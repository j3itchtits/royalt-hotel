unit u_quadro_apartamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, PngSpeedButton, Buttons, u_dm, ComCtrls, DBCtrls,
  Grids, DBGrids, pngimage;

type
  Tf_quadro_apartamentos = class(TForm)
    rg_quartos_quadro: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    DateTimePicker1: TDateTimePicker;
    RadioButton3: TRadioButton;
    RadioGroup1: TRadioGroup;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    DBGrid1: TDBGrid;
    b_listar: TPngSpeedButton;
    RadioButton7: TRadioButton;
    b_fechar: TPngSpeedButton;
    Image1: TImage;
    db_classificar_quarto: TComboBox;
    procedure b_fecharClick(Sender: TObject);
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

end.
