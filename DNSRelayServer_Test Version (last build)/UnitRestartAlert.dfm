object FormRestart: TFormRestart
  Left = 194
  Top = 876
  BorderStyle = bsNone
  Caption = 'FormRestart'
  ClientHeight = 25
  ClientWidth = 297
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
  object ButtonRestart: TButton
    Left = 0
    Top = 0
    Width = 84
    Height = 25
    Caption = 'Red'#233'marrer'
    TabOrder = 0
    OnClick = ButtonRestartClick
  end
  object Panel1: TPanel
    Left = 264
    Top = 0
    Width = 33
    Height = 25
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      33
      25)
    object SpeedButtonClose: TSpeedButton
      Left = 11
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
      OnClick = SpeedButtonCloseClick
      OnDblClick = SpeedButtonCloseDblClick
    end
  end
  object TimerFadeIn: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerFadeInTimer
    Left = 88
  end
  object TimerFadeOut: TTimer
    Enabled = False
    Interval = 10
    OnTimer = TimerFadeOutTimer
    Left = 120
  end
end
