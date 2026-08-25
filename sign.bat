@echo off
title WinUtil Binary Sign Engine
echo ========================================================
echo   WINUTIL CODE SIGNING UTILITY
echo ========================================================
echo.

:: Check for SignTool installation paths inside Windows SDK
set SIGNTOOL_PATH="C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x64\signtool.exe"

if not exist %SIGNTOOL_PATH% (
    echo [X] Error: signtool.exe was not detected within standard Windows SDK installation tracks.
    pause
    exit /b 1
)

echo [i] Digitally signing winutil-apex.exe via SHA256 context...
%SIGNTOOL_PATH% sign /a /g /fd SHA256 .\dist\winutil-apex.exe

echo [✓] Signing pipeline successfully concluded.
pause
