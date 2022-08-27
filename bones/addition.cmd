:tl5
cls

echo.       ===================================================================================
echo.       =                            HERRAMIENTAS ADICIONALES                             =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Office 2021 Installer                                                 =
echo.       =                                                                                 =
echo.       =      2]   Viejo Visor de Fotos                                                  =
echo.       =                                                                                 =
echo.       =      3]   Codec de Audio Actializado                                            =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio
echo.

set /p tool=Opcion =   

if "%tool%" == "0" goto salir
if "%tool%" == "1" goto 5op1
if "%tool%" == "2" goto 5selop
if "%tool%" == "3" goto 5selop
if not "%tool%" == "3" goto tl5

:5op1
start https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img
pause
MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
cd %~p0
start ProPlus2021Retail.img
echo Listo, ejecute el Setup.exe y su programa se instalara.
pause
goto tl5

:5selop
start https://drive.google.com/uc?id=1UWrNule5gi1Q5tkcKqO34zlLgtZP35gw
pause
MOVE "C:\Users\%username%\Downloads\otherTools.zip" "%~p0"
cd %~p0
tar -xf otherTools.zip
DEL otherTools.zip
if "%tool%" == "2" goto 5op2
if "%tool%" == "3" goto 5op3

:5op2
cd %~p0&cd otherTools
start visualphotos.reg
pause
goto tl5

:5op3
cd %~p0&cd otherTools
POWERSHELL "Add-AppxPackage Microsoft.HEVCVideoExtension_1.0.42701.0_x64__8wekyb3d8bbwe.Appx"
pause
goto tl5

:salir
cd "%~p0"
cd..
main.bat