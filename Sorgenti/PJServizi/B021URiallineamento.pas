unit B021URiallineamento;

interface

uses
  B021UUtils, B021URiallineamentoDM,
  C180FunzioniGenerali, OracleData, StrUtils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, DB, DBClient, Grids, DBGrids, ComCtrls, Spin;

type
  TB021FRiallineamento = class(TForm)
    btnEsegui: TButton;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    lblServerUrl: TLabel;
    cmbServerURL: TComboBox;
    dgrdOperazioni: TDBGrid;
    cdsOperazioni: TClientDataSet;
    cdsOperazioniTIPO: TStringField;
    cdsOperazioniDESCRIZIONE: TStringField;
    dsrOperazioni: TDataSource;
    grpMetodi: TGroupBox;
    edtMetodoIns: TEdit;
    lblMetodoDel: TLabel;
    edtMetodoDel: TEdit;
    lblMetodoIns: TLabel;
    cdsOperazioniSTEP: TIntegerField;
    pgbElaborazione: TProgressBar;
    sbMain: TStatusBar;
    memLog: TMemo;
    grpOpzioni: TGroupBox;
    lblElementi: TLabel;
    chkFiddler: TCheckBox;
    chkModoTest: TCheckBox;
    sedtElementi: TSpinEdit;
    chkFiltro: TCheckBox;
    cdsOperazioniTOTALE: TIntegerField;
    cdsOperazioniFILTRO: TStringField;
    chkIndici: TCheckBox;
    cdsOperazioniFLAG_ESEGUI: TStringField;
    procedure btnEseguiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkModoTestClick(Sender: TObject);
    procedure chkFiltroClick(Sender: TObject);
  private
    procedure AddLog(const PRiga: string; var RMemo: TMemo);
    procedure GestioneChiamata(const PTipo, PPostData, PPostData2: String);
    procedure GestioneStep(const PStep: Integer; const PTipo: String);
    function  EseguiMetodoRest(const PUrl, PJsonData: string): String;
  end;

var
  B021FRiallineamento: TB021FRiallineamento;

const
  OP_INSERT   = 'I';
  OP_DELETE   = 'D';
  OP_REINSERT = 'R';

implementation

{$R *.dfm}

procedure TB021FRiallineamento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOperazioni.EmptyDataSet;
  cdsOperazioni.Insert;
  cdsOperazioni.FieldByName('FLAG_ESEGUI').AsString:='N';
  cdsOperazioni.FieldByName('STEP').AsInteger:=1;
  cdsOperazioni.FieldByName('TIPO').AsString:=OP_DELETE;
  cdsOperazioni.FieldByName('DESCRIZIONE').AsString:='Presenti in Firlab e non in IrisWIN (T040 + T050): da cancellare';
  cdsOperazioni.FieldByName('TOTALE').AsInteger:=0;
  cdsOperazioni.FieldByName('FILTRO').AsString:='where progressivo = 1570 and causale = ''99001''';
  cdsOperazioni.Post;

  cdsOperazioni.Insert;
  cdsOperazioni.FieldByName('FLAG_ESEGUI').AsString:='N';
  cdsOperazioni.FieldByName('STEP').AsInteger:=2;
  cdsOperazioni.FieldByName('TIPO').AsString:=OP_INSERT;
  cdsOperazioni.FieldByName('DESCRIZIONE').AsString:='Presenti in IrisWIN (T040) e non in Firlab: da inserire con Autorizzata = true';
  cdsOperazioni.FieldByName('TOTALE').AsInteger:=0;
  cdsOperazioni.FieldByName('FILTRO').AsString:='where progressivo = 1570';
  cdsOperazioni.Post;

  cdsOperazioni.Insert;
  cdsOperazioni.FieldByName('FLAG_ESEGUI').AsString:='N';
  cdsOperazioni.FieldByName('STEP').AsInteger:=3;
  cdsOperazioni.FieldByName('TIPO').AsString:=OP_INSERT;
  cdsOperazioni.FieldByName('DESCRIZIONE').AsString:='Presenti in IrisWIN (T050 da elaborare) e non in Firlab: da inserire con Autorizzata = false';
  cdsOperazioni.FieldByName('TOTALE').AsInteger:=0;
  cdsOperazioni.FieldByName('FILTRO').AsString:='where progressivo = 8301';
  cdsOperazioni.Post;

  cdsOperazioni.Insert;
  cdsOperazioni.FieldByName('FLAG_ESEGUI').AsString:='N';
  cdsOperazioni.FieldByName('STEP').AsInteger:=4;
  cdsOperazioni.FieldByName('TIPO').AsString:=OP_REINSERT;
  cdsOperazioni.FieldByName('DESCRIZIONE').AsString:='Presenti in IrisWIN (T040) e in Firlab Autorizzata = false: reinserire con Autorizzata = true';
  cdsOperazioni.FieldByName('TOTALE').AsInteger:=0;
  cdsOperazioni.FieldByName('FILTRO').AsString:='where progressivo = 1570';
  cdsOperazioni.Post;

  cdsOperazioni.Insert;
  cdsOperazioni.FieldByName('FLAG_ESEGUI').AsString:='N';
  cdsOperazioni.FieldByName('STEP').AsInteger:=5;
  cdsOperazioni.FieldByName('TIPO').AsString:=OP_REINSERT;
  cdsOperazioni.FieldByName('DESCRIZIONE').AsString:='Presenti in IrisWIN (T050) e in Firlab Autorizzata = true: reinserire con Autorizzata = false';
  cdsOperazioni.FieldByName('TOTALE').AsInteger:=0;
  cdsOperazioni.FieldByName('FILTRO').AsString:='';
  cdsOperazioni.Post;

  // indici
  cdsOperazioni.IndexDefs.Add('Step','STEP',[ixUnique]);
  cdsOperazioni.IndexName:='Step';

  // campi protetti
  cdsOperazioni.FieldByName('STEP').ReadOnly:=True;
  cdsOperazioni.FieldByName('TIPO').ReadOnly:=True;
  cdsOperazioni.FieldByName('DESCRIZIONE').ReadOnly:=True;
  cdsOperazioni.FieldByName('TOTALE').ReadOnly:=True;

  // posizionamento su primo record
  cdsOperazioni.First;
end;

procedure TB021FRiallineamento.chkFiltroClick(Sender: TObject);
begin
  if chkFiltro.Checked then
    sedtElementi.Value:=5;
end;

procedure TB021FRiallineamento.chkModoTestClick(Sender: TObject);
begin
  chkFiddler.Enabled:=not chkModoTest.Checked;
  if not chkFiddler.Enabled then
    chkFiddler.Checked:=False;
end;

procedure TB021FRiallineamento.AddLog(const PRiga: string; var RMemo: TMemo);
var
  Testo: String;
begin
  Testo:=FormatDateTime('hhhh.mm.ss',Now);
  Testo:=Format('%s - %s',[Testo,PRiga]);
  RMemo.Lines.Add(Testo);
  RMemo.Repaint;
end;

procedure TB021FRiallineamento.btnEseguiClick(Sender: TObject);
var
  Tipo: String;
  Step: Integer;
begin
  Screen.Cursor:=crHourGlass;
  memLog.Clear;
  AddLog('Inizio allineamento',memLog);

  // crea indici
  if chkIndici.Checked then
  begin
    AddLog('Creazione indici temporanei per query di allineamento...',memLog);
    try
      B021FRiallineamentoDM.scrPrepara.Execute;
      AddLog('Creazione indici completata',memLog);
    except
      AddLog('Creazione indici non completata',memLog);
    end;
  end;

  // ciclo di operazioni
  cdsOperazioni.First;
  while not cdsOperazioni.Eof do
  begin
    if cdsOperazioni.FieldByName('FLAG_ESEGUI').AsString = 'S' then
    begin
      Step:=cdsOperazioni.FieldByName('STEP').AsInteger;
      Tipo:=cdsOperazioni.FieldByName('TIPO').AsString;

      GestioneStep(Step,Tipo);
    end;
    cdsOperazioni.Next;
  end;

  // elimina indici
  if chkIndici.Checked then
  begin
    AddLog('Eliminazione indici temporanei per query di allineamento...',memLog);
    try
      B021FRiallineamentoDM.scrTermina.Execute;
      AddLog('Eliminazione indici completata',memLog);
    except
      AddLog('Eliminazione indici non completata',memLog);
    end;
  end;

  // termina
  sbMain.SimpleText:='Allineamento completato';
  sbMain.Repaint;
  AddLog(StringOfChar('-',30),memLog);
  AddLog('Allineamento completato',memLog);
  pgbElaborazione.Position:=0;
  Screen.Cursor:=crDefault;
end;

procedure TB021FRiallineamento.GestioneStep(const PStep: Integer; const PTipo: String);
var
  Testo, PostData, PostData2, JsonItem, JsonItem2, OpStr, Filtro: string;
  selOp: TOracleDataset;
  //conta: Integer;
begin
  pgbElaborazione.Position:=0;
  Testo:=Format('Passaggio %d',[PStep]);
  AddLog(StringOfChar('-',30),memLog);
  AddLog(Format('%s: inizio',[Testo]),memLog);
  sbMain.SimpleText:=Testo;
  sbMain.Repaint;

  Filtro:='';
  case PStep of
    1: begin
         selOp:=B021FRiallineamentoDM.selStep1;
       end;
    2: begin
         selOp:=B021FRiallineamentoDM.selStep2;
       end;
    3: begin
         selOp:=B021FRiallineamentoDM.selStep3;
       end;
    4: begin
         selOp:=B021FRiallineamentoDM.selStep4;
       end;
    5: begin
         selOp:=B021FRiallineamentoDM.selStep5;
       end;
    else
      raise Exception.Create(Format('Passaggio %d non previsto!',[PStep]));
  end;

  sbMain.SimpleText:=Testo + ': calcolo assenze da allineare...';
  sbMain.Repaint;

  // apertura dataset
  selOp.ClearVariables;
  if chkFiltro.Checked then
    selOp.SetVariable('FILTRO',cdsOperazioni.FieldByName('FILTRO').AsString);
  selOp.Close;
  selOp.Open;

  cdsOperazioni.FieldByName('TOTALE').ReadOnly:=False;
  cdsOperazioni.Edit;
  cdsOperazioni.FieldByName('TOTALE').AsInteger:=selOp.RecordCount;
  cdsOperazioni.Post;
  cdsOperazioni.FieldByName('TOTALE').ReadOnly:=True;

  // stato elaborazione
  pgbElaborazione.Max:=selOp.RecordCount;
  sbMain.SimpleText:=Format('%s: allineamento in corso di %d assenze...',[Testo,selOp.RecordCount]);
  sbMain.Repaint;
  if PTipo = OP_INSERT then
    OpStr:='inserire'
  else if PTipo = OP_DELETE then
    OpStr:='cancellare'
  else if PTipo = OP_REINSERT then
    OpStr:='reinserire';
  AddLog(Format('%s: %d assenze da %s su Firlab',[Testo,selOp.RecordCount,OpStr]),memLog);

  // ciclo elaborazione
  PostData:='';
  PostData2:='';
  while not selOp.Eof do
  begin
    // formatta la stringa json per la chiamata in post (per bug delphi)
    JsonItem:=PulisciStringaJson(selOp.FieldByName('POSTDATA').AsString);
    PostData:=PostData + IfThen(PostData <> '',',') + JsonItem;

    // formatta la stringa json per la chiamata in post 2
    if PTipo = OP_REINSERT then
    begin
      JsonItem2:=PulisciStringaJson(selOp.FieldByName('POSTDATA_2').AsString);
      PostData2:=PostData2 + IfThen(PostData2 <> '',',') + JsonItem2;
    end;

    if selOp.RecNo mod sedtElementi.Value = 0 then
    begin
      GestioneChiamata(PTipo,Format('{"justifications":[%s]}',[PostData]),
                             Format('{"justifications":[%s]}',[PostData2]));
      PostData:='';
      PostData2:='';
    end;

    pgbElaborazione.StepBy(1);
    pgbElaborazione.Repaint;
    selOp.Next;
  end;

  // chiamata per gli elementi dell'ultimo gruppo
  if PostData <> '' then
    GestioneChiamata(PTipo,Format('{"justifications":[%s]}',[PostData]),
                           Format('{"justifications":[%s]}',[PostData2]));

  sbMain.SimpleText:=Testo + ': terminata';
  sbMain.Repaint;
  AddLog(Format('%s: fine',[Testo]),memLog);
end;

procedure TB021FRiallineamento.GestioneChiamata(const PTipo, PPostData, PPostData2: String);
var
  UrlIns, UrlDel: String;
begin
    // url per inserimento / cancellazione
  UrlIns:=cmbServerURL.Text + edtMetodoIns.Text;
  UrlDel:=cmbServerURL.Text + edtMetodoDel.Text;

  if PTipo = OP_INSERT then
  begin
    // inserimento
    EseguiMetodoRest(UrlIns,PPostData);
  end
  else if PTipo = OP_DELETE then
  begin
    // cancellazione
    EseguiMetodoRest(UrlDel,PPostData);
  end
  else if PTipo = OP_REINSERT then
  begin
    // cancellazione e inserimento nuovo
    EseguiMetodoRest(UrlDel,PPostData);
    EseguiMetodoRest(UrlIns,PPostData2);
  end;
end;

function TB021FRiallineamento.EseguiMetodoRest(const PUrl, PJsonData: String): String;
var
  RBody: TStringStream;
begin
  // test
  if chkModoTest.Checked then
  begin
    AddLog('Chiamata',memLog);
    //AddLog(Format('Postdata: %s',[PJsonData]),memLog);
    Result:='ok';
    Exit;
  end;

  AddLog(Format('Chiamata metodo "%s", postdata: %s',[PUrl,PJsonData]),memLog);
  RBody:=TStringStream.Create(AnsiString(PJsonData));

  // per far vedere a Fiddler la richiesta
  if chkFiddler.Checked then
  begin
    IdHTTP1.ProxyParams.ProxyServer:='127.0.0.1';
    IdHTTP1.ProxyParams.ProxyPort:=8888;
  end
  else
  begin
    IdHTTP1.ProxyParams.ProxyServer:='';
    IdHTTP1.ProxyParams.ProxyPort:=0;
  end;

  IdHTTP1.Request.Accept:='text/javascript';
  IdHTTP1.Request.ContentType:='application/json';
  //IdHTTP1.Request.ContentEncoding:='utf-8';

  try
    try
      Result:=IdHTTP1.Post(PUrl,RBody);
      AddLog(Format('Chiamata ok "%s", risultato: %s',[PUrl,Result]),memLog);
    except
      AddLog(Format('Chiamata fallita "%s", risultato: %s',[PUrl,Result]),memLog);
    end;
  finally
    try FreeAndNil(RBody); except end;
  end;
end;

end.
