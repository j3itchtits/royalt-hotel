unit u_cadastro_reserva;

interface

uses
  u_dm, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Grids, DBGrids, ComCtrls;

type
  Tf_cadastro_reserva = class(TForm)
    gb_reserva: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    g_reserva: TDBGrid;
    DateTimePicker1: TDateTimePicker;
    Label5: TLabel;
    db_cpf: TDBEdit;
    db_check_in: TDBEdit;
    db_check_out: TDBEdit;
    db_combo_box: TDBComboBox;
    procedure OnDropDown_db_combo_box(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_reserva: Tf_cadastro_reserva;

implementation

{$R *.dfm}

procedure Tf_cadastro_reserva.OnDropDown_db_combo_box(Sender: TObject);
begin
with dm.q_quarto do
begin
  Close;
  SQL.Clear;
  SQL.Add('select distinct(numero) from quarto');
  Open;
  db_combo_box.Clear;
  while not EOF do
  begin
    db_combo_box.Items;
    Add(Fields[0].AsString);
    Next;
  end;
end;
end;

end.
