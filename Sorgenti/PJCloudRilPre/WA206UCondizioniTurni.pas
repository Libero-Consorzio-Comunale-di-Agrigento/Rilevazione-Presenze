unit WA206UCondizioniTurni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, Oracle, StrUtils, Math,
  System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit,
  meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  meIWRadioGroup, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion;

type
  TWA206FCondizioniTurni = class(TWR102FGestTabella)
    WA206AreaIntestazioneRG: TmeIWRegion;
    rgpTipoCondizioni: TmeIWRadioGroup;
    lblTipoCondizioni: TmeIWLabel;
    TemplateAreaIntestazioneRG: TIWTemplateProcessorHTML;
    procedure IWAppFormCreate(Sender: TObject);
    procedure rgpTipoCondizioniClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CambioDataDecorrenza; override;
    procedure CambioDataScadenza; override;
  public
    { Public declarations }
    procedure WC700CambioProgressivo(Sender: TObject); override;
  end;

implementation

uses WA206UCondizioniTurniDM, WA206UCondizioniTurniBrowseFM, WA206UCondizioniTurniDettFM;

{$R *.dfm}

procedure TWA206FCondizioniTurni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  WR302DM:=TWA206FCondizioniTurniDM.Create(Self);
  WBrowseFM:=TWA206FCondizioniTurniBrowseFM.Create(Self);
  WDettaglioFM:=TWA206FCondizioniTurniDettFM.Create(Self);
  CreaTabDefault;
  WR100LinkWC700:=False;
  AttivaGestioneC700;
  (WR302DM as TWA206FCondizioniTurniDM).A206MW.selAnagrafe:=grdC700.selAnagrafe;
  WC700CambioProgressivo(nil);
  WDettaglioFM.AbilitaComponenti;
end;

procedure TWA206FCondizioniTurni.rgpTipoCondizioniClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA206FCondizioniTurniDM).A206MW do
  begin
    TipoCond:=IfThen(rgpTipoCondizioni.ItemIndex = 0,'G',IfThen(rgpTipoCondizioni.ItemIndex = 1,'I','E'));
    selT605.Refresh;
    WR100LinkWC700:=TipoCond = 'I';
    selT606.FieldByName('MATRICOLA').Visible:=TipoCond = 'E';
    selT606.FieldByName('COGNOME').Visible:=TipoCond = 'E';
    selT606.FieldByName('NOME').Visible:=TipoCond = 'E';
  end;
  AttivaGestioneC700;
  WC700CambioProgressivo(nil);
  WDettaglioFM.AbilitaComponenti;
end;

procedure TWA206FCondizioniTurni.WC700CambioProgressivo(Sender: TObject);
begin
  with (WR302DM as TWA206FCondizioniTurniDM) do
  begin
    selTabella.Close;
    selTabella.SetVariable('PROGRESSIVO',IfThen(A206MW.TipoCond = 'G',-1,IfThen(A206MW.TipoCond = 'I',grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,-2)));
    selTabella.Open;
  end;
  WBrowseFM.grdTabella.medpCreaColonne;
  WBrowseFM.grdTabella.medpAggiornaCDS;
  AggiornaRecord;
  inherited;
end;

procedure TWA206FCondizioniTurni.CambioDataDecorrenza;
begin
  WR302DM.selTabella.FieldByName('DECORRENZA').AsString:=dedtDataDecorrenza.Text;
  WR302DM.selTabella.FieldByName('DECORRENZA_FINE').AsString:=dedtDataScadenza.Text;
  if WDettaglioFM <> nil then
    (WDettaglioFM as TWA206FCondizioniTurniDettFM).cmbCodDatoChange(nil,0);
end;

procedure TWA206FCondizioniTurni.CambioDataScadenza;
begin
  CambioDataDecorrenza;
end;

end.
