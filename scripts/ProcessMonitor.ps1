# ������ԱȨ��
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
  Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Verb RunAs
  exit
}

# ���ȼ�����
# Idle: �������ȼ������ڵ����ȼ�����
# BelowNormal: �����������ȼ���������ͨ���ȼ�����
# Normal: �������ȼ������ڴ��������
# AboveNormal: �����������ȼ���������Ҫ������Ӧ�Ľ���
# High: �����ȼ������ڹؼ�����

# �������ȼ���Ӧ����������
$priorityMap = @{
  "Idle"        = "��"
  "BelowNormal" = "��������"
  "Normal"      = "����"
  "AboveNormal" = "��������"
  "High"        = "��"
}

# ������Ҫ��ص���Ϸ�����������Ӧ���������ƺ����ȼ�����
$gameProcessMap = @{
  "League of Legends.exe"               = @{ Priority = "High"; Name = "Ӣ������" }
  "crossfire.exe"                       = @{ Priority = "High"; Name = "��Խ����" }
  "VALORANT-Win64-Shipping.exe"         = @{ Priority = "High"; Name = "��η��Լ1" }
  "VALORANT.exe"                        = @{ Priority = "High"; Name = "��η��Լ2" }
  "cs2.exe"                             = @{ Priority = "High"; Name = "CSGO2" }
  "Overwatch.exe"                       = @{ Priority = "High"; Name = "�����ȷ�" }
  "UAgame.exe"                          = @{ Priority = "High"; Name = "����ͻΧ" }
  "NieRAutomata.exe"                    = @{ Priority = "High"; Name = "�����޼�" }
  "FragPunk.exe"                        = @{ Priority = "High"; Name = "�����" }
  "TPS.exe"                             = @{ Priority = "High"; Name = "ǹ���" }
  "DeltaForce-Win64-Shipping.exe"       = @{ Priority = "High"; Name = "������WeGame��" }
  "DeltaForceClient-Win64-Shipping.exe" = @{ Priority = "High"; Name = "�����޹ٷ���" }
}

# ���巴���׽��̼������ȼ����ú���������
$antiCheatProcessSettings = @{
  "SGuard.exe"      = @{ Priority = "Idle"; Name = "TX������-SGuard" }
  "SGuard64.exe"    = @{ Priority = "Idle"; Name = "TX������-SGuard64" }
  "SGuardSvc64.exe" = @{ Priority = "Idle"; Name = "TX������-SGuardSvc64" }
}

# ��ȡ CPU �߼�������
$cpuCount = (Get-CimInstance -ClassName Win32_Processor).NumberOfLogicalProcessors
$lastCoreMask = [IntPtr]::new([Int64]1 -shl ($cpuCount - 1))

# ��̬���� WMI ��ѯ�����������Ϸ���̺ͷ����׽��̣�
$query = "SELECT * FROM __InstanceCreationEvent WITHIN 5 WHERE TargetInstance ISA 'Win32_Process' AND (" + 
         (($gameProcessMap.Keys + $antiCheatProcessSettings.Keys | ForEach-Object { "TargetInstance.Name = '$_'" }) -join " OR ") + ")"

# ��ʼ���¼�������
$watcher = New-Object Management.ManagementEventWatcher -ArgumentList $query
$watcher.Start()

Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ���ڼ�����½���:"
Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ��Ϸ����: $($gameProcessMap.Values.Name -join ', ')" -ForegroundColor Green
Write-Host "[$(Get-Date -Format 'HH:mm:ss')] �����׽���: $($antiCheatProcessSettings.Values.Name -join ', ')" -ForegroundColor Yellow

while ($true) {
  try {
    $processEvent = $watcher.WaitForNextEvent()
    if (-not $processEvent -or -not $processEvent.TargetInstance) { continue }

    $startedProcessName = $processEvent.TargetInstance.Name
    Start-Sleep -Seconds 5  # �ȴ�������ȫ����

    # ����Ƿ�Ϊ��Ϸ����
    if ($gameProcessMap.ContainsKey($startedProcessName)) {
      $process = Get-Process -Name ($startedProcessName -replace '\.exe$') -ErrorAction SilentlyContinue
      if ($null -eq $process) {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] δ�ҵ���Ϸ����: $($gameProcessMap[$startedProcessName].Name)" -ForegroundColor Yellow
        continue
      }

      $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$($gameProcessMap[$startedProcessName].Priority)
      Write-Host "[$(Get-Date -Format 'HH:mm:ss')] ��������Ϸ����: $($gameProcessMap[$startedProcessName].Name) (���ȼ�=$($priorityMap[$gameProcessMap[$startedProcessName].Priority]))" -ForegroundColor Cyan
    }
    # ����Ƿ�Ϊ�����׽���
    elseif ($antiCheatProcessSettings.ContainsKey($startedProcessName)) {
      $process = Get-Process -Name $startedProcessName -ErrorAction SilentlyContinue
      if ($null -eq $process) {
        Write-Host "[$(Get-Date -Format 'HH:mm:ss')] δ�ҵ������׽���: $($antiCheatProcessSettings[$startedProcessName].Name)" -ForegroundColor Yellow
        continue
      }

      $priority = $antiCheatProcessSettings[$startedProcessName].Priority
      $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$priority
      $process.ProcessorAffinity = $lastCoreMask

      Write-Host "[$(Get-Date -Format 'HH:mm:ss')] �����÷����׽���: $($antiCheatProcessSettings[$startedProcessName].Name) (���ȼ�=$($priorityMap[$antiCheatProcessSettings[$startedProcessName].Priority]), CPU����ԣ����һ������)" -ForegroundColor Green
    }
  }
  catch [System.Management.Automation.PipelineStoppedException] {
    # ����Ctrl+C�ж��ź�
    Write-Host "`n[$(Get-Date -Format 'HH:mm:ss')] ����ֹͣ���..." -ForegroundColor Magenta
    break
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
