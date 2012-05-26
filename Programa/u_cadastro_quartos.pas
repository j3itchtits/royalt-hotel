unit u_cadastro_quartos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FileCtrl, Buttons, PngSpeedButton, Mask, DBCtrls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompListbox,
  TeCanvas, Grids, DBGrids, u_dm;

type
  Tf_cadastro_quartos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    db_tipo: TDBComboBox;
    db_diaria: TDBEdit;
    b_fechar: TPngSpeedButton;
    b_novo: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    b_alterar: TPngSpeedButton;
    b_excluir: TPngSpeedButton;
    b_cancelar: TPngSpeedButton;
    group_pesquisar: TGroupBox;
    db_pesquisar_por: TComboBox;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    db_andar: TDBComboBox;
    db_numero: TDBEdit;
    db_pesquisar: TDBEdit;
    Label6: TLabel;
    b_listar_todos: TPngSpeedButton;
    procedure b_novoClick(Sender: TObject);
    procedure b_salvarClick(Sender: TObject);
    procedure b_alterarClick(Sender: TObject);
    procedure b_excluirClick(Sender: TObject);
    procedure b_cancelarClick(Sender: TObject);
    procedure b_fecharClick(Sender: TObject);
    procedure b_listar_todosClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_quartos: Tf_cadastro_quartos;
  v_salvar : integer;
  conta_numero : integer;
  resultado : integer;

implementation

{$R *.dfm}


procedure Tf_cadastro_quartos.b_alterarClick(Sender: TObject);
begin
db_tipo.Enabled:=true;
db_diaria.Enabled:=true;
db_andar.Enabled:=true;
db_numero.Enabled:=true;
b_salvar.Enabled:=true;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_novo.Enabled:=false;
b_cancelar.Enabled:=true;
//vai servir para o botão salvar saber se verifica se quarto já existe, ou apenas atualiza
v_salvar := 2;
//
dm.t_quarto.Edit;
end;

procedure Tf_cadastro_quartos.b_cancelarClick(Sender: TObject);
begin
dm.t_quarto.Cancel;
db_tipo.Enabled:=false;
db_diaria.Enabled:=false;
db_andar.Enabled:=false;
db_numero.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_quarto do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from quarto order by numero');
  Open;
  end;
end;

procedure Tf_cadastro_quartos.b_excluirClick(Sender: TObject);
begin
If Application.MessageBox('Confirma Exclusão?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_quarto.Delete;
db_tipo.Enabled:=false;
db_diaria.Enabled:=false;
db_andar.Enabled:=false;
db_numero.Enabled:=false;
  //atualizar grid
  with dm.q_quarto do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from quarto order by numero');
  Open;
  end;
end;
end;

procedure Tf_cadastro_quartos.b_fecharClick(Sender: TObject);
begin
dm.t_quarto.Cancel;
db_tipo.Enabled:=false;
db_diaria.Enabled:=false;
db_andar.Enabled:=false;
db_numero.Enabled:=false;
b_salvar.Enabled:=false;
b_excluir.Enabled:=true;
b_alterar.Enabled:=true;
b_novo.Enabled:=true;
b_cancelar.Enabled:=false;

close;
end;

procedure Tf_cadastro_quartos.b_listar_todosClick(Sender: TObject);
begin
dm.t_quarto.cancel;
  with dm.q_quarto do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from quarto order by numero');
  Open;
  end;
end;

procedure Tf_cadastro_quartos.b_novoClick(Sender: TObject);
begin
db_tipo.Enabled:=true;
db_diaria.Enabled:=true;
db_andar.Enabled:=true;
db_numero.Enabled:=true;
b_salvar.Enabled:=true;
b_novo.Enabled:=false;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_salvar.Enabled:=true;
b_cancelar.Enabled:=true;
//vai servir para o botão salvar saber se verifica se quarto já existe, ou apenas atualiza
v_salvar := 1;
//
dm.t_quarto.cancel;
dm.t_quarto.append;
db_andar.SetFocus;
with dm.q_quarto do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from quarto order by numero');
  Open;
  end;
end;

procedure Tf_cadastro_quartos.b_salvarClick(Sender: TObject);
begin
if (db_numero.text = '') or (db_numero.text = '0') then
  begin
  showmessage('Número do quarto não pode ser vazio!');
  exit;
  end;
if (db_diaria.text = '') or (db_diaria.text = '0') then
  begin
  showmessage('Valor da diária não pode ser vazio ou R$ 0!');
  exit;
  end;
//se veio do botão novo verifica se número do quarto já existe
if v_salvar = 1 then
begin
with dm.q_quarto do
  begin
  Active := False;
  SQL.Text := 'Select * from quarto where numero = :num';
  parameters.parambyname('num').value := db_numero.text;
  Active := True;
  conta_numero := RecordCount;
  end;
  if (conta_numero > 0) then
    begin
    showmessage('Quarto já cadastrado!');
    exit
    end
    else
    begin
    If Application.MessageBox('Gravar registro?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin

    dm.t_quarto.Post;
    showmessage('Quarto cadastrado com sucesso!');
    db_tipo.Enabled:=false;
    db_diaria.Enabled:=false;
    db_andar.Enabled:=false;
    db_numero.Enabled:=false;
    b_salvar.Enabled:=false;
    b_alterar.Enabled:=true;
    b_cancelar.Enabled:=false;
    b_novo.Enabled:=true;
    b_excluir.Enabled:=true;
    //atualizar grid
    with dm.q_quarto do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto order by numero');
    Open;
    end;
   end;
   end;
   end;

// se veio do botão alterar ele não verifica se o apartamento já existe
if v_salvar = 2 then
begin
If Application.MessageBox('Confirma alteração?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_quarto.Post;
showmessage('Quarto alterado com sucesso!');
db_tipo.Enabled:=false;
db_diaria.Enabled:=false;
db_andar.Enabled:=false;
db_numero.Enabled:=false;
b_salvar.Enabled:=false;
b_alterar.Enabled:=true;
b_cancelar.Enabled:=false;
b_novo.Enabled:=true;
b_excluir.Enabled:=true;
// atualizar grid
  with dm.q_quarto do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from quarto order by numero');
  Open;
  end;
end;
end;
end;

procedure Tf_cadastro_quartos.DBGrid1CellClick(Column: TColumn);
begin
resultado := dm.q_quarto.fieldbyname('numero').asinteger;
dm.t_cliente.Locate('numero',resultado,[]);
end;

procedure Tf_cadastro_quartos.DBGrid1TitleClick(Column: TColumn);
begin
if (dm.q_quarto.Sort<>column.FieldName+' ASC') then
dm.q_quarto.Sort:=column.FieldName+' ASC'
else
dm.q_quarto.sort:=column.fieldname+' DESC';
end;


procedure Tf_cadastro_quartos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dm.t_quarto.Cancel;
end;

procedure Tf_cadastro_quartos.FormShow(Sender: TObject);
begin
db_tipo.Enabled:=false;
db_diaria.Enabled:=false;
db_andar.Enabled:=false;
db_numero.Enabled:=false;
b_salvar.Enabled:=false;
b_cancelar.Enabled:=false;
  //atualizar grid
  with dm.q_quarto do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from quarto order by numero');
  Open;
  end;

end;

end.
