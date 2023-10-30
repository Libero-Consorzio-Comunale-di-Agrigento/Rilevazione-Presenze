unit A040UPianifRep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ExtCtrls, Grids, Spin, DBCGrids, Math,
  DB, DBGrids, OracleData, DBCtrls, Buttons, ActnList, ImgList, ToolWin, Variants,
  A000UCostanti, A000USessione, A000UInterfaccia, A083UMsgElaborazioni, B021UWebSvcClientDtM,
  C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe,
  R001UGestTab, RegistrazioneLog, SelAnagrafe, StrUtils, A000UMessaggi,
  System.Actions, System.ImageList;

type
  TA040FPianifRep = class(TR001FGestTab)
    Panel2: TPanel;
    EMese: TSpinEdit;
    Label3: TLabel;
    EAnno: TSpinEdit;
    Label4: TLabel;
    ScrollBox3: TScrollBox;
    dGrdPianif: TDBGrid;
    Label5: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkNonContDipPian: TCheckBox;
    actGestioneMensile: TAction;
    GestioneMensile1: TMenuItem;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    Gestionemensile2: TMenuItem;
    actAcquisizioneTurni: TAction;
    Acquisizioneturni1: TMenuItem;
    actVisualizzaAnomalie: TAction;
    ProgressBar1: TProgressBar;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    chkRecapitiAlternativi: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EAnnoChange(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure dGrdPianifCellClick(Column: TColumn);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure dGrdPianifDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actGestioneMensileExecute(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure actAcquisizioneTurniExecute(Sender: TObject);
    procedure actVisualizzaAnomalieExecute(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure chkRecapitiAlternativiClick(Sender: TObject);
  private
    { Private declarations }
    procedure RefreshListaDatoLibero(Data:TDateTime);
    procedure VisualizzaColonneRecapiti;
  public
    { Public declarations }
    DataRif:TDateTime;
    DocumentoPDF,TipoModulo,MessaggioDCOM: string;
  end;

var
  A040FPianifRep: TA040FPianifRep;

procedure OpenA040PianifRep(Prog:LongInt;Tipologia:String;DataIn:TDateTime = 0);

implementation

uses A040UPianifRepDtM1,A040UInserimento,A040UStampa,A040UDialogStampa,
     A040UPianifRepDtM2,A040UStampa2;

{$R *.DFM}

procedure OpenA040PianifRep(Prog:LongInt;Tipologia:String;DataIn:TDateTime = 0);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  if Tipologia = 'REPERIB' then
    case A000GetInibizioni('Funzione','OpenA040PianifRep') of
      'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          SolaLettura:=SolaLetturaOriginale;
          Exit;
          end;
      'R':SolaLettura:=True;
    end
  else
    case A000GetInibizioni('Funzione','OpenA040PianifGuardia') of
      'N':begin
          ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
          SolaLettura:=SolaLetturaOriginale;
          Exit;
          end;
      'R':SolaLettura:=True;
    end;
  A040FPianifRep:=TA040FPianifRep.Create(nil);
  with A040FPianifRep do
  try
    DataRif:=DataIn;

    A040FPianifRepDtM1:=TA040FPianifRepDtM1.Create(nil);
    with A040FPianifRepDtM1.A040MW do
    begin
      CodTipologia:=IfThen(Tipologia = 'REPERIB','R','G');
      ImpostaTipologiaDataSet;
    end;
    C700Progressivo:=Prog;
    actGestioneMensile.Enabled:=not SolaLettura;
    A040FPianifRepDtM1.selT380.ReadOnly:=SolaLettura;
    A040FPianifRepDtM2:=TA040FPianifRepDtM2.Create(nil);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A040FPianifRepDtM1);
    FreeAndNil(A040FInserimento);
    FreeAndNil(A040FStampa);
    FreeAndNil(A040FDialogStampa);
    FreeAndNil(A040FPianifRepDtM2);
    FreeAndNil(A040FStampa2);
    Free;
  end;
end;

procedure TA040FPianifRep.FormCreate(Sender: TObject);
begin
  inherited;
  TipoModulo:='CS';
  MessaggioDCOM:='';
  Application.HintPause:=100;
  Application.HintHidePause:=6000;
  A040FInserimento:=TA040FInserimento.Create(nil);
  A040FDialogStampa:=TA040FDialogStampa.Create(nil);
  A040FStampa:=TA040FStampa.Create(nil);
  A040FStampa2:=TA040FStampa2.Create(nil);
end;

procedure TA040FPianifRep.FormActivate(Sender: TObject);
begin
  DButton.DataSet:=A040FPianifRepDtM1.selT380;
  inherited;
end;

procedure TA040FPianifRep.FormShow(Sender: TObject);
var c,c1,c2,c3,cDL:Integer;
begin
  inherited;
  A040FStampa.QRLTitolo.Caption:='Turni ' + A040FPianifRepDtM1.A040MW.sTipo + ' mensile';
  A040FPianifRepDtM1.A040MW.PaperSizeStampa:=A040FStampa.RepR.Page.PaperSize;
  A040FPianifRepDtM1.A040MW.PaperSizeStampa2:=A040FStampa2.QRep.Page.PaperSize;
  if TipoModulo <> 'COM' then
  begin
    A040FPianifRep.Caption:='<A040> Pianificazione turni ' + A040FPianifRepDtM1.A040MW.sTipo;
    A040FDialogStampa.Caption:='<A040> Stampa turni ' + A040FPianifRepDtM1.A040MW.sTipo + ' mensile';
    c:=R180GetColonnaDBGrid(dGrdPianif,'PRIORITA1');
    dGrdPianif.Columns[c].Visible:=A040FPianifRepDtM1.A040MW.CodTipologia = 'R';
    c:=R180GetColonnaDBGrid(dGrdPianif,'PRIORITA2');
    dGrdPianif.Columns[c].Visible:=A040FPianifRepDtM1.A040MW.CodTipologia = 'R';
    c:=R180GetColonnaDBGrid(dGrdPianif,'PRIORITA3');
    dGrdPianif.Columns[c].Visible:=A040FPianifRepDtM1.A040MW.CodTipologia = 'R';
    chkRecapitiAlternativi.Visible:=A040FPianifRepDtM1.A040MW.CodTipologia = 'R';
    VisualizzaColonneRecapiti;
    Self.Width:=Self.Width + IfThen(A040FPianifRepDtM1.A040MW.CodTipologia = 'R', dGrdPianif.Columns[c].Width * 3, 0);
    A040FPianifRepDtM1.A040MW.VisualizzaCampi;

    // caricamento picklist TURNI della griglia
    c1:=R180GetColonnaDBGrid(dGrdPianif,'TURNO1');
    dGrdPianif.Columns[c1].PickList.Clear;
    c2:=R180GetColonnaDBGrid(dGrdPianif,'TURNO2');
    dGrdPianif.Columns[c2].PickList.Clear;
    c3:=R180GetColonnaDBGrid(dGrdPianif,'TURNO3');
    dGrdPianif.Columns[c3].PickList.Clear;
    A040FPianifRepDtM1.A040MW.Q350.First;
    while not A040FPianifRepDtM1.A040MW.Q350.Eof do
    begin
      dGrdPianif.Columns[c1].PickList.Add(Format('%-*s',[5,A040FPianifRepDtM1.A040MW.Q350.FieldByName('CODICE').AsString]) + ' - ' + A040FPianifRepDtM1.A040MW.Q350.FieldByName('DESCRIZIONE').AsString);
      dGrdPianif.Columns[c2].PickList.Add(Format('%-*s',[5,A040FPianifRepDtM1.A040MW.Q350.FieldByName('CODICE').AsString]) + ' - ' + A040FPianifRepDtM1.A040MW.Q350.FieldByName('DESCRIZIONE').AsString);
      dGrdPianif.Columns[c3].PickList.Add(Format('%-*s',[5,A040FPianifRepDtM1.A040MW.Q350.FieldByName('CODICE').AsString]) + ' - ' + A040FPianifRepDtM1.A040MW.Q350.FieldByName('DESCRIZIONE').AsString);
      A040FPianifRepDtM1.A040MW.Q350.Next;
    end;
    // Reperimento dato libero e caricamento picklist
    cDL:=R180GetColonnaDBGrid(dGrdPianif,'DATOLIBERO');
    dGrdPianif.Columns[cDL].Visible:=False;
    if A000LookupTabella(Parametri.CampiRiferimento.C3_DatoPianificabile,A040FPianifRepDtM1.A040MW.selDatoLibero) then
    begin
      A040FPianifRepDtM1.A040MW.selT380.FieldByName('DATOLIBERO').DisplayLabel:=R180Capitalize(Parametri.CampiRiferimento.C3_DatoPianificabile);
      dGrdPianif.Columns[cDL].Visible:=True;
      A040FPianifRepDtM1.A040MW.selDatoLibero.First;
      while not A040FPianifRepDtM1.A040MW.selDatoLibero.Eof do
      begin
        dGrdPianif.Columns[cDL].PickList.Add(Format('%-*s',[20,A040FPianifRepDtM1.A040MW.selDatoLibero.FieldByName('CODICE').AsString]) + ' - ' + A040FPianifRepDtM1.A040MW.selDatoLibero.FieldByName('DESCRIZIONE').AsString);
        A040FPianifRepDtM1.A040MW.selDatoLibero.Next;
      end;
    end;
    actAcquisizioneTurni.Visible:=(not SolaLettura) and (A040FPianifRepDtM1.A040MW.CodTipologia = 'R') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_GET <> '') and (Parametri.CampiRiferimento.C30_WebSrv_A025_URL_PUT <> '');
    actVisualizzaAnomalie.Visible:=actAcquisizioneTurni.Visible;
    actVisualizzaAnomalie.Enabled:=False;
    ProgressBar1.Visible:=actAcquisizioneTurni.Visible;
    CreaC004(SessioneOracle,'A040',Parametri.ProgOper);
    chkNonContDipPian.Checked:=(C004FParamForm.GetParametro('chkNonContDipPian','N') = 'S');
    chkRecapitiAlternativi.Checked:=(C004FParamForm.GetParametro('chkRecapitiAlternativi','N') = 'S');
  end;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME || '' '' || T030.NOME NOMINATIVO,TO_CHAR(T430BADGE) CHR_BADGE';
  if DataRif = 0 then
    DataRif:=Parametri.DataLavoro;
  C700DataLavoro:=DataRif;
  C700DataDal:=DataRif;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.CreaSelAnagrafe(A040FPianifRepDtM1.A040MW,SessioneOracle,StatusBar,2,True);
  if TipoModulo <> 'COM' then
  begin
    actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
    A040FPianifRepDtM1.A040MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
    A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.SQL.Text:=A040FPianifRepDtM1.A040MW.SelAnagrafe.SQL.Text;
    C700FSelezioneAnagrafe.SelezionePeriodicaDalAl(A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp, A040FPianifRepDtM1.A040MW.DataInizio, A040FPianifRepDtM1.A040MW.DataFine, nil, 2, True, False, False);
    A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.Open;
    A040FPianifRepDtM1.A040MW.ImpostaCampiLookup;
    EAnno.OnChange:=nil;
    EMese.OnChange:=nil;
    EAnno.Value:=R180Anno(DataRif);
    EMese.Value:=R180Mese(DataRif);
    EAnno.OnChange:=EAnnoChange;
    EMese.OnChange:=EAnnoChange;
  end;
  EAnnoChange(nil);
end;

procedure TA040FPianifRep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if (Action <> caNone)
  and (TipoModulo <> 'COM') then
  begin
    C004FParamForm.Cancella001;
    C004FParamForm.PutParametro('chkNonContDipPian',IfThen(chkNonContDipPian.Checked,'S','N'));
    C004FParamForm.PutParametro('chkRecapitiAlternativi',IfThen(chkRecapitiAlternativi.Checked,'S','N'));
    try SessioneOracle.Commit; except end;
    FreeAndNil(C004FParamForm);
  end;
end;

procedure TA040FPianifRep.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA040FPianifRep.EAnnoChange(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    A040FPianifRepDtM1.A040MW.DataInizio:=EncodeDate(EAnno.Value,EMese.Value,1);
    A040FPianifRepDtM1.A040MW.DataFine:=R180FineMese(A040FPianifRepDtM1.A040MW.DataInizio);
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(A040FPianifRepDtM1.A040MW.DataInizio,A040FPianifRepDtM1.A040MW.DataFine) then
    begin
      C700SelAnagrafe.Close;
      A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.SQL.Text:=A040FPianifRepDtM1.A040MW.SelAnagrafe.SQL.Text;
      C700FSelezioneAnagrafe.SelezionePeriodicaDalAl(A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp, A040FPianifRepDtM1.A040MW.DataInizio, A040FPianifRepDtM1.A040MW.DataFine, nil, 2, True, False, False);
      //A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.Refresh;
      A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.Close;
      A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.Open;
      C700SelAnagrafe.Open;
    end;
    if TipoModulo <> 'COM' then
    begin
      A040FPianifRepDtM1.A040MW.RefreshT380;
      //Gestione del dato libero storico
      RefreshListaDatoLibero(A040FPianifRepDtM1.A040MW.DataFine);
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRep.RefreshListaDatoLibero(Data:TDateTime);
var cDL: Integer;
begin
  A040FPianifRepDtM1.A040MW.RefreshSelDatoLibero(Data);
  begin
    cDL:=R180GetColonnaDBGrid(dGrdPianif,'DATOLIBERO');
    dGrdPianif.Columns[cDL].PickList.Clear;
    while not A040FPianifRepDtM1.A040MW.selDatoLibero.Eof do
    begin
      dGrdPianif.Columns[cDL].PickList.Add(Format('%-*s',[20,A040FPianifRepDtM1.A040MW.selDatoLibero.FieldByName('CODICE').AsString]) + ' - ' + A040FPianifRepDtM1.A040MW.selDatoLibero.FieldByName('DESCRIZIONE').AsString);
      A040FPianifRepDtM1.A040MW.selDatoLibero.Next;
    end;
  end;
end;

procedure TA040FPianifRep.Stampa1Click(Sender: TObject);
begin
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP);
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  A040FPianifRepDtM1.A040MW.DataSt:=A040FPianifRepDtM1.A040MW.DataInizio;
  A040FDialogStampa.ShowModal;
  Screen.Cursor:=crHourGlass;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A040FPianifRepDtM1.A040MW);
  Screen.Cursor:=crDefault;
end;

procedure TA040FPianifRep.VisualizzaColonneRecapiti;
var
  c:integer;
  Visualizza: Boolean;
begin
  Visualizza:=(A040FPianifRepDtM1.A040MW.CodTipologia = 'R') and chkRecapitiAlternativi.Checked;
  c:=R180GetColonnaDBGrid(dGrdPianif,'RECAPITO1');
  dGrdPianif.Columns[c].Visible:=Visualizza;
  c:=R180GetColonnaDBGrid(dGrdPianif,'RECAPITO2');
  dGrdPianif.Columns[c].Visible:=Visualizza;
  c:=R180GetColonnaDBGrid(dGrdPianif,'RECAPITO3');
  dGrdPianif.Columns[c].Visible:=Visualizza;
end;

procedure TA040FPianifRep.dGrdPianifCellClick(Column: TColumn);
begin
// creazione hint della griglia
  dGrdPianif.Hint:=A040FPianifRepDtM1.A040MW.GetHint(dGrdPianif.Columns[R180GetColonnaDBGrid(dGrdPianif,'DATOLIBERO')].Visible);
end;

procedure TA040FPianifRep.frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  // impostazione Filtro e aggiornamento selezione
  A040FPianifRepDtM1.A040MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
  A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.SQL.Text:=A040FPianifRepDtM1.A040MW.SelAnagrafe.SQL.Text;
  C700FSelezioneAnagrafe.SelezionePeriodicaDalAl(A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp, A040FPianifRepDtM1.A040MW.DataInizio, A040FPianifRepDtM1.A040MW.DataFine, nil, 2, True, False, False);
  A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.Refresh;
  Screen.Cursor:=crHourGlass;
  try
    A040FPianifRepDtM1.A040MW.RefreshT380;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRep.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  C700DataDal:=EncodeDate(EAnno.Value,EMese.Value,1);
  C700DataLavoro:=R180FineMese(C700DataDal);
  frmSelAnagrafe.btnSelezioneClick(Sender);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  // impostazione Filtro e aggiornamento selezione
  A040FPianifRepDtM1.A040MW.ImpostaFiltro(C700SelAnagrafe.SubstitutedSQL);
  A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.SQL.Text:=A040FPianifRepDtM1.A040MW.SelAnagrafe.SQL.Text;
  C700FSelezioneAnagrafe.SelezionePeriodicaDalAl(A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp, A040FPianifRepDtM1.A040MW.DataInizio, A040FPianifRepDtM1.A040MW.DataFine, nil, 2, True, False, False);
  A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.Refresh;
  Screen.Cursor:=crHourGlass;
  try
    A040FPianifRepDtM1.A040MW.RefreshT380;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA040FPianifRep.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  C005DataVisualizzazione:=A040FPianifRepDtM1.A040MW.DataInizio;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA040FPianifRep.dGrdPianifDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:integer;
begin
  inherited;
  if gdFixed in State then exit;
  //Ciclo su tabella
  for i:=1 to 31 do
  begin
    if (A040FPianifRepDtM1.A040MW.ElencoDate[i].Colorata) and (A040FPianifRepDtM1.A040MW.ElencoDate[i].Data = A040FPianifRepDtM1.A040MW.selT380.FieldByName('DATA').AsDateTime) then
    begin
      if gdSelected in State then
      begin
        dgrdPianif.Canvas.Brush.Color:=clHighLight;
        dgrdPianif.Canvas.Font.Color:=clWhite;
      end
      else
      begin
        dgrdPianif.Canvas.Brush.Color:=$00FFFF80;
        dgrdPianif.Canvas.Font.Color:=clWindowText;
      end;
      dgrdPianif.DefaultDrawColumnCell(Rect,DataCol,Column,State);
      Break;
    end;
  end;
end;

procedure TA040FPianifRep.actAcquisizioneTurniExecute(Sender: TObject);
{2 fasi:
 - Chiamata servizio firlab 'Calendar' in get
 - Chiamata nostro servizio 'Turni' in put passando il risultato della chiamata precedente
}
var B021FWebSvcClientDtM:TB021FWebSvcClientDtM;
    EsistonoMsgAnomalie,CancellaTurniEsistenti:Boolean;
    Dal,Al:TDateTime;
begin
  inherited;
  if C700SelAnagrafe.RecordCount = 0 then
    raise Exception.Create(A000MSG_ERR_NO_DIP)
  else if MessageDlg(Format(A000MSG_A040_DLG_FMT_ACQUISIZ_TURNI,[R180NomeMese(EMese.Value),EAnno.Text]),mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  CancellaTurniEsistenti:=MessageDlg(Format(A000MSG_A040_DLG_FMT_CANCELLA_TURNI,[R180NomeMese(EMese.Value),EAnno.Text]),mtConfirmation,[mbYes,mbNo],0) = mrYes;
  actVisualizzaAnomalie.Enabled:=False;
  B021FWebSvcClientDtM:=TB021FWebSvcClientDtM.Create(nil);
  Dal:=EncodeDate(EAnno.Value,EMese.Value,1);
  Al:=R180FineMese(Dal);
  if CancellaTurniEsistenti then
    A040FPianifRepDtM1.A040MW.CancellaTurniEsistenti;

  try
    ProgressBar1.Position:=0;
    ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
    C700SelAnagrafe.First;
    Screen.Cursor:=crHourGlass;
    while not C700SelAnagrafe.Eof do
    begin
      ProgressBar1.StepBy(1);
      B021FWebSvcClientDtM.WebSvcRecordT380(C700SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                                            C700SelAnagrafe.FieldByName('MATRICOLA').AsString,
                                            Dal,
                                            Al);
      C700SelAnagrafe.Next;
    end;

    EsistonoMsgAnomalie:=B021FWebSvcClientDtM.EsistonoMsgAnomalie;
    actVisualizzaAnomalie.Enabled:=EsistonoMsgAnomalie;
  finally
    FreeAndNil(B021FWebSvcClientDtM);
    ProgressBar1.Position:=0;
    Screen.Cursor:=crDefault;
  end;
  EAnnoChange(nil);
  if EsistonoMsgAnomalie then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes) then
      actVisualizzaAnomalieExecute(nil);
  end
  else
    ShowMessage(A000MSG_MSG_ACQUISIZIONE_TERMINATA);
end;

procedure TA040FPianifRep.actGestioneMensileExecute(Sender: TObject);
begin
  inherited;
  A040FInserimento.ShowModal;
end;

procedure TA040FPianifRep.actVisualizzaAnomalieExecute(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A040WEBSRV','');
  C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME || '' '' || T030.NOME NOMINATIVO,TO_CHAR(T430BADGE) CHR_BADGE';
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A040FPianifRepDtM1.A040MW);
  //Gestire ricreazione selAnagrafe con campi di lookup sul T380
end;

procedure TA040FPianifRep.chkRecapitiAlternativiClick(Sender: TObject);
begin
  inherited;
  VisualizzaColonneRecapiti;
end;

procedure TA040FPianifRep.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if (Field = A040FPianifRepDtM1.selT380.FieldByName('DATA')) and
     (not A040FPianifRepDtM1.selT380.FieldByName('DATA').IsNull) then
    RefreshListaDatoLibero(A040FPianifRepDtM1.selT380.FieldByName('DATA').AsDateTime);
end;

procedure TA040FPianifRep.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

end.
