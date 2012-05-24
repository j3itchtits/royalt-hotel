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
    DBComboBox1: TDBComboBox;
    DBEdit1: TDBEdit;
    DBComboBox2: TDBComboBox;
    DBEdit2: TDBEdit;
    b_fechar: TPngSpeedButton;
    b_novo: TPngSpeedButton;
    PngSpeedButton2: TPngSpeedButton;
    PngSpeedButton3: TPngSpeedButton;
    PngSpeedButton4: TPngSpeedButton;
    PngSpeedButton5: TPngSpeedButton;
    group_pesquisar: TGroupBox;
    ComboBox1: TComboBox;
    Label5: TLabel;
    DBGrid1: TDBGrid;
    Label6: TLabel;
    Label7: TLabel;
    procedure ds_quartoDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_cadastro_quartos: Tf_cadastro_quartos;

implementation

{$R *.dfm}

procedure Tf_cadastro_quartos.ds_quartoDataChange(Sender: TObject;
  Field: TField);
begin
with QUERY do
  begin
  Close;
  SQL.Clear;
  sql.Add('select * from TABELA where TIPOQUARTO like '''+COMBOBOX.text+'%''');
  Open;
  end;
end;

end.
