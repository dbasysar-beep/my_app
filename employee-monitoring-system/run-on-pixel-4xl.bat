@echo off
REM One-Click Setup for Pixel 4XL Mobile Access
REM This script builds and runs both backend and frontend with mobile IP configuration

echo.
echo ========================================
echo  Employee Monitoring System - Pixel 4XL
echo ========================================
echo.

echo [1/4] Building Backend JAR...
cd /d "%~dp0\backend"
if not exist "target\" mkdir target
call mvn package -DskipTests -q 2>nul
if errorlevel 1 (
    echo ERROR: Maven build failed. Please install Maven and try again.
    pause
    exit /b 1
)

echo [2/4] Configuring Frontend for Mobile Access...
cd /d "%~dp0\frontend"
echo REACT_APP_API_URL=http://172.20.10.3:8080/api > .env

echo [3/4] Installing Frontend Dependencies...
if not exist "node_modules\" (
    call npm install --legacy-peer-deps
) else (
    echo Dependencies already installed, skipping...
)

echo [4/4] Starting Services...
echo.
echo ========================================
echo  ACCESS FROM PIXEL 4XL:
echo ========================================
echo Frontend: http://172.20.10.3:3000
echo Admin:    http://172.20.10.3:3000/admin
echo Employee: http://172.20.10.3:3000/employee
echo.
echo Credentials: admin / admin123
echo ========================================
echo.

echo Starting Backend (Spring Boot)...
start "Backend Server" cmd /k "cd /d %~dp0\backend && java -jar target\employee-monitoring-system-1.0.0.jar"

timeout /t 5 /nobreak > nul

echo Starting Frontend (React)...
start "Frontend Server" cmd /k "cd /d %~dp0\frontend && npm start"

echo.
echo ========================================
echo  READY! Open these URLs on Pixel 4XL:
echo ========================================
echo http://172.20.10.3:3000
echo.
echo Press any key to close this window...
pause > nul
