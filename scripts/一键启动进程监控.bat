:: Game-Optimization-Script v2.1.1
:: Released: 2025-04-12
:: By ����@����ζ(119020212) ת����ע������

@echo off

:: ���ñ����ӳ���ʾ
setlocal enabledelayedexpansion

:: һ���������̼�ع���
title һ���������̼�ع���

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
echo    �U           һ���������̼�ع��� v2.1          �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0ProcessMonitor.ps1"
exit /b