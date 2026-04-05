#!/bin/bash
# Fast Frontend Startup Script for macOS/Linux

echo ""
echo "========================================"
echo " Employee Monitoring System - Frontend"
echo "========================================"
echo ""

cd "$(dirname "$0")/frontend"

echo "[1/2] Installing dependencies (only if needed)..."
if [ ! -d "node_modules" ]; then
  npm install --legacy-peer-deps
else
  echo "Dependencies already installed, skipping..."
fi

echo "[2/2] Starting React development server..."
echo ""
echo "Frontend starting at http://localhost:3000"
echo ""

npm start
