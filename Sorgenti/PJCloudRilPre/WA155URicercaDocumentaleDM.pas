unit WA155URicercaDocumentaleDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WR300UBaseDM, A155URicercaDocumentaleMW, WR302UGestTabellaDM, Data.DB,
  OracleData;

type
  TWA155FRicercaDocumentaleDM = class(TWR302FGestTabellaDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  public
    A155MW: TA155FRicercaDocumentaleMW;
  end;

implementation

{$R *.dfm}

procedure TWA155FRicercaDocumentaleDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A155MW:=TA155FRicercaDocumentaleMW.Create(Self);
end;

procedure TWA155FRicercaDocumentaleDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A155MW);
  inherited;
end;

end.
