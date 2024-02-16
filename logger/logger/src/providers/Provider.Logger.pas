unit Provider.Logger;

interface

uses
  System.Generics.Collections,
  System.SyncObjs,
  System.Classes;

type

  TLogger = class(TThread)
  private
    { Private declarations }
    FCriticalSection: TCriticalSection;
    FEvent: TEvent;
    FLogCacheList: TList<string>;
    class var FLogger: TLogger;
  protected
    procedure Execute; override;
    function ExtractLog: TArray<string>;
    procedure SaveLogCacheToFile;
    class function GetDefaultLogger: TLogger; static;
  public
    procedure AddLog(ALog: string);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    class property GetDefault: TLogger read GetDefaultLogger;
  end;

implementation

uses
  System.SysUtils;

{ TLogger }

procedure TLogger.AddLog(ALog: string);
begin
  FCriticalSection.Enter;
  try
    FLogCacheList.Add(ALog);
  finally
    FCriticalSection.Leave;
  end;
  FEvent.SetEvent;
end;

procedure TLogger.AfterConstruction;
begin
  inherited;
  FLogCacheList := TList<string>.Create;
  FCriticalSection := TCriticalSection.Create;
  FEvent := TEvent.Create;
end;

procedure TLogger.BeforeDestruction;
begin
  inherited;
  FLogCacheList.Free;
  FCriticalSection.Free;
  FEvent.Free;
end;

procedure TLogger.Execute;
var
  LWaitResult: TWaitResult;
begin
  { Place thread code here }
  while not Self.Terminated do
  begin
    LWaitResult := FEvent.WaitFor(INFINITE);
    FEvent.ResetEvent;
    if LWaitResult = wrSignaled then
      SaveLogCacheToFile;
  end;
end;

function TLogger.ExtractLog: TArray<string>;
begin
  FCriticalSection.Enter;
  try
    Result := FLogCacheList.ToArray;
  finally
    FCriticalSection.Leave;
  end;
  FLogCacheList.Clear;
end;

class function TLogger.GetDefaultLogger: TLogger;
begin
  if FLogger = nil then
  begin
    FLogger := TLogger.Create;
    FLogger.Priority := TThreadPriority.tpLowest;
  end;
  Result := FLogger;
end;

procedure TLogger.SaveLogCacheToFile;
var
  LFilename: string;
  LTextFile: TextFile;
  LLogCache: TArray<string>;
  I: Integer;
begin
  LLogCache := ExtractLog;
  if Length(LLogCache) > 0 then
  begin
    LFilename := 'access_' + FormatDateTime('yyyy-mm-dd', Now()) + '.log';
    AssignFile(LTextFile, LFilename);

    if FileExists(LFilename) then
      Append(LTextFile)
    else
      Rewrite(LTextFile);
    try
      for I := Low(LLogCache) to High(LLogCache) do
        Writeln(LTextFile, LLogCache[I]);
    finally
      CloseFile(LTextFile);
    end;
  end;
end;

end.
