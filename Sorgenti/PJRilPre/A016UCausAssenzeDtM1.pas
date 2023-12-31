unit A016UCausAssenzeDtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,
  A016UCausAssenzeMW, A016UCausAssenzeStoricoMW, C180FunzioniGenerali,
  RegistrazioneLog, OracleData, Oracle, Variants, ControlloVociPaghe, StrUtils,
  System.Generics.Collections;

type
  TA016FCausAssenzeDtM1 = class(TDataModule)
    T265: TOracleDataSet;
    T265Codice: TStringField;
    T265Descrizione: TStringField;
    T265CodRaggr: TStringField;
    T265GNonLav: TStringField;
    T265InfluCont: TStringField;
    T265ValorGior: TStringField;
    T265InfluenzaPO: TStringField;
    T265Indpres: TStringField;
    T265EccedLiq: TStringField;
    T265HMAssenza: TDateTimeField;
    T265RaggrStat: TStringField;
    T265Stampa: TStringField;
    T265VocePaghe: TStringField;
    T265GSignific: TStringField;
    T265Fruibile: TStringField;
    T265MaturFerie: TStringField;
    T265AValidAss: TFloatField;
    T265HMaxUnitario: TStringField;
    T265GMaxUnitario: TStringField;
    T265UMisura: TStringField;
    T265Competenza1: TStringField;
    T265Retribuzione1: TFloatField;
    T265Competenza2: TStringField;
    T265Retribuzione2: TFloatField;
    T265Competenza3: TStringField;
    T265Retribuzione3: TFloatField;
    T265Competenza4: TStringField;
    T265Retribuzione4: TFloatField;
    T265Competenza5: TStringField;
    T265Retribuzione5: TFloatField;
    T265Competenza6: TStringField;
    T265Retribuzione6: TFloatField;
    T265TipoCumulo: TStringField;
    T265DurataCumulo: TFloatField;
    T265UMCumulo: TStringField;
    T265GMCumulo: TStringField;
    T265CodCauInizio: TStringField;
    T265CodCau1: TStringField;
    T265Fruizione: TStringField;
    T265DurataFruizione: TFloatField;
    T265UMFruizione: TStringField;
    T265CodCauFruizione: TStringField;
    T265D_Raggruppamento: TStringField;
    T265D_CodCauInizio: TStringField;
    T265D_CodCauFruizione: TStringField;
    T265DETREPERIB: TStringField;
    T265ORESETT: TStringField;
    T265ASSTOLL: TStringField;
    T265CUMULOGLOBALE: TStringField;
    T265CAMPOGLOBALE: TStringField;
    T265RICORSIONE: TStringField;
    T265VALSETIMB: TStringField;
    T265RECUPEROFESTIVO: TStringField;
    T265ESCLUSIONE: TStringField;
    T265TIPORECUPERO: TStringField;
    T265PARTTIME: TStringField;
    T265TIPO_PROPORZIONE: TStringField;
    T265PROPORZIONA_PERSERV: TStringField;
    T265TEMPO_DETERMINATO: TStringField;
    T265CUMULO_FAMILIARI: TStringField;
    T265FRUIZIONE_FAMILIARI: TStringField;
    T265OFFSET_FRUIZIONE: TIntegerField;
    T265ALLUNGA_PROVA: TStringField;
    T265REGISTRA_STORICO: TStringField;
    T265UM_INSERIMENTO: TStringField;
    T265NO_SUPERO_COMPETENZE: TStringField;
    T265DESCRIZIONE_ESTESA: TStringField;
    T265FRUIZ_MIN: TStringField;
    T265FRUIZ_ARR: TStringField;
    T265FRUIZ_MAX_DEBITO: TStringField;
    T265FLESSIBILITA_ORARIO: TStringField;
    T265UM_INSERIMENTO_MG: TStringField;
    T265UM_INSERIMENTO_H: TStringField;
    T265CQ_PROGRESSIVO: TStringField;
    T265CQ_FESTIVI: TStringField;
    T265CQ_GGNONLAV: TStringField;
    T265FRUIZCOMPETENZE_ARR: TStringField;
    T265D_VOCEPAGHE: TStringField;
    T265PERC_INAIL: TFloatField;
    T265CODCAU2: TStringField;
    T265INTERSEZIONE_TIMBRATURE: TStringField;
    T265PROPORZIONA_ABILITAZIONE: TStringField;
    T265CP_DOMENICHE: TStringField;
    T265CP_PIANIFREPER: TStringField;
    T265CP_FESTGIUSTIF: TStringField;
    T265ABBATTE_STRIND: TStringField;
    T265CAUSALE_SUCCESSIVA: TStringField;
    T265D_CODCAU3: TStringField;
    T265TIMB_PM: TStringField;
    T265CUMULO_TIPO_ORE: TStringField;
    T265CM_DEBSETT: TStringField;
    T265VALIDAZIONE: TStringField;
    T265CODCAU3: TStringField;
    T265D_CAUSALE_SUCCESSIVA2: TStringField;
    T265VISITA_FISCALE: TStringField;
    T265SCARICOPAGHE_UM_PROP: TStringField;
    T265PERIODO_LUNGO: TStringField;
    T265COPRI_GGNONLAV: TStringField;
    T265RAPPORTI_UNITI: TStringField;
    T265MATERNITA_OBBL: TStringField;
    T265TIMB_PM_DETRAZ: TStringField;
    T265FRUIZ_MAX: TStringField;
    T265UM_INSERIMENTO_D: TStringField;
    T265CUMULA_RICHIESTE_WEB: TStringField;
    T265UM_SCARICOPAGHE: TStringField;
    T265FRUIZIONE_FAM_GGDOPO: TStringField;
    T265CUMULO_FAM_GGDOPO: TStringField;
    T265GLAVINPS: TStringField;
    T265FRUIZ_MAX_NUM: TIntegerField;
    T265ALLARME_FRUIZIONE_CONTINUATIVA: TIntegerField;
    T265DETREPERIB_TOTALE: TStringField;
    T265NO_SUPERO_COMPETENZE_WEB: TStringField;
    T265COMPETENZE_PERSONALIZZATE: TStringField;
    T265ARROT_ORE2GG: TStringField;
    T265SIGLA_CAUSALE: TStringField;
    T265ABBATTE_GGSERV_TEMPODET: TStringField;
    T265ABBATTE_GGVALUTAZIONE: TStringField;
    T265VARCOMP_FRUIZMMINTERI: TStringField;
    T265VARCOMP_FRUIZMMCONT: TIntegerField;
    T265MMCONT_VARCOMP: TIntegerField;
    T265COMPINDIV_CONIUGE_ESISTENTE: TIntegerField;
    T265ARROT_COMPETENZE: TStringField;
    T265VOCEPAGHE2: TStringField;
    T265VOCEPAGHE3: TStringField;
    T265VOCEPAGHE4: TStringField;
    T265VOCEPAGHE5: TStringField;
    T265VOCEPAGHE6: TStringField;
    T265OREGG_MAX_INF6: TStringField;
    T265OREGG_MAX_SUP6: TStringField;
    T265COPRE_FASCIA_OBB: TStringField;
    T265PERIODO_CUMULO_PERSONALIZZATO: TStringField;
    T265PROPPTVGG: TStringField;
    T265CT_MANTIENI_RESIDNEG: TStringField;
    T265ITER_ECCGG: TStringField;
    T265FRUIZGG_NEUTRA: TStringField;
    T265ITER_IGNORA_FINERAPPORTO: TStringField;
    T265ID: TIntegerField;
    T265FRUIZ_MIN_COMP: TStringField;
    T265CAUSALI_CUMULO_L133: TStringField;
    procedure T265AfterScroll(DataSet: TDataSet);
    procedure T265HMAssenzaGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure BDET265Competenza1Validate(Sender: TField);
    procedure BDET265GMCumuloValidate(Sender: TField);
    procedure BDET265CodRaggrChange(Sender: TField);
    procedure BDET265CodCauInizioValidate(Sender: TField);
    procedure BDET265HMaxUnitarioValidate(Sender: TField);
    procedure BDET265GMaxUnitarioValidate(Sender: TField);
    procedure T265BeforePost(DataSet: TDataSet);
    procedure A016FCausAssenzeDtM1Create(Sender: TObject);
    procedure A016FCausAssenzeDtM1Destroy(Sender: TObject);
    procedure BDET265ORESETTValidate(Sender: TField);
    procedure T265BeforeDelete(DataSet: TDataSet);
    procedure T265AfterDelete(DataSet: TDataSet);
    procedure T265AfterPost(DataSet: TDataSet);
    procedure T265FRUIZ_MINValidate(Sender: TField);
    procedure T265CM_DEBSETTValidate(Sender: TField);
    procedure T265InfluContChange(Sender: TField);
    procedure T265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure T265NewRecord(DataSet: TDataSet);
    procedure T265BeforeCancel(DataSet: TDataSet);
  private
    procedure VisualizzaTab(TabIndex:Integer);
  public
    A016MW:TA016FCausAssenzeMW;
    A016StoricoMW:TA016FCausAssenzeStoricoMW;
    procedure RefreshCodiceVoce(const Cod: String = '');
    procedure PreparaDataSetParamStorici;
    procedure SvuotaGrigliaDatiStoriciz;
    procedure AggiornaGrigliaDatiStoriciz(DataPeriodo:TDateTime);
  end;

var
  A016FCausAssenzeDtM1: TA016FCausAssenzeDtM1;

implementation

uses A016UCausAssenze;

{$R *.DFM}

procedure TA016FCausAssenzeDtM1.A016FCausAssenzeDtM1Create(
  Sender: TObject);
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
  A016StoricoMW:=TA016FCausAssenzeStoricoMW.Create(Self);
  A016MW:=TA016FCausAssenzeMW.Create(Self);
  A016MW.T265:=T265;
  A016MW.VisualizzaTab:=VisualizzaTab;
  A016MW.InizializzaDataSet;
  T265.Open;

end;

procedure TA016FCausAssenzeDtM1.BDET265CodRaggrChange(Sender: TField);
var AnnoS:string;
{Abilita/disabilita i controlli a seconda del Conteggio Anno Solare}
begin
  A016MW.Q265B.Filtered:=False;
  A016MW.Q265B.Filtered:=True;
  AnnoS:=A016MW.Q260.FieldByName('ContASolare').AsString;
  with A016FCausAssenze do
  begin
    EUMisura.Enabled:=AnnoS = 'N';
    R180AbilitaOggetti(grpFasce,(AnnoS = 'N') and (not (R180CarattereDef(T265.FieldByName('TipoCumulo').AsString,1,'H') in ['H','N','P','Q','R','S','T'])));
    dchkCompetenzePersonalizzate.Enabled:=T265.FieldByName('TipoCumulo').AsString <> 'H';
    dchkArrotCompetenze.Enabled:=T265.FieldByName('TipoCumulo').AsString <> 'H';
    drdgRapportiUniti.Enabled:=(AnnoS = 'N') and (T265.FieldByName('TipoCumulo').AsString <> 'H');
    EHMaxUnitario.Enabled:=(AnnoS = 'S') or (T265.FieldByName('UMisura').AsString = 'O');
    EGMaxUnitario.Enabled:=(AnnoS = 'S') or (T265.FieldByName('UMisura').AsString = 'G');
    ETipoCumulo.Enabled:=AnnoS = 'N';
    drgpArrotOre2GG.Enabled:=(T265.FieldByName('UMisura').AsString = 'O') or (AnnoS = 'S');
    if T265.State in [dsEdit,dsInsert] then
    begin
      if not EHMaxUnitario.Enabled then T265.FieldByName('HMaxUnitario').Clear;
      if not EGMaxUnitario.Enabled then T265.FieldByName('GMaxUnitario').Clear;
      if AnnoS = 'S' then T265.FieldByName('TipoCumulo').AsString:='A';
    end;
  end;
end;

procedure TA016FCausAssenzeDtM1.BDET265Competenza1Validate(Sender: TField);
begin
  A016MW.Competenza1Validate(Sender);
end;

procedure TA016FCausAssenzeDtM1.BDET265HMaxUnitarioValidate(Sender: TField);
begin
  A016MW.HMaxUnitarioValidate(Sender);
end;

procedure TA016FCausAssenzeDtM1.BDET265ORESETTValidate(Sender: TField);
begin
  A016MW.ORESETTValidate(Sender);
end;

procedure TA016FCausAssenzeDtM1.BDET265GMaxUnitarioValidate(Sender: TField);
begin
  A016MW.GMaxUnitarioValidate(Sender);
end;

procedure TA016FCausAssenzeDtM1.BDET265GMCumuloValidate(Sender: TField);
begin
  A016MW.GMCumuloValidate(Sender);
end;

procedure TA016FCausAssenzeDtM1.BDET265CodCauInizioValidate(Sender: TField);
begin
  A016MW.CodCauInizioValidate(Sender);
end;

procedure TA016FCausAssenzeDtM1.T265BeforePost(DataSet: TDataSet);
var VoceOld:String;
  i: Integer;
begin
  A016MW.T265State:=T265.State;
  A016MW.VerificaDatiInseriti;
  //Controllo voci paghe
  if (T265.State = dsInsert) or (T265.FieldByName('VOCEPAGHE').medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=T265.FieldByName('VOCEPAGHE').medpOldValue;

  if not A016MW.selControlloVociPaghe.ControlloVociPaghe(VoceOld,T265.FieldByName('VOCEPAGHE').AsString) then
  begin
    if R180MessageBox(A016MW.selControlloVociPaghe.MessaggioLog,'DOMANDA') = mrNo then
      Abort
    else
      A016MW.selControlloVociPaghe.ValutaInserimentoVocePaghe(T265.FieldByName('VOCEPAGHE').AsString);
  end;
  if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) and (T265.FieldByName('RAGGRSTAT').AsString = 'C') then
  begin
    for i:=2 to 6 do
    begin
      T265.FieldByName('VOCEPAGHE'+ IntToStr(i)).AsString:=Copy(T265.FieldByName('VOCEPAGHE').AsString,1,9) + IntToStr(i);
      A016MW.selControlloVociPaghe.ValutaInserimentoVocePaghe(T265.FieldByName('VOCEPAGHE'+ IntToStr(i)).AsString);
    end;
  end;
  A016MW.VerificaTipoCumulo;
  with A016FCausassenze do
    T265PartTime.AsString:=IfThen(chkPartTimeO.Checked,'O') + IfThen(chkPartTimeV.Checked,'V') + IfThen(chkPartTimeC.Checked,'C');
  T265PartTime.AsString:=IfThen(T265PartTime.AsString = '','N',T265PartTime.AsString);

  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I','T265_CAUASSENZE',Copy(Name,1,4),T265,True);
    dsEdit:RegistraLog.SettaProprieta('M','T265_CAUASSENZE',Copy(Name,1,4),T265,True);
  end;

  if A016MW.selT266.State in [dsInsert,dsEdit] then
    A016MW.selT266.Post;
  if A016MW.selT259.State in [dsInsert,dsEdit] then
    A016MW.selT259.Post;
end;

procedure TA016FCausAssenzeDtM1.T265CM_DEBSETTValidate(Sender: TField);
begin
  A016MW.CM_DEBSETTValidate(Sender);
end;

procedure TA016FCausAssenzeDtM1.A016FCausAssenzeDtM1Destroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TDataSet then
      (Self.Components[i] as TDataSet).Close;
end;

procedure TA016FCausAssenzeDtM1.T265BeforeCancel(DataSet: TDataSet);
begin
  //SessioneOracle.CancelUpdates([A016MW.selT259]);
  A016MW.selT259.CancelUpdates;
end;

procedure TA016FCausAssenzeDtM1.T265BeforeDelete(DataSet: TDataSet);
begin
  A016MW.T265BeforeDelete;
  RegistraLog.SettaProprieta('C','T265_CAUASSENZE',Copy(Name,1,4),T265,True);
  A000AggiornaFiltroDizionario('CAUSALI ASSENZA',DataSet.FieldByName('CODICE').AsString,'');
end;

procedure TA016FCausAssenzeDtM1.T265AfterDelete(DataSet: TDataSet);
begin
  RegistraLog.RegistraOperazione;
end;

procedure TA016FCausAssenzeDtM1.T265AfterPost(DataSet: TDataSet);
begin
  if (A016MW.T265State = dsInsert) then
    A016StoricoMW.CreaRecordVuoto(T265.FieldByName('ID').AsInteger);
  A016MW.T265AfterPost;
  RegistraLog.RegistraOperazione;
end;

procedure TA016FCausAssenzeDtM1.T265FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  A016MW.FiltroDizionario(DataSet,Accept);
end;

procedure TA016FCausAssenzeDtM1.T265FRUIZ_MINValidate(Sender: TField);
begin
  if Sender.IsNull then
    exit;
  R180OraValidate(Sender.AsString);
end;

procedure TA016FCausAssenzeDtM1.T265HMAssenzaGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('hh:nn',Sender.AsDateTime);
end;

procedure TA016FCausAssenzeDtM1.T265InfluContChange(Sender: TField);
begin
  with A016FCausAssenze do
  begin
    if DBComboBox1.Text = 'I' then
    begin
      DBCheckBox8.Field.AsString:='N';
      DBCheckBox8.Enabled:=False;
    end
    else
      DBCheckBox8.Enabled:=True;
  end;
end;

procedure TA016FCausAssenzeDtM1.T265NewRecord(DataSet: TDataSet);
begin
  A016MW.T265OnNewRecord;
end;

procedure TA016FCausAssenzeDtM1.VisualizzaTab(TabIndex: Integer);
begin
  //2 -> A016FCausassenze.PageControl1.ActivePage:=A016FCausassenze.TabSheet2;
  //4 -> A016FCausassenze.PageControl1.ActivePage:=A016FCausassenze.TabSheet4;
  A016FCausassenze.PageControl1.ActivePage:=A016FCausassenze.PageControl1.Pages[TabIndex];
end;

procedure TA016FCausAssenzeDtM1.T265AfterScroll(DataSet: TDataSet);
begin
  A016MW.T265AfterScroll;
  with A016MW.selT266 do
  begin
    Close;
    SetVariable('CODICE',T265.FieldByName('CODICE').AsString);
    Open;
  end;
  with A016FCausAssenze do
  begin
    drgpUmScaricoPaghe.Visible:=Not T265.FieldByName('VOCEPAGHE').IsNull;
    if DBComboBox1.Text = 'I' then
      DBCheckBox8.Enabled:=False
    else
      DBCheckBox8.Enabled:=True;
    ImpostaPartTime;
  end;
  RefreshCodiceVoce;
  A016FCausAssenze.cmbDecParStor.Items.Clear;
  SvuotaGrigliaDatiStoriciz;
  if (T265.State <> dsInsert) and (not A016FCausAssenze.CopiaInCorso) and
     (T265.RecordCount > 0) then
  begin
    PreparaDataSetParamStorici;
    AggiornaGrigliaDatiStoriciz(Parametri.DataLavoro);
  end;
end;

procedure TA016FCausAssenzeDtM1.RefreshCodiceVoce;
begin
  if A016MW.selP200.SearchRecord('COD_VOCE',T265.FieldByName('VOCEPAGHE').AsString,[srFromBeginning]) then
    A016FCausAssenze.LblDescVoce.Caption:=A016MW.selP200.FieldByName('DESCRIZIONE').AsString
  else
    A016FCausAssenze.LblDescVoce.Caption:='';
end;

procedure TA016FCausAssenzeDtM1.PreparaDataSetParamStorici;
var
  ElencoDecorrenze:TArray<TDateTime>;
  I,IdCausale:Integer;
begin
  IdCausale:=T265.FieldByName('ID').AsInteger;
  A016StoricoMW.Inizializza(IdCausale);
  A016StoricoMW.selT230.Open;

  if A016StoricoMW.selT230.RecordCount = 0 then
  begin
    // Se per qualche motivo nella tabella dei parametri storicizzati non � presente
    // neanche un record corrispondente a questa causale, ne creiamo uno di default.
    A016StoricoMW.selT230.Close;
    A016StoricoMW.CreaRecordVuoto(IdCausale);
    A016StoricoMW.selT230.Open;
  end;

  // Controlli decorrenza parametri storicizzati
  A016StoricoMW.ElaboraArrayDecorrenze(Parametri.DataLavoro);

  A016FCausAssenze.chkVistaPeriodoCorr.Checked:=False;
  A016FCausAssenze.ToggleControlliSchedaParStor(False);
  if A016StoricoMW.selT230.RecordCount > 0 then
  begin
    // Combo date decorrenza
    ElencoDecorrenze:=A016StoricoMW.Decorrenze;
    for I:=0 to (Length(ElencoDecorrenze) - 1) do
    begin
      A016FCausAssenze.cmbDecParStor.Items.Add(DateToStr(ElencoDecorrenze[I])); // Uso il FormatSettings globale
    end;
    A016FCausAssenze.cmbDecParStor.ItemIndex:=A016StoricoMW.IndiceDecorrenzaCorrente;
  end;
  A016FCausAssenze.ToggleControlliSchedaParStor(True);
end;

procedure TA016FCausAssenzeDtM1.SvuotaGrigliaDatiStoriciz;
var
  I:Integer;
begin
  // Svuoto la tabella
  for I:=1 to (A016FCausAssenze.grdParamStoriciz.RowCount - 1) do
  begin
    A016FCausAssenze.grdParamStoriciz.Cells[0,I]:='';
    A016FCausAssenze.grdParamStoriciz.Cells[1,I]:='';
    A016FCausAssenze.grdParamStoriciz.Cells[2,I]:='';
    A016FCausAssenze.grdParamStoriciz.Cells[3,I]:='';
  end;
  A016FCausAssenze.grdParamStoriciz.FixedRows:=1;
  A016FCausAssenze.grdParamStoriciz.RowCount:=2;
end;

// Questo metodo va necessariamente eseguito dal DM, dato che il DM � sempre in grado
// di accedere al form principale, mentre il form principale alla prima apertura
// non � ancora in grado di accedere al DM (� gi� instanziato, ma il richiamo avviene prima
// che l'indirizzo sia salvato nella variabile globale A016FCausAssenzeDtM1).
procedure TA016FCausAssenzeDtM1.AggiornaGrigliaDatiStoriciz(DataPeriodo:TDateTime);
var
  StoriaDati:TObjectList<TA016ElementoListaStorico>;
  Elemento:TA016ElementoListaStorico;
  I:Integer;
begin
  A016StoricoMW.ElaboraStoriaDati(DataPeriodo);
  StoriaDati:=A016StoricoMW.StoriaDati;
  if StoriaDati <> nil then
  begin
    A016FCausAssenze.grdParamStoriciz.RowCount:=StoriaDati.Count + 1;
    for I:=0 to (StoriaDati.Count - 1) do
    begin
      Elemento:=StoriaDati.Items[I];
      A016FCausAssenze.grdParamStoriciz.Cells[0,I+1]:=Elemento.Descrizione;
      A016FCausAssenze.grdParamStoriciz.Cells[1,I+1]:=DateToStr(Elemento.Decorrenza);
      A016FCausAssenze.grdParamStoriciz.Cells[2,I+1]:=DateToStr(Elemento.FineDecorrenza);
      A016FCausAssenze.grdParamStoriciz.Cells[3,I+1]:=Elemento.DescValoreDato;
    end;
  end;
end;

end.
