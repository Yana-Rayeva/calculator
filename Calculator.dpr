program Calculator;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {MainFm},
  uCalculator in 'uCalculator.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFm, MainFm);
  Application.Run;
end.
