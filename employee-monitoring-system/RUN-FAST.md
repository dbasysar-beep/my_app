# ⚡ FASTEST WAY TO RUN

## Windows Users - Just Double-Click These! 🚀

### Step 1: First Time Setup (Do Once)
1. Open PowerShell in the project folder
2. Run:
```powershell
cd employee-monitoring-system\backend
mvn package -DskipTests -q
cd ..\frontend
npm install --legacy-peer-deps
```

Wait for both to finish (first time takes 5-10 min total).

### Step 2: Every Time You Run
Just double-click these files:

**File 1:** `employee-monitoring-system\run-backend-fast.bat`  
**File 2:** `employee-monitoring-system\run-frontend-fast.bat` (open in new window)

Then go to: http://localhost:3000

---

## PowerShell Terminal Method (2 Windows)

### Terminal 1 - Backend:
```powershell
cd employee-monitoring-system\backend
mvn package -DskipTests -q  # First time only (1 min)
java -jar target\employee-monitoring-system-1.0.0.jar
```

### Terminal 2 - Frontend:
```powershell
cd employee-monitoring-system\frontend
npm install --legacy-peer-deps  # First time only (3 min)
npm start
```

---

## ⏱️ Expected Times

| Step | First Time | Later Runs |
|------|-----------|-----------|
| Backend build | 1 min | Instant (uses JAR) |
| Frontend install | 3 min | Instant (skipped) |
| Backend startup | 20 sec | 20 sec |
| Frontend startup | 15 sec | 15 sec |
| **Total** | **5-6 min** | **35 sec** |

---

## 🔥 Super Fast Mode (Once Fully Built)

After first complete run, just use:

### Terminal 1:
```powershell
cd employee-monitoring-system
java -jar backend\target\employee-monitoring-system-1.0.0.jar
```

### Terminal 2:
```powershell
cd employee-monitoring-system\frontend
npm start
```

**Startup time: < 1 minute!** ⚡

---

## ✅ What To Look For

### Backend Started Successfully:
```
Started EmployeeMonitoringSystemApplication in X.XXX seconds
```

### Frontend Started Successfully:
```
Compiled successfully!
Waiting for changes...
```

---

## 🌐 Access Points

- **Admin Dashboard:** http://localhost:3000/admin
- **Employee Dashboard:** http://localhost:3000/employee
- **API Health:** http://localhost:8080/api/auth/health
- **H2 Console:** http://localhost:8080/h2-console (Debug database)

---

## 📋 Credentials

```
Username: admin
Password: admin123
```

---

## 💥 If Still Slow

### Option 1: More RAM
```powershell
java -Xmx2G -jar target\employee-monitoring-system-1.0.0.jar
```

### Option 2: Different JVM
```powershell
java -XX:+UseG1GC -jar target\employee-monitoring-system-1.0.0.jar
```

### Option 3: Clean Everything
```powershell
cd backend
mvn clean
cd ..\frontend
rm -r node_modules
npm install --legacy-peer-deps
mvn package -DskipTests -q
npm start
```

---

## 🎯 Copy-Paste Quick Commands

**One-time setup:**
```powershell
cd employee-monitoring-system/backend
mvn package -DskipTests -q
cd ../frontend
npm install --legacy-peer-deps
```

**Every time - Terminal 1:**
```powershell
cd employee-monitoring-system/backend
java -jar target/employee-monitoring-system-1.0.0.jar
```

**Every time - Terminal 2:**
```powershell
cd employee-monitoring-system/frontend
npm start
```

---

**Now it should be FAST!** 🚀 Let me know if you need more help!
