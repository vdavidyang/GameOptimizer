@echo off
REM
 REM @Author: vdavidyang vdavidyang@gmail.com
 REM @Date: 2025-04-11 15:39:30
 REM @LastEditors: vdavidyang vdavidyang@gmail.com
 REM @LastEditTime: 2025-04-27 17:07:15
 REM @FilePath: \GameOptimizer\scripts\һ���½���ݷ�ʽ.bat
 REM @Description: 
 REM @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
REM


setlocal EnableDelayedExpansion

REM һ���½���ݷ�ʽ
title һ���½���ݷ�ʽ

:: ���ÿ���̨�������ΪGBK
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

REM ������ԱȨ��
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
echo    �U            һ���½���ݷ�ʽ v2.3.2           �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

:: ʹ�õ�ǰ�ű�����Ŀ¼��Ϊ����Ŀ¼
cd /d "%~dp0"

set "batfile=һ������TX���������ȼ�.bat"
set "lnkname=һ������TX���������ȼ�.lnk"

:: ���Դ�ļ��Ƿ����
if not exist "%batfile%" (
    echo ���󣺵�ǰĿ¼��δ�ҵ� "%batfile%"
    pause
    exit /b 1
)

:: ʹ�� PowerShell ������ݷ�ʽ
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U           ���ڴ��������ݷ�ʽ...            �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

set "ps_create=$desktop = [Environment]::GetFolderPath('Desktop');"
set "ps_create=%ps_create% $lnkPath = Join-Path $desktop '%lnkname%';"
set "ps_create=%ps_create% $target = Join-Path ([System.Environment]::CurrentDirectory) '%batfile%';"
set "ps_create=%ps_create% $WshShell = New-Object -ComObject WScript.Shell;"
set "ps_create=%ps_create% $shortcut = $WshShell.CreateShortcut($lnkPath);"
set "ps_create=%ps_create% $shortcut.TargetPath = $target;"
set "ps_create=%ps_create% $shortcut.WorkingDirectory = [System.Environment]::CurrentDirectory;"
set "ps_create=%ps_create% $shortcut.Save();"

powershell -Command "%ps_create%"

:: ����ݷ�ʽ�Ƿ񴴽��ɹ�
if not exist "%USERPROFILE%\Desktop\%lnkname%" (
    echo.
    echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
    echo    �U                                              �U
    echo    �U      ���󣺿�ݷ�ʽ����ʧ�ܣ�����Ȩ��       �U
    echo    �U                                              �U
    echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
    echo.
    pause
    exit /b 1
)

:: �޸Ŀ�ݷ�ʽ�Թ���ԱȨ������
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U            �������ù���ԱȨ��...             �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

set "ps_admin=$desktop = [Environment]::GetFolderPath('Desktop');"
set "ps_admin=%ps_admin% $lnk = Join-Path $desktop '%lnkname%';"
set "ps_admin=%ps_admin% $bytes = [System.IO.File]::ReadAllBytes($lnk);"
set "ps_admin=%ps_admin% $bytes[0x15] = $bytes[0x15] -bor 0x20;"
set "ps_admin=%ps_admin% [System.IO.File]::WriteAllBytes($lnk, $bytes);"

powershell -Command "%ps_admin%"

echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U ������ɣ��Ѵ��������ݷ�ʽ�����ù���ԱȨ�� �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

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

pause
exit /b