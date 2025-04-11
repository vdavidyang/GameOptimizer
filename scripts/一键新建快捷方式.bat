:: Game-Optimization-Script v2.1.1
:: Released: 2025-04-11
:: By 抖音@鱼腥味(119020212) 转载请注明出处

@echo off
setlocal enabledelayedexpansion

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
echo By 抖音@鱼腥味(119020212) 转载请注明出处
echo 本脚本完全免费，如果你是收费购买请联系卖家退款！！！
echo.

pause
exit /b