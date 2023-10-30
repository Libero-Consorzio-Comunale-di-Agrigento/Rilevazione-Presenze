unit WA110UParametriConteggio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR103UGestMasterDetail, ActnList, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink,WA110UParametriConteggioDM, WA110UParametriConteggioBrowseFM,
  WA110UParametriConteggioDettFM, WA110USoglieRimborsiPastoFM, WA110UTipiMissioneFM,
  WR200UBaseFM, System.Actions,DB, IWCompEdit, meIWEdit;

type
  TWA110FParametriConteggio = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  protected
    procedure CambioDataDecorrenza; override;
    procedure RefreshPage; override;
  public
    WA110FSoglieRimborsiPastoFM: TWA110FSoglieRimborsiPastoFM;
    WA110FTipiMissioneFM: TWA110FTipiMissioneFM;
    procedure AbilitazioneTabScaglioni(Abil: Boolean);
  end;

implementation

{$R *.dfm}

procedure TWA110FParametriConteggio.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  DisabilitaFigliInModifica:=False;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA110FParametriConteggioDM.Create(Self);

  WBrowseFM:=TWA110FParametriConteggioBrowseFM.Create(Self);
  WDettaglioFM:=TWA110FParametriConteggioDettFM.Create(Self);

  WA110FSoglieRimborsiPastoFM:=TWA110FSoglieRimborsiPastoFM.Create(Self);
  AggiungiDetail(WA110FSoglieRimborsiPastoFM);
  WA110FSoglieRimborsiPastoFM.CaricaDettaglio(TWA110FParametriConteggioDM(WR302DM).A110FParametriConteggioMW.selM013_2,TWA110FParametriConteggioDM(WR302DM).A110FParametriConteggioMW.dsrM013_2);

  WA110FTipiMissioneFM:=TWA110FTipiMissioneFM.Create(Self);
  AggiungiDetail(WA110FTipiMissioneFM);
  WA110FTipiMissioneFM.CaricaDettaglio(TWA110FParametriConteggioDM(WR302DM).A110FParametriConteggioMW.selM011,TWA110FParametriConteggioDM(WR302DM).A110FParametriConteggioMW.dsrM011);

  CreaTabDefault;

  grdTabControl.AggiungiTab('Soglie rimborsi pasto',WA110FSoglieRimborsiPastoFM);

  grdTabControl.AggiungiTab('Tipi missione',WA110FTipiMissioneFM);
  //Non deve essere presente grdDetailTabControl. I Pannelli sono inseriti nel grdTabControl principale
  //e non usati come detail classici
  grdDetailTabControl.EliminaTab(1);
  grdDetailTabControl.EliminaTab(0);
  grdDetailTabControl.Visible:=False;
  WDettaglioFM.DataSet2Componenti;

  grdTabControl.ActiveTab:=WBrowseFM;
end;

procedure TWA110FParametriConteggio.RefreshPage;
begin
  inherited;
  with (WR302DM as TWA110FParametriConteggioDM) do
  begin
    A110FParametriConteggioMW.selP050.Refresh;
    if selTabella.State in [dsEdit,dsInsert] then
     (WDettaglioFM as TWA110FParametriConteggioDettFM).CaricaCmbArr;
    //refresh liste
    A110FParametriConteggioMW.CaricaListe;
  end;
end;

procedure TWA110FParametriConteggio.AbilitazioneTabScaglioni(Abil: Boolean);
begin
  //Abilito/disabilito il tab per modifica deglio scaglioni pasto
  if (WDettaglioFM <> nil) and (not Abil) and (grdTabControl.ActiveTab = WA110FSoglieRimborsiPastoFM) then
  begin
    //il tab attivo è quello degli scaglioni pasto ma deve essere disabilitato.
    //mi sposto su dettaglio
    grdTabControl.ActiveTab:=WDettaglioFM;
  end;
  if grdTabControl.Tabs[WA110FSoglieRimborsiPastoFM] <> nil then
  begin
    grdTabControl.Tabs[WA110FSoglieRimborsiPastoFM].Enabled:=Abil;
  end;
end;

procedure TWA110FParametriConteggio.CambioDataDecorrenza;
begin
  inherited;
  //Il cambio di decorrenza cambia Q050 e Q030
  //devo ricare la combo cmbArrTotaleImportiPerDatiPaghe che viene caricata con Q050
  (WDettaglioFM as TWA110FParametriConteggioDettFM).CaricaCmbArr;
end;

procedure TWA110FParametriConteggio.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(WA110FSoglieRimborsiPastoFM);
  FreeAndNil(WA110FTipiMissioneFM);
  inherited;
end;

end.
