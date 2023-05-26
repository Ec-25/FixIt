@echo off
@REM if "%1" the process is executed in a way other than being maximized
@REM starts a new minimized process and closes the process that was not maximized
if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
@REM initial setup;
color 17
title FixIt V1.13.5

:check_Permissions
@REM net session requests admin permissions
@REM if the process has such permissions, and does not return an error (%errorLevel% == 0)
echo Administrative permissions are required. Detecting Permissions...
net session >nul 2>&1
if %errorLevel% == 0 (
    @REM it only moves to the start point (:ini) of the program
    echo Success: Administrative permissions confirmed.
    goto ini
) else (
    color 4f
    echo Failure: Inadequate current permissions.
    echo        YOU NEED TO BE AN ADMINISTRATOR
    pause >nul
    exit
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
echo.       =        l]     Cleaning Tools                                                    =
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
echo.                                          by JuanchoWolf
echo.

set /p tool=Option =   

@REM in this section the new menu to be displayed is determined,
@REM It is done this way (if after if) because a different form of structure was not found in batch that allows us to use something similar to elif (in python).
if "%tool%" == "0" (
    exit
)
if "%tool%" == "s" (
    @REM "%~p0" is a variable where the path from where the instructions of the program are executed is stored
    cd "%~p0\batch"
    flash.cmd
)
if "%tool%" == "l" (
    cd "%~p0\batch"
    clean.cmd
)
if "%tool%" == "1" (
    cd "%~p0\batch"
    repair-so.cmd
)
if "%tool%" == "2" (
    cd "%~p0\batch"
    lan.cmd
)
if "%tool%" == "3" (
    cd "%~p0\batch"
    access.cmd
)
if "%tool%" == "4" (
    cd "%~p0\batch"
    other.cmd
)
if "%tool%" == "5" (
    cd "%~p0\batch"
    external.cmd
)
else (
    goto ini
)