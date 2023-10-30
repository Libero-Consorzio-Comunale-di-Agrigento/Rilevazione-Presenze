unit WS130UOrdiniProfessionaliBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWImageFile, meIWLabel, WC013UCheckListFM,
  A000UCostanti, A000USessione, A000UInterfaccia, C190FunzioniGeneraliWeb;

type
  TImgRow = class
    NumRow:integer;
  end;

  TWS130FOrdiniProfessionaliBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
    RowEdit: Integer;
    WC013: TWC013FCheckListFM;
    procedure imgQualificheCollegateClick(Sender: TObject);
    procedure CaricaQualificheChkLst;
    procedure ResultQualifiche(Sender:TObject;Result:Boolean);
  public
    { Public declarations }
  end;

const
  LUNGHEZZA = 10;

implementation

uses WS130UOrdiniProfessionaliDM;

{$R *.dfm}

procedure TWS130FOrdiniProfessionaliBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102','QUALIFICHE_COLLEGATE',0,DBG_LBL,'50','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102','QUALIFICHE_COLLEGATE',1,DBG_IMG,'','PUNTINI','','','');
end;

procedure TWS130FOrdiniProfessionaliBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var img:TmeIWImageFile;
begin
  inherited;
  //Campo Qualifiche_Collegate
  if grdTabella.medpDataSet.FieldByName('QUALIFICHE_COLLEGATE').Visible then
    if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('QUALIFICHE_COLLEGATE'),1) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('QUALIFICHE_COLLEGATE'),1));
      img.OnClick:=imgQualificheCollegateClick;
      img.medpTag:=TImgRow.Create;
      (img.medpTag as TImgRow).NumRow:=Row;
    end;
end;

procedure TWS130FOrdiniProfessionaliBrowseFM.imgQualificheCollegateClick(Sender: TObject);
var campoNote: TStringList;
begin
  RowEdit:=grdTabella.medpRigaDiCompGriglia(TmeIWImageFile(Sender).FriendlyName);
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  CaricaQualificheChkLst;
  C190PutCheckList(WR302DM.selTabella.FieldByName('QUALIFICHE_COLLEGATE').AsString,LUNGHEZZA,WC013.ckList);
  WC013.ResultEvent:=ResultQualifiche;
  //WC013.Visualizza(0,0,'Filtro su Parametro Aziendale "'+A000DescDatiEnte('C36_ORDPROFSAN_CODICE')+'"');
  WC013.Visualizza(0,0,'Scelta valori di '+Parametri.CampiRiferimento.C36_OrdProfSanCodice);
end;

procedure TWS130FOrdiniProfessionaliBrowseFM.CaricaQualificheChkLst;
begin
  try
    (WR302DM as TWS130FOrdiniProfessionaliDM).S130MW.selC36OrdiniProfessionali.First;
    while not (WR302DM as TWS130FOrdiniProfessionaliDM).S130MW.selC36OrdiniProfessionali.Eof do
    begin
      WC013.ckList.Items.Add(Format('%-10s',[(WR302DM as TWS130FOrdiniProfessionaliDM).S130MW.selC36OrdiniProfessionali.FieldByName('CODICE').AsString]) + ' - ' +
                             Format('%-100s',[(WR302DM as TWS130FOrdiniProfessionaliDM).S130MW.selC36OrdiniProfessionali.FieldByName('DESCRIZIONE').AsString]));
      (WR302DM as TWS130FOrdiniProfessionaliDM).S130MW.selC36OrdiniProfessionali.Next;
    end;
  finally
  end;
end;

procedure TWS130FOrdiniProfessionaliBrowseFM.ResultQualifiche(Sender:TObject;Result:Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName('QUALIFICHE_COLLEGATE').AsString:=C190GetCheckList(LUNGHEZZA,WC013.ckList);
    (grdTabella.medpCompCella(RowEdit,'QUALIFICHE_COLLEGATE',0) as TmeIWLabel).Text:=C190GetCheckList(LUNGHEZZA,WC013.ckList);
  end;
end;

end.
