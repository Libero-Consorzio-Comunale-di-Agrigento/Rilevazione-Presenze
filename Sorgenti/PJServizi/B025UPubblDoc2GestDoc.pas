unit B025UPubblDoc2GestDoc;

interface

uses
  A000UCostanti,
  B025UPubblDoc2GestDocDM,
  A118UPubblicazioneDocumentiMW,
  C180FunzioniGenerali,
  FunzioniGenerali,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.IOUtils, System.StrUtils, System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, System.UITypes;

type
  TB025FPubblDoc2GestDoc = class(TForm)
    grpStruttura: TGroupBox;
    Label1: TLabel;
    lblRoot: TLabel;
    cmbStrutture: TComboBox;
    edtRootDir: TEdit;
    grpTipologia: TGroupBox;
    cmbTipologie: TComboBox;
    Label2: TLabel;
    lblStruttura: TLabel;
    lblTipologia: TLabel;
    lblContaDocumenti: TLabel;
    pnlButtons: TPanel;
    btnEsegui: TButton;
    rgpOperazione: TRadioGroup;
    btnResetUI: TButton;
    lblInfoRootDir: TLabel;
    btnMostraRootDir: TButton;
    pnlLog: TPanel;
    memLogOperazione: TMemo;
    memFileNonIndicizzati: TMemo;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure cmbStruttureChange(Sender: TObject);
    procedure cmbTipologieChange(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure rgpOperazioneClick(Sender: TObject);
    procedure btnResetUIClick(Sender: TObject);
    procedure btnMostraRootDirClick(Sender: TObject);
  private
    FA118MW: TA118FPubblicazioneDocumentiMW;
    procedure InizializzaInterfaccia;
    procedure CaricaElencoStrutture;
    procedure CaricaElencoTipologie;
    procedure ScorriPath(const PDirNameCompleto: String; PLiv: Integer);
    procedure AllineaElementiUI;
  public
    procedure NotificaCountT960(const PTipologia: String; const PCountDocumenti: Integer);
  end;

var
  B025FPubblDoc2GestDoc: TB025FPubblDoc2GestDoc;

implementation

uses
  C021UDocumentiManagerDM,
  System.Diagnostics, Winapi.ShellAPI;

{$R *.dfm}

procedure TB025FPubblDoc2GestDoc.FormShow(Sender: TObject);
begin
  FA118MW:=B025FPubblDoc2GestDocDM.A118MW;

  // inizializzazione interfaccia
  InizializzaInterfaccia;
end;

procedure TB025FPubblDoc2GestDoc.InizializzaInterfaccia;
begin
  // carica elenco strutture I200
  CaricaElencoStrutture;

  // carica elenco tipologie documenti T962
  CaricaElencoTipologie;

  // abilita interfaccia
  rgpOperazione.Enabled:=True;
  grpStruttura.Enabled:=True;
  grpTipologia.Enabled:=True;

  // annulla scelta operazione
  rgpOperazione.OnClick:=nil;
  rgpOperazione.ItemIndex:=-1;
  rgpOperazione.OnClick:=rgpOperazioneClick;

  // nasconde groupbox scelta struttura
  grpStruttura.Visible:=False;

  // nasconde groupbox scelta tipologia
  grpTipologia.Visible:=False;

  // nasconde memo
  pnlLog.Visible:=False;

  // disabilita pulsante esegui
  btnEsegui.Enabled:=False;
end;

procedure TB025FPubblDoc2GestDoc.AllineaElementiUI;
begin
  grpTipologia.Top:=0;
  grpStruttura.Top:=0;
  rgpOperazione.Top:=0;
end;

procedure TB025FPubblDoc2GestDoc.CaricaElencoStrutture;
// popola la combobox di elenco tipologie
var
  LFiltro: string;
begin
  lblStruttura.Caption:='';

  if rgpOperazione.ItemIndex = 0 then
    LFiltro:=Format('SORGENTE_DOCUMENTI = %s',[SORGENTE_FS_EXT.QuotedString])
  else
    LFiltro:=Format('(SORGENTE_DOCUMENTI = %s) and (ROOT <> null)',[SORGENTE_T960.QuotedString]);

  cmbStrutture.Items.BeginUpdate;
  try
    cmbStrutture.Items.Clear;
    // estrazione delle sole tipologie di documento con sorgente file system
    // (non considera i filtri di visualizzazione)
    FA118MW.selI200.Close;
    FA118MW.selI200.Filtered:=False;
    FA118MW.selI200.Filter:=LFiltro;
    FA118MW.selI200.Filtered:=True;
    FA118MW.selI200.Open;
    FA118MW.selI200.First;
    while not FA118MW.selI200.Eof do
    begin
      cmbStrutture.Items.Add(FA118MW.selI200.FieldByName('CODICE').AsString);
      FA118MW.selI200.Next;
    end;
  finally
    cmbStrutture.Items.EndUpdate;
  end;
end;

procedure TB025FPubblDoc2GestDoc.CaricaElencoTipologie;
var
  LCodice: String;
begin
  lblTipologia.Caption:='';
  lblContaDocumenti.Caption:='';

  // carica elenco tipologie
  cmbTipologie.Items.BeginUpdate;
  try
    cmbTipologie.Items.Clear;

    B025FPubblDoc2GestDocDM.selT962Lookup.Close;
    B025FPubblDoc2GestDocDM.selT962Lookup.Open;
    while not B025FPubblDoc2GestDocDM.selT962Lookup.Eof do
    begin
      LCodice:=B025FPubblDoc2GestDocDM.selT962Lookup.FieldByName('CODICE').AsString;
      if not TFunzioniGenerali._In(LCodice,[DOC_TIPOL_PREDEF,DOC_TIPOL_ITER,DOC_TIPOL_INPS]) then
        cmbTipologie.Items.Add(LCodice);
      B025FPubblDoc2GestDocDM.selT962Lookup.Next;
    end;
  finally
    cmbTipologie.Items.EndUpdate;
  end;
end;

procedure TB025FPubblDoc2GestDoc.rgpOperazioneClick(Sender: TObject);
begin
  // carica l'elenco delle strutture
  CaricaElencoStrutture;

  // selezione tipologia attiva se operazione = indicizzazione
  grpStruttura.Visible:=True;
  lblRoot.Caption:=IfThen(rgpOperazione.ItemIndex = 0,'Directory radice','Tipologia');
  edtRootDir.Text:='';
  lblInfoRootDir.Visible:=False;
  btnMostraRootDir.Visible:=False;

  // nasconde groupbox selezione tipologia
  grpTipologia.Visible:=False;

  AllineaElementiUI;

  // disabilita pulsante esegui
  btnEsegui.Enabled:=False;
end;

procedure TB025FPubblDoc2GestDoc.cmbStruttureChange(Sender: TObject);
var
  LSorg: String;
begin
  // imposta codice tipologia documento
  FA118MW.Codice:=cmbStrutture.Text;
  lblStruttura.Caption:=VarToStr(FA118MW.selI200.Lookup('CODICE',FA118MW.Codice,'DESCRIZIONE'));

  LSorg:=VarToStr(FA118MW.selI200.Lookup('CODICE',FA118MW.Codice,'SORGENTE_DOCUMENTI'));

  if LSorg = SORGENTE_T960 then
  begin
    // documentale
    edtRootDir.Text:=VarToStr(FA118MW.selI200.Lookup('CODICE',FA118MW.Codice,'TIPOLOGIA_DOCUMENTI'));
    edtRootDir.Font.Color:=TColorRec.SysWindowText;
  end
  else
  begin
    // cartella esterna
    edtRootDir.Text:=FA118MW.RootDir;
    if TDirectory.Exists(FA118MW.RootDir) then
    begin
      edtRootDir.Font.Color:=TColorRec.SysWindowText;
      lblInfoRootDir.Visible:=False;
    end
    else
    begin
      edtRootDir.Font.Color:=TColorRec.Red;
      lblInfoRootDir.Visible:=True;
    end;
  end;
  btnMostraRootDir.Visible:=(LSorg = SORGENTE_FS_EXT);

  // visualizza groupbox selezione tipologia
  grpTipologia.Visible:=(LSorg = SORGENTE_FS_EXT) and (cmbStrutture.ItemIndex >= 0);

  AllineaElementiUI;

  // abilitazione pulsante esegui
  btnEsegui.Enabled:=(not grpTipologia.Visible);
end;

procedure TB025FPubblDoc2GestDoc.cmbTipologieChange(Sender: TObject);
var
  LCodice: String;
begin
  LCodice:=cmbTipologie.Text;
  lblTipologia.Caption:=VarToStr(B025FPubblDoc2GestDocDM.selT962Lookup.Lookup('CODICE',LCodice,'DESCRIZIONE'));

  lblContaDocumenti.Caption:='Conteggio documenti...';
  lblContaDocumenti.Font.Color:=TColorRec.SysWindowText;
  B025FPubblDoc2GestDocDM.selCountT960.SetVariable('TIPOLOGIA',LCodice);
  B025FPubblDoc2GestDocDM.selCountT960.Execute;

  // abilitazione pulsante esegui
  btnEsegui.Enabled:=True;
end;

procedure TB025FPubblDoc2GestDoc.NotificaCountT960(const PTipologia: String;
  const PCountDocumenti: Integer);
begin
  if PCountDocumenti = 0 then
  begin
    lblContaDocumenti.Caption:='Nessun documento presente in archivio';
    lblContaDocumenti.Font.Color:=TColorRec.SysWindowText;
  end
  else
  begin
    lblContaDocumenti.Caption:=Format('Attenzione! Sono già presenti %d documenti in archivio',[PCountDocumenti]);
    lblContaDocumenti.Font.Color:=TColorRec.Red;
  end;
end;

procedure TB025FPubblDoc2GestDoc.btnResetUIClick(Sender: TObject);
begin
  // richiede conferma
  if R180MessageBox('Si desidera annullare le impostazioni selezionate?',DOMANDA) = mrNo then
    Exit;

  InizializzaInterfaccia;
end;

procedure TB025FPubblDoc2GestDoc.btnMostraRootDirClick(Sender: TObject);
begin
  ShellExecute(0,'open','','',PChar(FA118MW.RootDir),SW_SHOWNORMAL);
end;

procedure TB025FPubblDoc2GestDoc.btnEseguiClick(Sender: TObject);
var
  LStopWatch: TStopWatch;
  LOperazione: String;
  LTipologia: String;
begin
  // controlli
  if rgpOperazione.ItemIndex = -1 then
  begin
    R180MessageBox('Selezionare l''operazione da eseguire!',ESCLAMA);
    Exit;
  end;

  LOperazione:=IfThen(rgpOperazione.ItemIndex = 0,'indicizzazione','annullamento indicizzazione');

  // struttura
  if cmbStrutture.ItemIndex = -1 then
  begin
    R180MessageBox(Format('Selezionare la struttura per cui eseguire l''%s!',[LOperazione]),ESCLAMA);
    Exit;
  end;

  // tipologia per indicizzazione
  if grpTipologia.Visible then
  begin
    if cmbTipologie.ItemIndex = -1 then
    begin
      R180MessageBox('Selezionare la tipologia di documenti da associare ai file!',ESCLAMA);
      Exit;
    end;
  end;

  // richiede conferma
  if R180MessageBox(Format('Stai per eseguire l''%s della struttura "%s"?'#13#10'Vuoi continuare?',[LOperazione,cmbStrutture.Text]),DOMANDA) = mrNo then
    Exit;

  LStopWatch:=TStopwatch.StartNew;
  Screen.Cursor:=crHourGlass;
  memLogOperazione.Lines.BeginUpdate;
  memFileNonIndicizzati.Lines.BeginUpdate;
  try
    try
      memLogOperazione.Lines.Clear;
      memFileNonIndicizzati.Lines.Clear;
      memFileNonIndicizzati.Lines.Add('Lista dei file non indicizzati');

      if rgpOperazione.ItemIndex = 0 then
      begin
        // indicizzazione dei file su T960

        // naviga la struttura delle cartelle per indicizzare i file su db
        ScorriPath(FA118MW.RootDir,-1);

        // imposta la tipologia sulla struttura I200
        B025FPubblDoc2GestDocDM.ImpostaSorgenteDocumentale(cmbStrutture.Text,cmbTipologie.Text);
      end
      else
      begin
        // annulla indicizzazione
        LTipologia:=VarToStr(FA118MW.selI200.Lookup('CODICE',FA118MW.Codice,'TIPOLOGIA_DOCUMENTI'));
        B025FPubblDoc2GestDocDM.AnnullaIndicizzazioneStruttura(cmbStrutture.Text,LTipologia);
      end;

      // operazione ok
      if memLogOperazione.Lines.Count > 0 then
      begin
        memLogOperazione.Lines.Add('');
        memLogOperazione.Lines.Add(StringOfChar('-',80));
      end;
      memLogOperazione.Lines.Add('Operazione completata');
    except
      on E: Exception do
      begin
        R180MessageBox(Format('Errore durante l''indicizzazione dei documenti:'#13#10'%s',[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    // stop timer di precisione
    LStopWatch.Stop;

    // disabilita interfaccia
    rgpOperazione.Enabled:=False;
    grpStruttura.Enabled:=False;
    grpTipologia.Enabled:=False;
    btnEsegui.Enabled:=False;

    memLogOperazione.Lines.EndUpdate;
    memFileNonIndicizzati.Lines.EndUpdate;
    memFileNonIndicizzati.Visible:=(rgpOperazione.ItemIndex = 0);
    pnlLog.Visible:=True;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TB025FPubblDoc2GestDoc.ScorriPath(const PDirNameCompleto: String; PLiv: Integer);
// questa procedura utilizza chiamate ricorsive per attraversare le strutture
// delle directory, per cui vengono utilizzati i puntatori per mantenere
// minimo l'utilizzo dello stack.
{$WARN SYMBOL_PLATFORM OFF}
var
  LSearchRec: ^TSearchRec;
  LFileName: PString;
  LNumFile: Integer;
  LIsFile: Boolean;
  LResCtrlFolder: TResCtrl;
  LResCtrlFile: TResCtrl;
  LResCtrl: TResCtrl;
  LSearchPath: String;
  LDirName: String;
  LPrefisso: String;
  LErrFolder: String;
  LErrFile: String;
  LLivObj: TLivello;
begin
  if PDirNameCompleto.Trim = '' then
    Exit;

  // estrae il nome della directory attuale (senza path completo)
  LDirName:=TPath.GetFileName(PDirNameCompleto);

  // effettua controlli per i livelli definiti sulla struttura

  // verifica cartella
  LResCtrlFolder.Ok:=True;
  LResCtrlFolder.Messaggio:='';
  LErrFolder:='';
  if TFunzioniGenerali.Between(PLiv,0,FA118MW.LivMaxDir) then
  begin
    // verifica se la cartella soddisfa i requisiti del nome e l'eventuale filtro
    LLivObj:=FA118MW.Livello[PLiv];
    LLivObj.NomeFile:=LDirName;
    LResCtrlFolder:=LLivObj.MatchNome(TTipoTest.Formale);
    if LResCtrlFolder.Ok then
    begin
      LResCtrlFolder:=LLivObj.MatchFiltro(TTipoTest.Dipendente);
      if not LResCtrlFolder.Ok then
        LErrFolder:=Format('   >>> ERR_FILTRO >>> %s',[LResCtrlFolder.Messaggio]);
    end
    else
    begin
      LErrFolder:=Format('   >>> ERR_NOME >>> %s',[LResCtrlFolder.Messaggio]);
    end;
  end;

  // dettaglio dell'attraversamento della struttura
  if PLiv = -1 then
    LPrefisso:=Format('%3s   ',['B'])
  else
    LPrefisso:=Format('%3d    ',[PLiv]) + DupeString('|    ',PLiv) + '|-- ';
  memLogOperazione.Lines.Add(LPrefisso + LDirName + LErrFolder);

  // esce se la cartella non è da considerare
  if not LResCtrlFolder.Ok then
    Exit;

  // disabilita input/output checking
  {$I-}

  // alloca un nuovo record (SearchRec) e una nuova string (FileName)
  New(LSearchRec);
  New(LFileName);

  // esamina i file presenti nella cartella
  try
    inc(PLiv);
    if PLiv >= FA118MW.LivFile  then
      LSearchPath:='*.' + FA118MW.Livello[FA118MW.LivFile].ExtI201
    else
      LSearchPath:='*.*';
    LSearchPath:=TPath.Combine(PDirNameCompleto,LSearchPath);
    LNumFile:=System.SysUtils.FindFirst(LSearchPath,System.SysUtils.faAnyFile,LSearchRec^);
    while LNumFile = 0 do
    begin
      LFileName^:=TPath.Combine(PDirNameCompleto,LSearchRec^.Name);

      // verifica il tipo di file: directory oppure file
      LIsFile:=((LSearchRec^.Attr and System.SysUtils.faDirectory) = 0);
      if LIsFile then
      begin
        // tipo: file
        // considera i file a partire dal livello in cui è indicata l'estensione nella struttura
        if PLiv >= FA118MW.LivFile then
        begin
          // -> esclude i file di sistema e i volume ID (C:, D:, ecc...)
          if ((LSearchRec^.Attr and System.SysUtils.faSysFile) = 0) then
          begin
            // IMPORTANTE
            //   anche se il livello è più alto di quello configurato nella struttura considera sempre il livello file
            LErrFile:='';
            LLivObj:=FA118MW.Livello[FA118MW.LivFile];
            LLivObj.PathFile:=TPath.GetDirectoryName(LFileName^);
            LLivObj.NomeFile:=TPath.GetFileName(LFileName^);
            LResCtrlFile:=LLivObj.MatchNome(TTipoTest.Formale);
            if LResCtrlFile.Ok then
            begin
              LResCtrlFile:=LLivObj.MatchFiltro(TTipoTest.Formale);
              if LResCtrlFile.Ok then
              begin
                LResCtrl:=B025FPubblDoc2GestDocDM.InserisciT960(LLivObj);
                if not LResCtrl.Ok then
                begin
                  LErrFile:=Format('   >>> ERR_INDICIZZAZIONE >>> %s',[LResCtrlFile.Messaggio]);
                  memFileNonIndicizzati.Lines.Add(LLivObj.GetNomeFileCompleto);
                end;
              end
              else
                LErrFile:=Format('   >>> ERR_FILTRO >>> %s',[LResCtrlFile.Messaggio]);
            end
            else
            begin
              LErrFile:=Format('   >>> ERR_NOME >>> %s',[LResCtrlFile.Messaggio]);
            end;

            LPrefisso:=Format('%3d    ',[LLivObj.Livello]) + DupeString('|    ',PLiv) + '|-- ';
            memLogOperazione.Lines.Add(LPrefisso + LLivObj.NomeFile + '.' + LLivObj.ExtFile + LErrFile);
          end;
        end;
      end
      else
      begin
        // tipo: directory
        // -> esclude le directory speciali "." e ".."
        if ((LSearchRec^.Name <> '.') and (LSearchRec^.Name <> '..')) then
        begin
          // -> chiamata ricorsiva
          ScorriPath(LFileName^,PLiv);
        end;
      end;
      LNumFile:=System.SysUtils.FindNext(LSearchRec^);
    end;

    System.SysUtils.FindClose(LSearchRec^);
  finally
    // rilascia la memoria allocata per le strutture
    System.Dispose(LFileName);
    System.Dispose(LSearchRec);
  end;

  // riabilita input/output checking
  {$I+}
{$WARN SYMBOL_PLATFORM ON}
end;

initialization
  // configura il logger
  TLogger.Configure(TLogOptions.Create('Utility B025',True,True,R180GetPathLog,'B025.csl'));

end.
