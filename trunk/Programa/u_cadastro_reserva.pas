unit u_cadastro_reserva;

interface

uses
  u_dm, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Grids, DBGrids;

type
  Tf_cadastro_reserva = class(TForm)
    DBEdit3: TDBEdit;
    gb_reserva: TGroupBox;
    DBEdit4: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    g_reserva: TDBGrid;
    db_cpf: TDBEdit;
    DBEdit1: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_reserva: Tf_cadastro_reserva;

implementation

{$R *.dfm}

end.
