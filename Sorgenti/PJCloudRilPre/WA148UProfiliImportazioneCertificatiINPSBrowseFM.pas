unit WA148UProfiliImportazioneCertificatiINPSBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, StrUtils,DB, Math,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids, meIWComboBox,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer, meIWEdit, meIWImageFile,
  IWHTML40Container, IWRegion, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Vcl.Menus;

type
  TWA148FProfiliImportazioneCertificatiINPSBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    procedure createImgSelAnagrafe(DBG_ROWID: string);
    procedure imgSelAnagrafeClick(Sender: TObject);
    procedure resultSelAnagrafe(Sender: TObject; Result: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WR100UBase, WA148UProfiliImportazioneCertificatiINPS, WA148UProfiliImportazioneCertificatiINPSDM;

{$R *.dfm}

procedure TWA148FProfiliImportazioneCertificatiINPSBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FILTRO'),1,DBG_IMG,'','SELANAGRAFE','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('dCProvvisoria'),0,DBG_CMB,'25','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('dCInserimento'),0,DBG_CMB,'25','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('dCRicovero'),0,DBG_CMB,'25','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('dCPostRicovero'),0,DBG_CMB,'25','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('dCSalvaVita'),0,DBG_CMB,'25','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('dCInvalidita'),0,DBG_CMB,'25','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('dCServizio'),0,DBG_CMB,'25','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('POSTRICOVERO_AUTO'),0,DBG_CMB,'5','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FLAG_IGNORA_NUOVO_PERIODO'),0,DBG_CMB,'5','','','','S');
end;

procedure TWA148FProfiliImportazioneCertificatiINPSBrowseFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with TWA148FProfiliImportazioneCertificatiINPSDM(WR302DM) do
  begin
    selTabella.FieldByName('FILTRO').AsString:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('FILTRO'),0)).Text;
    selTabella.FieldByName('CAUS_PROVVISORIA').AsString:=VarToStr(A148MW.selT265_All.Lookup('DESCRIZIONE',(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCProvvisoria'),0) as TmeIWComboBox).Text,'CODICE'));
    selTabella.FieldByName('CAUS_INSERIMENTO').AsString:=VarToStr(A148MW.selT265.Lookup('DESCRIZIONE',(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInserimento'),0) as TmeIWComboBox).Text,'CODICE'));
    selTabella.FieldByName('CAUS_RICOVERO').AsString:=VarToStr(A148MW.selT265_All.Lookup('DESCRIZIONE',(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCRicovero'),0) as TmeIWComboBox).Text,'CODICE'));
    selTabella.FieldByName('CAUS_POSTRICOVERO').AsString:=VarToStr(A148MW.selT265_All.Lookup('DESCRIZIONE',(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCPostRicovero'),0) as TmeIWComboBox).Text,'CODICE'));
    selTabella.FieldByName('CAUS_SALVAVITA').AsString:=VarToStr(A148MW.selT265_All.Lookup('DESCRIZIONE',(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCSalvaVita'),0) as TmeIWComboBox).Text,'CODICE'));
    selTabella.FieldByName('CAUS_INVALIDITA').AsString:=VarToStr(A148MW.selT265_All.Lookup('DESCRIZIONE',(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInvalidita'),0) as TmeIWComboBox).Text,'CODICE'));
    selTabella.FieldByName('CAUS_SERVIZIO').AsString:=VarToStr(A148MW.selT265_All.Lookup('DESCRIZIONE',(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCServizio'),0) as TmeIWComboBox).Text,'CODICE'));
    selTabella.FieldByName('POSTRICOVERO_AUTO').AsString:=(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('POSTRICOVERO_AUTO'),0) as TmeIWComboBox).Text;
    selTabella.FieldByName('FLAG_IGNORA_NUOVO_PERIODO').AsString:=(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('FLAG_IGNORA_NUOVO_PERIODO'),0) as TmeIWComboBox).Text;
  end;
end;

procedure TWA148FProfiliImportazioneCertificatiINPSBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  createImgSelAnagrafe(IntToStr(Row));

  //inizializzo combo
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCProvvisoria'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInserimento'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCRicovero'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCPostRicovero'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCSalvaVita'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCServizio'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInvalidita'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('POSTRICOVERO_AUTO'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
    Items.Add('S');
    Items.Add('N');
    ItemIndex:=Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('POSTRICOVERO_AUTO').AsString);
  end;
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FLAG_IGNORA_NUOVO_PERIODO'),0) as TmeIWComboBox) do
  begin
    Items.Clear;
    RequireSelection:=False;
    NoSelectionText:=' ';
    Items.Add('S');
    Items.Add('N');
    ItemIndex:=Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('FLAG_IGNORA_NUOVO_PERIODO').AsString);
  end;

  //Carico combo
  with (WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).A148MW do
  begin
    selT265_All.First;
    while not selT265_All.Eof do
    begin
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCProvvisoria'),0) as TmeIWComboBox).Items.Add(selT265_All.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCRicovero'),0) as TmeIWComboBox).Items.Add(selT265_All.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCPostRicovero'),0) as TmeIWComboBox).Items.Add(selT265_All.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCSalvaVita'),0) as TmeIWComboBox).Items.Add(selT265_All.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInvalidita'),0) as TmeIWComboBox).Items.Add(selT265_All.FieldByName('DESCRIZIONE').AsString);
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCServizio'),0) as TmeIWComboBox).Items.Add(selT265_All.FieldByName('DESCRIZIONE').AsString);
      selT265_All.Next;
    end;
    selT265.First;
    while not selT265.Eof do
    begin
      (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInserimento'),0) as TmeIWComboBox).Items.Add(selT265.FieldByName('DESCRIZIONE').AsString);
      selT265.Next;
    end;
  end;
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCProvvisoria'),0) as TmeIWComboBox).ItemIndex:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCProvvisoria'),0) as TmeIWComboBox).Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('dCProvvisoria').AsString);
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInserimento'),0) as TmeIWComboBox).ItemIndex:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInserimento'),0) as TmeIWComboBox).Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('dCInserimento').AsString);
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCRicovero'),0) as TmeIWComboBox).ItemIndex:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCRicovero'),0) as TmeIWComboBox).Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('dCRicovero').AsString);
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCPostRicovero'),0) as TmeIWComboBox).ItemIndex:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCPostRicovero'),0) as TmeIWComboBox).Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('dCPostRicovero').AsString);
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCSalvaVita'),0) as TmeIWComboBox).ItemIndex:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCSalvaVita'),0) as TmeIWComboBox).Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('dCSalvaVita').AsString);
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInvalidita'),0) as TmeIWComboBox).ItemIndex:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCInvalidita'),0) as TmeIWComboBox).Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('dCServizio').AsString);
  (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCServizio'),0) as TmeIWComboBox).ItemIndex:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('dCServizio'),0) as TmeIWComboBox).Items.IndexOf((WR302DM as TWA148FProfiliImportazioneCertificatiINPSDM).SelTabella.FieldByName('dCServizio').AsString);
end;

procedure TWA148FProfiliImportazioneCertificatiINPSBrowseFM.createImgSelAnagrafe(DBG_ROWID: string);
var r : Integer;
    img : TmeIWImageFile;
begin
  for r := ifthen(grdTabella.medpDataSet.state in [dsInsert],0,1) to High(grdTabella.medpCompGriglia) do
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('FILTRO'),1) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('FILTRO'),1));
      img.OnClick:=imgSelAnagrafeClick;
    end;
end;

procedure TWA148FProfiliImportazioneCertificatiINPSBrowseFM.imgSelAnagrafeClick(Sender: TObject);
var tmpStato:TDataSetState;
begin
  with TWA148FProfiliImportazioneCertificatiINPS(Self.Owner).grdC700 do
  begin
    WC700FM.ResultEvent:=resultSelAnagrafe;
    actSelezioneAnagraficheExecute(nil);
  end;
end;

procedure TWA148FProfiliImportazioneCertificatiINPSBrowseFM.resultSelAnagrafe(Sender: TObject; Result: Boolean);
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
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('FILTRO'),0)).Text:=TrasformaV430(S);
  end;
end;


end.
