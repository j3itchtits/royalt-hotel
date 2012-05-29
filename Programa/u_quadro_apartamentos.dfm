object f_quadro_apartamentos: Tf_quadro_apartamentos
  Left = 0
  Top = 0
  VertScrollBar.Visible = False
  Caption = 'Quadro de apartamentos'
  ClientHeight = 554
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 731
    Height = 554
    HorzScrollBar.Range = 161
    VertScrollBar.Range = 5000
    Align = alClient
    AutoScroll = False
    TabOrder = 0
    ExplicitTop = 48
    ExplicitHeight = 506
    object bt_atualizar: TButton
      Left = 272
      Top = 3
      Width = 65
      Height = 33
      Caption = 'Atualizar'
      TabOrder = 0
      OnClick = bt_atualizarClick
    end
  end
end
