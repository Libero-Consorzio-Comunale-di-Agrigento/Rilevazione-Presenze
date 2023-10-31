unit A173UImportAssestamento;

interface

uses ImgList, Controls, Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, Classes, Math,
  Variants, StrUtils, Forms, SysUtils, C004UParamForm, C012UVisualizzaTesto,
  A000UInterfaccia, A000UMessaggi, A000USessione, C180FunzioniGenerali,
  A083UMsgElaborazioni, A173UImportAssestamentoMW, FunzioniGenerali,
  System.IOUtils, Oracle, A000UCostanti, System.ImageList;

type
  TA173FImportAssestamento = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnEsegui: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    edtFile: TEdit;
    btnFile: TBitBtn;
    OpenDialog1: TOpenDialog;
    ProgressBar1: TProgressBar;
    BtnAnomalie: TBitBtn;
    btnVisualizzaFile: TBitBtn;
    ImageList1: TImageList;
    rgpTipoOperazione: TRadioGroup;
    rgpTipoImportazione: TRadioGroup;
    rgpIntervento: TRadioGroup;
    rgpIdDipendente: TRadioGroup;
    chkCercaCessati: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure rgpTipoImportazioneClick(Sender: TObject);
    procedure rgpIdDipendenteClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure BtnAnomalieClick(Sender: TObject);
  private
    A173MW:TA173FImportAssestamentoMW;
    const Assestamento = 0;
    const Liquidabili = 1;
    procedure RecuperaFile;
    procedure CaricamentoOre;
  public
    { Public declarations }
  end;

var
  A173FImportAssestamento: TA173FImportAssestamento;

procedure OpenA173FImportAssestamento;

implementation

{$R *.dfm}

procedure OpenA173FImportAssestamento;
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=False;
  case A000GetInibizioni('Funzione','OpenA173FImportAssestamento') of
    'N','R':begin
              ShowMessage(A000MSG_ERR_FUNZ_NON_ABILITATA);
              Exit;
            end;
  end;
  Screen.Cursor:=crHourglass;
  Application.CreateForm(TA173FImportAssestamento, A173FImportAssestamento);
  try
    Screen.Cursor:=crDefault;
    A173FImportAssestamento.ShowModal;
  finally
    SolaLettura:=SolaLetturaOriginale;
    A173FImportAssestamento.Free;
  end;
end;

procedure TA173FImportAssestamento.FormCreate(Sender: TObject);
begin
  A173MW:=TA173FImportAssestamentoMW.Create(Self);
  inherited;
end;

procedure TA173FImportAssestamento.FormShow(Sender: TObject);
begin
  // parametri utente
  CreaC004(SessioneOracle,'A173',Parametri.ProgOper);
  edtFile.Text:=C004FParamForm.GetParametro('NOMEFILE','');

  rgpTipoImportazione.ItemIndex:=Ifthen(C004FParamForm.GetParametro(rgpTipoImportazione.Name,'A') = 'A', Assestamento, Liquidabili);

  rgpIntervento.ItemIndex:=StrToInt(StringReplace(StringReplace(C004FParamForm.GetParametro('chkModificaEsistente','-1'),'S','1',[]),'N','0',[]));
  if rgpIntervento.ItemIndex = -1 then
    rgpIntervento.ItemIndex:=C004FParamForm.GetParametro(rgpIntervento.Name,'0').ToInteger;

  rgpIdDipendente.ItemIndex:=C004FParamForm.GetParametro(rgpIdDipendente.Name,'0').ToInteger;

  chkCercaCessati.Checked:=C004FParamForm.GetParametro(chkCercaCessati.Name,'N') = 'S';

  rgpTipoImportazioneClick(nil);
  rgpIdDipendenteClick(nil);

  BtnAnomalie.Enabled:=False;
end;

procedure TA173FImportAssestamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('NOMEFILE',edtFile.Text);
  C004FParamForm.PutParametro(rgpTipoImportazione.Name,IfThen(rgpTipoImportazione.ItemIndex=Assestamento,'A','L'));
  C004FParamForm.PutParametro(rgpIntervento.Name,IntToStr(rgpIntervento.ItemIndex));
  C004FParamForm.PutParametro(rgpIdDipendente.Name,IntToStr(rgpIdDipendente.ItemIndex));
  C004FParamForm.PutParametro(chkCercaCessati.Name,IfThen(chkCercaCessati.Checked,'S','N'));
  C004FParamForm.Free;
end;

procedure TA173FImportAssestamento.FormDestroy(Sender: TObject);
begin
  A173MW.Free;
end;

procedure TA173FImportAssestamento.btnFileClick(Sender: TObject);
var i:Integer;
begin
  OpenDialog1.Title:='Ricerca file';
  if edtFile.Text <> Null then
    for i:=Length(edtFile.Text) downto 1 do
    begin
      if Pos('\',Copy(edtFile.Text,i,1)) > 0 then
      begin
        OpenDialog1.InitialDir:=Copy(edtFile.Text,1,i);
        Break;
      end;
    end;
  if OpenDialog1.Execute then
    edtFile.Text:=OpenDialog1.FileName;
end;

procedure TA173FImportAssestamento.rgpTipoImportazioneClick(Sender: TObject);
begin
  rgpIdDipendente.Enabled:=rgpTipoImportazione.ItemIndex = Assestamento;
  if not rgpIdDipendente.Enabled then
    rgpIdDipendente.ItemIndex:=0;
end;

procedure TA173FImportAssestamento.rgpIdDipendenteClick(Sender: TObject);
begin
  chkCercaCessati.Visible:=rgpIdDipendente.ItemIndex = 1;
  if not chkCercaCessati.Visible then
    chkCercaCessati.Checked:=False;
end;

procedure TA173FImportAssestamento.btnVisualizzaFileClick(Sender: TObject);
begin
  OpenC012VisualizzaTesto(Self.caption,EdtFile.Text,nil,'');
end;

procedure TA173FImportAssestamento.btnEseguiClick(Sender: TObject);
var
  LTipoOperazione: String;
  LNomeFile: String;
  LResCtrl: TResCtrl;
begin
  // verifica ultima operazione
  LTipoOperazione:=IfThen(rgpTipoOperazione.ItemIndex = 0,'I','C');
  LNomeFile:=TPath.GetFileName(edtFile.Text);

  LResCtrl:=A173MW.UltimaOperazione.Verifica(LTipoOperazione,LNomeFile);
  if not LResCtrl.Ok then
  begin
    if R180MessageBox(LResCtrl.Messaggio,DOMANDA) = mrNo then
      Exit;
  end;

  RecuperaFile;
  CaricamentoOre;
end;

procedure TA173FImportAssestamento.RecuperaFile;
begin
  if Length(edtFile.Text) <= 0 then
    raise exception.Create(A000MSG_A173_ERR_NO_FILE);
  if not FileExists(edtFile.Text) then
    raise exception.Create(A000MSG_ERR_FILE_INESISTENTE);

  A173MW.ApriFile(edtFile.Text);
  A173MW.RecuperaTotaleRigheFile(IfThen(rgpTipoImportazione.ItemIndex = Assestamento, 'A', 'L'));
  A173MW.ApriFile(edtFile.Text);
end;

procedure TA173FImportAssestamento.CaricamentoOre;
var
  LTipoOperazione, LTipoImportazione: String;
begin
  ProgressBar1.Position:=0;
  ProgressBar1.Max:=A173MW.nTotRighe;
  btnAnomalie.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  RegistraMsg.IniziaMessaggio('A173');
  LTipoOperazione:=IfThen(rgpTipoOperazione.ItemIndex = 0,'I','C');
  LTipoImportazione:=IfThen(rgpTipoImportazione.ItemIndex = Assestamento,'A','L');
  try
    A173MW.nNumRiga:=0;
    while not System.Eof(A173MW.FIn) do
    begin
      ProgressBar1.StepBy(1);

      if rgpTipoImportazione.ItemIndex = Liquidabili then
        A173MW.ElaboraRigaOreLiquidate(LTipoOperazione,rgpIntervento.ItemIndex = 1)
      else if rgpTipoImportazione.ItemIndex = Assestamento then
        A173MW.ElaboraRigaOreAssestamento(LTipoOperazione,rgpIntervento.ItemIndex = 1,rgpIdDipendente.ItemIndex = 1,chkCercaCessati.Checked)
    end;

    // salva parametri ultima elaborazione effettuata
    A173MW.UltimaOperazione.SetInfo(Parametri.Operatore,Now,LTipoImportazione,LTipoOperazione,TPath.GetFileName(edtFile.Text));
    A173MW.UltimaOperazione.Salva;
  finally
    CloseFile(A173MW.FIn);
    SessioneOracle.Commit;
    Screen.Cursor:=crDefault;
    ProgressBar1.Position:=0;
  end;

  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  if btnAnomalie.Enabled then
  begin
    if (R180MessageBox(A000MSG_DLG_ELAB_ANOMALIE_VIS,DOMANDA) = mrYes) then
    begin
      // in debug imposta l'applicazione su RILPRE
      {$IFDEF DEBUG}
      if Parametri.Applicazione = '' then
        Parametri.Applicazione:='RILPRE';
      {$ENDIF DEBUG}
      btnAnomalieClick(nil);
    end;
  end
  else
    R180MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA);
end;

procedure TA173FImportAssestamento.BtnAnomalieClick(Sender: TObject);
begin
  OpenA083MsgElaborazioni(Parametri.Azienda,Parametri.Operatore,'A173','');
end;

end.
