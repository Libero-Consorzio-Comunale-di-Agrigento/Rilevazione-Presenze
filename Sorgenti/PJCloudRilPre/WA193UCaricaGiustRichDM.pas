unit WA193UCaricaGiustRichDM;

interface

uses
  A004UGiustifAssPresMW, A000UInterfaccia,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData;

type
  TWA193FCaricaGiustRichDM = class(TWR302FGestTabellaDM)
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
  public
    A004MW: TA004FGiustifAssPresMW;
    procedure AfterCreate;
  end;

implementation

uses WA193UCaricaGiustRich;

{$R *.dfm}

procedure TWA193FCaricaGiustRichDM.IWUserSessionBaseCreate(Sender: TObject);
var
  i: Integer;
begin
  NonAprireSelTabella:=True;

  inherited;

  // middleware A004
  A004MW:=TA004FGiustifAssPresMW.Create(Self);
  with A004MW do
  begin
    Chiamante:='WA193';
    GestioneSingolaDM:=True;

    Q265.OnFilterRecord:=nil;
    Q275.OnFilterRecord:=nil;
    if Q265.Active then
      Q265.Refresh;
    if A004MW.Q275.Active then
      Q275.Refresh;

    // sostituzione al volo del dataset
    selTabella:=selT050;
    dsrTabella.DataSet:=selTabella; // necessario reimpostare il collegamento con il datasource dsrTabella

    selTabella.Close;
    selTabella.SetVariable('AZIENDA',Parametri.Azienda);
    selTabella.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  end;
end;

procedure TWA193FCaricaGiustRichDM.AfterCreate;
begin
  with A004MW do
  begin
    selAnagrafe:=(Self.Owner as TWA193FCaricaGiustRich).grdC700.selAnagrafe;
    (Self.Owner as TWA193FCaricaGiustRich).grdC700.WC700FM.C700MergeSelAnagrafe(selTabella,False);
    (Self.Owner as TWA193FCaricaGiustRich).grdC700.WC700FM.C700MergeSettaPeriodo(selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
  end;
  selTabella.Open;
end;

procedure TWA193FCaricaGiustRichDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A004MW);
  inherited;
end;

end.
