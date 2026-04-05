# 📱 Run Employee Monitoring System on Pixel 4XL

## 🚀 Quick Setup for Android Device

### Step 1: Build and Start Backend (Spring Boot)

**Terminal 1 - Build JAR:**
```bash
cd employee-monitoring-system/backend
mvn package -DskipTests -q
```

**Terminal 1 - Run Backend:**
```bash
cd employee-monitoring-system/backend
java -jar target/employee-monitoring-system-1.0.0.jar
```

**Expected Output:**
```
Started EmployeeMonitoringSystemApplication in X.XXX seconds
```

### Step 2: Start Frontend (React)

**Terminal 2 - Install Dependencies:**
```bash
cd employee-monitoring-system/frontend
npm install --legacy-peer-deps
```

**Terminal 2 - Start React:**
```bash
cd employee-monitoring-system/frontend
npm start
```

**Expected Output:**
```
Compiled successfully!
Waiting for changes...
```

### Step 3: Configure for Mobile Access

**Update Frontend to Use Local IP:**

Edit `employee-monitoring-system/frontend/.env`:
```env
REACT_APP_API_URL=http://172.20.10.3:8080/api
```

**Or create if it doesn't exist:**
```env
REACT_APP_API_URL=http://172.20.10.3:8080/api
```

### Step 4: Access from Pixel 4XL

**On your Pixel 4XL browser, go to:**
```
http://172.20.10.3:3000
```

---

## 📋 Complete Setup Commands

### Windows PowerShell (Copy-Paste):

**Terminal 1 (Backend):**
```powershell
cd employee-monitoring-system/backend
mvn package -DskipTests -q
java -jar target/employee-monitoring-system-1.0.0.jar
```

**Terminal 2 (Frontend):**
```powershell
cd employee-monitoring-system/frontend
npm install --legacy-peer-deps
npm start
```

---

## 🔧 If You Get Errors

### Java Not Found:
```bash
# Download Java 17 from: https://www.oracle.com/java/technologies/downloads/
# Or check if installed:
java -version
```

### Maven Not Found:
```bash
# Download Maven from: https://maven.apache.org/download.cgi
# Add to PATH or use full path
```

### Node.js Not Found:
```bash
# Download Node.js from: https://nodejs.org/
# Check installation:
node --version
npm --version
```

---

## 📱 Pixel 4XL Access URLs

| Service | URL | Purpose |
|---------|-----|---------|
| **Frontend** | `http://172.20.10.3:3000` | Main app |
| **Admin Login** | `http://172.20.10.3:3000/admin` | Admin dashboard |
| **Employee Search** | `http://172.20.10.3:3000/employee` | Employee dashboard |
| **Backend API** | `http://172.20.10.3:8080/api` | API endpoints |
| **API Health** | `http://172.20.10.3:8080/api/auth/health` | Check backend |

---

## 🔑 Login Credentials

```
Username: admin
Password: admin123
```

---

## 📊 Test Employee IDs

- EMP001 (John Doe)
- EMP002 (Jane Smith)
- EMP003 (Mike Johnson)

---

## ⚡ Fast Start Scripts

If you have the fast scripts, just run:

**Windows:**
- Double-click: `run-backend-fast.bat`
- Double-click: `run-frontend-fast.bat`

**Then access:** `http://172.20.10.3:3000`

---

## 🔍 Troubleshooting Mobile Access

### Can't Connect from Phone?

1. **Check Firewall:**
   - Allow ports 3000 and 8080 through Windows Firewall

2. **Same WiFi Network:**
   - Make sure Pixel 4XL is on the same WiFi as your PC

3. **IP Address Changed:**
   - Run `ipconfig` again if connection fails
   - Update the IP in `.env` file

4. **Backend CORS:**
   - Backend is already configured for mobile access

### App Shows Blank Page?

1. **Check Console:** Press F12 in phone browser
2. **API Connection:** Look for network errors
3. **Restart Frontend:** After updating `.env`

---

## 🎯 What You'll See on Pixel 4XL

### Admin Dashboard:
- Employee management table
- Add new employees
- Delete employees
- Performance metrics overview

### Employee Dashboard:
- Search by Employee ID
- View personal profile
- Performance charts and trends
- Detailed metrics breakdown

---

## 📱 Mobile Optimization

The app is **responsive** and works great on Pixel 4XL:
- Touch-friendly buttons
- Mobile-optimized layout
- Charts scale properly
- Fast loading on mobile networks

---

## 🚀 Ready to Go!

1. **Build backend:** `mvn package -DskipTests -q`
2. **Run backend:** `java -jar target/employee-monitoring-system-1.0.0.jar`
3. **Install frontend:** `npm install --legacy-peer-deps`
4. **Run frontend:** `npm start`
5. **Update .env:** `REACT_APP_API_URL=http://172.20.10.3:8080/api`
6. **Access:** `http://172.20.10.3:3000` on your Pixel 4XL

**Enjoy your Employee Monitoring System on mobile!** 📱✨
