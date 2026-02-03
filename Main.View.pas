unit Main.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
{$REGION '  FMX .. '}
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Edit,
  FMX.Layouts,
  FMX.ListBox,
  FMX.Objects,
  FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo,
  FMX.Ani
{$ENDREGION}
//
, API.Calculator.Interfaces

;

type
  TMainView = class(TForm)
  {$REGION '  components .. '}
    LytRoot: TLayout;
    LytAppTitle: TLayout;
    LytTitle: TLayout;
    LytDisplay: TLayout;
    LytStatus: TLayout;
    LytLog: TLayout;
    LytClient: TLayout;
    TxtOpResult: TText;
    TxtOpFull: TText;
    FAniResult: TFloatAnimation;
    LytEdtA: TLayout;
    LytEdtB: TLayout;
    LytResult: TLayout;
    EdtValueA: TEdit;
    EdtValueB: TEdit;
    LblResult: TLabel;
    GridPnlOperations: TGridPanelLayout;
    LytHistory: TLayout;
    LytHistTitle: TLayout;
    LblHistory: TLabel;
    TxtHistory: TText;
    MemoLog: TMemo;
    LstBoxHistory: TListBox;
    RectTitle: TRectangle;
    LblTitle: TLabel;
    RectBtnAdd: TRectangle;
    BtnAdd: TButton;
    RectBtnSub: TRectangle;
    BtnSub: TButton;
    RectBtnMul: TRectangle;
    BtnMul: TButton;
    RectBtnDiv: TRectangle;
    BtnDiv: TButton;
    StyleMgr: TStyleBook;
  {$ENDREGION}
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSubClick(Sender: TObject);
    procedure btnMulClick(Sender: TObject);
    procedure btnDivClick(Sender: TObject);
  private
  {$IFDEF ANDROID}
    FService: iCalculatorService;

    procedure PerformCalculation(const aOp: Integer);
    procedure RefreshHistory;
    procedure Log(const AMsg: string);
  {$ENDIF}
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation {$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

uses
  System.Generics.Collections,
  API.Calculator.Service;

procedure TMainView.FormCreate(Sender: TObject);
begin
{$IFDEF ANDROID}
  FService := TCalculatorService.Create;

  RefreshHistory;
{$ENDIF}
end;

procedure TMainView.Log(const AMsg: string);
begin
  TThread.Queue(nil, procedure begin

      MemoLog.Lines.Add(FormatDateTime('hh:mm:ss: ', Now) + AMsg);
      MemoLog.GoToTextEnd;
    end);
end;

{$IFDEF ANDROID}
procedure TMainView.PerformCalculation(const aOp: Integer);
var
  LValA, LValB, LRes: Double;
begin
  if (edtValueA.Text = '') or (edtValueB.Text = '') then
  begin
    ShowMessage('Please enter values');
    Exit;
  end;

  LValA := StrToFloatDef(edtValueA.Text, 0);
  LValB := StrToFloatDef(edtValueB.Text, 0);

  try
  {$IFDEF ANDROID}
    case aOp of
      0: LRes := FService.Add(LValA, LValB);
      1: LRes := FService.Subtract(LValA, LValB);
      2: LRes := FService.Multiply(LValA, LValB);
      3: LRes := FService.Divide(LValA, LValB);
    else
      Exit;
    end;
  {$ENDIF}

    lblResult.Text := Format('Result: %.2f', [LRes]);
    RefreshHistory;
  except
    on E: Exception do
      Log('Error: ' + E.Message);
  end;
end;

procedure TMainView.RefreshHistory;
var
  LList: TList<iCalculationHistory>;
  LItem: iCalculationHistory;
  LListItem: TListBoxItem;
begin
  LstBoxHistory.Clear;
  LList := FService.GetHistory;
  try
    for LItem in LList do
    begin
      LListItem := TListBoxItem.Create(LstBoxHistory);
      LListItem.Text := Format('%s: %.2f and %.2f = %.2f',
        [LItem.Operation, LItem.ValueA, LItem.ValueB, LItem.Result]);
      LstBoxHistory.AddObject(LListItem);
    end;
  finally
    LList.Free;
  end;
end;
{$ENDIF}

procedure TMainView.btnAddClick(Sender: TObject);
begin
{$IFDEF ANDROID}
  PerformCalculation(0);
{$ENDIF}
end;

procedure TMainView.btnSubClick(Sender: TObject);
begin
{$IFDEF ANDROID}
  PerformCalculation(1);
{$ENDIF}
end;

procedure TMainView.btnMulClick(Sender: TObject);
begin
{$IFDEF ANDROID}
  PerformCalculation(2);
{$ENDIF}
end;

procedure TMainView.btnDivClick(Sender: TObject);
begin
{$IFDEF ANDROID}
  PerformCalculation(3);
{$ENDIF}
end;

end.
