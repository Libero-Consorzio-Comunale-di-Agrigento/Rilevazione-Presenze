unit WA186ULoginDipendentiBrowseFM;

interface

uses
  Windows,Messages,SysUtils,StrUtils,Variants,Classes,Graphics,Controls,Forms,
  Dialogs,WR204UBrowseTabellaFM,DB,DBClient,IWVCLComponent,
  IWBaseLayoutComponent,IWBaseContainerLayout,IWContainerLayout,
  IWTemplateProcessorHTML,IWVCLBaseControl,IWBaseControl,IWBaseHTMLControl,
  IWControl,IWDBGrids,medpIWDBGrid,IWVCLBaseContainer,IWContainer,
  IWHTMLContainer,IWHTML40Container,IWRegion,IWCompLabel,meIWLabel,
  IWCompListbox,IWDBStdCtrls,meIWDBLookupComboBox,Oracle,OracleData,
  C190FunzioniGeneraliWeb,IWCompJQueryWidget,IWCompGrids,
  meIWEdit,meIWImageFile,WC011UListBoxFM,WA083UMsgElaborazioni,
  WA186ULoginDipendentiCambioPasswordFM,A000UInterfaccia,A000UCostanti,A000USessione,A000UMessaggi,
  C180FUnzioniGenerali,IWCompExtCtrls,meIWRegion,meIWGrid,medpIWTabControl,medpIWMessageDlg,
  meIWDBComboBox,IWCompEdit,meIWComboBox,IWCompCheckbox,meIWCheckBox,IWCompButton,meIWButton,medpIWImageButton,Vcl.Menus;

type
  TWA186FLoginDipendentiBrowseFM = class(TWR204FBrowseTabellaFM)
    dcmbAzienda: TmeIWDBLookupComboBox;
    lblAzienda: TmeIWLabel;
    lblDescAzienda: TmeIWLabel;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    grdExrAccount: TmedpIWDBGrid;
    lblPermessi: TmeIWLabel;
    lblFiltroAnagrafe: TmeIWLabel;
    lblFiltroFunzioni: TmeIWLabel;
    lblFiltroDizionario: TmeIWLabel;
    lblNomeProfilo: TmeIWLabel;
    chkForzaCambioPwd: TmeIWCheckBox;
    lblUtente: TmeIWLabel;
    lblPassword: TmeIWLabel;
    cmbPermessi: TmeIWComboBox;
    cmbFiltroAnagrafe: TmeIWComboBox;
    cmbFiltroFunzioni: TmeIWComboBox;
    cmbFiltroDizionario: TmeIWComboBox;
    chkApplicaFiltro: TmeIWCheckBox;
    lblBoxGenMassivaLogin: TmeIWLabel;
    lblBoxImpProfili: TmeIWLabel;
    cmbIterAutor: TmeIWComboBox;
    lblIterAutor: TmeIWLabel;
    lblBoxAzioni: TmeIWLabel;
    btnDefault: TmeIWButton;
    btnCancellaProfili: TmeIWButton;
    cmbExprUtente: TmeIWDBLookupComboBox;
    cmbExprPassword: TmeIWDBLookupComboBox;
    cmbNomeProfilo: TmeIWComboBox;
    btnTrigger: TmeIWButton;
    imgAggPermessi: TmeIWImageFile;
    imgAggAnagrafe: TmeIWImageFile;
    imgAggFunzioni: TmeIWImageFile;
    imgAggIter: TmeIWImageFile;
    imgAggDizionario: TmeIWImageFile;
    imbAnomalie: TmedpIWImageButton;
    imbModificaPassword: TmedpIWImageButton;
    imbInserisciLogin: TmedpIWImageButton;
    imbCancellaLogin: TmedpIWImageButton;
    imbImpostaDatiDaDominio: TmedpIWImageButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dcmbAziendaChange(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure grdExrAccountRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
    procedure grdExrAccountComponenti2DataSet(Row: Integer);
    procedure grdExrAccountDataSet2Componenti(Row: Integer);
    procedure cmbExprPasswordChange(Sender: TObject);
    procedure cmbExprUtenteChange(Sender: TObject);
    procedure chkApplicaFiltroClick(Sender: TObject);
    procedure imgModificaPasswordClick(Sender: TObject);
    procedure imgInserisciLoginClick(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
    procedure imgCancellaLoginClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure btnCancellaProfiliClick(Sender: TObject);
    procedure btnTriggerClick(Sender: TObject);
    procedure imgAggPermessiClick(Sender: TObject);
    procedure imgAggAnagrafeClick(Sender: TObject);
    procedure imgAggFunzioniClick(Sender: TObject);
    procedure imgAggIterClick(Sender: TObject);
    procedure imgAggDizionarioClick(Sender: TObject);
    procedure chkForzaCambioPwdChange(Sender: TObject);
    procedure imbImpostaDatiDaDominioClick(Sender: TObject);
    procedure actScaricaInExcelClick(Sender: TObject);
    // MONDOEDP - chiamata 85397.ini
    // eliminato: v. evento onclick
    //procedure chkApplicaFiltroChange(Sender: TObject);
    // MONDOEDP - chiamata 85397.fine
  private
    campoUpdate:String;
    valUpdate:String;
    lstDominio:TStringList;
    RowAffected: Integer;
    WC011: TWC011FListBoxFM;
    WA186CambioPassword: TWA186FLoginDipendentiCambioPasswordFM;
    procedure PutParametriFunzione;
    procedure GetParametriFunzione;
    procedure SettaFiltroProfili;
    procedure CaricaCmbNomiProfili;
    procedure TestExprLogin(var ODS:TOracleDataSet);
    procedure imgAggiornaClick(Sender: TObject);
    procedure imgElencoUsers(Sender: TObject);
    procedure imgCambioPasswordClick(Sender: TObject);
    procedure AggiornaCampiI061(campo,val:String);
    procedure ResultInserimento(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultModificaPassword(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultAnomalie(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultCancella(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultTrigger(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultCancellaProfili(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultValoriDefault(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultAggiornaCampi(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultCambioPassword(Sender: TObject; DialogResult: Boolean; ResultValue: string);
    procedure ReleaseOggetti;Override;
    procedure GetTriggerT030;
    procedure ResultImpostaDatiDaDominio(Sender: TObject; PResult: TmeIWModalResult; PChiave: String);
  public
    Inserimento,ForzaCambioPsw:Boolean;
    procedure CaricaDBCombo;
    procedure lstElencoUsersResult(Sender: TObject; DialogResult: Boolean; ResultValue: string);
    procedure selAnagrafeResult(Sender: TObject; Result: Boolean);
  end;

implementation

uses
  WA186ULoginDipendentiDM,
  WA186ULoginDipendenti,
  WR100UBase,
  A001USSPIValidatePassword,
  WC700USelezioneAnagrafeFM;

{$R *.dfm}

procedure TWA186FLoginDipendentiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  TWA186FLoginDipendentiDM(WR302DM).selI060.Close;
  TWA186FLoginDipendentiDM(WR302DM).selI060.SetVariable('AZIENDA',dcmbAzienda.Text);
  TWA186FLoginDipendentiDM(WR302DM).selI060.Open;

  TWA186FLoginDipendentiDM(WR302DM).selI065P.Open;
  TWA186FLoginDipendentiDM(WR302DM).selI065U.Open;
  cmbExprUtente.ListSource:=TWA186FLoginDipendentiDM(WR302DM).dsrI065U;
  cmbExprPassword.ListSource:=TWA186FLoginDipendentiDM(WR302DM).dsrI065P;
  //attivazione gestione Tab JQuery
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);

  // tabella espressioni dizionario
  grdExrAccount.medpAttivaGrid(TWA186FLoginDipendentiDM(WR302DM).selI065,True,True);
  grdExrAccount.medpPreparaComponentiDefault;
  grdExrAccount.medpPreparaComponenteGenerico('WR102',grdExrAccount.medpIndexColonna('C_TIPO'),0,DBG_CMB,'20','','','','S');

  grdTabella.medpTestoNoRecord:='Nessun login';
  grdTabella.medpPaginazione:=True;
  grdTabella.medpRighePagina:=13;
  grdTabella.medpAggiornaCDS();
  TWA186FLoginDipendenti(Self.Owner).grdC700.WC700FM.ResultEvent:=selAnagrafeResult;
  lstDominio:=TStringList.Create;

  dcmbAzienda.ListSource:=TWA186FLoginDipendentiDM(WR302DM).D090;
  dcmbAzienda.KeyValue:=TWA186FLoginDipendentiDM(WR302DM).AziendaCorrente;
  lblDescAzienda.Caption:=VarToStr(TWA186FLoginDipendentiDM(WR302DM).QI090.LookUp('AZIENDA',TWA186FLoginDipendentiDM(WR302DM).AziendaCorrente,'DESCRIZIONE'));

  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('MATRICOLA'),1,DBG_IMG,'','AGGIORNA','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOME_UTENTE'),1,DBG_IMG,'','CAMBIADATO','','','D');
  if Parametri.I060_Password then
    grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_PASSWORD'),1,DBG_IMG,'','CAMBIADATO','','','D');
  CaricaDBCombo;

  GetParametriFunzione;

  // MONDOEDP - chiamata 85397.ini
  // bugfix: pulsante imbAnomalie disabilitato in avvio
  imbAnomalie.Enabled:=False;

  // caption pulsante btnTrigger da impostare in avvio
  GetTriggerT030;
  // MONDOEDP - chiamata 85397.fine

  imbModificaPassword.Enabled:=Parametri.I060_Password;
  btnDefault.Visible:=(Parametri.Azienda = 'AZIN') and (Parametri.Operatore = 'MONDOEDP');
end;

// MONDOEDP - chiamata 85397.ini
// caption pulsante btnTrigger da impostare in avvio
procedure TWA186FLoginDipendentiBrowseFM.GetTriggerT030;
begin
  if TWA186FLoginDipendentiDM(WR302DM).selUser_Triggers.fieldbyname('STATUS').AsString = 'ENABLED' then
  begin
    btnTrigger.Tag:=1;
    btnTrigger.Caption:='Disabilita Trigger';
  end
  else
  begin
    btnTrigger.Tag:=2;
    btnTrigger.Caption:='Abilita Trigger';
  end;
end;
// MONDOEDP - chiamata 85397.fine

procedure TWA186FLoginDipendentiBrowseFM.grdExrAccountComponenti2DataSet(Row: Integer);
begin
  inherited;
  TWA186FLoginDipendentiDM(WR302DM).selI065.FieldByName('C_TIPO').AsString:=TmeIWComboBox(grdExrAccount.medpCompCella(Row,grdExrAccount.medpIndexColonna('C_TIPO'),0)).Text;
  end;

procedure TWA186FLoginDipendentiBrowseFM.grdExrAccountDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWComboBox(grdExrAccount.medpCompCella(Row,grdExrAccount.medpIndexColonna('C_TIPO'),0)).Items.Add(' ');
  TmeIWComboBox(grdExrAccount.medpCompCella(Row,grdExrAccount.medpIndexColonna('C_TIPO'),0)).Items.Add('Password');
  TmeIWComboBox(grdExrAccount.medpCompCella(Row,grdExrAccount.medpIndexColonna('C_TIPO'),0)).Items.Add('Utente');
  TmeIWComboBox(grdExrAccount.medpCompCella(Row,grdExrAccount.medpIndexColonna('C_TIPO'),0)).ItemIndex:=StrToInt(ifthen(Row>0,IntToStr(TmeIWComboBox(grdExrAccount.medpCompCella(Row,grdExrAccount.medpIndexColonna('C_TIPO'),0)).Items.IndexOf(grdExrAccount.medpValoreColonna(Row,'C_TIPO'))),'0'));
end;

procedure TWA186FLoginDipendentiBrowseFM.grdExrAccountRenderCell(ACell: TIWGridCell; const ARow,AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=TmedpIWDBGrid(ACell.Grid).medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(TmedpIWDBGrid(ACell.Grid).medpCompGriglia) + 1) and (TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=TmedpIWDBGrid(ACell.Grid).medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.grdTabellaDataSet2Componenti(
  Row: Integer);
begin
  with TmeIWImageFile(grdTabella.medpCompCella(Row,'MATRICOLA',1)) do
  begin
    OnClick:=imgAggiornaClick;
    Tag:=Row;
  end;
  if VarToStr(TWA186FLoginDipendentiDM(WR302DM).QI090.Lookup('AZIENDA',TWA186FLoginDipendentiDM(WR302DM).AziendaCorrente,'DOMINIO_DIP')) <> '' then
  begin
    with TmeIWImageFile(grdTabella.medpCompCella(Row,'NOME_UTENTE',1)) do
    begin
      OnClick:=imgElencoUsers;
      Tag:=Row;
    end;
  end
  else
  TmeIWImageFile(grdTabella.medpCompCella(Row,'NOME_UTENTE',1)).Css:='invisibile';
  TmeIWEdit(grdTabella.medpCompCella(Row,'D_PASSWORD',0)).Enabled:=False;
  TmeIWEdit(grdTabella.medpCompCella(Row,'D_PASSWORD',0)).PasswordPrompt:=True;
  if Parametri.I060_Password then
    with TmeIWImageFile(grdTabella.medpCompCella(Row,'D_PASSWORD',1)) do
    begin
      OnClick:=imgCambioPasswordClick;
      Tag:=Row;
    end;
end;

procedure TWA186FLoginDipendentiBrowseFM.imgAggAnagrafeClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('FILTRO_ANAGRAFE',cmbFiltroAnagrafe.Text);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgAggDizionarioClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('FILTRO_DIZIONARIO',cmbFiltroDizionario.Text);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgAggFunzioniClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('FILTRO_FUNZIONI',cmbFiltroFunzioni.Text);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgAggiornaClick(Sender: TObject);
var row: Integer;
begin
  row:=TmeIWImageFile(Sender).Tag;
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selTabella.FieldByName('MATRICOLA').Value:=TmeIWEdit(grdTabella.medpCompCella(row,1,0)).Text;
    grdTabella.medpClientDataSet.Edit;
    grdTabella.medpClientDataSet.FieldByName('D_NOMINATIVO').Value:=selTabella.FieldByName('D_NOMINATIVO').Value;
    grdTabella.medpClientDataSet.Post;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.imgAggIterClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('ITER_AUTORIZZATIVI',cmbIterAutor.Text);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgAggPermessiClick(Sender: TObject);
begin
  inherited;
  AggiornaCampiI061('PERMESSI',cmbPermessi.Text);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgAnomalieClick(Sender: TObject);
var
  Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=WA186' + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';

  TWR100FBase(Self.Parent).AccediForm(201,Params);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgC700SelezioneAnagrafeClick(Sender: TObject);
begin
  inherited;
  TWA186FLoginDipendenti(Self.Owner).grdC700.actSelezioneAnagraficheExecute(nil);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgCambioPasswordClick(
  Sender: TObject);
begin
  if not Parametri.I060_Password then
    Exit;
  RowAffected:=TmeIWImageFile(Sender).Tag;
  WA186CambioPassword:=TWA186FLoginDipendentiCambioPasswordFM.Create(Self.Parent);
  WA186CambioPassword.lblPasswordAttuale.Visible:=False;
  WA186CambioPassword.edtPasswordAttuale.Visible:=False;
  WA186CambioPassword.lblScadenza.Visible:=Parametri.ValiditaPassword > 0;
  WA186CambioPassword.lblScadenza.Caption:='Scade il ' + DateToStr(R180AddMesi(Date,Parametri.ValiditaPassword));
  WA186CambioPassword.ResultEvent:=ResultCambioPassword;
  WA186CambioPassword.Visualizza(TWA186FLoginDipendentiDM(WR302DM).selTabella.FieldByName('PASSWORD').AsString,Parametri.LunghezzaPassword,TWA186FLoginDipendentiDM(WR302DM).QI090.FieldByName('DOMINIO_DIP').IsNull);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgCancellaLoginClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(Format(A000MSG_A186_DLG_FMT_ELIM_LOGIN,[IntToStr(TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.RecordCount)]),mtConfirmation,[mbYes,mbNo],ResultCancella,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.imgElencoUsers(Sender: TObject);
var Dominio:String;
begin

  if not (TWA186FLoginDipendentiDM(WR302DM).selTabella.State in [dsEdit,dsInsert]) then
    exit;
  Dominio:=VarToStr(TWA186FLoginDipendentiDM(WR302DM).QI090.Lookup('AZIENDA',TWA186FLoginDipendentiDM(WR302DM).AziendaCorrente,'DOMINIO_DIP'));
  if lstDominio.Count = 0 then
  begin
    A001GetUsers(lstDominio,A001GetDomainControllerName(Dominio));
    if lstDominio.Count = 0 then
      A001GetUsers(lstDominio,Dominio);
  end;
  RowAffected:=TmeIWImageFile(Sender).Tag;

  WC011:=TWC011FListBoxFM.Create(Self.Parent);
  WC011.ResultEvent:=lstElencoUsersResult;
  WC011.lstValori.Items.AddStrings(lstDominio);
  WC011.Visualizza('Utenti del dominio ' + Dominio);
end;

procedure TWA186FLoginDipendentiBrowseFM.imgInserisciLoginClick(Sender: TObject);
begin
  if trim(cmbFiltroFunzioni.Text) = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A186_ERR_FMT_DEFINIRE_FILTRO,['funzioni']),mtError,[mbOK],nil,'');
    exit;
  end;
  if trim(cmbPermessi.Text) = '' then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A186_ERR_FMT_DEFINIRE_FILTRO,['permessi']),mtError,[mbOK],nil,'');
    exit;
  end;
  MsgBox.WebMessageDlg(Format(A000MSG_A186_DLG_FMT_INS_LOGIN,[IntToStr(TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.RecordCount)]),mtConfirmation,[mbYes,mbNo],ResultInserimento,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultInserimento(Sender: TObject; R: TmeIWModalResult; KI: String);
var NLogin:Integer;
    // MONDOEDP - chiamata 85397.ini
    //Sysdate:TDateTime; // bugfix
    // MONDOEDP - chiamata 85397.fine
    ODS:TOracleDataSet;
begin
  if R = mrYes then
  begin
    NLogin:=0;
    with TWA186FLoginDipendentiDM(WR302DM) do
    begin
      RegistraMsg.IniziaMessaggio('WA186');
      TestExprLogin(ODS);
      try
        TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.First;
        while not TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.Eof do
        begin
          begin //???
            ODS.Close;
            ODS.SetVariable('MATRICOLA',TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString);
            ODS.Open;
            insI060.SetVariable('AZIENDA',AziendaCorrente);
            insI060.SetVariable('Matricola',TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString);
            insI060.SetVariable('NOMEUTENTE',ODS.FieldByName('EXPR_UTENTE').AsString);
            insI060.SetVariable('Password',R180Cripta(ODS.FieldByName('EXPR_PASSWORD').AsString,30011945));
            if chkForzaCambioPwd.Checked then
              insI060.SetVariable('DataPW',null)
            else
              insI060.SetVariable('DataPW',Date{Sysdate}); // MONDOEDP - chiamata 85397 - bugfix

            insI061.SetVariable('AZIENDA',AziendaCorrente);
            insI061.SetVariable('NOME_UTENTE',ODS.FieldByName('EXPR_UTENTE').AsString);
            InsI061.SetVariable('NOME_PROFILO',cmbNomeProfilo.Text);
            insI061.SetVariable('FILTRO_FUNZIONI',cmbFiltroFunzioni.Text);
            insI061.SetVariable('FILTRO_ANAGRAFE',cmbFiltroAnagrafe.Text);
            insI061.SetVariable('FILTRO_DIZIONARIO',cmbFiltroDizionario.Text);
            // MONDOEDP - chiamata 85397.ini
            // aggiunto dato filtro iter autorizzativi
            insI061.SetVariable('ITER_AUTORIZZATIVI',cmbIterAutor.Text);
            // MONDOEDP - chiamata 85397.fine
            insI061.SetVariable('PERMESSI',cmbPermessi.Text);
            insI061.SetVariable('INIZIO_VALIDITA',EncodeDate(1900,1,1));
            insI061.SetVariable('FINE_VALIDITA',EncodeDate(3999,12,31));
            try
              insI060.Execute;
            except
              on E:EOracleError do
                RegistraMsg.InserisciMessaggio('A','Inserimento login fallito: ' + E.Message,AziendaCorrente,TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger)
            end;
            try
              InsI061.Execute;
              inc(NLogin);
            except
              on E:EOracleError do
                RegistraMsg.InserisciMessaggio('A','Inserimento profilo fallito: ' + E.Message,AziendaCorrente,TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger)
            end;
          end; //???
          //ProgressBar1.StepBy(1);
          TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.Next;
        end;
      finally
        insI060.Session.Commit;
        FreeAndNil(ODS);
        //ProgressBar1.Position:=0;
       // TWA186FLoginDipendenti(Self.Parent).actAggiorna.Execute;
        selI061.Refresh;
        Screen.Cursor:=crDefault;
        TWA186FLoginDipendentiDM(WR302DM).selTabella.Refresh;
        grdTabella.medpAggiornaCDS;
        //NumRecords;
      end;
    end;
    imbAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    if (RegistraMsg.ContieneTipoA) then
      MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOMALIE_VIS,mtConfirmation,[mbYes,mbNo],ResultAnomalie,'')
    else
      MsgBox.WebMessageDlg(Format(A000MSG_MSG_FMT_ELAB_TERMINATA,[IntToStr(NLogin) + ' login inseriti']),mtInformation,[mbOK],nil,'');
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultModificaPassword(Sender: TObject; R: TmeIWModalResult; KI: String);
var NLogin:Integer;
    Sysdate:TDateTime;
    ODS:TOracleDataSet;
    NuovaPwd: String;
begin
  if R = mrYes then
  begin
    NLogin:=0;
    with TWA186FLoginDipendentiDM(WR302DM) do
    begin
      TestExprLogin(ODS);
      try
        UpdI060.SetVariable('AZIENDA',AziendaCorrente);
        selTabella.First;
        while not selTabella.Eof do
        begin
          begin //???
            ODS.Close;
            ODS.SetVariable('MATRICOLA',selTabella.FieldByName('MATRICOLA').AsString);
            ODS.Open;
            NuovaPwd:=R180Cripta(ODS.FieldByName('EXPR_PASSWORD').AsString,30011945);
            if chkForzaCambioPwd.Checked then
              UpdI060.SetVariable('DATAPW',null)
            else
              UpdI060.SetVariable('DATAPW',Date);
            UpdI060.SetVariable('NOME_UTENTE',selTabella.FieldByName('NOME_UTENTE').AsString);
            UpdI060.SetVariable('PASSWORD_NEW',NuovaPwd);
            try
              // effettua update e registra log (cfr. evento OnAfterQuery!)
              UpdI060.Execute;
              inc(NLogin);
            except
              on E:EOracleError do
                RegistraMsg.InserisciMessaggio('A',Format('Modifica password del login %s: %s',[selTabella.FieldByName('NOME_UTENTE').AsString,E.Message]),selI090.FieldByName('AZIENDA').AsString);
            end;
            selTabella.Next;
          end; //???
          TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.Next;
        end;
      finally
        UpdI060.Session.Commit;
        FreeAndNil(ODS);
        TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.First;
        //TWA186FLoginDipendenti(Self.Parent).actAggiorna.Execute;
        selI061.Refresh;
        Screen.Cursor:=crDefault;
      end;
    end;
    imbAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    if (RegistraMsg.ContieneTipoA) then
      MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOMALIE_VIS,mtConfirmation,[mbYes,mbNo],ResultAnomalie,'')
    else
      MsgBox.WebMessageDlg(Format(A000MSG_MSG_FMT_ELAB_TERMINATA,[IntToStr(NLogin) + ' login modificati']),mtInformation,[mbOK],nil,'');
    grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultTrigger(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    try
      if btnTrigger.Tag = 2 then
      begin
        with  TWA186FLoginDipendentiDM(WR302DM).OperSQL do
        begin
          SQL.Clear;
          SQL.Add('ALTER TRIGGER T030_AFTERINS_I060 ENABLE');
          Execute;
        end;
        btnTrigger.Caption:='Disabilita Trigger';
        btnTrigger.Tag:=1;
      end
      else
      begin
        with  TWA186FLoginDipendentiDM(WR302DM).OperSQL do
        begin
          SQL.Clear;
          SQL.Add('ALTER TRIGGER T030_AFTERINS_I060 DISABLE');
          Execute;
        end;
        btnTrigger.Caption:='Abilita Trigger';
        btnTrigger.Tag:=2;
    end;
    finally
      TWA186FLoginDipendentiDM(WR302DM).OperSQL.Session:=TWA186FLoginDipendentiDM(WR302DM).DbIris008B;
    end;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultValoriDefault(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    with TWA186FLoginDipendentiDM(WR302DM).OperSQL do
    begin
      try
        SQL.Clear;
        if cmbFiltroFunzioni.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_FUNZIONI DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_FUNZIONI DEFAULT ''%s''',[cmbFiltroFunzioni.Text]));
        Execute;
        SQL.Clear;
        if cmbFiltroDizionario.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_DIZIONARIO DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY FILTRO_DIZIONARIO DEFAULT ''%s''',[cmbFiltroDizionario.Text]));
        Execute;
        SQL.Clear;
        if cmbPermessi.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY PERMESSI DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY PERMESSI DEFAULT ''%s''',[cmbPermessi.Text]));
        SQL.Clear;
        if cmbIterAutor.Text = '' then
          SQL.Add('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY ITER_AUTORIZZATIVI DEFAULT NULL')
        else
          SQL.Add(Format('ALTER TABLE MONDOEDP.I061_PROFILI_DIPENDENTE MODIFY ITER_AUTORIZZATIVI DEFAULT ''%s''',[cmbIterAutor.Text]));
        Execute;
        MsgBox.WebMessageDlg('Valori di default applicati correttamente.',mtInformation,[mbOK],nil,'');
      except
        raise exception.create('Errore nell''applicazione dei valori di default.');
      end;
    end;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultAggiornaCampi(Sender: TObject; R: TmeIWModalResult; KI: String);
var I061PrevStat:Boolean;
    RowIDPrev:String;
begin
  if R = mrYes then
  begin
      if Trim(cmbNomeProfilo.Text) = '' then
      begin
        MsgBox.WebMessageDlg('Specificare il nome del profilo d''aggiornare.',mtInformation,[mbOK],nil,'');
        Exit;
      end;
      with TWA186FLoginDipendentiDM(WR302DM) do
      begin
        selTabella.DisableControls;
        RowIDPrev:=selTabella.RowID;
        selTabella.First;
        while Not selTabella.Eof do
        begin
          selI061.First;
          I061PrevStat:=selI061.ReadOnly;
          selI061.ReadOnly:=False;
          try
            while Not selI061.Eof do
            begin
              if selI061.FieldByName('NOME_PROFILO').AsString = cmbNomeProfilo.Text then
              begin
                selI061.Edit;
                selI061.FieldByName(CampoUpdate).AsString:=ValUpdate;
                selI061.Post;
                SessioneOracle.ApplyUpdates([selI061],True);
              end;
              selI061.Next;
            end;
          finally
            selI061.ReadOnly:=I061PrevStat;
          end;
          selTabella.Next;
        end;
        selTabella.SearchRecord('ROWID',RowIDPrev,[srFromBeginning]);
        selTabella.EnableControls;
      end;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultAnomalie(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    imgAnomalieClick(Nil)
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultCancella(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  NLogin: integer;
begin
  if R = mrYes then
  begin
    NLogin:=0;
    with TWA186FLoginDipendentiDM(WR302DM) do
    begin
     // MONDOEDP - chiamata 85397.ini
     // spostato dall'interno del ramo if
     RegistraMsg.IniziaMessaggio('WA186');
     // MONDOEDP - chiamata 85397.fine
     if (trim(cmbNomeProfilo.Text) = '') and
        (trim(cmbPermessi.Text) = '') and
        (trim(cmbFiltroAnagrafe.Text) = '') and
        (trim(cmbFiltroFunzioni.Text) = '') and
        (trim(cmbIterAutor.Text) = '') and // MONDOEDP - chiamata 85397: bugfix
        (trim(cmbFiltroDizionario.Text) = '') then
     begin
        // MONDOEDP - chiamata 85397.ini
        // spostato sopra
        // RegistraMsg.IniziaMessaggio('WA186');
        // MONDOEDP - chiamata 85397.fine
        while not TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.Eof do
        begin
          delI060.SetVariable('Azienda',AziendaCorrente);
          delI060.SetVariable('Matricola',TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString);
          try
            delI060.Execute;
            if delI060.RowsProcessed > 0 then
              inc(NLogin);
          except
            on E:EOracleError do
              RegistraMsg.InserisciMessaggio('A','Login: ' + E.Message,AziendaCorrente,TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
          end;
          TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.Next;
        end;
        delI060.Session.Commit;
      end
      else
      begin
        (* Commentato da Massimo 06/12/2012
        TWA186FLoginDipendenti(Self.Owner).WC700DM.selAnagrafe.Close;
        TWA186FLoginDipendenti(Self.Owner).WC700DM.selAnagrafe.SQL.Text:='select * from T030_ANAGRAFICO where MATRICOLA like ''PA%''';
        TWA186FLoginDipendenti(Self.Owner).WC700DM.selAnagrafe.Open;
        *)
        // MONDOEDP - chiamata 85397.ini
        // bugfix: necessario riposizionamento su primo record anagrafico
        TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.First;
        // MONDOEDP - chiamata 85397.fine
        while not TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.Eof do
        begin
          delI060Filtri.SetVariable('Azienda',AziendaCorrente);
          delI060Filtri.SetVariable('Matricola',TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('MATRICOLA').AsString);
          delI060Filtri.SetVariable('NomeProfilo',Trim(cmbNomeProfilo.Text));
          delI060Filtri.SetVariable('Permessi',trim(cmbPermessi.Text));
          delI060Filtri.SetVariable('FiltroAnagrafe',trim(cmbFiltroAnagrafe.Text));
          delI060Filtri.SetVariable('FiltroFunzioni',trim(cmbFiltroFunzioni.Text));
          delI060Filtri.SetVariable('ITER_AUTORIZZATIVI',trim(cmbIterAutor.Text)); // MONDOEDP - chiamata 85397: bugfix
          delI060Filtri.SetVariable('FiltroDizionario',trim(cmbFiltroDizionario.Text));
          try
            delI060Filtri.Execute;
            // MONDOEDP - chiamata 85397.ini
            // la property RowsProcessed contiene un valore non coerente
            // lo script estrae ora in una variabile il numero di righe eliminate da I060
            //if delI060Filtri.RowsProcessed > 0 then
            if StrToInt(VarToStr(delI060Filtri.GetVariable('RECORD_ELIMINATI'))) > 0 then
            // MONDOEDP - chiamata 85397.fine
            begin
              inc(NLogin);
            end;
          except
            on E:EOracleError do
              RegistraMsg.InserisciMessaggio('A','Login: ' + E.Message,AziendaCorrente,TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
          end;
          TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.Next;
        end;
        delI060Filtri.Session.Commit;
      end;
    end;
    Screen.Cursor:=crDefault;
    Screen.Cursor:=crHourGlass;
    TWA186FLoginDipendenti(Self.Parent).actAggiorna.Execute;
    TWA186FLoginDipendentiDM(WR302DM).selI061.Refresh;
    //TWA186FLoginDipendentiDM(WR302DM).selTabella.Refresh;
    Screen.Cursor:=crDefault;
    imbAnomalie.Enabled:=(RegistraMsg.ContieneTipoA);
   // grdTabella.medpAggiornaCDS;
    if (RegistraMsg.ContieneTipoA) then
      MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOMALIE_VIS,mtConfirmation,[mbYes,mbNo],ResultAnomalie,'')
    else
      MsgBox.WebMessageDlg(Format(A000MSG_MSG_FMT_ELAB_TERMINATA,[IntToStr(NLogin) + ' login eliminati']),mtInformation,[mbOK],nil,'');
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultCancellaProfili(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  Trovato:Boolean;
  NProfili:Integer;
begin
  if R = mrYes then
  begin
    NProfili:=0;
    with TWA186FLoginDipendentiDM(WR302DM) do
    begin
      SelTabella.First;
      delI060.SetVariable('AZIENDA',AziendaCorrente);
      RegistraMsg.IniziaMessaggio('A008');
      RegistraMsg.InserisciMessaggio('I','Cancellazione login');
      while not SelTabella.Eof do
      begin
        if chkApplicaFiltro.Checked then
        begin
          Trovato:=True;
          if (trim(cmbNomeProfilo.Text) <> '') and (not selI061.SearchRecord('NOME_PROFILO',trim(cmbNomeProfilo.Text),[srFromBeginning])) then
            Trovato:=False
          else if (trim(cmbPermessi.Text) <> '') and (not selI061.SearchRecord('PERMESSI',trim(cmbPermessi.Text),[srFromBeginning])) then
            Trovato:=False
          else if (trim(cmbFiltroAnagrafe.Text) <> '') and (not selI061.SearchRecord('FILTRO_ANAGRAFE',trim(cmbFiltroAnagrafe.Text),[srFromBeginning])) then
            Trovato:=False
          else if (trim(cmbFiltroFunzioni.Text) <> '') and (not selI061.SearchRecord('FILTRO_FUNZIONI',trim(cmbFiltroFunzioni.Text),[srFromBeginning])) then
            Trovato:=False
          else if (trim(cmbIterAutor.Text) <> '') and (not selI061.SearchRecord('ITER_AUTORIZZATIVI',trim(cmbIterAutor.Text),[srFromBeginning])) then
            Trovato:=False
          else if (trim(cmbFiltroDizionario.Text) <> '') and (not selI061.SearchRecord('FILTRO_DIZIONARIO',trim(cmbFiltroDizionario.Text),[srFromBeginning])) then
            Trovato:=False;
          if Trovato then
          begin
            selI061.Delete;
            selI061.Session.ApplyUpdates([selI061],True);
            inc(NProfili);
          end;
        end;
        selTabella.Next;
      end;
    end;
    imbAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
    if (RegistraMsg.ContieneTipoA) then
      MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOMALIE_VIS,mtConfirmation,[mbYes,mbNo],ResultAnomalie,'')
    else
      MsgBox.WebMessageDlg(Format(A000MSG_MSG_FMT_ELAB_TERMINATA,[IntToStr(NProfili) + ' profili eliminati.']),mtInformation,[mbOK],nil,'');

    TWA186FLoginDipendentiDM(WR302DM).selTabella.Refresh;
    grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.imgModificaPasswordClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(Format(A000MSG_A186_DLG_FMT_UPD_PWD,[IntToStr(TWA186FLoginDipendentiDM(WR302DM).selTabella.RecordCount)]),mtConfirmation,[mbYes,mbNo],ResultModificaPassword,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.selAnagrafeResult(Sender: TObject; Result: Boolean);
begin
  if Result then
  begin
    with TWA186FLoginDipendentiDM(WR302DM) do
    begin
      selTabella.Close;
      TWA186FLoginDipendenti(Self.Owner).grdC700.WC700FM.C700MergeSelAnagrafe(selTabella);
      TWA186FLoginDipendenti(Self.Owner).grdC700.WC700FM.C700MergeSettaPeriodo(selTabella,Parametri.DataLavoro,Parametri.DataLavoro);
      selTabella.Open;
      grdTabella.medpAggiornaCDS;
    end;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.SettaFiltroProfili;
var Cambiato:Boolean;
begin
  Cambiato:=False;
  with TWA186FLoginDipendentiDM(WR302DM).FiltroProfiliI061 do
  begin
    if (NomeProfilo <> cmbNomeProfilo.Text) or
       (Permessi <> cmbPermessi.Text) or
       (FiltroAnagrafe <> cmbFiltroAnagrafe.Text) or
       (FiltroFunzioni <> cmbFiltroFunzioni.Text) or
       (IterAutorizzativi <> cmbIterAutor.Text) or
       (FiltroDizionario <> cmbFiltroDizionario.Text) then
      Cambiato:=True;
    NomeProfilo:=cmbNomeProfilo.Text;
    Permessi:=cmbPermessi.Text;
    FiltroAnagrafe:=cmbFiltroAnagrafe.Text;
    FiltroFunzioni:=cmbFiltroFunzioni.Text;
    IterAutorizzativi:=cmbIterAutor.Text;
    FiltroDizionario:=cmbFiltroDizionario.Text;
    if Attivo <> chkApplicaFiltro.Checked then
    begin
      Attivo:=chkApplicaFiltro.Checked;
      TWA186FLoginDipendentiDM(WR302DM).I060SettaFiltroI061;
    end
    else if Attivo and Cambiato then
      TWA186FLoginDipendentiDM(WR302DM).I060SettaFiltroI061;
    grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.lstElencoUsersResult(Sender: TObject;
  DialogResult: Boolean; ResultValue: string);
begin
  if DialogResult then
    (grdTabella.medpCompCella(RowAffected,'NOME_UTENTE',0) as TmeIWEdit).Text:=ResultValue;
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultCambioPassword(Sender: TObject;
  DialogResult: Boolean; ResultValue: string);
begin
  // in caso di conferma cambio password assegna il nuovo valore al campo corrispondente
  if DialogResult then
  begin
    (grdTabella.medpCompCella(RowAffected,'D_PASSWORD',0) as TmeIWEdit).Text:=ResultValue;
    // MONDOEDP - chiamata 85397.ini
    // bugfix: il dato password non veniva impostato
    TWA186FLoginDipendentiDM(WR302DM).selTabella.FieldByName('PASSWORD').AsString:=ResultValue;
    // MONDOEDP - chiamata 85397.fine
  end;
end;

// MONDOEDP - chiamata 85397.ini
// eliminato: v. evento onclick
{
procedure TWA186FLoginDipendentiBrowseFM.chkApplicaFiltroChange(Sender: TObject);
begin
  PutParametriFunzione;
end;
}
// MONDOEDP - chiamata 85397.fine

procedure TWA186FLoginDipendentiBrowseFM.chkApplicaFiltroClick(Sender: TObject);
begin
  SettaFiltroProfili;
  PutParametriFunzione;
end;

procedure TWA186FLoginDipendentiBrowseFM.chkForzaCambioPwdChange(Sender: TObject);
begin
  PutParametriFunzione;
end;

procedure TWA186FLoginDipendentiBrowseFM.cmbExprPasswordChange(Sender: TObject);
begin
  inherited;
  if TWA186FLoginDipendentiDM(WR302DM).selI065P.SearchRecord('CODICE',cmbExprPassword.Text,[srFromBeginning]) then
    cmbExprPassword.Hint:=StringReplace(TWA186FLoginDipendentiDM(WR302DM).selI065P.FieldByName('ESPRESSIONE').AsString,'||','+',[rfReplaceAll])
  else
    cmbExprPassword.Hint:='';
  PutParametriFunzione;
end;

procedure TWA186FLoginDipendentiBrowseFM.cmbExprUtenteChange(Sender: TObject);
begin
  inherited;
  if TWA186FLoginDipendentiDM(WR302DM).selI065U.SearchRecord('CODICE',cmbExprUtente.Text,[srFromBeginning]) then
    cmbExprUtente.Hint:=StringReplace(TWA186FLoginDipendentiDM(WR302DM).selI065U.FieldByName('ESPRESSIONE').AsString,'||','+',[rfReplaceAll])
  else
    cmbExprUtente.Hint:='';
  PutParametriFunzione;
end;

procedure TWA186FLoginDipendentiBrowseFM.dcmbAziendaChange(Sender: TObject);
begin
  inherited;
  if TWA186FLoginDipendentiDM(WR302DM).QI090.SearchRecord('AZIENDA',dcmbAzienda.Text,[srFromBeginning]) then
  begin
    with TWA186FLoginDipendentiDM(WR302DM) do
    begin
      lblDescAzienda.Caption:=QI090.FieldByName('DESCRIZIONE').AsString;
      lstDominio.Clear;
      CambiaDataBase;
    end;
    grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(lstDominio);
end;

procedure TWA186FLoginDipendentiBrowseFM.actScaricaInExcelClick(Sender: TObject);
begin
  try
    TWA186FLoginDipendentiDM(WR302DM).selTabella.AfterScroll:=nil;
    inherited;
  finally
    TWA186FLoginDipendentiDM(WR302DM).selTabella.AfterScroll:=TWA186FLoginDipendentiDM(WR302DM).AfterScroll;
    TWA186FLoginDipendentiDM(WR302DM).selTabella.AfterScroll(TWA186FLoginDipendentiDM(WR302DM).selTabella);
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.AggiornaCampiI061(campo,val: String);
begin
  campoUpdate:=campo;
  ValUpdate:=val;
  MsgBox.WebMessageDlg('Vuoi aggiornare "' + LowerCase(campoUpdate) + '" con il nuovo valore?',mtConfirmation,[mbYes,mbNo],ResultAggiornaCampi,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.btnCancellaProfiliClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(Format(A000MSG_A186_DLG_ELIM_PROFILI,[IntToStr(TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.RecordCount)]),mtConfirmation,[mbYes,mbNo],ResultCancellaProfili,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.btnDefaultClick(Sender: TObject);
begin
  MsgBox.WebMessageDlg(Format(A000MSG_A186_DLG_VAL_DEFAULT,[IntToStr(TWA186FLoginDipendenti(Self.Owner).grdC700.selAnagrafe.RecordCount)]),mtConfirmation,[mbYes,mbNo],ResultValoriDefault,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.imbImpostaDatiDaDominioClick(Sender: TObject);
// imposta alcuni dati dell'account leggendo le informazioni da active directory:
// - email
begin
  // se il dominio non è impostato esce subito
  if TWA186FLoginDipendentiDM(WR302DM).QI090.FieldByName('DOMINIO_DIP').AsString = '' then
  begin
    MsgBox.MessageBox('Il dominio di autenticazione per i dipendenti web non è indicato!',INFORMA);
    Exit;
  end;

  // se la sincronizzazione dati non è attiva esce subito
  if Parametri.CampiRiferimento.C90_EmailSincrDominio <> 'S' then
  begin
    MsgBox.MessageBox('La sincronizzazione dei dati con Active Directory non è attiva!',INFORMA);
    Exit;
  end;

  // se non ci sono account selezionati esce subito
  if WR302DM.selTabella.RecordCount = 0 then
  begin
    MsgBox.MessageBox('Nessun account selezionato: verificare la selezione anagrafica!',INFORMA);
    Exit;
  end;

  // richiesta conferma
  MsgBox.WebMessageDlg('Si desidera impostare la mail degli account selezionati'#13#10 +
                       'utilizzando le informazioni estratte da Active Directory?',
                       mtConfirmation,[mbYes,mbNo],ResultImpostaDatiDaDominio,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.ResultImpostaDatiDaDominio(Sender: TObject; PResult: TmeIWModalResult; PChiave: String);
begin
  if PResult = mrNo then
    Exit;

  // esegue l'impostazione massiva dei dati
  // imposta i dati da active directory
  // (al momento solo la mail)
  TWA186FLoginDipendentiDM(WR302DM).ImpostaDatiAccountDaDominio;

  // verifica risultato elaborazione
  imbAnomalie.Enabled:=RegistraMsg.ContieneAnomalie;
  if (RegistraMsg.ContieneAnomalie) then
    MsgBox.WebMessageDlg(A000MSG_DLG_ELAB_ANOMALIE_VIS,mtConfirmation,[mbYes,mbNo],ResultAnomalie,'')
  else
    MsgBox.MessageBox(A000MSG_MSG_ELAB_TERMINATA_OK,INFORMA);
end;

procedure TWA186FLoginDipendentiBrowseFM.btnTriggerClick(Sender: TObject);
var S:String;
begin
  TWA186FLoginDipendentiDM(WR302DM).OperSQL.Session:=TWA186FLoginDipendentiDM(WR302DM).DbIris008B;

  if btnTrigger.Tag = 2 then
    S:=Format(A000MSG_A186_DLG_FMT_TRIG_060,['Attivare'])
  else
    S:=Format(A000MSG_A186_DLG_FMT_TRIG_060,['Disattivare']);

  MsgBox.WebMessageDlg(S,mtConfirmation,[mbYes,mbNo],ResultTrigger,'');
end;

procedure TWA186FLoginDipendentiBrowseFM.CaricaCmbNomiProfili;
var Index:integer;
begin
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    selI061Dist.Close;
    selI061Dist.SetVariable('AZIENDA',AziendaCorrente);
    selI061Dist.Open;
    cmbNomeProfilo.Items.Clear;
    selI061Dist.First;
    while Not selI061Dist.Eof do
    begin
      cmbNomeProfilo.Items.Add(selI061Dist.FieldByName('NOME_PROFILO').AsString);
      selI061Dist.Next;
    end;
    cmbNomeProfilo.ItemIndex:=-1;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.CaricaDBCombo;
begin
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    CaricaCmbNomiProfili;
    cmbPermessi.Items.Clear;
    cmbFiltroAnagrafe.Items.Clear;
    cmbFiltroFunzioni.Items.Clear;
    cmbIterAutor.Items.Clear;
    cmbFiltroDizionario.Items.Clear;
    selI071.First;
    while not selI071.Eof do
    begin
      cmbPermessi.Items.Add(selI071.FieldByName('PROFILO').AsString);
      selI071.Next;
    end;
    selI072Dist.First;
    while not selI072Dist.Eof do
    begin
      cmbFiltroAnagrafe.Items.Add(selI072Dist.FieldByName('PROFILO').AsString);
      selI072Dist.Next;
    end;
    selI073Dist.First;
    while not selI073Dist.Eof do
    begin
      cmbFiltroFunzioni.Items.Add(selI073Dist.FieldByName('PROFILO').AsString);
      selI073Dist.Next;
    end;
    selI074Dist.First;
    while not selI074Dist.Eof do
    begin
      cmbFiltroDizionario.Items.Add(selI074Dist.FieldByName('PROFILO').AsString);
      selI074Dist.Next;
    end;
    selI075Dist.First;
    while not selI075Dist.Eof do
    begin
      cmbIterAutor.Items.Add(selI075Dist.FieldByName('PROFILO').AsString);
      selI075Dist.Next;
    end;

    cmbPermessi.ItemIndex:=-1;
    cmbFiltroAnagrafe.ItemIndex:=-1;
    cmbFiltroFunzioni.ItemIndex:=-1;
    cmbIterAutor.ItemIndex:=-1;
    cmbFiltroDizionario.ItemIndex:=-1;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.TestExprLogin(var ODS:TOracleDataSet);
var ExprUtente,ExprPasswd:String;
begin
  with TWA186FLoginDipendentiDM(WR302DM) do
  begin
    ExprUtente:=VarToStr(selI065U.Lookup('CODICE',cmbExprUtente.Text,'ESPRESSIONE'));
    ExprPasswd:=VarToStr(selI065P.Lookup('CODICE',cmbExprPassword.Text,'ESPRESSIONE'));
    ODS:=TOracleDataset.Create(nil);
    ODS.Session:=SessioneOracle;
    ODS.SQL.Text:='SELECT :EXPR_UTENTE EXPR_UTENTE,:EXPR_PASSWORD EXPR_PASSWORD FROM T030_ANAGRAFICO T030,V430_STORICO V430 WHERE T030.PROGRESSIVO = T430PROGRESSIVO AND TO_DATE(''31123999'',''DDMMYYYY'')'+
                  ' BETWEEN T430DATADECORRENZA AND T430DATAFINE AND T030.MATRICOLA = :MATRICOLA';
    ODS.DeclareVariable('MATRICOLA',otString);
    ODS.DeclareVariable('EXPR_UTENTE',otSubst);
    ODS.DeclareVariable('EXPR_PASSWORD',otSubst);
    if Trim(cmbExprUtente.Text) = '' then
      ODS.SetVariable('EXPR_UTENTE','MATRICOLA')
    else
      ODS.SetVariable('EXPR_UTENTE',ExprUtente);
    if Trim(cmbExprPassword.Text) = '' then
      ODS.SetVariable('EXPR_PASSWORD','NULL')
    else
      ODS.SetVariable('EXPR_PASSWORD',ExprPasswd);
    ODS.SetVariable('MATRICOLA',null);
    try
      ODS.Open;
    except
      on E:Exception do
        raise Exception.Create('Le espressioni indicate per l''utente e la password non sono valide!' + #13#10 + E.Message);
    end;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  with (Self.Owner as TWR100FBase).C004DM do
  begin
    Cancella001;
    if chkForzaCambioPwd.Checked then
      PutParametro('DIP_PASSWORD','S')
    else
      PutParametro('DIP_PASSWORD','N');
    if chkApplicaFiltro.Checked then
      PutParametro('DIP_FILTRO','S')
    else
      PutParametro('DIP_FILTRO','N');
    PutParametro('EXPR_UTENTE',cmbExprUtente.Text);
    PutParametro('EXPR_PASSWORD',cmbExprPassword.Text);
    PutParametro('DIP_PERMESSI',cmbPermessi.Text);
    PutParametro('DIP_ANAGRAFE',cmbFiltroAnagrafe.Text);
    PutParametro('DIP_FUNZIONI',cmbFiltroFunzioni.Text);
    PutParametro('DIP_DIZIONARIO',cmbFiltroDizionario.Text);
    PutParametro('DIP_NOMEPROFILO',cmbNomeProfilo.Text);
    PutParametro('DIP_ITERAUTOR',cmbIterAutor.Text);
    try SessioneOracle.Commit; except end;
  end;
end;

procedure TWA186FLoginDipendentiBrowseFM.GetParametriFunzione;
{Leggo i parametri della form}
begin
  with (Self.Owner as TWR100FBase).C004DM do
  begin
    chkForzaCambioPwd.Checked:=GetParametro('DIP_PASSWORD','N') = 'S';
    chkApplicaFiltro.Checked:=GetParametro('DIP_FILTRO','N') = 'S';
    cmbExprUtente.KeyValue:=GetParametro('EXPR_UTENTE','');
    cmbExprPassword.KeyValue:=GetParametro('EXPR_PASSWORD','');
    cmbPermessi.ItemIndex:=cmbPermessi.Items.IndexOf(GetParametro('DIP_PERMESSI',''));
    cmbFiltroAnagrafe.ItemIndex:=cmbFiltroAnagrafe.Items.IndexOf(GetParametro('DIP_ANAGRAFE',''));
    cmbFiltroFunzioni.ItemIndex:=cmbFiltroFunzioni.Items.IndexOf(GetParametro('DIP_FUNZIONI',''));
    cmbFiltroDizionario.ItemIndex:=cmbFiltroDizionario.Items.IndexOf(GetParametro('DIP_DIZIONARIO',''));
    cmbNomeProfilo.ItemIndex:=cmbNomeProfilo.Items.IndexOf(GetParametro('DIP_NOMEPROFILO','')); // bugfix
    cmbIterAutor.ItemIndex:=cmbIterAutor.Items.IndexOf(GetParametro('DIP_ITERAUTOR',''));
  end;
end;

end.
