unit WS715UStampaValutazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompCheckbox, meIWCheckBox, C180FunzioniGenerali,
  A000UMessaggi, meIWImageFile, medpIWImageButton, WS715UStampaValutazioniDM, StrUtils, A000UInterfaccia,
  WC013UCheckListFM, A000UCostanti, WC700USelezioneAnagrafeFM, medpIWMessageDlg, C190FunzioniGeneraliWeb,
  Data.DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} ActiveX, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, IWApplication;

type
  TWS715FStampaValutazioni = class(TWR100FBase)
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    rgpTipoValutazione: TmeTIWAdvRadioGroup;
    rgpTipoChiusura: TmeTIWAdvRadioGroup;
    rgpStatoAvanzamento: TmeTIWAdvRadioGroup;
    edtDataDa: TmeIWEdit;
    lblDataDa: TmeIWLabel;
    edtStatoAvanzamento: TmeIWEdit;
    btnStatoAvanzamento: TmeIWButton;
    lblTipoValutazione: TmeIWLabel;
    lblTipoChiusura: TmeIWLabel;
    lblStatoAvanzamento: TmeIWLabel;
    rgpDipValutabile: TmeTIWAdvRadioGroup;
    lblDipValutabile: TmeIWLabel;
    rgpPresaVisione: TmeTIWAdvRadioGroup;
    lblPresaVisione: TmeIWLabel;
    rgpSchedeProtocollo: TmeTIWAdvRadioGroup;
    lblSchedeProtocollo: TmeIWLabel;
    chkControllaRegola: TmeIWCheckBox;
    chkAggiornaPunteggi: TmeIWCheckBox;
    chkAvanzaStato: TmeIWCheckBox;
    chkChiudiScheda: TmeIWCheckBox;
    chkRiapriScheda: TmeIWCheckBox;
    chkRetrocediStato: TmeIWCheckBox;
    chkAggiornaIncentivi: TmeIWCheckBox;
    chkStampa: TmeIWCheckBox;
    chkFilePDF: TmeIWCheckBox;
    chkProtocolla: TmeIWCheckBox;
    chkSostituisciRegola: TmeIWCheckBox;
    chkAssegnaValutatore: TmeIWCheckBox;
    btnTipologieQuote: TmeIWButton;
    chkLegendaPunteggi: TmeIWCheckBox;
    chkPresaVisione: TmeIWCheckBox;
    btnAnomalie: TmedpIWImageButton;
    btnEsegui: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    btnCambioData: TmeIWButton;
    procedure rgpAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnStatoAvanzamentoClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnTipologieQuoteClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure rgpStatoAvanzamentoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnCambioDataClick(Sender: TObject);
  private
    DataI, DataF: TDateTime;
    ListaTipologieQuote: String;
    IdAnomalia: String;
    WS715FStampaValutazioniDM: TWS715FStampaValutazioniDM;
    procedure AbilitaComponenti;
    procedure AggiornaStatoAvanzamento;
    procedure RecuperaDate;
    procedure StatiAvanzamentoResult(Sender: TObject; Result: Boolean);
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ListaTipologieResult(Sender: TObject; Result: Boolean);
    procedure ResultConfermaElaborazione(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ImpostazioniWC700; override;
    procedure ElaborazioneServer; override;
    procedure InizializzaMsgElaborazione; override;
  end;

implementation

{$R *.dfm}

procedure TWS715FStampaValutazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WS715FStampaValutazioniDM:=TWS715FStampaValutazioniDM.Create(Self);

  chkAssegnaValutatore.Visible:=WS715FStampaValutazioniDM.S715FStampaValutazioniMW.CanAssegnaValutatore;
  chkSostituisciRegola.Visible:=chkAssegnaValutatore.Visible;
  chkProtocolla.Visible:=WS715FStampaValutazioniDM.S715FStampaValutazioniMW.CanProtocolla;

  GetParametriFunzione;

  //Abilitazioni controlli
  AbilitaComponenti;
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  RecuperaDate;
  AggiornaStatoAvanzamento;

  AttivaGestioneC700;
  ListaTipologieQuote:='';
end;

procedure TWS715FStampaValutazioni.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700SelezionePeriodica:=True;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + WS715FStampaValutazioniDM.S715FStampaValutazioniMW.CampiAggiuntiviC700(C700CampiBase);
  WC700AperturaSelezione(nil);
end;

procedure TWS715FStampaValutazioni.GetParametriFunzione;
{Leggo i parametri della form}
begin
  rgpTipoValutazione.ItemIndex:=StrToIntDef(C004DM.GetParametro('rgpTipoValutazione',''),2);
  rgpTipoChiusura.ItemIndex:=StrToIntDef(C004DM.GetParametro('rgpTipoChiusura',''),3);
  rgpStatoAvanzamento.ItemIndex:=StrToIntDef(C004DM.GetParametro('rgpStatoAvanzamento',''),0);
  edtStatoAvanzamento.Text:=C004DM.GetParametro('edtStatoAvanzamento','');
  rgpPresaVisione.ItemIndex:=StrToIntDef(C004DM.GetParametro('rgpPresaVisione',''),3);
  rgpSchedeProtocollo.ItemIndex:=StrToIntDef(C004DM.GetParametro('rgpSchedeProtocollo',''),2);
  rgpDipValutabile.ItemIndex:=StrToIntDef(C004DM.GetParametro('rgpDipValutabile',''),2);
  chkAssegnaValutatore.Checked:=(C004DM.GetParametro('chkAssegnaValutatore','') = 'S');
  chkControllaRegola.Checked:=(C004DM.GetParametro('chkControllaRegola','') = 'S');
  chkSostituisciRegola.Checked:=(C004DM.GetParametro('chkSostituisciRegola','') = 'S');
  chkAggiornaPunteggi.Checked:=(C004DM.GetParametro('chkAggiornaPunteggi','') = 'S');
  chkAvanzaStato.Checked:=(C004DM.GetParametro('chkAvanzaStato','') = 'S');
  chkChiudiScheda.Checked:=(C004DM.GetParametro('chkChiudiScheda','') = 'S');
  chkRiapriScheda.Checked:=(C004DM.GetParametro('chkRiapriScheda','') = 'S');
  chkRetrocediStato.Checked:=(C004DM.GetParametro('chkRetrocediStato','') = 'S');
  chkAggiornaIncentivi.Checked:=(C004DM.GetParametro('chkAggiornaIncentivi','') = 'S');
  chkStampa.Checked:=(C004DM.GetParametro('chkStampa','') = 'S');
  chkFilePDF.Checked:=(C004DM.GetParametro('chkFilePDF','') = 'S');
  chkProtocolla.Checked:=(C004DM.GetParametro('chkProtocolla','') = 'S');
  chkLegendaPunteggi.Checked:=(C004DM.GetParametro('chkLegendaPunteggi','') = 'S');
  chkPresaVisione.Checked:=(C004DM.GetParametro('chkPresaVisione','') = 'S');
end;

procedure TWS715FStampaValutazioni.AggiornaStatoAvanzamento;
var listSG746: TElencoValoriChecklist;
    StatiSel: String;
begin
  if (DataI > DataF) or (rgpStatoAvanzamento.ItemIndex = 0) then
    exit;
  try
    StatiSel:=edtStatoAvanzamento.Text;
    listSG746:=WS715FStampaValutazioniDM.S715FStampaValutazioniMW.ListSG746(DataI,DataF,StatiSel);
    edtStatoAvanzamento.Text:=StatiSel;
  finally
    FreeAndNil(listSG746);
  end;
end;

procedure TWS715FStampaValutazioni.AbilitaComponenti;
begin
  edtStatoAvanzamento.Enabled:=rgpStatoAvanzamento.ItemIndex = 1;
  btnStatoAvanzamento.Enabled:=edtStatoAvanzamento.Enabled;
  chkControllaRegola.Enabled:=not chkAggiornaPunteggi.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and not chkAggiornaIncentivi.Checked and not chkProtocolla.Checked and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkControllaRegola.Enabled then
    chkControllaRegola.Checked:=False;
  chkSostituisciRegola.Enabled:=not SolaLettura and chkControllaRegola.Enabled and chkControllaRegola.Checked and chkSostituisciRegola.Visible;
  if not chkSostituisciRegola.Enabled then
    chkSostituisciRegola.Checked:=False;
  chkAggiornaPunteggi.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkProtocolla.Checked and (chkAssegnaValutatore.Visible or not R180In(rgpTipoChiusura.ItemIndex,[1,2])) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkAggiornaPunteggi.Enabled then
    chkAggiornaPunteggi.Checked:=False;
  chkAssegnaValutatore.Enabled:=not SolaLettura and chkAggiornaPunteggi.Enabled and chkAggiornaPunteggi.Checked and chkAssegnaValutatore.Visible;
  if not chkAssegnaValutatore.Enabled then
    chkAssegnaValutatore.Checked:=False;
  chkAvanzaStato.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and (not chkAggiornaIncentivi.Checked or chkChiudiScheda.Checked) and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[1,2]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkAvanzaStato.Enabled then
    chkAvanzaStato.Checked:=False;
  chkChiudiScheda.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[1,2]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkChiudiScheda.Enabled then
    chkChiudiScheda.Checked:=False;
  chkRiapriScheda.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkAggiornaIncentivi.Checked and not chkFilePDF.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkRiapriScheda.Enabled then
    chkRiapriScheda.Checked:=False;
  chkRetrocediStato.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkAggiornaIncentivi.Checked and not chkFilePDF.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[1,2]) and (rgpDipValutabile.ItemIndex <> 1) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkRetrocediStato.Enabled then
    chkRetrocediStato.Checked:=False;
  chkAggiornaIncentivi.Enabled:=not SolaLettura and not chkControllaRegola.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and (rgpTipoValutazione.ItemIndex <> 1) and (not chkAvanzaStato.Checked or chkChiudiScheda.Checked) and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]) and (rgpDipValutabile.ItemIndex <> 1);
  if not chkAggiornaIncentivi.Enabled then
    chkAggiornaIncentivi.Checked:=False;
  btnTipologieQuote.Enabled:=chkAggiornaIncentivi.Checked;
  chkStampa.Enabled:=not chkFilePDF.Checked and not chkProtocolla.Checked;
  if not chkStampa.Enabled then
    chkStampa.Checked:=False;
  chkFilePDF.Enabled:=not chkRetrocediStato.Checked and not chkRiapriScheda.Checked and not chkStampa.Checked and not chkProtocolla.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]);
  if not chkFilePDF.Enabled then
    chkFilePDF.Checked:=False;
  chkLegendaPunteggi.Enabled:=chkStampa.Checked or chkFilePDF.Checked;
  chkPresaVisione.Enabled:=chkStampa.Checked or chkFilePDF.Checked;
  chkProtocolla.Enabled:=chkProtocolla.Visible and not SolaLettura and not chkControllaRegola.Checked and not chkAggiornaPunteggi.Checked and not chkAvanzaStato.Checked and not chkChiudiScheda.Checked and not chkRiapriScheda.Checked and not chkRetrocediStato.Checked and not chkAggiornaIncentivi.Checked and not chkStampa.Checked and not chkFilePDF.Checked and not R180In(rgpTipoChiusura.ItemIndex,[0,1]) and (rgpSchedeProtocollo.ItemIndex <> 0);
  if not chkProtocolla.Enabled then
    chkProtocolla.Checked:=False;
  btnEsegui.Enabled:=chkControllaRegola.Checked or chkSostituisciRegola.Checked or chkAggiornaPunteggi.Checked or chkAssegnaValutatore.Checked or chkAvanzaStato.Checked or chkRetrocediStato.Checked or chkChiudiScheda.Checked or chkRiapriScheda.Checked or chkAggiornaIncentivi.Checked or chkStampa.Checked or chkFilePDF.Checked or chkProtocolla.Checked;
end;

procedure TWS715FStampaValutazioni.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IdAnomalia + ParamDelimiter +
          'TIPO=A,B';
  AccediForm(201,Params,False);
end;

procedure TWS715FStampaValutazioni.RecuperaDate;
begin
  if edtDataDa.Text = '' then
    raise exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_INIZIO]));
  if not TryStrToDate(edtDataDa.Text,DataI) then
    raise exception.Create(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_MSG_DATA_INIZIO]));
  if edtDataA.Text = '' then
    raise exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,[A000MSG_MSG_DATA_FINE]));
  if not TryStrToDate(edtDataA.Text,DataF) then
    raise exception.Create(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[A000MSG_MSG_DATA_FINE]));
end;

procedure TWS715FStampaValutazioni.btnEseguiClick(Sender: TObject);
var
  Msg: String;
begin
  inherited;

  if DataI > DataF then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    Exit;
  end;

  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataI,DataF) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;
  grdC700.selAnagrafe.First;

  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Abort;
  end;

  if chkAggiornaIncentivi.Checked and (ListaTipologieQuote = '') then
  begin
    MsgBox.WebMessageDlg(A000MSG_S715_ERR_NO_TIPO_QUOTA,mtError,[mbOk],nil,'');
    Abort;
  end;

  if (rgpStatoAvanzamento.ItemIndex = 1) and (edtStatoAvanzamento.Text = '') then
  begin
    MsgBox.WebMessageDlg(A000MSG_S715_ERR_NO_STATO_AVANZAMENTO,mtError,[mbOk],nil,'');
    Abort;
  end;

  if ( chkControllaRegola.Checked
       or chkSostituisciRegola.Checked
       or chkAggiornaPunteggi.Checked
       or chkAssegnaValutatore.Checked
       or chkAvanzaStato.Checked
       or chkChiudiScheda.Checked
       or chkRiapriScheda.Checked
       or chkRetrocediStato.Checked
       or chkAggiornaIncentivi.Checked
       or chkFilePDF.Checked
       or chkProtocolla.Checked) then
  begin
    Msg:=Format(A000MSG_S715_DLG_FMT_CONFERMA_ESEGUI,[IfThen(chkControllaRegola.Checked,CRLF + ' - ' + chkControllaRegola.Caption) +
                                                      IfThen(chkSostituisciRegola.Checked,CRLF + ' - ' + chkSostituisciRegola.Caption) +
                                                      IfThen(chkAggiornaPunteggi.Checked,CRLF + ' - ' + chkAggiornaPunteggi.Caption) +
                                                      IfThen(chkAssegnaValutatore.Checked,CRLF + ' - ' + chkAssegnaValutatore.Caption) +
                                                      IfThen(chkAvanzaStato.Checked,CRLF + ' - ' + chkAvanzaStato.Caption) +
                                                      IfThen(chkChiudiScheda.Checked,CRLF + ' - ' + chkChiudiScheda.Caption) +
                                                      IfThen(chkRiapriScheda.Checked,CRLF + ' - ' + chkRiapriScheda.Caption) +
                                                      IfThen(chkRetrocediStato.Checked,CRLF + ' - ' + chkRetrocediStato.Caption) +
                                                      IfThen(chkAggiornaIncentivi.Checked,CRLF + ' - ' + chkAggiornaIncentivi.Caption) +
                                                      IfThen(chkStampa.Checked,CRLF + ' - ' + chkStampa.Caption) +
                                                      IfThen(chkFilePDF.Checked,CRLF + ' - ' + chkFilePDF.Caption) +
                                                      IfThen(chkProtocolla.Checked,CRLF + ' - ' + chkProtocolla.Caption)]);

    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultConfermaElaborazione,'');
    Abort;
  end;

  PutParametriFunzione;
  StartElaborazioneServer(btnEsegui.HTMLName);
end;

procedure TWS715FStampaValutazioni.ResultConfermaElaborazione(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    PutParametriFunzione;
    StartElaborazioneServer(btnEsegui.HTMLName);
  end;
end;

procedure TWS715FStampaValutazioni.btnStatoAvanzamentoClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  listSG746: TElencoValoriChecklist;
  LstSel: TStringList;
  StatiSel: String;
begin
  inherited;
  if DataI > DataF then
    raise Exception.Create(A000MSG_ERR_PERIODO_ERRATO);
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  StatiSel:=edtStatoAvanzamento.Text;
  listSG746:=WS715FStampaValutazioniDM.S715FStampaValutazioniMW.ListSG746(DataI,DataF,StatiSel);
  WC013.CaricaLista(listSG746.lstDescrizione, listSG746.lstCodice);
  FreeAndNil(listSG746);
  LstSel:=TStringList.Create;
  LstSel.CommaText:=edtStatoAvanzamento.Text;
  WC013.ImpostaValoriSelezionati(LstSel);
  FreeAndNil(LstSel);
  WC013.ResultEvent:=StatiAvanzamentoResult;
  WC013.Visualizza(0,0,'<WC013> Elenco stati avanzamento');
end;

procedure TWS715FStampaValutazioni.btnTipologieQuoteClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  elencoTipologieQuote: TElencoValoriChecklist;
  LstSel: TStringList;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  elencoTipologieQuote:=WS715FStampaValutazioniDM.S715FStampaValutazioniMW.ListTipologieQuote;
  WC013.CaricaLista(elencoTipologieQuote.lstDescrizione, elencoTipologieQuote.lstCodice);
  FreeAndNil(elencoTipologieQuote);
  LstSel:=TStringList.Create;
  LstSel.CommaText:=ListaTipologieQuote;
  WC013.ImpostaValoriSelezionati(LstSel);
  FreeAndNil(LstSel);

  WC013.ResultEvent:=ListaTipologieResult;
  WC013.Visualizza(0,0,'<WC013> Elenco TipologieQuote');
end;

procedure TWS715FStampaValutazioni.ListaTipologieResult(Sender: TObject; Result: Boolean);
var lst: TStringList;
begin
  if Result then
  begin
    lst:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      ListaTipologieQuote:=lst.CommaText;
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWS715FStampaValutazioni.StatiAvanzamentoResult(Sender: TObject; Result: Boolean);
var lst: TStringList;
begin
  if Result then
  begin
    lst:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      edtStatoAvanzamento.Text:=lst.CommaText;
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWS715FStampaValutazioni.chkAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWS715FStampaValutazioni.rgpAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWS715FStampaValutazioni.rgpStatoAvanzamentoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AggiornaStatoAvanzamento;
  AbilitaComponenti;
end;

procedure TWS715FStampaValutazioni.WC700AperturaSelezione(Sender: TObject);
var
  dTmp: TDateTime;
begin
  if not TryStrToDate(edtDataDa.Text,dTmp) then
    dTmp:=Parametri.DataLavoro;
  grdC700.WC700FM.C700DataDal:=dTmp;

  if not TryStrToDate(edtDataA.Text,dTmp) then
    dTmp:=Parametri.DataLavoro;
  grdC700.WC700FM.C700DataLavoro:=dTmp;
end;

procedure TWS715FStampaValutazioni.PutParametriFunzione;
begin
  C004DM.Cancella001;
  C004DM.PutParametro('rgpTipoValutazione',IntToStr(rgpTipoValutazione.ItemIndex));
  C004DM.PutParametro('rgpTipoChiusura',IntToStr(rgpTipoChiusura.ItemIndex));
  C004DM.PutParametro('rgpStatoAvanzamento',IntToStr(rgpStatoAvanzamento.ItemIndex));
  C004DM.PutParametro('edtStatoAvanzamento',edtStatoAvanzamento.Text);
  C004DM.PutParametro('rgpPresaVisione',IntToStr(rgpPresaVisione.ItemIndex));
  C004DM.PutParametro('rgpSchedeProtocollo',IntToStr(rgpSchedeProtocollo.ItemIndex));
  C004DM.PutParametro('rgpDipValutabile',IntToStr(rgpDipValutabile.ItemIndex));
  C004DM.PutParametro('chkAssegnaValutatore',IfThen(chkAssegnaValutatore.Checked,'S','N'));
  C004DM.PutParametro('chkControllaRegola',IfThen(chkControllaRegola.Checked,'S','N'));
  C004DM.PutParametro('chkSostituisciRegola',IfThen(chkSostituisciRegola.Checked,'S','N'));
  C004DM.PutParametro('chkAggiornaPunteggi',IfThen(chkAggiornaPunteggi.Checked,'S','N'));
  C004DM.PutParametro('chkAvanzaStato',IfThen(chkAvanzaStato.Checked,'S','N'));
  C004DM.PutParametro('chkChiudiScheda',IfThen(chkChiudiScheda.Checked,'S','N'));
  C004DM.PutParametro('chkRiapriScheda',IfThen(chkRiapriScheda.Checked,'S','N'));
  C004DM.PutParametro('chkRetrocediStato',IfThen(chkRetrocediStato.Checked,'S','N'));
  C004DM.PutParametro('chkAggiornaIncentivi',IfThen(chkAggiornaIncentivi.Checked,'S','N'));
  C004DM.PutParametro('chkStampa',IfThen(chkStampa.Checked,'S','N'));
  C004DM.PutParametro('chkFilePDF',IfThen(chkFilePDF.Checked,'S','N'));
  C004DM.PutParametro('chkProtocolla',IfThen(chkProtocolla.Checked,'S','N'));
  C004DM.PutParametro('chkLegendaPunteggi',IfThen(chkLegendaPunteggi.Checked,'S','N'));
  C004DM.PutParametro('chkPresaVisione',IfThen(chkPresaVisione.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

procedure TWS715FStampaValutazioni.InizializzaMsgElaborazione;
begin
  with WC022FMsgElaborazioneFM do
  begin
    if chkStampa.Checked then
    begin
      Messaggio:=A000MSG_MSG_ELABORAZIONE_PDF_IN_CORSO;
      Titolo:=A000MSG_MSG_ELABORAZIONE;
      ImgFileName:=IMG_FILENAME_PDF;
    end
    else
    begin
      Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
      Titolo:=A000MSG_MSG_ELABORAZIONE;
      ImgFileName:=IMG_FILENAME_ELABORAZIONE;
    end;
  end;
end;

procedure TWS715FStampaValutazioni.ElaborazioneServer;
begin
  inherited;

  CallDCOMPrinter;
  btnAnomalie.Enabled:=IdAnomalia <> '';
  //DCOMMsg può essere vuoto o con messaggio di protocollazione
  if DCOMMsg = '' then
  begin
    if btnAnomalie.Enabled then
      DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
  end
  else
  begin
    if btnAnomalie.Enabled then
      DCOMMsg:=DCOMMsg + #13#10 + A000MSG_MSG_ELABORAZIONE_ANOMALIE
    else
      DCOMMsg:=DCOMMsg + #13#10 + A000MSG_MSG_ELABORAZIONE_TERMINATA;
  end;
end;

procedure TWS715FStampaValutazioni.CallDCOMPrinter;
var DettaglioLog,
    MessaggioAggiuntivo:OleVariant;
    DatiUtente: String;
begin
  DCOMNomeFile:='';
  if (chkStampa.Checked) then
  begin
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
  end
  else
    DCOMNomeFile:='';

  DatiUtente:=CreateJSonString;

  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);

  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintS715(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog,
                                       MessaggioAggiuntivo);
  finally
    IdAnomalia:=DettaglioLog;
    DCOMMsg:= MessaggioAggiuntivo;

    DCOMConnection.Connected:=False;
  end;
end;

function TWS715FStampaValutazioni.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    C190Comp2JsonString(edtDataDa,json);
    C190Comp2JsonString(edtDataA,json);
    C190Comp2JsonString(rgpTipoValutazione,json);
    C190Comp2JsonString(rgpTipoChiusura,json);
    C190Comp2JsonString(rgpStatoAvanzamento,json);
    C190Comp2JsonString(edtStatoAvanzamento,json);
    C190Comp2JsonString(rgpDipValutabile,json);
    C190Comp2JsonString(rgpPresaVisione,json);
    C190Comp2JsonString(rgpSchedeProtocollo,json);
    C190Comp2JsonString(chkControllaRegola,json);
    C190Comp2JsonString(chkAggiornaPunteggi,json);
    C190Comp2JsonString(chkAvanzaStato,json);
    C190Comp2JsonString(chkChiudiScheda,json);
    C190Comp2JsonString(chkRiapriScheda,json);
    C190Comp2JsonString(chkRetrocediStato,json);
    C190Comp2JsonString(chkAggiornaIncentivi,json);
    C190Comp2JsonString(chkStampa,json);
    C190Comp2JsonString(chkFilePDF,json);
    C190Comp2JsonString(chkProtocolla,json);
    C190Comp2JsonString(chkSostituisciRegola,json);
    C190Comp2JsonString(chkAssegnaValutatore,json);
    C190Comp2JsonString(chkLegendaPunteggi,json);
    C190Comp2JsonString(chkPresaVisione,json);
    json.AddPair('ListaTipologieQuote',ListaTipologieQuote);

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWS715FStampaValutazioni.edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  RecuperaDate;
  //if TryStrToDate(edtDataDa.Text,DataI) and TryStrToDate(edtDataA.Text,DataF) then
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWS715FStampaValutazioni.btnCambioDataClick(Sender: TObject);
begin
  inherited;
  AggiornaStatoAvanzamento;
end;

procedure TWS715FStampaValutazioni.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WS715FStampaValutazioniDM);
  inherited;
end;

end.
