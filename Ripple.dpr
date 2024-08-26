program Ripple;





{$R *.dres}

uses
  Forms,
  API.RippleEffects in 'API\Ripple\API.RippleEffects.pas',
  API.RippleHeader in 'API\Ripple\API.RippleHeader.pas',
  Main.View in 'Main.View.pas' {MainView};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
