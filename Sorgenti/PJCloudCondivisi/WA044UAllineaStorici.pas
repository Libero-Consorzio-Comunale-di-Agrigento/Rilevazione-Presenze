unit WA044UAllineaStorici;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit, IWCompLabel,
  meIWLabel, meIWImageFile, medpIWImageButton,
  A000UInterfaccia,WA044UAllineaStoriciDM,A000UMessaggi,
  medpIWC700NavigatorBar,medpIWMessageDlg, A000UCostanti;

type
  TWA044FAllineaStorici = class(TWR100FBase)
    chkAllineaMovSucc: TmeIWCheckBox;
    chkPresenze: TmeIWCheckBox;
    chkAssLiberaPresenze: TmeIWCheckBox;
    chkStipendi: TmeIWCheckBox;
    chkAssLiberaStipendi: TmeIWCheckBox;
    btnRicreazioneJob: TmeIWButton;
    lblOrarioJob: TmeIWLabel;
    edtOrarioJob: TmeIWEdit;
    btnApplicaOrario: TmeIWButton;
    lblIdJob: TmeIWLabel;
    imgEsegui: TmedpIWImageButton;
    imgAnomalie: TmedpIWImageButton;
    chkAllineaPrimoStorico: TmeIWCheckBox;
    procedure chkAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnRicreazioneJobClick(Sender: TObject);
    procedure btnApplicaOrarioClick(Sender: TObject);
    procedure imgEseguiClick(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
  private
    WA044FAllineaStoriciDM: TWA044FAllineaStoriciDM;
    procedure AbilitaComponenti;
    function VisualizzaDatiJob(Creazione: Boolean): String;
  protected
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

{ TWA044FAllineaStorici }

procedure TWA044FAllineaStorici.AbilitaComponenti;
begin
  if chkAllineaMovSucc.Checked then
  begin
    chkAllineaPrimoStorico.Checked:=False;
    chkAllineaPrimoStorico.Enabled:=False;
  end;
  if chkAllineaPrimoStorico.Checked then
  begin
    chkAllineaMovSucc.Checked:=False;
    chkAllineaMovSucc.Enabled:=False;
  end;
  if chkAllineaMovSucc.Checked or chkAllineaPrimoStorico.Checked then
  begin
    chkPresenze.Checked:=False;
    chkStipendi.Checked:=False;
    chkPresenze.Enabled:=False;
    chkStipendi.Enabled:=False;
    chkAssLiberaPresenze.Checked:=False;
    chkAssLiberaStipendi.Checked:=False;
    chkAssLiberaPresenze.Enabled:=False;
    chkAssLiberaStipendi.Enabled:=False;
  end
  else
  begin
    chkPresenze.Enabled:=True;
    chkStipendi.Enabled:=True;
  end;
  chkAssLiberaPresenze.Enabled:=chkPresenze.Checked;
  chkAssLiberaStipendi.Enabled:=chkStipendi.Checked;
  if not chkPresenze.Checked then
    chkAssLiberaPresenze.Checked:=False;
  if not chkStipendi.Checked then
    chkAssLiberaStipendi.Checked:=False;
  if (chkPresenze.Checked) or (chkStipendi.Checked) then
  begin
    chkAllineaMovSucc.Checked:=False;
    chkAllineaMovSucc.Enabled:=False;
    chkAllineaPrimoStorico.Checked:=False;
    chkAllineaPrimoStorico.Enabled:=False;
  end
  else
  begin
    chkAllineaMovSucc.Enabled:=not chkAllineaPrimoStorico.Checked;
    chkAllineaPrimoStorico.Enabled:=not chkAllineaMovSucc.Checked;
  end;
  imgEsegui.Enabled:=(chkAllineaMovSucc.Checked) or (chkAllineaPrimoStorico.Checked) or (chkPresenze.Checked) or (chkStipendi.Checked);
end;

procedure TWA044FAllineaStorici.btnApplicaOrarioClick(Sender: TObject);
var
 Mess : String;
begin
  inherited;
  if edtOrarioJob.Text <> '' then
  begin
    with WA044FAllineaStoriciDM.A044FAllineaStoriciMW do
    begin
      ImpostaOraJob(edtOrarioJob.Text);
      Mess:=VisualizzaDatiJob(False);
      MsgBox.WebMessageDlg(Mess,mtInformation,[mbOk],nil,'');
    end
  end
  else
    MsgBox.WebMessageDlg(A000MSG_A044_ERR_ORA_JOB,mtInformation,[mbOk],nil,'');
end;

procedure TWA044FAllineaStorici.btnRicreazioneJobClick(Sender: TObject);
var
  Mess:String;
begin
  with WA044FAllineaStoriciDM.A044FAllineaStoriciMW do
  begin
    RicreaJob;
    Mess:=VisualizzaDatiJob(True);
    MsgBox.WebMessageDlg(Mess,mtInformation,[mbOk],nil,'');
  end;
end;

procedure TWA044FAllineaStorici.chkAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  AbilitaComponenti;
end;


function TWA044FAllineaStorici.InizializzaAccesso: Boolean;
begin
  AbilitaComponenti;
  VisualizzaDatiJob(False);
  imgAnomalie.Enabled:=False;
  Result:=True;
end;

procedure TWA044FAllineaStorici.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  (* Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);// creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.AttivaBrowse:=False;
  *)
  AttivaGestioneC700;

  WA044FAllineaStoriciDM:=TWA044FAllineaStoriciDM.Create(Self);
end;

procedure TWA044FAllineaStorici.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(WA044FAllineaStoriciDM);
end;

function TWA044FAllineaStorici.VisualizzaDatiJob(Creazione: Boolean): String;
var
  Msg,idJob,OraJob: String;
  ProssimaEsecuzione: TDateTime;
begin
  if Creazione then
    Msg:=A000MSG_A044_MSG_CREATO
  else
    Msg:=A000MSG_A044_MSG_SCHEDULATO;

  if WA044FAllineaStoriciDM.A044FAllineaStoriciMW.getDatiJob(idJob,OraJob,ProssimaEsecuzione) then
  begin
    lblIdJob.Caption:='Id job: ' + idJob;
    lblIdJob.css:='Intestazione';
    if OraJob <> '' then
    begin
      edtOrarioJob.Text:=OraJob;
      Result:=Format(A000MSG_A044_DLG_FMT_ESEC_JOB,[Msg,FormatDateTime('dd/mm/yyyy hh.nn.ss',ProssimaEsecuzione)]);
    end
    else
    begin
      edtOrarioJob.Text:='';
      Result:=Format(A000MSG_A044_MSG_FMT_JOB,[Msg]);
    end;
  end
  else
  begin
    if Creazione then
      Result:=A000MSG_A044_ERR_JOB_NON_CREATO
    else
      Result:=A000MSG_A044_ERR_JOB_INESISTENTE;
    lblIdJob.Caption:=A000MSG_A044_ERR_JOB_INESISTENTE;
    lblIdJob.css:='font_rosso';
  end;
end;

procedure TWA044FAllineaStorici.imgAnomalieClick(Sender: TObject);
var
  params: String;
begin
  if  (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + medpCodiceForm + ParamDelimiter +
            'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
            'TIPO=A,B';

    accediForm(201,Params,True);
  end;

end;

procedure TWA044FAllineaStorici.imgEseguiClick(Sender: TObject);
begin
  inherited;
  StartElaborazioneCiclo(imgEsegui.HTMLName);
end;

//ELABORAZIONE
procedure TWA044FAllineaStorici.InizioElaborazione;
begin
  inherited;
  grdC700.selAnagrafe.First;
end;

function TWA044FAllineaStorici.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

function TWA044FAllineaStorici.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

function TWA044FAllineaStorici.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.selAnagrafe.Next;
  if not grdC700.selAnagrafe.EOF then
  begin
    Result:=True;
  end;
end;

procedure TWA044FAllineaStorici.ElaboraElemento;
var
  Msg: String;
begin
  inherited;
  if chkAllineaMovSucc.Checked then
    WA044FAllineaStoriciDM.A044FAllineaStoriciMW.AllineamentoPeriodi(grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger)
  else if chkAllineaPrimoStorico.Checked then
    WA044FAllineaStoriciDM.A044FAllineaStoriciMW.AllineamentoPrimaDecorrenza(grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger)
  else if (chkPresenze.Checked) or (chkStipendi.Checked) then
  begin
    Msg:=WA044FAllineaStoriciDM.A044FAllineaStoriciMW.OttimizzazionePeriodi(grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger,
                                                     chkPresenze.Checked,
                                                     chkAssLiberaPresenze.Checked,
                                                     chkStipendi.Checked,
                                                     chkAssLiberaStipendi.Checked);
    if Msg <> '' then
      RegistraMsg.InserisciMessaggio('A',Msg,'',grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
  end;
  SessioneOracle.Commit;
end;


procedure TWA044FAllineaStorici.FineCicloElaborazione;
begin
  inherited;
  imgAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

function TWA044FAllineaStorici.ElaborazioneTerminata: String;
begin
  if imgAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA044FAllineaStorici.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  SessioneOracle.Commit;
end;

end.
