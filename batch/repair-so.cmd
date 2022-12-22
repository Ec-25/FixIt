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
echo.       =      3]   Restauracion de la imagen                                             =
echo.       =                                                                                 =
echo.       =      4]   Analisis de la estructura de datos en el disco                        =
echo.       =                                                                                 =
echo.       =      0]   Salir                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by JuanchoWolf
echo.
echo.

set /p tool=Opcion =   

if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main.cmd
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
) else (
    goto tl1
)