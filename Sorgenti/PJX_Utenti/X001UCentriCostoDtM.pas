unit X001UCentriCostoDtM;

interface

uses
  SysUtils, Classes, DB, OracleData, StrUtils,
  WR000UBaseDM, C180FunzioniGenerali, Datasnap.DBClient;

type
  TX001FCentriCostoDtM = class(TWR000FBaseDM)
    selX001: TOracleDataSet;
    selCols: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OrdCod,OrdDec:String;
  end;

implementation

{$R *.dfm}

uses A000UInterfaccia;

procedure TX001FCentriCostoDtM.DataModuleCreate(Sender: TObject);
var
  NomeTabella,Ordinamento:String;
  IdDecorrenza:Integer;
begin
  selCols.Session:=OracleSession1;
  selX001.Session:=OracleSession1;
  // gestione parametri di configurazione su file.ini
  //***NomeTabella:='X001_' + Copy(R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'TabColPartenza',''),Pos('.',R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'TabColPartenza','')) + 1) + '_' + IntToStr(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'NumLivelli',''),0));
  NomeTabella:='X001_' + Copy(W000ParConfig.TabColPartenza,Pos('.',W000ParConfig.TabColPartenza) + 1) + '_' + IntToStr(W000ParConfig.NumLivelli);
  // gestione parametri di configurazione su file.ini
  selCols.SetVariable('TABELLA',NomeTabella);
  selCols.Open;
  while not selCols.Eof do
  begin
    if (selCols.FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA')
    and (selCols.FieldByName('COLUMN_NAME').AsString <> 'SCADENZA')
    and (Pos(',' + selCols.FieldByName('COLUMN_NAME').AsString + ',',',' + W000ParConfig.CampiInvisibili{R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'CampiInvisibili','')} + ',') = 0) then // gestione parametri di configurazione su file
      Ordinamento:=Ordinamento + IfThen(Ordinamento <> '',',','') + IntToStr(selCols.FieldByName('COLUMN_ID').AsInteger)
    else if selCols.FieldByName('COLUMN_NAME').AsString = 'DECORRENZA' then
      IdDecorrenza:=selCols.FieldByName('COLUMN_ID').AsInteger;
    selCols.Next;
  end;
  OrdCod:=Ordinamento + IfThen(Ordinamento <> '',',','') + IntToStr(IdDecorrenza);
  OrdDec:=IntToStr(IdDecorrenza) + IfThen(Ordinamento <> '',',','') + Ordinamento;
  selX001.SetVariable('TABELLA',NomeTabella);
end;

end.
