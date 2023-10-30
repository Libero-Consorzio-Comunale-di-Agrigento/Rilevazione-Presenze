unit WS700UElementiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions, Vcl.ActnList, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, WR103UGestMasterDetail, DB, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg,
  meIWImageFile, Math, meIWEdit, IWCompButton, meIWButton, IWApplication, meIWMemo, meIWLabel,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, WC013UCheckListFM;

type
  TWS700FElementiFM = class(TWR203FGestDetailFM)
    pmnDettaglio: TPopupMenu;
    actScaricaInExcelDett1: TMenuItem;
    mniCopiaDettaglio: TMenuItem;
    meIWButton1: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actDetailEliminaExecute(Sender: TObject);
    procedure actDetailConfermaExecute(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure mniCopiaDettaglioClick(Sender: TObject);
    procedure meIWButton1Click(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure actDetailAnnullaExecute(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    procedure Ric;
    procedure imgCodClick(Sender: TObject);
    procedure CaricaLista;
    procedure imgCodResult(Sender: TObject; Result: Boolean);
    procedure mniCopiaDettaglioResult(Sender: TObject; Result: Boolean);
    procedure ResultCopiaDettaglio(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure AggiornaDettaglio; override;
    procedure AssegnaMenuDett;
    procedure DataSourceStateChange(Sender: TObject); override;
  end;

implementation

uses WS700UAreeValutazioniDM, WS700UAreeValutazioniDettFM, WR102UGestTabella;

{$R *.dfm}

procedure TWS700FElementiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  evBeforeApplyUpdates:=Ric;
end;

procedure TWS700FElementiFM.Ric;
var boo: Boolean;
begin
  boo:=( ( (WR302DM AS TWS700FAreeValutazioniDM).Owner as TWR102FGestTabella ).WDettaglioFM as TWS700FAreeValutazioniDettFM).dedtPesoPercMin.Enabled;
  (WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.RicalcolaPesoArea(boo, false);
end;

procedure TWS700FElementiFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  ( ( (WR302DM AS TWS700FAreeValutazioniDM).Owner as TWR102FGestTabella ).WDettaglioFM as TWS700FAreeValutazioniDettFM).AbilitaComponenti;
end;

procedure TWS700FElementiFM.actDetailAnnullaExecute(Sender: TObject);
begin
  actAnnullaExecute(Sender);
  ( ( (WR302DM AS TWS700FAreeValutazioniDM).Owner as TWR102FGestTabella ).WDettaglioFM as TWS700FAreeValutazioniDettFM).AbilitaComponenti;
end;

procedure TWS700FElementiFM.actDetailConfermaExecute(Sender: TObject);
var boo: Boolean;
begin
  actConfermaExecute(Sender);
  try
   boo:=( ( (WR302DM AS TWS700FAreeValutazioniDM).Owner as TWR102FGestTabella ).WDettaglioFM as TWS700FAreeValutazioniDettFM).dedtPesoPercMin.Enabled;
  (WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.RicalcolaPesoArea(boo, false);
  except
    on E:exception do
    begin
      ShowMessage(E.Message);
      actModificaExecute(actModifica);
    end;
  end;
end;

procedure TWS700FElementiFM.actDetailEliminaExecute(Sender: TObject);
var boo: Boolean;
begin
  actEliminaExecute(Sender);
  try
    boo:=( ( (WR302DM AS TWS700FAreeValutazioniDM).Owner as TWR102FGestTabella ).WDettaglioFM as TWS700FAreeValutazioniDettFM).dedtPesoPercMin.Enabled;
    (WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.RicalcolaPesoArea(boo, false);
  except
    on E:exception do
    begin
      ShowMessage(E.Message);
      actModificaExecute(actModifica);
    end;
  end;
end;

procedure TWS700FElementiFM.actModificaExecute(Sender: TObject);
begin
  AggiornaDettaglio;
  inherited;
end;

procedure TWS700FElementiFM.AggiornaDettaglio;
begin
  inherited;
  ( ( (WR302DM AS TWS700FAreeValutazioniDM).Owner as TWR102FGestTabella ).WDettaglioFM as TWS700FAreeValutazioniDettFM).AbilitaComponenti;
end;

procedure TWS700FElementiFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  r: Integer;
  img: TmeIWImageFile;
  mem: TmeIWMemo;
begin
  inherited;
  for r := ifthen(grdTabella.medpDataSet.state in [dsInsert],0,1) to High(grdTabella.medpCompGriglia) do
  begin
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('COD_AREA_LINK'),1) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('COD_AREA_LINK'),1));
      img.OnClick:=imgCodClick;
    end;
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('COD_VALUTAZIONE_LINK'),1) <> nil then
    begin
      img:=TmeIWImageFile(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('COD_VALUTAZIONE_LINK'),1));
      img.OnClick:=imgCodClick;
    end;
    if grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DESCRIZIONI_PUNTEGGI'),0) <> nil then
    begin
      mem:=TmeIWMemo(grdTabella.medpCompCella(r,grdTabella.medpIndexColonna('DESCRIZIONI_PUNTEGGI'),0));
      mem.Text:=grdTabella.medpValoreColonna(r,'DESCRIZIONI_PUNTEGGI');
    end;
  end;
end;

procedure TWS700FElementiFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  inherited;
  with grdTabella do
    if medpCompCella(Row,medpIndexColonna('DESCRIZIONI_PUNTEGGI'),0) <> nil then
      if medpCompCella(Row,medpIndexColonna('DESCRIZIONI_PUNTEGGI'),0) is TmeIWMemo then
        medpDataSet.FieldByName('DESCRIZIONI_PUNTEGGI').AsString:=TmeIWMemo(medpCompCella(Row,medpIndexColonna('DESCRIZIONI_PUNTEGGI'),0)).Text;
end;

procedure TWS700FElementiFM.imgCodClick(Sender: TObject);
var codArea, codValu: String;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  CaricaLista;
  with WC013 do
  begin
    ResultEvent:=imgCodResult;
    codArea:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_AREA_LINK'),0)).Text;
    codValu:=TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_VALUTAZIONE_LINK'),0)).Text;
    C190PutCheckList(codArea+' '+codValu,12,ckList);
    Visualizza(0,1);
  end;
end;

procedure TWS700FElementiFM.CaricaLista;
begin
  with (WR302DM AS TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selLinkItem do
  begin
    First;
    while not Eof do
    begin
      WC013.ckList.Items.Add(Format('%-5s %s %s',[FieldByName('COD_AREA').AsString,FieldByName('COD_VALUTAZIONE').AsString, FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

procedure TWS700FElementiFM.imgCodResult(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_AREA_LINK'),0)).Text:=Trim(C190GetCheckList(5,WC013.ckList));
    TmeIWEdit(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('COD_VALUTAZIONE_LINK'),0)).Text:=Trim(Copy(C190GetCheckList(11,WC013.ckList),7,5));
    TmeIWLabel(grdTabella.medpCompCella(grdTabella.medpClientDataSet.RecNo-1,grdTabella.medpIndexColonna('DESCRIZIONE_LINK'),0)).Text:=Trim(Copy(C190GetCheckList(999,WC013.ckList),13,999));
  end
end;

procedure TWS700FElementiFM.DataSourceStateChange(Sender: TObject);
begin
  inherited;
  AssegnaMenuDett;
end;

procedure TWS700FElementiFM.AssegnaMenuDett;
begin
  if not ((((WR302DM as TWS700FAreeValutazioniDM).Owner as TWR102FGestTabella).WBrowseFM).grdTabella.medpDataSet.State in [dsInsert,dsEdit])
  and not (grdTabella.medpDataSet.State in [dsInsert,dsEdit])
  and ((WR302DM as TWS700FAreeValutazioniDM).selTabella.FieldByName('TIPO_PESO_PERCENTUALE').AsString = '1')
  and ((WR302DM as TWS700FAreeValutazioniDM).selTabella.FieldByName('TIPO_LINK_ITEM').AsString = '0') then
    grdTabella.medpContextMenu:=pmnDettaglio
  else
    grdTabella.medpContextMenu:=pmnGrdTabellaDett;
end;

procedure TWS700FElementiFM.mniCopiaDettaglioClick(Sender: TObject);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[meIWButton1.HTMLName]));
end;

procedure TWS700FElementiFM.meIWButton1Click(Sender: TObject);
begin
  inherited;
  (WR302DM as TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.AreeCopiaDettaglio;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with WC013 do
  begin
    ResultEvent:=mniCopiaDettaglioResult;
    with (WR302DM as TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.selSG701a do
      while not Eof do
      begin
        ckList.Items.Add(Format('%-5s %s',[FieldByName('COD_AREA').AsString,FieldByName('DESCRIZIONE').AsString]));
        Next;
      end;
    Visualizza(0,0,'Aree con decorrenza ' + (WR302DM as TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.SG701_Funzioni.FieldByName('DECORRENZA').AsString);
  end;
end;

procedure TWS700FElementiFM.mniCopiaDettaglioResult(Sender: TObject; Result:Boolean);
begin
  with (WR302DM as TWS700FAreeValutazioniDM).S700FAreeValutazioniMW do
  begin
    AreeSel:='';
    if Result then
      AreeSel:=Trim(C190GetCheckList(5,WC013.ckList));
    if AreeSel = '' then
      Exit;
    MsgBox.WebMessageDlg(Format(A000MSG_S700_DLG_FMT_COPIA_DETT,[SG701_Funzioni.FieldByName('COD_AREA').AsString,AreeSel,SG701_Funzioni.FieldByName('DECORRENZA').AsString]),mtConfirmation,[mbYes,mbNo],ResultCopiaDettaglio,'');
  end;
end;

procedure TWS700FElementiFM.ResultCopiaDettaglio(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    (WR302DM as TWS700FAreeValutazioniDM).S700FAreeValutazioniMW.CopiaDettaglio;
    MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA,mtInformation,[mbOk],nil,'');
  end
end;

end.
