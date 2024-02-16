unit Service.CEPImporter;

interface

uses
  Model.CEP,
  System.Generics.Collections;

type

  TFinishImportingEvent = reference to procedure(ASender: TObject; ACEPList: TObjectList<TCEPModel>);
  TImportProgressEvent = reference to procedure(ASender: TObject; ACount: Integer; AIndex: Integer; ACEPModel: TCEPModel);

  TCEPImporter = class
  private
    { private declarations }
    FOnFinishImporting: TFinishImportingEvent;
    FOnImportProgress: TImportProgressEvent;
    procedure SetOnFinishImporting(const Value: TFinishImportingEvent);
    procedure SetOnImportProgress(const Value: TImportProgressEvent);
  protected
    { protected declarations }
    procedure DoFinishImporting(ACEPList: TObjectList<TCEPModel>);
    procedure DoImportProgress(ACount: Integer; AIndex: Integer; ACEPModel: TCEPModel);
  public
    { public declarations }
    procedure ImportFromCSV(AFilename: string);
    property OnImportProgress: TImportProgressEvent read FOnImportProgress write SetOnImportProgress;
    property OnFinishImporting: TFinishImportingEvent read FOnFinishImporting write SetOnFinishImporting;
  end;

implementation

uses
  System.SysUtils,
  System.Classes;

{ TCEPImporter }

procedure TCEPImporter.DoFinishImporting(ACEPList: TObjectList<TCEPModel>);
begin
  if Assigned(FOnFinishImporting) then
    FOnFinishImporting(Self, ACEPList)
end;

procedure TCEPImporter.DoImportProgress(ACount, AIndex: Integer; ACEPModel: TCEPModel);
begin
  if Assigned(FOnImportProgress) then
    FOnImportProgress(Self, ACount, AIndex, ACEPModel);
end;

procedure TCEPImporter.ImportFromCSV(AFilename: string);
var
  LStringList: TStringList;
  I: Integer;
  LCEPModel: TCEPModel;
  LCEPList: TObjectList<TCEPModel>;
  LSplitedRow: TArray<string>;
begin
  LCEPList := TObjectList<TCEPModel>.Create;
  try
    LStringList := TStringList.Create;
    try
      LStringList.LoadFromFile(AFilename);
      for I := 0 to Pred(LStringList.Count) do
      begin
        LSplitedRow := LStringList.Strings[I].Split([';']);
        LCEPModel := TCEPModel.Create;
        LCEPList.Add(LCEPModel);
        LCEPModel.UF := LSplitedRow[0];
        LCEPModel.Cidade := LSplitedRow[1];
        LCEPModel.Bairro := LSplitedRow[2];
        LCEPModel.CEP := LSplitedRow[3];
        DoImportProgress(LStringList.Count, I, LCEPModel);
      end;
      DoFinishImporting(LCEPList);
    finally
      LStringList.Free;
    end;
  finally
    LCEPList.Free;
  end;
end;

procedure TCEPImporter.SetOnFinishImporting(const Value: TFinishImportingEvent);
begin
  FOnFinishImporting := Value;
end;

procedure TCEPImporter.SetOnImportProgress(const Value: TImportProgressEvent);
begin
  FOnImportProgress := Value;
end;

end.
