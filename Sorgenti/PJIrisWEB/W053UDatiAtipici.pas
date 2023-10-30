unit W053UDatiAtipici;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R012UWebAnagrafico, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  medpIWMultiColumnComboBox, A000UInterfaccia, W053UDatiAtipiciDM, IWDBGrids, medpIWDBGrid,
  Data.DB, Datasnap.DBClient, OracleData, StrUtils, IWApplication,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb;

type
  TW053FDatiAtipici = class(TR012FWebAnagrafico)
    lblMese: TmeIWLabel;
    edtMese: TmeIWEdit;
    lblDato: TmeIWLabel;
    cmbCodDato: TMedpIWMultiColumnComboBox;
    lblDescDato: TmeIWLabel;
    btnVisualizza: TmeIWButton;
    btnApplica: TmeIWButton;
    btnGenera: TmeIWButton;
    dgrdDettaglio: TmedpIWDBGrid;
    dsrT077: TDataSource;
    cdsT077: TClientDataSet;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCodDatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure dgrdDettaglioAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure dgrdDettaglioRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnGeneraClick(Sender: TObject);
    procedure btnApplicaClick(Sender: TObject);
  private
    { Private declarations }
    W053DM: TW053FDatiAtipiciDM;
    DataScheda:TDateTime;
    DatoGenerato:Boolean;
    procedure Dipendente(P:Integer);
    procedure CreaColonne;
    procedure DistruggiComponenti;
  protected
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TW053FDatiAtipici.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  W053DM:=TW053FDatiAtipiciDM.Create(Self);
  DatoGenerato:=False;

  // tabella dati atipici
  dgrdDettaglio.medpRighePagina:=GetRighePaginaTabella;
  dgrdDettaglio.medpPaginazione:=False; // Non gestire la paginazione!
  dgrdDettaglio.medpDataSet:=W053DM.selT077;
  dgrdDettaglio.medpTestoNoRecord:='Nessun dato';
  dgrdDettaglio.medpRowSelect:=False;
  dgrdDettaglio.medpComandiCustom:=True;

  lblDescDato.Caption:='';
  edtMese.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);

  (*SOLO PER TEST - INIZIO
  Parametri.AbilitaSchedeChiuse:='N';
  edtMese.Text:='12/2021';
  cmbCodDato.Text:='PROVA_DANILO';
  SOLO PER TEST - FINE*)

  edtMeseAsyncChange(nil,nil);
end;

procedure TW053FDatiAtipici.edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
var OldCodDato:String;
begin
  inherited;
  //Recupero la data di riferimento della scheda riepilogativa
  try
    DataScheda:=StrToDate('01/' + edtMese.Text);
  except
    edtMese.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
    DataScheda:=StrToDate('01/' + edtMese.Text);
  end;

  //Ricarico la lista dei dati atipici abilitati alla data della scheda
  OldCodDato:=cmbCodDato.Text;
  cmbCodDato.Text:='';
  lblDescDato.Caption:='';
  cmbCodDato.Items.Clear;
  with W053DM do
  begin
    selI011.Close;
    selI011.SetVariable('DATA',DataScheda);
    selI011.Open;
    selI011.Filtered:=True;
    while not selI011.Eof do
    begin
      cmbCodDato.AddRow(Format('%s;%s',[selI011.FieldByName('DATO').AsString,selI011.FieldByName('DESCRIZIONE').AsString]));
      selI011.Next;
    end;
    if not selI011.SearchRecord('DATO',OldCodDato,[srFromBeginning]) then
      selI011.First;
    cmbCodDato.Text:=selI011.FieldByName('DATO').AsString;
    lblDescDato.Caption:=selI011.FieldByName('DESCRIZIONE').AsString;
  end;

  //Ricarico la lista dei dipendenti disponibili alla data della scheda
  GetDipendentiDisponibili(DataScheda);

  //Ricarico la lista dei dipendenti disponibili alla data della scheda
  Dipendente(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);

  btnVisualizzaClick(nil);
end;

procedure TW053FDatiAtipici.GetDipendentiDisponibili(Data: TDateTime);
begin
  ElementoTuttiDip:=True;
  inherited;
end;

procedure TW053FDatiAtipici.Dipendente(P:Integer);
begin
  inherited;
  lnkDipendente.Caption:='';
  if not TuttiDipSelezionato then
    if not selAnagrafeW.SearchRecord('PROGRESSIVO',P,[srFromBeginning]) then
      selAnagrafeW.First;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnVisualizza.HTMLName]));
end;

procedure TW053FDatiAtipici.cmbCodDatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  lblDescDato.Caption:=VarToStr(W053DM.selI011.Lookup('DATO',cmbCodDato.Text,'DESCRIZIONE'));
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnVisualizza.HTMLName]));
end;

procedure TW053FDatiAtipici.btnVisualizzaClick(Sender: TObject);
begin
  inherited;
  VisualizzaDipendenteCorrente;
end;

procedure TW053FDatiAtipici.VisualizzaDipendenteCorrente;
var ElencoProg:String;
begin
  inherited;
  with W053DM do
  begin
    //Dataset della griglia dei dati atipici
    selT077.Close;
    selT077.SetVariable('DATO',cmbCodDato.Text);
    selT077.SetVariable('DATA',DataScheda);
    if TuttiDipSelezionato then
    begin
      selAnagrafeW.First;
      while not selAnagrafeW.Eof do
      begin
        ElencoProg:=ElencoProg + IfThen(ElencoProg <> '',',') + selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
        selAnagrafeW.Next;
      end;
    end
    else
      ElencoProg:=selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    selT077.SetVariable('SEL_ANA',ElencoProg);
    selT077.Open;

    //Dataset per eventuale generazione dato atipico per altri dipendenti
    R180SetVariable(selGenera,'DATA',DataScheda);
    R180SetVariable(selGenera,'DATO',cmbCodDato.Text);
    R180SetVariable(selGenera,'SEL_ANA',ElencoProg);
    R180SetVariable(selGenera,'SELEZIONE_ANAGRAFE',VarToStr(selI011.Lookup('DATO',cmbCodDato.Text,'SELEZIONE_ANAGRAFE')));
    if DatoGenerato then
      selGenera.Close;
    selGenera.Open;
    DatoGenerato:=False;
  end;
  CreaColonne;

  btnGenera.Visible:=not SolaLettura and (cmbCodDato.Text <> '') and (W053DM.selGenera.RecordCount > 0);
  btnApplica.Visible:=VarToStr(W053DM.selT077.Lookup('ABILITA','S','ABILITA')) = 'S';
end;

procedure TW053FDatiAtipici.CreaColonne;
begin
  dgrdDettaglio.medpBrowse:=True;

  dgrdDettaglio.medpCreaCDS;
  dgrdDettaglio.medpEliminaColonne;
  dgrdDettaglio.medpAggiungiColonna('PROGRESSIVO','Progressivo','',nil);
  dgrdDettaglio.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
  dgrdDettaglio.medpAggiungiColonna('COGNOME','Cognome','',nil);
  dgrdDettaglio.medpAggiungiColonna('NOME','Nome','',nil);
  dgrdDettaglio.medpAggiungiColonna('VALORE_AUT','Valore calcolato','',nil);
  dgrdDettaglio.medpAggiungiColonna('VALORE_MAN','Valore manuale','',nil);
  dgrdDettaglio.medpAggiungiColonna('MESSAGGI','Messaggi','',nil);
  dgrdDettaglio.medpColonna('PROGRESSIVO').Visible:=False;

  dgrdDettaglio.medpInizializzaCompGriglia;

  dgrdDettaglio.medpPreparaComponenteGenerico('R',dgrdDettaglio.medpIndexColonna('VALORE_MAN'),0,DBG_EDT,'input_num_generic','','','');
  dgrdDettaglio.medpCaricaCDS;
end;

procedure TW053FDatiAtipici.dgrdDettaglioAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,c: Integer;
begin
  // Righe dati
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
  begin
    // valore manuale
    c:=dgrdDettaglio.medpIndexColonna('VALORE_MAN');
    if dgrdDettaglio.medpValoreColonna(i,'ABILITA') = 'S' then
      (dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit).Text:=dgrdDettaglio.medpValoreColonna(i,'VALORE_MAN')
    else
      FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[c]);
  end;
end;

procedure TW053FDatiAtipici.dgrdDettaglioRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  inherited;

  if not dgrdDettaglio.medpRenderCell(ACell,ARow,AColumn,True,True) then
    exit;

  // assegnazione componenti alle celle
  NumColonna:=dgrdDettaglio.medpNumColonna(AColumn);
  if (ARow > 0) and (ARow - 1 <= High(dgrdDettaglio.medpCompGriglia)) and (dgrdDettaglio.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdDettaglio.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TW053FDatiAtipici.btnGeneraClick(Sender: TObject);
begin
  inherited;
  with W053DM do
  begin
    selGenera.First;
    while not selGenera.Eof do
    begin
      selT077.Append;
      selT077.FieldByName('PROGRESSIVO').AsInteger:=selGenera.FieldByName('PROGRESSIVO').AsInteger;
      selT077.FieldByName('DATA').AsDateTime:=DataScheda;
      selT077.FieldByName('DATO').AsString:=cmbCodDato.Text;
      selT077.FieldByName('VALORE_AUT').AsString:='';
      selT077.FieldByName('VALORE_MAN').AsString:='0';
      selT077.Post;
      selGenera.Next;
    end;
  end;
  DatoGenerato:=True;
  VisualizzaDipendenteCorrente;
end;

procedure TW053FDatiAtipici.btnApplicaClick(Sender: TObject);
var
  i,c: Integer;
  FN: String;
  IWC: TmeIWEdit;
begin
  inherited;
  c:=dgrdDettaglio.medpIndexColonna('VALORE_MAN');
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
    if dgrdDettaglio.medpCompCella(i,c,0) <> nil then
    begin
      // valore manuale
      IWC:=dgrdDettaglio.medpCompCella(i,c,0) as TmeIWEdit;
      FN:=IWC.FriendlyName;
      with W053DM.selT077 do
        if SearchRecord('ROWID',FN,[srFromBeginning]) then
        begin
          Edit;
          FieldByName('VALORE_MAN').AsString:=Trim(IWC.Text);
          if FieldByName('VALORE_MAN').IsNull then
            FieldByName('VALORE_MAN').AsString:='0';
          Post;
        end;
    end;
  dgrdDettaglio.medpCaricaCDS;
end;

procedure TW053FDatiAtipici.DistruggiComponenti;
var
  i,c: Integer;
begin
  for i:=0 to High(dgrdDettaglio.medpCompGriglia) do
  begin
    c:=dgrdDettaglio.medpIndexColonna('VALORE_MAN');
    FreeAndNil(dgrdDettaglio.medpCompGriglia[i].CompColonne[c]);
  end;
end;

end.
