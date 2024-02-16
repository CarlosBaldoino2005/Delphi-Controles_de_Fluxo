unit Middleware.HorseServerExceptions;

interface

uses
  Horse,
  System.Generics.Collections,
  Contract.HorseServerExceptionConverter;

type

  THorseServerExceptions = class
  private
    { private declarations }
    class var FConverterList: TList<IHorseServerExceptionConverter>;
  protected
    { protected declarations }
    class function GetConverterList: TList<IHorseServerExceptionConverter>;
  public
    { public declarations }
    class destructor UnInitialize;
    class procedure RegisterConveter(AHorseServerExceptionConverter: IHorseServerExceptionConverter);
    class procedure Invoke(AReq: THorseRequest; ARes: THorseResponse; ANext: TNextProc);
  end;

implementation

uses
  System.SysUtils,
  System.JSON,
  InvalidCredentials;

{ THorseServerExceptions }

class function THorseServerExceptions.GetConverterList: TList<IHorseServerExceptionConverter>;
begin
  if FConverterList = nil then
    FConverterList := TList<IHorseServerExceptionConverter>.Create;
  Result := FConverterList;
end;

class procedure THorseServerExceptions.Invoke(AReq: THorseRequest; ARes: THorseResponse; ANext: TNextProc);
var
  LStatusCode: Integer;
  I: Integer;
  LJSONResponse: TJSONObject;
  LHint: string;
begin
  try
    ANext;
  except
    on E: Exception do
    begin
      LStatusCode := 500;
      LJSONResponse := nil;

      for I := 0 to Pred(GetConverterList.Count) do
      begin
        if GetConverterList.Items[I].CanConvert(E) then
        begin
          LJSONResponse := TJSONObject.Create;
          LJSONResponse.AddPair('error', GetConverterList.Items[I].GetErrorType(E));
          LJSONResponse.AddPair('error_description', GetConverterList.Items[I].GetMessage(E));
          LHint := GetConverterList.Items[I].GetHint(E);
          if not LHint.IsEmpty then
            LJSONResponse.AddPair('hint', LHint);
          LStatusCode := GetConverterList.Items[I].GetStatusCode(E);
          Break;
        end;
      end;

      if LJSONResponse = nil then
      begin
        LJSONResponse := TJSONObject.Create;
        LJSONResponse.AddPair('error', 'unknow_error');
        LJSONResponse.AddPair('error_description', E.Message);
      end;

      ARes.Send<TJSONObject>(LJSONResponse).Status(LStatusCode);
    end;
  end;

end;

class procedure THorseServerExceptions.RegisterConveter(AHorseServerExceptionConverter: IHorseServerExceptionConverter);
begin
  GetConverterList.Add(AHorseServerExceptionConverter);
end;

class destructor THorseServerExceptions.UnInitialize;
begin
  if FConverterList <> nil then
    FreeAndNil(FConverterList);
end;

end.
