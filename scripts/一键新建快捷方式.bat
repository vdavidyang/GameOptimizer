:: Game-Optimization-Script v2.1.1
:: Released: 2025-04-11
:: By ����@����ζ(119020212) ת����ע������

@echo off
setlocal enabledelayedexpansion

:: ʹ�õ�ǰ�ű�����Ŀ¼��Ϊ����Ŀ¼
cd /d "%~dp0"

set "batfile=һ������TX���������ȼ�.bat"
set "lnkname=һ������TX���������ȼ�.lnk"

:: ���Դ�ļ��Ƿ����
if not exist "%batfile%" (
    echo ���󣺵�ǰĿ¼��δ�ҵ� "%batfile%"
    pause
    exit /b 1
)

:: ʹ�� PowerShell ������ݷ�ʽ
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U           ���ڴ��������ݷ�ʽ...            �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
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

:: ����ݷ�ʽ�Ƿ񴴽��ɹ�
if not exist "%USERPROFILE%\Desktop\%lnkname%" (
    echo.
    echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
    echo    �U                                              �U
    echo    �U      ���󣺿�ݷ�ʽ����ʧ�ܣ�����Ȩ��       �U
    echo    �U                                              �U
    echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
    echo.
    pause
    exit /b 1
)

:: �޸Ŀ�ݷ�ʽ�Թ���ԱȨ������
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U            �������ù���ԱȨ��...             �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

set "ps_admin=$desktop = [Environment]::GetFolderPath('Desktop');"
set "ps_admin=%ps_admin% $lnk = Join-Path $desktop '%lnkname%';"
set "ps_admin=%ps_admin% $bytes = [System.IO.File]::ReadAllBytes($lnk);"
set "ps_admin=%ps_admin% $bytes[0x15] = $bytes[0x15] -bor 0x20;"
set "ps_admin=%ps_admin% [System.IO.File]::WriteAllBytes($lnk, $bytes);"

powershell -Command "%ps_admin%"

echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U ������ɣ��Ѵ��������ݷ�ʽ�����ù���ԱȨ�� �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

echo.
echo By ����@����ζ(119020212) ת����ע������
echo ���ű���ȫ��ѣ���������շѹ�������ϵ�����˿����
echo.

pause
exit /b