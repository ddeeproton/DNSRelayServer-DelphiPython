object FormNetConfig: TFormNetConfig
  Left = 373
  Top = 104
  BorderStyle = bsSingle
  Caption = 'W'
  ClientHeight = 406
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label9: TLabel
    Left = 16
    Top = 16
    Width = 337
    Height = 39
    Caption = 
      'Vous pouvez indiquer ici la configuration de la carte r'#233'seau qui' +
      ' sera appliqu'#233' au moment de la fermeture du programme. En cas de' +
      ' do'#251'te, laissez en mode automatique.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 192
    Top = 368
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 272
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Annuler'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 64
    Width = 361
    Height = 161
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 35
      Top = 8
      Width = 192
      Height = 13
      Caption = 'Obtenir une adresse IP automatiquement'
      FocusControl = RadioButtonDHCP_IP
      OnClick = LabelClick
    end
    object RadioButtonDHCP_IP: TRadioButton
      Left = 16
      Top = 8
      Width = 17
      Height = 17
      TabOrder = 0
      OnClick = RadioButtonDHCP_IPClick
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 32
      Width = 337
      Height = 121
      Caption = '                                                      '
      TabOrder = 1
      object Label2: TLabel
        Left = 26
        Top = -1
        Width = 137
        Height = 13
        Caption = 'Utiliser l'#39'adresse IP suivante :'
        FocusControl = RadioButtonCUSTOM_IP
        OnClick = LabelClick
      end
      object Label3: TLabel
        Left = 16
        Top = 24
        Width = 57
        Height = 13
        Caption = 'Adresse IP :'
      end
      object Label4: TLabel
        Left = 16
        Top = 50
        Width = 119
        Height = 13
        Caption = 'Masque de sous-r'#233'seau :'
      end
      object Label5: TLabel
        Left = 16
        Top = 76
        Width = 105
        Height = 13
        Caption = 'Passerelle par d'#233'faut :'
      end
      object Edit1: TEdit
        Left = 190
        Top = 24
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 12
        Text = '          .          .         .'
      end
      object Memo1: TMemo
        Left = 194
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
      end
      object Memo2: TMemo
        Left = 227
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
      end
      object Memo3: TMemo
        Left = 258
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
      end
      object Memo4: TMemo
        Left = 289
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
      end
      object Edit2: TEdit
        Left = 190
        Top = 50
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 13
        Text = '          .          .         .'
      end
      object Memo5: TMemo
        Left = 194
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 4
        WantReturns = False
        WordWrap = False
      end
      object Memo6: TMemo
        Left = 227
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 5
        WantReturns = False
        WordWrap = False
      end
      object Memo7: TMemo
        Left = 258
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 6
        WantReturns = False
        WordWrap = False
      end
      object Memo8: TMemo
        Left = 289
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 7
        WantReturns = False
        WordWrap = False
      end
      object Edit3: TEdit
        Left = 190
        Top = 76
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 14
        Text = '          .          .         .'
      end
      object Memo9: TMemo
        Left = 194
        Top = 80
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 8
        WantReturns = False
        WordWrap = False
      end
      object Memo10: TMemo
        Left = 227
        Top = 80
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 9
        WantReturns = False
        WordWrap = False
      end
      object Memo11: TMemo
        Left = 258
        Top = 80
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 10
        WantReturns = False
        WordWrap = False
      end
      object Memo12: TMemo
        Left = 289
        Top = 80
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 11
        WantReturns = False
        WordWrap = False
      end
    end
    object RadioButtonCUSTOM_IP: TRadioButton
      Left = 16
      Top = 29
      Width = 15
      Height = 17
      TabOrder = 2
      OnClick = RadioButtonCUSTOM_IPClick
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 232
    Width = 353
    Height = 129
    BevelOuter = bvNone
    TabOrder = 3
    object Label10: TLabel
      Left = 34
      Top = 8
      Width = 192
      Height = 13
      Caption = 'Obtenir une adresse IP automatiquement'
      FocusControl = RadioButtonDHCP_DNS
      OnClick = LabelClick
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 32
      Width = 337
      Height = 89
      Caption = '                                                      '
      TabOrder = 0
      object Label6: TLabel
        Left = 25
        Top = 0
        Width = 137
        Height = 13
        Caption = 'Utiliser l'#39'adresse IP suivante :'
        FocusControl = RadioButtonCUSTOM_DNS
        OnClick = LabelClick
      end
      object Label7: TLabel
        Left = 16
        Top = 24
        Width = 105
        Height = 13
        Caption = 'Serveur DNS pr'#233'f'#233'r'#233' :'
      end
      object Label8: TLabel
        Left = 16
        Top = 50
        Width = 124
        Height = 13
        Caption = 'Serveur DNS secondaire :'
      end
      object Edit4: TEdit
        Left = 192
        Top = 24
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 8
        Text = '          .          .         .'
      end
      object Memo13: TMemo
        Left = 196
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
      end
      object Memo14: TMemo
        Left = 229
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
      end
      object Memo15: TMemo
        Left = 260
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
      end
      object Memo16: TMemo
        Left = 291
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
      end
      object Edit5: TEdit
        Left = 192
        Top = 50
        Width = 132
        Height = 21
        ReadOnly = True
        TabOrder = 9
        Text = '          .          .         .'
      end
      object Memo17: TMemo
        Left = 196
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 4
        WantReturns = False
        WordWrap = False
      end
      object Memo18: TMemo
        Left = 229
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 5
        WantReturns = False
        WordWrap = False
      end
      object Memo19: TMemo
        Left = 260
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 6
        WantReturns = False
        WordWrap = False
      end
      object Memo20: TMemo
        Left = 291
        Top = 54
        Width = 28
        Height = 14
        Alignment = taCenter
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Lines.Strings = (
          '000')
        MaxLength = 3
        TabOrder = 7
        WantReturns = False
        WordWrap = False
      end
    end
    object RadioButtonDHCP_DNS: TRadioButton
      Left = 16
      Top = 8
      Width = 17
      Height = 17
      TabOrder = 1
      OnClick = RadioButtonDHCP_DNSClick
    end
    object RadioButtonCUSTOM_DNS: TRadioButton
      Left = 16
      Top = 32
      Width = 15
      Height = 17
      TabOrder = 2
      OnClick = RadioButtonCUSTOM_DNSClick
    end
  end
end
