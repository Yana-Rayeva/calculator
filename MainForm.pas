unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, uCalculator;

type
  TMainFm = class(TForm)
    btnOne: TButton;
    btnTwo: TButton;
    btnThree: TButton;
    btnFour: TButton;
    btnFive: TButton;
    btnSix: TButton;
    btnSeven: TButton;
    btnEight: TButton;
    btnNine: TButton;
    btnZero: TButton;
    btnDeleteSymbol: TButton;
    btnPlus: TButton;
    btnMinus: TButton;
    btnMultiply: TButton;
    btnDivide: TButton;
    btnEquals: TButton;
    btnOpenBracket: TButton;
    btnCloseBracket: TButton;
    CalcLineLabel: TLabel;
    btnFirstCalc: TButton;
    btnSecondCalc: TButton;
    btnThirdCalc: TButton;
    btnDeleteText: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure btnFirstCalcClick(Sender: TObject);
    procedure btnSecondCalcClick(Sender: TObject);
    procedure btnThirdCalcClick(Sender: TObject);
    procedure btnOnClick(Sender: TObject);
    procedure btnDeleteSymbolClick(Sender: TObject);
    procedure btnDeleteTextClick(Sender: TObject);
  private
    FFirstCalc: TCalculator;
    FSecondCalc: TCalculator;
    FThirdCalc: TCalculator;
    FCurrentCalc: TCalculator;
  public
  end;

var
  MainFm: TMainFm;

implementation

{$R *.dfm}

procedure TMainFm.FormCreate(Sender: TObject);
begin
  FFirstCalc := TCalculator.Create;
  FSecondCalc := TCalculator.Create;
  FThirdCalc := TCalculator.Create;
  FCurrentCalc := FFirstCalc;
end;

procedure TMainFm.FormDestroy(Sender: TObject);
begin
  FFirstCalc.Free;
  FSecondCalc.Free;
  FThirdCalc.Free;
end;

// кнопки удаления
procedure TMainFm.btnDeleteSymbolClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.DeleteSymbol;
end;

procedure TMainFm.btnDeleteTextClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.DeleteText;
end;

// кнопки введения символов
procedure TMainFm.btnOnClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol(TButton(Sender).Caption);
end;

// кнопки переключения калькуляторов
procedure TMainFm.btnFirstCalcClick(Sender: TObject);
begin
  FCurrentCalc := FFirstCalc;
  CalcLineLabel.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.btnSecondCalcClick(Sender: TObject);
begin
  FCurrentCalc := FSecondCalc;
  CalcLineLabel.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.btnThirdCalcClick(Sender: TObject);
begin
  FCurrentCalc := FThirdCalc;
  CalcLineLabel.Caption := FCurrentCalc.CalcLine;
end;

end.
