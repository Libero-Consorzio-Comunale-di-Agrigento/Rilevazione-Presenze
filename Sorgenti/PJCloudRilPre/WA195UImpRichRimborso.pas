unit WA195UImpRichRimborso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA195UImpRichRimborsoDM, WA195UImpRichRimborsoBrowseFM, WA195UImpRichRimborsoDettFM,
  A000UInterfaccia, A000UMessaggi, medpIWC700NavigatorBar, meIWImageFile,
  IWCompEdit, meIWEdit;

type
  TWA195FImpRichRimborso = class(TWR102FGestTabella)
    actConfermaModifiche: TAction;
    actAnnullaModifiche: TAction;
    actConfermaTutto: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actAnnullaModificheExecute(Sender: TObject);
    procedure actConfermaModificheExecute(Sender: TObject);
    procedure actConfermaTuttoExecute(Sender: TObject);
  private
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    { Private declarations }
  public
    function InizializzaAccesso: boolean; override;
    procedure abilitaPulsanti;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.dfm}
procedure TWA195FImpRichRimborso.IWAppFormCreate(Sender: TObject);
begin
  actNuovo.Visible:=False;
  actElimina.Visible:=False;
  actCopiaSu.Visible:=False;
  inherited;
  WR302DM:=TWA195FImpRichRimborsoDM.Create(Self);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  //Inizializzazioni non standard:
  grdC700.AttivaBrowse:=False;
  grdC700.AttivaLabel:=False;
  //Fine inizializzazioni
  AttivaGestioneC700;
  grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella);
  grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
  WR302DM.selTabella.Open;
  grdC700.WC700FM.ResultEvent:=ResultWC700;

  WBrowseFM:=TWA195FImpRichRimborsoBrowseFM.Create(Self);
  WDettaglioFM:=TWA195FImpRichRimborsoDettFM.Create(Self);

  CreaTabDefault;
end;

procedure TWA195FImpRichRimborso.ResultWC700(Sender: TObject; Result: Boolean);
begin
  // se Result è True, significa che è stata modificata la selezione anagrafica
  if Result then
  begin
     //Caratto 06/03/2014 reset delle varibili dei dataset delle griglie
    //se entro con dei valori, poi riaccedo senza dipendenti rimanevano con i vecchi valori
    (WR302DM as TWA195FImpRichRimborsoDM).A100FImpRimborsiIterMW.ResetDatasetFigli;

    // reimposta il filtro anagrafe
    WR302DM.selTabella.Close;
    grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella,False);
    grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
    WR302DM.selTabella.Open;

    // aggiorna tabella
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
    //devo forzare aggiornamento grid del dettaglio
    WDettaglioFM.DataSet2Componenti;
  end;
end;

procedure TWA195FImpRichRimborso.OnTabClosing(var AllowClose: Boolean;
  var Conferma: String);
begin
  if WR302DM.selTabella.UpdatesPending then
  begin
    AllowClose:=False;
    Conferma:=A000MSG_ERR_MODIFICHE_PENDING;
  end;
end;

function TWA195FImpRichRimborso.InizializzaAccesso: boolean;
begin
  Result:=False;
  //forzo eredita Selezione
  grdC700.actC700EreditaSelezioneExecute(nil);
  WR302DM.selTabella.Close;
  grdC700.WC700FM.C700MergeSelAnagrafe(WR302DM.selTabella);
  grdC700.WC700FM.C700MergeSettaPeriodo(WR302DM.selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
  WR302DM.selTabella.Open;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA195FImpRichRimborso.actAnnullaModificheExecute(Sender: TObject);
begin
  inherited;
  WR302DM.selTabella.CancelUpdates;
  abilitaPulsanti;
  WR302DM.selTabella.Refresh;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA195FImpRichRimborso.actConfermaModificheExecute(Sender: TObject);
begin
  inherited;
  SessioneOracle.ApplyUpdates([WR302DM.selTabella],True);
  abilitaPulsanti;
  WR302DM.selTabella.Refresh;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA195FImpRichRimborso.actConfermaTuttoExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA195FImpRichRimborsoDM).A100FImpRimborsiIterMW.ConfermaTuttiRimborsi;
  abilitaPulsanti;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA195FImpRichRimborso.abilitaPulsanti;
begin
  actConfermaModifiche.Enabled:=WR302DM.selTabella.UpdatesPending;
  actAnnullaModifiche.Enabled:=WR302DM.selTabella.UpdatesPending;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;
end.
