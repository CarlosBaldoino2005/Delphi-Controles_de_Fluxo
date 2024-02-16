unit Controller.Auth;

interface

uses
  Horse;

type

  TAuthController = class
  private
    { private declarations }
  protected
    { protected declarations }
    class procedure Login(AReq: THorseRequest; ARes: THorseResponse; ANext: TNextProc);
  public
    { public declarations }
    class procedure Register;
  end;

implementation

uses
  InvalidCredentials,
  InvalidRequest,
  System.SysUtils;

{ TAuthController }

class procedure TAuthController.Login(AReq: THorseRequest; ARes: THorseResponse; ANext: TNextProc);
var
  LUsername: string;
  LPassword: string;
begin
  if not AReq.ContentFields.ContainsKey('username') then
    raise EInvalidRequest.Create('username');
  if not AReq.ContentFields.ContainsKey('password') then
    raise EInvalidRequest.Create('password');

  LUsername := AReq.ContentFields['username'];
  LPassword := AReq.ContentFields['password'];

  if not((LUsername.Equals('carlos')) and (LPassword.Equals('123'))) then
    raise EInvalidCredentials.Create;

end;

class procedure TAuthController.Register;
begin
  THorse
    .Group
    .Prefix('auth')
    .Post('login', Login);
end;

end.
