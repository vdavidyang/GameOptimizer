<#
 # @Author: vdavidyang vdavidyang@gmail.com
 # @Date: 2025-04-11 15:39:30
 # @LastEditors: vdavidyang vdavidyang@gmail.com
 # @LastEditTime: 2025-04-27 17:11:55
 # @FilePath: \GameOptimizer\scripts\SetProcessPriority.ps1
 # @Description: 
 # @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
#>


# ������ԱȨ��
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "���Ҽ��Թ���Ա������д˽ű���" -ForegroundColor Red
    pause
    exit
}


<#
# ���ȼ�����
# Idle: �������ȼ������ڵ����ȼ�����
# BelowNormal: �����������ȼ���������ͨ���ȼ�����
# Normal: �������ȼ������ڴ��������
# AboveNormal: �����������ȼ���������Ҫ������Ӧ�Ľ���
# High: �����ȼ������ڹؼ�����
#>


# �������ȼ���Ӧ����������
$priorityMap = @{
    "Idle"        = "��"
    "BelowNormal" = "��������"
    "Normal"      = "����"
    "AboveNormal" = "��������"
    "High"        = "��"
}

# ���巴���׽��̼������ȼ����ú���������
$antiCheatProcessSettings = @{
    "SGuard"      = @{ Priority = "Idle"; Name = "TX������-SGuard" }
    "SGuard64"    = @{ Priority = "Idle"; Name = "TX������-SGuard64" }
    "SGuardSvc64" = @{ Priority = "Idle"; Name = "TX������-SGuardSvc64" }
}

# ʹ�ø��ִ���CIM�������WMI
$cpuCount = (Get-CimInstance -ClassName Win32_Processor).NumberOfLogicalProcessors
$lastCoreMask = [IntPtr]::new([Int64]1 -shl ($cpuCount - 1))

# ��װ�������
function Write-Status {
    param (
        [string]$message,
        [string]$color = "White"
    )
    Write-Host $message -ForegroundColor $color
}

foreach ($processName in $antiCheatProcessSettings.Keys) {
    try {
        # ��ȡ����ͬ������ʵ��
        $processes = Get-Process -Name $processName -ErrorAction Stop
        
        foreach ($process in $processes) {
            try {
                $priority = $antiCheatProcessSettings[$processName].Priority
                $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$priority
                $process.ProcessorAffinity = $lastCoreMask
                
                Write-Status "[�ɹ�] $($process.Name) (PID:$($process.Id)): ���ȼ�=$($priorityMap[$priority]), CPU����ԣ����һ������" -color "Green"
            }
            catch {
                Write-Status "[����] ���ý��� $($process.Name) ʧ��: $_" -color "Red"
            }
        }
    }
    catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
        Write-Status "[����] δ�ҵ�����: $processName" -color "Yellow"
    }
    catch {
        Write-Status "[����] ������� $processName ʱ����δ֪����: $_" -color "Red"
    }
}

# Write-Status "By ����@����ζ(119020212) ת����ע������"
# Write-Status "���ű���ȫ��ѣ���������շѹ�������ϵ�����˿����"

# ��װ����ʱ����
function Start-Countdown {
    param (
        [int]$seconds = 5
    )
    Write-Status "`n������ɣ����ڽ��� $seconds ���ر�..." -color "Cyan"
    for ($i = $seconds; $i -gt 0; $i--) {
        Write-Host "ʣ��ʱ��: $i ��" -NoNewline
        Start-Sleep -Seconds 1
        Write-Host "`r" -NoNewline
    }
}

Start-Countdown -seconds 5
# exit