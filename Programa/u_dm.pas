unit u_dm;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  Tdm = class(TDataModule)
    conexao: TADOConnection;
    t_cliente: TADOTable;
    ds_cliente: TDataSource;
    q_cliente: TADOQuery;
    ds_cliente_grid: TDataSource;
    t_clienteid: TAutoIncField;
    t_clientecpf: TWideStringField;
    t_clientenome: TWideStringField;
    t_clientetelefone: TWideStringField;
    t_clienteestado: TWideStringField;
    t_clientecidade: TWideStringField;
    t_quarto: TADOTable;
    ds_quarto: TDataSource;
    q_quarto: TADOQuery;
    ds_quarto_grid: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

end.
