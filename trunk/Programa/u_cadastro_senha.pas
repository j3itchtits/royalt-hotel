unit u_cadastro_senha;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, PngSpeedButton, StdCtrls, u_dm, pngimage, ExtCtrls;

type
  Tf_cadastro_senha = class(TForm)
    t_senha_atual: TEdit;
    t_senha_nova: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    b_salvar: TPngSpeedButton;
    Image1: TImage;
    timer: TTimer;
    gb_mensagem: TGroupBox;
    l_mensagem: TLabel;
    procedure b_salvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure timerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_senha: Tf_cadastro_senha;
  senha : string;

implementation

{$R *.dfm}

procedure Tf_cadastro_senha.b_salvarClick(Sender: TObject);
begin
  with dm.q_senha do
  begin
  Close;
  SQL.Clear;
  sql.Add('select senha from senha where senha = '''+t_senha_atual.text+'''');
  Open;
  if RecordCount = 0 then
    begin
    showmessage('Senha atual está errada!');
    exit
    end
    else
    begin
    Close;
    SQL.Clear;
    sql.Add('update senha set senha = '''+t_senha_nova.text+''' where senha = '''+t_senha_atual.text+''' ');
    ExecSQL;
    l_mensagem.Caption:='Senha alterada com sucesso!';
    l_mensagem.Font.Color:=clBlue;
    timer.Enabled:=true;
    end;

  end;
t_senha_nova.text := '';
t_senha_atual.text := '';

end;


procedure Tf_cadastro_senha.FormShow(Sender: TObject);
begin
t_senha_nova.text := '';
t_senha_atual.text := '';
end;

procedure Tf_cadastro_senha.timerTimer(Sender: TObject);
begin
l_mensagem.caption:='';
l_mensagem.Font.Color:=clBlack;
timer.Enabled:=false;
end;

end.
