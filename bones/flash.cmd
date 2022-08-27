:tl3

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
main.bat