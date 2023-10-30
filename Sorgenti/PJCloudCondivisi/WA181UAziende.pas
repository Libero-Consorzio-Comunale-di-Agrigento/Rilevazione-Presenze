unit WA181UAziende;

interface

uses
  WA181UAziendeBrowseFM, WA181UAziendeDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  IWCompJQueryWidget, ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000UMessaggi, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, Data.DB,
  IWCompButton, WR102UGestTabella, C180FunzioniGenerali,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, meIWComboBox,
  meIWEdit, IWCompGrids, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, System.Actions, meIWImageFile, medpIWMessageDlg;

type
  TWA181FAziende = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    procedure ConfermaElimina(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
    const
      ELIMINA_CONF_1:String = 'CONFERMA_1';
      ELIMINA_CONF_2:String = 'CONFERMA_2';
  public
    procedure AggiornaDetails;
    procedure AbilitaFunzioni;
  end;

implementation

uses WA181UAziendeDM;

{$R *.dfm}

procedure TWA181FAziende.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA181FAziendeDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=True;

  WDettaglioFM:=TWA181FAziendeDettFM.Create(Self);
  WBrowseFM:=TWA181FAziendeBrowseFM.Create(Self);
  CreaTabDefault;

  TWA181FAziendeDM(WR302DM).AfterScroll(TWA181FAziendeDM(WR302DM).selTabella);
end;

procedure TWA181FAziende.actEliminaExecute(Sender: TObject);
var
  Azienda:String;
begin
  Azienda:=WR302DM.selTabella.FieldByName('AZIENDA').AsString;
  if Azienda <> 'AZIN' then
  begin
    if Azienda <> Parametri.Azienda then
      MsgBox.WebMessageDlg(Format(A000MSG_A008_DLG_FMT_CANC_AZ,[WR302DM.selTabella.FieldByName('AZIENDA').AsString]),
                           mtWarning,[mbYes,mbNo],ConfermaElimina,
                           ELIMINA_CONF_1,'Elimina azienda',mbNo)
    else
      Msgbox.MessageBox(A000MSG_A008_ERR_NO_CANC_AZIENDA_CORR,ESCLAMA,'Operazione annullata','');
  end
  else
    Msgbox.MessageBox(A000MSG_A008_ERR_NO_CANC_AZIN,ESCLAMA,'Operazione annullata','');
end;

procedure TWA181FAziende.ConfermaElimina(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if KeyID = ELIMINA_CONF_1 then
  begin
    // L'utente ha risposto alla prima conferma
    if ModalResult = mrYes then
      // Chiediamo ancora una conferma
      MsgBox.WebMessageDlg(Format(A000MSG_A008_MSG_FMT_CANC_AZ_AVVISO,[WR302DM.selTabella.FieldByName('AZIENDA').AsString]),
                           mtWarning,[mbYes,mbNo],ConfermaElimina,
                           ELIMINA_CONF_2,'Elimina azienda',mbNo);
  end
  else if KeyID = ELIMINA_CONF_2 then
  begin
    // Risposta alla seconda dialog di conferma
    if ModalResult = mrYes then
      inherited actEliminaExecute(nil);
  end;
  MsgBox.ClearKeys;
end;

procedure TWA181FAziende.AggiornaDetails;
begin
  if WDettaglioFM <> nil then
    (WDettaglioFM as TWA181FAziendeDettFM).AggiornaDettaglio;
end;

procedure TWA181FAziende.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  AbilitaFunzioni;
end;

procedure TWA181FAziende.AbilitaFunzioni;
begin
  if WR302DM <> nil then
  begin
    actNuovo.Enabled:=(WR302DM.selTabella.State = dsBrowse) and (grdTabControl.TabIndex = 0);
    actElimina.Enabled:=(WR302DM.selTabella.State = dsBrowse) and (grdTabControl.TabIndex = 0);
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
end;

end.
