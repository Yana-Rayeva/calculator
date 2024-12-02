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
    btnDeleteAll: TButton;
    procedure btnOneClick(Sender: TObject);
    procedure btnTwoClick(Sender: TObject);
    procedure btnThreeClick(Sender: TObject);
    procedure btnFourClick(Sender: TObject);
    procedure btnFiveClick(Sender: TObject);
    procedure btnSixClick(Sender: TObject);
    procedure btnSevenClick(Sender: TObject);
    procedure btnEightClick(Sender: TObject);
    procedure btnNineClick(Sender: TObject);
    procedure btnZeroClick(Sender: TObject);
    procedure btnDeleteSymbolClick(Sender: TObject);
    procedure btnPlusClick(Sender: TObject);
    procedure btnMinusClick(Sender: TObject);
    procedure btnMultiplyClick(Sender: TObject);
    procedure btnDivideClick(Sender: TObject);
    procedure btnEqualsClick(Sender: TObject);
    procedure btnOpenBracketClick(Sender: TObject);
    procedure btnCloseBracketClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFirstCalcClick(Sender: TObject);
    procedure btnSecondCalcClick(Sender: TObject);
    procedure btnThirdCalcClick(Sender: TObject);
    procedure btnDeleteAllClick(Sender: TObject);
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

procedure TMainFm.btnDeleteAllClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.DeleteText;
end;

// кнопки символов
procedure TMainFm.btnPlusClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('+');
end;

procedure TMainFm.btnMinusClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('-');
end;

procedure TMainFm.btnMultiplyClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('*');
end;

procedure TMainFm.btnDivideClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('/');
end;

procedure TMainFm.btnEqualsClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('=');
end;

// кнопки скобок
procedure TMainFm.btnOpenBracketClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('(');
end;

procedure TMainFm.btnCloseBracketClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol(')');
end;

// кнопки цифр
procedure TMainFm.btnZeroClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('0');
end;

procedure TMainFm.btnOneClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('1');
end;

procedure TMainFm.btnTwoClick(Sender: TObject);
begin

  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('2');
end;

procedure TMainFm.btnThreeClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('3');
end;

procedure TMainFm.btnFourClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('4');
end;

procedure TMainFm.btnFiveClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('5');
end;

procedure TMainFm.btnSixClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('6');
end;

procedure TMainFm.btnSevenClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('7');
end;

procedure TMainFm.btnEightClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('8');
end;

procedure TMainFm.btnNineClick(Sender: TObject);
begin
  CalcLineLabel.Caption := FCurrentCalc.AddSymbol('9');
end;

// кнопки переключения калькуляторов
procedure TMainFm.btnFirstCalcClick(Sender: TObject);
begin
  FCurrentCalc := FFirstCalc;
  CalcLineLabel.Caption := FCurrentCalc.ReturnCalcLine;
end;

procedure TMainFm.btnSecondCalcClick(Sender: TObject);
begin
  FCurrentCalc := FSecondCalc;
  CalcLineLabel.Caption := FCurrentCalc.ReturnCalcLine;
end;

procedure TMainFm.btnThirdCalcClick(Sender: TObject);
begin
  FCurrentCalc := FThirdCalc;
  CalcLineLabel.Caption := FCurrentCalc.ReturnCalcLine;
end;

end.
