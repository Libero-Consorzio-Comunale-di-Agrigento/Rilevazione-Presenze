unit B110UWebServiceEnteDM;

interface

uses
  A000UCostanti,
  B110USharedTypes,
  B110UUtils,
  C200UWebServicesTypes,
  R015UDatasnapRestDM,
  System.SysUtils,
  System.Classes,
  Data.DB,
  OracleData,
  Oracle;

type
  TB110FWebServiceEnteDM = class(TR015FDatasnapRestDM)
    selR010: TOracleDataSet;
    SessioneMEDP: TOracleSession;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdAzienda: String;
    procedure SetIdAzienda(Value: String);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property IdAzienda: String write SetIdAzienda;
  end;

implementation

{$R *.dfm}

{ TB110FWebServiceEnteDM }

procedure TB110FWebServiceEnteDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FIdAzienda:='';
end;

procedure TB110FWebServiceEnteDM.SetIdAzienda(Value: String);
begin
  // controllo parametro "dato"
  if Value = '' then
    raise EC200InvalidParameter.Create('Il parametro Id Azienda non può essere vuoto!');

  FIdAzienda:=Value;
end;

function TB110FWebServiceEnteDM.ControlloParametri: TResCtrl;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // controllo parametro "Id Azienda"
  if FIdAzienda = '' then
  begin
    Result.Messaggio:=Format('Il parametro Id Azienda non è indicato',[]);
    Exit;
  end;

  Result.Ok:=True;
end;

procedure TB110FWebServiceEnteDM.Esegui(var RRisultato: TRisultato);
var
  LRes: TOutputWebServiceEnte;
begin
  // viene usata una connessione particolare
  SessioneMEDP.LogonDatabase:=TB110FParametriServer.Default_Database;
  try
    SessioneMEDP.LogOn;
  except
    on E: Exception do
      raise EC200NoConnection.Create(
        Format('Connessione al database [%s] fallita: %s',[SessioneMEDP.LogonDatabase,E.Message]),
        'Errore di connessione al database');
  end;

  try
    // apre dataset e restituisce dati
    selR010.Session:=SessioneMEDP;
    selR010.Close;
    selR010.SetVariable('ID',FIdAzienda);
    selR010.Open;
    if selR010.RecordCount > 0 then
    begin
      RRisultato.Output:=TOutputWebServiceEnte.Create;
      LRes:=TOutputWebServiceEnte(RRisultato.Output);
      LRes.IdAzienda:=selR010.FieldByName('ID').AsString;
      LRes.Azienda:=selR010.FieldByName('AZIENDA').AsString;
      LRes.WSInfo.TipoServer:=TTipoServerRec.Aziendale;
      LRes.WSInfo.Host:=selR010.FieldByName('HOST').AsString;
      LRes.WSInfo.Port:=selR010.FieldByName('PORT').AsInteger;
      LRes.WSInfo.Protocol:=selR010.FieldByName('PROTOCOL').AsString;
      LRes.WSInfo.UrlPath:=selR010.FieldByName('URL_PATH').AsString;
      RRisultato.AddInfo('Informazioni ente reperite correttamente');
    end
    else
    begin
      // id azienda non presente in archivio
      raise EC200DataNotFoundError.CreateFmt('Id Azienda inesistente [%s]',[FIdAzienda]);
    end;
  finally
    if selR010.Active then
      selR010.Close;
    if SessioneMEDP.Connected then
      SessioneMEDP.LogOff;
  end;
end;

end.
