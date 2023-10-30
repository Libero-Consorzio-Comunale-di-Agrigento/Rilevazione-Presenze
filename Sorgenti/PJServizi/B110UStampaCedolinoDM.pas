unit B110UStampaCedolinoDM;

interface

uses
  A000UCostanti,
  A000USessione,
  B110USharedTypes,
  B110UUtils,
  C180FunzioniGenerali,
  C200UWebServicesServerUtils,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  R015UDatasnapRestDM,
  W017UStampaCedolinoDM,
  Oracle,
  OracleData,
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.Types,
  Data.DB;

type
  TB110FStampaCedolinoDM = class(TR015FDatasnapRestDM)
    selP441: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdCedolino: Integer;
    FCumuloVociArretrate: Boolean;
    FStampaOrigineVoci: Boolean;
    procedure SetIdCedolino(Value: Integer);
    function CreaCedolinoPDF(POracleSession: TOracleSession;
      PMatricola: String; PIdCedolino: Integer; PCumuloVociArretrate: Boolean;
      PStampaOrigineVoci: Boolean;
      var RFilePdf: String;
      var RAzioneCedolino: TAzioneCedolino): String;
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property IdCedolino: Integer write SetIdCedolino;
    property CumuloVociArretrate: Boolean write FCumuloVociArretrate;
    property StampaOrigineVoci: Boolean write FStampaOrigineVoci;
  end;

implementation

uses
  A000UInterfaccia;

{$R *.dfm}

{ TB110FCedolinoDM }

procedure TB110FStampaCedolinoDM.DataModuleCreate(Sender: TObject);
begin
  inherited;

  FIdCedolino:=0;
  FCumuloVociArretrate:=False;
  FStampaOrigineVoci:=False;
end;

procedure TB110FStampaCedolinoDM.SetIdCedolino(Value: Integer);
begin
  if Value <= 0 then
    raise EC200InvalidParameter.CreateFmt('L''ID cedolino indicato non è valido: %d',[Value]);

  FIdCedolino:=Value;
end;

function TB110FStampaCedolinoDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // id cedolino
  if FIdCedolino = 0 then
  begin
    Result.Messaggio:='L''ID del cedolino non è indicato!';
    Exit;
  end;

  if FIdCedolino < 0 then
  begin
    Result.Messaggio:=Format('L''ID del cedolino non è valido: %d!',[FIdCedolino]);
    Exit;
  end;

  Result.Ok:=True;
end;

procedure TB110FStampaCedolinoDM.Esegui(var RRisultato: TRisultato);
var
  LNomeFilePdf: String;
  LPathFilePdf: String;
  LInfoOperaz: String;
  LResOperaz: String;
  LByteArrPdf: TByteDynArray;
  LAzioneCedolino: TAzioneCedolino;
  LDataCedolino: TDateTime;
begin
  // estrae info cedolino da P441
  selP441.Close;
  selP441.SetVariable('ID_CEDOLINO',FIdCedolino);
  selP441.Open;
  if selP441.RecordCount = 0 then
    raise EC200DataNotFoundError.CreateFmt('Il cedolino indicato non è presente in archivio [%d]',[FIdCedolino]);
  LDataCedolino:=selP441.FieldByName('DATA_CEDOLINO').AsDateTime;

  // determina il nome del file pdf e la posizione temporanea di salvataggio
  LNomeFilePdf:=Format('cedolino_%s_%s.pdf',[Parametri.MatricolaOper,FormatDateTime('mmmm_yyyy',LDataCedolino)]);
  LPathFilePdf:=TPath.Combine(TB110FUtils.GetTempFilePath,LNomeFilePdf);

  // genera il cartellino pdf
  LInfoOperaz:=Format('Cedolino di matr. %s, id %d, mese di %s',
                      [Parametri.MatricolaOper,
                       FIdCedolino,
                       FormatDateTime('mmmm yyyy',LDataCedolino)
                      ]);
  LResOperaz:=CreaCedolinoPDF(SIW.SessioneOracle,
                              Parametri.MatricolaOper,
                              FIdCedolino,
                              FCumuloVociArretrate,
                              FStampaOrigineVoci,
                              LPathFilePdf,
                              LAzioneCedolino);

  // indica il risultato dell'operazione
  if LResOperaz = '' then
    RRisultato.AddInfo(LInfoOperaz)
  else
    RRisultato.AddError(Format('%s - %s',[LResOperaz,LInfoOperaz]),'Errore durante la generazione del cedolino');

  LByteArrPdf:=TC200FWebServicesUtils.FileToByteArray(LPathFilePdf);

  RRisultato.Output:=TOutputStampaCedolino.Create;
  TOutputStampaCedolino(RRisultato.Output).Azione:=LAzioneCedolino;
  TOutputStampaCedolino(RRisultato.Output).MeseCedolino:=LDataCedolino;
  TOutputStampaCedolino(RRisultato.Output).FileCedolino:=TByteDynArrayWrapper.Create(LByteArrPdf);

  // cancella file temporaneo sul server
  TFile.Delete(LPathFilePdf);
end;

function TB110FStampaCedolinoDM.CreaCedolinoPDF(POracleSession: TOracleSession;
  PMatricola: String; PIdCedolino: Integer;
  PCumuloVociArretrate: Boolean; PStampaOrigineVoci: Boolean;
  var RFilePdf: String;
  var RAzioneCedolino: TAzioneCedolino): String;
// restituire una stringa vuota in caso di elaborazione ok,
// oppure il relativo messaggio di errore
var
  LPathModelliRave: String;
  LDataRetribuzione: TDateTime;
  W017DM: TW017FStampaCedolinoDM;
begin
  Result:='';

  // verifica e impostazione path modelli corretto
  LPathModelliRave:=TPath.Combine(A000GetHomePath,RAVE_MODEL_REL_PATH);
  if not TDirectory.Exists(LPathModelliRave) then
  begin
    Result:=Format('Il path dei modelli di stampa indicato è invalido o non accessibile: "%s". Verificare la variabile di ambiente HKLM\Software\IrisWin\HOME',[LPathModelliRave]);
    exit;
  end;

  W017DM:=TW017FStampaCedolinoDM.Create(nil);
  try
    try
      W017DM.selAnagrafeW:=W017DM.selAnagrafeApp;
      W017DM.W017CSStampa:=CSC200StampaRave;
      W017DM.RaveProjectPath:=LPathModelliRave;
      W017DM.TempPDFPath:=TB110FUtils.GetTempFilePath;

      // apertura del dataset dei cedolini sull'id_cedolino indicato
      W017DM.selP441.Close;
      W017DM.selP441.ClearVariables;
      W017DM.selP441.SetVariable('ID_CEDOLINO',PIdCedolino);
      W017DM.selP441.Open;
      W017DM.selP441.Filtered:=Parametri.WEBCedoliniFilePDF = 'S';

      if W017DM.selP441.RecordCount > 0 then
      begin
        LDataRetribuzione:=R180FineMese(StrToDate('01/' + W017DM.selP441.FieldByName('DATA_RETRIBUZIONE').AsString));

        // estrazione dati anagrafici alla data di retribuzione
        W017DM.selAnagrafeW.SetVariable('MATRICOLA',PMatricola);
        W017DM.selAnagrafeW.SetVariable('DATALAVORO',LDataRetribuzione);
        W017DM.selAnagrafeW.Close;
        W017DM.selAnagrafeW.Open;

        W017DM.GeneraCedolinoPDF(PMatricola,PCumuloVociArretrate,PStampaOrigineVoci,RFilePdf,RAzioneCedolino,Result);
      end
      else
      begin
        Result:='Il cedolino richiesto non è disponibile!';
      end;
    except
      on E: Exception do
      begin
        Result:=Format('Errore durante la stampa del cedolino: %s',[E.Message]);
      end;
    end;
  finally
    FreeAndNil(W017DM);
  end;
end;

end.
