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
    Left = 40
    Top = 104
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object Label2: TLabel
    Left = 184
    Top = 104
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 328
    Top = 104
    Width = 31
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 472
    Top = 104
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object db_cpf: TDBEdit
    Left = 40
    Top = 136
    Width = 112
    Height = 21
    DataField = 'cpf_usuario'
    DataSource = dm.ds_reserva
    MaxLength = 14
    TabOrder = 0
  end
  object DBEdit3: TDBEdit
    Left = 472
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object gb_reserva: TGroupBox
    Left = 40
    Top = 264
    Width = 705
    Height = 233
    Caption = 'Pesquisar Reserva'
    TabOrder = 2
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
          FieldName = 'id'
          Title.Caption = 'Id'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'check_in'
          Title.Caption = 'Check In'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'check_out'
          Title.Caption = 'Check Out'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'id_quarto'
          Title.Caption = 'Id Quarto'
          Width = 53
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cpf_usuario'
          Title.Caption = 'CPF'
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data_reserva'
          Title.Caption = 'Data Reservada'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'dia'
          Title.Caption = 'Quant. de Dias Reservados'
          Width = 142
          Visible = True
        end>
    end
  end
  object DBEdit4: TDBEdit
    Left = 328
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object DBEdit1: TDBEdit
    Left = 184
    Top = 136
    Width = 112
    Height = 21
    DataField = 'data_reserva'
    DataSource = dm.ds_reserva
    MaxLength = 8
    TabOrder = 4
  end
end
