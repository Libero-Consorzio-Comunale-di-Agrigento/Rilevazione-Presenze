unit WA162UIncentiviAssenze;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA162UIncentiviAssenzeDM, WA162UIncentiviAssenzeBrowseFM,
  WA162UIncentiviAssenzeDettFM, A000UInterfaccia, medpIWMultiColumnComboBox,DB,
  A000UMessaggi, WC009UCopiaSuFM, WC020UInputDataOreFM, medpIWMessageDlg, meIWEdit;

type
  TWA162FIncentiviAssenze = class(TWR102FGestTabella)
    btnCambioData: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    procedure ResultInputCopiaSu(Sender:TObject; Result:Boolean; Valore:String);
  protected
    procedure CambioDataDecorrenza; override;
    procedure CambioDataScadenza; override;
    procedure RefreshPage; override;
  end;

implementation

{$R *.dfm}

procedure TWA162FIncentiviAssenze.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  WR302DM:=TWA162FIncentiviAssenzeDM.Create(Self);
  WBrowseFM:=TWA162FIncentiviAssenzeBrowseFM.Create(Self);
  WDettaglioFM:=TWA162FIncentiviAssenzeDettFM.Create(Self);
  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
end;

procedure TWA162FIncentiviAssenze.IWAppFormRender(Sender: TObject);
begin
  with (WR302DM as TWA162FIncentiviAssenzeDM),(WDettaglioFM as TWA162FIncentiviAssenzeDettFM) do
    if (SelTabella.State = dsBrowse) and (SelTabella.FieldByName('CODTIPOQUOTA').AsString = '*') then
      cmbCodTipoQuota.medpContextMenu:=pmnCodTipoQuota
    else
      cmbCodTipoQuota.medpContextMenu:=nil;
  inherited;
end;

procedure TWA162FIncentiviAssenze.RefreshPage;
begin
  inherited;
  with (WR302DM as TWA162FIncentiviAssenzeDM) do
  begin
    if selTabella.State in [dsEdit, dsInsert] then
    begin
      A162FIncentiviAssenzeMW.selT766.Refresh;
      (WDettaglioFM as TWA162FIncentiviAssenzeDettFM).CaricaComboTipoAbbattimento;
      (WDettaglioFM as TWA162FIncentiviAssenzeDettFM).cmbTipoAbbattimento.RefreshData;

      A162FIncentiviAssenzeMW.selT255.Refresh;
      (WDettaglioFM as TWA162FIncentiviAssenzeDettFM).CaricaComboTipoAccorpCausali;
      (WDettaglioFM as TWA162FIncentiviAssenzeDettFM).cmbTipoAccorpCausali.RefreshData;

      A162FIncentiviAssenzeMW.selT256.Refresh;
      (WDettaglioFM as TWA162FIncentiviAssenzeDettFM).CaricaComboCodiciAccorpCausali;
      (WDettaglioFM as TWA162FIncentiviAssenzeDettFM).cmbCodiciAccorpCausali.RefreshData;
    end;
  end;
end;

procedure TWA162FIncentiviAssenze.actCopiaSuExecute(Sender: TObject);
var WC020FInputBoxFM: TWC020FInputDataOreFM;
begin
  WC020FInputBoxFM:=TWC020FInputDataOreFM.Create(Self);
  WC020FInputBoxFM.ImpostaCampiText('Indicare il nuovo codice quota:','');
  WC020FInputBoxFM.ResultEvent:=ResultInputCopiaSu;
  WC020FInputBoxFM.Visualizza('Nuovo codice quota');
end;

procedure TWA162FIncentiviAssenze.ResultInputCopiaSu(Sender:TObject; Result:Boolean; Valore:String);
var i:Integer;
begin
  if Result then
  begin
    if (Trim(Valore) = '')
    or (Valore = '*')
    or (VarToStr((WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW.selT765.Lookup('CODICE',Valore,'CODICE')) = '') then
    begin
      MsgBox.WebMessageDlg(A000MSG_A162_ERR_CODTIPOQUOTA,mtError,[mbOk],nil,'');
      Exit;
    end;
    with TWC009FCopiaSuFM.Create(Self) do
    try
      Storicizzazione:=False;
      ODS:=WR302DM.selTabella;
      CopiaSuTabella:=InterfacciaWR102.CopiaSuTabella;
      CopiaSuChiave:=InterfacciaWR102.CopiaSuChiave;
      CopiaSuChiaveInput:=InterfacciaWR102.CopiaSuChiaveInput;
      CopiaSuCampi:=InterfacciaWR102.CopiaSuCampi;
      if Length(InterfacciaWR102.TabelleRelazionate) > 0 then
        SetODS(InterfacciaWR102.TabelleRelazionate)
      else
        SetODS([ODS]);
      Visualizza;
      for i:=0 to grdChiaveElemento.RowCount - 1 do
        if grdChiaveElemento.Cell[i,0].Text = (WR302DM as TWA162FIncentiviAssenzeDM).selTabella.FieldByName('CODTIPOQUOTA').DisplayLabel then
          if grdChiaveElemento.Cell[i,1].Control <> nil then
            TmeIWEdit(grdChiaveElemento.Cell[i,1].Control).Text:=Valore;
      btnEseguiClick(nil);
    except
      Free;
    end;
  end;
end;

procedure TWA162FIncentiviAssenze.CambioDataDecorrenza;
begin
  inherited;

  with (WR302DM as TWA162FIncentiviAssenzeDM) do
    A162FIncentiviAssenzeMW.ImpostaDecorrenzaDatasetLookup;

  WDettaglioFM.CaricaMultiColumnCombobox;
  with (WDettaglioFM as TWA162FIncentiviAssenzeDettFM) do
  begin
    //l'elenco può essere cambiato. reset di text e itemindex
    cmbDato1.RefreshData;
    cmbDato2.RefreshData;
    cmbDato3.RefreshData;

    //reimposto campi per forzare reload del campo di lookup

    WR302DM.selTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
    WR302DM.selTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
    WR302DM.selTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;

    if Parametri.CampiRiferimento.C7_Dato1 <> '' then
      lblDescDato1.Caption:=WR302DM.selTabella.FieldByName('D_DATO1').AsString;

    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
      lblDescDato2.Caption:=WR302DM.selTabella.FieldByName('D_DATO2').AsString;

    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
      lblDescDato3.Caption:=WR302DM.selTabella.FieldByName('D_DATO3').AsString;
  end;
end;

procedure TWA162FIncentiviAssenze.CambioDataScadenza;
begin
  inherited;
  (WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW.ImpostaDecorrenzaFineDatasetLookup;
  WDettaglioFM.CaricaMultiColumnCombobox;
  with (WDettaglioFM as TWA162FIncentiviAssenzeDettFM) do
  begin
    //l'elenco può essere cambiato. reset di text e itemindex
    cmbCodTipoQuota.RefreshData;
    //reimposto campi per forzare reload del campo di lookup
    WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbCodTipoQuota.Text;
    lblDescTipoQuota.Caption:=WR302DM.selTabella.FieldByName('D_TIPOQUOTA').AsString;
  end;
end;

end.
