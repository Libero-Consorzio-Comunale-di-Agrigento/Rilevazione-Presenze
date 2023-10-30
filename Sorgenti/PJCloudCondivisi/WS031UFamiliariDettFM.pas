unit WS031UFamiliariDettFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,OracleData,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompButton, meIWButton, IWCompListbox, meIWComboBox,
  IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWDBStdCtrls, meIWDBLookupComboBox, IWCompLabel, meIWLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, meIWDBEdit, medpIWMultiColumnComboBox,
  IWCompCheckbox, meIWDBCheckBox, meIWEdit, IWHTMLControls, meIWLink, A000UMessaggi, IWApplication, meIWImageFile,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, WC013UCheckListFM, IWCompMemo, meIWMemo, meIWDBMemo,
  meIWRegion, IWCompGrids, meIWGrid, medpIWTabControl, A000UInterfaccia, UIntfWebT480, A000UCostanti,
  meIWDBComboBox, meIWRadioGroup, S031UFamiliariMW, Vcl.Menus, IWDBGrids, medpIWDBGrid, C021UDocumentiManagerDM;

type
  TWS031FFamiliariDettFM = class(TWR205FDettTabellaFM)
    WS031DatiAnagraficiRG: TmeIWRegion;
    TemplateDatiAnagraficiRG: TIWTemplateProcessorHTML;
    lblNumOrd: TmeIWLabel;
    dedtNumOrd: TmeIWDBEdit;
    lblParentela: TmeIWLabel;
    lblTipoPar: TmeIWLabel;
    lblNumGrado: TmeIWLabel;
    dedtNumGrado: TmeIWDBEdit;
    lblMatricola: TmeIWLabel;
    cmbMatricola: TMedpIWMultiColumnComboBox;
    lblCognome: TmeIWLabel;
    dedtCognome: TmeIWDBEdit;
    lblNome: TmeIWLabel;
    dedtNome: TmeIWDBEdit;
    lblSesso: TmeIWLabel;
    drgpSesso: TmeIWDBRadioGroup;
    lblDataNas: TmeIWLabel;
    lblDataNasPresunta: TmeIWLabel;
    lblDataAdoz: TmeIWLabel;
    dedtComNas: TmeIWDBEdit;
    lblCap: TmeIWLabel;
    dedtCapNas: TmeIWDBEdit;
    lblProvNas: TmeIWLabel;
    lnkDescrComNas: TmeIWLink;
    edtProvNas: TmeIWEdit;
    edtDescComNas: TmeIWEdit;
    btnComNas: TmeIWButton;
    lblCodFiscale: TmeIWLabel;
    dedtCodFiscale: TmeIWDBEdit;
    lblDataMat: TmeIWLabel;
    lblDataSep: TmeIWLabel;
    lblCausFruibili: TmeIWLabel;
    dedtCausaliAbilitate: TmeIWDBEdit;
    btnCausali: TmeIWButton;
    grdTabDetail: TmedpIWTabControl;
    WS031Legge104RG: TmeIWRegion;
    TemplateLegge104RG: TIWTemplateProcessorHTML;
    lblProvRes: TmeIWLabel;
    dedtComune: TmeIWDBEdit;
    lblTelefono: TmeIWLabel;
    dedtTelefono: TmeIWDBEdit;
    lblIndirizzo: TmeIWLabel;
    dedtIndirizzo: TmeIWDBEdit;
    lblCapRes: TmeIWLabel;
    dedtCapRes: TmeIWDBEdit;
    edtComune: TmeIWEdit;
    btnResidenza: TmeIWButton;
    edtProvRes: TmeIWEdit;
    lnkComune: TmeIWLink;
    lblResidenza: TmeIWLabel;
    lblPA: TmeIWLabel;
    WS031DatiStipendialiRG: TmeIWRegion;
    TemplateDatiStipendialiRG: TIWTemplateProcessorHTML;
    lblDetrIrpef: TmeIWLabel;
    lblUltimaDich: TmeIWLabel;
    lblTipoDich: TmeIWLabel;
    lblPercCarico: TmeIWLabel;
    dedtPercCarico: TmeIWDBEdit;
    dchkDetrFiglioHandicap: TmeIWDBCheckBox;
    dchkDet100Affid: TmeIWDBCheckBox;
    lblAssegnoFam: TmeIWLabel;
    dchkComponenteNucleo: TmeIWDBCheckBox;
    dchkSpecialeANF: TmeIWDBCheckBox;
    dchkInabile: TmeIWDBCheckBox;
    lblRedditoANF: TmeIWLabel;
    dedtRedditoAnf: TmeIWDBEdit;
    dedtRedditoAltroANF: TmeIWDBEdit;
    lblAltriRedditi: TmeIWLabel;
    lblTotale: TmeIWLabel;
    edtTotaleANF: TmeIWEdit;
    WS031NoteRG: TmeIWRegion;
    TemplateNoteRG: TIWTemplateProcessorHTML;
    dmemNote: TmeIWDBMemo;
    cmbMotivoTerzoGrado: TmeIWComboBox;
    lblMotivoTerzoGrado: TmeIWLabel;
    lblTipoDisabilita: TmeIWLabel;
    lblDisabilita: TmeIWLabel;
    lblAnnoRevisione: TmeIWLabel;
    lblAnnoAvvTitle: TmeIWLabel;
    lblAnnoAvv: TmeIWLabel;
    dedtAnnoAvv: TmeIWDBEdit;
    lblAnnoAvvFam: TmeIWLabel;
    dedtAnnoAvvFam: TmeIWDBEdit;
    lblNomePA: TmeIWLabel;
    cmbDurataContratto: TmeIWComboBox;
    lblDurataContratto: TmeIWLabel;
    lblAlternDescr: TmeIWLabel;
    lblAlternativa: TmeIWLabel;
    cmbAlternativa: TmeIWComboBox;
    lblAlternativaMotivoTerzoGrado: TmeIWLabel;
    cmbAlternativaMotivoTerzoGrado: TmeIWComboBox;
    lblAlternativaNomePA: TmeIWLabel;
    cmbParentela: TmeIWComboBox;
    cmbNomePA: TMedpIWMultiColumnComboBox;
    cmbTipoPar: TmeIWComboBox;
    cmbTipoDisabilita: TmeIWComboBox;
    lblFamiliare: TmeIWLabel;
    cmbAlternativaNomePA: TMedpIWMultiColumnComboBox;
    lblDataPreAdoz: TmeIWLabel;
    cmbTipoAdoz: TmeIWComboBox;
    lblTipoAdoz: TmeIWLabel;
    lblGravidanza: TmeIWLabel;
    lblGravInizioTeorico: TmeIWLabel;
    lblGravInizioScelto: TmeIWLabel;
    lblGravInizioEffettivo: TmeIWLabel;
    lblGravFine: TmeIWLabel;
    dedtDataAdoz: TmeIWEdit;
    dedtDataPreAdoz: TmeIWEdit;
    dedtDataSep: TmeIWEdit;
    dedtDataMat: TmeIWEdit;
    dedtDataNas: TmeIWEdit;
    dedtDataNasPresunta: TmeIWEdit;
    dedtGravInizioTeorico: TmeIWEdit;
    btnVisualizzaComponenti: TmeIWButton;
    dedtGravInizioScelto: TmeIWEdit;
    dedtGravInizioEffettivo: TmeIWEdit;
    dedtGravFine: TmeIWEdit;
    dedtUltimaDich: TmeIWEdit;
    drgpTipoDetrazione: TmeIWRadioGroup;
    dedtAnnoRevisione: TmeIWEdit;
    cmbMotivoEsclusione: TmeIWComboBox;
    lblMotivoEsclusione: TmeIWLabel;
    dedtNumCartaId: TmeIWDBEdit;
    lblNumCartaId: TmeIWLabel;
    dedtDataRilascioCartaId: TmeIWEdit;
    lblDataRilascioCartaId: TmeIWLabel;
    dedtDataScadenzaCartaId: TmeIWEdit;
    lblDataScadenzaCartaId: TmeIWLabel;
    cmbNazionalita: TMedpIWMultiColumnComboBox;
    lblDescNazionalita: TmeIWLabel;
    lnkNazionalita: TmeIWLink;
    dchkInserimentoCU: TmeIWDBCheckBox;
    dEdtnumeroPassaporto: TmeIWDBEdit;
    lblNumeroPassaporto: TmeIWLabel;
    lblDataRilascioPassaporto: TmeIWLabel;
    lblDataScadenzaPassaporto: TmeIWLabel;
    edtDataRilascioPassaporto: TmeIWEdit;
    edtDataScadenzaPassaporto: TmeIWEdit;
    pmnGrdDocumenti: TPopupMenu;
    actScaricaInExcelDoc: TMenuItem;
    WS031DocumentiRG: TmeIWRegion;
    grdDocumenti: TmedpIWDBGrid;
    TemplateDocumentiRG: TIWTemplateProcessorHTML;
    actScaricainCSVDoc: TMenuItem;
    procedure cmbMatricolaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure lnkDescrComNasClick(Sender: TObject);
    procedure dedtCodFiscaleAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure dedtCapNasAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure btnCausaliClick(Sender: TObject);
    procedure drgpTipoDetrazioneClick(Sender: TObject);
    procedure dedtRedditoAnfAsyncExit(Sender: TObject; EventParams: TStringList);
    procedure dedtPercCaricoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dedtNumGradoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbAlternativaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure cmbNomePAAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbParentelaChange(Sender: TObject);
    procedure cmbTipoDisabilitaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtDataAdozAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnVisualizzaComponentiClick(Sender: TObject);
    procedure dedtDataNasPresuntaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtDataNasAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dedtGravInizioSceltoAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtGravInizioEffettivoAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure lnkNazionalitaClick(Sender: TObject);
    procedure cmbNazionalitaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure actScaricaInExcelDocClick(Sender: TObject);
    procedure actScaricainCSVDocClick(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    IntfWebT480Nas,IntfWebT480Res:TIntfWebT480;
    C021DM: TC021FDocumentiManagerDM;
    procedure imgAccediClick(Sender: TObject);
    procedure imgDownloadClick(Sender: TObject);

    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure cklistCausali(Sender: TObject; Result:Boolean);
    procedure CaricaNomePA(Combo: TMedpIWMultiColumnComboBox);
    procedure ReleaseOggetti;
    procedure ValidaCampoData(edtCampoData: TmeIWEdit; NomeCampoDB,
      DataMessaggio: String);
  public
    procedure AbilitaComponenti; override;
    procedure AbilitaGrdDocumenti;
  end;

implementation

uses WS031UFamiliari, WS031UFamiliariDM, WR100UBase;

{$R *.dfm}

procedure TWS031FFamiliariDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  IntfWebT480Nas:=TIntfWebT480.Create(Self.Parent);
  IntfWebT480Res:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480Nas do
  begin
    Titolo:='Scelta comune di nascita';
    DataSource:=(WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.dsrQ480;
    edtCitta:=edtDescComNas;
    dedtCodice:=dedtComNas;
    dedtCap:=dedtCapNas;
    edtProvincia:=edtProvNas;
    btnLookup:=btnComNas;
  end;
  with IntfWebT480Res do
  begin
    Titolo:='Scelta comune di residenza';
    DataSource:=(WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.dsrQ480;
    edtCitta:=edtComune;
    dedtCodice:=dedtComune;
    dedtCap:=dedtCapRes;
    edtProvincia:=edtProvRes;
    btnLookup:=btnResidenza;
  end;

  grdTabDetail.AggiungiTab('Dati anagrafici',WS031DatiAnagraficiRG);
  grdTabDetail.AggiungiTab('Legge 104/1992',WS031Legge104RG);
  grdTabDetail.AggiungiTab('Dati stipendiali',WS031DatiStipendialiRG);
  grdTabDetail.AggiungiTab('Note',WS031NoteRG);
  grdTabDetail.AggiungiTab('Documenti',WS031DocumentiRG);
  grdTabDetail.ActiveTab:=WS031DatiAnagraficiRG;

  if (WR302DM as TWS031FFamiliariDM).selTabella.RecordCount = 0 then
    AbilitaGrdDocumenti;

  // scorciatoia per datamodulo di servizio per allegati
  C021DM:=(WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.C021DM;

end;

procedure TWS031FFamiliariDettFM.AbilitaComponenti;
begin
  (*
  0 Nessuno/Sè stesso
  1 Coniuge
  2 Figlio/Figlia
  3 Genitore
  4 Fratello/Sorella
  5 Nipote
  6 Nipote equiparato Figlio
  7 Altro
  8 Affidato
  9 Unito civilmente
  10 Convivente di fatto
  *)
  //--- Dati anagrafici
  cmbParentela.Enabled:=((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]);
  lblTipoPar.Enabled:=(cmbParentela.ItemIndex in [GP_ALTRO]);
  cmbTipoPar.Enabled:=((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]) and (cmbParentela.ItemIndex in [GP_ALTRO]);
  lblNumGrado.Enabled:=(cmbParentela.ItemIndex in [GP_NIPOTE,GP_NIPOTE_FIGLIO,GP_ALTRO]);
  dedtNumGrado.Enabled:=((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]) and (cmbParentela.ItemIndex in [GP_NIPOTE,GP_NIPOTE_FIGLIO,GP_ALTRO]);
  dedtNumGradoAsyncChange(nil,nil);
  dedtCognome.Enabled:=(Trim(cmbMatricola.Text) = '');
  dedtNome.Enabled:=(Trim(cmbMatricola.Text) = '');
  drgpSesso.Enabled:=(Trim(cmbMatricola.Text) = '');
  dedtDataNas.Enabled:=(Trim(cmbMatricola.Text) = '');
  lblDataNasPresunta.Enabled:=(Parametri.Applicazione <> 'PAGHE');
  dedtDataNasPresunta.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(cmbMatricola.Text) = '');
  lblDataAdoz.Enabled:=(Trim(cmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  dedtDataAdoz.Enabled:=(Trim(cmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  lblDataPreAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(cmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  dedtDataPreAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(cmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  lblTipoAdoz.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (Trim(cmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  cmbTipoAdoz.Enabled:=((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]) and (Parametri.Applicazione <> 'PAGHE') and (Trim(cmbMatricola.Text) = '') and (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]);
  if ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) and (not dedtDataAdoz.Enabled) then
  begin
    dedtDataAdoz.Text:='';
    dedtDataPreAdoz.Text:='';
    cmbTipoAdoz.ItemIndex:=-1;
  end;
  btnVisualizzaComponentiClick(nil);
  dedtComNas.Enabled:=(Trim(cmbMatricola.Text) = '');
  edtDescComNas.Enabled:=(Trim(cmbMatricola.Text) = '');
  dedtCapNas.Enabled:=(Trim(cmbMatricola.Text) = '');
  edtProvNas.Enabled:=(Trim(cmbMatricola.Text) = '');
  btnComNas.Enabled:=(Trim(cmbMatricola.Text) = '') and ((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]);
  dedtCodFiscale.Enabled:=(Trim(cmbMatricola.Text) = '');
  dedtDataSep.Enabled:=(Trim(cmbMatricola.Text) = '') or (cmbParentela.ItemIndex <> GP_NESSUNO); //Diverso da sè stesso
  cmbMotivoEsclusione.Enabled:=((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]) and ((Trim(cmbMatricola.Text) = '') or (cmbParentela.ItemIndex <> GP_NESSUNO));
  lblDataMat.Enabled:=(cmbParentela.ItemIndex in [GP_CONIUGE,GP_UNITO_CIVILE]);
  dedtDataMat.Enabled:=(cmbParentela.ItemIndex in [GP_CONIUGE,GP_UNITO_CIVILE]);
  dedtCausaliAbilitate.Enabled:=Parametri.Applicazione <> 'PAGHE';
  btnCausali.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]);
  if cmbParentela.ItemIndex = GP_NESSUNO then
    lblCausFruibili.Caption:='Causali fruibili per sè stesso'
  else
    lblCausFruibili.Caption:='Causali fruibili per questo familiare';

  //--- Legge 104
  WS031Legge104RG.Enabled:=Parametri.Applicazione <> 'PAGHE';
  lblAnnoAvv.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = GP_NESSUNO);   //Sè stesso
  dedtAnnoAvv.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex = GP_NESSUNO);   //Sè stesso
  lblAnnoAvvFam.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex <> GP_NESSUNO);   //Diverso da sè stesso
  dedtAnnoAvvFam.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbParentela.ItemIndex <> GP_NESSUNO);  //Diverso da sè stesso
  lblAnnoRevisione.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
  dedtAnnoRevisione.Enabled:=(Parametri.Applicazione <> 'PAGHE') and (cmbTipoDisabilita.ItemIndex = 0);
  lblTipoDisabilita.Enabled:=Parametri.Applicazione <> 'PAGHE';
  cmbTipoDisabilita.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]);
  if cmbTipoDisabilita.Enabled then
    cmbTipoDisabilitaAsyncChange(nil,nil);

  C190VisualizzaElemento(JQuery,'grpResidenza',(Trim(cmbMatricola.Text) = ''));
  if (Trim(cmbMatricola.Text) = '') then
  begin
    lblIndirizzo.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtIndirizzo.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lnkComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
    edtComune.Enabled:=Parametri.Applicazione <> 'PAGHE';
    btnResidenza.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]);
    lblCAPRes.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtCAPRes.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblProvRes.Enabled:=Parametri.Applicazione <> 'PAGHE';
    edtProvRes.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblTelefono.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtTelefono.Enabled:=Parametri.Applicazione <> 'PAGHE';
  end;

  C190VisualizzaElemento(JQuery,'grpPA',(Trim(cmbMatricola.Text) = ''));
  if (Trim(cmbMatricola.Text) = '') then
  begin
    lblDurataContratto.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbDurataContratto.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]);
    lblNomePA.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbNomePA.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]);
    if cmbNomePA.Enabled then
    begin
      CaricaNomePA(cmbNomePA);
      cmbNomePAAsyncChange(nil,nil,0,'');
    end;
  end
  else if ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
  begin
    cmbNomePA.ItemIndex:=-1;
    cmbNomePA.Text:='';
    cmbDurataContratto.ItemIndex:=-1;
  end;

  C190VisualizzaElemento(JQuery,'grpAlternativa',(cmbParentela.ItemIndex = GP_FIGLIO));
  if (cmbParentela.ItemIndex = GP_FIGLIO) then
  begin
    lblAlternativaMotivoTerzoGrado.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbAlternativaMotivoTerzoGrado.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]);
    lblAlternativaNomePA.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbAlternativaNomePA.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]);
    lblAlternativa.Enabled:=Parametri.Applicazione <> 'PAGHE';
    cmbAlternativa.Enabled:=(Parametri.Applicazione <> 'PAGHE') and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]);
    if cmbAlternativa.Enabled then
    begin
      CaricaNomePA(cmbAlternativaNomePA);
      cmbAlternativaAsyncChange(nil,nil);
    end;
  end
  else if ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
  begin
    cmbAlternativa.ItemIndex:=-1;
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=-1;
    cmbAlternativaNomePA.ItemIndex:=-1;
    cmbAlternativaNomePA.Text:='';
  end;

  //--- Dati stipendiali - Abilitati per chi ha le paghe solo dall'applicativo paghe, altrimenti sempre
  //Fa eccezione l'ONU dove è abilitata anche dal Giuridico
  WS031DatiStipendialiRG.Enabled:=((Parametri.V430 = 'P430') and (Parametri.CampiRiferimento.C1_CedoliniConValuta <> 'S') and (Parametri.Applicazione = 'PAGHE')) or
                              ((Parametri.V430 = 'P430') and (Parametri.CampiRiferimento.C1_CedoliniConValuta = 'S') and ((Parametri.Applicazione = 'PAGHE') or (Parametri.Applicazione = 'STAGIU'))) or
                              (Parametri.V430 <> 'P430');
  lblUltimaDich.Enabled:=WS031DatiStipendialiRG.Enabled;
  dedtUltimaDich.Enabled:=WS031DatiStipendialiRG.Enabled;
  drgpTipoDetrazione.Enabled:=((WR302DM as TWS031FFamiliariDM).selTabella.State in [dsEdit,dsInsert]) and WS031DatiStipendialiRG.Enabled;
  lblPercCarico.Enabled:=WS031DatiStipendialiRG.Enabled;
  dedtPercCarico.Enabled:=WS031DatiStipendialiRG.Enabled;
  dchkDetrFiglioHandicap.Enabled:=WS031DatiStipendialiRG.Enabled;
  dchkDet100Affid.Enabled:=WS031DatiStipendialiRG.Enabled;
  dchkComponenteNucleo.Enabled:=WS031DatiStipendialiRG.Enabled;
  dchkSpecialeANF.Visible:=cmbParentela.ItemIndex = GP_FIGLIO;  //Studente/apprendista
  dchkSpecialeANF.Enabled:=WS031DatiStipendialiRG.Enabled;
  dchkInabile.Enabled:=WS031DatiStipendialiRG.Enabled;
  lblRedditoANF.Enabled:=WS031DatiStipendialiRG.Enabled;
  dedtRedditoANF.Enabled:=WS031DatiStipendialiRG.Enabled;
  lblAltriRedditi.Enabled:=WS031DatiStipendialiRG.Enabled;
  dedtRedditoAltroANF.Enabled:=WS031DatiStipendialiRG.Enabled;
  lblTotale.Enabled:=WS031DatiStipendialiRG.Enabled;
  edtTotaleANF.Enabled:=WS031DatiStipendialiRG.Enabled;
  dchkInserimentoCU.Visible:=cmbParentela.ItemIndex in [GP_CONIUGE,GP_UNITO_CIVILE];
  dchkInserimentoCU.Enabled:=WS031DatiStipendialiRG.Enabled;
  drgpTipoDetrazioneClick(nil);

  //--- BtnCarica
  with (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selGradoPar do
  begin
    SetVariable('PROGRESSIVO',(Self.Owner as TWS031FFamiliari).grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('NUM',-1);
    Execute;
    with (Self.Owner as TWS031FFamiliari) do
    begin
      actCarica.Visible:=(StrToIntDef(VarToStr(Field(0)),0) <= 0) and (not SolaLettura);
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    end;
  end;
end;

procedure TWS031FFamiliariDettFM.dedtNumGradoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  lblMotivoTerzoGrado.Enabled:=((WR302DM as TWS031FFamiliariDM).SelTabella.FieldByName('NUMGRADO').AsString = '3');
  cmbMotivoTerzoGrado.Enabled:=((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) and ((WR302DM as TWS031FFamiliariDM).SelTabella.FieldByName('NUMGRADO').AsString = '3');
  if not cmbMotivoTerzoGrado.Enabled and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
    cmbMotivoTerzoGrado.ItemIndex:=-1;
end;

procedure TWS031FFamiliariDettFM.cmbTipoDisabilitaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  lblAnnoRevisione.Enabled:=cmbTipoDisabilita.ItemIndex = 0;
  dedtAnnoRevisione.Enabled:=cmbTipoDisabilita.ItemIndex = 0;
  if not dedtAnnoRevisione.Enabled and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
    dedtAnnoRevisione.Text:='';
  if (cmbTipoDisabilita.ItemIndex = -1) and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
  begin
    (WR302DM as TWS031FFamiliariDM).SelTabella.FieldByName('ANNO_AVV').Clear;
    (WR302DM as TWS031FFamiliariDM).SelTabella.FieldByName('ANNO_AVV_FAM').Clear;
    (WR302DM as TWS031FFamiliariDM).SelTabella.FieldByName('ALTERNATIVA').Clear;
    cmbAlternativa.ItemIndex:=-1;
    cmbAlternativaAsyncChange(nil,nil);
  end;
end;

procedure TWS031FFamiliariDettFM.cmbAlternativaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  lblAlternativaMotivoTerzoGrado.Enabled:=cmbAlternativa.ItemIndex = 4;
  cmbAlternativaMotivoTerzoGrado.Enabled:=cmbAlternativa.ItemIndex = 4;
  if not cmbAlternativaMotivoTerzoGrado.Enabled and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=-1;
  lblAlternativaNomePA.Enabled:=(cmbAlternativa.ItemIndex <> -1) and (cmbAlternativa.ItemIndex <> 5);
  cmbAlternativaNomePA.Enabled:=(cmbAlternativa.ItemIndex <> -1) and (cmbAlternativa.ItemIndex <> 5);
  if not cmbAlternativaNomePA.Enabled and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
  begin
    cmbAlternativaNomePA.ItemIndex:=-1;
    cmbAlternativaNomePA.Text:='';
  end;
end;

procedure TWS031FFamiliariDettFM.CaricaNomePA(Combo:TMedpIWMultiColumnComboBox);
var i: Integer;
    isPresent: Boolean;
begin
  Combo.Items.Clear;
  with (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selNomePA do
  begin
    Close;
    SetVariable('DATO','NOME_PA');
    Open;
    First;
    while not Eof do
    begin
      Combo.AddRow(FieldByName('NOME_PA').AsString);
      Next;
    end;
    Close;
    SetVariable('DATO','NOME_PA_ALT');
    Open;
    First;
    while not Eof do
    begin
      isPresent:=False;
      for i := 0 to Combo.Items.Count -1 do
        if Trim(Combo.Items[i].RowData.Text) = Trim(FieldByName('NOME_PA_ALT').AsString)  then
        begin
          isPresent:=True;
          break;
        end;
      if not isPresent then
        Combo.AddRow(FieldByName('NOME_PA_ALT').AsString);
      Next;
    end;
  end;
end;

procedure TWS031FFamiliariDettFM.cmbNazionalitaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWS031FFamiliariDM) do
  begin
    selTabella.FieldByName('NAZIONE').AsString:=cmbNazionalita.Text;
    lblDescNazionalita.Caption:=VarToStr(S031FFamiliariMW.selT483.Lookup('COD_NAZIONE',selTabella.FieldByName('NAZIONE').AsString,'DESCRIZIONE'));
  end;
end;

procedure TWS031FFamiliariDettFM.cmbNomePAAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  lblDurataContratto.Enabled:=Trim(cmbNomePA.Text) <> '';
  cmbDurataContratto.Enabled:=Trim(cmbNomePA.Text) <> '';
  if not cmbDurataContratto.Enabled and ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
    cmbDurataContratto.ItemIndex:=-1;
end;

procedure TWS031FFamiliariDettFM.drgpTipoDetrazioneClick(Sender: TObject);
begin
  inherited;
  dchkDet100Affid.Enabled:=dedtPercCarico.Enabled and (drgpTipoDetrazione.ItemIndex = 2) and
                           ((WR302DM as TWS031FFamiliariDM).SelTabella.FieldByName('PERC_CARICO').AsFloat = 100);
  if not dchkDet100Affid.Enabled then
    dchkDet100Affid.Checked:=False;
end;

procedure TWS031FFamiliariDettFM.grdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  img: TmeIWImageFile;
begin
  for r:=0 to High(grdDocumenti.medpCompGriglia) do
  begin
    // salva
    if grdDocumenti.medpCompCella(r,DBG_COMANDI,0) <> nil then
    begin
      img:=(grdDocumenti.medpCompCella(r,DBG_COMANDI,0) as TmeIWImageFile);
      //img.medpDownloadButton:=True; //bugfix
      img.OnClick:=imgDownloadClick;
    end;
    // accedi
    if ((Self.Owner as TWS031FFamiliari).AbilitaGestioneA154) and
       (grdDocumenti.medpCompCella(r,DBG_COMANDI,1) <> nil) then
    begin
      img:=(grdDocumenti.medpCompCella(r,DBG_COMANDI,1) as TmeIWImageFile);
      img.OnClick:=imgAccediClick;
    end;
  end;
end;

procedure TWS031FFamiliariDettFM.grdDocumentiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
  NoteLimitate: Boolean;
begin
  if not grdDocumenti.medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;

  NumColonna:=grdDocumenti.medpNumColonna(AColumn);
  Campo:=grdDocumenti.medpColonna(NumColonna).DataField;

  if ARow = 0 then
  begin
    // noop
  end
  else
  begin
    if Campo = 'NOTE' then
    begin
      // se il testo supera certe soglie (lunghezza o ritorni a capo)
      // lo riduce inserendo dei puntini di sospensione
      // per evitare che la riga ecceda un'altezza accettabile
      if (ACell.Text = '') or (ACell.Text = '<br>') then
      begin
        ACell.Hint:='';
        ACell.ShowHint:=False;
      end
      else
      begin
        ACell.Hint:=C190ConvertiSimboliHtml(ACell.Text);
        ACell.Css:=ACell.Css + ' tooltipHtml';
        NoteLimitate:=False;
        if Length(ACell.Text) > LIMITE_CARATTERI_NOTE then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_NOTE)]);
        end;
        if ACell.RawText then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('<div style="overflow-y: hidden; text-overflow: ellipsis; max-height: %dem;">%s</div>',[LIMITE_RIGHE_NOTE,ACell.Text]);
        end;
        ACell.ShowHint:=NoteLimitate;
      end;
    end;
  end;

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdDocumenti.medpCompGriglia) + 1) and (grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdDocumenti.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWS031FFamiliariDettFM.imgAccediClick(Sender: TObject);
var
  FN, LProg, LId, LParametri: String;
  i: Integer;
begin
  if not (Self.Owner as TWS031FFamiliari).AbilitaGestioneA154 then
  begin
    MsgBox.MessageBox('La funzione <A154> Gestione documentale non è abilitata!',ESCLAMA);
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdDocumenti.medpRigaDiCompGriglia(FN);
  LProg:=grdDocumenti.medpValoreColonna(i,'PROGRESSIVO');
  LId:=grdDocumenti.medpValoreColonna(i,'ID');
  LParametri:='PROGRESSIVO=' + LProg + ParamDelimiter +
              'ID=' + LId;
  (Self.Owner as TWS031FFamiliari).AccediForm(76,LParametri,False);
end;

procedure TWS031FFamiliariDettFM.imgDownloadClick(Sender: TObject);
// effettua il download dell'allegato
var
  i: Integer;
  LId: Integer;
  LDoc: TDocumento;
  FN: String;
  LResCtrl: TResCtrl;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdDocumenti.medpRigaDiCompGriglia(FN);

  // estrae id richiesta
  LId:=grdDocumenti.medpValoreColonna(i,'ID').ToInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  A000SessioneWEB.AnnullaTimeOut;
  try
    // estrae il file con i metadati associati
    try
      LResCtrl:=C021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // invia il file al browser
      // aggiorna i dati di accesso al documento ed esegue il download
      (Self.Owner as TWS031FFamiliari).AggiornaAccessoEScarica(LId,LDoc.FilePath);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format(A000MSG_A155_ERR_FMT_DOC_SALVA,[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TWS031FFamiliariDettFM.dedtPercCaricoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  dchkDet100Affid.Enabled:=dedtPercCarico.Enabled and (drgpTipoDetrazione.ItemIndex = 2) and
                           ((WR302DM as TWS031FFamiliariDM).SelTabella.FieldByName('PERC_CARICO').AsFloat = 100);
  if not dchkDet100Affid.Enabled then
    dchkDet100Affid.Checked:=False;
end;

procedure TWS031FFamiliariDettFM.dedtRedditoAnfAsyncExit(Sender: TObject; EventParams: TStringList);
begin
  with (WR302DM as TWS031FFamiliariDM).SelTabella do
    edtTotaleANF.Text:=FloatToStr(FieldByName('REDDITO_ANF').AsFloat + FieldByName('REDDITO_ALTRO_ANF').AsFloat);
end;

procedure TWS031FFamiliariDettFM.dedtCodFiscaleAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  with (WR302DM as TWS031FFamiliariDM).SelTabella do
    if (State in [dsEdit,dsInsert]) and (Trim(FieldByName('CODFISCALE').AsString) = '') then
        FieldByName('CODFISCALE').AsString:=R180CalcoloCodiceFiscale(FieldByName('Cognome').AsString,
                                                         FieldByName('Nome').AsString,
                                                         FieldByName('Sesso').AsString,
                                                         FieldByName('D_CodCatastale').AsString,
                                                         FieldByName('DataNas').AsDateTime);
end;

procedure TWS031FFamiliariDettFM.dedtDataNasAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ValidaCampoData(dedtDataNas,'DATANAS','nascita');
  ValidaCampoData(dedtDataNasPresunta,'DATANAS_PRESUNTA','presunta');
  ValidaCampoData(dedtGravFine,'GRAV_FINE','fine effettiva');
  (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selSG101DATANASChange(dedtGravInizioTeorico.Visible);
  dedtGravFine.Text:=(WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('GRAV_FINE').AsString;
end;

procedure TWS031FFamiliariDettFM.dedtDataNasPresuntaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ValidaCampoData(dedtDataNas,'DATANAS','nascita');
  ValidaCampoData(dedtDataNasPresunta,'DATANAS_PRESUNTA','presunta');
  (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selSG101DATANAS_PRESUNTAChange(dedtGravInizioTeorico.Visible);
  if (WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('DATANAS').IsNull then
    dedtDataNas.Text:=''
  else
    dedtDataNas.Text:=FormatDateTime('dd/mm/yyyy hh:nn',(WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('DATANAS').AsDateTime);
  dedtGravInizioTeorico.Text:=(WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('GRAV_INIZIO_TEOR').AsString;
  dedtGravInizioScelto.Text:=(WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('GRAV_INIZIO_SCELTA').AsString;
  dedtGravInizioSceltoAsyncChange(nil,nil);
end;

procedure TWS031FFamiliariDettFM.dedtGravInizioEffettivoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ValidaCampoData(dedtGravInizioEffettivo,'GRAV_INIZIO_EFF','inizio effettivo');
  (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selSG101GRAV_INIZIO_EFFChange(dedtGravInizioTeorico.Visible);
  dedtGravFine.Text:=(WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('GRAV_FINE').AsString;
end;

procedure TWS031FFamiliariDettFM.dedtGravInizioSceltoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ValidaCampoData(dedtGravInizioScelto,'GRAV_INIZIO_SCELTA','inizio scelto dal dip.');
  (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selSG101GRAV_INIZIO_SCELTAChange(dedtGravInizioTeorico.Visible);
  dedtGravInizioEffettivo.Text:=(WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('GRAV_INIZIO_EFF').AsString;
  dedtGravInizioEffettivoAsyncChange(nil,nil);
end;

procedure TWS031FFamiliariDettFM.dedtCapNasAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  {Ricava il CAP dalla tabella comuni se si fa DoppioClick}
  with (WR302DM as TWS031FFamiliariDM).SelTabella do
  if State in [dsInsert,dsEdit] then
    if Sender = dedtCAPNas then
      FieldByName('CAPNas').AsString:=FieldByName('D_CAPNAS').AsString
    else
      FieldByName('CAP').AsString:=FieldByName('D_CAP').AsString;
end;

procedure TWS031FFamiliariDettFM.AbilitaGrdDocumenti;
begin
  // gestione tabella
  grdDocumenti.medpAttivaGrid((WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT960,False,False,False);
  grdDocumenti.medpComandiCustom:=True;
  // prepara i componenti sulla colonna comandi
  grdDocumenti.medpPreparaComponentiDefault;
  grdDocumenti.medpPreparaComponenteGenerico('WR102-R',0,0,DBG_IMG,'','SALVA','Salva il documento','','');
  if (Self.Owner as TWS031FFamiliari).AbilitaGestioneA154 then
    grdDocumenti.medpPreparaComponenteGenerico('WR102-R',0,1,DBG_IMG,'','ACCEDI','Accedi al documento','','');

  grdDocumenti.medpCaricaCDS;
end;

procedure TWS031FFamiliariDettFM.actScaricaInExcelDocClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    TWS031FFamiliari(Self.Owner).streamDownload:=grdDocumenti.ToXlsx
  else
    TWS031FFamiliari(Self.Owner).inviaFile('Documenti.xlsx',TWS031FFamiliari(Self.Owner).streamDownload);
end;

procedure TWS031FFamiliariDettFM.actScaricainCSVDocClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    TWS031FFamiliari(Self.Owner).csvDownload:=grdDocumenti.ToCsv
  else
    TWS031FFamiliari(Self.Owner).inviaFile('Documenti.xls',TWS031FFamiliari(Self.Owner).csvDownload);
end;

procedure TWS031FFamiliariDettFM.btnCausaliClick(Sender: TObject);
begin
  inherited;
  if Assigned(Sender) then
  begin
    WC013:=TWC013FCheckListFM.Create(Self.Parent);
    with WC013 do
    begin
      (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT265.Open;
      (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT265.First;
      ckList.Items.Add(Format('%-5s %s',['*','Tutte le causali']));
      while not (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT265.Eof do
      begin
        ckList.Items.Add(Format('%-5s %s',[(WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT265.FieldByName('Codice').AsString,TWS031FFamiliariDM(WR302DM).S031FFamiliariMW.selT265.FieldByName('Descrizione').AsString]));
        ckList.Values.Add(Trim((WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT265.FieldByName('CODICE').AsString));
        (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT265.Next;
      end;
      (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT265.Close;
      ResultEvent:=cklistCausali;
      C190PutCheckList(dedtCausaliAbilitate.Text,5,ckList);
      WC013.Visualizza(0,0,'Scelta causali fruibili');
    end;
  end;
end;

procedure TWS031FFamiliariDettFM.cklistCausali(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    (WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('CAUSALI_ABILITATE').AsString:=Trim(C190GetCheckList(5,WC013.ckList));
    if Copy((WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('CAUSALI_ABILITATE').AsString,1,2) = '*,' then
      (WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('CAUSALI_ABILITATE').AsString:='*';
  end;
end;

procedure TWS031FFamiliariDettFM.cmbParentelaChange(Sender: TObject);
begin
  with (WR302DM as TWS031FFamiliariDM) do
    if SelTabella.State in [dsEdit,dsInsert] then
    begin
      SelTabella.FieldByName('NUMGRADO').AsString:='';
      cmbTipoPar.ItemIndex:=-1;
      cmbTipoPar.Text:='';
      if cmbParentela.ItemIndex in [GP_FIGLIO,GP_GENITORE] then //Figlio,Genitore
      begin
        SelTabella.FieldByName('NUMGRADO').AsString:='1';
        cmbTipoPar.ItemIndex:=0;
      end
      else if cmbParentela.ItemIndex in [GP_FRATELLO] then //Fratello-Sorella
      begin
        SelTabella.FieldByName('NUMGRADO').AsString:='2';
        cmbTipoPar.ItemIndex:=0;
      end
      else if cmbParentela.ItemIndex in [GP_NIPOTE,GP_NIPOTE_FIGLIO] then //Nipote
      begin
        SelTabella.FieldByName('NUMGRADO').AsString:='2';
        cmbTipoPar.ItemIndex:=0;
      end;
      if (dedtCausaliAbilitate.Enabled) and (SelTabella.State = dsInsert) then
        if cmbParentela.ItemIndex = GP_FIGLIO then
          SelTabella.FieldByName('CAUSALI_ABILITATE').AsString:=S031FFamiliariMW.GetCausaliFG
        else
          SelTabella.FieldByName('CAUSALI_ABILITATE').Clear;
      SelTabella.FieldByName('SPECIALE_ANF').AsString:='N';
    end;
    AbilitaComponenti;
end;

procedure TWS031FFamiliariDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  if Trim((WR302DM as TWS031FFamiliariDM).selTabella.FieldByName('NOTE').AsString) <> '' then
  begin
    grdTabDetail.Tabs[WS031NoteRG].Link.RawText:=True;
    grdTabDetail.Tabs[WS031NoteRG].Caption:='<b><u>Note</u></b>';
  end
  else
  begin
    grdTabDetail.Tabs[WS031NoteRG].Link.RawText:=False;
    grdTabDetail.Tabs[WS031NoteRG].Caption:='Note';
  end;

  if (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW.selT960.RecordCount > 0 then
  begin
    grdTabDetail.Tabs[WS031DocumentiRG].Link.RawText:=True;
    grdTabDetail.Tabs[WS031DocumentiRG].Caption:='<b><u>Documenti</u></b>';
  end
  else
  begin
    grdTabDetail.Tabs[WS031DocumentiRG].Link.RawText:=False;
    grdTabDetail.Tabs[WS031DocumentiRG].Caption:='Documenti';
  end;
end;

procedure TWS031FFamiliariDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWS031FFamiliariDM).S031FFamiliariMW do
  begin
    selT030.Refresh;
    selT030.First;
    cmbMatricola.Items.Clear;
    while not selT030.Eof do
    begin
      if selT030.FieldByName('MATRICOLA').AsString <> '' then
        cmbMatricola.AddRow(selT030.FieldByName('MATRICOLA').AsString + ';' + selT030.FieldByName('NOMINATIVO').AsString);
      selT030.Next;
    end;
    selT483.Refresh;
    selT483.First;
    cmbNazionalita.Items.Clear;
    while not selT483.Eof do
    begin
      cmbNazionalita.AddRow(selT483.FieldByName('COD_NAZIONE').AsString + ';' + selT483.FieldByName('DESCRIZIONE').AsString);
      selT483.Next;
    end;
  end;
end;

procedure TWS031FFamiliariDettFM.cmbMatricolaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  with (WR302DM as TWS031FFamiliariDM) do
  begin
    selTabella.FieldByName('MATRICOLA').AsString:=cmbMatricola.Text;
  end;
  AbilitaComponenti;
  DataSet2Componenti;
end;

procedure TWS031FFamiliariDettFM.ValidaCampoData(edtCampoData:TmeIWEdit;NomeCampoDB,DataMessaggio:String);
var D:TDateTime;
begin
  with (WR302DM as TWS031FFamiliariDM) do
    if Trim(edtCampoData.Text) = '' then
      selTabella.FieldByName(NomeCampoDB).Clear
    else if TryStrToDateTime(edtCampoData.Text,D) then
      selTabella.FieldByName(NomeCampoDB).AsDateTime:=D
    else
    begin
      edtCampoData.SetFocus;
      raise Exception.Create(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,[DataMessaggio]));
    end;
end;

procedure TWS031FFamiliariDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWS031FFamiliariDM) do
  begin
    //Impostazione/Controlli campi data
    ValidaCampoData(dedtDataNas,'DATANAS','nascita');
    ValidaCampoData(dedtDataNasPresunta,'DATANAS_PRESUNTA','presunta');
    ValidaCampoData(dedtDataPreAdoz,'DATA_PREADOZ','pre-adozione');
    ValidaCampoData(dedtDataAdoz,'DATAADOZ','adozione');
    ValidaCampoData(dedtDataSep,'DATASEP','esclusione');
    ValidaCampoData(dedtDataMat,'DATAMAT','matrimonio');
    ValidaCampoData(dedtDataRilascioCartaId,'CARTA_ID_DATA_RIL','rilascio carta identità');
    ValidaCampoData(dedtDataScadenzaCartaId,'CARTA_ID_DATA_SCAD','scadenza carta identità');
    ValidaCampoData(edtDataRilascioPassaporto,'PASSAPORTO_DATA_RIL','rilascio passaporto');
    ValidaCampoData(edtDataScadenzaPassaporto,'PASSAPORTO_DATA_SCAD','scadenza passaporto');
    ValidaCampoData(dedtGravInizioTeorico,'GRAV_INIZIO_TEOR','inizio teorico');
    ValidaCampoData(dedtGravInizioScelto,'GRAV_INIZIO_SCELTA','inizio scelto dal dip.');
    ValidaCampoData(dedtGravInizioEffettivo,'GRAV_INIZIO_EFF','inizio effettivo');
    ValidaCampoData(dedtGravFine,'GRAV_FINE','fine effettiva');
    ValidaCampoData(dedtUltimaDich,'DATA_ULT_FAM_CAR','ultima dichiarazione');
    ValidaCampoData(dedtAnnoRevisione,'ANNO_REVISIONE','revisione');
    //Impostazione campi db
    selTabella.FieldByName('MATRICOLA').AsString:=cmbMatricola.Text;
    if drgpTipoDetrazione.ItemIndex = 0 then
      selTabella.FieldByName('TIPO_DETRAZIONE').AsString:='ND'
    else if drgpTipoDetrazione.ItemIndex = 1 then
      selTabella.FieldByName('TIPO_DETRAZIONE').AsString:='DC'
    else if drgpTipoDetrazione.ItemIndex = 2 then
      selTabella.FieldByName('TIPO_DETRAZIONE').AsString:='DF'
    else if drgpTipoDetrazione.ItemIndex = 3 then
     selTabella.FieldByName('TIPO_DETRAZIONE').AsString:='DA';
    selTabella.FieldByName('NAZIONE').AsString:=cmbNazionalita.Text;
  end;
end;

procedure TWS031FFamiliariDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWS031FFamiliariDM) do
  begin
    //Impostazione campi data
    if selTabella.FieldByName('DATANAS_PRESUNTA').IsNull then
      dedtDataNasPresunta.Text:=''
    else
      dedtDataNasPresunta.Text:=FormatDateTime('dd/mm/yyyy hh:nn',selTabella.FieldByName('DATANAS_PRESUNTA').AsDateTime);
    if selTabella.FieldByName('DATANAS').IsNull then
      dedtDataNas.Text:=''
    else
      dedtDataNas.Text:=FormatDateTime('dd/mm/yyyy hh:nn',selTabella.FieldByName('DATANAS').AsDateTime);
    dedtDataPreAdoz.Text:=selTabella.FieldByName('DATA_PREADOZ').AsString;
    if selTabella.FieldByName('DATAADOZ').IsNull then
      dedtDataAdoz.Text:=''
    else
      dedtDataAdoz.Text:=FormatDateTime('dd/mm/yyyy hh:nn',selTabella.FieldByName('DATAADOZ').AsDateTime);
    dedtDataSep.Text:=selTabella.FieldByName('DATASEP').AsString;
    dedtDataMat.Text:=selTabella.FieldByName('DATAMAT').AsString;
    dedtDataRilascioCartaId.Text:=selTabella.FieldByName('CARTA_ID_DATA_RIL').AsString;
    dedtDataScadenzaCartaId.Text:=selTabella.FieldByName('CARTA_ID_DATA_SCAD').AsString;
    edtDataRilascioPassaporto.Text:=selTabella.FieldByName('PASSAPORTO_DATA_RIL').AsString;
    edtDataScadenzaPassaporto.Text:=selTabella.FieldByName('PASSAPORTO_DATA_SCAD').AsString;
    dedtGravInizioTeorico.Text:=selTabella.FieldByName('GRAV_INIZIO_TEOR').AsString;
    dedtGravInizioScelto.Text:=selTabella.FieldByName('GRAV_INIZIO_SCELTA').AsString;
    dedtGravInizioEffettivo.Text:=selTabella.FieldByName('GRAV_INIZIO_EFF').AsString;
    dedtGravFine.Text:=selTabella.FieldByName('GRAV_FINE').AsString;
    dedtUltimaDich.Text:=selTabella.FieldByName('DATA_ULT_FAM_CAR').AsString;
    dedtAnnoRevisione.Text:=selTabella.FieldByName('ANNO_REVISIONE').AsString;
    //Impostazione campi db
    cmbParentela.ItemIndex:=S031FFamiliariMW.cmbParentelaItemIndex;
    cmbTipoPar.ItemIndex:=S031FFamiliariMW.cmbTipoParentelaItemIndex;
    cmbMotivoTerzoGrado.ItemIndex:=S031FFamiliariMW.cmbMotivoTerzoGradoItemIndex;
    cmbTipoAdoz.ItemIndex:=S031FFamiliariMW.cmbTipoAdozItemIndex;
    cmbTipoDisabilita.ItemIndex:=S031FFamiliariMW.cmbTipoDisabilitaItemIndex;
    cmbNomePA.ItemIndex:=S031FFamiliariMW.cmbNomePAItemIndex;
    cmbNomePA.Text:=SelTabella.FieldByName('NOME_PA').AsString;
    cmbDurataContratto.ItemIndex:=S031FFamiliariMW.cmbDurataContrattoItemIndex;
    cmbAlternativa.ItemIndex:=S031FFamiliariMW.cmbAlternativaItemIndex;
    cmbAlternativaMotivoTerzoGrado.ItemIndex:=S031FFamiliariMW.cmbAlternativaMotivoTerzoGradoItemIndex;
    cmbAlternativaNomePA.ItemIndex:=S031FFamiliariMW.cmbAlternativaNomePAItemIndex;
    cmbAlternativaNomePA.Text:=selTabella.FieldByName('NOME_PA_ALT').AsString;
    cmbMotivoEsclusione.ItemIndex:=S031FFamiliariMW.cmbMotivoEsclusioneItemIndex;
    cmbMatricola.Text:=selTabella.FieldByName('MATRICOLA').AsString;
    edtDescComNas.Text:=selTabella.FieldByName('D_DESCOMNAS').AsString;
    edtProvNas.Text:=selTabella.FieldByName('D_Provincia').AsString;
    edtComune.Text:=selTabella.FieldByName('Desc_Comune').AsString;
    edtProvRes.Text:=selTabella.FieldByName('Prov_Comune').AsString;
    lblFamiliare.Caption:=selTabella.FieldByName('D_FAMILIARE').AsString;
    if selTabella.FieldByName('TIPO_DETRAZIONE').AsString = 'ND' then
      drgpTipoDetrazione.ItemIndex:=0
    else if selTabella.FieldByName('TIPO_DETRAZIONE').AsString = 'DC' then
      drgpTipoDetrazione.ItemIndex:=1
    else if selTabella.FieldByName('TIPO_DETRAZIONE').AsString = 'DF' then
      drgpTipoDetrazione.ItemIndex:=2
    else if selTabella.FieldByName('TIPO_DETRAZIONE').AsString = 'DA' then
      drgpTipoDetrazione.ItemIndex:=3;
    cmbNazionalita.Text:=selTabella.FieldByName('NAZIONE').AsString;
    lblDescNazionalita.Caption:=VarToStr(S031FFamiliariMW.selT483.Lookup('COD_NAZIONE',selTabella.FieldByName('NAZIONE').AsString,'DESCRIZIONE'));
  end;
  dedtRedditoAnfAsyncExit(nil,nil);
end;

procedure TWS031FFamiliariDettFM.lnkDescrComNasClick(Sender: TObject);
var codice:String;
begin
  if Sender = lnkComune then
    codice:=dedtComune.Text
  else
    codice:=dedtComNas.Text;
  (Self.Owner as TWR100FBase).AccediForm(530,'CODICE=' + codice + ParamDelimiter +
    'TIPOARCHIVIO=C' + ParamDelimiter + 'TIPOCOMUNE=T');//EntiLocali
end;

procedure TWS031FFamiliariDettFM.lnkNazionalitaClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWR100FBase).AccediForm(530,'CODICE=' + cmbNazionalita.Text + ParamDelimiter + 'TIPOARCHIVIO=N');//EntiLocali
end;

procedure TWS031FFamiliariDettFM.dedtDataAdozAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(
     Format('SubmitClick("%s", "", true);',[btnVisualizzaComponenti.HTMLName]));
end;

procedure TWS031FFamiliariDettFM.btnVisualizzaComponentiClick(Sender: TObject);
begin
  inherited;
  C190VisualizzaElemento(JQuery,'gpbGravidanza',(cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]) and
    (Trim(dedtDataAdoz.Text) = '') and (Trim(dedtDataPreAdoz.Text) = ''));    //Figlio o affidato con data adozione nulla
  if (cmbParentela.ItemIndex in [GP_FIGLIO,GP_AFFIDATO]) and
     (Trim(dedtDataAdoz.Text) = '') and (Trim(dedtDataPreAdoz.Text) = '') then
  begin
    lblGravInizioTeorico.Enabled:=False;
    dedtGravInizioTeorico.Enabled:=False;
    lblGravInizioScelto.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtGravInizioScelto.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblGravInizioEffettivo.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtGravInizioEffettivo.Enabled:=Parametri.Applicazione <> 'PAGHE';
    lblGravFine.Enabled:=Parametri.Applicazione <> 'PAGHE';
    dedtGravFine.Enabled:=Parametri.Applicazione <> 'PAGHE';
  end
  else if ((WR302DM as TWS031FFamiliariDM).SelTabella.State in [dsEdit,dsInsert]) then
  begin
    dedtGravInizioTeorico.Text:='';
    dedtGravInizioScelto.Text:='';
    dedtGravInizioEffettivo.Text:='';
    dedtGravFine.Text:='';
  end;
end;

procedure TWS031FFamiliariDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(IntfWebT480Nas);
  FreeAndNil(IntfWebT480Res);
end;

end.
