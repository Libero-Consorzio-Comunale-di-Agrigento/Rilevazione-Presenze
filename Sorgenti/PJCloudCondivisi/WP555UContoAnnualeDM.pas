unit WP555UContoAnnualeDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, P555UContoAnnualeMW, A000UInterfaccia, medpIWMessageDlg;

type
  TWP555FContoAnnualeDM = class(TWR303FGestMasterDetailDM)
    selTabellaANNO: TIntegerField;
    selTabellaCOD_TABELLA: TStringField;
    selTabellaDESC_TABELLA: TStringField;
    selTabellaCHIUSO: TStringField;
    selTabellaDESC_CHIUSO: TStringField;
    selTabellaID_CONTOANN: TFloatField;
    selTabellaDATA_CHIUSURA: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaCalcFields(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
    bErroreCalcoloManuale: boolean;
    P555FContoAnnualeMW: TP555FContoAnnualeMW;
  end;

implementation

uses
  WP555UContoAnnuale;

{$R *.dfm}
procedure TWP555FContoAnnualeDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  P555FContoAnnualeMW:=TP555FContoAnnualeMW.Create(Self);
  P555FContoAnnualeMW.SelP554_Funzioni:=selTabella;
  P555FContoAnnualeMW.selP555.ReadOnly:=False;
  selTabella.SetVariable('ORDERBY','order by anno, cod_tabella');
  inherited;
end;

procedure TWP555FContoAnnualeDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  P555FContoAnnualeMW.SelP554BeforeDelete;
end;

procedure TWP555FContoAnnualeDM.AfterScroll(DataSet: TDataSet);
begin
  P555FContoAnnualeMW.SelP554AfterScroll;
  inherited;
end;

procedure TWP555FContoAnnualeDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P555FContoAnnualeMW);
  inherited;
end;

procedure TWP555FContoAnnualeDM.RelazionaTabelleFiglie;
var
  sMsg: String;
begin
  inherited;
  bErroreCalcoloManuale:=False;
  if ((Self.Owner as TWP555FContoAnnuale) = nil) or
     ((Self.Owner as TWP555FContoAnnuale).Detail = nil) then
    Exit;

  if (Self.Owner as TWP555FContoAnnuale).Detail.rgpTipoDati.ItemIndex = 2 then
  begin
    sMsg:=P555FContoAnnualeMW.VerificaCalcoloManuale(selTabella.FieldByName('COD_TABELLA').AsString);
    if sMsg <> '' then
    begin
      bErroreCalcoloManuale:=True;
      MsgBox.WebMessageDlg(sMsg,mtError,[mbOk],nil,'');
      Exit;
    end;
    P555FContoAnnualeMW.ImpostaSelQuery(selTabella.FieldByName('COD_TABELLA').AsString);
  end
  else
  begin
    P555FContoAnnualeMW.Aggiorna;
  end;
end;

procedure TWP555FContoAnnualeDM.selTabellaCalcFields(DataSet: TDataSet);
begin
  P555FContoAnnualeMW.ImpostaSelP552;
  selTabella.FieldByName('DESC_TABELLA').AsString:=P555FContoAnnualeMW.selP552.FieldByName('DESCRIZIONE').AsString;
end;

end.
