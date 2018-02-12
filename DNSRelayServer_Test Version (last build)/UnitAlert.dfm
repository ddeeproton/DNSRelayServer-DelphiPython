object FormAlert: TFormAlert
  Left = 187
  Top = 622
  BorderStyle = bsNone
  Caption = 'FormAlert'
  ClientHeight = 82
  ClientWidth = 242
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clWindow
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
    Width = 242
    Height = 23
    Align = alTop
    AutoSize = True
    Color = clGreen
    TabOrder = 0
    DesignSize = (
      242
      23)
    object Label1: TLabel
      Left = 22
      Top = 1
      Width = 48
      Height = 20
      Caption = 'Label1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = Label2Click
    end
    object ButtonMenuForDisallowed: TSpeedButton
      Left = 169
      Top = 1
      Width = 25
      Height = 21
      Hint = 'Menu'
      Anchors = [akTop, akRight]
      Caption = '+'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = ButtonMenuForDisallowedClick
    end
    object Image1: TImage
      Left = 0
      Top = 1
      Width = 23
      Height = 21
      Center = True
      Picture.Data = {
        07544269746D6170AA030000424DAA0300000000000036000000280000001100
        0000110000000100180000000000740300000000000000000000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF9F9DCF2625BA0000B50000B13130B29290BEFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF6261CE0000C70000CC0000CC0000
        C70000BE0000B14A49AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFBFBDDE0000D10000DC0000E30000E30000DE0000D10000C20000B19290
        BEFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF5453DF0000E30000F2
        0000F50000F50000F20000E40000D10000BE3130B2FFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFF2F2FE40000F00000F90202FF0202FF0000F90000F2
        0000DE0000C70000B1FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF3C
        3CEA0000F50101FF5454FF5859FF0202FF0000F50000E30000CC0000B5FFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF9B9AEF0000F50101FF5151FF54
        54FF0202FF0000F50000E30000CC3534BDFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFF0EFE53232F40000F90101FF0101FF0000F90000F20000DC00
        00C7C1C0D7FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFEEED
        F03D3DF40000F50000F50000F00000E30404D29E9DDBFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0EEE2C4C3EE5656EE4D4D
        EA8685E1E4E2E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
      Transparent = True
    end
    object SpeedButtonClosePanelUpdateTheme: TSpeedButton
      Left = 218
      Top = 1
      Width = 22
      Height = 21
      Hint = 'Fermer'
      Anchors = [akTop, akRight]
      Flat = True
      Glyph.Data = {
        E6010000424DE60100000000000036000000280000000C0000000C0000000100
        180000000000B001000000000000000000000000000000000000818181A3A3A3
        9E9E9E9898989696969191918B8B8B8686868181817C7C7C797979575757A8A8
        A88181815252523C3C3C3A3A3A3A3A3A3535353535352F2F2F3C3C3C5F5F5F79
        7979AEAEAE5C5C5C575757FFFFFE8181813C3C3C3A3A3A7E7E7EFFFFFE4A4A4A
        3737377C7C7CB3B3B3616161FFFFFEFFFFFEFFFFFE838383818181FFFFFEFFFF
        FEFFFFFE2F2F2F818181B5B5B56767678B8B8BFFFFFEFFFFFEFFFFFEFFFFFEFF
        FFFEFFFFFE7E7E7E323232868686BDBDBD6C6C6C4F4F4F8E8E8EFFFFFEFFFFFE
        FFFFFEFFFFFE8181813A3A3A353535919191D0D0D07979795F5F5F989898FFFF
        FEFFFFFEFFFFFEFFFFFE8989894A4A4A444444A6A6A6DDDDDD9B9B9BB8B8B8FF
        FFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEA8A8A86C6C6CB8B8B8DFDFDFA0A0A0
        FFFFFEFFFFFEFFFFFEB3B3B3B0B0B0FFFFFEFFFFFEFFFFFE6C6C6CBBBBBBE2E2
        E2A0A0A09B9B9BFFFFFEB8B8B87E7E7E797979AEAEAEFFFFFE838383767676BD
        BDBDDFDFDFBBBBBB9393939191918E8E8E8989898686868181817E7E7E797979
        989898B8B8B8AEAEAED5D5D5D2D2D2D0D0D0CACACAC5C5C5C3C3C3C0C0C0BBBB
        BBB8B8B8B3B3B3898989}
      ParentShowHint = False
      ShowHint = True
      OnClick = PanelAllowedClick
      OnDblClick = SpeedButton1DblClick
    end
    object CheckBoxStay: TCheckBox
      Left = 198
      Top = 1
      Width = 21
      Height = 21
      Hint = 'Ne pas dispara'#238'tre'
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = CheckBoxStayClick
    end
  end
  object PanelAllowed: TPanel
    Left = 0
    Top = 23
    Width = 242
    Height = 23
    Align = alTop
    AutoSize = True
    Color = clMaroon
    TabOrder = 1
    DesignSize = (
      242
      23)
    object Label2: TLabel
      Left = 22
      Top = 1
      Width = 48
      Height = 20
      Caption = 'Label2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = Label2Click
    end
    object ButtonMenuForAllowed: TSpeedButton
      Left = 169
      Top = 1
      Width = 25
      Height = 21
      Hint = 'Menu'
      Anchors = [akTop, akRight]
      Caption = '+'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = ButtonMenuForAllowedClick
    end
    object Image2: TImage
      Left = 0
      Top = 1
      Width = 23
      Height = 21
      Center = True
      Picture.Data = {
        07544269746D6170AA030000424DAA0300000000000036000000280000001100
        0000110000000100180000000000740300000000000000000000000000000000
        0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFAEDAA249BF4525B52524B12451B64C9FCA93FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF7ED57829C7292ACC2A2ACC2A29C7
        2927BE2724B12464B55DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFC9E7BE2CD12C2DDC2D2FE32F2FE32F2DDE2D2CD12C28C22824B1249FCA
        93FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF75E1722FE32F32F232
        33F53333F53332F2322FE42F2CD12C27BE2751B64CFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFF5AE45B32F03234F93438FF3838FF3834F93432F232
        2DDE2D29C72924B124FFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFF64
        EA6533F53337FF377EFF7E81FF8138FF3833F5332FE32F2ACC2A25B525FFFFFF
        FFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFB0F2AD33F53337FF377CFF7C7E
        FF7E38FF3833F5332FE32F2ACC2A56C251FFFFFFFFFFFFFFFFFFFFFFFF00FFFF
        FFFFFFFFFFFFFFF0F0E45FF46034F93437FF3737FF3734F93432F2322DDC2D29
        C729CBE3BDFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFF0F6
        EA68F46933F53333F53332F0322FE32F30D230B0E2A8FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0EEE2CFF3CA7BEE7B73EA
        739CE698E6ECD8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00}
      Transparent = True
    end
    object SpeedButton1: TSpeedButton
      Left = 218
      Top = 1
      Width = 22
      Height = 21
      Hint = 'Fermer'
      Anchors = [akTop, akRight]
      Flat = True
      Glyph.Data = {
        E6010000424DE60100000000000036000000280000000C0000000C0000000100
        180000000000B001000000000000000000000000000000000000818181A3A3A3
        9E9E9E9898989696969191918B8B8B8686868181817C7C7C797979575757A8A8
        A88181815252523C3C3C3A3A3A3A3A3A3535353535352F2F2F3C3C3C5F5F5F79
        7979AEAEAE5C5C5C575757FFFFFE8181813C3C3C3A3A3A7E7E7EFFFFFE4A4A4A
        3737377C7C7CB3B3B3616161FFFFFEFFFFFEFFFFFE838383818181FFFFFEFFFF
        FEFFFFFE2F2F2F818181B5B5B56767678B8B8BFFFFFEFFFFFEFFFFFEFFFFFEFF
        FFFEFFFFFE7E7E7E323232868686BDBDBD6C6C6C4F4F4F8E8E8EFFFFFEFFFFFE
        FFFFFEFFFFFE8181813A3A3A353535919191D0D0D07979795F5F5F989898FFFF
        FEFFFFFEFFFFFEFFFFFE8989894A4A4A444444A6A6A6DDDDDD9B9B9BB8B8B8FF
        FFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFEA8A8A86C6C6CB8B8B8DFDFDFA0A0A0
        FFFFFEFFFFFEFFFFFEB3B3B3B0B0B0FFFFFEFFFFFEFFFFFE6C6C6CBBBBBBE2E2
        E2A0A0A09B9B9BFFFFFEB8B8B87E7E7E797979AEAEAEFFFFFE838383767676BD
        BDBDDFDFDFBBBBBB9393939191918E8E8E8989898686868181817E7E7E797979
        989898B8B8B8AEAEAED5D5D5D2D2D2D0D0D0CACACAC5C5C5C3C3C3C0C0C0BBBB
        BBB8B8B8B3B3B3898989}
      ParentShowHint = False
      ShowHint = True
      OnClick = PanelAllowedClick
      OnDblClick = SpeedButton1DblClick
    end
    object CheckBoxStay2: TCheckBox
      Left = 198
      Top = 1
      Width = 17
      Height = 21
      Hint = 'Ne pas dispara'#238'tre'
      Anchors = [akTop, akRight]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = CheckBoxStayClick
    end
  end
  object Edit1: TEdit
    Left = 21
    Top = 1
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
    Visible = False
    OnClick = Edit1Enter
    OnEnter = Edit1Enter
  end
  object TimerAfterCreate: TTimer
    Interval = 20000
    OnTimer = PanelAllowedClick
    Left = 8
    Top = 48
  end
  object PopupMenuForAllowed: TPopupMenu
    Images = Form1.ImageList3
    Left = 40
    Top = 48
    object Bloquerparfichierhost1: TMenuItem
      Caption = 'Bloquer par le fichier host'
      ImageIndex = 3
      OnClick = Bloquerparfichierhost1Click
    end
    object BloquerparfichierBlackwords1: TMenuItem
      Caption = 'Bloquer par Blackwords'
      Hint = 'Si une partie du nom est d'#233'tect'#233', le domaine est bloqu'#233
      ImageIndex = 10
      OnClick = BloquerparfichierBlackwords1Click
    end
    object Bloquertout1: TMenuItem
      Caption = 'Bloquer tout'
      ImageIndex = 9
      OnClick = Bloquertout1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Dsactiverlesalertespourlesdomainesautoriss1: TMenuItem
      Caption = 'D'#233'sactiver les alertes pour les domaines autoris'#233's'
      ImageIndex = 9
      OnClick = Dsactiverlesalertespourlesdomainesautoriss1Click
    end
  end
  object PopupMenuForDisallowed: TPopupMenu
    Images = Form1.ImageList3
    Left = 72
    Top = 48
    object AutoriserledomainedufichierHost1: TMenuItem
      Caption = 'Autoriser le domaine (fichier Host)'
      ImageIndex = 1
      OnClick = AutoriserledomainedufichierHost1Click
    end
    object AutoriserledomaineBlackwords1: TMenuItem
      Caption = 'Autoriser le domaine (Blackwords)'
      ImageIndex = 10
      OnClick = AutoriserledomaineBlackwords1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object ButtonDisableBlockHost: TMenuItem
      Caption = 'D'#233'sactiver tous les bloquages (fichier host)'
      ImageIndex = 9
      OnClick = ButtonDisableBlockHostClick
    end
    object ButtonDisableBlockBlackwords: TMenuItem
      Caption = 'D'#233'sactiver tous les bloquages (Blackwords)'
      ImageIndex = 9
      OnClick = ButtonDisableBlockBlackwordsClick
    end
    object Desactiverlebloquagedetouslesdomaines1: TMenuItem
      Caption = 'D'#233'sactiver tous les bloquages'
      ImageIndex = 9
      OnClick = Desactiverlebloquagedetouslesdomaines1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object DisableAlertDisallowed: TMenuItem
      Caption = 'D'#233'sactiver les alertes pour les domaines bloqu'#233's'
      ImageIndex = 9
      OnClick = DisableAlertDisallowedClick
    end
  end
  object TimerFadeIn: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerFadeInTimer
    Left = 104
    Top = 48
  end
  object TimerFadeOut: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TimerFadeOutTimer
    Left = 136
    Top = 48
  end
end
