unit B110UStampaCartellinoDM;

interface

uses
  A000UCostanti,
  A000USessione,
  B110USharedTypes,
  B110UUtils,
  C180FunzioniGenerali,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  C200UWebServicesServerUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  W009UStampaCartellinoDtm,
  System.DateUtils,
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.Types,
  Oracle,
  OracleData;

type
  TB110FStampaCartellinoDM = class(TR015FDatasnapRestDM)
    procedure DataModuleCreate(Sender: TObject);
  private
    FMeseCartellino: TDateTime;
    FCodParamStampa: String;
    procedure SetMeseCartellino(Value: TDateTime);
    procedure SetCodParamStampa(Value: String);
    function CreaCartellinoPDF(POracleSession: TOracleSession;
      pMatricola: String; DataI, DataF: TDateTime; CodParStampa, FilePdf,
      CartelliniChiusi: String): String;
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property MeseCartellino: TDateTime write SetMeseCartellino;
    property CodParamStampa: String write SetCodParamStampa;
  end;

implementation

{$R *.dfm}

uses
  A000UInterfaccia;

procedure TB110FStampaCartellinoDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FMeseCartellino:=DATE_NULL;
  FCodParamStampa:='';
end;

procedure TB110FStampaCartellinoDM.SetCodParamStampa(Value: String);
begin
  if Value = '' then
    raise EC200InvalidParameter.Create('Il codice di parametrizzazione stampa cartellino non è indicato!');

  FCodParamStampa:=Value;
end;

procedure TB110FStampaCartellinoDM.SetMeseCartellino(Value: TDateTime);
begin
  if Value = DATE_NULL then
    raise EC200InvalidParameter.Create('Il mese di stampa del cartellino non è indicato!');

  FMeseCartellino:=Value;
end;

function TB110FStampaCartellinoDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // mese cartellino
  if FMeseCartellino = DATE_NULL then
  begin
    Result.Messaggio:='Il mese di stampa del cartellino non è indicato!';
    Exit;
  end;

  // parametrizzazione di stampa
  if FCodParamStampa = '' then
  begin
    Result.Messaggio:='Il codice di parametrizzazione di stampa non è indicato!';
    Exit;
  end;

  // tutto ok
  Result.Ok:=True;
end;

procedure TB110FStampaCartellinoDM.Esegui(var RRisultato: TRisultato);
var
  LNomeFilePdf: String;
  LPathFilePdf: String;
  LInfoOperaz: String;
  LResOperaz: String;
  LCartelliniChiusi: String;
  LDataInizio: TDateTime;
  LDataFine: TDateTime;
  LByteArrPdf: TByteDynArray;
begin
  // determina parametri richiesta per stampa cartellino
  LDataInizio:=FMeseCartellino.StartOfMonth.Date;
  LDataFine:=FMeseCartellino.EndOfMonth.Date;

  // determina il nome del file pdf e la posizione temporanea di salvataggio
  LNomeFilePdf:=Format('%s_%s.pdf',['cart',FormatDateTime('yyyymmdd-hhhhmmsszzz',Now)]);
  LPathFilePdf:=TPath.Combine(TB110FUtils.GetTempFilePath,LNomeFilePdf);
  LCartelliniChiusi:='N';

  // genera il cartellino pdf
  LInfoOperaz:=Format('Cartellino di %s, dal %s al %s, param. %s, cartellini chiusi %s',
                      [Parametri.MatricolaOper,
                       LDataInizio.ToString,
                       LDataFine.ToString,
                       FCodParamStampa,
                       LCartelliniChiusi
                      ]);

  LResOperaz:=CreaCartellinoPDF(SIW.SessioneOracle,
                                Parametri.MatricolaOper,
                                LDataInizio,
                                LDataFine,
                                FCodParamStampa,
                                LPathFilePdf,
                                LCartelliniChiusi);

  // indica il risultato dell'operazione
  if LResOperaz = '' then
  begin
    if TFile.Exists(LPathFilePdf) then
    begin
      LByteArrPdf:=TC200FWebServicesUtils.FileToByteArray(LPathFilePdf);

      //RRisultato.Output:=TGenericWrapper<TByteDynArray>.Create(LByteArrPdf);
      //RRisultato.Output:=TGenericWrapper<String>.Create('ciao');
      //RRisultato.Output:=TFileStream.Create(LFilePdf,fmOpenread);
      RRisultato.Output:=TByteDynArrayWrapper.Create(LByteArrPdf);

      // cancella file temporaneo sul server
      TFile.Delete(LPathFilePdf);

      RRisultato.AddInfo(LInfoOperaz);
    end
    else
    begin
      RRisultato.AddError(Format('Il file PDF del cartellino non è stato creato [%s]',[LPathFilePdf]),'Il cartellino PDF non è stato creato!');
    end;
  end
  else
  begin
    RRisultato.AddError(LResOperaz,'Errore durante la generazione del cartellino');
  end;
end;

function TB110FStampaCartellinoDM.CreaCartellinoPDF(POracleSession: TOracleSession;
  pMatricola: String; DataI,DataF: TDateTime;
  CodParStampa,FilePdf,CartelliniChiusi: String): String;
var
  A,M,G,A2,M2,G2:Word;
  iSQL:Integer;
  S,SQLText:String;
  CodiceT950:String;
  lst:TStringList;
  PathModelliRave: String;
  W009FStampaCartellinoDtm: TW009FStampaCartellinoDtm;
begin
  Result:='';

  // verifica e impostazione path modelli corretto
  PathModelliRave:=TPath.Combine(A000GetHomePath,RAVE_MODEL_REL_PATH);
  if not TDirectory.Exists(PathModelliRave) then
  begin
    Result:=Format('Il path dei modelli di stampa indicato è invalido o non accessibile: "%s". Verificare la variabile di ambiente HKLM\Software\IrisWin\HOME',[PathModelliRave]);
    exit;
  end;

  Parametri.WEBCartelliniDataMin:=0;
  Parametri.WEBCartelliniMMPrec:=-1;
  Parametri.WEBCartelliniMMSucc:=-1;
  Parametri.WEBCartelliniChiusi:=CartelliniChiusi;

  // verifica parametri
  if DataF < DataI then
  begin
    Result:='Date non corrette!';
    exit;
  end;
  if R180Anno(DataI) <> R180Anno(DataF) then
  begin
    Result:='Le date devono essere riferite allo stesso anno!';
    exit;
  end;
  if DataI < Parametri.WEBCartelliniDataMin then
  begin
    Result:=Format('Non è possibile elaborare il cartellino prima del %s!',[DateToStr(Parametri.WEBCartelliniDataMin)]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMPrec >= 0) and (R180AddMesi(R180InizioMese(DataI),Parametri.WEBCartelliniMMPrec) < R180InizioMese(Date)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino antecedente di %d mesi!',[Parametri.WEBCartelliniMMPrec]);
    exit;
  end;
  if (Parametri.WEBCartelliniMMSucc >= 0) and (R180InizioMese(DataF) > R180AddMesi(R180InizioMese(Date),Parametri.WEBCartelliniMMSucc)) then
  begin
    Result:=Format('Non è possibile elaborare il cartellino successivo a %d mesi!',[Parametri.WEBCartelliniMMSucc]);
    exit;
  end;

  // creazione datamodule
  W009FStampaCartellinoDtm:=TW009FStampaCartellinoDtm.Create(nil);
  try //except
    try  //finally
      W009FStampaCartellinoDtm.Sessione:=POracleSession;
      W009FStampaCartellinoDtm.selAnagrafeW:=W009FStampaCartellinoDtm.selAnagrafeApp;
      W009FStampaCartellinoDtm.selAnagrafeW.Session:=POracleSession;
      W009FStampaCartellinoDtm.CartelliniChiusi:=Parametri.WEBCartelliniChiusi = 'S';
      W009FStampaCartellinoDtm.Stampa:=True;
      W009FStampaCartellinoDtm.RegLog:=False;
      W009FStampaCartellinoDtm.RaveProjectFile:=TPath.Combine(PathModelliRave,RAVE_MODEL_CARTELLINO);
      W009FStampaCartellinoDtm.NomeFile:=FilePDF;
      W009FStampaCartellinoDtm.RaveOutputFileName:=FilePDF;

      SQLText:=W009FStampaCartellinoDtm.selAnagrafeW.SQL.Text;
      CodiceT950:=CodParStampa;
      DecodeDate(DataI,A,M,G);
      DecodeDate(DataF,A2,M2,G2);

      //Se le date differiscono di mese o di anno, allora i giorni vanno
      //da 1 all'ultimo del mese
      if (M <> M2) or (A <> A2) then
      begin
        G:=1;
        G2:=R180GiorniMese(DataF);
        DataI:=EncodeDate(A,M,G);
        DataF:=EncodeDate(A2,M2,G2);
      end;

      W009FStampaCartellinoDtm.DataF:=DataF;

      // conteggi cartellino
      W009FStampaCartellinoDtm.CreazioneR400(POracleSession);
      W009FStampaCartellinoDtm.R400FCartellinoDtM.R450DtM1.Name:=''; //Altrimenti duplicazione sul nome quando viene creata la R450 dalla R600 per i conteggi di alcune assenze
      W009FStampaCartellinoDtm.R400FCartellinoDtM.R600DtM1.Name:='';
      W009FStampaCartellinoDtm.R400FCartellinoDtM.R410FAutoGiustificazioneDtM.Name:='';

      // no aggiornamento buoni pasto
      //if ... then
      //  W009FStampaCartellinoDtM.CreazioneR350;

      // no aggiornamento accessi mensa
      //if ... then
      //  W009FStampaCartellinoDtM.CreazioneR300(DataI,DataF);

      with W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int do
      begin
        Close;
        SetVariable('Codice',CodiceT950);
        Open;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selDatiBloccati.Close;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.SoloAggiornamento:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AggiornamentoScheda:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.AutoGiustificazione:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.CalcoloCompetenze:=False;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstDettaglio.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.lstRiepilogo.Clear;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Intestazione');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Dettaglio');
      W009FStampaCartellinoDtM.R400FCartellinoDtM.LeggiDatiRichiesti('Riepilogo');

      W009FStampaCartellinoDtm.selAnagrafeW.SetVariable('MATRICOLA',pMatricola);
      W009FStampaCartellinoDtm.selAnagrafeW.SetVariable('DATALAVORO',DataF);
      W009FStampaCartellinoDtm.selAnagrafeW.Close;
      if (Pos(W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione,W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text) = 0) and
         ((Pos('T030.*',W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text) = 0) or (Pos('V430.*',W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text) = 0)) then
      begin
        S:=W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text;
        iSQL:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
        if iSQL > 0 then
          Insert(',' + W009FStampaCartellinoDtM.R400FCartellinoDtM.CampiIntestazione + ' ',S,iSQL);
        W009FStampaCartellinoDtm.SelAnagrafeW.SQL.Text:=S;
      end;
      try
        W009FStampaCartellinoDtm.selAnagrafeW.Open;
      except
        on E: Exception do
        begin
          raise Exception.Create(Format('La parametrizzazione di stampa contiene campi di intestazione non validi: %s',[E.Message]));
        end;
      end;

      if W009FStampaCartellinoDtm.selAnagrafeW.SearchRecord('MATRICOLA',pMatricola,[srFromBeginning]) then
      begin
        S:=W009FStampaCartellinoDtM.R400FCartellinoDtM.CheckValidazione2Parametrizzazione(W009FStampaCartellinoDtm.selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,DataI,DataF);
        if S <> '' then
        begin
          //Result:=S;
          //Abort;
          raise Exception.Create(S);
        end;
      end;

      lst:=TStringList.Create;
      with W009FStampaCartellinoDtM.R400FCartellinoDtM do
      try
        SetLength(VetDatiLiberiSQL,0);
        selT951.Close;
        selT951.SetVariable('Codice',Q950Int.FieldByName('CODICE').AsString);
        selT951.Open;
        while not selT951.Eof do
        begin
          lst.Add(Trim(selT951.FieldByName('RIGA').AsString));
          selT951.Next;
        end;
        selT951.Close;
        W009FStampaCartellinoDtM.GetLabels(lst,'Riepilogo2001',nil);
        //Devo già avere l'elenco dei dati liberi 2001
        CreaClientDataSet(W009FStampaCartellinoDtm.selAnagrafeW);
      finally
        lst.Free;
      end;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=W009FStampaCartellinoDtm.selAnagrafeW;
      //Posizionamento sulla matricola correntemente selezionata
      if W009FStampaCartellinoDtm.selAnagrafeW.SearchRecord('MATRICOLA',pMatricola,[srFromBeginning]) then
        Result:=W009FStampaCartellinoDtM.CalcoloCartellini(A,M,G,A2,M2,G2)
      else
      begin
        Result:='Anagrafico non disponibile!';
        Abort;
      end;
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      //Chiudo subito le query e le unit dei conteggi, salvo Q950Int e selT004 che serve in stampa
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.Open;
      W009FStampaCartellinoDtM.R400FCartellinoDtM.selT004.Open;
      W009FStampaCartellinoDtM.ChiusuraQuery(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
      FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R450DtM1);
      FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R600DtM1);
      try
       if W009FStampaCartellinoDtM.R400FCartellinoDtM.cdsRiepilogo.RecordCount > 0 then
       begin
         W009FStampaCartellinoDtM.W009CSStampa:=CSC200StampaRave;
         W009FStampaCartellinoDtm.RPDefine_DataID(B110USharedTypes.SIGLA_SERVIZIO);
         Result:=W009FStampaCartellinoDtM.EsecuzioneStampa;
       end
       else
         Result:='Nessun cartellino disponibile nel periodo specificato!';
      except
        on E:Exception do
          Result:=E.Message;
      end;
      with W009FStampaCartellinoDtM.R400FCartellinoDtM do
      begin
        cdsRiepilogo.Close;
        cdsDettaglio.Close;
        cdsSettimana.Close;
        cdsAssenze.Close;
        cdsPresenze.Close;
        Q950Int.CloseAll;
      end;
    finally
      W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.CloseAll;
      W009FStampaCartellinoDtm.selAnagrafeW.CloseAll;
      if W009FStampaCartellinoDtM.R400FCartellinoDtM <> nil then
      begin
        W009FStampaCartellinoDtM.R400FCartellinoDtM.Q950Int.CloseAll;
        W009FStampaCartellinoDtM.R400FCartellinoDtM.A027SelAnagrafe:=nil;
        if W009FStampaCartellinoDtM.R400FCartellinoDtM.R300DtM <> nil then
          FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R300DtM);
        if W009FStampaCartellinoDtM.R400FCartellinoDtM.R350DtM <> nil then
          FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM.R350DtM);
        FreeAndNil(W009FStampaCartellinoDtM.R400FCartellinoDtM);
      end;
      W009FStampaCartellinoDtM.DistruggiLstRaveComp;
      FreeAndNil(W009FStampaCartellinoDtm);
    end;
  except
    on E:Exception do
      Result:=E.Message;
  end;
end;

end.
