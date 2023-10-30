unit WA204UModelliCertificazione;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, Oracle, System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  WC010UMemoEditFM, meIWImageFile,OracleData, medpIWDBGrid;

type
  TImgRow = class
    NumRow:integer;
    NomeCampo:string;
    Sel:TOracleDataSet;
    Lbl:TmeIWLabel;
  end;

  TWA204FModelliCertificazione = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    _CurrImgRow: TImgRow;
    function CtrlTestoWC010(const RList: TStrings): Boolean;
    procedure AggiornaDati;
  public
    { Public declarations }
    procedure AttivaGestioneC700L;
    procedure imgEditTestoClick(Sender: TObject);
    procedure CreaBtnTesto(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
  end;

implementation

{$R *.dfm}

uses
  WR203UGestDetailFM, WA204UModelliCertificazioneDM, WA204UModelliCertificazioneBrowseFM, WA204UCategorieCertificazioneDettFM, WA204UDatiCertificazioneDettFM;

procedure TWA204FModelliCertificazione.IWAppFormCreate(Sender: TObject);
var
  DetailCategorie: TWA204FCategorieCertificazioneDettFM;
  DetailDati: TWA204FDatiCertificazioneDettFM;
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA204FModelliCertificazioneDM.Create(Self);
  WBrowseFM:=TWA204FModelliCertificazioneBrowseFM.Create(Self);

  DetailCategorie:=TWA204FCategorieCertificazioneDettFM.Create(Self);
  AggiungiDetail(DetailCategorie,False);
  DetailCategorie.CaricaDettaglio(TWA204FModelliCertificazioneDM(WR302DM).selSG236, TWA204FModelliCertificazioneDM(WR302DM).dsrSG236);

  DetailDati:=TWA204FDatiCertificazioneDettFM.Create(Self);
  AggiungiDetail(DetailDati,False);
  DetailDati.CaricaDettaglio(TWA204FModelliCertificazioneDM(WR302DM).selSG237, TWA204FModelliCertificazioneDM(WR302DM).dsrSG237);

  DetailDati.AggiornaDettaglio;

  CreaTabDefault;

  TWA204FModelliCertificazioneDM(WR302DM).NotificaAfterScroll:=AggiornaDati;
end;


procedure TWA204FModelliCertificazione.AggiornaDati;
begin
  (DetailFM[1] as TWR203FGestDetailFM).AggiornaDettaglio;
end;

procedure TWA204FModelliCertificazione.AttivaGestioneC700L;
begin
  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;
end;

procedure TWA204FModelliCertificazione.imgEditTestoClick(Sender: TObject);
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

function TWA204FModelliCertificazione.CtrlTestoWC010(const RList: TStrings): Boolean;
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
  if WBrowseFM.grdTabella.medpdataset=_CurrImgRow.Sel then
    (WBrowseFM.grdTabella.medpCompCella(_CurrImgRow.NumRow,_CurrImgRow.NomeCampo,0) as TmeIWLabel).Text:=RList.Text
  else
  begin
    for i:=0 to DetailsCount-1 do
      if (DetailFM[i] as TWR203FGestDetailFM).grdTabella.medpDataSet=_CurrImgRow.Sel then
        ((DetailFM[i] as TWR203FGestDetailFM).grdTabella.medpCompCella(_CurrImgRow.NumRow,_CurrImgRow.NomeCampo,0) as TmeIWLabel).Text:=RList.Text
  end;
end;

procedure TWA204FModelliCertificazione.CreaBtnTesto(pGrid: TmedpIWDBGrid; pSel: TOracleDataSet; pCampoColonna: string; pRow: integer);
var
  img:TmeIWImageFile;
begin
  if pGrid.medpCompCella(pRow,pGrid.medpIndexColonna(pCampoColonna),1) <> nil then
  begin
    img:=TmeIWImageFile(pGrid.medpCompCella(pRow,pGrid.medpIndexColonna(pCampoColonna),1));
    img.OnClick:=imgEditTestoClick;
    img.medpTag:=TImgRow.Create;
    (img.medpTag as TImgRow).NumRow:=pRow;
    (img.medpTag as TImgRow).NomeCampo:=pCampoColonna;
    (img.medpTag as TImgRow).Sel:=pSel;
    (img.medpTag as TImgRow).Lbl:=(pGrid.medpCompCella(pRow,pGrid.medpIndexColonna(pCampoColonna),0) as TmeIWLabel);
  end;
end;

end.
