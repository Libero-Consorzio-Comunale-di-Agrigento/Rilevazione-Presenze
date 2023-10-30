unit WA186ULoginDipendentiProfiliFM;

interface

uses
  Windows,Messages,SysUtils,Variants,Classes,Graphics,Controls,Forms,
  Dialogs,WR203UGestDetailFM,ActnList,IWVCLComponent,
  IWBaseLayoutComponent,IWBaseContainerLayout,IWContainerLayout,
  IWTemplateProcessorHTML,IWDBGrids,medpIWDBGrid,IWVCLBaseControl,
  IWBaseControl,IWBaseHTMLControl,IWControl,meIWGrid, medpIWMultiColumnComboBox,
  IWVCLBaseContainer,IWContainer,IWHTMLContainer,IWHTML40Container,IWRegion,
  Db,Oracle,OracleData,A000UInterfaccia,A000UCostanti,A000USessione,IWCompJQueryWidget,IWCompGrids,
  C190FunzioniGeneraliWeb,meIWComboBox,C180FunzioniGenerali,meIWEdit,
  System.Actions,Vcl.Menus;

type
  TWA186FLoginDipendentiProfiliFM = class(TWR203FGestDetailFM)
    actVisioneCorrente: TAction;
    actRiportaSuImpostazione: TAction;
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure actVisioneCorrenteExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
    procedure actRiportaSuImpostazioneExecute(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses
  WA186ULoginDipendentiDM,
  WA186ULoginDipendenti,
  WA186ULoginDipendentiBrowseFM;

{$R *.dfm}

procedure TWA186FLoginDipendentiProfiliFM.IWFrameRegionRender(Sender: TObject);
var
  LModalitaVisualizzazione: Boolean;
  LModificato: Boolean;
begin
  inherited;

  // modalità visualizzazione
  LModalitaVisualizzazione:=TWA186FLoginDipendenti(Owner).ModalitaVisualizzazione;

  // determina se alcune action sono state modificate
  LModificato:=actRiportaSuImpostazione.Visible <> not LModalitaVisualizzazione;

  // imposta visibilità azioni in base alla "modalità visualizzazione"
  actRiportaSuImpostazione.Visible:=not LModalitaVisualizzazione;

  // se ci sono state modifiche aggiorna la toolbar
  if LModificato then
    TWA186FLoginDipendenti(Owner).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
end;

procedure TWA186FLoginDipendentiProfiliFM.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  actVisioneCorrente.Enabled:=(grdTabella.medpStato = msBrowse);
  actRiportaSuImpostazione.Enabled:=(grdTabella.medpStato = msBrowse);
  (Owner as TWA186FLoginDipendenti).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
end;

procedure TWA186FLoginDipendentiProfiliFM.actConfermaExecute(Sender: TObject);
begin
  inherited;
  actVisioneCorrente.Enabled:=(grdTabella.medpStato = msBrowse);
  actRiportaSuImpostazione.Enabled:=(grdTabella.medpStato = msBrowse);
  (Owner as TWA186FLoginDipendenti).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
end;

procedure TWA186FLoginDipendentiProfiliFM.actModificaExecute(Sender: TObject);
begin
  inherited;
  actVisioneCorrente.Enabled:=(grdTabella.medpStato = msBrowse);
  actRiportaSuImpostazione.Enabled:=(grdTabella.medpStato = msBrowse);
  (Owner as TWA186FLoginDipendenti).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
end;

procedure TWA186FLoginDipendentiProfiliFM.actNuovoExecute(Sender: TObject);
begin
  inherited;
  actVisioneCorrente.Enabled:=(grdTabella.medpStato = msBrowse);
  actRiportaSuImpostazione.Enabled:=(grdTabella.medpStato = msBrowse);
  (Owner as TWA186FLoginDipendenti).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
end;

procedure TWA186FLoginDipendentiProfiliFM.actRiportaSuImpostazioneExecute(Sender: TObject);
var WA186DM:TWA186FLoginDipendentiDM;
  WA186Browse:TWA186FLoginDipendentiBrowseFM;
begin
  inherited;
  WA186DM:=(Owner as TWA186FLoginDipendenti).WR302DM as TWA186FLoginDipendentiDM;
  WA186Browse:=((Owner as TWA186FLoginDipendenti).WBrowseFM as TWA186FLoginDipendentiBrowseFM);
  if Trim(WA186DM.selI061.FieldByName('NOME_PROFILO').AsString) <> '' then
  begin
    WA186Browse.cmbNomeProfilo.ItemIndex:=R180IndexOf(WA186Browse.cmbNomeProfilo.Items,WA186DM.selI061.FieldByName('NOME_PROFILO').AsString,30);
    WA186Browse.cmbPermessi.ItemIndex:=R180IndexOf(WA186Browse.cmbPermessi.Items,WA186DM.selI061.FieldByName('PERMESSI').AsString,20);
    WA186Browse.cmbFiltroAnagrafe.ItemIndex:=R180IndexOf(WA186Browse.cmbFiltroAnagrafe.Items,WA186DM.selI061.FieldByName('FILTRO_ANAGRAFE').AsString,20);
    WA186Browse.cmbFiltroFunzioni.ItemIndex:=R180IndexOf(WA186Browse.cmbFiltroFunzioni.Items,WA186DM.selI061.FieldByName('FILTRO_FUNZIONI').AsString,20);
    WA186Browse.cmbIterAutor.ItemIndex:=R180IndexOf(WA186Browse.cmbIterAutor.Items,WA186DM.selI061.FieldByName('ITER_AUTORIZZATIVI').AsString,20);
    WA186Browse.cmbFiltroDizionario.ItemIndex:=R180IndexOf(WA186Browse.cmbFiltroDizionario.Items,WA186DM.selI061.FieldByName('FILTRO_DIZIONARIO').AsString,20);
  end;
end;

procedure TWA186FLoginDipendentiProfiliFM.actVisioneCorrenteExecute(
  Sender: TObject);
var
 WA186FLoginDipendentiDM:TWA186FLoginDipendentiDM;
begin
  WA186FLoginDipendentiDM:=(Owner as TWA186FLoginDipendenti).WR302DM as TWA186FLoginDipendentiDM;
  WA186FLoginDipendentiDM.selTI061VisioneCorrente:=not WA186FLoginDipendentiDM.selTI061VisioneCorrente;
  WA186FLoginDipendentiDM.selI061.Filtered:=(WA186FLoginDipendentiDM.selI061.Filter <> '') or
                                             (WA186FLoginDipendentiDM.selTI061VisioneCorrente);
  actVisioneCorrente.Checked:=WA186FLoginDipendentiDM.selTI061VisioneCorrente;
  (Owner as TWA186FLoginDipendenti).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
  grdTabella.medpCaricaCDS;
end;

procedure TWA186FLoginDipendentiProfiliFM.CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource);
begin
  grdTabella.medpEditMultiplo:=True; // Massimo 06/11/2012
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOME_PROFILO'),0,DBG_MECMB,'20','1','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('LOGIN_DEFAULT'),0,DBG_CMB,'2','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PERMESSI'),0,DBG_CMB,'20','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FILTRO_FUNZIONI'),0,DBG_CMB,'20','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0,DBG_CMB,'20','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FILTRO_DIZIONARIO'),0,DBG_CMB,'20','','','','S');
  // filtro iter autorizzativi.ini
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ITER_AUTORIZZATIVI'),0,DBG_CMB,'20','','','','S');
  // filtro iter autorizzativi.fine
  // modifica delegato_da.ini
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DELEGATO_DA'),0,DBG_EDT,'30','','','','S');
  // modifica delegato_da.fine
  // ricezione mail.ini
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('RICEZIONE_MAIL'),0,DBG_CMB,'2','','','','S');
  // ricezione mail.fine
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('AUTO_ESCLUSIONE'),0,DBG_CMB,'2','','','','S');
end;

procedure TWA186FLoginDipendentiProfiliFM.grdTabellaComponenti2DataSet(Row: Integer);
var i:Integer;
begin
  inherited;
  for i:=0 to High(grdTabella.medpCompGriglia[Row].CompColonne) do
  begin
    if (grdTabella.medpDataSet.FindField(grdTabella.medpColonna(i).DataField) <> nil) and
       (grdTabella.medpCompGriglia[Row].CompColonne[i] <> nil) then
    begin
      if grdTabella.medpCompCella(row,i,0) is TmeIWComboBox then
        grdTabella.medpDataSet.FindField(grdTabella.medpColonna(i).DataField).AsString:=TmeIWComboBox(grdTabella.medpCompCella(Row,i,0)).Text;
    end;
  end;

  grdTabella.medpDataSet.FieldByName('AZIENDA').AsString:=TWA186FLoginDipendentiDM(TWA186FLoginDipendenti(Self.Parent).WR302DM).selTabella.FieldByName('AZIENDA').AsString;
  grdTabella.medpDataSet.FieldByName('NOME_UTENTE').AsString:=TWA186FLoginDipendentiDM(TWA186FLoginDipendenti(Self.Parent).WR302DM).selTabella.FieldByName('NOME_UTENTE').AsString;
end;

procedure TWA186FLoginDipendentiProfiliFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  ElementiJQ:String;
  IWC: TmeIWComboBox;
  IWMC: TMedpIWMultiColumnComboBox;
begin
  inherited;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PERMESSI'),0)).Items.Clear;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PERMESSI'),0)).NoSelectionText:=' ';
  TWA186FLoginDipendenti(Self.Parent).CaricaCmbPermessi(TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PERMESSI'),0)));
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PERMESSI'),0)).ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PERMESSI'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row,'PERMESSI'));

  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_FUNZIONI'),0)).Items.Clear;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_FUNZIONI'),0)).NoSelectionText:=' ';
  TWA186FLoginDipendenti(Self.Parent).CaricaCmbFiltroFunzioni(TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_FUNZIONI'),0)));
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_FUNZIONI'),0)).ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_FUNZIONI'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row,'FILTRO_FUNZIONI'));

  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0)).Items.Clear;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0)).NoSelectionText:=' ';
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0)).RequireSelection:=False;
  TWA186FLoginDipendenti(Self.Parent).CaricaCmbFiltroAnagrafe(TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0)));
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0)).ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row,'FILTRO_ANAGRAFE'));

  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_DIZIONARIO'),0)).Items.Clear;
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_DIZIONARIO'),0)).NoSelectionText:=' ';
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_DIZIONARIO'),0)).RequireSelection:=False;
  TWA186FLoginDipendenti(Self.Parent).CaricaCmbFiltroDizionario(TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_DIZIONARIO'),0)));
  TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_DIZIONARIO'),0)).ItemIndex:=TmeIWComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FILTRO_DIZIONARIO'),0)).Items.IndexOf(grdTabella.medpValoreColonna(Row,'FILTRO_DIZIONARIO'));

  ////PALERMO_POLICLINICO - 159894: nome profilo.inizio
  IWMC:=(grdTabella.medpCompCella(Row,'NOME_PROFILO',0) as TMedpIWMultiColumnComboBox);
  if IWMC <> nil then
  begin
    IWMC.Items.Clear;
    //IWMC.NoSelectionText:=' ';
    (Self.Parent as TWA186FLoginDipendenti).CaricaCmbNomeProfilo(IWMC);
    IWMC.Text:=grdTabella.medpValoreColonna(Row,'NOME_PROFILO');
    IWMC.Editable:=True;
    IWMC.NonEditableAsLabel:=False;
    IWMC.CustomElement:=True;
  end;
  // nome profilo.fine

  // login default.ini
  IWC:=(grdTabella.medpCompCella(Row,'LOGIN_DEFAULT',0) as TmeIWComboBox);
  if IWC <> nil then
  begin
    IWC.Items.Clear;
    IWC.NoSelectionText:=' ';
    IWC.Items.Add('S');
    IWC.Items.Add('N');
    IWC.ItemIndex:=IWC.Items.IndexOf(grdTabella.medpValoreColonna(Row,'LOGIN_DEFAULT'));
  end;
  // login default.fine

  // filtro iter autorizzativi.ini
  IWC:=(grdTabella.medpCompCella(Row,'ITER_AUTORIZZATIVI',0) as TmeIWComboBox);
  if IWC <> nil then
  begin
    IWC.Items.Clear;
    IWC.NoSelectionText:=' ';
    IWC.RequireSelection:=False;
    (Self.Parent as TWA186FLoginDipendenti).CaricaCmbFiltroIter(IWC);
    IWC.ItemIndex:=IWC.Items.IndexOf(grdTabella.medpValoreColonna(Row,'ITER_AUTORIZZATIVI'));
  end;
  // filtro iter autorizzativi.fine

  // ricezione mail.ini
  IWC:=(grdTabella.medpCompCella(Row,'RICEZIONE_MAIL',0) as TmeIWComboBox);
  if IWC <> nil then
  begin
    IWC.Items.Clear;
    IWC.NoSelectionText:=' ';
    IWC.Items.Add('S');
    IWC.Items.Add('N');
    IWC.ItemIndex:=IWC.Items.IndexOf(grdTabella.medpValoreColonna(Row,'RICEZIONE_MAIL'));
  end;
  // ricezione mail.fine

  IWC:=(grdTabella.medpCompCella(Row,'AUTO_ESCLUSIONE',0) as TmeIWComboBox);
  if IWC <> nil then
  begin
    IWC.Items.Clear;
    IWC.NoSelectionText:=' ';
    IWC.Items.Add('S');
    IWC.Items.Add('N');
    IWC.ItemIndex:=IWC.Items.IndexOf(grdTabella.medpValoreColonna(Row,'AUTO_ESCLUSIONE'));
  end;
  // impostazioni in fase di inserimento
  if grdTabella.medpDataSet.State = dsInsert then
  begin
    // inizio e fine validità
    (grdTabella.medpCompCella(Row,'INIZIO_VALIDITA',0) as TmeIWEdit).Text:='01/01/1900';
    (grdTabella.medpCompCella(Row,'FINE_VALIDITA',0) as TmeIWEdit).Text:='31/12/3999';
    // profili indicati nel riquadro "Impostazione profili" (BrowseFM)
    (grdTabella.medpCompCella(Row,'PERMESSI',0) as TmeIWComboBox).ItemIndex:=((Self.Parent as TWA186FLoginDipendenti).WBrowseFM as TWA186FLoginDipendentiBrowseFM).cmbPermessi.ItemIndex;
    (grdTabella.medpCompCella(Row,'FILTRO_ANAGRAFE',0) as TmeIWComboBox).ItemIndex:=((Self.Parent as TWA186FLoginDipendenti).WBrowseFM as TWA186FLoginDipendentiBrowseFM).cmbFiltroAnagrafe.ItemIndex;
    (grdTabella.medpCompCella(Row,'FILTRO_DIZIONARIO',0) as TmeIWComboBox).ItemIndex:=((Self.Parent as TWA186FLoginDipendenti).WBrowseFM as TWA186FLoginDipendentiBrowseFM).cmbFiltroDizionario.ItemIndex;
    (grdTabella.medpCompCella(Row,'ITER_AUTORIZZATIVI',0) as TmeIWComboBox).ItemIndex:=((Self.Parent as TWA186FLoginDipendenti).WBrowseFM as TWA186FLoginDipendentiBrowseFM).cmbIterAutor.ItemIndex;
    //PALERMO_POLICLINICO - 159894: assegnazione dei valori mancanti
    (grdTabella.medpCompCella(Row,'NOME_PROFILO',0) as TMedpIWMultiColumnComboBox).ItemIndex:=((Self.Parent as TWA186FLoginDipendenti).WBrowseFM as TWA186FLoginDipendentiBrowseFM).cmbNomeProfilo.ItemIndex;
    (grdTabella.medpCompCella(Row,'FILTRO_FUNZIONI',0) as TmeIWComboBox).ItemIndex:=((Self.Parent as TWA186FLoginDipendenti).WBrowseFM as TWA186FLoginDipendentiBrowseFM).cmbFiltroFunzioni.ItemIndex;
  end;

  //PALERMO_POLICLINICO - 159894: Colonna NOME_PROFILO gestita come le altre
  (*if Profili <> '' then
  begin
    if JQuery.OnReady.Text = '' then
      ElementiJQ:='var elementi = [' + Copy(Profili,1,Length(Profili) - 1) + '];';

    JQuery.OnReady.Add(ElementiJQ);
    JQuery.OnReady.Add('$("#' +  TmeIWEdit(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NOME_PROFILO'),0)).HTMLName + '").autocomplete({');
    JQuery.OnReady.Add('  source: elementi');
    JQuery.OnReady.Add('});');
  end;*)
end;

end.
