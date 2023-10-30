unit A020UCausPresenzeStoricoDtM1;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, OracleData,
  A020UCausPresenzeStoricoMW, C180FunzioniGenerali;

type
  TA020FCausPresenzeStoricoDtM1 = class(TR004FGestStoricoDtM)
    selT235: TOracleDataSet;
    selT235ID: TIntegerField;
    selT235DECORRENZA: TDateTimeField;
    selT235DECORRENZA_FINE: TDateTimeField;
    selT235DESCRIZIONE: TStringField;
    selT235NONABILITATA_ELIMINATIMB: TStringField;
    selT235NONACCOPPIATA_ANOMBLOCC: TStringField;
    selT235CODICE: TStringField;
    selT235DESC_CAUSALE: TStringField;
    selT235CAUSCOMP_DEBITOGG: TStringField;
    selT235DETRAZ_RIEPPR_SEQ: TIntegerField;
    selT235GIUST_DAA_RECUP_FLEX: TStringField;
    selT235ITER_AUTSTR_ARROT_LIQ: TStringField;
    selT235ITER_AUTSTR_ARROT_LIQ_FASCE: TStringField;
    selT235CONTEGGIO_TIMB_INTERNA: TStringField;
    selT235MATURAMENSA: TStringField;
    selT235TIMB_PM: TStringField;
    selT235TIMB_PM_DETRAZ: TStringField;
    selT235TIMB_PM_H: TStringField;
    selT235INTERSEZIONE_TIMBRATURE: TStringField;
    selT235AUTOCOMPLETAMENTO_UE: TStringField;
    selT235SEPARA_CAUSALI_UE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure selT235ITER_AUTSTR_ARROT_LIQValidate(Sender: TField);
  private
    IdCausale:Integer;
  public
    A020FCausPresenzeStoricoMW:TA020FCausPresenzeStoricoMW;
    constructor Create(AOwner: TComponent; IdCausale:Integer); overload;
  end;

var
  A020FCausPresenzeStoricoDtM1: TA020FCausPresenzeStoricoDtM1;

implementation

uses A020UCausPresenzeStorico;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

constructor TA020FCausPresenzeStoricoDtM1.Create(AOwner: TComponent; IdCausale:Integer);
begin
  Self.IdCausale:=IdCausale;
  A020FCausPresenzeStoricoMW:=TA020FCausPresenzeStoricoMW.Create(Self);
  A020FCausPresenzeStoricoMW.Inizializza(IdCausale);
  A020FCausPresenzeStoricoMW.ApriT275;
  inherited Create(AOwner);
end;

procedure TA020FCausPresenzeStoricoDtM1.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT235.SetVariable('ID',IdCausale);
  InterfacciaR004:=A020FCausPresStorico.InterfacciaR004;
  InizializzaDataSet(selT235,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePost,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnNewRecord,
                              evOnTranslateMessage]);
  A020FCausPresStorico.DButton.DataSet:=selT235;
  InterfacciaR004.OttimizzaStorico:=False;

  selT235CODICE.LookupDataSet:=A020FCausPresenzeStoricoMW.selT275;
  selT235DESC_CAUSALE.LookupDataSet:=A020FCausPresenzeStoricoMW.selT275;
  selT235.Open;
end;

procedure TA020FCausPresenzeStoricoDtM1.selT235ITER_AUTSTR_ARROT_LIQValidate(Sender: TField);
begin
  if not Sender.IsNull then
    OreMinutiValidate(Sender.AsString);
end;

end.
