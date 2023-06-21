:tl4
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS EXTRAS                                  =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Detener Servicios Innecesarios                                        =
echo.       =                                                                                 =
echo.       =      2]   Desinstalar Aplicaciones                                              =
echo.       =                                                                                 =
echo.       =      3]   Desinstalar Aplicaciones de Windows                                   =
echo.       =                                                                                 =
echo.       =      4]   Desinstalar Office                                                    =
echo.       =                                                                                 =
echo.       =      5]   Instalar Todas las WindowsApps                                        =
echo.       =                                                                                 =
echo.       =      6]   Instalar Seleccion de WindowsApps                                     =
echo.       =                                                                                 =
echo.       =      7]   Instalar Codec de Video HEVC (H.265) Actializado                      =
echo.       =                                                                                 =
echo.       =      8]   Instalar Office 2021 (sin-licencia)                                   =
echo.       =                                                                                 =
echo.       =      9]   Activar Viejo Visor de Fotos                                          =
echo.       =                                                                                 =
echo.       =      10]  Agregar capa de seguridad al Sistema contra Ejecucion de Malware      =
echo.       =                                                                                 =
echo.       =      11]  Quitar capa de seguridad al Sistema contra Ejecucion de Malware       =
echo.       =                                                                                 =
echo.       =      12]  Deshabilitar Todas las Extensiones Webs (Chrome y Edge)               =
echo.       =                                                                                 =
echo.       =      13]  Actualizar Todas las Aplicaciones Disponibles del Sistema             =
echo.       =                                                                                 =
echo.       =      14]  Instalar PowerToys                                                    =
echo.       =                                                                                 =
echo.       =      15]  Recuperar Archivos Borrados                                           =
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
    @REM sin restricciones de política crea un punto de restauración del sistema, de modo que si algo sale mal, la computadora no se ve afectada
    echo Creando un punto de Restauracion
    powershell -ExecutionPolicy Bypass -NoExit -Command "Checkpoint-Computer -Description "FixItRestorePoint" -RestorePointType "MODIFY_SETTINGS""& powershell exit
    echo.
    @REM sc stop "Name of Service"
    @REM sc config "Name of Service" start= disabled
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
    pause
    goto tl4
)
if "%tool%" == "2" (
    @REM Desinstale las aplicaciones indicadas automáticamente con todos los permisos necesarios.
    echo.
    WMIC product get name
    echo.
    echo. Copie y pegue debajo del nombre de la aplicacion que se muestra en la lista superior para desinstalarla
    echo.
    echo. ADVERTENCIA
    echo. 
    echo. Esta apunto de eliminar la aplicacion especificada. Esta accion es irreversible. Estas seguro de que quieres continuar?
    set /p ans.4op3="Esta de acuerdo?[S/N]"
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
    @REM Desinstale las aplicaciones propiedad del sistema indicadas automáticamente con todos los permisos necesarios.
    echo.
    POWERSHELL "Get-AppxPackage | Select Name, PackageFullName"
    echo.
    echo. "Copie y pegue debajo del nombre de la aplicacion que se muestra en la lista superior(derecha) para desinstalarla"
    echo.
    echo. ADVERTENCIA
    echo. 
    echo. Esta apunto de eliminar la aplicacion especificada. Esta accion es irreversible. Estas seguro de que quieres continuar?
    set /p ans.4op4="Esta de acuerdo?[S/N]"
    echo.
    if "%ans.4op4%" == "S" goto 4op4.next
    if "%ans.4op4%" == "s" goto 4op4.next
    if "%ans.4op4%" == "N" goto tl4
    if "%ans.4op4%" == "n" goto tl4
    goto tl4
    :4op4.next
    @REM estableció las políticas de ejecución en sin restricciones para poder manipular las aplicaciones del sistema sin inconvenientes
    PowerShell Set-ExecutionPolicy Unrestricted
    echo.
    set /p appak=APPID=
    @REM Por último se vuelve a colocar la restricción de ejecución ya que de lo contrario sería peligroso dejarla ilimitada ya que se podría instalar cualquier cosa en la computadora sin que lo sepas
    POWERSHELL Remove-AppxPackage "%appak%"
    echo.
    PowerShell Set-ExecutionPolicy Restricted
    set /p opt="Continuar o ir al menu? [C / M]"
    if "%opt%" == "c" goto 4op4.next
    if "%opt%" == "C" goto 4op4.next
    pause
    goto tl4
)
if "%tool%" == "4" (
    @REM descarga y ejecuta la herramienta de desinstalación de office, ya que muchas veces su desinstalador interno deja archivos y claves residuales que impiden la instalación de una nueva instancia.
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
)
if "%tool%" == "5" (
    echo.
    PowerShell Set-ExecutionPolicy Unrestricted
    @REM registra una nueva instalación de aplicación que tiene el instalador de Windows
    POWERSHELL "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register ""$($_.InstallLocation)\appxmanifest.xml"" -DisableDevelopmentMode}"
    REM Add-AppxPackage : Error de implementación con HRESULT: 0x80073D02, No se pudo instalar el paquete porque los recursos que modifica están actualmente en uso.
    REM si sale el mensaje anterior, entonces el comando se ejecuto con exito
    PowerShell Set-ExecutionPolicy Restricted
    echo.
    echo. Instalacion exitosa
    pause
    goto tl4
)
if "%tool%" == "6" (
    echo.
    POWERSHELL Set-ExecutionPolicy Unrestricted
    echo.
    @REM muestra una lista de aplicaciones que tiene disponibles para instalar
    POWERSHELL "Get-AppxPackage -AllUsers | Select Name, PackageFullName"
    echo.
    echo "Elija la aplicacion a instalar de la lista, y copie y pegue a continuacion, el codigo de identificacion del producto (columna derecha)"
    echo    En algunos casos, es necesario reiniciar para que surta efecto.
    set /p appname=APPID=
    POWERSHELL "Add-AppxPackage -Register 'C:\Program Files\WindowsApps\%appname%\appxmanifest.xml' -DisableDevelopmentMode"
    POWERSHELL Set-ExecutionPolicy Restricted
    pause
    goto tl4
)
if "%tool%" == "7" (
    @REM descargue e instale los controladores de video más recientes con una solicitud web, esto se debe a que muchas personas usan formatos que no son reconocidos de forma nativa por el sistema, para facilitar su instalación
    POWERSHELL Invoke-WebRequest -Uri "https://free-codecs.com/download_soft.php?d=0c6f463b2b5ba2af6c8e5f8c55ed5243&s=1024&r=&f=hevc_video_extension.htm" -OutFile "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx" "%~p0"
    cd "%~p0"
    start Microsoft.HEVCVideoExtensionx64.Appx
    echo Listo, ejecute el Setup.exe y su programa se instalara.
    pause
    goto tl4
)
if "%tool%" == "8" (
    @REM Desde los servidores de Microsoft descarga una iso ofimática con una versión de prueba, y si el usuario tiene una licencia activa todas las funcionalidades
    POWERSHELL Invoke-WebRequest -Uri "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img" -OutFile "C:\Users\%username%\Downloads\ProPlus2021Retail.img"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
    cd "%~p0"
    start ProPlus2021Retail.img
    echo Listo, ejecute el Setup.exe y su programa se instalara.
    pause
    goto tl4
)
if "%tool%" == "9" (
    @REM activa todas las claves de registro necesarias para ejecutar el antiguo visor de Windows que tiene un rendimiento sorprendente
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d 00000001 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%SystemRoot%\System32\imageres.dll,-70" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "\"%SystemRoot%\System32\cmd.exe\" /c \"\"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll\" \"%1\"\"" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d 00010000 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d 00000001 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
    pause
    goto tl4
)
if "%tool%" == "10" (
    echo. Capa de Seguridad Habilitada
    @REM estableció la configuración del registro de privacidad de ejecución en habilitado
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 1 /f
    echo. Listo...
    pause
    goto tl4
)
if "%tool%" == "11" (
    echo. Capa de Seguridad Deshabilitada
    @REM estableció la configuración de registro de la sección de privacidad de ejecución en deshabilitada
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f
    echo. Listo...
    pause
    goto tl4
)
if "%tool%" == "12" (
    echo.
    @REM ejecuta comandos internos del navegador para deshabilitar extensiones debido a bloqueos, errores o conflictos
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-extensions
    "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-extensions
    echo.
    pause
    goto tl4
)
if "%tool%" == "13" (
    echo.
    @REM winget busca en la lista de aplicaciones instaladas las actualizaciones disponibles, si las encuentra las instala automáticamente
    POWERSHELL winget upgrade --all
    echo.
    pause
    goto tl4
)
if "%tool%" == "14" (
    echo.
    POWERSHELL winget install --id Microsoft.PowerToys
    echo.
    pause
    goto tl4
)
if "%tool%" == "15" (
    echo.
    set /p inst="Tienes 'Windows File Recovery' instalado? [S/n]"
    if "%inst%" == "s" goto continue
    if "%inst%" == "S" goto continue
    if "%inst%" == "" goto continue
    :install
    start https://apps.microsoft.com/store/detail/windows-file-recovery/9N26S50LN705
    pause
    :continue
    echo.
    set /p search="Ubicacion para Buscar:[C://...] "
    set /p save="Ubicacion para Guardar los Encontrado:[C://...] "
    set /p filters="Filtros[/n ''user\<username>\download'' /n ''*.pdf''] "
    @REM escanea el disco en busca de archivos eliminados donde el usuario indica en el filtro
    winfr "%search%" "%save%" /regular %filters%
    echo.
    pause
    goto tl4
)
else (
    goto tl4
)