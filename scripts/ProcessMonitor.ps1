# 检查管理员权限
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
  exit
}

# 优先级解释
# Idle: 空闲优先级，用于低优先级进程
# BelowNormal: 低于正常优先级，用于普通优先级进程
# Normal: 正常优先级，用于大多数进程
# AboveNormal: 高于正常优先级，用于需要快速响应的进程
# High: 高优先级，用于关键进程

# 定义优先级对应的中文名称
$priorityMap = @{
  "Idle"        = "低"
  "BelowNormal" = "低于正常"
  "Normal"      = "正常"
  "AboveNormal" = "高于正常"
  "High"        = "高"
}

# 定义需要监控的游戏进程名及其对应的中文名称和优先级设置
$gameProcessMap = @{
  "League of Legends.exe"               = @{ Priority = "High"; Name = "英雄联盟" }
  "crossfire.exe"                       = @{ Priority = "High"; Name = "穿越火线" }
  "VALORANT-Win64-Shipping.exe"         = @{ Priority = "High"; Name = "无畏契约1" }
  "VALORANT.exe"                        = @{ Priority = "High"; Name = "无畏契约2" }
  "cs2.exe"                             = @{ Priority = "High"; Name = "CSGO2" }
  "Overwatch.exe"                       = @{ Priority = "High"; Name = "守望先锋" }
  "UAgame.exe"                          = @{ Priority = "High"; Name = "暗区突围" }
  "NieRAutomata.exe"                    = @{ Priority = "High"; Name = "永劫无间" }
  "FragPunk.exe"                        = @{ Priority = "High"; Name = "界外狂潮" }
  "TPS.exe"                             = @{ Priority = "High"; Name = "枪神纪" }
  "DeltaForce-Win64-Shipping.exe"       = @{ Priority = "High"; Name = "三角洲WeGame版" }
  "DeltaForceClient-Win64-Shipping.exe" = @{ Priority = "High"; Name = "三角洲官方版" }
}

# 定义反作弊进程及其优先级设置和中文名称
$antiCheatProcessSettings = @{
  "SGuard.exe"      = @{ Priority = "Idle"; Name = "TX反作弊-SGuard" }
  "SGuard64.exe"    = @{ Priority = "Idle"; Name = "TX反作弊-SGuard64" }
  "SGuardSvc64.exe" = @{ Priority = "Idle"; Name = "TX反作弊-SGuardSvc64" }
}

# 获取 CPU 逻辑核心数
$cpuCount = (Get-CimInstance -ClassName Win32_Processor).NumberOfLogicalProcessors
$lastCoreMask = [IntPtr]::new([Int64]1 -shl ($cpuCount - 1))

# 动态生成 WMI 查询条件（监控游戏进程和反作弊进程）
$query = "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process' AND (" + 
         (($gameProcessMap.Keys + $antiCheatProcessSettings.Keys | ForEach-Object { "TargetInstance.Name = '$_'" }) -join " OR ") + ")"

# 初始化事件监视器
$watcher = New-Object Management.ManagementEventWatcher -ArgumentList $query
$watcher.Start()

Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 正在监控以下进程:"
Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 游戏进程: $($gameProcessMap.Values.Name -join ', ')" -ForegroundColor Green
Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 反作弊进程: $($antiCheatProcessSettings.Values.Name -join ', ')" -ForegroundColor Yellow

while ($true) {
  try {
    $processEvent = $watcher.WaitForNextEvent()
    if (-not $processEvent -or -not $processEvent.TargetInstance) { continue }

    $startedProcessName = $processEvent.TargetInstance.Name
    Start-Sleep -Seconds 5  # 等待进程完全启动

    # 检查是否为游戏进程
    if ($gameProcessMap.ContainsKey($startedProcessName)) {
      $process = Get-Process -Name ($startedProcessName -replace '\.exe$') -ErrorAction SilentlyContinue
      if ($null -eq $process) {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 未找到游戏进程: $($gameProcessMap[$startedProcessName].Name)" -ForegroundColor Yellow
        continue
      }

      $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$($gameProcessMap[$startedProcessName].Priority)
      Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 已设置游戏进程: $($gameProcessMap[$startedProcessName].Name) (优先级=$($priorityMap[$gameProcessMap[$startedProcessName].Priority]))" -ForegroundColor Cyan
    }
    # 检查是否为反作弊进程
    elseif ($antiCheatProcessSettings.ContainsKey($startedProcessName)) {
      $process = Get-Process -Name $startedProcessName -ErrorAction SilentlyContinue
      if ($null -eq $process) {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 未找到反作弊进程: $($antiCheatProcessSettings[$startedProcessName].Name)" -ForegroundColor Yellow
        continue
      }

      $priority = $antiCheatProcessSettings[$startedProcessName].Priority
      $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$priority
      $process.ProcessorAffinity = $lastCoreMask

      Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 已设置反作弊进程: $($antiCheatProcessSettings[$startedProcessName].Name) (优先级=$($priorityMap[$antiCheatProcessSettings[$startedProcessName].Priority]), CPU相关性：最后一个核心)" -ForegroundColor Green
    }
  }
  catch [System.Management.Automation.PipelineStoppedException] {
    # 捕获Ctrl+C中断信号
    Write-Host "`n[$(Get-Date -Format 'HH:mm:ss')] 正在停止监控..." -ForegroundColor Magenta
    break
  }

  catch {
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 错误: $($_.Exception.Message)" -ForegroundColor Red
  }
}

# 停止监视器（按Ctrl+C退出时自动调用）
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
  $watcher.Stop()
  Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 监控已停止" -ForegroundColor Magenta
}
