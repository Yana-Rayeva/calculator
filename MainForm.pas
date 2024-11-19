unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uCalculator;

type
  TMainFm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Label1: TLabel;
    btnFirst: TButton;
    btnSecond: TButton;
    btnThird: TButton;
    btnDeleteAll: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
    procedure btnSecondClick(Sender: TObject);
    procedure btnThirdClick(Sender: TObject);
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

// создание объекта "FCalculator" после создания главного окна
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
procedure TMainFm.Button11Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.DeleteSymbolFromText
    (FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.btnDeleteAllClick(Sender: TObject);
begin
  FCurrentCalc.CalcLine := '';
  FCurrentCalc.BracketCounter := 0;
  Label1.Caption := FCurrentCalc.CalcLine;
end;

// кнопки символов
procedure TMainFm.Button12Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('+', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button13Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('-', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button14Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('*', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button15Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('/', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

// кнопки скобок
procedure TMainFm.Button17Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('(', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button18Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol(')', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

// кнопка равно
procedure TMainFm.Button16Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('=', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

// кнопки цифр
procedure TMainFm.Button10Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('0', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button1Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('1', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button2Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('2', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button3Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('3', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button4Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('4', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button5Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('5', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button6Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('6', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button7Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('7', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button8Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('8', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Button9Click(Sender: TObject);
begin
  FCurrentCalc.CalcLine := FCurrentCalc.AddSymbol('9', FCurrentCalc.CalcLine);
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.Label1Click(Sender: TObject);
begin
  //
end;

// кнопки переключения калькуляторов
procedure TMainFm.btnFirstClick(Sender: TObject);
begin
  FCurrentCalc := FFirstCalc;
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.btnSecondClick(Sender: TObject);
begin
  FCurrentCalc := FSecondCalc;
  Label1.Caption := FCurrentCalc.CalcLine;
end;

procedure TMainFm.btnThirdClick(Sender: TObject);
begin
  FCurrentCalc := FThirdCalc;
  Label1.Caption := FCurrentCalc.CalcLine;
end;

end.
