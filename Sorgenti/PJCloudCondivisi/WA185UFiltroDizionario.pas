unit WA185UFiltroDizionario;

interface

uses
  WA185UFiltroDizionarioBrowseFM, WA185UFiltroDizionarioDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  IWCompButton, WR102UGestTabella, OracleData,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, C180FunzioniGenerali,
  medpIWMessageDlg, WC009UCopiaSuFM, IWCompGrids,A000UMessaggi,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile,
  meIWEdit, Oracle;

type
  TWA185FFiltroDizionario = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
  private
    function InizializzaAccesso: Boolean; override;
    procedure ResDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
  end;

implementation

uses WA185UFiltroDizionarioDM;

{$R *.dfm}

procedure TWA185FFiltroDizionario.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA185FFiltroDizionarioDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=True;
  InterfacciaWR102.CopiaSuTabella:='MONDOEDP.I074_FILTRODIZIONARIO';
  InterfacciaWR102.CopiaSuChiave:='AZIENDA,PROFILO';
  InterfacciaWR102.CopiaSuChiaveInput:='PROFILO';
  InterfacciaWR102.CopiaSuCampi:='AZIENDA,PROFILO,TABELLA,CODICE,ABILITATO';

  WDettaglioFM:=TWA185FFiltroDizionarioDettFM.Create(Self);
  WBrowseFM:=TWA185FFiltroDizionarioBrowseFM.Create(Self);
  CreaTabDefault;
end;

function TWA185FFiltroDizionario.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('AZIENDA;PROFILO',VarArrayOf([GetParam('AZIENDA'),GetParam('PROFILO')]),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA185FFiltroDizionario.actAggiornaExecute(Sender: TObject);
begin
  TWA185FFiltroDizionarioDM(WR302DM).selTabella.Refresh;
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA185FFiltroDizionario.actAnnullaExecute(Sender: TObject);
begin
  TWA185FFiltroDizionarioDM(WR302DM).selI074.Cancel;
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA185FFiltroDizionario.actConfermaExecute(Sender: TObject);
var
  Azienda,Profilo:string;
begin
  Azienda:=TWA185FFiltroDizionarioDM(WR302DM).selI074.FieldByName('AZIENDA').AsString;
  Profilo:=TWA185FFiltroDizionarioDM(WR302DM).selI074.FieldByName('PROFILO').AsString;
  //verifica filtro anagrafe.fine
  TWA185FFiltroDizionarioDM(WR302DM).PutFiltroDizionario;
  TWA185FFiltroDizionarioDM(WR302DM).selTabella.Refresh;
  TWA185FFiltroDizionarioDM(WR302DM).selI074.Refresh;

  WR302DM.selTabella.Locate('AZIENDA;PROFILO',VarArrayOf([Azienda,Profilo]),[]);
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA185FFiltroDizionario.actEliminaExecute(Sender: TObject);
begin
  if TWA185FFiltroDizionarioDM(WR302DM).ProfiloUtilizzato then
    raise Exception.Create(A000MSG_ERR_ELIMINA_PROFILO);
  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResDelete,'');
end;

procedure TWA185FFiltroDizionario.ResDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
var Azienda,Profilo:String;
begin
  if R = mrYes then
  begin
    with TWA185FFiltroDizionarioDM(WR302DM) do
    begin
      selI074.Refresh;
      selI074.First;
      while not selI074.Eof do
        selI074.Delete;

      selTabella.Next;
      if selTabella.Eof then
        selTabella.Prior;
      Azienda:=selTabella.FieldByName('AZIENDA').AsString;
      Profilo:=selTabella.FieldByName('PROFILO').AsString;
      selTabella.Refresh;
    end;
    RegistraLog.SettaProprieta('C','I074_FILTRODIZIONARIO',Copy(Name,1,5),nil,True);
    RegistraLog.RegistraOperazione;
    SessioneOracle.Commit;
    //R010PagGridSeleziona(WBrowseFM.grdTabella);
    WR302DM.selTabella.Locate('AZIENDA;PROFILO',VarArrayOf([Azienda,Profilo]),[]);
    WBrowseFM.grdTabella.medpAggiornaCDS;
    AggiornaRecord;
  end;
end;


procedure TWA185FFiltroDizionario.actModificaExecute(Sender: TObject);
begin
  //grdTabControl.SelezionaTab(WDettaglioFM);
  grdTabControl.ActiveTab:=WDettaglioFM;
  TWA185FFiltroDizionarioDM(WR302DM).selI074.Edit;

  MessaggioStatus(INFORMA,'Modifica');
end;

procedure TWA185FFiltroDizionario.actNuovoExecute(Sender: TObject);
var Azienda: String;
begin
  Azienda:=TWA185FFiltroDizionarioDM(WR302DM).selI074.FieldByName('AZIENDA').AsString;
  grdTabControl.ActiveTab:=WDettaglioFM;
  TWA185FFiltroDizionarioDM(WR302DM).selI074.Insert;
  TWA185FFiltroDizionarioDM(WR302DM).selI074.FieldByName('AZIENDA').AsString:=Azienda;

  TWA185FFiltroDizionarioDettFM(WDettaglioFM).imgDeselezionaTuttoAsyncClick(nil,nil);
  MessaggioStatus(INFORMA,'Inserimento');
end;

end.
