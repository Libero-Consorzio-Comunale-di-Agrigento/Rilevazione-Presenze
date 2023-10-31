unit A140UTurniServiziDTM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, A000UInterfaccia, C180FunzioniGenerali,
  DBGrids;

type
  TA140FTurniServiziDTM = class(TR004FGestStoricoDtM)
    selT540: TOracleDataSet;
    selT540CODICE: TStringField;
    selT540DESCRIZIONE: TStringField;
    selT540COLORE: TStringField;
    selT540COLOREFONT: TStringField;
    selT545: TOracleDataSet;
    selT545CODICE: TStringField;
    selT545DESCRIZIONE: TStringField;
    selT545COMANDATO: TStringField;
    selT530: TOracleDataSet;
    selT530DATA_PRIMOGGLAV: TDateTimeField;
    selT530DATA_PRIMOGGFES: TDateTimeField;
    selT530ALTERNANZA_GGLAV: TIntegerField;
    selT530ALTERNANZA_GGFES: TIntegerField;
    selT530GGCHIUSURA: TIntegerField;
    selT530CALENDARIO: TStringField;
    selT010: TOracleDataSet;
    selT530D_CALENDARIO: TStringField;
    dsrT010: TDataSource;
    selT540PADRE: TStringField;
    selT540FILTRO_ANAGRAFE: TStringField;
    selT540SelPadre: TOracleDataSet;
    selI070: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT540AfterScroll(DataSet: TDataSet);
    procedure selT545BeforePost(DataSet: TDataSet);
    procedure selT530BeforeInsert(DataSet: TDataSet);
    procedure selT540BeforeEdit(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT540BeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
    function GetFAnagrafe:String;
    function Amminist:Boolean;
  public
    { Public declarations }
    procedure CambiaInizializzaDataSet(DataSet: TOracleDataSet);
  end;

var
  A140FTurniServiziDTM: TA140FTurniServiziDTM;

implementation

uses A140UTurniServizi;

{$R *.dfm}

function TA140FTurniServiziDTM.Amminist:Boolean;
//se True può Modificare/Cancellare record
begin
  Result:=True;
  if (Parametri.A139_ServiziComandati = 'N') and
     ((selT540.FieldByName('FILTRO_ANAGRAFE').AsString <> GetFAnagrafe) or
     (selT540.FieldByName('PADRE').IsNull)) then
    Result:=False;
end;

procedure TA140FTurniServiziDTM.DataModuleCreate(Sender: TObject);
var FAnagrafe,SQL:String;
begin
  inherited;
  InizializzaDataSet(selT530,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selT010.Open;
  selT530.Open;
  SQL:='';
  if Parametri.A139_ServiziComandati = 'N' then
  begin
    SQL:=SQL + 'T540.PADRE IS NULL';
    FAnagrafe:=GetFAnagrafe;
    if FAnagrafe <> '' then
      SQL:=SQL + ' OR T540.FILTRO_ANAGRAFE = ''' + FAnagrafe + ''''
    else
      SQL:=SQL + ' OR T540.FILTRO_ANAGRAFE IS NULL';
  end;
  if SQL <> '' then
    SQL:='WHERE ' + SQL;
  selT540.SetVariable('WHERE',SQL);
  selT540.Open;

  selT545.Open;
end;

function TA140FTurniServiziDTM.GetFAnagrafe:String;
begin
  selI070.Close;
  selI070.SetVariable('AZIENDA',Parametri.Azienda);
  selI070.SetVariable('UTENTE',Parametri.Operatore);
  selI070.Open;
  Result:=selI070.FieldByName('FILTRO_ANAGRAFE').AsString;
end;

procedure TA140FTurniServiziDTM.CambiaInizializzaDataSet(DataSet: TOracleDataSet);
begin
  A140FTurniServizi.DButton.DataSet:=DataSet;
  InizializzaDataSet(DataSet,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
end;

procedure TA140FTurniServiziDTM.selT530BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if selT530.RecordCount > 0 then
    Abort;
end;

procedure TA140FTurniServiziDTM.selT540AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A140FTurniServizi.NumRecords;
end;

procedure TA140FTurniServiziDTM.BeforeDelete(DataSet: TDataSet);
begin
  if Not Amminist then
    Abort;
  inherited;
end;

procedure TA140FTurniServiziDTM.selT540BeforeEdit(DataSet: TDataSet);
begin
  if Not Amminist then
    Abort;
  inherited;
  selT540.FieldByName('PADRE').ReadOnly:=selT540.FieldByName('PADRE').IsNull and (Parametri.A139_ServiziComandati = 'N');
end;

procedure TA140FTurniServiziDTM.selT540BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  selT540.FieldByName('PADRE').Required:=Parametri.A139_ServiziComandati = 'N';
end;

procedure TA140FTurniServiziDTM.selT545BeforePost(DataSet: TDataSet);
begin
  inherited;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA140FTurniServiziDTM.BeforePostNoStorico(DataSet: TDataSet);
var Ret:string;
begin
  if DataSet = selT530 then
    exit;
  DataSet.FieldByName('CODICE').AsString:=Trim(DataSet.FieldByName('CODICE').AsString);
  DataSet.FieldByName('DESCRIZIONE').AsString:=Trim(DataSet.FieldByName('DESCRIZIONE').AsString);
  if DataSet = selT540 then
  begin
    if Not DataSet.FieldByName('PADRE').IsNull then
    begin
      selT540SelPadre.Open;
      Ret:=Trim(VarToStr(selT540SelPadre.Lookup('CODICE',DataSet.FieldByName('PADRE').AsString,'CODICE')));
      if (Ret = '') then
      begin
        DataSet.FieldByName('PADRE').Clear;      
        Raise Exception.Create('Codice padre inesistente!');
      end;
      if (Ret = selT540.FieldByName('CODICE').AsString) then
        Raise Exception.Create('Impossibile assegnare come padre il codice del record su cui si è posizionati!');
      DataSet.FieldByName('FILTRO_ANAGRAFE').AsString:=GetFAnagrafe;
    end;
  end;
  inherited;
end;

end.
