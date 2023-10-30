unit WA056UTurnazIndDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, medpIWMessageDlg,
  A056UTurnazIndMW, A000UInterfaccia, A000UMessaggi, Datasnap.DBClient;

type
  TWA056FTurnazIndDM = class(TWR302FGestTabellaDM)
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaDATA: TDateTimeField;
    selTabellaTURNAZIONE: TStringField;
    selTabellaPARTENZA: TFloatField;
    selTabellaPIANIF_DA_CALENDARIO: TStringField;
    selTabellaVERIFICA_TURNI: TStringField;
    selTabellaVERIFICA_RIPOSI: TStringField;
    cdsSviluppoTurnaz: TClientDataSet;
    cdsSviluppoTurnazNUM_GIORNO: TStringField;
    cdsSviluppoTurnazTURNO1: TStringField;
    cdsSviluppoTurnazTURNO2: TStringField;
    cdsSviluppoTurnazORARIO: TStringField;
    cdsSviluppoTurnazASSENZA: TStringField;
    dsrSviluppoTurnaz: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet);override;
    procedure AfterDelete(DataSet: TDataSet);override;
    procedure AfterPost(DataSet: TDataSet);override;
    procedure selTabellaPIANIF_DA_CALENDARIOValidate(Sender: TField);
  private
    procedure EvtImpostaVarMW;
    procedure EvtD640DataChange;
    procedure EvtShowMsg(Msg: String);
    procedure ResultAssAutomatica(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    A056MW: TA056FTurnazIndMW;
    procedure CaricaCdsSviluppoTurnaz;
    procedure AssegnazioneAutomatica;
  end;


implementation

uses WA056UTurnazInd;

{$R *.dfm}

procedure TWA056FTurnazIndDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY DATA DESC');
  inherited;
  cdsSviluppoTurnaz.CreateDataSet;
  A056MW:=TA056FTurnazIndMW.Create(Self);
  A056MW.EvtImpostaVarMW:=EvtImpostaVarMW;
  A056MW.EvtShowMsg:=EvtShowMsg;
  A056MW.Q620:=SelTabella;
  A056MW.EvtD640DataChange:=EvtD640DataChange;
end;

procedure TWA056FTurnazIndDM.AfterDelete(DataSet: TDataSet);
begin
  SessioneOracle.ApplyUpdates([SelTabella],True);
  inherited;
end;

procedure TWA056FTurnazIndDM.AfterPost(DataSet: TDataSet);
begin
  RegistraLog.SettaProprieta('M',InterfacciaWR102.NomeTabella,Copy(Name,1,5),selTabella,True);
  SessioneOracle.ApplyUpdates([SelTabella],True);
  inherited;
end;

procedure TWA056FTurnazIndDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  (Self.Owner as TWA056FTurnazInd).AggiornaComponenti;
end;

procedure TWA056FTurnazIndDM.CaricaCdsSviluppoTurnaz;
var i:Integer;
begin
  with A056MW do
  begin
    cdsSviluppoTurnaz.Close;
    cdsSviluppoTurnaz.Open;
    cdsSviluppoTurnaz.EmptyDataSet;
    for i:=0 to Turno1.Count - 1 do
    begin
      cdsSviluppoTurnaz.Append;
      cdsSviluppoTurnaz.FieldByName('NUM_GIORNO').AsString:=IntToStr(i);
      cdsSviluppoTurnaz.FieldByName('TURNO1').AsString:=Turno1[i];
      cdsSviluppoTurnaz.FieldByName('TURNO2').AsString:=Turno2[i];
      cdsSviluppoTurnaz.FieldByName('ORARIO').AsString:=Orario[i];
      cdsSviluppoTurnaz.FieldByName('ASSENZA').AsString:=Causale[i];
      cdsSviluppoTurnaz.Post;
    end;
  end;
end;

procedure TWA056FTurnazIndDM.EvtD640DataChange;
begin
  with (Self.Owner as TWA056FTurnazInd) do
    if Trim(cmbTurnazione.Text) <> '' then
    begin
      lblDescrTurnazione.Caption:=A056MW.Q640.FieldByName('Descrizione').AsString;
      A056MW.CalcolaSviluppo(A056MW.Q640.FieldByName('Codice').AsString);
    end;
end;

procedure TWA056FTurnazIndDM.EvtImpostaVarMW;
begin
  with (Self.Owner as TWA056FTurnazInd) do
  begin
    A056MW.ChkPregressoChecked:=chkPregresso.Checked;
    A056MW.ChkPianifDaCalendarioChecked:=ChkPianifDaCalendario.Checked;
    A056MW.ChkGGLavChecked:=chkGGLav.Checked;
    A056MW.ChkRiposiChecked:=chkRiposi.Checked;
    A056MW.Turnazione:=cmbTurnazione.Text;
    A056MW.PartenzaValue:=StrToInt(edtPuntoPartenza.Text);
  end;
end;

procedure TWA056FTurnazIndDM.EvtShowMsg(Msg: String);
begin
  MsgBox.MessageBox(Msg,'INFORMA');
end;

procedure TWA056FTurnazIndDM.AssegnazioneAutomatica;
begin
  A056MW.AssegnazioneAutomaticaStep1;
  MsgBox.WebMessageDlg(A000MSG_A056_DLG_ASSEGNAZ_AUTOMATICA,mtConfirmation,[mbYes, mbNo],ResultAssAutomatica,'');
  Abort;
end;

procedure TWA056FTurnazIndDM.ResultAssAutomatica(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    A056MW.AssegnazioneAutomaticaStep2;
    (Self.Owner as TWA056FTurnazInd).actAggiornaExecute(nil);
  end;
end;

procedure TWA056FTurnazIndDM.selTabellaPIANIF_DA_CALENDARIOValidate(
  Sender: TField);
begin
  inherited;
  A056MW.PianifDaCalendarioValidate;
  if SelTabella.FieldByName('PIANIF_DA_CALENDARIO').AsString = 'S' then
    (Self.Owner as TWA056FTurnazInd).ChkPianifDaCalendario.Checked:=True
  else
    (Self.Owner as TWA056FTurnazInd).ChkPianifDaCalendario.Checked:=False;
end;

end.
