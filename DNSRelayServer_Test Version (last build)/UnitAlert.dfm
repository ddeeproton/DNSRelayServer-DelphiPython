object FormAlert: TFormAlert
  Left = 239
  Top = 125
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
    Height = 26
    Align = alTop
    AutoSize = True
    Color = clGreen
    TabOrder = 0
    OnClick = PanelAllowedClick
    DesignSize = (
      309
      26)
    object Label1: TLabel
      Left = 6
      Top = 2
      Width = 48
      Height = 20
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = PanelAllowedClick
    end
    object ButtonAllowDomain: TSpeedButton
      Left = 227
      Top = 1
      Width = 81
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Autoriser'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = ButtonAllowDomainClick
    end
  end
  object PanelAllowed: TPanel
    Left = 0
    Top = 26
    Width = 309
    Height = 26
    Align = alTop
    AutoSize = True
    Color = clMaroon
    TabOrder = 1
    OnClick = PanelAllowedClick
    DesignSize = (
      309
      26)
    object Label2: TLabel
      Left = 6
      Top = 4
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
    object ButtonDisallow: TSpeedButton
      Left = 227
      Top = 1
      Width = 81
      Height = 24
      Anchors = [akTop, akRight]
      Caption = 'Bloquer'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = ButtonDisallowClick
    end
  end
  object TimerAfterCreate: TTimer
    Interval = 20000
    OnTimer = PanelAllowedClick
    Left = 16
    Top = 56
  end
end
