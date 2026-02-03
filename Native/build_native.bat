@echo off
REM ===================================================================
REM Build Script for Calculator Demo
REM ===================================================================

echo.
echo ===================================================================
echo Calculator Demo - Build Script
echo ===================================================================
echo.

REM Check if ANDROID_NDK_ROOT is set
if "%ANDROID_NDK_ROOT%"=="" (
    echo ERROR: ANDROID_NDK_ROOT environment variable is not set!
    echo Please set it to your NDK installation path.
    echo Example: set ANDROID_NDK_ROOT=C:\Users\Public\Documents\Embarcadero\Android\AndroidSDK\ndk
    pause
    exit /b 1
)

echo [1/3] Cleaning previous native builds...
cd native
call "%ANDROID_NDK_ROOT%\ndk-build.cmd" clean
if errorlevel 1 (
    echo ERROR: Clean failed!
    pause
    exit /b 1
)

echo.
echo [2/3] Building native library...
call "%ANDROID_NDK_ROOT%\ndk-build.cmd"
if errorlevel 1 (
    echo ERROR: NDK build failed!
    pause
    exit /b 1
)

echo.
echo [3/3] Verifying build output...
cd libs

if not exist "armeabi-v7a\libNativeCalcLIB.so" (
    echo ERROR: armeabi-v7a library not found!
    pause
    exit /b 1
)

if not exist "arm64-v8a\libNativeCalcLIB.so" (
    echo ERROR: arm64-v8a library not found!
    pause
    exit /b 1
)

echo.
echo ===================================================================
echo Build completed successfully!
echo ===================================================================
echo.
echo Generated files:
echo   - libs\armeabi-v7a\libNativeCalcLIB.soo
echo   - libs\armeabi-v7a\libc++_shared.so
echo   - libs\arm64-v8a\libNativeCalcLIB.so
echo   - libs\arm64-v8a\libc++_shared.so
echo.
echo Next steps:
echo   1. Build CalcBridge.jar from Java source
echo   2. Add files to Delphi project deployment
echo   3. Build and deploy Delphi project
echo.
echo ===================================================================

cd ..\..
pause
