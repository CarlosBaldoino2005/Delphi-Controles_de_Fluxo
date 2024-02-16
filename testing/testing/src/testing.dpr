program testing;

uses
  Vcl.Forms,
  View.Main in 'views\View.Main.pas' {Form1},
  Thread.Download in 'threads\Thread.Download.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
