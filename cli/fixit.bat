@echo off
setlocal

:: Check administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 4f
    title FixIt requires ADMINISTRATOR PRIVILEGES
    echo The script is not running with administrative privileges.
    echo Please run the script as administrator.
    pause
    exit /b
)


:: Flags for parameterization
if "%1"=="" goto continue

if "%1"=="-H" goto help
if "%1"=="-help" goto help
if "%1"=="/?" goto help

if "%1"=="-R" (
    if "%2"=="-F" (
        goto repair_full
    ) else (
        goto repair
    )
)
if "%1"=="-repair" (
    if "%2"=="-F" (
        goto repair_full
    ) else (
        goto repair
    )
)
if "%1"=="-C" (
    if "%2"=="-F" (
        goto clean_full
    ) else (
        goto clean
    )
)
if "%1"=="-clean" (
    if "%2"=="-F" (
        goto clean_full
    ) else (
        goto clean
    )
)

echo flag "%1" not recognized

:help
:: Help method
echo Use: fixit.bat [-H / -R / -C] [-B / -F]
echo.
echo Command line options:
echo   -H   Displays the help screen with commands and usage.
echo   -R   Run the system repair block, if the level is not specified, the repair is basic.
echo   -C   Run the system cleanup block, if the level is not specified, the repair is basic.
echo   [-B / -F]   -B runs Basic mode, and -F runs Full mode of the selected tool.
echo.
echo How to use:
echo   Choose from the options shown in the menu to execute the desired function.
endlocal
exit /b

:repair
echo Running System File Check (sfc /scannow)...
echo This may take a few minutes, please wait.
sfc /scannow
if %errorlevel% neq 0 (
    echo ERROR: System File Check failed. Please check system logs.
)

echo Running DISM Health Scan...
echo Scanning the health of the system image (DISM /ScanHealth)...
DISM /Online /Cleanup-Image /ScanHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM ScanHealth failed. Please check system logs.
)

echo Checking system image health (DISM /CheckHealth)...
DISM /Online /Cleanup-Image /CheckHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM CheckHealth failed. Please check system logs.
)

pause
endlocal
exit /b

:repair_full
echo Running System File Check (sfc /scannow)...
echo This may take a few minutes, please wait.
sfc /scannow
if %errorlevel% neq 0 (
    echo ERROR: System File Check failed. Please check system logs.
)

echo Running DISM Health Scan...
echo Scanning the health of the system image (DISM /ScanHealth)...
DISM /Online /Cleanup-Image /ScanHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM ScanHealth failed. Please check system logs.
)

echo Checking system image health (DISM /CheckHealth)...
DISM /Online /Cleanup-Image /CheckHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM CheckHealth failed. Please check system logs.
)

echo Starting component cleanup (DISM /StartComponentCleanup)...
DISM /Online /Cleanup-Image /StartComponentCleanup
if %errorlevel% neq 0 (
    echo ERROR: DISM StartComponentCleanup failed. Please check system logs.
)

echo Restoring system image health (DISM /RestoreHealth)...
echo This may take several minutes, please wait.
DISM /Online /Cleanup-Image /RestoreHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM RestoreHealth failed. Please check system logs.
)

echo Defragmenting C: drive...
defrag C: /U /V

pause
endlocal
exit /b

:clean
echo WARNING: This operation will delete temporary files and system logs.
echo Files from the following locations will be deleted:
echo - %temp%
echo - C:\Windows\Temp
echo - C:\$Recycle.Bin
echo.
set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
if "%confirm%" == "0" (
    endlocal
    exit /b
)
if not "%confirm%" == "1" goto clean

:: Proceed with cleanup
echo Deleting temporary files...
DEL /f /q /s %temp%\*.*
DEL /f /q /s C:\Windows\Temp\*.*

echo Emptying recycle bin...
RD /q /s C:\$Recycle.Bin

:: Check if the command can be executed without errors
echo Running Disk Cleanup...
POWERSHELL -Command "Clear-DnsClientCache" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system does not support the DnsClient module for DNS caching or an error has occurred.
) else (
    echo DNS cache flushed successfully.
)

endlocal
exit /b

:clean_full
echo WARNING: This operation will delete temporary files and system logs.
echo Files from the following locations will be deleted:
echo - %temp%
echo - C:\Windows\Temp
echo - C:\$Recycle.Bin
echo - Recent files list
echo.
set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
if "%confirm%" == "0" (
    endlocal
    exit /b
)
if not "%confirm%" == "1" goto clean_full

:: Proceed with cleanup
echo Deleting temporary files...
DEL /f /q /s %temp%\*.*
DEL /f /q /s C:\Windows\Temp\*.*

echo Emptying recycle bin...
RD /q /s C:\$Recycle.Bin

:: Check if the command can be executed without errors
echo Running Disk Cleanup...
POWERSHELL -Command "Clear-DnsClientCache" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system does not support the DnsClient module for DNS caching or an error has occurred.
) else (
    echo DNS cache flushed successfully.
)

echo Clearing event logs...
wevtutil.exe cl Application
wevtutil.exe cl Security
wevtutil.exe cl System

echo Deleting recent file history...
DEL /f /q "%APPDATA%\Microsoft\Windows\Recent\*"

taskkill /f /im explorer.exe
start explorer.exe
endlocal
exit /b


:continue
color 17
title FixIt V2.1.7

:: If "%1" the process is executed in a way other than the maximized one, it starts a new minimized process and closes the process that was not maximized
:: if not "%1" == "max" start /MAX cmd /c %0 max & exit/b


:menu
cls
echo.
echo.       ===================================================================================
echo.       =                                      FIXIT                                      =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =        AUTO                                                                     =
echo.       =        s]     Quick Repair                                                      =
echo.       =                                                                                 =
echo.       =        c]     Quick Clean                                                       =
echo.       =                                                                                 =
echo.       =        t]     Scheduled Tasks                                                   =
echo.       =                                                                                 =
echo.       =        ADVANCED                                                                 =
echo.       =        1]     System Tools                                                      =
echo.       =                                                                                 =
echo.       =        2]     Web Tools                                                         =
echo.       =                                                                                 =
echo.       =        3]     Clean Tools                                                       =
echo.       =                                                                                 =
echo.       =        EXIT                                                                     =
echo.       =        0]     Go Out                                                            =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    endlocal
    exit /b
) else if "%option%"=="s" (
    goto quick_repair
) else if "%option%"=="c" (
    goto quick_clean
) else if "%option%"=="t" (
    goto scheduled_tasks
) else if "%option%"=="1" (
    goto system_tools
) else if "%option%"=="2" (
    goto web_tools
) else if "%option%"=="3" (
    goto cleaning_tools
)

goto menu


:quick_repair
echo Running System File Check (sfc /scannow)...
echo This may take a few minutes, please wait.
sfc /scannow
if %errorlevel% neq 0 (
    echo ERROR: System File Check failed. Please check system logs.
)

echo Running DISM Health Scan...
echo Scanning the health of the system image (DISM /ScanHealth)...
DISM /Online /Cleanup-Image /ScanHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM ScanHealth failed. Please check system logs.
)

echo Checking system image health (DISM /CheckHealth)...
DISM /Online /Cleanup-Image /CheckHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM CheckHealth failed. Please check system logs.
)

echo Starting component cleanup (DISM /StartComponentCleanup)...
DISM /Online /Cleanup-Image /StartComponentCleanup
if %errorlevel% neq 0 (
    echo ERROR: DISM StartComponentCleanup failed. Please check system logs.
)

echo Restoring system image health (DISM /RestoreHealth)...
echo This may take several minutes, please wait.
DISM /Online /Cleanup-Image /RestoreHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM RestoreHealth failed. Please check system logs.
)

echo Defragmenting C: drive...
defrag C: /U /V

pause
goto menu


:quick_clean
echo WARNING: This operation will delete temporary files and system logs.
echo Files from the following locations will be deleted:
echo - %temp%
echo - C:\Windows\Temp
echo - C:\$Recycle.Bin
echo - Recent files list
echo.
set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
if "%confirm%" == "0" goto menu
if not "%confirm%" == "1" goto quick_clean

:: Proceed with cleanup
echo Deleting temporary files...
DEL /f /q /s %temp%\*.*
DEL /f /q /s C:\Windows\Temp\*.*

echo Emptying recycle bin...
RD /q /s C:\$Recycle.Bin

echo Running Disk Cleanup...
CLEANMGR /D C: /sagerun:65535

:: Check if the command can be executed without errors
echo Running Disk Cleanup...
POWERSHELL -Command "Clear-DnsClientCache" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system does not support the DnsClient module for DNS caching or an error has occurred.
) else (
    echo DNS cache flushed successfully.
)

echo Clearing event logs...
wevtutil.exe cl Application
wevtutil.exe cl Security
wevtutil.exe cl System

echo Deleting recent file history...
DEL /f /q "%APPDATA%\Microsoft\Windows\Recent\*"

taskkill /f /im explorer.exe
start explorer.exe
pause
goto menu

:scheduled_tasks
cls
echo.
echo.       ===================================================================================
echo.       =                               Scheduled Tasks                                   =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Repair System Monthly                                                 =
echo.       =                                                                                 =
echo.       =      2]   Clean The System Monthly                                              =
echo.       =                                                                                 =
echo.       =      0]   Go Back                                                               =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    goto menu
) else if "%option%"=="1" (
    schtasks /create /tn "Fixit.AutoRepair" /tr "%~dp0fixit.bat -R -B" /sc "monthly" /d 1 /st "12:00" /ru %USERNAME% /F
    :: Check if the task was created correctly
    if %errorlevel% equ 0 (
        echo Scheduled task created successfully.
    ) else (
        echo Error creating scheduled task.
    )
) else if "%option%"=="2" (
    schtasks /create /tn "Fixit.AutoClean" /tr "%~dp0fixit.bat -C -B" /sc "monthly" /d 1 /st "12:00" /ru %USERNAME% /F
    :: Check if the task was created correctly
    if %errorlevel% equ 0 (
        echo Scheduled task created successfully.
    ) else (
        echo Error creating scheduled task.
    )
)

goto scheduled_tasks


:cleaning_tools
cls
echo.
echo.       ===================================================================================
echo.       =                                 CLEANING TOOLS                                  =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   System Cleanup                                                        =
echo.       =                                                                                 =
echo.       =      2]   Custom Cleanup                                                        =
echo.       =                                                                                 =
echo.       =      3]   Clean Windows Defender                                                =
echo.       =                                                                                 =
echo.       =      4]   Clear Recent Files List                                               =
echo.       =                                                                                 =
echo.       =      0]   Go Back                                                               =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    goto menu
) else if "%option%"=="1" (
    goto system_cleanup
) else if "%option%"=="2" (
    CLEANMGR
    pause
) else if "%option%"=="3" (
    goto clean_defender
) else if "%option%"=="4" (
    goto clean_recent_files
)

goto cleaning_tools


:system_cleanup
:: deletes the temp folder silently; both local and Windows. At the same time, it runs the internal window cleaner and also cleans the dns cache.
echo WARNING: This operation will delete temporary files and system logs.
echo Save and Close everything before continuing.
echo Files from the following locations will be deleted:
echo - %temp%
echo - C:\Windows\Temp
echo - C:\$Recycle.Bin
echo - Recent files list
echo.
set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
if "%confirm%" == "0" goto cleaning_tools
if not "%confirm%" == "1" goto system_cleanup

:: Proceed with cleanup
echo Deleting temporary files...
DEL /f /q /s %temp%\*.*
DEL /f /q /s C:\Windows\Temp\*.*

echo Emptying recycle bin...
RD /q /s C:\$Recycle.Bin

echo Running Disk Cleanup...
CLEANMGR /D C: /sagerun:65535

:: Check if the command can be executed without errors
echo Running Disk Cleanup...
POWERSHELL -Command "Clear-DnsClientCache" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system does not support the DnsClient module for DNS caching or an error has occurred.
) else (
    echo DNS cache flushed successfully.
)

echo Clearing event logs...
:: wevtutil is a set of system instructions that allow you to read, modify, and delete event logs and posts.
:: with "cl" clears all event logs (application, security, system)
wevtutil.exe cl Application
wevtutil.exe cl Security
wevtutil.exe cl System

echo Deleting recent file history...
DEL /f /q "%APPDATA%\Microsoft\Windows\Recent\*"

taskkill /f /im explorer.exe
start explorer.exe
pause
goto cleaning_tools


:clean_defender
echo WARNING: This operation will delete defender history of actions.
echo.
set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
if "%confirm%" == "0" goto cleaning_tools
if not "%confirm%" == "1" goto clean_defender

:: delete the content and service folder silently to clear the history of actions.
echo Deleting defender history of actions ...
DEL "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" /f /s /q
RD "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" /s /q
MD "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service"

pause
goto cleaning_tools


:clean_recent_files
echo WARNING: This operation will delete recent files history.
echo.
set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
if "%confirm%" == "0" goto cleaning_tools
if not "%confirm%" == "1" goto clean_recent_files

:: remotely delete recent file history
echo Deleting recent files history ...
del /F /Q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*"
del /F /Q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*"
del /F /Q "%APPDATA%\Microsoft\Windows\Recent\*"

taskkill /f /im explorer.exe
start explorer.exe
pause
goto cleaning_tools


:system_tools
cls
echo.
echo.       ===================================================================================
echo.       =                                 WINDOWS TOOLS                                   =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   System file check                                                     =
echo.       =                                                                                 =
echo.       =      2]   Check repair files                                                    =
echo.       =                                                                                 =
echo.       =      3]   System Image Restore                                                  =
echo.       =                                                                                 =
echo.       =      4]   Analysis of the data structure on disk (reboot is required)           =
echo.       =                                                                                 =
echo.       =      5]   Convert MBR Disk to GPT (Not Recommended)                             =
echo.       =                                                                                 =
echo.       =      6]   Force System Updates                                                  =
echo.       =                                                                                 =
echo.       =      7]   Defrag Main drive                                                     =
echo.       =                                                                                 =
echo.       =      0]   Go Back                                                               =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    goto menu
) else if "%option%"=="1" (
    goto system_file_check
) else if "%option%"=="2" (
    goto check_repair_files
) else if "%option%"=="3" (
    goto system_image_restore
) else if "%option%"=="4" (
    goto check_system_data_structure
) else if "%option%"=="5" (
    goto convert_mbr_gpt
) else if "%option%"=="6" (
    goto force_system_update
) else if "%option%"=="7" (
    goto defrag_main_drive
)

goto system_tools


:system_file_check
echo Running System File Check (sfc /scannow)...
echo This may take a few minutes, please wait.
sfc /scannow
if %errorlevel% neq 0 (
    echo ERROR: System File Check failed. Please check system logs.
)
pause
goto system_tools


:check_repair_files
echo Running DISM Health Scan...
echo Scanning the health of the system image (DISM /ScanHealth)...
DISM /Online /Cleanup-Image /ScanHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM ScanHealth failed. Please check system logs.
)

echo Checking system image health (DISM /CheckHealth)...
DISM /Online /Cleanup-Image /CheckHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM CheckHealth failed. Please check system logs.
)
pause
goto system_tools


:system_image_restore
echo Starting component cleanup (DISM /StartComponentCleanup)...
DISM /Online /Cleanup-Image /StartComponentCleanup
if %errorlevel% neq 0 (
    echo ERROR: DISM StartComponentCleanup failed. Please check system logs.
)

echo Restoring system image health (DISM /RestoreHealth)...
echo This may take several minutes, please wait.
DISM /Online /Cleanup-Image /RestoreHealth
if %errorlevel% neq 0 (
    echo ERROR: DISM RestoreHealth failed. Please check system logs.
)
pause
goto system_tools


:check_system_data_structure
echo WARNING: A reboot is required, Save everything before continuing.
echo.
set /p confirm="Do you want to continue with the check system data structure? [1-Continue ; 0-Exit]: "
if "%confirm%" == "0" goto system_tools
if not "%confirm%" == "1" goto check_system_data_structure

:: Proceed
chkdsk C: /F /R
pause
shutdown /r
pause>NUL
exit


:convert_mbr_gpt
cls
echo.
echo.   ====================== MBR to GPT Conversion ======================
echo.
echo.   WARNING: This operation will convert your disk from MBR to GPT.
echo.   Converting a disk to GPT may result in data loss if not done properly.
echo.   This process is irreversible. Please ensure you have backed up all data.
echo.   Your system must support UEFI to boot from a GPT disk.
echo.
echo.   Make sure you are ready before continuing.
echo.
set /p confirm="Do you want to continue under your Responsibility? [1-Continue ; 0-Exit]"
if "%confirm%" == "0" goto menu
if not "%confirm%" == "1" goto convert_mbr_gpt

:accepted_convert_mbr_gpt
:: Check if system is running UEFI
echo Checking if the system is booted in UEFI mode...
POWERSHELL -command "if ((Get-WmiObject -Class Win32_ComputerSystem).BootMode -ne 'UEFI') { exit 1 }"
if %errorlevel% neq 0 (
    echo ERROR: The system is not running in UEFI mode. Conversion to GPT will not work.
    pause
    goto system_tools
)

:: Ensure disk is MBR and not already GPT
(
    echo list disk
) | diskpart
echo.
set /p disk="Enter the number of the disk to convert: "

:: Validate that the disk is MBR
mbr2gpt /validate /disk:%disk% /allowFullOS
if %errorlevel% neq 0 (
    echo ERROR: The disk is either not suitable for conversion or already GPT.
    pause
    goto system_tools
)

set /p valid="Do you want to proceed with the conversion? [1-Continue ; 0-Exit]: "
if "%valid%" == "0" goto system_tools

:: Proceed with conversion
echo Proceeding with MBR to GPT conversion...
mbr2gpt /convert /disk:%disk% /allowFullOS
if %errorlevel% neq 0 (
    echo ERROR: Conversion failed.
    pause
    goto system_tools
)

echo.
echo Conversion successful. You will need to enable UEFI mode in your BIOS to boot from this disk.
echo.
shutdown /r /t 60
echo System will now reboot in 60 seconds. Press any key to cancel....
pause>NUL
shutdown /a 2>NUL
goto system_tools


:force_system_update
:: looks for (/detectnow) and forces system updates (/updatenow)
echo Searching and Updating.
wuauclt /detectnow /updatenow
echo. This process is in the background, and may take time depending on your internet speed.
pause
goto system_tools


:defrag_main_drive
echo Defragmenting C: drive...
defrag C: /U /V
pause
goto system_tools


:web_tools
cls
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
echo.       =      0]   Go Back                                                               =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                             by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    goto menu
) else if "%option%"=="1" (
    goto clean_dns
) else if "%option%"=="2" (
    goto test_dns
) else if "%option%"=="3" (
    goto select_dns
) else if "%option%"=="4" (
    goto view_wifi_password
)

goto web_tools


:clean_dns
:: cleanup the cache allows you to solve problems of bad storage of the same, and sometimes having too many elements stored in the cache slows down the system
echo Getting and clearing the dns client cache.

:: Check if the command can be executed without errors
echo Running Disk Cleanup...
POWERSHELL -Command "Get-DnsClientCache" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system does not support the DnsClient module for DNS caching or an error has occurred.
)

POWERSHELL -Command "Clear-DnsClientCache" >nul 2>&1
if %errorlevel% neq 0 (
    echo The system does not support the DnsClient module for DNS caching or an error has occurred.
) else (
    echo DNS cache flushed successfully.
)

pause
goto web_tools


:test_dns
:: pinging different DNS points allows you to see which one has less latency and data loss, so you can automatically assign it later.
echo PING major DNS providers.
echo Google DNS
ping 8.8.8.8
ping 8.8.4.4
echo.
echo CloudFire DNS
ping 1.1.1.1
ping 1.0.0.1
echo.
echo Open DNS
ping 208.67.222.222
ping 208.67.220.220
echo.
pause
goto web_tools


:select_dns
:: indicate and assign the fastest dns for your connection and configure them in your network port
echo Please indicate the network adapter to which to change your DNS.
netsh interface show interface
echo.
set /p Red= Indicate the name of the interface to apply the DNS change =   
echo.
set /p DNS1= Indicate the fastest DNS you want to apply =   
echo.
set /p DNS2= Indicate the second fastest DNS you want to apply =   
echo.
:: netsh is a command package for managing computer networks
netsh interface ipv4 set dnsservers "%Red%" static "%DNS1%" primary
netsh interface ipv4 add dnsservers "%Red%" "%DNS2%" index=2
echo.
pause
goto web_tools


:view_wifi_password
echo Showing the wifi connections registered on the PC.
netsh wlan show profile
echo.
set /p wifi= Wifi = 
echo.
pause
:: displays a list of network profiles that store a password
netsh wlan show profile name="%wifi%" key=clear
echo.
pause
goto web_tools
