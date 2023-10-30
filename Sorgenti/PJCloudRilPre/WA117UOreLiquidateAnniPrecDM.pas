unit WA117UOreLiquidateAnniPrecDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A117UOreLiquidateAnniPrecMW,
  C180FunzioniGenerali, A000UInterfaccia, A000UMessaggi, MedpIWMessageDlg;

type
  TWA117FOreLiquidateAnniPrecDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaANNO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaORE_LIQUIDATE: TStringField;
    selTabellaVARIAZIONE_ORE: TStringField;
    selTabellaNOTE: TStringField;
    selTabellaOREPERSE: TStringField;
    selTabellaOREPERSE_TOT: TStringField;
    selTabellaOREPERSE_RES: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaAfterOpen(DataSet: TDataSet);
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
  private
    FselAnagrafe: TOracleDataSet;
    AnnoLiq: Integer;
  public
    A117FOreLiquidateAnniPrecMW: TA117FOreLiquidateAnniPrecMW;
    property selAnagrafe: TOracleDataSet read FselAnagrafe write FselAnagrafe;
  end;

implementation

uses WA117UOreLiquidateAnniPrec;

{$R *.dfm}

procedure TWA117FOreLiquidateAnniPrecDM.IWUserSessionBaseCreate(
  Sender: TObject);
begin
  A117FOreLiquidateAnniPrecMW:=TA117FOreLiquidateAnniPrecMW.Create(Self);
  A117FOreLiquidateAnniPrecMW.selT134_Funzioni:=selTabella;
  selTabella.FieldByName('DATA').OnGetText:=A117FOreLiquidateAnniPrecMW.DATAGetText;
  selTabella.FieldByName('OREPERSE').OnValidate:=A117FOreLiquidateAnniPrecMW.OREPERSEValidate;

  FselAnagrafe:=nil;
  inherited;
end;

procedure TWA117FOreLiquidateAnniPrecDM.AfterPost(DataSet: TDataSet);
var AnnoRes, AnnoLiq: Integer;
begin
  AnnoRes:=selTabella.FieldByName('ANNO').AsInteger;
  AnnoLiq:=R180Anno(selTabella.FieldByName('DATA').AsDateTime);
  try
    //Verifico se aggiornare i residui tramite il passaggio di anno
    A117FOreLiquidateAnniPrecMW.AggiornaResidui(FSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,AnnoLiq);
    inherited;
  except
    on e: exception do
    begin
      SessioneOracle.RollBack;
      MsgBox.WebMessageDlg(format(A000MSG_ERR_FMT_REG_FALLITA,[e.Message]),mtError,[mbOk],nil,'');
    end;
  end;
  Seltabella.Close;
  Seltabella.Open;
  Seltabella.Locate('ANNO',AnnoRes,[]);
end;

procedure TWA117FOreLiquidateAnniPrecDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  (Self.Owner as TWA117FOreLiquidateAnniPrec).ImpostaDateWC700;
end;

procedure TWA117FOreLiquidateAnniPrecDM.BeforeDelete(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134BeforeDelete(FSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  AnnoLiq:=R180Anno(selTabella.FieldByName('DATA').AsDateTime);
  inherited;
end;

procedure TWA117FOreLiquidateAnniPrecDM.AfterDelete(DataSet: TDataSet);
begin
  try
    //Verifico se aggiornare i residui tramite il passaggio di anno
    A117FOreLiquidateAnniPrecMW.AggiornaResidui(FSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,AnnoLiq);
    inherited;
  except
    on e: exception do
    begin
      SessioneOracle.RollBack;
      MsgBox.WebMessageDlg(format(A000MSG_ERR_FMT_REG_FALLITA,[e.Message]),mtError,[mbOk],nil,'');
      //ricarica dati
      selTabella.Close;
      selTabella.Open;
    end;
  end;
end;

procedure TWA117FOreLiquidateAnniPrecDM.BeforePost(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134BeforePost(FSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  inherited;
end;

procedure TWA117FOreLiquidateAnniPrecDM.IWUserSessionBaseDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(A117FOreLiquidateAnniPrecMW);
end;

procedure TWA117FOreLiquidateAnniPrecDM.OnNewRecord(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134NewRecord(FSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  inherited;
end;

procedure TWA117FOreLiquidateAnniPrecDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  A117FOreLiquidateAnniPrecMW.SelT134AfterOpen;
end;

procedure TWA117FOreLiquidateAnniPrecDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  if FSelAnagrafe <> nil then
    A117FOreLiquidateAnniPrecMW.SelT134CalcFields(FSelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
end;

end.
