unit WA137UCalcoloSpeseAccesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWApplication,
  IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWCompLabel, meIWLabel, IWCompEdit,
  meIWEdit, medpIWMultiColumnComboBox, A137UCalcoloSpeseAccessoMW, WC013UCheckListFM,
  IWCompCheckbox, meIWCheckBox, C180FunzioniGenerali, A000UInterfaccia, medpIWC700NavigatorBar,
  meIWImageFile, medpIWImageButton, A000UMessaggi, medpIWMessageDlg,A000UCostanti,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWRegion, IWDBGrids, medpIWDBGrid, medpIWTabControl, Vcl.Menus;

type
  TWA137FCalcoloSpeseAccesso = class(TWR100FBase)
    WA137ParametriRG: TmeIWRegion;
    LblMeseComp: TmeIWLabel;
    edtMeseComp: TmeIWEdit;
    LblTipoTrasferta: TmeIWLabel;
    cmbTipoTrasferta: TMedpIWMultiColumnComboBox;
    lblPresenzeEscluse: TmeIWLabel;
    edtPresenzeEscluse: TmeIWEdit;
    btnPresenzeEscluse: TmeIWButton;
    chkAggiorna: TmeIWCheckBox;
    imgAnomalie: TmedpIWImageButton;
    TemplateParametriRG: TIWTemplateProcessorHTML;
    WA137RisultatiRG: TmeIWRegion;
    TemplateRisultatiRG: TIWTemplateProcessorHTML;
    grdRisultati: TmedpIWDBGrid;
    grdTabDetail: TmedpIWTabControl;
    pmnGrid: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    imgElaborazione: TmedpIWImageButton;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnPresenzeEscluseClick(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
    procedure grdRisultatiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure imgElaborazioneClick(Sender: TObject);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    A137FCalcoloSpeseAccessoMW:TA137FCalcoloSpeseAccessoMW;
    WC013: TWC013FCheckListFM;
    LstPresenzeSelezionate: TStringList;
    DataComp,DataElaborata: TDateTime;
    SenderName: String;
    RicaricaGridRisultati: Boolean;
    procedure CaricaCombo;
    procedure GetParametriFunzione;
    procedure RimborsiCausali(Sender: TObject; Result: Boolean);
    procedure PutParametriFunzione;
    procedure NascondiCampiTabellaStampa;
  protected
    procedure WC700AperturaSelezione(Sender: Tobject); override;
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    function ElementoSuccessivo: Boolean; override;
    procedure ElaboraElemento; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA137FCalcoloSpeseAccesso.IWAppFormCreate(Sender: TObject);
begin
  grdTabDetail.AggiungiTab('Parametri',WA137ParametriRG);
  grdTabDetail.AggiungiTab('Risultati',WA137RisultatiRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA137ParametriRG;
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.AttivaBrowse:=False;

  AttivaGestioneC700;

  LstPresenzeSelezionate:=TStringList.Create();
  A137FCalcoloSpeseAccessoMW:=TA137FCalcoloSpeseAccessoMW.Create(Self);
  A137FCalcoloSpeseAccessoMW.SelAnagrafe:=grdC700.WC700DM.selAnagrafe;
end;

function TWA137FCalcoloSpeseAccesso.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
  sData: String;
  Data: TDateTime;
begin
  CaricaCombo;

  GetParametriFunzione;

  edtMeseComp.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  DataComp:=StrToDate('01/' + edtMeseComp.Text);
  DataElaborata:=DataComp;
  //Disabilito anomalie
  imgAnomalie.Enabled:=False;

  RicaricaGridRisultati:=False;
  A137FCalcoloSpeseAccessoMW.CreaTabellaStampa;
  NascondiCampiTabellaStampa;
  grdRisultati.medpPaginazione:=True;
  grdRisultati.medpRighePagina:=18;

  grdRisultati.medpAttivaGrid(A137FCalcoloSpeseAccessoMW.TabellaStampa,False,False);

  Result:=True;
end;

procedure TWA137FCalcoloSpeseAccesso.ImpostazioniWC700;
begin
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWA137FCalcoloSpeseAccesso.WC700AperturaSelezione(Sender: Tobject);
begin
  if TryStrToDate('01/' + edtMeseComp.Text,DataComp) then
  begin
    grdC700.WC700FM.C700DataDal:=R180InizioMese(DataComp);
    grdC700.WC700FM.C700DataLavoro:=R180FineMese(DataComp);
  end;
end;

procedure TWA137FCalcoloSpeseAccesso.imgAnomalieClick(Sender: TObject);
var Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';
  accediForm(201,Params,True);
end;

procedure TWA137FCalcoloSpeseAccesso.imgElaborazioneClick(Sender: TObject);
begin
  inherited;
  if cmbTipoTrasferta.ItemIndex = -1 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A117_ERR_NO_TIPOLOGIA,mtInformation,[mbOK],nil,'');
    Exit;
  end;

  if grdC700.WC700DM.SelAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtInformation,[mbOK],nil,'');
    Exit;
  end;

  if not TryStrToDate('01/' + edtMeseComp.Text,dataComp) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA,mtInformation,[mbOK],nil,'');
    Exit;
  end;

  //Disabilito anomalie
  imgAnomalie.Enabled:=False;
  SenderName:=TmedpIWImageButton(Sender).HTMLName;

  StartElaborazioneCiclo(SenderName);
end;

procedure TWA137FCalcoloSpeseAccesso.actScaricaInCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdRisultati.ToCsv
  else
    InviaFile('SpeseAccesso_' +
              FormatDateTime('dd_mm_yyyy',R180InizioMese(DataElaborata)) + '_' +
              FormatDateTime('dd_mm_yyyy',R180FineMese(DataElaborata))+ '.xls',csvDownload);
end;

procedure TWA137FCalcoloSpeseAccesso.actScaricaInExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdRisultati.ToXlsx
  else
    InviaFile('SpeseAccesso_' +
              FormatDateTime('dd_mm_yyyy',R180InizioMese(DataElaborata)) + '_' +
              FormatDateTime('dd_mm_yyyy',R180FineMese(DataElaborata))+ '.xlsx',streamDownload);
end;

procedure TWA137FCalcoloSpeseAccesso.btnPresenzeEscluseClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with A137FCalcoloSpeseAccessoMW do
  begin
    WC013.CaricaLista(lstDescPresenze, lstCodPresenze);
    WC013.ImpostaValoriSelezionati(LstPresenzeSelezionate);
    WC013.ResultEvent:=RimborsiCausali;
    WC013.Visualizza(0,0,'<WC013> Codici Causali');
  end;
end;

procedure TWA137FCalcoloSpeseAccesso.RimborsiCausali(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    LstPresenzeSelezionate.Clear;
    LstPresenzeSelezionate.Assign(lstTmp);
    edtPresenzeEscluse.Text:=LstPresenzeSelezionate.CommaText;
    FreeAndNil(lstTmp);
  end;
end;

procedure TWA137FCalcoloSpeseAccesso.CaricaCombo;
begin
  cmbTipoTrasferta.Items.Clear;
  with A137FCalcoloSpeseAccessoMW do
  begin
    selM010.First;
    while not selM010.Eof do
    begin
      cmbTipoTrasferta.AddRow(selM010.FieldByName('TIPO_MISSIONE').AsString + ';' +
                              selM010.FieldByName('DESCRIZIONE').AsString);
      selM010.Next;
    end;
  end;
end;

procedure TWA137FCalcoloSpeseAccesso.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(A137FCalcoloSpeseAccessoMW);
  FreeAndNil(LstPresenzeSelezionate);
  inherited;
end;

procedure TWA137FCalcoloSpeseAccesso.GetParametriFunzione;
begin
  cmbTipoTrasferta.Text:=C004DM.GetParametro('TIPOTRASFERTA','');
  LstPresenzeSelezionate.CommaText:=C004DM.GetParametro('PRESENZEESCLUSE','');
  edtPresenzeEscluse.Text:=LstPresenzeSelezionate.CommaText;
end;

procedure TWA137FCalcoloSpeseAccesso.grdRisultatiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TWA137FCalcoloSpeseAccesso.grdTabDetailTabControlChange(
  Sender: TObject);
begin
  inherited;

  if (grdTabDetail.ActiveTab = WA137RisultatiRG) and (RicaricaGridRisultati) then
  begin
    grdRisultati.medpAggiornaCDS(True);
  end;
end;

procedure TWA137FCalcoloSpeseAccesso.PutParametriFunzione;
begin
  C004DM.Cancella001;

  C004DM.PutParametro('TIPOTRASFERTA',cmbTipoTrasferta.Text);
  C004DM.PutParametro('PRESENZEESCLUSE',LstPresenzeSelezionate.CommaText);

  try SessioneOracle.Commit; except end;
end;

//ELABORAZIONE
procedure TWA137FCalcoloSpeseAccesso.InizioElaborazione;
begin
  inherited;
  A137FCalcoloSpeseAccessoMW.TrovateAnomalie:=False;
  DataElaborata:=DataComp;
  //Preparazione
  A137FCalcoloSpeseAccessoMW.CreaTabellaStampa;
  NascondiCampiTabellaStampa;
  RicaricaGridRisultati:=True;
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(DataComp),R180FineMese(DataComp)) then
    grdC700.SelAnagrafe.CloseAll;
  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;
end;

procedure TWA137FCalcoloSpeseAccesso.NascondiCampiTabellaStampa;
begin
  with A137FCalcoloSpeseAccessoMW.TabellaStampa do
  begin
    FieldByName('PROGRESSIVO').Visible:=False;
    FieldByName('COGNOME').Visible:=False;
    FieldByName('NOME').Visible:=False;
  end;
end;

function TWA137FCalcoloSpeseAccesso.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecNO;
end;

function TWA137FCalcoloSpeseAccesso.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecordCount;
end;

procedure TWA137FCalcoloSpeseAccesso.ElaboraElemento;
begin
  inherited;
  A137FCalcoloSpeseAccessoMW.ElaboraElemento(DataComp,grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,LstPresenzeSelezionate.CommaText);
  SessioneOracle.Commit;
end;

function TWA137FCalcoloSpeseAccesso.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.SelAnagrafe.Next;
  if not grdC700.SelAnagrafe.EOF then
    Result:=True;
end;

procedure TWA137FCalcoloSpeseAccesso.FineCicloElaborazione;
begin
  if chkAggiorna.Checked then
    A137FCalcoloSpeseAccessoMW.RegistraMese(DataComp,cmbTipoTrasferta.Text);
  //Caratto Non chiudere Tabella stampa altrimenti errore in caricamento grid
  //A137FCalcoloSpeseAccessoMW.TabellaStampa.Close;
  imgAnomalie.Enabled:=A137FCalcoloSpeseAccessoMW.TrovateAnomalie;
  PutParametriFunzione;
end;

function TWA137FCalcoloSpeseAccesso.ElaborazioneTerminata: String;
begin
  if imgAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

end.
