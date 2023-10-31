unit A207UProfiliStampeRep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R001UGESTTAB, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Mask, StrUtils, Math, Generics.Collections,OracleData,
  C180FunzioniGenerali, A000UInterfaccia, A000USessione, A000UMessaggi,
  A207UProfiliStampeRepDTM, QRPrntr;

type
  TA207FProfiliStampeRep = class(TR001FGestTab)
    grpDettaglioTabellone: TGroupBox;
    grpDatiPianif: TGroupBox;
    dchkCodice: TDBCheckBox;
    dchkSigla: TDBCheckBox;
    dchkDatoLibero: TDBCheckBox;
    dchkDatiAggInRiga: TDBCheckBox;
    dchkDatiAggiuntivi: TDBCheckBox;
    dchkOrarioInRiga: TDBCheckBox;
    dchkOrario: TDBCheckBox;
    dchkPriorita: TDBCheckBox;
    drgpDatiAssenza: TDBRadioGroup;
    dedtSiglaAssenza: TDBEdit;
    pnlOpzioniTabellone: TPanel;
    dchkLegenda: TDBCheckBox;
    dchkIncludiNonPianif: TDBCheckBox;
    pnlCampoDettaglio: TPanel;
    dcmbCampoDett: TDBLookupComboBox;
    pnlCampoConNominativo: TPanel;
    lblCampoConNom: TLabel;
    dcmbCampoConNom: TDBLookupComboBox;
    dchkNomeCompleto: TDBCheckBox;
    pnlSceltaTurni: TPanel;
    lblTurni: TLabel;
    btnScegliTurni: TButton;
    drgpSelTurni: TDBRadioGroup;
    dedtTurni: TDBEdit;
    pnlRaggruppamento: TPanel;
    lblCampoRaggr: TLabel;
    dcmbCampoRaggr: TDBLookupComboBox;
    dchkSaltoPagina: TDBCheckBox;
    pnlTop: TPanel;
    drgpTipoStampa: TDBRadioGroup;
    grpTitolo: TGroupBox;
    lblTitolo: TLabel;
    Label1: TLabel;
    dedtTitolo: TDBEdit;
    dEdtTitoloSize: TDBEdit;
    dchkTitoloBold: TDBCheckBox;
    dchkTitoloUnderline: TDBCheckBox;
    Panel2: TPanel;
    lblCodProfilo: TLabel;
    lblDescProfilo: TLabel;
    dEdtCodice: TDBEdit;
    dEdtDesc: TDBEdit;
    grpLayout: TGroupBox;
    Label2: TLabel;
    lblDimensione: TLabel;
    lblOPagina: TLabel;
    dcmbOrientamento: TDBComboBox;
    dcmbFont: TDBComboBox;
    dedtSize: TDBEdit;
    Label4: TLabel;
    lblEsempio: TLabel;
    lblFormato: TLabel;
    dcmbFormato: TDBComboBox;
    drgpDettaglio: TDBRadioGroup;
    procedure drgpTipoStampaClick(Sender: TObject);
    procedure drgpDatiAssenzaClick(Sender: TObject);
    procedure dcmbCampoRaggrClick(Sender: TObject);
    procedure dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnScegliTurniClick(Sender: TObject);
    procedure drgpSelTurniClick(Sender: TObject);
    procedure dchkCodiceClick(Sender: TObject);
    procedure dchkOrarioClick(Sender: TObject);
    procedure dchkDatiAggiuntiviClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dcmbOrientamentoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure dcmbFontChange(Sender: TObject);
    procedure TAnnullaClick(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure TInserClick(Sender: TObject);
    procedure drgpDettaglioChange(Sender: TObject);
  private
    { Private declarations }
    procedure Abilitazioni;
    procedure AggiornaFontEsempio;
    procedure CorreggiTitolo;
    procedure CaricaFont;
    procedure Visualizzazioni;
  public
    { Public declarations }
    A207DM: TA207FProfiliStampeRepDTM;
  end;

var
  A207FProfiliStampeRep: TA207FProfiliStampeRep;

  procedure OpenA207ProfiliStampeRep(Profilo:String = '');

implementation
uses C013UCheckList;

{$R *.dfm}

procedure OpenA207ProfiliStampeRep(Profilo:String = '');
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA207ProfiliStampeRep') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A207FProfiliStampeRep:=TA207FProfiliStampeRep.Create(nil);
  try
    if Trim(Profilo) <> '' then
      A207FProfiliStampeRep.A207DM.selT355.SearchRecord('CODICE',Profilo,[srFromBeginning]);
    A207FProfiliStampeRep.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A207FProfiliStampeRep);
  end;
end;

procedure TA207FProfiliStampeRep.Abilitazioni;
begin
  dcmbFont.Enabled:=DButton.State in [dsInsert,dsEdit];
  dcmbOrientamento.Enabled:=DButton.State in [dsInsert,dsEdit];
  dcmbFormato.Enabled:=DButton.State in [dsInsert,dsEdit];
  btnScegliTurni.Enabled:=DButton.State in [dsInsert,dsEdit];
end;

procedure TA207FProfiliStampeRep.AggiornaFontEsempio;
begin
  lblEsempio.Font.Name:=dcmbFont.Text;
end;

procedure TA207FProfiliStampeRep.btnScegliTurniClick(Sender: TObject);
var Elem: String;
    LenCod: Integer;
begin
  inherited;
  // apre dataset dei turni da visualizzare
  with A207DM.A040MW do
  begin
    RecuperaTurni(drgpSelTurni.ItemIndex);
    LenCod:=IfThen(drgpSelTurni.ItemIndex = 0,5,11);
    C013FCheckList:=TC013FCheckList.Create(nil);
    try
      with C013FCheckList do
      begin
        if drgpTipoStampa.ItemIndex = 2 then
          MaxElem:=MAX_CODICI;
        clbListaDati.Items.BeginUpdate;
        clbListaDati.Items.Clear;
        selT350Cod.First;
        while not selT350Cod.Eof do
        begin
          if drgpSelTurni.ItemIndex = 0 then
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
        R180PutCheckList(dedtTurni.Text,LenCod,clbListaDati);
        if ShowModal = mrOK then
          dedtTurni.Text:=R180GetCheckList(LenCod,clbListaDati);
      end;
    finally
      C013FCheckList.Free;
    end;
  end;
end;

procedure TA207FProfiliStampeRep.CorreggiTitolo;
// rimuove la data dal titolo per evitare disallineamenti
var
  LTitolo: string;
begin
  if drgpTipoStampa.ItemIndex = 0 then
    Exit;

  // verifica se il titolo è quello fisso
  LTitolo:=dedtTitolo.Text;
  if LTitolo.StartsWith('Turni di ' + A207DM.A040MW.sTipo + ' del mese di: ') then
  begin
    DButton.DataSet.FieldByName('TITOLO').AsString:='Turni di ' + A207DM.A040MW.sTipo;
  end;
end;

procedure TA207FProfiliStampeRep.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  Visualizzazioni;
end;

procedure TA207FProfiliStampeRep.DButtonStateChange(Sender: TObject);
begin
  inherited;
  Abilitazioni;

end;

procedure TA207FProfiliStampeRep.dchkCodiceClick(Sender: TObject);
begin
  inherited;
  dchkSigla.Enabled:=dchkCodice.Checked;
  if not dchkSigla.Enabled then
    dchkSigla.Checked:=False;
  dchkPriorita.Enabled:=dchkCodice.Checked;
  if not dchkPriorita.Enabled then
    dchkPriorita.Checked:=False;
end;

procedure TA207FProfiliStampeRep.dchkDatiAggiuntiviClick(Sender: TObject);
begin
  inherited;
  dchkDatiAggInRiga.Enabled:=dchkDatiAggiuntivi.Checked;
  if not dchkDatiAggInRiga.Enabled then
    dchkDatiAggInRiga.Checked:=False;
end;

procedure TA207FProfiliStampeRep.dchkOrarioClick(Sender: TObject);
begin
  inherited;
  dchkOrarioInRiga.Enabled:=dchkOrario.Checked;
  if not dchkOrarioInRiga.Enabled then
    dchkOrarioInRiga.Checked:=False;
end;

procedure TA207FProfiliStampeRep.dcmbCampoRaggrClick(Sender: TObject);
begin
  inherited;
  if ((drgpTipostampa.ItemIndex <> 1) and (drgpTipostampa.ItemIndex <> 2)) or
     (VarToStr(TDBLookupComboBox(Sender).KeyValue) = '') then
  begin
    dchkSaltoPagina.Checked:=False;
    dchkSaltoPagina.Enabled:=False;
  end
  else
    dchkSaltoPagina.Enabled:=True;
end;

procedure TA207FProfiliStampeRep.dcmbCampoRaggrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    TDBLookupComboBox(Sender).KeyValue:='';
    if TDBLookupComboBox(Sender).Field <> nil then
      TDBLookupComboBox(Sender).Field.Clear;
    if Sender = dcmbCampoRaggr then
    begin
      dchkSaltoPagina.Checked:=False;
      dchkSaltoPagina.Enabled:=False;
    end;
  end;
end;

procedure TA207FProfiliStampeRep.dcmbFontChange(Sender: TObject);
begin
  inherited;
  AggiornaFontEsempio;
end;

procedure TA207FProfiliStampeRep.dcmbOrientamentoDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  (Control as TDBComboBox).Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top,A207DM.A040MW.Orientamento[Index].Item);
end;

procedure TA207FProfiliStampeRep.drgpDatiAssenzaClick(Sender: TObject);
begin
  inherited;
  dedtSiglaAssenza.Enabled:=(drgpDatiAssenza.Values[drgpDatiAssenza.ItemIndex] = 'S') and (DButton.State in [dsEdit,dsInsert]);
end;

procedure TA207FProfiliStampeRep.drgpDettaglioChange(Sender: TObject);
begin
  inherited;
  dcmbCampoDett.Enabled:=drgpDettaglio.ItemIndex = 0;
end;

procedure TA207FProfiliStampeRep.drgpSelTurniClick(Sender: TObject);
begin
  inherited;
  dedtTurni.Text:='';
end;

procedure TA207FProfiliStampeRep.drgpTipoStampaClick(Sender: TObject);
begin
  inherited;
  case drgpTipoStampa.ItemIndex of
  0: begin
       // tabellone mensile
       DButton.DataSet.FieldByName('TITOLO').AsString:='Turni di ' + A207DM.A040MW.sTipo + ' del mese di: ';
     end;
  1: begin
       // tabellone personalizzato
       drgpDatiAssenzaClick(nil);
     end;
  2: begin
       // prospetto per dipendente
       if R180NumOccorrenzeCar(dedtTurni.Text,',') >= 4 then
         dedtTurni.Text:='';
     end;
  3: begin
       // prospetto orizzontale
     end;
  end;

  // imposta il titolo nel caso la stampa non sia il tabellone mensile (che ha titolo fisso)
  if drgpTipoStampa.ItemIndex > 0 then
    CorreggiTitolo;

  Visualizzazioni;
end;

procedure TA207FProfiliStampeRep.FormActivate(Sender: TObject);
begin
  inherited;
  drgpTipoStampaClick(nil);
  OnActivate:=nil;
end;

procedure TA207FProfiliStampeRep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  OnActivate:=FormActivate;
end;

procedure TA207FProfiliStampeRep.FormCreate(Sender: TObject);
begin
  inherited;
  R180SetComboItemsValues(dCmbOrientamento.Items,A207DM.A040MW.Orientamento,'V');
  CaricaFont;
  A207DM:=TA207FProfiliStampeRepDTM.Create(Self);
end;

procedure TA207FProfiliStampeRep.FormDestroy(Sender: TObject);
begin
  if A207DM <> nil then
   FreeAndNil(A207DM);
  inherited;
end;

procedure TA207FProfiliStampeRep.FormShow(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A207DM.selT355;
  dcmbCampoRaggr.ListSource:=A207DM.A040MW.D010;
  dcmbCampoDett.ListSource:=A207DM.A040MW.D010B;
  dcmbCampoConNom.ListSource:=A207DM.A040MW.D010C;

  // priorità
  dchkPriorita.Visible:=A207DM.A040MW.CodTipologia = 'R';
  // dati aggiuntivi
  dchkDatiAggiuntivi.Visible:=(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1 <> '') and (A207DM.A040MW.CodTipologia = 'R');
  dchkDatiAggInRiga.Visible:=dchkDatiAggiuntivi.Visible and (Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2 <> '');
  // dato libero pianif. (nascosto se gestisco dati aggiuntivi)
  dchkDatoLibero.Visible:=(Parametri.CampiRiferimento.C3_DatoPianificabile <> '') and not dchkDatiAggiuntivi.Visible;
  dchkDatoLibero.Caption:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile) + ' pianificato';
  dchkDatoLibero.Top:=dchkDatiAggiuntivi.Top;
  dchkDatoLibero.Left:=dchkDatiAggiuntivi.Left;
  AggiornaFontEsempio;
end;

procedure TA207FProfiliStampeRep.TAnnullaClick(Sender: TObject);
begin
  inherited;
  AggiornaFontEsempio;
end;

procedure TA207FProfiliStampeRep.TInserClick(Sender: TObject);
begin
  inherited;
  drgpTipoStampaClick(drgpTipoStampa);
end;

procedure TA207FProfiliStampeRep.Visualizzazioni;
begin
  dedtTitolo.Enabled:=drgpTipoStampa.ItemIndex <> 0;
// reimposta visualizzazione pannelli
  pnlRaggruppamento.Visible:=False;
  pnlSceltaTurni.Visible:=False;
  pnlCampoConNominativo.Visible:=False;
  pnlOpzioniTabellone.Visible:=False;
  grpDettaglioTabellone.Visible:=False;
  pnlCampoDettaglio.Visible:=False;
  pnlRaggruppamento.Align:=alNone;
  pnlSceltaTurni.Align:=alNone;
  pnlCampoConNominativo.Align:=alNone;
  pnlOpzioniTabellone.Align:=alNone;
  grpDettaglioTabellone.Align:=alNone;
  pnlCampoDettaglio.Align:=alNone;
  // visualizza pannelli in base al tipo stampa
  pnlRaggruppamento.Visible:=True;
  if pnlRaggruppamento.Visible then
    pnlRaggruppamento.Align:=alTop;
  // scelta turni
  pnlSceltaTurni.Visible:=drgpTipoStampa.ItemIndex > 0;
  if pnlSceltaTurni.Visible then
    pnlSceltaTurni.Align:=alTop;
  // campo con nominativo
  pnlCampoConNominativo.Visible:=drgpTipoStampa.ItemIndex in [1,2];
  if pnlCampoConNominativo.Visible then
    pnlCampoConNominativo.Align:=alTop;
  // opzioni tabellone
  pnlOpzioniTabellone.Visible:=drgpTipoStampa.ItemIndex = 1;
  if pnlOpzioniTabellone.Visible then
    pnlOpzioniTabellone.Align:=alTop;
  // dettaglio cella tabellone
  grpDettaglioTabellone.Visible:=drgpTipoStampa.ItemIndex = 1;
  if grpDettaglioTabellone.Visible then
    grpDettaglioTabellone.Align:=alTop;
  // campo di dettaglio anagrafico
  pnlCampoDettaglio.Visible:=drgpTipoStampa.ItemIndex = 2;
  if pnlCampoDettaglio.Visible then
    pnlCampoDettaglio.Align:=alTop;

  // abilita salto pagina in base a selezione
  dchkSaltoPagina.Enabled:=((drgpTipostampa.ItemIndex = 1) or (drgpTipostampa.ItemIndex = 2)) and
                          (VarToStr(dcmbCampoRaggr.KeyValue) <> '');
  if not dchkSaltoPagina.Enabled then
    dchkSaltoPagina.Checked:=False;
end;

procedure TA207FProfiliStampeRep.CaricaFont;
var
  lstFonts: TStringLIst;
  FontName, s: String;
  Found: Boolean;
  ps: TQRPaperSize;
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

    dcmbFont.Items.Clear;
    for s in lstFonts do
      dcmbFont.Items.Add(s);

    dcmbFormato.Items.Clear;
    dcmbFormato.Items.Add('(non impostato)');
    for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
      dcmbFormato.Items.Add(QRPaperName(ps));

  finally
    FreeAndNil(lstFonts);
  end;
end;


end.
