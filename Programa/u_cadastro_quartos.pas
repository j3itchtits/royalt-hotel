unit u_cadastro_quartos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, FileCtrl, Buttons, PngSpeedButton, Mask, DBCtrls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompListbox,
  TeCanvas, Grids, DBGrids, u_dm;

type
  Tf_cadastro_quartos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    db_tipo: TDBComboBox;
    db_diaria: TDBEdit;
    b_fechar: TPngSpeedButton;
    b_novo: TPngSpeedButton;
    PngSpeedButton2: TPngSpeedButton;
    PngSpeedButton3: TPngSpeedButton;
    PngSpeedButton4: TPngSpeedButton;
    PngSpeedButton5: TPngSpeedButton;
    group_pesquisar: TGroupBox;
    db_pesquisar_por: TComboBox;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    db_andar: TDBComboBox;
    db_numero: TDBEdit;
    db_pesquisar: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_quartos: Tf_cadastro_quartos;

implementation

{$R *.dfm}


end.
