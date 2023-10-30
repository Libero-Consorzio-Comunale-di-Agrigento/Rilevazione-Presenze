unit W022UValutatoFM;

interface

uses
  SysUtils, Classes, Controls, Forms,
  IWAppForm, IWApplication,
  IWVCLBaseContainer, IWContainer, IWRegion,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton,
  IWHTMLContainer, IWHTML40Container, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  DB, DBClient, StrUtils, medpIWMessageDlg,
  A000UInterfaccia, C190FunzioniGeneraliWeb, R010UPaginaWeb,
  W022UDettaglioValutazioni, W022USchedaValutazioniDtM,
  IWCompJQueryWidget, meIWButton, C180FunzioniGenerali;

type
  TW022FValutatoFM = class(TFrame)
    IWFrameRegion: TIWRegion;
    btnChiudi: TmeIWButton;
    IWTemplateProcessorFrame: TIWTemplateProcessorHTML;
    jQVisFrame: TIWJQueryWidget;
    dsrRiep: TDataSource;
    cdsRiep: TClientDataSet;
    btnApplica: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure btnApplicaClick(Sender: TObject);
  private
    AccettazioneOriginale,CommentiOriginali:String;
    W022: TW022FDettaglioValutazioni;
    WFormParent: TR010FPaginaWeb;
    procedure ResultExit(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    W022DtM4: TW022FSchedaValutazioniDtM;
    procedure Visualizza;
  end;

implementation

{$R *.dfm}

procedure TW022FValutatoFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=(Self.Owner as TIWAppForm);
  WFormParent:=(Self.Parent as TR010FPaginaWeb);
  btnApplica.Visible:=False;
  AccettazioneOriginale:='';
  CommentiOriginali:='';
end;

procedure TW022FValutatoFM.Visualizza;
var Titolo:String;
    AbilitaModifica:Boolean;
begin
  inherited;
  if W022 = nil then
    W022:=TW022FDettaglioValutazioni.Create(GGetWebApplicationThreadVar,False);
  try
    //Inizializzazioni
    W022.W022DtM2:=W022DtM4;
    W022.lblAccettazioneValutato.Parent:=IWFrameRegion;
    W022.chkAccettazioneValutatoSi.Parent:=IWFrameRegion;
    W022.chkAccettazioneValutatoNo.Parent:=IWFrameRegion;
    W022.lblDataAccettazioneValutato.Parent:=IWFrameRegion;
    W022.lblCommentiValutato.Parent:=IWFrameRegion;
    W022.dmemCommentiValutato.Parent:=IWFrameRegion;
    W022.dmemStoriaCommentiValutato.Parent:=IWFrameRegion;
    W022.W022DtM2.Azione:='';
    W022.W022DtM2.ModificaDelValutato:=True;
    W022.W022DtM2.Q710.RefreshRecord;//Esegue selStoriaCommVal con ModificaDelValutato
    W022.CaricaCampiDescrittivi;//Imposta i campi con ModificaDelValutato e campi calcolati
    W022.AbilitazioneControlli;//Imposta chkAccettazioneValutatoSi e chkAccettazioneValutatoNo
    //Abilitazioni
    with W022.W022DtM2 do
    begin
      AccettazioneOriginale:=Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString;
      CommentiOriginali:=Trim(Q710.FieldByName('COMMENTI_VALUTATO').AsString);
      W022.ModificaTestata:=(    (Trunc(R180SysDate(SessioneOracle)) >= selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_DA_RICHIESTA_VISIONE'))
                             and (Trunc(R180SysDate(SessioneOracle)) <= selSG746.Lookup('CODICE',Q710.FieldByName('STATO_AVANZAMENTO').AsInteger,'DATA_A_RICHIESTA_VISIONE')));
      if W022.ModificaTestata then
      begin
        btnApplica.Visible:=True;
        Azione:='M';
        Q710.Edit;
        W022.AbilitazioneControlli;//Imposta i campi in base al nuovo valore di ModificaTestata
      end;
    end;
  except
    on E: Exception do
    begin
      MsgBox.MessageBox(E.Message,ESCLAMA);
      btnChiudiClick(nil);
      Exit;
    end;
  end;
  Titolo:=Format('%s: %s %s',[W022.W022DtM2.RecuperaEtichetta('ANNO_VALUTAZIONE_C'),W022.W022DtM2.selQ710.FieldByName('D_DATA').AsString,W022.W022DtM2.selQ710.FieldByName('STATO_SCHEDA').AsString]);
  WFormParent.VisualizzajQMessaggio(jQVisFrame,770,-1,EM2PIXEL * 10,Titolo,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
end;

procedure TW022FValutatoFM.btnApplicaClick(Sender: TObject);
var Msg: String;
begin
  if btnApplica.Visible then
    if (CommentiOriginali <> Trim(W022.dmemCommentiValutato.Text))
    or (AccettazioneOriginale <> IfThen(W022.chkAccettazioneValutatoSi.Checked,'S',IfThen(W022.chkAccettazioneValutatoNo.Checked,'N',''))) then
      with W022.W022DtM2 do
      begin
        if W022.dmemCommentiValutato.Visible then
          W022.ControllaLunghezzaCampo(Length(Trim(W022.dmemCommentiValutato.Text)),Q710.FieldByName('COMMENTI_VALUTATO').Size,'COMMENTI_VALUTATO_C',True,Msg);
        Q710.FieldByName('COMMENTI_VALUTATO').AsString:=Trim(W022.dmemCommentiValutato.Text);
        Q710.FieldByName('COMMENTI_VALUTATO').AsString:=R180SostituisciCaratteriSpeciali(Trim(Q710.FieldByName('COMMENTI_VALUTATO').AsString));
        ControllaCommentiValutato;
        Q710.BeforePost:=nil;
        Q710.AfterPost:=nil;
        Q710.Post;
        Q710.RefreshRecord; // Se Oracle sostituisce qualche carattere speciale, devo aggiornare i campi descrittivi di testata prima di effettuare un altro Post
        Q710.BeforePost:=Q710BeforePost;
        Q710.AfterPost:=Q710AfterPost;
        Q710.Edit;
        W022.CaricaCampiDescrittivi;
        AccettazioneOriginale:=Q710.FieldByName('ACCETTAZIONE_VALUTATO').AsString;
        CommentiOriginali:=Trim(Q710.FieldByName('COMMENTI_VALUTATO').AsString);
      end;
end;

procedure TW022FValutatoFM.btnChiudiClick(Sender: TObject);
begin
  if (CommentiOriginali <> Trim(W022.dmemCommentiValutato.Text))
  or (AccettazioneOriginale <> IfThen(W022.chkAccettazioneValutatoSi.Checked,'S',IfThen(W022.chkAccettazioneValutatoNo.Checked,'N',''))) then
    MsgBox.WebMessageDlg('Salvare le modifiche?',mtConfirmation,[mbYes,mbNo,mbCancel],ResultExit,'')
  else
    ResultExit(nil,mrYes,'');
end;

procedure TW022FValutatoFM.ResultExit(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrCancel then
    exit
  else
  begin
    if R = mrYes then
      btnApplicaClick(nil);
    if W022.ModificaTestata then
      W022.W022DtM2.Q710.Cancel;
    W022.W022DtM2.ModificaDelValutato:=False;
    W022.ClosePage;
    Free;
  end;
end;

end.
