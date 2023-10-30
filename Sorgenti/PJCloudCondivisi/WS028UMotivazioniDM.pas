unit WS028UMotivazioniDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  S028UMotivazioniMW;

type
  TWS028FMotivazioniDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDESCRIZIONE_AGG: TStringField;
    selTabellaSTAMPA_FAMILIARI: TStringField;
    selTabellaELENCO_NUMERI_PREC: TStringField;
    selTabellaELENCO_NUMERI_SUCC: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    S028MW:TS028FmotivazioniMW;
  end;

implementation

{$R *.dfm}

procedure TWS028FMotivazioniDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  S028MW:=TS028FmotivazioniMW.Create(nil);
end;

procedure TWS028FMotivazioniDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(S028MW);
end;

end.
