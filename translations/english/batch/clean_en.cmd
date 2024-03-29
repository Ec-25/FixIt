:tll
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                                 CLEANING TOOLS                                  =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   System Cleanup                                                        =
echo.       =                                                                                 =
echo.       =      2]   Clear Event Viewer                                                    =
echo.       =                                                                                 =
echo.       =      3]   Clean Windows Defender                                                =
echo.       =                                                                                 =
echo.       =      4]   Edit Windows Defender History time (30d, default)                     =
echo.       =                                                                                 =
echo.       =      5]   Remove Watermark from Windows (10 and 11)                             =
echo.       =                                                                                 =
echo.       =      6]   Clear Recent Files List                                               =
echo.       =                                                                                 =
echo.       =      0]   Exit                                                                  =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by Ec25
echo.
echo.

set /p tool=Option =   

if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main_en.cmd
)
if "%tool%" == "1" (
    echo.
    @REM deletes the temp folder silently; both local and Windows. At the same time, it runs the internal window cleaner and also cleans the dns cache.
    echo Save and Close everything before continuing
    pause
    @REM Temp
    echo.
    del C:\Users\"%username%"\AppData\Local\Temp /f /s /q
    del C:\Users\"%username%"\AppData\Local\IconCache.db /f /s /q
    rd C:\Users\"%username%"\AppData\Local\Temp /s /q
    echo.
    del C:\Windows\Temp /f /s /q
    rd C:\Windows\Temp /s /q
    @REM Dns
    echo.
    CLEANMGR /D C:
    POWERSHELL Get-DnsClientCache
    POWERSHELL Clear-DnsClientCache
    @REM Papelera
    rd /s /q "%userprofile%"\RecycleBin
    echo.
    mkdir "%userprofile%"\RecycleBin
    pause
    goto tll
)
if "%tool%" == "2" (
    echo Clearing Event Viewer logs...
    @REM wevtutil is a set of system instructions that allow you to read, modify, and delete event logs and posts.
    @REM with "cl" clears all event logs (application, security, system)
    wevtutil.exe cl Application
    wevtutil.exe cl Security
    wevtutil.exe cl System
    echo Event Viewer logs successfully removed.
    pause
    goto tll
)
if "%tool%" == "3" (
    echo.
    @REM delete the content and service folder silently to clear the history of actions.
    cd C:\ProgramData\Microsoft\Windows Defender\Scans\History
    DEL Service /f /s /q
    RD Service /s /q
    MD Service
    pause
    goto tll
)
if "%tool%" == "4" (
    echo.
    echo "How much time should you define as a limit so that the history of Windows Defender is periodically deleted. Specify it in Days (ONLY WITH NUMBERS)"
    set /p time=
    echo. 
    echo.
    echo. you chose "%time%" Days!
    @REM runs a custom PowerShell command, setting the preference to scan items after the requested days in %time%
    POWERSHELL Set-MpPreference -ScanPurgeItemsAfterDelay "%time%"
    echo. Done!
    pause
    goto tll
)
if "%tool%" == "5" (
    @REM adds the registry key in currentVersion/Windows/ called "DisplayNotRet" with value 0. to tell Windows not to draw the version watermark on the screen.
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v "DisplayNotRet" /t REG_DWORD /d "0" /f
    echo. For the changes to take effect, restart the computer
    echo. Done...
    pause
    goto tll
)
if "%tool%" == "6" (
    echo.
    @REM removes the RecentDocs keys to clear the list of recently opened files from explorer
    REG DELETE "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f
    echo. Done...
    pause
    goto tll
)
else (
    goto tll
)