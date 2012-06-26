unit u_cadastro_quartos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FileCtrl, Buttons, PngSpeedButton, Mask, DBCtrls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompListbox,
  TeCanvas, Grids, DBGrids, u_dm, DB, pngimage;

type
  Tf_cadastro_quartos = class(TForm)
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
    db_andar: TDBComboBox;
    db_numero: TDBEdit;
    Label6: TLabel;
    b_listar_todos: TPngSpeedButton;
    Label7: TLabel;
    db_info_add: TDBEdit;
    DBGrid1: TDBGrid;
    t_pesquisar: TEdit;
    Image1: TImage;
    timer: TTimer;
    gb_mensagem: TGroupBox;
    l_mensagem: TLabel;
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
    procedure t_pesquisarChange(Sender: TObject);
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
  campo : string;
  id : integer;

implementation

{$R *.dfm}


procedure Tf_cadastro_quartos.b_alterarClick(Sender: TObject);
begin
 with dm.q_quarto do
 begin
 Close;
 SQL.Clear;
 sql.Add('select * from quarto where numero = :num');
 parameters.parambyname('num').value := strtoint(db_numero.text);
Open;
 id := fieldbyname('id').asinteger;
 end;

db_info_add.Enabled:=true;
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
l_mensagem.Caption:='Alterando registro...';
l_mensagem.Font.Color:=clOlive;
timer.Enabled:=true;
dm.t_quarto.Edit;
end;

procedure Tf_cadastro_quartos.b_cancelarClick(Sender: TObject);
begin
dm.t_quarto.Cancel;
db_tipo.Enabled:=false;
db_diaria.Enabled:=false;
db_info_add.Enabled:=false;
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
l_mensagem.Caption:='Cancelado!';
l_mensagem.Font.Color:=clGreen;
timer.Enabled:=true;
end;

procedure Tf_cadastro_quartos.b_excluirClick(Sender: TObject);
begin
If Application.MessageBox('Confirma Exclusão?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
dm.t_quarto.Delete;
l_mensagem.Caption:='Excluído com sucesso!';
l_mensagem.Font.Color:=clRed;
timer.Enabled:=true;
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
db_info_add.Enabled:=true;
b_salvar.Enabled:=true;
b_novo.Enabled:=false;
b_alterar.Enabled:=false;
b_excluir.Enabled:=false;
b_salvar.Enabled:=true;
b_cancelar.Enabled:=true;
//vai servir para o botão salvar saber se verifica se quarto já existe, ou apenas atualiza
v_salvar := 1;
//
l_mensagem.Caption:='Criando novo registro...';
l_mensagem.Font.Color:=clBlue;
timer.Enabled:=true;
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
if (db_andar.Text = '') or (db_andar.Text = '0') then
  begin
l_mensagem.Caption:='O número do andar deve estar entre 1 e 100!';
l_mensagem.Font.Color:=clRed;
timer.Enabled:=true;
  exit;
  end;
if (db_numero.text = '') or (db_numero.text = '0') then
  begin
l_mensagem.Caption:='Número do quarto não pode ser vazio ou 0!';
l_mensagem.Font.Color:=clRed;
timer.Enabled:=true;
  exit;
  end;
if (db_tipo.text = '') then
  begin
l_mensagem.Caption:='Escolha o tipo de acomodação!';
l_mensagem.Font.Color:=clRed;
timer.Enabled:=true;
  exit
  end;
if (db_diaria.text = '') or (db_diaria.text = '0') then
  begin
l_mensagem.Caption:='Valor da diária não pode ser vazio ou R$ 0!';
l_mensagem.Font.Color:=clRed;
timer.Enabled:=true;
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
    l_mensagem.Caption:='Quarto já cadastrado!';
    l_mensagem.Font.Color:=clRed;
    timer.Enabled:=true;
    exit
    end
    else
    begin
    If Application.MessageBox('Gravar registro?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
    begin

    dm.t_quarto.Post;
    l_mensagem.Caption:='Quarto cadastrado com sucesso!';
    l_mensagem.Font.Color:=clGreen;
    timer.Enabled:=true;
    db_tipo.Enabled:=false;
    db_info_add.Enabled:=false;
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

// se veio do botão alterar ele também verifica se o apartamento já existe
if v_salvar = 2 then
begin
If Application.MessageBox('Confirma alteração?','Atenção!',MB_YESNO +
                           MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES Then
begin
with dm.q_quarto do
  begin
  Active := False;
  SQL.Text := 'Select * from quarto where numero = :num and id <> :i ';
  parameters.parambyname('num').value := db_numero.text;
  parameters.parambyname('i').value := id;
  Active := True;
  conta_numero := RecordCount;
  end;
  if (conta_numero > 0) then
    begin
    l_mensagem.Caption:='Quarto já cadastrado!';
    l_mensagem.Font.Color:=clRed;
    timer.Enabled:=true;
    exit
    end
    else
        begin

    dm.t_quarto.Post;
    l_mensagem.Caption:='Quarto alterado com sucesso!';
    l_mensagem.Font.Color:=clGreen;
    timer.Enabled:=true;
      db_tipo.Enabled:=false;
      db_info_add.Enabled:=false;
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
end;

procedure Tf_cadastro_quartos.DBGrid1CellClick(Column: TColumn);
begin
resultado := dm.q_quarto.fieldbyname('numero').asinteger;
dm.t_quarto.Locate('numero',resultado,[]);
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
db_info_add.Enabled:=false;
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

procedure Tf_cadastro_quartos.t_pesquisarChange(Sender: TObject);
begin
if db_pesquisar_por.text = '' then
begin
showmessage('Selecione uma categoria à ser pesquisada!');
exit
end;
if t_pesquisar.text <> '' then
begin
begin
if db_pesquisar_por.text = 'Número do andar' then
begin
campo := 'andar'
end;
if db_pesquisar_por.text = 'Número do quarto' then
begin
campo := 'numero'
end;
if db_pesquisar_por.text = 'Tipo de quarto' then
begin
campo := 'tipo'
end;
if db_pesquisar_por.text = 'Valor da diária' then
begin
campo := 'diaria'
end;
if db_pesquisar_por.text = 'Informações adicionais' then
begin
campo := 'info_add'
end;
if db_pesquisar_por.text = 'ID' then
begin
campo := 'id'
end;
end;
 with dm.q_quarto do
 begin
 Close;
 SQL.Clear;
 sql.Add('select * from quarto where '+campo+' like '''+t_pesquisar.text+'%''');
Open;
 resultado := fieldbyname('numero').asinteger;
 dm.t_cliente.Locate('numero',resultado,[loCaseInsensitive, loPartialKey]);
 end;
end
else
begin
 with dm.q_quarto do
 begin
 Close;
 SQL.Clear;
 sql.Add('select * from quarto order by numero');
 Open;
 end;
end;
 end;

end.
