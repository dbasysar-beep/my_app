@echo off
echo ========================================
echo  Employee Monitoring System - Setup
echo ========================================
echo.

echo Checking current installations...
echo.

echo === Java Check ===
java -version 2>nul
if %errorlevel% neq 0 (
    echo ❌ Java NOT installed
    echo Please install Java 17 from: https://www.oracle.com/java/technologies/downloads/
    echo Download: Windows x64 Installer
    echo.
) else (
    echo ✅ Java is installed
)

echo.
echo === Maven Check ===
mvn -version 2>nul
if %errorlevel% neq 0 (
    echo ❌ Maven NOT installed
    echo Please install Maven from: https://maven.apache.org/download.cgi
    echo Download: apache-maven-3.9.x-bin.zip
    echo Extract and add to PATH: C:\Program Files\apache-maven-3.9.x\bin
    echo.
) else (
    echo ✅ Maven is installed
)

echo.
echo === Node.js Check ===
node -version 2>nul
if %errorlevel% neq 0 (
    echo ❌ Node.js NOT installed
    echo Please install Node.js from: https://nodejs.org/
    echo Download: LTS version (18.x.x)
    echo.
) else (
    echo ✅ Node.js is installed
)

echo.
echo === npm Check ===
npm -version 2>nul
if %errorlevel% neq 0 (
    echo ❌ npm NOT installed
    echo npm should come with Node.js
    echo.
) else (
    echo ✅ npm is installed
)

echo.
echo ========================================
echo  Installation Status Summary
echo ========================================

set "JAVA_OK=0"
set "MAVEN_OK=0"
set "NODE_OK=0"
set "NPM_OK=0"

java -version >nul 2>&1 && set "JAVA_OK=1"
mvn -version >nul 2>&1 && set "MAVEN_OK=1"
node -version >nul 2>&1 && set "NODE_OK=1"
npm -version >nul 2>&1 && set "NPM_OK=1"

if %JAVA_OK%==1 if %MAVEN_OK%==1 if %NODE_OK%==1 if %NPM_OK%==1 (
    echo ✅ ALL TOOLS INSTALLED! Ready to run.
    echo.
    echo Next steps:
    echo 1. Run: start-backend.bat
    echo 2. Run: start-frontend.bat
    echo 3. Access: http://172.20.10.3:3000
) else (
    echo ❌ MISSING TOOLS DETECTED
    echo Please install missing tools above, then run this script again.
)

echo.
pause