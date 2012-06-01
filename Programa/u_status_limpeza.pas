unit u_status_limpeza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, u_dm, StdCtrls, ExtCtrls, Buttons, PngSpeedButton,
  ComCtrls, DBCtrls;

type
  Tf_status_limpeza = class(TForm)
    DBGrid1: TDBGrid;
    rg_quartos: TRadioGroup;
    gb_limpar: TGroupBox;
    db_numero: TDBText;
    db_andar: TDBText;
    db_tipo: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dtp: TDateTimePicker;
    bt_limpar: TPngSpeedButton;
    bt_fechar: TPngSpeedButton;
    procedure rg_quartosClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure bt_fecharClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bt_limparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_status_limpeza: Tf_status_limpeza;
  resultado : integer;

implementation

{$R *.dfm}

procedure Tf_status_limpeza.bt_fecharClick(Sender: TObject);
begin
close;
end;

procedure Tf_status_limpeza.bt_limparClick(Sender: TObject);
begin
if db_numero.Caption = '' then
begin
showmessage('Selecione um quarto primeiro!');
end
else
begin

with dm.q_limpeza do
    begin
    Active:=false;
    SQL.Clear;
    sql.Add('update quarto set data_limpeza = :data where numero = :num');
    parameters.parambyname('data').value := datetostr(dtp.date);
    parameters.parambyname('num').value := strtoint(db_numero.caption);
    ExecSQL;
    end;
with dm.q_limpeza do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto order by data_limpeza');
    Open;
    db_numero.Caption:='';
    db_andar.Caption:='';
    db_tipo.Caption:='';
    end;
end;
end;

procedure Tf_status_limpeza.DBGrid1CellClick(Column: TColumn);
begin
resultado := dm.q_limpeza.fieldbyname('numero').asinteger;
dm.t_quarto.Locate('numero',resultado,[]);

end;

procedure Tf_status_limpeza.DBGrid1TitleClick(Column: TColumn);
begin
if (dm.q_limpeza.Sort<>column.FieldName+' ASC') then
dm.q_limpeza.Sort:=column.FieldName+' ASC'
else
dm.q_limpeza.sort:=column.fieldname+' DESC';
end;

procedure Tf_status_limpeza.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dm.t_quarto.Cancel;
end;

procedure Tf_status_limpeza.FormShow(Sender: TObject);
begin
dtp.Date := date();
db_numero.Caption:='';
db_andar.Caption:='';
db_tipo.Caption:='';
end;

procedure Tf_status_limpeza.rg_quartosClick(Sender: TObject);
begin
Case rg_quartos.ItemIndex Of
0:  with dm.q_limpeza do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto order by data_limpeza');
    Open;
    db_numero.Caption:='';
    db_andar.Caption:='';
    db_tipo.Caption:='';
    end;
1:  with dm.q_limpeza do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto where data_limpeza < date()-1 order by data_limpeza');
    Open;
    db_numero.Caption:='';
    db_andar.Caption:='';
    db_tipo.Caption:='';
    end;
2:  with dm.q_limpeza do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto where data_limpeza < date()-3 order by data_limpeza ');
    Open;
    db_numero.Caption:='';
    db_andar.Caption:='';
    db_tipo.Caption:='';
    end;
3:  with dm.q_limpeza do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto where data_limpeza < date()-5 order by data_limpeza');
    Open;
    db_numero.Caption:='';
    db_andar.Caption:='';
    db_tipo.Caption:='';
    end;
4:  with dm.q_limpeza do
    begin
    Close;
    SQL.Clear;
    sql.Add('select * from quarto where data_limpeza < date()-6 order by data_limpeza');
    Open;
    db_numero.Caption:='';
    db_andar.Caption:='';
    db_tipo.Caption:='';
    end;

end;
end;

end.
