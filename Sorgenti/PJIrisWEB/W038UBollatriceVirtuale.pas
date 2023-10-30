unit W038UBollatriceVirtuale;

interface

uses
  A000UCostanti, A023UTimbratureMW,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  R012UWebAnagrafico, IWVCLComponent,IWBaseLayoutComponent, Math,
  IWBaseContainerLayout, IWContainerLayout, System.DateUtils, System.StrUtils,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, A000UInterfaccia, OracleData, IWCompGrids, IWDBGrids, medpIWDBGrid,
  W038UBollatriceVirtualeDM, C180FunzioniGenerali, FunzioniGenerali, IWApplication,
  IWCompJQueryWidget, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  medpIWMessageDlg, IWCompMemo, meIWMemo, IW.Browser.InternetExplorer,
  C190FunzioniGeneraliWeb, IWCompListbox, meIWComboBox, W005UCartellinoFM,
  IWCompEdit, meIWEdit, meIWGrid;

type
  TW038FBollatriceVirtuale = class(TR012FWebAnagrafico)
    grdTimbrature: TmedpIWDBGrid;
    lblOraCorrente: TmeIWLabel;
    JQuery: TIWJQueryWidget;
    btnEntrata: TmedpIWImageButton;
    btnUscita: TmedpIWImageButton;
    btnRegistraEntrata: TmeIWButton;
    btnRegistraUscita: TmeIWButton;
    meIWMemo1: TmeIWMemo;
    btnCambiaProgressivo: TmeIWButton;
    lblEntrata: TmeIWLabel;
    lblUscita: TmeIWLabel;
    lblOraEntrata: TmeIWLabel;
    lblOraUscita: TmeIWLabel;
    cmbCausale: TmeIWComboBox;
    lblCausale: TmeIWLabel;
    lblClock: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure btnRegistraEntrataClick(Sender: TObject);
    procedure btnEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnRegistraUscitaClick(Sender: TObject);
    procedure btnUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnCambiaProgressivoClick(Sender: TObject);
    procedure lblEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure lblUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FDatiTimbratura: TDatiTimbratura;
    W038DM: TW038FBollatriceVirtualeDM;
    W005FM: TW005FCartellinoFM;
    A023MW: TA023FTimbratureMW;
    FRilevatore: String;
    FEsistonoTolleranze: Boolean;
    FParMinutiTolleranzaE: Integer;
    FParMinutiTolleranzaU: Integer;
    procedure RegistraTimbratura;
    procedure cmbAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure ResultTimbraturaEsci(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultConferma(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure ResultTimbraturaOk(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    function GetRilevatoreByIndirizzo(Indirizzo: String): String;
    procedure GestisciRisposteInsTimbratura;
    procedure ImpostaRegistraTimbratura(const PVerso: String);
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
  public
    procedure ImpostaOraCorrente(EventParams: TStringList);
    function  InizializzaAccesso: Boolean; override;
    procedure VisualizzaDipendenteCorrente; override;
  end;

const
  RILEVATORE_DEFAULT = '--';
  FORMATO_ORA_TIMB   = 'hh.nn.ss';
  LABEL_ENTRATA_HTML_IMG  = '<img alt="Entrata" style="cursor:pointer; margin-right:0.3em;" src="img/imgEntrata.png"/>';
  LABEL_ENTRATA_HTML_SPAN = '<span class="etichettaTimbratura">Entrata</span>';
  LABEL_USCITA_HTML_IMG   = '<img alt="Uscita" style="cursor:pointer; margin-left:0.3em;" src="img/imgUscita.png"/>';
  LABEL_USCITA_HTML_SPAN  = '<span class="etichettaTimbratura">Uscita</span>';

implementation

{$R *.dfm}

function TW038FBollatriceVirtuale.InizializzaAccesso:Boolean;
const
  FUNZIONE = 'InizializzaAccesso';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Result:=True;

  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW038FBollatriceVirtuale.VisualizzaDipendenteCorrente;
var
  DataOggi,
  DataInizio: TDateTime;
  NumGGVisibili: Integer;
  Codice, Descrizione: String;
const
  FUNZIONE = 'VisualizzaDipendenteCorrente';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  inherited;

  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  DataOggi:=Date;

  // BELLUNUM - commessa 2016/175 VARIE#0.ini
  //NumGGVisibili (0..31): 0=W005 non visibile, 1(default)=oggi, 2=ieri e oggi, ecc..
  NumGGVisibili:=Min(31,Max(0,StrToIntDef(Parametri.CampiRiferimento.C90_W038NumGGVisibili,1)));
  DataInizio:=DataOggi - NumGGVisibili + 1;

  // gestione causale
  lblCausale.Visible:=False;
  cmbCausale.Visible:=False;
  if (Parametri.CampiRiferimento.C90_W038TimbCausalizzabile = 'S') and (not SolaLettura) then
  begin
    // la gestione della causalizzazione è abilitata
    R180SetVariable(W038DM.selT275Abilitate,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(W038DM.selT275Abilitate,'DATA',DataOggi);
    W038DM.selT275Abilitate.Open;
    if W038DM.selT275Abilitate.RecordCount > 0 then
    begin
      // sono presenti causali abilitate: le aggiunge alla combobox di selezione
      cmbCausale.Items.BeginUpdate;
      cmbCausale.Items.Add('=');
      while not W038DM.selT275Abilitate.Eof do
      begin
        Codice:=W038DM.selT275Abilitate.FieldByName('CODICE').AsString;
        Descrizione:=Format('%-5s %s',[Codice,W038DM.selT275Abilitate.FieldByName('DESCRIZIONE').AsString]);
        cmbCausale.Items.Values[Descrizione]:=Codice;
        W038DM.selT275Abilitate.Next;
      end;
      cmbCausale.Items.EndUpdate;

      // rende visibile i dati della causale e imposta elemento vuoto come default
      lblCausale.Visible:=True;
      cmbCausale.Visible:=True;
      cmbCausale.ItemIndex:=0;
    end;
  end;

  // questa form utilizza il frame W005FM per visualizzare le timbrature
  if NumGGVisibili > 0 then
  begin
    W005FM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
    W005FM.Dal:=DataInizio;
    W005FM.Al:=DataOggi;
    W005FM.Visualizza(False,False,False);
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW038FBollatriceVirtuale.IWAppFormCreate(Sender: TObject);
var
  CallBackName, Js, fixIE8: String;
begin
  inherited;

  // colonne di V430 da estrarre oltre a quelle standard
  CampiV430:='V430.T430TGESTIONE';

  FDatiTimbratura:=TDatiTimbratura.Create;

  FParMinutiTolleranzaE:=StrToIntDef(Parametri.CampiRiferimento.C90_W038Tolleranza_E,0);
  FParMinutiTolleranzaU:=StrToIntDef(Parametri.CampiRiferimento.C90_W038Tolleranza_U,0);
  FEsistonoTolleranze:=(FParMinutiTolleranzaE <> 0) or (FParMinutiTolleranzaU <> 0);
  lblOraEntrata.Visible:=FEsistonoTolleranze;
  lblOraUscita.Visible:=FEsistonoTolleranze;

  CambioDipendenteAsync:=True;
  cmbDipendentiDisponibili.OnAsyncChange:=cmbAsyncChange;
  W038DM:=TW038FBollatriceVirtualeDM.Create(Self);
  W005FM:=TW005FCartellinoFM.Create(Self);

  // middleware per registrazione timbratura
  A023MW:=TA023FTimbratureMW.Create(Self);

  // gestione rilevatore
  if Parametri.CampiRiferimento.C90_W038Rilevatore <> '' then
  begin
    FRilevatore:=Parametri.CampiRiferimento.C90_W038Rilevatore;
  end
  else
  begin
    FRilevatore:=RILEVATORE_DEFAULT;
    if WR000DM.ClientName <> '' then
      FRilevatore:=GetRilevatoreByIndirizzo(WR000DM.ClientName);
    if (FDatiTimbratura.Rilevatore = RILEVATORE_DEFAULT) and
       (WR000DM.IpAddressClient <> '') and
       (W038DM.selT361.SearchRecord('INDIRIZZO_IP',WR000DM.IpAddressClient,[srFromBeginning])) then
      FRilevatore:=W038DM.selT361.FieldByName('CODICE').AsString;
  end;

  // imposta ed abilita jquery plugin per orologio
  //http://tutorialzine.com/2013/06/digital-clock/
  CallBackName:=UpperCase(Self.Name) + '.ImpostaOraCorrente';
  GGetWebApplicationThreadVar.RegisterCallBack(CallBackName,ImpostaOraCorrente);

  //Fix per IE8, gli span:before e span:after non funzionano correttamente
  fixIE8:='false';
  if (GGetWebApplicationThreadVar.Browser is TInternetExplorer) and
     (GGetWebApplicationThreadVar.Browser.MajorVersion = 8) then
    fixIE8:='true';

  lblEntrata.Caption:=LABEL_ENTRATA_HTML_IMG + IfThen(Parametri.AccessibilitaNonVedenti <> 'S',LABEL_ENTRATA_HTML_SPAN);
  lblUscita.Caption:=IfThen(Parametri.AccessibilitaNonVedenti <> 'S',LABEL_USCITA_HTML_SPAN) + LABEL_USCITA_HTML_IMG;
  lblEntrata.Visible:=not SolaLettura;
  lblUscita.Visible:=not SolaLettura;
  lblOraEntrata.Visible:=not SolaLettura and FEsistonoTolleranze;
  lblOraUscita.Visible:=not SolaLettura and FEsistonoTolleranze;

  if Parametri.AccessibilitaNonVedenti = 'S' then
    lblClock.Caption:=''
  else
    lblClock.Caption:='<div id="clock" class="dark"><div class="display"><div class="weekdays"></div><div class="ampm"></div><div class="alarm"></div><div class="digits"></div></div></div>';

  Js:=Format('impostaOrologio(' + fixIE8 + '); setInterval(function () {processAjaxEvent("",null,"%s",false,null,false);}, 1000);',[CallBackName]);
  JQuery.onReady.Text:=JS;
end;

function TW038FBollatriceVirtuale.GetRilevatoreByIndirizzo(Indirizzo:String):String;
{Indirizzo: nome del computer passato a login
 FieldByName('INDIRIZZO').AsString: nome del computer sulla tabella degli orologi}
begin
  Result:=RILEVATORE_DEFAULT;
  with W038DM.selT361 do
  begin
    First;
    while not Eof do
    begin
      if Pos(FieldByName('INDIRIZZO').AsString.ToUpper,Indirizzo.ToUpper) > 0 then
      begin
        Result:=FieldByName('CODICE').AsString;
        Break;
      end;
      Next;
    end;
  end;
end;

procedure TW038FBollatriceVirtuale.cmbAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btncambiaProgressivo.HTMLName]));
end;

procedure TW038FBollatriceVirtuale.IWAppFormRender(Sender: TObject);
begin
  inherited;
  ImpostaOraCorrente(nil);
end;

procedure TW038FBollatriceVirtuale.lblEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraEntrata.HTMLName]));
end;

procedure TW038FBollatriceVirtuale.lblUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraUscita.HTMLName]));
end;

procedure TW038FBollatriceVirtuale.btnEntrataAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraEntrata.HTMLName]));
end;

procedure TW038FBollatriceVirtuale.btnUscitaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Usato AsyncClick e non click perchè vi è la funzione javascript che
  //richiama evento async ogni secondo.
  //un submit durante un evento async viene perso dal fantastico IW (bug segnalato e risposto che è una feature)
  GGetWebApplicationThreadVar.CallBackResponse.AddJavascriptToExecuteAsCDATA(Format('SubmitClick("%s","",true); ',[btnRegistraUscita.HTMLName]));
end;

procedure TW038FBollatriceVirtuale.RefreshPage;
begin
  VisualizzaDipendenteCorrente;
end;

procedure TW038FBollatriceVirtuale.DistruggiOggetti;
begin
  FreeAndNil(FDatiTimbratura);
  W005FM.btnChiudiClick(nil);
end;

procedure TW038FBollatriceVirtuale.ImpostaRegistraTimbratura(const PVerso: String);
var
  LDeltaMinuti: Integer;
  LDataOraT100: TDateTime;
  LResCtrl: TResCtrl;
begin
  // imposta i dati della timbratura
  FDatiTimbratura.EsistonoTolleranze:=FEsistonoTolleranze;
  FDatiTimbratura.TimbCausalizzabile:=cmbCausale.Visible;

  // salva immediatamente la data/ora corrente
  FDatiTimbratura.DataOra:=Now;

  // progressivo
  FDatiTimbratura.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  // verso
  FDatiTimbratura.Verso:=PVerso;

  // data / ora effettive in base ai parametri di tolleranza
  LDeltaMinuti:=IfThen(FDatiTimbratura.Verso = 'E',-FParMinutiTolleranzaE,FParMinutiTolleranzaU);
  LDataOraT100:=FDatiTimbratura.DataOra.AddMinutes(LDeltaMinuti);
  FDatiTimbratura.Data:=LDataOraT100.Date;
  FDatiTimbratura.Ora:=LDataOraT100;

  // causale
  if FDatiTimbratura.TimbCausalizzabile then
    FDatiTimbratura.Causale:=cmbCausale.Items.ValueFromIndex[cmbCausale.ItemIndex]
  else
    FDatiTimbratura.Causale:='';

  // rilevatore
  FDatiTimbratura.Rilevatore:=FRilevatore;

  // controlli standard su dati timbratura
  LResCtrl:=FDatiTimbratura.Check;
  if not LResCtrl.Ok then
  begin
    MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
    Exit;
  end;

  RegistraTimbratura;
end;

procedure TW038FBollatriceVirtuale.RegistraTimbratura;
begin
  A023MW.CtrlRegistraTimbratura(FDatiTimbratura);
  GestisciRisposteInsTimbratura;
end;

procedure TW038FBollatriceVirtuale.GestisciRisposteInsTimbratura;
begin
  if FDatiTimbratura.RisposteMsg.Bloccante then
  begin
    MsgBox.MessageBox(FDatiTimbratura.RisposteMsg.ErrMsg,ESCLAMA,FDatiTimbratura.RisposteMsg.ErrTitolo);
    Exit;
  end
  else if FDatiTimbratura.RisposteMsg.ErrMsg <> '' then
  begin
    MsgBox.WebMessageDlg(FDatiTimbratura.RisposteMsg.ErrMsg,mtWarning,[mbYes,mbNo],ResultConferma,FDatiTimbratura.RisposteMsg.ErrCod,FDatiTimbratura.RisposteMsg.ErrTitolo,mbNo);
    Exit;
  end
  else
  begin
    if (WR000DM.PaginaSingola <> '') then
      MsgBox.WebMessageDlg('Timbratura inserita con successo',mtInformation,[mbOk],ResultTimbraturaEsci,'')
    else
      MsgBox.WebMessageDlg('Timbratura inserita con successo',mtInformation,[mbOk],ResultTimbraturaOk,'');
  end;
end;

procedure TW038FBollatriceVirtuale.ResultConferma(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  case Res of
    mrYes:
      begin
        FDatiTimbratura.RisposteMsg.AddRisposta(KeyID,RSP_DATIGIUST_SI);
        RegistraTimbratura;
      end;
    mrNo:
      begin
        FDatiTimbratura.RisposteMsg.AddRisposta(KeyID,RSP_DATIGIUST_NO);
        MsgBox.ClearKeys;
      end;
  end;
end;

procedure TW038FBollatriceVirtuale.ResultTimbraturaEsci(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  // timbratura inserita -> uscita immediata nel caso di pagina singola
  lnkEsciClick(nil);
end;

procedure TW038FBollatriceVirtuale.ResultTimbraturaOk(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  // la timbratura è stata inserita correttamente
  MsgBox.ClearKeys;
  VisualizzaDipendenteCorrente;
end;

procedure TW038FBollatriceVirtuale.btnCambiaProgressivoClick(Sender: TObject);
begin
  OnCambiaProgressivo;
end;

procedure TW038FBollatriceVirtuale.btnRegistraEntrataClick(Sender: TObject);
begin
  FDatiTimbratura.Clear;
  ImpostaRegistraTimbratura('E');
  VisualizzaDipendenteCorrente;
end;

procedure TW038FBollatriceVirtuale.btnRegistraUscitaClick(Sender: TObject);
begin
  FDatiTimbratura.Clear;
  ImpostaRegistraTimbratura('U');
  VisualizzaDipendenteCorrente;
end;

procedure TW038FBollatriceVirtuale.ImpostaOraCorrente(EventParams: TStringList);
var
  dNow: TDateTime;
begin
  if Self.IsPageClosing then
    Exit;

  // gestione abilitazioni I076
  if not Self.medpI076Info.Enabled then
    Exit;

  dNow:=Now;
  lblOraCorrente.Caption:=FormatDateTime('hhnnss',dNow) + IntToStr(DayOfWeek(dNow) - 1);
  // entrata e uscita con i minuti di tolleranza
  if FEsistonoTolleranze then
  begin
    lblOraEntrata.Caption:=FormatDateTime(FORMATO_ORA_TIMB,IncMinute(dNow,-FParMinutiTolleranzaE));
    lblOraUscita.Caption:=FormatDateTime(FORMATO_ORA_TIMB,IncMinute(dNow,FParMinutiTolleranzaU));
  end;
  if GGetWebApplicationThreadVar.IsCallBack then
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA('aggiornaOrologio();');
end;

end.
