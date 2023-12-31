unit A006UModelliOrario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGestStorico, ActnList, ImgList, DB, Menus, ComCtrls,OracleData,
  ToolWin, StdCtrls, Mask, DBCtrls, Buttons, Grids, DBGrids, R500Lin,
  ExtCtrls, dbcgrids, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  C008UCercaDuplicati, C009UCopiaSu, C013UCheckList, C180FunzioniGenerali,
  A020UCausPresenze, System.Actions, System.ImageList;

type
  TA006FModelliOrario = class(TR004FGestStorico)
    PageControl: TPageControl;
    tabTimbrature: TTabSheet;
    dgrdTimbrature: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    dedtCodice: TDBEdit;
    dedtDescrizione: TDBEdit;
    tabOpzioni: TTabSheet;
    grdIndennitaPres: TGroupBox;
    Label47: TLabel;
    P2E05: TDBEdit;
    drgpCompNot: TDBRadioGroup;
    GroupBox6: TGroupBox;
    Label48: TLabel;
    dedtMMIndPres: TDBEdit;
    drgpFlagPres: TDBRadioGroup;
    GroupBox7: TGroupBox;
    dchkFlagMPres: TDBCheckBox;
    dedtMMIndMPres: TDBEdit;
    grpAltreIndennita: TGroupBox;
    lblOreIndFest: TLabel;
    dedtOreIndFest: TDBEdit;
    tabPausaMensa: TTabSheet;
    tabStraordinario: TTabSheet;
    dgrdPausaMensa: TDBGrid;
    Panel1: TPanel;
    Label6: TLabel;
    dcmbTipoOra: TDBComboBox;
    Label7: TLabel;
    dcmbPerLav: TDBComboBox;
    Panel3: TPanel;
    lblTipoMensa: TLabel;
    lblMMMinimi: TLabel;
    lblMinPercorr: TLabel;
    dedtMMMinimi: TDBEdit;
    dedtMinPercorr: TDBEdit;
    dcmbTipoMensa: TDBComboBox;
    grpPausaMensaTimbrata: TGroupBox;
    DBCheckBox3: TDBCheckBox;
    actCercaDuplicati: TAction;
    Ricercaduplicati1: TMenuItem;
    N5: TMenuItem;
    grpMensaAutomatica: TGroupBox;
    lblRientroMinimo: TLabel;
    lblPausaMensaAutomatica: TLabel;
    dchkDetrAutCont: TDBCheckBox;
    dedtRientroMinimo: TDBEdit;
    dedetPausaMensaAutomatica: TDBEdit;
    dchkPMAutoURit: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    grpArrotFuoriOrario: TGroupBox;
    Label64: TLabel;
    Label65: TLabel;
    P2E01: TDBEdit;
    P2E02: TDBEdit;
    grpArrotGiornaliero: TGroupBox;
    Label41: TLabel;
    Label42: TLabel;
    P2E03: TDBEdit;
    P2E04: TDBEdit;
    GParametri: TGroupBox;
    lblOreTeor: TLabel;
    lblOreMin: TLabel;
    lblOreMax: TLabel;
    lblTipoFle: TLabel;
    pnlTurni: TPanel;
    lblMinUscitaNotte: TLabel;
    dchkFrazDeb: TDBCheckBox;
    dchkNotteEntrata: TDBCheckBox;
    dedtMinUscitaNotte: TDBEdit;
    dchkCompDetr: TDBCheckBox;
    dcmbTipoFle: TDBComboBox;
    dedtOreMin: TDBEdit;
    dedtOreTeor: TDBEdit;
    dedtOreMax: TDBEdit;
    drgpObblFac: TDBRadioGroup;
    drgpIndPresStr: TDBRadioGroup;
    drgpIndFestStr: TDBRadioGroup;
    drgpIndNotStr: TDBRadioGroup;
    Panel6: TPanel;
    dgrdStraordinario: TDBGrid;
    GroupBox10: TGroupBox;
    Label58: TLabel;
    P4E07: TDBEdit;
    chkDopoOreMax: TDBCheckBox;
    Panel5: TPanel;
    Label20: TLabel;
    GroupBox11: TGroupBox;
    Label5: TLabel;
    Label13: TLabel;
    Label21: TLabel;
    EComp1: TDBRadioGroup;
    P4E13: TDBEdit;
    P4E14: TDBEdit;
    dchkSoloComp: TDBCheckBox;
    EComp2: TDBRadioGroup;
    dchkArrotComp: TDBCheckBox;
    dedtOraMaxComp: TDBEdit;
    dcmbTipoStraordinario: TDBComboBox;
    GroupBox9: TGroupBox;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    P4E04: TDBEdit;
    P4E05: TDBEdit;
    P4E06: TDBEdit;
    P4E01: TDBEdit;
    P4E03: TDBEdit;
    grpCarenzaObbNoLiq: TGroupBox;
    dchkCarenzaObbNoLiq: TDBCheckBox;
    Label2: TLabel;
    dedtArrEccedLiq: TDBEdit;
    Label4: TLabel;
    DBEdit1: TDBEdit;
    dchkRegoleProfilo: TDBCheckBox;
    dcmbEccCompCausalizzata: TDBComboBox;
    Label8: TLabel;
    dchkStrRipFasce: TDBCheckBox;
    Label9: TLabel;
    dedtArrEccedFasce: TDBEdit;
    dchkArrotComp2: TDBCheckBox;
    dchkArrTimbInterne: TDBCheckBox;
    lblPMRecupUscita: TLabel;
    dedtPMRecupUscita: TDBEdit;
    dchkArrEccFasceComp: TDBCheckBox;
    dchkPMT_TIMB_AUTORIZZATE: TDBCheckBox;
    dchkPMAPreservaTimbInFascia: TDBCheckBox;
    Label10: TLabel;
    dedtScostGGMinSoglia: TDBEdit;
    lblPMTTolleranza: TLabel;
    dedtPMTTolleranza: TDBEdit;
    dchkPMTTimbMaturaMensa: TDBCheckBox;
    grpTimbraturaMensa: TGroupBox;
    lblTimbraturaMensaDetrazione: TLabel;
    dedtTimbraturaMensaDetrazione: TDBEdit;
    dchkTimbraturaMensaDetrTot: TDBCheckBox;
    drgpTimbraturaMensaInterna: TDBRadioGroup;
    dchkPmtSoloTimbMensa: TDBCheckBox;
    dchkTimbraturaMensa: TDBCheckBox;
    grpPMIntermedia: TGroupBox;
    Label11: TLabel;
    Label14: TLabel;
    dedtPMStaccoInf: TDBEdit;
    dedtPMOreMinimeInf: TDBEdit;
    dChkCompseInf: TDBCheckBox;
    dchkCoperturaCarenza: TDBCheckBox;
    dchkPMTLimiteFlex: TDBCheckBox;
    drgpIndFestiva: TDBRadioGroup;
    dchkTimbraturaMensaFlex: TDBCheckBox;
    dchkSpezzNonCaus_ScartoEcc: TDBCheckBox;
    dchkFlexDopoMezanotte: TDBCheckBox;
    GroupBox1: TGroupBox;
    drgpRiposoCompensativo: TDBRadioGroup;
    lblDebitoRipCom: TLabel;
    dedtDebitoRipCom: TDBEdit;
    P2E12: TDBCheckBox;
    dchkRipcomGGNonLav: TDBCheckBox;
    dchkIntersezAutoGiust: TDBCheckBox;
    dchkPMTUscitaRit: TDBCheckBox;
    lblArrotondamentoSottoSoglia: TLabel;
    dedtArrotondamentoSottoSoglia: TDBEdit;
    dchkRientroPomeridiano: TDBCheckBox;
    tabCausAuto: TTabSheet;
    grpFestLav: TGroupBox;
    lblFestLavLiq: TLabel;
    lblFestLavCmpLiqTurn: TLabel;
    btnCausaliEccedenza: TButton;
    dedtCausaliEccedenza: TDBEdit;
    lblCausaliEccedenza: TLabel;
    lblDistrOreOrdFasce: TLabel;
    dcmbDistrOreOrdFasce: TDBLookupComboBox;
    dcmbFestLavLiq: TDBLookupComboBox;
    dcmbFestLavCmpLiq: TDBLookupComboBox;
    dcmbFestLavCmpLiqTurn: TDBLookupComboBox;
    lblFestLavCmpLiq: TLabel;
    pmnCausali: TPopupMenu;
    mnuAccedi: TMenuItem;
    dchkCausaleDisabilBloccante: TDBCheckBox;
    Label12: TLabel;
    dcmbCausaleInizioOrario: TDBLookupComboBox;
    Label15: TLabel;
    dedtMinutiCausInizioOrario: TDBEdit;
    Label16: TLabel;
    dcmbCausaleFineOrario: TDBLookupComboBox;
    Label17: TLabel;
    dedtMinutiCausFineOrario: TDBEdit;
    Label18: TLabel;
    dedtPMTStaccoMin: TDBEdit;
    dchkRipcomDebitoGG: TDBCheckBox;
    GroupBox2: TGroupBox;
    dedtMMIndPresMag: TDBEdit;
    Label19: TLabel;
    dedtCoeffIndPresMag: TDBEdit;
    Label22: TLabel;
    dedtOreTeorGGAss: TDBEdit;
    Label23: TLabel;
    GroupBox4: TGroupBox;
    lblRicalcoloMin: TLabel;
    lblRicalcoloMax: TLabel;
    lblRicalcoloDebMin: TLabel;
    lblRicalcoloDebMax: TLabel;
    lblRicalcoloCausNeg: TLabel;
    lblRicalcoloCausPos: TLabel;
    dchkRicalcoloDebitoGG: TDBCheckBox;
    dedtRicalcoloMin: TDBEdit;
    dedtRicalcoloMax: TDBEdit;
    dchkRicalcoloSpostaPN: TDBCheckBox;
    dchkRicalcoloOffNoTimb: TDBCheckBox;
    dedtRicalcoloDebMin: TDBEdit;
    dedtRicalcoloDebMax: TDBEdit;
    dlckRicalcoloCausNeg: TDBLookupComboBox;
    dlckRicalcoloCausPos: TDBLookupComboBox;
    dchkFrazDebNoTurnista: TDBCheckBox;
    dchkForzaTurnoPianificato: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    dchkPMTNoOreMinTimbMensa: TDBCheckBox;
    dchkPMTTimbraturaMensa: TDBCheckBox;
    dchkFasciaNotteFestCompleta: TDBCheckBox;
    dchkIndFestivaUsaNotteCompleta: TDBCheckBox;
    Label24: TLabel;
    dcmbDETRAZ_RIEPPR_NORM: TDBComboBox;
    pnlXParam: TPanel;
    lblXParam: TLabel;
    DBEdit2: TDBEdit;
    Label25: TLabel;
    DBEdit3: TDBEdit;
    lblOrariScambio: TLabel;
    dedtOrariScambio: TDBEdit;
    btnOrariScambio: TButton;
    dchkStrNotteSpezzato: TDBCheckBox;
    grpCausRiduzPN: TGroupBox;
    lblCausRiduzPN: TLabel;
    btnCausRiduzPN: TButton;
    dedtCausRiduzPN: TDBEdit;
    lblCausRiduzPNCheckPMT: TLabel;
    dedtCausRiduzPNCheckPMT: TDBEdit;
    btnCausRiduzPNCheckPMT: TButton;
    dchkDetrazParzStaccoInf: TDBCheckBox;
    lblTurniInizioOrario: TLabel;
    dedtTurniInizioOrario: TDBEdit;
    lblTurniFineOrario: TLabel;
    dedtTurniFineOrario: TDBEdit;
    btnAnomalieBloccanti: TButton;
    dedtAnomalieBloccanti: TDBEdit;
    lblAnomalieBloccanti: TLabel;
    dchkMinutiCausPrioritari: TDBCheckBox;
    tabXParam: TTabSheet;
    dgrdXParamComp: TDBGrid;
    dgrdXParam: TDBGrid;
    grpXParam: TGroupBox;
    grpXParamComp: TGroupBox;
    Splitter1: TSplitter;
    procedure dchkTimbraturaMensaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dcmbTipoOraDrawItem(Control: TWinControl; Index: Integer;Rect: TRect; State: TOwnerDrawState);
    procedure actCercaDuplicatiExecute(Sender: TObject);
    procedure dcmbTipoOraChange(Sender: TObject);
    procedure dcmbPerLavChange(Sender: TObject);
    procedure dcmbTipoMensaChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure PulisciValore(Sender: TObject);
    procedure dchkFlagMPresClick(Sender: TObject);
    procedure dchkSoloCompClick(Sender: TObject);
    procedure dchkFrazDebClick(Sender: TObject);
    procedure dchkNotteEntrataClick(Sender: TObject);
    procedure dchkPMAutoURitClick(Sender: TObject);
    procedure dgrdSelT021Exit(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure Copiada1Click(Sender: TObject);
    procedure btnStoricizzaClick(Sender: TObject);
    procedure dchkRicalcoloDebitoGGClick(Sender: TObject);
    procedure dcmbTipoStraordinarioChange(Sender: TObject);
    procedure drgpRiposoCompensativoChange(Sender: TObject);
    procedure drgpIndFestivaChange(Sender: TObject);
    procedure btnCausaliEccedenzaClick(Sender: TObject);
    procedure dgrdTimbratureDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure mnuAccediClick(Sender: TObject);
    procedure btnOrariScambioClick(Sender: TObject);
    procedure btnAnomalieBloccantiClick(Sender: TObject);
  private
    function SettaOrario:boolean;
    procedure ItemsPeriodoLav;
    procedure VisualizzaDatiSelT021;
    procedure VisualizzaPaginaOpzioni;
  public
    { Public declarations }
  end;

var
  A006FModelliOrario: TA006FModelliOrario;

procedure OpenA006ModelliOrario(Cod:String);

implementation

uses A006UModelliOrarioDtM1, A006UModelliOrarioMW;

{$R *.dfm}

procedure OpenA006ModelliOrario(Cod:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA006ModelliOrario') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A006FModelliOrario:=TA006FModelliOrario.Create(nil);
  with A006FModelliOrario do
  try
    A006FModelliOrarioDtM1:=TA006FModelliOrarioDtM1.Create(nil);
    A006FModelliOrarioDtM1.selT020.Locate('Codice',Cod,[]);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A006FModelliOrarioDtM1.Free;
    Release;
  end;
end;

procedure TA006FModelliOrario.FormCreate(Sender: TObject);
begin
  inherited;
  CopiaDa1.Visible:=True;
end;

procedure TA006FModelliOrario.FormShow(Sender: TObject);
  procedure PreparaColonnaTimbrature(pColName:string);
  var
    j:integer;
  begin
    for j:=0 to dgrdTimbrature.Columns.Count-1 do
      if UpperCase(dgrdTimbrature.Columns[j].FieldName) = UpperCase(pColName) then
      begin
        dgrdTimbrature.Columns[j].ButtonStyle:=cbsAuto;
        dgrdTimbrature.Columns[j].PickList.Add('O');
        dgrdTimbrature.Columns[j].PickList.Add('N');
        Break;
      end;
  end;
begin
  dlckRicalcoloCausNeg.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT265;
  dlckRicalcoloCausPos.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT265;
  dcmbDistrOreOrdFasce.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT276;
  dcmbFestLavLiq.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT275;
  dcmbFestLavCmpLiq.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT275;
  dcmbFestLavCmpLiqTurn.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT275;
  dcmbCausaleInizioOrario.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT275;
  dcmbCausaleFineOrario.ListSource:=A006FModelliOrarioDtM1.A006MW.dsrT275;
  A006FModelliOrarioDtM1.A006MW.PopolaD_PerLav;
  A006FModelliOrarioDtM1.A006MW.FTipoOrario:=toNull;
  A006FModelliOrarioDtM1.A006MW.FPeriodoLav:=plNull;
  PageControl.ActivePageIndex:=0;
  tabXParam.TabVisible:=R180In(Parametri.Operatore,['MONDOEDP','SYSMAN','TESTR']);
  DButton.DataSet:=A006FModelliOrarioDtM1.selT020;
  dgrdTimbrature.DataSource:=A006FModelliOrarioDtM1.A006MW.dsrT021PN;
  PreparaColonnaTimbrature('INDTURNO');
  PreparaColonnaTimbrature('INDFESTIVA');
  dgrdPausaMensa.DataSource:=A006FModelliOrarioDtM1.A006MW.dsrT021PM;
  dgrdStraordinario.DataSource:=A006FModelliOrarioDtM1.A006MW.dsrT021STR;
  dgrdXParam.DataSource:=A006FModelliOrarioDtM1.A006MW.dsrXParam;
  dgrdXParamComp.DataSource:=A006FModelliOrarioDtM1.A006MW.dsrXParamComp;
  R180SetComboItemsValues(dcmbTipoOra.Items,A006FModelliOrarioDtM1.A006MW.D_TipoOrario,'V');
  R180SetComboItemsValues(dcmbTipoFle.Items,A006FModelliOrarioDtM1.A006MW.D_Flessibilita,'V');
  R180SetComboItemsValues(dcmbTipoMensa.Items,A006FModelliOrarioDtM1.A006MW.D_PausaMensa,'V');
  R180SetComboItemsValues(dcmbTipoStraordinario.Items,A006FModelliOrarioDtM1.A006MW.D_TipoStraordinario,'V');
  R180SetComboItemsValues(dcmbEccCompCausalizzata.Items,A006FModelliOrarioDtM1.A006MW.D_EccCompCausalizzata,'V');
  inherited;
  SetTabelleRelazionate([A006FModelliOrarioDtM1.selT020,A006FModelliOrarioDtM1.A006MW.selT021PN]);
  (*
  Visionecorrente1Click(nil);  //x abilitare la Visione corrente: non si deve eseguire la Open prima!
  *)
  CercaStoricoCorrente;
  dchkRicalcoloDebitoGGClick(nil);
  dchkSpezzNonCaus_ScartoEcc.Visible:=(Pos('TORINO',UpperCase(Parametri.RagioneSociale)) > 0) and (Parametri.CodiceIntegrazione = 'TO');
end;

procedure TA006FModelliOrario.DButtonStateChange(Sender: TObject);
var
  IsAdmin: Boolean;
begin
  inherited;
  IsAdmin:=R180In(Parametri.Operatore,['MONDOEDP','SYSMAN','TESTR']);
  A006FModelliOrarioDtM1.A006MW.selT021PN.ReadOnly:=DButton.State = dsBrowse;
  A006FModelliOrarioDtM1.A006MW.selT021PM.ReadOnly:=DButton.State = dsBrowse;
  A006FModelliOrarioDtM1.A006MW.selT021STR.ReadOnly:=DButton.State = dsBrowse;
  actCercaDuplicati.Enabled:=DButton.State = dsBrowse;
  btnCausaliEccedenza.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnCausRiduzPN.Enabled:=(DButton.State in [dsInsert,dsEdit]) and IsAdmin;
  btnCausRiduzPNCheckPMT.Enabled:=(DButton.State in [dsInsert,dsEdit]) and IsAdmin;
  btnOrariScambio.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnAnomalieBloccanti.Enabled:=DButton.State in [dsInsert,dsEdit];
  if DButton.State in [dsInsert,dsEdit,dsBrowse] then
    ItemsPeriodoLav;
  if dgrdXParam.DataSource <> nil then
  begin
    TXParamClientDataSet(dgrdXParam.DataSource.DataSet).SolaLettura(not(IsAdmin and (DButton.State = dsEdit)));
  end;
  if dgrdXParamComp.DataSource <> nil then
  begin
    TXParamClientDataSet(dgrdXParamComp.DataSource.DataSet).SolaLettura(not(IsAdmin and (DButton.State = dsEdit)));
  end;
end;

procedure TA006FModelliOrario.dcmbTipoOraDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if Control =  dcmbTipoOra then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A006FModelliOrarioDtM1.A006MW.D_TipoOrario[Index].Item)
  else if Control = dcmbPerLav then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left,Rect.Top,A006FModelliOrarioDtM1.A006MW.D_PerLav[Index].Item)
  else if Control = dcmbTipoFle then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A006FModelliOrarioDtM1.A006MW.D_Flessibilita[Index].Item)
  else if Control = dcmbTipoMensa then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A006FModelliOrarioDtM1.A006MW.D_PausaMensa[Index].Item)
  else if Control = dcmbTipoStraordinario then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A006FModelliOrarioDtM1.A006MW.D_TipoStraordinario[Index].Item)
  else if Control = dcmbEccCompCausalizzata then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A006FModelliOrarioDtM1.A006MW.D_EccCompCausalizzata[Index].Item)
  else if Control = dcmbDETRAZ_RIEPPR_NORM then
    (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A006FModelliOrarioDtM1.A006MW.D_DetrazRiepPrNorm[Index].Item)
  ;
end;

procedure TA006FModelliOrario.actCercaDuplicatiExecute(Sender: TObject);
var i:Integer;
begin
  C008FCercaDuplicati:=TC008FCercaDuplicati.Create(nil);
  with C008FCercaDuplicati do
  try
    ODS:=A006FModelliOrarioDtM1.selT020;
    Row_ID:=A006FModelliOrarioDtM1.selT020.RowId;
    Codice:='CODICE,DESCRIZIONE';
    Standard:=False;
    //Query di confronto tra l'orario selezionato e gli altri con ROWID diverso
    //2 orari sono uguali se la query non restituisce nulla: 
    (*(SELECT ... FROM T020,T021 WHERE RIGA_CORRENTE
       MINUS
       SELECT ... FROM T020,T021 WHERE ALTRA_RIGA)
      UNION
      (SELECT ... FROM T020,T021 WHERE ALTRA_RIGA
       MINUS
       SELECT ... FROM T020,T021 WHERE RIGA_CORRENTE)
    *)
    selDuplicati.SQL.Add('select :codice,rowid from t020_orari t1 where');
    selDuplicati.SQL.Add('rowid <> :row_id and not exists (');
    selDuplicati.SQL.Add('(select :campi');
    selDuplicati.SQL.Add('from t020_orari t020,t021_fasceorari t021');
    selDuplicati.SQL.Add('where t020.codice = t021.codice(+) and t020.decorrenza = t021.decorrenza(+)');
    selDuplicati.SQL.Add('and t020.rowid = :row_id');
    selDuplicati.SQL.Add('minus');
    selDuplicati.SQL.Add('select :campi');
    selDuplicati.SQL.Add('from t020_orari t020,t021_fasceorari t021');
    selDuplicati.SQL.Add('where t020.codice = t021.codice(+) and t020.decorrenza = t021.decorrenza(+)');
    selDuplicati.SQL.Add('and t020.rowid = t1.rowid)');
    selDuplicati.SQL.Add('union');
    selDuplicati.SQL.Add('(select :campi');
    selDuplicati.SQL.Add('from t020_orari t020,t021_fasceorari t021');
    selDuplicati.SQL.Add('where t020.codice = t021.codice(+) and t020.decorrenza = t021.decorrenza(+)');
    selDuplicati.SQL.Add('and t020.rowid = t1.rowid');
    selDuplicati.SQL.Add('minus');
    selDuplicati.SQL.Add('select :campi');
    selDuplicati.SQL.Add('from t020_orari t020,t021_fasceorari t021');
    selDuplicati.SQL.Add('where t020.codice = t021.codice(+) and t020.decorrenza = t021.decorrenza(+)');
    selDuplicati.SQL.Add('and t020.rowid = :row_id))');
    //Definizione delle colonne che si possono confrontare
    lstColonne.Items.Clear;
    with A006FModelliOrarioDtM1 do
    begin
      for i:=0 to selT020.FieldDefs.Count - 1 do
        if (selT020.FieldDefs[i].Name <> 'CODICE') and
           (selT020.FieldDefs[i].Name <> 'DESCRIZIONE') then
          lstColonne.Items.Add('T020.' + selT020.FieldDefs[i].Name);
      for i:=0 to A006MW.selT021PN.FieldDefs.Count - 1 do
        if (A006MW.selT021PN.FieldDefs[i].Name <> 'CODICE') and
           (A006MW.selT021PN.FieldDefs[i].Name <> 'DESCRIZIONE') and
           (A006MW.selT021PN.FieldDefs[i].Name <> 'DECORRENZA') then
          lstColonne.Items.Add('T021.' + A006MW.selT021PN.FieldDefs[i].Name);
    end;
    ShowModal;
  finally
    Free;
  end;
end;

procedure TA006FModelliOrario.DButtonDataChange(Sender: TObject; Field: TField);
{Richiama le procedure di cambio videate allo scorrimento dei record}
var SO,SPL:Boolean;
begin
  inherited;
  if (Field = dedtPMOreMinimeInf.Field) or (Field = dedtPMStaccoInf.Field) then
    dcmbTipoMensaChange(Sender) {aggiorno pagina Pausa Mensa}
  else if Field <> nil then
    exit;
  {Se TipoOrario o PeriodoLav sono cambiati, allora cambio le pagine}
  SO:=SettaOrario;
  SPL:=A006FModelliOrarioDtM1.A006MW.SettaPeriodoLav(dcmbPerLav.Text);
  if (SO) or (SPL) then
    VisualizzaDatiSelT021;
  VisualizzaPaginaOpzioni;
  dcmbTipoMensaChange(Sender); {aggiorno pagina Pausa Mensa}
  //Disabilito il parametro "Ore continuative" se "Forzata se uscita dopo ore max"
  if dchkPMAutoURit.Checked then
  begin
    dchkDetrAutCont.Enabled:=False;
  end;
  dcmbTipoStraordinarioChange(Sender); {Visualizzo dati straordinario}
  dchkTimbraturaMensaClick(nil);
  PulisciValore(dedtMinPercorr);
  pnlXParam.Visible:=(not Dbutton.DataSet.FieldByName('XPARAM').IsNull) or (not Dbutton.DataSet.FieldByName('XPARAM_COMP_OLDVERS').IsNull);
  A006FModelliOrarioDtM1.A006MW.cdsXParam.ImpostaParametri(XParamList, A006FModelliOrarioDtM1.selT020.FieldByName('XPARAM').AsString);
  A006FModelliOrarioDtM1.A006MW.cdsXParamComp.ImpostaParametri(XParamCompList, A006FModelliOrarioDtM1.selT020.FieldByName('XPARAM_COMP_OLDVERS').AsString);
end;

function TA006FModelliOrario.SettaOrario:boolean;
{Setta FTipoOrario a seconda dell'input}
begin
  Result:=A006FModelliOrarioDtM1.A006MW.SettaTipoOrario(dcmbTipoOra.Text);
  if (DButton.State in [dsInsert,dsEdit]) and (Result) then
  begin
    ItemsPeriodoLav;
    dcmbPerLav.ItemIndex:=0;
    dcmbPerLav.Field.AsString:=dcmbPerLav.Items[0];
  end;
end;

procedure TA006FModelliOrario.ItemsPeriodoLav;
{Cambia gli items di PeriodoLav a seconda di TipoOrario}
var i: Integer;
begin
  i:=A006FModelliOrarioDtM1.A006MW.AggiornaItemsPerLav(dcmbPerLav.Items);
  if i>-2 then
    dcmbPerLav.ItemIndex:=i;
end;

procedure TA006FModelliOrario.mnuAccediClick(Sender: TObject);
var
  Accedi: Boolean;
  Codice: String;
  p: Integer;
  LComp: TComponent;
  LDBEditComp:TDBEdit;
begin
  Accedi:=False;
  Codice:='';
  LDBEditComp:=nil;

  if (Sender as TMenuItem).GetParentMenu = pmnCausali then
  begin
    LComp:=(pmnCausali.PopupComponent as TComponent);
    if LComp is TDBLookupComboBox then
    begin
      // dblookupcombobox
      if (LComp = dcmbFestLavLiq) or
         (LComp = dcmbFestLavCmpLiq) or
         (LComp = dcmbFestLavCmpLiqTurn) then
      begin
        // causali del festivo lavorato
        Codice:=VarToStr((LComp as TDBLookupComboBox).KeyValue);
        Accedi:=True;
      end;
    end
    else if LComp is TDBEdit then
    begin
      // edit
      if (LComp = dedtCausaliEccedenza) then
        LDBEditComp:=dedtCausaliEccedenza as TDBEdit
      else if (LComp = dedtCausRiduzPN) then
        LDBEditComp:=dedtCausRiduzPN as TDBEdit;
      if LDBEditComp <> nil then
      begin
        // accede selezionando la prima causale nella lista
        if LDBEditComp.Text = '' then
          Codice:=''
        else
        begin
          p:=Pos(',',LDBEditComp.Text);
          if p = 0 then
            Codice:=LDBEditComp.Text
          else
            Codice:=Copy(LDBEditComp.Text,1,p - 1);
        end;
        Accedi:=True;
      end;
    end;

    // accesso alla funzione "causali di presenza"
    if Accedi then
    begin
      OpenA020CausPresenze(Codice);
      A006FModelliOrarioDtM1.A006MW.selT275.Refresh;
    end;
  end;
end;

procedure TA006FModelliOrario.dcmbTipoOraChange(Sender: TObject);
{Cambio Tipo Orario con conseguente modifica delle videate}
var SO,SPL:Boolean;
begin
  {Se TipoOrario o PeriodoLav sono cambiati, allora cambio le pagine}
  SO:=SettaOrario;
  SPL:=A006FModelliOrarioDtM1.A006MW.SettaPeriodoLav(dcmbPerLav.Text);
  if (SO) or (SPL) then
  begin
    VisualizzaDatiSelT021;
    VisualizzaPaginaOpzioni;
  end;
end;

procedure TA006FModelliOrario.dcmbPerLavChange(Sender: TObject);
{Cambio di periodo lavorativo}
begin
  if A006FModelliOrarioDtM1.A006MW.SettaPeriodoLav(dcmbPerLav.Text) then
  begin
    VisualizzaDatiSelT021;
    VisualizzaPaginaOpzioni;
  end;
end;

procedure TA006FModelliOrario.dcmbTipoMensaChange(Sender: TObject);
{Visualizza dati mensa a seconda del tipo}
var i:Integer;
begin
  R180AbilitaOggetti(grpPausaMensaTimbrata,dcmbTipoMensa.Text <> 'Z');
  R180AbilitaOggetti(grpMensaAutomatica,dcmbTipoMensa.Text <> 'Z');
  R180AbilitaOggetti(grpTimbraturaMensa,dcmbTipoMensa.Text <> 'Z');
  R180AbilitaOggetti(grpPMIntermedia,dcmbTipoMensa.Text <> 'Z');
  dedtMMMinimi.Enabled:=dcmbTipoMensa.Text <> 'Z';
  lblMMMinimi.Enabled:=dcmbTipoMensa.Text <> 'Z';
  lblMinPercorr.Enabled:=dcmbTipoMensa.Text <> 'Z';
  dedtMinPercorr.Enabled:=dcmbTipoMensa.Text <> 'Z';
  lblPMTTolleranza.Enabled:=dcmbTipoMensa.Text <> 'Z';
  dedtPMTTolleranza.Enabled:=dcmbTipoMensa.Text <> 'Z';
  dgrdPausamensa.Enabled:=dcmbTipoMensa.Text <> 'Z';
  if dcmbTipoMensa.Text = 'Z' then exit;
  A006FModelliOrarioDtM1.A006MW.selT021PM.FieldByName('MMFlex').Visible:=R180In(dcmbTipoMensa.Text,['B','D','E','F']);
  dchkPMTLimiteFlex.Enabled:=R180In(dcmbTipoMensa.Text,['B','D','E','F']);
  //Pausa mensa automatica
  for i:=0 to grpMensaAutomatica.ControlCount - 1 do
    grpMensaAutomatica.Controls[i].Enabled:=R180In(dcmbTipoMensa.Text,['C','D','E','F']);
  lblPMRecupUscita.Enabled:=R180In(dcmbTipoMensa.Text,['D','E','F']);
  dedtPMRecupUscita.Enabled:=R180In(dcmbTipoMensa.Text,['D','E','F']);
  dedtRientroMinimo.Enabled:=dedtRientroMinimo.Enabled and (dcmbTipoMensa.Text = 'F');
  lblRientroMinimo.Enabled:=dedtRientroMinimo.Enabled and (dcmbTipoMensa.Text = 'F');
  dchkPMAutoURit.Enabled:=dchkPMAutoURit.Enabled and (dcmbTipoMensa.Text <> 'F');
  dchkPMTUscitaRit.Enabled:=dchkPMAutoURit.Enabled and dchkPMAutoURit.Checked;
  dchkPMAPreservaTimbInFascia.Enabled:=R180In(dcmbTipoMensa.Text,['E','F']);
  if (dcmbTipoMensa.Text = 'F') and (DButton.State in [dsEdit,dsInsert]) then
  begin
    dchkPMAutoURit.Field.AsString:='N';
    dchkPMTUscitaRit.Field.AsString:='N';
  end;
  dchkDetrazParzStaccoInf.Enabled:=R180In(dcmbTipoMensa.Text,['E','F']) and (not dedtPMOreMinimeInf.Field.IsNull) and (not dedtPMStaccoInf.Field.IsNull);
  //Timbratura Mensa
  dchkTimbraturaMensaDetrTot.Enabled:=dchkTimbraturaMensa.Checked and R180In(dcmbTipoMensa.Text,['E','F']);
  dchkTimbraturaMensaFlex.Enabled:=dchkTimbraturaMensa.Checked and (dcmbTipoMensa.Text = 'C');
end;

procedure TA006FModelliOrario.VisualizzaDatiSelT021;
{Visualizzazione dati di selT021 nelle griglie, in base al Tipo orario e alla pausa mensa}
var i:Integer;
begin
  if (PageControl.ActivePage <> tabTimbrature) then exit;
  {Ripristino tutti i dati}
  with A006FModelliOrarioDtM1.A006MW.selT021PN do
    for i:=0 to FieldCount - 1 do
      Fields[i].Visible:=(Fields[i].FieldName <> 'CODICE') and (Fields[i].FieldName <> 'DECORRENZA');

  A006FModelliOrarioDtM1.A006MW.selT021PN.FieldByName('INDTURNO').Visible:=(A006FModelliOrarioDtM1.A006MW.selT021PN.FieldByName('INDTURNO').Visible) and (A006FModelliOrarioDtM1.A006MW.FTipoOrario = toE);
  A006FModelliOrarioDtM1.A006MW.selT021PN.FieldByName('INDFESTIVA').Visible:=(A006FModelliOrarioDtM1.A006MW.selT021PN.FieldByName('INDFESTIVA').Visible) and (A006FModelliOrarioDtM1.A006MW.FTipoOrario = toE);
  A006FModelliOrarioDtM1.A006MW.VisualizzaDatiTimbrature(dchkFrazDeb.Checked);
end;

procedure TA006FModelliOrario.VisualizzaPaginaOpzioni;
{Gestione visualizzazione dati nella pagina Opzioni}
begin
  {Visualizzazione label}
  lblOreTeor.Enabled:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toA,toB,toC,toD];
  dedtOreTeor.Enabled:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toA,toB,toC,toD];
  lblOreMax.Visible:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toC];
  dedtOreMax.Visible:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toC];
  dchkFrazDeb.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]);
  dchkFrazDebNoTurnista.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]);
  dchkNotteEntrata.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]);
  dchkFlexDopoMezanotte.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]);
  lblMinUscitaNotte.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]);
  dedtMinUscitaNotte.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]);
  lblTipoFle.Visible:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toA];
  dcmbTipoFle.Visible:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toA];
  dchkCompDetr.Visible:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toC];
  chkDopoOreMax.Enabled:= A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toC];
  dcmbTipoFle.Enabled:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toA]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plS]);
  if (DButton.State in [dsInsert,dsEdit]) and (A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toA]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plC]) then
    dcmbTipoFle.Field.AsString:='A';
  pnlTurni.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]);
  {Competenza turno notturno}
  drgpFlagPres.Enabled:=Trim(dedtMMIndPres.Text) = '.';
  dedtMMIndMPres.Enabled:=dchkFlagMPres.Checked;
  drgpCompNot.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]);
  dedtOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
  lblOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
  {Pausa mensa abilitata}
  if (DButton.State in [dsInsert,dsEdit]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plS]) and (not (A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toC])) then
    A006FModelliOrarioDtM1.selT020.FieldByName('TipoMensa').AsString:='Z';

  dchkStrNotteSpezzato.Enabled:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]) and dchkNotteEntrata.Checked;

  lblTurniInizioOrario.Visible:=A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE];
  dedtTurniInizioOrario.Visible:=lblTurniInizioOrario.Visible;
  lblTurniFineOrario.Visible:=lblTurniInizioOrario.Visible;
  dedtTurniFineOrario.Visible:=lblTurniInizioOrario.Visible;
end;

procedure TA006FModelliOrario.PulisciValore(Sender: TObject);
begin
  if not(DButton.State in [dsInsert,dsEdit]) then exit;
  if (Sender as TDBEdit).Text = '  .  ' then
    (Sender as TDBEdit).Field.Clear;
  if Sender = dedtMMIndPres then
    begin
    drgpFlagPres.Enabled:=dedtMMIndPres.Text = '  .  ';
    if (dedtMMIndPres.Text <> '  .  ') and (not drgpFlagPres.Field.IsNull) then
      drgpFlagPres.Field.AsString:=' ';
    if dedtMMIndPres.Text = '  .  ' then
      drgpFlagPres.Field.AsString:='N';
    end;
end;

procedure TA006FModelliOrario.dchkFlagMPresClick(Sender: TObject);
{Introduzione Ore per mezza indennit� presenza}
begin
  if (not dchkFlagMPres.Checked) and (DButton.State in [dsInsert,dsEdit]) then
    dedtMMIndMPres.Field.Clear;
  dedtMMIndMPres.Enabled:=dchkFlagMPres.Checked;
end;

procedure TA006FModelliOrario.dchkSoloCompClick(Sender: TObject);
begin
  EComp1.Visible:=not dchkSoloComp.Checked;
  EComp2.Visible:=dchkSoloComp.Checked;
  if dchkSoloComp.Checked and (DButton.State in [dsEdit,dsInsert]) then
    if (EComp2.Field.AsString <> 'N') and (EComp2.Field.AsString <> 'P') then
      EComp2.Field.AsString:='N';
end;

procedure TA006FModelliOrario.dchkFrazDebClick(Sender: TObject);
begin
  A006FModelliOrarioDtM1.A006MW.selT021PNORETEOTUR2.Visible:=(A006FModelliOrarioDtM1.A006MW.FTipoOrario in [toE]) and (A006FModelliOrarioDtM1.A006MW.FPeriodoLav in [plT1]) and (dchkFrazDeb.Checked);
  dchkFrazDebNoTurnista.Enabled:=dchkFrazDeb.Checked;
  dchkNotteEntrata.Enabled:=not(dchkFrazDeb.Checked);
  if (not dchkNotteEntrata.Enabled) and (DButton.State in [dsInsert,dsEdit]) then
    dchkNotteEntrata.Field.AsString:='N';
end;

procedure TA006FModelliOrario.dchkNotteEntrataClick(Sender: TObject);
begin
  dchkFrazDeb.Enabled:=not(dchkNotteEntrata.Checked);
  dchkFrazDebNoTurnista.Enabled:=not(dchkNotteEntrata.Checked) and dchkFrazDeb.Checked;
  dchkFlexDopoMezanotte.Enabled:=dchkNotteEntrata.Checked;
  if (not dchkFrazDeb.Enabled) and (DButton.State in [dsInsert,dsEdit]) then
    dchkFrazDeb.Field.AsString:='N';
end;

procedure TA006FModelliOrario.dchkPMAutoURitClick(Sender: TObject);
begin
  //Disabilito il parametro "Ore continuative" se "Forzata se uscita dopo ore max"
  if (dchkPMAutoURit.Checked) and (DButton.State in [dsEdit,dsInsert])then
    A006FModelliOrarioDtM1.selT020.FieldByName('DETRAUTCONT').AsString:='N';
  dchkDetrAutCont.Enabled:=not dchkPMAutoURit.Checked;
  dchkPMTUscitaRit.Enabled:=dchkPMAutoURit.Checked;
  if (dchkPMAutoURit.Checked) and (DButton.State in [dsEdit,dsInsert]) and (A006FModelliOrarioDtM1.A006MW.selT021PM.State = dsBrowse) then
    A006FModelliOrarioDtM1.A006MW.PulisciTipoFasciaPMA;
  lblRientroMinimo.Enabled:=(not dchkPMAutoURit.Checked) and (dcmbTipoMensa.Text = 'F');
  dedtRientroMinimo.Enabled:=(not dchkPMAutoURit.Checked) and (dcmbTipoMensa.Text = 'F');
end;

procedure TA006FModelliOrario.dgrdSelT021Exit(Sender: TObject);
begin
  if (Sender as TDBGrid).DataSource.State in [dsInsert,dsEdit] then
    (Sender as TDBGrid).DataSource.DataSet.Post;
end;

procedure TA006FModelliOrario.dgrdTimbratureDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'ROWNUM' then
    if Not(gdSelected in state) then
    begin
      dgrdTimbrature.Canvas.Brush.Color:=cl3DLight;
      dgrdTimbrature.Canvas.Font.Color:=clBlack;
    end
    else
    begin
      dgrdTimbrature.Canvas.Brush.Color:=clHighlight;
      dgrdTimbrature.Canvas.Font.Color:=clWhite;
    end;
  dgrdTimbrature.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TA006FModelliOrario.drgpIndFestivaChange(Sender: TObject);
{Introduzione Ore per indennit� festive}
begin
  if (drgpIndFestiva.ItemIndex = 0) and (DButton.State in [dsInsert,dsEdit]) then
    dedtOreIndFest.Field.Clear;
  dedtOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
  lblOreIndFest.Enabled:=drgpIndFestiva.ItemIndex > 0;
end;

procedure TA006FModelliOrario.drgpRiposoCompensativoChange(Sender: TObject);
begin
  inherited;
  with grpAltreIndennita do
  begin
    lblDebitoRipCom.Caption:='Ore massime';
    if drgpRiposoCompensativo.ItemIndex = 1 then
      lblDebitoRipCom.Caption:='Debito teorico';
    lblDebitoRipCom.Enabled:=drgpRiposoCompensativo.ItemIndex > 0;
    dedtDebitoRipCom.Enabled:=drgpRiposoCompensativo.ItemIndex > 0;
    dchkRipcomGGNonLav.Enabled:=drgpRiposoCompensativo.ItemIndex = 2;
    dchkRipcomDebitoGG.Enabled:=drgpRiposoCompensativo.ItemIndex = 2;
  end;
end;

procedure TA006FModelliOrario.Stampa1Click(Sender: TObject);
var i:Integer;
begin
  QueryStampa.Clear;
  QueryStampa.Add('SELECT * FROM T020_ORARI T020, T021_FASCEORARI T021');
  QueryStampa.Add('WHERE T020.CODICE = T021.CODICE(+) AND T020.DECORRENZA = T021.DECORRENZA(+)');
  QueryStampa.Add('ORDER BY T020.CODICE,T020.DECORRENZA,T021.TIPO_FASCIA,nvl(T021.ID_TURNO,oreminuti(T021.ENTRATA)),T021.USCITA');
  NomiCampiR001.Clear;
  with A006FModelliOrarioDtM1 do
  begin
    for i:=0 to selT020.FieldDefs.Count - 1 do
      NomiCampiR001.Add('T020.' + selT020.FieldDefs[i].Name);
    for i:=0 to A006MW.selT021PN.FieldDefs.Count - 1 do
    begin
      if A006MW.selT021PN.FieldDefs[i].Name <> 'ROWNUM' then
        NomiCampiR001.Add('T021.' + A006MW.selT021PN.FieldDefs[i].Name);
    end;
  end;
  inherited;
end;

procedure TA006FModelliOrario.Copiada1Click(Sender: TObject);
begin
  inherited;
  A006FModelliOrarioDtM1.selT020AfterScroll(A006FModelliOrarioDtM1.selT020);
end;

procedure TA006FModelliOrario.btnAnomalieBloccantiClick(Sender: TObject);
var
  LstAnomalie:TStringList;
  i: integer;
begin
  inherited;
  with TC013FCheckList.Create(nil) do
    try
      LstAnomalie:=TStringList.Create;
      for i:=low(tdescanom2) to High(tdescanom2) do
        LstAnomalie.Add(R180DimLung('2_' + IntToStr(tdescanom2[i].N),6) + ' ' + tdescanom2[i].D);
      for i:=low(tdescanom3) to High(tdescanom3) do
        LstAnomalie.Add(R180DimLung('3_' + IntToStr(tdescanom3[i].N),6) + ' ' + tdescanom3[i].D);
      clbListaDati.Items.Assign(LstAnomalie);

      R180PutCheckList(A006FModelliOrarioDtM1.selT020.FieldByName('ANOM_BLOCC_23LIV').AsString,5,clbListaDati);
      if ShowModal = mrOK then
        if DButton.State in [dsEdit,dsInsert] then
          A006FModelliOrarioDtM1.selT020.FieldByName('ANOM_BLOCC_23LIV').AsString:=R180GetCheckList(5,clbListaDati);
    finally
      Free;
      FreeAndNil(LstAnomalie)
    end;
end;

procedure TA006FModelliOrario.btnCausaliEccedenzaClick(Sender: TObject);
begin
  inherited;
  with TC013FCheckList.Create(nil) do
    try
      clbListaDati.Items.Assign(A006FModelliOrarioDtM1.A006MW.lstT275);
      if Sender = btnCausaliEccedenza then
        R180PutCheckList(A006FModelliOrarioDtM1.selT020.FieldByName('CAUSALI_ECCEDENZA').AsString,5,clbListaDati)
      else if Sender = btnCausRiduzPN then
        R180PutCheckList(A006FModelliOrarioDtM1.selT020.FieldByName('CAUS_RIDUZPN').AsString,5,clbListaDati)
      else if Sender = btnCausRiduzPNCheckPMT then
        R180PutCheckList(A006FModelliOrarioDtM1.selT020.FieldByName('CAUS_RIDUZPN_CHECKPMT').AsString,5,clbListaDati);
      if ShowModal = mrOK then
        if DButton.State in [dsEdit,dsInsert] then
        begin
          if Sender = btnCausaliEccedenza then
            A006FModelliOrarioDtM1.selT020.FieldByName('CAUSALI_ECCEDENZA').AsString:=R180GetCheckList(5,clbListaDati)
          else if Sender = btnCausRiduzPN then
            A006FModelliOrarioDtM1.selT020.FieldByName('CAUS_RIDUZPN').AsString:=R180GetCheckList(5,clbListaDati)
          else if Sender = btnCausRiduzPNCheckPMT then
            A006FModelliOrarioDtM1.selT020.FieldByName('CAUS_RIDUZPN_CHECKPMT').AsString:=R180GetCheckList(5,clbListaDati);
        end;
    finally
      Free;
    end;
end;

procedure TA006FModelliOrario.btnOrariScambioClick(Sender: TObject);
begin
  inherited;
  with TC013FCheckList.Create(nil) do
    try
      A006FModelliOrarioDtM1.A006MW.CaricaLstT020;
      clbListaDati.Items.Assign(A006FModelliOrarioDtM1.A006MW.lstT020);
      R180PutCheckList(A006FModelliOrarioDtM1.selT020.FieldByName('ORARI_SCAMBIO').AsString,5,clbListaDati);
      if ShowModal = mrOK then
        if DButton.State in [dsEdit,dsInsert] then
          A006FModelliOrarioDtM1.selT020.FieldByName('ORARI_SCAMBIO').AsString:=R180GetCheckList(5,clbListaDati);
    finally
      Free;
    end;
end;

procedure TA006FModelliOrario.btnStoricizzaClick(Sender: TObject);
begin
  inherited;
  A006FModelliOrarioDtM1.selT020AfterScroll(A006FModelliOrarioDtM1.selT020);
end;

procedure TA006FModelliOrario.dchkRicalcoloDebitoGGClick(Sender: TObject);
begin
  lblRicalcoloMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloDebMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloDebMin.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloDebMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dedtRicalcoloDebMax.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dchkRicalcoloSpostaPN.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dchkRicalcoloOffNoTimb.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloCausNeg.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dlckRicalcoloCausNeg.Enabled:=dchkRicalcoloDebitoGG.Checked;
  lblRicalcoloCausPos.Enabled:=dchkRicalcoloDebitoGG.Checked;
  dlckRicalcoloCausPos.Enabled:=dchkRicalcoloDebitoGG.Checked;
end;

procedure TA006FModelliOrario.dcmbTipoStraordinarioChange(Sender: TObject);
var i:Integer;
begin
  inherited;
  dChkCompseInf.Enabled:=(dcmbTipoStraordinario.Text = '3') or (dcmbTipoStraordinario.Text = '4');
  dchkArrotComp2.Enabled:=(dcmbTipoStraordinario.Text = '3') or (dcmbTipoStraordinario.Text = '4');
  for i:=0 to GroupBox11.ControlCount - 1 do
    GroupBox11.Controls[i].Enabled:=(dcmbTipoStraordinario.Text = '1') or (dcmbTipoStraordinario.Text = '2');
end;

procedure TA006FModelliOrario.dchkTimbraturaMensaClick(Sender: TObject);
begin
  inherited;
  dchkTimbraturaMensaDetrTot.Enabled:=dchkTimbraturaMensa.Checked and ((dcmbTipoMensa.Text = 'E') or (dcmbTipoMensa.Text = 'F'));
  dchkTimbraturaMensaFlex.Enabled:=dchkTimbraturaMensa.Checked and (dcmbTipoMensa.Text = 'C');
  (* Commento gi� presente prima dell'inserimento del MW
  drgpTimbraturaMensaInterna.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  dedtTimbraturaMensaDetrazione.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  lblTimbraturaMensaDetrazione.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  dchkTimbraturaMensaDetParziale.Enabled:=dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked;
  if (DButton.State in [dsEdit,dsInsert]) and not(dchkTimbraturaMensa.Checked or dchkPmtSoloTimbMensa.Checked) then
    drgpTimbraturaMensaInterna.Field.AsString:='N';
  *)
end;

end.
