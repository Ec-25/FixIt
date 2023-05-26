@REM shortcuts from the Tools tab of msconfig, to facilitate their access since not many know this section

:tl7
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                               SHORTCUTS                                         =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   About Windows                                                         =
echo.       =                                                                                 =
echo.       =      2]   Change UAC Settings                                                   =
echo.       =                                                                                 =
echo.       =      3]   Security and Maintenance                                              =
echo.       =                                                                                 =
echo.       =      4]   Windows Troubleshooting                                               =
echo.       =                                                                                 =
echo.       =      5]   Computer Management                                                   =
echo.       =                                                                                 =
echo.       =      6]   System Information                                                    =
echo.       =                                                                                 =
echo.       =      7]   Event Viewer                                                          =
echo.       =                                                                                 =
echo.       =      8]   Programs                                                              =
echo.       =                                                                                 =
echo.       =      9]   System Properties                                                     =
echo.       =                                                                                 =
echo.       =     10]   Internet Options                                                      =
echo.       =                                                                                 =
echo.       =     11]   Internet Protocol Configuration                                       =
echo.       =                                                                                 =
echo.       =     12]   Performance Monitor                                                   =
echo.       =                                                                                 =
echo.       =     13]   Resource Monitor                                                      =
echo.       =                                                                                 =
echo.       =     14]   Task Manager                                                          =
echo.       =                                                                                 =
echo.       =     15]   Registry Editor                                                       =
echo.       =                                                                                 =
echo.       =     16]   System Restore                                                        =
echo.       =                                                                                 =
echo.       =     17]   System Configuration                                                  =
echo.       =                                                                                 =
echo.       =     18]   DirectX Diagnostic Tool                                               =
echo.       =                                                                                 =
echo.       =     19]   Microsoft Malicious Software Removal                                  =
echo.       =                                                                                 =
echo.       =      0]   Exit                                                                  =
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