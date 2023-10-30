unit WP032UCambiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, P032UCambiMW;

type
  TWP032FCambiDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_VALUTA1: TStringField;
    selTabellaCOD_VALUTA2: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaCOEFF_CALCOLI: TFloatField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaDesc_Valuta1: TStringField;
    selTabellaDesc_Valuta2: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet);Override;
    procedure BeforePost(DataSet: TDataSet);Override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    P032FCambiMW: TP032FCambiMW;
  end;

implementation

{$R *.dfm}

uses WP032UCambiDettFM, WP032UCambi;

procedure TWP032FCambiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY COD_VALUTA1, COD_VALUTA2, DECORRENZA');
  P032FCambiMW:=TP032FCambiMW.Create(Self);
  P032FCambiMW.selP032:=selTabella;
  inherited;
end;

procedure TWP032FCambiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P032FCambiMW.P032AfterScroll;
end;

procedure TWP032FCambiDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  P032FCambiMW.BeforePost;
end;

procedure TWP032FCambiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  P032FCambiMW.P032CalcFields;
end;

end.
