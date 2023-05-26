:tl2
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                                 WEB TOOLS                                       =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Internal DNS cleanup                                                  =
echo.       =                                                                                 =
echo.       =      2]   DNS testing                                                           =
echo.       =                                                                                 =
echo.       =      3]   Internal DNS selector                                                 =
echo.       =                                                                                 =
echo.       =      4]   View WiFi Password                                                    =
echo.       =                                                                                 =
echo.       =      0]   Exit                                                                  =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.
echo.

set /p tool=Option =   

if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main.cmd
)
if "%tool%" == "1" (
    @REM cleaning the cache allows you to solve problems of bad storage of the same, and on occasions when having too many elements stored in cache the system slows down
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
    @REM pinging different DNS points allows you to see which one you have the least latency and data loss with, so you can automatically assign it later.
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
    @REM indicate and assign the fastest dns for your connection and set them in your network port
    echo.
    echo.
    echo.
    netsh interface show interface
    echo.
    echo.
    set /p Red= Indicate the name of the interface to apply the DNS change =   
    echo.
    echo.
    set /p DNS1= Indicate the fastest DNS you want to apply =   
    echo.
    echo.
    set /p DNS2= Indicate the second fastest DNS you want to apply =   
    echo.
    echo.
    @REM netsh is a command package to manage computer networks
    netsh interface ipv4 set dnsservers "%Red%" static "%DNS1%" primary
    netsh interface ipv4 add dnsservers "%Red%" "%DNS2%" index=2
    echo.
    echo Done!
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
REM it was separated from the container because the creation of a variable was not executed there
:axw
netsh wlan show profile
echo.
set /p wifi= Wifi = 
echo.
pause
echo.
@REM displays a list of network profiles that store a password
netsh wlan show profile name="%wifi%" key=clear
pause
goto vlt