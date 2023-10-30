unit WA184UFiltroFunzioniDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, System.TypInfo,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali, QueryPK,medpIWMessageDlg,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, USelI010,
  A000UCostanti, A000USessione, L021Call, IWCompListBox, StrUtils, Math,
  meIWEdit, meIWComboBox, A000UMessaggi;

type
  TWA184FFiltroFunzioniDM = class(TWR302FGestTabellaDM)
    selI073: TOracleDataSet;
    dsrI073: TDataSource;
    insI073: TOracleQuery;
    delI073: TOracleQuery;
    QI090: TOracleDataSet;
    D090: TDataSource;
    selPermessi: TOracleDataSet;
    updI073: TOracleQuery;
    selI073Applicazione: TOracleDataSet;
    selI073Agg: TOracleDataSet;
    delI073Agg: TOracleQuery;
    selVersione: TOracleDataSet;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure dsrI073StateChange(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selI073BeforePost(DataSet: TDataSet);
    procedure selI073FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    procedure EliminaFunzioniInesistenti;
    procedure AggiornaFunzioniEsistenti;
    procedure AggiungiFunzioniNuove;
    procedure EseguiAggiornaI073(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    AziendaCorrente, Gruppo, Descrizione:String;
    procedure SalvaFunzioni;
    function ProfiloUtilizzato:Boolean;
    procedure AggiornaI073;
  end;

implementation

uses WA184UFiltroFunzioni, WA184UFiltroFunzioniDettFM;

{$R *.dfm}

procedure TWA184FFiltroFunzioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY AZIENDA,PROFILO');
  NonAprireSelTabella:=True;
  inherited;

  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';
  selTabella.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  if Parametri.Azienda <> 'AZIN' then
  begin
    selTabella.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    selTabella.Filtered:=True;
    QI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
    QI090.Filtered:=True;
  end;

  (* spostato in azione esplicita AggiornaI073
  EliminaFunzioniInesistenti;
  AggiornaFunzioniEsistenti;
  AggiungiFunzioniNuove;*)
  QI090.Open;
  selTabella.Open;
end;

procedure TWA184FFiltroFunzioniDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;

  selI073.Close;
  selI073.SetVariable('AZIENDA',selTabella.FieldByName('AZIENDA').AsString);
  selI073.SetVariable('PROFILO',selTabella.FieldByName('PROFILO').AsString);
  selI073.SetVariable('APPLICAZIONE',Parametri.Applicazione);
  selI073.Open;
  if TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM) <> nil then
    TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).grdFunzioni.medpAggiornaCDS;
end;

procedure TWA184FFiltroFunzioniDM.AggiornaFunzioniEsistenti;
//Aggiorna le funzioni disponibili
var i:Integer;
begin
  for i:=1 to High(FunzioniDisponibili) do
  begin
    if FunzioniDisponibili[i].A = 'XXXX' then
      Continue;
    if not L021VerificaApplicazione(Parametri.Applicazione,i) then
      Continue;
    with updI073 do
    begin
      SetVariable('TAG',FunzioniDisponibili[i].T);
      SetVariable('FUNZIONE',FunzioniDisponibili[i].F);
      SetVariable('GRUPPO',FunzioniDisponibili[i].G);
      SetVariable('DESCRIZIONE',FunzioniDisponibili[i].N);
      Execute;
    end;
  end;
end;

procedure TWA184FFiltroFunzioniDM.AggiornaI073;
begin
  if (Parametri.Operatore <> 'MONDOEDP') and
     ((Parametri.VersionePJ <> Parametri.VersioneDB) or
      (Parametri.BuildPJ <> Parametri.BuildDB)) then
  begin
    raise exception.Create(Format(A000MSG_A008_VERSIONI_DIVERSE,[Parametri.VersionePJ,Parametri.BuildPJ,Parametri.VersioneDB,Parametri.BuildDB]) + CRLF + A000MSG_A008_AGGIORNAMENTO_IMPEDITO);
  end;

  if (Parametri.Operatore = 'MONDOEDP') and
     (Parametri.VersioneDB <> '') and
     (Parametri.BuildDB <> '') then
  begin
    try
      selVersione.Close;
      selVersione.SetVariable('VERSIONEDB', Parametri.VersioneDB + '.' + Parametri.BuildDB);
      selVersione.SetVariable('VERSIONEPJ', Parametri.VersionePJ + '.' + Parametri.BuildPJ);
      selVersione.Open;
      if selVersione.FieldByName('VERSIONEPJ').AsFloat < selVersione.FieldByName('VERSIONEDB').AsFloat then
      begin
        raise exception.Create(Format(A000MSG_A008_VERSIONE_INFERIORE,[Parametri.VersionePJ,Parametri.BuildPJ,Parametri.VersioneDB,Parametri.BuildDB]) + CRLF + A000MSG_A008_AGGIORNAMENTO_IMPEDITO);
      end;
    except
      on E:Exception do
      begin
        raise exception.Create(E.Message + CRLF + A000MSG_A008_AGGIORNAMENTO_IMPEDITO);
      end;
    end;
  end;

  if Parametri.VersioneDB = '' then
   MsgBox.WebMessageDlg(Format(A000MSG_A008_VERSIONE_DB,[Parametri.VersionePJ,Parametri.BuildPJ]),mtConfirmation,[mbYes, mbNo],EseguiAggiornaI073,'Conferma aggiornamento')
  else
    EseguiAggiornaI073(nil, mrYes,'');
end;

procedure TWA184FFiltroFunzioniDM.EliminaFunzioniInesistenti;
//Elimina le funzioni registrate ma non più disponibili
var i:Integer;
    Esiste:Boolean;
begin
  with selI073Agg do
  try
    Open;
    while not Eof do
    begin
      Esiste:=False;
      for i:=1 to High(FunzioniDisponibili) do
        if (FunzioniDisponibili[i].T = FieldByName('TAG').AsInteger) and L021VerificaApplicazione(Parametri.Applicazione,i) then
        begin
          Esiste:=True;
          Break;
        end;
      if Esiste then
        Next
      else
      try
        with delI073Agg do
        begin
          SetVariable('TAG',FieldByName('TAG').AsInteger);
          SetVariable('APPLICAZIONE',FieldByName('APPLICAZIONE').AsString);
          Execute;
        end;
      except
        Next;
      end;
    end;
  finally
    Close;
    SessioneOracle.Commit;
  end;
end;

procedure TWA184FFiltroFunzioniDM.EseguiAggiornaI073(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  EliminaFunzioniInesistenti;
  AggiornaFunzioniEsistenti;
  AggiungiFunzioniNuove;
end;

procedure TWA184FFiltroFunzioniDM.AggiungiFunzioniNuove;
//Aggiorna le funzioni disponibili
var i:Integer;
begin
  for i:=1 to High(FunzioniDisponibili) do
  begin
    if FunzioniDisponibili[i].A = 'XXXX' then
      Continue;
    if not L021VerificaApplicazione(Parametri.Applicazione,i) then
      Continue;
    with insI073 do
    begin
      SetVariable('TAG',FunzioniDisponibili[i].T);
      SetVariable('FUNZIONE',FunzioniDisponibili[i].F);
      SetVariable('GRUPPO',FunzioniDisponibili[i].G);
      SetVariable('DESCRIZIONE',FunzioniDisponibili[i].N);
      if FunzioniDisponibili[i].A = 'FUNWEB' then
        SetVariable('APPLICAZIONE',FunzioniDisponibili[i].A)
      else
        SetVariable('APPLICAZIONE',Parametri.Applicazione);
      Execute;
    end;
  end;
  SessioneOracle.Commit;
end;

procedure TWA184FFiltroFunzioniDM.selI073BeforePost(DataSet: TDataSet);
begin
  inherited;
  // controllo validità dati
  if (selI073.FieldByName('ACCESSO_BROWSE').AsString <> 'S') and
     (selI073.FieldByName('ACCESSO_BROWSE').AsString <> 'N') then
    raise Exception.Create('Il valore del dato Accesso Browse deve essere S oppure N');

  if selI073.FieldByName('RIGHE_PAGINA').AsInteger < -1 then
    raise Exception.Create('Il valore indicato per il dato Righe Pagina non è valido');

  if selI073.FieldByName('RIGHE_PAGINA').AsInteger > 9999 then
    raise Exception.Create('Il valore indicato per il dato Righe Pagina non è valido');
end;

procedure TWA184FFiltroFunzioniDM.selI073FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=True;
  if (Gruppo <> '') and (Gruppo <> 'Tutti') then
    Accept:=(selI073.FieldByName('GRUPPO').AsString = Gruppo);
  if Accept and (Descrizione <> '') then
    Accept:=Pos(UpperCase(Descrizione), UpperCase(selI073.FieldByName('DESCRIZIONE').AsString)) > 0;
end;

procedure TWA184FFiltroFunzioniDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('AZIENDA').Index:=0;
  selTabella.FieldByName('PROFILO').Index:=1;
  selTabella.FieldByName('INIBIZIONE_S').Index:=2;
  selTabella.FieldByName('INIBIZIONE_R').Index:=3;
  selTabella.FieldByName('INIBIZIONE_N').Index:=4;
  selTabella.FieldByName('AZIENDA').DisplayLabel:='Azienda';
  selTabella.FieldByName('PROFILO').DisplayLabel:='Profilo';
  selTabella.FieldByName('INIBIZIONE_S').DisplayLabel:='Accessi completi';
  selTabella.FieldByName('INIBIZIONE_R').DisplayLabel:='Accessi sola lettura';
  selTabella.FieldByName('INIBIZIONE_N').DisplayLabel:='Accessi negati';
end;

procedure TWA184FFiltroFunzioniDM.SalvaFunzioni;
var
  Azienda,Profilo:string;
  i:Integer;
  ControlloChiave:Boolean;
begin
  Azienda:=selI073.FieldByName('AZIENDA').Value;
  Profilo:=selI073.FieldByName('PROFILO').Value;

  ControlloChiave:=(selI073.State = dsInsert) or
                   ((selI073.State = dsEdit) and ((Azienda <> selTabella.FieldByName('AZIENDA').AsString) or (Profilo <> selTabella.FieldByName('PROFILO').AsString)));
  if ControlloChiave then
    with TQueryPK.Create(Self) do
    try
      Session:=SessioneOracle;
      if EsisteChiave('MONDOEDP.I073_FILTROFUNZIONI','',State,['AZIENDA','PROFILO'],[Azienda,Profilo]) then
        raise Exception.Create(A000MSG_ERR_CHIAVE_DUPLICATA);
    finally
      Free;
    end;

  if (selI073.State = dsEdit) and ((Azienda <> selTabella.FieldByName('AZIENDA').AsString) or (Profilo <> selTabella.FieldByName('PROFILO').AsString)) then
    if ProfiloUtilizzato then
      raise Exception.Create(A000MSG_ERR_MODIFICA_PROFILO);

  if selI073.State = dsInsert then
  try
    RegistraLog.SettaProprieta('I','I073_FILTROFUNZIONI',Copy(Name,1,5),nil,True);
    selI073.Cancel;
    for i:=1 to High(FunzioniDisponibili) do
    begin
      if FunzioniDisponibili[i].A = 'XXXX' then
        Continue;
      if not L021VerificaApplicazione(Parametri.Applicazione,i) then
        Continue;
      with selI073 do
      begin
        Append;
        FieldByName('AZIENDA').AsString:=Azienda;
        FieldByName('PROFILO').AsString:=Profilo;
        FieldByName('TAG').AsInteger:=FunzioniDisponibili[i].T;
        FieldByName('FUNZIONE').AsString:=FunzioniDisponibili[i].F;
        FieldByName('GRUPPO').AsString:=FunzioniDisponibili[i].G;
        FieldByName('DESCRIZIONE').AsString:=FunzioniDisponibili[i].N;
        if FunzioniDisponibili[i].A = 'FUNWEB' then
          FieldByName('APPLICAZIONE').AsString:=FunzioniDisponibili[i].A
        else
          FieldByName('APPLICAZIONE').AsString:=Parametri.Applicazione;
        FieldByName('INIBIZIONE').AsString:='N';
        selI073.FieldByName('ACCESSO_BROWSE').AsString:='S';
        selI073.FieldByName('RIGHE_PAGINA').AsInteger:=0;
        Post;
      end;
    end;
    RegistraLog.InserisciDato('AZIENDA','',Azienda);
    RegistraLog.InserisciDato('PROFILO','',Profilo);
    RegistraLog.RegistraOperazione;
  finally
    SessioneOracle.Commit;
  end
  else
  try
    selI073.Cancel;
    selI073.First;
    for i:=0 to selI073.RecordCount - 1 do
    begin
      selI073.Edit;
      selI073.FieldByName('AZIENDA').AsString:=Azienda;
      selI073.FieldByName('PROFILO').AsString:=Profilo;
      selI073.FieldByName('INIBIZIONE').AsString:=TmeIWComboBox(TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).grdFunzioni.medpCompCella(i,2,0)).Text;
      selI073.FieldByName('ACCESSO_BROWSE').AsString:=TmeIWComboBox(TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).grdFunzioni.medpCompCella(i,3,0)).Text;
      selI073.FieldByName('RIGHE_PAGINA').AsInteger:=StrToIntDef(TmeIWEdit(TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).grdFunzioni.medpCompCella(i,4,0)).Text,0);
      RegistraLog.SettaProprieta('M','I073_FILTROFUNZIONI',Copy(Name,1,5),selI073,(i = 0));
      selI073.Post;
      selI073.Next;
    end;
    RegistraLog.RegistraOperazione;
  finally
    SessioneOracle.Commit;
  end;
end;

procedure TWA184FFiltroFunzioniDM.dsrI073StateChange(Sender: TObject);
begin
  inherited;

  if TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM) <> nil then
    with TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM)do
    begin
      abilitaAllComponenti(selI073);
      TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).btnAggiornaFiltroFunzioni.Enabled:=not TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).btnAggiornaFiltroFunzioni.Enabled;
      TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).cmbFiltroFunzioni.Enabled:=not TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).cmbFiltroFunzioni.Enabled;
      SetPropValue(TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).edtContenuto, 'readonly', not TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).cmbFiltroFunzioni.Enabled);
      TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).edtContenuto.Enabled:=TWA184FFiltroFunzioniDettFM(TWA184FFiltroFunzioni(Self.Owner).WDettaglioFM).cmbFiltroFunzioni.Enabled;
      TWA184FFiltroFunzioni(Self.Owner).selTabellaStateChange(selI073);
    end;
end;

function TWA184FFiltroFunzioniDM.ProfiloUtilizzato:Boolean;
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

end.
