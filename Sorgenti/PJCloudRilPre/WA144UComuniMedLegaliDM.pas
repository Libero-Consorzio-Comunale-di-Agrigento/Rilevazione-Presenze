unit WA144UComuniMedLegaliDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A144UComuniMedLegaliMW;

type
  TWA144FComuniMedLegaliDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_COMUNE: TStringField;
    selTabellaMED_LEGALE: TStringField;
    selTabellaD_COMUNE: TStringField;
    selTabellaD_MED_LEGALE: TStringField;
    selTabellaCITTA: TStringField;
    selTabellaDESC_MED_LEGALE: TStringField;
    //dsrTabella: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    A144FComuniMedLegaliMW: TA144FComuniMedLegaliMW;
  end;

implementation

{$R *.dfm}


procedure TWA144FComuniMedLegaliDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  selTabella.SetVariable('ORDERBY','order by T486.MED_LEGALE');
  inherited;
  A144FComuniMedLegaliMW:=TA144FComuniMedLegaliMW.Create(Self);
  A144FComuniMedLegaliMW.selT486:=selTabella;

  selTabella.FieldByName('D_COMUNE').LookupDataSet:=A144FComuniMedLegaliMW.selT480;
  selTabella.FieldByName('D_MED_LEGALE').LookupDataSet:=A144FComuniMedLegaliMW.selT485;

  selTabella.Open;
end;

end.
