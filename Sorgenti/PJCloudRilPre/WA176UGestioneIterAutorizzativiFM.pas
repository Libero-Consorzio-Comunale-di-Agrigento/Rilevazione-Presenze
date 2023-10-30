unit WA176UGestioneIterAutorizzativiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, WR010UBase, IWCompEdit,
  medpIWMultiColumnComboBox, IWCompCheckbox, meIWCheckBox, IWCompExtCtrls,
  meIWRadioGroup, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompGrids, IWDBGrids, medpIWDBGrid, IWCompButton, meIWButton, IWCompLabel,
  A000UCostanti, A000USessione, A000UMessaggi, A000UInterfaccia, IWCompListbox, meIWComboBox,
  medpIWMessageDlg, C190FunzioniGeneraliWeb, meIWLabel, meIWEdit, meIWImageFile, medpIWImageButton;

type
  TWA176FGestioneIterAutorizzativiFM = class(TWR200FBaseFM)
    dGrdDettIter: TmedpIWDBGrid;
    rgpAzioni: TmeIWRadioGroup;
    rgpAutorizzaNega: TmeIWRadioGroup;
    chkEliminaDato: TmeIWCheckBox;
    btnEsegui: TmeIWButton;
    lblAzioni: TmeIWLabel;
    lblLivello: TmeIWLabel;
    btnChiudi: TmeIWButton;
    cmbLivello: TmeIWComboBox;
    lblStruttura: TmeIWLabel;
    lblNuovaStruttura: TmeIWLabel;
    cmbNuovaStruttura: TmeIWComboBox;
    edtStruttura: TmeIWEdit;
    procedure btnChiudiClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure rgpAzioniClick(Sender: TObject);
  private
    { Private declarations }
    TipoAzioneRichiesta:string;
    procedure AbilitazioneComponenti(Azione:string);
    procedure CaricaCmbLivelli(const Azione:string);
    procedure VisualizzaAnomalie(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ModificaRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    { Public declarations }
    procedure Visualizza;
  end;

implementation

uses
  WA176URiepilogoIterAutorizzativiDM, C180FunzioniGenerali, WA176URiepilogoIterAutorizzativi, A176URiepilogoIterAutorizzativiMW;

{$R *.dfm}

procedure TWA176FGestioneIterAutorizzativiFM.AbilitazioneComponenti(Azione:string);
var
  AbilitaCancellazione:Boolean;
begin
  Azione:=Azione.ToLower;
  //Condizioni di abilitazione cancallazione dati su DataBase
  //Missioni
  AbilitaCancellazione:=((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.Iter = ITER_MISSIONI) and ((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo.FieldByName('T850STATO').AsString.ToUpper = 'S');
  //Giustificativi
  AbilitaCancellazione:=AbilitaCancellazione or ((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.Iter = ITER_GIUSTIF) and ((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo.FieldByName('T050ELABORATO').AsString.ToUpper <> 'N');
  //Timbrature
  AbilitaCancellazione:=AbilitaCancellazione or ((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.Iter = ITER_TIMBR) and ((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo.FieldByName('T105ELABORATO').AsString.ToUpper <> 'N');
  //(Disabilito per forzatura)
  AbilitaCancellazione:=AbilitaCancellazione and (not R180In(Azione,[A176AZIONE_APPLICA_AUT,A176AZIONE_CAMBIA_STRUTT]));
  chkEliminaDato.Enabled:=AbilitaCancellazione;
  C190VisualizzaElementoAsync(JQuery,'rgpAutorizzaNega',Azione = A176AZIONE_APPLICA_AUT);
  chkEliminaDato.Visible:=AbilitaCancellazione and (Azione <> A176AZIONE_CONFERMA_AUT);
  cmbLivello.Visible:=not R180In(Azione,[A176AZIONE_CANCELLA_RICH,A176AZIONE_CAMBIA_STRUTT,A176AZIONE_CONFERMA_AUT]);
  lblLivello.Visible:=cmbLivello.Visible;

  lblStruttura.Visible:=Azione = A176AZIONE_CAMBIA_STRUTT;
  edtStruttura.Visible:=lblStruttura.Visible;
  lblNuovaStruttura.Visible:=lblStruttura.Visible;
  cmbNuovaStruttura.Visible:=lblStruttura.Visible;

  //Gestione sola lettura
  C190VisualizzaElementoAsync(JQuery,'pnlAzioni', not (Self.Owner as TWA176FRiepilogoIterAutorizzativi).SolaLettura);
end;

procedure TWA176FGestioneIterAutorizzativiFM.CaricaCmbLivelli(const Azione:string);
begin
  cmbLivello.Items.Assign((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.CaricaCmbLivelliA176MW(Azione));
  cmbLivello.ItemIndex:=0;
end;

procedure TWA176FGestioneIterAutorizzativiFM.VisualizzaAnomalie(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + (Self.Owner as TWA176FRiepilogoIterAutorizzativi).medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';

  (Self.Owner as TWA176FRiepilogoIterAutorizzativi).AccediForm(201,Params,True);
end;

procedure TWA176FGestioneIterAutorizzativiFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851.Close;
  FreeAndNil(Self);
end;

procedure TWA176FGestioneIterAutorizzativiFM.ModificaRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  EsitoElaboraborazione:string;
begin
  EsitoElaboraborazione:='';
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.AnomaliePresenti:=False;
  if TipoAzioneRichiesta = A176AZIONE_ANNULLA_AUT then
  begin
    EsitoElaboraborazione:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.ResetRichiesta(cmbLivello.Items[cmbLivello.ItemIndex].ToInteger,
                                                                                   chkEliminaDato.Checked);
  end
  else if TipoAzioneRichiesta = A176AZIONE_CANCELLA_RICH then
  begin
    EsitoElaboraborazione:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.CancellaRichiesta(chkEliminaDato.Checked);
  end
  else if TipoAzioneRichiesta = A176AZIONE_APPLICA_AUT  then
  begin
    EsitoElaboraborazione:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.ForzaRichiesta(cmbLivello.Items[cmbLivello.ItemIndex].ToInteger,
                                                                                   (rgpAutorizzaNega.Items[rgpAutorizzaNega.ItemIndex] = 'Autorizza'));
  end
  else if TipoAzioneRichiesta = A176AZIONE_CAMBIA_STRUTT then
  begin
    EsitoElaboraborazione:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.CambiaStruttura(edtStruttura.Text,cmbNuovaStruttura.Text);
    edtStruttura.Text:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.CodIter;
  end
  else if TipoAzioneRichiesta = A176AZIONE_CONFERMA_AUT then
  begin
    EsitoElaboraborazione:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.ConfermaAutorizzazioni;
  end;
  //Refresh dei dati post- elaborazione
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851.Refresh;
  dGrdDettIter.medpAttivaGrid((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851,False,False);
  //Refrsh Griglia di riepilogo
  (Self.Owner as TWA176FRiepilogoIterAutorizzativi).ApriDataSetIterAutorizzativi;

  //Gestione esito - anomalia
  if not (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.AnomaliePresenti then
  begin
    if not EsitoElaboraborazione.IsEmpty then
    begin
      MsgBox.MessageBox(Format('ERRORE:' + #13#10 + '"%s"!',[EsitoElaboraborazione]) ,ERRORE);
    end
    else
    begin
      MsgBox.MessageBox('Elaborazione terminata correttamente.',INFORMA);
    end;
  end
  else
  begin
    MsgBox.WebMessageDlg(Format('ERRORE:' + #13#10 + '"%s"!',[EsitoElaboraborazione]) + CRLF + 'Visualizzare le anomalie?',mtConfirmation,[mbYes,mbNo],VisualizzaAnomalie,'');
  end;

  //Gestione abilitazioni componenti post elaborazione
  AbilitazioneComponenti(TipoAzioneRichiesta);
  CaricaCmbLivelli(TipoAzioneRichiesta);
  //Abilito il bottone d'elaborazione solo se ci sono livelli disponibili per l'elaborazione
  btnEsegui.Enabled:=cmbLivello.Items.Count > 0;
end;

procedure TWA176FGestioneIterAutorizzativiFM.btnEseguiClick(Sender: TObject);
var
  MsgConfermaElaborazione:string;
begin
  inherited;
  TipoAzioneRichiesta:=rgpAzioni.Items[rgpAzioni.ItemIndex].ToLower;
  //Costruzione messaggio di conferma
  if TipoAzioneRichiesta = A176AZIONE_APPLICA_AUT then
  begin
    if rgpAutorizzaNega.Items[rgpAutorizzaNega.ItemIndex].ToLower = 'autorizza' then
    begin
      MsgConfermaElaborazione:=Format('Vuoi autorizzare la richiesta fino al livello %s?',[cmbLivello.Items[cmbLivello.ItemIndex]]);
    end
    else
    begin
      MsgConfermaElaborazione:=Format('Vuoi negare la richiesta fino al livello %s?',[cmbLivello.Items[cmbLivello.ItemIndex]]);
    end;
  end
  else if TipoAzioneRichiesta = A176AZIONE_ANNULLA_AUT then
  begin
    MsgConfermaElaborazione:=Format('Vuoi annullare l''autorizzazione fino al livello %s?',[cmbLivello.Items[cmbLivello.ItemIndex]]);
  end
  else if TipoAzioneRichiesta = A176AZIONE_CANCELLA_RICH then
  begin
    MsgConfermaElaborazione:='Vuoi cancellare la richiesta?';
  end
  else if TipoAzioneRichiesta = A176AZIONE_CAMBIA_STRUTT then
  begin
    MsgConfermaElaborazione:='Vuoi modificare la struttura assegnando quella selezionata?';
  end
  else if TipoAzioneRichiesta = A176AZIONE_CONFERMA_AUT then
  begin
    MsgConfermaElaborazione:='Vuoi caricare i dati della richiesta sul cartellino?';
  end;
  MsgBox.WebMessageDlg(MsgConfermaElaborazione,mtConfirmation,[mbYes,mbNo],ModificaRichiesta,'');
end;

procedure TWA176FGestioneIterAutorizzativiFM.rgpAzioniClick(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.SetC018selT851;
  CaricaCmbLivelli(rgpAzioni.Items[rgpAzioni.ItemIndex]);
  chkEliminaDato.Enabled:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851.FieldByName('STATO').AsString.ToUpper = 'SI';
  //Cambio struttura abilitato solo se non esistono livelli obbligatori già con autorizzazione assegnata
  if rgpAzioni.Items[rgpAzioni.ItemIndex].ToLower = A176AZIONE_CAMBIA_STRUTT then
  begin
    btnEsegui.Enabled:=(VarToStr((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851.Lookup('OBBLIGATORIO;STATO',VarArrayOf(['S','No']),'STATO')).ToUpper = '') and
                       (VarToStr((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851.Lookup('OBBLIGATORIO;STATO',VarArrayOf(['S','Si']),'STATO')).ToUpper = '');
    cmbNuovaStruttura.Enabled:=btnEsegui.Enabled;
  end
  else if rgpAzioni.Items[rgpAzioni.ItemIndex].ToLower = A176AZIONE_CONFERMA_AUT then
  begin
    btnEsegui.Enabled:=(cmbLivello.Items.Count = 0) and
                       ((((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.Iter = ITER_GIUSTIF) and ((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo.FieldByName('T050ELABORATO').AsString.ToUpper <> 'S')) or
                        (((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.Iter = ITER_TIMBR) and ((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo.FieldByName('T105ELABORATO').AsString.ToUpper <> 'S')))
  end
  else
    btnEsegui.Enabled:=(cmbLivello.Items.Count > 0);
  btnEsegui.Enabled:=btnEsegui.Enabled and ((A000GetInibizioni('Funzione','OpenA176RiepilogoIterAutorizzativi') = 'S') or (DebugHook <> 0));
  AbilitazioneComponenti(rgpAzioni.Items[rgpAzioni.ItemIndex]);
end;

procedure TWA176FGestioneIterAutorizzativiFM.Visualizza;
begin
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.SetC018selT851;
  dGrdDettIter.medpAttivaGrid((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851,False,False);
  CaricaCmbLivelli(rgpAzioni.Items[rgpAzioni.ItemIndex]);

  edtStruttura.Text:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.CodIter;
  cmbNuovaStruttura.Items.Clear;
  with (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.selI095 do
  begin
    Open;
    First;
    while not Eof do
    begin
      cmbNuovaStruttura.Items.Add(FieldByName('COD_ITER').AsString);
      Next;
    end;
  end;
  cmbNuovaStruttura.ItemIndex:=cmbNuovaStruttura.Items.IndexOf(edtStruttura.Text);
  chkEliminaDato.Enabled:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018.selT851.FieldByName('STATO').AsString.ToUpper = 'SI';
  btnEsegui.Enabled:=cmbLivello.Items.Count > 0;
  AbilitazioneComponenti(rgpAzioni.Items[rgpAzioni.ItemIndex]);
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,1200,-1,-1,-1,'<WA176> Gestione richiesta','#' + Self.Name,False,True);
  //Gestione sola lettura
  C190VisualizzaElementoAsync(JQuery,'pnlAzioni', not (Self.Owner as TWA176FRiepilogoIterAutorizzativi).SolaLettura);
end;

end.
