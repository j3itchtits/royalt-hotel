unit u_cadastro_reserva;

interface

uses
  u_dm, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ComCtrls, Buttons,
  PngSpeedButton, ExtCtrls;

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
    db_cpf: TDBEdit;
    db_check_in: TDBEdit;
    db_check_out: TDBEdit;
    db_combo_box: TDBComboBox;
    b_novo: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    b_alterar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    b_cancelar: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    Panel1: TPanel;
    b_listar_todos: TPngSpeedButton;
    t_cpf: TEdit;
    Label6: TLabel;
    procedure OnDropDown_db_combo_box(Sender: TObject);
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_reserva: Tf_cadastro_reserva;
  v_salvar : integer;
  conta_cpf : integer;
  resultado : integer;

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
//
dm.t_reserva.Edit;
end;

procedure Tf_cadastro_reserva.b_cancelarClick(Sender: TObject);
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
dm.t_reserva.cancel;
dm.t_reserva.append;
db_cpf.SetFocus;
end;

procedure Tf_cadastro_reserva.b_salvarClick(Sender: TObject);
begin
if db_cpf.text = '' then
  begin
  showmessage('CPF não poder ser vazio!');
  exit;
  end;
//if db_check_in.text = '' then
  //begin
  //showmessage('Data de Entrada não poder ser vazio!');
  //exit;
  //end;
if v_salvar = 1 then
begin
with dm.q_reserva do
  begin
  Active := False;
  SQL.Text := 'Select * from cliente where id_quarto = :id and check_in = :in';
  parameters.parambyname('id').value := db_combo_box.text;
  parameters.parambyname('in').value := db_check_in.text;
  Active := True;
  conta_cpf := RecordCount;
  end;
  if (conta_cpf > 0) then
    begin
    showmessage('Quarto já está reservado!');
    exit;
    end
    else
    begin
    If Application.MessageBox('Gravar registro?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin

    dm.t_reserva.Post;
    showmessage('Reserva efetuada com sucesso!');
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
If Application.MessageBox('Confirma alteração?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_cliente.Post;
showmessage('Reserva alterada com sucesso!');
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
  sql.Add('select * from reserva order by checkk_in');
  Open;
  end;
end;
end;

end;

procedure Tf_cadastro_reserva.dtp_reserva_change(Sender: TObject);
begin
  //with dm.q_reserva do
  //begin
  //Close;
  //SQL.Clear;
  //sql.Add('select * from reserva where check_in like '''+dtp_reserva.text+'%''');
  //Open;
  //resultado := dm.q_cliente.fieldbyname('id').asinteger;
  //dm.t_cliente.Locate('id',resultado,[loCaseInsensitive, loPartialKey]);
  //end;
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

procedure Tf_cadastro_reserva.OnChange(Sender: TObject);
begin
if t_cpf.text <> '' then
begin
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva where cpf like '''+t_cpf.text+'%''');
  Open;
  resultado := dm.q_reserva.fieldbyname('id').asinteger;
  //dm.t_reserva.Locate('id',resultado,[loCaseInsensitive, loPartialKey]);
  end;
end
else
begin
  with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from reserva order by check_in');
  Open;
  end;
end;

end;

procedure Tf_cadastro_reserva.OnDropDown_db_combo_box(Sender: TObject);
begin
with dm.q_quarto do
begin
  Close;
  SQL.Clear;
  SQL.Add('select distinct(id) from quarto');
  Open;
  db_combo_box.Clear;
  while not EOF do
  begin
    db_combo_box.Items.Add(Fields[0].AsString);
    Next;
  end;
end;
end;

end.
