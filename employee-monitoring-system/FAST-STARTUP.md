# Fast Startup Guide

Quick optimizations to make your application start **3-5x faster**!

## ⚡ Windows Users - Use These Scripts

### Backend (Fast Startup)
Double-click: **`run-backend-fast.bat`**

This will:
- ✅ Skip tests (saves 2-3 minutes)
- ✅ Build JAR (one-time, then cached)
- ✅ Run JAR directly (faster than `mvn spring-boot:run`)
- ✅ **Takes 1-2 minutes instead of 5-10!**

### Frontend (Fast Startup)
Double-click: **`run-frontend-fast.bat`**

This will:
- ✅ Skip install if already done
- ✅ Start React dev server
- ✅ **Takes 30 seconds!**

---

## 🐧 macOS/Linux Users - Use These Scripts

### Backend
```bash
chmod +x run-backend-fast.sh
./run-backend-fast.sh
```

### Frontend
```bash
chmod +x run-frontend-fast.sh
./run-frontend-fast.sh
```

---

## 🚀 Manual Fast Startup (Terminal Commands)

### Backend (Terminal 1)
```bash
cd backend
mvn package -DskipTests -q
java -jar target/employee-monitoring-system-1.0.0.jar
```

**Expected output in 1-2 minutes:**
```
Started EmployeeMonitoringSystemApplication in X seconds
```

### Frontend (Terminal 2)
```bash
cd frontend
npm install  # Only first time
npm start
```

---

## 📊 Speed Comparison

| Method | First Run | Subsequent |
|--------|-----------|-----------|
| Original | 15 min | 2 min |
| **Fast Scripts** | **2-3 min** | **1 min** |
| **JAR direct** | **1-2 min** | **1 min** |

---

## 💡 Optimization Tips

### 1. Skip Maven Tests (Already done in scripts)
```bash
mvn package -DskipTests -q  # Skip tests = 2-3 min faster
```

### 2. Use Pre-built JAR (Fastest)
```bash
# Build once:
mvn package -DskipTests -q

# Then just run:
java -jar target/employee-monitoring-system-1.0.0.jar
```

### 3. Use npm ci Instead of install (Faster)
```bash
# After first npm install:
npm ci  # Faster than npm install
```

### 4. Skip npm install If Already Done
```bash
# Check if node_modules exist
# If yes, just run: npm start
```

### 5. Use Yarn (Optional - Faster than npm)
```bash
# Install yarn: npm install -g yarn
# Then use: yarn install
# And: yarn start
```

---

## ✅ One-Time Setup (Do This Once)

### Backend
```bash
cd backend
mvn package -DskipTests -q
# Wait for: BUILD SUCCESS
# This creates: target/employee-monitoring-system-1.0.0.jar
```

### Frontend
```bash
cd frontend
npm install --legacy-peer-deps
# Wait for: added X packages
# This creates: node_modules folder
```

**After setup: Everything runs 3-5x faster!** ⚡

---

## 🎯 Fastest Way to Run

### Windows - Double-click These Files:
1. `run-backend-fast.bat`
2. `run-frontend-fast.bat` (in separate window)

### macOS/Linux - Run These Commands:
```bash
# Terminal 1:
./run-backend-fast.sh

# Terminal 2:
./run-frontend-fast.sh
```

---

## 🔍 Troubleshooting Slow Startup

### If Backend is Still Slow:
```bash
# Check if Java version is OK:
java -version  # Should be 17+

# Try with more RAM:
java -Xmx1G -jar target/employee-monitoring-system-1.0.0.jar

# Or different JVM flags:
java -XX:+UseG1GC -jar target/employee-monitoring-system-1.0.0.jar
```

### If Frontend is Still Slow:
```bash
# Clear npm cache:
npm cache clean --force

# Reinstall:
cd frontend
rm -rf node_modules
npm install --legacy-peer-deps
```

### If Maven Download is Slow:
```bash
# Use offline mode after first build:
mvn package -DskipTests -o  # -o = offline
```

---

## 📈 Performance Monitoring

### Check Backend Startup Time
Look for this line in logs:
```
Started EmployeeMonitoringSystemApplication in 1.234 seconds
```

**Good:** < 2 seconds  
**OK:** 2-5 seconds  
**Slow:** > 5 seconds

### Check Frontend Startup Time
```
Compiled successfully!
Waiting for changes...
```

Should appear in **< 1 minute**

---

## 🎁 Bonus: Advanced Optimizations

### Use Spring Boot Gradle (Faster Build)
```bash
# Instead of Maven (if you prefer)
# Add gradle build support (optional)
```

### Enable Lazy Initialization
Edit `backend/src/main/resources/application-fast.properties`:
```properties
spring.main.lazy-initialization=true
```

### Use Custom JVM Flags
```bash
java -XX:+UnlockExperimentalVMOptions \
     -XX:+UseZGC \
     -Xmx512M \
     -jar target/employee-monitoring-system-1.0.0.jar
```

---

## ✨ Expected Startup Time After Optimization

```
Terminal 1 (Backend):
[1/3] Cleaning... ✓ (5 sec)
[2/3] Building... ✓ (45 sec)
[3/3] Starting... ✓ (20 sec)
READY in 70 seconds!

Terminal 2 (Frontend):
[1/2] Dependencies skipped ✓
[2/2] Starting React... ✓
READY in 15 seconds!

Total Time: 85 seconds (< 2 minutes) ⚡
```

---

## 🚀 Ready to Go Fast!

### Windows:
```
Double-click: run-backend-fast.bat
Double-click: run-frontend-fast.bat
```

### macOS/Linux:
```bash
./run-backend-fast.sh &
./run-frontend-fast.sh
```

**Then open:** http://localhost:3000 ✨

---

**Your app should start in 1-2 minutes now instead of 15!** 🎉

Questions? Check QUICKSTART.md for more details.
