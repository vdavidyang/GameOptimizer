:: Game-Optimization-Script v2.1.0
:: Released: 2025-04-11
:: By ����@����ζ(119020212) ת����ע������

@echo off

:: ���ñ����ӳ���ʾ
setlocal enabledelayedexpansion

:: һ��ɾ����Ϸ���ȼ�ע����޸�
title ��Ϸ���ȼ����û�ԭ����
:: mode con: cols=80 lines=30

:: color 0A

:: ������ԱȨ��
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
    echo    �U                                              �U
    echo    �U        ���Ҽ�"�Թ���Ա�������"�˽ű���       �U
    echo    �U                                              �U
    echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
    echo.
    pause
    exit /b
)

:: ��ӡ����
echo.
echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
echo    �U                                              �U
echo    �U         ��Ϸ���ȼ����û�ԭ���� v2.1          �U
echo    �U                                              �U
echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
echo.

:choice

set /p choice=�Ƿ�ȷ��ɾ����Ϸ���ȼ����ã�(Y-��/N-��, Ĭ��Y):

if "!choice!"=="" set choice=y

if /i "!choice!"=="y" (

    :: ����Ҫɾ���Ľ����б�
    set "regPath=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
    set "success=0"
    set "failed=0"
    
    :: ɾ��SGuard��ؽ���
    call :DeleteReg "TX������" "SGuard.exe"
    call :DeleteReg "TX������" "SGuard64.exe"
    call :DeleteReg "TX������" "SGuardSvc64.exe"

    :: ɾ����Ϸ����
    call :DeleteReg "Ӣ������" "League of Legends.exe"
    call :DeleteReg "��Խ����" "crossfire.exe"
    call :DeleteReg "��η��Լ" "VALORANT-Win64-Shipping.exe"
    call :DeleteReg "��η��Լ" "VALORANT.exe"
    call :DeleteReg "������WeGame��" "DeltaForce-Win64-Shipping.exe"
    call :DeleteReg "�����޹ٷ���" "DeltaForceClient-Win64-Shipping.exe"
    call :DeleteReg "ǹ���" "TPS.exe"
    call :DeleteReg "�����" "FragPunk.exe"
    call :DeleteReg "�����ȷ�" "Overwatch.exe"
    call :DeleteReg "CSGO2" "cs2.exe"
    call :DeleteReg "����ͻΧ" "UAgame.exe"
    call :DeleteReg "�����޼�" "NieRAutomata.exe"

    :: ���ͳ��
    echo.
    echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
    echo    �U                �������ͳ��                  �U
    echo    �d�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�g
    echo    �U  �ɹ����: !success! ��                            �U
    echo    �U  δ�ҵ���: !failed! ��                             �U
    echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
    echo.
    echo    ע��δ�ҵ�����ܱ�ʾ֮ǰδ�޸Ĺ��ý������ȼ�
    echo.

    goto Endecho

) else if /i "!choice!"=="n" (

    echo.
    echo    �X�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�[
    echo    �U                                              �U
    echo    �U          ȡ��ɾ����Ϸ���ȼ�����...           �U
    echo    �U                                              �U
    echo    �^�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�T�a
    echo.

    goto Endecho

) else (

    echo ������Ч������������
    goto choice

)

:DeleteReg
set "game=%~1"
set "process=%~2"
reg delete "!regPath!\!process!" /f >nul 2>&1
if errorlevel 1 (
    echo    [��] δ�ҵ� !game!-!process! ��ע�����
    set /a failed+=1
) else (
    echo    [��] ����� !game!-!process! �����ȼ�����
    set /a success+=1
)
goto :eof

:Endecho
echo.
echo By ����@����ζ(119020212) ת����ע������
echo ���ű���ȫ��ѣ���������շѹ�������ϵ�����˿����
echo.

pause
exit /b