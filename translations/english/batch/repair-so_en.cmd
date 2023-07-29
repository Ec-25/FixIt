:tl1
cls

echo.
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
echo.       =      4]   Analysis of the data structure on disk                                =
echo.       =                                                                                 =
echo.       =      5]   Convert MBR Disk to GPT (Not Recommended)                             =
echo.       =                                                                                 =
echo.       =      6]   Force System Updates (not recommended)                                =
echo.       =                                                                                 =
echo.       =      7]   Check for and Apply System Updates                                                     =
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
    echo.
    echo.
    sfc /scannow
    echo.
    echo.
    pause
    echo.
    goto tl1
)
if "%tool%" == "2" (
    echo.
    echo.
    echo.
    DISM /Online /Cleanup-Image /CheckHealth
    echo.
    echo.
    DISM /Online /Cleanup-Image /ScanHealth
    echo.
    echo.
    pause
    echo.
    goto tl1
)
if "%tool%" == "3" (
    echo.
    echo.
    echo.
    DISM /Online /Cleanup-Image /StartComponentCleanup
    echo.
    echo.
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    echo.
    pause
    echo.
    goto tl1
)
if "%tool%" == "4" (
    echo.
    echo.
    echo.
    chkdsk C: /F /R
    echo.
    echo A reboot is required, Save everything before continuing
    pause
    shutdown /r
    pause>NUL
    exit
)
if "%tool%" == "5" (
    cls
    echo.
    echo.   WARNING...
    echo "The tool is designed to be run from a Windows Preinstallation Environment (Windows PE) command prompt, but it can also be run from within the operating system (OS)."
    echo.   IMPORTANT...
    echo. Before attempting to convert the drive, make sure the device supports UEFI.
    echo.
    echo. After the disk has been converted to the GPT partition style, the firmware must be configured to boot in UEFI mode.
    set /p confirm="Do you want to continue under your Responsibility? [1-Continue ; 0-Exit]"
    if "%confirm%" == "1" goto 5op4a 
    if not "%confirm%" == "1" goto salir
    :5op4a
    POWERSHELL DiskPart /s dp.cmd
    cd C:\Windows\System32
    echo.
    set /p disk=Indicate the number of the disk to convert that is NOT GPT   
    @REM First, it validates that the selected disk is suitable for conversion.
    mbr2gpt /validate /disk:"%disk%" /allowFullOS
    echo.
    set /p valid="Only! if the Process did not fail. Continue [1-Continue ; 0-Exit]:"
    if "%valid%" == "1" goto 5op4b
    if not "%valid%" == "1" goto salir
    :5op4b
    @REM if done convert disk to gpt; with the fullOs variant
    mbr2gpt /convert /disk:"%disk%" /allowFullOS
    echo.
    echo. RESETTING...
    echo. Access BIOS and enable SecureBoot
    shutdown /r /t 60
    exit
)
if "%tool%" == "6" (
    echo.
    echo Searching and Updating.
    @REM looks for (/detectnow) and forces system updates (/updatenow)
    wuauclt /detectnow /updatenow
    echo. This process is in the background, and may take time depending on your internet speed.
    pause
    echo.
    goto tl1
)
if "%tool%" == "7" (
    echo Defragmenting drive...
    defrag C: /U /V
    pause
    echo.
    goto tl1
)
else (
    goto tl1
)