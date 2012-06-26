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
    Label1: TLabel;
    Label2: TLabel;
    gb_mensagem: TGroupBox;
    l_mensagem: TLabel;
    timer: TTimer;
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
    procedure timerTimer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_despertador: Tf_despertador;
  resultado: integer;

implementation

{$R *.dfm}


procedure Tf_despertador.b_novoClick(Sender: TObject);
begin
l_mensagem.Caption:='Criando novo registro...';
l_mensagem.Font.Color:=clBlue;
timer.Enabled:=true;
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
if (db_num_quarto.Text = '') then
  begin
  l_mensagem.Caption:='O número do quarto não pode ser vazio!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
if (db_hora.Text = '  /  /           :  ') then
  begin
  l_mensagem.Caption:='O data e a hora devem estar preenchidas corretamente!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
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
l_mensagem.Caption:='Despertador cadastrado com sucesso!';
l_mensagem.Font.Color:=clGreen;
timer.Enabled:=true;
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
with dm.q_despertador do
begin
Close;
SQL.Clear;
sql.Add('select * from despertador where hora > :date1 and hora < :date2');
parameters.parambyname('date1').value := datetostr(dt_dia.date);
parameters.parambyname('date2').value := datetostr(dt_dia.date + 1);
Open;
resultado := dm.q_despertador.fieldbyname('id').asinteger;
dm.t_despertador.Locate('id',resultado,[loCaseInsensitive, loPartialKey]);
end;
end;

procedure Tf_despertador.FormShow(Sender: TObject);
begin
l_mensagem.Caption:='';
l_mensagem.Color:=clblack;
db_num_quarto.Enabled:=false;
db_hora.Enabled:=false;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
 // atualizar grid
 with dm.q_despertador do
 begin
 Close;
 SQL.Clear;
 sql.Add('select * from despertador order by num_quarto');
 Open;
 end;

end;

procedure Tf_despertador.grid_despertadorCellClick(Column: TColumn);
begin
resultado := dm.q_despertador.fieldbyname('id').AsInteger;
dm.t_despertador.Locate('id', resultado,[]);
end;

procedure Tf_despertador.p_num_quartoChange(Sender: TObject);
begin
if p_num_quarto.text <> '' then
begin
 with dm.q_despertador do
 begin
 Close;
 SQL.Clear;
 sql.Add('select * from despertador where num_quarto like '''+p_num_quarto.text+'%'' order by num_quarto');
 Open;
 resultado := dm.q_despertador.fieldbyname('id').asinteger;
 dm.t_despertador.Locate('id',resultado,[loCaseInsensitive, loPartialKey]);
 end;
end
else
begin
 with dm.q_despertador do
 begin
 Close;
 SQL.Clear;
 sql.Add('select * from despertador order by num_quarto');
 Open;
 end;
end;
end;

procedure Tf_despertador.timerTimer(Sender: TObject);
begin
l_mensagem.caption:='';
l_mensagem.Font.Color:=clBlack;
timer.Enabled:=false;
end;

procedure Tf_despertador.b_cancelarClick(Sender: TObject);
begin
dm.t_despertador.Cancel;
db_num_quarto.Enabled:=false;
db_hora.Enabled:=false;
b_novo.Enabled:=false;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
b_excluir.Enabled:=true;
b_salvar.Enabled:=false;
b_novo.Enabled:=true;
l_mensagem.Caption:='Cancelado!';
l_mensagem.Font.Color:=clGreen;
timer.Enabled:=true;
  //atualizar grid
  with dm.q_despertador do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from despertador order by num_quarto');
  Open;
  end;


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
l_mensagem.Caption:='Excluído com sucesso!';
l_mensagem.Font.Color:=clRed;
timer.Enabled:=true;
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
sql.Add('select * from despertador order by num_quarto');
Open;
end;
end;
end.
