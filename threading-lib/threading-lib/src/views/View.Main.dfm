object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Threading lib'
  ClientHeight = 441
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 57
    Caption = 'Parallel for'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 71
    Width = 553
    Height = 362
    TabOrder = 1
  end
  object Button2: TButton
    Left = 191
    Top = 8
    Width = 177
    Height = 57
    Caption = 'IFuture'
    TabOrder = 2
    OnClick = Button2Click
  end
end
