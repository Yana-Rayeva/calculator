unit uCalculator;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, System.StrUtils, Math;

type
  TNode = class
  private
    FIsOperation: Boolean;
    FOperationPriority: Integer;
    FValue: Double;
    FLeft: TNode;
    FRight: TNode;
  protected

  public
    constructor Create(const AIsOperation: Boolean; AOperationPriority: Integer;
      AValue: Double; ALeft: TNode; ARight: TNode);
    destructor Destroy; override;
  end;

  TCalculator = class
  private

    FRootNode: TNode;
    FCurrentNode: TNode;
    FError: Boolean;
  public
    CalcLine: string;
    BracketCounter: Integer;
    function Calc(AText: string): string;
    function Parse(AText: string): TNode;
    function GetValue(ANode: TNode): Double;
    destructor Destroy; override;
    function AddSymbol(ASymbol, AText: string): string;
    function AddText(ASymbol, AText: string): string;
    function DeleteSymbolFromText(AText: string): string;
    function CheckBracketCounterFunction(AText: string): Integer;
    function CheckCorrectInputOpenBracket(ASymbol, AText: string): string;
    function CheckCorrectInputCloseBracket(ASymbol, AText: string): string;
    function CheckCorrectInputNumber(ASymbol, AText: string): string;
    function CheckCorrectInputMinus(ASymbol, AText: string): string;
    function CheckCorrectInputSymbol(ASymbol, AText: string): string;
    function FinishedLine(AText: string): string;
  end;

implementation

{ TNode }
{ TCalculator }

function TCalculator.AddSymbol(ASymbol, AText: string): string;

begin
  case IndexStr(ASymbol, ['-', '+', '*', '/', '(', ')', '0', '1', '2', '3', '4',
    '5', '6', '7', '8', '9', '=']) of
    0:
      begin
        Result := CheckCorrectInputMinus(ASymbol, AText);
      end;
    1, 2, 3:
      begin
        Result := CheckCorrectInputSymbol(ASymbol, AText);
      end;
    4:
      begin
        Result := CheckCorrectInputOpenBracket(ASymbol, AText);
      end;
    5:
      begin
        Result := CheckCorrectInputCloseBracket(ASymbol, AText);
      end;
    6, 7, 8, 9, 10, 11, 12, 13, 14, 15:
      begin
        Result := CheckCorrectInputNumber(ASymbol, AText);
      end;
    16:
      begin
        Result := FinishedLine(CalcLine);
      end;
  else
    begin
      Result := ('Incorrect symbol');
    end;
  end;
end;

// запись символов в строку
function TCalculator.AddText(ASymbol, AText: string): string;
begin
  AText := AText + ASymbol;
  Result := AText;
end;

// удаление символов из строки
function TCalculator.DeleteSymbolFromText(AText: string): string;
var
  Symbol: string;
begin
  if Length(AText) > 0 then
  begin
    Symbol := AText[Length(AText)];
    BracketCounter := CheckBracketCounterFunction(AText);
    Delete(AText, Length(AText), 1);
    Result := AText;
  end
  else
  begin
    Result := '';
  end;
end;

// проверка удаляемого символа для обновления счётчика скобок
function TCalculator.CheckBracketCounterFunction(AText: string): Integer;
begin
  case AText[Length(AText)] of
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
function TCalculator.CheckCorrectInputOpenBracket(ASymbol,
  AText: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  if Length(AText) > 0 then
  begin
    symbols := '0123456789)';
    Symbol := (AText[Length(AText)]);
    position := Pos(Symbol, symbols);
    if position > 0 then
    begin
      AText := AddText('*' + ASymbol, AText);
      BracketCounter := BracketCounter + 1;
      Result := AText;
    end
    else
    begin
      AText := AddText(ASymbol, AText);
      BracketCounter := BracketCounter + 1;
      Result := AText;
    end;
  end
  else
  begin
    AText := AddText(ASymbol, AText);
    BracketCounter := BracketCounter + 1;
    Result := AText;
  end;
end;

// проверка корректности введения ")"
function TCalculator.CheckCorrectInputCloseBracket(ASymbol,
  AText: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  If BracketCounter > 0 then
  begin
    Symbol := (AText[Length(AText)]);
    if Symbol = '(' then
    begin
      Result := AText;
    end
    else
    begin
      symbols := '+-*/';
      position := Pos(Symbol, symbols);
      if position > 0 then
      begin
        AText := DeleteSymbolFromText(AText);
        AText := AddText(ASymbol, AText);
        BracketCounter := BracketCounter - 1;
        Result := AText;
      end
      else
      begin
        AText := AddText(ASymbol, AText);
        BracketCounter := BracketCounter - 1;
        Result := AText;
      end;
    end;
  end
  else
  begin
    Result := AText;
  end;
end;

// проверка введения цифр после ")"
function TCalculator.CheckCorrectInputNumber(ASymbol, AText: string): string;
var
  Symbol: string;
begin
  if Length(AText) > 0 then
  begin
    Symbol := (AText[Length(AText)]);
    if Symbol = ')' then
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
function TCalculator.CheckCorrectInputMinus(ASymbol, AText: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  if Length(AText) > 0 then
  begin
    symbols := '+-*/';
    Symbol := (AText[Length(AText)]);
    position := Pos(Symbol, symbols);
    if position > 0 then
    begin
      AText := DeleteSymbolFromText(AText);
      AText := AddText(ASymbol, AText);
      Result := AText;
    end
    else
    begin
      if Symbol = '(' then
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
function TCalculator.CheckCorrectInputSymbol(ASymbol, AText: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  if Length(AText) > 0 then
  begin
    Symbol := (AText[Length(AText)]);
    if Symbol = '(' then
    begin
      Result := AText;
    end
    else
    begin
      symbols := '+-*/';
      position := Pos(Symbol, symbols);
      if position > 0 then
      begin
        AText := DeleteSymbolFromText(AText);
        Symbol := (AText[Length(AText)]);
        if Symbol = '(' then
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
function TCalculator.FinishedLine(AText: string): string;
var
  Symbol, symbols: string;
  position: Integer;
begin
  symbols := '+-*/';
  if Length(AText) > 0 then
  begin
    If BracketCounter = 0 then
    begin
      Symbol := AText[Length(AText)];
      position := Pos(Symbol, symbols);
      if position > 0 then
      begin
        AText := DeleteSymbolFromText(AText);
      end;
      AText := Calc(AText);
    end;
  end;
  Result := AText;
end;

// ============================================================================//

// создание узла дерева
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

destructor TCalculator.Destroy;
begin
  FreeAndNil(FRootNode);
  inherited;
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

// запуск парсинга, вычисления и вывод результата
function TCalculator.Calc(AText: string): string;
begin
  FRootNode.Free;
  FError := False;
  if AText[1] = '-' then
    AText := '0' + AText;
  FRootNode := Parse(AText);
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

end;

end.
