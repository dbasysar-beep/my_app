@echo off
echo ========================================
echo  Employee Monitoring System - Full Start
echo ========================================
echo.

echo Checking setup...
call check-setup.bat
if %errorlevel% neq 0 (
    echo Setup check failed. Please fix issues above.
    pause
    exit /b 1
)

echo.
echo Starting backend in new window...
start "Backend Server" cmd /k "start-backend.bat"

echo Waiting 10 seconds for backend to start...
timeout /t 10 /nobreak >nul

echo.
echo Starting frontend in new window...
start "Frontend Server" cmd /k "start-frontend.bat"

echo.
echo ========================================
echo  Servers Starting...
echo ========================================
echo.
echo Backend: http://localhost:8080
echo Frontend: http://localhost:3000
echo Mobile: http://172.20.10.3:3000
echo.
echo Admin Login: admin / admin123
echo.
echo Press any key to close this window...
pause >nul