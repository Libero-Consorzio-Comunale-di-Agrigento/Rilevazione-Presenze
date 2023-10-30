unit A171UXMLVisiteFiscaliMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, A000UMessaggi,
  C180FunzioniGenerali, Xml.XMLDoc, Xml.xmldom, Xml.XMLIntf, Xml.Win.msxmldom, System.Variants,
  Generics.Collections, Oracle, A000UInterfaccia, FunzioniGenerali, A000UCostanti, StrUtils,
  System.IOUtils, Math;

type
  TA171FXMLVisiteFiscaliMW = class(TR005FDataModuleMW)
    selT430: TOracleDataSet;
    selT480: TOracleDataSet;
    selT049UltimaVisita: TOracleDataSet;
    selP500: TOracleDataSet;
    dsrT480: TDataSource;
    delT049: TOracleQuery;
    selT265_T260: TOracleQuery;
    updT049_ELABORATO: TOracleQuery;
    insT049: TOracleQuery;
    CountT049Richieste: TOracleQuery;
    updT049_CopiaConfig: TOracleQuery;
    selT049NumRec: TOracleQuery;
    selT030_GetProgressivo: TOracleDataSet;
    selT047: TOracleDataSet;
    selT480_Dett: TOracleDataSet;
    selT048: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure AssegnaValore(Nodo:IXMLNode; Valore:string);
    procedure RichiestaRetNodo(NodoPadre:IXMLNode);
  public
    { Public declarations }
    selT049:TOracleDataset;
    T049FiltroPeriodoDa, T049FiltroPeriodoA, T049PeriodoMalattiaDa, T049PeriodoMalattiaA:TDateTime;
    T049FiltroElaborato:string;
    OldDataRichiesta,OldDataVisita:TDateTime;
    OldOraRichiesta,OldConfermaAmb,OldAccettaAttiMed,OldTipoAmbDom,OldOrarioVisita,OldObbligoOrario,OldElaborato,updScript,updMessaggio:String;
    RichiedenteCognome,RichiedenteNome,RichiedenteCodFiscale,RichiedenteTelefono,RichiedenteEMail:string;
    NomeFile,FileName,FilePath:string;
    NumCertificato:Integer;
    VFXML:IXMLDocument;
    ElencoFile:TStringList;
    function PulisciNumero(const Value:string):string;
    function PeriodoMalattiaInFerie(Prog:Integer):string;
    function T049RecordDaElaborare:integer;
    function T049MessaggioCancellazione:string;
    procedure OpenSelT049;
    procedure VerificaPeriodoT049(DataDa, DataA:TDateTime);
    procedure CancellaPeriodoVisiteT049;
    procedure VerificaPeriodoMalT049(DataDa, DataA:string);
    procedure BeforePostSelT049;
    procedure BeforeEditSelT049;
    procedure CalcFieldSelT049;
    procedure CopiaConfigurazione;
    procedure ControlliCopia;
    procedure InsDipSuT049(Visite:Boolean);
    procedure GeneraXML;
    procedure SetVMCINPS;
    procedure Controlli;
    procedure SetElaborato;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA171FXMLVisiteFiscaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selP500.SetVariable('ANNO',R180Anno(R180SysDate(SessioneOracle)));
  selP500.Open;
  R180SetVariable(selT430,'DATA',Trunc(R180SysDate(SessioneOracle)));
  selT430.Open;
  selT480.Open;
  selT480_Dett.Open;

  OldDataRichiesta:=0;
  OldOraRichiesta:='';
  OldConfermaAmb:='';
  OldAccettaAttiMed:='';
  OldTipoAmbDom:='';
  OldDataVisita:=0;
  OldOrarioVisita:='';
  OldObbligoOrario:='';
  OldElaborato:='';

  selT049UltimaVisita.Open;
  ElencoFile:=TStringList.Create;
end;

procedure TA171FXMLVisiteFiscaliMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ElencoFile);
end;

procedure TA171FXMLVisiteFiscaliMW.VerificaPeriodoT049(DataDa, DataA:TDateTime);
begin
  if DataDa <= 0 then
    raise exception.Create('La data filtro periodo Da è errata!')
  else T049FiltroPeriodoDa:= DataDa;
  if DataA <= 0 then
    raise exception.Create('La data filtro periodo A è errata!')
  else T049FiltroPeriodoA:= DataA;
  if T049FiltroPeriodoA < T049FiltroPeriodoDa then
    raise exception.Create('La data filtro periodo Da dev''essere minore di data perido A!');
end;

procedure TA171FXMLVisiteFiscaliMW.OpenSelT049;
begin
  R180SetVariable(selT049,'DATADA', T049FiltroPeriodoDa);
  R180SetVariable(selT049,'DATAA', T049FiltroPeriodoA);
  R180SetVariable(selT049,'ELABORATO', IfThen(T049FiltroElaborato='','',' and T049.ELABORATO = ''' + T049FiltroElaborato + ''''));
  selT049.Open;
end;

procedure TA171FXMLVisiteFiscaliMW.CancellaPeriodoVisiteT049;
begin
  delT049.SetVariable('DATADA', T049FiltroPeriodoDa);
  delT049.SetVariable('DATAA', T049FiltroPeriodoA);
  delT049.SetVariable('ELABORATO', IfThen(T049FiltroElaborato='','',' and T049.ELABORATO = ''' + T049FiltroElaborato + ''''));
  delT049.Execute;
  SessioneOracle.Commit;
end;

procedure TA171FXMLVisiteFiscaliMW.InsDipSuT049(Visite:Boolean);
var DataOra:TDateTime;
  Dataset:TOracleDataset;
  CodComune,CognomeRep:String;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  if Visite then
    Dataset:=selT047
  else
    Dataset:=SelAnagrafe;
  Dataset.First;
  while Not Dataset.Eof do
  begin
    DataOra:=R180SysDate(Sessioneoracle);
    //Verifico che il dipendente non sia stato già inserito
    selT049NumRec.SetVariable('DATA_RICHIESTA',Trunc(DataOra));
    selT049NumRec.SetVariable('PROGRESSIVO',Dataset.FieldByName('PROGRESSIVO').AsInteger);
    selT049NumRec.Execute;
    if selT049NumRec.FieldAsInteger('NUMREC') > 0 then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A171_ERR_FMT_DIPINS,[DataOra.ToString('dd/mm/yyyy')]),'',Dataset.FieldByName('PROGRESSIVO').AsInteger)  //Richiesta visita fiscale già inserita in data %s
    else
    begin
      insT049.ClearVariables;
      insT049.SetVariable('PROGRESSIVO', Dataset.FieldByName('PROGRESSIVO').AsInteger);
      insT049.SetVariable('DATA_RICHIESTA', Trunc(DataOra));
      insT049.SetVariable('ORA_RICHIESTA',DataOra.ToString('hh.nn'));
      insT049.SetVariable('DATA_VISITA', Trunc(DataOra));
      //Valorizzo T049PeriodoMalattiaDa, T049PeriodoMalattiaA per calcolare il se la malattia avviene nel periodo di ferie nel metodo "PeriodoMalattiaInFerie"
      if Visite then
      begin
        T049PeriodoMalattiaDa:=selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime;
        if not selT047.FieldByName('NUOVA_DATA_FINE').IsNull then
          T049PeriodoMalattiaA:=selT047.FieldByName('NUOVA_DATA_FINE').AsDateTime
        else
          T049PeriodoMalattiaA:=selT047.FieldByName('DATA_FINE_ASSENZA').AsDateTime;
        if (Trunc(DataOra) < T049PeriodoMalattiaDa) or
           (Trunc(DataOra) > T049PeriodoMalattiaA) then
          RegistraMsg.InserisciMessaggio('A',A000MSG_A171_ERR_PERIODO_MAL,'',Dataset.FieldByName('PROGRESSIVO').AsInteger);  //Visita fiscale con periodo di malattia che non comprende la data richiesta e la data visita
      end
      else
      begin
        T049PeriodoMalattiaDa:=Trunc(DataOra);
        T049PeriodoMalattiaA:=DATE_NULL;
      end;
      insT049.SetVariable('INIZIO_MAL', T049PeriodoMalattiaDa);
      if not T049PeriodoMalattiaA.IsNull then
        insT049.SetVariable('FINE_MAL', T049PeriodoMalattiaA);
      insT049.SetVariable('MALATTIA_FERIE', PeriodoMalattiaInFerie(Dataset.FieldByName('PROGRESSIVO').AsInteger));
      if Visite then
      begin
        CognomeRep:=selT047.FieldByName('NOMINATIVO').AsString;
        if Trim(CognomeRep) = '' then  //Se nominativo vuoto
        begin
          //Verifico se c'è l'indirizzo di reperibilità sulla richiesta originaria
          selT048.Close;
          selT048.SetVariable('PROGRESSIVO',selT047.FieldByName('PROGRESSIVO').AsInteger);
          selT048.SetVariable('INIZIOMAL',selT047.FieldByName('DATA_INIZIO_ASSENZA').AsDateTime);
          selT048.Open;
          if (selT048.RecordCount > 0) and (selT048.FieldByName('CODCATASTALE_REP').AsString <> '') then   //Se c'è ind.reper. su T048
          begin
            if Trim(selT047.FieldByName('COD_COMUNE').AsString) <> '' then  //Se indirizzo su T047 non vuoto imposto nominativo reper. uguale a quello del certificato originale oppure cognome e nome
            begin
              if (Trim(selT048.FieldByName('COGNOME_REP').AsString) <> '') then
              begin
                CognomeRep:=selT048.FieldByName('COGNOME_REP').AsString;
                RegistraMsg.InserisciMessaggio('I',A000MSG_A171_MSG_COGNOME_REP_ORIG,'',Dataset.FieldByName('PROGRESSIVO').AsInteger);    //Visita fiscale con comune di reperibilità ma senza nominativo di riferimento che è stato impostato uguale al cognome di reperibiltà presente sul certificato originale
              end
              else
              begin
                if selT430.SearchRecord('PROGRESSIVO',Dataset.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
                  CognomeRep:=selT430.FieldByName('COGNOME').AsString + ' ' + selT430.FieldByName('NOME').AsString;
                RegistraMsg.InserisciMessaggio('I',A000MSG_A171_MSG_COGNOME_REP,'',Dataset.FieldByName('PROGRESSIVO').AsInteger);    //Visita fiscale con comune di reperibilità ma senza nominativo di riferimento che è stato impostato uguale al cognome e nome del dipendente
              end;
            end
            else
              RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A171_MSG_REP_ORIGINALE,[selT048.FieldByName('DATI_REP').AsString]),'',Dataset.FieldByName('PROGRESSIVO').AsInteger)  //Visita fiscale senza dati di reperibilità: annullati dall''operatore ma presenti sul certificato originale (%s)
          end
          else if Trim(selT047.FieldByName('COD_COMUNE').AsString) <> '' then  //Ind. rep. su T048 non c'è --> Se indirizzo su T047 non vuoto significa che è quello di domicilio/residenza
          begin
            //Verifico se il comune del certificato è diverso dal comune di domicilio/residenza
            CodComune:='';
            if selT430.SearchRecord('PROGRESSIVO',Dataset.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
            begin
              if Not selT430.FieldByName('COMUNE_DOM_BASE').IsNull then
                CodComune:=selT430.FieldByName('COMUNE_DOM_BASE').AsString
              else
                CodComune:=selT430.FieldByName('COMUNE').AsString;
            end;
            if selT047.FieldByName('COD_COMUNE').AsString <> CodComune then
              RegistraMsg.InserisciMessaggio('I',Format(A000MSG_A171_MSG_COMUNE_DIVERSO,[selT047.FieldByName('DATI_INDIR').AsString]),'',Dataset.FieldByName('PROGRESSIVO').AsInteger);    //Visita fiscale con comune diverso da comune di domicilio/residenza
          end;
        end;
        if Trim(CognomeRep) <> '' then  //Nominativo reperibilità valorizzato
        begin
          insT049.SetVariable('COGNOME_REP', CognomeRep);
          if Trim(selT047.FieldByName('COD_COMUNE').AsString) = '' then
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A171_ERR_FMT_NO_REPERIBILITA,['comune']),'',Dataset.FieldByName('PROGRESSIVO').AsInteger)  //Visita fiscale con nominativo di riferimento ma senza comune di reperibilità
          else
          begin
            if selT480_DETT.SearchRecord('CODICE',selT047.FieldByName('COD_COMUNE').AsString,[srFromBeginning]) then
              insT049.SetVariable('CODCATASTALE_REP', selT480_DETT.FieldByName('CODCATASTALE').AsString)
            else
              RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A171_ERR_COMUNE_NOT480,[selT047.FieldByName('COD_COMUNE').AsString]),'',Dataset.FieldByName('PROGRESSIVO').AsInteger);  //Comune %s non trovato nella tabella di riferimento
          end;
          if Trim(selT047.FieldByName('CAP').AsString) = '' then
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A171_ERR_FMT_NO_REPERIBILITA,['CAP']),'',Dataset.FieldByName('PROGRESSIVO').AsInteger)  //Visita fiscale con nominativo di riferimento ma senza cap di reperibilità
          else
            insT049.SetVariable('CAP_REP', selT047.FieldByName('CAP').AsString);
          if Trim(selT047.FieldByName('INDIRIZZO').AsString) = '' then
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A171_ERR_FMT_NO_REPERIBILITA,['indirizzo']),'',Dataset.FieldByName('PROGRESSIVO').AsInteger)  //Visita fiscale con nominativo di riferimento ma senza indirizzo di reperibilità
          else
            insT049.SetVariable('VIA_REP', selT047.FieldByName('INDIRIZZO').AsString);
        end;
        // MAN/02 SVILUPPO#215.ini
        // aggiunta dei dettagli indirizzo e telefono
        insT049.SetVariable('DETTAGLI_INDIRIZZO', selT047.FieldByName('DETTAGLI_INDIRIZZO').AsString);
        insT049.SetVariable('TELEFONO', selT047.FieldByName('TELEFONO').AsString);
        // MAN/02 SVILUPPO#215.fine
      end
      else
      begin
        // MAN/02 SVILUPPO#215.ini
        // imposta il telefono registrato sulla scheda anagrafica
        if selT430.SearchRecord('PROGRESSIVO',Dataset.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
          insT049.SetVariable('TELEFONO',PulisciNumero(selT430.FieldByName('TELEFONO').AsString));
        // MAN/02 SVILUPPO#215.fine
      end;
      insT049.Execute;
      SessioneOracle.Commit;
    end;
    Dataset.Next;
  end;
  Dataset.First;
end;

procedure TA171FXMLVisiteFiscaliMW.VerificaPeriodoMalT049(DataDa, DataA:string);
begin
  if (DataDa.Trim = '/  /') or (DataDa.Trim = '') then
    raise Exception.Create('La data d''inizio malattia non può essere nulla!');
  if Not TryStrToDateTime(DataDa, T049PeriodoMalattiaDa) then
    raise Exception.Create('La data d''inizio malattia è errata!');
  if (DataA.Trim <> '/  /') and (DataA.Trim <> '') and Not TryStrToDateTime(DataA, T049PeriodoMalattiaA) then
    raise Exception.Create('La data di fine malattia è errata!');
  if (DataDa.Trim <> '/  /') and (DataA.Trim <> '/  /') and (DataDa.Trim <> '') and (DataA.Trim <> '') and (T049PeriodoMalattiaA < T049PeriodoMalattiaDa) then
    raise Exception.Create('La data d''inizio malattia dev''essere minore della data di fine malattia!');
end;

procedure TA171FXMLVisiteFiscaliMW.BeforePostSelT049;
begin
  VerificaPeriodoMalT049(selT049.FieldByName('INIZIO_MAL').AsString, selT049.FieldByName('FINE_MAL').AsString);

  // MAN/02 SVILUPPO#215.ini
  // trim del valore di dettagli indirizzo
  selT049.FieldByName('DETTAGLI_INDIRIZZO').AsString:=selT049.FieldByName('DETTAGLI_INDIRIZZO').AsString.Trim;
  // MAN/02 SVILUPPO#215.fine

  //Verifico stato dati della reperibilità - valorizzare tutti i campi o nessun campo
  if (selT049.FieldByName('CODCATASTALE_REP').IsNull or selT049.FieldByName('CAP_REP').IsNull or
      selT049.FieldByName('VIA_REP').IsNull or selT049.FieldByName('COGNOME_REP').IsNull) and
    (not selT049.FieldByName('CODCATASTALE_REP').IsNull or not selT049.FieldByName('CAP_REP').IsNull or
     not selT049.FieldByName('VIA_REP').IsNull or not selT049.FieldByName('COGNOME_REP').IsNull) then
    raise Exception.Create('Valorizzare tutti i campi della reperibilità!');

  // controlli su data richiesta
  if (selT049.FieldByName('DATA_RICHIESTA').AsDateTime < selT049.FieldByName('INIZIO_MAL').AsDateTime) or
    ((not selT049.FieldByName('FINE_MAL').IsNull) and (selT049.FieldByName('DATA_RICHIESTA').AsDateTime > selT049.FieldByName('FINE_MAL').AsDateTime)) then
    raise Exception.Create('La data richiesta non è compresa nel periodo di malattia!');

  // controlli su data visita
  if (selT049.FieldByName('DATA_VISITA').AsDateTime < selT049.FieldByName('INIZIO_MAL').AsDateTime) or
    ((not selT049.FieldByName('FINE_MAL').IsNull) and (selT049.FieldByName('DATA_VISITA').AsDateTime > selT049.FieldByName('FINE_MAL').AsDateTime)) then
    raise Exception.Create('La data visita non è compresa nel periodo di malattia!');

  if (selT049.FieldByName('DATA_VISITA').OldValue <> selT049.FieldByName('DATA_VISITA').Value) and
     (selT049.FieldByName('DATA_VISITA').AsDateTime < Trunc(R180SysDate(SessioneOracle))) then
    raise Exception.Create('La data visita dev''essere successiva o uguale alla data odierna!');
end;

function TA171FXMLVisiteFiscaliMW.PeriodoMalattiaInFerie(Prog:Integer):string;
begin
  Result:='N';
  selT265_T260.SetVariable('PROGRESSIVO', Prog);
  selT265_T260.SetVariable('DATADA', T049PeriodoMalattiaDa);
  if T049PeriodoMalattiaA.IsNull then
    selT265_T260.SetVariable('DATAA', null)
  else
    selT265_T260.SetVariable('DATAA', T049PeriodoMalattiaA);
  selT265_T260.Execute;
  if selT265_T260.FieldAsInteger('MALATTIA_FERIE') > 0 then
    Result:='S';
end;

procedure TA171FXMLVisiteFiscaliMW.CopiaConfigurazione;
begin
  updT049_CopiaConfig.ClearVariables;
  updT049_CopiaConfig.SetVariable('AGGIORNA',updScript);
  updT049_CopiaConfig.SetVariable('DATADA',T049FiltroPeriodoDa);
  updT049_CopiaConfig.SetVariable('DATAA',T049FiltroPeriodoA);
  updT049_CopiaConfig.SetVariable('ELABORATO', IfThen(T049FiltroElaborato='','',' and T049.ELABORATO = ''' + T049FiltroElaborato + ''''));
  updT049_CopiaConfig.Execute;
  SessioneOracle.Commit;
end;

procedure TA171FXMLVisiteFiscaliMW.BeforeEditSelT049;
begin
  OldDataRichiesta:=selT049.FieldByName('DATA_RICHIESTA').AsDateTime;
  OldOraRichiesta:=selT049.FieldByName('ORA_RICHIESTA').AsString;
  OldConfermaAmb:=selT049.FieldByName('CONFERMA_AMB').AsString;
  OldAccettaAttiMed:=selT049.FieldByName('ACCETTA_ATTI_MED').AsString;
  OldTipoAmbDom:=selT049.FieldByName('TIPO_AMB_DOM').AsString;
  OldDataVisita:=selT049.FieldByName('DATA_VISITA').AsDateTime;
  OldOrarioVisita:=selT049.FieldByName('ORARIO_VISITA').AsString;
  OldObbligoOrario:=selT049.FieldByName('OBBLIGO_ORARIO').AsString;
  OldElaborato:=selT049.FieldByName('ELABORATO').AsString;
end;

procedure TA171FXMLVisiteFiscaliMW.Controlli;
begin
  //Verifico che ci siano all'interno del periodo specificato, record da elaborare
  if T049RecordDaElaborare <= 0 then
    raise Exception.Create('Non ci sono visite fiscali da elaborare!');
  //Campi richiedente obbligatori
  if Trim(RichiedenteCognome).IsEmpty then
    raise Exception.Create('Specificare il cognome del richiedente!');
  if Trim(RichiedenteNome).IsEmpty then
    raise Exception.Create('Specificare il nome del richiedente!');
  if Trim(RichiedenteCodFiscale).IsEmpty then
    raise Exception.Create('Specificare il codice fiscale del richiedente!');
  if Trim(RichiedenteEMail).IsEmpty then
    raise Exception.Create('Specificare l''E-Mail del richiedente!');
  if Trim(RichiedenteTelefono).IsEmpty then
    raise Exception.Create('Specificare il telefono del richiedente!');
  //Verifico che il percorso file sia specificato
  if Trim(NomeFile).IsEmpty then
    raise Exception.Create(A000MSG_ERR_SPEC_NOME_FILE);
  //Verifico che il percorso file specificato sia valido
  FilePath:=ExtractFilePath(NomeFile);
  FileName:=ExtractFileName(NomeFile);
  if Not TDirectory.Exists(FilePath) then
    raise Exception.Create(Format(A000MSG_ERR_FMT_CREA_DIR,[FilePath]));
end;

procedure TA171FXMLVisiteFiscaliMW.ControlliCopia;
begin
  updScript:='';
  updMessaggio:='';
  if (OldDataRichiesta <> 0) and (OldDataRichiesta <> selT049.FieldByName('DATA_RICHIESTA').AsDateTime) then
  begin
    updScript:='DATA_RICHIESTA = TO_DATE(''' + selT049.FieldByName('DATA_RICHIESTA').AsString + ''',''DD/MM/YYYY'')';
    updMessaggio:='Data richiesta ' + selT049.FieldByName('DATA_RICHIESTA').AsString;
  end;
  if (OldOraRichiesta <> '') and (OldOraRichiesta <> selT049.FieldByName('ORA_RICHIESTA').AsString) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'ORA_RICHIESTA = ''' + selT049.FieldByName('ORA_RICHIESTA').AsString + '''';
    updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Ora richiesta ' + selT049.FieldByName('ORA_RICHIESTA').AsString;
  end;
  if (OldElaborato <> '') and (OldElaborato <> selT049.FieldByName('ELABORATO').AsString) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'ELABORATO = ''' + selT049.FieldByName('ELABORATO').AsString + '''';
    updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Elaborato ' + IfThen(selT049.FieldByName('ELABORATO').AsString='S','Attivato','Disattivato');
  end;
  if (OldTipoAmbDom <> '') and (OldTipoAmbDom <> selT049.FieldByName('TIPO_AMB_DOM').AsString) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'TIPO_AMB_DOM = ''' + selT049.FieldByName('TIPO_AMB_DOM').AsString + '''';
    updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Tipo visita ' + IfThen(selT049.FieldByName('TIPO_AMB_DOM').AsString='A','Ambulatoriale','Domiciliare');
  end;
  if (OldDataVisita <> 0) and (OldDataVisita <> selT049.FieldByName('DATA_VISITA').AsDateTime) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'DATA_VISITA = TO_DATE(''' + selT049.FieldByName('DATA_VISITA').AsString + ''',''DD/MM/YYYY'')';
    updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Data visita ' + selT049.FieldByName('DATA_VISITA').AsString;
  end;
  if (OldConfermaAmb <> '') and (OldConfermaAmb <> selT049.FieldByName('CONFERMA_AMB').AsString) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'CONFERMA_AMB = ''' + selT049.FieldByName('CONFERMA_AMB').AsString + '''';
    updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Conferma ambulatoriale ' + IfThen(selT049.FieldByName('CONFERMA_AMB').AsString='S','Attivato','Disattivato');
  end;
  if (OldAccettaAttiMed <> '') and (OldAccettaAttiMed <> selT049.FieldByName('ACCETTA_ATTI_MED').AsString) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'ACCETTA_ATTI_MED = ''' + selT049.FieldByName('ACCETTA_ATTI_MED').AsString + '''';
    updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Accetta atti medici ' + IfThen(selT049.FieldByName('ACCETTA_ATTI_MED').AsString='S','Attivato','Disattivato');
  end;
  if (OldOrarioVisita <> '') and (OldOrarioVisita <> selT049.FieldByName('ORARIO_VISITA').AsString) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'ORARIO_VISITA = ''' + selT049.FieldByName('ORARIO_VISITA').AsString + '''';
    if selT049.FieldByName('ORARIO_VISITA').AsString = 'A' then
      updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Orario visita Antimeridiana'
    else if selT049.FieldByName('ORARIO_VISITA').AsString = 'P' then
      updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Orario visita Pomeridiana'
    else
      updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Orario visita Nessuna'
  end;
  if (OldObbligoOrario <> '') and (OldObbligoOrario <> selT049.FieldByName('OBBLIGO_ORARIO').AsString) then
  begin
    updScript:=IfThen(updScript<>'',updScript + ', ') + 'OBBLIGO_ORARIO = ''' + selT049.FieldByName('OBBLIGO_ORARIO').AsString + '''';
    updMessaggio:=IfThen(updMessaggio<>'',updMessaggio + ', ') + 'Obbligo orario ' + IfThen(selT049.FieldByName('OBBLIGO_ORARIO').AsString='S','Obbligatorio','NON Obbligatorio');
  end;
  if updScript = '' then
    raise Exception.Create('Non è stato variato alcun dato di dettaglio visita!');
end;

procedure TA171FXMLVisiteFiscaliMW.CalcFieldSelT049;
var IndComuneCap:string;
  LDatiRep: Boolean;
  LCampoDettIndirizzo: String;
begin
  //Costruzione indirizzo - comune - CAP in base alla tabella T430_STORICO
  if selT430.SearchRecord('PROGRESSIVO',selT049.FieldByName('PROGRESSIVO').AsString,[srFromBeginning]) then
  begin
    if (Not selT430.FieldByName('COMUNE_DOM_BASE').IsNull) and (Not selT430.FieldByName('CAP_DOM_BASE').IsNull) and
       (Not selT430.FieldByName('INDIRIZZO_DOM_BASE').IsNull) then
    begin
      IndComuneCap:=selT430.FieldByName('INDIRIZZO_DOM_BASE').AsString;
      if Not selT430.FieldByName('CITTA_DOM').IsNull then
        IndComuneCap:=IndComuneCap + Format(' - %s',[selT430.FieldByName('CITTA_DOM').AsString]);
      if Not selT430.FieldByName('CAP_DOM_BASE').IsNull then
        IndComuneCap:=IndComuneCap + Format('(%s)',[selT430.FieldByName('CAP_DOM_BASE').AsString]);
    end
    else
    begin
      IndComuneCap:=selT430.FieldByName('INDIRIZZO').AsString;
      if Not selT430.FieldByName('CITTA').IsNull then
        IndComuneCap:=IndComuneCap + Format(' - %s',[selT430.FieldByName('CITTA').AsString]);
      if Not selT430.FieldByName('CAP').IsNull then
        IndComuneCap:=IndComuneCap + Format('(%s)',[selT430.FieldByName('CAP').AsString]);
    end;
    selT049.FieldByName('IndComuneCAP').AsString:=IndComuneCap;

    // telefono
    if selT049.FieldByName('TELEFONO').AsString = '' then
      selT049.FieldByName('D_TELEFONO').AsString:=PulisciNumero(selT430.FieldByName('TELEFONO').AsString.Trim)
    else
      selT049.FieldByName('D_TELEFONO').AsString:=selT049.FieldByName('TELEFONO').AsString;
  end;

  // determina se sono indicati i dati di reperibilità
  LDatiRep:=(Trim(selT049.FieldByName('CODCATASTALE_REP').AsString) <> '') and
            (Trim(selT049.FieldByName('CAP_REP').AsString) <> '') and
            (Trim(selT049.FieldByName('COGNOME_REP').AsString) <> '') and
            (Trim(selT049.FieldByName('VIA_REP').AsString) <> '');

  LCampoDettIndirizzo:=IfThen(LDatiRep,'D_DETTAGLI_INDIRIZZO_REP','D_DETTAGLI_INDIRIZZO');
  selT049.FieldByName(LCampoDettIndirizzo).AsString:=selT049.FieldByName('DETTAGLI_INDIRIZZO').AsString;

  //Estraggo la data di ultima visita
  selT049UltimaVisita.Refresh;
  if (selT049UltimaVisita.SearchRecord('PROGRESSIVO',selT049.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning])) and
     (Not selT049UltimaVisita.FieldByName('ULTIMA_VISITA').IsNull) then
    selT049.FieldByName('DataUltimaVisita').AsDateTime:=selT049UltimaVisita.FieldByName('ULTIMA_VISITA').AsDateTime;
end;

function TA171FXMLVisiteFiscaliMW.T049MessaggioCancellazione: string;
begin
  Result:=Format(A000MSG_A171_DLG_FMT_CANCELLAZIONE,[IntToStr(selT049.RecordCount),DateToStr(T049FiltroPeriodoDa),DateToStr(T049FiltroPeriodoA)]);
end;

function TA171FXMLVisiteFiscaliMW.T049RecordDaElaborare:integer;
begin
  CountT049Richieste.SetVariable('DATADA',T049FiltroPeriodoDa);
  CountT049Richieste.SetVariable('DATAA',T049FiltroPeriodoA);
  CountT049Richieste.Execute;
  Result:=CountT049Richieste.FieldAsInteger('NUMREC');
end;

function TA171FXMLVisiteFiscaliMW.PulisciNumero(const Value:string):string;
var
  i:integer;
begin
  Result:='';
  for i:=0 to Value.Length do
  begin
    if R180In(Value.Substring(i,1),['0','1','2','3','4','5','6','7','8','9']) then
    begin
      Result:=Result + Value.Substring(i,1);
    end;
  end;
end;

procedure TA171FXMLVisiteFiscaliMW.AssegnaValore(Nodo:IXMLNode; Valore:string);
begin
  if Not Valore.IsEmpty then
    Nodo.Text:=Valore;
end;

procedure TA171FXMLVisiteFiscaliMW.GeneraXML;
var RootNode,Node1,MainNode:IXMLNODE;
  i:integer;
  FileFinale:String;

  procedure GeneraTestata;
  begin
    //InizializzaDocumento;
    VFXML:=NewXMLDocument('1.0');
    VFXML.Encoding:='iso-8859-1';
    VFXML.Options:=[doNodeAutoIndent];
    RootNode:=VFXML.AddChild('inps-bkm');
    RootNode.DeclareNamespace('vmc','http://ws.inps.it/schema/vmc/VMC_InvioRichieste_Input.xsd');
    //Richiedente.RetNodo(RootNode);
    if Not RichiedenteCognome.IsEmpty and Not RichiedenteNome.IsEmpty and Not RichiedenteCodFiscale.IsEmpty then
    begin
      MainNode:=RootNode.AddChild('richiedente');
      Node1:=MainNode.AddChild('cognome');
      AssegnaValore(Node1,Copy(RichiedenteCognome,1,60));
      Node1:=MainNode.AddChild('nome');
      AssegnaValore(Node1,Copy(RichiedenteNome,1,60));
      Node1:=MainNode.AddChild('codice-fiscale');
      AssegnaValore(Node1,RichiedenteCodFiscale);
    end;
    MainNode:=RootNode.AddChild('richieste');
    if T049RecordDaElaborare <= 50 then
      MainNode.Attributes['numero']:=T049RecordDaElaborare.ToString
    else
    begin
      if NumCertificato = 0 then
        MainNode.Attributes['numero']:=50
      else
        MainNode.Attributes['numero']:=IntToStr(Min(50,T049RecordDaElaborare - (50 * NumCertificato)));
    end;
  end;
begin
  RegistraMsg.IniziaMessaggio(NomeOwner);
  i:=1;
  NumCertificato:=0;
  ElencoFile.Clear;
  selT049.First;
  while not selT049.Eof do
  begin
    if selT049.FieldByName('ELABORATO').AsString = 'N' then
    begin
      //Se sono alla fine del dataset o al 50 record creo il file - 50 è il numero massimo di richieste visite fiscali inviabile per file
      if i > 50 then  //Operazioni finali
      begin
        SetVMCINPS;
        if NumCertificato = 0 then
          FileFinale:=Trim(Format('%s%s%s',[FilePath,FileName.Trim.Substring(0,FileName.Trim.Length - 4),ExtractFileExt(NomeFile)]))
        else
          FileFinale:=Trim(Format('%s%s_%d%s',[FilePath,FileName.Trim.Substring(0,FileName.Trim.Length - 4),NumCertificato,ExtractFileExt(NomeFile)]));
        if not RegistraMsg.ContieneTipoA then
        begin
          VFXML.XML.SaveToFile(FileFinale);
          ElencoFile.Add(FileFinale);
        end;
        Inc(NumCertificato);
        i:=1;
        selT049.Prior;
      end
      else
      begin
        if i = 1 then  //Operazioni iniziali
          GeneraTestata;
        selT030_GetProgressivo.SetVariable('DECORRENZA',Trunc(R180SysDate(SessioneOracle)));
        selT030_GetProgressivo.SetVariable('CODFISCALE',selT049.FieldByName('CODFISCALE').AsString);
        selT030_GetProgressivo.Open;
        if selT030_GetProgressivo.RecordCount > 1 then
          RegistraMsg.InserisciMessaggio('A', Format('Il codice fiscale "%s" è associato a più di un dipendente in servizio!',[selT049.FieldByName('CODFISCALE').AsString]), '', selT049.FieldByName('PROGRESSIVO').AsInteger);
        selT030_GetProgressivo.Close;
        RichiestaRetNodo(MainNode);
        inc(i);
      end;
    end;
    selT049.Next;
  end;
  //Operazioni finali per eof
  SetVMCINPS;
  if NumCertificato = 0 then
    FileFinale:=Trim(Format('%s%s%s',[FilePath,FileName.Trim.Substring(0,FileName.Trim.Length - 4),ExtractFileExt(NomeFile)]))
  else
    FileFinale:=Trim(Format('%s%s_%d%s',[FilePath,FileName.Trim.Substring(0,FileName.Trim.Length - 4),NumCertificato,ExtractFileExt(NomeFile)]));
  if not RegistraMsg.ContieneTipoA then
  begin
    VFXML.XML.SaveToFile(FileFinale);
    ElencoFile.Add(FileFinale);
  end;
end;

procedure TA171FXMLVisiteFiscaliMW.RichiestaRetNodo(NodoPadre:IXMLNode);
var MainNodeRich,MainNode1,MainNode,Node1:IXMLNODE;
  Comune,Provincia,DescProvincia, CAP,DenominazioneStradale,CodiceCatastale,Telefono:String;
  DataRichiesta:TDateTime;
  OraRichiesta:string;
  LDatiRep: Boolean;
begin
  inherited;
  MainNodeRich:=NodoPadre.AddChild('richiesta');
  // --------------------  Impresa.RetNodo(MainNode);
  selP500.SearchRecord('COD_AZIENDA_BASE',VarToStr(selT430.LookUp('PROGRESSIVO',selT049.FieldByName('PROGRESSIVO').AsInteger,'AZIENDA_BASE')),[srFromBeginning]);
  MainNode1:=MainNodeRich.AddChild('impresa');
  //forma-giuridica
  Node1:=MainNode1.AddChild('forma-giuridica');
  Node1.Attributes['codice']:='ENTE';
  AssegnaValore(Node1,selP500.FieldByName('DENOMINAZIONE').AsString);
  //ragione sociale
  Node1:=MainNode1.AddChild('ragione-sociale');
  AssegnaValore(Node1,selP500.FieldByName('DENOMINAZIONE').AsString);
  if Trim(selP500.FieldByName('DENOMINAZIONE').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'La ragione sociale dell''azienda ' + selP500.FieldByName('COD_AZIENDA_BASE').AsString + ' non può essere nulla!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //codice-fiscale
  Node1:=MainNode1.AddChild('codice-fiscale');
  AssegnaValore(Node1,selP500.FieldByName('COD_FISCALE').AsString);
  //partita-iva
  Node1:=MainNode1.AddChild('partita-iva');
  AssegnaValore(Node1,selP500.FieldByName('COD_FISCALE').AsString);
  if Trim(selP500.FieldByName('COD_FISCALE').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'Il codice fiscale dell''azienda ' + selP500.FieldByName('COD_AZIENDA_BASE').AsString + ' non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //matricola INPS
  Node1:=MainNode1.AddChild('matricola');
  AssegnaValore(Node1,selP500.FieldByName('MATRICOLA_INPS').AsString);
  if Trim(selP500.FieldByName('MATRICOLA_INPS').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'La matricola INPS dell''azienda ' + selP500.FieldByName('COD_AZIENDA_BASE').AsString + ' non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //--- impresa->indirizzo
  MainNode:=MainNode1.AddChild('indirizzo');
  if selT480_DETT.SearchRecord('CODCATASTALE',selP500.FieldByName('COD_COMUNE').AsString,[srFromBeginning]) then
  begin
    Comune:=selT480_DETT.FieldByName('CITTA').AsString;
    Provincia:=selT480_DETT.FieldByName('COD_PROVINCIA').AsString;
    DescProvincia:=selT480_DETT.FieldByName('DESCRIZIONE').AsString;
  end;
  Node1:=MainNode.AddChild('provincia');
  Node1.Attributes['sigla']:=Provincia;
  AssegnaValore(Node1,DescProvincia);
  //provincia codice\descrizione
  if Provincia.IsEmpty then
    RegistraMsg.InserisciMessaggio('A', 'La provincia dell''azienda ' + selP500.FieldByName('COD_AZIENDA_BASE').AsString + ' non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //comune codice catastale\descrizione
  Node1:=MainNode.AddChild('comune');
  Node1.Attributes['codice-catastale']:=selP500.FieldByName('COD_COMUNE').AsString;
  AssegnaValore(Node1,Comune);
  if (Trim(selP500.FieldByName('COD_COMUNE').AsString) = '') or (Trim(Comune) = '') then
    RegistraMsg.InserisciMessaggio('A', 'Il comune dell''azienda ' + selP500.FieldByName('COD_AZIENDA_BASE').AsString + ' non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //CAP
  Node1:=MainNode.AddChild('cap');
  AssegnaValore(Node1,selP500.FieldByName('CAP').AsString);
  if Trim(selP500.FieldByName('CAP').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'Il CAP dell''azienda ' + selP500.FieldByName('COD_AZIENDA_BASE').AsString + ' non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //Denominazione stradale(indirizzo)
  Node1:=MainNode.AddChild('denominazione-stradale');
  AssegnaValore(Node1,Copy(selP500.FieldByName('INDIRIZZO').AsString,1,60));
  if Trim(selP500.FieldByName('INDIRIZZO').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'L''indirizzo dell''azienda ' + selP500.FieldByName('COD_AZIENDA_BASE').AsString + ' non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //E-Mail
  Node1:=MainNode.AddChild('e-mail');
  AssegnaValore(Node1,RichiedenteEMail);
  //Telefono(ufficio)
  Node1:=MainNode.AddChild('telefono');
  Node1.Attributes['tipo']:='Ufficio';
  AssegnaValore(Node1,RichiedenteTelefono);
  {==>Disabilitato PER ORA(a PARMA non SERVE)<==
  Node1:=Result.AddChild('telefono');
  Node1.Attributes['tipo']:='Fax';
  AssegnaValore(Node1,TelefonoFax);}
  Node1:=MainNode1.AddChild('rapporto-inps');
  AssegnaValore(Node1,'true');
  Node1:=MainNode1.AddChild('datore-pa');
  AssegnaValore(Node1,'true');
  {Nodo PER ORA disabilitato
  Node1:=MainNode.AddChild('requisiti-polo-unico');
  AssegnaValore(Node1,RequisitiPoloUnico.toString);}

  //----------------------------  Lavoratore.RetNodo(MainNode);
  MainNode1:=MainNodeRich.AddChild('lavoratore');
  //Cognome
  Node1:=MainNode1.AddChild('cognome');
  AssegnaValore(Node1,Copy(selT049.FieldByName('COGNOME').AsString,1,60));
  if Trim(selT049.FieldByName('COGNOME').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'Il cognome del lavoratore non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //Nome
  Node1:=MainNode1.AddChild('nome');
  AssegnaValore(Node1,Copy(selT049.FieldByName('NOME').AsString,1,60));
  if Trim(selT049.FieldByName('NOME').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'Il nome del lavoratore non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //codice-fiscale
  Node1:=MainNode1.AddChild('codice-fiscale');
  AssegnaValore(Node1,selT049.FieldByName('CODFISCALE').AsString);
  if Trim(selT049.FieldByName('CODFISCALE').AsString) = '' then
    RegistraMsg.InserisciMessaggio('A', 'Il codice fiscale del lavoratore non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //---  Residenza.RetNodo(MainNode);
  MainNode:=MainNode1.AddChild('residenza');
  if selT430.SearchRecord('PROGRESSIVO',selT049.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
  begin
    if (Not selT430.FieldByName('COMUNE_DOM_BASE').IsNull) and (Not selT430.FieldByName('CAP_DOM_BASE').IsNull) and
       (Not selT430.FieldByName('INDIRIZZO_DOM_BASE').IsNull) then
    begin
      CodiceCatastale:=selT430.FieldByName('CODICE_DOM').AsString;
      Comune:=selT430.FieldByName('CITTA_DOM').AsString;
      CAP:=selT430.FieldByName('CAP_DOM_BASE').AsString;
      DenominazioneStradale:=selT430.FieldByName('INDIRIZZO_DOM_BASE').AsString;
      Provincia:=selT430.FieldByName('PROV_DOM').AsString;
      DescProvincia:=selT430.FieldByName('DESC_PROV_DOM').AsString;
    end
    else
    begin
      CodiceCatastale:=selT430.FieldByName('CODICE_RES').AsString;
      Comune:=selT430.FieldByName('CITTA').AsString;
      CAP:=selT430.FieldByName('CAP').AsString;
      DenominazioneStradale:=selT430.FieldByName('INDIRIZZO').AsString;
      Provincia:=selT430.FieldByName('PROV_RES').AsString;
      DescProvincia:=selT430.FieldByName('DESC_PROV_RES').AsString;
    end;
    Telefono:=PulisciNumero(selT430.FieldByName('TELEFONO').AsString.Trim);
  end;
  // MAN/02 SVILUPPO#215.ini
  // sovrascrive telefono se ridefinito
  if selT049.FieldByName('TELEFONO').AsString.Trim <> '' then
  begin
    Telefono:=PulisciNumero(selT049.FieldByName('TELEFONO').AsString.Trim);
  end;
  // MAN/02 SVILUPPO#215.fine

  //provincia codice\descrizione
  Node1:=MainNode.AddChild('provincia');
  Node1.Attributes['sigla']:=Provincia;
  AssegnaValore(Node1,DescProvincia);
  if Provincia.IsEmpty then
    RegistraMsg.InserisciMessaggio('A', 'La provincia del lavoratore non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //comune codice\descrizione
  Node1:=MainNode.AddChild('comune');
  Node1.Attributes['codice-catastale']:=CodiceCatastale;
  AssegnaValore(Node1,Comune);
  if CodiceCatastale.IsEmpty then
    RegistraMsg.InserisciMessaggio('A', 'Il comune del lavoratore non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //cap
  Node1:=MainNode.AddChild('cap');
  AssegnaValore(Node1,CAP);
  if CAP.IsEmpty then
    RegistraMsg.InserisciMessaggio('A', 'Il CAP del lavoratore non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //indirizzo
  Node1:=MainNode.AddChild('denominazione-stradale');
  AssegnaValore(Node1,Copy(DenominazioneStradale,1,60));
  if DenominazioneStradale.IsEmpty then
    RegistraMsg.InserisciMessaggio('A', 'L''indirizzo del lavoratore non può essere nullo!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);

  // MAN/02 SVILUPPO#215.ini
  LDatiRep:=(Trim(selT049.FieldByName('CODCATASTALE_REP').AsString) <> '') and
            (Trim(selT049.FieldByName('CAP_REP').AsString) <> '') and
            (Trim(selT049.FieldByName('COGNOME_REP').AsString) <> '') and
            (Trim(selT049.FieldByName('VIA_REP').AsString) <> '');

  // aggiunta dei dati telefono e dettagli-indirizzo

  // telefono
  if Telefono <> '' then
  begin
    Node1:=MainNode.AddChild('telefono');
    Node1.Attributes['tipo']:='Abitazione';
    // PRE: Length(Telefono) < 16
    AssegnaValore(Node1,Telefono);
  end;

  // dettagli-indirizzo
  // se è impostato il dato ma non sono indicati gli altri dati di reperibilità lo utilizza come info di residenza
  if (selT049.FieldByName('DETTAGLI_INDIRIZZO').AsString <> '') and
     (not LDatiRep) then
  begin
    Node1:=MainNode.AddChild('dettagli-indirizzo');
    AssegnaValore(Node1,Copy(selT049.FieldByName('DETTAGLI_INDIRIZZO').AsString,1,50));
  end;

  // MAN/02 SVILUPPO#215.fine

  //---------------------    Reperibilita.RetNodo(MainNode);
  {
  if (Trim(selT049.FieldByName('CODCATASTALE_REP').AsString) <> '') and (Trim(selT049.FieldByName('CAP_REP').AsString) <> '') and
     (Trim(selT049.FieldByName('COGNOME_REP').AsString) <> '') and (Trim(selT049.FieldByName('VIA_REP').AsString) <> '') then
  }
  if LDatiRep then
  begin
    if selT480_DETT.SearchRecord('CODCATASTALE',selT049.FieldByName('CODCATASTALE_REP').AsString,[srFromBeginning]) then
    begin
      Comune:=selT480_DETT.FieldByName('CITTA').AsString;
      Provincia:=selT480_DETT.FieldByName('COD_PROVINCIA').AsString;
      DescProvincia:=selT480_DETT.FieldByName('DESCRIZIONE').AsString;
    end;
    MainNode:=MainNode1.AddChild('reperibilita');
    Node1:=MainNode.AddChild('provincia');
    Node1.Attributes['sigla']:=Provincia;
    AssegnaValore(Node1,DescProvincia);
    Node1:=MainNode.AddChild('comune');
    Node1.Attributes['codice-catastale']:=selT049.FieldByName('CODCATASTALE_REP').AsString;
    AssegnaValore(Node1,Comune);
    Node1:=MainNode.AddChild('cap');
    AssegnaValore(Node1,selT049.FieldByName('CAP_REP').AsString);
    Node1:=MainNode.AddChild('denominazione-stradale');
    AssegnaValore(Node1,Copy(selT049.FieldByName('VIA_REP').AsString,1,60));

    // MAN/02 SVILUPPO#215.ini
    // aggiunta del dato dettagli-indirizzo
    if selT049.FieldByName('DETTAGLI_INDIRIZZO').AsString <> '' then
    begin
      Node1:=MainNode.AddChild('dettagli-indirizzo');
      AssegnaValore(Node1,Copy(selT049.FieldByName('DETTAGLI_INDIRIZZO').AsString,1,50));
    end;
    // MAN/02 SVILUPPO#215.fine

    Node1:=MainNode.AddChild('cognome');
    AssegnaValore(Node1,Copy(selT049.FieldByName('COGNOME_REP').AsString,1,60));
    //ReperibilitaComunicataLavoratore.RetNodo(MainNode);
    MainNode:=MainNode1.AddChild('reperibilita-comunicata-lavoratore');
    Node1:=MainNode.AddChild('check-accetta-reperibilita-com-lav');
    AssegnaValore(Node1,'true');
  end;

  //-----------------------------  Visita.RetNodo(MainNode);
  MainNode1:=MainNodeRich.AddChild('visita');
  //RichiestaAzienda.RetNodo(MainNode);
  DataRichiesta:=Trunc(selT049.FieldByName('DATA_RICHIESTA').AsDateTime);
  OraRichiesta:=(selT049.FieldByName('ORA_RICHIESTA').AsString).Replace('.',':',[rfReplaceAll]) + ':00';
  MainNode:=MainNode1.AddChild('richiestaAzienda');
  //Data
  Node1:=MainNode.AddChild('data');
  AssegnaValore(Node1,DataRichiesta.ToString('YYYY-MM-DD'));
  if DataRichiesta.IsNull then
    RegistraMsg.InserisciMessaggio('A', 'La data della richiesta non può essere nulla!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //ora
  Node1:=MainNode.AddChild('ora');
  AssegnaValore(Node1,OraRichiesta);
  if OraRichiesta.isEmpty then
    RegistraMsg.InserisciMessaggio('A', 'L''ora della richiesta non può essere nulla!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  //
  Node1:=MainNode1.AddChild('diritto-indennita-malattia');
  AssegnaValore(Node1,'false');
  Node1:=MainNode1.AddChild('lavoratore-pubblico');
  AssegnaValore(Node1,'true');
  Node1:=MainNode1.AddChild('conferma-ambulatoriale');
  AssegnaValore(Node1,Ifthen(selT049.FieldByName('CONFERMA_AMB').AsString = 'S','true','false'));
  Node1:=MainNode1.AddChild('accetta-atti-medici');
  AssegnaValore(Node1,IfThen(selT049.FieldByName('ACCETTA_ATTI_MED').AsString = 'S','true','false'));
  Node1:=MainNode1.AddChild('tipo');
  AssegnaValore(Node1,selT049.FieldByName('TIPO_AMB_DOM').AsString);
  //  RichiestaVisita.RetNodo(MainNode);
  MainNode:=MainNode1.AddChild('richiestaVisita');
  Node1:=MainNode.AddChild('data');
  if Not selT049.FieldByName('DATA_VISITA').IsNull then
    AssegnaValore(Node1,(selT049.FieldByName('DATA_VISITA').AsDateTime).ToString('YYYY-MM-DD'))
  else
    RegistraMsg.InserisciMessaggio('A', 'La data visita non può essere nulla!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  Node1:=MainNode.AddChild('orario');
  AssegnaValore(Node1,selT049.FieldByName('ORARIO_VISITA').AsString);
  Node1:=MainNode.AddChild('obbligo-orario');
  AssegnaValore(Node1,selT049.FieldByName('OBBLIGO_ORARIO').AsString);
  //Non si puo' richiedere una visita fiscale dopo le ore 11:59 del giorno della visita
  if selT049.FieldByName('DATA_VISITA').AsDateTime = Trunc(R180SysDate(SessioneOracle)) then
  begin
    if Frac(R180SysDate(SessioneOracle)) > EncodeTime(11,59,00,00) then
      RegistraMsg.InserisciMessaggio('A', 'Non si puo'' richiedere una visita fiscale dopo le ore 11:59 del giorno della visita!', '', selT049.FieldByName('PROGRESSIVO').AsInteger);
  end;
  // Malattia.RetNodo(MainNode);
  MainNode:=MainNode1.AddChild('malattia');
  MainNode.Attributes['ferie']:=IfThen(selT049.FieldByName('MALATTIA_FERIE').AsString = 'S','true','false');
  Node1:=MainNode.AddChild('data-inizio');
  if selT049.FieldByName('INIZIO_MAL').IsNull then
    RegistraMsg.InserisciMessaggio('A', 'La data d''inizio malattia non può essere nulla!', '', selT049.FieldByName('PROGRESSIVO').AsInteger)
  else
    AssegnaValore(Node1,(selT049.FieldByName('INIZIO_MAL').AsDateTime).ToString('YYYY-MM-DD'));
  if Not selT049.FieldByName('FINE_MAL').IsNull then
  begin
    Node1:=MainNode.AddChild('data-fine');
    AssegnaValore(Node1,(selT049.FieldByName('FINE_MAL').AsDateTime).ToString('YYYY-MM-DD'));
  end;
end;

procedure TA171FXMLVisiteFiscaliMW.SetVMCINPS;
var
  i:integer;
begin
  //Setto il prefisso vmc al tag inps
  //non riesco ad attribuirlo tramite property, perchè in automatico lo riporta su tutti i tag
  if VFXML.XML.Count > 0 then
  begin
    VFXML.XML.BeginUpdate;
    for i:=0 to VFXML.XML.Count - 1 do
    begin
      if VFXML.XML[i].IndexOf('inps-bkm') >= 0 then
      begin
        VFXML.XML[i]:=VFXML.XML[i].Replace('inps-bkm','vmc:inps',[rfIgnoreCase]);
      end;
    end;
    VFXML.XML.EndUpdate;
    VFXML.Active:=True;
    //risetto le opzioni dopo l'editing dell'xml
    VFXML.Encoding:='iso-8859-1';
    VFXML.Options:=[doNodeAutoIndent];
  end;
end;

procedure TA171FXMLVisiteFiscaliMW.SetElaborato;
begin
  updT049_ELABORATO.SetVariable('DATADA', T049FiltroPeriodoDa);
  updT049_ELABORATO.SetVariable('DATAA', T049FiltroPeriodoA);
  updT049_ELABORATO.Execute;
  SessioneOracle.Commit;
end;

end.
