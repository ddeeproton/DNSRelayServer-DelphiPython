object FormManageIP: TFormManageIP
  Left = 930
  Top = 435
  Width = 303
  Height = 203
  Caption = 'R'#232'gles d'#39'exception'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    295
    176)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 2
    Top = 4
    Width = 196
    Height = 160
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Adresses IP'
    TabOrder = 0
    DesignSize = (
      196
      160)
    object ListBox1: TListBox
      Left = 8
      Top = 20
      Width = 177
      Height = 132
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
    end
  end
  object ButtonAjouter: TButton
    Left = 207
    Top = 16
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Ajouter'
    TabOrder = 1
    OnClick = ButtonAjouterClick
  end
  object ButtonSupprimer: TButton
    Left = 207
    Top = 48
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Supprimer'
    TabOrder = 2
    OnClick = ButtonSupprimerClick
  end
  object ButtonClose: TButton
    Left = 207
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Fermer'
    TabOrder = 3
    OnClick = ButtonCloseClick
  end
end
