unit WA197ULayoutSchedaAnagrDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, meIWGrid, medpIWTabControl,
  WA197ULayoutSchedaAnagrDM, medpIWDBGrid, Data.DB, IWCompEdit,
  medpIWMultiColumnComboBox, IWCompLabel, meIWLabel, C190FunzioniGeneraliWeb,
  IWCompButton, meIWButton,WA197UPreviewFM;

type
  TPagina = record
    Caption    : String;
    Region : TIWRegion;
    GridCampi: TmedpIWDBGrid;
  end;

  TWA197FLayoutSchedaAnagrDettFM = class(TWR205FDettTabellaFM)
    grdTabDetail: TmedpIWTabControl;
    TemplatePagina: TIWTemplateProcessorHTML;
    lblNomeLayout: TmeIWLabel;
    lblStatoPagina: TmeIWLabel;
    btnPaginaModificabile: TmeIWButton;
    btnPaginaNascosta: TmeIWButton;
    btnPaginaSolaLettura: TmeIWButton;
    btnPreview: TmeIWButton;
    cmbNomeLayout: TMedpIWMultiColumnComboBox;
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure btnPaginaModificabileClick(Sender: TObject);
    procedure btnPaginaSolaLetturaClick(Sender: TObject);
    procedure btnPaginaNascostaClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure TemplatePaginaBeforeProcess(var VTemplate: TStream);
  private
    Pagine: Array of TPagina;
    procedure CreaPagine;
    procedure CaricaGridCampi;
    procedure ComponentiGridCampi;
    procedure grdCampiDataSet2Componenti(Row: Integer);
    procedure AbilitaPulsantiPagina;
  public
    procedure Dataset2Componenti; override;
    procedure Componenti2Dataset; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
    function VerificaGrdPending: Boolean;
  end;

implementation

{$R *.dfm}

procedure TWA197FLayoutSchedaAnagrDettFM.CreaPagine;
var i : Integer;
    Pagina:TPagina;
    Reg: TIWRegion;
    MedpGrid: TmedpIWDBGrid;
begin
  //pagine fisse
  //distruggo pagine già create
  btnPreview.Parent:=Self;
  for Pagina in Pagine do
  begin
    grdTabDetail.EliminaTab(Pagina.Region);
    Reg:=Pagina.Region;
    FreeAndNil(Reg);
  end;

  SetLength(Pagine,0);
  i:=0;

  with TWA197FLayoutSchedaAnagrDM(WR302DM).selT033_Pagine do
  begin
    Open;
    while not Eof do
    begin
      SetLength(Pagine,i+1);
      Pagine[i].Caption:=FieldByName('NomePagina').AsString;
      Pagine[i].Region:=TIWRegion.Create(Self);
      Pagine[i].Region.Name:='WA197Pagina' + IntToStr(i+1) + 'RG';
      Pagine[i].Region.Parent:=IWFrameRegion;
      Pagine[i].Region.LayoutMgr:=TemplatePagina;
      MedpGrid:=TmedpIWDBGrid.Create(Self);
      MedpGrid.Parent:=Pagine[i].Region;
      MedpGrid.name:='grdCampi' + i.ToString;
      MedpGrid.Summary:='campi pagina ' + Pagine[i].Caption;
      MedpGrid.OnDataSet2Componenti:=grdCampiDataSet2Componenti;
      MedpGrid.OnmedpStatoChange:=AbilitaPulsantiPagina;
      Pagine[i].GridCampi:=MedpGrid;

      grdTabDetail.AggiungiTab(Pagine[i].Caption,Pagine[i].Region);
      inc(i);
      Next;
    end;
    Close;
  end;

  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=Pagine[0].Region;
  btnPreview.Parent:=Pagine[0].Region
end;

procedure TWA197FLayoutSchedaAnagrDettFM.AbilitaPulsantiPagina;
begin
  btnPreview.Enabled:=(Pagine[grdTabDetail.TabIndex].GridCampi.medpStato = msBrowse);
  if (WR302DM.SelTabella.State in [dsEdit,dsInsert]) and
      (Pagine[grdTabDetail.TabIndex].GridCampi.medpStato = msBrowse) then
  begin
    btnPaginaModificabile.Enabled:=True;
    btnPaginaSolaLettura.Enabled:=True;
    btnPaginaNascosta.Enabled:=True;
  end
  else
  begin
    btnPaginaModificabile.Enabled:=False;
    btnPaginaSolaLettura.Enabled:=False;
    btnPaginaNascosta.Enabled:=False;
  end;
end;

procedure TWA197FLayoutSchedaAnagrDettFM.btnPaginaModificabileClick(
  Sender: TObject);
begin
  inherited;
  (WR302DM as TWA197FLayoutSchedaAnagrDM).ImpostaAccessoPagina(Pagine[grdTabDetail.TabIndex].Caption,'S');
  Pagine[grdTabDetail.TabIndex].GridCampi.medpAggiornaCDS(True);
end;

procedure TWA197FLayoutSchedaAnagrDettFM.btnPaginaNascostaClick(
  Sender: TObject);
begin
  inherited;
  (WR302DM as TWA197FLayoutSchedaAnagrDM).ImpostaAccessoPagina(Pagine[grdTabDetail.TabIndex].Caption,'N');
  Pagine[grdTabDetail.TabIndex].GridCampi.medpAggiornaCDS(True);
end;

procedure TWA197FLayoutSchedaAnagrDettFM.btnPaginaSolaLetturaClick(
  Sender: TObject);
begin
  inherited;
  (WR302DM as TWA197FLayoutSchedaAnagrDM).ImpostaAccessoPagina(Pagine[grdTabDetail.TabIndex].Caption,'R');
  Pagine[grdTabDetail.TabIndex].GridCampi.medpAggiornaCDS(True);
end;

procedure TWA197FLayoutSchedaAnagrDettFM.btnPreviewClick(Sender: TObject);
var
  WA197FPreviewFM: TWA197FPreviewFM;
begin
  WA197FPreviewFM:=TWA197FPreviewFM.Create(Self.Parent);
  WA197FPreviewFM.Visualizza(Pagine[grdTabDetail.TabIndex].Caption);
end;

procedure TWA197FLayoutSchedaAnagrDettFM.AbilitaComponenti;
begin
  inherited;
  btnPreview.Enabled:=True;
  CaricaGridCampi;
  if WR302DM.selTabella.State in [dsInsert,dsEdit] then
    ComponentiGridCampi;

  AbilitaPulsantiPagina;
end;

procedure TWA197FLayoutSchedaAnagrDettFM.CaricaGridCampi;
var
  Pagina:TPagina;
begin
  for Pagina in Pagine do
  begin
    with TWA197FLayoutSchedaAnagrDM(WR302DM) do
    begin
      pagina.GridCampi.medpAttivaGrid(dicDatasetPagina.Items[Pagina.Caption],
                                      selTabella.State in [dsInsert,dsEdit],
                                      false,
                                      false);
    end;
  end;
end;

procedure TWA197FLayoutSchedaAnagrDettFM.ComponentiGridCampi;
var
  Pagina:TPagina;
begin
  for Pagina in Pagine do
  begin
    with TWA197FLayoutSchedaAnagrDM(WR302DM) do
    begin
      //NON Si aggiunge +1 perchè richiamato quando già la grid ha colonna con i bottoni di editing
      pagina.GridCampi.medpPreparaComponenteGenerico('WR102',pagina.GridCampi.medpIndexColonna('CAPTION'),0,DBG_EDT,'','','','','S');
      pagina.GridCampi.medpPreparaComponenteGenerico('WR102',pagina.GridCampi.medpIndexColonna('TOP'),0,DBG_EDT,'','','','','D');
      pagina.GridCampi.medpPreparaComponenteGenerico('WR102',pagina.GridCampi.medpIndexColonna('LFT'),0,DBG_EDT,'','','','','D');
      pagina.GridCampi.medpPreparaComponenteGenerico('WR102',pagina.GridCampi.medpIndexColonna('ACCESSO'),0,DBG_MECMB,'1','1','','','S');
      pagina.GridCampi.medpPreparaComponenteGenerico('WR102',pagina.GridCampi.medpIndexColonna('NOMEPAGINA'),0,DBG_MECMB,'20','1','','','S');
    end;
  end;
end;

procedure TWA197FLayoutSchedaAnagrDettFM.grdCampiDataSet2Componenti(Row: Integer);
var
  grd: TmedpIWDBGrid;
  cmb: TMedpIWMultiColumnComboBox;
  Pagina: TPagina;
begin
  inherited;
  //Filtro su combo
  grd:=Pagine[grdTabDetail.TabIndex].GridCampi;
  //Accesso
  cmb:=(grd.medpCompCella(Row,grd.medpIndexColonna('ACCESSO'),0) as TMedpIWMultiColumnComboBox );
  cmb.CustomElement:=False;
  cmb.Items.Clear;
  cmb.PopupHeight:=10;
  cmb.PopUpWidth:=5;
  cmb.addRow('S');
  cmb.addRow('N');
  cmb.addRow('R');
  cmb.Text:=grd.medpValoreColonna(Row,'ACCESSO');

  //Nome pagina
  cmb:=(grd.medpCompCella(Row,grd.medpIndexColonna('NOMEPAGINA'),0) as TMedpIWMultiColumnComboBox );
  cmb.CustomElement:=True;
  cmb.Items.Clear;
  cmb.PopupHeight:=10;
  cmb.PopUpWidth:=20;
  for Pagina in Pagine do
  begin
    cmb.addRow(Pagina.caption);
  end;
  cmb.Text:=grd.medpValoreColonna(Row,'NOMEPAGINA');
end;

procedure TWA197FLayoutSchedaAnagrDettFM.grdTabDetailTabControlChange(
  Sender: TObject);
begin
  inherited;
  AbilitaPulsantiPagina;
  btnPreview.Parent:=Pagine[grdTabDetail.TabIndex].Region;
end;

procedure TWA197FLayoutSchedaAnagrDettFM.TemplatePaginaBeforeProcess(
  var VTemplate: TStream);
var
  strListTemp: TStringList;
begin
  inherited;
  strListTemp:=TStringList.Create();
  strListTemp.LoadFromStream(VTemplate);
  //MANIPOLAZIONE TEMPLATE
  strListTemp.Text:=StringReplace(strListTemp.Text, '{%grdDinamica%}', '{%grdCampi' + grdTabDetail.Tabindex.ToString + '%}', [rfReplaceAll]);

  //SALVATAGGIO SU STREAM VTemplate
  FreeAndNil(VTemplate);//.Free;
  VTemplate:=TStringStream.Create;
  strListTemp.SaveToStream(VTemplate);
  FreeAndNil(strListTemp);
  TStringStream(VTemplate).Seek(0, soFromBeginning);
end;

procedure TWA197FLayoutSchedaAnagrDettFM.Dataset2Componenti;
begin
  CmbNomeLayout.Text:=WR302DM.selTabella.FieldByName('NOME').AsString;
  CreaPagine;
  CaricaGridCampi;
end;

procedure TWA197FLayoutSchedaAnagrDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA197FLayoutSchedaAnagrDM) do
  begin
    cmbNomeLayout.Items.Clear;
    //chiudo e riapro per aggiornare
    selLayout.Close;
    selLayout.Open;
    while not selLayout.Eof do
    begin
      cmbNomeLayout.AddRow(selLayout.FieldByName('NOME').AsString);
      selLayout.Next;
    end;
  end;
end;

procedure TWA197FLayoutSchedaAnagrDettFM.Componenti2Dataset;
begin
  inherited;
  WR302DM.selTabella.FieldByName('NOME').AsString:=CmbNomeLayout.Text;
end;

function TWA197FLayoutSchedaAnagrDettFM.VerificaGrdPending : Boolean;
var Pagina : TPagina;
begin
  Result:=False;

  for Pagina in Pagine do
  begin
    if Pagina.GridCampi.medpStato <> msBrowse then
      Result:=True;
  end;
end;

end.
