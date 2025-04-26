:: Game-Optimization-Script v2.3.1
:: Released: 2025-04-26
:: By 抖音@鱼腥味(119020212) 转载请注明出处

@echo off

:: 设置变量延迟显示
setlocal enabledelayedexpansion

:: 一键设置TX反作弊优先级工具
title 一键设置TX反作弊优先级工具

:: 设置控制台输出编码为GBK
chcp 936 >nul

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
echo    ║        一键设置TX反作弊优先级工具 v2.3.1     ║
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

PowerShell -NoProfile -ExecutionPolicy Bypass -File "%~dp0SetProcessPriority.ps1"

exit