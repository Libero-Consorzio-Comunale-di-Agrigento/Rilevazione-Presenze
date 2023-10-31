unit A203UDatiMensiliPersonalizzatiDtM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, A203UDatiMensiliPersonalizzatiMW, Data.DB, OracleData, Oracle;

type

  TA203FDatiMensiliPersonalizzatiDtM = class(TR004FGestStoricoDtM)
    selI011: TOracleDataSet;
    sesTest: TOracleSession;
    selI011DATO: TStringField;
    selI011TIPO: TStringField;
    selI011DESCRIZIONE: TStringField;
    selI011ORDINAMENTO: TIntegerField;
    selI011ESPRESSIONE: TStringField;
    selI011VOCEPAGHE: TStringField;
    selI011DECORRENZA: TDateTimeField;
    selI011DECORRENZA_FINE: TDateTimeField;
    selI011SELEZIONE_ANAGRAFE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selI011AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A203MW:TA203FDatiMensiliPersonalizzatiMW;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses A203UDatiMensiliPersonalizzati;

{$R *.dfm}

procedure TA203FDatiMensiliPersonalizzatiDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InterfacciaR004:=A203FDatiMensiliPersonalizzati.InterfacciaR004;
  InterfacciaR004.AllineaSoloDecorrenzeIntersecanti:=True;

  InizializzaDataSet(selI011,[evBeforeEdit,
                             evBeforeInsert,
                             evBeforePost,
                             evBeforeDelete,
                             evAfterDelete,
                             evAfterPost,
                             evOnNewRecord,
                             evOnTranslateMessage]);
  selI011.Open;

  A203MW:=TA203FDatiMensiliPersonalizzatiMW.Create(self);
  A203MW.InizializzaDataSet;
  A203MW.selI011:=selI011;
end;

procedure TA203FDatiMensiliPersonalizzatiDtM.selI011AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Assigned(A203MW) then
    A203MW.selI011AfterScroll(DataSet);
end;

end.
