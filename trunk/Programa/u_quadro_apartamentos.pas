unit u_quadro_apartamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, PngSpeedButton, Buttons, u_dm;

type
  Tf_quadro_apartamentos = class(TForm)
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

end.
