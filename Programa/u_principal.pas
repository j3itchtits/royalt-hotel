unit u_principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, PngSpeedButton, ComCtrls, Menus, u_dm, ExtCtrls, pngimage,
  StdCtrls;

type
  Tf_principal = class(TForm)
    b_cadastro_cliente: TPngSpeedButton;
    b_cadastro_reserva: TPngSpeedButton;
    b_quadro_apartamentos: TPngSpeedButton;
    b_status_limpeza: TPngSpeedButton;
    b_cadastro_quartos: TPngSpeedButton;
    b_pagamentos: TPngSpeedButton;
    b_relatorios: TPngSpeedButton;
    PngSpeedButton7: TPngSpeedButton;
    MainMenu1: TMainMenu;
    m_cadastro: TMenuItem;
    m_apartamentos: TMenuItem;
    m_c_cliente: TMenuItem;
    m_c_reserva: TMenuItem;
    m_c_pagamentos: TMenuItem;
    m_a_quadro_ocupacao: TMenuItem;
    m_a_status_limpeza: TMenuItem;
    m_relatorios: TMenuItem;
    m_c_senha: TMenuItem;
    m_c_quartos: TMenuItem;
    N1: TMenuItem;
    m_c_sair: TMenuItem;
    StatusBar1: TStatusBar;
    Image1: TImage;
    m_c_despertador: TMenuItem;
    gb_despertador: TGroupBox;
    l_datahora: TLabel;
    l_num_quarto: TLabel;
    b_finalizar: TPngSpeedButton;
    timer: TTimer;
    hadespertador2: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    hadespertador1: TLabel;
    bt_ver: TPngSpeedButton;
    procedure b_cadastro_clienteClick(Sender: TObject);
    procedure m_c_clienteClick(Sender: TObject);
    procedure b_cadastro_reservaClick(Sender: TObject);
    procedure m_c_reservaClick(Sender: TObject);
    procedure b_quadro_apartamentosClick(Sender: TObject);
    procedure m_a_quadro_ocupacaoClick(Sender: TObject);
    procedure b_status_limpezaClick(Sender: TObject);
    procedure m_a_status_limpezaClick(Sender: TObject);
    procedure b_cadastro_quartosClick(Sender: TObject);
    procedure m_c_quartosClick(Sender: TObject);
    procedure b_pagamentosClick(Sender: TObject);
    procedure m_c_pagamentosClick(Sender: TObject);
    procedure b_relatoriosClick(Sender: TObject);
    procedure m_relatoriosClick(Sender: TObject);
    procedure m_c_senhaClick(Sender: TObject);
    procedure PngSpeedButton7Click(Sender: TObject);
    procedure m_sobreClick(Sender: TObject);
    procedure b_despertadorClick(Sender: TObject);
    procedure m_c_despertadorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure timerTimer(Sender: TObject);
    procedure b_finalizarClick(Sender: TObject);
    procedure bt_verClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_principal: Tf_principal;
  conta_alarme, conta_alarme2: integer;
  id_despertador : integer;

implementation

uses u_cadastro_cliente, u_cadastro_reserva, u_quadro_apartamentos,
  u_status_limpeza, u_cadastro_quartos, u_pagamentos, u_relatorios,
  u_cadastro_senha, u_sobre, u_despertador;

{$R *.dfm}

procedure Tf_principal.bt_verClick(Sender: TObject);
begin
f_despertador.show;
end;

procedure Tf_principal.b_cadastro_clienteClick(Sender: TObject);
begin
f_cadastro_cliente.show;
end;

procedure Tf_principal.b_cadastro_quartosClick(Sender: TObject);
begin
f_cadastro_quartos.show;
end;

procedure Tf_principal.b_cadastro_reservaClick(Sender: TObject);
begin
f_cadastro_reserva.show;
end;

procedure Tf_principal.b_despertadorClick(Sender: TObject);
begin
f_despertador.show;
end;

procedure Tf_principal.b_finalizarClick(Sender: TObject);
begin
with dm.q_despertador do
 begin
 Close;
 SQL.Clear;
 sql.Add('delete from despertador where id = :id');
 parameters.parambyname('id').value := id_despertador;
 ExecSQL;
 end;
 timer.OnTimer(self);
end;

procedure Tf_principal.b_pagamentosClick(Sender: TObject);
begin
f_pagamentos.show;
end;

procedure Tf_principal.b_quadro_apartamentosClick(Sender: TObject);
begin
f_quadro_apartamentos.show;
end;

procedure Tf_principal.b_relatoriosClick(Sender: TObject);
begin
f_relatorios.show;
end;

procedure Tf_principal.b_status_limpezaClick(Sender: TObject);
begin
f_status_limpeza.show;
end;

procedure Tf_principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
application.Terminate;
end;

procedure Tf_principal.FormShow(Sender: TObject);
begin
l_datahora.caption:='';
l_num_quarto.caption:='';
timer.OnTimer(self);
end;

procedure Tf_principal.m_a_quadro_ocupacaoClick(Sender: TObject);
begin
f_quadro_apartamentos.show;
end;

procedure Tf_principal.m_a_status_limpezaClick(Sender: TObject);
begin
f_status_limpeza.show;
end;

procedure Tf_principal.m_c_clienteClick(Sender: TObject);
begin
f_cadastro_cliente.show;
end;

procedure Tf_principal.m_c_despertadorClick(Sender: TObject);
begin
f_despertador.show;
end;

procedure Tf_principal.m_c_pagamentosClick(Sender: TObject);
begin
f_pagamentos.show;
end;

procedure Tf_principal.m_c_quartosClick(Sender: TObject);
begin
f_cadastro_quartos.show;
end;

procedure Tf_principal.m_c_reservaClick(Sender: TObject);
begin
f_cadastro_reserva.show;
end;

procedure Tf_principal.m_relatoriosClick(Sender: TObject);
begin
f_relatorios.show;
end;

procedure Tf_principal.m_sobreClick(Sender: TObject);
begin
f_sobre.show;
end;

procedure Tf_principal.PngSpeedButton7Click(Sender: TObject);
begin
f_cadastro_senha.show;
end;

procedure Tf_principal.timerTimer(Sender: TObject);
begin
with dm.q_aviso_despertador do
 begin
 Active := False;
 SQL.Text := 'SELECT  id, num_quarto, hora from  despertador where day(now()) = day(hora) and month(now()) = month(hora) and year(now()) = year(hora) and hour(now()) = hour(hora) and minute(now()) = minute(hora)';
 Active := True;
 conta_alarme := RecordCount;
 end;
 if (conta_alarme > 0) then
   begin
   gb_despertador.Visible:=true;
   l_num_quarto.caption := dm.q_aviso_despertador.fieldbyname('num_quarto').asstring;
   l_datahora.caption := dm.q_aviso_despertador.fieldbyname('hora').asstring;
   id_despertador := dm.q_aviso_despertador.fieldbyname('id').asinteger;
   b_finalizar.Visible:=true;
   end
   else
   begin
   l_datahora.caption:='';
   l_num_quarto.caption:='';
   b_finalizar.Visible:=false;
   gb_despertador.Visible:=false;
   end;
with dm.q_aviso_despertador do
begin
 Active := False;
 SQL.Text := 'SELECT * from despertador where now() > hora and id <> :id';
 if conta_alarme > 0 then
 begin
 parameters.parambyname('id').value := id_despertador;
 end
 else
 begin
 parameters.parambyname('id').value := 0;
 end;
 Active := True;
 conta_alarme2 := RecordCount;
 end;
 if (conta_alarme2 > 0) then
   begin
   gb_despertador.Visible:=true;
   hadespertador1.Visible:=true;
   hadespertador2.Visible:=true;
   bt_ver.Visible:=true;
    if (conta_alarme = 0) then
   begin
   l_datahora.caption:='';
   l_num_quarto.caption:='';
   end;
   end
   else
   begin
   hadespertador1.Visible:=false;
   hadespertador2.Visible:=false;
   bt_ver.Visible:=false;
   if conta_alarme = 0 then
   begin
   gb_despertador.Visible:=false;
   end;

end;
end;

procedure Tf_principal.m_c_senhaClick(Sender: TObject);
begin
f_cadastro_senha.show;
end;

end.
