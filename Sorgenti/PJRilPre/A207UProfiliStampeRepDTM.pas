unit A207UProfiliStampeRepDTM;

interface

uses
  System.SysUtils, System.Classes, OracleData, R004UGestStoricoDTM, A040UPianifRepMW, Data.DB;

type
  TA207FProfiliStampeRepDTM = class(TR004FGestStoricoDtM)
    selT355: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    A040MW: TA040FPianifRepMW;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA207FProfiliStampeRepDTM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT355,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A040MW:=TA040FPianifRepMW.Create(Self);
  selT355.Open;
end;

end.
