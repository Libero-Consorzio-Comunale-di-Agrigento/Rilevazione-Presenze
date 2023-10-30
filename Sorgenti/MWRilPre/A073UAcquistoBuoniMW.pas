unit A073UAcquistoBuoniMW;

interface

uses
  Windows, Messages, SysUtils,StrUtils,Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, DB, DBClient, A000UInterfaccia, C180FunzioniGenerali,
  DatiBloccati,R005UDataModuleMW, R350UCalcoloBuoniDtM, C004UParamForm,
  Winapi.ActiveX, A000UCostanti, System.Win.ComObj, System.IOUtils,
  FireDAC.Comp.BatchMove, FireDAC.Comp.BatchMove.DataSet, FireDAC.Stan.Intf,
  FireDAC.Comp.BatchMove.Text, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI;

type
  TTipoImportazioneRec = record
  const
    Buoni  = 'B';
    Ticket = 'T';
  end;

  TTipoFileRec = record
  const
    CSV  = 'csv';
    XLS = 'xls';
  end;

  TOpzioniImportazione = record
    FileName: string;
    TipoFile:String; //csv, xls
    RigaIntestazione: Boolean;
    TipoImportazione: string;
    ColMatricola: Integer;
    ColCodFiscale: Integer;
    ColDataAcquisto: Integer;
    ColQuantita: Integer;
    procedure Clear; inline;
  end;

  TStatisticheImportazione = record
    DipendentiNonTrovati: Integer;
    AnomalieDati: Integer;
    Inseriti: Integer;
    Aggiornati: Integer;
    ErroriImportazione: Integer;
    ErroriImprevisti: Integer;
    Totali: Integer;
    procedure Clear; inline;
  end;

  TInfoRiga = record
    Matricola: string;
    CodFiscale: string;
    DataAcquisto: TDateTime;
    Quantita: Integer;
    procedure Clear; inline;
  end;

  TA073FAcquistoBuoniMW = class(TR005FDataModuleMW)
    BuoniPasto: TClientDataSet;
    selT680: TOracleDataSet;
    selT690: TOracleDataSet;
    selT691: TOracleDataSet;
    selT690DataInizio: TOracleDataSet;
    selT690_IDBLOCCHETTI: TOracleDataSet;
    cdsMappaturaExcel: TClientDataSet;
    cdsMappaturaExcelDATO: TStringField;
    cdsMappaturaExcelCOLONNA: TIntegerField;
    selT690Import: TOracleDataSet;
    txtRdrCsv: TFDBatchMoveTextReader;
    mvDtstWrCsv: TFDBatchMoveDataSetWriter;
    bMvCsv: TFDBatchMove;
    cdsLetturaCsv: TClientDataSet;
    WtCrsr: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsMappaturaExcelBeforeDelete(DataSet: TDataSet);
    procedure cdsMappaturaExcelBeforeInsert(DataSet: TDataSet);
  private
    FC004: TC004FParamForm;
    function  ControllaBlocchettiParziali:String;
    procedure GetMaturazione;
    procedure GetAcquisto;
    procedure CreaBuoniPasto;
    procedure SalvaParametriImportazione;
    procedure LeggiFileCsv(nomeFile: String);
    procedure inizializzaImportazione;
  public
    BuoniPastoMaturati, Messaggio, TicketMaturati, BuoniPastoAcquistati, TicketAcquistati: String;
    Anomalie:boolean;
    Progressivo:LongInt;
    FOpzioni: TOpzioniImportazione;
    Q690: TOracleDataSet;
    selDatiBloccati:TDatiBloccati;
    Inizio,Fine,DataA:TDateTime;
    R350FCalcoloBuoniDtM:TR350FCalcoloBuoniDtM;
    procedure InizializzaQ690;
    procedure CalcolaRiepilogo;
    procedure CreaBuoniPastoCDS;
    procedure Q690AfterPost;
    function  Q690BeforePost:String;
    procedure Q690DATAValidate(Sender: TField);
    procedure Q690ID_BLOCCHETTIValidate(Sender: TField);
    procedure PreparaImportazione(PDataSource: TDataSource);
    function VerificaOpzioniImportazione: TResCtrl;
    function LeggiInfoFile:Integer;
    procedure EseguiImportazione;
    property C004: TC004FParamForm read FC004;
  end;

const
  A073_OPT_FILENAME          = 'FILE';
  A073_OPT_TIPO_FILE         = 'TIPO_FILE';
  A073_OPT_RIGA_INTESTAZIONE = 'RIGA_INTESTAZIONE';
  A073_OPT_TIPO_IMPORTAZIONE = 'TIPO_IMPORTAZIONE';

  EXCEL_DATO_MATRICOLA     = 'MATRICOLA';
  EXCEL_DATO_CODFISCALE    = 'CODFISCALE';
  EXCEL_DATO_DATA_ACQUISTO = 'DATA_ACQUISTO';
  EXCEL_DATO_QUANTITA      = 'QUANTITA';

  EXCEL_DATI_IMPORT: TArray<String> = [
    EXCEL_DATO_MATRICOLA,
    EXCEL_DATO_CODFISCALE,
    EXCEL_DATO_DATA_ACQUISTO,
    EXCEL_DATO_QUANTITA
  ];
  C004_COLONNA_FMT = 'COL_%s';


implementation

{$R *.dfm}

procedure TA073FAcquistoBuoniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  selDatiBloccati.TipoLog:='M';
  selT691.Open;
  R350FCalcoloBuoniDtM:=TR350FCalcoloBuoniDtM.Create(nil);
end;

procedure TA073FAcquistoBuoniMW.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(FC004) then
    FreeAndNil(FC004);
  FreeAndNil(selDatiBloccati);
  FreeAndNil(R350FCalcoloBuoniDtM);

  inherited;
end;

procedure TA073FAcquistoBuoniMW.InizializzaQ690;
begin
  Q690.FieldByName('DATA_MAGAZZINO').Visible:=selT691.RecordCount > 0;
  Q690.FieldByName('ID_BLOCCHETTI').Visible:=False;
  while not selT691.Eof do
  begin
    if (not selT691.FieldByName('ID_DAL').IsNull) and (not selT691.FieldByName('ID_AL').IsNull) then
    begin
      Q690.FieldByName('ID_BLOCCHETTI').Visible:=True;
      Break;
    end;
    selT691.Next;
  end;
end;

procedure TA073FAcquistoBuoniMW.Q690AfterPost;
var D:TDateTime;
begin
  D:=Q690.FieldByName('Data').AsDateTime;
  Q690.Refresh;
  Q690.Locate('Data',D,[]);
end;

function TA073FAcquistoBuoniMW.Q690BeforePost:String;
var DS:TDateTime;
begin
  if (not Q690.FieldByName('DATA_MAGAZZINO').IsNull) then
  begin
    DS:=selT691.Lookup('DATA_ACQUISTO',Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,'DATA_SCADENZA');
    DS:=IfThen(DS = EncodeDate(1900,12,30),EncodeDate(3999,12,31),DS);
    if not R180Between(Q690.FieldByName('DATA').AsDateTime,Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,DS) then
      raise Exception.Create(Format('La data di acquisto deve essere compresa tra il %s e il %s!',[Q690.FieldByName('DATA_MAGAZZINO').AsString,DateToStr(DS)]));
  end;
  Q690ID_BLOCCHETTIValidate(Q690.FieldByName('ID_BLOCCHETTI'));
  if Q690.FieldByName('ID_BLOCCHETTI').IsNull and Q690.FieldByName('ID_BLOCCHETTI').Required then
    raise Exception.Create('Indicare un elenco valido di blocchetti!');
  Result:=ControllaBlocchettiParziali;
end;

procedure TA073FAcquistoBuoniMW.Q690DATAValidate(Sender: TField);
begin
  if (Q690.FieldByName('DATA_MAGAZZINO').IsNull) and (selT691.RecordCount > 0) then
  begin
    //selT691.Last;
    selT691.First;
    //while not selT691.Bof do
    while not selT691.Eof do
    begin
      if R180Between(Q690.FieldByName('DATA').AsDateTime,
                     selT691.FieldByName('DATA_ACQUISTO').AsDateTime,
                     IfThen(selT691.FieldByName('DATA_SCADENZA').IsNull,EncodeDate(3999,12,31),selT691.FieldByName('DATA_SCADENZA').AsDateTime))
      then
      begin
        Q690.FieldByName('DATA_MAGAZZINO').AsDateTime:=selT691.FieldByName('DATA_ACQUISTO').AsDateTime;
        Break;
      end
      else
        //selT691.Prior;
        selT691.Next;
    end;
  end;
end;

procedure TA073FAcquistoBuoniMW.Q690ID_BLOCCHETTIValidate(Sender: TField);
var lst:TStringList;
    i,j,id:Integer;
    Trovato:Boolean;
    Campo:String;
begin
  if (not Q690.FieldByName('ID_BLOCCHETTI').IsNull) and
     (Q690.FieldByName('ID_BLOCCHETTI').AsString <> '*') then
  begin
    lst:=TStringList.Create;
    try
      lst.CommaText:=Q690.FieldByName('ID_BLOCCHETTI').AsString;
      for i:=0 to lst.Count - 1 do
        if not TryStrToInt(Trim(lst[i]),id) then
          raise Exception.Create('Blocchetto non valido! Il dato deve essere numerico.')
        else
        begin
          if (not Q690.FieldByName('DATA_MAGAZZINO').IsNull) and (not selT691.SearchRecord('DATA_ACQUISTO',Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,[srFromBeginning])) then
            raise Exception.Create('Fornitura non presente in magazzino!');
          Trovato:=Q690.FieldByName('DATA_MAGAZZINO').IsNull;
          if not Trovato then
            Trovato:=R180Between(id,selT691.FieldByName('ID_DAL').AsInteger,selT691.FieldByName('ID_AL').AsInteger);
          if not Trovato then
            raise Exception.Create(Format('Blocchetto %d non presente nella fornitura del %s (%d - %d)',[id,Q690.FieldByName('DATA_MAGAZZINO').AsString,selT691.FieldByName('ID_DAL').AsInteger,selT691.FieldByName('ID_AL').AsInteger]));
          for j:=i + 1 to lst.Count - 1 do
            if Trim(lst[i]) = Trim(lst[j]) then
              raise Exception.Create(Format('Blocchetto %d ripetuto!',[id]));
        end;
      if not Q690.FieldByName('DATA_MAGAZZINO').IsNull and (selT691.FieldByName('DIM_BLOCCHETTO').AsInteger > 0) then
      begin
        if selT691.FieldByName('BUONIPASTO').AsInteger > 0 then
          Campo:='BUONIPASTO'
        else
          Campo:='TICKET';
        if Q690.FieldByName(Campo).IsNull then
          Q690.FieldByName(Campo).AsInteger:=lst.Count * selT691.FieldByName('DIM_BLOCCHETTO').AsInteger;
      end;
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TA073FAcquistoBuoniMW.cdsMappaturaExcelBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;

procedure TA073FAcquistoBuoniMW.cdsMappaturaExcelBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

function TA073FAcquistoBuoniMW.ControllaBlocchettiParziali:String;
var lst,lst2:TStringList;
    i,j,id,TotBuoni,TotBlocc:Integer;
    Campo,s,IdRighe:String;
begin
  Result:='';
  if not Q690.FieldByName('ID_BLOCCHETTI').IsNull then
  begin
    lst:=TStringList.Create;
    lst2:=TStringList.Create;
    IdRighe:='';
    TotBuoni:=0;
    try
      lst.CommaText:=Q690.FieldByName('ID_BLOCCHETTI').AsString;
      if (not Q690.FieldByName('DATA_MAGAZZINO').IsNull) and
         (selT691.SearchRecord('DATA_ACQUISTO',Q690.FieldByName('DATA_MAGAZZINO').AsDateTime,[srFromBeginning])) and
         (selT691.FieldByName('DIM_BLOCCHETTO').AsInteger > 0) then
      begin
        if selT691.FieldByName('BUONIPASTO').AsInteger > 0 then
          Campo:='BUONIPASTO'
        else
          Campo:='TICKET';
        lst2.Assign(lst);
        TotBuoni:=Q690.FieldByName(Campo).AsInteger;
      end;
      for i:=0 to lst.Count - 1 do
        if TryStrToInt(Trim(lst[i]),id) then
        begin
          selT690_IDBLOCCHETTI.Close;
          selT690_IDBLOCCHETTI.SetVariable('IDRIGA',IfThen(Q690.State = dsEdit,Q690.RowID,''));
          selT690_IDBLOCCHETTI.SetVariable('ID_BLOCCHETTO',IntToStr(id));
          selT690_IDBLOCCHETTI.Open;
          if selT690_IDBLOCCHETTI.RecordCount > 0 then
          begin
            s:='';
            while not selT690_IDBLOCCHETTI.Eof do
            begin
              s:=s + #13#10 + Format('%s %s (matricola %s) il %s - acquisto complessivo: %d',
                                     [selT690_IDBLOCCHETTI.FieldByName('COGNOME').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('NOME').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('MATRICOLA').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('DATA').AsString,
                                      selT690_IDBLOCCHETTI.FieldByName('BUONIPASTO').AsInteger + selT690_IDBLOCCHETTI.FieldByName('TICKET').AsInteger]);
              selT690_IDBLOCCHETTI.Next;
            end;
            Result:=Result + #13#10 + Format('Blocchetto %d già acquistato da:' + s + #13#10,[id]);

            selT690_IDBLOCCHETTI.First;
            while not selT690_IDBLOCCHETTI.Eof do
            begin
              if Pos(selT690_IDBLOCCHETTI.RowID,IdRighe) = 0 then
              begin
                IdRighe:=IdRighe + ',' + selT690_IDBLOCCHETTI.RowID;
                inc(TotBuoni,selT690_IDBLOCCHETTI.FieldByName(Campo).AsInteger);
                with TStringList.Create do
                try
                  CommaText:=Trim(selT690_IDBLOCCHETTI.FieldByName('ID_BLOCCHETTI').AsString);
                  for j:=0 to Count - 1 do
                    if lst2.IndexOf(Strings[j]) = -1 then
                      lst2.Add(Strings[j]);
                finally
                  Free;
                end;
              end;
              selT690_IDBLOCCHETTI.Next;
            end;
          end;
        end;
      TotBlocc:=lst2.Count;
      if TotBuoni > TotBlocc * selT691.FieldByName('DIM_BLOCCHETTO').AsInteger then
        raise Exception.Create(Format('Attenzione: risulta un''eccedenza di numero %d buoni acquistati rispetto a quelli disponibili.',[TotBuoni - TotBlocc * selT691.FieldByName('DIM_BLOCCHETTO').AsInteger]));
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TA073FAcquistoBuoniMW.CalcolaRiepilogo;
begin
  R350FCalcoloBuoniDtM.R502ProDtM1.PeriodoConteggi(Inizio,Fine);
  GetMaturazione;
  GetAcquisto;
end;

procedure TA073FAcquistoBuoniMW.GetAcquisto;
begin
  BuoniPastoAcquistati:='0';
  TicketAcquistati:='0';
  with R350FCalcoloBuoniDtM.Q690 do
  begin
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA1',Inizio);
    SetVariable('DATA2',Fine);
    Execute;
    BuoniPastoAcquistati:=VarToStr(GetVariable('BUONI'));
    TicketAcquistati:=VarToStr(GetVariable('TICKET'));
  end;
  with R350FCalcoloBuoniDtM.Q692 do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    SetVariable('DATA',Fine);
    Open;
    if RecordCount > 0 then
    begin
      if FieldByName('BUONIPASTO').AsInteger <> 0 then
        BuoniPastoAcquistati:=BuoniPastoAcquistati + Format(' (%d)',[FieldByName('BUONIPASTO').AsInteger]);
      if FieldByName('TICKET').AsInteger <> 0 then
        TicketAcquistati:=TicketAcquistati + Format(' (%d)',[FieldByName('TICKET').AsInteger]);
    end;
  end;
end;

procedure TA073FAcquistoBuoniMW.GetMaturazione;
var DI,DF,DataCorr:TDateTime;
    NB,NT,B,T,i,j:Integer;
    A1,A2,M1,M2,G:Word;
    S:String;
begin
  DI:=Inizio;
  DF:=Fine;
  with R350FCalcoloBuoniDtM.selPeriodoServizio do
  begin
    Close;
    SetVariable('PROGRESSIVO',Progressivo);
    //SetVariable('DATAINIZIO',Inizio);
    SetVariable('DATAFINE',Fine);
    Open;
    if FieldByName('INIZIO').AsDateTime > DI then
      DI:=FieldByName('INIZIO').AsDateTime;
    if FieldByName('FINE').AsDateTime < DF then
      DF:=FieldByName('FINE').AsDateTime;
    Close;
  end;
  Anomalie:=False;
  BuoniPastoMaturati:='0';
  TicketMaturati:='0';
  NB:=0;
  NT:=0;
  R350FCalcoloBuoniDtM.QSBuonoMensa.GetDatiStorici('T430' + Parametri.CampiRiferimento.C4_BuoniMensa,Progressivo,DI,DF);
  DataCorr:=DI;
  while DataCorr <= DF do
  begin
    R350FCalcoloBuoniDtM.CalcolaBuoni(Progressivo,DataCorr,B,T,S);
    if S <> '' then
      Anomalie:=True;
    inc(NB,B);
    inc(NT,T);
    DataCorr:=DataCorr + 1;
  end;
  BuoniPastoMaturati:=IntToStr(NB);
  TicketMaturati:=IntToStr(NT);
  //Lettura variazioni manuali
  NB:=0;
  NT:=0;
  DecodeDate(DI,A1,M1,G);
  if G > 1 then
  begin
    M1:=M1 + 1;
    if M1 = 13 then
    begin
      M1:=1;
      inc(A1);
    end;
  end;
  DecodeDate(DF,A2,M2,G);
  if G < R180GiorniMese(DF) then
  begin
    M2:=M2 - 1;
    if M2 = 0 then
    begin
      M2:=12;
      dec(A2);
    end;
  end;
  j:=M1;
  for i:=A1 to A2 do
    while True do
    begin
      if (i = A2) and (j > M2) then
        Break;
      R350FCalcoloBuoniDtM.GetVariazioni(Progressivo,i,j,B,T);
      inc(NB,B);
      inc(NT,T);
      inc(j);
      if j = 13 then
      begin
        j:=1;
        Break;
      end;
    end;
  if NB <> 0 then
  begin
    S:=IntToStr(NB);
    if NB > 0 then S:='+' + S;
    BuoniPastoMaturati:=BuoniPastoMaturati + '(' + S + ')';
  end;
  if NT <> 0 then
  begin
    S:=IntToStr(NT);
    if NT > 0 then S:='+' + S;
    TicketMaturati:=TicketMaturati + '(' + S + ')';
  end;
end;

procedure TA073FAcquistoBuoniMW.CreaBuoniPastoCDS;
var BuoniResidui,BuoniScaduti,BuoniUsati,BuoniAcquistati:Integer;
    OldData:TDateTime;
begin
  CreaBuoniPasto;
  OldData:=0;
  SelAnagrafe.First;
  while not SelAnagrafe.EOF do
  begin
    selT690DataInizio.Close;
    selT690DataInizio.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    selT690DataInizio.SetVariable('DATA',DataA);
    selT690DataInizio.Open;
    selT680.Close;
    selT680.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    selT680.SetVariable('DATADAL',selT690DataInizio.FieldByName('DATA').AsDateTime);
    selT680.SetVariable('DATAAL',DataA);
    selT680.Open;
    selT690.Close;
    selT690.SetVariable('PROGRESSIVO',SelAnagrafe.FieldByName('Progressivo').AsInteger);
    selT690.SetVariable('DATA',DataA);
    selT690.Open;
    BuoniUsati:=0;
    BuoniScaduti:=0;
    BuoniAcquistati:=0;
    BuoniResidui:=0;
    while not selT680.Eof do
    begin
      BuoniUsati:=BuoniUsati + selT680.FieldByName('BUONIPASTO').AsInteger;
      while not selT690.Eof do
      begin
        if (selT680.FieldByName('DATA').AsDateTime <= OldData) then
        begin
          if BuoniResidui >= selT680.FieldByName('BUONIPASTO').AsInteger then
            break;
        end
        else
        begin
          BuoniScaduti:=BuoniScaduti + BuoniResidui;
          BuoniResidui:=0;
        end;
        OldData:=selT690.FieldByName('DATA_SCADENZA').AsDateTime;
        BuoniResidui:=BuoniResidui + selT690.FieldByName('BUONIPASTO').AsInteger;
        BuoniAcquistati:=BuoniAcquistati + selT690.FieldByName('BUONIPASTO').AsInteger;
        selT690.Next;
      end;
      if (selT680.FieldByName('DATA').AsDateTime > OldData) then
        break;
      BuoniResidui:=BuoniResidui - selT680.FieldByName('BUONIPASTO').AsInteger;
      selT680.Next;
    end;
    if OldData <  selT680.FieldByName('DATA').AsDateTime then
    begin
      BuoniScaduti:=BuoniScaduti + BuoniResidui;
      BuoniResidui:=0-selT680.FieldByName('BUONIPASTO').AsInteger;
    end;
    while not selT690.Eof do
    begin
      if selT690.FieldByName('DATA_SCADENZA').AsDateTime < DataA then
        BuoniScaduti:=BuoniScaduti + selT690.FieldByName('BUONIPASTO').AsInteger
      else
        BuoniResidui:=BuoniResidui + selT690.FieldByName('BUONIPASTO').AsInteger;
      BuoniAcquistati:=BuoniAcquistati + selT690.FieldByName('BUONIPASTO').AsInteger;
      selT690.Next;
    end;
    BuoniPasto.Append;
    BuoniPasto.FieldByName('MATRICOLA').AsString:=SelAnagrafe.FieldByName('MATRICOLA').AsString;
    BuoniPasto.FieldByName('COGNOME').AsString:=SelAnagrafe.FieldByName('COGNOME').AsString;
    BuoniPasto.FieldByName('NOME').AsString:=SelAnagrafe.FieldByName('NOME').AsString;
    BuoniPasto.FieldByName('BUONIRESIDUI').AsInteger:=BuoniResidui;
    BuoniPasto.FieldByName('BUONISCADUTI').AsInteger:=BuoniScaduti;
    BuoniPasto.FieldByName('BUONIACQUISTATI').AsInteger:=BuoniAcquistati;
    BuoniPasto.FieldByName('BUONIMATURATI').AsInteger:=BuoniUsati;
    BuoniPasto.Post;
    SelAnagrafe.Next;
  end;
end;

procedure TA073FAcquistoBuoniMW.CreaBuoniPasto;
begin
  BuoniPasto.Close;
  BuoniPasto.FieldDefs.Clear;
  BuoniPasto.FieldDefs.Add('Matricola',ftString,8,False);
  BuoniPasto.FieldDefs.Add('Cognome',ftString,60,False);
  BuoniPasto.FieldDefs.Add('Nome',ftString,60,False);
  BuoniPasto.FieldDefs.Add('BuoniResidui',ftInteger,0,False);
  BuoniPasto.FieldDefs.Add('BuoniScaduti',ftInteger,0,False);
  BuoniPasto.FieldDefs.Add('BuoniAcquistati',ftInteger,0,False);
  BuoniPasto.FieldDefs.Add('BuoniMaturati',ftInteger,0,False);
  BuoniPasto.IndexDefs.Clear;
  BuoniPasto.IndexDefs.Add('Primario',('Matricola'),[ixUnique]);
  BuoniPasto.IndexName:='Primario';
  BuoniPasto.CreateDataSet;
  BuoniPasto.LogChanges:=False;
end;

function TA073FAcquistoBuoniMW.LeggiInfoFile:Integer;
var
  LExcel: Variant;
  XLSheet: Variant;
  LNumColonne: Integer;
  LNumRighe: Integer;
  LFoglio: Integer;
  //LInfoRiga: TInfoRiga;
  LFieldColonna: TIntegerField;
begin
  Result:=0;
  if (FOpzioni.FileName = '') or (not TFile.Exists(FOpzioni.FileName) or (FOpzioni.TipoFile <> TTipoFileRec.XLS)) then
    Exit;

  try
    if (not IsLibrary) and (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
      CoInitialize(nil);
    LExcel:=CreateOleObject('Excel.Application');

    // inizializzazione variabili
    LExcel.Visible:=False;
    LFoglio:=1;

    // apertura del file excel (foglio 1)
    LExcel.WorkBooks.Open(FOpzioni.FileName);
    XLSheet:=LExcel.Worksheets[LFoglio];

    // numero di colonne totali
    LNumColonne:=XLSheet.UsedRange.Columns.Count;

    // imposta limite valore per campo "colonna"
    LFieldColonna:=(cdsMappaturaExcel.FieldByName('COLONNA') as TIntegerField);
    LFieldColonna.MaxValue:=LNumColonne;

    // numero di righe totali
    Result:=XLSheet.UsedRange.Rows.Count;

  finally
    if not VarIsEmpty(LExcel) then
    begin // pulizia oggetti excel
      LExcel.Workbooks.Close;
      LExcel.Quit;
      LExcel:=Unassigned;
    end;
    if (not IsLibrary) and (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
      CoUninitialize;
  end;
end;

procedure TA073FAcquistoBuoniMW.PreparaImportazione(PDataSource: TDataSource);
var
  LDato: string;
  LColonna: Integer;
begin
  FOpzioni.Clear;

  if Assigned(FC004) then
    FreeAndNil(FC004);
  FC004:=CreaC004(SessioneOracle,'A073',0,False);

  // imposta i parametri di ritorno
  FOpzioni.FileName:=C004.GetParametro(A073_OPT_FILENAME,'');
  FOpzioni.TipoFile:=C004.GetParametro(A073_OPT_TIPO_FILE,'');
  FOpzioni.RigaIntestazione:=C004.GetParametro(A073_OPT_RIGA_INTESTAZIONE,'N') = 'S';
  FOpzioni.TipoImportazione:=C004.GetParametro(A073_OPT_TIPO_IMPORTAZIONE,TTipoImportazioneRec.Buoni);

  // prepara il clientdataset per la mappatura delle colonne
  cdsMappaturaExcel.EmptyDataSet;
  cdsMappaturaExcel.BeforeInsert:=nil;
  cdsMappaturaExcel.FieldByName('DATO').ReadOnly:=False;
  try
    // popolamento iniziale dei dati
    // l'associazione viene estratta dalle impostazioni salvate con C004
    for LDato in EXCEL_DATI_IMPORT do
    begin
      // legge il numero di colonna salvato nelle impostazioni
      LColonna:=FC004.GetParametro(Format(C004_COLONNA_FMT,[LDato]),'0').ToInteger;

      // carica la mappatura sul clientdataset
      cdsMappaturaExcel.Append;
      cdsMappaturaExcel.FieldByName('DATO').AsString:=LDato;
      if LColonna > 0 then
        cdsMappaturaExcel.FieldByName('COLONNA').AsInteger:=LColonna
      else
        cdsMappaturaExcel.FieldByName('COLONNA').Value:=null;
      cdsMappaturaExcel.Post;

      // valorizza la colonna specifica nelle opzioni
      if LDato = EXCEL_DATO_MATRICOLA then
        FOpzioni.ColMatricola:=LColonna
      else if LDato = EXCEL_DATO_CODFISCALE then
        FOpzioni.ColCodFiscale:=LColonna
      else if LDato = EXCEL_DATO_DATA_ACQUISTO then
        FOpzioni.ColDataAcquisto:=LColonna
      else if LDato = EXCEL_DATO_QUANTITA then
        FOpzioni.ColQuantita:=LColonna;
    end;

    // seleziona il primo record
    cdsMappaturaExcel.First;
  finally
    cdsMappaturaExcel.BeforeInsert:=cdsMappaturaExcelBeforeInsert;
    cdsMappaturaExcel.FieldByName('DATO').ReadOnly:=True;
  end;

  PDataSource.DataSet:=cdsMappaturaExcel;
end;

function TA073FAcquistoBuoniMW.VerificaOpzioniImportazione: TResCtrl;
// verifica le impostazioni indicate nel parametro
var
  LLst: TStringList;
  LLen: Integer;
begin
  Result.Ok:=False;
  Result.Messaggio:='';

  // verifica che il tipo di importazione sia impostato
  if not R180In(FOpzioni.TipoImportazione,[TTipoImportazioneRec.Buoni,TTipoImportazioneRec.Ticket]) then
  begin
    Result.Messaggio:='Non è stato selezionato il tipo di importazione!';
    Exit;
  end;

  // verifica indicazione del file
  if FOpzioni.FileName = '' then
  begin
    Result.Messaggio:='Il file degli acquisti non è stato specificato!';
    Exit;
  end;

  // verifica esistenza del file
  if not TFile.Exists(FOpzioni.FileName) then
  begin
    Result.Messaggio:=Format('Il file degli acquisti indicato è inesistente:'#13#10'%s',[FOpzioni.FileName]);
    Exit;
  end;

  // verifica mappatura colonne "matricola" / "cod. fiscale"
  if (FOpzioni.ColMatricola = 0) and (FOpzioni.ColCodFiscale = 0) then
  begin
    Result.Messaggio:=Format('E'' necessario mappare almeno uno dei dati "%s" o "%s"'#13#10 +
                             'al fine di identificare il dipendente!',
                             [EXCEL_DATO_MATRICOLA,EXCEL_DATO_CODFISCALE]);
    Exit;
  end;

  // verifica attribuzione stessa colonna a dati differenti
  if (FOpzioni.ColMatricola = FOpzioni.ColCodFiscale) then
  begin
    Result.Messaggio:=Format('La colonna %d è stata attribuita a due o più dati differenti!',[FOpzioni.ColMatricola]);
    Exit;
  end;

  // verifica mappatura colonna "data acquisto"
  if (FOpzioni.ColDataAcquisto = 0) then
  begin
    Result.Messaggio:=Format('E'' necessario mappare il dato "%s"!',[EXCEL_DATO_DATA_ACQUISTO]);
    Exit;
  end;

  // verifica attribuzione stessa colonna a dati differenti
  if (FOpzioni.ColDataAcquisto = FOpzioni.ColMatricola) or
     (FOpzioni.ColDataAcquisto = FOpzioni.ColCodFiscale) then
  begin
    Result.Messaggio:=Format('La colonna %d è stata attribuita a due o più dati differenti!',[FOpzioni.ColDataAcquisto]);
    Exit;
  end;

  // verifica mappatura colonna "quantità"
  if (FOpzioni.ColQuantita = 0) then
  begin
    Result.Messaggio:=Format('E'' necessario mappare il dato "%s"!',[EXCEL_DATO_QUANTITA]);
    Exit;
  end;

  // verifica attribuzione stessa colonna a dati differenti
  if (FOpzioni.ColQuantita = FOpzioni.ColMatricola) or
     (FOpzioni.ColQuantita = FOpzioni.ColCodFiscale) or
     (FOpzioni.ColQuantita = FOpzioni.ColDataAcquisto)  then
  begin
    Result.Messaggio:=Format('La colonna %d è stata attribuita a due o più dati differenti!',[FOpzioni.ColQuantita]);
    Exit;
  end;

  // controlli ok
  Result.Ok:=True;
end;

procedure TA073FAcquistoBuoniMW.EseguiImportazione;
var
  LResCtrl: TResCtrl;
  LExcel: Variant;
  XLSheet: Variant;
  LNumColonne: Integer;
  LNumRighe: Integer;
  LFoglio: Integer;
  r: Integer;
  LInfoRiga: TInfoRiga;
  LDataStr: string;
  LDipTrovato: Boolean;
  LQuantitaStr: string;
  LOperazione: string;
  LRigaIniziale: Integer;
  LColonnaQuantita: string;
  LStatistiche: TStatisticheImportazione;

  function GetDato(Indice:Integer):String;
  begin
    Result:='';
    if R180Between(Indice,1,LNumColonne) then
    begin
      if FOpzioni.TipoFile = TTipoFileRec.CSV then
      begin
        Result:=cdsLetturaCsv.Fields[Indice - 1].AsString;
      end
      else
        Result:=VarToStr(LExcel.Cells[r,indice].Value).Trim;
    end;
  end;

begin
  try
    inizializzaImportazione;
    LStatistiche.Clear;
    if FOpzioni.TipoFile = TTipoFileRec.CSV then
    begin
      LeggiFileCsv(FOpzioni.FileName);
      LRigaIniziale:=1;
      LNumColonne:=cdsLetturaCsv.FieldCount;
      LNumRighe:=cdsLetturaCsv.RecordCount;
      LStatistiche.Totali:=cdsLetturaCsv.RecordCount;
    end
    else if FOpzioni.TipoFile = TTipoFileRec.XLS then
    begin
      if (not IsLibrary) and (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
        CoInitialize(nil);
      LExcel:=CreateOleObject('Excel.Application');
      // inizializzazione variabili
      LExcel.Visible:=False;
      LFoglio:=1;

      // apertura del file excel (foglio 1)
      LExcel.WorkBooks.Open(FOpzioni.FileName);
      XLSheet:=LExcel.Worksheets[LFoglio];

      // numero di colonne totali
      LNumColonne:=XLSheet.UsedRange.Columns.Count;

      // numero di righe totali
      LNumRighe:=XLSheet.UsedRange.Rows.Count;

      // determina la riga iniziale (in funzione della presenza di una riga di intestazione)
      LRigaIniziale:=IfThen(FOpzioni.RigaIntestazione,2,1);
      if LRigaIniziale > 1 then
      begin
        RegistraMsg.InserisciMessaggio('I','Riga 1: la riga di intestazione è stata ignorata come richiesto',Parametri.Azienda);
      end;

      // inizializza contatori per statistiche
      LStatistiche.Totali:=(LNumRighe - LRigaIniziale + 1);
    end;
  except
    on E:Exception do
    begin
      RegistraMsg.InserisciMessaggio('A',Format('Errore imprevisto in fase di lettura del file: %s',[E.Message]),Parametri.Azienda);
      // pulizia oggetti excel
      if FOpzioni.TipoFile = TTipoFileRec.XLS then
      begin
        LExcel.Workbooks.Close;
        LExcel.Quit;
        LExcel:=Unassigned;
        if (not IsLibrary) and (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
          CoUninitialize;
      end;
      raise;
    end;
  end;

  try
    // ciclo di importazione sulle righe del file
    for r:=LRigaIniziale to LNumRighe do
    begin
      try
        if FOpzioni.TipoFile = TTipoFileRec.CSV then
          cdsLetturaCsv.RecNO:=r;

        LInfoRiga.Clear;
        // matricola
        LInfoRiga.Matricola:=GetDato(FOpzioni.ColMatricola);

        // codice fiscale
        LInfoRiga.CodFiscale:=GetDato(FOpzioni.ColCodFiscale);

        // identificazione dipendente
        if (LInfoRiga.Matricola <> '') and (LInfoRiga.CodFiscale <> '') then
        begin
          LDipTrovato:=SelAnagrafe.SearchRecord('MATRICOLA;CODFISCALE',VarArrayOf([LInfoRiga.Matricola,LInfoRiga.CodFiscale]),[srFromBeginning]);
          if not LDipTrovato then
          begin
            inc(LStatistiche.DipendentiNonTrovati);
            RegistraMsg.InserisciMessaggio('A',Format('Riga %d: nessun dipendente trovato nella selezione corrente con matricola "%s" e codice fiscale "%s"',[r,LInfoRiga.Matricola,LInfoRiga.CodFiscale]),Parametri.Azienda);
            Continue;
          end;
        end
        else if (LInfoRiga.Matricola <> '') then
        begin
          LDipTrovato:=SelAnagrafe.SearchRecord('MATRICOLA',LInfoRiga.Matricola,[srFromBeginning]);
          if not LDipTrovato then
          begin
            inc(LStatistiche.DipendentiNonTrovati);
            RegistraMsg.InserisciMessaggio('A',Format('Riga %d: nessun dipendente trovato nella selezione corrente con matricola "%s"',[r,LInfoRiga.Matricola]),Parametri.Azienda);
            Continue;
          end;
        end
        else if (LInfoRiga.CodFiscale <> '') then
        begin
          LDipTrovato:=SelAnagrafe.SearchRecord('CODFISCALE',LInfoRiga.CodFiscale,[srFromBeginning]);
          if not LDipTrovato then
          begin
            inc(LStatistiche.DipendentiNonTrovati);
            RegistraMsg.InserisciMessaggio('A',Format('Riga %d: nessun dipendente trovato nella selezione corrente con codice fiscale "%s"',[r,LInfoRiga.CodFiscale]),Parametri.Azienda);
            Continue;
          end;
        end
        else
        begin
          inc(LStatistiche.AnomalieDati);
          RegistraMsg.InserisciMessaggio('A',Format('Riga %d: matricola e codice fiscale non indicati, impossibile identificare il dipendente',[r]),Parametri.Azienda);
          Continue;
        end;

        // data di acquisto
        LDataStr:=GetDato(FOpzioni.ColDataAcquisto);
        if LDataStr <> '' then
        begin
          if not TryStrToDate(LDataStr,LInfoRiga.DataAcquisto) then
          begin
            inc(LStatistiche.AnomalieDati);
            RegistraMsg.InserisciMessaggio('A',Format('Riga %d: la data di acquisto indicata non è valida: %s',[r,LDataStr]),Parametri.Azienda,ProgressivoC700);
            Continue;
          end;
        end;

        // quantita
        LQuantitaStr:=GetDato(FOpzioni.ColQuantita);
        if LQuantitaStr <> '' then
        begin
          if not TryStrToInt(LQuantitaStr,LInfoRiga.Quantita) then
          begin
            inc(LStatistiche.AnomalieDati);
            RegistraMsg.InserisciMessaggio('A',Format('Riga %d: la quantità indicata non è valida: %s',[r,LQuantitaStr]),Parametri.Azienda,ProgressivoC700);
            Continue;
          end;
        end;

        // tutti i dati presenti e validi

        // inserisce o aggiorna il record di acquisto
        selT690Import.Close;
        selT690Import.SetVariable('PROGRESSIVO',ProgressivoC700);
        selT690Import.SetVariable('DATA',LInfoRiga.DataAcquisto);
        selT690Import.Open;

        // inserimento o aggiornamento
        try
          LOperazione:=IfThen(selT690Import.RecordCount = 0,'inserimento','aggiornamento');
          if selT690Import.RecordCount = 0 then
          begin
            selT690Import.Append;
            selT690Import.FieldByName('PROGRESSIVO').AsInteger:=ProgressivoC700;
            selT690Import.FieldByName('DATA').AsDateTime:=LInfoRiga.DataAcquisto;
          end
          else
          begin
            selT690Import.Edit;
          end;
          LColonnaQuantita:=IfThen(FOpzioni.TipoImportazione = TTipoImportazioneRec.Buoni,'BUONIPASTO','TICKET');
          selT690Import.FieldByName(LColonnaQuantita).AsInteger:=LInfoRiga.Quantita;
          selT690Import.Post;

          // aggiorna statistiche
          if LOperazione = 'inserimento' then
            inc(LStatistiche.Inseriti)
          else
            inc(LStatistiche.Aggiornati);

          // importazione ok
          RegistraMsg.InserisciMessaggio('I',Format('Riga %d: %s effettuato',[r,LOperazione]),Parametri.Azienda,ProgressivoC700);
        except
          on E: Exception do
          begin
            // importazione fallita
            inc(LStatistiche.ErroriImportazione);
            RegistraMsg.InserisciMessaggio('A',Format('Riga %d: %s fallito: %s (%s)',[r,LOperazione,E.Message,E.ClassName]),Parametri.Azienda,ProgressivoC700);
          end;
        end;
      except
        on E: Exception do
        begin
          // errore imprevisto
          inc(LStatistiche.ErroriImprevisti);
          RegistraMsg.InserisciMessaggio('A',Format('Riga %d: errore imprevisto: %s (%s)',[r,E.Message,E.ClassName]),Parametri.Azienda);
        end;
      end;
    end;
  finally
    // pulizia oggetti excel
    if FOpzioni.TipoFile = TTipoFileRec.XLS then
    begin
      LExcel.Workbooks.Close;
      LExcel.Quit;
      LExcel:=Unassigned;
      if (not IsLibrary) and (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then
        CoUninitialize;
    end;

    // log statistiche e fine elaborazione
    RegistraMsg.InserisciMessaggio('I','Statistiche elaborazione',Parametri.Azienda);
    RegistraMsg.InserisciMessaggio('I',Format('Righe totali elaborate: %d',[LStatistiche.Totali]),Parametri.Azienda);
    if LStatistiche.Inseriti > 0 then
      RegistraMsg.InserisciMessaggio('I',Format('Righe importate (nuovi inserimenti): %d',[LStatistiche.Inseriti]),Parametri.Azienda);
    if LStatistiche.Aggiornati > 0 then
      RegistraMsg.InserisciMessaggio('I',Format('Righe importate (aggiornamento quantità): %d',[LStatistiche.Aggiornati]),Parametri.Azienda);
    if LStatistiche.AnomalieDati > 0 then
      RegistraMsg.InserisciMessaggio('I',Format('Righe non importate (anomalie nei dati del file): %d',[LStatistiche.AnomalieDati]),Parametri.Azienda);
    if LStatistiche.DipendentiNonTrovati > 0 then
      RegistraMsg.InserisciMessaggio('I',Format('Righe non importate (dipendenti non presenti nella selezione): %d',[LStatistiche.DipendentiNonTrovati]),Parametri.Azienda);
    if LStatistiche.ErroriImportazione > 0 then
      RegistraMsg.InserisciMessaggio('I',Format('Righe non importate (errori durante importazione su database): %d',[LStatistiche.ErroriImportazione]),Parametri.Azienda);
    if LStatistiche.ErroriImprevisti > 0 then
      RegistraMsg.InserisciMessaggio('I',Format('Righe non importate (errori imprevisti): %d',[LStatistiche.ErroriImprevisti]),Parametri.Azienda);
    RegistraMsg.InserisciMessaggio('I','Fine importazione',Parametri.Azienda);
  end;
end;

procedure TA073FAcquistoBuoniMW.SalvaParametriImportazione;
var
  LDato: string;
  LNumColonna: Integer;
begin
  // salva le opzioni di importazione
  FC004.PutParametro(A073_OPT_FILENAME,FOpzioni.FileName);
  FC004.PutParametro(A073_OPT_TIPO_FILE,FOpzioni.TipoFile);
  FC004.PutParametro(A073_OPT_RIGA_INTESTAZIONE,IfThen(FOpzioni.RigaIntestazione,'S','N'));
  FC004.PutParametro(A073_OPT_TIPO_IMPORTAZIONE,FOpzioni.TipoImportazione);

  // salva la mappatura del file excel
  for LDato in EXCEL_DATI_IMPORT do
  begin
    // conversione numero colonna in integer
    LNumColonna:=StrToIntDef(VarToStr(cdsMappaturaExcel.Lookup('DATO',LDato,'COLONNA')),0);
    FC004.PutParametro(Format(C004_COLONNA_FMT,[LDato]),LNumColonna.ToString);
  end;

  SessioneOracle.Commit;
end;

{ TInfoRiga }

procedure TInfoRiga.Clear;
begin
  Self.Matricola:='';
  Self.CodFiscale:='';
  Self.DataAcquisto:=DATE_NULL;
  Self.Quantita:=0;
end;

{ TOpzioniImportazione }

procedure TOpzioniImportazione.Clear;
begin
  Self.FileName:='';
  Self.RigaIntestazione:=False;
  Self.TipoImportazione:=TTipoImportazioneRec.Buoni;
  Self.ColMatricola:=0;
  Self.ColCodFiscale:=0;
  Self.ColDataAcquisto:=0;
  Self.ColQuantita:=0;
end;

{ TStatisticheImportazione }

procedure TStatisticheImportazione.Clear;
begin
  Self.DipendentiNonTrovati:=0;
  Self.AnomalieDati:=0;
  Self.Inseriti:=0;
  Self.Aggiornati:=0;
  Self.ErroriImportazione:=0;
  Self.ErroriImprevisti:=0;
  Self.Totali:=0;
end;

procedure TA073FAcquistoBuoniMW.LeggiFileCsv(nomeFile: String);
var i:Integer;
    NomeCampo:String;
begin
  txtRdrCsv.FileName:= nomeFile;
  txtRdrCsv.DataDef.Separator:= ';';
  if cdsLetturaCsv.Active then
  begin
    cdsLetturaCsv.EmptyDataSet;
    cdsLetturaCsv.Close;
    cdsLetturaCsv.FieldDefs.Clear;
  end;
  if txtRdrCsv.DataDef.Fields.Count > 0 then
    txtRdrCsv.DataDef.Fields.Clear;
  //permette di caricare i campi nel reader
  bMvCsv.GuessFormat(bMvCsv.Analyze);
  if txtRdrCsv.DataDef.Fields.Count > 0 then
  begin
    for i:=0 to txtRdrCsv.DataDef.Fields.Count -1 do
    begin
      NomeCampo:=txtRdrCsv.DataDef.Fields[i].FieldName;
      if NomeCampo = '' then
      begin
        NomeCampo:='Campo'+i.ToString;
        txtRdrCsv.DataDef.Fields[i].FieldName:=NomeCampo;
        txtRdrCsv.DataDef.Fields[i].DataType:=atString;
      end;
      cdsLetturaCsv.FieldDefs.Add(NomeCampo, ftString, 100);
    end;
    bMvCsv.GuessFormat(bMvCsv.Analyze);
    cdsLetturaCsv.CreateDataSet;
  end;
  cdsLetturaCsv.Open;
  bMvCsv.Execute;
end;

procedure TA073FAcquistoBuoniMW.inizializzaImportazione;
var LResCtrl: TResCtrl;
begin
  RegistraMsg.IniziaMessaggio('A073');
  LResCtrl:=VerificaOpzioniImportazione;
  if not LResCtrl.Ok then
  begin
    RegistraMsg.InserisciMessaggio('A',Format('Le impostazioni di importazione presentano errori: %s',[LResCtrl.Messaggio]),Parametri.Azienda);
    raise Exception.Create('Le impostazioni di importazione presentano errori');
  end;
  SalvaParametriImportazione;
  RegistraMsg.InserisciMessaggio('I','Avvio importazione',Parametri.Azienda);
  RegistraMsg.InserisciMessaggio('I',Format('File: "%s"',[FOpzioni.FileName]),Parametri.Azienda);
end;
end.
