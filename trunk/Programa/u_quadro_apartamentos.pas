unit u_quadro_apartamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, PngSpeedButton, Buttons, u_dm, ComCtrls, DBCtrls,
  Grids, DBGrids, pngimage;

type
  Tf_quadro_apartamentos = class(TForm)
    rg_quartos_quadro: TRadioGroup;
    DateTimePicker1: TDateTimePicker;
    rg_ocupacao: TRadioGroup;
    DBGrid1: TDBGrid;
    b_listar: TPngSpeedButton;
    b_fechar: TPngSpeedButton;
    Image1: TImage;
    db_classificar_quarto: TComboBox;
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
 if (rg_quartos_quadro.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 0) then
  begin
  with dm.q_quadro do
  begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto');
    Open;
  end;
  end;

 if (rg_quartos_quadro.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 1) then
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

 if (rg_quartos_quadro.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 2) then
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

 if (rg_quartos_quadro.ItemIndex = 0) and (rg_ocupacao.ItemIndex = 3) then
 begin
  with dm.q_quadro do
  begin
    Active:=false;
    SQL.Clear;
    sql.Add('select * from quarto where quarto.numero not in (select reserva.num_quarto from reserva where : data between check_in and check_out) order by numero');
    parameters.ParamByName('data').Value :=date();
    ExecSQL;
    Active:=true;
  end;
  end;
end;




end.
