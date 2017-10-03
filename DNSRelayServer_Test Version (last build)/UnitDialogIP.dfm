object FormDialogIP: TFormDialogIP
  Left = 1036
  Top = 332
  BorderStyle = bsDialog
  Caption = 'FormDialogIP'
  ClientHeight = 91
  ClientWidth = 153
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 13
    Caption = 'Adresse IP :'
  end
  object Edit4: TEdit
    Left = 10
    Top = 24
    Width = 132
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 4
    Text = '          .          .         .'
  end
  object Memo4: TMemo
    Left = 110
    Top = 28
    Width = 28
    Height = 14
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Lines.Strings = (
      '000')
    MaxLength = 3
    TabOrder = 3
    WantReturns = False
    WordWrap = False
    OnKeyPress = MemoKeyPress
    OnKeyUp = MemoKeyUp
  end
  object Memo3: TMemo
    Left = 79
    Top = 28
    Width = 28
    Height = 14
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Lines.Strings = (
      '000')
    MaxLength = 3
    TabOrder = 2
    WantReturns = False
    WordWrap = False
    OnKeyPress = MemoKeyPress
    OnKeyUp = MemoKeyUp
  end
  object Memo2: TMemo
    Left = 47
    Top = 28
    Width = 28
    Height = 14
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Lines.Strings = (
      '000')
    MaxLength = 3
    TabOrder = 1
    WantReturns = False
    WordWrap = False
    OnKeyPress = MemoKeyPress
    OnKeyUp = MemoKeyUp
  end
  object Memo1: TMemo
    Left = 14
    Top = 28
    Width = 28
    Height = 14
    Alignment = taCenter
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Lines.Strings = (
      '000')
    MaxLength = 3
    TabOrder = 0
    WantReturns = False
    WordWrap = False
    OnKeyPress = MemoKeyPress
    OnKeyUp = MemoKeyUp
  end
  object ButtonOK: TButton
    Left = 8
    Top = 56
    Width = 62
    Height = 25
    Caption = 'OK'
    TabOrder = 5
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 80
    Top = 56
    Width = 62
    Height = 25
    Caption = 'Annuler'
    TabOrder = 6
    OnClick = ButtonCancelClick
  end
end
