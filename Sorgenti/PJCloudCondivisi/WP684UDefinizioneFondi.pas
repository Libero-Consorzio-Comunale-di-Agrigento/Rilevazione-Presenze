unit WP684UDefinizioneFondi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, Oracle,
  System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit,
  meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  A000UInterfaccia, Data.DB, medpIWMessagedlg, A000UMessaggi,
  WP684UDefinizioneFondiDM, WP684UDefinizioneFondiBrowseFM, WP684UDefinizioneFondiDettFM,
  WP684URisorseGenDefinizioneFondiFM, WP684UDestGenDefinizioneFondiFM,
  WP684URisorseDettDefinizioneFondiFM, WP684UDestDettDefinizioneFondiFM,
  WC007UFormContainerFM, WP684UGrigliaDettDefinizioneFondi;

type
  TWP684FDefinizioneFondi = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    WP684FGrigliaDettDefinizioneFondi:TWP684FGrigliaDettDefinizioneFondi;
    WC007FM:TWC007FFormContainerFM;
    procedure ResultConfermaElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultGrigliaDettDefinizioneFondi(Sender: TObject);
    procedure ResultAllineaSpeso(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    DetailRisorseGen: TWP684FRisorseGenDefinizioneFondiFM;
    DetailDestGen: TWP684FDestGenDefinizioneFondiFM;
    DetailRisorseDett: TWP684FRisorseDettDefinizioneFondiFM;
    DetailDestDett: TWP684FDestDettDefinizioneFondiFM;
    function InizializzaAccesso:Boolean; override;
    procedure AbilitazioniComponenti;
    procedure ApriGrigliaDettDefinizioneFondi;
  end;

implementation

{$R *.dfm}

function TWP684FDefinizioneFondi.InizializzaAccesso;
begin
  Result:=False;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWP684FDefinizioneFondi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.ChiaveReadOnly:=True;
  WR302DM:=TWP684FDefinizioneFondiDM.Create(Self);
  WR100LinkWC700:=False;
  AttivaGestioneC700;

  WBrowseFM:=TWP684FDefinizioneFondiBrowseFM.Create(Self);

  with TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW do
  begin
    selP684Dec.Open;
    if selP684Dec.RecordCount > 0 then
    begin
      selP684Dec.Last;
      (WR302DM as TWP684FDefinizioneFondiDM).selTabella.Locate('DECORRENZA_DA',selP684Dec.FieldByName('DECORRENZA').AsDateTime,[]);
    end;
  end;

  WDettaglioFM:=TWP684FDefinizioneFondiDettFM.Create(Self);

  DetailRisorseGen:=TWP684FRisorseGenDefinizioneFondiFM.Create(Self);
  AggiungiDetail(DetailRisorseGen,'Risorse Generali');
  DetailRisorseGen.CaricaDettaglio(TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP686R,TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.dsrP686R);

  DetailRisorseDett:=TWP684FRisorseDettDefinizioneFondiFM.Create(Self);
  AggiungiDetail(DetailRisorseDett,'Risorse Dettagliate');
  DetailRisorseDett.CaricaDettaglio(TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP688R,TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.dsrP688R);

  DetailDestGen:=TWP684FDestGenDefinizioneFondiFM.Create(Self);
  AggiungiDetail(DetailDestGen,'Destinazioni Generali');
  DetailDestGen.CaricaDettaglio(TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP686D,TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.dsrP686D);

  DetailDestDett:=TWP684FDestDettDefinizioneFondiFM.Create(Self);
  AggiungiDetail(DetailDestDett,'Destinazioni Dettagliate');
  DetailDestDett.CaricaDettaglio(TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP688D,TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.dsrP688D);

  CreaTabDefault;
  GrdTabControl.ActiveTab:=WBrowseFM;
end;

procedure TWP684FDefinizioneFondi.actEliminaExecute(Sender: TObject);
var Mes:String;
begin
  with TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW do
    Mes:=MessaggioCancellazione(selP684.FieldByName('COD_FONDO').AsString,DateToStr(selP684.FieldByName('DECORRENZA_DA').AsDateTime));
  MsgBox.WebMessageDlg(Mes,mtConfirmation,[mbYes,mbNo],ResultConfermaElimina,'');
end;

procedure TWP684FDefinizioneFondi.ResultConfermaElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    EseguiDelete;
end;

procedure TWP684FDefinizioneFondi.AbilitazioniComponenti;
var bEdit: Boolean;
//Gestisco le abilitazioni e disabilitazioni di tutti i componenti della form nelle varie circostanza
begin
  if (WR302DM as TWP684FDefinizioneFondiDM) = nil then exit;
  if not (DetailRisorseGen = nil) then
  begin
    with DetailRisorseGen do
    begin
      bEdit:=grdTabella.medpDataSet.State in [dsInsert,dsEdit];
      actModificaCodiceVoce.Enabled:=not bEdit;
      actRinumeraOrdineStampa.Enabled:=not bEdit;
      actModificaCodiceVoce.Visible:=TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP686R.RecordCount > 0;
      actRinumeraOrdineStampa.Visible:=TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP686R.RecordCount > 0;
      AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
    end;
  end;
  if not (DetailDestGen = nil) then
  begin
    with DetailDestGen do
    begin
      bEdit:=grdTabella.medpDataSet.State in [dsInsert,dsEdit];
      actModificaCodiceVoce.Enabled:=not bEdit;
      actRinumeraOrdineStampa.Enabled:=not bEdit;
      actModificaCodiceVoce.Visible:=TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP686D.RecordCount > 0;
      actRinumeraOrdineStampa.Visible:=TWP684FDefinizioneFondiDM(WR302DM).P684FDefinizioneFondiMW.selP686D.RecordCount > 0;
      AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
    end;
  end;
end;

procedure TWP684FDefinizioneFondi.ApriGrigliaDettDefinizioneFondi;
begin
  WP684FGrigliaDettDefinizioneFondi:=TWP684FGrigliaDettDefinizioneFondi.Create(Self.Owner,
                                                                               False,
                                                                               (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW);
  WC007FM:=TWC007FFormContainerFM.Create(Self.Parent);
  WC007FM.TemplateProcessor.Templates.Default:='WP684FGrigliaDettDefinizioneFondiFM.html';
  WC007FM.ResultEvent:=ResultGrigliaDettDefinizioneFondi;
  WC007FM.popupWidth:=1200;
  WC007FM.popupHeigth:=745;
  WP684FGrigliaDettDefinizioneFondi.grdNavigatorBar.Parent:=WC007FM.IWFrameRegion;
  WP684FGrigliaDettDefinizioneFondi.WP684FGrigliaDettDefinizioneFondiAreaIntestazioneRG.Parent:=WC007FM.IWFrameRegion;
  WP684FGrigliaDettDefinizioneFondi.WP684FGrigliaDettDefinizioneFondiAreaPiedeRG.Parent:=WC007FM.IWFrameRegion;
  WP684FGrigliaDettDefinizioneFondi.WBrowseFM.Parent:=WC007FM.IWFrameRegion;
  WC007FM.Visualizza('Dettaglio importo speso');
end;

procedure TWP684FDefinizioneFondi.ResultGrigliaDettDefinizioneFondi(Sender: TObject);
var Imp:Real;
begin
  if WP684FGrigliaDettDefinizioneFondi <> nil then
  begin
    WP684FGrigliaDettDefinizioneFondi.grdNavigatorBar.Parent:=WP684FGrigliaDettDefinizioneFondi;
    WP684FGrigliaDettDefinizioneFondi.WP684FGrigliaDettDefinizioneFondiAreaIntestazioneRG.Parent:=WP684FGrigliaDettDefinizioneFondi;
    WP684FGrigliaDettDefinizioneFondi.WP684FGrigliaDettDefinizioneFondiAreaPiedeRG.Parent:=WP684FGrigliaDettDefinizioneFondi;
    WP684FGrigliaDettDefinizioneFondi.WBrowseFM.Parent:=WP684FGrigliaDettDefinizioneFondi;
  end;
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
  begin
    if Trim(CodGenElabGrigliaDett) = '' then
      exit;
    if LetturaDettaglioImportoSpeso(selP690.FieldByName('COD_FONDO').AsString,selP690.FieldByName('DECORRENZA_DA').AsDateTime,Imp) then
      MsgBox.WebMessageDlg(A000MSG_P664_DLG_ALLINEA_SPESO,mtConfirmation,[mbYes, mbNo],ResultAllineaSpeso,'');
  end;
end;

procedure TWP684FDefinizioneFondi.ResultAllineaSpeso(Sender: TObject; R: TmeIWModalResult; KI: String);
var Imp:Real;
begin
  if R = mrYes then
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    begin
      LetturaDettaglioImportoSpeso(selP690.FieldByName('COD_FONDO').AsString,selP690.FieldByName('DECORRENZA_DA').AsDateTime,Imp);
      ImpostaImportoSpeso(Imp);
      DetailDestDett.grdTabella.medpAllineaRecordCDS;
    end;
end;

end.
