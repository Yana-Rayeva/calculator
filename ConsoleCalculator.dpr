program ConsoleCalculator;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  uCalculator in 'uCalculator.pas';

var
  Text: string;
  i: integer;
  FCalc: TCalculator;

begin
  try
    FCalc := TCalculator.Create;
    try
      while True do
      begin
        WriteLn('¬ведите математическое выражение');
        Read(Text);
        FCalc.AddText(Text);
        WriteLn(FCalc.Calc);
        WriteLn('');
        Readln;
        Text := '';
        FCalc.DeleteText;
      end;
    finally
      FCalc.Free;
    end;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
