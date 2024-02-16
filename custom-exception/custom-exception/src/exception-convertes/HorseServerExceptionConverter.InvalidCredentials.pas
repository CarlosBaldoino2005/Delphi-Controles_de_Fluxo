unit HorseServerExceptionConverter.InvalidCredentials;

interface

uses
  Contract.HorseServerExceptionConverter,
  System.SysUtils;

type

  TInvalidCredentialsHorseServerExceptionConverter = class(TInterfacedObject, IHorseServerExceptionConverter)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    function CanConvert(AException: Exception): Boolean;
    function GetMessage(AException: Exception): string;
    function GetErrorType(AException: Exception): string;
    function GetHint(AException: Exception): string;
    function GetStatusCode(AException: Exception): Integer;
    class function New: IHorseServerExceptionConverter;
  end;

implementation

uses
  Middleware.HorseServerExceptions,
  InvalidCredentials;

{ TInvalidCredentialsHorseServerExceptionConverter }

function TInvalidCredentialsHorseServerExceptionConverter.CanConvert(AException: Exception): Boolean;
begin
  Result := AException is EInvalidCredentials;
end;

function TInvalidCredentialsHorseServerExceptionConverter.GetErrorType(AException: Exception): string;
begin
  Result := 'invalid_credentials'
end;

function TInvalidCredentialsHorseServerExceptionConverter.GetHint(AException: Exception): string;
begin
  Result := '';
end;

function TInvalidCredentialsHorseServerExceptionConverter.GetMessage(AException: Exception): string;
begin
  Result := AException.Message;
end;

function TInvalidCredentialsHorseServerExceptionConverter.GetStatusCode(AException: Exception): Integer;
begin
  Result := 401;
end;

class function TInvalidCredentialsHorseServerExceptionConverter.New: IHorseServerExceptionConverter;
begin
  Result := TInvalidCredentialsHorseServerExceptionConverter.Create;
end;

initialization
  THorseServerExceptions.RegisterConveter(
    TInvalidCredentialsHorseServerExceptionConverter.New
  )
end.
