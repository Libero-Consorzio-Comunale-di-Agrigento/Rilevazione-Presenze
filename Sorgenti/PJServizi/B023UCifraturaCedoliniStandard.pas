unit B023UCifraturaCedoliniStandard;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, B023UCifraturaCedoliniBase,
  Vcl.Samples.Spin, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls,
  A000UMessaggi,C180FunzioniGenerali, B023UCifraturaCedoliniDtM;

type
  TB023FCifraturaCedoliniStandard = class(TB023FCifraturaCedoliniBase)
    lblDirectory: TLabel;
    edtPath: TEdit;
    lblDataCed: TLabel;
    spMese: TSpinEdit;
    lblMese: TLabel;
    lblAnno: TLabel;
    spAnno: TSpinEdit;
    grpPercorso: TGroupBox;
    rdbCedolini: TRadioButton;
    rdbCU: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject); override;
    procedure rdbCedoliniClick(Sender: TObject);
    procedure rdbCUClick(Sender: TObject);
  private
    TipoDocumento:TB023TipoDocumento;
    procedure OnSpinEditChange(Sender: TObject);
    procedure ToggleSpinEdit;
  public
    { Public declarations }
    procedure AbilitaComponenti(Abilita:Boolean); override;
  end;

var
  B023FCifraturaCedoliniStandard: TB023FCifraturaCedoliniStandard;

implementation

{$R *.dfm}

procedure TB023FCifraturaCedoliniStandard.FormShow(Sender: TObject);
var
  Anno,Mese,Giorno:Word;
begin
  TipoDocumento:=b023Cedolino;
  DecodeDate(Now,Anno,Mese,Giorno);
  spAnno.Value:=Anno;
  spMese.Value:=Mese;
  spAnno.OnChange:=OnSpinEditChange;
  spMese.OnChange:=OnSpinEditChange;
  OnSpinEditChange(nil);
end;

procedure TB023FCifraturaCedoliniStandard.OnSpinEditChange(Sender: TObject);
var
  Path:String;
begin
  if TipoDocumento = b023Cedolino then
    Path:=B023FCifraturaCedoliniDtM.GetPathCedolini(spMese.Value,spAnno.Value)
  else
    Path:=B023FCifraturaCedoliniDtM.GetPathCU(spAnno.Value);
  edtPath.Text:=Path;
  btnEsegui.Enabled:=edtPath.Text <> '';
end;

procedure TB023FCifraturaCedoliniStandard.ToggleSpinEdit;
begin
  if TipoDocumento = b023Cedolino then
  begin
    lblMese.Visible:=true;
    spMese.Visible:=true;
  end
  else
  begin
    lblMese.Visible:=false;
    spMese.Visible:=false;
  end;
  OnSpinEditChange(nil);
end;

procedure TB023FCifraturaCedoliniStandard.rdbCedoliniClick(Sender: TObject);
begin
  TipoDocumento:=b023Cedolino;
  ToggleSpinEdit;
  OnSpinEditChange(nil);
end;

procedure TB023FCifraturaCedoliniStandard.rdbCUClick(Sender: TObject);
begin
  TipoDocumento:=b023CU;
  ToggleSpinEdit;
  OnSpinEditChange(nil);
end;

procedure TB023FCifraturaCedoliniStandard.AbilitaComponenti(Abilita:Boolean);
begin
  edtPath.Enabled:=Abilita;
  spAnno.Enabled:=Abilita;
  spMese.Enabled:=Abilita;
  btnEsegui.Enabled:=Abilita;
  btnAnomalie.Enabled:=Abilita;
  btnChiudi.Enabled:=Abilita;
  btnDisattivaElaborazioni.Enabled:=not Abilita;
end;

procedure TB023FCifraturaCedoliniStandard.btnEseguiClick(Sender: TObject);
begin
  B023FCifraturaCedoliniDtM.Esegui(edtPath.Text);
  inherited;
end;


end.
