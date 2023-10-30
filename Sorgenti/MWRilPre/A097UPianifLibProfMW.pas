unit A097UPianifLibProfMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, DB, StrUtils, Oracle, Math, A000UInterfaccia,
  DatiBloccati, RegistrazioneLog,
  R005UDataModuleMW, A000UMessaggi, C180FunzioniGenerali, Winapi.ActiveX;

const
  A097_CODFISCALE = 'CODFISCALE';
  A097_DATA       = 'DATA';
  A097_DALLE      = 'DALLE';

type
  T097VisualizzaDipendente = procedure of object;

  TCampo = record
    CampoExcel,CampoDB:String;
    IdxExcel:Integer;
  end;

  TArrCampi = array of TCampo;

  TA097FPianifLibProfMW = class(TR005FDataModuleMW)
    Q310: TOracleDataSet;
    Q311: TOracleDataSet;
    selaT320: TOracleDataSet;
    Del320: TOracleQuery;
    Ins320: TOracleQuery;
    Q275: TOracleDataSet;
    selData: TOracleDataSet;
    insT315: TOracleQuery;
    delT320Key: TOracleQuery;
    selV010: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    selDatiBloccati:TDatiBloccati;
    Campo: TArrCampi;
    Excel,XLSheet: Variant;
    Progressivo: Integer;
    sCodFiscTroppiDip,sCodFiscNonTrov: String;
    function ControlloFestivo(P:Integer; D:TDateTime; pPianifFestivi: Boolean):Boolean;
    function GetIdxCampo(ID:String): Integer;
  public
    FRighe,FRiga,FColonne: Integer;
    selT320: TOracleDataSet;
    Dal,Al:TDateTime;
    PianifFestivi:Boolean;
    NomeFile:String;
    NRecImp:Integer;
    evtVisualizzaDipendente:T097VisualizzaDipendente;
    procedure RefreshSelT320;
    procedure selT320BeforeDelete;
    procedure selT320BeforePost;
    procedure selT320CalcFields;
    procedure selT320NewRecord;
    procedure selT320DALLEValidate(Sender: TField);
    procedure selT320CAUSALEValidate(Sender: TField);
    procedure GestionePianificazione(Prog:LongInt;Inserimento:Boolean);
    procedure ControlliImportazione;
    procedure ValorizzaVettoreCampi;
    procedure ImportaFile_Inizio1;
    procedure ImportaFile_Inizio2;
    procedure ImportaFile_Corpo;
    procedure ImportaFile_Fine;
  end;

implementation

{$R *.dfm}

uses
  ComObj;

procedure TA097FPianifLibProfMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='';
  Q310.Open;
  Q275.Open;
end;

procedure TA097FPianifLibProfMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selDatiBloccati);
end;

procedure TA097FPianifLibProfMW.RefreshSelT320;
begin
  selT320.Close;
  selT320.SetVariable('Progressivo',selAnagrafe.FieldByName('Progressivo').AsInteger);
  selT320.SetVariable('Data1',Dal);
  selT320.SetVariable('Data2',Al);
  selT320.ReadBuffer:=Trunc(Max(0,Al - Dal) + 1) * 2;
  selT320.Open;
end;

procedure TA097FPianifLibProfMW.selT320BeforeDelete;
begin
  if selDatiBloccati.DatoBloccato(selT320.FieldByName('PROGRESSIVO').AsInteger,selT320.FieldByName('DATA').AsDateTime,'T320') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);
end;

procedure TA097FPianifLibProfMW.selT320BeforePost;
begin
  if (selT320.FieldByName('DATA').AsDateTime < Dal)
  or (selT320.FieldByName('DATA').AsDateTime > Al) then
    raise exception.Create(A000MSG_A097_ERR_DATA_ESTERNA);
  if selDatiBloccati.DatoBloccato(selT320.FieldByName('PROGRESSIVO').AsInteger,selT320.FieldByName('DATA').AsDateTime,'T320') then
    raise Exception.Create(selDatiBloccati.MessaggioLog);

  selaT320.Close;
  selaT320.SetVariable('PROGRESSIVO',selT320.FieldByName('PROGRESSIVO').AsInteger);
  if selT320.State in [dsEdit] then
    selaT320.SetVariable('COND_ROWID',' and rowid <> ''' + selT320.RowId + ''' ')
  else
    selaT320.SetVariable('COND_ROWID','');
  selaT320.SetVariable('DATA',selT320.FieldByName('DATA').AsDateTime);
  selaT320.SetVariable('DALLE',selT320.FieldByName('DALLE').AsString);
  selaT320.SetVariable('ALLE',selT320.FieldByName('ALLE').AsString);
  selaT320.SetVariable('ALLE_CONTINUE',IfThen(R180OreMinutiExt(selT320.FieldByName('DALLE').AsString) > R180OreMinutiExt(selT320.FieldByName('ALLE').AsString),R180MinutiOre(R180OreMinutiExt(selT320.FieldByName('ALLE').AsString) + R180OreMinutiExt('24.00')),selT320.FieldByName('ALLE').AsString));
  selaT320.Open;
  if not selaT320.Eof then
    raise exception.Create(Format(A000MSG_A097_ERR_FMT_INTERSEZIONE,[selT320.FieldByName('DATA').AsString,
                                                                     selT320.FieldByName('Dalle').AsString,
                                                                     selT320.FieldByName('Alle').AsString,
                                                                     selaT320.FieldByName('DATA').AsString,
                                                                     selaT320.FieldByName('Dalle').AsString,
                                                                     selaT320.FieldByName('Alle').AsString]));
end;

procedure TA097FPianifLibProfMW.selT320CalcFields;
begin
  selT320.FieldByName('D_Giorno').AsString:=R180NomeGiorno(selT320.FieldByName('Data').AsDateTime);
end;

procedure TA097FPianifLibProfMW.selT320NewRecord;
begin
  selT320.FieldByName('Progressivo').AsInteger:=selAnagrafe.FieldByName('Progressivo').AsInteger;
end;

procedure TA097FPianifLibProfMW.selT320DALLEValidate(Sender: TField);
begin
  R180OraValidate(Sender.AsString);
end;

procedure TA097FPianifLibProfMW.selT320CAUSALEValidate(Sender: TField);
begin
  if Sender.IsNull or (Sender.Text = '') then
    exit;
  if not Q275.Locate('CODICE',Sender.AsString,[]) then
    raise Exception.Create(A000MSG_A097_ERR_CAUSALE_INESISTENTE);
end;

procedure TA097FPianifLibProfMW.GestionePianificazione(Prog:LongInt;Inserimento:Boolean);
var D:TDateTime;
    strFiltroGiorno: string;
begin
  selDatiBloccati.TipoLog:='F';
  try
    D:=Dal;
    while D <= Al do
    try
      if not ControlloFestivo(Prog,D,PianifFestivi) then
        Continue;     //giorno festivo e no check su "pianificazione giorni festivi"
      if selDatiBloccati.DatoBloccato(Prog,D,'T320') then
        Continue;

      strFiltroGiorno:=IntToStr(DayOfWeek(D - 1)); //GIORNI FERIALI
      if not ControlloFestivo(Prog,D,False) and Q311.SearchRecord('GIORNO','FS',[srFromBeginning]) then
        strFiltroGiorno:='FS'; //GIORNI FESTIVI

      if Q311.SearchRecord('GIORNO',strFiltroGiorno,[srFromBeginning]) then
      repeat
        if Inserimento then
        begin
          selaT320.Close;
          selaT320.SetVariable('PROGRESSIVO',Prog);
          selaT320.SetVariable('COND_ROWID','');
          selaT320.SetVariable('DATA',D);
          selaT320.SetVariable('DALLE',Q311.FieldByName('Dalle').AsString);
          selaT320.SetVariable('ALLE',Q311.FieldByName('Alle').AsString);
          selaT320.SetVariable('ALLE_CONTINUE',IfThen(R180OreMinutiExt(Q311.FieldByName('DALLE').AsString) > R180OreMinutiExt(Q311.FieldByName('ALLE').AsString),R180MinutiOre(R180OreMinutiExt(Q311.FieldByName('ALLE').AsString) + R180OreMinutiExt('24.00')),Q311.FieldByName('ALLE').AsString));
          selaT320.Open;
          if not selaT320.Eof then
            RegistraMsg.InserisciMessaggio('A','Nel giorno ' + DateToStr(D) + ' la pianificazione ' + Q311.FieldByName('Dalle').AsString + '-' + Q311.FieldByName('Alle').AsString + ' ne interseca una già esistente (' + selaT320.FieldByName('DATA').AsString + ' ' + selaT320.FieldByName('Dalle').AsString + '-' + selaT320.FieldByName('Alle').AsString + ')!','',Prog)
          else
            try
              Ins320.SetVariable('Progressivo',Prog);
              Ins320.SetVariable('Data',D);
              Ins320.SetVariable('Causale',Q311.FieldByName('Causale').AsString);
              Ins320.SetVariable('Dalle',Q311.FieldByName('Dalle').AsString);
              Ins320.SetVariable('Alle',Q311.FieldByName('Alle').AsString);
              Ins320.Execute;
              RegistraLog.SettaProprieta('I','T320_PIANLIBPROFESSIONE',NomeOwner,nil,True);
              RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(Prog));
              RegistraLog.InserisciDato('DAL - AL','',Format('%s - %s',[DateToStr(Dal),DateToStr(Al)]));
              RegistraLog.RegistraOperazione;
            except
            end;
        end
        else
        begin
          try
            Del320.SetVariable('Progressivo',Prog);
            Del320.SetVariable('Data',D);
            Del320.SetVariable('Dalle',Q311.FieldByName('Dalle').AsString);
            Del320.SetVariable('Alle',Q311.FieldByName('Alle').AsString);
            Del320.Execute;
            RegistraLog.SettaProprieta('C','T320_PIANLIBPROFESSIONE',NomeOwner,nil,True);
            RegistraLog.InserisciDato('PROGRESSIVO',IntToStr(Prog),'');
            RegistraLog.InserisciDato('DAL - AL',Format('%s - %s',[DateToStr(Dal),DateToStr(Al)]),'');
            RegistraLog.RegistraOperazione;
          except
          end;
        end;
      until not Q311.SearchRecord('GIORNO',strFiltroGiorno,[]);

    finally
      D:=D + 1;
    end;
  finally
    SessioneOracle.Commit;
    selDatiBloccati.TipoLog:='';
  end;
end;

function  TA097FPianifLibProfMW.ControlloFestivo(P:Integer; D:TDateTime; pPianifFestivi: Boolean):Boolean;
{Restituisce True se i Festivi sono abilitati, oppure se il giorno non è festivo}
begin
  Result:=pPianifFestivi;
  if not Result then
    with selV010 do
    begin
      R180SetVariable(selV010,'PROGRESSIVO',P);
      R180SetVariable(selV010,'DAL',Dal);
      R180SetVariable(selV010,'AL',Al);
      Open;
      Result:=VarToStr(Lookup('DATA',D,'FESTIVO')) <> 'S';
    end;
end;

procedure TA097FPianifLibProfMW.ControlliImportazione;
begin
  if Dal > Al then
    raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if NomeFile = '' then
    raise Exception.Create(A000MSG_ERR_SPEC_NOME_FILE_IMP);
  if not FileExists(NomeFile) then
    raise exception.Create(A000MSG_ERR_FILE_INESISTENTE_IMP);
  if not R180In(LowerCase(R180EstraiExtFile(NomeFile)),['xls','xlsx']) then
    raise exception.Create(A000MSG_ERR_EXT_FILE_EXPO_XLS);
end;

procedure TA097FPianifLibProfMW.ValorizzaVettoreCampi;
var
  Colonna,Foglio,i: Integer;
begin
  {$IFDEF IRISWEB}
  if (not IsLibrary) then
    CoInitialize(nil);
  {$ENDIF}
  Excel:=CreateOleObject('Excel.Application');
  try
    //inizializzazione variabili
    Excel.Visible:=False;
    Foglio:=1;
    //apertura excel al path designato, foglio 1
    Excel.WorkBooks.Open(NomeFile);
    XLSheet:=Excel.Worksheets[Foglio];
    //calcolo del numero di colonne e righe totali
    FColonne:=XLSheet.UsedRange.Columns.Count;
    //calcolo del numero di righe totali
    FRighe:=XLSheet.UsedRange.Rows.Count;
    //reperimento colonne da usare
    SetLength(Campo,0);
    for i:=0 to 2 do
    begin
      SetLength(Campo,Length(Campo) + 1);
      case i of
        0:begin
            Campo[High(Campo)].CampoExcel:='PF_CFIS';
            Campo[High(Campo)].CampoDB:=A097_CODFISCALE;
          end;
        1:begin
            Campo[High(Campo)].CampoExcel:='DATA_APP';
            Campo[High(Campo)].CampoDB:=A097_DATA;
          end;
        2:begin
            Campo[High(Campo)].CampoExcel:='ORA_APP';
            Campo[High(Campo)].CampoDB:=A097_DALLE;
          end;
      end;
      Campo[High(Campo)].IdxExcel:=-1;
      FRiga:=1;
      for Colonna:=1 to FColonne do
        if VarToStr(Excel.Cells[FRiga,Colonna].Value).Trim = Campo[High(Campo)].CampoExcel then
        begin
          Campo[High(Campo)].IdxExcel:=Colonna;
          Break;
        end;
      if Campo[High(Campo)].IdxExcel = -1 then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A097_ERR_IMP_COLONNA_NON_TROV,[Campo[High(Campo)].CampoExcel,Campo[High(Campo)].CampoDB]),'');
    end;
  finally
    //pulizia oggetti excel
    Excel.Workbooks.Close;
    Excel.Quit;
    Excel:=Unassigned;
  end;
end;

procedure TA097FPianifLibProfMW.ImportaFile_Inizio1;
begin
  sCodFiscTroppiDip:='';
  sCodFiscNonTrov:='';
  Progressivo:=-1;
  //creazione dell'oggetto di interfaccia con excel
  Excel:=CreateOleObject('Excel.Application');
end;

procedure TA097FPianifLibProfMW.ImportaFile_Inizio2;
var Foglio: Integer;
begin
  //inizializzazione variabili
  Excel.Visible:=False;
  Foglio:=1;
  //apertura excel al path designato, foglio 1
  Excel.WorkBooks.Open(NomeFile);
  XLSheet:=Excel.Worksheets[Foglio];
end;

procedure TA097FPianifLibProfMW.ImportaFile_Corpo;
var
  CodFiscale,sData,Dalle: String;
  Data: TDateTime;
  c: Integer;
  LNome: string;
  LValore: string;
begin
  //recupero valori campi
  CodFiscale:=UpperCase(VarToStr(Excel.Cells[FRiga,Campo[GetIdxCampo(A097_CODFISCALE)].IdxExcel].Value).Trim);
  sData:=VarToStr(Excel.Cells[FRiga,Campo[GetIdxCampo(A097_DATA)].IdxExcel].Value).Trim;
  Dalle:=VarToStr(Excel.Cells[FRiga,Campo[GetIdxCampo(A097_DALLE)].IdxExcel].Value).Trim.Replace(':','.');
  //recupero il dipendente
  if CodFiscale = '' then
  begin
    //RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A097_ERR_IMP_DATO_VUOTO,[IntToStr(Riga),Campo[GetIdxCampo(A097_CODFISCALE)].CampoExcel,Campo[GetIdxCampo(A097_CODFISCALE)].CampoDB]),'');
    Exit;
  end
  else if R180InConcat(CodFiscale,sCodFiscTroppiDip) or R180InConcat(CodFiscale,sCodFiscNonTrov) then
    Exit
  else if (CodFiscale <> SelAnagrafe.FieldByName('CODFISCALE').AsString) or (Progressivo = -1) then
  begin
    if SelAnagrafe.SearchRecord('CODFISCALE',CodFiscale,[srFromBeginning]) then
    begin
      Progressivo:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
      if SelAnagrafe.SearchRecord('CODFISCALE',CodFiscale,[]) then
      begin
        if not R180InConcat(CodFiscale,sCodFiscTroppiDip) then
          sCodFiscTroppiDip:=sCodFiscTroppiDip + IfThen(sCodFiscTroppiDip <> '',',') + CodFiscale;
        Exit;
      end
      else if Assigned(evtVisualizzaDipendente) then
        evtVisualizzaDipendente;
    end
    else
    begin
      if not R180InConcat(CodFiscale,sCodFiscNonTrov) then
        sCodFiscNonTrov:=sCodFiscNonTrov + IfThen(sCodFiscNonTrov <> '',',') + CodFiscale;
      Exit;
    end;
  end;
  //recupero la data
  if sData = '' then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A097_ERR_IMP_DATO_VUOTO,[IntToStr(FRiga),Campo[GetIdxCampo(A097_DATA)].CampoExcel,Campo[GetIdxCampo(A097_DATA)].CampoDB]),'',Progressivo);
    Exit;
  end
  else
    try
      R180SetVariable(selData,'DATA',sData);
      selData.Open;
      Data:=selData.FieldByName('DATA').AsDateTime;
    except
      on E:Exception do
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A097_ERR_IMP_DATA_NON_VALIDA,[IntToStr(FRiga),sData,Campo[GetIdxCampo(A097_DATA)].CampoExcel,Campo[GetIdxCampo(A097_DATA)].CampoDB]),'',Progressivo);
        Exit;
      end;
    end;
  //controllo periodo
  if (Data < Dal) or (Data > Al) then
  begin
    RegistraMsg.InserisciMessaggio('A',Format('Riga %s: Data %s esterna al periodo di importazione! Attività non importata!',[IntToStr(FRiga),DateToStr(Data)]),'',Progressivo);
    Exit;
  end;
  //recupero l'ora
  if Dalle = '' then
  begin
    RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A097_ERR_IMP_DATO_VUOTO,[IntToStr(FRiga),Campo[GetIdxCampo(A097_DALLE)].CampoExcel,Campo[GetIdxCampo(A097_DALLE)].CampoDB]),'',Progressivo);
    Exit;
  end
  else
    try
      R180OraValidate(Dalle);
    except
      on E:Exception do
      begin
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A097_ERR_IMP_ORA_NON_VALIDA,[IntToStr(FRiga),Dalle,Campo[GetIdxCampo(A097_DALLE)].CampoExcel,Campo[GetIdxCampo(A097_DALLE)].CampoDB]),'',Progressivo);
        Exit;
      end;
    end;

  // IMPORTANTE: nessuna operazione viene committata in questo metodo
  //inserimento su tabella
  try
    // elimina eventuale record pianificazione già presente (in cascade elimina anche info su T315)
    delT320Key.ClearVariables;
    delT320Key.SetVariable('PROGRESSIVO',Progressivo);
    delT320Key.SetVariable('DATA',Data);
    delT320Key.SetVariable('DALLE',Dalle);
    delT320Key.Execute;

    // inserisce record di pianificazione privo di causale e di ora fine
    ins320.ClearVariables;
    ins320.SetVariable('PROGRESSIVO',Progressivo);
    ins320.SetVariable('DATA',Data);
    ins320.SetVariable('DALLE',Dalle);
    ins320.Execute;
    inc(NRecImp);

    // recupera i valori di ogni colonna e li salva sulla tabella T315
    for c:=1 to FColonne do
    begin
      LNome:=VarToStr(Excel.Cells[1,c].Value).Trim;
      LValore:=VarToStr(Excel.Cells[FRiga,c].Value).Trim;

      // inserisce record con informazioni per il singolo valore
      insT315.ClearVariables;
      insT315.SetVariable('PROGRESSIVO',Progressivo);
      insT315.SetVariable('DATA',Data);
      insT315.SetVariable('DALLE',Dalle);
      insT315.SetVariable('NOME',LNome);
      insT315.SetVariable('VALORE',LValore);
      insT315.Execute;
    end;
  except
    on E: EOracleError do
    begin
      //if E.ErrorCode <> 1 then
        RegistraMsg.InserisciMessaggio('A',Format('Riga %s: Importazione fallita! Data %s; Dalle: %s; %s',[IntToStr(FRiga),DateToStr(Data),Dalle,E.Message]),'',Progressivo);
    end;
  end;
end;

procedure TA097FPianifLibProfMW.ImportaFile_Fine;
var i: Integer;
    Lista:TStringList;
begin
  SessioneOracle.Commit;
  //segnalo i codici fiscali associati a più dipendenti
  if sCodFiscTroppiDip <> '' then
  begin
    RegistraMsg.InserisciMessaggio('A','Attività non importate per i seguenti codici fiscali associati a più dipendenti nella selezione anagrafica:','');
    Lista:=TStringList.Create;
    try
      Lista.CommaText:=sCodFiscTroppiDip;
      Lista.Sort;
      for i:=0 to Lista.Count - 1 do
        RegistraMsg.InserisciMessaggio('A','  ' + Lista[i],'');
    finally
      Lista.Free;
    end;
  end;
  //segnalo i codici fiscali non presenti nella selezione
  if sCodFiscNonTrov <> '' then
  begin
    RegistraMsg.InserisciMessaggio('A','Attività non importate per i seguenti codici fiscali non presenti nella selezione anagrafica:','');
    Lista:=TStringList.Create;
    try
      Lista.CommaText:=sCodFiscNonTrov;
      Lista.Sort;
      for i:=0 to Lista.Count - 1 do
        RegistraMsg.InserisciMessaggio('A','  ' + Lista[i],'');
    finally
      Lista.Free;
    end;
  end;
  //pulizia oggetti excel
  if VarToStr(Excel) <> '' then
  begin
    try Excel.Workbooks.Close; except end;
    try Excel.Quit; except end;
    Excel:=Unassigned;
  end;
end;

function TA097FPianifLibProfMW.GetIdxCampo(ID:String): Integer;
var i: Integer;
begin
  Result:=-1;
  for i:=0 to High(Campo) do
    if Campo[i].CampoDB = ID then
    begin
      Result:=i;
      Break;
    end;
end;

end.
