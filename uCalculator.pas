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
    FCalcLine: string;
    FBracketCounter: Integer;
    FError: Boolean;
    function CheckBracketCounterFunction: Integer;
    function CheckCorrectInputOpenBracket(const ASymbol: string): string;
    function CheckCorrectInputCloseBracket(const ASymbol: string): string;
    function CheckCorrectInputNumber(const ASymbol: string): string;
    function CheckCorrectInputMinus(const ASymbol: string): string;
    function CheckCorrectInputSymbol(const ASymbol: string): string;
    function FinishedLine: string;
    function Parse(const AText: string): TNode;
    function GetValue(ANode: TNode): Double;
  public
    constructor Create;
    destructor Destroy; override;

    function Calc: string;
    function AddSymbol(const ASymbol: string): string;
    function DeleteSymbol: string;
    function DeleteText: string;

    property CalcLine: string read FCalcLine write FCalcLine;

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
  FCalcLine := '';
  FBracketCounter := 0;
  FError := False;
  inherited;
end;

destructor TCalculator.Destroy;
begin

  inherited;
end;

function TCalculator.AddSymbol(const ASymbol: string): string;
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
  end;
end;

function TCalculator.DeleteSymbol: string;
var
  vSymbol: string;
begin
  if Length(FCalcLine) > 0 then
  begin
    vSymbol := FCalcLine[Length(FCalcLine)];
    FBracketCounter := CheckBracketCounterFunction();
    Delete(FCalcLine, Length(FCalcLine), 1);
  end;
  Result := FCalcLine;
end;

function TCalculator.DeleteText: string;
begin
  FCalcLine := '';
  FBracketCounter := 0;
  Result := FCalcLine;
end;

// проверка удаляемого символа для обновления счётчика скобок
function TCalculator.CheckBracketCounterFunction(): Integer;
begin
  case FCalcLine[Length(FCalcLine)] of
    ')':
        FBracketCounter := FBracketCounter + 1;
    '(':
        FBracketCounter := FBracketCounter - 1;
  end;
  Result := FBracketCounter;
end;

// проверка корректности введения "("
function TCalculator.CheckCorrectInputOpenBracket(const ASymbol: string): string;
var
  vSymbol, vSymbols: string;
  vPosition: Integer;
begin
  if Length(FCalcLine) > 0 then
  begin
    vSymbols := '0123456789)';
    vSymbol := FCalcLine[Length(FCalcLine)];
    vPosition := Pos(vSymbol, vSymbols);
    if vPosition > 0 then
    begin
      FCalcLine := FCalcLine + '*' + ASymbol;
      FBracketCounter := FBracketCounter + 1;
    end
    else
    begin
      FCalcLine := FCalcLine + ASymbol;
      FBracketCounter := FBracketCounter + 1;
    end;
  end
  else
  begin
    FCalcLine := FCalcLine + ASymbol;
    FBracketCounter := FBracketCounter + 1;
  end;
  Result := FCalcLine;
end;

// проверка корректности введения ")"
function TCalculator.CheckCorrectInputCloseBracket(const ASymbol: string): string;
var
  vSymbol, vSymbols: string;
  vPosition: Integer;
begin
  If FBracketCounter > 0 then
  begin
    vSymbol := FCalcLine[Length(FCalcLine)];
    if vSymbol <> '(' then
    begin
      vSymbols := '+-*/';
      vPosition := Pos(vSymbol, vSymbols);
      if vPosition > 0 then
      begin
        FCalcLine := DeleteSymbol;
        FCalcLine := FCalcLine + ASymbol;
        FBracketCounter := FBracketCounter - 1;
      end
      else
      begin
        FCalcLine := FCalcLine + ASymbol;
        FBracketCounter := FBracketCounter - 1;
      end;
    end;
  end;
  Result := FCalcLine;
end;

// проверка введения цифр после ")"
function TCalculator.CheckCorrectInputNumber(const ASymbol: string): string;
var
  vSymbol: string;
begin
  if Length(FCalcLine) > 0 then
  begin
    vSymbol := FCalcLine[Length(FCalcLine)];
    if vSymbol = ')' then
    begin
      FCalcLine := FCalcLine + '*' + ASymbol;
      Result := FCalcLine;
    end
    else
    begin
      FCalcLine := FCalcLine + ASymbol;
      Result := FCalcLine;
    end;
  end
  else
  begin
    FCalcLine := FCalcLine + ASymbol;
    Result := FCalcLine;
  end;
end;

// проверка корректности введения минуса -
function TCalculator.CheckCorrectInputMinus(const ASymbol: string): string;
var
  vSymbol, vSymbols: string;
  vPosition: Integer;
begin
  if Length(FCalcLine) > 0 then
  begin
    vSymbols := '+-*/';
    vSymbol := FCalcLine[Length(FCalcLine)];
    vPosition := Pos(vSymbol, vSymbols);
    if vPosition > 0 then
    begin
      DeleteSymbol;
      FCalcLine := FCalcLine + ASymbol;
      Result := FCalcLine;
    end
    else
    begin
      if vSymbol = '(' then
      begin
        FCalcLine := FCalcLine + '0' + ASymbol;
        Result := FCalcLine;
      end
      else
      begin
        FCalcLine := FCalcLine + ASymbol;
        Result := FCalcLine;
      end;
    end;
  end
  else
  begin
    FCalcLine := FCalcLine + '0' + ASymbol;
    Result := FCalcLine;
  end;
end;

// проверка корректности введения операций (+ * ÷)
function TCalculator.CheckCorrectInputSymbol(const ASymbol: string): string;
var
  vSymbol, vSymbols: string;
  vPosition: Integer;
begin
  if Length(FCalcLine) > 0 then
  begin
    vSymbol := FCalcLine[Length(FCalcLine)];
    if vSymbol = '(' then
    begin
      Result := FCalcLine;
    end
    else
    begin
      vSymbols := '+-*/';
      vPosition := Pos(vSymbol, vSymbols);
      if vPosition > 0 then
      begin
        DeleteSymbol;
        vSymbol := FCalcLine[Length(FCalcLine)];
        if vSymbol = '(' then
        begin
          Result := FCalcLine;
        end
        else
        begin
          FCalcLine := FCalcLine + ASymbol;
          Result := FCalcLine;
        end;
      end
      else
      begin
        FCalcLine := FCalcLine + ASymbol;
        Result := FCalcLine;
      end;
    end;
  end
  else
  begin
    Result := FCalcLine;
  end;
end;

// проверка строки после нажатия "="
function TCalculator.FinishedLine: string;
var
  vSymbol, vSymbols: string;
  vPosition: Integer;
begin
  vSymbols := '+-*/';
  if Length(FCalcLine) > 0 then
  begin
    If FBracketCounter = 0 then
    begin
      vSymbol := FCalcLine[Length(FCalcLine)];
      vPosition := Pos(vSymbol, vSymbols);
      if vPosition > 0 then
      begin
        DeleteSymbol;
      end;
      FCalcLine := Calc;
    end;
  end;
  Result := FCalcLine;
end;

// запуск парсинга, вычисления и вывод результата
function TCalculator.Calc: string;
var
  vRootNode: TNode;
begin
  vRootNode := Parse(FCalcLine);
  if FError then
  begin
    Result := 'Error: Incorrect string';
  end
  else
  begin
    Result := FormatFloat('0.###', GetValue(vRootNode));
    if FError then
    begin
      Result := 'Error: Division by zero';
    end;
  end;
  FError := False;
  vRootNode.Free;
end;

// парсинг строки
function TCalculator.Parse(const AText: string): TNode;
var
  i, vBracketCount: Integer;
  vRight, vLeft, vText: string;
  vValue: Double;
  vFlag: Boolean;
begin
  Result := nil;
  vBracketCount := 0;
  vFlag := False;
  vText := AText;
  if vText.Length > 0 then
    if vText[1] = '-' then
      vText := '0' + vText;
  // Для поиска + и - вне скобок
  for i := Length(vText) downto 1 do
  begin
    if vFlag then
      break;
    case vText[i] of
      '(':
        vBracketCount := vBracketCount + 1;
      ')':
        vBracketCount := vBracketCount - 1;
      '+':
        begin
          if vBracketCount = 0 then
          begin
            vFlag := True;
            vLeft := Copy(vText, 1, i - 1);
            vRight := Copy(vText, i + 1, Length(vText) - i);
            Result := TNode.Create(True, 0, 00, Parse(vLeft), Parse(vRight));
          end;
        end;
      '-':
        begin
          if vBracketCount = 0 then
          begin
            vFlag := True;
            vLeft := Copy(vText, 1, i - 1);
            vRight := Copy(vText, i + 1, Length(vText) - i);
            Result := TNode.Create(True, 0, 01, Parse(vLeft), Parse(vRight));
          end;
        end;
    else
    end;
  end;
  vBracketCount := 0;
  // Для поиска * и ÷ вне скобок
  for i := Length(vText) downto 1 do
  begin
    if vFlag then
      break;
    case vText[i] of
      '(':
        vBracketCount := vBracketCount + 1;
      ')':
        vBracketCount := vBracketCount - 1;
      '*':
        begin
          if vBracketCount = 0 then
          begin
            vFlag := True;
            vLeft := Copy(vText, 1, i - 1);
            vRight := Copy(vText, i + 1, Length(vText) - i);
            Result := TNode.Create(True, 1, 10, Parse(vLeft), Parse(vRight));
          end;
        end;
      '/':
        begin
          if vBracketCount = 0 then
          begin
            vFlag := True;
            vLeft := Copy(vText, 1, i - 1);
            vRight := Copy(vText, i + 1, Length(vText) - i);
            Result := TNode.Create(True, 1, 11, Parse(vLeft), Parse(vRight));
          end;
        end;
    else
    end;
  end;
  // удаление внешних скобок
  if not vFlag then
  begin
    if (Length(vText) > 0) and (vText[1] = '(') and (vText[Length(vText)] = ')')
    then
    begin
      vText := Copy(vText, 2, Length(vText) - 2);
      if vText[1] = '-' then
        vText := '0' + vText;
      Result := Parse(vText);
    end
    else
    // создание узла с числом (листья дерева)
    begin
      if TryStrToFloat(vText, vValue) then
      begin
        Result := TNode.Create(False, 0, vValue, nil, nil);
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
    end;
  end
  else
  begin
    Result := ANode.FValue;
  end;
end;
end.
