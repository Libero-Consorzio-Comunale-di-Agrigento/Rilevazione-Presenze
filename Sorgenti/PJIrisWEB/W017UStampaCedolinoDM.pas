unit W017UStampaCedolinoDM;

interface

uses
  A000UCostanti, A000UInterfaccia, A000UMessaggi, W000UMessaggi,
  C180FunzioniGenerali,
  P999UGenerale, USelT004,
  Data.DB, Oracle, OracleData,
  RpSystem, RvDirectDataView, RpRave, RvClass, RpRenderPDF, RpConDS,
  RpCon, RvData, RvCsStd, RvCsData, RpDefine,
  System.SysUtils, System.Classes, Datasnap.DBClient, Winapi.Windows,
  System.Variants, System.StrUtils, System.IOUtils;

type
  TCambi = record
    Valuta1:string;
    Valuta2:string;
    Cambio:real;
  end;

  TW017FStampaCedolinoDM = class(TDataModule)
    selP500: TOracleDataSet;
    selP441: TOracleDataSet;
    selP441DATA_CEDOLINO: TStringField;
    selP441DATA_RETRIBUZIONE: TStringField;
    selP441TIPO_CEDOLINO: TStringField;
    selP441DATA_EMISSIONE: TDateTimeField;
    selP441DATA_CONSEGNA: TDateTimeField;
    selP441ID_CEDOLINO: TFloatField;
    selP442Cumulo: TOracleDataSet;
    selP442NonCumulo: TOracleDataSet;
    selP442: TOracleDataSet;
    cdsRiepilogo: TClientDataSet;
    cdsNote: TClientDataSet;
    cdsDettaglio: TClientDataSet;
    selDatiPag: TOracleDataSet;
    selV430: TOracleDataSet;
    selP442A: TOracleDataSet;
    selP441_Note: TOracleDataSet;
    selAnagrafeApp: TOracleDataSet;
    updP441: TOracleQuery;
    selP441LBL_DATA_RETRIBUZIONE: TStringField;
    selP441LBL_DATA_CEDOLINO: TStringField;
    selP441LBL_IMPORTO: TStringField;
    selP441NOME_FILEPDF: TStringField;
    selP441DESCRIZIONE_FILEPDF: TStringField;
    procedure selP441FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DataModuleCreate(Sender: TObject);
  private
    DataRetribuzione: TDateTime;
    DataCedolino: TDateTime;
    DataCumuloMax: TDateTime;
    TitoloStampa,CittaStampa,CodFiscaleStampa,NcSedeServizio,NcUnitaOperativa,NcQualifica,NcDataInizio,NcPartitaIva: String;
    // componenti per stampa
    rvSystem:TRVSystem;
    rvDWRiepilogo,rvDWDettaglio,rvDWNote:TRaveDataView;
    rvProject:TRVProject;
    rvPage:TRaveComponent;
    rvRenderPDF:TRvRenderPDF;
    connRiepilogo,connDettaglio,connNote:TRVDataSetConnection;
    procedure CaricaClientDataset(PCumuloVociArretrate: Boolean);
    procedure CreaClientDataset;
    procedure EsecuzioneStampa(const PNomeFilePdf: String; var RErrMsg: String);
    function  EsisteFilePDFCedolino(DataSet: TDataSet): String; // da W001DtM
    function GetRagioneSociale: String; // da R012    - rimosso il parametro Progressivo
  public
    selAnagrafeW: TOracleDataset;
    // critical section per stampa
    W017CSStampa: TMedpCriticalSection;
    // path dei modelli di stampa .rav
    RaveProjectPath: String;
    // file temporaneo per copia file cedolino (nel caso in cui Parametri.WEBCedoliniFilePDF = 'S')
    TempPDFPath: String;
    AzioneRichiesta: TAzioneCedolino;
    procedure GeneraCedolinoPDF(PMatricola: String; PCumuloVociArretrate: Boolean; PStampaOrigine: Boolean; var RNomeFilePdf: String; var RAzioneCedolino: TAzioneCedolino; var RMsgErrore: String);
    procedure ImpostaDataConsegna(PIdCedolino: Integer);        // da W017
  end;

implementation

{$R *.dfm}

procedure TW017FStampaCedolinoDM.DataModuleCreate(Sender: TObject);
var
  i: Integer;
begin
  // associa i componenti alla sessione oracle
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;
end;

procedure TW017FStampaCedolinoDM.GeneraCedolinoPDF(PMatricola: String; PCumuloVociArretrate: Boolean;
  PStampaOrigine: Boolean; var RNomeFilePdf: String; var RAzioneCedolino: TAzioneCedolino; var RMsgErrore: String);
var
  SQLText,TipoCedolino,PathPDF:String;
  procedure CalcoloCedolino;
  begin
    DataCumuloMax:=DataRetribuzione;
    // utilizza un dataset simile a selAnagrafeW
    if selAnagrafeW.FieldByName('P430RETRIB_MESE_PREC').AsString = 'S' then
      DataCumuloMax:=R180InizioMese(DataCumuloMax)-1;
    selP442.SetVariable('Data_Cumulo_Max',DataCumuloMax);
    selP442.Close;
    selP442.SetVariable('Progressivo',selAnagrafeW.FieldByName('Progressivo').AsInteger);
    selP442.Open;
    if selP442.RecordCount > 0 then
      CaricaClientDataSet(PCumuloVociArretrate);
  end;

  procedure CedolinoPDF(var RNomeFilePdf: String);
  var
    NomeFileOrig, NomeFileTemp: String;
  begin
    // file del cedolino originale
    NomeFileOrig:=PathPDF + '\' + FormatDateTime('yyyymm',DataCedolino) + '\' + selP441.FieldByName('ID_CEDOLINO').AsString + '.pdf';

    // determina il nome del file temporaneo su cui copiare l'originale
    NomeFileTemp:=PMatricola + '_' + TipoCedolino + '_' + FormatDateTime('yyyymm',DataCedolino);
    if DataCedolino <> DataRetribuzione then
      NomeFileTemp:=NomeFileTemp + '_' + FormatDateTime('yyyymm',DataRetribuzione);
    if TipoCedolino = 'EX' then
      NomeFileTemp:=NomeFileTemp + '_' + FormatDateTime('yyyymmdd',selP441.FieldByName('DATA_EMISSIONE').AsDateTime);
    NomeFileTemp:=NomeFileTemp + '.pdf';

    // determina il path e il nome del file pdf da generare
    NomeFileTemp:=TPath.Combine(TempPDFPath,NomeFileTemp);

    // esegue copia del file
    CopyFile(PChar(NomeFileOrig),PChar(NomeFileTemp),False);
    //Decifratura PDF
    if Parametri.CampiRiferimento.C34_CriptaSingoliCedolini = 'S' then
      R180FileEncryptAES(False,NomeFileTemp,'',P441Passphrase,HASHTYPE_Sha256);

    // restituisce in un parametro il path del file da visualizzare
    RNomeFilePdf:=NomeFileTemp;
  end;

begin
  RMsgErrore:='';

  if selP441.RecordCount = 0 then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_W017_MSG_NO_CEDOLINO_DISP));
  if selP441.Active then
  begin
    if UpperCase(selP441.FieldByName('TIPO_CEDOLINO').AsString) = 'NORMALE' then
      TipoCedolino:='NR'
    else if UpperCase(selP441.FieldByName('TIPO_CEDOLINO').AsString) = 'TREDICESIMA' then
      TipoCedolino:='TR'
    else
      TipoCedolino:='EX';
  end;
  try
    DataRetribuzione:=R180FineMese(StrToDate('01/' + selP441.FieldByName('DATA_RETRIBUZIONE').AsString));
  except
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_W017_ERR_DATA_RETR_ERRATA));
  end;
  try
    DataCedolino:=R180FineMese(StrToDate('01/' + selP441.FieldByName('DATA_CEDOLINO').AsString));
  except
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_W017_ERR_DATACEDOLINO_ERRATA));
  end;

  // inizializza azione cedolino
  RAzioneCedolino:=acNessuna;

  SQLText:=selAnagrafeW.SQL.Text;

  try
    // estrae informazioni dalla tabella P500 per l'anno della data retribuzione
    selP500.Close;
    selP500.SetVariable('Anno', strtoint(FormatDateTime('yyyy',DataRetribuzione)));
    selP500.Open;
    if selP500.SearchRecord('COD_AZIENDA_BASE',T440AZIENDA_BASE,[srFromBeginning]) then
    begin
      NcSedeServizio:=selP500.FieldByName('SEDE_SERVIZIO_CED').AsString;
      NcUnitaOperativa:=selP500.FieldByName('UNITA_OP_CED').AsString;
      NcQualifica:=selP500.FieldByName('QUALIFICA_CED').AsString;
      NcDataInizio:=selP500.FieldByName('DATA_INIZIO_CED').AsString;
      NcPartitaIva:=selP500.FieldByName('PIVA_CED').AsString;
      PathPDF:=selP500.FieldByName('PATH_FILEPDF_CED').AsString
    end
    else
    begin
      NcSedeServizio:='';
      NcUnitaOperativa:='';
      NcQualifica:='';
      NcDataInizio:='';
      NcPartitaIva:='';
      PathPDF:='';
    end;

    if Parametri.WEBCedoliniFilePDF <> 'S' then
    begin
      // generazione dei cedolini
      selP442.Close;
      selP442.ClearVariables;
      selP442.SQL.Clear;
      if PCumuloVociArretrate then
        selP442.SQL.Add(selP442Cumulo.SQL.Text)
      else
        selP442.SQL.Add(selP442NonCumulo.SQL.Text);
      selP442.SetVariable('Progressivo',0);
      selP442.SetVariable('Data_Cedolino',DataCedolino);
      selP442.SetVariable('Data_Retribuzione',DataRetribuzione);
      selP442.SetVariable('Data_Emissione',selP441.FieldByName('DATA_EMISSIONE').AsString);
      //La data di emissione viene controllato solo per il cedolino Extra 27
      selP442.SetVariable('ControllaData','N');
      selP442.SetVariable('Tipo_Cedolino',TipoCedolino);
      if TipoCedolino = 'EX' then
        selP442.SetVariable('ControllaData','S');
      if PStampaOrigine then
      begin
        selP442.SetVariable('CODICIDESCRIZIONI', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '') || RPAD(P442.ORIGINE,1,'' '') || '' '' || P442.ECCEZIONI) VOCE,' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE) DESCRIZIONE');
        selP442.SetVariable('CODICIDESCRIZIONIGRUPPO', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '') || RPAD(P442.ORIGINE,1,'' '') || '' '' || P442.ECCEZIONI),' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE)');
      end
      else
      begin
        selP442.SetVariable('CODICIDESCRIZIONI', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '')) VOCE,' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE) DESCRIZIONE');
        selP442.SetVariable('CODICIDESCRIZIONIGRUPPO', 'RTRIM(RPAD(P200.COD_VOCE_STAMPA,11,'' '')),' + 'DECODE(P442.DESCRIZIONE_VOCE_SOST,NULL,P200.DESCRIZIONE_STAMPA,P442.DESCRIZIONE_VOCE_SOST)||DECODE(P442.RATE_RESIDUE,NULL,'''','' - r.r.''||P442.RATE_RESIDUE)');
      end;
      CreaClientDataSet;
    end;

    selAnagrafeW.SetVariable('DATALAVORO',DataRetribuzione);
    selAnagrafeW.Close;
    selAnagrafeW.Open;
    //Posizionamento sulla matricola correntemente selezionata
    if selAnagrafeW.SearchRecord('MATRICOLA',PMatricola,[srFromBeginning]) then
    begin
      if Parametri.WEBCedoliniFilePDF = 'S' then
      begin
        // il file del cedolino è già presente
        CedolinoPDF(RNomeFilePdf);
      end
      else
      begin
        CalcoloCedolino;
        try
          EsecuzioneStampa(RNomeFilePdf,RMsgErrore);
        except
          on E:Exception do
          begin
            RMsgErrore:=E.Message;
          end;
        end;
        cdsRiepilogo.Close;
        cdsDettaglio.Close;
      end;

      // aggiornamento data consegna
      // PRE:
      //   RAzioneCedolino = acNessuna
      // nel caso di webservice il file di configurazione non è previsto
      {$IFNDEF WEBSVC}
      if Pos(INI_PAR_NO_PDF,W000ParConfig.ParametriAvanzati) = 0 then
      {$ENDIF WEBSVC}
      begin
        if (selAnagrafeW.FieldByName('Progressivo').AsInteger = Parametri.ProgressivoOper) and
           (selP441.FieldByName('DATA_CONSEGNA').AsString = '') then
        begin
          if Parametri.WebRichiestaConsegnaCed = 'S' then
          begin
            RAzioneCedolino:=acRichiediImpostazioneConsegna;
          end
          else
          begin
            RAzioneCedolino:=acImpostaConsegna;
            ImpostaDataConsegna(selP441.FieldByName('ID_CEDOLINO').AsInteger);
          end;
        end;
      end;
    end
    else
    begin
      RMsgErrore:=A000TraduzioneStringhe(A000MSG_MSG_ANAGRA_NON_DISPONIBILE);
      Abort;
    end;
  finally
    selAnagrafeW.CloseAll;
    selAnagrafeW.SQL.Text:=SQLText;
    selAnagrafeW.SetVariable('DATALAVORO',R180FineMese(Parametri.DataLavoro));
    selAnagrafeW.Open;
    selAnagrafeW.SearchRecord('MATRICOLA',PMatricola,[srFromBeginning]);
  end;
end;

procedure TW017FStampaCedolinoDM.CreaClientDataset;
begin
  with cdsRiepilogo do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Data',ftDate,0,False);
    FieldDefs.Add('Mese_Cedolino',ftString,20,False);
    FieldDefs.Add('Tipo_Cedolino',ftString,20,False);
    FieldDefs.Add('Matricola',ftString,8,False);
    FieldDefs.Add('Cognome_Nome',ftString,100,False);
    FieldDefs.Add('Data_Nascita',ftString,20,False);
    FieldDefs.Add('Sede_Servizio',ftString,100,False);
    FieldDefs.Add('Unita_Operativa',ftString,100,False);
    FieldDefs.Add('Inizio_Rapporto',ftString,20,False);
    FieldDefs.Add('Fine_Rapporto',ftString,20,False);
    FieldDefs.Add('Pos_Economica',ftString,100,False);
    FieldDefs.Add('UN_UID',ftString,10,False);
    FieldDefs.Add('Part_Time',ftString,10,False);
    FieldDefs.Add('Qualifica',ftString,100,False);
    FieldDefs.Add('Cod_Fiscale',ftString,16,False);
    FieldDefs.Add('Partita_Iva',ftString,11,False);
    FieldDefs.Add('PosizioneINAIL',ftString,15,False);
    FieldDefs.Add('Cambi_Valute',ftString,100,False);
    FieldDefs.Add('Modalita_Pagamento',ftString,200,False);
    FieldDefs.Add('Cod_Valuta_Stampa',ftString,10,False);
    FieldDefs.Add('Note',ftString,200,False);
    FieldDefs.Add('Tot_Competenze',ftString,20,False);
    FieldDefs.Add('Tot_Ritenute',ftString,20,False);
    FieldDefs.Add('Imponibile_Lordo',ftString,20,False);
    FieldDefs.Add('Ritenuta',ftString,20,False);
    FieldDefs.Add('Deduzioni',ftString,20,False);
    FieldDefs.Add('Detrazioni',ftString,20,False);
    FieldDefs.Add('Arrotondamento',ftString,20,False);
    FieldDefs.Add('Netto',ftString,20,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
  end;
  with cdsDettaglio do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Cod_Voce',ftString,100,False);
    FieldDefs.Add('Desc_Voce',ftString,100,False);
    FieldDefs.Add('Cod_Valuta_Iniz',ftString,20,False);
    FieldDefs.Add('Importo_Valuta_Iniz',ftString,20,False);
    FieldDefs.Add('Quantita',ftString,20,False);
    FieldDefs.Add('DatoBase',ftString,20,False);
    FieldDefs.Add('Ritenute',ftString,20,False);
    FieldDefs.Add('Competenze',ftString,20,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
  end;
  with cdsNote do
  begin
    Close;
    FieldDefs.Clear;
    FieldDefs.Add('Chiave',ftString,20,False);
    FieldDefs.Add('Note',ftString,236,False);
    IndexDefs.Clear;
    CreateDataSet;
    LogChanges:=False;
  end;
end;

procedure TW017FStampaCedolinoDM.CaricaClientDataset(PCumuloVociArretrate: Boolean);
var
  Chiave,DescVoce,sDep,S:String;
  bPv_CalcolaProgressivi,bCambioTrovato:boolean;
  nPv_Detrazioni:Real;
  nPv_TotCompetenze,nPv_TotTrattenute,nPv_Netto:Real;
  nPv_DeduzioneNoTax:Real;
  i:Integer;
  QueryCambio: TQueryCambio;
  sPv_Cambi:array of TCambi;
const
  MaxCar = 40;

  function FormattaVoce(ImportoColonna:string; Importo:Real): string;
  begin
    Result:='';
    if ImportoColonna = 'R' then
      Result:=Trim(Format('%*.*n',[10,2,Importo]))
    else if ImportoColonna = 'E' then
      Result:=Trim(Format('e%*.*n',[9,2,Importo]))
    else if ImportoColonna = 'C' then
      Result:=Trim(Format('%*.*n',[10,2,Importo]))
    else if ImportoColonna = 'D' then
      Result:=Trim(Format('%*.*n',[10,2,Importo]));
  end;
begin
  QueryCambio:=TQueryCambio.Create(nil);
  QueryCambio.Session:=SessioneOracle;

  Chiave:=selAnagrafeW.FieldByName('PROGRESSIVO').AsString;

  //!!!!! Chiedere a Dario se è giusto inizializzarli per ogni dipendente
  nPv_Detrazioni:=0;
  nPv_DeduzioneNoTax:=0;
  bPv_CalcolaProgressivi:=True;
  //nPv_TotCompetenze:=0;
  //nPv_TotTrattenute:=0;
  //nPv_Netto:=0;
  SetLength(sPv_Cambi,0);
  //Popolo le modalità di pagamento
  selV430.Close;
  selV430.ClearVariables;
  selV430.SetVariable('Progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  selV430.SetVariable('DataRetrib', DataCumuloMax);
  selV430.SetVariable('DataCedolino', DataCedolino);
  //SACCO INIZIO: provo ad assegnare l'unità operativa
  //selV430.SetVariable('unioperselect', ', i501a.descrizione as descrunioper, i501b.descrizione as descrsedelav');
  //selV430.SetVariable('uniopertabella', ', i501centro_costo i501a');
  //selV430.SetVariable('unioperwhere', 'and i501a.codice(+) = t430.centro_costo');
  //selV430.SetVariable('uniopertabella', ', i501uo_azien i501a, i501sede_lav i501b');
  //selV430.SetVariable('unioperwhere', 'and i501a.codice(+) = t430.uo_azien and i501b.codice(+) = t430.sede_lav');
  //SACCO FINE: provo ad assegnare l'unità operativa
  if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then
    selV430.SetVariable('dati_ONU', ',t430un_uid');
  S:='';
  if Trim(NcSedeServizio) <> '' then
    S:=S + ',' + Trim(NcSedeServizio) + ' descrsedelav';
  if Trim(NcUnitaOperativa) <> '' then
    S:=S + ',' + Trim(NcUnitaOperativa) + ' descrunioper';
  if Trim(NcQualifica) <> '' then
    S:=S + ',' + Trim(NcQualifica) + ' descrqualifica';
  if Trim(NcDataInizio) <> '' then
    S:=S + ',' + Trim(NcDataInizio) + ' descrdatainizio';
  if Trim(NcPartitaIva) <> '' then
    S:=S + ',' + Trim(NcPartitaIva) + ' descrpartitaiva';
  selV430.SetVariable('dati_P500', S);
  try
    selV430.Open;
  except
    raise exception.create('Dato anagrafico non trovato! Contattare l''amministratore del sistema!');
  end;
  //I dati di pagamento devono sempre essere presi alla data del cedolino
  R180SetVariable(selDatiPag,'Progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  R180SetVariable(selDatiPag,'Data_Cedolino',DataCedolino);
  selDatiPag.Open;
  cdsRiepilogo.Append;
  cdsRiepilogo.FieldByName('Chiave').AsString:=Chiave;
  cdsRiepilogo.FieldByName('Matricola').AsString:=selAnagrafeW.FieldByName('MATRICOLA').AsString;
  cdsRiepilogo.FieldByName('Mese_Cedolino').AsString:=UpperCase(FormatDateTime('mmmm yyyy',DataRetribuzione));
  cdsRiepilogo.FieldByName('Tipo_Cedolino').AsString:=selP441.FieldByName('TIPO_CEDOLINO').AsString;
  cdsRiepilogo.FieldByName('Cognome_Nome').AsString:=selAnagrafeW.FieldByName('COGNOME').AsString + ' ' + SelAnagrafeW.FieldByName('NOME').AsString;
  cdsRiepilogo.FieldByName('Data_Nascita').AsString:=selAnagrafeW.FieldByName('DataNas').AsString;

  if selV430.RecordCount > 0 then
  begin
    if selV430.FindField('descrsedelav') <> nil then
      cdsRiepilogo.FieldByName('Sede_Servizio').AsString:=selV430.FieldByName('descrsedelav').AsString;
    if selV430.FindField('descrunioper') <> nil then
      cdsRiepilogo.FieldByName('Unita_Operativa').AsString:=selV430.FieldByName('descrunioper').AsString;
    if selV430.FindField('descrdatainizio') <> nil then
      cdsRiepilogo.FieldByName('Inizio_Rapporto').AsString:=selV430.FieldByName('descrdatainizio').AsString;
    cdsRiepilogo.FieldByName('Fine_Rapporto').AsString:=selV430.FieldByName('T430Fine').AsString;
    cdsRiepilogo.FieldByName('Pos_Economica').AsString:=selV430.fieldbyname('P430cod_posizione_economica').AsString;
    if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then
      cdsRiepilogo.FieldByName('UN_UID').AsString:=selV430.fieldbyname('t430un_uid').AsString;
    if (selV430.fieldbyname('p430perc_parttime').AsInteger <> 0) and (selV430.fieldbyname('p430perc_parttime').AsInteger <> 100) then
      cdsRiepilogo.FieldByName('Part_Time').AsString:=Format('%3.2f',[selV430.fieldbyname('p430perc_parttime').AsFloat]) + ' %';
    if selV430.FindField('descrqualifica') <> nil then
      cdsRiepilogo.FieldByName('Qualifica').AsString:=selV430.FieldByName('descrqualifica').AsString;
    cdsRiepilogo.FieldByName('Cod_Fiscale').AsString:=selV430.FieldByName('codfiscale').AsString;
    if selV430.FindField('descrpartitaiva') <> nil then
      cdsRiepilogo.FieldByName('Partita_Iva').AsString:=selV430.FieldByName('descrpartitaiva').AsString;
    cdsRiepilogo.FieldByName('PosizioneINAIL').AsString:=selV430.FieldByName('p092posizione_inail').AsString;
    if selP442.FieldByName('COD_PAGAMENTO').AsString = '1' then
    begin
      sDep:=selP442.FieldByName('DESC_PAGAMENTO').AsString + ' IBAN';
      if sDep <> '' then
        cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=sDep ;
      //Calcolo i dati bancari dell'ordinante che sono uguali per tutti i dipendenti
      if Trim(selDatiPag.FieldByName('P430IBAN_ESTERO').AsString) <> '' then
        sDep:=selDatiPag.FieldByName('P430IBAN_ESTERO').AsString
      else
        sDep:=selDatiPag.FieldByName('P430IBAN').AsString;
      if sDep <> '' then
        cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' ' + sDep);
      sDep:=trim(selDatiPag.FieldByName('P430D_COD_BANCA').AsString);
      if sDep <> '' then
        cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' ' + sDep);
      sDep:=trim(selDatiPag.FieldByName('P430AGENZIA_BANCA').AsString);
      if sDep <> '' then
        cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',' Agenzia ',' Branch ') + sDep);
    end
    else
    begin
      sDep:=trim(selP442.FieldByName('DESC_PAGAMENTO').AsString + ' ' + selDatiPag.FieldByName('P430D_COD_BANCA').AsString);
      if sDep <> '' then
        cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=sDep;
      sDep:=trim(selDatiPag.FieldByName('P430AGENZIA_BANCA').AsString);
      if sDep <> '' then
        cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' Agenzia ' + sDep;
      sDep:=trim(selDatiPag.FieldByName('P430CONTO_CORRENTE').AsString);
      if sDep <> '' then
        cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString + ' C/C n. ' + sDep;
    end;
  end
  else
    cdsRiepilogo.FieldByName('MODALITA_PAGAMENTO').AsString:=trim(selP442.FieldByName('DESC_PAGAMENTO').AsString);
  cdsRiepilogo.FieldByName('COD_VALUTA_STAMPA').AsString:=selP442.fieldbyname('COD_VALUTA_STAMPA').AsString;
  //Gestione dei cambi (Valuta calcoli P441 --> Valuta netto P441)
  if (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S')
  and (selP442.FieldByName('COD_VALUTA_BASE').AsString <> selP442.FieldByName('COD_VALUTA_STAMPA').AsString) then
  begin
    SetLength(sPv_Cambi,1);
    sPv_Cambi[0].Valuta1:=selP442.FieldByName('COD_VALUTA_BASE').AsString;
    sPv_Cambi[0].Valuta2:=selP442.FieldByName('COD_VALUTA_STAMPA').AsString;
    sPv_Cambi[0].Cambio:=QueryCambio.CambioValuta(sPv_Cambi[0].Valuta1,sPv_Cambi[0].Valuta2,selP442.FieldByName('DATA_CAMBIO_VALUTA').AsDateTime);
    if sPv_Cambi[0].Cambio <> 0 then
      cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString:='1 ' + sPv_Cambi[0].Valuta1 + ' = ' + Trim(Format('%5.5f',[sPv_Cambi[0].Cambio])) + ' ' + sPv_Cambi[0].Valuta2;
  end;

  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleCompetenze.CodVoce,VFTotaleCompetenze.CodVoceSpeciale]),[srFromBeginning]) then
  begin
    nPv_TotCompetenze:=selP442.FieldByName('Importo').AsFloat;
    while selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleCompetenze.CodVoce,VFTotaleCompetenze.CodVoceSpeciale]),[]) do
      nPv_TotCompetenze:=nPv_TotCompetenze + selP442.FieldByName('Importo').AsFloat;
    cdsRiepilogo.FieldByName('Tot_Competenze').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, nPv_TotCompetenze);
  end;
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleRitenute.CodVoce,VFTotaleRitenute.CodVoceSpeciale]),[srFromBeginning]) then
  begin
    nPv_TotTrattenute:=selP442.FieldByName('Importo').AsFloat;
    while selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFTotaleRitenute.CodVoce,VFTotaleRitenute.CodVoceSpeciale]),[]) do
      nPv_TotTrattenute:=nPv_TotTrattenute + selP442.FieldByName('Importo').AsFloat;
    cdsRiepilogo.FieldByName('Tot_Ritenute').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, nPv_TotTrattenute);
  end;
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoce,VFTakeHome.CodVoce),IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoceSpeciale,VFTakeHome.CodVoceSpeciale)]),[srFromBeginning]) then
  begin
    nPv_Netto:=selP442.FieldByName('Importo').AsFloat;
    while selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoce,VFTakeHome.CodVoce),IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S',VFTotaleNettoAPagare.CodVoceSpeciale,VFTakeHome.CodVoceSpeciale)]),[]) do
      nPv_Netto:=nPv_Netto + selP442.FieldByName('Importo').AsFloat;
    cdsRiepilogo.FieldByName('Netto').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, nPv_Netto);
  end;
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFImponibileIRPEFCong.CodVoce,VFImponibileIRPEFCong.CodVoceSpeciale]),[srFromBeginning]) then
  begin
    //La voce può essere presente:
    //1) una volta sola: riferita all'anno corrente (dipendente in servizio a fine anno o cessato durante l'anno)
    //2) una volta sola: riferita all'anno precedente (dipendente in servizio a gennaio o febbraio, con conguaglio anno precedente)
    //3) due volte: una riferita all'anno corrente e una all'anno precedente (dipendente cessato a gennaio o febbraio, con conguaglio anno precedente)
    //Se la voce è presente più volte, viene ordinata per data_competenza_a, perciò:
    // a) in IrisWin/Cloud, dato che c'è un ciclo sulle voci, in qlblImponibile viene inserito il valore della competenza più recente
    // b) in IrisWeb, dato che non c'è un ciclo sulle voci, in Imponibile_Lordo viene inserito il valore della competenza più remota
    //Ad ogni modo tale valore potrebbe essere sovrascritto dai totali da inizio anno in base a bPv_CalcolaProgressivi
    cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, selP442.FieldByName('Importo').AsFloat);
    //Se la voce è riferita all'anno corrente...
    if FormatDateTime('yyyy', selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime) = FormatDateTime('yyyy',DataRetribuzione) then
    begin
      //...evito il successivo ricalcolo dei totali da inizio anno
      bPv_CalcolaProgressivi:=False;
      //Inoltre dal 2022 la riduco dell'eventuale deduzione FPC, cercata a parità di data competenza
      if (R180Anno(DataCedolino) >= 2022)
      and selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE;DATA_COMPETENZA_A',VarArrayOf([VFDeduzioneIRPEFFPCDipCong.CodVoce,VFDeduzioneIRPEFFPCDipCong.CodVoceSpeciale,selP442.FieldByName('DATA_COMPETENZA_A').AsDateTime]),[srFromBeginning]) then
        cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, StrToFloatDef(StringReplace(cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString,'.','',[rfReplaceAll]),0) - selP442.FieldByName('Importo').AsFloat);
    end;
  end;
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFDetrazioniIRPEFTotaliCong.CodVoce,VFDetrazioniIRPEFTotaliCong.CodVoceSpeciale]),[srFromBeginning]) then
  begin
    nPv_Detrazioni:=selP442.FieldByName('Importo').AsFloat;
    cdsRiepilogo.FieldByName('Detrazioni').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, selP442.FieldByName('Importo').AsFloat);
  end;
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFDeduzioneIRPEFNoTaxCong.CodVoce,VFDeduzioneIRPEFNoTaxCong.CodVoceSpeciale]),[srFromBeginning]) then
    nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442.FieldByName('Importo').AsFloat;
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFDeduzioneIRPEFFamCong.CodVoce,VFDeduzioneIRPEFFamCong.CodVoceSpeciale]),[srFromBeginning]) then
    nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442.FieldByName('Importo').AsFloat;
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFRitenutaIRPEFLordaCong.CodVoce,VFRitenutaIRPEFLordaCong.CodVoceSpeciale]),[srFromBeginning]) then
    cdsRiepilogo.FieldByName('Ritenuta').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, (selP442.FieldByName('Importo').AsFloat - nPv_Detrazioni));
  if selP442.SearchRecord('COD_VOCE;COD_VOCE_SPECIALE',VarArrayOf([VFArrotondamento.CodVoce,VFArrotondamento.CodVoceSpeciale]),[srFromBeginning]) then
    if selP442.FieldByName('Importo').AsFloat <> 0 then
      cdsRiepilogo.FieldByName('Arrotondamento').AsString:=FormattaVoce(selP442.FieldByName('Importo_Colonna').AsString, (selP442.FieldByName('Importo').AsFloat));

  if bPv_CalcolaProgressivi then
  begin
    cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString:='';
    cdsRiepilogo.FieldByName('Ritenuta').AsString:='';
    cdsRiepilogo.FieldByName('Deduzioni').AsString:='';
    cdsRiepilogo.FieldByName('Detrazioni').AsString:='';
    nPv_DeduzioneNoTax:=0;
    selP442A.Close;
    selP442A.SetVariable('Cod_Voce', VFImponibileIRPEF.CodVoce);
    selP442A.SetVariable('CedolinoInStampa', selP442.FieldByName('ID_CEDOLINO').asInteger);
    selP442A.SetVariable('Progressivo', selP442.GetVariable('Progressivo'));
    selP442A.SetVariable('DataCedolinoInStampa', selP442.GetVariable('data_cedolino'));
    selP442A.SetVariable('DataRetribInStampa',DataRetribuzione);
    selP442A.Open;
    if selP442A.RecordCount > 0 then
      cdsRiepilogo.FieldByName('Imponibile_Lordo').AsString:=Trim(Format('%*.*n',[10,2,selP442A.FieldByName('IMPORTO').AsFloat]));
    selP442A.Close;
    selP442A.SetVariable('Cod_Voce', VFRitenutaIRPEFNetta.CodVoce);
    selP442A.Open;
    if selP442A.RecordCount > 0 then
      cdsRiepilogo.FieldByName('Ritenuta').AsString:=Trim(Format('%*.*n',[10,2,selP442A.FieldByName('IMPORTO').AsFloat]));
    selP442A.Close;
    selP442A.SetVariable('Cod_Voce', VFDetrazioniIRPEFTotali.CodVoce);
    selP442A.Open;
    if selP442A.RecordCount > 0 then
      cdsRiepilogo.FieldByName('Detrazioni').AsString:=Trim(Format('%*.*n',[10,2,selP442A.FieldByName('IMPORTO').AsFloat]));
    selP442A.Close;
    selP442A.SetVariable('Cod_Voce', VFDeduzioneIRPEFNoTax.CodVoce);
    selP442A.Open;
    if selP442A.RecordCount > 0 then
      nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442A.FieldByName('IMPORTO').AsFloat;
    //La parte che segue è stata inserita da Andrea in data 28/01/2005
    selP442A.Close;
    selP442A.SetVariable('Cod_Voce', VFDeduzioneIRPEFFam.CodVoce);
    selP442A.Open;
    if selP442A.RecordCount > 0 then
      nPv_DeduzioneNoTax:=nPv_DeduzioneNoTax + selP442A.FieldByName('IMPORTO').AsFloat;
  end;
  if nPv_DeduzioneNoTax > 0 then
    cdsRiepilogo.FieldByName('Deduzioni').AsString:=Trim(Format('%*.*n',[10,2,nPv_DeduzioneNoTax]));
  cdsRiepilogo.Post;

  //Popolo le note
  cdsNote.Append;
  cdsNote.FieldByName('CHIAVE').AsString:=Chiave;
  if PCumuloVociArretrate then
  begin
    SelP441_Note.SetVariable('ID_CEDOLINO', selP442.FieldByName('ID_CEDOLINO').AsInteger);
    SelP441_Note.Open;
    cdsNote.FieldByName('Note').AsString:=trim(SelP441_Note.FieldByName('NOTE').AsString);
    SelP441_Note.Close;
  end
  else
    cdsNote.FieldByName('Note').AsString:=trim(selP442.FieldByName('NOTE').AsString);
  if Trim(cdsNote.FieldByName('Note').AsString) <> '' then
    cdsNote.Post
  else
    cdsNote.Cancel;

  //Dettaglio Voci
  selP442.First;
  while not selP442.Eof do
  begin
    if (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'S')
    or (    (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'D')
        and (selP442.FieldByName('IMPORTO').AsFloat <> 0)) then
    begin
      cdsDettaglio.Append;
      cdsDettaglio.FieldByName('CHIAVE').AsString:=Chiave;
      cdsDettaglio.FieldByName('Cod_Voce').AsString:=selP442.FieldByName('Voce').AsString;
      DescVoce:=selP442.FieldByName('Descrizione').AsString;
      if selP442.FieldByName('Stampa_Competenza').AsString = 'S' then
      begin
        if PCumuloVociArretrate then
        begin
          if selP442.FieldByName('NumRec').AsInteger = 1 then
          begin
            if selP442.FieldByName('Data_Competenza_A').AsDateTime < DataRetribuzione then
            begin
              DescVoce:=Copy(Format('%-*s',[MaxCar,DescVoce]),1,MaxCar);
              DescVoce:=DescVoce + FormatDateTime(' (mm/yyyy)',selP442.FieldByName('Data_Competenza_A').AsDateTime);
            end
          end
          else
          begin
            DescVoce:=Copy(Format('%-*s',[MaxCar,DescVoce]),1,MaxCar);
            DescVoce:=DescVoce + FormatDateTime('    (yyyy)',selP442.FieldByName('Data_Competenza_A').AsDateTime);
          end
        end
        else
        begin
          if (selP442.FieldByName('Stampa_Competenza').AsString = 'S') and
             (FormatDateTime('mmyyyy',selP442.FieldByName('Data_Competenza_A').AsDateTime) <> FormatDateTime('mmyyyy',DataRetribuzione)) then
          begin
            DescVoce:=Copy(Format('%-*s',[MaxCar,DescVoce]),1,MaxCar);
            DescVoce:=DescVoce + FormatDateTime(' (mm/yyyy)',selP442.FieldByName('Data_Competenza_A').AsDateTime);
          end;
        end;
      end;
      cdsDettaglio.FieldByName('Desc_Voce').AsString:=DescVoce;
      cdsDettaglio.FieldByName('Cod_Valuta_Iniz').AsString:=selP442.FieldByName('Cod_Valuta_Iniz').AsString;
      if selP442.FieldByName('Importo_Valuta_Iniz').AsFloat <> 0 then
        cdsDettaglio.FieldByName('Importo_Valuta_Iniz').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo_Valuta_Iniz').AsFloat]));
      cdsDettaglio.FieldByName('Quantita').AsString:=Trim(selP442.FieldByName('Quantita').AsString);
      cdsDettaglio.FieldByName('DatoBase').AsString:=Trim(selP442.FieldByName('DatoBase').AsString);
      if selP442.FieldByName('Importo_Colonna').AsString = 'R' then
        cdsDettaglio.FieldByName('Ritenute').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo').AsFloat]))
      else if selP442.FieldByName('Importo_Colonna').AsString = 'E' then
        cdsDettaglio.FieldByName('Ritenute').AsString:='e' + Trim(Format('%*.*n',[9,2,selP442.FieldByName('Importo').AsFloat]))
      else if selP442.FieldByName('Importo_Colonna').AsString = 'C' then
        cdsDettaglio.FieldByName('Competenze').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo').AsFloat]))
      else if selP442.FieldByName('Importo_Colonna').AsString = 'D' then
        cdsDettaglio.FieldByName('DatoBase').AsString:=Trim(Format('%*.*n',[10,2,selP442.FieldByName('Importo').AsFloat]));
      cdsDettaglio.Post;
      //Gestione dei cambi (Valuta P442 --> Valuta calcoli P441)
      if (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S')
      and (   (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'S')
           or (    (selP442.FieldByName('STAMPA_CEDOLINO').AsString = 'D')
               and (selP442.FieldByName('IMPORTO').AsFloat <> 0)))
      and not selP442.FieldByName('COD_VALUTA_INIZ').IsNull
      and (selP442.FieldByName('COD_VALUTA_INIZ').AsString <> selP442.FieldByName('COD_VALUTA_BASE').AsString) then
      begin
        bCambioTrovato:=False;
        for i:=0 to High(sPv_Cambi) do
          if (sPv_Cambi[i].Valuta1 = selP442.FieldByName('COD_VALUTA_INIZ').AsString)
          and (sPv_Cambi[i].Valuta2 = selP442.FieldByName('COD_VALUTA_BASE').AsString) then
          begin
            bCambioTrovato:=True;
            Break;
          end;
        if not bCambioTrovato then
        begin
          SetLength(sPv_Cambi,Length(sPv_Cambi) + 1);
          i:=High(sPv_Cambi);
          sPv_Cambi[i].Valuta1:=selP442.FieldByName('COD_VALUTA_INIZ').AsString;
          sPv_Cambi[i].Valuta2:=selP442.FieldByName('COD_VALUTA_BASE').AsString;
          sPv_Cambi[i].Cambio:=QueryCambio.CambioValuta(sPv_Cambi[i].Valuta1,sPv_Cambi[i].Valuta2,selP442.FieldByName('DATA_CAMBIO_VALUTA').AsDateTime);
          if sPv_Cambi[i].Cambio <> 0 then
          begin
            cdsRiepilogo.Edit;
            if cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString <> '' then
              cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString:=cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString + '; ';
            cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString:=cdsRiepilogo.FieldByName('CAMBI_VALUTE').AsString + '1 ' + sPv_Cambi[i].Valuta1 + ' = ' + Trim(Format('%5.5f',[sPv_Cambi[i].Cambio])) + ' ' + sPv_Cambi[i].Valuta2;
            cdsRiepilogo.Post;
          end;
        end;
      end;
    end;
    selP442.Next;
  end;

  try FreeAndNil(QueryCambio); except end;
end;

procedure TW017FStampaCedolinoDM.EsecuzioneStampa(const PNomeFilePdf: String; var RErrMsg: String);
var
  rvComp:TRaveComponent;
  L:TStringList;
  dconnRiepilogo,dconnDettaglio,dconnNote:TRaveDataConnection;
  //Azione: Integer;
const
  RAVE_MODEL_CEDOLINO_STD = 'W017StampaCedolino.rav';
  RAVE_MODEL_CEDOLINO_INT = 'W017StampaCedolinoInternazionale.rav';
begin
  // nel caso di webservice manca il file di configurazione
  // ma un tale parametro non dovrebbe servire
  {$IFNDEF WEBSVC}
  if Pos(INI_PAR_NO_STAMPACEDOLINO,W000ParConfig.ParametriAvanzati) > 0 then
    exit;
  {$ENDIF WEBSVC}
  try
    W017CSStampa.Enter;
    rvSystem:=TRVSystem.Create(Self);
    rvProject:=TRVProject.Create(Self);
    connRiepilogo:=TRVDataSetConnection.Create(Self);
    connDettaglio:=TRVDataSetConnection.Create(Self);
    connNote:=TRVDataSetConnection.Create(Self);
    rvRenderPDF:=TRvRenderPDF.Create(Self);
    L:=TStringList.Create;
    try
      rvProject.Engine:=RvSystem;
      rvRenderPDF.Active:=True;
      // la directory viene passata come parametro
      // i nomi dei modelli sono ora costanti
      rvProject.ProjectFile:=TPath.Combine(RaveProjectPath,IfThen(Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S',RAVE_MODEL_CEDOLINO_INT,RAVE_MODEL_CEDOLINO_STD));
      connRiepilogo.Name:='connRiepilogo';
      connRiepilogo.DataSet:=cdsRiepilogo;
      connRiepilogo.RuntimeVisibility:=RpCon.rtNone;
      connDettaglio.Name:='connDettaglio';
      connDettaglio.DataSet:=cdsDettaglio;
      connDettaglio.RuntimeVisibility:=RpCon.rtNone;
      connNote.Name:='connNote';
      connNote.DataSet:=cdsNote;
      connNote.RuntimeVisibility:=RpCon.rtNone;
      rvProject.Open;
      rvProject.GetReportList(L,True);
      rvProject.SelectReport(L[0],True);
      rvDWRiepilogo:=(RVProject.ProjMan.FindRaveComponent('dwRiepilogo',nil) as TRaveDataView);
      rvDWDettaglio:=(RVProject.ProjMan.FindRaveComponent('dwDettaglio',nil) as TRaveDataView);
      rvDWNote:=(RVProject.ProjMan.FindRaveComponent('dwNote',nil) as TRaveDataView);
      //Impostazioni dei campi di Dettaglio
      dconnDettaglio:=CreateDataCon(connDettaglio);
      rvDWDettaglio.ConnectionName:=dconnDettaglio.Name;
      rvDWDettaglio.DataCon:=dconnDettaglio;
      CreateFields(rvDWDettaglio,nil,nil,True);
      //Impostazioni dei campi di Note
      dconnNote:=CreateDataCon(connNote);
      rvDWNote.ConnectionName:=dconnNote.Name;
      rvDWNote.DataCon:=dconnNote;
      CreateFields(rvDWNote,nil,nil,True);
      rvPage:=RVProject.ProjMan.FindRaveComponent('W017.Page',nil);
      //Impostazioni della banda bndTitolo
      rvComp:=RVProject.ProjMan.FindRaveComponent('bmpLogo',rvPage);
      (rvComp as TRaveBitmap).Height:=0;
      (rvComp as TRaveBitmap).Width:=0;
      with TSelT004.Create(nil) do
      try
        Session:=SessioneOracle;
        Azienda:=selAnagrafeW.FieldByName('T430AZIENDA_BASE').AsString;
        Data:=DataRetribuzione;
        if EsisteImmagine then
        begin
          (rvComp as TRaveBitmap).Image.Assign(Immagine);
          (rvComp as TRaveBitmap).Width:=1.2;//LarghezzaCedolino*(1.2/165);
          //if Parametri.RagioneSociale = 'A.O. "OSPEDALE L. SACCO"' then
          if LarghezzaCedolino = 165 then
          begin
            (rvComp as TRaveBitmap).Height:=0.896;
            rvComp:=RVProject.ProjMan.FindRaveComponent('bndTitolo',rvPage);
            (rvComp as TRaveContainerControl).Height:=1.06;
          end
          else
          begin
            (rvComp as TRaveBitmap).Height:=0.640;
          end;
        end;
      finally
        Free;
      end;
      TitoloStampa:='';
      CittaStampa:='';
      CodFiscaleStampa:='';
      //uso l'azienda presente in anagrafica alla DataRetribuzione
      if selP500.SearchRecord('COD_AZIENDA_BASE',selAnagrafeW.FieldByName('T430AZIENDA_BASE').AsString,[srFromBeginning]) then
      begin
        TitoloStampa:=selP500.FieldByName('indirizzo').AsString;
        CittaStampa:=selP500.FieldByName('cap').AsString + ' ' + selP500.FieldByName('comune').AsString;
        CodFiscaleStampa:=selP500.FieldByName('cod_fiscale').AsString;
      end;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblAzienda',rvPage);
      (rvComp as TRaveText).Text:=GetRagioneSociale;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblTitolo',rvPage);
      //(rvComp as TRaveText).Text:=TitoloStampa;
      (rvComp as TRaveText).Text:=TitoloStampa + ' - ' + CittaStampa;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblCitta',rvPage);
      //(rvComp as TRaveText).Text:=CittaStampa;
      if CodFiscaleStampa <> '' then
        (rvComp as TRaveText).Text:='P.IVA/C.F. ' + CodFiscaleStampa
      else
        (rvComp as TRaveText).Text:='';
      if Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S' then
      begin
        rvComp:=RVProject.ProjMan.FindRaveComponent('lblCambiValute',rvPage);
        (rvComp as TRaveText).Text:='EXCHANGE RATES ' + UpperCase(FormatDateTime('mmmm yyyy',DataRetribuzione));
      end;
      rvComp:=RVProject.ProjMan.FindRaveComponent('lblCodFiscale',rvPage);
      // correzione per cedolino internazionale.ini - 25.06.2012
      if Assigned(rvComp) then
      begin
        (rvComp as TRaveText).Text:=IfThen(cdsRiepilogo.FieldByName('Partita_Iva').AsString = '','CODICE FISCALE','PARTITA IVA');
        rvComp:=RVProject.ProjMan.FindRaveComponent('dlblCodFiscale',rvPage);
        (rvComp as TRaveDataText).DataField:=IfThen(cdsRiepilogo.FieldByName('Partita_Iva').AsString = '','Cod_Fiscale','Partita_Iva');
      end;
      // correzione per cedolino internazionale.fine
      //Impostazioni dei campi di Riepilogo
      dconnRiepilogo:=CreateDataCon(connRiepilogo);
      rvDWRiepilogo.ConnectionName:=dconnRiepilogo.Name;
      rvDWRiepilogo.DataCon:=dconnRiepilogo;
      CreateFields(rvDWRiepilogo,nil,nil,True);
      //Generazione del file PDF
      rvSystem.SystemSetups:=RVSystem.SystemSetups - [ssAllowSetup];
      rvSystem.SystemOptions:=rvSystem.SystemOptions - [soShowStatus,soPreviewModal];
      rvSystem.DefaultDest:=rdFile;
      rvSystem.DoNativeOutput:=False;
      rvSystem.RenderObject:=RvRenderPDF;
      // nel caso di webservice manca il file di configurazione, per cui
      // imposta lo streammode su tempfile
      {$IFDEF WEBSVC}
      //rvSystem.SystemFiler.StreamMode:=smTempFile;
      rvSystem.SystemFiler.StreamMode:=smMemory;
      {$ELSE}
      if W000ParConfig.RaveStreamMode = INI_RAVE_STREAM_MODE_TEMPFILE then
        rvSystem.SystemFiler.StreamMode:=smTempFile
      else
        rvSystem.SystemFiler.StreamMode:=smMemory;
      {$ENDIF WEBSVC}
      // il nome del file è ora impostato esternamente
      rvSystem.OutputFileName:=PNomeFilePdf;
      ForceDirectories(ExtractFileDir(rvSystem.OutputFileName));
      rvProject.Execute;
    finally
      try L.Free; except end;
      try rvProject.Close; except end;
      try FreeAndNil(dconnRiepilogo); except end;
      try FreeAndNil(dconnDettaglio); except end;
      try FreeAndNil(dconnNote); except end;
      try FreeAndNil(rvSystem); except end;
      try FreeAndNil(rvRenderPDF); except end;
      try FreeAndNil(rvProject); except end;
      try FreeAndNil(connRiepilogo); except end;
      try FreeAndNil(connDettaglio); except end;
      try FreeAndNil(connNote); except end;
      W017CSStampa.Leave;
    end;
  except
    on E: Exception do
    begin
      RErrMsg:=Format('Errore durante l''esecuzione della stampa: %s',[E.Message]);
    end;
  end;
end;

function TW017FStampaCedolinoDM.GetRagioneSociale{(Progressivo:Integer = -1)}:String;
var AziendaBase:String;
begin
  Result:=Parametri.RagioneSociale;
  if selAnagrafeW.FindField('T430AZIENDA_BASE') = nil then
    exit;

  AziendaBase:=selAnagrafeW.FieldByName('T430AZIENDA_BASE').AsString;
  if not R180In(AziendaBase,['',T440AZIENDA_BASE]) then
  begin
    Result:=selAnagrafeW.FieldByName('T430D_AZIENDA_BASE').AsString;
  end;
end;

procedure TW017FStampaCedolinoDM.ImpostaDataConsegna(PIdCedolino: Integer);
begin
  updP441.SetVariable('DATA_CONSEGNA',Trunc(R180Sysdate(SessioneOracle)));
  updP441.SetVariable('ID_CEDOLINO',PIdCedolino);
  updP441.Execute;
  SessioneOracle.Commit;
end;

procedure TW017FStampaCedolinoDM.selP441FilterRecord(DataSet: TDataSet; var Accept: Boolean);
//richiamato sia da selP441 che da selP441CountDaLeggere
begin
  inherited;
  Accept:=EsisteFilePDFCedolino(DataSet) = 'S';
end;

// estratto da da W0001Dtm
function TW017FStampaCedolinoDM.EsisteFilePDFCedolino(DataSet: TDataSet): String;
var NomeFileOrig,PathPDF:String;
    IdCedolino:Integer;
    DataRetribuzione,DataCedolino:TDateTime;
begin
  inherited;
  Result:='N';
  if Parametri.WEBCedoliniFilePDF = 'S' then
    try
      DataRetribuzione:=R180FineMese(StrToDate('01/' + DataSet.FieldByName('DATA_RETRIBUZIONE').AsString));
      selP500.Close;
      selP500.SetVariable('Anno', strtoint(FormatDateTime('yyyy',DataRetribuzione)));
      selP500.Open;
      if selP500.SearchRecord('COD_AZIENDA_BASE',T440AZIENDA_BASE,[srFromBeginning]) then
        PathPDF:=selP500.FieldByName('PATH_FILEPDF_CED').AsString
      else
        PathPDF:='';
      DataCedolino:=R180FineMese(StrToDate('01/' + DataSet.FieldByName('DATA_CEDOLINO').AsString));
      IdCedolino:=DataSet.FieldByName('ID_CEDOLINO').AsInteger;
      NomeFileOrig:=PathPDF + '\' + FormatDateTime('yyyymm',DataCedolino) + '\' + IntToStr(IdCedolino) + '.pdf';
      Result:=IfThen(FileExists(NomeFileOrig),'S','N');
    except
    end;
end;

end.
