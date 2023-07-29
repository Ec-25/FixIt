@echo off
@REM si "%1" el proceso se ejecuta de una forma distinta a la maximizada, inicia un nuevo proceso minimizado y cierra el proceso que no fue maximizado
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
color 17
title FixIt V1.14.6
:check_Permissions
@REM La sesión de red solicita permisos de administrador
@REM si el proceso tiene dichos permisos no devuelve el error y continua su ejecucion(%errorLevel% == 0)
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
cls
echo.
echo.       ===================================================================================
echo.       =                                      FIXTOOL                                    =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =        SIMPLE                                                                   =
echo.       =        s]     Reparacion Rapida                                                 =
echo.       =                                                                                 =
echo.       =        c]     Herramientas de Limpieza                                          =
echo.       =                                                                                 =
echo.       =        AVANZADO                                                                 =
echo.       =        1]     Herramientas para el Sistema Operativo                            =
echo.       =                                                                                 =
echo.       =        2]     Herramientas para Internet                                        =
echo.       =                                                                                 =
echo.       =        3]     Accesos Directos de Herramientas del Sistema                      =
echo.       =                                                                                 =
echo.       =        EXTERNAS                                                                 =
echo.       =        4]     Herramientas Varias                                               =
echo.       =                                                                                 =
echo.       =        5]     Herramientas de Terceros                                          =
echo.       =                                                                                 =
echo.       =        SALIDA                                                                   =
echo.       =        0]     Salir                                                             =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.
set /p tool=Opcion =   
@REM en esta sección se determina el nuevo menú a desplegar.
if "%tool%" == "0" (
    exit
)
if "%tool%" == "s" (
    cd "%~p0\batch"
    flash.cmd
)
if "%tool%" == "c" (
    cd "%~p0\batch"
    clean_es.cmd
)
if "%tool%" == "1" (
    cd "%~p0\batch"
    repair-so_es.cmd
)
if "%tool%" == "2" (
    cd "%~p0\batch"
    lan_es.cmd
)
if "%tool%" == "3" (
    cd "%~p0\batch"
    access_es.cmd
)
if "%tool%" == "4" (
    cd "%~p0\batch"
    other_es.cmd
)
if "%tool%" == "5" (
    cd "%~p0\batch"
    external_es.cmd
)
else (
    goto ini
)