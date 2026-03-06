@echo off
chcp 65001 >nul

set "filename=%USERPROFILE%\Desktop\tree.txt"
:: [설정] 무시할 폴더나 파일명을 띄어쓰기로 나열하세요.
set "ignore="

echo [작업 경로: %cd%]
echo [제외 항목: %ignore%]

tree /f /a | powershell -NoProfile -Command ^
    "$ignoreList = '%ignore%'.Split(' ') | Where-Object { $_ -ne '' }; " ^
    "$skipLevel = -1; " ^
    "foreach ($line in $input) { " ^
    "    $level = ($line -replace '[^| ]', '').Length / 4; " ^
    "    if ($skipLevel -ne -1 -and $level -gt $skipLevel) { continue; } " ^
    "    $matched = $false; " ^
    "    foreach ($i in $ignoreList) { if ($line -match [regex]::Escape($i)) { $matched = $true; break; } } " ^
    "    if ($matched) { $skipLevel = $level; continue; } " ^
    "    else { $skipLevel = -1; $line; } " ^
    "}" > "%filename%"

echo.
echo 저장이 완료되었습니다.
echo 저장 위치: %filename%
echo.

start "" "%filename%"
pause