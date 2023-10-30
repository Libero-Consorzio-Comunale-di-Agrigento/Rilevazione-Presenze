unit WA170UGestioneGruppi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, medpIWTabControl, IWCompCheckbox,
  meIWCheckBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  medpIWMultiColumnComboBox, WC013UCheckListFM, WA170UGestioneGruppiDM,
  A000UCostanti, C190FunzioniGeneraliWeb, C180FunzioniGenerali,
  IWCompJQueryWidget, IWApplication, meIWImageFile, medpIWImageButton,
  A000UInterfaccia,A000USessione,medpIWMessageDlg,A000UMessaggi,WC020UInputDataOreFM,
  Generics.Collections, A170UGestioneGruppiMW;

type
  TWA170FGestioneGruppi = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA170PesatureRG: TmeIWRegion;
    TemplatePesatureRG: TIWTemplateProcessorHTML;
    WA170SchedeRG: TmeIWRegion;
    TemplateSchedeRG: TIWTemplateProcessorHTML;
    chkChiusuraPesature: TmeIWCheckBox;
    chkAperturaPesature: TmeIWCheckBox;
    chkAggiornaPesature: TmeIWCheckBox;
    lblAnnoPesature: TmeIWLabel;
    edtAnnoPesature: TmeIWEdit;
    lblQuotaPesature: TmeIWLabel;
    lblGruppiPesature: TmeIWLabel;
    cmbQuotaPesature: TMedpIWMultiColumnComboBox;
    lblDescQuotaPesature: TmeIWLabel;
    edtGruppiPesature: TmeIWEdit;
    btnGruppiPesature: TmeIWButton;
    chkChiusuraSchede: TmeIWCheckBox;
    chkAperturaSchede: TmeIWCheckBox;
    chkAggiornaSchede: TmeIWCheckBox;
    lblAnnoSchede: TmeIWLabel;
    edtAnnoSchede: TmeIWEdit;
    lblQuotaSchede: TmeIWLabel;
    cmbQuotaSchede: TMedpIWMultiColumnComboBox;
    lblDescQuotaSchede: TmeIWLabel;
    lblGruppiSchede: TmeIWLabel;
    edtGruppiSchede: TmeIWEdit;
    btnGruppiSchede: TmeIWButton;
    chkPassaggioAnnoSchede: TmeIWCheckBox;
    lblDataRifSchede: TmeIWLabel;
    edtDataRifSchede: TmeIWEdit;
    grdPagamenti: TmeIWGrid;
    lblPagamenti: TmeIWLabel;
    JQuery: TIWJQueryWidget;
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnGruppiPesatureClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtAnnoPesatureAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbQuotaPesatureAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure chkChiusuraPesatureAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkAperturaPesatureAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkAggiornaPesatureAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkChiusuraSchedeAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkAperturaSchedeAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkAggiornaSchedeAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkPassaggioAnnoSchedeAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure cmbQuotaSchedeAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnGruppiSchedeClick(Sender: TObject);
    procedure edtAnnoSchedeAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    lstGruppi: TStringList;
    idxGruppo: Integer;
    DataRif: TDateTime;
    NumGruppi: Integer;
    procedure GruppiPesatureResult(Sender: TObject; Result: Boolean);
    procedure RicaricaCombQuotePesature(Anno: Integer);
    procedure AbilitaComponentiPesature;
    procedure CaricaGrdPagamenti;
    procedure AbilitaComponentiSchede;
    procedure CaricaComboQuoteSchede;
    procedure GruppiSchedeResult(Sender: TObject; Result: Boolean);
    procedure PutParametriFunzione;
    procedure GetParametriFunzione;
    procedure ResultConfermaStart(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure ResultConfermaPassaggioAnno(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure ResultConfermaNoMesePagamento(Sender: TObject;
      R: TmeIWModalResult; KI: String);
    procedure VerificaGruppiPassaggioAnno;
    procedure ResultConfermaGruppiAperti(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure ResultNumeroGruppi(Sender: TObject; Result: Boolean;
      Valore: String);
  protected
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore: Boolean); override;

  public
    WA170FGestioneGruppiDM: TWA170FGestioneGruppiDM;
    function InizializzaAccesso:Boolean; override;
  end;
implementation

{$R *.dfm}

{ TWA170FGestioneGruppi }

procedure TWA170FGestioneGruppi.IWAppFormCreate(Sender: TObject);
begin
  grdTabDetail.AggiungiTab('Pesature individuali',WA170PesatureRG);
  grdTabDetail.AggiungiTab('Schede quantitative individuali',WA170SchedeRG);
  inherited;
  WA170FGestioneGruppiDM:=TWA170FGestioneGruppiDM.Create(Self);
  CaricaGrdPagamenti;
  getParametriFunzione;
  btnAnomalie.Enabled:=False;
end;

function TWA170FGestioneGruppi.InizializzaAccesso: Boolean;
begin
  grdTabDetail.Tabs[WA170PesatureRG].Visible:=A000GetInibizioni('Tag','173') <> 'N';
  grdTabDetail.Tabs[WA170SchedeRG].Visible:=A000GetInibizioni('Tag','206') <> 'N';

  if (not grdTabDetail.Tabs[WA170PesatureRG].Visible) and
     (not grdTabDetail.Tabs[WA170SchedeRG].Visible) then
  begin
     MsgBox.WebMessageDlg(A000MSG_A170_ERR_ABIL_PES_SCHEDE,mtInformation,[mbOK],nil,'');
     Result:=False;
     Exit;
  end;

  if grdTabDetail.Tabs[WA170PesatureRG].Visible then
    grdTabDetail.ActiveTab:=WA170PesatureRG
  else
    grdTabDetail.ActiveTab:=WA170SchedeRG;

  AbilitaComponentiPesature;
  AbilitaComponentiSchede;

  Result:=True;
end;

procedure TWA170FGestioneGruppi.RicaricaCombQuotePesature(Anno:Integer);
begin
  with WA170FGestioneGruppiDM.A170FGestioneGruppiMW do
  begin
    selT773Quote.Close;
    selT773Quote.SetVariable('ANNO',Anno);
    selT773Quote.Open;
    selT773Quote.First;
    cmbQuotaPesature.Items.Clear;
    while not selT773Quote.Eof do
    begin
      cmbQuotaPesature.AddRow(Format('%s;%s',[selT773Quote.FieldByName('CODTIPOQUOTA').AsString,selT773Quote.FieldByName('DESCRIZIONE').AsString]));
      selT773Quote.Next;
    end;
    selT773Quote.Close;
  end;
  //per reimpostare itemindex se elemento non più presente ed eseguire evento change
  cmbQuotaPesature.RefreshData;
end;

procedure TWA170FGestioneGruppi.CaricaComboQuoteSchede;
begin
  with WA170FGestioneGruppiDM.A170FGestioneGruppiMW do
  begin
    selT767Quote.First;
    cmbQuotaSchede.Items.Clear;
    while not selT767Quote.Eof do
    begin
      cmbQuotaSchede.AddRow(Format('%s;%s',[selT767Quote.FieldByName('CODTIPOQUOTA').AsString,selT767Quote.FieldByName('DESCRIZIONE').AsString]));
      selT767Quote.Next;
    end;
    selT767Quote.Close;
  end;
  //per reimpostare itemindex se elemento non più presente ed eseguire evento change
  cmbQuotaSchede.RefreshData;
end;

procedure TWA170FGestioneGruppi.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,True);
end;

procedure TWA170FGestioneGruppi.btnEseguiClick(Sender: TObject);
var Msg: String;
  anno: Integer;
begin
  inherited;
  if grdTabDetail.ActiveTab = WA170PesatureRG then
  begin
    if Trim(edtGruppiPesature.Text) = '' then
    begin
      MsgBox.WebMessageDlg(A000MSG_A170_ERR_GRUPPI_PESATURE,mtError,[mbOK],nil,'');
      Exit;
    end;

    if chkChiusuraPesature.Checked then
      msg:=A000MSG_A170_DLG_FMT_CHIUSURA_PESATURE
    else if chkAperturaPesature.Checked then
      msg:=A000MSG_A170_DLG_FMT_RIAPERTURA_PESATURE
    else
      msg:=A000MSG_A170_DLG_FMT_AGGIORNA_PESATURE;
    MsgBox.WebMessageDlg(Format(msg,[edtAnnoPesature.Text]),mtConfirmation,[mbYes,mbNo],ResultConfermaStart,'');
    Exit;
  end
  else
  begin
    if (not chkPassaggioAnnoSchede.Checked) and (Trim(edtGruppiSchede.Text) = '') then
    begin
      MsgBox.WebMessageDlg(A000MSG_A170_ERR_GRUPPI_SCHEDE,mtError,[mbOK],nil,'');
      Exit;
    end;
    if chkPassaggioAnnoSchede.Checked then
    begin
      anno:=StrToIntDef(edtAnnoSchede.Text,0);
      if anno = 0 then
      begin
        MsgBox.WebMessageDlg(A000MSG_A170_ERR_ANNO_SCHEDE,mtError,[mbOK],nil,'');
        Exit;
      end;

      msg:=Format(A000MSG_A170_DLG_FMT_PASSAGGIO_ANNO_SCHEDE,[IntToStr(Anno - 1),IntToStr(anno), IntToStr(anno)]);
      MsgBox.WebMessageDlg(Format(msg,[edtAnnoSchede.Text]),mtConfirmation,[mbYes,mbNo],ResultConfermaPassaggioAnno,'');
      Exit;
    end
    else
    begin
      if chkChiusuraSchede.Checked then
        msg:=A000MSG_A170_DLG_FMT_CHIUSURA_SCHEDE
      else if chkAperturaSchede.Checked then
        msg:=A000MSG_A170_DLG_FMT_RIAPERTURA_SCHEDE
      else if chkAggiornaSchede.Checked then
        msg:=A000MSG_A170_DLG_FMT_AGGIORNA_SCHEDE;

      MsgBox.WebMessageDlg(Format(msg,[edtAnnoSchede.Text]),mtConfirmation,[mbYes,mbNo],ResultConfermaStart,'');
      Exit;
    end;
  end;
end;

procedure TWA170FGestioneGruppi.ResultConfermaPassaggioAnno(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  Empty: Boolean;
  c: Integer;
  edtOre, edtPctOre: TmeIWEdit;
begin
  if R = mrYes then
  begin
    //Ribaltamento sul nuovo anno delle schede
    if not TryStrToDate(edtDataRifSchede.Text,DataRif) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A170_ERR_DATA_RIF_SCHEDE,mtError,[mbOK],nil,'');
      Exit;
    end;
    //Verificare che datarif sia compresa nel nuovo anno
    if R180Anno(DataRif) <> StrToIntDef(edtAnnoSchede.Text,0) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A170_ERR_ANNO_DATA_RIF_SCHEDE,mtError,[mbOK],nil,'');
      Exit;
    end;

    //Verificare che la quota sia indicata
    if (Trim(cmbQuotaSchede.Text) = '') then
    begin
      MsgBox.WebMessageDlg(A000MSG_A170_ERR_TIPOLOGIA_QUOTA,mtError,[mbOK],nil,'');
      Exit;
    end;

    Empty:=True;
    for c:=1 to 12 do
    begin
      edtOre:=(grdPagamenti.Cell[1,c].Control as TmeIWEdit);
      edtPctOre:=(grdPagamenti.Cell[2,c].Control as TmeIWEdit);
      if ((edtOre.Text <> '') and (edtOre.Text <> '0')) or
         ((edtPctOre.Text <> '') and (edtPctOre.Text <> '0')) then
      begin
        Empty:=False;
        Break;
      end;
    end;

    //Verificare che il pagamento sia indicato
    if Empty then
    begin
      MsgBox.WebMessageDlg(A000MSG_A170_DLG_NO_MESE_PAGAMENTO,mtConfirmation,[mbYes,mbNo],ResultConfermaNoMesePagamento,'');
      Exit;
    end;
    VerificaGruppiPassaggioAnno;
  end;
end;

procedure TWA170FGestioneGruppi.ResultConfermaNoMesePagamento(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    VerificaGruppiPassaggioAnno;
  end;
end;

procedure TWA170FGestioneGruppi.VerificaGruppiPassaggioAnno;
begin
  NumGruppi:=WA170FGestioneGruppiDM.A170FGestioneGruppiMW.VerificaGruppiApertiSchede(StrToIntDef(edtAnnoSchede.Text,0),cmbQuotaSchede.Text);
  if NumGruppi > 0 then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A170_DLG_FMT_GRUPPI_APERTI_SCHEDE,[IntToStr(NumGruppi),edtAnnoSchede.Text]),mtConfirmation,[mbYes,mbNo],ResultConfermaGruppiAperti,'');
    Exit;
  end;

  StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWA170FGestioneGruppi.ResultConfermaGruppiAperti(Sender: TObject; R: TmeIWModalResult; KI: String);
var WC020FInputBoxFM: TWC020FInputDataOreFM;
begin
  if R = mrYes then
  begin
    WC020FInputBoxFM:=TWC020FInputDataOreFM.Create(Self);
    WC020FInputBoxFM.ImpostaCampiText('Indicare il numero di gruppi da sovrascrivere:','-1');
    WC020FInputBoxFM.ResultEvent:=ResultNumeroGruppi;
    WC020FInputBoxFM.Visualizza('Cancellazione di ' + IntToStr(NumGruppi) + ' gruppi');
  end;
end;

procedure TWA170FGestioneGruppi.ResultNumeroGruppi(Sender: TObject;Result: Boolean;Valore: String);
begin
  if Result then
  begin
    if StrToIntDef(Valore,0) = NumGruppi then
    begin
      StartElaborazioneCiclo(btnEsegui.HTMLName);
      Exit;
    end;
  end;
  MsgBox.WebMessageDlg(A000MSG_MSG_OPERAZIONE_ANNULLATA,mtInformation,[mbOk],nil,'');
end;

procedure TWA170FGestioneGruppi.ResultConfermaStart(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    StartElaborazioneCiclo(btnEsegui.HTMLName);
  end;
end;

procedure TWA170FGestioneGruppi.btnGruppiPesatureClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
  ElencoValoriChecklist: TElencoValoriChecklist;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  LstSel:=TStringList.Create;
  try
    ElencoValoriChecklist:=WA170FGestioneGruppiDM.A170FGestioneGruppiMW.ListGruppiPesature(StrToIntDef(edtAnnoPesature.Text,0),cmbQuotaPesature.Text);

    LstSel.CommaText:=edtGruppiPesature.Text;
    WC013.CaricaLista(ElencoValoriChecklist.lstDescrizione, ElencoValoriChecklist.lstCodice);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=GruppiPesatureResult;
    WC013.Visualizza(0,0,'<WC013> Gruppi pesature');
  finally
    FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
  end;
end;

procedure TWA170FGestioneGruppi.btnGruppiSchedeClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
  ElencoValoriChecklist: TElencoValoriChecklist;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  LstSel:=TStringList.Create;
  try
    ElencoValoriChecklist:=WA170FGestioneGruppiDM.A170FGestioneGruppiMW.ListGruppiSchede(StrToIntDef(edtAnnoSchede.Text,0),cmbQuotaSchede.Text);

    LstSel.CommaText:=edtGruppiSchede.Text;
    WC013.CaricaLista(ElencoValoriChecklist.lstDescrizione, ElencoValoriChecklist.lstCodice);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=GruppiSchedeResult;
    WC013.Visualizza(0,0,'<WC013> Gruppi schede');
  finally
    FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
  end;
end;

procedure TWA170FGestioneGruppi.chkAggiornaPesatureAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponentiPesature;
end;

procedure TWA170FGestioneGruppi.chkAggiornaSchedeAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponentiSchede;
end;

procedure TWA170FGestioneGruppi.chkAperturaPesatureAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponentiPesature;
end;

procedure TWA170FGestioneGruppi.chkAperturaSchedeAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponentiSchede;
end;

procedure TWA170FGestioneGruppi.chkChiusuraPesatureAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponentiPesature;
end;

procedure TWA170FGestioneGruppi.chkChiusuraSchedeAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaComponentiSchede;
end;

procedure TWA170FGestioneGruppi.chkPassaggioAnnoSchedeAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponentiSchede;
end;

procedure TWA170FGestioneGruppi.AbilitaComponentiSchede;
begin
  if grdTabDetail.ActiveTab = WA170SchedeRG then
    btnEsegui.Enabled:=not SolaLettura and (chkChiusuraSchede.Checked or chkAperturaSchede.Checked or chkAggiornaSchede.Checked or chkPassaggioAnnoSchede.Checked);
  chkAggiornaSchede.Enabled:=not chkChiusuraSchede.Checked and not chkAperturaSchede.Checked and not chkPassaggioAnnoSchede.Checked;
  if not chkAggiornaSchede.Enabled then
    chkAggiornaSchede.Checked:=False;
  chkAperturaSchede.Enabled:=not chkChiusuraSchede.Checked and not chkAggiornaSchede.Checked and not chkPassaggioAnnoSchede.Checked;
  if not chkAperturaSchede.Enabled then
    chkAperturaSchede.Checked:=False;
  chkChiusuraSchede.Enabled:=not chkAperturaSchede.Checked and not chkAggiornaSchede.Checked and not chkPassaggioAnnoSchede.Checked;
  if not chkChiusuraSchede.Enabled then
    chkChiusuraSchede.Checked:=False;
  chkPassaggioAnnoSchede.Enabled:=not chkAperturaSchede.Checked and not chkAggiornaSchede.Checked and not chkChiusuraSchede.Checked;
  if not chkPassaggioAnnoSchede.Enabled then
    chkPassaggioAnnoSchede.Checked:=False;
  lblGruppiSchede.Enabled:=not chkPassaggioAnnoSchede.Checked;
  edtGruppiSchede.Enabled:=lblGruppiSchede.Enabled;
  btnGruppiSchede.Enabled:=lblGruppiSchede.Enabled;
  if not edtGruppiSchede.Enabled then
    edtGruppiSchede.Text:='';
  if chkPassaggioAnnoSchede.Checked then
    lblAnnoSchede.Caption:='Nuovo anno'
  else
    lblAnnoSchede.Caption:='Anno elaborazione';
  lblDataRifSchede.Enabled:=chkPassaggioAnnoSchede.Checked;
  edtDataRifSchede.Enabled:=lblDataRifSchede.Enabled;
  grdPagamenti.Enabled:=lblDataRifSchede.Enabled;
  if GGetWebApplicationThreadVar.IsCallBack then
  begin
    C190VisualizzaElementoAsync(JQuery,'groupboxpagamenti',chkPassaggioAnnoSchede.Checked)
  end
  else
    C190VisualizzaElemento(JQuery,'groupboxpagamenti',chkPassaggioAnnoSchede.Checked);
end;

procedure TWA170FGestioneGruppi.AbilitaComponentiPesature;
begin
  if grdTabDetail.ActiveTab = WA170PesatureRG then
    btnEsegui.Enabled:=not SolaLettura and (chkChiusuraPesature.Checked or chkAperturaPesature.Checked or chkAggiornaPesature.Checked);

  chkAperturaPesature.Enabled:=(not chkAggiornaPesature.Checked) and
                               (not chkChiusuraPesature.Checked);
  if not chkAperturaPesature.Enabled then
    chkAperturaPesature.Checked:=False;

  chkChiusuraPesature.Enabled:=(not chkAggiornaPesature.Checked) and
                               (not chkAperturaPesature.Checked);
  if not chkChiusuraPesature.Enabled then
    chkChiusuraPesature.Checked:=False;

  chkAggiornaPesature.Enabled:=(not chkAperturaPesature.Checked) and
                               (not chkChiusuraPesature.Checked);
  if not chkAggiornaPesature.Enabled then
    chkAggiornaPesature.Checked:=False;
end;

procedure TWA170FGestioneGruppi.cmbQuotaPesatureAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbQuotaPesature.ItemIndex = -1 then
    lblDescQuotaPesature.Caption:=''
  else
    lblDescQuotaPesature.Caption:=cmbQuotaPesature.Items[cmbQuotaPesature.ItemIndex].RowData[1];
  edtGruppiPesature.Text:='';
end;

procedure TWA170FGestioneGruppi.cmbQuotaSchedeAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbQuotaSchede.ItemIndex = -1 then
    lblDescQuotaSchede.Caption:=''
  else
    lblDescQuotaSchede.Caption:=cmbQuotaSchede.Items[cmbQuotaSchede.ItemIndex].RowData[1];
  edtGruppiSchede.Text:='';
end;

procedure TWA170FGestioneGruppi.edtAnnoPesatureAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  RicaricaCombQuotePesature(StrToIntDef(edtAnnoPesature.Text,0))
end;

procedure TWA170FGestioneGruppi.edtAnnoSchedeAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  edtGruppiSchede.Text:='';
end;

procedure TWA170FGestioneGruppi.grdTabDetailTabControlChange(Sender: TObject);
begin
  inherited;
  if grdTabDetail.ActiveTab = WA170PesatureRG then
    AbilitaComponentiPesature
  else
    AbilitaComponentiSchede;
end;

procedure TWA170FGestioneGruppi.GruppiSchedeResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      edtGruppiSchede.Text:=lstTmp.CommaText;
    finally
      FreeAndNil(lstTmp);
    end;
  end;
end;

procedure TWA170FGestioneGruppi.GruppiPesatureResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      edtGruppiPesature.Text:=lstTmp.CommaText;
    finally
      FreeAndNil(lstTmp);
    end;
  end;
end;

procedure TWA170FGestioneGruppi.CaricaGrdPagamenti;
var
  r,c: Integer;
begin
  // Deallocazione controlli della griglia e pulizia dati
  C190PulisciIWGrid(grdPagamenti,True);

  //Caricamento Grid
  grdPagamenti.RowCount:=3;
  grdPagamenti.ColumnCount:=13;

  c:=0;
  grdPagamenti.Cell[1,c].Text:='Max.ore';
  grdPagamenti.Cell[2,c].Text:='% ore';

  for c:=1 to 12 do
  begin
    r:=0;
    grdPagamenti.Cell[r,c].Text:=R180NomeMese(c);
    inc(r);
    grdPagamenti.Cell[r,c].Control:=TmeIWEdit.Create(Self);
    with (grdPagamenti.Cell[r,c].Control as TmeIWEdit) do
    begin
      Css:='input_hour_hhhmm width5chr';
      Text:='';
    end;
    inc(r);
    grdPagamenti.Cell[r,c].Control:=TmeIWEdit.Create(Self);
    with (grdPagamenti.Cell[r,c].Control as TmeIWEdit) do
    begin
      Css:='input_num_nnndd width5chr';
      Text:='0';
    end;
  end;
end;

procedure TWA170FGestioneGruppi.GetParametriFunzione;
{Leggo i parametri della form}
begin

  edtAnnoPesature.Text:=C004DM.getParametro('ANNOPESATURE',R180Anno(Parametri.DataLavoro).ToString());
  RicaricaCombQuotePesature(StrToIntDef(edtAnnoPesature.Text,0));
  cmbQuotaPesature.Text:=C004DM.getParametro('QUOTAPESATURE','');
  edtGruppiPesature.Text:=C004DM.getParametro('GRUPPIPESATURE','');

  edtAnnoSchede.Text:=C004DM.getParametro('ANNOSCHEDE',R180Anno(Parametri.DataLavoro).ToString());
  CaricaComboQuoteSchede;
  cmbQuotaSchede.Text:=C004DM.getParametro('QUOTASCHEDE','');
  edtGruppiSchede.Text:=C004DM.getParametro('GRUPPISCHEDE','');
  edtDataRifSchede.Text:='';
end;

procedure TWA170FGestioneGruppi.PutParametriFunzione;
begin
  C004DM.Cancella001;

  C004DM.PutParametro('ANNOPESATURE',edtAnnoPesature.Text);
  C004DM.PutParametro('QUOTAPESATURE',cmbQuotaPesature.Text);
  C004DM.PutParametro('GRUPPIPESATURE',edtGruppiPesature.Text);

  C004DM.PutParametro('ANNOSCHEDE',edtAnnoSchede.Text);
  C004DM.PutParametro('QUOTASCHEDE',cmbQuotaSchede.Text);
  C004DM.PutParametro('GRUPPISCHEDE',edtGruppiSchede.Text);

  try SessioneOracle.Commit; except end;
end;

//ELABORAZIONE PESATURE
procedure TWA170FGestioneGruppi.InizioElaborazione;
var
  pagamenti: TPagamenti;
  lstPagamenti:TList<TPagamenti>;
  i: Integer;
begin
  inherited;
  btnAnomalie.Enabled:=False;
  if grdTabDetail.ActiveTab = WA170PesatureRG then
  begin
    if chkAggiornaPesature.Checked then
    begin
      lstGruppi:=TStringList.Create();
      lstGruppi.CommaText:=edtGruppiPesature.Text;
      idxGruppo:=0;
      WA170FGestioneGruppiDM.A170FGestioneGruppiMW.InizioElaborazioneGruppiPesature;
    end;
  end
  else
  begin
    if chkAggiornaSchede.Checked then
    begin
      lstGruppi:=TStringList.Create();
      lstGruppi.CommaText:=edtGruppiSchede.Text;
      idxGruppo:=0;
    end
    else if chkPassaggioAnnoSchede.Checked then
    begin
      lstGruppi:=TStringList.Create();
      idxGruppo:=0;
      lstPagamenti:=TList<TPagamenti>.Create();
      for i:=1 to 12 do
      begin
        with (grdPagamenti.Cell[1,i].Control as TmeIWEdit) do
        begin
          pagamenti.max:=Trim(Text);
        end;
        with (grdPagamenti.Cell[2,i].Control as TmeIWEdit) do
        begin
          if trim(Text) = '' then
            pagamenti.perc:=0
          else
            pagamenti.perc:=StrToFloatDef(trim(Text),-1);
        end;
        lstPagamenti.add(pagamenti);
      end;

      WA170FGestioneGruppiDM.A170FGestioneGruppiMW.InizioElaborazionePassaggioAnno(StrToIntDef(edtAnnoSchede.Text,0),cmbQuotaSchede.Text,DataRif,lstPagamenti,lstGruppi);
    end;
  end;
end;

function TWA170FGestioneGruppi.TotalRecordsElaborazione: Integer;
begin
  if grdTabDetail.ActiveTab = WA170PesatureRG then
  begin
    if chkAggiornaPesature.Checked then
      Result:=lstGruppi.count
    else
      Result:=1;
  end
  else
  begin
    if (chkAggiornaSchede.Checked) or (chkPassaggioAnnoSchede.Checked) then
      Result:=lstGruppi.count
    else
      Result:=1;
  end;
end;

function TWA170FGestioneGruppi.CurrentRecordElaborazione: Integer;
begin
  if grdTabDetail.ActiveTab = WA170PesatureRG then
  begin
    if chkAggiornaPesature.Checked then
      Result:=idxGruppo
    else
      Result:=1;
  end
  else
  begin
    if (chkAggiornaSchede.Checked) or (chkPassaggioAnnoSchede.Checked) then
      Result:=idxGruppo
    else
      Result:=1;
  end;
end;

procedure TWA170FGestioneGruppi.ElaboraElemento;
var
  Tot: Real;
  TotOre: Integer;
begin
  inherited;
  if grdTabDetail.ActiveTab = WA170PesatureRG then //Pesature
  begin
    if (chkChiusuraPesature.Checked) or (chkAperturaPesature.Checked) then
    begin
      WA170FGestioneGruppiDM.A170FGestioneGruppiMW.AperturaChiusuraPesature(StrToIntDef(edtAnnoPesature.Text,0),cmbQuotaPesature.Text,edtGruppiPesature.Text,chkChiusuraPesature.Checked);
    end
    else
    begin //Aggiornamento gruppi
      if WA170FGestioneGruppiDM.A170FGestioneGruppiMW.VerificheElaborazioneGruppoPesature(StrToIntDef(edtAnnoPesature.Text,0), cmbQuotaPesature.Text,lstGruppi.Strings[idxGruppo]) then
      begin
        WA170FGestioneGruppiDM.A170FGestioneGruppiMW.selV430.First;
        while not WA170FGestioneGruppiDM.A170FGestioneGruppiMW.selV430.Eof do
        begin
          WA170FGestioneGruppiDM.A170FGestioneGruppiMW.ElaboraGruppoPesature;
          WA170FGestioneGruppiDM.A170FGestioneGruppiMW.selV430.Next;
        end;
      end;
    end;
  end
  else  //Schede
  begin
    if (chkChiusuraSchede.Checked) or (chkAperturaSchede.Checked) then
    begin
      WA170FGestioneGruppiDM.A170FGestioneGruppiMW.AperturaChiusuraSchede(StrToIntDef(edtAnnoSchede.Text,0),cmbQuotaSchede.Text,edtGruppiSchede.Text,chkChiusuraSchede.Checked);
    end
    else if (chkAggiornaSchede.Checked) or (chkPassaggioAnnoSchede.Checked) then
    begin
      Tot:=0;
      TotOre:=0;
      if WA170FGestioneGruppiDM.A170FGestioneGruppiMW.VerificheElaborazioneGruppoSchede(StrToIntDef(edtAnnoSchede.Text,0), cmbQuotaSchede.Text,lstGruppi.Strings[idxGruppo])then
      begin
        WA170FGestioneGruppiDM.A170FGestioneGruppiMW.selV430ScInd.First;
        while not WA170FGestioneGruppiDM.A170FGestioneGruppiMW.selV430ScInd.Eof do
        begin
          WA170FGestioneGruppiDM.A170FGestioneGruppiMW.ElaboraGruppoSchede(Tot,TotOre);
          WA170FGestioneGruppiDM.A170FGestioneGruppiMW.selV430ScInd.Next;
        end;
        WA170FGestioneGruppiDM.A170FGestioneGruppiMW.ImpostaTotaleGruppoSchede(Tot,TotOre);
      end;
    end;
  end;
end;

function TWA170FGestioneGruppi.ElementoSuccessivo: Boolean;
begin
  if grdTabDetail.ActiveTab = WA170PesatureRG then
  begin
    if (chkChiusuraPesature.Checked) or (chkAperturaPesature.Checked) then
      Result:=False
    else
    begin
      inc(idxGruppo);
      Result:=(idxGruppo < lstGruppi.Count);
    end;
  end
  else
  begin
    if (chkAggiornaSchede.Checked) or (chkPassaggioAnnoSchede.Checked) then
    begin
      inc(idxGruppo);
      Result:=(idxGruppo < lstGruppi.Count);
    end
    else
      Result:=False;
  end;
end;

procedure TWA170FGestioneGruppi.FineCicloElaborazione;
begin
  inherited;
  if grdTabDetail.ActiveTab = WA170SchedeRG then
  begin
    if (chkPassaggioAnnoSchede.Checked) and
       (not WC019FProgressBarFM.chkInterrompiElaborazione.Checked) then
    begin
      WA170FGestioneGruppiDM.A170FGestioneGruppiMW.FineElaborazionePassaggioAnno(StrToIntDef(edtAnnoSchede.Text,0),cmbQuotaSchede.Text);
    end;
  end;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

function TWA170FGestioneGruppi.ElaborazioneTerminata: String;
begin
  if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA170FGestioneGruppi.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  if grdTabDetail.ActiveTab = WA170PesatureRG then
  begin
    if chkAggiornaPesature.Checked then
    begin
      //richiamato qui FineElaborazioneGruppiPesature perchè fa destroy dell'oggetto dtm usato nel calcolo
      //In caso di errore non passa da finecicloelaborazione ma da qui si
      WA170FGestioneGruppiDM.A170FGestioneGruppiMW.FineElaborazioneGruppiPesature;
      FreeAndNil(lstGruppi);
    end;
  end
  else
  begin
    if (chkAggiornaSchede.Checked) or (chkPassaggioAnnoSchede.Checked) then
    begin
      FreeAndNil(lstGruppi);
    end;
  end;
end;

procedure TWA170FGestioneGruppi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  WA170FGestioneGruppiDM.A170FGestioneGruppiMW.FineElaborazioneGruppiPesature;
  FreeAndNil(lstGruppi);
  FreeAndNil(WA170FGestioneGruppiDM);
  inherited;
end;

end.
