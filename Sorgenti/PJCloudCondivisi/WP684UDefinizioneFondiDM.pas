unit WP684UDefinizioneFondiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB,
  OracleData, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg, P684UDefinizioneFondiMW;

type
  TWP684FDefinizioneFondiDM = class(TWR303FGestMasterDetailDM)
    selTabellaCOD_FONDO: TStringField;
    selTabellaDECORRENZA_DA: TDateTimeField;
    selTabellaDECORRENZA_A: TDateTimeField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaCOD_MACROCATEG: TStringField;
    selTabellaCOD_RAGGR: TStringField;
    selTabellaDATA_COSTITUZ: TDateTimeField;
    selTabellaFILTRO_DIPENDENTI: TStringField;
    selTabellaDATA_ULTIMO_MONIT: TDateTimeField;
    selTabellaDESC_MACROCATEG: TStringField;
    selTabellaNOTE: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    P684FDefinizioneFondiMW: TP684FDefinizioneFondiMW;
    procedure RelazionaTabelleFiglie; override;
    procedure selP688RAfterPost(DataSet: TDataSet);
    procedure selP688DAfterPost(DataSet: TDataSet);
  end;

implementation

uses WP684UDefinizioneFondi, WP684UDefinizioneFondiDettFM;

{$R *.dfm}

procedure TWP684FDefinizioneFondiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY P684.DECORRENZA_DA, P684.COD_FONDO');
  P684FDefinizioneFondiMW:=TP684FDefinizioneFondiMW.Create(Self);
  P684FDefinizioneFondiMW.selP684:=selTabella;
  P684FDefinizioneFondiMW.selP688R.AfterPost:=selP688RAfterPost;
  P684FDefinizioneFondiMW.selP688D.AfterPost:=selP688DAfterPost;
  inherited;
end;

procedure TWP684FDefinizioneFondiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(P684FDefinizioneFondiMW);
  inherited;
end;

procedure TWP684FDefinizioneFondiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  P684FDefinizioneFondiMW.selP684AfterScroll;
  if (Self.Owner as TWP684FDefinizioneFondi).WDettaglioFM = nil then exit;
  with P684FDefinizioneFondiMW do
  begin
    with ((Self.Owner as TWP684FDefinizioneFondi).WDettaglioFM as TWP684FDefinizioneFondiDettFM) do
    begin
      edtTotRisorse.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(0)),0)]);
      edtTotSpeso.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(1)),0)]);
      edtTotResiduo.Text:=Format('%15.0n',[StrToFloatDef(VarToStr(selP688Tot.Field(2)),0)]);
    end;
  end;
  (Self.Owner as TWP684FDefinizioneFondi).AbilitazioniComponenti;
end;

procedure TWP684FDefinizioneFondiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  P684FDefinizioneFondiMW.selP684BeforePost;
  inherited;
end;

procedure TWP684FDefinizioneFondiDM.RelazionaTabelleFiglie;
begin
  P684FDefinizioneFondiMW.LeggoSelP686R(selTabella.FieldByName('COD_FONDO').AsString,selTabella.FieldByName('DECORRENZA_DA').AsString);
  P684FDefinizioneFondiMW.LeggoSelP686D(selTabella.FieldByName('COD_FONDO').AsString,selTabella.FieldByName('DECORRENZA_DA').AsString);
  P684FDefinizioneFondiMW.LeggoSelP688R(selTabella.FieldByName('COD_FONDO').AsString,selTabella.FieldByName('DECORRENZA_DA').AsString);
  P684FDefinizioneFondiMW.LeggoSelP688D(selTabella.FieldByName('COD_FONDO').AsString,selTabella.FieldByName('DECORRENZA_DA').AsString);
  inherited;
end;

procedure TWP684FDefinizioneFondiDM.selP688RAfterPost(DataSet: TDataSet);
begin
  inherited;
  with P684FDefinizioneFondiMW do
  begin
    selP688RAfterPost(DataSet);
    if (selP688R.FieldByName('COD_VOCE_GEN').AsString <> '') and (selP688R.FieldByName('COD_VOCE_DET').AsString <> '') and
       (selP688R.FieldByName('COD_ARROTONDAMENTO').AsString = '') then
    begin
      MsgBox.AddMessage(A000MSG_P684_MSG_COD_ARROTONDAMENTO,mtInformation,[mbOK],nil,'');
      MsgBox.ShowMessages;
    end;
  end;
end;

procedure TWP684FDefinizioneFondiDM.selP688DAfterPost(DataSet: TDataSet);
begin
  inherited;
  with P684FDefinizioneFondiMW do
  begin
    selP688DAfterPost(DataSet);
    if (selP688D.FieldByName('COD_VOCE_GEN').AsString <> '') and (selP688D.FieldByName('COD_VOCE_DET').AsString <> '') and
       (selP688D.FieldByName('COD_ARROTONDAMENTO').AsString = '') then
    begin
      MsgBox.AddMessage(A000MSG_P684_MSG_COD_ARROTONDAMENTO,mtInformation,[mbOK],nil,'');
      MsgBox.ShowMessages;
    end;
  end;
end;

end.
