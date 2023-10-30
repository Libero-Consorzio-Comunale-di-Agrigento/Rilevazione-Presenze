unit WA033UStampaAnomalie;

interface

uses
  Windows, Messages, SysUtils, StrUtils,Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, IWCompCheckbox,
  meIWCheckBox,medpIWC700NavigatorBar, IWCompListbox, meIWComboBox,
  meIWImageFile, medpIWImageButton, IWApplication,
  A000UCostanti, A000USessione, A000UInterfaccia,C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  R500Lin,WC013UCheckListFM, WA033UStampaAnomalieDM,A000UMessaggi,
  medpIWMessageDlg,QueryStorico, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, medpIWTabControl,
  IWDBGrids, medpIWDBGrid,DB,OracleData, Menus;

type
  TWA033FStampaAnomalie = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA033ParametriRG: TmeIWRegion;
    lblDaData: TmeIWLabel;
    lblAData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    edtAData: TmeIWEdit;
    btnElencoLivello1: TmeIWButton;
    chkLivello1: TmeIWCheckBox;
    chkTimbrature1: TmeIWCheckBox;
    chkCausali1: TmeIWCheckBox;
    btnElencoLivello2: TmeIWButton;
    chkLivello2: TmeIWCheckBox;
    chkTimbrature2: TmeIWCheckBox;
    chkCausali2: TmeIWCheckBox;
    btnElencoLivello3: TmeIWButton;
    chkLivello3: TmeIWCheckBox;
    chkTimbrature3: TmeIWCheckBox;
    chkCausali3: TmeIWCheckBox;
    chkAutoGiustificazione: TmeIWCheckBox;
    chkAggiornaT101: TmeIWCheckBox;
    lblRaggruppamento: TmeIWLabel;
    cmbRaggruppamento: TmeIWComboBox;
    chkSaltoPagina: TmeIWCheckBox;
    imgElaborazione: TmedpIWImageButton;
    TemplateParametriRG: TIWTemplateProcessorHTML;
    WA033RisultatiRG: TmeIWRegion;
    TemplateRisultatiRG: TIWTemplateProcessorHTML;
    grdRisultati: TmedpIWDBGrid;
    pmnGrid: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    chkConsideraRichiesteIter: TmeIWCheckBox;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnElencoLivello1Click(Sender: TObject);
    procedure btnElencoLivello2Click(Sender: TObject);
    procedure btnElencoLivello3Click(Sender: TObject);
    procedure chkTimbrature1AsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkTimbrature2AsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkTimbrature3AsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgElaborazioneClick(Sender: TObject);
    procedure edtDaDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure grdRisultatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    LstAnomalie1Selezionate,
    LstAnomalie2Selezionate,
    LstAnomalie3Selezionate: TStringList;
    RicaricaGridRisultati: Boolean;
    SenderName: String;
    WC013: TWC013FCheckListFM;
    WA033FStampaAnomalieDM: TWA033FStampaAnomalieDM;
    procedure ResultAnomalie1Livello(Sender: TObject; Result:Boolean);
    procedure ResultAnomalie2Livello(Sender: TObject; Result:Boolean);
    procedure ResultAnomalie3Livello(Sender: TObject; Result:Boolean);
    function VerificaAnomaliaSelezionata(Livello: Integer; idx: Integer):Boolean;
    function AnomalieSelezionate:Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure imgAccediClick(Sender: TObject);
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione;override;
    procedure DistruzioneOggettiElaborazione(Errore: Boolean); override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA033FStampaAnomalie.IWAppFormCreate(Sender: TObject);
begin
  grdTabDetail.AggiungiTab('Parametri',WA033ParametriRG);
  grdTabDetail.AggiungiTab('Risultati',WA033RisultatiRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA033ParametriRG;
  inherited;
  WA033FStampaAnomalieDM:=TWA033FStampaAnomalieDM.Create(Self);
  (* Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);// creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.AttivaBrowse:=False;
  *)
  AttivaGestioneC700;
  WA033FStampaAnomalieDM.A033FStampaAnomalieMW.SelAnagrafe:=grdC700.SelAnagrafe
end;

function TWA033FStampaAnomalie.InizializzaAccesso: Boolean;
var
  Data: TDateTime;
  i: Integer;
begin
  LstAnomalie1Selezionate:=TStringList.Create;
  LstAnomalie2Selezionate:=TStringList.Create;
  LstAnomalie3Selezionate:=TStringList.Create;

  if Parametri.DataLavoro > 0 then
    Data:=Parametri.DataLavoro
  else
    Data:=Date;

  edtDaData.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(Data));
  edtAData.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(Data));

  //Imposto tutte le anomalie come selezionate
  for i:=1 to High(tdescanom1) do
    LstAnomalie1Selezionate.Add(IntToStr(tdescanom1[i].N));

  for i:=1 to High(tdescanom2) do
    LstAnomalie2Selezionate.Add(IntToStr(tdescanom2[i].N));
  for i:=1 to High(tdescanom3) do
    LstAnomalie3Selezionate.Add(IntToStr(tdescanom3[i].N));

  cmbRaggruppamento.Items.Clear;
  cmbRaggruppamento.Items.add('');

  with WA033FStampaAnomalieDM.A033FStampaAnomalieMW do
  begin
    dsrI010.DataSet.First;
    while not dsrI010.DataSet.Eof do
    begin
      cmbRaggruppamento.Items.add(dsrI010.DataSet.FieldByName('NOME_LOGICO').AsString +'=' +
                                  dsrI010.DataSet.FieldByName('NOME_CAMPO').AsString);
      dsrI010.DataSet.Next;
    end;
    cmbRaggruppamento.ItemIndex:=0;

    CreazioneTabellaStampa;
    TStampa.FieldByName('PROGRESSIVO').Visible:=False;
    TStampa.FieldByName('BADGE').Visible:=False;

  end;
  GetParametriFunzione;

  RicaricaGridRisultati:=False;
  grdRisultati.medpComandiCustom:=True;
  grdRisultati.medpPaginazione:=True;
  grdRisultati.medpRighePagina:=18;

  grdRisultati.medpAttivaGrid(WA033FStampaAnomalieDM.A033FStampaAnomalieMW.TStampa,False,False);
  grdRisultati.medpPreparaComponenteGenerico('WR102-R',grdRisultati.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','','','');
  //In seguito alla modifica inserita nella DBGrid ( per avere medpComandiEdit e medpComandiCustom)
  //bisogna richiamare esplicitamente medpCaricaCDS in caso di medpComandiCustom;
  grdRisultati.medpCaricaCDS;

  Result:=True;
end;

procedure TWA033FStampaAnomalie.ResultAnomalie1Livello(Sender: TObject;
  Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    LstAnomalie1Selezionate.Clear;
    LstAnomalie1Selezionate.Assign(lstTmp);
    FreeAndNil(lstTmp);
  end;
end;

procedure TWA033FStampaAnomalie.ResultAnomalie2Livello(Sender: TObject;
  Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    LstAnomalie2Selezionate.Clear;
    LstAnomalie2Selezionate.Assign(lstTmp);
    FreeAndNil(lstTmp);
  end;
end;

procedure TWA033FStampaAnomalie.ResultAnomalie3Livello(Sender: TObject;
  Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    LstAnomalie3Selezionate.Clear;
    LstAnomalie3Selezionate.Assign(lstTmp);
    FreeAndNil(lstTmp);
  end;
end;

function TWA033FStampaAnomalie.VerificaAnomaliaSelezionata(Livello,
  idx: Integer): Boolean;
begin
  Result:=False;
  if Livello = 1 then
    Result:=LstAnomalie1Selezionate.IndexOf(IntToStr(tdescanom1[idx].N)) >= 0
  else if Livello = 2 then
    Result:=LstAnomalie2Selezionate.IndexOf(IntToStr(tdescanom2[idx].N)) >= 0
  else if Livello = 3 then
    Result:=LstAnomalie3Selezionate.IndexOf(IntToStr(tdescanom3[idx].N)) >= 0;
end;

procedure TWA033FStampaAnomalie.actScaricaInCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdRisultati.ToCsv
  else
    InviaFile('Anomalie.xls',csvDownload);
end;

procedure TWA033FStampaAnomalie.actScaricaInExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdRisultati.ToXlsx
  else
    InviaFile('Anomalie.xlsx',streamDownload);
end;

function TWA033FStampaAnomalie.AnomalieSelezionate: Integer;
begin
  Result:=0;
  if chkLivello1.Checked then
    Result:=Result+LstAnomalie1Selezionate.Count;

  if chkLivello2.Checked then
    Result:=Result+LstAnomalie2Selezionate.Count;

  if chkLivello3.Checked then
    Result:=Result+LstAnomalie3Selezionate.Count;
end;

procedure TWA033FStampaAnomalie.btnElencoLivello1Click(Sender: TObject);
var
  i: Integer;
  LstAnomalieValue,
  LstAnomalieDesc : TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self);
  with WC013 do
  begin
    LstAnomalieValue:=TStringList.Create;
    LstAnomalieDesc:=TStringList.Create;
    for i:=1 to High(tdescanom1) do
    begin
      LstAnomalieValue.Add(IntToStr(tdescanom1[i].N));
      //LstAnomalieDesc.Add(tdescanom1[i].D);
      LstAnomalieDesc.Add(Format('[1_%s] %s', [IntToStr(tdescanom1[i].N), tdescanom1[i].D]));
    end;

    CaricaLista(LstAnomalieDesc, LstAnomalieValue);
    ImpostaValoriSelezionati(LstAnomalie1Selezionate);
    ResultEvent:=ResultAnomalie1Livello;
    Visualizza(0,0,'Anomalie di 1° livello');
    FreeAndNil(LstAnomalieValue);
    FreeAndNil(LstAnomalieDesc);
  end;
end;

procedure TWA033FStampaAnomalie.btnElencoLivello2Click(Sender: TObject);
var
  i: Integer;
  LstAnomalieValue,
  LstAnomalieDesc : TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self);
  with WC013 do
  begin
    LstAnomalieValue:=TStringList.Create;
    LstAnomalieDesc:=TStringList.Create;
    for i:=1 to High(tdescanom2) do
    begin
      LstAnomalieValue.Add(IntToStr(tdescanom2[i].N));
      //LstAnomalieDesc.Add(tdescanom2[i].D);
      LstAnomalieDesc.Add(Format('[2_%s] %s', [IntToStr(tdescanom2[i].N), tdescanom2[i].D]));
    end;

    CaricaLista(LstAnomalieDesc, LstAnomalieValue);
    ImpostaValoriSelezionati(LstAnomalie2Selezionate);
    ResultEvent:=ResultAnomalie2Livello;
    Visualizza(0,0,'Anomalie di 2° livello');
    FreeAndNil(LstAnomalieValue);
    FreeAndNil(LstAnomalieDesc);
  end;
end;

procedure TWA033FStampaAnomalie.btnElencoLivello3Click(Sender: TObject);
var
  i: Integer;
  LstAnomalieValue,
  LstAnomalieDesc : TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self);
  with WC013 do
  begin
    LstAnomalieValue:=TStringList.Create;
    LstAnomalieDesc:=TStringList.Create;
    for i:=1 to High(tdescanom3) do
    begin
      LstAnomalieValue.Add(IntToStr(tdescanom3[i].N));
      //LstAnomalieDesc.Add(tdescanom3[i].D);
      LstAnomalieDesc.Add(Format('[3_%s] %s', [IntToStr(tdescanom3[i].N), tdescanom3[i].D]));
    end;

    CaricaLista(LstAnomalieDesc, LstAnomalieValue);
    ImpostaValoriSelezionati(LstAnomalie3Selezionate);
    ResultEvent:=ResultAnomalie3Livello;
    Visualizza(0,0,'Anomalie di 3° livello');
    FreeAndNil(LstAnomalieValue);
    FreeAndNil(LstAnomalieDesc);
  end;
end;

procedure TWA033FStampaAnomalie.chkTimbrature1AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  if not ChkTimbrature1.Checked then
    ChkCausali1.Checked:=False;
  ChkCausali1.Enabled:=ChkTimbrature1.Checked;
end;

procedure TWA033FStampaAnomalie.chkTimbrature2AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if not ChkTimbrature2.Checked then
    ChkCausali2.Checked:=False;
  ChkCausali2.Enabled:=ChkTimbrature2.Checked;
end;

procedure TWA033FStampaAnomalie.chkTimbrature3AsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if not ChkTimbrature3.Checked then
    ChkCausali3.Checked:=False;
  ChkCausali3.Enabled:=ChkTimbrature3.Checked;
end;

procedure TWA033FStampaAnomalie.imgAccediClick(Sender: TObject);
var
  Params: string;
  R: integer;
begin
  R:=StrToInt(TmeIWImageFile(Sender).FriendlyName);
  Params:='PROGRESSIVO=' + grdRisultati.medpValoreColonna(R,'PROGRESSIVO') + ParamDelimiter;
  Params:=Params + 'DATARIF=' + grdRisultati.medpValoreColonna(R,'DATA');
  AccediForm(7,Params,True);
end;

procedure TWA033FStampaAnomalie.imgElaborazioneClick(Sender: TObject);
var
  DataI,
  DataF: TDateTime;
begin
  inherited;
  if grdC700.SelAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  if AnomalieSelezionate = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A033_ERR_NO_ANOM_SEL,mtError,[mbOk],nil,'');
    Exit;
  end;
  with WA033FStampaAnomalieDM.A033FStampaAnomalieMW do
  begin
    if not TryStrToDate(edtDaData.Text,DataI) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Da Data']),mtError,[mbOk],nil,'');
      Exit;
    end;
    DataInizio:=DataI;
    if not TryStrToDate(edtAData.Text,DataF) then
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['A Data']),mtError,[mbOk],nil,'');
      Exit;
    end;
    DataFine:=DataF;
    if DataInizio > DataFine then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
      Exit;
    end;
    ConsideraRichiesteIter:=chkConsideraRichiesteIter.Checked;
  end;
  PutParametriFunzione;
  SenderName:=TmedpIWImageButton(Sender).HTMLName;
  StartElaborazioneCiclo(SenderName);
end;

procedure TWA033FStampaAnomalie.GetParametriFunzione;
var
  StrAnomalie,
  Raggr: String;
  i: Integer;
  EsisteFiltroDizionario:Boolean;
begin
  ChkLivello1.Checked:=C004DM.GetParametro('LIVELLO1','N') = 'S';
  ChkLivello2.Checked:=C004DM.GetParametro('LIVELLO2','N') = 'S';
  ChkLivello3.Checked:=C004DM.GetParametro('LIVELLO3','N') = 'S';

  ChkTimbrature1.Checked:=C004DM.GetParametro('TIMBRATURE1','N') = 'S';
  ChkTimbrature2.Checked:=C004DM.GetParametro('TIMBRATURE2','N') = 'S';
  ChkTimbrature3.Checked:=C004DM.GetParametro('TIMBRATURE3','N') = 'S';

  ChkTimbrature1AsyncClick(nil,nil);
  ChkTimbrature2AsyncClick(nil,nil);
  ChkTimbrature3AsyncClick(nil,nil);

  ChkCausali1.Checked:=C004DM.GetParametro('CAUSALI1','N') = 'S';
  ChkCausali2.Checked:=C004DM.GetParametro('CAUSALI2','N') = 'S';
  ChkCausali3.Checked:=C004DM.GetParametro('CAUSALI3','N') = 'S';

  ChkSaltoPagina.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
  ChkAggiornaT101.Checked:=C004DM.GetParametro('SALVAANOMALIE','N') = 'S';
  ChkAutoGiustificazione.Checked:=C004DM.GetParametro('AUTOGIUSTIFICAZIONE','N') = 'S';
  chkConsideraRichiesteIter.Checked:=C004DM.GetParametro('CONSIDERARICHIESTEITER','N') = 'S';

  Raggr:=C004DM.GetParametro('RAGGRUPPAMENTO','');
  for I:=0 to cmbRaggruppamento.Items.Count - 1 do
  begin
    if cmbRaggruppamento.Items.ValueFromIndex[I] = Raggr  then
    begin
      cmbRaggruppamento.ItemIndex:=I;
      Break;
    end;
  end;

  StrAnomalie:=C004DM.GetParametro('ANOMALIE1','');
  LstAnomalie1Selezionate.CommaText:=StrAnomalie;

  BtnElencoLivello2.Enabled:=True;
  BtnElencoLivello3.Enabled:=True;
  EsisteFiltroDizionario:=False;
  for i:=0 to High(Parametri.FiltroDizionario) do
    if Parametri.FiltroDizionario[i].Tabella = 'ANOMALIE DEI CONTEGGI' then
    begin
      EsisteFiltroDizionario:=True;
      Break;
    end;

  if not EsisteFiltroDizionario then
  begin
    StrAnomalie:=C004DM.GetParametro('ANOMALIE2','');
    LstAnomalie2Selezionate.CommaText:=StrAnomalie;

    StrAnomalie:=C004DM.GetParametro('ANOMALIE3','');
    LstAnomalie3Selezionate.CommaText:=StrAnomalie;
  end
  else
  begin
    //CARATTO 01/04/2015 Utente: AOSTA_REGIONE Chiamata: 90246; per default tutte le anomalie di livello 2 e 3 abilitate
    //in caoso di filtro dizionario seleziona solo quelle, ma non svuotava la stringlist
    LstAnomalie2Selezionate.Clear;
    LstAnomalie3Selezionate.Clear;
    for i:=1 to High(tdescanom2) do
      if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A2_' + intToStr(tdescanom2[i].N)) then
         LstAnomalie2Selezionate.Add(intToStr(tdescanom2[i].N));

    for i:=1 to High(tdescanom3) do
      if A000FiltroDizionario('ANOMALIE DEI CONTEGGI','A3_' + IntToStr(tdescanom3[i].N)) then
         LstAnomalie3Selezionate.Add(intToStr(tdescanom3[i].N));
  end;
end;

procedure TWA033FStampaAnomalie.grdRisultatiAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  img: TmeIWImageFile;
  r: Integer;
begin
  inherited;
  for r:=0 to High(grdRisultati.medpCompGriglia) do
  begin
    img:=(grdRisultati.medpCompCella(r,grdRisultati.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
    img.OnClick:=imgAccediClick;
    img.FriendlyName:=IntToStr(r);
  end;
end;

procedure TWA033FStampaAnomalie.grdTabDetailTabControlChange(Sender: TObject);
begin
  inherited;

  if (grdTabDetail.ActiveTab = WA033RisultatiRG) and (RicaricaGridRisultati) then
  begin

    with WA033FStampaAnomalieDM.A033FStampaAnomalieMW do
    begin
      TStampa.FieldByName('PROGRESSIVO').Visible:=False;
      TStampa.FieldByName('BADGE').Visible:=False;
      TStampa.FieldByName('RAGGRUPPAMENTO').Visible:=cmbRaggruppamento.Text <> '';
      grdRisultati.medpAttivaGrid(WA033FStampaAnomalieDM.A033FStampaAnomalieMW.TStampa,False,False);
      grdRisultati.medpPreparaComponenteGenerico('WR102-R',grdRisultati.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','','','');
      //Caratto 04/04/2013 In seguito alla modifica inserita nella DBGrid ( per avere medpComandiEdit e medpComandiCustom)
      //bisogna richiamare esplicitamente medpCaricaCDS in caso di medpComandiCustom;
        grdRisultati.medpCaricaCDS;
    end;
  end;
end;

procedure TWA033FStampaAnomalie.PutParametriFunzione;
begin
  C004DM.Cancella001;

  C004DM.PutParametro('LIVELLO1',IfThen(ChkLivello1.Checked,'S','N'));
  C004DM.PutParametro('LIVELLO2',IfThen(ChkLivello2.Checked,'S','N'));
  C004DM.PutParametro('LIVELLO3',IfThen(ChkLivello3.Checked,'S','N'));

  C004DM.PutParametro('TIMBRATURE1',IfThen(ChkTimbrature1.Checked,'S','N'));
  C004DM.PutParametro('TIMBRATURE2',IfThen(ChkTimbrature2.Checked,'S','N'));
  C004DM.PutParametro('TIMBRATURE3',IfThen(ChkTimbrature3.Checked,'S','N'));

  C004DM.PutParametro('CAUSALI1',IfThen(ChkCausali1.Checked,'S','N'));
  C004DM.PutParametro('CAUSALI2',IfThen(ChkCausali2.Checked,'S','N'));
  C004DM.PutParametro('CAUSALI3',IfThen(ChkCausali3.Checked,'S','N'));

  C004DM.PutParametro('SALTOPAGINA',IfThen(ChkSaltoPagina.Checked,'S','N'));
  C004DM.PutParametro('SALVAANOMALIE',IfThen(ChkAggiornaT101.Checked,'S','N'));
  C004DM.PutParametro('AUTOGIUSTIFICAZIONE',IfThen(chkAutoGiustificazione.Checked,'S','N'));
  C004DM.PutParametro('CONSIDERARICHIESTEITER',IfThen(chkConsideraRichiesteIter.Checked,'S','N'));

  C004DM.PutParametro('CAMPORAGGRUPPA',cmbRaggruppamento.Items.ValueFromIndex[cmbRaggruppamento.ItemIndex]);

  C004DM.PutParametro('ANOMALIE1',lstAnomalie1Selezionate.CommaText);
  C004DM.PutParametro('ANOMALIE2',lstAnomalie2Selezionate.CommaText);
  C004DM.PutParametro('ANOMALIE3',lstAnomalie3Selezionate.CommaText);
  try SessioneOracle.Commit; except end;
end;

procedure TWA033FStampaAnomalie.WC700AperturaSelezione(Sender: TObject);
var D: TDateTime;
begin
  if TryStrToDate(EdtDaData.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(EdtAData.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

procedure TWA033FStampaAnomalie.edtDaDataAsyncChange(Sender: TObject;
  EventParams: TStringList);
var D: TDateTime;
begin
  inherited;
  if TryStrToDate(EdtDaData.Text,D)then
  begin
    try
      if D > StrToDate(edtAData.Text) then
        EdtAData.Text:=FormatDateTime('dd/mm/yyyy',R180FIneMese(D));
    except
    end;
  end;
end;

//Elaborazione
procedure TWA033FStampaAnomalie.InizioElaborazione;
var
  raggr,S : String;
begin
  inherited;
  raggr:=cmbRaggruppamento.Items.ValueFromIndex[cmbRaggruppamento.ItemIndex];
  if raggr <> '' then
  begin
    S:=grdC700.SelAnagrafe.SQL.Text;
    if R180InserisciColonna(S,AliasTabella(raggr)+'.'+raggr ) then
    begin
      grdC700.SelAnagrafe.CloseAll;
      grdC700.SelAnagrafe.SQL.Text:=S;
    end;
  end;

  with WA033FStampaAnomalieDM.A033FStampaAnomalieMW do
  begin
    CreazioneTabellaStampa;
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
      grdC700.SelAnagrafe.CloseAll;
    grdC700.SelAnagrafe.Open;
    grdC700.SelAnagrafe.First;

    CancellaAnomalie;

    CreaR502Dtm;
    PeriodoConteggi;
    AggiornaT101:=ChkAggiornaT101.Checked;
    AnomalieLivello1:=ChkLivello1.Checked;
    AnomalieLivello2:=ChkLivello2.Checked;
    AnomalieLivello3:=ChkLivello3.Checked;
    TimbratureLivello1:=ChkTimbrature1.Checked;
    TimbratureLivello2:=ChkTimbrature2.Checked;
    TimbratureLivello3:=ChkTimbrature3.Checked;
    CausaliLivello1:=ChkCausali1.Checked;
    CausaliLivello2:=ChkCausali2.Checked;
    CausaliLivello3:=ChkCausali3.Checked;
    CampoRaggruppamento:=raggr;
    A033VerificaAnomaliaSelezionata:=VerificaAnomaliaSelezionata;
    //Massimo: assegnazione già fatta nel create
    //SelAnagrafe:=grdC700.SelAnagrafe;
  end;
end;

function TWA033FStampaAnomalie.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecNO;
end;


function TWA033FStampaAnomalie.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecordCount;
end;

procedure TWA033FStampaAnomalie.ElaboraElemento;
begin
  inherited;
  with WA033FStampaAnomalieDM.A033FStampaAnomalieMW do
  begin
    if chkAutoGiustificazione.Checked then
      Autogiustificazione;
    ElaboraDipendente;
  end;
end;

function TWA033FStampaAnomalie.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.SelAnagrafe.Next;
  if not grdC700.SelAnagrafe.EOF then
    Result:=True;
end;

procedure TWA033FStampaAnomalie.FineCicloElaborazione;
begin
  with WA033FStampaAnomalieDM.A033FStampaAnomalieMW do
  begin
    TStampa.First;
    RicaricaGridRisultati:=True;
  end;
end;

procedure TWA033FStampaAnomalie.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  WA033FStampaAnomalieDM.A033FStampaAnomalieMW.DistruggiR502Dtm;
end;

procedure TWA033FStampaAnomalie.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
  WA033FStampaAnomalieDM.A033FStampaAnomalieMW.DistruggiR502Dtm;
  FreeAndNil(WA033FStampaAnomalieDM);
  FreeAndNil(LstAnomalie1Selezionate);
  FreeAndNil(LstAnomalie2Selezionate);
  FreeAndNil(LstAnomalie3Selezionate);
end;

end.
