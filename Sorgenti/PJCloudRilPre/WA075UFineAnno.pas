unit WA075UFineAnno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, A075UFineAnnoMW, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, IWCompCheckbox, meIWCheckBox, meIWRadioGroup, IWCompMemo, meIWMemo,
  meIWImageFile, medpIWMessageDlg, medpIWImageButton, A000UInterfaccia, A000UMessaggi,
  C180FunzioniGenerali, QueryStorico, medpIWC700NavigatorBar, WC700USelezioneAnagrafeFM,
  C190FunzioniGeneraliWeb, A000UCostanti, meIWImageButton, WC010UMemoEditFM,
  IWCompJQueryWidget, System.StrUtils;

type
  TWA075FFineAnno = class(TWR100FBase)
    lblDaData: TmeIWLabel;
    edtAnno: TmeIWEdit;
    chkTriggerBefore: TmeIWCheckBox;
    chkTriggerAfter: TmeIWCheckBox;
    chkCalendari: TmeIWCheckBox;
    chkProfiliAsse: TmeIWCheckBox;
    chkProfiliIndividuali: TmeIWCheckBox;
    chkDebitiAggiuntivi: TmeIWCheckBox;
    chkDebitiAggiuntiviIndiv: TmeIWCheckBox;
    lblLimitiEccedenze: TmeIWLabel;
    chkLimitiIndividualiAnnuali: TmeIWCheckBox;
    chkLimitiMensili: TmeIWCheckBox;
    rgpLimiti: TmeIWRadioGroup;
    chkResiduiBuoniTicket: TmeIWCheckBox;
    chkResiduiCrediti: TmeIWCheckBox;
    chkResiduiOre: TmeIWCheckBox;
    chkResiduiAsse: TmeIWCheckBox;
    memResiduiAssenza: TmeIWMemo;
    btnAnomalie: TmedpIWImageButton;
    btnEsegui: TmedpIWImageButton;
    btnSrcResiduiTriggerBefore: TmeIWImageButton;
    btnSrcResiduiTriggerAfter: TmeIWImageButton;
    chkResiduiBuoniTicketOvr: TmeIWCheckBox;
    chkResiduiOreOvr: TmeIWCheckBox;
    chkResiduiAsseOvr: TmeIWCheckBox;
    chkLimitiIndividualiAnnualiOvr: TmeIWCheckBox;
    chkLimitiIndividualiMensili: TmeIWCheckBox;
    chkLimitiIndividualiMensiliOvr: TmeIWCheckBox;
    JQVisual: TIWJQueryWidget;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnSrcResiduiTriggerBeforeClick(Sender: TObject);
    procedure chkLimitiIndividualiAnnualiAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkLimitiIndividualiMensiliAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkLimitiMensiliAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkResiduiBuoniTicketAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkResiduiOreAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkResiduiAsseAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    WA075MW:TA075FFineAnnoMW;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultElabora(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure LogContatoriResidui;
  public
    { Public declarations }
  protected
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    procedure FineCicloElaborazione; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
    function ElaborazioneTerminata:String; override;
    function ElementoSuccessivo: Boolean; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
  end;

implementation

{$R *.dfm}

procedure TWA075FFineAnno.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=True;
  grdC700.AttivaBrowse:=False;
  AttivaGestioneC700;

  WA075MW:=TA075FFineAnnoMW.Create(Self);
  GetParametriFunzione;

  // opzioni per procedure before / after residui
  chkTriggerBefore.Enabled:=WA075MW.EsisteProcResiduiBefore;
  btnSrcResiduiTriggerBefore.Visible:=WA075MW.EsisteProcResiduiBefore;
  if chkTriggerBefore.Enabled then
  begin
    // se è specificata l'opzione aziendale di impostazione, utilizza questa
    if Parametri.CampiRiferimento.C35_ResiduiTriggerBefore <> '' then
      chkTriggerBefore.Checked:=Parametri.CampiRiferimento.C35_ResiduiTriggerBefore = 'S';
  end
  else
  begin
    chkTriggerBefore.Checked:=False;
  end;
  chkTriggerAfter.Enabled:=WA075MW.EsisteProcResiduiAfter;
  btnSrcResiduiTriggerAfter.Visible:=WA075MW.EsisteProcResiduiAfter;
  if chkTriggerAfter.Enabled then
  begin
    // se è specificata l'opzione aziendale di impostazione, utilizza questa
    if Parametri.CampiRiferimento.C35_ResiduiTriggerAfter <> '' then
      chkTriggerAfter.Checked:=Parametri.CampiRiferimento.C35_ResiduiTriggerAfter = 'S';
  end
  else
  begin
    chkTriggerAfter.Checked:=False;
  end;

  edtAnno.Text:=FormatDateTime('yyyy',Parametri.DataLavoro);
  WA075MW.DataRif:=EncodeDate(R180Anno(Parametri.DataLavoro),1,1);
  btnAnomalie.Enabled:=False;
  C190VisualizzaElementoConVisibility(JQVisual,rgpLimiti.HTMLName,False);
end;

procedure TWA075FFineAnno.btnAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  if RegistraMsg.ContieneAnomalie then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + medpCodiceForm;
    AccediForm(201,Params,True);
  end;
end;

procedure TWA075FFineAnno.btnEseguiClick(Sender: TObject);
var
  LMsg: String;
  LDatiNonSovrascritti: String;
begin
  // determina le eventuali opzioni da ribaltare sul nuovo anno, ma da non sovrascrivere se già presenti
  LDatiNonSovrascritti:='';
  if chkLimitiIndividualiAnnuali.Checked and not chkLimitiIndividualiAnnualiOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + '- limiti eccedenze individuali annuali'#13#10;
  if chkLimitiIndividualiMensili.Checked and not chkLimitiIndividualiMensiliOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + '- limiti eccedenze individuali mensili'#13#10;
  if chkResiduiBuoniTicket.Checked and not chkResiduiBuoniTicketOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + Format('- %s'#13#10,[LowerCase(chkResiduiBuoniTicket.Caption)]);
  if chkResiduiOre.Checked and not chkResiduiOreOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + Format('- %s'#13#10,[LowerCase(chkResiduiOre.Caption)]);
  if chkResiduiAsse.Checked and not chkResiduiAsseOvr.Checked then
    LDatiNonSovrascritti:=LDatiNonSovrascritti + Format('- %s'#13#10,[LowerCase(chkResiduiAsse.Caption)]);

  // prepara il messaggio di conferma operazione
  LMsg:='Verranno generati i dati per l''anno ' + edtAnno.Text + '.'#13#10;
  if LDatiNonSovrascritti <> '' then
    LMsg:=LMsg +
          'Attenzione!'#13#10 +
          'I seguenti dati non verranno sovrascritti da questa elaborazione:'#13#10 +
          LDatiNonSovrascritti;

  btnAnomalie.Enabled:=False;
  WA075MW.selDatiBloccati.Close;
  WA075MW.NuovoAnno:=edtAnno.Text;
  MsgBox.WebMessageDlg(LMsg + 'Vuoi continuare?',mtConfirmation,[mbYes,mbNo],ResultElabora,'');
end;

procedure TWA075FFineAnno.btnSrcResiduiTriggerBeforeClick(Sender: TObject);
var
  LLst: TStringList;
  LObjName: string;
  LTitolo: string;
begin
  if Sender = btnSrcResiduiTriggerBefore then
  begin
    LObjName:='RESIDUI_TRIGGER_BEFORE';
    LTitolo:='Sorgente procedura Oracle eseguita prima del calcolo dei residui';
  end
  else if Sender = btnSrcResiduiTriggerAfter then
  begin
    LObjName:='RESIDUI_TRIGGER_AFTER';
    LTitolo:='Sorgente procedura Oracle eseguita dopo il calcolo dei residui';
  end;

  LLst:=TStringList.Create;
  try
    R180OracleObjectSource(LObjName,SessioneOracle,LLst);
    TWC010FMemoEditFM.Visualizza(LTitolo,800,600,Llst);
  finally
    FreeAndNil(LLst);
  end;
end;

procedure TWA075FFineAnno.chkLimitiIndividualiAnnualiAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkLimitiIndividualiAnnualiOvr.Enabled:=chkLimitiIndividualiAnnuali.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkLimitiIndividualiAnnualiOvr.Checked:=False;
end;

procedure TWA075FFineAnno.chkLimitiIndividualiMensiliAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkLimitiIndividualiMensiliOvr.Enabled:=chkLimitiIndividualiMensili.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkLimitiIndividualiMensiliOvr.Checked:=False;
  // determina se visualizzare il radiogroup di opzione dei limiti mensili
  C190VisualizzaElementoConVisibilityAsync(JQVisual,rgpLimiti.HTMLName,(chkLimitiMensili.Checked or chkLimitiIndividualiMensili.Checked));
  //rgpLimiti.Visible:=(chkLimitiMensili.Checked or chkLimitiIndividualiMensili.Checked);
end;

procedure TWA075FFineAnno.chkLimitiMensiliAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  // determina se visualizzare il radiogroup di opzione dei limiti mensili
  // rgpLimiti.Visible:=(chkLimitiMensili.Checked or chkLimitiIndividualiMensili.Checked);
  C190VisualizzaElementoConVisibilityAsync(JQVisual,rgpLimiti.HTMLName,(chkLimitiMensili.Checked or chkLimitiIndividualiMensili.Checked));
end;

procedure TWA075FFineAnno.chkResiduiAsseAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkResiduiAsseOvr.Enabled:=chkResiduiAsse.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkResiduiAsseOvr.Checked:=False;
end;

procedure TWA075FFineAnno.chkResiduiBuoniTicketAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkResiduiBuoniTicketOvr.Enabled:=chkResiduiBuoniTicket.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkResiduiBuoniTicketOvr.Checked:=False;
end;

procedure TWA075FFineAnno.chkResiduiOreAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkResiduiOreOvr.Enabled:=chkResiduiOre.Checked;
  // disabilita sempre il checkbox di sovrascrittura
  chkResiduiOreOvr.Checked:=False;
end;

procedure TWA075FFineAnno.ResultElabora(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWA075FFineAnno.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  WA075MW.DataRif:=EncodeDate(StrToInt(edtAnno.Text),1,1);
end;

procedure TWA075FFineAnno.GetParametriFunzione;
begin
  chkTriggerBefore.Checked:=C004DM.GetParametro('TRIGGER_BEFORE','N') = 'S';
  chkTriggerAfter.Checked:=C004DM.GetParametro('TRIGGER_AFTER','N') = 'S';
end;

procedure TWA075FFineAnno.PutParametriFunzione;
begin
  C004DM.Cancella001;
  if chkTriggerBefore.Checked then
    C004DM.PutParametro('TRIGGER_BEFORE','S')
  else
    C004DM.PutParametro('TRIGGER_BEFORE','N');
  if chkTriggerAfter.Checked then
    C004DM.PutParametro('TRIGGER_AFTER','S')
  else
    C004DM.PutParametro('TRIGGER_AFTER','N');
  try SessioneOracle.Commit; except end;
end;

procedure TWA075FFineAnno.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase (*+ ',RAPPORTI_UNITI'*);
end;

procedure TWA075FFineAnno.InizioElaborazione;
begin
  inherited;
  with WA075MW do
  begin
    lstCausali.Clear;
    lstCausali.Add(Format('%-7s %-11s %-13s',['Causale','Raggr.caus.','Raggr.residui']));
    lstCausali.Add('');
    memResiduiAssenza.Lines.Clear;

    // esegue i passaggi selezionati
    RegistraMsg.InserisciMessaggio('I',Format('Generazione dei dati per l''anno %s',[NuovoAnno]));

    // calendari
    if chkCalendari.Checked then
      GeneraCalendario;

    // profili assenza
    if chkProfiliAsse.Checked then
      GeneraProfili;

    // debiti aggiuntivi
    if chkDebitiAggiuntivi.Checked then
      GeneraDebiti;

    // limiti eccedenze mensili
    if chkLimitiMensili.Checked then
      GeneraLimitiMensili(rgpLimiti.ItemIndex);

    // limiti individuali
    if (chkResiduiOre.Checked) or (chkResiduiAsse.Checked) or (chkResiduiBuoniTicket.Checked) or
       (chkProfiliIndividuali.Checked) or (chkDebitiAggiuntiviIndiv.Checked) or
       (chkLimitiIndividualiMensili.Checked) or (chkLimitiIndividualiAnnuali.Checked) or
       (chkResiduiCrediti.Checked) then
    begin
      if grdC700.selAnagrafe.GetVariable('DATALAVORO') <> DataRif then
      begin
        grdC700.selAnagrafe.Close;
        grdC700.selAnagrafe.SetVariable('DATALAVORO',DataRif);
        grdC700.selAnagrafe.Open;
      end;
      grdC700.selAnagrafe.First;
      Self.Enabled:=False;

      // log su messaggi elaborazioni
      if grdC700.selAnagrafe.RecordCount > 0 then
      begin
        RegistraMsg.InserisciMessaggio('I',Format('Inizio elaborazione dei dati individuali per %d anagrafiche',[grdC700.selAnagrafe.RecordCount]));
        if chkTriggerBefore.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkTriggerBefore.Caption]));
        if chkTriggerAfter.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkTriggerAfter.Caption]));
        if chkProfiliIndividuali.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkProfiliIndividuali.Caption]));
        if chkDebitiAggiuntiviIndiv.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkDebitiAggiuntiviIndiv.Caption]));
        if chkLimitiIndividualiAnnuali.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkLimitiIndividualiAnnuali.Caption,IfThen(chkLimitiIndividualiAnnualiOvr.Checked,'con','senza')]));
        if chkLimitiIndividualiMensili.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkLimitiIndividualiMensili.Caption,IfThen(chkLimitiIndividualiMensiliOvr.Checked,'con','senza')]));
        if chkLimitiMensili.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkLimitiMensili.Caption]));
        if (chkLimitiIndividualiMensili.Checked or chkLimitiMensili.Checked) then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: tipo ribaltamento limiti mensili: %s',[rgpLimiti.Items[rgpLimiti.ItemIndex]]));
        if chkResiduiBuoniTicket.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkResiduiBuoniTicket.Caption,IfThen(chkResiduiBuoniTicketOvr.Checked,'con','senza')]));
        if chkResiduiCrediti.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s',[chkResiduiCrediti.Caption]));
        if chkResiduiOre.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkResiduiOre.Caption,IfThen(chkResiduiOreOvr.Checked,'con','senza')]));
        if chkResiduiAsse.Checked then
          RegistraMsg.InserisciMessaggio('I',Format('Opzione selezionata: %s (%s sovrascrittura dati già presenti)',[chkResiduiAsse.Caption,IfThen(chkResiduiAsseOvr.Checked,'con','senza')]));
      end
      else
      begin
        RegistraMsg.InserisciMessaggio('I','Elaborazione dei dati individuali non effettuata: nessuna anagrafica selezionata');
      end;

      // impostazioni iniziali
      WA075MW.NuovoAnno:=edtAnno.Text;

      // salva le opzioni selezionate sul middleware
      WA075MW.Opzioni.TriggerBefore:=chkTriggerBefore.Checked;
      WA075MW.Opzioni.TriggerAfter:=chkTriggerAfter.Checked;

      WA075MW.Opzioni.Calendari:=chkCalendari.Checked;
      WA075MW.Opzioni.ProfiliAsse:=chkProfiliAsse.Checked;
      WA075MW.Opzioni.ProfiliIndividuali:=chkProfiliIndividuali.Checked;
      WA075MW.Opzioni.DebitiAggiuntivi:=chkDebitiAggiuntivi.Checked;
      WA075MW.Opzioni.DebitiAggiuntiviIndiv:=chkDebitiAggiuntiviIndiv.Checked;
      WA075MW.Opzioni.LimitiIndividualiMensili.Selected:=chkLimitiIndividualiMensili.Checked;
      WA075MW.Opzioni.LimitiIndividualiMensili.Overwrite:=chkLimitiIndividualiMensiliOvr.Checked;
      WA075MW.Opzioni.LimitiIndividualiAnnuali.Selected:=chkLimitiIndividualiAnnuali.Checked;
      WA075MW.Opzioni.LimitiIndividualiAnnuali.Overwrite:=chkLimitiIndividualiAnnualiOvr.Checked;
      WA075MW.Opzioni.LimitiMensili:=chkLimitiMensili.Checked;
      WA075MW.Opzioni.LimitiItemIndex:=rgpLimiti.ItemIndex;

      WA075MW.Opzioni.ResiduiBuoniTicket.Selected:=chkResiduiBuoniTicket.Checked;
      WA075MW.Opzioni.ResiduiBuoniTicket.Overwrite:=chkResiduiBuoniTicketOvr.Checked;
      WA075MW.Opzioni.ResiduiCrediti:=chkResiduiCrediti.Checked;
      WA075MW.Opzioni.ResiduiOre.Selected:=chkResiduiOre.Checked;
      WA075MW.Opzioni.ResiduiOre.Overwrite:=chkResiduiOreOvr.Checked;
      WA075MW.Opzioni.ResiduiAsse.Selected:=chkResiduiAsse.Checked;
      WA075MW.Opzioni.ResiduiAsse.Overwrite:=chkResiduiAsseOvr.Checked;

      // azzera i dati di riepilogo per le statistiche di elaborazione
      WA075MW.RiepilogoElab.Clear;
    end
    else
      exit;
  end;
end;

procedure TWA075FFineAnno.ElaboraElemento;
begin
  inherited;
  // imposta i dati relativi al dipendente corrente
  WA075MW.ProgrAnagafica:=grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

  WA075MW.ResiduiDipendente;
end;

function TWA075FFineAnno.ElaborazioneTerminata: String;
begin
  RegistraMsg.InserisciMessaggio('I','Elaborazione terminata');
  if RegistraMsg.ContieneAnomalie then
  begin
    btnAnomalie.Enabled:=True;
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
  end
  else
    Result:=inherited;
end;

function TWA075FFineAnno.ElementoSuccessivo: Boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.Eof; //richiama calcolo su nuovo dipendente
end;

procedure TWA075FFineAnno.FineCicloElaborazione;
begin
  if grdC700.selAnagrafe.RecordCount > 0 then
    RegistraMsg.InserisciMessaggio('I','Fine elaborazione dei dati individuali');

  // registra i contatori dei residui
  LogContatoriResidui;

  memResiduiAssenza.Lines.Assign(WA075MW.lstCausali);
end;

function TWA075FFineAnno.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNo;
end;

procedure TWA075FFineAnno.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  PutParametriFunzione;
end;

function TWA075FFineAnno.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA075FFineAnno.LogContatoriResidui;
// registra i contatori dei dati non sovrascritti come anomalie di cui tenere conto
var
  LRiep: TDatiRiepilogo;
begin
  LRiep:=WA075MW.RiepilogoElab;

  if LRiep.LimitiIndividualiMensili.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Limiti delle ecc. individuali mensili: %d record già presenti non sono stati sovrascritti',[LRiep.LimitiIndividualiMensili.ContaNonSovrascritti]));
  if LRiep.LimitiIndividualiAnnuali.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Limiti delle ecc. individuali annuali: %d record già presenti non sono stati sovrascritti',[LRiep.LimitiIndividualiAnnuali.ContaNonSovrascritti]));
  if LRiep.ResiduiBuoniTicket.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Residui buoni pasto / ticket: %d record già presenti non sono stati sovrascritti',[LRiep.ResiduiBuoniTicket.ContaNonSovrascritti]));
  if LRiep.ResiduiOre.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Residui saldo ore annuo: %d record già presenti non sono stati sovrascritti',[LRiep.ResiduiOre.ContaNonSovrascritti]));
  if LRiep.ResiduiAssenze.ContaNonSovrascritti > 0 then
    RegistraMsg.InserisciMessaggio('A',Format('Residui assenze: %d record già presenti non sono stati sovrascritti',[LRiep.ResiduiAssenze.ContaNonSovrascritti]));
end;

end.
