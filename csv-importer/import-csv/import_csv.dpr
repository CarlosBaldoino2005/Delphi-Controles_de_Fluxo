program import_csv;

uses
  Vcl.Forms,
  View.Main in 'src\views\View.Main.pas' {MainView},
  Service.CEPImporter in 'src\services\Service.CEPImporter.pas',
  Model.CEP in 'src\models\Model.CEP.pas',
  Thread.CEPImporter in 'src\threads\Thread.CEPImporter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
