object MainView: TMainView
  Left = 0
  Top = 0
  Caption = 'Import CSV'
  ClientHeight = 358
  ClientWidth = 465
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EditFilename: TEdit
    Left = 8
    Top = 14
    Width = 368
    Height = 21
    ReadOnly = True
    TabOrder = 0
    OnChange = EditFilenameChange
  end
  object ButtonSelectFile: TButton
    Left = 382
    Top = 11
    Width = 75
    Height = 27
    Caption = 'Select file'
    TabOrder = 1
    OnClick = ButtonSelectFileClick
  end
  object ButtonImportWithThread: TButton
    Left = 8
    Top = 40
    Width = 129
    Height = 27
    Caption = 'Import with thread'
    Enabled = False
    TabOrder = 2
    OnClick = ButtonImportWithThreadClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 104
    Width = 449
    Height = 246
    TabOrder = 3
  end
  object ProgressBarImportProgress: TProgressBar
    Left = 8
    Top = 73
    Width = 449
    Height = 25
    TabOrder = 4
  end
  object ButtonImportWithoutThread: TButton
    Left = 143
    Top = 40
    Width = 129
    Height = 27
    Caption = 'Import without thread'
    Enabled = False
    TabOrder = 5
    OnClick = ButtonImportWithoutThreadClick
  end
end
