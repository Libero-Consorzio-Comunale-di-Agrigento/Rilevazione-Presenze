unit WS735UPunteggiFasceIncentiviDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, S735UPunteggiFasceIncentiviMW;

type
  TWS735FPunteggiFasceIncentiviDM = class(TWR302FGestTabellaDM)
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaPUNTEGGIO_DA: TFloatField;
    selTabellaPUNTEGGIO_A: TFloatField;
    selTabellaPERC: TFloatField;
    selTabellaTIPOLOGIA: TStringField;
    selTabellaCODQUOTA: TStringField;
    selTabellaFLESSIBILITA: TStringField;
    selTabellaD_CODQUOTA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); Override;
  private
    { Private declarations }
  public
    S735FPunteggiFasceIncentiviMW: TS735FPunteggiFasceIncentiviMW;
  end;

implementation

{$R *.dfm}

procedure TWS735FPunteggiFasceIncentiviDM.BeforePost(DataSet: TDataSet);
begin
  inherited;
  S735FPunteggiFasceIncentiviMW.BeforePost;
end;

procedure TWS735FPunteggiFasceIncentiviDM.IWUserSessionBaseCreate(
  Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY', 'ORDER BY CODQUOTA, FLESSIBILITA, SG735.PUNTEGGIO_DA, SG735.PUNTEGGIO_A, SG735.DECORRENZA');
  selTabella.SetVariable('TIPO', 'V');
  NonAprireSelTabella:=True;
  inherited;

  S735FPunteggiFasceIncentiviMW:=TS735FPunteggiFasceIncentiviMW.Create(Self);
  S735FPunteggiFasceIncentiviMW.Q735:=selTabella;

  selTabella.Open;
end;


end.
