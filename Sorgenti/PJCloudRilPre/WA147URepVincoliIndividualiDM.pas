unit WA147URepVincoliIndividualiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData,
  C180FunzioniGenerali, A147URepVincoliIndividualiMW;

type
  TWA147FRepVincoliIndividualiDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaTIPOLOGIA: TStringField;
    selTabellaGIORNO: TStringField;
    selTabellaDescGiorno: TStringField;
    selTabellaDISPONIBILE: TStringField;
    selTabellaBLOCCA_PIANIF: TStringField;
    selTabellaTURNI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure dsrTabellaStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    A147MW: TA147FRepVincoliIndividualiMW;
  end;

implementation

uses WA147URepVincoliIndividuali, WA147URepVincoliIndividualiDettFM;

{$R *.dfm}

procedure TWA147FRepVincoliIndividualiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY DECORRENZA, GIORNO');
  A147MW:=TA147FRepVincoliIndividualiMW.Create(Self);
  A147MW.selT385:=SelTabella;
  inherited;
end;

procedure TWA147FRepVincoliIndividualiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if ((Self.Owner as TWA147FRepVincoliIndividuali).WDettaglioFM as TWA147FRepVincoliIndividualiDettFM) <> nil then
    with ((Self.Owner as TWA147FRepVincoliIndividuali).WDettaglioFM as TWA147FRepVincoliIndividualiDettFM).cmbGiorno do
      ItemIndex:=R180IndexOf(Items,selTabella.FieldByName('GIORNO').AsString,2);
end;

procedure TWA147FRepVincoliIndividualiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A147MW.Giorno:=TrimRight(Copy(((Self.Owner as TWA147FRepVincoliIndividuali).WDettaglioFM as TWA147FRepVincoliIndividualiDettFM).cmbGiorno.Text,1,2));
  A147MW.BeforePost;
  inherited;
end;

procedure TWA147FRepVincoliIndividualiDM.dsrTabellaStateChange(Sender: TObject);
begin
  (Self.Owner as TWA147FRepVincoliIndividuali).AbilitaAzioni;
  inherited;
end;

procedure TWA147FRepVincoliIndividualiDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  inherited;
  A147MW.CalcFields;
end;

procedure TWA147FRepVincoliIndividualiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A147MW.NewRecord;
end;

end.
