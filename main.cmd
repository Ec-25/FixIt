@echo off
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
color 17
title FixIt

goto check_Permissions

:ini
cls

echo.
echo.       ===================================================================================
echo.       =                                       FIXTOOL                                   =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =        1]     Herramientas para Reparar SO                                      =
echo.       =                                                                                 =
echo.       =        2]     Herramientas de Internet                                          =
echo.       =                                                                                 =
echo.       =        3]     Reparacion Rapida                                                 =
echo.       =                                                                                 =
echo.       =        4]     Herramientas de Programas                                         =
echo.       =                                                                                 =
echo.       =        5]     Herramientas Adicionales                                          =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Para Cerrar el programa pulse el numero 0
echo.               de lo contrario muchos archivos temporales quedaran en su equipo.
echo.
echo.
echo.


set /p tool=Opcion =   

if "%tool%" == "0" goto salir
if "%tool%" == "1" goto tl1
if "%tool%" == "2" goto tl2
if "%tool%" == "3" goto tl3
if "%tool%" == "4" goto tl4
if "%tool%" == "5" goto tl5

if not "%tool%" == "0, 1, 2, 3, 4 or 5" goto ini

:tl1
cd "%~p0\batch"
repair-so.cmd

:tl2
cd "%~p0\batch"
lan.cmd

:tl3
cd "%~p0\batch"
flash.cmd

:tl4
cd "%~p0\batch"
programs.cmd

:tl5
cd "%~p0\batch"
addition.cmd

:salir
exit

:check_Permissions
echo Se requieren permisos administrativos. Detectando permisos...
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Exito: Permisos administrativos confirmados.
    goto ini
) else (
    color 4f
    echo Fallo: Permisos actuales inadecuados. 
    echo        NECESITA SER ADMINISTRADOR
    pause >nul
)