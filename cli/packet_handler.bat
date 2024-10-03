@echo off
setlocal enabledelayedexpansion

:: Check administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 4f
    title Win Tools requires ADMINISTRATOR PRIVILEGES
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

if "%1"=="-D" goto debloat
if "%1"=="-S" goto kill_services
if "%1"=="-T" goto block_telemetry
if "%1"=="-M" (
    mrt
    endlocal
    exit /b
)

echo flag "%1" not recognized

:help
:: Help method
echo Use: packet_handler.bat [-H / -D / -S / -T / -M]
echo.
echo Command line options:
echo   -H   Displays the help screen with commands and usage.
echo   -D   Starts the debloat function of the windows system.
echo   -S   Stop unnecessary services.
echo   -T   Block telemetry collection and sending.
echo   -M   Open Microsoft Malicious Software Removal.
echo.
echo How to use:
echo   Choose from the options shown in the menu to execute the desired function.
endlocal
exit /b

:kill_services
if "%restorePoint%"=="0" (
    powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "FixItToolsRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
    set "restorePoint=1"
)
:: sc stop "Name of Service"
:: sc config "Name of Service" start= disabled
sc stop defragsvc& sc config defragsvc start= disabled
sc stop SysMain& sc config SysMain start= disabled
sc stop Fax& sc config Fax start= disabled
sc stop RemoteRegistry& sc config RemoteRegistry start= disable
sc stop TapiSrv& sc config TapiSrv start= disabled
sc stop MapsBroker& sc config MapsBroker start= disabled
sc stop SNMPTRAP& sc config SNMPTRAP start= disabled
sc stop PcaSvc& sc config PcaSvc start= demand& :: demand = manual
sc stop BDESVC& sc config BDESVC start= demand
sc stop CertPropSvc& sc config CertPropSvc start= disabled
sc stop DiagTrack& sc config DiagTrack start= disabled
sc stop dmwappushservice& sc config dmwappushservice start= disabled
sc stop BITS& sc config BITS start= disabled
sc stop Netlogon& sc config Netlogon start= disabled
sc stop RmSvc& sc config RmSvc start= disabled
endlocal
exit /b

:block_telemetry
if "%restorePoint%"=="0" (
    powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "FixItToolsRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
    set "restorePoint=1"
)
:: Disable Windows Telemetry through the System Registry
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
:: Restart the telemetry service
net stop DiagTrack
net stop dmwappushservice
endlocal
exit /b


:continue
color 17
title Win Tools V1.1.4

:: If "%1" the process is executed in a way other than the maximized one, it starts a new minimized process and closes the process that was not maximized
:: if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

:: Define a variable to check if a restore point has been made in case of making unwanted changes to the system.
set "restorePoint=0"


:menu
cls
echo.
echo.       ===================================================================================
echo.       =                                    WIN TOOLS                                    =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =        1]     System Tools Shortcuts                                            =
echo.       =                                                                                 =
echo.       =        2]     Process and Services                                              =
echo.       =                                                                                 =
echo.       =        3]     System Settings                                                   =
echo.       =                                                                                 =
echo.       =        4]     Packages                                                          =
echo.       =                                                                                 =
echo.       =        5]     Debloat                                                           =
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
) else if "%option%"=="1" (
    goto system_shortcuts
) else if "%option%"=="2" (
    goto process_and_services
) else if "%option%"=="3" (
    goto system_settings
) else if "%option%"=="4" (
    goto packages
) else if "%option%"=="5" (
    echo The Debloat option is responsible for cleaning, optimizing, repairing and eliminating all pre-installed Windows programs that are normally not used and only take up space, leaving a clean and light image of the system.
    echo You must be careful to execute the following command since it is an irreversible process, you must also keep in mind that you should not turn off the computer or close the application during its execution since the system could be damaged.
    echo Only execute the following option if you agree and know the risk involved.
    echo.
    set /p confirm="Are you sure?[y/N]: "
    if "%confirm%"=="y" (
        goto debloat
    ) else if "%confirm%"=="Y" (
        goto debloat
    )
    goto menu
)

goto menu


:system_shortcuts
cls
echo.
echo.       ===================================================================================
echo.       =                                    SHORTCUTS                                    =
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
echo.       =      7]   Users Information                                                     =
echo.       =                                                                                 =
echo.       =      8]   Event Viewer                                                          =
echo.       =                                                                                 =
echo.       =      9]   Programs                                                              =
echo.       =                                                                                 =
echo.       =     10]   System Properties                                                     =
echo.       =                                                                                 =
echo.       =     11]   Internet Options                                                      =
echo.       =                                                                                 =
echo.       =     12]   Internet Protocol Configuration                                       =
echo.       =                                                                                 =
echo.       =     13]   Performance Monitor                                                   =
echo.       =                                                                                 =
echo.       =     14]   Resource Monitor                                                      =
echo.       =                                                                                 =
echo.       =     15]   Task Manager                                                          =
echo.       =                                                                                 =
echo.       =     16]   Registry Editor                                                       =
echo.       =                                                                                 =
echo.       =     17]   System Restore                                                        =
echo.       =                                                                                 =
echo.       =     18]   System Configuration                                                  =
echo.       =                                                                                 =
echo.       =     19]   DirectX Diagnostic Tool                                               =
echo.       =                                                                                 =
echo.       =     20]   Microsoft Malicious Software Removal                                  =
echo.       =                                                                                 =
echo.       =      0]   Exit                                                                  =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                         by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    goto menu
) else if "%option%"=="1" (
    winver
    pause
) else if "%option%"=="2" (
    UserAccountControlSettings
    pause
) else if "%option%"=="3" (
    C:\WINDOWS\System32\wscui.cpl
    pause
) else if "%option%"=="4" (
    C:\WINDOWS\System32\control.exe /name Microsoft.Troubleshooting
    pause
) else if "%option%"=="5" (
    compmgmt
    pause
) else if "%option%"=="6" (
    msinfo32
    pause
) else if "%option%"=="7" (
    C:\WINDOWS\System32\lusrmgr.msc
    pause
) else if "%option%"=="8" (
    eventvwr
    pause
) else if "%option%"=="9" (
    C:\WINDOWS\System32\appwiz.cpl
    pause
) else if "%option%"=="10" (
    C:\WINDOWS\System32\control.exe system
    pause
) else if "%option%"=="11" (
    C:\WINDOWS\System32\inetcpl.cpl
    pause
) else if "%option%"=="12" (
    ipconfig
    pause
) else if "%option%"=="13" (
    perfmon
    pause
) else if "%option%"=="14" (
    resmon
    pause
) else if "%option%"=="15" (
    C:\WINDOWS\System32\taskmgr.exe /7
    pause
) else if "%option%"=="16" (
    regedt32
    pause
) else if "%option%"=="17" (
    rstrui
    pause
) else if "%option%"=="18" (
    msconfig
    pause
) else if "%option%"=="19" (
    dxdiag
    pause
) else if "%option%"=="20" (
    mrt
    pause
)

goto system_shortcuts


:process_and_services
cls
echo.
echo.       ===================================================================================
echo.       =                             PROCESSES AND SERVICES                              =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]  Stop Unnecessary Services                                              =
echo.       =                                                                                 =
echo.       =      2]  Stop Xbox Services                                                     =
echo.       =                                                                                 =
echo.       =      3]  Recover Deleted Files                                                  =
echo.       =                                                                                 =
echo.       =      4]  Disable Telemetry Collection                                           =
echo.       =                                                                                 =
echo.       =      5]  Disable Automatic Updates (Windows Update)                             =
echo.       =                                                                                 =
echo.       =      6]  Activate Automatic Updates (Windows Update)                            =
echo.       =                                                                                 =
echo.       =      0]   Go Back                                                               =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                         by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    goto menu
) else if "%option%"=="1" (
    if "%restorePoint%"=="0" (
        :: no policy restrictions creates a system restore point, so if something goes wrong, the computer is not affected
        echo Creating a Restore point
        powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "FixItToolsRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
        echo.
        set "restorePoint=1"
    )
    :: sc stop "Name of Service"
    :: sc config "Name of Service" start= disabled
    sc stop defragsvc& sc config defragsvc start= disabled
    sc stop SysMain& sc config SysMain start= disabled
    sc stop Fax& sc config Fax start= disabled
    sc stop RemoteRegistry& sc config RemoteRegistry start= disable
    sc stop TapiSrv& sc config TapiSrv start= disabled
    sc stop MapsBroker& sc config MapsBroker start= disabled
    sc stop SNMPTRAP& sc config SNMPTRAP start= disabled
    sc stop PcaSvc& sc config PcaSvc start= demand& :: demand = manual
    sc stop BDESVC& sc config BDESVC start= demand
    sc stop CertPropSvc& sc config CertPropSvc start= disabled
    sc stop DiagTrack& sc config DiagTrack start= disabled
    sc stop dmwappushservice& sc config dmwappushservice start= disabled
    sc stop BITS& sc config BITS start= disabled
    sc stop Netlogon& sc config Netlogon start= disabled
    sc stop RmSvc& sc config RmSvc start= disabled
    pause
) else if "%option%"=="2" (
    if "%restorePoint%"=="0" (
        echo Creating a Restore point
        powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "FixItToolsRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
        echo.
        set "restorePoint=1"
    )
    sc stop XblGameSave& sc config XblGameSave start= disabled
    sc stop XboxNetApiSvc& sc config XboxNetApiSvc start= disabled
    sc stop XboxGipSvc& sc config XboxGipSvc start= disabled
    pause
) else if "%option%"=="3" (
    set /p inst="Do you have 'Windows File Recovery' installed? [Y/n]"
    if "%inst%" == "s" goto continue
    if "%inst%" == "S" goto continue
    if "%inst%" == "" goto continue
    :install
    start https://apps.microsoft.com/store/detail/windows-file-recovery/9N26S50LN705
    pause
    :continue
    echo.
    set /p search="Location to Search:[C://...] "
    set /p save="Location to Store the Found:[C://...] "
    set /p filters="Filters[/n ''user\<username>\download'' /n ''*.pdf''] "
    :: scans the drive for deleted files where the user indicates in the filter
    winfr "%search%" "%save%" /regular %filters%
    echo.
    pause
) else if "%option%"=="4" (
    if "%restorePoint%"=="0" (
        echo Creating a Restore point
        powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "FixItToolsRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
        echo.
        set "restorePoint=1"
    )
    :: Disable Windows Telemetry through the System Registry
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
    :: Restart the telemetry service
    net stop DiagTrack
    net stop dmwappushservice
    echo Telemetry disabled successfully.
    echo.
    pause
) else if "%option%"=="5" (
    :: Stop the Windows Update service
    net stop wuauserv
    :: Disable automatic updates through the Registry
    :: NoAutoUpdate = 1 : Activated the blocking of updates
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
    echo Automatic updates successfully disabled.
    echo.
    pause
) else if "%option%"=="6" (
    :: Activate automatic updates through the Registry
    :: NoAutoUpdate = 0 : Disabled Lock
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f
    :: Activate the windows update service
    net start wuauserv
    echo Automatic updates successfully enabled.
    echo.
    pause
)

goto process_and_services


:system_settings
cls
echo.
echo.       ===================================================================================
echo.       =                                 SYSTEM SETTINGS                                 =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]  Activate Old Photo Viewer                                              =
echo.       =                                                                                 =
echo.       =      2]  Add security layer to the System against Malware Execution             =
echo.       =                                                                                 =
echo.       =      3]  Remove security layer to the System against Malware Execution          =
echo.       =                                                                                 =
echo.       =      4]  Remove the New Menu Design from Windows 11                             =
echo.       =                                                                                 =
echo.       =      5]  Return to the New Windows 11 Menu Design                               =
echo.       =                                                                                 =
echo.       =      6]  Disable All Web Extensions (Chrome and Edge)                           =
echo.       =                                                                                 =
echo.       =      7]  Disable Execution of Unsigned PS Scripts                               =
echo.       =                                                                                 =
echo.       =      8]  Disable Windows Smartscreen (especially for sandbox)                   =
echo.       =                                                                                 =
echo.       =      9]  EXTRA settings                                                         =
echo.       =                                                                                 =
echo.       =                ================= USER CONTROLS =================                =
echo.       =     10]  Change User Password                                                   =
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
    :: activates all the registry keys needed to run the old windows viewer which has amazing performance
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d 00000001 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%SystemRoot%\System32\imageres.dll,-70" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "\"%SystemRoot%\System32\cmd.exe\" /c \"\"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll\" \"%1\"\"" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d 00010000 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d 00000001 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
    pause
) else if "%option%"=="2" (
    :: set the execution privacy log setting to enabled
    echo. Security Layer Enabled
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 1 /f
    echo.
    pause
) else if "%option%"=="3" (
    :: set the runtime privacy section registry setting to disabled
    echo. Security Layer Disabled
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f
    echo.
    pause
) else if "%option%"=="4" (
    :: Create module in the registry to enable the old menu.
    echo. Old Menu Enabled
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
    taskkill /f /im explorer.exe
    start explorer.exe
    echo.
    pause
) else if "%option%"=="5" (
    :: Delete menu module
    echo. Old Menu Disabled
    reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
    taskkill /f /im explorer.exe
    start explorer.exe
    echo.
    pause
) else if "%option%"=="6" (
    :: run internal browser commands to disable extensions due to crashes, errors, or conflicts
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-extensions
    "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-extensions
    echo.
    pause
) else if "%option%"=="7" (
    :: Disable execution of unsigned PowerShell scripts
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d "AllSigned" /f
    reg add "HKEY_CURRENT_USER\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d "AllSigned" /f
    echo Execution of unsigned PowerShell scripts successfully disabled.
    echo.
    pause
) else if "%option%"=="8" (
    :: Disable SmartScreen
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f
    :: Checks if the PhishingFilter key exists, if not, creates it
    reg query "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" >nul 2>&1
    if %errorlevel% neq 0 (
        reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /f
    )
    :: Disable Microsoft Edge's antiphishing filter
    reg add "HKLM\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" /v EnabledV9 /t REG_DWORD /d 0 /f
    echo successfully disabled.
    echo.
    pause
) else if "%option%"=="9" (
    if exist "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" (
        start explorer.exe "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 
    ) else (
        mkdir "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 
    )
    pause
) else if "%option%"=="10" (
    echo.
    net user
    echo.
    set /p user="Enter the username to change your password: "
    :set_passwords
    set /p pass1="Enter the new password: "
    set /p pass2="Please enter the password again: "
    if not "%pass1%"=="%pass2%" (
        echo "Passwords do not match. Please try again."
        goto set_passwords
    )
    net user "%user%" "%pass1%"
    if %errorlevel% neq 0 (
        echo "Failed to change the password. Please check if the username is correct or you have sufficient permissions."
    ) else (
        echo "Password changed successfully."
    )
    pause
)

goto system_settings


:packages
cls
echo.
echo.       ===================================================================================
echo.       =                                    PACKAGES                                     =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =       1]  Uninstall a Third Party Application                                   =
echo.       =                                                                                 =
echo.       =       2]  Uninstall a Windows Apps                                              =
echo.       =                                                                                 =
echo.       =       3]  Uninstall Microsoft Office                                            =
echo.       =                                                                                 =
echo.       =       4]  Uninstall OneDrive                                                    =
echo.       =                                                                                 =
echo.       =       5]  Install All WindowsApps                                               =
echo.       =                                                                                 =
echo.       =       6]  Install Selection of WindowsApps                                      =
echo.       =                                                                                 =
echo.       =       7]  Install HEVC (H.265) Video Codec                                      =
echo.       =                                                                                 =
echo.       =       8]  Install Office 2021 (without license)                                 =
echo.       =                                                                                 =
echo.       =       9]  PowerToys                                                             =
echo.       =                                                                                 =
echo.       =      10]  Update All Apps                                                       =
echo.       =                                                                                 =
echo.       =       0]  Go Back                                                               =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    goto menu
) else if "%option%"=="1" (
    :: Uninstall the indicated apps automatically with all necessary permissions.
    WMIC product get name
    echo.
    echo. Copy and paste below the app name shown in the top list to uninstall it
    echo. WARNING
    echo. You are about to delete the specified application. This action is irreversible. Are you sure you want to continue?
    set /p ans="Do you agree? [Y/N]"
    echo.
    if "%ans%" == "S" goto next
    if "%ans%" == "s" goto next
    goto menu
    :: In order for it to be uninstalled, it is necessary for the program to contain an uninstaller in its data folder && There are programs that do not fully integrate it, so it is not possible to uninstall it this way
    :next
    set /p produn=AppUni=
    WMIC product where name="%produn%" call uninstall
    echo.
    pause
) else if "%option%"=="2" (
    :: Uninstall automatically indicated system-owned apps with all necessary permissions.
    POWERSHELL "Get-AppxPackage | Select Name, PackageFullName"
    echo.
    echo. "Copy and paste below the app name shown in the top (right) list to uninstall it"
    echo. WARNING
    echo. You are about to delete the specified application. This action is irreversible. Are you sure you want to continue?
    set /p ans="Do you agree? [Y/N]"
    echo.
    if "%ans%" == "S" goto next2
    if "%ans%" == "s" goto next2
    goto menu
    :next2
    :: set the execution policies to unrestricted so that you can manipulate system applications without inconvenience
    PowerShell Set-ExecutionPolicy Unrestricted
    echo.
    set /p appak=APPID=
    :: PFinally, the execution restriction is placed again since otherwise it would be dangerous to leave it unlimited since anything could be installed on the computer without you knowing it
    POWERSHELL Remove-AppxPackage "%appak%"
    echo.
    PowerShell Set-ExecutionPolicy Restricted
    set /p opt="Continue or go to menu? [C/M]"
    if "%opt%" == "c" goto next2
    if "%opt%" == "C" goto next2
    pause
) else if "%option%"=="3" (
    :: download and run the office uninstall tool, as many times its internal uninstaller leaves residual files and keys that prevent the installation of a new instance.
    POWERSHELL Invoke-WebRequest -Uri "https://aka.ms/SaRA-officeUninstallFromPC" -OutFile "C:\Users\%username%\Downloads\SetupProd_OffScrub.exe"
    timeout 5
    move C:\Users\%username%\Downloads\SetupProd_OffScrub.exe "%~p0"
    cd "%~p0"
    start SetupProd_OffScrub.exe
    pause
    del SetupProd_OffScrub.exe /f /s /q
    echo.
    pause
) else if "%option%"=="4" (
    echo Kill OneDrive process
    taskkill.exe /F /IM "OneDrive.exe"
    taskkill.exe /F /IM "explorer.exe"

    echo Remove OneDrive
    if exist "%systemroot%\System32\OneDriveSetup.exe" (
        "%systemroot%\System32\OneDriveSetup.exe" /uninstall
    )
    if exist "%systemroot%\SysWOW64\OneDriveSetup.exe" (
        "%systemroot%\SysWOW64\OneDriveSetup.exe" /uninstall
    )

    echo Removing OneDrive leftovers
    rmdir /s /q "%localappdata%\Microsoft\OneDrive"
    rmdir /s /q "%programdata%\Microsoft OneDrive"
    rmdir /s /q "%systemdrive%\OneDriveTemp"

    :: check if directory is empty before removing:
    for /f %%I in ('dir "%userprofile%\OneDrive" /a /b') do set count=1
    if not %count%==0 (
        rmdir /s /q "%userprofile%\OneDrive"
    )

    echo Disable OneDrive via Group Policies
    reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f

    echo Remove OneDrive from explorer sidebar
    reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
    reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f

    echo Removing run hook for new users
    reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
    reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
    reg unload "hku\Default"

    echo Removing startmenu entry
    del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

    echo Removing scheduled task
    schtasks /delete /tn "OneDrive*" /f

    echo Restarting explorer
    start explorer.exe

    echo Waiting for explorer to complete loading
    timeout /t 10 /nobreak
    echo. Uninstall successful
    pause

) else if "%option%"=="5" (
    PowerShell Set-ExecutionPolicy Unrestricted
    :: registers a new application installation that has the Windows installer
    POWERSHELL "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register ""$($_.InstallLocation)\appxmanifest.xml"" -DisableDevelopmentMode}"
    :: Add-AppxPackage : Deployment error with HRESULT: 0x80073D02, The package could not be installed because the resources it modifies are currently in use.
    :: if the above message comes out, then the command is executed successfully
    PowerShell Set-ExecutionPolicy Restricted
    echo. Installation successful
    pause
) else if "%option%"=="6" (
    POWERSHELL Set-ExecutionPolicy Unrestricted
    :: displays a list of apps you have available to install
    POWERSHELL "Get-AppxPackage -AllUsers | Select Name, PackageFullName"
    echo.
    echo "Choose the application to install from the list, and copy and paste the product identification code below (right column)"
    echo    In some cases, a reboot is required for it to take effect.
    set /p appname=APPID=
    POWERSHELL "Add-AppxPackage -Register 'C:\Program Files\WindowsApps\%appname%\appxmanifest.xml' -DisableDevelopmentMode"
    POWERSHELL Set-ExecutionPolicy Restricted
    pause
) else if "%option%"=="7" (
    :: download and install the latest video drivers with a web prompt, this is because many people use formats that are not natively recognized by the system, to make their installation easier
    POWERSHELL Invoke-WebRequest -Uri "https://free-codecs.com/download_soft.php?d=0c6f463b2b5ba2af6c8e5f8c55ed5243&s=1024&r=&f=hevc_video_extension.htm" -OutFile "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx" "%~p0"
    cd "%~p0"
    start Microsoft.HEVCVideoExtensionx64.Appx
    echo Done, run the Setup.exe and your program is installed.
    pause
) else if "%option%"=="8" (
    :: From Microsoft servers download an office iso with a trial version, and if the user has an active license all the features
    POWERSHELL Invoke-WebRequest -Uri "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img" -OutFile "C:\Users\%username%\Downloads\ProPlus2021Retail.img"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
    cd "%~p0"
    start ProPlus2021Retail.img
    echo Done, run the Setup.exe and your program is installed.
    pause
) else if "%option%"=="9" (
    POWERSHELL winget install --id Microsoft.PowerToys
    echo.
    pause
) else if "%option%"=="10" (
    :: winget searches the list of installed applications for available updates, if it finds them it installs them automatically
    POWERSHELL winget upgrade --all
    echo.
    pause
)

goto packages


:debloat
if "%restorePoint%"=="0" (
    echo Creating a Restore point
    powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "DebloatRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
    echo.
    set "restorePoint=1"
)

:: remove and disable OneDrive integration.
echo Remove OneDrive
taskkill.exe /F /IM "OneDrive.exe"
taskkill.exe /F /IM "explorer.exe"


if exist "%systemroot%\System32\OneDriveSetup.exe" (
    "%systemroot%\System32\OneDriveSetup.exe" /uninstall
)
if exist "%systemroot%\SysWOW64\OneDriveSetup.exe" (
    "%systemroot%\SysWOW64\OneDriveSetup.exe" /uninstall
)

echo Removing OneDrive leftovers
rmdir /s /q "%localappdata%\Microsoft\OneDrive"
rmdir /s /q "%programdata%\Microsoft OneDrive"
rmdir /s /q "%systemdrive%\OneDriveTemp"

echo check if directory is empty before removing:
for /f %%I in ('dir "%userprofile%\OneDrive" /a /b') do set count=1
if not %count%==0 (
    rmdir /s /q "%userprofile%\OneDrive"
)

echo Disable OneDrive via Group Policies
reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f

echo Remove OneDrive from explorer sidebar
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f
reg add "HKCR\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f

echo Removing run hook for new users
reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f
reg unload "hku\Default"

echo Removing startmenu entry
del /f /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\OneDrive.lnk"

echo Removing scheduled task
schtasks /delete /tn "OneDrive*" /f

echo Restarting explorer
start explorer.exe

timeout /t 10 /nobreak
:: == END ONEDRIVE PROCESS ==

:: removes unwanted Apps that come with Windows.
echo Uninstalling default apps
set "apps=Microsoft.549981C3F5F10 Microsoft.3DBuilder Microsoft.Appconnector Microsoft.BingFinance Microsoft.BingNews Microsoft.BingSports Microsoft.BingTranslator Microsoft.BingWeather Microsoft.GamingServices Microsoft.MicrosoftOfficeHub Microsoft.MicrosoftPowerBIForWindows Microsoft.MicrosoftSolitaireCollection Microsoft.MinecraftUWP Microsoft.NetworkSpeedTest Microsoft.Office.OneNote Microsoft.People Microsoft.Print3D Microsoft.SkypeApp Microsoft.Wallet Microsoft.WindowsAlarms Microsoft.WindowsCamera microsoft.windowscommunicationsapps Microsoft.WindowsMaps Microsoft.WindowsPhone Microsoft.WindowsSoundRecorder Microsoft.Xbox.TCUI Microsoft.XboxApp Microsoft.XboxGameOverlay Microsoft.XboxSpeechToTextOverlay Microsoft.YourPhone Microsoft.ZuneMusic Microsoft.ZuneVideo Microsoft.CommsPhone Microsoft.ConnectivityStore Microsoft.GetHelp Microsoft.Getstarted Microsoft.Messaging Microsoft.Office.Sway Microsoft.OneConnect Microsoft.WindowsFeedbackHub Microsoft.Microsoft3DViewer Microsoft.BingFoodAndDrink Microsoft.BingHealthAndFitness Microsoft.BingTravel Microsoft.WindowsReadingList Microsoft.MixedReality.Portal Microsoft.ScreenSketch Microsoft.XboxGamingOverlay 2FE3CB00.PicsArt-PhotoStudio 46928bounde.EclipseManager 4DF9E0F8.Netflix 613EBCEA.PolarrPhotoEditorAcademicEdition 6Wunderkinder.Wunderlist 7EE7776C.LinkedInforWindows 89006A2E.AutodeskSketchBook 9E2F88E3.Twitter A278AB0D.DisneyMagicKingdoms A278AB0D.MarchofEmpires ActiproSoftwareLLC.562882FEEB491 CAF9E577.Plex ClearChannelRadioDigital.iHeartRadio D52A8D61.FarmVille2CountryEscape D5EA27B7.Duolingo-LearnLanguagesforFree DB6EA5DB.CyberLinkMediaSuiteEssentials DolbyLaboratories.DolbyAccess DolbyLaboratories.DolbyAccess Drawboard.DrawboardPDF Facebook.Facebook Fitbit.FitbitCoach Flipboard.Flipboard GAMELOFTSA.Asphalt8Airborne KeeperSecurityInc.Keeper NORDCURRENT.COOKINGFEVER PandoraMediaInc.29680B314EFC2 Playtika.CaesarsSlotsFreeCasino ShazamEntertainmentLtd.Shazam SlingTVLLC.SlingTV SpotifyAB.SpotifyMusic ThumbmunkeysLtd.PhototasticCollage TuneIn.TuneInRadio WinZipComputing.WinZipUniversal XINGAG.XING flaregamesGmbH.RoyalRevolt2 king.com.* king.com.BubbleWitch3Saga king.com.CandyCrushSaga king.com.CandyCrushSodaSaga A025C540.Yandex.Music"
for %%i in (%apps%) do (
    echo Trying to remove %%i
    PowerShell -Command "Get-AppxPackage -Name '%%i' -AllUsers | Remove-AppxPackage -AllUsers"
    PowerShell -Command "$appxprovisionedpackage = Get-AppxProvisionedPackage -Online; ($appxprovisionedpackage | Where-Object { $_.DisplayName -eq '%%i' }) | Remove-AppxProvisionedPackage -Online"
)

echo Prevents Apps from re-installing
set "cdm=ContentDeliveryAllowed FeatureManagementEnabled OemPreInstalledAppsEnabled PreInstalledAppsEnabled PreInstalledAppsEverEnabled SilentInstalledAppsEnabled SubscribedContent-314559Enabled SubscribedContent-338387Enabled SubscribedContent-338388Enabled SubscribedContent-338389Enabled SubscribedContent-338393Enabled SubscribedContentEnabled SystemPaneSuggestionsEnabled"
for %%i in (%cdm%) do (
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v %%i /t REG_DWORD /d 0 /f
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
:: == END APPS PROCESS ==

:: disables unwanted Windows services.
echo Disabling unwanted Windows services
set "services=diagnosticshub.standardcollector.service DiagTrack dmwappushservice lfsvc MapsBroker NetTcpPortSharing RemoteAccess RemoteRegistry SharedAccess TrkWks WbioSrvc WMPNetworkSvc XblAuthManager XblGameSave XboxNetApiSvc ndu"

for %%i in (%services%) do (
    echo Trying to disable %%i
    sc config "%%i" start= disabled
    net stop "%%i" >nul 2>&1
)
:: == END SERVICES ==

:: blocks telemetry related domains via the hosts file and related IPs via Windows Firewall.
echo Disabling telemetry via Group Policies
set "telemetryKey=HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
set "telemetryValue=AllowTelemetry"
reg add "%telemetryKey%" /v "%telemetryValue%" /t REG_DWORD /d 0 /f

echo Adding telemetry domains to hosts file
set "hostsFile=%SystemRoot%\System32\drivers\etc\hosts"
set "domains=184-86-53-99.deploy.static.akamaitechnologies.com a-0001.a-msedge.net a-0002.a-msedge.net a-0003.a-msedge.net a-0004.a-msedge.net a-0005.a-msedge.net a-0006.a-msedge.net a-0007.a-msedge.net a-0008.a-msedge.net a-0009.a-msedge.net a1621.g.akamai.net a1856.g2.akamai.net a1961.g.akamai.net a978.i6g1.akamai.net a.ads1.msn.com a.ads2.msads.net a.ads2.msn.com ac3.msn.com ad.doubleclick.net adnexus.net adnxs.com ads1.msads.net ads1.msn.com ads.msn.com aidps.atdmt.com aka-cdn-ns.adtech.de a-msedge.net any.edge.bing.com a.rad.msn.com az361816.vo.msecnd.net az512334.vo.msecnd.net b.ads1.msn.com b.ads2.msads.net bingads.microsoft.com b.rad.msn.com bs.serving-sys.com c.atdmt.com cdn.atdmt.com cds26.ams9.msecn.net choice.microsoft.com choice.microsoft.com.nsatc.net compatexchange.cloudapp.net corpext.msitadfs.glbdns2.microsoft.com corp.sts.microsoft.com cs1.wpc.v0cdn.net db3aqu.atdmt.com df.telemetry.microsoft.com diagnostics.support.microsoft.com e2835.dspb.akamaiedge.net e7341.g.akamaiedge.net e7502.ce.akamaiedge.net e8218.ce.akamaiedge.net ec.atdmt.com fe2.update.microsoft.com.akadns.net feedback.microsoft-hohm.com feedback.search.microsoft.com feedback.windows.com flex.msn.com g.msn.com h1.msn.com h2.msn.com hostedocsp.globalsign.com i1.services.social.microsoft.com i1.services.social.microsoft.com.nsatc.net lb1.www.ms.akadns.net live.rads.msn.com m.adnxs.com msedge.net msnbot-65-55-108-23.search.msn.com msntest.serving-sys.com oca.telemetry.microsoft.com oca.telemetry.microsoft.com.nsatc.net onesettings-db5.metron.live.nsatc.net pre.footprintpredict.com preview.msn.com rad.live.com rad.msn.com redir.metaservices.microsoft.com reports.wes.df.telemetry.microsoft.com schemas.microsoft.akadns.net secure.adnxs.com secure.flashtalking.com services.wes.df.telemetry.microsoft.com settings-sandbox.data.microsoft.com sls.update.microsoft.com.akadns.net sqm.df.telemetry.microsoft.com sqm.telemetry.microsoft.com sqm.telemetry.microsoft.com.nsatc.net ssw.live.com static.2mdn.net statsfe1.ws.microsoft.com statsfe2.update.microsoft.com.akadns.net statsfe2.ws.microsoft.com survey.watson.microsoft.com telecommand.telemetry.microsoft.com telecommand.telemetry.microsoft.com.nsatc.net telemetry.appex.bing.net telemetry.microsoft.com telemetry.urs.microsoft.com vortex-bn2.metron.live.com.nsatc.net vortex-cy2.metron.live.com.nsatc.net vortex.data.microsoft.com vortex-sandbox.data.microsoft.com vortex-win.data.microsoft.com cy2.vortex.data.microsoft.com.akadns.net watson.live.com watson.microsoft.com watson.ppe.telemetry.microsoft.com watson.telemetry.microsoft.com watson.telemetry.microsoft.com.nsatc.net wes.df.telemetry.microsoft.com win10.ipv6.microsoft.com www.bingads.microsoft.com www.go.microsoft.akadns.net client.wns.windows.com wdcpalt.microsoft.com settings-ssl.xboxlive.com settings-ssl.xboxlive.com-c.edgekey.net settings-ssl.xboxlive.com-c.edgekey.net.globalredir.akadns.net e87.dspb.akamaidege.net insiderservice.microsoft.com insiderservice.trafficmanager.net e3843.g.akamaiedge.net flightingserviceweurope.cloudapp.net www-google-analytics.l.google.com hubspot.net.edge.net e9483.a.akamaiedge.net stats.g.doubleclick.net stats.l.doubleclick.net adservice.google.de adservice.google.com googleads.g.doubleclick.net pagead46.l.doubleclick.net hubspot.net.edgekey.net livetileedge.dsx.mp.microsoft.com fe2.update.microsoft.com.akadns.net s0.2mdn.net statsfe2.update.microsoft.com.akadns.net survey.watson.microsoft.com view.atdmt.com watson.microsoft.com watson.ppe.telemetry.microsoft.com watson.telemetry.microsoft.com watson.telemetry.microsoft.com.nsatc.net wes.df.telemetry.microsoft.com"
(for %%i in (%domains%) do (
    findstr /i /c:"%%i" "!hostsFile!" >nul || echo 0.0.0.0 %%i
)) >> "!hostsFile!"

echo Adding telemetry IPs to firewall
set "ips=134.170.30.202 137.116.81.24 157.56.106.189 184.86.53.99 2.22.61.43 2.22.61.66 204.79.197.200 23.218.212.69 65.39.117.230 65.55.108.23 64.4.54.254 8.36.80.197 8.36.80.224 8.36.80.252 8.36.113.118 8.36.113.141 8.36.80.230 8.36.80.231 8.36.113.126 8.36.80.195 8.36.80.217 8.36.80.237 8.36.80.246 8.36.113.116 8.36.113.139 8.36.80.244 216.228.121.209"
for %%i in (%ips%) do (
    netsh advfirewall firewall add rule name="Block Telemetry IP %%i" dir=out action=block remoteip=%%i
)

echo Blocking scheduled telemetry tasks
schtasks /Change /Disable /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /Change /Disable /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
schtasks /Change /Disable /TN "\Microsoft\Windows\Application Experience\StartupAppTask"
schtasks /Change /Disable /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
:: == END TELEMETRY PROCESS ==

:: optimizes Windows updates by disabling automatic download and seeding updates to other computers.
echo Disable automatic download and installation of Windows updates
reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallDay" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "ScheduledInstallTime" /t REG_DWORD /d 3 /f

echo Disable seeding of updates to other computers via Group Policies
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f

:: echo "Disabling automatic driver update"
:: reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f

echo Disable 'Updates are available' message
takeown /F "%WinDir%\System32\MusNotification.exe"
icacls "%WinDir%\System32\MusNotification.exe" /deny "!EveryOne!:(X)"
takeown /F "%WinDir%\System32\MusNotificationUx.exe"
icacls "%WinDir%\System32\MusNotificationUx.exe" /deny "!EveryOne!:(X)"
:: == END AUTOUPDATE PROCESS ==

echo Done, Please restart the app to continue using.

taskkill /f /im explorer.exe
start explorer.exe

pause
endlocal
exit /b
