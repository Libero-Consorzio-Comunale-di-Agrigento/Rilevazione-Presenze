unit WP430UAnagraficoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, WR102UGestTabella,
  P430UAnagraficoMW, A000UInterfaccia, medpIWMessageDlg, Datasnap.DBClient, A000UCostanti,
  A000UMessaggi, C180FunzioniGenerali;

type
  TWP430FAnagraficoDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaCOD_CONTRATTO: TStringField;
    selTabellaCOD_POSIZIONE_ECONOMICA: TStringField;
    selTabellaCOD_PARTTIME: TStringField;
    selTabellaNO_CEDOLINO_NORMALE: TStringField;
    selTabellaCOD_PAGAMENTO: TStringField;
    selTabellaCOD_VALUTA_STAMPA: TStringField;
    selTabellaDETRAZ_LAVDIP: TStringField;
    selTabellaREDDITO_DETRAZ_LAVDIP: TFloatField;
    selTabellaPERC_IRPEF_MANUALE: TFloatField;
    selTabellaTREDICESIMA: TStringField;
    selTabellaCOD_BANCA: TStringField;
    selTabellaCONTO_CORRENTE: TStringField;
    selTabellaCOD_STATOCIVILE: TStringField;
    selTabellaCOD_NAZIONALITA: TStringField;
    selTabellaREDDITO_DETRAZ_CONIUGE: TFloatField;
    selTabellaCOD_TABELLAANF: TStringField;
    selTabellaCOMPONENTI_ANF: TFloatField;
    selTabellaREDDITO_ANF: TFloatField;
    selTabellaVARIAZIONE_IMPORTO_ANF: TFloatField;
    selTabellaREDDITO_DETRAZ_FIGLI_ALTRI: TFloatField;
    selTabellaCOD_PARAMETRISTIPENDI: TStringField;
    selTabellaCONGUAGLIO: TStringField;
    selTabellaPERC_IRPEF_TFR: TFloatField;
    selTabellaTIPO_CALCOLO_IMPORTO13A: TStringField;
    selTabellaCOD_CODICEINPS: TStringField;
    selTabellaCOD_CODICEINAIL: TStringField;
    selTabellaSTATO_DIPENDENTE: TStringField;
    selTabellaTIPO_DIPENDENTE: TStringField;
    selTabellaCOD_CAUSALEIRPEF: TStringField;
    selTabellaCOD_TIPOASSOGGETTAMENTO: TStringField;
    selTabellaDETRAZ_REDDITI_MIN_INDET: TStringField;
    selTabellaDETRAZ_REDDITI_MIN_DET: TStringField;
    selTabellaCREDITO_FAM_NUMEROSE: TStringField;
    selTabellaCOD_REGIONE_IRPEF: TStringField;
    selTabellaCOD_COMUNE_IRPEF: TStringField;
    selTabellaCOD_CUDINPDAPCAUSACESS: TStringField;
    selTabellaCOD_INQUADRINPDAP: TStringField;
    selTabellaCOD_INQUADRINPS: TStringField;
    selTabellaLIVELLO_INPS: TStringField;
    selTabellaPROGRESSIVO_EREDE_DI: TFloatField;
    selTabellaPERC_EREDITA: TFloatField;
    selTabellaCOD_CATEGPARTICOLARE: TStringField;
    selTabellaCOD_QUALIFICA_INAIL: TStringField;
    selTabellaCOD_COMUNE_INAIL: TStringField;
    selTabellaCOD_CAUSALELA: TStringField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaPERC_IRPEF_EXTRA27: TFloatField;
    selTabellaPERC_IRPEF_MASSIMA_EXTRA27: TStringField;
    selTabellaPROFESSIONE_ONAOSI: TStringField;
    selTabellaD_CONTRATTO: TStringField;
    selTabellaD_POSIZIONE_ECONOMICA: TStringField;
    selTabellaD_TABELLAANF: TStringField;
    selTabellaD_PARAMETRISTIPENDI: TStringField;
    selTabellaD_CODICEINPS: TStringField;
    selTabellaD_CODICEINAIL: TStringField;
    selTabellaD_TIPOASSOGGETTAMENTO: TStringField;
    selTabellaD_NOMINATIVO_EREDE: TStringField;
    selTabellaCIN_EUROPA: TStringField;
    selTabellaCIN_ITALIA: TStringField;
    selTabellaCOD_EMENSTIPOASS: TStringField;
    selTabellaCOD_EMENSTIPOCESS: TStringField;
    selTabellaCOD_TIPORAPP_COCOCO: TStringField;
    selTabellaCOD_TIPOATT_COCOCO: TStringField;
    selTabellaCOD_ALTRAASS_COCOCO: TStringField;
    selTabellaCOD_ONAOSITIPOASS: TStringField;
    selTabellaCOD_ONAOSITIPOCESS: TStringField;
    selTabellaNUMERO_ISCRIZIONE_ALBO: TStringField;
    selTabellaPROVINCIA_ALBO: TStringField;
    selTabellaDATA_ISCRIZIONE_ALBO: TDateTimeField;
    selTabellaCOD_ONAOSITIPOPAG: TStringField;
    selTabellaREDDITO_ALTRO_ANF: TFloatField;
    selTabellaINABILE_ANF: TStringField;
    selTabellaTIPO_MASSIMALE_CONTR: TStringField;
    selTabellaMATR_PENSIONISTICA: TStringField;
    selTabellaRETRIB_MESE_PREC: TStringField;
    selTabellaCOD_VALUTA_BASE: TStringField;
    selTabellaCOD_FPC: TStringField;
    selTabellaD_FPC: TStringField;
    selTabellaD_VALUTA: TStringField;
    selTabellaD_COD_VALUTA_BASE: TStringField;
    selTabellaD_PARTTIME: TStringField;
    selT030Elenco: TOracleDataSet;
    selTabellaD_BANCA: TStringField;
    selTabellaD_PAGAMENTO: TStringField;
    selTabellaD_STATOCIVILE: TStringField;
    selTabellaD_NAZIONALITA: TStringField;
    selTabellaD_CAUSALEIRPEF: TStringField;
    selTabellaD_REGIONE_IRPEF: TStringField;
    selTabellaDATA_DOMANDA_FPC: TDateTimeField;
    selTabellaPERC_TOT_DIP_FPC: TFloatField;
    selTabellaDATA_SOSP_CESS_FPC: TDateTimeField;
    selTabellaCOD_INPDAPMOTIVOSOSP_FPC: TStringField;
    selTabellaCOD_INPDAPTIPOCESS_FPC: TStringField;
    selTabellaPERC_DETRAZ_FAM_NUMEROSE: TStringField;
    selTabellaCOD_CATEG_CONVENZ: TStringField;
    selTabellaALTRA_AMM: TStringField;
    selTabellaCOD_INPDAPTIPOLS_ALTRA_AMM: TStringField;
    selTabellaCOD_FISCALE_ALTRA_AMM: TStringField;
    selTabellaCODICE_INPDAP_ALTRA_AMM: TStringField;
    selTabellaBONUS_RIDUZ_CUNEO_FISC: TStringField;
    selTabellaCOD_NAZIONALITAESTERE: TStringField;
    selTabellaREDDITO_DETRAZ_REDDITI_MIN: TFloatField;
    selTabellaCOD_DEDUZIONEIRPEF: TStringField;
    selTabellaDETRAZ_PROGR_IMP: TStringField;
    selTabellaREDDITO_DETRAZ_PROGR_IMP: TFloatField;
    selTabellaSCADENZA_ANF: TDateTimeField;
    selTabellaD_INQUADRINPS: TStringField;
    selTabellaD_EMENSTIPOASS: TStringField;
    selTabellaD_EMENSTIPOCESS: TStringField;
    selTabellaD_TIPORAPP_COCOCO: TStringField;
    selTabellaD_TIPOATT_COCOCO: TStringField;
    selTabellaD_ALTRAASS_COCOCO: TStringField;
    selTabellaD_INQUADRINPDAP: TStringField;
    selTabellaD_CUDINPDAPCAUSACESS: TStringField;
    selTabellaD_CATEG_CONVENZ: TStringField;
    selTabellaD_INPDAPTIPOLS_ALTRA_AMM: TStringField;
    selTabellaD_QUALIFICA_INAIL: TStringField;
    selTabellaD_COMUNE_IRPEF: TStringField;
    selTabellaD_COMUNE_INAIL: TStringField;
    selTabellaD_CATEGPARTICOLARE: TStringField;
    selTabellaD_CAUSALELA: TStringField;
    selTabellaD_ONAOSITIPOPAG: TStringField;
    selTabellaD_ONAOSITIPOASS: TStringField;
    selTabellaD_INPDAPMOTIVOSOSP_FPC: TStringField;
    selTabellaD_INPDAPTIPOCESS_FPC: TStringField;
    selTabellaD_ONAOSITIPOCESS: TStringField;
    cdsStoriaDato: TClientDataSet;
    cdsStoriaDatoDATO: TStringField;
    cdsStoriaDatoDATADEC: TStringField;
    cdsStoriaDatoDATAFINE: TStringField;
    cdsStoriaDatoVALORE: TStringField;
    cdsStoriaDatoDESCRIZIONE: TStringField;
    cdsStoriaDatoKEY: TStringField;
    cdsrStoriaDato: TDataSource;
    cdsStoriaDatoRIGACOLORATA: TBooleanField;
    selTabellaD_TIPO_DIPENDENTE: TStringField;
    selT030ElencoCOGNOME: TStringField;
    selT030ElencoNOME: TStringField;
    selT030ElencoMATRICOLA: TStringField;
    selT030ElencoNOMINATIVO: TStringField;
    selT030ElencoPROGRESSIVO: TFloatField;
    selTabellaCOD_ENTE_APPARTENENZA: TStringField;
    selTabellaD_ENTE_APPARTENENZA: TStringField;
    selTabellaLAV_PRIMA_OCCUP_FPC: TStringField;
    selTabellaIBAN_ESTERO: TStringField;
    selTabellaIBAN_ESTERO_CITTA: TStringField;
    selTabellaCOD_EMENSQUALPROF: TStringField;
    selTabellaPERC_IRPEF_REGIMI_SPECIALI: TFloatField;
    selTabellaDATA_INF_SIL_ASS_FPC: TDateTimeField;
    selTabellaTIPO_ADESIONE_FPC: TStringField;
    selTabellaCOD_STATO_EST_REG_SPEC: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure selTabellaCONTO_CORRENTESetText(Sender: TField;
      const Text: string);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure AfterCancel(DataSet: TDataSet); override;
  private
    procedure resultConfermaPost(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
    { Private declarations }
  public
    P430FAnagraficoMW: TP430FAnagraficoMW;
    function QueryLookupCampo(Campo: String): TOracleDataSet;
    function getNomeCampoCodice(ods: TOracleDataset): String;
  end;

implementation

uses
  WP430UAnagrafico,WP430UAnagraficoDettFM;

{$R *.dfm}

procedure TWP430FAnagraficoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY PROGRESSIVO, DECORRENZA');
  NonAprireSelTabella:=True;
  inherited;
  selT030Elenco.SetVariable('ORDERBY','ORDER BY COGNOME,NOME,MATRICOLA');
  P430FAnagraficoMW:=TP430FAnagraficoMW.Create(Self);
  P430FAnagraficoMW.selP430_Funzioni:=selTabella;
  selTabella.FieldByName('D_PARTTIME').LookupDataSet:=P430FAnagraficoMW.Q040;
  selTabella.FieldByName('D_PAGAMENTO').LookupDataSet:=P430FAnagraficoMW.Q130;
  selTabella.FieldByName('D_STATOCIVILE').LookupDataSet:=P430FAnagraficoMW.Q020;
  selTabella.FieldByName('D_NAZIONALITA').LookupDataSet:=P430FAnagraficoMW.Q120;
  selTabella.FieldByName('D_CAUSALEIRPEF').LookupDataSet:=P430FAnagraficoMW.Q080;
  selTabella.FieldByName('D_REGIONE_IRPEF').LookupDataSet:=P430FAnagraficoMW.selT482;
  selTabella.FieldByName('D_COMUNE_IRPEF').LookupDataSet:=P430FAnagraficoMW.selT480S;
  selTabella.FieldByName('D_COMUNE_INAIL').LookupDataSet:=P430FAnagraficoMW.t480_comuni;
  selTabella.FieldByName('D_ENTE_APPARTENENZA').LookupDataSet:=P430FAnagraficoMW.Q015;

  selTabella.FieldByName('SCADENZA_ANF').OnGetText:=P430FAnagraficoMW.Q430SCADENZA_ANFGetText;
  selTabella.FieldByName('SCADENZA_ANF').OnSetText:=P430FAnagraficoMW.Q430SCADENZA_ANFSetText;

  selTabella.Open;
  cdsStoriaDato.CreateDataSet;
end;

procedure TWP430FAnagraficoDM.selTabellaCalcFields(DataSet: TDataSet);
var
  i: Integer;
begin
  inherited;
  P430FAnagraficoMW.P430CalcField;
  for i:=Low(D_TipoDipendente) to High(D_TipoDipendente) do
  begin
    if D_TipoDipendente[i].value = selTabella.FieldByName('TIPO_DIPENDENTE').AsString then
      selTabella.FieldByName('D_TIPO_DIPENDENTE').AsString:=D_TipoDipendente[i].Item;
  end;
end;

procedure TWP430FAnagraficoDM.selTabellaCONTO_CORRENTESetText(Sender: TField;
  const Text: string);
begin
  inherited;
  selTabella.FieldByName('CONTO_CORRENTE').AsString:=P430FAnagraficoMW.NormalizzaCC(Text);
end;

function TWP430FAnagraficoDM.QueryLookupCampo(Campo: String): TOracleDataSet;
begin
  Result:=nil;
  if UpperCase(campo) = 'COD_CONTRATTO' then
    Result:=P430FAnagraficoMW.Q210
  else if UpperCase(campo) = 'COD_PARAMETRISTIPENDI' then
    Result:=P430FAnagraficoMW.Q212
  else if UpperCase(campo) = 'COD_TIPOASSOGGETTAMENTO' then
    Result:=P430FAnagraficoMW.Q240
  else if UpperCase(campo) = 'COD_POSIZIONE_ECONOMICA' then
    Result:=P430FAnagraficoMW.Q220
  else if UpperCase(campo) = 'COD_PARTTIME' then
    Result:=P430FAnagraficoMW.Q040
  else if UpperCase(campo) = 'COD_PAGAMENTO' then
    Result:=P430FAnagraficoMW.Q130
  else if UpperCase(campo) = 'COD_VALUTA_BASE' then
    Result:=P430FAnagraficoMW.Q030
  else if UpperCase(campo) = 'COD_VALUTA_STAMPA' then
    Result:=P430FAnagraficoMW.Q030
  else if UpperCase(campo) = 'COD_STATOCIVILE' then
    Result:=P430FAnagraficoMW.Q020
  else if UpperCase(campo) = 'COD_NAZIONALITA' then
    Result:=P430FAnagraficoMW.Q120
  else if UpperCase(campo) = 'COD_CAUSALEIRPEF' then
    Result:=P430FAnagraficoMW.Q080
  else if UpperCase(campo) = 'COD_REGIONE_IRPEF' then
    Result:=P430FAnagraficoMW.selT482
  else if UpperCase(campo) = 'COD_TABELLAANF' then
    Result:=P430FAnagraficoMW.Q236
  else if UpperCase(campo) = 'COD_CODICEINPS' then
    Result:=P430FAnagraficoMW.Q090
  else if UpperCase(campo) = 'COD_INQUADRINPS' then
    Result:=P430FAnagraficoMW.Q096
  else if UpperCase(campo) = 'COD_EMENSTIPOASS' then
    Result:=P430FAnagraficoMW.selP004TipoAss
  else if UpperCase(campo) = 'COD_EMENSTIPOCESS' then
    Result:=P430FAnagraficoMW.selP004TipoCess
  else if UpperCase(campo) = 'COD_TIPORAPP_COCOCO' then
    Result:=P430FAnagraficoMW.selP004TipoRapp
  else if UpperCase(campo) = 'COD_TIPOATT_COCOCO' then
    Result:=P430FAnagraficoMW.selP004TipoAtt
  else if UpperCase(campo) = 'COD_ALTRAASS_COCOCO' then
    Result:=P430FAnagraficoMW.selP004AltreAssic
  else if UpperCase(campo) = 'COD_INQUADRINPDAP' then
    Result:=P430FAnagraficoMW.Q094
  else if UpperCase(campo) = 'COD_CUDINPDAPCAUSACESS' then
    Result:=P430FAnagraficoMW.selP004CausaCess
  else if UpperCase(campo) = 'COD_CATEG_CONVENZ' then
    Result:=P430FAnagraficoMW.selP004CategConvenz
  else if UpperCase(campo) = 'COD_INPDAPTIPOLS_ALTRA_AMM' then
    Result:=P430FAnagraficoMW.selP004TipoServAltraAmm
  else if UpperCase(campo) = 'COD_CODICEINAIL' then
    Result:=P430FAnagraficoMW.Q092
  else if UpperCase(campo) = 'COD_QUALIFICA_INAIL' then
    Result:=P430FAnagraficoMW.selP004QualifInail
  else if UpperCase(campo) = 'COD_CATEGPARTICOLARE' then
    Result:=P430FAnagraficoMW.selP004CatPart770
  else if UpperCase(campo) = 'COD_CAUSALELA' then
    Result:=P430FAnagraficoMW.selP004CausPag770
  else if UpperCase(campo) = 'COD_ONAOSITIPOPAG' then
    Result:=P430FAnagraficoMW.selP004TipoPagOnaosi
  else if UpperCase(campo) = 'COD_ONAOSITIPOASS' then
    Result:=P430FAnagraficoMW.selP004TipoAssOnaosi
  else if UpperCase(campo) = 'COD_ONAOSITIPOCESS' then
    Result:=P430FAnagraficoMW.selP004TipoCessOnaosi
  else if UpperCase(campo) = 'COD_FPC' then
    Result:=P430FAnagraficoMW.selP026
  else if UpperCase(campo) = 'COD_INPDAPMOTIVOSOSP_FPC' then
    Result:=P430FAnagraficoMW.selP004SospFPC
  else if UpperCase(campo) = 'COD_INPDAPTIPOCESS_FPC' then
    Result:=P430FAnagraficoMW.selP004CessFPC
  else if UpperCase(campo) = 'COD_ENTE_APPARTENENZA' then
    Result:=P430FAnagraficoMW.Q015;
end;

procedure TWP430FAnagraficoDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;

  // rimuove il lock sul record di T030
  P430FAnagraficoMW.UnlockRecordT030Rollback;
  A000SessioneWEB.RipristinaTimeOut;
end;

procedure TWP430FAnagraficoDM.AfterDelete(DataSet: TDataSet);
var
  MsgInfo,MsgErr: string;
begin
  P430FAnagraficoMW.AllineaDati(MsgInfo, MsgErr);
  if MsgInfo <> '' then
    Msgbox.AddMessage(MsgInfo,mtInformation);
  if MsgErr <> '' then
    Msgbox.AddMessage(MsgErr,mtError);
  if P430FAnagraficoMW.selP430_Funzioni.RecordCount > 0 then //Nel BeforeDelete viene impedita la cancellazione dell'unico record in caso di presenza cedolini
    if not P430FAnagraficoMW.VerificaCedAntePrimoStoricoStip then
      Msgbox.AddMessage(A000MSG_P430_ERR_CED_ANTE_PRIMO_STORICO,mtInformation);

  inherited;

  // rimuove il lock sul record di T030
  P430FAnagraficoMW.UnlockRecordT030Rollback;
  A000SessioneWEB.RipristinaTimeOut;

  // visualizzazione pulsanti nuovo e modifica in funzione della presenza di record sul progressivo corrente
  with (Self.Owner as TWP430FAnagrafico) do
  begin
    actModifica.Visible:=selTabella.RecordCount > 0;
    actNuovo.Visible:=selTabella.RecordCount = 0;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;

  MsgBox.ShowMessages;
end;

procedure TWP430FAnagraficoDM.AfterPost(DataSet: TDataSet);
var
  MsgInfo,MsgErr: string;
begin
  P430FAnagraficoMW.AllineaDati(MsgInfo, MsgErr);
  if MsgInfo <> '' then
    Msgbox.AddMessage(MsgInfo,mtInformation);
  if MsgErr <> '' then
    Msgbox.AddMessage(MsgErr,mtError);

  inherited;

  // rimuove il lock sul record di T030
  P430FAnagraficoMW.UnlockRecordT030Rollback;
  A000SessioneWEB.RipristinaTimeOut;

  // visualizzazione pulsanti nuovo e modifica in funzione della presenza di record sul progressivo corrente
  with (Self.Owner as TWP430FAnagrafico) do
  begin
    actModifica.Visible:=selTabella.RecordCount > 0;
    actNuovo.Visible:=selTabella.RecordCount = 0;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;

  MsgBox.ShowMessages;
end;

procedure TWP430FAnagraficoDM.BeforeInsert(DataSet: TDataSet);
begin
  // tenta di acquisire il lock sul record di T030
  if not P430FAnagraficoMW.TryLockRecordT030(selTabella.FieldByName('PROGRESSIVO').AsInteger) then
  begin
    // raise Exception.Create(A000TraduzioneStringhe(A000MSG_P430_ERR_SCHEDA_LOCK)); // non ottiene il comportamento desiderato
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_P430_ERR_SCHEDA_LOCK),ERRORE);
    Abort;
  end;
  A000SessioneWEB.RiduciTimeOut;

  inherited;
end;

procedure TWP430FAnagraficoDM.BeforeEdit(DataSet: TDataSet);
begin
  // tenta di acquisire il lock sul record di T030
  if not P430FAnagraficoMW.TryLockRecordT030(selTabella.FieldByName('PROGRESSIVO').AsInteger) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_P430_ERR_SCHEDA_LOCK));
  A000SessioneWEB.RiduciTimeOut;

  inherited;
end;

procedure TWP430FAnagraficoDM.BeforeDelete(DataSet: TDataSet);
begin
  // tenta di acquisire il lock sul record di T030
  if not P430FAnagraficoMW.TryLockRecordT030(selTabella.FieldByName('PROGRESSIVO').AsInteger) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_P430_ERR_SCHEDA_LOCK));
  A000SessioneWEB.RiduciTimeOut;

  inherited;

  P430FAnagraficoMW.P430BeforeDelete;
end;

procedure TWP430FAnagraficoDM.BeforePost(DataSet: TDataSet);
var
  Msg: String;
  dettFM:TWP430FAnagraficoDettFM;
  lstErrori: TStringList;
  s: String;
begin
  inherited;
  dettFM:=((Self.Owner as TWP430FAnagrafico).WDettaglioFM as TWP430FAnagraficoDettFM);
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    Msg:=P430FAnagraficoMW.MessaggioVerificaDecorrenzaAnte(InterfacciaWR102.StoricizzazioneInCorso);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultConfermaPost,'PUNTO_1');
      Abort;
    end;
  end;

  P430FAnagraficoMW.VerificaDecorrenzaInizioMese(InterfacciaWR102.StoricizzazioneInCorso);
  selTabella.FieldByName('PROFESSIONE_ONAOSI').AsString:=Trim(selTabella.FieldByName('PROFESSIONE_ONAOSI').AsString);
  try
    P430FAnagraficoMW.VerificaDetrazRedditiMin;
  Except
    on E: Exception do
    begin
      dettFM.grdTabDetail.activeTab:=dettFM.WP430DetrazioniRG;
      MsgBox.ClearKeys;
      raise;
    end;
  end;

  try
    P430FAnagraficoMW.VerificaCausaleIRPEF;
    P430FAnagraficoMW.VerificaPercIrpefRegimiSpeciali;
    P430FAnagraficoMW.VerificaCodStatoEsteroRegimiSpeciali;
  Except
    on E: Exception do
    begin
      dettFM.grdTabDetail.activeTab:=dettFM.WP430ParametriCalcoloRG;
      MsgBox.ClearKeys;
      raise;
    end;
  end;

  try
    P430FAnagraficoMW.VerificaTipoAdesioneFPC;
    P430FAnagraficoMW.VerificaDataInfSilAssFPC;
    P430FAnagraficoMW.VerificaCodFPC;
    P430FAnagraficoMW.VerificaDataDomandaFPC;
    P430FAnagraficoMW.VerificaLavPrimaOccupFPC;
    P430FAnagraficoMW.VerificaPercTotDipFPC;
    P430FAnagraficoMW.VerificaMotivoSosp;
  Except
    on E: Exception do
    begin
      dettFM.grdTabDetail.activeTab:=dettFM.WP430FPCRG;
      MsgBox.ClearKeys;
      raise;
    end;
  end;

  try
    P430FAnagraficoMW.VerificaContrattoVoci;
    P430FAnagraficoMW.VerificaAreaContrat;
    P430FAnagraficoMW.VerificaPercEredita;
    P430FAnagraficoMW.VerificaModuloCP;
    P430FAnagraficoMW.VerificaTipoRetribuzione;
  Except
    on E: Exception do
    begin
      dettFM.grdTabDetail.activeTab:=dettFM.WP430PosizioneRG;
      MsgBox.ClearKeys;
      raise;
    end;
  end;

  try
    P430FAnagraficoMW.VerificaTipoServAltraAmm;
    P430FAnagraficoMW.VerificaCodFiscaleAltraAmm;
    P430FAnagraficoMW.VerificaCodInpdapAltraAmm;
  Except
    on E: Exception do
    begin
      dettFM.grdTabDetail.activeTab:=dettFM.WP430AltraAmmRG;
      MsgBox.ClearKeys;
      raise;
    end;
  end;

  try
    P430FAnagraficoMW.VerificaCodBanca;
    P430FAnagraficoMW.VerificaCittaEstera;
  Except
    on E: Exception do
    begin
      dettFM.grdTabDetail.activeTab:=dettFM.WP430DatiAggiuntiviRG;
      MsgBox.ClearKeys;
      raise;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    Msg:=P430FAnagraficoMW.MessaggioIban(dettFM.edtIban.Text);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultConfermaPost,'PUNTO_2');
      Abort;
    end;
  end;
  if not MsgBox.KeyExists('PUNTO_3') then
  begin
    Msg:=P430FAnagraficoMW.MessaggioErede;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultConfermaPost,'PUNTO_3');
      Abort;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_4') then
  begin
    Msg:=P430FAnagraficoMW.MessaggioInquadrInpdap;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],resultConfermaPost,'PUNTO_4');
      Abort;
    end;
  end;
  try
    P430FAnagraficoMW.VerificaCodInps;
  except
    MsgBox.ClearKeys;
    raise;
  end;
  lstErrori:=TStringList.Create();
  try
    P430FAnagraficoMW.ControlliNonBloccanti(lstErrori);
    for s in lstErrori do
    begin
      Msgbox.AddMessage(s,mtInformation);
    end;
  finally
    FreeAndNil(lstErrori);
  end;
end;

procedure TWP430FAnagraficoDM.dsrTabellaStateChange(Sender: TObject);
var Browse:Boolean;
begin
  inherited;
  with TWR102FGestTabella(Owner) do
  begin
    Browse:=not (selTabella.State in [dsInsert,dsEdit]);
    actNuovo.Enabled:=actNuovo.Enabled and (Parametri.InserimentoMatricoleP430 = 'S');
    actElimina.Enabled:=actElimina.Enabled and (Parametri.EliminaStoriciP430 = 'S');
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    if dEdtDataDecorrenza <> nil then
    begin
      AggiornaToolBarStorico(not Browse, not Browse, not Browse, False, False, imgNuovaStoricizzazione.Enabled and (Parametri.StoricizzazioneP430 = 'S'));
      dEdtDataDecorrenza.Enabled:=dEdtDataDecorrenza.Enabled and not ((selTabella.State = dsEdit) and not InterfacciaWR102.StoricizzazioneInCorso and (Parametri.ModificaDecorrenzaP430 = 'N'));
    end;
  end;
end;

procedure TWP430FAnagraficoDM.resultConfermaPost(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
    begin
      selTabella.Post;
    end;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

function TWP430FAnagraficoDM.getNomeCampoCodice(ods: TOracleDataset): String;
begin
  with P430FAnagraficoMW do
  begin
    Result:='';
    if ods = q210 then
      Result:='COD_CONTRATTO'
    else if ods = q212 then
      Result:='COD_PARAMETRISTIPENDI'
    else if ods = Q240 then
      Result:='COD_TIPOASSOGGETTAMENTO'
    else if ods = Q220 then
      Result:='COD_POSIZIONE_ECONOMICA'
    else if ods = Q040 then
      Result:='COD_PARTTIME'
    else if ods = Q130 then
      Result:='COD_PAGAMENTO'
    else if ods = Q030 then
      Result:='COD_VALUTA'
    else if ods = Q020 then
      Result:='COD_STATOCIVILE'
    else if ods = Q120 then
      Result:='COD_NAZIONALITA'
    else if ods = Q080 then
      Result:='COD_CAUSALEIRPEF'
    else if ods = selT482 then
      Result:='COD_REGIONE'
    else if ods = Q236 then
      Result:='COD_TABELLAANF'
    else if ods = Q090 then
      Result:='COD_CODICEINPS'
    else if ods = Q096 then
      Result:='COD_INQUADRINPS'
    else if ods = selP004TipoAss then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004TipoCess then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004TipoRapp then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004TipoAtt then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004AltreAssic then
      Result:='COD_CODICITABANNUALI'
    else if ods = Q094 then
      Result:='COD_INQUADRINPDAP'
    else if ods = selP004CausaCess then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004CategConvenz then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004TipoServAltraAmm then
      Result:='COD_CODICITABANNUALI'
    else if ods = Q092 then
      Result:='COD_CODICEINAIL'
    else if ods = selP004QualifInail then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004CatPart770 then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004CausPag770 then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004TipoPagOnaosi then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004TipoAssOnaosi then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004TipoCessOnaosi then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP026 then
      Result:='COD_FPC'
    else if ods = selP004SospFPC then
      Result:='COD_CODICITABANNUALI'
    else if ods = selP004CessFPC then
      Result:='COD_CODICITABANNUALI'
    else if ods = Q015 then
      Result:='COD_ENTE_APPARTENENZA';
  end;
end;

procedure TWP430FAnagraficoDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P430FAnagraficoMW);
  inherited;
end;

procedure TWP430FAnagraficoDM.OnNewRecord(DataSet: TDataSet);
begin
  P430FAnagraficoMW.P430NewRecord(InterfacciaWR102.StoricizzazioneInCorso);
  inherited;
end;

end.
