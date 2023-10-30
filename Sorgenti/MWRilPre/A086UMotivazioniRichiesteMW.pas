unit A086UMotivazioniRichiesteMW;

interface

uses
  A000UInterfaccia, A000UMessaggi,
  C180FunzioniGenerali, Oracle, OracleData, Variants,
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, Datasnap.DBClient;

type
  TA086FMotivazioniRichiesteMW = class(TR005FDataModuleMW)
    cdsTipologie: TClientDataSet;
    cdsTipologieCODICE: TStringField;
    cdsTipologieDESCRIZIONE: TStringField;
    selCausali: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSelT106: TOracleDataSet;
  public
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    ListaCausaliAss: TStringList;
    ListaCausaliPres: TStringList;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
    procedure FiltraSelT106(const PTipo: String);
    procedure SelT106NewRecord(const PTipo: String);
    procedure SelT106BeforePost;
    procedure SelT106BeforeDelete;
    property SelT106_Funzioni: TOracleDataset read FSelT106 write FSelT106;
  end;

implementation

{$R *.dfm}

procedure TA086FMotivazioniRichiesteMW.DataModuleCreate(Sender: TObject);
var
  LRiga: String;
begin
  inherited;

  // popola clientdataset tipologie (non sono presenti in tabella su db)
  cdsTipologie.EmptyDataSet;

  // T - richieste timbrature
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='T';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni richieste timbrature';
  cdsTipologie.Post;

  // T105C - richieste causali per timbrature
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='T105C';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni richieste causali per timbrature';
  cdsTipologie.Post;

  // M140 - annullamento missioni
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='M140';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni annullamento missioni';
  cdsTipologie.Post;

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  // T050 - richieste giustificativi
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='T050';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni richieste giustificativi';
  cdsTipologie.Post;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

  // T325 - richieste eccedenze giornaliere
  cdsTipologie.Append;
  cdsTipologie.FieldByName('CODICE').AsString:='T325';
  cdsTipologie.FieldByName('DESCRIZIONE').AsString:='Motivazioni richieste eccedenze giornaliere';
  cdsTipologie.Post;

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  ListaCausaliAss:=TStringList.Create;
  ListaCausaliPres:=TStringList.Create;
  selCausali.Open;
  selCausali.First;
  while not selCausali.Eof do
  begin
    LRiga:=Format('%-5s %s',[selCausali.FieldByName('CODICE').AsString,selCausali.FieldByName('DESCRIZIONE').AsString]);
    if selCausali.FieldByName('TIPO').AsString = 'A' then
      ListaCausaliAss.Add(LRiga)
    else
      ListaCausaliPres.Add(LRiga);
    selCausali.Next;
  end;
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
end;

procedure TA086FMotivazioniRichiesteMW.DataModuleDestroy(Sender: TObject);
begin
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  FreeAndNil(ListaCausaliAss);
  FreeAndNil(ListaCausaliPres);
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
  inherited;
end;

procedure TA086FMotivazioniRichiesteMW.FiltraSelT106(const PTipo: String);
begin
  FSelT106.Filtered:=False;
  FSelT106.Filter:=Format('TIPO = ''%s''',[PTipo]);
  FSelT106.Filtered:=True;

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  FSelT106.FieldByName('CAUSALI').Visible:=R180In(PTipo,['T105C','T050']);
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
end;

procedure TA086FMotivazioniRichiesteMW.SelT106BeforePost;
var
  Tipo: String;
begin
  // verifica che il tipo sia corretto (è automatico, quindi dovrebbe esserlo)
  Tipo:=FSelT106.FieldByName('TIPO').AsString;
  if Tipo <> VarToStr(cdsTipologie.Lookup('CODICE',Tipo,'CODICE')) then
    raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A086_ERR_FMT_TIPO_VALORE),[Tipo]));

  // verifica valore di CODICE_DEFAULT
  if not R180In(FSelT106.FieldByName('CODICE_DEFAULT').AsString,['S','N']) then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A086_ERR_CODICE_DEFAULT));

  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
  // verifica che il default sia impostato solo su record con CAUSALI null
  if (FSelT106.FieldByName('CODICE_DEFAULT').AsString = 'S') and
     (FSelT106.FieldByName('CAUSALI').AsString <> '') then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A086_ERR_CODICE_DEFAULT_CAUS_NOT_NULL));
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine

  // verifica che il default sia impostato su un solo record per tipo
  if FSelT106.FieldByName('CODICE_DEFAULT').AsString = 'S' then
  begin
    if QueryPK1.EsisteChiave('T106_MOTIVAZIONIRICHIESTE',FSelT106.RowID,FSelT106.State,['TIPO','CODICE_DEFAULT'],[FSelT106.FieldByName('TIPO').AsString,'S']) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A086_ERR_CODICE_DEFAULT_MULT));
  end;
end;

procedure TA086FMotivazioniRichiesteMW.SelT106NewRecord(const PTipo: String);
begin
  // impostazione valori per il nuovo record
  FSelT106.FieldByName('TIPO').AsString:=PTipo;
end;

procedure TA086FMotivazioniRichiesteMW.SelT106BeforeDelete;
var
  Q: TOracleQuery;
  Tipo, Codice, StrSql{, Descrizione}: String;
begin
  // variabili di supporto
  Tipo:=VarToStr(FSelT106.FieldByName('TIPO').medpOldValue);
  Codice:=VarToStr(FSelT106.FieldByName('CODICE').medpOldValue);
  //Descrizione:=VarToStr(FSelT106.FieldByName('DESCRIZIONE').medpOldValue);

  // imposta query per verificare che il codice non sia utilizzato
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    // in base al tipo verifica se il codice è utilizzato
    if Tipo = 'T' then
    begin
      // motivazioni richieste timbrature (W018)
      StrSql:=Format('select count(*) from T105_RICHIESTETIMBRATURE '#13#10 +
                     'where  MOTIVAZIONE = ''%s''',[Codice]);
      Q.SQL.Text:=StrSql;
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create('La motivazione è utilizzata nelle richieste di'#13#10 +
                               'modifica delle timbrature web.'#13#10 +
                               'Cancellazione impossibile!');
    end
    else if Tipo = 'M140' then
    begin
      // motivazioni annullamento richieste missioni
      // in questo caso non si controlla nulla, perché le motivazioni vengono
      // utilizzate solo per quanto riguarda le descrizioni, come proposta
      // di diciture in fase di annullamento
      {
      StrSql:=Format('select count(*) from M140_RICHIESTE_MISSIONI '#13#10 +
                     'where  ANNULLAMENTO = ''%s''',[Descrizione]);
      Q.SQL.Text:=StrSql;
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create('La descrizione è utilizzata come motivazione di annullamento' + #13#10 +
                               'nelle richieste di trasferta web.'#13#10 +
                               'Cancellazione impossibile!');
      }
    end
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.ini
    else if Tipo = 'T050' then
    begin
      // motivazioni richieste giustificativi (W010)
      StrSql:=Format('select count(*) from T050_RICHIESTEASSENZA '#13#10 +
                     'where  MOTIVAZIONE = ''%s''',[Codice]);
      Q.SQL.Text:=StrSql;
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create('La motivazione è utilizzata nelle richieste'#13#10 +
                               'di giustificativi web.'#13#10 +
                               'Cancellazione impossibile!');
    end
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#3.fine
    else if Tipo = 'T325' then
    begin
      // motivazioni richieste eccedenze gg. (W026)
      StrSql:=Format('select count(*) from T326_RICHIESTESTR_SPEZ '#13#10 +
                     'where  MOTIVAZIONE = ''%s''',[Codice]);
      Q.SQL.Text:=StrSql;
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create('La motivazione è utilizzata nelle richieste di'#13#10 +
                               'eccedenze giornaliere web.'#13#10 +
                               'Cancellazione impossibile!');
    end;
  finally
    FreeAndNil(Q);
  end;
end;

end.
