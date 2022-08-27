:tl2
cls

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
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio

set /p tool=Opcion =   

if "%tool%" == "0" goto salir
if "%tool%" == "1" goto 2op1
if "%tool%" == "2" goto 2op2
if "%tool%" == "3" goto 2op3
if not "%tool%" == "0, 1, 2 or 3" goto tl2

:2op1
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

:2op2
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

:2op3
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
netsh interface ipv4 set dnsservers %Red% static %DNS1% primary
netsh interface ipv4 add dnsservers %Red% %DNS2% index=2
echo.
echo Listo!
echo.
pause
goto tl2

:salir
cd "%~p0"
cd..
main.bat