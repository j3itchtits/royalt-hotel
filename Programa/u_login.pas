unit u_login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, PngSpeedButton, u_dm, u_principal;

type
  Tf_login = class(TForm)
    logo: TPngSpeedButton;
    t_senha: TEdit;
    Label1: TLabel;
    b_login: TPngSpeedButton;
    procedure b_loginClick(Sender: TObject);
    procedure t_senhaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_login: Tf_login;

implementation

{$R *.dfm}

procedure Tf_login.b_loginClick(Sender: TObject);
begin
  with dm.q_senha do
  begin
  Close;
  SQL.Clear;
  sql.Add('select senha from senha where senha = '''+t_senha.text+'''');
  Open;
  if RecordCount = 0 then
    begin
    showmessage('Senha inválida!');
    exit
    end
    else
    begin
    t_senha.text := '';
    f_principal.Show;
    f_login.Hide;
    end;

  end;

end;

procedure Tf_login.t_senhaKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
b_login.Click;
end;

end.
