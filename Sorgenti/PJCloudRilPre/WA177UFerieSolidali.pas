unit WA177UFerieSolidali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton,
  meIWRadioGroup, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, IWCompCheckbox, meIWCheckBox,
  A000UMessaggi, A000UInterfaccia, A000UCostanti, medpIWMessageDlg, C180FunzioniGenerali;

type
  TWA177FFerieSolidali = class(TWR102FGestTabella)
    WA177AreaIntestazioneRG: TmeIWRegion;
    TemplateAreaIntestazioneRG: TIWTemplateProcessorHTML;
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    chkAggiornaQuantita: TmeIWCheckBox;
    chkAggiornaProfili: TmeIWCheckBox;
    chkAzzeraQuantita: TmeIWCheckBox;
    chkImpostaTermine: TmeIWCheckBox;
    edtTermine: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure chkAggiornaQuantitaClick(Sender: TObject);
    procedure chkAzzeraQuantitaChange(Sender: TObject);
    procedure chkAggiornaProfiliChange(Sender: TObject);
    procedure chkImpostaTermineChange(Sender: TObject);
  private
    procedure Esecuzione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  protected
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
  end;

implementation

{$R *.dfm}

uses WA177UFerieSolidaliBrowseFM, WA177UFerieSolidaliDettFM, WA177UFerieSolidaliDM;

{ TWA177FFerieSolidali }

procedure TWA177FFerieSolidali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.ChiaveReadOnly:=True;
  WR302DM:=TWA177FFerieSolidaliDM.Create(Self);
  WDettaglioFM:=TWA177FFerieSolidaliDettFM.Create(Self);
  WBrowseFM:=TWA177FFerieSolidaliBrowseFM.Create(Self);

  CreaTabDefault;
  AttivaGestioneC700;
  (WR302DM as TWA177FFerieSolidaliDM).A177MW.SelAnagrafe:=grdC700.selAnagrafe;
end;

procedure TWA177FFerieSolidali.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';
  AccediForm(201,Params,True);
end;

procedure TWA177FFerieSolidali.btnEseguiClick(Sender: TObject);
begin
  inherited;
  btnAnomalie.Enabled:=False;
  with (WR302DM as TWA177FFerieSolidaliDM).A177MW do
  begin
    ParametriElaborazione.bAggiornaQuantita:=chkAggiornaQuantita.Checked;
    ParametriElaborazione.bAggiornaProfili:=chkAggiornaProfili.Checked;
    ParametriElaborazione.bAzzeraQuantita:=chkAzzeraQuantita.Checked;
    ParametriElaborazione.bImpostaTermine:=chkImpostaTermine.Checked;
    ParametriElaborazione.sDataTermine:=edtTermine.Text;

    if chkAggiornaQuantita.Checked then
    begin
      //Prima di chiudere è necessario specificare la scadenza!
      if selT254.FieldByName('DECORRENZA_FINE').IsNull then
      begin
        selT254.FieldByName('DECORRENZA_FINE').FocusControl;
        raise Exception.Create(A000MSG_A177_ERR_SCADENZA_NULLA);
      end;
    end
    else if chkAzzeraQuantita.Checked then
    begin
      //Attenzione: riportando lo stato richiesta ad Aperta, verranno azzerate tutte le quantità ottenute e accettate. Continuare comunque?
      MsgBox.WebMessageDlg(A000MSG_A177_DLG_STATO_APERTA,mtConfirmation,[mbYes,mbNo],Esecuzione,'');
      Abort;
    end
    else if chkImpostaTermine.Checked then
    begin
      ControllaTermineDiritto;
      if ((selT254.FieldByName('UMISURA').AsString = 'G') and (ResiduoRichiesta <= 0)) or
         ((selT254.FieldByName('UMISURA').AsString = 'O') and (ResiduoRichiestaHH <= 0)) then
      begin
        //Attenzione: la quantità ottenuta di ferie solidali è stata interamente fruita, l''impostazione della data termine diritto non avrà alcun effetto sulle quantità restituite. Continuare comunque?
        MsgBox.WebMessageDlg(A000MSG_A177_DLG_QUANTITA_TERMINE,mtConfirmation,[mbYes,mbNo],Esecuzione,'');
        Abort;
      end;
      if ((selT254.FieldByName('UMISURA').AsString = 'G') and (ResiduoRichiesta > StrToFloat(selT254.FieldByName('QUANTITA_OTTENUTA').AsString))) or
         ((selT254.FieldByName('UMISURA').AsString = 'O') and (ResiduoRichiestaHH > R180OreMinutiExt(selT254.FieldByName('QUANTITA_OTTENUTA').AsString))) then
      begin
        //Attenzione: la quantità residua di ferie solidali %s è maggiore della quantità ottenuta, verrà restituita la sola quantità ottenuta. Continuare comunque?';
        MsgBox.WebMessageDlg(A000MSG_A177_DLG_QUANTITA_RESTITUITA,mtConfirmation,[mbYes,mbNo],Esecuzione,'');
        Abort;
      end;
    end;
  end;
  StartElaborazioneServer(btnEsegui.HTMLName);
end;

procedure TWA177FFerieSolidali.chkAggiornaProfiliChange(Sender: TObject);
begin
  inherited;
  //Richiesta Chiusa
  chkAzzeraQuantita.Enabled:=not chkAggiornaProfili.Checked;
  if not chkAzzeraQuantita.Enabled then
    chkAzzeraQuantita.Checked:=False;
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TWA177FFerieSolidali.chkAggiornaQuantitaClick(Sender: TObject);
begin
  inherited;
  //Richiesta Aperta
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TWA177FFerieSolidali.chkAzzeraQuantitaChange(Sender: TObject);
begin
  inherited;
  //Richiesta Chiusa
  chkAggiornaProfili.Enabled:=not chkAzzeraQuantita.Checked;
  if not chkAggiornaProfili.Enabled then
    chkAggiornaProfili.Checked:=False;
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TWA177FFerieSolidali.chkImpostaTermineChange(Sender: TObject);
begin
  inherited;
  //Richiesta Fruibile
  edtTermine.Visible:=chkImpostaTermine.Checked;
  btnEsegui.Enabled:=chkAggiornaQuantita.Checked or chkAzzeraQuantita.Checked or chkAggiornaProfili.Checked or chkImpostaTermine.Checked;
end;

procedure TWA177FFerieSolidali.Esecuzione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    StartElaborazioneServer(btnEsegui.HTMLName)
  else
    MsgBox.ClearKeys;
end;

procedure TWA177FFerieSolidali.ElaborazioneServer;
begin
  (WR302DM as TWA177FFerieSolidaliDM).A177MW.Elaborazione;
  actAggiornaExecute(nil);
  btnAnomalie.Enabled:=RegistraMsg.ContieneTipoA;
  if RegistraMsg.ContieneTipoA then
    DCOMMsg:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    DCOMMsg:=A000MSG_MSG_ELABORAZIONE_TERMINATA;
end;

function TWA177FFerieSolidali.InizializzaAccesso;
begin
  Result:=False;
//  WR302DM.selTabella.SearchRecord('COD_PARAMETRISTIPENDI',GetParam('COD_PARAMETRISTIPENDI'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA177FFerieSolidali.InizializzaMsgElaborazione;
begin
  inherited;
  with WC022FMsgElaborazioneFM do
  begin
    Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    Titolo:=A000MSG_MSG_ELABORAZIONE;
    ImgFileName:=IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWA177FFerieSolidali.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA177FFerieSolidaliDM) do
  begin
//    R180SetVariable(TWA010FProfAsseIndDM(WR302DM).selSG101,'PROGRESSIVO',grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger);
//    TWA010FProfAsseIndDM(WR302DM).selSG101.Open;
  end;
end;

end.
