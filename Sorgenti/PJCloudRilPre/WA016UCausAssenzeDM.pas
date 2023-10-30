unit WA016UCausAssenzeDM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A016UCausAssenzeMW, A000USessione,
  A000UInterfaccia, C180FunzioniGenerali, medpIWMessageDlg, DBClient, C190FUnzioniGeneraliWeb,
  A016UCausAssenzeStoricoMW;

type
  TWA016FCausAssenzeDM = class(TWR302FGestTabellaDM)
    T265Codice: TStringField;
    T265Descrizione: TStringField;
    selTabellaCodRaggr: TStringField;
    T265GNonLav: TStringField;
    selTabellaInfluCont: TStringField;
    T265ValorGior: TStringField;
    T265InfluenzaPO: TStringField;
    T265Indpres: TStringField;
    T265EccedLiq: TStringField;
    selTabellaHMAssenza: TDateTimeField;
    T265RaggrStat: TStringField;
    T265Stampa: TStringField;
    T265VocePaghe: TStringField;
    T265GSignific: TStringField;
    T265Fruibile: TStringField;
    T265MaturFerie: TStringField;
    T265AValidAss: TFloatField;
    selTabellaHMaxUnitario: TStringField;
    selTabellaGMaxUnitario: TStringField;
    selTabellaUMisura: TStringField;
    selTabellaCompetenza1: TStringField;
    selTabellaRetribuzione1: TFloatField;
    selTabellaCompetenza2: TStringField;
    selTabellaRetribuzione2: TFloatField;
    selTabellaCompetenza3: TStringField;
    selTabellaRetribuzione3: TFloatField;
    selTabellaCompetenza4: TStringField;
    selTabellaRetribuzione4: TFloatField;
    selTabellaCompetenza5: TStringField;
    selTabellaRetribuzione5: TFloatField;
    selTabellaCompetenza6: TStringField;
    selTabellaRetribuzione6: TFloatField;
    selTabellaTipoCumulo: TStringField;
    selTabellaDurataCumulo: TFloatField;
    selTabellaUMCumulo: TStringField;
    selTabellaGMCumulo: TStringField;
    selTabellaCodCauInizio: TStringField;
    selTabellaCodCau1: TStringField;
    selTabellaCODCAU2: TStringField;
    selTabellaFruizione: TStringField;
    selTabellaDurataFruizione: TFloatField;
    selTabellaUMFruizione: TStringField;
    selTabellaCodCauFruizione: TStringField;
    selTabellaD_Raggruppamento: TStringField;
    selTabellaD_CodCauInizio: TStringField;
    selTabellaD_CodCauFruizione: TStringField;
    selTabellaDETREPERIB: TStringField;
    selTabellaORESETT: TStringField;
    selTabellaASSTOLL: TStringField;
    selTabellaCUMULOGLOBALE: TStringField;
    selTabellaCAMPOGLOBALE: TStringField;
    selTabellaRICORSIONE: TStringField;
    selTabellaVALSETIMB: TStringField;
    selTabellaRECUPEROFESTIVO: TStringField;
    selTabellaESCLUSIONE: TStringField;
    selTabellaTIPORECUPERO: TStringField;
    selTabellaPARTTIME: TStringField;
    selTabellaTIPO_PROPORZIONE: TStringField;
    selTabellaPROPORZIONA_PERSERV: TStringField;
    selTabellaTEMPO_DETERMINATO: TStringField;
    selTabellaCUMULO_FAMILIARI: TStringField;
    selTabellaFRUIZIONE_FAMILIARI: TStringField;
    selTabellaOFFSET_FRUIZIONE: TIntegerField;
    selTabellaALLUNGA_PROVA: TStringField;
    selTabellaREGISTRA_STORICO: TStringField;
    selTabellaUM_INSERIMENTO: TStringField;
    selTabellaNO_SUPERO_COMPETENZE: TStringField;
    selTabellaDescrizione_estesa: TStringField;
    selTabellaFRUIZ_MIN: TStringField;
    selTabellaFRUIZ_ARR: TStringField;
    selTabellaFRUIZ_MAX_DEBITO: TStringField;
    selTabellaFLESSIBILITA_ORARIO: TStringField;
    selTabellaUM_INSERIMENTO_MG: TStringField;
    selTabellaUM_INSERIMENTO_H: TStringField;
    selTabellaCQ_PROGRESSIVO: TStringField;
    selTabellaCQ_FESTIVI: TStringField;
    selTabellaCQ_GGNONLAV: TStringField;
    selTabellaFRUIZCOMPETENZE_ARR: TStringField;
    selTabellaD_VOCEPAGHE: TStringField;
    selTabellaPERC_INAIL: TFloatField;
    selTabellaINTERSEZIONE_TIMBRATURE: TStringField;
    selTabellaPROPORZIONA_ABILITAZIONE: TStringField;
    selTabellaCP_DOMENICHE: TStringField;
    selTabellaCP_PIANIFREPER: TStringField;
    selTabellaCP_FESTGIUSTIF: TStringField;
    selTabellaABBATTE_STRIND: TStringField;
    selTabellaCAUSALE_SUCCESSIVA: TStringField;
    selTabellaD_CAUSALE_SUCCESSIVA: TStringField;
    selTabellaD_CODCAU3: TStringField;
    selTabellaTIMB_PM: TStringField;
    selTabellaCUMULO_TIPO_ORE: TStringField;
    selTabellaCM_DEBSETT: TStringField;
    selTabellaVALIDAZIONE: TStringField;
    selTabellaCODCAU3: TStringField;
    selTabellaVISITA_FISCALE: TStringField;
    selTabellaSCARICOPAGHE_UM_PROP: TStringField;
    selTabellaPERIODO_LUNGO: TStringField;
    selTabellaCOPRI_GGNONLAV: TStringField;
    selTabellaRAPPORTI_UNITI: TStringField;
    selTabellaMATERNITA_OBBL: TStringField;
    selTabellaTIMB_PM_DETRAZ: TStringField;
    selTabellaFRUIZ_MAX: TStringField;
    selTabellaUM_INSERIMENTO_D: TStringField;
    selTabellaCUMULA_RICHIESTE_WEB: TStringField;
    selTabellaUM_SCARICOPAGHE: TStringField;
    selTabellaCUMULO_FAM_GGDOPO: TStringField;
    selTabellaFRUIZIONE_FAM_GGDOPO: TStringField;
    selTabellaGLAVINPS: TStringField;
    selTabellaFRUIZ_MAX_NUM: TIntegerField;
    selTabellaALLARME_FRUIZIONE_CONTINUATIVA: TIntegerField;
    selTabellaDETREPERIB_TOTALE: TStringField;
    selTabellaNO_SUPERO_COMPETENZE_WEB: TStringField;
    selTabellaCOMPETENZE_PERSONALIZZATE: TStringField;
    selTabellaARROT_ORE2GG: TStringField;
    selTabellaSIGLA_CAUSALE: TStringField;
    selTabellaABBATTE_GGSERV_TEMPODET: TStringField;
    selTabellaABBATTE_GGVALUTAZIONE: TStringField;
    selTabellaVARCOMP_FRUIZMMINTERI: TStringField;
    selTabellaVARCOMP_FRUIZMMCONT: TIntegerField;
    selTabellaMMCONT_VARCOMP: TIntegerField;
    selTabellaCOMPINDIV_CONIUGE_ESISTENTE: TIntegerField;
    selTabellaARROT_COMPETENZE: TStringField;
    selTabellaOREGG_MAX_INF6: TStringField;
    selTabellaOREGG_MAX_SUP6: TStringField;
    selTabellaCOPRE_FASCIA_OBB: TStringField;
    selTabellaPERIODO_CUMULO_PERSONALIZZATO: TStringField;
    selTabellaC_CONTASOLARE: TStringField;
    selTabellaPROPPTVGG: TStringField;
    selTabellaCT_MANTIENI_RESIDNEG: TStringField;
    selTabellaITER_ECCGG: TStringField;
    selTabellaFRUIZGG_NEUTRA: TStringField;
    selTabellaITER_IGNORA_FINERAPPORTO: TStringField;
    selTabellaID: TIntegerField;
    selTabellaCAUSALI_CUMULO_L133: TStringField;
    T265VocePaghe2: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BDET265Competenza1Validate(Sender: TField);
    procedure BDET265GMCumuloValidate(Sender: TField);
    procedure BDET265CodCauInizioValidate(Sender: TField);
    procedure BDET265CodRaggrChange(Sender: TField);
    procedure BDET265HMaxUnitarioValidate(Sender: TField);
    procedure BDET265GMaxUnitarioValidate(Sender: TField);
    procedure BDET265HMAssenzaSetText(Sender: TField; const Text: string);
    procedure T265FRUIZ_MINValidate(Sender: TField);
    procedure T265CM_DEBSETTValidate(Sender: TField);
    procedure T265InfluContChange(Sender: TField);
    procedure AfterScroll(DataSet: TDataSet);Override;
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure BeforeDelete(DataSet: TDataSet);Override;
    procedure AfterPost(DataSet: TDataSet);Override;
    procedure OnNewRecord(DataSet: TDataSet);Override;
    procedure selTabellaHMAssenzaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selTabellaHMAssenzaSetText(Sender: TField; const Text: string);
    procedure selTabellaORESETTValidate(Sender: TField);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selTabellaBeforeCancel(DataSet: TDataSet);
    procedure selTabellaCalcFields(DataSet: TDataSet);
  private
    procedure ResultVocePaghe(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    A016MW:TA016FCausAssenzeMW;
    A016StoricoMW:TA016FCausAssenzeStoricoMW;
    ParamStoricizMostraSoloPeriodoCorrente:Boolean;
    procedure PreparaDataSetParamStorici;
    procedure AggiornaCDSParamStoriciz(DataPeriodo:TDateTime);
  end;


implementation

uses WA016UCausAssenze, WA016UCausAssenzeDettFM;

{$R *.dfm}

procedure TWA016FCausAssenzeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  SelTabella.SetVariable('ORDERBY','order by CODICE');
  NonAprireSelTabella:=True;
  ParamStoricizMostraSoloPeriodoCorrente:=False;
  A016MW:=TA016FCausAssenzeMW.Create(Self);
  A016MW.T265:=SelTabella;
  A016StoricoMW:=TA016FCausAssenzeStoricoMW.Create(Self);
  inherited;
  A016MW.InizializzaDataSet;
  SelTabella.Open;
end;

procedure TWA016FCausAssenzeDM.AfterPost(DataSet: TDataSet);
begin
  if (A016MW.T265State = dsInsert) then
    A016StoricoMW.CreaRecordVuoto(selTabella.FieldByName('ID').AsInteger);
  A016MW.T265AfterPost;
  inherited;
end;

procedure TWA016FCausAssenzeDM.AfterScroll(DataSet: TDataSet);
var
  FMDettaglio:TWA016FCausAssenzeDettFM;
begin
  inherited;
  FMDettaglio:=((Self.Owner as TWA016FCausAssenze).WDettaglioFM as TWA016FCausAssenzeDettFM);

  A016MW.T265AfterScroll;
  with A016MW.SelT266 do
  begin
    Close;
    SetVariable('CODICE',SelTabella.FieldByName('CODICE').AsString);
    Open;
  end;

  A016StoricoMW.SvuotaCDSStoriaDati;
  if FMDettaglio <> nil then
    FMDettaglio.cmbDecParStor.Items.Clear;

  if (selTabella.State <> dsInsert) and (not InterfacciaWR102.CopiaInCorso) and
     (selTabella.RecordCount > 0) then
  begin
    PreparaDataSetParamStorici;
    AggiornaCDSParamStoriciz(Parametri.DataLavoro);
  end;

  if FMDettaglio <> nil then
  begin
    with FMDettaglio do
    begin
      //Utente: VENEZIA_IUAV Chiamata: 94562; in caso di nessun elemento della combo deve essere consentito l'elemento custom;
      //Miglioramenti grafici
      //drgpUmScaricoPaghe.Visible:=Not SelTabella.FieldByName('VOCEPAGHE').IsNull;
      C190VisualizzaElemento(JQuery,'grpUmScaricoPaghe',Not SelTabella.FieldByName('VOCEPAGHE').IsNull);

      //if dcmbInfluCont.SelectedValue = 'I' then
      if dcmbInfluCont.Items.ValueFromIndex[dcmbInfluCont.ItemIndex] = 'I' then
        dchkEsclusione.Enabled:=False
      else
        dchkEsclusione.Enabled:=True;
      ImpostaPartTime;
      //Massimo 07/01/2014
      A016MW.Q260.SearchRecord('CODICE',SelTabella.FieldByName('CODRAGGR').AsString,[srFromBeginning]);
      AbilitaTipoPropPtVGG;

      FMDettaglio.AggiornaGridParamStoricizzati;
      chkVistaPeriodoCorr.Enabled:=True;
      drgpValorGior.Enabled:=False;
      dedtHmAssenza.Enabled:=False;
      lblGgAssenza.Enabled:=False;
      btnModificaParStor.Enabled:=not(selTabella.State in [dsEdit,dsInsert]);
     end;
  end;
end;

procedure TWA016FCausAssenzeDM.BDET265CodCauInizioValidate(Sender: TField);
begin
  A016MW.CodCauInizioValidate(Sender);
end;

procedure TWA016FCausAssenzeDM.BDET265CodRaggrChange(Sender: TField);
begin
  if (Self.Owner as TWA016FCausAssenze).WDettaglioFM <> nil then
    with ((Self.Owner as TWA016FCausAssenze).WDettaglioFM as TWA016FCausAssenzeDettFM) do
      CodRaggrChange;
end;

procedure TWA016FCausAssenzeDM.BDET265Competenza1Validate(Sender: TField);
begin
  A016MW.Competenza1Validate(Sender);
end;

procedure TWA016FCausAssenzeDM.BDET265GMaxUnitarioValidate(Sender: TField);
begin
  A016MW.GMaxUnitarioValidate(Sender);
end;

procedure TWA016FCausAssenzeDM.BDET265GMCumuloValidate(Sender: TField);
begin
  A016MW.GMCumuloValidate(Sender);
end;

procedure TWA016FCausAssenzeDM.BDET265HMAssenzaSetText(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TWA016FCausAssenzeDM.BDET265HMaxUnitarioValidate(Sender: TField);
begin
  A016MW.HMaxUnitarioValidate(Sender);
end;

procedure TWA016FCausAssenzeDM.BeforeDelete(DataSet: TDataSet);
begin
  A016MW.T265BeforeDelete;
  inherited;
  A000AggiornaFiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString,'');
end;

procedure TWA016FCausAssenzeDM.BeforePostNoStorico(DataSet: TDataSet);
var VoceOld:String;
begin
  A016MW.T265State:=selTabella.State;
  if not MsgBox.KeyExists('VociPagheControllate') then
  begin
    A016MW.VerificaDatiInseriti;
    //Controllo voci paghe
    if (SelTabella.State = dsInsert) or (SelTabella.FieldByName('VOCEPAGHE').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=SelTabella.FieldByName('VOCEPAGHE').medpOldValue;
    if not A016MW.selControlloVociPaghe.ControlloVociPaghe(VoceOld,SelTabella.FieldByName('VOCEPAGHE').AsString) then
    begin
      MsgBox.WebMessageDlg(A016MW.selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ResultVocePaghe,'VociPagheControllate');
      Abort;
    end;
  end;
  A016MW.VerificaTipoCumulo;
  with ((Self.Owner as TWA016FCausAssenze).WDettaglioFM as TWA016FCausAssenzeDettFM) do
    SelTabella.FieldByName('PartTime').AsString:=IfThen(chkPartTimeO.Checked,'O') + IfThen(chkPartTimeV.Checked,'V') + IfThen(chkPartTimeC.Checked,'C');
  SelTabella.FieldByName('PartTime').AsString:=IfThen(SelTabella.FieldByName('PartTime').AsString = '','N',SelTabella.FieldByName('PartTime').AsString);
  if A016MW.selT266.State in [dsInsert,dsEdit] then
    A016MW.selT266.Post;
  if A016MW.selT259.State in [dsInsert,dsEdit] then
    A016MW.selT259.Post;
  MsgBox.ClearKeys;
  inherited;
end;

procedure TWA016FCausAssenzeDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if ((Self.Owner as TWA016FCausAssenze).WDettaglioFM <> nil) then
    with ((Self.Owner as TWA016FCausAssenze).WDettaglioFM as TWA016FCausAssenzeDettFM) do
      EvtStateChange;
end;

procedure TWA016FCausAssenzeDM.ResultVocePaghe(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    A016MW.selControlloVociPaghe.ValutaInserimentoVocePaghe(SelTabella.FieldByName('VOCEPAGHE').AsString);
    SelTabella.Post;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA016FCausAssenzeDM.selTabellaBeforeCancel(DataSet: TDataSet);
begin
  inherited;
  //SessioneOracle.CancelUpdates([A016MW.selT259]);
  A016MW.selT259.CancelUpdates;
end;

procedure TWA016FCausAssenzeDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('C_CONTASOLARE').AsString:=VarToStr(A016MW.Q260.Lookup('CODICE',selTabella.FieldByName('CODRAGGR').AsString,'CONTASOLARE'));
end;

procedure TWA016FCausAssenzeDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  A016MW.FiltroDizionario(DataSet,Accept);
end;

procedure TWA016FCausAssenzeDM.selTabellaHMAssenzaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  A016MW.HMAssenzaGetText(Sender,Text,DisplayText);
end;

procedure TWA016FCausAssenzeDM.selTabellaHMAssenzaSetText(Sender: TField; const Text: string);
begin
  {$I CampoOra}
end;

procedure TWA016FCausAssenzeDM.OnNewRecord(DataSet: TDataSet);
begin
  A016MW.T265OnNewRecord;
  inherited;
end;

procedure TWA016FCausAssenzeDM.selTabellaORESETTValidate(Sender: TField);
begin
  A016MW.ORESETTValidate(Sender);
end;

procedure TWA016FCausAssenzeDM.T265CM_DEBSETTValidate(Sender: TField);
begin
  A016MW.CM_DEBSETTValidate(Sender);
end;

procedure TWA016FCausAssenzeDM.T265FRUIZ_MINValidate(Sender: TField);
begin
  A016MW.FRUIZ_MINValidate(Sender);
end;

procedure TWA016FCausAssenzeDM.T265InfluContChange(Sender: TField);
begin
  with ((Self.Owner as TWA016FCausAssenze).WDettaglioFM as TWA016FCausAssenzeDettFM) do
  begin
    //if dcmbInfluCont.SelectedValue = 'I' then
    if dcmbInfluCont.Items.ValueFromIndex[dcmbInfluCont.ItemIndex] = 'I' then
    begin
      SelTabella.FieldByName('ESCLUSIONE').AsString:='N';
      dchkEsclusione.Enabled:=False;
    end
    else
      dchkEsclusione.Enabled:=True;
  end;
end;

procedure TWA016FCausAssenzeDM.PreparaDataSetParamStorici;
var
  FMDettaglio:TWA016FCausAssenzeDettFM;
  ElencoDecorrenze:TArray<TDateTime>;
  I,IdCausale:Integer;
begin
  FMDettaglio:=((Self.Owner as TWA016FCausAssenze).WDettaglioFM as TWA016FCausAssenzeDettFM);
  IdCausale:=selTabella.FieldByName('ID').AsInteger;
  A016StoricoMW.Inizializza(IdCausale);
  A016StoricoMW.selT230.Open;

  if (A016StoricoMW.selT230.RecordCount = 0) then
  begin
    // Se per qualche motivo nella tabella dei parametri storicizzati non è presente
    // neanche un record corrispondente a questa causale, ne creiamo uno di default.
    A016StoricoMW.selT230.Close;
    A016StoricoMW.CreaRecordVuoto(IdCausale);
    A016StoricoMW.selT230.Open;
  end;

  // Controlli decorrenza parametri storicizzati
  A016StoricoMW.ElaboraArrayDecorrenze(Parametri.DataLavoro);

  if FMDettaglio <> nil then
  begin
    FMDettaglio.chkVistaPeriodoCorr.Checked:=False;
    // Combo date decorrenza
    ElencoDecorrenze:=A016StoricoMW.Decorrenze;
    for I:=0 to (Length(ElencoDecorrenze) - 1) do
    begin
      FMDettaglio.cmbDecParStor.Items.Add(DateToStr(ElencoDecorrenze[I])); // Uso il FormatSettings globale
    end;
    FMDettaglio.cmbDecParStor.ItemIndex:=A016StoricoMW.IndiceDecorrenzaCorrente;
  end;
end;

procedure TWA016FCausAssenzeDM.AggiornaCDSParamStoriciz(DataPeriodo:TDateTime);
begin
  A016StoricoMW.ElaboraStoriaDati(DataPeriodo);
  A016StoricoMW.ValorizzaCDSStoriaDati;
end;

end.
