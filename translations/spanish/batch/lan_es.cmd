:tl2
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS DE INTERNET                             =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Limpieza del DNS interno                                              =
echo.       =                                                                                 =
echo.       =      2]   Testeo de DNS's                                                       =
echo.       =                                                                                 =
echo.       =      3]   Selector de DNS interno                                               =
echo.       =                                                                                 =
echo.       =      4]   Ver Contrasegna de Wifi's                                             =
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
    @REM limpiar la caché permite solucionar problemas de mal almacenamiento de la misma, y en ocasiones al tener demasiados elementos almacenados en caché el sistema se ralentiza
    echo.
    echo.
    echo.
    POWERSHELL Get-DnsClientCache
    echo.
    echo.
    POWERSHELL Clear-DnsClientCache
    echo.
    echo.
    pause
    goto tl2
)
if "%tool%" == "2" (
    @REM hacer ping a diferentes puntos DNS le permite ver con cuál tiene menos latencia y pérdida de datos, para que pueda asignarlo automáticamente más tarde.
    echo.
    echo Google DNS
    ping 8.8.8.8
    echo.
    ping 8.8.4.4
    echo.
    echo.
    echo CloudFire DNS
    ping 1.1.1.1
    echo.
    ping 1.0.0.1
    echo.
    echo.
    echo Open DNS
    ping 208.67.222.222
    echo.
    ping 208.67.220.220
    echo.
    echo.
    pause
    goto tl2
)
if "%tool%" == "3" (
    @REM indica y asigna los dns más rápidos para tu conexión y configúralos en tu puerto de red
    echo.
    echo.
    echo.
    netsh interface show interface
    echo.
    echo.
    set /p Red= Indique el nombre de la interfaz para aplicar el cambio de DNS =   
    echo.
    echo.
    set /p DNS1= Indique el DNS mas rapido que desea aplicar =   
    echo.
    echo.
    set /p DNS2= Indique el segundo DNS mas rapido que desea aplicar =   
    echo.
    echo.
    @REM netsh es un paquete de comandos para administrar redes informáticas
    netsh interface ipv4 set dnsservers "%Red%" static "%DNS1%" primary
    netsh interface ipv4 add dnsservers "%Red%" "%DNS2%" index=2
    echo.
    echo Listo!
    echo.
    pause
    goto tl2
)
if "%tool%" == "4" (
    goto axw
    :vlt
    echo.
    echo Listo!
    echo.
    pause
    goto tl2
)
else (
    goto tl2
)
@REM se separo del contenedor debido a que ahí no se ejecutaba la creacion de una variable
:axw
netsh wlan show profile
echo.
set /p wifi= Wifi = 
echo.
pause
echo.
@REM muestra una lista de perfiles de red que almacenan una contraseña
netsh wlan show profile name="%wifi%" key=clear
pause
goto vlt