unit WP150USetupDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, P150USetupMW;

type
  TWP150FSetupDM = class(TWR302FGestTabellaDM)
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaCOD_PAGAMENTO: TStringField;
    selTabellaCOD_VALUTA_BASE: TStringField;
    selTabellaCOD_VALUTA_STAMPA: TStringField;
    selTabellaNUM_DEC_PERC: TIntegerField;
    selTabellaBLOCCO_DETR_IRPEF: TStringField;
    selTabellaNUM_DEC_QUANTITA: TIntegerField;
    selTabellaTIPO_ORE: TStringField;
    selTabellaDES_BASE: TStringField;
    selTabellaDES_STAMPA: TStringField;
    selTabellaDES_PAGAM: TStringField;
    selTabellaCOD_COMUNE_INAIL: TStringField;
    selTabellaULTIMO_ANNO_RECUP: TIntegerField;
    selTabellaCOD_VALUTA_CONT: TStringField;
    selTabellaDES_CONT: TStringField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaC_Desc_Comune: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    P150FSetupMW: TP150FSetupMW;
  end;

implementation

{$R *.dfm}

procedure TWP150FSetupDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY DECORRENZA');
  P150FSetupMW:=TP150FSetupMW.Create(Self);
  P150FSetupMW.selP150:=selTabella;
  inherited;
end;

procedure TWP150FSetupDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  P150FSetupMW.P150CalcFields;
  if not P150FSetupMW.T480_COMUNI.Active then
    Exit;
  selTabella.FieldByName('C_Desc_Comune').AsString:='';
  if selTabella.FieldByName('COD_COMUNE_INAIL').AsString <> '' then
    selTabella.FieldByName('C_Desc_Comune').AsString:=VarToStr(P150FSetupMW.T480_COMUNI.Lookup('CODCATASTALE',selTabella.FieldByName('COD_COMUNE_INAIL').AsString,'CITTA'));
end;

end.
