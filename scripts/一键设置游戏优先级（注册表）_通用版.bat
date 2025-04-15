:: Game-Optimization-Script v2.1.1
:: Released: 2025-04-11
:: By 抖音@鱼腥味(119020212) 转载请注明出处

@echo off

:: 设置变量延迟显示
setlocal enabledelayedexpansion

:: 标题
title 游戏进程优先级优化工具

:: 设置列和行数
:: mode con: cols=80 lines=60

:: 颜色：绿色
:: color 0A

:: 检查是否以管理员身份运行
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
echo    ║        游戏进程优先级优化工具 v2.1           ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

:: CPU优先级
:: 十进制 级别
::   1   Idle (低)
::   2   Normal (正常)
::   3   High (高)
::   4   Realtime (实时)
::   5   Below Normal (低于正常)
::   6   Above Normal (高于正常)

:: I/O优先级
:: 十进制 级别
::   0   Very Low (极低)
::   1   Low (低)
::   2   Normal (正常)
::   3   High (高)

:: 设置反作弊进程 SGuard.exe 和 SGuard64.exe CPU优先级和I/O优先级
:: 设置 SGuard.exe → CPU=1 (低), IO=0 (极低)
call :SetPriority "TX反作弊进程-SGuard" "SGuard.exe" 1 0

:: 设置 SGuard64.exe → CPU=1 (低), IO=0 (极低)
call :SetPriority "TX反作弊进程-SGuard64" "SGuard64.exe" 1 0

:: 设置 SGuardSvc64.exe → CPU=1 (低), IO=0 (极低)
call :SetPriority "TX反作弊进程-SGuardSvc64" "SGuardSvc64.exe" 1 0


:: 设置游戏进程优先级
:: 以LOL为例 进程名为"League of Legends.exe"
:: 其他游戏自行替换下面代码中的"League of Legends.exe"即可
:: 非TX游戏也可以设置 本质还是提升了系统对游戏的响应优先级

:: 设置 英雄联盟-League of Legends.exe → CPU=3 (高), IO=3 (高)
call :SetPriority "英雄联盟" "League of Legends.exe" 3 3

:: 设置 穿越火线-crossfire.exe → CPU=3 (高), IO=3 (高)
call :SetPriority "穿越火线" "crossfire.exe" 3 3

:: 设置 无畏契约-VALORANT-Win64-Shipping.exe → CPU=3 (高), IO=3 (高)
call :SetPriority "无畏契约1" "VALORANT-Win64-Shipping.exe" 3 3
:: 设置 无畏契约-VALORANT.exe → CPU=3 (高), IO=3 (高)
call :SetPriority "无畏契约2" "VALORANT.exe" 3 3

:: 设置 三角洲-DeltaForce-Win64-Shipping.exe → CPU=3 (高), IO=3 (高)
call :SetPriority "三角洲WeGame版" "DeltaForce-Win64-Shipping.exe" 3 3
:: 设置 三角洲-DeltaForceClient-Win64-Shipping.exe → CPU=3 (高), IO=3 (高)
call :SetPriority "三角洲官方版" "DeltaForceClient-Win64-Shipping.exe" 3 3

:: 设置 枪神纪-TPS.exe→ CPU=3 (高), IO=3 (高)
call :SetPriority "枪神纪" "TPS.exe" 3 3

:: 设置 界外狂潮-FragPunk.exe→ CPU=3 (高), IO=3 (高)
call :SetPriority "界外狂潮" "FragPunk.exe" 3 3

:: 设置 守望先锋-Overwatch.exe→ CPU=3 (高), IO=3 (高)
call :SetPriority "守望先锋" "Overwatch.exe" 3 3

:: 设置 CSGO2-cs2.exe→ CPU=3 (高), IO=3 (高)
call :SetPriority "CSGO2" "cs2.exe" 3 3

:: 设置 暗区突围-UAgame.exe→ CPU=3 (高), IO=3 (高)
call :SetPriority "暗区突围" "UAgame.exe" 3 3

:: 设置 永劫无间-NarakaBladepoint.exe→ CPU=3 (高), IO=3 (高)
call :SetPriority "永劫无间" "NarakaBladepoint.exe" 3 3

:: 如需多款游戏直接复制粘贴上方代码并替换名称即可
:: 如 call :SetPriority "XXX.exe" X X "游戏名称"

:: 完成提示
echo.
echo    ╔══════════════════════════════════════════════╗
echo    ║                                              ║
echo    ║         所有进程优先级已设置完成             ║
echo    ║                                              ║
echo    ╚══════════════════════════════════════════════╝
echo.

:: 自动创建快捷方式并设置管理员权限
:choice
set /p choice=是否自动创建一键设置TX反作弊优先级快捷方式？(Y-是/N-否, 默认Y):
if "!choice!"=="" set choice=y

if /i "!choice!"=="y" (
    call "%~dp0一键新建快捷方式.bat"
) else if /i "!choice!"=="n" (
    echo.
    echo    ╔══════════════════════════════════════════════╗
    echo    ║                                              ║
    echo    ║           跳过创建桌面快捷方式...            ║
    echo    ║                                              ║
    echo    ╚══════════════════════════════════════════════╝
    echo.
) else (
    echo 输入无效，请重新输入
    goto choice
)

echo.
echo By 抖音@鱼腥味(119020212) 转载请注明出处
echo 本脚本完全免费，如果你是收费购买请联系卖家退款！！！
echo.

pause
exit /b


:: 设置优先级函数
:SetPriority
setlocal
set "game=%~1"
set "process=%~2"
set "cpuPriority=%~3"
set "ioPriority=%~4"

:: 转换CPU优先级为中文
if "%cpuPriority%"=="1" set "cpuText=低"
if "%cpuPriority%"=="2" set "cpuText=正常"
if "%cpuPriority%"=="3" set "cpuText=高"
if "%cpuPriority%"=="4" set "cpuText=实时"
if "%cpuPriority%"=="5" set "cpuText=低于正常"
if "%cpuPriority%"=="6" set "cpuText=高于正常"

:: 转换I/O优先级为中文
if "%ioPriority%"=="0" set "ioText=极低"
if "%ioPriority%"=="1" set "ioText=低"
if "%ioPriority%"=="2" set "ioText=正常"
if "%ioPriority%"=="3" set "ioText=高"

:: 美化输出格式
if not "%game%"=="" (
    echo    ┌──────────────────────────────────────────────┐
    echo    │  游戏名称: %game%
    echo    │  进程名称: %process%
    echo    │  CPU优先级: %cpuText%
    echo    │  I/O优先级: %ioText%
    echo    └──────────────────────────────────────────────┘
) else (
    echo    ┌──────────────────────────────────────────────┐
    echo    │  进程名称: %process%
    echo    │  CPU优先级: %cpuText%
    echo    │  I/O优先级: %ioText%
    echo    └──────────────────────────────────────────────┘
)


reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process%" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process%\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d %cpuPriority% /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%process%\PerfOptions" /v "IoPriority" /t REG_DWORD /d %ioPriority% /f >nul
endlocal
goto :eof