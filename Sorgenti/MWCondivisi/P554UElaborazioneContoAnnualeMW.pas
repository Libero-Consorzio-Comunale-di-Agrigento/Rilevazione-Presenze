unit P554UElaborazioneContoAnnualeMW;

interface

uses
  A000UInterfaccia, R005UDataModuleMW,
  System.SysUtils, System.Classes, Oracle, Data.DB,
  OracleData, USelAziendeBase;

type
  TTabElab = record
    CodiceTabella:String;
    DescTabella:String;
  end;

  TImpostazioni = record
    NomeFile: String;
    Azienda: String;
    Comparto: String;
    DSM: String;
    Istituto: String;
    Regione: String;
    TipoOper: String;
  end;

  TP554FElaborazioneContoAnnualeMW = class(TR005FDataModuleMW)
    selP555_ID: TOracleDataSet;
    selP554: TOracleDataSet;
    insP554: TOracleQuery;
    delP555: TOracleQuery;
    updP554: TOracleQuery;
    delP554: TOracleQuery;
    seleP554: TOracleDataSet;
    selP552: TOracleDataSet;
    selP552a: TOracleDataSet;
    delP555a: TOracleQuery;
    delP555b: TOracleQuery;
    insP555: TOracleQuery;
    selP050: TOracleDataSet;
    selP500: TOracleDataSet;
    selP555: TOracleDataSet;
    selP552b: TOracleDataSet;
    selP555a: TOracleDataSet;
    selP555b: TOracleDataSet;
    selP553: TOracleDataSet;
    updP555: TOracleQuery;
    selP555Esporta: TOracleDataSet;
    selP551: TOracleDataSet;
    selP555Righe: TOracleDataSet;
    selQuery: TOracleDataSet;
    selP551Formato: TOracleDataSet;
    dsrAziendeBase: TDataSource;
    ScriptIniziale: TOracleQuery;
    delP555c: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    Anno: Integer;
    ChkElaboraDatiCONTANN_Checked,bVisStatoCedolini: Boolean;
    SelAziendeBase:TSelAziendeBase;
    function TestataCONTANN(sCodTabella: String): Integer;
  end;

implementation

{$R *.dfm}

procedure TP554FElaborazioneContoAnnualeMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  SelAziendeBase:=TSelAziendeBase.Create(Self);
  SelAziendeBase.Apri(SessioneOracle);
  dsrAziendeBase.DataSet:=SelAziendeBase;
  bVisStatoCedolini:=False;
  selQuery.Close;
  selQuery.SQL.Clear;
  selQuery.DeleteVariables;
  selQuery.SQL.Add('SELECT COUNT(*) NCED FROM P441_CEDOLINO WHERE ROWNUM < 2');
  selQuery.Open;
  if selQuery.RecordCount > 0 then
    bVisStatoCedolini:=selQuery.FieldByName('NCED').AsInteger > 0;
end;

procedure TP554FElaborazioneContoAnnualeMW.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(SelAziendeBase);
  inherited;
end;

function TP554FElaborazioneContoAnnualeMW.TestataCONTANN(sCodTabella:String):Integer;
//Creo testata della fornitura mensile CONTANN o ne estraggo ID se già esiste
begin
  Result:=0;

  //Lettura di eventuale CONTANN aperta
  selP554.SetVariable('Anno',{//***edtAnno.Text}Anno);
  selP554.SetVariable('CodTabella',sCodTabella);
  selP554.Close;
  selP554.Open;
  if selP554.Eof then
  begin
    //Nel caso di Elaborazione, se non esiste, si genera la testata
    //***if chkElaboraDatiCONTANN.Checked then
    if ChkElaboraDatiCONTANN_Checked then
    begin
      //Generazione della sequenza Id_FLUSSO
      selP555_ID.Close;
      selP555_ID.Open;
      Result:=selP555_ID.FieldByName('NEXTVAL').AsInteger;
      insP554.SetVariable('Anno',{//***edtAnno.Text}Anno);
      insP554.SetVariable('CodTabella',sCodTabella);
      insP554.SetVariable('IdCONTANN',Result);
      insP554.Execute;
      SessioneOracle.Commit;
    end;
  end
  else
    if selP554.FieldByName('CHIUSO').AsString = 'N' then
      Result:=selP554.FieldByName('ID_CONTOANN').AsInteger;
end;

end.
