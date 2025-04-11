# Game-Optimization-Script v2.1.1
# Released: 2025-04-11
# By 抖音@鱼腥味(119020212) 转载请注明出处

# 检查管理员权限
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "请右键以管理员身份运行此脚本！" -ForegroundColor Red
    pause
    exit
}

# 设置进程名称和优先级的哈希表
# 设置反作弊进程的优先级为低
$processSettings = @{
    "SGuard.exe"  = "Idle"
    "SGuard64"    = "Idle"
    "SGuardSvc64" = "Idle"
}

# 获取 CPU 逻辑核心数量
$cpuCount = (Get-WmiObject -Class Win32_Processor).NumberOfLogicalProcessors

# 计算最后一个核心的编号
# Date:2025年4月10日19:36:16
# 有小伙伴反馈无法正确获取核心数，检查后发现当CPU线程数太多时（大于等于32）
# lastCoreAffinity会出现溢出情况 值为-2147483648 为此修改计算方式
# $lastCoreAffinity = [IntPtr](1 -shl ($cpuCount - 1))

# 计算掩码时使用 [Int64] 计算 这样可以兼容32/64 位系统
$lastCoreAffinity = [IntPtr]([Int64]1 -shl ($cpuCount - 1))

foreach ($processName in $processSettings.Keys) {
    # 获取进程
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue

    if ($null -ne $process) {
        # 获取当前进程的优先级设置
        $priority = $processSettings[$processName]

        # 设置优先级
        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$priority

        # 设置相关性，将进程绑定到最后一个 CPU 核心
        $process.ProcessorAffinity = $lastCoreAffinity
        
        Write-Host "已设置进程 '$processName' 的优先级为低，相关性已绑定到 CPU 最后一个核心。"
    }
    else {
        Write-Host "未找到进程 '$processName'。"
    }
}

Write-Host By 抖音@鱼腥味(119020212) 转载请注明出处
Write-Host 本脚本完全免费，如果你是收费购买请联系卖家退款！！！

# 等待5秒后结束
Write-Host "五秒后自动退出..."
Start-Sleep -Seconds 5

exit