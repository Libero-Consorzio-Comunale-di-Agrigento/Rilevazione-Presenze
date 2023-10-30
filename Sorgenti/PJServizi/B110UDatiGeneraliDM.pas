unit B110UDatiGeneraliDM;

interface

uses
  A000UCostanti,
  A000Versione,
  R015UDatasnapRestDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  B110USharedTypes,
  B110UUtils,
  FunzioniGenerali,
  L021Call,
  W000UMessaggi,
  System.SysUtils,
  System.Classes,
  System.DateUtils,
  System.StrUtils,
  System.Math,
  Oracle, Data.DB, OracleData;

type
  TB110FDatiGeneraliDM = class(TR015FDatasnapRestDM)
    selT030_T430: TOracleDataSet;
    selP441_MaxData: TOracleQuery;
    selT950: TOracleDataSet;
    selI061: TOracleDataSet;
    selT040Note: TOracleDataSet;
    selAnagrafe: TOracleDataSet;
    procedure selT950FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  end;

implementation

uses
  A000UInterfaccia,
  A000USessione,
  System.IOUtils;

{$R *.dfm}

{ TB110FDatiGeneraliDM }

procedure TB110FDatiGeneraliDM.selT950FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('PARAMETRIZZAZIONI CARTELLINO',DataSet.FieldByName('CODICE').AsString);
end;

function TB110FDatiGeneraliDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=True;
  Result.Messaggio:='';
end;

procedure TB110FDatiGeneraliDM.Esegui(var RRisultato: TRisultato);
var
  LDataRif: TDateTime;
  LRes: TOutputDatiGenerali;
  i: Integer;
  j: Integer;
  LTag: Integer;
  LAbil: String;
  LFiltroAnagrafe: String;
  LFiltroInServizio: String;
  LCampiV430: String;
begin
  // registra accesso sui log
  // nota: i dati ridondanti sono inseriti per coerenza con gli altri applicativi
  RegistraLog.SettaProprieta('A','','B110',nil,True);
  RegistraLog.InserisciDato('APPLICATIVO','',TPath.GetFileName(GetModuleName(HInstance)).ToUpper);
  RegistraLog.InserisciDato('TIPOUTENTE','','Dipendente'); // dato fisso (l'accesso è solo per dipendenti web I060)
  RegistraLog.InserisciDato('OPERATORE','',Parametri.Operatore);
  RegistraLog.InserisciDato('PROFILO','',Parametri.ProfiloWEB);
  RegistraLog.InserisciDato('TIPO','','ACCESSO');
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;

  LDataRif:=Date;

  // prepara l'output
  RRisultato.Output:=TOutputDatiGenerali.Create;
  LRes:=TOutputDatiGenerali(RRisultato.Output);

  // crea e prepara oggetto parametri
  FreeAndNil(LRes.Parametri);
  LRes.Parametri:=TParamMobile.Create;
  LRes.Parametri.AssignParametri(Parametri);

  {$REGION 'Informazioni del profilo corrente, abilitazioni ed elenco profili disponibili'}

  // nome del profilo corrente
  LRes.Profilo:=GetParametriLogin.Profilo;

  // dati delle abilitazioni per il profilo corrente
  // IMPORTANTE:
  //   restituisce solo i valori di filtro funzioni relativi al modulo irisweb
  SetLength(LRes.AbilitazioniArr,0);
  j:=0;
  for i:=Low(FunzioniDisponibili) to High(FunzioniDisponibili) do
  begin
    if FunzioniDisponibili[i].M = 'IRIS_WEB' then
    begin
      SetLength(LRes.AbilitazioniArr,Length(LRes.AbilitazioniArr) + 1);
      LTag:=FunzioniDisponibili[i].T;
      LAbil:=A000GetInibizioni('Tag',LTag.ToString);
      // se la funzione è legata ad un modulo opzionale, l'abilitazione è legata alla presenza di tale modulo
      if FunzioniDisponibili[i].MIW <> '' then
      begin
        if not Parametri.ModuloInstallato[FunzioniDisponibili[i].MIW] then
          LAbil:='N';
      end;
      LRes.AbilitazioniArr[j]:=TAbilitazioneFunzione.Create(LTag,LAbil);
      inc(j);
    end;
  end;

  // elenco dei profili disponibili e validi alla data odierna
  selI061.Close;
  selI061.SetVariable('AZIENDA',Parametri.Azienda);
  selI061.SetVariable('NOME_UTENTE',Parametri.Operatore);
  selI061.Open;
  SetLength(LRes.ProfiliArr,selI061.RecordCount);
  i:=0;
  while not selI061.Eof do
  begin
    LRes.ProfiliArr[i]:=selI061.FieldByName('NOME_PROFILO').AsString;
    inc(i);
    selI061.Next;
  end;

  {$ENDREGION 'Informazioni del profilo corrente, abilitazioni ed elenco profili disponibili'}

  {$REGION 'Dati anagrafici utente'}

  selT030_T430.Close;
  selT030_T430.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
  selT030_T430.SetVariable('DATA_RIFERIMENTO',LDataRif);
  selT030_T430.Open;
  if selT030_T430.RecordCount > 0 then
  begin
    LRes.DatiAnagraficiUtente.Progressivo:=selT030_T430.FieldByName('PROGRESSIVO').AsInteger;
    LRes.DatiAnagraficiUtente.Matricola:=selT030_T430.FieldByName('MATRICOLA').AsString;
    LRes.DatiAnagraficiUtente.Nome:=selT030_T430.FieldByName('NOME').AsString;
    LRes.DatiAnagraficiUtente.Cognome:=selT030_T430.FieldByName('COGNOME').AsString;
    LRes.DatiAnagraficiUtente.Sesso:=selT030_T430.FieldByName('SESSO').AsString;
    LRes.DatiAnagraficiUtente.CodFiscale:=selT030_T430.FieldByName('CODFISCALE').AsString;
    LRes.DatiAnagraficiUtente.DataNascita:=selT030_T430.FieldByName('DATANAS').AsDateTime;
    RRisultato.AddInfo(Format('Dati anagrafici ok (data riferimento %s)',[LDataRif.ToString]));
  end
  else
  begin
    RRisultato.AddError(TErrorCode.DataNotFound,Format('Dati anagrafici: dipendente non presente in archivio (progressivo %d, data riferimento %s)',[Parametri.ProgressivoOper,LDataRif.ToString]));
  end;

  {$ENDREGION 'Dati anagrafici utente'}

  {$REGION 'Valutazione eventuale filtro anagrafe'}
  if not Parametri.InibizioneIndividuale then
  begin
    // per il momento non estrae nulla
    LCampiV430:='';

    selAnagrafe.SQL.Clear;
    selAnagrafe.SQL.Text:=QVistaOracle;
    selAnagrafe.SQL.Insert(0,Format('SELECT %s T030.*,T480.CITTA, T480.PROVINCIA %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,LCampiV430]));
    selAnagrafe.SQL.Add(':FILTRO_IN_SERVIZIO');
    selAnagrafe.SQL.Add(':FILTRO');
    selAnagrafe.DeleteVariables;
    selAnagrafe.DeclareVariable('DATALAVORO',otDate);
    selAnagrafe.DeclareVariable('FILTRO',otSubst);
    selAnagrafe.DeclareVariable('FILTRO_IN_SERVIZIO',otSubst);

    // imposta il filtro anagrafe e il filtro per i cessati
    LFiltroInServizio:=FILTRO_IN_SERVIZIO;//IfThen(VisualizzaCessati,'',FILTRO_IN_SERVIZIO);
    LFiltroAnagrafe:=Parametri.Inibizioni.Text;
    // IMPORTANTE: se nel filtro vengono usati campi della T030_ANAGRAFICO,
    // viene aggiunto l'alias "T030" per evitare problemi nelle join
    LFiltroAnagrafe:=TFunzioniGenerali.InserisciAliasT030(LFiltroAnagrafe);
    LFiltroAnagrafe:=CRLF + TAG_FILTRO_ANAG_INIZIO + CRLF + LFiltroAnagrafe + IfThen(LFiltroAnagrafe <> '',CRLF) + TAG_FILTRO_ANAG_FINE + CRLF;
    if (Trim(LFiltroAnagrafe) <> '') and (Trim(LFiltroAnagrafe) <> TAG_FILTRO_ANAG_INIZIO + CRLF + TAG_FILTRO_ANAG_FINE) then
      LFiltroAnagrafe:=' AND ' + LFiltroAnagrafe;

    selAnagrafe.Close;
    selAnagrafe.ReadBuffer:=IfThen(Parametri.InibizioneIndividuale,2,100);
    selAnagrafe.SetVariable('DATALAVORO',Parametri.DataLavoro);
    selAnagrafe.SetVariable('FILTRO_IN_SERVIZIO',LFiltroInServizio);
    selAnagrafe.SetVariable('FILTRO',LFiltroAnagrafe.Trim);
    try
      selAnagrafe.Open;
      LRes.DatiDipendenti.NumDipendenti:=selAnagrafe.RecordCount;
      selAnagrafe.Filter:=Format('PROGRESSIVO <> %d',[Parametri.ProgressivoOper]);
      selAnagrafe.Filtered:=True;
      LRes.DatiDipendenti.NumDipendentiDiversiDaProgressivo:=selAnagrafe.RecordCount;
    except
      on E:Exception do
      begin
        RRisultato.AddError(Format(A000TraduzioneStringhe(A000MSG_W002_ERR_FMT_FILTRO_NON_ASSOCIATO),[Parametri.Operatore,E.Message]));
      end;
    end;
    selAnagrafe.CloseAll;
  end;

  {$ENDREGION 'Valutazione eventuale filtro anagrafe'}

  {$REGION 'Parametri per i servizi esposti'}

  // elenco parametrizzazioni di stampa cartellino
  try
    selT950.Close;
    selT950.Open;
    SetLength(LRes.ParametriServizi.CodiciT950,selT950.RecordCount);
    if selT950.RecordCount > 0 then
    begin
      selT950.First;
      i:=0;
      while not selT950.Eof do
      begin
        LRes.ParametriServizi.CodiciT950[i]:=TNomeValore.Create(selT950.FieldByName('CODICE').AsString,
                                                                selT950.FieldByName('DESCRIZIONE').AsString);
        inc(i);
        selT950.Next;
      end;
      RRisultato.AddInfo(Format('Stampa cartellino - parametrizzazioni di stampa ok (%d record)',[selT950.RecordCount]));
    end;
  except
    on E: Exception do
    begin
      RRisultato.AddError(Format('%s (%s)',[E.Message,E.ClassName]));
    end;
  end;

  // data ultimo cedolino chiuso
  LRes.ParametriServizi.DataUltimoCedolinoChiuso:=DATE_NULL;
  try
    selP441_MaxData.SetVariable('PROGRESSIVO',Parametri.ProgressivoOper);
    selP441_MaxData.Execute;
    if selP441_MaxData.RowCount > 0 then
      LRes.ParametriServizi.DataUltimoCedolinoChiuso:=selP441_MaxData.FieldAsDate(0);
    RRisultato.AddInfo(Format('Stampa cedolino - data ultimo cedolino chiuso ok',[]));
  except
    on E: Exception do
    begin
      RRisultato.AddError(Format('Errore nell''estrazione della data ultimo cedolino chiuso: %s (%s)',[E.Message,E.ClassName]));
    end;
  end;

  // altri parametri e dati vari
  LRes.Responsabile:=not Parametri.InibizioneIndividuale;
  RRisultato.AddInfo(Format('Altri parametri ok',[]));
  {$ENDREGION 'Valutazione eventuale filtro anagrafe'}
end;

end.
