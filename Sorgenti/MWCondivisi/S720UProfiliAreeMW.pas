unit S720UProfiliAreeMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Data.DB, Oracle,
  A000UMessaggi, A000UInterfaccia, Datasnap.DBClient, C180FunzioniGenerali,
  Variants, StrUtils, Math;

type
  S720Proc = procedure of object;
  S720ImpostaStatusBar = procedure(RecTot:String) of object;
  S720ImpostaProgressBar = procedure(Totale:Integer) of object;

  TS720FProfiliAreeMW = class(TR005FDataModuleMW)
    selDato1: TOracleDataSet;
    dsrDato1: TDataSource;
    selDato2: TOracleDataSet;
    selDato3: TOracleDataSet;
    dsrDato2: TDataSource;
    dsrDato3: TDataSource;
    selArea: TOracleDataSet;
    dsrArea: TDataSource;
    selDato4: TOracleDataSet;
    dsrDato4: TDataSource;
    selSG720a: TOracleQuery;
    delSG701: TOracleQuery;
    updSG701a: TOracleQuery;
    updI501a: TOracleQuery;
    delI501: TOracleQuery;
    scrT430: TOracleQuery;
    cdsAppoggio: TClientDataSet;
    selT030: TOracleDataSet;
    selSG711a: TOracleDataSet;
    selI501: TOracleDataSet;
    updI501b: TOracleQuery;
    insI501: TOracleQuery;
    updT430: TOracleQuery;
    updSG701b: TOracleQuery;
    insSG701a: TOracleQuery;
    insSG700: TOracleQuery;
    updSG720a: TOracleQuery;
    delSG720: TOracleQuery;
    updSG720b: TOracleQuery;
    insSG720: TOracleQuery;
    cdsDipInf: TClientDataSet;
    selSG701: TOracleDataSet;
    selT430: TOracleDataSet;
    selSG710: TOracleDataSet;
  private
    Fsg720_Funzioni: TOracleDataSet;
    DatiRiga:array[1..7] of String;
    lstMatrDir,lstMatrDirSup:TStringList;
    nRiga,nMaxCodDir:Integer;
    procedure CreaCdsAppoggio;
    procedure CreaCdsDipInf;
    procedure ScompattaRiga(S,Sep:String);
    procedure CaricaCdsAppoggio;
    procedure CaricaCdsDipInf(sMatrDipInf:String);
    procedure ControlloRecord;
    procedure CreaListeMatricole;
    procedure FreeListeMatricole;
    procedure Controlli(Anno:Integer;Sep,NomeFile:String);
    procedure ControlloTotPercItem;
    procedure OperazioniIniziali;
    procedure ObiettiviIndividuali;
    procedure ObiettiviRiportati;
    procedure ObiettiviConvogliati;
    function RecuperoCodiceDirigente(Prog:Integer):String;
    procedure AddAnomalia(Testo:String;bRiga:Boolean = False;nProg:Integer = 0);
    function CapitalizeNominativo(Testo:String):String;
  public
    AnnoImp:Integer;
    evtIniziaImport: S720Proc;
    evtImpostaStatusBar: S720ImpostaStatusBar;
    evtImpostaProgressBar: S720ImpostaProgressBar;
    evtAggiornaProgressBar: S720Proc;
    evtTerminaImport: S720Proc;
    const AnnoMinNuoviCodici:Integer = 2016;
    property SG720_Funzioni: TOracleDataset read Fsg720_Funzioni write Fsg720_Funzioni;
    procedure BeforePost;
    procedure onNewRecord;
    procedure RefreshDataSet;
    procedure RefreshDataLavoro(DataLavoro:TDateTime);
    procedure ImportProfili(SoloControlli:Boolean;Anno:Integer;Sep,NomeFile:String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TS720FProfiliAreeMW.BeforePost;
begin
  if Fsg720_Funzioni.FieldByName('COD_AREA').IsNull then
    raise Exception.Create(A000MSG_S720_ERR_SEL_AREA_VAL);
  if Fsg720_Funzioni.FieldByName('DATO1').IsNull
     and (   not Fsg720_Funzioni.FieldByName('DATO2').IsNull
          or not Fsg720_Funzioni.FieldByName('DATO3').IsNull
          or not Fsg720_Funzioni.FieldByName('DATO4').IsNull) then
    raise Exception.Create(A000MSG_S720_ERR_SPEC_PRIMO_LIV);
  if Fsg720_Funzioni.FieldByName('DATO2').IsNull
     and (   not Fsg720_Funzioni.FieldByName('DATO3').IsNull
          or not Fsg720_Funzioni.FieldByName('DATO4').IsNull) then
    raise Exception.Create(A000MSG_S720_ERR_SPEC_SECONDO_LIV);
  if Fsg720_Funzioni.FieldByName('DECORRENZA').AsDateTime > Fsg720_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime then
    raise Exception.Create(A000MSG_ERR_DECORR_NON_SUCC_SCAD);
  with selSG720a do
  begin
    SetVariable('DATO1',Fsg720_Funzioni.FieldByName('DATO1').AsString);
    SetVariable('DATO2',Fsg720_Funzioni.FieldByName('DATO2').AsString);
    SetVariable('DATO3',Fsg720_Funzioni.FieldByName('DATO3').AsString);
    SetVariable('DATO4',Fsg720_Funzioni.FieldByName('DATO4').AsString);
    SetVariable('COD_AREA',Fsg720_Funzioni.FieldByName('COD_AREA').AsString);
    if Fsg720_Funzioni.State in [dsEdit] then
      SetVariable('COND_ROWID',' and rowid <> ''' + Fsg720_Funzioni.RowId + ''' ')
    else
      SetVariable('COND_ROWID','');
    SetVariable('DECORRENZA',Fsg720_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    SetVariable('SCADENZA',Fsg720_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime);
    Execute;
    if Field(0) > 0 then
      raise Exception.Create(A000MSG_ERR_DATE_INTERS_PERIODI);
  end;
  if Fsg720_Funzioni.State in [dsInsert] then
  begin
    if Fsg720_Funzioni.FieldByName('DATO1').AsString = '' then
      Fsg720_Funzioni.FieldByName('DATO1').AsString:=' ';
    if Fsg720_Funzioni.FieldByName('DATO2').AsString = '' then
      Fsg720_Funzioni.FieldByName('DATO2').AsString:=' ';
    if Fsg720_Funzioni.FieldByName('DATO3').AsString = '' then
      Fsg720_Funzioni.FieldByName('DATO3').AsString:=' ';
    if Fsg720_Funzioni.FieldByName('DATO4').AsString = '' then
      Fsg720_Funzioni.FieldByName('DATO4').AsString:=' ';
  end;
end;

procedure TS720FProfiliAreeMW.onNewRecord;
begin
  Fsg720_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime:=EncodeDate(3999,12,31);
end;

procedure TS720FProfiliAreeMW.RefreshDataSet;
begin
  if selDato1.Active then
    selDato1.Refresh;
  if selDato2.Active then
    selDato2.Refresh;
  if selDato3.Active then
    selDato3.Refresh;
  if selDato4.Active then
    selDato4.Refresh;
  if selArea.Active then
    selArea.Refresh;
  if SG720_Funzioni.Active then
    SG720_Funzioni.Refresh;
end;

procedure TS720FProfiliAreeMW.RefreshDataLavoro(DataLavoro:TDateTime);
begin
  if selDato1.VariableIndex('DECORRENZA') <> -1 then
  begin
    selDato1.Close;
    selDato1.SetVariable('DECORRENZA',DataLavoro);
    selDato1.Open;
  end;
  if selDato2.VariableIndex('DECORRENZA') <> -1 then
  begin
    selDato2.Close;
    selDato2.SetVariable('DECORRENZA',DataLavoro);
    selDato2.Open;
  end;
  if selDato3.VariableIndex('DECORRENZA') <> -1 then
  begin
    selDato3.Close;
    selDato3.SetVariable('DECORRENZA',DataLavoro);
    selDato3.Open;
  end;
  if selDato4.VariableIndex('DECORRENZA') <> -1 then
  begin
    selDato4.Close;
    selDato4.SetVariable('DECORRENZA',DataLavoro);
    selDato4.Open;
  end;
  selArea.Close;
  selArea.SetVariable('DECORRENZA',DataLavoro);
  selArea.Open;
end;

//IMPORTAZIONE PROFILI DA FILE

procedure TS720FProfiliAreeMW.ImportProfili(SoloControlli:Boolean;Anno:Integer;Sep,NomeFile:String);
begin
  try
    if Assigned(evtIniziaImport) then
      evtIniziaImport;
    CreaListeMatricole;
    Controlli(Anno,Sep,NomeFile);
    if not SoloControlli then
    begin
      if not RegistraMsg.ContieneTipoA then
        OperazioniIniziali;
      if not RegistraMsg.ContieneTipoA then
      begin
        try
          ObiettiviIndividuali;
          ObiettiviRiportati;
          ObiettiviConvogliati;
          SessioneOracle.Commit;
        except
          SessioneOracle.Rollback;
          raise;
        end;
      end;
    end;
  finally
    FreeListeMatricole;
    if Assigned(evtTerminaImport) then
      evtTerminaImport;
  end;
end;

procedure TS720FProfiliAreeMW.CreaListeMatricole;
begin
  lstMatrDir:=TStringList.Create;
  lstMatrDirSup:=TStringList.Create;
end;

procedure TS720FProfiliAreeMW.FreeListeMatricole;
begin
  lstMatrDir.Free;
  lstMatrDirSup.Free;
end;

procedure TS720FProfiliAreeMW.Controlli(Anno:Integer;Sep,NomeFile:String);
var F1:TextFile;
    S:String;
begin
  if Anno = 0 then
    raise exception.Create(A000MSG_S720_ERR_NO_ANNO);
  AnnoImp:=Anno;
  R180SetVariable(selT030,'InizioAnno',EncodeDate(AnnoImp,1,1));
  R180SetVariable(selT030,'FineAnno',EncodeDate(AnnoImp,12,31));
  if Trim(Sep) = '' then
    raise exception.Create(A000MSG_S720_ERR_NO_SEPARATORE);
  if not FileExists(NomeFile) then
    raise exception.Create(A000MSG_ERR_FILE_INESISTENTE);
  //Importare il file in un ClientDataSet (vedi P041).
  AssignFile(F1,NomeFile);
  try
    Reset(F1);
  except
    raise exception.Create(Format(A000MSG_ERR_FMT_APRI_FILE,[NomeFile]));
  end;
  selSG710.Close;
  selSG710.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
  selSG710.Open;
  if selSG710.FieldByName('N_SCHEDE').AsInteger > 0 then
    raise exception.Create(A000MSG_S720_ERR_ESISTE_SCHEDA);
  RegistraMsg.IniziaMessaggio('S720');
  CreaCdsAppoggio;
  CreaCdsDipInf;
  //Recupero il totale delle righe valide del file
  if Assigned(evtImpostaStatusBar) then
    evtImpostaStatusBar(A000MSG_S720_MSG_STEP_CTRL_GEN);
  try
    try
      Reset(F1);
      nRiga:=0;
      while not Eof(F1) do
      begin
        Readln(F1,S);
        if Trim(S) <> '' then
          inc(nRiga);
      end;
    except
      raise exception.Create(A000MSG_S720_ERR_LETTURA_FILE);
    end;
    if nRiga = 0 then
      raise exception.Create(A000MSG_S720_ERR_FILE_NO_DATI);
  finally
    CloseFile(F1);
  end;
  //Avvio la lettura effettiva del file
  if Assigned(evtImpostaProgressBar) then
    evtImpostaProgressBar(nRiga);
  try
    try
      Reset(F1);
      nRiga:=0;
      while not Eof(F1) do
      begin
        Readln(F1,S);
        inc(nRiga);
        if Trim(S) <> '' then
        begin
          ScompattaRiga(S,Sep);
          CaricaCdsAppoggio;
          ControlloRecord;
          if Assigned(evtAggiornaProgressBar) then
            evtAggiornaProgressBar;
        end;
      end;
    except
      raise exception.Create(A000MSG_S720_ERR_LETTURA_FILE);
    end;
  finally
    CloseFile(F1);
  end;
  ControlloTotPercItem;
end;

procedure TS720FProfiliAreeMW.CreaCdsAppoggio;
begin
  cdsAppoggio.Close;
  cdsAppoggio.IndexDefs.Clear;
  cdsAppoggio.IndexName:='';
  cdsAppoggio.FieldDefs.Clear;
  cdsAppoggio.FieldDefs.Add('PROGRESSIVO',ftInteger,0);
  cdsAppoggio.FieldDefs.Add('COGNOME',ftString,50);
  cdsAppoggio.FieldDefs.Add('NOME',ftString,50);
  cdsAppoggio.FieldDefs.Add('COD_DIR',ftString,3);
  cdsAppoggio.FieldDefs.Add('MATR_DIR',ftString,8);
  cdsAppoggio.FieldDefs.Add('FASCIA_DIR',ftString,1);
  cdsAppoggio.FieldDefs.Add('COD_ITEM',ftString,5);
  cdsAppoggio.FieldDefs.Add('DESC_ITEM',ftString,500);
  cdsAppoggio.FieldDefs.Add('PERC_ITEM',ftString,10);
  cdsAppoggio.FieldDefs.Add('MATR_DIP_INF',ftString,1000);
  cdsAppoggio.FieldDefs.Add('MATR_DIR_SUP',ftString,8);
  cdsAppoggio.CreateDataSet;
  cdsAppoggio.IndexDefs.Add('Primario','MATR_DIR;COD_ITEM',[]);
  cdsAppoggio.IndexName:='Primario';
  cdsAppoggio.LogChanges:=False;
  cdsAppoggio.DisableControls;
end;

procedure TS720FProfiliAreeMW.CreaCdsDipInf;
begin
  cdsDipInf.Close;
  cdsDipInf.IndexDefs.Clear;
  cdsDipInf.IndexName:='';
  cdsDipInf.FieldDefs.Clear;
  cdsDipInf.FieldDefs.Add('PROGRESSIVO',ftInteger,0);
  cdsDipInf.FieldDefs.Add('MATR_DIP',ftString,8);
  cdsDipInf.FieldDefs.Add('MATR_DIR',ftString,8);
  cdsDipInf.FieldDefs.Add('N_ITEM',ftInteger,0);
  cdsDipInf.FieldDefs.Add('MIN_COD_ITEM',ftInteger,0);
  cdsDipInf.CreateDataSet;
  cdsDipInf.AddIndex('Primario','MATR_DIR;N_ITEM;MIN_COD_ITEM',[],'N_ITEM');
  cdsDipInf.IndexName:='Primario';
  cdsDipInf.LogChanges:=False;
  cdsDipInf.DisableControls;
end;

procedure TS720FProfiliAreeMW.ScompattaRiga(S,Sep:String);
var i,PosSep:integer;
begin
  for i:=1 to 7 do
  begin
    PosSep:=Pos(Sep,S);
    if PosSep = 0 then
    begin
      DatiRiga[i]:=Trim(S);
      break;
    end
    else
    begin
      DatiRiga[i]:=Trim(Copy(S,1,PosSep - 1));
      S:=Copy(S,PosSep + Length(Sep));
    end;
  end;
end;

procedure TS720FProfiliAreeMW.CaricaCdsAppoggio;
begin
  cdsAppoggio.Insert;
  cdsAppoggio.FieldByName('MATR_DIR').AsString:=Copy(DatiRiga[1],1,cdsAppoggio.FieldByName('MATR_DIR').Size);
  cdsAppoggio.FieldByName('FASCIA_DIR').AsString:=Copy(DatiRiga[2],1,cdsAppoggio.FieldByName('FASCIA_DIR').Size);
  cdsAppoggio.FieldByName('COD_ITEM').AsString:=Copy(DatiRiga[3],1,cdsAppoggio.FieldByName('COD_ITEM').Size);
  cdsAppoggio.FieldByName('DESC_ITEM').AsString:=Copy(DatiRiga[4],1,cdsAppoggio.FieldByName('DESC_ITEM').Size);
  cdsAppoggio.FieldByName('PERC_ITEM').AsString:=Copy(DatiRiga[5],1,cdsAppoggio.FieldByName('PERC_ITEM').Size);
  cdsAppoggio.FieldByName('MATR_DIP_INF').AsString:=',' + Copy(DatiRiga[6],1,cdsAppoggio.FieldByName('MATR_DIP_INF').Size - 2) + ',';
  cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString:=Copy(DatiRiga[7],1,cdsAppoggio.FieldByName('MATR_DIR_SUP').Size);
  cdsAppoggio.Post;
end;

procedure TS720FProfiliAreeMW.CaricaCdsDipInf(sMatrDipInf:String);
var CodItem:Integer;
begin
  cdsDipInf.Insert;
  cdsDipInf.FieldByName('PROGRESSIVO').AsInteger:=selT030.FieldByName('PROGRESSIVO').AsInteger;
  cdsDipInf.FieldByName('MATR_DIP').AsString:=sMatrDipInf;
  cdsDipInf.FieldByName('MATR_DIR').AsString:=cdsAppoggio.FieldByName('MATR_DIR').AsString;
  cdsDipInf.FieldByName('N_ITEM').AsInteger:=0;
  if TryStrToInt(cdsAppoggio.FieldByName('COD_ITEM').AsString,CodItem) then
    cdsDipInf.FieldByName('MIN_COD_ITEM').AsInteger:=CodItem;
  cdsDipInf.Post;
end;

procedure TS720FProfiliAreeMW.ControlloRecord;
var CodItem:Integer;
    PercItem:Extended;
    sElencoMatrDipInf,sMatrDipInf:String;
    BM:TBookMark;
begin
  R180SetVariable(selT030,'Matricola',cdsAppoggio.FieldByName('MATR_DIR').AsString);
  selT030.Open;
  if cdsAppoggio.FieldByName('MATR_DIR').AsString = '' then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DATO,['Matricola del dirigente']),True)
  else if selT030.RecordCount = 0 then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DIP_IN_SERVIZIO,['"Matricola del dirigente"',IntToStr(AnnoImp),cdsAppoggio.FieldByName('MATR_DIR').AsString]),True)
  else
  begin
    if lstMatrDir.IndexOf(cdsAppoggio.FieldByName('MATR_DIR').AsString) < 0 then
      lstMatrDir.Add(cdsAppoggio.FieldByName('MATR_DIR').AsString);
    cdsAppoggio.Edit;
    cdsAppoggio.FieldByName('PROGRESSIVO').AsInteger:=selT030.FieldByName('PROGRESSIVO').AsInteger;
    cdsAppoggio.FieldByName('COGNOME').AsString:=CapitalizeNominativo(Trim(selT030.FieldByName('COGNOME').AsString));
    cdsAppoggio.FieldByName('NOME').AsString:=CapitalizeNominativo(Trim(selT030.FieldByName('NOME').AsString));
    cdsAppoggio.Post;
  end;
  if cdsAppoggio.FieldByName('FASCIA_DIR').AsString = '' then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DATO,['Fascia del dirigente']),True)
  else if not R180In(cdsAppoggio.FieldByName('FASCIA_DIR').AsString,['1','2']) then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_FASCIA_EXTRA,[cdsAppoggio.FieldByName('FASCIA_DIR').AsString]),True)
  else if VarToStr(cdsAppoggio.Lookup('MATR_DIR;FASCIA_DIR',VarArrayOf([cdsAppoggio.FieldByName('MATR_DIR').AsString,IfThen(cdsAppoggio.FieldByName('FASCIA_DIR').AsString = '1','2','1')]),'MATR_DIR')) = cdsAppoggio.FieldByName('MATR_DIR').AsString then
    AddAnomalia(A000MSG_S720_ERR_FASCIA_DIVERSA,True);
  if cdsAppoggio.FieldByName('COD_ITEM').AsString = '' then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DATO,['Codice obiettivo']),True)
  else if not TryStrToInt(cdsAppoggio.FieldByName('COD_ITEM').AsString,CodItem) then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_DATO_NO_NUMERICO,['"Codice obiettivo"',cdsAppoggio.FieldByName('COD_ITEM').AsString]),True)
  else
  begin
    BM:=cdsAppoggio.GetBookmark;
	  try
      cdsAppoggio.Filter:='(MATR_DIR = ''' + cdsAppoggio.FieldByName('MATR_DIR').AsString + ''') and (COD_ITEM = ''' + cdsAppoggio.FieldByName('COD_ITEM').AsString + ''')';
      cdsAppoggio.Filtered:=True;
      if cdsAppoggio.RecordCount > 1 then
        AddAnomalia(Format(A000MSG_S720_ERR_FMT_ITEM_DOPPIO,[cdsAppoggio.FieldByName('COD_ITEM').AsString]),True);
      cdsAppoggio.Filtered:=False;
      cdsAppoggio.GotoBookmark(BM);
	  finally
      cdsAppoggio.FreeBookmark(BM);
	  end;
  end;
  if cdsAppoggio.FieldByName('DESC_ITEM').AsString = '' then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DATO,['Descrizione obiettivo']),True);
  if cdsAppoggio.FieldByName('PERC_ITEM').AsString = '' then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DATO,['Peso % obiettivo']),True)
  else if not TryStrToFloat(cdsAppoggio.FieldByName('PERC_ITEM').AsString,PercItem) then
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_DATO_NO_NUMERICO,['"Peso % obiettivo"',cdsAppoggio.FieldByName('PERC_ITEM').AsString]),True);
  if cdsAppoggio.FieldByName('MATR_DIP_INF').AsString <> ',,' then
  begin
    sElencoMatrDipInf:=cdsAppoggio.FieldByName('MATR_DIP_INF').AsString;
    while Pos(',',sElencoMatrDipInf) > 0 do
    begin
      sMatrDipInf:=Trim(Copy(sElencoMatrDipInf,1,Pos(',',sElencoMatrDipInf) - 1));
      if sMatrDipInf <> '' then
      begin
        R180SetVariable(selT030,'Matricola',sMatrDipInf);
        selT030.Open;
        if selT030.RecordCount = 0 then
          AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DIP_IN_SERVIZIO,['"Elenco matricole dei dipendenti" contiene una matricola che',IntToStr(AnnoImp),sMatrDipInf]),True)
        else if not cdsDipInf.Locate('MATR_DIP',sMatrDipInf,[]) then
          CaricaCdsDipInf(sMatrDipInf)
        else if cdsDipInf.FieldByName('MATR_DIR').AsString <> cdsAppoggio.FieldByName('MATR_DIR').AsString then
          //Per ogni dipendente, verificare che sia associato agli obiettivi di una sola matricola del dirigente; altrimenti segnalare anomalia e saltare.
          AddAnomalia(Format(A000MSG_S720_ERR_FMT_DIPENDENTE_DOPPIO,[sMatrDipInf]),True)
        else
        begin
          cdsDipInf.Edit;
          cdsDipInf.FieldByName('N_ITEM').AsInteger:=cdsDipInf.FieldByName('N_ITEM').AsInteger + 1;
          cdsDipInf.Post;
        end;
      end;
      sElencoMatrDipInf:=Copy(sElencoMatrDipInf,Pos(',',sElencoMatrDipInf) + 1);
    end;
  end;
  if cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString <> '' then
  begin
    if cdsAppoggio.FieldByName('FASCIA_DIR').AsString = '1' then
      AddAnomalia(Format(A000MSG_S720_ERR_FMT_DIR_SUP_PER_FASCIA1,[cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString]),True)
    else if VarToStr(cdsAppoggio.Lookup('MATR_DIR;FASCIA_DIR',VarArrayOf([cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString,'2']),'FASCIA_DIR')) = '2' then
      AddAnomalia(Format(A000MSG_S720_ERR_FMT_DIR_SUP_CON_FASCIA2,[cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString]),True)
    else
    begin
      R180SetVariable(selT030,'Matricola',cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString);
      selT030.Open;
      if selT030.RecordCount = 0 then
        AddAnomalia(Format(A000MSG_S720_ERR_FMT_NO_DIP_IN_SERVIZIO,['"Matricola del dirigente di fascia superiore"',IntToStr(AnnoImp),cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString]),True)
      else if lstMatrDirSup.IndexOf(cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString) < 0 then
        lstMatrDirSup.Add(cdsAppoggio.FieldByName('MATR_DIR_SUP').AsString);
    end;
  end;
end;

procedure TS720FProfiliAreeMW.ControlloTotPercItem;
var i:Integer;
    TotPercItem:Real;
begin
  if Assigned(evtImpostaStatusBar) then
    evtImpostaStatusBar(A000MSG_S720_MSG_STEP_CTRL_PESI);
  if Assigned(evtImpostaProgressBar) then
    evtImpostaProgressBar(lstMatrDir.Count);
  for i:=0 to lstMatrDir.Count - 1 do
  begin
    //Filtro le righe della Matricola del dirigente
    cdsAppoggio.Filter:='MATR_DIR = ''' + lstMatrDir[i] + '''';
    cdsAppoggio.Filtered:=True;
    //Controllo che la somma dei pesi degli item sia 100
    TotPercItem:=0;
    cdsAppoggio.First;
    while not cdsAppoggio.Eof do
    begin
      TotPercItem:=TotPercItem + cdsAppoggio.FieldByName('PERC_ITEM').AsFloat;
      cdsAppoggio.Next;
    end;
    cdsAppoggio.First;
    if TotPercItem <> 100 then
      AddAnomalia(Format(A000MSG_S720_ERR_FMT_TOT_PESI_ITEM,[FloatToStr(TotPercItem)]));
    cdsAppoggio.Filtered:=False;
    if Assigned(evtAggiornaProgressBar) then
      evtAggiornaProgressBar;
  end;
end;

procedure TS720FProfiliAreeMW.OperazioniIniziali;
begin
  if Assigned(evtImpostaStatusBar) then
    evtImpostaStatusBar(A000MSG_S720_MSG_STEP_INIZIO_IMP);
  if Assigned(evtImpostaProgressBar) then
    evtImpostaProgressBar(0);
  //Cancellare storicizzazioni >= Anno delle aree usate nei profili che intersecano il 01/01/Anno, tranne quelle dei comportamenti (x000,x999). Riaprire fine = 31/12/3999.
  delSG701.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
  delSG701.Execute;
  updSG701a.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
  updSG701a.Execute;
  //Chiudere al 31/12/Anno-1 i RAG_SCHEDA_VAL e i profili che intersecano il 01/01/Anno, tranne quelli dei soli comportamenti (x000). Cancellare fine > inizio.
  updI501a.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
  updI501a.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
  updI501a.Execute;
  delI501.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
  delI501.Execute;
  updSG720a.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
  updSG720a.Execute;
  delSG720.Execute;
  //Prelevo il massimo codice dirigente usato
  selI501.Close;
  selI501.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
  selI501.SetVariable('DecMinNuoviCodici',EncodeDate(AnnoMinNuoviCodici,1,1));
  selI501.Open;
  if not TryStrToInt(selI501.FieldByName('MAX_COD_DIR').AsString,nMaxCodDir) then
  begin
    AddAnomalia(Format(A000MSG_S720_ERR_FMT_DATO_NO_NUMERICO,['Il massimo codice dirigente già caricato',selI501.FieldByName('MAX_COD_DIR').AsString]));
    SessioneOracle.Rollback;
  end
  else
  begin
    //Assegnare in anagrafica dal 01/01/Anno il RAG_SCHEDA_VAL dei soli comportamenti (x000) a tutti in base al TIPO_SCHEDA_VAL (A,B,C).
    scrT430.SetVariable('CampoRegole',Parametri.CampiRiferimento.C21_ValutazioniPnt1);
    scrT430.SetVariable('CampoProfili',Parametri.CampiRiferimento.C21_ValutazioniLiv1);
    scrT430.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
    scrT430.SetVariable('FineAnno',EncodeDate(AnnoImp,12,31));
    scrT430.Execute;
    SessioneOracle.Commit;
  end;
end;

procedure TS720FProfiliAreeMW.ObiettiviIndividuali;
var i:Integer;
    CodDir,CodProf,DescProf,CodArea,DescArea,CodProfStoricizzato:String;
    SoloObInd:Boolean;
    PercArea:Real;
begin
  if Assigned(evtImpostaStatusBar) then
    evtImpostaStatusBar(A000MSG_S720_MSG_STEP_ITEM_PROPRI);
  if Assigned(evtImpostaProgressBar) then
    evtImpostaProgressBar(lstMatrDir.Count);
  //1° Ciclo ClientDataSet: creazione obiettivi individuali dei dirigenti di prima e seconda fascia
  //Per ogni distinta Matricola del dirigente nel file, recuperare il Codice dirigente (<>000) in base alla propria ultima scheda >= 2016, o calcolarne uno nuovo (tra 001 e 998).
  for i:=0 to lstMatrDir.Count - 1 do
  begin
    //Filtro le righe della Matricola del dirigente
    cdsAppoggio.Filter:='MATR_DIR = ''' + lstMatrDir[i] + '''';
    cdsAppoggio.Filtered:=True;
    CodDir:=RecuperoCodiceDirigente(cdsAppoggio.FieldByName('PROGRESSIVO').AsInteger);
    if CodDir <> '' then
    begin
      //Assegno il codice del dirigente alle righe della Matricola del dirigente
      cdsAppoggio.First;
      while not cdsAppoggio.Eof do
      begin
        cdsAppoggio.Edit;
        cdsAppoggio.FieldByName('COD_DIR').AsString:=CodDir;
        cdsAppoggio.Post;
        cdsAppoggio.Next;
      end;
      cdsAppoggio.First;
      //Calcolare RAG_SCHEDA_VAL = DECODE(Fascia dirigente,1,’A’,2,’B’)||Codice dirigente. Se esiste al 31/12/Anno-1, fine := 31/12/3999, altrimenti crearlo dal 01/01/Anno.
      CodProf:=IfThen(cdsAppoggio.FieldByName('FASCIA_DIR').AsString = '1','A','B') + cdsAppoggio.FieldByName('COD_DIR').AsString;
      SoloObInd:=lstMatrDirSup.IndexOf(lstMatrDir[i]) < 0;
      DescProf:=Copy(Copy(CodProf,1,1) + '999 (comp.) + ' + CodProf + 'a (ob.ind)' + IfThen(not SoloObInd,' + ' + CodProf + 'b (ob.str)') + ' ' + cdsAppoggio.FieldByName('COGNOME').AsString + ' ' + cdsAppoggio.FieldByName('NOME').AsString,1,100);
      CodProfStoricizzato:='N';
      updI501b.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
      updI501b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
      updI501b.SetVariable('CodProf',CodProf);
      updI501b.SetVariable('DescProf',DescProf);
      updI501b.Execute;
      if updI501b.RowsProcessed = 0 then
      begin
        insI501.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
        insI501.SetVariable('CodProf',CodProf);
        insI501.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        insI501.SetVariable('DescProf',DescProf);
        insI501.Execute;
        CodProfStoricizzato:='S';
      end;
      //Assegnare il RAG_SCHEDA_VAL in anagrafica dal 01/01/Anno in poi. Allineare il TIPO_SCHEDA_VAL.
      updT430.SetVariable('CampoRegole',Parametri.CampiRiferimento.C21_ValutazioniPnt1);
      updT430.SetVariable('CampoProfili',Parametri.CampiRiferimento.C21_ValutazioniLiv1);
      updT430.SetVariable('CodProf',CodProf);
      updT430.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
      updT430.SetVariable('Progressivo',cdsAppoggio.FieldByName('PROGRESSIVO').AsInteger);
      updT430.Execute; //la prima storicizzazione nell'anno è già stata effettuata dal scrT430
      //Creare o storicizzare dal 01/01/Anno l’area = RAG_SCHEDA_VAL||’a’ con peso = DECODE(Fascia dirigente,1,DECODE(Matricola del dirigente,Presente nel file in Matricola del dirigente di fascia superiore su cui è convogliato l’obiettivo,35,70),2,70). Per gli altri campi, vedi le immagini seguenti.
      CodArea:=CodProf + 'a';
      PercArea:=IfThen(SoloObInd,70,35);
      DescArea:=Copy('Grado di conseguimento degli obiettivi propri ' + FloatToStr(PercArea) + '% ' + cdsAppoggio.FieldByName('COGNOME').AsString + ' ' + cdsAppoggio.FieldByName('NOME').AsString,1,100);
      updSG701b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
      updSG701b.SetVariable('CodArea',CodArea);
      updSG701b.Execute;
      insSG701a.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
      insSG701a.SetVariable('CodArea',CodArea);
      insSG701a.SetVariable('DescArea',DescArea);
      insSG701a.SetVariable('PercArea',PercArea);
      insSG701a.SetVariable('TipoLinkItem','0');
      insSG701a.Execute;
      //Creare elementi impostando: codice = LPAD(Numero obiettivo,5,'0'), descrizione = Descrizione obiettivo, peso = Peso obiettivo.
      cdsAppoggio.First;
      while not cdsAppoggio.Eof do
      begin
        insSG700.ClearVariables;//per svuotare variabili CodAreaLink e CodItemLink
        insSG700.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        insSG700.SetVariable('CodArea',CodArea);
        insSG700.SetVariable('CodItem',StringReplace(Format('%-5.5d',[cdsAppoggio.FieldByName('COD_ITEM').AsInteger]),' ','0',[rfReplaceAll]));
        insSG700.SetVariable('DescItem',cdsAppoggio.FieldByName('DESC_ITEM').AsString);
        insSG700.SetVariable('PercItem',cdsAppoggio.FieldByName('PERC_ITEM').AsFloat);
        insSG700.Execute;
        cdsAppoggio.Next;
      end;
      cdsAppoggio.First;
      //Creare il profilo dal 01/01/Anno, o prolungarne la fine, associando il RAG_SCHEDA_VAL alla nuova area e all’area DECODE(Fascia dirigente,1,’A’,2,’B’)||’999’.
      updSG720b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
      updSG720b.SetVariable('CodProf',CodProf);
      updSG720b.SetVariable('CodArea',CodArea);
      updSG720b.SetVariable('CodProfStoricizzato',CodProfStoricizzato);
      insSG720.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
      insSG720.SetVariable('CodProf',CodProf);
      insSG720.SetVariable('CodArea',CodArea);
      updSG720b.Execute;
      if updSG720b.RowsProcessed = 0 then
        insSG720.Execute;
      updSG720b.SetVariable('CodArea',Copy(CodArea,1,1) + '999');
      updSG720b.SetVariable('CodProfStoricizzato','N');
      insSG720.SetVariable('CodArea',Copy(CodArea,1,1) + '999');
      updSG720b.Execute;
      if updSG720b.RowsProcessed = 0 then
        insSG720.Execute;
    end;
    cdsAppoggio.Filtered:=False;
    if Assigned(evtAggiornaProgressBar) then
      evtAggiornaProgressBar;
  end;
end;

procedure TS720FProfiliAreeMW.ObiettiviRiportati;
var CodProf,DescProf,CodArea,DescArea,CodCombItem,ElencoItem,DescElencoItem,CodProfStoricizzato:String;
    PercArea,PercItem,DiffPercItem,nDiffPercItem:Real;
    i:Integer;
    CodAreaTrovata,CodCombItemTrovato:Boolean;
const CombItem:string = 'abcdefghijklmnopqrstuvwxyz';
begin
  if Assigned(evtImpostaStatusBar) then
    evtImpostaStatusBar(A000MSG_S720_MSG_STEP_ITEM_RIPORTA);
  if Assigned(evtImpostaProgressBar) then
    evtImpostaProgressBar(cdsDipInf.RecordCount);
  //2° Ciclo ClientDataSet: creazione degli obiettivi delle categorie ereditati dai dirigenti di prima e seconda fascia
  //Prelevare l’elenco distinto di tutte le matricole dei dipendenti nel file, dando la precedenza a quelle che compaiono associate al maggior numero di obiettivi.
  cdsDipInf.First;
  while not cdsDipInf.Eof do
  begin
    R180SetVariable(selT030,'Matricola',cdsDipInf.FieldByName('MATR_DIP').AsString);
    selT030.Open;
    //Filtro le righe dell'Elenco matricole dei dipendenti
    cdsAppoggio.Filter:='MATR_DIP_INF LIKE ' + QuotedStr('%,' + cdsDipInf.FieldByName('MATR_DIP').AsString + ',%');
    cdsAppoggio.Filtered:=True;
    //Recuperare il Codice dirigente in base al RAG_SCHEDA_VAL impostato (dal 1° ciclo) durante l’Anno nell’anagrafica della matricola del dirigente.
    if cdsAppoggio.FieldByName('COD_DIR').AsString <> '' then
    begin
      //In base agli elementi associati al dipendente, recuperare il Codice combinazione dall’area che decorre dall’Anno con gli stessi elementi, oppure calcolarlo (tra “a” e “z”).
      ElencoItem:='';
      DescElencoItem:='';
      cdsAppoggio.First;
      while not cdsAppoggio.Eof do
      begin
        //Elementi associati al dipendente
        ElencoItem:=ElencoItem + IfThen(ElencoItem <> '','/') + StringReplace(Format('%-5.5d',[cdsAppoggio.FieldByName('COD_ITEM').AsInteger]),' ','0',[rfReplaceAll]);
        DescElencoItem:=DescElencoItem + IfThen(DescElencoItem <> '',',') + cdsAppoggio.FieldByName('COD_ITEM').AsString;
        cdsAppoggio.Next;
      end;
      cdsAppoggio.First;
      //Scorro le aree già create per l'anno di valutazione relative al dirigente corrente
      CodProf:='C' + cdsAppoggio.FieldByName('COD_DIR').AsString;
      CodArea:='';
      CodAreaTrovata:=False;
      CodCombItem:='';
      selSG701.Close;
      selSG701.SetVariable('CodProf',CodProf);
      selSG701.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
      selSG701.Open;
      while not selSG701.Eof do
      begin
        CodCombItem:=Copy(selSG701.FieldByName('COD_AREA').AsString,5,1);
        //Gli elementi associati al dipendente sono già stati inseriti in un'area nell'anno di valutazione
        if ElencoItem = selSG701.FieldByName('ELENCO_ITEM').AsString then
        begin
          CodArea:=selSG701.FieldByName('COD_AREA').AsString;
          CodAreaTrovata:=True;
          Break;
        end;
        selSG701.Next;
      end;
      //Se gli elementi associati al dipendente non sono già stati inseriti in un'area nell'anno di valutazione, creo una nuova combinazione
      if not CodAreaTrovata then
      begin
        //Se non è stata ancora creata nessuna area per i dipendenti con gli obiettivi del dirigente, parto da "a"...
        if CodCombItem = '' then
          CodCombItem:=CombItem[1]
        //...altrimenti recupero la lettera successiva per la combinazione corrente
        else
        begin
          CodCombItemTrovato:=False;
          i:=0;
          repeat
            inc(i);
            if CodCombItem = CombItem[i] then
            begin
              CodCombItem:=CombItem[i + 1];
              CodCombItemTrovato:=True;
              Break;
            end;
          until i = Length(CombItem) - 1;
          if not CodCombItemTrovato then
          begin
            AddAnomalia(Format(A000MSG_S720_ERR_FMT_TROPPE_COMB_ITEM,[CodCombItem]),False,cdsDipInf.FieldByName('PROGRESSIVO').AsInteger);
            CodCombItem:='';//Forzatura per saltare il dipendente
          end;
        end;
        //Codice della nuova area
        CodArea:=CodProf + CodCombItem;
      end;
      if CodCombItem <> '' then
      begin
        //Calcolare RAG_SCHEDA_VAL =’C’||Codice dirigente||Codice combinazione. Crearlo dal 01/01/Anno.
        CodProf:=CodArea;
        DescProf:=Copy(Copy(CodProf,1,1) + '999 (comp.) + ' + CodProf + ' (ob.' + DescElencoItem + ') ' + cdsAppoggio.FieldByName('COGNOME').AsString + ' ' + cdsAppoggio.FieldByName('NOME').AsString,1,100);
        if not CodAreaTrovata then
        begin
          CodProfStoricizzato:='N';
          updI501b.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
          updI501b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
          updI501b.SetVariable('CodProf',CodProf);
          updI501b.SetVariable('DescProf',DescProf);
          updI501b.Execute;
          if updI501b.RowsProcessed = 0 then
          begin
            insI501.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
            insI501.SetVariable('CodProf',CodProf);
            insI501.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
            insI501.SetVariable('DescProf',DescProf);
            insI501.Execute;
            CodProfStoricizzato:='S';
          end;
        end;
        //Assegnare il RAG_SCHEDA_VAL in anagrafica dal 01/01/Anno in poi. Allineare il TIPO_SCHEDA_VAL.
        updT430.SetVariable('CampoRegole',Parametri.CampiRiferimento.C21_ValutazioniPnt1);
        updT430.SetVariable('CampoProfili',Parametri.CampiRiferimento.C21_ValutazioniLiv1);
        updT430.SetVariable('CodProf',CodProf);
        updT430.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        updT430.SetVariable('Progressivo',cdsDipInf.FieldByName('PROGRESSIVO').AsInteger);
        updT430.Execute; //la prima storicizzazione nell'anno è già stata effettuata dal scrT430
        if not CodAreaTrovata then
        begin
          //Creare o storicizzare dal 01/01/Anno l’area = RAG_SCHEDA_VAL con peso = 50. Per gli altri campi, vedi le immagini seguenti.
          PercArea:=50;
          DescArea:=Copy('Grado di conseguimento degli obiettivi assegnati ' + FloatToStr(PercArea) + '% ' + cdsAppoggio.FieldByName('COGNOME').AsString + ' ' + cdsAppoggio.FieldByName('NOME').AsString,1,100);
          updSG701b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
          updSG701b.SetVariable('CodArea',CodArea);
          updSG701b.Execute;
          insSG701a.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
          insSG701a.SetVariable('CodArea',CodArea);
          insSG701a.SetVariable('DescArea',DescArea);
          insSG701a.SetVariable('PercArea',PercArea);
          insSG701a.SetVariable('TipoLinkItem','2');
          insSG701a.Execute;
          //Creare elementi impostando: codice = LPAD(progressivo numerico nell’area,5,'0'), descrizione = Descrizione obiettivo, peso uniforme. Collegare gli obiettivi a quelli corrispondenti dell’area del dirigente, in base al Numero obiettivo.
          PercItem:=R180Arrotonda(100 / cdsAppoggio.RecordCount,0.01,'P');
          DiffPercItem:=R180Arrotonda(100 - (cdsAppoggio.RecordCount * PercItem),0.01,'P');
          nDiffPercItem:=Abs(DiffPercItem / 0.01);
          cdsAppoggio.First;
          while not cdsAppoggio.Eof do
          begin
            insSG700.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
            insSG700.SetVariable('CodArea',CodArea);
            insSG700.SetVariable('CodItem',StringReplace(Format('%-5.5d',[cdsAppoggio.RecNo]),' ','0',[rfReplaceAll]));
            insSG700.SetVariable('DescItem',Copy('Obiettivo ' + cdsAppoggio.FieldByName('COD_ITEM').AsString + ': ' + cdsAppoggio.FieldByName('DESC_ITEM').AsString,1,500));
            insSG700.SetVariable('PercItem',PercItem + IfThen(cdsAppoggio.RecNo > (cdsAppoggio.RecordCount - nDiffPercItem),0.01 * IfThen(DiffPercItem < 0,-1,1)));
            insSG700.SetVariable('CodAreaLink',IfThen(cdsAppoggio.FieldByName('FASCIA_DIR').AsString = '1','A','B') + cdsAppoggio.FieldByName('COD_DIR').AsString + 'a');
            insSG700.SetVariable('CodItemLink',StringReplace(Format('%-5.5d',[cdsAppoggio.FieldByName('COD_ITEM').AsInteger]),' ','0',[rfReplaceAll]));
            insSG700.Execute;
            cdsAppoggio.Next;
          end;
          cdsAppoggio.First;
          //Creare il profilo dal 01/01/Anno, o prolungarne la fine, associando il RAG_SCHEDA_VAL alla nuova area e all’area ’C999’.
          updSG720b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
          updSG720b.SetVariable('CodProf',CodProf);
          updSG720b.SetVariable('CodArea',CodArea);
          updSG720b.SetVariable('CodProfStoricizzato',CodProfStoricizzato);
          insSG720.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
          insSG720.SetVariable('CodProf',CodProf);
          insSG720.SetVariable('CodArea',CodArea);
          updSG720b.Execute;
          if updSG720b.RowsProcessed = 0 then
            insSG720.Execute;
          updSG720b.SetVariable('CodArea',Copy(CodArea,1,1) + '999');
          updSG720b.SetVariable('CodProfStoricizzato','N');
          insSG720.SetVariable('CodArea',Copy(CodArea,1,1) + '999');
          updSG720b.Execute;
          if updSG720b.RowsProcessed = 0 then
            insSG720.Execute;
        end;
      end;
    end;
    cdsAppoggio.Filtered:=False;
    if Assigned(evtAggiornaProgressBar) then
      evtAggiornaProgressBar;
    cdsDipInf.Next;
  end;
end;

procedure TS720FProfiliAreeMW.ObiettiviConvogliati;
var i:Integer;
    CodDirSup,CodProf,DescProf,CodArea,DescArea,CodProfStoricizzato:String;
    CodDirValorizzato,SoloObConv:Boolean;
    PercArea,PercItem,DiffPercItem,nDiffPercItem:Real;
begin
  if Assigned(evtImpostaStatusBar) then
    evtImpostaStatusBar(A000MSG_S720_MSG_STEP_ITEM_CONVOGLIA);
  if Assigned(evtImpostaProgressBar) then
    evtImpostaProgressBar(lstMatrDirSup.Count);
  //3° Ciclo ClientDataSet: creazione degli obiettivi di struttura dei dirigenti di prima fascia convogliati dai dirigenti di seconda fascia
  //Prelevare l’elenco distinto di tutte le matricole dei dirigenti di prima fascia nel file dal campo Matricola del dirigente di fascia superiore su cui è convogliato l’obiettivo.
  for i:=0 to lstMatrDirSup.Count - 1 do
  begin
    R180SetVariable(selT030,'Matricola',lstMatrDirSup[i]);
    selT030.Open;
    //Filtro le righe della Matricola del dirigente di fascia superiore
    cdsAppoggio.Filter:='MATR_DIR_SUP = ''' + lstMatrDirSup[i] + '''';
    cdsAppoggio.Filtered:=True;
    //Controllo che tutti i dirigenti da cui convoglio gli obiettivi abbiano il codice dirigente valorizzato
    CodDirValorizzato:=True;
    cdsAppoggio.First;
    while not cdsAppoggio.Eof do
    begin
      if cdsAppoggio.FieldByName('COD_DIR').AsString = '' then
        CodDirValorizzato:=False;
      cdsAppoggio.Next;
    end;
    cdsAppoggio.First;
    if CodDirValorizzato then
    begin
      //Per ogni dirigente di prima fascia:
      //Recuperare il Codice dirigente (<>000) in base alla propria ultima scheda >= 2016. Se non esiste, recuperare il Codice dirigente (<>000) in base al RAG_SCHEDA_VAL impostato (dal 1° ciclo) durante l’Anno nella propria anagrafica. Se non esiste, calcolare un nuovo Codice dirigente (tra 001 e 998) .
      cdsAppoggio.Filtered:=False;//Tolgo temporaneamente il Filtered per effettuare la Locate nell'intero Cds. Non porto tutto il blocco prima del Filter per non far "staccare" inutilmente un nuovo codice dirigente da RecuperoCodiceDirigente
      SoloObConv:=lstMatrDir.IndexOf(lstMatrDirSup[i]) < 0;
      if SoloObConv then
        CodDirSup:=RecuperoCodiceDirigente(selT030.FieldByName('PROGRESSIVO').AsInteger)
      else
        CodDirSup:=VarToStr(cdsAppoggio.Lookup('MATR_DIR',lstMatrDirSup[i],'COD_DIR'));
      cdsAppoggio.Filtered:=True;
      if CodDirSup <> '' then
      begin
        //Calcolare RAG_SCHEDA_VAL =’A’||Codice dirigente. Se esiste al 31/12/Anno-1, fine := 31/12/3999, altrimenti crearlo dal 01/01/Anno.
        CodProf:='A' + CodDirSup;
        CodProfStoricizzato:='N';
        if SoloObConv then //Se il dirigente ha anche obiettivi individuali, il codice del dato libero è già stato creato o aggiornato nel 1° ciclo
        begin
          DescProf:=Copy(Copy(CodProf,1,1) + '999 (comp.) + ' + CodProf + 'b (ob.str) ' + CapitalizeNominativo(Trim(selT030.FieldByName('COGNOME').AsString)) + ' ' + CapitalizeNominativo(Trim(selT030.FieldByName('NOME').AsString)),1,100);
          updI501b.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
          updI501b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
          updI501b.SetVariable('CodProf',CodProf);
          updI501b.SetVariable('DescProf',DescProf);
          updI501b.Execute;
          if updI501b.RowsProcessed = 0 then
          begin
            insI501.SetVariable('Tabella','I501' + Parametri.CampiRiferimento.C21_ValutazioniLiv1);
            insI501.SetVariable('CodProf',CodProf);
            insI501.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
            insI501.SetVariable('DescProf',DescProf);
            insI501.Execute;
            CodProfStoricizzato:='S';
          end;
        end;
        //Assegnare il RAG_SCHEDA_VAL in anagrafica dal 01/01/Anno in poi. Allineare il TIPO_SCHEDA_VAL.
        updT430.SetVariable('CampoRegole',Parametri.CampiRiferimento.C21_ValutazioniPnt1);
        updT430.SetVariable('CampoProfili',Parametri.CampiRiferimento.C21_ValutazioniLiv1);
        updT430.SetVariable('CodProf',CodProf);
        updT430.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        updT430.SetVariable('Progressivo',selT030.FieldByName('PROGRESSIVO').AsInteger);
        updT430.Execute; //la prima storicizzazione nell'anno è già stata effettuata dal scrT430
        //Creare o storicizzare dal 01/01/Anno l’area = RAG_SCHEDA_VAL||’b’ con peso = DECODE(matricola,Presente nel file in Matricola del dirigente,35,70). Per gli altri campi, vedi le immagini seguenti.
        CodArea:=CodProf + 'b';
        PercArea:=IfThen(SoloObConv,70,35);
        DescArea:=Copy('Grado di conseguimento medio degli obiettivi assegnati ai dirigenti sottordinati ' + FloatToStr(PercArea) + '% ' + CapitalizeNominativo(Trim(selT030.FieldByName('COGNOME').AsString)) + ' ' + CapitalizeNominativo(Trim(selT030.FieldByName('NOME').AsString)),1,100);
        updSG701b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        updSG701b.SetVariable('CodArea',CodArea);
        updSG701b.Execute;
        insSG701a.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        insSG701a.SetVariable('CodArea',CodArea);
        insSG701a.SetVariable('DescArea',DescArea);
        insSG701a.SetVariable('PercArea',PercArea);
        insSG701a.SetVariable('TipoLinkItem','1');
        insSG701a.Execute;
        //Creare elementi impostando: codice = LPAD(progressivo numerico nell’area,5,'0'), descrizione = Numero obiettivo dirigente 2° fascia, peso uniforme. Collegare gli obiettivi a quelli corrispondenti dell’area del dirigente di 2° fascia, in base al Numero obiettivo.
        PercItem:=R180Arrotonda(100 / cdsAppoggio.RecordCount,0.01,'P');
        DiffPercItem:=R180Arrotonda(100 - (cdsAppoggio.RecordCount * PercItem),0.01,'P');
        nDiffPercItem:=Abs(DiffPercItem / 0.01);
        cdsAppoggio.First;
        while not cdsAppoggio.Eof do
        begin
          insSG700.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
          insSG700.SetVariable('CodArea',CodArea);
          insSG700.SetVariable('CodItem',StringReplace(Format('%-5.5d',[cdsAppoggio.RecNo]),' ','0',[rfReplaceAll]));
          insSG700.SetVariable('DescItem',Copy('Obiettivo ' + cdsAppoggio.FieldByName('COD_ITEM').AsString + ' - ' + cdsAppoggio.FieldByName('COGNOME').AsString + ' ' + cdsAppoggio.FieldByName('NOME').AsString,1,500));
          insSG700.SetVariable('PercItem',PercItem + IfThen(cdsAppoggio.RecNo > (cdsAppoggio.RecordCount - nDiffPercItem),0.01 * IfThen(DiffPercItem < 0,-1,1)));
          insSG700.SetVariable('CodAreaLink','B' + cdsAppoggio.FieldByName('COD_DIR').AsString + 'a');
          insSG700.SetVariable('CodItemLink',StringReplace(Format('%-5.5d',[cdsAppoggio.FieldByName('COD_ITEM').AsInteger]),' ','0',[rfReplaceAll]));
          insSG700.Execute;
          cdsAppoggio.Next;
        end;
        cdsAppoggio.First;
        //Creare dal 01/01/Anno il profilo, o prolungarne la fine, associando il RAG_SCHEDA_VAL alla nuova area e all’area ’A999’ (eventualmente già profilata dal 1° ciclo).
        updSG720b.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        updSG720b.SetVariable('CodProf',CodProf);
        updSG720b.SetVariable('CodArea',CodArea);
        updSG720b.SetVariable('CodProfStoricizzato',CodProfStoricizzato);
        insSG720.SetVariable('InizioAnno',EncodeDate(AnnoImp,1,1));
        insSG720.SetVariable('CodProf',CodProf);
        insSG720.SetVariable('CodArea',CodArea);
        updSG720b.Execute;
        if updSG720b.RowsProcessed = 0 then
          insSG720.Execute;
        if SoloObConv then //Se il dirigente ha anche obiettivi individuali, il profilo è già stato creato o aggiornato nel 1° ciclo
        begin
          updSG720b.SetVariable('CodArea',Copy(CodArea,1,1) + '999');
          updSG720b.SetVariable('CodProfStoricizzato','N');
          insSG720.SetVariable('CodArea',Copy(CodArea,1,1) + '999');
          updSG720b.Execute;
          if updSG720b.RowsProcessed = 0 then
            insSG720.Execute;
        end;
      end;
    end;
    cdsAppoggio.Filtered:=False;
    if Assigned(evtAggiornaProgressBar) then
      evtAggiornaProgressBar;
  end;
end;

function TS720FProfiliAreeMW.RecuperoCodiceDirigente(Prog:Integer):String;
var nCodDir:Integer;
begin
  Result:='';
  //Cerco il codice del dirigente nel codice area dell'ultima scheda
  selSG711a.Close;
  selSG711a.SetVariable('Progressivo',Prog);
  selSG711a.SetVariable('DecMinNuoviCodici',EncodeDate(AnnoMinNuoviCodici,1,1));
  selSG711a.Open;
  if selSG711a.RecordCount > 1 then
    AddAnomalia(A000MSG_S720_ERR_COD_DIR_TROPPE_AREE,False,Prog)
  else
  begin
    nCodDir:=0;
    if selSG711a.RecordCount > 0 then
      TryStrToInt(selSG711a.FieldByName('COD_DIR').AsString,nCodDir);
    if nCodDir <= 0 then
    begin
      //Cerco il codice del dirigente nel RAG_SCHEDA_VAL della scheda anagrafica
      selT430.Close;
      selT430.SetVariable('Progressivo',Prog);
      selT430.SetVariable('DecMinNuoviCodici',EncodeDate(AnnoMinNuoviCodici,1,1));
      selT430.SetVariable('CampoProfili',Parametri.CampiRiferimento.C21_ValutazioniLiv1);
      selT430.Open;
      if selT430.RecordCount > 1 then
      begin
        AddAnomalia(A000MSG_S720_ERR_COD_DIR_TROPPI_VALORI,False,Prog);
        exit;
      end
      else if selT430.RecordCount > 0 then
        TryStrToInt(selT430.FieldByName('COD_DIR').AsString,nCodDir);
    end;
    //Se il codice non è numerico, ne creo uno nuovo
    if nCodDir <= 0 then
    begin
      inc(nMaxCodDir);
      nCodDir:=nMaxCodDir;
    end;
    if nCodDir >= 999 then
      AddAnomalia(A000MSG_S720_ERR_TROPPI_COD_DIR,False,Prog)
    else
      Result:=StringReplace(Format('%-3.3d',[nCodDir]),' ','0',[rfReplaceAll]);
  end;
end;

procedure TS720FProfiliAreeMW.AddAnomalia(Testo:String;bRiga:Boolean = False;nProg:Integer = 0);
begin
  RegistraMsg.InserisciMessaggio('A',IfThen(bRiga,'Riga: ' + IntToStr(nRiga) + '. ') + Testo,Parametri.Azienda,IfThen(nProg > 0,nProg,cdsAppoggio.FieldByName('PROGRESSIVO').AsInteger));
end;

function TS720FProfiliAreeMW.CapitalizeNominativo(Testo:String):String;
begin
  Result:='';
  while Pos(' ',Testo) > 0 do
  begin
    Result:=Result + R180Capitalize(Copy(Testo,1,Pos(' ',Testo)));
    Testo:=Copy(Testo,Pos(' ',Testo) + 1);
  end;
  Result:=Result + R180Capitalize(Testo);
end;

end.
