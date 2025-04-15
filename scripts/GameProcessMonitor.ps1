# 检查管理员权限
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# 定义需要监控的游戏进程名及其对应的中文名称
$processMap = @{
    "League of Legends.exe"               = "英雄联盟"
    "crossfire.exe"                       = "穿越火线"
    "VALORANT-Win64-Shipping.exe"         = "无畏契约"
    "VALORANT.exe"                        = "无畏契约"
    "cs2.exe"                             = "CSGO2"
    "Overwatch.exe"                       = "守望先锋"
    "UAgame.exe"                          = "暗区突围"
    "NieRAutomata.exe"                    = "永劫无间"
    "FragPunk.exe"                        = "界外狂潮"
    "TPS.exe"                             = "枪神纪"
    "DeltaForce-Win64-Shipping.exe"       = "三角洲WeGame版"
    "DeltaForceClient-Win64-Shipping.exe" = "三角洲官方版"
}

# 动态生成 WMI 查询条件
$query = "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process' AND (" + 
         (($processMap.Keys | ForEach-Object { "TargetInstance.Name = '$_'" }) -join " OR ") + ")"

# 初始化事件监视器
$watcher = New-Object Management.ManagementEventWatcher -ArgumentList $query
$watcher.Start()

Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 正在监控以下进程: $($processMap.Values -join ', ')" -ForegroundColor Green

while ($true) {
    try {
        $processEvent = $watcher.WaitForNextEvent()
        if (-not $processEvent -or -not $processEvent.TargetInstance) { continue }

        $startedProcessName = $processEvent.TargetInstance.Name
        if (-not $processMap.ContainsKey($startedProcessName)) { continue }

        Start-Sleep -Seconds 5  # 等待进程完全启动

        $process = Get-Process -Name ($startedProcessName -replace '\.exe$') -ErrorAction SilentlyContinue
        if ($null -eq $process) {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 未找到进程: $($processMap[$startedProcessName])" -ForegroundColor Yellow
            continue
        }

        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] 已提升进程优先级: $($processMap[$startedProcessName])" -ForegroundColor Cyan

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