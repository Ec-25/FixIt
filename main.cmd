@echo off
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
color 17
title FixIt V1.10.2

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

:ini
echo.
echo.       ===================================================================================
echo.       =                                      FIXTOOL                                    =
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
echo.       =        6]     Accesos Directos                                                  =
echo.       =                                                                                 =
echo.       =        0]     Salir                                                             =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by JuanchoWolf
echo.

set /p tool=Opcion =   

if "%tool%" == "0" (
    exit
)
if "%tool%" == "1" (
    cd "%~p0\batch"
    repair-so.cmd
)
if "%tool%" == "2" (
    cd "%~p0\batch"
    lan.cmd
)
if "%tool%" == "3" (
    cd "%~p0\batch"
    flash.cmd
)
if "%tool%" == "4" (
    cd "%~p0\batch"
    programs.cmd
)
if "%tool%" == "5" (
    cd "%~p0\batch"
    addition.cmd
)
if "%tool%" == "6" (
    cd "%~p0\batch"
    access.cmd
) else (
    cls
    echo Opcion Invalida.
    goto ini
)