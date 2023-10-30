unit WA002UAnagrafeDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBClient, DB, Math, OracleData, Oracle, medpIWMessageDlg, StrUtils,
  WR100UBase, WR102UGestTabella, WR302UGestTabellaDM,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, RegistrazioneLog,
  A002UAnagrafeMW, WA142UQualifMinisteriali, UselI010;

type
  TDatoLiberoDM = record
    Nome,Formato:String;
    NomeTabella:String;
    Storico:String;
    Dimensione: Double;
    Query:TOracleDataSet;
    Sorgente:TDataSource;
  end;

  TWA002FAnagrafeDM = class(TWR302FGestTabellaDM)
    selT030: TOracleDataSet;
    selT030PROGRESSIVO: TFloatField;
    selT030COGNOME: TStringField;
    selT030NOME: TStringField;
    selTabellaPROGRESSIVO: TFloatField;
    selT030MATRICOLA: TStringField;
    selTabellaDATADECORRENZA: TDateTimeField;
    selTabellaBADGE: TFloatField;
    selT030SESSO: TStringField;
    selTabellaDATAFINE: TDateTimeField;
    selTabellaEDBADGE: TStringField;
    selTabellaINDIRIZZO: TStringField;
    selTabellaCOMUNE: TStringField;
    selTabellaCAP: TStringField;
    selTabellaINIZIO: TDateTimeField;
    seltabellaTELEFONO: TStringField;
    selTabellaFINE: TDateTimeField;
    selTabellaSQUADRA: TStringField;
    selTabellaTIPOOPE: TStringField;
    selTabellaTERMINALI: TStringField;
    selTabellaTIPORAPPORTO: TStringField;
    selTabellaDOCENTE: TStringField;
    selT030DATANAS: TDateTimeField;
    selT030COMUNENAS: TStringField;
    selT480: TOracleDataSet;
    selT480CODICE: TStringField;
    selT480CITTA: TStringField;
    selT480CAP: TStringField;
    selT480PROVINCIA: TStringField;
    selT480CODCATASTALE: TStringField;
    selT030CAPNAS: TStringField;
    dsrT030: TDataSource;
    selComune: TOracleDataSet;
    dsrComune: TDataSource;
    selT030CODFISCALE: TStringField;
    selT030INIZIOSERVIZIO: TDateTimeField;
    selT030RAPPORTI_UNITI: TStringField;
    selT030TIPO_PERSONALE: TStringField;
    selTabellaCAUSSTRAORD: TStringField;
    selTabellaSTRAORDE: TStringField;
    selTabellaSTRAORDU: TStringField;
    selTabellaSTRAORDEU: TStringField;
    selTabellaCONTRATTO: TStringField;
    selTabellaHTEORICHE: TStringField;
    selTabellaPERSELASTICO: TStringField;
    selTabellaTGESTIONE: TStringField;
    selTabellaPLUSORA: TStringField;
    selTabellaCALENDARIO: TStringField;
    selTabellaIPRESENZA: TStringField;
    selTabellaPORARIO: TStringField;
    selTabellaPASSENZE: TStringField;
    selTabellaABCAUSALE1: TStringField;
    selTabellaABPRESENZA1: TStringField;
    selTabellaPARTTIME: TStringField;
    selTabellaSTRAORDEU2: TStringField;
    selTabellaQUALIFICAMINIST: TStringField;
    selTabellaTIPO_LOCALITA_DIST_LAVORO: TStringField;
    selTabellaCOD_LOCALITA_DIST_LAVORO: TStringField;
    selTabellaINIZIO_IND_MAT: TDateTimeField;
    selTabellaFINE_IND_MAT: TDateTimeField;
    selTabellaMEDICINA_LEGALE: TStringField;
    selTabellaORARIO: TStringField;
    selT033_Pagine: TOracleDataSet;
    selT033: TOracleDataSet;
    selT030I060EMAIL: TStringField;
    selT430_appoggio: TOracleDataSet;
    cdsElencoCampi: TClientDataSet;
    cdsElencoCampiETICHETTA: TStringField;
    cdsElencoCampiNOMEDATO: TStringField;
    cdsElencoCampiRIDEFINITO: TStringField;
    cdsElencoCampiPAGINA: TStringField;
    cdsElencoCampiIDPAGINA: TIntegerField;
    cdsElencoCampiIDCOMPONENTE: TIntegerField;
    cdsrGridCercaCampo: TDataSource;
    cdsGridCercaCampo: TClientDataSet;
    cdsStoriaDato: TClientDataSet;
    cdsStoriaDatoDATO: TStringField;
    cdsStoriaDatoDATADEC: TStringField;
    cdsStoriaDatoDATAFINE: TStringField;
    cdsStoriaDatoVALORE: TStringField;
    cdsStoriaDatoDESCRIZIONE: TStringField;
    cdsrStoriaDato: TDataSource;
    cdsStoriaDatoKEY: TStringField;
    selTabellaINDIRIZZO_DOM_BASE: TStringField;
    selTabellaCOMUNE_DOM_BASE: TStringField;
    selTabellaCAP_DOM_BASE: TStringField;
    selComuneCODICE: TStringField;
    selComuneCITTA: TStringField;
    selComuneCAP: TStringField;
    selComunePROVINCIA: TStringField;
    selComuneCODCATASTALE: TStringField;
    cdsStoriaDatoRIGACOLORATA: TBooleanField;
    selTabellaAZIENDA_BASE: TStringField;
    selT030I060EMAILPEC: TStringField;
    selT030TIPO_SOGGETTO_BASE: TStringField;
    selT030I060CELLULARE: TStringField;
    selTabellaRAPPORTI_UNIFICATI: TStringField;
    selT030I060EMAILPERSONALE: TStringField;
    selT030I060CELLULAREPERSONALE: TStringField;
    procedure selTabellaAfterEdit(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterCancel(DataSet: TDataSet); override;
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforeInsert(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selT030CalcFields(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure selT030NewRecord(DataSet: TDataSet);
    procedure selTabellaPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    CodiceFiscaleCalcolato,
    OldTipoRapporto: String;
    OldFine:TDateTime;
    OldRapportiUnificati:String;
    AllineaCessazione,AllineaRapportiUnificati: Boolean;
    GestioneCdCPercentualizzati,Automatismo: Boolean; //Gestione CdC Percentualizzati. automatismo e dataMod passati per referenza
    DeletePrimaDecorrenza: Boolean;
    DataDecMod,Istante: TDateTime;
    NFieldsFissi: Integer;
    RegistraLogT030:TRegistraLog;
    procedure CreaDatiLiberiDM;
    procedure CheckCFCambiato(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CheckBeforePost(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CheckCdCManuale(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CheckCdCAutomatico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CheckDelAzienda(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    function QueryLookupCampo(Campo : String): TOracleDataSet;
    procedure DistruggiDatiLiberi;
  public
    QI010:TselI010;
    DatiLiberiDM: array of TDatoLiberoDM;
    A002FAnagrafeMW:TA002FAnagrafeMW;
    procedure ImpostaBadgeLibero (StartFrom : Integer);
    procedure AggiornaDatasetStorici(data : TDateTime);
    function ListaAssenze: TStringList;
    function ListaPresenze: TStringList;
    procedure NuovaMatricola;
    procedure ReloadDatiLiberi;
    function GetQueryLookup(idx: Integer;nomeCampo: String): TOracleDataSet;
  end;

implementation

uses WA002UAnagrafe;
{$R *.dfm}

procedure TWA002FAnagrafeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A002FAnagrafeMW:=TA002FAnagrafeMW.Create(Self);
  A002FAnagrafeMW.selT030_Funzioni:=selT030;
  A002FAnagrafeMW.selT430_Funzioni:=selTabella;
  A002FAnagrafeMW.selT430OldValues.SetDataSet(selTabella);

  CreaDatiLiberiDM;
  selTabella.Open;
  A002FAnagrafeMW.selI030.Open;
  A002FAnagrafeMW.selI035.Open;
  A002FAnagrafeMW.RefreshVSQLAppoggio;

  cdsStoriaDato.CreateDataSet;

  selT033_Pagine.SetVariable('NOME', Parametri.Layout);
  selT033.SetVariable('NOME', Parametri.Layout);
  A002FAnagrafeMW.selT033_campoDecode.SetVariable('Nome',Parametri.Layout);
  (*
  selT033_Pagine.SetVariable('NOME', 'CARATTO');
  selT033.SetVariable('NOME', 'CARATTO');
  A002FAnagrafeMW.selT033_campoDecode.SetVariable('NOME','CARATTO');
  *)
  A002FAnagrafeMW.selT033_campoDecode.Open;

  selComune.ReadBuffer:=A002FAnagrafeMW.GetReadBuffer(R180Query2NomeTabella(selComune),'N');
  selComune.SetVariable('ORDERBY','ORDER BY CITTA');
  selComune.Open;

  QI010:=TselI010.Create(Self);
  QI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'','','RICERCA,NOME_LOGICO');
  RegistraLogT030:=TRegistraLog.Create(Self);
  RegistraLogT030.Session:=SessioneOracle;
end;

procedure TWA002FAnagrafeDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;

  //SELTABELLA SINCRONIZZATO CON SELT030
  selT030.Cancel;
  A000SessioneWEB.RipristinaTimeOut;
end;

procedure TWA002FAnagrafeDM.AfterPost(DataSet: TDataSet);
var
  Automatismo: Boolean;
  NewTipoRapporto,
  TR,
  Tipo,
  sTmp: String;

begin
  inherited;
  MsgBox.ClearKeys;

  //SELTABELLA SINCRONIZZATO CON SELT030
  selT030.Post;
  A000SessioneWEB.RipristinaTimeOut;

  if AllineaCessazione then
  begin
    A002FAnagrafeMW.updFine.Execute;
    AllineaCessazione:=False;
  end;
  if AllineaRapportiUnificati then
  begin
    A002FAnagrafeMW.updRapportiUnificati.Execute;
    AllineaRapportiUnificati:=False;
  end;

  A002FAnagrafeMW.noTrigger(Istante,'N');

  A002FAnagrafeMW.UpdT430Mat.SetVariable('PROGRESSIVO',selT030.FieldByName('PROGRESSIVO').AsInteger);
  A002FAnagrafeMW.UpdT430Mat.Execute;

  if not A002FAnagrafeMW.AggiornaPeriodiStorici then
    MsgBox.addMessage(A000MSG_A002_ERR_DIP_IN_USO,mtError);

  NewTipoRapporto:=selTabella.FieldByName('TipoRapporto').AsString;
  A002FAnagrafeMW.selT450.Open;
  if (OldTipoRapporto <> '')
  and (VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',OldTipoRapporto,'TIPO')) = 'R')
  and (VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',NewTipoRapporto,'TIPO')) <> 'R') then
  begin
    TR:=VarToStr(A002FAnagrafeMW.selT450.Lookup('CODICE',NewTipoRapporto,'TIPO'));
    if (TR = 'S') then
      Tipo:='Supplente'
    else if (TR = 'I') then
      Tipo:='Incaricato'
    else if (TR = 'P') then
      Tipo:='Prova'
    else if (TR = 'A') then
      Tipo:='Altro'
    else
      Tipo:='nessuno';

    MsgBox.addMessage(format(A000MSG_A002_ERR_FMT_CAMBIO_RAPP,[Tipo]),mtInformation);
  end;
  //A002FAnagrafeMW.selT450.Close;

  if not A002FAnagrafeMW.VerificaInizioRapportoInterseca(sTmp) then
    MsgBox.addMessage(format(A000MSG_A002_ERR_FMT_RAPP_INTERSECA,[sTmp]),mtError);

  if not A002FAnagrafeMW.VerificaPeriodiInvertiti(sTmp) then
    MsgBox.addMessage(format(A000MSG_A002_ERR_FMT_PERIODI_INV,[sTmp]),mtError);

  if not A002FAnagrafeMW.VerificaDatePeriodi(sTmp) then
    MsgBox.addMessage(format(A000MSG_A002_ERR_FMT_DATE_INCONGR,[sTmp]),mtError);

  if not A002FAnagrafeMW.VerificaCedAntePrimoStoricoStip then
    MsgBox.addMessage(A000MSG_P430_ERR_CED_ANTE_PRIMO_STORICO,mtError);

  if GestioneCdCPercentualizzati then
  begin
    //Chiedo se intervenire sui centri di costo, manualmente o automaticamente
    if not Automatismo then
      MsgBox.addMessage(A000MSG_A002_DLG_CDC_MANUALE,mtConfirmation,[mbYes,mbNo],CheckCdCManuale,'')
    else
      MsgBox.addMessage(A000MSG_A002_DLG_CDC_AUTOMATICO,mtConfirmation,[mbYes,mbNo,mbCancel],CheckCdCAutomatico,'');
  end;

  MsgBox.ShowMessages;

end;

procedure TWA002FAnagrafeDM.AfterScroll(DataSet: TDataSet);
begin
  //devo mantenere i dataset storici aggiornati alla data decorrenza per caricare le descrizioni corrette
  AggiornaDatasetStorici(selTabella.FieldByName('DATADECORRENZA').AsDateTime);
  inherited;
  A002FAnagrafeMW.selT430OldValues.Aggiorna;
  // abilita azione di accesso (readonly) ai login dipendente
  TWA002FAnagrafe(Self.Owner).actLoginDipendente.Enabled:=A002FAnagrafeMW.EsistonoLoginWeb(selTabella.FieldByName('PROGRESSIVO').AsInteger);
end;

procedure TWA002FAnagrafeDM.AggiornaDatasetStorici(data: TDateTime);
var
  i,NRecords: Integer;
begin
  //al cambiamento di T430_STORICO devo aggiornare i dataset storici con la nuova data di decorrenza
  if data <> A002FAnagrafeMW.selT220.GetVariable('Data') then
  begin
    for i:=0 to Length(DatiLiberiDM)-1 do
    begin
      if DatiLiberiDM[i].Storico = 'S' then
      begin
        //Opero sulla query legata al dato libero storicizzato
        DatiLiberiDM[i].Query.Close;
        //Setto la data e rieseguo la query
        DatiLiberiDM[i].Query.SetVariable('DATA',data);
      end;
    end;
    with A002FAnagrafeMW do
    begin
      selT220.Close;
      selT220.SetVariable('DATA',data);

      selT470.Close;
      selT470.SetVariable('DATA',data);
    end;
  end;
end;

procedure TWA002FAnagrafeDM.BeforeDelete(DataSet: TDataSet);
var AziendaBasePrec,AziendaBaseAtt,Msg:String;
begin
  // effettua l'edit su T030, tentando di acquisire il lock sul record
  try
    selT030.Edit;
  except
    on E: EDatabaseError do
    begin
      if E.Message = A000MSG_ERR_DATABASE_RECORD_LOCKED then
        raise EDatabaseError.Create(A000TraduzioneStringhe(A000MSG_A002_ERR_SCHEDA_LOCK))
      else
        raise;
    end;
    on E: Exception do
    begin
      raise;
    end;
  end;

  inherited;

  //Controllo che non si stia cancellando l'unico record presente
  A002FAnagrafeMW.selT430_Decorrenze.Close;
  A002FAnagrafeMW.selT430_Decorrenze.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
  A002FAnagrafeMW.selT430_Decorrenze.Open;
  A002FAnagrafeMW.selT430_Decorrenze.First;
  try
    if A002FAnagrafeMW.selT430_Decorrenze.RecordCount = 1 then
    begin
      MsgBox.WebMessageDlg(A000MSG_A002_ERR_DEL_UNICA_DECORRENZA ,mtInformation,[mbOK],nil,'');
      Abort;
    end;
    Msg:=A002FAnagrafeMW.VerificaCampiNonAbilitati(selTabella.FieldByName('Progressivo').AsInteger,selTabella.FieldByName('DataDecorrenza').AsDateTime);
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A002_ERR_FMT_DECO_CAMPI_DISABIL,['cancellazione',Msg]),mtInformation,[mbOK],nil,'');
      Abort;
    end;

    DeletePrimaDecorrenza:=False;//Serve nell'AfterPost
    //Verifico se sono sulla prima decorrenza
    if selTabella.FieldByName('DATADECORRENZA').AsDateTime = A002FAnagrafeMW.selT430_Decorrenze.FieldByName('DATADECORRENZA').AsDateTime then
    begin
      //verifico che la decorrenza successiva sia maggiore o uguale all'inizio rapporto...
      selT430_appoggio.Close;
      selT430_appoggio.SetVariable('DATALAV',selTabella.FieldByName('DATAFINE').AsDateTime+ 1);
      selT430_appoggio.setVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
      selT430_appoggio.Open;
      if (not selT430_appoggio.FieldByName('INIZIO').IsNull) and (selT430_appoggio.FieldByName('INIZIO').AsDateTime < selT430_appoggio.FieldByName('DATADECORRENZA').AsDateTime) then
      begin
        MsgBox.WebMessageDlg(A000MSG_A002_ERR_DEL_INIZIO_RAPPORTO ,mtInformation,[mbOK],nil,'');
        Abort;
      end;
      //verifico presenza anagrafiche stipendiali
      if A002FAnagrafeMW.CountAnagraficheStipendiali(selTabella.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATADECORRENZA').AsDateTime + 1,selT430_appoggio.FieldByName('DATADECORRENZA').AsDateTime) > 0 then
      begin
        MsgBox.WebMessageDlg(format(A000MSG_A002_ERR_FMT_DEL_STIPENDIALI,[DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_OLD')),DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_NEW'))]) ,mtInformation,[mbOK],nil,'');
        Abort;
      end;
      DeletePrimaDecorrenza:=True;//Serve nell'AfterPost
    end
    else if not MsgBox.KeyExists('DEL_AZIENDA') then
    //Se non sono sulla prima decorrenza
    begin
      //Recupero l'azienda sul periodo precedente
      A002FAnagrafeMW.selT430_AziendaPrec.Close;
      A002FAnagrafeMW.selT430_AziendaPrec.setVariable('Progressivo',selTabella.FieldByName('PROGRESSIVO').AsInteger);
      A002FAnagrafeMW.selT430_AziendaPrec.SetVariable('DataFinePrec',selTabella.FieldByName('DATADECORRENZA').AsDateTime - 1);
      A002FAnagrafeMW.selT430_AziendaPrec.Open;
      AziendaBasePrec:=A002FAnagrafeMW.selT430_AziendaPrec.FieldByName('AZIENDA_BASE').AsString;
      //Recupero l'azienda sul periodo attuale
      AziendaBaseAtt:=selTabella.FieldByName('AZIENDA_BASE').AsString;
      //Se l'azienda impostata sul record precedente è diversa da quella impostata sul record attuale, chiedo conferma, perché andrebbe a sostituirla nel periodo
      if AziendaBasePrec <> AziendaBaseAtt then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_A002_DLG_FMT_DEL_AZIENDA,[AziendaBasePrec,AziendaBaseAtt]),mtConfirmation,[mbYes,mbNo],CheckDelAzienda,'DEL_AZIENDA');
        Abort;
      end;
    end;
  finally
    A002FAnagrafeMW.selT430_Decorrenze.Close;
    selT430_appoggio.Close;
  end;
end;

procedure TWA002FAnagrafeDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  MsgBox.ClearKeys;

  if DeletePrimaDecorrenza then
  begin
    //Aggiorno la minima data decorrenza stipendiale, in modo che la Allinea_Periodi_Storici non annulli la posticipazione
    A002FAnagrafeMW.updP430.SetVariable('DATA_NEW',R180InizioMese(selTabella.FieldByName('DATADECORRENZA').AsDateTime));
    A002FAnagrafeMW.updP430.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
    A002FAnagrafeMW.updP430.Execute;
    if not A002FAnagrafeMW.VerificaCedAntePrimoStoricoStip then
      MsgBox.addMessage(A000MSG_P430_ERR_CED_ANTE_PRIMO_STORICO,mtError);
  end;
  if not A002FAnagrafeMW.AggiornaPeriodiStorici  then
    MsgBox.addMessage(A000MSG_A002_ERR_DIP_IN_USO,mtError);
  SessioneOracle.Commit;

  MsgBox.ShowMessages;
end;

procedure TWA002FAnagrafeDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if (Parametri.ModPersonaleEsterno = 'N') and (selT030.FieldByName('TIPO_PERSONALE').AsString = 'E') then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_ABIL_ESTERNI,mtError,[mbOk],nil,'');
    Abort;
  end;

  // effettua l'edit su T030, tentando di acquisire il lock sul record
  try
    OldFine:=selTabella.FieldByName('Fine').AsDateTime;
    OldRapportiUnificati:=SelTabella.FieldByName('Rapporti_Unificati').AsString;
    selT030.Edit;
    A000SessioneWEB.RiduciTimeOut;
  except
    on E: EDatabaseError do
    begin
      if E.Message = A000MSG_ERR_DATABASE_RECORD_LOCKED then
        raise EDatabaseError.Create(A000TraduzioneStringhe(A000MSG_A002_ERR_SCHEDA_LOCK))
      else
        raise;
    end;
    on E: Exception do
    begin
      raise;
    end;
  end;
end;

procedure TWA002FAnagrafeDM.selTabellaAfterEdit(DataSet: TDataSet);
begin
  inherited;

  //SELTABELLA SINCRONIZZATO CON SELT030
  // selT030.Edit;
end;

procedure TWA002FAnagrafeDM.BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  //SELTABELLA SINCRONIZZATO CON SELT030
  // storicizzazione imposta edit. per nuovo record insert
  //Devo eseguire questo codice nella beforeinsert e non nella post per poter
  //settare correttamente i dati nella Dataset2Componenti
  if InterfacciaWR102.StoricizzazioneInCorso then
  begin
    // effettua l'edit su T030, tentando di acquisire il lock sul record
    try
      OldFine:=selTabella.FieldByName('Fine').AsDateTime;
      OldRapportiUnificati:=SelTabella.FieldByName('Rapporti_Unificati').AsString;
      selT030.Edit;
      A000SessioneWEB.RiduciTimeOut;
    except
      on E: EDatabaseError do
      begin
        if E.Message = A000MSG_ERR_DATABASE_RECORD_LOCKED then
        begin
          //raise EDatabaseError.Create(A000TraduzioneStringhe(A000MSG_A002_ERR_SCHEDA_LOCK)) // non si ottiene il comportamento desiderato
          MsgBox.Messagebox(A000TraduzioneStringhe(A000MSG_A002_ERR_SCHEDA_LOCK),ERRORE);
          Abort;
        end
        else
          raise;
      end;
      on E: Exception do
      begin
        raise;
      end;
    end;
  end
  else
  begin
    if Parametri.InserimentoMatricole <> 'S' then
    begin
     MsgBox.WebMessageDlg(A000MSG_ERR_NO_INSERIMENTO,mtError,[mbOk],nil,'');
     Abort;
    end;

    //svuoto selezione WC700
    //Aggiunge Progressivo = 0 in modo da non selezionare elementi
//TODO ALVARE PROGRESSIVO E RIPOSIZIONARSI SU CANCEL. IN CASO DI NUOVO POSIZIONARSI SUL NUOVO SE POSSIBILE
//TWA002FAnagrafe(Self.Owner).WC700FM.actEseguiSelezioneExecute(TWA002FAnagrafe(Self.Owner).WC700FM.actAnnullaSelezione);
    selT030.Insert;
  end;
end;

procedure TWA002FAnagrafeDM.BeforePost(DataSet: TDataSet);
var
  CodCatastale,Msg: String;
  Decorrenza,PrimaDecorrenza: TDateTime;
  InserimentoNew,ModificaPrimaRicorrenza: Boolean;
  lstBadgeUsato: TStringList;
  i: Integer;
begin
  inherited;
  //VERIFICHE T030 (Non fatto su beforepost di T030 perchè il post è richiamato sulla after post di selTabella
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    if selT030.State = dsInsert then
    begin
      //Incremento il progressivo interno
      selT030.FieldByName('Progressivo').AsInteger:=A002FAnagrafeMW.NuovoProgressivo;
      selTabella.FieldByName('Progressivo').AsInteger:=selT030.FieldByName('Progressivo').AsInteger;
    end;

    with selT030 do
    begin
      if QueryPK1.EsisteChiave('T030_ANAGRAFICO',RowID,State,['MATRICOLA'],[FieldByName('MATRICOLA').AsString]) then
      begin
        MsgBox.MessageBox(Format(A000MSG_ERR_FMT_GIA_ESISTENTE,['Matricola']), ERRORE);
        //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
        MsgBox.ClearKeys;
        Abort;
      end;

      if (Parametri.ModPersonaleEsterno = 'N') and (FieldByName('TIPO_PERSONALE').AsString = 'E') then
      begin
        MsgBox.MessageBox(A000MSG_ERR_ABIL_ESTERNI, ERRORE);
        //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
        MsgBox.ClearKeys;
        Abort;
      end;
      FieldByName('MATRICOLA').AsString:=Trim(FieldByName('MATRICOLA').AsString);
      FieldByName('COGNOME').AsString:=Trim(FieldByName('COGNOME').AsString);
      if FieldByName('MATRICOLA').IsNull then
        raise Exception.Create(A000MSG_S031_ERR_MATR_NULLA);

      CodCatastale:='';
      if FieldByName('COMUNENAS').AsString <> '' then
      begin
        //selT480.Close;
        R180SetVariable(selT480,'CODICE',FieldByName('COMUNENAS').AsString);
        selT480.Open;
        selT480.First;
        CodCatastale:=selT480.FieldByName('CODCATASTALE').AsString;
      end;
      CodiceFiscaleCalcolato:=A002FanagrafeMW.VerificaCFCambiato(CodCatastale);
      if CodiceFiscaleCalcolato <> '' then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_A002_DLG_FMT_CF_CAMBIATO,[CodiceFiscaleCalcolato]),mtConfirmation,[mbYes,mbNo],CheckCFCambiato,'PUNTO_1');
        Abort;
      end;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_2') then
  begin
    Msg:=A002FAnagrafeMW.VerificaCFUsato;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A002_DLG_FMT_CF_USATO,[Msg]),mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_2');
      Abort;
    end;
  end;
  AllineaCessazione:=False;
  AllineaRapportiUnificati:=False;
  //VERIFICHE T430
  if not MsgBox.KeyExists('PUNTO_3') then
  begin
    InserimentoNew:=(selTabella.State = dsInsert) and (not InterfacciaWR102.StoricizzazioneInCorso);

    with selTabella do
    begin
      if (FieldByName('DATADECORRENZA').AsDateTime < EncodeDate(1900,01,01)) or (FieldByName('DATADECORRENZA').AsDateTime > EncodeDate(3999,12,31)) then
      begin
        MsgBox.MessageBox(A000MSG_ERR_DECORRENZA_INVALIDA,ERRORE);
        //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
        MsgBox.ClearKeys;
        Abort;
      end;
      if (selTabella.State = dsEdit) and (not InterfacciaWR102.StoricizzazioneInCorso) and (FieldByName('DataDecorrenza').AsDateTime <> FieldByName('DataDecorrenza').medpOldValue) then
      begin
        Msg:=A002FAnagrafeMW.VerificaCampiNonAbilitati(FieldByName('Progressivo').AsInteger,FieldByName('DataDecorrenza').medpOldValue);
        if Msg <> '' then
        begin
          MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_DECO_CAMPI_DISABIL,['spostamento decorrenza',Msg]),ERRORE);
          //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
          MsgBox.ClearKeys;
          Abort;
        end;
      end;
      ModificaPrimaRicorrenza:=False;
      if InserimentoNew then
        //Nuovo record
        PrimaDecorrenza:=FieldByName('DataDecorrenza').AsDateTime
      else
      begin
        A002FAnagrafeMW.selT430_Decorrenze.Close;
        A002FAnagrafeMW.selT430_Decorrenze.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
        A002FAnagrafeMW.selT430_Decorrenze.Open;
        A002FAnagrafeMW.selT430_Decorrenze.First;
        PrimaDecorrenza:=A002FAnagrafeMW.selT430_Decorrenze.FieldByName('DATADECORRENZA').AsDateTime;
        if A002FAnagrafeMW.selT430OldValues.FieldByName('DATADECORRENZA').Value = PrimaDecorrenza then
        begin
          //modifica della primadecorrenza
          ModificaPrimaRicorrenza:=True;
          PrimaDecorrenza:=selTabella.FieldByName('DataDecorrenza').AsDateTime;
        end;
      end;
      if (not FieldByName('INIZIO').IsNull) and (FieldByName('INIZIO').AsDateTime <> A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO').Value) then
        if FieldByName('INIZIO').AsDateTime < PrimaDecorrenza then
        begin
          MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_INIZIO_ANTE,[FieldByName('INIZIO').AsString,DateToStr(PrimaDecorrenza)]),ERRORE);
          //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
          MsgBox.ClearKeys;
          Abort;
        end;

      if not InserimentoNew then
      begin
        if InterfacciaWR102.StoricizzazioneInCorso then
        begin //Controllo che la data di decorrenza sia compresa nel periodo storico corrente, con l'eccezione del primo periodo storico in cui è possibile storicizzare ad una data precedente
          if ((FieldByName('DATADECORRENZA').AsDateTime < A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value) or (FieldByName('DATADECORRENZA').AsDateTime > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value)) then
            if (not ModificaPrimaRicorrenza) or (FieldByName('DATADECORRENZA').AsDateTime > A002FAnagrafeMW.selT430OldValues.FieldByName('DataFine').Value) then
            begin
              MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_DECOR_FUORI_PER,[DateToStr(FieldByName('DATADECORRENZA').AsDateTime)]),ERRORE);
              //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
              MsgBox.ClearKeys;
              Abort;
            end;
        end
        else
        begin
          if not ModificaPrimaRicorrenza then
          begin //Controllo che la data di decorrenza non sia successiva alla fine del periodo storico corrente
            //e non sia precedente al periodo storico precedente
            //Reperisco data deccorenza antecedente a quella corrente ( prendo oldvalue perchè può essere modificata)
            selT430_appoggio.Close;
            selT430_appoggio.SetVariable('DATALAV',A002FAnagrafeMW.selT430OldValues.FieldByName('DATADECORRENZA').Value - 1);
            selT430_appoggio.setVariable('PROGRESSIVO',FieldByName('PROGRESSIVO').AsInteger);
            selT430_appoggio.Open;

            if (FieldByName('DATADECORRENZA').AsDateTime <= selT430_appoggio.FieldByName('DATADECORRENZA').AsDateTime) or (FieldByName('DATADECORRENZA').AsDateTime > A002FAnagrafeMW.selT430OldValues.FieldByName('DATAFINE').Value) then
            begin
              MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_DECOR_FUORI_PER,[DateToStr(FieldByName('DATADECORRENZA').AsDateTime)]),ERRORE);
              //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
              MsgBox.ClearKeys;
              Abort;
            end;
          end
          else //Controllo che la prima decorrenza non sia successiva alla fine del periodo storico corrente
          begin
            if (FieldByName('DATADECORRENZA').AsDateTime > A002FAnagrafeMW.selT430OldValues.FieldByName('DATAFINE').Value) then
            begin
              MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMO_PER,[DateToStr(FieldByName('DATADECORRENZA').AsDateTime)]),ERRORE);
              //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
              MsgBox.ClearKeys;
              Abort;
            end;

            //Se è già stata impostata la data di inizio rapporto...
            if not FieldByName('INIZIO').IsNull then
            begin
              if A002FAnagrafeMW.CountAnagraficheStipendiali(FieldByName('PROGRESSIVO').AsInteger,EncodeDate(1900,01,01),EncodeDate(3999,12,31)) > 0 then
              begin
                //Se il dipendente ha già almeno un'anagrafica stipendiale, controllo che la decorrenza non sia maggiore del 1° giorno del mese di inizio rapporto
                if FieldByName('DATADECORRENZA').AsDateTime > R180InizioMese(FieldByName('INIZIO').AsDateTime) then
                begin
                  MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMO_STIP,[DateToStr(FieldByName('DATADECORRENZA').AsDateTime),DateToStr(R180InizioMese(FieldByName('INIZIO').AsDateTime) )]),ERRORE);
                  //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
                  MsgBox.ClearKeys;
                  Abort;
                end;
              end
              else
              begin
                //Se il dipendente non ha alcuna anagrafica stipendiale, controllo che la decorrenza non sia maggiore dell'inizio rapporto
                if FieldByName('DATADECORRENZA').AsDateTime > FieldByName('INIZIO').AsDateTime then
                begin
                  MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_DECOR_PRIMA_ASSUNZ,[DateToStr(FieldByName('DATADECORRENZA').AsDateTime),DateToStr(FieldByName('INIZIO').AsDateTime)]),ERRORE);
                  //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
                  MsgBox.ClearKeys;
                  Abort;
                end;
              end;
            end;
            //Se sto posticipando la decorrenza...
            if A002FAnagrafeMW.selT430OldValues.FieldByName('DATADECORRENZA').Value < FieldByName('DATADECORRENZA').AsDateTime then
            begin
              //...verifico che non esistano periodi storici stipendiali nel periodo di traslazione della decorrenza
              if A002FAnagrafeMW.CountAnagraficheStipendiali(FieldByName('PROGRESSIVO').AsInteger,A002FAnagrafeMW.selT430OldValues.FieldByName('DataDecorrenza').Value + 1,FieldByName('DataDecorrenza').AsDateTime) > 0 then
              begin
                MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_STIP_INTERSEC,[DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_OLD')),DateToStr(A002FAnagrafeMW.selP430_count.GetVariable('DATA_NEW'))]),ERRORE);
                //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
                MsgBox.ClearKeys;
                Abort;
              end;
            end;
            //Aggiorno la minima data decorrenza stipendiale, in modo che la Allinea_Periodi_Storici non annulli la posticipazione
            A002FAnagrafeMW.AggiornaDecorrenzaStipendiale(FieldByName('DATADECORRENZA').AsDateTime);
          end;
        end;
      end;

      //Un campo non storicizzabile può essere modificato soltanto se sono stati attivati i flag Storici prec. (non obbligatorio sul primo storico) e Storici succ. (non obbligatorio sull'ultimo storico)
      //In inserimento non si controlla. In storicizzazione il componente dovrebbe essere disabilitato, ma per sicurezza si effettua il controllo.
      if (not InserimentoNew)
      and (    InterfacciaWR102.StoricizzazioneInCorso
           or ((selTabella.State = dsEdit) and (   ((not TWA002FAnagrafe(Self.Owner).chkStoriciPrec.Checked) and (TWA002FAnagrafe(Self.Owner).cmbDecorrenza.ItemIndex <> 0))
                                                or ((not TWA002FAnagrafe(Self.Owner).chkStoriciSucc.Checked) and (TWA002FAnagrafe(Self.Owner).cmbDecorrenza.ItemIndex <> (TWA002FAnagrafe(Self.Owner).cmbDecorrenza.Items.Count - 1)))))) then
      begin
        Msg:=A002FAnagrafeMW.VerificaCampiNonStoricizzabili;
        if Msg <> '' then
        begin
          MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_CAMPI_NON_STORICIZ,[IfThen(InterfacciaWR102.StoricizzazioneInCorso,'storicizzazione','modifica'),Msg]),ERRORE);
          //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
          MsgBox.ClearKeys;
          Abort;
        end;
      end;

      if FieldByName('INIZIO_IND_MAT').IsNull xor FieldByName('FINE_IND_MAT').IsNull then
      begin
        MsgBox.MessageBox(A000MSG_A002_ERR_MATERNITA_VALOR,ERRORE);
        //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
        MsgBox.ClearKeys;
        Abort;
      end;

      if FieldByName('INIZIO_IND_MAT').AsDateTime > FieldByName('FINE_IND_MAT').AsDateTime then
      begin
        MsgBox.MessageBox(A000MSG_A002_ERR_DATE_MATERNITA,ERRORE);
        //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
        MsgBox.ClearKeys;
        Abort;
      end;

      if ((A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO_IND_MAT').Value <> FieldByName('INIZIO_IND_MAT').Value) or
         (A002FAnagrafeMW.selT430OldValues.FieldByName('FINE_IND_MAT').Value <> FieldByName('FINE_IND_MAT').Value) or
         (A002FAnagrafeMW.selT430OldValues.FieldByName('INIZIO').Value <> FieldByName('INIZIO').Value) or
         (A002FAnagrafeMW.selT430OldValues.FieldByName('FINE').Value <> FieldByName('FINE').Value)) then
      begin
        if (Not FieldByName('INIZIO_IND_MAT').IsNull) then
        begin
          Msg:=A002FAnagrafeMW.VerificaIntersezionePeriodiIndMat;
          if Msg <> '' then
          begin
            MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_INT_MAT,[Msg]),ERRORE);
            //Devo resettare MSgBox perchè proponento il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
            MsgBox.ClearKeys;
            Abort;
          end;

          Msg:=A002FAnagrafeMW.VerificaIntersezionePeriodiRappIndMat;
          {Controllo che non avvengano intersezioni tra periodi di rapporto e periodi di maturazione indennità maternità}
          if Msg <> '' then
          begin
            MsgBox.MessageBox(Format(A000MSG_A002_ERR_FMT_INT_MAT_RAPP,[Msg]),ERRORE);
            //Devo resettare MSgBox perchè proponendo il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
            MsgBox.ClearKeys;
            Abort;
          end;
        end;

        A002FAnagrafeMW.AggiornaPeriodoIndMat;
      end;

      if (not FieldByName('FINE').IsNull) and (FieldByName('INIZIO').AsDateTime > FieldByName('FINE').AsDateTime) then
      begin
        MsgBox.WebMessageDlg(A000MSG_A002_DLG_DATA_ASSUNZ_POST,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_3');
        Abort;
      end;
    end;
  end;

  if not MsgBox.KeyExists('PUNTO_4') then
    if (selTabella.State = dsEdit) and (not InterfacciaWR102.StoricizzazioneInCorso) and (selTabella.FieldByName('DataDecorrenza').AsDateTime <> selTabella.FieldByName('DataDecorrenza').medpOldValue) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A002_DLG_MODIFICA_DECOR,mtConfirmation,[mbYes,mbNo],CheckBeforePost,'PUNTO_4');
      Abort;
    end;

  with A002FAnagrafeMW do
  begin
    selT430_Decorrenze.Close;
    selT430_Decorrenze.SetVariable('PROGRESSIVO',selTabella.FieldByName('PROGRESSIVO').AsInteger);
    selT430_Decorrenze.Open;
    selT430_Decorrenze.First;
    PrimaDecorrenza:=selT430_Decorrenze.FieldByName('DATADECORRENZA').AsDateTime;

    lstBadgeUsato:=VerificaBadge(InserimentoNew,InterfacciaWR102.StoricizzazioneInCorso,PrimaDecorrenza,InterfacciaWR102.StoriciPrec,InterfacciaWR102.StoriciSucc);
    if lstBadgeUsato <> nil then
    begin
      try
        Msg:='';
        for i:=0 to lstBadgeUsato.Count - 1 do
          Msg:=Msg + lstBadgeUsato[i] + #13#10;

        MsgBox.MessageBox(format(A000MSG_A002_ERR_FMT_BADGE_USATO,[Msg]),ERRORE);
        //Devo resettare MSgBox perchè proponendo il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
        MsgBox.ClearKeys;
        Abort;
      finally
        FreeAndNil(lstBadgeUsato);
      end;
    end;

    if not VerificaBadgeServizio then
    begin
      MsgBox.MessageBox(A000MSG_A002_ERR_BADGE_SERVIZIO,ERRORE);
      //Devo resettare MSgBox perchè proponendo il messaggio si dà la possibilità di modificare i dati e quindi vanno rieseguiti i controlli
      MsgBox.ClearKeys;
      Abort;
    end;
  end;

  //Modifica senza storicizzazione
  if not InserimentoNew then
  begin
    RegistraLogT030.SettaProprieta('M',R180Query2NomeTabella(selT030{DataSet}),Copy(Self.Name,1,5),selT030,True);
    RegistraLogT030.RegistraOperazione;

    GestioneCdCPercentualizzati:=False;
    if A002FAnagrafeMW.VerificaCdCPercentualizzati(InterfacciaWR102.StoriciPrec,InterfacciaWR102.StoriciSucc, PrimaDecorrenza, DataDecMod,Automatismo) then
      GestioneCdCPercentualizzati:=True; //usato nell'afterPost per apertura gestione cdc

    if not InterfacciaWR102.StoricizzazioneInCorso then
    begin
      A002FAnagrafeMW.AggiornaFine('N');
      A002FAnagrafeMW.AggiornaRapportiUnificati('N');
    end
    else
    begin
      if (selTabella.FieldByName('Fine').AsDateTime <> OldFine) then
        with A002FAnagrafeMW.updFine do
        begin
          ClearVariables;
          SetVariable('PROGRESSIVO',selTabella.FieldByName('Progressivo').AsInteger);
          SetVariable('RIGAID',selTabella.RowID);
          SetVariable('STORICIZZA','S');
          SetVariable('INIZIO',selTabella.FieldByName('Inizio').AsDateTime);
          if not selTabella.FieldByName('Fine').IsNull then
            SetVariable('FINE',selTabella.FieldByName('Fine').AsDateTime);
          AllineaCessazione:=True;
          //in questo caso (storicizzazione), l'esecuzione di updFine avviene nell'AfterPost
        end;
      if (selTabella.FieldByName('Rapporti_Unificati').AsString <> OldRapportiUnificati) then
        with A002FAnagrafeMW.updRapportiUnificati do
        begin
          ClearVariables;
          SetVariable('PROGRESSIVO',selTabella.FieldByName('Progressivo').AsInteger);
          SetVariable('RIGAID',selTabella.RowID);
          SetVariable('STORICIZZA','S');
          SetVariable('INIZIO',selTabella.FieldByName('Inizio').AsDateTime);
          SetVariable('RAPPORTI_UNIFICATI',selTabella.FieldByName('Rapporti_Unificati').AsString);
          AllineaRapportiUnificati:=True;
          //in questo caso (storicizzazione), l'esecuzione di updRapportiUnificati avviene nell'AfterPost
        end;
    end;
  end
  else //Inserimento di un nuovo dipendente
  begin
    if not (selTabella.FieldByName('INIZIO').IsNull) then       //Setto data decorrenza = al giorno di assunzione
      selTabella.FieldByName('DATADECORRENZA').AsDateTime:=selTabella.FieldByName('INIZIO').AsDateTime;

    selTabella.FieldByName('DATAFINE').AsDateTime:=StrToDateTime('31/12/3999');
    RegistraLogT030.SettaProprieta('I',R180Query2NomeTabella(selT030{DataSet}),Copy(Self.Name,1,5),selT030,True);
    RegistraLogT030.RegistraOperazione;
  end;
  OldTipoRapporto:=VarToStr(A002FAnagrafeMW.selT430OldValues.FieldByName('TipoRapporto').Value);

  Istante:=Now;
  A002FAnagrafeMW.noTrigger(Istante,'S');
end;

procedure TWA002FAnagrafeDM.CheckBeforePost(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: selTabella.Post;
    mrNo:  MsgBox.ClearKeys;
  end;
end;

procedure TWA002FAnagrafeDM.CheckCdCAutomatico(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
var
  F: TWR100FBase;
begin
  if (Res = mrYes) then
  begin
    A002FAnagrafeMW.updT433.SetVariable('PROGRESSIVO',selTabella.FieldByName('Progressivo').AsInteger);
    A002FAnagrafeMW.updT433.SetVariable('DATADECORRENZA_MOD',DataDecMod);
    A002FAnagrafeMW.updT433.Execute;
  end
  else if (Res = mrNo) then
  begin
    //todo apertura gestione cdcPercentualizzati
  end;
end;

procedure TWA002FAnagrafeDM.CheckCdCManuale(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
    if (Res = mrYes) then
      //todo apertura gestione cdcPercentualizzati
end;

procedure TWA002FAnagrafeDM.CheckCFCambiato(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
    selT030.FieldByName('CodFiscale').AsString:=CodiceFiscaleCalcolato;

  selTabella.Post;
end;

procedure TWA002FAnagrafeDM.CheckDelAzienda(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: (Self.Owner as TWR102FGestTabella).EseguiDelete;
    mrNo:  MsgBox.ClearKeys;
  end;
end;


{Scorro I500 e creo Query e DataSource corrispondenti per ciascun dato;
creo i campi persistenti del dato Codice e della descrizione (Lookup)
}
procedure TWA002FAnagrafeDM.CreaDatiLiberiDM;
var NDatiLiberi, i : Integer;
    NomeCampo   : String;
    Field       : TField;
begin
  //Creo i campi persistenti per selTabella (T430_STORICO)
  SetLength(DatiLiberiDM,0);
  NDatiLiberi:=0;
  selTabella.FieldDefs.Update;
  NFieldsFissi:=selTabella.Fields.Count;
  with A002FAnagrafeMW do
  begin
    selI500.Close;
    selI500.Open;
  if selI500.RecordCount = 0 then exit;
    selI500.First;
    while not selI500.Eof do
    begin
      i:=NDatiLiberi;
      Inc(NDatiLiberi);
      SetLength(DatiLiberiDM,NDatiLiberi);
      NomeCampo:=selI500.FieldByName('NOMECAMPO').AsString;
      DatiLiberiDM[i].Nome:=NomeCampo;
      DatiLiberiDM[i].Formato:=selI500.FieldByName('Formato').AsString;
      DatiLiberiDM[i].NomeTabella:='';
      DatiLiberiDM[i].Dimensione:=selI500.FieldByName('Lunghezza').AsFloat;

      //Se è un dato tabellare costruisco la query associata
      if selI500.FieldByName('TABELLA').AsString = 'S' then
        with DatiLiberiDM[i] do
        begin
          {Creo Query associata al dato libero}
          NomeTabella:='I501'+NomeCampo;
          Storico:=selI500.FieldByName('STORICO').AsString;
          Query:=TOracleDataSet.Create(nil);
          Query.Name:='selI501'+NomeCampo;
          Query.Session:=SessioneOracle;
          Query.OnFilterRecord:=nil;
          Query.Filtered:=False;
          Query.SQL.Clear;
          Query.DeleteVariables;
          //Se il dato libero è storicizzato filtro max di data decorrenza
          if selI500.FieldByName('STORICO').AsString = 'S' then
          begin
            Query.SQL.Add('select * from ' + NomeTabella + ' T1 where :DATA between DECORRENZA and DECORRENZA_FINE');
            Query.SQL.Add(' order by CODICE');
            Query.DeclareVariable('Data',otDate);
            Query.SetVariable('DATA',Parametri.DataLavoro);
          end
          else
            Query.SQL.Add('select * from ' + NomeTabella + ' order by CODICE');
          Query.ReadBuffer:=GetReadBuffer(NomeTabella,selI500.FieldByName('STORICO').AsString);
          Query.Open;
          //Creo data source associato alla tabella
          Sorgente:=TDataSource.Create(nil);
          Sorgente.Name:='D501' + NomeCampo;
          Sorgente.DataSet:=Query;
        end
      else
        DatiLiberiDM[i].Query:=nil;

      //Creo il campo persistente associato al dato libero
      if DatiLiberiDM[i].Formato = 'S' then
      begin
        Field:=TStringField.Create(nil);
        Field.Size:=selI500.FieldByName('Lunghezza').AsInteger;
      end
      else if DatiLiberiDM[i].Formato = 'D' then
      begin
        Field:=TDateTimeField.Create(nil);
        TDateTimeField(Field).DisplayFormat:='dd/mm/yyyy';
      end
      else if DatiLiberiDM[i].Formato = 'N' then
        Field:=TFloatField.Create(nil);

      with Field do
      begin
        FieldName:=NomeCampo;
        Name:=selTabella.Name + FieldName;
        DataSet:=selTabella;
        Index:=selTabella.FieldCount - 1;
        Visible:=False; //imposto False altrimenti visualizzato in grid elenco
      end;
      selTabella.FieldDefs.Update;
      selI500.Next;
    end;
  end;
//  selTabella.FieldDefs.EndUpdate;
end;

procedure TWA002FAnagrafeDM.DistruggiDatiLiberi;
var
  i: Integer;
begin
//  selTabella.FieldDefs.Update;
  for i:=0 to Length(DatiLiberiDM)-1 do
  begin
    with DatiLiberiDM[i] do
    begin
      if Sorgente <> nil then
        FreeAndNil(Sorgente);
      if Query <> nil then
        FreeAndNil(Query);
      selTabella.FieldByName(Nome).Free;
      //CARATTO 19/12/2012 FREE DEL FIELDDEF
//      selTabella.Fields[NFieldsFissi+i].Free;
    end;
  end;
//  selTabella.FieldDefs.EndUpdate;
  SetLength(DatiLiberiDM,0);

end;

procedure TWA002FAnagrafeDM.dsrTabellaStateChange(Sender: TObject);
var Browse:Boolean;
begin
  inherited;
  with TWR102FGestTabella(Owner) do
  begin
    Browse:=not (selTabella.State in [dsInsert,dsEdit]);
    actNuovo.Enabled:=actNuovo.Enabled and (Parametri.InserimentoMatricole = 'S');
    actElimina.Enabled:=actElimina.Enabled and (Parametri.EliminaStorici = 'S');
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    if dEdtDataDecorrenza <> nil then
    begin
      AggiornaToolBarStorico(not Browse, not Browse, not Browse, False, False, imgNuovaStoricizzazione.Enabled and (Parametri.Storicizzazione = 'S'));
      dEdtDataDecorrenza.Enabled:=dEdtDataDecorrenza.Enabled and not ((selTabella.State = dsEdit) and not InterfacciaWR102.StoricizzazioneInCorso and (Parametri.ModificaDecorrenza = 'N'));
    end;
  end;
end;

function TWA002FAnagrafeDM.GetQueryLookup(idx: Integer; nomeCampo: String): TOracleDataSet;
begin
  //i dati liberi hanno un corrispettivo array sul DataModulo in quanto creati a runtime.
  //Per i componenti fissi non esiste corrispondenza e viene decodificato da codice
  if idx < length(DatiLiberiDM) then
    Result:=DatiLiberiDM[idx].Query
  else
    Result:=QueryLookupCampo(nomeCampo);
end;

procedure TWA002FAnagrafeDM.impostaBadgeLibero(StartFrom: Integer);
var DataDecorrenza,DataFine:TDateTime;
begin
  if not (selTabella.State in [dsInsert, dsEdit]) then exit;

  with A002FAnagrafeMW do
  begin
    QBadgeLibero.Close;
    DataDecorrenza:=selTabella.FieldByName('DATADECORRENZA').AsDateTime;
    DataFine:=selTabella.FieldByName('DATAFINE').AsDateTime;
    if DataDecorrenza > DataFine then
      DataFine:=EncodeDate(3999,12,31);
    QBadgeLibero.SetVariable('Dal',DataDecorrenza);
    QBadgeLibero.SetVariable('Al',DataFine);
    QBadgeLibero.Open;

    if StartFrom = 0 then
    begin
      QBadgeLibero.Last;
      selTabella.FieldByName('BADGE').AsInteger:=QBadgeLibero.FieldByName('BADGE').AsInteger + 1;
    end
    else
    begin
      while QBadgeLibero.SearchRecord('BADGE',StartFrom,[srFromBeginning]) do
        inc(StartFrom);
      selTabella.FieldByName('BADGE').AsInteger:=StartFrom;
    end;
  end;
end;

function TWA002FAnagrafeDM.ListaAssenze: TStringList;
begin
  Result:=TStringList.Create;
  with A002FAnagrafeMW.selT265 do
  begin
    Open;
    First;
    while not Eof do
    begin
      Result.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

function TWA002FAnagrafeDM.ListaPresenze: TStringList;
begin
  Result:=TStringList.Create;
  with A002FAnagrafeMW.selT270 do
  begin
    Open;
    First;
    while not Eof do
    begin
      Result.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
    Close;
  end;
end;

procedure TWA002FAnagrafeDM.NuovaMatricola;
begin
  if selT030.State = dsInsert then
  begin
    A002FAnagrafeMW.GetNuovaMatricola.Execute;
    selT030.FieldByName('MATRICOLA').AsString:=VarToStr(A002FAnagrafeMW.GetNuovaMatricola.GetVariable('MATRICOLA'));
  end;

end;

function TWA002FAnagrafeDM.QueryLookupCampo(Campo: String): TOracleDataSet;
begin
  Result:=nil;
  if UpperCase(campo) = 'TIPORAPPORTO' then
    Result:=A002FAnagrafeMW.selT450
  else if UpperCase(campo) = 'SQUADRA' then
    Result:=A002FAnagrafeMW.selT603
  else if UpperCase(campo) = 'CONTRATTO' then
    Result:=A002FAnagrafeMW.selT200
  else if UpperCase(campo) = 'PLUSORA' then
    Result:=A002FAnagrafeMW.selT060
  else if UpperCase(campo) = 'IPRESENZA' then
    Result:=A002FAnagrafeMW.selT163
  else if UpperCase(campo) = 'PARTTIME' then
    Result:=A002FAnagrafeMW.selT460
  else if UpperCase(campo) = 'CALENDARIO' then
    Result:=A002FAnagrafeMW.selT010
  else if UpperCase(campo) = 'PORARIO' then
    Result:=A002FAnagrafeMW.selT220
  else if UpperCase(campo) = 'PERSELASTICO' then
    Result:=A002FAnagrafeMW.selT025
  else if UpperCase(campo) = 'PASSENZE' then
    Result:=A002FAnagrafeMW.selT261
  else if UpperCase(campo) = 'QUALIFICAMINIST' then
    Result:=A002FAnagrafeMW.selT470
  else if UpperCase(campo) = 'MEDICINA_LEGALE' then
    Result:=A002FAnagrafeMW.selT485
  else if UpperCase(campo) = 'AZIENDA_BASE' then
    Result:=A002FAnagrafeMW.selT440;
end;

procedure TWA002FAnagrafeDM.ReloadDatiLiberi;
var
  Progressivo: Integer;
begin
  Progressivo:=selTabella.FieldByName('PROGRESSIVO').AsInteger;

  selTabella.Close;

  DistruggiDatiLiberi;
  CreaDatiLiberiDM;

  selTabella.setVariable( 'PROGRESSIVO',Progressivo);
  selTabella.Open;

//  selTabella.First;
end;

procedure TWA002FAnagrafeDM.selT030CalcFields(DataSet: TDataSet);
begin
  inherited;
  selT030.FieldByName('I060EMail').AsString:=A002FAnagrafeMW.FormattaEMail(selT030.FieldByName('Matricola').AsString,'EMAIL');
  selT030.FieldByName('I060EMailPEC').AsString:=A002FAnagrafeMW.FormattaEMail(selT030.FieldByName('Matricola').AsString,'EMAIL_PEC');
  selT030.FieldByName('I060CELLULARE').AsString:=A002FAnagrafeMW.GetDatoI060(selT030.FieldByName('Matricola').AsString,'CELLULARE');
  selT030.FieldByName('I060EMAILPERSONALE').AsString:=A002FAnagrafeMW.GetDatoI060(selT030.FieldByName('Matricola').AsString,'EMAIL_PERSONALE');
  selT030.FieldByName('I060CELLULAREPERSONALE').AsString:=A002FAnagrafeMW.GetDatoI060(selT030.FieldByName('Matricola').AsString,'CELLULARE_PERSONALE');
end;

procedure TWA002FAnagrafeDM.selT030NewRecord(DataSet: TDataSet);
begin
  inherited;
  if (Parametri.DefTipoPersonale = 'E') and (Parametri.ModPersonaleEsterno = 'S') then
    selT030.FieldByName('TIPO_PERSONALE').AsString:='E'
  else
    selT030.FieldByName('TIPO_PERSONALE').AsString:='I';
end;

procedure TWA002FAnagrafeDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  //SELTABELLA SINCRONIZZATO CON SELT030
  selT030.Close;
  selT030.SetVariable('PROGRESSIVO',selTabella.GetVariable('PROGRESSIVO'));
  selT030.Open;
  A002FAnagrafeMW.selT430OldValues.CreaStruttura;
end;

procedure TWA002FAnagrafeDM.selTabellaPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  inherited;

  selT030.Cancel;
  A000SessioneWEB.RipristinaTimeOut;

  A002FAnagrafeMW.noTrigger(Istante,'N');
end;

procedure TWA002FAnagrafeDM.IWUserSessionBaseDestroy(Sender: TObject);
var i : Integer;
    Field : TField;
    FieldDef: TFieldDef;
begin
  FreeAndNil(A002FAnagrafeMW);
  FreeAndNil(QI010);//.Free;
  selT030.Close;
  selTabella.FieldDefs.BeginUpdate;
  for i:=0 to Length(DatiLiberiDM)- 1 do
  begin
    if DatiLiberiDM[i].Query <> nil then
    begin
      FreeAndNil(DatiLiberiDM[i].Query);
      FreeAndNil(DatiLiberiDM[i].Sorgente);
    end;
    field:=selTabella.FieldByName(DatiLiberiDM[i].Nome);
    FreeAndNil(field);
    FieldDef:=selTabella.FieldDefList.FieldByName(DatiLiberiDM[i].Nome);
    FreeAndNil(FieldDef);
  end;
  selTabella.FieldDefs.EndUpdate;
  selTabella.Close;
  inherited;
end;

end.
