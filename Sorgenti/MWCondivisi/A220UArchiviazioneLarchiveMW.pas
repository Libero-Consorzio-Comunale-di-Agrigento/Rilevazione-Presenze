unit A220UArchiviazioneLArchiveMW;

interface

uses
  System.SysUtils, System.Classes, System.Types, R005UDataModuleMW, StrUtils, Generics.Collections,
  System.Hash, IdGlobal, IdCoderMIME, Generics.Defaults, System.Net.Mime,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent, IOUtils,
  Data.DB, Datasnap.DBClient, OracleData, A000UInterfaccia, Xml.xmldom,
  Xml.XMLIntf, Xml.XMLDoc, A000UCostanti, IdGlobalProtocols, Oracle, System.JSON, Variants;

type

  TDocumentoDaArchiviare = class(TObject)
  private
    procedure ValidaNomeFile;
    procedure CalcolaSHA512;
    function GetFullPathDocumento: String;
    function GetFullPathMetadata: String;
  public
    Id: String;
    IdNumerico: Integer; //=0 nel caso del cartellino!!!
    Tipo: String;
    Nome: String;
    Estensione: String;
    Path: String;
    DataCreazione: TDateTime;
    HashSHA512: String;

    constructor Create(PFullPath: String);

    property FullPathDocumento: String read GetFullPathDocumento;
    property FullPathMetadata: String read GetFullPathMetadata;

    function DocumentoExist: Boolean;
    function MetadataExist: Boolean;
    procedure EliminaFile;
    function GetMultipartFormData(bucketId: String; userPdaId: String = ''): TMultipartFormData;
  end;

  TListaDocumenti = class(TObjectList<TDocumentoDaArchiviare>)
  private

  public
    constructor Create(AOwnsObject: boolean = True);

    function IndexOfId(PId, PTipo: String): Integer;
    procedure RemoveById(PId, PTipo: String);
    function CaricaDocumento(PFullPath: String): Integer;

    class function FileFilter(const Path: string; const SearchRec: TSearchRec): Boolean;
  end;

  TA220FArchiviazioneLarchiveMW = class(TR005FDataModuleMW)
    cdsFileCaricati: TClientDataSet;
    cdsFileCaricatiID_DOCUMENTO: TStringField;
    cdsFileCaricatiTIPO_DOCUMENTO: TStringField;
    cdsFileCaricatiNOME_FILE: TStringField;
    cdsFileCaricatiPATH: TStringField;
    cdsFileCaricatiDATA_CREAZIONE: TDateTimeField;
    cdsFileCaricatiSTATO_TRASMISSIONE: TStringField;
    HTTPClient: TNetHTTPClient;
    HTTPRequest: TNetHTTPRequest;
    dsrFileCaricati: TDataSource;
    selI220a: TOracleDataSet;
    dsrselI220a: TDataSource;
    selI220b: TOracleDataSet;
    selI220c: TOracleDataSet;
    insI220: TOracleQuery;
    selI220aDATA_TRASMISSIONE: TDateTimeField;
    selI220aTIPO_DOCUMENTO: TStringField;
    selI220aDOCUSERID: TStringField;
    selI220aDOCFILENAME: TStringField;
    selI220aDATA_CREAZIONE: TDateTimeField;
    selI220aDOCHASH: TStringField;
    selI220aBUCKETID: TStringField;
    selI220aUSERPDVID: TStringField;
    selI220aPDVID: TStringField;
    selI220aPDVSTATUS: TStringField;
    selI220aPDVSTATUSMESSAGE: TStringField;
    selI220aERRORMESSAGE: TStringField;
    selI220aID_TRASMISSIONE: TFloatField;
    updI220: TOracleQuery;
    selI220aUPLOADDATE: TDateTimeField;
    selI210: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure InviaDocumento(PIndex: Integer);
    procedure AggiornaPdvStatus;
    procedure LogRisposta(PHTTPResponse: IHTTPResponse; Hash: String);
    procedure GestisciRispostaVersamento(PHTTPResponse: IHTTPResponse; PIndex: Integer; PBucketId: String);
    procedure GestisciRispostaStato(PHTTPResponse: IHTTPResponse);
  public
    ListaDocumenti: TListaDocumenti;
    PresenzaAnomalie: Boolean;
    TerminaElaborazione: Boolean;
    EliminaFile: Boolean;

    ResettaProgressBarPdvStatus:TprocNone;
    IncrementaProgressBarPdvStatus:TprocNone;
    MaxProgressBarPdvStatus:TprocInteger;
    ScriviStatusBarPdvStatus:TprocString;

    function ValidazioneTokenJWT: Boolean;
    procedure InviaDocumenti;
    procedure AggiornaStatoDocumenti;
    procedure CaricaListaDocumenti(PPath: String; var PListaGiaPresenti: TStringList);
    function CaricaDocumento(PFullPath: String): Boolean;
    procedure CancellaDocumento;
    procedure Clear;

    procedure AggiornaFiltroStorico(PInizio, PFine: TDateTime; PDocUserId, PPdvStatus, PTipoDocumento, PDocFileName, PId: String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA220FArchiviazioneLarchiveMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ListaDocumenti:=TListaDocumenti.Create;
  cdsFileCaricati.CreateDataSet;
  PresenzaAnomalie:=False;
  TerminaElaborazione:=False;
  EliminaFile:=False;

  //TEST
  {Parametri.CampiRiferimento.C45_LArchive_ProducerId:='5ceebbf5-c867-442a-8998-be417596187c';
  Parametri.CampiRiferimento.C45_LArchive_TokenJWT:='eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjI1RkI4NzUwNjg5NERCRTYwMUM4MkJEMUJEMjlGQ'+'jgzNUUxQUQxRjQifQ.eyJzdWIiOiJMQXJjaGl2ZSIsIm5hdHVyZSI6IkFQUFRPS0VOIiwidXNlcl9uYW1lIjoiYXNzdF92YWx0ZWxsaW5hX3dzIiwiaXAiOiI'+'xMC42NC4xNS4xNDciLCJpc3MiOiJBcnViYSBQRUMiLCJkZWxlZ2F0aW9ucyI6eyJhc3N0X3ZhbHQiOiI1Y2VlYmJmNS1jODY3LTQ0MmEtODk5OC1iZTQxNzU5NjE4N2M'+'ifSwibG9jYWxlIjoiSVRBTElBTiIsImF1dGhvcml0aWVzIjpbIlJPTEVfQURNSU5fTElTUEEiLCJST0xFX0FETUlOIl0sImNsaWVudF9pZCI6ImRmLWFkbWlu'+'IiwiY2hhbmdlX3Bhc3N3b3JkIjpmYWxzZSwiY2hhbm5lbHMiOlsiV1MiXSwicHJvdmlkZXIiOiJBTFRSTyIsInVzZXJfaWQiOiI4NTEyZGU3OS00Yjg5LTRiMzQt'+'OWYxNy1iMWM5OGE4Njk2NWYiLCJzY29wZSI6WyJjdXN0b20iXSwiZXhwIjoxNjM2Mjk1NDQ5LCJqdGkiOiJmNDlhNDhjZC1lYWIxLTRjNWEtOTM3OC1iZWY4OThiNWMwY2'+'MiLCJzdGF0dXMiOiJBQ1RJVkUifQ.e8xMTzevSGaayRCCmKplqtoOh8JuUFLiR36vsx3ZMRLKxpPIMVZLEVX6CmIRMIgvZoJsTPCgKGxl08jfZWdU1TNxLemoSv138'+'4VFrIDTrmvYpM8iwGFxivoRFhvVWrdO7On4A3i0X8xJqeERLWJ3osCmClj8Cr-A7ML3PPoOcNJb8SaE3NKV1iS6J9CYlhVsiDS8itbMWOpuZRW2RTIGkVTHCY-Jrdy2'+'GvYhJdp6KoRPGx1QKXyLbb1xDpKjr83VGjH6R-9AsLr-KxC5yYfBHEM3OeKFBBGjC2bbW0qEivpv2wGWjvtaISkKEQ66NK3Yk77Xs2f8GYZtEZJqbzzETw';
  Parametri.CampiRiferimento.C45_LArchive_Scadenza_TokenJWT:='07/11/2021';
  Parametri.CampiRiferimento.C45_LArchive_URL_Versamento:='http://10.128.6.131/kxa/pdv/uploadqueue';
  Parametri.CampiRiferimento.C45_LArchive_URL_Stato:='https://demo.larchive.it/api/v2/pdv/status';}
  //FINE TEST
end;

procedure TA220FArchiviazioneLarchiveMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(ListaDocumenti);
end;

//aggiorno il filtro sullo storico delle trasmissioni
procedure TA220FArchiviazioneLarchiveMW.AggiornaFiltroStorico(PInizio, PFine: TDateTime; PDocUserId, PPdvStatus, PTipoDocumento, PDocFileName, PId: String);
var LId: Integer;
begin
  with selI220a do
  begin
    Close;

    SetVariable('DATA_INIZIO', PInizio);
    SetVariable('DATA_FINE', PFine);

    if (Trim(PId) <> '') and TryStrToInt(Trim(PId), LId) then
      SetVariable('ID_TRASMISSIONE', 'AND ID_TRASMISSIONE=''' +  Trim(PId) + '''')
    else
      SetVariable('ID_TRASMISSIONE', '');

    if Trim(PPdvStatus) <> '' then
      SetVariable('PDVSTATUS', 'AND PDVSTATUS=''' +  Trim(PPdvStatus) + '''')
    else
      SetVariable('PDVSTATUS', '');

    if Trim(PTipoDocumento) <> '' then
      SetVariable('TIPO_DOCUMENTO', 'AND TIPO_DOCUMENTO=''' + Trim(PTipoDocumento) + '''')
    else
      SetVariable('TIPO_DOCUMENTO', '');

    if Trim(PDocUserId) <> '' then
    begin
      if Pos('%', Trim(PDocUserId)) > 0 then
      begin
        SetVariable('DOCUSERID', 'AND UPPER(DOCUSERID) LIKE ''' +  Uppercase(Trim(PDocUserId)) + '''')
      end
      else
      begin
        SetVariable('DOCUSERID', 'AND UPPER(DOCUSERID) = ''' +  Uppercase(Trim(PDocUserId)) + '''')
      end;
    end
    else
      SetVariable('DOCUSERID', '');

    if Trim(PDocFileName) <> '' then
    begin
      if Pos('%', Trim(PDocFileName)) > 0 then
      begin
        SetVariable('DOCFILENAME', 'AND UPPER(DOCFILENAME) LIKE ''' +  Uppercase(Trim(PDocFileName)) + '''')
      end
      else
      begin
        SetVariable('DOCFILENAME', 'AND UPPER(DOCFILENAME) = ''' +  Uppercase(Trim(PDocFileName)) + '''')
      end;
    end
    else
      SetVariable('DOCFILENAME', '');

    Open;
  end;
end;

procedure TA220FArchiviazioneLarchiveMW.AggiornaStatoDocumenti;
begin
  selI220a.DisableControls;
  try
    with selI220a do
    begin
      First;
      PresenzaAnomalie:=False;
      TerminaElaborazione:=False;
      RegistraMsg.IniziaMessaggio('A220');

      if Assigned(ResettaProgressBarPdvStatus) then
        ResettaProgressBarPdvStatus;

      if Assigned(MaxProgressBarPdvStatus) then
        MaxProgressBarPdvStatus(selI220a.RecordCount);

      while not Eof do
      begin
        try
          try
            if Assigned(IncrementaProgressBarPdvStatus) then
              IncrementaProgressBarPdvStatus;

            if TerminaElaborazione then
              break;

            ScriviStatusBarPdvStatus('Documenti: ' + selI220a.RecNo.ToString + '/' + selI220a.RecordCount.ToString);
            if (selI220a.FieldByName('PDVSTATUS').AsString <> 'ARCHIVED') and (selI220a.FieldByName('USERPDVID').AsString <> '') then
              AggiornaPdvStatus;
            //Sleep(500);  //TEST
          except
            on E: Exception do
            begin
              PresenzaAnomalie:=True;
              RegistraMsg.InserisciMessaggio('A', 'Id trasmissione: ' + selI220a.FieldByName('ID_TRASMISSIONE').AsString + ' - '  + e.Message);
            end;
          end;
        finally
          Next;
        end;
      end;
    end;
  finally
    selI220a.Refresh;
    selI220a.EnableControls;

    if Assigned(ResettaProgressBarPdvStatus) then
        ResettaProgressBarPdvStatus;
  end;
end;

//da ripetere su tutti i record di selI220a
procedure TA220FArchiviazioneLarchiveMW.AggiornaPdvStatus;
var HTTPResponse: IHTTPResponse;
    HTTPHeaders: TArray<TNameValuePair>;
    JsonToSend: TStringStream;
    Json: string;
begin
  HTTPHeaders:=TArray<TNameValuePair>.Create
  (
    TNameValuePair.Create('Authorization','Bearer ' + Parametri.CampiRiferimento.C45_LArchive_TokenJWT),
    TNameValuePair.Create('X-Channel','WS'),
    TNameValuePair.Create('X-Delegate-Producer', Parametri.CampiRiferimento.C45_LArchive_ProducerId)
  );

  Json:='{"userPdvId":"' + selI220a.FieldByName('USERPDVID').AsString + '"}';
  JsonToSend:=TStringStream.Create(Json, TEncoding.UTF8);
  try
    HTTPClient.ContentType:='application/json';
    HTTPResponse:=HTTPRequest.Post(Parametri.CampiRiferimento.C45_LArchive_URL_Stato, JsonToSend, nil, HTTPHeaders);

    if (HTTPResponse.StatusCode = 200) or (HTTPResponse.StatusCode = 400) then
      GestisciRispostaStato(HTTPResponse)
    else
      raise Exception.Create('Errore nella comunicazione con l''endpoint di aggiornamento - HTTP status: ' + HTTPResponse.StatusCode.ToString + ' - ' + HTTPResponse.StatusText + ' - ' + HTTPResponse.ContentAsString);
  finally
    FreeAndNil(JsonToSend);
  end;
end;

//gestisco la risposta ritornata in formato JSON
procedure TA220FArchiviazioneLarchiveMW.GestisciRispostaStato(PHTTPResponse: IHTTPResponse);
var PdvId, PdvStatus, PdvStatusMessage, ErrorMessage: string;
    UploadDate: TDateTime;
    JSONResponse, DataJSON: TJSONValue;
    JSONArray: TJSONArray;
    i: Integer;
begin
  try
    JSONResponse:=TJSONObject.ParseJSONValue(PHTTPResponse.ContentAsString);
  except
    on E: Exception do
      raise Exception.Create('Formato della risposta JSON non valido: ' + E.Message + ' - ' + PHTTPResponse.ContentAsString);
  end;
  try
    if PHTTPResponse.StatusCode = 200 then
    begin
      try
        if JSONResponse.TryGetValue<TJSONValue>('data', DataJSON) then
        begin
          PdvId:=DataJSON.GetValue<String>('pdvId');
          PdvStatus:=DataJSON.GetValue<String>('pdvStatus');
          PdvStatusMessage:=DataJSON.GetValue<String>('pdvStatusMessage');
          UploadDate:=GMTToLocalDateTime(DataJSON.GetValue<String>('uploadDate'));

          updI220.SetVariable('ID_TRASMISSIONE', selI220a.FieldByName('ID_TRASMISSIONE').AsInteger);
          updI220.SetVariable('UPLOADDATE', UploadDate);
          updI220.SetVariable('PDVID', PdvId);
          updI220.SetVariable('PDVSTATUS', PdvStatus);
          updI220.SetVariable('PDVSTATUSMESSAGE', PdvStatusMessage);
          updI220.SetVariable('ERRORMESSAGE', '');
          updI220.Execute;
          SessioneOracle.Commit;
        end
        else          //se ci sono errori
        begin
          JSONArray:=JSONResponse.GetValue<TJSONArray>('errors');

          for i:=0 to JSONArray.Count-1 do
          begin
            ErrorMessage:=ErrorMessage + JSONArray.Items[i].GetValue<String>('code') + ' - ';
            ErrorMessage:=ErrorMessage + JSONArray.Items[i].GetValue<String>('message') + ' - ';
            ErrorMessage:=ErrorMessage + JSONArray.Items[i].GetValue<String>('detailedMessage');
            if i <> (JSONArray.Count-1) then
              ErrorMessage:=ErrorMessage + ' / ';
          end;

          updI220.SetVariable('ID_TRASMISSIONE', selI220a.FieldByName('ID_TRASMISSIONE').AsInteger);
          updI220.SetVariable('UPLOADDATE', selI220a.FieldByName('UPLOADDATE').AsDateTime);
          updI220.SetVariable('PDVID', selI220a.FieldByName('PDVID').AsString);
          updI220.SetVariable('PDVSTATUS', selI220a.FieldByName('PDVSTATUS').AsString);
          updI220.SetVariable('PDVSTATUSMESSAGE', selI220a.FieldByName('PDVSTATUSMESSAGE').AsString);
          updI220.SetVariable('ERRORMESSAGE', ErrorMessage);
          updI220.Execute;
          SessioneOracle.Commit;
        end;
      except
        on E: Exception do
          raise Exception.Create('Errore nel salvataggio della risposta JSON: ' + E.Message + ' - ' + PHTTPResponse.ContentAsString);
      end;
    end
    else if PHTTPResponse.StatusCode = 400 then
    begin
      JSONArray:=JSONResponse.GetValue<TJSONArray>('errors');

      for i:=0 to JSONArray.Count-1 do
      begin
        if JSONArray.Items[i].GetValue<String>('code') = 'RESOURCENOTFOUND' then
          raise Exception.Create('Documento non trovato nel sistema di archiviazione LArchive, se risulta correttamente trasmesso potrebbe essere ancora in elaborazione da parte del FlyAdapter');
      end;

      raise Exception.Create('Errore nella comunicazione con l''endpoint di aggiornamento - HTTP status: ' + PHTTPResponse.StatusCode.ToString + ' - ' + PHTTPResponse.StatusText + ' - ' + PHTTPResponse.ContentAsString);
    end;
  finally
    FreeAndNil(JSONResponse);
  end;
end;

//invio tutti i documenti della lista caricati
procedure TA220FArchiviazioneLarchiveMW.InviaDocumenti;
var i: Integer;
begin
  if Assigned(ResettaProgressBar) then
    ResettaProgressBar;

  if Assigned(MaxProgressBar) then
    MaxProgressBar(ListaDocumenti.Count);

  cdsFileCaricati.DisableControls;
  try
    PresenzaAnomalie:=False;
    TerminaElaborazione:=False;
    RegistraMsg.IniziaMessaggio('A220');
    for i:=0 to ListaDocumenti.Count-1 do
    begin
      try
        if Assigned(IncrementaProgressBar) then
          IncrementaProgressBar;

        if TerminaElaborazione then
          break;

        ScriviStatusBar('Documenti: ' + (i+1).ToString + '/' + ListaDocumenti.Count.ToString);
        InviaDocumento(i);
        //Sleep(500); //test
      except
        on E: Exception do
        begin
          PresenzaAnomalie:=True;
          RegistraMsg.InserisciMessaggio('A', 'Documento: ' + ListaDocumenti[i].FullPathDocumento + ' - ' + e.Message);
        end;
      end;
    end;
  finally
    ScriviStatusBar('Documenti: ' + ListaDocumenti.Count.ToString);
    cdsFileCaricati.EnableControls;
  end;
end;

//invio il singolo documento
procedure TA220FArchiviazioneLarchiveMW.InviaDocumento(PIndex: Integer);
var Multipart: TMultipartFormData;
    HTTPResponse: IHTTPResponse;
    HTTPHeaders: TArray<TNameValuePair>;
    bucketId: String;
begin
  try
    bucketId:='';
    selI210.Close;
    selI210.SetVariable('TIPO_DOCUMENTO', IfThen(ListaDocumenti[PIndex].Tipo = 'CUD', 'CU', ListaDocumenti[PIndex].Tipo));  //Se il tipo è CU, usa comunque CUD
    selI210.Open;

    bucketId:=selI210.FieldByName('BUCKETID').AsString;
    if bucketId = '' then
      raise Exception.Create('BucketId per il tipo documento: ' + ListaDocumenti[PIndex].Tipo + ' non trovato.');

    //TEST
    {if ListaDocumenti[PIndex].Tipo = 'CU' then
      bucketId:='4441f510-5fd5-427b-87e3-e854f3ad3347'
    else if ListaDocumenti[PIndex].Tipo = 'CED' then
      bucketId:='bda41c8c-eb55-450d-a62f-25a4dcd760eb'
    else if ListaDocumenti[PIndex].Tipo = 'LOGCED' then
      bucketId:='7aa40960-f542-4190-a88a-5c4934af0d9a'
    else if ListaDocumenti[PIndex].Tipo = 'LOGCU' then
      bucketId:='d816031b-01d9-4783-b4e3-a7bac23d135b'
    else if ListaDocumenti[PIndex].Tipo = 'CAR' then
      bucketId:='22856fcd-dc34-47a4-ba33-8967df0d1d58';}
    //FINE TEST

    Multipart:=ListaDocumenti[PIndex].GetMultipartFormData(bucketId);

    HTTPHeaders:=TArray<TNameValuePair>.Create
    (
      TNameValuePair.Create('Authorization','Bearer ' + Parametri.CampiRiferimento.C45_LArchive_TokenJWT),
      TNameValuePair.Create('X-Channel','WS'),
      TNameValuePair.Create('X-Delegate-Producer', Parametri.CampiRiferimento.C45_LArchive_ProducerId)
    );

    HTTPClient.ContentType:='';
    HTTPResponse:=HTTPRequest.Post(Parametri.CampiRiferimento.C45_LArchive_URL_Versamento, Multipart, nil, HTTPHeaders);

    //TEST
    //LogRisposta(HTTPResponse, ListaDocumenti[PIndex].HashSHA512);
    //FINE TEST

    if HTTPResponse.StatusCode = 200 then
      GestisciRispostaVersamento(HTTPResponse, PIndex, bucketId)
    else
      raise Exception.Create('Errore nella comunicazione con l''endpoint di archiviazione - HTTP status: ' + HTTPResponse.StatusCode.ToString + ' - ' + HTTPResponse.StatusText + ' - ' + HTTPResponse.ContentAsString);
  finally
    try TFile.Delete(ListaDocumenti[PIndex].Path + 'metadata.json'); except end;
    FreeAndNil(Multipart);
  end;
end;

procedure TA220FArchiviazioneLarchiveMW.GestisciRispostaVersamento(PHTTPResponse: IHTTPResponse; PIndex: Integer; PBucketId: String);
var XML: IXMLDocument;
    outcome, errorCode, error, userPdvId, docUserId, uploadDate: String;
    data: TDateTime;
begin
  try
    XML:=TXMLDocument.Create(nil); //gestito con reference count, non serve free

    XML.LoadFromStream(PHTTPResponse.ContentStream, xetUnknown);

    if XML.DocumentElement.LocalName = 'rdt' then
    begin
      if XML.DocumentElement.ChildNodes['outcome'] <> nil then
      begin
        if XML.DocumentElement.ChildNodes['outcome'].Text = 'TRANSMITTED' then
        begin
          uploadDate:=IfThen(XML.DocumentElement.ChildNodes['uploadDate'] <> nil, XML.DocumentElement.ChildNodes['uploadDate'].Text, '');
          outcome:=XML.DocumentElement.ChildNodes['outcome'].Text;
          userPdvId:=IfThen(XML.DocumentElement.ChildNodes['userPdvId'] <> nil, XML.DocumentElement.ChildNodes['userPdvId'].Text, '');
          docUserId:=IfThen(XML.DocumentElement.ChildNodes['docUserId'] <> nil, XML.DocumentElement.ChildNodes['docUserId'].Text, '');
        end
        else
        begin
          //outcome = ERROR
          uploadDate:=IfThen(XML.DocumentElement.ChildNodes['uploadDate'] <> nil, XML.DocumentElement.ChildNodes['uploadDate'].Text, '');
          outcome:=XML.DocumentElement.ChildNodes['outcome'].Text;
          errorCode:=IfThen(XML.DocumentElement.ChildNodes['errorCode'] <> nil, XML.DocumentElement.ChildNodes['errorCode'].Text, '');
          error:=IfThen(XML.DocumentElement.ChildNodes['error'] <> nil, XML.DocumentElement.ChildNodes['error'].Text, '');
        end;

        data:=GMTToLocalDateTime(uploadDate);

        with insI220 do
        begin
          SetVariable('DATA_TRASMISSIONE', Now);
          SetVariable('TIPO_DOCUMENTO', ListaDocumenti[PIndex].Tipo);
          SetVariable('DOCUSERID', ListaDocumenti[PIndex].Id);
          SetVariable('DOCFILENAME', ListaDocumenti[PIndex].Nome + ListaDocumenti[PIndex].Estensione);
          SetVariable('DATA_CREAZIONE', ListaDocumenti[PIndex].DataCreazione);
          SetVariable('DOCHASH', ListaDocumenti[PIndex].HashSHA512);
          SetVariable('BUCKETID', PBucketId);

          SetVariable('USERPDVID', userPdvId);
          SetVariable('PDVID', '');
          SetVariable('UPLOADDATE', data);
          SetVariable('PDVSTATUS', outcome);
          SetVariable('PDVSTATUSMESSAGE', '');
          SetVariable('ERRORMESSAGE', IfThen(errorCode + error <> '', errorCode + ' - ' + error, ''));

          Execute;
          SessioneOracle.Commit;
        end;

        if cdsFileCaricati.Locate('ID_DOCUMENTO;TIPO', VarArrayOf([ListaDocumenti[PIndex].Id, ListaDocumenti[PIndex].Tipo]), []) then
        begin
          cdsFileCaricati.Edit;
          cdsFileCaricati.FieldByName('STATO').AsString:=outcome;
          cdsFileCaricati.Post;
        end;

        if (outcome = 'TRANSMITTED') and EliminaFile then
          ListaDocumenti[PIndex].EliminaFile;
      end
      else
        raise Exception.Create('Formato della risposta XML non valido');
    end
    else
      raise Exception.Create('Formato della risposta XML non valido');
  except
    on E: Exception do
      raise Exception.Create(E.Message + ' - ' + PHTTPResponse.ContentAsString);
  end;
end;

//carico un singolo documento
function TA220FArchiviazioneLarchiveMW.CaricaDocumento(PFullPath: String): Boolean;
var idx: Integer;
begin
  Result:=False;
  idx:=ListaDocumenti.CaricaDocumento(PFullPath);

  if idx <> -1 then
  begin
    with cdsFileCaricati do
    begin
      Append;
      FieldByName('ID_DOCUMENTO').AsString:=ListaDocumenti[idx].Id;
      FieldByName('TIPO').AsString:=ListaDocumenti[idx].Tipo;
      FieldByName('NOME_FILE').AsString:=ListaDocumenti[idx].Nome + ListaDocumenti[idx].Estensione;
      FieldByName('PATH').AsString:=ListaDocumenti[idx].Path;
      FieldByName('DATA_CREAZIONE').AsDateTime:=ListaDocumenti[idx].DataCreazione;
      Post;
      Result:=True;
    end;
  end;
end;

//carico la lista di file da inserire a partire dal contenuto di una cartella
procedure TA220FArchiviazioneLarchiveMW.CaricaListaDocumenti(PPath: String; var PListaGiaPresenti: TStringList);
var FileList: TStringDynArray;
    i: Integer;
begin
  if not Assigned(PListaGiaPresenti) then
    raise Exception.Create('Lista dei file già presenti non inizializzata');

  if not DirectoryExists(PPath) then
    raise Exception.Create('Cartella da cui caricare la lista dei file non trovata: ' + PPath);

  FileList:=TDirectory.GetFiles(PPath, TListaDocumenti.FileFilter);

  cdsFileCaricati.DisableControls;
  try
    for i:=0 to Length(FileList) -1 do
    begin
      if not CaricaDocumento(FileList[i]) then
        PListaGiaPresenti.Add(FileList[i]);
    end;
  finally
    cdsFileCaricati.EnableControls;
  end;
end;

//elimino il singolo documento dalla lista
procedure TA220FArchiviazioneLarchiveMW.CancellaDocumento;
begin
  if (cdsFileCaricati.RecNo > 0) and (cdsFileCaricati.RecordCount > 0) then
  begin
    ListaDocumenti.RemoveById(cdsFileCaricati.FieldByName('ID_DOCUMENTO').AsString, cdsFileCaricati.FieldByName('TIPO').AsString);
    cdsFileCaricati.Delete;
  end;
end;

//svuoto la lista di documenti caricati
procedure TA220FArchiviazioneLarchiveMW.Clear;
begin
  ListaDocumenti.Clear;

  cdsFileCaricati.DisableControls;
  try
    cdsFileCaricati.EmptyDataSet;
  finally
    cdsFileCaricati.EnableControls;
  end;
end;

//se il token è scaduto ritorna false
function TA220FArchiviazioneLarchiveMW.ValidazioneTokenJWT: Boolean;
var scadenza: TDateTime;
    fs: TFormatSettings;
begin
  Result:=False;

  if Parametri.CampiRiferimento.C45_LArchive_TokenJWT <> '' then
  begin
    Result:=True;

    if Parametri.CampiRiferimento.C45_LArchive_Scadenza_TokenJWT <> '' then
    begin
      try
        fs:=TFormatSettings.Create;
        fs.DateSeparator := '/';
        fs.ShortDateFormat := 'dd/MM/yyyy';

        scadenza:=StrToDateTime(Parametri.CampiRiferimento.C45_LArchive_Scadenza_TokenJWT, fs);

        if scadenza < Now then
          Result:=False;
      except
        Exit;
      end;
    end;
  end;
end;

//usato per test
procedure TA220FArchiviazioneLarchiveMW.LogRisposta(PHTTPResponse: IHTTPResponse; Hash: String);
var text: String;
begin
  text:=CRLF + '/*-------------------------------------------------------------------------------*/' +
        CRLF + PHTTPResponse.Date +
        CRLF + 'Codice:' + PHTTPResponse.StatusCode.ToString +
        CRLF + PHTTPResponse.StatusText +
        CRLF + PHTTPResponse.ContentAsString +
        CRLF + 'Hash:' + Hash + CRLF;
  TFile.AppendAllText('responseLog.txt', text);
end;

{$region 'TDocumentoDaArchiviare'}
constructor TDocumentoDaArchiviare.Create(PFullPath: String);
begin
  Path:=ExtractFilePath(PFullPath);
  Nome:=TPath.GetFileNameWithoutExtension(PFullPath);
  Estensione:=ExtractFileExt(PFullPath);

  if not FileAge(PFullPath, DataCreazione) then
    raise Exception.Create('Errore nell''acquisizione della data di creazione del file : ' + PFullPath);

  if not MetadataExist then
    raise Exception.Create('File di metadati con nome "' + Nome + '.json" non trovato nella stessa cartella del file da archiviare');

  ValidaNomeFile;
  CalcolaSHA512;
end;

//elimina il documento caricato da file system
procedure TDocumentoDaArchiviare.EliminaFile;
begin
  if DocumentoExist then
    DeleteFile(FullPathDocumento);
  if MetadataExist then
    DeleteFile(FullPathMetadata);
end;

function TDocumentoDaArchiviare.GetFullPathDocumento: String;
begin
  Result:=Path + Nome + Estensione;
end;

function TDocumentoDaArchiviare.GetFullPathMetadata: String;
begin
  Result:=Path + Nome + '.json';
end;

function TDocumentoDaArchiviare.GetMultipartFormData(bucketId: String; userPdaId: String = ''): TMultipartFormData;
begin
  if not MetadataExist then
    raise Exception.Create('File di metadati con nome "' + Nome + '.json" non trovato nella stessa cartella del file da archiviare');

  try
    TFile.Copy(GetFullPathMetadata, Path + 'metadata.json', True);
  except
    on E: Exception do
      raise Exception.Create('Errore nella creazione del file "metadata.json": ' + E.Message);
  end;

  Result:=TMultipartFormData.Create;
  with Result do
  begin
    AddField('bucketId', bucketId);
    AddField('docUserId', Id);
    if userPdaId <> '' then
      AddField('userPdaId', userPdaId);
    AddFile('docPayload', GetFullPathDocumento);
    AddField('docHash', HashSHA512);
    AddField('docFileName', Nome + Estensione);
    AddFile('docMetadataPayload', Path + 'metadata.json');
    AddField('multiple','false'); //opzionale, indica se esplodere gli zip o no (ma noi non inviamo zip!!)
  end;
end;

procedure TDocumentoDaArchiviare.CalcolaSHA512;
var
  HashBytes: TBytes;
  HashIdBytes: TIdBytes;
begin
  HashBytes:=THashSHA2.GetHashBytesFromFile(FullPathDocumento, SHA512);  // Calcolo SHA512 da file, rappresentazione in TBytes
  HashIdBytes:=TIdBytes(HashBytes);				                   // Conversione da TBytes a TIdBytes
  HashSHA512:=TIdEncoderMIME.EncodeBytes(HashIdBytes);       // Conversione da TIdBytes a String Base64
end;

function TDocumentoDaArchiviare.DocumentoExist: Boolean;
begin
  Result:=FileExists(FullPathDocumento);
end;

function TDocumentoDaArchiviare.MetadataExist: Boolean;
begin
  Result:=FileExists(FullPathMetadata);
end;

procedure TDocumentoDaArchiviare.ValidaNomeFile;
var tempArray: TStringDynArray;
    Progressivo: Integer;
    Anno: Integer;
    Mese: Integer;
begin
  tempArray:=SplitString(Nome, '_');
  if Length(tempArray) < 2  then
    raise Exception.Create('Nome del file "' + Nome + '" non valido');

  if (tempArray[0] = 'CED') or
     (tempArray[0] = 'CAR') or
     (tempArray[0] = 'CU') or
     (tempArray[0] = 'CUD') or
     (tempArray[0] = 'LOGCU') or
     (tempArray[0] = 'LOGCED') then
    Tipo:=tempArray[0]
  else
    raise Exception.Create('Nome del file "' + Nome + '" non valido, tipo documento non ammesso');

  //validazione id nel caso del cartellino
  if (tempArray[0] = 'CAR') then
  begin
    if Length(tempArray) < 3 then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, formato non ammesso');

    if not TryStrToInt(tempArray[1], Progressivo) then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, impossibile identificare il progressivo');

    if Length(tempArray[2]) <> 6 then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, impossibile identificare anno/mese');

    if not TryStrToInt(tempArray[2].Substring(0, 4), Anno) then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, impossibile identificare l''anno');

    if (Anno < 1900) or (Anno > 3999) then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, anno non valido');

    if not TryStrToInt(tempArray[2].Substring(4, 2), Mese) then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, impossibile identificare il mese');

    if (Mese < 1) or (Mese > 12) then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, mese non valido');

    Id:=tempArray[1] + '_' + tempArray[2];
    IdNumerico:=0;
  end
  else //validazione dell'id (solo numerico) in tutti gli altri casi
  begin
    if Length(tempArray) <> 2 then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, formato non ammesso');

    if not TryStrToInt(tempArray[1], IdNumerico) then
      raise Exception.Create('Nome del file "' + Nome + '" non valido, l''identificativo del documento non è un valore numerico');

    Id:=tempArray[1];
  end;
end;
{$endregion}

{$region 'TListaDocumenti'}
constructor TListaDocumenti.Create(AOwnsObject: boolean = True);
begin
  inherited Create(TComparer<TDocumentoDaArchiviare>.Construct(
    function (const L, R : TDocumentoDaArchiviare) : Integer
    begin
      if (AnsiCompareStr(L.Id, R.Id) = 0) and (AnsiCompareStr(L.Tipo, R.Tipo) = 0) then
        Result:=0
      else
        Result:=-1;
    end));
  OwnsObjects:=AOwnsObject;
end;

function TListaDocumenti.CaricaDocumento(PFullPath: String): Integer;
var doc: TDocumentoDaArchiviare;
begin
  doc:=TDocumentoDaArchiviare.Create(PFullPath);

  if not Contains(doc) then
    Result:=Add(doc)
  else
  begin
    Result:=-1;
    FreeAndNil(doc);
  end;
end;

function TListaDocumenti.IndexOfId(PId, PTipo: String): Integer;
var i: Integer;
begin
  for i:=0 to Count-1 do
  begin
    if (Items[i].Id = PId) and (Items[i].Tipo = PTipo) then
    begin
      Result:=i;
      break;
    end;
  end;
  if i = Count then
    Result:=-1;
end;

procedure TListaDocumenti.RemoveById(PId, PTipo: String);
var index: Integer;
begin
  index:=IndexOfId(PId, PTipo);

  if index <> -1 then
    Remove(Items[index]);
end;

class function TListaDocumenti.FileFilter(const Path: string; const SearchRec: TSearchRec): Boolean;
begin
  Result:=Uppercase(TPath.GetExtension(SearchRec.Name)) = '.PDF';
end;
{$endregion}
end.
