unit WA039URegReperibDM;

interface

uses
  Windows, Messages, SysUtils, Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData, A039URegReperibMW, medpIWMessageDlg,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  TWA039FRegReperibDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaORAINIZIO: TDateTimeField;
    selTabellaORAFINE: TDateTimeField;
    selTabellaTIPOORE: TStringField;
    selTabellaORENORMALI: TDateTimeField;
    selTabellaORECOMPRESENZA: TDateTimeField;
    selTabellaTIPOTURNO: TStringField;
    selTabellaRAGGRUPPAMENTO: TStringField;
    selTabellaORENONCAUS: TStringField;
    selTabellaTOLLERANZA: TFloatField;
    selTabellaVP_TURNO: TStringField;
    selTabellaVP_ORE: TStringField;
    selTabellaVP_MAGGIORATE: TStringField;
    selTabellaVP_NONMAGGIORATE: TStringField;
    selTabellaVP_GETTONE_CHIAMATA: TStringField;
    selTabellaVP_TURNI_OLTREMAX: TStringField;
    selTabellaTURNO_INTERO: TStringField;
    selTabellaDETRAZ_MENSA: TStringField;
    selTabellaTIPOLOGIA: TStringField;
    selTabellaPIANIF_MAX_MESE: TIntegerField;
    selTabellaPIANIF_MAX_MESE_TURNI_INTERI: TStringField;
    selTabellaORE_MIN_INDENNITA: TStringField;
    selTabellaBLOCCA_MAX_MESE: TStringField;
    selTabellaTOLL_CHIAMATA_INIZIO: TStringField;
    selTabellaTOLL_CHIAMATA_FINE: TStringField;
    selTabellaSIGLA: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure SetTextOre(Sender: TField; const Text: String);
    procedure selTabellaORAINIZIOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure selTabellaTIPOTURNOValidate(Sender: TField);
    procedure selTabellaORE_MIN_INDENNITAValidate(Sender: TField);
    procedure AfterCancel(DataSet: TDataSet);Override;
    procedure AfterDelete(DataSet: TDataSet);Override;
    procedure AfterPost(DataSet: TDataSet);Override;
    procedure OnNewRecord(DataSet: TDataSet);Override;
    procedure BeforePostNoStorico(DataSet: TDataSet);Override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure dsrTabellaStateChange(Sender: TObject);
    procedure selTabellaTOLL_CHIAMATA_INIZIOValidate(Sender: TField);
    procedure selTabellaTOLL_CHIAMATA_FINEValidate(Sender: TField);
  private
    procedure VisualizzaMsg;
    procedure evtShowMessage (Msg,VocePaghe: String);
    procedure evtAggiornamentoTurni(Msg,VocePaghe: String);
    procedure ControlloVocePaghe(NomeCampo: String);
    procedure ResultControlloVocePaghe(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultEvtAggiornamentoTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    A039MW: TA039FRegReperibMW;
    MsgRiepiloghiList, MsgAllineamentoList: TStringList;
  end;

implementation

uses WA039URegReperib, WA039URegReperibDettFM;

{$R *.dfm}

procedure TWA039FRegReperibDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  A039MW:=TA039FRegReperibMW.Create(Self);
  A039MW.SelT350:=SelTabella;
  A039MW.evtShowMessage:=evtShowMessage;
  A039MW.evtAggiornamentoTurni:=evtAggiornamentoTurni;
  inherited;
end;

procedure TWA039FRegReperibDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  if MsgRiepiloghiList <> nil then
    FreeAndNil(MsgRiepiloghiList);
  if MsgAllineamentoList <> nil then
    FreeAndNil(MsgAllineamentoList);
end;

procedure TWA039FRegReperibDM.AfterCancel(DataSet: TDataSet);
begin
  inherited;
  A039MW.AfterCancel;
end;

procedure TWA039FRegReperibDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  A039MW.AfterDelete;
end;

procedure TWA039FRegReperibDM.AfterPost(DataSet: TDataSet);
begin
  inherited;
  A039MW.AfterPost;
end;

procedure TWA039FRegReperibDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  with ((Self.Owner as TWA039FRegReperib).WDettaglioFM as TWA039FRegReperibDettFM) do
  begin
    A039MW.TipoOreItemIndex:=drgpTipoOre.ItemIndex;
    A039MW.VpTurno:=dedtVpTurno.Text;
    A039MW.VpOre:=dedtVpOre.Text;
    A039MW.VpMaggiorate:=dedtVpMaggiorate.Text;
    A039MW.VpNonMaggiorate:=dedtVpNonMaggiorate.Text;
    A039MW.GettoneChiamata:=dedtVpGettoneChiamata.Text;
  end;
  A039MW.BeforePostStep1;
  //Controllo voci paghe
  ControlloVocePaghe('VP_TURNO');
  ControlloVocePaghe('VP_ORE');
  ControlloVocePaghe('VP_MAGGIORATE');
  ControlloVocePaghe('VP_NONMAGGIORATE');
  ControlloVocePaghe('VP_GETTONE_CHIAMATA');
  ControlloVocePaghe('VP_TURNI_OLTREMAX');
  if DataSet.State = dsInsert then
    exit;
  //Aggiornamento voci paghe dei turni già riepilogati su T340
  A039MW.BeforePostStep2;
  inherited;
  VisualizzaMsg;
  MsgBox.ClearKeys;
end;

procedure TWA039FRegReperibDM.VisualizzaMsg;
var msgFinale: String;
begin
  if MsgAllineamentoList <> nil then
    msgFinale:=Format(A000MSG_A039_FMT_ALLINEAMENTO_ESEGUITO,['per le voci paghe '+MsgAllineamentoList.CommaText]);
  if MsgRiepiloghiList <> nil then
    msgFinale:=msgFinale + CRLF + Format(A000MSG_A039_FMT_ALLINEAMENTO_RIEPILOGHI,['per le voci paghe '+MsgRiepiloghiList.CommaText]);
  if msgFinale <> '' then
    MsgBox.WebMessageDlg(msgFinale,mtInformation,[mbOK],nil,'');
end;

procedure TWA039FRegReperibDM.ControlloVocePaghe(NomeCampo: String);
begin
  if SelTabella.FieldByName(NomeCampo).AsString <> '<SI>' then
  begin
    A039MW.ImpostaVocePaghe(NomeCampo);
    if (not A039MW.selControlloVociPaghe.ControlloVociPaghe(A039MW.VoceOld,A039MW.VoceNew))
        and (not MsgBox.KeyExists(NomeCampo)) then
    begin
      MsgBox.WebMessageDlg(A039MW.selControlloVociPaghe.MessaggioLog,mtConfirmation,[mbYes,mbNo],ResultControlloVocePaghe,NomeCampo);
      Abort;
    end;
  end;
end;

procedure TWA039FRegReperibDM.dsrTabellaStateChange(Sender: TObject);
begin
  inherited;
  if ((Self.Owner as TWA039FRegReperib).WDettaglioFM as TWA039FRegReperibDettFM) <> nil then
    ((Self.Owner as TWA039FRegReperib).WDettaglioFM as TWA039FRegReperibDettFM).drgpTipologiaClick(nil);
end;

procedure TWA039FRegReperibDM.evtAggiornamentoTurni(Msg,VocePaghe: String);
begin
  if(not MsgBox.KeyExists(VocePaghe)) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtAggiornamentoTurni,VocePaghe);
    Abort;
  end;
end;

procedure TWA039FRegReperibDM.ResultEvtAggiornamentoTurni(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    A039MW.AggiornaVocePaghe
  else
  begin
    if MsgRiepiloghiList = nil then
      MsgRiepiloghiList:=TStringList.Create;
    if MsgRiepiloghiList.IndexOf(selTabella.FieldByName(A039MW.VocePagheAgg).Value) < 0 then
      MsgRiepiloghiList.Add(selTabella.FieldByName(A039MW.VocePagheAgg).Value);
  end;
  SelTabella.Post;
end;

procedure TWA039FRegReperibDM.evtShowMessage(Msg,VocePaghe: String);
begin
  if MsgAllineamentoList = nil then
    MsgAllineamentoList:=TStringList.Create;
  if MsgAllineamentoList.IndexOf(VocePaghe) < 0 then
    MsgAllineamentoList.Add(VocePaghe);
end;

procedure TWA039FRegReperibDM.ResultControlloVocePaghe(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    A039MW.selControlloVociPaghe.ValutaInserimentoVocePaghe(A039MW.VoceNew);
    SelTabella.Post;
  end
  else
    MsgBox.ClearKeys;
end;

procedure TWA039FRegReperibDM.selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  A039MW.FiltroDizionario(DataSet,Accept);
end;

procedure TWA039FRegReperibDM.OnNewRecord(DataSet: TDataSet);
begin
  inherited;
  A039MW.NewRecord;
  if ((Self.Owner as TWA039FRegReperib).WDettaglioFM as TWA039FRegReperibDettFM) <> nil then
    with ((Self.Owner as TWA039FRegReperib).WDettaglioFM as TWA039FRegReperibDettFM) do
    begin
      drgpTipologia.ItemIndex:=IfThen(Seltabella.FieldByName('TIPOLOGIA').AsString='G',1,0);
      drgpTipologiaClick(nil);
    end;
end;

procedure TWA039FRegReperibDM.selTabellaORAINIZIOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  A039MW.selT350GetText(Sender,Text);
end;

procedure TWA039FRegReperibDM.selTabellaORE_MIN_INDENNITAValidate(Sender: TField);
begin
  with ((Self.Owner as TWA039FRegReperib).WDettaglioFM as TWA039FRegReperibDettFM) do
    A039MW.selT350ValidaOreMinutiIndennita(Sender,dedtOraInizio.Text,dedtOraFine.Text);
end;

procedure TWA039FRegReperibDM.selTabellaTIPOTURNOValidate(Sender: TField);
begin
  A039MW.selT350ValidaTurnoIntero(Sender);
end;

procedure TWA039FRegReperibDM.selTabellaTOLL_CHIAMATA_INIZIOValidate(Sender: TField);
begin
  A039MW.selT350ValidaTollChiamata(Sender);
end;

procedure TWA039FRegReperibDM.selTabellaTOLL_CHIAMATA_FINEValidate(Sender: TField);
begin
  A039MW.selT350ValidaTollChiamata(Sender);
end;

procedure TWA039FRegReperibDM.SetTextOre(Sender: TField;const Text: String);
begin
  A039MW.VerificaCampoOra(Sender,Text);
end;

end.
