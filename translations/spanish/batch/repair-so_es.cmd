:tl1
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS PARA REPARAR SO                         =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Comprobacion de archivos del sistema                                  =
echo.       =                                                                                 =
echo.       =      2]   Comprobar archivos de reparacion                                      =
echo.       =                                                                                 =
echo.       =      3]   Restauracion de la imagen del Sistema                                 =
echo.       =                                                                                 =
echo.       =      4]   Analisis de la estructura de datos en el disco                        =
echo.       =                                                                                 =
echo.       =      5]   Convertir Disco MBR a GPT (no recomendado)                            =
echo.       =                                                                                 =
echo.       =      6]   Forzar Actualizaciones Del Sistema (no recomendado)                   =
echo.       =                                                                                 =
echo.       =      7]   Desfragmentar la Unidad Principal                                     =
echo.       =                                                                                 =
echo.       =      0]   Salir                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.
echo.

set /p tool=Opcion =   

if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main_es.cmd
)
if "%tool%" == "1" (
    echo.
    echo.
    echo.
    sfc /scannow
    echo.
    echo.
    pause
    echo.
    goto tl1
)
if "%tool%" == "2" (
    echo.
    echo.
    echo.
    DISM /Online /Cleanup-Image /CheckHealth
    echo.
    echo.
    DISM /Online /Cleanup-Image /ScanHealth
    echo.
    echo.
    pause
    echo.
    goto tl1
)
if "%tool%" == "3" (
    echo.
    echo.
    echo.
    DISM /Online /Cleanup-Image /StartComponentCleanup
    echo.
    echo.
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    echo.
    pause
    echo.
    goto tl1
)
if "%tool%" == "4" (
    echo.
    echo.
    echo.
    chkdsk C: /F /R
    echo.
    echo Es necesario reiniciar, Guarde todo antes de continuar
    pause
    shutdown /r
    pause>NUL
    exit
)
if "%tool%" == "5" (
    cls
    echo.
    echo.   ADVERTENCIA...
    echo "La herramienta se diseno para ejecutarse desde un simbolo del sistema del Entorno de preinstalacion de Windows (Windows PE), pero tambien se puede ejecutar desde el sistema operativo (SO)"
    echo.   IMPORTANTE...
    echo. Antes de intentar convertir el disco, asegurate de que el dispositivo admita UEFI.
    echo.
    echo. Despues de que el disco se haya convertido al estilo de particion GPT, el firmware se debe configurar para arrancar en modo UEFI.
    set /p confirm="Desea Continuar bajo su Responsabilidad?   [1-Continuar ; 0-Salir]"
    if "%confirm%" == "1" goto 5op4a 
    if not "%confirm%" == "1" goto salir
    :5op4a
    POWERSHELL DiskPart /s dp.cmd
    cd C:\Windows\System32
    echo.
    set /p disk=Indique el numero del disco a Convertir que NO sea GPT   
    @REM Primero, valida que el disco seleccionado sea adecuado para la conversión.
    mbr2gpt /validate /disk:"%disk%" /allowFullOS
    echo.
    set /p valid="Solo! si el Proceso no fallo. Continue [1-Continuar ; 0-Salir]:"
    if "%valid%" == "1" goto 5op4b
    if not "%valid%" == "1" goto salir
    :5op4b
    @REM si está hecho convierta el disco a gpt; con la variante fullOs
    mbr2gpt /convert /disk:"%disk%" /allowFullOS
    echo.
    echo. REINICIANDO...
    echo. Acceda a BIOS y habilite SecureBoot
    shutdown /r /t 60
    exit
)
if "%tool%" == "6" (
    echo.
    echo Buscando y Actualizando.
    @REM busca (/detectnow) y fuerza las actualizaciones del sistema (/updatenow)
    wuauclt /detectnow /updatenow
    echo. Este proceso es en segundo plano, y puede tardar segun la velocidad de su internet.
    pause
    echo.
    goto tl1
)
if "%tool%" == "7" (
    echo Desfragmentando unidad de disco...
    defrag C: /U /V
    pause
    echo.
    goto tl1
)
else (
    goto tl1
)