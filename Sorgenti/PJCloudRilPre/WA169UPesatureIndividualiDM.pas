unit WA169UPesatureIndividualiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR303UGestMasterDetailDM, Data.DB, OracleData,
  A169UPesatureIndividualiMW, C180FunzioniGenerali, A000UInterfaccia, medpIWMessageDlg, A000UMessaggi;

type
  TWA169FPesatureIndividualiDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODGRUPPO: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaFILTRO_ANAGRAFE: TStringField;
    selTabellaCODTIPOQUOTA: TStringField;
    selTabellaPESO_TOTALE: TFloatField;
    selTabellaPESO_IND_MIN: TFloatField;
    selTabellaPESO_IND_MAX: TFloatField;
    selTabellaQUOTA_TOTALE: TFloatField;
    selTabellaDATARIF: TDateTimeField;
    selTabellaCHIUSO: TStringField;
    selTabellaANNO: TFloatField;
    selTabellaDESCTIPOQUOTA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    //procedure InizioCiclo;
    //procedure AvanzamentoCiclo;
    procedure FineCiclo;
    procedure ResultMessaggio(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    A169FPesatureIndividualiMW: TA169FPesatureIndividualiMW;
    QuotaIndividuale,PesoCalcolato,QuotaCalcolata:Real;
    TotDip,TotalePesi,TotaleQuote,TotalePesiCalc,TotaleQuoteCalc:Real;
    lstMatricole:TStringList;
    procedure AggiornaTotali(Anno:Integer;CodGruppo,CodQuota:String);
  protected
    procedure RelazionaTabelleFiglie; override;
  end;

implementation

uses WA169UPesatureIndividuali, WA169UPesatureIndividualiDettFM;

{$R *.dfm}

procedure TWA169FPesatureIndividualiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by anno, codgruppo, codtipoquota');
  NonAprireSelTabella:=True; //§
  inherited;
  A169FPesatureIndividualiMW:=TA169FPesatureIndividualiMW.Create(Self);
  A169FPesatureIndividualiMW.selT773:=selTabella;
  A169FPesatureIndividualiMW.dsrT774.DataSet:=A169FPesatureIndividualiMW.selT774;
  selTabella.FieldByName('DESCTIPOQUOTA').LookupDataSet:=A169FPesatureIndividualiMW.selT765;
  selTabella.Open;
  A169FPesatureIndividualiMW.FineCiclo:=FineCiclo;
end;

procedure TWA169FPesatureIndividualiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A169FPesatureIndividualiMW);
  inherited;
end;

procedure TWA169FPesatureIndividualiDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A169FPesatureIndividualiMW.selT773NewRecord(DataSet);
end;

procedure TWA169FPesatureIndividualiDM.RelazionaTabelleFiglie;
begin
  with A169FPesatureIndividualiMW.selT774 do
  begin
    Close;
    SetVariable('ANNO',selTabella.FieldByName('ANNO').AsInteger);
    SetVariable('CODICE',selTabella.FieldByName('CODGRUPPO').AsString);
    SetVariable('CODQUOTA',selTabella.FieldByName('CODTIPOQUOTA').AsString);
    Open;
    ReadOnly:=False;
  end;
end;

procedure TWA169FPesatureIndividualiDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if((Self.Owner as TWA169FPesatureIndividuali).WDettaglioFM <> nil) then
  begin
    (Self.Owner as TWA169FPesatureIndividuali).Aggiorna(True,False);
  end;
  A169FPesatureIndividualiMW.selT773AfterScroll(DataSet);
end;

procedure TWA169FPesatureIndividualiDM.AggiornaTotali(Anno:Integer;CodGruppo,CodQuota:String);
begin
  TotalePesi:=0;
  TotaleQuote:=0;
  TotalePesiCalc:=0;
  TotaleQuoteCalc:=0;
  with A169FPesatureIndividualiMW do
  begin
    selT774.Close;
    selT774.SetVariable('ANNO',Anno);
    selT774.SetVariable('CODICE',CodGruppo);
    selT774.SetVariable('CODQUOTA',CodQuota);
    selT774.Open;
    selT774.First;
    TotDip:=selT774.RecordCount;
    lstMatricole.Clear;
    while not selT774.Eof do
    begin
      if selT774.FieldByName('PESO_INDIVIDUALE').AsFloat > 0 then
      begin
        TotalePesi:=TotalePesi + selT774.FieldByName('PESO_INDIVIDUALE').AsFloat;
        TotaleQuote:=TotaleQuote + selT774.FieldByName('QUOTA_ASSEGNATA').AsFloat;
        TotalePesiCalc:=TotalePesiCalc + selT774.FieldByName('PESO_CALCOLATO').AsFloat;
        TotaleQuoteCalc:=TotaleQuoteCalc + selT774.FieldByName('QUOTA_CALCOLATA').AsFloat;
      end;
      if (selT774.FieldByName('QUOTA_INDIVIDUALE').AsFloat = 0) or
         (selT774.FieldByName('PESO_INDIVIDUALE').AsFloat <= 0) then
        lstMatricole.Add(selT774.FieldByName('MATRICOLA').AsString);
      selT774.Next;
    end;
  end;
  TotaleQuote:=R180Arrotonda(TotaleQuote,0.01,'P');
  TotaleQuoteCalc:=R180Arrotonda(TotaleQuoteCalc,0.01,'P');
end;

procedure TWA169FPesatureIndividualiDM.AfterPost(DataSet: TDataSet);
var s:String;
begin
  inherited;
  if A169FPesatureIndividualiMW.AggT774 then
  begin
    MsgBox.AddMessage(A000MSG_A169_MSG_DIPENDENTI_CAMBIATI);
    MsgBox.ShowMessages;
  end;
  A169FPesatureIndividualiMW.AfterPost(DataSet);
end;

procedure TWA169FPesatureIndividualiDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A169FPesatureIndividualiMW.BeforePostNoStorico(DataSet);
  inherited;
end;

procedure TWA169FPesatureIndividualiDM.FineCiclo;
begin
  Screen.Cursor:=crDefault;
  {
  A169FPesatureIndividuali.ProgressBar1.Position:=0;
  A169FPesatureIndividuali.btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  }
  if RegistraMsg.ContieneTipoA then
  begin
    ((Self.Owner as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).btnAnomalie.Enabled:=true;
    MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOMALIE_VIS,mtConfirmation,[mbYes,mbNo],ResultMessaggio,'prova');
  end
  else
    //TWA169FPesatureIndividuali.Aggiorna(True,False);
end;

procedure TWA169FPesatureIndividualiDM.ResultMessaggio(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes: ((Self.Owner as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).btnAnomalieClick(nil);
  end;
end;

procedure TWA169FPesatureIndividualiDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  A169FPesatureIndividualiMW.selT773FilterRecord(DataSet,Accept);
end;

end.
