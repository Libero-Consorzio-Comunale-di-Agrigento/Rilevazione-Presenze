unit WA023URipristinoTimbOrigFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompEdit, meIWEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, WR100UBase,
  IWCompCheckbox, meIWCheckBox, IWCompButton, meIWButton, IWCompGrids,
  IWDBGrids, medpIWDBGrid, C180FunzioniGenerali, C190FunzioniGeneraliWeb, A000UInterfaccia,
  A000UMessaggi, medpIWMessagedlg, IWApplication;

type
  TWA023RipristinoModalResultEvents = procedure(Sender: TObject; Result: Boolean) of object;

  TWA023FRipristinoTimbOrigFM = class(TWR200FBaseFM)
    lblPeriodo: TmeIWLabel;
    lblMese: TmeIWLabel;
    edtDa: TmeIWEdit;
    edtA: TmeIWEdit;
    lblDa: TmeIWLabel;
    lblA: TmeIWLabel;
    lblOperazioni: TmeIWLabel;
    chkRipristinaOrig: TmeIWCheckBox;
    chkCancManuali: TmeIWCheckBox;
    chkCancIterWeb: TmeIWCheckBox;
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    lblLegenda: TmeIWLabel;
    lblFlagI: TmeIWLabel;
    lblFlagM: TmeIWLabel;
    lblFlagC: TmeIWLabel;
    lblFlagO: TmeIWLabel;
    grdAttuale: TmedpIWDBGrid;
    grdSimulazione: TmedpIWDBGrid;
    btnAggiornaTabella: TmeIWButton;
    lblSituazioneAttuale: TmeIWLabel;
    lblSituazioneRipristinata: TmeIWLabel;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure chkRipristinaOrigClick(Sender: TObject);
    procedure edtDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnAggiornaTabellaClick(Sender: TObject);
    procedure edtAAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    DataInizio, DataFine: TDateTime;
    function EsistonoOperazioniSelezionate: Boolean;
  public
    ResultEvent:TWA023RipristinoModalResultEvents;
    procedure Visualizza;
    procedure CaricaDatiIniziali(Inizio: TDateTime);
  end;

implementation
uses WA023UTimbrature,A023UTimbratureMW;

{$R *.dfm}

{ TWA023FRipristinoTimbOrigFM }

procedure TWA023FRipristinoTimbOrigFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    CreaDataSetSimulazione;
  end;
end;

procedure TWA023FRipristinoTimbOrigFM.CaricaDatiIniziali(Inizio: TDateTime);
begin
  DataInizio:=Inizio;
  DataFine:=DataInizio;

  lblMese.Caption:=R180Capitalize(FormatDateTime('mmmm yyyy',DataInizio));
  edtDa.Text:=IntToStr(R180Giorno(DataInizio));
  edtA.Text:=IntToStr(R180Giorno(DataInizio));

  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    AggiornaTabella(DataInizio, DataFine, EsistonoOperazioniSelezionate, chkRipristinaOrig.Checked, chkCancManuali.Checked, chkCancIterWeb.Checked);

    grdAttuale.medpAttivaGrid(dscT100Ripristino.DataSet,False,False,False);
    grdSimulazione.medpAttivaGrid(dscT100RiprSim.DataSet,False,False,False);
  end;
end;

procedure TWA023FRipristinoTimbOrigFM.Visualizza;
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,725,445,445, 'Ripristino timbrature originali','#wa023ripristino_container',False,True);
end;

function TWA023FRipristinoTimbOrigFM.EsistonoOperazioniSelezionate: Boolean;
// determina se sono selezionate operazioni di simulazione
// restituisce
// - True:  se almeno un'operazione è selezionata
// - False: se nessuna operazione è selezionata
begin
  Result:=(chkRipristinaOrig.Checked) or (chkCancManuali.Checked) or (chkCancIterWeb.Checked);
end;

procedure TWA023FRipristinoTimbOrigFM.grdRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not C190RenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;
end;

procedure TWA023FRipristinoTimbOrigFM.btnAggiornaTabellaClick(Sender: TObject);
begin
  // aggiorna visualizzazione
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
    AggiornaTabella(DataInizio, DataFine, EsistonoOperazioniSelezionate, chkRipristinaOrig.Checked, chkCancManuali.Checked, chkCancIterWeb.Checked);
  grdAttuale.medpAggiornaCDS(True);
  grdSimulazione.medpAggiornaCDS(True);
end;

procedure TWA023FRipristinoTimbOrigFM.chkRipristinaOrigClick(Sender: TObject);
begin
  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
    SimulaRipristino(chkRipristinaOrig.Checked,chkCancManuali.checked,chkCancIterWeb.Checked);
  grdAttuale.medpAggiornaCDS(True);
  grdSimulazione.medpAggiornaCDS(True);
end;

procedure TWA023FRipristinoTimbOrigFM.edtAAsyncChange(Sender: TObject;
  EventParams: TStringList);
var Giorno, Mese, Anno: word;
begin
  DecodeDate(DataFine,Anno,Mese,Giorno);
  try
    DataFine:=EncodeDate(Anno,Mese,StrToInt(edtA.Text));
  except
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_ERR_DATA_ERRATA);
    Exit;
  end;
   // mantiene coerente il periodo
  if DataFine < DataInizio then
  begin
    DataInizio:=DataFine;
    edtA.Text:=edtDa.Text;
  end;

  //Devo forzare un submit perchè la griglia non si carica in async
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnAggiornaTabella.HTMLName]));
end;

procedure TWA023FRipristinoTimbOrigFM.edtDaAsyncChange(Sender: TObject;
  EventParams: TStringList);
var Giorno, Mese, Anno: word;
begin
  DecodeDate(DataInizio,Anno,Mese,Giorno);
  try
    DataInizio:=EncodeDate(Anno,Mese,StrToInt(edtDa.Text));
  except
    MsgBox.webMessageDlg(A000MSG_ERR_DATA_ERRATA,mtError,[mbOk],nil,'');
    Exit;
  end;

   // mantiene coerente il periodo
  if DataInizio > DataFine then
  begin
    DataFine:=DataInizio;
    edtA.Text:=edtDa.Text;
  end;

  //Devo forzare un submit perchè la griglia non si carica in async
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnAggiornaTabella.HTMLName]));
end;

procedure TWA023FRipristinoTimbOrigFM.btnChiudiClick(Sender: TObject);
var Res: Boolean;
begin
  inherited;

  with (Self.Parent as TWA023FTimbrature).WA023FTimbratureDM.A023FTimbratureMW do
  begin
    Res:=Sender = btnConferma;
    if Res then
    begin
      if EsistonoOperazioniSelezionate then
        EseguiRipristino(DataInizio,DataFine,chkRipristinaOrig.Checked,chkCancManuali.checked,chkCancIterWeb.Checked);
    end;

    cdsT100RiprSim.Close;
    selT100Ripristino.CloseAll;
  end;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Res);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  ReleaseOggetti;
  Free;
end;

end.
