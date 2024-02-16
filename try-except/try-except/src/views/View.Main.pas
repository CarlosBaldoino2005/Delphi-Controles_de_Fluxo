unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type

  TMyClass = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function DivValues(AValue1, AValue2: Integer): Integer;
  end;

  TMainView = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

{$R *.dfm}

{ TMyClass }

function TMyClass.DivValues(AValue1, AValue2: Integer): Integer;
begin
  Result := AValue1 div AValue2;
end;

procedure TMainView.Button1Click(Sender: TObject);
var
  LMyClass: TMyClass;
begin
  LMyClass := TMyClass.Create;
  try
    LMyClass.DivValues(10, 0);
    {
      code
    }
  finally
    LMyClass.Free;
  end;

end;

end.
