unit A027UCarMen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, DBCtrls, OracleData, ComCtrls, Oracle,
  Qrctrls, Quickrpt, QrPrntr, QrExtra, QRExport, QRPDFFilt,Db, Menus, Spin,
  Variants, Math, A000UMessaggi,
  A000UCostanti, A000USessione,A000UInterfaccia, A027UCostanti, A052UParCar,
  C001StampaLib, C004UParamForm, C005UDatiAnagrafici, {C012UVisualizzaTesto,}
  C180FunzioniGenerali, C700USelezioneAnagrafe, R300UAccessiMensaDtM, R350UCalcoloBuoniDtM,
  A027UStampaTimb, A041UInsRiposiMW, R400UCartellinoDtM, L021Call, Printers,
  RegistrazioneLog, StrUtils, SelAnagrafe, A083UMsgElaborazioni, QueryStorico,
  A159UArchiviazioneCartellini, System.Diagnostics, InputPeriodo, A003UDataLavoroBis;

const TipoIndennitaTurno = '(TIPO = ''A'') OR (TIPO = ''B'') OR (TIPO = ''C'') OR (TIPO = ''D'') OR (TIPO = ''E'')  OR (TIPO = ''F'') OR (TIPO = ''P'')';
      MaxRighe = 35;
      MaxColonne = 54;

type
  TParametri = record
    sFileTesto:string;
    sCarCon:string;
    sNumRighe:string;
    sNumRigheHeader:string;
    sNumRigheFooter:string;
    sSaltoPagina:string;
    sNomeStampa:string;
    sChkNumPagina:string;
    sNumPagina:string;
    sPaginaParita:string;
    sAutoGiustificazione:String;
    sIgnoraAnomalie:String;
    sIgnoraAnomalieStampa:String;  //LORENA 28/072004
    sParametrizzazioniTipoCar:String;
  end;

  TA027FCarMen = class(TForm)
    BitBtn1: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;                                                     
    BitBtn2: TBitBtn;
    StatusBar: TStatusBar;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    SaveDialog1: TSaveDialog;
    BitBtn4: TBitBtn;
    ProgressBar1: TProgressBar;
    frmSelAnagrafe: TfrmSelAnagrafe;
    chkNumPagina: TCheckBox;
    edtNumPagina: TSpinEdit;
    btnStampaAscii: TBitBtn;
    PopupMenu1: TPopupMenu;
    Nuovoelemento1: TMenuItem;
    chkAutoGiustificazione: TCheckBox;
    btnAnomalie: TBitBtn;
    chkIgnoraAnomalieStampa: TCheckBox;
    pnlParametrizzazioneStampa: TGroupBox;
    DBText1: TDBText;
    Label4: TLabel;
    NomeStampa: TDBLookupComboBox;
    chkParametrizzazioniTipoCartellino: TCheckBox;
    pnlAggiornamento: TGroupBox;
    chkIgnoraAnomalie: TCheckBox;
    CAggiornamento: TCheckBox;
    chkBuoniPasto: TCheckBox;
    chkAccessiMensa: TCheckBox;
    chkPaginaParita: TCheckBox;
    btnBloccoRiepiloghi: TBitBtn;
    btnArchiviazioneCartellini: TBitBtn;
    chkInserimentoRiposi: TCheckBox;
    frmInputPeriodo: TfrmInputPeriodo;
    procedure NomeStampaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CAggiornamentoClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
    procedure TfrmSelAnagrafe1R003DatianagraficiClick(Sender: TObject);
    procedure chkNumPaginaClick(Sender: TObject);
    procedure btnStampaAsciiClick(Sender: TObject);
    procedure Nuovoelemento1Click(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnBloccoRiepiloghiClick(Sender: TObject);
    procedure btnArchiviazioneCartelliniClick(Sender: TObject);
    procedure frmInputPeriodoedtInizioExit(Sender: TObject);
    procedure frmInputPeriodoedtFineExit(Sender: TObject);
    procedure frmInputPeriodobtnIndietroClick(Sender: TObject);
    procedure frmInputPeriodobtnAvantiClick(Sender: TObject);
  private
    { Private declarations }
    AbilCont,AbilBuoniPasto,AbilAccessimensa,AbilInserimentoRiposi:Boolean;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure LeggiParametrizzazione(SoloAggiornamento:Boolean);
    procedure GetElencoIntestazione;
    procedure AbilitaBloccoRiepiloghi;
  public
    { Public declarations }
    R400FCartellinoDtM: TR400FCartellinoDtM;
    sParametri:TParametri;
    NumPaginaManuale:LongInt;
    NomeFileTesto:String;
    A027StampaTimb:TA027StampaTimb;
    DatiStorici:TQueryStorico;
    DocumentoPDF,TipoModulo: string;
  end;

var
  A027FCarMen: TA027FCarMen;

procedure OpenA027CarMen(Prog:LongInt; Data:TDateTime);

implementation

uses A027UStampaTesto, A126UBloccoRiepiloghi;

{$R *.DFM}

procedure OpenA027CarMen(Prog:LongInt; Data:TDateTime);
{Stampa della cartolina mensile}
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA027CarMen') of
    'N':begin
        ShowMessage('Funzione non abilitata!');
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  A027FCarmen:=TA027FCarmen.Create(nil);
  with A027FCarmen do
  try
    C700Progressivo:=Prog;
    frmInputPeriodo.DataInizio := R180InizioMese(Data);
    ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    Free;
  end;
end;

procedure TA027FCarMen.FormCreate(Sender: TObject);
var i:Integer;
    QRS:TQRShape;
begin
  TipoModulo:='CS';
  DocumentoPDF:='';
  DatiStorici:=TQueryStorico.Create(Nil);
  DatiStorici.Session:=SessioneOracle;
  Parametri.Applicazione:='RILPRE';
  AbilCont:=False;
  AbilBuoniPasto:=A000GetInibizioni('Funzione','OpenA074RiepilogoBuoni') = 'S';
  AbilAccessiMensa:=A000GetInibizioni('Funzione','OpenA049StampaPasti') = 'S';
  //Alberto 04/04/2018: abilitazione inserimento riposi solo è definito un campo anagrafico per la regola. Se regola unica non si abilita per evitare sbagli da parte degli operatori.
  AbilInserimentoRiposi:=(A000GetInibizioni('Funzione','OpenA041InsRiposi') = 'S') and (Parametri.CampiRiferimento.C16_INSRIPOSI <> '');
  btnArchiviazioneCartellini.Visible:=A000GetInibizioni('Funzione','OpenA159ArchiviazioneCartellini') <> 'N';
  A000SettaVariabiliAmbiente;
  CAggiornamento.Enabled:=not SolaLettura;
  btnStampaAscii.Enabled:=CartellinoAscii;
  A027StampaTimb:=TA027StampaTimb.Create(Self);
  A027StampaTimb.Cur:=0;
  A027StampaTimb.ListaFasce:=TList.Create;
  A027StampaTimb.ListaShape:=TList.Create;
  for i:=0 to High(DatiDett) do
  begin
    QRS:=TQRShape.Create(A027StampaTimb.QRSDet1);
    QRS.Parent:=A027StampaTimb.QRSDet1;
    QRS.Shape:=qrsVertLine;
    QRS.Top:=0;
    QRS.Height:=1;
    QRS.Width:=1;
    QRS.Enabled:=False;
    A027StampaTimb.ListaShape.Add(QRS);
  end;
  A027StampaTimb.A027VisualizzaDipendente:=nil;
  A027StampaTimb.DatiIntestazione:='';
  A027StampaTimb.BandLogoHeightIni:=TQRBand(A027StampaTimb.qimgLogo.Parent).Height;
  A027StampaTimb.QRLMeseHeightIni:=A027StampaTimb.QRLMese.Height;
  btnAnomalie.Enabled:=False;
  NomeFileTesto:='';  //Genova_Comune - CSI
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
end;

procedure TA027FCarMen.FormShow(Sender: TObject);
begin
  btnBloccoRiepiloghi.Visible:=False;
  R400FCartellinoDtM:=TR400FCartellinoDtM.Create(Self);
  NomeStampa.KeyValue:=R400FCartellinoDtM.Q950Lista.FieldByname('Codice').AsString;
  frmInputPeriodo.edtInizioExit(nil);
  try
    C001SettaQuickReport(A027StampaTimb(*IW.QRep*));
  except
  end;
  if TipoModulo <> 'COM' then
  begin
    //Lettura parametri
    CreaC004(SessioneOracle,'A027',Parametri.ProgOper);
    GetParametriFunzione;
    CAggiornamentoClick(nil);
  end
  else
  begin
    { In COM, oltre ad ignorare i valori salvati via C004, imposto i valori di default
      per le proprietà non gestite da W009 }
    GetParametriFunzione; // Gestisce il TipoModulo e imposta i valori di default
    chkIgnoraAnomalieStampa.Checked:=True;
    chkIgnoraAnomalie.Checked:=True;
  end;
  NomeStampa.KeyValue:=sParametri.sNomeStampa;
  if NomeStampa.Text = '' then
    NomeStampa.KeyValue:=null;
  chkNumPagina.Checked:=sParametri.sChkNumPagina = 'S';
  edtNumPagina.Value:=StrToInt(sParametri.sNumPagina);
  chkPaginaParita.Checked:=sParametri.sPaginaParita = 'S';
  chkAutoGiustificazione.Checked:=sParametri.sAutoGiustificazione = 'S';
  chkIgnoraAnomalie.Checked:=sParametri.sIgnoraAnomalie = 'S';
  chkIgnoraAnomalieStampa.Checked:=sParametri.sIgnoraAnomalieStampa = 'S';  //LORENA 28/07/2004
  chkParametrizzazioniTipoCartellino.Checked:=sParametri.sParametrizzazioniTipoCar = 'S';
  chkNumPaginaClick(chkNumPagina);
  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700TuttiCampi;//C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  C700DataDal:=Parametri.DataLavoro;
  frmSelAnagrafe.SelezionePeriodica:=True;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  //C700SelezionePeriodica:=True;
  R400FCartellinoDtM.A027SelAnagrafe:=C700SelAnagrafe;
  A027StampaTimb(*IW.QRep*).DataSet:=C700SelAnagrafe;
end;

procedure TA027FCarMen.BitBtn2Click(Sender: TObject);
{Impostazione stampante}
begin
  if PrinterSetupDialog1.Execute then
    C001SettaQuickReport(A027StampaTimb(*IW.QRep*));
end;

procedure TA027FCarMen.BitBtn4Click(Sender: TObject);
{Aggiornamento delle schede riepilogative senza stampa}
var A,M,G,A2,M2,G2,MCorr,ACorr:Word;
    xx,yy:Integer;
    DataI,DataF:TDateTime;
    i:Byte;
    B027:Boolean;
    LStopWatch: TStopWatch;
begin
  StatusBar.Panels[1].Text:='Elaborazione in corso...';
  StatusBar.Repaint;
  // avvio timer di precisione
  LStopWatch:=TStopwatch.StartNew;
  try
    B027:=Copy(ExtractFileName(Application.Exename),1,4) = 'B027';
    RegistraMsg.IniziaMessaggio(IfThen(B027,'B027','A027'));
    btnAnomalie.Enabled:=False;
    R400FCartellinoDtM.selDatiBloccati.Close;
    R400FCartellinoDtM.PrimoPassaggioStampa:=True;
    R400FCartellinoDtM.SoloAggiornamento:=True;
    R400FCartellinoDtM.AggiornamentoScheda:=CAggiornamento.Checked;
    R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
    R400FCartellinoDtM.IgnoraAnomalie:=chkIgnoraAnomalie.Checked;
    DataI := frmInputPeriodo.DataInizio;
    DataF := frmInputPeriodo.DataFine;

    if DataI > DataF then
      raise Exception.Create('Il periodo indicato non è valido!');
    DecodeDate(DataI,A,M,G);
    DecodeDate(DataF,A2,M2,G2);
    LeggiParametrizzazione(True);
    //Se le date differiscono di mese o di anno, allora i giorni vanno
    //da 1 all'ultimo del mese
    if (M <> M2) or (A <> A2) then
    begin
      G:=1;
      G2:=R180GiorniMese(DataF);
      DataI:=EncodeDate(A,M,G);
      DataF:=EncodeDate(A2,M2,G2);
      frmInputPeriodo.DataInizio := DataI;
      frmInputPeriodo.DataFine := DataF;
    end;
    if CAggiornamento.Checked then
    begin
      if chkBuoniPasto.Checked then
      begin
        R400FCartellinoDtM.RiepilogoBuoniPasto:=True;
        R400FCartellinoDtM.R350DtM:=TR350FCalcoloBuoniDtM.Create(Self);
        R400FCartellinoDtM.R350DtM.selAnagrafe:=C700SelAnagrafe;
        R400FCartellinoDtM.R350DtM.RMCampoRagg:='';
        R400FCartellinoDtM.R350DtM.RMStampa:=False;
        R400FCartellinoDtM.R350DtM.RMIgnoraAnomalie:=chkIgnoraAnomalie.Checked;
        R400FCartellinoDtM.R350DtM.RMRegistrazione:=True;
      end;
      if chkAccessiMensa.Checked then
      begin
        R400FCartellinoDtM.RiepilogoAccessiMensa:=True;
        R400FCartellinoDtM.R300DtM:=TR300FAccessiMensaDtM.Create(nil);
        R400FCartellinoDtM.R300DtM.SettaPeriodo(DataI,DataF);
        R400FCartellinoDtM.R300DtM.FiltroRilevatori:='';
      end;
      if chkInserimentoRiposi.Checked then
      begin
        R400FCartellinoDtM.InserimentoRiposi:=True;
        R400FCartellinoDtM.A041MW:=TA041FInsRiposiMW.Create(nil);
        R400FCartellinoDtM.A041MW.SelAnagrafe:=C700SelAnagrafe;
        R400FCartellinoDtM.A041MW.InizializzaSelDatiBloccati;
        R400FCartellinoDtM.A041MW.InizializzaComponentiElaborazione;
      end;
    end;
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    frmSelAnagrafe.ElaborazioneInterrompibile:=True and (not B027);
    if not B027 then
      Self.Enabled:=False;
    if B027 then
    begin
      KeyPreview:=False;
      OnKeyPress:=nil;
      RegistraMsg.InserisciMessaggio('I','Inizio elaborazione cartolina',Parametri.Azienda);
    end;
    with C700SelAnagrafe do
    begin
      First;
      if not B027 then
      begin
        ProgressBar1.Position:=0;
        ProgressBar1.Max:=RecordCount;
        Screen.Cursor:=crHourGlass;
      end;
      while not Eof do
      begin
        if not B027 then
          ProgressBar1.StepBy(1);
        MCorr:=M;
        ACorr:=A;
        while ((ACorr < A2) and (MCorr <= 12)) or ((ACorr = A2) and (MCorr <= M2)) do
        begin
          try
            repeat
              for xx:=1 to MaxRighe do for yy:=1 to MaxColonne do R400FCartellinoDtM.MatDettStampa[xx,yy]:='';
              for i:=1 to High(R400FCartellinoDtM.VetDomenica) do R400FCartellinoDtM.VetDomenica[i]:= -1;
              for xx:=Low(R400FCartellinoDtM.TotSett) to High(R400FCartellinoDtM.TotSett) do
              begin
                R400FCartellinoDtM.TotSett[xx].Debito:='';
                R400FCartellinoDtM.TotSett[xx].OreRese:='';
                R400FCartellinoDtM.TotSett[xx].Saldo:='';
              end;
              R400FCartellinoDtM.NumGiorniCartolina:=0;
              //Se devo ciclare per più mesi allora calcolo il numero di
              //giorni di ciascun mese
              if (M <> M2) or (A <> A2) then
                G2:=R180GiorniMese(EncodeDate(ACorr,MCorr,1));
              if not B027 then
                frmSelAnagrafe.VisualizzaDipendente;
              if B027 then
                RegistraMsg.InserisciMessaggio('I','CartolinaDipendente di ' + Format('%.2d/%d',[MCorr,ACorr]),Parametri.Azienda,C700Progressivo);
              R400FCartellinoDtM.CartolinaDipendente(C700Progressivo,ACorr,MCorr,G,G2);
              if R400FCartellinoDtM.DipInser1 = 'no' then
              begin
                inc(MCorr);
                if MCorr > 12 then
                begin
                  inc(ACorr);
                  MCorr:=1;
                end;
              end;
              (*else
              begin
                RegistraLog.SettaProprieta('I','T070_SCHEDARIEPIL',copy(Self.Name,1,4),nil,True);
                RegistraLog.InserisciDato('PROGRESSIVO','',IntToStr(C700Progressivo));
                RegistraLog.InserisciDato('DA_DATA','',DateToStr(EncodeDate(ACorr,MCorr,G)));
                RegistraLog.InserisciDato('A_DATA','',DateToStr(EncodeDate(ACorr,MCorr,G2)));
                RegistraLog.RegistraOperazione;
              end;*)
            until (R400FCartellinoDtM.DipInSer1 = 'si') or (ACorr > A2) or ((ACorr = A2) and (MCorr > M2));
            if R400FCartellinoDtM.DipInSer1 = 'no' then
              Break;
          except
            //Log
          end;
          inc(MCorr);
          if MCorr > 12 then
          begin
            inc(ACorr);
            MCorr:=1;
          end;
        end;
        Next;
      end;
    end;
    if B027 then
      RegistraMsg.InserisciMessaggio('I','Fine elaborazione cartolina',Parametri.Azienda);
    frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    Self.Enabled:=True;
    if not B027 then
    begin
      Screen.Cursor:=crDefault;
      ProgressBar1.Position:=0;
      frmSelAnagrafe.VisualizzaDipendente;
    end;
    R400FCartellinoDtM.R450DtM1.DeallocaQueryStampa;
    if R400FCartellinoDtM.RiepilogoBuoniPasto then
    begin
      R400FCartellinoDtM.RiepilogoBuoniPasto:=False;
      FreeAndNil(R400FCartellinoDtM.R350DtM);
    end;
    if R400FCartellinoDtM.RiepilogoAccessiMensa or (R400FCartellinoDtM.R300DtM <> nil) then
    begin
      R400FCartellinoDtM.RiepilogoAccessiMensa:=False;
      FreeAndNil(R400FCartellinoDtM.R300DtM);
    end;
    if R400FCartellinoDtM.InserimentoRiposi or (R400FCartellinoDtM.A041MW <> nil) then
    begin
      R400FCartellinoDtM.InserimentoRiposi:=False;
      FreeAndNil(R400FCartellinoDtM.A041MW);
    end;

    // stop timer di precisione
    LStopWatch.Stop;
    StatusBar.Panels[1].Text:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
    StatusBar.Repaint;

    if not B027 then
    begin
      // gestione anomalie
      btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
      if btnAnomalie.Enabled then
      begin
        if (R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes) then
          btnAnomalieClick(nil);
      end
      else
        R180MessageBox('Elaborazione terminata',INFORMA);
    end
    else
      RegistraMsg.InserisciMessaggio('I','Chiusura',Parametri.Azienda);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA027FCarMen.BitBtn1Click(Sender: TObject);
{Lancio il processo di stampa}
var A,M,G,A2,M2,G2:Word;
    DataI,DataF:TDateTime;
    i,LarghezzaIntestazione,ForzaPeriodo:Integer;
    LStopWatch: TStopWatch;
begin
  A027StampaTimb.PrinterSettings.UseStandardPrinter:=(TipoModulo = 'COM') and (Parametri.UseStandardPrinter);
  StatusBar.Panels[1].Text:='Stampa in corso...';
  StatusBar.Repaint;
  // avvio timer di precisione
  LStopWatch:=TStopwatch.StartNew;
  try
    RegistraMsg.IniziaMessaggio(IfThen(Copy(ExtractFileName(Application.Exename),1,4) = 'B027','B027','A027'));
    btnAnomalie.Enabled:=False;
    R400FCartellinoDtM.selDatiBloccati.Close;
    //R400FCartellinoDtM.selDatiBloccati.FileLog:='';
    R400FCartellinoDtM.PrimoPassaggioStampa:=True;
    R400FCartellinoDtM.SoloAggiornamento:=False;
    R400FCartellinoDtM.AggiornamentoScheda:=CAggiornamento.Checked;
    R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
    R400FCartellinoDtM.IgnoraAnomalie:=chkIgnoraAnomalie.Checked;
    A027StampaTimb.AggSchedaRiep:='';
    A027StampaTimb.ParCartellinoFisso:=NomeStampa.Text;
    if R400FCartellinoDtM.AggiornamentoScheda then
      A027StampaTimb.AggSchedaRiep:=A000MSG_R400_MSG_AGGIORNAMENTO_SCHEDA;
    DataI := frmInputPeriodo.DataInizio;
    DataF := frmInputPeriodo.DataFine;
    if DataI > DataF then
      raise Exception.Create('Il periodo indicato non è valido!');
    if Trim(NomeStampa.Text) = '' then
      raise Exception.Create('Non è stata indicata una parametrizzazione valida!');

    if (DataF > R180FineMese(Now)) then
    begin
      ForzaPeriodo:=MessageDlg(A000MSG_A027_ERR_CONFERMA_PERIODO,mtWarning,[mbOK, mbNo],0);
      if ForzaPeriodo = mrOk then
      begin
        DataF:=DataOut(0, A000MSG_A027_ERR_CONFERMA_PERIODO_TITOLO, 'G');
        if DataF <> frmInputPeriodo.DataFine then
        begin
          R180MessageBox(A000MSG_A027_ERR_DATA_ERRATA,ESCLAMA);
          Exit;
        end;
      end
      else
        Exit;
    end;

    DecodeDate(DataI,A,M,G);
    DecodeDate(DataF,A2,M2,G2);
    //Se le date differiscono di mese o di anno, allora i giorni vanno
    //da 1 all'ultimo del mese
    if (M <> M2) or (A <> A2) then
    begin
      G:=1;
      G2:=R180GiorniMese(DataF);
      DataI:=EncodeDate(A,M,G);
      DataF:=EncodeDate(A2,M2,G2);
      frmInputPeriodo.DataInizio := DataI;
      frmInputPeriodo.DataFine := DataF;
    end;
    A027StampaTimb.Anno1:=A;
    A027StampaTimb.Anno2:=A2;
    A027StampaTimb.Mese1:=M;
    A027StampaTimb.Mese2:=M2;
    A027StampaTimb.Giorno1:=G;
    A027StampaTimb.Giorno2:=G2;
    A027StampaTimb.R400FCartellinoDtM:=R400FCartellinoDtM;
    A027StampaTimb.CampiBase:=C700CampiBase;
    LeggiParametrizzazione(False);
    R400FCartellinoDtM.StampaFileTesto:=Sender = BitBtn5;
    A027StampaTimb.RTTimb.Enabled:=(A027StampaTimb.RTTimb.Enabled) and (not R400FCartellinoDtM.StampaFileTesto);
    A027StampaTimb.QMTimb.Enabled:=(A027StampaTimb.QMTimb.Enabled) and R400FCartellinoDtM.StampaFileTesto;
    //Caricamento tag dei dati di dettaglio per formattazione dei dati nella R400
    R400FCartellinoDtM.lstDettaglio.Clear;
    for i:=0 to A027StampaTimb.QRSDet1.ControlCount - 1 do
      R400FCartellinoDtM.lstDettaglio.Add(IntToStr(A027StampaTimb.QRSDet1.Controls[i].Tag));
    //Caricamento tag dei dati di riepilogo per ottimizzazione delle query nella R400
    R400FCartellinoDtM.lstRiepilogo.Clear;
    for i:=0 to A027StampaTimb.Riepilogo.ControlCount - 1 do
      R400FCartellinoDtM.lstRiepilogo.Add(IntToStr(A027StampaTimb.Riepilogo.Controls[i].Tag));
    if frmSelAnagrafe.SettaPeriodoSelAnagrafe(DataI,DataF) then
      C700SelAnagrafe.Close;
    C700SelAnagrafe.Open;
    if (CAggiornamento.Checked) or (TipoModulo = 'COM') then
    begin
      if chkBuoniPasto.Checked then
      begin
        R400FCartellinoDtM.RiepilogoBuoniPasto:=True;
        R400FCartellinoDtM.R350DtM:=TR350FCalcoloBuoniDtM.Create(Self);
        R400FCartellinoDtM.R350DtM.selAnagrafe:=C700SelAnagrafe;
        R400FCartellinoDtM.R350DtM.RMCampoRagg:='';
        R400FCartellinoDtM.R350DtM.RMStampa:=False;
        R400FCartellinoDtM.R350DtM.RMIgnoraAnomalie:=chkIgnoraAnomalie.Checked;
        R400FCartellinoDtM.R350DtM.RMRegistrazione:=True;
      end;
      if chkAccessiMensa.Checked then
      begin
        R400FCartellinoDtM.RiepilogoAccessiMensa:=True;
        R400FCartellinoDtM.R300DtM:=TR300FAccessiMensaDtM.Create(nil);
        R400FCartellinoDtM.R300DtM.SettaPeriodo(DataI,DataF);
        R400FCartellinoDtM.R300DtM.FiltroRilevatori:='';
      end;
      if chkInserimentoRiposi.Checked then
      begin
        R400FCartellinoDtM.InserimentoRiposi:=True;
        R400FCartellinoDtM.A041MW:=TA041FInsRiposiMW.Create(nil);
        R400FCartellinoDtM.A041MW.SelAnagrafe:=C700SelAnagrafe;
        R400FCartellinoDtM.A041MW.InizializzaSelDatiBloccati;
        R400FCartellinoDtM.A041MW.InizializzaComponentiElaborazione;
      end;
    end;
    with A027StampaTimb do
    begin
      LAzienda.Enabled:=R400FCartellinoDtM.Q950Int.FieldByName('RAGIONE_SOCIALE').AsString = 'S';
      qlblNumPaginaMan.Enabled:=chkNumPagina.Checked and (R400FCartellinoDtM.Q950Int.FieldByName('NUM_PAGINE').AsString = 'S');
      qlblNumPaginaAuto.Enabled:=(not chkNumPagina.Checked) and (R400FCartellinoDtM.Q950Int.FieldByName('NUM_PAGINE').AsString = 'S');
      NumPaginaChecked:=chkNumPagina.Checked;
      NumPaginaValue:=edtNumPagina.Value;
      qlblNumPaginaAuto.Top:=25;
      qlblNumPaginaMan.Top:=25;
      IgnoraAnomalieStampa:=chkIgnoraAnomalieStampa.Checked;
      ParametrizzazioniTipoCar:=chkParametrizzazioniTipoCartellino.Checked;
      IntestazioneRipetuta:=R400FCartellinoDtM.Q950Int.FieldByName('INTESTAZIONE_RIPETUTA').AsString = 'S';
      A027VisualizzaDipendente:=frmSelAnagrafe.VisualizzaDipendente;
      if R400FCartellinoDtM.Q950Int.FieldByName('MARGINE_SUP').IsNull then
      begin
        //Margine standard
        (*IWQRep.*)Page.Units:=MM;
        (*IWQRep.*)Page.TopMargin:=5;
      end
      else
      begin
        //Margine personalizzato (stampa Inail)
        (*IWQRep.*)Page.Units:=MM;
        (*IWQRep.*)Page.TopMargin:=R400FCartellinoDtM.Q950Int.FieldByName('MARGINE_SUP').AsInteger;
      end;
    end;
    C700SelAnagrafe.First;
    if Sender = BitBtn3 then
      A027StampaTimb(*IW.QRep*).Preview
    else if Sender = BitBtn1 then
    begin
      if (TipoModulo = 'COM') and (DocumentoPDF <> '') and (DocumentoPDF <> '<VUOTO>') then
      begin
        A027StampaTimb.ShowProgress:=False;
        A027StampaTimb.ExportToFilter(TQRPDFDocumentFilter.Create(DocumentoPDF));
      end
      else
      begin
        try
          Self.Enabled:=False;
          A027StampaTimb(*IW.QRep*).Print;
        finally
          Self.Enabled:=True;
        end
      end;
    end
    else if Sender = BitBtn5 then
    begin
      if NomeFileTesto <> '' then
        A027StampaTimb(*IW.QRep*).ExportToFilter(TQRAsciiExportFilter.Create(NomeFileTesto))
      else if SaveDialog1.Execute then
      begin
        // riavvia il timer di precisione dopo la dialog
        LStopWatch:=TStopwatch.StartNew;

        //Esportazione su file di testo
        A027StampaTimb(*IW.QRep*).ExportToFilter(TQRAsciiExportFilter.Create(SaveDialog1.FileName));
        //Salvataggio del percorso + nome del file di testo...
        C004FParamForm.Cancella001;
        C004FParamForm.PutParametro('NOMEFILETESTO',SaveDialog1.FileName);
        try SessioneOracle.Commit; except end;
      end;
    end;
    if chkNumPagina.Checked then
      edtNumPagina.Value:=A027StampaTimb.NumPaginaManuale;
    R400FCartellinoDtM.R450DtM1.DeallocaQueryStampa;
    if (R400FCartellinoDtM.RiepilogoBuoniPasto) or (R400FCartellinoDtM.R350DtM <> nil) then
    begin
      R400FCartellinoDtM.RiepilogoBuoniPasto:=False;
      FreeAndNil(R400FCartellinoDtM.R350DtM);
    end;
    if R400FCartellinoDtM.RiepilogoAccessiMensa or (R400FCartellinoDtM.R300DtM <> nil) then
    begin
      R400FCartellinoDtM.RiepilogoAccessiMensa:=False;
      FreeAndNil(R400FCartellinoDtM.R300DtM);
    end;
    if R400FCartellinoDtM.InserimentoRiposi or (R400FCartellinoDtM.A041MW <> nil) then
    begin
      R400FCartellinoDtM.InserimentoRiposi:=False;
      FreeAndNil(R400FCartellinoDtM.A041MW);
    end;
    btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  finally
    // stop timer di precisione
    LStopWatch.Stop;
    Screen.Cursor:=crDefault;
    StatusBar.Panels[1].Text:='Tempo di esecuzione: ' + FormatDateTime(FMT_DURATA_ELABORAZIONE,LStopWatch.ElapsedMilliseconds / MSecsPerDay);
    StatusBar.Repaint;
  end;
end;

procedure TA027FCarMen.btnAnomalieClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A027','');
  C700DatiSelezionati:=C700TuttiCampi;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;

  R400FCartellinoDtM.A027SelAnagrafe:=C700SelAnagrafe;
  A027StampaTimb.DataSet:=C700SelAnagrafe;
end;

procedure TA027FCarMen.btnArchiviazioneCartelliniClick(Sender: TObject);
var
  DataDal, DataAl: TDateTime;
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  try
    DataDal:=R180InizioMese(frmInputPeriodo.DataInizio);
  except
    DataDal:=R180InizioMese(Parametri.DataLavoro);
  end;
  try
    DataAl:=R180FineMese(frmInputPeriodo.DataFine);
  except
    DataAl:=R180FineMese(Parametri.DataLavoro);
  end;
  OpenA159ArchiviazioneCartellini(R180InizioMese(DataDal), R180FineMese(DataAl));
  C700DatiSelezionati:=C700TuttiCampi;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;

  R400FCartellinoDtM.A027SelAnagrafe:=C700SelAnagrafe;
  A027StampaTimb.DataSet:=C700SelAnagrafe;
end;

procedure TA027FCarMen.btnBloccoRiepiloghiClick(Sender: TObject);
begin
  frmSelAnagrafe.SalvaC00SelAnagrafe;
  C700Distruzione;
  OpenA126BloccoRiepiloghi(C700Progressivo,'A027', R180InizioMese(frmInputPeriodo.DataInizio), R180InizioMese(frmInputPeriodo.DataFine));
  C700DatiSelezionati:=C700TuttiCampi;
  C700Creazione(SessioneOracle);
  frmSelAnagrafe.RipristinaC00SelAnagrafe;

  R400FCartellinoDtM.A027SelAnagrafe:=C700SelAnagrafe;
  A027StampaTimb.DataSet:=C700SelAnagrafe;
end;

procedure TA027FCarMen.LeggiParametrizzazione(SoloAggiornamento:Boolean);
begin
  with R400FCartellinoDtM.Q950Int do
  begin
    Close;
    SetVariable('Codice',NomeStampa.Text);
    Open;
    if SoloAggiornamento then
      exit;
    C001SettaQuickReport(A027StampaTimb(*IW.QRep*));
    if FieldByName('ORIENTAMENTO').AsString = 'V' then  //LORENA 07/02/2005
      A027StampaTimb(*IW.QRep*).Page.Orientation:=poPortrait
    else if FieldByName('ORIENTAMENTO').AsString = 'O' then
      A027StampaTimb(*IW.QRep*).Page.Orientation:=poLandScape;
  end;
  A027StampaTimb.LeggiIntestazione;
  (*if A027StampaTimb.DatiIntestazione <> '' then
    if Pos(A027StampaTimb.DatiIntestazione,C700SelAnagrafe.SQL.Text) = 0 then
    begin
      S:=C700SelAnagrafe.SQL.Text;
      I:=Pos('FROM',S);
      if I > 0 then
        Insert(A027StampaTimb.DatiIntestazione + ' ',S,I);
      C700SelAnagrafe.Close;
      C700SelAnagrafe.SQL.Text:=S;
      C700SelAnagrafe.Open;
    end;
  *)
end;

procedure TA027FCarMen.GetElencoIntestazione;
var i,j,i2:Integer;
    S,Nome:String;
    ListaSettaggi:TStringlist;
begin
  ListaSettaggi:=TStringList.Create;
  with R400FCartellinoDtM do
    try
      Q950Int.Close;
      Q950Int.SetVariable('Codice',NomeStampa.Text);
      Q950Int.Open;
      selT951.Close;
      selT951.SetVariable('Codice',NomeStampa.Text);
      selT951.Open;
      ListaSettaggi.Clear;
      while not selT951.Eof do
      begin
        ListaSettaggi.Add(Trim(selT951.FieldByName('RIGA').AsString));
        selT951.Next;
      end;
      selT951.Close;
      //Impostazioni delle Labels
      A027StampaTimb.DatiIntestazione:='';
      i:=ListaSettaggi.IndexOf('[LABELS]');
      if i = -1 then
        ShowMessage('Intestazione:Le labels non sono leggibili.')
      else
        begin
        //Cerco la fine delle impostazioni del gruppo (Intestazione/Dettaglio/Riepilogo)
        i2:=ListaSettaggi.IndexOf('[FONTDettaglio]');
        if i2 < i then
          begin
          i2:=ListaSettaggi.IndexOf('[FONTRiepilogo]');
          if i2 < i then
            i2:=ListaSettaggi.Count;
          end;
        for j:=i + 1 to i2 - 1 do
          begin
          S:=ListaSettaggi[j];
          //Leggo il Nome della labels
          if not R180Getvalore(S,'[N]','[C]',Nome) then
            begin
            ShowMessage('Intestazione:La label non è completa (Nome)');
            Continue;
            end;
          if Pos(Nome,C700CampiBase) = 0 then
            A027StampaTimb.DatiIntestazione:=A027StampaTimb.DatiIntestazione + ',' + Nome;
          end;
        end;
    finally
      ListaSettaggi.Free;
    end;
end;

procedure TA027FCarMen.CAggiornamentoClick(Sender: TObject);
begin
  if TipoModulo = 'COM' then
    Exit;
  BitBtn4.Enabled:=CAggiornamento.Checked;
  chkIgnoraAnomalie.Enabled:=CAggiornamento.Checked;
  chkBuoniPasto.Enabled:=CAggiornamento.Checked and AbilBuoniPasto;
  chkAccessiMensa.Enabled:=CAggiornamento.Checked and AbilAccessiMensa;
  //Alberto 04/04/2018: abilitazione inserimento riposi solo è definito un campo anagrafico per la regola. Se regola unica non si abilita per evitare sbagli da parte degli operatori.
  chkInserimentoRiposi.Enabled:=CAggiornamento.Checked and AbilInserimentoRiposi;
  if not CAggiornamento.Checked then
  begin
    chkBuoniPasto.Checked:=False;
    chkAccessiMensa.Checked:=False;
    chkInserimentoRiposi.Checked:=False;
  end;
  AbilitaBloccoRiepiloghi;
end;

procedure TA027FCarMen.AbilitaBloccoRiepiloghi;
begin
  try
    btnBloccoRiepiloghi.Visible:=(A000GetInibizioni('Tag','59'(*funz. A126*)) = 'S') and
                                 (frmInputPeriodo.DataInizio < frmInputPeriodo.DataFine) and
                                 (frmInputPeriodo.DataInizio = R180InizioMese(frmInputPeriodo.DataInizio)) and
                                 (frmInputPeriodo.DataFine = R180FineMese(frmInputPeriodo.DataFine)) and
                                 CAggiornamento.Checked and
                                 (C700SelAnagrafe.RecordCount > 0);
  except //Date impostate male...
    btnBloccoRiepiloghi.Visible:=False;
  end;
end;

procedure TA027FCarMen.GetParametriFunzione;
begin
  if TipoModulo <> 'COM' then
  begin
    //Leggo i parametri di questa mappa
    sParametri.sNomeStampa:=C004FParamForm.GetParametro('NOMESTAMPA', R400FCartellinoDtM.Q950Lista.FieldByname('Codice').AsString);
    sParametri.sChkNumPagina:=C004FParamForm.GetParametro('CK_NUMERO_PAGINA', 'N');
    sParametri.sNumPagina:=C004FParamForm.GetParametro('NUMERO_PAGINA', '1');
    sParametri.sPaginaParita:=C004FParamForm.GetParametro('PAGINAPARITA', 'N');
    sParametri.sAutoGiustificazione:=C004FParamForm.GetParametro('AUTOGIUSTIFICAZIONE', 'N');
    sParametri.sIgnoraAnomalie:=C004FParamForm.GetParametro('IGNORAANOMALIE', 'S');
    sParametri.sIgnoraAnomalieStampa:=C004FParamForm.GetParametro('IGNORAANOMALIESTAMPA', 'S');  //LORENA 28/07/2004
    sParametri.sParametrizzazioniTipoCar:=C004FParamForm.GetParametro('PARAMTIPOCAR', 'S');
    //Leggo i parametri della form di stampa
    sParametri.sFileTesto:=C004FParamForm.GetParametro('FILETESTO', '');
    sParametri.sCarCon:=C004FParamForm.GetParametro('CARRIGA', '');
    sParametri.sNumRighe:=C004FParamForm.GetParametro('NUMRIGHE', '0');
    sParametri.sNumRigheHeader:=C004FParamForm.GetParametro('NUMHEADER', '0');
    sParametri.sNumRigheFooter:=C004FParamForm.GetParametro('NUMFOOTER', '0');
    sParametri.sSaltoPagina:=C004FParamForm.GetParametro('SALTOPAGINA', '');
  end
  else
  begin
    //Imposto i parametri default di questa mappa
    sParametri.sNomeStampa:=R400FCartellinoDtM.Q950Lista.FieldByname('Codice').AsString; // Superfluo
    sParametri.sChkNumPagina:='N';
    sParametri.sNumPagina:='1';
    sParametri.sPaginaParita:='N';
    sParametri.sAutoGiustificazione:='N';
    sParametri.sIgnoraAnomalie:='S';
    sParametri.sIgnoraAnomalieStampa:='S';  //LORENA 28/07/2004
    sParametri.sParametrizzazioniTipoCar:='S';
    //Imposto i parametri default della form di stampa
    sParametri.sFileTesto:='';
    sParametri.sCarCon:='';
    sParametri.sNumRighe:='0';
    sParametri.sNumRigheHeader:='0';
    sParametri.sNumRigheFooter:='0';
    sParametri.sSaltoPagina:='';
  end;

end;

procedure TA027FCarMen.PutParametriFunzione;
begin
  //Aggiorno sParametri con i valori modificati per questa mappa...
  sParametri.sNomeStampa:=VarToStr(NomeStampa.KeyValue);
  sParametri.sChkNumPagina:=IfThen(chkNumPagina.Checked,'S','N');
  sParametri.sPaginaParita:=IfThen(chkPaginaParita.Checked,'S','N');
  sParametri.sAutoGiustificazione:=IfThen(chkAutoGiustificazione.Checked,'S','N');
  sParametri.sIgnoraAnomalie:=IfThen(chkIgnoraAnomalie.Checked,'S','N');
  sParametri.sIgnoraAnomalieStampa:=IfThen(chkIgnoraAnomalieStampa.Checked,'S','N'); //LORENA 28/07/2004
  sParametri.sParametrizzazioniTipoCar:=IfThen(chkParametrizzazioniTipoCartellino.Checked,'S','N');
  sParametri.sNumPagina:=edtNumPagina.Text;
  //Cancello
  C004FParamForm.Cancella001;
  //Setto i parametri
  C004FParamForm.PutParametro('NOMESTAMPA',sParametri.sNomeStampa);
  C004FParamForm.PutParametro('CK_NUMERO_PAGINA',sParametri.sChkNumPagina);
  C004FParamForm.PutParametro('NUMERO_PAGINA',sParametri.sNumPagina);
  C004FParamForm.PutParametro('PAGINAPARITA',sParametri.sPaginaParita);
  C004FParamForm.PutParametro('AUTOGIUSTIFICAZIONE',sParametri.sAutoGiustificazione);
  C004FParamForm.PutParametro('IGNORAANOMALIE',sParametri.sIgnoraAnomalie);
  C004FParamForm.PutParametro('IGNORAANOMALIESTAMPA',sParametri.sIgnoraAnomalieStampa);  //LORENA 28/07/2004
  C004FParamForm.PutParametro('PARAMTIPOCAR',sParametri.sParametrizzazioniTipoCar);

  C004FParamForm.PutParametro('FILETESTO', sParametri.sFileTesto);
  C004FParamForm.PutParametro('CARRIGA', sParametri.sCarCon);
  C004FParamForm.PutParametro('NUMRIGHE', sParametri.sNumRighe);
  C004FParamForm.PutParametro('NUMHEADER', sParametri.sNumRigheHeader);
  C004FParamForm.PutParametro('NUMFOOTER', sParametri.sNumRigheFooter);
  C004FParamForm.PutParametro('SALTOPAGINA', sParametri.sSaltoPagina);
  try SessioneOracle.Commit; except end;
end;

procedure TA027FCarMen.TfrmSelAnagrafe1btnSelezioneClick(Sender: TObject);
begin
  try
    C700DataDal:= frmInputPeriodo.DataInizio;
    C700DataLavoro:= frmInputPeriodo.DataFine;

  except
    C700DataDal:=Parametri.DataLavoro;
    C700DataLavoro:=Parametri.DataLavoro;
  end;
  frmSelAnagrafe.btnSelezioneClick(Sender);
  A027StampaTimb.DatiIntestazione:='';
  if NomeStampa.Text <> '' then
    GetElencoIntestazione;
  AbilitaBloccoRiepiloghi;
end;

procedure TA027FCarMen.TfrmSelAnagrafe1R003DatianagraficiClick(
  Sender: TObject);
begin
  if frmInputPeriodo.DataFine > 0 then
    C005DataVisualizzazione:= frmInputPeriodo.DataFine
  else
    C005DataVisualizzazione:=Parametri.DataLavoro;

  frmSelAnagrafe.R003DatianagraficiClick(Sender);
end;

procedure TA027FCarMen.chkNumPaginaClick(Sender: TObject);
begin
  edtNumPagina.Enabled:=chkNumPagina.Checked;
end;

procedure TA027FCarMen.btnStampaAsciiClick(Sender: TObject);
begin
  R400FCartellinoDtM.AutoGiustificazione:=chkAutoGiustificazione.Checked;
  A027UStampaTesto.OpenA027StampaTesto;
end;

procedure TA027FCarMen.Nuovoelemento1Click(Sender: TObject);
begin
  OpenA052ParCar(NomeStampa.Text);
  R400FCartellinoDtM.Q950Lista.DisableControls;
  R400FCartellinoDtM.Q950Lista.Refresh;
  R400FCartellinoDtM.Q950Lista.EnableControls;
  R400FCartellinoDtM.Q950Lista.SearchRecord('CODICE',NomeStampa.Text,[srFromBeginning])
end;

procedure TA027FCarMen.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if TipoModulo <> 'COM' then
    PutParametriFunzione;
end;

procedure TA027FCarMen.FormDestroy(Sender: TObject);
begin
  A027StampaTimb.DistruggiListe;
  A027StampaTimb.ListaFasce.Free;
  A027StampaTimb.ListaShape.Free;
  A027StampaTimb.A027VisualizzaDipendente:=nil;
  FreeAndNil(A027StampaTimb);
  FreeAndNil(C004FParamForm);
  FreeAndNil(R400FCartellinoDtM);
  frmSelAnagrafe.DistruggiSelAnagrafe;
  FreeAndNil(DatiStorici);
  //Parametri.FileAnomalie:='';
end;

procedure TA027FCarMen.NomeStampaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Delete then
  begin
    (Sender as TDBLookupComboBox).KeyValue:=null;
    if (Sender as TDBLookupComboBox).Field <> nil then
      if (Sender as TDBLookupComboBox).DataSource.State in [dsEdit,dsInsert] then
        (Sender as TDBLookupComboBox).Field.Clear;
  end;
end;

procedure TA027FCarMen.frmInputPeriodobtnAvantiClick(Sender: TObject);
begin
  frmInputPeriodo.btnAvantiClick(Sender);
  AbilitaBloccoRiepiloghi;
end;

procedure TA027FCarMen.frmInputPeriodobtnIndietroClick(Sender: TObject);
begin
  frmInputPeriodo.btnIndietroClick(Sender);
  AbilitaBloccoRiepiloghi;
end;

procedure TA027FCarMen.frmInputPeriodoedtFineExit(Sender: TObject);
begin
  AbilitaBloccoRiepiloghi;
end;

procedure TA027FCarMen.frmInputPeriodoedtInizioExit(Sender: TObject);
begin
  frmInputPeriodo.edtInizioExit(Sender);
  AbilitaBloccoRiepiloghi;
end;

end.
