:: Game-Optimization-Script v2.1.1
:: Released: 2025-04-12
:: By 抖音@鱼腥味(119020212) 转载请注明出处

@echo off

:: 设置变量延迟显示
setlocal enabledelayedexpansion

:: 一键启动游戏进程监控工具
title 一键启动游戏进程监控工具

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
echo    ║         一键启动游戏进程监控工具 v2.1        ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0GameProcessMonitor.ps1"
pause