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
    t_quarto: TADOTable;
    ds_quarto: TDataSource;
    q_quarto: TADOQuery;
    ds_quarto_grid: TDataSource;
    t_clientecpf: TWideStringField;
    t_clientenome: TWideStringField;
    t_clientetelefone_celular: TWideStringField;
    t_clienteemail: TWideStringField;
    t_clienteendereco: TWideStringField;
    t_clientecomplemento: TWideStringField;
    t_clientebairro: TWideStringField;
    t_clientecidade: TWideStringField;
    t_clienteestado: TWideStringField;
    t_clientecep: TWideStringField;
    t_clientepais: TWideStringField;
    t_clientetelefone_residencial: TWideStringField;
    t_quartoid: TAutoIncField;
    t_quartotipo: TWideStringField;
    t_quartolimpo: TBooleanField;
    t_quartoocupado: TBooleanField;
    t_quartoandar: TIntegerField;
    t_quartonumero: TIntegerField;
    t_quartoinfo_add: TWideStringField;
    t_quartodiaria: TIntegerField;
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
