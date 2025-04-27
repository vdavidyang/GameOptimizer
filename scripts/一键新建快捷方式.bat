@echo off
REM
 REM @Author: vdavidyang vdavidyang@gmail.com
 REM @Date: 2025-04-11 15:39:30
 REM @LastEditors: vdavidyang vdavidyang@gmail.com
 REM @LastEditTime: 2025-04-27 17:07:15
 REM @FilePath: \GameOptimizer\scripts\一键新建快捷方式.bat
 REM @Description: 
 REM @Copyright (c) 2025 by vdavidyang vdavidyang@gmail.com, All Rights Reserved. 
REM


setlocal EnableDelayedExpansion

REM 一键新建快捷方式
title 一键新建快捷方式

:: 设置控制台输出编码为GBK
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
echo    ║            一键新建快捷方式 v2.3.2           ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

:: 使用当前脚本所在目录作为工作目录
cd /d "%~dp0"

set "batfile=一键设置TX反作弊优先级.bat"
set "lnkname=一键设置TX反作弊优先级.lnk"

:: 检查源文件是否存在
if not exist "%batfile%" (
    echo 错误：当前目录下未找到 "%batfile%"
    pause
    exit /b 1
)

:: 使用 PowerShell 创建快捷方式
echo.
echo    ╔══════════════════════════════════════════════╗
echo    ║                                              ║
echo    ║           正在创建桌面快捷方式...            ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
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

:: 检查快捷方式是否创建成功
if not exist "%USERPROFILE%\Desktop\%lnkname%" (
    echo.
    echo    ╔══════════════════════════════════════════════╗
    echo    ║                                              ║
    echo    ║      错误：快捷方式创建失败，请检查权限       ║
    echo    ║                                              ║
    echo    ╚══════════════════════════════════════════════╝
    echo.
    pause
    exit /b 1
)

:: 修改快捷方式以管理员权限运行
echo.
echo    ╔══════════════════════════════════════════════╗
echo    ║                                              ║
echo    ║            正在配置管理员权限...             ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

set "ps_admin=$desktop = [Environment]::GetFolderPath('Desktop');"
set "ps_admin=%ps_admin% $lnk = Join-Path $desktop '%lnkname%';"
set "ps_admin=%ps_admin% $bytes = [System.IO.File]::ReadAllBytes($lnk);"
set "ps_admin=%ps_admin% $bytes[0x15] = $bytes[0x15] -bor 0x20;"
set "ps_admin=%ps_admin% [System.IO.File]::WriteAllBytes($lnk, $bytes);"

powershell -Command "%ps_admin%"

echo.
echo    ╔══════════════════════════════════════════════╗
echo    ║                                              ║
echo    ║ 操作完成！已创建桌面快捷方式并启用管理员权限 ║
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

pause
exit /b