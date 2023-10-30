unit WA184UFiltroFunzioni;

interface

uses
  Classes, Controls, ActnList, Menus, Forms, StrUtils, SysUtils, Variants,
  IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWCompTabControl, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, IWCompButton,
  IWDBStdCtrls,
  meIWLabel, meIWGrid, meIWDBNavigator,
  medpIWTabControl, medpIWStatusBar, medpIWMessageDlg, meIWButton,
  A000UInterfaccia, A000UCostanti, A000USessione, C180FunzioniGenerali,
  WC009UCopiaSuFM,
  WR100UBase, WR102UGestTabella, WR302UGestTabellaDM, OracleData,
  WA184UFiltroFunzioniBrowseFM, WA184UFiltroFunzioniDettFM, IWCompGrids,A000UMessaggi,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile,
  meIWEdit;

type
  TWA184FFiltroFunzioni = class(TWR102FGestTabella)
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

uses WA184UFiltroFunzioniDM;

{$R *.dfm}

procedure TWA184FFiltroFunzioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA184FFiltroFunzioniDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=True;
  InterfacciaWR102.CopiaSuTabella:='MONDOEDP.I073_FILTROFUNZIONI';
  InterfacciaWR102.CopiaSuChiave:='AZIENDA,PROFILO';
  InterfacciaWR102.CopiaSuChiaveInput:='PROFILO';
  InterfacciaWR102.CopiaSuCampi:='AZIENDA,PROFILO,APPLICAZIONE,DESCRIZIONE,FUNZIONE,GRUPPO,INIBIZIONE,TAG';

  WBrowseFM:=TWA184FFiltroFunzioniBrowseFM.Create(Self);
  WDettaglioFM:=TWA184FFiltroFunzioniDettFM.Create(Self);

  CreaTabDefault;
  AddScrollBarManager('divscrollable');
end;

function TWA184FFiltroFunzioni.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('AZIENDA;PROFILO',VarArrayOf([GetParam('AZIENDA'),GetParam('PROFILO')]),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA184FFiltroFunzioni.actConfermaExecute(Sender: TObject);
var
  Azienda,Profilo:string;
begin
  Azienda:=TWA184FFiltroFunzioniDM(WR302DM).selI073.FieldByName('AZIENDA').AsString;
  Profilo:=TWA184FFiltroFunzioniDM(WR302DM).selI073.FieldByName('PROFILO').AsString;
  TWA184FFiltroFunzioniDM(WR302DM).SalvaFunzioni;
  TWA184FFiltroFunzioniDM(WR302DM).selTabella.Refresh;
  WR302DM.selTabella.Locate('AZIENDA;PROFILO',VarArrayOf([Azienda,Profilo]),[]);
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA184FFiltroFunzioni.actAnnullaExecute(Sender: TObject);
begin
  TWA184FFiltroFunzioniDM(WR302DM).selI073.Cancel;
  TWA184FFiltroFunzioniDettFM(WDettaglioFM).TrasformaComponenti(False);
end;

procedure TWA184FFiltroFunzioni.actEliminaExecute(Sender: TObject);
var S:String;
begin
  //Eseguire query per applicazione diversa da Parametri.Applicazione e INIBIZIONE <> 'N'.
  with TWA184FFiltroFunzioniDM(WR302DM) do
  begin
    if ProfiloUtilizzato then
      raise Exception.Create(A000MSG_ERR_ELIMINA_PROFILO);
    selI073Applicazione.Close;
    selI073Applicazione.SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
    selI073Applicazione.SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
    selI073Applicazione.SetVariable('APPLICAZIONE',Parametri.Applicazione);
    selI073Applicazione.Open;
    S:='';
    while not selI073Applicazione.Eof do
    begin
      S:=S + IfThen(S <> '',',','') + selI073Applicazione.FieldByName('APPLICAZIONE').AsString;
      selI073Applicazione.Next;
    end;
    selI073Applicazione.Close;
  end;

  if S <> '' then
    S:=Format(A000MSG_A184_DLG_FMT_CANCELLA,[S])
  else
    S:=A000MSG_DLG_CANCELLAZIONE;
  MsgBox.WebMessageDlg(S ,mtConfirmation,[mbYes,mbNo],ResDelete,'');
end;

procedure TWA184FFiltroFunzioni.ResDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
var Azienda,Profilo:String;
begin
  if R = mrYes then
  begin
    with TWA184FFiltroFunzioniDM(WR302DM) do
    begin
      RegistraLog.SettaProprieta('C','I073_FILTROFUNZIONI',Copy(Name,1,5),nil,True);
      RegistraLog.InserisciDato('AZIENDA',selTabella.FieldByName('AZIENDA').AsString,'');
      RegistraLog.InserisciDato('PROFILO',selTabella.FieldByName('PROFILO').AsString,'');
      delI073.SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
      delI073.SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
      delI073.Execute;
      RegistraLog.RegistraOperazione;
      selTabella.Next;
      if selTabella.Eof then
        selTabella.Prior;
      Azienda:=selTabella.FieldByName('AZIENDA').AsString;
      Profilo:=selTabella.FieldByName('PROFILO').AsString;
      selTabella.Refresh;
    end;
    SessioneOracle.Commit;
    WR302DM.selTabella.Locate('AZIENDA;PROFILO',VarArrayOf([Azienda,Profilo]),[]);
    WBrowseFM.grdTabella.medpAggiornaCDS;
    AggiornaRecord;
  end;
end;

procedure TWA184FFiltroFunzioni.actModificaExecute(Sender: TObject);
begin
  grdTabControl.ActiveTab:=WDettaglioFM;
  TWA184FFiltroFunzioniDM(WR302DM).selI073.Edit;
  TWA184FFiltroFunzioniDettFM(WDettaglioFM).TrasformaComponenti(True);
  MessaggioStatus(INFORMA,'Modifica');
end;

procedure TWA184FFiltroFunzioni.actNuovoExecute(Sender: TObject);
begin
  grdTabControl.ActiveTab:=WDettaglioFM;
  TWA184FFiltroFunzioniDM(WR302DM).selI073.Filtered:=False;
  TWA184FFiltroFunzioniDM(WR302DM).selI073.Insert;
  TWA184FFiltroFunzioniDettFM(WDettaglioFM).cdsI073.EmptyDataset;
  MessaggioStatus(INFORMA,'Inserimento');
end;

end.
