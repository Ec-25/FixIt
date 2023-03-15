:tl6
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS ADICIONALES                             =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Viejo Visor de Fotos                                                  =
echo.       =                                                                                 =
echo.       =      2]   Codec de Video HEVC (H.265) Actializado                               =
echo.       =                                                                                 =
echo.       =      3]   Convertir Disco MBR a GPT (no recomendado)                            =
echo.       =                                                                                 =
echo.       =      4]   Analisis Antimalware                                                  =
echo.       =                                                                                 =
echo.       =      5]   Quitar Marca de agua de Windows (10 y 11)                             =
echo.       =                                                                                 =
echo.       =      6]   Agregar capa de seguridad al Sistema contra Ejecucion de Malware      =
echo.       =                                                                                 =
echo.       =      7]   Quitar capa de seguridad al Sistema contra Ejecucion de Malware       =
echo.       =                                                                                 =
echo.       =      8]   Instalar Office 2021 (sin-licencia)                                   =
echo.       =                                                                                 =
echo.       =      0]   Salir                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.
echo.

set /p tool=Opcion =   

if "%tool%" == "0" (
    goto salir
)
if "%tool%" == "1" (
    cd "%~p0&\tools"
    start visualphotos.reg
    pause
    cd..
    goto tl6
)
if "%tool%" == "2" (
    REM free-codecs.com/download/hevc_video_extension.htm
    POWERSHELL Invoke-WebRequest -Uri "https://free-codecs.com/download_soft.php?d=0c6f463b2b5ba2af6c8e5f8c55ed5243&s=1024&r=&f=hevc_video_extension.htm" -OutFile "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx" "%~p0"
    cd %~p0
    start Microsoft.HEVCVideoExtensionx64.Appx
    echo Listo, ejecute el Setup.exe y su programa se instalara.
    pause
    goto tl6
)
if "%tool%" == "3" (
    cls
    echo.
    echo.   ADVERTENCIA...
    echo. La herramienta se diseno para ejecutarse desde un simbolo del sistema del Entorno de preinstalacion de Windows (Windows PE), pero tambien se puede ejecutar desde el sistema operativo (SO)
    echo.   IMPORTANTE...
    echo. Antes de intentar convertir el disco, asegurate de que el dispositivo admita UEFI.
    echo.
    echo. Despues de que el disco se haya convertido al estilo de particion GPT, el firmware se debe configurar para arrancar en modo UEFI.
    set /p confirm=Desea Continuar bajo su Responsabilidad?   [1-Continuar ; 0-Salir]
    if "%confirm%" == "1" goto 5op4a 
    if not "%confirm%" == "1" goto salir
    :5op4a
    DiskPart /s dp.cmd
    cd C:\Windows\System32
    echo.
    set /p disk=Indique el numero del disco a Convertir que NO sea GPT   
    mbr2gpt /validate /disk:"%disk%" /allowFullOS
    echo.
    set /p valid=Solo! si el Proceso no fallo. Continue [1-Continuar ; 0-Salir]:
    if "%valid%" == "1" goto 5op4b
    if not "%valid%" == "1" goto salir
    :5op4b
    mbr2gpt /convert /disk:"%disk%" /allowFullOS
    echo.
    echo. REINICIANDO...
    echo. Acceda a BIOS y habilite SecureBoot
    shutdown /r /t 60
    exit
)
if "%tool%" == "4" (
    cls
    echo.
    echo. Sistema de eliminacion de software malintencionado
    echo. __________________________________________________
    mrt
    echo.
    goto tl6
)
if "%tool%" == "5" (
    cd "%~p0&\tools"
    start watermark.reg
    echo. Para que los cambios surtan efecto, reinicia el equipo
    echo. Listo...
    cd..
    goto tl6
)
if "%tool%" == "6" (
    cd "%~p0&\tools"
    echo. Capa de Seguridad Habilitada
    start capa-seguridad-Enabled.reg
    echo. Listo...
    cd..
    goto tl6
)
if "%tool%" == "7" (
    cd %~p0&cd tools
    echo. Capa de Seguridad Deshabilitada
    start capa-seguridad-Disabled.reg
    echo. Listo...
    goto tl6
)
if "%tool%" == "8" (
    REM start https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img
    POWERSHELL Invoke-WebRequest -Uri "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img" -OutFile "C:\Users\%username%\Downloads\ProPlus2021Retail.img"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
    cd %~p0
    start ProPlus2021Retail.img
    echo Listo, ejecute el Setup.exe y su programa se instalara.
    pause
    goto tl6
) else ( 
    goto tl6 
)
:salir
cd "%~p0"
cd..
main.cmd