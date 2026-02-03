#include <jni.h>
#include <stdlib.h>  // ← ADDED: Required for free()
#include <string.h>
#include <android/log.h>

/*
 Name: NativeCalc.c
 Native C implementation of math operations
 Exported for this java class file:
 com/MBenDelphi/CalculatorDemo/CalculatorBridge
*/

#define LOG_TAG "CALC_JNI"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

JNIEXPORT jdouble JNICALL
Java_com_MBenDelphi_CalculatorDemo_CalculatorBridge_nativeAdd(JNIEnv *env, jobject thiz, jdouble a, jdouble b) {
    (void)env;   // Mark as intentionally unused
	(void)thiz;  // Mark as intentionally unused

	LOGD("nativeAdd called");
	return a + b;
}

JNIEXPORT jdouble JNICALL
Java_com_MBenDelphi_CalculatorDemo_CalculatorBridge_nativeSub(JNIEnv *env, jobject thiz, jdouble a, jdouble b) {
    (void)env;   // Mark as intentionally unused
	(void)thiz;  // Mark as intentionally unused

	LOGD("nativeSub called");

	return a - b;
}

JNIEXPORT jdouble JNICALL
Java_com_MBenDelphi_CalculatorDemo_CalculatorBridge_nativeMul(JNIEnv *env, jobject thiz, jdouble a, jdouble b) {
    (void)env;   // Mark as intentionally unused
	(void)thiz;  // Mark as intentionally unused

	LOGD("nativeMul called");

	return a * b;
}

JNIEXPORT jdouble JNICALL
Java_com_MBenDelphi_CalculatorDemo_CalculatorBridge_nativeDiv(JNIEnv *env, jobject thiz, jdouble a, jdouble b) {
    (void)env;   // Mark as intentionally unused
	(void)thiz;  // Mark as intentionally unused

	LOGD("nativeDiv called");

    if (b == 0) return 0.0;
    return a / b;
}
