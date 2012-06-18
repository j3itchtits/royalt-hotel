object f_despertador: Tf_despertador
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Sim'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object b_novo: TPngSpeedButton
    Left = 48
    Top = 280
    Width = 49
    Height = 22
    Caption = 'Novo'
    OnClick = b_novoClick
  end
  object b_salvar: TPngSpeedButton
    Left = 154
    Top = 280
    Width = 47
    Height = 22
    Caption = 'Salvar'
    OnClick = b_salvarClick
  end
  object b_alterar: TPngSpeedButton
    Left = 244
    Top = 280
    Width = 45
    Height = 22
    Caption = 'Alterar'
    OnClick = b_alterarClick
  end
  object b_excluir: TPngSpeedButton
    Left = 496
    Top = 280
    Width = 41
    Height = 22
    Caption = 'Excluir'
    OnClick = b_excluirClick
  end
  object b_cancelar: TPngSpeedButton
    Left = 578
    Top = 280
    Width = 47
    Height = 22
    Caption = 'Cancelar'
    OnClick = b_cancelarClick
  end
  object b_sair: TPngSpeedButton
    Left = 688
    Top = 280
    Width = 31
    Height = 22
    Caption = 'Sair'
    OnClick = b_sairClick
  end
  object b_primeiro: TPngSpeedButton
    Left = 88
    Top = 320
    Width = 49
    Height = 22
    Caption = 'Primeiro'
    OnClick = b_primeiroClick
  end
  object b_anterior: TPngSpeedButton
    Left = 200
    Top = 320
    Width = 49
    Height = 22
    Caption = 'Anterior'
    OnClick = b_anteriorClick
  end
  object b_proximo: TPngSpeedButton
    Left = 536
    Top = 320
    Width = 49
    Height = 22
    Caption = 'Pr'#243'ximo'
    OnClick = b_proximoClick
  end
  object b_ultimo: TPngSpeedButton
    Left = 632
    Top = 320
    Width = 41
    Height = 22
    Caption = #218'ltimo'
    OnClick = b_ultimoClick
  end
  object l_numquarto: TLabel
    Left = 48
    Top = 164
    Width = 94
    Height = 13
    Caption = 'N'#250'mero do quarto: '
  end
  object l_dia: TLabel
    Left = 48
    Top = 188
    Width = 19
    Height = 13
    Caption = 'Dia:'
  end
  object l_hora: TLabel
    Left = 48
    Top = 212
    Width = 27
    Height = 13
    Caption = 'Hora:'
  end
  object l_realizado: TLabel
    Left = 48
    Top = 237
    Width = 50
    Height = 13
    Caption = 'Realizado:'
  end
  object db_numquarto: TDBEdit
    Left = 146
    Top = 161
    Width = 121
    Height = 21
    DataField = 'num_quarto'
    DataSource = dm.ds_despertador
    TabOrder = 0
  end
  object db_dia: TDBEdit
    Left = 75
    Top = 185
    Width = 121
    Height = 21
    DataField = 'dia'
    DataSource = dm.ds_despertador
    TabOrder = 1
  end
  object db_hora: TDBEdit
    Left = 83
    Top = 209
    Width = 121
    Height = 21
    DataField = 'hora'
    DataSource = dm.ds_despertador
    TabOrder = 2
  end
  object c_sim: TDBCheckBox
    Left = 104
    Top = 236
    Width = 97
    Height = 17
    Caption = 'Sim'
    DataField = 'feito'
    DataSource = dm.ds_despertador
    TabOrder = 3
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 368
    Width = 761
    Height = 209
    DataSource = dm.ds_despertador
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'N'#250'mero do quarto'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Realizado'
        Visible = True
      end>
  end
end
