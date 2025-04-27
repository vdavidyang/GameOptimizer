<#
 # @Author: vdavidyang vdavidyang@gmail.com
 # @Date: 2025-04-11 15:39:30
 # @LastEditors: vdavidyang vdavidyang@gmail.com
 # @LastEditTime: 2025-04-27 17:11:55
 # @FilePath: \GameOptimizer\scripts\SetProcessPriority.ps1
 # @Description: 
 # @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
#>


# 检查管理员权限
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "请右键以管理员身份运行此脚本！" -ForegroundColor Red
    pause
    exit
}


<#
# 优先级解释
# Idle: 空闲优先级，用于低优先级进程
# BelowNormal: 低于正常优先级，用于普通优先级进程
# Normal: 正常优先级，用于大多数进程
# AboveNormal: 高于正常优先级，用于需要快速响应的进程
# High: 高优先级，用于关键进程
#>


# 定义优先级对应的中文名称
$priorityMap = @{
    "Idle"        = "低"
    "BelowNormal" = "低于正常"
    "Normal"      = "正常"
    "AboveNormal" = "高于正常"
    "High"        = "高"
}

# 定义反作弊进程及其优先级设置和中文名称
$antiCheatProcessSettings = @{
    "SGuard"      = @{ Priority = "Idle"; Name = "TX反作弊-SGuard" }
    "SGuard64"    = @{ Priority = "Idle"; Name = "TX反作弊-SGuard64" }
    "SGuardSvc64" = @{ Priority = "Idle"; Name = "TX反作弊-SGuardSvc64" }
}

# 使用更现代的CIM命令替代WMI
$cpuCount = (Get-CimInstance -ClassName Win32_Processor).NumberOfLogicalProcessors
$lastCoreMask = [IntPtr]::new([Int64]1 -shl ($cpuCount - 1))

# 封装输出函数
function Write-Status {
    param (
        [string]$message,
        [string]$color = "White"
    )
    Write-Host $message -ForegroundColor $color
}

foreach ($processName in $antiCheatProcessSettings.Keys) {
    try {
        # 获取所有同名进程实例
        $processes = Get-Process -Name $processName -ErrorAction Stop
        
        foreach ($process in $processes) {
            try {
                $priority = $antiCheatProcessSettings[$processName].Priority
                $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$priority
                $process.ProcessorAffinity = $lastCoreMask
                
                Write-Status "[成功] $($process.Name) (PID:$($process.Id)): 优先级=$($priorityMap[$priority]), CPU相关性：最后一个核心" -color "Green"
            }
            catch {
                Write-Status "[错误] 设置进程 $($process.Name) 失败: $_" -color "Red"
            }
        }
    }
    catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
        Write-Status "[警告] 未找到进程: $processName" -color "Yellow"
    }
    catch {
        Write-Status "[错误] 处理进程 $processName 时发生未知错误: $_" -color "Red"
    }
}

# Write-Status "By 抖音@鱼腥味(119020212) 转载请注明出处"
# Write-Status "本脚本完全免费，如果你是收费购买请联系卖家退款！！！"

# 封装倒计时函数
function Start-Countdown {
    param (
        [int]$seconds = 5
    )
    Write-Status "`n操作完成，窗口将在 $seconds 秒后关闭..." -color "Cyan"
    for ($i = $seconds; $i -gt 0; $i--) {
        Write-Host "剩余时间: $i 秒" -NoNewline
        Start-Sleep -Seconds 1
        Write-Host "`r" -NoNewline
    }
}

Start-Countdown -seconds 5
# exit