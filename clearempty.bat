@echo off
chcp 65001 >nul

echo 현재 경로 [%cd%] 내의 빈 폴더를 제거합니다...

for /f "delims=" %%i in ('dir /s /ad /b ^| sort /r') do (
    rd "%%i" 2>nul && echo 삭제됨: %%i
)

echo 작업이 완료되었습니다.
pause