unit WA157UCapitoliTrasferteDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, A157UCapitoliTrasferteMW;

type
  TWA157FCapitoliTrasferteDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaFILTRO_ANAGRAFE: TStringField;
    selTabellaTIPO_MISSIONE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
  public
    { Public declarations }
    A157MW:TA157FCapitoliTrasferteMW;
  end;

implementation

{$R *.dfm}

procedure TWA157FCapitoliTrasferteDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A157MW:=TA157FCapitoliTrasferteMW.Create(nil);
end;

procedure TWA157FCapitoliTrasferteDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A157MW);
  inherited;
end;

end.
