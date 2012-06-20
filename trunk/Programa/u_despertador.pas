unit u_despertador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_dm, db, StdCtrls, DBCtrls, Buttons, PngSpeedButton, Grids, DBGrids,
  ADODB, Mask, ComCtrls, pngimage, ExtCtrls;

type
  Tf_despertador = class(TForm)
    l_numquarto: TLabel;
    l_dia: TLabel;
    l_hora: TLabel;
    db_numquarto: TDBEdit;
    db_dia: TDBEdit;
    db_hora: TDBEdit;
    gb_grid: TGroupBox;
    grid_despertador: TDBGrid;
    b_novo: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    b_alterar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    b_cancelar: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    dt_dia: TDateTimePicker;
    l_dia1: TLabel;
    p_num_quarto: TEdit;
    l_num_quarto: TLabel;
    b_listar_todos: TPngSpeedButton;
    b_finalizar: TPngSpeedButton;
    b_listar_ativos: TPngSpeedButton;
    Image1: TImage;
    procedure b_novoClick(Sender: TObject);
    procedure b_salvarClick(Sender: TObject);
    procedure b_alterarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_cancelarClick(Sender: TObject);
    procedure b_sairClick(Sender: TObject);
    procedure b_primeiroClick(Sender: TObject);
    procedure b_anteriorClick(Sender: TObject);
    procedure b_proximoClick(Sender: TObject);
    procedure b_ultimoClick(Sender: TObject);
    procedure b_finalizarClick(Sender: TObject);
    procedure b_fecharClick(Sender: TObject);
    procedure b_listar_todosClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_despertador: Tf_despertador;

implementation

{$R *.dfm}


procedure Tf_despertador.b_novoClick(Sender: TObject);
begin
dm.t_despertador.Append;
dm.q_dispertador.Close;
dm.q_dispertador.Open;
end;

procedure Tf_despertador.b_primeiroClick(Sender: TObject);
begin
dm.t_despertador.First;
end;

procedure Tf_despertador.b_proximoClick(Sender: TObject);
begin
dm.t_despertador.Next;
end;

procedure Tf_despertador.b_sairClick(Sender: TObject);
begin
close;
end;

procedure Tf_despertador.b_salvarClick(Sender: TObject);
begin
dm.t_despertador.Post;
dm.q_dispertador.Close;
dm.q_dispertador.Open;
end;

procedure Tf_despertador.b_ultimoClick(Sender: TObject);
begin
dm.t_despertador.Last;
end;

procedure Tf_despertador.b_alterarClick(Sender: TObject);
begin
dm.t_despertador.Edit;
dm.q_dispertador.Close;
dm.q_dispertador.Open;
end;

procedure Tf_despertador.b_anteriorClick(Sender: TObject);
begin
dm.t_despertador.Prior;
end;

procedure Tf_despertador.b_cancelarClick(Sender: TObject);
begin
dm.t_despertador.Cancel;
dm.q_dispertador.Close;
dm.q_dispertador.Open;
end;

procedure Tf_despertador.b_excluirClick(Sender: TObject);
begin
dm.t_despertador.Delete;
dm.q_dispertador.Close;
dm.q_dispertador.Open;
end;

procedure Tf_despertador.b_fecharClick(Sender: TObject);
begin
close;
end;

procedure Tf_despertador.b_finalizarClick(Sender: TObject);
begin

dm.q_dispertador.Close;
dm.q_dispertador.Open;
end;

procedure Tf_despertador.b_listar_todosClick(Sender: TObject);
begin
  with dm.q_dispertador do
  begin
  Close;
  SQL.Clear;
  SQL.Add('select * from despertador where status = aberto order by dia');
  Open;
  end;
end;

end.
