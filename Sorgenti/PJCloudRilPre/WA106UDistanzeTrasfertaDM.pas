unit WA106UDistanzeTrasfertaDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  A106UDistanzeTrasfertaMW;

type
  TWA106FDistanzeTrasfertaDM = class(TWR302FGestTabellaDM)
    selTabelladesc_partenza: TStringField;
    selTabellacap1: TStringField;
    selTabellaprov1: TStringField;
    selTabelladesc_destinazione: TStringField;
    selTabellacap2: TStringField;
    selTabellaprov2: TStringField;
    selTabellaTIPO1: TStringField;
    selTabellaLOCALITA1: TStringField;
    selTabellaTIPO2: TStringField;
    selTabellaLOCALITA2: TStringField;
    selTabellaCHILOMETRI: TFloatField;
    selTabellaCITTA1: TStringField;
    selTabellaCITTA2: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A106FDistanzeTrasfertaMW: TA106FDistanzeTrasfertaMW;
  end;

implementation

{$R *.dfm}

procedure TWA106FDistanzeTrasfertaDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A106FDistanzeTrasfertaMW.selM041BeforePost;
  inherited;
end;

procedure TWA106FDistanzeTrasfertaDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A106FDistanzeTrasfertaMW:=TA106FDistanzeTrasfertaMW.Create(Self);
  A106FDistanzeTrasfertaMW.SelM041_Funzioni:=SelTabella;
  selTabella.SetVariable('ORDERBY','ORDER BY DESC_PARTENZA, DESC_DESTINAZIONE');
  selTabella.Open;
end;

procedure TWA106FDistanzeTrasfertaDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A106FDistanzeTrasfertaMW);
  inherited;
end;

end.
