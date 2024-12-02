unit uCalculator;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.StrUtils, Math;

type
  TNode = class
  private
    FIsOperation: Boolean;
    FOperationPriority: Integer;
    FValue: Double;
    FLeft: TNode;
    FRight: TNode;
  public
    constructor Create(const AIsOperation: Boolean; AOperationPriority: Integer;
      AValue: Double; ALeft: TNode; ARight: TNode);
    destructor Destroy; override;
  end;

  TCalculator = class
  private
    CalcLine: string;
    BracketCounter: Integer;
    FRootNode: TNode;
    FCurrentNode: TNode;
    FError: Boolean;
    function CheckBracketCounterFunction(): Integer;
    function CheckCorrectInputOpenBracket(ASymbol: string): string;
    function CheckCorrectInputCloseBracket(ASymbol: string): string;
    function CheckCorrectInputNumber(ASymbol: string): string;
    function CheckCorrectInputMinus(ASymbol: string): string;
    function CheckCorrectInputSymbol(ASymbol: string): string;
    function FinishedLine(): string;
    function Parse(AText: string): TNode;
    function GetValue(ANode: TNode): Double;
  public
    function Calc: string;
    function AddText(AText: string): string;
    function AddSymbol(ASymbol: string): string;
    function DeleteSymbol: string;
    function DeleteText: string;
    function ReturnCalcLine: string;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TNode }
constructor TNode.Create(const AIsOperation: Boolean;
  AOperationPriority: Integer; AValue: Double; ALeft: TNode; ARight: TNode);
begin
  FIsOperation := AIsOperation;
  FOperationPriority := AOperationPriority;
  FValue := AValue;
  FLeft := ALeft;
  FRight := ARight;
end;

destructor TNode.Destroy;
begin
  FreeAndNil(FLeft);
  FreeAndNil(FRight);
  inherited;
end;

{ TCalculator }
constructor TCalculator.Create;
begin
  CalcLine := '';
  BracketCounter := 0;
  FError := False;
  FRootNode := nil;
  FCurrentNode := nil;
  inherited;
end;

destructor TCalculator.Destroy;
begin
  FreeAndNil(FRootNode);
  inherited;
end;

function TCalculator.ReturnCalcLine: string;
begin
  Result := CalcLine;
end;

function TCalculator.AddText(AText: string): string;
begin
  CalcLine := AText;
end;

function TCalculator.AddSymbol(ASymbol: string): string;
begin
  case IndexStr(ASymbol, ['-', '+', '*', '/', '(', ')', '0', '1', '2', '3', '4',
    '5', '6', '7', '8', '9', '=']) of
    0:
      begin
        Result := CheckCorrectInputMinus(ASymbol);
      end;
    1, 2, 3:
      begin
        Result := CheckCorrectInputSymbol(ASymbol);
      end;
    4:
      begin
        Result := CheckCorrectInputOpenBracket(ASymbol);
      end;
    5:
      begin
        Result := CheckCorrectInputCloseBracket(ASymbol);
      end;
    6, 7, 8, 9, 10, 11, 12, 13, 14, 15:
      begin
        Result := CheckCorrectInputNumber(ASymbol);
      end;
    16:
      begin
        Result := FinishedLine();
      end;
  else
    begin
      FError := True;
      Result := ('Incorrect symbol');
    end;
  end;
end;

function TCalculator.DeleteSymbol: string;
var
  Symbol: string;
begin
  if Length(CalcLine) > 0 then
  begin
    Symbol := CalcLine[Length(CalcLine)];
    BracketCounter := CheckBracketCounterFunction();
    Delete(CalcLine, Length(CalcLine), 1);
  end
  else
  begin
    CalcLine := '';
  end;
  Result := CalcLine;
end;

function TCalculator.DeleteText: string;
begin
  CalcLine := '';
  BracketCounter := 0;
  Result := CalcLine;
end;

// проверка удаляемого символа для обновления счётчика скобок
function TCalculator.CheckBracketCounterFunction(): Integer;
begin
  case CalcLine[Length(CalcLine)] of
    ')':
      begin
        BracketCounter := BracketCounter + 1;
        Result := BracketCounter;
      end;
    '(':
      begin
        BracketCounter := BracketCounter - 1;
        Result := BracketCounter;
      end;
  else
    Result := BracketCounter;
  end;
end;

// проверка корректности введения "("
function TCalculator.CheckCorrectInputOpenBracket(ASymbol: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  if Length(CalcLine) > 0 then
  begin
    symbols := '0123456789)';
    Symbol := (CalcLine[Length(CalcLine)]);
    position := Pos(Symbol, symbols);
    if position > 0 then
    begin
      CalcLine := CalcLine + '*' + ASymbol;
      BracketCounter := BracketCounter + 1;
      Result := CalcLine;
    end
    else
    begin
      CalcLine := CalcLine + ASymbol;
      BracketCounter := BracketCounter + 1;
      Result := CalcLine;
    end;
  end
  else
  begin
    CalcLine := CalcLine + ASymbol;
    BracketCounter := BracketCounter + 1;
    Result := CalcLine;
  end;
end;

// проверка корректности введения ")"
function TCalculator.CheckCorrectInputCloseBracket(ASymbol: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  If BracketCounter > 0 then
  begin
    Symbol := (CalcLine[Length(CalcLine)]);
    if Symbol = '(' then
    begin
      Result := CalcLine;
    end
    else
    begin
      symbols := '+-*/';
      position := Pos(Symbol, symbols);
      if position > 0 then
      begin
        DeleteSymbol;
        CalcLine := CalcLine + ASymbol;
        BracketCounter := BracketCounter - 1;
        Result := CalcLine;
      end
      else
      begin
        CalcLine := CalcLine + ASymbol;
        BracketCounter := BracketCounter - 1;
        Result := CalcLine;
      end;
    end;
  end
  else
  begin
    Result := CalcLine;
  end;
end;

// проверка введения цифр после ")"
function TCalculator.CheckCorrectInputNumber(ASymbol: string): string;
var
  Symbol: string;
begin
  if Length(CalcLine) > 0 then
  begin
    Symbol := (CalcLine[Length(CalcLine)]);
    if Symbol = ')' then
    begin
      CalcLine := CalcLine + '*' + ASymbol;
      Result := CalcLine;
    end
    else
    begin
      CalcLine := CalcLine + ASymbol;
      Result := CalcLine;
    end;
  end
  else
  begin
    CalcLine := CalcLine + ASymbol;
    Result := CalcLine;
  end;
end;

// проверка корректности введения минуса -
function TCalculator.CheckCorrectInputMinus(ASymbol: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  if Length(CalcLine) > 0 then
  begin
    symbols := '+-*/';
    Symbol := (CalcLine[Length(CalcLine)]);
    position := Pos(Symbol, symbols);
    if position > 0 then
    begin
      DeleteSymbol;
      CalcLine := CalcLine + ASymbol;
      Result := CalcLine;
    end
    else
    begin
      if Symbol = '(' then
      begin
        CalcLine := CalcLine + '0' + ASymbol;
        Result := CalcLine;
      end
      else
      begin
        CalcLine := CalcLine + ASymbol;
        Result := CalcLine;
      end;
    end;
  end
  else
  begin
    CalcLine := CalcLine + '0' + ASymbol;
    Result := CalcLine;
  end;
end;

// проверка корректности введения операций (+ * ÷)
function TCalculator.CheckCorrectInputSymbol(ASymbol: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  if Length(CalcLine) > 0 then
  begin
    Symbol := (CalcLine[Length(CalcLine)]);
    if Symbol = '(' then
    begin
      Result := CalcLine;
    end
    else
    begin
      symbols := '+-*/';
      position := Pos(Symbol, symbols);
      if position > 0 then
      begin
        DeleteSymbol;
        Symbol := (CalcLine[Length(CalcLine)]);
        if Symbol = '(' then
        begin
          Result := CalcLine;
        end
        else
        begin
          CalcLine := CalcLine + ASymbol;
          Result := CalcLine;
        end;
      end
      else
      begin
        CalcLine := CalcLine + ASymbol;
        Result := CalcLine;
      end;
    end;
  end
  else
  begin
    Result := CalcLine;
  end;
end;

// проверка строки после нажатия "="
function TCalculator.FinishedLine(): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  symbols := '+-*/';
  if Length(CalcLine) > 0 then
  begin
    If BracketCounter = 0 then
    begin
      Symbol := CalcLine[Length(CalcLine)];
      position := Pos(Symbol, symbols);
      if position > 0 then
      begin
        DeleteSymbol;
      end;
      CalcLine := Calc();
    end;
  end;
  Result := CalcLine;
end;

// запуск парсинга, вычисления и вывод результата
function TCalculator.Calc(): string;
begin
  FRootNode.Free;
  FRootNode := Parse(CalcLine);
  if FError then
  begin
    Result := 'Error: Incorrect string';
  end
  else
  begin
    Result := FormatFloat('0.###', GetValue(FRootNode));
    if FError then
    begin
      Result := 'Error: Division by zero';
    end;
  end;
  FError := False;
end;

// пасинг строки
function TCalculator.Parse(AText: string): TNode;
var
  i, vBracketCount: Integer;
  vRight, vLeft: string;
  vValue: Double;
  vСheckbox: Boolean;
begin
  Result := nil;
  vBracketCount := 0;
  vСheckbox := False;
  if AText.Length > 0 then
    if AText[1] = '-' then
      AText := '0' + AText;
  // Для поиска + и - вне скобок
  for i := Length(AText) downto 1 do
  begin
    if vСheckbox = True then
      break;
    case AText[i] of
      '(':
        vBracketCount := vBracketCount + 1;
      ')':
        vBracketCount := vBracketCount - 1;
      '+':
        begin
          if vBracketCount = 0 then
          begin
            vСheckbox := True;
            vLeft := Copy(AText, 1, i - 1);
            vRight := Copy(AText, i + 1, Length(AText) - i);
            FCurrentNode := TNode.Create(True, 0, 00, Parse(vLeft),
              Parse(vRight));
            Result := FCurrentNode;
          end;
        end;
      '-':
        begin
          if vBracketCount = 0 then
          begin
            vСheckbox := True;
            vLeft := Copy(AText, 1, i - 1);
            vRight := Copy(AText, i + 1, Length(AText) - i);
            FCurrentNode := TNode.Create(True, 0, 01, Parse(vLeft),
              Parse(vRight));
            Result := FCurrentNode;
          end;
        end;
    else
    end;
  end;
  vBracketCount := 0;
  // Для поиска * и ÷ вне скобок
  for i := Length(AText) downto 1 do
  begin
    if vСheckbox = True then
      break;
    case AText[i] of
      '(':
        vBracketCount := vBracketCount + 1;
      ')':
        vBracketCount := vBracketCount - 1;
      '*':
        begin
          if vBracketCount = 0 then
          begin
            vСheckbox := True;
            vLeft := Copy(AText, 1, i - 1);
            vRight := Copy(AText, i + 1, Length(AText) - i);
            FCurrentNode := TNode.Create(True, 1, 10, Parse(vLeft),
              Parse(vRight));
            Result := FCurrentNode;
          end;
        end;
      '/':
        begin
          if vBracketCount = 0 then
          begin
            vСheckbox := True;
            vLeft := Copy(AText, 1, i - 1);
            vRight := Copy(AText, i + 1, Length(AText) - i);
            FCurrentNode := TNode.Create(True, 1, 11, Parse(vLeft),
              Parse(vRight));
            Result := FCurrentNode;
          end;
        end;
    else
    end;
  end;
  // удаление крайних скобок
  if vСheckbox = False then
  begin
    if (Length(AText) > 0) and (AText[1] = '(') and (AText[Length(AText)] = ')')
    then
    begin
      AText := Copy(AText, 2, Length(AText) - 2);
      if AText[1] = '-' then
        AText := '0' + AText;
      FCurrentNode := Parse(AText);
      Result := FCurrentNode;
    end
    else
    // создание узла с числом (листья дерева)
    begin
      if TryStrToFloat(AText, vValue) then
      begin
        FCurrentNode := TNode.Create(False, 0, vValue, nil, nil);
        Result := FCurrentNode;
      end
      else
      begin
        FError := True;
        Result := nil;
      end;
    end;
  end;
end;




// подсчёт значения узла
function TCalculator.GetValue(ANode: TNode): Double;
begin
  Result := 0;
  if ANode.FIsOperation then
  begin
    case Round(ANode.FValue) of
      0:
        begin
          Result := GetValue(ANode.FLeft) + GetValue(ANode.FRight);
        end;
      1:
        begin
          Result := GetValue(ANode.FLeft) - GetValue(ANode.FRight);
        end;
      10:
        begin
          Result := GetValue(ANode.FLeft) * GetValue(ANode.FRight);
        end;
      11:
        begin
          if not IsZero(GetValue(ANode.FRight)) then
            Result := GetValue(ANode.FLeft) / GetValue(ANode.FRight)
          else
          begin
            FError := True;
            Result := 0;
          end;
        end;
    else
    end;
  end
  else
  begin
    Result := ANode.FValue;
  end;
end;
end.
