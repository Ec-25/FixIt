:tl4
cls

echo.
echo.
echo.       ===================================================================================
echo.       =                                    EXTRA TOOLS                                  =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =      1]   Stop Unnecessary Services                                             =
echo.       =                                                                                 =
echo.       =      2]   Uninstall Apps                                                        =
echo.       =                                                                                 =
echo.       =      3]   Uninstall Windows Apps                                                =
echo.       =                                                                                 =
echo.       =      4]   Uninstall Office                                                      =
echo.       =                                                                                 =
echo.       =      5]   Install All WindowsApps                                               =
echo.       =                                                                                 =
echo.       =      6]   Install Selection of WindowsApps                                      =
echo.       =                                                                                 =
echo.       =      7]   Install Updated HEVC (H.265) Video Codec                              =
echo.       =                                                                                 =
echo.       =      8]   Install Office 2021 (without-license)                                 =
echo.       =                                                                                 =
echo.       =      9]   Activate Old Photo Viewer                                             =
echo.       =                                                                                 =
echo.       =      10]  Add security layer to the System against Malware Execution            =
echo.       =                                                                                 =
echo.       =      11]  Remove security layer to the System against Malware Execution         =
echo.       =                                                                                 =
echo.       =      12]  Disable All Web Extensions (Chrome and Edge)                          =
echo.       =                                                                                 =
echo.       =      13]  Update All Available System Applications                              =
echo.       =                                                                                 =
echo.       =      14]  Install PowerToys                                                     =
echo.       =                                                                                 =
echo.       =      15]  Recover Deleted Files                                                 =
echo.       =                                                                                 =
echo.       =      0]   Exit                                                                  =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
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
    @REM without policy restrictions creates a system restore point, so if something goes wrong, the computer is not affected
    echo Creating a restore point
    powershell -ExecutionPolicy Bypass -NoExit -Command "Checkpoint-Computer -Description "FixItRestorePoint" -RestorePointType "MODIFY_SETTINGS""& powershell exit
    echo.
    @REM sc stop "Name of Service"
    @REM sc config "Name of Service" start= disabled
    sc stop defragsvc& sc config defragsvc start= disabled
    sc stop XblGameSave& sc config XblGameSave start= disabled
    sc stop SysMain& sc config SysMain start= disabled
    sc stop Fax& sc config Fax start= disabled
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
if "%tool%" == "2" (
    @REM Uninstall the listed apps automatically with all necessary permissions.
    echo.
    WMIC product get name
    echo.
    echo. Copy and paste below the app name shown in the top list to uninstall it
    echo.
    echo. WARNING
    echo. 
    echo. You are about to delete the specified application. This action is irreversible. Are you sure you want to continue?
    set /p ans.4op3="Do you agree?[y/n]"
    echo.
    if "%ans.4op3%" == "Y" goto 4op3.next
    if "%ans.4op3%" == "y" goto 4op3.next
    if "%ans.4op3%" == "N" goto tl4
    if "%ans.4op3%" == "n" goto tl4
    if not "%ans.4op3%" == "Y, y, N or n" goto salir
    @REM In order for it to be uninstalled, it is necessary for the program to contain an uninstaller in its data folder && There are programs that do not fully integrate it, so it is not possible to uninstall it this way
    :4op3.next
    set /p produn=AppUni=
    WMIC product where name="%produn%" call uninstall
    echo.
    pause
    goto tl4
)
if "%tool%" == "3" (
    @REM Uninstall automatically indicated system-owned apps with all necessary permissions.
    echo.
    POWERSHELL "Get-AppxPackage | Select Name, PackageFullName"
    echo.
    echo. "Copy and paste below the app name shown in the top (right) list to uninstall it"
    echo.
    echo. WARNING
    echo. 
    echo. You are about to delete the specified application. This action is irreversible. Are you sure you want to continue?
    set /p ans.4op4="Do you agree?[y/n]"
    echo.
    if "%ans.4op4%" == "Y" goto 4op4.next
    if "%ans.4op4%" == "y" goto 4op4.next
    if "%ans.4op4%" == "N" goto tl4
    if "%ans.4op4%" == "n" goto tl4
    goto tl4
    :4op4.next
    @REM set the execution policies to unrestricted in order to be able to manipulate system applications without issue
    PowerShell Set-ExecutionPolicy Unrestricted
    echo.
    set /p appak=APPID=
    @REM Finally the execution restriction is put back since otherwise it would be dangerous to leave it unlimited since anything could be installed on the computer without you knowing.
    POWERSHELL Remove-AppxPackage "%appak%"
    echo.
    PowerShell Set-ExecutionPolicy Restricted
    set /p opt="Continue or go to menu? [c / m]"
    if "%opt%" == "c" goto 4op4.next
    if "%opt%" == "C" goto 4op4.next
    pause
    goto tl4
)
if "%tool%" == "4" (
    @REM downloads and runs the office uninstall tool, as many times its internal uninstaller leaves residual files and keys that prevent a new instance from being installed.
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
if "%tool%" == "5" (
    echo.
    PowerShell Set-ExecutionPolicy Unrestricted
    @REM registers a new application installation that has the Windows installer
    POWERSHELL "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register ""$($_.InstallLocation)\appxmanifest.xml"" -DisableDevelopmentMode}"
    REM Add-AppxPackage : Deployment error with HRESULT: 0x80073D02, The package could not be installed because the resources it modifies are currently in use.
    REM if the above message appears, then the command was executed successfully
    PowerShell Set-ExecutionPolicy Restricted
    echo.
    echo. Installation successful
    pause
    goto tl4
)
if "%tool%" == "6" (
    echo.
    POWERSHELL Set-ExecutionPolicy Unrestricted
    echo.
    @REM displays a list of applications that are available to install
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
if "%tool%" == "7" (
    POWERSHELL Invoke-WebRequest -Uri "https://free-codecs.com/download_soft.php?d=0c6f463b2b5ba2af6c8e5f8c55ed5243&s=1024&r=&f=hevc_video_extension.htm" -OutFile "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\Microsoft.HEVCVideoExtensionx64.Appx" "%~p0"
    cd "%~p0"
    start Microsoft.HEVCVideoExtensionx64.Appx
    echo Ready, run the Setup.exe and your program will be installed.
    pause
    goto tl4
)
if "%tool%" == "8" (
    @REM From Microsoft servers download an office iso with a trial version, and if the user has an active license all the features
    POWERSHELL Invoke-WebRequest -Uri "https://officecdn.microsoft.com/db/492350f6-3a01-4f97-b9c0-c7c6ddf67d60/media/en-us/ProPlus2021Retail.img" -OutFile "C:\Users\%username%\Downloads\ProPlus2021Retail.img"
    timeout 5
    MOVE "C:\Users\%username%\Downloads\ProPlus2021Retail.img" "%~p0"
    cd "%~p0"
    start ProPlus2021Retail.img
    echo Ready, run the Setup.exe and your program will be installed.
    pause
    goto tl4
)
if "%tool%" == "9" (
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
if "%tool%" == "10" (
    echo. Security Layer Enabled
    @REM set the execution privacy log setting to enabled
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 1 /f
    echo. Done...
    pause
    goto tl4
)
if "%tool%" == "11" (
    echo. Security Layer Disabled
    @REM set the execution privacy section registry setting to disabled
    reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5 /f
    echo. Done...
    pause
    goto tl4
)
if "%tool%" == "12" (
    echo.
    @REM runs internal browser commands to disable extensions due to crashes, errors, or conflicts
    "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-extensions
    "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --disable-extensions
    echo.
    pause
    goto tl4
)
if "%tool%" == "13" (
    echo.
    @REM winget searches the list of installed applications for available updates, if it finds them it installs them automatically
    POWERSHELL winget upgrade --all
    echo.
    pause
    goto tl4
)
if "%tool%" == "14" (
    echo.
    POWERSHELL winget install --id Microsoft.PowerToys
    echo.
    pause
    goto tl4
)
if "%tool%" == "15" (
    echo.
    set /p inst="Do you have 'Windows File Recovery' installed? [Y/n]"
    if "%inst%" == "y" goto continue
    if "%inst%" == "Y" goto continue
    if "%inst%" == "" goto continue
    :install
    start https://apps.microsoft.com/store/detail/windows-file-recovery/9N26S50LN705
    pause
    :continue
    echo.
    set /p search="Location to Search:[C://...] "
    set /p save="Location to Store the Found:[C://...] "
    set /p filters="filters[/n ''user\<username>\download'' /n ''*.pdf''] "
    @REM scans the drive for deleted files where the user indicates in the filter
    winfr "%search%" "%save%" /regular %filters%
    echo.
    pause
    goto tl4
)
else (
    goto tl4
)