unit Model.Connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.FMXUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  System.IOUtils,
  Data.DB;

type
  TdmConnection = class(TDataModule)
    FDConnection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ConfigureDatabase;
  public
    function GetConnection: TFDConnection;
  end;

var
  dmConnection: TdmConnection;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TdmConnection.DataModuleCreate(Sender: TObject);
begin
  ConfigureDatabase;
end;

procedure TdmConnection.ConfigureDatabase;
var
  LPath: string;
begin
  {$IFDEF ANDROID}
  LPath := TPath.Combine(TPath.GetDocumentsPath, 'calculator.db');
  {$ELSE}
  LPath := TPath.Combine(ExtractFilePath(ParamStr(0)), 'calculator.db');
  {$ENDIF}

  FDConnection.Params.Clear;
  FDConnection.Params.DriverID := 'SQLite';
  FDConnection.Params.Database := LPath;
  FDConnection.Params.Add('LockingMode=Normal');

  // Ensure table exists
  FDConnection.Connected := True;
  FDConnection.ExecSQL(
    'CREATE TABLE IF NOT EXISTS History (' +
    'ID INTEGER PRIMARY KEY AUTOINCREMENT, ' +
    'Operation TEXT, ' +
    'ValueA REAL, ' +
    'ValueB REAL, ' +
    'Result REAL, ' +
    'Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)');
end;

function TdmConnection.GetConnection: TFDConnection;
begin
  Result := FDConnection;
end;

end.
