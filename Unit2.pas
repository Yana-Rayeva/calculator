unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
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
    Label1: TLabel;
    Button16: TButton;
    procedure Button16Click(Sender: TObject);
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
    procedure Button15Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    function add_text(s, text: string): string;
    function delete_symbol_from_text(text: string): string;
    function add_symbol_to_text(s, text: string): string;
    function finished_line(text: string): string;
    function split_string(text: string): real;
    function calculation_result(extracted_number, extracted_symbol: string;
      firstresult: real): real;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

var
  txt: string;
  firstresult, thisresul, myresult: real;

  // запись чисел
function TForm2.add_text(s, text: string): string;
begin
  text := text + s;
  s := '';
  Result := text;
end;

// удаление символов
function TForm2.delete_symbol_from_text(text: string): string;
begin
  Delete(text, Length(text), 1);
  Result := text;
end;

// запись символов
function TForm2.add_symbol_to_text(s, text: string): string;
var
  symbol, symbols: string;
  position: real;
begin
  symbols := '+-*÷';
  if Length(text) > 0 then
  begin
    symbol := (text[Length(text)]);
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      if Length(text) > 1 then
      begin
        text := delete_symbol_from_text(text);
        text := text + s;
        s := '';
        Result := text;
      end;
    end
    else
    begin
      text := text + s;
      s := '';
      Result := text;
    end;
  end
  else
  begin
    if s = '-' then
    begin
      text := text + s;
      s := '';
      Result := text;
    end
    else
    begin
      s := '';
      Result := text;
    end;
  end;
end;

// вывод равно
function TForm2.finished_line(text: string): string;
var
  symbol, symbols: string;
  position, myresult: real;
begin
  symbols := '+-*÷';
  if Length(text) > 0 then
  begin
    symbol := (text[Length(text)]);
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      text := delete_symbol_from_text(text);
      // Result := text;
      ShowMessage(text);
    end;
    text := text + '=';
    myresult := split_string(text);
  end
  else
  begin
    ShowMessage('no result');
  end;
  text := '';
  Result := text;
end;

// функция разделения строки на числа
function TForm2.split_string(text: string): real;
var
  symbol, symbols, line, extracting_symbol, extracting_number: string;
  position, J: Integer;
begin
  myresult := 0;
  symbols := '+-*÷=';
  for J := 1 to Length(text) do
  begin
    symbol := (text[J]);
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      extracting_symbol := text[J];
      firstresult := calculation_result(extracting_number, extracting_symbol, firstresult);
      // extracting_number := '';
    end
    else
    begin
      extracting_number := extracting_number + text[J];
    end;
    // extracting_number := '';
  end;
  Result := myresult;
  ShowMessage(FloatToStr(myresult));
end;

// функция подсчёта результата
function TForm2.calculation_result(extracted_number, extracted_symbol: string; firstresult: real): real;
var
  symbol1: string;
begin
  if firstresult = 0 then
  begin
    if symbol1 = '-' then
    begin
      firstresult := StrToInt('-' + extracted_number);
      symbol1 := extracted_symbol;
      Result := firstresult;
    end
    else
    begin
      firstresult := StrToInt(extracted_number);
      symbol1 := extracted_symbol;
      Result := firstresult;
    end;
  end
  else
  begin
    if symbol1 = '-' then
    begin
      firstresult := firstresult + StrToInt('-' + extracted_number);
      symbol1 := extracted_symbol;
      Result := firstresult;
    end;
    if symbol1 = '+' then
    begin
      firstresult := firstresult + StrToInt(extracted_number);
      symbol1 := extracted_symbol;
      Result := firstresult;
    end;
    if symbol1 = '*' then
    begin
      firstresult := firstresult * StrToInt(extracted_number);
      symbol1 := extracted_symbol;
      Result := firstresult;
    end;
    if symbol1 = '÷' then
    begin
      firstresult := firstresult / StrToInt(extracted_number);
      symbol1 := extracted_symbol;
      Result := firstresult;
    end;
  end;
  if extracted_symbol = '=' then
  begin
    myresult := firstresult;
  end;
  Result := myresult;
end;

// кнопка удаления
procedure TForm2.Button11Click(Sender: TObject);
begin
  txt := delete_symbol_from_text(txt);
  Label1.Caption := txt;
end;

// кнопки символов
procedure TForm2.Button12Click(Sender: TObject);
begin
  txt := add_symbol_to_text('+', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button13Click(Sender: TObject);
begin
  txt := add_symbol_to_text('-', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button14Click(Sender: TObject);
begin
  txt := add_symbol_to_text('*', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button15Click(Sender: TObject);
begin
  txt := add_symbol_to_text('÷', txt);
  Label1.Caption := txt;
end;

// кнопка равно
procedure TForm2.Button16Click(Sender: TObject);
begin
  txt := finished_line(txt);
  Label1.Caption := txt;
  // ShowMessage(FloatToStr(myresult));
end;

// кнопки цифр
procedure TForm2.Button10Click(Sender: TObject);
begin
  txt := add_text('0', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  txt := add_text('1', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  txt := add_text('2', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  txt := add_text('3', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  txt := add_text('4', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  txt := add_text('5', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  txt := add_text('6', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  txt := add_text('7', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  txt := add_text('8', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  txt := add_text('9', txt);
  Label1.Caption := txt;
end;

procedure TForm2.Label1Click(Sender: TObject);
begin
  //
end;

end.
