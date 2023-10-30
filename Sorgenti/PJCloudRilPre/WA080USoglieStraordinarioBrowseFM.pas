unit WA080USoglieStraordinarioBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OracleData, Db,DBClient,
  meIWImageFile,Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout,IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids,IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  meIWEdit,meIWLabel,IWHTMLContainer, IWHTML40Container, IWRegion,Math,WC700USelezioneAnagrafeFM,IWApplication,
  C180FunzioniGenerali,C190FunzioniGeneraliWeb,WA080USoglieStraordinario,WA080UTipologieCartellini,
  WC013UCheckListFM,WA080USoglieStraordinarioDM,WR100UBase, Vcl.Menus;

type
  TWA080FSoglieStraordinarioBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    WC013:TWC013FCheckListFM;
    ListaGgLav,ListaGgNoLav:TStringList;
    procedure caricaListaGgLav;
    procedure caricaListaGgNoLav;
    procedure SettaCausali(S:String);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure imgGgLavClick(Sender: TObject);
    procedure imgGgNoLavClick(Sender: TObject);
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure createImgSelAnagrafe(DBG_ROWID: String);
    procedure createGgLavImgWC013(DBG_ROWID:String);
    procedure createGgNoLavImgWC013(DBG_ROWID:String);
    procedure cklistGgLavResult(Sender: TObject; Result:Boolean);
    procedure cklistGgNoLavResult(Sender: TObject; Result:Boolean);
  public
    procedure PutTipoCartellino(Valore:String);
  end;

implementation

{$R *.dfm}

procedure TWA080FSoglieStraordinarioBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPOCARTELLINO'),0,DBG_LBL,'10','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DECORRENZA'),0,DBG_LBL,'10','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('SELEZIONE_ANAGRAFE'),1,DBG_IMG,'','SELANAGRAFE','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALI_GGLAV'),1,DBG_IMG,'','PUNTINI','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CAUSALI_GGNONLAV'),1,DBG_IMG,'','PUNTINI','','','');
  ListaGgLav:=TStringList.Create;
  ListaGgNoLav:=TStringList.Create;
  grdTabella.medpCaricaCDS;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.PutTipoCartellino(Valore: String);
begin
   TWA080FSoglieStraordinarioDM(WR302DM).PutTipoCartellino(Valore);
   grdTabella.medpCaricaCDS;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.caricaListaGgNoLav;
begin
 with TWA080FSoglieStraordinarioDM(WR302DM) do
  begin
    ListaGgNoLav.Clear;
    selT275.First;
    while not selT275.Eof do
    begin
      ListaGgNoLav.Add(selT275.FieldByName('CODICE').AsString+'     '+selT275.FieldByName('DESCRIZIONE').AsString);
      selT275.Next;
    end;
  end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.caricaListaGgLav;
begin
 with TWA080FSoglieStraordinarioDM(WR302DM) do
  begin
    ListaGgLav.Clear;
    ListaGgLav.Add('<*L>  Eccedenza liquidabile');
    selT275.First;
    while not selT275.Eof do
    begin
      ListaGgLav.Add(selT275.FieldByName('CODICE').AsString+'    '+selT275.FieldByName('DESCRIZIONE').AsString);
      selT275.Next;
    end;
  end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.createGgLavImgWC013(DBG_ROWID:String);
var r : Integer;
    img : TmeIWImageFile;
begin
  for r := ifthen(grdTabella.medpDataSet.state in [dsInsert],0,1) to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('CAUSALI_GGLAV'),1) <> nil then
    begin
      caricaListaGgLav;
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('CAUSALI_GGLAV'),1));
      img.OnClick:=imgGgLavClick;
    end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.createGgNoLavImgWC013(DBG_ROWID:String);
var r : Integer;
    img : TmeIWImageFile;
begin
  for r := ifthen(grdTabella.medpDataSet.state in [dsInsert],0,1) to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('CAUSALI_GGNONLAV'),1) <> nil then
    begin
      caricaListaGgNoLav;
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('CAUSALI_GGNONLAV'),1));
      img.OnClick:=imgGgNoLavClick;
    end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.createImgSelAnagrafe(DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  for r := ifthen(grdTabella.medpDataSet.state in [dsInsert],0,1) to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('SELEZIONE_ANAGRAFE'),1) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('SELEZIONE_ANAGRAFE'),1));
      img.OnClick:=imgSelAnagrafeClick;
    end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPOCARTELLINO'),0)).Caption:=TWA080FSoglieStraordinarioDM(WR302DM).selTabella.GetVariable('TIPOCARTELLINO');
  TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DECORRENZA'),0)).Caption:=TWA080FSoglieStraordinarioDM(WR302DM).selTabella.FieldByName('DECORRENZA').AsString;
  createImgSelAnagrafe(IntToStr(Row));
  createGgLavImgWC013(IntToStr(Row));
  createGgNoLavImgWC013(IntToStr(Row));
end;

procedure TWA080FSoglieStraordinarioBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with TWA080FSoglieStraordinarioDM(WR302DM).selTabella do
  begin
    FieldByName('TIPOCARTELLINO').AsString:=TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPOCARTELLINO'),0)).Caption;
    FieldByName('DECORRENZA').AsString:=TmeIWLabel(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DECORRENZA'),0)).Caption;
    FieldByName('SELEZIONE_ANAGRAFE').AsString:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('SELEZIONE_ANAGRAFE'),0)).Text;
    FieldByName('CAUSALI_GGNONLAV').AsString:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('CAUSALI_GGNONLAV'),0)).Text;
    FieldByName('CAUSALI_GGLAV').AsString:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('CAUSALI_GGLAV'),0)).Text;
  end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.imgGgLavClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    ckList.Items.Clear;
    ckList.Items.Assign(ListaGgLav);
    ResultEvent:=cklistGgLavResult;
    C190PutCheckList(TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('CAUSALI_GGLAV'),0)).Text,5,ckList);
    Visualizza;
  end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.imgGgNoLavClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    ckList.Items.Clear;
    ckList.Items.Assign(ListaGgNoLav);
    ResultEvent:=cklistGgNoLavResult;
    C190PutCheckList(TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('CAUSALI_GGNONLAV'),0)).Text,5,ckList);
    Visualizza;
  end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.cklistGgLavResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('CAUSALI_GGLAV'),0)).Text:=Trim(C190GetCheckList(5,WC013.ckList));
end;

procedure TWA080FSoglieStraordinarioBrowseFM.cklistGgNoLavResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('CAUSALI_GGNONLAV'),0)).Text:=Trim(C190GetCheckList(5,WC013.ckList));
end;

procedure TWA080FSoglieStraordinarioBrowseFM.imgSelAnagrafeClick(Sender: TObject);
var tmpStato:TDataSetState;
begin
  with TWA080FSoglieStraordinario(Self.Owner).grdC700 do
  begin
    WC700FM.ResultEvent:=resultSelAnagrafe;
    actSelezioneAnagraficheExecute(nil);
  end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.resultSelAnagrafe(Sender: TObject; Result: Boolean);
  function TrasformaV430(X:String):String;
    var Apice:Boolean;
        i:Integer;
    begin
      Result:='';
      i:=1;
      Apice:=False;
      while i <= Length(X) do
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
      Result:=EliminaRitornoACapo(Trim(X));
    end;
var S:string;
begin
  if result then
  begin
    S:=Trim(TWR100FBase(Self.Owner).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('SELEZIONE_ANAGRAFE'),0)).Text:=TrasformaV430(S);
  end;
end;

procedure TWA080FSoglieStraordinarioBrowseFM.SettaCausali(S:String);
var L:TStringList;
    i,P:Integer;
begin
  if Trim(S) = '' then
    exit;
  L:=TStringList.Create;
  try
    L.CommaText:=S;
    for i:=0 to L.Count - 1 do
    begin
      P:=WC013.ckList.Items.IndexOf(L[i]);
      if P >= 0 then
        WC013.ckList.IsChecked[P]:=True;
    end;
  finally
    L.Free;
  end;
end;

end.
