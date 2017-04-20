object FormAlert: TFormAlert
  Left = 933
  Top = 599
  BorderStyle = bsNone
  Caption = 'FormAlert'
  ClientHeight = 84
  ClientWidth = 309
  Color = clWhite
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
  object PanelDisallowed: TPanel
    Left = 0
    Top = 0
    Width = 309
    Height = 27
    Align = alTop
    AutoSize = True
    Color = clMaroon
    TabOrder = 0
    OnClick = PanelAllowedClick
    DesignSize = (
      309
      27)
    object Label1: TLabel
      Left = 6
      Top = 3
      Width = 51
      Height = 18
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = PanelAllowedClick
    end
    object ButtonAllowDomain: TButton
      Left = 232
      Top = 1
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Autoriser'
      TabOrder = 0
      OnClick = ButtonAllowDomainClick
    end
  end
  object PanelAllowed: TPanel
    Left = 0
    Top = 27
    Width = 309
    Height = 27
    Align = alTop
    AutoSize = True
    Color = clGreen
    TabOrder = 1
    OnClick = PanelAllowedClick
    DesignSize = (
      309
      27)
    object Label2: TLabel
      Left = 6
      Top = 3
      Width = 48
      Height = 20
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = PanelAllowedClick
    end
    object ButtonDisallow: TButton
      Left = 232
      Top = 1
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Bloquer'
      TabOrder = 0
      OnClick = ButtonDisallowClick
    end
  end
  object TimerAfterCreate: TTimer
    Interval = 5000
    OnTimer = PanelAllowedClick
    Left = 16
    Top = 56
  end
end
