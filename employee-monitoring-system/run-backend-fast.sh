#!/bin/bash
# Fast Backend Startup Script for macOS/Linux

echo ""
echo "========================================"
echo " Employee Monitoring System - Backend"
echo "========================================"
echo ""

cd "$(dirname "$0")/backend"

echo "[1/3] Cleaning previous build..."
mvn clean -q

echo "[2/3] Building with tests skipped (faster)..."
mvn package -DskipTests -q

echo "[3/3] Starting Spring Boot server..."
echo ""
echo "Backend starting at http://localhost:8080"
echo "API Health Check: http://localhost:8080/api/auth/health"
echo "H2 Console: http://localhost:8080/h2-console"
echo ""

java -jar target/employee-monitoring-system-1.0.0.jar
