@echo off

color 17
title Win Tools V1.0

REM Check administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    color 4f
    title Win Tools requires ADMINISTRATOR PRIVILEGES
    echo The script is not running with administrative privileges.
    echo Please run the script as administrator.
    pause
    exit /b
)

REM If "%1" the process is executed in a way other than the maximized one, it starts a new minimized process and closes the process that was not maximized
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b

REM Define a variable to check if a restore point has been made in case of making unwanted changes to the system.
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
echo.       =        EXIT                                                                     =
echo.       =        0]     Go Out                                                            =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.

set /p option="Option: "

if "%option%"=="0" (
    exit /b
) else if "%option%"=="1" (
    goto system_shortcuts
) else if "%option%"=="2" (
    goto process_and_services
) else if "%option%"=="3" (
    goto system_settings
) else if "%option%"=="4" (
    goto packages
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
    eventvwr
    pause
) else if "%option%"=="8" (
    C:\WINDOWS\System32\appwiz.cpl
    pause
) else if "%option%"=="9" (
    C:\WINDOWS\System32\control.exe system
    pause
) else if "%option%"=="10" (
    C:\WINDOWS\System32\inetcpl.cpl
    pause
) else if "%option%"=="11" (
    ipconfig
    pause
) else if "%option%"=="12" (
    perfmon
    pause
) else if "%option%"=="13" (
    resmon
    pause
) else if "%option%"=="14" (
    C:\WINDOWS\System32\taskmgr.exe /7
    pause
) else if "%option%"=="15" (
    regedt32
    pause
) else if "%option%"=="16" (
    rstrui
    pause
) else if "%option%"=="17" (
    msconfig
    pause
) else if "%option%"=="18" (
    dxdiag
    pause
) else if "%option%"=="19" (
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
        REM no policy restrictions creates a system restore point, so if something goes wrong, the computer is not affected
        echo Creating a Restore point
        powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "FixItToolsRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
        echo.
        set "restorePoint=1"
    )
    REM sc stop "Name of Service"
    REM sc config "Name of Service" start= disabled
    sc stop defragsvc& sc config defragsvc start= disabled
    sc stop SysMain& sc config SysMain start= disabled
    sc stop Fax& sc config Fax start= disabled
    sc stop RemoteRegistry& sc config RemoteRegistry start= disable
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
    REM scans the drive for deleted files where the user indicates in the filter
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
    REM Disable Windows Telemetry through the System Registry
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
    REM Restart the telemetry service
    net stop DiagTrack
    net stop dmwappushservice
    echo Telemetry disabled successfully.
    echo.
    pause
) else if "%option%"=="5" (
    REM Stop the Windows Update service
    net stop wuauserv
    REM Disable automatic updates through the Registry
    REM NoAutoUpdate = 1 : Activated the blocking of updates
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
    echo Automatic updates successfully disabled.
    echo.
    pause
) else if "%option%"=="6" (
    REM Activate automatic updates through the Registry
    @REM NoAutoUpdate = 0 : Disabled Lock
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f
    @REM Activate the windows update service
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
echo.       =      8]  EXTRA settings                                                         =
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
    REM activates all the registry keys needed to run the old windows viewer which has amazing performance
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
    REM set the execution privacy log setting to enabled
    echo. Security Layer Enabled
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 1 /f
    echo.
    pause
) else if "%option%"=="3" (
    REM set the runtime privacy section registry setting to disabled
    echo. Security Layer Disabled
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f
    echo.
    pause
) else if "%option%"=="4" (
    REM Create module in the registry to enable the old menu.
    echo. Old Menu Enabled
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
    taskkill /f /im explorer.exe
    start explorer.exe
    echo.
    pause
) else if "%option%"=="5" (
    REM Delete menu module
    echo. Old Menu Disabled
    reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
    taskkill /f /im explorer.exe
    start explorer.exe
    echo.
    pause
) else if "%option%"=="6" (
    REM run internal browser commands to disable extensions due to crashes, errors, or conflicts
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-extensions
    "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-extensions
    echo.
    pause
) else if "%option%"=="7" (
    REM Disable execution of unsigned PowerShell scripts
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d "RemoteSigned" /f
    echo Execution of unsigned PowerShell scripts successfully disabled.
    echo.
    pause
) else if "%option%"=="8" (
    if exist "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" (
        start explorer.exe "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 
    ) else (
        mkdir "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 
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
echo.       =       4]  Install All WindowsApps                                               =
echo.       =                                                                                 =
echo.       =       5]  Install Selection of WindowsApps                                      =
echo.       =                                                                                 =
echo.       =       6]  Install HEVC (H.265) Video Codec                                      =
echo.       =                                                                                 =
echo.       =       7]  Install Office 2021 (without license)                                 =
echo.       =                                                                                 =
echo.       =       8]  PowerToys                                                             =
echo.       =                                                                                 =
echo.       =       9]  Update All Apps                                                       =
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
    REM Uninstall the indicated apps automatically with all necessary permissions.
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
    REM In order for it to be uninstalled, it is necessary for the program to contain an uninstaller in its data folder && There are programs that do not fully integrate it, so it is not possible to uninstall it this way
    :next
    set /p produn=AppUni=
    WMIC product where name="%produn%" call uninstall
    echo.
    pause
) else if "%option%"=="2" (
    REM Uninstall automatically indicated system-owned apps with all necessary permissions.
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
    REM set the execution policies to unrestricted so that you can manipulate system applications without inconvenience
    PowerShell Set-ExecutionPolicy Unrestricted
    echo.
    set /p appak=APPID=
    REM PFinally, the execution restriction is placed again since otherwise it would be dangerous to leave it unlimited since anything could be installed on the computer without you knowing it
    POWERSHELL Remove-AppxPackage "%appak%"
    echo.
    PowerShell Set-ExecutionPolicy Restricted
    set /p opt="Continue or go to menu? [C/M]"
    if "%opt%" == "c" goto next2
    if "%opt%" == "C" goto next2
    pause
) else if "%option%"=="3" (
    REM download and run the office uninstall tool, as many times its internal uninstaller leaves residual files and keys that prevent the installation of a new instance.
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
    PowerShell Set-ExecutionPolicy Unrestricted
    REM registers a new application installation that has the Windows installer
    POWERSHELL "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register ""$($_.InstallLocation)\appxmanifest.xml"" -DisableDevelopmentMode}"
    REM Add-AppxPackage : Deployment error with HRESULT: 0x80073D02, The package could not be installed because the resources it modifies are currently in use.
    REM if the above message comes out, then the command is executed successfully
    PowerShell Set-ExecutionPolicy Restricted
    echo. Installation successful
    pause
) else if "%option%"=="5" (
    POWERSHELL Set-ExecutionPolicy Unrestricted
    REM displays a list of apps you have available to install
    POWERSHELL "Get-AppxPackage -AllUsers | Select Name, PackageFullName"
    echo.
    echo "Choose the application to install from the list, and copy and paste the product identification code below (right column)"
    echo    In some cases, a reboot is required for it to take effect.
    set /p appname=APPID=
    POWERSHELL "Add-AppxPackage -Register 'C:\Program Files\WindowsApps\%appname%\appxmanifest.xml' -DisableDevelopmentMode"
    POWERSHELL Set-ExecutionPolicy Restricted
    pause
) else if "%option%"=="6" (
    REM download and install the latest video drivers with a web prompt, this is because many people use formats that are not natively recognized by the system, to make their installation easier
    POWERSHELL Invoke-WebRequest -Uri "https://free-codecs.com/download_soft.php?d=0c6f463b2b5ba2af6c8e5f8c55ed5243&s=1024&r=&f=hevc_video_extension.htm" -OutFile "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx" "%~p0"
    cd "%~p0"
    start Microsoft.HEVCVideoExtensionx64.Appx
    echo Done, run the Setup.exe and your program is installed.
    pause
) else if "%option%"=="7" (
    REM From Microsoft servers download an office iso with a trial version, and if the user has an active license all the features
    POWERSHELL Invoke-WebRequest -Uri "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img" -OutFile "C:\Users\%username%\Downloads\ProPlus2021Retail.img"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
    cd "%~p0"
    start ProPlus2021Retail.img
    echo Done, run the Setup.exe and your program is installed.
    pause
) else if "%option%"=="8" (
    POWERSHELL winget install --id Microsoft.PowerToys
    echo.
    pause
) else if "%option%"=="9" (
    REM winget searches the list of installed applications for available updates, if it finds them it installs them automatically
    POWERSHELL winget upgrade --all
    echo.
    pause
)

goto packages
