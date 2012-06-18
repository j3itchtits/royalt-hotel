unit u_despertador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_dm, db, StdCtrls, DBCtrls, Buttons, PngSpeedButton, Grids, DBGrids,
  ADODB, Mask, ComCtrls;

type
  Tf_despertador = class(TForm)
    l_numquarto: TLabel;
    l_dia: TLabel;
    l_hora: TLabel;
    db_numquarto: TDBEdit;
    db_dia: TDBEdit;
    db_hora: TDBEdit;
    gb_grid: TGroupBox;
    dbg_despertador: TDBGrid;
    PngSpeedButton1: TPngSpeedButton;
    PngSpeedButton2: TPngSpeedButton;
    PngSpeedButton3: TPngSpeedButton;
    PngSpeedButton4: TPngSpeedButton;
    PngSpeedButton5: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    DateTimePicker1: TDateTimePicker;
    Label5: TLabel;
    p_num_quarto: TEdit;
    Label7: TLabel;
    b_listar_todos: TPngSpeedButton;
    b_finalizar: TPngSpeedButton;
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
end;

procedure Tf_despertador.b_ultimoClick(Sender: TObject);
begin
dm.t_despertador.Last;
end;

procedure Tf_despertador.b_alterarClick(Sender: TObject);
begin
dm.t_despertador.Edit;
end;

procedure Tf_despertador.b_anteriorClick(Sender: TObject);
begin
dm.t_despertador.Prior;
end;

procedure Tf_despertador.b_cancelarClick(Sender: TObject);
begin
dm.t_despertador.Cancel;
end;

procedure Tf_despertador.b_excluirClick(Sender: TObject);
begin
dm.t_despertador.Delete;
end;

end.
