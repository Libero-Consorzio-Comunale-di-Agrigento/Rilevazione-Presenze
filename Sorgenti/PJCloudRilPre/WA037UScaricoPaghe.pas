unit WA037UScaricoPaghe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  WA037UScaricoPagheDM, meIWRadioGroup, IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit, IWCompLabel, meIWComboBox, meIWLabel, meIWImageButton, meIWImageFile,
  medpIWImageButton,IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb,WC013UCheckListFM,
  OracleData,A000UMessaggi,medpIWMessageDlg,medpIWC700NavigatorBar,QueryStorico,
  Menus, IWCompJQueryWidget, medpIWMultiColumnComboBox, IWApplication,
  System.Actions;

type
  TWA037FScaricoPaghe = class(TWR100FBase)
    lblMeseDaScaricare: TmeIWLabel;
    edtData: TmeIWEdit;
    lblIndietro: TmeIWLabel;
    edtDataInd: TmeIWEdit;
    lblDataCassa: TmeIWLabel;
    edtDataFile: TmeIWEdit;
    lblUltimaDataCassa: TmeIWLabel;
    edtUltimaDataCassa: TmeIWEdit;
    lblParametri: TmeIWLabel;
    lblNomeFile: TmeIWLabel;
    edtNomeFile: TmeIWEdit;
    chkConguagli: TmeIWCheckBox;
    rgpTipoScrittura: TmeIWRadioGroup;
    imbScarica: TmedpIWImageButton;
    imbBtnChiudi: TmedpIWImageButton;
    grdWA037NavigatorBar: TmeIWGrid;
    actlstWA037NavigatorBar: TActionList;
    actSalvataggio: TAction;
    actRipristino: TAction;
    actVisualizzaScarico: TAction;
    actVisualizzaAnomalie: TAction;
    actFiltroCodInterni: TAction;
    actEsci: TAction;
    actEseguiScarico: TAction;
    actFiltroVoci: TAction;
    actFiltro: TAction;
    actEliminaFiltro: TAction;
    actCmbSelezione: TAction;
    imbAnomalie: TmedpIWImageButton;
    imgEliminaUltimaDataCassa: TmeIWImageFile;
    JQuery: TIWJQueryWidget;
    cmbParametri: TMedpIWMultiColumnComboBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actFiltroCodInterniExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure actFiltroVociExecute(Sender: TObject);
    procedure edtSelAsyncChange(Sender: TObject;EventParams: TStringList);
    procedure edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbParametriAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure edtDataFileAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imbScaricaClick(Sender: TObject);
    procedure edtDataIndAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imgEliminaUltimaDataCassaClick(Sender: TObject);
    procedure imbAnomalieClick(Sender: TObject);
    procedure actFiltroExecute(Sender: TObject);
    procedure actRipristinoExecute(Sender: TObject);
    procedure actSalvataggioExecute(Sender: TObject);
    procedure actEliminaFiltroExecute(Sender: TObject);
    procedure actVisualizzaScaricoExecute(Sender: TObject);
    procedure actEseguiScaricoExecute(Sender: TObject);
  private
    Data,
    DataCassa,
    DataFile,
    DataIndietro,
    DataScarico,
    DTmp: TDateTime;
    WA037FScaricoPagheDM:TWA037FScaricoPagheDM;
    WC013: TWC013FCheckListFM;
    lstCodiciInterni, lstFiltroVoci: TStringList;
    edtSel: TmeIWEdit;
    sCodiciInterniSelezionati,
    sFiltroVociSelezionati,
    SenderName,
    Path: String;
    FileSeq,
    AggiornaT195,
    EsisteImporto:Boolean;
    F: TextFile;
    Lung: Integer;
    DipInSer:TDipendenteInServizio;
    procedure CaricaListaSelezioni;
    procedure imgNavBarClick(Sender: TObject);
    procedure CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; _onClick: TprocSender);
    procedure ResultCodiciInterni(Sender: TObject; Result:Boolean);
    procedure ResultFiltroVoci(Sender: TObject; Result:Boolean);
    procedure ResultDataCassaAnteScarico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultScaricoEsistente(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultCreaDirectory(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultApriScarico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultEliminaUltimaDataCassa(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultSovrascriviFiltro(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultRipristina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultSalvataggioScarico(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultEliminaFiltro(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure CreaListCodiciInterni;
    procedure CreaListFiltroVoci;
    procedure GetDataCassa(MeseSucc: Boolean);
    procedure GestisciNomeFile;
    procedure ControlliScarico;
    procedure GestioneFileSequenziale;
    procedure ApriScarico;
    procedure SalvaFiltri(Nome: String);
  private
    FileAperto:Boolean;
    function ControllaDisponibilitaBilancio: Boolean;
    function VoceAbilitata(Campo: String): Boolean;
    function VoceDisabilitata(Campo: String): Boolean;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
  public
    function InizializzaAccesso: Boolean; override;
    //Apertura da WA074 per creazione file scarico paghe
    procedure OpenWA037ScaricoBuoni(ParScarico: String; PDataScarico: TDateTime; grdC700DaEreditare: TmedpIWC700NavigatorBar);
  end;

const
  LENGHT_VOCIPAGHE: Integer = 10;
  LENGTH_CODINTERNI: Integer = 4;

implementation
{$R *.dfm}

procedure TWA037FScaricoPaghe.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  //Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
  //grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.ImpostaProgressivoCorrente:=True;
  grdC700.AttivaBrowse:=False;
  AttivaGestioneC700;

  WA037FScaricoPagheDM:=TWA037FScaricoPagheDM.Create(Self);
  WA037FScaricoPagheDM.A037FScaricoPagheMW.VoceAbilitata:=VoceAbilitata;
  WA037FScaricoPagheDM.A037FScaricoPagheMW.VoceDisabilitata:=VoceDisabilitata;
  WA037FScaricoPagheDM.A037FScaricoPagheMW.SelAnagrafe:=grdC700.selAnagrafe;
  edtSel:=TmeIWEdit.Create(Self);
  edtSel.OnAsyncChange:=edtSelAsyncChange;
  CreaNavigatorBar(actlstWA037NavigatorBar,grdWA037NavigatorBar,imgNavBarClick);

  lstCodiciInterni:=TStringList.Create;
  lstFiltroVoci:=TStringList.Create;
  sCodiciInterniSelezionati:='';
  sFiltroVociSelezionati:='';
  FileAperto:=False;
end;

procedure TWA037FScaricoPaghe.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(lstCodiciInterni);
  FreeAndNil(lstFiltroVoci);
  FreeAndNil(edtSel);
  DistruzioneOggettiElaborazione(False);
  inherited;
end;

procedure TWA037FScaricoPaghe.WC700AperturaSelezione(Sender: TObject);
begin
  grdC700.WC700FM.C700DataDal:=R180InizioMese(DataIndietro);
  grdC700.WC700FM.C700DataLavoro:=R180FineMese(Data);
end;

procedure TWA037FScaricoPaghe.ImpostazioniWC700;
begin
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWA037FScaricoPaghe.OpenWA037ScaricoBuoni(ParScarico:String; PDataScarico:TDateTime; grdC700DaEreditare: TmedpIWC700NavigatorBar );
{Scarico dati mensili alle paghe su file sequenziale}
var
  i:Integer;
  Codice: String;
  TmpLstSelezionati: TStringList;

begin
  InizializzaAccesso;
  //Sovrascrivo alcune impostazioni
  AggiornaT195:=False;
  cmbParametri.ItemIndex:=-1;
  cmbParametri.Text:=ParScarico;
  GestisciNomeFile;
  Data:=R180InizioMese(PDataScarico);
  DataScarico:=R180InizioMese(PDataScarico);
  DataIndietro:=R180InizioMese(PDataScarico);
  chkConguagli.Checked:=False;

  edtData.Text:=FormatDateTime('mm/yyyy',Data);
  edtDataInd.Text:=FormatDateTime('mm/yyyy',Data);

  //Imposto selezione su WC700 ed eseguo la selezione
  grdC700.SelezioneDaEreditare:=grdC700DaEreditare.WC700FM.C700SelAnagrafeBridge;
  grdC700.actC700EreditaSelezioneExecute(nil);
  grdC700.WC700FM.actConfermaExecute(nil);
  //Imposto filtri selezionati
  sCodiciInterniSelezionati:='215,225';
  TmpLstSelezionati:=TStringList.Create();
  for i:=0 to lstFiltroVoci.Count - 1 do
    TmpLstSelezionati.Add(Trim(Copy(lstFiltroVoci[i],1,LENGHT_VOCIPAGHE)));

  sFiltroVociSelezionati:=TmpLstSelezionati.CommaText;
  FreeAndNil(TmpLstSelezionati);

  imbScaricaClick(imbScarica);
end;

function TWA037FScaricoPaghe.InizializzaAccesso: Boolean;
begin
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
  begin
    selT191.First;
    CmbParametri.Items.Clear;
    while not selT191.EOF do
    begin
      CmbParametri.AddRow(selT191.FieldByName('CODICE').AsString+';'+selT191.FieldByName('DESCRIZIONE').AsString);
      selT191.Next;
    end;
  end;
  if Parametri.DataLavoro > 0 then
    Data:=Parametri.DataLavoro
  else
    Data:=Date;
  Data:=R180InizioMese(Data);

  DataIndietro:=Data;

  DataScarico:=Data;

  edtData.Text:=FormatDateTime('mm/yyyy',Data);
  edtDataInd.Text:=FormatDateTime('mm/yyyy',Data);
  CaricaListaSelezioni;
  //Creo elenco codici interni
  CreaListCodiciInterni;
  CreaListFiltroVoci;
  GetParametriFunzione;
  edtSelAsyncChange(nil,nil);
  GetDataCassa(True);
  FileSeq:=True;
  GestisciNomeFile;
  rgpTipoScrittura.Enabled:=Parametri.A037_RicreaScaricoPaghe = 'S';
  if Parametri.A037_RicreaScaricoPaghe <> 'S' then
    rgpTipoScrittura.itemIndex:=1;
  edtDataFile.Enabled:=WA037FScaricoPagheDM.A037FScaricoPagheMW.selT199.RecordCount = 0;
  imbAnomalie.Enabled:=False;
  imgEliminaUltimaDataCassa.Enabled:=(Parametri.A037_EliminaDataCassa = 'S') and (WA037FScaricoPagheDM.A037FScaricoPagheMW.selT199.RecordCount = 0);
  if not imgEliminaUltimaDataCassa.Enabled then
    imgEliminaUltimaDataCassa.ImageFile.Filename:='img\btnElimina_disabled.png';

  AggiornaT195:=True;
  Result:=True;
end;

procedure TWA037FScaricoPaghe.ResultCodiciInterni(Sender: TObject;
  Result: Boolean);
begin
  if Result then
    sCodiciInterniSelezionati:=C190GetCheckList(LENGTH_CODINTERNI, WC013.ckList);
end;

procedure TWA037FScaricoPaghe.ResultCreaDirectory(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
  begin
    if not CreateDir(Path) then
      if not ForceDirectories(Path) then
      begin
        MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CREA_DIR,[Path]),mtError,[mbOk],nil,'');
        Exit;
      end;
  end
  else
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_CREA_DIR,[Path]),mtError,[mbOk],nil,'');
    Exit;
  end;

  ApriScarico;
end;

procedure TWA037FScaricoPaghe.ResultDataCassaAnteScarico(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
    ControlliScarico;
end;
procedure TWA037FScaricoPaghe.ResultEliminaFiltro(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
  begin
    WA037FScaricoPagheDM.A037FScaricoPagheMW.EliminaFiltroScaricoPaghe(Trim(edtSel.Text));
    edtSel.Text:='';
    edtSelAsyncChange(nil,nil);
    CaricaListaSelezioni;
  end;
end;

procedure TWA037FScaricoPaghe.ResultEliminaUltimaDataCassa(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
  begin
    WA037FScaricoPagheDM.A037FScaricoPagheMW.EliminaUltimaDataCassa;
    getDataCassa(True);
  end;
end;

procedure TWA037FScaricoPaghe.ResultSalvataggioScarico(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
    WA037FScaricoPagheDM.A037FScaricoPagheMW.SalvataggioScarico;
end;

procedure TWA037FScaricoPaghe.ResultScaricoEsistente(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
    GestioneFileSequenziale;
end;

procedure TWA037FScaricoPaghe.ResultSovrascriviFiltro(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
var
  Nome: String;
  lstSalvaCodiciInterni,
  lstSalvaFiltroVoci: TStringList;
begin
  if (Res = mrYes) then
  begin
    Nome:=Trim(edtSel.Text);
    with WA037FScaricoPagheDM.A037FScaricoPagheMW do
    begin
      EliminaFiltroScaricoPaghe(Nome);
      salvaFiltri(Nome);
      CaricaListaSelezioni;
    end;
  end;
end;

procedure TWA037FScaricoPaghe.SalvaFiltri(Nome: String);
var
  lstSalvaCodiciInterni,
  lstSalvaFiltroVoci: TStringList;
begin
  lstSalvaCodiciInterni:=TStringList.Create();
  lstSalvaFiltroVoci:=TStringList.Create();
  try
    if sCodiciInterniSelezionati <> '' then
      lstSalvaCodiciInterni.CommaText:=sCodiciInterniSelezionati;
    if sFiltroVociSelezionati <> '' then
      lstSalvaFiltroVoci.CommaText:=sFiltroVociSelezionati;

    WA037FScaricoPagheDM.A037FScaricoPagheMW.SalvaFiltroScaricoPaghe(Nome,lstSalvaCodiciInterni,lstSalvaFiltroVoci);
  finally
    FreeAndNil(lstSalvaCodiciInterni);
    FreeAndNil(lstSalvaFiltroVoci);
  end;
  CaricaListaSelezioni;
end;

procedure TWA037FScaricoPaghe.ResultApriScarico(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
var
  Prosegui: String;
begin
  if (Res = mrYes) then
  begin
    Prosegui:=WA037FScaricoPagheDM.A037FScaricoPagheMW.ImpostaTabella(EdtNomeFile.Text,rgpTipoScrittura.ItemIndex = 0);
    if Prosegui = '' then
      StartElaborazioneCiclo(SenderName);
  end;
end;

procedure TWA037FScaricoPaghe.ResultFiltroVoci(Sender: TObject;
  Result: Boolean);
begin
  if Result then
    sFiltroVociSelezionati:=C190GetCheckList(LENGHT_VOCIPAGHE, WC013.ckList);
end;

procedure TWA037FScaricoPaghe.ResultRipristina(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if (Res = mrYes) then
  begin
    WA037FScaricoPagheDM.A037FScaricoPagheMW.RipristinoVociPaghe.Execute;
  end;
end;

{Se sono attive voci legate allo straordinario si fa il controllo sulla T710 che non ci siano situazioni anomale}
function TWA037FScaricoPaghe.ControllaDisponibilitaBilancio: Boolean;
var ScaricoVociBilancio:Boolean;
    i:Integer;
    lstTmpCodici: TStringList;
begin
  Result:=True;
  ScaricoVociBilancio:=False;
  lstTmpCodici:=TStringList.Create;
  lstTmpCodici.CommaText:=sCodiciInterniSelezionati;
  try
    for i:=0 to lstTmpCodici.Count - 1 do
      if R180In(Trim(Copy(lstTmpCodici[i],1,LENGTH_CODINTERNI)),WA037FScaricoPagheDM.A037FScaricoPagheMW.VociStraordinario) then
      begin
        ScaricoVociBilancio:=True;
        Break;
      end;
  finally
    lstTmpCodici.Free;
  end;
  if ScaricoVociBilancio then
    if not WA037FScaricoPagheDM.A037FScaricoPagheMW.DisponibilitaBilancio then
      Result:=False;
end;

procedure TWA037FScaricoPaghe.ControlliScarico;
var
  MsgFiltroScarico,
  Msg: String;
begin
  MsgFiltroScarico:='';
  if edtSel.Text <> '' then
    MsgFiltroScarico:=Format(A000MSG_A037_DLG_FMT_SCARICO_FILTRO,[edtSel.Text]) + #13#10;

  if AggiornaT195 then
  begin
    if DataCassa = DTmp then
      Msg:=MsgFiltroScarico + A000MSG_A037_DLG_SCARICO_GIA_PRESENTE
    else
      Msg:=MsgFiltroScarico + A000MSG_A037_DLG_ESEGUIRE_SCARICO;

    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,MbNo],ResultScaricoEsistente,'');
    Exit;
  end;

  GestioneFileSequenziale;
end;

procedure TWA037FScaricoPaghe.imbAnomalieClick(Sender: TObject);
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

procedure TWA037FScaricoPaghe.imbScaricaClick(Sender: TObject);
begin
  inherited;
  SenderName:=TmeIWButton(Sender).HTMLName;
  if grdC700.selAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  //Controllo per Torino_Comune: non ci devono essere situazioni anomale sulla T710
  if not ControllaDisponibilitaBilancio then
  begin
    MsgBox.WebMessageDlg(A000MSG_A037_ERR_BILANCIO,mtError,[mbOK],nil,'');
    Exit;
  end;

  if sFiltroVociSelezionati = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_A037_ERR_NO_VOCI,mtError,[mbOK],nil,'');
    Exit;
  end;

  if not tryStrToDate(edtDataFile.Text,DataFile) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Data cassa']),mtError,[mbOK],nil,'');
    Exit;
  end;
  DataCassa:=R180InizioMese(DataFile);

  if not TryStrToDate('01/'+edtData.Text,Data) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Mese da scaricare']),mtError,[mbOK],nil,'');
    Exit;
  end;

  if not TryStrToDate('01/'+edtDataInd.Text,DataIndietro) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['Indietro fino al mese']),mtError,[mbOK],nil,'');
    Exit;
  end;

  if DataIndietro > Data then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_PERIODO_NON_CORRETTO,[DateToStr(DataIndietro) + ' - ' + DateToStr(Data)]),mtError,[mbOK],nil,'');
    Exit;
  end;

  with WA037FScaricoPagheDM.A037FScaricoPagheMW.selMaxDataCassa do
  try
    Close;
    Open;
    DTmp:=Fields[0].AsDateTime;
  finally
    Close;
  end;
  if DataCassa < DTmp then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A037_ERR_FMT_DATA_CASSA_ANTE,[UpperCase(FormatDateTime('mmmm yyyy',DTmp))]),mtError,[mbOK],nil,'');
    Exit;
  end;

  if AggiornaT195 and (DataCassa < Data) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A037_ERR_FMT_DATA_ANTE_SCARICO,[FormatDateTime('mmmm yyyy',DTmp),FormatDateTime('mmmm yyyy',Data)]),mtError,[mbOK],nil,'');
    Exit;
  end;

  ControlliScarico;
end;

procedure TWA037FScaricoPaghe.imgEliminaUltimaDataCassaClick(Sender: TObject);
var
  S: String;
begin
  inherited;
  S:=WA037FScaricoPagheDM.A037FScaricoPagheMW.MessaggioEliminaDataCassa;
  MsgBox.WebMessageDlg(S,mtConfirmation,[mbYes,mbNo],ResultEliminaUltimaDataCassa,'');
end;

procedure TWA037FScaricoPaghe.imgNavBarClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  TAction(actlstWA037NavigatorBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA037FScaricoPaghe.actEliminaFiltroExecute(Sender: TObject);
begin
  inherited;
  if Trim(edtSel.Text) = '' then Exit;
  MsgBox.WebMessageDlg(Format(A000MSG_A037_DLG_FMT_ELIMINA_FILTRO,[edtSel.Text]),mtConfirmation,[mbYes,MbNo],ResultEliminaFiltro,'');
  Exit;
end;

procedure TWA037FScaricoPaghe.actEseguiScaricoExecute(Sender: TObject);
begin
  inherited;
  imbScaricaClick(imbScarica);
end;

procedure TWA037FScaricoPaghe.actFiltroCodInterniExecute(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self);
  with WC013 do
  begin
    ckList.Items.BeginUpdate;
    ckList.Items.Clear;
    ckList.Items.AddStrings(LstCodiciInterni);
    ckList.Items.EndUpdate;
    C190PutCheckList(sCodiciInterniSelezionati,LENGTH_CODINTERNI,ckList);
    ResultEvent:=ResultCodiciInterni;
    Visualizza;
  end;
end;

procedure TWA037FScaricoPaghe.actFiltroExecute(Sender: TObject);
var
  Nome: String;
begin
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
  begin
    Nome:=Trim(edtSel.Text);
    selT196.Close;
    selT196.setVariable('CODICE', Nome);
    selT196.Open;
    if selT196.RecordCount > 0 then
    begin
      MsgBox.WebMessageDlg(A000MSG_A037_DLG_SOVRASCRIVERE_FILTRO,mtConfirmation,[mbYes,MbNo],ResultSovrascriviFiltro,'');
      Exit
    end;
  end;
  SalvaFiltri(Nome);
end;

procedure TWA037FScaricoPaghe.actFiltroVociExecute(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self);
  with WC013 do
  begin
    ckList.Items.BeginUpdate;
    ckList.Items.Clear;
    ckList.Items.AddStrings(LstFiltroVoci);
    ckList.Items.EndUpdate;
    C190PutCheckList(sFiltroVociSelezionati,LENGHT_VOCIPAGHE,ckList);
    ResultEvent:=ResultFiltroVoci;
    Visualizza;
  end;
end;

procedure TWA037FScaricoPaghe.actRipristinoExecute(Sender: TObject);
begin
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
  begin
    MsgBox.WebMessageDlg(MessaggioRipristina,mtConfirmation,[mbYes,mbNo],ResultRipristina,'');
    Exit;
  end;
end;

procedure TWA037FScaricoPaghe.actSalvataggioExecute(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(WA037FScaricoPagheDM.A037FScaricoPagheMW.MessaggioSalvataggio,mtConfirmation,[mbYes,mbNo],ResultSalvataggioScarico,'');
  Exit;
end;

procedure TWA037FScaricoPaghe.actVisualizzaScaricoExecute(Sender: TObject);
var
  lst: TStringList;
  ss: TStringStream;
begin
  inherited;
  if FileSeq then
  begin
    if FileExists(edtNomeFile.Text) then
      GGetWebApplicationThreadVar.SendFile(edtNomeFile.Text,true,'application/x-download',ExtractFileName(edtNomeFile.Text))
    else
      MsgBox.WebMessageDlg(A000MSG_ERR_FILE_INESISTENTE,mtError,[mbOk],nil,'');
  end
  else
  begin
    lst:=WA037FScaricoPagheDM.A037FScaricoPagheMW.LeggiScaricoDaTabella(EdtNomeFile.Text);
    SS:=TStringStream.Create('');
    lst.SaveToStream(SS);
    GGetWebApplicationThreadVar.SendStream(SS,true,'application/x-download',edtNomeFile.Text + '.txt');
    lst.Free;
  end;
end;

procedure TWA037FScaricoPaghe.ApriScarico;
var
  S: String;
  Prosegui: String;
begin
  if FileSeq then
  begin
    Prosegui:=WA037FScaricoPagheDM.A037FScaricoPagheMW.ApriFileSequenziale(edtNomeFile.Text,rgpTipoScrittura.ItemIndex = 1, F);
    FileAperto:=Prosegui = '';
  end
  else
  begin
    S:=WA037FScaricoPagheDM.A037FScaricoPagheMW.VerificaTabella(EdtNomeFile.Text,rgpTipoScrittura.ItemIndex = 0);
    Prosegui:='';
    if (S <> '') then
    begin
      MsgBox.WebMessageDlg(S,mtConfirmation,[mbYes,mbNo],ResultApriScarico,'');
      Exit;
    end;
    if Prosegui = '' then
      Prosegui:=WA037FScaricoPagheDM.A037FScaricoPagheMW.ImpostaTabella(EdtNomeFile.Text,rgpTipoScrittura.ItemIndex = 0);
  end;

  if Prosegui = '' then
    if AggiornaT195 then
      StartElaborazioneCiclo(SenderName)
    else
      ElaborazioneCicloServer; //Se richiamo da WA074, Elaborazione senza progress bar
end;

procedure TWA037FScaricoPaghe.CaricaListaSelezioni;
var
  lstSel: TStringList;
begin
  lstSel:=TStringList.Create();
  with WA037FScaricoPagheDM.A037FScaricoPagheMW.selCodiciScaricoT196 do
  begin
    Open;
    while Not(Eof) do
    begin
      lstSel.Add('''' + C190EscapeJS(FieldByName('CODICE').AsString) + '''');
      Next;
    end;
    Close;
  end;

  if lstSel.Count > 0 then
  begin
    //15/10/2013 Con un magheggio jquery si fa scatenare l'asyncChange del edit quando si seleziona dalla lista
   JQuery.OnReady.Text:='var elementi = [' + lstSel.CommaText + '];' + CRLF +
                         '$("#' +  edtSel.HTMLName + '").autocomplete({' + CRLF +
                         '  source: elementi,' + CRLF +
                         '  delay: 0,' + CRLF +
                         '  minLength: 0,' + CRLF +
                         '  select: function( event, ui ) {window.ChangedControls += "' + edtSel.HTMLName + '"+ ","; processAjaxEvent("","+e dtSel.HTMLName + ","' + edtSel.HTMLName + '.DoOnAsyncChange",false,null,false);}' + CRLF +
                         '}).focus(function(){ ' + CRLF +
                         '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
                         '}); ';
  end;

  FreeAndNil(lstSel);
end;

procedure TWA037FScaricoPaghe.cmbParametriAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  GestisciNomeFile;
end;

procedure TWA037FScaricoPaghe.edtSelAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  Sel, Cod: String;
  i: Integer;
  TmpLstSelezionati: TStringList;
begin
  Sel:=Trim(edtSel.Text);
  TmpLstSelezionati:=TStringList.Create();
  try
    //se selezione vuota, seleziono tutti gli elementi
    if Sel = '' then
    begin
      for i:=0 to lstCodiciInterni.Count-1 do
        TmpLstSelezionati.Add(Trim(Copy(lstCodiciInterni[i],1,LENGTH_CODINTERNI)));
      sCodiciInterniSelezionati:=TmpLstSelezionati.CommaText;
      TmpLstSelezionati.Clear;

      for i:=0 to lstFiltroVoci.Count - 1 do
        TmpLstSelezionati.Add(Trim(Copy(lstFiltroVoci[i],1,LENGHT_VOCIPAGHE)));

      sFiltroVociSelezionati:=TmpLstSelezionati.CommaText;
      Exit;
    end;

    with WA037FScaricoPagheDM.A037FScaricoPagheMW do
    begin
      selT196.Close;
      selT196.setVariable('CODICE',Sel);
      selT196.Open;
      if selT196.RecordCount = 0 then
      begin
        //se ho inserito un filtro non presente, mantengo i filtri impostati
        //sCodiciInterniSelezionati:='';
        //sFiltroVociSelezionati:='';
        Exit;
      end;

      //Codici interni selezionati in base a selezione
      for i:=0 to lstCodiciInterni.Count-1 do
      begin
        Cod:=Trim(Copy(lstCodiciInterni[i],1,LENGTH_CODINTERNI));
        if selT196.SearchRecord('TIPO;CODVOCE',VarArrayOf(['I',Cod]),[srFromBeginning]) then
          TmpLstSelezionati.Add(Cod);
      end;
      sCodiciInterniSelezionati:=TmpLstSelezionati.CommaText;

      //Filtro voci selezionati in base a selezione (se no selezione, tutti i codici selezionati)
      TmpLstSelezionati.Clear;
      for i:=0 to lstFiltroVoci.Count - 1 do
      begin
        Cod:=Trim(Copy(lstFiltroVoci[i],1,LENGHT_VOCIPAGHE));
        if SelT196.SearchRecord('TIPO;CODVOCE',VarArrayOf(['V',Cod]),[srFromBeginning]) then
          TmpLstSelezionati.Add(Cod);
      end;
      sFiltroVociSelezionati:=TmpLstSelezionati.CommaText;
    end;
  finally
    FreeAndNil(TmpLstSelezionati);
  end;

end;

procedure TWA037FScaricoPaghe.CreaListCodiciInterni;
var
  Elemento: String;
  i: Integer;
begin
  lstCodiciInterni.Clear;
  Elemento:='%-' + IntToStr(LENGTH_CODINTERNI) + 's %s';
  for i:=1 to High(VettConst) do
    lstCodiciInterni.Add(Format(Elemento,[VettConst[i].CodInt,VettConst[i].Descrizione]));
end;

procedure TWA037FScaricoPaghe.CreaListFiltroVoci;
var
  Elemento: String;
  i: Integer;
begin
  Elemento:='%-' + IntToStr(LENGHT_VOCIPAGHE) + 's %s';
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
  begin
    selT193Filtro.Open;
    selT193Filtro.First;
    while not selT193Filtro.Eof do
    begin
      lstFiltroVoci.Add(Format(Elemento,[selT193Filtro.FieldByName('COD_VOCE').AsString,selT193Filtro.FieldByName('DESCRIZIONE').AsString]));
      selT193Filtro.Next;
    end;
    selT193Filtro.Close;
  end;
end;

procedure TWA037FScaricoPaghe.CreaNavigatorBar(actlstNavBar: TActionList; grdNavBar: TmeIWGrid; _onClick: TprocSender);
var
  i, k:Integer;
  PrecCategory: String;
begin
  grdNavBar.RowCount:=1;
  grdNavBar.ColumnCount:=actlstNavBar.ActionCount;

  if actlstNavBar.ActionCount > 0 then
    PrecCategory:=TAction(actlstNavBar.Actions[0]).Category;

  k:=0;
  for i:=0 to actlstNavBar.ActionCount - 1 do
  begin
    if PrecCategory <> TAction(actlstNavBar.Actions[i]).Category  then
    begin
      grdNavBar.Cell[0,k].Css:='x';
      grdNavBar.Cell[0,k].Text:='';
      k:=k + 1;
      grdNavBar.ColumnCount:=grdNavBar.ColumnCount + 1;
      PrecCategory:=TAction(actlstNavBar.Actions[i]).Category;
    end;

    if TAction(actlstNavBar.Actions[i]) <> actCmbSelezione then
    begin
      grdNavBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
      if TAction(actlstNavBar.Actions[i]) = actVisualizzaScarico then
        TmeIWImageFile(grdNavBar.Cell[0,k].Control).medpDownloadButton:=True;

      with TmeIWImageFile(grdNavBar.Cell[0,k].Control) do
      begin
        Name:=C190CreaNomeComponente(TAction(actlstNavBar.Actions[i]).Name,Self);
        //OnClick:=imgNavBarClick;
        OnClick:=_onClick;
        Tag:=i;
      end;
    end
    else
    begin
      grdNavBar.Cell[0,k].Control:=edtSel;
      with edtSel do
      begin
        Tag:=i;
        Name:=C190CreaNomeComponente('edtSelezione',Self);
        Css:='width15chr';
        //OnChange:=cmbDecorrenzaChange;
      end;
      //cmbDecorrenza:=TmeIWComboBox(grdNavBar.Cell[0,k].Control);
    end;

    grdNavBar.Cell[0,k].Css:='x';
    grdNavBar.Cell[0,k].Text:='';

    k:=k + 1;
  end;
  AggiornaToolBar(grdNavBar,actlstNavBar);
end;

procedure TWA037FScaricoPaghe.edtDataAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  if TryStrToDate('01/'+edtData.Text,Data) then
  begin
    DataScarico:=Data;
    if DataIndietro > Data then
    begin
      DataIndietro:=Data;
      EdtDataInd.Text:=FormatDateTime('mm/yyyy',DataIndietro);
    end;
  end;
end;

procedure TWA037FScaricoPaghe.edtDataFileAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if tryStrToDate(edtDataFile.Text,DataFile) then
  begin
    DataFile:=R180InizioMese(DataFile);
    DataCassa:=DataFile;
  end;
end;

procedure TWA037FScaricoPaghe.edtDataIndAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  TryStrToDate('01/'+EdtDataInd.Text,DataIndietro);
end;

procedure TWA037FScaricoPaghe.GestioneFileSequenziale;
begin
  if cmbParametri.Text = '' then
  begin
    MsgBox.WebMessageDlg(A000MSG_A037_ERR_NO_PARAMETRIZZAZIONE,mtError,[mbOk],nil,'');
    Exit;
  end;
  //Flag per File Sequenziale / Tabella Oracle
  FileSeq:=WA037FScaricoPagheDM.A037FScaricoPagheMW.selT191.FieldByName('TipoFile').AsString = 'F';
  if FileSeq then
  begin
    //CONTROLLO ESISTENZA DIRECTORY E SUA EVENTUALE CREAZIONE
    Path:=R180GetFilePath(EdtNomeFile.Text,True);
    if Length(Path) > 0 then
    begin
      if not(DirectoryExists(Path)) then
      begin
        if AggiornaT195 then
        begin
          MsgBox.WebMessageDlg(Format(A000MSG_A037_DLG_FMT_CREA_DIR,[Path]),mtConfirmation,[mbYes,mbNo],ResultCreaDirectory,'');
          Exit;
        end
        else //se richiamo da wa074 non posso proporre messaggio
          ResultCreaDirectory(nil,mrYes,'');
      end;
    end;
  end;

  ApriScarico;
end;

procedure TWA037FScaricoPaghe.GestisciNomeFile;
begin
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
  begin
    if CmbParametri.Text <> '' then
    begin
      selT191.Locate('CODICE',CmbParametri.Text,[]);
      FileSeq:=selT191.FieldByName('TipoFile').AsString = 'F';
      if EdtNomeFile.Text <> GetNomeFile(DataScarico,DataFile) then
      begin
        EdtNomeFile.Text:=GetNomeFile(DataScarico,DataFile);
        imbAnomalie.Enabled:=False;
      end;
    end;
  end;
end;

procedure TWA037FScaricoPaghe.getDataCassa(MeseSucc: Boolean);
begin
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
  begin
    //Verifica della registrazione della data di cassa
    if selT199.RecordCount > 0 then
    begin
      DataCassa:=R180InizioMese(selT199.FieldByName('DATA_CASSA').AsDateTime);
      edtUltimaDataCassa.Text:=FormatDateTime('mmmm yyyy',DataCassa);
    end
    else
      with TOracleDataSet.Create(nil) do
      try
        Session:=SessioneOracle;
        SQL.Add('SELECT MAX(DATA_CASSA) FROM T195_VOCIVARIABILI');
        Open;
        if Fields[0].IsNull then
        begin
          DataCassa:=R180InizioMese(Date);
          edtUltimaDataCassa.Text:='';
        end
        else
        begin
          DataCassa:=R180InizioMese(Fields[0].AsDateTime);
          edtUltimaDataCassa.Text:=FormatDateTime('mmmm yyyy',Fields[0].AsDateTime);
        end;
      finally
        Free;
      end;
    if MeseSucc then
    begin
      DataFile:=DataCassa;
      edtDataFile.Text:=FormatDateTime('dd/mm/yyyy',DataFile);
    end;
  end;
end;

function TWA037FScaricoPaghe.VoceAbilitata(Campo:String):Boolean;
var
  CodiciSelezionti,Codice: String;
begin
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
    Result:=selT190.SearchRecord('CodInterno;Flag',VarArrayOf([Campo,'S']),[srFromBeginning]);
  if Result then
  begin
    CodiciSelezionti:=',' + sCodiciInterniSelezionati + ',';
    Codice:=',' + Campo + ',';
    Result:=Pos(Codice,CodiciSelezionti) > 0;
  end;
end;

function TWA037FScaricoPaghe.VoceDisabilitata(Campo:String):Boolean;
var
  CodiciSelezionti,Codice: String;
begin
  CodiciSelezionti:=',' + sFiltroVociSelezionati + ',';
  Codice:=',' + Campo + ',';
  Result:=Pos(Codice,CodiciSelezionti) = 0;
end;

procedure TWA037FScaricoPaghe.GetParametriFunzione;
var
  I: Integer;
begin
  cmbParametri.ItemIndex:=-1;
  cmbParametri.Text:=C004DM.GetParametro('PARPAGHE','');
  GestisciNomeFile;
  edtSel.Text:=C004DM.GetParametro('FILTROVOCI','');
  rgpTipoScrittura.ItemIndex:=StrToInt(C004DM.GetParametro('TIPOSCRITTURA','0'));
end;

procedure TWA037FScaricoPaghe.PutParametriFunzione;
var
  str: String;
begin
  C004DM.Cancella001;

  C004DM.PutParametro('PARPAGHE',cmbParametri.Text);
  C004DM.PutParametro('TIPOSCRITTURA',IntToStr(rgpTipoScrittura.ItemIndex));

  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
  begin
    str:=Trim(edtSel.Text);
    selCountCodiciT196.Close;
    selCountCodiciT196.setVariable('CODICE', str);
    selCountCodiciT196.Open;
    if selCountCodiciT196.FieldByName('NUMREC').AsInteger > 0 then
      C004DM.PutParametro('FILTROVOCI',str);
    selCountCodiciT196.Close;
  end;
  try SessioneOracle.Commit; except end;
end;
//ELABORAZIONE
procedure TWA037FScaricoPaghe.InizioElaborazione;
begin
  inherited;
  WA037FScaricoPagheDM.A037FScaricoPagheMW.InizializzaConteggi;
  Lung:=WA037FScaricoPagheDM.A037FScaricoPagheMW.LeggiParametri;
  EsisteImporto:=WA037FScaricoPagheDM.A037FScaricoPagheMW.VerificaEsisteImporto;
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(DataIndietro),R180FineMese(Data)) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;
  grdC700.selAnagrafe.First;
  //Massimo: assegnazione già fatta nel FormCreate
  //WA037FScaricoPagheDM.A037FScaricoPagheMW.SelAnagrafe:=grdC700.selAnagrafe;

  DipInSer:=TDipendenteInServizio.Create(nil);
  DipInSer.Session:=SessioneOracle;
end;

function TWA037FScaricoPaghe.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

function TWA037FScaricoPaghe.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA037FScaricoPaghe.ElaboraElemento;
begin
  with WA037FScaricoPagheDM.A037FScaricoPagheMW do
    ElaboraDipendente(Data, DataFile, DataIndietro, DataCassa,R180Mese(Data), R180Anno(Data), DipInSer,
                      AggiornaT195,chkConguagli.Checked,EsisteImporto,FileSeq,rgpTipoScrittura.ItemIndex = 1,
                      F);
end;

function TWA037FScaricoPaghe.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.selAnagrafe.Next;
  if not grdC700.selAnagrafe.EOF then
  begin
    Result:=True;
  end;
end;

procedure TWA037FScaricoPaghe.FineCicloElaborazione;
begin
  if AggiornaT195 then
    imbAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);

  getDataCassa(False);
end;

function TWA037FScaricoPaghe.ElaborazioneTerminata: String;
begin
  if imbAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA037FScaricoPaghe.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  if Errore then
    SessioneOracle.Rollback
  else
    SessioneOracle.Commit;

  PutParametriFunzione;
  FreeAndNil(DipInSer);
  WA037FScaricoPagheDM.A037FScaricoPagheMW.DistruggiConteggi;

  if FileSeq and FileAperto then
  begin
    CloseFile(F);
    FileAperto:=False;
  end;
end;

end.
