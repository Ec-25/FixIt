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
    goto :Exit
)
:: Create the directory to store the logs
if not exist "%~dp0/logs" (
    mkdir "%~dp0/logs"
)
:: Flags for parameterization
if "%1"=="" goto :App
if "%1"=="-H" goto :Help
if "%1"=="-help" goto :Help
if "%1"=="/?" goto :Help
if "%1"=="-R" (
    if "%2"=="-F" (
        call :Repair_Full
    ) else (
        call :Repair_Simple
    )
    pause
    goto :Exit
)
if "%1"=="-repair" (
    if "%2"=="-F" (
        call :Repair_Full
    ) else (
        call :Repair_Simple
    )
    pause
    goto :Exit
)
if "%1"=="-C" (
    if "%2"=="-F" (
        call :Clear_Full
    ) else (
        call :Clear_Simple
    )
    pause
    goto :Exit
)
if "%1"=="-clean" (
    if "%2"=="-F" (
        call :Clear_Full
    ) else (
        call :Clear_Simple
    )
    pause
    goto :Exit
)
echo flag "%1" not recognized

:Help
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
    goto :Exit

::Base App Init
:App
    color 17
    title FixIt V2.2.1
    ::   If "%1" the process is executed in a way other than the maximized one,
    :: it starts a new minimized process and closes the process that was not maximized.
    ::   If not "%1" == "max" start /MAX cmd /c %0 max & exit/b
    goto :View_Menu

:: Views
:View_Menu
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
        goto :Exit
    ) else if "%option%"=="s" (
        call :Quick_Repair
    ) else if "%option%"=="c" (
        call :Quick_Clean
    ) else if "%option%"=="t" (
        call :View_Scheduled_Tasks
    ) else if "%option%"=="1" (
        call :View_System_Tools
    ) else if "%option%"=="2" (
        call :View_Web_Tools
    ) else if "%option%"=="3" (
        call :View_Cleaning_Tools
    ) else (
        echo Invalid Option
    )
    goto :View_Menu

:View_Scheduled_Tasks
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
        goto :EOF
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
    ) else (
        echo Invalid Option
    )
    pause
    goto :View_Scheduled_Tasks

:View_System_Tools
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
        goto :EOF
    ) else if "%option%"=="1" (
        call :Sfc
    ) else if "%option%"=="2" (
        call :DISM_Scan
        call :DISM_Check
    ) else if "%option%"=="3" (
        call :DISM_Restore
    ) else if "%option%"=="4" (
        goto :Check_System_Data_Structure
    ) else if "%option%"=="5" (
        call :Convert_Mbr_To_Gpt
    ) else if "%option%"=="6" (
        call :Force_System_Update
    ) else if "%option%"=="7" (
        call :Defrag_C
    ) else (
        echo Invalid Option
    )
    pause
    goto :View_System_Tools

:View_Web_Tools
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
        goto :EOF
    ) else if "%option%"=="1" (
        call :Get_Dns_Cache
        call :Clear_Dns_Cache
    ) else if "%option%"=="2" (
        call :Test_Dns_s
    ) else if "%option%"=="3" (
        call :Set_Dns
    ) else if "%option%"=="4" (
        call :Get_Wifi
    ) else (
        echo Invalid Option
    )
    pause
    goto :View_Web_Tools

:View_Cleaning_Tools
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
        goto :EOF
    ) else if "%option%"=="1" (
        call :System_Cleanup
    ) else if "%option%"=="2" (
        cleanmgr
    ) else if "%option%"=="3" (
        call :Clear_Defender
    ) else if "%option%"=="4" (
        call :Clear_Recent_Files
    ) else (
        echo Invalid Option
    )
    pause
    goto :View_Cleaning_Tools

:: Functions
:Check_System_Data_Structure
    echo WARNING: A reboot is required, Save everything before continuing.
    echo.
    set /p confirm="Do you want to continue with the check system data structure? [1-Continue ; 0-Exit]: "
    if "%confirm%" == "0" goto :EOF
    if not "%confirm%" == "1" goto :Check_System_Data_Structure
    :: Proceed
    chkdsk C: /F /R
    pause
    shutdown /r
    goto :Exit

:Clear_Defender
    echo WARNING: This operation will delete defender history of actions.
    echo.
    set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
    if "%confirm%" == "0" goto :EOF
    if not "%confirm%" == "1" goto :Clear_Defender
    :: Delete the content and service folder silently to clear the history of actions.
    call :Get_Date
    echo Deleting defender history of actions ...
    del "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service\*" /f /q >> "%~dp0/logs/%fecha%_%hora%.log" 2>&1
    rd "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" /q /s
    md "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service"
    goto :EOF

:Clear_Dns_Cache
    :: Check if the command can be executed without errors
    echo Clearing Dns Cache...
    powershell -Command "Clear-DnsClientCache" >nul 2>&1
    if %errorlevel% neq 0 (
        echo The system does not support the DnsClient module for DNS caching or an error has occurred.
    ) else (
        echo DNS cache flushed successfully.
    )
    goto :EOF

:Clear_Event_Logs
    echo Clearing event logs...
    powershell -Command "wevtutil cl Application" >nul 2>&1
    if %errorlevel% neq 0 (
        echo The system does not support the wevtutil module or an error has occurred.
    ) else (
        echo Event Application flushed successfully.
    )
    powershell -Command "wevtutil cl Security" >nul 2>&1
    if %errorlevel% neq 0 (
        echo The system does not support the wevtutil module or an error has occurred.
    ) else (
        echo Event Security flushed successfully.
    )
    powershell -Command "wevtutil cl System" >nul 2>&1
    if %errorlevel% neq 0 (
        echo The system does not support the wevtutil module or an error has occurred.
    ) else (
        echo Event System flushed successfully.
    )
    goto :EOF

:Clear_Full
    call :Clear_Warning
    if "%confirm%" == "0" (
        goto :Exit
    )
    if not "%confirm%" == "1" goto :Clear_Full
    :: Proceed with cleanup
    call :Delete_Temp_Trash_Files
    call :Clear_Dns_Cache
    call :Clear_Event_Logs
    call :Clear_Recent_History
    taskkill /f /im explorer.exe
    start explorer.exe
    goto :EOF

:Clear_Recent_Files
    echo WARNING: This operation will delete recent files history.
    echo.
    set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
    if "%confirm%" == "0" goto :EOF
    if not "%confirm%" == "1" goto :Clear_Recent_Files
    :: Remotely delete recent file history
    call :Get_Date
    echo Deleting recent files history ...
    del /f /q "%APPDATA%\Microsoft\Windows\Recent\*" >> "%~dp0/logs/%fecha%_%hora%.log" 2>&1
    call :Restart_Explorer
    goto :EOF

:Clear_Recent_History
    call :Get_Date
    echo Deleting recent file history...
    del /f /q "%APPDATA%\Microsoft\Windows\Recent\*" >> "%~dp0/logs/%fecha%_%hora%.log" 2>&1
    goto :EOF

:Clear_Simple
    call :Clear_Warning
    if "%confirm%" == "0" (
        goto :Exit
    )
    if not "%confirm%" == "1" goto :Clear_Simple
    :: Proceed with cleanup
    call :Delete_Temp_Trash_Files
    call :Clear_Dns_Cache
    goto :EOF

:Clear_Warning
    echo WARNING: This operation will delete temporary files and system logs.
    echo Files from the following locations will be deleted:
    echo - %temp%
    echo - C:\Windows\Temp
    echo - C:\$Recycle.Bin
    echo.
    set /p confirm="Do you want to continue with the cleanup? [1-Continue ; 0-Exit]: "
    goto :EOF

:Convert_Mbr_To_Gpt
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
    if "%confirm%" == "0" goto :EOF
    if not "%confirm%" == "1" goto :Convert_Mbr_To_Gpt
    :: Check if system is running UEFI
    echo Checking if the system is booted in UEFI mode...
    powershell -command "if ((Get-WmiObject -Class Win32_ComputerSystem).BootMode -ne 'UEFI') { exit 1 }"
    if %errorlevel% neq 0 (
        echo ERROR: The system is not running in UEFI mode. Conversion to GPT will not work.
        goto :EOF
    )
    :: Ensure disk is MBR and not already GPT
    (
        echo list disk
    ) | diskpart
    echo.
    set /p disk="Enter the number of the disk to convert: "
    if "%disk%" == "" (
        echo The disk name cannot be blank
        goto :EOF
    )
    :: Validate that the disk is MBR
    mbr2gpt /validate /disk:%disk% /allowFullOS
    if %errorlevel% neq 0 (
        echo ERROR: The disk is either not suitable for conversion or already GPT.
        goto :EOF
    )
    set /p valid="Do you want to proceed with the conversion? [1-Continue ; 0-Exit]: "
    if "%valid%" neq "0" goto :EOF
    :: Proceed with conversion
    echo Proceeding with MBR to GPT conversion...
    mbr2gpt /convert /disk:%disk% /allowFullOS
    if %errorlevel% neq 0 (
        echo ERROR: Conversion failed.
        goto :EOF
    )
    echo.
    echo Conversion successful. You will need to enable UEFI mode in your BIOS to boot from this disk.
    echo.
    shutdown /r /t 60
    echo System will now reboot in 60 seconds. Press any key to cancel....
    pause>NUL
    shutdown /a 2>NUL
    goto :EOF

:Defrag_C
    echo Defragmenting C: drive...
    defrag C: /U /V
    goto :EOF

:Delete_Temp_Trash_Files
    call :Get_Date
    echo Deleting temporary files...
    del %temp% /f /q /s >> "%~dp0/logs/%fecha%_%hora%.log" 2>&1
    rd "%temp%" /s /q
    md "%temp%"
    del /f /q /s C:\Windows\Temp\*.* >> "%~dp0/logs/%fecha%_%hora%.log" 2>&1
    echo Emptying recycle bin...
    rd /q /s C:\$Recycle.Bin  >> "%~dp0/logs/%fecha%_%hora%.log" 2>&1
    goto :EOF

:DISM_Check
    echo Checking system image health (DISM /CheckHealth)...
    dism /Online /Cleanup-Image /CheckHealth
    if %errorlevel% neq 0 (
        echo ERROR: DISM CheckHealth failed. Please check system logs.
    )
    goto :EOF

:DISM_Restore
    echo Starting component cleanup (DISM /StartComponentCleanup)...
    dism /Online /Cleanup-Image /StartComponentCleanup
    if %errorlevel% neq 0 (
        echo ERROR: DISM StartComponentCleanup failed. Please check system logs.
    )
    echo Restoring system image health (DISM /RestoreHealth)...
    echo This may take several minutes, please wait.
    dism /Online /Cleanup-Image /RestoreHealth
    if %errorlevel% neq 0 (
        echo ERROR: DISM RestoreHealth failed. Please check system logs.
    )
    goto :EOF

:DISM_Restore
    echo Starting component cleanup (DISM /StartComponentCleanup)...
    dism /Online /Cleanup-Image /StartComponentCleanup
    if %errorlevel% neq 0 (
        echo ERROR: DISM StartComponentCleanup failed. Please check system logs.
    )
    echo Restoring system image health (DISM /RestoreHealth)...
    echo This may take several minutes, please wait.
    dism /Online /Cleanup-Image /RestoreHealth
    if %errorlevel% neq 0 (
        echo ERROR: DISM RestoreHealth failed. Please check system logs.
    )
    goto :EOF

:DISM_Scan
    echo Running DISM Health Scan...
    echo Scanning the health of the system image (DISM /ScanHealth)...
    dism /Online /Cleanup-Image /ScanHealth
    if %errorlevel% neq 0 (
        echo ERROR: DISM ScanHealth failed. Please check system logs.
    )
    goto :EOF

:Disk_Cleanup
    echo Running Disk Cleanup...
    cleanmgr /D C: /sagerun:65535
    goto :EOF

:Exit
    endlocal
    exit /b

:Force_System_Update
    :: Looks for (/detectnow) and forces system updates (/updatenow)
    echo Searching and Updating.
    powershell -Command "wuauclt /detectnow /updatenow" >nul 2>&1
    if %errorlevel% neq 0 (
        echo The system does not support the wuauclt module or an error has occurred.
    ) else (
        echo. This process is in the background, and may take time depending on your internet speed.
    )
    goto :EOF

:Get_Date
    :: Remove the first four characters (the day)
    set "fecha=%date:~4%"
    :: Replace slashes "/" with dashes "-"
    set "fecha=%fecha:/=-%"
    :: Extract time in HH MM format & replace leading spaces with 0, if necessary
    set "hora=%time:~0,2%-%time:~3,2%"
    set "hora=%hora: =0%"
    goto :EOF

:Get_Dns_Cache
    echo Getting Dns Cache...
    powershell -Command "Get-DnsClientCache" >nul 2>&1
    if %errorlevel% neq 0 (
        echo The system does not support the DnsClient module for DNS caching or an error has occurred.
    )
    goto :EOF

:Get_Wifi
    echo Showing the wifi connections registered on the PC.
    netsh wlan show profile
    echo.
    set /p wifi= Wifi = 
    if "%wifi%" == "" (
        echo The network name cannot be blank
        goto :EOF
    )
    echo.
    :: Displays a list of network profiles that store a password
    netsh wlan show profile name="%wifi%" key=clear
    echo.
    goto :EOF

:Quick_Clean
    call :Clear_Warning
    if "%confirm%" == "0" goto :View_Menu
    if not "%confirm%" == "1" goto :Quick_Clean
    :: Proceed with cleanup
    call :Delete_Temp_Trash_Files
    call :Clear_Dns_Cache
    call :Clear_Event_Logs
    call :Clear_Recent_History
    call :Disk_Cleanup
    taskkill /f /im explorer.exe
    start explorer.exe
    pause
    goto :EOF

:Quick_Repair
    call :Repair_Full
    pause
    goto :EOF

:Repair_Full
    call :Repair_Simple
    call :DISM_Restore
    call :Defrag_C
    goto :EOF

:Repair_Simple
    call :Sfc
    call :DISM_Scan
    call :DISM_Check
    goto :EOF

:Restart_Explorer
    taskkill /f /im explorer.exe
    start explorer.exe
    goto :EOF

:Set_Dns
    :: Indicate and assign the fastest dns for your connection and configure them in your network port
    echo Please indicate the network adapter to which to change your DNS.
    netsh interface show interface
    echo.
    set /p Red= Indicate the name of the interface to apply the DNS change =   
    if "%Red%" == "" (
        echo The network name cannot be blank
        goto :EOF
    )
    echo.
    set /p DNS1= Indicate the fastest DNS you want to apply =   
    if "%DNS1%" == "" (
        echo DNS1 cannot be blank
        goto :EOF
    )
    echo.
    set /p DNS2= Indicate the second fastest DNS you want to apply =   
    if "%DNS2%" == "" (
        echo DNS2 cannot be blank
        goto :EOF
    )
    echo.
    :: Netsh is a command package for managing computer networks
    netsh interface ipv4 set dnsservers "%Red%" static "%DNS1%" primary
    netsh interface ipv4 add dnsservers "%Red%" "%DNS2%" index=2
    echo.
    goto :EOF

:Sfc
    echo Running System File Check (sfc /scannow)...
    echo This may take a few minutes, please wait.
    sfc /scannow
    if %errorlevel% neq 0 (
        echo ERROR: System File Check failed. Please check system logs.
    )
    goto :EOF

:System_Cleanup
    ::    Deletes the temp folder silently; both local and Windows. At the same time,
    :: it runs the internal window cleaner and also cleans the dns cache.
    call :Clear_Warning
    if "%confirm%" == "0" goto :EOF
    if not "%confirm%" == "1" goto :System_Cleanup
    :: Proceed with cleanup
    call :Delete_Temp_Trash_Files
    call :Clear_Dns_Cache
    call :Clear_Event_Logs
    call :Clear_Recent_History
    call :Disk_Cleanup
    call :Restart_Explorer
    goto :EOF

:Test_Dns_s
    ::    Pinging different DNS points allows you to see which one has less
    :: latency and data loss, so you can automatically assign it later.
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
    goto :EOF
