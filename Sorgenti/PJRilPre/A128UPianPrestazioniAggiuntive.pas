unit A128UPianPrestazioniAggiuntive;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ExtCtrls, Grids, Spin, DBCtrls, Buttons, DB,
  DBGrids, OracleData, DBCGrids, ActnList, ImgList, ToolWin, Variants,
  R001UGestTab, RegistrazioneLog, SelAnagrafe,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A000USessione,
  C004UParamForm, C005UDatiAnagrafici, C180FunzioniGenerali, C700USelezioneAnagrafe, System.Actions,
  System.ImageList, StrUtils;

type
  TA128FPianPrestazioniAggiuntive = class(TR001FGestTab)
    Panel2: TPanel;
    EMese: TSpinEdit;
    Label3: TLabel;
    EAnno: TSpinEdit;
    Label4: TLabel;
    ScrollBox3: TScrollBox;
    dGrdPianif: TDBGrid;
    Label5: TLabel;
    frmSelAnagrafe: TfrmSelAnagrafe;
    actGestioneMensile: TAction;
    GestioneMensile1: TMenuItem;
    BitBtn1: TBitBtn;
    PopupMenu1: TPopupMenu;
    Gestionemensile2: TMenuItem;
    btnAcqFile: TBitBtn;
    actAcquisizioneFile: TAction;
    Acquisizionedafile1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure EAnnoChange(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure dGrdPianifCellClick(Column: TColumn);
    procedure frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
    procedure dGrdPianifDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actGestioneMensileExecute(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure actAcquisizioneFileExecute(Sender: TObject);
  private
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    { Public declarations }
  end;

var
  A128FPianPrestazioniAggiuntive: TA128FPianPrestazioniAggiuntive;

procedure OpenA128PianPrestazioniAggiuntive(Prog:LongInt);

implementation

uses A128UPianPrestazioniAggiuntiveDtm, A128UAcqFilePrestazioniAggiuntive,
     A128UInserimento, A128UDialogStampa, A128UStampa;

{$R *.DFM}

procedure OpenA128PianPrestazioniAggiuntive(Prog:LongInt);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA128PianPrestazioniAggiuntive') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A128FPianPrestazioniAggiuntive:=TA128FPianPrestazioniAggiuntive.Create(nil);
  with A128FPianPrestazioniAggiuntive do
  try
    A128FPianPrestazioniAggiuntiveDtm:=TA128FPianPrestazioniAggiuntiveDtm.Create(nil);
    C700Progressivo:=Prog;
    actGestioneMensile.Enabled:=not SolaLettura;
    actAcquisizioneFile.Enabled:=not SolaLettura;
    A128FPianPrestazioniAggiuntiveDtm.selT332.ReadOnly:=SolaLettura;
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A128FPianPrestazioniAggiuntiveDtm);
    FreeAndNil(A128FAcqFilePrestazioniAggiuntive);
    FreeAndNil(A128FInserimento);
    FreeAndNil(A128FStampa);
    FreeAndNil(A128FDialogStampa);
    Free;
  end;
end;

procedure TA128FPianPrestazioniAggiuntive.FormCreate(Sender: TObject);
begin
  inherited;
  Application.HintPause:=100;
  A128FAcqFilePrestazioniAggiuntive:=TA128FAcqFilePrestazioniAggiuntive.Create(nil);
  A128FInserimento:=TA128FInserimento.Create(nil);
  A128FDialogStampa:=TA128FDialogStampa.Create(nil);
  A128FStampa:=TA128FStampa.Create(nil);
end;

procedure TA128FPianPrestazioniAggiuntive.FormActivate(Sender: TObject);
begin
  inherited;
  DButton.DataSet:=A128FPianPrestazioniAggiuntiveDtm.selT332;
end;

procedure TA128FPianPrestazioniAggiuntive.FormShow(Sender: TObject);
var c1,c2:Integer;
begin
  inherited;
  // caricamento picklist TURNI della griglia
  c1:=R180GetColonnaDBGrid(dGrdPianif,'TURNO1');
  dGrdPianif.Columns[c1].PickList.Clear;
  c2:=R180GetColonnaDBGrid(dGrdPianif,'TURNO2');
  dGrdPianif.Columns[c2].PickList.Clear;
  with A128FPianPrestazioniAggiuntiveDtm.A128MW.Q330 do
  begin
    First;
    while not Eof do
    begin
      dGrdPianif.Columns[c1].PickList.Add(Format('%-*s',[5,FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
      dGrdPianif.Columns[c2].PickList.Add(Format('%-*s',[5,FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
  CreaC004(SessioneOracle,'A128',Parametri.ProgOper);
  GetParametriFunzione;
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME || '' '' || T030.NOME NOMINATIVO,TO_CHAR(T430BADGE) CHR_BADGE';
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A128FPianPrestazioniAggiuntiveDtm.A128MW,SessioneOracle,StatusBar,1,True);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  A128FPianPrestazioniAggiuntiveDtm.A128MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
  A128FPianPrestazioniAggiuntiveDtm.A128MW.ImpostaCampiLookup;
  EAnno.OnChange:=nil;
  EMese.OnChange:=nil;
  EAnno.Value:=R180Anno(Parametri.DataLavoro);
  EMese.Value:=R180Mese(Parametri.DataLavoro);
  EAnno.OnChange:=EAnnoChange;
  EMese.OnChange:=EAnnoChange;
  EAnnoChange(nil);
end;

procedure TA128FPianPrestazioniAggiuntive.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Action <> caNone then
  begin
    PutParametriFunzione;
    FreeAndNil(C004FParamForm);
  end;
end;

procedure TA128FPianPrestazioniAggiuntive.GetParametriFunzione;
begin
  with A128FAcqFilePrestazioniAggiuntive do
  begin
    edtNomeFileInput.Text:=C004FParamForm.GetParametro('edtNomeFileInput','');
    grdParametrizzazioneFile.Cells[1,1]:=C004FParamForm.GetParametro('MatricolaPos','1');
    grdParametrizzazioneFile.Cells[1,2]:=C004FParamForm.GetParametro('MatricolaLung','8');
    grdParametrizzazioneFile.Cells[2,1]:=C004FParamForm.GetParametro('GiornoPos','9');
    grdParametrizzazioneFile.Cells[2,2]:=C004FParamForm.GetParametro('GiornoLung','2');
    grdParametrizzazioneFile.Cells[3,1]:=C004FParamForm.GetParametro('MesePos','11');
    grdParametrizzazioneFile.Cells[3,2]:=C004FParamForm.GetParametro('MeseLung','2');
    grdParametrizzazioneFile.Cells[4,1]:=C004FParamForm.GetParametro('AnnoPos','13');
    grdParametrizzazioneFile.Cells[4,2]:=C004FParamForm.GetParametro('AnnoLung','4');
    grdParametrizzazioneFile.Cells[5,1]:=C004FParamForm.GetParametro('Turno1Pos','17');
    grdParametrizzazioneFile.Cells[5,2]:=C004FParamForm.GetParametro('Turno1Lung','5');
    grdParametrizzazioneFile.Cells[6,1]:=C004FParamForm.GetParametro('Turno2Pos','22');
    grdParametrizzazioneFile.Cells[6,2]:=C004FParamForm.GetParametro('Turno2Lung','5');
    grdParametrizzazioneFile.Cells[7,1]:=C004FParamForm.GetParametro('OraInizioTurno1Pos','27');
    grdParametrizzazioneFile.Cells[7,2]:=C004FParamForm.GetParametro('OraInizioTurno1Lung','5');
    grdParametrizzazioneFile.Cells[8,1]:=C004FParamForm.GetParametro('OraFineTurno1Pos','32');
    grdParametrizzazioneFile.Cells[8,2]:=C004FParamForm.GetParametro('OraFineTurno1Lung','5');
    grdParametrizzazioneFile.Cells[9,1]:=C004FParamForm.GetParametro('OraInizioTurno2Pos','37');
    grdParametrizzazioneFile.Cells[9,2]:=C004FParamForm.GetParametro('OraInizioTurno2Lung','5');
    grdParametrizzazioneFile.Cells[10,1]:=C004FParamForm.GetParametro('OraFineTurno2Pos','42');
    grdParametrizzazioneFile.Cells[10,2]:=C004FParamForm.GetParametro('OraFineTurno2Lung','5');
    chkSovrascriviEsistenti.Checked:=C004FParamForm.GetParametro('chkSovrascriviEsistenti','False') = 'True';
    chkCancellaFile.Checked:=C004FParamForm.GetParametro('chkCancellaFile','False') = 'True';
  end;
end;

procedure TA128FPianPrestazioniAggiuntive.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  with A128FAcqFilePrestazioniAggiuntive do
  begin
    C004FParamForm.PutParametro('edtNomeFileInput',edtNomeFileInput.Text);
    C004FParamForm.PutParametro('MatricolaPos',grdParametrizzazioneFile.Cells[1,1]);
    C004FParamForm.PutParametro('MatricolaLung',grdParametrizzazioneFile.Cells[1,2]);
    C004FParamForm.PutParametro('GiornoPos',grdParametrizzazioneFile.Cells[2,1]);
    C004FParamForm.PutParametro('GiornoLung',grdParametrizzazioneFile.Cells[2,2]);
    C004FParamForm.PutParametro('MesePos',grdParametrizzazioneFile.Cells[3,1]);
    C004FParamForm.PutParametro('MeseLung',grdParametrizzazioneFile.Cells[3,2]);
    C004FParamForm.PutParametro('AnnoPos',grdParametrizzazioneFile.Cells[4,1]);
    C004FParamForm.PutParametro('AnnoLung',grdParametrizzazioneFile.Cells[4,2]);
    C004FParamForm.PutParametro('Turno1Pos',grdParametrizzazioneFile.Cells[5,1]);
    C004FParamForm.PutParametro('Turno1Lung',grdParametrizzazioneFile.Cells[5,2]);
    C004FParamForm.PutParametro('Turno2Pos',grdParametrizzazioneFile.Cells[6,1]);
    C004FParamForm.PutParametro('Turno2Lung',grdParametrizzazioneFile.Cells[6,2]);
    C004FParamForm.PutParametro('OraInizioTurno1Pos',grdParametrizzazioneFile.Cells[7,1]);
    C004FParamForm.PutParametro('OraInizioTurno1Lung',grdParametrizzazioneFile.Cells[7,2]);
    C004FParamForm.PutParametro('OraFineTurno1Pos',grdParametrizzazioneFile.Cells[8,1]);
    C004FParamForm.PutParametro('OraFineTurno1Lung',grdParametrizzazioneFile.Cells[8,2]);
    C004FParamForm.PutParametro('OraInizioTurno2Pos',grdParametrizzazioneFile.Cells[9,1]);
    C004FParamForm.PutParametro('OraInizioTurno2Lung',grdParametrizzazioneFile.Cells[9,2]);
    C004FParamForm.PutParametro('OraFineTurno2Pos',grdParametrizzazioneFile.Cells[10,1]);
    C004FParamForm.PutParametro('OraFineTurno2Lung',grdParametrizzazioneFile.Cells[10,2]);
    C004FParamForm.PutParametro('chkSovrascriviEsistenti',IfThen(chkSovrascriviEsistenti.Checked, 'True', 'False'));
    C004FParamForm.PutParametro('chkCancellaFile',IfThen(chkCancellaFile.Checked, 'True', 'False'));
    try SessioneOracle.Commit; except end;
  end;
end;

procedure TA128FPianPrestazioniAggiuntive.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

procedure TA128FPianPrestazioniAggiuntive.EAnnoChange(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass;
  try
    with A128FPianPrestazioniAggiuntiveDtm.A128MW do
    begin
      DataInizio:=EncodeDate(EAnno.Value,EMese.Value,1);
      DataFine:=R180FineMese(DataInizio);
      if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataInizio,DataInizio) then
        C700SelAnagrafe.Close;
      RefreshSelT332;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA128FPianPrestazioniAggiuntive.Stampa1Click(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  A128FDialogStampa.DataSt:=A128FPianPrestazioniAggiuntiveDtm.A128MW.DataInizio;
  A128FDialogStampa.ShowModal;
  frmSelAnagrafe.RipristinaC00SelAnagrafe(A128FPianPrestazioniAggiuntiveDtm.A128MW);
end;

procedure TA128FPianPrestazioniAggiuntive.dGrdPianifCellClick(Column: TColumn);
begin
// creazione hint della griglia
  dGrdPianif.Hint:=A128FPianPrestazioniAggiuntiveDtm.A128MW.GetHint;
end;

procedure TA128FPianPrestazioniAggiuntive.frmSelAnagrafebtnEreditaSelezioneClick(Sender: TObject);
begin
  frmSelAnagrafe.btnEreditaSelezioneClick(Sender);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  // impostazione Filtro e aggiornamento selezione
  A128FPianPrestazioniAggiuntiveDtm.A128MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
  Screen.Cursor:=crHourGlass;
  try
    A128FPianPrestazioniAggiuntiveDtm.A128MW.RefreshSelT332;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA128FPianPrestazioniAggiuntive.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  C700DataLavoro:=A128FPianPrestazioniAggiuntiveDtm.A128MW.DataInizio;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  actGestioneMensile.Enabled:=(C700SelAnagrafe.RecordCount > 0) and (not SolaLettura);
  // impostazione Filtro e aggiornamento selezione
  A128FPianPrestazioniAggiuntiveDtm.A128MW.ImpostaFiltro(C700SelAnagrafe.SQL.Text);
  Screen.Cursor:=crHourGlass;
  try
    A128FPianPrestazioniAggiuntiveDtm.A128MW.RefreshSelT332;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA128FPianPrestazioniAggiuntive.frmSelAnagrafeR003DatianagraficiClick(Sender: TObject);
begin
  inherited;
  C005DataVisualizzazione:=A128FPianPrestazioniAggiuntiveDtm.A128MW.DataInizio;
  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA128FPianPrestazioniAggiuntive.dGrdPianifDrawColumnCell(Sender: TObject;const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var i:integer;
begin
  inherited;
  if gdFixed in State then exit;
  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
    //Ciclo su tabella
    for i:=1 to 31 do
      if (ElencoDate[i].Colorata) and (ElencoDate[i].Data = selT332.FieldByName('DATA').AsDateTime) then
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

procedure TA128FPianPrestazioniAggiuntive.actAcquisizioneFileExecute(Sender: TObject);
begin
  inherited;
  with A128FAcqFilePrestazioniAggiuntive do
  begin
    edtInizioAcquisizione.Text:=FormatDateTime('dd/mm/yyyy',A128FPianPrestazioniAggiuntiveDtm.A128MW.DataInizio);
    edtFineAcquisizione.Text:=FormatDateTime('dd/mm/yyyy',A128FPianPrestazioniAggiuntiveDtm.A128MW.DataFine);
    ShowModal;
  end;
  A128FPianPrestazioniAggiuntiveDtm.selT332.Refresh;
  A128FPianPrestazioniAggiuntiveDtm.A128MW.CaricaElencoDate;
end;

procedure TA128FPianPrestazioniAggiuntive.actGestioneMensileExecute(Sender: TObject);
begin
  inherited;
  A128FInserimento.ShowModal;
end;

procedure TA128FPianPrestazioniAggiuntive.DButtonStateChange(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.Enabled:=DButton.State = dsBrowse;
end;

end.
