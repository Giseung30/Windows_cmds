@echo off
setlocal enabledelayedexpansion

:: [설정] 제외할 키워드
set "IGNORE_LIST="

:: [초기화] 프로젝트명 그대로 파일 생성
set "WORKDIR=%CD%"
for %%I in ("%WORKDIR%") do set "PROJNAME=%%~nxI"
set "OUTFILE=%USERPROFILE%\Desktop\%PROJNAME%.txt"

if exist "%OUTFILE%" del "%OUTFILE%"

:: [구조] 트리 전체 출력
echo 프로젝트: %PROJNAME% > "%OUTFILE%"
echo 날짜: %DATE% %TIME% >> "%OUTFILE%"
echo. >> "%OUTFILE%"
echo [전체 트리 구조] >> "%OUTFILE%"
tree "%WORKDIR%" /f /a >> "%OUTFILE%"
echo. >> "%OUTFILE%"
echo ------------------------------------------------------------ >> "%OUTFILE%"
echo. >> "%OUTFILE%"

:: [병합] 파일 내용 기록 시작
pushd "%WORKDIR%"
for /r %%F in (*) do (
    set "FILEPATH=%%F"
    set "RELPATH=%%F"
    set "RELPATH=!RELPATH:%WORKDIR%\=!"
    
    set "SKIP="
    if "%%~nxF"=="%~nx0" set "SKIP=1"
    if "%%~nxF"=="%PROJNAME%.txt" set "SKIP=1"
    
    for %%P in (%IGNORE_LIST%) do (
        echo "!FILEPATH!" | findstr /i /c:"%%P" >nul
        if !errorlevel! equ 0 set "SKIP=1"
    )

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
popd

echo.
echo 작업이 완료되었습니다. 바탕화면을 확인하세요.
start "" notepad.exe "%OUTFILE%"
pause