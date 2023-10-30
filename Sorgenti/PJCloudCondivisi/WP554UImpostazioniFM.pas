unit WP554UImpostazioniFM;

interface

uses
  P554UElaborazioneContoAnnualeMW,
  C190FunzioniGeneraliWeb,
  System.SysUtils, System.Variants,
  System.Classes, Vcl.Controls,
  WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, meIWImageFile,
  medpIWImageButton, meIWRadioGroup, IWCompEdit, meIWEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, Vcl.Forms;

type
  TWP554FImpostazioniFM = class(TWR200FBaseFM)
    lblNomeFile: TmeIWLabel;
    edtNomeFile: TmeIWEdit;
    rgpComparto: TmeIWRadioGroup;
    lblComparto: TmeIWLabel;
    lblTipoOperazione: TmeIWLabel;
    rgpTipoOperazione: TmeIWRadioGroup;
    lblAzienda: TmeIWLabel;
    lblRegione: TmeIWLabel;
    edtAzienda: TmeIWEdit;
    edtRegione: TmeIWEdit;
    edtIstituto: TmeIWEdit;
    edtDSM: TmeIWEdit;
    lblIstituto: TmeIWLabel;
    lblDSM: TmeIWLabel;
    btnOK: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
  private
    procedure PulisciImpostazioni;
  public
    Impostazioni: TImpostazioni;
    procedure Visualizza;
    procedure ReleaseOggetti; override;
  end;

implementation

{$R *.dfm}

uses WR100UBase, WP554UElaborazioneContoAnnuale;

{ TWP554FImpostazioniFM }

procedure TWP554FImpostazioniFM.Visualizza;
begin
  // imposta i valori delle impostazioni nell'interfaccia
  edtNomeFile.Text:=Impostazioni.NomeFile;
  edtAzienda.Text:=Impostazioni.Azienda;
  if Impostazioni.Comparto = '01' then
    rgpComparto.ItemIndex:=0
  else
    rgpComparto.ItemIndex:=1;
  edtDSM.Text:=Impostazioni.DSM;
  edtIstituto.Text:=Impostazioni.Istituto;
  edtRegione.Text:=Impostazioni.Regione;
  if Impostazioni.TipoOper = '0' then
    rgpTipoOperazione.ItemIndex:=0
  else if Impostazioni.TipoOper = '1' then
    rgpTipoOperazione.ItemIndex:=1
  else
    rgpTipoOperazione.ItemIndex:=2;

  // visualizza in jquery modal dialog
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,610,-1,EM2PIXEL * 30,'<P554> Impostazioni','#' + Name,False,True);
end;

procedure TWP554FImpostazioniFM.PulisciImpostazioni;
begin
  Impostazioni.NomeFile:='';
  Impostazioni.Azienda:='';
  Impostazioni.Comparto:='';
  Impostazioni.DSM:='';
  Impostazioni.Istituto:='';
  Impostazioni.Regione:='';
  Impostazioni.TipoOper:='';
end;

procedure TWP554FImpostazioniFM.btnOKClick(Sender: TObject);
begin
  inherited;

  // salva i valori presenti nell'interfaccia nelle impostazioni
  Impostazioni.NomeFile:=edtNomeFile.Text;
  Impostazioni.Azienda:=edtAzienda.Text;
  if rgpComparto.ItemIndex = 0 then
    Impostazioni.Comparto:='01'
  else
    Impostazioni.Comparto:='04';
  Impostazioni.DSM:=edtDSM.Text;
  Impostazioni.Istituto:=edtIstituto.Text;
  Impostazioni.Regione:=edtRegione.Text;
  if rgpTipoOperazione.ItemIndex = 0 then
    Impostazioni.TipoOper:='0'
  else if rgpTipoOperazione.ItemIndex = 1 then
    Impostazioni.TipoOper:='1'
  else
    Impostazioni.TipoOper:='9';

  // conferma il percorso indicato
  try
    (Self.Owner as TWP554FElaborazioneContoAnnuale).ConfermaImpostazioni(Impostazioni);
  finally
    ReleaseOggetti;
    Free;
  end;
end;

procedure TWP554FImpostazioniFM.btnAnnullaClick(Sender: TObject);
begin
  inherited;
  PulisciImpostazioni;
  ReleaseOggetti;
  Free;
end;

procedure TWP554FImpostazioniFM.ReleaseOggetti;
begin
  //
end;

end.
