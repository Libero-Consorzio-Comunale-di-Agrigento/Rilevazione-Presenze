unit WA176URiepilogoIterAutorizzativi;

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWDBStdCtrls, meIWDBEdit,
  medpIWMultiColumnComboBox, C190FunzioniGeneraliWeb, IWCompListbox,
  meIWComboBox, A000UCostanti, FunzioniGenerali, System.SysUtils, System.Classes, StrUtils,
  System.Variants, meIWRadioGroup, WC027UInfoDatiFM, Oracle, OracleData, A000USessione, meIWDBLookupComboBox;

type
  TWA176FRiepilogoIterAutorizzativi = class(TWR102FGestTabella)
    lblTipoIter: TmeIWLabel;
    lblDataDa: TmeIWLabel;
    lblDataA: TmeIWLabel;
    cmbTipoIter: TmeIWComboBox;
    edtDataDa: TmeIWEdit;
    edtDataA: TmeIWEdit;
    rgpAllegato: TmeIWRadioGroup;
    rgpCondizAllegato: TmeIWRadioGroup;
    lblAllegato: TmeIWLabel;
    lblCondizAllegato: TmeIWLabel;
    lblCausale: TmeIWLabel;
    cmbCausale: TMedpIWMultiColumnComboBox;
    lblDescCausale: TmeIWLabel;
    lblDataInserimento: TmeIWLabel;
    lblPeriodoRichiesto: TmeIWLabel;
    lblPeriodoDa: TmeIWLabel;
    lblPeriodoA: TmeIWLabel;
    edtPeriodoDa: TmeIWEdit;
    edtPeriodoA: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbTipoIterChange(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure rgpAllegatoAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    WC027:TWC027FInfoDatiFM;
    procedure CaricaCmbTipoIter;
    procedure ImpostaVarFiltro;
    procedure PopolaComboCausale(PDataSet: TOracleDataSet);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    procedure ApriDataSetIterAutorizzativi;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure imgElaboraClick(Sender:TObject);
    procedure imgGestioneRichiestaClick(Sender:TObject);
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses
  WA176URiepilogoIterAutorizzativiDM, WA176URiepilogoIterAutorizzativiBrowseFM,
  IWApplication, meIWImageFile, WA176UGestioneIterAutorizzativiFM;

{$R *.dfm}

procedure TWA176FRiepilogoIterAutorizzativi.ImpostaVarFiltro;
var
  MyDate:TDateTime;
begin
  if TryStrToDate(edtDataDa.Text,MyDate) then
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataRichDa:=MyDate
  else
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataRichDa:=DATE_NULL;

  if TryStrToDate(edtDataA.Text,MyDate) then
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataRichA:=MyDate
  else
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataRichA:=DATE_MAX;

  if TryStrToDate(edtPeriodoDa.Text,MyDate) then
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.PeriodoRichDa:=MyDate
  else
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.PeriodoRichDa:=DATE_NULL;

  if TryStrToDate(edtPeriodoA.Text,MyDate) then
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.PeriodoRichA:=MyDate
  else
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.PeriodoRichA:=DATE_MAX;

  if (cmbCausale.Enabled) and (cmbCausale.ItemIndex >= 0) then
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.Causale:=(VarToStr(CmbCausale.Text))
  else
    (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.Causale:='';

  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.TipoEstrazioneIter:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.IterDescToCod(cmbTipoIter.Items[cmbTipoIter.ItemIndex]);
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.CondizAllegato:=rgpCondizAllegato.Items[rgpCondizAllegato.ItemIndex];
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.AllegatoExist:=rgpAllegato.Items[rgpAllegato.ItemIndex];
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.Progressivo:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
end;

procedure TWA176FRiepilogoIterAutorizzativi.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent,Operation);
  if (AComponent = WC027) and (Operation = opRemove) then
    WC027:=nil;
end;

procedure TWA176FRiepilogoIterAutorizzativi.PopolaComboCausale(PDataSet: TOracleDataSet);
// popola la multicolumncombobox delle causali indicata con i valori
begin
  if not Assigned(PDataSet) then
    raise Exception.Create('Dataset non indicato');

  if PDataSet.Active then
  begin
    cmbCausale.Items.Clear;
    PDataSet.First;
    while not PDataSet.Eof do
    begin
      cmbCausale.AddRow(PDataSet.FieldByName('CODICE').AsString + ';' + PDataSet.FieldByName('DESCRIZIONE').AsString);
      PDataSet.Next;
    end;
  end;
end;

procedure TWA176FRiepilogoIterAutorizzativi.rgpAllegatoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ImpostaVarFiltro;
  ApriDataSetIterAutorizzativi;
end;

procedure TWA176FRiepilogoIterAutorizzativi.imgElaboraClick(Sender:TObject);
var
  r, ID: Integer;
begin
  r:=(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  ID:=(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpValoreColonna(r,'T850ID').ToInteger;
  if WC027 <> nil then
  begin
    try
      WC027.btnChiudiClick(nil);
    except
    end;
  end;
  WC027:=TWC027FInfoDatiFM.Create(Self);
  WC027.FreeNotification(Self);
  WC027.SolaLettura:=SolaLettura;
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo.Locate('T850ID', ID, []);   //Necessario per posizionare il cursore sulla riga giusta
  WC027.C018:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.C018;
  WC027.MostraInfoRichiesta((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo);
end;

procedure TWA176FRiepilogoIterAutorizzativi.imgGestioneRichiestaClick(Sender:TObject);
var
  WA176FGestioneIterAutorizzativiFM:TWA176FGestioneIterAutorizzativiFM;
  r, ID:integer;
  Iter, CodIter:string;
begin
  r:=(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  ID:=(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpValoreColonna(r,'T850ID').ToInteger;
  Iter:=(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpValoreColonna(r,'T850ITER');
  CodIter:=(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpValoreColonna(r,'T850COD_ITER');
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.SetIDIter(Iter, CodIter, ID);
  WA176FGestioneIterAutorizzativiFM:=TWA176FGestioneIterAutorizzativiFM.Create(Self);
  WA176FGestioneIterAutorizzativiFM.Visualizza;
end;

procedure TWA176FRiepilogoIterAutorizzativi.actAggiornaExecute(Sender: TObject);
begin
  ImpostaVarFiltro;
  ApriDataSetIterAutorizzativi;
end;

procedure TWA176FRiepilogoIterAutorizzativi.ApriDataSetIterAutorizzativi;
begin
  //Apro DataSet selezionato
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.OpenDataSetAttivo;
  //Assegno il DataSet selezionato al DataSource di dsrTabella
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).dsrTabella.DataSet:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).selTabella;
  //Uso medpAttivaGrid per pulire il ClientDataSet della medpGrid
  (WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpAttivaGrid((WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo,False,False,False);
  //Specifico di nuovo la creazione dei comandi personalizzati
  (WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpComandiCustom:=True;
  (WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpPreparaComponenteGenerico('WR102-R',(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','DETTAGLIO','Info richiesta','','');
  (WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpPreparaComponenteGenerico('WR102-R',(WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpIndexColonna('DBG_COMANDI'),1,DBG_IMG,'','CAMBIADATO','Gestione richiesta','','');
  //Carico il DataSet
  //Generalmente se ne occupa medpAttivaGrid, ma se "medpComandiCustom=True"
  //è necessario farlo a mano dopo aver ridichiarto i comandi personalizzati
  (WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpCaricaCDS;
end;

procedure TWA176FRiepilogoIterAutorizzativi.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  ImpostaVarFiltro;
  ApriDataSetIterAutorizzativi;
end;

procedure TWA176FRiepilogoIterAutorizzativi.cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.Causale:=(VarToStr(CmbCausale.Text));
  if cmbCausale.ItemIndex >= 0 then
    lblDescCausale.Caption:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.selT265T275.Lookup('CODICE',cmbCausale.Text,'DESCRIZIONE')
  else
    lblDescCausale.Caption:='    ';
  ApriDataSetIterAutorizzativi;
end;

procedure TWA176FRiepilogoIterAutorizzativi.cmbTipoIterChange(Sender: TObject);
begin
  inherited;
  ImpostaVarFiltro;
  ApriDataSetIterAutorizzativi;
  cmbCausale.Enabled:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.TipoEstrazioneIter = ITER_GIUSTIF;
  lblCausale.Enabled:=cmbCausale.Enabled;
  lblDescCausale.Enabled:=cmbCausale.Enabled;
end;

procedure TWA176FRiepilogoIterAutorizzativi.edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ImpostaVarFiltro;
  ApriDataSetIterAutorizzativi;
end;

function TWA176FRiepilogoIterAutorizzativi.InizializzaAccesso:Boolean;
begin
  //Inizializzazione
  Result:=True;
end;

procedure TWA176FRiepilogoIterAutorizzativi.CaricaCmbTipoIter;
var
  i:integer;
begin
  //A000IterAutorizzativi dichiarato su unit constanti
  for i:=low(A000IterAutorizzativi) to High(A000IterAutorizzativi) do
  begin
    if A000FiltroDizionario('ITER AUTORIZZATIVI', A000IterAutorizzativi[i].Cod) then
      cmbTipoIter.Items.Add(A000IterAutorizzativi[i].Desc);
  end;
  cmbTipoIter.ItemIndex:=0;//cmbTipoIter.Items.IndexOf('Giustificativi');
end;

procedure TWA176FRiepilogoIterAutorizzativi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.GestioneStoricizzata:=False;
  WR302DM:=TWA176FRiepilogoIterAutorizzativiDM.Create(Self);

  //Carico elenco iter autorizzativi
  CaricaCmbTipoIter;
  //Imposto progressivo = -1 - nessin risultato previsto
  //(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.Progressivo:=-1;
  //Imposto il tipo d'estrazione mediante l'iter autorizzativo
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.TipoEstrazioneIter:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.IterDescToCod(cmbTipoIter.Items[cmbTipoIter.ItemIndex]);
  //Inizializzo data DA
  edtDataDa.Text:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataRichDa.ToString;
  //Inizializzo data A
  edtDataA.Text:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataRichA.ToString;
  //Inizializzo periodo DA
  edtPeriodoDa.Text:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.PeriodoRichDa.ToString;
  //Inizializzo periodo A
  edtPeriodoA.Text:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.PeriodoRichA.ToString;
  //Apertura dataset  selezionato e filtrato
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.OpenDataSetAttivo;
  //=======================================================================================
  //Operazioni di riassegnazione dei componenti necessarie, in quanto il dataset utilizzato
  //può cambiare in base all'iter selezionato
  //=======================================================================================
  //Assegno il dataset attivo a selTabella
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).selTabella:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).A176MW.DataSetAttivo;
  //Assegno il selTabella attivo a dsrTabella
  (WR302DM as TWA176FRiepilogoIterAutorizzativiDM).dsrTabella.DataSet:=(WR302DM as TWA176FRiepilogoIterAutorizzativiDM).selTabella;
  //=======================================================================================
  WBrowseFM:=TWA176FRiepilogoIterAutorizzativiBrowseFM.Create(Self);
  (WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.RigaInserimento:=False;
  (WBrowseFM as TWA176FRiepilogoIterAutorizzativiBrowseFM).grdTabella.medpCaricaCDS;
  //Attivo la gestione C700 x ultima
  AttivaGestioneC700;

  PopolaComboCausale(TWA176FRiepilogoIterAutorizzativiDM(WR302DM).A176MW.selT265T275);

  WC027:=nil;
end;

procedure TWA176FRiepilogoIterAutorizzativi.IWAppFormDestroy(Sender: TObject);
begin
  if WC027 <> nil then
  begin
    try
      WC027.btnChiudiClick(nil);
    except
    end;
    WC027:=nil;
  end;
  inherited;
end;

end.
