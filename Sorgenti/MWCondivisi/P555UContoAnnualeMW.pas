unit P555UContoAnnualeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData,C180FunzioniGenerali,
  System.Variants, Datasnap.DBClient, A000UInterfaccia, A000UMessaggi, Oracle, A000UCostanti;

type
  TP555FContoAnnualeMW = class(TR005FDataModuleMW)
    selP552: TOracleDataSet;
    dsrP552: TDataSource;
    selP552Col: TOracleDataSet;
    selP552ColANNO: TIntegerField;
    selP552ColCOD_TABELLA: TStringField;
    selP552ColCOLONNA: TIntegerField;
    selP552ColDESCRIZIONE: TStringField;
    selP552Riga: TOracleDataSet;
    selP552RigaANNO: TIntegerField;
    selP552RigaCOD_TABELLA: TStringField;
    selP552RigaRIGA: TIntegerField;
    selP552RigaDESCRIZIONE: TStringField;
    selP552RigaVALORE_COSTANTE: TStringField;
    dsrP552Riga: TDataSource;
    dsrP552Col: TDataSource;
    selP555: TOracleDataSet;
    selP555ID_CONTOANN: TFloatField;
    selP555PROGRESSIVO: TFloatField;
    selP555RIGA: TIntegerField;
    selP555COLONNA: TIntegerField;
    selP555VALORE: TFloatField;
    selP555Desc_Colonna: TStringField;
    selP555Desc_Riga: TStringField;
    selP555Valore_Costante: TStringField;
    dsrP555: TDataSource;
    selQuery: TOracleDataSet;
    dsrQuery: TDataSource;
    cdsValori: TClientDataSet;
    cdsValoriVARIABILE: TStringField;
    cdsValoriVALORE: TStringField;
    LungCampi: TOracleDataSet;
    selP555canc: TOracleDataSet;
    selDip: TOracleDataSet;
    selDipMATRICOLA: TStringField;
    selDipCOGNOME: TStringField;
    selDipNOME: TStringField;
    selDipVALORE: TFloatField;
    dsrDip: TDataSource;
    MaxAnno: TOracleDataSet;
    procedure selP555CalcFields(DataSet: TDataSet);
    procedure selP555NewRecord(DataSet: TDataSet);
    procedure selP555ApplyRecord(Sender: TOracleDataSet; Action: Char;
      var Applied: Boolean; var NewRowId: string);
    procedure DataModuleCreate(Sender: TObject);
  private
    FselP554_Funzioni: TOracleDataset;
    procedure TrovaVariabili(var Elenco: TStringList);
    procedure ElaboraVar;
    function LunghezzaCampo(F: TField): Integer;
  public
    AnnoRegole:Integer;
    RigSel,ColSel: String;
    bSelAnagrafe: boolean;
    ApplyP555: TProc<TOracleDataSet,Char>;
    procedure PosizionaSelP554(Progressivo: Integer);
    function ImpostaSelDip(Anno, Colonna, Riga: Integer;CodTabella: String): Integer;
    function ControllaSelDip(Valore:Real):String;
    procedure SalvaRiepilogo(Intestazione: boolean; var lst: TStringList);
    function ListRighe: TElencoValoriChecklist;
    function ListColonne: TElencoValoriChecklist;
    function MessaggioCancellazione: String;
    procedure FiltroRigheColonne;
    procedure ImpostaSelP552;
    procedure ImpostaSelQuery(CodTabella: String);
    procedure CostruisciGriglia(CodTabella: String);
    procedure CaricaVariabili(CodiceTabella: String);
    procedure ElaboraVariabili;
    procedure Aggiorna;
    function VerificaCalcoloManuale(CodTabella: String): String;
    procedure SelP554AfterScroll;
    procedure SelP554BeforeDelete;
    property SelP554_Funzioni: TOracleDataset read FselP554_Funzioni write FselP554_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


{ TP555FContoAnnualeMW }
procedure TP555FContoAnnualeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  RigSel:='';
  ColSel:='';
end;

procedure TP555FContoAnnualeMW.ImpostaSelP552;
begin
  if R180SetVariable(selP552,'ANNO',FselP554_Funzioni.FieldByName('ANNO').AsInteger) then
  begin
    selP552.Open;
  end;
  selP552.SearchRecord('COD_TABELLA',FselP554_Funzioni.FieldByName('COD_TABELLA').AsString,[srFromBeginning]);
end;

procedure TP555FContoAnnualeMW.SelP554BeforeDelete;
begin
  if FselP554_Funzioni.FieldByName('CHIUSO').AsString = 'S' then
    raise Exception.Create(A000MSG_P555_ERR_CHIUSO);
end;

procedure TP555FContoAnnualeMW.SelP554AfterScroll;
var
  anno: String;
begin
  AnnoRegole:=0;
  selQuery.Close;
  selQuery.SQL.Clear;
  selQuery.DeleteVariables;
  anno:='0';
  if FselP554_Funzioni.recordCount > 0 then
    anno:=FselP554_Funzioni.FieldByName('ANNO').AsString;
  selQuery.SQL.Add('SELECT MAX(ANNO) ANNO FROM P552_CONTOANNREGOLE WHERE ANNO <= ' + anno);
  selQuery.Open;
  if selQuery.RecordCount > 0 then
    AnnoRegole:=selQuery.FieldByName('ANNO').AsInteger;

  ImpostaSelP552;
end;

procedure TP555FContoAnnualeMW.Aggiorna;
begin
  selP552Riga.Close;
  selP552Riga.SetVariable('COD_TABELLA',FselP554_Funzioni.FieldByName('COD_TABELLA').AsString);
  selP552Riga.SetVariable('ANNO',AnnoRegole);
  selP552Riga.SetVariable('ORDERBY','order by anno,cod_tabella,riga');
  selP552Riga.Open;
  selP552Col.Close;
  selP552Col.SetVariable('COD_TABELLA',FselP554_Funzioni.FieldByName('COD_TABELLA').AsString);
  selP552Col.SetVariable('ANNO',AnnoRegole);
  selP552Col.SetVariable('ORDERBY','order by anno,cod_tabella,colonna');
  selP552Col.Open;
  selP555.Close;
  selP555.SetVariable('ANNOREGOLE',AnnoRegole);
  selP555.SetVariable('ID_CONTOANN',FselP554_Funzioni.FieldByName('ID_CONTOANN').AsInteger);
  if bSelAnagrafe then
  begin
    if SelAnagrafe <> nil then
      selP555.SetVariable('PROGRESSIVO',selAnagrafe.FieldByName('PROGRESSIVO').AsInteger)
    else
      selP555.SetVariable('PROGRESSIVO',0)
  end
  else
    selP555.SetVariable('PROGRESSIVO',-1);
  selP555.SetVariable('FILTRO',' ');
  selP555.Open;
end;

procedure TP555FContoAnnualeMW.selP555ApplyRecord(Sender: TOracleDataSet;
  Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  inherited;
  if Assigned(ApplyP555) then
    ApplyP555(Sender,Action);
end;

procedure TP555FContoAnnualeMW.selP555CalcFields(DataSet: TDataSet);
begin
  if selP552Riga.SearchRecord('ANNO;COD_TABELLA;RIGA',VarArrayOf([AnnoRegole,FselP554_Funzioni.FieldByName('COD_TABELLA').AsString,selP555.FieldByName('RIGA').AsInteger]),[srFromBeginning]) then
  begin
    selP555.FieldByName('DESC_RIGA').AsString:=selP552Riga.FieldByName('DESCRIZIONE').AsString;
    selP555.FieldByName('VALORE_COSTANTE').AsString:=selP552Riga.FieldByName('VALORE_COSTANTE').AsString;
  end;
  if selP552Col.SearchRecord('ANNO;COD_TABELLA;COLONNA',VarArrayOf([AnnoRegole,FselP554_Funzioni.FieldByName('COD_TABELLA').AsString,selP555.FieldByName('COLONNA').AsInteger]),[srFromBeginning]) then
    selP555.FieldByName('DESC_COLONNA').AsString:=selP552Col.FieldByName('DESCRIZIONE').AsString;
end;

procedure TP555FContoAnnualeMW.selP555NewRecord(DataSet: TDataSet);
begin
  selP555.FieldByName('ID_CONTOANN').AsInteger:=FselP554_Funzioni.FieldByName('ID_CONTOANN').AsInteger;
  if bSelAnagrafe then
    selP555.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger
  else //if P555FContoAnnuale.rgpTipoDati.ItemIndex = 1 then
    selP555.FieldByName('PROGRESSIVO').AsInteger:=-1;
end;

procedure TP555FContoAnnualeMW.TrovaVariabili(var Elenco: TStringList);
var Variabile,Stringa:String;
    x:Integer;
begin
  Stringa:=EliminaRitornoACapo(selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString);
  while Stringa <> '' do
  begin
    Variabile:='';
    x:=Pos(':',Stringa) + 1;
    if x = 1 then
      Break;
    while (Stringa[x] in ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']) or
      (Stringa[x] in ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']) or
      (Stringa[x] in ['1','2','3','4','5','6','7','8','9','0','_']) do
    begin
      Variabile:=Variabile+Copy(Stringa,x,1);
      x:=x + 1;
    end;
    if Elenco.IndexOf(Variabile) = -1 then
      Elenco.Add(Variabile);
    Stringa:=Copy(Stringa,x,Length(Stringa) - x + 1);
  end;
  Elenco.Sort;
end;

procedure TP555FContoAnnualeMW.CaricaVariabili(CodiceTabella: String);
var i:Integer;
    Valori:TStringList;
  Elenco: TStringList;
begin
  Elenco:=TStringList.Create;
  Elenco.Clear;
  TrovaVariabili(Elenco);
  with cdsValori do
  begin
    Close;
    CreateDataset;
    Open;
    LogChanges:=False;
    FieldByName('VARIABILE').ReadOnly:=False;
    for i:=0 to Elenco.Count - 1 do
    begin
      Insert;
      FieldByName('VARIABILE').AsString:=Elenco[i];
      if UpperCase(FieldByName('VARIABILE').AsString) = 'PROGRESSIVO' then
        FieldByName('VALORE').AsString:='-1'
      else if UpperCase(FieldByName('VARIABILE').AsString) = 'CODTABELLA' then
        FieldByName('VALORE').AsString:=CodiceTabella
      else if UpperCase(FieldByName('VARIABILE').AsString) = 'ANNOELABORAZIONE' then
        FieldByName('VALORE').AsString:=FselP554_Funzioni.FieldByName('ANNO').AsString
      else if UpperCase(FieldByName('VARIABILE').AsString) = 'P555' then
        FieldByName('VALORE').AsString:='P555_CONTOANNDATIINDIVIDUALI'
      else if UpperCase(FieldByName('VARIABILE').AsString) = 'SEL' then
        FieldByName('VALORE').AsString:='SELECT VALORE FROM P555_CONTOANNDATIINDIVIDUALI WHERE ID_CONTOANN=P554.ID_CONTOANN AND PROGRESSIVO';
      Post;
    end;
    FieldByName('VARIABILE').ReadOnly:=True;
  end;
  SessioneOracle.Commit;
  FreeAndNil(Elenco);
  FreeAndNil(Valori);
end;

procedure TP555FContoAnnualeMW.ElaboraVariabili;
begin
  selQuery.DeleteVariables;
  if cdsValori.RecordCount = 0 then
    Exit;
  cdsValori.First;
  while not cdsValori.Eof do
  begin
    if UpperCase(cdsValori.FieldByName('VARIABILE').AsString) = 'P555' then
      selQuery.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otSubst)
    else if UpperCase(cdsValori.FieldByName('VARIABILE').AsString) = 'SEL' then
      selQuery.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otSubst)
    else
      selQuery.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otString);
    selQuery.SetVariable(cdsValori.FieldByName('VARIABILE').AsString,cdsValori.FieldByName('VALORE').AsString);
    cdsValori.Next;
  end;
end;

procedure TP555FContoAnnualeMW.CostruisciGriglia(CodTabella:String);
var i:Integer;
    Campi:TStringList;
begin
  Campi:=TStringList.Create;
  Campi.Clear;
  selQuery.GetFieldNames(Campi);
  for i:=0 to Campi.Count - 1 do
  begin
    LungCampi.Close;
    LungCampi.SQL.Text:='';
    LungCampi.SQL.Add('select max(length(' + '"' + Campi[i] + '"' + ')) lunghezza from');
    LungCampi.SQL.Add('(' + selQuery.SQL.Text + ')');
    CaricaVariabili(codTabella);
    ElaboraVar;
    LungCampi.Open;
    if length(Campi[i]) > LungCampi.FieldByName('LUNGHEZZA').AsInteger then
      selQuery.FieldByName(Campi[i]).DisplayWidth:=length(Campi[i])
    else
      selQuery.FieldByName(Campi[i]).DisplayWidth:=LungCampi.FieldByName('LUNGHEZZA').AsInteger;
  end;
  FreeAndNil(Campi);
end;

procedure TP555FContoAnnualeMW.ElaboraVar;
begin
  LungCampi.DeleteVariables;
  if cdsValori.RecordCount = 0 then
    Exit;
  cdsValori.First;
  while not cdsValori.Eof do
  begin
    if UpperCase(cdsValori.FieldByName('VARIABILE').AsString) = 'P555' then
      LungCampi.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otSubst)
    else if UpperCase(cdsValori.FieldByName('VARIABILE').AsString) = 'SEL' then
      LungCampi.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otSubst)
    else
      LungCampi.DeclareVariable(cdsValori.FieldByName('VARIABILE').AsString,otString);
    LungCampi.SetVariable(cdsValori.FieldByName('VARIABILE').AsString,cdsValori.FieldByName('VALORE').AsString);
    cdsValori.Next;
  end;
end;

procedure TP555FContoAnnualeMW.ImpostaSelQuery(CodTabella: String);
begin
  selQuery.Close;
  selQuery.SQL.Text:='';
  selQuery.SQL.Text:=selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString;
  CaricaVariabili(CodTabella);
  ElaboraVariabili;
  selQuery.Open;
  CostruisciGriglia(CodTabella);
end;

function TP555FContoAnnualeMW.VerificaCalcoloManuale(CodTabella:String): String;
begin
  Result:='';
  if not selP552.SearchRecord('COD_TABELLA',CodTabella,[srFromBeginning]) then
  begin
    Result:=A000MSG_P555_ERR_NO_CALC_MAN_ANNO;
    Exit;
  end;
  if selP552.FieldByName('REGOLA_CALCOLO_MANUALE').AsString = '' then
  begin
    Result:=A000MSG_P555_ERR_NO_CALC_MAN_TAB;
    Exit;
  end;
end;

function TP555FContoAnnualeMW.ListColonne: TElencoValoriChecklist;
var codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with selP552Col do
  begin
    First;
    while not Eof do
    begin
      codice:=FieldByName('COLONNA').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-3s %-100s',[codice, FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

function TP555FContoAnnualeMW.ListRighe: TElencoValoriChecklist;
var codice: String;
begin
  Result:=TElencoValoriChecklist.Create;

  with selP552Riga do
  begin
    First;
    while not Eof do
    begin
      codice:=FieldByName('RIGA').AsString;
      Result.lstCodice.Add(codice);
      Result.lstDescrizione.Add(Format('%-3s %-100s',[codice, FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

procedure TP555FContoAnnualeMW.FiltroRigheColonne;
var
  s: String;
begin
  selP555.Close;
  selP555.SetVariable('ANNOREGOLE',AnnoRegole);
  selP555.SetVariable('ID_CONTOANN',FselP554_Funzioni.FieldByName('ID_CONTOANN').AsInteger);
  if bSelAnagrafe then
    selP555.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger)
  else
    selP555.SetVariable('PROGRESSIVO',-1);
  s:=' ';
  if Trim(RigSel) <> '' then
    s:=s + ' AND P552R.RIGA IN (' + RigSel + ')';
  if Trim(ColSel) <> '' then
    s:=s + ' AND P552C.COLONNA IN (' + ColSel + ')';
  selP555.SetVariable('FILTRO',s);
  selP555.Open;
end;

function TP555FContoAnnualeMW.MessaggioCancellazione: String;
begin
  selP555canc.Close;
  selP555canc.SetVariable('IdContoAnn', FselP554_Funzioni.FieldByName('ID_CONTOANN').AsInteger);
  selP555canc.Open;
  Result:=Format(A000MSG_DLG_FMT_CANCELLA_TESTATA,[selP555canc.FieldByName('NUMDIP').AsString]);
end;

function TP555FContoAnnualeMW.LunghezzaCampo(F:TField):Integer;
begin
  if F is TStringField then
    Result:=F.Size
  else
    Result:=F.DisplayWidth;
  if F.Index < F.DataSet.FieldCount then
    inc(Result);
end;

procedure TP555FContoAnnualeMW.SalvaRiepilogo(Intestazione: boolean;var lst: TStringList);
var
  S: String;
  i: Integer;
begin
  lst.Clear;

  with selQuery do
  begin
    First;
    DisableControls;
    if Intestazione then
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[Lunghezzacampo(Fields[i]),Copy(Fields[i].FieldName,1,Lunghezzacampo(Fields[i]))]);
      lst.Add(S);
    end;
    while not Eof do
    begin
      S:='';
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[Lunghezzacampo(Fields[i]), Copy(Fields[i].AsString,1,Lunghezzacampo(Fields[i]))]);
      lst.Add(S);
      Next;
    end;
    First;
    EnableControls;
  end;
end;

function TP555FContoAnnualeMW.ImpostaSelDip(Anno,Colonna,Riga:Integer;CodTabella:String):Integer;
begin
  with selDip do
  begin
    Close;
    SetVariable('Anno',Anno);
    SetVariable('Colonna',Colonna);
    SetVariable('Riga',Riga);
    SetVariable('CodTabella',CodTabella);
    Open;
    Result:=RecordCount;
  end;
end;

function TP555FContoAnnualeMW.ControllaSelDip(Valore:Real):String;
var Tot:Real;
begin
  Result:='';
  Tot:=0;
  with selDip do
  begin
    DisableControls;
    First;
    while not Eof do
    begin
      Tot:=Tot + FieldByName('VALORE').AsFloat;
      Next;
    end;
    First;
    EnableControls;
  end;
  if R180Arrotonda(Tot,1,'P') <> R180Arrotonda(Valore,1,'P') then
    Result:=Format(A000MSG_P555_ERR_FMT_VALORI_DIVERSI,[FloatToStr(R180Arrotonda(Tot,1,'P')),FloatToStr(R180Arrotonda(Valore,1,'P'))]);
end;

procedure TP555FContoAnnualeMW.PosizionaSelP554(Progressivo: Integer);
begin
  MaxAnno.Close;
  if Progressivo = 0 then
    MaxAnno.SetVariable('PROGRESSIVO',-1)
  else
    MaxAnno.SetVariable('PROGRESSIVO',Progressivo);
  MaxAnno.Open;
  if MaxAnno.FieldByName('ANNO').AsInteger <> 0 then
  begin
    if (not FselP554_Funzioni.SearchRecord('ANNO',MaxAnno.FieldByName('ANNO').AsInteger,[srFromBeginning])) and (Progressivo <> 0) then
    begin
      MaxAnno.Close;
      MaxAnno.SetVariable('PROGRESSIVO',-1);
      MaxAnno.Open;
      FselP554_Funzioni.SearchRecord('ANNO',MaxAnno.FieldByName('ANNO').AsInteger,[srFromBeginning]);
    end;
  end
  else if Progressivo <> 0 then
  begin
    MaxAnno.Close;
    MaxAnno.SetVariable('PROGRESSIVO',-1);
    MaxAnno.Open;
    FselP554_Funzioni.SearchRecord('ANNO',MaxAnno.FieldByName('ANNO').AsInteger,[srFromBeginning]);
  end;
end;

end.
