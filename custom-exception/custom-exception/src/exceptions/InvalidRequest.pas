unit InvalidRequest;

interface

uses
  System.SysUtils;

type

  EInvalidRequest = class(Exception)
  private
    { private declarations }
    FParameter: string;
    FHint: string;
  protected
    { protected declarations }
    procedure SetHint(const Value: string);
    procedure SetParameter(const Value: string);
  public
    { public declarations }
    property Parameter: string read FParameter write SetParameter;
    property Hint: string read FHint write SetHint;
    constructor Create(AParameter: string; const AHint: string = ''); reintroduce;
  end;

implementation

{ EInvalidRequest }

constructor EInvalidRequest.Create(AParameter: string; const AHint: string = '');
begin
  FParameter := AParameter;
  FHint := AHint;
  Self.Message := 'The request is missing a required parameter,' +
    ' includes an invalid parameter value,' +
    ' includes a parameter more than once,' +
    ' or is otherwise malformed';
end;

procedure EInvalidRequest.SetHint(const Value: string);
begin
  FHint := Value;
end;

procedure EInvalidRequest.SetParameter(const Value: string);
begin
  FParameter := Value;
end;

end.
