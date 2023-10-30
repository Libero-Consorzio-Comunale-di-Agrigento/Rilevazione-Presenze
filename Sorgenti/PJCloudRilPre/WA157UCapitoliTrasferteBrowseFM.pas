unit WA157UCapitoliTrasferteBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, StrUtils, C190FunzioniGeneraliWeb, meIWComboBox,
  C180FunzioniGenerali, medpIWMultiColumnComboBox, meIWEdit, meIWImageFile,
  DB, WA157UCapitoliTrasferte, Math;

type
  TWA157FCapitoliTrasferteBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
    procedure createImgSelAnagrafe(DBG_ROWID: string);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
  public
    { Public declarations }
  end;

implementation

uses
  WA157UCapitoliTrasferteDM, WR100UBase;

{$R *.dfm}

procedure TWA157FCapitoliTrasferteBrowseFM.imgSelAnagrafeClick(Sender:TObject);
begin
  with TWA157FCapitoliTrasferte(Self.Owner).grdC700 do
  begin
    WC700FM.ResultEvent:=resultSelAnagrafe;
    actSelezioneAnagraficheExecute(nil);
  end;
end;

procedure TWA157FCapitoliTrasferteBrowseFM.resultSelAnagrafe(Sender:TObject; Result:Boolean);

  function TrasformaV430(X:String):String;
  var
    Apice:Boolean;
    i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= X.Length do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=EliminaRitornoACapo(X.Trim);
  end;

var
  S:string;
begin
  if result then
  begin
    S:=(Self.Owner as TWR100FBase).grdC700.WC700FM.SQLCreato.Text.Trim;
    if Pos('ORDER BY',S.ToUpper) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',S.ToUpper) - 1);
    (grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo - 1,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),0) as TmeIWEdit).Text:=TrasformaV430(S);
  end;
end;

procedure TWA157FCapitoliTrasferteBrowseFM.createImgSelAnagrafe(DBG_ROWID: string);
var
  r:Integer;
  img:TmeIWImageFile;
begin
  for r:=ifthen(grdTabella.medpDataSet.state in [dsInsert],0,1) to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),1) <> nil then
    begin
      img:=(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),1) as TmeIWImageFile);
      img.OnClick:=imgSelAnagrafeClick;
    end;
end;

procedure TWA157FCapitoliTrasferteBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  c:integer;
begin
  inherited;
  //Gestione VisualizzazioneC700
  createImgSelAnagrafe(Row.ToString);
  //Gesione multi-column
  (WR302DM as TWA157FCapitoliTrasferteDM).A157MW.selM011.Open;
  c:=grdTabella.medpIndexColonna('TIPO_MISSIONE');
  C190CaricaMepdMulticolumnComboBox((grdTabella.medpCompCella(Row,c,0) as TMedpIWMultiColumnComboBox),
                                    (WR302DM as TWA157FCapitoliTrasferteDM).A157MW.selM011);
  (grdTabella.medpCompCella(Row,c,0) as TMedpIWMultiColumnComboBox).Text:=grdTabella.medpValoreColonna(Row,'TIPO_MISSIONE');
end;

procedure TWA157FCapitoliTrasferteBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FILTRO_ANAGRAFE'),1,DBG_IMG,'','SELANAGRAFE','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO_MISSIONE'),0,DBG_MECMB,'10','2','null','','S');
end;

end.
