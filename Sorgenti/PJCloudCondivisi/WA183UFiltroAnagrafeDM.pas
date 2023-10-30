unit WA183UFiltroAnagrafeDM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, USelI010,
  A000UCostanti, A000USessione, L021Call, QueryPK,A000UMessaggi;

type
  TWA183FFiltroAnagrafeDM = class(TWR302FGestTabellaDM)
    DbIris008B: TOracleSession;
    insI072: TOracleQuery;
    D090: TDataSource;
    QI090: TOracleDataSet;
    dsrI072: TDataSource;
    selI072: TOracleDataSet;
    selPermessi: TOracleDataSet;
    testFiltroAnagrafe: TOracleDataSet;
    testFiltroAnagrafeMATRICOLA: TStringField;
    testFiltroAnagrafeCOGNOME: TStringField;
    testFiltroAnagrafeNOME: TStringField;
    testFiltroAnagrafeT430INIZIO: TDateTimeField;
    testFiltroAnagrafeT430FINE: TDateTimeField;
    dsrTestFiltroAnagrafe: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure dsrI072StateChange(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    VecchiaAzienda:String;
  public
    procedure PutFiltroAnagrafe;
    function ProfiloUtilizzato:Boolean;
    function VerificaFiltro(Filtro:String):String;
  end;

implementation

uses WA183UFiltroAnagrafe, WA183UFiltroAnagrafeDettFM;

{$R *.dfm}

procedure TWA183FFiltroAnagrafeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA,PROFILO');
  NonAprireSelTabella:=True;
  VecchiaAzienda:='';
  inherited;

  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  if Parametri.Azienda <> 'AZIN' then
  begin
    selTabella.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selTabella.Filtered:=True;
    QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    QI090.Filtered:=True;
  end;
  QI090.Open;
  selTabella.Open;
  if selTabella.RecordCount = 0 then
    selTabella.AfterScroll(selTabella);
end;

procedure TWA183FFiltroAnagrafeDM.PutFiltroAnagrafe;
{Registrazione del contenuto di memoFiltroAnagrafe}
var i:Integer;
    Azienda,AziendaOld,Profilo,ProfiloOld,FiltroOld:string;
    State:TDatasetState;
    ControlloChiave:Boolean;
begin
  if TWA183FFiltroAnagrafeDettFM(TWA183FFiltroAnagrafe(Self.Owner).WDettaglioFM) <> nil then
    with TWA183FFiltroAnagrafeDettFM(TWA183FFiltroAnagrafe(Self.Owner).WDettaglioFM)do
    begin
      Azienda:=selI072.FieldByName('AZIENDA').Value;
      Profilo:=selI072.FieldByName('PROFILO').Value;

      State:=selI072.State;

      ControlloChiave:=(State = dsInsert) or
                       ((State = dsEdit) and ((Azienda <> selTabella.FieldByName('AZIENDA').AsString) or (Profilo <> selTabella.FieldByName('PROFILO').AsString)));
      if ControlloChiave then
        with TQueryPK.Create(Self) do
        try
          Session:=SessioneOracle;
          if EsisteChiave('MONDOEDP.I072_FILTROANAGRAFE','',State,['AZIENDA','PROFILO'],[Azienda,Profilo]) then
            raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
        finally
          Free;
        end;

      if (State = dsEdit) and ((Azienda <> selTabella.FieldByName('AZIENDA').AsString) or (Profilo <> selTabella.FieldByName('PROFILO').AsString)) then
        if ProfiloUtilizzato then
          raise Exception.Create(A000MSG_ERR_MODIFICA_PROFILO);

      selI072.Cancel;
        if State <> dsInsert then
      begin
        selI072.First;
        AziendaOld:=selI072.FieldByName('AZIENDA').AsString;
        ProfiloOld:=selI072.FieldByName('PROFILO').AsString;
        FiltroOld:='';
        while not selI072.Eof do
        begin
          FiltroOld:=FiltroOld + Trim(selI072.FieldByName('FILTRO').AsString) + ' ';
          selI072.Delete;
        end;
      end;

      if memFiltroAnagrafe.Lines.Count = 0 then
      begin
        selI072.Append;
        selI072.FieldByName('AZIENDA').AsString:=Azienda;
        selI072.FieldByName('PROFILO').AsString:=Profilo;
        selI072.FieldByName('PROGRESSIVO').AsInteger:=0;
        selI072.FieldByName('FILTRO').AsString:='';
        selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString:=IfThen(chkSelezioneRichiestaPortale.Checked,'S','');
        selI072.Post;
      end
      else
        for i:=0 to memFiltroAnagrafe.Lines.Count - 1 do
        begin
          selI072.Append;
          selI072.FieldByName('AZIENDA').AsString:=Azienda;
          selI072.FieldByName('PROFILO').AsString:=Profilo;
          selI072.FieldByName('PROGRESSIVO').AsInteger:=i;
          selI072.FieldByName('FILTRO').AsString:=memFiltroAnagrafe.Lines[i];
          selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString:='';
          if (i = 0) and chkSelezioneRichiestaPortale.Checked then
            selI072.FieldByName('SELEZIONE_RICHIESTA_PORTALE').AsString:='S';
          selI072.Post;
        end;

      RegistraLog.SettaProprieta(IfThen(State = dsInsert,'I','M'),'I072_FILTROANAGRAFE',Copy(Name,1,5),nil,True);
      RegistraLog.InserisciDato('AZIENDA',IfThen(State = dsInsert,'',AziendaOld),Azienda);
      RegistraLog.InserisciDato('PROFILO',IfThen(State = dsInsert,'',ProfiloOld),Profilo);
      RegistraLog.InserisciDato('FILTRO',IfThen(State = dsInsert,'',Copy(Trim(FiltroOld),1,60)),Copy(Trim(memFiltroAnagrafe.Lines.Text),1,60));
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    end;
end;

procedure TWA183FFiltroAnagrafeDM.AfterScroll(DataSet: TDataSet);
begin
  selI072.Close;
  selI072.SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
  selI072.SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
  selI072.Open;
  inherited;
  //Apertura del database indicato dall'Azienda
  if selTabella.FieldByName('AZIENDA').AsString <> VecchiaAzienda then
  begin
    VecchiaAzienda:=selTabella.FieldByName('AZIENDA').AsString;
    if QI090.SearchRecord('AZIENDA',selTabella.FieldByName('AZIENDA').AsString,[srFromBeginning]) then
      with DbIris008B do
      begin
        if (not Connected) or
           (UpperCase(LogonUserName) <> UpperCase(QI090.FieldByName('UTENTE').AsString)) then
        begin
          Logoff;
          LogonDataBase:=Parametri.Database;
          LogonUserName:=QI090.FieldByName('UTENTE').AsString;
          LogonPassword:=R180Decripta(QI090.FieldByName('PAROLACHIAVE').AsString,21041974);
          Preferences.UseOCI7:=False;
          BytesPerCharacter:=bc1Byte;
        end;
        {$IFDEF IRISWEB}
          ThreadSafe:=True;
        {$ENDIF}
        Logon;
        TWA183FFiltroAnagrafe(Self.Owner).MessaggioStatus(INFORMA,'');
      end;
  end;
end;

procedure TWA183FFiltroAnagrafeDM.dsrI072StateChange(Sender: TObject);
begin
  inherited;
  if TWA183FFiltroAnagrafe(Self.Owner).WDettaglioFM <> nil then
    TWA183FFiltroAnagrafeDettFM( TWA183FFiltroAnagrafe(Self.Owner).WDettaglioFM).AbilitaAllComponenti(selI072);

  TWA183FFiltroAnagrafe(Self.Owner).selTabellaStateChange(selI072);
end;

procedure TWA183FFiltroAnagrafeDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('AZIENDA').Index:=0;
  selTabella.FieldByName('PROFILO').Index:=1;
  selTabella.FieldByName('SELEZIONE_RICHIESTA_PORTALE').Index:=2;
  selTabella.FieldByName('FILTRO').Index:=3;
  selTabella.FieldByName('AZIENDA').DisplayLabel:='Azienda';
  selTabella.FieldByName('PROFILO').DisplayLabel:='Profilo';
  selTabella.FieldByName('SELEZIONE_RICHIESTA_PORTALE').DisplayLabel:='Selezione anagrafica necessaria';
  selTabella.FieldByName('FILTRO').DisplayLabel:='Filtro';
end;

function TWA183FFiltroAnagrafeDM.ProfiloUtilizzato:Boolean;
begin
  with selPermessi do
  begin
    Close;
    SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
    SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
    Open;
    Result:=RecordCount > 0;
    Close;
  end;
end;


function TWA183FFiltroAnagrafeDM.VerificaFiltro(Filtro:String):String;
var OQ:TOracleQuery;
begin
  Result:='';
  OQ:=TOracleQuery.Create(nil);
  try
    OQ.Session:=SessioneOracle;
    OQ.SQL.Text:=QVistaOracle;
    OQ.SQL.Insert(0,'SELECT COUNT(*) FROM');
    if Trim(Filtro) <> '' then
    begin
      OQ.Sql.Add('AND (' + StringReplace(Filtro,':NOME_UTENTE','''1''',[rfReplaceAll,rfIgnoreCase]));
      OQ.Sql.Add(')');
    end;
    //Imposto la data di lavoro per i dati storici
    OQ.DeclareVariable('DataLavoro',otDate);
    OQ.SetVariable('DataLavoro',Parametri.DataLavoro);
    try
      OQ.Execute;
    except
      on E:Exception do
        Result:=E.Message;
    end;
  finally
    OQ.Free;
  end;
end;

end.

