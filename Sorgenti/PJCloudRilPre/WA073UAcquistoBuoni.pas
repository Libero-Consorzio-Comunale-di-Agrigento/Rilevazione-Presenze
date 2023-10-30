unit WA073UAcquistoBuoni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, WA073UControlloFM, meIWImageFile, medpIWImageButton, WR100UBase,
  System.Actions, Oracle, IWCompEdit, meIWEdit, WA073UImportazioneAcquistiExcelFM;

type
  TWA073FAcquistoBuoni = class(TWR102FGestTabella)
    imbInterrogazioniServizio: TmedpIWImageButton;
    imbMagazzinoBuoni: TmedpIWImageButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure imbMagazzinoBuoniClick(Sender: TObject);
  private
    WA073FControlloFM:TWA073FControlloFM;
    WA073FImportazioneAcquistiExcelFM:TWA073FImportazioneAcquistiExcelFM; //dichiaro il tipo
    procedure grdTabControlTabControlChanging(Sender: TObject;var AllowChange: Boolean);
  public
    { Public declarations }
  protected
    procedure ImpostazioniWC700; override;
  end;

implementation

uses WA073UAcquistoBuoniDM, WA073UAcquistoBuoniBrowseFM, WC700USelezioneAnagrafeFM;

{$R *.dfm}

procedure TWA073FAcquistoBuoni.imbMagazzinoBuoniClick(Sender: TObject);
begin
  TWR100FBase(Self).AccediForm(TmedpIWImageButton(Sender).Tag);
end;

procedure TWA073FAcquistoBuoni.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ', T030.CODFISCALE';
end;

procedure TWA073FAcquistoBuoni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;

  WR302DM:=TWA073FAcquistoBuoniDM.Create(Self);

  AttivaGestioneC700;
  WBrowseFM:=TWA073FAcquistoBuoniBrowseFM.Create(Self);
  TWA073FAcquistoBuoniDM(WR302DM).A073MW.R350FCalcoloBuoniDtM.selAnagrafe:=grdC700.selAnagrafe;
  TWA073FAcquistoBuoniDM(WR302DM).A073MW.SelAnagrafe:=grdC700.selAnagrafe;
  WA073FControlloFM:=TWA073FControlloFM.Create(Self);
  WA073FImportazioneAcquistiExcelFM:=TWA073FImportazioneAcquistiExcelFM.Create(Self);   //istanzio l'oggetto frame
  CreaTabDefault;
  grdTabControl.AggiungiTab('Riepilogo buoni pasto/Ticket',WA073FControlloFM);
  grdTabControl.AggiungiTab('Importazione acquisti da file excel',WA073FImportazioneAcquistiExcelFM);
  grdTabControl.ActiveTab:=WBrowseFM;
  grdTabControl.OnTabControlChanging:=grdTabControlTabControlChanging;
end;

procedure TWA073FAcquistoBuoni.grdTabControlTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  if grdTabControl.ActiveTab = WBrowseFM then
  begin
    WA073FControlloFM.InizializzaDate;
    //Massimo abbinamento già fatto nel FOrmCreate
    //TWA073FAcquistoBuoniDM(WR302DM).A073MW.R350FCalcoloBuoniDtM.selAnagrafe:=grdC700.selAnagrafe;
    //TWA073FAcquistoBuoniDM(WR302DM).A073MW.SelAnagrafe:=grdC700.selAnagrafe;
  end;
end;

end.
