@echo off
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
color 17
title FixIt

REM FINISH:   
REM TESTED:   

:ini
cls

echo.
echo.
echo.
echo.       ===================================================================================
echo.       =                                       FIXTOOL                                   =
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
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Para Cerrar el programa pulse el numero 0
echo.               de lo contrario muchos archivos temporales quedaran en su equipo.
echo.
echo.
echo.


set /p tool=Opcion =   

if "%tool%" == "0" goto exit
if "%tool%" == "1" goto tl1
if "%tool%" == "2" goto tl2
if "%tool%" == "3" goto tl3
if "%tool%" == "4" goto tl4
if "%tool%" == "5" goto tl5

if not "%tool%" == "0, 1, 2, 3, 4 or 5" goto ini

:tl1
cls

echo.
echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS PARA REPARAR SO                         =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Comprobacion de archivos del sistema                                  =
echo.       =                                                                                 =
echo.       =      2]   Comprobar archivos de reparacion                                      =
echo.       =                                                                                 =
echo.       =      3]   Restauracion de la imagen                                             =
echo.       =                                                                                 =
echo.       =      4]   Analisis de la estructura de datos en el disco                        =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio

set /p tool=Opcion =   

if "%tool%" == "0" goto ini
if "%tool%" == "1" goto 1op1
if "%tool%" == "2" goto 1op2
if "%tool%" == "3" goto 1op3
if "%tool%" == "4" goto 1op4
if not "%tool%" == "0, 1, 2, 3 or 4" goto tl1

:1op1
echo.
echo.
echo.
sfc /scannow
echo.
echo.
pause
echo.
goto tl1

:1op2
echo.
echo.
echo.
DISM /Online /Cleanup-Image /CheckHealth
echo.
echo.
DISM /Online /Cleanup-Image /ScanHealth
echo.
echo.
pause
echo.
goto tl1

:1op3
echo.
echo.
echo.
DISM /Online /Cleanup-Image /StartComponentCleanup
echo.
echo.
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo.
pause
echo.
goto tl1

:1op4
echo.
echo.
echo.
chkdsk C: /F /R
echo.
echo Es necesario reiniciar, Guarde todo antes de continuar
pause
shutdown /r
pause>NUL
goto exit


:tl2
cls

echo.
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
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio

set /p tool=Opcion =   

if "%tool%" == "0" goto ini
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


:tl3

echo.
echo.
echo.
sfc /scannow
echo.
echo.
DISM /Online /Cleanup-Image /CheckHealth
echo.
echo.
DISM /Online /Cleanup-Image /ScanHealth
echo.
echo.
DISM /Online /Cleanup-Image /StartComponentCleanup 
echo.
pause
goto ini


:tl4
cls

echo.
echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS DE PROGRAMAS                            =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Limpieza del Sistema                                                  =
echo.       =                                                                                 =
echo.       =      2]   Detener Servicios Innecesarios                                        =
echo.       =                                                                                 =
echo.       =      3]   Desinstalar Aplicaciones                                              =
echo.       =                                                                                 =
echo.       =      4]   Desinstalar Aplicaciones de Windows                                   =
echo.       =                                                                                 =
echo.       =      5]   Instalar Todas las WindowsApps                                        =
echo.       =                                                                                 =
echo.       =      6]   Instalar Seleccion de WindowsApps                                     =
echo.       =                                                                                 =
echo.       =      7]   Activador de Windows                                                  =
echo.       =                                                                                 =
echo.       =      8]   Activador de Office 2021                                              =
echo.       =                                                                                 =
echo.       =      9]   Limpiar Windows Defender                                              =
echo.       =                                                                                 =
echo.       =     10]   Editar tiempo del Historial de WinDefender (30d, predefinido)         =
echo.       =                                                                                 =
echo.       =     11]   Desinstalar Clave de Windows                                          =
echo.       =                                                                                 =
echo.       =     12]   Desinstalar Clave de Office                                           =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio

set /p tool=Opcion =   

if "%tool%" == "0" goto ini
if "%tool%" == "1" goto 4op1
if "%tool%" == "2" goto 4op2
if "%tool%" == "3" goto 4op3
if "%tool%" == "4" goto 4op4
if "%tool%" == "5" goto 4op5
if "%tool%" == "6" goto 4op6
if "%tool%" == "7" goto 4op7
if "%tool%" == "8" goto 4op8
if "%tool%" == "9" goto 4op9
if "%tool%" == "10" goto 4op10
if "%tool%" == "11" goto 4op11
if "%tool%" == "12" goto 4op12
if not "%tool%" == "12" goto tl4

:4op1
echo.
echo.
echo.
echo Guarde y Cierre todo antes de continuar
pause
del C:\Users\%username%\AppData\Local\Temp /f /s /q
rd C:\Users\%username%\AppData\Local\Temp /s /q
del C:\Windows\Temp /f /s /q
rd C:\Windows\Temp /s /q
CLEANMGR /D C:
POWERSHELL Get-DnsClientCache
POWERSHELL Clear-DnsClientCache
pause
goto tl4

:4op2
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

:4op3
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
if not "%ans.4op3%" == "S, s, N or n" goto ini
REM Para que se pueda desinstalar es necesario que el programa contenga un uninstaller en su carpeta de datos && Hay programas que no lo integran al completo por lo que no es posible por esta via desintalarlo
:4op3.next
set /p produn=AppUni=
WMIC product where name="%produn%" call uninstall
echo.
pause
goto tl4

:4op4
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
if not "%ans.4op4%" == "S, s, N or n" goto ini
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

:4op5
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

:4op6
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

:4op7
echo.
echo.
echo.
winver
set /p verwin=Que version de windows tienes(SOLO PARA WIN10 Y WIN11),  Home, Professional, Education o Entrerprise?[H/P/ED/EN]=
if "%verwin%" == "H" goto win.Home
if "%verwin%" == "h" goto win.Home
if "%verwin%" == "P" goto win.Pro
if "%verwin%" == "p" goto win.Pro
if "%verwin%" == "ED" goto win.Edu
if "%verwin%" == "Ed" goto win.Edu
if "%verwin%" == "eD" goto win.Edu
if "%verwin%" == "ed" goto win.Edu
if "%verwin%" == "EN" goto win.Enter
if "%verwin%" == "En" goto win.Enter
if "%verwin%" == "eN" goto win.Enter
if "%verwin%" == "en" goto win.Enter
if not "%verwin%" == "H, h, P, p, E or e" goto tl4
:win.Home
set key=TX9XD-98N7V-6WMQ6-BX7FG-H8Q99
goto b5.act
:win.Pro
set key=W269N-WFGWX-YVC9B-4J6C9-T83GX
goto b5.act
:win.Edu
set key=NW6C2-QMPVW-D7KKK-3GKT6-VCFB2
goto b5.act
:win.Enter
set key=NPPR9-FWDCX-D2C8J-H872K-2YT43
goto b5.act
:b5.act
slmgr /ipk %key%
timeout 3
slmgr /skms kms.digiboy.ir
timeout 3
slmgr /ato
timeout 5
pause
goto tl4

:4op8
echo.
echo Activando su Office 2021, Espere!
cd /d %ProgramFiles%\Microsoft Office\Office16
for /f %x in ('dir /b ..\root\Licenses16\ProPlus2021VL_KMS*.xrm-ms') do cscript ospp.vbs /inslic:"..\root\Licenses16\%x"
cscript ospp.vbs /setprt:1688
cscript ospp.vbs /unpkey:6F7TH >nul
cscript ospp.vbs /inpkey:FXYTK-NJJ8C-GB6DW-3DYQT-6F7TH
cscript ospp.vbs /sethst:s8.uk.to
cscript ospp.vbs /act
echo Listo!
pause
goto tl4

:4op9
echo.
cd C:\ProgramData\Microsoft\Windows Defender\Scans\History
DEL Service /f /s /q
RD Service /s /q
MD Service
pause
goto tl4

:4op10
echo.
echo Cuanto tiempo desea definir como limite para que se borre periodicamente el historial de windows Defender. Especifiquelo en Dias (SOLO CON NUMEROS)
set /p tiemp=
echo. 
echo.
echo. Usted eligio %tiemp% Dias!
POWERSHELL Set-MpPreference -ScanPurgeItemsAfterDelay %tiemp%
echo. Listo!
pause
goto tl4

:4op11
echo.
echo Desintalando Clave de activacion de Windows, Espere!
cscript slmgr.vbs /upk&cscript slmgr.vbs /cpky
echo Listo!
pause
goto tl4

:4op12
echo.
echo Desintalando Clave de activacion de Office, Espere!
cd /d %ProgramFiles%\Microsoft Office\Office16
echo copiar: Last 5 characters of intalled product key:***** <---- COPIAR SOLO ESO
set /p unpkey=
echo.
cscript "%ProgramFiles%\Microsoft Office\Office16\ospp.vbs" /unpkey:%unpkey%
echo.
echo Listo!
pause
goto tl4


:tl5
cls

echo.
echo.
echo.
echo.       ===================================================================================
echo.       =                            HERRAMIENTAS ADICIONALES                             =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Office 2021 Installer                                                 =
echo.       =                                                                                 =
echo.       =      2]   Viejo Visor de Fotos                                                  =
echo.       =                                                                                 =
echo.       =      3]   Codec de Audio Actializado                                            =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio

set /p tool=Opcion =   

if "%tool%" == "0" goto ini
if "%tool%" == "1" goto 5op1
if "%tool%" == "2" goto 5selop
if "%tool%" == "3" goto 5selop
if not "%tool%" == "3" goto tl5

:5op1
start https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img
pause
MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
cd %~p0
start ProPlus2021Retail.img
echo Listo, ejecute el Setup.exe y su programa se instalara.
pause
goto tl5

:5selop
start https://drive.google.com/uc?id=1UWrNule5gi1Q5tkcKqO34zlLgtZP35gw
pause
MOVE "C:\Users\%username%\Downloads\otherTools.zip" "%~p0"
cd %~p0
tar -xf otherTools.zip
DEL otherTools.zip
if "%tool%" == "2" goto 5op2
if "%tool%" == "3" goto 5op3

:5op2
cd %~p0&cd otherTools
start visualphotos.reg
pause
goto tl5

:5op3
cd %~p0&cd otherTools
POWERSHELL "Add-AppxPackage Microsoft.HEVCVideoExtension_1.0.42701.0_x64__8wekyb3d8bbwe.Appx"
pause
goto tl5


:exit
cd %~p0
DEL office.exe
DEL otherTools /f /s /q
RD  otherTools /s /q
exit