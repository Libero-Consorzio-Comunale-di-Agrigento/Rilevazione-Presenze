unit WR003UGeneratoreStampeDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox, Data.DB,
  A000UInterfaccia, IWCompListbox, meIWComboBox, WR003UGeneratoreStampeDM,
  meIWListbox, IWCompTabControl, meIWTabControl, IWCompGrids, meIWGrid,
  medpIWTabControl, meIWRegion, Vcl.Menus, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup,Generics.collections, medpIWMultiColumnComboBox,
  meIWDBComboBox, IWMultiColumnComboBox, qrprntr,
  meIWDBLookupComboBox, IWApplication, IWCompButton, meIWButton, IWDBGrids,
  medpIWDBGrid, A000UMessaggi, C180FunzioniGenerali, WC013UCheckListFM,
  IWCompMemo, meIWMemo, WR003UFormatoFM, meIWEdit, C190FunzioniGeneraliWeb,
  R003UGeneratoreStampeMW, System.StrUtils, meIWCheckBox, meIWImageFile,
  meIWLink, IWHTMLControls, medpIWImageButton, WR003UProprietaDatiFM,
  Datasnap.DBClient, medpIWMessageDlg, WR003UGeneratoreStampe, meIWRadioGroup,
  A000UCostanti, WR100UBase, meTIWCheckListBox, System.Math;

type
  TWR003FGeneratoreStampeDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtTitolo: TmeIWDBEdit;
    lblTitolo: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    dChkStampaBloccata: TmeIWDBCheckBox;
    cmbSerbatoi: TmeIWComboBox;
    grdTabDetail: TmedpIWTabControl;
    lstDatiSerbatoio: TmeIWListbox;
    TemplateGeneraleRG: TIWTemplateProcessorHTML;
    TemplateOrdinamentoRG: TIWTemplateProcessorHTML;
    WR003GeneraleRG: TmeIWRegion;
    WR003OrdinamentoRG: TmeIWRegion;
    WR003AreaStampaRG: TmeIWRegion;
    TemplateAreaStampaRG: TIWTemplateProcessorHTML;
    WR003CodiciSerbatoioRG: TmeIWRegion;
    TemplateCodiciSerbatoioRG: TIWTemplateProcessorHTML;
    WR003FiltroSerbatoioRG: TmeIWRegion;
    TemplateFiltroSerbatoioRG: TIWTemplateProcessorHTML;
    WR003DettaglioSerbatoioRG: TmeIWRegion;
    MainMenu1: TMainMenu;
    TemplateDettaglioSerbatoioRG: TIWTemplateProcessorHTML;
    drgpTipoStampa: TmeIWDBRadioGroup;
    lblTipoStampa: TmeIWLabel;
    dchkNomeAzienda: TmeIWDBCheckBox;
    lblIntestazione: TmeIWLabel;
    dchkTitoloStampa: TmeIWDBCheckBox;
    dchkPeriodoSelezionato: TmeIWDBCheckBox;
    dchkDataCorrente: TmeIWDBCheckBox;
    dchkNumeroPagina: TmeIWDBCheckBox;
    lblStruttura: TmeIWLabel;
    dchkSepRiga: TmeIWDBCheckBox;
    dchkSepCol: TmeIWDBCheckBox;
    dchkIntestazioneCol: TmeIWDBCheckBox;
    dchkSoloTotali: TmeIWDBCheckBox;
    dchkSaltoPagina: TmeIWDBCheckBox;
    dchkTotParziali: TmeIWDBCheckBox;
    dchkTotRiepilogo: TmeIWDBCheckBox;
    dchkTotGenerali: TmeIWDBCheckBox;
    dchkSaltoPaginaTotali: TmeIWDBCheckBox;
    lblVarie: TmeIWLabel;
    dchkValoreNullo: TmeIWDBCheckBox;
    dchkPeriodoStorico: TmeIWDBCheckBox;
    dchkFiltriEsclusivi: TmeIWDBCheckBox;
    dchkCDCPercentualizzati: TmeIWDBCheckBox;
    lblDipendenti: TmeIWLabel;
    drgpFiltroInServizio: TmeIWDBRadioGroup;
    lblFont: TmeIWLabel;
    cmbFontSize: TMedpIWMultiColumnComboBox;
    cmbFontName: TMedpIWMultiColumnComboBox;
    cmbOrientamentoPag: TMedpIWMultiColumnComboBox;
    lblOrientamentoPag: TmeIWLabel;
    cmbFormatoPag: TMedpIWMultiColumnComboBox;
    lblFormatoPag: TmeIWLabel;
    dcmbQueryIntestazione: TmeIWDBLookupComboBox;
    lblQueryIntestazione: TmeIWLabel;
    dcmbQueryFineStampa: TmeIWDBLookupComboBox;
    lblQueryFineStampa: TmeIWLabel;
    lblGeneraTabella: TmeIWLabel;
    dedtTabellaStampa: TmeIWDBEdit;
    lblTabellaStampa: TmeIWLabel;
    lblChiavi: TmeIWLabel;
    dedtChiavi: TmeIWDBEdit;
    btnChiavi: TmeIWButton;
    grdAreaStampaIntestazione: TmedpIWDBGrid;
    grdAreaStampaDettaglio: TmedpIWDBGrid;
    lblAreaStampaIntestazione: TmeIWLabel;
    lblAreaStampaDettaglio: TmeIWLabel;
    dgrpRicreaTabella: TmeIWDBRadioGroup;
    lblDelete: TmeIWLabel;
    dedtDelete: TmeIWDBEdit;
    btnDelete: TmeIWButton;
    edtTabCaretPosition: TmeIWEdit;
    grdOrdinamento: TmeIWGrid;
    btnAggiungiSerbatoio: TmeIWButton;
    pmnAreaStampa: TPopupMenu;
    mnuAggiungiIntestazione: TMenuItem;
    muAggiungiDettaglio: TMenuItem;
    chkFiltroEsclusivo: TmeIWCheckBox;
    cmbDatoDalAl: TMedpIWMultiColumnComboBox;
    lblDatoDalAl: TmeIWLabel;
    memFiltro: TmeIWMemo;
    memRiepilogoFiltri: TmeIWMemo;
    edtFiltroCaretPosition: TmeIWEdit;
    grdKeyCumulo: TmeIWGrid;
    memRiepilogoKeyCumulo: TmeIWMemo;
    pmnDatiCalcolati: TPopupMenu;
    mnuDatiCalcolati: TMenuItem;
    mnuDatiCalcolati1: TMenuItem;
    pmnListaCodici: TPopupMenu;
    mnuElementiSelezionatiInAlto: TMenuItem;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    edtRicercaTesto: TmeIWEdit;
    btnRicercaSu: TmeIWImageFile;
    btnRicercaGiu: TmeIWImageFile;
    edtAlleOre: TmeIWEdit;
    lblAlleOre: TmeIWLabel;
    edtDalleOre: TmeIWEdit;
    lblDalleOre: TmeIWLabel;
    dchkRotturaPeriodiNonContigui: TmeIWDBCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbSerbatoiChange(Sender: TObject);
    procedure drgpTipoStampaClick(Sender: TObject);
    procedure dchkTotRiepilogoAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure btnChiaviClick(Sender: TObject);
    procedure dgrpRicreaTabellaClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure grdOrdinamentoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure lstDatiSerbatoioDblClick(Sender: TObject);
    procedure btnAggiungiSerbatoioClick(Sender: TObject);
    procedure grdAreaStampaIntestazioneDataSet2Componenti(Row: Integer);
    procedure grdAreaStampaDettaglioDataSet2Componenti(Row: Integer);
    procedure grdAreaStampaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    function grdAreaStampaIntestazioneBeforeModifica(Sender: TObject): Boolean;
    procedure grdAreaStampaIntestazioneAnnulla(Sender: TObject);
    function grdAreaStampaDettaglioBeforeModifica(Sender: TObject): Boolean;
    procedure grdAreaStampaDettaglioAnnulla(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure mnuAggiungiIntestazioneClick(Sender: TObject);
    procedure muAggiungiDettaglioClick(Sender: TObject);
    procedure chkFiltroEsclusivoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure cmbDatoDalAlAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure memFiltroAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure grdKeyCumuloRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure mnuDatiCalcolatiClick(Sender: TObject);
    procedure mnuElementiSelezionatiInAltoClick(Sender: TObject);
    function grdAreaStampaBeforeCancella(Sender: TObject): Boolean;
    procedure grdAreaStampaIntestazioneComponenti2DataSet(Row: Integer);
    procedure grdAreaStampaDettaglioComponenti2DataSet(Row: Integer);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure edtRicercaTestoAsyncKeyUp(Sender: TObject; EventParams: TStringList);
    procedure btnRicercaSuAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnRicercaGiuAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    WC013: TWC013FCheckListFM;
    lstSystemFonts: TList<String>;
    PIntestazione,PDettaglio: Integer;
    SaveProprietaDatoIntestazione,
    SaveProprietaDatoDettaglio: TRiep;
    procedure GetDati;
    procedure CreaDatiDiStampa;
    procedure CampiChiaveResult(Sender: TObject; Result: Boolean);
    procedure FormatoResult(Sender: TObject; Result: Boolean; Val: String);
    procedure CaricaGrdOrdinamento;
    procedure chkOrdinamentoDiscendenteAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure chkRotturaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure spostaSuLinkClick(Sender: TObject);
    procedure spostaGiuLinkClick(Sender: TObject);
    procedure ImpostaGrdCampo(var grdCampo: TmeIWGrid; NomeCampo: String;
      idx: Integer; Edit: Boolean);
    procedure RimuoviLinkClick(Sender: TObject);
    procedure AggiungiSerbatoioOrdinamento;
    procedure PreparaComponentiGrid(grd: TMedpIWDBGrid);
    procedure imgProprietaClick(Sender: TObject);
    procedure mnuAreaStampa;
    procedure AggiungiSerbatoioAreaStampa(dest: Integer);
    procedure setValoreOpzioneAvanzata(Opz, Valore: String);
    procedure VisualizzaFiltri;
    procedure AggiungiSerbatoioFiltro;
    procedure AttivaCodiciSerbatoi;
    procedure CaricaGrdKeyCumulo(idx: Integer);
    procedure ImpostaGrdCampoDettSerb(var grdCampo: TmeIWGrid;
      NomeCampo: String; idx: Integer; Edit: Boolean);
    procedure chkTotaleDettSerbClick(Sender: TObject; EventParams: TStringList);
    procedure RefreshKeyCumuloGlobale;
    procedure spostaSuDettSerbLinkClick(Sender: TObject);
    procedure spostaGiuDettSerbLinkClick(Sender: TObject);
    procedure RimuoviDettSerbLinkClick(Sender: TObject);
    procedure AggiungiDettaglioSerbatoio;
    procedure chklstElementiInAlto(Sender: TmeTIWCheckListBox);
    procedure chklstResetElementiInAlto(Sender: TmeTIWCheckListBox);
    procedure chklstCodiciAsyncClick(Sender: TObject; EventParams: TStringList);
  protected
    procedure CheckAll(chklst: TmeTIWCheckListBox; Val: Boolean);
    procedure grdAreaDatiDettaglioRowClick;
    procedure grdAreaDatiIntestazioneRowClick;
    function getControlOpzioneAvanzata(Val: String): TControl; virtual; abstract;
    procedure CaricaCheckListCodici(chk: TmeTIWChecklistBox); virtual; abstract;
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure ReleaseOggetti; override;
    procedure CaricaMultiColumnCombobox; override;
    function getValoreOpzioneAvanzata(Opz: String): String;
    function getCheckListBoxTabellaCollegata(M: Integer): TListaCodici; virtual;abstract;
    procedure CaricaLstDatiSerbatoio;
  end;

implementation

const
  NONIMPOSTATO='(non impostato)';
  VERTICALE='Verticale';
  ORIZZONTALE='Orizzontale';

{$R *.dfm}

{ TWR003FGeneratoreStampeDettFM }

procedure TWR003FGeneratoreStampeDettFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
  sJs: string;
  ListaCodici: TListaCodici;
begin
  lstSystemFonts:=TList<String>.Create;
  LoadFontList(lstSystemFonts);
 //Non spostare dopo inherited perchè richiama Dataset2Componenti e deve già essere stato eseguito medpAttivaGrid
  with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    grdAreaStampaIntestazione.medpAttivaGrid(cdsDatiIntestazione,False,False,False);
    grdAreaStampaDettaglio.medpAttivaGrid(cdsDatiDettaglio,False,False,False);
    PreparaComponentiGrid(grdAreaStampaIntestazione);
    PreparaComponentiGrid(grdAreaStampaDettaglio);
    grdAreaStampaDettaglio.OnRowClick:=grdAreaDatiDettaglioRowClick;
    grdAreaStampaIntestazione.OnRowClick:=grdAreaDatiIntestazioneRowClick;
    //devo aggiungere click su ogni checklist di codice serbatoio
  end;
  inherited;

  grdTabDetail.AggiungiTab('Generale',WR003GeneraleRG);
  grdTabDetail.AggiungiTab('Ordinamento',WR003OrdinamentoRG);
  grdTabDetail.AggiungiTab('Area stampa',WR003AreaStampaRG);
  grdTabDetail.AggiungiTab('Codici serbatoio',WR003CodiciSerbatoioRG);
  grdTabDetail.AggiungiTab('Filtro serbatoio',WR003FiltroSerbatoioRG);
  grdTabDetail.AggiungiTab('Dettaglio serbatoio',WR003DettaglioSerbatoioRG);
  grdTabDetail.ActiveTab:=WR003GeneraleRG;
  GetDati;

  dcmbQueryIntestazione.ListSource:=(WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.dsrT002;
  dcmbQueryFineStampa.ListSource:=(WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.dsrT002;
  //Eventi javascript
  sJs:='$("#' + edtTabCaretPosition.HTMLName + '").val($("#' + dedtDelete.HTMLName+ '").caret().end + 1);';
  btnDelete.ScriptEvents.HookEvent('OnClick', sJs);
  sJs:='if ($("#' + memFiltro.HTMLName+ '").length > 0) {$("#' + edtFiltroCaretPosition.HTMLName + '").val($("#' + memFiltro.HTMLName+ '").caret().end + 1);}';
  lstDatiSerbatoio.ScriptEvents.HookEvent('OnDblClick', sJs);
  btnAggiungiSerbatoio.ScriptEvents.HookEvent('OnClick', sJs);
end;

procedure TWR003FGeneratoreStampeDettFM.PreparaComponentiGrid(grd: TMedpIWDBGrid);
begin
  //Si aggiunge +1 perchè in modifica compare la colonna con i bottoni di editing
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('CAPTION') + 1,0,DBG_EDT,'','','','','S');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('TOP') + 1,0,DBG_EDT,'input_num_nnnn','','','','D');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('LEFT') + 1,0,DBG_EDT,'input_num_nnnn','','','','D');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('HEIGHT') + 1,0,DBG_EDT,'input_num_nnn','','','','D');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('WIDTH') + 1,0,DBG_EDT,'input_num_nnn','','','','D');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('TOTALE') + 1,0,DBG_CHK,'','','','','S');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('FITTIZIO') + 1,0,DBG_IMG,'','CAMBIADATO','','','C');
end;

procedure TWR003FGeneratoreStampeDettFM.lstDatiSerbatoioDblClick(
  Sender: TObject);
begin
  inherited;
  btnAggiungiSerbatoioClick(nil);
end;

procedure TWR003FGeneratoreStampeDettFM.CreaDatiDiStampa;
var
  aCompIntestazione,
  aCompDettaglio: Array of String;
  i:Integer;
  bmIntestazione,
  bmDettaglio: TBookmark;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    bmIntestazione:=cdsDatiIntestazione.GetBookmark;
    bmDettaglio:=cdsDatiDettaglio.GetBookmark;
    try
      if (cdsDatiIntestazione.RecordCount = 0) and (cdsDatiDettaglio.RecordCount = 0) then
        raise Exception.Create(A000MSG_R003_ERR_NO_DATO_STAMPA);

      SetLength(aCompIntestazione,cdsDatiIntestazione.RecordCount);
      cdsDatiIntestazione.First;
      i:=0;
      while not cdsDatiIntestazione.Eof do
      begin
        aCompIntestazione[i]:=Identificatore(cdsDatiIntestazione.FieldByName('NOME').AsString);
        i:=i+1;
        cdsDatiIntestazione.Next;
      end;
      cdsDatiIntestazione.GotoBookmark(bmIntestazione);


      SetLength(aCompDettaglio,cdsDatiDettaglio.RecordCount);
      cdsDatiDettaglio.First;
      i:=0;
      while not cdsDatiDettaglio.Eof do
      begin
        aCompDettaglio[i]:=Identificatore(cdsDatiDettaglio.FieldByName('NOME').AsString);
        i:=i+1;
        cdsDatiDettaglio.Next;
      end;
      cdsDatiDettaglio.GotoBookmark(bmDettaglio);
    finally
      cdsDatiIntestazione.FreeBookmark(bmIntestazione);
      cdsDatiDettaglio.FreeBookmark(bmDettaglio);
    end;

    R003FGeneratoreStampeMW.CaricaDatiDiStampa(aCompIntestazione,aCompDettaglio);
    SetLength(aCompIntestazione,0);
    SetLength(aCompDettaglio,0);
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.AggiungiSerbatoioOrdinamento;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    if lstDatiSerbatoio.ItemIndex >= 0 then
      if R003FGeneratoreStampeMW.AggiungiOrdinamento(lstDatiSerbatoio.SelectedValue) then
        caricaGrdOrdinamento;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.AggiungiSerbatoioFiltro;
var
  nCRLF,RP: Integer;
  Tmp: String;
begin
  RP:=StrToIntDef(edtFiltroCaretPosition.Text,0);
  Tmp:=memFiltro.Text;
  //devo contare i ritorni a capo perchè contati come 1 carattere ma nella propietà text sono 2 (#13#10)
  nCRLF:=R180NumOccorrenzeString(#13#10,Copy(Tmp,0,RP));
  Insert(Identificatore(lstDatiSerbatoio.SelectedValue),Tmp,RP + nCRLF);
  memFiltro.Text:=Tmp;
  memFiltroAsyncChange(nil,nil);
end;

procedure TWR003FGeneratoreStampeDettFM.AggiungiDettaglioSerbatoio;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  if AggiungiDettaglioSerbatoio(cmbSerbatoi.ItemIndex,lstDatiSerbatoio.SelectedValue) then
    CaricaGrdKeyCumulo(cmbSerbatoi.ItemIndex);
end;

//0 Intestazione 1 dettaglio
procedure TWR003FGeneratoreStampeDettFM.AggiungiSerbatoioAreaStampa(dest: Integer);
var
  val: String;
  bFound: Boolean;
  P,MaxTopInt,HeightInt, MaxLeftDett, LarghDett, defTop, defLeft,defWidth,FontSize :Integer;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    if (cdsDatiIntestazione.state <> dsBrowse) or
       (cdsDatiDettaglio.state <> dsBrowse)  then
    begin
      MsgBox.WebMessageDlg(A000MSG_R003_ERR_AREA_STAMPA_PENDING,mtInformation,[mbOk],nil,'');
      Abort;
    end;

    val:=lstDatiSerbatoio.SelectedValue;
    MaxTopInt:=-1;
    HeightInt:=0;
    bFound:=False;
    cdsDatiIntestazione.First;
    while not cdsDatiIntestazione.eof do
    begin
      if cdsDatiIntestazione.FieldByName('NOME').AsString = val then
      begin
        bFound:=True;
        Break;
      end;
      if cdsDatiIntestazione.FieldByName('TOP').AsInteger > MaxTopInt then
      begin
        MaxTopInt:=cdsDatiIntestazione.FieldByName('TOP').AsInteger;
        HeightInt:=cdsDatiIntestazione.FieldByName('HEIGHT').AsInteger;
      end;

      cdsDatiIntestazione.Next;
    end;
    MaxLeftDett:=-1;
    LarghDett:=0;
    if not bFound then
    begin
      cdsDatiDettaglio.First;
      while not cdsDatiDettaglio.eof do
      begin
        if cdsDatiDettaglio.FieldByName('NOME').AsString = val then
        begin
          bFound:=True;
          Break;
        end;
        if cdsDatiDettaglio.FieldByName('LEFT').AsInteger > MaxLeftDett then
        begin
          MaxLeftDett:=cdsDatiDettaglio.FieldByName('LEFT').AsInteger;
          LarghDett:=cdsDatiDettaglio.FieldByName('WIDTH').AsInteger;
        end;

        cdsDatiDettaglio.Next;
      end;
    end;

    if not bFound then
    begin
      if dest = 0 then  //intestazione
      begin
        defLeft:=0;
        if MaxTopInt = -1 then
          defTop:=0
        else
          defTop:=MaxTopInt + HeightInt;
      end
      else
      begin
        defTop:=0;
        if MaxLeftDett = -1 then
          defLeft:=8
        else
          defLeft:=MaxLeftDett + LarghDett + 8;
      end;
      defWidth:=10;
      P:=R003FGeneratoreStampeMW.GetDato(val,False);
      if P >= 0 then
      begin
        defWidth:=R003FGeneratoreStampeMW.Dati[P].W;
        if defWidth = 0 then defWidth:=10;
        FontSize:=strToIntDef(cmbFontSize.Text,1);
        defWidth:=FontSize * defWidth;
        if (dest = 0) or (selTabella.FieldByName('TIPO').AsString = 'S') then
          defWidth:=defWidth + FontSize * Length(Val);
      end;
      AggiungiDatoAreaStampa(val,dest,defTop,defLeft,defWidth);
      if dest = 0 then  //intestazione
        grdAreaStampaIntestazione.medpAggiornaCDS(True)
      else
        grdAreaStampaDettaglio.medpAggiornaCDS(True);
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.btnAggiungiSerbatoioClick(
  Sender: TObject);
begin
  inherited;
  if not(WR302DM.selTabella.State in [dsEdit,dsInsert]) then
    Exit;
  if lstDatiSerbatoio.ItemIndex < 0  then
    Exit;

  if grdTabDetail.ActiveTab = WR003OrdinamentoRG then
    AggiungiSerbatoioOrdinamento
  else if grdTabDetail.ActiveTab = WR003AreaStampaRG then
    AggiungiSerbatoioAreaStampa(1)
  else if grdTabDetail.ActiveTab = WR003FiltroSerbatoioRG then
    AggiungiSerbatoioFiltro
  else if grdTabDetail.ActiveTab = WR003DettaglioSerbatoioRG then
    AggiungiDettaglioSerbatoio;
end;

procedure TWR003FGeneratoreStampeDettFM.btnChiaviClick(Sender: TObject);
var
  LstCod,
  LstDesc,
  LstSel: TStringList;
  i: Integer;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  CreaDatiDiStampa;

  LstCod:=TStringList.Create;
  LstDesc:=TStringList.Create;
  LstSel:=TStringList.Create;
  try
    with (WR302DM as TWR003FGeneratoreStampeDM) do
    begin
      for i:=low(R003FGeneratoreStampeMW.DatiStampa) to High(R003FGeneratoreStampeMW.DatiStampa) do
      begin
        lstDesc.Add(R003FGeneratoreStampeMW.DatiStampa[i].D);
        lstCod.Add(R003FGeneratoreStampeMW.DatiStampa[i].D);
      end;
      LstSel.CommaText:=SelTabella.FieldByName('TABELLA_GENERATA_KEY').AsString;
    end;
    lstDesc.Sort;
    lstCod.Sort;
    WC013.CaricaLista(LstDesc, LstCod);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=CampiChiaveResult;
    WC013.Visualizza(0,0,'<WC013> Campi chiave');
  finally
    FreeAndNil(LstSel);
    FreeAndNil(LstCod);
    FreeAndNil(LstDesc);
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.btnDeleteClick(Sender: TObject);
var
  WR003FormatoFM: TWR003FFormatoFM;
begin
  inherited;
  WR003FormatoFM:=TWR003FFormatoFM.Create(Self.Owner);
  WR003FormatoFM.UsaDato:=False;
  CreaDatiDiStampa;
  WR003FormatoFM.ResultEvent:=FormatoResult;
  WR003FormatoFM.Visualizza('Dati disponibili','Nome dato');
end;

procedure TWR003FGeneratoreStampeDettFM.btnRicercaGiuAsyncClick(Sender: TObject; EventParams: TStringList);
var i:Integer;
begin
  inherited;
  for i:=lstDatiSerbatoio.ItemIndex + 1 to lstDatiSerbatoio.Items.Count - 1 do
  begin
    if Pos(LowerCase(edtRicercaTesto.Text),LowerCase(lstDatiSerbatoio.Items[i])) > 0 then
    begin
      lstDatiSerbatoio.ItemIndex:=i;
      Break;
    end;
  end;
  edtRicercaTesto.SetFocus;
end;

procedure TWR003FGeneratoreStampeDettFM.btnRicercaSuAsyncClick(Sender: TObject; EventParams: TStringList);
var i:Integer;
begin
  inherited;
  for i:=lstdatiSerbatoio.ItemIndex - 1 downto 0 do
  begin
    if Pos(LowerCase(edtRicercaTesto.Text),LowerCase(lstdatiSerbatoio.Items[i])) > 0 then
    begin
      lstdatiSerbatoio.ItemIndex:=i;
      Break;
    end;
  end;
  edtRicercaTesto.SetFocus;
end;

procedure TWR003FGeneratoreStampeDettFM.FormatoResult(Sender: TObject; Result: Boolean; Val: String);
var
  Tmp: String;
begin
  if Result then
  begin
    with (WR302DM as TWR003FGeneratoreStampeDM) do
    begin
      Tmp:=SelTabella.FieldByName('TABELLA_GENERATA_DELETE').AsString;
      Insert(Val,Tmp,StrToIntDef(edttabCaretPosition.Text,0));
      SelTabella.FieldByName('TABELLA_GENERATA_DELETE').AsString:=Tmp;
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.CampiChiaveResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    (WR302DM as TWR003FGeneratoreStampeDM).SelTabella.FieldByName('TABELLA_GENERATA_KEY').AsString:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.CaricaMultiColumnCombobox;
var
  lstFonts: TList<String>;
  FontName, s: String;
  Found: boolean;
  i: Integer;
  ps: TQRPaperSize;
begin
  cmbFontSize.Items.Clear;
  for i:=8 to 30 do
    cmbFontSize.AddRow(i.toString);

  //fonts
  lstFonts:=TList<String>.Create(lstSystemFonts);
  try
    //se font preimpostato non trovato nella lista lo aggiungo
    FontName:=WR302DM.selTabella.FieldByName('FONTNAME').asString;
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
  finally
    FreeAndNil(lstFonts);
  end;
  //Orientamento
  cmbOrientamentoPag.Items.Clear;
  cmbOrientamentoPag.AddRow(NONIMPOSTATO);
  cmbOrientamentoPag.AddRow(VERTICALE);
  cmbOrientamentoPag.AddRow(ORIZZONTALE);
  //Formato pagina
  cmbFormatoPag.Items.Clear;
  cmbFormatoPag.AddRow(NONIMPOSTATO);
  for ps:=Low(TQRPaperSize) to High(TQRPaperSize) do
    cmbFormatoPag.AddRow(QRPaperName(ps));
end;

procedure TWR003FGeneratoreStampeDettFM.cmbDatoDalAlAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM) do
    R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].DatoDalAl:=cmbDatoDalAl.Text;
end;

procedure TWR003FGeneratoreStampeDettFM.CaricaLstDatiSerbatoio;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    lstDatiSerbatoio.Items.Assign(Serbatoi[cmbSerbatoi.ItemIndex].lst);

  lstDatiSerbatoio.ItemIndex:=0;
end;

procedure TWR003FGeneratoreStampeDettFM.cmbSerbatoiChange(Sender: TObject);
var
  TabCodici: Boolean;
  TabDettSerbatoi: Boolean;
  i: Integer;
  ListaCodici: TListaCodici;
  lst: TStringList;
  s: String;
  idx: Integer;
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    //Caricamento serbatoio
    CaricaLstDatiSerbatoio;
    C190PulisciIWGrid(grdKeyCumulo,True);
    
    memFiltro.Text:=Serbatoi[cmbSerbatoi.ItemIndex].FiltroTxt;
    VisualizzaFiltri;
    chkFiltroEsclusivo.Checked:=Serbatoi[cmbSerbatoi.ItemIndex].Esclusivo;

    lblDatoDalAl.Visible:=False;
    cmbDatoDalAl.Visible:=False;
    cmbDatoDalAl.Items.Clear;
    cmbDatoDalAl.Text:='';
    idx:=IdxTabelleCollegateDaSerbatoi(cmbSerbatoi.ItemIndex);
    if (idx >= 0) and (TabelleCollegate[idx].DatiDalAl <> '') then
    begin
      lblDatoDalAl.Visible:=True;
      cmbDatoDalAl.Visible:=True;
      try
        lst:=TStringList.Create;
        lst.CommaText:=TabelleCollegate[idx].DatiDalAl;
        for s in lst do
          cmbDatoDalAl.AddRow(s);
      finally
        FreeAndNil(lst);
      end;
      cmbDatoDalAl.Text:=Serbatoi[cmbSerbatoi.ItemIndex].DatoDalAl
    end;

    TabCodici:=grdTabDetail.ActiveTab = WR003CodiciSerbatoioRG;
    TabDettSerbatoi:=grdTabDetail.ActiveTab = WR003DettaglioSerbatoioRG;

    grdTabDetail.Tabs[WR003CodiciSerbatoioRG].Visible:=False;
    grdTabDetail.Tabs[WR003DettaglioSerbatoioRG].Visible:=False;

    if Serbatoi[cmbSerbatoi.ItemIndex].Multiplo then
    begin
      grdTabDetail.Tabs[WR003DettaglioSerbatoioRG].Visible:=True;
      CaricaGrdKeyCumulo(cmbSerbatoi.ItemIndex);
    end;
    //visualizzazione lista codici collegata

    for i:=0 to High(TabelleCollegate) do
    begin
      ListaCodici:=getCheckListBoxTabellaCollegata(TabelleCollegate[i].M);
      if ListaCodici.chklst <> nil then
      begin
        ListaCodici.chklst.Visible:=TabelleCollegate[i].M = Serbatoi[cmbSerbatoi.ItemIndex].M;
        if ListaCodici.chklst.Visible then
          grdTabDetail.Tabs[WR003CodiciSerbatoioRG].Visible:=True;
      end;
    end;
    if TabCodici then
    begin
      if grdTabDetail.Tabs[WR003CodiciSerbatoioRG].Visible then
        grdTabDetail.ActiveTab:=WR003CodiciSerbatoioRG
      else
        grdTabDetail.ActiveTab:=WR003GeneraleRG;
    end
    else if TabDettSerbatoi then
    begin
      if grdTabDetail.Tabs[WR003DettaglioSerbatoioRG].Visible then
        grdTabDetail.ActiveTab:=WR003DettaglioSerbatoioRG
      else
        grdTabDetail.ActiveTab:=WR003GeneraleRG;
    end
    else //devo forzare activetab perchè rendere visibili/invisibiil i tab opera anche sulle relative region e pobbero essere visibili le region del tab non attivo
      grdTabDetail.ActiveTab:=grdTabDetail.ActiveTab;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.DataSet2Componenti;
var
  i: Integer;
  Opz: String;
  Valore: String;
begin
  with (Self.Owner as TWR003FGeneratoreStampe) do
  begin
    actTabella.Enabled:=WR302DM.selTabella.FieldByName('TABELLA_GENERATA').AsString <> '';
    //actStampa.Enabled:=True;
    actStampaPDF.Enabled:=True;
    actStampaXLS.Enabled:=True;
    AggiornaToolBar(grdComandi,actlstComandi);
  end;

  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    //generale
    cmbFontName.Text:=selTabella.FieldByName('FONTNAME').asString;
    cmbFontSize.Text:=selTabella.FieldByName('FONTSIZE').asString;

    if selTabella.FieldByName('ORIENTAMENTO_PAGINA').asString = 'V' then
      cmbOrientamentoPag.Text:=VERTICALE
    else if selTabella.FieldByName('ORIENTAMENTO_PAGINA').asString = 'O' then
      cmbOrientamentoPag.Text:=ORIZZONTALE
    else
      cmbOrientamentoPag.Text:=NONIMPOSTATO;
    i:=StrToIntDef(selTabella.FieldByName('FORMATO_PAGINA').AsString,0);
    if i <= 0 then
      cmbFormatoPag.Text:=NONIMPOSTATO
    else
      cmbFormatoPag.Text:=QRPaperName(TQRPaperSize(i-1));
    //ordinamento
    CaricaGrdOrdinamento;

    //area stampa
    grdAreaStampaIntestazione.medpAggiornaCDS(True);
    grdAreaStampaDettaglio.medpAggiornaCDS(True);

    //Lettura Impostazioni (Opzioni Avanzate)
    with TStringList.Create do
    try
      CommaText:=selTabella.FieldByName('IMPOSTAZIONI').AsString;
      for i:=0 to High(R003FGeneratoreStampeMW.OpzioniAvanzate) do
      begin
        Opz:=R003FGeneratoreStampeMW.OpzioniAvanzate[i].Opzione;
        Valore:=Values[Opz];
        setValoreOpzioneAvanzata(Opz,Valore);
      end;
    finally
      Free;
    end;
    //quando viene creata esegue Dataset2Componenti ma dati serbatoi non ancora caricati. quindi cmbSerbatoi.ItemIndex = -1
    if cmbSerbatoi.ItemIndex >=0 then
    begin
      chkFiltroEsclusivo.Checked:=R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].Esclusivo;
      cmbDatoDalAl.Text:=R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].DatoDalAl;
      memFiltro.Text:=R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].FiltroTxt;
      VisualizzaFiltri;
      //dettaglio serbatoio
      CaricaGrdKeyCumulo(cmbSerbatoi.ItemIndex);
    end;
    AttivaCodiciSerbatoi;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.ImpostaGrdCampo(var grdCampo: TmeIWGrid; NomeCampo:String;idx:Integer;Edit:Boolean);
var
  colControl: Integer;
begin
  with grdCampo do
  begin
    Css:='gridCampoGeneratore';
    if Edit then
      ColumnCount:=4
    else
      ColumnCount:=1;

    RowCount:=1;
  end;

  colControl:=0;
  if Edit then
  begin
    //Link sposta su
    with grdCampo.Cell[0,colControl] do
    begin
      Css:='width1chr';
      Control:=TmeIWLink.Create(Self);
    end;
    with (grdCampo.Cell[0,colControl].Control as TmeIWLink) do
    begin
      css:='ui-icon ui-icon-circle-triangle-n';
      Tag:=idx;
      Hint:='Sposta su';
      OnClick:=spostaSuLinkClick;
    end;
    inc(colControl);

    //Link sposta giu
    with grdCampo.Cell[0,colControl] do
    begin
      Css:='width1chr';
      Control:=TmeIWLink.Create(Self);
    end;
    with (grdCampo.Cell[0,colControl].Control as TmeIWLink) do
    begin
      css:='ui-icon ui-icon-circle-triangle-s';
      Tag:=idx;
      Hint:='Sposta giù';
      OnClick:=spostaGiuLinkClick;
    end;
    inc(colControl);

    //Link rimuovi
    with grdCampo.Cell[0,colControl] do
    begin
      Css:='width1chr';
      Control:=TmeIWLink.Create(Self);
    end;
    with (grdCampo.Cell[0,colControl].Control as TmeIWLink) do
    begin
      css:='ui-icon ui-icon-circle-minus';
      Tag:=idx;
      Hint:='Rimuovi';
      OnClick:=RimuoviLinkClick;
    end;
    inc(colControl);
  end;
  //Nome campo
  with grdCampo.Cell[0,colControl] do
  begin
    Css:='cellCampoGeneratore';
    Text:=NomeCampo;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.ImpostaGrdCampoDettSerb(var grdCampo: TmeIWGrid; NomeCampo:String;idx:Integer;Edit:Boolean);
var
  colControl: Integer;
begin
  with grdCampo do
  begin
    Css:='gridCampoGeneratore';
    if Edit then
      ColumnCount:=4
    else
      ColumnCount:=1;

    RowCount:=1;
  end;

  colControl:=0;
  if Edit then
  begin
    //Link sposta su
    with grdCampo.Cell[0,colControl] do
    begin
      Css:='width1chr';
      Control:=TmeIWLink.Create(Self);
    end;
    with (grdCampo.Cell[0,colControl].Control as TmeIWLink) do
    begin
      css:='ui-icon ui-icon-circle-triangle-n';
      Tag:=idx;
      Hint:='Sposta su';
      OnClick:=spostaSuDettSerbLinkClick;
    end;
    inc(colControl);

    //Link sposta giu
    with grdCampo.Cell[0,colControl] do
    begin
      Css:='width1chr';
      Control:=TmeIWLink.Create(Self);
    end;
    with (grdCampo.Cell[0,colControl].Control as TmeIWLink) do
    begin
      css:='ui-icon ui-icon-circle-triangle-s';
      Tag:=idx;
      Hint:='Sposta giù';
      OnClick:=spostaGiuDettSerbLinkClick;
    end;
    inc(colControl);

    //Link rimuovi
    with grdCampo.Cell[0,colControl] do
    begin
      Css:='width1chr';
      Control:=TmeIWLink.Create(Self);
    end;
    with (grdCampo.Cell[0,colControl].Control as TmeIWLink) do
    begin
      css:='ui-icon ui-icon-circle-minus';
      Tag:=idx;
      Hint:='Rimuovi';
      OnClick:=RimuoviDettSerbLinkClick;
    end;
    inc(colControl);
  end;
  //Nome campo
  with grdCampo.Cell[0,colControl] do
  begin
    Css:='cellCampoGeneratore';
    Text:=NomeCampo;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.Invertiselezione1Click(Sender: TObject);
var i: Integer;
begin
  inherited;
  with (pmnListaCodici.PopupComponent as TmeTIWCheckListBox) do
  begin
    for i:=0 to Items.Count - 1 do
      Selected[i]:=not Selected[i];
    AsyncUpdate;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.CaricaGrdOrdinamento;
var
  r,c,i: Integer;
  Ordinamento: TOrdinamento;
  tmpChk: TmeIWCheckbox;
  grdCampo: TmeIWGrid;
  Edit: Boolean;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM)do
  begin
    C190PulisciIWGrid(grdOrdinamento,True);

    grdOrdinamento.RowCount:=Length(R003FGeneratoreStampeMW.Ordinamento) + 1 ;
    grdOrdinamento.ColumnCount:=3;

    c:=0;
    grdOrdinamento.Cell[0,c].Text:='Campo';
    grdOrdinamento.Cell[0,c].Css:='width40chr';
    inc(c);
    grdOrdinamento.Cell[0,c].Text:='Rottura di chiave';
    grdOrdinamento.Cell[0,c].Css:='width10chr';
    inc(c);
    grdOrdinamento.Cell[0,c].Text:='Discendente';
    grdOrdinamento.Cell[0,c].Css:='width10chr';

    Edit:=selTabella.State in [dsEdit,dsInsert];

    for i:=0 to High(R003FGeneratoreStampeMW.Ordinamento) do
    begin
      Ordinamento:=R003FGeneratoreStampeMW.Ordinamento[i];
      c:=0;
      r:=i+1;
      //griglia campo con pulsanti spostamento
      grdCampo:=TmeIWGrid.Create(Self);
      grdOrdinamento.Cell[r,c].Control:=grdCampo;
      ImpostaGrdCampo(grdCampo,Ordinamento.Nome,i,Edit);
      inc(c);

      with grdOrdinamento.Cell[r,c] do
      begin
        css:='align_center';
        tmpChk:=TmeIWCheckbox.Create(Self);
        tmpChk.Caption:='';
        tmpChk.checked:=Ordinamento.Rottura;
        tmpChk.tag:=i;
        tmpChk.enabled:=Edit;
        tmpChk.OnAsyncClick:=chkRotturaAsyncClick;
        Control:=tmpChk;
      end;
      inc(c);
      with grdOrdinamento.Cell[r,c] do
      begin
        css:='align_center';
        tmpChk:=TmeIWCheckbox.Create(Self);
        tmpChk.Caption:='';
        tmpChk.checked:=Ordinamento.Discendente;
        tmpChk.tag:=i;
        tmpChk.enabled:=Edit;
        tmpChk.OnAsyncClick:=chkOrdinamentoDiscendenteAsyncClick;
        Control:=tmpChk;
      end;
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.CaricaGrdKeyCumulo(idx:Integer);
var
  kc: TKeyCumulo;
  r,c,i: Integer;
  Edit: Boolean;
  grdCampo: TmeIWGrid;
  tmpChk: TmeIWCheckbox;
begin
  if (idx < 0) then Exit;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    C190PulisciIWGrid(grdKeyCumulo,True);

    grdKeyCumulo.RowCount:=Length(Serbatoi[idx].KeyCumulo) + 1 ;
    grdKeyCumulo.ColumnCount:=2;

    c:=0;
    grdKeyCumulo.Cell[0,c].Text:='Campo';
    grdKeyCumulo.Cell[0,c].Css:='width40chr';
    inc(c);
    grdKeyCumulo.Cell[0,c].Text:='Totale';
    grdKeyCumulo.Cell[0,c].Css:='width10chr';

    Edit:=WR302DM.selTabella.State in [dsEdit,dsInsert];

    for i:=0 to High(Serbatoi[idx].KeyCumulo) do
    begin
      kc:=Serbatoi[idx].KeyCumulo[i];
      c:=0;
      r:=i + 1;
      //griglia campo con pulsanti spostamento
      grdCampo:=TmeIWGrid.Create(Self);
      grdKeyCumulo.Cell[r,c].Control:=grdCampo;
      ImpostaGrdCampoDettSerb(grdCampo,kc.Nome,i,Edit);
      inc(c);

      with grdKeyCumulo.Cell[r,c] do
      begin
        css:='align_center';
        tmpChk:=TmeIWCheckbox.Create(Self);
        tmpChk.Caption:='';
        tmpChk.checked:=kc.Totale;
        tmpChk.tag:=i;
        tmpChk.enabled:=Edit;
        tmpChk.OnAsyncClick:=chkTotaleDettSerbClick;
        Control:=tmpChk;
      end;
    end;
  end;
  RefreshKeyCumuloGlobale;
end;

procedure TWR003FGeneratoreStampeDettFM.Componenti2DataSet;
var
  i: Integer;
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('FONTNAME').asString:=cmbFontName.Text;
    selTabella.FieldByName('FONTSIZE').asInteger:=cmbFontSize.Text.ToInteger;
    selTabella.FieldByName('ORIENTAMENTO_PAGINA').Clear;

    if cmbOrientamentoPag.Text = VERTICALE then
      selTabella.FieldByName('ORIENTAMENTO_PAGINA').asString:='V'
    else if cmbOrientamentoPag.Text = ORIZZONTALE then
      selTabella.FieldByName('ORIENTAMENTO_PAGINA').asString:='O';

    //non usare itemIndex
    selTabella.FieldByName('FORMATO_PAGINA').AsInteger:=0;
    for i:=0 to cmbFormatoPag.Items.Count - 1 do
    begin
      if cmbFormatoPag.Text = cmbFormatoPag.Items[i].RowData[0] then
        selTabella.FieldByName('FORMATO_PAGINA').AsInteger:=i;
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.dchkTotRiepilogoAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dchkSaltoPaginaTotali.Enabled:=WR302DM.selTabella.FieldByName('TOTRIEPILOGO').AsString = 'S';
end;

procedure TWR003FGeneratoreStampeDettFM.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  CheckAll((pmnListaCodici.PopupComponent as TmeTIWCheckListBox),False);
end;

procedure TWR003FGeneratoreStampeDettFM.RimuoviLinkClick(Sender: TObject);
var
  idx: Integer;
begin
  idx:=(Sender as TmeIWLink).tag;

  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    RimuoviOrdinamentoByIndice(idx);
  end;
  CaricaGrdOrdinamento;
end;

procedure TWR003FGeneratoreStampeDettFM.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  CheckAll((pmnListaCodici.PopupComponent as TmeTIWCheckListBox),True);
end;

procedure TWR003FGeneratoreStampeDettFM.CheckAll(chklst: TmeTIWCheckListBox;Val: Boolean);
var
  i: Integer;
begin
  for i:=0 to chklst.Items.Count - 1 do
    chklst.Selected[i]:=Val;
  chklst.AsyncUpdate;
end;

procedure TWR003FGeneratoreStampeDettFM.spostaSuLinkClick(Sender: TObject);
var
  idx: Integer;
  tmpOrd: TOrdinamento;
begin
  idx:=(Sender as TmeIWLink).tag;
  if idx = 0 then
    Exit;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    tmpOrd:=Ordinamento[idx - 1];
    Ordinamento[idx - 1]:=Ordinamento[idx];
    Ordinamento[idx]:=tmpOrd;
    ModOrdinamento:=True;
    CaricaGrdOrdinamento;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.spostaSuDettSerbLinkClick(Sender: TObject);
var
  idx: Integer;
  tmpkc: TKeyCumulo;
begin
  idx:=(Sender as TmeIWLink).tag;
  if idx = 0 then
    Exit;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    tmpKc:=Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx - 1];
    Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx - 1]:=Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx];
    Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx]:=tmpkc;
    modDettaglioSerbatoio:=True;
    CaricaGrdKeyCumulo(cmbSerbatoi.ItemIndex);
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.spostaGiuDettSerbLinkClick(Sender: TObject);
var
  idx: Integer;
  tmpKc: TKeyCumulo;
begin
  idx:=(Sender as TmeIWLink).tag;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    if idx = high(Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo) then
      Exit;

    tmpKc:=Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx + 1];
    Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx + 1]:=Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx];
    Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[idx]:=tmpKc;
    ModDettaglioSerbatoio:=True;
    CaricaGrdKeyCumulo(cmbSerbatoi.ItemIndex);
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.RimuoviDettSerbLinkClick(Sender: TObject);
var
  idx: Integer;
begin
  idx:=(Sender as TmeIWLink).tag;

  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    RimuoviKeyCumuloByIndice(cmbSerbatoi.ItemIndex,idx);
  end;
  CaricaGrdKeyCumulo(cmbSerbatoi.ItemIndex);
end;

procedure TWR003FGeneratoreStampeDettFM.VisualizzaFiltri;
var
  lst: TStringList;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    memRiepilogoFiltri.Lines.Clear;

    lst:=getElencoFiltri;
    try
      memRiepilogoFiltri.Lines.Assign(lst);
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.spostaGiuLinkClick(Sender: TObject);
var
  idx: Integer;
  tmpOrd: TOrdinamento;
begin
  idx:=(Sender as TmeIWLink).tag;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    if idx = high(Ordinamento) then
      Exit;

    tmpOrd:=Ordinamento[idx + 1];
    Ordinamento[idx + 1]:=Ordinamento[idx];
    Ordinamento[idx]:=tmpOrd;
    ModOrdinamento:=True;
    CaricaGrdOrdinamento;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.chkFiltroEsclusivoAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM) do
    R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].Esclusivo:=chkFiltroEsclusivo.Checked;
end;

procedure TWR003FGeneratoreStampeDettFM.chkOrdinamentoDiscendenteAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  chk: TmeIWCheckBox;
begin
  inherited;
  chk:=(Sender as TmeIWCheckBox);
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    if SelTabella.State in [dsEdit,dsInsert] then
    begin
      R003FGeneratoreStampeMW.Ordinamento[chk.tag].Discendente:=chk.checked ;
      R003FGeneratoreStampeMW.modOrdinamento:=True;
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.chkRotturaAsyncClick(
  Sender: TObject; EventParams: TStringList);
var
  chk: TmeIWCheckBox;
begin
  inherited;
  chk:=(Sender as TmeIWCheckBox);
  with (WR302DM as TWR003FGeneratoreStampeDM)do
  begin
    if SelTabella.State in [dsEdit,dsInsert] then
    begin
      R003FGeneratoreStampeMW.Ordinamento[chk.tag].Rottura:=chk.checked;
      R003FGeneratoreStampeMW.modOrdinamento:=True;
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.chkTotaleDettSerbClick(
  Sender: TObject; EventParams: TStringList);
var
  chk: TmeIWCheckBox;
begin
  inherited;
  chk:=(Sender as TmeIWCheckBox);
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    Serbatoi[cmbSerbatoi.ItemIndex].KeyCumulo[chk.tag].Totale:=chk.checked;
    modDettaglioSerbatoio:=True;
    RefreshKeyCumuloGlobale;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.RefreshKeyCumuloGlobale;
var
  lst: TStringList;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    memRiepilogoKeyCumulo.Lines.Clear;

    lst:=getRiepilogoKeyCumulo;
    try
      memRiepilogoKeyCumulo.Lines.Assign(lst);
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.dgrpRicreaTabellaClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWR003FGeneratoreStampeDettFM.drgpTipoStampaClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    if selTabella.FieldByName('TIPO').AsString = 'S' then
    begin
      selTabella.FieldByName('SEPARAV').AsString:='N';
      selTabella.FieldByName('INTESTAZIONE_COLONNE').AsString:='N';
    end;
  end;
  AbilitaComponenti;
end;

procedure TWR003FGeneratoreStampeDettFM.edtRicercaTestoAsyncKeyUp(Sender: TObject; EventParams: TStringList);
var i:Integer;
begin
  inherited;
  //Invio: si posiziona su lstAzienda
  if EventParams.Values['which'] = '13' then
  begin
    lstDatiSerbatoio.SetFocus;
    exit;
  end;
  //Freccia su: ricerca precedente
  if EventParams.Values['which'] = '38' then
  begin
    btnRicercaSuAsyncClick(btnRicercaSu,EventParams);
    exit;
  end;
  //Freccia giù: ricerca successivo
  if EventParams.Values['which'] = '40' then
  begin
    btnRicercaGiuAsyncClick(btnRicercaGiu,EventParams);
    exit;
  end;
  for i:=0 to lstDatiSerbatoio.Items.Count - 1 do
  begin
    if Pos(LowerCase(edtRicercaTesto.Text),LowerCase(lstDatiSerbatoio.Items[i])) > 0 then
    begin
      lstDatiSerbatoio.ItemIndex:=i;
      Break;
    end;
  end;

end;

procedure TWR003FGeneratoreStampeDettFM.GetDati;
var i:Integer;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(Serbatoi) do
      cmbSerbatoi.Items.Add(Serbatoi[i].Nome);

    cmbSerbatoi.ItemIndex:=0;
    cmbSerbatoiChange(nil);
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaStampaDettaglioAnnulla(
  Sender: TObject);
begin
  inherited;
  //Se annullo, ripristino le proprietà
  if pDettaglio >=0 then
  begin
    (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.Dati[pDettaglio]:=SaveProprietaDatoDettaglio;
  end;
end;

function TWR003FGeneratoreStampeDettFM.grdAreaStampaDettaglioBeforeModifica(
  Sender: TObject): Boolean;
var
  NomeCampo: String;
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    NomeCampo:=cdsDatiDettaglio.FieldByName('NOME').AsString;
    PDettaglio:=R003FGeneratoreStampeMW.GetDato(NomeCampo,False);
    if pDettaglio >=0 then
    begin
      SaveProprietaDatoDettaglio:=R003FGeneratoreStampeMW.Dati[PDettaglio];
    end;
  end;
  Result:=True;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaStampaDettaglioComponenti2DataSet(
  Row: Integer);
begin
  inherited;
  with grdAreaStampaDettaglio do
  begin
    if (medpCompCella(Row,medpIndexColonna('TOTALE'),0) as TmeIWCheckBox).checked then
      medpDataSet.FieldByName('TOTALE').AsString:='S'
    else
      medpDataSet.FieldByName('TOTALE').AsString:='N';
  end;
  //Non mettere in onConferma perchè se definita la procedura OnConferma
  //non esegue il comportamento standard ma solo il codice OnConferma stesso
  (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.modAreaStampa:=True;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaStampaDettaglioDataSet2Componenti(
  Row: Integer);
var
  NomeCampo: String;
  P:Integer;
begin
  inherited;
  with (grdAreaStampaDettaglio.medpCompCella(Row,grdAreaStampaDettaglio.medpIndexColonna('TOTALE'),0) as TmeIWCheckBox) do
  begin
    NomeCampo:=grdAreaStampaDettaglio.medpDataSet.FieldByName('NOME').AsString;
    with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    begin
      P:=GetDato(NomeCampo,False);
    end;
    Enabled:=P >= 0;
    Checked:=(Enabled) and (grdAreaStampaDettaglio.medpDataSet.FieldByName('TOTALE').ASString = 'S');
  end;

  with (grdAreaStampaDettaglio.medpCompCella(Row,grdAreaStampaDettaglio.medpIndexColonna('FITTIZIO'),1) as TmeIWImageFile) do
  begin
    OnClick:=imgProprietaClick;
    tag:=1;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaStampaRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  inherited;
  //Facendo click sulla riga rimanda al serbatoio(funzione vai a serbatoio di win)
  //Evidenziare la riga che è selezionata (richiesta alberto 31/07/2014)
  //(ACell.Grid AS TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,False,False);
  (ACell.Grid AS TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,False,True);
  NumColonna:=(ACell.Grid as TmedpIWDBGrid).medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High((ACell.Grid as TmedpIWDBGrid).medpCompGriglia) + 1) and ((ACell.Grid as TmedpIWDBGrid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=(ACell.Grid as TmedpIWDBGrid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if (ARow > 0) and
     ((ACell.Grid AS TmedpIWDBGrid).medpClientDataSet.recordCount > 0) and
     ((ACell.Grid AS TmedpIWDBGrid).medpClientDataSet.FieldByName('TOTALE').AsString = 'S') then
  begin
    ACell.Css:=ACell.Css + ' bg_giallo';
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.grdKeyCumuloRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,ARow,AColumn,True,False,True);
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaStampaIntestazioneAnnulla(
  Sender: TObject);
begin
  inherited;
  //Se annullo, ripristino le proprietà
  if pIntestazione >=0 then
  begin
    (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.Dati[PIntestazione]:=SaveProprietaDatoIntestazione;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaDatiDettaglioRowClick;
var
  P, i: Integer;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    P:=GetDato(grdAreaStampaDettaglio.medpDataSet.FieldByName('NOME').AsString,False);
    if P >= 0 then
      for i:=0 to High(Serbatoi) do
      if Serbatoi[i].X =Dati[P].X then
      begin
        cmbSerbatoi.ItemIndex:=i;
        cmbSerbatoiChange(nil);
        Break;
      end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaDatiIntestazioneRowClick;
var
  P, i: Integer;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    P:=GetDato(grdAreaStampaIntestazione.medpDataSet.FieldByName('NOME').AsString,False);
    if P >= 0 then
      for i:=0 to High(Serbatoi) do
      if Serbatoi[i].X =Dati[P].X then
      begin
        cmbSerbatoi.ItemIndex:=i;
        cmbSerbatoiChange(nil);
        Break;
      end;
  end;
end;

function TWR003FGeneratoreStampeDettFM.grdAreaStampaBeforeCancella(
  Sender: TObject): Boolean;
begin
  inherited;
  (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.modAreaStampa:=True;
  Result:=True;
end;

function TWR003FGeneratoreStampeDettFM.grdAreaStampaIntestazioneBeforeModifica(
  Sender: TObject): Boolean;
var
  NomeCampo: String;
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    NomeCampo:=cdsDatiIntestazione.FieldByName('NOME').AsString;
    PIntestazione:=R003FGeneratoreStampeMW.GetDato(NomeCampo,False);
    if pIntestazione >=0 then
    begin
      SaveProprietaDatoIntestazione:=R003FGeneratoreStampeMW.Dati[PIntestazione];
    end;
  end;
  Result:=True;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaStampaIntestazioneDataSet2Componenti(
  Row: Integer);
var
  NomeCampo: String;
  P:Integer;
begin
  inherited;
  with (grdAreaStampaIntestazione.medpCompCella(Row,grdAreaStampaIntestazione.medpIndexColonna('TOTALE'),0) as TmeIWCheckBox) do
  begin
    NomeCampo:=grdAreaStampaIntestazione.medpDataSet.FieldByName('NOME').AsString;
    with ((Self.Owner as TWR003FGeneratoreStampe).WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    begin
      P:=GetDato(NomeCampo,False);
    end;
    Enabled:=P >= 0;
    Checked:=(Enabled) and (grdAreaStampaIntestazione.medpDataSet.FieldByName('TOTALE').ASString = 'S');
  end;
  with (grdAreaStampaIntestazione.medpCompCella(Row,grdAreaStampaIntestazione.medpIndexColonna('FITTIZIO'),1) as TmeIWImageFile) do
  begin
    OnClick:=imgProprietaClick;
    tag:=0;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.imgProprietaClick(Sender: TObject);
var
  WR003FProprietaDatiFM: TWR003FProprietaDatiFM;
  cds: TClientDataSet;
  bConvertiVisible: Boolean;
begin
  //Sender è TmeIWImageFile
  //tag 0 intestazione; tag 1 Dettaglio
  if (Sender as TmeIWImageFile).Tag = 0 then
    cds:=(WR302DM as TWR003FGeneratoreStampeDM).cdsDatiIntestazione
  else
    cds:=(WR302DM as TWR003FGeneratoreStampeDM).cdsDatiDettaglio;

  bConvertiVisible:=(Self.Owner as TWR003FGeneratoreStampe).ConvertiInValutaVisible(cds.FieldByName('NOME').AsString);
  WR003FProprietaDatiFM:=TWR003FProprietaDatiFM.Create(Self.Owner);
  WR003FProprietaDatiFM.Visualizza(cds,bConvertiVisible);
end;

procedure TWR003FGeneratoreStampeDettFM.grdOrdinamentoRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,ARow,AColumn,True,False,True);
end;

procedure TWR003FGeneratoreStampeDettFM.grdTabDetailTabControlChange(
  Sender: TObject);
begin
  inherited;
  mnuAreaStampa;
end;

procedure TWR003FGeneratoreStampeDettFM.memFiltroAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    Serbatoi[cmbSerbatoi.ItemIndex].FiltroTxt:=memFiltro.Lines.Text;
    modFiltro:=True;
  end;
  VisualizzaFiltri;
end;

procedure TWR003FGeneratoreStampeDettFM.mnuAggiungiIntestazioneClick(
  Sender: TObject);
begin
  inherited;
  if not(WR302DM.selTabella.State in [dsEdit,dsInsert]) then
    Exit;
  if lstDatiSerbatoio.ItemIndex < 0  then
    Exit;
  AggiungiSerbatoioAreaStampa(0);
end;

procedure TWR003FGeneratoreStampeDettFM.mnuAreaStampa;
begin
  if (WR302DM.selTabella.State in [dsEdit,dsInsert]) then
  begin
    if (grdTabDetail.ActiveTab = WR003AreaStampaRG) then
      lstDatiSerbatoio.medpContextMenu:=pmnAreaStampa
    else
      lstDatiSerbatoio.medpContextMenu:=pmnDatiCalcolati;
  end
  else
    lstDatiSerbatoio.medpContextMenu:=pmnDatiCalcolati;
end;

procedure TWR003FGeneratoreStampeDettFM.mnuDatiCalcolatiClick(Sender: TObject);
var
  IdSerbatoio: Integer;
  Params: String;
begin
  inherited;
  IdSerbatoio:=(WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.Serbatoi[cmbSerbatoi.ItemIndex].X;
  Params:='IDSERBATOIO=' + IntToStr(IdSerbatoio) + ParamDelimiter +
          'NOME=' + lstDatiSerbatoio.SelectedValue;
  (Self.Owner as TWR100FBase).AccediForm(73,Params,False);
end;

procedure TWR003FGeneratoreStampeDettFM.muAggiungiDettaglioClick(
  Sender: TObject);
begin
  inherited;
  if not(WR302DM.selTabella.State in [dsEdit,dsInsert]) then
    Exit;
  if lstDatiSerbatoio.ItemIndex < 0  then
    Exit;
  AggiungiSerbatoioAreaStampa(1);
end;

procedure TWR003FGeneratoreStampeDettFM.AbilitaComponenti;
var
  edit,bBloccaStampa: Boolean;
  i: Integer;
  ListaCodici: TListaCodici;
begin
  inherited;
  cmbSerbatoi.Enabled:=True;
  lstDatiSerbatoio.Enabled:=True;
  dedtChiavi.ReadOnly:=True;
  mnuAreaStampa;
  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    edit:=SelTabella.State in [dsEdit, dsInsert];
    grdAreaStampaIntestazione.medpAttivaGrid(cdsDatiIntestazione,edit,False,edit);
    grdAreaStampaDettaglio.medpAttivaGrid(cdsDatiDettaglio,edit,False,edit);

    if edit then
    begin
      bBloccaStampa:=(Self.Owner as TWR003FGeneratoreStampe).BloccaStampa;
      dEdtDelete.Enabled:=not bBloccaStampa and (selTabella.FieldByName('TABELLA_GENERATA_DROP').AsString = 'N');
      btnDelete.Enabled:=dEdtDelete.Enabled;

      btnChiavi.Enabled:=not bBloccaStampa;
      dedtTabellaStampa.Enabled:=not bBloccaStampa;
      dgrpRicreaTabella.Enabled:=not bBloccaStampa;
      {Alberto 11/01/2021: abilitazine stampa anche in modifica
      //quando entro in modifica disabilito sempre la generazione tabella perchè
      //usando B028 i dati non sono ancora su DB
      if not GGetWebApplicationThreadVar.IsCallBack then
      begin
        with (Self.Owner as TWR003FGeneratoreStampe) do
        begin
          actTabella.Enabled:=False;
          //actStampa.Enabled:=False;
          actStampaPDF.Enabled:=False;
          actStampaXLS.Enabled:=False;
          AggiornaToolBar(grdComandi,actlstComandi);
        end;
      end;
      }
      dChkStampaBloccata.Enabled:=Parametri.ModificaDatiProtetti;
      dchkSepCol.Enabled:=selTabella.FieldByName('TIPO').AsString = 'C';
      dChkIntestazioneCol.Enabled:=selTabella.FieldByName('TIPO').AsString = 'C';
      dchkSaltoPaginaTotali.Enabled:=selTabella.FieldByName('TOTRIEPILOGO').AsString = 'S';
    end;

    CaricaGrdOrdinamento;
    CaricaGrdKeyCumulo(cmbSerbatoi.ItemIndex);

    memRiepilogoFiltri.Enabled:=False;
    memRiepilogoKeyCumulo.Enabled:=False;
    //popupmenu su checkslist
    if not edit then
    begin
      //annullo elementiSelezionatiInAlto
      mnuElementiSelezionatiInAlto.Checked:=False;
    end;

    for i:=0 to High(R003FGeneratoreStampeMW.TabelleCollegate) do
    begin
      ListaCodici:=getCheckListBoxTabellaCollegata(R003FGeneratoreStampeMW.TabelleCollegate[i].M);
      if ListaCodici.chklst <> nil then
      begin
        if edit then
        begin
          ListaCodici.chklst.medpContextMenu:=pmnListaCodici;
        end
        else
        begin
          ListaCodici.chklst.medpContextMenu:=nil;
          //Ricarico gli elementi della checklistbox. In questo modo ripristino l'ordine
          //originale degli elementi che può essere stato alterato da mnuElementiSelezionatiInalto
          //Carico solo gli item, se sono selezionati o meno viene fatto in dataset2Componenti
          CaricaCheckListCodici(ListaCodici.chklst);
         end;
      end;
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.setValoreOpzioneAvanzata(Opz,Valore:String);
var
  ctrl: TControl;
begin
  ctrl:=getControlOpzioneAvanzata(Opz);
  if ctrl is TmeIWCheckBox then
    (ctrl as TmeIWCheckBox).Checked:=Valore = 'S'
  else if ctrl is TmeIWRadioGroup then
    (ctrl as TmeIWRadioGroup).ItemIndex:=StrToIntDef(Valore,0)
  else if ctrl is TmeIWDBLookupComboBox then
  begin
    if Valore <> '' then
      (ctrl as TmeIWDBLookupComboBox).KeyValue:=Valore
    else
      (ctrl as TmeIWDBLookupComboBox).KeyValue:=null;
  end
  else if ctrl is TmeIWComboBox then
    (ctrl as TmeIWComboBox).ItemIndex:=(ctrl as TmeIWComboBox).Items.IndexOf(Valore)
  else if ctrl is TMedpIWMultiColumnComboBox then
    (ctrl as TMedpIWMultiColumnComboBox).Text:=Valore
  else if ctrl is TmeIWEdit then
    (ctrl as TmeIWEdit).Text:=Valore;
end;

function TWR003FGeneratoreStampeDettFM.getValoreOpzioneAvanzata(Opz:String):String;
var
  ctrl: TControl;
begin
  Result:='';
  ctrl:=getControlOpzioneAvanzata(Opz);

  if ctrl is TmeIWCheckBox then
  begin
    Result:=IfThen((ctrl as TmeIWCheckBox).Checked,'S','N');
  end
  else if ctrl is TmeIWRadioGroup then
  begin
    Result:=IntToStr((ctrl as TmeIWRadioGroup).ItemIndex);
  end
  else if ctrl is TmeIWDBLookupComboBox then
  begin
    Result:=VarToStr((ctrl as TmeIWDBLookupComboBox).KeyValue);
  end
  else if ctrl is TmeIWComboBox then
  begin
    Result:=(ctrl as TmeIWComboBox).Text;
  end
  else if ctrl is TMedpIWMultiColumnComboBox then
  begin
    Result:=(ctrl as TMedpIWMultiColumnComboBox).Text;
  end
  else if ctrl is TmeIWEdit then
  begin
    Result:=(ctrl as TmeIWEdit).Text;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.AttivaCodiciSerbatoi;
var i,j:Integer;
    ListaCodici: TListaCodici;
begin
  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
  begin
    for i:=0 to High(TabelleCollegate) do
    begin
      ListaCodici:=getCheckListBoxTabellaCollegata(TabelleCollegate[i].M);

      if ListaCodici.chklst <> nil then
        for j:=0 to ListaCodici.chklst.Items.Count - 1 do
          ListaCodici.chklst.Selected[j]:=IsCodiceSerbatoioChecked(TabelleCollegate[i].M,Trim(Copy(ListaCodici.chklst.Items[j],1,ListaCodici.Lunghezza)));
    end;
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.chklstCodiciAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if mnuElementiSelezionatiInAlto.Checked then
    chklstElementiInAlto((Sender as TmeTIWCheckListBox));
end;

procedure TWR003FGeneratoreStampeDettFM.mnuElementiSelezionatiInAltoClick(
  Sender: TObject);
var
  i: Integer;
  ListaCodici: TListaCodici;
begin
  mnuElementiSelezionatiInAlto.Checked:=not mnuElementiSelezionatiInAlto.Checked;

  with (WR302DM as TWR003FGeneratoreStampeDM) do
  begin
    for i:=0 to High(R003FGeneratoreStampeMW.TabelleCollegate) do
    begin
      ListaCodici:=getCheckListBoxTabellaCollegata(R003FGeneratoreStampeMW.TabelleCollegate[i].M);
      if ListaCodici.chklst <> nil then
      begin
        if mnuElementiSelezionatiInAlto.Checked  then
          ListaCodici.chklst.OnAsyncClick:=chklstCodiciAsyncClick
        else
          ListaCodici.chklst.OnAsyncClick:=nil;
      end;
    end;
  end;

  with (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW do
    for i:=0 to High(TabelleCollegate) do
    begin
      ListaCodici:=getCheckListBoxTabellaCollegata(TabelleCollegate[i].M);
      if ListaCodici.chklst <> nil then
      begin
        if mnuElementiSelezionatiInAlto.Checked then
          chklstElementiInAlto(ListaCodici.chklst)
        else
          chklstResetElementiInAlto(ListaCodici.chklst);
      end;
    end;
end;

procedure TWR003FGeneratoreStampeDettFM.chklstResetElementiInAlto(Sender: TmeTIWCheckListBox);
var
  lstSelected: TStringList;
  i: Integer;
begin
  //Salvo items selezionati
  lstSelected:=TStringList.Create;
  for i:=0 to Sender.Items.Count - 1 do
  begin
    if Sender.Selected[i] then
      lstSelected.Add(Sender.Items[i]);
  end;
  Sender.UnCheckAll;
  CaricaCheckListCodici(Sender);

  for i:=0 to Sender.Items.Count - 1 do
  begin
    if lstSelected.IndexOf(Sender.Items[i])>=0 then
      Sender.Selected[i]:=True;
  end;
  FreeAndNil(lstSelected);
end;

procedure TWR003FGeneratoreStampeDettFM.chklstElementiInAlto(Sender: TmeTIWCheckListBox);
var i:Integer;
    lst1,lst2:TStringList;
begin
  if not mnuElementiSelezionatiInAlto.Checked then
    exit;

  lst1:=TStringList.Create;
  lst2:=TStringList.Create;
  Sender.Items.BeginUpdate;
  try
    for i:=0 to Sender.Items.Count - 1 do
    begin
      if Sender.Selected[i] then
        lst1.Add(Sender.Items[i])
      else
        lst2.Add(Sender.Items[i]);
      Sender.Selected[i]:=False;
    end;

    Sender.Items.Clear;
    for i:=0 to lst1.Count - 1 do
    begin
      Sender.Items.Add(lst1[i]);
      Sender.Selected[i]:=True;
    end;
    for i:=0 to lst2.Count - 1 do
      Sender.Items.Add(lst2[i]);
  finally
    Sender.Items.EndUpdate;
    FreeAndNil(lst1);
    FreeAndNil(lst2);
  end;
end;

procedure TWR003FGeneratoreStampeDettFM.ReleaseOggetti;
begin
  FreeAndNil(lstSystemFonts);
  inherited;
end;

procedure TWR003FGeneratoreStampeDettFM.grdAreaStampaIntestazioneComponenti2DataSet(
  Row: Integer);
begin
  inherited;
  with grdAreaStampaIntestazione do
  begin
    if (medpCompCella(Row,medpIndexColonna('TOTALE'),0) as TmeIWCheckBox).checked then
      medpDataSet.FieldByName('TOTALE').AsString:='S'
    else
      medpDataSet.FieldByName('TOTALE').AsString:='N';
  end;

  //Non mettere in onConferma perchè se definita la procedura OnConferma
  //non esegue il comportamento standard ma solo il codice OnConferma stesso
  (WR302DM as TWR003FGeneratoreStampeDM).R003FGeneratoreStampeMW.modAreaStampa:=True;
end;

end.
