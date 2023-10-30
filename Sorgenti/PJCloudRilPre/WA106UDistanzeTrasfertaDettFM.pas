unit WA106UDistanzeTrasfertaDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WR205UDettTabellaFM, IWCompJQueryWidget, StrUtils,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWDBExtCtrls, IWCompLabel,
  meIWLabel, IWCompListbox, IWDBStdCtrls, meIWDBLookupComboBox, IWCompEdit,
  meIWDBEdit, IWAdvRadioGroup, meTIWAdvRadioGroup, WA106UDistanzeTrasfertaDM,
  medpIWMultiColumnComboBox, meIWEdit, IWCompButton, meIWButton,
  meIWDBRadioGroup, DB, WC015USelEditGridFM, C180FunzioniGenerali,
  IWHTMLControls, meIWLink,WR100UBase, UIntfWebT480, C190FunzioniGeneraliWeb,
  meIWGrid, medpIWDBGrid;

type
  TWA106FDistanzeTrasfertaDettFM = class(TWR205FDettTabellaFM)
    lblLocalitaPartenza: TmeIWLabel;
    dedtCodiceLocalita1: TmeIWDBEdit;
    lblCodice1: TmeIWLabel;
    lblCap1: TmeIWLabel;
    lblProv1: TmeIWLabel;
    edtLocalita1: TmeIWEdit;
    btnSceltaComune1: TmeIWButton;
    lblCodice2: TmeIWLabel;
    lblCap2: TmeIWLabel;
    lblProv2: TmeIWLabel;
    dedtCodiceLocalita2: TmeIWDBEdit;
    edtLocalita2: TmeIWEdit;
    btnSceltaComune2: TmeIWButton;
    rgpTipo1: TmeTIWAdvRadioGroup;
    rgpTipo2: TmeTIWAdvRadioGroup;
    edtCap1: TmeIWEdit;
    edtCap2: TmeIWEdit;
    edtProv1: TmeIWEdit;
    edtProv2: TmeIWEdit;
    cmbLocalita1: TmeIWDBLookupComboBox;
    cmbLocalita2: TmeIWDBLookupComboBox;
    lblChilometri: TmeIWLabel;
    dedtChilometri: TmeIWDBEdit;
    lnkLocalitaPartenza: TmeIWLink;
    lnkLocalitaDestinazione: TmeIWLink;
    edtCitta1: TmeIWEdit;
    edtCitta2: TmeIWEdit;
    lblCitta1: TmeIWLabel;
    lblCitta2: TmeIWLabel;
    procedure cmbLocalita1AsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure rgpTipo1Click(Sender: TObject);
    procedure cmbLocalita2AsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure rgpTipo2Click(Sender: TObject);
    procedure lnkLocalitaPartenzaClick(Sender: TObject);
    procedure lnkLocalitaDestinazioneClick(Sender: TObject);
  private
    IntfWebT480Loc1: TIntfWebT480;
    IntfWebT480Loc2: TIntfWebT480;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    IntfWebT480LocPers: TIntfWebT480;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
    WC015: TWC015FSelEditGridFM;
    procedure grdselM042PreparaComponenti(Sender: TObject);
    procedure grdselM042DataSet2Componenti(Sender: TObject;Row: Integer);
    procedure grdselM042Componenti2DataSet(Sender: TObject;Row: Integer);
    procedure VisualizzaComponenti;
    procedure ApriLocalita(Tipo, Codice: String);
    procedure ResultLocalita(Sender: TObject; Result: Boolean);
    procedure ReleaseOggetti; override;
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
  end;

implementation

{$R *.dfm}

uses WA106UDistanzeTrasferta;

{ TWA106FDistanzeTrasfertaDettFM }

procedure TWA106FDistanzeTrasfertaDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  IntfWebT480Loc1:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480Loc1 do
  begin
    Titolo:='Scelta comune di partenza';
    DataSource:=(WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.dsrSelT480;
    edtCitta:=edtLocalita1;
    dedtCodice:=dedtCodiceLocalita1;
    edtProvincia:=edtProv1;
    edtCap:=edtCap1;
    btnLookup:=btnSceltaComune1;
  end;
  IntfWebT480Loc2:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480Loc2 do
  begin
    Titolo:='Scelta comune di destinazione';
    DataSource:=(WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.dsrSelT480;
    edtCitta:=edtLocalita2;
    dedtCodice:=dedtCodiceLocalita2;
    edtProvincia:=edtProv2;
    edtCap:=edtCap2;
    btnLookup:=btnSceltaComune2;
  end;
  IntfWebT480LocPers:=TIntfWebT480.Create(Self.Parent);

  with (WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW do
  begin
    cmbLocalita1.ListSource:=dsrSelM042;
    cmbLocalita2.ListSource:=dsrSelM042;
  end;
end;

procedure TWA106FDistanzeTrasfertaDettFM.lnkLocalitaDestinazioneClick(
  Sender: TObject);
begin
  inherited;
  ApriLocalita(WR302DM.selTabella.FieldByName('TIPO2').AsString,
               WR302DM.selTabella.FieldByName('LOCALITA2').AsString);
end;

procedure TWA106FDistanzeTrasfertaDettFM.lnkLocalitaPartenzaClick(
  Sender: TObject);
begin
  ApriLocalita(WR302DM.selTabella.FieldByName('TIPO1').AsString,
               WR302DM.selTabella.FieldByName('LOCALITA1').AsString);
end;

procedure TWA106FDistanzeTrasfertaDettFM.ApriLocalita(Tipo,Codice: String);
begin
  if Tipo = 'C' then
    TWR100FBase(Self.Parent).AccediForm(530,'CODICE='+ Codice)
  else
  begin
    WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
    WC015.ResultEvent:=ResultLocalita;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    WC015.InizializzaEvent:=grdselM042PreparaComponenti;
    WC015.Componenti2DataSetEvent:=grdselM042Componenti2DataSet;
    WC015.DataSet2ComponentiEvent:=grdselM042DataSet2Componenti;
    WC015.medpSearchField:='DESCRIZIONE';
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
    //Devo passare il dataset SELM042EDIT perchè selM042è il listsource
    //delle combo e tornerebbe in browse tentanto di modificare i dati nella tabella
    (WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.selM042Edit.Open;
    WC015.Visualizza('Gestione località personalizzate',(WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.selM042Edit);
  end;
end;

procedure TWA106FDistanzeTrasfertaDettFM.ResultLocalita(Sender: TObject; Result: Boolean);
begin
  (WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelM042Edit.Close;
  (WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelM042.Refresh;
end;

procedure TWA106FDistanzeTrasfertaDettFM.DataSet2Componenti;
begin
  inherited;
  with WR302DM do
  begin
    //partenza
    if selTabella.FieldByName('TIPO1').AsString = 'C' then
    begin
      rgpTipo1.ItemIndex:=0;
      edtLocalita1.Text:=selTabella.FieldByName('DESC_PARTENZA').AsString;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      //edtCap1.Text:=selTabella.FieldByName('CAP1').AsString;
      //edtProv1.Text:=selTabella.FieldByName('PROV1').AsString;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
    end
    else
      rgpTipo1.ItemIndex:=1;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    // cap e provincia sono sempre visualizzati
    edtCap1.Text:=selTabella.FieldByName('CAP1').AsString;
    edtProv1.Text:=selTabella.FieldByName('PROV1').AsString;
    edtCitta1.Text:=selTabella.FieldByName('CITTA1').AsString;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

    //destinazione
    if selTabella.FieldByName('TIPO2').AsString = 'C' then
    begin
      rgpTipo2.ItemIndex:=0;
      edtLocalita2.Text:=selTabella.FieldByName('DESC_DESTINAZIONE').AsString;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
      //edtCap2.Text:=selTabella.FieldByName('CAP2').AsString;
      //edtProv2.Text:=selTabella.FieldByName('PROV2').AsString;
      // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
    end
    else
      rgpTipo2.ItemIndex:=1;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    edtCap2.Text:=selTabella.FieldByName('CAP2').AsString;
    edtProv2.Text:=selTabella.FieldByName('PROV2').AsString;
    edtCitta2.Text:=selTabella.FieldByName('CITTA2').AsString;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

    VisualizzaComponenti;
  end;
end;

// AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
procedure TWA106FDistanzeTrasfertaDettFM.grdselM042PreparaComponenti(Sender: TObject);
var
  IWG: TmedpIWDBGrid;
  ColComune: Integer;
begin
  IWG:=(Sender as TWC015FSelEditGridFM).grdElenco;
  IWG.medpPreparaComponentiDefault;
  ColComune:=IWG.medpIndexColonna('D_COMUNE');
  IWG.medpPreparaComponenteGenerico('WR102',ColComune,0,DBG_EDT,'10','2','null','','S');
  IWG.medpPreparaComponenteGenerico('WR102',ColComune,1,DBG_BTN,'','...','','','S');
  IWG.medpPreparaComponenteGenerico('WR102',ColComune,2,DBG_EDT,'2','','null','','S');
end;

procedure TWA106FDistanzeTrasfertaDettFM.grdselM042Componenti2DataSet(
  Sender: TObject; Row: Integer);
var
  IWG: TmedpIWDBGrid;
begin
  IWG:=(Sender as TWC015FSelEditGridFM).grdElenco;
  IWG.medpDataSet.FieldByName('COD_ISTAT').AsString:=IntfWebT480LocPers.ValoreChiave;
end;

procedure TWA106FDistanzeTrasfertaDettFM.grdselM042DataSet2Componenti(
  Sender: TObject; Row: Integer);
var
  IWG: TmedpIWDBGrid;
  CodIstat: String;
  ColComune: Integer;
begin
  IWG:=(Sender as TWC015FSelEditGridFM).grdElenco;
  ColComune:=IWG.medpIndexColonna('D_COMUNE');

  // aggancio oggetto intfwebt480
  IntfWebT480LocPers.Titolo:='Seleziona il comune della località personalizzata';
  IntfWebT480LocPers.DataSource:=(WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.dsrSelT480;
  IntfWebT480LocPers.edtCitta:=(IWG.medpCompCella(Row,ColComune,0) as TmeIWEdit);
  IntfWebT480LocPers.dedtCodice:=nil;
  IntfWebT480LocPers.dedtCap:=nil;
  IntfWebT480LocPers.edtProvincia:=(IWG.medpCompCella(Row,ColComune,2) as TmeIWEdit);
  IntfWebT480LocPers.btnLookup:=(IWG.medpCompCella(Row,ColComune,1) as TmeIWButton);

  // estrae il valore del codice comune
  CodIstat:=IWG.medpClientDataSet.FieldByName('COD_ISTAT').AsString;

  // edit descrizione comune
  IntfWebT480LocPers.edtCitta.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'CITTA'));
  IntfWebT480LocPers.edtProvincia.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'PROVINCIA'));
end;
// AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

procedure TWA106FDistanzeTrasfertaDettFM.cmbLocalita1AsyncChange(
  Sender: TObject; EventParams: TStringList);
var
  CodLocalita, CodIstat: String;
begin
  inherited;
  //L'edit punta allo stesso campo della combo ma è readOnly.
  cmbLocalita1.Invalidate;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  // estrae il valore del codice comune
  CodLocalita:=(WR302DM as TWA106FDistanzeTrasfertaDM).selTabella.FieldByName('LOCALITA1').AsString;
  CodIstat:=VarToStr(TWA106FDistanzeTrasfertaDM(WR302DM).A106FDistanzeTrasfertaMW.selM042.Lookup('CODICE',CodLocalita,'COD_ISTAT'));
  edtCap1.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'CAP'));
  edtProv1.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'PROVINCIA'));
  edtCitta1.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'CITTA'));
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
end;

procedure TWA106FDistanzeTrasfertaDettFM.cmbLocalita2AsyncChange(
  Sender: TObject; EventParams: TStringList);
var
  CodLocalita, CodIstat: String;
begin
  inherited;
  //L'edit punta allo stesso campo della combo ma è readOnly.
  cmbLocalita2.Invalidate;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  // estrae il valore del codice comune
  CodLocalita:=(WR302DM as TWA106FDistanzeTrasfertaDM).selTabella.FieldByName('LOCALITA2').AsString;
  CodIstat:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.selM042.Lookup('CODICE',CodLocalita,'COD_ISTAT'));
  edtCap2.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'CAP'));
  edtProv2.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'PROVINCIA'));
  edtCitta2.Text:=VarToStr((WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW.SelT480.Lookup('CODICE',CodIstat,'CITTA'));
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
end;

procedure TWA106FDistanzeTrasfertaDettFM.rgpTipo1Click(Sender: TObject);
begin
  inherited;
  if rgpTipo1.ItemIndex = 0 then
  begin
    WR302DM.selTabella.FieldByName('TIPO1').AsString:='C';
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    {
    //Reset Campi
    edtLocalita1.Text:='';
    edtCap1.Text:='';
    edtProv1.Text:='';
    }
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
  end
  else
  begin
    WR302DM.selTabella.FieldByName('TIPO1').AsString:='P';
  end;

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  //Reset Campi
  edtLocalita1.Text:='';
  edtCap1.Text:='';
  edtProv1.Text:='';
  edtCitta1.Text:='';
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

  //svuoto istat
  WR302DM.selTabella.FieldByName('LOCALITA1').AsString:='';
  VisualizzaComponenti;
end;

procedure TWA106FDistanzeTrasfertaDettFM.rgpTipo2Click(Sender: TObject);
begin
  inherited;
  if rgpTipo2.ItemIndex = 0 then
  begin
    WR302DM.selTabella.FieldByName('TIPO2').AsString:='C';
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    {
    //Reset Campi
    edtLocalita2.Text:='';
    edtCap2.Text:='';
    edtProv2.Text:='';
    }
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
  end
  else
    WR302DM.selTabella.FieldByName('TIPO2').AsString:='P';

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  //Reset Campi
  edtLocalita2.Text:='';
  edtCap2.Text:='';
  edtProv2.Text:='';
  edtCitta2.Text:='';
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

  //svuoto istat
  WR302DM.selTabella.FieldByName('LOCALITA2').AsString:='';

  VisualizzaComponenti;
end;

procedure TWA106FDistanzeTrasfertaDettFM.VisualizzaComponenti;
var isComune : boolean;
begin
  //Partenza
  isComune:=WR302DM.selTabella.FieldByName('TIPO1').AsString = 'C';

  cmbLocalita1.Visible:=not isComune;
  edtLocalita1.Visible:=isComune;
  btnSceltaComune1.Visible:=isComune;
  lblCodice1.Caption:=IfThen(isComune,'Codice Istat','Codice');

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  {
  lblCap1.Visible:=isComune;
  edtCap1.Visible:=isComune;
  lblProv1.Visible:=isComune;
  edtProv1.Visible:=isComune;
  }
  lblCitta1.Visible:=not isComune;
  edtCitta1.Visible:=not isComune;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

  //Destinazione
  isComune:=WR302DM.selTabella.FieldByName('TIPO2').AsString = 'C';

  cmbLocalita2.Visible:=not isComune;
  edtLocalita2.Visible:=isComune;
  btnSceltaComune2.Visible:=isComune;
  lblCodice2.Caption:=IfThen(isComune,'Codice Istat','Codice');

  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  {
  lblCap2.Visible:=isComune;
  edtCap2.Visible:=isComune;
  lblProv2.Visible:=isComune;
  edtProv2.Visible:=isComune;
  }
  lblCitta2.Visible:=not isComune;
  edtCitta2.Visible:=not isComune;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
end;

procedure TWA106FDistanzeTrasfertaDettFM.AbilitaComponenti;
var enab: boolean;
begin
  inherited;
  //Non editabili
  dedtCodiceLocalita1.ReadOnly:=True;
  edtCap1.ReadOnly:=True;
  edtProv1.ReadOnly:=True;
  dedtCodiceLocalita2.ReadOnly:=True;
  edtCap2.ReadOnly:=True;
  edtProv2.ReadOnly:=True;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  edtCitta1.ReadOnly:=True;
  edtCitta2.ReadOnly:=True;
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    //in edit si può cambiare solo il chilometraggio, in insert tutto
    //Devo disabilitare e riabilitare perchè la gestione dei campi db-Aware non imposta enabled = true/false
    enab:=WR302DM.selTabella.State = dsInsert;
    rgpTipo1.Enabled:=enab;
    edtLocalita1.Enabled:=enab;
    cmbLocalita1.Enabled:=enab;
    dedtCodiceLocalita1.Enabled:=enab;
    edtCap1.Enabled:=enab;
    edtProv1.Enabled:=enab;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    edtCitta1.Enabled:=enab;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine

    rgpTipo2.Enabled:=enab;
    edtLocalita2.Enabled:=enab;
    dedtCodiceLocalita2.Enabled:=enab;
    cmbLocalita2.Enabled:=enab;
    edtCap2.Enabled:=enab;
    edtProv2.Enabled:=enab;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
    edtCitta2.Enabled:=enab;
    // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
  end;
end;

procedure TWA106FDistanzeTrasfertaDettFM.Componenti2DataSet;
begin
  inherited;
  //i campi localita vengono settati nel change della combo e nel dbedit
  if rgpTipo1.ItemIndex = 0 then
    WR302DM.selTabella.FieldByName('TIPO1').AsString:='C'
  else
    WR302DM.selTabella.FieldByName('TIPO1').AsString:='P';

  if rgpTipo2.ItemIndex = 0 then
    WR302DM.selTabella.FieldByName('TIPO2').AsString:='C'
  else
    WR302DM.selTabella.FieldByName('TIPO2').AsString:='P';
end;

procedure TWA106FDistanzeTrasfertaDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(IntfWebT480Loc1);
  FreeAndNil(IntfWebT480Loc2);
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.ini
  FreeAndNil(IntfWebT480LocPers);
  // AOSTA_REGIONE - commessa 2014/242 SVILUPPO#2 - riesame del 20.04.2015.fine
end;

end.
