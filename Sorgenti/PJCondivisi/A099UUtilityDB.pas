unit A099UUtilityDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  StdCtrls, Buttons, ExtCtrls, CheckLst, Menus, A000UCostanti, A000USessione,
  A000UInterfaccia, A099UUtilityDBMW, ComCtrls, Variants, Grids, DBGrids, DB,
  Oracle, Clipbrd, A000UMessaggi, C600USelAnagrafe, C180FunzioniGenerali, Vcl.Mask,
  C004UParamForm, OracleData;

type
  TA099FUtilityDB = class(TForm)
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Annullatutto1: TMenuItem;
    PageControl1: TPageControl;
    tabTabelle: TTabSheet;
    Panel1: TPanel;
    btnDeleteStatistics: TBitBtn;
    btnAnalyzeTable: TBitBtn;
    btnAnalyzeColumns: TBitBtn;
    btnAnalyzeIndexes: TBitBtn;
    btnRebuildIndexes: TBitBtn;
    btnTableNoParallel: TBitBtn;
    btnIndexNoParallel: TBitBtn;
    Panel2: TPanel;
    lstTabelle: TCheckListBox;
    rgpSelezioneTabelle: TRadioGroup;
    Splitter1: TSplitter;
    tabOggetti: TTabSheet;
    Panel3: TPanel;
    memoResult: TMemo;
    Panel4: TPanel;
    BitBtn7: TBitBtn;
    Panel5: TPanel;
    ProgressBar1: TProgressBar;
    StatusBar: TStatusBar;
    treeOggettiDB: TTreeView;
    Panel6: TPanel;
    btnRicompilaTutto: TBitBtn;
    mnuCompilaOggetti: TPopupMenu;
    Ricompila1: TMenuItem;
    btnRicompilaInvalidi: TBitBtn;
    N1: TMenuItem;
    Refresh1: TMenuItem;
    btnDeleteSchemaStats: TBitBtn;
    btnGatherSchemaStats: TBitBtn;
    btnGatherTableStats: TBitBtn;
    btnMoveTablespace: TBitBtn;
    tabQuerySupporto: TTabSheet;
    Panel7: TPanel;
    btnEsegui: TBitBtn;
    Panel8: TPanel;
    rgpQuerySupporto: TRadioGroup;
    dgrdQuerySupporto: TDBGrid;
    dsrQuerySupporto: TDataSource;
    GroupBox1: TGroupBox;
    chkCompileDebug: TCheckBox;
    chkCompileNative: TCheckBox;
    chkCompileInterpreted: TCheckBox;
    chkCompileReuse: TCheckBox;
    btnCopiaTestoQuery: TBitBtn;
    btnShrink: TBitBtn;
    btnV430Storico: TBitBtn;
    TabExport: TTabSheet;
    pnlExport: TPanel;
    edtPath: TEdit;
    btnPath: TButton;
    lblPath: TLabel;
    edtFiltro: TEdit;
    btnFiltro: TBitBtn;
    lblFiltro: TLabel;
    btnEsporta: TBitBtn;
    ppMnu: TPopupMenu;
    Selezionatutto2: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    GRPOpzioniOggetti: TGroupBox;
    chkExpCreateTable: TCheckBox;
    chkExpDati: TCheckBox;
    chkExpConstraint: TCheckBox;
    chkExpPLSQL: TCheckBox;
    btnCountRecords: TBitBtn;
    Label1: TLabel;
    edtDal: TMaskEdit;
    edtAl: TMaskEdit;
    pnlLeftTabelle: TPanel;
    chkLstBoxExpTabelle: TCheckListBox;
    lblListaTabelle: TLabel;
    procedure FormShow(Sender: TObject);
    procedure rgpSelezioneTabelleClick(Sender: TObject);
    procedure Annullatutto1Click(Sender: TObject);
    procedure btnDeleteStatisticsClick(Sender: TObject);
    procedure btnRicompilaTuttoClick(Sender: TObject);
    procedure Ricompila1Click(Sender: TObject);
    procedure treeOggettiDBChange(Sender: TObject; Node: TTreeNode);
    procedure Refresh1Click(Sender: TObject);
    procedure treeOggettiDBAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure treeOggettiDBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnDeleteSchemaStatsClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure chkCompileParametersClick(Sender: TObject);
    procedure btnCopiaTestoQueryClick(Sender: TObject);
    procedure btnV430StoricoClick(Sender: TObject);
    procedure btnEsportaClick(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Selezionatutto2Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure btnPathClick(Sender: TObject);
    procedure edtPathExit(Sender: TObject);
    procedure btnCountRecordsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtDalExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CaricaListaTabelleExport;
    procedure SetPercorsi;
    function ChkLst1ElementChecked:boolean;
    procedure CaricaOggettiDB;
    procedure RicompilaOggetto(Tipo,Oggetto:String);
    function DisegnaNodo(Albero:TTreeView; RectRif: TRect; xFontColor:TColor; xFontStyle:TFontStyles; sTesto:string): TRect;
  public
    { Public declarations }
    Chiamante:String;
    A099FUtilityDBMW: TA099FUtilityDBMW;
  end;

var
  A099FUtilityDB: TA099FUtilityDB;

procedure OpenA099UtilityDB;

implementation

uses A099UUtilityDBDtM1;

{$R *.DFM}

procedure OpenA099UtilityDB;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA099UtilityDB') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A099FUtilityDB:=TA099FUtilityDB.Create(nil);
  with A099FUtilityDB do
    try
      A099FUtilityDBDtM1:=TA099FUtilityDBDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A099FUtilityDBDtM1.Free;
      Free;
    end;
end;

procedure TA099FUtilityDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Chiamante <> 'Q000' then
  begin
    PutParametriFunzione;
    FreeAndNil(C004FParamForm);
  end;
end;

procedure TA099FUtilityDB.FormCreate(Sender: TObject);
begin
  Chiamante:='A099';
end;

procedure TA099FUtilityDB.FormDestroy(Sender: TObject);
begin
  if Chiamante <> 'Q000' then
    C600frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA099FUtilityDB.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro(UpperCase(edtPath.Name),edtPath.Text);
  if chkExpCreateTable.Checked then
    C004FParamForm.PutParametro(UpperCase(chkExpCreateTable.Name),'S')
  else
    C004FParamForm.PutParametro(UpperCase(chkExpCreateTable.Name),'N');
  if chkExpDati.Checked then
    C004FParamForm.PutParametro(UpperCase(chkExpDati.Name),'S')
  else
    C004FParamForm.PutParametro(UpperCase(chkExpDati.Name),'N');
  if chkExpConstraint.Checked then
    C004FParamForm.PutParametro(UpperCase(chkExpConstraint.Name),'S')
  else
    C004FParamForm.PutParametro(UpperCase(chkExpConstraint.Name),'N');
  if chkExpPLSQL.Checked then
    C004FParamForm.PutParametro(UpperCase(chkExpPLSQL.Name),'S')
  else
    C004FParamForm.PutParametro(UpperCase(chkExpPLSQL.Name),'N');
  C004FParamForm.PutParametro(UpperCase(edtFiltro.Name),edtFiltro.Text);
  try SessioneOracle.Commit; except end;
end;

procedure TA099FUtilityDB.GetParametriFunzione;
begin
  edtPath.Text:=C004FParamForm.GetParametro(UpperCase(edtPath.Name),'');
  chkExpCreateTable.Checked:=C004FParamForm.GetParametro(UpperCase(chkExpCreateTable.Name),'S') = 'S';
  chkExpDati.Checked:=C004FParamForm.GetParametro(UpperCase(chkExpDati.Name),'S') = 'S';
  chkExpConstraint.Checked:=C004FParamForm.GetParametro(UpperCase(chkExpConstraint.Name),'S') = 'S';
  chkExpPLSQL.Checked:=C004FParamForm.GetParametro(UpperCase(chkExpPLSQL.Name),'S') = 'S';
  edtFiltro.Text:=C004FParamForm.GetParametro(UpperCase(edtFiltro.Name),'');
end;


procedure TA099FUtilityDB.SetPercorsi;
begin
  A099FUtilityDBMW.ExportDB.Pathfile:=edtPath.Text;
  chkExpCreateTable.Caption:=Format('Create table "%s"',[ExtractFileName(A099FUtilityDBMW.ExportDB.PathFileCreate)]);
  chkExpDati.Caption:=Format('Dati "%s"',[ExtractFileName(A099FUtilityDBMW.ExportDB.ExpDati.PathFile)]);
  chkExpConstraint.Caption:=Format('Constraints "%s"',[ExtractFileName(A099FUtilityDBMW.ExportDB.PathFileConstr)]);
  chkExpPLSQL.Caption:=Format('PL\SQL "%s"',[ExtractFileName(A099FUtilityDBMW.ExportDB.PathFilePLSql)]);
end;

function TA099FUtilityDB.ChkLst1ElementChecked:boolean;
var
  i:integer;
begin
  i:=0;
  while (i < chkLstBoxExpTabelle.Count - 1) and not chkLstBoxExpTabelle.Checked[i] do
    inc(i);
  Result:=chkLstBoxExpTabelle.Checked[i];
end;

procedure TA099FUtilityDB.CaricaListaTabelleExport;
begin
  chkLstBoxExpTabelle.Items.Clear;
  if not A099FUtilityDBMW.selExpAllTab.Active then
    exit;

  A099FUtilityDBMW.selExpAllTab.First;
  while Not A099FUtilityDBMW.selExpAllTab.Eof do
  begin
    chkLstBoxExpTabelle.Items.Add(A099FUtilityDBMW.selExpAllTab.FieldByName('TABLE_NAME').AsString);
    A099FUtilityDBMW.selExpAllTab.Next;
  end;
end;

procedure TA099FUtilityDB.FormShow(Sender: TObject);
begin
  if Chiamante <> 'Q000' then
  begin
    C600frmSelAnagrafe:=TC600frmSelAnagrafe.Create(Self);
    C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
    C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
    C600frmSelAnagrafe.C600Progressivo:=0;
  end;
  PageControl1.TabIndex:=0;
  rgpSelezioneTabelle.Items[0]:='Tabelle di ' + Parametri.Username;
  rgpSelezioneTabelle.Items[3]:='Tabelle esterne al tablespace ' + Parametri.TSLavoro;
  rgpSelezioneTabelle.Items[4]:='Tabelle con indici esterni al tablespace ' + Parametri.TSIndici;
  if Chiamante <> 'Q000' then
  begin
    CreaC004(SessioneOracle,'A099',Parametri.ProgOper);
    GetParametriFunzione;
  end;
  rgpSelezioneTabelleClick(rgpSelezioneTabelle);
  CaricaOggettiDB;
  CaricaListaTabelleExport;
  if DirectoryExists(edtPath.Text) then
    SetPercorsi;
end;

procedure TA099FUtilityDB.Invertiselezione1Click(Sender: TObject);
begin
  R180InvertiSelezioneCheckList(chkLstBoxExpTabelle);
end;

procedure TA099FUtilityDB.rgpSelezioneTabelleClick(Sender: TObject);
begin
  lstTabelle.Items.Clear;
  Screen.Cursor:=crHourGlass;
  with A099FUtilityDBMW.selTabs do
  begin
    Close;
    SQL.Clear;
    case rgpSelezioneTabelle.ItemIndex of
      0:SQL.Add('SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME');
      1:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM IND ORDER BY TABLE_NAME');
      2:SQL.Add('SELECT TABLE_NAME FROM TABS MINUS SELECT TABLE_NAME FROM USER_CONSTRAINTS WHERE CONSTRAINT_TYPE = ''P'' ORDER BY TABLE_NAME');
      3:SQL.Add('SELECT TABLE_NAME FROM TABS WHERE TABLESPACE_NAME <> ''' + Parametri.TSLavoro + ''' ORDER BY TABLE_NAME');
      4:SQL.Add('SELECT DISTINCT TABLE_NAME FROM IND WHERE TABLESPACE_NAME <> ''' + Parametri.TSIndici + ''' ORDER BY TABLE_NAME');
    end;
    Open;
    while not Eof do
    begin
      lstTabelle.Items.Add(FieldByName('TABLE_NAME').AsString);
      Next;
    end;
  end;
  Screen.Cursor:=crDefault;
end;

procedure TA099FUtilityDB.Annullatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to lstTabelle.Items.Count - 1 do
    lstTabelle.Checked[i]:=Sender = Selezionatutto1
end;

procedure TA099FUtilityDB.btnCopiaTestoQueryClick(Sender: TObject);
begin
  Clipboard.Clear;
  case rgpQuerySupporto.ItemIndex of
    0:Clipboard.AsText:=A099FUtilityDBMW.selTablespace.SQL.Text;
    1:Clipboard.AsText:=A099FUtilityDBMW.selSortSegment.SQL.Text;
    2:Clipboard.AsText:=A099FUtilityDBMW.selDataFiles.SQL.Text;
    3:Clipboard.AsText:=A099FUtilityDBMW.selLogMsg.SQL.Text;
  end;
end;

procedure TA099FUtilityDB.btnCountRecordsClick(Sender: TObject);
{Visualizzazione dimensione tabella (recordcount): bozza da definire}
var
  i,NumRecord:integer;
  CheckElem:boolean;
  lstCountRecords:TStringList;
begin
  Screen.Cursor:=crHourGlass;
  lstCountRecords:=TStringList.Create;
  CheckElem:=ChkLst1ElementChecked;
  try
    for i:=0 to chkLstBoxExpTabelle.Count - 1 do
      if chkLstBoxExpTabelle.Checked[i] or Not CheckElem then
      begin
        NumRecord:=A099FUtilityDBMW.ExportDB.ExpDati.RetCountTabDati(chkLstBoxExpTabelle.Items[i]);
        lstCountRecords.Add(Format('%s=%d',[chkLstBoxExpTabelle.Items[i],NumRecord]));
        chkLstBoxExpTabelle.Items.ValueFromIndex[i]:=NumRecord.ToString;
        chkLstBoxExpTabelle.Items[i]:=lstCountRecords[lstCountRecords.Count - 1];
      end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA099FUtilityDB.btnDeleteSchemaStatsClick(Sender: TObject);
var
  S:String;
begin
  if Sender = btnGatherSchemaStats then
    S:=Format(A000MSG_A099_DLG_FMT_DB,['GATHER_SCHEMA_STATS',Parametri.Username])
  else
    S:= Format(A000MSG_A099_DLG_FMT_DB,['DELETE_SCHEMA_STATS',Parametri.Username]);
  if MessageDlg(S,mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  Screen.Cursor:=crHourGlass;
  try
    if Sender = btnGatherSchemaStats then
    begin
       memoResult.Lines.AddStrings(A099FUtilityDBMW.GatherSchemaStats);
    end
    else
    begin
       memoResult.Lines.AddStrings(A099FUtilityDBMW.DeleteSchemaStats);
    end
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA099FUtilityDB.btnDeleteStatisticsClick(Sender: TObject);
var S:String;
    i,N:Integer;
begin
  if Sender = btnGatherTableStats then
    S:=Format(A000MSG_A099_DLG_FMT_ESEGUI,['GATHER_TABLE_STATS'])
  else
    S:=Format(A000MSG_A099_DLG_FMT_ESEGUI,[TBitBtn(Sender).Caption]);
  if MessageDlg(S,mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  if (Sender = btnAnalyzeTable) or (Sender = btnAnalyzeColumns) or (Sender = btnAnalyzeIndexes) then
    if MessageDlg(A000MSG_A099_DLG_SCONSIGLIATA ,mtConfirmation,[mbYes,mbNo],0) <> mrYes then exit;
  memoResult.Lines.Clear;
  Screen.Cursor:=crHourGlass;
  N:=0;
  for i:=0 to lstTabelle.Items.Count - 1 do
    if lstTabelle.Checked[i] then inc(N);
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=N;
  for i:=0 to lstTabelle.Items.Count - 1 do
    if lstTabelle.Checked[i] then
    begin
      ProgressBar1.StepBy(1);
      StatusBar.SimpleText:=lstTabelle.Items[i];
      StatusBar.Repaint;
      if Sender = btnShrink then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.ShrinkTable(lstTabelle.Items[i]));
      end
      else if Sender = btnDeleteStatistics then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.DeleteStatistics(lstTabelle.Items[i]));
      end
      else if Sender = btnTableNoParallel then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.TableNoParallel(lstTabelle.Items[i]));
      end
      else if Sender = btnAnalyzeTable then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.AnalyzeTable(lstTabelle.Items[i]));
      end
      else if Sender = btnAnalyzeColumns then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.AnalyzeColumns(lstTabelle.Items[i]));
      end
      else if Sender = btnAnalyzeIndexes then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.AnalyzeIndexes(lstTabelle.Items[i]));
      end
      else if Sender = btnMoveTablespace then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.MoveTablespace(lstTabelle.Items[i]));
      end
      else if (Sender = btnRebuildIndexes) then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.RebuildIndexes(lstTabelle.Items[i]));
      end
      else if (Sender = btnIndexNoParallel) then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.IndexNoParallel(lstTabelle.Items[i]));
      end
      else if Sender = btnGatherTableStats then
      begin
        memoResult.Lines.AddStrings(A099FUtilityDBMW.GatherTableStats(lstTabelle.Items[i]));
      end;
      memoResult.Repaint;
    end;
  Screen.Cursor:=crDefault;
  if (Sender = btnMovetablespace) and (ProgressBar1.Position > 0) then
    ShowMessage(A000MSG_A099_MSG_INDICI);
  ProgressBar1.Position:=0;
  StatusBar.SimpleText:='';
end;

procedure TA099FUtilityDB.btnEseguiClick(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    case rgpQuerySupporto.ItemIndex of
      0:begin
          A099FUtilityDBMW.selTablespace.Close;
          A099FUtilityDBMW.selTablespace.Open;
          dsrQuerySupporto.DataSet:=A099FUtilityDBMW.selTablespace;
        end;
      1:begin
          A099FUtilityDBMW.selSortSegment.Close;
          A099FUtilityDBMW.selSortSegment.Open;
          dsrQuerySupporto.DataSet:=A099FUtilityDBMW.selSortSegment;
        end;
      2:begin
          A099FUtilityDBMW.selDataFiles.Close;
          A099FUtilityDBMW.selDataFiles.Open;
          dsrQuerySupporto.DataSet:=A099FUtilityDBMW.selDataFiles;
        end;
      3:begin
          A099FUtilityDBMW.selLogMsg.Close;
          A099FUtilityDBMW.selLogMsg.SetVariable('AZIENDA',Parametri.Azienda);
          A099FUtilityDBMW.selLogMsg.Open;
          dsrQuerySupporto.DataSet:=A099FUtilityDBMW.selLogMsg;
        end;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA099FUtilityDB.btnEsportaClick(Sender: TObject);
var
  i, NumeroTabelle, jTab:integer;
  CheckElem:boolean;
begin
  Screen.Cursor:=crHourGlass;
  try
    SetPercorsi;
    //A099FUtilityDBMW.ExportDB.Pathfile:=edtPath.Text;
    if (FileExists(A099FUtilityDBMW.ExportDB.PathFileCreate) or FileExists(A099FUtilityDBMW.ExportDB.ExpDati.PathFile) or
       FileExists(A099FUtilityDBMW.ExportDB.PathFileConstr) or  FileExists(A099FUtilityDBMW.ExportDB.PathFilePLSql)) then
    begin
      if R180MessageBox('Esistono già alcuni file di esportazione con lo stesso nome, procedendo verranno sovrascritti.' + CRLF +
                       'Continuare?',DOMANDA) = mrYes then
      begin
        if chkExpCreateTable.Checked then
          DeleteFile(A099FUtilityDBMW.ExportDB.PathFileCreate);
        if chkExpDati.Checked then
          DeleteFile(A099FUtilityDBMW.ExportDB.ExpDati.PathFile);
        if chkExpConstraint.Checked then
          DeleteFile(A099FUtilityDBMW.ExportDB.PathFileConstr);
        if chkExpPLSQL.Checked then
          DeleteFile(A099FUtilityDBMW.ExportDB.PathFilePLSql);
      end
      else
        Exit;
    end;
    DeleteFile(A099FUtilityDBMW.ExportDB.PathFileLOG);
    A099FUtilityDBMW.ExportDB.RegistraLOG('<Inizio esportazione utente ' + Parametri.Username.ToUpper + '>');
    A099FUtilityDBMW.ExportDB.FiltroTabelle:=R180GetCheckList(100,chkLstBoxExpTabelle,',');
    //Sostituire in ogni statement: "nome_schema". con niente
    if chkExpCreateTable.Checked then
    begin
      A099FUtilityDBMW.ExportDB.RegistraLOG('<Inizio esportazione tabelle>');
      //_CREATE Create table
      StatusBar.SimpleText:='Esportazione tabelle...';
      A099FUtilityDBMW.ExportDB.ExportTables;
      A099FUtilityDBMW.ExportDB.RegistraLOG('<Fine esportazione tabelle>');
    end;
    if chkExpConstraint.Checked then
    begin
      //_KEYS Constraint
      A099FUtilityDBMW.ExportDB.RegistraLOG('<Inizio esportazione constraint>');
      StatusBar.SimpleText:='Esportazione indici...';
      A099FUtilityDBMW.ExportDB.ExportIndexes;
      StatusBar.SimpleText:='Esportazione chiavi...';
      A099FUtilityDBMW.ExportDB.ExportKeys;
      StatusBar.SimpleText:='Esportazione chiavi esterne...';
      A099FUtilityDBMW.ExportDB.ExportforeignKeys;
      A099FUtilityDBMW.ExportDB.RegistraLOG('<Fine esportazione constraint>');
    end;
    if chkExpPLSQL.Checked then
    begin
      //_PLSQL PLSql + sequences + Views
      A099FUtilityDBMW.ExportDB.RegistraLOG('<Inizio esportazione script>');
      StatusBar.SimpleText:='Esportazione packages...';
      A099FUtilityDBMW.ExportDB.ExportPackages;
      StatusBar.SimpleText:='Esportazione sequence...';
      A099FUtilityDBMW.ExportDB.ExportObjects('SEQUENCE');
      StatusBar.SimpleText:='Esportazione trigger...';
      A099FUtilityDBMW.ExportDB.ExportObjects('TRIGGER');
      StatusBar.SimpleText:='Esportazione function...';
      A099FUtilityDBMW.ExportDB.ExportObjects('FUNCTION');
      StatusBar.SimpleText:='Esportazione procedure...';
      A099FUtilityDBMW.ExportDB.ExportObjects('PROCEDURE');
      StatusBar.SimpleText:='Esportazione viste...';
      A099FUtilityDBMW.ExportDB.ExportObjects('VIEW');
      A099FUtilityDBMW.ExportDB.RegistraLOG('<Fine esportazione script>');
    end;
    if chkExpDati.Checked then
    begin
      //_DATI Insert
      A099FUtilityDBMW.ExportDB.RegistraLOG('Inizio esportazione dati tabelle');
      A099FUtilityDBMW.ExportDB.ExpDati.SQLDefine:=False;
      NumeroTabelle:=0;
      CheckElem:=ChkLst1ElementChecked;
      for i:=0 to chkLstBoxExpTabelle.Count - 1 do
      begin
        if chkLstBoxExpTabelle.Checked[i] or Not CheckElem then
          inc(NumeroTabelle);
      end;
      A099FUtilityDBMW.selMEDPV_EXPTAB_DATI.Open;
      A099FUtilityDBMW.ExportDB.ExpDati.FiltroTabella:=edtFiltro.Text;
      jTab:=1;
      for i:=0 to chkLstBoxExpTabelle.Count - 1 do
      begin
        if (chkLstBoxExpTabelle.Checked[i] or Not CheckElem) and
           (A099FUtilityDBMW.selMEDPV_EXPTAB_DATI.SearchRecord('TABLE_NAME',chkLstBoxExpTabelle.Items[i],[srFromBeginning])) then
        begin
          StatusBar.SimpleText:=Format('Esportazione dati tabella (%s) %s ...',[jTab.ToString + ' di ' + NumeroTabelle.ToString,
                                                                                chkLstBoxExpTabelle.Items[i]]);
          inc(jTab);
          Application.ProcessMessages;
          A099FUtilityDBMW.ExportDB.RegistraLOG(Format('Esportazione tabella: %s',[chkLstBoxExpTabelle.Items[i]]));
          A099FUtilityDBMW.ExportDB.RegistraLOG(A099FUtilityDBMW.ExportDB.ExpDati.Esporta(chkLstBoxExpTabelle.Items[i]));
        end;
      end;
      A099FUtilityDBMW.selMEDPV_EXPTAB_DATI.Close;
      A099FUtilityDBMW.ExportDB.ExpDati.SQLDefine:=True;
      A099FUtilityDBMW.ExportDB.RegistraLOG('Fine esportazione dati tabelle');
    end;
    A099FUtilityDBMW.ExportDB.RegistraLOG('<Fine esportazione utente ' + Parametri.Username.ToUpper + '>');
  finally
    Screen.Cursor:=crDefault;
  end;
  StatusBar.SimpleText:='Esportazione terminata.';
  ShowMessage('Esportazione terminata.');
end;

procedure TA099FUtilityDB.btnFiltroClick(Sender: TObject);
var
  s:string;
begin
  C600frmSelAnagrafe.C600DataLavoro:=Parametri.DataLavoro;
  C600frmSelAnagrafe.C600DatiVisualizzati:='';
  C600frmSelAnagrafe.btnSelezioneClick(Sender);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text.Trim;
    if Pos('ORDER BY',S.ToUpper) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',S.ToUpper) - 1);
    edtFiltro.Text:=S;
  end;
end;

procedure TA099FUtilityDB.btnPathClick(Sender: TObject);
begin
  with TSaveDialog.Create(nil) do
    try
      Filter:='*.sql|*.sql';
      FileName:=Parametri.Username.ToUpper;
      if DirectoryExists(edtPath.Text) then
        InitialDir:=ExtractFilePath(edtPath.Text)
      else
        InitialDir:='';
      DefaultExt:='.sql';
      if Execute then
      begin
        edtPath.Text:=FileName;
        SetPercorsi;
      end;
    finally
      Free;
    end;
end;

procedure TA099FUtilityDB.CaricaOggettiDB;

  procedure AggiungiNodo(Tipo,Oggetto:String);
  var i:Integer;
      Trovato:Boolean;
      Nodo:TTreeNode;
  begin
    i:=0;
    Trovato:=False;
    while i < treeOggettiDB.Items.Count do
    begin
      if UpperCase(Tipo) = UpperCase(treeOggettiDB.Items[i].Text) then
      begin
        Nodo:=treeOggettiDB.Items.AddChild(treeOggettiDB.Items[i],Oggetto);
        Nodo.ImageIndex:=2;
        if Pos('(INVALID)',Oggetto) > 0 then
          Nodo.ImageIndex:=1;
        Trovato:=True;
        Break;
      end;
      inc(i);
    end;
    if not Trovato then
    begin
      Nodo:=treeOggettiDB.Items.Add(nil,Tipo);
      Nodo:=treeOggettiDB.Items.AddChild(Nodo,Oggetto);
      Nodo.ImageIndex:=2;
      if Pos('(INVALID)',Oggetto) > 0 then
        Nodo.ImageIndex:=1;
    end;
  end;

begin
  treeOggettiDB.Items.Clear;
  with A099FUtilityDBMW.selUserObjects do
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

procedure TA099FUtilityDB.chkCompileParametersClick(Sender: TObject);
begin
  if (Sender = chkCompileInterpreted) and chkCompileInterpreted.Checked then
    chkCompileNative.Checked:=False;
  if (Sender = chkCompileNative) and chkCompileNative.Checked then
    chkCompileInterpreted.Checked:=False;
  if (Sender = chkCompileReuse) and chkCompileReuse.Checked then
  begin
    chkCompileDebug.Checked:=False;
    chkCompileInterpreted.Checked:=False;
    chkCompileNative.Checked:=False;
  end;
  if (Sender <> chkCompileReuse) and (chkCompileDebug.Checked or chkCompileInterpreted.Checked or chkCompileNative.Checked) then
    chkCompileReuse.Checked:=False;
end;

procedure TA099FUtilityDB.RicompilaOggetto(Tipo,Oggetto:String);
begin
  Oggetto:=Copy(Oggetto,1,Pos('(',Oggetto) - 1);
  StatusBar.SimpleText:=Tipo + ': ' + Oggetto;
  StatusBar.Repaint;
  memoResult.Lines.AddStrings(A099FUtilityDBMW.RicompilaOggetto(Tipo,Oggetto,chkCompileDebug.Checked,chkCompileNative.Checked,chkCompileInterpreted.Checked,chkCompileReuse.Checked));
end;

procedure TA099FUtilityDB.Selezionatutto2Click(Sender: TObject);
begin
  chkLstBoxExpTabelle.CheckAll(cbChecked);
end;

procedure TA099FUtilityDB.btnRicompilaTuttoClick(Sender: TObject);
var i,j:Integer;
    s:String;
    Nodo:TTreeNode;
begin
  memoResult.Lines.Clear;
  Screen.Cursor:=crHourGlass;
  for i:=0 to treeOggettiDB.Items.Count - 1 do
  begin
    s:=treeOggettiDB.Items[i].Text;
    if s = 'SYNONYM' then
      Continue;
    Nodo:=treeOggettiDB.Items[i];
    for j:=0 to Nodo.Count - 1 do
      if (Sender = btnRicompilaTutto) or (Pos('(INVALID)',Nodo.Item[j].Text) > 0) then
      begin
        RicompilaOggetto(s,Nodo.Item[j].Text);
      end;
  end;
  Screen.Cursor:=crDefault;
  StatusBar.SimpleText:='';
end;

procedure TA099FUtilityDB.btnV430StoricoClick(Sender: TObject);
begin
  A099FUtilityDBMW.CostruisciV430;
end;

procedure TA099FUtilityDB.Ricompila1Click(Sender: TObject);
var Nodo:TTreeNode;
    i:Integer;
begin
  Nodo:=treeOggettiDB.Selected;
  memoResult.Lines.Clear;
  Screen.Cursor:=crHourGlass;
  if Nodo.Parent = nil then
  begin
    for i:=0 to Nodo.Count - 1 do
      RicompilaOggetto(Nodo.Text,Nodo.Item[i].Text);
  end
  else
    RicompilaOggetto(Nodo.Parent.Text,Nodo.Text);
  Screen.Cursor:=crDefault;
  StatusBar.SimpleText:='';
  CaricaOggettiDB;
end;

procedure TA099FUtilityDB.treeOggettiDBChange(Sender: TObject;
  Node: TTreeNode);
var Nodo:TTreeNode;
begin
  Nodo:=treeOggettiDB.Selected;
  Ricompila1.Enabled:=True;
  if Nodo = nil then
    exit
  else if (Nodo.Parent = nil) and (Nodo.Text = 'SYNONYM') then
    Ricompila1.Enabled:=False
  else if (Nodo.Parent <> nil) and (Nodo.Parent.Text = 'SYNONYM') then
    Ricompila1.Enabled:=False;
end;

procedure TA099FUtilityDB.Refresh1Click(Sender: TObject);
begin
  CaricaOggettiDB;
end;

{procedure TA099FUtilityDB.RGPOpzioniTabelleClick(Sender: TObject);
var
  SQL:string;
const
  TAB_IRIS =
    'and ((substr(T.TABLE_NAME,1,1) in (''T'',''I'',''P'') and substr(T.TABLE_NAME,5,1) = ''_'')' + CRLF +
    '      or (substr(T.TABLE_NAME,1,2) = ''SG'' and substr(T.TABLE_NAME,6,1) = ''_''))';
  TAB_IRIS_INUTILI =
    'T.TABLE_NAME not in (''I000_BACKUP'',''I000_LOGINFO'',''I001_BACKUP'',''I001_LOGDATI'',''I005_MSGINFO'',''I006_MSGDATI'',''IA000_LOGINTEGRAZIONE'',''T195_BACKUP'',''T103_TIMBRATURE_SCARTATE'',''T101_ANOMALIE'',''I101_TIMBIRREGOLARI'')' + CRLF +
    'and T.TABLE_NAME not like ''T920%''' ;
begin
  try
    Screen.Cursor:=crHourGlass;
    case RGPOpzioniTabelle.ItemIndex of
      0: A099FUtilityDBMW.OpenSelExpAllTab;
      1: A099FUtilityDBMW.OpenSelExpAllTab(TAB_IRIS);
      2: A099FUtilityDBMW.OpenSelExpAllTab(TAB_IRIS + ' and ' + TAB_IRIS_INUTILI);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
  CaricaListaTabelleExport;
end;}

procedure TA099FUtilityDB.treeOggettiDBAdvancedCustomDrawItem(
  Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage; var PaintImages, DefaultDraw: Boolean);
var C:TColor;
begin
  if cdsSelected in State then
  begin
    treeOggettiDB.Canvas.Brush.Color:=clHighLight;
    C:=clHighLightText;
  end
  else
  begin
    treeOggettiDB.Canvas.Brush.Color:=clWindow;
    C:=clWindowText;
  end;
  if Node.ImageIndex = 1 then
    C:=clRed;
  DisegnaNodo(treeOggettiDB, Node.DisplayRect(True), C, [], Node.Text);
end;

procedure TA099FUtilityDB.Deselezionatutto1Click(Sender: TObject);
begin
  chkLstBoxExpTabelle.CheckAll(cbUnchecked);
end;

function TA099FUtilityDB.DisegnaNodo(Albero:TTreeView; RectRif: TRect; xFontColor:TColor; xFontStyle:TFontStyles; sTesto:string): TRect;
var xNewRect:TRect;
begin
  xNewRect.Left:=RectRif.Left;
  xNewRect.Right:=RectRif.Right;
  xNewRect.Top:=RectRif.Top;
  xNewRect.Bottom:=RectRif.Bottom;
  Albero.Canvas.Font.Color:=xFontColor;
  //Albero.Canvas.Font.Style:=xFontStyle;
  Albero.Canvas.TextRect(xNewRect,xNewRect.left + 1,xNewRect.top + 1,sTesto);
  Albero.Canvas.Refresh;
  Result:=xNewRect;
end;

procedure TA099FUtilityDB.edtDalExit(Sender: TObject);
var
  StrDate:string;
  MyDate:TDateTime;
begin
  StrDate:=(Sender as TMaskEdit).Text;
  if Not TryStrToDate(StrDate,MyDate) and
     (StrDate <> '  /  /    ') then
  begin
    R180MessageBox('Data errata.',ERRORE);
    (Sender as TMaskEdit).Clear;
  end;
end;

procedure TA099FUtilityDB.edtPathExit(Sender: TObject);
begin
  try
    SetPercorsi;
  except
  end;
end;

procedure TA099FUtilityDB.treeOggettiDBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Nodo:TTreeNode;
begin
  Nodo:=treeOggettiDB.GetNodeAt(X,Y);
  if Nodo <> nil then
    treeOggettiDB.Selected:=Nodo;
end;

end.
