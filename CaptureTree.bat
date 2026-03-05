@echo off
chcp 65001 >nul

set "filename=%USERPROFILE%\Desktop\tree.txt"

echo 현재 폴더의 구조를 분석 중입니다...
echo [작업 경로: %cd%]

:: tree 명령 실행 (/f: 파일 포함, /a: 텍스트 선 사용)
tree /f /a > "%filename%"

echo.
echo 저장이 완료되었습니다.
echo 저장 위치: %filename%
echo.

:: 저장된 파일을 바로 열어서 확인
start "" "%filename%"

pause