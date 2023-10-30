unit S031UFamiliari;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  R004UGESTSTORICO, Grids, DBGrids, ExtCtrls, Menus, DBCtrls, ImgList, Db, Winapi.ShellAPI,
  ComCtrls, ToolWin, StdCtrls, Mask, Buttons, C700USelezioneAnagrafe, A003UDataLavoroBis,
  A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, A011UComuniProvinceRegioni,
  C005UDatiAnagrafici, C013UCheckList, C021UDocumentiManagerDM, C180FunzioniGenerali, SelAnagrafe,
  OracleData, ActnList, Variants, System.IOUtils,
  System.Actions, S031UFamiliariMW, System.ImageList;

type
  TElencoNumOrd = record
    NumOrd:Integer;
    Colorata:Boolean;
  end;

  TS031FFamiliari = class(TR004FGestStorico)
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    dgrdDATIBASE: TDBGrid;
    frmSelAnagrafe: TfrmSelAnagrafe;
    btnCarica: TBitBtn;
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    tabDatiAnagrafici: TTabSheet;
    tabLegge104: TTabSheet;
    tabDatiStipendiali: TTabSheet;
    tabNote: TTabSheet;
    dmemNote: TDBMemo;
    GroupBox1: TGroupBox;
    lblRedditoANF: TLabel;
    lblRedditoAltroANF: TLabel;
    lblTotaleANF: TLabel;
    dchkANFSpeciale: TDBCheckBox;
    dchkANF: TDBCheckBox;
    dchkANFInabile: TDBCheckBox;
    dedtREDDITOANF: TDBEdit;
    dedtRedditoAltroANF: TDBEdit;
    edtTotaleANF: TEdit;
    lblNUMORD: TLabel;
    lblCOGNOME: TLabel;
    lblDataNas: TLabel;
    lblComNas: TLabel;
    lblProvNas: TLabel;
    lblDATAMAT: TLabel;
    lblDATASEP: TLabel;
    lblNOME: TLabel;
    lblMatricola: TLabel;
    lblDataAdoz: TLabel;
    lblCodFiscale: TLabel;
    lblDataNasPresunta: TLabel;
    lblCapNas: TLabel;
    dedtNUMORD: TDBEdit;
    dedtCOGNOME: TDBEdit;
    dcmbComNas: TDBLookupComboBox;
    dedtProvNas: TDBEdit;
    dedtDATAMAT: TDBEdit;
    dedtDATASEP: TDBEdit;
    dedtNOME: TDBEdit;
    dedtCOMNAS: TDBEdit;
    dedtDataNas: TDBEdit;
    dcmbMatricola: TDBLookupComboBox;
    dedtDataAdoz: TDBEdit;
    drgpSesso: TDBRadioGroup;
    dedtCodFiscale: TDBEdit;
    dedtDataNasPresunta: TDBEdit;
    dedtCAPNas: TDBEdit;
    Panel1: TPanel;
    gpbAnnoAvv: TGroupBox;
    lblAnnoAvv: TLabel;
    lblAnnoAvvFam: TLabel;
    dedtAnnoAvv: TDBEdit;
    dedtAnnoAvvFam: TDBEdit;
    gpbDisabilita: TGroupBox;
    lblAnnoRevisione: TLabel;
    lblTipoDisabilita: TLabel;
    gpbFamiliare: TGroupBox;
    lblDurataContratto: TLabel;
    lblNomePA: TLabel;
    gpbAlternativa: TGroupBox;
    lblAlternativaNomePA: TLabel;
    lblAlternativaMotivoTerzoGrado: TLabel;
    lblAlternativa: TLabel;
    cmbAlternativaMotivoTerzoGrado: TComboBox;
    cmbAlternativa: TComboBox;
    cmbDurataContratto: TComboBox;
    cmbTipoDisabilita: TComboBox;
    gpbCausali: TGroupBox;
    dedtCausaliAbilitate: TDBEdit;
    btnCausali: TButton;
    gpbResidenza: TGroupBox;
    dedtIndirizzo: TDBEdit;
    lblIndirizzo: TLabel;
    dcmbComune: TDBLookupComboBox;
    lblComune: TLabel;
    dedtComune: TDBEdit;
    dedtCAP: TDBEdit;
    lblCap: TLabel;
    dedtProvincia: TDBEdit;
    lblProvincia: TLabel;
    dedtTelefono: TDBEdit;
    lblTelefono: TLabel;
    gpbDetrazioniIRPEF: TGroupBox;
    lblPERC_CARICO: TLabel;
    lblDATA_ULT_FAM_CAR: TLabel;
    drgpTIPO_DETRAZIONE: TDBRadioGroup;
    dedtPERC_CARICO: TDBEdit;
    dchkDetrFiglioHandicap: TDBCheckBox;
    dedtDATA_ULT_FAM_CAR: TDBEdit;
    dchkDetr100Affid: TDBCheckBox;
    cmbNomePA: TComboBox;
    cmbAlternativaNomePA: TComboBox;
    MnuCopia: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    N9: TMenuItem;
    Copia1: TMenuItem;
    CopiaInExcel: TMenuItem;
    cmbTipoAdoz: TComboBox;
    lblTipoAdoz: TLabel;
    dedtDataPreAdoz: TDBEdit;
    lblDataPreAdoz: TLabel;
    lblNumGrado: TLabel;
    lblTipoPar: TLabel;
    lblParentela: TLabel;
    lblMotivoTerzoGrado: TLabel;
    dedtNumGrado: TDBEdit;
    cmbParentela: TComboBox;
    cmbTipoPar: TComboBox;
    cmbMotivoTerzoGrado: TComboBox;
    gpbGravidanza: TGroupBox;
    dedtGravInizioTeorico: TDBEdit;
    lblGravInizioTeorico: TLabel;
    dedtGravInizioScelto: TDBEdit;
    lblGravInizioScelto: TLabel;
    dedtGravInizioEffettivo: TDBEdit;
    lblGravInizioEffettivo: TLabel;
    dedtGravFine: TDBEdit;
    lblGravFine: TLabel;
    dedtAnnoRevisione: TDBEdit;
    btnGravInizioTeorico: TButton;
    btnGravInizioScelto: TButton;
    btnGravInizioEffettivo: TButton;
    btnGravFine: TButton;
    btnDataPreAdoz: TButton;
    btnDataSep: TButton;
    btnDataMat: TButton;
    btnAnnoRevisione: TButton;
    btnDATA_ULT_FAM_CAR: TButton;
    dcmbNazionalita: TDBLookupComboBox;
    lblNazionalita: TLabel;
    cmbMotivoEsclusione: TComboBox;
    lblMotivoEscl: TLabel;
    dedtNumCartaId: TDBEdit;
    lblNumCartaId: TLabel;
    dedtDataRilascioCartaId: TDBEdit;
    btnDataRilascioCartaId: TButton;
    lblDataRilascioCartaId: TLabel;
    dedtDataScadenzaCartaId: TDBEdit;
    btnDataScadenzaCartaId: TButton;
    lblDataScadenzaCartaId: TLabel;
    dchkInserimentoCU: TDBCheckBox;
    dEdtNumPassaporto: TDBEdit;
    dEdtDataRilascioPassaporto: TDBEdit;
    dEdtDataScadenzaPassaporto: TDBEdit;
    lblNumPassaporto: TLabel;
    lblDataRilascioPassaporto: TLabel;
    lblDataScadenzaPassaporto: TLabel;
    btnDataRilascioPassaporto: TButton;
    btnDataScadenzaPassaporto: TButton;
    tabDocumenti: TTabSheet;
    dgrdDocumenti: TDBGrid;
    ActionList2: TActionList;
    actFileDownload: TAction;
    actFileVisualizza: TAction;
    actAccediDocumento: TAction;
    pmnAzioniDocumento: TPopupMenu;
    Apri1: TMenuItem;
    Salva1: TMenuItem;
    MenuItem1: TMenuItem;
    Accedi1: TMenuItem;
    N5: TMenuItem;
    mnuCopiaExcel: TMenuItem;
    dlgFileSave: TSaveDialog;
    procedure TAnnullaClick(Sender: TObject);
    procedure dedtREDDITOANFExit(Sender: TObject);
    procedure dedtCodFiscaleKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dedtCodFiscaleEnter(Sender: TObject);
    procedure dcmbMatricolaKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure btnCausaliClick(Sender: TObject);
    procedure dedtCAPNasDblClick(Sender: TObject);
    procedure dedtCAPNasKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure dcmbMatricolaCloseUp(Sender: TObject);
    procedure dcmbMatricolaKeyUp(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnCaricaClick(Sender: TObject);
    procedure cmbParentelaCloseUp(Sender: TObject);
    procedure cmbParentelaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TInserClick(Sender: TObject);
    procedure drgpTIPO_DETRAZIONEClick(Sender: TObject);
    procedure dedtPERC_CARICOExit(Sender: TObject);
    procedure dedtNumGradoChange(Sender: TObject);
    procedure cmbAlternativaCloseUp(Sender: TObject);
    procedure cmbAlternativaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbTipoDisabilitaCloseUp(Sender: TObject);
    procedure cmbTipoDisabilitaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TRegisClick(Sender: TObject);
    procedure cmbTipoParKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TModifClick(Sender: TObject);
    procedure cmbNomePAChange(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure dgrdDATIBASEDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Visionecorrente1Click(Sender: TObject);
    procedure btnGravInizioTeoricoClick(Sender: TObject);
    procedure btnGravInizioSceltoClick(Sender: TObject);
    procedure btnGravInizioEffettivoClick(Sender: TObject);
    procedure btnGravFineClick(Sender: TObject);
    procedure btnDataPreAdozClick(Sender: TObject);
    procedure btnDataSepClick(Sender: TObject);
    procedure btnDataMatClick(Sender: TObject);
    procedure btnAnnoRevisioneClick(Sender: TObject);
    procedure btnDATA_ULT_FAM_CARClick(Sender: TObject);
    procedure dedtDataPreAdozChange(Sender: TObject);
    procedure btnDataRilascioCartaIdClick(Sender: TObject);
    procedure btnDataScadenzaCartaIdClick(Sender: TObject);
    procedure btnDataRilascioPassaportoClick(Sender: TObject);
    procedure btnDataScadenzaPassaportoClick(Sender: TObject);
    procedure Apri1Click(Sender: TObject);
    procedure Salva1Click(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure pmnAzioniDocumentoPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FC021DM: TC021FDocumentiManagerDM;
    FAbilitaGestioneA154: Boolean;
    ElencoNumOrd:array of TElencoNumOrd;
    procedure AggiornaAccesso;
    procedure CambiaProgressivo;
    procedure CaricaLista;
    procedure CaricaNomePA(Combo:TComboBox);
    procedure CaricaElencoNumOrd;
  public
    procedure AllineaComponenti;
    procedure AbilitaComponenti;
  end;

var
  S031FFamiliari: TS031FFamiliari;

procedure OpenS031Familiari(Prog:Integer);

implementation

uses S031UFamiliariDtM,
     A154UGestioneDocumentale;

{$R *.DFM}

procedure OpenS031Familiari(Prog:Integer);
begin
  if Prog <= 0 then
  begin
    ShowMessage(A000MSG_ERR_NO_DIP);
    exit;
  end;
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenS031Familiari') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  S031FFamiliari:=TS031FFamiliari.Create(nil);
  with S031FFamiliari do
  try
    C700Progressivo:=Prog;
    S031FFamiliariDtM:=TS031FFamiliariDtM.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    S031FFamiliariDtM.Free;
    Free;
  end;
end;

procedure TS031FFamiliari.FormShow(Sender: TObject);
begin
  inherited;

  // scorciatoia per datamodulo di servizio per allegati
  FC021DM:=S031FFamiliariDtM.S031FFamiliariMW.C021DM;

  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(S031FFamiliariDtM.S031FFamiliariMW,SessioneOracle,StatusBar,3,True);

  PageControl1.ActivePage:=tabDatiAnagrafici;
  VisioneCorrente1Click(nil);
end;

procedure TS031FFamiliari.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    S031FFamiliariDtM.SettaProgressivo;
    GetDateDecorrenza;
    NumRecords;
    AllineaComponenti;
    AbilitaComponenti;
  end;
end;

procedure TS031FFamiliari.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dgrdDatiBase.Enabled:=DButton.State = dsBrowse;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
  btnCarica.Enabled:=DButton.State = dsBrowse;
  btnCausali.Enabled:=DButton.State in [dsEdit,dsInsert];
  AbilitaComponenti;

  // blocca modifica numero ordine in inserimento
  //dedtNUMORD.ReadOnly:=DButton.State = dsInsert;

  // blocca campi anagrafici fissi in fase di storicizzazione
  with S031FFamiliariDtm.QSG101 do
  begin
    FieldByName('NUMORD').ReadOnly:=DButton.State = dsInsert;
    FieldByName('MATRICOLA').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('COGNOME').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('NOME').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('SESSO').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('DATANAS').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('COMNAS').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('CAPNAS').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('CODFISCALE').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('DATAMAT').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
    FieldByName('INSERIMENTO_CU').ReadOnly:=InterfacciaR004.StoricizzazioneInCorso;
  end;
end;

procedure TS031FFamiliari.Nuovoelemento1Click(Sender: TObject);
{Carica la Struttura griglia con i dati della tabella}
begin
  if PopupMenu1.PopupComponent.Name = 'dcmbComNas' then
    OpenA011ComuniProvinceRegioni(dedtComNas.Text,'C')
  else if PopupMenu1.PopupComponent.Name = 'dcmbNazionalita' then
    OpenA011ComuniProvinceRegioni(VarToStr(dcmbNazionalita.KeyValue),'N')
  else
    OpenA011ComuniProvinceRegioni(dedtComune.Text,'C');
  S031FFamiliariDtM.S031FFamiliariMW.Q480.Close;
  S031FFamiliariDtM.S031FFamiliariMW.Q480.Open;
  S031FFamiliariDtM.S031FFamiliariMW.selT483.Close;
  S031FFamiliariDtM.S031FFamiliariMW.selT483.Open;
end;

procedure TS031FFamiliari.pmnAzioniDocumentoPopup(Sender: TObject);
var
  LAbilita: Boolean;
begin
  inherited;
  LAbilita:=(DButton.DataSet.Active ) and (S031FFamiliariDtM.S031FFamiliariMW.selT960.RecordCount > 0);
  actFileDownload.Visible:=LAbilita and Parametri.ModuloInstallato['GESTIONE_DOCUMENTALE'];
  actFileVisualizza.Visible:=LAbilita and Parametri.ModuloInstallato['GESTIONE_DOCUMENTALE'];
  actAccediDocumento.Visible:=FAbilitaGestioneA154 and LAbilita;
end;

procedure TS031FFamiliari.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDatiBase,'S');
end;

procedure TS031FFamiliari.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  C005DataVisualizzazione:=Parametri.DataLavoro;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TS031FFamiliari.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDatiBase,'C');
end;

procedure TS031FFamiliari.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TS031FFamiliari.FormCreate(Sender: TObject);
begin
  inherited;

  // valuta abilitazione gestione documenti
  FAbilitaGestioneA154:=A000GetInibizioni('Tag','76') <> 'N';
end;

procedure TS031FFamiliari.FormDestroy(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TS031FFamiliari.dcmbMatricolaCloseUp(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TS031FFamiliari.dcmbMatricolaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TS031FFamiliari.dcmbMatricolaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not dcmbMatricola.ListVisible then
    dcmbMatricolaCloseUp(nil);
end;

procedure TS031FFamiliari.dedtCAPNasDblClick(Sender: TObject);
begin
  inherited;
  {Ricava il CAP dalla tabella comuni se si fa DoppiClick}
  if S031FFamiliariDtM.QSG101.State in [dsInsert,dsEdit] then
    if Sender = dedtCAPNas then
      with S031FFamiliariDtM.QSG101 do
        FieldByName('CAPNas').AsString:=FieldByName('D_CAPNAS').AsString
    else
      with S031FFamiliariDtM.QSG101 do
        FieldByName('CAP').AsString:=FieldByName('D_CAP').AsString;
end;

procedure TS031FFamiliari.dedtCAPNasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  {Ricava il CAP dalla tabella comuni se si preme Ctrl + Enter}
  if (Key = 13) and (Shift = [ssCtrl]) then
    dedtCAPNasDblClick(Sender);
end;

procedure TS031FFamiliari.dedtCodFiscaleEnter(Sender: TObject);
begin
  inherited;
  if (dedtCodFiscale.DataSource.State in [dsEdit,dsInsert]) and (Trim(dedtCodFiscale.Field.AsString) = '') then
    with S031FFamiliariDtM.QSG101 do
      dedtCodFiscale.Field.AsString:=R180CalcoloCodiceFiscale(FieldByName('Cognome').AsString,
                                                       FieldByName('Nome').AsString,
                                                       FieldByName('Sesso').AsString,
                                                       FieldByName('D_CodCatastale').AsString,
                                                       FieldByName('DataNas').AsDateTime);
end;

procedure TS031FFamiliari.dedtCodFiscaleKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
   if (dedtCodFiscale.DataSource.State in [dsEdit,dsInsert]) and (Key = 13) and (Shift = [ssCtrl]) then
    with S031FFamiliariDtM.QSG101 do
      dedtCodFiscale.Field.AsString:=R180CalcoloCodiceFiscale(FieldByName('Cognome').AsString,
                                                       FieldByName('Nome').AsString,
                                                       FieldByName('Sesso').AsString,
                                                       FieldByName('D_CodCatastale').AsString,
                                                       FieldByName('DataNas').AsDateTime);
end;

procedure TS031FFamiliari.dedtDataPreAdozChange(Sender: TObject);
begin
  inherited;
  R180ClearDBEditDateTime(Sender);
end;

procedure TS031FFamiliari.dedtNumGradoChange(Sender: TObject);
begin
  inherited;
  lblMotivoTerzoGrado.Enabled:=(dedtNumGrado.Text = '3');
  cmbMotivoTerzoGrado.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (dedtNumGrado.Text = '3');
  if not cmbMotivoTerzoGrado.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbMotivoTerzoGrado.ItemIndex:=-1;
end;

procedure TS031FFamiliari.dedtPERC_CARICOExit(Sender: TObject);
begin
  inherited;
  drgpTIPO_DETRAZIONEClick(nil);
end;

procedure TS031FFamiliari.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  AllineaComponenti;
  AbilitaComponenti;
  dedtDecorrenza.SetFocus;
end;

procedure TS031FFamiliari.btnCaricaClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor:=crHourGlass;
  cmbParentela.ItemIndex:=GP_NESSUNO;
  dcmbMatricola.KeyValue:=C700SelAnagrafe.FieldByName('MATRICOLA').AsString;
  S031FFamiliariDtM.QSG101.AfterScroll:=nil;
  S031FFamiliariDtM.QSG101.OnCalcFields:=nil;
  S031FFamiliariDtM.QSG101.BeforePost:=nil;
  S031FFamiliariDtM.QSG101.AfterPost:=nil;
  S031FFamiliariDtM.S031FFamiliariMW.CaricaSeStesso;
  S031FFamiliariDtM.QSG101.Refresh;
  S031FFamiliariDtM.QSG101.BeforePost:=S031FFamiliariDtM.BeforePost;
  S031FFamiliariDtM.QSG101.AfterPost:=S031FFamiliariDtM.AfterPost;
  S031FFamiliariDtM.QSG101.OnCalcFields:=S031FFamiliariDtM.QSG101CalcFields;
  S031FFamiliariDtM.QSG101.AfterScroll:=S031FFamiliariDtM.QSG101AfterScroll;
  Screen.Cursor:=crDefault;
  actRefresh.Execute;
  S031FFamiliariDtM.QSG101.Last;
end;

procedure TS031FFamiliari.btnCausaliClick(Sender: TObject);
var S:String;
begin
  inherited;
  C013FCheckList:=TC013FCheckList.Create(nil);
  C013FCheckList.Caption:='Scelta causali fruibili';
  with C013FCheckList do
  try
    S:=dedtCausaliAbilitate.Field.AsString;
    CaricaLista;
    R180PutCheckList(S,5,C013FCheckList.clbListaDati);
    if ShowModal = mrOK then
    begin
      dedtCausaliAbilitate.Field.AsString:=R180GetCheckList(5,C013FCheckList.clbListaDati);
      if Copy(dedtCausaliAbilitate.Field.AsString,1,2) = '*,' then
        dedtCausaliAbilitate.Field.AsString:='*';
    end;
  finally
    Release;
  end;
end;

procedure TS031FFamiliari.btnDataMatClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATAMAT').AsDateTime,'Data matrimonio','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATAMAT').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataPreAdozClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATA_PREADOZ').AsDateTime,'Data pre-adozione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATA_PREADOZ').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataRilascioCartaIdClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('CARTA_ID_DATA_RIL').AsDateTime,'Data rilascio carta identità','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('CARTA_ID_DATA_RIL').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataRilascioPassaportoClick(Sender: TObject);
var
  d:TDateTime;
begin
  inherited;
  d:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('PASSAPORTO_DATA_RIL').AsDateTime,'Data rilascio passaporto','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('PASSAPORTO_DATA_RIL').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataScadenzaCartaIdClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('CARTA_ID_DATA_SCAD').AsDateTime,'Data scadenza carta identità','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('CARTA_ID_DATA_SCAD').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataScadenzaPassaportoClick(Sender: TObject);
var
  D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('PASSAPORTO_DATA_SCAD').AsDateTime,'Data scadenza passaporto','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('PASSAPORTO_DATA_SCAD').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDataSepClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATASEP').AsDateTime,'Data esclusione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATASEP').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnDATA_ULT_FAM_CARClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('DATA_ULT_FAM_CAR').AsDateTime,'Data ultima dichiarazione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('DATA_ULT_FAM_CAR').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravInizioTeoricoClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime,'Data inizio teorico','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_TEOR').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravFineClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_FINE').AsDateTime,'Data fine effettiva','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_FINE').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravInizioEffettivoClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime,'Data inizio effettivo','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_EFF').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnGravInizioSceltoClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime,'Data inizio scelto dal dip.','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('GRAV_INIZIO_SCELTA').AsDateTime:=D;
end;

procedure TS031FFamiliari.btnAnnoRevisioneClick(Sender: TObject);
var D:TDateTime;
begin
  inherited;
  D:=DataOut(S031FFamiliariDtM.QSG101.FieldByName('ANNO_REVISIONE').AsDateTime,'Data revisione','G',True);
  if D <> 0 then
    S031FFamiliariDtM.QSG101.FieldByName('ANNO_REVISIONE').AsDateTime:=D;
end;

procedure TS031FFamiliari.CaricaLista;
begin
  with S031FFamiliariDtM.S031FFamiliariMW.selT265 do
  begin
    Open;
    First;
    C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',['*','Tutte le causali']));
    while not Eof do
    begin
      C013FCheckList.clbListaDati.Items.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
  end;
end;

procedure TS031FFamiliari.cmbAlternativaCloseUp(Sender: TObject);
begin
  inherited;
  lblAlternativaMotivoTerzoGrado.Enabled:=cmbAlternativa.ItemIndex = 4;
  cmbAlternativaMotivoTerzoGrado.Enabled:=cmbAlternativa.ItemIndex = 4;
  if not cmbAlternativaMotivoTerzoGrado.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=-1;
  lblAlternativaNomePA.Enabled:=(cmbAlternativa.ItemIndex <> -1) and (cmbAlternativa.ItemIndex <> 5);
  cmbAlternativaNomePA.Enabled:=(cmbAlternativa.ItemIndex <> -1) and (cmbAlternativa.ItemIndex <> 5);
  if not cmbAlternativaNomePA.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbAlternativaNomePA.ItemIndex:=-1;
end;

procedure TS031FFamiliari.cmbAlternativaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbAlternativaCloseUp(nil);
end;

procedure TS031FFamiliari.cmbNomePAChange(Sender: TObject);
begin
  inherited;
  lblDurataContratto.Enabled:=Trim(cmbNomePA.Text) <> '';
  cmbDurataContratto.Enabled:=Trim(cmbNomePA.Text) <> '';
  if not cmbDurataContratto.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    cmbDurataContratto.ItemIndex:=-1;
end;

procedure TS031FFamiliari.cmbParentelaCloseUp(Sender: TObject);
begin
  inherited;
  if DButton.State in [dsEdit,dsInsert] then
  begin
    DButton.Dataset.FieldByName('NUMGRADO').AsString:='';
    cmbTipoPar.ItemIndex:=-1;
    if cmbParentela.ItemIndex in [GP_FIGLIO,GP_GENITORE] then //Figlio,Genitore
    begin
      DButton.Dataset.FieldByName('NUMGRADO').AsString:='1';
      cmbTipoPar.ItemIndex:=0;
    end
    else if cmbParentela.ItemIndex in [GP_FRATELLO] then //Fratello-Sorella
    begin
      DButton.Dataset.FieldByName('NUMGRADO').AsString:='2';
      cmbTipoPar.ItemIndex:=0;
    end
    else if cmbParentela.ItemIndex in [GP_NIPOTE,GP_NIPOTE_FIGLIO] then //Nipote
    begin
      DButton.Dataset.FieldByName('NUMGRADO').AsString:='2';
      cmbTipoPar.ItemIndex:=0;
    end;
    if (gpbCausali.Enabled) and (DButton.State = dsInsert) then
      if cmbParentela.ItemIndex = GP_FIGLIO then  //Figlio
        DButton.Dataset.FieldByName('CAUSALI_ABILITATE').AsString:=S031FFamiliariDtM.S031FFamiliariMW.GetCausaliFG
      else
        DButton.Dataset.FieldByName('CAUSALI_ABILITATE').Clear;
  end;
  AbilitaComponenti;
end;

procedure TS031FFamiliari.cmbParentelaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbParentelaCloseUp(nil);
end;

procedure TS031FFamiliari.cmbTipoDisabilitaCloseUp(Sender: TObject);
begin
  inherited;
  lblAnnoRevisione.Enabled:=cmbTipoDisabilita.ItemIndex = 0;
  dedtAnnoRevisione.Enabled:=cmbTipoDisabilita.ItemIndex = 0;
  btnAnnoRevisione.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (cmbTipoDisabilita.ItemIndex = 0);
  if not dedtAnnoRevisione.Enabled and (DButton.State in [dsEdit,dsInsert]) then
    DButton.Dataset.FieldByName('ANNO_REVISIONE').Clear;
  if (cmbTipoDisabilita.ItemIndex = -1) and (DButton.State in [dsEdit,dsInsert]) then
  begin
    DButton.Dataset.FieldByName('ANNO_AVV').Clear;
    DButton.Dataset.FieldByName('ANNO_AVV_FAM').Clear;
    DButton.Dataset.FieldByName('ALTERNATIVA').Clear;
    cmbAlternativa.ItemIndex:=-1;
    cmbAlternativaCloseUp(nil);
  end;
end;

procedure TS031FFamiliari.cmbTipoDisabilitaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  cmbTipoDisabilitaCloseUp(nil);
end;

procedure TS031FFamiliari.cmbTipoParKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
    (Sender as TComboBox).ItemIndex:=-1;
end;

procedure TS031FFamiliari.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dgrdDatiBase,Sender = CopiaInExcel);
end;

procedure TS031FFamiliari.dedtREDDITOANFExit(Sender: TObject);
begin
  inherited;
  edtTotaleANF.Text:=FloatToStr(DButton.Dataset.FieldByName('REDDITO_ANF').AsFloat + DButton.Dataset.FieldByName('REDDITO_ALTRO_ANF').AsFloat);
end;

procedure TS031FFamiliari.dgrdDATIBASEDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:Integer;
begin
  inherited;
  if actVisioneCorrente.Checked then
    Exit;
  if gdFixed in State then exit;
  //Ciclo su tabella
  for i:=0 to High(ElencoNumOrd) do
    if (ElencoNumOrd[i].Colorata) and
       (ElencoNumOrd[i].NumOrd = DButton.Dataset.FieldByName('NUMORD').AsInteger) then
    begin
      if gdSelected in State then
      begin
        dgrdDATIBASE.Canvas.Brush.Color:=clHighLight;
        dgrdDATIBASE.Canvas.Font.Color:=clWhite;
      end
      else
      begin
        dgrdDATIBASE.Canvas.Brush.Color:=$00FFFF80;
        dgrdDATIBASE.Canvas.Font.Color:=clWindowText;
      end;
      dgrdDATIBASE.DefaultDrawColumnCell(Rect,DataCol,Column,State);
      Break;
    end;
end;

procedure TS031FFamiliari.CaricaElencoNumOrd;
var i:integer;
    Puntatore:TBookmark;
begin
  SetLength(ElencoNumOrd,0);
  with DButton.DataSet do
  begin
    DisableControls;
    Puntatore:=GetBookmark;
    First;
    i:=-1;
    while not Eof do
    begin
      if Length(ElencoNumOrd) = 0 then
      begin
        inc(i);
        SetLength(ElencoNumOrd,i + 1);
        ElencoNumOrd[i].NumOrd:=FieldByName('NUMORD').AsInteger;
        ElencoNumOrd[i].Colorata:=False;
      end
      else if (ElencoNumOrd[i].NumOrd <> FieldByName('NUMORD').AsInteger) then
      begin
        inc(i);
        SetLength(ElencoNumOrd,i + 1);
        ElencoNumOrd[i].NumOrd:=FieldByName('NUMORD').AsInteger;
        ElencoNumOrd[i].Colorata:=not ElencoNumOrd[i - 1].Colorata;
      end;
      Next;
    end;
    GotoBookmark(Puntatore);
    FreeBookmark(Puntatore);
    EnableControls;
  end;
end;

procedure TS031FFamiliari.drgpTIPO_DETRAZIONEClick(Sender: TObject);
begin
  inherited;
  dchkDetr100Affid.Visible:=(drgpTIPO_DETRAZIONE.ItemIndex = 2) and (DButton.DataSet.FieldByName('PERC_CARICO').AsFloat = 100);
  if not dchkDetr100Affid.Visible then
    dchkDetr100Affid.Checked:=False;
end;

procedure TS031FFamiliari.TAnnullaClick(Sender: TObject);
var tabCorrente:TTabSheet;
begin
  tabCorrente:=PageControl1.ActivePage;
  inherited;
  PageControl1.ActivePage:=tabCorrente;
  actRefresh.Execute;
end;

procedure TS031FFamiliari.TInserClick(Sender: TObject);
begin
  inherited;
  cmbParentela.SetFocus;
  cmbParentela.ItemIndex:=GP_FIGLIO;
  cmbParentelaCloseUp(nil);
end;

procedure TS031FFamiliari.TModifClick(Sender: TObject);
begin
  if Dbutton.DataSet.RecordCount <= 0 then
    TInserClick(nil)
  else
    inherited;
end;

procedure TS031FFamiliari.TRegisClick(Sender: TObject);
var tabCorrente:TTabSheet;
begin
  tabCorrente:=PageControl1.ActivePage;
  inherited;
  PageControl1.ActivePage:=tabCorrente;
  actRefresh.Execute;
end;

procedure TS031FFamiliari.Visionecorrente1Click(Sender: TObject);
begin
  inherited;
  CaricaElencoNumOrd;
end;

procedure TS031FFamiliari.Annullatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdDatiBase,'N');
end;

procedure TS031FFamiliari.Apri1Click(Sender: TObject);
// apre il documento allegato utilizzando la shellexecute
var
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta dal tag del componente
  LId:=S031FFamiliariDtM.S031FFamiliariMW.selT960.FieldByName('ID').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae info documento da db
  Screen.Cursor:=crHourGlass;
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=FC021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // apre il documento con il visualizzatore associato
      ShellExecute(0,'open',PChar(LDoc.FilePath),nil,nil,SW_SHOWNORMAL);

      // aggiorna i dati di accesso al documento
      AggiornaAccesso;
    except
      on E: Exception do
      begin
        R180MessageBox(Format(A000MSG_A155_ERR_FMT_DOC_APRI,[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TS031FFamiliari.Accedi1Click(Sender: TObject);
// accesso alla gestione del documento A154
// pre: la funzione A154 è accessibile
var
  LOldIdDoc: Integer;
begin
  // salva id documento per successivo riposizionamento
  LOldIdDoc:=S031FFamiliariDtM.S031FFamiliariMW.selT960.FieldByName('ID').AsInteger;

  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA154GestioneDocumentale(S031FFamiliariDtM.S031FFamiliariMW.selT960.FieldByName('PROGRESSIVO').AsInteger,S031FFamiliariDtM.S031FFamiliariMW.selT960.FieldByName('ID').AsInteger);
  C700DatiSelezionati:=C700CampiBase;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;

  // refresh dataset e riposizionamento
  S031FFamiliariDtM.S031FFamiliariMW.selT960.Refresh;
  TOracleDataSet(S031FFamiliariDtM.S031FFamiliariMW.selT960).SearchRecord('ID',LOldIdDoc,[srFromBeginning]);
end;

procedure TS031FFamiliari.AggiornaAccesso;
// aggiorna i dati di accesso per la tabella indicata
begin
  FC021DM.AggiornaDatiAccesso(S031FFamiliariDtM.S031FFamiliariMW.selT960.FieldByName('ID').AsInteger,Parametri.Operatore);
  S031FFamiliariDtM.S031FFamiliariMW.selT960.Refresh;
end;

procedure TS031FFamiliari.Salva1Click(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LDoc: TDocumento;
  LFileName: String;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta dal tag del componente
  LId:=DButton.DataSet.FieldByName('ID').AsInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  // estrae info documento da db
  Screen.Cursor:=crHourGlass;
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=FC021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        R180MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // dialog per richiesta destinazione file
      {$WARN SYMBOL_PLATFORM OFF}
      dlgFileSave.Title:='Selezionare destinazione';
      dlgFileSave.FileName:=LDoc.GetNomeFileCompleto;
      if dlgFileSave.Execute then
      begin
        // il file è stato selezionato
        LFileName:=dlgFileSave.FileName;
        // cancella eventuale file già esistente
        if TFile.Exists(LFileName) then
          TFile.Delete(LFileName);
        // salvataggio del file
        TFile.Move(LDoc.FilePath,LFileName);
        // aggiorna i dati di accesso al documento
        AggiornaAccesso;
      end;
      {$WARN SYMBOL_PLATFORM ON}
    except
      on E: Exception do
      begin
        R180MessageBox(Format(A000MSG_A155_ERR_FMT_DOC_SALVA,[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    Screen.Cursor:=crDefault;
  end;
end;

procedure TS031FFamiliari.AllineaComponenti;
begin
  with S031FFamiliariDtM do
  begin
    cmbParentela.ItemIndex:=S031FFamiliariMW.cmbParentelaItemIndex;
    cmbTipoPar.ItemIndex:=S031FFamiliariMW.cmbTipoParentelaItemIndex;
    cmbMotivoTerzoGrado.ItemIndex:=S031FFamiliariMW.cmbMotivoTerzoGradoItemIndex;
    cmbTipoAdoz.ItemIndex:=S031FFamiliariMW.cmbTipoAdozItemIndex;
    cmbTipoDisabilita.ItemIndex:=S031FFamiliariMW.cmbTipoDisabilitaItemIndex;
    cmbNomePA.ItemIndex:=S031FFamiliariMW.cmbNomePAItemIndex;
    cmbNomePA.Text:=QSG101.FieldByName('NOME_PA').AsString;
    cmbDurataContratto.ItemIndex:=S031FFamiliariMW.cmbDurataContrattoItemIndex;
    cmbAlternativa.ItemIndex:=S031FFamiliariMW.cmbAlternativaItemIndex;
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=S031FFamiliariMW.cmbAlternativaMotivoTerzoGradoItemIndex;
    cmbAlternativaNomePA.ItemIndex:=S031FFamiliariMW.cmbAlternativaNomePAItemIndex;
    cmbAlternativaNomePA.Text:=QSG101.FieldByName('NOME_PA_ALT').AsString;
    cmbMotivoEsclusione.ItemIndex:=S031FFamiliariMW.cmbMotivoEsclusioneItemIndex;
    TabNote.Highlighted:=QSG101.FieldByName('NOTE').AsString <> '';
    TabDocumenti.Highlighted:=S031FFamiliariMW.selT960.Active and (S031FFamiliariMW.selT960.RecordCount > 0);
  end;
end;

procedure TS031FFamiliari.AbilitaComponenti;
begin
(*
0 Nessuno/Sè stesso
1 Coniuge
2 Figlio/Figlia
3 Genitore
4 Fratello/Sorella
5 Nipote
6 Nipote equiparato Figlio
7 Altro
8 Affidato
9 Unito civilmente
*)
  //--- Dati anagrafici
  cmbParentela.Enabled:=(DButton.State in [dsEdit,dsInsert]);
  lblTipoPar.Enabled:=(cmbParentela.ItemIndex in [GP_ALTRO]);
  cmbTipoPar.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (cmbParentela.ItemIndex in [GP_ALTRO]);
  lblNumGrado.Enabled:=(cmbParentela.ItemIndex in [GP_NIPOTE,GP_NIPOTE_FIGLIO,GP_ALTRO]);
  dedtNumGrado.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (cmbParentela.ItemIndex in [GP_NIPOTE,GP_NIPOTE_FIGLIO,GP_ALTRO]);
  dedtNumGradoChange(nil);
  dedtCognome.Enabled:=(Trim(dcmbMatricola.Text) = '');
  dedtNome.Enabled:=(Trim(dcmbMatricola.Text) = '');
  drgpSesso.Enabled:=(Trim(dcmbMatricola.Text) = '');
  dedtDataNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
  lblDataNasPresunta.Enabled:=(Parametri.Applicazione <> 'PAGHE');
  dedtDataNasPresunta.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '');
  lblDataAdoz.Enabled:=(Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  dedtDataAdoz.Enabled:=(Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  lblDataPreAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  dedtDataPreAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  btnDataPreAdoz.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  lblTipoAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  cmbTipoAdoz.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (Trim(dcmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  if (DButton.State in [dsEdit,dsInsert]) and (not dedtDataAdoz.Enabled) then
  begin
    dedtDataAdoz.Field.Clear;
    dedtDataPreAdoz.Field.Clear;
    cmbTipoAdoz.ItemIndex:=-1;
  end;
  S031FFamiliariDtM.QSG101DATAADOZChange(nil);
  dedtComNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
  dcmbComNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
  dedtCapNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
  dedtProvNas.Enabled:=(Trim(dcmbMatricola.Text) = '');
  dedtCodFiscale.Enabled:=(Trim(dcmbMatricola.Text) = '');
  dedtDataSep.Enabled:=(Trim(dcmbMatricola.Text) = '') or (cmbParentela.ItemIndex <> GP_NESSUNO); //Diverso da sè stesso
  btnDataSep.Enabled:=(DButton.State in [dsEdit,dsInsert]) and ((Trim(dcmbMatricola.Text) = '') or (cmbParentela.ItemIndex <> GP_NESSUNO));
  cmbMotivoEsclusione.Enabled:=(DButton.State in [dsEdit,dsInsert]) and ((Trim(dcmbMatricola.Text) = '') or (cmbParentela.ItemIndex <> GP_NESSUNO));
  lblDataMat.Enabled:=cmbParentela.ItemIndex in [GP_CONIUGE,GP_UNITO_CIVILE];
  dedtDataMat.Enabled:=cmbParentela.ItemIndex in [GP_CONIUGE,GP_UNITO_CIVILE];
  btnDataMat.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (cmbParentela.ItemIndex in [GP_CONIUGE,GP_UNITO_CIVILE]) and not InterfacciaR004.StoricizzazioneInCorso;
  btnDataRilascioCartaId.Enabled:=(DButton.State in [dsEdit,dsInsert]);
  btnDataScadenzaCartaID.Enabled:=(DButton.State in [dsEdit,dsInsert]);
  gpbCausali.Enabled:=Parametri.Applicazione <> 'PAGHE';
  if cmbParentela.ItemIndex = GP_NESSUNO then
    gpbCausali.Caption:='Causali fruibili per sè stesso'
  else
    gpbCausali.Caption:='Causali fruibili per questo familiare';

  //--- Legge 104
  tabLegge104.Enabled:=Parametri.Applicazione <> 'PAGHE';
  lblAnnoAvv.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = GP_NESSUNO);   //Sè stesso
  dedtAnnoAvv.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = GP_NESSUNO);   //Sè stesso
  lblAnnoAvvFam.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex <> GP_NESSUNO);   //Diverso da sè stesso
  dedtAnnoAvvFam.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex <> GP_NESSUNO);  //Diverso da sè stesso
  lblAnnoRevisione.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
  dedtAnnoRevisione.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
  btnAnnoRevisione.Enabled:=(DButton.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
  lblTipoDisabilita.Enabled:=Parametri.Applicazione <> 'PAGHE';
  cmbTipoDisabilita.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
  if cmbTipoDisabilita.Enabled then
    cmbTipoDisabilitaCloseUp(nil);
  gpbResidenza.Visible:=(Trim(dcmbMatricola.Text) = '');  //Diverso da Sè stesso e coniuge interno
  if gpbResidenza.Visible then
  begin
    lblIndirizzo.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtIndirizzo.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dcmbComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblCAP.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtCAP.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblProvincia.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtProvincia.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblTelefono.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtTelefono.Enabled:=Parametri.Applicazione <> 'PAGHE';
  end;
  gpbFamiliare.Visible:=(Trim(dcmbMatricola.Text) = '');  //Diverso da Sè stesso e coniuge interno
  if gpbFamiliare.Visible then
  begin
    lblDurataContratto.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbDurataContratto.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
    lblNomePA.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbNomePA.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
    if cmbNomePA.Enabled then
    begin
      CaricaNomePA(cmbNomePA);
      cmbNomePAChange(nil);
    end;
  end
  else if (DButton.State in [dsEdit,dsInsert]) then
  begin
    cmbNomePA.ItemIndex:=-1;
    cmbNomePA.Text:='';
    cmbDurataContratto.ItemIndex:=-1;
  end;
  gpbAlternativa.Visible:=(cmbParentela.ItemIndex = GP_FIGLIO); //Figlio
  if gpbAlternativa.Visible then
  begin
    lblAlternativaMotivoTerzoGrado.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbAlternativaMotivoTerzoGrado.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
    lblAlternativaNomePA.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbAlternativaNomePA.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
    lblAlternativa.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbAlternativa.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (DButton.State in [dsEdit,dsInsert]);
    if cmbAlternativa.Enabled then
    begin
      CaricaNomePA(cmbAlternativaNomePA);
      cmbAlternativaCloseUp(nil);
    end;
  end
  else if (DButton.State in [dsEdit,dsInsert]) then
  begin
    cmbAlternativa.ItemIndex:=-1;
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=-1;
    cmbAlternativaNomePA.ItemIndex:=-1;
    cmbAlternativaNomePA.Text:='';
  end;

  //--- Dati stipendiali - Abilitati per chi ha le paghe solo dall'applicativo paghe, altrimenti sempre
  //Fa eccezione l'ONU dove è abilitata anche dal Giuridico
  tabDatiStipendiali.Enabled:=((Parametri.V430 = 'P430') and (Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S') and (Parametri.Applicazione = 'PAGHE')) or
                              ((Parametri.V430 = 'P430') and (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S') and ((Parametri.Applicazione = 'PAGHE') or (Parametri.Applicazione = 'STAGIU'))) or
                              (Parametri.V430 <> 'P430');
  lblDATA_ULT_FAM_CAR.Enabled:=tabDatiStipendiali.Enabled;
  dedtDATA_ULT_FAM_CAR.Enabled:=tabDatiStipendiali.Enabled;
  btnDATA_ULT_FAM_CAR.Enabled:=(DButton.State in [dsEdit,dsInsert]) and tabDatiStipendiali.Enabled;
  drgpTipo_Detrazione.Enabled:=tabDatiStipendiali.Enabled;
  lblPerc_Carico.Enabled:=tabDatiStipendiali.Enabled;
  dedtPerc_Carico.Enabled:=tabDatiStipendiali.Enabled;
  dchkDetrFiglioHandicap.Enabled:=tabDatiStipendiali.Enabled;
  dchkDetr100Affid.Enabled:=tabDatiStipendiali.Enabled;
  dchkANF.Enabled:=tabDatiStipendiali.Enabled;
  dchkANFSpeciale.Visible:=cmbParentela.ItemIndex = GP_FIGLIO;  //Studente/apprendista
  dchkANFSpeciale.Enabled:=tabDatiStipendiali.Enabled;
  dchkANFInabile.Enabled:=tabDatiStipendiali.Enabled;
  lblRedditoANF.Enabled:=tabDatiStipendiali.Enabled;
  dedtRedditoANF.Enabled:=tabDatiStipendiali.Enabled;
  lblRedditoAltroANF.Enabled:=tabDatiStipendiali.Enabled;
  dedtRedditoAltroANF.Enabled:=tabDatiStipendiali.Enabled;
  lblTotaleANF.Enabled:=tabDatiStipendiali.Enabled;
  edtTotaleANF.Enabled:=tabDatiStipendiali.Enabled;
  dchkInserimentoCU.Visible:=cmbParentela.ItemIndex in [GP_CONIUGE,GP_UNITO_CIVILE];
  dchkInserimentoCU.Enabled:=tabDatiStipendiali.Enabled;
  drgpTIPO_DETRAZIONEClick(nil);
  dedtREDDITOANFExit(nil);

  //--- BtnCarica
  with S031FFamiliariDtM.S031FFamiliariMW.selGradoPar do
  begin
    SetVariable('PROGRESSIVO',C700Progressivo);
    SetVariable('NUM',-1);
    Execute;
    btnCarica.Visible:=(StrToIntDef(VarToStr(Field(0)),0) <= 0) and (not SolaLettura);
  end;
end;

procedure TS031FFamiliari.CaricaNomePA(Combo:TComboBox);
begin
  Combo.Items.Clear;
  with S031FFamiliariDtM.S031FFamiliariMW.selNomePA do
  begin
    Close;
    SetVariable('DATO','NOME_PA');
    Open;
    First;
    while not Eof do
    begin
      Combo.Items.Add(FieldByName('NOME_PA').AsString);
      Next;
    end;
    Close;
    SetVariable('DATO','NOME_PA_ALT');
    Open;
    First;
    while not Eof do
    begin
      if R180IndexOf(Combo.Items,FieldByName('NOME_PA_ALT').AsString,100) < 0 then
        Combo.Items.Add(FieldByName('NOME_PA_ALT').AsString);
      Next;
    end;
  end;
end;

end.
