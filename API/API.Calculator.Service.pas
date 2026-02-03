unit API.Calculator.Service;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  API.Calculator.Interfaces,
  API.JNI.Calculator,
  Model.Connection,
  Model.History,
  FireDAC.Comp.Client;

type
  TCalculatorService = class(TInterfacedObject, iCalculatorService)
  private
    FJavaBridge: JCalculatorBridge;
    procedure LogHistory(const aOp: String; const a, b, aResult: Double);

  public
    constructor Create;
    function Add(const a, b: Double): Double;
    function Subtract(const a, b: Double): Double;
    function Multiply(const a, b: Double): Double;
    function Divide(const a, b: Double): Double;
    function GetHistory: TList<iCalculationHistory>;
  end;

implementation

uses
  Androidapi.Helpers;

constructor TCalculatorService.Create;
begin
  inherited;
  // Initialize the Java Class via JNI
  FJavaBridge := TJCalculatorBridge.JavaClass.init;
end;

procedure TCalculatorService.LogHistory(const aOp: String; const a, b, aResult: Double);
var
  LConn: TFDConnection;
begin
  LConn := dmConnection.GetConnection;
  LConn.StartTransaction;
  try
    LConn.ExecSQL(
      'INSERT INTO History (Operation, ValueA, ValueB, Result) VALUES (:Op, :A, :B, :Res)',
      [aOp, a, b, aResult]);
    LConn.Commit;
  except
    LConn.Rollback;
    raise;
  end;
end;

function TCalculatorService.Add(const a, b: Double): Double;
begin
  // Call Java -> Native C
  Result := FJavaBridge.nativeAdd(a, b);
  LogHistory('ADD', a, b, Result);
end;

function TCalculatorService.Subtract(const a, b: Double): Double;
begin
  Result := FJavaBridge.nativeSub(a, b);
  LogHistory('SUB', a, b, Result);
end;

function TCalculatorService.Multiply(const a, b: Double): Double;
begin
  Result := FJavaBridge.nativeMul(a, b);
  LogHistory('MUL', a, b, Result);
end;

function TCalculatorService.Divide(const a, b: Double): Double;
begin
  Result := FJavaBridge.nativeDiv(a, b);
  LogHistory('DIV', a, b, Result);
end;

function TCalculatorService.GetHistory: TList<iCalculationHistory>;
var
  LQuery: TFDQuery;
  LItem: iCalculationHistory;
begin
  Result := TList<iCalculationHistory>.Create;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := dmConnection.GetConnection;
    LQuery.Open('SELECT * FROM History ORDER BY ID DESC LIMIT 20');
    while not LQuery.Eof do
    begin
      LItem := TCalculationHistory.Create;
      LItem.Operation := LQuery.FieldByName('Operation').AsString;
      LItem.ValueA := LQuery.FieldByName('ValueA').AsFloat;
      LItem.ValueB := LQuery.FieldByName('ValueB').AsFloat;
      LItem.Result := LQuery.FieldByName('Result').AsFloat;
      Result.Add(LItem);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

end.
