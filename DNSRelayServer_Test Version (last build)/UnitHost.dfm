object FormHost: TFormHost
  Left = 433
  Top = 158
  Width = 454
  Height = 381
  Caption = 'FormHost'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    446
    347)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 449
    Height = 305
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssBoth
    TabOrder = 0
    WantTabs = True
    WordWrap = False
  end
  object ButtonSave: TButton
    Left = 267
    Top = 311
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Save'
    TabOrder = 1
    OnClick = ButtonSaveClick
  end
  object ButtonCancel: TButton
    Left = 355
    Top = 311
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = ButtonCancelClick
  end
end
