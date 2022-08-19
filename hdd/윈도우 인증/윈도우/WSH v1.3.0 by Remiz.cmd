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
echo		[ 윈도우 초기 설정 도우미 v1.3.0 By Remiz ]
echo.
echo.
echo		1. 최대 절전 모드 켜기 [기본값]
echo.
echo		2. 최대 절전 모드 끄기
echo.
echo		3. 우클릭 메뉴 "제어판" 보이기
echo.
echo		4. 우클릭 메뉴 "제어판" 감추기 [기본값]
echo.
echo		5. 윈도우 디펜더 끄기/켜기
echo.
echo		6. 원드라이브[OneDrive] 제거
echo.
echo		7. 윈도우10, 오피스 2019 인증하기
echo.
echo		8. 윈도우 자동 업데이트 차단/활성화 하기
echo.
echo		9. StartIsBack(시작메뉴) 2.8.9 설치
echo.
echo		0. Windows 사진 뷰어 활성화
echo.
set menu=
set /p menu=원하시는 작업 번호를 입력 후 엔터(Enter)키를 눌러주세요 : 
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
echo OneDrive 관련 프로세스를 닫는중...
echo.
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1
echo OneDrive 제거중...
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
echo '바로가기'란의 OneDrive 제거중...
echo.
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
pause
goto main

:rightadd
reg add "HKEY_CLASSES_ROOT\DesktopBackground\Shell\Control Panel" /t REG_SZ /d "제어판" /f
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