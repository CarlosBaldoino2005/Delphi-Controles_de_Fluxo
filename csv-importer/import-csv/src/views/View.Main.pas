unit View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Model.CEP,
  Service.CEPImporter, Vcl.ComCtrls;

type
  TMainView = class(TForm)
    EditFilename: TEdit;
    ButtonSelectFile: TButton;
    ButtonImportWithThread: TButton;
    Memo1: TMemo;
    ProgressBarImportProgress: TProgressBar;
    ButtonImportWithoutThread: TButton;
    procedure ButtonSelectFileClick(Sender: TObject);
    procedure EditFilenameChange(Sender: TObject);
    procedure ButtonImportWithThreadClick(Sender: TObject);
    procedure ButtonImportWithoutThreadClick(Sender: TObject);
  private
    { Private declarations }
    procedure DoOnImportProgress(ASender: TObject; ACount: Integer; AIndex: Integer; ACEPModel: TCEPModel);
    procedure DoFinishImporting(ASender: TObject; ACEPList: TObjectList<TCEPModel>);
    procedure SelectFile;
    procedure ImportCSV(AFilename: string; ARunningOnThread: Boolean);
  public
    { Public declarations }
  end;

var
  MainView: TMainView;

implementation

uses
  Thread.CEPImporter;

{$R *.dfm}


procedure TMainView.ButtonImportWithoutThreadClick(Sender: TObject);
begin
  ImportCSV(EditFilename.Text, False);
end;

procedure TMainView.ButtonImportWithThreadClick(Sender: TObject);
begin
  ImportCSV(EditFilename.Text, True);
end;

procedure TMainView.ButtonSelectFileClick(Sender: TObject);
begin
  SelectFile;
end;

procedure TMainView.DoFinishImporting(ASender: TObject; ACEPList: TObjectList<TCEPModel>);
begin
end;

procedure TMainView.DoOnImportProgress(ASender: TObject; ACount, AIndex: Integer; ACEPModel: TCEPModel);
begin
  if (Pred(AIndex) = ACount) or (Pred(AIndex) mod (ACount div 10) = 0) then
  begin
    TThread.Queue(nil,
      procedure
      begin
        ProgressBarImportProgress.Max := ACount;
        ProgressBarImportProgress.Position := AIndex + 1;
      end);
  end;
end;

procedure TMainView.EditFilenameChange(Sender: TObject);
begin
  ButtonImportWithThread.Enabled := EditFilename.Text <> '';
  ButtonImportWithoutThread.Enabled := EditFilename.Text <> '';
end;

procedure TMainView.ImportCSV(AFilename: string; ARunningOnThread: Boolean);
var
  LThreadCEPImporter: TThreadCEPImporter;
  LCEPImporter: TCEPImporter;
begin
  if not ARunningOnThread then
  begin
    LCEPImporter := TCEPImporter.Create;
    try
      LCEPImporter.OnFinishImporting := DoFinishImporting;
      LCEPImporter.OnImportProgress := DoOnImportProgress;
      LCEPImporter.ImportFromCSV(AFilename);
    finally
      LCEPImporter.Free;
    end;
  end
  else
  begin
    LThreadCEPImporter := TThreadCEPImporter.Create(True);
    LThreadCEPImporter.OnFinishImporting := DoFinishImporting;
    LThreadCEPImporter.OnImportProgress := DoOnImportProgress;
    LThreadCEPImporter.Filename := AFilename;
    LThreadCEPImporter.Start;
  end;
end;

procedure TMainView.SelectFile;
var
  LOpenDialog: TOpenDialog;
begin
  LOpenDialog := TOpenDialog.Create(nil);
  try
    if LOpenDialog.Execute() then
    begin
      EditFilename.Text := LOpenDialog.Filename;
    end;
  finally
    LOpenDialog.Free;
  end;
end;

end.
