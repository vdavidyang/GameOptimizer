@echo off
REM
 REM @Author: vdavidyang vdavidyang@gmail.com
 REM @Date: 2025-04-11 15:39:30
 REM @LastEditors: vdavidyang vdavidyang@gmail.com
 REM @LastEditTime: 2025-04-27 17:06:34
 REM @FilePath: \GameOptimizer\scripts\一键设置TX反作弊优先级.bat
 REM @Description: 
 REM @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
REM


REM 设置变量延迟显示
setlocal EnableDelayedExpansion

REM 一键设置TX反作弊优先级工具
title 一键设置TX反作弊优先级工具

REM 设置控制台输出编码为GBK
chcp 936 >nul

REM 检查管理员权限，如果当前用户不是管理员，则请求管理员权限
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 (
    echo 请求管理员权限...
    goto UACPrompt
) else ( goto gotAdmin )

REM 请求管理员权限
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /b

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
cd /d "%~dp0"

REM 检查管理员权限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo    ╔══════════════════════════════════════════════╗
    echo    ║                                              ║
    echo    ║        请右键"以管理员身份运行"此脚本！       ║
    echo    ║                                              ║
    echo    ╚══════════════════════════════════════════════╝
    echo.
    pause
    exit /b
)

REM 打印标题
echo.
echo    ╔══════════════════════════════════════════════╗
echo    ║                                              ║
echo    ║        一键设置TX反作弊优先级工具 v2.3.2     ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

echo.
echo    ╔══════════════════════════════════════════════╗
echo    ║                                              ║
echo    ║  By 抖音@鱼腥味(119020212) 转载请注明出处    ║
echo    ║                                              ║
echo    ║  有需要鞋子的兄弟添加微信：Mrmuscle12138     ║
echo    ║  大学生赚点生活费，主播自己也是买了很多年了  ║
echo    ║  这是泉州的老板，无论是质量还是价格都是杠杠的║
echo    ║  售后也好，支持7天无理由，质量问题包退换     ║
echo    ║                                              ║
echo    ║             本脚本完全免费                   ║
echo    ║     如果你是收费购买请联系卖家退款！！！     ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

REM 以管理员权限运行PowerShell脚本
PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0SetProcessPriority.ps1"

exit