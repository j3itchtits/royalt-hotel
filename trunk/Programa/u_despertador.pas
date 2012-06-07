unit u_despertador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_dm, db, StdCtrls, DBCtrls, Buttons, PngSpeedButton, Grids, DBGrids,
  ADODB, Mask;

type
  Tf_despertador = class(TForm)
    conexao: TADOConnection;
    tb_despertador: TADOTable;
    ds_despertador: TDataSource;
    l_num: TLabel;
    l_data: TLabel;
    l_hora: TLabel;
    grid_geral: TDBGrid;
    l_gridGeral: TLabel;
    grid_ativos: TDBGrid;
    l_ativos: TLabel;
    b_novo: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    b_cancelar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    check_ativo: TDBCheckBox;
    l_status: TLabel;
    db_data: TDBEdit;
    db_hora: TDBEdit;
    db_num_quarto: TDBComboBox;
    procedure db_dataChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_despertador: Tf_despertador;

implementation

{$R *.dfm}

