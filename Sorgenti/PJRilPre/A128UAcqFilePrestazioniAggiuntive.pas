unit A128UAcqFilePrestazioniAggiuntive;

interface

uses Windows, SysUtils, Dialogs, Grids, StdCtrls, Controls, Mask, Buttons,
     Classes, Forms,
     C012UVisualizzaTesto, C180FunzioniGenerali, C700USelezioneAnagrafe,
     A000UInterfaccia, A000UMessaggi, A003UDataLavoroBis, A083UMsgElaborazioni,
  Vcl.ExtCtrls;

type
  TA128FAcqFilePrestazioniAggiuntive = class(TForm)
    ScrollBox1: TScrollBox;
    btnAcquisizione: TBitBtn;
    btnChiudi: TBitBtn;
    btnVisAnomalie: TBitBtn;
    LblRiga: TLabel;
    LblMatricola: TLabel;
    btnVisualizzaFile: TBitBtn;
    lblFineAcquisizione: TLabel;
    edtFineAcquisizione: TMaskEdit;
    sbtFineAcquisizione: TSpeedButton;
    lblInizioAcquisizione: TLabel;
    edtInizioAcquisizione: TMaskEdit;
    sbtInizioAcquisizione: TSpeedButton;
    gpbParametriAcquisizione: TGroupBox;
    lblNomeFileInput: TLabel;
    edtNomeFileInput: TEdit;
    sbtNomeFileInput: TSpeedButton;
    grdParametrizzazioneFile: TStringGrid;
    lblGrigliaTracciato: TLabel;
    OpenDialog1: TOpenDialog;
    chkSovrascriviEsistenti: TCheckBox;
    chkCancellaFile: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbtInizioAcquisizioneClick(Sender: TObject);
    procedure sbtFineAcquisizioneClick(Sender: TObject);
    procedure sbtNomeFileInputClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure btnAcquisizioneClick(Sender: TObject);
    procedure CaricaParametriFile;
    procedure RecuperaFile;
    procedure btnVisAnomalieClick(Sender: TObject);
  private
    { Private declarations }
    NFCopia:String;
    NFCorrente:String;
    procedure CaricamentoTurniPrestazioniAggiuntive;
    procedure evtAvanzamentoAcq(Matr:String;Riga:Integer);
  public
    { Public declarations }
  end;

var
  A128FAcqFilePrestazioniAggiuntive: TA128FAcqFilePrestazioniAggiuntive;

implementation

uses A128UPianPrestazioniAggiuntive, A128UPianPrestazioniAggiuntiveDtm;

{$R *.DFM}

procedure TA128FAcqFilePrestazioniAggiuntive.FormCreate(Sender: TObject);
begin
  with grdParametrizzazioneFile do
  begin
    Width:=Width - (ColWidths[0] - 40) + 20;
    ColWidths[0]:=40;
    Cells[0,1]:='Pos.';
    Cells[0,2]:='Lung.';
    Cells[1,0]:='Matricola';
    Cells[2,0]:='Giorno';
    Cells[3,0]:='Mese';
    Cells[4,0]:='Anno';
    Cells[5,0]:='1° Turno';
    Cells[6,0]:='2 °Turno';
    Cells[7,0]:='Inizio 1° Turno';
    Cells[8,0]:='Fine 1° Turno';
    Cells[9,0]:='Inizio 2° Turno';
    Cells[10,0]:='Fine 2° Turno';
  end;
end;

procedure TA128FAcqFilePrestazioniAggiuntive.FormShow(Sender: TObject);
begin
  BtnVisAnomalie.Enabled:=False;
  evtAvanzamentoAcq('',0);
  A128FPianPrestazioniAggiuntiveDtm.A128MW.evtAvanzamentoAcq:=evtAvanzamentoAcq;
end;

procedure TA128FAcqFilePrestazioniAggiuntive.sbtInizioAcquisizioneClick(Sender: TObject);
begin
  edtInizioAcquisizione.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtInizioAcquisizione.Text),'Inizio acquisizione','G'));
end;

procedure TA128FAcqFilePrestazioniAggiuntive.sbtFineAcquisizioneClick(Sender: TObject);
begin
  edtFineAcquisizione.Text:=FormatDateTime('dd/mm/yyyy',DataOut(StrToDate(edtFineAcquisizione.Text),'Fine acquisizione','G'));
end;

procedure TA128FAcqFilePrestazioniAggiuntive.sbtNomeFileInputClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Nome del file da importare';
  if edtNomeFileInput.Text <> '' then
    OpenDialog1.FileName:=edtNomeFileInput.Text;
  if OpenDialog1.Execute then
    edtNomeFileInput.Text:=OpenDialog1.FileName;
end;

procedure TA128FAcqFilePrestazioniAggiuntive.btnVisualizzaFileClick(Sender: TObject);
begin
  //Controllo se il file esiste...
  if not FileExists(edtNomeFileInput.Text) then
    raise Exception.Create(Format(A000MSG_A128_ERR_FMT_PATH_ERRATO,['' + edtNomeFileInput.Text + '']));
  OpenC012VisualizzaTesto('<A128> Visualizza file di importazione',edtNomeFileInput.Text,nil);
end;

procedure TA128FAcqFilePrestazioniAggiuntive.btnAcquisizioneClick(Sender: TObject);
begin
  CaricaParametriFile;
  RecuperaFile;
  CaricamentoTurniPrestazioniAggiuntive;
end;

procedure TA128FAcqFilePrestazioniAggiuntive.CaricaParametriFile;
var c:Integer;
begin
  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
  begin
    for c:=1 to 10 do
    begin
      // Controllo che ogni campo sia numerico
      if not(TryStrToInt(grdParametrizzazioneFile.Cells[c,1], Mappa[c].Pos)) or not(TryStrToInt(grdParametrizzazioneFile.Cells[c,2], Mappa[c].Lun)) then
        raise Exception.Create(Format(A000MSG_A128_ERR_FMT_DATO_ERRATO,[IntToStr(c)]));
      // Controllo che il campo sia positivo (>= 0)
      if (Mappa[c].Pos < 0) or (Mappa[c].Lun < 0) then
        raise Exception.Create(Format(A000MSG_A128_ERR_FMT_DATO_NEGATIVO,[IntToStr(c)]));
      // Se l'utente ha azzerato la posizione ma non la lunghezza allora correggo il valore
      if (Mappa[c].Pos = 0) and (Mappa[c].Lun > 0) then
        Mappa[c].Lun:=0;
      // Se l'utente ha azzerato la lunghezza ma non la posizione allora correggo il valore
      if (Mappa[c].Lun = 0) and (Mappa[c].Pos > 0) then
        Mappa[c].Pos:=0;
    end;
    ControlloParametriFile;
  end;
end;

procedure TA128FAcqFilePrestazioniAggiuntive.RecuperaFile;
var NB:integer;
    bResult:boolean;
    sNomeFileAcquisizione:string;
begin
  //Recupero il nome del file da cui devo leggere i turni
  sNomeFileAcquisizione:=edtNomeFileInput.Text;
  //Controllo se il file esiste...
  if not FileExists(sNomeFileAcquisizione) then
    raise Exception.Create(Format(A000MSG_A128_ERR_FMT_PATH_ERRATO,['' + sNomeFileAcquisizione + '']));

  //Copio il file nella cartella di lavoro temporanea
  NFCorrente:=Parametri.Path + '\Temp\PrestAg';
  if not CopyFile(PChar(sNomeFileAcquisizione),PChar(NFCorrente),False) then
    raise Exception.Create(A000MSG_A128_ERR_CREA_FILE_APPOGGIO);

  //Creo la copia di backup del file ACII di input
  NFCopia:=ExtractFilePath(sNomeFileAcquisizione) + 'PA' + FormatDateTime('yymmdd',Date) + '.';
  bResult:=False;
  NB:=0;
  while not bResult do
  begin
    if CopyFile(PChar(sNomeFileAcquisizione), PChar(NFCopia + Format('%3.3d',[NB])),True) then
      bResult:=True
    else
      NB:=NB+1;
    If NB = 1000 then
      if not CopyFile(PChar(sNomeFileAcquisizione),PChar(NFCopia + '999'),False) then
      begin
        //Cancello il file temporaneo creato prima
        DeleteFile(NFCorrente);
        raise Exception.Create(A000MSG_A128_ERR_CREA_FILE_BACKUP);
      end;
  end;
  //Cancello il file creato dall'utente
  if chkCancellaFile.Checked then
    DeleteFile(sNomeFileAcquisizione);

  A128FPianPrestazioniAggiuntiveDtm.A128MW.ApriFile(NFCorrente);
end;

procedure TA128FAcqFilePrestazioniAggiuntive.CaricamentoTurniPrestazioniAggiuntive;
begin
  Screen.Cursor:=crHourGlass;
  BtnVisAnomalie.Enabled:=False;
  ScrollBox1.Refresh;
  evtAvanzamentoAcq('',0);
  RegistraMsg.IniziaMessaggio('A128');

  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
  begin
    nNumRiga:=0;
    //Inizio l'elaborazione sino a quando non raggiungo fine file...
    while not Eof(FIn) do
      InserisciPrestAgg(StrToDate(edtInizioAcquisizione.Text),StrToDate(edtFineAcquisizione.Text), chkSovrascriviEsistenti.Checked);
    //Chiudo il file temporaneo
    CloseFile(FIn);
    RefreshSelT332;
  end;
  //Cancello il file temporaneo
  DeleteFile(NFCorrente);

  Screen.Cursor:=crDefault;
  BtnVisAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if BtnVisAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,'DOMANDA') = mrYes) then
      BtnVisAnomalieClick(nil);
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,'INFORMA');
end;

procedure TA128FAcqFilePrestazioniAggiuntive.btnVisAnomalieClick(Sender: TObject);
begin
  with A128FPianPrestazioniAggiuntive do
  begin
    frmSelAnagrafe.SalvaC00SelAnagrafe;
    C700Distruzione;
    OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A128','');
    C700DatiSelezionati:=C700CampiBase + ',T030.COGNOME || '' '' || T030.NOME NOMINATIVO,TO_CHAR(T430BADGE) CHR_BADGE';
    C700Creazione(SessioneOracle);
    frmSelAnagrafe.RipristinaC00SelAnagrafe(A128FPianPrestazioniAggiuntiveDtm.A128MW);
  end;
  with A128FPianPrestazioniAggiuntiveDtm.A128MW do
  begin
    selT332.Close;
    ImpostaCampiLookup;
    RefreshSelT332;
  end;
end;

procedure TA128FAcqFilePrestazioniAggiuntive.evtAvanzamentoAcq(Matr:String;Riga:Integer);
begin
  LblMatricola.Caption:='Matricola: ' + Matr;
  LblMatricola.Repaint;
  LblRiga.Caption:='Riga: ' + inttostr(Riga);
  LblRiga.Repaint;
end;

end.
