unit WA029USchedaRiepilDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData,A029USchedaRiepilMW,A029UBudgetDtM1, C180FunzioniGenerali,
  A000UInterfaccia, A000Umessaggi, MedpIWMessageDlg;

type
  TWA029FSchedaRiepilDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaDEBITOORARIO: TStringField;
    selTabellaDEBITOPO: TStringField;
    selTabellaTIPOPO: TStringField;
    selTabellaFESTIVINTERA: TFloatField;
    selTabellaFESTIVINTERA_VAR: TFloatField;
    selTabellaFESTIVRIDOTTA: TFloatField;
    selTabellaFESTIVRIDOTTA_VAR: TFloatField;
    selTabellaINDTURNONUM: TFloatField;
    selTabellaINDTURNONUM_VAR: TIntegerField;
    selTabellaINDTURNOORE: TStringField;
    selTabellaINDTURNOORE_VAR: TStringField;
    selTabellaCAUSALE1MINASS: TStringField;
    selTabellaCAUSALE2MINASS: TStringField;
    selTabellaOREECCEDCOMP: TStringField;
    selTabellaTURNI1: TFloatField;
    selTabellaTURNI2: TFloatField;
    selTabellaTURNI3: TFloatField;
    selTabellaTURNI4: TFloatField;
    selTabellaGGPRESENZA: TFloatField;
    selTabellaGGVUOTI: TFloatField;
    selTabellaOREVARIAZECC: TStringField;
    selTabellaOREASSENZE: TStringField;
    selTabellaRECANNOCORR: TStringField;
    selTabellaRECANNOPREC: TStringField;
    selTabellaSCOSTNEG: TStringField;
    selTabellaRIPCOM: TStringField;
    selTabellaABBRIPCOM: TStringField;
    selTabellaADDEBITOPAGHE: TStringField;
    selTabellaRECLIQCORR: TStringField;
    selTabellaRECLIQPREC: TStringField;
    selTabellaORECOMP_LIQUIDATE: TStringField;
    selTabellaLIQ_FUORI_BUDGET: TFloatField;
    selTabellaORECOMP_RECUPERATE: TStringField;
    selTabellaOREECCEDCOMPOLTRESOGLIA: TStringField;
    selTabellaORE_INAIL: TStringField;
    selTabellaRIPOSI_NONFRUITI: TIntegerField;
    selTabellaRIPOSINONFRUITIORE: TStringField;
    selTabellaBANCAORE_LIQ_VAR: TStringField;
    selTabellaD_Causale1: TStringField;
    selTabellaD_Causale2: TStringField;
    selTabellaRIEPASS_COMPENSATE_ANNO: TStringField;
    selTabellaRIEPASS_COMPENSATE_MESE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure AfterCancel(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaAfterInsert(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selTabellaBeforeCancel(DataSet: TDataSet);
  private
    AbortPost,
    PutLiquidatoFuoriBudget,
    ConfermaGestioneBudget,
    RispostaConfermaGestione: Boolean;
    OreLiq,MaxLiquidato: Integer;
    MsgAbort: String;
    procedure selT074LiqBeforePost(DataSet: TDataSet);
    procedure selT073CompBeforePost(DataSet: TDataSet);
    { Private declarations }
  public
    A029FSchedaRiepilMW: TA029FSchedaRiepilMW;
    procedure ResultConfermaPostSelTabella(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultConfermaGestioneBudget(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultConfermaPostSelT074Liq(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure OnChangeSelT071;
  end;

implementation

uses WA029USchedaRiepil, WA029USchedaRiepilDettFM;
{$R *.dfm}

procedure TWA029FSchedaRiepilDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A029FSchedaRiepilMW:=TA029FSchedaRiepilMW.Create(Self);
  with A029FSchedaRiepilMW do
  begin
    selT070_Funzioni:=selTabella;
    ApplyUpdatesT075:=False; //WEBPJ non deve fare applyupdates sul post del t075 ma solo sul post di selTabella
    //Impostazioni specifiche per WEBPJ
    selT071.ReadOnly:=False;
    selT072.ReadOnly:=False;
    selT076.CachedUpdates:=True;
    //webpj usa campo centro costo con combo popolata con elementi qlook75
    selT075.FieldByName('CENTROCOSTO').DisplayLabel:=Parametri.CampiRiferimento.C2_Budget;
    selT075.FieldByName('CENTROCOSTO').Visible:=True;
    selT075.FieldByName('C_CENTROCOSTO').Visible:=False;

    selTabella.FieldByName('D_CAUSALE1').LookupDataSet:=selT305;
    selTabella.FieldByName('D_CAUSALE2').LookupDataSet:=selT305;

    //impostazione campi readonly
    selT071.FieldByName('D_FASCIA').ReadOnly:=True;
    selT071.FieldByName('TOTALE').ReadOnly:=True;
    selT072.FieldByName('D_IndPres').ReadOnly:=True;
    selT071.FieldByName('ORESTRAORDLIQ').ReadOnly:=True;

    selT074Liq.BeforePost:=Self.selT074LiqBeforePost;
    selT073Comp.BeforePost:=Self.selT073CompBeforePost;
  end;
  inherited;
end;

procedure TWA029FSchedaRiepilDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A029FSchedaRiepilMW.selT070BeforeDelete;
end;

procedure TWA029FSchedaRiepilDM.BeforeEdit(DataSet: TDataSet);
var
  LOldProg: Integer;
  LOldData: TDateTime;
begin
  // refresh del dataset per garantire che i dati siano allineati
  // potrebbe essere infatti stata rigenerata la scheda nel frattempo
  LOldProg:=selTabella.FieldByName('Progressivo').AsInteger;
  LOldData:=selTabella.FieldByName('Data').AsDateTime;
  selTabella.Refresh;
  if not selTabella.SearchRecord('PROGRESSIVO;DATA',VarArrayOf([LOldProg,LOldData]),[srFromBeginning]) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A029_ERR_SCHEDA_CANC_ESTERNO));

  inherited;

  //devo richiamarlo nella before edit perchè sullo state change si
  //scatena l'abilitaComponenti del frame di dettaglio che valuta se dataset
  //figli sono readonly o meno
  A029FSchedaRiepilMW.selT070Edit;
  if not A029FSchedaRiepilMW.selT073Comp.ReadOnly then
    A029FSchedaRiepilMW.selT073Comp.Edit;
end;

procedure TWA029FSchedaRiepilDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  A029FSchedaRiepilMW.selT070BeforeInsert;
end;

procedure TWA029FSchedaRiepilDM.BeforePostNoStorico(DataSet: TDataSet);
var
  Msg: String;
  DialogConferma,
  Cambiato: Boolean;
  ImpLiq: real;
begin
  inherited;

  // in edit verifica che la scheda non sia stata modificata o eliminata nel frattempo
  if A029FSchedaRiepilMW.IsRecordSchedaChangedOrDeleted(Msg) then
  begin
    MsgBox.MessageBox(Msg,INFORMA);
    Abort;
  end;

  with ((Self.Owner as TWA029FSchedaRiepil).WDettaglioFM as TWA029FSchedaRiepilDettFM) do
  begin
    if R180OreMinutiExt(edtStraordEsterno.Text) > R180OreMinutiExt(edtStraordLiquid.Text) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A029_ERR_STRAORD_EST,mtError,[mbOk],nil,'');
      Abort;
    end;
    //verifica disponibilità liquidità
    Msg:=A029FSchedaRiepilMW.VerificaDispLiquidità;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  A029FSchedaRiepilMW.selT070BeforePost(False);

  if (not MsgBox.KeyExists('PUNTO_1')) then
  begin
    AbortPost:=False;
    MsgAbort:='';
    Msg:=A029FSchedaRiepilMW.ControllaLiquidato(DialogConferma);
    if Msg <> '' then
    begin
      if DialogConferma then
        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaPostSelTabella,'PUNTO_1')
      else
        MsgBox.WebMessageDlg(Msg,mtError,[mbOk],ResultConfermaPostSelTabella,'PUNTO_1');
      Abort;
    end;
  end;

  if (not MsgBox.KeyExists('PUNTO_2')) then
  begin
    try
      PutLiquidatoFuoriBudget:=False;
      ConfermaGestioneBudget:=False;
      if not AbortPost then
      begin
        if A029FSchedaRiepilMW.Budget then
        begin
          A029FSchedaRiepilMW.ControllaStraordinarioLiquidato(Cambiato,OreLiq,ImpLiq,MaxLiquidato);
          // effettua i controlli sul budget solo se le ore in fasce di maggiorazione
          // sono cambiate rispetto a prima
          if Cambiato then //if Liquidato <> 0 then
          begin
            if Parametri.CampiRiferimento.C2_Facoltativo = 'N' then
            begin
              A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(True,selTabella.FieldByName('Progressivo').AsInteger,selTabella.FieldByName('Data').AsDateTime,OreLiq,ImpLiq);
            end
            else if Parametri.CampiRiferimento.C2_Facoltativo = 'S' then
            begin
              ConfermaGestioneBudget:=True;
              MsgBox.WebMessageDlg(Format(A000MSG_A029_DLG_FMT_GEST_BUDGET,[R180MinutiOre(OreLiq)]),mtConfirmation,[mbYes,mbNo],ResultConfermaGestioneBudget,'PUNTO_2');
              Abort;
            end;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        if (E is EAbort) then
        begin
          AbortPost:=True;
          MsgAbort:=e.Message;
        end
        else
          raise;
      end;
    end;
  end;

  if ConfermaGestioneBudget then
  begin
    try
      if RispostaConfermaGestione then
        A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.ControllaBudget(True,selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATA').AsDateTime,OreLiq,ImpLiq)
      else
        PutLiquidatoFuoriBudget:=True;
    except
      on E: Exception do
      begin
        if (E is EAbort) then
        begin
          AbortPost:=True;
          MsgAbort:=e.Message;
        end
        else
          raise;
      end;
    end;
  end;
end;

procedure TWA029FSchedaRiepilDM.AfterPost(DataSet: TDataSet);
var BancaOreLiquidata:Integer;
  CodGruppo,FiltroAnagrafe:String;
begin
  inherited;

  BancaOreLiquidata:=0;
  A029FSchedaRiepilMW.NDaLiquidare:=0;
  if (not AbortPost) then
  begin
    BancaOreLiquidata:=A029FSchedaRiepilMW.CalcolaBancaOreLiquidata;
    A029FSchedaRiepilMW.ApplicaModifiche;
  end
  else //msgbox e prosegue. lo visualizza alla fine
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_ESEGUITA + CRLF + MsgAbort,mtError,[mbOk],nil,'');

  A029FSchedaRiepilMW.ImpostaLiquidazioneEBancaOre(BancaOreLiquidata);

  if A029FSchedaRiepilMW.Budget then
  begin
    if (not AbortPost) then
    begin
      //Queste operazioni vanno fatte dopo ApplicaModifiche perchè si va a modificare la selT070
      //e quindi la commit darebbe errore di dato modificato da altro utente
      if PutLiquidatoFuoriBudget then
        A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.PutLiquidatoFuoriBudget(selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATA').AsDateTime,OreLiq);

      // ore liquidate fuori budget
      if Parametri.CampiRiferimento.C2_Facoltativo = 'S' then
        A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.PutMaxLiquidatoFuoriBudget(selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATA').AsDateTime,MaxLiquidato);
    end;
    A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.GetRaggruppamentiBudget(selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATA').AsDateTime,CodGruppo,FiltroAnagrafe);
    A029FSchedaRiepilMW.A029FLiquidazione.A029FBudgetDtM1.AggiornaFruitoBudget(selTabella.FieldByName('DATA').AsDateTime,TipoLiq,CodGruppo,FiltroAnagrafe,'E');
    SessioneOracle.Commit;
  end;
  MsgBox.ClearKeys;
  selTabella.RefreshRecord;
  AfterScroll(selTabella);
end;

procedure TWA029FSchedaRiepilDM.AfterCancel(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070AfterCancel;
  inherited;
end;

procedure TWA029FSchedaRiepilDM.AfterDelete(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070AfterDelete;
  inherited;
end;

procedure TWA029FSchedaRiepilDM.AfterScroll(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT070AfterScroll;
  inherited;
end;

//Richiamato sulla modifica della grid grdFasce
procedure TWA029FSchedaRiepilDM.OnChangeSelT071;
var i:Integer;
begin
  with A029FSchedaRiepilMW do
  begin
    i:=GetPosFascia(selT071.FieldByName('CodFascia').AsString,selT071.FieldByName('Maggiorazione').AsInteger);
    //OreLavorate
    R450DtM1.L07.tminlavmese[i]:=R180OreMinutiExt(selT071.FieldByName('OreLavorate').AsString);
    //Ore Assestamento 1
    R450DtM1.L07.tdatiassestamento[1].tminassest[i]:=R180OreMinutiExt(selT071.FieldByName('Ore1Assest').AsString);
    //Ore Assestamento 2
    R450DtM1.L07.tdatiassestamento[2].tminassest[i]:=R180OreMinutiExt(selT071.FieldByName('Ore2Assest').AsString);
    //Ore Eccedenze giornaliere
    R450DtM1.L07.tminstrmens[i]:=R180OreMinutiExt(selT071.FieldByName('OreEccedGiorn').AsString);
    if (R450DtM1.LiquidazioneDistribuita = 'S') then //Ore Sraordinario liquidabile
      R450DtM1.L07.tLiqNelMese[i]:=R180OreMinutiExt(selT071.FieldByName('LiquidNelMese').AsString);

    CalcolaDati;
  end;
end;

procedure TWA029FSchedaRiepilDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A029FSchedaRiepilMW.selT070NewRecord;
end;

procedure TWA029FSchedaRiepilDM.ResultConfermaGestioneBudget(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  RispostaConfermaGestione:=Res = mrYes;
  selTabella.Post
end;

procedure TWA029FSchedaRiepilDM.ResultConfermaPostSelT074Liq(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrOk then
    ((Self.Owner as TWA029FSchedaRiepil).WDettaglioFM as TWA029FSchedaRiepilDettFM).grdPresLiq.medpRiconferma
  else
    MsgBox.ClearKeys;
end;

procedure TWA029FSchedaRiepilDM.ResultConfermaPostSelTabella(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res <> mrYes then
    AbortPost:=True;

  selTabella.Post
end;

procedure TWA029FSchedaRiepilDM.selTabellaAfterInsert(DataSet: TDataSet);
begin
  if not A029FSchedaRiepilMW.selT070AfterInsert then
  begin
    MsgBox.WebMessageDlg(A000MSG_A029_ERR_CONTR_FASCE,mtError,[mbOk],nil,'');
    selTabella.Cancel;
  end;
end;

procedure TWA029FSchedaRiepilDM.selTabellaBeforeCancel(DataSet: TDataSet);
begin
  inherited;
  with A029FSchedaRiepilMW do
  begin
    if selT071.State <> dsBrowse then
      selT071.Cancel;
    if selT072.State <> dsBrowse then
      selT072.Cancel;
    if selT074.State <> dsBrowse then
      selT074.Cancel;
    if selT075.State <> dsBrowse then
      selT075.Cancel;
    if selT076.State <> dsBrowse then
      selT076.Cancel;
    if selT077.State <> dsBrowse then
      selT077.Cancel;
    if selT074Liq.State <> dsBrowse then
      selT074Liq.Cancel;
    if selT073Comp.State <> dsBrowse then
      selT073Comp.Cancel;
  end;
end;

procedure TWA029FSchedaRiepilDM.selT074LiqBeforePost(DataSet: TDataSet);
{Controllo che il liquidato non sia maggiore della disponibilità}
var
  Msg,CodiceCausPresenza: String;
  DialogConferma: Boolean;
begin
  // verifica che la scheda T070 non sia stata modificata o eliminata nel frattempo
  if A029FSchedaRiepilMW.IsRecordSchedaChangedOrDeleted(Msg) then
  begin
    MsgBox.MessageBox(Msg,INFORMA);
    Abort;
  end;

  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    CodiceCausPresenza:=((Self.Owner as TWA029FSchedaRiepil).WDettaglioFM as TWA029FSchedaRiepilDettFM).cmbCausPresenza.Text;

    Msg:=A029FSchedaRiepilMW.selT074LiqBeforePost(CodiceCausPresenza,DialogConferma);
    if Msg <> '' then
    begin
      if DialogConferma then
        MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbOk,mbCancel],ResultConfermaPostSelT074Liq,'PUNTO_1')
      else
        MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  MsgBox.ClearKeys;
end;

procedure TWA029FSchedaRiepilDM.selT073CompBeforePost(DataSet: TDataSet);
begin
  A029FSchedaRiepilMW.selT073CompBeforePost(((Self.Owner as TWA029FSchedaRiepil).WDettaglioFM as TWA029FSchedaRiepilDettFM).cmbCausPresenza.Text);
end;

procedure TWA029FSchedaRiepilDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A029FSchedaRiepilMW);
  inherited;
end;

end.
