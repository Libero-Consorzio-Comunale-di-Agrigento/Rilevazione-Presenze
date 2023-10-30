unit WA207UProfiliStampeRepDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompLabel, meIWLabel, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWCompListbox, meIWDBComboBox, IWCompButton, meIWButton, meIWDBLookupComboBox, IWCompCheckbox, meIWDBCheckBox,
  WC013UCheckListFM;

type
  TWA207FProfiliStampeRepDettFM = class(TWR205FDettTabellaFM)
    dedtSize: TmeIWDBEdit;
    lblDimensione: TmeIWLabel;
    dcmbOrientamento: TmeIWDBComboBox;
    lblOrientamento: TmeIWLabel;
    lblFont: TmeIWLabel;
    dcmbFont: TmeIWDBComboBox;
    lblGLayout: TmeIWLabel;
    dgrpTipoStampa: TmeIWDBRadioGroup;
    lblTipoStampa: TmeIWLabel;
    lblGTitolo: TmeIWLabel;
    dedtTitolo: TmeIWDBEdit;
    lblTitolo: TmeIWLabel;
    lblCampoRaggr: TmeIWLabel;
    lblTitoloDimensione: TmeIWLabel;
    lblGselTurni: TmeIWLabel;
    lblGDatiPianif: TmeIWLabel;
    lblCampoConNom: TmeIWLabel;
    lblGDatiAssenza: TmeIWLabel;
    lblGDettaglioTabellone: TmeIWLabel;
    lblTurni: TmeIWLabel;
    dEdtTitoloSize: TmeIWDBEdit;
    dedtTurni: TmeIWDBEdit;
    dedtSiglaAssenza: TmeIWDBEdit;
    dchkTitoloBold: TmeIWDBCheckBox;
    dchkTitoloUnderline: TmeIWDBCheckBox;
    dchkSaltoPagina: TmeIWDBCheckBox;
    dcmbCampoRaggr: TmeIWDBLookupComboBox;
    btnScegliTurni: TmeIWButton;
    drgpSelTurni: TmeIWDBRadioGroup;
    dcmbCampoConNom: TmeIWDBLookupComboBox;
    dchkLegenda: TmeIWDBCheckBox;
    dchkIncludiNonPianif: TmeIWDBCheckBox;
    dchkDatiAggiuntivi: TmeIWDBCheckBox;
    dchkOrario: TmeIWDBCheckBox;
    dchkCodice: TmeIWDBCheckBox;
    dchkNomeCompleto: TmeIWDBCheckBox;
    dchkDatoLibero: TmeIWDBCheckBox;
    dchkOrarioInRiga: TmeIWDBCheckBox;
    dchkPriorita: TmeIWDBCheckBox;
    dchkSigla: TmeIWDBCheckBox;
    drgpDatiAssenza: TmeIWDBRadioGroup;
    dchkDatiAggInRiga: TmeIWDBCheckBox;
    dedtCodice: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dcmbCampoDett: TmeIWDBLookupComboBox;
    lblCampoDett: TmeIWLabel;
    dcmbFormatoPag: TmeIWDBComboBox;
    lblFormato: TmeIWLabel;
    dgrpCampoDettaglio: TmeIWDBRadioGroup;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnScegliTurniClick(Sender: TObject);
    procedure dgrpTipoStampaClick(Sender: TObject);
    procedure dchkCodiceAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkOrarioAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkDatoLiberoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure drgpDatiAssenzaClick(Sender: TObject);
    procedure drgpSelTurniClick(Sender: TObject);
    procedure dgrpCampoDettaglioClick(Sender: TObject);
    procedure dcmbCampoRaggrChange(Sender: TObject);
  private
    { Private declarations }
    WC013: TWC013FCheckListFM;
    procedure AbilitaSiglaAssenza;
    procedure CorreggiTitolo;
    procedure ResultSelTurni(Sender: TObject; Result:Boolean);
  public
    { Public declarations }
    procedure Abilitazioni;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  end;

implementation

uses
  WA207UProfiliStampeRepDM, IWApplication, A000UInterfaccia, Generics.Collections, OracleData, Math,
  C190FunzioniGeneraliWeb, C180FunzioniGenerali, QRPrntr, Data.DB;

{$R *.dfm}

{ TWA207FProfiliStampeRepDettFM }

procedure TWA207FProfiliStampeRepDettFM.AbilitaSiglaAssenza;
begin
  dedtSiglaAssenza.Enabled:=TWA207FProfiliStampeRepDM(WR302DM).selTabella.FieldByName('DETT_ASSENZA').AsString = 'S';
end;

procedure TWA207FProfiliStampeRepDettFM.Abilitazioni;
begin
  if WR302DM <> nil then
    if WR302DM.dsrTabella.State in [dsEdit,dsInsert] then
      dgrpCampoDettaglioClick(dgrpCampoDettaglio);
end;

procedure TWA207FProfiliStampeRepDettFM.btnScegliTurniClick(Sender: TObject);
var
  Elem: String;
  LenCod: Integer;
begin
  // apre dataset dei turni da visualizzare
  with TWA207FProfiliStampeRepDM(WR302DM).A040MW do
  begin
    RecuperaTurni(drgpSelTurni.ItemIndex);
    LenCod:=IfThen(drgpSelTurni.ItemIndex = 0,5,11);
    WC013:=TWC013FCheckListFM.Create(Self.Parent);
    with WC013 do
    begin
      ckList.Items.BeginUpdate;
      ckList.Items.Clear;
      selT350Cod.First;
      while not selT350Cod.Eof do
      begin
        if drgpSelTurni.ItemIndex = 0 then
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
      C190PutCheckList(dedtTurni.Text,LenCod,ckList);
      ResultEvent:=ResultSelTurni;
      Visualizza(0,IfThen(dgrpTipoStampa.ItemIndex = 2,MAX_CODICI,0));
    end;
  end;
end;

procedure TWA207FProfiliStampeRepDettFM.ResultSelTurni(Sender: TObject; Result:Boolean);
var LenCod: Integer;
begin
  LenCod:=IfThen(drgpSelTurni.ItemIndex = 0,5,11);
  if Result then
    TWA207FProfiliStampeRepDM(WR302DM).selTabella.FieldByName('TURNI').AsString:=C190GetCheckList(LenCod,WC013.ckList);
end;

procedure TWA207FProfiliStampeRepDettFM.Componenti2DataSet;
begin
  inherited;
end;

procedure TWA207FProfiliStampeRepDettFM.DataSet2Componenti;
begin
  inherited;
  dgrpTipoStampaClick(dgrpTipoStampa);
end;

procedure TWA207FProfiliStampeRepDettFM.dchkCodiceAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkSigla.Enabled:=dchkCodice.Checked;
  if not dchkSigla.Enabled then
    dchkSigla.Checked:=False;
  dchkPriorita.Enabled:=dchkCodice.Checked;
  if not dchkPriorita.Enabled then
    dchkPriorita.Checked:=False;
end;

procedure TWA207FProfiliStampeRepDettFM.dchkDatoLiberoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkDatiAggInRiga.Enabled:=dchkDatiAggiuntivi.Checked;
  if not dchkDatiAggInRiga.Enabled then
    dchkDatiAggInRiga.Checked:=False;
end;

procedure TWA207FProfiliStampeRepDettFM.dchkOrarioAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkOrarioInRiga.Enabled:=dchkOrario.Checked;
  if not dchkOrarioInRiga.Enabled then
    dchkOrarioInRiga.Checked:=False;
end;

procedure TWA207FProfiliStampeRepDettFM.dcmbCampoRaggrChange(Sender: TObject);
begin
  inherited;
  if ((dgrpTipoStampa.ItemIndex <> 1) and (dgrpTipoStampa.ItemIndex <> 2)) or
     (VarToStr(dcmbCampoRaggr.KeyValue) = '') then
  begin
    dchkSaltoPagina.Checked:=False;
    dchkSaltoPagina.Enabled:=False;
  end
  else
    dchkSaltoPagina.Enabled:=True;
end;

procedure TWA207FProfiliStampeRepDettFM.dgrpCampoDettaglioClick(Sender: TObject);
begin
  inherited;
  dcmbCampoDett.Enabled:=dgrpCampoDettaglio.ItemIndex = 0;
end;

procedure TWA207FProfiliStampeRepDettFM.dgrpTipoStampaClick(Sender: TObject);
begin
  inherited;
  dgrpTipoStampa.ItemIndex:=dgrpTipoStampa.Values.IndexOf(TWA207FProfiliStampeRepDM(WR302DM).selTabella.FieldByName('TIPO').AsString);

  case dgrpTipoStampa.ItemIndex of
    0: // tabellone mensile
      TWA207FProfiliStampeRepDM(WR302DM).selTabella.FieldByName('TITOLO').AsString:='Turni di ' + TWA207FProfiliStampeRepDM(WR302DM).A040MW.sTipo + ' del mese di: ';
    1: // tabellone personalizzato
      AbilitaSiglaAssenza;
    2: // prospetto per dipendente
      if R180NumOccorrenzeCar(TWA207FProfiliStampeRepDM(WR302DM).selTabella.FieldByName('TURNI').AsString,',') >= 4 then
        TWA207FProfiliStampeRepDM(WR302DM).selTabella.FieldByName('TURNI').AsString:='';
  end;

  // imposta il titolo nel caso la stampa non sia il tabellone mensile (che ha titolo fisso)
  if dgrpTipoStampa.ItemIndex > 0 then
    CorreggiTitolo;

  // scelta turni
  C190VisualizzaElemento(JQuery,'grpTurni',dgrpTipoStampa.ItemIndex > 0);
  lblTurni.Visible:=dgrpTipoStampa.ItemIndex > 0;
  DedtTurni.Visible:=dgrpTipoStampa.ItemIndex > 0;
  btnScegliTurni.Visible:=dgrpTipoStampa.ItemIndex > 0;
  lblGSelTurni.Visible:=dgrpTipoStampa.ItemIndex > 0;
  drgpSelTurni.Visible:=dgrpTipoStampa.ItemIndex > 0;
  // campo con nominativo
  lblCampoConNom.Visible:=dgrpTipoStampa.ItemIndex in [1,2];
  dcmbCampoConNom.Visible:=dgrpTipoStampa.ItemIndex in [1,2];
  dchkNomeCompleto.Visible:=dgrpTipoStampa.ItemIndex in [1,2];
  // opzioni tabellone
  dchkIncludiNonPianif.Visible:=dgrpTipoStampa.ItemIndex = 1;
  dchkLegenda.Visible:=dgrpTipoStampa.ItemIndex = 1;
  // dettaglio cella tabellone
  C190VisualizzaElemento(JQuery,'grpDettaglioTabellone',dgrpTipoStampa.ItemIndex = 1);
  lblGDettaglioTabellone.Visible:=dgrpTipoStampa.ItemIndex = 1;
  lblGDatiPianif.Visible:=dgrpTipoStampa.ItemIndex = 1;
  dchkCodice.Visible:=dgrpTipoStampa.ItemIndex = 1;
  dchkSigla.Visible:=dchkCodice.Visible;
  dchkOrario.Visible:=dgrpTipoStampa.ItemIndex = 1;
  dchkOrarioInRiga.Visible:=dchkOrario.Visible;
  dchkDatiAggiuntivi.Visible:=(dgrpTipoStampa.ItemIndex = 1) and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') and (TWA207FProfiliStampeRepDM(WR302DM).A040MW.CodTipologia = 'R');
  dchkDatiAggInRiga.Visible:=dchkDatiAggiuntivi.Visible and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '');
  dchkDatoLibero.Visible:=(dgrpTipoStampa.ItemIndex = 1) and (Parametri.CampiRiferimento.C3_DatoPianificabile <> '') and not dchkDatiAggiuntivi.Visible;
  lblGDatiAssenza.Visible:=dgrpTipoStampa.ItemIndex = 1;
  drgpDatiAssenza.Visible:=dgrpTipoStampa.ItemIndex = 1;
  dedtSiglaAssenza.Visible:=dgrpTipoStampa.ItemIndex = 1;
  // campo di dettaglio anagrafico
  C190VisualizzaElemento(JQuery,'grpDettaglio',dgrpTipoStampa.ItemIndex = 2);
  lblCampoDett.Visible:=dgrpTipoStampa.ItemIndex = 2;
  dcmbCampoDett.Visible:=dgrpTipoStampa.ItemIndex = 2;
  dgrpCampoDettaglio.Visible:=dgrpTipoStampa.ItemIndex = 2;

  dgrpCampoDettaglioClick(dgrpCampoDettaglio);

  // abilita salto pagina in base a selezione
  dchkSaltoPagina.Enabled:=((dgrpTipoStampa.ItemIndex = 1) or (dgrpTipoStampa.ItemIndex = 2)) and
                          (VarToStr(dcmbCampoRaggr.KeyValue) <> '');
  if not dchkSaltoPagina.Enabled then
    dchkSaltoPagina.Checked:=False;
end;

procedure TWA207FProfiliStampeRepDettFM.drgpDatiAssenzaClick(Sender: TObject);
begin
  inherited;
  AbilitaSiglaAssenza;
end;

procedure TWA207FProfiliStampeRepDettFM.drgpSelTurniClick(Sender: TObject);
begin
  inherited;
  TWA207FProfiliStampeRepDM(WR302DM).selTabella.FieldByName('TURNI').AsString:='';
end;

procedure TWA207FProfiliStampeRepDettFM.IWFrameRegionCreate(Sender: TObject);
var
  lstFonts: TList<String>;
  FontName, s: string;
  Found: Boolean;
  ps: TQRPaperSize;
begin
  inherited;
  //fonts
  with TWA207FProfiliStampeRepDM(WR302DM).A040MW do
  begin
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

      dcmbFont.Items.Clear;
      for s in lstFonts do
        dcmbFont.Items.Add(s);
//      dcmbFont.Text:=FontName;
    finally
      FreeAndNil(lstFonts);
    end;
  end;

  dcmbCampoRaggr.ListSource:=TWA207FProfiliStampeRepDM(WR302DM).A040MW.D010;
  dcmbCampoDett.ListSource:=TWA207FProfiliStampeRepDM(WR302DM).A040MW.D010B;
  dcmbCampoConNom.ListSource:=TWA207FProfiliStampeRepDM(WR302DM).A040MW.D010C;

  dcmbFormatoPag.Items.Clear;
  dcmbFormatoPag.Items.Add('(non impostato)');
  for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
    dcmbFormatoPag.Items.Add(QRPaperName(ps));
end;

procedure TWA207FProfiliStampeRepDettFM.CorreggiTitolo;
// rimuove la data dal titolo per evitare disallineamenti
var
  LTitolo: string;
begin
  if dgrpTipoStampa.ItemIndex = 0 then
    Exit;

  // verifica se il titolo è quello fisso
  LTitolo:=dedtTitolo.Text;
  if LTitolo.StartsWith('Turni di ' + TWA207FProfiliStampeRepDM(WR302DM).A040MW.sTipo + ' del mese di: ') then
    TWA207FProfiliStampeRepDM(WR302DM).SelTabella.FieldByName('TITOLO').AsString:='Turni di ' + TWA207FProfiliStampeRepDM(WR302DM).A040MW.sTipo;
end;


end.
