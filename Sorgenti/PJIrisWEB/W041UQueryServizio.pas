unit W041UQueryServizio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R012UWebAnagrafico, IWVCLComponent, IWApplication,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, A000UInterfaccia, OracleData, IWCompListbox, meIWComboBox,
  W041UQueryServizioDM, IWCompExtCtrls, meIWImageButton, IWCompGrids, IWDBGrids,
  medpIWDBGrid, meIWDBGrid, db, Vcl.Menus, IWCompEdit, meIWEdit, meIWGrid,
  System.Diagnostics, A000UCostanti, C004UParamForm;

type
  TW041FQueryServizio = class(TR012FWebAnagrafico)
    cmbRaggruppamenti: TmeIWComboBox;
    cmbInterrogazioni: TmeIWComboBox;
    btnEsegui: TmeIWImageButton;
    grdQuery: TmedpIWDBGrid;
    grdVariabili: TmedpIWDBGrid;
    pmnExcel: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    lblTempo: TmeIWLabel;
    mnuEsportaCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure cmbInterrogazioniChange(Sender: TObject);
    procedure cmbRaggruppamentiChange(Sender: TObject);
    procedure mnuEsportaExcelClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure mnuEsportaCSVClick(Sender: TObject);
  private
    { Private declarations }
    W041DM:TW041FQueryServizioDM;
    C004DM:TC004FParamForm;
    procedure CaricaComboInterrogazioni;
    procedure SettaGrdVariabili;
    procedure CaricamentoW041Query(NomeQuery:string);
    procedure EseguiQueryFiltrata(RefreshC700:Boolean);
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
    procedure OnCambiaProgressivo; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    //procedure VisualizzaDipendenteCorrente; override;
  end;

implementation

{$R *.dfm}

procedure TW041FQueryServizio.btnEseguiClick(Sender: TObject);
var
  r:integer;
  LStopWatch: TStopWatch;
begin
  inherited;

  W041DM.TuttiDipSelezionato:=TuttiDipSelezionato;
  W041DM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  if grdVariabili.medpDataSet.State in [dsInsert,dsEdit] then
    grdVariabili.medpDataSet.Cancel;
  grdVariabili.medpDataSet.Filtered:=True;
  grdVariabili.medpDataSet.First;
  for r:=0 to High(grdVariabili.medpCompGriglia) do
  begin
    grdVariabili.medpDataSet.Edit;
    grdVariabili.medpConferma(r);
    grdVariabili.medpDataSet.Next;
  end;
  grdVariabili.medpDataSet.Filtered:=False;

  // avvio timer di precisione
  LStopWatch:=TStopwatch.StartNew;
  try
    W041DM.A062MW.EseguiQuery;
  finally
    // stop timer di precisione
    LStopWatch.Stop;

    // il testo sarà questo:
    lblTempo.Caption:= 'Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
  end;

  grdQuery.medpAttivaGrid(W041DM.A062MW.Q1,False,False);
  EseguiQueryFiltrata(False);
  grdQuery.Visible:=True;
end;

procedure TW041FQueryServizio.OnCambiaProgressivo;
begin
  inherited;
  W041DM.TuttiDipSelezionato:=TuttiDipSelezionato;
  if Not W041DM.A062MW.Q1.Active then
    Exit;

  EseguiQueryFiltrata(True);
end;

procedure TW041FQueryServizio.EseguiQueryFiltrata(RefreshC700:Boolean);
var
  EsistonoVariabili:Boolean;
begin
  W041DM.A062MW.Q1.Filtered:=False;
  W041DM.A062MW.Q1.Filter:='';
  EsistonoVariabili:=False;
  if VarToStr(W041DM.A062MW.cdsValori.Lookup('VARIABILE','C700SelAnagrafe','VARIABILE')) <> '' then
  begin
    EsistonoVariabili:=True;
    W041DM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  end
  else if W041DM.A062MW.Q1.FindField('PROGRESSIVO') <> nil then
  begin
    EsistonoVariabili:=True;
    W041DM.A062MW.Q1.Filter:='PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    W041DM.A062MW.Q1.Filtered:=not TuttiDipSelezionato;
  end
  else if W041DM.A062MW.Q1.FindField('MATRICOLA') <> nil then
  begin
    EsistonoVariabili:=True;
    W041DM.A062MW.Q1.Filter:='MATRICOLA = ''' + selAnagrafeW.FieldByName('MATRICOLA').AsString + '''';
    W041DM.A062MW.Q1.Filtered:=not TuttiDipSelezionato;
  end;

  if EsistonoVariabili then
  begin
    //Rieseguo la query solo se intervengo sulla variabile C700SelAnagrafe (filtro sulla query)
    if (W041DM.A062MW.Q1.Filter = '') and (RefreshC700) then
      W041DM.A062MW.EseguiQuery;
    grdQuery.medpAggiornaCDS(True);
  end;
end;

procedure TW041FQueryServizio.mnuEsportaCSVClick(Sender: TObject);
begin
  //Esporto in csv
  if not Assigned(Sender) then
    csvDownload:=grdQuery.ToCsv
  else
    InviaFile('Interrogazione di servizio.xls',csvDownload);
end;

procedure TW041FQueryServizio.mnuEsportaExcelClick(Sender: TObject);
begin
  //Esporto in excel
  if not Assigned(Sender) then
    streamDownload:=grdQuery.ToXlsx
  else
    InviaFile('Interrogazione di servizio.xlsx',streamDownload);
end;

procedure TW041FQueryServizio.GetDipendentiDisponibili(Data:TDateTime);
begin
  ElementoTuttiDip:=not Parametri.InibizioneIndividuale;
  inherited;
  cmbDipendentiDisponibili.ItemIndex:=0;
end;


procedure TW041FQueryServizio.CaricaComboInterrogazioni;
begin
  if cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex] = 'Tutte le interrogazioni' then
    W041DM.A062MW.OpenSelT002(W041DM.selT002,'')
  else
    W041DM.A062MW.OpenSelT002(W041DM.selT002,cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex]);
  cmbInterrogazioni.Items.Clear;
  W041DM.selT002.First;
  while not W041DM.selT002.Eof do
  begin
    cmbInterrogazioni.Items.Add(W041DM.selT002.FieldByName('NOME').AsString);
    W041DM.selT002.Next;
  end;
  cmbInterrogazioni.ItemIndex:=0;
end;

procedure TW041FQueryServizio.CaricamentoW041Query(NomeQuery:string);
begin
  W041DM.A062MW.SqlNome:=NomeQuery;
  W041DM.A062MW.SqlSelezioneList.Clear;
  W041DM.A062MW.cdsValori.FieldByName('TIPO').ReadOnly:=False;
  W041DM.A062MW.CaricaQuery;
  {Solo per IrisWeb inibisco la modifica del tipo è svuoto il valore}
  W041DM.A062MW.cdsValori.FieldByName('TIPO').ReadOnly:=True;
end;

procedure TW041FQueryServizio.cmbInterrogazioniChange(Sender: TObject);
begin
  inherited;
  SettaGrdVariabili;
end;

procedure TW041FQueryServizio.cmbRaggruppamentiChange(Sender: TObject);
begin
  inherited;
  CaricaComboInterrogazioni;
  SettaGrdVariabili;
end;

procedure TW041FQueryServizio.SettaGrdVariabili;
begin
  grdVariabili.Visible:=False;
  if cmbInterrogazioni.Items.Count > 0 then
  begin
    CaricamentoW041Query(cmbInterrogazioni.Items[cmbInterrogazioni.ItemIndex]);
    grdVariabili.medpDataSet.Cancel;
    W041DM.A062MW.cdsValori.Filtered:=True;
    grdVariabili.medpAggiornaCDS(True);
    if grdVariabili.medpDataSet.RecordCount > 0 then
      grdVariabili.medpModifica(False);
    grdQuery.Visible:=False;
    W041DM.A062MW.Q1.Filter:='';
    W041DM.A062MW.Q1.Filtered:=False;
    grdVariabili.Visible:=grdVariabili.medpDataSet.RecordCount > 0;
  end;
end;

function TW041FQueryServizio.InizializzaAccesso:Boolean;
begin
  Result:=True;
  grdQuery.Visible:=False;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
  //Inizializzazione parametri grdQuery
  grdQuery.medpRighePagina:=GetRighePaginaTabella;
  grdQuery.medpDataSet:=W041DM.A062MW.cdsValori;
  grdQuery.medpBrowse:=False;

  W041DM.A062MW.CaricaCmbRaggruppamenti(cmbRaggruppamenti.Items); //Caricamento valori cmbRaggruppamenti
  cmbRaggruppamenti.ItemIndex:=cmbRaggruppamenti.Items.IndexOf('Tutte le interrogazioni'); //Set Combobox sul primo valore <Tutti i dipendenti>
  CaricaComboInterrogazioni;
  if cmbInterrogazioni.Items.Count > 0 then
  begin
    //Lettura query ed eventuali variabili prima di esecuzione
    CaricamentoW041Query(cmbInterrogazioni.Items[cmbInterrogazioni.ItemIndex]);
    //Inizializzazione parametri grdVariabili
    W041DM.A062MW.cdsValori.Filter:='(VARIABILE <> ''C700SelAnagrafe'') and (TIPO <> ''Nome_Utente'')';
    W041DM.A062MW.cdsValori.Filtered:=True;
    grdVariabili.medpPaginazione:=False;
    grdVariabili.medpDataSet:=W041DM.A062MW.cdsValori;
    grdVariabili.medpTestoNoRecord:='Nessuna variabile';
    grdVariabili.medpRowSelect:=False;
    grdVariabili.medpPaginazione:=False;
    grdVariabili.medpEditMultiplo:=True;
    grdVariabili.medpAttivaGrid(W041DM.A062MW.cdsValori,True,False,False);
    grdVariabili.medpModifica(False);
    grdVariabili.medpNascondiComandi;
    grdVariabili.Visible:=grdVariabili.medpDataSet.RecordCount > 0;
  end;
end;

{procedure TW041FQueryServizio.VisualizzaDipendenteCorrente;
begin

end;}

procedure TW041FQueryServizio.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  grdVariabili.Visible:=False;
  W041DM:=TW041FQueryServizioDM.Create(Self); //Creazione DataModulo
  C004DM:=CreaC004(SessioneOracle,'W041',Parametri.Operatore,False);
  W041DM.A062MW.C004DM_MW:=C004DM;
  W041DM.A062MW.SoloValoriVariabiliOperatore:=True;
end;

procedure TW041FQueryServizio.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(C004DM);
end;

procedure TW041FQueryServizio.IWAppFormRender(Sender: TObject);
begin
  inherited;
  lblTempo.Visible:=grdQuery.Visible;
end;

end.
