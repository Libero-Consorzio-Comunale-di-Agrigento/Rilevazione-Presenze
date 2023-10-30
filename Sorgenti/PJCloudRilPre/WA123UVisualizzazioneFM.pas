unit WA123UVisualizzazioneFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWApplication,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, meIWEdit, OracleData,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, medpIWMultiColumnComboBox, IWCompGrids, IWDBGrids, medpIWDBGrid,meIWImageFile,
  A000UInterfaccia, C190FunzioniGeneraliWeb, A000UCostanti;

type
  TWA123FVisualizzazioneFM = class(TWR200FBaseFM)
    lblOrdina1: TmeIWLabel;
    lblOrdina2: TmeIWLabel;
    lblOrdina3: TmeIWLabel;
    edtOrdina1: TmeIWEdit;
    edtOrdina2: TmeIWEdit;
    edtOrdina3: TmeIWEdit;
    lblOrganismo: TmeIWLabel;
    lblSindacato: TmeIWLabel;
    lblData: TmeIWLabel;
    edtData: TmeIWEdit;
    cmbSindacato: TMedpIWMultiColumnComboBox;
    cmbOrganismo: TMedpIWMultiColumnComboBox;
    lblOrganismoDescr: TmeIWLabel;
    lblSindacatoDescr: TmeIWLabel;
    grdVisualizzazione: TmedpIWDBGrid;
    procedure grdVisualizzazioneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbOrganismoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtOrdina1AsyncChange(Sender: TObject; EventParams: TStringList);
    procedure grdVisualizzazioneAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    procedure Aggiorna;
    procedure AggiornaDescrizioni;
    procedure imgAccediClick(Sender: TObject);
  public
    { Public declarations }
  end;


implementation

uses WA123UPartecipazioniSindacati, WA123UPartecipazioniSindacatiDM;

{$R *.dfm}

procedure TWA123FVisualizzazioneFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  edtData.Text:=DateTimeToStr(Parametri.DataLavoro);
  edtDataAsyncChange(nil,nil);
  Aggiorna;
  with ((Self.Owner as TWA123FPartecipazioniSindacati).WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW do
  begin
    grdVisualizzazione.medpPaginazione:=False;
    grdVisualizzazione.medpComandiCustom:=True;
    grdVisualizzazione.medpRowSelect:=False;
    grdVisualizzazione.medpAttivaGrid(selT247A, False, False);
    grdVisualizzazione.medpPreparaComponentiDefault;
    grdVisualizzazione.medpPreparaComponenteGenerico('WR102-R',grdVisualizzazione.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','','','');
    //popolo comboBox
    selT245A.First;
    while not selT245A.Eof do
    begin
      cmbOrganismo.AddRow(selT245A.FieldByName('CODICE').AsString+';'+selT245A.FieldByName('DESCRIZIONE').AsString);
      selT245A.Next;
    end;
    selT245A.First;
    while not selT240A.Eof do
    begin
      cmbSindacato.AddRow(selT240A.FieldByName('CODICE').AsString+';'+selT240A.FieldByName('DESCRIZIONE').AsString);
      selT240A.Next;
    end;
  end;
  AggiornaDescrizioni;
  if grdVisualizzazione.medpDataSet <> nil then
    grdVisualizzazione.medpAggiornaCDS(True);
end;

procedure TWA123FVisualizzazioneFM.AggiornaDescrizioni;
begin
  lblOrganismoDescr.Caption:='';
  lblSindacatoDescr.Caption:='';
  cmbSindacato.Text:=Trim(cmbSindacato.Text);
  cmbOrganismo.Text:=Trim(cmbOrganismo.Text);
  with ((Self.Owner as TWA123FPartecipazioniSindacati).WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW do
  begin
    if (cmbSindacato.Text <> '') and (selT240A.SearchRecord('CODICE',cmbSindacato.Text,[srFromBeginning])) then
       lblSindacatoDescr.Caption:=selT240A.FieldByName('DESCRIZIONE').AsString;
    if (cmbOrganismo.Text <> '') and (selT245A.SearchRecord('CODICE',cmbSindacato.Text,[srFromBeginning])) then
       lblOrganismoDescr.Caption:=selT245A.FieldByName('DESCRIZIONE').AsString;
  end;
end;

procedure TWA123FVisualizzazioneFM.cmbOrganismoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  Aggiorna;
  AggiornaDescrizioni;
end;

procedure TWA123FVisualizzazioneFM.edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with ((Self.Owner as TWA123FPartecipazioniSindacati).WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW.selT240A do
  begin
    DisableControls;
    Close;
    SetVariable('DATA',StrToDateTime(edtData.Text));
    Open;
    EnableControls;
  end;
  with ((Self.Owner as TWA123FPartecipazioniSindacati).WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW.selT245A do
  begin
    DisableControls;
    Close;
    SetVariable('DATA',StrToDateTime(edtData.Text));
    Open;
    EnableControls;
  end;
  Aggiorna;
  AggiornaDescrizioni;
end;

procedure TWA123FVisualizzazioneFM.edtOrdina1AsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  Aggiorna;
  AggiornaDescrizioni;
end;

procedure TWA123FVisualizzazioneFM.grdVisualizzazioneAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var r  : Integer;
    img: TmeIWImageFile;
begin
  inherited;
  for r :=0 to High(grdVisualizzazione.medpCompGriglia) do
    if grdVisualizzazione.medpCompCella(r,grdVisualizzazione.medpIndexColonna('DBG_COMANDI'),0) <> nil then
    begin
      img:=(grdVisualizzazione.medpCompCella(r,grdVisualizzazione.medpIndexColonna('DBG_COMANDI'),0) as TmeIWImageFile);
      img.Enabled:=true;
      img.Hint:='Accedi a organizzazioni sindacali';
      img.OnClick:=imgAccediClick;
    end;
end;

procedure TWA123FVisualizzazioneFM.imgAccediClick(Sender: TObject);
var r: Integer;
    Params: String;
begin
  r:=grdVisualizzazione.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Params:='TIPO=S' + ParamDelimiter + 'CODICE=' + grdVisualizzazione.medpValoreColonna(r, 'COD_SINDACATO');
  (Self.Owner as TWA123FPartecipazioniSindacati).AccediForm(55,Params);
end;

procedure TWA123FVisualizzazioneFM.grdVisualizzazioneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdVisualizzazione.medpNumColonna(AColumn);
  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdVisualizzazione.medpCompGriglia) + 1) and (grdVisualizzazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdVisualizzazione.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA123FVisualizzazioneFM.Aggiorna;
var Elenco:TStringList;
begin
  Elenco:=TStringList.Create;
  Elenco.Clear;
  with ((Self.Owner as TWA123FPartecipazioniSindacati).WR302DM as TWA123FPartecipazioniSindacatiDM).A123MW do
  begin
    selT247A.Close;
    selT247A.SetVariable('DATA',StrToDateTime(edtData.Text));
    if Trim(CmbSindacato.Text) <> '' then
      selT247A.SetVariable('FILTROSINDACATO',' AND T247.COD_SINDACATO = ''' + CmbSindacato.Text + '''')
    else
      selT247A.SetVariable('FILTROSINDACATO','');
    if Trim(CmbOrganismo.Text) <> '' then
      selT247A.SetVariable('FILTROORGANISMO',' AND T247.COD_ORGANISMO = ''' + CmbOrganismo.Text + '''')
    else
      selT247A.SetVariable('FILTROORGANISMO','');
    if edtOrdina1.Text = '1' then
      Elenco.Add(' T247.COD_ORGANISMO, ');
    if edtOrdina1.Text = '2' then
      Elenco.Add(' T247.COD_ORGANISMO, ');
    if edtOrdina1.Text = '3' then
      Elenco.Add(' T247.COD_ORGANISMO, ');
    if edtOrdina2.Text = '1' then
      Elenco.Insert(0,' T247.COD_SINDACATO, ');
    if edtOrdina2.Text = '2' then
      if edtOrdina1.Text = '1' then
        Elenco.Add(' T247.COD_SINDACATO, ')
      else
        Elenco.Insert(0,' T247.COD_SINDACATO, ');
    if edtOrdina2.Text = '3' then
      Elenco.Add(' T247.COD_SINDACATO, ');
    if edtOrdina3.Text = '1' then
      Elenco.Insert(0,' T247.DADATA, ');
    if edtOrdina3.Text = '2' then
      Elenco.Insert(1,' T247.DADATA, ');
    if edtOrdina3.Text = '3' then
      Elenco.Add(' T247.DADATA, ');
    selT247A.SetVariable('ORDINAMENTO',Elenco.Text);
    selT247A.Open;
  end;
  if grdVisualizzazione.medpDataSet <> nil then
    grdVisualizzazione.medpAggiornaCDS(True);
  //Necessario perchè altrimenti in async il refresh di grdCompetenze non viene renderizzato
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[(Self.Owner as TWA123FPartecipazioniSindacati).btnSendFile.HTMLName]));
  FreeAndNil(Elenco);
end;

end.
