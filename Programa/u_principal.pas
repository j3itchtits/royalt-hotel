unit u_principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, PngSpeedButton, ComCtrls, Menus, u_dm, ExtCtrls, pngimage;

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
    m_sobre: TMenuItem;
    m_c_quartos: TMenuItem;
    N1: TMenuItem;
    m_c_sair: TMenuItem;
    StatusBar1: TStatusBar;
    Image1: TImage;
    b_despertador: TPngSpeedButton;
    m_c_despertador: TMenuItem;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_principal: Tf_principal;

implementation

uses u_cadastro_cliente, u_cadastro_reserva, u_quadro_apartamentos,
  u_status_limpeza, u_cadastro_quartos, u_pagamentos, u_relatorios,
  u_cadastro_senha, u_sobre, u_despertador;

{$R *.dfm}

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

procedure Tf_principal.m_c_senhaClick(Sender: TObject);
begin
f_cadastro_senha.show;
end;

end.
