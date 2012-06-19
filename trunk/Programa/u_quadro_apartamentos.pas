unit u_quadro_apartamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, PngSpeedButton, Buttons, u_dm, ComCtrls, DBCtrls,
  Grids, DBGrids, pngimage;

type
  Tf_quadro_apartamentos = class(TForm)
    rg_data: TRadioGroup;
    DateTimePicker1: TDateTimePicker;
    rg_ocupacao: TRadioGroup;
    DBGrid1: TDBGrid;
    b_listar: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    Image1: TImage;
    db_classificar_quarto: TComboBox;
    rg_tipo: TRadioGroup;
    procedure b_fecharClick(Sender: TObject);
    procedure b_listarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_quadro_apartamentos: Tf_quadro_apartamentos;
  quarto: tpngspeedbutton;
  nome : tlabel;
  i,n,j : integer;
  numero, andar, ocupado, id, tipo : string;


implementation

{$R *.dfm}









procedure Tf_quadro_apartamentos.b_fecharClick(Sender: TObject);
begin
close;
end;

procedure Tf_quadro_apartamentos.b_listarClick(Sender: TObject);
begin
 //hoje, todos, todos (000)
 if (rg_data.ItemIndex = 0) and (rg_tipo.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 0) then
  begin
  with dm.q_quadro do
  begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto');
    Open;
  end;
  end;

 //hoje, todos, livres (001)
 if (rg_data.ItemIndex = 0) and (rg_tipo.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 1) then
  begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where quarto.numero not in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by numero');
    parameters.parambyname('data').value := date();
    ExecSQL;
    Active:=true;
  end;
  end;

 //hoje, todos, ocupados (002)
 if (rg_data.ItemIndex = 0) and (rg_tipo.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 2) then
 begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where quarto.numero in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by quarto.numero');
    parameters.ParamByName('data').Value :=date();
    ExecSQL;
    Active:=true;
  end;
  end;

 //hoje, por tipo, todos (010)
 if (rg_data.ItemIndex = 0) and (rg_tipo.ItemIndex = 1) and (rg_ocupacao.ItemIndex = 0) then
  begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where tipo =:tipo order by numero');
    parameters.ParamByName('tipo').Value := db_classificar_quarto.text;
    ExecSQL;
    Active:=true;
  end;
  end;

 //hoje, por tipo, livres (011)
 if (rg_data.ItemIndex = 0) and (rg_tipo.ItemIndex = 1) and (rg_ocupacao.ItemIndex = 1)then
  begin
    with dm.q_quadro do
    begin
      Active:=false;
      SQL.Clear;
      sql.Add('select * from quarto where quarto.tipo like '''+db_classificar_quarto.Text+'%'' and quarto.numero not in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by numero');
      parameters.ParamByName('data').Value :=date();
      ExecSQL;
      Active:=true;
    end;
  end;

  //hoje, por tipo, ocupados (012)
  if (rg_data.ItemIndex = 0) and (rg_tipo.ItemIndex = 1) and (rg_ocupacao.ItemIndex = 2)then
  begin
    with dm.q_quadro do
    begin
      Active:=false;
      SQL.Clear;
      sql.Add('select * from quarto where quarto.tipo like '''+db_classificar_quarto.Text+'%'' and quarto.numero in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by numero');
      parameters.ParamByName('data').Value :=date();
      ExecSQL;
      Active:=true;
    end;
  end;

  //por data, todos, todos (100)
  if (rg_data.ItemIndex = 1) and (rg_tipo.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 0)then
  begin
  with dm.q_quadro do
  begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto');
    Open;
  end;
  end;

  //por data, todos, livres (101)
  if (rg_data.ItemIndex = 1) and (rg_tipo.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 1) then
  begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where quarto.numero not in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by numero');
    parameters.parambyname('data').value := datetostr(DateTimePicker1.date);
    ExecSQL;
    Active:=true;
  end;
  end;

  //por data, todos, ocupados (102)
  if (rg_data.ItemIndex = 1) and (rg_tipo.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 2) then
  begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where quarto.numero in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by numero');
    parameters.parambyname('data').value := datetostr(DateTimePicker1.date);
    ExecSQL;
    Active:=true;
  end;
  end;

  //por data, por tipo, todos (110)
  if (rg_data.ItemIndex = 1) and (rg_tipo.ItemIndex = 1) and (rg_ocupacao.ItemIndex = 0) then
  begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where tipo =:tipo order by numero');
    parameters.ParamByName('tipo').Value := db_classificar_quarto.text;
    ExecSQL;
    Active:=true;
  end;
  end;

  //por data, por tipo, livres (111)
  if (rg_data.ItemIndex = 1) and (rg_tipo.ItemIndex = 1) and (rg_ocupacao.ItemIndex = 1) then
  begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where quarto.tipo like '''+db_classificar_quarto.Text+'%'' and quarto.numero not in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by numero');
    parameters.parambyname('data').value := datetostr(DateTimePicker1.date);
    ExecSQL;
    Active:=true;
  end;
  end;

  //por data, por tipo, ocupados
  if (rg_data.ItemIndex = 1) and (rg_tipo.ItemIndex = 1) and (rg_ocupacao.ItemIndex = 1) then
  begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where quarto.tipo like '''+db_classificar_quarto.Text+'%'' and quarto.numero in (select reserva.num_quarto from reserva where :data between check_in and check_out) order by numero');
    parameters.parambyname('data').value := datetostr(DateTimePicker1.date);
    ExecSQL;
    Active:=true;
  end;
  end;









 end;

end.
