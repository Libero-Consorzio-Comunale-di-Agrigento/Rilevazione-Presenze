unit WA164UQuoteIncentivi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA164UQuoteIncentiviDM, WA164UQuoteIncentiviBrowseFM,
  WA164UQuoteIncentiviDettFM, WA164UAggGlobaleFM, A000UInterfaccia, DB;

type
  TWA164FQuoteIncentivi = class(TWR102FGestTabella)
    actAggGlobale: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actAggGlobaleExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    sDecorrenzaAggGlobale, sTipoQuotaAggGlobale: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultAggGlobale(Sender: TWA164FAggGlobaleFM);
  protected
    procedure CambioDataDecorrenza; override;
    procedure AbilitaActListNavBar(Browse: boolean); override;
    procedure RefreshPage; override;
  public
    procedure ReimpostaCampiDecorrenza;
  end;

implementation

{$R *.dfm}

procedure TWA164FQuoteIncentivi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.AllineaSoloDecorrenzeIntersecanti:=True;
  WR302DM:=TWA164FQuoteIncentiviDM.Create(Self);
  WBrowseFM:=TWA164FQuoteIncentiviBrowseFM.Create(Self);
  WDettaglioFM:=TWA164FQuoteIncentiviDettFM.Create(Self);
  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
  GetParametriFunzione;
end;

procedure TWA164FQuoteIncentivi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA164FQuoteIncentivi.AbilitaActListNavBar(Browse: boolean);
begin
  inherited;
  actAggGlobale.Enabled:=Browse;
end;

procedure TWA164FQuoteIncentivi.actAggGlobaleExecute(Sender: TObject);
var
  WA164FAggGlobaleFM: TWA164FAggGlobaleFM;
begin
  inherited;
  WA164FAggGlobaleFM:=TWA164FAggGlobaleFM.Create(Self);

  WA164FAggGlobaleFM.edtDecorrenza.Text:=sDecorrenzaAggGlobale;
  if sDecorrenzaAggGlobale = '' then
    WA164FAggGlobaleFM.edtDecorrenza.Text:=DateToStr(Parametri.DataLavoro);

  WA164FAggGlobaleFM.cmbTipoQuota.Text:=sTipoQuotaAggGlobale;
  WA164FAggGlobaleFM.ResultEvent:=ResultAggGlobale;
  WA164FAggGlobaleFM.Visualizza;
end;

procedure TWA164FQuoteIncentivi.ResultAggGlobale(Sender: TWA164FAggGlobaleFM);
begin
  sDecorrenzaAggGlobale:=Sender.edtDecorrenza.Text;
  sTipoQuotaAggGlobale:=Sender.cmbTipoQuota.Text;
end;

procedure TWA164FQuoteIncentivi.CambioDataDecorrenza;
var
  sTmp: String;
begin
  inherited;

  with (WR302DM as TWA164FQuoteIncentiviDM) do
  begin
    A164FQuoteIncentiviMW.ImpostaDecorrenzaDatasetLookup;
  end;

  WDettaglioFM.caricaMulticolumncombobox;
  with (WDettaglioFM as TWA164FQuoteIncentiviDettFM) do
  begin
    //l'elenco può essere cambiato. reset di text e itemindex
    cmbDato1.RefreshData;
    cmbDato2.RefreshData;
    cmbDato3.RefreshData;
    cmbCodTipoQuota.RefreshData;

    //reimposto campi per forzare reload del campo di lookup
    WR302DM.selTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
    WR302DM.selTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
    WR302DM.selTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;
    WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbCodTipoQuota.Text;

    if Parametri.CampiRiferimento.C7_Dato1 <> '' then
      lblDescDato1.Caption:=WR302DM.selTabella.FieldByName('D_DATO1').AsString;

    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
      lblDescDato2.Caption:=WR302DM.selTabella.FieldByName('D_DATO2').AsString;

    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
      lblDescDato3.Caption:=WR302DM.selTabella.FieldByName('D_DATO3').AsString;

    lblImporto.Caption:=(WR302DM as TWA164FQuoteIncentiviDM).A164FQuoteIncentiviMW.getCaptionImporto;
  end;
end;

procedure TWA164FQuoteIncentivi.RefreshPage;
begin
  inherited;
  with (WR302DM as TWA164FQuoteIncentiviDM) do
  begin
    if selTabella.State in [dsEdit, dsInsert] then
    begin
      A164FQuoteIncentiviMW.selT765.Refresh;
      (WDettaglioFM as TWA164FQuoteIncentiviDettFM).CaricaComboTipoQuota;
      (WDettaglioFM as TWA164FQuoteIncentiviDettFM).cmbCodTipoQuota.RefreshData;
    end;
  end;
end;

procedure TWA164FQuoteIncentivi.ReimpostaCampiDecorrenza;
begin
  CambioDataDecorrenza;
end;

procedure TWA164FQuoteIncentivi.GetParametriFunzione;
{Leggo i parametri della form}
begin
  //parametri di WA164FAggGlobaleFM
  sDecorrenzaAggGlobale:=C004DM.GetParametro('DECORRENZA','');
  sTipoQuotaAggGlobale:=C004DM.GetParametro('QUOTA','');
end;

procedure TWA164FQuoteIncentivi.PutParametriFunzione;
begin
  C004DM.Cancella001;
    //parametri di WA164FAggGlobaleFM

  C004DM.PutParametro('DECORRENZA',sDecorrenzaAggGlobale);
  C004DM.PutParametro('QUOTA',sTipoQuotaAggGlobale);

  try SessioneOracle.Commit; except end;
end;
end.
