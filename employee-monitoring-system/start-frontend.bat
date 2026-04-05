@echo off
echo ========================================
echo  Starting Employee Monitoring Frontend
echo ========================================
echo.

cd frontend

echo Installing dependencies...
npm install --legacy-peer-deps
if %errorlevel% neq 0 (
    echo ❌ npm install failed!
    echo Try: npm install --legacy-peer-deps --force
    pause
    exit /b 1
)

echo.
echo Starting frontend server...
npm start
if %errorlevel% neq 0 (
    echo ❌ Frontend failed to start!
    pause
    exit /b 1
)