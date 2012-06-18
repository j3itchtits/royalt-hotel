program Royalt_Hotel;

uses
  Forms,
  u_principal in 'u_principal.pas' {f_principal},
  u_quadro_apartamentos in 'u_quadro_apartamentos.pas' {f_quadro_apartamentos},
  u_cadastro_cliente in 'u_cadastro_cliente.pas' {f_cadastro_cliente},
  u_cadastro_quartos in 'u_cadastro_quartos.pas' {f_cadastro_quartos},
  u_cadastro_reserva in 'u_cadastro_reserva.pas' {f_cadastro_reserva},
  u_status_limpeza in 'u_status_limpeza.pas' {f_status_limpeza},
  u_pagamentos in 'u_pagamentos.pas' {f_pagamentos},
  u_cadastro_senha in 'u_cadastro_senha.pas' {f_cadastro_senha},
  u_relatorios in 'u_relatorios.pas' {f_relatorios},
  u_sobre in 'u_sobre.pas' {f_sobre},
  u_dm in 'u_dm.pas' {dm: TDataModule},
  u_login in 'u_login.pas' {f_login},
  u_despertador in 'u_despertador.pas' {f_despertador};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tf_login, f_login);
  Application.CreateForm(Tf_cadastro_reserva, f_cadastro_reserva);
  Application.CreateForm(Tf_principal, f_principal);
  Application.CreateForm(Tf_quadro_apartamentos, f_quadro_apartamentos);
  Application.CreateForm(Tf_cadastro_cliente, f_cadastro_cliente);
  Application.CreateForm(Tf_cadastro_quartos, f_cadastro_quartos);
  Application.CreateForm(Tf_status_limpeza, f_status_limpeza);
  Application.CreateForm(Tf_pagamentos, f_pagamentos);
  Application.CreateForm(Tf_cadastro_senha, f_cadastro_senha);
  Application.CreateForm(Tf_relatorios, f_relatorios);
  Application.CreateForm(Tf_sobre, f_sobre);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tf_despertador, f_despertador);
  Application.Run;
end.
