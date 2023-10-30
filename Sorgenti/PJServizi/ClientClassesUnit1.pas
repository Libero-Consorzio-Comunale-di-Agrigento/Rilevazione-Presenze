//
// Created by the DataSnap proxy generator.
// 28/07/2016 09:16:53
//

unit ClientClassesUnit1;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, C200UWebServicesTypes, Data.DBXJSONReflect;

type

  IDSRestCachedTRisultato = interface;

  TB110FServerMethodsDMClient = class(TDSAdminRestClient)
  private
    FCartellinoCommand: TDSRestCommand;
    FCartellinoCommand_Cache: TDSRestCommand;
    FAssenzeCommand: TDSRestCommand;
    FAssenzeCommand_Cache: TDSRestCommand;
    FInfoServerCommand: TDSRestCommand;
    FInfoServerCommand_Cache: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function Cartellino(Azienda: string; Utente: string; Password: string; Profilo: string; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string = ''): TRisultato;
    function Cartellino_Cache(Azienda: string; Utente: string; Password: string; Profilo: string; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function Assenze(Azienda: string; Utente: string; Password: string; Profilo: string; const ARequestFilter: string = ''): TRisultato;
    function Assenze_Cache(Azienda: string; Utente: string; Password: string; Profilo: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
    function InfoServer(Dato: string; const ARequestFilter: string = ''): TRisultato;
    function InfoServer_Cache(Dato: string; const ARequestFilter: string = ''): IDSRestCachedTRisultato;
  end;

  IDSRestCachedTRisultato = interface(IDSRestCachedObject<TRisultato>)
  end;

  TDSRestCachedTRisultato = class(TDSRestCachedObject<TRisultato>, IDSRestCachedTRisultato, IDSRestCachedCommand)
  end;

const
  TB110FServerMethodsDM_Cartellino: array [0..6] of TDSRestParameterMetaData =
  (
    (Name: 'Azienda'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Utente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Password'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Profilo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'MeseCartellino'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'CodParamStampa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Cartellino_Cache: array [0..6] of TDSRestParameterMetaData =
  (
    (Name: 'Azienda'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Utente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Password'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Profilo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'MeseCartellino'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'CodParamStampa'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_Assenze: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'Azienda'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Utente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Password'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Profilo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_Assenze_Cache: array [0..4] of TDSRestParameterMetaData =
  (
    (Name: 'Azienda'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Utente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Password'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'Profilo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TB110FServerMethodsDM_InfoServer: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Dato'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TRisultato')
  );

  TB110FServerMethodsDM_InfoServer_Cache: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Dato'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

implementation

function TB110FServerMethodsDMClient.Cartellino(Azienda: string; Utente: string; Password: string; Profilo: string; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string): TRisultato;
begin
  if FCartellinoCommand = nil then
  begin
    FCartellinoCommand := FConnection.CreateCommand;
    FCartellinoCommand.RequestType := 'GET';
    FCartellinoCommand.Text := 'TB110FServerMethodsDM.Cartellino';
    FCartellinoCommand.Prepare(TB110FServerMethodsDM_Cartellino);
  end;
  FCartellinoCommand.Parameters[0].Value.SetWideString(Azienda);
  FCartellinoCommand.Parameters[1].Value.SetWideString(Utente);
  FCartellinoCommand.Parameters[2].Value.SetWideString(Password);
  FCartellinoCommand.Parameters[3].Value.SetWideString(Profilo);
  FCartellinoCommand.Parameters[4].Value.AsDateTime := MeseCartellino;
  FCartellinoCommand.Parameters[5].Value.SetWideString(CodParamStampa);
  FCartellinoCommand.Execute(ARequestFilter);
  if not FCartellinoCommand.Parameters[6].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FCartellinoCommand.Parameters[6].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FCartellinoCommand.Parameters[6].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FCartellinoCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Cartellino_Cache(Azienda: string; Utente: string; Password: string; Profilo: string; MeseCartellino: TDateTime; CodParamStampa: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FCartellinoCommand_Cache = nil then
  begin
    FCartellinoCommand_Cache := FConnection.CreateCommand;
    FCartellinoCommand_Cache.RequestType := 'GET';
    FCartellinoCommand_Cache.Text := 'TB110FServerMethodsDM.Cartellino';
    FCartellinoCommand_Cache.Prepare(TB110FServerMethodsDM_Cartellino_Cache);
  end;
  FCartellinoCommand_Cache.Parameters[0].Value.SetWideString(Azienda);
  FCartellinoCommand_Cache.Parameters[1].Value.SetWideString(Utente);
  FCartellinoCommand_Cache.Parameters[2].Value.SetWideString(Password);
  FCartellinoCommand_Cache.Parameters[3].Value.SetWideString(Profilo);
  FCartellinoCommand_Cache.Parameters[4].Value.AsDateTime := MeseCartellino;
  FCartellinoCommand_Cache.Parameters[5].Value.SetWideString(CodParamStampa);
  FCartellinoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FCartellinoCommand_Cache.Parameters[6].Value.GetString);
end;

function TB110FServerMethodsDMClient.Assenze(Azienda: string; Utente: string; Password: string; Profilo: string; const ARequestFilter: string): TRisultato;
begin
  if FAssenzeCommand = nil then
  begin
    FAssenzeCommand := FConnection.CreateCommand;
    FAssenzeCommand.RequestType := 'GET';
    FAssenzeCommand.Text := 'TB110FServerMethodsDM.Assenze';
    FAssenzeCommand.Prepare(TB110FServerMethodsDM_Assenze);
  end;
  FAssenzeCommand.Parameters[0].Value.SetWideString(Azienda);
  FAssenzeCommand.Parameters[1].Value.SetWideString(Utente);
  FAssenzeCommand.Parameters[2].Value.SetWideString(Password);
  FAssenzeCommand.Parameters[3].Value.SetWideString(Profilo);
  FAssenzeCommand.Execute(ARequestFilter);
  if not FAssenzeCommand.Parameters[4].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FAssenzeCommand.Parameters[4].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FAssenzeCommand.Parameters[4].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FAssenzeCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.Assenze_Cache(Azienda: string; Utente: string; Password: string; Profilo: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FAssenzeCommand_Cache = nil then
  begin
    FAssenzeCommand_Cache := FConnection.CreateCommand;
    FAssenzeCommand_Cache.RequestType := 'GET';
    FAssenzeCommand_Cache.Text := 'TB110FServerMethodsDM.Assenze';
    FAssenzeCommand_Cache.Prepare(TB110FServerMethodsDM_Assenze_Cache);
  end;
  FAssenzeCommand_Cache.Parameters[0].Value.SetWideString(Azienda);
  FAssenzeCommand_Cache.Parameters[1].Value.SetWideString(Utente);
  FAssenzeCommand_Cache.Parameters[2].Value.SetWideString(Password);
  FAssenzeCommand_Cache.Parameters[3].Value.SetWideString(Profilo);
  FAssenzeCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FAssenzeCommand_Cache.Parameters[4].Value.GetString);
end;

function TB110FServerMethodsDMClient.InfoServer(Dato: string; const ARequestFilter: string): TRisultato;
begin
  if FInfoServerCommand = nil then
  begin
    FInfoServerCommand := FConnection.CreateCommand;
    FInfoServerCommand.RequestType := 'GET';
    FInfoServerCommand.Text := 'TB110FServerMethodsDM.InfoServer';
    FInfoServerCommand.Prepare(TB110FServerMethodsDM_InfoServer);
  end;
  FInfoServerCommand.Parameters[0].Value.SetWideString(Dato);
  FInfoServerCommand.Execute(ARequestFilter);
  if not FInfoServerCommand.Parameters[1].Value.IsNull then
  begin
    FUnMarshal := TDSRestCommand(FInfoServerCommand.Parameters[1].ConnectionHandler).GetJSONUnMarshaler;
    try
      Result := TRisultato(FUnMarshal.UnMarshal(FInfoServerCommand.Parameters[1].Value.GetJSONValue(True)));
      if FInstanceOwner then
        FInfoServerCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal)
    end
  end
  else
    Result := nil;
end;

function TB110FServerMethodsDMClient.InfoServer_Cache(Dato: string; const ARequestFilter: string): IDSRestCachedTRisultato;
begin
  if FInfoServerCommand_Cache = nil then
  begin
    FInfoServerCommand_Cache := FConnection.CreateCommand;
    FInfoServerCommand_Cache.RequestType := 'GET';
    FInfoServerCommand_Cache.Text := 'TB110FServerMethodsDM.InfoServer';
    FInfoServerCommand_Cache.Prepare(TB110FServerMethodsDM_InfoServer_Cache);
  end;
  FInfoServerCommand_Cache.Parameters[0].Value.SetWideString(Dato);
  FInfoServerCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedTRisultato.Create(FInfoServerCommand_Cache.Parameters[1].Value.GetString);
end;

constructor TB110FServerMethodsDMClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TB110FServerMethodsDMClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TB110FServerMethodsDMClient.Destroy;
begin
  FCartellinoCommand.DisposeOf;
  FCartellinoCommand_Cache.DisposeOf;
  FAssenzeCommand.DisposeOf;
  FAssenzeCommand_Cache.DisposeOf;
  FInfoServerCommand.DisposeOf;
  FInfoServerCommand_Cache.DisposeOf;
  inherited;
end;

end.

