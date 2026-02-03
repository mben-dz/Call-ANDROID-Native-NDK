package com.MBenDelphi.CalculatorDemo;

public class CalculatorBridge {

    // Load the C library
    static {
        System.loadLibrary("NativeCalcLIB");
    }

    // Declare native methods implemented in C
    public native double nativeAdd(double a, double b);
    public native double nativeSub(double a, double b);
    public native double nativeMul(double a, double b);
    public native double nativeDiv(double a, double b);

}
