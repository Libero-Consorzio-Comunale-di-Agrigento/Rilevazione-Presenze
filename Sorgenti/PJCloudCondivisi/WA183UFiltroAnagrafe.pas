unit WA183UFiltroAnagrafe;

interface

uses
  WA183UFiltroAnagrafeBrowseFM, WA183UFiltroAnagrafeDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  IWCompButton, WR102UGestTabella, OracleData,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  C180FunzioniGenerali,
  medpIWMessageDlg, WC009UCopiaSuFM,  IWCompGrids,A000UMessaggi,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile,
  meIWEdit;

type
  TWA183FFiltroAnagrafe = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  private
    function InizializzaAccesso: Boolean; override;
    procedure ResDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
  end;

implementation

uses WA183UFiltroAnagrafeDM;

{$R *.dfm}

procedure TWA183FFiltroAnagrafe.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA183FFiltroAnagrafeDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=True;
  InterfacciaWR102.CopiaSuChiave:='AZIENDA,PROFILO';
  InterfacciaWR102.CopiaSuChiaveInput:='PROFILO';
  InterfacciaWR102.CopiaSuCampi:='AZIENDA,PROFILO,PROGRESSIVO,SELEZIONE_RICHIESTA_PORTALE,FILTRO';

  WR100LinkWC700:=False;
  AttivaGestioneC700;

  WDettaglioFM:=TWA183FFiltroAnagrafeDettFM.Create(Self);
  WBrowseFM:=TWA183FFiltroAnagrafeBrowseFM.Create(Self);
  CreaTabDefault;
  jqWatermark.Enabled:=True;
end;

function TWA183FFiltroAnagrafe.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('AZIENDA;PROFILO',VarArrayOf([GetParam('AZIENDA'),GetParam('PROFILO')]),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA183FFiltroAnagrafe.actNuovoExecute(Sender: TObject);
begin
  grdTabControl.ActiveTab:=WDettaglioFM;
  TWA183FFiltroAnagrafeDM(WR302DM).selI072.Insert;
  TWA183FFiltroAnagrafeDettFM(WDettaglioFM).memFiltroAnagrafe.Clear;
  TWA183FFiltroAnagrafeDettFM(WDettaglioFM).chkSelezioneRichiestaPortale.Checked:=False;
  MessaggioStatus(INFORMA,'Inserimento');
end;

procedure TWA183FFiltroAnagrafe.actModificaExecute(Sender: TObject);
begin
  grdTabControl.ActiveTab:=WDettaglioFM;
  TWA183FFiltroAnagrafeDM(WR302DM).selI072.Edit;
  MessaggioStatus(INFORMA,'Modifica');
end;

procedure TWA183FFiltroAnagrafe.actAnnullaExecute(Sender: TObject);
begin
  TWA183FFiltroAnagrafeDM(WR302DM).selI072.Cancel;
  WBrowseFM.grdTabella.medpAggiornaCDS(False);
  TWA183FFiltroAnagrafeDM(WR302DM).selTabella.AfterScroll(nil);

end;

procedure TWA183FFiltroAnagrafe.actConfermaExecute(Sender: TObject);
var
  Azienda,Profilo,S:string;
begin
  S:=TWA183FFiltroAnagrafeDM(TWA183FFiltroAnagrafe(Self.Owner).WR302DM).VerificaFiltro(TWA183FFiltroAnagrafeDettFM(WDettaglioFM).memFiltroAnagrafe.Lines.Text);
  if S <> '' then
    raise Exception.Create(Format(A000MSG_A183_ERR_FMT_FILTRO,[S]));

  Azienda:=TWA183FFiltroAnagrafeDM(WR302DM).selI072.FieldByName('AZIENDA').AsString;
  Profilo:=TWA183FFiltroAnagrafeDM(WR302DM).selI072.FieldByName('PROFILO').AsString;
  TWA183FFiltroAnagrafeDM(WR302DM).PutFiltroAnagrafe;
  TWA183FFiltroAnagrafeDM(WR302DM).selTabella.Refresh;

  //WBrowseFM.CreaColonne;
  WR302DM.selTabella.Locate('AZIENDA;PROFILO',VarArrayOf([Azienda,Profilo]),[]);
  WBrowseFM.grdTabella.medpAggiornaCDS;
  //R010PagGridSeleziona(WBrowseFM.grdTabella);
end;

procedure TWA183FFiltroAnagrafe.actEliminaExecute(Sender: TObject);
begin
  if TWA183FFiltroAnagrafeDM(WR302DM).ProfiloUtilizzato then
    raise Exception.Create(A000MSG_ERR_ELIMINA_PROFILO);
  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResDelete,'');
end;

procedure TWA183FFiltroAnagrafe.ResDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
var Azienda,Profilo:String;
begin
  if R = mrYes then
  begin
    TWA183FFiltroAnagrafeDM(WR302DM).selI072.First;
    while not TWA183FFiltroAnagrafeDM(WR302DM).selI072.Eof do
      TWA183FFiltroAnagrafeDM(WR302DM).selI072.Delete;
    if WR302DM.selTabella.Eof then
      WR302DM.selTabella.Prior;
    Azienda:=WR302DM.selTabella.FieldByName('AZIENDA').AsString;
    Profilo:=WR302DM.selTabella.FieldByName('PROFILO').AsString;
    TWA183FFiltroAnagrafeDM(WR302DM).selTabella.Refresh;
    WR302DM.selTabella.Locate('AZIENDA;PROFILO',VarArrayOf([Azienda,Profilo]),[]);
    //R010PagGridSeleziona(WBrowseFM.grdTabella);
    WBrowseFM.grdTabella.medpAggiornaCDS;
    RegistraLog.SettaProprieta('C','I072_FILTROANAGRAFE',Copy(Name,1,5),nil,True);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    AggiornaRecord;
  end;
end;

end.
