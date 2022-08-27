:tl1
cls

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
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio
echo.

set /p tool=Opcion =   

if "%tool%" == "0" goto salir
if "%tool%" == "1" goto 1op1
if "%tool%" == "2" goto 1op2
if "%tool%" == "3" goto 1op3
if "%tool%" == "4" goto 1op4
if not "%tool%" == "0, 1, 2, 3 or 4" goto tl1

:1op1
echo.
echo.
echo.
sfc /scannow
echo.
echo.
pause
echo.
goto tl1

:1op2
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

:1op3
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

:1op4
echo.
echo.
echo.
chkdsk C: /F /R
echo.
echo Es necesario reiniciar, Guarde todo antes de continuar
pause
shutdown /r
pause>NUL
goto exit

:salir
cd "%~p0"
cd..
main.bat