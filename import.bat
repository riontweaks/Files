@echo off
:: ============================================================
:: RION TWEAKS - import.bat (OOSU10 silent config import)
:: Version 2.1 ^| Windows 11 23H2/24H2
:: Place in Rion-Config\ next to OOSU10.exe and rion.cfg
::
:: NOTE: /quiet was REMOVED so OOSU10 shows its native
::       "X settings imported" confirmation popup.
::       /nosrp stays so no system restore point prompt.
:: ============================================================

:: Auto-elevate silently
>nul 2>&1 net session
if %errorlevel% neq 0 (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -Verb RunAs -FilePath '%~f0'" >nul 2>&1
  exit /b
)

setlocal EnableExtensions DisableDelayedExpansion
title Rion Tweaks - OOSU10 Config Import

cd /d "%~dp0"

if not exist "%~dp0OOSU10.exe" (
  echo [ERROR] OOSU10.exe not found in %~dp0
  echo [%DATE% %TIME%] %~nx0 - OOSU10.exe missing >> "%~dp0..\RionTweaks_Log.txt" 2>nul
  timeout /t 3 /nobreak >nul
  exit /b 1
)

if not exist "%~dp0rion.cfg" (
  echo [ERROR] rion.cfg not found in %~dp0
  echo [%DATE% %TIME%] %~nx0 - rion.cfg missing >> "%~dp0..\RionTweaks_Log.txt" 2>nul
  timeout /t 3 /nobreak >nul
  exit /b 1
)

:: Run OOSU10 - import config, no restore point prompt, but keep
:: the native success popup so the technician sees "X settings imported"
"%~dp0OOSU10.exe" "%~dp0rion.cfg" /nosrp

echo [%DATE% %TIME%] %~nx0 completed >> "%~dp0..\RionTweaks_Log.txt" 2>nul
endlocal
exit /b 0
