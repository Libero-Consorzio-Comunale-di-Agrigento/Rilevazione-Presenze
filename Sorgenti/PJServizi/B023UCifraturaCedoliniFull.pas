unit B023UCifraturaCedoliniFull;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, B023UCifraturaCedoliniBase,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, StrUtils,
  A000UMessaggi, A000UCostanti, B023UCifraturaCedoliniDtM, C180FunzioniGenerali;

type
  TB023FCifraturaCedoliniFull = class(TB023FCifraturaCedoliniBase)
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    grpDirectory: TGroupBox;
    lblMese: TLabel;
    lblAnno: TLabel;
    lblDirectory: TLabel;
    spMese: TSpinEdit;
    spAnno: TSpinEdit;
    edtPath: TEdit;
    rdbSceltaManualeDir: TRadioButton;
    rdbDirectoryData: TRadioButton;
    btnBrowse: TButton;
    rgpHash: TRadioGroup;
    rgpOperazione: TRadioGroup;
    grpPassphrase: TGroupBox;
    edtPassphrase: TEdit;
    chkSostFile: TCheckBox;
    lblNuoviFile: TLabel;
    edtNomeNuoviFile: TEdit;
    rdbCedolini: TRadioButton;
    rdbCU: TRadioButton;
    pnlRadioDir: TPanel;
    procedure FormShow(Sender: TObject);
    procedure rdbDirectoryDataClick(Sender: TObject);
    procedure rdbSceltaManualeDirClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure edtPathChange(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject); override;
    procedure chkSostFileClick(Sender: TObject);
    procedure rgpOperazioneClick(Sender: TObject);
    procedure rdbCedoliniClick(Sender: TObject);
    procedure rdbCUClick(Sender: TObject);
  private
    TipoDocumento:TB023TipoDocumento;
    procedure OnSpinEditChange(Sender: TObject);
    procedure ToggleEsegui;
    procedure AbilitaSceltaPathLibera(Abilita:Boolean);
    procedure AggiornaNomiFile;
    procedure ToggleSpinEdit;
  public
    procedure AbilitaComponenti(Abilita:Boolean); override;
  end;

var
  B023FCifraturaCedoliniFull: TB023FCifraturaCedoliniFull;

implementation

{$R *.dfm}

procedure TB023FCifraturaCedoliniFull.FormShow(Sender: TObject);
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
  grpDirectory.Font.Color:=clBlue;
end;

procedure TB023FCifraturaCedoliniFull.OnSpinEditChange(Sender: TObject);
var
  Path:String;
begin
  if rdbDirectoryData.Checked then
  begin
    if TipoDocumento = b023Cedolino then
      Path:=B023FCifraturaCedoliniDtM.GetPathCedolini(spMese.Value,spAnno.Value)
    else
      Path:=B023FCifraturaCedoliniDtM.GetPathCU(spAnno.Value);
    edtPath.Text:=Path;
    ToggleEsegui;
  end;
end;

procedure TB023FCifraturaCedoliniFull.ToggleEsegui;
begin
  btnEsegui.Enabled:=edtPath.Text <> '';
end;

procedure TB023FCifraturaCedoliniFull.AbilitaSceltaPathLibera(Abilita:Boolean);
begin
  edtPath.ReadOnly:=not Abilita;
  if Abilita then
    edtPath.Color:=clWindow
  else
    edtPath.Color:=clBtnFace;
  btnBrowse.Enabled:=Abilita;
  rdbCedolini.Enabled:=not Abilita;
  rdbCU.Enabled:=not Abilita;
  spAnno.Enabled:=not Abilita;
  spMese.Enabled:=not Abilita;
  OnSpinEditChange(nil);
end;

procedure TB023FCifraturaCedoliniFull.AbilitaComponenti(Abilita:Boolean);
begin
  edtPath.Enabled:=Abilita;
  btnBrowse.Enabled:=Abilita;
  rdbDirectoryData.Enabled:=Abilita;
  spAnno.Enabled:=Abilita;
  spMese.Enabled:=Abilita;
  rdbSceltaManualeDir.Enabled:=Abilita;
  edtPassphrase.Enabled:=Abilita;
  rgpHash.Enabled:=Abilita;
  rgpOperazione.Enabled:=Abilita;
  btnEsegui.Enabled:=Abilita;
  btnAnomalie.Enabled:=Abilita;
  btnChiudi.Enabled:=Abilita;
  chkSostFile.Enabled:=Abilita;
  btnDisattivaElaborazioni.Enabled:=not Abilita;

  if Abilita then
  begin
    AbilitaSceltaPathLibera(rdbSceltaManualeDir.Checked);
    ToggleEsegui;
  end;

end;

procedure TB023FCifraturaCedoliniFull.AggiornaNomiFile;
begin
  if not chkSostFile.Checked then
  begin
    lblNuoviFile.Visible:=true;
    edtNomeNuoviFile.Visible:=true;
    edtNomeNuoviFile.Text:='<nome file originale>' +
                            IfThen(rgpOperazione.ItemIndex = 0, B023_SUFFISSO_FILE_CIFRATO, B023_SUFFISSO_FILE_DECIFRATO) +
                            '.pdf';
  end
  else
  begin
    lblNuoviFile.Visible:=false;
    edtNomeNuoviFile.Visible:=false;
    edtNomeNuoviFile.Text:='';
  end;
end;

procedure TB023FCifraturaCedoliniFull.ToggleSpinEdit;
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

procedure TB023FCifraturaCedoliniFull.rdbSceltaManualeDirClick(Sender: TObject);
begin
  AbilitaSceltaPathLibera(true);
end;

procedure TB023FCifraturaCedoliniFull.rgpOperazioneClick(Sender: TObject);
begin
  AggiornaNomiFile;
end;

procedure TB023FCifraturaCedoliniFull.rdbCedoliniClick(Sender: TObject);
begin
  TipoDocumento:=b023Cedolino;
  ToggleSpinEdit;
end;

procedure TB023FCifraturaCedoliniFull.rdbCUClick(Sender: TObject);
begin
  TipoDocumento:=b023CU;
  ToggleSpinEdit;
end;

procedure TB023FCifraturaCedoliniFull.rdbDirectoryDataClick(Sender: TObject);
begin
  AbilitaSceltaPathLibera(false);
end;

procedure TB023FCifraturaCedoliniFull.btnBrowseClick(Sender: TObject);
begin
  OpenDialog1.Title:='Percorso dei cedolini';
  OpenDialog1.InitialDir:=edtPath.Text;
  OpenDialog1.FileName:='x';
  OpenDialog1.Options:=[ofPathMustExist,ofHideReadOnly,ofEnableSizing];
  OpenDialog1.Filter:='Tutti i file (*.*)|*.*';
  if OpenDialog1.Execute then
    edtPath.Text:=R180GetFilePath(OpenDialog1.FileName);
end;

procedure TB023FCifraturaCedoliniFull.btnEseguiClick(Sender: TObject);
var
  HashAlg:String;
  Azione:TB023TipoAzione;
  Sostituisci:Boolean;
begin
  case rgpHash.ItemIndex of
    0: HashAlg:=HASHTYPE_NoHash;
    1: HashAlg:=HASHTYPE_Sha1;
    else HashAlg:=HASHTYPE_Sha256;
  end;
  if rgpOperazione.ItemIndex = 0 then
    Azione:=b023ActEncrypt
  else
    Azione:=b023ActDecrypt;

  Sostituisci:=chkSostFile.Checked;

  B023FCifraturaCedoliniDtM.Esegui(edtPath.Text,edtPassphrase.Text,HashAlg,Azione,Sostituisci);
  inherited;
end;

procedure TB023FCifraturaCedoliniFull.chkSostFileClick(Sender: TObject);
begin
  AggiornaNomiFile;
end;

procedure TB023FCifraturaCedoliniFull.edtPathChange(Sender: TObject);
begin
  ToggleEsegui;
end;


end.
