# ������ԱȨ��
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
    exit
}

# ������Ҫ��ص���Ϸ�����������Ӧ����������
$processMap = @{
    "League of Legends.exe"               = "Ӣ������"
    "crossfire.exe"                       = "��Խ����"
    "VALORANT-Win64-Shipping.exe"         = "��η��Լ"
    "VALORANT.exe"                        = "��η��Լ"
    "cs2.exe"                             = "CSGO2"
    "Overwatch.exe"                       = "�����ȷ�"
    "UAgame.exe"                          = "����ͻΧ"
    "NieRAutomata.exe"                    = "�����޼�"
    "FragPunk.exe"                        = "�����"
    "TPS.exe"                             = "ǹ���"
    "DeltaForce-Win64-Shipping.exe"       = "������WeGame��"
    "DeltaForceClient-Win64-Shipping.exe" = "�����޹ٷ���"
}

# ��̬���� WMI ��ѯ����
$query = "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process' AND (" + 
         (($processMap.Keys | ForEach-Object { "TargetInstance.Name = '$_'" }) -join " OR ") + ")"

# ��ʼ���¼�������
$watcher = New-Object Management.ManagementEventWatcher -ArgumentList $query
$watcher.Start()

Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ���ڼ�����½���: $($processMap.Values -join ', ')" -ForegroundColor Green

while ($true) {
    try {
        $processEvent = $watcher.WaitForNextEvent()
        if (-not $processEvent -or -not $processEvent.TargetInstance) { continue }

        $startedProcessName = $processEvent.TargetInstance.Name
        if (-not $processMap.ContainsKey($startedProcessName)) { continue }

        Start-Sleep -Seconds 5  # �ȴ�������ȫ����

        $process = Get-Process -Name ($startedProcessName -replace '\.exe$') -ErrorAction SilentlyContinue
        if ($null -eq $process) {
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] δ�ҵ�����: $($processMap[$startedProcessName])" -ForegroundColor Yellow
            continue
        }

        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] �������������ȼ�: $($processMap[$startedProcessName])" -ForegroundColor Cyan

    }
    catch {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ����: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# ֹͣ����������Ctrl+C�˳�ʱ�Զ����ã�
Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
    $watcher.Stop()
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')] �����ֹͣ" -ForegroundColor Magenta
}