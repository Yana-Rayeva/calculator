unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
    Label1: TLabel;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
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
    procedure Button18Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
  private
    function add_text(s, text: string): string;
    function delete_symbol_from_text(text: string): string;
    function check_correct_input_number(s, text: string): string;
    function check_correct_input_symbol(s, text: string): string;
    function check_correct_input_minus(s, text: string): string;
    function check_correct_input_open_bracket(s, text: string): string;
    function check_correct_input_close_bracket(s, text: string): string;
    function bracket_counter_function(counter: boolean): integer;
    function check_bracket_counter_function(text: string): integer;
    function finished_line(text: string): string;

    function split_string(text: string): real;
    function calculation_result(extracted_number, extracted_symbol: string;
      firstresult: real): real;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainFm: TMainFm;

implementation

{$R *.dfm}

var
  txt, last_symbol: string;
  firstresult, thisresul, myresult: real;
  bracket_counter: integer;

  // запись символов в строку
function TMainFm.add_text(s, text: string): string;
begin
  text := text + s;
  Result := text;
end;

// удаление символов из строки
function TMainFm.delete_symbol_from_text(text: string): string;
var
  symbol: string;
begin
  symbol := (text[Length(text)]);
  bracket_counter := check_bracket_counter_function(text);
  Delete(text, Length(text), 1);
  Result := text;
end;

// Функция счётчика скобок открытия и закрытия
function TMainFm.bracket_counter_function(counter: boolean): integer;
begin
  if counter = true then
  begin
    bracket_counter := bracket_counter + 1;
    Result := bracket_counter;
  end;
  if counter = false then
  begin
    bracket_counter := bracket_counter - 1;
    Result := bracket_counter;
  end;
end;

// Функция проверки удаляемого символа для обновления счётчика скобок
function TMainFm.check_bracket_counter_function(text: string): integer;
var
  symbol: string;
begin
  symbol := (text[Length(text)]);
  if symbol = ')' then
  begin
    bracket_counter := bracket_counter_function(true);
    Result := bracket_counter;
  end
  else if symbol = '(' then
  begin
    bracket_counter := bracket_counter_function(false);
    Result := bracket_counter;
  end
  else
  begin
    Result := bracket_counter;
  end;
end;

// Функция проверки корректности введения "("
function TMainFm.check_correct_input_open_bracket(s, text: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  if Length(text) > 0 then
  begin
    symbols := '0123456789)';
    symbol := (text[Length(text)]);
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      text := add_text('*' + s, text);
      bracket_counter := bracket_counter_function(true);
      Result := text;
    end
    else
    begin
      text := add_text(s, text);
      bracket_counter := bracket_counter_function(true);
      Result := text;
    end;
  end
  else
  begin
    text := add_text(s, text);
    bracket_counter := bracket_counter_function(true);
    Result := text;
  end;
end;

// Функция проверки корректности введения ")"
function TMainFm.check_correct_input_close_bracket(s, text: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  If bracket_counter > 0 then
  begin
    symbol := (text[Length(text)]);
    if symbol = '(' then
    begin
      ShowMessage('the value between the brackets "( )" is missing');
      Result := text;
    end
    else
    begin
    symbols := '+-*÷';
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      text := delete_symbol_from_text(text);
      text := add_text(s, text);
      bracket_counter := bracket_counter_function(false);
      Result := text;
    end
    else
    begin
      text := add_text(s, text);
      bracket_counter := bracket_counter_function(false);
      Result := text;
    end;
    end;
  end
  else
  begin
  Result := text;
  ShowMessage('The open bracket "(" not found');
  end;
end;

// Функция проверки корректности введения цифр
function TMainFm.check_correct_input_number(s, text: string): string;
var
  symbol: string;

begin
  if Length(text) > 0 then
  begin
    symbol := (text[Length(text)]);
    if symbol = ')' then
    begin
      text := add_text('*' + s, text);
      Result := text;
    end
    else
    begin
      text := add_text(s, text);
      Result := text;
    end;
  end
  else
  begin
    text := add_text(s, text);
    Result := text;
  end;
end;

// Функция проверки корректности введения минуса
function TMainFm.check_correct_input_minus(s, text: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  if Length(text) > 0 then
  begin
    symbols := '+-*÷';
    symbol := (text[Length(text)]);
    position := Pos(symbol, symbols);
    if position > 0 then
    begin
      text := delete_symbol_from_text(text);
      text := add_text(s, text);
      Result := text;
    end
    else
    begin
      if symbol = '(' then
        begin
          text := add_text('0'+s, text);
          Result := text;
        end
        else
        begin
        text := add_text(s, text);
        Result := text;
        end;
    end;
  end
  else
  begin
    text := add_text('0'+s, text);
    Result := text;
  end;
end;

// Функция проверки корректности введения операций
function TMainFm.check_correct_input_symbol(s, text: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  if Length(text) > 0 then
  begin
    symbol := (text[Length(text)]);
    if symbol = '(' then
    begin
      Result := text;
    end
    else
    begin
      symbols := '+-*÷';
      position := Pos(symbol, symbols);
      if position > 0 then
      begin
        text := delete_symbol_from_text(text);
        symbol := (text[Length(text)]);
        if symbol = '(' then
        begin
          Result := text;
        end
        else
        begin
        text := add_text(s, text);
        Result := text;
        end;
      end
      else
      begin
        text := add_text(s, text);
        Result := text;
      end;
    end;
  end
  else
  begin
    Result := text;
  end;
end;

// Функция вывода равно
function TMainFm.finished_line(text: string): string;
var
  symbol, symbols: string;
  position: integer;
begin
  symbols := '+-*÷';
  if Length(text) > 0 then
  begin
    if text = '-' then
    begin
      ShowMessage('no result');
      text := '';
    end;
    If bracket_counter = 0 then
    begin
      symbol := text[Length(text)];
      position := Pos(symbol, symbols);
      if position > 0 then
      begin
        text := delete_symbol_from_text(text);
      end;
      text := text + '=';
      myresult := split_string(text);
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
  Result := text;
end;

//-----------------------------------------------------------------------------//
// Функция разделения строки на числа
function TMainFm.split_string(text: string): real;
var
  symbol, symbols, extracting_symbol, extracting_number: string;
  position, J: integer;
begin
  firstresult := 0;
  myresult := 0;
  symbols := '+-*÷=';
  extracting_number := '';
  for J := 1 to Length(text) do
  begin
    symbol := (text[J]);
    position := Pos(symbol, symbols);
    if position = 0 then
    begin
      extracting_number := extracting_number + symbol;
    end
    else
    begin
      extracting_symbol := symbol;
      firstresult := calculation_result(extracting_number, extracting_symbol,
        firstresult);
      extracting_number := '';
    end;
  end;
  Result := myresult;
  ShowMessage(FloatToStr(myresult));
end;

// Функция подсчёта результата
function TMainFm.calculation_result(extracted_number, extracted_symbol: string;
  firstresult: real): real;
var
  number: real;
begin
  if extracted_number = '' then
  begin
    extracted_number := '0';
  end;
  number := StrToFloat(extracted_number);
  if firstresult = 0 then
  begin
    if last_symbol = '-' then
    begin
      firstresult := -number;
    end;
    if last_symbol = '' then
    begin
      firstresult := number;
    end;
  end
  else
  begin
    if last_symbol = '-' then
    begin
      firstresult := firstresult - number;
    end;
    if last_symbol = '+' then
    begin
      firstresult := firstresult + number;
    end;
    if last_symbol = '*' then
    begin
      firstresult := firstresult * number;
    end;
    if last_symbol = '÷' then
    begin
      if number = 0 then
      begin
        ShowMessage('Error: division by zero is impossible');
        // выводит последнее подсчитанное значение (исправить)
      end
      else
      begin
        firstresult := firstresult / number;
      end;
    end;
  end;
  Result := firstresult;
  last_symbol := extracted_symbol;
  if last_symbol = '=' then
  begin
    myresult := firstresult;
    Result := myresult;
    last_symbol := '';
  end;
end;
//-----------------------------------------------------------------------------//

// кнопка удаления
procedure TMainFm.Button11Click(Sender: TObject);
begin
  txt := delete_symbol_from_text(txt);
  Label1.Caption := txt;
end;

// кнопки символов
procedure TMainFm.Button12Click(Sender: TObject);
begin
  txt := check_correct_input_symbol('+', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button13Click(Sender: TObject);
begin
  txt := check_correct_input_minus('-', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button14Click(Sender: TObject);
begin
  txt := check_correct_input_symbol('*', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button15Click(Sender: TObject);
begin
  txt := check_correct_input_symbol('÷', txt);
  Label1.Caption := txt;
end;

// Кнопки скобок
procedure TMainFm.Button17Click(Sender: TObject);
begin
  txt := check_correct_input_open_bracket('(', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button18Click(Sender: TObject);
begin
  txt := check_correct_input_close_bracket(')', txt);
  Label1.Caption := txt;
end;

// кнопка равно
procedure TMainFm.Button16Click(Sender: TObject);
begin
  txt := finished_line(txt);
  Label1.Caption := txt;
end;

// кнопки цифр
procedure TMainFm.Button10Click(Sender: TObject);
begin
  txt := check_correct_input_number('0', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button1Click(Sender: TObject);
begin
  txt := check_correct_input_number('1', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button2Click(Sender: TObject);
begin
  txt := check_correct_input_number('2', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button3Click(Sender: TObject);
begin
  txt := check_correct_input_number('3', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button4Click(Sender: TObject);
begin
  txt := check_correct_input_number('4', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button5Click(Sender: TObject);
begin
  txt := check_correct_input_number('5', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button6Click(Sender: TObject);
begin
  txt := check_correct_input_number('6', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button7Click(Sender: TObject);
begin
  txt := check_correct_input_number('7', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button8Click(Sender: TObject);
begin
  txt := check_correct_input_number('8', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Button9Click(Sender: TObject);
begin
  txt := check_correct_input_number('9', txt);
  Label1.Caption := txt;
end;

procedure TMainFm.Label1Click(Sender: TObject);
begin
  //
end;

end.
