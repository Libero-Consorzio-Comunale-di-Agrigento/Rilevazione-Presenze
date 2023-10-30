unit WA083UMsgElaborazioni;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  IWCompJQueryWidget, ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, IWDBStdCtrls, meIWLabel, meIWButton, meIWDBNavigator,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, L021Call, medpIWMessageDlg, IWCompButton, WR102UGestTabella,
  A000UInterfaccia, A000UCostanti, A000USessione, C180FunzioniGenerali, C190FunzioniGeneraliWeb, WR100UBase,
  WA083UMSGElaborazioniDM, WA083UMSGElaborazioniBrowseFM, StrUtils,
  meIWGrid, medpIWTabControl, medpIWStatusBar,
  medpIWC700NavigatorBar, OracleData, IWCompCheckbox, meIWCheckBox, meIWEdit,
  IWAdvCheckGroup, meTIWAdvCheckGroup, WC700USelezioneAnagrafeFM,
  WC700USelezioneAnagrafeDM, Oracle, Winapi.Activex, Data.DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  Db, Math, Variants, IWCompExtCtrls, IWCompGrids, meIWImageFile, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, System.Actions, medpIWImageButton,
  Datasnap.DBClient, Datasnap.Win.MConnect;

type
  TWA083FMsgElaborazioni = class(TWR102FGestTabella)
    edtDataA: TmeIWEdit;
    lblAziende: TmeIWLabel;
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblOperatori: TmeIWLabel;
    lblMaschere: TmeIWLabel;
    lblDataA: TmeIWLabel;
    lblCampiVisibili: TmeIWLabel;
    lblOperazioni: TmeIWLabel;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    chkUltimoMovimento: TmeIWCheckBox;
    chkSelAnagrafe: TmeIWCheckBox;
    listChkAziende: TmeTIWAdvCheckGroup;
    listChkOperatori: TmeTIWAdvCheckGroup;
    listChkMaschere: TmeTIWAdvCheckGroup;
    listChkOperazioni: TmeTIWAdvCheckGroup;
    listChkCampiVisibili: TmeTIWAdvCheckGroup;
    pmnAzioniAziende: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    pmnAzioniOperatori: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    pmnAzioniMaschere: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    pmnAzioniOperazioni: TPopupMenu;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    pmnAzioniCampiVisibili: TPopupMenu;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    chkDettaglioCompleto: TmeIWCheckBox;
    DCOMConnection: TDCOMConnection;
    JQuery: TIWJQueryWidget;
    lblTestoMsg: TmeIWLabel;
    edtTestoMsg: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure listChkCampiVisibiliClick(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure actEstraiExecute(Sender: TObject);
    procedure chkSelAnagrafeAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    ParAzienda,ParOperatore,ParMaschera,ParTipo,ParId:String;
    function GetCampiChk:String;
    function GetOperazioni:String;
    function GetOperatori:String;
    function GetMaschere:String;
    function GetAziende:String;
    procedure PutParametri;
    procedure CaricaListChkAziende;
    procedure CaricaListChkOperazioni;
    procedure CaricaListChkOperatori;
    procedure CaricaListChkMaschere;
    procedure CaricaListChkCampiVisibili(ValIn:String);
    procedure CaricaList;
    procedure SviluppoQuery;
    procedure AbilitaPulsanteC700(val :boolean);
    procedure SelezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure DeselezionatuttoClick(Sender: TObject; CheckGroup: TmeTIWAdvCheckGroup);
    procedure InvertiselezioneClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
    procedure VisualizzaGruppoComponenti(Id: String; Visualizza: Boolean);
    procedure CallDCOMPrinter;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ElaborazioneServer; override;
  public
    function InizializzaAccesso:Boolean; override;
    function CreateJSonString: String;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.dfm}

procedure TWA083FMsgElaborazioni.imgC700SelezioneAnagrafeClick(Sender: TObject);
begin
  grdC700.actSelezioneAnagraficheExecute(nil);
end;

procedure TWA083FMsgElaborazioni.AbilitaPulsanteC700(val: boolean);
begin
  imgC700SelezioneAnagrafe.Enabled:=val;
  if imgC700SelezioneAnagrafe.Enabled then
    imgC700SelezioneAnagrafe.ImageFile.Filename:='img\btnC700SelezioneAnagrafe.png'
  else
    imgC700SelezioneAnagrafe.ImageFile.Filename:='img\btnC700SelezioneAnagrafe_Disabled.png';
end;

procedure TWA083FMsgElaborazioni.chkSelAnagrafeAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  listChkAziende.IsChecked[listChkAziende.Items.IndexOf(UpperCase(Parametri.Azienda))]:=True;
  AbilitaPulsanteC700(chkSelAnagrafe.Checked);
  listChkAziende.Enabled:=(listChkAziende.Visible) and (Length((WR302DM as TWA083FMsgElaborazioniDM).A083MW.vetAziende) > 1) and (Not chkSelAnagrafe.Checked);
end;

procedure TWA083FMsgElaborazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.DettaglioFM:=False;
  WR100LinkWC700:=False;
  WR302DM:=TWA083FMSGElaborazioniDM.Create(Self);
  AttivaGestioneC700;
  (WR302DM as TWA083FMSGElaborazioniDM).A083MW.SelAnagrafe:=grdC700.selAnagrafe;
  AbilitaPulsanteC700(False);
  SolaLettura:=True;
end;

function TWA083FMsgElaborazioni.InizializzaAccesso: Boolean;
begin
  Result:=False;
  ParAzienda:=GetParam('AZIENDA');
  ParOperatore:=GetParam('OPERATORE');
  ParMaschera:=GetParam('MASCHERA');
  ParTipo:=GetParam('TIPO');
  ParId:=GetParam('ID');

  edtDataDa.Text:=DateToStr(Date);
  edtDataA.Text:=DateToStr(Date);
  if ParId <> '' then
    with (WR302DM as TWA083FMsgElaborazioniDM).A083MW do
    begin
      msgID:=ParId;
      GetDataDaID.SetVariable('ID',StrTOInt(parId));
      GetDataDaID.Execute;
      edtDataDa.Text:=GetDataDaID.FieldAsString(0);
      edtDataA.Text:=GetDataDaID.FieldAsString(0);
    end;

  if (ParAzienda = '') and (ParOperatore = '') and (ParMaschera = '') then
    chkUltimoMovimento.Visible:=False;
  chkUltimoMovimento.Checked:=chkUltimoMovimento.Visible;
  lblAziende.Visible:=(ParAzienda = '');
  listChkAziende.Visible:=(ParAzienda = '');
  VisualizzaGruppoComponenti('listChkAziende',listChkAziende.Visible);
  CaricaListChkAziende;
  lblOperazioni.Visible:=True;//(ParTipo = '');
  listChkOperazioni.Visible:=True;//(ParTipo = '');
  VisualizzaGruppoComponenti('listChkOperazioni',listChkOperazioni.Visible);
  CaricaListChkOperazioni;
  lblOperatori.Visible:=(ParOperatore = '');
  listChkOperatori.Visible:=(ParOperatore = '');
  VisualizzaGruppoComponenti('listChkOperatori',listChkOperatori.Visible);
  lblMaschere.Visible:=(ParMaschera = '');
  listChkMaschere.Visible:=(ParMaschera = '');
  VisualizzaGruppoComponenti('listChkMaschere',listChkMaschere.Visible);

  with (WR302DM as TWA083FMsgElaborazioniDM) do
  begin
    A083MW.sAziendeChecked:=GetAziende;
    CaricaListChkOperatori;
    CaricaListChkMaschere;
  end;

  (WR302DM as TWA083FMsgElaborazioniDM).A083MW.sCampiChecked:=C004DM.GetParametro(listChkCampiVisibili.Name,'');  //Default tutti visualizzati
  SviluppoQuery;
  CaricaListChkCampiVisibili('');

  WBrowseFM:=TWA083FMsgElaborazioniBrowseFM.Create(Self);
  CreaTabDefault;
  Result:=True;
end;

procedure TWA083FMsgElaborazioni.CaricaListChkAziende;
var i:Integer;
begin
  listChkAziende.Items.Clear;
  with (WR302DM as TWA083FMsgElaborazioniDM).A083MW do
  begin
    for i:=0 to Length(vetAziende) -1 do
    begin
      listChkAziende.Items.Add(vetAziende[i]);
      if pos(vetAziende[i],ParAzienda) > 0 then
        listChkAziende.IsChecked[listChkAziende.Items.Count-1]:=True;
    end;
    if listChkAziende.Items.Count <= 1 then
    begin
      listChkAziende.IsChecked[0]:=True;
      listChkAziende.Enabled:=False;
    end;
  end;
end;

function TWA083FMsgElaborazioni.GetAziende:String;
var i:Integer;
    SelectAll:Boolean;
begin
  Result:='';
  SelectAll:=False;
  for i:=0 to listChkAziende.Items.Count - 1 do
    if listChkAziende.IsChecked[i] then
      Break;
  if (i = listChkAziende.Items.Count) and  Not listChkAziende.IsChecked[i-1] then
    SelectAll:=True;

  for i:=0 to listChkAziende.Items.Count - 1 do
  begin
    if listChkAziende.IsChecked[i] or SelectAll then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + listChkAziende.Items[i] + '''';
    end;
  end;

  if (Result = '') or (chkSelAnagrafe.Checked) then
    Result:='''' + Parametri.Azienda + '''';
end;

procedure TWA083FMsgElaborazioni.CaricaListChkOperazioni;
var i:integer;
begin
  listChkOperazioni.Items.Clear;
  with (WR302DM as TWA083FMsgElaborazioniDM).A083MW do
  begin
    for i:=0 to Length(vetOperazioni) - 1 do
    begin
      listChkOperazioni.Items.Add(vetOperazioni[i].Descrizione);
      if (pos(',' + vetOperazioni[i].Codice + ',',',' + Partipo + ',') > 0) or (ParTipo = '') then
        listChkOperazioni.IsChecked[i]:=True;
    end;
  end;
end;

function TWA083FMsgElaborazioni.GetOperazioni:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to listChkOperazioni.Items.Count - 1 do
    if listChkOperazioni.IsChecked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + (WR302DM as TWA083FMsgElaborazioniDM).A083MW.VetOperazioni[i].Codice + '''';
    end;
end;

procedure TWA083FMsgElaborazioni.CaricaListChkOperatori;
var i:Integer;
begin
  with (WR302DM as TWA083FMsgElaborazioniDM).A083MW do
  begin
    listChkOperatori.Items.Clear;
    CaricaVetOperatori;
    for i:=0 to Length(vetOperatori) -1 do
    begin
      ListChkOperatori.Items.Add(vetOperatori[i]);
      if vetOperatori[i] = (Parametri.Azienda + '.' + ParOperatore) then
        ListChkOperatori.IsChecked[i]:=True;
    end;
  end;
end;

procedure TWA083FMsgElaborazioni.CaricaListChkMaschere;
var i:Integer;
begin
  with (WR302DM as TWA083FMsgElaborazioniDM).A083MW do
  begin
    listChkMaschere.Items.Clear;
    CaricaVetMaschere;
    for i:=0 to Length(vetMaschere) -1 do
    begin
      ListChkMaschere.Items.Add(vetMaschere[i].Descrizione);
      if (Pos(',' + vetMaschere[i].Codice + ',',',' + ParMaschera + ',') > 0) and
         (vetMaschere[i].Codice <> '') and
         (listChkMaschere.Items.Count > 0) then
          listChkMaschere.IsChecked[i]:=True;
    end;
  end;
end;

function TWA083FMsgElaborazioni.GetOperatori:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to listChkOperatori.Items.Count - 1 do
    if listChkOperatori.IsChecked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + (WR302DM as TWA083FMsgElaborazioniDM).A083MW.VetOperatori[i] + '''';
    end;
end;

function TWA083FMsgElaborazioni.GetMaschere:String;
var i:Integer;
begin
  Result:='';
  for i:=0 to listChkMaschere.Items.Count - 1 do
    if listChkMaschere.IsChecked[i] then
    begin
      if Result <> '' then
        Result:=Result + ', ';
      Result:=Result + '''' + (WR302DM as TWA083FMsgElaborazioniDM).A083MW.VetMaschere[i].Codice + '''';
    end;
end;

procedure TWA083FMsgElaborazioni.SviluppoQuery;
var SQL,msgID:String;
    D:TDateTime;
begin
  with (WR302DM as TWA083FMsgElaborazioniDM).A083MW  do
  begin
    sAziendeChecked:=GetAziende;
    sOperatoriChecked:=GetOperatori;
    sMaschereChecked:=GetMaschere;
    sOperazioniChecked:=GetOperazioni;
    sTestoMsg:=edtTestoMsg.Text;
    DataDa:=StrToDate(edtDataDa.Text);
    DataA:=StrToDate(edtDataA.Text);
    bSelAnagrafe:=chkSelAnagrafe.Checked;
    bDettaglioCompleto:=chkDettaglioCompleto.Checked;
    bUltimoMov:=chkUltimoMovimento.Checked;
    Aggiorna;
    (WR302DM as TWA083FMsgElaborazioniDM).selTabella:=DataSetStampa;
  end;
end;

procedure TWA083FMsgElaborazioni.CaricaListChkCampiVisibili(ValIn:String);
var i:Integer;
    CampiChk:String;
begin
  CampiChk:=(WR302DM as TWA083FMsgElaborazioniDM).A083MW.sCampiChecked;
  if ValIn <> '' then
    CampiChk:=ValIn;
  if CampiChk = '' then
    CampiChk:='1,5,6,7,8';
  listChkCampiVisibili.Items.Clear;
  for i:=0 to (WR302DM as TWA083FMsgElaborazioniDM).selTabella.FieldCount - 1 do
  begin
    listChkCampiVisibili.Items.Add((WR302DM as TWA083FMsgElaborazioniDM).selTabella.Fields[i].DisplayLabel);
    (WR302DM as TWA083FMsgElaborazioniDM).selTabella.Fields[i].Visible:=(Pos(',' + IntToStr(i) + ',',',' + CampiChk + ',') > 0);
    listChkCampiVisibili.IsChecked[listChkCampiVisibili.Items.Count-1]:=(WR302DM as TWA083FMsgElaborazioniDM).selTabella.Fields[i].Visible;
  end;
end;

function TWA083FMsgElaborazioni.GetCampiChk:String;
var i:integer;
begin
  Result:='';
  for i:=0 to listChkCampiVisibili.Items.Count - 1 do
    if listChkCampiVisibili.IsChecked[i] then
    begin
      if Result <> '' then
        Result:=Result + ',';
      Result:=Result + IntToStr(i);
    end;
end;

procedure TWA083FMsgElaborazioni.actAggiornaExecute(Sender: TObject);
begin
  SviluppoQuery;
  (WR302DM as TWA083FMsgElaborazioniDM).A083MW.sCampiChecked:=GetCampiChk;
  CaricaListChkCampiVisibili((WR302DM as TWA083FMsgElaborazioniDM).A083MW.sCampiChecked);
  //Devo reimpostare MedpDataset perchè la procedura SviluppoQuery può
  //switchare selTabella da selOutput a selAnagrafeOut e deve riflettere sulla tabella
  WBrowseFM.grdTabella.medpDataSet:=TWA083FMsgElaborazioniDM(WR302DM).selTabella;
  WBrowseFM.grdTabella.medpCreaColonne;
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA083FMsgElaborazioni.IWAppFormRender(Sender: TObject);
begin
  VisualizzaGruppoComponenti('listChkAziende',listChkAziende.Visible);
  VisualizzaGruppoComponenti('listChkMaschere',listChkMaschere.Visible);
  VisualizzaGruppoComponenti('listChkOperazioni',listChkOperazioni.Visible);
  VisualizzaGruppoComponenti('listChkOperatori',listChkOperatori.Visible);
  inherited;
end;

procedure TWA083FMsgElaborazioni.MenuItem10Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,listChkOperazioni);
end;

procedure TWA083FMsgElaborazioni.MenuItem11Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,listChkOperazioni);
end;

procedure TWA083FMsgElaborazioni.MenuItem12Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,listChkOperazioni);
end;

procedure TWA083FMsgElaborazioni.MenuItem13Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,listChkCampiVisibili);
end;

procedure TWA083FMsgElaborazioni.MenuItem14Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,listChkCampiVisibili);
end;

procedure TWA083FMsgElaborazioni.MenuItem15Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,listChkCampiVisibili);
end;

procedure TWA083FMsgElaborazioni.MenuItem1Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,listChkAziende);
end;

procedure TWA083FMsgElaborazioni.MenuItem2Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,listChkAziende);
end;

procedure TWA083FMsgElaborazioni.MenuItem3Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,listChkAziende);
end;

procedure TWA083FMsgElaborazioni.MenuItem4Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,listChkOperatori);
end;

procedure TWA083FMsgElaborazioni.MenuItem5Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,listChkOperatori);
end;

procedure TWA083FMsgElaborazioni.MenuItem6Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,listChkOperatori);
end;

procedure TWA083FMsgElaborazioni.MenuItem7Click(Sender: TObject);
begin
  inherited;
  SelezionatuttoClick(Sender,listChkMaschere);
end;

procedure TWA083FMsgElaborazioni.MenuItem8Click(Sender: TObject);
begin
  inherited;
  DeselezionatuttoClick(Sender,listChkMaschere);
end;

procedure TWA083FMsgElaborazioni.MenuItem9Click(Sender: TObject);
begin
  inherited;
  InvertiSelezioneClick(Sender,listChkMaschere);
end;

procedure TWA083FMsgElaborazioni.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  inherited;
  PutParametri;
end;

procedure TWA083FMsgElaborazioni.PutParametri;
begin
  C004DM.Cancella001;
  C004DM.PutParametro(listChkCampiVisibili.Name,GetCampiChk);
  try SessioneOracle.Commit; except end;
end;

procedure TWA083FMsgElaborazioni.CaricaList;
begin
end;

procedure TWA083FMsgElaborazioni.VisualizzaGruppoComponenti(Id: String; Visualizza: Boolean);
begin
  if Visualizza then
    AddToInitProc('$(''.'+Id+'Obj'').show();')
  else
    AddToInitProc('$(''.'+Id+'Obj'').hide();');
end;

procedure TWA083FMsgElaborazioni.WC700AperturaSelezione(Sender: TObject);
var
  D: TDateTime;
begin
  inherited;
  if TryStrToDate(edtDataDa.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtDataA.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

procedure TWA083FMsgElaborazioni.listChkCampiVisibiliClick(Sender: TObject);
var i,x:Integer;
begin
  with TWA083FMSGElaborazioniDM(WR302DM) do
  begin
    for i := 0 to selTabella.FieldCount - 1 do
    begin
      x:=0;
      while (x < listChkCampiVisibili.Items.Count) do
      begin
        if selTabella.Fields[i].DisplayLabel = listChkCampiVisibili.Items[x] then
          selTabella.Fields[i].Visible:=listChkCampiVisibili.IsChecked[x];
        x:=x+1;
      end;
    end;
  end;
  (WR302DM as TWA083FMsgElaborazioniDM).selTabella.Refresh;
  (WR302DM as TWA083FMsgElaborazioniDM).A083MW.sCampiChecked:=GetCampiChk;
  WBrowseFM.grdTabella.medpCreaColonne;
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

procedure TWA083FMsgElaborazioni.SelezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
 i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=True;
  CheckGroup.AsyncUpdate;
end;

procedure TWA083FMsgElaborazioni.DeselezionatuttoClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=False;
  CheckGroup.AsyncUpdate;
end;

procedure TWA083FMsgElaborazioni.InvertiselezioneClick(Sender: TObject;CheckGroup: TmeTIWAdvCheckGroup);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CheckGroup.Items.Count - 1 do
    CheckGroup.IsChecked[i]:=not CheckGroup.IsChecked[i];
  CheckGroup.AsyncUpdate;
end;

procedure TWA083FMsgElaborazioni.actEstraiExecute(Sender: TObject);
begin
//  inherited;
  StartElaborazioneServer(btnSendFile.HTMLName);
end;

procedure TWA083FMsgElaborazioni.ElaborazioneServer;
begin
//  inherited;
  CallDCOMPrinter;
end;

procedure TWA083FMsgElaborazioni.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA083(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
  end;
end;

function TWA083FMsgElaborazioni.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDataDa,json);
    C190Comp2JsonString(edtDataA,json);
    C190Comp2JsonString(chkSelAnagrafe,json);
    C190Comp2JsonString(chkDettaglioCompleto,json);
    C190Comp2JsonString(chkUltimoMovimento,json);
    Json.AddPair('sApplicazione',TJSONString.Create(Parametri.Applicazione));
    Json.AddPair('sAziendeChecked',TJSONString.Create((WR302DM as TWA083FMsgElaborazioniDM).A083MW.sAziendeChecked));
    Json.AddPair('sOperatoriChecked',TJSONString.Create((WR302DM as TWA083FMsgElaborazioniDM).A083MW.sOperatoriChecked));
    Json.AddPair('sMaschereChecked',TJSONString.Create((WR302DM as TWA083FMsgElaborazioniDM).A083MW.sMaschereChecked));
    Json.AddPair('sOperazioniChecked',TJSONString.Create((WR302DM as TWA083FMsgElaborazioniDM).A083MW.sOperazioniChecked));
    Json.AddPair('sCampiChecked',TJSONString.Create((WR302DM as TWA083FMsgElaborazioniDM).A083MW.sCampiChecked));
    Json.AddPair('sTestoMsg',TJSONString.Create((WR302DM as TWA083FMsgElaborazioniDM).A083MW.sTestoMsg));
    Json.AddPair('msgID',TJSONString.Create((WR302DM as TWA083FMsgElaborazioniDM).A083MW.msgID));
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

end.
