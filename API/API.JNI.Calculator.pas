unit API.JNI.Calculator;

interface

uses
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes;

type
// ===== Forward declarations =====

  JCalculatorBridge = interface;//com.MBenDelphi.CalculatorDemo.CalculatorBridge

// ===== Interface declarations =====

  JCalculatorBridgeClass = interface(JObjectClass) ['{36C6AE53-2083-4734-9E5B-30CD2C4324AC}']

    {class} function init: JCalculatorBridge; cdecl;
  end;

  [JavaSignature('com/MBenDelphi/CalculatorDemo/CalculatorBridge')]
  JCalculatorBridge = interface(JObject) ['{B0DB393C-F4D6-4C4D-BE3B-6C427CD2AC89}']

    function nativeAdd(d: Double; d1: Double): Double; cdecl;
    function nativeDiv(d: Double; d1: Double): Double; cdecl;
    function nativeMul(d: Double; d1: Double): Double; cdecl;
    function nativeSub(d: Double; d1: Double): Double; cdecl;
  end;
  TJCalculatorBridge = class(TJavaGenericImport<JCalculatorBridgeClass, JCalculatorBridge>) end;

implementation

procedure RegisterTypes;
begin
  TRegTypes.RegisterType('API.JNI.Calculator.JCalculatorBridge', TypeInfo(API.JNI.Calculator.JCalculatorBridge));
end;

initialization
  RegisterTypes;
end.
