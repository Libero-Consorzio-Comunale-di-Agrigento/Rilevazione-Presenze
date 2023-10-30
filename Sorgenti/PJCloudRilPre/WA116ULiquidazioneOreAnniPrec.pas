unit WA116ULiquidazioneOreAnniPrec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, StrUtils,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, medpIWC700NavigatorBar, A116ULiquidazioneOreAnniPrecMW, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, meIWImageFile, medpIWImageButton,
  IWCompCheckbox, meIWCheckBox,
  C180FunzioniGenerali, A000UInterfaccia, A000UMessaggi, A000UCostanti, DB,
  DBClient, MConnect, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} C190FunzioniGeneraliWeb, IWAdvCheckGroup,
  meTIWAdvCheckGroup, OracleData, medpIWMessageDlg, ActiveX;

type
  TWA116FLiquidazioneOreAnniPrec = class(TWR100FBase)
    btnGeneraPDF: TmedpIWImageButton;
    btnSoloAggiornamento: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    lblAnno: TmeIWLabel;
    edtAnno: TmeIWEdit;
    lblData: TmeIWLabel;
    edtData: TmeIWEdit;
    lblParametriLiquidazione: TmeIWLabel;
    lblLimiteOreLiquidabili: TmeIWLabel;
    edtMaxLiq: TmeIWEdit;
    lblArrotondamento: TmeIWLabel;
    edtArrotLiq: TmeIWEdit;
    chkAbbattimentoOre: TmeIWCheckBox;
    lblDettaglio: TmeIWLabel;
    btnCancella: TmedpIWImageButton;
    chkSaltoPag: TmeIWCheckBox;
    chkTotaliRaggr: TmeIWCheckBox;
    chkTotaliGen: TmeIWCheckBox;
    chkCessati: TmeIWCheckBox;
    lblIntestazione: TmeIWLabel;
    DCOMConnection: TDCOMConnection;
    cgpIntestazione: TmeTIWAdvCheckGroup;
    cgpDettaglio: TmeTIWAdvCheckGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnCancellaClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
  private
    A116MW: TA116FLiquidazioneOreAnniPrecMW;
    SoloAgg,IdAnomalia:String;
    OldProg:Integer;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure CallDCOMPrinter;
    function CreateJSonString: String;
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    function InizializzaAccesso: Boolean; override;
  protected
    procedure ImpostazioniWC700; override;
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

procedure TWA116FLiquidazioneOreAnniPrec.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  A116MW:=TA116FLiquidazioneOreAnniPrecMW.Create(Self);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.AttivaBrowse:=False;
  AttivaGestioneC700;
  btnAnomalie.Enabled:=False;
  with A116MW.selI010 do
    while not Eof do
    begin
      if (Copy(FieldByname('NOME_CAMPO').AsString,1,6) <> 'T430D_') and
         (FieldByname('NOME_CAMPO').AsString <> 'COGNOME') and
         (FieldByname('NOME_CAMPO').AsString <> 'NOME') and
         (FieldByname('NOME_CAMPO').AsString <> 'MATRICOLA') then
        cgpIntestazione.Items.Add(FieldByname('NOME_LOGICO').AsString);
      cgpDettaglio.Items.Add(FieldByname('NOME_LOGICO').AsString);
      Next;
    end;
  GetParametriFunzione;
  edtAnno.Text:=IntToStr(R180Anno(Parametri.DataLavoro) - 1);
  edtData.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
end;

function TWA116FLiquidazioneOreAnniPrec.InizializzaAccesso: Boolean;
begin
  Result:=AccessoAbilitato and (not SolaLettura);
end;

procedure TWA116FLiquidazioneOreAnniPrec.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA116FLiquidazioneOreAnniPrec.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtMaxLiq.Text:=C004DM.GetParametro('MAXLIQ','00.00');
  edtArrotLiq.Text:=C004DM.GetParametro('ARROTLIQ','0');
  chkAbbattimentoOre.Checked:=C004DM.GetParametro('ABBATTIMENTOORE','N') = 'S';
  chkSaltoPag.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
  chkTotaliRaggr.Checked:=C004DM.GetParametro('TOTALIPARZIALI','N') = 'S';
  chkTotaliGen.Checked:=C004DM.GetParametro('TOTALIGENERALI','N') = 'S';
  chkCessati.Checked:=C004DM.GetParametro('CESSATI','N') = 'S';
  C190PutCheckList(C004DM.GetParametro('INTESTAZIONE',''),99,cgpIntestazione);
  C190PutCheckList(C004DM.GetParametro('DETTAGLIO',''),99,cgpDettaglio);
end;

procedure TWA116FLiquidazioneOreAnniPrec.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA116FLiquidazioneOreAnniPrec.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  C004DM.PutParametro('MAXLIQ',edtMaxLiq.Text);
  C004DM.PutParametro('ARROTLIQ',edtArrotLiq.Text);
  C004DM.PutParametro('ABBATTIMENTOORE',IfThen(chkAbbattimentoOre.Checked,'S','N'));
  C004DM.PutParametro('SALTOPAGINA',IfThen(chkSaltoPag.Checked,'S','N'));
  C004DM.PutParametro('TOTALIPARZIALI',IfThen(chkTotaliRaggr.Checked,'S','N'));
  C004DM.PutParametro('TOTALIGENERALI',IfThen(chkTotaliGen.Checked,'S','N'));
  C004DM.PutParametro('CESSATI',IfThen(chkCessati.Checked,'S','N'));
  C004DM.PutParametro('INTESTAZIONE',C190GetCheckList(99,cgpIntestazione));
  C004DM.PutParametro('DETTAGLIO',C190GetCheckList(99,cgpDettaglio));
  try SessioneOracle.Commit; except end;
end;

procedure TWA116FLiquidazioneOreAnniPrec.edtDataAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  grdC700.WC700FM.C700DataLavoro:=R180FineMese(StrToDate('01/'+edtData.Text));
end;

procedure TWA116FLiquidazioneOreAnniPrec.btnGeneraPDFClick(Sender: TObject);
begin
  with A116MW do
  begin
    AnnoRif:=StrToInt(edtAnno.Text);
    Data:=StrToDate('01/' + edtData.Text);
    if (AnnoRif <> R180Anno(Data) - 1) and (AnnoRif <> R180Anno(Data) - 2) then
      raise exception.Create(A000MSG_A116_ERR_ANNO_RIF_PREC);
  end;
  SoloAgg:=IfThen(Sender = btnSoloAggiornamento,'S','N');
  CallDCOMPrinter;
  btnAnomalie.Enabled:=IdAnomalia <> '';
  if btnAnomalie.Enabled then
    Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_ANOMALIE,INFORMA)
  else if Sender = btnSoloAggiornamento then
    Msgbox.MessageBox(A000MSG_MSG_ELABORAZIONE_TERMINATA,INFORMA)
  else if not FileExists(DCOMNomeFile) then
    raise Exception.Create(A000MSG_ERR_FILE_NON_CREATO);
  if FileExists(DCOMNomeFile) then
  begin
    NomeFileGenerato:=DCOMNomeFile;
    InviaFileGenerato;
  end;
end;

procedure TWA116FLiquidazioneOreAnniPrec.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    A000SessioneWEB.AnnullaTimeOut;
    DCOMConnection.AppServer.PrintA116(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
    IdAnomalia:=DettaglioLog;
  finally
    DCOMConnection.Connected:=False;
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

function TWA116FLiquidazioneOreAnniPrec.CreateJSonString: String;
var json: TJSONObject;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtAnno,json);
    C190Comp2JsonString(edtData,json);
    C190Comp2JsonString(edtMaxLiq,json);
    C190Comp2JsonString(edtArrotLiq,json);
    C190Comp2JsonString(chkAbbattimentoOre,json);

    C190Comp2JsonString(chkSaltoPag,json);
    C190Comp2JsonString(chkTotaliRaggr,json);
    C190Comp2JsonString(chkTotaliGen,json);
    C190Comp2JsonString(chkCessati,json);

    json.AddPair('cgpIntestazione',TJSONString.Create(C190GetCheckList(99,cgpIntestazione)));
    json.AddPair('cgpDettaglio',TJSONString.Create(C190GetCheckList(99,cgpDettaglio)));

    json.AddPair('SoloAgg',TJSONString.Create(SoloAgg));

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA116FLiquidazioneOreAnniPrec.btnCancellaClick(Sender: TObject);
begin
  A116MW.AnnoRif:=StrToInt(edtAnno.Text);
  A116MW.Data:=StrToDate('01/' + edtData.Text);
  evtRichiesta(Format(A000MSG_A116_DLG_FMT_CANCELLA,[edtAnno.Text,edtData.Text]),'RichiestaConferma');
  StartElaborazioneCiclo((Sender as TmedpIWImageButton).HTMLName);
end;

procedure TWA116FLiquidazioneOreAnniPrec.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA116FLiquidazioneOreAnniPrec.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    btnCancellaClick(btnCancella)
  else
    MsgBox.ClearKeys;
end;

procedure TWA116FLiquidazioneOreAnniPrec.InizioElaborazione;
begin
  inherited;
  btnAnomalie.Enabled:=False;
  RegistraMsg.IniziaMessaggio(A116MW.CodForm);
  A116MW.selDatiBloccati.Close;
  OldProg:=grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger;
  R180SetVariable(grdC700.SelAnagrafe,'DataLavoro',R180FineMese(A116MW.Data));
  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;
end;

function TWA116FLiquidazioneOreAnniPrec.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

function TWA116FLiquidazioneOreAnniPrec.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

procedure TWA116FLiquidazioneOreAnniPrec.ElaboraElemento;
begin
  A116MW.CancellaLiquidazione(grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger);
end;

function TWA116FLiquidazioneOreAnniPrec.ElementoSuccessivo: Boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.EOF;
end;

procedure TWA116FLiquidazioneOreAnniPrec.FineCicloElaborazione;
begin
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  AggiornaAnagr;
  MsgBox.ClearKeys;
end;

function TWA116FLiquidazioneOreAnniPrec.ElaborazioneTerminata: String;
begin
  grdC700.SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
  if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA116FLiquidazioneOreAnniPrec.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IdAnomalia + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,False);
end;

end.
