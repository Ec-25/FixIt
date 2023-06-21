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
echo.       =      3]   Process Explorer                                                      =
echo.       =                                                                                 =
echo.       =      0]   Salir                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.       ADVERTENCIA:    Ninguno de estos programas son de mi pertenencia.
echo.                       Es Software de Codigo Abierto recopilado de Internet desde sus fuentes oficiales.
echo.                           Ejecutelos bajo su propio riesgo.
echo.
echo.

set /p tool=Opcion =   

if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main_es.cmd
)
if "%tool%" == "1" (
    @REM verifique que no existan tales archivos en el directorio del programa para no volver a descargarlos
    if not exist "tools\OpenHardwareMonitor" (
        @REM si no existe, invoca una solicitud web desde powershell y obtiene el paquete de extensión .zip, extrayéndolo en la carpeta del directorio para poder administrarlo
        POWERSHELL Invoke-WebRequest -Uri "https://openhardwaremonitor.org/files/openhardwaremonitor-v0.9.6.zip" -OutFile "ohm.zip"
        timeout 5
        @REM Expand Archive le permite manipular archivos comprimidos con la extensión .zip
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
if "%tool%" == "3" (
    if not exist "tools\ProcessExplorer" (
        POWERSHELL Invoke-WebRequest -Uri "https://download.sysinternals.com/files/ProcessExplorer.zip" -OutFile "ProcessExplorer.zip"
        timeout 5
        POWERSHELL Expand-Archive -Path ProcessExplorer.zip
        MOVE "ProcessExplorer" "tools"
        DEL ProcessExplorer.zip
    )
    cd "tools\ProcessExplorer"
    start procexp64.exe
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