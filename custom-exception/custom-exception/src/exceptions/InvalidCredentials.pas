unit InvalidCredentials;

interface

uses
  System.SysUtils;

type

  EInvalidCredentials = class(Exception)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create; reintroduce;
  end;

implementation

{ EInvalidCredentials }

constructor EInvalidCredentials.Create;
begin
  Self.Message := 'The user credentials were incorrect';
end;

end.
