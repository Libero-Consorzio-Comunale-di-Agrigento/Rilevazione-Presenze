unit S700UAreeValutazioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, Oracle,
  C180FunzioniGenerali, Variants, Math, A000UInterfaccia, A000UMessaggi,
  Datasnap.DBClient;

type
  TS700FAreeValutazioniMW = class(TR005FDataModuleMW)
    updSG701: TOracleQuery;
    selLinkItem: TOracleDataSet;
    selLinkItemCOD_AREA: TStringField;
    selLinkItemCOD_VALUTAZIONE: TStringField;
    selLinkItemDESCRIZIONE: TStringField;
    selSG710: TOracleDataSet;
    selSG711: TOracleQuery;
    selSG746: TOracleDataSet;
    selSG700: TOracleDataSet;
    selSG700COD_AREA: TStringField;
    selSG700DECORRENZA: TDateTimeField;
    selSG700COD_VALUTAZIONE: TStringField;
    selSG700DESCRIZIONE: TStringField;
    selSG700PESO_PERCENTUALE: TFloatField;
    selSG700COD_AREA_LINK: TStringField;
    selSG700COD_VALUTAZIONE_LINK: TStringField;
    selSG700DESCRIZIONE_LINK: TStringField;
    selSG701a: TOracleDataSet;
    cdsSG700: TClientDataSet;
    selSG700DESCRIZIONI_PUNTEGGI: TStringField;
    procedure selSG700NewRecord(DataSet: TDataSet);
    procedure selSG700CalcFields(DataSet: TDataSet);
    procedure selSG700BeforePost(DataSet: TDataSet);
    procedure OnNewRecord;
    procedure selSG700COD_VALUTAZIONEValidate(Sender: TField);
    procedure selSG700BeforeDelete(DataSet: TDataSet);
    procedure selSG700AfterPost(DataSet: TDataSet);
    procedure selSG700ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
  private
    Fsg701_Funzioni: TOracleDataSet;
  public
    AreeSel:String;
    AfterPostRecall: procedure of object;
    property SG701_Funzioni: TOracleDataset read Fsg701_Funzioni write Fsg701_Funzioni;
    procedure AfterScroll;
    procedure PESO_PERCENTUALEValidate(Sender: TField);
    procedure VerificaPercentuali;
    procedure VerificaPeso;
    procedure VerificaItemPersonalizzatiMin;
    procedure RicalcolaPesoArea(Enabled: Boolean; Win: Boolean);
    function VerificaItemPersonalizzatiMax: String;
    function ControllaSchedeEsistenti: String;
    procedure AreeCopiaDettaglio;
    procedure CopiaDettaglio;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TS700FAreeValutazioniMW.AfterScroll;
begin
  selSG700.Close;
  selSG700.SetVariable('COD_AREA',Fsg701_Funzioni.FieldByName('COD_AREA').AsString);
  selSG700.SetVariable('DECORRENZA',Fsg701_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  selSG700.Open;
end;

procedure TS700FAreeValutazioniMW.PESO_PERCENTUALEValidate(Sender: TField);
begin
  if (Sender.AsInteger < 0)
  or (Sender.AsInteger > 100) then
    raise Exception.Create(Format(A000MSG_S700_ERR_FMT_VAL_COMPRESO,[Sender.DisplayLabel]));
end;

procedure TS700FAreeValutazioniMW.selSG700NewRecord(DataSet: TDataSet);
begin
  selSG700.FieldByName('COD_AREA').AsString:=Fsg701_Funzioni.FieldByName('COD_AREA').AsString;
  selSG700.FieldByName('DECORRENZA').AsDateTime:=Fsg701_Funzioni.FieldByName('DECORRENZA').AsDateTime;
end;

procedure TS700FAreeValutazioniMW.selSG700CalcFields(DataSet: TDataSet);
begin
  R180SetVariable(selLinkItem,'DATA',Fsg701_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime);
  selLinkItem.Open;
  with selSG700 do
    FieldByName('DESCRIZIONE_LINK').AsString:=VarToStr(selLinkItem.Lookup('COD_AREA;COD_VALUTAZIONE',VarArrayOf([FieldByName('COD_AREA_LINK').AsString,FieldByName('COD_VALUTAZIONE_LINK').AsString]),'DESCRIZIONE'));
end;

procedure TS700FAreeValutazioniMW.selSG700COD_VALUTAZIONEValidate(Sender: TField);
begin
  inherited;
  selSG711.SetVariable('COD_AREA',selSG700.FieldByName('COD_AREA').AsString);
  selSG711.SetVariable('COD_VALUTAZIONE',selSG700.FieldByName('COD_VALUTAZIONE').AsString);
  selSG711.Execute;
  if selSG711.FieldAsInteger(0) > 0 then
     raise Exception.Create(Format(A000MSG_S700_ERR_FMT_COD_INSERITO,[selSG700.FieldByName('COD_VALUTAZIONE').AsString, selSG700.FieldByName('COD_AREA').AsString]));
  end;

procedure TS700FAreeValutazioniMW.selSG700AfterPost(DataSet: TDataSet);
begin
  inherited;
  {S700FAreeValutazioni.AbilitaComponenti;}
end;

procedure TS700FAreeValutazioniMW.selSG700ApplyRecord(Sender: TOracleDataSet; Action: Char; var Applied: Boolean; var NewRowId: string);
begin
  case Action of
    'D':RegistraLog.SettaProprieta('C',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'I':RegistraLog.SettaProprieta('I',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
    'U':RegistraLog.SettaProprieta('M',R180Query2NomeTabella(Sender),Copy(Name,1,4),Sender,True);
  end;
  if Action in ['D','I','U'] then
    RegistraLog.RegistraOperazione;
end;

procedure TS700FAreeValutazioniMW.selSG700BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  ControllaSchedeEsistenti;
end;

procedure TS700FAreeValutazioniMW.selSG700BeforePost(DataSet: TDataSet);
begin
  if selSG700.FieldByName('COD_VALUTAZIONE').IsNull then
    raise exception.Create(A000MSG_S700_ERR_INSERIRE_COD);
  if selSG700.FieldByName('DESCRIZIONE').IsNull then
    raise exception.Create(A000MSG_S700_ERR_INSERIRE_DESC);
  if (Fsg701_Funzioni.FieldByName('TIPO_LINK_ITEM').AsString <> '0') then
  begin
    if selSG700.FieldByName('COD_AREA_LINK').IsNull then
      raise exception.Create(A000MSG_S700_ERR_INS_COD_AREA);
    if selSG700.FieldByName('COD_VALUTAZIONE_LINK').IsNull then
      raise exception.Create(A000MSG_S700_ERR_INS_COD_ELEM);
    R180SetVariable(selLinkItem,'DATA',Fsg701_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime);
    selLinkItem.Open;
    if VarToStr(selLinkItem.Lookup('COD_AREA;COD_VALUTAZIONE',VarArrayOf([selSG700.FieldByName('COD_AREA_LINK').AsString,selSG700.FieldByName('COD_VALUTAZIONE_LINK').AsString]),'DESCRIZIONE')) = '' then
      raise exception.Create(A000MSG_S700_ERR_VALID_ELEM);
  end;
end;

procedure TS700FAreeValutazioniMW.OnNewRecord;
begin
  Fsg701_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime:=DATE_MAX;
  R180SetVariable(selLinkItem,'DATA',Fsg701_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime);
  selLinkItem.Open;
end;

procedure TS700FAreeValutazioniMW.VerificaPercentuali;
begin
  if (Fsg701_Funzioni.FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1')
  and (Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat = 0) then
    raise exception.Create(A000MSG_S700_ERR_PESO_PERC_AREA);
end;

procedure TS700FAreeValutazioniMW.VerificaPeso;
begin
  if (Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat < Fsg701_Funzioni.FieldByName('PESO_PERC_MIN').AsFloat)
    or (Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat > Fsg701_Funzioni.FieldByName('PESO_PERC_MAX').AsFloat)
    and not ((Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat = 0) and (selSG700.RecordCount = 0)) then
      raise exception.Create(A000MSG_S700_ERR_PESO_PERC_AREA);
end;

procedure TS700FAreeValutazioniMW.VerificaItemPersonalizzatiMin;
begin
  if Fsg701_Funzioni.FieldByName('ITEM_PERSONALIZZATI_MIN').AsInteger > Fsg701_Funzioni.FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger then
    raise exception.Create(A000MSG_S700_ERR_PESO_RANGE_ELEM);
end;

function TS700FAreeValutazioniMW.VerificaItemPersonalizzatiMax:String;
begin
  Result:='';
  if (Fsg701_Funzioni.FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger > 0)
  and (Trim(Fsg701_Funzioni.FieldByName('TESTO_ITEM_PERSONALIZZATI').AsString) = '') then
    Result:=A000MSG_S700_MSG_COMPILARE_CAMPO;
end;

procedure TS700FAreeValutazioniMW.RicalcolaPesoArea(Enabled: Boolean; Win: Boolean);
var
  BM: TBookmark;
  PesoArea,PesoItem: Real;
begin
  inherited;
  selSG700.DisableControls;
  BM:=selSG700.GetBookmark;
  //Se l'area prevede la ripartizione equa dei pesi degli elementi...
  if Fsg701_Funzioni.FieldByName('PESO_EQUO_ITEMS').AsString = 'S' then
  begin
    try
      selSG700.ReadOnly:=False;
      //...divido il peso dell'area per il numero di elementi
      PesoArea:=IfThen(Fsg701_Funzioni.FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1',100,Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat);
      PesoItem:=0;
      if selSG700.RecordCount > 0 then
        PesoItem:=R180Arrotonda(PesoArea / selSG700.RecordCount,0.01,'P');
      selSG700.First;
      while not selSG700.Eof do
      begin
        selSG700.Edit;
        selSG700.FieldByName('PESO_PERCENTUALE').AsFloat:=PesoItem;
        selSG700.Post;
        PesoArea:=PesoArea - PesoItem;
        selSG700.Next;
      end;
      selSG700.Last;
      while (PesoArea <> 0)
      and (selSG700.RecordCount > 0) do
      begin
        selSG700.Edit;
        selSG700.FieldByName('PESO_PERCENTUALE').AsFloat:=PesoItem + (0.01 * IfThen(PesoArea < 0,-1,1));
        selSG700.Post;
        PesoArea:=R180Arrotonda(PesoArea + (0.01 * IfThen(PesoArea < 0,1,-1)),0.01,'P');
        selSG700.Prior;
      end;
      SessioneOracle.ApplyUpdates([selSG700],True);
      selSG700.GotoBookmark(BM);
    finally
      selSG700.FreeBookmark(BM);
      selSG700.EnableControls;
      if Win then
        selSG700.ReadOnly:=True;
    end;
  end
  else
  begin
    try
      PesoArea:=0;
      selSG700.First;
      while not selSG700.Eof do
      begin
        PesoArea:=PesoArea + selSG700.FieldByName('PESO_PERCENTUALE').AsFloat;
        selSG700.Next;
      end;
      selSG700.GotoBookmark(BM);
    finally
      selSG700.FreeBookmark(BM);
      selSG700.EnableControls;
    end;
    if Fsg701_Funzioni.FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1' then
    begin
      if PesoArea <> 100 then
        raise exception.create(A000MSG_S700_ERR_SOMMA_PESO);
    end
    else
    begin
      updSG701.SetVariable('PESO_PERCENTUALE',PesoArea);
      updSG701.SetVariable('COD_AREA',Fsg701_Funzioni.FieldByName('COD_AREA').AsString);
      updSG701.SetVariable('DECORRENZA',Fsg701_Funzioni.FieldByName('DECORRENZA').AsDateTime);
      updSG701.Execute;
      Fsg701_Funzioni.RefreshRecord;
      if (PesoArea < 0) or (PesoArea > 100) then
        raise exception.create(A000MSG_S700_ERR_PESO_COMPRESO);
    end;
  end;
  if (Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat = 0)
  and (Fsg701_Funzioni.FieldByName('PESO_VARIABILE_ITEMS').AsString = 'N')
  and (   (Fsg701_Funzioni.FieldByName('ITEM_PERSONALIZZATI_MAX').AsInteger > 0)
       or (selSG700.RecordCount > 0)) then
  begin
    Fsg701_Funzioni.AfterPost:=nil;
    Fsg701_Funzioni.Edit;
    Fsg701_Funzioni.FieldByName('ITEM_TUTTI_VALUTABILI').AsString:='S';
    Fsg701_Funzioni.Post;
      if Assigned(AfterPostRecall) then
        AfterPostRecall;//implementata sul dtm per gestire l'interfaccia win
  end;
  //Aggiorno il range Min-Max
  Fsg701_Funzioni.AfterPost:=nil;
  Fsg701_Funzioni.Edit;
  if not Enabled
  or (Fsg701_Funzioni.FieldByName('PESO_PERC_MIN').AsFloat = Fsg701_Funzioni.FieldByName('PESO_PERC_MAX').AsFloat) then
  begin
    Fsg701_Funzioni.FieldByName('PESO_PERC_MIN').AsString:=Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsString;
    Fsg701_Funzioni.FieldByName('PESO_PERC_MAX').AsString:=Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsString;
  end
  else if selSG700.RecordCount > 0 then
  begin
    if (Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat < Fsg701_Funzioni.FieldByName('PESO_PERC_MIN').AsFloat) then
      Fsg701_Funzioni.FieldByName('PESO_PERC_MIN').AsFloat:=Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat
    else if (Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat > Fsg701_Funzioni.FieldByName('PESO_PERC_MAX').AsFloat) then
      Fsg701_Funzioni.FieldByName('PESO_PERC_MAX').AsFloat:=Fsg701_Funzioni.FieldByName('PESO_PERCENTUALE').AsFloat;
  end;
  Fsg701_Funzioni.Post;
  if Assigned(AfterPostRecall) then
    AfterPostRecall;//implementata sul dtm per gestire l'interfaccia win
  SessioneOracle.Commit;
end;

function TS700FAreeValutazioniMW.ControllaSchedeEsistenti:String;
begin
  Result:='';
  with selSG710 do
  begin
    Close;
    SetVariable('COD_AREA',selSG700.FieldByName('COD_AREA').AsString);
    SetVariable('DEC_INI',Fsg701_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Open;
    if FieldByName('N_REC_SCHEDE').AsInteger > 0 then
      Result:=(Format(A000MSG_S700_ERR_FMT_DATE_SUCC,[selSG700.FieldByName('COD_AREA').AsString + #13]));
  end;
end;

procedure TS700FAreeValutazioniMW.AreeCopiaDettaglio;
begin
  //Recupero l'elenco delle aree su cui si può riportare il dettaglio
  with selSG701a do
  begin
    Close;
    SetVariable('COD_AREA',Fsg701_Funzioni.FieldByName('COD_AREA').AsString);
    SetVariable('DECORRENZA',Fsg701_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    Open;
    if RecordCount = 0 then
      raise exception.Create(Format(A000MSG_S700_ERR_FMT_COPIA_DETT_AREE,[Fsg701_Funzioni.FieldByName('DECORRENZA').AsString]));
  end;
end;

procedure TS700FAreeValutazioniMW.CopiaDettaglio;
var CodArea:String;
    selSG700ReadOnly:Boolean;
begin
  with selSG700 do
  begin
    selSG700ReadOnly:=selSG700.ReadOnly;
    selSG700.ReadOnly:=False;
    //Salvo dettaglio da riportare
    DisableControls;
    cdsSG700.Close;
    cdsSG700.FieldDefs.Clear;
    cdsSG700.FieldDefs.Add('COD_VALUTAZIONE',ftString,5,False);
    cdsSG700.FieldDefs.Add('DESCRIZIONE',ftString,500,False);
    cdsSG700.FieldDefs.Add('PESO_PERCENTUALE',ftFloat,0,False);
    cdsSG700.FieldDefs.Add('DESCRIZIONI_PUNTEGGI',ftString,2000,False);
    cdsSG700.IndexDefs.Clear;
    cdsSG700.IndexDefs.Add('Indice',('COD_VALUTAZIONE'),[]);
    cdsSG700.IndexName:='Indice';
    cdsSG700.CreateDataSet;
    cdsSG700.LogChanges:=False;
    First;
    while not Eof do
    begin
      cdsSG700.Append;
      cdsSG700.FieldByName('COD_VALUTAZIONE').AsString:=FieldByName('COD_VALUTAZIONE').AsString;
      cdsSG700.FieldByName('DESCRIZIONE').AsString:=FieldByName('DESCRIZIONE').AsString;
      cdsSG700.FieldByName('PESO_PERCENTUALE').AsFloat:=FieldByName('PESO_PERCENTUALE').AsFloat;
      cdsSG700.FieldByName('DESCRIZIONI_PUNTEGGI').AsString:=FieldByName('DESCRIZIONI_PUNTEGGI').AsString;
      cdsSG700.Post;
      Next;
    end;
    //Per ogni area selezionata cancello il dettaglio e lo ripopolo (sfrutto gli automatismi del selSG700 compresa la registrazione del log)
    AreeSel:=AreeSel + ',';
    while Pos(',',AreeSel) > 0 do
    begin
      CodArea:=Copy(AreeSel,1,Pos(',',AreeSel) - 1);
      Close;
      SetVariable('COD_AREA',CodArea);
      Open;
      while not Eof do
        Delete;
      cdsSG700.First;
      while not cdsSG700.Eof do
      begin
        Append;
        FieldByName('COD_AREA').AsString:=CodArea;
        FieldByName('COD_VALUTAZIONE').AsString:=cdsSG700.FieldByName('COD_VALUTAZIONE').AsString;
        FieldByName('DESCRIZIONE').AsString:=cdsSG700.FieldByName('DESCRIZIONE').AsString;
        FieldByName('PESO_PERCENTUALE').AsFloat:=cdsSG700.FieldByName('PESO_PERCENTUALE').AsFloat;
        FieldByName('DESCRIZIONI_PUNTEGGI').AsString:=cdsSG700.FieldByName('DESCRIZIONI_PUNTEGGI').AsString;
        Post;
        cdsSG700.Next;
      end;
      SessioneOracle.ApplyUpdates([selSG700],True);
      AreeSel:=Copy(AreeSel,Pos(',',AreeSel) + 1);
    end;
    //Ricarico il dettaglio dell'area corrente
    Self.AfterScroll;
    EnableControls;
    selSG700.ReadOnly:=selSG700ReadOnly;
  end;
end;

end.

