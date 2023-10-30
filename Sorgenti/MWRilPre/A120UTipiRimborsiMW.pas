unit A120UTipiRimborsiMW;

interface

uses
  System.SysUtils, System.Classes, Variants,R005UDataModuleMW, Data.DB, OracleData,
  A000UInterfaccia, ControlloVociPaghe, A000USessione;

type
  TA120FTipiRimborsiMW = class(TR005FDataModuleMW)
    DsrP050: TDataSource;
    selP050: TOracleDataSet;
    selP050COD_ARROTONDAMENTO: TStringField;
    selP050COD_VALUTA: TStringField;
    selP050DECORRENZA: TDateTimeField;
    selP050DESCRIZIONE: TStringField;
    selP050VALORE: TFloatField;
    selP050TIPO: TStringField;
    selM022: TOracleDataSet;
    dsrM022: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FSelM020_Funzioni: TOracleDataset;
    CodCanc: String;
    procedure AggiornaFiltroDizionario(Codice: String);
  public
    Ins: Boolean;
    selControlloVociPaghe:TControlloVociPaghe;
    function VerificaVociPaghe(CampoCodVoce: String): String;
    procedure InserisciVocePaghe(CampoCodVoce: String);
    procedure selM020CalcFields;
    procedure selM020BeforeDelete;
    procedure selM020AfterDelete;
    procedure selM020AfterPost;
    property selM020_Funzioni: TOracleDataset read FSelM020_Funzioni write FSelM020_Funzioni;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA120FTipiRimborsiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selControlloVociPaghe:=TControlloVociPaghe.Create(Self,'');
  selM022.Open;
end;

function TA120FTipiRimborsiMW.VerificaVociPaghe(CampoCodVoce:String): String;
var VoceOld: String;
begin
  Result:='';
  if (FSelM020_Funzioni.State = dsInsert) or (FSelM020_Funzioni.FieldByName(CampoCodVoce).medpOldValue = null) then
    VoceOld:=''
  else
    VoceOld:=FSelM020_Funzioni.FieldByName(CampoCodVoce).medpOldValue;
  if not selControlloVociPaghe.ControlloVociPaghe(VoceOld,FSelM020_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Result:=selControlloVociPaghe.MessaggioLog;
end;

procedure TA120FTipiRimborsiMW.InserisciVocePaghe(CampoCodVoce:String);
begin
  //se voce vuota esco ma non faccio abort altrimenti interromperei il salvataggio
  if Trim(FSelM020_Funzioni.FieldByName(CampoCodVoce).AsString) = '' then Exit;

  if not selControlloVociPaghe.ValutaInserimentoVocePaghe(FSelM020_Funzioni.FieldByName(CampoCodVoce).AsString) then
    Abort;
end;

procedure TA120FTipiRimborsiMW.selM020AfterDelete;
begin
  AggiornaFiltroDizionario(CodCanc);
end;

procedure TA120FTipiRimborsiMW.selM020AfterPost;
begin
  // la funzione di modifica non permette di variare il codice,
  // pertanto considero solo l'inserimento
  if Ins then
    A000AggiornaFiltroDizionario('RIMBORSI MISSIONI','',FSelM020_Funzioni.FieldByName('CODICE').AsString);
end;

procedure TA120FTipiRimborsiMW.selM020BeforeDelete;
begin
  CodCanc:=FSelM020_Funzioni.FieldByName('CODICE').AsString;
end;

procedure TA120FTipiRimborsiMW.selM020CalcFields;
begin
  inherited;
  if selP050.GetVariable('Decorrenza') <> Parametri.DataLavoro then
  begin
    selP050.Close;
    selP050.SetVariable('Decorrenza',Parametri.DataLavoro);
    selP050.Open;
  end;
  FSelM020_Funzioni.FieldByName('CalcArrotIndennitaSuppl').AsString:='';
  if selP050.SearchRecord('COD_ARROTONDAMENTO',FSelM020_Funzioni.FieldByName('ArrotIndennitaSuppl').AsString,[srFromBeginning]) then
    FSelM020_Funzioni.FieldByName('CalcArrotIndennitaSuppl').AsString:=selP050.FieldByName('DESCRIZIONE').AsString;
end;

procedure TA120FTipiRimborsiMW.AggiornaFiltroDizionario(Codice: String);
begin
  A000AggiornaFiltroDizionario('RIMBORSI MISSIONI',Codice,'');
end;

procedure TA120FTipiRimborsiMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(selControlloVociPaghe);
  inherited;
end;

end.
