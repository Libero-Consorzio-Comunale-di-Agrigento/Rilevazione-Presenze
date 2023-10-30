unit WA100UMissioniDettFM;

interface

uses
  WC015USelEditGridFM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, medpIWMultiColumnComboBox, WA100UMissioniDM, meIWEdit,
  meIWDBLabel, db, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  IWCompCheckbox, meIWDBCheckBox, C190FunzioniGeneraliWeb, meIWRegion,
  IWCompGrids, meIWGrid, medpIWTabControl, meIWCheckBox, A000UInterfaccia,
  IWCompListbox, meIWDBComboBox, IWDBGrids, meIWDBGrid, medpIWDBGrid, meIWImageFile,
  WA100UDistanzeChilometricheFM, IWCompMemo, IWHTMLControls, meIWLink, meIWDBMemo,
  IWCompButton, meIWButton;

type
  TWA100FMissioniDettFM = class(TWR205FDettTabellaFM)
    lblMeseScarico: TmeIWLabel;
    lblDalGiorno: TmeIWLabel;
    dedtDataDa: TmeIWDBEdit;
    dedtDataA: TmeIWDBEdit;
    lblAlGiorno: TmeIWLabel;
    dedtTotaleGiorni: TmeIWDBEdit;
    lblTotGiorni: TmeIWLabel;
    cmbTipoMissione: TMedpIWMultiColumnComboBox;
    dedtPeriodo: TmeIWDBEdit;
    dlblDescTipoMissione: TmeIWDBLabel;
    cmbCodiceTariffa: TMedpIWMultiColumnComboBox;
    lblDescCodiceTariffa: TmeIWLabel;
    cmbCodiceRiduzione: TMedpIWMultiColumnComboBox;
    lblDescCodiceRiduzione: TmeIWLabel;
    lblOraDa: TmeIWLabel;
    dedtOraDa: TmeIWDBEdit;
    lblOraA: TmeIWLabel;
    dedtOraA: TmeIWDBEdit;
    lblTotaleOre: TmeIWLabel;
    dedtTotaleOre: TmeIWDBEdit;
    drgpFlagDetinazione: TmeIWDBRadioGroup;
    lblDatiRichiestaWeb: TmeIWLabel;
    dChkIspettiva: TmeIWDBCheckBox;
    dlblAnnullata: TmeIWDBLabel;
    lblCommessa: TmeIWLabel;
    cmbCommessa: TMedpIWMultiColumnComboBox;
    dlblDescCommessa: TmeIWDBLabel;
    lblProtocollo: TmeIWLabel;
    dedtProtocollo: TmeIWDBEdit;
    TemplateDatiTrasfertaRG: TIWTemplateProcessorHTML;
    chkIndennitaSupMaxGG: TmeIWCheckBox;
    dChkModifica: TmeIWDBCheckBox;
    lblStatoMissione: TmeIWLabel;
    DCmbStato: TmeIWDBComboBox;
    lblTotaleMissione: TmeIWLabel;
    dedtTotaleMissione: TmeIWDBEdit;
    lblCostoMissione: TmeIWLabel;
    dEdtCostoMissione: TmeIWDBEdit;
    lblTarIndOr: TmeIWLabel;
    lblTarQuotaEsente: TmeIWLabel;
    lblTariffa: TmeIWLabel;
    lblOreGiorni: TmeIWLabel;
    lblTotale: TmeIWLabel;
    lblPartenza: TmeIWLabel;
    cmbPartenza: TMedpIWMultiColumnComboBox;
    dlblDescPartenza: TmeIWDBLabel;
    lblDestinazione: TmeIWLabel;
    cmbDestinazione: TMedpIWMultiColumnComboBox;
    lblIndTrasfInt: TmeIWLabel;
    dedtTariffaIndennitaTrasfertaIntera: TmeIWDBEdit;
    dedtOreIndennitaTrasfertaIntera: TmeIWDBEdit;
    dedtTotaleIndennitaTrasfertaIntera: TmeIWDBEdit;
    lblSupOreMasRimbPasto: TmeIWLabel;
    dedtTariffaSuperoOreMassime: TmeIWDBEdit;
    dedtOreSuperoOreMassime: TmeIWDBEdit;
    dedtTotaleSuperoOreMassime: TmeIWDBEdit;
    lblSuperoMaxGiorniMese: TmeIWLabel;
    dedtTariffaSuperoGiorniMese: TmeIWDBEdit;
    dedtOreSuperoGiorniMese: TmeIWDBEdit;
    dedtTotaleSuperoGiorniMese: TmeIWDBEdit;
    lblSuperoMaxOreGiorni: TmeIWLabel;
    dedtTariffaSuperoOreGiorni: TmeIWDBEdit;
    dedtOreSuperoOreGiorni: TmeIWDBEdit;
    dedtTotaleSuperoOreGiorni: TmeIWDBEdit;
    lblTotaleA: TmeIWLabel;
    dedtOreTotaliIndennita: TmeIWDBEdit;
    dedtTotaleIndennita: TmeIWDBEdit;
    lblDatiTrasferta: TmeIWLabel;
    lblNoteRimborsi: TmeIWLabel;
    lnkCodiceTariffa: TmeIWLink;
    lblTipologia: TmeIWLabel;
    lnkCodiceRiduzione: TmeIWLink;
    dchkMissioneRiaperta: TmeIWDBCheckBox;
    memNoteRimborsi: TmeIWDBMemo;
    btnDettaglioPercorso: TmeIWButton;
    procedure cmbTipoMissioneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodiceTariffaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodiceRiduzioneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dedtDataAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCommessaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure chkIndennitaSupMaxGGClick(Sender: TObject);
    procedure dedtTariffaIndennitaTrasfertaInteraAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtOreIndennitaTrasfertaInteraAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtTariffaSuperoOreMassimeAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtOreSuperoOreMassimeAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtTariffaSuperoGiorniMeseAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtOreSuperoGiorniMeseAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtTariffaSuperoOreGiorniAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtOreSuperoOreGiorniAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbPartenzaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbDestinazioneAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dedtPeriodoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dedtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dedtOraDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dedtOraAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dChkModificaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure lnkCodiceClick(Sender: TObject);
    procedure btnDettaglioPercorsoClick(Sender: TObject);
  private
    WC015: TWC015FSelEditGridFM;
    procedure CaricaComboDinamiche;
    procedure AbilitaCampi(Valore: boolean);
  public
    procedure GestioneCampi;
    procedure CaricaComboCodiceTariffa;
    procedure CaricaComboCodiceRiduzione;
    procedure ImpostaCampiElaboraMissione;
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation
uses WA100UMissioni;
{$R *.dfm}

{ TWA100FMissioniDettFM }

procedure TWA100FMissioniDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  dChkModifica.Visible:=Parametri.CampiRiferimento.C8_GestioneMensile <> 'N';   //Se è prevista la gestione a cavallo di mese non visualizzo il campo
end;

procedure TWA100FMissioniDettFM.lnkCodiceClick(Sender: TObject);
var Par: String;
begin
  inherited;
  with (Self.Parent as TWA100FMissioni) do
  begin
    Par:='PROGRESSIVO=' + grdC700.WC700DM.selAnagrafe.FieldByName('PROGRESSIVO').AsString;
    AccediForm(180,Par,False);
  end;
end;

procedure TWA100FMissioniDettFM.AbilitaComponenti;
var editSelTabella: Boolean;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    if Parametri.CampiRiferimento.C8_GestioneMensile <> 'N' then  //Gestione mensile
      chkIndennitaSupMaxGG.Visible:=selTabella.State in [dsEdit, dsInsert];
    chkIndennitaSupMaxGG.Checked:=False;
    A100FMissioniMW.bIndennitaSupMaxGG:=chkIndennitaSupMaxGG.Checked;

    editSelTabella:=selTabella.State in [dsEdit,dsInsert];

    if editSelTabella then
    begin
      memNoteRimborsi.Enabled:=(A100FMissioniMW.Q050.RecordCount > 0) or (not selTabella.FieldByName('NOTE_RIMBORSI').IsNull);
      drgpFlagDetinazione.Enabled:=False;
      dChkIspettiva.Enabled:=False;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
      dchkMissioneRiaperta.Enabled:=False;
      // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
      AbilitaCampi(dChkModifica.Checked);
      //campi non editabili
      dedtTotaleIndennitaTrasfertaIntera.ReadOnly:=True;
      dedtTotaleSuperoOreMassime.ReadOnly:=True;
      dedtTotaleSuperoGiorniMese.ReadOnly:=True;
      dedtTotaleSuperoOreGiorni.ReadOnly:=True;
      dedtOreTotaliIndennita.ReadOnly:=True;
      dedtTotaleMissione.ReadOnly:=True;

      if A100FMissioniMW.Q010.Active then
      begin
        if A100FMissioniMW.Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
        begin
          cmbCodiceTariffa.Enabled:=True;
          cmbCodiceRiduzione.Enabled:=True;
        end
        else
        begin
          cmbCodiceTariffa.Enabled:=False;
          cmbCodiceRiduzione.Enabled:=False;
          selTabella.FieldByName('COD_TARIFFA').Clear;
          selTabella.FieldByName('COD_RIDUZIONE').Clear;
        end;
      end;
    end;
  end;
end;

procedure TWA100FMissioniDettFM.btnDettaglioPercorsoClick(Sender: TObject);
begin
  TWA100FMissioniDM(WR302DM).A100FMissioniMW.ApriDatasetPercorso(WR302DM.selTabella.FieldByName('ID').AsInteger);
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  WC015.grdElenco.medpPaginazione:=False;
  WC015.grdElenco.medpRowSelect:=False;
  WC015.Visualizza('Percorso trasferta',TWA100FMissioniDM(WR302DM).A100FMissioniMW.cdsM141,False,False);
end;

procedure TWA100FMissioniDettFM.CaricaComboCodiceTariffa;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //CODICE TARIFFA
    cmbCodiceTariffa.Items.Clear;
    Selm065.First;
    while not SelM065.Eof do
    begin
      cmbCodiceTariffa.AddRow(SelM065.FieldByName('COD_TARIFFA').AsString + ';' +
                              SelM065.FieldByName('DESCRIZIONE').AsString);
      Selm065.Next;
    end;
  end;
end;

procedure TWA100FMissioniDettFM.CaricaComboCodiceRiduzione;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //CODICE RIDUZIONE
    cmbCodiceRiduzione.Items.Clear;
    Selm066.First;
    while not SelM066.Eof do
    begin
      cmbCodiceRiduzione.AddRow(SelM066.FieldByName('COD_RIDUZIONE').AsString + ';' + SelM066.FieldByName('DESCRIZIONE').AsString);
      Selm066.Next;
    end;
  end;
end;

procedure TWA100FMissioniDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //TIPO MISSIONE
    cmbTipoMissione.Items.Clear;
    QM011.First;
    while not QM011.Eof do
    begin
      cmbTipoMissione.AddRow(QM011.FieldByName('CODICE').AsString + ';' +
                             QM011.FieldByName('DESCRIZIONE').AsString);
      QM011.Next;
    end;
    CaricaComboCodiceTariffa;
    CaricaComboCodiceRiduzione;

   // Carico la combo delle località di destinazione
    ImpostaQSourceDestinazione;
    CmbDestinazione.Items.Clear;
    While not QSource.Eof do
    begin
      CmbDestinazione.AddRow(QSource.FieldByName('DESTINAZIONE').AsString);
      QSource.Next;
    end;

    CaricaComboDinamiche;
  end;
end;

procedure TWA100FMissioniDettFM.CaricaComboDinamiche;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    AggiornaQueryCombo;
    //Commessa

    CmbCommessa.Items.Clear;
    QCommessa.First;
    // Carico la combo delle commesse
    While not QCommessa.Eof do
    begin
      if QCommessa.FieldByName('DESCRIZIONE').AsString <> '' then
        CmbCommessa.AddRow(QCommessa.FieldByName('CODICE').AsString + ';' + QCommessa.FieldByName('DESCRIZIONE').AsString)
      else
        CmbCommessa.AddRow(QCommessa.FieldByName('CODICE').AsString + ';' + QCommessa.FieldByName('CODICE').AsString);
      QCommessa.Next;
    end;

    //Partenza
    CmbPartenza.Items.Clear;
    While not QSede.Eof do
    begin
      if QSede.FieldByName('DESCRIZIONE').AsString <> '' then
         CmbPartenza.AddRow(QSede.FieldByName('CODICE').AsString + ';' + QSede.FieldByName('DESCRIZIONE').AsString)
      else
        CmbPartenza.AddRow(QSede.FieldByName('CODICE').AsString+ ';');
      QSede.Next;
    end;
  end;
end;

procedure TWA100FMissioniDettFM.chkIndennitaSupMaxGGClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    A100FMissioniMW.bIndennitaSupMaxGG:=chkIndennitaSupMaxGG.Checked;
    if Not(A100FMissioniMW.TabTariffe) then
      A100FMissioniMW.ElaboraMissione
    else
      A100FMissioniMW.ElaboraDaTariffe;
  end;
end;

procedure TWA100FMissioniDettFM.cmbCodiceRiduzioneAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  with (WR302DM as TWA100FMissioniDM) do
  begin
    selTabella.FieldByName('COD_RIDUZIONE').AsString:=cmbCodiceRiduzione.Text;
    lblDescCodiceRiduzione.Caption:=VarToStr(A100FMissioniMW.selM066.Lookup('COD_RIDUZIONE',cmbCodiceRiduzione.Text,'DESCRIZIONE'));
  end;
end;

procedure TWA100FMissioniDettFM.cmbCodiceTariffaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    selTabella.FieldByName('COD_TARIFFA').AsString:=cmbCodiceTariffa.Text;
    lblDescCodiceTariffa.Caption:=VarToStr(A100FMissioniMW.selM065.Lookup('COD_TARIFFA',cmbCodiceTariffa.Text,'DESCRIZIONE'));
  end;
end;

procedure TWA100FMissioniDettFM.cmbCommessaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('COMMESSA').AsString:=cmbCommessa.Text;
    //Aggiorna db label relativa
  end;
end;

procedure TWA100FMissioniDettFM.cmbDestinazioneAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('DESTINAZIONE').AsString:=CmbDestinazione.Text;
  end;
end;

procedure TWA100FMissioniDettFM.cmbPartenzaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('PARTENZA').AsString:=cmbPartenza.Text;
    //Aggiorna db label relativa
  end;
end;

procedure TWA100FMissioniDettFM.cmbTipoMissioneAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    selTabella.FieldByName('TIPOREGISTRAZIONE').AsString:=cmbTipoMissione.Text;
    //Aggiorna db label relativa
    //NON USARE validate del campo direttamente come in WIN perchè gli eventi
    //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
    //quindi si perde l'aggiornamento dei campi a video

    //Esegue DataDaValidate come evento onValidate di TipoRegistrazione di win. non so bene il perchè di questo
    A100FMissioniMW.M040DATADAValidate;

    if Not(selTabella.FieldByName('DATAA').IsNull) and (selTabella.FieldByName('TIPOREGISTRAZIONE').AsString <> '') then
      A100FMissioniMW.LeggiParametri(selTabella.FieldByName('DATAA').asDatetime,selTabella.FieldByName('TIPOREGISTRAZIONE').AsString);
    if A100FMissioniMW.Q010.Active then
    begin
      if A100FMissioniMW.Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S' then
      begin
        lnkCodiceTariffa.Enabled:=True;
        lnkCodiceRiduzione.Enabled:=True;
        cmbCodiceTariffa.Enabled:=True;
        cmbCodiceRiduzione.Enabled:=True;
      end
      else
      begin
        lnkCodiceTariffa.Enabled:=False;
        lnkCodiceRiduzione.Enabled:=False;
        cmbCodiceTariffa.Enabled:=False;
        cmbCodiceRiduzione.Enabled:=False;
        cmbCodiceTariffa.Text:='';
        cmbCodiceRiduzione.Text:='';
        selTabella.FieldByName('COD_TARIFFA').Clear;
        selTabella.FieldByName('COD_RIDUZIONE').Clear;
      end;
    end;
  end;
end;

procedure TWA100FMissioniDettFM.Componenti2DataSet;
begin
  inherited;
end;

procedure TWA100FMissioniDettFM.DataSet2Componenti;
var
 VisibleRichiestaWeb: Boolean;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM) do
  begin
    cmbTipoMissione.Text:=selTabella.FieldByName('TIPOREGISTRAZIONE').AsString;
    cmbCodiceTariffa.Text:=selTabella.FieldByName('COD_TARIFFA').AsString;
    //in partenza il dataset selM065 è chiuso poichè nessun progressivo di selAnagrafe è selezionato
    if A100FMissioniMW.selM065.Active then
      lblDescCodiceTariffa.Caption:=VarToStr(A100FMissioniMW.selM065.Lookup('COD_TARIFFA',cmbCodiceTariffa.Text,'DESCRIZIONE'));

    cmbCodiceRiduzione.Text:=selTabella.FieldByName('COD_RIDUZIONE').AsString;

    //in partenza il dataset selM066 è chiuso poichè nessun progressivo di selAnagrafe è selezionato
    if A100FMissioniMW.selM066.Active then
      LblDescCodiceRiduzione.Caption:=VarToStr(A100FMissioniMW.selM066.Lookup('COD_RIDUZIONE',cmbCodiceRiduzione.Text,'DESCRIZIONE'));

    VisibleRichiestaWeb:=not selTabella.FieldByName('ID').IsNull;
    drgpFlagDetinazione.Visible:=VisibleRichiestaWeb;
    dChkIspettiva.Visible:=VisibleRichiestaWeb;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.ini
    dchkMissioneRiaperta.Visible:=VisibleRichiestaWeb;
    // TORINO_REGIONE - commessa 2014/243 SVILUPPO#1.fine
    dlblAnnullata.Visible:=VisibleRichiestaWeb;
    C190VisualizzaElemento(jQuery,'divRichiestaWeb',VisibleRichiestaWeb);

    cmbCommessa.Text:=selTabella.FieldByName('COMMESSA').AsString;

    lblTarIndOr.Caption:=A100FMissioniMW.CaptionTariffaOraria;
    lblTarQuotaEsente.Caption:=A100FMissioniMW.CaptionTariffaQuotaEsente;

    CmbPartenza.Text:=selTabella.FieldByName('PARTENZA').AsString;
    CmbDestinazione.Text:=selTabella.FieldByName('DESTINAZIONE').AsString;

    // dettaglio percorso
    btnDettaglioPercorso.Enabled:=VisibleRichiestaWeb;

    if A100FMissioniMW.Q010TIPO_TARIFFA.AsString = 'G' then
      lblOreGiorni.Caption:='Giorni'
    else
      lblOreGiorni.Caption:='Ore in centesimi';

    A100FMissioniMW.Q010.Close;
    A100FMissioniMW.Q010.ClearVariables;
  end;
end;

procedure TWA100FMissioniDettFM.dChkModificaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  AbilitaCampi(dChkModifica.Checked);
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040DATAAValidate;
end;

procedure TWA100FMissioniDettFM.dedtDataAAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //NON USARE validate del campo direttamente come in WIN perchè gli eventi
    //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
    //quindi si perde l'aggiornamento dei campi a video
    M040DATAAValidate;
    CambioDate;
  end;

  //ricarico combo
  CaricaMultiColumnCombobox;
end;

procedure TWA100FMissioniDettFM.dedtDataDaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //NON USARE validate del campo direttamente come in WIN perchè gli eventi
    //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
    //quindi si perde l'aggiornamento dei campi a video
    M040DATADAValidate;
    CambioDate;
  end;

  //ricarico combo
  CaricaMultiColumnCombobox;
end;

procedure TWA100FMissioniDettFM.dedtOraAAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
   //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  with (WR302DM as TWA100FMissioniDM) do
    A100FMissioniMW.M040ORAValidate(selTabella.FieldByName('ORAA'));
end;

procedure TWA100FMissioniDettFM.dedtOraDaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
   //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  with (WR302DM as TWA100FMissioniDM) do
    A100FMissioniMW.M040ORAValidate(selTabella.FieldByName('ORADA'));
end;

procedure TWA100FMissioniDettFM.dedtOreIndennitaTrasfertaInteraAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDINTERAValidate;
end;

procedure TWA100FMissioniDettFM.dedtOreSuperoGiorniMeseAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDRIDOTTAGValidate;
end;

procedure TWA100FMissioniDettFM.dedtOreSuperoOreGiorniAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDRIDOTTAHGValidate;
end;

procedure TWA100FMissioniDettFM.dedtOreSuperoOreMassimeAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDRIDOTTAHValidate;
end;

procedure TWA100FMissioniDettFM.dedtPeriodoAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040MESESCARICOValidate;
end;

procedure TWA100FMissioniDettFM.dedtTariffaIndennitaTrasfertaInteraAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDINTERAValidate;
end;

procedure TWA100FMissioniDettFM.dedtTariffaSuperoGiorniMeseAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDRIDOTTAGValidate;
end;

procedure TWA100FMissioniDettFM.dedtTariffaSuperoOreGiorniAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDRIDOTTAHGValidate;
end;

procedure TWA100FMissioniDettFM.dedtTariffaSuperoOreMassimeAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //NON USARE validate del campo direttamente come in WIN perchè gli eventi
  //async non aspettano l'esecuzione del codice sepcificato nel validate e tornano al client
  //quindi si perde l'aggiornamento dei campi a video
  (WR302DM as TWA100FMissioniDM).A100FMissioniMW.M040INDRIDOTTAHValidate;
end;

procedure TWA100FMissioniDettFM.GestioneCampi;
begin

  //=======================================================
  //GESTIONE CAMPI PILOTATI DAL PARAMETRO SELEZIONE TARIFFA
  //NELLA MASCHERA DELLE REGOLE
  //=======================================================
  with (WR302DM as TWA100FMissioniDM) do
  begin
    if A100FMissioniMW.SelAnagrafe = nil then
      Exit;

    if Not(A100FMissioniMW.Q010.Active) then
      A100FMissioniMW.LeggiParametri(selTabella.FieldByName('DATAA').asDatetime,selTabella.FieldByName('TIPOREGISTRAZIONE').AsString);
    if (A100FMissioniMW.Q010.FieldByName('IND_DA_TAB_TARIFFE').AsString = 'S') then
    begin
      lblSuperoMaxGiorniMese.Visible:=False;
      dedtTariffaSuperoGiorniMese.Visible:=False;
      dedtOreSuperoGiorniMese.Visible:=False;
      dedtTotaleSuperoGiorniMese.Visible:=False;
      lblSuperoMaxOreGiorni.Visible:=False;
      dedtTariffaSuperoOreGiorni.Visible:=False;
      dedtOreSuperoOreGiorni.Visible:=False;
      dedtTotaleSuperoOreGiorni.Visible:=False;
      if selTabella.State in [dsEdit,dsInsert] then
      begin
        selTabella.FieldByName('OREINDRIDOTTAG').Clear;
        selTabella.FieldByName('IMPORTOINDRIDOTTAG').Clear;
        selTabella.FieldByName('TARIFFAINDRIDOTTAHG').Clear;
        selTabella.FieldByName('OREINDRIDOTTAHG').Clear;
        selTabella.FieldByName('TARIFFAINDRIDOTTAG').Clear;
        selTabella.FieldByName('IMPORTOINDRIDOTTAHG').Clear;
      end;
      lblSupOreMasRimbPasto.Caption:='Quota assoggettata a tassazione';
      lblIndTrasfInt.Caption:='Quota esente da tassazione';
    end
    else
    begin
      lblSuperoMaxGiorniMese.Visible:=True;
      dedtTariffaSuperoGiorniMese.Visible:=True;
      dedtOreSuperoGiorniMese.Visible:=True;
      dedtTotaleSuperoGiorniMese.Visible:=True;

      lblSuperoMaxOreGiorni.Visible:=True;
      dedtTariffaSuperoOreGiorni.Visible:=True;
      dedtOreSuperoOreGiorni.Visible:=True;
      dedtTotaleSuperoOreGiorni.Visible:=True;
      lblSupOreMasRimbPasto.Caption:='Al supero ore massime/rimborso pasto';
      lblIndTrasfInt.Caption:='Indennità di trasferta intera';
    end;
  end;
end;

procedure TWA100FMissioniDettFM.AbilitaCampi(Valore:boolean);
begin
  //Pannello 1
  dedtTotaleGiorni.enabled:=valore;
  dedtTotaleOre.enabled:=valore;
  //Pannello 2
  dedtTariffaIndennitaTrasfertaIntera.enabled:=valore;
  dedtOreIndennitaTrasfertaIntera.enabled:=valore;
  dedtTariffaSuperoOreMassime.enabled:=valore;
  dedtOreSuperoOreMassime.enabled:=valore;
  dedtTariffaSuperoGiorniMese.enabled:=valore;
  dedtOreSuperoGiorniMese.enabled:=valore;
  dedtTariffaSuperoOreGiorni.enabled:=valore;
  dedtOreSuperoOreGiorni.enabled:=valore;
end;

procedure TWA100FMissioniDettFM.ImpostaCampiElaboraMissione;
var
  sCodice,sDescrizione : String;
begin
  with (WR302DM as TWA100FMissioniDM) do
  begin
    if A100FMissioniMW.Q010.FieldByName('TIPO_TARIFFA').AsString = 'G' then // Tariffa giornaliera...
      lblOreGiorni.Caption:='Giorni'
    else
      lblOreGiorni.Caption:='Ore in centesimi';
    // Propongo, se presente, nel campo Località di Partenza la sede
    // di assunzione del dipendente
    if (trim(CmbPartenza.Text) = '') then
    begin
      A100FMissioniMW.GetSede(A100FMissioniMW.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,selTabella.FieldByName('DATAA').AsDateTime, selTabella.FieldByName('DATAA').AsDateTime,sCodice,sDescrizione);
      CmbPartenza.Text:=sCodice;
      selTabella.FieldByName('PARTENZA').AsString:=CmbPartenza.Text; // il campo descrizione è lookup in base a partenza
    end;

  // Propongo il dato collegato al campo COMMESSA per il dipendente...
  if (trim(CmbCommessa.Text) = '') then
    A100FMissioniMW.GetCommessa(A100FMissioniMW.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,selTabella.FieldByName('DATAA').AsDateTime, selTabella.FieldByName('DATAA').AsDateTime,sCodice,sDescrizione);
    CmbCommessa.Text:=sCodice;
    selTabella.FieldByName('COMMESSA').AsString:=CmbCommessa.Text; // il campo descrizione è lookup in base a commessa
  end;
end;

end.
