# Call Android Native NDK from Delphi

[![License: MIT](https://img.shields.io/badge/License-MIT-white.svg)](https://opensource.org/licenses/MIT)
[![Delphi](https://img.shields.io/badge/Delphi-12%20Athens-red.svg)](https://www.embarcadero.com/products/delphi)
[![Android](https://img.shields.io/badge/Android-API%2021%2B-blue.svg)](https://developer.android.com)

A production-ready demonstration of calling **Android NDK native C code** from **Delphi FireMonkey** applications using **JNI (Java Native Interface)**. This project showcases a complete architecture with native calculations, SQLite persistence, and history tracking.

## 📋 Overview

This project demonstrates the complete data flow: **Delphi (Pascal) → Java Bridge → Native C Library**, featuring:

- ✅ **Native C Math Operations** via JNI
- ✅ **Clean Architecture** with interfaces and dependency injection
- ✅ **SQLite History Persistence** using FireDAC
- ✅ **Production-Quality Code** with proper error handling
- ✅ **Responsive UI** for phones and tablets

## 🎯 What Makes This Project Valuable

Unlike simple "Hello World" JNI examples, this project demonstrates:

1. **Real-world Architecture**: Service layer, interfaces, models, and data persistence
2. **Bidirectional Communication**: Delphi calls native code AND stores results in SQLite
3. **Complete NDK Integration**: Shows the full build process for C libraries
4. **Production Patterns**: Proper memory management, error handling, and logging
5. **Multi-Layer Design**: UI → Service → JNI → Native C

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    Delphi FMX UI Layer                          │
│                     (Main.View.pas)                             │
│  • User inputs two numbers                                      │
│  • Clicks operation button (Add/Sub/Mul/Div)                   │
│  • Displays result and history                                  │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ Uses iCalculatorService interface
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                   Service Layer (Pascal)                        │
│              (API.Calculator.Service.pas)                       │
│  • TCalculatorService implements iCalculatorService             │
│  • Calls Java bridge for calculations                           │
│  • Logs results to SQLite via FireDAC                          │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ Calls FJavaBridge (JNI wrapper)
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                   JNI Bridge Layer (Pascal)                     │
│                (API.JNI.Calculator.pas)                         │
│  • TJCalculatorBridge wraps Java class                          │
│  • Exposes: nativeAdd, nativeSub, nativeMul, nativeDiv         │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ JNI call to Java
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Java Bridge Class                            │
│            (CalculatorBridge.java)                              │
│  • Loads native library: System.loadLibrary("NativeCalcLIB")   │
│  • Declares native methods matching C signatures                │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ JNI native call
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                 Native C Implementation                         │
│                  (NativeCalc.c)                                 │
│  • JNIEXPORT jdouble JNICALL                                    │
│    Java_com_MBenDelphi_CalculatorDemo_CalculatorBridge_XXX     │
│  • Pure C math operations                                       │
│  • Android logging for debugging                                │
└─────────────────────────────────────────────────────────────────┘
                         │
                         │ Result returns through same layers
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                  SQLite Database (FireDAC)                      │
│                 (Model.Connection.pas)                          │
│  • History table: Operation, ValueA, ValueB, Result, Timestamp │
│  • Stores calculation history                                   │
│  • Retrieved and displayed in UI                                │
└─────────────────────────────────────────────────────────────────┘
```

## 📁 Project Structure

```
Call-ANDROID-Native-NDK/
│
├── API/                           # API & Interface Layer
│   ├── API.Calculator.Interfaces.pas   # iCalculatorService & iCalculationHistory
│   ├── API.Calculator.Service.pas      # TCalculatorService implementation
│   └── API.JNI.Calculator.pas          # JNI bridge to Java (TJCalculatorBridge)
│
├── Model/                         # Data Layer
│   ├── Model.Connection.pas            # FireDAC SQLite connection & schema
│   └── Model.History.pas               # TCalculationHistory model
│
├── Java/                          # Java Bridge Layer
│   └── CalculatorBridge.java           # JNI bridge class
│
├── Native/                        # C Native Library
│   ├── NativeCalc.c                    # C implementation of math operations
│   ├── Android.mk                      # NDK build configuration
│   └── Application.mk                  # ABI and platform settings
│
├── Res/                           # Android Resources
│   ├── drawable/
│   │   ├── splash_image_def.xml        # Splash screen (API 21+)
│   │   └── splash_vector_def.xml       # Vector splash (API 21+)
│   └── values/
│
├── Main.View.pas                  # Main FMX form (UI logic)
├── Main.View.fmx                  # FMX UI design (base)
├── Main.View.LgXhdpiPh.fmx       # Large XHDPI Phone layout
├── Main.View.LgXhdpiTb.fmx       # Large XHDPI Tablet layout
├── Main.View.XLgXhdpiTb.fmx      # Extra Large XHDPI Tablet layout
│
├── CalculatorDemo.dpr             # Main Delphi project
├── CalculatorDemo.dproj           # Project configuration
├── AndroidManifest.template.xml   # Android manifest template
│
└── LICENSE                        # MIT License
```

## 🚀 Getting Started

### Prerequisites

- **Delphi RAD Studio 12 Athens** or later (with Android SDK support)
- **Android NDK** r21e or compatible (configured in Delphi SDK Manager)
- **Android SDK** API Level 21+ (minimum) / API Level 23+ (recommended)
- **Java Development Kit** JDK 8 or 11

### Step 1: Clone the Repository

```bash
git clone https://github.com/mben-dz/Call-ANDROID-Native-NDK.git
cd Call-ANDROID-Native-NDK
```

### Step 2: Build the Native Library

Navigate to the `Native/` directory and build the C library:

```bash
cd Native
"%ANDROID_NDK_ROOT%\ndk-build.cmd" clean
"%ANDROID_NDK_ROOT%\ndk-build.cmd"
```

This generates:
- `libs/armeabi-v7a/libc++_shared.so`
- `libs/armeabi-v7a/libNativeCalcLIB.so`
- `libs/armeabi-v7a/libc++_shared.so`
- `libs/arm64-v8a/libNativeCalcLIB.so`

**Important**: The library name `NativeCalcLIB` must match the `System.loadLibrary("NativeCalcLIB")` call in `CalculatorBridge.java`.

### Step 3: Configure Delphi Project

1. Open `CalculatorDemo.dproj` in RAD Studio
2. Verify Android SDK/NDK paths:
   - **Tools → Options → Deployment → SDK Manager**
   - Ensure Android SDK and NDK paths are correct
   - good Steps [here](https://github.com/DelphiWorlds/HowTo/tree/main/Solutions/AndroidLowerVersions)
3. Add native libraries to deployment:
   - **Project → Deployment**
   - Ensure `libc++_shared.so` & `libNativeCalcLIB.so` is included for both architectures

### Step 4: Add Java Bridge to Project

The Java file `CalculatorBridge.java` must be included in the project:

1. In Project Manager, right-click the Android target
2. open this [tool](https://github.com/mben-dz/JarBuilder/blob/main/DEPLOY/APP/JarBuilder.exe) and **Add → Java Source** and the latest android.Jar path in your SDK Folder
3. compile and then open this command:  `java2op -jar NativeCalcLib.jar -unit API.JNI.Calculator`

java2op will automatically generate this into the Delphi JNI WRAPER Unit (to add it to your project).

### Step 5: Build and Deploy

1. Select **Android 32-bit** or **Android 64-bit** target
2. Connect Android device or start emulator
3. Press **F9** (Run) or **Shift+Ctrl+F9** (Run Without Debugging)

The app will:
- Compile Delphi code
- Compile Java bridge
- Package native `.so` libraries
- Build and install APK
- Launch on device

## 🔧 How It Works

### Complete Call Flow Example: Adding Two Numbers

#### 1. User Interaction (UI Layer)
```pascal
// Main.View.pas - User clicks "Add" button
procedure TMainView.btnAddClick(Sender: TObject);
begin
  PerformCalculation(0);  // 0 = Add operation
end;
```

#### 2. Service Layer Processes Request
```pascal
// API.Calculator.Service.pas
function TCalculatorService.Add(const a, b: Double): Double;
begin
  // Call Java bridge which calls native C
  Result := FJavaBridge.nativeAdd(a, b);
  
  // Log to SQLite database
  LogHistory('ADD', a, b, Result);
end;
```

#### 3. JNI Bridge to Java
```pascal
// API.JNI.Calculator.pas - Delphi JNI wrapper
JCalculatorBridge = interface(JObject)
  function nativeAdd(d: Double; d1: Double): Double; cdecl;
end;

// In service:
FJavaBridge := TJCalculatorBridge.JavaClass.init;
Result := FJavaBridge.nativeAdd(a, b);  // Calls Java method
```

#### 4. Java Calls Native C
```java
// Java/CalculatorBridge.java
public class CalculatorBridge {
    static {
        System.loadLibrary("NativeCalcLIB");  // Load .so library
    }
    
    public native double nativeAdd(double a, double b);  // JNI declaration
}
```

#### 5. Native C Implementation
```c
// Native/NativeCalc.c
JNIEXPORT jdouble JNICALL
Java_com_MBenDelphi_CalculatorDemo_CalculatorBridge_nativeAdd(
    JNIEnv *env, jobject thiz, jdouble a, jdouble b) {
    
    __android_log_print(ANDROID_LOG_DEBUG, "CALC_JNI", "nativeAdd called");
    return a + b;  // Pure C calculation
}
```

#### 6. Result Returns & Persists
```pascal
// Result flows back: C → Java → JNI → Service → UI
lblResult.Text := Format('Result: %.2f', [LRes]);

// Saved to SQLite via FireDAC
FDConnection.ExecSQL(
  'INSERT INTO History (Operation, ValueA, ValueB, Result) VALUES (?, ?, ?, ?)',
  ['ADD', a, b, Result]);
```

## 💾 Database Schema

SQLite database created automatically at app launch:

```sql
CREATE TABLE IF NOT EXISTS History (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Operation TEXT,           -- 'ADD', 'SUB', 'MUL', 'DIV'
    ValueA REAL,             -- First operand
    ValueB REAL,             -- Second operand
    Result REAL,             -- Calculation result
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

Location:
- **Android**: `/data/data/com.MBenDelphi.CalculatorDemo/files/calculator.db`
- **Desktop** (testing): `<EXE_PATH>/calculator.db`

## 🔍 Key Components Explained

### JNI Method Naming Convention

The C function names **must** follow this exact pattern:

```c
JNIEXPORT <return_type> JNICALL
Java_<package_name>_<class_name>_<method_name>(JNIEnv *env, jobject thiz, <parameters>)
```

Example:
```c
Java_com_MBenDelphi_CalculatorDemo_CalculatorBridge_nativeAdd
     └──────────────┬─────────────┘ └─────┬──────┘ └───┬───┘
              Package name          Class name    Method name
```

### Java Package Declaration

Must match the package in `CalculatorBridge.java`:

```java
package com.MBenDelphi.CalculatorDemo;
```

### Library Loading

The native library is loaded once when the Java class initializes:

```java
static {
    System.loadLibrary("NativeCalcLIB");  // Loads libNativeCalcLIB.so
}
```

### Interface-Based Design

The project uses **dependency injection** with interfaces:

```pascal
// Interface definition
iCalculatorService = interface
  function Add(const a, b: Double): Double;
  function GetHistory: TList<iCalculationHistory>;
end;

// Concrete implementation
TCalculatorService = class(TInterfacedObject, iCalculatorService)
  // Implementation details
end;

// Usage
FService: iCalculatorService;
FService := TCalculatorService.Create;
```

This allows for easy testing and future implementations (e.g., pure Pascal calculator for testing).

## 🛠️ Building Native Libraries

### Android.mk Configuration

```makefile
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# Library name (produces libNativeCalcLIB.so)
LOCAL_MODULE := NativeCalcLIB

# Source files
LOCAL_SRC_FILES := NativeCalc.c

# Link Android log library for __android_log_print
LOCAL_LDLIBS := -llog

# Compiler flags
LOCAL_CFLAGS := -Wall -Wextra -O2 -DDEBUG

include $(BUILD_SHARED_LIBRARY)
```

### Application.mk Configuration

```makefile
# Target architectures (32-bit and 64-bit ARM)
APP_ABI := armeabi-v7a arm64-v8a

# Minimum Android API level
APP_PLATFORM := android-21

# C++ standard library
APP_STL := c++_shared

# C++ version
APP_CPPFLAGS := -std=c++11
```

### Build Commands

```bash
# Clean previous builds
ndk-build clean

# Build for all ABIs defined in Application.mk
ndk-build

# Build for specific ABI
ndk-build APP_ABI=arm64-v8a

# Verbose build output
ndk-build V=1
```

## 📱 Android Splash Screen Fix

For **Android 5.0+ (API 21+)**, the splash screen requires `android:scaleType="centerInside"` to display correctly:

**Res/drawable/splash_image_def.xml**:
```xml
<bitmap
    android:src="@drawable/splash_image"
    android:gravity="center"
    android:scaleType="centerInside"  <!-- Required for API 21+ -->
    android:tileMode="disabled"/>
```

**Res/drawable/splash_vector_def.xml**:
```xml
<item
    android:gravity="center"
    android:scaleType="centerInside"  <!-- Required for API 21+ -->
    android:drawable="@drawable/splash_vector">
</item>
```

This ensures the app icon displays properly in the splash screen on modern Android versions.

## 🐛 Troubleshooting

### Issue: "UnsatisfiedLinkError: dlopen failed"

**Cause**: Native library not found or wrong architecture

**Solutions**:
1. Verify `libNativeCalcLIB.so` exists in `libs/armeabi-v7a/` or `libs/arm64-v8a/`
2. Check deployment configuration includes `.so` files
3. Ensure library name matches: `System.loadLibrary("NativeCalcLIB")`
4. Rebuild with `ndk-build clean && ndk-build`

### Issue: "NoSuchMethodError" when calling native method

**Cause**: JNI method signature mismatch

**Solutions**:
1. Verify C function name matches Java package/class/method exactly
2. Check parameter types match (jdouble vs double, etc.)
3. Regenerate JNI headers: `javah -classpath . com.MBenDelphi.CalculatorDemo.CalculatorBridge`

### Issue: App crashes when calling native method

**Cause**: JNI reference handling or null pointer

**Solutions**:
1. Check C code for null parameter validation
2. Verify `(void)env; (void)thiz;` to avoid unused parameter warnings
3. Enable NDK debugging: Add `android:debuggable="true"` to manifest
4. Check Android logcat for native crash logs: `adb logcat | grep CALC_JNI`

### Issue: SQLite database errors

**Cause**: File permissions or path issues

**Solutions**:
1. Verify app has storage permissions in `AndroidManifest.xml`
2. Check database path: `TPath.GetDocumentsPath` on Android
3. Ensure table creation SQL executes on first run
4. Test with a simple query before complex operations

### Issue: JNI bridge not found in Delphi

**Cause**: Java file not included in project

**Solutions**:
1. the jar file not found you should compile and deploy
2. Verify package name matches: `com.MBenDelphi.CalculatorDemo`
3. Clean and rebuild project

## 📊 Performance Considerations

### Why Use Native Code?

This example uses simple math operations for demonstration, but native code is beneficial for:

- **Heavy Computations**: Image processing, cryptography, physics simulations
- **Existing C Libraries**: FFmpeg, OpenCV, TensorFlow Lite
- **Performance-Critical Code**: Game engines, real-time audio processing
- **Hardware Access**: Camera HAL, sensors, custom drivers

### Overhead

JNI calls have overhead (~100-200ns per call). For best performance:
- **Batch operations**: Pass arrays instead of single values
- **Minimize JNI boundary crossings**: Do more work per call
- **Use native threads**: For long-running computations

Example:
```c
// Less efficient: 1000 JNI calls
for (int i = 0; i < 1000; i++) {
    result[i] = nativeAdd(a[i], b[i]);
}

// More efficient: 1 JNI call
JNIEXPORT jdoubleArray JNICALL
Java_..._nativeAddArray(JNIEnv *env, jobject thiz, jdoubleArray a, jdoubleArray b) {
    // Process entire array in C
}
```

## 🧪 Testing

### Unit Testing (Recommended Approach)

Create a **pure Pascal implementation** of `iCalculatorService` for testing:

```pascal
type
  TCalculatorServiceMock = class(TInterfacedObject, iCalculatorService)
  public
    function Add(const a, b: Double): Double;
    // ... simple Pascal implementations for testing
  end;

// In tests:
FService := TCalculatorServiceMock.Create;  // No JNI, fast testing
```

### Integration Testing

Test the full JNI stack on a real device:

```pascal
procedure TestNativeAdd;
var
  LService: iCalculatorService;
  LResult: Double;
begin
  LService := TCalculatorService.Create;
  LResult := LService.Add(2.5, 3.7);
  Assert(Abs(LResult - 6.2) < 0.001);  // Float comparison
end;
```

## 🎓 Learning Path

### 1. Understand the Basics
- Review `CalculatorBridge.java` → Simple Java class with native methods
- Review `NativeCalc.c` → Simple C functions with JNI macros
- Review `API.JNI.Calculator.pas` → Delphi JNI wrapper

### 2. Modify the Example
- Add a new operation (e.g., modulo, power)
- Add it to C, Java, and Delphi layers
- Rebuild and test

### 3. Extend with Real Libraries
- Integrate an existing C library
- Create proper JNI wrappers for complex structs
- Handle memory management carefully

## 📚 Additional Resources

### Official Documentation
- [Android NDK Developer Guide](https://developer.android.com/ndk/guides)
- [JNI Specification (Oracle)](https://docs.oracle.com/javase/8/docs/technotes/guides/jni/)
- [Delphi Android JNI Tutorial](https://docwiki.embarcadero.com/RADStudio/en/Using_Java_Libraries_in_Delphi_Android_Apps)

### Build Tools
- [ndk-build Reference](https://developer.android.com/ndk/guides/ndk-build)
- [Android.mk Syntax](https://developer.android.com/ndk/guides/android_mk)
- [Application.mk Syntax](https://developer.android.com/ndk/guides/application_mk)

### Best Practices
- [JNI Tips (Android)](https://developer.android.com/training/articles/perf-jni)
- [FireDAC SQLite Guide](https://docwiki.embarcadero.com/RADStudio/en/Connect_to_SQLite_(Android))

## 🤝 Contributing

Contributions are welcome! Areas for improvement:

- [ ] Add more complex C library integration (e.g., image processing)
- [ ] Implement unit tests for all layers
- [ ] Add CMake build option (alternative to Android.mk)
- [ ] Create desktop version using C++ Builder RTL instead of JNI
- [ ] Add async calculation support with callbacks
- [ ] Improve error handling and validation

### How to Contribute

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/YourFeature`
3. Make your changes and test thoroughly
4. Commit with clear messages: `git commit -m 'Add XYZ feature'`
5. Push to your fork: `git push origin feature/YourFeature`
6. Open a Pull Request with detailed description

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

You are free to:
- ✅ Use commercially
- ✅ Modify
- ✅ Distribute
- ✅ Use privately

## 👤 Author

**mben-dz**

- GitHub: [@mben-dz](https://github.com/mben-dz)
- Repository: [Call-ANDROID-Native-NDK](https://github.com/mben-dz/Call-ANDROID-Native-NDK)

## 🙏 Acknowledgments

- **Embarcadero Technologies** - Delphi and FireMonkey framework
- **Google Android Team** - Android NDK and SDK
- **Community Contributors** - Testing and feedback

## 💬 Support

Need help? Here's how to get support:

1. **Check Issues**: [Existing Issues](https://github.com/mben-dz/Call-ANDROID-Native-NDK/issues)
2. **Open New Issue**: Describe your problem with:
   - Delphi version
   - Android API level
   - Error messages or logs
   - Steps to reproduce
3. **Community**: Ask in Delphi forums or Stack Overflow with tag `delphi-android-ndk`

## 📈 Version History

- **v1.0** (Current)
  - Initial release
  - Basic calculator with Add/Sub/Mul/Div
  - SQLite history persistence
  - Support for Android API 21+
  - ARM 32-bit and 64-bit support

---

⭐ **If this project helped you understand Delphi + Android NDK integration, please star the repository!**

🔗 **Share your projects built with this knowledge** - We'd love to see what you create!
