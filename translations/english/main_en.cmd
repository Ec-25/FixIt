@echo off
@REM if "%1" the process runs in a way other than maximized, start a new minimized process and kill the process that was not maximized
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
color 17
title FixIt V1.14

:check_Permissions
@REM Network session requests admin permissions
@REM if the process has these permissions, it does not return the error and continues its execution (%errorLevel% == 0)
echo Administrative permissions are required. Detecting Permissions...
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
    goto ini
) else (
    color 4f
    echo Failure: Inadequate current permissions.
    echo        YOU NEED TO BE AN ADMINISTRATOR
    pause >nul
)

:ini
cls
echo.
echo.       ===================================================================================
echo.       =                                      FIXTOOL                                    =
echo.       ===================================================================================
echo.       =                                                                                 =
echo.       =        SIMPLE                                                                   =
echo.       =        s]     Quick Repair                                                      =
echo.       =                                                                                 =
echo.       =        c]     Cleaning Tools                                                    =
echo.       =                                                                                 =
echo.       =        ADVANCED                                                                 =
echo.       =        1]     Tools for the Operating System                                    =
echo.       =                                                                                 =
echo.       =        2]     Web Tools                                                         =
echo.       =                                                                                 =
echo.       =        3]     System Tools Shortcuts                                            =
echo.       =                                                                                 =
echo.       =        EXTERNAL                                                                 =
echo.       =        4]     Extra Tools                                                       =
echo.       =                                                                                 =
echo.       =        5]     Third Party Tools                                                 =
echo.       =                                                                                 =
echo.       =        EXIT                                                                     =
echo.       =        0]     Exit                                                              =
echo.       =                                                                                 =
echo.       ===================================================================================
echo.                                          by Ec25
echo.

set /p tool=Option =   

@REM in this section the new menu to be displayed is determined.
if "%tool%" == "0" (
    exit
)
if "%tool%" == "s" (
    cd "%~p0\batch"
    flash.cmd
)
if "%tool%" == "c" (
    cd "%~p0\batch"
    clean_en.cmd
)
if "%tool%" == "1" (
    cd "%~p0\batch"
    repair-so_en.cmd
)
if "%tool%" == "2" (
    cd "%~p0\batch"
    lan_en.cmd
)
if "%tool%" == "3" (
    cd "%~p0\batch"
    access_en.cmd
)
if "%tool%" == "4" (
    cd "%~p0\batch"
    other_en.cmd
)
if "%tool%" == "5" (
    cd "%~p0\batch"
    external_en.cmd
)
else (
    goto ini
)