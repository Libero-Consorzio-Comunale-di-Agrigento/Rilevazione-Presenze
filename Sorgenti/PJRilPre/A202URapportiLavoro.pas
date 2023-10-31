unit A202URapportiLavoro;

interface

uses
  A000USessione, A000UInterfaccia, A000UCostanti, A000UMessaggi, W000UMessaggi,
  C006UStoriaDati, C012UVisualizzaTesto, C180FunzioniGenerali,
  C700USelezioneAnagrafe, SelAnagrafe, R001UGESTTAB,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, StrUtils,
  System.Actions, System.ImageList, Math, Data.DB, OracleData,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.ImgList, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.Graphics,
  Vcl.DBCtrls;

type
  //Contiene i nomi dei campi e l'indicazione se devono essere colorati
  TElencoStorici = record
    NomeCampo:String;
    Colore:boolean;
  end;

  TA202FRapportiLavoro = class(TR001FGestTab)
    frmSelAnagrafe: TfrmSelAnagrafe;
    pnlBottoni: TPanel;
    btnApplica: TButton;
    mnuCopia: TPopupMenu;
    CopiaInExcel: TMenuItem;
    cmbPAssenze: TDBLookupComboBox;
    lblPAssenze: TLabel;
    lblDescrizione: TLabel;
    edtDecorrenza: TMaskEdit;
    edtFine: TMaskEdit;
    lblDecorrenza: TLabel;
    lblFine: TLabel;
    lblScadenza: TLabel;
    edtScadenza: TMaskEdit;
    lblGG: TLabel;
    edtGG: TEdit;
    grpAltriEnti: TGroupBox;
    dgrdRapportiLavoro: TDBGrid;
    grpEnteCorrente: TGroupBox;
    dgrdRapportiEnte: TDBGrid;
    grpPAssenze: TGroupBox;
    grdPAssenze: TStringGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    pgValidazione: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    gbT425: TGroupBox;
    gbT430: TGroupBox;
    dgrdT425: TDBGrid;
    dgrdT430: TDBGrid;
    gbT055: TGroupBox;
    dgrdT040: TDBGrid;
    GroupBox1: TGroupBox;
    Splitter3: TSplitter;
    grdRiepilogo: TStringGrid;
    edtDataIReport: TEdit;
    edtDataFReport: TEdit;
    TabSheet0: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    dgrdT425_T050_NA: TDBGrid;
    GroupBox3: TGroupBox;
    dgrdT055: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dgrdRapportiLavoroEditButtonClick(Sender: TObject);
    procedure CopiaInExcelClick(Sender: TObject);
    procedure cmbPAssenzeExit(Sender: TObject);
    procedure cmbPAssenzeCloseUp(Sender: TObject);
    procedure DButtonStateChange(Sender: TObject);
    procedure btnApplicaClick(Sender: TObject);
    procedure frmSelAnagrafebtnSuccessivoClick(Sender: TObject);
    procedure DButtonDataChange(Sender: TObject; Field: TField);
    procedure GetRiepilogoPeriodi;
    procedure pgValidazioneChanging(Sender: TObject; var AllowChange: Boolean);
    procedure pgValidazioneChange(Sender: TObject);
    procedure grdPAssenzeDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Stampa1Click(Sender: TObject);
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
  private
    { Private declarations }
    ElencoStorici: array of TElencoStorici;
    procedure CambiaProgressivo;
    procedure ColonnaNote;
    procedure CreaPickListGrid(pGrid: TDBgrid);
    procedure CreaSGrdStoricoAssenze;
    procedure InibisciCampi;
    procedure ValorizzaCampiStoricizzazione;
  public
    { Public declarations }
  end;

var
  A202FRapportiLavoro: TA202FRapportiLavoro;

procedure OpenA202RapportiLavoro(Prog:Integer);
procedure OpenA202ValidazioneDatiGiuridici(Prog:Integer);

implementation

uses
  A202URapportiLavoroDM, A202URapportiLavoroMW, A202UStampa, QuickRpt, QRCtrls, QRPDFFilt;

{$R *.dfm}

procedure OpenA202RapportiLavoro(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA202RapportiLavoro') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  if (not SolaLettura) and (Parametri.Applicazione = 'PAGHE')  then
    SolaLettura:=True;
  C700Progressivo:=Prog;
  A202FRapportiLavoroDM:=TA202FRapportiLavoroDM.Create(nil);
  A202FRapportiLavoroDM.ImpostaModalita(PASSENZE);
  A202FRapportiLavoro:=TA202FRapportiLavoro.Create(nil);
  A202FRapportiLavoro.Caption:='<A202> Riepilogo rapporti di lavoro';
  A202FRapportiLavoro.Tag:=161;
  A202FRapportiLavoro.HelpContext:=202000;
  try
    A202FRapportiLavoro.ShowModal;
  finally
    FreeAndNil(A202FRapportiLavoro);
    FreeAndNil(A202FRapportiLavoroDM);
  end;
end;

procedure OpenA202ValidazioneDatiGiuridici(Prog:Integer);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA202RapportiLavoro') of
    'N':begin
        ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
        SolaLettura:=SolaLetturaOriginale;
        Exit;
        end;
    'R':SolaLettura:=True;
  end;
  if (not SolaLettura) and (Parametri.Applicazione = 'PAGHE')  then
    SolaLettura:=True;
  C700Progressivo:=Prog;
  A202FRapportiLavoroDM:=TA202FRapportiLavoroDM.Create(nil);
  A202FRapportiLavoroDM.ImpostaModalita(VALIDAZIONE);
  A202FRapportiLavoro:=TA202FRapportiLavoro.Create(nil);
  A202FRapportiLavoro.Caption:='<A202> Validazione autocertificazione dati giuridici';
  A202FRapportiLavoro.Tag:=182;
  A202FRapportiLavoro.HelpContext:=202100;
  try
    A202FRapportiLavoro.ShowModal;
  finally
    FreeAndNil(A202FRapportiLavoro);
    FreeAndNil(A202FRapportiLavoroDM);
  end;
end;

procedure TA202FRapportiLavoro.FormShow(Sender: TObject);
var i: integer;
begin
  inherited;

  case A202FRapportiLavoroDM.A202MW.ModalitaA202 of
   PASSENZE: begin
    pgValidazione.Pages[0].TabVisible:=True;
    pgValidazione.Pages[1].TabVisible:=False;
    pgValidazione.Pages[2].TabVisible:=False;
    pgValidazione.Pages[3].TabVisible:=False;
    grdPAssenze.Cells[0,0] :='';
    HelpContext:=202000;
    A202FRapportiLavoroDM.A202MW.ValorizzaCampiStoricizzazione:=ValorizzaCampiStoricizzazione;
   end;

   VALIDAZIONE: begin
    pgValidazione.Pages[0].TabVisible:=False;
    pgValidazione.Pages[1].TabVisible:=True;
    pgValidazione.Pages[2].TabVisible:=True;
    pgValidazione.Pages[3].TabVisible:=True;
    HelpContext:=202100;
    pgValidazione.TabIndex:=0;
    pgValidazione.Align:=alClient;
    pgValidazione.Visible:=True;
    dgrdT430.DataSource:=A202FRapportiLavoroDM.A202MW.dsrT430;
    //dgrdT055.DataSource:=A202FRapportiLavoroDM.A202MW.dsrT055;
    dgrdT425_T050_NA.DataSource:=A202FRapportiLavoroDM.A202MW.drsT425_T050_NA;

    grdRiepilogo.ColWidths[0]:=200;
    for i:=1 to grdRiepilogo.ColCount-1 do
      grdRiepilogo.ColWidths[i]:=150;

    grdRiepilogo.Cells[0,1]:='Servizi prestati totale';
    grdRiepilogo.Cells[0,2]:='Servizi prestati a tempo indeterminato';
    grdRiepilogo.Cells[0,3]:='Servizi prestati rapportati al part time';
    grdRiepilogo.Cells[1,0]:='Complessivo (giorni)';
    grdRiepilogo.Cells[2,0]:='Complessivo (anni)';
    grdRiepilogo.Cells[3,0]:='Da approvare (giorni)';
    grdRiepilogo.Cells[4,0]:='Da approvare(anni)';
    grdRiepilogo.Cells[5,0]:='Anzianità 5 anni';
    grdRiepilogo.Cells[6,0]:='Anzianità 15 anni';


    //Rendo modificabili solo i campi VALIDAZIONE di selT425 e selT055
    for i:=0 to A202FRapportiLavoroDM.A202MW.selT425.FieldCount-1 do
      A202FRapportiLavoroDM.A202MW.selT425.Fields[i].ReadOnly:=True;
    A202FRapportiLavoroDM.A202MW.selT425.FieldByName('VALIDAZIONE').ReadOnly:=False;

    for i:=0 to A202FRapportiLavoroDM.A202MW.selT055.FieldCount-1 do
      A202FRapportiLavoroDM.A202MW.selT055.Fields[i].ReadOnly:=True;
    A202FRapportiLavoroDM.A202MW.selT055.FieldByName('VALIDAZIONE').ReadOnly:=False;
   end;
  end;

  DButton.DataSet:=A202FRapportiLavoroDM.A202MW.selT425;

  C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  C700DatiSelezionati:=C700CampiBase;
  C700DataLavoro:=Parametri.DataLavoro;
  ColonnaNote;
  frmSelAnagrafe.OnCambiaProgressivo:=CambiaProgressivo;
  frmSelAnagrafe.CreaSelAnagrafe(SessioneOracle, StatusBar,2,True);
  frmSelAnagrafe.NumRecords;

  case A202FRapportiLavoroDM.A202MW.ModalitaA202 of
   VALIDAZIONE: begin
     actInserisci.Visible:=False;
     actCancella.Visible:=False;
   end;

   PASSENZE: begin
    dgrdRapportiEnte.DataSource:=A202FRapportiLavoroDM.A202MW.dsrT430;
    CreaSGrdStoricoAssenze;
    cmbPAssenze.ListSource := A202FRapportiLavoroDM.A202MW.dsrT261;

    if SolaLettura then
    begin
      lblDecorrenza.Visible:=False;
      lblFine.Visible:=False;
      edtDecorrenza.Visible:=False;
      edtFine.Visible:=False;
      lblPAssenze.Visible:=False;
      cmbPAssenze.Visible:=False;
      lblDescrizione.Visible:=False;
      btnApplica.Visible:=False;
    end;
   end;
  end;
end;

procedure TA202FRapportiLavoro.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnSelezioneClick(Sender);

end;

procedure TA202FRapportiLavoro.frmSelAnagrafebtnSuccessivoClick(Sender: TObject);
begin
  inherited;
  frmSelAnagrafe.btnBrowseClick(Sender);

end;

procedure TA202FRapportiLavoro.CreaSGrdStoricoAssenze;
{Scrivo le intestazioni della colonna}
begin
  grdPAssenze.Cells[0,0]:='Decorrenza';
  grdPAssenze.Cells[1,0]:='Termine';
  grdPAssenze.Cells[2,0]:='Valore';
  grdPAssenze.Cells[3,0]:='Descrizione';
  grdPAssenze.ColWidths[0]:=70;
  grdPAssenze.ColWidths[1]:=70;
  grdPAssenze.ColWidths[2]:=110;
  grdPAssenze.ColWidths[3]:=350;
end;

procedure TA202FRapportiLavoro.CambiaProgressivo;
begin
  A202FRapportiLavoroDM.A202MW.CambiaProgressivo(C700Progressivo);

  case A202FRapportiLavoroDM.A202MW.ModalitaA202 of
    VALIDAZIONE:begin
      GetRiepilogoPeriodi;
      if pgValidazione.TabIndex=0 then
        CreaPickListGrid(dgrdT425)
      else
        CreaPickListGrid(dgrdT055);
    end;
    PASSENZE:begin
      ColonnaNote;
    end;
  end;

  NumRecords;
end;

procedure TA202FRapportiLavoro.CreaPickListGrid(pGrid: TDBgrid);
begin
  pGrid.Columns[0].PickList.Add('S');
  pGrid.Columns[0].PickList.Add('N');
end;


procedure TA202FRapportiLavoro.GetRiepilogoPeriodi;
var
  i: Integer;
begin
  with A202FRapportiLavoroDM.A202MW do
  begin
    selRiepilogo.Close;
    R180SetVariable(selRiepilogo,'PROGRESSIVO',C700Progressivo);
    selRiepilogo.Open;
    selRiepilogo.First;
  end;

  with grdRiepilogo do
  begin
    //Servizi prestati totale (approvati+non approvati) [gg];
    Cells[1,1]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_ALL').AsString;
    //Servizi prestati totale (approvati+non approvati) [anni];
    Cells[2,1]:=FloatToStrF(A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_ALL').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati a tempo indeterminato (approvati+non approvati) [gg];
    Cells[1,2]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_TI').AsString;
    //Servizi prestati a tempo indeterminato (approvati+non approvati) [anni];
    Cells[2,2]:=FloatToStrF(A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_TI').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati totale (non approvati) [gg];
    Cells[3,1]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_ALL_NA').AsString;
    //Servizi prestati totale (non approvati) [anni];
    Cells[4,1]:=FloatToStrF(A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_ALL_NA').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati a tempo indeterminato (non approvati) [gg];
    Cells[3,2]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_TI_NA').AsString;
    //Servizi prestati a tempo indeterminato (non approvati) [anni];
    Cells[4,2]:=FloatToStrF(A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_TI_NA').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati rapportati al part time totale FTE (approvati+non approvati) [gg];
    Cells[1,3]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_FTE_ALL').AsString;
    //Servizi prestati rapportati al part time totale FTE (approvati+non approvati) [anni];
    Cells[2,3]:=FloatToStrF(A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_FTE_ALL').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati rapportati al part time FTE (non approvati) [gg];
    Cells[3,3]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_FTE_NA').AsString;
    //Servizi prestati rapportati al part time FTE (non approvati) [anni];
    Cells[4,3]:=FloatToStrF(A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('G_FTE_NA').AsInteger / 365, ffNumber, 50, 2);

    Cells[5,1]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('DT_ANZ_5').AsString;
    Cells[6,1]:=A202FRapportiLavoroDM.A202MW.selRiepilogo.FieldByName('DT_ANZ_15').AsString;
    Cells[5,2]:='-';
    Cells[6,2]:='-';
    Cells[5,3]:='-';
    Cells[6,3]:='-';
    //ColWidths[0]:=150;
    for i:=1 to ColCount-1 do
      ColWidths[i]:=110;
  end;
end;


procedure TA202FRapportiLavoro.grdPAssenzeDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  if (ARow <> 0) then Exit;
  with TStringGrid(Sender).Canvas do
  begin
    Font.Color := clBlue;
    //Font.Style := [fsBold];
    TextRect(Rect, Rect.Left + 2, Rect.Top + 2,
      TStringGrid(Sender).Cells[aCol, aRow]);
  end;
end;

procedure TA202FRapportiLavoro.DButtonDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = nil then
    DButtonStateChange(Sender);
end;

procedure TA202FRapportiLavoro.DButtonStateChange(Sender: TObject);
begin
  inherited;
  InibisciCampi;
  if (A202FRapportiLavoroDM.A202MW.Progressivo > 0) and
     (DButton.State = dsBrowse) then
  begin
    // Determino dati utili alla determinazione del periodo storico
    A202FRapportiLavoroDM.A202MW.LeggiDatiStorici;
    //Aggiorna conteggio dei gg di servizio
    //...
    GetRiepilogoPeriodi;
  end;
end;

procedure TA202FRapportiLavoro.btnApplicaClick(Sender: TObject);
var Dal,Al:TDateTime;
begin
  inherited;
  if cmbPAssenze.Text.IsEmpty then
    raise Exception.Create('Selezionato il Profilo Assenze da storicizzare!');

  if not TryStrToDate(edtDecorrenza.Text,Dal) then
    raise Exception.Create('Decorrenza errata!');
  if not TryStrToDate(edtFine.Text,Al) then
    raise Exception.Create('Scadenza errata!');

  if Dal > Al then
    raise Exception.Create('Periodo errato!');

  if MessageDlg('Eseguire la storicizzazione del Profilo Assenze?',mtConfirmation,[mbYes,mbNo],0,mbYes) = mrNo then
    exit;

  try
    A202FRapportiLavoroDM.A202MW.EseguiStoricizzazione(Dal,Al,cmbPAssenze.Text);
    A202FRapportiLavoroDM.A202MW.LeggiDatiStorici;
    ShowMessage('Storicizzazione eseguita');
  except
    on E:Exception do
      raise Exception.Create('Storicizzazione fallita:' + CRLF + E.Message);
  end;
end;

procedure TA202FRapportiLavoro.ColonnaNote;
var indNote:integer;
begin
  indNote:=R180GetColonnaDBGrid(dgrdRapportiLavoro,'NOTE');
  if indNote >= 0 then
  begin
    dgrdRapportiLavoro.Columns[indNote].ButtonStyle:=cbsEllipsis;
  end;
end;

procedure TA202FRapportiLavoro.InibisciCampi;
{Inibisce campi per storicizzazione}
begin
  cmbPAssenze.Enabled:=False;
  cmbPAssenze.KeyValue:='';
  lblDescrizione.Caption:='';
  edtDecorrenza.Enabled:=False;
  edtFine.Enabled:=False;
  edtScadenza.Text:='';
  edtGG.Text:='';
  edtDecorrenza.Text:='';
  edtFine.Text:='';
  btnApplica.Enabled:=False;
end;

procedure TA202FRapportiLavoro.pgValidazioneChange(Sender: TObject);
begin
  if A202FRapportiLavoroDM.A202MW.ModalitaA202 = VALIDAZIONE then
  begin
    if pgValidazione.TabIndex=0 then
    begin
      DButton.DataSet:=A202FRapportiLavoroDM.A202MW.selT425;
      CreaPickListGrid(dgrdT425);
    end
    else if pgValidazione.TabIndex=1 then
    begin
      DButton.DataSet:=A202FRapportiLavoroDM.A202MW.selT055;
      CreaPickListGrid(dgrdT055);
    end
    else if pgValidazione.TabIndex=2 then
      A202FRapportiLavoroDM.A202MW.selT425_T050_NA.Refresh;
  end;
end;

procedure TA202FRapportiLavoro.pgValidazioneChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange:=not (DButton.State in [dsInsert, dsEdit]);
end;

procedure TA202FRapportiLavoro.Stampa1Click(Sender: TObject);
var i : integer;
    gap: integer;
    qLbl: TQRLabel;
    yo: integer;
    qBnd: TQRChildBand;
begin
  A202FStampa:=TA202FStampa.Create(nil);

  if A202FRapportiLavoroDM.A202MW.TipoModulo='COM' then
  begin
     C700SelAnagrafe.Open;
     CambiaProgressivo;
     GetRiepilogoPeriodi;
  end
  else
  begin
     A202FRapportiLavoroDM.A202MW.DataIReport:=StrToDate(edtDataIReport.Text);
     A202FRapportiLavoroDM.A202MW.DataFReport:=StrToDate(edtDataFReport.Text);
  end;

  try
    with A202FStampa do
    begin
      //Report predisposto per la stampa limitata ad un periodo DAL-AL impostato dall'utente
      Dal:=A202FRapportiLavoroDM.A202MW.DataIReport;
      Al:=A202FRapportiLavoroDM.A202MW.DataFReport;

      QRep.DataSet:=A202FRapportiLavoroDM.selT425;
      LEnte.Caption:=C700RagioneSociale();

      //Intestazione
      qlblNome.Caption:=qlblNome.Caption + C700SelAnagrafe.FieldByName('NOME').AsString;
      qlblCognome.Caption:=qlblCognome.Caption + C700SelAnagrafe.FieldByName('COGNOME').AsString;
      qlblMatricola.Caption:=qlblMatricola.Caption + C700SelAnagrafe.FieldByName('MATRICOLA').AsString;

      //Riepilogo
      qlblSPT_GG.Caption:=grdRiepilogo.Cells[1,1];
      qlblSPT_AA.Caption:=grdRiepilogo.Cells[2,1];
      qlblSPT_GG_NA.Caption:=grdRiepilogo.Cells[3,1];
      qlblSPT_AA_NA.Caption:=grdRiepilogo.Cells[4,1];
      qlblSPTI_GG.Caption:=grdRiepilogo.Cells[1,2];
      qlblSPTI_AA.Caption:=grdRiepilogo.Cells[2,2];
      qlblSPTI_GG_NA.Caption:=grdRiepilogo.Cells[3,2];
      qlblSPTI_AA_NA.Caption:=grdRiepilogo.Cells[4,2];
      qlblSFTE_GG.Caption:=grdRiepilogo.Cells[1,3];
      qlblSFTE_AA.Caption:=grdRiepilogo.Cells[2,3];
      qlblSFTE_GG_NA.Caption:=grdRiepilogo.Cells[3,3];
      qlblSFTE_AA_NA.Caption:=grdRiepilogo.Cells[4,3];

      //T425
      gap:=qlblTipoRapporto.Top - qlblEnte.Top;
      for i:=0 to A202FStampa.ComponentCount-1 do
      begin
        if (Components[i].GetParentComponent = qrT425) and (Components[i] is TQRDBText)then
          if TQRDBText(Components[i]).DataField <> '' then
            TQRDBText(Components[i]).DataSet:=A202FRapportiLavoroDM.selT425;
      end;

      if Parametri.CampiRiferimento.C22_QualificaGiuridico = '' then
      begin
        qlblQualifica.Enabled:=False;
        qlblD_Qualifica.Enabled:=False;
        qlblDisciplina.Top:=qlblDisciplina.Top-Gap;
        qlblD_Disciplina.Top:=qlblD_Disciplina.Top-Gap;
        qlblNoteT.Top:=qlblNoteT.Top-Gap;
        qlblNote.Top:=qlblNote.Top-Gap;
        qrT425.Height:=qrT425.Height-Gap;
      end;

      if Parametri.CampiRiferimento.C22_DisciplinaGiuridico = '' then
      begin
        qlblDisciplina.Destroy;
        qlblD_Disciplina.Destroy;
        qlblNoteT.Top:=qlblNoteT.Top-Gap;
        qlblNote.Top:=qlblNote.Top-Gap;
        qrT425.Height:=qrT425.Height-Gap;
      end;

      //T055
      qrT055_Titolo.HasChild:=False;
      yo:=qlblDal.Top;
      A202FRapportiLavoroDM.A202MW.selT055.First;
      while not A202FRapportiLavoroDM.A202MW.selT055.Eof do
      begin
        if Math.Max(A202FRapportiLavoroDM.A202MW.selT055.FieldByName('DAL').AsDateTime, Dal)
          <= Math.Min(A202FRapportiLavoroDM.A202MW.selT055.FieldByName('AL').AsDateTime, Al) then
        begin
          if not qrT055_Titolo.HasChild then
          begin  //Prima banda
            qrT055_Titolo.HasChild:=True;
            qBnd:=qrT055_Titolo.ChildBand;
          end
          else
          begin  //Bande successive
            qBnd.HasChild:=True;
            qBnd:=qBnd.ChildBand;
          end;

          //Periodo dal:
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=qlblDal.Caption;
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblDal.Left;
          qLbl.Top:=yo;

          //Periodo dal: [valore]
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=A202FRapportiLavoroDM.A202MW.selT055.FieldByName('DAL').AsString;
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblInizio.Left;
          qLbl.Top:=yo;

          //al:
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=qlblAl.Caption;
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblAl.Left;
          qLbl.Top:=yo;

          //al: [valore]
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=A202FRapportiLavoroDM.A202MW.selT055.FieldByName('AL').AsString;
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblFine.Left;
          qLbl.Top:=yo;

          //Validato
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=qlblValidato.Caption;
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblValidato.Left;
          qLbl.Top:=yo;

          //Validato [valore]
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=IfThen(A202FRapportiLavoroDM.A202MW.selT055.FieldByName('VALIDAZIONE').AsString = 'S', 'Sì', 'No');
          qLbl.Parent:=qBnd;
          qLbl.Left:=qExprValidato.Left;
          qLbl.Font:=qExprValidato.Font;
          qLbl.Top:=yo;

          //Causale:
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:='Causale:';
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblDal.Left;
          qLbl.Top:=yo + Gap;

          //Causale: [valore]
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=A202FRapportiLavoroDM.A202MW.selT055.FieldByName('d_CAUSALE').AsString;
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblInizio.Left;
          qLbl.Top:=yo + Gap;

          //Note:
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:='Note:';
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblDal.Left;
          qLbl.Top:=yo + 2 * Gap;

          //Note: [valore]
          qLbl:=TQRLabel.Create(qBnd);
          qLbl.Caption:=A202FRapportiLavoroDM.A202MW.selT055.FieldByName('NOTE').AsString;
          qLbl.Parent:=qBnd;
          qLbl.Left:=qlblNote.Left;
          qLbl.Top:=yo + 2 * Gap + (qlblNote.Top-qlblNoteT.Top);

          qBnd.Height:=qLbl.Top +  qrT425.Height - qlblNote.Top;

          qBnd.Frame.DrawTop:=qrT425.Frame.DrawTop;
          qBnd.Frame.DrawBottom:=qrT425.Frame.DrawBottom;
          qBnd.Frame.Color:=qrT425.Frame.Color;
          qBnd.Frame.Style:=qrT425.Frame.Style;
          qBnd.Frame.Width:=qrT425.Frame.Width;
        end;
        A202FRapportiLavoroDM.A202MW.selT055.Next;
      end;

      if not qrT055_Titolo.HasChild then
      begin
        qrT055_Titolo.Enabled:=False;
        qrT055_Titolo.Enabled:=False;
      end;

      A202FStampa.QRep.PrinterSettings.UseStandardPrinter:=(A202FRapportiLavoroDM.A202MW.TipoModulo = 'COM') and Parametri.UseStandardPrinter;

      if (Trim(A202FRapportiLavoroDM.A202MW.DocumentoPDF) <> '') and
         (Trim(A202FRapportiLavoroDM.A202MW.DocumentoPDF) <> '<VUOTO>') and
         (Trim(A202FRapportiLavoroDM.A202MW.TipoModulo) = 'COM')then
      begin
        QRep.ShowProgress:=False;
        QRep.ExportToFilter(TQRPDFDocumentFilter.Create(A202FRapportiLavoroDM.A202MW.DocumentoPDF));
      end
      else
        QRep.Preview;

    end;
  finally
    FreeAndNil(A202FStampa);

  end;
end;

procedure TA202FRapportiLavoro.cmbPAssenzeCloseUp(Sender: TObject);
begin
  inherited;
  lblDescrizione.Caption:=A202FRapportiLavoroDM.A202MW.selT261.FieldByName('DESCRIZIONE').AsString;
end;

procedure TA202FRapportiLavoro.cmbPAssenzeExit(Sender: TObject);
begin
  inherited;
  lblDescrizione.Caption:=A202FRapportiLavoroDM.A202MW.selT261.FieldByName('DESCRIZIONE').AsString;
end;

procedure TA202FRapportiLavoro.ValorizzaCampiStoricizzazione;
{Valorizza campi per storicizzazione}
var StoricizzazioneAbilitata:Boolean;
  Codice, Descrizione, DataFine, sOldTipoDato: string;
  j: Integer;
begin
  // carico StringListGrid
  grdPAssenze.RowCount:=max(2,A202FRapportiLavoroDM.A202MW.cdsProfili.RecordCount + 1);
  with A202FRapportiLavoroDM.A202MW.cdsProfili do
  begin
    First;
    j:=0;
    while not Eof do
    try
      grdPAssenze.Cells[0,j + 1]:=FieldByName('DECORRENZA').AsString;
      //Se la data fine = 31/12/3999 scrivo 'Corrente'
      grdPAssenze.Cells[1,j + 1]:=FieldByName('TERMINE').AsString;
      grdPAssenze.Cells[2,j + 1]:=FieldByName('VALORE').AsString;
      grdPAssenze.Cells[3,j + 1]:=FieldByName('DESCRIZIONE').AsString;
      inc(j);
    finally
      Next;
    end;
  end;

  InibisciCampi;
  with A202FRapportiLavoroDM.A202MW.cdsProfili do
  begin
    Filtered:=False;
    Filter:='Valorizza=True';
    Filtered:=True;
    if RecordCount = 1 then
    begin
      Codice:=FieldByName('Valore').AsString;
      Descrizione:=FieldByName('Descrizione').AsString;
      DataFine:=FieldByName('Termine').AsString;
    end
    else
    begin
      Codice:='';
      Descrizione:='';
      DataFine:='';
    end;
    Filtered:=False;
  end;

  cmbPAssenze.Enabled:=not SolaLettura;
  with A202FRapportiLavoroDM.A202MW.selT261 do
  begin
    R180SetVariable(A202FRapportiLavoroDM.A202MW.selT261,'CODICE',Codice);
    Open;
    First;
    Codice:=FieldByName('CODICE').AsString;
    Descrizione:=FieldByName('DESCRIZIONE').AsString;
  end;
  cmbPAssenze.KeyValue:=Codice;
  lblDescrizione.Caption:=Descrizione;
  edtScadenza.Text:=FormatDateTime('dd/mm/yyyy',A202FRapportiLavoroDM.A202MW.DataScadenza);
  edtGG.Text:=A202FRapportiLavoroDM.A202MW.GGServizio.ToString;
  edtDecorrenza.Text:=FormatDateTime('dd/mm/yyyy',Max(A202FRapportiLavoroDM.A202MW.DataDecorrenzaUtile, A202FRapportiLavoroDM.A202MW.DataInizioUtile));
  edtFine.Text:=IfThen(DataFine = A202_Corrente,DateToStr(DATE_MAX),DataFine);
  StoricizzazioneAbilitata:=(not SolaLettura);// and (A202FRapportiLavoroDM.A202MW.DataDecorrenzaUtile >= A202FRapportiLavoroDM.A202MW.DataInizioUtile) and (not A202FRapportiLavoroDM.A202MW.DataInizioUtile.IsNull);
  edtDecorrenza.Enabled:=StoricizzazioneAbilitata;
  edtFine.Enabled:=StoricizzazioneAbilitata;
  btnApplica.Enabled:=StoricizzazioneAbilitata;
end;

procedure TA202FRapportiLavoro.CopiaInExcelClick(Sender: TObject);
begin
  if MnuCopia.PopupComponent = dgrdRapportiLavoro then
    R180DBGridCopyToClipboard(dgrdRapportiLavoro,True, False)
  else if MnuCopia.PopupComponent = dgrdRapportiEnte then
    R180DBGridCopyToClipboard(dgrdRapportiEnte,True, False);
end;

procedure TA202FRapportiLavoro.dgrdRapportiLavoroEditButtonClick(Sender: TObject);
var Str: TStringList;
begin
  inherited;
  Str:=TStringList.Create;
  Str.Text:=dgrdRapportiLavoro.DataSource.DataSet.FieldByName('NOTE').AsString;
  try
    if DButton.State in [dsEdit,dsInsert] then
    begin
      OpenC012VisualizzaTesto('Note','',Str,'',[mbOK,mbCancel]);
      A202FRapportiLavoroDM.A202MW.selT425.FieldByName('NOTE').AsString:=Trim(Str.Text);
    end
    else
      OpenC012VisualizzaTesto('Note','',Str,'',[mbClose]);
  finally
    FreeAndNil(Str);
  end;
end;

procedure TA202FRapportiLavoro.FormDestroy(Sender: TObject);
begin
  frmSelAnagrafe.DistruggiSelAnagrafe;
  inherited;
end;

end.
