unit WA166UQuoteIndividuali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA166UQuoteIndividualiDM, WA166UQuoteIndividualiBrowseFM,
  WA166UQuoteIndividualiDettFM, DB, WA166UAcquisizioneFM, A000UInterfaccia;

type
  TWA166FQuoteIndividuali = class(TWR102FGestTabella)
    actAcquisizione: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actAcquisizioneExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    sTipoQuotaAcquisizione: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultAcquisizione(Sender: TWA166FAcquisizioneFM);
  protected
    procedure CambioDataDecorrenza; override;
    procedure CambioDataScadenza; override;
    procedure RefreshPage; override;
  end;

implementation

{$R *.dfm}

procedure TWA166FQuoteIndividuali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA166FQuoteIndividualiDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA166FQuoteIndividualiDM).A166FQuoteIndividualiMW.SelAnagrafe:=grdC700.selAnagrafe;

  WBrowseFM:=TWA166FQuoteIndividualiBrowseFM.Create(Self);
  WDettaglioFM:=TWA166FQuoteIndividualiDettFM.Create(Self);

  CreaTabDefault;
  GetParametriFunzione;
end;

procedure TWA166FQuoteIndividuali.actAcquisizioneExecute(Sender: TObject);
var
  WA166FAcquisizioneFM: TWA166FAcquisizioneFM;
begin
  inherited;
  WA166FAcquisizioneFM:=TWA166FAcquisizioneFM.Create(Self);
  WA166FAcquisizioneFM.cmbTipoQuota.Text:=sTipoQuotaAcquisizione;
  WA166FAcquisizioneFM.ResultEvent:=ResultAcquisizione;
  WA166FAcquisizioneFM.Visualizza;
end;

procedure TWA166FQuoteIndividuali.ResultAcquisizione(Sender: TWA166FAcquisizioneFM);
begin
  sTipoQuotaAcquisizione:=Sender.cmbTipoQuota.Text;
end;

procedure TWA166FQuoteIndividuali.CambioDataDecorrenza;
begin
  inherited;

  with (WR302DM as TWA166FQuoteIndividualiDM) do
  begin
    A166FQuoteIndividualiMW.ImpostaDecorrenzaDatasetLookup;
    A166FQuoteIndividualiMW.ImpostaImportoPenalizzazione;
  end;

  WDettaglioFM.caricaMulticolumncombobox;

  with (WDettaglioFM as TWA166FQuoteIndividualiDettFM) do
  begin
    //l'elenco potrebbe essere cambiato. reimposto text e itemindex
    cmbTipoQuota.RefreshData;
    //Reiumposto per forzare reload del campo lookup
    WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbTipoQuota.Text;
  end;
end;

procedure TWA166FQuoteIndividuali.CambioDataScadenza;
begin
  inherited;
  with (WR302DM as TWA166FQuoteIndividualiDM) do
  begin
    A166FQuoteIndividualiMW.ImpostaImportoPenalizzazione;
  end;
end;

procedure TWA166FQuoteIndividuali.RefreshPage;
begin
  inherited;
  with (WR302DM as TWA166FQuoteIndividualiDM) do
  begin
    if selTabella.State in [dsEdit, dsInsert] then
    begin
      A166FQuoteIndividualiMW.selT765.Refresh;
      (WDettaglioFM as TWA166FQuoteIndividualiDettFM).CaricaComboTipoQuota;
      (WDettaglioFM as TWA166FQuoteIndividualiDettFM).cmbTipoQuota.RefreshData;
    end;
  end;
end;

procedure TWA166FQuoteIndividuali.GetParametriFunzione;
begin
  //parametri di WA166FAcquisizioneFM
  sTipoQuotaAcquisizione:=C004DM.GetParametro('QUOTAACQ','');
end;

procedure TWA166FQuoteIndividuali.PutParametriFunzione;
begin
  C004DM.Cancella001;
  //parametri di WA166FAcquisizioneFM
  C004DM.PutParametro('QUOTAACQ',sTipoQuotaAcquisizione);
  try SessioneOracle.Commit; except end;
end;

procedure TWA166FQuoteIndividuali.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

end.
