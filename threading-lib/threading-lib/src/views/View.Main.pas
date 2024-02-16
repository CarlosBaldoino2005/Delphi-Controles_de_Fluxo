unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    function GetStringOoba: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Threading;

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
begin
  TParallel.&For(0, 99,
    procedure(AIndex: Int64)
    begin
      TThread.Queue(nil,
        procedure
        begin
          Memo1.Lines.Add(AIndex.ToString);
        end);
    end)
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LFuture: IFuture<string>;
  LStringOoba: string;
begin

   LFuture := TTask.Future<string>(
   function: string
   begin
    Result := GetStringOoba;
   end).Start;

  Sleep(5000);
  LStringOoba := LFuture.Value;


  Memo1.Lines.Add(LStringOoba);

end;

function TForm1.GetStringOoba: string;
begin
  Sleep(5000);
  Result := 'Ooba!';
end;

end.
