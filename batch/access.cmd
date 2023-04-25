:tl7
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                               ACCESOS DIRECTOS                                  =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Version de Windows                                                    =
echo.       =                                                                                 =
echo.       =      2]   Configuracion de Control de Cuentas de Windows                        =
echo.       =                                                                                 =
echo.       =      3]   Seguridad y Mantenimiento                                             =
echo.       =                                                                                 =
echo.       =      4]   Solucionador de Problemas de Windows                                  =
echo.       =                                                                                 =
echo.       =      5]   Administrador del Equipo                                              =
echo.       =                                                                                 =
echo.       =      6]   Informacion del Sistema                                               =
echo.       =                                                                                 =
echo.       =      7]   Visor de Eventos                                                      =
echo.       =                                                                                 =
echo.       =      8]   Programas y Caracteristicas                                           =
echo.       =                                                                                 =
echo.       =      9]   Propiedades del Sistema                                               =
echo.       =                                                                                 =
echo.       =     10]   Opciones de Internet                                                  =
echo.       =                                                                                 =
echo.       =     11]   Configuracion de Protocolo de Internet                                =
echo.       =                                                                                 =
echo.       =     12]   Monitor de Rendimiento                                                =
echo.       =                                                                                 =
echo.       =     13]   Monitor de Recursos                                                   =
echo.       =                                                                                 =
echo.       =     14]   Administrador de Tareas                                               =
echo.       =                                                                                 =
echo.       =     15]   Editor del Registro                                                   =
echo.       =                                                                                 =
echo.       =     16]   Restaurar Sistema                                                     =
echo.       =                                                                                 =
echo.       =     17]   Configuracion de Inicio del Sistema                                   =
echo.       =                                                                                 =
echo.       =     18]   Herramienta de Diagonstico de DirectX                                 =
echo.       =                                                                                 =
echo.       =     19]   Analisis Antimalware                                                  =
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
    winver
    pause
    echo.
    goto tl7
)
if "%tool%" == "2" (
    UserAccountControlSettings
    pause
    echo.
    goto tl7
)
if "%tool%" == "3" (
    C:\WINDOWS\System32\wscui.cpl
    pause
    echo.
    goto tl7
)
if "%tool%" == "4" (
    C:\WINDOWS\System32\control.exe /name Microsoft.Troubleshooting
    pause
    echo.
    goto tl7
)
if "%tool%" == "5" (
    compmgmt
    pause
    echo.
    goto tl7
)
if "%tool%" == "6" (
    msinfo32
    pause
    echo.
    goto tl7
)
if "%tool%" == "7" (
    eventvwr
    pause
    echo.
    goto tl7
)
if "%tool%" == "8" (
    C:\WINDOWS\System32\appwiz.cpl
    pause
    echo.
    goto tl7
)
if "%tool%" == "9" (
    C:\WINDOWS\System32\control.exe system
    pause
    echo.
    goto tl7
)
if "%tool%" == "10" (
    C:\WINDOWS\System32\inetcpl.cpl
    pause
    echo.
    goto tl7
)
if "%tool%" == "11" (
    ipconfig
    pause
    echo.
    goto tl7
)
if "%tool%" == "12" (
    perfmon
    pause
    echo.
    goto tl7
)
if "%tool%" == "13" (
    resmon
    pause
    echo.
    goto tl7
)
if "%tool%" == "14" (
    C:\WINDOWS\System32\taskmgr.exe /7
    pause
    echo.
    goto tl7
)
if "%tool%" == "15" (
    regedt32
    pause
    echo.
    goto tl7
)
if "%tool%" == "16" (
    rstrui
    pause
    echo.
    goto tl7
)
if "%tool%" == "17" (
    msconfig
    pause
    echo.
    goto tl7
)
if "%tool%" == "18" (
    dxdiag
    pause
    echo.
    goto tl7
)
if "%tool%" == "19" (
    mrt
    pause
    echo.
    goto tl7
)
else (
    goto tl7
)