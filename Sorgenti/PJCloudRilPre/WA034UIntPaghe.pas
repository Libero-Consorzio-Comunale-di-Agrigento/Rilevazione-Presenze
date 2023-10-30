unit WA034UIntPaghe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, A000UInterfaccia, A000UMessaggi,
  WA034UIntPagheDM, WA034UIntPagheBrowseFM, medpIWMessageDlg, WC007UFormContainerFM,
  WA034UParametriAvanzati, IWApplication, System.Actions, meIWImageFile;

type
  TWA034FIntPaghe = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure ResultEliminaInterfaccia(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  private
    WC007FM:TWC007FFormContainerFM;
    WA034FParametriAvanzati: TWA034FParametriAvanzati;
    procedure ParametriAvanzatiResultEvent(Sender: TObject);
  public
    procedure ParametriAvanzati;
  end;


implementation

{$R *.dfm}

procedure TWA034FIntPaghe.IWAppFormCreate(Sender: TObject);
begin
  actNuovo.Visible:=False;
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA034FIntPagheDM.Create(Self);
  WBrowseFM:=TWA034FIntPagheBrowseFM.Create(Self);

  with TWA034FIntPagheDM(WR302DM).A034FIntPagheMW.selC9ScaricoPaghe do
    if FieldByName('CODICE').AsString = '<INTERFACCIA UNICA>' then
    begin
      actCopiaSu.Visible:=False;
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    end;

  CreaTabDefault;
 end;

procedure TWA034FIntPaghe.actEliminaExecute(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_A034_DLG_ELIMINA_INTERFACCIA,mtConfirmation,[mbYes,mbNo],ResultEliminaInterfaccia,'');
end;

procedure TWA034FIntPaghe.ResultEliminaInterfaccia(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    TWA034FIntPagheDM(WR302DM).A034FIntPagheMW.EliminaInterfaccia;
    WBrowseFM.grdTabella.medpAggiornaCDS;
    AggiornaRecord;
  end;
end;

procedure TWA034FIntPaghe.ParametriAvanzati;
begin
  WC007FM:=TWC007FFormContainerFM.Create(Self);
  WC007FM.TemplateProcessor.Templates.Default:='WA034FParametriAvanzatiFM.html';

  WC007FM.ResultEvent:=ParametriAvanzatiResultEvent;

  WA034FParametriAvanzati:=TWA034FParametriAvanzati.Create(GGetWebApplicationThreadVar,False);
  WA034FParametriAvanzati.ImpostaCodiceInterfaccia(TWA034FIntPagheDM(WR302DM).A034FIntPagheMW.selC9ScaricoPaghe.FieldByName('CODICE').AsString );

  WA034FParametriAvanzati.grdNavigatorBar.Parent:=WC007FM.IWFrameRegion;
  WA034FParametriAvanzati.grdToolBarStorico.Parent:=WC007FM.IWFrameRegion;
  WA034FParametriAvanzati.WDettaglioFM.Parent:=WC007FM.IWFrameRegion;
  WA034FParametriAvanzati.WBrowseFM.Parent:=WC007FM.IWFrameRegion;
  WA034FParametriAvanzati.grdTabControl.Parent:=WC007FM.IWFrameRegion;
  WC007FM.PopupWidth:=870;
  WC007FM.Visualizza('Parametri avanzati');
 end;

procedure TWA034FIntPaghe.ParametriAvanzatiResultEvent(Sender: TObject);
begin
  if WA034FParametriAvanzati <> nil then
  begin
    WA034FParametriAvanzati.grdNavigatorBar.Parent:=WA034FParametriAvanzati;
    WA034FParametriAvanzati.grdToolBarStorico.Parent:=WA034FParametriAvanzati;
    WA034FParametriAvanzati.WDettaglioFM.Parent:=WA034FParametriAvanzati;
    WA034FParametriAvanzati.WBrowseFM.Parent:=WA034FParametriAvanzati;
    WA034FParametriAvanzati.grdTabControl.Parent:=WA034FParametriAvanzati;
    FreeAndNil(WA034FParametriAvanzati);
  end;
end;

end.
