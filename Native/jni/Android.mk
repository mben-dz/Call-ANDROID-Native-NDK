# Android.mk for Calc Demo Native Library
# Updated to match Java: System.loadLibrary("NativeCalcLIB")
# This will create: libNativeCalcLIB.so

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# ⚠️ IMPORTANT: This name MUST match System.loadLibrary("NativeCalcLIB") in Java
# Android will search for: libNativeCalcLIB.so

LOCAL_MODULE    := NativeCalcLIB
LOCAL_SRC_FILES := NativeCalc.c

# Link against Android log library
LOCAL_LDLIBS := -llog

# Compiler flags
LOCAL_CFLAGS := -Wall -Wextra -O2 -DDEBUG

# Build shared library
include $(BUILD_SHARED_LIBRARY)
