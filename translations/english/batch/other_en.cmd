:tl4
cls
echo.
echo.
echo.       ===================================================================================
echo.       =                                    EXTRA TOOLS                                  =
echo.       ===================================================================================
echo.       =       0]  Back                                                                  =
echo.       =                                                                                 =
echo.       =   _APPLICATIONS_                                                                =
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
echo.       =       8]  Update All Apps                                                       =
echo.       =                                                                                 =
echo.       =       9]  Install PowerToys                                                     =
echo.       =                                                                                 =
echo.       =   _PROCESSES AND SERVICES_                                                      =
echo.       =      10]  Stop Unnecessary Services                                             =
echo.       =                                                                                 =
echo.       =      11]  Recover Deleted Files                                                 =
echo.       =                                                                                 =
echo.       =      12]  Disable Telemetry Collection                                          =
echo.       =                                                                                 =
echo.       =      13]  Disable Automatic Updates (Windows Update)                            =
echo.       =                                                                                 =
echo.       =      14]  Activate Automatic Updates (Windows Update)                           =
echo.       =                                                                                 =
echo.       =   _SETTINGS_                                                                    =
echo.       =      15]  Activate Old Photo Viewer                                             =
echo.       =                                                                                 =
echo.       =      16]  Add security layer to the System against Malware Execution            =
echo.       =                                                                                 =
echo.       =      17]  Remove security layer to the System against Malware Execution         =
echo.       =                                                                                 =
echo.       =      18]  Remove the New Menu Design from Windows 11                            =
echo.       =                                                                                 =
echo.       =      19]  Return to the New Windows 11 Menu Design                              =
echo.       =                                                                                 =
echo.       =      20]  Disable All Web Extensions (Chrome and Edge)                          =
echo.       =                                                                                 =
echo.       =      21]  Disable Execution of Unsigned PS Scripts                              =
echo.       =                                                                                 =
echo.       =      22]  EXTRA settings                                                        =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.
echo.
set /p tool=Opcion =   
if "%tool%" == "0" (
    cd "%~p0"
    cd..
    main_es.cmd
)
if "%tool%" == "1" (
    @REM Uninstall the indicated apps automatically with all necessary permissions.
    echo.
    WMIC product get name
    echo.
    echo. Copy and paste below the app name shown in the top list to uninstall it
    echo.
    echo. WARNING
    echo. 
    echo. You are about to delete the specified application. This action is irreversible. Are you sure you want to continue?
    set /p ans.4op3="Do you agree? [Y/N]"
    echo.
    if "%ans.4op3%" == "S" goto 4op3.next
    if "%ans.4op3%" == "s" goto 4op3.next
    if "%ans.4op3%" == "N" goto tl4
    if "%ans.4op3%" == "n" goto tl4
    if not "%ans.4op3%" == "S, s, N or n" goto salir
    @REM In order for it to be uninstalled, it is necessary for the program to contain an uninstaller in its data folder && There are programs that do not fully integrate it, so it is not possible to uninstall it this way
    :4op3.next
    set /p produn=AppUni=
    WMIC product where name="%produn%" call uninstall
    echo.
    pause
    goto tl4
)
if "%tool%" == "2" (
    @REM Uninstall automatically indicated system-owned apps with all necessary permissions.
    echo.
    POWERSHELL "Get-AppxPackage | Select Name, PackageFullName"
    echo.
    echo. "Copy and paste below the app name shown in the top (right) list to uninstall it"
    echo.
    echo. WARNING
    echo. 
    echo. You are about to delete the specified application. This action is irreversible. Are you sure you want to continue?
    set /p ans.4op4="Do you agree? [Y/N]"
    echo.
    if "%ans.4op4%" == "S" goto 4op4.next
    if "%ans.4op4%" == "s" goto 4op4.next
    if "%ans.4op4%" == "N" goto tl4
    if "%ans.4op4%" == "n" goto tl4
    goto tl4
    :4op4.next
    @REM set the execution policies to unrestricted so that you can manipulate system applications without inconvenience
    PowerShell Set-ExecutionPolicy Unrestricted
    echo.
    set /p appak=APPID=
    @REM PFinally, the execution restriction is placed again since otherwise it would be dangerous to leave it unlimited since anything could be installed on the computer without you knowing it
    POWERSHELL Remove-AppxPackage "%appak%"
    echo.
    PowerShell Set-ExecutionPolicy Restricted
    set /p opt="Continue or go to menu? [C/M]"
    if "%opt%" == "c" goto 4op4.next
    if "%opt%" == "C" goto 4op4.next
    pause
    goto tl4
)
if "%tool%" == "3" (
    @REM download and run the office uninstall tool, as many times its internal uninstaller leaves residual files and keys that prevent the installation of a new instance.
    POWERSHELL Invoke-WebRequest -Uri "https://aka.ms/SaRA-officeUninstallFromPC" -OutFile "C:\Users\%username%\Downloads\SetupProd_OffScrub.exe"
    timeout 5
    move C:\Users\%username%\Downloads\SetupProd_OffScrub.exe "%~p0"
    cd "%~p0"
    start SetupProd_OffScrub.exe
    pause
    del SetupProd_OffScrub.exe /f /s /q
    echo.
    pause
    goto tl4
)
if "%tool%" == "4" (
    echo.
    PowerShell Set-ExecutionPolicy Unrestricted
    @REM registers a new application installation that has the Windows installer
    POWERSHELL "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register ""$($_.InstallLocation)\appxmanifest.xml"" -DisableDevelopmentMode}"
    @REM Add-AppxPackage : Deployment error with HRESULT: 0x80073D02, The package could not be installed because the resources it modifies are currently in use.
    @REM if the above message comes out, then the command is executed successfully
    PowerShell Set-ExecutionPolicy Restricted
    echo.
    echo. Installation successful
    pause
    goto tl4
)
if "%tool%" == "5" (
    echo.
    POWERSHELL Set-ExecutionPolicy Unrestricted
    echo.
    @REM displays a list of apps you have available to install
    POWERSHELL "Get-AppxPackage -AllUsers | Select Name, PackageFullName"
    echo.
    echo "Choose the application to install from the list, and copy and paste the product identification code below (right column)"
    echo    In some cases, a reboot is required for it to take effect.
    set /p appname=APPID=
    POWERSHELL "Add-AppxPackage -Register 'C:\Program Files\WindowsApps\%appname%\appxmanifest.xml' -DisableDevelopmentMode"
    POWERSHELL Set-ExecutionPolicy Restricted
    pause
    goto tl4
)
if "%tool%" == "6" (
    @REM download and install the latest video drivers with a web prompt, this is because many people use formats that are not natively recognized by the system, to make their installation easier
    POWERSHELL Invoke-WebRequest -Uri "https://free-codecs.com/download_soft.php?d=0c6f463b2b5ba2af6c8e5f8c55ed5243&s=1024&r=&f=hevc_video_extension.htm" -OutFile "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx" "%~p0"
    cd "%~p0"
    start Microsoft.HEVCVideoExtensionx64.Appx
    echo Done, run the Setup.exe and your program is installed.
    pause
    goto tl4
)
if "%tool%" == "7" (
    @REM From Microsoft servers download an office iso with a trial version, and if the user has an active license all the features
    POWERSHELL Invoke-WebRequest -Uri "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img" -OutFile "C:\Users\%username%\Downloads\ProPlus2021Retail.img"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
    cd "%~p0"
    start ProPlus2021Retail.img
    echo Done, run the Setup.exe and your program is installed.
    pause
    goto tl4
)
if "%tool%" == "8" (
    echo.
    @REM winget searches the list of installed applications for available updates, if it finds them it installs them automatically
    POWERSHELL winget upgrade --all
    echo.
    pause
    goto tl4
)
if "%tool%" == "9" (
    echo.
    POWERSHELL winget install --id Microsoft.PowerToys
    echo.
    pause
    goto tl4
)
if "%tool%" == "10" (
    echo.
    @REM no policy restrictions creates a system restore point, so if something goes wrong, the computer is not affected
    echo Creating a Restore point
    powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description "FixItRestorePoint" -RestorePointType "MODIFY_SETTINGS""&powershell exit
    echo.
    @REM sc stop "Name of Service"
    @REM sc config "Name of Service" start= disabled
    sc stop defragsvc& sc config defragsvc start= disabled
    sc stop XblGameSave& sc config XblGameSave start= disabled
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
    sc stop XboxNetApiSvc& sc config XboxNetApiSvc start= disabled
    sc stop XboxGipSvc& sc config XboxGipSvc start= disabled
    sc stop RmSvc& sc config RmSvc start= disabled
    pause
    goto tl4
)
if "%tool%" == "11" (
    echo.
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
    @REM scans the drive for deleted files where the user indicates in the filter
    winfr "%search%" "%save%" /regular %filters%
    echo.
    pause
    goto tl4
)
if "%tool%" == "12" (
    @REM Disable Windows Telemetry through the System Registry
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
    @REM Restart the telemetry service
    net stop DiagTrack
    net stop dmwappushservice
    echo.
    echo Telemetry disabled successfully.
    echo.
    pause
    goto tl4
)
if "%tool%" == "13" (
    @REM Stop the Windows Update service
    net stop wuauserv
    @REM Disable automatic updates through the Registry
    @REM NoAutoUpdate = 1 : Activated the blocking of updates
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
    echo.
    echo Automatic updates successfully disabled.
    echo.
    pause
    goto tl4
)
if "%tool%" == "14" (
    @REM Activate automatic updates through the Registry
    @REM NoAutoUpdate = 0 : Disabled Lock
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f
    @REM Activate the windows update service
    net start wuauserv
    echo.
    echo Automatic updates successfully enabled.
    echo.
    pause
    goto tl4
)
if "%tool%" == "15" (
    @REM activates all the registry keys needed to run the old windows viewer which has amazing performance
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "ImageOptionFlags" /t REG_DWORD /d 00000001 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\DefaultIcon" /ve /t REG_EXPAND_SZ /d "%SystemRoot%\System32\imageres.dll,-70" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\command" /ve /t REG_EXPAND_SZ /d "\"%SystemRoot%\System32\cmd.exe\" /c \"\"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll\" \"%1\"\"" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.Bitmap\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "EditFlags" /t REG_DWORD /d 00010000 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "ImageOptionFlags" /t REG_DWORD /d 00000001 /f
    reg add "HKEY_CLASSES_ROOT\PhotoViewer.FileAssoc.JFIF" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll,-3056" /f
    pause
    goto tl4
)
if "%tool%" == "16" (
    echo. Security Layer Enabled
    @REM set the execution privacy log setting to enabled
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 1 /f
    echo. Done...
    pause
    goto tl4
)
if "%tool%" == "17" (
    echo. Security Layer Disabled
    @REM set the runtime privacy section registry setting to disabled
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f
    echo. Done...
    pause
    goto tl4
)
if "%tool%" == "18" (
    @REM Create module in the registry to enable the old menu.
    echo. Old Menu Enabled
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
    taskkill /f /im explorer.exe
    start explorer.exe
    echo.
    pause
    goto tl4
)
if "%tool%" == "19" (
    @REM Delete menu module
    echo. Old Menu Disabled
    reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
    taskkill /f /im explorer.exe
    start explorer.exe
    echo.
    pause
    goto tl4
)
if "%tool%" == "20" (
    echo.
    @REM run internal browser commands to disable extensions due to crashes, errors, or conflicts
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-extensions
    "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-extensions
    echo.
    pause
    goto tl4
)
if "%tool%" == "21" (
    @REM Disable execution of unsigned PowerShell scripts
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d "RemoteSigned" /f
    echo.
    echo Execution of unsigned PowerShell scripts successfully disabled.
    pause
    goto tl4
)
if "%tool%" == "22" (
    if exist "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" (
        start explorer.exe "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 
    ) else (
        mkdir "GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" 
    )
    pause
    goto tl4
) else (
    goto tl4
)