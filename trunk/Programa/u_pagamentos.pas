unit u_pagamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, PngSpeedButton, StdCtrls, Grids, DBGrids, u_dm;

type
  Tf_pagamentos = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    t_cpf: TEdit;
    b_listar_todos: TPngSpeedButton;
    b_salvar: TPngSpeedButton;
    Label1: TLabel;
    l_total: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure b_listar_todosClick(Sender: TObject);
    procedure b_salvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_pagamentos: Tf_pagamentos;
  total: Currency;
  ver: integer = 0;

implementation

{$R *.dfm}

procedure Tf_pagamentos.b_listar_todosClick(Sender: TObject);
begin
if t_cpf.text = '' then
  begin
  showmessage('CPF não poder ser vazio!');
  exit;
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
end;

procedure Tf_pagamentos.b_salvarClick(Sender: TObject);
begin
if t_cpf.text = '' then
  begin
  showmessage('CPF não poder ser vazio!');
  exit;
  end;
if ver <> 1 then
  begin
  showmessage('Pesquise e Calcule o preço antes de efetuar o pagamento!');
  exit;
  end;
with dm.q_pagamento do
  begin
  Close;
  SQL.Clear;
  sql.Add('update reserva set status = "fechada" where reserva.cpf_cliente = :cp');
  parameters.parambyname('cp').value := t_cpf.text;
  ExecSQL;
  showmessage('Pagamento efetuado com sucesso!');
  ver := 0;
  end;
end;

end.
