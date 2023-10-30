unit A040UDialogStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, DBCtrls, StdCtrls, Spin, Grids, DBGrids, CheckLst, ExtCtrls,
  Printers, QRPrntr, ComCtrls, Oracle, Variants, Mask, StrUtils, Math, QRPDFFilt, OracleData,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione, A003UDataLavoroBis, A207UProfiliStampeRep,
  C001StampaLib, C004UParamForm, C013UCheckList, C180FunzioniGenerali, QueryStorico, Vcl.Menus;

type
  TA040FDialogStampa = class(TForm)
    PrinterSetupDialog1: TPrinterSetupDialog;
    pnlTipo: TPanel;
    rgpTipoStampa: TRadioGroup;
    pnlBottom: TPanel;
    btnPrinterSetUp: TBitBtn;
    btnAnteprima: TBitBtn;
    btnStampa: TBitBtn;
    btnClose: TBitBtn;
    ProgressBar: TProgressBar;
    ppMnuAccedi: TPopupMenu;
    Accedi1: TMenuItem;
    pnlProfili: TPanel;
    dLblDescProfilo: TDBText;
    dCmbLkpProfili: TDBLookupComboBox;
    pnlPeriodo: TPanel;
    grpPeriodo: TGroupBox;
    lblDataDa: TLabel;
    lblDataA: TLabel;
    edtDataDa: TMaskEdit;
    btnDataDa: TBitBtn;
    edtDataA: TMaskEdit;
    btnDataA: TBitBtn;
    pnlTitolo: TPanel;
    pnlLayout: TPanel;
    GroupBox1: TGroupBox;
    grpLayout: TGroupBox;
    lblTitolo: TLabel;
    edtTitolo: TEdit;
    lblTitoloSize: TLabel;
    edtTitoloSize: TEdit;
    chkTitoloBold: TCheckBox;
    chkTitoloUnderline: TCheckBox;
    Label2: TLabel;
    lblOPagina: TLabel;
    Label3: TLabel;
    edtSize: TEdit;
    cmbFont: TComboBox;
    cmbOrientamento: TComboBox;
    pnlRaggruppamento: TPanel;
    lblCampoRaggr: TLabel;
    dcmbCampoRaggr: TDBLookupComboBox;
    chkSaltoPagina: TCheckBox;
    pnlSceltaTurni: TPanel;
    lblTurni: TLabel;
    edtTurni: TEdit;
    btnScegliTurni: TButton;
    rgpSelTurni: TRadioGroup;
    pnlCampoConNominativo: TPanel;
    lblCampoConNom: TLabel;
    dcmbCampoConNom: TDBLookupComboBox;
    chkNomeCompleto: TCheckBox;
    pnlOpzioniTabellone: TPanel;
    chkIncludiNonPianif: TCheckBox;
    chkLegenda: TCheckBox;
    pnlCampoDettaglio: TPanel;
    dcmbCampoDett: TDBLookupComboBox;
    pnlDettaglioTabellone: TPanel;
    grpDettaglioTabellone: TGroupBox;
    rgpDatiAssenza: TRadioGroup;
    edtSiglaAssenza: TEdit;
    grpDatiPianif: TGroupBox;
    chkCodice: TCheckBox;
    chkOrario: TCheckBox;
    chkDatoLibero: TCheckBox;
    chkSigla: TCheckBox;
    chkPriorita: TCheckBox;
    chkOrarioInRiga: TCheckBox;
    chkDatiAggInRiga: TCheckBox;
    chkDatiAggiuntivi: TCheckBox;
    lblProfilo: TLabel;
    lblEsempio: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    cmbFormato: TComboBox;
    rgpCampoDettaglio: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpTipoStampaClick(Sender: TObject);
    procedure btnDataDaClick(Sender: TObject);
    procedure edtDataADblClick(Sender: TObject);
    procedure dcmbCampoRaggrClick(Sender: TObject);
    procedure dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnScegliTurniClick(Sender: TObject);
    procedure rgpSelTurniClick(Sender: TObject);
    procedure rgpDatiAssenzaClick(Sender: TObject);
    procedure btnPrinterSetUpClick(Sender: TObject);
    procedure btnStampaClick(Sender: TObject);
    procedure chkCodiceClick(Sender: TObject);
    procedure chkOrarioClick(Sender: TObject);
    procedure chkDatiAggiuntiviClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure dCmbLkpProfiliClick(Sender: TObject);
    procedure dCmbLkpProfiliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbFontChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtTitoloExit(Sender: TObject);
    procedure rgpCampoDettaglioClick(Sender: TObject);
  private
    FontCorpo: TFont;
    FontTitolo: TFont;
    FLstTitoli: TStringList;
    procedure AbilitaComponenti(pAbilita: Boolean);
    procedure AggiornaFont;
    procedure CaricaTemplate;
    procedure CaricaFormati;
    procedure CaricaListaFont;
    procedure CorreggiTitolo;
    procedure GeneraQueryMese;
    procedure GeneraQueryMista;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function GetOrientamento: TPrinterOrientation;
    procedure PutOrientamento(const Value: TPrinterOrientation);
    property Orientamento:TPrinterOrientation read GetOrientamento write PutOrientamento;
  public
  end;

var
  A040FDialogStampa: TA040FDialogStampa;

const
  NumLet = '0123456789ABCDEFGHILMNOPQRSTUVZ';

implementation

uses A040UPianifRep,A040UPianifRepDtM1,A040UStampa,A002UInterfacciaSt,
     A040UPianifRepDtM2,A040UStampa2,C700USelezioneAnagrafe;

{$R *.DFM}

procedure TA040FDialogStampa.FormShow(Sender: TObject);
begin
  dLblDescProfilo.DataSource:=A040FPianifRepDtM1.A040MW.drsT355;
  // periodo stampa
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(A040FPianifRepDtM1.A040MW.DataSt));
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(A040FPianifRepDtM1.A040MW.DataSt));
  // priorità
  chkPriorita.Visible:=A040FPianifRepDtM1.A040MW.CodTipologia = 'R';
  // dati aggiuntivi
  chkDatiAggiuntivi.Visible:=(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') and (A040FPianifRepDtM1.A040MW.CodTipologia = 'R');
  chkDatiAggInRiga.Visible:=chkDatiAggiuntivi.Visible and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '');
  // dato libero pianif. (nascosto se gestisco dati aggiuntivi)
  chkDatoLibero.Visible:=(Parametri.CampiRiferimento.C3_DatoPianificabile <> '') and not chkDatiAggiuntivi.Visible;
  chkDatoLibero.Caption:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile) + ' pianificato';
  chkDatoLibero.Top:=chkDatiAggiuntivi.Top;
  chkDatoLibero.Left:=chkDatiAggiuntivi.Left;
  // impostazioni per la selezione del font
  FontCorpo:=A040FStampa2.QRep.Font;
  FontTitolo:=A040FStampa2.LTitolo.Font;

  if A040FPianifRep.TipoModulo <> 'COM' then
  begin
    // salvataggio parametri
    CreaC004(SessioneOracle,'A040_1',Parametri.ProgOper);
    GetParametriFunzione;
  end;
  Self.Height:=701;

  if dCmbLkpProfili.KeyValue = '' then
    dLblDescProfilo.Caption:=''
  else
    dCmbLkpProfiliClick(dCmbLkpProfili);
end;

procedure TA040FDialogStampa.FormActivate(Sender: TObject);
begin
  rgpTipoStampaClick(nil);
  if dCmbLkpProfili.KeyValue = '' then
    dLblDescProfilo.Caption:=''
  else
    dCmbLkpProfiliClick(dCmbLkpProfili);
  OnActivate:=nil;
end;

procedure TA040FDialogStampa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  OnActivate:=FormActivate;
  if A040FPianifRep.TipoModulo <> 'COM' then
    PutParametriFunzione;
end;

procedure TA040FDialogStampa.FormCreate(Sender: TObject);
begin
  FLstTitoli:=TStringList.Create;
  CaricaListaFont;
  CaricaFormati;
end;

procedure TA040FDialogStampa.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FLstTitoli);
end;

function TA040FDialogStampa.GetOrientamento: TPrinterOrientation;
begin
  Result:=TPrinterOrientation(Max(0, cmbOrientamento.ItemIndex -1));
end;

procedure TA040FDialogStampa.GetParametriFunzione;
var
  i: Integer;
  ps: TQRPaperSize;
begin
  rgpTipoStampa.OnClick:=nil;
  rgpTipoStampa.ItemIndex:=StrToInt(C004FParamForm.GetParametro('TIPOSTAMPA','0'));
  rgpTipoStampa.OnClick:=rgpTipoStampaClick;
  FLstTitoli.Clear;
  for i:=0 to rgpTipoStampa.Items.Count - 1 do
    FLstTitoli.Add(C004FParamForm.GetParametro(Format('TITOLO_%d',[i]),''));
  edtTitolo.Text:=C004FParamForm.GetParametro(Format('TITOLO_%d',[rgpTipoStampa.ItemIndex]),C004FParamForm.GetParametro('TITOLO',''));
  // salva il titolo corrente nel corrispondente elemento
  FLstTitoli[rgpTipoStampa.ItemIndex]:=edtTitolo.Text;
  dcmbCampoRaggr.KeyValue:=C004FParamForm.GetParametro('CAMPORAGGR','');
  chkSaltoPagina.Checked:=C004FParamForm.GetParametro('SALTOPAGINA','N') = 'S';
  rgpSelTurni.ItemIndex:=StrToInt(C004FParamForm.GetParametro('SELTURNI','0'));
  edtTurni.Text:=C004FParamForm.GetParametro('ELENCOTURNI','');
  dcmbCampoConNom.KeyValue:=C004FParamForm.GetParametro('CAMPOCONNOM','');
  chkNomeCompleto.Checked:=C004FParamForm.GetParametro('NOMECOMPLETO','S') = 'S';
  chkIncludiNonPianif.Checked:=C004FParamForm.GetParametro('INCLUDINONPIANIF','S') = 'S';
  chkLegenda.Checked:=C004FParamForm.GetParametro('LEGENDA','N') = 'S';
  chkCodice.Checked:=C004FParamForm.GetParametro('TURNO_CODICE','N') = 'S';
  chkSigla.Checked:=chkCodice.Checked and (C004FParamForm.GetParametro('TURNO_SIGLA','N') = 'S');
  chkPriorita.Checked:=chkCodice.Checked and (C004FParamForm.GetParametro('TURNO_PRIORITA','S') = 'S');
  chkOrario.Checked:=C004FParamForm.GetParametro('TURNO_ORARIO','N') = 'S';
  chkOrarioInRiga.Checked:=chkOrario.Checked and (C004FParamForm.GetParametro('TURNO_ORARIOINRIGA','N') = 'S');
  chkDatoLibero.Checked:=C004FParamForm.GetParametro('TURNO_DATOLIBERO','N') = 'S';
  chkDatiAggiuntivi.Checked:=C004FParamForm.GetParametro('TURNO_DATIAGGIUNTIVI','N') = 'S';
  chkDatiAggInRiga.Checked:=chkDatiAggiuntivi.Checked and (C004FParamForm.GetParametro('TURNO_DATIAGGINRIGA','N') = 'S');
  rgpDatiAssenza.ItemIndex:=StrToInt(C004FParamForm.GetParametro('DATIASSENZA','0'));
  edtSiglaAssenza.Text:=C004FParamForm.GetParametro('SIGLAASSENZA','ASS');
  dcmbCampoDett.KeyValue:=C004FParamForm.GetParametro('CAMPODETT','');
  //COMO_ASL 2021/084 SVILUPPO#1
  cmbFont.ItemIndex:=cmbFont.Items.IndexOf(C004FParamForm.GetParametro('FONTNAME','Courier New'));
  edtSize.Text:=C004FParamForm.GetParametro('FONTSIZE','8');
  edtTitoloSize.Text:=C004FParamForm.GetParametro('TITOLO_SIZE','10');
  chkTitoloBold.Checked:=C004FParamForm.GetParametro('TITOLO_BOLD','S') = 'S';
  chkTitoloUnderline.Checked:=C004FParamForm.GetParametro('TITOLO_UNDERLINE','N') = 'N';

  try
    if C004FParamForm.GetParametro('ORIENTAMENTOPAG', A040FPianifRepDtM1.A040MW.ORIZZONTALE) = A040FPianifRepDtM1.A040MW.ORIZZONTALE then
      Printer.Orientation:=poLandScape
    else
      Printer.Orientation:=poPortrait;
  except
  end;

  dCmbLkpProfili.KeyValue:=C004FParamForm.GetParametro('PROFILO','');
  AggiornaFont;
  //---
  A040FStampa.RepR.PrinterSettings.Orientation:=A040FStampa2.QRep.PrinterSettings.Orientation;
  for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
    if C004FParamForm.GetParametro('FORMATOPAG','') = QRPaperName(ps) then
    begin
      A040FPianifRepDtM1.A040MW.PaperSizeStampa:=ps; //imposta la variabile sul report, ma non si vede dal PrinterSetupDialog
      A040FPianifRepDtM1.A040MW.PaperSizeStampa2:=ps;//imposta la variabile sul report, ma non si vede dal PrinterSetupDialog
      cmbFormato.ItemIndex:=cmbFormato.Items.IndexOf(QRPaperName(ps));
      break;
    end;
  rgpCampoDettaglio.ItemIndex:=StrToInt(C004FParamForm.GetParametro('DETTAGLIO','0'));
end;

procedure TA040FDialogStampa.rgpCampoDettaglioClick(Sender: TObject);
begin
  dcmbCampoDett.Enabled:=rgpCampoDettaglio.ItemIndex = 0;
end;

procedure TA040FDialogStampa.PutOrientamento(const Value: TPrinterOrientation);
begin
  if Value = poPortrait then
    cmbOrientamento.ItemIndex:=1
  else if Value = poLandscape then
    cmbOrientamento.ItemIndex:=2
  else
    cmbOrientamento.ItemIndex:=0;
end;

procedure TA040FDialogStampa.PutParametriFunzione;
var
  i: Integer;
  ps: TQRPaperSize;
begin
  AggiornaFont;
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  // salva il titolo corrente nel corrispondente elemento
  FLstTitoli[rgpTipoStampa.ItemIndex]:=edtTitolo.Text;
  for i:=0 to rgpTipoStampa.Items.Count - 1 do
    C004FParamForm.PutParametro(Format('TITOLO_%d',[i]),FLstTitoli[i]);
  C004FParamForm.PutParametro('TITOLO',edtTitolo.Text);
  C004FParamForm.PutParametro('CAMPORAGGR',VarToStr(dcmbCampoRaggr.KeyValue));
  C004FParamForm.PutParametro('SALTOPAGINA',IfThen(chkSaltoPagina.Checked,'S','N'));
  C004FParamForm.PutParametro('SELTURNI',IntToStr(rgpSelTurni.ItemIndex));
  C004FParamForm.PutParametro('ELENCOTURNI',edtTurni.Text);
  C004FParamForm.PutParametro('CAMPOCONNOM',VarToStr(dcmbCampoConNom.KeyValue));
  C004FParamForm.PutParametro('NOMECOMPLETO',IfThen(chkNomeCompleto.Checked,'S','N'));
  C004FParamForm.PutParametro('INCLUDINONPIANIF',IfThen(chkIncludiNonPianif.Checked,'S','N'));
  C004FParamForm.PutParametro('LEGENDA',IfThen(chkLegenda.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_CODICE',IfThen(chkCodice.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_SIGLA',IfThen(chkSigla.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_PRIORITA',IfThen(chkPriorita.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_ORARIO',IfThen(chkOrario.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_ORARIOINRIGA',IfThen(chkOrarioInRiga.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_DATOLIBERO',IfThen(chkDatoLibero.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_DATIAGGIUNTIVI',IfThen(chkDatiAggiuntivi.Checked,'S','N'));
  C004FParamForm.PutParametro('TURNO_DATIAGGINRIGA',IfThen(chkDatiAggInRiga.Checked,'S','N'));
  C004FParamForm.PutParametro('DATIASSENZA',IntToStr(rgpDatiAssenza.ItemIndex));
  C004FParamForm.PutParametro('SIGLAASSENZA',edtSiglaAssenza.Text);
  C004FParamForm.PutParametro('CAMPODETT',VarToStr(dcmbCampoDett.KeyValue));
  C004FParamForm.PutParametro('FONTNAME',FontCorpo.Name);
  C004FParamForm.PutParametro('FONTSIZE',IntToStr(FontCorpo.Size));
  try
    if Printer.Orientation = poPortrait then
      C004FParamForm.PutParametro('ORIENTAMENTOPAG',A040FPianifRepDtM1.A040MW.VERTICALE)
    else if Printer.Orientation = poLandScape then
      C004FParamForm.PutParametro('ORIENTAMENTOPAG',A040FPianifRepDtM1.A040MW.ORIZZONTALE);
  except
  end;
  for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
    if A040FPianifRepDtM1.A040MW.PaperSizeStampa2 = TQRPaperSize(ps) then
      C004FParamForm.PutParametro('FORMATOPAG',QRPaperName(ps));
  C004FParamForm.PutParametro('TITOLO_SIZE',IntToStr(FontTitolo.Size));
  C004FParamForm.PutParametro('TITOLO_BOLD',IfThen(fsBold In FontTitolo.Style,'S','N'));
  C004FParamForm.PutParametro('TITOLO_UNDERLINE',IfThen(fsUnderline In FontTitolo.Style,'S','N'));

  C004FParamForm.PutParametro('PROFILO',VarToStr(dCmbLkpProfili.KeyValue));
  C004FParamForm.PutParametro('DETTAGLIO',VarToStr(rgpCampoDettaglio.ItemIndex));
  try SessioneOracle.Commit; except end;
end;

procedure TA040FDialogStampa.CorreggiTitolo;
// rimuove la data dal titolo per evitare disallineamenti
var
  LTitolo: string;
begin
  // PRE: rgpTipoStampa.ItemIndex > 0
  if rgpTipoStampa.ItemIndex = 0 then
    Exit;

  // verifica se il titolo è quello fisso
  LTitolo:=edtTitolo.Text;
  if LTitolo.StartsWith('Turni di ' + A040FPianifRepDtM1.A040MW.sTipo + ' del mese di: ') then
    edtTitolo.Text:='Turni di ' + A040FPianifRepDtM1.A040MW.sTipo;
end;

procedure TA040FDialogStampa.rgpTipoStampaClick(Sender: TObject);
begin
  case rgpTipoStampa.ItemIndex of
  0: begin
       // tabellone mensile
       edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',R180InizioMese(A040FPianifRepDtM1.A040MW.DataSt));
       edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(A040FPianifRepDtM1.A040MW.DataSt));
       edtTitolo.Text:='Turni di ' + A040FPianifRepDtM1.A040MW.sTipo + ' del mese di: ' + R180NomeMese(R180Mese(A040FPianifRepDtM1.A040MW.DataSt)) + ' ' + IntToStr(R180Anno(A040FPianifRepDtM1.A040MW.DataSt));
     end;
  1: begin
       // tabellone personalizzato
       rgpDatiAssenzaClick(nil);
     end;
  2: begin
       // prospetto per dipendente
       if R180NumOccorrenzeCar(edtTurni.Text,',') >= 4 then
         edtTurni.Text:='';
     end;
  3: begin
       // prospetto orizzontale
       A040FStampa2.AbilRaggr:=False;
     end;
  end;

  // imposta il titolo nel caso la stampa non sia il tabellone mensile (che ha titolo fisso)
  if rgpTipoStampa.ItemIndex > 0 then
  begin
    edtTitolo.Text:=IfThen(dCmbLkpProfili.KeyValue = '', FLstTitoli[rgpTipoStampa.ItemIndex], edtTitolo.Text);
    CorreggiTitolo;
  end;

  edtDataDa.Enabled:=rgpTipoStampa.ItemIndex <> 0;
  btnDataDa.Enabled:=rgpTipoStampa.ItemIndex <> 0;
  edtDataA.Enabled:=rgpTipoStampa.ItemIndex <> 0;
  btnDataA.Enabled:=rgpTipoStampa.ItemIndex <> 0;
  edtTitolo.Enabled:=rgpTipoStampa.ItemIndex <> 0;

  // reimposta visualizzazione pannelli
  pnlRaggruppamento.Visible:=False;
  pnlSceltaTurni.Visible:=False;
  pnlCampoConNominativo.Visible:=False;
  pnlOpzioniTabellone.Visible:=False;
  pnlDettaglioTabellone.Visible:=False;
  pnlCampoDettaglio.Visible:=False;
  pnlRaggruppamento.Align:=alNone;
  pnlSceltaTurni.Align:=alNone;
  pnlCampoConNominativo.Align:=alNone;
  pnlOpzioniTabellone.Align:=alNone;
  pnlDettaglioTabellone.Align:=alNone;
  pnlCampoDettaglio.Align:=alNone;
  // visualizza pannelli in base al tipo stampa
  pnlRaggruppamento.Visible:=True;
  if pnlRaggruppamento.Visible then
    pnlRaggruppamento.Align:=alTop;
  // scelta turni
  pnlSceltaTurni.Visible:=rgpTipoStampa.ItemIndex > 0;
  if pnlSceltaTurni.Visible then
    pnlSceltaTurni.Align:=alTop;
  // campo con nominativo
  pnlCampoConNominativo.Visible:=rgpTipoStampa.ItemIndex in [1,2];
  if pnlCampoConNominativo.Visible then
    pnlCampoConNominativo.Align:=alTop;
  // opzioni tabellone
  pnlOpzioniTabellone.Visible:=rgpTipoStampa.ItemIndex = 1;
  if pnlOpzioniTabellone.Visible then
    pnlOpzioniTabellone.Align:=alTop;
  // dettaglio cella tabellone
  pnlDettaglioTabellone.Visible:=rgpTipoStampa.ItemIndex = 1;
  if pnlDettaglioTabellone.Visible then
    pnlDettaglioTabellone.Align:=alTop;
  // campo di dettaglio anagrafico
  pnlCampoDettaglio.Visible:=rgpTipoStampa.ItemIndex = 2;
  if pnlCampoDettaglio.Visible then
    pnlCampoDettaglio.Align:=alTop;

  // abilita salto pagina in base a selezione
  chkSaltoPagina.Enabled:=((rgpTipostampa.ItemIndex = 1) or (rgpTipostampa.ItemIndex = 2)) and
                          (VarToStr(dcmbCampoRaggr.KeyValue) <> '');
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;

  A040FPianifRepDtM1.A040MW.StampaTurniOttimizzata:=(rgpTipostampa.ItemIndex = 2) and (rgpSelTurni.ItemIndex = 0) and (dcmbCampoRaggr.KeyValue <> '');
  edtTurni.Text:=A040FPianifRepDtM1.A040MW.GetCodiciTurnoUtilizzati(edtTurni.Text,edtDataDa.Text,edtDataA.Text,rgpTipoStampa.ItemIndex,rgpSelTurni.ItemIndex);
end;

procedure TA040FDialogStampa.AbilitaComponenti(pAbilita: Boolean);
begin
  pnlTipo.Enabled:=pAbilita;
  pnlLayout.Enabled:=pAbilita;
  pnlTitolo.Enabled:=pAbilita;
  pnlRaggruppamento.Enabled:=pAbilita;
  pnlCampoConNominativo.Enabled:=pAbilita;
  pnlOpzioniTabellone.Enabled:=pAbilita;
  pnlDettaglioTabellone.Enabled:=pAbilita;
  pnlCampoDettaglio.Enabled:=pAbilita;
  pnlSceltaTurni.Enabled:=pAbilita;
  grpDatiPianif.Enabled:=pAbilita;
  rgpDatiAssenza.Enabled:=pAbilita;

  if not pAbilita then
  begin
    chkSaltoPagina.Enabled:=dcmbCampoRaggr.KeyValue <> '';
    chkCodiceClick(chkCodice);
    chkOrarioClick(chkOrario);
  end;
end;

procedure TA040FDialogStampa.Accedi1Click(Sender: TObject);
var
  Cod:String;
begin
  with A040FPianifRepDtM1.A040MW do
  begin
    OpenA207ProfiliStampeRep(selT355.FieldByName('CODICE').AsString);
    Cod:=selT355.FieldByName('CODICE').AsString;
    selT355.Refresh;
    selT355.SearchRecord('CODICE',Cod,[srFromBeginning]);
    dCmbLkpProfili.KeyValue:=A040FPianifRepDtM1.A040MW.drsT355.DataSet.FieldByName(dCmbLkpProfili.KeyField).AsVariant;
    dCmbLkpProfiliClick(dCmbLkpProfili);
    CaricaTemplate;
    AbilitaComponenti(False);
  end;
end;

procedure TA040FDialogStampa.AggiornaFont;
begin
  FontCorpo.Name:=IfThen(cmbFont.Text <> '', cmbFont.Text, FontCorpo.Name);
  FontTitolo.Name:=FontCorpo.Name;
  FontCorpo.Size:=StrToIntDef(edtSize.Text,8);
  FontTitolo.Size:=StrToIntDef(edtTitoloSize.Text,10);
  if chkTitoloBold.Checked then
    FontTitolo.Style:=FontTitolo.Style+[fsBold]
  else
    FontTitolo.Style:=FontTitolo.Style-[fsBold];

  if chkTitoloUnderline.Checked then
    FontTitolo.Style:=FontTitolo.Style+[fsUnderline]
  else
    FontTitolo.Style:=FontTitolo.Style-[fsUnderline];
end;

procedure TA040FDialogStampa.btnDataDaClick(Sender: TObject);
begin
  if Sender = btnDataDa then
    edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataDa.Text),'Data iniziale','G'))
  else
    edtDataA.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtDataA.Text),'Data finale','G'));
end;

procedure TA040FDialogStampa.edtDataADblClick(Sender: TObject);
var D: TDateTime;
begin
  if Sender = edtDataA then
    if TryStrToDate(edtDataDa.Text,D) then
      edtDataA.Text:=FormatDateTime('dd/mm/yyyy',R180FineMese(D));
end;

procedure TA040FDialogStampa.edtTitoloExit(Sender: TObject);
begin
  if dCmbLkpProfili.KeyValue = '' then
    FLstTitoli[rgpTipoStampa.ItemIndex]:=edtTitolo.Text;
end;

procedure TA040FDialogStampa.dcmbCampoRaggrClick(Sender: TObject);
begin
  if ((rgpTipostampa.ItemIndex <> 1) and (rgpTipostampa.ItemIndex <> 2)) or
     (VarToStr(TDBLookupComboBox(Sender).KeyValue) = '') then
  begin
    chkSaltoPagina.Checked:=False;
    chkSaltoPagina.Enabled:=False;
  end
  else
    chkSaltoPagina.Enabled:=True;
end;

procedure TA040FDialogStampa.dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) or (Key = VK_BACK) then
  begin
    TDBLookupComboBox(Sender).KeyValue:='';
    if TDBLookupComboBox(Sender).Field <> nil then
      TDBLookupComboBox(Sender).Field.Clear;
    if Sender = dcmbCampoRaggr then
    begin
      chkSaltoPagina.Checked:=False;
      chkSaltoPagina.Enabled:=False;
    end;
  end;
end;

procedure TA040FDialogStampa.dCmbLkpProfiliClick(Sender: TObject);
begin
  if VarToStr(TDBLookupComboBox(Sender).KeyValue) <> '' then
  begin
    CaricaTemplate;
    AbilitaComponenti(False);
  end;
end;

procedure TA040FDialogStampa.dCmbLkpProfiliKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) or (Key = VK_BACK) then
  begin
    AbilitaComponenti(True);
    CaricaTemplate;
    dLblDescProfilo.Caption:='';
    TDBLookupComboBox(Sender).KeyValue:='';
    if TDBLookupComboBox(Sender).Field <> nil then
      TDBLookupComboBox(Sender).Field.Clear;
  end;
end;

procedure TA040FDialogStampa.btnScegliTurniClick(Sender: TObject);
var Elem: String;
    LenCod: Integer;
begin
  // apre dataset dei turni da visualizzare
  with A040FPianifRepDtM1.A040MW do
  begin
    RecuperaTurni(rgpSelTurni.ItemIndex);
    LenCod:=IfThen(rgpSelTurni.ItemIndex = 0,5,11);
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      with C013FCheckList do
      begin
        if (rgpTipoStampa.ItemIndex = 2) and (rgpSelTurni.ItemIndex = 1) then
          MaxElem:=MAX_CODICI;

        clbListaDati.Items.BeginUpdate;
        clbListaDati.Items.Clear;
        selT350Cod.First;
        while not selT350Cod.Eof do
        begin
          if rgpSelTurni.ItemIndex = 0 then
          begin
            Elem:=Format('%-5s %s',[selT350Cod.FieldByName('CODICE').AsString,selT350Cod.FieldByName('DESCRIZIONE').AsString]);
            clbListaDati.Items.Add(Elem);
          end
          else
          begin
            Elem:=Format('%-5s-%-5s',[selT350Cod.FieldByName('HINI').AsString,selT350Cod.FieldByName('HFINE').AsString]);
            if clbListaDati.Items.IndexOf(Elem) < 0 then
              clbListaDati.Items.Add(Elem);
          end;
          selT350Cod.Next;
        end;
        clbListaDati.Items.EndUpdate;
        R180PutCheckList(edtTurni.Text,LenCod,clbListaDati);
        if ShowModal = mrOK then
          edtTurni.Text:=R180GetCheckList(LenCod,clbListaDati);
      end;
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA040FDialogStampa.rgpSelTurniClick(Sender: TObject);
begin
  edtTurni.Text:='';
end;

procedure TA040FDialogStampa.rgpDatiAssenzaClick(Sender: TObject);
begin
  edtSiglaAssenza.Enabled:=rgpDatiAssenza.ItemIndex = 2;
end;

procedure TA040FDialogStampa.btnPrinterSetUpClick(Sender: TObject);
begin
  //Printer.Orientation:=Orientamento; //Imposta l'orientamento della pagina da cmbOrientamento
  if PrinterSetUpDialog1.Execute then
  begin
    //Se è selezionato un profilo di stampa impedisce di modificare l'orientamento
    {if dCmbLkpProfili.Text = '' then
      Orientamento:=Printer.Orientation;}

    C001SettaQuickReport(A040FStampa.RepR);
    C001SettaQuickReport(A040FStampa2.QRep);
    A040FPianifRepDtM1.A040MW.PaperSizeStampa:=A040FStampa.RepR.Page.PaperSize;
    A040FPianifRepDtM1.A040MW.PaperSizeStampa2:=A040FStampa2.QRep.Page.PaperSize;
  end;
end;

procedure TA040FDialogStampa.btnStampaClick(Sender: TObject);
var DettCella: set of TDettaglioCella;
    S,CampoRaggr,CampoConNom,CampoDett: String;
    ps: TQRPaperSize;
    tmpOrientamento: TPrinterOrientation;
begin
  A040FPianifRepDtM1.A040MW.LstTurniEsclusi:='';
  A040FStampa2.QRep.PrinterSettings.UseStandardPrinter:=(A040FPianifRep.TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  A040FStampa.RepR.PrinterSettings.UseStandardPrinter:=(A040FPianifRep.TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  if A040FPianifRep.TipoModulo <> 'COM' then
  begin
    Printer.Orientation:=Orientamento;

    AggiornaFont;
    for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
      if cmbFormato.Text = QRPaperName(ps) then
      begin  //imposta la variabile sul report, ma non si vede dal PrinterSetupDialog
        A040FPianifRepDtM1.A040MW.PaperSizeStampa:=ps;
        A040FPianifRepDtM1.A040MW.PaperSizeStampa2:=ps;
        break;
      end;

    A040FStampa.RepR.Page.Orientation:=Orientamento;
    A040FStampa.RepR.PrinterSettings.Orientation:=A040FStampa.RepR.Page.Orientation;
    A040FStampa2.QRep.Page.Orientation:=A040FStampa.RepR.Page.Orientation;
    A040FStampa2.QRep.PrinterSettings.Orientation:=A040FStampa2.QRep.Page.Orientation;
  end
  else
  begin
    FontTitolo.Name:=FontCorpo.Name;
    try
      Printer.Orientation:=A040FStampa2.QRep.Page.Orientation;
    except
    end;
  end;

  A040FPianifRepDtM1.A040MW.ControlliStampa(edtDataDa.Text,edtDataA.Text,edtTurni.Text,VarToStr(dcmbCampoRaggr.KeyValue),rgpTipoStampa.ItemIndex,rgpDatiAssenza.ItemIndex,chkCodice.Checked,chkOrario.Checked,chkDatoLibero.Checked,chkDatiAggiuntivi.Checked);
  if rgpTipoStampa.ItemIndex = 0 then
  begin
    // stampa originale
    Screen.Cursor:=crHourGlass;
    with A040FPianifRepDtM1 do
    begin
      CampoRaggr:=VarToStr(dcmbCampoRaggr.KeyValue);
      RaggrDatiAgg:=CampoRaggr = A040MW.DATIAGG;
      NomeLogicoCampoGruppo1:='';
      CampoGruppo1:='';
      TabellaCampoGruppo1:='';
      NomeLogicoCampoGruppo2:='';
      CampoGruppo2:='';
      TabellaCampoGruppo2:='';
      if RaggrDatiAgg then
      begin
        CampoGruppo1:='T430D_' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1;
        NomeLogicoCampoGruppo1:=VarToStr(A040MW.selI010.Lookup('NOME_CAMPO',CampoGruppo1,'NOME_LOGICO'));
        if NomeLogicoCampoGruppo1 = '' then
        begin
          CampoGruppo1:='T430' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1;
          NomeLogicoCampoGruppo1:=VarToStr(A040MW.selI010.Lookup('NOME_CAMPO',CampoGruppo1,'NOME_LOGICO'));
        end;
        TabellaCampoGruppo1:=AliasTabella(CampoGruppo1);
        S:=C700SelAnagrafe.SQL.Text;
        if R180CercaParolaIntera(TabellaCampoGruppo1 + '.' + CampoGruppo1,S,',') > 0 then
        begin
          S:=StringReplace(S,',' + TabellaCampoGruppo1 + '.' + CampoGruppo1,'',[]);
          C700SelAnagrafe.CloseAll;
          C700SelAnagrafe.SQL.Text:=S;
        end;
        if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
        begin
          CampoGruppo2:='T430D_' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2;
          NomeLogicoCampoGruppo2:=VarToStr(A040MW.selI010.Lookup('NOME_CAMPO',CampoGruppo2,'NOME_LOGICO'));
          if NomeLogicoCampoGruppo2 = '' then
          begin
            CampoGruppo2:='T430' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2;
            NomeLogicoCampoGruppo2:=VarToStr(A040MW.selI010.Lookup('NOME_CAMPO',CampoGruppo2,'NOME_LOGICO'));
          end;
          TabellaCampoGruppo2:=AliasTabella(CampoGruppo2);
          S:=C700SelAnagrafe.SQL.Text;
          if R180CercaParolaIntera(TabellaCampoGruppo2 + '.' + CampoGruppo2,S,',') > 0 then
          begin
            S:=StringReplace(S,',' + TabellaCampoGruppo2 + '.' + CampoGruppo2,'',[]);
            C700SelAnagrafe.CloseAll;
            C700SelAnagrafe.SQL.Text:=S;
          end;
        end;
      end
      else if CampoRaggr <> '' then
      begin
        NomeLogicoCampoGruppo1:=dcmbCampoRaggr.Text;
        CampoGruppo1:=A040MW.selI010.FieldByName('Nome_Campo').AsString;
        TabellaCampoGruppo1:=AliasTabella(A040MW.selI010.FieldByName('Nome_Campo').AsString);
        S:=C700SelAnagrafe.SQL.Text;
        if R180InserisciColonna(S,TabellaCampoGruppo1 + '.' + CampoGruppo1) then
        begin
          C700SelAnagrafe.CloseAll;
          C700SelAnagrafe.SQL.Text:=S;
        end;
      end;
    end;
    if A040FPianifRepDtM1.A040MW.DataSt <> C700SelAnagrafe.GetVariable('DataLavoro') then
    begin
      C700SelAnagrafe.CloseAll;
      C700SelAnagrafe.SetVariable('DataLavoro',A040FPianifRepDtM1.A040MW.DataSt);
    end;
    C700SelAnagrafe.Open;
    GeneraQueryMese;
    GeneraQueryMista;
    C001SettaQuickReport(A040FStampa.RepR);
    A040FStampa.RepR.Page.PaperSize:=A040FPianifRepDtM1.A040MW.PaperSizeStampa;
    A040FStampa.RepR.PrinterSettings.PaperSize:=A040FStampa.RepR.Page.PaperSize;
    A040FStampa.DataStampa:=A040FPianifRepDtM1.A040MW.DataSt;
    Screen.Cursor:=crDefault;
    with A040FStampa do
    begin
      CreaReport;
      if (A040FPianifRep.TipoModulo = 'COM') and (Trim(A040FPianifRep.DocumentoPDF) <> '') and (Trim(A040FPianifRep.DocumentoPDF) <> '<VUOTO>') then
      begin
        RepR.ShowProgress:=False;
        RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A040FPianifRep.DocumentoPDF));
      end
      else if Sender = btnAnteprima then
        RepR.Preview
      else
        RepR.Print;
    end;
  end
  else
  begin
    // *** nuove stampe
    // campo di raggruppamento
    if VarToStr(dcmbCampoRaggr.KeyValue) <> '' then
      CampoRaggr:=A040FPianifRepDtM1.A040MW.selI010.FieldByName('Nome_Campo').AsString
    else
      CampoRaggr:='';

    // campo con nominativo
    if VarToStr(dcmbCampoConNom.KeyValue) <> '' then
      CampoConNom:=A040FPianifRepDtM1.A040MW.selI010C.FieldByName('Nome_Campo').AsString
    else
      CampoConNom:='';

    // campo di dettaglio anagrafico
    if rgpCampoDettaglio.ItemIndex = 0 then
    begin
    if VarToStr(dcmbCampoDett.KeyValue) <> '' then
      CampoDett:=A040FPianifRepDtM1.A040MW.selI010B.FieldByName('Nome_Campo').AsString
    else
      CampoDett:='';
    end
    else
      CampoDett:=A040FPianifRepDtM1.A040MW.RECAPITO;

    // compone il dettaglio cella
    DettCella:=[];
    if chkCodice.Checked then
    begin
      Include(DettCella,dtCodice);
      if chkSigla.Checked then
        Include(DettCella,dtSigla);
      if chkPriorita.Checked then
        Include(DettCella,dtPriorita);
    end;
    if chkOrario.Checked then
    begin
      Include(DettCella,dtOrario);
      if chkOrarioInRiga.Checked then
        Include(DettCella,dtOrarioInRiga);
    end;
    if chkDatoLibero.Checked then
      Include(DettCella,dtDatoLibero);
    if chkDatiAggiuntivi.Checked then
    begin
      Include(DettCella,dtDatiAggiuntivi);
      if chkDatiAggInRiga.Checked then
        Include(DettCella,dtDatiAggInRiga);
    end;
    case rgpDatiAssenza.ItemIndex of
      1: Include(DettCella,dtCausAss);
      2: Include(DettCella,dtSiglaAss);
    end;

    // predispone il dataset per la stampa
    with A040FPianifRepDtM2 do
    begin
      case rgpTipoStampa.ItemIndex of
        1: TipoStampa:=tsTabellone;
        2: TipoStampa:=tsProspettoDip;
        3: TipoStampa:=tsProspettoRaggr;
      end;
      TipologiaTurno:=A040FPianifRepDtM1.A040MW.CodTipologia;
      DataInizio:=StrToDate(edtDataDa.Text);
      DataFine:=StrToDate(edtDataA.Text);

      IncludiNonPianificati:=chkIncludiNonPianif.Checked;
      RaggrDatiAgg:=CampoRaggr = A040FPianifRepDtM1.A040MW.DATIAGG;
      NomeCampoRaggr1:='';
      NomeCampoRaggr2:='';
      if RaggrDatiAgg then
      begin
        try
          NomeCampoRaggr1:='T430D_' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1;
        except
          NomeCampoRaggr1:='T430' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1;
        end;
        if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
          try
            NomeCampoRaggr2:='T430D_' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2;
          except
            NomeCampoRaggr2:='T430' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2;
          end;
      end
      else
        NomeCampoRaggr1:=CampoRaggr;

      A040FPianifRepDtM1.A040MW.StampaTurniOttimizzata:=(TipoStampa = tsProspettoDip) and (rgpSelTurni.ItemIndex = 0) and (NomeCampoRaggr1 <> '');

      //SAVONA_ASL2 - Chiamata: 170770 - Non devono essere aggiunti turni in stampa a quelli selezionati.
      ElencoTurni:=edtTurni.Text;
      A040FPianifRepDtM1.A040MW.GetCodiciTurnoUtilizzati(edtTurni.Text, edtDataDa.Text, edtDataA.Text, rgpTipoStampa.ItemIndex, rgpSelTurni.ItemIndex); //(deve essere eseguita perchè imposta il dataset selTurni)
      (*if rgpSelTurni.ItemIndex = 0 then  //Se chiamata COM il controllo dei codici è già fatto a monte
      begin
        ElencoTurni:=IfThen(A040FPianifRep.TipoModulo = 'COM', edtTurni.Text, A040FPianifRepDtM1.A040MW.GetCodiciTurnoUtilizzati(edtTurni.Text, edtDataDa.Text, edtDataA.Text, rgpTipoStampa.ItemIndex, rgpSelTurni.ItemIndex));
      end
      else
        ElencoOrari:=edtTurni.Text;*)

      NomeCampoConNom:=CampoConNom;
      NomeCampoDett:=CampoDett;
      SiglaAssenza:=edtSiglaAssenza.Text;
      DettaglioCella:=DettCella;
      VisualizzaLegenda:=chkLegenda.Checked;
      NomeCompleto:=chkNomeCompleto.Checked;
      PBar:=ProgressBar;

      // prepara il dataset per la stampa
      Screen.Cursor:=crHourGlass;
      try
        PreparaDati;
      except
        on E: Exception do
        begin
          Screen.Cursor:=crDefault;
          raise exception.Create(Format(A000MSG_A040_ERR_FMT_STAMPA,[E.Message + IfThen(E.ClassName <> 'Exception',' (' + E.ClassName + ')')]));
        end;
      end;
      Screen.Cursor:=crDefault;
    end;

    // imposta proprietà stampa e crea report
    C001SettaQuickReport(A040FStampa2.QRep);
    with A040FStampa2 do
    begin
      tmpOrientamento:=QRep.Page.Orientation;
      QRep.Page.PaperSize:=A040FPianifRepDtM1.A040MW.PaperSizeStampa2;
      QRep.PrinterSettings.PaperSize:=QRep.Page.PaperSize;
      QRep.Page.Orientation:=tmpOrientamento;
      AbilRaggr:=(CampoRaggr <> '');
      VisualizzaLegenda:=A040FPianifRepDtM2.VisualizzaLegenda;
      Riproporziona:='P';
      QRGroup1.ForceNewPage:=chkSaltoPagina.Checked;
      TitoloStampa:=edtTitolo.Text;
      if TitoloStampa = '' then
      begin
        case rgpTipoStampa.ItemIndex of
          1: TitoloStampa:='Piano di servizio';
          2: TitoloStampa:='Prospetto per dipendente';
          3: TitoloStampa:='Prospetto per raggruppamento';
        end;
      end;
      if rgpTipoStampa.ItemIndex = 3 then
        AbilRaggr:=False;

      if A040FPianifRepDtM1.A040MW.StampaTurniOttimizzata then
        A040FStampa2.RivalutaCodici:=A040FPianifRepDtM2.RivalutaCodici
      else
        A040FStampa2.RivalutaCodici:=nil;

      CreaReport;

      //Messaggio se ci sono dei turni esclusi dalla stampa per "prospetto per dipendente"
      with A040FPianifRepDtM1.A040MW do
      begin
        if LstTurniEsclusi <> '' then
        begin
          A040FPianifRep.MessaggioDCOM:=Format(A000MSG_A040_MSG_FMT_TURNI_ESCLUSI,[LstTurniEsclusi.Substring(0, LstTurniEsclusi.Length - 1),IntToStr(MAX_CODICI)]);
          if Assigned(A040FPianifRepDtM1.A040MW.evtMessaggio) then
            evtMessaggio(A040FPianifRep.MessaggioDCOM);
        end
        else
          A040FPianifRep.MessaggioDCOM:='';
      end;

      if (A040FPianifRep.TipoModulo = 'COM') and (Trim(A040FPianifRep.DocumentoPDF) <> '') and (Trim(A040FPianifRep.DocumentoPDF) <> '<VUOTO>') then
      begin
        QRep.ShowProgress:=False;
        QRep.ExportToFilter(TQRPDFDocumentFilter.Create(A040FPianifRep.DocumentoPDF));
      end
      else if Sender = btnAnteprima then
        QRep.Preview
      else
        QRep.Print;
    end;
  end;
  ProgressBar.Position:=0;
  ProgressBar.Repaint;
  Screen.Cursor:=crDefault;
end;

procedure TA040FDialogStampa.CaricaFormati;
var
  ps: TQRPaperSize;
begin
  //Formato pagina
  cmbFormato.Items.Clear;
  cmbFormato.Items.Add('(non impostato)');
  for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
    cmbFormato.Items.Add(QRPaperName(ps));
end;

procedure TA040FDialogStampa.CaricaListaFont;
var
  lstFonts: TStringLIst;
  FontName, s: String;
  Found: Boolean;
begin
  try
    lstFonts:=TStringList.Create;
    lstFonts.AddStrings(screen.fonts);
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

    cmbFont.Items.Clear;
    for s in lstFonts do
      cmbFont.Items.Add(s);

  finally
    FreeAndNil(lstFonts);
  end;
end;

procedure TA040FDialogStampa.CaricaTemplate;
begin
  if A040FPianifRepDtM1.A040MW.selT355.FieldByName('TIPO').AsString = 'M' then
    rgpTipoStampa.ItemIndex:=0
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('TIPO').AsString = 'P' then
    rgpTipoStampa.ItemIndex:=1
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('TIPO').AsString = 'D' then
    rgpTipoStampa.ItemIndex:=2
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('TIPO').AsString = 'R' then
    rgpTipoStampa.ItemIndex:=4;

  edtTitolo.Text:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('TITOLO').AsString;
  if A040FPianifRepDtM1.A040MW.selT355.FieldByName('TIPO').AsString = 'M' then
    edtTitolo.Text:=edtTitolo.Text + R180NomeMese(R180Mese(A040FPianifRepDtM1.A040MW.DataSt)) + ' ' + IntToStr(R180Anno(A040FPianifRepDtM1.A040MW.DataSt));

  dcmbCampoRaggr.KeyValue:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('CAMPO_RAGGRUPPAMENTO').AsString;
  chkSaltoPagina.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('SALTO_PAGINA').AsString = 'S';

  if A040FPianifRepDtM1.A040MW.selT355.FieldByName('SELEZIONE').AsString = 'C' then
    rgpSelTurni.ItemIndex:=0
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('SELEZIONE').AsString = 'O' then
    rgpSelTurni.ItemIndex:=1;
  edtTurni.Text:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('TURNI').AsString;

  dcmbCampoConNom.KeyValue:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('CAMPO_NOMINATIVO').AsString;
  chkNomeCompleto.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('NOME_COMPLETO').AsString = 'S';
  chkIncludiNonPianif.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DIP_NP').AsString = 'S';
  chkLegenda.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('LEGENDA').AsString = 'S';

  chkCodice.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_CODICE').AsString = 'S';
  chkSigla.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_SIGLA').AsString = 'S';
  chkPriorita.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_PRIORITA').AsString = 'S';
  chkOrario.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_ORARIO').AsString = 'S';
  chkOrarioInRiga.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_ORARIO_RIGA').AsString = 'S';
  chkDatiAggiuntivi.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_DATI_AGG').AsString = 'S';
  chkDatiAggInRiga.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_DATI_AGG_RIGA').AsString = 'S';
  chkDatoLibero.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_DATO_LIBERO').AsString = 'S';

  if A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_ASSENZA').AsString = 'N' then
    rgpDatiAssenza.ItemIndex:=0
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_ASSENZA').AsString = 'C' then
    rgpDatiAssenza.ItemIndex:=1
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_ASSENZA').AsString = 'S' then
    rgpDatiAssenza.ItemIndex:=2;

  edtSiglaAssenza.Text:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETT_SIGLA_ASSENZA').AsString;

  cmbFont.ItemIndex:=cmbFont.Items.IndexOf(A040FPianifRepDtM1.A040MW.selT355.FieldByName('FONTNAME').AsString);
  cmbFontChange(cmbFont);
  if A040FPianifRepDtM1.A040MW.selT355.FieldByName('ORIENTAMENTO').AsString = 'A' then
    cmbOrientamento.ItemIndex:=cmbOrientamento.Items.IndexOf(A040FPianifRepDtM1.A040MW.NONIMPOSTATO)
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('ORIENTAMENTO').AsString = 'V' then
    cmbOrientamento.ItemIndex:=cmbOrientamento.Items.IndexOf(A040FPianifRepDtM1.A040MW.VERTICALE)
  else if A040FPianifRepDtM1.A040MW.selT355.FieldByName('ORIENTAMENTO').AsString = 'O' then
    cmbOrientamento.ItemIndex:=cmbOrientamento.Items.IndexOf(A040FPianifRepDtM1.A040MW.ORIZZONTALE)
  else
    cmbOrientamento.ItemIndex:=-1;
  //Orientamento:=TPrinterOrientation(IfThen(A040FPianifRepDtM1.A040MW.selT355.FieldByName('ORIENTAMENTO').AsString = 'O',1,0));
  edtSize.Text:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('FONTSIZE').AsString;
  cmbFormato.ItemIndex:=cmbFormato.Items.IndexOf(A040FPianifRepDtM1.A040MW.selT355.FieldByName('FORMATO').AsString);

  edtTitoloSize.Text:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('TITOLO_SIZE').AsString;
  chkTitoloBold.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('TITOLO_BOLD').AsString = 'S';
  chkTitoloUnderline.Checked:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('TITOLO_UNDERLINE').AsString = 'S';

  dcmbCampoDett.KeyValue:=A040FPianifRepDtM1.A040MW.selT355.FieldByName('CAMPO_DETTAGLIO').AsString;
  rgpCampoDettaglio.ItemIndex:=IfThen(A040FPianifRepDtM1.A040MW.selT355.FieldByName('DETTAGLIO').AsString = 'R',1,0);
end;

procedure TA040FDialogStampa.chkCodiceClick(Sender: TObject);
begin
  chkSigla.Enabled:=chkCodice.Checked;
  if not chkSigla.Enabled then
    chkSigla.Checked:=False;
  chkPriorita.Enabled:=chkCodice.Checked;
  if not chkPriorita.Enabled then
    chkPriorita.Checked:=False;
end;

procedure TA040FDialogStampa.chkOrarioClick(Sender: TObject);
begin
  chkOrarioInRiga.Enabled:=chkOrario.Checked;
  if not chkOrarioInRiga.Enabled then
    chkOrarioInRiga.Checked:=False;
end;

procedure TA040FDialogStampa.cmbFontChange(Sender: TObject);
begin
  lblEsempio.Font.Name:=cmbFont.Text;
end;

procedure TA040FDialogStampa.chkDatiAggiuntiviClick(Sender: TObject);
begin
  chkDatiAggInRiga.Enabled:=chkDatiAggiuntivi.Checked;
  if not chkDatiAggInRiga.Enabled then
    chkDatiAggInRiga.Checked:=False;
end;

procedure TA040FDialogStampa.GeneraQueryMese;
var Alias,Tabella,SQLSelect,Suff:String;
    i:ShortInt;
    SQLJoin,JoinOra:Array[1..31] of String;
    A,M,G,NG:Word;
  function NomeCampoTurno(idxTurno:String):String;
  begin
    if A040FPianifRepDtM1.RaggrDatiAgg then
      Result:='DECODE(' + Alias + '.DatoAgg1_T' + idxTurno + '||'',''||' + Alias + '.DatoAgg2_T' + idxTurno + ',TDA.DatiAgg,' + Alias + '.Turno' + idxTurno + ')'
    else
      Result:=Alias + '.Turno' + idxTurno;
    Result:=Result + ' TURNO' + idxTurno + Suff;
  end;
begin
  with A040FPianifRepDtM1 do
  begin
    Q380St.DisableControls;
    Q380St.Close;
    DecodeDate(A040MW.DataSt,A,M,G);
    SQLSelect:='';
    NG:=R180GiorniMese(A040MW.DataSt);
    //Leggo le fasce dai dati in fasce
    for i:=1 to NG do
    begin
      Alias:='T380' + NumLet[i];
      Tabella:='T380_PianifReperib ' + Alias;
      Suff:='_' + NumLet[i];
      //SQLSelect:=SQLSelect + ',' + Alias + '.Data';
      SQLSelect:=SQLSelect + ',' + NomeCampoTurno('1');
      SQLSelect:=SQLSelect + ',' + NomeCampoTurno('2');
      SQLSelect:=SQLSelect + ',' + NomeCampoTurno('3');
      SQLSelect:=SQLSelect + ',' + Alias + '.DatoLibero DATOLIBERO' + Suff;
      case DataBaseDrv of
         //Sintassi ORACLE
         dbOracle:begin
                  SQLJoin[i]:=',' + Tabella;
                  JoinOra[i]:='T380_.Progressivo = ' + Alias +
                              '.Progressivo(+) AND ' + Alias +
                              '.Data(+) = ' + '''' + FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,i)) + ''' AND ' + Alias +
                              '.Tipologia(+) = '''+ A040MW.CodTipologia+''' AND';
                  end;
      end;
    end;
    with Q380St.Sql do
    begin
      Clear;
      Add('SELECT ' + Copy(SQLSelect,2,Length(SQLSelect)));
      if RaggrDatiAgg then
      begin
        if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '' then
          Add(',I501A.DESCRIZIONE ' + CampoGruppo1);
        if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
          Add(',I501B.DESCRIZIONE ' + CampoGruppo2);
      end;
      Add('FROM T380_PianifReperib T380_');
      for i:=1 to NG do
        Add(SQLJoin[i]);
      if RaggrDatiAgg then
      begin
        if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '' then
          Add(',I501' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 + ' I501A');
        if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
          Add(',I501' + Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 + ' I501B');
      end;
      Add('WHERE');
      //Add('WHERE T380_.TIPOLOGIA = '''+A040FPianifRep.CodTipologia+''' AND');
      if DataBaseDrv = dbOracle then
        for i:=1 to NG do
          Add(JoinOra[i]);
      Add(Format(' T380_.Data BETWEEN ''%s'' AND ''%s''',[FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,1)),FormatDateTime('dd/mm/yyyy',EncodeDate(A,M,NG))]));
    end;
    Q380St.EnableControls;
  end;
end;

procedure TA040FDialogStampa.GeneraQueryMista;
var App,S:String;
    TestoQVista,TestoQuery2:String;
    P,i,iT:Integer;
    NG:Word;
    procedure CambiaT380T030;
    begin
      P:=Pos('T380_.',App);
      while P > 0 do
      begin
        Delete(App,P,5);
        Insert('T030',App,P);
        P:=Pos('T380_.',App);
      end;
    end;
begin
  with A040FPianifRepDtM1 do
  begin
    TestoQVista:=C700SelAnagrafe.Sql.Text;
    TestoQuery2:=UpperCase(Q380St.Sql.Text);
    TestoQVista:=EliminaRitornoACapo(TestoQVista);
    TestoQuery2:=EliminaRitornoACapo(TestoQuery2);
    Q380St.SQL.Clear;
    Q380St.DeleteVariables;
    // Parte SELECT
    App:='SELECT ' + GetSelect(TestoQVista) +','+ GetSelect(TestoQuery2);
    App:=TogliParametro(App,A040MW.DataSt);
    Q380St.SQL.Add(App);
    // Parte FROM
    App:='FROM ' + GetFrom(TestoQVista)+','+GetFrom(TestoQuery2);
    if RaggrDatiAgg then
    begin
      App:=App + ',(SELECT DISTINCT DATIAGG FROM ' +
           '(SELECT T030.PROGRESSIVO FROM ' + GetFrom(TestoQVista) + ' WHERE ' + GetWhere(TestoQVista) + ') ELENCO_DIP,' +
           '(';
      for iT:=1 to 3 do
      begin
        App:=App + Format('SELECT PROGRESSIVO, DATOAGG1_T%s||'',''||DATOAGG2_T%s DATIAGG FROM T380_PIANIFREPERIB ' +
                          'WHERE TIPOLOGIA = ''%s'' AND DATA BETWEEN ''%s'' AND ''%s''',
                          [IntToStr(iT),IntToStr(iT),A040MW.CodTipologia,FormatDateTime('dd/mm/yyyy',R180InizioMese(A040MW.DataSt)),FormatDateTime('dd/mm/yyyy',R180FineMese(A040MW.DataSt))]);
        if iT < 3 then
          App:=App + ' UNION ';
      end;
      App:=App + ') ELENCO_DATI_AGG WHERE ELENCO_DATI_AGG.PROGRESSIVO = ELENCO_DIP.PROGRESSIVO) TDA';
    end;
    Delete(App,Pos(',T380_PIANIFREPERIB T380_',UpperCase(App)),Length(',T380_PIANIFREPERIB T380_'));
    App:=TogliParametro(App,A040MW.DataSt);
    Q380St.SQL.Add(App);
    // Parte WHERE
    App:='WHERE ' + GetWhere(TestoQVista);
    App:=App + ' AND ' + GetWhere(TestoQuery2);
    App:=TogliParametro(App,A040MW.DataSt);
    P:=Pos('T380_.DATA BETWEEN',UpperCase(App));
    S:=Copy(App,P + 19,30);
    Delete(App,P,49);
    Insert('0 < (SELECT COUNT(*) FROM T380_PIANIFREPERIB WHERE PROGRESSIVO = T030.PROGRESSIVO AND TIPOLOGIA = '''+A040MW.CodTipologia+''' AND DATA BETWEEN ' + S + ') ',App,P);
    if RaggrDatiAgg then
    begin
      if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '' then
        App:=App + ' AND I501A.CODICE (+) = SUBSTR(TDA.DATIAGG,1,INSTR(TDA.DATIAGG,'','') - 1) ';
      if Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '' then
        App:=App + ' AND I501B.CODICE (+) = SUBSTR(TDA.DATIAGG,INSTR(TDA.DATIAGG,'','') + 1) ';
    end;
    CambiaT380T030;
    Q380St.SQL.Add(App);
    // Parte ORDER BY
    App:=GetOrderBy(TestoQVista);
    if RaggrDatiAgg then
    begin
      if CampoGruppo2 <> '' then
        App:='I501B.DESCRIZIONE' + IfThen(App <> '',',') + App;
      App:='I501A.DESCRIZIONE' + IfThen(App <> '',',') + App;
    end
    else if CampoGruppo1 <> '' then
      App:=TabellaCampoGruppo1 + '.' + CampoGruppo1 + IfThen(App <> '',',') + App;
    App:='ORDER BY ' + App;
    App:=TogliParametro(App,A040MW.DataSt);
    if App <> 'ORDER BY ' then
      Q380St.SQL.Add(App);
    //App:=TogliParametro(App,A040MW.DataSt);
    if Pos(':C700DATADAL',Q380St.SubstitutedSql) > 0 then
    begin
      Q380St.DeclareVariable('C700DATADAL',otDate);
      Q380St.SetVariable('C700DATADAL',C700DataDal);
    end;
    if Pos(':C700FILTRO',Q380St.SubstitutedSql) > 0 then
    begin
      Q380St.DeclareVariable('C700FILTRO',otSubst);
      Q380St.SetVariable('C700FILTRO',OldC700Filtro);
      if OldC700Filtro.IndexOf(':DATALAVORO') >= 0 then
        Q380St.DeclareAndSet('DATALAVORO',otDate,Parametri.DataLavoro);
    end;
    if RaggrDatiAgg then
    begin
      TestoQuery2:=UpperCase(Q380St.Sql.Text);
      Q380St.SQL.Clear;
      Q380St.SQL.Add('SELECT * FROM (');
      Q380St.SQL.Add(TestoQuery2);
      Q380St.SQL.Add(') WHERE (');
      App:='';
      NG:=R180GiorniMese(A040MW.DataSt);
      for i:=1 to NG do
        for iT:=1 to 3 do
          App:=App + 'TURNO' + IntToStr(iT) + '_' + NumLet[i] + ' IS NOT NULL OR ';
      App:=Copy(App,1,Length(App) - 4);
      Q380St.SQL.Add(App);
      Q380St.SQL.Add(')');
    end;
    Q380St.Close;
    Q380St.Open;
  end;
end;

end.
