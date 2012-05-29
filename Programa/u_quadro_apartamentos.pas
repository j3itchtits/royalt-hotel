unit u_quadro_apartamentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, PngSpeedButton, Buttons, u_dm;

type
  Tf_quadro_apartamentos = class(TForm)
    ScrollBox1: TScrollBox;
    bt_atualizar: TButton;
    procedure bt_atualizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure Tf_quadro_apartamentos.bt_atualizarClick(Sender: TObject);
begin

with dm.q_quarto do
  begin
  Close;
  SQL.Clear;
  SQL.Add('select numero, andar, ocupado, id, tipo from quarto order by andar, numero, ocupado, id, tipo;');
  Open;

i := 10;
j := 100;
WHILE not EOF DO
begin
numero := Fields[0].AsString;
andar := Fields[1].AsString;
ocupado := Fields[2].AsString;
id := Fields[3].AsString;
tipo := Fields[4].AsString;

if i > 600 then
begin
  j := j + 100;
  i := 10;
end;
//icone do quarto
quarto:= Tpngspeedbutton.Create(self);
quarto.Left:=i+60;
quarto.top:=j;
quarto.Width:=33;
quarto.Height:=33;
quarto.name:='bt_quarto'+id;
quarto.Flat:=true;
quarto.Parent:=f_quadro_apartamentos.ScrollBox1;
if ocupado='não' then
  begin
  quarto.PngImage.LoadFromFile('C:\Royalt Hotel\imagens\botoes\qlivre.png');
  end
  else
  begin
  quarto.PngImage.LoadFromFile('C:\Royalt Hotel\imagens\botoes\qocupado.png');
  end;
//fim do icone
//texto do icone do quarto
nome:= tlabel.Create(self);
nome.Left:=i+10;
nome.Top:=j-15;
nome.name:='l_quarto'+id;
nome.Caption:='Quarto '+numero+' ('+tipo+') - Andar '+andar+'º:';
nome.Parent:=f_quadro_apartamentos.ScrollBox1;
//fim do texto
i := i + 200;
//next do while, ou seja, proximo registro de quarto encontrado
Next;
end;
end;
end;

procedure Tf_quadro_apartamentos.FormShow(Sender: TObject);
begin
bt_atualizar.Click;
end;

end.
