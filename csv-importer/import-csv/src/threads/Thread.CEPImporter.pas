unit Thread.CEPImporter;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Service.CEPImporter,
  Model.CEP;

type

  TThreadCEPImporter = class(TThread)
  private
    FFilename: string;
    FOnImportProgress: TImportProgressEvent;
    FOnFinishImporting: TFinishImportingEvent;
    { Private declarations }
  protected
    procedure SetFilename(const Value: string);
    procedure SetOnFinishImporting(const Value: TFinishImportingEvent);
    procedure SetOnImportProgress(const Value: TImportProgressEvent);
    procedure DoOnImportProgress(ASender: TObject; ACount: Integer; AIndex: Integer; ACEPModel: TCEPModel);
    procedure DoFinishImporting(ASender: TObject; ACEPList: TObjectList<TCEPModel>);
    procedure Execute; override;
  public
    property Filename: string read FFilename write SetFilename;
    property OnImportProgress: TImportProgressEvent read FOnImportProgress write SetOnImportProgress;
    property OnFinishImporting: TFinishImportingEvent read FOnFinishImporting write SetOnFinishImporting;
  end;

implementation

{ TThreadCEPImporter }

procedure TThreadCEPImporter.DoFinishImporting(ASender: TObject; ACEPList: TObjectList<TCEPModel>);
begin
  if Assigned(FOnFinishImporting) then
    FOnFinishImporting(Self, ACEPList);
end;

procedure TThreadCEPImporter.DoOnImportProgress(ASender: TObject; ACount, AIndex: Integer; ACEPModel: TCEPModel);
begin
  if Assigned(FOnImportProgress) then
    FOnImportProgress(Self, ACount, AIndex, ACEPModel);
end;

procedure TThreadCEPImporter.Execute;
var
  LCEPImporter: TCEPImporter;
begin
  LCEPImporter := TCEPImporter.Create;
  try
    LCEPImporter.OnFinishImporting := DoFinishImporting;
    LCEPImporter.OnImportProgress := DoOnImportProgress;
    LCEPImporter.ImportFromCSV(FFilename);
  finally
    LCEPImporter.Free;
  end;
end;

procedure TThreadCEPImporter.SetFilename(const Value: string);
begin
  FFilename := Value;
end;

procedure TThreadCEPImporter.SetOnFinishImporting(const Value: TFinishImportingEvent);
begin
  FOnFinishImporting := Value;
end;

procedure TThreadCEPImporter.SetOnImportProgress(const Value: TImportProgressEvent);
begin
  FOnImportProgress := Value;
end;

end.
