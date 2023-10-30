unit WA031UParScaricoDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, IWCompButton,
  meIWButton, A000UInterfaccia,
  IWDBGrids, medpIWDBGrid, meIWGrid,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWEdit, WC013UCheckListFM,
  IWCompGrids, IWCompExtCtrls, IWCompJQueryWidget, meIWLabel,DB, IWCompMemo,
  meIWDBMemo, meIWCheckBox, meIWImageButton, WC010UMemoEditFM;

type
  TWA031FParScaricoDettFM = class(TWR205FDettTabellaFM)
    dedtOffsetAnno: TmeIWDBEdit;
    lblNomeScarico: TmeIWLabel;
    dedtAziendeAbilitate: TmeIWDBEdit;
    lblAziendeAbilitate: TmeIWLabel;
    lblTipologiaTimbrature: TmeIWLabel;
    drgpTipologiaTimbrature: TmeIWDBRadioGroup;
    dchkScaricoAutomatico: TmeIWDBCheckBox;
    dchkScaricoDating: TmeIWDBCheckBox;
    dchkProceduraPrima: TmeIWDBCheckBox;
    dchkProceduraDopo: TmeIWDBCheckBox;
    lblOffsetAnno: TmeIWLabel;
    lblPeriodoTolleranza: TmeIWLabel;
    lblGiorniPrecElab: TmeIWLabel;
    lblGiorniSucElab: TmeIWLabel;
    dedtGiorniPrecElab: TmeIWDBEdit;
    dedtGiorniSucElab: TmeIWDBEdit;
    dchkSegnalaAnomalia: TmeIWDBCheckBox;
    dchkRegistra: TmeIWDBCheckBox;
    lblFileSequenziale: TmeIWLabel;
    lblNomeFile: TmeIWLabel;
    dedtCodiceEntrata: TmeIWDBEdit;
    lblCodiceEntrata: TmeIWLabel;
    dedtCodiceUscita: TmeIWDBEdit;
    lblCodiceUscita: TmeIWLabel;
    dedtNomeScarico: TmeIWDBEdit;
    btnAziendeAbilitate: TmeIWButton;
    grdMappatura: TmeIWGrid;
    lblMappatura: TmeIWLabel;
    dedtNomeFile: TmeIWDBEdit;
    dmemExprChiave: TmeIWDBMemo;
    chkExprChiave: TmeIWCheckBox;
    btnSrcTriggerBefore: TmeIWImageButton;
    btnSrcTriggerAfter: TmeIWImageButton;
    procedure dchkScaricoDatingAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdMappaturaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnAziendeAbilitateClick(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure chkExprChiaveClick(Sender: TObject);
    procedure btnSrcTriggerBeforeClick(Sender: TObject);
  private
    WC013:TWC013FCheckListFM;
    isChkExprChiaveClicked: boolean;
    procedure cklistAziendeResult(Sender: TObject; Result:Boolean);
  public
    procedure AttivaGrid(ActiveEdit:Boolean);
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses WA031UParScarico, WA031UParScaricoDM, WR100UBase;

{$R *.dfm}

procedure TWA031FParScaricoDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  dmemExprChiave.Visible:=false or isChkExprChiaveClicked;
  chkExprChiave.Checked:=false or isChkExprChiaveClicked;
  isChkExprChiaveClicked:=False;
  if (WR302DM as TWA031FParScaricoDM) <> nil then
    if (WR302DM as TWA031FParScaricoDM).selTabella.FieldByName('EXPR_CHIAVE').AsString <> '' then
    begin
      dmemExprChiave.Visible:=True;
      chkExprChiave.Checked:=True;
    end;
end;

procedure TWA031FParScaricoDettFM.btnAziendeAbilitateClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ResultEvent:=cklistAziendeResult;
    ckList.Items.Clear;
    //ckList.Items.Assign(Lista275);

    if Parametri.Azienda <> 'AZIN' then
    begin
      TWA031FParScaricoDM(WR302DM).selI090.Filtered:=False;
      TWA031FParScaricoDM(WR302DM).selI090.Filter:='AZIENDA = ''' + Parametri.Azienda + '''';
      TWA031FParScaricoDM(WR302DM).selI090.Filtered:=True;
    end;
    TWA031FParScaricoDM(WR302DM).selI090.First;
    while not TWA031FParScaricoDM(WR302DM).selI090.Eof do
    begin
      ckList.Items.Add(TWA031FParScaricoDM(WR302DM).selI090.FieldByName('AZIENDA').AsString);
      TWA031FParScaricoDM(WR302DM).selI090.Next;
    end;
    C190PutCheckList(dedtAziendeAbilitate.Text,30,ckList);

    WC013.Visualizza;
  end;
end;

procedure TWA031FParScaricoDettFM.btnSrcTriggerBeforeClick(Sender: TObject);
var
  LLst: TStringList;
  LObjName: string;
  LTitolo: string;
begin
  if Sender = btnSrcTriggerBefore then
  begin
    LObjName:='TIMB_TRIGGER_BEFORE';
    LTitolo:='Sorgente procedura Oracle eseguita prima dell''acquisizione';
  end
  else if Sender = btnSrcTriggerAfter then
  begin
    LObjName:='TIMB_TRIGGER_AFTER';
    LTitolo:='Sorgente procedura Oracle eseguita dopo l''acquisizione';
  end;

  LLst:=TStringList.Create;
  try
    R180OracleObjectSource(LObjName,SessioneOracle,LLst);
    TWC010FMemoEditFM.Visualizza(LTitolo,800,600,Llst);
  finally
    FreeAndNil(LLst);
  end;
end;

procedure TWA031FParScaricoDettFM.chkExprChiaveClick(Sender: TObject);
begin
  inherited;
  dmemExprChiave.Visible:=not dmemExprChiave.Visible;
  isChkExprChiaveClicked:=chkExprChiave.Checked;
end;

procedure TWA031FParScaricoDettFM.cklistAziendeResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtAziendeAbilitate.DataField).AsString:=C190GetCheckList(30,WC013.ckList);
end;

procedure TWA031FParScaricoDettFM.DataSet2Componenti;
var i,P:Byte;
    S:String;
begin
  with TWA031FParScaricoDM(WR302DM) do
    for i:=0 to Length(ColonneGrdMappaturaDati) - 1 do
    begin
      S:=selTabella.FieldByName(ColonneGrdMappaturaDati[i]).AsString;
      P:=Pos(',',S);
      grdMappatura.Cell[1,i + 1].Text:=Copy(S,1,P - 1);
      grdMappatura.Cell[2,i + 1].Text:=Copy(S,P + 1,Length(S));
    end;
end;

procedure TWA031FParScaricoDettFM.Componenti2DataSet;
var
  i : Integer;
  P,L : Word;
begin
  with TWA031FParScaricoDM(WR302DM) do
    for i:=0 to Length(ColonneGrdMappaturaDati) - 1 do
    begin
      P:=StrToIntDef(TmeIWEdit(grdMappatura.Cell[1,i + 1].Control).Text,0);
      L:=StrToIntDef(TmeIWEdit(grdMappatura.Cell[2,i + 1].Control).Text,0);
      selTabella.FieldByName(ColonneGrdMappaturaDati[i]).AsString:=IntToStr(P) + ',' + IntToStr(L);
    end;
end;

procedure TWA031FParScaricoDettFM.AbilitaComponenti;
begin
  with TWA031FParScaricoDM(WR302DM) do
  begin
    if selTabella.State in [dsEdit,dsInsert] then
      dedtOffsetAnno.Enabled:=dchkScaricoDating.Checked;
    attivaGrid(selTabella.State in [dsEdit,dsInsert]);
  end;

  btnSrcTriggerBefore.Enabled:=True;
  btnSrcTriggerAfter.Enabled:=True;
end;

procedure TWA031FParScaricoDettFM.dchkScaricoDatingAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  dedtOffsetAnno.Enabled:=dchkScaricoDating.Checked;
end;

procedure TWA031FParScaricoDettFM.grdMappaturaRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not C190RenderCell(ACell,ARow,AColumn,True,False,False) then
    Exit;

  if AColumn = 0 then
    ACell.Css:=ACell.Css + ' riga_intestazione';
end;

procedure TWA031FParScaricoDettFM.AttivaGrid(ActiveEdit:Boolean);
var
  i: Integer;
begin
  if ActiveEdit then
  begin
    for i:=1 to Length(TWA031FParScaricoDM(WR302DM).ColonneGrdMappaturaDati) do
    begin
      grdMappatura.Cell[1,i].Control:=TmeIWEdit.Create(Self);
      TmeIWEdit(grdMappatura.Cell[1,i].Control).Text:=grdMappatura.Cell[1,i].Text;
      TmeIWEdit(grdMappatura.Cell[1,i].Control).Css:='input5';
      grdMappatura.Cell[1,i].Text:='';

      grdMappatura.Cell[2,i].Control:=TmeIWEdit.Create(Self);
      TmeIWEdit(grdMappatura.Cell[2,i].Control).Text:=grdMappatura.Cell[2,i].Text;
      TmeIWEdit(grdMappatura.Cell[2,i].Control).Css:='input5';
      grdMappatura.Cell[2,i].Text:='';
    end;
  end
  else
  begin
    for i:=1 to Length(TWA031FParScaricoDM(WR302DM).ColonneGrdMappaturaDati) do
      begin
        grdMappatura.Cell[1,i].Control:=nil;
        grdMappatura.Cell[2,i].Control:=nil;
      end;
  end;
end;
procedure TWA031FParScaricoDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  grdMappatura.RowCount:=3;
  grdMappatura.ColumnCount:=13;

  grdMappatura.Cell[0,0].Text:='';
  grdMappatura.Cell[0,1].Text:='Badge';
  grdMappatura.Cell[0,2].Text:='Ediz.Badge';
  grdMappatura.Cell[0,3].Text:='Anno';
  grdMappatura.Cell[0,4].Text:='Mese';
  grdMappatura.Cell[0,5].Text:='Giorno';
  grdMappatura.Cell[0,6].Text:='Ore';
  grdMappatura.Cell[0,7].Text:='Minuti';
  grdMappatura.Cell[0,8].Text:='Secondi';
  grdMappatura.Cell[0,9].Text:='Verso';
  grdMappatura.Cell[0,10].Text:='Rilevatore';
  grdMappatura.Cell[0,11].Text:='Causale';
  grdMappatura.Cell[0,12].Text:='Chiave';

  grdMappatura.Cell[1,0].Text:='Pos.';
  grdMappatura.Cell[2,0].Text:='Lung.';
  inherited;
end;

end.
