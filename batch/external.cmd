:tl5
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                        HERRAMIENTAS DE PROGRAMAS EXTERNOS                       =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Open Hardware Monitor                                                 =
echo.       =                                                                                 =
echo.       =      2]   AutoRuns                                                              =
echo.       =                                                                                 =
echo.       =      0]   Salir                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                         by JuanchoWolf
echo.
echo.

set /p tool=Opcion =   

if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main.cmd
)
if "%tool%" == "1" (
    if not exist "tools\OpenHardwareMonitor" (
        POWERSHELL Invoke-WebRequest -Uri "https://openhardwaremonitor.org/files/openhardwaremonitor-v0.9.6.zip" -OutFile "ohm.zip"
        timeout 5
        POWERSHELL Expand-Archive -Path ohm.zip
        CD ohm
        MOVE "OpenHardwareMonitor" "%~p0\tools"
        cd..
        RMDIR /S /Q ohm
        DEL ohm.zip
    )
    cd "tools\OpenHardwareMonitor"
    start OpenHardwareMonitor.exe
    echo.
    echo.
    echo LISTO
    cd..
    cd..
    goto tl5
)
if "%tool%" == "2" (
    if not exist "tools\Autoruns" (
        POWERSHELL Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Autoruns.zip" -OutFile "Autoruns.zip"
        timeout 5
        POWERSHELL Expand-Archive -Path Autoruns.zip
        MOVE "Autoruns" "tools"
        DEL Autoruns.zip
    )
    cd "tools\Autoruns"
    start Autoruns64.exe
    echo.
    echo.
    echo LISTO
    cd..
    cd..
    goto tl5
)

else (
    goto tl5
)