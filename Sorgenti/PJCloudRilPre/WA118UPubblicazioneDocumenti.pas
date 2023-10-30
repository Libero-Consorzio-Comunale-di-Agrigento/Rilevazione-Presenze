unit WA118UPubblicazioneDocumenti;

interface

uses
  WA118ULivelliFM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, Data.DB, Oracle;

type
  TWA118FPubblicazioneDocumenti = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    FDetail: TWA118FLivelliFM;
  public
    function InizializzaAccesso: Boolean; override;
    procedure selTabellaStateChange(DataSet: TDataSet); override;
    procedure OnI200AfterSCroll;
    procedure OnI201AfterSCroll;
    property LivelliFM: TWA118FLivelliFM read FDetail;
  end;

implementation

uses
  WA118UPubblicazioneDocumentiDM,
  WA118UPubblicazioneDocumentiBrowseFM,
  WA118UPubblicazioneDocumentiDettFM;

{$R *.dfm}

{ TWA118FPubblicazioneDocumenti }

function TWA118FPubblicazioneDocumenti.InizializzaAccesso: Boolean;
begin
  Result:=True;
end;

procedure TWA118FPubblicazioneDocumenti.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  // nasconde l'azione di "copia su"
  actCopiaSu.Visible:=False;

  WR302DM:=TWA118FPubblicazioneDocumentiDM.Create(Self);
  WBrowseFM:=TWA118FPubblicazioneDocumentiBrowseFM.Create(Self);
  WDettaglioFM:=TWA118FPubblicazioneDocumentiDettFM.Create(Self);

  FDetail:=TWA118FLivelliFM.Create(Self);
  AggiungiDetail(FDetail);
  FDetail.CaricaDettaglio(TWA118FPubblicazioneDocumentiDM(WR302DM).selI201,TWA118FPubblicazioneDocumentiDM(WR302DM).dsrI201);
  TWA118FLivelliFM(FDetail).OnI201AfterScroll;

  CreaTabDefault;

  WR302DM.selTabella.First;
end;

procedure TWA118FPubblicazioneDocumenti.OnI200AfterSCroll;
begin
  if (WR302DM = nil) or
     (WR302DM.selTabella = nil) then
    Exit;

  // visualizza dati in base alla sorgente dei documenti
  if Assigned(WDettaglioFM) then
  begin
    TWA118FPubblicazioneDocumentiDettFM(WDettaglioFM).btnCheckFiltro.Enabled:=WR302DM.selTabella.FieldByName('FILTRO').AsString <> '';
    TWA118FPubblicazioneDocumentiDettFM(WDettaglioFM).ImpostaPannelloInfoSorgente;
  end;
end;

procedure TWA118FPubblicazioneDocumenti.OnI201AfterSCroll;
begin
  // gestore dell'evento sul frame di dettaglio livelli
  if Assigned(FDetail) then
    FDetail.OnI201AfterSCroll;
end;

procedure TWA118FPubblicazioneDocumenti.selTabellaStateChange(DataSet: TDataSet);
var
  LBrowse: Boolean;
begin
  inherited;

  if Assigned(FDetail) then
  begin
    LBrowse:=not (DataSet.State in [dsInsert,dsEdit]);
    AbilitaToolbar(FDetail.grdCampiNavBar,LBrowse,FDetail.actlstCampiNavBar);
    FDetail.grdCampi.medpBrowse:=LBrowse;
  end;
end;

end.
