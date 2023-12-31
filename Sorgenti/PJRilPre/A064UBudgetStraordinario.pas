unit A064UBudgetStraordinario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, CheckLst, DBCtrls, Buttons, Mask, ExtCtrls,
  ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Oracle, OracleData, Clipbrd,
  System.Actions, Math, StrUtils,
  R001UGESTTAB, QueryStorico, ToolbarFiglio,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  A003UDataLavoroBis, C180FunzioniGenerali, C600USelAnagrafe, System.ImageList;

type
  TA064FBudgetStraordinario = class(TR001FGestTab)
    Panel2: TPanel;
    lblCodGruppo: TLabel;
    lblDescrizione: TLabel;
    lblFiltroAnagrafe: TLabel;
    lblTipo: TLabel;
    lblImporto: TLabel;
    lblOre: TLabel;
    dlblDescTipo: TDBText;
    dedtCodGruppo: TDBEdit;
    dedtDescrizione: TDBEdit;
    dedtFiltroAnagrafe: TDBEdit;
    dcmbTipo: TDBLookupComboBox;
    dedtImporto: TDBEdit;
    dedtOre: TDBEdit;
    C600frmSelAnagrafe: TC600frmSelAnagrafe;
    lblAnno: TLabel;
    btnAnno: TBitBtn;
    lblDalMese: TLabel;
    PopupMenu1: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    MenuItem1: TMenuItem;
    Copia2: TMenuItem;
    CopiaInExcel: TMenuItem;
    dedtAnno: TDBEdit;
    cmbDalMese: TComboBox;
    lblAlMese: TLabel;
    cmbAlMese: TComboBox;
    ProgressBar1: TProgressBar;
    Panel3: TPanel;
    frmToolbarFiglio: TfrmToolbarFiglio;
    dgrdRiepilogoMese: TDBGrid;
    Panel4: TPanel;
    rgpTipoResiduo: TRadioGroup;
    actAccediAllineamentoBudget: TAction;
    ToolButton2: TToolButton;
    TAllineamentoBudget: TToolButton;
    btnDipendenti: TBitBtn;
    Azioni1: TMenuItem;
    Allineamentodelbudget1: TMenuItem;
    cmbFiltroAnno: TComboBox;
    lblFiltroAnno: TLabel;
    ToolButton4: TToolButton;
    TStampaBudget: TToolButton;
    actAccediStampaBudget: TAction;
    Stampasituazionedelbudget1: TMenuItem;
    lblOperatori: TLabel;
    edtOperatori: TEdit;
    btnOperatori: TBitBtn;
    lblAutorizzatori: TLabel;
    edtAutorizzatori: TEdit;
    btnAutorizzatori: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure dedtAnnoChange(Sender: TObject);
    procedure btnAnnoClick(Sender: TObject);
    procedure cmbDalMeseChange(Sender: TObject);
    procedure cmbDalMeseExit(Sender: TObject);
    procedure cmbAlMeseChange(Sender: TObject);
    procedure cmbAlMeseExit(Sender: TObject);
    procedure dcmbTipoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure Copia2Click(Sender: TObject);
    procedure btnDipendentiClick(Sender: TObject);
    procedure rgpTipoResiduoClick(Sender: TObject);
    procedure frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
    procedure actAccediAllineamentoBudgetExecute(Sender: TObject);
    procedure cmbFiltroAnnoChange(Sender: TObject);
    procedure actAccediStampaBudgetExecute(Sender: TObject);
    procedure btnOperatoriClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AbilitaAzioni;
  end;

var
  A064FBudgetStraordinario: TA064FBudgetStraordinario;

  procedure OpenA064FBudgetStraordinario;

implementation

uses A064UBudgetStraordinarioDtM, A064UDipendenti, A063UBudgetGenerazione, A065UStampaBudget,
     C013UCheckList;

{$R *.dfm}

procedure OpenA064FBudgetStraordinario;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA064FBudgetStraordinario') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  Application.CreateForm(TA064FBudgetStraordinario, A064FBudgetStraordinario);
  Application.CreateForm(TA064FBudgetStraordinarioDtM, A064FBudgetStraordinarioDtM);
  try
    Screen.Cursor:=crDefault;
    A064FBudgetStraordinario.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A064FBudgetStraordinario.Free;
    A064FBudgetStraordinarioDtM.Free;
  end;
end;

procedure TA064FBudgetStraordinario.FormShow(Sender: TObject);
begin
  inherited;
  frmToolbarFiglio.TFDButton:=A064FBudgetStraordinarioDtM.dsrT714;
  frmToolbarFiglio.TFDBGrid:=dgrdRiepilogoMese;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  frmToolbarFiglio.lstLock[3]:=Panel4;
  AbilitaAzioni;
  C600frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,nil,0,False);
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.OpenC600SelAnagrafe:=False;
  dlblDescTipo.DataSource:=A064FBudgetStraordinarioDtM.A064MW.dsrT275;
  dcmbTipo.ListSource:=A064FBudgetStraordinarioDtM.A064MW.dsrT275;
  rgpTipoResiduo.ItemIndex:=1;
end;

procedure TA064FBudgetStraordinario.frmToolbarFiglioactTFAnnullaExecute(Sender: TObject);
begin
  with frmToolbarFiglio do
  begin
    TOracleDataSet(DButton.DataSet).CancelUpdates;
    if TFCache then
      TOracleDataSet(DButton.DataSet).ReadOnly:=True;
    if TFDBGrid <> nil then
    try
      TFDBGrid.Options:=TFDBGridOptions;
    except
    end;
    AbilitaAzioniTF(Sender);
  end;
  A064FBudgetStraordinarioDtM.A064MW.CaricamentoMesi;
end;

procedure TA064FBudgetStraordinario.AbilitaAzioni;
begin
  with A064FBudgetStraordinarioDtM.A064MW do
    if selT713.Active then
    begin
      actInserisci.Enabled:=(selT713.State = dsBrowse) and (not SolaLettura);
      actCancella.Enabled:=(selT713.RecordCount > 0) and (selT713.State = dsBrowse) and (not SolaLettura);
      actModifica.Enabled:=(selT713.RecordCount > 0) and (selT713.State = dsBrowse) and (not SolaLettura);
      actAccediAllineamentoBudget.Enabled:=selT713.State = dsBrowse;
      if frmToolbarFiglio.TFDButton <> nil then
        frmToolbarFiglio.AbilitaAzioniTF(nil);
      if selT714.Active then
      begin
        frmToolbarFiglio.actTFInserisci.Enabled:=False;
        frmToolbarFiglio.actTFModifica.Enabled:=(selT713.RecordCount > 0) and (selT714.RecordCount > 0) and (not frmToolBarFiglio.actTFConferma.Enabled) and (not SolaLettura);
        frmToolbarFiglio.actTFCancella.Enabled:=False;
      end;
    end;
end;

procedure TA064FBudgetStraordinario.DButtonStateChange(Sender: TObject);
begin
  inherited;
  dedtAnno.ReadOnly:=not (DButton.State in [dsInsert]);
  btnAnno.Enabled:=DButton.State in [dsInsert];
  C600frmSelAnagrafe.btnSelezione.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbDalMese.Enabled:=DButton.State in [dsEdit,dsInsert];
  cmbAlMese.Enabled:=DButton.State in [dsEdit,dsInsert];
  with A064FBudgetStraordinarioDtM.A064MW do
  begin
    if DButton.State in [dsEdit] then
    begin
      DecIniOld:=selT713.FieldByName('DECORRENZA').AsDateTime;
      DecFinOld:=selT713.FieldByName('DECORRENZA_FINE').AsDateTime;
    end;
    selT713.FieldByName('CODGRUPPO').ReadOnly:=not (DButton.State in [dsInsert]);
    selT713.FieldByName('TIPO').ReadOnly:=not (DButton.State in [dsInsert]);
  end;
  AbilitaAzioni;
end;

procedure TA064FBudgetStraordinario.dedtAnnoChange(Sender: TObject);
begin
  inherited;
  cmbDalMeseChange(nil);
  cmbAlMeseChange(nil);
end;

procedure TA064FBudgetStraordinario.btnAnnoClick(Sender: TObject);
begin
  inherited;
  DButton.DataSet.FieldByName('ANNO').AsInteger:=StrToIntDef(Copy(DateToStr(DataOut(StrToDate('01/01/' + DButton.DataSet.FieldByName('ANNO').AsString),'Anno elaborazione','A')),7,4),0);
end;

procedure TA064FBudgetStraordinario.cmbDalMeseChange(Sender: TObject);
var Data:TDateTime;
begin
  inherited;
  try
    Data:=EncodeDate(StrToInt(dedtAnno.Text),StrToInt(cmbDalMese.Text),1);
    A064FBudgetStraordinarioDtM.A064MW.selT713.FieldByName('DECORRENZA').AsDateTime:=Data;
  except
  end;
end;

procedure TA064FBudgetStraordinario.cmbDalMeseExit(Sender: TObject);
var Data:TDateTime;
begin
  inherited;
  try
    Data:=EncodeDate(StrToInt(dedtAnno.Text),StrToInt(cmbDalMese.Text),1);
  except
    cmbDalMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_INIZIO_VALIDITA);
  end;
  if StrToInt(cmbDalMese.Text) > StrToInt(cmbAlMese.Text) then
  begin
    cmbDalMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_INIZIO_FINE_VALIDITA);
  end;
end;

procedure TA064FBudgetStraordinario.cmbFiltroAnnoChange(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  A064FBudgetStraordinarioDtM.A064MW.CambioAnno(cmbFiltroAnno.Text);
  Screen.Cursor:=crDefault;
  actRefreshExecute(nil);
  A064FBudgetStraordinarioDtM.A064MW.AperturaDettaglio;
  AbilitaAzioni;
  NumRecords;
end;

procedure TA064FBudgetStraordinario.cmbAlMeseChange(Sender: TObject);
var Data:TDateTime;
begin
  inherited;
  try
    Data:=R180FineMese(EncodeDate(StrToInt(dedtAnno.Text),StrToInt(cmbAlMese.Text),1));
    A064FBudgetStraordinarioDtM.A064MW.selT713.FieldByName('DECORRENZA_FINE').AsDateTime:=Data;
  except
  end;
end;

procedure TA064FBudgetStraordinario.cmbAlMeseExit(Sender: TObject);
var Data:TDateTime;
begin
  inherited;
  try
    Data:=EncodeDate(StrToInt(dedtAnno.Text),StrToInt(cmbAlMese.Text),1);
  except
    cmbAlMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_FINE_VALIDITA);
  end;
  if StrToInt(cmbDalMese.Text) > StrToInt(cmbAlMese.Text) then
  begin
    cmbAlMese.SetFocus;
    raise exception.Create(A000MSG_A064_ERR_INIZIO_FINE_VALIDITA);
  end;
end;

procedure TA064FBudgetStraordinario.dcmbTipoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA064FBudgetStraordinario.btnDipendentiClick(Sender: TObject);
begin
  inherited;
  if Trim(A064FBudgetStraordinarioDtM.A064MW.selT713.FieldByName('FILTRO_ANAGRAFE').AsString) = '' then
    exit;
  A064FBudgetStraordinarioDtM.A064MW.AperturaDipendenti;
  A064FDipendenti:=TA064FDipendenti.Create(nil);
  A064FDipendenti.ShowModal;
  FreeAndNil(A064FDipendenti);
end;

procedure TA064FBudgetStraordinario.btnOperatoriClick(Sender: TObject);
var
  MyC013FCheckList:TC013FCheckList;
  lstOperatori: TStringList;
  lstSelezionati: TStringList;
  DimCodice, i: Integer;
begin
  inherited;
  DimCodice:=1000;
  MyC013FCheckList:=TC013FCheckList.Create(nil);
  try
    A064FBudgetStraordinarioDtM.A064MW.ResponsabileAutorizzatore:=Sender = btnAutorizzatori;
    A064FBudgetStraordinarioDtM.A064MW.selOperatori.Filtered:=True;
    lstOperatori:=A064FBudgetStraordinarioDtM.A064MW.GetLstOperatori;
    lstSelezionati:=A064FBudgetStraordinarioDtM.A064MW.GetLstOperatoriSelezionati;

    MyC013FCheckList.Caption:=IfThen(Sender = btnOperatori, 'Operatori', 'Autorizzatori');
    //Passo i valori da visualizzare mediante string list
    MyC013FCheckList.clbListaDati.Items:=lstOperatori;
    R180PutCheckList(lstSelezionati.CommaText,
                     DimCodice,
                     MyC013FCheckList.clbListaDati);
    MyC013FCheckList.clbListaDati.Enabled:=DButton.State in [dsInsert,dsEdit];
    if MyC013FCheckList.ShowModal = mrOK then
    begin
      if DButton.State in [dsInsert,dsEdit] then
      begin
        lstSelezionati.StrictDelimiter:=True;
        lstSelezionati.CommaText:=R180GetCheckList(DimCodice,
                                 MyC013FCheckList.clbListaDati,',');
        A064FBudgetStraordinarioDtM.A064MW.SetLstOperatoriSelezionati(lstSelezionati);
        if Sender = btnOperatori then
        begin
          edtOperatori.Text:='';
          for i:=0 to lstSelezionati.Count-1 do
            edtOperatori.Text:=edtOperatori.Text + lstSelezionati[i] + '; ';
        end
        else if Sender = btnAutorizzatori then
        begin
          edtAutorizzatori.Text:='';
          for i:=0 to lstSelezionati.Count-1 do
            edtAutorizzatori.Text:=edtAutorizzatori.Text + lstSelezionati[i] + '; ';
        end
      end;
    end;
  finally
    FreeAndNil(MyC013FCheckList);
    FreeAndNil(lstOperatori);
    FreeAndNil(lstSelezionati);
  end;
end;

procedure TA064FBudgetStraordinario.C600frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var S:String;
begin
  C600frmSelAnagrafe.C600DataDal:=A064FBudgetStraordinarioDtM.A064MW.selT713.FieldByName('DECORRENZA').AsDateTime;
  C600frmSelAnagrafe.C600DataLavoro:=A064FBudgetStraordinarioDtM.A064MW.selT713.FieldByName('DECORRENZA_FINE').AsDateTime;
  C600frmSelAnagrafe.SelezionePeriodica:=True;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.grpSelezionePeriodica.ItemIndex:=1;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Enabled:=False;
  C600frmSelAnagrafe.C600FSelezioneAnagrafe.chkCessati.Checked:=False;
  C600frmSelAnagrafe.btnSelezioneClick(nil);
  if C600frmSelAnagrafe.C600ModalResult = mrOK then
  begin
    S:=EliminaRitornoACapo(Trim(C600frmSelAnagrafe.C600FSelezioneAnagrafe.SQLCreato.Text));
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    A064FBudgetStraordinarioDtM.A064MW.selT713.FieldByName('FILTRO_ANAGRAFE').AsString:=S;
  end;
end;

procedure TA064FBudgetStraordinario.Selezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdRiepilogoMese,'S')
end;

procedure TA064FBudgetStraordinario.Deselezionatutto1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdRiepilogoMese,'N')
end;

procedure TA064FBudgetStraordinario.Invertiselezione1Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dgrdRiepilogoMese,'C')
end;

procedure TA064FBudgetStraordinario.Copia2Click(Sender: TObject);
var S:String;
    i:Integer;
begin
  with dgrdRiepilogoMese.DataSource.DataSet do
  begin
    if not Active then
      exit;
    S:='';
    Clipboard.Clear;
    DisableControls;
    Screen.Cursor:=crHourGlass;
    First;
    try
      if not EOF then
      begin
        for i:=0 to FieldCount - 1 do
          if Fields[i].Visible then
            S:=S + Fields[i].DisplayLabel + #9;
        S:=S + #13#10;
      end;
      while not EOF do
      begin
        if dgrdRiepilogoMese.SelectedRows.CurrentRowSelected then
        begin
          for i:=0 to FieldCount - 1 do
            if Fields[i].Visible then
              S:=S + Fields[i].AsString + #9;
          S:=S + #13#10;
        end;
        Next;
      end;
    finally
      First;
      EnableControls;
      Screen.Cursor:=crDefault;
    end;
  end;
  Clipboard.AsText:=S;
end;

procedure TA064FBudgetStraordinario.actAccediAllineamentoBudgetExecute(Sender: TObject);
var BM:TBookMark;
begin
  inherited;
  with A064FBudgetStraordinarioDtM.A064MW do
  begin
    BM:=selT713.GetBookMark;
    if A000GetInibizioni('Funzione','OpenA063FBudgetGenerazione') = 'N' then
      ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA + CRLF + A000MSG_A064_MSG_CONTROLLO_FA_AUTOMATICO)
    else
    begin
      OpenA063FBudgetGenerazione(selT713.FieldByName('CODGRUPPO').AsString,selT713.FieldByName('TIPO').AsString,selT713.FieldByName('DECORRENZA').AsDateTime);
      selT713.Refresh;
      selT713.GoToBookMark(BM);
      selT713.FreeBookMark(BM);
    end;
  end;
end;

procedure TA064FBudgetStraordinario.actAccediStampaBudgetExecute(Sender: TObject);
var BM:TBookMark;
begin
  inherited;
  with A064FBudgetStraordinarioDtM.A064MW do
  begin
    BM:=selT713.GetBookMark;
    OpenA065StampaBudget(selT713.FieldByName('CODGRUPPO').AsString,selT713.FieldByName('TIPO').AsString,selT713.FieldByName('DECORRENZA').AsDateTime);
    selT713.Refresh;
    selT713.GoToBookMark(BM);
    selT713.FreeBookMark(BM);
  end;
end;

procedure TA064FBudgetStraordinario.rgpTipoResiduoClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  for i:=0 to dgrdRiepilogoMese.Columns.Count - 1 do
  begin
    if (dgrdRiepilogoMese.Columns[i].FieldName = 'ORE_RESIDUO_AUTO')
    or (dgrdRiepilogoMese.Columns[i].FieldName = 'IMPORTO_RESIDUO_AUTO') then
    begin
      dgrdRiepilogoMese.Columns[i].Visible:=rgpTipoResiduo.ItemIndex = 0;
      if dgrdRiepilogoMese.Columns[i].Visible then
        dgrdRiepilogoMese.Columns[i].Width:=IfThen(dgrdRiepilogoMese.Columns[i].FieldName = 'ORE_RESIDUO_AUTO',65,82);
    end;
    if (dgrdRiepilogoMese.Columns[i].FieldName = 'ORE_RESIDUO')
    or (dgrdRiepilogoMese.Columns[i].FieldName = 'IMPORTO_RESIDUO') then
    begin
      dgrdRiepilogoMese.Columns[i].Visible:=rgpTipoResiduo.ItemIndex = 1;
      if dgrdRiepilogoMese.Columns[i].Visible then
        dgrdRiepilogoMese.Columns[i].Width:=IfThen(dgrdRiepilogoMese.Columns[i].FieldName = 'ORE_RESIDUO',65,82);
    end;
  end;
end;

end.
