# 🚀 Windows Commands(cmds)
>윈도우 환경에서 반복적인 작업을 효율화하기 위한 배치 파일(.bat) 모음입니다.<br>
>환경 변수 등록을 통해 터미널 어디서든 명령을 수행할 수 있습니다.

## 🛠️ Setup Guide
### 1. 레포지토리 클론 (Repository Clone)
관리할 디렉터리에 레포지토리를 클론합니다. (권장 경로: `C:\cmds`)

```Bash
git clone https://github.com/Giseung30/Windows_cmds.git C:\cmds
```
### 2. 환경 변수 등록
시스템 어디서나 명령어를 호출하기 위해 디렉터리 경로를 <b>환경 변수</b>에 추가해야 합니다.

1. <b>Win + S</b> 입력 후 `시스템 환경 변수 편집` 실행
2. `환경 변수(N)...` 클릭
3. <b>시스템 변수(S)</b> 목록에서 Path 선택 후 `편집(I)...` 클릭
4. `새로 만들기(N)`를 클릭하고 `C:\cmds` 입력
5. 모든 창에서 확인을 눌러 설정 저장
6. 새로운 <b>CMD</b> 또는 <b>PowerShell</b> 창을 열어 적용 확인

## 💡 How to Add New Command
1. <b>(ANSI 인코딩 권장)</b> `C:\cmds` 디렉터리 내에 새로운 <b>.bat</b> 파일을 생성합니다.
2. 파일명을 호출하고자 하는 명령어 이름으로 지정합니다.
3. 파일 상단에 `@echo off`를 추가하여 출력을 최적화합니다.
4. 매개변수가 필요한 경우 `%1`, `%2` 등을 활용합니다.

## ⚠️ Requirements
+ `OS`: Windows 10 / 11
+ `Terminal`: CMD, PowerShell, Git Bash