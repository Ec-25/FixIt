:tl5
cls

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
echo.       ===================================================================================
echo.                                             by JuanchoWolf
echo.           ADVERTENCIA! Pulse 0 para volver al Inicio
echo.

set /p tool=Opcion =   

if "%tool%" == "0" goto salir
if "%tool%" == "off" goto 5op1
if "%tool%" == "1" goto 5op2
if "%tool%" == "2" goto 5op3
if "%tool%" == "3" goto 5op4
if "%tool%" == "4" goto 5op5
if "%tool%" == "5" goto 5op6
if "%tool%" == "6" goto 5op7
if "%tool%" == "7" goto 5op7Ds
if not "%tool%" == "7" goto tl5

:5op1
start https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img
pause
MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
cd %~p0
start ProPlus2021Retail.img
echo Listo, ejecute el Setup.exe y su programa se instalara.
pause
goto tl5

:5op2
cd %~p0&cd tools
start visualphotos.reg
pause
goto tl5

:5op3
start ms-windows-store://pdp/?ProductId=9n4wgh0z6vhq
pause
goto tl5

:5op4
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
mbr2gpt /validate /disk:%disk% /allowFullOS
echo.
set /p valid=Solo! si el Proceso no fallo. Continue [1-Continuar ; 0-Salir]:
if "%valid%" == "1" goto 5op4b
if not "%valid%" == "1" goto salir

:5op4b
mbr2gpt /convert /disk:%disk% /allowFullOS
echo.
echo. REINICIANDO...
echo. Acceda a BIOS y habilite SecureBoot
shutdown /r /t 60
exit

:5op5
cls
echo.
echo. Sistema de eliminacion de software malintencionado
echo. __________________________________________________
mrt
echo.
goto tl5

:5op6
cd %~p0&cd tools
start watermark.reg
echo. Para que los cambios surtan efecto, reinicia el equipo
echo. Listo...
goto tl5

:5op7
cd %~p0&cd tools
echo. Capa de Seguridad Habilitada
start capa-seguridad-Enabled.reg
echo. Listo...
goto tl5

:5op7Ds
cd %~p0&cd tools
echo. Capa de Seguridad Deshabilitada
start capa-seguridad-Disabled.reg
echo. Listo...
goto tl5

:salir
cd "%~p0"
cd..
main.cmd