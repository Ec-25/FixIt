:tll
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS DE LIMPIEZA                             =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Limpieza del Sistema                                                  =
echo.       =                                                                                 =
echo.       =      2]   Limpiar el Visor de Eventos                                           =
echo.       =                                                                                 =
echo.       =      3]   Limpiar Windows Defender                                              =
echo.       =                                                                                 =
echo.       =      4]   Editar tiempo del Historial de WinDefender (30d, predefinido)         =
echo.       =                                                                                 =
echo.       =      5]   Quitar Marca de agua de Windows (10 y 11)                             =
echo.       =                                                                                 =
echo.       =      6]   Borrar Lista de Archivos Recientes                                    =
echo.       =                                                                                 =
echo.       =      0]   Salir                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by Ec25
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
    @REM elimina la carpeta temporal en silencio; tanto local como Windows. Al mismo tiempo, ejecuta el limpiador de ventanas interno y tambien limpia el cache de dns.
    echo Guarde y Cierre todo antes de continuar
    pause
    @REM Temporales
    del C:\Users\%username%\AppData\Local\Temp /f /s /q
    rd C:\Users\%username%\AppData\Local\Temp /s /q
    del C:\Windows\Temp /f /s /q
    rd C:\Windows\Temp /s /q
    @REM Dns
    CLEANMGR /D C:
    POWERSHELL Get-DnsClientCache
    POWERSHELL Clear-DnsClientCache
    @REM Papelera
    rd /s /q %USERPROFILE%\RecycleBin
    mkdir %USERPROFILE%\RecycleBin
    pause
    goto tll
)
if "%tool%" == "2" (
    echo Limpiando registros del Visor de eventos...
    @REM wevtutil es un conjunto de instrucciones del sistema que le permiten leer, modificar y eliminar registros y publicaciones de eventos.
    @REM con "cl" limpia todos los registros de eventos (aplicación, seguridad, sistema)
    wevtutil.exe cl Application
    wevtutil.exe cl Security
    wevtutil.exe cl System
    echo Registros del Visor de eventos eliminados con exito.
    pause
    goto tll
)
if "%tool%" == "3" (
    echo.
    @REM elimine el contenido y la carpeta de servicio en silencio para borrar el historial de acciones.
    cd C:\ProgramData\Microsoft\Windows Defender\Scans\History
    DEL Service /f /s /q
    RD Service /s /q
    MD Service
    pause
    goto tll
)
if "%tool%" == "4" (
    echo.
    echo "Cuanto tiempo desea definir como limite para que se borre periodicamente el historial de windows Defender. Especifiquelo en Dias (SOLO CON NUMEROS)"
    set /p tiemp=
    echo. 
    echo.
    echo. Usted eligio "%tiemp%" Dias!
    @REM ejecuta un comando personalizado de PowerShell, configurando la preferencia para escanear elementos después de los días solicitados en %tiemp%
    POWERSHELL Set-MpPreference -ScanPurgeItemsAfterDelay "%tiemp%"
    echo. Listo!
    pause
    goto tll
)
if "%tool%" == "5" (
    @REM agrega la clave de registro en currentVersion/Windows/ llamada "DisplayNotRet" con valor 0. para indicarle a Windows que no dibuje la marca de agua de la versión en la pantalla.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "DisplayNotRet" /t REG_DWORD /d "0" /f
    echo. Para que los cambios surtan efecto, reinicia el equipo
    echo. Listo...
    pause
    goto tll
)
if "%tool%" == "6" (
    echo.
    @REM elimina las claves de RecentDocs para borrar la lista de archivos abiertos recientemente del explorador
    REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f
    echo. Listo...
    pause
    goto tll
)
else (
    goto tll
)