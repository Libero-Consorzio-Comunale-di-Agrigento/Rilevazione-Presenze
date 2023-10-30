unit A208UAcquisizioneInfoEsterneMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, C180FunzioniGenerali, A000UMessaggi,
  Oracle, Data.DB, Variants, StrUtils, USelI010, QueryStorico, A000UInterfaccia, A000UCostanti,
  Datasnap.DBClient, R600, IOUtils;

type
  TParametriElaborazione = record
    sNomeFile: String;              //Trim(edtNomeFile.Text)
    sTipo: String;                  //cmbTipo.Text
    sDato: String;                  //cmbDato.Text
    sValoreDefault: String;         //cmbValore.Text
  end;

  TA208FAcquisizioneInfoEsterneMW = class(TR005FDataModuleMW)
    delT036: TOracleQuery;
    insT036: TOracleQuery;
    selT030: TOracleDataSet;
    selT036Count: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    function InserisciT036(CodFiscale, Valore: String): Boolean;
    function ContaRighe: Integer;
  public
    { Public declarations }
    selT036:TOracleDataSet;
    selI010:TselI010;
    PresenzaAnomalie:Boolean;
    ParametriElaborazione:TParametriElaborazione;
    procedure ControlliEsistenzaFile(Visualizza: Boolean = False);
    procedure AggiornaT036;
    procedure CancellaT036;
    function RecordCountT036: Integer;
    procedure EseguiAcquisizione;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA208FAcquisizioneInfoEsterneMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //
end;

procedure TA208FAcquisizioneInfoEsterneMW.DataModuleDestroy(Sender: TObject);
begin
  //
  inherited;
end;

procedure TA208FAcquisizioneInfoEsterneMW.ControlliEsistenzaFile(Visualizza: Boolean = False);
begin
  if ParametriElaborazione.sNomeFile = '' then
    raise Exception.Create(A000MSG_ERR_SPEC_NOME_FILE_IMP);
  if not FileExists(ParametriElaborazione.sNomeFile) then
    raise Exception.Create(IfThen(Visualizza, A000MSG_ERR_VISUALIZ_FILE, A000MSG_ERR_FILE_INESISTENTE_IMP));
end;

procedure TA208FAcquisizioneInfoEsterneMW.AggiornaT036;
begin
  selT036.Close;
  selT036.Open;
end;

procedure TA208FAcquisizioneInfoEsterneMW.CancellaT036;
begin
  with delT036 do
  begin
    SetVariable('TIPO',ParametriElaborazione.sTipo);
    SetVariable('DATO',ParametriElaborazione.sDato);
    delT036.Execute;
  end;
  SessioneOracle.Commit;
end;

function TA208FAcquisizioneInfoEsterneMW.InserisciT036(CodFiscale, Valore: String): Boolean;
//Ritorna False se il CF non è trovato, True se ha inserito almeno un record
begin
  Result:=False;
  with selT030 do
  begin
    Close;
    SetVariable('CODFISCALE',CodFiscale);
    Open;
    if RecordCount = 0 then
      Exit;
  end;

  while not selT030.Eof do
  begin
    with insT036 do
    begin
      SetVariable('PROGRESSIVO',selT030.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('TIPO',ParametriElaborazione.sTipo);
      SetVariable('DATO',ParametriElaborazione.sDato);
      SetVariable('VALORE',IfThen(Valore = '',ParametriElaborazione.sValoreDefault,Valore));
      Execute;
    end;
    selT030.Next;
  end;
  SessioneOracle.Commit;
  Result:=True;
end;

function TA208FAcquisizioneInfoEsterneMW.RecordCountT036: Integer;
begin
  with selT036Count do
  begin
    SetVariable('TIPO',ParametriElaborazione.sTipo);
    SetVariable('DATO',ParametriElaborazione.sDato);
    Execute;
    Result:=FieldAsInteger(0)
  end;
end;

function TA208FAcquisizioneInfoEsterneMW.ContaRighe: Integer;
var Reader: TStreamReader;
    Line: String;
begin
  Result:=0;
  //conta numero di righe da importare
  Reader:=TFile.OpenText(ParametriElaborazione.sNomeFile);
  try
    while not Reader.EndOfStream do
    begin
      try
        Line:=Trim(Reader.ReadLine);
        if Line <> '' then
          Inc(Result);
      except end;
    end;
  finally
    FreeAndNil(Reader);
  end;
end;

procedure TA208FAcquisizioneInfoEsterneMW.EseguiAcquisizione;
var Reader: TStreamReader;
    line, CF, Valore: String;
    strArray: TArray<String>;
begin
  PresenzaAnomalie:=False;
  RegistraMsg.IniziaMessaggio(NomeOwner);

  if Assigned(MaxProgressBar) then
      MaxProgressBar(ContaRighe);
  //importazione dati
  Reader:=TFile.OpenText(ParametriElaborazione.sNomeFile);
  try
    while not Reader.EndOfStream do
    begin
      try
        try
          line:=Trim(Reader.ReadLine);
          if line = '' then
            Continue;

          strArray:=line.Split([Char(9),';']);  //separatore colonne: TAB o ;

          if length(strArray) = 1 then          //una sola colonna con il codice fiscale
          begin
            CF:=Trim(strArray[0]);
            Valore:=ParametriElaborazione.sValoreDefault;
          end
          else                                  //due o più colonne
          begin
            CF:=Trim(strArray[0]);
            Valore:=Trim(strArray[1]);
          end;

          if not InserisciT036(CF, Valore) then
          begin
            RegistraMsg.InserisciMessaggio('A', Format(A000MSG_P208_ERR_FMT_NO_CF, [CF]), '', 0);
            PresenzaAnomalie:=True;
          end;
        except
          on E: Exception do
          begin
            RegistraMsg.InserisciMessaggio('A', Format(A000MSG_P208_ERR_FMT_CF_GENERICO, [CF, E.Message]), '', 0);
            PresenzaAnomalie:=True;
          end;
        end;
      finally
        if Assigned(IncrementaProgressBar) then
          IncrementaProgressBar;
      end;
    end;
    SessioneOracle.Commit;
  finally
    FreeAndNil(Reader);
  end;
end;

end.
