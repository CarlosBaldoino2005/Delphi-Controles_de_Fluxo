program threading_lib;

uses
  Vcl.Forms,
  View.Main in 'src\views\View.Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
