# Game-Optimization-Script v2.1.1
# Released: 2025-04-11
# By ����@����ζ(119020212) ת����ע������

# ������ԱȨ��
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "���Ҽ��Թ���Ա������д˽ű���" -ForegroundColor Red
    pause
    exit
}

# ���ý������ƺ����ȼ��Ĺ�ϣ��
# ���÷����׽��̵����ȼ�Ϊ��
$processSettings = @{
    "SGuard.exe"  = "Idle"
    "SGuard64"    = "Idle"
    "SGuardSvc64" = "Idle"
}

# ��ȡ CPU �߼���������
$cpuCount = (Get-WmiObject -Class Win32_Processor).NumberOfLogicalProcessors

# �������һ�����ĵı��
# Date:2025��4��10��19:36:16
# ��С��鷴���޷���ȷ��ȡ�������������ֵ�CPU�߳���̫��ʱ�����ڵ���32��
# lastCoreAffinity����������� ֵΪ-2147483648 Ϊ���޸ļ��㷽ʽ
# $lastCoreAffinity = [IntPtr](1 -shl ($cpuCount - 1))

# ��������ʱʹ�� [Int64] ���� �������Լ���32/64 λϵͳ
$lastCoreAffinity = [IntPtr]([Int64]1 -shl ($cpuCount - 1))

foreach ($processName in $processSettings.Keys) {
    # ��ȡ����
    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue

    if ($null -ne $process) {
        # ��ȡ��ǰ���̵����ȼ�����
        $priority = $processSettings[$processName]

        # �������ȼ�
        $process.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::$priority

        # ��������ԣ������̰󶨵����һ�� CPU ����
        $process.ProcessorAffinity = $lastCoreAffinity
        
        Write-Host "�����ý��� '$processName' �����ȼ�Ϊ�ͣ�������Ѱ󶨵� CPU ���һ�����ġ�"
    }
    else {
        Write-Host "δ�ҵ����� '$processName'��"
    }
}

Write-Host By ����@����ζ(119020212) ת����ע������
Write-Host ���ű���ȫ��ѣ���������շѹ�������ϵ�����˿����

# �ȴ�5������
Write-Host "������Զ��˳�..."
Start-Sleep -Seconds 5

exit