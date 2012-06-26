unit u_pagamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, PngSpeedButton, StdCtrls, Grids, DBGrids, u_dm, DBCtrls, db,
  ExtCtrls, pngimage;

type
  Tf_pagamentos = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    t_cpf: TEdit;
    b_listar_todos: TPngSpeedButton;
    b_pagar: TPngSpeedButton;
    Label1: TLabel;
    l_total: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    gb_cliente: TGroupBox;
    db_nome: TDBText;
    db_endereco: TDBText;
    db_cidade: TDBText;
    Label8: TLabel;
    l_cpf: TLabel;
    db_cpf2: TDBText;
    t_nome: TEdit;
    b_voltar: TPngSpeedButton;
    Image1: TImage;
    PngSpeedButton1: TPngSpeedButton;
    timer: TTimer;
    gb_mensagem: TGroupBox;
    l_mensagem: TLabel;
    procedure b_listar_todosClick(Sender: TObject);
    procedure b_pagarClick(Sender: TObject);
    procedure formShow(Sender: TObject);
    procedure t_nomeChange(Sender: TObject);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure b_voltarClick(Sender: TObject);
    procedure timerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_pagamentos: Tf_pagamentos;
  total: Currency;
  ver: integer = 0;
  resultado : string;
  fatiarcpf : string;
  gbcliente : integer;

implementation

{$R *.dfm}

procedure Tf_pagamentos.b_listar_todosClick(Sender: TObject);
begin
if t_cpf.text = '' then
  begin
  l_mensagem.Caption:='CPF não poder ser vazio!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
with dm.q_reserva do
  begin
  Close;
  SQL.Clear;
  SQL.Add('Select cpf_cliente from reserva where cpf_cliente = :cp and status = "aberta"');
  parameters.parambyname('cp').value := t_cpf.text;
  Open;
  if RecordCount = 0 then
    begin
    l_mensagem.Caption:='CPF não possui reserva aberta!';
    l_mensagem.Font.Color:=clRed;
    timer.Enabled:=true;
    exit;
    end;
  end;
with dm.q_pagamento do
  begin
  Close;
  SQL.Clear;
  sql.Add('Select reserva.cpf_cliente, reserva.num_quarto, quarto.diaria, reserva.check_in,reserva.check_out, ((reserva.check_out - reserva.check_in)*quarto.diaria) from reserva, quarto ');
  sql.Add('where quarto.numero = reserva.num_quarto and reserva.status = "aberta" and reserva.cpf_cliente = :cp');
  parameters.parambyname('cp').value := t_cpf.text;
  Open;
  total := 0;
  while not EOF do
  begin
    total := total + Fields[5].AsCurrency;
    Next;
  end;
  end;
  l_total.Caption := FloatToStr( total );
  ver := 1;
  b_pagar.Enabled:=true;
end;

procedure Tf_pagamentos.b_pagarClick(Sender: TObject);
begin
if t_cpf.text = '' then
  begin
  l_mensagem.Caption:='CPF não poder ser vazio!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
if ver <> 1 then
  begin
  l_mensagem.Caption:='Pesquise e Calcule o preço antes de efetuar o pagamento!';
  l_mensagem.Font.Color:=clRed;
  timer.Enabled:=true;
  exit;
  end;
with dm.q_pagamento do
  begin
  Close;
  SQL.Clear;
  sql.Add('update reserva set status = "fechada" where reserva.cpf_cliente = :cp');
  parameters.parambyname('cp').value := t_cpf.text;
  ExecSQL;
  l_mensagem.Caption:='Pagamento efetuado com sucesso!';
  l_mensagem.Font.Color:=clGreen;
  timer.Enabled:=true;
  ver := 0;
  end;
t_cpf.Text := '';
b_pagar.Enabled:=false;
end;

procedure Tf_pagamentos.b_voltarClick(Sender: TObject);
begin
close;
end;

procedure Tf_pagamentos.formShow(Sender: TObject);
begin
t_cpf.Text := '';
b_pagar.Enabled:=false;
end;



procedure Tf_pagamentos.PngSpeedButton1Click(Sender: TObject);
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

procedure Tf_pagamentos.timerTimer(Sender: TObject);
begin
l_mensagem.caption:='';
l_mensagem.Font.Color:=clBlack;
timer.Enabled:=false;
end;

procedure Tf_pagamentos.t_nomeChange(Sender: TObject);
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
  fatiarcpf := db_cpf2.caption;
  fatiarcpf := stringReplace(fatiarcpf, '.', '', []);
  fatiarcpf := stringReplace(fatiarcpf, '.', '', []);
  fatiarcpf := stringReplace(fatiarcpf, '-', '', []);
  t_cpf.Text:=fatiarcpf;
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
