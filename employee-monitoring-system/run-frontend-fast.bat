@echo off
REM Fast Frontend Startup Script for Windows

echo.
echo ========================================
echo  Employee Monitoring System - Frontend
echo ========================================
echo.

cd /d "%~dp0\frontend"

echo [1/2] Installing dependencies (only if needed)...
if not exist "node_modules\" (
  call npm install --legacy-peer-deps
) else (
  echo Dependencies already installed, skipping...
)

echo [2/2] Starting React development server...
echo.
echo Frontend starting at http://localhost:3000
echo.

call npm start

pause
