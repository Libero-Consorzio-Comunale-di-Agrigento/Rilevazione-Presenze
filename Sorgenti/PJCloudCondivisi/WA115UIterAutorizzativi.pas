unit WA115UIterAutorizzativi;

interface

uses
  Data.DB,
  Oracle,
  OracleData,
  System.Actions,
  System.Classes,
  System.SysUtils,
  System.Variants,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Menus,
  Winapi.Messages,
  Winapi.Windows,
  A000UInterfaccia,
  IWBaseComponent,
  IWBaseContainerLayout,
  IWBaseControl,
  IWBaseHTML40Component,
  IWBaseHTMLComponent,
  IWBaseHTMLControl,
  IWBaseLayoutComponent,
  IWCompButton,
  IWCompEdit,
  IWCompExtCtrls,
  IWCompGrids,
  IWCompLabel,
  IWContainerLayout,
  IWControl,
  IWHTMLControls,
  IWTemplateProcessorHTML,
  IWVCLBaseControl,
  IWVCLComponent,
  WC010UMemoEditFM,
  WC015USelEditGridFM,
  WR103UGestMasterDetail,
  WR203UGestDetailFM,
  meIWButton,
  meIWEdit,
  meIWGrid,
  meIWImageFile,
  meIWLabel,
  meIWLink,
  medpIWDBGrid,
  medpIWStatusBar,
  medpIWTabControl;

type

  TAzioneBottone = procedure (Sender: TObject) of object;

  TImgRow = class
    NumRow:integer;
    NomeCampo:string;
    Sel:TOracleDataSet;
    Lbl:TmeIWLabel;
  end;

  TWA115FIterAutorizzativi = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    AziendaCorrente:String;
    _CurrImgRow: TImgRow;
    WC015: TWC015FSelEditGridFM;
    procedure imgEditTestoClick(Sender: TObject);
    procedure imgSelI094Click(Sender: TObject);
    procedure imgSelI097Click(Sender: TObject);
    function CtrlTestoWC010(const RList: TStrings): Boolean;
    procedure CreaBtnAzione(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer; Azione:TAzioneBottone);
  public
    function InizializzaAccesso:Boolean; override;
    procedure selTabellaStateChange(DataSet: TDataSet); override;
    procedure CreaBtnTesto(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
    procedure CreaBtnTabellaSelI094(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
    procedure CreaBtnTabellaSelI097(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
  end;

implementation

{$R *.dfm}

uses
  WA115UIterAutorizzativiDM,
  WA115UIterAutorizzativiBrowseFM,
  WA115UIterAutorizzativiSelI95DetailFM,
  WA115UIterAutorizzativiSelI96DetailFM;

procedure TWA115FIterAutorizzativi.IWAppFormCreate(Sender: TObject);
var
  selI095Detail:TWA115FIterAutorizzativiSelI95DetailFM;
  selI096Detail:TWA115FIterAutorizzativiSelI96DetailFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA115FIterAutorizzativiDM.Create(Self);

  AziendaCorrente:=GetParam('AZIENDA');
  if AziendaCorrente = '' then
    AziendaCorrente:=Parametri.Azienda;
  TWA115FIterAutorizzativiDM(WR302DM).InizializzaDataModulo(AziendaCorrente);

  WBrowseFM:=TWA115FIterAutorizzativiBrowseFM.Create(Self);

  selI095Detail:=TWA115FIterAutorizzativiSelI95DetailFM.Create(Self);
  AggiungiDetail(selI095Detail, False);
  selI095Detail.CaricaDettaglio((WR302DM as TWA115FIterAutorizzativiDM).A115MW.selI095,(WR302DM as TWA115FIterAutorizzativiDM).dsrI095);

  selI096Detail:=TWA115FIterAutorizzativiSelI96DetailFM.Create(Self);
  AggiungiDetail(selI096Detail, False);
  selI096Detail.CaricaDettaglio((WR302DM as TWA115FIterAutorizzativiDM).A115MW.selI096,(WR302DM as TWA115FIterAutorizzativiDM).dsrI096);

  CreaTabDefault;
end;

function TWA115FIterAutorizzativi.InizializzaAccesso:Boolean;
begin
  inherited;
  //Parametro Azienda?
end;

procedure TWA115FIterAutorizzativi.selTabellaStateChange(DataSet: TDataSet);
begin
  inherited;
  actNuovo.Enabled:=False;
  actElimina.Enabled:=False;
  actNuovo.Visible:=False;
  actCopiaSu.Visible:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

function TWA115FIterAutorizzativi.CtrlTestoWC010(const RList: TStrings): Boolean;
var
  i: integer;
begin
  Result:=True;
  for i:=RList.Count-1 downto 0 do
    if Trim(RList[i]) = '' then
      RList.Delete(i)
    else
      break;
  //Aggiorna il dataset
  _CurrImgRow.Sel.FieldByName(_CurrImgRow.NomeCampo).AsString:=RList.Text;
  //Aggiorna la grid associata al dataset
  if WBrowseFM.grdTabella.medpdataset = _CurrImgRow.Sel then
    (WBrowseFM.grdTabella.medpCompCella(_CurrImgRow.NumRow,_CurrImgRow.NomeCampo,0) as TmeIWLabel).Text:=RList.Text
  else
  begin
    for i:=0 to DetailsCount-1 do
      if (DetailFM[i] as TWR203FGestDetailFM).grdTabella.medpDataSet = _CurrImgRow.Sel then
        ((DetailFM[i] as TWR203FGestDetailFM).grdTabella.medpCompCella(_CurrImgRow.NumRow,_CurrImgRow.NomeCampo,0) as TmeIWLabel).Text:=RList.Text
  end;
end;

procedure TWA115FIterAutorizzativi.imgEditTestoClick(Sender: TObject);
var
  campoNote: TStringList;
begin
  _CurrImgRow:=((Sender as TmeIWImageFile).medpTag as TImgRow);
  campoNote:=TStringList.Create;
  campoNote.Clear;
  campoNote.Add(_CurrImgRow.Sel.FieldByName(_CurrImgRow.NomeCampo).AsString);
  TWC010FMemoEditFM.Visualizza(_CurrImgRow.Sel.FieldByName(_CurrImgRow.NomeCampo).DisplayLabel,600,350,campoNote,Self.Parent,True,CtrlTestoWC010);
  FreeAndNil(campoNote);
end;

procedure TWA115FIterAutorizzativi.imgSelI094Click(Sender: TObject);
begin
  with TWA115FIterAutorizzativiDM(WR302DM).A115MW do
  begin
    WC015:=TWC015FSelEditGridFM.Create(Self);
    WC015.InizializzaEvent:=TWA115FIterAutorizzativiBrowseFM(WBrowseFM).grdselI094preparaComponenti;
    WC015.DataSet2ComponentiEvent:=TWA115FIterAutorizzativiBrowseFM(WBrowseFM).grdselI094DataSet2Componenti;
    WC015.Componenti2DataSetEvent:=TWA115FIterAutorizzativiBrowseFM(WBrowseFM).grdselI094Componenti2DataSet;
    WC015.Visualizza('Controllo Riepiloghi',selI094);
  end;
end;

procedure TWA115FIterAutorizzativi.imgSelI097Click(Sender: TObject);
begin
  with TWA115FIterAutorizzativiDM(WR302DM).A115MW do
  begin
    WC015:=TWC015FSelEditGridFM.Create(Self);
    WC015.InizializzaEvent:=TWA115FIterAutorizzativiSelI95DetailFM(DetailFM[0]).grdselI097preparaComponenti;
    WC015.DataSet2ComponentiEvent:=TWA115FIterAutorizzativiSelI95DetailFM(DetailFM[0]).grdselI097DataSet2Componenti;
    WC015.Componenti2DataSetEvent:=TWA115FIterAutorizzativiSelI95DetailFM(DetailFM[0]).grdselI097Componenti2DataSet;
    WC015.Visualizza('Condizioni Validità',selI097);
  end;
end;

procedure TWA115FIterAutorizzativi.CreaBtnTesto(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
begin
  CreaBtnAzione(pGrid, pSel, pCampoColonna, pRow, Self.imgEditTestoClick);
end;

procedure TWA115FIterAutorizzativi.CreaBtnTabellaSelI094(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
begin
  CreaBtnAzione(pGrid, pSel, pCampoColonna, pRow, Self.imgSelI094Click);
end;

procedure TWA115FIterAutorizzativi.CreaBtnTabellaSelI097(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
begin
  CreaBtnAzione(pGrid, pSel, pCampoColonna, pRow, Self.imgSelI097Click);
end;

procedure TWA115FIterAutorizzativi.CreaBtnAzione(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer; Azione:TAzioneBottone);
var
  img:TmeIWImageFile;
begin
  if pGrid.medpCompCella(pRow,pGrid.medpIndexColonna(pCampoColonna),1) <> nil then
  begin
    img:=TmeIWImageFile(pGrid.medpCompCella(pRow,pGrid.medpIndexColonna(pCampoColonna),1));
    img.OnClick:=Azione;
    img.medpTag:=TImgRow.Create;
    (img.medpTag as TImgRow).NumRow:=pRow;
    (img.medpTag as TImgRow).NomeCampo:=pCampoColonna;
    (img.medpTag as TImgRow).Sel:=pSel;
    (img.medpTag as TImgRow).Lbl:=(pGrid.medpCompCella(pRow,pGrid.medpIndexColonna(pCampoColonna),0) as TmeIWLabel);
  end;
end;

end.
