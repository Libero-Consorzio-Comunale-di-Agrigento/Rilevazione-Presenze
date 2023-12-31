unit A056UTurnazInd;

interface

uses Data.DB, Vcl.Menus, Vcl.Forms, SelAnagrafe, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.Samples.Spin, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.Controls, System.Classes, Vcl.ExtCtrls,
  Dialogs, SysUtils, OracleData, Windows, Variants, StrUtils,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  A003UDataLavoroBis, A055UTurnazioni,
  C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe;

type
  TA056FTurnazInd = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    ETurnazione: TDBLookupComboBox;
    Label4: TLabel;
    Label5: TLabel;
    EPartenza: TSpinEdit;
    Button1: TButton;
    BInserimento: TBitBtn;
    DBGrid1: TDBGrid;
    PopupMenu2: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    Label6: TLabel;
    StatusBar: TStatusBar;
    BitBtn2: TBitBtn;
    ProgressBar1: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkDipendenteCorrente: TCheckBox;
    edtDataAss: TMaskEdit;
    Label1: TLabel;
    GrpParInserimento: TGroupBox;
    chkRiposi: TCheckBox;
    chkGGLav: TCheckBox;
    ChkPianif_da_calendario: TCheckBox;
    chkInsAutomatico: TCheckBox;
    ppMnuTurniAssegnati: TPopupMenu;
    Assegnaturnoalladata1: TMenuItem;
    chkPregresso: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BInserimentoClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ETurnazioneKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1EditButtonClick(Sender: TObject);
    procedure frmSelAnagrafebtnSuccessivoClick(Sender: TObject);
    procedure edtDataAssExit(Sender: TObject);
    procedure chkInsAutomaticoClick(Sender: TObject);
    procedure chkDipendenteCorrenteClick(Sender: TObject);
    procedure Assegnaturnoalladata1Click(Sender: TObject);
    procedure ppMnuTurniAssegnatiPopup(Sender: TObject);
  private
    procedure CambiaProgressivo;
    function  VisualizzaSviluppo(ValDefault:Integer = 0):Integer;
  public
    {public declarations}
  end;

var
  A056FTurnazInd: TA056FTurnazInd;

procedure OpenA056TurnazInd(Prog:LongInt);

implementation

uses A056UTurnazIndDtM1, A056UGrigliaCicli;

{$R *.DFM}

procedure OpenA056TurnazInd(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA056TurnazInd') of
    'N':
        begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A056FTurnazInd:=TA056FTurnazInd.Create(nil);
  with A056FTurnazInd do
    try
      C700Progressivo:=Prog;
      A056FTurnazIndDtM1:=TA056FTurnazIndDtM1.Create(nil);
      ShowModal;
    finally
      SolaLettura:=SolaLetturaOriginale;
      A056FTurnazIndDtM1.Free;
      Free;
    end;
end;

procedure TA056FTurnazInd.FormCreate(Sender: TObject);
begin
  BInserimento.Enabled:=not SolaLettura;
  BitBtn2.Enabled:=not SolaLettura;
end;

procedure TA056FTurnazInd.FormShow(Sender: TObject);
begin
  ETurnazione.ListSource:=A056FTurnazIndDtM1.A056MW.D640;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T430SQUADRA, T430TIPOOPE, T430CALENDARIO';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(A056FTurnazIndDtM1.A056MW,SessioneOracle,StatusBar,0,True);
  chkDipendenteCorrente.Checked:=False;
  chkDipendenteCorrenteClick(nil);
  chkInsAutomaticoClick(nil);  
  chkGGLav.Checked:=True;
  chkRiposi.Checked:=True;
  edtDataAss.Text:=DateToStr(Parametri.DataLavoro);
end;

procedure TA056FTurnazInd.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
end;

procedure TA056FTurnazInd.CambiaProgressivo;
begin
  if C700OldProgressivo <> C700Progressivo then
  begin
    //Combo ETurnazione elenca solo i codici di T640 che sono riportati in T603, per la squadra corrispondente a quella su T430.
    //Propone il codice usato su T620 alla data specificata. Se non trovato, quello alla data pi� recente. Altrimenti, il primo della lista.
    A056FTurnazIndDtM1.A056MW.LeggiSquadraStorico;
    A056FTurnazIndDtM1.Q620.Close;
    A056FTurnazIndDtM1.Q620.SetVariable('Progressivo',C700Progressivo);
    A056FTurnazIndDtM1.Q620.Open;
    A056FTurnazIndDtM1.Q620.SearchRecord('DATA',A056FTurnazIndDtM1.A056MW.Data,[srFromBeginning]);
    if A056FTurnazIndDtM1.Q620.RecordCount > 0 then
      ETurnazione.KeyValue:=A056FTurnazIndDtM1.Q620.FieldByName('Turnazione').AsString
    else
      ETurnazione.KeyValue:=A056FTurnazIndDtM1.A056MW.Q640.FieldByName('Codice').AsString;
    if A056FTurnazIndDtM1.Q620.FieldByName('PIANIF_DA_CALENDARIO').AsString = 'S' then
      ChkPianif_da_calendario.Checked:=True
    else
      ChkPianif_da_calendario.Checked:=False;
  end;
end;

procedure TA056FTurnazInd.BitBtn1Click(Sender: TObject);
{var P:Integer;}
begin
  {P:=C700Progressivo;}
  try
    A056FTurnazIndDtM1.A056MW.Data:=DataOut(StrToDate(edtDataAss.Text),'Riferimento per turnazione','G');
  except
    A056FTurnazIndDtM1.A056MW.Data:=DataOut(A056FTurnazIndDtM1.A056MW.Data,'Riferimento per turnazione','G');
  end;
  edtDataAss.Text:=DateToStr(A056FTurnazIndDtM1.A056MW.Data);
  {if C700SelAnagrafe.GetVariable('DataLavoro') <> A056FTurnazIndDtM1.A056MW.Data then
  begin
    C700SelAnagrafe.Close;
    C700SelAnagrafe.SetVariable('DataLavoro',A056FTurnazIndDtM1.A056MW.Data);
    C700SelAnagrafe.Open;
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    frmSelAnagrafe.VisualizzaDipendente;
    frmSelAnagrafe.NumRecords;
  end;}
end;

procedure TA056FTurnazInd.Assegnaturnoalladata1Click(Sender: TObject);
begin
  A056FTurnazIndDtM1.A056MW.A056PCKT080TURNO.CalcolaDatiADATA(C700Progressivo,StrToDate(edtDataAss.Text));
  EPartenza.Text:=IntToStr(A056FTurnazIndDtM1.A056MW.A056PCKT080TURNO.GetPartenza);
  ETurnazione.KeyValue:=A056FTurnazIndDtM1.Q620.FieldByName('TURNAZIONE').AsString;
end;

procedure TA056FTurnazInd.BInserimentoClick(Sender: TObject);
{Inserisco la turnazione specificata cancellando eventualmente una gi� esistente
 nella stessa data}
var ProgOld:Integer;
begin
  ProgOld:=C700Progressivo;
  if frmSelAnagrafe.SettaPeriodoSelAnagrafe(A056FTurnazIndDtM1.A056MW.Data,A056FTurnazIndDtM1.A056MW.Data) then
    C700SelAnagrafe.Close;
  C700SelAnagrafe.Open;
  frmSelAnagrafe.NumRecords;
  if not C700SelAnagrafe.SearchRecord('PROGRESSIVO',ProgOld,[srFromBeginning]) then
    raise exception.Create(A000MSG_A056_ERR_NO_DIP);
  if C700SelAnagrafe.RecordCount = 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  //Non esiste una turnazione valida
  if ETurnazione.Text = ''then
    raise Exception.create(A000MSG_A056_ERR_TURNAZIONE);
  if EPartenza.MaxValue = 0 then
    raise Exception.create(A000MSG_A056_ERR_TURNAZ_INESISTENTE);
  if Sender = BitBtn2 then
    if MessageDlg(IfThen(chkDipendenteCorrente.Checked,A000MSG_A056_DLG_CANCELLAZIONE,A000MSG_DLG_CANCELLAZIONE),mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit;
  if (Sender = BInserimento) and chkDipendenteCorrente.Checked then
    if MessageDlg(A000MSG_A056_DLG_INSERIMENTO,mtConfirmation,[mbYes,mbNo],0) = mrNo then
      exit;

  with A056FTurnazIndDtM1 do
  begin
    if (Sender = BitBtn2) or (Not chkInsAutomatico.Checked) then
    begin
      frmSelAnagrafe.OnCambiaProgressivo:=nil;
      if chkDipendenteCorrente.Checked then
        C700SelAnagrafe.First;
      ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
      ProgressBar1.Position:=0;
      while not C700SelAnagrafe.Eof do
      begin
        frmSelAnagrafe.VisualizzaDipendente;
        ProgressBar1.StepBy(1);
        if Sender = BInserimento then
          A056FTurnazIndDtM1.A056MW.InserisciTurnazInd(C700Progressivo)
        else
          A056FTurnazIndDtM1.A056MW.CancellaTurnazInd(C700Progressivo);
        if Not chkDipendenteCorrente.Checked then
          Break;
        C700SelAnagrafe.Next;
      end;
      ProgressBar1.Position:=0;
      frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
      if chkDipendenteCorrente.Checked then
        C700SelAnagrafe.First;
      C700OldProgressivo:=-1;
      CambiaProgressivo;
    end
    else
      A056FTurnazIndDtM1.AssegnazioneAutomatica;
  end;
end;

procedure TA056FTurnazInd.chkDipendenteCorrenteClick(Sender: TObject);
begin
  chkInsAutomatico.Enabled:=chkDipendenteCorrente.Checked;
  if not chkInsAutomatico.Enabled then
    chkInsAutomatico.Checked:=False;
end;

procedure TA056FTurnazInd.chkInsAutomaticoClick(Sender: TObject);
begin
  chkPregresso.Enabled:=chkInsAutomatico.Checked;
  if not chkPregresso.Enabled then
    chkPregresso.Checked:=False;
end;

procedure TA056FTurnazInd.DBGrid1EditButtonClick(Sender: TObject);
begin
  with A056FTurnazIndDtM1 do
  begin
    if not(Q620.State in [dsEdit]) then
      Q620.Edit;
    Q620.FieldByName('PARTENZA').AsInteger:=VisualizzaSviluppo(Q620.FieldByName('PARTENZA').AsInteger);
    //Q620.Post;
    EPartenza.Value:=Q620.FieldByName('PARTENZA').AsInteger;
  end;
end;

procedure TA056FTurnazInd.edtDataAssExit(Sender: TObject);
{var P:Integer;}
begin
  {P:=C700Progressivo;}
  try
    A056FTurnazIndDtM1.A056MW.Data:=StrToDate(edtDataAss.Text);
  except
    edtDataAss.Text:='';
    edtDataAss.SetFocus;
    Exit;
  end;
  {f C700SelAnagrafe.GetVariable('DataLavoro') <> A056FTurnazIndDtM1.A056MW.Data then
  begin
    C700SelAnagrafe.Close;
    C700SelAnagrafe.SetVariable('DataLavoro',A056FTurnazIndDtM1.A056MW.Data);
    C700SelAnagrafe.Open;
    C700SelAnagrafe.SearchRecord('PROGRESSIVO',P,[srFromBeginning]);
    frmSelAnagrafe.VisualizzaDipendente;
    frmSelAnagrafe.NumRecords;
  end;}
end;

procedure TA056FTurnazInd.Nuovoelemento1Click(Sender: TObject);
{Richiamo gestione turnazioni}
begin
  OpenA055Turnazioni(ETurnazione.Text);
  with A056FTurnazIndDtM1.A056MW.Q640 do
  begin
    DisableControls;
    Refresh;
    EnableControls;
    //SearchRecord('CODICE',S,[srFromBeginning]);
  end;
end;

procedure TA056FTurnazInd.ppMnuTurniAssegnatiPopup(Sender: TObject);
begin
  if A056FTurnazIndDtM1.Q620.RecordCount > 0 then
    Assegnaturnoalladata1.Caption:=Format('Imposta turnazione alla data di partenza indicata (%s)',[edtDataAss.Text])
end;

procedure TA056FTurnazInd.Button1Click(Sender: TObject);
begin
  EPartenza.Value:=VisualizzaSviluppo;
end;

function TA056FTurnazInd.VisualizzaSviluppo(ValDefault:Integer = 0):Integer;
{Richiamo la form di visualizzzazione cicli in una StringGrid}
begin
  Result:=ValDefault;
  A056FGrigliaCicli:=TA056FGrigliaCicli.Create(nil);
  with A056FGrigliaCicli do
    try
      Caption:='Sviluppo turnazione ' + ETurnazione.Text;
      with A056FTurnazIndDtM1.A056MW do
        CaricaGriglia(Turno1,Turno2,Orario,Causale);
      if ShowModal = mrOK then
        Result:=StringGrid1.Row - 1;
    finally
      Release;
    end;
end;

procedure TA056FTurnazInd.ETurnazioneKeyDown(Sender: TObject;
var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (not ETurnazione.ListVisible) then
    Label6.Caption:='';
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      //if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA056FTurnazInd.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=A056FTurnazIndDtM1.A056MW.Data;
  except
    C005DataVisualizzazione:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA056FTurnazInd.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  try
    C700DataLavoro:=A056FTurnazIndDtM1.A056MW.Data;
  except
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
end;

procedure TA056FTurnazInd.frmSelAnagrafebtnSuccessivoClick(Sender: TObject);
begin
  frmSelAnagrafe.btnBrowseClick(Sender);
end;

end.
