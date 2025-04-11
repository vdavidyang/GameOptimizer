:: Game-Optimization-Script v2.1.0
:: Released: 2025-04-11
:: By 抖音@鱼腥味(119020212) 转载请注明出处

@echo off

:: 设置变量延迟显示
setlocal enabledelayedexpansion

:: 一键删除游戏优先级注册表修改
title 游戏优先级设置还原工具
:: mode con: cols=80 lines=30

:: color 0A

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
echo    ║         游戏优先级设置还原工具 v2.1          ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

:choice

set /p choice=是否确认删除游戏优先级设置？(Y-是/N-否, 默认Y):

if "!choice!"=="" set choice=y

if /i "!choice!"=="y" (

    :: 定义要删除的进程列表
    set "regPath=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
    set "success=0"
    set "failed=0"
    
    :: 删除SGuard相关进程
    call :DeleteReg "TX反作弊" "SGuard.exe"
    call :DeleteReg "TX反作弊" "SGuard64.exe"
    call :DeleteReg "TX反作弊" "SGuardSvc64.exe"

    :: 删除游戏进程
    call :DeleteReg "英雄联盟" "League of Legends.exe"
    call :DeleteReg "穿越火线" "crossfire.exe"
    call :DeleteReg "无畏契约" "VALORANT-Win64-Shipping.exe"
    call :DeleteReg "无畏契约" "VALORANT.exe"
    call :DeleteReg "三角洲WeGame版" "DeltaForce-Win64-Shipping.exe"
    call :DeleteReg "三角洲官方版" "DeltaForceClient-Win64-Shipping.exe"
    call :DeleteReg "枪神纪" "TPS.exe"
    call :DeleteReg "界外狂潮" "FragPunk.exe"
    call :DeleteReg "守望先锋" "Overwatch.exe"
    call :DeleteReg "CSGO2" "cs2.exe"
    call :DeleteReg "暗区突围" "UAgame.exe"
    call :DeleteReg "永劫无间" "NieRAutomata.exe"

    :: 结果统计
    echo.
    echo    ╔══════════════════════════════════════════════╗
    echo    ║                操作结果统计                  ║
    echo    ╠══════════════════════════════════════════════╣
    echo    ║  成功清除: !success! 项                            ║
    echo    ║  未找到项: !failed! 项                             ║
    echo    ╚══════════════════════════════════════════════╝
    echo.
    echo    注：未找到项可能表示之前未修改过该进程优先级
    echo.

    goto Endecho

) else if /i "!choice!"=="n" (

    echo.
    echo    ╔══════════════════════════════════════════════╗
    echo    ║                                              ║
    echo    ║          取消删除游戏优先级设置...           ║
    echo    ║                                              ║
    echo    ╚══════════════════════════════════════════════╝
    echo.

    goto Endecho

) else (

    echo 输入无效，请重新输入
    goto choice

)

:DeleteReg
set "game=%~1"
set "process=%~2"
reg delete "!regPath!\!process!" /f >nul 2>&1
if errorlevel 1 (
    echo    [×] 未找到 !game!-!process! 的注册表项
    set /a failed+=1
) else (
    echo    [√] 已清除 !game!-!process! 的优先级设置
    set /a success+=1
)
goto :eof

:Endecho
echo.
echo By 抖音@鱼腥味(119020212) 转载请注明出处
echo 本脚本完全免费，如果你是收费购买请联系卖家退款！！！
echo.

pause
exit /b