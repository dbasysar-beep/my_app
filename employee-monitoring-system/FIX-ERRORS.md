# 🚨 FIX: Required Tools Not Installed

## ❌ **Current Status**
- ❌ **Java 17+**: NOT INSTALLED
- ❌ **Maven 3.8+**: NOT INSTALLED
- ✅ **Node.js 16+**: INSTALLED (v11.11.0 - needs update)
- ✅ **npm**: INSTALLED

## 📥 **Download & Install Missing Tools**

### **Step 1: Install Java 17**
1. **Download Java 17:**
   - Go to: https://www.oracle.com/java/technologies/downloads/
   - Download: "Windows x64 Installer" for Java 17

2. **Install Java:**
   - Run the downloaded `.exe` file
   - Follow installation wizard
   - Choose default settings

3. **Verify Installation:**
   ```cmd
   java -version
   ```
   Should show: `java version "17.x.x"`

### **Step 2: Install Maven**
1. **Download Maven:**
   - Go to: https://maven.apache.org/download.cgi
   - Download: `apache-maven-3.9.x-bin.zip` (latest)

2. **Extract Maven:**
   - Extract the zip to: `C:\Program Files\apache-maven-3.9.x`
   - Or any folder you prefer

3. **Add to PATH:**
   - Search for "Environment Variables" in Windows search
   - Click "Environment Variables"
   - Under "System variables", find "Path"
   - Click "Edit" → "New"
   - Add: `C:\Program Files\apache-maven-3.9.x\bin`
   - Click OK

4. **Verify Installation:**
   ```cmd
   mvn -version
   ```
   Should show Maven version

### **Step 3: Update Node.js (Optional but Recommended)**
Current version: 11.11.0 (old)
Recommended: 16+ or 18+

1. **Download Latest Node.js:**
   - Go to: https://nodejs.org/
   - Download: LTS version (18.x.x)

2. **Install:**
   - Run the installer
   - Follow default settings
   - This will update both Node.js and npm

---

## 🧪 **Test Installation**

After installing all tools, run these commands:

```cmd
# Test Java
java -version

# Test Maven
mvn -version

# Test Node.js
node -version

# Test npm
npm -version
```

**Expected Output:**
```
java version "17.x.x"
Apache Maven 3.9.x
v18.x.x
8.x.x
```

---

## 🚀 **Run the Application**

After installing everything:

### **Terminal 1 - Backend:**
```cmd
cd employee-monitoring-system\backend
mvn clean package -DskipTests
java -jar target\employee-monitoring-system-1.0.0.jar
```

### **Terminal 2 - Frontend:**
```cmd
cd employee-monitoring-system\frontend
npm install --legacy-peer-deps
npm start
```

---

## 📱 **Access on Pixel 4XL**

After both servers are running:
- **Frontend:** http://172.20.10.3:3000
- **Admin:** http://172.20.10.3:3000/admin
- **Employee:** http://172.20.10.3:3000/employee

---

## 🔧 **Alternative: Use Pre-built Version**

If installation is difficult, I can create a simplified version that doesn't require Maven/Java installation. Would you like me to create a Node.js-only version?

---

## ❓ **Still Having Issues?**

### **Java Installation Problems:**
- Make sure you download the correct version (Windows x64)
- Try running installer as Administrator
- Check if antivirus is blocking installation

### **Maven PATH Issues:**
- Restart Command Prompt after adding to PATH
- Use full path: `"C:\Program Files\apache-maven-3.9.x\bin\mvn" -version`

### **Node.js Issues:**
- If npm install fails, try: `npm install --legacy-peer-deps --force`

---

## 📞 **Quick Check Commands**

Run these one by one:

```cmd
echo "=== Checking Tools ==="
java -version 2>nul && echo "✓ Java OK" || echo "✗ Java missing"
mvn -version 2>nul && echo "✓ Maven OK" || echo "✗ Maven missing"
node -version 2>nul && echo "✓ Node OK" || echo "✗ Node missing"
npm -version 2>nul && echo "✓ npm OK" || echo "✗ npm missing"
```

---

**Install Java and Maven first, then try running again!** 🎯

Let me know if you need help with any installation step.
