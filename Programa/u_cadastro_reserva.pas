unit u_cadastro_reserva;

interface

uses
  u_dm, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ComCtrls, Buttons,
  PngSpeedButton, ExtCtrls, pngimage, db;

type
  Tf_cadastro_reserva = class(TForm)
    gb_reserva: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    g_reserva: TDBGrid;
    dtp_reserva: TDateTimePicker;
    Label5: TLabel;
    b_novo: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    b_alterar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    b_cancelar: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    b_listar_todos: TPngSpeedButton;
    t_cpf: TEdit;
    Label6: TLabel;
    db_check_in: TDBEdit;
    db_check_out: TDBEdit;
    t_num_quarto: TEdit;
    Label7: TLabel;
    db_combo_box: TDBComboBox;
    db_cpf: TDBEdit;
    Image1: TImage;
    gb_cliente: TGroupBox;
    PngSpeedButton1: TPngSpeedButton;
    t_nome: TEdit;
    db_nome: TDBText;
    db_endereco: TDBText;
    db_cidade: TDBText;
    Label8: TLabel;
    l_cpf: TLabel;
    db_cpf2: TDBText;
    gb_mensagem: TGroupBox;
    l_mensagem: TLabel;
    timer: TTimer;
    procedure b_fecharClick(Sender: TObject);
    procedure b_cancelarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_listar_todosClick(Sender: TObject);
    procedure b_novoClick(Sender: TObject);
    procedure b_alterarClick(Sender: TObject);
    procedure b_salvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OnChange(Sender: TObject);
    procedure dtp_reserva_change(Sender: TObject);
    procedure db_combo_box_DropDown(Sender: TObject);
    procedure num_quarto_change(Sender: TObject);
    procedure g_reserva_titleClick(Column: TColumn);
    procedure g_reserva_cellClick(Column: TColumn);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure t_nomeChange(Sender: TObject);
    procedure timerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_reserva: Tf_cadastro_reserva;
  v_salvar : integer;
  contar_cpf : integer;
  contar_reserva : integer;
  resultado : integer;
  id : string;
  gbcliente : integer;
  resultado2 : string;
  fatiarcpf : string;

implementation

{$R *.dfm}

procedure Tf_cadastro_reserva.b_alterarClick(Sender: TObject);
begin
db_cpf.Enabled:=true;
db_check_in.Enabled:=true;
db_check_out.Enabled:=true;
db_combo_box.Enabled:=true;
b_salvar.Enabled:=true;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_novo.Enabled:=false;
b_cancelar.Enabled:=true;
//vai servir para o botão salvar saber
v_salvar := 2;
id := dm.t_reserva.FieldByName('id').asstring;
//
l_mensagem.Caption:='Alterando registro...';
l_mensagem.Font.Color:=clOlive;
timer.Enabled:=true;
dm.t_reserva.Edit;
end;

procedure Tf_cadastro_reserva.b_cancelarClick(Sender: TObject);
begin
dm.t_reserva.Cancel;
l_mensagem.Caption:='Cancelado!';
l_mensagem.Font.Color:=clGreen;
timer.Enabled:=true;
db_cpf.Enabled:=false;
db_check_in.Enabled:=false;
db_check_out.Enabled:=false;
db_combo_box.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva order by check_in');
  Open;
  end;
end;

procedure Tf_cadastro_reserva.b_excluirClick(Sender: TObject);
begin
If Application.MessageBox('Confirma Exclusão?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_reserva.Delete;
l_mensagem.Caption:='Reserva excluida com sucesso!';
l_mensagem.Font.Color:=clGreen;
timer.Enabled:=true;
db_cpf.Enabled:=false;
db_check_in.Enabled:=false;
db_check_out.Enabled:=false;
db_combo_box.Enabled:=false;
dm.q_cliente.Active:=false;
dm.q_cliente.Active:=true;
  //atualizar grid
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva order by check_in');
  Open;
  end;
end;
end;

procedure Tf_cadastro_reserva.b_fecharClick(Sender: TObject);
begin
dm.t_reserva.Cancel;
db_cpf.Enabled:=false;
db_check_in.Enabled:=false;
db_check_out.Enabled:=false;
db_combo_box.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;

close;
end;

procedure Tf_cadastro_reserva.b_listar_todosClick(Sender: TObject);
begin
dm.t_reserva.cancel;
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva order by check_in');
  Open;
  end;
end;

procedure Tf_cadastro_reserva.b_novoClick(Sender: TObject);
begin
db_cpf.Enabled:=true;
db_check_in.Enabled:=true;
db_check_out.Enabled:=true;
db_combo_box.Enabled:=true;
b_novo.Enabled:=false;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_salvar.Enabled:=true;
b_cancelar.Enabled:=true;
//vai servir para o botão salvar saber se
v_salvar := 1;
//
l_mensagem.Caption:='Criando novo registro...';
l_mensagem.Font.Color:=clBlue;
timer.Enabled:=true;
dm.t_reserva.cancel;
dm.t_reserva.append;
db_cpf.SetFocus;
end;

procedure Tf_cadastro_reserva.b_salvarClick(Sender: TObject);
begin
if db_cpf.text = '' then
  begin
  l_mensagem.Caption:='CPF não pode ser vazio!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
with dm.q_cliente do
  begin
  Active := False;
  SQL.Text := 'select * from cliente where cpf = :cp';
  parameters.parambyname('cp').value := db_cpf.text;
  Active := True;
  contar_cpf := RecordCount;
  end;
if contar_cpf = 0 then
  begin
  l_mensagem.Caption:='CPF não está cadastrado!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
if db_check_in.text = '' then
  begin
  l_mensagem.Caption:='Data de Entrada não pode ser vazio!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
if db_check_in.text = '' then
  begin
  l_mensagem.Caption:='Data de Saída não pode ser vazio!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
if db_combo_box.Text = '' then
  begin
  l_mensagem.Caption:='Selecione o número do quarto!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
if v_salvar = 1 then
begin
with dm.q_reserva do
  begin
  Active := False;
  SQL.Text := 'select * from reserva where num_quarto = :num and (( :in between check_in and check_out) or ( :out between check_in and check_out) or ( check_in between :in and :out) or ( check_out between :in and :out))';
  parameters.parambyname('num').value := db_combo_box.text;
  parameters.parambyname('in').value := db_check_in.text;
  parameters.parambyname('out').value := db_check_out.text;
  Active := True;
  contar_reserva := RecordCount;
  end;
  if (contar_reserva > 0) then
    begin
    l_mensagem.Caption:='Quarto já está reservado!';
    l_mensagem.Font.Color:=clRed;
    timer.Enabled:=true;
    exit;
    end
    else
    begin
    If Application.MessageBox('Gravar registro?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin

    dm.t_reserva.Post;
    l_mensagem.Caption:='Reserva efetuada com sucesso!';
    l_mensagem.Font.Color:=clGreen;
    timer.Enabled:=true;
    db_cpf.Enabled:=false;
    db_check_in.Enabled:=false;
    db_check_out.Enabled:=false;
    db_combo_box.Enabled:=false;
    b_salvar.Enabled:=false;
    b_alterar.Enabled:=true;
    b_cancelar.Enabled:=false;
    b_novo.Enabled:=true;
    b_excluir.Enabled:=true;
    //atualizar grid
    with dm.q_reserva do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from reserva order by check_in');
    Open;
    end;
    end;
  end;
end;
//se veio do botão alterar não verifica se cpf existe
if v_salvar = 2 then
begin

with dm.q_reserva do
  begin
  Active := False;
  SQL.Text := 'select * from reserva where num_quarto = :num and (( :in between check_in and check_out) or ( :out between check_in and check_out) or ( check_in between :in and :out) or ( check_out between :in and :out)) and id <> :i';
  parameters.parambyname('num').value := db_combo_box.text;
  parameters.parambyname('in').value := db_check_in.text;
  parameters.parambyname('out').value := db_check_out.text;
  parameters.parambyname('i').value := id;
  Active := True;
  contar_reserva := RecordCount;
  end;
  if (contar_reserva > 0) then
    begin
    l_mensagem.Caption:='Quarto já está reservado!';
    l_mensagem.Font.Color:=clRed;
    timer.Enabled:=true;
    exit;
    end
    else
    If Application.MessageBox('Confirma alteração?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin
    dm.t_reserva.Post;
    l_mensagem.Caption:='Reserva alterada com sucesso!';
    l_mensagem.Font.Color:=clGreen;
    timer.Enabled:=true;
    db_cpf.Enabled:=false;
    db_check_in.Enabled:=false;
    db_check_out.Enabled:=false;
    db_combo_box.Enabled:=false;
    b_salvar.Enabled:=false;
    b_alterar.Enabled:=true;
    b_cancelar.Enabled:=false;
    b_novo.Enabled:=true;
    b_excluir.Enabled:=true;
  //atualizar grid
    with dm.q_reserva do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from reserva order by check_in');
    Open;
    end;
 end;
end;
end;


procedure Tf_cadastro_reserva.db_combo_box_DropDown(Sender: TObject);
begin
with dm.q_quarto do
begin
  Close;
  SQL.Clear;
  SQL.Add('select distinct(numero) from quarto');
  Open;
  db_combo_box.Clear;
  while not EOF do
  begin
    db_combo_box.Items.Add(Fields[0].AsString);
    Next;
  end;
end;
end;

procedure Tf_cadastro_reserva.dtp_reserva_change(Sender: TObject);
begin
  if (t_cpf.Text <> '') then
  begin

  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva where check_in = :date and cpf_cliente like :cp');
  parameters.parambyname('cp').value := t_cpf.text + '%';
  parameters.parambyname('date').value := datetostr(dtp_reserva.date);
  Open;
  end;
  end;

  if (t_cpf.Text = '') then
  begin

  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva where check_in = :date');
  parameters.parambyname('date').value := datetostr(dtp_reserva.date);
  Open;
  end;
  end;
end;

procedure Tf_cadastro_reserva.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dm.t_reserva.cancel
end;

procedure Tf_cadastro_reserva.FormShow(Sender: TObject);
begin
db_cpf.Enabled:=false;
db_check_in.Enabled:=false;
db_check_out.Enabled:=false;
db_combo_box.Enabled:=false;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva order by check_in');
  Open;
  end;
end;

procedure Tf_cadastro_reserva.g_reserva_cellClick(Column: TColumn);
begin
resultado := dm.q_reserva.fieldbyname('id').AsInteger;
dm.t_reserva.Locate('id', resultado,[]);
end;

procedure Tf_cadastro_reserva.g_reserva_titleClick(Column: TColumn);
begin
if (dm.q_reserva.Sort<>column.FieldName+' ASC') then
dm.q_reserva.Sort:=column.FieldName+' ASC'
else
dm.q_reserva.sort:=column.fieldname+' DESC';
end;

procedure Tf_cadastro_reserva.num_quarto_change(Sender: TObject);
begin
if t_num_quarto.text <> '' then
begin
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva where check_in = :date and num_quarto like :num');
  parameters.parambyname('num').value := t_num_quarto.text + '%';
  parameters.parambyname('date').value := datetostr(dtp_reserva.date);
  Open;
  end;
end
else
begin
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva where check_in = :date');
  parameters.parambyname('date').value := datetostr(dtp_reserva.date);
  Open;
  end;
end;
end;

procedure Tf_cadastro_reserva.OnChange(Sender: TObject);
begin
if t_cpf.text <> '' then
begin
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva where check_in = :date and cpf_cliente like :cp');
  parameters.parambyname('cp').value := t_cpf.text + '%';
  parameters.parambyname('date').value := datetostr(dtp_reserva.date);
  Open;
  end;
end
else
begin
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva where check_in = :date');
  parameters.parambyname('date').value := datetostr(dtp_reserva.date);
  Open;
  end;
end;

end;

procedure Tf_cadastro_reserva.PngSpeedButton1Click(Sender: TObject);
begin
if gbcliente = 0 then
begin
gbcliente := 1;
gb_cliente.Visible:=true;
db_nome.Caption:='';
db_endereco.Caption:='';
db_cidade.Caption:='';
l_cpf.Caption:='';
db_cpf2.Caption:='';
end
else
begin
gbcliente := 0;
db_nome.Caption:='';
db_endereco.Caption:='';
db_cidade.Caption:='';

db_cpf2.Caption:='';
gb_cliente.Visible:=false;
end;
end;

procedure Tf_cadastro_reserva.timerTimer(Sender: TObject);
begin
l_mensagem.caption:='';
l_mensagem.Font.Color:=clBlack;
timer.Enabled:=false;
end;

procedure Tf_cadastro_reserva.t_nomeChange(Sender: TObject);
begin
if t_nome.text <> '' then
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente where nome like '''+t_nome.text+'%''');
  Open;
  resultado2 := dm.q_cliente.fieldbyname('cpf').asstring;
  dm.t_cliente.Locate('cpf',resultado2,[loCaseInsensitive, loPartialKey]);
  fatiarcpf := db_cpf2.caption;
  fatiarcpf := stringReplace(fatiarcpf, '.', '', []);
  fatiarcpf := stringReplace(fatiarcpf, '.', '', []);
  fatiarcpf := stringReplace(fatiarcpf, '-', '', []);
  db_cpf.Text:=fatiarcpf;
  l_cpf.Caption:='CPF:';
  end;
end
else
begin
db_nome.Caption:='';
db_endereco.Caption:='';
db_cidade.Caption:='';
l_cpf.Caption:='';
db_cpf2.Caption:='';
end;

end;

end.
