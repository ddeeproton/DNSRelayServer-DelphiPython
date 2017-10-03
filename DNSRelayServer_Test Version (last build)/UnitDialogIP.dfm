object FormDialogIP: TFormDialogIP
  Left = 1066
  Top = 324
  BorderStyle = bsDialog
  Caption = 'Adresse IP'
  ClientHeight = 77
  ClientWidth = 153
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 9
    Top = 1
    Width = 113
    Height = 13
    Caption = 'N'#39'est pas entre 1 et 255'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Visible = False
  end
  object Edit4: TEdit
    Left = 10
    Top = 15
    Width = 132
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 4
    Text = '          .          .         .'
  end
  object Memo4: TMemo
    Left = 110
    Top = 19
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
    Top = 19
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
    Top = 19
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
    Top = 19
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
    Top = 43
    Width = 62
    Height = 25
    Caption = 'OK'
    Enabled = False
    TabOrder = 5
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 80
    Top = 43
    Width = 62
    Height = 25
    Caption = 'Annuler'
    TabOrder = 6
    OnClick = ButtonCancelClick
  end
end
