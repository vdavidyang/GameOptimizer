@echo off
REM
 REM @Author: vdavidyang vdavidyang@gmail.com
 REM @Date: 2025-04-11 15:39:30
 REM @LastEditors: vdavidyang vdavidyang@gmail.com
 REM @LastEditTime: 2025-04-27 17:06:34
 REM @FilePath: \GameOptimizer\scripts\һ������TX���������ȼ�.bat
 REM @Description: 
 REM @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
REM


REM ���ñ����ӳ���ʾ
setlocal EnableDelayedExpansion

REM һ������TX���������ȼ�����
title һ������TX���������ȼ�����

REM ���ÿ���̨�������ΪGBK
chcp 936 >nul

REM ������ԱȨ�ޣ������ǰ�û����ǹ���Ա�����������ԱȨ��
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 (
    echo �������ԱȨ��...
    goto UACPrompt
) else ( goto gotAdmin )

REM �������ԱȨ��
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
echo    �U        һ������TX���������ȼ����� v2.3.2     �U
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

REM �Թ���ԱȨ������PowerShell�ű�
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0SetProcessPriority.ps1"

exit