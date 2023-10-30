unit WA038UVociVariabili;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA038UVociVariabiliDM, medpIWTabControl, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion,
  IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, IWCompCheckbox, meIWCheckBox,
  IWCompListbox, meIWComboBox, meIWRadioGroup, IWAdvCheckGroup, IWApplication,
  meTIWAdvCheckGroup,A000UCostanti,A000UInterfaccia,C180FunzioniGenerali,
  IWDBGrids, medpIWDBGrid, IWAdvRadioGroup, meTIWAdvRadioGroup,
  IWCompJQueryWidget, Menus,Db;

type
  TWA038FVociVariabili = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA038FiltroRG: TmeIWRegion;
    WA038VociRG: TmeIWRegion;
    TemplateFiltroRG: TIWTemplateProcessorHTML;
    TemplateVociRG: TIWTemplateProcessorHTML;
    chkTuttiDipendenti: TmeIWCheckBox;
    edtDalMese: TmeIWEdit;
    lblDalMese: TmeIWLabel;
    lblAlMese: TmeIWLabel;
    edtAlMese: TmeIWEdit;
    chkMeseCassa: TmeIWCheckBox;
    cmbMeseCassa: TmeIWComboBox;
    chkUMNumero: TmeIWCheckBox;
    chkUMOre: TmeIWCheckBox;
    chkUMValuta: TmeIWCheckBox;
    lblTipoVoci: TmeIWLabel;
    lblVociPaghe: TmeIWLabel;
    chkVoci: TmeIWCheckBox;
    lblCodiciInterni: TmeIWLabel;
    chkCodici: TmeIWCheckBox;
    cgpCodiciInterni: TmeTIWAdvCheckGroup;
    grdVociScaricate: TmedpIWDBGrid;
    rgpTipoElenco: TmeTIWAdvRadioGroup;
    cgpVociPaghe: TmeTIWAdvCheckGroup;
    pmnAzioni: TPopupMenu;
    SelezionaTutto1: TMenuItem;
    DeselezionaTutto1: TMenuItem;
    pmnGrid: TPopupMenu;
    actScaricaInExcel: TMenuItem;
    actScaricaInCSV: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure grdVociScaricateRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure cgpCodiciInterniAsyncItemClick(Sender: TObject;
      EventParams: TStringList; Index: Integer);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure cgpVociPagheAsyncItemClick(Sender: TObject; EventParams: TStringList;
      Index: Integer);
    procedure SelezionaTutto1Click(Sender: TObject);
    procedure DeselezionaTutto1Click(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    procedure chkTuttiDipendentiAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure edtAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbMeseCassaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure chkAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure rgpTipoElencoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure actScaricaInCSVClick(Sender: TObject);
  private
    selT195Modificata: Boolean;
    procedure ImpostaQuery(OpenSelT195: Boolean);
    procedure ImpostaFiltro;
    procedure ImpostaContatore;
    procedure SelezionaCheckGroup(CheckGroup:TmeTIWAdvCheckGroup; Val: Boolean);
  public
    WA038FVociVariabiliDM: TWA038FVociVariabiliDM;
    LstCodiciInterniSelezionati,
    LstVociPagheSelezionate: TStringList;
    function InizializzaAccesso: Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure AbilitaToolbarWC700(Abil: Boolean);
  end;

implementation

{$R *.dfm}

procedure TWA038FVociVariabili.IWAppFormCreate(Sender: TObject);
begin
  WA038FVociVariabiliDM:=TWA038FVociVariabiliDM.Create(Self);

  grdTabDetail.AggiungiTab('Filtro',WA038FiltroRG);
  grdTabDetail.AggiungiTab('Voci Scaricate',WA038VociRG);

  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA038FiltroRG;

  inherited;
  AttivaGestioneC700;
//  grdVociScaricate.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
  grdVociScaricate.medpRighePagina:=20;
  LstCodiciInterniSelezionati:=TStringList.Create;
  LstVociPagheSelezionate:=TStringList.Create;;
end;

procedure TWA038FVociVariabili.AbilitaToolbarWC700(Abil: Boolean);
begin
  grdC700.AbilitaToolbar(Abil);
end;

procedure TWA038FVociVariabili.actScaricaInCSVClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdVociScaricate.ToCsv
  else
    InviaFile('Estrazione.xls',csvDownload);
end;

procedure TWA038FVociVariabili.actScaricaInExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdVociScaricate.ToXlsx
  else
    InviaFile('Estrazione.xlsx',streamDownload);
end;

procedure TWA038FVociVariabili.cgpCodiciInterniAsyncItemClick(Sender: TObject;
  EventParams: TStringList; Index: Integer);
var
  idx: Integer;
  Codice: String;
begin
  Codice:=Trim(Copy(cgpCodiciInterni.Items[Index],1,4));
  if cgpCodiciInterni.IsChecked[Index] then
    //aggiungo a lista codici selezionati
    LstCodiciInterniSelezionati.add(Codice)
  else
  begin
    //rimuovo da a lista codici selezionati se presente
    idx:= LstCodiciInterniSelezionati.IndexOf(Codice);
    if idx>=0 then
      LstCodiciInterniSelezionati.Delete(idx);
  end;

  if chkCodici.Checked then
    ImpostaFiltro;
end;

procedure TWA038FVociVariabili.cgpVociPagheAsyncItemClick(Sender: TObject;
  EventParams: TStringList; Index: Integer);
var
  idx: Integer;
begin
  if cgpVociPaghe.IsChecked[Index] then
    //aggiungo a lista codici selezionati
    LstVociPagheSelezionate.add(cgpVociPaghe.Items[Index])
  else
  begin
    //rimuovo da a lista codici selezionati se presente
    idx:= LstVociPagheSelezionate.IndexOf(cgpVociPaghe.Items[Index]);
    if idx>=0 then
      LstVociPagheSelezionate.Delete(idx);
  end;

  if chkVoci.Checked then
    ImpostaFiltro;
end;

procedure TWA038FVociVariabili.chkTuttiDipendentiAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  ImpostaQuery(False);
end;

procedure TWA038FVociVariabili.chkAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  ImpostaFiltro;
end;

procedure TWA038FVociVariabili.cmbMeseCassaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  ImpostaFiltro;
end;

procedure TWA038FVociVariabili.SelezionaCheckGroup(CheckGroup:TmeTIWAdvCheckGroup; Val: Boolean);
var i : Integer;
begin
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=Val;
  CheckGroup.AsyncUpdate;
end;

procedure TWA038FVociVariabili.DeselezionaTutto1Click(Sender: TObject);
begin
  inherited;
  SelezionaCheckGroup((pmnAzioni.PopupComponent as TmeTIWAdvCheckGroup),False);
end;

procedure TWA038FVociVariabili.edtAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  ImpostaQuery(False);
end;

procedure TWA038FVociVariabili.SelezionaTutto1Click(Sender: TObject);
begin
  inherited;
  SelezionaCheckGroup((pmnAzioni.PopupComponent as TmeTIWAdvCheckGroup),True);
end;

procedure TWA038FVociVariabili.grdTabDetailTabControlChange(Sender: TObject);
begin
  inherited;
  if grdTabDetail.ActiveTab = WA038VociRG then
  begin
    if (selT195Modificata) or (WA038FVociVariabiliDM.A038FVociVariabiliMW.selT195.State = dsInactive) then
      ImpostaQuery(True);

    grdVociScaricate.medpAttivaGrid(WA038FVociVariabiliDM.A038FVociVariabiliMW.selT195,not WA038FVociVariabiliDM.A038FVociVariabiliMW.selT195.ReadOnly,False);
  end;
  if (Sender <> nil) then//se arrivo da cambio progressivo non eseguo di nuovo perchè già fatto in ImpostaQuery
    ImpostaContatore;
end;

procedure TWA038FVociVariabili.grdVociScaricateRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  inherited;
  if not grdVociScaricate.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    Exit;

  NumColonna:=grdVociScaricate.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdVociScaricate.medpCompGriglia) + 1) and (grdVociScaricate.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdVociScaricate.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA038FVociVariabili.ImpostaContatore;
begin

  if (grdTabDetail.ActiveTab = WA038VociRG) or (selT195Modificata) then
  begin
    grdTabDetail.Tabs[WA038VociRG].Link.RawText:=False;
    grdTabDetail.Tabs[WA038VociRG].Link.Caption:='Voci Scaricate'
  end
  else
  begin
    with WA038FVociVariabiliDM.A038FVociVariabiliMW.selT195 do
    begin
      if Active then
      begin
        RecordCount;
        grdTabDetail.Tabs[WA038VociRG].Link.RawText:=True;
        grdTabDetail.Tabs[WA038VociRG].Caption:=Format('Voci Scaricate <span class="contatore_apice">%d</span>',[RecordCount]);
      end;
    end;
  end;
end;

procedure TWA038FVociVariabili.ImpostaFiltro;
begin
  with WA038FVociVariabiliDM.A038FVociVariabiliMW.selT195 do
  begin
    Filtered:=False;
    Filtered:=chkVoci.Checked or chkCodici.Checked or chkMeseCassa.Checked or (not chkUMNumero.Checked) or (not chkUMOre.Checked) or (not chkUMValuta.Checked);
    if Active then
      First;
    ImpostaContatore;
  end;
end;

procedure TWA038FVociVariabili.ImpostaQuery(OpenSelT195: Boolean);
var
  Data1,Data2: TDateTime;
begin
  if not tryStrToDate('01/' +edtDalMese.Text,Data1) then
    Data1:=DATE_NULL;

  if not tryStrToDate('01/' +edtAlMese.Text,Data2) then
    Data2:=DATE_NULL;
  Data2:=R180FineMese(Data2);

  WA038FVociVariabiliDM.SettaQuery(Data1,Data2,chkTuttiDipendenti.Checked,SolaLettura,rgpTipoElenco.ItemIndex,grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,OpenSelT195);
  selT195Modificata:=not OpenSelT195;
  ImpostaContatore;
end;

function TWA038FVociVariabili.InizializzaAccesso: Boolean;
var
  i: Integer;
  Data: TDateTime;
begin
  with WA038FVociVariabiliDM.A038FVociVariabiliMW.VociPaghe do
  begin
    Open;
    while not Eof do
    begin
      cgpVociPaghe.Items.Add(FieldByName('VocePaghe').AsString);
      Next;
    end;
    Close;
  end;

  for i:=1 to High(VettConst) do
    cgpCodiciInterni.Items.Add(Format('%-4s %s',[VettConst[i].CodInt,VettConst[i].Descrizione]));

  with WA038FVociVariabiliDM.A038FVociVariabiliMW.selT195Cassa do
  begin
    Open;
    while not Eof do
    begin
      cmbMeseCassa.Items.Add(FieldByName('Data_Cassa').AsString);
      Next;
    end;
    Close;
  end;

  if cmbMeseCassa.Items.Count > 0 then
    cmbMeseCassa.ItemIndex:=0;

  if Parametri.DataLavoro <> 0 then
    Data:=Parametri.DataLavoro
  else
    Data:=Date;

  edtDalMese.Text:=FormatDateTime('mm/yyyy',R180InizioMese(Data));
  edtAlMese.Text:=FormatDateTime('mm/yyyy',R180FineMese(Data));

  selT195Modificata:=False;
  Result:=True;
end;

procedure TWA038FVociVariabili.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(LstCodiciInterniSelezionati);
  FreeAndNil(LstVociPagheSelezionate);
end;

procedure TWA038FVociVariabili.rgpTipoElencoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  ImpostaQuery(False);
end;

procedure TWA038FVociVariabili.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  if not chkTuttiDipendenti.Checked then
    ImpostaQuery(False);
  grdTabDetailTabControlChange(nil);
end;

end.
