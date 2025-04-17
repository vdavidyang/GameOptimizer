:: Game-Optimization-Script v2.2.0
:: Released: 2025-04-17
:: By 抖音@鱼腥味(119020212) 转载请注明出处

@echo off

:: 设置变量延迟显示
setlocal enabledelayedexpansion

:: 一键设置TX反作弊优先级工具
title 一键设置TX反作弊优先级工具

:: 检查管理员权限
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

:: 打印标题
echo.
echo    ╔══════════════════════════════════════════════╗
echo    ║                                              ║
echo    ║        一键设置TX反作弊优先级工具 v2.2.0    ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0SetProcessPriority.ps1"
exit