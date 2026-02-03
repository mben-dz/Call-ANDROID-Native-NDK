unit Model.History;

interface

uses
  System.SysUtils,
  API.Calculator.Interfaces;

type
  TCalculationHistory = class(TInterfacedObject, iCalculationHistory)
  private
    FID: Integer;
    FOperation: String;
    FValueA: Double;
    FValueB: Double;
    FResult: Double;
    FTimestamp: TDateTime;
  public
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

    constructor Create;
  end;

implementation
//uses
//  System.DateUtils;

constructor TCalculationHistory.Create;
begin
  inherited;
  FTimestamp := Now;
end;

function TCalculationHistory.GetID: Integer;
begin
  Result := FID;
end;

function TCalculationHistory.GetOperation: String;
begin
  Result := FOperation;
end;

function TCalculationHistory.GetResult: Double;
begin
  Result := FResult;
end;

function TCalculationHistory.GetTimestamp: TDateTime;
begin
  Result := FTimestamp;
end;

function TCalculationHistory.GetValueA: Double;
begin
  Result := FValueA;
end;

function TCalculationHistory.GetValueB: Double;
begin
  Result := FValueB;
end;

procedure TCalculationHistory.SetOperation(const aValue: String);
begin
  FOperation := aValue;
end;

procedure TCalculationHistory.SetResult(const aValue: Double);
begin
  FResult := aValue;
end;

procedure TCalculationHistory.SetValueA(const aValue: Double);
begin
  FValueA := aValue;
end;

procedure TCalculationHistory.SetValueB(const aValue: Double);
begin
  FValueB := aValue;
end;

end.
