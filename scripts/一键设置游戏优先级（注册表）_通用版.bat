@echo off
REM
 REM @Author: vdavidyang vdavidyang@gmail.com
 REM @Date: 2025-04-11 18:03:27
 REM @LastEditors: vdavidyang vdavidyang@gmail.com
 REM @LastEditTime: 2025-04-27 17:06:19
 REM @FilePath: \GameOptimizer\scripts\һ��������Ϸ���ȼ���ע���_ͨ�ð�.bat
 REM @Description: 
 REM @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
REM

REM ���ñ����ӳ���ʾ
setlocal EnableDelayedExpansion

REM ����
title ��Ϸ�������ȼ��Ż�����

REM �����к�����
REM mode con: cols=80 lines=60

REM ��ɫ����ɫ
REM color 0A

REM ���ÿ���̨�������ΪGBK
chcp 936 >nul

REM ������ԱȨ�ޣ������ǰ�û����ǹ���Ա�����������ԱȨ��
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 (
    echo �������ԱȨ��...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /b

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
cd /d "%~dp0"

REM ����Ƿ��Թ���Ա�������
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

REM ��ӡ����
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U        ��Ϸ�������ȼ��Ż����� v2.3.2         �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

REM CPU���ȼ�
REM ʮ���� ����
REM   1   Idle (��)
REM   2   Normal (����)
REM   3   High (��)
REM   4   Realtime (ʵʱ)
REM   5   Below Normal (��������)
REM   6   Above Normal (��������)

REM I/O���ȼ�
REM ʮ���� ����
REM   0   Very Low (����)
REM   1   Low (��)
REM   2   Normal (����)
REM   3   High (��)

REM ���÷����׽��� SGuard.exe �� SGuard64.exe CPU���ȼ���I/O���ȼ�
REM ���� SGuard.exe �� CPU=1 (��), IO=0 (����)
call :SetPriority "TX�����׽���-SGuard" "SGuard.exe" 1 0

REM ���� SGuard64.exe �� CPU=1 (��), IO=0 (����)
call :SetPriority "TX�����׽���-SGuard64" "SGuard64.exe" 1 0

REM ���� SGuardSvc64.exe �� CPU=1 (��), IO=0 (����)
call :SetPriority "TX�����׽���-SGuardSvc64" "SGuardSvc64.exe" 1 0


REM ������Ϸ�������ȼ�
REM ��LOLΪ�� ������Ϊ"League of Legends.exe"
REM ������Ϸ�����滻��������е�"League of Legends.exe"����
REM ��TX��ϷҲ�������� ���ʻ���������ϵͳ����Ϸ����Ӧ���ȼ�

REM ���� Ӣ������-League of Legends.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "Ӣ������" "League of Legends.exe" 3 3

REM ���� ��Խ����-crossfire.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "��Խ����" "crossfire.exe" 3 3

REM ���� ��η��Լ-VALORANT-Win64-Shipping.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "��η��Լ1" "VALORANT-Win64-Shipping.exe" 3 3
REM ���� ��η��Լ-VALORANT.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "��η��Լ2" "VALORANT.exe" 3 3

REM ���� ������-DeltaForce-Win64-Shipping.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "������WeGame��" "DeltaForce-Win64-Shipping.exe" 3 3
REM ���� ������-DeltaForceClient-Win64-Shipping.exe �� CPU=3 (��), IO=3 (��)
call :SetPriority "�����޹ٷ���" "DeltaForceClient-Win64-Shipping.exe" 3 3

REM ���� ǹ���-TPS.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "ǹ���" "TPS.exe" 3 3

REM ���� �����-FragPunk.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "�����" "FragPunk.exe" 3 3

REM ���� �����ȷ�-Overwatch.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "�����ȷ�" "Overwatch.exe" 3 3

REM ���� CSGO2-cs2.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "CSGO2" "cs2.exe" 3 3

REM ���� ����ͻΧ-UAgame.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "����ͻΧ" "UAgame.exe" 3 3

REM ���� �����޼�-NarakaBladepoint.exe�� CPU=3 (��), IO=3 (��)
call :SetPriority "�����޼�" "NarakaBladepoint.exe" 3 3

REM ��������Ϸֱ�Ӹ���ճ���Ϸ�����Ȼ���滻���Ƽ���
REM �� call :SetPriority "XXX.exe" X X "��Ϸ����"

REM �����ʾ
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U         ���н������ȼ����������             �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

REM �Զ�������ݷ�ʽ�����ù���ԱȨ��
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

goto :Endecho

pause
exit /b

:Endecho
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U  By ����@����ζ(119020212) ת����ע������    �U
echo    �U                                              �U
echo    �U  ����ҪЬ�ӵ��ֵ����΢�ţ�Mrmuscle12138     �U
echo    �U  ��ѧ��׬������ѣ������Լ�Ҳ�����˺ܶ�����  �U
echo    �U  ����Ȫ�ݵ��ϰ壬�������������Ǽ۸��ǸܸܵĨU
echo    �U  �ۺ�Ҳ�ã�֧��7�������ɣ�����������˻�     �U
echo    �U                                              �U
echo    �U             ���ű���ȫ���                   �U
echo    �U     ��������շѹ�������ϵ�����˿����     �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

REM �������ȼ�����
:SetPriority
setlocal
set "game=%~1"
set "process=%~2"
set "cpuPriority=%~3"
set "ioPriority=%~4"

REM ת��CPU���ȼ�Ϊ����
if "%cpuPriority%"=="1" set "cpuText=��"
if "%cpuPriority%"=="2" set "cpuText=����"
if "%cpuPriority%"=="3" set "cpuText=��"
if "%cpuPriority%"=="4" set "cpuText=ʵʱ"
if "%cpuPriority%"=="5" set "cpuText=��������"
if "%cpuPriority%"=="6" set "cpuText=��������"

REM ת��I/O���ȼ�Ϊ����
if "%ioPriority%"=="0" set "ioText=����"
if "%ioPriority%"=="1" set "ioText=��"
if "%ioPriority%"=="2" set "ioText=����"
if "%ioPriority%"=="3" set "ioText=��"

REM ���������ʽ
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