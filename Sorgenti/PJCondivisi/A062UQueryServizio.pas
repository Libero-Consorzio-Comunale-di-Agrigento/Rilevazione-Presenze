unit A062UQueryServizio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Winapi.ShellAPI,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGrids, checklst, Mask, Clipbrd,
  A000UCostanti, A000USessione,A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, Printers, C005UDatiAnagrafici,
  Menus,  Variants, Oracle, OracleData, {$IFNDEF ISO} A023UTimbrature, C700USelezioneAnagrafe,{$ENDIF}
  SelAnagrafe, StrUtils, RegistrazioneLog, Cestino, Vcl.DBCtrls, System.Diagnostics,
  Data.DB, C004UParamForm
  {$IFDEF ISO}, LDbInterno, Q000ULogin, Q010UClientiSedi, Q040UInstallazione, Q060UCommesse{$ENDIF}
  ;

type
  TA062FQueryServizio = class(TForm)
    pnlRisultati: TPanel;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PopupMenu3: TPopupMenu;
    Datianagrafici1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Splitter1: TSplitter;
    N1: TMenuItem;
    CopiaInExcel: TMenuItem;
    Copia2: TMenuItem;
    pnlGriglia: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlSelAnagrafe: TPanel;
    Panel5: TPanel;
    btnEsegui: TBitBtn;
    btnCarica: TBitBtn;
    btnSalva: TBitBtn;
    btnElimina: TBitBtn;
    btnPulisci: TBitBtn;
    frmSelAnagrafe: TfrmSelAnagrafe;
    Label7: TLabel;
    cmbQuery: TComboBox;
    PopupMenu1: TPopupMenu;
    Inseriscisubquerydallaselezioneanagrafica1: TMenuItem;
    Inseriscijoinconlaselezioneanagrafica1: TMenuItem;
    InseriscisubqueryEXISTSsullaselezioneanagrafica1: TMenuItem;
    Incollatesto1: TMenuItem;
    PanelTop: TPanel;
    Splitter2: TSplitter;
    Memo1: TMemo;
    dGrdVariabili: TDBGrid;
    grpRis: TGroupBox;
    BStampa: TBitBtn;
    BStampante: TBitBtn;
    BSalva: TBitBtn;
    btnCreaTab: TBitBtn;
    lblNomeTab: TLabel;
    edtNomeTab: TEdit;
    BCartellino: TBitBtn;
    prgBar: TProgressBar;
    chkIntestazione: TCheckBox;
    chkNoRitornoACapo: TCheckBox;
    chkProtetta: TCheckBox;
    lblRaggruppamento: TLabel;
    cmbRaggruppamenti: TComboBox;
    ppMnuAccediA101: TPopupMenu;
    Accedi1: TMenuItem;
    pnlMail: TPanel;
    grpMail: TGroupBox;
    pnlOggetto: TPanel;
    lblOggetto: TLabel;
    memoOggetto: TMemo;
    pnlMessaggio: TPanel;
    lblMessaggio: TLabel;
    pnlControlliMail: TPanel;
    btnInvioAuto: TBitBtn;
    BEMail: TBitBtn;
    rgpMailingList: TRadioGroup;
    memoMessaggio: TMemo;
    Splitter3: TSplitter;
    Contatti1: TMenuItem;
    Installazioni1: TMenuItem;
    Commesse1: TMenuItem;
    N2: TMenuItem;
    mnuSelezionaTutto: TMenuItem;
    mnuDeselezionaTutto: TMenuItem;
    mnuInvertiSelezione: TMenuItem;
    N3: TMenuItem;
    Salvasufile1: TMenuItem;
    InformatoExcel1: TMenuItem;
    InformatoCSV1: TMenuItem;
    InformatoTXT1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure BCartellinoClick(Sender: TObject);
    procedure BStampanteClick(Sender: TObject);
    procedure BStampaClick(Sender: TObject);
    procedure btnCaricaClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure Datianagrafici1Click(Sender: TObject);
    procedure cmbQueryDropDown(Sender: TObject);
    procedure btnEliminaClick(Sender: TObject);
    procedure cmbQueryDblClick(Sender: TObject);
    procedure btnPulisciClick(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Inseriscisubquerydallaselezioneanagrafica1Click(Sender: TObject);
    procedure Inseriscijoinconlaselezioneanagrafica1Click(Sender: TObject);
    procedure InseriscisubqueryEXISTSsullaselezioneanagrafica1Click(Sender: TObject);
    procedure Incollatesto1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure edtNomeTabChange(Sender: TObject);
    procedure edtNomeTabEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
    procedure cmbRaggruppamentiChange(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure BEMailClick(Sender: TObject);
    procedure btnInvioAutoClick(Sender: TObject);
    procedure Contatti1Click(Sender: TObject);
    procedure Installazioni1Click(Sender: TObject);
    procedure Commesse1Click(Sender: TObject);
    procedure mnuSelezionaTuttoClick(Sender: TObject);
    procedure SalvainCSVClick(Sender: TObject);
    procedure SalvainExcelClick(Sender: TObject);
    procedure SalvainTXT1Click(Sender: TObject);
    procedure BSalvaClick(Sender: TObject);
  private
    ColonnaCliente,ColonnaCommessa:Integer;
    function ValPosizProtetta:Integer;
    procedure Pulizia;
    procedure IniDCmbRaggruppamenti;
    procedure SalvaSuFile;
  public
    { Public declarations }
    OggettoDecod,MessaggioDecod:String;
    sPb_Destinatari, sPb_LogAnomalie, sPb_FileAnomalie, sPb_FileInviate:String;
    Esito:Boolean;
    procedure ElaboraOggetto(CampoOggetto,Estrazione:String);
    procedure ElaboraCorpo(CampoMessaggio,Estrazione:String);
  end;

var
  A062FQueryServizio: TA062FQueryServizio;

procedure OpenA062QueryServizio(Nome,SQL:String);

implementation

uses A062UQueryServizioDtM1, A062UAccessoDB, A101URaggrInterrogazioni
     {$IFDEF ISO},Q062UEMail, Q062UAllegati{$ENDIF};

{$R *.DFM}

procedure OpenA062QueryServizio(Nome,SQL:String);
{Interrogazioni di servizio}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
{$IFNDEF ISO}
  case A000GetInibizioni('Funzione','OpenA062QueryServizio') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
{$ENDIF}
  A062FQueryServizio:=TA062FQueryServizio.Create(nil);
  A062FAccessoDB:=TA062FAccessoDB.Create(nil);
  try
    A062FQueryServizio.btnSalva.Enabled:=not SolaLettura;
    A062FQueryServizio.btnElimina.Enabled:=not SolaLettura;
    A062FQueryServizioDtM1:=TA062FQueryServizioDtM1.Create(nil);
    A062FQueryServizio.Pulizia;
    if Trim(Nome) <> '' then
    begin
      A062FQueryServizio.cmbQuery.Text:=Nome;
      A062FQueryServizio.btnCaricaClick(nil);
    end
    else if Trim(SQL) <> '' then
      A062FQueryServizio.Memo1.Lines.Add(SQL);
    A062FQueryServizio.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    FreeAndNil(A062FAccessoDB);
    FreeAndNil(A062FQueryServizioDtM1);
    FreeAndNil(A062FQueryServizio);
  end;
end;

procedure TA062FQueryServizio.FormCreate(Sender: TObject);
begin
{$IFNDEF ISO}
  //Valori settati qui perchè vengono sempre riportati al defalut all'avvio
  frmSelAnagrafe.Align:=alNone;
  frmSelAnagrafe.Width:=25;
{$ENDIF}

{$IFDEF ISO}
  if Q000FLogin = nil then
    Q000FLogin:=TQ000FLogin.Create(nil);
{$ENDIF}
end;

procedure TA062FQueryServizio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  {$IFNDEF ISO}
  C004FParamForm.Free;
  {$ENDIF}
end;

procedure TA062FQueryServizio.FormDestroy(Sender: TObject);
begin
{$IFNDEF ISO}
  frmSelAnagrafe.DistruggiSelAnagrafe;
{$ENDIF}
end;

procedure TA062FQueryServizio.IniDCmbRaggruppamenti;
begin
  A062FQueryServizioDtm1.A062MW.CaricaCmbRaggruppamenti(CmbRaggruppamenti.items);
  CmbRaggruppamenti.ItemIndex:=0;
end;

procedure TA062FQueryServizio.FormShow(Sender: TObject);
var FiltroProt: string;
begin
  DBGrid1.DataSource:=A062FQueryServizioDtM1.A062MW.DS1;
  dGrdVariabili.DataSource:=A062FQueryServizioDtM1.A062MW.dsrValori;
{$IFNDEF ISO}
  chkProtetta.Enabled:=Parametri.ModificaDatiProtetti;
  C700DatiVisualizzati:='';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  frmSelAnagrafe.CreaSelAnagrafe(A062FQueryServizioDtM1.A062MW,SessioneOracle, StatusBar1,1,False);
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.NumRecords;
  Self.Height:=Self.Height-pnlMail.Height-Splitter3.Height;
  Splitter3.Visible:=False;
  CreaC004(SessioneOracle,'A062',Parametri.ProgOper);
{$ELSE}
  pnlRisultati.Visible:=False;
  pnlSelAnagrafe.Visible:=False;
  chkProtetta.Visible:=R180GetCsvIntersect(Q000FLogin.ProfOperatore,'DIREZ,SEGRE') <> '';
  pnlMail.Visible:=True;
  pnlRisultati.Visible:=True;
  Splitter3.Top:=pnlGriglia.Top+pnlGriglia.Height;
  DBGrid1.Options:=[dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgRowSelect,dgConfirmDelete,dgCancelOnExit,dgMultiSelect];
  CreaC004(DBInterno,'A062',Q000FLogin.Operatore);
  FiltroProt:=Format('NOME not in (select NOME from T002_querypersonalizzate where POSIZ = %s and riga = ''S'')',[ValPosizProtetta.ToString]);
  A062FQueryServizioDtM1.A062MW.OpenSelT002(A062FQueryServizioDtM1.selT002,'',FiltroProt);
{$ENDIF}
  Memo1.SetFocus;
  btnCreaTab.Enabled:=Trim(edtNomeTab.Text) <> '';
{$IFNDEF ISO}
  A062FQueryServizioDtM1.A062MW.GC700MergeSelAnagrafe:=C700MergeSelAnagrafe;
  A062FQueryServizioDtM1.A062MW.SelAnagrafe:=C700SelAnagrafe;
{$ENDIF}
  IniDCmbRaggruppamenti;
  A062FQueryServizioDtM1.A062MW.C004DM_MW:=C004FParamForm;
end;

procedure TA062FQueryServizio.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
var D:TDateTime;
begin
{$IFNDEF ISO}
  with A062FQueryServizioDtM1.A062MW.cdsValori do
  begin
    if state = dsInactive then
    begin
      Close;
      CreateDataSet;
      Open;
    end;

    if Locate('VARIABILE;TIPO',VarArrayOf(['DataLavoro','Data']),[loCaseInsensitive]) and
       (not FieldByName('VALORE').IsNull) and
       TryStrToDate(FieldByName('VALORE').AsString,D) then
      C700DataLavoro:=FieldByName('VALORE').AsDateTime
    else
      C700DataLavoro:=Parametri.DataLavoro;

    if Locate('VARIABILE;TIPO',VarArrayOf(['C700DataDal','Data']),[loCaseInsensitive]) and
       (not FieldByName('VALORE').IsNull) and
       TryStrToDate(FieldByName('VALORE').AsString,D) then
      C700DataDal:=FieldByName('VALORE').AsDateTime
    else
      C700DataDal:=Parametri.DataLavoro;

  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
{$ENDIF}
end;

procedure TA062FQueryServizio.btnEseguiClick(Sender: TObject);
var
  PassWord:String;
  LStopWatch: TStopWatch;
  i: integer;
begin
  try
    StatusBar1.Panels[2].Text:='Attendere: esecuzione in corso...';
    StatusBar1.Repaint;
    Screen.Cursor:=crHourGlass;

    // avvio timer di precisione
    LStopWatch:=TStopwatch.StartNew;

    with A062FQueryServizioDtM1.A062MW do
    begin
      Q1.Close;
      SenderIsBtnCreaTab:=Sender = btnCreaTab;
      SqlSelezioneList.Text:=Memo1.Lines.Text;
      SqlNomeTabella:=edtNomeTab.Text;
      ValidaQuery;
      if UpperCase(Copy(Trim(Memo1.Lines.Text) + ' ',1,5)) = 'EXEC ' then
      begin
        RegistraMsg.IniziaMessaggio('A062');
        SqlNome:=cmbQuery.Text;
        PreparaScript;
        if ChiediPswAccessoDB and (selI090.RecordCount > 0) then
        begin
          A062FAccessoDB.edtUserName.Text:=UserName;
          A062FAccessoDB.ShowModal;
          if A062FAccessoDB.ModalResult = mrOk then
            PassWord:=A062FAccessoDB.edtPassWord.Text;
          if R180Decripta(selI090.FieldByName('PAROLACHIAVE').AsString,21041974) <> PassWord then
          begin
            StatusBar1.Panels[2].Text:='';
            screen.cursor:=crDefault;
            ShowMessage('Accesso negato');
            exit;
          end;
        end;
        S1.Execute;
        if Pos('ORA-',Trim(S1.Output.Text)) > 0 then
          RegistraMsg.InserisciMessaggio('A','Risultato = ' + Trim(S1.Output.Text),'',0)
        else
          RegistraMsg.InserisciMessaggio('I','Risultato = ' + Trim(S1.Output.Text),'',0);
        ShowMessage(Trim(S1.Output.Text));
        Exit;
      end;
      if SenderIsBtnCreaTab then
      begin
        if EsisteTabella then
        begin
          if R180MessageBox('Attenzione! La tabella T921' + SqlNomeTabella + ' è già esistente e verrà ricreata.' + #13#10 +
                            'I dati contenuti nella tabella precedente andranno persi. Continuare?',DOMANDA) = mrNo then
            Exit;
          DropTableT921;  //Drop tabella
        end;
      end;
      EseguiQuery;
      if SenderIsBtnCreaTab then
      begin
        CreateTableT921(SqlNomeTabella);
        R180MessageBox('I dati sono stati registrati nella tabella T921' + SqlNomeTabella + '.',INFORMA);
      end;
      BStampa.Enabled:=Q1.RecordCount > 0;
      BStampante.Enabled:=Q1.RecordCount > 0;
      BCartellino.Enabled:=(Parametri.Applicazione = 'RILPRE') and (Q1.RecordCount > 0);
      BCartellino.Visible:=A062FQueryServizio.BCartellino.Enabled;
      BSalva.Enabled:=Q1.RecordCount > 0;
    {$IFDEF ISO}
      BEMail.Enabled:=Q1.RecordCount > 0;
      btnInvioAuto.Enabled:=Q1.RecordCount > 0;
      ColonnaCliente:=-1;
      for i:=0 to (dbGrid1.Columns.Count - 1) do
        if Pos('CLIENTE',UpperCase(dbGrid1.Columns[i].Title.Caption)) > 0 then
          ColonnaCliente:=i;
      Contatti1.Enabled:=ColonnaCliente >= 0;
      Installazioni1.Enabled:=ColonnaCliente >= 0;
      ColonnaCommessa:=-1;
      for i:=0 to (dbGrid1.Columns.Count - 1) do
        if Pos('COMMESSA',UpperCase(dbGrid1.Columns[i].Title.Caption)) > 0 then
          ColonnaCommessa:=i;
      Commesse1.Enabled:=ColonnaCommessa >= 0;
    {$ENDIF}
      StatusBar1.Panels[0].Text:=IntToStr(Q1.RecordCount) + ' Records';
    end;
  finally
    // stop timer di precisione
    LStopWatch.Stop;
    Screen.Cursor:=crDefault;
    StatusBar1.Panels[2].Text:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
    StatusBar1.Repaint;
  end;
end;

procedure TA062FQueryServizio.btnInvioAutoClick(Sender: TObject);
begin
{$IFDEF ISO}
  if Pos('CLIENTE',UpperCase(A062FQueryServizioDtM1.A062MW.Q1.SQL.Text)) = 0 then
    raise Exception.Create('E'' necessario specificare il campo CLIENTE nella selezione!');
  OpenQ062Allegati;
{$ENDIF}
end;

procedure TA062FQueryServizio.Accedi1Click(Sender: TObject);
begin
  OpenA101RaggrInterrogazioni(cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex]);
end;

procedure TA062FQueryServizio.BCartellinoClick(Sender: TObject);
var Data:TDateTime;
begin
{$IFNDEF ISO}
  try
    Data:=A062FQueryServizioDtM1.A062MW.Q1.FieldByName('Data').AsDatetime
  except
    Data:=Parametri.DataLavoro;
  end;
  with A062FQueryServizioDtM1.A062MW.Q1 do
    try
      frmSelAnagrafe.SalvaC00SelAnagrafe;
      C700Distruzione;
      OpenA023Timbrature(FieldByName('Progressivo').AsInteger,Data);
      C700DatiSelezionati:=C700CampiBase;
      C700Creazione(SessioneOracle);
      frmSelAnagrafe.RipristinaC00SelAnagrafe(A062FQueryServizioDtM1.A062MW);
    except
      on E:Exception do
        ShowMessage('Per richiamare il cartellino, devono esistere le seguenti colonne: Progressivo,Data' + CRLF + E.Message);
    end;
{$ENDIF}
end;

procedure TA062FQueryServizio.BEMailClick(Sender: TObject);
var
  sDep:string;
  EMail:Boolean;
begin
{$IFDEF ISO}
  sPb_Destinatari:='';
  sPb_LogAnomalie:='';
  with A062FQueryServizioDtM1.A062MW do
  begin
    if Pos('CLIENTE',UpperCase(Q1.SQL.Text)) = 0 then
      raise Exception.Create('E'' necessario specificare il campo CLIENTE nella selezione!');
    Q1.DisableControls;
    Q1.First;
    Q1.SetVariable('MAILING_LIST',IfThen(rgpMailingList.Itemindex = 0,'A',IfThen(rgpMailingList.Itemindex = 1,'C','T')));
    while not Q1.Eof do
    begin
      selQ104.SetVariable('CLIENTE',Q1.FieldByName('CLIENTE').AsString);
      selQ104.Open;
      selQ104.First;
      EMail:=False;
      while not selQ104.Eof do
      begin
        if selQ104.Fieldbyname('FLAGEMAILAGG').asString = 'S' then
        begin
          EMail:=True;
          if selQ104.Fieldbyname('EMAIL').asString = '' then
          begin
            selQ104Esterni.Close;
            selQ104Esterni.SetVariable('PROGRESSIVO',selQ104.FieldByName('PROGRESSIVO').AsInteger);
            selQ104Esterni.Open;
            if selQ104Esterni.Fieldbyname('EMAIL').asString <> '' then
              if Pos(selQ104Esterni.FieldByName('EMAIL').asString,sPb_Destinatari) = 0 then
              begin
                if sPb_Destinatari <> '' then
                  sPb_Destinatari:=sPb_Destinatari + ';';
                sPb_Destinatari:=sPb_Destinatari + StringReplace(selQ104Esterni.FieldByName('EMAIL').asString,',',';',[rfReplaceAll]);
              end;
          end
          else
            if Pos(selQ104.FieldByName('EMAIL').asString,sPb_Destinatari) = 0 then
            begin
              if sPb_Destinatari <> '' then
                sPb_Destinatari:=sPb_Destinatari + ';';
              sPb_Destinatari:=sPb_Destinatari + StringReplace(selQ104.FieldByName('EMAIL').asString,',',';',[rfReplaceAll]);
            end;
        end;
        selQ104.Next;
      end;
      if not EMail then
        sPb_LogAnomalie:=sPb_LogAnomalie + Q1.FieldByName('CLIENTE').AsString + ': Nessun riferimento abilitato a ricevere e-mail riguardanti gli aggiornamenti.' + #$D#$A;
      selQ104.Close;
      Q1.Next;
    end;
    Q1.EnableControls;
  end;
  if sPb_Destinatari <> '' then
  begin
    sPb_FileInviate:=LHomeDir + 'Log\E_Mail\Inviate' + formatdatetime('yyyymmdd', now) + '_' + formatdatetime('hhnnss', now) + '.log';
    if sPb_LogAnomalie <> '' then
    begin
      sPb_FileAnomalie:=LHomeDir + 'Log\E_Mail\Anomalie' + formatdatetime('yyyymmdd', now) + '_' + formatdatetime('hhnnss', now) + '.log';
      sDep:=FormatDateTime('dd mmmm yyyy', Now) +  ' Ore: ' + FormatDateTime('hh:nn', Now)+ #$D#$A;
      sDep:= sDep + 'ANOMALIE RISCONTRATE DURANTE L''ELABORAZIONE DEI RIFERIMENTI A CUI INVIARE L''E-MAIL.' + #$D#$A + #$D#$A;
      sPb_LogAnomalie:=sDep + sPb_LogAnomalie;
    end;
    Q062UEMail.OpenQ062EMail;
  end
  else
    R180MessageBox('Non è stato individuato alcun contatto a cui inviare l''e-mail.',INFORMA);
{$ENDIF}
end;

procedure TA062FQueryServizio.BStampanteClick(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TA062FQueryServizio.BStampaClick(Sender: TObject);
var F:TextFile;
    S,Intestazione:String;
    i,HP,HR,HCorr:Integer;
    procedure SaltoPagina;
    begin
    writeln(F,'');
    writeln(F,'Elenco Interrogazione Tabelle IrisWIN (Pag. ' + IntToStr(Printer.PageNumber)+ ')');
    writeln(F,'');
    writeln(F,Intestazione);
    writeln(F,'');
    HCorr:=HR * 5;
    end;
begin
  AssignPrn(F);
  Rewrite(F);
  Printer.Canvas.Font.Name:='Courier New';
  Printer.Canvas.Font.Size:=7;
  HP:=Printer.PageHeight;
  HR:=Printer.Canvas.TextHeight(' ');
  with A062FQueryServizioDtM1.A062MW.Q1 do
  begin
    First;
    DisableControls;
    S:='';
    for i:=0 to FieldCount - 1 do
      if Fields[i].Visible then
        S:=S + Format('%-*s',[R180Lunghezzacampo(Fields[i]), Fields[i].FieldName]);
    Intestazione:=S;
    SaltoPagina;
    while not Eof do
    begin
      S:='';
      if HCorr >= (HP - HR*8) then
        begin
        while Printer.PageNumber < 2 do
          writeln(F,'');
        SaltoPagina;
        end;
      for i:=0 to FieldCount - 1 do
        if Fields[i].Visible then
          S:=S + Format('%-*s',[R180Lunghezzacampo(Fields[i]), Fields[i].AsString]);
      writeln(F,S);
      inc(HCorr,HR);
      Next;
    end;
    First;
    EnableControls;
  end;
  CloseFile(F);
end;

procedure TA062FQueryServizio.btnCaricaClick(Sender: TObject);
begin
  with A062FQueryServizioDtM1.A062MW do
  begin
    {$IFDEF ISO} //Controlla che non si stia aprendo una query protetta senza essere abilitati
    selT002RigaProtetta.Close;
    selT002RigaProtetta.SetVariable('Nome',cmbQuery.Text);
    selT002RigaProtetta.SetVariable('POSIZ_PROTETTA',ValPosizProtetta);
    selT002RigaProtetta.Open;
    if selT002RigaProtetta.RecordCount = 0 then
      exit;
    {$ENDIF}
    Memo1.Clear;
    SqlNome:=cmbQuery.Text;
    SqlSelezioneList.Text:=Memo1.Lines.Text;
    chkIntestazioneName:=chkIntestazione.Name;
    chkNoRitornoACapoName:=chkNoRitornoACapo.Name;
    CaricaQuery;
    {$IFNDEF ISO}
    btnSalva.Enabled:=(not SolaLettura) and (not ChkMWProtetta or Parametri.ModificaDatiProtetti);
    frmSelAnagrafe.Visible:=EsisteC700;
    Memo1.ReadOnly:=ChkMWProtetta and Not Parametri.ModificaDatiProtetti;
    {$ELSE}
    btnSalva.Enabled:=R180GetCsvIntersect(Q000FLogin.ProfOperatore,'DIREZ,SEGRE') <> '';
    if SqlNome <> '' then
    begin
      memoMessaggio.Text:=selQ003.FieldByName('MESSAGGIO').AsString;
      memoOggetto.Text:=selQ003.FieldByName('OGGETTO').AsString;
    end
    else
    begin
      memoMessaggio.Text:='';
      memoOggetto.Text:='';
    end;
    {$ENDIF}
    btnElimina.Enabled:=btnSalva.Enabled;
    chkProtetta.Checked:=ChkMWProtetta;
    edtNomeTab.Text:=SqlNomeTabella;
    chkIntestazione.Checked:=chkIntestazioneChecked;
    chkNoRitornoACapo.Checked:=chkNoRitornoACapoChecked;
    Memo1.Text:=SqlSelezioneList.Text;
  end;
end;

procedure TA062FQueryServizio.btnSalvaClick(Sender: TObject);
begin
  if cmbQuery.Text = '' then
    raise Exception.Create(A000MSG_A062_ERR_NOME_QUERY_MANCANTE);

  with A062FQueryServizioDtM1.A062MW do
  begin
    {$IFDEF ISO} //Controlla che non si utilizzando il nome di una query protetta senza essere abilitati
    selT002RigaProtetta.Close;
    selT002RigaProtetta.SetVariable('Nome',cmbQuery.Text);
    selT002RigaProtetta.SetVariable('POSIZ_PROTETTA',-99);
    selT002RigaProtetta.Open;
    selT002RigaProtetta.First;
    if selT002RigaProtetta.RecordCount > 0 then
    begin
      //Se nome già usato per query protetta, ma non si è abilitati, si deve usare altro nome
      if (ValPosizProtetta = -9) and
         selT002RigaProtetta.SearchRecord('POSIZ;RIGA',VarArrayOf([-9,'S']),[srFromBeginning]) then
        raise Exception.Create('Query già esistente e non riscrivibile.' + #13#10 + 'Usare un altro nome.');
    end;
    {$ENDIF}
    SqlNome:=cmbQuery.Text;
    SqlNomeTabella:=edtNomeTab.Text;
    SqlSelezioneList.Text:=Memo1.Lines.Text;
    chkIntestazioneName:=chkIntestazione.Name;
    chkIntestazioneChecked:=chkIntestazione.Checked;
    chkNoRitornoACapoName:=chkNoRitornoACapo.Name;
    chkNoRitornoACapoChecked:=chkNoRitornoACapo.Checked;
    ChkMWProtetta:=chkProtetta.Checked;
    A062FQueryServizioDtM1.A062MW.SalvataggioIncorso:=True;
    if not SalvaSql then
      R180MessageBox(Format(A000MSG_A062_ERR_QUERY_ESISTENTE,[SqlNome]),ERRORE)
    {$IFNDEF ISO}
    else
      frmSelAnagrafe.Visible:=EsisteC700{$ENDIF};

    {$IFDEF ISO}
    if (memoMessaggio.Text <> '') or (memoOggetto.Text <> '') then
    begin
      selQ003.Insert;
      selQ003.FieldByName('NOMEQUERY').AsString:=cmbQuery.Text;
      selQ003.FieldByName('MESSAGGIO').AsString:=memoMessaggio.Text;
      selQ003.FieldByName('OGGETTO').AsString:=memoOggetto.Text;
      selQ003.Post;
    end;
    SessioneOracle.Commit;
    {$ENDIF}

    cmbRaggruppamentiChange(cmbRaggruppamenti);
    A062FQueryServizioDtM1.A062MW.SalvataggioIncorso:=False;
  end;
end;

procedure TA062FQueryServizio.Datianagrafici1Click(Sender: TObject);
begin
  try
    C005DataVisualizzazione:=A062FQueryServizioDtM1.A062MW.Q1.FieldByName('Data').AsDateTime;
  except
    C005DataVisualizzazione:=Date;
  end;
  C005FDatiAnagrafici:=TC005FDatiAnagrafici.Create(nil);
  try
    C005FDatiAnagrafici.ShowDipendente(A062FQueryServizioDtM1.A062MW.Q1.FieldByName('Progressivo').AsInteger);
  finally
    C005FDatiAnagrafici.Release;
  end;
end;

procedure TA062FQueryServizio.SalvaSuFile;
var Contenuto: TStream;
    FileStream: TFileStream;
    Preference: Integer;
    NomeFile: String;
begin
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName) + 'Archivi\Temp';
  DateTimeToString(NomeFile, 'dd-mm-yy_hh-nn-ss', Now);
  SaveDialog1.FileName:='Esportazione_' + NomeFile;
  if not SaveDialog1.Execute then
    Exit;
  Screen.Cursor:=crHourGlass;
  try
    A062FQueryServizioDtM1.A062MW.ChkIntestazioneChecked:=chkIntestazione.Checked;
    A062FQueryServizioDtM1.A062MW.chkNoRitornoACapoChecked:=chkNoRitornoACapo.Checked;
    if ExtractFileExt(SaveDialog1.FileName) = '.xlsx' then
    begin
      R180DatasetToXlsxFile(SessioneOracle,
                            A062FQueryServizioDtM1.A062MW.chkIntestazioneChecked,
                            A062FQueryServizioDtM1.A062MW.Q1, SaveDialog1.FileName);
    end
    else
    begin
      Contenuto:=A062FQueryServizioDtM1.A062MW.CreaTestoFile(SaveDialog1.FileName);
        try
          FileStream:=TFileStream.Create(SaveDialog1.FileName, fmCreate);
          try
            FileStream.CopyFrom(Contenuto, 0);
          finally
            FreeAndNil(FileStream);
          end;
        finally
          FreeAndNil(Contenuto);
        end;
    end;
    {$IFDEF MSWINDOWS}
    if FileExists(SaveDialog1.FileName) then
    begin
      Preference:=MessageDlg('Desideri aprire il file esportato?',mtConfirmation, [mbYes, mbNo], 0);
      if Preference = mrYes then
        ShellExecute(0, 'OPEN', PChar(SaveDialog1.FileName), '', '', SW_SHOWNORMAL);
    end;
    {$ENDIF MSWINDOWS}
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA062FQueryServizio.cmbQueryDropDown(Sender: TObject);
begin
  with A062FQueryServizioDtM1 do
    if selT002.Active then
    begin
      selT002.First;
      while not selT002.Eof do
      begin
        cmbQuery.Items.Add(selT002.FieldByName('Nome').AsString);
        selT002.Next;
      end;
      selT002.Close;
    end;
end;

procedure TA062FQueryServizio.cmbRaggruppamentiChange(Sender: TObject);
var FiltroProt: string;
begin
  {$IFDEF ISO}
  FiltroProt:=Format('NOME not in (select NOME from T002_querypersonalizzate where POSIZ = %s and riga = ''S'')',[ValPosizProtetta.ToString]);
  {$ELSE}
  FiltroProt:='';
  {$ENDIF}
  if cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex] = 'Tutte le interrogazioni' then
    A062FQueryServizioDtM1.A062MW.OpenSelT002(A062FQueryServizioDtM1.selT002,'',FiltroProt)
  else
    A062FQueryServizioDtM1.A062MW.OpenSelT002(A062FQueryServizioDtM1.selT002,cmbRaggruppamenti.Items[cmbRaggruppamenti.ItemIndex],FiltroProt);
  cmbQuery.Items.Clear;
  if (cmbQuery.Text <> '') and not A062FQueryServizioDtM1.selT002.SearchRecord('NOME',cmbQuery.Text,[srFromBeginning]) then
    cmbQuery.Text:='';
end;

procedure TA062FQueryServizio.btnEliminaClick(Sender: TObject);
var
  Msg:string;
begin
  if MessageDlg(Format('Eliminare la query "%s" ?',[cmbQuery.Text]),MtWarning,[MbYes,MbNo],0) = MrYes then
  begin
  {$IFNDEF ISO}
    with TCestino.Create(SessioneOracle) do
    try
      Msg:=CancLogica('T002_QUERYPERSONALIZZATE',cmbQuery.Text);
      if Msg <> '' then
        R180MessageBox(Msg,ERRORE)
      else
      begin
        A062FQueryServizioDtM1.A062MW.DelQueryRaggr(cmbQuery.Text);
        RegistraLog.SettaProprieta('C','T002_QUERYPERSONALIZZATE','A062',nil,True);
        RegistraLog.InserisciDato('NOME',cmbQuery.Text,'');
        RegistraLog.RegistraOperazione;
        //---Pulizia;
        //---cmbQuery.Text:='';;
      end;
    finally
      //---SessioneOracle.Commit;
      Free;
    end;
  {$ELSE}
    with A062FQueryServizioDtM1.A062MW do
    begin
      selT002RigaProtetta.Close;
      selT002RigaProtetta.SetVariable('Nome',cmbQuery.Text);
      selT002RigaProtetta.SetVariable('POSIZ_PROTETTA',ValPosizProtetta);
      selT002RigaProtetta.Open;
      if selT002RigaProtetta.RecordCount = 0 then
        raise Exception.Create('Cancellazione fallita perchè la query è inesistente.');
      selT002RigaProtetta.First;
      while not selT002RigaProtetta.Eof do
        selT002RigaProtetta.Delete;
      selQ003.Close;
      selQ003.SetVariable('NOMEQUERY',cmbQuery.Text);
      selQ003.Open;
      if selQ003.RecordCount > 0 then
        selQ003.Delete;
      //---DBInterno.Commit;
      //---Pulizia;
      //---cmbQuery.Text:='';
    end;
  {$ENDIF}
    SessioneOracle.Commit;
    Pulizia;
    cmbQuery.Text:='';
    cmbRaggruppamentiChange(cmbRaggruppamenti); //AGGIORNA L'ELENCO NELLE COMBO
  end;
end;

procedure TA062FQueryServizio.cmbQueryDblClick(Sender: TObject);
begin
  btnCaricaClick(nil);
end;

procedure TA062FQueryServizio.btnPulisciClick(Sender: TObject);
begin
  Pulizia;
  cmbQuery.Text:='';
end;

procedure TA062FQueryServizio.Pulizia;
begin
  Memo1.Clear;
  with A062FQueryServizioDtM1.A062MW do
  begin
    cdsValori.Close;
    cdsValori.CreateDataSet;
    cdsValori.Open;
    Q1.Close;
    Q1.SQL.Clear;
    BStampa.Enabled:=False;
    BSalva.Enabled:=False;
    BStampante.Enabled:=False;
    BCartellino.Enabled:=False;
    BCartellino.Visible:=BCartellino.Enabled;
    btnInvioAuto.Enabled:=False;
    BEMail.Enabled:=False;
    StatusBar1.Panels[0].Text:='0 Records';
  end;
end;

procedure TA062FQueryServizio.BSalvaClick(Sender: TObject);
begin
  SaveDialog1.Filter:='File Excel|*.xlsx|File CSV|*.csv|File di testo|*.txt';
  SaveDialog1.DefaultExt:='*.xlsx';
  SalvaSuFile;
end;

procedure TA062FQueryServizio.SalvainExcelClick(Sender: TObject);
begin
  SaveDialog1.Filter:='File Excel|*.xlsx';
  SaveDialog1.DefaultExt:='*.xlsx';
  SalvaSuFile;
end;

procedure TA062FQueryServizio.SalvainCSVClick(Sender: TObject);
begin
  SaveDialog1.Filter:='File CSV|*.csv';
  SaveDialog1.DefaultExt:='*.csv';
  SalvaSuFile;
end;

procedure TA062FQueryServizio.SalvainTXT1Click(Sender: TObject);
begin
  SaveDialog1.Filter:='File di testo|*.txt';
  SaveDialog1.DefaultExt:='*.txt';
  SalvaSuFile;
end;

function TA062FQueryServizio.ValPosizProtetta: Integer;
begin
{$IFDEF ISO}
  Result:=-9;  //Esclusione POSIZ = -9
  if R180GetCsvIntersect(Q000FLogin.ProfOperatore,'DIREZ,SEGRE') <> '' then
{$ENDIF}
    Result:=-99; //Nessuna eslcusione
end;

procedure TA062FQueryServizio.mnuSelezionaTuttoClick(Sender: TObject);
var
  Par: Char;
begin
  if Sender = mnuSelezionaTutto then
    Par:='S'
  else if Sender = mnuDeselezionaTutto then
    Par:='N'
  else if Sender = mnuInvertiSelezione then
    Par:='C'
  else
    Exit;
  R180DBGridSelezionaRighe(DBGrid1,Par);
end;

procedure TA062FQueryServizio.PopupMenu1Popup(Sender: TObject);
begin
  IncollaTesto1.Enabled:=Clipboard.AsText <> '';
end;

procedure TA062FQueryServizio.PopupMenu3Popup(Sender: TObject);
var
  i:integer;
  bTrovato:boolean;
begin
{$IFNDEF ISO}
  bTrovato:=False;
  for i:=0 to A062FQueryServizioDtM1.A062MW.Q1.FieldCount - 1 do
  begin
    if (UpperCase(A062FQueryServizioDtM1.A062MW.Q1.Fields[i].FieldName) = 'PROGRESSIVO') or
       (UpperCase(A062FQueryServizioDtM1.A062MW.Q1.Fields[i].FieldName) = 'T430PROGRESSIVO') or
       (UpperCase(A062FQueryServizioDtM1.A062MW.Q1.Fields[i].FieldName) = 'T030PROGRESSIVO') then
    begin
      bTrovato:=True;
      break;
    end;
  end;
  Datianagrafici1.Enabled:=bTrovato;

{$ELSE}
  N1.Visible:=False;
  Datianagrafici1.Visible:=False;
  N2.Visible:=True;
  Contatti1.Visible:=True;
  Installazioni1.Visible:=True;
  Commesse1.Visible:=True;
  mnuSelezionaTutto.Visible:=True;
  mnuDeselezionaTutto.Visible:=True;
  mnuInvertiSelezione.Visible:=True;
{$ENDIF}
end;

procedure TA062FQueryServizio.edtNomeTabChange(Sender: TObject);
begin
  btnCreaTab.Enabled:=Trim(edtNomeTab.Text) <> '';
end;

procedure TA062FQueryServizio.edtNomeTabEnter(Sender: TObject);
begin
  if (Trim(cmbQuery.Text) <> '') and (edtNomeTab.Text = '') and
     (Trim(Memo1.Lines.Text) <> '') then
    edtNomeTab.Text:=cmbQuery.Text;
  edtNomeTab.SelectAll;
end;

procedure TA062FQueryServizio.ElaboraCorpo(CampoMessaggio, Estrazione: String);
var
  Variabile,Messaggio:String;
  Minore,Maggiore,i:Integer;
begin
{$IFDEF ISO}
  Messaggio:=CampoMessaggio;
  Minore:=Pos('<',Messaggio);
  Maggiore:=Pos('>',Messaggio);
  i:=1;
  MessaggioDecod:='Gentile cliente,' + #$D#$A;
  while Minore > 0 do
  begin
    MessaggioDecod:=MessaggioDecod + Copy(Messaggio,i,Minore - i);
    Variabile:=Copy(Messaggio,Minore + 1, Maggiore - Minore - 1);
    with A062FQueryServizioDtM1.A062MW do
    begin
      if cdsValori.Locate('VARIABILE',Variabile,[]) then //cerco la variabile tra quelle richieste
        MessaggioDecod:=MessaggioDecod + cdsValori.FieldByName('VALORE').AsString
      else if Estrazione = 'S' then
      begin
        if Pos(Variabile,Q1.SQL.Text) > 0 then //cerco la variabile nell'estrazione
          MessaggioDecod:=MessaggioDecod + Q1.FieldByName(Variabile).AsString
        else
        begin
          Esito:=False;
          Break;
        end;
      end
      else
        MessaggioDecod:=MessaggioDecod + '<' + Variabile + '>';
    end;
    i:=Maggiore - Length(Variabile) - 1;
    Messaggio:=Copy(Messaggio,1,Minore - 1) + Copy(Messaggio,Maggiore + 1, Length(Messaggio) - Length(Variabile) - 2);
    Minore:=Pos('<',Messaggio);
    Maggiore:=Pos('>',Messaggio);
  end;
  if Esito then
  begin
    MessaggioDecod:=MessaggioDecod + Copy(Messaggio,i,Length(Messaggio) - i + 1);
    MessaggioDecod:=MessaggioDecod + #$D#$A + 'Cordiali saluti,' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Il servizio di assistenza tecnica.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Mailto: ' + MAIL_HELPDESK  + #$D#$A + #$D#$A;
    MessaggioDecod:=MessaggioDecod + '--------------------------------------------------------------------' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Mondo Edp s.r.l.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Via Barbaresco , 11' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + '12100 Cuneo' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Tel. 0171/34.66.85' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Fax. 0171/34.66.86' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'http://www.mondoedp.com' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + '--------------------------------------------------------------------' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Avvertenze ai sensi del Dlgs. 196/2003 e RE 679/2016' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Le informazioni contenute in questo messaggio sono riservate, confidenziali ed a uso esclusivo del destinatario ed è vietata la loro diffusione.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Qualora riceveste il presente messaggio per errore e non ne siate destinatari, vi preghiamo di darcene notizia via e-mail, di astenervi dal consultare il messaggio stesso ';
    MessaggioDecod:=MessaggioDecod + 'e gli eventuali files allegati e di cancellare il messaggio dal vs. sistema informatico.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Costituisce comportamento contrario ai principi del  Dlgs. 196/2003 e del RE 679/2016 il trattenere il messaggio, diffonderne il contenuto, inviarlo ad altri soggetti, ';
    MessaggioDecod:=MessaggioDecod + 'copiarlo in tutto od in parte,  utilizzarlo da parte di soggetti diversi dal destinatario.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Mondo Edp srl garantisce la massima riservatezza dei dati da voi comunicati; gli stessi saranno trattati in ottemperanza alle normative vigenti.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'L''interessato può esercitare i propri diritti di soggetto interessato dandone comunicazione all''indirizzo e-mail privacy@mondoedp.com.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Le dichiarazioni contenute nel presente messaggio nonché nei suoi eventuali allegati devono essere attribuite esclusivamente al mittente e non impegnano Mondo Edp srl nei confronti del destinatario o di terzi.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + 'Mondo Edp srl non si assume alcuna responsabilità per eventuali intercettazioni, modifiche o danneggiamenti del presente messaggio e-mail.' + #$D#$A;
    MessaggioDecod:=MessaggioDecod + #$D#$A;
  end;
{$ENDIF}
end;

procedure TA062FQueryServizio.ElaboraOggetto(CampoOggetto, Estrazione: String);
var
  Variabile,Oggetto:String;
  Minore,Maggiore,i:Integer;
begin
{$IFDEF ISO}
  Oggetto:=CampoOggetto;
  Minore:=Pos('<',Oggetto);
  Maggiore:=Pos('>',Oggetto);
  i:=1;
  while Minore > 0 do
  begin
    OggettoDecod:=OggettoDecod + Copy(Oggetto,i,Minore - i);
    Variabile:=Copy(Oggetto,Minore + 1, Maggiore - Minore - 1);
    with A062FQueryServizioDtM1.A062MW do
    begin
      if cdsValori.Locate('VARIABILE',Variabile,[]) then //cerco la variabile tra quelle richieste
        OggettoDecod:=OggettoDecod + cdsValori.FieldByName('VALORE').AsString
      else if Estrazione = 'S' then
        if Pos(Variabile,Q1.SQL.Text) > 0 then //cerco la variabile nell'estrazione
          OggettoDecod:=OggettoDecod + Q1.FieldByName(Variabile).AsString
        else
        begin
          Esito:=False;
          Break;
        end;
    end;
    i:=Maggiore - Length(Variabile) - 1;
    Oggetto:=Copy(Oggetto,1,Minore - 1) + Copy(Oggetto,Maggiore + 1, Length(Oggetto) - Length(Variabile) - 2);
    Minore:=Pos('<',Oggetto);
    Maggiore:=Pos('>',Oggetto);
  end;
  if Esito then
    OggettoDecod:=OggettoDecod + Copy(Oggetto,i,Length(Oggetto) - i + 1);
{$ENDIF}
end;

procedure TA062FQueryServizio.Incollatesto1Click(Sender: TObject);
begin
  Memo1.Text:=R180IncollaTestoDaClipboard(Memo1.Text,Memo1.SelStart,Memo1.SelLength);
end;

procedure TA062FQueryServizio.Inseriscijoinconlaselezioneanagrafica1Click(
  Sender: TObject);
var s:String;
    i:Integer;
begin
  s:=Memo1.Text;
  i:=Memo1.SelStart + 1;
  Insert('SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO',S,i);
  Memo1.Text:=S;
  Memo1.SetFocus;
  Memo1.SelStart:=i - 1 + Length('SELECT * FROM TABELLA1, TABELLA2, :C700SelAnagrafe AND TABELLA1.CAMPO1 = TABELLA2.CAMPO2 AND TABELLA1.PROGRESSIVO = T030.PROGRESSIVO');
  Memo1.SelLength:=0;
end;

procedure TA062FQueryServizio.Inseriscisubquerydallaselezioneanagrafica1Click(
  Sender: TObject);
var s:String;
    i:Integer;
begin
  s:=Memo1.Text;
  i:=Memo1.SelStart + 1;
  Insert('PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)',S,i);
  Memo1.Text:=S;
  Memo1.SetFocus;
  Memo1.SelStart:=i - 1 + Length('PROGRESSIVO IN (SELECT PROGRESSIVO FROM :C700SelAnagrafe)');
  Memo1.SelLength:=0;
end;

procedure TA062FQueryServizio.InseriscisubqueryEXISTSsullaselezioneanagrafica1Click(
  Sender: TObject);
var s:String;
    i:Integer;
begin
  s:=Memo1.Text;
  i:=Memo1.SelStart + 1;
  Insert('EXISTS (SELECT ''X'' FROM :C700SelAnagrafe AND T030.PROGRESSIVO =  <tabella>.PROGRESSIVO)',S,i);
  Memo1.Text:=S;
  Memo1.SetFocus;
  Memo1.SelStart:=i - 1 + Length('EXISTS (SELECT ''X'' FROM :C700SelAnagrafe AND T030.PROGRESSIVO =  <tabella>.PROGRESSIVO)');
  Memo1.SelLength:=0;
end;

procedure TA062FQueryServizio.Installazioni1Click(Sender: TObject);
begin
{$IFDEF ISO}
  OpenQ040Installazione(dbGrid1.Columns[ColonnaCliente].Field.AsString);
{$ENDIF}
end;

procedure TA062FQueryServizio.Commesse1Click(Sender: TObject);
begin
{$IFDEF ISO}
  OpenQ060Commesse(dbGrid1.Columns[ColonnaCommessa].Field.AsString);
{$ENDIF}
end;

procedure TA062FQueryServizio.Contatti1Click(Sender: TObject);
begin
{$IFDEF ISO}
  OpenQ010ClientiSedi(dbGrid1.Columns[ColonnaCliente].Field.AsString);
{$ENDIF}
end;

procedure TA062FQueryServizio.CopiaInExcelClick(Sender: TObject);
begin
{$IFNDEF ISO}
  R180DBGridCopyToClipboard(DBGrid1,Sender = CopiaInExcel, False, chkIntestazione.Checked, chkNoRitornoACapo.Checked);
{$ElSE}
  R180DBGridCopyToClipboard(DBGrid1,Sender = CopiaInExcel);
{$ENDIF}
end;

end.
