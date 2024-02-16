program logger;

uses
  Vcl.Forms,
  View.Main in 'src\views\View.Main.pas' {MainView},
  Provider.Logger in 'src\providers\Provider.Logger.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
