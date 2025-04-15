:: Game-Optimization-Script v2.1.1
:: Released: 2025-04-11
:: By ����@����ζ(119020212) ת����ע������

@echo off

:: ���ñ����ӳ���ʾ
setlocal enabledelayedexpansion

:: ����
title ��Ϸ�������ȼ��Ż�����

:: �����к�����
:: mode con: cols=80 lines=60

:: ��ɫ����ɫ
:: color 0A

:: ����Ƿ��Թ���Ա�������
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
    echo    �U                                              �U
    echo    �U        ���Ҽ�"�Թ���Ա�������"�˽ű���       �U
    echo    �U                                              �U
    echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
    echo.
    pause
    exit /b
)

:: ��ӡ����
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U        ��Ϸ�������ȼ��Ż����� v2.1           �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

:: CPU���ȼ�
:: ʮ���� ����
::   1   Idle (��)
::   2   Normal (����)
::   3   High (��)
::   4   Realtime (ʵʱ)
::   5   Below Normal (��������)
::   6   Above Normal (��������)

:: I/O���ȼ�
:: ʮ���� ����
::   0   Very Low (����)
::   1   Low (��)
::   2   Normal (����)
::   3   High (��)

:: ���÷����׽��� SGuard.exe �� SGuard64.exe CPU���ȼ���I/O���ȼ�
:: ���� SGuard.exe �� CPU=1 (��), IO=0 (����)
call :SetPriority "TX�����׽���-SGuard" "SGuard.exe" 1 0

:: ���� SGuard64.exe �� CPU=1 (��), IO=0 (����)
call :SetPriority "TX�����׽���-SGuard64" "SGuard64.exe" 1 0

:: ���� SGuardSvc64.exe �� CPU=1 (��), IO=0 (����)
call :SetPriority "TX�����׽���-SGuardSvc64" "SGuardSvc64.exe" 1 0


:: ������Ϸ�������ȼ�
:: ��LOLΪ�� ������Ϊ"League of Legends.exe"
:: ������Ϸ�����滻��������е�"League of Legends.exe"����
:: ��TX��ϷҲ�������� ���ʻ���������ϵͳ����Ϸ����Ӧ���ȼ�

:: ���� Ӣ������-League of Legends.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "Ӣ������" "League of Legends.exe" 3 3

:: ���� ��Խ����-crossfire.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "��Խ����" "crossfire.exe" 3 3

:: ���� ��η��Լ-VALORANT-Win64-Shipping.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "��η��Լ1" "VALORANT-Win64-Shipping.exe" 3 3
:: ���� ��η��Լ-VALORANT.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "��η��Լ2" "VALORANT.exe" 3 3

:: ���� ������-DeltaForce-Win64-Shipping.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "������WeGame��" "DeltaForce-Win64-Shipping.exe" 3 3
:: ���� ������-DeltaForceClient-Win64-Shipping.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "�����޹ٷ���" "DeltaForceClient-Win64-Shipping.exe" 3 3

:: ���� ǹ���-TPS.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "ǹ���" "TPS.exe" 3 3

:: ���� �����-FragPunk.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "�����" "FragPunk.exe" 3 3

:: ���� �����ȷ�-Overwatch.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "�����ȷ�" "Overwatch.exe" 3 3

:: ���� CSGO2-cs2.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "CSGO2" "cs2.exe" 3 3

:: ���� ����ͻΧ-UAgame.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "����ͻΧ" "UAgame.exe" 3 3

:: ���� �����޼�-NarakaBladepoint.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "�����޼�" "NarakaBladepoint.exe" 3 3

:: ��������Ϸֱ�Ӹ���ճ���Ϸ����벢�滻���Ƽ���
:: �� call :SetPriority "XXX.exe" X X "��Ϸ����"

:: �����ʾ
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U         ���н������ȼ����������             �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

:: �Զ�������ݷ�ʽ�����ù���ԱȨ��
:choice
set /p choice=�Ƿ��Զ�����һ������TX���������ȼ���ݷ�ʽ��(Y-��/N-��, Ĭ��Y):
if "!choice!"=="" set choice=y

if /i "!choice!"=="y" (
    call "%~dp0һ���½���ݷ�ʽ.bat"
) else if /i "!choice!"=="n" (
    echo.
    echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
    echo    �U                                              �U
    echo    �U           �������������ݷ�ʽ...            �U
    echo    �U                                              �U
    echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
    echo.
) else (
    echo ������Ч������������
    goto choice
)

echo.
echo By ����@����ζ(119020212) ת����ע������
echo ���ű���ȫ��ѣ���������շѹ�������ϵ�����˿����
echo.

pause
exit /b


:: �������ȼ�����
:SetPriority
setlocal
set "game=%~1"
set "process=%~2"
set "cpuPriority=%~3"
set "ioPriority=%~4"

:: ת��CPU���ȼ�Ϊ����
if "%cpuPriority%"=="1" set "cpuText=��"
if "%cpuPriority%"=="2" set "cpuText=����"
if "%cpuPriority%"=="3" set "cpuText=��"
if "%cpuPriority%"=="4" set "cpuText=ʵʱ"
if "%cpuPriority%"=="5" set "cpuText=��������"
if "%cpuPriority%"=="6" set "cpuText=��������"

:: ת��I/O���ȼ�Ϊ����
if "%ioPriority%"=="0" set "ioText=����"
if "%ioPriority%"=="1" set "ioText=��"
if "%ioPriority%"=="2" set "ioText=����"
if "%ioPriority%"=="3" set "ioText=��"

:: ���������ʽ
if not "%game%"=="" (
    echo    ������������������������������������������������������������������������������������������������
    echo    ��  ��Ϸ����: %game%
    echo    ��  ��������: %process%
    echo    ��  CPU���ȼ�: %cpuText%
    echo    ��  I/O���ȼ�: %ioText%
    echo    ������������������������������������������������������������������������������������������������
) else (
    echo    ������������������������������������������������������������������������������������������������
    echo    ��  ��������: %process%
    echo    ��  CPU���ȼ�: %cpuText%
    echo    ��  I/O���ȼ�: %ioText%
    echo    ������������������������������������������������������������������������������������������������
)


reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process%" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process%\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d %cpuPriority% /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process%\PerfOptions" /v "IoPriority" /t REG_DWORD /d %ioPriority% /f >nul
endlocal
goto :eof