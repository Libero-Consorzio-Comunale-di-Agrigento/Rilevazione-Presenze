unit A040UPianifRepDtM2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ComCtrls, R004UGESTSTORICODTM, DB, DBClient, Oracle, OracleData,
  A000UCostanti, A000USessione, A000UInterfaccia, USelI010, QueryStorico,
  C180FunzioniGenerali, C700USelezioneAnagrafe, Math, StrUtils;

type
  TTipoStampa = (tsTabellone,
                 tsProspettoDip,
                 tsProspettoRaggr);

  TDettaglioCella = (dtCodice,
                     dtSigla,
                     dtPriorita,
                     dtOrario,
                     dtOrarioInRiga,
                     dtDatoLibero,
                     dtDatiAggiuntivi,
                     dtDatiAggInRiga,
                     dtCausAss,
                     dtSiglaAss);

  TSetDettaglioCella = set of TDettaglioCella;

  TTurno = record
    Codice,               // cod. turno
    Sigla,                // sigla turno
    Descrizione,          // desc. turno
    OraInizio,            // ora inizio turno
    OraFine,              // ora fine turno
    OraInizioNoSep,       // ora inizio turno (formato hhmm)
    OraFineNoSep: String; // ora fine turno   (formato hhmm)
  end;

  TCella = record
    T1,               // codice turno 1
    T2,               // codice turno 2
    T3,               // codice turno 3
    DL,               // dato libero pianificato
    Ass,              // codice causale assenza / sigla per assenza
    Testo: String;    // testo formattato
    MaxLen: Integer;  // numero di caratteri della riga più lunga nella cella
  end;

  TA040FPianifRepDtM2 = class(TR004FGestStoricoDtM)
    cdsPianif: TClientDataSet;
    selT380: TOracleDataSet;
    selT350: TOracleDataSet;
    selT040: TOracleDataSet;
    selT267: TOracleDataSet;
    selT265: TOracleDataSet;
    cdsLegenda: TClientDataSet;
    cdsLegendaCODTURNO: TStringField;
    cdsLegendaDESCTURNO: TStringField;
    cdsLegendaCODCAUS: TStringField;
    cdsLegendaDESCCAUS: TStringField;
    selV010: TOracleDataSet;
    cdsLegendaCODDATOAGG1: TStringField;
    cdsLegendaDESCDATOAGG1: TStringField;
    cdsLegendaCODDATOAGG2: TStringField;
    cdsLegendaDESCDATOAGG2: TStringField;
    selDatoAgg1: TOracleDataSet;
    selDatoAgg2: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure FiltroDizionario(DataSet: TDataSet; var Accept: Boolean);
    procedure selT380FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    // variabili private per le property
    FTipoStampa: TTipoStampa;
    FTipologiaTurno: String; // R = reperibilità, G = guardia
    FDataInizio,
    FDataFine: TDateTime; 
    FElencoTurni,
    FElencoOrari,
    FNomeCampoRaggr1,
    FNomeLogicoRaggr1,
    FTabellaCampoRaggr1,
    FTipoCampoRaggr1,
    FNomeCampoRaggr2,
    FNomeLogicoRaggr2,
    FTabellaCampoRaggr2,
    FTipoCampoRaggr2,
    FNomeCampoConNom,
    FNomeLogicoConNom,
    FTabellaCampoConNom,
    FTipoCampoConNom,
    FNomeCampoDett,
    FNomeLogicoDett,
    FTabellaCampoDett,
    FTipoCampoDett,
    FSiglaAssenza: String;
    FIncludiNonPianificati: Boolean;
    FLengthCampoRaggr1,
    FLengthCampoRaggr2,
    FLengthCampoConNom,
    FLengthCampoDett,
    FLengthCampoDettStr: Integer;
    MaxLengthCodCaus,
    MaxLengthDescCaus,
    MaxLengthCodTurno,
    MaxLengthDescTurno,
    MaxLengthCodDatoAgg1,
    MaxLengthDescDatoAgg1,
    MaxLengthCodDatoAgg2,
    MaxLengthDescDatoAgg2: Integer;
    FVisualizzaLegenda,FNomeCompleto: Boolean;
    FDettaglioCella: TSetDettaglioCella;
    // altre variabili
    ArrTurni: array of TTurno;
    ElencoTurniArr: array of String;
    ListLegendaCausAss,
    ListLegendaTurni,
    ListLegendaDatoAgg1,
    ListLegendaDatoAgg2: TStringList;
    FSessioneOracle: TOracleSession;
    selI010: TselI010;
    PBarOffset,PBarLimit: Integer;
    // metodi get/set per proprietà
    function  GetTipoStampa: TTipoStampa;
    procedure SetTipoStampa(Val: TTipoStampa);
    function  GetTipologiaTurno: String;
    procedure SetTipologiaTurno(const Val: String);
    function  GetDataInizio: TDateTime;
    procedure SetDataInizio(Val: TDateTime);
    function  GetDataFine: TDateTime;
    procedure SetDataFine(Val: TDateTime);
    function  GetElencoTurni: String;
    procedure SetElencoTurni(const Val: String);
    function  GetElencoOrari: String;
    procedure SetElencoOrari(const Val: String);
    function  GetIncludiNonPianificati: Boolean;
    procedure SetIncludiNonPianificati(Val: Boolean);
    function  GetNomeCampoRaggr1: String;
    procedure SetNomeCampoRaggr1(const Val: String);
    function  GetNomeCampoRaggr2: String;
    procedure SetNomeCampoRaggr2(const Val: String);
    function  GetNomeLogicoRaggr1: String;
    function  GetNomeLogicoRaggr2: String;
    function  GetTabellaCampoRaggr1: String;
    function  GetTabellaCampoRaggr2: String;
    function  GetTipoCampoRaggr1: String;
    function  GetTipoCampoRaggr2: String;
    function  GetLengthCampoRaggr1: Integer;
    function  GetLengthCampoRaggr2: Integer;
    function  GetNomeCampoConNom: String;
    procedure SetNomeCampoConNom(const Val: String);
    function  GetNomeLogicoConNom: String;
    function  GetTabellaCampoConNom: String;
    function  GetTipoCampoConNom: String;
    function  GetLengthCampoConNom: Integer;
    function  GetNomeCampoDett: String;
    procedure SetNomeCampoDett(const Val: String);
    function  GetNomeLogicoDett: String;
    function  GetTabellaCampoDett: String;
    function  GetTipoCampoDett: String;
    function  GetSiglaAssenza: String;
    procedure SetSiglaAssenza(const Val: String);
    function  GetLengthCampoDett: Integer;
    function  GetLengthCampoDettStr: Integer;
    function  GetDettaglioCella: TSetDettaglioCella;
    procedure SetDettaglioCella(Val: TSetDettaglioCella);
    function  GetVisualizzaLegenda: Boolean;
    procedure SetVisualizzaLegenda(Val: Boolean);
    function  GetNomeCompleto: Boolean;
    procedure SetNomeCompleto(Val: Boolean);
    // gestione progressbar
    {$IFNDEF IRISWEB}
    procedure AzzeraProgresso;
    procedure AggiornaProgresso(Attuale, Totale: Integer);
    procedure LimiteProgresso(Val: Integer);
    procedure SettaProgresso;
    {$ENDIF}
    // gestione dati turni
    procedure GetDatiTurni;
    function  _ArrTurniGetIndex(const Codice: String; p,r:Integer): Integer;
    // gestione assenze e pianificazioni
    function  IsGiornataAssenza(D: TDateTime; var Causale: String): Boolean;
    procedure LegendaAdd(const PTipo: String; PChiave: String);
    procedure ApriDatasetPianificazioni;
    // gestione client dataset

    function  ComponiCellaTabellone(FiltroDatoAgg1,FiltroDatoAgg2:String): TCella;
    procedure CreaFieldRaggruppamento1(cds: TClientDataset);
    procedure CreaFieldRaggruppamento2(cds: TClientDataset);
    function  GetNomeCampo(D: TDateTime): String;
    procedure CreaTabellone;
    procedure CreaLegenda;
    procedure CreaProspDip;
    procedure CreaProspRaggr;
    function  TurnoSelezionato(idxTurno:String):Boolean;
  public
    {$IFNDEF IRISWEB}
    PBar: TProgressBar;
    {$ENDIF}
    RaggrDatiAgg:Boolean;
    // gestione client dataset
    function RivalutaCodici(pGruppo: String): TStringList;
    function  IsFestivo(const PData: TDateTime): Boolean;
    procedure PreparaDati;
    function GetNomeLogico(NomeCampo:String):String;
    function GetValDatoAgg(idxDatoAgg,idxTurno:String):String;
    function GetTurno(const Codice: String): TTurno;
    // proprietà
    property TipoStampa: TTipoStampa read GetTipoStampa write SetTipoStampa;
    property TipologiaTurno: String read GetTipologiaTurno write SetTipologiaTurno;
    property DataInizio: TDateTime read GetDataInizio write SetDataInizio;
    property DataFine: TDateTime read GetDataFine write SetDataFine;
    property ElencoTurni: String read GetElencoTurni write SetElencoTurni;
    property ElencoOrari: String read GetElencoOrari write SetElencoOrari; 
    property IncludiNonPianificati: Boolean read GetIncludiNonPianificati write SetIncludiNonPianificati;
    property NomeCampoRaggr1: String read GetNomeCampoRaggr1 write SetNomeCampoRaggr1;
    property NomeCampoRaggr2: String read GetNomeCampoRaggr2 write SetNomeCampoRaggr2;
    property NomeLogicoRaggr1: String read GetNomeLogicoRaggr1;
    property NomeLogicoRaggr2: String read GetNomeLogicoRaggr2;
    property TabellaCampoRaggr1: String read GetTabellaCampoRaggr1;
    property TabellaCampoRaggr2: String read GetTabellaCampoRaggr2;
    property TipoCampoRaggr1: String read GetTipoCampoRaggr1;
    property TipoCampoRaggr2: String read GetTipoCampoRaggr2;
    property LengthCampoRaggr1: Integer read GetLengthCampoRaggr1;
    property LengthCampoRaggr2: Integer read GetLengthCampoRaggr2;
    property NomeCampoConNom: String read GetNomeCampoConNom write SetNomeCampoConNom;
    property NomeLogicoConNom: String read GetNomeLogicoConNom;
    property TabellaCampoConNom: String read GetTabellaCampoConNom;
    property TipoCampoConNom: String read GetTipoCampoConNom;
    property LengthCampoConNom: Integer read GetLengthCampoConNom;
    property NomeCampoDett: String read GetNomeCampoDett write SetNomeCampoDett;
    property NomeLogicoDett: String read GetNomeLogicoDett;
    property TabellaCampoDett: String read GetTabellaCampoDett;
    property TipoCampoDett: String read GetTipoCampoDett;
    property LengthCampoDett: Integer read GetLengthCampoDett;
    property LengthCampoDettStr: Integer read GetLengthCampoDettStr;
    property SiglaAssenza: String read GetSiglaAssenza write SetSiglaAssenza;
    property DettaglioCella: TSetDettaglioCella read GetDettaglioCella write SetDettaglioCella;
    property VisualizzaLegenda: Boolean read GetVisualizzaLegenda write SetVisualizzaLegenda;
    property NomeCompleto: Boolean read GetNomeCompleto write SetNomeCompleto;
  end;

var
  A040FPianifRepDtM2: TA040FPianifRepDtM2;

const
  // tag per la stampa
  // *************************************************************
  // *                  I M P O R T A N T E !                    *
  // *************************************************************
  // * Fatta eccezione per il TAG_NO_PRINT (valore negativo),    *
  // * se è necessario dichiarare altri tag per la stampa        *
  // * utilizzare sempre multipli di 2                           *
  // *************************************************************
  TAG_NO_PRINT:            Integer = -1;
  TAG_EVIDENZIA_FESTIVI: Integer = 2;
  TAG_NO_RIPROPORZIONA:    Integer = 4;

  // lunghezza massima campo di raggruppamento
  MAXWIDTH_CAMPORAGGR: Integer = 30;

implementation

uses A040UPianifRepDtM1;

{$R *.dfm}

procedure TA040FPianifRepDtM2.DataModuleCreate(Sender: TObject);
{ E' possibile specificare come Sender una variabile di tipo TOracleSession,
  che sarà utilizzata come sessione oracle per il dataset e }
var
  i: Integer;
begin
  inherited;
  PBarOffset:=0;
  PBarLimit:=0;

  // inizializzazione proprietà
  TipoStampa:=tsTabellone;
  TipologiaTurno:='R';
  DataInizio:=R180InizioMese(Parametri.DataLavoro);
  DataFine:=R180FineMese(Parametri.DataLavoro);
  ElencoTurni:='';
  IncludiNonPianificati:=True;
  NomeCampoRaggr1:='';
  NomeCampoRaggr2:='';
  NomeCampoConNom:='';
  NomeCampoDett:='';
  SiglaAssenza:='A';
  DettaglioCella:=[];
  VisualizzaLegenda:=False;
  NomeCompleto:=False;
  
  // imposta la sessione oracle in base al parametro Sender
  FSessioneOracle:=SessioneOracle;
  if Sender <> nil then
    if Sender is TOracleSession then
    begin
      FSessioneOracle:=TOracleSession(Sender);
      // reimposta la sessione oracle ai componenti oraclequery e dataset
      for i:=0 to Self.ComponentCount - 1 do
      begin
        if Components[i] is TOracleQuery then
          (Components[i] as TOracleQuery).Session:=SessioneOracle;
        if Components[i] is TOracleDataSet then
          (Components[i] as TOracleDataSet).Session:=SessioneOracle;
      end;
    end;

  // apertura dataset campi anagrafici
  selI010:=TselI010.Create(Self);
  selI010.Apri(FSessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,DATA_TYPE,DATA_LENGTH','','NOME_LOGICO');

  // apre elenco codici-descrizioni dati aggiuntivi
  A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1,selDatoAgg1);
  if selDatoAgg1.VariableIndex('DECORRENZA') >= 0 then
    selDatoAgg1.SetVariable('DECORRENZA',R180InizioMese(DataInizio));
  try
    selDatoAgg1.Open;
  except
  end;
  A000LookupTabella(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2,selDatoAgg2);
  if selDatoAgg2.VariableIndex('DECORRENZA') >= 0 then
    selDatoAgg2.SetVariable('DECORRENZA',R180InizioMese(DataInizio));
  try
    selDatoAgg2.Open;
  except
  end;
end;

procedure TA040FPianifRepDtM2.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  SetLength(ArrTurni,0);
  SetLength(ElencoTurniArr,0);
  FreeAndNil(ListLegendaCausAss);
  FreeAndNil(ListLegendaTurni);
  FreeAndNil(ListLegendaDatoAgg1);
  FreeAndNil(ListLegendaDatoAgg2);
  FreeAndNil(selI010);
end;


//****************************************************************************//
//******************   G E S T I O N E   P R O P E R T Y   *******************//
//****************************************************************************//
function TA040FPianifRepDtM2.GetTipoStampa: TTipoStampa;
begin
  Result:=FTipoStampa;
end;

procedure TA040FPianifRepDtM2.SetTipoStampa(Val: TTipoStampa);
begin
  case Val of
    tsTabellone:
      begin
        ElencoTurni:='';
        NomeCompleto:=False;
      end;
    tsProspettoDip:
      begin
        IncludiNonPianificati:=False;
        SiglaAssenza:='';
        DettaglioCella:=[];
        VisualizzaLegenda:=False;
        NomeCompleto:=False;
      end;
    tsProspettoRaggr:
      begin
        IncludiNonPianificati:=False;
        SiglaAssenza:='';
        DettaglioCella:=[];
        VisualizzaLegenda:=False;
        NomeCampoDett:='';
      end;
  end;
  FTipoStampa:=Val;
end;

function TA040FPianifRepDtM2.GetTipologiaTurno: String;
begin
  Result:=FTipologiaTurno;
end;

procedure TA040FPianifRepDtM2.SetTipologiaTurno(const Val: String);
begin
  FTipologiaTurno:=Val;
end;

function TA040FPianifRepDtM2.GetDataInizio: TDateTime;
begin
  Result:=FDataInizio;
end;

procedure TA040FPianifRepDtM2.SetDataInizio(Val: TDateTime);
begin
  FDataInizio:=Val;
end;

function TA040FPianifRepDtM2.GetDataFine: TDateTime;
begin
  Result:=FDataFine;
end;

procedure TA040FPianifRepDtM2.SetDataFine(Val: TDateTime);
begin
  FDataFine:=Val;
end;

function TA040FPianifRepDtM2.GetElencoTurni: String;
begin
  Result:=FElencoTurni;
end;

procedure TA040FPianifRepDtM2.SetElencoTurni(const Val: String);
{ Imposta l'elenco dei turni da considerare, suddividendoli per comodità
  di gestione in un array
}
var
  i: Integer;
  Lista: TStringList;
begin
  // suddivide i codici e li inserisce nell'array dei turni
  if Val = '' then
  begin
    // 0 elementi
    SetLength(ElencoTurniArr,0);
  end
  else if Pos(',',Val) = 0 then
  begin
    // 1 elemento
    SetLength(ElencoTurniArr,1);
    ElencoTurniArr[0]:=Val;
  end
  else
  begin
    // n > 1 elementi
    Lista:=TStringList.Create();
    try
      Lista.CommaText:=Val;
      SetLength(ElencoTurniArr,Lista.Count);
      for i:=0 to Lista.Count - 1 do
        ElencoTurniArr[i]:=Lista[i];
    finally
      FreeAndNil(Lista);
    end;
  end;
  FElencoTurni:=Val;
end;

function TA040FPianifRepDtM2.GetElencoOrari: String;
begin
  Result:=FElencoOrari;
end;

procedure TA040FPianifRepDtM2.SetElencoOrari(const Val: String);
{ Imposta l'elenco degli orari dei turni da considerare e quindi carica l'array
  contenente l'elenco dei turni per ogni orario
}
var
  i: Integer;
  Lista: TStringList;
  F,Cod: String;
begin
  if Val = '' then
  begin
    ElencoTurni:='';
    Exit;
  end;

  // usa stringlist di appoggio per caricare array di elenco turni
  FElencoTurni:='';
  Lista:=TStringList.Create();
  R180SetVariable(selT350,'TIPOLOGIA',TipologiaTurno);
  F:='and    to_char(ORAINIZIO,''hh24.mi'') = ''%s''' + #13#10 +
     'and    to_char(ORAFINE,''hh24.mi'') = ''%s''';
  try
    Lista.CommaText:=Val;
    SetLength(ElencoTurniArr,Lista.Count);
    for i:=0 to Lista.Count - 1 do
    begin
      ElencoTurniArr[i]:='';
      R180SetVariable(selT350,'FILTRO',Format(F,[Copy(Lista[i],1,5),Copy(Lista[i],7,11)]));
      selT350.Open;
      selT350.First;
      while not selT350.Eof do
      begin
        Cod:=selT350.FieldByName('CODICE').AsString;
        ElencoTurniArr[i]:=ElencoTurniArr[i] + Cod + ',';
        if Pos(',' + Cod + ',',',' + FElencoTurni) = 0 then
          FElencoTurni:=FElencoTurni + Cod + ',';
        selT350.Next;
      end;
      ElencoTurniArr[i]:=Copy(ElencoTurniArr[i],1,Length(ElencoTurniArr[i]) - 1);
    end;
    FElencoTurni:=Copy(FElencoTurni,1,Length(FElencoTurni) - 1);
    FElencoOrari:=Val;
  finally
    FreeAndNil(Lista);
  end;
end;

function TA040FPianifRepDtM2.GetIncludiNonPianificati: Boolean;
begin
  Result:=FIncludiNonPianificati;
end;

procedure TA040FPianifRepDtM2.SetIncludiNonPianificati(Val: Boolean);
begin
  // proprietà significativa solo per tabellone mensile
  if TipoStampa = tsTabellone then
    FIncludiNonPianificati:=Val
  else
    FIncludiNonPianificati:=False;
end;

function TA040FPianifRepDtM2.GetNomeCampoRaggr1: String;
begin
  Result:=FNomeCampoRaggr1;
end;

procedure TA040FPianifRepDtM2.SetNomeCampoRaggr1(const Val: string);
  procedure PulisciProprietaDerivate;
  begin
    FNomeCampoRaggr1:='';
    FTabellaCampoRaggr1:='';
    FTipoCampoRaggr1:='';
    FLengthCampoRaggr1:=0;
    FNomeLogicoRaggr1:='';
  end;
begin
  // pulisce informazioni su campo raggruppamento
  if Val = '' then
  begin
    PulisciProprietaDerivate;
    Exit;
  end;

  // estrae i dati collegati al campo di raggruppamento
  try
    if selI010.Active then
    begin
      if selI010.SearchRecord('NOME_CAMPO',Val,[srFromBeginning]) then
      begin
        FNomeCampoRaggr1:=Val;
        FTabellaCampoRaggr1:=AliasTabella(FNomeCampoRaggr1);
        FTipoCampoRaggr1:=selI010.FieldByName('DATA_TYPE').AsString;
        FLengthCampoRaggr1:=selI010.FieldByName('DATA_LENGTH').AsInteger;
        FNomeLogicoRaggr1:=selI010.FieldByName('NOME_LOGICO').AsString;
      end
      else
        raise Exception.Create('campo anagrafico inesistente!');
    end
    else
      raise Exception.Create('selI010: dataset non attivo!');
  except
    on E: Exception do
    begin
      E.Message:='Errore durante l''impostazione del campo anagrafico' + #13#10 +
                 'di raggruppamento ' + Val + #13#10 +
                 'Motivo: ' + E.Message;
      PulisciProprietaDerivate;
      raise;
    end;
  end;
end;

function TA040FPianifRepDtM2.GetNomeCampoRaggr2: String;
begin
  Result:=FNomeCampoRaggr2;
end;

procedure TA040FPianifRepDtM2.SetNomeCampoRaggr2(const Val: string);
  procedure PulisciProprietaDerivate;
  begin
    FNomeCampoRaggr2:='';
    FTabellaCampoRaggr2:='';
    FTipoCampoRaggr2:='';
    FLengthCampoRaggr2:=0;
    FNomeLogicoRaggr2:='';
  end;
begin
  // pulisce informazioni su campo raggruppamento
  if Val = '' then
  begin
    PulisciProprietaDerivate;
    Exit;
  end;

  // estrae i dati collegati al campo di raggruppamento
  try
    if selI010.Active then
    begin
      if selI010.SearchRecord('NOME_CAMPO',Val,[srFromBeginning]) then
      begin
        FNomeCampoRaggr2:=Val;
        FTabellaCampoRaggr2:=AliasTabella(FNomeCampoRaggr2);
        FTipoCampoRaggr2:=selI010.FieldByName('DATA_TYPE').AsString;
        FLengthCampoRaggr2:=selI010.FieldByName('DATA_LENGTH').AsInteger;
        FNomeLogicoRaggr2:=selI010.FieldByName('NOME_LOGICO').AsString;
      end
      else
        raise Exception.Create('campo anagrafico inesistente!');
    end
    else
      raise Exception.Create('selI010: dataset non attivo!');
  except
    on E: Exception do
    begin
      E.Message:='Errore durante l''impostazione del campo anagrafico' + #13#10 +
                 'di raggruppamento ' + Val + #13#10 +
                 'Motivo: ' + E.Message;
      PulisciProprietaDerivate;
      raise;
    end;
  end;
end;

function TA040FPianifRepDtM2.GetNomeLogicoRaggr1: String;
begin
  Result:=FNomeLogicoRaggr1;
end;

function TA040FPianifRepDtM2.GetNomeLogicoRaggr2: String;
begin
  Result:=FNomeLogicoRaggr2;
end;

function TA040FPianifRepDtM2.GetTabellaCampoRaggr1: String;
begin
  Result:=FTabellaCampoRaggr1;
end;

function TA040FPianifRepDtM2.GetTabellaCampoRaggr2: String;
begin
  Result:=FTabellaCampoRaggr2;
end;

function TA040FPianifRepDtM2.GetTipoCampoRaggr1: String;
begin
  Result:=FTipoCampoRaggr1;
end;

function TA040FPianifRepDtM2.GetTipoCampoRaggr2: String;
begin
  Result:=FTipoCampoRaggr2;
end;

function TA040FPianifRepDtM2.GetLengthCampoRaggr1: Integer;
begin
  Result:=FLengthCampoRaggr1;
end;

function TA040FPianifRepDtM2.GetLengthCampoRaggr2: Integer;
begin
  Result:=FLengthCampoRaggr2;
end;

function TA040FPianifRepDtM2.GetNomeCampoConNom: String;
begin
  Result:=FNomeCampoConNom;
end;

procedure TA040FPianifRepDtM2.SetNomeCampoConNom(const Val: string);
  procedure PulisciProprietaDerivate;
  begin
    FNomeCampoConNom:='';
    FTabellaCampoConNom:='';
    FTipoCampoConNom:='';
    FLengthCampoConNom:=0;
    FNomeLogicoConNom:='';
  end;
begin
  // pulisce informazioni su campo con nominativo
  if Val = '' then
  begin
    PulisciProprietaDerivate;
    Exit;
  end;

  // estrae i dati collegati al campo con nominativo
  try
    if selI010.Active then
    begin
      if selI010.SearchRecord('NOME_CAMPO',Val,[srFromBeginning]) then
      begin
        FNomeCampoConNom:=Val;
        FTabellaCampoConNom:=AliasTabella(FNomeCampoConNom);
        FTipoCampoConNom:=selI010.FieldByName('DATA_TYPE').AsString;
        FLengthCampoConNom:=selI010.FieldByName('DATA_LENGTH').AsInteger;
        FNomeLogicoConNom:=selI010.FieldByName('NOME_LOGICO').AsString;
      end
      else
        raise Exception.Create('campo anagrafico inesistente!');
    end
    else
      raise Exception.Create('selI010: dataset non attivo!');
  except
    on E: Exception do
    begin
      E.Message:='Errore durante l''impostazione del campo anagrafico' + #13#10 +
                 'di raggruppamento ' + Val + #13#10 +
                 'Motivo: ' + E.Message;
      PulisciProprietaDerivate;
      raise;
    end;
  end;
end;

function TA040FPianifRepDtM2.GetNomeLogicoConNom: String;
begin
  Result:=FNomeLogicoConNom;
end;

function TA040FPianifRepDtM2.GetTabellaCampoConNom: String;
begin
  Result:=FTabellaCampoConNom;
end;

function TA040FPianifRepDtM2.GetTipoCampoConNom: String;
begin
  Result:=FTipoCampoConNom;
end;

function TA040FPianifRepDtM2.GetLengthCampoConNom: Integer;
begin
  Result:=FLengthCampoConNom;
end;

function TA040FPianifRepDtM2.GetNomeCampoDett: String;
begin
  Result:=FNomeCampoDett;
end;

procedure TA040FPianifRepDtM2.SetNomeCampoDett(const Val: string);
  procedure PulisciProprietaDerivate;
  begin
    FNomeCampoDett:='';
    FTabellaCampoDett:='';
    FTipoCampoDett:='';
    FLengthCampoDett:=0;
    FLengthCampoDettStr:=0;
    FNomeLogicoDett:='';
  end;
begin
  if (Val = '') or
     (TipoStampa <> tsProspettoDip) then
  begin
    PulisciProprietaDerivate;
    Exit;
  end;
  if Val = A040FPianifRepDtM1.A040MW.RECAPITO then
  begin
    FNomeCampoDett:=Val;
    FNomeLogicoDett:=Val;
    FTabellaCampoDett:='T380';
    FTipoCampoDett:='VARCHAR2';
    FLengthCampoDett:=100;
    FLengthCampoDettStr:=15;
    Exit;
  end;
  try
    if selI010.Active then
    begin
      if selI010.SearchRecord('NOME_CAMPO',Val,[srFromBeginning]) then
      begin
        FNomeCampoDett:=Val;
        FTabellaCampoDett:=AliasTabella(FNomeCampoDett);
        FTipoCampoDett:=selI010.FieldByName('DATA_TYPE').AsString;
        FLengthCampoDett:=selI010.FieldByName('DATA_LENGTH').AsInteger;
        if FTipoCampoDett = 'VARCHAR2' then
          FLengthCampoDettStr:=FLengthCampoDett
        else if FTipoCampoDett = 'NUMBER' then
          FLengthCampoDettStr:=10  // number: 10 caratteri max
        else if FTipoCampoDett = 'DATE' then
          FLengthCampoDettStr:=19; // date [dd/mm/yyyy hh.mm.ss]: 19 caratteri max
        FNomeLogicoDett:=selI010.FieldByName('NOME_LOGICO').AsString;
      end
      else
        raise Exception.Create('campo anagrafico inesistente!');
    end
    else
      raise Exception.Create('selI010: dataset non attivo!');
  except
    on E: Exception do
    begin
      PulisciProprietaDerivate;
      E.Message:='Errore durante l''impostazione del campo anagrafico' + #13#10 +
                 'di dettaglio ' + Val + #13#10 +
                 'Motivo: ' + E.Message;
      raise;
    end;
  end;
end;

function TA040FPianifRepDtM2.GetNomeLogicoDett: String;
begin
  Result:=FNomeLogicoDett;
end;

function TA040FPianifRepDtM2.GetTabellaCampoDett: String;
begin
  Result:=FTabellaCampoDett;
end;

function TA040FPianifRepDtM2.GetTipoCampoDett: String;
begin
  Result:=FTipoCampoDett;
end;

function TA040FPianifRepDtM2.GetLengthCampoDett: Integer;
begin
  Result:=FLengthCampoDett;
end;

function TA040FPianifRepDtM2.GetLengthCampoDettStr: Integer;
begin
  Result:=FLengthCampoDettStr;
end;

function TA040FPianifRepDtM2.GetSiglaAssenza: String;
begin
  Result:=FSiglaAssenza;
end;

procedure TA040FPianifRepDtM2.SetSiglaAssenza(const Val: String);
begin
  if TipoStampa = tsTabellone then
    FSiglaAssenza:=Val
  else
    FSiglaAssenza:='';
end;

function TA040FPianifRepDtM2.GetDettaglioCella: TSetDettaglioCella;
begin
  Result:=FDettaglioCella;
end;

procedure TA040FPianifRepDtM2.SetDettaglioCella(Val: TSetDettaglioCella);
begin
  if TipoStampa = tsTabellone then
    FDettaglioCella:=Val
  else
    FDettaglioCella:=[];
end;

function TA040FPianifRepDtM2.GetVisualizzaLegenda: Boolean;
begin
  Result:=FVisualizzaLegenda;
end;

procedure TA040FPianifRepDtM2.SetVisualizzaLegenda(Val: Boolean);
begin
  selT265.Close;
  if TipoStampa <> tsTabellone then
    Val:=False;

  // gestione liste per legenda
  if Val then
  begin
    selT265.Open;

    // crea stringlist
    if ListLegendaCausAss = nil then
    begin
      ListLegendaCausAss:=TStringList.Create;
      ListLegendaCausAss.Sorted:=True;
    end;
    if ListLegendaTurni = nil then
    begin
      ListLegendaTurni:=TStringList.Create;
      ListLegendaTurni.Sorted:=True;
    end;
    if ListLegendaDatoAgg1 = nil then
    begin
      ListLegendaDatoAgg1:=TStringList.Create;
      ListLegendaDatoAgg1.Sorted:=True;
    end;
    if ListLegendaDatoAgg2 = nil then
    begin
      ListLegendaDatoAgg2:=TStringList.Create;
      ListLegendaDatoAgg2.Sorted:=True;
    end;

    // crea clientdataset
    if not cdsLegenda.Active then
    begin
      cdsLegenda.CreateDataSet;
      cdsLegenda.LogChanges:=False;
    end;
  end
  else
  begin
    cdsLegenda.Close;
    FreeAndNil(ListLegendaCausAss);
    FreeAndNil(ListLegendaTurni);
    FreeAndNil(ListLegendaDatoAgg1);
    FreeAndNil(ListLegendaDatoAgg2);
  end;
  FVisualizzaLegenda:=Val;
end;

function TA040FPianifRepDtM2.GetNomeCompleto: Boolean;
begin
  Result:=FNomeCompleto;
end;

procedure TA040FPianifRepDtM2.SetNomeCompleto(Val: Boolean);
begin
  FNomeCompleto:=Val;
end;


//****************************************************************************//
//***************   G E S T I O N E   P R O G R E S S B A R   ****************//
//****************************************************************************//

{$IFNDEF IRISWEB}
procedure TA040FPianifRepDtM2.AzzeraProgresso;
begin
  PBarOffset:=0;
  PBarLimit:=0;
  if PBar <> nil then
  begin
    PBar.Min:=0;
    PBar.Max:=100;
    PBar.Position:=0;
    PBar.Repaint;
  end;
end;

procedure TA040FPianifRepDtM2.LimiteProgresso(Val: Integer);
var
  NewLim: Integer;
begin
  NewLim:=Val;
  if PBar <> nil then
  begin
    NewLim:=min(NewLim,PBar.Max);
    NewLim:=max(NewLim,PBar.Min);
  end;
  PBarLimit:=NewLim;
end;

procedure TA040FPianifRepDtM2.AggiornaProgresso(Attuale, Totale: Integer);
var
  NewPos: Integer;
begin
  if PBar <> nil then
  begin
    if ((Totale = 0) or (Attuale = 0)) then
      NewPos:=PBarOffset
    else
      NewPos:=PBarOffset + trunc(Attuale * (PBarLimit - PBarOffset) / Totale);
    NewPos:=min(NewPos,PBar.Max);
    NewPos:=max(NewPos,PBar.Min);
    PBar.Position:=NewPos;
    PBar.Repaint;
  end;
end;

procedure TA040FPianifRepDtM2.SettaProgresso;
begin
  if PBar <> nil then
  begin
    if (PBarLimit >= PBar.Min) and
       (PBarLimit <= PBar.Max) then
    begin
      PBar.Position:=PBarLimit;
      PBar.Repaint;
      PBarOffset:=PBarLimit;
    end;
  end;
end;
{$ENDIF}

//****************************************************************************//
//*********************   G E S T I O N E   T U R N I   **********************//
//****************************************************************************//

procedure TA040FPianifRepDtM2.GetDatiTurni;
var
  i: Integer;
  Filtro,Temp: String;
begin
  if (TipoStampa = tsTabellone) and
     (not ((dtCodice in DettaglioCella) or
           (dtOrario in DettaglioCella) or
           (dtDatoLibero in DettaglioCella) or
           (dtDatiAggiuntivi in DettaglioCella))) then
    Exit;

  if ElencoTurni = '' then
  begin
    Filtro:='';
    //selT350.ReadBuffer:=400;
  end
  else
  begin
    Filtro:='and    CODICE %s';
    Temp:='''' + StringReplace(ElencoTurni,',',''',''',[rfReplaceAll]) + '''';
    if Pos(',',Temp) = 0 then
      Temp:='= ' + Temp
    else
      Temp:='in (' + Temp + ' )';
    Filtro:=StringReplace(Filtro,'%s',Temp,[rfReplaceAll]);
    //selT350.ReadBuffer:=R180NumOccorrenzeCar(ElencoTurni,',') + 1;
  end;

  R180SetVariable(selT350,'TIPOLOGIA',TipologiaTurno);
  R180SetVariable(selT350,'FILTRO',Filtro);
  selT350.Open;
  SetLength(ArrTurni,selT350.RecordCount);
  i:=0;
  while not selT350.Eof do
  begin
    ArrTurni[i].Codice:=selT350.FieldByName('CODICE').AsString;
    ArrTurni[i].Sigla:=selT350.FieldByName('SIGLA').AsString;
    ArrTurni[i].Descrizione:=selT350.FieldByName('DESCRIZIONE').AsString;
    ArrTurni[i].OraInizio:=R180MinutiOre(R180OreMinuti(selT350.FieldByName('ORAINIZIO').AsDateTime));
    ArrTurni[i].OraFine:=R180MinutiOre(R180OreMinuti(selT350.FieldByName('ORAFINE').AsDateTime));
    ArrTurni[i].OraInizioNoSep:=StringReplace(ArrTurni[i].OraInizio,'.','',[]);
    ArrTurni[i].OraFineNoSep:=StringReplace(ArrTurni[i].OraFine,'.','',[]);
    i:=i + 1;
    selT350.Next;

    {$IFNDEF IRISWEB}AggiornaProgresso(i,selT350.RecordCount);{$ENDIF}
  end;
end;

function TA040FPianifRepDtM2._ArrTurniGetIndex(const Codice: String; p,r:Integer): Integer;
{ Funzione di ricerca dicotomica per l'array dei turni }
var
  q, Res: Integer;
begin
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < ArrTurni[q].Codice) then
      Res:=_ArrTurniGetIndex(Codice,p,q-1);
    if (Codice > ArrTurni[q].Codice) then
      Res:=_ArrTurniGetIndex(Codice,q+1,r);
    if (Codice = ArrTurni[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if ArrTurni[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
end;

function TA040FPianifRepDtM2.GetTurno(const Codice: String): TTurno;
var
  i: Integer;
begin
  // record fittizio con valori nulli
  Result.Codice:=Codice;
  Result.Sigla:='';
  Result.Descrizione:='';
  Result.OraInizio:='';
  Result.OraFine:='';
  Result.OraInizioNoSep:='';
  Result.OraFineNoSep:='';

  if Codice = '' then
    Exit;

  i:=_ArrTurniGetIndex(Codice,0,High(ArrTurni));
  if i < 0 then
    Exit;

  Result:=ArrTurni[i];
end;

procedure TA040FPianifRepDtM2.FiltroDizionario(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('TURNI REPERIBILITA',DataSet.FieldByName('CODICE').AsString)
end;



//****************************************************************************//
//*******************   G E S T I O N E   A S S E N Z E   ********************//
//****************************************************************************//

function TA040FPianifRepDtM2.IsGiornataAssenza(D: TDateTime; var Causale: String): Boolean;
begin
  Result:=False;
  Causale:='';

  // verifica se nel giorno indicato esiste un giustificativo a giornata intera
  // non di riposo e non di riposo compensativo
  selT040.Open;
  if selT040.RecordCount > 0 then
  begin
    if selT040.SearchRecord('DATA',D,[srFromBeginning]) then
    begin
      Result:=True;
      Causale:=selT040.FieldByName('CAUSALE').AsString;
    end;
  end;
end;



//****************************************************************************//
//******************   C R E A Z I O N E   D A T A S E T   *******************//
//****************************************************************************//
function TA040FPianifRepDtM2.ComponiCellaTabellone(FiltroDatoAgg1,FiltroDatoAgg2:String): TCella;
{ Compone il dettaglio delle informazioni sul turno in base al dettagliocella }
var
  MaxLen: Integer;
  Caus: String;
  function FormattaTurno(const IdxTurno: String): String;
  var
    T: TTurno;
    Turno,Orario,Priorita,DatiAgg,DatoAgg1,DatoAgg2: String;
  begin
    Result:='';

    Turno:=selT380.FieldByName('TURNO' + IdxTurno).AsString;
    Priorita:=IfThen(selT380.FieldByName('PRIORITA' + IdxTurno).IsNull,'',selT380.FieldByName('PRIORITA' + IdxTurno).AsString);
    if Turno = '' then
      Exit;
    if ElencoTurni <> '' then
      if Pos(Turno,ElencoTurni) = 0 then
        Exit;

    if RaggrDatiAgg
    and (   (selT380.FieldByName('DATOAGG1_T' + IdxTurno).AsString <> FiltroDatoAgg1)
         or (selT380.FieldByName('DATOAGG2_T' + IdxTurno).AsString <> FiltroDatoAgg2)) then
      exit;

    // estrae info turno
    T:=GetTurno(Turno);
    LegendaAdd('TURNO',T.Codice);

    // 1. codice
    if dtCodice in DettaglioCella then
    begin
      if dtSigla in DettaglioCella then
        Result:=T.Sigla
      else
        Result:=T.Codice;
      if (dtPriorita in DettaglioCella) and (Priorita <> '') then
        Result:=Result + Format('(%s)',[Priorita]);
      MaxLen:=Max(MaxLen,Length(Result));
      Result:=Result + #13#10;
    end;

    // 2. orario nel formato hhmm-hhmm
    if dtOrario in DettaglioCella then
    begin
      Orario:=Format('%s%s%s',[T.OraInizioNoSep,IfThen(dtOrarioInRiga in DettaglioCella,'-',#13#10),T.OraFineNoSep]);
      MaxLen:=Max(MaxLen,IfThen(dtOrarioInRiga in DettaglioCella,Length(Orario),4)); // 4: formato "hhmm"
      Result:=Result + Orario + #13#10;
    end;

    // 3. dati aggiuntivi
    if dtDatiAggiuntivi in DettaglioCella then
    begin
      DatoAgg1:=selT380.FieldByName('DATOAGG1_T' + IdxTurno).AsString;
      LegendaAdd('DATOAGG1',DatoAgg1);
      DatoAgg2:=selT380.FieldByName('DATOAGG2_T' + IdxTurno).AsString;
      LegendaAdd('DATOAGG2',DatoAgg2);
      DatiAgg:=DatoAgg1 +
               IfThen(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '', //Prevedo il separatore solo se gestisco anche il secondo dato aggiuntivo.
                      IfThen(dtDatiAggInRiga in DettaglioCella,
                             ' / ',                                               //Se stampo in riga, separo con la sbarra circondata da spazi.
                             #13#10)) +                                           //Se non stampo in riga, separo andando a capo (anche se i dati aggiuntivi non sono valorizzati, per buona leggibilità).
               DatoAgg2;
      MaxLen:=Max(MaxLen,IfThen(dtDatiAggInRiga in DettaglioCella,Length(DatiAgg),Max(Length(DatoAgg1),Length(DatoAgg2))));
      Result:=Result + DatiAgg + #13#10;
    end;

    Result:=Copy(Result,1,Length(Result) - 2);
  end;
  function FormattaAssenza(const Caus: String): String;
  begin
    Result:='';
    if dtCausAss in DettaglioCella then
    begin
      LegendaAdd('CAUS',Caus);
      Result:=Caus;
    end
    else if dtSiglaAss in DettaglioCella then
    begin
      LegendaAdd('CAUS',SiglaAssenza);
      Result:=SiglaAssenza;
    end;
    MaxLen:=Max(MaxLen,Length(Result));
  end;
begin
  MaxLen:=0;
  Result.T1:='';
  Result.T2:='';
  Result.T3:='';
  Result.DL:='';
  Result.Ass:='';

  // verifica se non è richiesto nessun dettaglio
  if DettaglioCella = [] then
  begin
    Result.Testo:='';
    Exit;
  end;

  // dati turno 1
  Result.T1:=FormattaTurno('1');
  // dati turno 2
  Result.T2:=FormattaTurno('2');
  // dati turno 3
  Result.T3:=FormattaTurno('3');
  // dato libero pianificabile
  if dtDatoLibero in DettaglioCella then
    Result.DL:=selT380.FieldByName('DATOLIBERO').AsString;
  // dati assenza
  if (dtCausAss in DettaglioCella) or
     (dtSiglaAss in DettaglioCella) then
  begin
    if IsGiornataAssenza(selT380.FieldByName('DATA').AsDateTime,Caus) then
      Result.Ass:=FormattaAssenza(Caus);
  end;

  // compone il dato
  Result.Testo:=Result.Ass;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.T1 <> ''),#13#10) + Result.T1;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.T2 <> ''),#13#10) + Result.T2;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.T3 <> ''),#13#10) + Result.T3;
  Result.Testo:=Result.Testo + IfThen((Result.Testo <> '') and (Result.DL <> ''),#13#10) + Result.DL;
  Result.MaxLen:=MaxLen;
end;

procedure TA040FPianifRepDtM2.CreaFieldRaggruppamento1(cds: TClientDataset);
begin
  if NomeCampoRaggr1 = '' then
    Exit;

  // determina il tipo campo
  if TipoCampoRaggr1 = 'VARCHAR2' then
    cds.FieldDefs.Add(NomeCampoRaggr1,ftString,LengthCampoRaggr1)
  else if TipoCampoRaggr1 = 'NUMBER' then
    cds.FieldDefs.Add(NomeCampoRaggr1,ftInteger)
  else if TipoCampoRaggr1 = 'DATE' then
    cds.FieldDefs.Add(NomeCampoRaggr1,ftDate);
end;

procedure TA040FPianifRepDtM2.CreaFieldRaggruppamento2(cds: TClientDataset);
begin
  if NomeCampoRaggr2 = '' then
    Exit;

  // determina il tipo campo
  if TipoCampoRaggr2 = 'VARCHAR2' then
    cds.FieldDefs.Add(NomeCampoRaggr2,ftString,LengthCampoRaggr2)
  else if TipoCampoRaggr2 = 'NUMBER' then
    cds.FieldDefs.Add(NomeCampoRaggr2,ftInteger)
  else if TipoCampoRaggr2 = 'DATE' then
    cds.FieldDefs.Add(NomeCampoRaggr2,ftDate);
end;

function TA040FPianifRepDtM2.GetNomeCampo(D: TDateTime): String;
const
  Mesi: String = 'ABCDEHLMPRST';
begin
  Result:=Format('GG_%.2d%s',[R180Giorno(D),Mesi[R180Mese(D)]]);
end;

procedure TA040FPianifRepDtM2.PreparaDati;
{ Predispone il client dataset in base ai valori attuali delle proprietà }
begin
  // controllo sul periodo
  if FDataInizio > FDataFine then
    raise Exception.Create('Il periodo indicato non è valido!');
  if R180Anno(FDataInizio) <> R180Anno(FDataFine) then
    raise Exception.Create('Le date devono essere riferite allo stesso anno!');

  // impostazioni progressbar
  {$IFNDEF IRISWEB}AzzeraProgresso;{$ENDIF}
  try
    case TipoStampa of
      tsTabellone:      CreaTabellone;
      tsProspettoDip:   CreaProspDip;
      tsProspettoRaggr: CreaProspRaggr;
    else
      raise Exception.Create('Tipologia di estrazione non supportata!');
    end;
  finally
    {$IFNDEF IRISWEB}AzzeraProgresso;{$ENDIF}
  end;
end;

function TA040FPianifRepDtM2.RivalutaCodici(pGruppo: String): TStringList;
var
  i: integer;
  LTurni: TStringList;
  T:TTurno;
begin
  try
    Result:=TStringList.Create;

    LTurni:=TStringList.Create;
    LTurni.CommaText:=A040FPianifRepDtM1.A040MW.GetCodiciTurnoUtilizzatiRaggruppamento(TabellaCampoRaggr1, NomeCampoRaggr1, pGruppo, ElencoTurni);

    // elenco di codici turno
    for i:=0 to LTurni.Count-1 do
    begin
      T:=GetTurno(LTurni[i]);
      Result.Add(Format('Turno %s%s%s - %s',[T.Codice,#13#10,T.OraInizio,T.OraFine]));
      if NomeCampoDett <> '' then
        Result.Add(NomeLogicoDett);
  end;
  finally
    FreeAndNil(LTurni);
  end;
end;

function TA040FPianifRepDtM2.GetNomeLogico(NomeCampo:String):String;
var NomeCampoApp:String;
begin
  Result:=NomeCampo;
  try
    NomeCampoApp:=NomeCampo;
    if Copy(NomeCampo,1,4) <> 'T430' then
      NomeCampoApp:='T430' + NomeCampo;
    Result:=VarToStr(selI010.Lookup('NOME_CAMPO',NomeCampoApp,'NOME_LOGICO'));
  except
  end;
end;

procedure TA040FPianifRepDtM2.selT380FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=((selT380.FieldByName('TURNO1').IsNull) or
           (A000FiltroDizionario('TURNI REPERIBILITA',selT380.FieldByName('TURNO1').AsString))) and
          ((selT380.FieldByName('TURNO2').IsNull) or
           (A000FiltroDizionario('TURNI REPERIBILITA',selT380.FieldByName('TURNO2').AsString))) and
          ((selT380.FieldByName('TURNO3').IsNull) or
           (A000FiltroDizionario('TURNI REPERIBILITA',selT380.FieldByName('TURNO3').AsString)));
end;

procedure TA040FPianifRepDtM2.ApriDatasetPianificazioni;
// Apre il dataset delle pianificazioni in base ai filtri attualmente impostati
var
  S,Ordinamento,FiltroTurni,OuterJoin,Temp,Temp2: String;
begin
  selT380.Close;
  selT380.ClearVariables;

  // include il campo di raggruppamento 1 nella selezione
  if NomeCampoRaggr1 <> '' then
  begin
    S:=selT380.SQL.Text;
    if R180InserisciColonna(S,TabellaCampoRaggr1 + '.' + NomeCampoRaggr1) then
      selT380.SQL.Text:=S;
  end;

  // include il campo di raggruppamento 2 nella selezione
  if NomeCampoRaggr2 <> '' then
  begin
    S:=selT380.SQL.Text;
    if R180InserisciColonna(S,TabellaCampoRaggr2 + '.' + NomeCampoRaggr2) then
      selT380.SQL.Text:=S;
  end;

  // include il campo con nominativo nella selezione
  if NomeCampoConNom <> '' then
  begin
    S:=selT380.SQL.Text;
    if R180InserisciColonna(S,TabellaCampoConNom + '.' + NomeCampoConNom) then
      selT380.SQL.Text:=S;
  end;

  // include il campo di dettaglio anagrafico nella selezione
  if (NomeCampoDett <> '') and (NomeCampoDett <> A040FPianifRepDtM1.A040MW.RECAPITO) then
  begin
    S:=selT380.SQL.Text;
    if R180InserisciColonna(S,TabellaCampoDett + '.' + NomeCampoDett) then
      selT380.SQL.Text:=S;
  end;

  // imposta il filtro turni (vedere anche OnFilterRecord per filtro dizionario)
  if ElencoTurni = '' then
    FiltroTurni:=''
  else
  begin
    Temp:='''' + StringReplace(ElencoTurni,',',''',''',[rfReplaceAll]) + '''';
    if Pos(',',Temp) = 0 then
      Temp:='= ' + Temp
    else
      Temp:='in (' + Temp + ')';

    // se outer join con dipendenti non pianificati si accettano anche le righe con TURNO1,TURNO2 e TURNO3 nulli
    Temp2:=IfThen(IncludiNonPianificati,' or (T380.TURNO1 is null and T380.TURNO2 is null and T380.TURNO3 is null)','');
    FiltroTurni:=Format('and    ((T380.TURNO1 %s or T380.TURNO2 %s or T380.TURNO3 %s)%s)',[Temp,Temp,Temp,Temp2]);
  end;

  // effettua una outer join se si vogliono visualizzare anche i dipendenti non pianificati nel periodo
  OuterJoin:=IfThen(IncludiNonPianificati,'(+)','');

  // applica la selezione anagrafica attuale
  C700MergeSelAnagrafe(selT380,False);
  C700MergeSettaPeriodo(selT380,DataInizio,DataFine);

  // determina ordinamento
  case TipoStampa of
    tsTabellone:      Ordinamento:='T030.PROGRESSIVO,T380.DATA';
    tsProspettoDip:   Ordinamento:='T380.DATA,T030.COGNOME,T030.NOME,T030.MATRICOLA';
    tsProspettoRaggr: Ordinamento:='T380.DATA,T030.COGNOME,T030.NOME,T030.MATRICOLA';
  end;
  if not RaggrDatiAgg and (NomeCampoRaggr1 <> '') then
    Ordinamento:=TabellaCampoRaggr1 + '.' + NomeCampoRaggr1 + ',' + Ordinamento;

  // imposta le variabili e apre il dataset
  selT380.SetVariable('TIPOLOGIA',TipologiaTurno);
  selT380.SetVariable('DATADA',DataInizio);
  selT380.SetVariable('DATAA',DataFine);
  selT380.SetVariable('FILTRO_TURNI',FiltroTurni);
  selT380.SetVariable('OUTER_JOIN',OuterJoin);
  selT380.SetVariable('ORDINAMENTO','order by ' + Ordinamento);
  selT380.Open;

  // apre il dataset di supporto per verificare i festivi infrasettimanali
  selV010.Close;
  selV010.SetVariable('DAL',DataInizio);
  selV010.SetVariable('AL',DataFine);
  if selT380.RecordCount > 0 then
    selV010.SetVariable('PROGRESSIVO',selT380.FieldByName('PROGRESSIVO').AsInteger);
  selV010.Open;
end;

function TA040FPianifRepDtM2.IsFestivo(const PData: TDateTime): Boolean;
// determina se la data indicata è una domenica o un festivo infrasettimanale
// nota: per i festivi infrasettimanali utilizza convenzionalmente il calendario
//       del primo dipendente della selezione
begin
  Result:=(DayOfWeek(PData) = 1) or
          ((selV010.Active) and
           (selV010.SearchRecord('DATA;FESTIVO',VarArrayOf([PData,'S']),[srFromBeginning]))
          );
end;

procedure TA040FPianifRepDtM2.LegendaAdd(const PTipo: String; PChiave: String);
var
  Valore: String;
  LSigla: String;
begin
  if VisualizzaLegenda then
  begin
    if (PTipo = 'CAUS') and
       ((dtCausAss in DettaglioCella) or
        (dtSiglaAss in DettaglioCella)) then
    begin
      // codice - descrizione dell'assenza
      if dtCausAss in DettaglioCella then
        Valore:=VarToStrDef(selT265.Lookup('CODICE',PChiave,'DESCRIZIONE'),'###')
      else if dtSiglaAss in DettaglioCella then
        Valore:='ASSENZA';
      if ListLegendaCausAss.IndexOfName(PChiave) < 0 then
        ListLegendaCausAss.Add(PChiave + '=' + Valore);
      MaxLengthCodCaus:=max(MaxLengthCodCaus,Length(PChiave));
      MaxLengthDescCaus:=max(MaxLengthDescCaus,Length(Valore));
    end
    else if (PTipo = 'TURNO') and
            ((dtCodice in DettaglioCella) or (TipoStampa <> tsTabellone)) then
    begin
      // codice - descrizione del turno
      Valore:=VarToStrDef(selT350.Lookup('CODICE',PChiave,'DESCRIZIONE'),'###');
      // se è richiesta la sigla, il codice divente "sigla (codice)"
      if (dtSigla in DettaglioCella) then
      begin
        LSigla:=VarToStr(selT350.Lookup('CODICE',PChiave,'SIGLA'));
        if LSigla <> '' then
          PChiave:=Format('%s (%s)',[LSigla,PChiave]);
      end;
      if ListLegendaTurni.IndexOfName(PChiave) < 0 then
        ListLegendaTurni.Add(PChiave + '=' + Valore);
      MaxLengthCodTurno:=max(MaxLengthCodTurno,Length(PChiave));
      MaxLengthDescTurno:=max(MaxLengthDescTurno,Length(Valore));
    end
    else if (PTipo = 'DATOAGG1') and
            (dtDatiAggiuntivi in DettaglioCella) and
            (Trim(PChiave) <> '') and
            selDatoAgg1.Active then
    begin
      // codice - descrizione del dato aggiuntivo 1
      Valore:=VarToStrDef(selDatoAgg1.Lookup('CODICE',PChiave,'DESCRIZIONE'),'###');
      if ListLegendaDatoAgg1.IndexOfName(PChiave) < 0 then
        ListLegendaDatoAgg1.Add(PChiave + '=' + Valore);
      MaxLengthCodDatoAgg1:=max(MaxLengthCodDatoAgg1,Length(PChiave));
      MaxLengthDescDatoAgg1:=max(MaxLengthDescDatoAgg1,Length(Valore));
    end
    else if (PTipo = 'DATOAGG2') and
            (dtDatiAggiuntivi in DettaglioCella) and
            (Trim(PChiave) <> '') and
            selDatoAgg2.Active then
    begin
      // codice - descrizione del dato aggiuntivo 2
      Valore:=VarToStrDef(selDatoAgg2.Lookup('CODICE',PChiave,'DESCRIZIONE'),'###');
      if ListLegendaDatoAgg2.IndexOfName(PChiave) < 0 then
        ListLegendaDatoAgg2.Add(PChiave + '=' + Valore);
      MaxLengthCodDatoAgg2:=max(MaxLengthCodDatoAgg2,Length(PChiave));
      MaxLengthDescDatoAgg2:=max(MaxLengthDescDatoAgg2,Length(Valore));
    end;
  end;
end;

function TA040FPianifRepDtM2.TurnoSelezionato(idxTurno:String):Boolean;
var i:Integer;
begin
  Result:=(Length(ElencoTurniArr) = 0) and (selT380.FieldByName('TURNO' + idxTurno).AsString <> '');
  if Length(ElencoTurniArr) > 0  then
    for i:=0 to High(ElencoTurniArr) do
      if R180InConcat(selT380.FieldByName('TURNO' + idxTurno).AsString,ElencoTurniArr[i]) then
      begin
        Result:=True;
        Break;
      end;
end;

function TA040FPianifRepDtM2.GetValDatoAgg(idxDatoAgg,idxTurno:String):String;
var ODS:TOracleDataSet;
begin
  Result:=selT380.FieldByName('DATOAGG' + idxDatoAgg + '_T' + idxTurno).AsString;
  try
    if idxDatoAgg = '1' then
      ODS:=selDatoAgg1
    else
      ODS:=selDatoAgg2;
    Result:=VarToStr(ODS.Lookup('CODICE',Result,'DESCRIZIONE'));
  except
  end;
end;

procedure TA040FPianifRepDtM2.CreaTabellone;
// Preparazione dataset per tabellone mensile per raggruppamento
// con calendario in orizzontale
var
  MaxLengthCella: Integer;
  idxTurno,CampoGG,Caus: String;
  D: TDateTime;
  Cella: TCella;
  T1OK,T2OK:Boolean;
  procedure CompletaPeriodo;
  // Completa la riga del dipendente con le eventuali giornate di assenza
  var D: TDateTime;
  begin
    // se i dati delle assenze non sono richiesti termina subito
    if not ((dtCausAss in DettaglioCella) or (dtSiglaAss in DettaglioCella)) then
      Exit;

    // imposta variabili per dataset assenze
    R180SetVariable(selT040,'Progressivo',selT380.FieldByName('PROGRESSIVO').AsInteger);
    selT040.Open;

    // completa il periodo
    D:=DataInizio;
    cdsPianif.Edit;
    while D <= DataFine do
    begin
      CampoGG:=GetNomeCampo(D);
      if (cdsPianif.FieldByName(CampoGG).IsNull) or
         (cdsPianif.FieldByName(CampoGG).AsString = '') then
        // se la giornata è di assenza compone il dato
        if IsGiornataAssenza(D,Caus) then
        begin
          if dtCausAss in DettaglioCella then
          begin
            LegendaAdd('CAUS',Caus);
            cdsPianif.FieldByName(CampoGG).AsString:=Caus;
          end
          else if dtSiglaAss in DettaglioCella then
          begin
            LegendaAdd('CAUS',SiglaAssenza);
            cdsPianif.FieldByName(CampoGG).AsString:=SiglaAssenza;
          end;
          MaxLengthCella:=max(MaxLengthCella,Length(cdsPianif.FieldByName(CampoGG).AsString));
        end;
      D:=D + 1;
    end;
  end;
  procedure NuovaRiga;
  var Nominativo: String;
  begin
    cdsPianif.Append;
    if NomeCampoRaggr1 <> '' then
    begin
      cdsPianif.FieldByName(NomeCampoRaggr1).Value:=selT380.FieldByName(NomeCampoRaggr1).Value;
      if RaggrDatiAgg then
      begin
        cdsPianif.FieldByName(NomeCampoRaggr1).AsString:=GetValDatoAgg('1',idxTurno);
        if NomeCampoRaggr2 <> '' then
          cdsPianif.FieldByName(NomeCampoRaggr2).AsString:=GetValDatoAgg('2',idxTurno);
      end;
    end;
    cdsPianif.FieldByName('PROGRESSIVO').AsInteger:=selT380.FieldByName('PROGRESSIVO').AsInteger;
    cdsPianif.FieldByName('MATRICOLA').AsString:=selT380.FieldByName('MATRICOLA').AsString;
    cdsPianif.FieldByName('COGNOME').AsString:=selT380.FieldByName('COGNOME').AsString;
    cdsPianif.FieldByName('NOME').AsString:=selT380.FieldByName('NOME').AsString;
    // nominativo visualizzato nel formato "[cognome] [(iniziale)nome](.) ([campo con nominativo])"
    Nominativo:=selT380.FieldByName('COGNOME').AsString + ' ' +
                IfThen(NomeCompleto,selT380.FieldByName('NOME').AsString,Copy(selT380.FieldByName('NOME').AsString,1,1) + '.') + #13#10;
    if NomeCampoConNom <> '' then
      Nominativo:=Nominativo + '('+ selT380.FieldByName(NomeCampoConNom).AsString + ')';
    cdsPianif.FieldByName('NOMINATIVO').AsString:=Nominativo;
    CompletaPeriodo;
    cdsPianif.Post;
  end;
  procedure RecuperaRiga;
  begin
    if NomeCampoRaggr2 <> '' then  //solo per RaggrDatiAgg
    begin
      if not cdsPianif.Locate(NomeCampoRaggr1 + ';' + NomeCampoRaggr2 + ';PROGRESSIVO',VarArrayOf([GetValDatoAgg('1',idxTurno),GetValDatoAgg('2',idxTurno),selT380.FieldByName('PROGRESSIVO').AsInteger]),[]) then
        NuovaRiga;
    end
    else if NomeCampoRaggr1 <> '' then
    begin
      if RaggrDatiAgg then
      begin
        if not cdsPianif.Locate(NomeCampoRaggr1 + ';PROGRESSIVO',VarArrayOf([GetValDatoAgg('1',idxTurno),selT380.FieldByName('PROGRESSIVO').AsInteger]),[]) then
          NuovaRiga;
      end
      else if not cdsPianif.Locate(NomeCampoRaggr1 + ';PROGRESSIVO',VarArrayOf([selT380.FieldByName(NomeCampoRaggr1).Value,selT380.FieldByName('PROGRESSIVO').AsInteger]),[]) then
        NuovaRiga;
    end
    else if not cdsPianif.Locate('PROGRESSIVO',VarArrayOf([selT380.FieldByName('PROGRESSIVO').AsInteger]),[]) then
      NuovaRiga;
  end;
  procedure ImpostaCella;
  begin
    cdsPianif.Edit;
    CampoGG:=GetNomeCampo(selT380.FieldByName('DATA').AsDateTime);
    Cella:=ComponiCellaTabellone(selT380.FieldByName('DATOAGG1_T' + idxTurno).AsString,selT380.FieldByName('DATOAGG2_T' + idxTurno).AsString);
    cdsPianif.FieldByName(CampoGG).AsString:=Cella.Testo;
    MaxLengthCella:=max(MaxLengthCella,Cella.MaxLen);
    cdsPianif.Post;
  end;
begin
  // prepara il dataset delle assenze
  if (dtCausAss in DettaglioCella) or
     (dtSiglaAss in DettaglioCella) then
  begin
    selT040.Close;
    selT040.ClearVariables;
    R180SetVariable(selT040,'DataDa',DataInizio);
    R180SetVariable(selT040,'DataA',DataFine);
  end;

  // estrae dati in array di supporto
  {$IFNDEF IRISWEB}LimiteProgresso(30);{$ENDIF}
  GetDatiTurni;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  // clear delle stringlist di legenda
  if VisualizzaLegenda then
  begin
    ListLegendaCausAss.Clear;
    ListLegendaTurni.Clear;
    ListLegendaDatoAgg1.Clear;
    ListLegendaDatoAgg2.Clear;
    MaxLengthCodCaus:=0;
    MaxLengthDescCaus:=0;
    MaxLengthCodTurno:=0;
    MaxLengthDescTurno:=0;
    MaxLengthCodDatoAgg1:=0;
    MaxLengthDescDatoAgg1:=0;
    MaxLengthCodDatoAgg2:=0;
    MaxLengthDescDatoAgg2:=0;
  end;

  // prepara il dataset di supporto
  ApriDatasetPianificazioni;

  // crea i field del client dataset
  cdsPianif.Close;
  cdsPianif.FieldDefs.Clear;
  if NomeCampoRaggr1 <> '' then
  begin
    CreaFieldRaggruppamento1(cdsPianif);
    CreaFieldRaggruppamento2(cdsPianif);
  end;
  cdsPianif.FieldDefs.Add('PROGRESSIVO',ftInteger);
  cdsPianif.FieldDefs.Add('MATRICOLA',ftString,8);
  cdsPianif.FieldDefs.Add('COGNOME',ftString,50);
  cdsPianif.FieldDefs.Add('NOME',ftString,50);
  cdsPianif.FieldDefs.Add('NOMINATIVO',ftString,100); // [cognome] [(iniz.)nome] [(campo con nominativo)]
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldDefs.Add(CampoGG,ftString,IfThen(dtDatiAggiuntivi in DettaglioCella,200,IfThen(dtDatoLibero in DettaglioCella,100,80)));
    D:=D + 1;
  end;

  // predispone indici per il dataset
  cdsPianif.IndexDefs.Clear;
  if NomeCampoRaggr1 = '' then
    cdsPianif.IndexDefs.Add('Primario','COGNOME;NOME',[])
  else
    cdsPianif.IndexDefs.Add('Primario',NomeCampoRaggr1 + IfThen(NomeCampoRaggr2 <> '',';' + NomeCampoRaggr2) + ';COGNOME;NOME',[]);
  cdsPianif.IndexName:='Primario';

  // crea dataset e imposta proprietà dei field
  cdsPianif.CreateDataSet;
  cdsPianif.LogChanges:=False;
  if NomeCampoRaggr1 <> '' then
    cdsPianif.FieldByName(NomeCampoRaggr1).Tag:=TAG_NO_PRINT;
  if NomeCampoRaggr2 <> '' then
    cdsPianif.FieldByName(NomeCampoRaggr2).Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('PROGRESSIVO').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('MATRICOLA').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('COGNOME').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('NOME').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('NOMINATIVO').DisplayLabel:='Nominativo';
  cdsPianif.FieldByName('NOMINATIVO').DisplayWidth:=13;
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldByName(CampoGG).DisplayLabel:=Copy(R180NomeGiorno(D),1,2) + #13#10 +
                                                 Format('%.2d',[R180Giorno(D)]);
    cdsPianif.FieldByName(CampoGG).DisplayWidth:=5; // codice turno: 5 car., codice ass: 5 car., orario: 4 car.
    cdsPianif.FieldByName(CampoGG).Alignment:=taCenter;
    cdsPianif.FieldByName(CampoGG).Tag:=IfThen(IsFestivo(D),TAG_EVIDENZIA_FESTIVI,0); //IfThen(DayOfWeek(D) = 1,TAG_EVIDENZIA_DOMENICHE,0);
    D:=D + 1;
  end;

  // ciclo di inserimento nel client dataset
  {$IFNDEF IRISWEB}LimiteProgresso(100);{$ENDIF}
  cdsPianif.DisableControls;
  MaxLengthCella:=0;
  while not selT380.Eof do
  begin
    idxTurno:='1';
    T1OK:=False;
    if selT380.FieldByName('DATA').IsNull or (not RaggrDatiAgg) or TurnoSelezionato(idxTurno) then
    begin
      RecuperaRiga;
      T1OK:=True;
    end;
    // se la data è valorizzata compila la cella con i dati della pianificazione
    // il caso opposto si verifica per effetto dell'outer join
    // (che serve per avere l'elenco di tutti i progressivi)
    if not selT380.FieldByName('DATA').IsNull then
    begin
      if T1OK then
        ImpostaCella;
      //se raggruppo per dati aggiuntivi pianificati...
      if RaggrDatiAgg then
      begin
        //..creo e popolo una nuova riga se il secondo turno del giorno ha dati aggiuntivi diversi da quelli del primo turno
        idxTurno:='2';
        T2OK:=False;
        if TurnoSelezionato(idxTurno)
        and (   (not T1OK)
             or (   (selT380.FieldByName('DATOAGG1_T1').AsString <> selT380.FieldByName('DATOAGG1_T2').AsString)
                 or (selT380.FieldByName('DATOAGG2_T1').AsString <> selT380.FieldByName('DATOAGG2_T2').AsString))) then
        begin
          RecuperaRiga;
          T2OK:=True;
          ImpostaCella;
        end;
        //...creo e popolo una nuova riga se il terzo turno del giorno ha dati aggiuntivi diversi da quelli del primo e del secondo turno
        idxTurno:='3';
        if TurnoSelezionato(idxTurno)
        and (   (not T1OK)
             or (   (selT380.FieldByName('DATOAGG1_T1').AsString <> selT380.FieldByName('DATOAGG1_T3').AsString)
                 or (selT380.FieldByName('DATOAGG2_T1').AsString <> selT380.FieldByName('DATOAGG2_T3').AsString)))
        and (   (not T2OK)
             or (   (selT380.FieldByName('DATOAGG1_T2').AsString <> selT380.FieldByName('DATOAGG1_T3').AsString)
                 or (selT380.FieldByName('DATOAGG2_T2').AsString <> selT380.FieldByName('DATOAGG2_T3').AsString))) then
        begin
          RecuperaRiga;
          ImpostaCella;
        end;
      end;
    end;
    // passa al prossimo record
    {$IFNDEF IRISWEB}AggiornaProgresso(selT380.RecNo,selT380.RecordCount);{$ENDIF}
    selT380.Next;
  end; //==> while not eof
  selT380.Close;

  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}
  
  // adatta width cella tabellone in base alle informazioni contenute
  MaxLengthCella:=max(3,MaxLengthCella);
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldByName(CampoGG).DisplayWidth:=MaxLengthCella;
    D:=D + 1;
  end;

  cdsPianif.First;
  cdsPianif.EnableControls;

  // se richiesto crea il clientdataset per la legenda
  if VisualizzaLegenda then
    CreaLegenda;
end;

procedure TA040FPianifRepDtM2.CreaLegenda;
// Crea il dataset per la legenda di turni e assenze
var
  i: Integer;
begin
  cdsLegenda.DisableControls;
  cdsLegenda.EmptyDataSet;

  // turni pianificati
  cdsLegenda.FieldByName('CODTURNO').Visible:=(ListLegendaTurni.Count > 0);
  cdsLegenda.FieldByName('CODTURNO').DisplayWidth:=IfThen(cdsLegenda.FieldByName('CODTURNO').Visible,MaxLengthCodTurno,0);
  cdsLegenda.FieldByName('DESCTURNO').Visible:=(ListLegendaTurni.Count > 0);
  cdsLegenda.FieldByName('DESCTURNO').DisplayWidth:=IfThen(cdsLegenda.FieldByName('CODTURNO').Visible,MaxLengthDescTurno,0);
  for i:=0 to ListLegendaTurni.Count - 1 do
  begin
    cdsLegenda.Append;
    cdsLegenda.FieldByName('CODTURNO').AsString:=ListLegendaTurni.Names[i];
    cdsLegenda.FieldByName('DESCTURNO').AsString:=ListLegendaTurni.ValueFromIndex[i];
    cdsLegenda.Post;
  end;

  // causali di assenza
  cdsLegenda.FieldByName('CODCAUS').Visible:=(ListLegendaCausAss.Count > 0);
  cdsLegenda.FieldByName('CODCAUS').DisplayWidth:=IfThen(cdsLegenda.FieldByName('CODCAUS').Visible,MaxLengthCodCaus,0);
  cdsLegenda.FieldByName('DESCCAUS').Visible:=(ListLegendaCausAss.Count > 0);
  cdsLegenda.FieldByName('DESCCAUS').DisplayWidth:=IfThen(cdsLegenda.FieldByName('CODCAUS').Visible,MaxLengthDescCaus,0);
  cdsLegenda.First;
  for i:=0 to ListLegendaCausAss.Count - 1 do
  begin
    if cdsLegenda.Eof then
      cdsLegenda.Append
    else
      cdsLegenda.Edit;
    cdsLegenda.FieldByName('CODCAUS').AsString:=ListLegendaCausAss.Names[i];
    cdsLegenda.FieldByName('DESCCAUS').AsString:=ListLegendaCausAss.ValueFromIndex[i];
    cdsLegenda.Post;
    cdsLegenda.Next;
  end;

  // dato aggiuntivo 1
  cdsLegenda.FieldByName('CODDATOAGG1').Visible:=(ListLegendaDatoAgg1.Count > 0);
  cdsLegenda.FieldByName('CODDATOAGG1').DisplayWidth:=IfThen(cdsLegenda.FieldByName('CODDATOAGG1').Visible,MaxLengthCodDatoAgg1,0);
  cdsLegenda.FieldByName('DESCDATOAGG1').Visible:=(ListLegendaDatoAgg1.Count > 0);
  cdsLegenda.FieldByName('DESCDATOAGG1').DisplayWidth:=IfThen(cdsLegenda.FieldByName('DESCDATOAGG1').Visible,MaxLengthDescDatoAgg1,0);
  cdsLegenda.First;
  for i:=0 to ListLegendaDatoAgg1.Count - 1 do
  begin
    if cdsLegenda.Eof then
      cdsLegenda.Append
    else
      cdsLegenda.Edit;
    cdsLegenda.FieldByName('CODDATOAGG1').AsString:=ListLegendaDatoAgg1.Names[i];
    cdsLegenda.FieldByName('DESCDATOAGG1').AsString:=ListLegendaDatoAgg1.ValueFromIndex[i];
    cdsLegenda.Post;
    cdsLegenda.Next;
  end;

  // dato aggiuntivo 2
  cdsLegenda.FieldByName('CODDATOAGG2').Visible:=(ListLegendaDatoAgg2.Count > 0);
  cdsLegenda.FieldByName('CODDATOAGG2').DisplayWidth:=IfThen(cdsLegenda.FieldByName('CODDATOAGG2').Visible,MaxLengthCodDatoAgg2,0);
  cdsLegenda.FieldByName('DESCDATOAGG2').Visible:=(ListLegendaDatoAgg2.Count > 0);
  cdsLegenda.FieldByName('DESCDATOAGG2').DisplayWidth:=IfThen(cdsLegenda.FieldByName('DESCDATOAGG2').Visible,MaxLengthDescDatoAgg2,0);
  cdsLegenda.First;
  for i:=0 to ListLegendaDatoAgg2.Count - 1 do
  begin
    if cdsLegenda.Eof then
      cdsLegenda.Append
    else
      cdsLegenda.Edit;
    cdsLegenda.FieldByName('CODDATOAGG2').AsString:=ListLegendaDatoAgg2.Names[i];
    cdsLegenda.FieldByName('DESCDATOAGG2').AsString:=ListLegendaDatoAgg2.ValueFromIndex[i];
    cdsLegenda.Post;
    cdsLegenda.Next;
  end;

  cdsLegenda.EnableControls;
  cdsLegenda.First;
end;

procedure TA040FPianifRepDtM2.CreaProspDip;
// Preparazione dataset per prospetto mensile per dipendente
//  con calendario in verticale
var
  i,j,p: Integer;
  idxTurno: String;
  OldRaggruppamento: String;
  T: TTurno;
  BckElencoTurniArr: String;
  NrColonne, NumMaxTurni: Integer;
  LstTurni: TStringList;
const
  MAX_NOMINATIVI_TURNO = 6;
  LUNG_NOMINATIVO = 100;

  procedure NuovaRiga;
  var D: TDateTime;
  begin
    D:=DataInizio;
    while D <= DataFine do
    begin
      cdsPianif.Append;
      if NomeCampoRaggr1 <> '' then
      begin
        cdsPianif.FieldByName(NomeCampoRaggr1).Value:=selT380.FieldByName(NomeCampoRaggr1).Value;
        if RaggrDatiAgg then
        begin
          cdsPianif.FieldByName(NomeCampoRaggr1).AsString:=GetValDatoAgg('1',idxTurno);
          if NomeCampoRaggr2 <> '' then
            cdsPianif.FieldByName(NomeCampoRaggr2).AsString:=GetValDatoAgg('2',idxTurno);
        end;
      end;
      cdsPianif.FieldByName('DATA').AsDateTime:=D;
      cdsPianif.FieldByName('DD').AsString:=FormatDateTime('dd',D);
      cdsPianif.FieldByName('GG').AsString:=FormatDateTime('ddd dd',D);//Copy(R180NomeGiorno(D),1,3);
      cdsPianif.Post;
      D:=D + 1;
      {$IFNDEF IRISWEB}AggiornaProgresso(trunc(D),trunc(DataFine));{$ENDIF}
    end;
  end;
  procedure RecuperaRiga;
  begin
    if NomeCampoRaggr2 <> '' then //solo per RaggrDatiAgg
    begin
      if not cdsPianif.Locate(NomeCampoRaggr1 + ';' + NomeCampoRaggr2 + ';DATA',VarArrayOf([GetValDatoAgg('1',idxTurno),GetValDatoAgg('2',idxTurno),selT380.FieldByName('DATA').AsDateTime]),[]) then
      begin
        NuovaRiga;
        cdsPianif.Locate(NomeCampoRaggr1 + ';' + NomeCampoRaggr2 + ';DATA',VarArrayOf([GetValDatoAgg('1',idxTurno),GetValDatoAgg('2',idxTurno),selT380.FieldByName('DATA').AsDateTime]),[]);
      end;
    end
    else if NomeCampoRaggr1 <> '' then
    begin
      if RaggrDatiAgg then
      begin
        if not cdsPianif.Locate(NomeCampoRaggr1 + ';DATA',VarArrayOf([GetValDatoAgg('1',idxTurno),selT380.FieldByName('DATA').AsDateTime]),[]) then
        begin
          NuovaRiga;
          cdsPianif.Locate(NomeCampoRaggr1 + ';DATA',VarArrayOf([GetValDatoAgg('1',idxTurno),selT380.FieldByName('DATA').AsDateTime]),[]);
        end;
      end
      else if not cdsPianif.Locate(NomeCampoRaggr1 + ';DATA',VarArrayOf([selT380.FieldByName(NomeCampoRaggr1).Value,selT380.FieldByName('DATA').AsDateTime]),[]) then
      begin
        NuovaRiga;
        cdsPianif.Locate(NomeCampoRaggr1 + ';DATA',VarArrayOf([selT380.FieldByName(NomeCampoRaggr1).Value,selT380.FieldByName('DATA').AsDateTime]),[]);
      end;
    end
    else if not cdsPianif.Locate('DATA',VarArrayOf([selT380.FieldByName('DATA').AsDateTime]),[]) then
    begin
      NuovaRiga;
      cdsPianif.Locate('DATA',VarArrayOf([selT380.FieldByName('DATA').AsDateTime]),[]);
    end;
  end;
  procedure ImpostaCella(idxCampoTurno:Integer);// nrTurno:Integer);
  var CampoTn,ValCampoTn,Nominativo,Dettaglio: String;
  begin
    if RaggrDatiAgg then
    begin
      if cdsPianif.FieldByName(NomeCampoRaggr1).AsString <> GetValDatoAgg('1',idxTurno) then
        exit;
      if NomeCampoRaggr2 <> '' then
        if cdsPianif.FieldByName(NomeCampoRaggr2).AsString <> GetValDatoAgg('2',idxTurno) then
          exit;
    end;
    cdsPianif.Edit;
    // aggiunge il nominativo
    CampoTn:=Format('TURNO_%.1d',[idxCampoTurno]);
    ValCampoTn:=cdsPianif.FieldByName(CampoTn).AsString;
    Nominativo:=selT380.FieldByName('COGNOME').AsString + ' ' +
                IfThen(NomeCompleto,selT380.FieldByName('NOME').AsString,Copy(selT380.FieldByName('NOME').AsString,1,1) + '.');
    if not selT380.FieldByName('PRIORITA' + idxTurno).IsNull then
      Nominativo:=Nominativo + Format('(%s)',[selT380.FieldByName('PRIORITA' + idxTurno).AsString]);
    if NomeCampoConNom <> '' then
      Nominativo:=Nominativo + ' (' + selT380.FieldByName(NomeCampoConNom).AsString + ')';
    cdsPianif.FieldByName(CampoTn).AsString:=IfThen(ValCampoTn <> '',ValCampoTn + #13#10) + Nominativo;
    // aggiunge il dettaglio anagrafico
    if NomeCampoDett <> '' then
    begin
      CampoTn:=CampoTn + '_DETT';
      ValCampoTn:=cdsPianif.FieldByName(CampoTn).AsString;
      if NomeCampoDett = A040FPianifRepDtM1.A040MW.RECAPITO then
        Dettaglio:=selT380.FieldByName(NomeCampoDett + idXTurno).AsString
      else
        Dettaglio:=selT380.FieldByName(NomeCampoDett).AsString;
      cdsPianif.FieldByName(CampoTn).AsString:=IfThen(ValCampoTn <> '',ValCampoTn + #13#10) + Dettaglio;
    end;
    cdsPianif.Post;
  end;
begin
  if ElencoTurni = '' then
    raise ExceptionNoLog.Create('Nessun turno specificato!');

  {$IFNDEF IRISWEB}LimiteProgresso(10);{$ENDIF}
  GetDatiTurni;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  // crea i field del client dataset
  cdsPianif.Close;
  cdsPianif.FieldDefs.Clear;
  if NomeCampoRaggr1 <> '' then
    CreaFieldRaggruppamento1(cdsPianif);
  if NomeCampoRaggr2 <> '' then
    CreaFieldRaggruppamento2(cdsPianif);
  cdsPianif.FieldDefs.Add('DATA',ftDate);
  cdsPianif.FieldDefs.Add('DD',ftString,2);
  cdsPianif.FieldDefs.Add('GG',ftString,6{3});

  if A040FPianifRepDtM1.A040MW.StampaTurniOttimizzata then
    if not RaggrDatiAgg then
      NumMaxTurni:=A040FPianifRepDtM1.A040MW.GetNumMaxTurniUtilizzati(TabellaCampoRaggr1 + '.' + NomeCampoRaggr1, DataInizio, DataFine)
    else
      NumMaxTurni:=A040FPianifRepDtM1.A040MW.GetNumMaxTurniUtilizzati(A040FPianifRepDtM1.A040MW.DATIAGG, DataInizio, DataFine)
  else
    NumMaxTurni:=0;

  NumMaxTurni:=Min(NumMaxTurni, High(ElencoTurniArr)+1);  //Limita comunque il nr di colonne al nr di turni indicato

  if NumMaxTurni > 0 then
    NrColonne:=Min(A040FPianifRepDtM1.A040MW.MAX_CODICI, NumMaxTurni)
  else
    NrColonne:=Min(A040FPianifRepDtM1.A040MW.MAX_CODICI, High(ElencoTurniArr)+1);

  for i:=0 to NrColonne-1 do
  begin
    cdsPianif.FieldDefs.Add(Format('TURNO_%.1d',[i]),ftString,(LUNG_NOMINATIVO + 2) * MAX_NOMINATIVI_TURNO); // nominativo = 33 caratteri * MAX_NOMINATIVI_TURNO
    if NomeCampoDett <> '' then
      cdsPianif.FieldDefs.Add(Format('TURNO_%.1d_DETT',[i]),ftString,(LengthCampoDettStr + 2) * MAX_NOMINATIVI_TURNO);
  end;

  // predispone indici per il dataset
  cdsPianif.IndexDefs.Clear;
  if NomeCampoRaggr1 = '' then
    cdsPianif.IndexDefs.Add('Primario','DATA',[])
  else
    cdsPianif.IndexDefs.Add('Primario',NomeCampoRaggr1 + IfThen(NomeCampoRaggr2 <> '',';' + NomeCampoRaggr2) + ';DATA',[]);
  cdsPianif.IndexName:='Primario';

  // crea dataset e imposta proprietà dei field
  {$IFNDEF IRISWEB}LimiteProgresso(20);{$ENDIF}
  cdsPianif.CreateDataSet;
  cdsPianif.LogChanges:=False;
  if NomeCampoRaggr1 <> '' then
    cdsPianif.FieldByName(NomeCampoRaggr1).Tag:=TAG_NO_PRINT;
  if NomeCampoRaggr2 <> '' then
    cdsPianif.FieldByName(NomeCampoRaggr2).Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('DATA').Tag:=TAG_NO_PRINT;
  cdsPianif.FieldByName('DD').DisplayLabel:=' ';
  cdsPianif.FieldByName('DD').DisplayWidth:=3;
  cdsPianif.FieldByName('DD').Tag:=TAG_NO_RIPROPORZIONA + TAG_EVIDENZIA_FESTIVI;
  cdsPianif.FieldByName('GG').DisplayLabel:=' ';
  cdsPianif.FieldByName('GG').DisplayWidth:=4;
  cdsPianif.FieldByName('GG').Tag:=TAG_NO_RIPROPORZIONA + TAG_EVIDENZIA_FESTIVI;

  for i:=0 to NrColonne-1 do
  begin
    if ElencoOrari <> '' then
    begin
      // legge il primo turno nell'elenco (in ogni elemento dell'array l'orario è uguale per tutti i turni)
      p:=Pos(',',ElencoTurniArr[i]);
      if p = 0 then
        T:=GetTurno(ElencoTurniArr[i])
      else
        T:=GetTurno(Copy(ElencoTurniArr[i],1,p - 1));
      cdsPianif.FieldByName(Format('TURNO_%.1d',[i])).DisplayLabel:=Format('Turno %s - %s',[T.OraInizio,T.OraFine]);
    end
    else
    begin
      // elenco di codici turno
      T:=GetTurno(ElencoTurniArr[i]);
      cdsPianif.FieldByName(Format('TURNO_%.1d',[i])).DisplayLabel:=Format('Turno %s%s%s - %s',[T.Codice,#13#10,T.OraInizio,T.OraFine]);
    end;
    cdsPianif.FieldByName(Format('TURNO_%.1d',[i])).DisplayWidth:=LUNG_NOMINATIVO;

    if NomeCampoDett <> '' then
    begin
      cdsPianif.FieldByName(Format('TURNO_%.1d_DETT',[i])).DisplayLabel:=IfThen(NomeLogicoDett <> A040FPianifRepDtM1.A040MW.RECAPITO, NomeLogicoDett, 'Recapito alternativo');
      cdsPianif.FieldByName(Format('TURNO_%.1d_DETT',[i])).DisplayWidth:=LengthCampoDettStr;
      cdsPianif.FieldByName(Format('TURNO_%.1d_DETT',[i])).Tag:=TAG_NO_RIPROPORZIONA;
    end;
    {$IFNDEF IRISWEB}AggiornaProgresso(i,High(ElencoTurniArr));{$ENDIF}
  end;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  ApriDatasetPianificazioni;

  // ciclo di inserimento nel client dataset
  {$IFNDEF IRISWEB}LimiteProgresso(100);{$ENDIF}
  cdsPianif.DisableControls;
  BckElencoTurniArr:=ElencoTurni;
  if RaggrDatiAgg then
  begin
    LstTurni:=TStringList.Create;
    LstTurni.Sorted:=True;
    LstTurni.Duplicates:=dupIgnore;

    if Assigned(A040FPianifRepDtM1.A040MW.evtMergeSelAnagrafe) then
      A040FPianifRepDtM1.A040MW.evtMergeSelAnagrafe(A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg);
    A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.SetVariable('TIPOLOGIA',A040FPianifRepDtM1.A040MW.selTurni.GetVariable('TIPOLOGIA'));
    A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.SetVariable('DATA1',A040FPianifRepDtM1.A040MW.selTurni.GetVariable('DATA1'));
    A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.SetVariable('DATA2',A040FPianifRepDtM1.A040MW.selTurni.GetVariable('DATA2'));
    A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.SetVariable('RAGGRUPPAMENTO',A040FPianifRepDtM1.A040MW.selTurni.GetVariable('RAGGRUPPAMENTO'));
    A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.Open;
    A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.First;
    while not A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.Eof do
    begin
      selT380.First;
      while not selT380.Eof do
      begin
        LstTurni.Clear;
        if (ElencoOrari = '') and A040FPianifRepDtM1.A040MW.StampaTurniOttimizzata then
        begin
          for p:=1 to 3 do
          begin
            if (selT380.FieldByname(Format('DATOAGG1_T%.1d',[p])).AsString = A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.FieldByName('DATOAGG1').AsString) and
               (selT380.FieldByname(Format('DATOAGG2_T%.1d',[p])).AsString = A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.FieldByName('DATOAGG2').AsString) then
              LstTurni.Add(selT380.FieldByname(Format('TURNO%.1d',[p])).AsString);
          end;
          if LstTurni.Count > 0 then
            ElencoTurni:=LstTurni.CommaText
          else
            ElencoTurni:='';
        end;

        for i:=0 to Min(High(ElencoTurniArr), NrColonne-1) do
        begin
          idxTurno:='';
          for j:=1 to 3 do
            if R180InConcat(selT380.FieldByName('TURNO' + IntToStr(j)).AsString,ElencoTurniArr[i]) then
            begin
              idxTurno:=IntToStr(j);
              RecuperaRiga;
              ImpostaCella(j-1);
            end;
        end;
        selT380.Next;
      end;
      {$IFNDEF IRISWEB}AggiornaProgresso(selT380.RecNo,selT380.RecordCount);{$ENDIF}

      A040FPianifRepDtM1.A040MW.selPermutazioniDatiAgg.Next;
    end; FreeAndNil(LstTurni);
  end
  else
  begin
    while not selT380.Eof do
    begin
      if (ElencoOrari = '') and A040FPianifRepDtM1.A040MW.StampaTurniOttimizzata then
      begin
        if selT380.FieldByname(NomeCampoRaggr1).AsString <> OldRaggruppamento then
        begin
          OldRaggruppamento:=selT380.FieldByname(NomeCampoRaggr1).AsString;
          ElencoTurni:=A040FPianifRepDtM1.A040MW.GetCodiciTurnoUtilizzatiRaggruppamento(TabellaCampoRaggr1, NomeCampoRaggr1, selT380.FieldByname(NomeCampoRaggr1).AsString, BckElencoTurniArr);
        end;
      end;

      for i:=0 to Min(High(ElencoTurniArr), NrColonne-1) do
      begin
        idxTurno:='';
        for j:=1 to 3 do
          if R180InConcat(selT380.FieldByName('TURNO' + IntToStr(j)).AsString,ElencoTurniArr[i]) then
            idxTurno:=IntToStr(j);
        if idxTurno <> '' then
        begin
          RecuperaRiga;
          ImpostaCella(i);
        end;
      end;
      {$IFNDEF IRISWEB}AggiornaProgresso(selT380.RecNo,selT380.RecordCount);{$ENDIF}
      selT380.Next;
    end;
  end;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}
  selT380.Close;

  cdsPianif.First;
  cdsPianif.EnableControls;

  ElencoTurni:=BckElencoTurniArr;
end;

procedure TA040FPianifRepDtM2.CreaProspRaggr;
// Preparazione dataset per prospetto settimanale
//  con calendario in orizzontale
var
  CampoGG,ValCampoGG,idxTurno,Nominativo: String;
  D: TDateTime;
  T1OK,T2OK:Boolean;

  procedure NuovaRiga;
  begin
    cdsPianif.Append;
    cdsPianif.FieldByName(NomeCampoRaggr1).Value:=selT380.FieldByName(NomeCampoRaggr1).Value;
    if RaggrDatiAgg then
    begin
      cdsPianif.FieldByName(NomeCampoRaggr1).AsString:=GetValDatoAgg('1',idxTurno);
      if NomeCampoRaggr2 <> '' then
        cdsPianif.FieldByName(NomeCampoRaggr2).AsString:=GetValDatoAgg('2',idxTurno);
    end;
    cdsPianif.Post;
  end;
  procedure RecuperaRiga;
  begin
    if NomeCampoRaggr2 <> '' then  //solo per RaggrDatiAgg
    begin
      if not cdsPianif.Locate(NomeCampoRaggr1 + ';' + NomeCampoRaggr2,VarArrayOf([GetValDatoAgg('1',idxTurno),GetValDatoAgg('2',idxTurno)]),[]) then
        NuovaRiga;
    end
    else if RaggrDatiAgg then
    begin
      if not cdsPianif.Locate(NomeCampoRaggr1,VarArrayOf([GetValDatoAgg('1',idxTurno)]),[]) then
        NuovaRiga;
    end
    else if not cdsPianif.Locate(NomeCampoRaggr1,VarArrayOf([selT380.FieldByName(NomeCampoRaggr1).Value]),[]) then
      NuovaRiga;
  end;
  procedure ImpostaCella;
  var Nominativo: String;
  begin
    cdsPianif.Edit;
    // aggiunge il nominativo
    CampoGG:=GetNomeCampo(selT380.FieldByName('DATA').AsDateTime);
    ValCampoGG:=cdsPianif.FieldByName(CampoGG).AsString;
    // nominativo visualizzato nel formato "cognome + iniziale nome"
    Nominativo:=selT380.FieldByName('COGNOME').AsString + ' ' +
                Copy(selT380.FieldByName('NOME').AsString,1,1) + '.';
    if not selT380.FieldByName('PRIORITA' + idxTurno).IsNull then
      Nominativo:=Nominativo + Format('(%s)',[selT380.FieldByName('PRIORITA' + idxTurno).AsString]);
    cdsPianif.FieldByName(CampoGG).AsString:=IfThen(ValCampoGG <> '',ValCampoGG + #13#10) + Nominativo;
    cdsPianif.Post;
  end;
begin
  if NomeCampoRaggr1 = '' then
    raise Exception.Create('E'' necessario indicare un campo di raggruppamento per questa stampa!');

  {$IFNDEF IRISWEB}LimiteProgresso(10);{$ENDIF}
  GetDatiTurni;
  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  // crea i field del client dataset
  cdsPianif.Close;
  cdsPianif.FieldDefs.Clear;
  CreaFieldRaggruppamento1(cdsPianif);
  if NomeCampoRaggr2 <> '' then
    CreaFieldRaggruppamento2(cdsPianif);
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldDefs.Add(CampoGG,ftString,100);
    D:=D + 1;
  end;

  // predispone indici per il dataset
  cdsPianif.IndexDefs.Clear;
  cdsPianif.IndexDefs.Add('Primario',NomeCampoRaggr1 + IfThen(NomeCampoRaggr2 <> '',';' + NomeCampoRaggr2),[ixPrimary]);
  cdsPianif.IndexName:='Primario';

  // apre i dataset di supporto
  ApriDatasetPianificazioni;

  // crea dataset e imposta proprietà dei field
  cdsPianif.CreateDataSet;
  cdsPianif.LogChanges:=False;
  cdsPianif.FieldByName(NomeCampoRaggr1).DisplayWidth:=min(cdsPianif.FieldByName(NomeCampoRaggr1).DisplayWidth,30);
  cdsPianif.FieldByName(NomeCampoRaggr1).DisplayLabel:=NomeLogicoRaggr1;
  if NomeCampoRaggr2 <> '' then
  begin
    cdsPianif.FieldByName(NomeCampoRaggr2).DisplayWidth:=min(cdsPianif.FieldByName(NomeCampoRaggr2).DisplayWidth,30);
    cdsPianif.FieldByName(NomeCampoRaggr2).DisplayLabel:=NomeLogicoRaggr2;
  end;
  D:=DataInizio;
  while D <= DataFine do
  begin
    CampoGG:=GetNomeCampo(D);
    cdsPianif.FieldByName(CampoGG).DisplayWidth:=15;
    cdsPianif.FieldByName(CampoGG).DisplayLabel:=R180NomeGiorno(D) + ' ' + FormatDateTime('dd/mm',D);
    cdsPianif.FieldByName(CampoGG).Tag:=IfThen(IsFestivo(D),TAG_EVIDENZIA_FESTIVI,0); //IfThen(DayOfWeek(D) = 1,TAG_EVIDENZIA_DOMENICHE,0);
    D:=D + 1;
  end;

  // ciclo di inserimento nel client dataset
  {$IFNDEF IRISWEB}LimiteProgresso(100);{$ENDIF}
  cdsPianif.DisableControls;
  while not selT380.Eof do
  begin
    idxTurno:='1';
    T1OK:=False;
    if (not RaggrDatiAgg) or TurnoSelezionato(idxTurno) then
    begin
      RecuperaRiga;
      T1OK:=True;
      ImpostaCella;
    end;
    if RaggrDatiAgg then
    begin
      //..creo e popolo una nuova riga se il secondo turno del giorno ha dati aggiuntivi diversi da quelli del primo turno
      idxTurno:='2';
      T2OK:=False;
      if TurnoSelezionato(idxTurno)
      and (   (not T1OK)
           or (   (selT380.FieldByName('DATOAGG1_T1').AsString <> selT380.FieldByName('DATOAGG1_T2').AsString)
               or (selT380.FieldByName('DATOAGG2_T1').AsString <> selT380.FieldByName('DATOAGG2_T2').AsString))) then
      begin
        RecuperaRiga;
        T2OK:=True;
        ImpostaCella;
      end;
      //...creo e popolo una nuova riga se il terzo turno del giorno ha dati aggiuntivi diversi da quelli del primo e del secondo turno
      idxTurno:='3';
      if TurnoSelezionato(idxTurno)
      and (   (not T1OK)
           or (   (selT380.FieldByName('DATOAGG1_T1').AsString <> selT380.FieldByName('DATOAGG1_T3').AsString)
               or (selT380.FieldByName('DATOAGG2_T1').AsString <> selT380.FieldByName('DATOAGG2_T3').AsString)))
      and (   (not T2OK)
           or (   (selT380.FieldByName('DATOAGG1_T2').AsString <> selT380.FieldByName('DATOAGG1_T3').AsString)
               or (selT380.FieldByName('DATOAGG2_T2').AsString <> selT380.FieldByName('DATOAGG2_T3').AsString))) then
      begin
        RecuperaRiga;
        ImpostaCella;
      end;
    end;
    selT380.Next;
    {$IFNDEF IRISWEB}AggiornaProgresso(selT380.RecNo,selT380.RecordCount);{$ENDIF}
  end; //==> while not eof

  {$IFNDEF IRISWEB}SettaProgresso;{$ENDIF}

  selT380.Close;
  cdsPianif.First;
  cdsPianif.EnableControls;
end;


end.
