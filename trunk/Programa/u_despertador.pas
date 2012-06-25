unit u_despertador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, u_dm, db, StdCtrls, DBCtrls, Buttons, PngSpeedButton, Grids, DBGrids,
  ADODB, Mask, ComCtrls, pngimage, ExtCtrls;

type
  Tf_despertador = class(TForm)
    l_numquarto: TLabel;
    l_hora: TLabel;
    db_hora: TDBEdit;
    gb_grid: TGroupBox;
    grid_despertador: TDBGrid;
    b_novo: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    dt_dia: TDateTimePicker;
    p_num_quarto: TEdit;
    b_listar_todos: TPngSpeedButton;
    Image1: TImage;
    db_num_quarto: TDBComboBox;
    b_cancelar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    RadioGroup1: TRadioGroup;
    procedure b_novoClick(Sender: TObject);
    procedure b_salvarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_cancelarClick(Sender: TObject);
    procedure b_sairClick(Sender: TObject);
    procedure b_finalizarClick(Sender: TObject);
    procedure b_fecharClick(Sender: TObject);
    procedure b_listar_todosClick(Sender: TObject);
    procedure p_num_quartoChange(Sender: TObject);
    procedure grid_despertadorCellClick(Column: TColumn);
    procedure dt_diaChange(Sender: TObject);
    procedure db_num_quartoDropDown(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_despertador: Tf_despertador;
  resultado : integer;

implementation

{$R *.dfm}


procedure Tf_despertador.b_novoClick(Sender: TObject);
begin
db_num_quarto.Enabled:=true;
db_hora.Enabled:=true;
b_novo.Enabled:=false;
b_salvar.Enabled:=true;
b_cancelar.Enabled:=true;
b_excluir.Enabled:=false;
dm.t_despertador.Append;
dm.q_despertador.Close;
dm.q_despertador.Open;
end;

procedure Tf_despertador.b_sairClick(Sender: TObject);
begin
close;
end;

procedure Tf_despertador.b_salvarClick(Sender: TObject);
begin
db_num_quarto.Enabled:=false;
db_hora.Enabled:=false;
b_novo.Enabled:=true;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
b_excluir.Enabled:=true;
b_listar_todos.Enabled:=true;
dm.t_despertador.Post;
dm.q_despertador.Close;
dm.q_despertador.Open;
end;

procedure Tf_despertador.db_num_quartoDropDown(Sender: TObject);
begin
with dm.q_quarto do
begin
  Close;
  SQL.Clear;
  SQL.Add('select distinct(numero) from quarto order by numero');
  Open;
  db_num_quarto.Clear;
  while not EOF do
  begin
    db_num_quarto.Items.Add(Fields[0].AsString);
    Next;
  end;
end;
end;

procedure Tf_despertador.dt_diaChange(Sender: TObject);
begin
  if (p_num_quarto.Text <> '') then
  begin
  with dm.q_despertador do
  begin
  Close;
  SQL.Clear;
  SQL.Add('select * from despertador where dia = :date and num_quarto like :cp');
  parameters.parambyname('cp').value := p_num_quarto.Text + '%';
  parameters.parambyname('date').value := datetostr(dt_dia.date);
  Open;
  end;
  end;

  if (p_num_quarto.Text = '') then
  begin

  with dm.q_despertador do
  begin
  Close;
  SQL.Clear;
  SQL.Add('select * from despertador where dia = :date');
  parameters.parambyname('date').value := datetostr(dt_dia.date);
  Open;
  end;
  end;

end;

procedure Tf_despertador.FormShow(Sender: TObject);
begin
db_num_quarto.Enabled:=false;
db_hora.Enabled:=false;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
end;

procedure Tf_despertador.grid_despertadorCellClick(Column: TColumn);
begin
resultado := dm.q_despertador.fieldbyname('id').AsInteger;
dm.t_despertador.Locate('id', resultado,[]);
end;

procedure Tf_despertador.p_num_quartoChange(Sender: TObject);
begin
if p_num_quarto.Text <> '' then
begin
  with dm.q_despertador do
  begin
  Close;
  SQL.Clear;
  SQL.Add('select * from despertador where dia = :date and num_quarto like :cp');
  parameters.parambyname('cp').value := p_num_quarto.text + '%';
  parameters.parambyname('date').value := datetostr(dt_dia.date);
  Open;
  end;
end
else
begin
  with dm.q_despertador do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from despertador where dia = :date');
  parameters.parambyname('date').value := datetostr(dt_dia.date);
  Open;
  end;
end;

end;

procedure Tf_despertador.b_cancelarClick(Sender: TObject);
begin
dm.t_despertador.Cancel;
dm.q_despertador.Close;
dm.q_despertador.Open;
end;

procedure Tf_despertador.b_excluirClick(Sender: TObject);
begin
If Application.MessageBox('Confirma Exclusão?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_despertador.Delete;
db_num_quarto.Enabled:=false;
db_hora.Enabled:=false;
  //atualizar grid
  with dm.q_despertador do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from despertador order by num_quarto');
  Open;
  end;
end;
end;

procedure Tf_despertador.b_fecharClick(Sender: TObject);
begin
close;
end;

procedure Tf_despertador.b_finalizarClick(Sender: TObject);
begin
dm.t_despertador.Delete;
dm.q_despertador.Close;
dm.q_despertador.Open;
end;

procedure Tf_despertador.b_listar_todosClick(Sender: TObject);
begin
  with dm.q_despertador do
  begin
  Close;
  SQL.Clear;
  SQL.Add('select * from despertador order by dia');
  Open;
  end;
end;

end.
