unit A128UPianPrestazioniAggiuntiveMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, DB, Oracle, DBClient, Math, R005UDataModuleMW,
  A000UInterfaccia, A000UMessaggi, DatiBloccati, C180FunzioniGenerali, StrUtils;

type
  T128Dlg = procedure(msg,Chiave:String) of object;
  T128ClearKeys = procedure of object;
  T128AvanzamentoAcq = procedure(Matr:String;Riga:Integer) of object;

  TElencoDate = record
    Data:TDateTime;
    Colorata:Boolean;
  end;

  TMappa = record
    Pos:Integer;
    Lun:Integer;
  end;

  TA128FPianPrestazioniAggiuntiveMW = class(TR005FDataModuleMW)
    selT030: TOracleDataSet;
    Q330: TOracleDataSet;
    Q330CODICE: TStringField;
    Q330DESCRIZIONE: TStringField;
    Q330ORAINIZIO: TDateTimeField;
    Q330ORAFINE: TDateTimeField;
    Q330CONTROLLO_PT: TStringField;
    D330: TDataSource;
    selaT332: TOracleDataSet;
    Q430Contratto: TOracleDataSet;
    insT332: TOracleQuery;
    updT332: TOracleQuery;
    delT332: TOracleQuery;
    cdsParametri: TClientDataSet;
    cdsParametriTurno1: TStringField;
    cdsParametriTurno2: TStringField;
    dsrParametri: TDataSource;
    cdsParametriORAINIZIO_TURNO1: TStringField;
    cdsParametriORAFINE_TURNO1: TStringField;
    cdsParametriORAINIZIO_TURNO2: TStringField;
    cdsParametriORAFINE_TURNO2: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsParametriOrarioValidate(Sender: TField);
    procedure cdsParametriOrarioChange(Sender: TField);
    procedure cdsParametriOrarioSetText(Sender: TField; const Text: string);
    procedure cdsParametriCodiceTurnoValidate(Sender: TField);
    procedure cdsParametriCodiceTurnoSetText(Sender: TField; const Text: string);
    procedure cdsParametriCodiceTurnoChange(Sender: TField);
  private
    GiornoGriglia: TDateTime;
    DataGM: TDateTime;
    selDatiBloccati: TDatiBloccati;
  public
    selT332: TOracleDataSet;
    Filtro,Dipendente:string;
    //sConfermaInserimento:string;
    ProceduraChiamante,IMax:Integer;
    Turno1Value,Turno2Value,OraInizioTurno1,OraFineTurno1,OraInizioTurno2,OraFineTurno2:Variant;
    DataInizio,DataFine: TDateTime;
    ListaGiorniSel:TStringList;
    ElencoDate:array [1..31] of TElencoDate;
    Mappa:array [1..10] of TMappa;
    evtAvanzamentoAcq:T128AvanzamentoAcq;
    evtRichiesta:T128Dlg;
   //evtRichiestaInserimento:T128Dlg;
    evtClearKeys:T128ClearKeys;
    nNumRiga,nTotRighe:integer;
    FIn: TextFile;
    procedure AfterPost;
    procedure BeforeInsert;
    procedure BeforePost;
    procedure BeforeDelete;
    procedure NewRecord;
    procedure ValidaData;
    procedure ImpostaTesto(Sender: TField; const Text: String);
    procedure ValidaTurno(Sender: TField);
    procedure ValidaOrario(Sender: TField);
    procedure AzzeraOrario(Sender: TField);
    procedure AzzeraTurni(Sender: TField);
    procedure CercaContratto(Prog: Integer; DataRif: TDateTime);
    procedure RefreshSelT332;
    procedure CaricaElencoDate;
    procedure ImpostaFiltro(Testo: String);
    procedure ImpostaCampiLookup;
    function GetHint: String;
    procedure InserisciGestioneMensile;
    procedure CancellaGestioneMensile;
    procedure Controlli(Modo: String);
    procedure PulisciVariabili;
    procedure ControlloParametriFile;
    procedure ApriFile(NomeFile: String);
    procedure RecuperaTotaleRigheFile;
    procedure InserisciPrestAgg(DIniAcq,DFinAcq:TDateTime;OverrideValue:Boolean = False);
  end;

implementation

{$R *.dfm}

procedure TA128FPianPrestazioniAggiuntiveMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
  selT030.Open;
  Q330.Open;
  cdsParametri.CreateDataSet;
  ListaGiorniSel:=TStringList.Create;
  PulisciVariabili;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);//.Free;
  FreeAndNil(ListaGiorniSel);//.Free;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.AfterPost;
var RowID:String;
begin
  RowID:=selT332.RowID;
  selT332.Refresh;
  selT332.SearchRecord('ROWID',RowID,[srFromBeginning]);
  CaricaElencoDate;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(selT332.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(selT332.FieldByName('DATA').AsDateTime),'T332') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.BeforeInsert;
begin
  if SelAnagrafe.RecordCount = 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP)
  else
    GiornoGriglia:=selT332.FieldByName('DATA').AsDateTime;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.BeforePost;
var 
  Turno1Dalle, Turno1Alle, Turno2Dalle, Turno2Alle: Integer;
  GestionePerCodiceTurno,GestionePerFasciaOraria: Boolean;
begin
  ProceduraChiamante:=0;//BeforePost

  if selDatiBloccati.DatoBloccato(selT332.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(selT332.FieldByName('DATA').AsDateTime),'T332') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);

  selT332.FieldByName('TURNO1').AsString:=Trim(selT332.FieldByName('TURNO1').AsString);
  selT332.FieldByName('TURNO2').AsString:=Trim(selT332.FieldByName('TURNO2').AsString);

  GestionePerFasciaOraria:=(selT332.FieldByName('TURNO1').AsString = '') and 
                          (selT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '') and 
                          (selT332.FieldByName('ORAFINE_TURNO1').AsString <> '');
  GestionePerCodiceTurno:=(selT332.FieldByName('TURNO1').AsString <> '') and 
                          (selT332.FieldByName('ORAINIZIO_TURNO1').AsString = '') and 
                          (selT332.FieldByName('ORAFINE_TURNO1').AsString = '');
  
  // Turno 1
  // Se ho il codice turno nullo devo avere una gestione per fascia oraria
  if ((selT332.FieldByName('TURNO1').AsString = '') and 
     ((selT332.FieldByName('ORAINIZIO_TURNO1').AsString = '')
     or (selT332.FieldByName('ORAFINE_TURNO1').AsString = ''))) then
    raise Exception.Create(Format(A000MSG_A128_ERR_TURNO_NON_VALIDO, [1]));

  // Se ho una gestione per codice turno devo avere la fascia oraria nulla
  if (selT332.FieldByName('TURNO1').AsString <> '') and 
     ((selT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '') or 
     (selT332.FieldByName('ORAFINE_TURNO1').AsString <> '')) then
    raise Exception.Create(Format(A000MSG_A128_ERR_GESIONE_PER_TURNI, [1]));

  // Turno 2  ** facoltativo **
  if (selT332.FieldByName('TURNO2').AsString <> '') or 
     (selT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '') or 
     (selT332.FieldByName('ORAFINE_TURNO2').AsString <> '') then
  begin
    if GestionePerFasciaOraria then
    begin
      // Se ho il codice turno nullo devo avere una gestione per fascia oraria
      if ((selT332.FieldByName('TURNO2').AsString = '') and 
         ((selT332.FieldByName('ORAINIZIO_TURNO2').AsString = '')
         or (selT332.FieldByName('ORAFINE_TURNO2').AsString = ''))) then
        raise Exception.Create(Format(A000MSG_A128_ERR_TURNO_NON_VALIDO, [2]))  
    end
    else if GestionePerCodiceTurno then
    begin
      // Se ho una gestione per codice turno devo avere la fascia oraria nulla
      if (selT332.FieldByName('TURNO2').AsString <> '') and 
         ((selT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '') or 
         (selT332.FieldByName('ORAFINE_TURNO2').AsString <> '')) then
      raise Exception.Create(Format(A000MSG_A128_ERR_GESIONE_PER_TURNI, [2]))
    end; 
  end;
 
  // Codice turno ripeturo
  if GestionePerCodiceTurno then
  begin
    if (selT332.FieldByName('TURNO1').AsString = selT332.FieldByName('TURNO2').AsString) then
      raise Exception.Create(A000MSG_A128_ERR_TURNO_RIPETUTO);
  end;

  // Check intersezione periodi
  if GestionePerFasciaOraria then
  begin
    if (selT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '') and
    (selT332.FieldByName('ORAFINE_TURNO1').AsString <> '') and
    (selT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '') and 
    (selT332.FieldByName('ORAFINE_TURNO2').AsString <> '') then
    begin
      Turno1Dalle:=R180OreMinutiExt(selT332.FieldByName('ORAINIZIO_TURNO1').AsString);
      Turno1Alle:=R180OreMinutiExt(selT332.FieldByName('ORAFINE_TURNO1').AsString);   
      Turno2Dalle:=R180OreMinutiExt(selT332.FieldByName('ORAINIZIO_TURNO2').AsString);
      Turno2Alle:=R180OreMinutiExt(selT332.FieldByName('ORAFINE_TURNO2').AsString);
      if Turno1Dalle >= Turno1Alle then
          Turno1Alle:=Turno1Alle + 1440;
      if Turno2Dalle >= Turno2Alle then
          Turno2Alle:=Turno2Alle + 1440;
      if (Min(Turno1Alle,Turno2Alle) - Max(Turno1Dalle,Turno2Dalle)) > 0 then
        raise Exception.Create(A000MSG_A128_ERR_ORA_INTERSEZIONE);
    end;  
  end;

  if QueryPK1.EsisteChiave('T332_PIAN_ATT_AGGIUNTIVE',selT332.RowId,selT332.State,['PROGRESSIVO','DATA'],[selT332.FieldByName('Progressivo').AsString,selT332.FieldByName('Data').AsString]) then
    raise Exception.Create(A000MSG_A128_ERR_ESISTE_PIANIFICAZIONE);
  CercaContratto(SelAnagrafe.FieldByName('Progressivo').AsInteger,DataFine);
  if (Q430Contratto.FieldByName('PERCPT').AsFloat <> 100)
  and (   (VarToStr(Q330.Lookup('CODICE',selT332.FieldByName('TURNO1').AsString,'CONTROLLO_PT')) = 'S')
       or (VarToStr(Q330.Lookup('CODICE',selT332.FieldByName('TURNO2').AsString,'CONTROLLO_PT')) = 'S')) then
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_A128_DLG_TURNO_NO_PARTTIME,IntToStr(IMax) + 'ConfermaInserimento');
end;

procedure TA128FPianPrestazioniAggiuntiveMW.NewRecord;
begin
  selT332.FieldByName('DATA').AsDateTime:=Max(GiornoGriglia,DataInizio);
  selT332.FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ValidaData;
begin
  if (selT332.FieldByName('DATA').AsDateTime < DataInizio) or
     (selT332.FieldByName('DATA').AsDateTime > DataFine) then
    raise Exception.Create(A000MSG_A128_ERR_DATA_ESTERNA_MESE);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ImpostaTesto(Sender:TField;const Text:String);
begin
  Sender.AsString:=Trim(Copy(Text,1,5));
  if Sender.AsString = '.' then
    Sender.AsString:='';
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ValidaTurno(Sender: TField);
begin
  if Sender.AsString <> '' then
    if VarToStr(Q330.Lookup('CODICE',Sender.AsString,'CODICE')) = '' then
      raise Exception.Create(Format(A000MSG_A128_ERR_FMT_COD_NON_VALIDO,[Sender.DisplayLabel]));
end;

procedure TA128FPianPrestazioniAggiuntiveMW.AzzeraOrario(Sender: TField);
begin
  if Sender.Text <> '' then
  begin
    if selT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '' then
      selT332.FieldByName('ORAINIZIO_TURNO1').AsString:='';
    if selT332.FieldByName('ORAFINE_TURNO1').AsString <> '' then
      selT332.FieldByName('ORAFINE_TURNO1').AsString:='';
    if selT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '' then
      selT332.FieldByName('ORAINIZIO_TURNO2').AsString:='';
    if selT332.FieldByName('ORAFINE_TURNO2').AsString <> '' then
      selT332.FieldByName('ORAFINE_TURNO2').AsString:='';
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.AzzeraTurni(Sender: TField);
begin
  if Sender.Text <> '' then
  begin
    if selT332.FieldByName('TURNO1').AsString <> '' then
      selT332.FieldByName('TURNO1').AsString:='';
    if selT332.FieldByName('TURNO2').AsString <> '' then
      selT332.FieldByName('TURNO2').AsString:='';
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ValidaOrario(Sender: TField);
begin
  if (Trim(Sender.AsString) <> '') and (Trim(Sender.AsString) <> '.') then
  begin
    R180OraValidate(Sender.AsString);
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.CercaContratto(Prog:Integer;DataRif:TDateTime);
begin
  with Q430Contratto do
  begin
    Close;
    SetVariable('Progressivo',Prog);
    SetVariable('Data',DataRif);
    Open;
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.RefreshSelT332;
begin
  with selT332 do
  begin
    Close;
    SetVariable('DATADA',DataInizio);
    SetVariable('DATAA',DataFine);
    SetVariable('FILTRO',Filtro);
    Open;
  end;
  CaricaElencoDate;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.CaricaElencoDate;
var i:integer;
    Puntatore:TBookmark;
begin
  for i:=1 to 31 do
  begin
    ElencoDate[i].Data:=StrToDateTime('01/01/1900');
    ElencoDate[i].Colorata:=False;
  end;
  i:=1;
  with selT332 do
  begin
    Puntatore:=GetBookmark;
    try
	    First;
      ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
      inc(i);
      while not Eof do
      begin
        if ElencoDate[i - 1].Data <> FieldByName('DATA').AsDateTime then
        begin
          ElencoDate[i].Data:=FieldByName('DATA').AsDateTime;
          ElencoDate[i].Colorata:=not ElencoDate[i - 1].Colorata;
          inc(i);
        end;
        Next;
      end;
      GotoBookmark(Puntatore);
  	finally
      FreeBookmark(Puntatore);
	  end;
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.cdsParametriOrarioSetText(
  Sender: TField; const Text: string);
begin
  ImpostaTesto(Sender,Text);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.cdsParametriOrarioChange(Sender: TField);
begin
  if Sender.Text <> '' then
  begin
    if cdsParametri.FindField('Turno1').AsString <> '' then
      cdsParametri.FindField('Turno1').AsString:='';
    if cdsParametri.FindField('Turno2').AsString <> '' then
      cdsParametri.FindField('Turno2').AsString:='';
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.cdsParametriOrarioValidate(
  Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.cdsParametriCodiceTurnoChange(Sender: TField);
begin
  if Sender.Text <> '' then
  begin
    if cdsParametri.FindField('ORAINIZIO_TURNO1').AsString <> '' then
      cdsParametri.FindField('ORAINIZIO_TURNO1').AsString:='';
    if cdsParametri.FindField('ORAFINE_TURNO1').AsString <> '' then
      cdsParametri.FindField('ORAFINE_TURNO1').AsString:='';
    if cdsParametri.FindField('ORAINIZIO_TURNO2').AsString <> '' then
      cdsParametri.FindField('ORAINIZIO_TURNO2').AsString:='';
    if cdsParametri.FindField('ORAFINE_TURNO2').AsString <> '' then
      cdsParametri.FindField('ORAFINE_TURNO2').AsString:='';
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.cdsParametriCodiceTurnoSetText(
  Sender: TField; const Text: string);
begin
  ImpostaTesto(Sender,Text);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.cdsParametriCodiceTurnoValidate(
  Sender: TField);
begin
  ValidaTurno(Sender);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ImpostaFiltro(Testo:String);
begin
  Filtro:='';
  if (Testo <> '') and (Pos('ORDER BY',Testo) <> 1) then
    if Pos('ORDER BY',Testo) > 0 then
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Pos('ORDER BY', Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T332.DATA',[rfIgnoreCase,rfReplaceAll])
    else
      Filtro:=' AND ' + StringReplace(Copy(Testo,Pos('WHERE ',Testo) + 6,Length(Testo) - (Pos('WHERE ',Testo) + 6)),':DataLavoro','T332.DATA',[rfIgnoreCase,rfReplaceAll]);
  if Filtro = ' AND ' then
    Filtro:='';
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ImpostaCampiLookup;
begin
  selT332.FieldByName('D_MATRICOLA').FieldKind:=fkLookup;
  selT332.FieldByName('D_MATRICOLA').LookupDataSet:=SelAnagrafe;
  selT332.FieldByName('D_MATRICOLA').LookupKeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_MATRICOLA').LookupResultField:='MATRICOLA';
  selT332.FieldByName('D_MATRICOLA').KeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_BADGE').FieldKind:=fkLookup;
  selT332.FieldByName('D_BADGE').LookupDataSet:=SelAnagrafe;
  selT332.FieldByName('D_BADGE').LookupKeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_BADGE').LookupResultField:='T430BADGE';
  selT332.FieldByName('D_BADGE').KeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_NOMINATIVO').FieldKind:=fkLookup;
  selT332.FieldByName('D_NOMINATIVO').LookupDataSet:=SelAnagrafe;
  selT332.FieldByName('D_NOMINATIVO').LookupKeyFields:='PROGRESSIVO';
  selT332.FieldByName('D_NOMINATIVO').LookupResultField:='NOMINATIVO';
  selT332.FieldByName('D_NOMINATIVO').KeyFields:='PROGRESSIVO';
end;

function TA128FPianPrestazioniAggiuntiveMW.GetHint:String;
var DescT1,DescT2: String;
  function GetDescrizioneTurno(const CodTurno : String):String;
  begin
    Result:='';
    if Q330.Locate('CODICE',CodTurno,[loCaseInsensitive]) then
      Result:=Q330.FieldByName('DESCRIZIONE').AsString + ': ' +
        FormatDateTime('hh.mm',Q330.FieldByName('OraInizio').AsDateTime) + '-' +
        FormatDateTime('hh.mm',Q330.FieldByName('OraFine').AsDateTime);
  end;
  const
    PATTERN_ORARIO = 'Dalle %s alle %s';
begin
  Result:=selT332.FieldByName('D_NOMINATIVO').AsString;
  DescT1:=GetDescrizioneTurno(selT332.FieldByName('Turno1').AsString);
  if DescT1 <> '' then
    Result:=Result + #13#10 + selT332.FieldByName('Turno1').AsString + ': ' + DescT1
  else
  begin
    if (selT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '')
    and (selT332.FieldByName('ORAFINE_TURNO1').AsString <> '')
    then
      Result:=Result + #13#10 + Format(PATTERN_ORARIO, [selT332.FieldByName('ORAINIZIO_TURNO1').AsString, selT332.FieldByName('ORAFINE_TURNO1').AsString]);
  end;
  DescT2:=GetDescrizioneTurno(selT332.FieldByName('Turno2').AsString);
  if DescT2 <> '' then
    Result:=Result + #13#10 + selT332.FieldByName('Turno2').AsString + ': ' + DescT2
  else
  begin
    if (selT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '')
    and (selT332.FieldByName('ORAFINE_TURNO2').AsString <> '')
    then
      Result:=Result + #13#10 + Format(PATTERN_ORARIO, [selT332.FieldByName('ORAINIZIO_TURNO2').AsString, selT332.FieldByName('ORAFINE_TURNO2').AsString]);
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.InserisciGestioneMensile;
var i:Integer;
    DataRif:TDateTime;
  procedure SettaQuery(Data:TDateTime);
  begin
    (*Spostato nei controlli preliminari, dato che il part time viene estratto solo a fine mese
    if (Q430Contratto.FieldByName('PERCPT').AsFloat <> 100)
    and (   (VarToStr(Q330.Lookup('CODICE',Turno1Value,'CONTROLLO_PT')) = 'S')
         or (VarToStr(Q330.Lookup('CODICE',Turno2Value,'CONTROLLO_PT')) = 'S')) then
    begin
      if sConfermaInserimento = '' then
        if Assigned(evtRichiestaInserimento) then
          evtRichiestaInserimento('Confermi la pianificazione di un turno incompatibile con dipendente part-time?',IntToStr(IMax) + 'ConfermaInserimento');
      if sConfermaInserimento = 'N' then
        exit;
    end;*)
    insT332.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    insT332.SetVariable('DATA',Data);
    insT332.SetVariable('TURNO1',VarToStr(Turno1Value));
    insT332.SetVariable('ORAINIZIO_TURNO1',VarToStr(OraInizioTurno1));
    insT332.SetVariable('ORAFINE_TURNO1',VarToStr(OraFineTurno1));
    insT332.SetVariable('TURNO2',VarToStr(Turno2Value));
    insT332.SetVariable('ORAINIZIO_TURNO2',VarToStr(OraInizioTurno2));
    insT332.SetVariable('ORAFINE_TURNO2',VarToStr(OraFineTurno2));
    try
      insT332.Execute;
      RegistraLog.SettaProprieta('I','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(insT332.GetVariable('PROGRESSIVO')));
      RegistraLog.InserisciDato('DATA','',VarToStr(insT332.GetVariable('DATA')));
      if VarToStr(Turno1Value) <> '' then
        RegistraLog.InserisciDato('TURNO1','',VarToStr(insT332.GetVariable('TURNO1')));
      if VarToStr(OraInizioTurno1) <> '' then
        RegistraLog.InserisciDato('ORAINIZIO_TURNO1','',VarToStr(insT332.GetVariable('ORAINIZIO_TURNO1')));
      if VarToStr(OraFineTurno1) <> '' then
        RegistraLog.InserisciDato('ORAFINE_TURNO1','',VarToStr(insT332.GetVariable('ORAFINE_TURNO1')));
      if VarToStr(Turno2Value) <> '' then
        RegistraLog.InserisciDato('TURNO2','',VarToStr(insT332.GetVariable('TURNO2')));
      if VarToStr(OraInizioTurno1) <> '' then
        RegistraLog.InserisciDato('ORAINIZIO_TURNO2','',VarToStr(insT332.GetVariable('ORAINIZIO_TURNO2')));
      if VarToStr(OraFineTurno2) <> '' then
        RegistraLog.InserisciDato('ORAFINE_TURNO2','',VarToStr(insT332.GetVariable('ORAFINE_TURNO2')));
      RegistraLog.RegistraOperazione;
      SessioneOracle.Commit;
    except
    end;
  end;
begin
  ProceduraChiamante:=1;//InserisciGestioneMensile
  if ListaGiorniSel.Count > 0 then
    DataGM:=StrToDate(Copy(ListaGiorniSel[0],5,10));
  Controlli('I');
  if IMax = 0 then
    if (Q430Contratto.FieldByName('PERCPT').AsFloat <> 100)
    and (   (VarToStr(Q330.Lookup('CODICE',Turno1Value,'CONTROLLO_PT')) = 'S')
         or (VarToStr(Q330.Lookup('CODICE',Turno2Value,'CONTROLLO_PT')) = 'S')) then
      if Assigned(evtRichiesta) then
        evtRichiesta(A000MSG_A128_DLG_TURNO_NO_PARTTIME,IntToStr(IMax) + 'ConfermaInserimento');
  for i:=0 to ListaGiorniSel.Count - 1 do
  begin
    if i < IMax then
      Continue;
    IMax:=i;
    DataRif:=StrToDate(Copy(ListaGiorniSel[i],5,10));
    if QueryPK1.EsisteChiave('T332_PIAN_ATT_AGGIUNTIVE',selT332.RowId,selT332.State,['PROGRESSIVO','DATA'],[SelAnagrafe.FieldByName('Progressivo').AsString,DateToStr(DataRif)]) then
    begin
      PulisciVariabili;
      raise Exception.Create(A000MSG_A128_ERR_ESISTE_PIANIFICAZIONE);
    end;
    SettaQuery(DataRif);
    //sConfermaInserimento:='';
  end;
  PulisciVariabili;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.CancellaGestioneMensile;
var i:Integer;
    Where:String;
    Aggiorna:Boolean;
begin
  ProceduraChiamante:=2;//CancellaGestioneMensile
  if ListaGiorniSel.Count > 0 then
    DataGM:=StrToDate(Copy(ListaGiorniSel[0],5,10));
  Controlli('E');
  if IMax = 0 then
    if Assigned(evtRichiesta) then
      evtRichiesta(A000MSG_DLG_CANCELLAZIONE_MASSIVA,IntToStr(IMax) + 'ConfermaCancellazione');
  Where:='';
  if (VarToStr(Turno1Value) <> '') or (VarToStr(Turno2Value) <> '') then
  begin
    if VarToStr(Turno1Value) <> '' then
      Where:=' AND TURNO1 = ''' + VarToStr(Turno1Value) + '''';
    if VarToStr(Turno2Value) <> '' then
      Where:=Where + ' AND TURNO2 = ''' + VarToStr(Turno2Value)  + '''';
  end
  else if (VarToStr(OraInizioTurno1) <> '') or (VarToStr(OraFineTurno1) <> '') or 
          (VarToStr(OraInizioTurno2) <> '') or (VarToStr(OraFineTurno2) <> '') then
  begin
    if VarToStr(OraInizioTurno1) <> '' then
      Where:=' AND ORAINIZIO_TURNO1 = ''' + VarToStr(OraInizioTurno1) + '''';
    if VarToStr(OraFineTurno1) <> '' then
      Where:=Where + ' AND ORAFINE_TURNO1 = ''' + VarToStr(OraFineTurno1)  + '''';
    if VarToStr(OraInizioTurno2) <> '' then
      Where:=Where + ' AND ORAINIZIO_TURNO2 = ''' + VarToStr(OraInizioTurno2) + '''';
    if VarToStr(OraFineTurno2) <> '' then
      Where:=Where + ' AND ORAFINE_TURNO2 = ''' + VarToStr(OraFineTurno2)  + '''';
  end;
       
  Aggiorna:=False;
  for i:=0 to ListaGiorniSel.Count - 1 do
  begin
    if i < IMax then
      Continue;
    IMax:=i;
    delT332.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsString);
    delT332.SetVariable('DATA',StrToDate(Copy(ListaGiorniSel[i],5,10)));
    delT332.SetVariable('WHERE',Where);
    delT332.Execute;
    if delT332.RowsProcessed > 0 then
    begin
      RegistraLog.SettaProprieta('C','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
      RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(delT332.GetVariable('Progressivo')));
      RegistraLog.InserisciDato('DATA','',VarToStr(delT332.GetVariable('Data')));
      if (VarToStr(Turno1Value) <> '') or (VarToStr(Turno2Value) <> '') then
      begin
        if VarToStr(Turno1Value) <> '' then
          RegistraLog.InserisciDato('TURNO1','',VarToStr(Turno1Value));
        if VarToStr(Turno2Value) <> '' then
          RegistraLog.InserisciDato('TURNO2','',VarToStr(Turno2Value));
      end
      else if (VarToStr(OraInizioTurno1) <> '') or (VarToStr(OraFineTurno1) <> '') or 
              (VarToStr(OraInizioTurno2) <> '') or (VarToStr(OraFineTurno2) <> '') then
      begin
        if VarToStr(OraInizioTurno1) <> '' then
          RegistraLog.InserisciDato('ORAINIZIO_TURNO1','',VarToStr(OraInizioTurno1));
        if VarToStr(OraFineTurno1) <> '' then
          RegistraLog.InserisciDato('ORAFINE_TURNO1','',VarToStr(OraFineTurno1));
        if VarToStr(OraInizioTurno2) <> '' then
          RegistraLog.InserisciDato('ORAINIZIO_TURNO2','',VarToStr(OraInizioTurno2));
        if VarToStr(OraFineTurno2) <> '' then
          RegistraLog.InserisciDato('ORAFINE_TURNO2','',VarToStr(OraFineTurno2));
      end;     
      RegistraLog.RegistraOperazione;
      Aggiorna:=True;
    end;
  end;
  if Aggiorna then
  begin
    SessioneOracle.Commit;
    RefreshSelT332;
  end;
  PulisciVariabili;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.Controlli(Modo:String);
var 
   GestionePerCodiceTurno1,GestionePerFasciaOrariaTurno1,GestionePerCodiceTurno2,GestionePerFasciaOrariaTurno2:Boolean;
   Turno1Dalle,Turno1Alle,Turno2Dalle,Turno2Alle:Integer; 
begin
  if Trim(Dipendente) = '' then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  if ListaGiorniSel.Count <= 0 then
    raise Exception.Create(A000MSG_ERR_NO_LISTA_GIORNI);
  if selDatiBloccati.DatoBloccato(SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataGM),'T332') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);

  if Modo = 'I' then
  begin

    GestionePerCodiceTurno1:=(VarToStr(Turno1Value) <> '');
    GestionePerFasciaOrariaTurno1:=(VarToStr(OraInizioTurno1) <> '') and
                                   (VarToStr(OraFineTurno1) <> '');

    GestionePerCodiceTurno2:=(VarToStr(Turno2Value) <> '');
    GestionePerFasciaOrariaTurno2:=(VarToStr(OraInizioTurno2) <> '') and
                                   (VarToStr(OraFineTurno2) <> '');

    if GestionePerFasciaOrariaTurno1 then
    begin
      R180OraValidate(VarToStr(OraInizioTurno1));
      R180OraValidate(VarToStr(OraFineTurno1));
    end;
    if GestionePerFasciaOrariaTurno2 then
    begin
      R180OraValidate(VarToStr(OraInizioTurno2));
      R180OraValidate(VarToStr(OraFineTurno2));
    end;

    // Il turno uno non è valorizzato
    if not(GestionePerCodiceTurno1) and not(GestionePerFasciaOrariaTurno1) then
      raise Exception.Create(A000MSG_A128_ERR_NO_TURNO_1)
    // I due turni corrispondono
    else if GestionePerCodiceTurno1 and GestionePerCodiceTurno2 and (Turno1Value = Turno2Value) then
      raise Exception.Create(A000MSG_A128_ERR_TURNO_RIPETUTO)
    else if GestionePerFasciaOrariaTurno1 and GestionePerFasciaOrariaTurno2 then
    begin
        Turno1Dalle:=R180OreMinutiExt(VarToStr(OraInizioTurno1));
        Turno1Alle:=R180OreMinutiExt(VarToStr(OraFineTurno1));   
        Turno2Dalle:=R180OreMinutiExt(VarToStr(OraInizioTurno2));
        Turno2Alle:=R180OreMinutiExt(VarToStr(OraFineTurno2));
        if Turno1Dalle >= Turno1Alle then
          Turno1Alle:=Turno1Alle + 1440;
        if Turno2Dalle >= Turno2Alle then
          Turno2Alle:=Turno2Alle + 1440;
        if (Min(Turno1Alle,Turno2Alle) - Max(Turno1Dalle,Turno2Dalle)) > 0 then
          raise Exception.Create(A000MSG_A128_ERR_ORA_INTERSEZIONE)
    end;
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.PulisciVariabili;
begin
  IMax:=0;
  if Assigned(evtClearKeys) then
    evtClearKeys;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ControlloParametriFile;
var c, j: Integer;
begin
  // Controllo eventuali posizioni non consecutive
  j:=-1;
  for c:=1 to 10 do
  begin
    if Mappa[c].Pos <> 0 then
    begin
      if j = -1 then
        j:=Mappa[c].Pos;
      if (Mappa[c].Pos <> j) then
          raise Exception.Create(Format(A000MSG_A128_ERR_FMT_POSIZIONE_ERRATA,[IntToStr(c)]));
      j:=Mappa[c].Pos + Mappa[c].Lun;
    end;
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.ApriFile(NomeFile:String);
begin
  try
    AssignFile(FIn, NomeFile);
    Reset(FIn);
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_APRI_FILE,[NomeFile]));
  end;
end;

procedure TA128FPianPrestazioniAggiuntiveMW.RecuperaTotaleRigheFile;
var sRigaIn: String;
begin
  nTotRighe:=0;
  while not Eof(FIn) do
  begin
    Readln(FIn,sRigaIn);
    nTotRighe:=nTotRighe + 1;
  end;
  CloseFile(FIn);
end;

procedure TA128FPianPrestazioniAggiuntiveMW.InserisciPrestAgg(DIniAcq,DFinAcq:TDateTime;OverrideValue:Boolean = False);
type 
  TTipoImportazione = (NON_PRESENTE, PER_CODICE_TURNO, PER_FASCIA_ORARIA);
var
  sRigaIn,sMatricola,sGiorno,sMese,sAnno,sTurno1,sInizioTurno1,sFineTurno1,sTurno2,sInizioTurno2,sFineTurno2: String;
  dDataTurno:TDateTime;
  nProgressivo:integer;
  TipoImportazioneTurno1,TipoImportazioneTurno2:TTipoImportazione;
  Turno1Dalle,Turno1Alle,Turno2Dalle,Turno2Alle: Integer;
begin
  nNumRiga:=nNumRiga + 1;
  Readln(FIn,sRigaIn);
  if sRigaIn <> '' then
  begin
    //Matricola: testo che non sia nulla
    sMatricola:=Trim(Copy(sRigaIn, Mappa[1].Pos, Mappa[1].Lun));
    if sMatricola = '' then
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_NO_MATRICOLA,[inttostr(nNumRiga),sRigaIn]));
      exit;
    end;
    if Assigned(evtAvanzamentoAcq) then
      evtAvanzamentoAcq(sMatricola,nNumRiga);

    //Giorno
    sGiorno:=Trim(Copy(sRigaIn, Mappa[2].Pos, Mappa[2].Lun));
    //Mese
    sMese:=Trim(Copy(sRigaIn, Mappa[3].Pos, Mappa[3].Lun));
    //Anno
    sAnno:=Trim(Copy(sRigaIn, Mappa[4].Pos, Mappa[4].Lun));
    if Mappa[4].Lun = 2 then
      sAnno:='20'+sAnno;
    if (sGiorno <> '') and (sMese <> '') and (sAnno <> '') then
    begin
      try
        dDataTurno:=EncodeDate(strtoint(sAnno),strtoint(sMese),strtoint(sGiorno));
      except
        //Si tratta di anomalia e la aggiungo alle liste delle anomalie
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_NO_FMT_DATA,[inttostr(nNumRiga),sRigaIn]));
        exit;
      end;
    end
    else
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DATA_INCOMPLETA,[inttostr(nNumRiga),sRigaIn]));
      exit;
    end;
    if (dDataTurno < DIniAcq) or (dDataTurno > DFinAcq) then
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DATA_ESTERNA,[inttostr(nNumRiga),sRigaIn,FormatDateTime('dd/mm/yyyy',dDataTurno)]));
      exit;
    end;
    
    //Turno 1 **non facoltativo, deve sempre comparire**
    sTurno1:=Trim(Copy(sRigaIn, Mappa[5].Pos, Mappa[5].Lun));
    sInizioTurno1:=Trim(Copy(sRigaIn, Mappa[7].Pos, Mappa[7].Lun));
    sFineTurno1:=Trim(Copy(sRigaIn, Mappa[8].Pos, Mappa[8].Lun));

    TipoImportazioneTurno1:=NON_PRESENTE;
    
    // Verifico il tipo di importazione che si sta tentando di fare
    if (sTurno1 <> '') and (sInizioTurno1 = '') and (sFineTurno1 = '' ) then
      TipoImportazioneTurno1:=PER_CODICE_TURNO
    else if (sTurno1 = '') and (sInizioTurno1 <> '') and (sFineTurno1 <> '' ) then
      TipoImportazioneTurno1:=PER_FASCIA_ORARIA;
    if sTurno1 = '' then
    begin
      // Controllo se la fascia oraria è correttamente valorizzata
      if (sInizioTurno1 = '') or (sFineTurno1 = '') then
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_NO_TURNO,[inttostr(nNumRiga),sRigaIn]));
        exit;
      end
      else
      begin
        // Controllo se l'orario di inizio turno importato è valido
        try
          StrToTime(sInizioTurno1);
        except
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_ORARIO_NON_VALIDO,[inttostr(nNumRiga),sRigaIn,sInizioTurno1, 1]));
          Exit;
        end;
        // Controllo se l'orario di fine turno importato è valido
        try
          StrToTime(sFineTurno1);
        except
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_ORARIO_NON_VALIDO,[inttostr(nNumRiga),sRigaIn,sFineTurno1, 1]));
          Exit;
        end;
      end;
    end
    else
    begin
      // Controllo se il codice importato esiste
      if not Q330.SearchRecord('CODICE',sTurno1,[srFromBeginning]) then
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_INESISTENTE,[inttostr(nNumRiga),sRigaIn,sTurno1]));
        exit;
      end;
      // Controllo se si sta tentando di importare sia un codice turno che una fascia oraria
      if (sInizioTurno1 <> '') or (sFineTurno1 <> '') then
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_ORARIO,[inttostr(nNumRiga),sRigaIn]));
        Exit;
      end;
    end;

    //Turno 2 **facoltativo**
    sTurno2:=Trim(Copy(sRigaIn, Mappa[6].Pos, Mappa[6].Lun));
    sInizioTurno2:=Trim(Copy(sRigaIn, Mappa[9].Pos, Mappa[9].Lun));
    sFineTurno2:=Trim(Copy(sRigaIn, Mappa[10].Pos, Mappa[10].Lun));

    TipoImportazioneTurno2:=NON_PRESENTE;
    
    // Controllo se il secondo turno è stato censito perché può essere facoltativo
    if (sTurno2 <> '') or (sInizioTurno2 <> '') or (sFineTurno2 <> '') then
    begin
      // Verifico il tipo di importazione che si sta tentando di fare
      if (sTurno2 <> '') and (sInizioTurno2 = '') and (sFineTurno2 = '' ) then
        TipoImportazioneTurno2:=PER_CODICE_TURNO
      else if (sTurno2 = '') and (sInizioTurno2 <> '') and (sFineTurno2 <> '' ) then
        TipoImportazioneTurno2:=PER_FASCIA_ORARIA;
      // Se sto tentando di importare un codice turno per il turno uno e una fascia oraria per il turno due vengo bloccato
      if (TipoImportazioneTurno1 <> NON_PRESENTE) and 
         (TipoImportazioneTurno1 <> TipoImportazioneTurno2) then
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_ORARIO,[inttostr(nNumRiga),sRigaIn,sInizioTurno2]));
        Exit;
      end;
      if sTurno2 = '' then
      begin
        // Controllo se la fascia oraria è correttamente valorizzata
        if (sInizioTurno2 <> '') and (sFineTurno2 <> '') then
        begin
          // Controllo se l'orario di inizio turno importato è valido
          try
            StrToTime(sInizioTurno2);
          except
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_ORARIO_NON_VALIDO,[inttostr(nNumRiga),sRigaIn,sInizioTurno2, 2]));
            Exit;
          end;
          // Controllo se l'orario di fine turno importato è valido
          try
            StrToTime(sFineTurno2);
          except
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_ORARIO_NON_VALIDO,[inttostr(nNumRiga),sRigaIn,sFineTurno2, 2]));
            Exit;
          end;
        end
        // Controllo se uno dei due valori è malformato
        else if (sInizioTurno2 <> '') or (sFineTurno2 <> '') then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_NO_ORARIO,[inttostr(nNumRiga),sRigaIn]));
          Exit;
        end;
        // Non ho anomalie in quanto il turno2 è facoltativo
      end
      else
      begin
        // Controllo se il codice importato esiste
        if not Q330.SearchRecord('CODICE',sTurno2,[srFromBeginning]) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_INESISTENTE,[inttostr(nNumRiga),sRigaIn,sTurno2]));
          exit;
        end;
        // Controllo se si sta tentando di importare sia un codice turno che una fascia oraria
        if (sInizioTurno2 <> '') or (sFineTurno2 <> '') then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_ORARIO,[inttostr(nNumRiga),sRigaIn]));
          Exit;
        end;
      end;    
    end;

    // Check intersezione periodi
    if (TipoImportazioneTurno1 = PER_FASCIA_ORARIA) and 
       (TipoImportazioneTurno2 = PER_FASCIA_ORARIA) then
    begin
      Turno1Dalle:=R180OreMinutiExt(sInizioTurno1);
      Turno1Alle:=R180OreMinutiExt(sFineTurno1);   
      Turno2Dalle:=R180OreMinutiExt(sInizioTurno2);
      Turno2Alle:=R180OreMinutiExt(sFineTurno2);
      if Turno1Dalle >= Turno1Alle then
          Turno1Alle:=Turno1Alle + 1440;
      if Turno2Dalle >= Turno2Alle then
          Turno2Alle:=Turno2Alle + 1440;
      if (Min(Turno1Alle,Turno2Alle) - Max(Turno1Dalle,Turno2Dalle)) > 0 then
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_ORA_INTERSEZIONE,[inttostr(nNumRiga),sRigaIn]));
        Exit;
      end;
    end;
    
    //Leggo il progressivo associato alla matricola
    if selT030.SearchRecord('MATRICOLA',sMatricola,[srFromBeginning]) then
    begin
      nProgressivo:=selT030.FieldByName('PROGRESSIVO').asInteger;
      //Verifico se controllare incompatibilità con part-time.
      if Q330.FieldByName('CONTROLLO_PT').AsString = 'S' then
      begin
        CercaContratto(nProgressivo,dDataTurno);
        if Q430Contratto.FieldByName('PERCPT').AsFloat <> 100 then
          //Si tratta di anomalia non bloccante la aggiungo alla lista delle anomalie, ma viene comunque inserito il turno
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DIP_PARTTIME,[inttostr(nNumRiga),sRigaIn,sMatricola]),'',nProgressivo);
      end;
    end
    else
    begin
      //Si tratta di anomalia e la aggiungo alle liste delle anomalie
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_MATR_INESISTENTE,[inttostr(nNumRiga),sRigaIn,sMatricola]));
      exit;
    end;

    selaT332.Close;
    selaT332.SetVariable('DATA',dDataTurno);
    selaT332.SetVariable('PROGRESSIVO',nProgressivo);
    selaT332.Open;

    if not(selaT332.RecNo = 0) then
    begin
      (* 
       * Se il record esiste già si possono solo aggiornare 
       * i campi rispettando l'alternativa tra codice turno o fascia 
       * oraria inoltre si possono solo importare valori differenti 
       * da quelli censiti a DB, il turno uno deve sempre esserci
       *)
      if not(OverrideValue) then
      begin
        // Da vecchia logica: Se sto tentando di importare lo stesso turno 1 già censito a DB
        if (selaT332.FieldByName('TURNO1').AsString <> '') and 
           (selaT332.FieldByName('TURNO1').AsString = sTurno1) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_PIANIFICATO,[inttostr(nNumRiga),sRigaIn,sMatricola,sTurno1,FormatDateTime('dd/mm/yyyy',dDataTurno)]),'',nProgressivo);
          Exit;
        end
        // Turno 1 censito a DB e l'utente tenta di importare una fascia oraria
        else if (selaT332.FieldByName('TURNO1').AsString <> '') and 
                (TipoImportazioneTurno1 = PER_FASCIA_ORARIA) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DB_TURNO_NON_NULLO,[inttostr(nNumRiga),sRigaIn]));
          Exit;
        end
        // Fascia oraria censita a DB e l'utente tenta di importare un codice turno 1
        else if ((selaT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '') or
                (selaT332.FieldByName('ORAFINE_TURNO1').AsString <> '')) and 
                (TipoImportazioneTurno1 = PER_CODICE_TURNO) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DB_ORARIO_NON_NULLO,[inttostr(nNumRiga),sRigaIn]));
          Exit;
        end
        // Da vecchia logica: Se sto tentando di importare lo stesso turno 2 già censito a DB
        else if (selaT332.FieldByName('TURNO2').AsString <> '') and 
                (selaT332.FieldByName('TURNO2').AsString = sTurno2) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_PIANIFICATO,[inttostr(nNumRiga),sRigaIn,sMatricola,sTurno2,FormatDateTime('dd/mm/yyyy',dDataTurno)]),'',nProgressivo);
          Exit;
        end
        // Turno 2 censito a DB e l'utente tenta di importare una fascia oraria
        else if (selaT332.FieldByName('TURNO2').AsString <> '') and 
                (TipoImportazioneTurno2 = PER_FASCIA_ORARIA) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DB_TURNO_NON_NULLO,[inttostr(nNumRiga),sRigaIn]));
          Exit;
        end
        // Fascia oraria censita a DB e l'utente tenta di importare un codice turno 2
        else if ((selaT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '') or
                (selaT332.FieldByName('ORAFINE_TURNO2').AsString <> '')) and
                (TipoImportazioneTurno2 = PER_CODICE_TURNO) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_DB_ORARIO_NON_NULLO,[inttostr(nNumRiga),sRigaIn]));
          Exit;
        end
        // Da vecchia logica: se ho già due turni censiti vado in anomalia
        else if ((selaT332.FieldByName('TURNO1').AsString <> '') or 
                ((selaT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '') and (selaT332.FieldByName('ORAFINE_TURNO1').AsString <> ''))) and 
                ((selaT332.FieldByName('TURNO2').AsString <> '') or 
                ((selaT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '') and (selaT332.FieldByName('ORAFINE_TURNO2').AsString <> ''))) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TROPPI_TURNI,[inttostr(nNumRiga),sRigaIn,sMatricola,FormatDateTime('dd/mm/yyyy',dDataTurno)]),'',nProgressivo);
          Exit;
        end
        // Se sto cercando di importare la stessa fascia oraria già censita a DB sul turno 1
        else if ((selaT332.FieldByName('ORAINIZIO_TURNO1').AsString = sInizioTurno1) and
                (selaT332.FieldByName('ORAFINE_TURNO1').AsString = sFineTurno1) and
                (TipoImportazioneTurno1 = PER_FASCIA_ORARIA)) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_PIANIFICATO,[inttostr(nNumRiga),sRigaIn,sMatricola,sTurno1,FormatDateTime('dd/mm/yyyy',dDataTurno)]),'',nProgressivo);
          Exit;
        end
        // Se sto cercando di importare la stessa fascia oraria già censita a DB sul turno 2
        else if ((selaT332.FieldByName('ORAINIZIO_TURNO2').AsString = sInizioTurno2) and
                (selaT332.FieldByName('ORAFINE_TURNO2').AsString = sFineTurno2) and
                (TipoImportazioneTurno2 = PER_FASCIA_ORARIA)) then
        begin
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_TURNO_PIANIFICATO,[inttostr(nNumRiga),sRigaIn,sMatricola,sTurno2,FormatDateTime('dd/mm/yyyy',dDataTurno)]),'',nProgressivo);
          Exit;
        end
        // Se la fascia oraria importata si interseca con quella censita a db
        else if TipoImportazioneTurno1 = PER_FASCIA_ORARIA then
        begin
          if (selaT332.FieldByName('ORAINIZIO_TURNO2').AsString <> '') and 
             (selaT332.FieldByName('ORAFINE_TURNO2').AsString <> '') then
          begin
            Turno1Dalle:=R180OreMinutiExt(sInizioTurno1);
            Turno1Alle:=R180OreMinutiExt(sFineTurno1);   
            Turno2Dalle:=R180OreMinutiExt(selaT332.FieldByName('ORAINIZIO_TURNO2').AsString);
            Turno2Alle:=R180OreMinutiExt(selaT332.FieldByName('ORAFINE_TURNO2').AsString);
            if Turno1Dalle >= Turno1Alle then
              Turno1Alle:=Turno1Alle + 1440;
            if Turno2Dalle >= Turno2Alle then
                Turno2Alle:=Turno2Alle + 1440;
            if (Min(Turno1Alle,Turno2Alle) - Max(Turno1Dalle,Turno2Dalle)) > 0 then
            begin
              RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_ORA_INTERSEZIONE,[inttostr(nNumRiga),sRigaIn]));
              Exit;
            end;
          end;
        end
        // Se la fascia oraria importata si interseca con quella censita a db
        else if TipoImportazioneTurno2 = PER_FASCIA_ORARIA then
        begin
          if (selaT332.FieldByName('ORAINIZIO_TURNO1').AsString <> '') and (selaT332.FieldByName('ORAFINE_TURNO1').AsString <> '') then
          begin
            Turno1Dalle:=R180OreMinutiExt(selaT332.FieldByName('ORAINIZIO_TURNO1').AsString);
            Turno1Alle:=R180OreMinutiExt(selaT332.FieldByName('ORAFINE_TURNO1').AsString);   
            Turno2Dalle:=R180OreMinutiExt(sInizioTurno2);
            Turno2Alle:=R180OreMinutiExt(sFineTurno2);
            if Turno1Dalle >= Turno1Alle then
                Turno1Alle:=Turno1Alle + 1440;
            if Turno2Dalle >= Turno2Alle then
                Turno2Alle:=Turno2Alle + 1440;
            if (Min(Turno1Alle,Turno2Alle) - Max(Turno1Dalle,Turno2Dalle)) > 0 then
            begin
              RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A128_ERR_FMT_ACQ_ORA_INTERSEZIONE,[inttostr(nNumRiga),sRigaIn]));
              Exit;
            end;
          end;
        end;
      end; 
    end;

    // Da vecchia logica: se il dato è bloccato esco
    if selDatiBloccati.DatoBloccato(nProgressivo,R180InizioMese(dDataTurno),'T332') then
    begin
      Exit;
    end;

    // Se non esiste già un record sul db
    if selaT332.RecNo = 0 then
    begin
      // Inserimento del nuovo record
      insT332.SetVariable('PROGRESSIVO',nProgressivo);
      insT332.SetVariable('DATA',dDataTurno);
      insT332.SetVariable('TURNO1',sTurno1);
      insT332.SetVariable('ORAINIZIO_TURNO1',sInizioTurno1);
      insT332.SetVariable('ORAFINE_TURNO1',sFineTurno1);
      insT332.SetVariable('TURNO2',sTurno2);
      insT332.SetVariable('ORAINIZIO_TURNO2',sInizioTurno2);
      insT332.SetVariable('ORAFINE_TURNO2',sFineTurno2);
      try
        insT332.Execute;
        RegistraLog.SettaProprieta('I','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO','',VarToStr(insT332.GetVariable('PROGRESSIVO')));
        RegistraLog.InserisciDato('DATA','',VarToStr(insT332.GetVariable('DATA')));
        RegistraLog.InserisciDato('TURNO1','',VarToStr(insT332.GetVariable('TURNO1')));
        RegistraLog.InserisciDato('ORAINIZIO_TURNO1','',VarToStr(insT332.GetVariable('ORAINIZIO_TURNO1')));
        RegistraLog.InserisciDato('ORAFINE_TURNO1','',VarToStr(insT332.GetVariable('ORAFINE_TURNO1')));
        RegistraLog.InserisciDato('TURNO2','',VarToStr(insT332.GetVariable('TURNO2')));
        RegistraLog.InserisciDato('ORAINIZIO_TURNO2','',VarToStr(insT332.GetVariable('ORAINIZIO_TURNO2')));
        RegistraLog.InserisciDato('ORAFINE_TURNO2','',VarToStr(insT332.GetVariable('ORAFINE_TURNO2')));
        RegistraLog.RegistraOperazione;
        SessioneOracle.Commit;
      except
      end;
    end
    else
    begin
      // Aggiornamento del vecchio record
      updT332.SetVariable('PROGRESSIVO',nProgressivo);
      updT332.SetVariable('DATA',dDataTurno);
      updT332.SetVariable('TURNO1',sTurno1);
      updT332.SetVariable('ORAINIZIO_TURNO1',sInizioTurno1);
      updT332.SetVariable('ORAFINE_TURNO1',sFineTurno1);
      updT332.SetVariable('TURNO2',sTurno2);
      updT332.SetVariable('ORAINIZIO_TURNO2',sInizioTurno2);
      updT332.SetVariable('ORAFINE_TURNO2',sFineTurno2);
      try
        updT332.Execute;
        RegistraLog.SettaProprieta('M','T332_PIAN_ATT_AGGIUNTIVE',NomeOwner,nil,True);
        RegistraLog.InserisciDato('PROGRESSIVO',selaT332.FieldByName('PROGRESSIVO').AsString,VarToStr(updT332.GetVariable('PROGRESSIVO')));
        RegistraLog.InserisciDato('DATA',selaT332.FieldByName('DATA').AsString,VarToStr(updT332.GetVariable('DATA')));
        RegistraLog.InserisciDato('TURNO1',selaT332.FieldByName('TURNO1').AsString,VarToStr(updT332.GetVariable('TURNO1')));
        RegistraLog.InserisciDato('ORAINIZIO_TURNO1',selaT332.FieldByName('ORAINIZIO_TURNO1').AsString,VarToStr(updT332.GetVariable('ORAINIZIO_TURNO1')));
        RegistraLog.InserisciDato('ORAFINE_TURNO1',selaT332.FieldByName('ORAFINE_TURNO1').AsString,VarToStr(updT332.GetVariable('ORAFINE_TURNO1')));
        RegistraLog.InserisciDato('TURNO2',selaT332.FieldByName('TURNO2').AsString,VarToStr(updT332.GetVariable('TURNO2')));
        RegistraLog.InserisciDato('ORAINIZIO_TURNO2',selaT332.FieldByName('ORAINIZIO_TURNO2').AsString,VarToStr(updT332.GetVariable('ORAINIZIO_TURNO2')));
        RegistraLog.InserisciDato('ORAFINE_TURNO2',selaT332.FieldByName('ORAFINE_TURNO2').AsString,VarToStr(updT332.GetVariable('ORAFINE_TURNO2')));
        RegistraLog.RegistraOperazione;
        SessioneOracle.Commit;
      except
      end;
    end;
  end;
end;

end.
