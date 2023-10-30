unit A203UDatiMensiliPersonalizzatiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData;

type
  TMyProc = procedure of object;

  TA203FDatiMensiliPersonalizzatiMW = class(TR005FDataModuleMW)
    selP200: TOracleDataSet;
    procedure InizializzaDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
    selI011: TOracleDataSet;
    NotificaAfterScroll: TMyProc;
    strDescVocePaghe: String;
    procedure selI011AfterScroll(DataSet: TDataSet);
  end;

{var
    A203FDatiMensiliPersonalizzatiMW: TA203FDatiMensiliPersonalizzatiMW;}

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA203FDatiMensiliPersonalizzatiMW.InizializzaDataSet;
begin
  selP200.Open;
end;

procedure TA203FDatiMensiliPersonalizzatiMW.selI011AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Assigned(NotificaAfterScroll) then
  begin
    if selP200.SearchRecord('COD_VOCE',selI011.FieldByName('VOCEPAGHE').AsString,[srFromBeginning]) then
      strDescVocePaghe:=selP200.FieldByName('DESCRIZIONE').AsString
    else
      strDescVocePaghe:='';
    NotificaAfterScroll;
  end;
end;

end.
