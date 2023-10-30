unit WM006UGestioneDelegheDM;

interface

uses
  System.SysUtils, System.Classes, WM000UDataModuleBaseDM, Data.DB, Oracle, OracleData, Generics.Collections, StrUtils,
  WM000UConstants, A000UCostanti, A000USessione, RegistrazioneLog;

type
  TUtenteDelegante = class(TObject)
  public
    Azienda: String;
    Progressivo: Integer;
    Matricola: String;
    Utente: String;
    Profilo: String;
    ProfiloDelegato: String;  //profilo dell'utente che ha caricato la delega
    DelegatoDa: String;       //utente che ha caricato la delega
    InizioValidita: TDateTime;
    FineValidita: TDateTime;
    Permessi: String;
    FiltroFunzioni: String;
    FiltroAnagrafe: String;
    FiltroDizionario: String;
    IterAutorizzativi: String;
  end;

  TUtenteDelegato = class(TObject)
  public
    Cognome: String;
    Nome: String;
    Utente: String;
    constructor Create(LCognome, LNome, LUtente: String);
  end;

  TVarPers = class(TObject)
  public
    Nome: String;
    Tipo: Integer;
    Valore: Variant;
    constructor Create(PNome: String; PTipo: Integer; PValore: Variant);
  end;

  TDelega = class(TObject)
  public
    Id: String;
    Cognome: String;
    Nome: String;
    Utente: String;
    Profilo: String;
    InizioValidita: TDateTime;
    FineValidita: TDateTime;
    EscludiDelegato: Boolean;
    UltimoAccesso: TDateTime;
    constructor Create(PId, PCognome, PNome, PUtente, PProfilo: String; PInizioValidita, PFineValidita, PUltimoAccesso:TDateTime; PEscludiDelegato :String);
  end;

  TWM006FGestioneDelegheDM = class(TWM000FDataModuleBaseDM)
    selI061PermessiUtente: TOracleDataSet;
    selI060Utenti: TOracleDataSet;
    selI061NomiProfili: TOracleDataSet;
    selI061ProfiloAssegnato: TOracleDataSet;
    selI061DelegheUtente: TOracleDataSet;
    selI061DelegheEsistenti: TOracleDataSet;
  public
    function GetUtenteDelegante(PAzienda: String; PProgressivo: Integer; PMatricola, PUtente, PProfilo:String): TUtenteDelegante;
    function GetListaDeleghe(PAzienda, PUtente: String): TObjectList<TDelega>;
    function GetListaUtentiDelegabili(PAzienda, PUtente, PFiltroUtentiDelegabili, PC90_FiltroDeleghe: String; PVarPersonalizzate: TObjectList<TVarPers>): TObjectList<TUtenteDelegato>;
    function GetProfiloAssegnato(PAzienda, PProfilo: String): String;
    function VerificaProfiloAssegnato(PAzienda, PUtenteDelegato, PProfiloAssegnato: String): Boolean;
    function VerificaDelegheEsistenti(PAzienda, PUtenteDelegato, PProfiloAssegnato: String; PDataDal, PDataAl: TDateTime; var OldDataDal, OldDataAl: TDateTime; var PRowId: String): Integer;
    procedure EliminaDelegaUtente(PRowId:String);
    procedure EliminaDelegaEsistente(PRowId:String);
    procedure ModificaDelega(PRowId: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean);
    procedure InserisciDelega(PUtenteDelegante: TUtenteDelegante; PUtenteDelegato, PProfilo: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TWM006FGestioneDelegheDM }

// cerca il profilo (che potrebbe essere stato digitato a mano)
function TWM006FGestioneDelegheDM.GetProfiloAssegnato(PAzienda, PProfilo: String): String;
begin
  with selI061NomiProfili do
  begin
    Close;
    SetVariable('AZIENDA', PAzienda);
    Open;

    if SearchRecord('NOME_PROFILO',PProfilo,[srIgnoreCase, srFromBeginning]) then
      Result:=FieldByName('NOME_PROFILO').AsString
    else
      Result:=PProfilo;

    Close;
  end;
end;

// verifica se il profilo appartiene originariamente all'operatore delegato
// non considera il periodo di validità ma è voluto così
function TWM006FGestioneDelegheDM.VerificaProfiloAssegnato(PAzienda, PUtenteDelegato, PProfiloAssegnato: String): Boolean;
begin
  with selI061ProfiloAssegnato do
  begin
    Close;
    SetVariable('AZIENDA',PAzienda);
    SetVariable('UTENTE', PUtenteDelegato);
    SetVariable('PROFILO', PProfiloAssegnato);
    Open;

    Result:=RecordCount > 0;

    Close;
  end;
end;

// verifica se esiste già una delega dello stesso profilo in un periodo intersecante
function TWM006FGestioneDelegheDM.VerificaDelegheEsistenti(PAzienda, PUtenteDelegato, PProfiloAssegnato: String; PDataDal, PDataAl: TDateTime; var OldDataDal, OldDataAl: TDateTime; var PRowId: String): Integer;
begin
  with selI061DelegheEsistenti do
  begin
    Close;
    SetVariable('AZIENDA',PAzienda);
    SetVariable('UTENTE',PUtenteDelegato);
    SetVariable('PROFILO',PProfiloAssegnato);
    SetVariable('DATA_DAL',PDataDal);
    SetVariable('DATA_AL',PDataAl);
    Open;

    Result:=RecordCount;

    if RecordCount = 1 then
    begin
      // il profilo è già stato delegato all'utente in uno (e uno solo) periodo intersecante
      OldDataDal:=FieldByName('INIZIO_VALIDITA').AsDateTime;
      OldDataAl:=FieldByName('FINE_VALIDITA').AsDateTime;
      PRowId:=RowId;
    end;
  end;
end;

//ritorna i dati dell'utente delegante
function TWM006FGestioneDelegheDM.GetUtenteDelegante(PAzienda: String; PProgressivo: Integer; PMatricola, PUtente, PProfilo: String): TUtenteDelegante;
begin
  with selI061PermessiUtente do
  begin
    Close;
    SetVariable('AZIENDA', PAzienda);
    SetVariable('UTENTE', PUtente);
    SetVariable('PROFILO', PProfilo);
    Open;

    if RecordCount > 0 then
    begin
      Result:=TUtenteDelegante.Create;
      try
        // salva i dati del profilo nel periodo attuale di validita
        Result.Azienda:=FieldByName('AZIENDA').AsString;
        Result.Progressivo:=PProgressivo;
        Result.Matricola:=PMatricola;
        Result.Utente:=FieldByName('NOME_UTENTE').AsString;
        Result.Profilo:=FieldByName('NOME_PROFILO').AsString;

        Result.ProfiloDelegato:=Result.Profilo;
        if (FindField('PROFILO_DELEGATO') <> nil) and (FieldByName('PROFILO_DELEGATO').AsString.Trim <> '') then
          Result.ProfiloDelegato:=FieldByName('PROFILO_DELEGATO').AsString;

        Result.DelegatoDa:=PUtente;
        if FieldByName('DELEGATO_DA').AsString.Trim <> '' then
          Result.DelegatoDa:=FieldByName('DELEGATO_DA').AsString;

        Result.InizioValidita:=FieldByName('INIZIO_VALIDITA').AsDateTime;
        Result.FineValidita:=FieldByName('FINE_VALIDITA').AsDateTime;
        Result.Permessi:=FieldByName('PERMESSI').AsString;
        Result.FiltroFunzioni:=FieldByName('FILTRO_FUNZIONI').AsString;
        Result.FiltroAnagrafe:=FieldByName('FILTRO_ANAGRAFE').AsString;
        Result.FiltroDizionario:=FieldByName('FILTRO_DIZIONARIO').AsString;
        Result.IterAutorizzativi:=FieldByName('ITER_AUTORIZZATIVI').AsString;
      except
        FreeAndNil(Result);
        raise;
      end;
    end
    else
      Result:=nil;

    Close;
  end;
end;

procedure TWM006FGestioneDelegheDM.EliminaDelegaEsistente(PRowId: String);
begin
  with selI061DelegheEsistenti do
  begin
    if SearchRecord('ROWID', PRowId, [srFromBeginning]) then
    begin
      Delete;
      Session.Commit;
    end;
  end;
end;

procedure TWM006FGestioneDelegheDM.EliminaDelegaUtente(PRowId: String);
begin
  with selI061DelegheUtente do
  begin
    if SearchRecord('ROWID', PRowId, [srFromBeginning]) then
    begin
      Delete;
      Session.Commit;
    end;
  end;
end;

procedure TWM006FGestioneDelegheDM.ModificaDelega(PRowId: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean);
begin
  with selI061DelegheUtente do
  begin
    if SearchRecord('ROWID', PRowId, [srFromBeginning]) then
    begin
      Edit;

      FieldByName('INIZIO_VALIDITA').AsDateTime:=PInizioValidita;
      FieldByName('FINE_VALIDITA').AsDateTime:=PFineValidita;
      FieldByName('AUTO_ESCLUSIONE').AsString:=IfThen(PAutoEsclusione, 'S', 'N');;

      try
        RegistraLog.SettaProprieta('M','I061_PROFILI_DIPENDENTE', 'WM006',nil,True);
        Post;
        RegistraLog.RegistraOperazione;
        Session.Commit;
      except
        on E:Exception do
          begin
            RegistraLog.AnnullaOperazione;
            Session.Commit;
            raise;
          end;
      end;
    end;
  end;
end;

procedure TWM006FGestioneDelegheDM.InserisciDelega(PUtenteDelegante: TUtenteDelegante; PUtenteDelegato, PProfilo: String; PInizioValidita, PFineValidita: TDateTime; PAutoEsclusione: Boolean);
begin
  with selI061DelegheUtente do
  begin
    Append;
    FieldByName('AZIENDA').AsString:=PUtenteDelegante.Azienda;
    FieldByName('NOME_UTENTE').AsString:=PUtenteDelegato;
    FieldByName('NOME_PROFILO').AsString:=PProfilo;
    FieldByName('PERMESSI').AsString:=PUtenteDelegante.Permessi;
    FieldByName('FILTRO_FUNZIONI').AsString:=PUtenteDelegante.FiltroFunzioni;
    FieldByName('FILTRO_ANAGRAFE').AsString:=PUtenteDelegante.FiltroAnagrafe;
    FieldByName('FILTRO_DIZIONARIO').AsString:=PUtenteDelegante.FiltroDizionario;
    FieldByName('ITER_AUTORIZZATIVI').AsString:=PUtenteDelegante.IterAutorizzativi;
    FieldByName('INIZIO_VALIDITA').AsDateTime:=PInizioValidita;
    FieldByName('FINE_VALIDITA').AsDateTime:=PFineValidita;
    FieldByName('AUTO_ESCLUSIONE').AsString:=IfThen(PAutoEsclusione, 'S', 'N');
    FieldByName('DELEGATO_DA').AsString:=PUtenteDelegante.DelegatoDa;
    if FindField('DELEGA_INSERITA_DA') <> nil then
      FieldByName('DELEGA_INSERITA_DA').AsString:=PUtenteDelegante.Utente;
    if FindField('PROFILO_DELEGATO') <> nil then
      FieldByName('PROFILO_DELEGATO').AsString:=PUtenteDelegante.ProfiloDelegato;

    try
      Post;
      Session.Commit;
    except
      on E:Exception do
      begin
        Session.Commit;
        Cancel;
        raise;
      end;
    end;
  end;
end;

function TWM006FGestioneDelegheDM.GetListaDeleghe(PAzienda, PUtente: String): TObjectList<TDelega>;
var LUltimoAccesso: TDateTime;
begin
  with selI061DelegheUtente do
  begin
    Close;
    SetVariable('AZIENDA',PAzienda);
    SetVariable('UTENTE',PUtente);
    SetVariable('DATA_LIMITE',Trunc(Now));
    try
      Open;
    except
      SQL.Text:=StringReplace(SQL.Text,'DELEGA_INSERITA_DA','DELEGATO_DA',[]);
      Open;
    end;

    Result:=TObjectList<TDelega>.Create(True);
    try
      while not Eof do
      begin
        if FieldByName('ULTIMO_ACCESSO').IsNull then
          LUltimoAccesso:=DATE_NULL
        else
          LUltimoAccesso:=FieldByName('ULTIMO_ACCESSO').AsDateTime;

        Result.Add(TDelega.Create(RowId, FieldByName('COGNOME').AsString, FieldByName('NOME').AsString, FieldByName('NOME_UTENTE').AsString, FieldByName('NOME_PROFILO').AsString, FieldByName('INIZIO_VALIDITA').AsDateTime, FieldByName('FINE_VALIDITA').AsDateTime, LUltimoAccesso, FieldByName('AUTO_ESCLUSIONE').AsString));
        Next;
      end;
    except
      FreeAndNil(Result);
      Close;
      raise;
    end;
  end;
end;

function TWM006FGestioneDelegheDM.GetListaUtentiDelegabili(PAzienda, PUtente, PFiltroUtentiDelegabili, PC90_FiltroDeleghe: String; PVarPersonalizzate: TObjectList<TVarPers>): TObjectList<TUtenteDelegato>;
var
  ErrMsg: String;
  VarPers: TVarPers;
  idxVarFiltro: Integer;
  idxVarDataset: Integer;
begin
  // popolamento lista utenti
  with selI060Utenti do
  begin
    Close;
    ClearVariables;
    SetVariable('AZIENDA', PAzienda);
    SetVariable('UTENTE', PUtente);
    SetVariable('FILTRO', PFiltroUtentiDelegabili);

    // filtro anagrafiche personalizzato
    if (PC90_FiltroDeleghe <> '') and Assigned(PVarPersonalizzate) then
    begin
      // determina la presenza di bind variables nel filtro e le valorizza
      with FindVariables(PC90_FiltroDeleghe, False) do
      begin
        try
          for VarPers in PVarPersonalizzate do
          begin
            idxVarFiltro:=IndexOf(VarPers.Nome);
            idxVarDataset:=VariableIndex(VarPers.Nome);
            if idxVarFiltro >= 0 then
            begin
              // variabile presente nel filtro
              // 1. verifica se necessario dichiararla nel dataset
              if idxVarDataset < 0 then
                DeclareVariable(VarPers.Nome, VarPers.Tipo);
              // 2. imposta valore
              SetVariable(VarPers.Nome, VarPers.Valore);
            end
            else
            begin
              // variabile non presente nel filtro
              // se è dichiarata nel dataset la elimina
              if idxVarDataset >= 0 then
                DeleteVariable(VarPers.Nome);
            end;
          end;
        finally
          Free;
        end;
      end;
    end;
    PC90_FiltroDeleghe:=IfThen(PC90_FiltroDeleghe <> '', 'AND (' + PC90_FiltroDeleghe + ')');
    SetVariable('FILTRO_ANAGRAFICHE', PC90_FiltroDeleghe);

    try
      Open;
    except
      on E: Exception do
      begin
        ErrMsg:=Format('Si è verificato un errore nell''applicazione del filtro personalizzato'#13#10 +
                       'per gli utenti delegabili:'#13#10 +
                       '%s (%s).',[E.Message,E.ClassName]);
        try
          // tenta apertura dataset escludendo il filtro personalizzato
          // 1. elimina eventuali variabili personalizzate
          for VarPers in PVarPersonalizzate do
          begin
            if VariableIndex(VarPers.Nome) >= 0 then
              DeleteVariable(VarPers.Nome);
          end;
          // 2. annulla la variabile substitution per il filtro anagrafiche
          SetVariable('FILTRO_ANAGRAFICHE','');
          Open;
        except
          on E: Exception do
          begin
            // se fallisce anche questo tentativo segnala errore
            raise Exception.Create(ErrMsg);
          end;
        end;
        // informa che il filtro è errato e non viene applicato
        ErrMsg:=ErrMsg + #13#10'Il filtro personalizzato non sarà pertanto applicato.'#13#10 + 'Si prega di segnalare questa anomalia.';
        raise Exception.Create(ErrMsg);
      end;
    end;
    // creo la lista con gli utenti creati
    Result:=TObjectList<TUtenteDelegato>.Create(True);
    while not Eof do
    begin
      Result.Add(TUtenteDelegato.Create(FieldByName('COGNOME').AsString, FieldByName('NOME').AsString, FieldByName('NOME_UTENTE').AsString));
      Next;
    end;

    Close;
  end;
end;

{ TUtenteDelegabile }

constructor TUtenteDelegato.Create(LCognome, LNome, LUtente: String);
begin
  Cognome:=LCognome;
  Nome:=LNome;
  Utente:=LUtente;
end;

{ TVarPers }

constructor TVarPers.Create(PNome: String; PTipo: Integer; PValore: Variant);
begin
  Nome:=PNome;
  Tipo:=PTipo;
  Valore:=PValore;
end;

{ TDeleghe }

constructor TDelega.Create(PId, PCognome, PNome, PUtente, PProfilo: String; PInizioValidita, PFineValidita, PUltimoAccesso: TDateTime; PEscludiDelegato: String);
begin
  Id:=PId;
  Cognome:=PCognome;
  Nome:=PNome;
  Utente:=PUtente;
  Profilo:=PProfilo;
  InizioValidita:=PInizioValidita;
  FineValidita:=PFineValidita;
  UltimoAccesso:=PUltimoAccesso;
  EscludiDelegato:=AnsiUpperCase(PEscludiDelegato) = 'S';
end;

end.
