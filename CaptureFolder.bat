@echo off
setlocal enabledelayedexpansion

:: [Settings] 제외할 폴더명 또는 파일 패턴 (공백으로 구분)
:: .* 대신 .git .vscode 처럼 명시하거나, 확장자 패턴을 사용하세요.
set "IGNORE_LIST="

:: [Init] 현재 CMD 작업 디렉토리(%CD%) 기준 설정
set "WORKDIR=%CD%"
for %%I in ("%WORKDIR%") do set "PROJNAME=%%~nxI"
set "OUTFILE=%USERPROFILE%\Desktop\%PROJNAME%.txt"

if exist "%OUTFILE%" del "%OUTFILE%"

:: [Structure] 트리 구조 기록
echo ============================================================ >> "%OUTFILE%"
echo PROJECT: %PROJNAME% / BASE: %WORKDIR% >> "%OUTFILE%"
echo DATE: %DATE% %TIME% >> "%OUTFILE%"
echo ============================================================ >> "%OUTFILE%"
echo. >> "%OUTFILE%"
tree "%WORKDIR%" /f /a >> "%OUTFILE%"
echo. >> "%OUTFILE%"

:: [Merge] 파일 병합 시작
echo [START] Processing from current CMD path: "%WORKDIR%"
echo.

pushd "%WORKDIR%"
for /r %%F in (*) do (
    set "FILEPATH=%%F"
    set "FILENAME=%%~nxF"
    set "RELPATH=%%F"
    set "RELPATH=!RELPATH:%WORKDIR%\=!"
    
    set "SKIP="
    
    :: 1. 자기 자신 및 결과 파일 제외
    if "%%~nxF"=="%~nx0" set "SKIP=1"
    if "%%~nxF"=="%PROJNAME%.txt" set "SKIP=1"
    
    :: 2. IGNORE_LIST 기반 필터링
    for %%P in (%IGNORE_LIST%) do (
        :: 폴더 경로에 패턴이 포함되어 있는지 확인 (findstr 활용)
        echo "!FILEPATH!" | findstr /i /c:"%%P" >nul
        if !errorlevel! equ 0 set "SKIP=1"
        
        :: 파일명 자체가 패턴과 일치하는지 확인 (와일드카드 대응)
        if /i "%%~nxF"=="%%P" set "SKIP=1"
    )

    if not defined SKIP (
        echo Processing: !RELPATH!
        
        echo ------------------------------------------------------------ >> "%OUTFILE%"
        echo FILE: !RELPATH! >> "%OUTFILE%"
        echo ------------------------------------------------------------ >> "%OUTFILE%"
        type "%%F" >> "%OUTFILE%" 2>nul
        echo. >> "%OUTFILE%"
        echo. >> "%OUTFILE%"
    )
)
popd

echo.
echo ============================================================
echo [DONE] Result saved to: "%OUTFILE%"
echo ============================================================
echo.

start "" notepad.exe "%OUTFILE%"
pause