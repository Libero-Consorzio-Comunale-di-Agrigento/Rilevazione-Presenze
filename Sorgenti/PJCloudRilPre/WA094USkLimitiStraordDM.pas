unit WA094USkLimitiStraordDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A094USkLimitiStraordMW,
  A000UInterfaccia;

type
  TWA094FSkLimitiStraordDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TIntegerField;
    selTabellaANNO: TIntegerField;
    selTabellaMESE: TIntegerField;
    selTabellaDAL: TIntegerField;
    selTabellaAL: TIntegerField;
    selTabellaLIQUIDABILE: TStringField;
    selTabellaCAUSALE: TStringField;
    selTabellaORE_TEORICHE: TStringField;
    selTabellaORE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    FSelAnagrafe: TOracleDataset;
  public
    A094FSkLimitiStraordMW: TA094FSkLimitiStraordMW;
    function GetProgressivo:Integer;  //richiamata da MW per ottenere progressivo di selAnagrafe
    property SelAnagrafe: TOracleDataset read FSelAnagrafe write FSelAnagrafe;
  end;

implementation

{$R *.dfm}

procedure TWA094FSkLimitiStraordDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  NonAprireSelTabella:=True;
  inherited;
  A094FSkLimitiStraordMW:=TA094FSkLimitiStraordMW.Create(Self);
  A094FSkLimitiStraordMW.ProgressivoCorrente:=getProgressivo;
  A094FSkLimitiStraordMW.SelT820_Funzioni:=SelTabella;

  SelTabella.FieldByName('CAUSALE').Visible:=Parametri.CampiRiferimento.C15_LimitiMensCaus = 'S';
  SelTabella.FieldByName('DAL').Visible:=SelTabella.FieldByName('CAUSALE').Visible;
  SelTabella.FieldByName('Al').Visible:=SelTabella.FieldByName('CAUSALE').Visible;

  SelTabella.setVariable('ORDERBY','ORDER BY ANNO DESC, MESE DESC, LIQUIDABILE');
  SelTabella.Open;
end;

procedure TWA094FSkLimitiStraordDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A094FSkLimitiStraordMW);
  inherited;
end;

procedure TWA094FSkLimitiStraordDM.OnNewRecord(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.SelT820NewRecord;
  inherited;
end;

procedure TWA094FSkLimitiStraordDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;

  //SELTABELLA SINCRONIZZATO CON SELT825
  with A094FSkLimitiStraordMW do
  begin
    selT825.Close;
    selT825.SetVariable('PROGRESSIVO',selTabella.GetVariable('PROGRESSIVO'));
    selT825.Open;
  end;

  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.ini
  // imposta progressivo su tabella ore supplementari
  A094FSkLimitiStraordMW.selT830.Close;
  A094FSkLimitiStraordMW.selT830.SetVariable('PROGRESSIVO',selTabella.GetVariable('PROGRESSIVO'));
  A094FSkLimitiStraordMW.selT830.Open;
  // AOSTA_REGIONE - commessa 2015/170 SVILUPPO#2.fine
end;

procedure TWA094FSkLimitiStraordDM.BeforeDelete(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.SelT820BeforeDelete;
  inherited;
end;

procedure TWA094FSkLimitiStraordDM.BeforeEdit(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.SelT820BeforeEdit;
  inherited;
end;

procedure TWA094FSkLimitiStraordDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A094FSkLimitiStraordMW.SelT820BeforePost;
  inherited;
end;

function TWA094FSkLimitiStraordDM.GetProgressivo: Integer;
begin
  Result:=FSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

end.
