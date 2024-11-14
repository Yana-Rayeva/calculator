unit uCalculator;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
  end;

  TCalculator = class
  private
    FRootNode: TNode;
    FCurrentNode: TNode;
  public
    function Calc(AText: string): Double;
    function Parse(AText: string): TNode;
    function GetValue(ANode: TNode): Double;
  end;

implementation

{ TNode }
{ TCalculator }

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

// подсчёт значения узла
function TCalculator.GetValue(ANode: TNode): Double;
begin
  if ANode.FIsOperation = True then
  begin
    case StrToInt(FloatToStr(ANode.FValue)) of
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
          if GetValue(ANode.FRight) <> 0 then
            Result := GetValue(ANode.FLeft) / GetValue(ANode.FRight)
          else
            ShowMessage('Error')
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
  i, vPosition, vBracketCount: Integer;
  vRight, vLeft: string;
  vValue: Double;
  vСheckbox: Boolean;
begin
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
      '÷':
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
      vСheckbox := True;
      AText := Copy(AText, 2, Length(AText) - 2);
      FCurrentNode := Parse(AText);
      Result := FCurrentNode;
    end
    else
    // создание узла с числом (листья дерева)
    begin
      vValue := StrToFloat(AText);
      FCurrentNode := TNode.Create(False, 0, vValue, nil, nil);
      Result := FCurrentNode;
      vСheckbox := False;
    end;
  end;
end;

// запуск пасинга, вычисления и вывод результата
function TCalculator.Calc(AText: string): Double;
begin
  FRootNode := Parse(AText);
  Result := GetValue(FRootNode);
  ShowMessage(FormatFloat('0.##', Result));
end;

end.
