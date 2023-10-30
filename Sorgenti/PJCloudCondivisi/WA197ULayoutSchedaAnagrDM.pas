unit WA197ULayoutSchedaAnagrDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  System.Generics.Collections,C180FunzioniGenerali,A000UInterfaccia, Oracle, A000UMessaggi,
  medpIWMessageDlg,StrUtils;

type
  TEvDataset = procedure (DataSet: TDataSet) of object;

  TWA197FLayoutSchedaAnagrDM = class(TWR302FGestTabellaDM)
    selT033_Pagine: TOracleDataSet;
    selTabellaNOME: TStringField;
    selTabellaCAMPODB: TStringField;
    selLayout: TOracleDataSet;
    selI071: TOracleQuery;
    delT033: TOracleQuery;
    selTabellaTOP: TFloatField;
    selTabellaLFT: TFloatField;
    selTabellaCAPTION: TStringField;
    selTabellaACCESSO: TStringField;
    selTabellaNOMEPAGINA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
  private
    SaveNome: String;
    procedure DatasetPagine(LoadFormDefault: Boolean);
    procedure ResetdicDatasetPagina;
    procedure removeDataset(pag: String);
    function verificaPermessi(Nome: String): Boolean;
    function CreaDatasetPagina(Nome, NomePagina: String): TOracleDataSet;
    procedure DatasetPaginaBeforepost(DataSet: TDataSet);
  public
    dicDatasetPagina: TDictionary<String,TOracleDataSet>;
    procedure ImpostaAccessoPagina(pagina, Accesso: String);
  end;

  const
    LAYOUT_DEFAULT: String = 'DEFAULT';
    LAYOUT_MONDOEDP: String = 'MONDOEDP';

implementation

{$R *.dfm}

procedure TWA197FLayoutSchedaAnagrDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selLayout.SetVariable('AZIELAV',Parametri.Azienda);

  dicDatasetPagina:=TDictionary<String,TOracleDataSet>.Create;

  selTabella.SetVariable('ORDERBY','ORDER BY NOME');
  inherited;
end;

procedure TWA197FLayoutSchedaAnagrDM.ImpostaAccessoPagina(pagina: String; Accesso: String);
begin
  with dicDatasetPagina.Items[pagina] do
  begin
    BeforePost:=nil;
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('ACCESSO').AsString:=Accesso;
      Post;
      Next;
    end;
    BeforePost:=DatasetPaginaBeforepost;
  end;
end;

procedure TWA197FLayoutSchedaAnagrDM.AfterScroll(DataSet: TDataSet);
begin
  //in inserimento la creazione dei dataset viene fatta su onNewRecord
  //ed è già stata eseguita medpAttivaGrid. se distruggo e ricreo il dataset
  //associato alla medpGrid da access violation se tento di modificare
  if selTabella.State <> dsInsert then
    DatasetPagine(False);
  inherited;
end;

procedure TWA197FLayoutSchedaAnagrDM.BeforePostNoStorico(DataSet: TDataSet);
var
  s, tmpLog: String;
  evAfterCancel:TEvDataset;
  Resetta: Boolean;
begin
  //devo inibire il log perchè gestito dopo
  tmpLog:=Parametri.LogTabelle;
  Parametri.LogTabelle:='N';
  inherited;
  Parametri.LogTabelle:=tmpLog;

  if (selTabella.State = dsEdit) and
     (selTabella.FieldByName('NOME').medpOldValue <> selTabella.FieldByName('NOME').AsString ) then
  begin
    if selTabella.FieldByName('NOME').medpOldValue = LAYOUT_DEFAULT then
    begin
      MsgBox.WebMessageDlg(A000MSG_A197_ERR_LAYOUT_DEFAULT,mtError,[mbOK],nil,'');
      Abort;
    end;

    if not VerificaPermessi(selTabella.FieldByName('NOME').medpOldValue) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A197_ERR_LAYOUT_USO,mtError,[mbOK],nil,'');
      Abort;
    end;
  end;

  if (selTabella.State = dsInsert) or
     (selTabella.FieldByName('NOME').medpOldValue <> selTabella.FieldByName('NOME').AsString ) then
  begin
    if selTabella.FieldByName('NOME').AsString = LAYOUT_MONDOEDP then
    begin
      MsgBox.WebMessageDlg(A000MSG_A197_ERR_LAYOUT_MEDP,mtError,[mbOK],nil,'');
      Abort;
    end;
  end;

  if (selTabella.FieldByName('NOME').AsString = '') then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Nome']),mtError,[mbOK],nil,'');
    Abort;
  end;

  //Non Mettere in afterPost perchè tra beforePost e afterPost si scatena scroll che ricarica i dataset
  Resetta:=True;
  for s in dicDatasetPagina.Keys do
  begin
    with dicDatasetPagina.Items[s] do
    begin
      BeforePost:=nil;
      First;
      while not Eof do
      begin
        Edit;
        FieldByName('NOME').AsString:=selTabella.FieldByName('NOME').AsString;
        //gestione log

        RegistraLog.SettaProprieta(IfThen(selTabella.State = dsInsert,'I','M'),'T033_LAYOUT',Copy(Self.Name,1,5), dicDatasetPagina.Items[s],Resetta);
        Resetta:=False;
        Next;
      end;
      BeforePost:=DatasetPaginaBeforepost;
    end;
    SessioneOracle.ApplyUpdates([dicDatasetPagina.Items[s]],False);
  end;

  SessioneOracle.Commit;
  SaveNome:=selTabella.FieldByName('NOME').AsString;
  //Devo riposizionarmi su record
  evAfterCancel:=seltabella.AfterCancel;
  seltabella.AfterCancel:=nil;
  selTabella.CancelUpdates;
  seltabella.AfterCancel:=evAfterCancel;
  selTabella.Refresh;
  selTabella.SearchRecord('NOME;CAMPODB',VarArrayOf([SaveNome,'MATRICOLA']),[srFromBeginning]);
end;

procedure TWA197FLayoutSchedaAnagrDM.BeforeDelete(DataSet: TDataSet);
begin
  if selTabella.FieldByName('NOME').AsString = LAYOUT_DEFAULT then
  begin
    MsgBox.WebMessageDlg(A000MSG_A197_ERR_LAYOUT_DEFAULT,mtError,[mbOK],nil,'');
    Abort;
  end;

  if not VerificaPermessi(selTabella.FieldByName('NOME').AsString) then
  begin
    MsgBox.WebMessageDlg(A000MSG_A197_ERR_LAYOUT_USO,mtError,[mbOK],nil,'');
    Abort;
  end;
  SaveNome:=selTabella.FieldByName('NOME').AsString;
  inherited;
end;

procedure TWA197FLayoutSchedaAnagrDM.AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([selTabella],True);
  delT033.SetVariable('NOME',SaveNome);
  delT033.Execute;
  SessioneOracle.Commit;

  //Devo forzare scroll per ricaricare dati del record corrent
  AfterScroll(selTabella);
  inherited;
end;

function TWA197FLayoutSchedaAnagrDM.CreaDatasetPagina(Nome, NomePagina:String):TOracleDataSet;
begin
  Result:=TOracleDataSet.Create(Self);
  Result.CachedUpdates:=True;
  Result.BeforePost:=DatasetPaginaBeforepost;
  Result.Name:=Identificatore('selT033' + Nome + NomePagina);
  Result.Session:=SessioneOracle;
  Result.SQL.Text:='select t.campodb,t.caption, t.top,t.lft,t.accesso,t.nomepagina,t.nome, t.rowid from t033_layout t where t.nome=:NOME and t.nomepagina= :NOMEPAGINA :ORDERBY';
  Result.DeclareVariable('NOME',otString);
  Result.DeclareVariable('NOMEPAGINA',otString);
  Result.DeclareVariable('ORDERBY',otSubst);
  Result.setVariable('NOME',Nome);
  Result.setVariable('NOMEPAGINA',NomePagina);
  Result.setVariable('ORDERBY','ORDER BY decode(ACCESSO,''S'',0,''R'',0,1),TOP,LFT');
  Result.Open;
  Result.FieldByName('CAMPODB').DisplayLabel:='Campo';
  Result.FieldByName('CAPTION').DisplayLabel:='Caption';
  Result.FieldByName('CAPTION').DisplayWidth:=25;
  Result.FieldByName('TOP').DisplayLabel:='Alto';
  Result.FieldByName('TOP').EditMask:='!999.99;1;_';
  Result.FieldByName('TOP').DisplayWidth:=3;
  Result.FieldByName('LFT').DisplayLabel:='Sinistra';
  Result.FieldByName('LFT').EditMask:='!999.99;1;_';
  Result.FieldByName('LFT').DisplayWidth:=3;
  Result.FieldByName('ACCESSO').DisplayLabel:='Accesso';
  Result.FieldByName('NOMEPAGINA').DisplayLabel:='Pagina';
  Result.FieldByName('NOME').Visible:=False;  
end;

procedure TWA197FLayoutSchedaAnagrDM.DatasetPaginaBeforepost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('CAPTION').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Caption']),mtError,[mbOK],nil,'');
    Abort;
  end;

  if DataSet.FieldByName('TOP').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Alto']),mtError,[mbOK],nil,'');
    Abort;
  end;

  if DataSet.FieldByName('LFT').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Sinitra']),mtError,[mbOK],nil,'');
    Abort;
  end;

  if DataSet.FieldByName('NOMEPAGINA').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Pagina']),mtError,[mbOK],nil,'');
    Abort;
  end;

  if DataSet.FieldByName('ACCESSO').AsString = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Accesso']),mtError,[mbOK],nil,'');
    Abort;  
  end;
  
  if  not R180In(DataSet.FieldByName('ACCESSO').AsString, ['S','N','R']) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A094_ERR_FMT_NON_IN_ELENCO,['Accesso']),mtError,[mbOK],nil,'');
    Abort;  
  end;
end;

procedure TWA197FLayoutSchedaAnagrDM.DatasetPagine(LoadFormDefault: Boolean);
var Query, QueryOrigine: TOracleDataSet;
  field: TStringField;
begin
  with selT033_Pagine do
  begin
    Close;
    if LoadFormDefault then
      SetVariable('NOME', LAYOUT_DEFAULT)
    else
      SetVariable('NOME', selTabella.FieldByName('NOME').AsString);
    Open;

    ResetdicDatasetPagina;
    //pulire vecchi dataset da dictionary

    First;
    while not Eof do
    begin
      try
        Query:=CreaDatasetPagina(selTabella.FieldByName('NOME').AsString, FieldByName('NOMEPAGINA').AsString);
      except
        raise Exception.Create('Errore creazione dataset pagina');
      end;
      if LoadFormDefault then
      begin
        try
          try
            Query.BeforePost:=nil;
            QueryOrigine:=CreaDatasetPagina(LAYOUT_DEFAULT, FieldByName('NOMEPAGINA').AsString);
            while not QueryOrigine.Eof  do
            begin
              Query.Append;
              Query.FieldByName('CAMPODB').AsString:=QueryOrigine.FieldByName('CAMPODB').AsString;
              Query.FieldByName('CAPTION').AsString:=QueryOrigine.FieldByName('CAPTION').AsString;
              Query.FieldByName('TOP').AsFloat:=QueryOrigine.FieldByName('TOP').AsFloat;
              Query.FieldByName('LFT').AsFloat:=QueryOrigine.FieldByName('LFT').AsFloat;
              Query.FieldByName('ACCESSO').AsString:=QueryOrigine.FieldByName('ACCESSO').AsString;
              Query.FieldByName('NOMEPAGINA').AsString:=QueryOrigine.FieldByName('NOMEPAGINA').AsString;
              Query.FieldByName('NOME').AsString:=QueryOrigine.FieldByName('NOME').AsString;
              Query.Post;
              QueryOrigine.Next;
            end;
          finally
            Query.BeforePost:=DatasetPaginaBeforepost;
            Query.First;
            QueryOrigine.Close;
            FreeAndNil(QueryOrigine);
          end;
        except
          raise Exception.Create('Errore caricamento dataset da DEFAULT');
        end;

      end;
      dicDatasetPagina.Add(FieldByName('NOMEPAGINA').AsString,Query);
      Next;
    end;
    First;
  end;
end;

procedure TWA197FLayoutSchedaAnagrDM.ResetdicDatasetPagina;
var s: String;
begin
  //Non usare direttamente Keys ma il toArray
  //perchè rimuovendo le chiavi, l'iterator sulle chiavi non scorre tutti gli elementi
  for s in dicDatasetPagina.Keys.ToArray do
    removeDataset(s);
end;

procedure TWA197FLayoutSchedaAnagrDM.removeDataset(pag: String);
var sez: TOracleDataSet;
begin
  if dicDatasetPagina.ContainsKey(pag) then
  begin
    Sez:=dicDatasetPagina.Items[pag];
    FreeAndNil(Sez);
    dicDatasetPagina.Remove(pag);
  end;
end;

function TWA197FLayoutSchedaAnagrDM.VerificaPermessi(Nome:String): Boolean;
begin
  Result:=False;
  selI071.SetVariable('NOME',Nome);
  selI071.Execute;
  if selI071.FieldAsInteger(0) = 0 then
    Result:=True;
end;

procedure TWA197FLayoutSchedaAnagrDM.OnNewRecord(DataSet: TDataSet);
begin
  DatasetPagine(True);
  //Necessario per corretto test EsisteChiave in fase di insert
  selTabella.FieldByName('CAMPODB').AsString:='MATRICOLA';
  inherited;
end;

procedure TWA197FLayoutSchedaAnagrDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  ResetdicDatasetPagina;
  FreeAndNil(dicDatasetPagina);
  inherited;
end;

end.
