@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Run as Administrator...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    rem del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin

:main
cls
echo.
echo.
echo		[ ������ �ʱ� ���� ����� v1.3.0 By Remiz ]
echo.
echo.
echo		1. �ִ� ���� ��� �ѱ� [�⺻��]
echo.
echo		2. �ִ� ���� ��� ����
echo.
echo		3. ��Ŭ�� �޴� "������" ���̱�
echo.
echo		4. ��Ŭ�� �޴� "������" ���߱� [�⺻��]
echo.
echo		5. ������ ����� ����/�ѱ�
echo.
echo		6. ������̺�[OneDrive] ����
echo.
echo		7. ������10, ���ǽ� 2019 �����ϱ�
echo.
echo		8. ������ �ڵ� ������Ʈ ����/Ȱ��ȭ �ϱ�
echo.
echo		9. StartIsBack(���۸޴�) 2.8.9 ��ġ
echo.
echo		0. Windows ���� ��� Ȱ��ȭ
echo.
set menu=
set /p menu=���Ͻô� �۾� ��ȣ�� �Է� �� ����(Enter)Ű�� �����ּ��� : 
if "%menu%" == "1" goto make
if "%menu%" == "2" goto delete
if "%menu%" == "3" goto rightadd
if "%menu%" == "4" goto rightdel
if "%menu%" == "5" goto antion
if "%menu%" == "6" goto one
if "%menu%" == "7" goto act
if "%menu%" == "8" goto ub
if "%menu%" == "9" goto sib
if "%menu%" == "0" goto pic

goto main

:ub
start %~dp01mp\ub\"Wub.exe"
pause
goto main

:make
powercfg -h on
pause
goto main

:delete
powercfg -h off
pause
goto main

:one
set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
echo.
echo OneDrive ���� ���μ����� �ݴ���...
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive ������...
echo.
if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1
echo Removing OneDrive leftovers...
echo.
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
echo '�ٷΰ���'���� OneDrive ������...
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
pause
goto main

:rightadd
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel" /t REG_SZ /d "������" /f
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel" /v "icon" /t REG_SZ /d "Control.exe" /f
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel\command" /t REG_SZ /d "Control.exe" /f
pause
goto main

:rightdel
reg delete "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel" /f
pause
goto main

:act
start %~dp01mp\act\"KMSAuto.exe"
pause
goto main

:sib
start %~dp01mp\start\"st.exe"
pause
goto main

:antion
start %~dp01mp\de\"DefenderControl.exe"
pause
goto main

:pic
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".wdp" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f
pause
goto main

:exit
exit