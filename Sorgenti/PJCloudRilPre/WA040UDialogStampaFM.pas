unit WA040UDialogStampaFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, meIWRadioGroup,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWCompEdit, meIWEdit, IWDBStdCtrls, meIWDBEdit, IWCompListbox,
  meIWDBComboBox, meIWDBLookupComboBox, IWCompCheckbox, meIWCheckBox, StrUtils,
  IWCompButton, meIWButton, meIWImageFile, medpIWImageButton, Math, C004UParamForm, OracleData,
  A000UCostanti, A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb, WC013UCheckListFM,
  medpIWMultiColumnComboBox, QRPrntr, Generics.Collections, A040UPianifRepMW, DBXJSON, IWHTMLControls, meIWLink {$IF CompilerVersion >= 31},System.JSON{$ENDIF};

type
  T040StmGenProc = procedure of object;

  TWA040FDialogStampaFM = class(TWR200FBaseFM)
    lblTipoStampa: TmeIWLabel;
    rgpTipoStampa: TmeIWRadioGroup;
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    lblPeriodo: TmeIWLabel;
    lblTitolo: TmeIWLabel;
    edtTitolo: TmeIWEdit;
    lblCampoRaggr: TmeIWLabel;
    dcmbCampoRaggr: TmeIWDBLookupComboBox;
    chkSaltoPagina: TmeIWCheckBox;
    lblTurni: TmeIWLabel;
    edtTurni: TmeIWEdit;
    btnScegliTurni: TmeIWButton;
    rgpSelTurni: TmeIWRadioGroup;
    lblSelTurni: TmeIWLabel;
    chkIncludiNonPianif: TmeIWCheckBox;
    chkLegenda: TmeIWCheckBox;
    lblDettaglioTabellone: TmeIWLabel;
    lblDatiPianif: TmeIWLabel;
    chkCodice: TmeIWCheckBox;
    chkOrario: TmeIWCheckBox;
    chkDatoLibero: TmeIWCheckBox;
    rgpDatiAssenza: TmeIWRadioGroup;
    lblDatiAssenza: TmeIWLabel;
    edtSiglaAssenza: TmeIWEdit;
    lblCampoDett: TmeIWLabel;
    dcmbCampoDett: TmeIWDBLookupComboBox;
    btnGeneraPDF: TmedpIWImageButton;
    lblFont: TmeIWLabel;
    cmbFontName: TMedpIWMultiColumnComboBox;
    cmbFontSize: TMedpIWMultiColumnComboBox;
    cmbOrientamentoPag: TMedpIWMultiColumnComboBox;
    lblOrientamentoPag: TmeIWLabel;
    lblFormatoPag: TmeIWLabel;
    cmbFormatoPag: TMedpIWMultiColumnComboBox;
    lblCampoConNom: TmeIWLabel;
    dcmbCampoConNom: TmeIWDBLookupComboBox;
    chkNomeCompleto: TmeIWCheckBox;
    chkSigla: TmeIWCheckBox;
    chkPriorita: TmeIWCheckBox;
    chkOrarioInRiga: TmeIWCheckBox;
    chkDatiAggiuntivi: TmeIWCheckBox;
    chkDatiAggInRiga: TmeIWCheckBox;
    lblProfilo: TmeIWLabel;
    lblGLayout: TmeIWLabel;
    lblGTitolo: TmeIWLabel;
    lblDimensione: TmeIWLabel;
    lblTitoloSize: TmeIWLabel;
    cmbFontTitoloSize: TMedpIWMultiColumnComboBox;
    chkTitoloBold: TmeIWCheckBox;
    chkTitoloUnderline: TmeIWCheckBox;
    dCmbLkpProfili: TmeIWDBLookupComboBox;
    lnkProfilo: TmeIWLink;
    rgpCampoDettaglio: TmeIWRadioGroup;
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure dcmbCampoRaggrChange(Sender: TObject);
    procedure edtDataAAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure btnScegliTurniClick(Sender: TObject);
    procedure rgpSelTurniAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure rgpDatiAssenzaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure chkCodiceAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkOrarioAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkDatiAggiuntiviAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure edtTitoloAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure dCmbLkpProfiliChange(Sender: TObject);
    procedure lnkProfiloClick(Sender: TObject);
    procedure rgpCampoDettaglioClick(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    FLstTitoli: TStringList;
    procedure GetParametriFunzioneStm;
    procedure PutParametriFunzioneStm;
    procedure ResultSelTurni(Sender: TObject; Result:Boolean);
    procedure AbilitaSiglaAssenza;
    procedure CorreggiTitolo;
    procedure AbilitaComponenti(pAbilita: Boolean);
    procedure CaricaTemplate;
  public
    A040MWStm: TA040FPianifRepMW;
    C004DMStm: TC004FParamForm;
    evtEseguiStampa: T040StmGenProc;
    procedure OperazioniIniziali;
    procedure Visualizza;
    function CreateJSonString: String;
    procedure ReleaseOggetti; override;
  end;

implementation

{$IFDEF WEBPJ}
uses WR100UBase;
{$ENDIF}

{$R *.dfm}

procedure TWA040FDialogStampaFM.OperazioniIniziali;
var
  lstFonts: TList<String>;
  FontName, s: String;
  Found: boolean;
  i: Integer;
  ps: TQRPaperSize;
begin
  inherited;
  with A040MWStm do
  begin
    dcmbCampoRaggr.ListSource:=D010;
    dcmbCampoDett.ListSource:=D010B;
    dcmbCampoConNom.ListSource:=D010C;
    dCmbLkpProfili.ListSource:=drsT355;

    cmbFontSize.Items.Clear;
    for i:=8 to 30 do
      cmbFontSize.AddRow(i.toString);
    cmbFontSize.Text:='8';

    cmbFontTitoloSize.Items.Clear;
    for i:=8 to 30 do
      cmbFontTitoloSize.AddRow(i.toString);
    cmbFontTitoloSize.Text:='10';

    //fonts
    LoadFontList(lstSystemFonts);
    lstFonts:=TList<String>.Create(lstSystemFonts);
    try
      //se font preimpostato non trovato nella lista lo aggiungo
      FontName:='Courier New';
      Found:=False;
      for s in lstFonts do
      begin
        if s.ToUpper = FontName.ToUpper then
        begin
          Found:=true;
          Break;
        end;
      end;
      if not Found then
        lstFonts.Add(FontName);

      lstFonts.Sort;

      cmbFontName.Items.Clear;
      for s in lstFonts do
        cmbFontName.AddRow(s);
      cmbFontName.Text:=FontName;
    finally
      FreeAndNil(lstFonts);
    end;
    //Orientamento
    cmbOrientamentoPag.Items.Clear;
    cmbOrientamentoPag.AddRow(NONIMPOSTATO);
    cmbOrientamentoPag.AddRow(VERTICALE);
    cmbOrientamentoPag.AddRow(ORIZZONTALE);
    cmbOrientamentoPag.Text:=NONIMPOSTATO;
    //Formato pagina
    cmbFormatoPag.Items.Clear;
    cmbFormatoPag.AddRow(NONIMPOSTATO);
    for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
      cmbFormatoPag.AddRow(QRPaperName(ps));
    cmbFormatoPag.Text:=NONIMPOSTATO;
  end;
  GetParametriFunzioneStm;

  {if dCmbLkpProfili.KeyValue <> '' then
    dCmbLkpProfiliChange(dCmbLkpProfili);}
end;

procedure TWA040FDialogStampaFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  FLstTitoli:=TStringList.Create;
  {$IFDEF WEBPJ}
  lnkProfilo.Visible:=True;
  lblProfilo.Visible:=False;
  {$ENDIF}
end;

procedure TWA040FDialogStampaFM.lnkProfiloClick(Sender: TObject);
begin
  inherited;
  {$IFDEF WEBPJ} //Solo se Cloud
    //IrisCloud link a WA207
    (Self.Parent as TWR100FBase).AccediForm(185,'CODICE=' + dCmbLkpProfili.KeyValue);
  {$ENDIF}
end;

procedure TWA040FDialogStampaFM.ReleaseOggetti;
begin
  PutParametriFunzioneStm;
  FreeAndNil(FLstTitoli);
end;

procedure TWA040FDialogStampaFM.GetParametriFunzioneStm;
{Leggo i parametri della form}
var
  i: Integer;
begin
  if C004DMStm <> nil then
    with C004DMStm do
    begin
      rgpTipoStampa.ItemIndex:=max(0,StrToInt(GetParametro('TIPOSTAMPA','0')));
      FLstTitoli.Clear;
      for i:=0 to rgpTipoStampa.Items.Count - 1 do
        FLstTitoli.Add(GetParametro(Format('TITOLO_%d',[i]),''));
      edtTitolo.Text:=GetParametro(Format('TITOLO_%d',[rgpTipoStampa.ItemIndex]),GetParametro('TITOLO',''));
      // salva il titolo corrente nel corrispondente elemento
      FLstTitoli[rgpTipoStampa.ItemIndex]:=edtTitolo.Text;
      dcmbCampoRaggr.KeyValue:=GetParametro('CAMPORAGGR','');
      chkSaltoPagina.Checked:=GetParametro('SALTOPAGINA','N') = 'S';
      rgpSelTurni.ItemIndex:=StrToInt(GetParametro('SELTURNI','0'));
      edtTurni.Text:=GetParametro('ELENCOTURNI','');
      dcmbCampoConNom.KeyValue:=GetParametro('CAMPOCONNOM','');
      chkNomeCompleto.Checked:=GetParametro('NOMECOMPLETO','S') = 'S';
      chkIncludiNonPianif.Checked:=GetParametro('INCLUDINONPIANIF','S') = 'S';
      chkLegenda.Checked:=GetParametro('LEGENDA','N') = 'S';
      chkCodice.Checked:=GetParametro('TURNO_CODICE','N') = 'S';
      chkSigla.Enabled:=chkCodice.Checked;
      chkSigla.Checked:=chkCodice.Checked and (GetParametro('TURNO_SIGLA','N') = 'S');
      chkPriorita.Enabled:=chkCodice.Checked;
      chkPriorita.Checked:=chkCodice.Checked and (GetParametro('TURNO_PRIORITA','S') = 'S');
      chkOrario.Checked:=GetParametro('TURNO_ORARIO','N') = 'S';
      chkOrarioInRiga.Enabled:=chkOrario.Checked;
      chkOrarioInRiga.Checked:=chkOrario.Checked and (GetParametro('TURNO_ORARIOINRIGA','N') = 'S');
      chkDatoLibero.Checked:=GetParametro('TURNO_DATOLIBERO','N') = 'S';
      chkDatiAggiuntivi.Checked:=GetParametro('TURNO_DATIAGGIUNTIVI','N') = 'S';
      chkDatiAggInRiga.Enabled:=chkDatiAggiuntivi.Checked;
      chkDatiAggInRiga.Checked:=chkDatiAggiuntivi.Checked and (GetParametro('TURNO_DATIAGGINRIGA','N') = 'S');
      rgpDatiAssenza.ItemIndex:=StrToInt(GetParametro('DATIASSENZA','0'));
      edtSiglaAssenza.Text:=GetParametro('SIGLAASSENZA','ASS');
      dcmbCampoDett.KeyValue:=GetParametro('CAMPODETT','');
      cmbFontName.Text:=GetParametro('FONTNAME','Courier New');
      if Trim(cmbFontName.Text) = '' then
        cmbFontName.Text:='Courier New';
      cmbFontSize.Text:=GetParametro('FONTSIZE','8');
      if Trim(cmbFontSize.Text) = '' then
        cmbFontSize.Text:='8';
      cmbFontSize.Text:=GetParametro('FONTSIZE','8');
      if Trim(cmbFontTitoloSize.Text) = '' then
        cmbFontTitoloSize.Text:='10';
      chkTitoloBold.Checked:=GetParametro('TITOLO_BOLD','S') = 'S';
      chkTitoloUnderline.Checked:=GetParametro('TITOLO_UNDERLINE','N') = 'S';
      cmbOrientamentoPag.Text:=GetParametro('ORIENTAMENTOPAG',A040MWStm.NONIMPOSTATO);
      if Trim(cmbOrientamentoPag.Text) = '' then
        cmbOrientamentoPag.Text:=A040MWStm.NONIMPOSTATO;
      cmbFormatoPag.Text:=GetParametro('FORMATOPAG',A040MWStm.NONIMPOSTATO);
      if Trim(cmbFormatoPag.Text) = '' then
        cmbFormatoPag.Text:=A040MWStm.NONIMPOSTATO;
      dCmbLkpProfili.KeyValue:=GetParametro('PROFILO','');
      rgpCampoDettaglio.ItemIndex:=StrToInt(GetParametro('DETTAGLIO','0'));
    end;
end;

procedure TWA040FDialogStampaFM.PutParametriFunzioneStm;
{Scrivo i parametri della form}
var
  i: Integer;
begin
  if C004DMStm <> nil then
    with C004DMStm do
    begin
      Cancella001;
      PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
      // salva il titolo corrente nel corrispondente elemento
      FLstTitoli[rgpTipoStampa.ItemIndex]:=edtTitolo.Text;
      for i:=0 to rgpTipoStampa.Items.Count - 1 do
        PutParametro(Format('TITOLO_%d',[i]),FLstTitoli[i]);
      PutParametro('TITOLO',''); // non più utilizzato
      PutParametro('CAMPORAGGR',VarToStr(dcmbCampoRaggr.KeyValue));
      PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
      PutParametro('SELTURNI',IntToStr(rgpSelTurni.ItemIndex));
      PutParametro('ELENCOTURNI',edtTurni.Text);
      PutParametro('CAMPOCONNOM',VarToStr(dcmbCampoConNom.KeyValue));
      PutParametro('NOMECOMPLETO',IfThen(chkNomeCompleto.Checked,'S','N'));
      PutParametro('INCLUDINONPIANIF',IfThen(chkIncludiNonPianif.Checked,'S','N'));
      PutParametro('LEGENDA',IfThen(chkLegenda.Checked,'S','N'));
      PutParametro('TURNO_CODICE',IfThen(chkCodice.Checked,'S','N'));
      PutParametro('TURNO_SIGLA',IfThen(chkSigla.Checked,'S','N'));
      PutParametro('TURNO_PRIORITA',IfThen(chkPriorita.Checked,'S','N'));
      PutParametro('TURNO_ORARIO',IfThen(chkOrario.Checked,'S','N'));
      PutParametro('TURNO_ORARIOINRIGA',IfThen(chkOrario.Checked,'S','N'));
      PutParametro('TURNO_DATOLIBERO',IfThen(chkDatoLibero.Checked,'S','N'));
      PutParametro('TURNO_DATIAGGIUNTIVI',IfThen(chkDatiAggiuntivi.Checked,'S','N'));
      PutParametro('TURNO_DATIAGGINRIGA',IfThen(chkDatiAggInRiga.Checked,'S','N'));
      PutParametro('DATIASSENZA',IntToStr(rgpDatiAssenza.ItemIndex));
      PutParametro('SIGLAASSENZA',edtSiglaAssenza.Text);
      PutParametro('CAMPODETT',VarToStr(dcmbCampoDett.KeyValue));
      PutParametro('FONTNAME',cmbFontName.Text);
      PutParametro('FONTSIZE',cmbFontSize.Text);
      PutParametro('ORIENTAMENTOPAG',cmbOrientamentoPag.Text);
      PutParametro('FORMATOPAG',cmbFormatoPag.Text);
      PutParametro('TITOLO_SIZE',cmbFontTitoloSize.Text);
      PutParametro('TITOLO_BOLD',IfThen(chkTitoloBold.Checked,'S','N'));
      PutParametro('TITOLO_UNDERLINE',IfThen(chkTitoloUnderline.Checked,'S','N'));
      PutParametro('PROFILO',VarToStr(dCmbLkpProfili.KeyValue));
      PutParametro('DETTAGLIO',VarToStr(rgpCampoDettaglio.ItemIndex));
      try SessioneOracle.Commit; except end;
    end;
end;

procedure TWA040FDialogStampaFM.Visualizza;
begin
  inherited;
  // periodo stampa
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(A040MWStm.DataSt));
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(A040MWStm.DataSt));
  dCmbLkpProfiliChange(dCmbLkpProfili);
  if VarToStr(dCmbLkpProfili.KeyValue) = '' then
  begin
    // priorità
    chkPriorita.Visible:=A040MWStm.CodTipologia = 'R';
    // dati aggiuntivi
    chkDatiAggiuntivi.Visible:=(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') and (A040MWStm.CodTipologia = 'R');
    chkDatiAggInRiga.Visible:=chkDatiAggiuntivi.Visible and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '');
    // dato libero pianif. (nascosto se gestisco dati aggiuntivi)
    chkDatoLibero.Visible:=(Parametri.CampiRiferimento.C3_DatoPianificabile <> '') and not chkDatiAggiuntivi.Visible;
    chkDatoLibero.Caption:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile) + ' pianificato';
    rgpTipoStampaClick(nil);
  end;
end;

procedure TWA040FDialogStampaFM.CorreggiTitolo;
// rimuove la data dal titolo per evitare disallineamenti
var
  LTitolo: string;
begin
  // PRE: rgpTipoStampa.ItemIndex > 0
  if rgpTipoStampa.ItemIndex = 0 then
    Exit;

  // verifica se il titolo è quello fisso
  LTitolo:=edtTitolo.Text;
  if LTitolo.StartsWith('Turni di ' + A040MWStm.sTipo + ' del mese di: ') then
  begin
    edtTitolo.Text:='Turni di ' + A040MWStm.sTipo;
    FLstTitoli[rgpTipoStampa.ItemIndex];
  end;
end;

procedure TWA040FDialogStampaFM.rgpTipoStampaClick(Sender: TObject);
begin
  with A040MWStm do
    case rgpTipoStampa.ItemIndex of
      0: begin
           // tabellone mensile
           edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(DataSt));
           edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(DataSt));
           edtTitolo.Text:='Turni di ' + sTipo + ' del mese di: ' + R180NomeMese(R180Mese(DataSt)) + ' ' + IntToStr(R180Anno(DataSt));
         end;
      1: begin
           // tabellone personalizzato
           AbilitaSiglaAssenza;
         end;
      2: begin
           // prospetto per dipendente
           if R180NumOccorrenzeCar(edtTurni.Text,',') >= 4 then
             edtTurni.Text:='';
         end;
    end;

  // imposta il titolo nel caso la stampa non sia il tabellone mensile (che ha titolo fisso)
  if rgpTipoStampa.ItemIndex > 0 then
  begin
    edtTitolo.Text:=FLstTitoli[rgpTipoStampa.ItemIndex];
    CorreggiTitolo;
  end;

  edtDataDa.Enabled:=rgpTipoStampa.ItemIndex <> 0;
  edtDataA.Enabled:=rgpTipoStampa.ItemIndex <> 0;
  edtTitolo.Enabled:=rgpTipoStampa.ItemIndex <> 0;

  // scelta turni
  C190VisualizzaElemento(JQuery,'grpTurni',rgpTipoStampa.ItemIndex > 0);
  lblTurni.Visible:=rgpTipoStampa.ItemIndex > 0;
  edtTurni.Visible:=rgpTipoStampa.ItemIndex > 0;
  btnScegliTurni.Visible:=rgpTipoStampa.ItemIndex > 0;
  lblSelTurni.Visible:=rgpTipoStampa.ItemIndex > 0;
  rgpSelTurni.Visible:=rgpTipoStampa.ItemIndex > 0;
  // campo con nominativo
  lblCampoConNom.Visible:=rgpTipoStampa.ItemIndex in [1,2];
  dcmbCampoConNom.Visible:=rgpTipoStampa.ItemIndex in [1,2];
  chkNomeCompleto.Visible:=rgpTipoStampa.ItemIndex in [1,2];
  // opzioni tabellone
  chkIncludiNonPianif.Visible:=rgpTipoStampa.ItemIndex = 1;
  chkLegenda.Visible:=rgpTipoStampa.ItemIndex = 1;
  // dettaglio cella tabellone
  C190VisualizzaElemento(JQuery,'grpDettaglioTabellone',rgpTipoStampa.ItemIndex = 1);
  lblDettaglioTabellone.Visible:=rgpTipoStampa.ItemIndex = 1;
  lblDatiPianif.Visible:=rgpTipoStampa.ItemIndex = 1;
  chkCodice.Visible:=rgpTipoStampa.ItemIndex = 1;
  chkSigla.Visible:=chkCodice.Visible;
  chkOrario.Visible:=rgpTipoStampa.ItemIndex = 1;
  chkOrarioInRiga.Visible:=chkOrario.Visible;
  chkDatiAggiuntivi.Visible:=(rgpTipoStampa.ItemIndex = 1) and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') and (A040MWStm.CodTipologia = 'R');
  chkDatiAggInRiga.Visible:=chkDatiAggiuntivi.Visible and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '');
  chkDatoLibero.Visible:=(rgpTipoStampa.ItemIndex = 1) and (Parametri.CampiRiferimento.C3_DatoPianificabile <> '') and not chkDatiAggiuntivi.Visible;
  lblDatiAssenza.Visible:=rgpTipoStampa.ItemIndex = 1;
  rgpDatiAssenza.Visible:=rgpTipoStampa.ItemIndex = 1;
  edtSiglaAssenza.Visible:=rgpTipoStampa.ItemIndex = 1;
  // campo di dettaglio anagrafico
  C190VisualizzaElemento(JQuery,'grpDettaglio',rgpTipoStampa.ItemIndex = 2);
  lblCampoDett.Visible:=rgpTipoStampa.ItemIndex = 2;
  dcmbCampoDett.Visible:=rgpTipoStampa.ItemIndex = 2;
  rgpCampoDettaglio.Visible:=rgpTipoStampa.ItemIndex = 2;

  // abilita salto pagina in base a selezione
  chkSaltoPagina.Enabled:=((rgpTipostampa.ItemIndex = 1) or (rgpTipostampa.ItemIndex = 2)) and
                          (VarToStr(dcmbCampoRaggr.KeyValue) <> '');
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;

  edtDataDa.Text:=IfThen(edtDataDa.Text <> '', edtDataDa.Text, FormatDateTime('dd/mm/yyyy',R180InizioMese(A040MWStm.DataSt)));
  edtDataA.Text:=IfThen(edtDataA.Text <> '', edtDataA.Text, FormatDateTime('dd/mm/yyyy',R180FineMese(A040MWStm.DataSt)));
  A040MWStm.StampaTurniOttimizzata:=(rgpTipostampa.ItemIndex = 2) and (rgpSelTurni.ItemIndex = 0) and (dcmbCampoRaggr.KeyValue <> '');
  edtTurni.Text:=A040MWStm.GetCodiciTurnoUtilizzati(edtTurni.Text,edtDataDa.Text,edtDataA.Text,rgpTipoStampa.ItemIndex,rgpSelTurni.ItemIndex);
end;

procedure TWA040FDialogStampaFM.edtDataAAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
var D: TDateTime;
begin
  if TryStrToDate(edtDataDa.Text,D) then
    edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(D));
end;

procedure TWA040FDialogStampaFM.edtTitoloAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  FLstTitoli[rgpTipoStampa.ItemIndex]:=edtTitolo.Text;
end;

procedure TWA040FDialogStampaFM.dcmbCampoRaggrChange(Sender: TObject);
begin
  inherited;
  if ((rgpTipostampa.ItemIndex <> 1) and (rgpTipostampa.ItemIndex <> 2)) or
     (VarToStr(dcmbCampoRaggr.KeyValue) = '') then
  begin
    chkSaltoPagina.Checked:=False;
    chkSaltoPagina.Enabled:=False;
  end
  else
    chkSaltoPagina.Enabled:=True;
end;

procedure TWA040FDialogStampaFM.dCmbLkpProfiliChange(Sender: TObject);
begin
  inherited;
  if VarToStr(dCmbLkpProfili.KeyValue) <> '' then
  begin
    A040MWStm.selT355.SearchRecord('CODICE',dCmbLkpProfili.KeyValue,[srFromBeginning]);
    CaricaTemplate;
    AbilitaComponenti(False);
  end
  else
    AbilitaComponenti(True);
end;

procedure TWA040FDialogStampaFM.btnScegliTurniClick(Sender: TObject);
var Elem: String;
    LenCod: Integer;
begin
  // apre dataset dei turni da visualizzare
  with A040MWStm do
  begin
    RecuperaTurni(rgpSelTurni.ItemIndex);
    LenCod:=IfThen(rgpSelTurni.ItemIndex = 0,5,11);
    WC013:=TWC013FCheckListFM.Create(Self.Parent);
    with WC013 do
    begin
      ckList.Items.BeginUpdate;
      ckList.Items.Clear;
      selT350Cod.First;
      while not selT350Cod.Eof do
      begin
        if rgpSelTurni.ItemIndex = 0 then
        begin
          Elem:=Format('%-5s %s',[selT350Cod.FieldByName('CODICE').AsString,selT350Cod.FieldByName('DESCRIZIONE').AsString]);
          ckList.Items.Add(Elem);
        end
        else
        begin
          Elem:=Format('%-5s-%-5s',[selT350Cod.FieldByName('HINI').AsString,selT350Cod.FieldByName('HFINE').AsString]);
          if ckList.Items.IndexOf(Elem) < 0 then
            ckList.Items.Add(Elem);
        end;
        selT350Cod.Next;
      end;
      ckList.Items.EndUpdate;
      C190PutCheckList(edtTurni.Text,LenCod,ckList);
      ResultEvent:=ResultSelTurni;
      Visualizza(0,IfThen((rgpTipoStampa.ItemIndex = 2) and (rgpSelTurni.ItemIndex = 1),MAX_CODICI,0));
    end;
  end;
end;

procedure TWA040FDialogStampaFM.CaricaTemplate;
begin
  if A040MWStm.selT355.FieldByName('TIPO').AsString = 'M' then
    rgpTipoStampa.ItemIndex:=0
  else if A040MWStm.selT355.FieldByName('TIPO').AsString = 'P' then
    rgpTipoStampa.ItemIndex:=1
  else if A040MWStm.selT355.FieldByName('TIPO').AsString = 'D' then
    rgpTipoStampa.ItemIndex:=2
  else if A040MWStm.selT355.FieldByName('TIPO').AsString = 'R' then
    rgpTipoStampa.ItemIndex:=4;

  rgpTipoStampaClick(rgpTipoStampa);

  edtTitolo.Text:=A040MWStm.selT355.FieldByName('TITOLO').AsString;
  dcmbCampoRaggr.KeyValue:=A040MWStm.selT355.FieldByName('CAMPO_RAGGRUPPAMENTO').AsString;
  chkSaltoPagina.Checked:=A040MWStm.selT355.FieldByName('SALTO_PAGINA').AsString = 'S';

  if A040MWStm.selT355.FieldByName('SELEZIONE').AsString = 'C' then
    rgpSelTurni.ItemIndex:=0
  else if A040MWStm.selT355.FieldByName('SELEZIONE').AsString = 'O' then
    rgpSelTurni.ItemIndex:=1;
  edtTurni.Text:=A040MWStm.selT355.FieldByName('TURNI').AsString;

  dcmbCampoConNom.KeyValue:=A040MWStm.selT355.FieldByName('CAMPO_NOMINATIVO').AsString;
  chkNomeCompleto.Checked:=A040MWStm.selT355.FieldByName('NOME_COMPLETO').AsString = 'S';
  chkIncludiNonPianif.Checked:=A040MWStm.selT355.FieldByName('DIP_NP').AsString = 'S';
  chkLegenda.Checked:=A040MWStm.selT355.FieldByName('LEGENDA').AsString = 'S';

  chkCodice.Checked:=A040MWStm.selT355.FieldByName('DETT_CODICE').AsString = 'S';
  chkSigla.Checked:=A040MWStm.selT355.FieldByName('DETT_SIGLA').AsString = 'S';
  chkPriorita.Checked:=A040MWStm.selT355.FieldByName('DETT_PRIORITA').AsString = 'S';
  chkOrario.Checked:=A040MWStm.selT355.FieldByName('DETT_ORARIO').AsString = 'S';
  chkOrarioInRiga.Checked:=A040MWStm.selT355.FieldByName('DETT_ORARIO_RIGA').AsString = 'S';
  chkDatiAggiuntivi.Checked:=A040MWStm.selT355.FieldByName('DETT_DATI_AGG').AsString = 'S';
  chkDatiAggInRiga.Checked:=A040MWStm.selT355.FieldByName('DETT_DATI_AGG_RIGA').AsString = 'S';
  chkDatoLibero.Checked:=A040MWStm.selT355.FieldByName('DETT_DATO_LIBERO').AsString = 'S';

  if A040MWStm.selT355.FieldByName('DETT_ASSENZA').AsString = 'N' then
    rgpDatiAssenza.ItemIndex:=0
  else if A040MWStm.selT355.FieldByName('DETT_ASSENZA').AsString = 'C' then
    rgpDatiAssenza.ItemIndex:=1
  else if A040MWStm.selT355.FieldByName('DETT_ASSENZA').AsString = 'S' then
    rgpDatiAssenza.ItemIndex:=2;

  edtSiglaAssenza.Text:=A040MWStm.selT355.FieldByName('DETT_SIGLA_ASSENZA').AsString;

  cmbFontName.Text:=A040MWStm.selT355.FieldByName('FONTNAME').AsString;
  if A040MWStm.selT355.FieldByName('ORIENTAMENTO').AsString = 'O' then
    cmbOrientamentoPag.Text:=A040MWStm.ORIZZONTALE
  else if A040MWStm.selT355.FieldByName('ORIENTAMENTO').AsString = 'V' then
    cmbOrientamentoPag.Text:=A040MWStm.VERTICALE
  else if A040MWStm.selT355.FieldByName('ORIENTAMENTO').AsString = 'A' then
    cmbOrientamentoPag.Text:=A040MWStm.NONIMPOSTATO
  else
    cmbOrientamentoPag.Text:='';

  cmbFontSize.Text:=A040MWStm.selT355.FieldByName('FONTSIZE').AsString;
  cmbFontTitoloSize.Text:=A040MWStm.selT355.FieldByName('TITOLO_SIZE').AsString;
  chkTitoloBold.Checked:=A040MWStm.selT355.FieldByName('TITOLO_BOLD').AsString = 'S';
  chkTitoloUnderline.Checked:=A040MWStm.selT355.FieldByName('TITOLO_UNDERLINE').AsString = 'S';
  cmbFormatoPag.Text:=A040MWStm.selT355.FieldByName('FORMATO').AsString;

  dcmbCampoDett.KeyValue:=A040MWStm.selT355.FieldByName('CAMPO_DETTAGLIO').AsString;
  rgpCampoDettaglio.ItemIndex:=IfThen(A040MWStm.selT355.FieldByName('DETTAGLIO').AsString = 'R',1,0);
end;

procedure TWA040FDialogStampaFM.chkCodiceAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  chkSigla.Enabled:=chkCodice.Checked;
  if not chkSigla.Enabled then
    chkSigla.Checked:=False;
  chkPriorita.Enabled:=chkCodice.Checked;
  if not chkPriorita.Enabled then
    chkPriorita.Checked:=False;
end;

procedure TWA040FDialogStampaFM.chkOrarioAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  chkOrarioInRiga.Enabled:=chkOrario.Checked;
  if not chkOrarioInRiga.Enabled then
    chkOrarioInRiga.Checked:=False;
end;

procedure TWA040FDialogStampaFM.chkDatiAggiuntiviAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  chkDatiAggInRiga.Enabled:=chkDatiAggiuntivi.Checked;
  if not chkDatiAggInRiga.Enabled then
    chkDatiAggInRiga.Checked:=False;
end;

procedure TWA040FDialogStampaFM.ResultSelTurni(Sender: TObject; Result:Boolean);
var LenCod: Integer;
begin
  LenCod:=IfThen(rgpSelTurni.ItemIndex = 0,5,11);
  if Result then
    edtTurni.Text:=C190GetCheckList(LenCod,WC013.ckList);
end;

procedure TWA040FDialogStampaFM.rgpSelTurniAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  edtTurni.Text:='';
end;

procedure TWA040FDialogStampaFM.rgpCampoDettaglioClick(Sender: TObject);
begin
  inherited;
  dcmbCampoDett.Enabled:=rgpCampoDettaglio.ItemIndex = 0;
end;

procedure TWA040FDialogStampaFM.rgpDatiAssenzaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaSiglaAssenza;
end;

procedure TWA040FDialogStampaFM.AbilitaComponenti(pAbilita: Boolean);
var
  i: Integer;
begin
  for i:=0 to ComponentCount-1 do
  begin
    if Components[i] is TmeIWRadioGroup then
      TmeIWRadioGroup(Components[i]).Enabled:=pAbilita
    else if Components[i] is TmeIWDBLookupComboBox then
      TmeIWDBLookupComboBox(Components[i]).Enabled:=
        (TmeIWDBLookupComboBox(Components[i]).Name = dCmbLkpProfili.Name) or  pAbilita
    else if Components[i] is TMedpIWMultiColumnComboBox then
      TMedpIWMultiColumnComboBox(Components[i]).Enabled:=pAbilita
    else if Components[i] is TmeIWCheckBox then
      TmeIWCheckBox(Components[i]).Enabled:=pAbilita
    else if Components[i] is TmeIWButton  then
      TmeIWButton(Components[i]).Enabled:=pAbilita
    else if Components[i] is TmeIWEdit then
      if not R180In(TmeIWEdit(Components[i]).Name,[edtDataDa.Name, edtDataA.Name]) then
        TmeIWEdit(Components[i]).Enabled:=pAbilita;
  end;
end;

procedure TWA040FDialogStampaFM.AbilitaSiglaAssenza;
begin
  edtSiglaAssenza.Enabled:=rgpDatiAssenza.ItemIndex = 2;
end;

procedure TWA040FDialogStampaFM.btnGeneraPDFClick(Sender: TObject);
begin
  inherited;
  PutParametriFunzioneStm;
  A040MWStm.ProceduraChiamante:=3;//Stampa
  A040MWStm.ControlliStampa(edtDataDa.Text,edtDataA.Text,edtTurni.Text,VarToStr(dcmbCampoRaggr.KeyValue),rgpTipoStampa.ItemIndex,rgpDatiAssenza.ItemIndex,chkCodice.Checked,chkOrario.Checked,chkDatoLibero.Checked,chkDatiAggiuntivi.Checked);

  if Assigned(evtEseguiStampa) then
    evtEseguiStampa;
end;

function TWA040FDialogStampaFM.CreateJSonString: String;
var json: TJSONObject;
    i:Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    json.AddPair('CodTipologia',A040MWStm.CodTipologia);
    json.AddPair('edtAnno',IntToStr(R180Anno(StrToDate(edtDataDa.Text))));
    json.AddPair('edtMese',IntToStr(R180Mese(StrToDate(edtDataDa.Text))));
    C190Comp2JsonString(rgpTipoStampa,json);
    C190Comp2JsonString(edtDataDa,json);
    C190Comp2JsonString(edtDataA,json);
    C190Comp2JsonString(edtTitolo,json);
    C190Comp2JsonString(dcmbCampoRaggr,json);
    C190Comp2JsonString(chkSaltoPagina,json);
    C190Comp2JsonString(rgpSelTurni,json);
    //SAVONA_ASL2 - Chiamata: 170770 - Non devono essere aggiunti turni in stampa a quelli selezionati.
    json.AddPair('edtTurni', edtTurni.Text (*A040MWStm.GetCodiciTurnoUtilizzati(edtTurni.Text,edtDataDa.Text,edtDataA.Text,rgpTipoStampa.ItemIndex,rgpSelTurni.ItemIndex)*));
    //C190Comp2JsonString(edtTurni,json);
    C190Comp2JsonString(dcmbCampoConNom,json);
    C190Comp2JsonString(chkNomeCompleto,json);
    C190Comp2JsonString(chkIncludiNonPianif,json);
    C190Comp2JsonString(chkLegenda,json);
    C190Comp2JsonString(chkCodice,json);
    C190Comp2JsonString(chkSigla,json);
    C190Comp2JsonString(chkPriorita,json);
    C190Comp2JsonString(chkOrario,json);
    C190Comp2JsonString(chkOrarioInRiga,json);
    C190Comp2JsonString(chkDatoLibero,json);
    C190Comp2JsonString(chkDatiAggiuntivi,json);
    C190Comp2JsonString(chkDatiAggInRiga,json);
    C190Comp2JsonString(rgpDatiAssenza,json);
    C190Comp2JsonString(edtSiglaAssenza,json);
    C190Comp2JsonString(dcmbCampoDett,json);
    C190Comp2JsonString(cmbFontName,json);
    C190Comp2JsonString(cmbFontSize,json);
    C190Comp2JsonString(cmbOrientamentoPag,json);
    for i:=0 to cmbFormatoPag.Items.Count - 1 do
      if cmbFormatoPag.Text = cmbFormatoPag.Items[i].RowData[0] then
        json.AddPair('cmbFormatoPag',i.ToString);
    C190Comp2JsonString(cmbFontTitoloSize,json);
    C190Comp2JsonString(chkTitoloBold,json);
    C190Comp2JsonString(chkTitoloUnderline,json);
    C190Comp2JsonString(rgpCampoDettaglio,json);

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

end.

