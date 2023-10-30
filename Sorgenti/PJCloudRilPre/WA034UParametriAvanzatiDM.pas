unit WA034UParametriAvanzatiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData,medpIWMessageDlg,A000UInterfaccia,
  A000UMessaggi, A034UParametriAvanzatiMW,WR102UGestTabella;

type
  TWA034FParametriAvanzatiDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_INTERFACCIA: TStringField;
    selTabellaVOCE_PAGHE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaVOCE_PAGHE_CEDOLINO: TStringField;
    selTabellaVOCE_PAGHE_NEGATIVA: TStringField;
    selTabellaDAL: TDateTimeField;
    selTabellaAL: TDateTimeField;
    selTabellaAUTOINC_DAL: TStringField;
    selTabellaAUTOINC_AL: TStringField;
    selTabellaARROTONDAMENTO: TFloatField;
    selTabellaFORMULA: TStringField;
    selTabellaSPOSTA_VALIMP: TStringField;
    selTabellaDESC_VPAGHE_NEGATIVA: TStringField;
    selTabellaDESC_VPAGHE_CEDOLINO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selTabellaDALSetText(Sender: TField; const Text: string);
    procedure selTabellaDALGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selTabellaAfterOpen(DataSet: TDataSet);
  private
    FDescInterfaccia: String;
    procedure ResultControlloVociPaghe(Sender: TObject; Res: TmeIWModalResult;
      KeyID: String);
  public
    A034FParametriAvanzatiMW : TA034FParametriAvanzatiMW;
    property DescrizioneInterfaccia: String read FDescInterfaccia;
  end;

implementation

{$R *.dfm}

procedure TWA034FParametriAvanzatiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  A034FParametriAvanzatiMW:=TA034FParametriAvanzatiMW.Create(Self);
  inherited;
end;

procedure TWA034FParametriAvanzatiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(A034FParametriAvanzatiMW);
  inherited;
end;

procedure TWA034FParametriAvanzatiDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  MsgBox.ClearKeys;
end;

procedure TWA034FParametriAvanzatiDM.BeforePost(DataSet: TDataSet);
var
  VoceOld, Msg: String;
begin
  inherited;
  if not MsgBox.KeyExists('PUNTO_1') then
  begin
    A034FParametriAvanzatiMW.selControlloVociPaghe.Storicizzazione:=InterfacciaWR102.StoricizzazioneInCorso;

    if (not selTabella.FieldByName('DAL').IsNull) and
      (selTabella.FieldByName('DAL').AsDateTime < selTabella.FieldByName('DECORRENZA').AsDateTime) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A034_ERR_DATA_INIZIO_VALIDITA,mtError,[mbOk],nil,'');
      Abort;
    end;

    // fine validità
    if (not selTabella.FieldByName('AL').IsNull) and
      (selTabella.FieldByName('AL').AsDateTime < selTabella.FieldByName('DECORRENZA').AsDateTime) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A034_ERR_DATA_FINE_VALIDITA,mtError,[mbOk],nil,'');
      Abort;
    end;

    // voce paghe cedolino
    if (DataSet.State = dsInsert) or (selTabella.FieldByName('VOCE_PAGHE_CEDOLINO').medpOldValue = null) then
      VoceOld:=''
    else
      VoceOld:=selTabella.FieldByName('VOCE_PAGHE_CEDOLINO').medpOldValue;
    // formula
    if not A034FParametriAvanzatiMW.VerificaFormula(selTabella.FieldByName('FORMULA').AsString,Msg) then
    begin
      MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
      Abort;
    end;

    if not A034FParametriAvanzatiMW.selControlloVociPaghe.ControlloVociPaghe(VoceOld,selTabella.FieldByName('VOCE_PAGHE_CEDOLINO').AsString) then
    begin
      MsgBox.WebMessageDlg(A034FParametriAvanzatiMW.selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ResultControlloVocipaghe,'PUNTO_1');
      Abort;
    end;
  end;
end;

procedure TWA034FParametriAvanzatiDM.ResultControlloVociPaghe(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrNo then
  begin
    MsgBox.ClearKeys;
    A034FParametriAvanzatiMW.selControlloVociPaghe.Storicizzazione:=False;
  end
  else
  begin
    (Self.Owner as TWR102FGestTabella).actConfermaExecute(nil); //riesegue il post impostando correttamente tutti i componenti visuali
  end;
end;

procedure TWA034FParametriAvanzatiDM.selTabellaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if A034FParametriAvanzatiMW.ImpostaSelInterfaccia(Parametri.DataLavoro) then
  begin
    FDescInterfaccia:=Parametri.CampiRiferimento.C9_ScaricoPaghe + ': ' +
                      selTabella.FieldByName('COD_INTERFACCIA').AsString;

    if A034FParametriAvanzatiMW.selInterfaccia.Locate('CODICE',selTabella.FieldByName('COD_INTERFACCIA').AsString,[]) then
      FDescInterfaccia:=FDescInterfaccia + ' ' + A034FParametriAvanzatiMW.selInterfaccia.FieldByName('DESCRIZIONE').AsString;
  end
  else
  begin
    FDescInterfaccia:=selTabella.FieldByName('COD_INTERFACCIA').AsString;
  end;
end;

procedure TWA034FParametriAvanzatiDM.selTabellaDALGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if Sender.IsNull then
    Text:=''
  else
    Text:=FormatDateTime('mm/yyyy',Sender.AsDateTime);
end;

procedure TWA034FParametriAvanzatiDM.selTabellaDALSetText(Sender: TField;
  const Text: string);
begin
  if Trim(Text) <> '' then
    Sender.AsString:='01/' + Text
  else
    Sender.Clear;
end;

end.
