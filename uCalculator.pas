unit uCalculator;

interface

uses
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TNode = class
  private
    FNodeID: string;
    FIsOperation: Boolean;
    FOperationPriority: Integer;
    FValue: Integer;
    FLeft: TNode;
    FRight: TNode;

  public
    constructor Create(const ANodeID: string; AIsOperation: Boolean;
      AOperationPriority: Integer; AValue: Integer; ALeft: TNode;
      ARight: TNode);
  end;

  TCalculator = class
  private
    FRootNode: TNode;
    FCurrentID: string;

    FCurrentNode: TNode;
    function AddNodeToRoot(ARootNode, ANode: TNode): TNode;
    procedure TNodeCreate(AValue: string);

  public
    function Calc(AText: string): Double;
    procedure Parse(AText: string);
  end;

implementation

{ TNode }
{ TCalculator }

constructor TNode.Create(const ANodeID: string; AIsOperation: Boolean;
  AOperationPriority: Integer; AValue: Integer; ALeft: TNode; ARight: TNode);
begin
  FNodeID := ANodeID;
  FIsOperation := AIsOperation;
  FOperationPriority := AOperationPriority;
  FValue := AValue;
  FLeft := ALeft;
  FRight := ARight;
end;

procedure TCalculator.Parse(AText: string);
var
  vCounter, vPosition: Integer;
  vSymbol, vSymbols, vExtracting_symbol, vExtracting_number: string;
begin
  vSymbols := '+-*÷=()';
  for vCounter := 1 to Length(AText) do
  begin
    vSymbol := (AText[vCounter]);
    vPosition := Pos(vSymbol, vSymbols);
    if vPosition = 0 then
    begin
      vExtracting_number := vExtracting_number + vSymbol;
    end
    else
    begin
      if vExtracting_number <> '' then
      begin
        TNodeCreate(vExtracting_number);
        vExtracting_number := '';
      end;
      vExtracting_symbol := vSymbol;
      TNodeCreate(vExtracting_symbol);
    end;
  end;
end;

//
procedure TCalculator.TNodeCreate(AValue: string);
var
  // vNodeID: string;
  vValue: Integer;
begin
  if AValue = '=' then
  begin
    FCurrentID := '';
  end
  else if AValue = '(' then
  begin
    FCurrentID := '';
  end
  else if AValue = ')' then
  begin
    FCurrentID := '';
  end
  else if AValue = '+' then
  begin
    FCurrentNode := TNode.Create('0', true, 1, 00, nil, nil);
    FRootNode := AddNodeToRoot(FRootNode, FCurrentNode);
  end
  else if AValue = '-' then
  begin
    FCurrentNode := TNode.Create('0', true, 1, 01, nil, nil);
    FRootNode := AddNodeToRoot(FRootNode, FCurrentNode);
  end
  else if AValue = '*' then
  begin
    FCurrentNode := TNode.Create('0', true, 1, 10, nil, nil);
    FRootNode := AddNodeToRoot(FRootNode, FCurrentNode);
  end
  else if AValue = '÷' then
  begin
    FCurrentNode := TNode.Create('0', true, 1, 11, nil, nil);
    FRootNode := AddNodeToRoot(FRootNode, FCurrentNode);
  end
  else
  begin
    vValue := StrToInt(AValue);
    FCurrentNode := TNode.Create('0', false, 0, vValue, nil, nil);
    FRootNode := AddNodeToRoot(FRootNode, FCurrentNode);
  end;
end;

function TCalculator.AddNodeToRoot(ARootNode, ANode: TNode): TNode;
begin



   Result := FRootNode;
end;

// ----------------------------------------------------------------------------//
function TCalculator.Calc(AText: string): Double;
begin
  Parse(AText);
  //
  Result := 0;
end;

end.
