unit WA167URegistraIncentivi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  C180FunzioniGenerali, A000UInterfaccia, WA167URegistraIncentiviDM, A167URegistraIncentiviMW,
  Generics.Collections, IWCompListbox, meIWComboBox, WC013UCheckListFM,
  medpIWMultiColumnComboBox, IWCompCheckbox, meIWCheckBox, StrUtils,
  meIWRadioGroup, IWAdvCheckGroup, meTIWAdvCheckGroup, meIWImageFile,
  medpIWImageButton, A000UCostanti,ActiveX, Data.DB, Datasnap.DBClient,
  Datasnap.Win.MConnect, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} C190FunzioniGeneraliWeb, A000UMessaggi,
  medpIWMessageDlg, IWApplication;

type
  TWA167FRegistraIncentivi = class(TWR100FBase)
    edtDaData: TmeIWEdit;
    edtAData: TmeIWEdit;
    lblDaData: TmeIWLabel;
    lblAData: TmeIWLabel;
    cmbTipoCalcolo: TmeIWComboBox;
    lblTipoCalcolo: TmeIWLabel;
    lblQuote: TmeIWLabel;
    edtQuote: TmeIWEdit;
    btnQuote: TmeIWButton;
    cmbCampoAnag: TMedpIWMultiColumnComboBox;
    lblImpostazioni: TmeIWLabel;
    lblCampoAnag: TmeIWLabel;
    chkSaltoPagina: TmeIWCheckBox;
    chkDettaglio: TmeIWCheckBox;
    rgpTipoDati: TmeIWRadioGroup;
    lblTipoDati: TmeIWLabel;
    cgpColonne: TmeTIWAdvCheckGroup;
    lblColonne: TmeIWLabel;
    chkAggiorna: TmeIWCheckBox;
    chkAnnulla: TmeIWCheckBox;
    btnAnomalie: TmedpIWImageButton;
    btnGeneraPDF: TmedpIWImageButton;
    btnAggiornamento: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    lblMeseCompMax: TmeIWLabel;
    edtMeseCompMax: TmeIWEdit;
    chkCalcolaImportiSaldoAnnoCorr: TmeIWCheckBox;
    btnCambioData: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtADataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnQuoteClick(Sender: TObject);
    procedure cmbTipoCalcoloAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbCampoAnagAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure chkAnnullaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkAggiornaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    RegoleC: Boolean;
    TipoQuota, OldTipoQuota: String;
    IdAnomalia: String;
    SoloAgg: String;
    SenderHTMLName: String;
    chkCalcolaImportiSaldoAnnoCorrCss,chkCalcolaImportiSaldoAnnoCorrCssOrig: String;
    WA167FRegistraIncentiviDM: TWA167FRegistraIncentiviDM;
    procedure GetParametriFunzione;
    procedure CaricaComboTipoCalcolo(Data: TDateTime);
    procedure PutParametriFunzione;
    procedure AbilitazioneComponenti;
    procedure QuoteResult(Sender: TObject; Result: Boolean);
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
    procedure ResultConfermaCancella(Sender: TObject; R: TmeIWModalResult;
      KI: String);
  protected
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

{ TWA167FRegistraIncentivi }

procedure TWA167FRegistraIncentivi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WA167FRegistraIncentiviDM:=TWA167FRegistraIncentiviDM.Create(Self);
  AttivaGestioneC700;
  with WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW do
  begin
    selI010.First;
    while not selI010.Eof do
    begin
      cmbCampoAnag.AddRow(selI010.FieldByName('NOME_CAMPO').AsString + ';' + selI010.FieldByName('NOME_LOGICO').AsString);
      selI010.Next;
    end;
  end;

  GetParametriFunzione;
  TipoQuota:=cmbTipoCalcolo.SelectedValue;
  RegoleC:=WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW.isRegoleC;
  cmbTipoCalcolo.Enabled:=RegoleC;

  if not cmbTipoCalcolo.Enabled then
    cmbTipoCalcolo.ItemIndex:=-1;

  btnAnomalie.Enabled:=False;
  chkCalcolaImportiSaldoAnnoCorrCssOrig:=chkCalcolaImportiSaldoAnnoCorr.Css;
  AbilitazioneComponenti;
end;

procedure TWA167FRegistraIncentivi.WC700AperturaSelezione(Sender: TObject);
var
  tmpData: TDateTime;
begin
  inherited;
  if TryStrToDate('01/' + edtDaData.Text,tmpData) then
  begin
    grdC700.WC700FM.C700DataDal:=tmpData;
  end;

  if TryStrToDate('01/' + edtAData.Text,tmpData) then
  begin
    tmpData:=R180FineMese(tmpData);
    grdC700.WC700FM.C700DataLavoro:=tmpData;
  end;
end;

procedure TWA167FRegistraIncentivi.edtADataAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  try
    WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW.SettaDataQuote(StrToDate('01/' + edtAData.Text));
    CaricaComboTipoCalcolo(StrToDate('01/' + edtAData.Text));
    edtMeseCompMax.Text:=Copy(edtMeseCompMax.Text,1,2) + '/' + Copy(edtAData.Text,4,4);
  except
  end;
end;

procedure TWA167FRegistraIncentivi.GetParametriFunzione;
var
  sData: string;
  I: Integer;
  sTipoCalcolo: string;
  s: string;
begin
  sData:=R180LPad(IntToStr(R180Mese(Parametri.DataLavoro)),2,'0') + '/' + IntToStr(R180Anno(Parametri.DataLavoro));
  edtDaData.Text:=C004DM.GetParametro('DATADA', sData);
  edtAData.Text:=C004DM.GetParametro('DATAA',sData);
  edtMeseCompMax.Text:=C004DM.GetParametro('MESECOMPMAX','12/' + Copy(edtAData.Text,4,4));
  WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW.SettaDataQuote(StrToDate('01/' + edtAData.Text));
  CaricaComboTipoCalcolo(StrToDate('01/' + edtAData.Text));
  sTipoCalcolo:=C004DM.GetParametro('CALCOLO','');
  for i:=0 to cmbTipoCalcolo.Items.Count - 1 do
  begin
    if cmbTipoCalcolo.Items.ValueFromIndex[i] = sTipoCalcolo then
    begin
      cmbTipoCalcolo.ItemIndex:=i;
      Break;
    end;
  end;
  edtQuote.Text:=C004DM.GetParametro('QUOTE','');

  chkSaltoPagina.Checked:=(C004DM.GetParametro('SALTOPAGINA','N') = 'S');
  chkDettaglio.Checked:=(C004DM.GetParametro('DETTAGLIO','N') = 'S');
  cmbCampoAnag.Text:=C004DM.GetParametro('RAGGRUPPAMENTO','');
  rgpTipoDati.ItemIndex:=StrToInt(C004DM.GetParametro('TIPODATI','0'));

  s:=C004DM.GetParametro('COLONNE','');
  for i:=0 to cgpColonne.Items.Count - 1 do
  begin
    if Pos(IntToStr(i) + ',',s) > 0 then
      cgpColonne.IsChecked[i]:=True
  end;
end;

procedure TWA167FRegistraIncentivi.PutParametriFunzione;
var
  s: String;
  i: Integer;
begin
  C004DM.Cancella001;
  C004DM.PutParametro('DATADA',edtDaData.Text);
  C004DM.PutParametro('DATAA',edtAData.Text);
  C004DM.PutParametro('MESECOMPMAX',edtMeseCompMax.Text);
  C004DM.PutParametro('CALCOLO',cmbTipoCalcolo.selectedValue);
  C004DM.PutParametro('QUOTE',edtQuote.Text);
  C004DM.PutParametro('SALTOPAGINA', IfThen(chkSaltoPagina.Checked,'S','N'));
  C004DM.PutParametro('DETTAGLIO', IfThen(chkDettaglio.Checked,'S','N'));
  C004DM.PutParametro('RAGGRUPPAMENTO',cmbCampoAnag.Text);
  C004DM.PutParametro('TIPODATI',IntToStr(rgpTipoDati.ItemIndex));
  s:='';
  for i:=0 to cgpColonne.Items.Count - 1 do
  begin
    if cgpColonne.IsChecked[i] then
      s:=s+IntToStr(i) + ',';
  end;
  C004DM.PutParametro('COLONNE',s);
  try SessioneOracle.Commit; except end;
end;

procedure TWA167FRegistraIncentivi.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IdAnomalia + ParamDelimiter +
          'TIPO=A,B';
  AccediForm(201,Params,False);
end;

procedure TWA167FRegistraIncentivi.btnGeneraPDFClick(Sender: TObject);
var
  DataI,DataF,DataCompMax: TDateTime;
begin
  inherited;

  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  if not tryStrToDate('01/' + edtDaData.Text,DataI) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Dal mese']),mtError,[mbOK],nil,'');
    Exit;
  end;

  if not tryStrToDate('01/' + edtAData.Text,DataF) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Al mese']),mtError,[mbOK],nil,'');
    Exit;
  end;

  if not tryStrToDate('01/' + edtMeseCompMax.Text,DataCompMax) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['del Mese comp. max']),mtError,[mbOK],nil,'');
    Exit;
  end;

  if (DataI > DataF) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    Exit;
  end;

  SoloAgg:=IfThen(Sender = btnAggiornamento,'S','N');
  SenderHTMLName:=(Sender as TmedpIWImageButton).HTMLName;

  if (SenderHTMLName = btnAggiornamento.HTMLName) and
     (chkAnnulla.Checked) then
  begin
    //Conferma per cancellazione schede
    MsgBox.WebMessageDlg(Format(A000MSG_A167_MSG_FMT_CONFERMA_CANC,[edtQuote.Text,edtDaData.Text,edtAData.Text]),mtConfirmation,[mbYes,mbNo],ResultConfermaCancella,'');
    Exit;
  end;

  StartElaborazioneServer(SenderHTMLName);
end;

procedure TWA167FRegistraIncentivi.ResultConfermaCancella(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  NuovoValore, Msg: String;
begin
  if R = mrYes then
    StartElaborazioneServer(SenderHTMLName);
end;

procedure TWA167FRegistraIncentivi.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  DCOMNomeFile:='';
  if (SenderHTMLName = btnGeneraPDF.HTMLName) then
  begin
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
  end;
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA167(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
    IdAnomalia:=DettaglioLog;
  finally
    DCOMConnection.Connected:=False;
  end;
end;

function TWA167FRegistraIncentivi.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaData,json);
    C190Comp2JsonString(edtAData,json);
    C190Comp2JsonString(edtMeseCompMax,json);
    C190Comp2JsonString(cmbTipoCalcolo,json);
    C190Comp2JsonString(edtQuote,json);
    C190Comp2JsonString(cmbCampoAnag,json);
    C190Comp2JsonString(chkSaltoPagina,json);
    C190Comp2JsonString(chkDettaglio,json);
    C190Comp2JsonString(rgpTipoDati,json);
    json.AddPair('cgpColonne',TJSONString.Create(C190GetCheckList(99,cgpColonne)));
    C190Comp2JsonString(chkAggiorna,json);
    C190Comp2JsonString(chkAnnulla,json);
    json.AddPair('SoloAgg',TJSONString.Create(SoloAgg));
    C190Comp2JsonString(chkCalcolaImportiSaldoAnnoCorr,json);

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;


procedure TWA167FRegistraIncentivi.btnQuoteClick(Sender: TObject);
var
  lstQuote:TList<TQuota>;
  lstSel, lstCod, lstDesc: TStringList;
  WC013: TWC013FCheckListFM;
  Quota: TQuota;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self);

  lstQuote:=WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW.getElencoQuote(cmbTipoCalcolo.SelectedValue);
  try
    lstCod:=TStringList.Create;
    lstDesc:=TStringList.Create;
    for Quota in lstQuote do
    begin
      lstCod.Add(Quota.Codice);
      lstDesc.Add(Quota.Descrizione);
    end;
    WC013.CaricaLista(lstDesc, lstCod);
    LstSel:=TStringList.Create;
    LstSel.CommaText:=edtquote.Text;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=QuoteResult;
    WC013.Visualizza(0,0,'<WC013> Quote');
  finally
    FreeAndNil(lstQuote);
    FreeAndNil(lstCod);
    FreeAndNil(lstDesc);
  end;
end;

procedure TWA167FRegistraIncentivi.QuoteResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      edtQuote.Text:=lstTmp.CommaText;
      AbilitazioneComponenti;
    finally
      FreeAndNil(lstTmp);
    end;
  end;
end;

procedure TWA167FRegistraIncentivi.CaricaComboTipoCalcolo(Data: TDateTime);
var
  elencoTipoCalcolo: TList<TTipoCalcolo>;
  TipoCalcolo: TTipoCalcolo;
  i: Integer;
  sel: string;
begin
  sel:=cmbTipoCalcolo.SelectedValue;

  with WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW do
  begin
    elencoTipoCalcolo:=getElencoTipoCalcolo(Data);
  end;
  try
    cmbTipoCalcolo.Clear;
    for TipoCalcolo in elencoTipoCalcolo do
    begin
      cmbTipoCalcolo.Items.Add(TipoCalcolo.Descrizione + '=' + TipoCalcolo.Codice);
    end;
  finally
    FreeAndNil(elencoTipoCalcolo);
  end;

  for i:=0 to cmbTipoCalcolo.Items.Count - 1 do
  begin
    if cmbTipoCalcolo.Items.ValueFromIndex[i] = sel then
    begin
      cmbTipoCalcolo.ItemIndex:=i;
      Break;
    end;
  end;
end;

procedure TWA167FRegistraIncentivi.chkAggiornaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitazioneComponenti;
  if chkCalcolaImportiSaldoAnnoCorrCss <> chkCalcolaImportiSaldoAnnoCorr.Css then //senza submit il campo non renderizza il cambio di css
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA167FRegistraIncentivi.chkAnnullaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  AbilitazioneComponenti;
end;

procedure TWA167FRegistraIncentivi.cmbCampoAnagAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  AbilitazioneComponenti;
end;

procedure TWA167FRegistraIncentivi.AbilitazioneComponenti;
var lstQuote:TStringList;
    VisMeseCompMax,VisCalcolaImporti:Boolean;
    i:Integer;
begin
  chkSaltoPagina.Enabled:=Trim(cmbCampoAnag.Text) <> '';
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;

  edtQuote.Enabled:=RegoleC and (TipoQuota <> 'R');
  lblQuote.Enabled:=edtQuote.Visible;
  btnQuote.Enabled:=btnQuote.Visible;

  if TipoQuota = 'C' then
    rgpTipoDati.ItemIndex:=0;
  if TipoQuota = 'Q' then
  begin
    for i:=0 to cgpColonne.Items.Count - 1 do
      cgpColonne.IsChecked[i]:=False;
    cgpColonne.IsChecked[6]:=True;
    rgpTipoDati.ItemIndex:=0;
  end
  else
    cgpColonne.isChecked[6]:=False;

  cgpColonne.Enabled:=TipoQuota <> 'Q';
  rgpTipoDati.Enabled:=(TipoQuota <> 'Q') and (TipoQuota <> 'C');

  //visualizzo il campo Mese comp. max o il campo Calcola anche gli importi... se la quota lo prevede
  VisMeseCompMax:=False;
  VisCalcolaImporti:=False;
  lstQuote:=TStringList.Create;
  lstQuote.Clear;
  if edtQuote.Visible then
    lstQuote.CommaText:=edtQuote.Text
  else
    lstQuote.Add('A#D');
  if WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW.selT765.Active then
    for i:=0 to lstQuote.Count - 1 do
    begin
      if VarToStr(WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW.selT765.Lookup('CODICE',lstQuote.Strings[i],'IMPOSTA_MESE_COMP_MAX')) = 'S' then
        VisMeseCompMax:=True;
      if VarToStr(WA167FRegistraIncentiviDM.A167FRegistraIncentiviMW.selT765.Lookup('CODICE',lstQuote.Strings[i],'RIF_SALDO_ANNO_CORR')) = 'S' then
        VisCalcolaImporti:=True;
    end;
  FreeAndNil(lstQuote);
  VisMeseCompMax:=VisMeseCompMax and (TipoQuota = 'N') and not chkAnnulla.Checked;
  edtMeseCompMax.Visible:=VisMeseCompMax;
  lblMeseCompMax.Visible:=VisMeseCompMax;
  chkCalcolaImportiSaldoAnnoCorrCss:=chkCalcolaImportiSaldoAnnoCorr.Css;
  chkCalcolaImportiSaldoAnnoCorr.Css:=IfThen(VisCalcolaImporti,chkCalcolaImportiSaldoAnnoCorrCssOrig,'invisibile');
  if chkCalcolaImportiSaldoAnnoCorr.Css = 'invisibile' then
    chkCalcolaImportiSaldoAnnoCorr.Checked:=False;

  btnAggiornamento.Enabled:=chkAggiorna.Checked or chkAnnulla.Checked;
  chkAnnulla.Enabled:=not chkAggiorna.Checked;
  if not chkAnnulla.Enabled then
    chkAnnulla.Checked:=False;

  btnGeneraPDF.Enabled:=not chkAnnulla.Checked;
  if chkAnnulla.Checked then
    btnAggiornamento.Caption:='Cancellazione'
  else
    btnAggiornamento.Caption:='Solo aggiornamento';
  chkAggiorna.Enabled:=not chkAnnulla.Checked;
  if not chkAggiorna.Enabled then
    chkAggiorna.Checked:=False;
end;

procedure TWA167FRegistraIncentivi.cmbTipoCalcoloAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  OldTipoQuota:=TipoQuota;
  TipoQuota:=cmbTipoCalcolo.SelectedValue;
  if OldTipoQuota <> TipoQuota then
    edtQuote.Text:='';
  AbilitazioneComponenti;
  if chkCalcolaImportiSaldoAnnoCorrCss <> chkCalcolaImportiSaldoAnnoCorr.Css then //senza submit il campo non renderizza il cambio di css
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA167FRegistraIncentivi.InizializzaMsgElaborazione;
begin
  if (SenderHTMLName = btnAggiornamento.HTMLName) then
  begin
    with WC022FMsgElaborazioneFM do
    begin
      Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
      Titolo:=A000MSG_MSG_ELABORAZIONE;
      ImgFileName:=IMG_FILENAME_ELABORAZIONE;
    end;
  end;
end;

procedure TWA167FRegistraIncentivi.ElaborazioneServer;
begin
  inherited;
  CallDCOMPrinter;
  btnAnomalie.Enabled:=IdAnomalia <> '';
  if btnAnomalie.Enabled then
    DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
end;

procedure TWA167FRegistraIncentivi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WA167FRegistraIncentiviDM);
  inherited;
end;

end.
