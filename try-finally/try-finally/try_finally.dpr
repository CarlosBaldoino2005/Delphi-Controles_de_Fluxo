program try_finally;

uses
  Vcl.Forms,
  View.Main in 'src\views\View.Main.pas' {MainView};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
