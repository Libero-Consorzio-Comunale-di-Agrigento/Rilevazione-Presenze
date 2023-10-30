
unit WA064UBudgetStraordinario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton, meIWImageFile,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, WR100UBase, C180FunzioniGenerali,
  meIWLink, IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompListbox, meIWComboBox, DB, Oracle, IWCompEdit, meIWEdit,
  A000UCostanti;

type
  TWA064FBudgetStraordinario = class(TWR103FGestMasterDetail)
    lblFiltroAnno: TmeIWLabel;
    cmbFiltroAnno: TmeIWComboBox;
    rgpTipoResiduo: TmeTIWAdvRadioGroup;
    actlstWA064ToolBar: TActionList;
    grdWA064ToolBar: TmeIWGrid;
    actStampa: TAction;
    actAllineamentoBudget: TAction;
    procedure actWA064ToolBarExecute(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure cmbFiltroAnnoChange(Sender: TObject);
    procedure rgpTipoResiduoClick(Sender: TObject);
  private
    { Private declarations }
    function InizializzaAccesso:Boolean; override;
    procedure ApriA063(Gruppo,Tipo: string; Decorrenza: TDateTime);
    procedure CreaNavigatorBar;
    procedure imgToolBarClick(Sender: TObject);
  protected
    procedure RefreshPage; override;
  public
    { Public declarations }
    procedure AbilitaAzioni;
  end;

implementation

uses WA064UBudgetStraordinarioMesiFM, WA064UBudgetStraordinarioDM,
     WA064UBudgetStraordinarioBrowseFM, WA064UBudgetStraordinarioDettFM;

{$R *.dfm}

function TWA064FBudgetStraordinario.InizializzaAccesso: Boolean;
begin
  Result:=False;
  cmbFiltroAnnoChange(nil);
  WR302DM.selTabella.First; //Serve perchè così abilita correttamente il dettaglio
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA064FBudgetStraordinario.IWAppFormCreate(Sender: TObject);
var Detail:TWA064FBudgetStraordinarioMesiFM;
begin
  inherited;
  InterfacciaWR102.ChiaveReadOnly:=True;
  WR100LinkWC700:=False;
  WR302DM:=TWA064FBudgetStraordinarioDM.Create(Self);
  WBrowseFM:=TWA064FBudgetStraordinarioBrowseFM.Create(Self);
  WDettaglioFM:=TWA064FBudgetStraordinarioDettFM.Create(Self);

  Detail:=TWA064FBudgetStraordinarioMesiFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio((WR302DM as TWA064FBudgetStraordinarioDM).selT714,(WR302DM as TWA064FBudgetStraordinarioDM).dsrT714);

  TWA064FBudgetStraordinarioDM(WR302DM).CallT063:=ApriA063;

  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.ini
  TabBrowseCaption:='Gruppi';
  // MONDOEDP - commessa.ini MAN/08 SVILUPPO#161.fine
  CreaTabDefault;

  AttivaGestioneC700;
  grdC700.AttivaBrowse:=False;

  CreaNavigatorBar;
end;

procedure TWA064FBudgetStraordinario.RefreshPage;
var BM:TBookMark;
begin
  inherited;
  if TWA064FBudgetStraordinarioDM(WR302DM).selTabella.Active then
  begin
    BM:=TWA064FBudgetStraordinarioDM(WR302DM).selTabella.GetBookMark;
    TWA064FBudgetStraordinarioDM(WR302DM).selTabella.Refresh;
    TWA064FBudgetStraordinarioDM(WR302DM).selTabella.GoToBookMark(BM);
    TWA064FBudgetStraordinarioDM(WR302DM).selTabella.FreeBookMark(BM);
  end;
end;

procedure TWA064FBudgetStraordinario.CreaNavigatorBar;
var
  i, k:Integer;
begin
  grdWA064ToolBar.RowCount:=1;
  grdWA064ToolBar.ColumnCount:=actlstWA064ToolBar.ActionCount;

  k:=0;
  for i:=0 to actlstWA064ToolBar.ActionCount - 1 do
  begin
    grdWA064ToolBar.Cell[0,k].Control:=TmeIWImageFile.Create(Self);
    with TmeIWImageFile(grdWA064ToolBar.Cell[0,k].Control) do
    begin
      OnClick:=imgToolBarClick;
      Tag:=i;
    end;
    grdWA064ToolBar.Cell[0,k].Css:='x';
    grdWA064ToolBar.Cell[0,k].Text:='';
    k:=k + 1;
  end;
  AggiornaToolBar(grdWA064ToolBar,actlstWA064ToolBar);
end;



procedure TWA064FBudgetStraordinario.imgToolBarClick(Sender: TObject);
begin
  MessaggioStatus(INFORMA,'');
  TAction(actlstWA064ToolBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA064FBudgetStraordinario.AbilitaAzioni;
begin
  with (WR302DM as TWA064FBudgetStraordinarioDM).A064MW do
    if selT713.Active then
    begin
      actNuovo.Enabled:=(selT713.State = dsBrowse) and (not SolaLettura);
      actElimina.Enabled:=(selT713.RecordCount > 0) and (selT713.State = dsBrowse) and (not SolaLettura);
      actModifica.Enabled:=(selT713.RecordCount > 0) and (selT713.State = dsBrowse) and (not SolaLettura);
      TWA064FBudgetStraordinarioDettFM(WDettaglioFM).dcmbTipo.ReadOnly:=selT713.FieldByName('TIPO').ReadOnly;
      TWA064FBudgetStraordinarioDettFM(WDettaglioFM).dedtCodGruppo.ReadOnly:=selT713.FieldByName('CODGRUPPO').ReadOnly;
      TWA064FBudgetStraordinarioDettFM(WDettaglioFM).cmbDalMese.Enabled:=(selT713.State = dsInsert) and (not selT713.FieldByName('DECORRENZA').ReadOnly);
      TWA064FBudgetStraordinarioDettFM(WDettaglioFM).cmbAlMese.Enabled:=(selT713.State = dsInsert) and (not selT713.FieldByName('DECORRENZA_FINE').ReadOnly);
      actAllineamentoBudget.Enabled:=(selT713.RecordCount > 0) and (selT713.State = dsBrowse) and (not SolaLettura);
      actStampa.Enabled:=(selT713.RecordCount > 0) and (selT713.State = dsBrowse) and (not SolaLettura);

     if selT714.Active then
      begin
        TWA064FBudgetStraordinarioMesiFM(DetailFM[0]).actModifica.Enabled:=(selT713.RecordCount > 0)
                                                                            and (selT714.RecordCount > 0)
                                                                            and (not TWA064FBudgetStraordinarioMesiFM(DetailFM[0]).actConferma.Enabled)
                                                                            and (not SolaLettura);
        TWA064FBudgetStraordinarioMesiFM(DetailFM[0]).actNuovo.Enabled:=False;
        TWA064FBudgetStraordinarioMesiFM(DetailFM[0]).actElimina.Enabled:=False;
      end;
      (*TODO
      actAccediAllineamentoBudget.Enabled:=selT713.State = dsBrowse;
      if frmToolbarFiglio.TFDButton <> nil then
        frmToolbarFiglio.AbilitaAzioniTF(nil);
      if selT714.Active then
      begin
        frmToolbarFiglio.actTFInserisci.Enabled:=False;
        frmToolbarFiglio.actTFModifica.Enabled:=(selT713.RecordCount > 0) and (selT714.RecordCount > 0) and (not frmToolBarFiglio.actTFConferma.Enabled) and (not SolaLettura);
        frmToolbarFiglio.actTFCancella.Enabled:=False;
      end;
      *)
    end;
end;

procedure TWA064FBudgetStraordinario.actWA064ToolBarExecute(Sender: TObject);
var Params: String;
begin
  Params:='CODGRUPPO=' + TWA064FBudgetStraordinarioDM(WR302DM).selTabella.FieldByName('CODGRUPPO').AsString + ParamDelimiter +
          'TIPO=' + TWA064FBudgetStraordinarioDM(WR302DM).selTabella.FieldByName('TIPO').AsString + ParamDelimiter +
          'DECORRENZA=' + TWA064FBudgetStraordinarioDM(WR302DM).selTabella.FieldByName('DECORRENZA').AsString;

  AccediForm(StrToInt(TAction(Sender).HelpKeyword),Params);
end;

procedure TWA064FBudgetStraordinario.ApriA063(Gruppo,Tipo: string; Decorrenza: TDateTime);
var Params: String;
begin
  inherited;
  Params:='CODGRUPPO=' + Gruppo + ParamDelimiter +
          'TIPO=' + Tipo + ParamDelimiter +
          'DECORRENZA=' + DateToStr(Decorrenza);

  TWR100FBase(Self).AccediForm(131,Params);
end;

procedure TWA064FBudgetStraordinario.cmbFiltroAnnoChange(Sender: TObject);
begin
  if WR302DM <> nil then
  begin
    (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.CambioAnno(cmbFiltroAnno.Text);
    Screen.Cursor:=crDefault;
    actAggiornaExecute(nil);
    (WR302DM as TWA064FBudgetStraordinarioDM).A064MW.AperturaDettaglio;
    AbilitaAzioni;
  end;
end;

procedure TWA064FBudgetStraordinario.rgpTipoResiduoClick(Sender: TObject);
begin
  (DetailFM[0] as TWA064FBudgetStraordinarioMesiFM).grdTabella.Refresh;
end;

end.
