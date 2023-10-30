unit WA049UStampaPasti;

interface

uses
  StrUtils,Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox, IWCompCheckbox, meIWCheckBox,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  A000UInterfaccia,  C180FunzioniGenerali, IWCompExtCtrls, meIWImageFile, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompButton, meIWButton,
  IWAdvCheckGroup, meTIWAdvCheckGroup, meIWComboBox,A000UMessaggi, medpIWMessageDlg, C190FunzioniGeneraliWeb,System.JSON,
  A049UStampaPastiMW, medpIWImageButton, Menus, A000UCostanti, ActiveX, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect;

type
  TWA049FStampaPasti = class(TWR100FBase)
    edtDa: TmeIWEdit;
    lblDa: TmeIWLabel;
    lblA: TmeIWLabel;
    edtA: TmeIWEdit;
    lblOrologi: TmeIWLabel;
    chkAggiorna: TmeIWCheckBox;
    lblRaggruppamento: TmeIWLabel;
    chkSaltoPagina: TmeIWCheckBox;
    chkDettaglio: TmeIWCheckBox;
    cgpTerm: TmeTIWAdvCheckGroup;
    imgSelezionaTutto: TmeIWImageFile;
    imgDeselezionaTutto: TmeIWImageFile;
    cmbRaggruppamento: TmeIWComboBox;
    imbGeneraPDF: TmedpIWImageButton;
    imbAnomalie: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    imbSoloAggiornamento: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure imgSelezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgDeselezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure cmbRaggruppamentoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure edtDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imbSoloAggiornamentoClick(Sender: TObject);
    procedure imbAnomalieClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure chkAggiornaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    DataI, DataF : TDateTime;
    SenderName: String;
    A049FStampaPastiMW:TA049FStampaPastiMW;
    procedure CheckAllTerminali(Val:Boolean);
    procedure AbilitaSalvataggio;
    function GetFiltro:String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function AllTermChecked: Boolean;
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione;override;
    function ElaborazioneTerminata:String; override;
    procedure ElaborazioneServer; override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}
procedure TWA049FStampaPasti.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
  A049FStampaPastiMW:=TA049FStampaPastiMW.Create(Self);

  edtDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Parametri.DataLavoro));
  edtA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Parametri.DataLavoro));
  imbSoloAggiornamento.Enabled:=chkAggiorna.Checked;
end;

function TWA049FStampaPasti.InizializzaAccesso: Boolean;
begin
  with A049FStampaPastiMW do
  begin
    cgpTerm.Items.Clear;
    cgpTerm.Items.Add(Format('%2s %s',['**','<Orologio nullo>']));
    selT361.First;
    while not(selT361.EOF) do
    begin
      cgpTerm.Items.Add(Format('%2s %s',[selT361.FieldByName('Codice').AsString,selT361.FieldByName('Descrizione').AsString]));
      selT361.Next;
    end;
    cmbRaggruppamento.Items.Clear;
    cmbRaggruppamento.Items.add('');

    dsr010.DataSet.First;
    while not dsr010.DataSet.Eof do
    begin
      cmbRaggruppamento.Items.add(dsr010.DataSet.FieldByName('NOME_LOGICO').AsString +'=' +
                                  dsr010.DataSet.FieldByName('NOME_CAMPO').AsString);
      dsr010.DataSet.Next;
    end;
    cmbRaggruppamento.ItemIndex:=0;
  end;

  GetParametriFunzione;

  AbilitaSalvataggio;
  imbAnomalie.Enabled:=False;
  Result:=True;
end;

procedure TWA049FStampaPasti.GetParametriFunzione;
var
  I: Integer;
  Raggr: String;
  S: TStringList;
begin
  Raggr:=C004DM.GetParametro('RAGGRUPPAMENTO','');
  for I:=0 to cmbRaggruppamento.Items.Count - 1 do
  begin
    if cmbRaggruppamento.Items.ValueFromIndex[I] = Raggr  then
    begin
      cmbRaggruppamento.ItemIndex:=I;
      Break;
    end;
  end;

  chkSaltoPagina.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
  chkDettaglio.Checked:=C004DM.GetParametro('DETTAGLIO','S') = 'S';

  If C004DM.GetParametro('SELECTALL','S') = 'S' then
    checkAllTerminali(True)
  else
  begin
    S:=TStringList.Create;
    S.Clear;
    S.CommaText:=C004DM.GetParametro('RILEVATORI','');
    for i:=0 to cgpTerm.Items.Count - 1 do
    begin
      if R180IndexOf(S,Trim(Copy(cgpTerm.Items[I],1,2)),2) <> -1 then
        cgpTerm.IsChecked[i]:=True;
    end;
    FreeAndNil(S);
  end;
end;

procedure TWA049FStampaPasti.PutParametriFunzione;
begin
  with C004DM do
  begin
    Cancella001;
    PutParametro('RAGGRUPPAMENTO',cmbRaggruppamento.Items.ValueFromIndex[cmbRaggruppamento.ItemIndex]);
    PutParametro('RILEVATORI',GetFiltro);
    PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
    PutParametro('DETTAGLIO',IfThen(chkDettaglio.Checked,'S','N'));
    PutParametro('SELECTALL',IfThen(AllTermChecked,'S','N'));
  end;

  try SessioneOracle.Commit; except end;
end;

procedure TWA049FStampaPasti.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  CheckAllTerminali(True);
end;

procedure TWA049FStampaPasti.AbilitaSalvataggio;
var YY1,MM1,DD1,YY2,MM2,DD2 : Word;
    Abilitato : Boolean;
begin
  Abilitato:=False;
  try
    DecodeDate(StrToDate(edtDa.Text),YY1,MM1,DD1);
    DecodeDate(StrToDate(edtA.Text),YY2,MM2,DD2);
    if (YY1 = YY2) and (MM1 = MM2) and (DD1 = 01) and (DD2 = R180GiorniMese(StrToDate(edtA.Text))) then
      Abilitato:=True;
  except
  end;
  if not(Abilitato) then
    ChkAggiorna.Checked:=False;
  ChkAggiorna.Enabled:=(not SolaLettura) and Abilitato;
end;

procedure TWA049FStampaPasti.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
    FIdAnomalia: String;
begin
  FIdAnomalia:='';
  DCOMMsg:='';
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));

  DatiUtente:=CreateJSonString;

  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    A000SessioneWEB.AnnullaTimeOut;
    DCOMConnection.AppServer.PrintA049(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
    FIdAnomalia:=DettaglioLog;

    // codice per segnalazione anomalia all'utente
    if (FIdAnomalia <> '') then
      DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
  finally
    DCOMConnection.Connected:=False;
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TWA049FStampaPasti.CheckAllTerminali(Val: Boolean);
var
  i: Integer;
begin
  for i:=0 to cgpTerm.Items.Count - 1 do
    cgpTerm.IsChecked[i]:=Val;
  cgpTerm.AsyncUpdate;
end;

procedure TWA049FStampaPasti.chkAggiornaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  imbSoloAggiornamento.Enabled:=chkAggiorna.Checked;
end;

procedure TWA049FStampaPasti.cmbRaggruppamentoAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  val: String;
begin
  inherited;
  val:=cmbRaggruppamento.Items.ValueFromIndex[cmbRaggruppamento.ItemIndex];

  chkSaltoPagina.Enabled:=val <> '';
  chkDettaglio.Enabled:=chkSaltoPagina.Enabled;
end;

procedure TWA049FStampaPasti.edtAAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaSalvataggio;
end;

procedure TWA049FStampaPasti.edtDaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaSalvataggio;
end;

function TWA049FStampaPasti.GetFiltro: String;
var
  I: Integer;
  AllChecked: Boolean;

begin
  Result:='';
  AllChecked:=True;
  for I:=0 to cgpTerm.Items.Count - 1 do
  begin
    if cgpTerm.isChecked[I] then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + Trim(Copy(cgpTerm.Items[I],1,2));
    end
    else
      AllChecked:=False;
  end;
  if AllChecked then
    Result:='';
end;

function TWA049FStampaPasti.AllTermChecked: Boolean;
var
  I: Integer;
begin
  Result:=True;
  for I:=0 to cgpTerm.Items.Count - 1 do
  begin
    if not cgpTerm.isChecked[I] then
    begin
      Result:=False;
      Exit;
    end;
  end;
end;

procedure TWA049FStampaPasti.imbAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  if  (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + medpCodiceForm + ParamDelimiter +
            'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
            'TIPO=A,B';

    accediForm(201,Params,True);
  end;
end;

procedure TWA049FStampaPasti.imbSoloAggiornamentoClick(Sender: TObject);
begin
  imbAnomalie.Enabled:=False;

  if grdC700.SelAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  if not TryStrToDate(edtDa.Text,DataI) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['inizio periodo']),mtError,[mbOk],nil,'');
    edtDa.SetFocus;
    Exit;
  end;

  if not TryStrToDate(edtA.Text,DataF) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['fine periodo']),mtError,[mbOk],nil,'');
    edtA.SetFocus;
    Exit;
  end;

  if DataF < DataI then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    Exit;
  end;
  PutParametriFunzione;

  SenderName:=TmedpIWImageButton(Sender).HTMLName;
  If TmedpIWImageButton(Sender) = imbSoloAggiornamento then
    StartElaborazioneCiclo(SenderName)  //solo aggiornamento
  else
    StartElaborazioneServer(imbGeneraPDF.HTMLName,True);
end;

procedure TWA049FStampaPasti.imgDeselezionaTuttoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  CheckAllTerminali(False);
end;

procedure TWA049FStampaPasti.imgSelezionaTuttoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  CheckAllTerminali(True);
end;

procedure TWA049FStampaPasti.InizioElaborazione;
var
  raggr,S : String;
begin
  inherited;
  if SenderName = imbGeneraPDF.HTMLName then
    MessaggioFinaleProgressBar:=A000MSG_MSG_PDF_IN_CORSO;

  A049FStampaPastiMW.R300FAccessiMensaDtM.selDatiBloccati.Close;
  with A049FStampaPastiMW do
  begin
    CreaTabellaStampa;
    R300FAccessiMensaDtM.SettaPeriodo(DataI,DataF);
    R300FAccessiMensaDtM.FiltroRilevatori:=GetFiltro;
  end;
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataI,DataF) then
    grdC700.SelAnagrafe.CloseAll;

  raggr:=cmbRaggruppamento.Items.ValueFromIndex[cmbRaggruppamento.ItemIndex];

  if raggr <> '' then
  begin
    S:=grdC700.SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,raggr) then
    begin
      grdC700.SelAnagrafe.CloseAll;
      grdC700.SelAnagrafe.SQL.Text:=S;
    end;
  end;
  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;
end;

procedure TWA049FStampaPasti.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpTerm.Items.Count - 1 do
    cgpTerm.IsChecked[i]:=not cgpTerm.IsChecked[i];
  cgpTerm.AsyncUpdate;
end;

function TWA049FStampaPasti.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDa,json,'edtInizio');
    C190Comp2JsonString(edtA,json,'edtFine');
    json.AddPair('dcmbRaggruppamento',cmbRaggruppamento.Items.ValueFromIndex[cmbRaggruppamento.ItemIndex]);
    C190Comp2JsonString(chkSaltoPagina,json);
    C190Comp2JsonString(chkDettaglio,json);
    json.AddPair('CkBAggiorna',IfThen(chkAggiorna.Enabled and chkAggiorna.Checked,'S','N'));
    json.AddPair('FiltroRilevatori', GetFiltro);

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

function TWA049FStampaPasti.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecNO;
end;

procedure TWA049FStampaPasti.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  CheckAllTerminali(False);
end;

function TWA049FStampaPasti.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecordCount;
end;

procedure TWA049FStampaPasti.ElaboraElemento;
begin
  with A049FStampaPastiMW do
  begin
    R300FAccessiMensaDtM.ConteggiaPastiPeriodo(grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,DataI,DataF,ChkAggiorna.Checked);
    InserisciDipendente(grdC700.SelAnagrafe,cmbRaggruppamento.Items.ValueFromIndex[cmbRaggruppamento.ItemIndex]);
  end;
end;

function TWA049FStampaPasti.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.SelAnagrafe.Next;
  if not grdC700.SelAnagrafe.EOF then
    Result:=True;
end;

procedure TWA049FStampaPasti.FineCicloElaborazione;
begin
  inherited;
  imbAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  A049FStampaPastiMW.TabellaStampa.Close;
end;

procedure TWA049FStampaPasti.ElaborazioneServer;
begin
  inherited;
  CallDCOMPrinter;
end;

function TWA049FStampaPasti.ElaborazioneTerminata: String;
begin
  if imbAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA049FStampaPasti.WC700AperturaSelezione(Sender: TObject);
var
  D: TDateTime;
begin
  if TryStrToDate(edtDa.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtA.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

procedure TWA049FStampaPasti.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A049FStampaPastiMW);
end;

end.
