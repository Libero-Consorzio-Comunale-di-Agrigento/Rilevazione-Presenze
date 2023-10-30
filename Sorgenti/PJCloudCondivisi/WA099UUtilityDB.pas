unit WA099UUtilityDB;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase, C180FunzioniGenerali,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompButton, C190FunzioniGeneraliWeb,
  IWDBStdCtrls, meIWLabel, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, IWAdvRadioGroup,
  IWCompMemo, meIWMemo, IWAdvCheckGroup, meTIWAdvCheckGroup, meTIWAdvRadioGroup,
  meIWTreeView, IWCompCheckbox, meIWCheckBox, A099UUtilityDBMW,
  AdvTreeNodes, medpIWMessageDlg, IWDBGrids,
  medpIWDBGrid, DB, DBClient, IWCompJQueryWidget, IWCompTreeview,
  IWCompExtCtrls, IWCompGrids, meIWImageFile,A000UMessaggi,Clipbrd, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  meIWEdit;

type
  TWA099FUtilityDB = class(TWR100FBase)
    JQuery: TIWJQueryWidget;
    rgpSelezioneTabelle: TmeTIWAdvRadioGroup;
    cgpTabelle: TmeTIWAdvCheckGroup;
    memResult: TmeIWMemo;
    btnTableNoParallel: TmeIWButton;
    btnIndexNoParallel: TmeIWButton;
    btnDeleteSchemaStats: TmeIWButton;
    btnGatherSchemaStats: TmeIWButton;
    btnGatherTableStats: TmeIWButton;
    btnMoveTablespace: TmeIWButton;
    btnRebuildIndexes: TmeIWButton;
    btnDeleteStatistics: TmeIWButton;
    btnAnalyzeTable: TmeIWButton;
    btnAnalyzeColumns: TmeIWButton;
    btnAnalyzeIndexes: TmeIWButton;
    btnRicompilaInvalidi: TmeIWButton;
    btnRicompilaTutto: TmeIWButton;
    lblParametriCompilazione: TmeIWLabel;
    chkDebug: TmeIWCheckBox;
    chkCodeTypeInterpreted: TmeIWCheckBox;
    chkCodeTypeNative: TmeIWCheckBox;
    chkReuseSettings: TmeIWCheckBox;
    btnRicompilaSelezionato: TmeIWButton;
    lblSelezionato: TmeIWLabel;
    lblOggettoSelezionato: TmeIWLabel;
    btnEsegui: TmeIWButton;
    rgpQuerySupporto: TmeTIWAdvRadioGroup;
    grdQuerySupporto: TmedpIWDBGrid;
    dcdsTablespace: TDataSource;
    cdsTablespace: TClientDataSet;
    imgDeselezionaTutto: TmeIWImageFile;
    imgInvertiSelezione: TmeIWImageFile;
    imgSelezionaTutto: TmeIWImageFile;
    trvOggettiDB: TmeIWTreeView;
    btnShrinkTable: TmeIWButton;
    btnV430Storico: TmeIWButton;
    btnCopiaTestoQuery: TmeIWButton;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure rgpSelezioneTabelleClick(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure btnClick2(Sender: TObject);
    procedure btnRicompilaTuttoClick(Sender: TObject);
    procedure btnRicompilaInvalidiClick(Sender: TObject);
    procedure btnRicompilaSelezionatoClick(Sender: TObject);
    procedure cgpTabelleAsyncItemClick(Sender: TObject; EventParams: TStringList;
      Index: Integer);
    procedure btnEseguiClick(Sender: TObject);
    procedure grdQuerySupportoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure imgSelezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgDeselezionaTuttoAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgInvertiSelezioneAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnV430StoricoClick(Sender: TObject);
    procedure btnCopiaTestoQueryClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
  private
    WA099DM:TA099FUtilityDBMW;
    NodoSelezionato:TIWTreeViewItem;
    CssOrigNodoSelezionato:String;
    SenderButton:TmeIWButton;
    LastIndexChecked:Integer;
    procedure ResultStats(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultStats2(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultSchema(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    procedure CaricaOggettiDB;
    procedure CreaQuerySupporto;
    procedure nodoClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TWA099FUtilityDB.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  imgInvertiSelezioneAsyncClick(Sender,nil);
end;

procedure TWA099FUtilityDB.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WA099DM:=TA099FUtilityDBMW.Create(Self);
  LastIndexChecked:=-1;

  (*
  JQuery.OnReady.Text:='$("#tabs").tabs({cookie: { expires: 10 } });'  + CRLF +
                       '$("#tabs").tabs("option","cookie",{ expires: 10 });';
  *)
  //attivazione gestione Tab JQuery
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);

  rgpSelezioneTabelle.Items[0]:='Tabelle di ' + Parametri.Username;
  rgpSelezioneTabelle.Items[3]:='Tabelle esterne al tablespace ' + Parametri.TSLavoro;
  rgpSelezioneTabelle.Items[4]:='Tabelle con indici esterni al tablespace ' + Parametri.TSIndici;
  rgpSelezioneTabelleClick(rgpSelezioneTabelle);
  CaricaOggettiDB;

  grdQuerySupporto.medpDataSet:=WA099DM.selTablespace;
  grdQuerySupporto.medpPaginazione:=False;
end;

procedure TWA099FUtilityDB.CreaQuerySupporto;
begin
  grdQuerySupporto.medpBrowse:=True;
  grdQuerySupporto.medpCreaCDS;
  if rgpQuerySupporto.ItemIndex = 0 then
  begin
    grdQuerySupporto.medpEliminaColonne;
    grdQuerySupporto.medpAggiungiColonna('TABLESPACE','Tablespace','',nil);
    grdQuerySupporto.medpAggiungiColonna('ALLOCATO','Allocato (bytes)','',nil);
    grdQuerySupporto.medpAggiungiColonna('USATO','Usato (bytes)','',nil);
    grdQuerySupporto.medpAggiungiColonna('DISPONIBILE','Disponibile (bytes)','',nil);
    grdQuerySupporto.medpAggiungiColonna('USATO%','% Usato','',nil);
    grdQuerySupporto.medpAggiungiColonna('DISPONIBILE%','% Disponibile','',nil);
  end;
  grdQuerySupporto.medpInizializzaCompGriglia;
  //grdGestioneModuli.medpPreparaComponenteGenerico('R',2,0,DBG_IMG,'','','null','','S');
  grdQuerySupporto.medpCaricaCDS;
end;

procedure TWA099FUtilityDB.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  imgDeselezionaTuttoAsyncClick(Sender,nil);
end;

procedure TWA099FUtilityDB.grdQuerySupportoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  if not grdQuerySupporto.medpRenderCell(ACell,ARow,AColumn,True,True,False) then
    exit;
end;

procedure TWA099FUtilityDB.imgDeselezionaTuttoAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelle.Items.Count - 1 do
    cgpTabelle.IsChecked[i]:=False;
  cgpTabelle.AsyncUpdate;
end;

procedure TWA099FUtilityDB.imgInvertiSelezioneAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelle.Items.Count - 1 do
    cgpTabelle.IsChecked[i]:=not cgpTabelle.IsChecked[i];
  cgpTabelle.AsyncUpdate;
end;

procedure TWA099FUtilityDB.imgSelezionaTuttoAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
 i:Integer;
begin
  inherited;
  for i:=0 to cgpTabelle.Items.Count - 1 do
    cgpTabelle.IsChecked[i]:=True;
  cgpTabelle.AsyncUpdate;
end;

procedure TWA099FUtilityDB.btnClick(Sender: TObject);
var S:String;
begin
  SenderButton:=TmeIWButton(Sender);
  if SenderButton = btnGatherTableStats then
    S:='GATHER_TABLE_STATS'
  else
    S:=TmeIWButton(Sender).Caption;
  MsgBox.WebMessageDlg(Format(A000MSG_A099_DLG_FMT_ESEGUI,[S]),mtConfirmation,[mbYes,mbNo],ResultStats,'');

end;

procedure TWA099FUtilityDB.ResultStats(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    if (SenderButton = btnAnalyzeTable) or
       (SenderButton = btnAnalyzeColumns) or
       (SenderButton = btnAnalyzeIndexes) then
       MsgBox.WebMessageDlg(A000MSG_A099_DLG_SCONSIGLIATA,mtConfirmation,[mbYes,mbNo],ResultStats2,'')
    else
       ResultStats2(Sender,mrYes,'');
  end;
end;

procedure TWA099FUtilityDB.ResultStats2(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  i:Integer;
begin
  if R = mrYes then
  begin
    memResult.Lines.Clear;

    for i:=0 to cgpTabelle.Items.Count - 1 do
      if cgpTabelle.IsChecked[i] then
      begin
        if SenderButton = btnShrinkTable then
        begin
          memResult.Lines.AddStrings(WA099DM.ShrinkTable(cgpTabelle.Items[i]));
        end
        else if SenderButton = btnDeleteStatistics then
        begin
          memResult.Lines.AddStrings(WA099DM.DeleteStatistics(cgpTabelle.Items[i]));
        end
        else if SenderButton = btnTableNoParallel then
        begin
          memResult.Lines.AddStrings(WA099DM.TableNoParallel(cgpTabelle.Items[i]));
        end
        else if SenderButton = btnAnalyzeTable then
        begin
          memResult.Lines.AddStrings(WA099DM.AnalyzeTable(cgpTabelle.Items[i]));
        end
        else if SenderButton = btnAnalyzeColumns then
        begin
          memResult.Lines.AddStrings(WA099DM.AnalyzeColumns(cgpTabelle.Items[i]));
        end
        else if SenderButton = btnAnalyzeIndexes then
        begin
          memResult.Lines.AddStrings(WA099DM.AnalyzeIndexes(cgpTabelle.Items[i]));
        end
        else if SenderButton = btnMoveTablespace then
        begin
          memResult.Lines.AddStrings(WA099DM.MoveTablespace(cgpTabelle.Items[i]));
        end
        else if (SenderButton = btnRebuildIndexes) then
        begin
          memResult.Lines.AddStrings(WA099DM.RebuildIndexes(cgpTabelle.Items[i]));
        end
        else if(SenderButton = btnIndexNoParallel) then
        begin
          memResult.Lines.AddStrings(WA099DM.IndexNoParallel(cgpTabelle.Items[i]));
        end
        else if SenderButton = btnGatherTableStats then
        begin
          memResult.Lines.AddStrings(WA099DM.GatherTableStats(cgpTabelle.Items[i]));
        end;
        //memoResult.Repaint;
      end;
    //Screen.Cursor:=crDefault;
    if (SenderButton = btnMovetablespace) (*and (ProgressBar1.Position > 0) *) then
    begin
      MsgBox.WebMessageDlg(A000MSG_A099_MSG_INDICI,mtInformation,[mbOk],nil,'');
      Abort;
    end;
    //ProgressBar1.Position:=0;
    //StatusBar.SimpleText:='';
    end;
end;

procedure TWA099FUtilityDB.btnClick2(Sender: TObject);
var S:String;
begin
  SenderButton:=TmeIWButton(Sender);
  if SenderButton = btnGatherSchemaStats then
    S:='GATHER_SCHEMA_STATS'
  else
    S:='DELETE_SCHEMA_STATS';
  MsgBox.WebMessageDlg(Format(A000MSG_A099_DLG_FMT_DB,[S,Parametri.Username]) ,mtConfirmation,[mbYes,mbNo],ResultSchema,'');
  //Screen.Cursor:=crHourGlass;
end;

procedure TWA099FUtilityDB.btnCopiaTestoQueryClick(Sender: TObject);
begin
  inherited;
  Clipboard.Clear;
  case rgpQuerySupporto.ItemIndex of
    0:Clipboard.AsText:=WA099DM.selTablespace.SQL.Text;
    1:Clipboard.AsText:=WA099DM.selSortSegment.SQL.Text;
    2:Clipboard.AsText:=WA099DM.selDataFiles.SQL.Text;
    3:Clipboard.AsText:=WA099DM.selLogMsg.SQL.Text;
  end;
end;

procedure TWA099FUtilityDB.btnEseguiClick(Sender: TObject);
begin
  inherited;
  Screen.Cursor:=crHourGlass;
  try
    case rgpQuerySupporto.ItemIndex of
      0:begin
          WA099DM.selTablespace.Close;
          WA099DM.selTablespace.Open;
          grdQuerySupporto.medpAttivaGrid(WA099DM.selTablespace,false,false);
        end;
      1:begin
          WA099DM.selSortSegment.Close;
          WA099DM.selSortSegment.Open;
          grdQuerySupporto.medpAttivaGrid(WA099DM.selSortSegment,false,false);
        end;
      2:begin
          WA099DM.selDataFiles.Close;
          WA099DM.selDataFiles.Open;
          grdQuerySupporto.medpAttivaGrid(WA099DM.selDataFiles,false,false);
        end;
      3:begin
          WA099DM.selLogMsg.Close;
          WA099DM.selLogMsg.SetVariable('AZIENDA',Parametri.Azienda);
          WA099DM.selLogMsg.Open;
          grdQuerySupporto.medpAttivaGrid(WA099DM.selLogMsg,false,false);
        end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TWA099FUtilityDB.btnRicompilaInvalidiClick(Sender: TObject);
var i,j:Integer;
    s:String;
    Nodo:TIWTreeViewItem;
begin
  memResult.Lines.Clear;
  //Screen.Cursor:=crHourGlass;
  for i:=0 to trvOggettiDB.Items.Count - 1 do
  begin
    s:=trvOggettiDB.Items[i].Caption;
    if s = 'SYNONYM' then
      Continue;
    Nodo:=trvOggettiDB.Items[i];
    for j:=0 to Nodo.SubItems.Count - 1 do
      if (Sender = btnRicompilaTutto) or (Pos('(INVALID)',TIWTreeViewItem(Nodo.SubItems[j]).Caption) > 0) then
        memResult.Lines.AddStrings(WA099DM.RicompilaOggetto(s,Copy(TIWTreeViewItem(Nodo.SubItems[j]).Caption,1,Pos('(',TIWTreeViewItem(Nodo.SubItems[j]).Caption) - 1),chkDebug.Checked,chkcOdeTypeInterpreted.Checked,chkCodeTypeNative.Checked,chkReuseSettings.Checked));
  end;
  CaricaOggettiDB;
end;

procedure TWA099FUtilityDB.btnRicompilaSelezionatoClick(Sender: TObject);
var
    i:Integer;
begin
  memResult.Lines.Clear;
  //Screen.Cursor:=crHourGlass;
  if NodoSelezionato.HasChild then
  begin
    for i:=0 to NodoSelezionato.SubItems.Count - 1 do
      memResult.Lines.AddStrings(WA099DM.RicompilaOggetto(NodoSelezionato.Caption,Copy(TIWTreeViewItem(NodoSelezionato.SubItems[i]).Caption,1,Pos('(',TIWTreeViewItem(NodoSelezionato.SubItems[i]).Caption) - 1),chkDebug.Checked,chkcOdeTypeInterpreted.Checked,chkCodeTypeNative.Checked,chkReuseSettings.Checked));
  end
  else
    memResult.Lines.AddStrings(WA099DM.RicompilaOggetto(NodoSelezionato.ParentItem.Caption,Copy(NodoSelezionato.Caption,1,Pos('(',NodoSelezionato.Caption) - 1),chkDebug.Checked,chkcOdeTypeInterpreted.Checked,chkCodeTypeNative.Checked,chkReuseSettings.Checked));

  //Screen.Cursor:=crDefault;
  //StatusBar.SimpleText:='';
  CaricaOggettiDB;
end;

procedure TWA099FUtilityDB.btnRicompilaTuttoClick(Sender: TObject);
var i,j:Integer;
    s:String;
    Nodo:TIWTreeViewItem;
begin
  memResult.Lines.Clear;
  for i:=0 to trvOggettiDB.Items.Count - 1 do
  begin
    s:=trvOggettiDB.Items[i].Caption;
    if s = 'SYNONYM' then
      Continue;
    Nodo:=trvOggettiDB.Items[i];
    for j:=0 to Nodo.SubItems.Count - 1 do
      if (Sender = btnRicompilaTutto) or (Pos('(INVALID)',TIWTreeViewItem(Nodo.SubItems[j]).Caption) > 0) then
        memResult.Lines.AddStrings(WA099DM.RicompilaOggetto(s,Copy(TIWTreeViewItem(Nodo.SubItems[j]).Caption,1,Pos('(',TIWTreeViewItem(Nodo.SubItems[j]).Caption) - 1),chkDebug.Checked,chkcOdeTypeInterpreted.Checked,chkCodeTypeNative.Checked,chkReuseSettings.Checked));
  end;
  CaricaOggettiDB;
end;

procedure TWA099FUtilityDB.btnV430StoricoClick(Sender: TObject);
begin
  WA099DM.CostruisciV430;
end;

procedure TWA099FUtilityDB.ResultSchema(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    memResult.Lines.Clear;
    if SenderButton = btnGatherSchemaStats then
    begin
      memResult.Lines.AddStrings(WA099DM.GatherSchemaStats);
    end
    else //btnDeleteSchemaStats
    begin
      memResult.Lines.AddStrings(WA099DM.DeleteSchemaStats);
    end;
  end;
end;

procedure TWA099FUtilityDB.CaricaOggettiDB;
  procedure AggiungiNodo(Tipo,Oggetto:String);
  var i:Integer;
        Trovato:Boolean;
        Nodo:TIWTreeViewItem;
  begin
   i:=0;
    Trovato:=False;
    while i < trvOggettiDB.Items.Count do
    begin
      if UpperCase(Tipo) = UpperCase(trvOggettiDB.Items[i].Caption) then
      begin
        Nodo:=trvOggettiDB.Items.Add(trvOggettiDB.Items[i]);
        Nodo.Caption:=Oggetto;

        Nodo.OnClick:=nodoClick;
        //Nodo.ImageIndex:=2;
        if Pos('(INVALID)',Oggetto) > 0 then
          Nodo.Css:='font_grassetto'; //Nodo.ImageIndex:=1;
        Trovato:=True;
        Break;
      end;
      inc(i);
    end;
    if not Trovato then
    begin
      Nodo:=trvOggettiDB.Items.Add(nil);
      Nodo.Caption:=Tipo;
      Nodo.OnClick:=nodoClick;
      Nodo:=trvOggettiDB.Items.Add(Nodo);
      Nodo.Caption:=Oggetto;
      Nodo.OnClick:=nodoClick;
      //Nodo.ImageIndex:=2;
      if Pos('(INVALID)',Oggetto) > 0 then
        Nodo.Css:='font_grassetto'; //Nodo.ImageIndex:=1;
    end;
  end;
begin
  trvOggettiDB.Items.Clear;
  with WA099DM.selUserObjects do
  begin
    Open;
    while not Eof do
    begin
      AggiungiNodo(FieldByName('OBJECT_TYPE').AsString,FieldByName('OBJECT_NAME').AsString + ' ('+ FieldByName('STATUS').AsString + ')');
      Next;
    end;
    Close;
  end;
end;

procedure TWA099FUtilityDB.cgpTabelleAsyncItemClick(Sender: TObject;
  EventParams: TStringList; Index: Integer);
begin
  inherited;
  if cgpTabelle.IsChecked[Index] then
  begin
    if LastIndexChecked > -1 then
      cgpTabelle.IsChecked[LastIndexChecked]:=False;
    LastIndexChecked:=Index;
  end;
end;

procedure TWA099FUtilityDB.rgpSelezioneTabelleClick(Sender: TObject);
begin
  WA099DM.LoadLstTabelle(rgpSelezioneTabelle.ItemIndex, cgpTabelle.Items);
end;

procedure TWA099FUtilityDB.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  imgSelezionaTuttoAsyncClick(Sender,nil);
end;

procedure TWA099FUtilityDB.nodoClick(Sender: TObject);
begin
   if NodoSelezionato <> nil then
     NodoSelezionato.Css:=CssOrigNodoSelezionato;
   lblSelezionato.Caption:=TIWTreeViewItem(Sender).Caption;
   CssOrigNodoSelezionato:=TIWTreeViewItem(Sender).Css;
   NodoSelezionato:=TIWTreeViewItem(Sender);
   TIWTreeViewItem(Sender).Css:=TIWTreeViewItem(Sender).Css + ' bg_lime';
   btnRicompilaSelezionato.Enabled:=True;
end;

procedure TWA099FUtilityDB.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(WA099DM);
  trvOggettiDB.Items.Clear;
  inherited;
end;

end.
