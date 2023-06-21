:tl5
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                        EXTERNAL PROGRAM TOOLS                                   =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Open Hardware Monitor                                                 =
echo.       =                                                                                 =
echo.       =      2]   AutoRuns                                                              =
echo.       =                                                                                 =
echo.       =      3]   Process Explorer                                                      =
echo.       =                                                                                 =
echo.       =      0]   Exit                                                                 =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.       WARNING:    None of these programs are owned by me.
echo.                       It is Open Source Software collected from the Internet from its official sources..
echo.                           Run at your own risk.
echo.
echo.

set /p tool=Opcion =   

if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main_en.cmd
)
if "%tool%" == "1" (
    @REM check that there are no such files in the program directory so as not to download them again
    if not exist "tools\OpenHardwareMonitor" (
        @REM if it doesn't exist, invoke a web request from powershell and get the .zip extension package, extracting it to the directory folder so it can be managed
        POWERSHELL Invoke-WebRequest -Uri "https://openhardwaremonitor.org/files/openhardwaremonitor-v0.9.6.zip" -OutFile "ohm.zip"
        timeout 5
        @REM Expand Archive allows you to manipulate compressed files with the .zip extension
        POWERSHELL Expand-Archive -Path ohm.zip
        CD ohm
        MOVE "OpenHardwareMonitor" "%~p0\tools"
        cd..
        RMDIR /S /Q ohm
        DEL ohm.zip
    )
    cd "tools\OpenHardwareMonitor"
    start OpenHardwareMonitor.exe
    echo.
    echo.
    echo Done
    cd..
    cd..
    goto tl5
)
if "%tool%" == "2" (
    if not exist "tools\Autoruns" (
        POWERSHELL Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Autoruns.zip" -OutFile "Autoruns.zip"
        timeout 5
        POWERSHELL Expand-Archive -Path Autoruns.zip
        MOVE "Autoruns" "tools"
        DEL Autoruns.zip
    )
    cd "tools\Autoruns"
    start Autoruns64.exe
    echo.
    echo.
    echo Done
    cd..
    cd..
    goto tl5
)
if "%tool%" == "3" (
    if not exist "tools\ProcessExplorer" (
        POWERSHELL Invoke-WebRequest -Uri "https://download.sysinternals.com/files/ProcessExplorer.zip" -OutFile "ProcessExplorer.zip"
        timeout 5
        POWERSHELL Expand-Archive -Path ProcessExplorer.zip
        MOVE "ProcessExplorer" "tools"
        DEL ProcessExplorer.zip
    )
    cd "tools\ProcessExplorer"
    start procexp64.exe
    echo.
    echo.
    echo Done
    cd..
    cd..
    goto tl5
)
else (
    goto tl5
)