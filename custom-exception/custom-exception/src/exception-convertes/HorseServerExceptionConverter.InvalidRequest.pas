unit HorseServerExceptionConverter.InvalidRequest;

interface

uses
  Contract.HorseServerExceptionConverter,
  System.SysUtils;

type

  TInvalidRequestHorseServerExceptionConverter = class(TInterfacedObject, IHorseServerExceptionConverter)
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
  InvalidRequest;

{ TInvalidRequestHorseServerExceptionConverter }

function TInvalidRequestHorseServerExceptionConverter.CanConvert(AException: Exception): Boolean;
begin
  Result := AException is EInvalidRequest;
end;

function TInvalidRequestHorseServerExceptionConverter.GetErrorType(AException: Exception): string;
begin
  Result := 'invalid_request'
end;

function TInvalidRequestHorseServerExceptionConverter.GetHint(AException: Exception): string;
begin
  Result := EInvalidRequest(AException).Hint;
  if Result.IsEmpty then
    Result := Format('Check the ''%s'' parameter', [EInvalidRequest(AException).Parameter]);
end;

function TInvalidRequestHorseServerExceptionConverter.GetMessage(AException: Exception): string;
begin
  Result := AException.Message;
end;

function TInvalidRequestHorseServerExceptionConverter.GetStatusCode(AException: Exception): Integer;
begin
  Result := 400;
end;

class function TInvalidRequestHorseServerExceptionConverter.New: IHorseServerExceptionConverter;
begin
  Result := TInvalidRequestHorseServerExceptionConverter.Create;
end;

initialization
  THorseServerExceptions.RegisterConveter(
    TInvalidRequestHorseServerExceptionConverter.New
  )
end.
