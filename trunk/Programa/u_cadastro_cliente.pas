unit u_cadastro_cliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, ExtCtrls, Buttons, PngSpeedButton, Grids,
  DBGrids, u_dm, DB;

type
  Tf_cadastro_cliente = class(TForm)
    db_cpf: TDBEdit;
    db_nome: TDBEdit;
    db_telefone_residencial: TDBEdit;
    db_cidade: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    db_estado: TDBComboBox;
    b_novo: TPngSpeedButton;
    b_alterar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    b_cancelar: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    Panel1: TPanel;
    group_pesquisar: TGroupBox;
    DBGrid1: TDBGrid;
    t_cpf: TEdit;
    t_nome: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    b_listar_todos: TPngSpeedButton;
    Label8: TLabel;
    db_telefone_celular: TDBEdit;
    db_cep: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    db_email: TDBEdit;
    Label11: TLabel;
    db_complemento: TDBEdit;
    db_endereco: TDBEdit;
    Label12: TLabel;
    db_bairro: TDBEdit;
    Label13: TLabel;
    Label14: TLabel;
    db_pais: TDBComboBox;
    procedure b_novoClick(Sender: TObject);
    procedure b_salvarClick(Sender: TObject);
    procedure b_alterarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_cancelarClick(Sender: TObject);
    procedure b_fecharClick(Sender: TObject);
    procedure t_nomeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure b_listar_todosClick(Sender: TObject);
    procedure t_cpfChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_cliente: Tf_cadastro_cliente;
  resultado : string;
  v_salvar : integer;
  conta_cpf : integer;
  id : integer;

implementation

{$R *.dfm}

procedure Tf_cadastro_cliente.b_alterarClick(Sender: TObject);
begin
 with dm.q_cliente do
 begin
 Close;
 SQL.Clear;
 sql.Add('select * from cliente where cpf = :cp');
 parameters.parambyname('cp').value := db_cpf.text;
Open;
 id := fieldbyname('id').asinteger;
 end;
db_nome.Enabled:=true;
db_cpf.Enabled:=true;
db_bairro.enabled:=true;
db_cep.enabled:=true;
db_complemento.enabled:=true;
db_email.enabled:=true;
db_endereco.enabled:=true;
db_pais.enabled:=true;
db_telefone_celular.enabled:=true;
db_telefone_residencial.enabled:=true;
db_cidade.Enabled:=true;
db_estado.Enabled:=true;
b_salvar.Enabled:=true;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_novo.Enabled:=false;
b_cancelar.Enabled:=true;
//vai servir para o botão salvar saber se verifica se cpf já existe, ou apenas atualiza
v_salvar := 2;
//
dm.t_cliente.Edit;
end;

procedure Tf_cadastro_cliente.b_cancelarClick(Sender: TObject);
begin
dm.t_cliente.Cancel;
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_bairro.enabled:=false;
db_cep.enabled:=false;
db_complemento.enabled:=false;
db_email.enabled:=false;
db_endereco.enabled:=false;
db_pais.enabled:=false;
db_telefone_celular.enabled:=false;
db_telefone_residencial.enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;

end;

procedure Tf_cadastro_cliente.b_excluirClick(Sender: TObject);
begin
If Application.MessageBox('Confirma Exclusão?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_cliente.Delete;
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_bairro.enabled:=false;
db_cep.enabled:=false;
db_complemento.enabled:=false;
db_email.enabled:=false;
db_endereco.enabled:=false;
db_pais.enabled:=false;
db_telefone_celular.enabled:=false;
db_telefone_residencial.enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;
end;

procedure Tf_cadastro_cliente.b_fecharClick(Sender: TObject);
begin
dm.t_cliente.Cancel;
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_bairro.enabled:=false;
db_cep.enabled:=false;
db_complemento.enabled:=false;
db_email.enabled:=false;
db_endereco.enabled:=false;
db_pais.enabled:=false;
db_telefone_celular.enabled:=false;
db_telefone_residencial.enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;

close;
end;

procedure Tf_cadastro_cliente.b_listar_todosClick(Sender: TObject);
begin
dm.t_cliente.cancel;
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;

procedure Tf_cadastro_cliente.b_novoClick(Sender: TObject);
begin
db_nome.Enabled:=true;
db_cpf.Enabled:=true;
db_bairro.enabled:=true;
db_cep.enabled:=true;
db_complemento.enabled:=true;
db_email.enabled:=true;
db_endereco.enabled:=true;
db_pais.enabled:=true;
db_telefone_celular.enabled:=true;
db_telefone_residencial.enabled:=true;
db_cidade.Enabled:=true;
db_estado.Enabled:=true;
b_novo.Enabled:=false;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_salvar.Enabled:=true;
b_cancelar.Enabled:=true;
//vai servir para o botão salvar saber se verifica se cpf já existe, ou apenas atualiza
v_salvar := 1;
//
dm.t_cliente.cancel;
dm.t_cliente.append;
db_cpf.SetFocus;
end;

procedure Tf_cadastro_cliente.b_salvarClick(Sender: TObject);
begin
if db_nome.text = '' then
  begin
  showmessage('Nome não pode ser vazio!');
  exit;
  end;
if db_cpf.text = '' then
  begin
  showmessage('CPF não pode ser vazio!');
  exit;
  end;
//se veio do botão novo verifica se cpf já existe
if v_salvar = 1 then
begin
with dm.q_cliente do
  begin
  Active := False;
  SQL.Text := 'Select * from cliente where cpf = :cp';
  parameters.parambyname('cp').value := db_cpf.text;
  Active := True;
  conta_cpf := RecordCount;
  end;
  if (conta_cpf > 0) then
    begin
    showmessage('CPF já cadastrado!');
    exit
    end
    else
    begin
    If Application.MessageBox('Gravar registro?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin

    dm.t_cliente.Post;
    showmessage('Cadastro efetuado com sucesso!');
    db_nome.Enabled:=false;
    db_cpf.Enabled:=false;
    db_bairro.enabled:=false;
    db_cep.enabled:=false;
    db_complemento.enabled:=false;
    db_email.enabled:=false;
    db_endereco.enabled:=false;
    db_pais.enabled:=false;
    db_telefone_celular.enabled:=false;
    db_telefone_residencial.enabled:=false;
    db_cidade.Enabled:=false;
    db_estado.Enabled:=false;
    b_salvar.Enabled:=false;
    b_alterar.Enabled:=true;
    b_cancelar.Enabled:=false;
    b_novo.Enabled:=true;
    b_excluir.Enabled:=true;
    //atualizar grid
    with dm.q_cliente do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from cliente order by nome');
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
with dm.q_cliente do
  begin
  Active := False;
  SQL.Text := 'Select * from cliente where cpf = :cp and id <> :i ';
  parameters.parambyname('cp').value := db_cpf.text;
  parameters.parambyname('i').value := id;
  Active := True;
  conta_cpf := RecordCount;
  end;
  if (conta_cpf > 0) then
    begin
    showmessage('CPF já cadastrado!');
    exit
    end
    else
    begin
dm.t_cliente.Post;
showmessage('Cadastro alterado com sucesso!');
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_bairro.enabled:=false;
db_cep.enabled:=false;
db_complemento.enabled:=false;
db_email.enabled:=false;
db_endereco.enabled:=false;
db_pais.enabled:=false;
db_telefone_celular.enabled:=false;
db_telefone_residencial.enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_alterar.Enabled:=true;
b_cancelar.Enabled:=false;
b_novo.Enabled:=true;
b_excluir.Enabled:=true;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;
end;
end;
end;


procedure Tf_cadastro_cliente.DBGrid1CellClick(Column: TColumn);
begin
resultado := dm.q_cliente.fieldbyname('cpf').asstring;
dm.t_cliente.Locate('cpf',resultado,[loCaseInsensitive, loPartialKey]);
end;

procedure Tf_cadastro_cliente.DBGrid1TitleClick(Column: TColumn);
begin
if (dm.q_cliente.Sort<>column.FieldName+' ASC') then
dm.q_cliente.Sort:=column.FieldName+' ASC'
else
dm.q_cliente.sort:=column.fieldname+' DESC';
end;

procedure Tf_cadastro_cliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dm.t_cliente.cancel;
end;

procedure Tf_cadastro_cliente.FormShow(Sender: TObject);
begin
db_nome.Enabled:=false;
db_cpf.Enabled:=false;
db_bairro.enabled:=false;
db_cep.enabled:=false;
db_complemento.enabled:=false;
db_email.enabled:=false;
db_endereco.enabled:=false;
db_pais.enabled:=false;
db_telefone_celular.enabled:=false;
db_telefone_residencial.enabled:=false;
db_cidade.Enabled:=false;
db_estado.Enabled:=false;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;

end;

procedure Tf_cadastro_cliente.t_cpfChange(Sender: TObject);
begin
if t_cpf.text <> '' then
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente where cpf like '''+t_cpf.text+'%''');
  Open;
  resultado := dm.q_cliente.fieldbyname('cpf').asstring;
  dm.t_cliente.Locate('cpf',resultado,[loCaseInsensitive, loPartialKey]);
  end;
end
else
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;

end;

procedure Tf_cadastro_cliente.t_nomeChange(Sender: TObject);
begin
if t_nome.text <> '' then
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente where nome like '''+t_nome.text+'%''');
  Open;
  resultado := dm.q_cliente.fieldbyname('cpf').asstring;
  dm.t_cliente.Locate('cpf',resultado,[loCaseInsensitive, loPartialKey]);
  end;
end
else
begin
  with dm.q_cliente do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from cliente order by nome');
  Open;
  end;
end;


end;

end.
