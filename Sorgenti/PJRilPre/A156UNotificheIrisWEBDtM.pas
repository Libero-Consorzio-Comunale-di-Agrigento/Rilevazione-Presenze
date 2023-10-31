unit A156UNotificheIrisWEBDtM;

interface

uses
  A156UNotificheIrisWEBMW,
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, OracleData,
  C180FunzioniGenerali, Datasnap.DBClient;

type

  TA156FNotificheIrisWEBDtM = class(TR004FGestStoricoDtM)
    selI040: TOracleDataSet;
    selI040ID: TIntegerField;
    selI040DESCRIZIONE: TStringField;
    selI040NOTIFICA: TStringField;
    selI040NOTIFICA_SQL_TEXT: TStringField;
    selI040VALIDO_DAL: TDateTimeField;
    selI040VALIDO_AL: TDateTimeField;
    selI040ATTIVO: TStringField;
    selI040D_NOTIFICA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    A156MW: TA156FNotificheIrisWEBMW;
  public
  end;

var
  A156FNotificheIrisWEBDtM: TA156FNotificheIrisWEBDtM;

implementation

uses A156UNotificheIrisWEB;

{$R *.dfm}

procedure TA156FNotificheIrisWEBDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;

  A156MW:=TA156FNotificheIrisWEBMW.Create(nil);
  A156MW.selI040_Funzioni:=selI040;

  InizializzaDataSet(selI040,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  selI040.FieldByName('D_NOTIFICA').LookupDataSet:=A156MW.cdsProc;
  selI040.Open;
end;

procedure TA156FNotificheIrisWEBDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A156MW);
  inherited;
end;

procedure TA156FNotificheIrisWEBDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A156MW.selI040BeforePost;
end;

end.
