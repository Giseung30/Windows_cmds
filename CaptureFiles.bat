@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set "IGNORE_LIST="
:: [설정] 무시할 폴더나 파일명을 띄어쓰기로 나열하세요.

set "WORKDIR=%CD%"
for %%I in ("%WORKDIR%") do set "PROJNAME=%%~nxI"
set "OUTFILE=%USERPROFILE%\Desktop\%PROJNAME%.txt"

if exist "%OUTFILE%" del "%OUTFILE%"

for /f "usebackq delims=" %%F in (`dir /s /b /a-d ^| findstr /i /v /r "%IGNORE_LIST: = %"` ) do (
    set "RELPATH=%%F"
    set "RELPATH=!RELPATH:%WORKDIR%\=!"
    
    set "SKIP="
    if "%%~nxF"=="%~nx0" set "SKIP=1"
    if "%%~nxF"=="%PROJNAME%.txt" set "SKIP=1"

    if not defined SKIP (
        echo [기록 중] !RELPATH!
        echo ------------------------------------------------------------ >> "%OUTFILE%"
        echo 파일명: !RELPATH! >> "%OUTFILE%"
        echo ------------------------------------------------------------ >> "%OUTFILE%"
        
        findstr "^" "%%F" >> "%OUTFILE%" 2>nul

        echo. >> "%OUTFILE%"
        echo. >> "%OUTFILE%"
    )
)

echo.
echo 작업 완료: %OUTFILE%
start "" notepad.exe "%OUTFILE%"
pause