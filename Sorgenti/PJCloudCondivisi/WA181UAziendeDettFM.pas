unit WA181UAziendeDettFM;

interface

uses
  Windows, Messages, SysUtils,StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompExtCtrls, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  meIWDBComboBox, meIWDBLabel,OracleData,
  meIWLabel, IWCompCheckbox, meIWDBCheckBox, A000UInterfaccia, Menus,
  IWAdvCheckGroup, meTIWAdvCheckGroup, meIWCheckBox, C180FunzioniGenerali,
  C190FunzioniGeneraliWeb, IWCompButton, meIWButton,
  IWDBGrids, medpIWDBGrid,meIWImageFile, DB, DBClient, StdCtrls, WC011UListboxFM,
  WC015USelEditGridFM, meIWComboBox, meIWEdit,meIWMemo, IWCompGrids, IWCompJQueryWidget,
  L021Call, meIWRegion, meIWGrid, medpIWTabControl, idSMTP, idMessage, medpIWMessageDlg,
  MedpIWMultiColumnComboBox, WR102UGestTabella, WC013UCheckListFM;

type
  TWA181FAziendeDettFM = class(TWR205FDettTabellaFM)
    lblAzienda: TmeIWLabel;
    lblCodiceIntegrazione: TmeIWLabel;
    lblIndirizzo: TmeIWLabel;
    dedtAzienda: TmeIWDBEdit;
    dedtCodiceIntegrazione: TmeIWDBEdit;
    dedtIndirizzo: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    dsrI091: TDataSource;
    cdsI091: TClientDataSet;
    grdTabDetail: TmedpIWTabControl;
    WA181GestModuliRG: TmeIWRegion;
    lblFiltroGestModuli: TmeIWLabel;
    cmbFiltroGestModuli: TmeIWComboBox;
    grdGestioneModuli: TmedpIWDBGrid;
    WA181DatiAziendaliRG: TmeIWRegion;
    lblGestioneSicurezza: TmeIWLabel;
    lblLunghezzaMinima: TmeIWLabel;
    dedtLunghezzaMinima: TmeIWDBEdit;
    dedtPeriodoValidita: TmeIWDBEdit;
    lblPeriodoValidita: TmeIWLabel;
    dedtPeriodoScadenza: TmeIWDBEdit;
    lblPeriodoScadenza: TmeIWLabel;
    lblValidCifre: TmeIWLabel;
    lblValidMaiuscole: TmeIWLabel;
    lblValidCarattSpeciali: TmeIWLabel;
    dedtValidCifre: TmeIWDBEdit;
    dedtValidMaiuscole: TmeIWDBEdit;
    dedtValidCarattSpeciali: TmeIWDBEdit;
    dcmbDominioIrisWeb: TmeIWDBComboBox;
    dedtDominioIrisWeb: TmeIWDBEdit;
    lblDominioIrisWeb: TmeIWLabel;
    lblParametriConnessione: TmeIWLabel;
    lblUsername: TmeIWLabel;
    dedtUsername: TmeIWDBEdit;
    lblPassword: TmeIWLabel;
    dedtPassword: TmeIWDBEdit;
    lblTablespaceTabelle: TmeIWLabel;
    dedtTablespaceTabelle: TmeIWDBEdit;
    dedtTablespaceIndici: TmeIWDBEdit;
    lblTablespaceIndici: TmeIWLabel;
    lblTablespaceAusiliario: TmeIWLabel;
    dedtTablespaceAusiliario: TmeIWDBEdit;
    lblControlloTimbrature: TmeIWLabel;
    dchkTimbraturaVerso: TmeIWDBCheckBox;
    dchkTimbraturaCausale: TmeIWDBCheckBox;
    TemplateDatiAziendaliRG: TIWTemplateProcessorHTML;
    TemplateGestModuliRG: TIWTemplateProcessorHTML;
    lblDominioApplicativi: TmeIWLabel;
    dedtDominioApplicativi: TmeIWDBEdit;
    dcmbDominioApplicativi: TmeIWDBComboBox;
    pmnLog: TPopupMenu;
    LogSelezionatutto1: TMenuItem;
    LogDeselezionatutto1: TMenuItem;
    LogInvertiselezione1: TMenuItem;
    lblGruppoBadge: TmeIWLabel;
    dedtGruppoBadge: TmeIWDBEdit;
    btnTestEMail: TmeIWButton;
    edtEMailTest: TmeIWEdit;
    WA181RegistraLogRG: TmeIWRegion;
    cgpTabelleLog: TmeTIWAdvCheckGroup;
    dchkRegistrazioneInterventi: TmeIWDBCheckBox;
    TemplateRegistraLogRG: TIWTemplateProcessorHTML;
    lblDominioLdapDn: TmeIWLabel;
    dedtDominioLdapDn: TmeIWDBEdit;
    lblSuffissoLDAP: TmeIWLabel;
    dedtSuffissoLDAP: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
    procedure cmbFiltroGestModuliChange(Sender: TObject);
    procedure grdGestioneModuliDataSet2Componenti(Row: Integer);
    procedure grdGestioneModuliComponenti2DataSet(Row: Integer);
    procedure LogSelezionatutto1Click(Sender: TObject);
    procedure LogDeselezionatutto1Click(Sender: TObject);
    procedure LogInvertiselezione1Click(Sender: TObject);
    procedure btnTestEMailClick(Sender: TObject);
  private
    WC015: TWC015FSelEditGridFM;
    WC013: TWC013FCheckListFM;
    procedure ResultDatiEnte(Sender: TObject; Result: Boolean);
    procedure MultiselectClick(Sender: TObject);
    procedure OpenSelezione(Row: Integer);
    procedure grdGestioneModulipreparaComponenti;
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaCmbFiltroGestModuli;
    procedure ReleaseOggetti;override;
  public
    CdFnz,CdFnzWeb:TStringList;
    procedure AggiornaDettaglio;
  end;

implementation

uses A000UCostanti, A000USessione, WA181UAziendeDM, WA181UAziende, WR100UBase,
  meIWLink;

{$R *.dfm}

procedure TWA181FAziendeDettFM.LogInvertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelleLog.Items.Count - 1 do
    cgpTabelleLog.IsChecked[i]:=not cgpTabelleLog.IsChecked[i];
  cgpTabelleLog.AsyncUpdate;
end;

procedure TWA181FAziendeDettFM.IWFrameRegionCreate(Sender: TObject);
var
  i,j : Integer;
begin
  grdTabDetail.AggiungiTab('Dati aziendali',WA181DatiAziendaliRG);
  grdTabDetail.AggiungiTab('Log delle operazioni',WA181RegistraLogRG);
  grdTabDetail.AggiungiTab('Gestione moduli',WA181GestModuliRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA181DatiAziendaliRG;

  CdFnz:=TStringList.Create;
  CdFnzWeb:=TStringList.Create;
  CdFnz.Clear;
  CdFnzWeb.Clear;
  if Parametri.Applicazione = '' then
    Parametri.Applicazione:='RILPRE';

  with TWA181FAziendeDM(WR302DM) do
  begin
    cgpTabelleLog.Items.Clear;
    cgpTabelleLog.Items.Sorted:=False;
    j:=0;
    for i:=1 to High(FunzioniDisponibili) do
    begin
      if (L021GetMaschera(i) <> 'XXXX') and (FunzioniDisponibili[i].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
         L021VerificaApplicazione(Parametri.Applicazione,i) then
      begin
        cgpTabelleLog.Items.Add(FunzioniDisponibili[i].G + ': ' + FunzioniDisponibili[i].N);
      end;
    end;
    cgpTabelleLog.Items.Sorted:=True;
    for i:=0 to cgpTabelleLog.Items.count - 1 do
      for j:=1 to High(FunzioniDisponibili) do
      begin
        if (L021GetMaschera(j) <> 'XXXX') and (FunzioniDisponibili[j].T <> 47) and //Alberto 28/11/2005: escludo l'inserimento collettivo giustificativi, che ha la stessa sigla di A004
           L021VerificaApplicazione(Parametri.Applicazione,j) and
           (cgpTabelleLog.Items[i] = FunzioniDisponibili[j].G + ': ' + FunzioniDisponibili[j].N) then
        begin
          CdFnz.Add(L021GetMaschera(j));
          CdFnzWeb.Add(FunzioniDisponibili[j].SW);//Caratto: 11/04/2013. Unificazione L021. codice della maschera web. abilito/disabilito in coppia con la maschera win
          Break;
        end;
      end;
  end;

  inherited;

  CaricaCmbFiltroGestModuli;
  grdGestioneModuli.medpAttivaGrid(TWA181FAziendeDM(WR302DM).A181MW.QI091,True,False,False);
  grdGestioneModuli.medpPaginazione:=True;
  grdGestioneModuli.medpRighePagina:=15;
  grdGestioneModulipreparaComponenti;
end;

procedure TWA181FAziendeDettFM.AggiornaDettaglio;
begin
  grdGestioneModuli.medpCreaColonne;
  if grdGestioneModuli.medpComandiCustom then
    grdGestioneModuli.medpCaricaCDS;
end;

procedure TWA181FAziendeDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
begin
  inherited;
  with (WR302DM as TWA181FAziendeDM) do
  begin
    cmbFiltroGestModuli.Enabled:=True;
    bEdit:=(selTabella.State in [dsEdit,dsInsert]);
  end;
end;

procedure TWA181FAziendeDettFM.DataSet2Componenti;
var i : Integer;
begin
  with TWA181FAziendeDM(WR302DM) do
  begin
    for i:=0 to CdFnz.Count - 1 do
      cgpTabelleLog.IsChecked[i]:=QI092.Locate('SCHEDA',CdFnz[i],[]);

    if grdGestioneModuli.medpDataSet <> nil then
      grdGestioneModuli.medpAggiornaCDS;
  end;
end;

procedure TWA181FAziendeDettFM.LogDeselezionatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelleLog.Items.Count - 1 do
    cgpTabelleLog.IsChecked[i]:=False;
  cgpTabelleLog.AsyncUpdate;
end;

procedure TWA181FAziendeDettFM.CaricaCmbFiltroGestModuli;
var i:Integer;
begin
  cmbFiltroGestModuli.Items.Clear;
  for i:=Low(DatiEnte) to High(DatiEnte) do
    if cmbFiltroGestModuli.Items.IndexOf(DatiEnte[i].Gruppo) < 0 then
      cmbFiltroGestModuli.Items.Add(DatiEnte[i].Gruppo);
  cmbFiltroGestModuli.Sorted:=True;
end;

procedure TWA181FAziendeDettFM.grdRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA181FAziendeDettFM.btnTestEMailClick(Sender: TObject);
begin
  inherited;
  if Trim(edtEMailTest.Text) = '' then
    raise Exception.Create('Indirizzo E-Mail non valorizzato.');
  TWA181FAziendeDM(WR302DM).A181MW.SendEMail(trim(edtEMailTest.Text));
end;

procedure TWA181FAziendeDettFM.cmbFiltroGestModuliChange(Sender: TObject);
begin
  inherited;
  with TWA181FAziendeDM(WR302DM) do
  begin
    A181MW.QI091.Close;
    A181MW.GruppoFiltroI091:=cmbFiltroGestModuli.Text;
    A181MW.QI091.Filtered:=True;
    A181MW.QI091.Open;
    grdGestioneModuli.medpAggiornaCDS;
  end;
end;

procedure TWA181FAziendeDettFM.Componenti2DataSet;
//Gestione della tabella principale (I090)
begin
  inherited;
  //Aggiorno dati aziendali eventualmente in modifica
  with TWA181FAziendeDM(WR302DM) do
  begin
    with grdGestioneModuli.medpClientDataSet do
    begin
      First;
      while not Eof do
      begin
        if grdGestioneModuli.medpCompCella(RecNo-1, grdGestioneModuli.medpIndexColonna('DATO'),0) <> nil then
        begin
          A181MW.QI091.SearchRecord('D_Tipo',FieldByName('D_Tipo').AsString,[srFromBeginning]);
          A181MW.QI091.Edit;
          grdGestioneModuliComponenti2DataSet(RecNo-1);
          A181MW.QI091.Post;
        end;
        Next;
      end;
    end;
  end;
end;

procedure TWA181FAziendeDettFM.ResultDatiEnte(Sender: TObject; Result: Boolean);
var
  Temp_WA181DM:TWA181FAziendeDM;
  WC13ValSelezionati:TStringList;
begin
  Temp_WA181DM:=(WR302DM as TWA181FAziendeDM);
  if Result then
  begin
    WC13ValSelezionati:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      (grdGestioneModuli.medpCompCella((grdGestioneModuli.medpClientDataSet as TClientDataSet).RecNo - 1, grdGestioneModuli.medpIndexColonna('DATO'),1) as TmeIWLabel).Caption:=WC13ValSelezionati.CommaText;
    finally
      FreeAndNil(WC13ValSelezionati);
    end;
  end;
end;

procedure TWA181FAziendeDettFM.MultiselectClick(Sender: TObject);
var
  Temp_WA181DM:TWA181FAziendeDM;
  WC013Valori:TElencoValoriChecklist;
  WC013ValoriSelezionati:TStringList;
  i:integer;
begin
  Temp_WA181DM:=(WR302DM as TWA181FAziendeDM);
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  WC013Valori:=TElencoValoriChecklist.Create;
  WC013ValoriSelezionati:=TStringList.Create;
  try
    //Caricamento WC013Valori.lstCodice - WC013Valori.lstDescrizione
    WC013Valori.lstCodice.BeginUpdate;
    WC013Valori.lstDescrizione.BeginUpdate;
    for i:=0 to Temp_WA181DM.A181MW.I091DatiEnteItems.ListaSelezione.Count - 1 do
    begin
      WC013Valori.lstCodice.Add(Temp_WA181DM.A181MW.I091DatiEnteItems.ListaSelezione[i].Substring(0,Temp_WA181DM.A181MW.I091DatiEnteItems.DimCodice).Trim);
      WC013Valori.lstDescrizione.Add(Temp_WA181DM.A181MW.I091DatiEnteItems.ListaSelezione[i].Substring(Temp_WA181DM.A181MW.I091DatiEnteItems.DimCodice + 1,
                                     Temp_WA181DM.A181MW.I091DatiEnteItems.ListaSelezione[i].Length).Trim);
    end;
    WC013Valori.lstDescrizione.EndUpdate;
    WC013Valori.lstCodice.EndUpdate;
    WC013.CaricaLista(WC013Valori.lstDescrizione, WC013Valori.lstCodice);
    //Carico i valori selezionati
    WC013ValoriSelezionati.Delimiter:=',';
    WC013ValoriSelezionati.CommaText:=(grdGestioneModuli.medpCompCella((grdGestioneModuli.medpClientDataSet as TClientDataSet).RecNo - 1, grdGestioneModuli.medpIndexColonna('DATO'),1) as TmeIWLabel).Caption;
    WC013.ImpostaValoriSelezionati(WC013ValoriSelezionati);
    WC013.ResultEvent:=ResultDatiEnte;
    WC013.Visualizza(0,0,'Dati ente');
  finally
    FreeAndNil(WC013Valori);
    FreeAndNil(WC013ValoriSelezionati);
  end;
end;

procedure TWA181FAziendeDettFM.grdGestioneModulipreparaComponenti;
begin
  grdGestioneModuli.medpDataSource:=TWA181FAziendeDM(WR302DM).D091;
  grdGestioneModuli.medpPreparaComponentiDefault;
  grdGestioneModuli.medpPreparaComponenteGenerico('WR102',grdGestioneModuli.medpIndexColonna('DATO'),0,DBG_CMB,'30','','','','S');
end;

procedure TWA181FAziendeDettFM.grdGestioneModuliComponenti2DataSet(Row: Integer);
begin
  inherited;
  if grdGestioneModuli.medpCompCella(Row,grdGestioneModuli.medpIndexColonna('DATO'),0) is TmeIWComboBox then
  begin
    grdGestioneModuli.medpDataSet.FieldByName('DATO').Text:=TmeIWComboBox(grdGestioneModuli.medpCompCella(Row,grdGestioneModuli.medpIndexColonna('DATO'),0)).Text
  end
  else if grdGestioneModuli.medpCompCella(Row,grdGestioneModuli.medpIndexColonna('DATO'),0) is TmeIWEdit then
  begin
    grdGestioneModuli.medpDataSet.FieldByName('DATO').Text:=TmeIWEdit(grdGestioneModuli.medpCompCella(Row,grdGestioneModuli.medpIndexColonna('DATO'),0)).Text;
  end
  else if grdGestioneModuli.medpCompCella(Row,grdGestioneModuli.medpIndexColonna('DATO'),1) is TmeIWLabel then
  begin
    grdGestioneModuli.medpDataSet.FieldByName('DATO').Text:=(grdGestioneModuli.medpCompCella(Row,grdGestioneModuli.medpIndexColonna('DATO'),1) as TmeIWLabel).Caption;
  end;
end;

procedure TWA181FAziendeDettFM.OpenSelezione(Row: Integer);
var
  iDato, i :integer;
begin
  iDato:=grdGestioneModuli.medpIndexColonna('DATO');
  if (WR302DM as TWA181FAziendeDM).A181MW.I091DatiEnteItems.ListaSelezione.Count <= 0 then
  begin
    TmeIWComboBox(grdGestioneModuli.medpCompCella(Row,iDato,0)).Free;
    grdGestioneModuli.medpPreparaComponenteGenerico('C', iDato,0,DBG_EDT,'30','','null','','S');
    grdGestioneModuli.medpCreaComponenteGenerico(Row, idato,grdGestioneModuli.Componenti);
  end
  else if not (WR302DM as TWA181FAziendeDM).A181MW.I091DatiEnteItems.MultiSelect then
  begin
    for i:=0 to (WR302DM as TWA181FAziendeDM).A181MW.I091DatiEnteItems.ListaSelezione.Count - 1 do
    begin
      (grdGestioneModuli.medpCompCella(Row,iDato,0) as TmeIWComboBox).Items.Add((WR302DM as TWA181FAziendeDM).A181MW.I091DatiEnteItems.ListaSelezione[i]);
    end;
  end
  else if (WR302DM as TWA181FAziendeDM).A181MW.I091DatiEnteItems.MultiSelect then
  begin
    //grdGestioneModuli.medpPreparaComponenteGenerico('C', iDato,0,DBG_LNK,'',(WR302DM as TWA181FAziendeDM).A181MW.QI091.FieldByName('DATO').AsString,'null','','S');
    grdGestioneModuli.medpPreparaComponenteGenerico('C', iDato,0,DBG_BTN,'','...','null','','S');
    grdGestioneModuli.medpPreparaComponenteGenerico('C', iDato,1,DBG_LBL,'',(WR302DM as TWA181FAziendeDM).A181MW.QI091.FieldByName('DATO').AsString,'null','','S');
    grdGestioneModuli.medpCreaComponenteGenerico(Row, idato,grdGestioneModuli.Componenti);
    (grdGestioneModuli.medpCompCella(Row,iDato,0) as TmeIWButton).Css:=(grdGestioneModuli.medpCompCella(Row,iDato,0) as TmeIWButton).Css + ' puntini';
    (grdGestioneModuli.medpCompCella(Row,iDato,0) as TmeIWButton).OnClick:=MultiselectClick;
  end;

  if grdGestioneModuli.medpCompCella(Row,iDato,0) is TmeIWComboBox then
  begin
    TmeIWComboBox(grdGestioneModuli.medpCompCella(Row,iDato,0)).NoSelectionText:=' ';
    TmeIWComboBox(grdGestioneModuli.medpCompCella(Row,iDato,0)).ItemIndex:=TmeIWComboBox(grdGestioneModuli.medpCompCella(Row,iDato,0)).Items.IndexOf(grdGestioneModuli.medpValoreColonna(Row,'DATO'));
  end
  else if grdGestioneModuli.medpCompCella(Row,iDato,0) is TmeIWEdit then
  begin
    TmeIWEdit(grdGestioneModuli.medpCompCella(Row,iDato,0)).Text:=grdGestioneModuli.medpValoreColonna(Row,'DATO');
  end
  else if grdGestioneModuli.medpCompCella(Row,iDato,1) is TmeIWLabel then
  begin
    TmeIWLabel(grdGestioneModuli.medpCompCella(Row,iDato,1)).Caption:=grdGestioneModuli.medpValoreColonna(Row,'DATO');
  end;
end;

procedure TWA181FAziendeDettFM.grdGestioneModuliDataSet2Componenti(Row: Integer);
var
  i: integer;
begin
  inherited;
  TWA181FAziendeDM(WR302DM).A181MW.I091DatiEnteItems.BeginUpdate;
  TWA181FAziendeDM(WR302DM).A181MW.I091DatiEnteItems.Clear_DatiEnteItems;
  TWA181FAziendeDM(WR302DM).A181MW.I091DatiEnteItems.BeginUpdate;
  for i:=1 to High(DatiEnte) do
  begin
    if TWA181FAziendeDM(WR302DM).A181MW.QI091.FieldByName('TIPO').AsString = DatiEnte[i].Nome then
    begin
      if not R180In(DatiEnte[i].Lista, ['','NUMERICO','GIORNO_MESE','ORA']) then
        (WR302DM as TWA181FAziendeDM).A181MW.PutElenco(TWA181FAziendeDM(WR302DM).A181MW.QI091.FieldByName('TIPO').AsString);
      break;
    end;
  end;
  OpenSelezione(Row);
end;

procedure TWA181FAziendeDettFM.ReleaseOggetti;
begin
  FreeAndNil(CdFnz);
  FreeAndNil(CdFnzWeb);
  inherited;
end;

procedure TWA181FAziendeDettFM.LogSelezionatutto1Click(Sender: TObject);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelleLog.Items.Count - 1 do
    cgpTabelleLog.IsChecked[i]:=True;
  cgpTabelleLog.AsyncUpdate;
end;

end.

