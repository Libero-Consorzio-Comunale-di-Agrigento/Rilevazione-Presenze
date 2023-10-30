unit WA002UAnagrafeDettFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls, meIWDBEdit,
  IWCompLabel, meIWLabel, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  WA002UAnagrafeDM, IWCompGrids, meIWGrid, medpIWTabControl,
  meIWRegion, IWCompButton, meIWButton, Db, OracleData, Oracle,
  meIWEdit,C180FunzioniGenerali, IWCompCheckbox, meIWDBCheckBox,
  A000UInterfaccia, A000USessione,
  C190FunzioniGeneraliWeb,WR100UBase,WC013UCheckListFM, Menus,
  IWHTMLControls, meIWLink,WA005UDatiLiberi,WA084UTipoRapporto,
  WA022UContratti,WA014UDebitiAggiuntivi,WA024UIndPresenza,
  WA085UPartTime,WA012UCalendari, WA007UProfiliOrari,WA080UTipologieCartellini,
  WA009UProfAsseAnn,WA142UQualifMinisteriali,C006UStoriaDati,WC006UStoriaDipFM,
  WA143UMedicineLegali,WA136URelazioniAnagrafe,
  medpIWMultiColumnComboBox, A000UCostanti, UIntfWebT480;

const
  WA002_EM2PIXEL = 10;

type
  GruppoComponenti = record
    EtichettaComponente   : TControl; // TmeIWLabel o TmeIWLink;
    Componenti      : array[0..2] of TControl;// TComponent;
    NomeCampo       : String;
    Accesso         : String;
    NomePagina      : String;
    isT430          : Boolean; //usato per riconoscere i dati storicizzati di 430 (usata anche da ricerca campo)
  end;

  Pagina = record
    Caption    : String;
    Componente : TIWRegion;
  end;

  TWA002FAnagrafeDettFM = class(TWR205FDettTabellaFM)
    meIWLabel1: TmeIWLabel;
    grdTabDetail: TmedpIWTabControl;
    WA002DatiAnagraficiRG: TmeIWRegion;
    lblMatricola: TmeIWLabel;
    dedtMatricola: TmeIWDBEdit;
    lblCognome: TmeIWLabel;
    lblNome: TmeIWLabel;
    lblBadge: TmeIWLabel;
    lblSesso: TmeIWLabel;
    drgpSesso: TmeIWDBRadioGroup;
    dedtBadge: TmeIWDBEdit;
    dedtNome: TmeIWDBEdit;
    dedtCognome: TmeIWDBEdit;
    lblDataNascita: TmeIWLabel;
    dedtDataNascita: TmeIWDBEdit;
    lblComuneNascita: TmeIWLabel;
    dedtComuneNascita: TmeIWDBEdit;
    dedtCapNascita: TmeIWDBEdit;
    lblCapNascita: TmeIWLabel;
    lblProvNascita: TmeIWLabel;
    WA002ParametriOrarioRG: TmeIWRegion;
    btnNascita: TmeIWButton;
    edtDescComuneNascita: TmeIWEdit;
    edtProvNascita: TmeIWEdit;
    lblCodiceFiscale: TmeIWLabel;
    lblTelefono: TmeIWLabel;
    dedtCodiceFiscale: TmeIWDBEdit;
    dedtTelefono: TmeIWDBEdit;
    lblComuneResidenza: TmeIWLabel;
    edtDescComuneResidenza: TmeIWEdit;
    dEdtComuneResidenza: TmeIWDBEdit;
    dedtCapResidenza: TmeIWDBEdit;
    lblCapResidenza: TmeIWLabel;
    edtProvResidenza: TmeIWEdit;
    lblProvResidenza: TmeIWLabel;
    btnResidenza: TmeIWButton;
    lblIndirizzo: TmeIWLabel;
    dedtIndirizzo: TmeIWDBEdit;
    lblInizio: TmeIWLabel;
    lblFine: TmeIWLabel;
    dedtInizio: TmeIWDBEdit;
    dedtFine: TmeIWDBEdit;
    lblInizioServizio: TmeIWLabel;
    dedtInizioServizio: TmeIWDBEdit;
    dChkRapportiUniti: TmeIWDBCheckBox;
    lblDescTipoRapporto: TmeIWLabel;
    lblTerminali: TmeIWLabel;
    dedTerminali: TmeIWDBEdit;
    dChkDocente: TmeIWDBCheckBox;
    lblDescSquadraTurni: TmeIWLabel;
    lblTipoOperatore: TmeIWLabel;
    dedtTipoOperatore: TmeIWDBEdit;
    drgpTipoPersonale: TmeIWDBRadioGroup;
    lblTipoPersonale: TmeIWLabel;
    lblEdizioneBadge: TmeIWLabel;
    dedtEdizioneBadge: TmeIWDBEdit;
    WA002PresenzeAssenzeRG: TmeIWRegion;
    TemplateDinamico: TIWTemplateProcessorHTML;
    dchkCausStraord: TmeIWDBCheckBox;
    drgpStraordE: TmeIWDBRadioGroup;
    lblStraordE: TmeIWLabel;
    drgpStraordEU2: TmeIWDBRadioGroup;
    lblStraordEU2: TmeIWLabel;
    drgpStraordEU: TmeIWDBRadioGroup;
    lblStraordEU: TmeIWLabel;
    drgpStraordU: TmeIWDBRadioGroup;
    lblStraordU: TmeIWLabel;
    lblDescContratto: TmeIWLabel;
    dedtOrario: TmeIWDBEdit;
    lblOrario: TmeIWLabel;
    dChkGestioneTurnista: TmeIWDBCheckBox;
    drgpHTeoriche: TmeIWDBRadioGroup;
    lblHTeoriche: TmeIWLabel;
    lblDescPlusOra: TmeIWLabel;
    lblDescIndennitaPresenza: TmeIWLabel;
    lblDescPartTime: TmeIWLabel;
    lblDescCalendario: TmeIWLabel;
    lblDescProfiloOrario: TmeIWLabel;
    lblDescTipoCartellino: TmeIWLabel;
    lblDescProfiloAssenze: TmeIWLabel;
    lblAssenzeAbilitate: TmeIWLabel;
    dedtAssenzeAbilitate: TmeIWDBEdit;
    btnAssenzeAbilitate: TmeIWButton;
    lblPresenzeAbilitate: TmeIWLabel;
    dedtPresenzeAbilitate: TmeIWDBEdit;
    btnPresenzeAbilitate: TmeIWButton;
    lblDescQualificaMinisteriale: TmeIWLabel;
    lblTipoLocalitaDistLavoro: TmeIWLabel;
    drgpTipoLocalitaDistLavoro: TmeIWDBRadioGroup;
    lblLocalitaDistLavoro: TmeIWLabel;
    edtDescLocalitaDistLavoro: TmeIWEdit;
    btnLocalitaDistLavoro: TmeIWButton;
    dedtCodLocalitaDistLavoro: TmeIWDBEdit;
    lblDescMedicinaLegale: TmeIWLabel;
    dedtMail: TmeIWDBEdit;
    lblMail: TmeIWLabel;
    lnkTipoRapporto: TmeIWLink;
    lnkSquadraTurni: TmeIWLink;
    lnkContratto: TmeIWLink;
    lnkPlusOra: TmeIWLink;
    lnkIndennitaPresenza: TmeIWLink;
    lnkPartTime: TmeIWLink;
    lnkCalendario: TmeIWLink;
    lnkProfiloOrario: TmeIWLink;
    lnkTipoCartellino: TmeIWLink;
    lnkProfiloAssenze: TmeIWLink;
    lnkQualificaMinisteriale: TmeIWLink;
    lnkMedicinaLegale: TmeIWLink;
    lblInizioIndMat: TmeIWLabel;
    lblFineIndMat: TmeIWLabel;
    dedtInizioIndMat: TmeIWDBEdit;
    dedtFineIndMat: TmeIWDBEdit;
    cmbTipoRapporto: TMedpIWMultiColumnComboBox;
    cmbSquadraTurni: TMedpIWMultiColumnComboBox;
    cmbContratto: TMedpIWMultiColumnComboBox;
    cmbPlusOra: TMedpIWMultiColumnComboBox;
    cmbIndennitaPresenza: TMedpIWMultiColumnComboBox;
    cmbPartTime: TMedpIWMultiColumnComboBox;
    cmbCalendario: TMedpIWMultiColumnComboBox;
    cmbProfiloOrario: TMedpIWMultiColumnComboBox;
    cmbTipoCartellino: TMedpIWMultiColumnComboBox;
    cmbProfiloAssenze: TMedpIWMultiColumnComboBox;
    cmbQualificaMinisteriale: TMedpIWMultiColumnComboBox;
    cmbMedicinaLegale: TMedpIWMultiColumnComboBox;
    lblIndirizzoDomBase: TmeIWLabel;
    dedtIndirizzoDomBase: TmeIWDBEdit;
    lblComuneDomBase: TmeIWLabel;
    edtDescComuneDomBase: TmeIWEdit;
    btnDomicilio: TmeIWButton;
    dedtComuneDomBase: TmeIWDBEdit;
    lblCapDomBase: TmeIWLabel;
    dedtCapDomBase: TmeIWDBEdit;
    lblProvDomBase: TmeIWLabel;
    edtProvDomBase: TmeIWEdit;
    lnkAziendaBase: TmeIWLink;
    cmbAziendaBase: TMedpIWMultiColumnComboBox;
    lblDescAziendaBase: TmeIWLabel;
    lblMailPec: TmeIWLabel;
    dedtMailPEC: TmeIWDBEdit;
    pmnAzioniDatiAnagrafici: TPopupMenu;
    mnuStoriaDipendente: TMenuItem;
    mnuStoricizCorr: TMenuItem;
    mnuStoriaDato: TMenuItem;
    mnuSeparator: TMenuItem;
    mnuRelazioni: TMenuItem;
    mnuProvvedimento: TMenuItem;
    lblTipoSoggettoBase: TmeIWLabel;
    drgpTipoSoggettoBase: TmeIWDBRadioGroup;
    lblCellulare: TmeIWLabel;
    dedtCellulare: TmeIWDBEdit;
    mnuRiepilogorapportidilavoro: TMenuItem;
    dedtMailPersonale: TmeIWDBEdit;
    lblMailPersonale: TmeIWLabel;
    dedtCellularePersonale: TmeIWDBEdit;
    lblCellularePersonale: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dedtBadgeAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure cmbAsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
    procedure TemplateDinamicoBeforeProcess(var VTemplate: TStream);
    procedure ReleaseOggetti; override;
    procedure btnAssenzeAbilitateClick(Sender: TObject);
    procedure btnPresenzeAbilitateClick(Sender: TObject);
    procedure StoriadeldipendenteClick(Sender: TObject);
    procedure dedtCapNascitaAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure dedtCodiceFiscaleAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure OnLinkClick(Sender: TObject);
    procedure dedtMatricolaAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure StoriaClick(Sender: TObject);
    procedure edtAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure RelazioniClick(Sender: TObject);
    procedure ProvvedimentoClick(Sender: TObject);
    procedure mnuRiepilogorapportidilavoroClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  private
    IntfWebT480Nas,IntfWebT480Res,IntfWebT480Dom,IntfWebT480Lav:TIntfWebT480;
    Pagine: Array of Pagina;
    nDatiLiberi: Integer;
    WC013: TWC013FCheckListFM;
    captionEmail, captionEmailPersonale, captionEmailPEC: String;
    //procedure ImpostaSelComune(Descrizione: String;Istat: String;Cap: String;Provincia:String);
    procedure ResultAssenzeAbilitate(Sender: TObject; Result:Boolean);
    procedure ResultPresenzeAbilitate(Sender: TObject; Result:Boolean);
    procedure CreaComponentiLayout;
    procedure CreaDatiLiberiComponenti;
    procedure CaricaCombo(Combo: TMedpIWMultiColumnComboBox; Query: TOracleDataSet);
    procedure CreaPagine;
    procedure ImpostaLayout;
    function GetComponentePagina(NomePagina: String): TIWRegion;
    procedure ImpostaVisible (Componente: TControl; Val: Boolean);
    procedure ImpostaEnabled (Componente: TControl; Val: Boolean);
    procedure ImpostaContextMenu (Componente: TControl; Val: TPopupMenu);
    function DivElementi(ComponentiGroup: GruppoComponenti): String;
    function DivGroupBox(ComponentiGroup: GruppoComponenti): String;
    function CssDaDimensione(Dimensione : Double) : String;
    procedure ImpostaEtichettaDescrizione(Codice: String; Query: TOracleDataset; Lbl: TIWLabel);
    procedure ImpostaContextMenuComponenti;
    procedure SpostaStoricoResultEvent (Sender: TObject; ResultDec,ResultFine: TDateTime);
    function CampoRelazione(i: Integer): Boolean;
    function CampoNonStoricizzabile(i: Integer): Boolean;
    function IndiceComponente(Campo: String): Integer;
    function IndiceComponenteByNomeComp(NomeComponente:String): Integer;
    procedure SvuotaTutteCombo;
    function CampoAccessoRelazioni(i:Integer):String;
    procedure evtAggiornaComuneNas;
    procedure evtAggiornaComuneRes;
    procedure evtAggiornaComuneDom;
    procedure evtAggiornaComuneLav;
  protected
    procedure DataSet2Componenti; override;
    procedure Componenti2Dataset; override;
    procedure AbilitaComponenti(); override;
    procedure CaricaMultiColumnCombobox; override;
  public
    ComponentiLayout: Array of GruppoComponenti;
    procedure CaricaTutteCombo(SoloStoriche: Boolean );
    procedure CambioDataDecorrenza;
    function GetIdPagina(NomePagina: String): Integer;
    procedure EseguiRelazioni(sNomeCampo:String);
  end;

implementation uses WA002UAnagrafe, A002UAnagrafeMW;

{$R *.dfm}

procedure TWA002FAnagrafeDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  //Caratto 21/12/2012 Mai impostare da desgin. se piuù form punta sempre al primo
  with TWA002FAnagrafeDM(TWA002FAnagrafe(Self.Owner).WR302DM) do
  begin
    dEdtMatricola.DataSource:=dsrT030;
    dEdtCognome.DataSource:=dsrT030;
    dEdtNome.DataSource:=dsrT030;
    drgpSesso.DataSource:=dsrT030;
    dEdtDataNascita.DataSource:=dsrT030;
    dEdtComuneNascita.DataSource:=dsrT030;
    dEdtCapNascita.DataSource:=dsrT030;
    dEdtMail.DataSource:=dsrT030;
    dedtMailPEC.DataSource:=dsrT030;
    dedtCellulare.DataSource:=dsrT030;
    dEdtCodiceFiscale.DataSource:=dsrT030;
    dEdtInizioServizio.DataSource:=dsrT030;
    drgpTipoPersonale.DataSource:=dsrT030;
    drgpTipoSoggettoBase.DataSource:=dsrT030;
    dedtMailPersonale.DataSource:=dsrT030;
    dedtCellularePersonale.DataSource:=dsrT030;
  end;
  inherited;
  IntfWebT480Nas:=TIntfWebT480.Create(Self.Parent);
  IntfWebT480Res:=TIntfWebT480.Create(Self.Parent);
  IntfWebT480Dom:=TIntfWebT480.Create(Self.Parent);
  IntfWebT480Lav:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480Nas do
  begin
    Titolo:='Scelta comune di nascita';
    DataSource:=(WR302DM as TWA002FAnagrafeDM).dsrComune;
    edtCitta:=edtDescComuneNascita;
    dedtCodice:=dedtComuneNascita;
    dedtCap:=dedtCapNascita;
    edtProvincia:=edtProvNascita;
    btnLookup:=btnNascita;
    CustomResultLookup:=evtAggiornaComuneNas;
  end;
  with IntfWebT480Res do
  begin
    Titolo:='Scelta comune di residenza';
    DataSource:=(WR302DM as TWA002FAnagrafeDM).dsrComune;
    edtCitta:=edtDescComuneResidenza;
    dedtCodice:=dedtComuneResidenza;
    dedtCap:=dedtCapResidenza;
    edtProvincia:=edtProvResidenza;
    btnLookup:=btnResidenza;
    CustomResultLookup:=evtAggiornaComuneRes;
  end;
  with IntfWebT480Dom do
  begin
    Titolo:='Scelta comune di domicilio';
    DataSource:=(WR302DM as TWA002FAnagrafeDM).dsrComune;
    edtCitta:=edtDescComuneDomBase;
    dedtCodice:=dedtComuneDomBase;
    dedtCap:=dedtCapDomBase;
    edtProvincia:=edtProvDomBase;
    btnLookup:=btnDomicilio;
    CustomResultLookup:=evtAggiornaComuneDom;
  end;
  with IntfWebT480Lav do
  begin
    Titolo:='Scelta località di lavoro';
    DataSource:=(WR302DM as TWA002FAnagrafeDM).dsrComune;
    edtCitta:=edtDescLocalitaDistLavoro;
    dedtCodice:=dedtCodLocalitaDistLavoro;
    btnLookup:=btnLocalitaDistLavoro;
    CustomResultLookup:=evtAggiornaComuneLav;
  end;
  CreaComponentiLayout;
  //Devo impostare abilitazione dei campi creati da CreaDatiLiberiComponenti
  AbilitaAllComponenti(nil);
  //forzo caricamento. avviene nella creazione del padre quando non sono ancora stati creati i dati liberi
  DataSet2Componenti;
  CreaPagine;
  ImpostaLayout;
end;

procedure TWA002FAnagrafeDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  (*
  if TWA002FAnagrafeDM(WR302DM).selTabella.State in [dsInsert] then
    if TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName('DATADECORRENZA').IsNull then
  begin
    TWA002FAnagrafe(Self.Owner).dedtDataDecorrenza.Text:='';
  end;
  *)
end;

procedure TWA002FAnagrafeDettFM.mnuRiepilogorapportidilavoroClick(Sender: TObject);
var Dato: String;
begin
  inherited;
  try
    Dato:=ComponentiLayout[pmnAzioniDatiAnagrafici.PopupComponent.Tag].NomeCampo;
    TWR100FBase(Self.Parent).AccediForm(161,'CAMPO=' + Dato +
      ParamDelimiter + 'PROGRESSIVO=' +  TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName('PROGRESSIVO').AsString);
  finally
    // Reimposto a nil i PopupComponent dei menù contestuali che puntano a questo metodo
    pmnAzioniDatiAnagrafici.PopupComponent:=nil;
  end;
end;

procedure TWA002FAnagrafeDettFM.CreaPagine;
var i : Integer;
begin
  //pagine fisse
  SetLength(Pagine,3);
  i:=0;
  Pagine[i].Caption:='Dati Anagrafici';
  Pagine[i].Componente:=WA002DatiAnagraficiRG;
  grdTabDetail.AggiungiTab(Pagine[i].Caption,Pagine[i].Componente);
  inc(i);

  Pagine[i].Caption:='Parametri Orario';
  Pagine[i].Componente:=WA002ParametriOrarioRG;
  grdTabDetail.AggiungiTab(Pagine[i].Caption,Pagine[i].Componente);
  inc(i);

  Pagine[i].Caption:='Presenze/Assenze';
  Pagine[i].Componente:=WA002PresenzeAssenzeRG;
  grdTabDetail.AggiungiTab(Pagine[i].Caption,Pagine[i].Componente);
  inc(i);

  with TWA002FAnagrafeDM(WR302DM).selT033_Pagine do
  begin
    Open;
    while not Eof do
    begin
      SetLength(Pagine,i+1);
      Pagine[i].Caption:=FieldByName('NomePagina').AsString;
      Pagine[i].Componente:=TIWRegion.Create(IWFrameRegion);
      Pagine[i].Componente.Name:='WA002Pagina' + IntToStr(i+1) + 'RG';
      Pagine[i].Componente.RenderInvisibleControls:=False;   //DC 2020-08-10 - necessario impostare questa proprietà altrimenti tutti i controlli figli vengono comunque visualizzati
      Pagine[i].Componente.LayoutMgr:=TemplateDinamico;
      Pagine[i].Componente.Parent:=IWFrameRegion;
      grdTabDetail.AggiungiTab(Pagine[i].Caption,Pagine[i].Componente);
      inc(i);
      Next;
    end;
    Close;
  end;

  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA002DatiAnagraficiRG;
end;

procedure TWA002FAnagrafeDettFM.CreaComponentiLayout;
var i : Integer;
begin
  //Creo componenti per i dati liberi definiti
  CreaDatiLiberiComponenti;
  //salvo il numero di dati liberi
  nDatiLiberi:=Length(ComponentiLayout);
  //aggiungo i campi fissi, sempre presenti
  i:=nDatiLiberi;
  SetLength(ComponentiLayout,nDatiLiberi + 61);

  dedtMatricola.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblMatricola;
  ComponentiLayout[i].Componenti[0]:=dedtMatricola;
  ComponentiLayout[i].nomeCampo:=dedtMatricola.DataField;
  ComponentiLayout[i].isT430:=dedtMatricola.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtCognome.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblCognome;
  ComponentiLayout[i].Componenti[0]:=dedtCognome;
  ComponentiLayout[i].nomeCampo:=dedtCognome.DataField;
  ComponentiLayout[i].isT430:=dedtCognome.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtNome.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblNome;
  ComponentiLayout[i].Componenti[0]:=dedtNome;
  ComponentiLayout[i].nomeCampo:=dedtNome.DataField;
  ComponentiLayout[i].isT430:=dedtNome.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpSesso.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblSesso;
  ComponentiLayout[i].Componenti[0]:=drgpSesso;
  ComponentiLayout[i].nomeCampo:=drgpSesso.DataField;
  ComponentiLayout[i].isT430:=drgpSesso.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtBadge.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblBadge;
  ComponentiLayout[i].Componenti[0]:=dedtBadge;
  ComponentiLayout[i].nomeCampo:=dedtBadge.DataField;
  ComponentiLayout[i].isT430:=dedtBadge.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtEdizioneBadge.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblEdizioneBadge;
  ComponentiLayout[i].Componenti[0]:=dedtEdizioneBadge;
  ComponentiLayout[i].nomeCampo:=dedtEdizioneBadge.DataField;
  ComponentiLayout[i].isT430:=dedtEdizioneBadge.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtDataNascita.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblDataNascita;
  ComponentiLayout[i].Componenti[0]:=dedtDataNascita;
  ComponentiLayout[i].nomeCampo:=dedtDataNascita.DataField;
  ComponentiLayout[i].isT430:=dedtDataNascita.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  edtDescComuneNascita.Tag:=i;
  dedtComuneNascita.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblComuneNascita;
  ComponentiLayout[i].Componenti[0]:=edtDescComuneNascita;
  ComponentiLayout[i].Componenti[1]:=btnNascita;
  ComponentiLayout[i].Componenti[2]:=dedtComuneNascita;
  //Decode sulla selT033
  ComponentiLayout[i].nomeCampo:='DescComune';
  ComponentiLayout[i].isT430:=dedtComuneNascita.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtCapNascita.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblCapNascita;
  ComponentiLayout[i].Componenti[0]:=dedtCapNascita;
  ComponentiLayout[i].nomeCampo:=dedtCapNascita.DataField;
  ComponentiLayout[i].isT430:=dedtCapNascita.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  edtProvNascita.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblProvNascita;
  ComponentiLayout[i].Componenti[0]:=edtProvNascita;
  //Decode sulla selT033
  ComponentiLayout[i].nomeCampo:='D_ProvinciaNas';
  ComponentiLayout[i].isT430:=false;
  inc(i);

  dedtCodiceFiscale.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblCodiceFiscale;
  ComponentiLayout[i].Componenti[0]:=dedtCodiceFiscale;
  ComponentiLayout[i].nomeCampo:=dedtCodiceFiscale.DataField;
  ComponentiLayout[i].isT430:=dedtCodiceFiscale.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtTelefono.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblTelefono;
  ComponentiLayout[i].Componenti[0]:=dedtTelefono;
  ComponentiLayout[i].nomeCampo:=dedtTelefono.DataField;
  ComponentiLayout[i].isT430:=dedtTelefono.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  edtDescComuneResidenza.Tag:=i;
  dEdtComuneResidenza.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblComuneResidenza;
  ComponentiLayout[i].Componenti[0]:=edtDescComuneResidenza;
  ComponentiLayout[i].Componenti[1]:=btnResidenza;
  ComponentiLayout[i].Componenti[2]:=dEdtComuneResidenza;
  //Decode sulla selT033
  ComponentiLayout[i].nomeCampo:='D_Comune';
  ComponentiLayout[i].isT430:=dEdtComuneResidenza.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtCapResidenza.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblCapResidenza;
  ComponentiLayout[i].Componenti[0]:=dedtCapResidenza;
  ComponentiLayout[i].nomeCampo:=dedtCapResidenza.DataField;
  ComponentiLayout[i].isT430:=dedtCapResidenza.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  edtProvResidenza.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblProvResidenza;
  ComponentiLayout[i].Componenti[0]:=edtProvResidenza;
  //Decode sulla selT033
  ComponentiLayout[i].nomeCampo:='D_Provincia';
  ComponentiLayout[i].isT430:=False;
  inc(i);

  dedtIndirizzo.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblIndirizzo;
  ComponentiLayout[i].Componenti[0]:=dedtIndirizzo;
  ComponentiLayout[i].nomeCampo:=dedtIndirizzo.DataField;
  ComponentiLayout[i].isT430:=dedtIndirizzo.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtInizio.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblInizio;
  ComponentiLayout[i].Componenti[0]:=dedtInizio;
  ComponentiLayout[i].nomeCampo:=dedtInizio.DataField;
  ComponentiLayout[i].isT430:=dedtInizio.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtFine.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblFine;
  ComponentiLayout[i].Componenti[0]:=dedtFine;
  ComponentiLayout[i].nomeCampo:=dedtFine.DataField;
  ComponentiLayout[i].isT430:=dedtFine.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtInizioServizio.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblInizioServizio;
  ComponentiLayout[i].Componenti[0]:=dedtInizioServizio;
  ComponentiLayout[i].nomeCampo:=dedtInizioServizio.DataField;
  ComponentiLayout[i].isT430:=dedtInizioServizio.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dChkRapportiUniti.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=nil;
  ComponentiLayout[i].Componenti[0]:=dChkRapportiUniti;
  ComponentiLayout[i].nomeCampo:=dChkRapportiUniti.DataField;
  ComponentiLayout[i].isT430:=dChkRapportiUniti.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  lnkTipoRapporto.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkTipoRapporto;
  cmbTipoRapporto.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbTipoRapporto;
  ComponentiLayout[i].Componenti[1]:=lblDescTipoRapporto;
  ComponentiLayout[i].nomeCampo:='TIPORAPPORTO';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  dedTerminali.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblTerminali;
  ComponentiLayout[i].Componenti[0]:=dedTerminali;
  ComponentiLayout[i].nomeCampo:=dedTerminali.DataField;
  ComponentiLayout[i].isT430:=dedTerminali.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dChkDocente.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=nil;
  ComponentiLayout[i].Componenti[0]:=dChkDocente;
  ComponentiLayout[i].nomeCampo:=dChkDocente.DataField;
  ComponentiLayout[i].isT430:=dChkDocente.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  lnkSquadraTurni.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkSquadraTurni;
  cmbSquadraTurni.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbSquadraTurni;
  ComponentiLayout[i].Componenti[1]:=lblDescSquadraTurni;
  ComponentiLayout[i].nomeCampo:='SQUADRA';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  dedtTipoOperatore.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblTipoOperatore;
  ComponentiLayout[i].Componenti[0]:=dedtTipoOperatore;
  ComponentiLayout[i].nomeCampo:=dedtTipoOperatore.DataField;
  ComponentiLayout[i].isT430:=dedtTipoOperatore.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpTipoPersonale.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblTipoPersonale;
  ComponentiLayout[i].Componenti[0]:=drgpTipoPersonale;
  ComponentiLayout[i].nomeCampo:=drgpTipoPersonale.DataField;
  ComponentiLayout[i].isT430:=drgpTipoPersonale.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpTipoSoggettoBase.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblTipoSoggettoBase;
  ComponentiLayout[i].Componenti[0]:=drgpTipoSoggettoBase;
  ComponentiLayout[i].nomeCampo:=drgpTipoSoggettoBase.DataField;
  ComponentiLayout[i].isT430:=drgpTipoSoggettoBase.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dchkCausStraord.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=nil;
  ComponentiLayout[i].Componenti[0]:=dchkCausStraord;
  ComponentiLayout[i].nomeCampo:=dchkCausStraord.DataField;
  ComponentiLayout[i].isT430:=dchkCausStraord.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpStraordE.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblStraordE;
  ComponentiLayout[i].Componenti[0]:=drgpStraordE;
  ComponentiLayout[i].nomeCampo:=drgpStraordE.DataField;
  ComponentiLayout[i].isT430:=drgpStraordE.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpStraordEU2.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblStraordEU2;
  ComponentiLayout[i].Componenti[0]:=drgpStraordEU2;
  ComponentiLayout[i].nomeCampo:=drgpStraordEU2.DataField;
  ComponentiLayout[i].isT430:=drgpStraordEU2.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpStraordEU.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblStraordEU;
  ComponentiLayout[i].Componenti[0]:=drgpStraordEU;
  ComponentiLayout[i].nomeCampo:=drgpStraordEU.DataField;
  ComponentiLayout[i].isT430:=drgpStraordEU.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpStraordU.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblStraordU;
  ComponentiLayout[i].Componenti[0]:=drgpStraordU;
  ComponentiLayout[i].nomeCampo:=drgpStraordU.DataField;
  ComponentiLayout[i].isT430:=drgpStraordU.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  lnkContratto.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkContratto;
  cmbContratto.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbContratto;
  ComponentiLayout[i].Componenti[1]:=lblDescContratto;
  ComponentiLayout[i].nomeCampo:='CONTRATTO';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  dedtOrario.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblOrario;
  ComponentiLayout[i].Componenti[0]:=dedtOrario;
  ComponentiLayout[i].nomeCampo:=dedtOrario.DataField;
  ComponentiLayout[i].isT430:=dedtOrario.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dchkGestioneTurnista.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=nil;
  ComponentiLayout[i].Componenti[0]:=dchkGestioneTurnista;
  ComponentiLayout[i].nomeCampo:=dchkGestioneTurnista.DataField;
  ComponentiLayout[i].isT430:=dchkGestioneTurnista.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  drgpHTeoriche.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblHTeoriche;
  ComponentiLayout[i].Componenti[0]:=drgpHTeoriche;
  ComponentiLayout[i].nomeCampo:=drgpHTeoriche.DataField;
  ComponentiLayout[i].isT430:=drgpHTeoriche.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  lnkPlusOra.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkPlusOra;
  cmbPlusOra.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbPlusOra;
  ComponentiLayout[i].Componenti[1]:=lblDescPlusOra;
  ComponentiLayout[i].nomeCampo:='PLUSORA';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  lnkIndennitaPresenza.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkIndennitaPresenza;
  cmbIndennitaPresenza.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbIndennitaPresenza;
  ComponentiLayout[i].Componenti[1]:=lblDescIndennitaPresenza;
  ComponentiLayout[i].nomeCampo:='IPRESENZA';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  lnkPartTime.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkPartTime;
  cmbPartTime.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbPartTime;
  ComponentiLayout[i].Componenti[1]:=lblDescPartTime;
  ComponentiLayout[i].nomeCampo:='PARTTIME';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  lnkCalendario.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkCalendario;
  cmbCalendario.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbCalendario;
  ComponentiLayout[i].Componenti[1]:=lblDescCalendario;
  ComponentiLayout[i].nomeCampo:='CALENDARIO';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  lnkProfiloOrario.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkProfiloOrario;
  cmbProfiloOrario.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbProfiloOrario;
  ComponentiLayout[i].Componenti[1]:=lblDescProfiloOrario;
  ComponentiLayout[i].nomeCampo:='PORARIO';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  lnkTipoCartellino.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkTipoCartellino;
  cmbTipoCartellino.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbTipoCartellino;
  ComponentiLayout[i].Componenti[1]:=lblDescTipoCartellino;
  ComponentiLayout[i].nomeCampo:='PERSELASTICO';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  lnkProfiloAssenze.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkProfiloAssenze;
  cmbProfiloAssenze.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbProfiloAssenze;
  ComponentiLayout[i].Componenti[1]:=lblDescProfiloAssenze;
  ComponentiLayout[i].nomeCampo:='PASSENZE';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  dedtAssenzeAbilitate.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblAssenzeAbilitate;
  ComponentiLayout[i].Componenti[0]:=dedtAssenzeAbilitate;
  ComponentiLayout[i].Componenti[1]:=btnAssenzeAbilitate;
  ComponentiLayout[i].nomeCampo:=dedtAssenzeAbilitate.DataField;
  ComponentiLayout[i].isT430:=dedtAssenzeAbilitate.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtPresenzeAbilitate.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblPresenzeAbilitate;
  ComponentiLayout[i].Componenti[0]:=dedtPresenzeAbilitate;
  ComponentiLayout[i].Componenti[1]:=btnPresenzeAbilitate;
  ComponentiLayout[i].nomeCampo:=dedtPresenzeAbilitate.DataField;
  ComponentiLayout[i].isT430:=dedtPresenzeAbilitate.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  lnkQualificaMinisteriale.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkQualificaMinisteriale;
  cmbQualificaMinisteriale.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbQualificaMinisteriale;
  ComponentiLayout[i].Componenti[1]:=lblDescQualificaMinisteriale;
  ComponentiLayout[i].nomeCampo:='QUALIFICAMINIST';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  drgpTipoLocalitaDistLavoro.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblTipoLocalitaDistLavoro;
  ComponentiLayout[i].Componenti[0]:=drgpTipoLocalitaDistLavoro;
  ComponentiLayout[i].nomeCampo:=drgpTipoLocalitaDistLavoro.DataField;
  ComponentiLayout[i].isT430:=drgpTipoLocalitaDistLavoro.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  edtDescLocalitaDistLavoro.Tag:=i;
  dedtCodLocalitaDistLavoro.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblLocalitaDistLavoro;
  ComponentiLayout[i].Componenti[0]:=edtDescLocalitaDistLavoro;
  ComponentiLayout[i].Componenti[1]:=btnLocalitaDistLavoro;
  ComponentiLayout[i].Componenti[2]:=dedtCodLocalitaDistLavoro;
  ComponentiLayout[i].nomeCampo:=dedtCodLocalitaDistLavoro.DataField;
  ComponentiLayout[i].isT430:=dedtCodLocalitaDistLavoro.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  lnkMedicinaLegale.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkMedicinaLegale;
  cmbMedicinaLegale.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbMedicinaLegale;
  ComponentiLayout[i].Componenti[1]:=lblDescMedicinaLegale;
  ComponentiLayout[i].nomeCampo:='MEDICINA_LEGALE';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  dedtMail.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblMail;
  ComponentiLayout[i].Componenti[0]:=dedtMail;
  ComponentiLayout[i].nomeCampo:=dedtMail.DataField;
  ComponentiLayout[i].isT430:=dedtMail.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtMailPEC.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblMailPec;
  ComponentiLayout[i].Componenti[0]:=dedtMailPEC;
  ComponentiLayout[i].nomeCampo:=dedtMailPEC.DataField;
  ComponentiLayout[i].isT430:=dedtMailPEC.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtCellulare.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblCellulare;
  ComponentiLayout[i].Componenti[0]:=dedtCellulare;
  ComponentiLayout[i].nomeCampo:=dedtCellulare.DataField;
  ComponentiLayout[i].isT430:=dedtCellulare.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtInizioIndMat.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblInizioIndMat;
  ComponentiLayout[i].Componenti[0]:=dedtInizioIndMat;
  ComponentiLayout[i].nomeCampo:=dedtInizioIndMat.DataField;
  ComponentiLayout[i].isT430:=dedtInizioIndMat.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtFineIndMat.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblFineIndMat;
  ComponentiLayout[i].Componenti[0]:=dedtFineIndMat;
  ComponentiLayout[i].nomeCampo:=dedtFineIndMat.DataField;
  ComponentiLayout[i].isT430:=dedtFineIndMat.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  // domicilio
  edtDescComuneDomBase.Tag:=i;
  dedtComuneDomBase.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblComuneDomBase;
  ComponentiLayout[i].Componenti[0]:=edtDescComuneDomBase;
  ComponentiLayout[i].Componenti[1]:=btnDomicilio;
  ComponentiLayout[i].Componenti[2]:=dedtComuneDomBase;
  //Decode sulla selT033
  ComponentiLayout[i].nomeCampo:='D_COMUNE_DOM_BASE';
  ComponentiLayout[i].isT430:=dedtComuneDomBase.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtCapDomBase.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblCapDomBase;
  ComponentiLayout[i].Componenti[0]:=dedtCapDomBase;
  ComponentiLayout[i].nomeCampo:=dedtCapDomBase.DataField;
  ComponentiLayout[i].isT430:=dedtCapDomBase.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  edtProvDomBase.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblProvDomBase;
  ComponentiLayout[i].Componenti[0]:=edtProvDomBase;
  //Decode sulla selT033
  ComponentiLayout[i].nomeCampo:='D_PROVINCIA_DOM_BASE';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  dedtIndirizzoDomBase.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblIndirizzoDomBase;
  ComponentiLayout[i].Componenti[0]:=dedtIndirizzoDomBase;
  ComponentiLayout[i].nomeCampo:=dedtIndirizzoDomBase.DataField;
  ComponentiLayout[i].isT430:=dedtIndirizzoDomBase.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  lnkAziendaBase.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lnkAziendaBase;
  cmbAziendaBase.Tag:=i;
  ComponentiLayout[i].Componenti[0]:=cmbAziendaBase;
  ComponentiLayout[i].Componenti[1]:=lblDescAziendaBase;
  ComponentiLayout[i].nomeCampo:='AZIENDA_BASE';
  ComponentiLayout[i].isT430:=True;
  inc(i);

  dedtMailPersonale.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblMailPersonale;
  ComponentiLayout[i].Componenti[0]:=dedtMailPersonale;
  ComponentiLayout[i].nomeCampo:=dedtMailPersonale.DataField;
  ComponentiLayout[i].isT430:=dedtMailPersonale.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  dedtCellularePersonale.Tag:=i;
  ComponentiLayout[i].EtichettaComponente:=lblCellularePersonale;
  ComponentiLayout[i].Componenti[0]:=dedtCellularePersonale;
  ComponentiLayout[i].nomeCampo:=dedtCellularePersonale.DataField;
  ComponentiLayout[i].isT430:=dedtCellularePersonale.DataSource = TWA002FAnagrafeDM(WR302DM).dsrTabella;
  inc(i);

  // *************************   IMPORTANTE   *************************
  // *  per aggiungere nuovi componenti ricordarsi di dimensionare    *
  // *  opportunamente l'array "ComponentiLayout", incrementando      *
  // *  il valore della SetLength() iniziale                          *
  // ******************************************************************

  //Imposto menu contestuale sui componenti
  ImpostaContextMenuComponenti;
end;

{
Crea i componenti data-aware per i dati liberi definiti
}
procedure TWA002FAnagrafeDettFM.CreaDatiLiberiComponenti;
var i,j : Integer;
    RGParent : TIWRegion;
    NomeComponente, NomeComponenteOrig: String;
    LstNomiComponenti: TStringList;
begin
  with TWA002FAnagrafeDM(WR302DM) do
  begin
    SetLength(ComponentiLayout,Length(DatiLiberiDM));
    LstNomiComponenti:=TStringList.Create;
    RGParent:=WA002DatiAnagraficiRG; //appoggio temporaneo. inserito nel parent corretto quando si disegna layout

    for i:=0 to Self.ComponentCount - 1 do
    begin
      if LowerCase(Self.Components[i].Name).Substring(0,3) = 'lbl' then
        LstNomiComponenti.Add(UpperCase(Self.Components[i].Name).Substring(3));
    end;

    for i:=0 to Length(DatiLiberiDM) - 1  do
    begin
      //Creazione componente Data-aware
      // trasformare da nome campo a nome componente valido (es togliere _)

      NomeComponenteOrig:=StringReplace(DatiLiberiDM[i].Nome,'_','',[rfReplaceAll]);
      //Caratto 15/07/2013 - ini - gestire univocità nome componente. Non si può usare C190CreaNomeComponente poichè
      //per lo stesso campo vengono creati più campi diversi con diversi prefissi (lbl, lnk, dedt, cmb)
      NomeComponente:=NomeComponenteOrig;
      j:=0;
      while LstNomiComponenti.IndexOf(NomeComponente) <> -1 do
      begin
        NomeComponente:=NomeComponenteOrig + IntToStr(j);
        j:=j+1;
      end;
      LstNomiComponenti.Add(NomeComponente);
      //Caratto 15/07/2013 - fine

      with ComponentiLayout[i] do
      begin
        isT430:=True; //campo di selTabella (T430_Storico)
        //Se campo tabellare creo MultiColumnComboBox e label per decodifica
        if DatiLiberiDM[i].NomeTabella <> '' then
        begin
          //link intestazione campo per accedi
          EtichettaComponente:=TmeIWLink.Create(Self);
          TmeIWLink(EtichettaComponente).Name:='lnk'+NomeComponente;
          TmeIWLink(EtichettaComponente).FriendlyName:=EtichettaComponente.Name;
          TmeIWLink(EtichettaComponente).Css:='intestazione link';
          TmeIWLink(EtichettaComponente).Parent:=RGParent;
          TmeIWLink(EtichettaComponente).Caption:=DatiLiberiDM[i].Nome;
          TmeIWLink(EtichettaComponente).Visible:=True;
          TmeIWLink(EtichettaComponente).Tag:=i;
          TmeIWLink(EtichettaComponente).OnClick:=OnLinkClick;

          //multicolumncombo
          Componenti[0]:=TMedpIWMultiColumnComboBox.Create(Self);
          Componenti[0].Tag:=i;
          Componenti[0].Name:='cmb' + NomeComponente;
          TMedpIWMultiColumnComboBox(Componenti[0]).FriendlyName:=Componenti[0].Name;
          TMedpIWMultiColumnComboBox(Componenti[0]).Parent:=RGParent;
          TMedpIWMultiColumnComboBox(Componenti[0]).Css:='medpMultiColumnCombo inline';
          TMedpIWMultiColumnComboBox(Componenti[0]).CssInputText:=C190GetCssWidthChr(Trunc(DatiLiberiDM[i].Dimensione));//'width5chr';
          TMedpIWMultiColumnComboBox(Componenti[0]).colCount:=2;
          TMedpIWMultiColumnComboBox(Componenti[0]).columnSeparator:=';';
          TMedpIWMultiColumnComboBox(Componenti[0]).PopUpHeight:=10;
          TMedpIWMultiColumnComboBox(Componenti[0]).MedpAutoresetItems:=true;
          TMedpIWMultiColumnComboBox(Componenti[0]).OnAsyncChange:=cmbAsyncChange;

          //label per decodifica
          Componenti[1]:=TmeIWLabel.Create(Self);
          Componenti[1].Tag:=i;
          Componenti[1].Name:='lblDesc'+NomeComponente;
          TmeIWLabel(Componenti[1]).FriendlyName:=Componenti[1].Name;
          TmeIWLabel(Componenti[1]).Css:='intestazione spazio_sx';
          TmeIWLabel(Componenti[1]).Parent:=RGParent;
          TmeIWLabel(Componenti[1]).AutoSize:=True;
          TmeIWLabel(Componenti[1]).Visible:=True;
        end
        else  //Se campo NON tabellare creo meIWDBEdit
        begin
          //label intestazione campo
          EtichettaComponente:=TmeIWLabel.Create(Self);
          TmeIWLabel(EtichettaComponente).Name:='lbl'+NomeComponente;
          TmeIWLabel(EtichettaComponente).FriendlyName:=EtichettaComponente.Name;
          TmeIWLabel(EtichettaComponente).Css:='intestazione';
          TmeIWLabel(EtichettaComponente).Parent:=RGParent;
          TmeIWLabel(EtichettaComponente).Caption:=DatiLiberiDM[i].Nome;
          TmeIWLabel(EtichettaComponente).AutoSize:=True;
          TmeIWLabel(EtichettaComponente).Visible:=True;
          TmeIWLabel(EtichettaComponente).Tag:=i;

          //dbedit
          Componenti[0]:=TmeIWDBEdit.Create(Self);
          Componenti[0].Tag:=i;
          Componenti[0].Name:='dedt' + NomeComponente;
          TmeIWDBEdit(Componenti[0]).FriendlyName:=Componenti[0].name;
          TmeIWDBEdit(Componenti[0]).Parent:=RGParent;
          TmeIWDBEdit(Componenti[0]).DataSource:=dsrTabella;
          TmeIWDBEdit(Componenti[0]).DataField:=DatiLiberiDM[i].Nome;
          TmeIWDBEdit(Componenti[0]).Visible:=True;
          TmeIWDBEdit(Componenti[0]).OnAsyncChange:=edtAsyncChange;
          if DatiLiberiDM[i].Formato = 'D' then
            TmeIWDBEdit(Componenti[0]).css:='input_data_dmy'
          else if DatiLiberiDM[i].Formato = 'N' then
            TmeIWDBEdit(Componenti[0]).css:=CssDaDimensione(DatiLiberiDM[i].Dimensione) + ' input_num_generic'
          else
            TmeIWDBEdit(Componenti[0]).css:=CssDaDimensione(DatiLiberiDM[i].Dimensione);
        end;

        nomeCampo:=DatiLiberiDM[i].Nome;
      end;
    end;
    FreeAndNil(LstNomiComponenti);
  end;
end;

procedure TWA002FAnagrafeDettFM.DataSet2Componenti;
var
  CodiceComune : String;
  i : Integer;
  queryLookup: TOracleDataSet;
begin
  inherited;
  //SELT030 SINCRONIZZATO CON SELTABELLA. POSSO ACCEDERE DIRETTAMENTE AI CAMPI
  with TWA002FAnagrafeDM(WR302DM) do
  begin
    //Necessario per forzare aggiornamento filtro selI030
    //A002FAnagrafeMW.selI030.Close;
    A002FAnagrafeMW.selI030.Open;
    A002FAnagrafeMW.selI030.First;
    A002FAnagrafeMW.RefreshVSQLAppoggio;
    EseguiRelazioni('');
//Caratto 26/11/2012 spostato in CaricaMultiColumnCombobox  CaricaTutteCombo(False);
    //AGGIORNA MAIL
    if selT030.FieldByName('I060EMAIL').AsString <> '' then
    begin
      lblMail.rawText:=true;
      //se ci sono più indirizzi vanno separati da , e senza spazio
      lblMail.caption:='<a href=mailto:' + StringReplace(selT030.FieldByName('I060EMAIL').AsString,'; ',',',[rfReplaceAll]) + '>'+captionEmail+'</a>';
    end
    else
    begin
      lblMail.rawText:=false;
      lblMail.caption:=captionEmail;
    end;
    //AGGIORNA MAIL PERSONALE
    if selT030.FieldByName('I060EMAILPERSONALE').AsString <> '' then
    begin
      lblMailPersonale.rawText:=true;
      //se ci sono più indirizzi vanno separati da , e senza spazio
      lblMailPersonale.caption:='<a href=mailto:' + StringReplace(selT030.FieldByName('I060EMAILPERSONALE').AsString,'; ',',',[rfReplaceAll]) + '>'+captionEmailPersonale+'</a>';
    end
    else
    begin
      lblMailPersonale.rawText:=false;
      lblMailPersonale.caption:=captionEmailPersonale;
    end;
    //AGGIORNA MAIL PEC
    if selT030.FieldByName('I060EMAILPEC').AsString <> '' then
    begin
      lblMailPec.rawText:=true;
      //se ci sono più indirizzi vanno separati da , e senza spazio
      lblMailPec.caption:='<a href=mailto:' + StringReplace(selT030.FieldByName('I060EMAILPEC').AsString,'; ',',',[rfReplaceAll]) + '>' + captionEmailPEC + '</a>';
    end
    else
    begin
      lblMailPec.rawText:=false;
      lblMailPec.caption:=captionEmailPEC;
    end;

    CodiceComune:=selT030.FieldByName('COMUNENAS').AsString;
    if CodiceComune <> '' then
    begin
      //selT480.Close;
      R180SetVariable(selT480,'CODICE',CodiceComune);
      selT480.Open;
      selT480.First;
      edtDescComuneNascita.Text:=selT480.FieldByName('CITTA').AsString;
      edtProvNascita.Text:=selT480.FieldByName('PROVINCIA').AsString;
    end
    else
    begin
      edtDescComuneNascita.Text:='';
      edtProvNascita.Text:='';
    end;

    CodiceComune:=selTabella.FieldByName('COMUNE').AsString;
    if CodiceComune <> '' then
    begin
      //selT480.Close;
      R180SetVariable(selT480,'CODICE',CodiceComune);
      selT480.Open;
      selT480.First;
      edtDescComuneResidenza.Text:=selT480.FieldByName('CITTA').AsString;
      edtProvResidenza.Text:=selT480.FieldByName('PROVINCIA').AsString;
    end
    else
    begin
      edtDescComuneResidenza.Text:='';
      edtProvResidenza.Text:='';
    end;

    CodiceComune:=selTabella.FieldByName('COMUNE_DOM_BASE').AsString;
    if CodiceComune <> '' then
    begin
      //selT480.Close;
      R180SetVariable(selT480,'CODICE',CodiceComune);
      selT480.Open;
      selT480.First;
      edtDescComuneDomBase.Text:=selT480.FieldByName('CITTA').AsString;
      edtProvDomBase.Text:=selT480.FieldByName('PROVINCIA').AsString;
    end
    else
    begin
      edtDescComuneDomBase.Text:='';
      edtProvDomBase.Text:='';
    end;

    CodiceComune:=selTabella.FieldByName(dedtCodLocalitaDistLavoro.DataField).AsString;
    if CodiceComune <> '' then
    begin
      //selT480.Close;
      R180SetVariable(selT480,'CODICE',CodiceComune);
      selT480.Open;
      selT480.First;
      edtDescLocalitaDistLavoro.Text:=selT480.FieldByName('CITTA').AsString;
    end
    else
      edtDescLocalitaDistLavoro.Text:='';

    //selT480.Close;
    //caricamento valori per campi non data-aware (sia dati liberi che componenti fissi)
    for i:=0 to Length(ComponentiLayout) - 1  do
      if ComponentiLayout[i].Componenti[0] is TMedpIWMultiColumnComboBox  then
      begin
//        TMedpIWMultiColumnComboBox(ComponentiLayout[i].Componenti[0]).ItemIndex:=-1;
        TMedpIWMultiColumnComboBox(ComponentiLayout[i].Componenti[0]).Text:=selTabella.FieldByName(ComponentiLayout[i].nomeCampo).AsString;
        //i dati liberi hanno un corrispettivo array sul DataModulo in quanto creati a runtime.
        //Per i componenti fissi non esiste corrispondenza e viene decodificato da codice
        queryLookup:=GetQueryLookUp(i,ComponentiLayout[i].NomeCampo);

        ImpostaEtichettaDescrizione(selTabella.FieldByName(ComponentiLayout[i].nomeCampo).AsString,queryLookup,TIWLabel(ComponentiLayout[i].Componenti[1]));
      end;
  end;
end;

function TWA002FAnagrafeDettFM.DivElementi(ComponentiGroup: GruppoComponenti): String;
var i :Integer;
begin
  Result:='';
  if ComponentiGroup.EtichettaComponente <> nil then
  begin
    //div per etichetta
    Result:='<div style="position:absolute;top: ' +  Stringreplace(format('%5.1f',[ComponentiGroup.EtichettaComponente.Top/WA002_EM2PIXEL]),',','.',[rfReplaceall]) +'em; left: '+  Stringreplace(format('%5.1f',[ComponentiGroup.EtichettaComponente.Left/WA002_EM2PIXEL]),',','.',[rfReplaceall]) +'em;">' +
            '{%'+ComponentiGroup.EtichettaComponente.Name+'%}' +
            '</div>'+ #13#10;
  end;
  //div dei componenti
  Result:=Result + '<div style="position:absolute;top: ' +  Stringreplace(format('%5.1f',[ComponentiGroup.Componenti[0].Top/WA002_EM2PIXEL]),',','.',[rfReplaceall]) +'em; left: '+  Stringreplace(format('%5.1f',[ComponentiGroup.Componenti[0].Left/WA002_EM2PIXEL]),',','.',[rfReplaceall]) +'em; '+
          'display: inline; float: left; ">' + #13#10;

  for i:=0 to Length(ComponentiGroup.Componenti)-1 do
    if ComponentiGroup.Componenti[i] <> nil then
      Result:=Result + '{%'+ComponentiGroup.Componenti[i].Name+'%}';
  Result:=Result+'</div>';
end;

function TWA002FAnagrafeDettFM.DivGroupBox( ComponentiGroup: GruppoComponenti): String;
begin
  Result:='<div class="groupbox" style="position:absolute;top: ' +  Stringreplace(format('%5.1f',[ComponentiGroup.EtichettaComponente.Top/WA002_EM2PIXEL]),',','.',[rfReplaceall]) +'em; left: '+  Stringreplace(format('%5.1f',[ComponentiGroup.EtichettaComponente.Left/WA002_EM2PIXEL]),',','.',[rfReplaceall]) +'em;">'+ #13#10+
          ' <fieldset> ' + #13#10 +
             '<legend>{%'+ComponentiGroup.EtichettaComponente.Name+'%}</legend>' + #13#10 +
	           '<span>{%'+ComponentiGroup.Componenti[0].Name+'%}</span>' + #13#10 +
          ' </fieldset> ' + #13#10+
          '</div>'+ #13#10;
end;

procedure TWA002FAnagrafeDettFM.edtAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  if Sender is TmeIWDBEdit then
    EseguiRelazioni((Sender as TmeIWDBEdit).DataField)
  else if Sender is TmeIWDBCheckBox then
    EseguiRelazioni((Sender as TmeIWDBCheckBox).DataField);
end;

procedure TWA002FAnagrafeDettFM.evtAggiornaComuneNas;
begin
  EseguiRelazioni('COMUNENAS');
  EseguiRelazioni('CAPNAS');
end;

procedure TWA002FAnagrafeDettFM.evtAggiornaComuneRes;
begin
  EseguiRelazioni('COMUNE');
  EseguiRelazioni('CAP');
end;

procedure TWA002FAnagrafeDettFM.evtAggiornaComuneDom;
begin
  EseguiRelazioni('COMUNE_DOM_BASE');
  EseguiRelazioni('CAP_DOM_BASE');
end;

procedure TWA002FAnagrafeDettFM.evtAggiornaComuneLav;
begin
  EseguiRelazioni('COD_LOCALITA_DIST_LAVORO');
end;

procedure TWA002FAnagrafeDettFM.EseguiRelazioni(sNomeCampo:String);
var
  idx: Integer;
  queryLookup: TOracleDataSet;
  SqlRelazione,SqlOriginale,CatenaRelazioni: String;
begin
  if not(TWA002FAnagrafeDM(WR302DM).selTabella.State in [dsEdit,dsInsert]) then exit;

  if sNomeCampo <> '' then
  begin
    with TWA002FAnagrafeDM(WR302DM).A002FAnagrafeMW.GetCatena do
    begin
      if VarToStr(GetVariable('sColonna')) <> sNomeCampo then
      begin
        SetVariable('sColonna',sNomeCampo);
        SetVariable('sChain','');
        Execute;
      end;
      CatenaRelazioni:=VarToStr(GetVariable('sChain'));
      CatenaRelazioni:=StringReplace(CatenaRelazioni,'''' + sNomeCampo + ''',','',[rfReplaceAll]);//tolgo sè stesso
      CatenaRelazioni:=StringReplace(Copy(CatenaRelazioni,1,Length(CatenaRelazioni) - 1),'''','',[rfReplaceAll]);//tolgo la virgola in fondo e gli apici
    end;
  end;

  with TWA002FAnagrafeDM(WR302DM).A002FAnagrafeMW do
  begin
    //Scorrimento su selI030 ordinato per ORDINE
    selI030.First;
    while not selI030.Eof do
    begin
      //eseguo le relazioni solo se la procedura è richiamata a causa della variazione della data fine decorrenza o di un dato pilota in una catena di relazioni o se è volutamente richiamata per tutti
      if (sNomeCampo = '') or (sNomeCampo = 'DATAFINE') or R180InConcat(selI030.FieldByName('COLONNA').AsString,CatenaRelazioni) then
      begin
        if selI030.FieldByName('TIPO').AsString = 'F' then
        begin
          idx:=IndiceComponente(selI030.FieldByName('COLONNA').AsString);
          if idx >= 0 then
          begin
            queryLookup:=TWA002FAnagrafeDM(WR302DM).GetQueryLookUp(idx,ComponentiLayout[idx].NomeCampo);
            if queryLookup <> nil then
            begin
              SqlRelazione:=CreaSQLRelazione((queryLookUp.VariableIndex('DATA') >= 0));
              if Trim(SqlRelazione) <> '' then
              begin
                with queryLookup do
                  if Trim(SqlRelazione) <> Trim(Sql.Text) then
                  begin
                    Close;
                    SqlOriginale:=Sql.Text;
                    Sql.Text:=SqlRelazione;
                    try
                      if VariableIndex('DATA') >= 0 then
                        SetVariable('DATA',TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName('DATAFINE').AsDateTime);
                      Open;
                      CaricaCombo((ComponentiLayout[idx].Componenti[0] as TMedpIWMultiColumnComboBox),queryLookup);
                    except
                      Sql.Text:=SqlOriginale;
                      Open;
                    end;
                  end;
              end;
            end;
          end;
        end
        else if ((selI030.FieldByName('TIPO').AsString = 'S') or ((selI030.FieldByName('TIPO').AsString = 'L') and (sNomeCampo <> ''))) and
                (selI030.FieldByName('TABELLA').AsString = selI030.FieldByName('TAB_ORIGINE').AsString) then
        begin
          if ImpostaValoreRelazione then
          begin
            idx:=IndiceComponente(selI030.FieldByName('COLONNA').AsString);
            if idx >= 0 then
            begin
              if (ComponentiLayout[idx].Componenti[0] is TMedpIWMultiColumnComboBox) then
              begin
                //impostare anche ItemIndex altrimenti non si aggiorna Combo
    //            TMedpIWMultiColumnComboBox(ComponentiLayout[idx].Componenti[0]).ItemIndex:=-1;
                (ComponentiLayout[idx].Componenti[0] as TMedpIWMultiColumnComboBox).Text:=TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName(ComponentiLayout[idx].NomeCampo).AsString;

                queryLookup:=TWA002FAnagrafeDM(WR302DM).GetQueryLookUp(idx,ComponentiLayout[idx].NomeCampo);
                ImpostaEtichettaDescrizione(TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName(ComponentiLayout[idx].nomeCampo).AsString,queryLookup,TIWLabel(ComponentiLayout[idx].Componenti[1]));
              end
              else if (ComponentiLayout[idx].Componenti[0] is TmeIWEdit) then
                TmeIWEdit(ComponentiLayout[idx].Componenti[0]).Text:=TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName(ComponentiLayout[idx].NomeCampo).AsString;
            end;
          end;
        end;
      end;
      selI030.Next;
    end;
  end;
end;

procedure TWA002FAnagrafeDettFM.TemplateDinamicoBeforeProcess(
  var VTemplate: TStream);
var
  strListTemp : TStringList;
  strDatiLiberi : string;
  i : Integer;
begin
  strListTemp:=TStringList.Create();
  strListTemp.LoadFromStream(VTemplate);
  //MANIPOLAZIONE TEMPLATE
  for i:=0 to Length(ComponentiLayout)-1 do
    //testo Componente[0].Parent perchè esiste sempre
    if ComponentiLayout[i].Componenti[0].Parent = grdTabDetail.ActiveTab then
      if ComponentiLayout[i].Componenti[0] is TmeIWDBRadioGroup then
      begin
        //Nel caso di groupbox se componenti non accessibili (ACCESSO = N) non deve disegnare nemmeno il bordo
        if ComponentiLayout[i].EtichettaComponente.Visible then
          StrDatiLiberi:=StrDatiLiberi + DivGroupBox(ComponentiLayout[i])+ #13#10
      end
      else
        StrDatiLiberi:=StrDatiLiberi + DivElementi(ComponentiLayout[i])+ #13#10;

  strListTemp.Text:=StringReplace(strListTemp.Text, '{%COMPONENTIDINAMICI%}', StrDatiLiberi, [rfReplaceAll]);

  //SALVATAGGIO SU STREAM VTemplate
  FreeAndNil(VTemplate);//.Free;
  VTemplate:=TStringStream.Create;
  strListTemp.SaveToStream(VTemplate);
  FreeAndNil(strListTemp);
  TStringStream(VTemplate).Seek(0, soFromBeginning);
end;

procedure TWA002FAnagrafeDettFM.CambioDataDecorrenza;
begin
  //cambio della data di decorrenza. ricarico le combobox
  TWA002FAnagrafeDM(WR302DM).AggiornaDatasetStorici(TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName('DATADECORRENZA').AsDateTime);
  CaricaTutteCombo(True);
end;

function TWA002FAnagrafeDettFM.CampoAccessoRelazioni(i: Integer): String;
begin
  Result:=ComponentiLayout[i].NomeCampo;
  if ComponentiLayout[i].isT430 then
  begin
    if UpperCase(Result) = 'EDBADGE' then
      Result:='BADGE'
    //Cambio il tipo dato nel caso di descrizione del comune di residenza
    else if UpperCase(Result) = 'D_COMUNE' then
      Result:='COMUNE'
    else if UpperCase(Result) = 'D_COD_LOCALITA_DIST_LAVORO' then
      Result:='COD_LOCALITA_DIST_LAVORO';
  end;
end;

function TWA002FAnagrafeDettFM.CampoRelazione(i: Integer): Boolean;
begin
  Result:=False;
  if TWA002FAnagrafeDM(WR302DM).A002FAnagrafeMW.selI030.SearchRecord('COLONNA;TIPO',VarArrayOf([ComponentiLayout[i].NomeCampo,'S']),[srFromBeginning]) then
    Result:=True;
end;

function TWA002FAnagrafeDettFM.CampoNonStoricizzabile(i: Integer): Boolean;
begin
  Result:=False;
  if TWA002FAnagrafeDM(WR302DM).A002FAnagrafeMW.selI500.Lookup('NOMECAMPO',ComponentiLayout[i].NomeCampo,'STORICIZZABILE') = 'N' then
    Result:=True;
end;

procedure TWA002FAnagrafeDettFM.CaricaCombo(Combo: TMedpIWMultiColumnComboBox; Query: TOracleDataSet);
begin
  //Query.Close;
  Query.Open;
  Query.First;
  Combo.Items.Clear;
  while not Query.Eof do
  begin
    Combo.AddRow(query.FieldByName('CODICE').AsString + ';' + query.FieldByName('DESCRIZIONE').AsString);
    Query.Next;
  end;
  //Query.Close;
  Combo.ItemIndex:=-1;
end;

procedure TWA002FAnagrafeDettFM.CaricaMultiColumnCombobox;
begin
  //CARATTO 30/09/2013 le combo vengono caricate solo quando si va in modifica
  //per ottimizzare la quantità di dati trasferiti
  //Devo anche aggiornare i dataset storici impostando la data decorrenza del record corrente
  TWA002FAnagrafeDM(WR302DM).AggiornaDatasetStorici(TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName('DATADECORRENZA').AsDateTime);

  CaricaTutteCombo(False);
end;

procedure TWA002FAnagrafeDettFM.cmbAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var Campo : String;
    idx : Integer;
begin
  //change su multicolumncombo di dati liberi (tag impostato con indice)
  with TWA002FAnagrafeDM(WR302DM) do
  begin
    idx:=(Sender as TMedpIWMultiColumnComboBox).Tag;
    Campo:=ComponentiLayout[idx].nomeCampo;
    selTabella.FieldByName(Campo).AsString:=(Sender as TMedpIWMultiColumnComboBox).Text;

    ImpostaEtichettaDescrizione((Sender as TMedpIWMultiColumnComboBox).Text,GetQueryLookUp(idx,ComponentiLayout[idx].NomeCampo),TIWLabel(ComponentiLayout[idx].Componenti[1]));
    EseguiRelazioni(Campo);
  end;
end;

procedure TWA002FAnagrafeDettFM.CaricaTutteCombo(SoloStoriche: Boolean );
var
  i: Integer;
  queryLookup : TOracleDataSet;
  count: Integer;
begin
  for i:=0 to Length(ComponentiLayout) - 1  do
    if (ComponentiLayout[i].Componenti[0] is TMedpIWMultiColumnComboBox) then
    begin
      //i dati liberi hanno un corrispettivo array sul DataModulo in quanto creati a runtime.
      //Per i componenti fissi non esiste corrispondenza e viene decodificato da codice
      queryLookup:= TWA002FAnagrafeDM(WR302DM).GetQueryLookup(i,ComponentiLayout[i].NomeCampo);

      if (queryLookup.VariableIndex('DATA') < 0) and (SoloStoriche)then
        //se solo storiche non carico le combo non storiche
      else
        CaricaCombo((ComponentiLayout[i].Componenti[0] as TMedpIWMultiColumnComboBox),queryLookup);
    end;
end;

procedure TWA002FAnagrafeDettFM.SvuotaTutteCombo;
var
  i: Integer;
begin
  for i:=0 to Length(ComponentiLayout) - 1  do
    if (ComponentiLayout[i].Componenti[0] is TMedpIWMultiColumnComboBox) then
        (ComponentiLayout[i].Componenti[0] as TMedpIWMultiColumnComboBox).Items.Clear;
end;

procedure TWA002FAnagrafeDettFM.Componenti2Dataset;
begin
  inherited;
  //Le multicolumn combobox impostano già il campo su selTabella sull'evento asyncChange
end;

//imposta classe css in base alla dimensione del campo
function TWA002FAnagrafeDettFM.CssDaDimensione(Dimensione: Double): String;
begin
  case Round(Dimensione)  of
    1: Result:='input1';
    2: Result:='input2';
    3: Result:='input3';
    4..5: Result:='input5';
    6..10: Result:='input10';
    11..15: Result:='input15';
    16..20: Result:='input20';
    21..30: Result:='input30';
    31..35: Result:='input35';
    else
      Result:='input40';
  end;
end;

procedure TWA002FAnagrafeDettFM.dedtBadgeAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if dedtBadge.Text <> '' then
    TWA002FAnagrafeDM(WR302DM).ImpostaBadgeLibero(StrToIntDef(dedtBadge.Text,0)+1);
end;

procedure TWA002FAnagrafeDettFM.dedtCapNascitaAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
var
  CodiceComune, NuovoCap: String;
begin
  with (WR302DM as TWA002FAnagrafeDM) do
  begin
    if selT030.State in [dsInsert,dsEdit] then
    begin
      if Sender = dedtCapNascita then
        CodiceComune:=selT030.FieldByName('COMUNENAS').AsString
      else if Sender = dedtCapResidenza then
        CodiceComune:=selTabella.FieldByName('COMUNE').AsString
      else if Sender = dedtCapDomBase then
        CodiceComune:=selTabella.FieldByName('COMUNE_DOM_BASE').AsString
      else
        Exit; // evento richiamato da oggetto non valido

      if CodiceComune <> '' then
      begin
        // estrae il cap in base al codice comune
        //selT480.Close;
        R180SetVariable(selT480,'CODICE',CodiceComune);
        selT480.Open;
        selT480.First;
        if selT480.RecordCount = 0 then
          Exit;

        NuovoCap:=selT480.FieldByName('CAP').AsString;
        if Sender = dedtCapNascita then
          selT030.FieldByName('CAPNAS').AsString:=NuovoCap
        else if Sender = dedtCapResidenza then
          selTabella.FieldByName('CAP').AsString:=NuovoCap
        else if Sender = dedtCapDomBase then
          selTabella.FieldByName('CAP_DOM_BASE').AsString:=NuovoCap;
      end;
    end;
  end;
end;

procedure TWA002FAnagrafeDettFM.dedtCodiceFiscaleAsyncDoubleClick(
  Sender: TObject; EventParams: TStringList);
var
  CodiceComune,CodCatastale : String;
begin
  if dedtCodiceFiscale.Text <> '' then exit;
  
  with TWA002FAnagrafeDM(WR302DM) do
  begin
    CodiceComune:=selT030.FieldByName('COMUNENAS').AsString;
    if CodiceComune <> '' then
    begin
      //selT480.Close;
      R180SetVariable(selT480,'CODICE',CodiceComune);
      selT480.Open;
      selT480.First;
      CodCatastale:=selT480.FieldByName('CODCATASTALE').AsString;
    end;

   selT030.FieldByName('CODFISCALE').AsString:=R180CalcoloCodiceFiscale(selT030.FieldByName('COGNOME').AsString,
                                                                        selT030.FieldByName('NOME').AsString,
                                                                        selT030.FieldByName('SESSO').AsString,
                                                                        CodCatastale,
                                                                        selT030.FieldByName('DATANAS').AsDateTime);
  end;
end;

procedure TWA002FAnagrafeDettFM.dedtMatricolaAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
begin
  if dedtMatricola.Text = '' then
    TWA002FAnagrafeDM(WR302DM).NuovaMatricola;
end;

function TWA002FAnagrafeDettFM.getComponentePagina(NomePagina: String): TIWRegion;
var
  i: Integer;
begin
  for i:=0 to Length(Pagine) - 1 do
  begin
    if UpperCase(Pagine[i].Caption) = UpperCase(nomePagina) then
    begin
      Result:=Pagine[i].Componente;
      exit;
    end;
  end;
  Result:=nil;
end;

function TWA002FAnagrafeDettFM.GetIdPagina(NomePagina: String): Integer;
var
  i: Integer;
begin
  for i:=0 to Length(Pagine) - 1 do
  begin
    if UpperCase(Pagine[i].Caption) = UpperCase(nomePagina) then
    begin
      Result:=i;
      exit;
    end;
  end;
  Result:=-1;
end;

//imposta menu contestuale sui componenti
procedure TWA002FAnagrafeDettFM.ImpostaContextMenu(Componente: TControl;
  Val: TPopupMenu);
begin
  if Componente is TmeIWDBEdit then
    TmeIWDBEdit(Componente).medpContextMenu:=val
  else if Componente is TmeIWEdit then
    TmeIWEdit(Componente).medpContextMenu:=val
  else if Componente is TmeIWDBRadioGroup then
    TmeIWDBRadioGroup(Componente).medpContextMenu:=val
  else if Componente is TMedpIWMultiColumnComboBox then
    (Componente as TMedpIWMultiColumnComboBox).medpContextMenu:=val
  else if Componente is TmeIWDBCheckBox then
    TmeIWDBCheckBox(Componente).medpContextMenu:=val
  else
   raise Exception.Create('Tipo componente non censito in ImpostaContextMenu ' + Componente.Name);
end;

procedure TWA002FAnagrafeDettFM.ImpostaContextMenuComponenti;
var
  i: Integer;
  Campo: String;
  Tag_pmLst:String;

  procedure ImpostaTag_pmLst(Componente: TControl; val:String);
  begin
    if Componente is TmeIWDBEdit then
      TmeIWDBEdit(Componente).ExtraTagParams.Add('pmLst=' + val)
    else if Componente is TmeIWEdit then
      TmeIWEdit(Componente).ExtraTagParams.Add('pmLst=' + val)
    else if Componente is TmeIWDBRadioGroup then
      TmeIWDBRadioGroup(Componente).ExtraTagParams.Add('pmLst=' + val)
    else if Componente is TMedpIWMultiColumnComboBox then
      (Componente as TMedpIWMultiColumnComboBox).ExtraTagParams.Add('pmLst=' + val)
    else if Componente is TmeIWDBCheckBox then
      TmeIWDBCheckBox(Componente).ExtraTagParams.Add('pmLst=' + val)
    else
     raise Exception.Create('Tipo componente non censito in ImpostaContextMenu ' + Componente.Name);
  end;

begin
  (WR302DM as TWA002FAnagrafeDM).QI010.Open;
  for i:=0 to Length(ComponentiLayout) - 1 do
  begin
    ImpostaContextMenu(ComponentiLayout[i].Componenti[0],pmnAzioniDatiAnagrafici);
    Tag_pmLst:=mnuStoriaDato.Name + ';' + mnuSeparator.Name + ';' + mnuRiepilogorapportidilavoro.Name + ';' + mnuRelazioni.Name + ';' + mnuProvvedimento.Name;
    if not ComponentiLayout[i].isT430 then
    begin
      // campo non appartenente a T430 -> context menu base
      Tag_pmLst:=mnuStoriaDato.name + ';' + mnuSeparator.Name + ';' + mnuRiepilogorapportidilavoro.Name + ';' + mnuRelazioni.Name + ';' + mnuProvvedimento.Name;
    end
    else
    begin
      // campo di T430 -> context menu con elemento "Storia del dato"
      Campo:=CampoAccessoRelazioni(i);
      if VarToStr((WR302DM as TWA002FAnagrafeDM).A002FAnagrafeMW.selI030.Lookup('COLONNA',Campo,'COLONNA')) = Campo then
      begin
        // context menu con elemento "Relazioni"
        if R180In(Parametri.Applicazione,['RILPRE','STAGIU']) and (WR302DM as TWA002FAnagrafeDM).QI010.SearchRecord('NOME_CAMPO;PROVVEDIMENTO',VarArrayOf(['T430' + ComponentiLayout[i].NomeCampo,'S']),[srFromBeginning]) then
        begin
          // context menu con elemento "Provvedimento"
          Tag_pmLst:=mnuRiepilogorapportidilavoro.Name;
        end
        else
          // context menu senza elemento "Provvedimento"
          Tag_pmLst:=mnuRiepilogorapportidilavoro.Name + ';' + mnuProvvedimento.Name;
      end
      else
      begin
        // context menu senza elemento "Relazioni"
        if R180In(Parametri.Applicazione,['RILPRE','STAGIU']) and (WR302DM as TWA002FAnagrafeDM).QI010.SearchRecord('NOME_CAMPO;PROVVEDIMENTO',VarArrayOf(['T430' + ComponentiLayout[i].NomeCampo,'S']),[srFromBeginning]) then
          // context menu con elemento "Provvedimento"
          Tag_pmLst:=mnuRiepilogorapportidilavoro.Name + ';' + mnuRelazioni.Name
        else
          // context menu senza elemento "Provvedimento"
          Tag_pmLst:=mnuSeparator.Name + ';' + mnuRiepilogorapportidilavoro.Name + ';' + mnuRelazioni.Name + ';' + mnuProvvedimento.Name;
      end;
    end;
    if R180In(Parametri.Applicazione,['RILPRE','STAGIU','PAGHE']) and
       R180In(ComponentiLayout[i].NomeCampo,['INIZIO','FINE','PASSENZE']) then
    begin
      Tag_pmLst:=Tag_pmLst.Replace(mnuSeparator.Name + ';' + mnuRiepilogorapportidilavoro.Name + ';','');
      Tag_pmLst:=Tag_pmLst.Replace(mnuRiepilogorapportidilavoro.Name + ';','');
      Tag_pmLst:=Tag_pmLst.Replace(mnuRiepilogorapportidilavoro.Name,'');
    end;

    if (A000GetAbilitazioniFunzioni('Tag','161').Inibizione = 'N') and (Pos(mnuRiepilogorapportidilavoro.Name,Tag_pmLst) = 0) then
      Tag_pmLst:=Tag_pmLst + IfThen(Tag_pmLst <> '',';') + mnuRiepilogorapportidilavoro.Name;
    if (A000GetAbilitazioniFunzioni('Tag','190').Inibizione = 'N') and (Pos(mnuRelazioni.Name,Tag_pmLst) = 0) then
      Tag_pmLst:=Tag_pmLst + IfThen(Tag_pmLst <> '',';') + mnuRelazioni.Name;
    if (A000GetAbilitazioniFunzioni('Tag','304').Inibizione = 'N') and (Pos(mnuProvvedimento.Name,Tag_pmLst) = 0) then
      Tag_pmLst:=Tag_pmLst + IfThen(Tag_pmLst <> '',';') + mnuProvvedimento.Name;

    ImpostaTag_pmLst(ComponentiLayout[i].Componenti[0],Tag_pmLst);
  end;
end;

procedure TWA002FAnagrafeDettFM.ImpostaEnabled(Componente: TControl; Val: Boolean);
begin
  if Componente is TmeIWLabel then
    TmeIWLabel(Componente).Enabled:=val
  else if Componente is TmeIWDBEdit then
    TmeIWDBEdit(Componente).Enabled:=val
  else if Componente is TmeIWEdit then
    TmeIWEdit(Componente).Enabled:=val
  else if Componente is TmeIWDBRadioGroup then
    TmeIWDBRadioGroup(Componente).Enabled:=val
  else if Componente is TMedpIWMultiColumnComboBox then
    (Componente as TMedpIWMultiColumnComboBox).Enabled:=val
  else if Componente is TmeIWDBCheckBox then
    TmeIWDBCheckBox(Componente).Enabled:=val
  else if Componente is TmeIWButton then
    TmeIWButton(Componente).Enabled:=val
  else if Componente is TmeIWLink then
    TmeIWLink(Componente).Enabled:=val
  else
   raise Exception.Create('Tipo componente non censito in ImpostaEnabled ' + Componente.Name);
end;

procedure TWA002FAnagrafeDettFM.ImpostaEtichettaDescrizione(Codice: String; Query: TOracleDataset; Lbl: TIWLabel);
begin
  Query.Open;
  Lbl.Caption:=VarToStr(Query.LookUp('CODICE', Codice, 'DESCRIZIONE'));
  //Query.Close;
end;

(* imposto posizione e pagina per i componenti in base al Layout scheda anagrafica *)
procedure TWA002FAnagrafeDettFM.ImpostaLayout;
var i,j : Integer;
    ComponentePagina : TIWRegion;
    GroupTop,GroupLeft : Integer;
begin
  //Caratto 10/07/2013 nascondo tutte le pagine. Diventano visibili se esiste
  //almeno un controllo visibile all'nterno di essa
  for i:=0 to grdTabDetail.TabCount - 1 do
  begin
    grdTabDetail.TabByIndex(i).Visible:=False;
  end;
  with TWA002FAnagrafeDM(WR302DM).selT033 do
  begin
    Open;
    First;
    while not Eof do
    begin
      for i:=0 to Length(ComponentiLayout)-1 do
      begin
        if ComponentiLayout[i].nomeCampo = FieldByName('CAMPODB').AsString then
        begin
          ComponentiLayout[i].NomePagina:=FieldByName('NOMEPAGINA').AsString;
          ComponentePagina:=getComponentePagina(FieldByName('NOMEPAGINA').AsString);
          //Caratto 10/07/2013 se controllo visibile, diventa visibile anche la pagina relativa
          if FieldByName('ACCESSO').AsString <> 'N' then
            grdTabDetail.Tabs[ComponentePagina].Visible:=True;
          //etichetta
          GroupTop:=Round(FieldByName('TOP').AsFloat);
          GroupLeft:=Round(FieldByName('LFT').AsFloat);
          ComponentiLayout[i].Accesso:=FieldByName('ACCESSO').AsString;
          if ComponentiLayout[i].EtichettaComponente <> nil then
          begin
            ComponentiLayout[i].EtichettaComponente.Parent:=ComponentePagina;
            ComponentiLayout[i].EtichettaComponente.Top:=GroupTop;
            ComponentiLayout[i].EtichettaComponente.Left:=GroupLeft;
            impostaVisible(ComponentiLayout[i].EtichettaComponente,FieldByName('ACCESSO').AsString <> 'N' );

            if FieldByName('CAPTION').AsString <> '' then
              if ComponentiLayout[i].EtichettaComponente is TmeIWLabel then
                TmeIWLabel(ComponentiLayout[i].EtichettaComponente).Caption:=FieldByName('CAPTION').AsString
              else
                TmeIWLink(ComponentiLayout[i].EtichettaComponente).Caption:=FieldByName('CAPTION').AsString;
            //il campo email è gestito in modo diverso.
            //La label diventa un link href se ci sono degli indirizzi email. perciò devo salvare la caption in una variabile specifica
            if UpperCase(ComponentiLayout[i].nomeCampo) = UpperCase(dedtMail.DataField) then
              if FieldByName('CAPTION').AsString <> '' then
                captionEmail:=FieldByName('CAPTION').AsString
              else
                captionEmail:='Email';
            if UpperCase(ComponentiLayout[i].nomeCampo) = UpperCase(dedtMailPersonale.DataField) then
              if FieldByName('CAPTION').AsString <> '' then
                captionEmailPersonale:=FieldByName('CAPTION').AsString
              else
                captionEmailPersonale:='Email personale';
            if ComponentiLayout[i].nomeCampo.ToUpper = dedtMailPEC.DataField.ToUpper then
              if FieldByName('CAPTION').AsString <> '' then
                captionEmailPEC:=FieldByName('CAPTION').AsString
              else
                captionEmailPEC:='EmailPEC';
          end;
          //componenti collegati (dbedit o multicolumnCOmbo + Label, ecc)
          for j:=0 to Length(ComponentiLayout[i].Componenti)-1 do
            if ComponentiLayout[i].Componenti[j] <> nil then
            begin
              ComponentiLayout[i].Componenti[j].Parent:=ComponentePagina;
              if ComponentiLayout[i].EtichettaComponente = nil then
                ComponentiLayout[i].Componenti[j].Top:=GroupTop
              else
                //1.5 em sotto l'etichetta
                ComponentiLayout[i].Componenti[j].Top:=GroupTop + Round(1.5 * WA002_EM2PIXEL);
              //Il template viene creato con float: left. Pertanto left è sginificativo solo per il
              //primo componente. gli altri sono accodati a sinistra
              ComponentiLayout[i].Componenti[j].Left:=GroupLeft;
              //per le checkbox non esiste la label ma si imposta la caption del componente
              if (ComponentiLayout[i].Componenti[j] is TmeIWDBCheckBox) and (FieldByName('CAPTION').AsString <>'') then
                TmeIWDBCheckBox(ComponentiLayout[i].Componenti[j]).Caption:=FieldByName('CAPTION').AsString;

              ImpostaVisible(ComponentiLayout[i].Componenti[j],FieldByName('ACCESSO').AsString <> 'N' );
            end;
          Break;
        end;
      end;
      Next;
    end;
    Close;
  end;
  //Caratto 10/07/2013 devo reimpostare l'activeTab per visualizzare correttamente i link e raltive region
  //Active il primo tab visibile
  for i:=0 to grdTabDetail.TabCount - 1 do
  begin
    if grdTabDetail.TabByIndex(i).Visible then
    begin
      grdTabDetail.ActiveTabIndex:=i;
      Break;
    end;
  end;

end;

(*
Devo impostare la proprieà visible castando al tipo del componente altrimenti
la proprieta non viene ereditata usandola direttamente su TControl
*)
procedure TWA002FAnagrafeDettFM.ImpostaVisible(Componente: TControl; Val: Boolean);
begin
  if Componente is TmeIWLabel then
    TmeIWLabel(Componente).Visible:=val
  else if Componente is TmeIWDBEdit then
    TmeIWDBEdit(Componente).Visible:=val
  else if Componente is TmeIWEdit then
    TmeIWEdit(Componente).Visible:=val
  else if Componente is TmeIWDBRadioGroup then
    TmeIWDBRadioGroup(Componente).Visible:=val
  else if Componente is TMedpIWMultiColumnComboBox then
    (Componente as TMedpIWMultiColumnComboBox).Visible:=val
  else if Componente is TmeIWDBCheckBox then
    TmeIWDBCheckBox(Componente).Visible:=val
  else if Componente is TmeIWButton then
    TmeIWButton(Componente).Visible:=val
  else if Componente is TmeIWLink then
    TmeIWLink(Componente).Visible:=val
  else
   raise Exception.Create('Tipo componente non censito in ImpostaVisible ' + Componente.Name);
end;

function TWA002FAnagrafeDettFM.IndiceComponente(Campo: String): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Length(ComponentiLayout) - 1 do
    if ComponentiLayout[i].NomeCampo = Campo then
    begin
      Result:=i;
      Break;
    end;
end;

function TWA002FAnagrafeDettFM.IndiceComponenteByNomeComp(
  NomeComponente: String): Integer;
var
  i,j: Integer;
begin
  Result:=-1;
  for i:=0 to Length(ComponentiLayout) - 1 do
  begin
    for j:=0 to Length(ComponentiLayout[i].Componenti) - 1 do
    begin
      if ComponentiLayout[i].Componenti[j] <> nil then
        if UpperCase(ComponentiLayout[i].Componenti[j].Name) = UpperCase(NomeComponente)  then
        begin
          Result:=i;
          Break;
        end;
    end;
    if Result > -1 then
      Break;
  end;
end;

procedure TWA002FAnagrafeDettFM.ResultAssenzeAbilitate(Sender: TObject;
  Result: Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtAssenzeAbilitate.DataField).AsString:=C190GetCheckList(5, WC013.ckList);
end;

procedure TWA002FAnagrafeDettFM.AbilitaComponenti;
var
  i,j:Integer;
  Disabilitato:Boolean;
begin
  inherited;
  //in automatico vengono abilitati tutti i campi quando edit o insert
  //devo inibire l'abilitazione per i campi con accesso sola lettura
  if TWA002FAnagrafeDM(WR302DM).selTabella.State in [dsEdit,dsInsert] then
    for i:=0 to Length(ComponentiLayout) - 1 do
    begin
      Disabilitato:=(ComponentiLayout[i].Accesso = 'R') or (CampoRelazione(i)) or (TWA002FAnagrafe(Self.Owner).InterfacciaWR102.StoricizzazioneInCorso and CampoNonStoricizzabile(i));
      for j:=0 to Length(ComponentiLayout[i].Componenti) - 1 do
        if ComponentiLayout[i].Componenti[j] <> nil then
          impostaEnabled(ComponentiLayout[i].Componenti[j],not Disabilitato);
    end
  else
    SvuotaTutteCombo;

  edtProvNascita.ReadOnly:=True;
  edtProvResidenza.ReadOnly:=True;
  //edtProvDomicilio.ReadOnly:=True;
end;

procedure TWA002FAnagrafeDettFM.btnAssenzeAbilitateClick(Sender: TObject);
var ListaAssenze : TStringList;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.BeginUpdate;
    ckList.Items.Clear;
    ListaAssenze:= TWA002FAnagrafeDM(WR302DM).ListaAssenze;
    ckList.Items.AddStrings(ListaAssenze);
    ckList.Items.EndUpdate;
    ListaAssenze.Free;
    C190PutCheckList(dedtAssenzeAbilitate.Text,5,ckList);
    ResultEvent:=ResultAssenzeAbilitate;
    Visualizza;
  end;
end;

procedure TWA002FAnagrafeDettFM.btnPresenzeAbilitateClick(Sender: TObject);
var
  ListaPresenze: TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.BeginUpdate;
    ckList.Items.Clear;
    ListaPresenze:= TWA002FAnagrafeDM(WR302DM).ListaPresenze;
    ckList.Items.AddStrings(ListaPresenze);
    ckList.Items.EndUpdate;
    ListaPresenze.Free;
    C190PutCheckList(dedtPresenzeAbilitate.Text,5,ckList);
    ResultEvent:=ResultPresenzeAbilitate;
    Visualizza;
  end;
end;

procedure TWA002FAnagrafeDettFM.RelazioniClick(Sender: TObject);
var Dato: String;
  Params: String;
begin
  inherited;
  try
    Dato:=pmnAzioniDatiAnagrafici.PopupComponent.Name;
    Params:='TABELLA=T430_STORICO'+ ParamDelimiter +
            'COLONNA='+  CampoAccessoRelazioni(IndiceComponenteByNomeComp(Dato)) + ParamDelimiter +
            'DATA='+ DateToStr(WR302DM.selTabella.FieldByName('DATADECORRENZA').AsDateTime);
    TWR100FBase(Self.Parent).AccediForm(190,Params);
  finally
    // Reimposto a nil i PopupComponent dei menù contestuali che puntano a questo metodo
    pmnAzioniDatiAnagrafici.PopupComponent:=nil;
  end;
end;

procedure TWA002FAnagrafeDettFM.ProvvedimentoClick(Sender: TObject);
var Dato: String;
begin
  inherited;
  try
    Dato:=ComponentiLayout[pmnAzioniDatiAnagrafici.PopupComponent.Tag].NomeCampo;
    TWR100FBase(Self.Parent).AccediForm(304,'CAMPO=' + Dato +
      ParamDelimiter + 'PROGRESSIVO=' +  TWA002FAnagrafeDM(WR302DM).selTabella.FieldByName('PROGRESSIVO').AsString);
  finally
    // Reimposto a nil i PopupComponent dei menù contestuali che puntano a questo metodo
    pmnAzioniDatiAnagrafici.PopupComponent:=nil;
  end;

end;

procedure TWA002FAnagrafeDettFM.ReleaseOggetti;
var
  i: Integer;
  j: Integer;
begin
  FreeAndNil(IntfWebT480Nas);
  FreeAndNil(IntfWebT480Res);
  FreeAndNil(IntfWebT480Dom);
  FreeAndNil(IntfWebT480Lav);
  for i:=0 to NDatiLiberi - 1 do
  begin
    if ComponentiLayout[i].EtichettaComponente <> nil then
      FreeAndNil(ComponentiLayout[i].EtichettaComponente);

    for j:=0 to Length(ComponentiLayout[i].Componenti) - 1 do
      if ComponentiLayout[i].Componenti[j] <> nil then
        FreeAndNil(ComponentiLayout[i].Componenti[j]);
  end;
(*
  SetLength(ComponentiLayout,0);

  for i:=0 to Length(Pagine) - 1 do
    FreeAndNil(Pagine[i].Componente);

  SetLength(Pagine,0);
  *)
  inherited;
end;

procedure TWA002FAnagrafeDettFM.OnLinkClick(Sender: TObject);
var
  Cod, Params: String;
  idx: Integer;
begin
    idx:=TmeIWLink(Sender).Tag;
    //decodifica Campo
    Cod:=(ComponentiLayout[idx].Componenti[0] as TMedpIWMultiColumnComboBox).Text;
    Params:='CODICE=' + Cod;
    if idx < nDatiLiberi then
    begin
      //FormDati Liberi
      Params:=Params + '|' + 'NOMECAMPO='+ComponentiLayout[idx].nomeCampo;
      TWR100FBase(Self.Owner).AccediForm(114,Params);
    end
    else
    begin
      if ComponentiLayout[idx].NomeCampo = 'TIPORAPPORTO' then
        TWR100FBase(Self.Owner).AccediForm(143,Params)
      else if ComponentiLayout[idx].NomeCampo = 'SQUADRA' then
        TWR100FBase(Self.Owner).AccediForm(128,Params)
      else if ComponentiLayout[idx].NomeCampo = 'CONTRATTO' then
        TWR100FBase(Self.Owner).AccediForm(111,Params)
      else if ComponentiLayout[idx].NomeCampo = 'PLUSORA' then
        TWR100FBase(Self.Owner).AccediForm(102,Params)
      else if ComponentiLayout[idx].NomeCampo = 'IPRESENZA' then
        TWR100FBase(Self.Owner).AccediForm(112,Params)
      else if ComponentiLayout[idx].NomeCampo = 'PARTTIME' then
        TWR100FBase(Self.Owner).AccediForm(144,Params)
      else if ComponentiLayout[idx].NomeCampo = 'CALENDARIO' then
        TWR100FBase(Self.Owner).AccediForm(101,Params)
      else if ComponentiLayout[idx].NomeCampo = 'PORARIO' then
        TWR100FBase(Self.Owner).AccediForm(113,Params)
      else if ComponentiLayout[idx].NomeCampo = 'PERSELASTICO' then
        TWR100FBase(Self.Owner).AccediForm(142,Params)
      else if ComponentiLayout[idx].NomeCampo = 'PASSENZE' then
        TWR100FBase(Self.Owner).AccediForm(104,Params)
      else if ComponentiLayout[idx].NomeCampo = 'QUALIFICAMINIST' then
        TWR100FBase(Self.Owner).AccediForm(191,Params)
      else if ComponentiLayout[idx].NomeCampo = 'MEDICINA_LEGALE' then
        TWR100FBase(Self.Owner).AccediForm(64,Params)
      (*
      else if ComponentiLayout[idx].NomeCampo = 'AZIENDA_BASE' then
        TWR100FBase(Self.Owner).AccediForm(-0,Params)
      *);
    end;
end;

procedure TWA002FAnagrafeDettFM.ResultPresenzeAbilitate(Sender: TObject;
  Result: Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtPresenzeAbilitate.DataField).AsString:=C190GetCheckList(5, WC013.ckList);
end;

procedure TWA002FAnagrafeDettFM.SpostaStoricoResultEvent(Sender: TObject; ResultDec,ResultFine: TDateTime);
begin
  TWA002FAnagrafe(Self.Owner).SpostaStorico(ResultDec);
end;

procedure TWA002FAnagrafeDettFM.StoriaClick(Sender: TObject);
var
  lastDato,Dato: String;
  Tutto: Boolean;
  i: Integer;
  WC006FStoriaDipFM: TWC006FStoriaDipFM;
  C006FStoriaDati: TC006FStoriaDati;
  rigaColorata: Boolean;
begin
  inherited;

  C006FStoriaDati:=TC006FStoriaDati.Create(nil);
  if pmnAzioniDatiAnagrafici.PopupComponent <> nil then
    Dato:=ComponentiLayout[pmnAzioniDatiAnagrafici.PopupComponent.Tag].NomeCampo
  else
    Dato:='';

  try
    with TWA002FAnaGrafeDM(WR302DM) do
    begin
      Tutto:=False;
      if Sender = mnuStoriaDipendente then
      begin
        C006FStoriaDati.GetStoriaDato(selTabella.FieldByName('PROGRESSIVO').AsInteger,'*');
        Tutto:=True;
      end
      else if Sender = mnuStoricizCorr then
        C006FStoriaDati.GetStoriaDato(selTabella.FieldByName('PROGRESSIVO').AsInteger,'*',selTabella.FieldByName('DATADECORRENZA').AsDateTime)
      else
        C006FStoriaDati.GetStoriaDato(selTabella.FieldByName('PROGRESSIVO').AsInteger,Dato);

      cdsStoriaDato.EmptyDataSet;
      rigaColorata:=False;
      lastDato:='';
      for i:=0 to C006FStoriaDati.StoriaDipendente.Count - 1 do
        if A002FAnagrafeMW.selT033_campoDecode.SearchRecord('CAMPODB',RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo,[srFromBeginning]) or (not Tutto) then
          //Dalla visualizzazione di tutti gli storici escludo data decorrenza e datafine
          if (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DATADECORRENZA') and
            (RecStoria(C006FStoriaDati.StoriaDipendente[i]).NomeCampo <> 'DATAFINE') then
          begin
            cdsStoriaDato.Append;
            cdsStoriaDato.FieldByName('KEY').AsString:=IntToStr(cdsStoriaDato.RecordCount);
            cdsStoriaDato.FieldByName('DATO').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).TipoDato;
            cdsStoriaDato.FieldByName('DATADEC').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec;
            //Se la data fine = 31/12/3999 scrivo 'Corrente'
            if RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine = '31/12/3999' then
              cdsStoriaDato.FieldByName('DATAFINE').AsString:='Corrente'
            else
              cdsStoriaDato.FieldByName('DATAFINE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine;

            cdsStoriaDato.FieldByName('VALORE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore;
            cdsStoriaDato.FieldByName('DESCRIZIONE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Descrizione;

            if cdsStoriaDato.FieldByName('DATO').AsString <> lastDato then
            begin
              lastDato:=cdsStoriaDato.FieldByName('DATO').AsString;
              rigaColorata:=not rigaColorata;
            end;
            cdsStoriaDato.FieldByName('RIGACOLORATA').AsBoolean:=rigaColorata;

            cdsStoriaDato.Post;
          end;
        cdsStoriaDato.First;
        WC006FStoriaDipFM:=TWC006FStoriaDipFM.Create(Self.Owner);
        WC006FStoriaDipFM.CampoColoreRiga:='RIGACOLORATA';
        if (selTabella.State = dsBrowse) then
          WC006FStoriaDipFM.Visualizza(cdsrStoriaDato,SpostaStoricoResultEvent)
        else
          WC006FStoriaDipFM.Visualizza(cdsrStoriaDato,nil);

    end;
  finally
    // Reimposto a nil i PopupComponent dei menù contestuali
    pmnAzioniDatiAnagrafici.PopupComponent:=nil;
    C006FStoriaDati.Free;
  end;
end;

procedure TWA002FAnagrafeDettFM.StoriadeldipendenteClick(Sender: TObject);
var i : integer;
begin
  inherited;
  i:=0;
end;

end.
