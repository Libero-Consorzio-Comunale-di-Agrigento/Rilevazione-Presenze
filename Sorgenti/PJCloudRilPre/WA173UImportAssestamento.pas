unit WA173UImportAssestamento;

interface

uses WR100UBase, IWCompExtCtrls, meIWRadioGroup, meIWImageFile,
  medpIWImageButton, IWCompLabel, meIWLabel,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  medpIWStatusBar, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWApplication,
  Windows, SysUtils, StrUtils, C004UParamForm,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A173UImportAssestamentoMW,
  IWCompEdit, meIWEdit, IWCompCheckbox, meIWCheckBox, C180FunzioniGenerali,
  System.IOUtils, IWCompFileUploader, meIWFileUploader, Math;

type
  TWA173FImportAssestamento = class(TWR100FBase)
    lblNomeFileInput: TmeIWLabel;
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    rgpTipoOperazione: TmeIWRadioGroup;
    lblTipoOperazione: TmeIWLabel;
    fileUpload: TmeIWFileUploader;
    lblTipoImportazione: TmeIWLabel;
    rgpTipoImportazione: TmeIWRadioGroup;
    lblIntervento: TmeIWLabel;
    rgpIntervento: TmeIWRadioGroup;
    lblIdDipendente: TmeIWLabel;
    rgpIdDipendente: TmeIWRadioGroup;
    chkCercaCessati: TmeIWCheckBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure rgpTipoImportazioneClick(Sender: TObject);
    procedure rgpIdDipendenteClick(Sender: TObject);
  private
    FFileCorrente: String;
    A173MW:TA173FImportAssestamentoMW;
    const Assestamento = 0;
    const Liquidabili = 1;
    procedure RecuperaFile;
    procedure DoEsegui;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
  public
    function InizializzaAccesso: Boolean; override;
  protected
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
  end;

implementation

{$R *.dfm}

procedure TWA173FImportAssestamento.IWAppFormCreate(Sender: TObject);
begin
  A173MW:=TA173FImportAssestamentoMW.Create(Self);
  inherited;
  BtnAnomalie.Enabled:=False;
  GetParametriFunzione;
end;

procedure TWA173FImportAssestamento.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA173FImportAssestamento.PutParametriFunzione;
begin
  C004DM.Cancella001;
  C004DM.PutParametro(rgpTipoImportazione.Name,IfThen(rgpTipoImportazione.ItemIndex=Assestamento,'A','L'));
  C004DM.PutParametro(rgpIntervento.Name,IntToStr(rgpIntervento.ItemIndex));
  C004DM.PutParametro(rgpIdDipendente.Name,IntToStr(rgpIdDipendente.ItemIndex));
  C004DM.PutParametro(chkCercaCessati.Name,IfThen(chkCercaCessati.Checked,'S','N'));
  try SessioneOracle.Commit; except end;
end;

function TWA173FImportAssestamento.InizializzaAccesso: Boolean;
begin
  Result:=AccessoAbilitato and (not SolaLettura);
end;

procedure TWA173FImportAssestamento.rgpTipoImportazioneClick(Sender: TObject);
begin
  inherited;
  rgpIdDipendente.Enabled:=rgpTipoImportazione.ItemIndex = Assestamento;
  if not rgpIdDipendente.Enabled then
  begin
    rgpIdDipendente.ItemIndex:=0;
    rgpIdDipendenteClick(nil);
  end;
end;

procedure TWA173FImportAssestamento.rgpIdDipendenteClick(Sender: TObject);
begin
  inherited;
  chkCercaCessati.Visible:=rgpIdDipendente.ItemIndex = 1;
  if not chkCercaCessati.Visible then
    chkCercaCessati.Checked:=False;
end;

procedure TWA173FImportAssestamento.btnEseguiClick(Sender: TObject);
var
  LTipoOperazione: String;
  LNomeFile: String;
  LResCtrl: TResCtrl;
begin
  { DONE : TEST IW 14 OK }
  if not fileUpload.IsPresenteFileUploadato then
    raise Exception.Create(A000MSG_A173_ERR_NO_FILE);
  try
    // path e nome per il salvataggio su file system
    FFileCorrente:=GGetWebApplicationThreadVar.UserCacheDir + fileUpload.NomeFile;
    // se esiste già un file con lo stesso nome lo cancella
    if FileExists(FFileCorrente) then
      DeleteFile(FFileCorrente);
    fileUpload.SalvaSuFile(FFileCorrente);
    fileUpload.Ripristina;
  except
    raise Exception.Create(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']));
  end;

  // verifica ultima operazione
  LTipoOperazione:=IfThen(rgpTipoOperazione.ItemIndex = 0,'I','C');
  LNomeFile:=fileUpload.NomeFile;

  LResCtrl:=A173MW.UltimaOperazione.Verifica(LTipoOperazione,LNomeFile);
  if not LResCtrl.Ok then
  begin
    Messaggio('Conferma operazione',LResCtrl.Messaggio,DoEsegui,nil);
    Exit;
  end;

  // effettua elaborazione
  DoEsegui;
end;

procedure TWA173FImportAssestamento.DoEsegui;
begin
  MsgBox.ClearKeys;
  RecuperaFile;
  StartElaborazioneCiclo(btnEsegui.HTMLName);
end;

procedure TWA173FImportAssestamento.RecuperaFile;
begin
  A173MW.ApriFile(FFileCorrente);
  A173MW.RecuperaTotaleRigheFile(IfThen(rgpTipoImportazione.ItemIndex = Assestamento, 'A', 'L'));
  A173MW.ApriFile(FFileCorrente);
end;

procedure TWA173FImportAssestamento.InizioElaborazione;
begin
  inherited;
  btnAnomalie.Enabled:=False;
  A173MW.nNumRiga:=0;
end;

function TWA173FImportAssestamento.TotalRecordsElaborazione: Integer;
begin
  Result:=A173MW.nTotRighe;
end;

function TWA173FImportAssestamento.CurrentRecordElaborazione: Integer;
begin
  Result:=A173MW.nNumRiga;
end;

procedure TWA173FImportAssestamento.ElaboraElemento;
var
  LTipoOperazione: String;
begin
  try
    LTipoOperazione:=IfThen(rgpTipoOperazione.ItemIndex = 0,'I','C');
    if rgpTipoImportazione.ItemIndex = Liquidabili then
      A173MW.ElaboraRigaOreLiquidate(LTipoOperazione,rgpIntervento.ItemIndex = 1)
    else if rgpTipoImportazione.ItemIndex = Assestamento then
      A173MW.ElaboraRigaOreAssestamento(LTipoOperazione,rgpIntervento.ItemIndex = 1,rgpIdDipendente.ItemIndex = 1,chkCercaCessati.Checked);
    SessioneOracle.Commit;
  except
    System.CloseFile(A173MW.FIn);
    raise;
  end;
end;

function TWA173FImportAssestamento.ElementoSuccessivo: Boolean;
begin
  Result:=not System.Eof(A173MW.FIn);
end;

procedure TWA173FImportAssestamento.FineCicloElaborazione;
var
  LTipoImportazione, LTipoOperazione: String;
  LNomeFile: String;
begin
  // salva parametri ultima elaborazione effettuata
  LTipoImportazione:=IfThen(rgpTipoImportazione.ItemIndex = Assestamento,'A','L');
  LTipoOperazione:=IfThen(rgpTipoOperazione.ItemIndex = 0,'I','C');
  LNomeFile:=TPath.GetFileName(FFileCorrente);

  A173MW.UltimaOperazione.SetInfo(Parametri.Operatore,Now,LTipoImportazione,LTipoOperazione,LNomeFile);
  A173MW.UltimaOperazione.Salva;

  CloseFile(A173MW.FIn);
  SessioneOracle.Commit;
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

procedure TWA173FImportAssestamento.GetParametriFunzione;
begin
  rgpTipoImportazione.ItemIndex:=Ifthen(C004DM.GetParametro(rgpTipoImportazione.Name,'A') = 'A', Assestamento, Liquidabili);

  rgpIntervento.ItemIndex:=StrToInt(StringReplace(StringReplace(C004DM.GetParametro('chkModificaEsistente','-1'),'S','1',[]),'N','0',[]));
  if rgpIntervento.ItemIndex = -1 then
    rgpIntervento.ItemIndex:=C004DM.GetParametro(rgpIntervento.Name,'0').ToInteger;

  rgpIdDipendente.ItemIndex:=C004DM.GetParametro(rgpIdDipendente.Name,'0').ToInteger;

  chkCercaCessati.Checked:=C004DM.GetParametro(chkCercaCessati.Name,'N') = 'S';

  rgpTipoImportazioneClick(nil);
  rgpIdDipendenteClick(nil);
end;

function TWA173FImportAssestamento.ElaborazioneTerminata: String;
begin
  if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA173FImportAssestamento.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,False);
end;

end.
