program CalculatorDemo;

{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Skia,
  System.Classes,
  System.SysUtils,
  System.Types,
  Model.Connection in 'Model\Model.Connection.pas' {dmConnection: TDataModule},
  API.Calculator.Interfaces in 'API\API.Calculator.Interfaces.pas',
  Model.History in 'Model\Model.History.pas',
  {$IFDEF ANDROID}
  API.JNI.Calculator in 'API\API.JNI.Calculator.pas',
  API.Calculator.Service in 'API\API.Calculator.Service.pas',
  {$ENDIF }
  Main.View in 'Main.View.pas' {MainView};

{$R *.res}

function RegisterFontFromRCDATA(const aFontResName: string): string;
var
  LStream: TResourceStream;
begin
  LStream := TResourceStream.Create(HInstance, aFontResName, RT_RCDATA);;
  try
    TSkDefaultProviders.RegisterTypeface(LStream);
  finally
    FreeAndNil(LStream);
  end;
end;

begin
  GlobalUseSkia := True;
  RegisterFontFromRCDATA('CalculatorIcons');
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  // Rule: DataModule created before MainForm
  Application.CreateForm(TdmConnection, dmConnection);
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
