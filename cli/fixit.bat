@echo off
setlocal

color 17
title FixIt V2.0.3

REM Check administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 4f
    title FixIt requires ADMINISTRATOR PRIVILEGES
    echo The script is not running with administrative privileges.
    echo Please run the script as administrator.
    pause
    exit /b
)

REM If "%1" the process is executed in a way other than the maximized one, it starts a new minimized process and closes the process that was not maximized
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b


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
) else if "%option%"=="1" (
    goto system_tools
) else if "%option%"=="2" (
    goto web_tools
) else if "%option%"=="3" (
    goto cleaning_tools
)

goto menu


:quick_repair
sfc /scannow
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /StartComponentCleanup
DISM /Online /Cleanup-Image /RestoreHealth
defrag C: /U /V
pause
goto menu


:quick_clean
DEL /f /q /s %temp%\*.*
DEL /f /q /s C:\Windows\Temp\*.*
RD /q /s C:\$Recycle.Bin
CLEANMGR /D C: /sagerun:65535
POWERSHELL Clear-DnsClientCache
wevtutil.exe cl Application
wevtutil.exe cl Security
wevtutil.exe cl System
DEL /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*"
DEL /f /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*"
DEL /f /q "%APPDATA%\Microsoft\Windows\Recent\*"
taskkill /f /im explorer.exe
start explorer.exe
pause
goto menu


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
REM deletes the temp folder silently; both local and Windows. At the same time, it runs the internal window cleaner and also cleans the dns cache.
echo Save and Close everything before continuing
pause
echo.
del /f /q /s %temp%\*.*
del /f /q /s C:\Windows\Temp\*.*
rd /q /s C:\$Recycle.Bin
CLEANMGR /D C: /sagerun:65535
POWERSHELL Clear-DnsClientCache
REM wevtutil is a set of system instructions that allow you to read, modify, and delete event logs and posts.
REM with "cl" clears all event logs (application, security, system)
wevtutil.exe cl Application
wevtutil.exe cl Security
wevtutil.exe cl System
pause
goto cleaning_tools


:clean_defender
REM delete the content and service folder silently to clear the history of actions.
DEL "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" /f /s /q
RD "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" /s /q
MD "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service"
pause
goto cleaning_tools


:clean_recent_files
REM remotely delete recent file history
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
sfc /scannow
pause
goto system_tools


:check_repair_files
DISM /Online /Cleanup-Image /ScanHealth
echo.
DISM /Online /Cleanup-Image /CheckHealth
pause
goto system_tools


:system_image_restore
DISM /Online /Cleanup-Image /StartComponentCleanup
echo.
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto system_tools


:check_system_data_structure
chkdsk C: /F /R
echo A reboot is required, Save everything before continuing
pause
shutdown /r
pause>NUL
exit


:convert_mbr_gpt
cls
echo.
echo.   WARNING...
echo "The tool is designed to be run from a Windows Preinstallation Environment (Windows PE) command prompt, but it can also be run from within the operating system (OS)."
echo.   IMPORTANT...
echo. Before attempting to convert the drive, make sure the device supports UEFI.
echo.
echo. After the disk has been converted to the GPT partition style, the firmware must be configured to boot in UEFI mode (in the computer's bios).
set /p confirm="Do you want to continue under your Responsibility? [1-Continue ; 0-Exit]"
if "%confirm%" == "1" goto accepted_convert_mbr_gpt 
if not "%confirm%" == "1" goto menu
:accepted_convert_mbr_gpt
(
    echo select disk all
    echo list disk
) | diskpart
cd C:\Windows\System32
echo.
set /p disk=Indicate the number of the disk to convert that is NOT GPT   
REM First, it validates that the selected disk is suitable for conversion.
mbr2gpt /validate /disk:"%disk%" /allowFullOS
echo.
set /p valid="Only! if the Process did not fail. Continue [1-Continue ; 0-Exit]:"
if "%valid%" == "1" goto success_convert_mbr_gpt
if not "%valid%" == "1" goto menu
:success_convert_mbr_gpt
REM if done convert disk to gpt; with the fullOs variant
mbr2gpt /convert /disk:"%disk%" /allowFullOS
echo.
echo. RESETTING...
echo. Access BIOS and enable SecureBoot
shutdown /r /t 60
exit


:force_system_update
REM looks for (/detectnow) and forces system updates (/updatenow)
echo Searching and Updating.
wuauclt /detectnow /updatenow
echo. This process is in the background, and may take time depending on your internet speed.
pause
goto system_tools


:defrag_main_drive
echo Defragmenting drive...
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
REM cleanup the cache allows you to solve problems of bad storage of the same, and sometimes having too many elements stored in the cache slows down the system
POWERSHELL Get-DnsClientCache
echo.
POWERSHELL Clear-DnsClientCache
pause
goto web_tools


:test_dns
REM pinging different DNS points allows you to see which one has less latency and data loss, so you can automatically assign it later.
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
REM indicate and assign the fastest dns for your connection and configure them in your network port
netsh interface show interface
echo.
set /p Red= Indicate the name of the interface to apply the DNS change =   
echo.
set /p DNS1= Indicate the fastest DNS you want to apply =   
echo.
set /p DNS2= Indicate the second fastest DNS you want to apply =   
echo.
REM netsh is a command package for managing computer networks
netsh interface ipv4 set dnsservers "%Red%" static "%DNS1%" primary
netsh interface ipv4 add dnsservers "%Red%" "%DNS2%" index=2
echo.
pause
goto web_tools


:view_wifi_password
netsh wlan show profile
echo.
set /p wifi= Wifi = 
echo.
pause
REM displays a list of network profiles that store a password
netsh wlan show profile name="%wifi%" key=clear
echo.
pause
goto web_tools
