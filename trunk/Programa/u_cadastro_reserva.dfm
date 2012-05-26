object f_cadastro_reserva: Tf_cadastro_reserva
  Left = 0
  Top = 0
  Caption = 'f_cadastro_reserva'
  ClientHeight = 557
  ClientWidth = 788
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 83
    Top = 83
    Width = 23
    Height = 13
    Caption = 'CPF:'
  end
  object Label2: TLabel
    Left = 64
    Top = 120
    Width = 42
    Height = 13
    Caption = 'Entrada:'
  end
  object Label3: TLabel
    Left = 24
    Top = 190
    Width = 82
    Height = 13
    Caption = 'N'#250'm. Do Quarto:'
  end
  object Label4: TLabel
    Left = 76
    Top = 155
    Width = 30
    Height = 13
    Caption = 'Sa'#237'da:'
  end
  object gb_reserva: TGroupBox
    Left = 45
    Top = 296
    Width = 705
    Height = 233
    Caption = 'Pesquisar Reserva'
    TabOrder = 0
    object Label5: TLabel
      Left = 24
      Top = 32
      Width = 20
      Height = 14
      Caption = 'Dia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object g_reserva: TDBGrid
      Left = 24
      Top = 72
      Width = 665
      Height = 145
      DataSource = dm.ds_reserva_grid
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'check_in'
          Title.Caption = 'Entrada'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'check_out'
          Title.Caption = 'Sa'#237'da'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id_quarto'
          Title.Caption = 'N'#250'm. Quarto'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cpf_cliente'
          Title.Caption = 'CPF do Cliente'
          Width = 150
          Visible = True
        end>
    end
    object DateTimePicker1: TDateTimePicker
      Left = 67
      Top = 32
      Width = 94
      Height = 21
      Date = 41054.899026504630000000
      Time = 41054.899026504630000000
      TabOrder = 1
    end
  end
  object db_cpf: TDBEdit
    Left = 120
    Top = 80
    Width = 115
    Height = 21
    DataField = 'cpf_cliente'
    DataSource = dm.ds_reserva
    MaxLength = 14
    TabOrder = 1
  end
  object db_check_in: TDBEdit
    Left = 120
    Top = 117
    Width = 121
    Height = 21
    DataField = 'check_in'
    DataSource = dm.ds_reserva
    MaxLength = 10
    TabOrder = 2
  end
  object db_check_out: TDBEdit
    Left = 120
    Top = 152
    Width = 121
    Height = 21
    DataField = 'check_out'
    DataSource = dm.ds_reserva
    MaxLength = 10
    TabOrder = 3
  end
  object db_combo_box: TDBComboBox
    Left = 120
    Top = 187
    Width = 121
    Height = 21
    DataField = 'id_quarto'
    DataSource = dm.ds_reserva
    TabOrder = 4
    OnDropDown = OnDropDown_db_combo_box
  end
end
