unit Thread.Download;

interface

uses
  System.Classes;

type
  TTest = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

{ TTest }

procedure TTest.Execute;
begin
  { Place thread code here }
end;

end.
