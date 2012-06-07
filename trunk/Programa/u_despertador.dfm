object f_despertador: Tf_despertador
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Despertador'
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
  object l_num: TLabel
    Left = 29
    Top = 121
    Width = 94
    Height = 13
    Caption = 'N'#250'mero do  quarto:'
  end
  object l_data: TLabel
    Left = 399
    Top = 121
    Width = 27
    Height = 13
    Caption = 'Data:'
  end
  object l_hora: TLabel
    Left = 399
    Top = 153
    Width = 27
    Height = 13
    Caption = 'Hora:'
  end
  object l_gridGeral: TLabel
    Left = 16
    Top = 448
    Width = 133
    Height = 13
    Caption = 'Hist'#243'rico de despertadores:'
  end
  object l_ativos: TLabel
    Left = 16
    Top = 280
    Width = 107
    Height = 13
    Caption = 'Despertadores ativos:'
  end
  object b_novo: TPngSpeedButton
    Left = 467
    Top = 264
    Width = 23
    Height = 22
    Caption = 'Novo'
  end
  object b_salvar: TPngSpeedButton
    Left = 506
    Top = 264
    Width = 23
    Height = 22
    Caption = 'Salvar'
  end
  object b_cancelar: TPngSpeedButton
    Left = 547
    Top = 264
    Width = 23
    Height = 22
    Caption = 'Cancelar'
  end
  object b_excluir: TPngSpeedButton
    Left = 592
    Top = 264
    Width = 23
    Height = 22
    Caption = 'Excluir'
  end
  object l_status: TLabel
    Left = 399
    Top = 186
    Width = 112
    Height = 13
    Caption = 'Status do despertador:'
  end
  object grid_geral: TDBGrid
    Left = 8
    Top = 472
    Width = 784
    Height = 120
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object grid_ativos: TDBGrid
    Left = 8
    Top = 304
    Width = 784
    Height = 120
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object check_ativo: TDBCheckBox
    Left = 527
    Top = 185
    Width = 43
    Height = 17
    Caption = 'Ativo'
    DataField = 'feito'
    DataSource = ds_despertador
    TabOrder = 2
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object db_data: TDBEdit
    Left = 436
    Top = 118
    Width = 121
    Height = 21
    DataField = 'dia'
    DataSource = ds_despertador
    TabOrder = 3
  end
  object db_hora: TDBEdit
    Left = 432
    Top = 145
    Width = 121
    Height = 21
    DataField = 'hora'
    DataSource = ds_despertador
    TabOrder = 4
  end
  object db_num_quarto: TDBComboBox
    Left = 130
    Top = 118
    Width = 145
    Height = 21
    TabOrder = 5
  end
  object conexao: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Royalt Hotel\ban' +
      'co\banco.mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 16
    Top = 8
  end
  object tb_despertador: TADOTable
    Active = True
    Connection = conexao
    CursorType = ctStatic
    TableName = 'despertador'
    Left = 88
    Top = 8
  end
  object ds_despertador: TDataSource
    DataSet = tb_despertador
    Left = 160
    Top = 8
  end
end
