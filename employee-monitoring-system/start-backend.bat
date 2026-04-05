@echo off
echo ========================================
echo  Starting Employee Monitoring Backend
echo ========================================
echo.

cd backend

echo Building backend...
mvn clean package -DskipTests
if %errorlevel% neq 0 (
    echo ❌ Build failed! Check Maven/Java installation.
    echo Run: check-setup.bat
    pause
    exit /b 1
)

echo.
echo Starting backend server...
java -jar target\employee-monitoring-system-1.0.0.jar
if %errorlevel% neq 0 (
    echo ❌ Server failed to start!
    pause
    exit /b 1
)