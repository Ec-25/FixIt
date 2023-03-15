:tl4
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS DE PROGRAMAS                            =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Detener Servicios Innecesarios                                        =
echo.       =                                                                                 =
echo.       =      2]   Desinstalar Aplicaciones                                              =
echo.       =                                                                                 =
echo.       =      3]   Desinstalar Aplicaciones de Windows                                   =
echo.       =                                                                                 =
echo.       =      4]   Instalar Todas las WindowsApps                                        =
echo.       =                                                                                 =
echo.       =      5]   Instalar Seleccion de WindowsApps                                     =
echo.       =                                                                                 =
echo.       =      6]   Limpiar Windows Defender                                              =
echo.       =                                                                                 =
echo.       =      7]   Editar tiempo del Historial de WinDefender (30d, predefinido)         =
echo.       =                                                                                 =
echo.       =      8]   Herramienta para Desinstalar Office                                   =
echo.       =                                                                                 =
echo.       =      0]   Salir                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                        by JuanchoWolf
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
    REM sc stop "Name of Service"
    REM sc config "Name of Service" start= disabled
    echo Creando un punto de Restauracion
    powershell -ExecutionPolicy Bypass -NoExit -Command "Checkpoint-Computer -Description "FixItRestorePoint" -RestorePointType "MODIFY_SETTINGS""& powershell exit
    echo.
    echo.
    sc stop defragsvc& sc config defragsvc start= disabled

    sc stop XblGameSave& sc config XblGameSave start= disabled

    sc stop SysMain& sc config SysMain start= disabled

    sc stop Fax& sc config Fax start= disabled

    sc stop TapiSrv& sc config TapiSrv start= disabled

    sc stop MapsBroker& sc config MapsBroker start= disabled

    sc stop SNMPTRAP& sc config SNMPTRAP start= disabled

    sc stop PcaSvc& sc config PcaSvc start= demand& REM demand = manual

    sc stop BDESVC& sc config BDESVC start= demand

    sc stop CertPropSvc& sc config CertPropSvc start= disabled

    sc stop DiagTrack& sc config DiagTrack start= disabled

    sc stop dmwappushservice& sc config dmwappushservice start= disabled

    sc stop BITS& sc config BITS start= disabled

    sc stop Netlogon& sc config Netlogon start= disabled

    sc stop XboxNetApiSvc& sc config XboxNetApiSvc start= disabled

    sc stop XboxGipSvc& sc config XboxGipSvc start= disabled

    sc stop RmSvc& sc config RmSvc start= disabled

    :bioquest
    echo.
    echo.
    set /p biometria= tienes un sensor biometrico? [S / N]
    if "%biometria%" == "s" goto tactilquest
    if "%biometria%" == "S" goto tactilquest
    if "%biometria%" == "n" goto biom.no
    if not "%biometria%" == "N" goto bioquest

    :biom.no
    sc stop NaturalAuthentication& sc config NaturalAuthentication start= disabled

    sc stop WbioSrvc& sc config WbioSrvc start= disabled

    :tactilquest
    echo.
    echo.
    set /p tactil= tienes una pantalla tactil? [S / N]
    if "%tactil%" == "s" goto tact.next
    if "%tactil%" == "S" goto tact.next
    if "%tactil%" == "n" goto tact.no
    if not "%tactil%" == "N" goto tactilquest

    :tact.no
    sc stop TabletInputService& sc config TabletInputService start= disabled

    :tact.next
    goto tl4
)
if "%tool%" == "2" (
    echo.
    echo.
    echo.
    WMIC product get name
    echo.
    echo. Copie y pegue debajo del nombre de la aplicacion que se muestra en la lista superior para desinstalarla
    echo.
    echo. ADVERTENCIA
    echo. 
    echo. Esta apunto de eliminar la aplicacion especificada. Esta accion es irreversible. Estas seguro de que quieres continuar?
    set /p ans.4op3=Esta de acuerdo?[S/N]
    echo.
    if "%ans.4op3%" == "S" goto 4op3.next
    if "%ans.4op3%" == "s" goto 4op3.next
    if "%ans.4op3%" == "N" goto tl4
    if "%ans.4op3%" == "n" goto tl4
    if not "%ans.4op3%" == "S, s, N or n" goto salir
    REM Para que se pueda desinstalar es necesario que el programa contenga un uninstaller en su carpeta de datos && Hay programas que no lo integran al completo por lo que no es posible por esta via desintalarlo
    :4op3.next
    set /p produn=AppUni=
    WMIC product where name="%produn%" call uninstall
    echo.
    pause
    goto tl4
)
if "%tool%" == "3" (
    echo.
    echo.
    echo.
    POWERSHELL "Get-AppxPackage | Select Name, PackageFullName"
    echo.
    echo. Copie y pegue debajo del nombre de la aplicacion que se muestra en la lista superior(derecha) para desinstalarla
    echo.
    echo. ADVERTENCIA
    echo. 
    echo. Esta apunto de eliminar la aplicacion especificada. Esta accion es irreversible. Estas seguro de que quieres continuar?
    set /p ans.4op4=Esta de acuerdo?[S/N]
    echo.
    if "%ans.4op4%" == "S" goto 4op4.next
    if "%ans.4op4%" == "s" goto 4op4.next
    if "%ans.4op4%" == "N" goto tl4
    if "%ans.4op4%" == "n" goto tl4
    if not "%ans.4op4%" == "S, s, N or n" goto salir
    :4op4.next
    PowerShell Set-ExecutionPolicy Unrestricted
    echo.
    set /p appak=APPID=
    POWERSHELL Remove-AppxPackage "%appak%"
    echo.
    PowerShell Set-ExecutionPolicy Restricted
    set /p opt=Continuar o ir al menu? [C / M]
    if "%opt%" == "c" goto 4op4.next
    if "%opt%" == "C" goto 4op4.next
    if not "%opt%" == "c or C" goto tl4
)
if "%tool%" == "4" (
    echo.
    echo.
    echo.
    PowerShell Set-ExecutionPolicy Unrestricted
    POWERSHELL "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register """$($_.InstallLocation)\appxmanifest.xml""" -DisableDevelopmentMode}"
    REM Add-AppxPackage : Error de implementación con HRESULT: 0x80073D02, No se pudo instalar el paquete porque los recursos que modifica están actualmente en uso.
    REM si sale el mensaje anterior, entonces el comando se ejecuto con exito
    PowerShell Set-ExecutionPolicy Restricted
    echo.
    echo. Instalacion exitosa
    pause
    goto tl4
)
if "%tool%" == "5" (
    echo.
    echo.
    echo.
    POWERSHELL Set-ExecutionPolicy Unrestricted
    echo.
    POWERSHELL "Get-AppxPackage -AllUsers | Select Name, PackageFullName"
    echo.
    echo Elija la aplicacion a instalar de la lista, y copie y pegue a continuacion, el codigo de identificacion del producto (columna derecha)
    echo    En algunos casos, es necesario reiniciar para que surta efecto.
    set /p appname=APPID=
    POWERSHELL "Add-AppxPackage -Register 'C:\Program Files\WindowsApps\%appname%\appxmanifest.xml' -DisableDevelopmentMode"
    POWERSHELL Set-ExecutionPolicy Restricted
    pause
    goto tl4
)
if "%tool%" == "6" (
    echo.
    cd C:\ProgramData\Microsoft\Windows Defender\Scans\History
    DEL Service /f /s /q
    RD Service /s /q
    MD Service
    pause
    goto tl4
)
if "%tool%" == "7" (
    echo.
    echo Cuanto tiempo desea definir como limite para que se borre periodicamente el historial de windows Defender. Especifiquelo en Dias (SOLO CON NUMEROS)
    set /p tiemp=
    echo. 
    echo.
    echo. Usted eligio "%tiemp%" Dias!
    POWERSHELL Set-MpPreference -ScanPurgeItemsAfterDelay "%tiemp%"
    echo. Listo!
    pause
    goto tl4
)
if "%tool%" == "8" (
    REM start https://aka.ms/SaRA-officeUninstallFromPC
    POWERSHELL Invoke-WebRequest -Uri "https://aka.ms/SaRA-officeUninstallFromPC" -OutFile "C:\Users\%username%\Downloads\SetupProd_OffScrub.exe"
    timeout 5
    move C:\Users\%username%\Downloads\SetupProd_OffScrub.exe "%~p0"
    cd "%~p0"
    start SetupProd_OffScrub.exe
    pause
    del SetupProd_OffScrub.exe /f /s /q
    echo.
    pause
    goto tl4
) else ( 
    goto tl4
)