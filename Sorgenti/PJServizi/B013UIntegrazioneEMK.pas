unit B013UIntegrazioneEMK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, Menus, Buttons, ExtCtrls, Spin, C004UParamForm,
  C180FunzioniGenerali, A000UCostanti, A000USessione,A000UInterfaccia, OracleData,
  ActnList, ImgList, ComCtrls, ToolWin, Variants, RegistrazioneLog;

type
  TB013FIntegrazioneEMK = class(TForm)
    Timer1: TTimer;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Esci1: TMenuItem;
    Pianificazione1: TMenuItem;
    Panel1: TPanel;
    Memo1: TMemo;
    ToolBar1: TToolBar;
    ToolButtonAttiva: TToolButton;
    ToolButtonSospendi: TToolButton;
    ToolButtonEsegui: TToolButton;
    ToolButton41: TToolButton;
    ToolButtonVisualizzaLog: TToolButton;
    ToolButtonCancellaLog: TToolButton;
    ToolButton22: TToolButton;
    ToolButton43: TToolButton;
    ToolButtonEsci: TToolButton;
    ImageList1: TImageList;
    actlstBase: TActionList;
    actAttiva: TAction;
    actSospendi: TAction;
    actVisualizzaLog: TAction;
    actCancellaLog: TAction;
    actEsci: TAction;
    actEsegui: TAction;
    ToolButtonPianificazione: TToolButton;
    ToolButton2: TToolButton;
    actPianificazione: TAction;
    Attiva1: TMenuItem;
    Sospendi1: TMenuItem;
    Eseguiintegrazione1: TMenuItem;
    Visualizzalog1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    lblMaxRigheLog: TLabel;
    speMaxRigheLog: TSpinEdit;
    ToolButtonCancTimb: TToolButton;
    ToolButton3: TToolButton;
    actCancellaTimbrature: TAction;
    chkChiudiTermineElab: TCheckBox;
    stbIntegrazione: TStatusBar;
    lblAbilitazioniMensa: TLabel;
    edtAbMensa: TEdit;
    lblDatabase: TLabel;
    edtDataBase: TEdit;
    btnDataBase: TButton;    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actEsciExecute(Sender: TObject);
    procedure actPianificazioneExecute(Sender: TObject);
    procedure actVisualizzaLogExecute(Sender: TObject);
    procedure actAttivaExecute(Sender: TObject);
    procedure actSospendiExecute(Sender: TObject);
    procedure actEseguiExecute(Sender: TObject);
    procedure actCancellaTimbratureExecute(Sender: TObject);
    procedure edtAbMensaChange(Sender: TObject);
    procedure btnDataBaseClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure AbilitaFunzioni(ScaricoInCorso:Boolean);
    procedure LetturaLog;
    procedure AggiornaTabelle;
  public
    { Public declarations }
  end;

var
  B013FIntegrazioneEMK: TB013FIntegrazioneEMK;

implementation

uses B013UIntegrazioneEMKDtM, B013UPianificazioneIntegrazione, A003UDataLavoroBis;

{$R *.DFM}

procedure TB013FIntegrazioneEMK.FormActivate(Sender: TObject);
begin
  if B013FIntegrazioneEMKDtM.DbIris032.Connected then
  begin
    lblDatabase.Font.Color:=clBlue;
    edtDatabase.Hint:='';
    lblDatabase.Font.Style:=[];
  end
  else
  begin
    lblDatabase.Font.Color:=clRed;
    edtDatabase.Hint:='Database non connesso';
    edtDatabase.ShowHint:=True;
    lblDatabase.Font.Style:=[fsStrikeOut];
  end;
  CreaC004(B013FIntegrazioneEMKDtM.DbIris032,'B013',Parametri.ProgOper);
  GetParametriFunzione;
  AbilitaFunzioni(True);
  LetturaLog;
  //Setto lettura ora ogni minuto
  Timer1.Interval:=60000;
  Timer1Timer(nil);
  if speMaxRigheLog.Value < 10 then
    speMaxRigheLog.Value:=10;
end;

procedure TB013FIntegrazioneEMK.GetParametriFunzione;
begin
  if C004FParamForm.GetParametro('AUTOMATICO','N') = 'S' then
  begin
    actAttiva.Checked:=True;
    actAttiva.Enabled:=True;
    actSospendi.Checked:=False;
    actSospendi.Enabled:=False;
    actEsegui.Enabled:=False;
    actPianificazione.Enabled:=False;
  end
  else
  begin
    actAttiva.Checked:=False;
    actAttiva.Enabled:=False;
    actSospendi.Checked:=True;
    actSospendi.Enabled:=True;
    actEsegui.Enabled:=True;
    actPianificazione.Enabled:=True;
  end;
  speMaxRigheLog.Text:=C004FParamForm.GetParametro('MAXRIGHELOG','0');
  chkChiudiTermineElab.Checked:=(C004FParamForm.GetParametro('chkChiudiElab','') = 'S');
  edtAbMensa.Text:=C004FParamForm.GetParametro('edtAbMensa','');
end;

procedure TB013FIntegrazioneEMK.PutParametriFunzione;
begin
  C004FParamForm.Cancella001;
  if actAttiva.Checked then
    C004FParamForm.PutParametro('AUTOMATICO','S')
  else
    C004FParamForm.PutParametro('AUTOMATICO','N');
  C004FParamForm.PutParametro('MAXRIGHELOG',speMaxRigheLog.Text);
  if chkChiudiTermineElab.Checked then
    C004FParamForm.PutParametro('chkChiudiElab','S')
  else
    C004FParamForm.PutParametro('chkChiudiElab','N');
  C004FParamForm.PutParametro('edtAbMensa',edtAbMensa.Text);
  try B013FIntegrazioneEMKDtM.DbIris032.Commit; except end;
end;

procedure TB013FIntegrazioneEMK.AbilitaFunzioni(ScaricoInCorso:Boolean);
begin
  actAttiva.Checked:=not ScaricoInCorso;
  actAttiva.Enabled:=not ScaricoInCorso;
  actSospendi.Checked:=ScaricoInCorso;
  actSospendi.Enabled:=ScaricoInCorso;
  actEsegui.Enabled:=not ScaricoInCorso;
  actPianificazione.Enabled:=not ScaricoInCorso;
  actEsci.Enabled:=not ScaricoInCorso;
  Timer1.Enabled:=ScaricoInCorso;
  if ScaricoInCorso then
    stbIntegrazione.SimpleText:='Integrazione attiva'
  else
    stbIntegrazione.SimpleText:='Integrazione disattiva';
  stbIntegrazione.Repaint;  
end;

procedure TB013FIntegrazioneEMK.Timer1Timer(Sender: TObject);
begin
  if B013FIntegrazioneEMKDtM.selI103.SearchRecord('ORA',FormatDateTime('hh.nn',Now),[srFromBeginning]) then
  begin
    AggiornaTabelle;
    if chkChiudiTermineElab.Checked then
      Application.Terminate;
  end;
end;

procedure TB013FIntegrazioneEMK.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if not actEsci.Enabled then
    Action:=caNone
  else
  begin
    PutParametriFunzione;
    C004FParamForm.Free;
  end;
end;

procedure TB013FIntegrazioneEMK.actEsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TB013FIntegrazioneEMK.actPianificazioneExecute(Sender: TObject);
begin
  B013FPianificazioneIntegrazione.ShowModal;
  B013FIntegrazioneEMKDtM.selI103.Refresh;
end;

procedure TB013FIntegrazioneEMK.actVisualizzaLogExecute(Sender: TObject);
begin
  LetturaLog;
end;

procedure TB013FIntegrazioneEMK.actAttivaExecute(Sender: TObject);
begin
  AbilitaFunzioni(True);
end;

procedure TB013FIntegrazioneEMK.actSospendiExecute(Sender: TObject);
begin
  AbilitaFunzioni(False);
end;

procedure TB013FIntegrazioneEMK.actEseguiExecute(Sender: TObject);
begin
  AggiornaTabelle;
end;

procedure TB013FIntegrazioneEMK.AggiornaTabelle;
begin
  Screen.Cursor:=crHourGlass;
  try
    B013FIntegrazioneEMKDtM.Scarico(True);
  except
  end;
  LetturaLog;
  Screen.Cursor:=crDefault;
end;

procedure TB013FIntegrazioneEMK.LetturaLog;
begin
  Memo1.Clear;
  try
    RegistraMsg.LeggiMessaggi('B013');
    RegistraMsg.GetListaMessaggi(Memo1.Lines,speMaxRigheLog.Value,'',[miMessaggio]);
  except
    on E:Exception do
      R180MessageBox('Errore durante la visualizzazione dei log:' + #13#10 +
                     E.Message,INFORMA);
  end;
end;

procedure TB013FIntegrazioneEMK.actCancellaTimbratureExecute(
  Sender: TObject);
//Cancello le timbrature sulla tabella oracle di appoggio fino alla data...
var
  DataCanc: TDateTime;
  RigheElaborate: Integer;
begin
  with B013FIntegrazioneEMKDtM do
  begin
    delEMKTimb.Close;
    delMicrTimb.Close;
    DataCanc:=DataOut(Date,'Ultimo giorno da cancellare','G');
    if R180MessageBox('Confermi la cancellazione delle timbrature del file' + #13#10 +
                      'di appoggio fino al ' + DateToStr(DataCanc) + ' compreso?',DOMANDA) = mrYes then
    begin
      RegistraMsg.IniziaMessaggio('B013');
      RegistraMsg.InserisciMessaggio('I',FormatDateTime('dd/mm/yyyy hh.nn ',Now) + '- CANC. TIMB. FINO AL ' + DateToStr(DataCanc) + ' -');
      //Cancello le timbrature EMK
      try
        delEMKTimb.SetVariable('DataCancellazione',DataCanc);
        delEMKTimb.Execute;
        RigheElaborate:=delEMKTimb.GetVariable('RigheElaborate');
        RegistraMsg.InserisciMessaggio('I',' Cancellazione EMK di ' + IntToStr(RigheElaborate) + ' righe avvenuta con successo');
      except
        RegistraMsg.InserisciMessaggio('I',' Cancellazione EMK fallita!');
      end;
      //Se esistono le tabelle cancello le timbrature Microntel
      if TabelleMicr = 'S' then
      begin
        try
          delMicrTimb.SetVariable('DataCancellazione',DataCanc);
          delMicrTimb.Execute;
          RigheElaborate:=delMicrTimb.GetVariable('RigheElaborate');
          RegistraMsg.InserisciMessaggio('I',' Cancellazione Microntel di ' + IntToStr(RigheElaborate) + ' righe avvenuta con successo');
        except
          RegistraMsg.InserisciMessaggio('I',' Cancellazione Microntel fallita!');
        end;
      end;
      LetturaLog;
    end;
  end;
end;

procedure TB013FIntegrazioneEMK.edtAbMensaChange(Sender: TObject);
begin
  if edtAbMensa.Text <> '' then
  begin
    try
      StrToInt(edtAbMensa.Text);
    except
      raise exception.create('Il codice di abilitazione mensa, se definito deve essere numerico');
    end;
  end;
end;

procedure TB013FIntegrazioneEMK.btnDataBaseClick(Sender: TObject);
var Db,DbOld:String;
begin
  Db:=edtDatabase.Text;
  DbOld:=Db;
  if InputQuery('Connessione al database','Database:',Db) then
    with B013FIntegrazioneEMKDtM do
    begin
      R180PutRegistro(HKEY_LOCAL_MACHINE,'B013','Database',Db);
      DataModuleCreate(nil);
      if B013FIntegrazioneEMKDtM.DbIris032.Connected then
        edtDatabase.Text:=Db
      else
      begin
        R180PutRegistro(HKEY_LOCAL_MACHINE,'B013','Database',DbOld);
        DataModuleCreate(nil);
      end;
      FormActivate(nil);
    end;
end;

end.
