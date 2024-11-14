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
  private
    FCalculator: TCalculator;
    FTxt: string;
    FBracketCounter: integer;
    function AddText(ASymbol, AText: string): string;
    function DeleteSymbolFromText(AText: string): string;
    function CheckBracketCounterFunction(AText: string): integer;
    function CheckCorrectInputOpenBracket(ASymbol, AText: string): string;
    function CheckCorrectInputCloseBracket(ASymbol, AText: string): string;
    function CheckCorrectInputNumber(ASymbol, AText: string): string;
    function CheckCorrectInputMinus(ASymbol, AText: string): string;
    function CheckCorrectInputSymbol(ASymbol, AText: string): string;
    function FinishedLine(AText: string): string;
  public
  end;

var
  MainFm: TMainFm;

implementation

{$R *.dfm}

// запись символов в строку
function TMainFm.AddText(ASymbol, AText: string): string;
begin
  AText := AText + ASymbol;
  Result := AText;
end;

// удаление символов из строки
function TMainFm.DeleteSymbolFromText(AText: string): string;
var
  symbol: string;
begin
  if Length(AText) > 0 then
  begin
    symbol := (AText[Length(AText)]);
    FBracketCounter := CheckBracketCounterFunction(AText);
    Delete(AText, Length(AText), 1);
    Result := AText;
  end
  else
  begin
    Result := '';
  end;
end;

// проверка удаляемого символа для обновления счётчика скобок
function TMainFm.CheckBracketCounterFunction(AText: string): integer;
var
  symbol: string;
begin
  case AText[Length(AText)] of
    ')':
      begin
        FBracketCounter := FBracketCounter + 1;
        Result := FBracketCounter;
      end;
    '(':
      begin
        FBracketCounter := FBracketCounter - 1;
        Result := FBracketCounter;

      end;
  else
    Result := FBracketCounter;
  end;

end;

// проверка корректности введения "("
function TMainFm.CheckCorrectInputOpenBracket(ASymbol, AText: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  if Length(AText) > 0 then
  begin
    symbols := '0123456789)';
    symbol := (AText[Length(AText)]);
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      AText := AddText('*' + ASymbol, AText);
      FBracketCounter := FBracketCounter + 1;
      Result := AText;
    end
    else
    begin
      AText := AddText(ASymbol, AText);
      FBracketCounter := FBracketCounter + 1;
      Result := AText;
    end;
  end
  else
  begin
    AText := AddText(ASymbol, AText);
    FBracketCounter := FBracketCounter + 1;
    Result := AText;
  end;
end;

// проверка корректности введения ")"
function TMainFm.CheckCorrectInputCloseBracket(ASymbol, AText: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  If FBracketCounter > 0 then
  begin
    symbol := (AText[Length(AText)]);
    if symbol = '(' then
    begin
      ShowMessage('the value between the brackets "( )" is missing');
      Result := AText;
    end
    else
    begin
      symbols := '+-*÷';
      position := Pos(symbol, symbols);
      if position > 0 then
      begin
        AText := DeleteSymbolFromText(AText);
        AText := AddText(ASymbol, AText);
        FBracketCounter := FBracketCounter - 1;
        Result := AText;
      end
      else
      begin
        AText := AddText(ASymbol, AText);
        FBracketCounter := FBracketCounter - 1;
        Result := AText;
      end;
    end;
  end
  else
  begin
    Result := AText;
    ShowMessage('The open bracket "(" not found');
  end;
end;

// проверка введения цифр после ")"
function TMainFm.CheckCorrectInputNumber(ASymbol, AText: string): string;
var
  symbol: string;

begin
  if Length(AText) > 0 then
  begin
    symbol := (AText[Length(AText)]);
    if symbol = ')' then
    begin
      AText := AddText('*' + ASymbol, AText);
      Result := AText;
    end
    else
    begin
      AText := AddText(ASymbol, AText);
      Result := AText;
    end;
  end
  else
  begin
    AText := AddText(ASymbol, AText);
    Result := AText;
  end;
end;

// проверка корректности введения минуса
function TMainFm.CheckCorrectInputMinus(ASymbol, AText: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  if Length(AText) > 0 then
  begin
    symbols := '+-*÷';
    symbol := (AText[Length(AText)]);
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      AText := DeleteSymbolFromText(AText);
      AText := AddText(ASymbol, AText);
      Result := AText;
    end
    else
    begin
      if symbol = '(' then
      begin
        AText := AddText('0' + ASymbol, AText);
        Result := AText;
      end
      else
      begin
        AText := AddText(ASymbol, AText);
        Result := AText;
      end;
    end;
  end
  else
  begin
    AText := AddText('0' + ASymbol, AText);
    Result := AText;
  end;
end;

// проверка корректности введения операций (+ * ÷)
function TMainFm.CheckCorrectInputSymbol(ASymbol, AText: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  if Length(AText) > 0 then
  begin
    symbol := (AText[Length(AText)]);
    if symbol = '(' then
    begin
      Result := AText;
    end
    else
    begin
      symbols := '+-*÷';
      position := Pos(symbol, symbols);
      if position > 0 then
      begin
        AText := DeleteSymbolFromText(AText);
        symbol := (AText[Length(AText)]);
        if symbol = '(' then
        begin
          Result := AText;
        end
        else
        begin
          AText := AddText(ASymbol, AText);
          Result := AText;
        end;
      end
      else
      begin
        AText := AddText(ASymbol, AText);
        Result := AText;
      end;
    end;
  end
  else
  begin
    Result := AText;
  end;
end;

// проверка строки после нажатия "="
function TMainFm.FinishedLine(AText: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  symbols := '+-*÷';
  if Length(AText) > 0 then
  begin
    if AText = '-' then
    begin
      ShowMessage('no result');
      AText := '';
    end;
    If FBracketCounter = 0 then
    begin
      symbol := AText[Length(AText)];
      position := Pos(symbol, symbols);
      if position > 0 then
      begin
        AText := DeleteSymbolFromText(AText);
      end;
      Result := FormatFloat('0.##', FCalculator.Calc(AText));
    end
    else
    begin
      ShowMessage('The close bracket ")" not found');
    end;
  end
  else
  begin
    ShowMessage('no result');
  end;
  Result := AText;
end;

// создание объекта "FCalculator" после создания главного окна
procedure TMainFm.FormCreate(Sender: TObject);
begin
  FCalculator := TCalculator.Create;
end;

procedure TMainFm.FormDestroy(Sender: TObject);
begin
  FCalculator.Free;
end;

// кнопка удаления
procedure TMainFm.Button11Click(Sender: TObject);
begin
  FTxt := DeleteSymbolFromText(FTxt);
  Label1.Caption := FTxt;
end;

// кнопки символов
procedure TMainFm.Button12Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputSymbol('+', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button13Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputMinus('-', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button14Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputSymbol('*', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button15Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputSymbol('÷', FTxt);
  Label1.Caption := FTxt;
end;

// Кнопки скобок
procedure TMainFm.Button17Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputOpenBracket('(', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button18Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputCloseBracket(')', FTxt);
  Label1.Caption := FTxt;
end;

// кнопка равно
procedure TMainFm.Button16Click(Sender: TObject);
begin
  FTxt := FinishedLine(FTxt);
  Label1.Caption := FTxt;
end;

// кнопки цифр
procedure TMainFm.Button10Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('0', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button1Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('1', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button2Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('2', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button3Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('3', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button4Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('4', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button5Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('5', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button6Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('6', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button7Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('7', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button8Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('8', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Button9Click(Sender: TObject);
begin
  FTxt := CheckCorrectInputNumber('9', FTxt);
  Label1.Caption := FTxt;
end;

procedure TMainFm.Label1Click(Sender: TObject);
begin
  //
end;

end.
