:: Game-Optimization-Script v2.2.0
:: Released: 2025-04-17
:: By ����@����ζ(119020212) ת����ע������

@echo off

:: ���ñ����ӳ���ʾ
setlocal enabledelayedexpansion

:: һ������TX���������ȼ�����
title һ������TX���������ȼ�����

:: ������ԱȨ��
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
echo    �U        һ������TX���������ȼ����� v2.2.0    �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0SetProcessPriority.ps1"
exit