@echo off
REM
 REM @Author: vdavidyang vdavidyang@gmail.com
 REM @Date: 2025-04-11 15:39:30
 REM @LastEditors: vdavidyang vdavidyang@gmail.com
 REM @LastEditTime: 2025-07-26 19:55:48
 REM @FilePath: \GameOptimizer\scripts\一键删除游戏优先级（注册表）_通用版.bat
 REM @Description: 
 REM @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
REM


REM 设置变量延迟显示
setlocal EnableDelayedExpansion

REM 一键删除游戏优先级注册表修改
title 游戏优先级设置还原工具
REM mode con: cols=80 lines=30

REM color 0A

REM 设置控制台输出编码为GBK
chcp 936 >nul

REM 检查管理员权限，如果当前用户不是管理员，则请求管理员权限
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 (
    echo 请求管理员权限...
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
echo    ║          游戏优先级设置还原工具 v2.3.2       ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

REM 选择是否确认删除游戏优先级设置
:choice

set /p choice=是否确认删除游戏优先级设置？(Y-是/N-否, 默认Y):

if "!choice!"=="" set choice=y

if /i "!choice!"=="y" (
  
  REM 定义要删除的进程列表
  set "regPath=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
  set "success=0"
  set "failed=0"
  
  REM 删除SGuard相关进程
  call :DeleteReg "TX反作弊-SGuard" "SGuard.exe"
  call :DeleteReg "TX反作弊-SGuard64" "SGuard64.exe"
  call :DeleteReg "TX反作弊-SGuardSvc64" "SGuardSvc64.exe"
  
  REM 删除游戏进程
  call :DeleteReg "英雄联盟" "League of Legends.exe"
  call :DeleteReg "穿越火线" "crossfire.exe"
  call :DeleteReg "无畏契约1" "VALORANT-Win64-Shipping.exe"
  call :DeleteReg "无畏契约2" "VALORANT.exe"
  call :DeleteReg "三角洲WeGame版" "DeltaForce-Win64-Shipping.exe"
  call :DeleteReg "三角洲官方版" "DeltaForceClient-Win64-Shipping.exe"
  call :DeleteReg "枪神纪" "TPS.exe"
  call :DeleteReg "界外狂潮" "FragPunk.exe"
  call :DeleteReg "守望先锋" "Overwatch.exe"
  call :DeleteReg "CSGO2" "cs2.exe"
  call :DeleteReg "暗区突围" "UAgame.exe"
  call :DeleteReg "永劫无间" "NarakaBladepoint.exe"
  
  REM 结果统计
  echo.
  echo    ╔══════════════════════════════════════════════╗
  echo    ║                 操作结果统计                 ║
  echo    ╠══════════════════════════════════════════════╣
  echo    ║             成功清除: !success! 项                  ║
  echo    ║             未找到项: !failed! 项                  ║
  echo    ╚══════════════════════════════════════════════╝
  echo.
  echo  注：未找到项可能表示之前未修改过该进程优先级
  echo.
  
  goto Endecho
  
  ) else if /i "!choice!"=="n" (
  
  echo.
  echo    ╔══════════════════════════════════════════════╗
  echo    ║                                              ║
  echo    ║           取消删除游戏优先级设置...          ║
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
  echo  [×] 未找到 !game!-!process! 的注册表项
  set /a failed+=1
  ) else (
  echo  [√] 已清除 !game!-!process! 的优先级设置
  set /a success+=1
)
goto :eof

:Endecho
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

pause
exit /b
