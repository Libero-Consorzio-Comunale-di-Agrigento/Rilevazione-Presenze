unit A083UMsgElaborazioni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SelAnagrafe, Oracle, C700USelezioneAnagrafe, A000UInterfaccia,
  ExtCtrls, StdCtrls, CheckLst, Mask, Buttons, A003UDataLavoroBis, ComCtrls,
  Grids, DBGrids, C180FunzioniGenerali, L021Call, R001UGestTab, ActnList, QRPDFFilt,
  ImgList, DB, Menus, ToolWin, A000UCostanti, A000USessione, OracleData, C004UParamForm,
  C001StampaLib, Printers, Math, C012UVisualizzaTesto, System.Actions, A000UMessaggi,
  System.ImageList, InputPeriodo;

type
  TA083FMsgElaborazioni = class(TR001FGestTab)
    pnlFiltri: TPanel;
    dGrdMessaggi: TDBGrid;
    chkSelAnagrafe: TCheckBox;
    Splitter1: TSplitter;
    pmnuCheck: TPopupMenu;
    SelezionaTutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnuGrid: TPopupMenu;
    CopiainExcel1: TMenuItem;
    Copia1: TMenuItem;
    Panel2: TPanel;
    PnlAziende: TPanel;
    listChkAziende: TCheckListBox;
    lblAziende: TLabel;
    PnlOperatori: TPanel;
    listChkOperatori: TCheckListBox;
    lblOperatori: TLabel;
    PnlMaschere: TPanel;
    listChkMaschere: TCheckListBox;
    lblMaschere: TLabel;
    PnlOperazioni: TPanel;
    listChkOperazioni: TCheckListBox;
    lblOperazioni: TLabel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    PnlCampiVisibili: TPanel;
    Splitter5: TSplitter;
    listChkCampiVisibili: TCheckListBox;
    lblCampiVisibili: TLabel;
    Selezionatutto2: TMenuItem;
    Deselezionatutto2: TMenuItem;
    Invertiselezione2: TMenuItem;
    N4: TMenuItem;
    pnlSelAnag: TPanel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkUltimoMovimento: TCheckBox;
    PrinterSetupDialog2: TPrinterSetupDialog;
    chkDettaglioCompleto: TCheckBox;
    edtTestoMsg: TEdit;
    lblTestoMsg: TLabel;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure FormShow(Sender: TObject);
    procedure listChkAziendeClickCheck(Sender: TObject);
    procedure chkSelAnagrafeClick(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure SelezionaTutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure pnlFiltriResize(Sender: TObject);
    procedure CopiainExcel1Click(Sender: TObject);
    procedure Copia1Click(Sender: TObject);
    procedure Selezionatutto2Click(Sender: TObject);
    procedure Deselezionatutto2Click(Sender: TObject);
    procedure Invertiselezione2Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure listChkCampiVisibiliClickCheck(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnStampanteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ParAzienda,ParOperatore,ParMaschera,ParTipo:String;
    C004FParamFormPrv:TC004FParamForm;
    function GetAziende:String;
    function GetOperatori:String;
    function GetMaschere:String;
    function GetOperazioni:String;
    function GetCampiChk:String;
    procedure PutParametriFunzione;
    procedure CaricaListChkCampiVisibili(ValIn:String);
    procedure SizePanel;
    procedure CambiaProgressivo;
    procedure CaricaListChkAziende;
    procedure CaricaListChkOperatori;
    procedure CaricaListChkMaschere;
    procedure CaricaListChkOperazioni;
    procedure SviluppoQuery;
    procedure VerificaData(Data:TDateTime);
    procedure Abilitazioni;
  public
    { Public declarations }
    DocumentoPDF,TipoModulo: String;
  end;

var A083FMsgElaborazioni: TA083FMsgElaborazioni;

procedure OpenA083MsgElaborazioni(P_Azienda,P_Operatore,P_Maschera,P_Tipo:String);

implementation

uses A083UMsgElaborazioniDtm, A083UStampa;

{$R *.dfm}

procedure OpenA083MsgElaborazioni(P_Azienda,P_Operatore,P_Maschera,P_Tipo:String);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if (P_Azienda = '') or (P_Operatore = '') or (P_Maschera = '') then
    case A000GetInibizioni('Funzione','OpenA083MsgElaborazioni') of
      'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          SolaLettura:=SolaLetturaOriginale;
          Exit;
          end;
      'R':SolaLettura:=True;
    end;
  A083FMsgElaborazioni:=TA083FMsgElaborazioni.Create(nil);
  A083FMsgElaborazioniDtm:=TA083FMsgElaborazioniDtm.Create(nil);
  with A083FMsgElaborazioni do
    try
      ParAzienda:=P_Azienda;
      ParOperatore:=P_Operatore;
      ParMaschera:=P_Maschera;
      ParTipo:=P_Tipo;
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      Free;
      A083FMsgElaborazioniDtm.Free;
    end;
end;

procedure TA083FMsgElaborazioni.VerificaData(Data:TDateTime);
begin
  if Data <= 0 then
  begin
    R180MessageBox(A000MSG_ERR_DATA_ERRATA,'ERRORE');
    Abort;
  end;
end;

procedure TA083FMsgElaborazioni.pnlFiltriResize(Sender: TObject);
begin
  inherited;
  Panel2.Height:=PnlFiltri.Height - 100;
  listChkAziende.Height:=Panel2.Height - 20;
  listChkOperatori.Height:=Panel2.Height - 20;
  listChkMaschere.Height:=Panel2.Height - 20;
  listChkOperazioni.Height:=Panel2.Height - 20;
  listChkCampiVisibili.Height:=Panel2.Height - 20;
  SizePanel;
end;

procedure TA083FMsgElaborazioni.SizePanel;
var NPanel:Integer;
begin
  NPanel:=0;
  if PnlAziende.Visible then
    inc(NPanel);
  if PnlOperatori.Visible then
    inc(NPanel);
  if PnlMaschere.Visible then
    inc(NPanel);
  if PnlOperazioni.Visible then
    inc(NPanel);
  if PnlCampiVisibili.Visible then
    inc(NPanel);
  PnlAziende.Width:=A083FMsgElaborazioni.Width div NPanel;
  PnlOperatori.Width:=PnlAziende.Width;
  PnlMaschere.Width:=PnlAziende.Width;
  PnlOperazioni.Width:=PnlAziende.Width;
  PnlCampiVisibili.Width:=PnlAziende.Width;
end;

procedure TA083FMsgElaborazioni.Stampa1Click(Sender: TObject);
begin
//  inherited;
  try
    if A083FStampa = nil then
      Application.CreateForm(TA083FStampa,A083FStampa);
    if TipoModulo = 'COM' then
    begin
      with A083FMsgElaborazioniDtm.A083MW do
      begin
        DataDa:=frmInputPeriodo.DataInizio;
        DataA:=frmInputPeriodo.DataFine;
        bSelAnagrafe:=chkSelAnagrafe.Checked;
        bDettaglioCompleto:=chkDettaglioCompleto.Checked;
        bUltimoMov:=chkUltimoMovimento.Checked;
        CaricaVetMaschere;
        Aggiorna;
        DButton.DataSet:=DataSetStampa;
        CaricaListChkCampiVisibili(A083FMsgElaborazioniDtm.A083MW.sCampiChecked);
      end;
    end
    else
      C001SettaQuickReport(A083FStampa.QRep);
    A083FMsgElaborazioniDtm.A083MW.DataSetStampa.DisableControls;
    A083FMsgElaborazioniDtm.A083MW.DataSetStampa.First;
    A083FStampa.QRep.PrinterSettings.UseStandardPrinter:=(TipoModulo = 'COM') and Parametri.UseStandardPrinter;
    A083FStampa.QRep.Page.Orientation:=poLandscape;
    with A083FStampa do
    begin
      QRep.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtID.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtData.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtOperatore.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtMaschera.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtMatricola.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtNominativo.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtTipo.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtMessaggio.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
      QRDBTxtAzienda.DataSet:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa;
    end;
    if TipoModulo = 'COM' then
    begin
      A083FStampa.QRep.ShowProgress:=False;
      A083FStampa.QRep.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
    end
    else
    begin
      A083FStampa.QRep.Preview;
    end;
  finally
    FreeAndNil(A083FStampa);
    A083FMsgElaborazioniDtm.A083MW.DataSetStampa.First;
    A083FMsgElaborazioniDtm.A083MW.DataSetStampa.EnableControls;
  end;
end;

procedure TA083FMsgElaborazioni.Invertiselezione1Click(Sender: TObject);
var I:Integer;
begin
  inherited;
  for i:=0 to TCheckListBox(pmnuCheck.PopupComponent).Items.Count - 1 do
    TCheckListBox(pmnuCheck.PopupComponent).Checked[i]:=Not TCheckListBox(pmnuCheck.PopupComponent).Checked[i];

  if pmnuCheck.PopupComponent = listChkCampiVisibili then
    for i:=0 to DButton.DataSet.FieldCount - 1 do
      DButton.DataSet.Fields[i].Visible:=Not DButton.DataSet.Fields[i].Visible;
end;

procedure TA083FMsgElaborazioni.Invertiselezione2Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dGrdMessaggi,'C');
end;

procedure TA083FMsgElaborazioni.Copia1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dGrdMessaggi,Sender = CopiaInExcel1, False);
end;

procedure TA083FMsgElaborazioni.CopiainExcel1Click(Sender: TObject);
begin
  inherited;
  R180DBGridCopyToClipboard(dGrdMessaggi,Sender = CopiaInExcel1, False);
end;

procedure TA083FMsgElaborazioni.Deselezionatutto1Click(Sender: TObject);
var I:Integer;
begin
  inherited;
  for i:=0 to TCheckListBox(pmnuCheck.PopupComponent).Items.Count - 1 do
    TCheckListBox(pmnuCheck.PopupComponent).Checked[i]:=False;

  if pmnuCheck.PopupComponent = listChkCampiVisibili then
    for i:=0 to DButton.DataSet.FieldCount - 1 do
      DButton.DataSet.Fields[i].Visible:=False;
end;

procedure TA083FMsgElaborazioni.Deselezionatutto2Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dGrdMessaggi,'N');
end;

procedure TA083FMsgElaborazioni.SelezionaTutto1Click(Sender: TObject);
var I:Integer;
begin
  inherited;
  for i:=0 to TCheckListBox(pmnuCheck.PopupComponent).Items.Count - 1 do
    TCheckListBox(pmnuCheck.PopupComponent).Checked[i]:=True;

  if pmnuCheck.PopupComponent = listChkCampiVisibili then
    for i:=0 to DButton.DataSet.FieldCount - 1 do
      DButton.DataSet.Fields[i].Visible:=True;
end;

procedure TA083FMsgElaborazioni.Selezionatutto2Click(Sender: TObject);
begin
  inherited;
  R180DBGridSelezionaRighe(dGrdMessaggi,'S');
end;

procedure TA083FMsgElaborazioni.BtnStampanteClick(Sender: TObject);
begin
  inherited;
  PrinterSetupDialog2.Execute;
end;

procedure TA083FMsgElaborazioni.CambiaProgressivo;
begin
  //
end;

procedure TA083FMsgElaborazioni.FormCreate(Sender: TObject);
begin
  inherited;
  TipoModulo:='CS';
  DocumentoPDF:='';
  frmInputPeriodo.CaptionDataOutI:= 'Da data';
  frmInputPeriodo.CaptionDataOutF:= 'A data';
end;

procedure TA083FMsgElaborazioni.FormDestroy(Sender: TObject);
begin
  inherited;
  PutParametriFunzione;
  FreeAndNil(C004FParamFormPrv);
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA083FMsgElaborazioni.PutParametriFunzione;
begin
  C004FParamFormPrv.Cancella001;
  C004FParamFormPrv.PutParametro(listChkCampiVisibili.Name,GetCampiChk);
  try SessioneOracle.Commit; except end;
end;

procedure TA083FMsgElaborazioni.FormShow(Sender: TObject);
begin
  inherited;

  Screen.Cursor:=crHourGlass;
  try
    //INIZIALIZZAZIONE C700
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DatiSelezionati:=C700CampiBase;
    C700DataLavoro:=Parametri.DataLavoro;
    frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
    frmSelAnagrafe.CreaSelAnagrafe(A083FMsgElaborazioniDtm.A083MW,SessioneOracle,StatusBar,2,False);
    frmSelAnagrafe.NumRecords;

    frmInputPeriodo.DataInizio:=Date;
    frmInputPeriodo.DataFine:=Date;
    if RegistraMsg.ID > 0 then
      with A083FMsgElaborazioniDtm.A083MW do
      begin
        GetDataDaID.SetVariable('ID',RegistraMsg.ID);
        GetDataDaID.Execute;
        frmInputPeriodo.DataInizio:=GetDataDaID.FieldAsDate(0);
        frmInputPeriodo.DataFine:=GetDataDaID.FieldAsDate(0);
      end;

    if (ParAzienda = '') and (ParOperatore = '') and (ParMaschera = '') then
      chkUltimoMovimento.Visible:=False;
    chkUltimoMovimento.Checked:=chkUltimoMovimento.Visible;
    PnlAziende.Visible:=(ParAzienda = '');
    CaricaListChkAziende;
    PnlOperazioni.Visible:=(ParTipo = '');
    CaricaListChkOperazioni;
    PnlOperatori.Visible:=(ParOperatore = '');
    PnlMaschere.Visible:=(ParMaschera = '');
    with A083FMsgElaborazioniDtm do
    begin
      A083MW.sAziendeChecked:=GetAziende;
      CaricaListChkOperatori;
      CaricaListChkMaschere;
    end;

    C004FParamFormPrv:=CreaC004(SessioneOracle,'A083',Parametri.ProgOper,False);
    A083FMsgElaborazioniDtm.A083MW.sCampiChecked:=C004FParamFormPrv.GetParametro(listChkCampiVisibili.Name,'');  //Default tutti visualizzati
    SviluppoQuery;
    CaricaListChkCampiVisibili('');

    Abilitazioni;
    SizePanel;
    Self.WindowState:=wsMaximized;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkAziende;
var i:Integer;
begin
  ListChkAziende.Items.Clear;
  with A083FMsgElaborazioniDtm.A083MW do
  begin
    for i:=0 to Length(vetAziende) -1 do
    begin
      ListChkAziende.Items.Add(vetAziende[i]);
      if pos(vetAziende[i],ParAzienda) > 0 then
        ListChkAziende.Checked[ListChkAziende.Count-1]:=True;
    end;
    if ListChkAziende.Count <= 1 then
    begin
      ListChkAziende.Checked[0]:=True;
      ListChkAziende.Enabled:=False;
    end;
  end;
end;

procedure TA083FMsgElaborazioni.listChkAziendeClickCheck(Sender: TObject);
begin
  A083FMsgElaborazioniDtm.A083MW.sAziendeChecked:=GetAziende;
  if PnlOperatori.Visible then
    CaricaListChkOperatori;
  if PnlMaschere.Visible then
    CaricaListChkMaschere;
end;

function TA083FMsgElaborazioni.GetAziende:String;
var i:Integer;
    SelectAll:Boolean;
begin
  Result:='';
  SelectAll:=False;
  for i:=0 to ListChkAziende.Items.Count - 1 do
    if ListChkAziende.Checked[i] then
      Break;
  if (i = ListChkAziende.Items.Count) and  Not ListChkAziende.Checked[i-1] then
    SelectAll:=True;

  for i:=0 to ListChkAziende.Items.Count - 1 do
  begin
    if ListChkAziende.Checked[i] or SelectAll then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + ListChkAziende.Items[i] + '''';
    end;
  end;

  if (Result = '') or (chkSelAnagrafe.Checked) then
    Result:='''' + Parametri.Azienda + '''';
end;

procedure TA083FMsgElaborazioni.CaricaListChkOperazioni;
var i:integer;
begin
  ListChkOperazioni.Items.Clear;
  with A083FMsgElaborazioniDtm.A083MW do
  begin
    for i:=0 to Length(vetOperazioni) - 1 do
    begin
      ListChkOperazioni.Items.Add(vetOperazioni[i].Descrizione);
      if (pos(',' + vetOperazioni[i].Codice + ',',',' + Partipo + ',') > 0) or (ParTipo = '') then
        ListChkOperazioni.Checked[i]:=True;
    end;
  end;
end;

function TA083FMsgElaborazioni.GetOperazioni:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to listChkOperazioni.Items.Count - 1 do
    if listChkOperazioni.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + A083FMsgElaborazioniDtm.A083MW.vetOperazioni[i].Codice + '''';
    end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkOperatori;
var i:Integer;
begin
  ListChkOperatori.Items.Clear;
  with A083FMsgElaborazioniDtm.A083MW do
  begin
    CaricaVetOperatori;
    for i:=0 to Length(vetOperatori) -1 do
    begin
      ListChkOperatori.Items.Add(vetOperatori[i]);
      if vetOperatori[i] = (Parametri.Azienda + '.' + ParOperatore) then
        ListChkOperatori.Checked[ListChkOperatori.Count-1]:=True;
    end;
  end;
end;

function TA083FMsgElaborazioni.GetOperatori:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to ListChkOperatori.Items.Count - 1 do
    if ListChkOperatori.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + A083FMsgElaborazioniDtm.A083MW.VetOperatori[i] + '''';
    end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkMaschere;
var i:Integer;
begin
  ListChkMaschere.Items.Clear;
  with A083FMsgElaborazioniDtm.A083MW do
  begin
    CaricaVetMaschere;
    for i:=0 to Length(vetMaschere) -1 do
    begin
      ListChkMaschere.Items.Add(vetMaschere[i].Descrizione);
      if (Pos(',' + vetMaschere[i].Codice + ',',',' + ParMaschera + ',') > 0) and
         (vetMaschere[i].Codice <> '') and
         (listChkMaschere.Count > 0) then
          listChkMaschere.Checked[listChkMaschere.Count - 1]:=True;
    end;
  end;
end;

function TA083FMsgElaborazioni.GetMaschere:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to listChkMaschere.Items.Count - 1 do
    if listChkMaschere.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' +  A083FMsgElaborazioniDtm.A083MW.VetMaschere[i].Codice + '''';
    end;
end;

procedure TA083FMsgElaborazioni.CaricaListChkCampiVisibili(ValIn:String);
var i:Integer;
    CampiChk:String;
begin
  CampiChk:=A083FMsgElaborazioniDtm.A083MW.sCampiChecked;
  if ValIn <> '' then
    CampiChk:=ValIn;
  if CampiChk = '' then
    CampiChk:='1,5,6,7,8';
  listChkCampiVisibili.Items.Clear;
  for i:=0 to DButton.DataSet.FieldCount - 1 do
  begin
    listChkCampiVisibili.Items.Add(DButton.DataSet.Fields[i].DisplayLabel);
    DButton.DataSet.Fields[i].Visible:=(Pos(',' + IntToStr(i) + ',',',' + CampiChk + ',') > 0);
    listChkCampiVisibili.Checked[listChkCampiVisibili.Count-1]:=DButton.DataSet.Fields[i].Visible;
  end;
end;

procedure TA083FMsgElaborazioni.chkSelAnagrafeClick(Sender: TObject);
begin
  if ListChkAziende.Visible then
    ListChkAziende.Checked[ListChkAziende.Items.IndexOf(UpperCase(Parametri.Azienda))]:=True;
  Abilitazioni;
end;

procedure TA083FMsgElaborazioni.Abilitazioni;
begin
  ListChkAziende.Enabled:=(ListChkAziende.Visible) and (Length(A083FMsgElaborazioniDtm.A083MW.vetAziende) > 1) and (Not chkSelAnagrafe.Checked);
  frmSelAnagrafe.Enabled:=chkSelAnagrafe.Checked;
  frmSelAnagrafe.btnSelezione.Enabled:=chkSelAnagrafe.Checked;
  frmSelAnagrafe.btnEreditaSelezione.Enabled:=chkSelAnagrafe.Checked;
end;

function TA083FMsgElaborazioni.GetCampiChk:String;
var i:integer;
begin
  Result:='';
  for i:=0 to listChkCampiVisibili.Items.Count - 1 do
    if listChkCampiVisibili.Checked[i] then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + IntToStr(i);
    end;
end;

procedure TA083FMsgElaborazioni.actRefreshExecute(Sender: TObject);
begin
  VerificaData(frmInputPeriodo.DataInizio);
  VerificaData(frmInputPeriodo.DataFine);
  SviluppoQuery;
  A083FMsgElaborazioniDtm.A083MW.sCampiChecked:=GetCampiChk;
  CaricaListChkCampiVisibili(A083FMsgElaborazioniDtm.A083MW.sCampiChecked);
  NumRecords;
  //inherited;
end;

procedure TA083FMsgElaborazioni.SviluppoQuery;
begin
  with A083FMsgElaborazioniDtm.A083MW do
  begin
    sAziendeChecked:=GetAziende;
    sOperatoriChecked:=GetOperatori;
    sMaschereChecked:=GetMaschere;
    sOperazioniChecked:=GetOperazioni;
    sTestoMsg:=edtTestoMsg.Text;
    DataDa:=frmInputPeriodo.DataInizio;
    DataA:=frmInputPeriodo.DataFine;
    bSelAnagrafe:=chkSelAnagrafe.Checked;
    bDettaglioCompleto:=chkDettaglioCompleto.Checked;
    bUltimoMov:=chkUltimoMovimento.Checked;
    Aggiorna;
    DButton.DataSet:=DataSetStampa;
  end;
end;

procedure TA083FMsgElaborazioni.listChkCampiVisibiliClickCheck(Sender: TObject);
var i:Integer;
begin
  inherited;
  i:=0;
  while (i <= DButton.DataSet.FieldCount - 1) and
        (DButton.DataSet.Fields[i].DisplayLabel <> listChkCampiVisibili.Items[listChkCampiVisibili.ItemIndex]) do
    inc(i);
  if (i > DButton.DataSet.FieldCount - 1) or
     (DButton.DataSet.Fields[i].DisplayLabel <> listChkCampiVisibili.Items[listChkCampiVisibili.ItemIndex]) then
    Exit;
  DButton.DataSet.Fields[i].Visible:=listChkCampiVisibili.Checked[listChkCampiVisibili.ItemIndex];
end;

end.
