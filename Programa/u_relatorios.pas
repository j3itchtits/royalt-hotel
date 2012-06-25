unit u_relatorios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, PngSpeedButton, DBCtrls, ComCtrls, db,
   u_dm;

type
  Tf_relatorios = class(TForm)
    gb_cliente: TGroupBox;
    gb_pesquisar_cliente: TGroupBox;
    db_nome: TDBText;
    db_endereco: TDBText;
    db_cidade: TDBText;
    Label8: TLabel;
    l_cpf: TLabel;
    db_cpf2: TDBText;
    t_nome: TEdit;
    PngSpeedButton1: TPngSpeedButton;
    rb_todos_cliente: TRadioButton;
    rb_cpf: TRadioButton;
    t_cpf: TEdit;
    gb_quarto: TGroupBox;
    rb_todos_quarto: TRadioButton;
    rb_tipo: TRadioButton;
    rb_nquarto: TRadioButton;
    t_quarto: TEdit;
    cb_tipo: TComboBox;
    gb_data: TGroupBox;
    rb_todos_data: TRadioButton;
    rb_data_em: TRadioButton;
    rb_data_entre: TRadioButton;
    dtp1: TDateTimePicker;
    dtp2: TDateTimePicker;
    dtp3: TDateTimePicker;
    Label1: TLabel;
    gb_ordenar: TGroupBox;
    rb_ordenar_cpf: TRadioButton;
    rb_ordenar_nome: TRadioButton;
    rb_ordenar_nquarto: TRadioButton;
    rb_ordenar_tipo: TRadioButton;
    rb_ordenar_checkin: TRadioButton;
    rb_ordenar_checkout: TRadioButton;
    bt_ok: TPngSpeedButton;
    procedure bt_okClick(Sender: TObject);
    procedure PngSpeedButton1Click(Sender: TObject);
    procedure t_nomeChange(Sender: TObject);
    procedure dtp1Click(Sender: TObject);
    procedure dtp2Click(Sender: TObject);
    procedure dtp3Click(Sender: TObject);
    procedure cb_tipoClick(Sender: TObject);
    procedure t_quartoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_relatorios: Tf_relatorios;
  gbcliente : integer;
  fatiarcpf : string;
  resultado2 : string;
  vcliente : string;
  vquarto : string;
  vordem : string;
  vdata1 : string;
  vdata01 : tdate;
  vdata02 : tdate;
  vdata03 : tdate;

implementation

{$R *.dfm}

procedure Tf_relatorios.bt_okClick(Sender: TObject);
begin
  vcliente:= '';
  vquarto := '';
  vordem := '';
  vdata1 := '';
  vdata01 := dtp1.date;
  vdata02 := dtp2.date;
  vdata03 := dtp3.date;
  dtp1.Date:=01/01/1900;
  dtp2.Date:=01/01/1900;
  dtp3.Date:=01/01/1900;

if rb_todos_cliente.Checked=true then
  begin
  t_cpf.text := '0';
  vcliente:= 'reserva.cpf_cliente <> :cpf and ';
  end;
if rb_cpf.Checked=true then
  begin
  vcliente:= 'reserva.cpf_cliente = :cpf and ';
  end;

if rb_todos_quarto.Checked=true then
  begin
  cb_tipo.text:='0';
  t_quarto.Text:='0';
  vquarto:= '(reserva.num_quarto <> :quarto) and (quarto.tipo <> :tipo) and ' ;
  end;
if rb_tipo.Checked=true then
  begin
  t_quarto.Text:='0';
  vquarto:= 'quarto.tipo = :tipo and reserva.num_quarto <> :quarto and ' ;
  end;
 if rb_nquarto.Checked=true then
  begin
  cb_tipo.text:='0';
  vquarto:= 'quarto.tipo <> :tipo and reserva.num_quarto = :quarto and ' ;
  end;


if rb_todos_data.Checked=true then
  begin
  vdata1 := ' ((reserva.check_in > :data1) or (reserva.check_in > :data2) or (reserva.check_in > :data3))';
  end;
if rb_data_em.Checked=true then
  begin
  dtp1.date:=vdata01;
  dtp2.date:=vdata01;
  dtp3.date:=vdata01;
  vdata1 := '(( :data1 between reserva.check_in and reserva.check_out) or ( :data2 between reserva.check_in and reserva.check_out) or ( :data3 between reserva.check_in and reserva.check_out))';
  end;
if rb_data_entre.Checked=true then
  begin
  dtp1.date:=vdata02;
  dtp2.date:=vdata02;
  dtp3.date:=vdata03;
  dtp1.Date:=dtp2.Date;
  vdata1 := '(( :data1 between reserva.check_in and reserva.check_out) or ( :data3 between reserva.check_in and reserva.check_out) or ( reserva.check_in between :data2 and :data3) or ( reserva.check_out between :data1 and :data3))';
  end;

 if rb_ordenar_cpf.Checked=true then
  begin
  vordem:= ' order by reserva.cpf_cliente' ;
  end;

 if rb_ordenar_nome.Checked=true then
  begin
  vordem:= ' order by cliente.nome' ;
  end;

 if rb_ordenar_nquarto.Checked=true then
  begin
  vordem:= ' order by reserva.num_quarto' ;
  end;

 if rb_ordenar_tipo.Checked=true then
  begin
  vordem:= ' order by quarto.tipo' ;
  end;

 if rb_ordenar_checkin.Checked=true then
  begin
  vordem:= ' order by reserva.check_in' ;
  end;

 if rb_ordenar_checkout.Checked=true then
  begin
  vordem:= ' order by reserva.check_out' ;
  end;

 with dm.q_relatorios do
 begin
  Active:= false;
  SQL.Clear;
  sql.add('select reserva.cpf_cliente, cliente.nome, reserva.num_quarto, quarto.tipo, reserva.check_in, reserva.check_out from reserva, quarto, cliente where reserva.num_quarto = quarto.numero and reserva.cpf_cliente = cliente.cpf and reserva.status = ''aberta'' and '+vcliente+''+vquarto+''+vdata1+''+vordem+'');
  Parameters.ParamByName('cpf').Value:= t_cpf.text;
  Parameters.ParamByName('quarto').Value:= t_quarto.text;
  Parameters.ParamByName('tipo').Value:=cb_tipo.text;
  Parameters.ParamByName('data1').Value:=datetostr(dtp1.Date);
  Parameters.ParamByName('data2').Value:=datetostr(dtp2.Date);
  Parameters.ParamByName('data3').Value:=datetostr(dtp3.Date);
  Active:= true;
 end;

dm.rvproject.Execute;
 t_cpf.text := '';
 t_quarto.Text := '';
 cb_tipo.Text := '';
 dtp1.date := vdata01;
 dtp2.date := vdata02;
 dtp3.date := vdata03;
end;

procedure Tf_relatorios.cb_tipoClick(Sender: TObject);
begin
rb_tipo.Checked:=true;
end;

procedure Tf_relatorios.dtp1Click(Sender: TObject);
begin
rb_data_em.Checked:=true;
end;

procedure Tf_relatorios.dtp2Click(Sender: TObject);
begin
rb_data_entre.Checked:=true;
end;

procedure Tf_relatorios.dtp3Click(Sender: TObject);
begin
rb_data_entre.Checked:=true;
end;

procedure Tf_relatorios.PngSpeedButton1Click(Sender: TObject);
begin
if gbcliente = 0 then
begin
gbcliente := 1;
gb_pesquisar_cliente.Visible:=true;
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
gb_pesquisar_cliente.Visible:=false;
end;
end;

procedure Tf_relatorios.t_nomeChange(Sender: TObject);
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
rb_cpf.Checked:=true;
end;

procedure Tf_relatorios.t_quartoClick(Sender: TObject);
begin
rb_nquarto.Checked:=true;
end;

end.
