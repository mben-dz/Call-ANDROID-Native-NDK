unit API.Calculator.Interfaces;

interface

uses
  System.Generics.Collections;

type
  // Model Interface
  iCalculationHistory = interface ['{A1B2C3D4-E5F6-4000-8000-000000000001}']
    function GetID: Integer;
    function GetOperation: String;
    function GetValueA: Double;
    function GetValueB: Double;
    function GetResult: Double;
    function GetTimestamp: TDateTime;
    
    procedure SetOperation(const aValue: String);
    procedure SetValueA(const aValue: Double);
    procedure SetValueB(const aValue: Double);
    procedure SetResult(const aValue: Double);
    
    property Operation: String read GetOperation write SetOperation;
    property ValueA: Double read GetValueA write SetValueA;
    property ValueB: Double read GetValueB write SetValueB;
    property Result: Double read GetResult write SetResult;
  end;

  // Service Interface
  iCalculatorService = interface ['{A1B2C3D4-E5F6-4000-8000-000000000002}']
    function Add(const a, b: Double): Double;
    function Subtract(const a, b: Double): Double;
    function Multiply(const a, b: Double): Double;
    function Divide(const a, b: Double): Double;
    function GetHistory: TList<iCalculationHistory>;
  end;

implementation

end.