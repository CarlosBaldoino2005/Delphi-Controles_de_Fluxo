unit Model.CEP;

interface

type

  TCEPModel = class
  private
    FBairro: string;
    FUF: string;
    FCEP: string;
    FCidade: string;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetUF(const Value: string);
    { private declarations }
  protected
    { protected declarations }
  public
    { public declarations }
    property UF: string read FUF write SetUF;
    property Cidade: string read FCidade write SetCidade;
    property Bairro: string read FBairro write SetBairro;
    property CEP: string read FCEP write SetCEP;
  end;

implementation

{ TCEPModel }

procedure TCEPModel.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TCEPModel.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TCEPModel.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TCEPModel.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
