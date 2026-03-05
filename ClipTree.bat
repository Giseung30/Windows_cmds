@echo off
chcp 65001 >nul

tree /f /a | clip

echo 현재 폴더의 Tree 구조가 클립보드에 복사되었습니다.
pause