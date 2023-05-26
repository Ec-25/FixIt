:tl3
@REM set of automated commands to quickly fix damaged system files, to ensure system stability
echo.
echo.
echo.
sfc /scannow
echo.
echo.
DISM /Online /Cleanup-Image /CheckHealth
echo.
echo.
DISM /Online /Cleanup-Image /ScanHealth
echo.
echo.
DISM /Online /Cleanup-Image /StartComponentCleanup 
echo.
pause

cd "%~p0"
cd..
main.cmd