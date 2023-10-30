unit WM015UTimbraturaVirtualeFM;

interface

uses
  A000UCostanti,
  B110USharedTypes,
  C200UWebServicesTypes,
  FunzioniGenerali,
  WM015UTimbraturaVirtualeMW,
  Data.FireDACJSONReflect,
  System.Generics.Collections,
  System.Math,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, uniButton, unimButton,
  uniBasicGrid, uniDBGrid, unimDBListGrid, unimDBGrid, uniMultiItem, unimSelect,
  uniGUImJSForm, unimPanel, uniLabel, unimLabel, uniPanel, uniPageControl,
  unimTabPanel, uniGUIBaseClasses, uniTimer, unimTimer, System.Sensors, unimList,
  System.StrUtils, uniHTMLFrame, unimHTMLFrame, System.Messaging, WM015UGoogleMaps,
  MedpUnimSelect, MedpUnimLabel, uniBitBtn, unimBitBtn, MedpUnimButton, WM000UFrameBase,
  MedpUnimPanelBase, MedpUnimPanelListaElem, MedpUnimPanelListaDisclosure, MedpUnimPanel2Labels,
  MedpUnimTypes, DateUtils, WM000UConstants, A000UInterfaccia;

type
  TWM015FTimbraturaVirtualeFM = class(TWM000FFrameBase)
    lblCausale: TMedpUnimLabel;
    cmbCausale: TMedpUnimSelect;
    pnlRilevatore: TMedpUnimPanelBase;
    pnlLabelsRilevatore: TMedpUnimPanelBase;
    btnMostraPosizione: TMedpUnimButton;
    pnlPulsanti: TMedpUnimPanelBase;
    tmrAggiornaOrario: TUnimTimer;
    btnEntrata: TMedpUnimButton;
    btnUscita: TMedpUnimButton;
    lblRilevatore: TMedpUnimLabel;
    lblRilevatoreValue: TMedpUnimLabel;
    lblErrori: TUnimLabel;
    pnlListaTimbrature: TMedpUnimPanelListaElem;
    pnlDataOra: TMedpUnimPanelBase;
    lblData: TMedpUnimLabel;
    lblOra: TMedpUnimLabel;
    lblTimbratureDiOggi: TMedpUnimLabel;
    tmrAggiornaSecondi: TUnimTimer;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject); override;
    procedure lblOraAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure btnTimbraturaAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure btnMostraPosizioneClick(Sender: TObject);
    procedure tmrAggiornaOrarioTimer(Sender: TObject);
    procedure UniFrameReady(Sender: TObject);
  private
    WM015MW: TWM015FTimbraturaVirtualeMW;

    procedure InserisciTimbratura;
    procedure AbilitaTimbratura(const Value: Boolean);
    procedure RegistraTimbratura(POra: TDateTime; PVerso: String);
    function GetOraTimbraturaClient(Params: TUniStrings): TDateTime;

    procedure PositionRead(Params: TUniStrings);
    procedure PositionError(Params: TUniStrings);

    procedure AggiornaCausali;
    procedure AggiornaTimbrature;
    procedure AggiornaRilevatori;
    function CreaPanelTimbrature(PCaption: String): TMedpUnimPanel2Labels;
  public
    { Public declarations }
  end;

implementation

uses
  uniGUIVars,
  uniGUIApplication,
  WM000UMainModule;

{$R *.dfm}

procedure TWM015FTimbraturaVirtualeFM.UniFrameCreate(Sender: TObject);
var
  LJsCode: String;
begin

  with WM000FMainModule.InfoLogin.DatiGenerali do
  begin
    WM015MW:=TWM015FTimbraturaVirtualeMW.Create(DatiAnagraficiUtente.Progressivo,
                                                Parametri.CampiRiferimento.C90_W038TimbCausalizzabile,
                                                Parametri.CampiRiferimento.C90_W038RilevatoreMobile,
                                                WM000FMainModule.InfoLogin.SessioneIrisWin);
  end;

  // tab timbratura
  AbilitaTimbratura(False);
  // pannello scelta causale visibile in base a parametro aziendale

  // pannello rilevatore nascosto inizialmente
  pnlRilevatore.Visible:=False;
  //btnMostraPosizione.Visible:=False;
  btnMostraPosizione.Enabled:=False;
  // pannello principale
  lblErrori.Caption:='';

  AggiornaCausali;
  AggiornaTimbrature;
  AggiornaRilevatori;

  if WM015MW.UsaGeolocalizzazione then
  begin
    pnlRilevatore.Visible:=True;
    lblRilevatoreValue.Caption:='Geolocalizzazione in corso...';
    // effettua lettura posizione corrente ad intervalli preimpostati
    LJsCode:='locateMe(); ' +
             'geolocInterval = setInterval(locateMe, 15000); ';

    UniSession.AddJS(LJsCode);
  end
  else
  begin
    pnlRilevatore.Visible:=False;
    AbilitaTimbratura(True);
  end;
end;

procedure TWM015FTimbraturaVirtualeFM.UniFrameDestroy(Sender: TObject);
var
  LJsCode: String;
begin
  if WM015MW.UsaGeolocalizzazione then
  begin
    // in chiusura ferma il timer javascript per la geolocalizzazione
    LJsCode:=
      'if (geolocInterval) { ' +
      '  clearInterval(geolocInterval); ' +
      '  geoLocInterval = 0; '+
      '} ';
    UniSession.AddJS(LJsCode);
  end;
  FreeAndNil(WM015MW);
  inherited;
end;

procedure TWM015FTimbraturaVirtualeFM.UniFrameReady(Sender: TObject);
begin
  inherited;
  tmrAggiornaOrarioTimer(nil);
  tmrAggiornaOrario.Enabled:=True;
  tmrAggiornaSecondi.Enabled:=True;
end;

procedure TWM015FTimbraturaVirtualeFM.AggiornaCausali;
var i: Integer;
    LResCtrl: TResCtrl;
begin
  lblCausale.Visible:=WM015MW.TimbCausalizzabile;
  cmbCausale.Visible:=WM015MW.TimbCausalizzabile;

  if WM015MW.TimbCausalizzabile then
  begin
    with WM000FMainModule do
      LResCtrl:= WM015MW.CaricaListaCausaliSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

    if LResCtrl.Ok then
    begin
      cmbCausale.Clear;

      cmbCausale.Add('', '');

      for i:=0 to WM015MW.ListaCausali.Count-1 do
        cmbCausale.Add(WM015MW.ListaCausali[i].Key, WM015MW.ListaCausali[i].Value);

      cmbCausale.ItemIndex:=0;
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWM015FTimbraturaVirtualeFM.AggiornaTimbrature;
var i: Integer;
    LResCtrl: TResCtrl;
begin
  pnlListaTimbrature.Clear;

  with WM000FMainModule do
    LResCtrl:= WM015MW.CaricaListaTimbratureSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

  if LResCtrl.Ok then
    if WM015MW.ListaTimbrature.Count = 0 then
      pnlListaTimbrature.Add(CreaPanelTimbrature('Nessuna timbratura'))
    else
    begin
      for i:=0 to WM015MW.ListaTimbrature.Count-1 do
        pnlListaTimbrature.Add(CreaPanelTimbrature(WM015MW.ListaTimbrature[i]));
    end
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM015FTimbraturaVirtualeFM.AggiornaRilevatori;
var LResCtrl: TResCtrl;
begin
  SessioneOracle.Preferences.UseOci7:=False;
  SessioneOracle.LogOn;
  SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  try
    with WM000FMainModule do
      LResCtrl:=WM015MW.CaricaListaRilevatori(Parametri.CampiRiferimento.C90_W038FiltroAnagRilevatoreMobile = 'S');
  finally
    SessioneOracle.LogOff;
  end;

  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM015FTimbraturaVirtualeFM.AbilitaTimbratura(const Value: Boolean);
begin
  btnEntrata.Enabled:=Value;
  btnUscita.Enabled:=Value;
end;

procedure TWM015FTimbraturaVirtualeFM.InserisciTimbratura;
var LResCtrl: TResCtrl;
    LRisposteMsg: TRisposteMsg;
    LRisposta: String;
    LModalResult: Integer;
begin
  try
    with WM000FMainModule do
      LResCtrl:= WM015MW.InserisciTimbraturaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LRisposteMsg);

    if not LResCtrl.Ok then
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end;

    if LRisposteMsg.Bloccante then
    begin
      // messaggio bloccante
      ShowMessage(LRisposteMsg.ErrMsg);
      Exit;
    end;

    if LRisposteMsg.ErrMsg = '' then
    begin
      // inserimento effettuato
      // aggiorna elenco timbrature
      AggiornaTimbrature;

      // messaggio di conferma
      UniSession.AddJS('Ext.toast({message: "<i class=''fas fa-check fa-4x'' style=''color: #157fcc;''></i><br><p style=''font-size:18px; margin-left: 5px; margin-right: 5px;''>  Timbratura inserita con successo  </p>", timeout: 5000}); ');
    end
    else
    begin
      LModalResult:=MessageDlg(LRisposteMsg.ErrMsg, TMsgDlgType.mtConfirmation, mbYesNo);

      if LModalResult = mrYes then
        LRisposta:='SI'
      else
        LRisposta:='NO';

      LRisposteMsg.AddRisposta(LRisposteMsg.ErrCod,LRisposta);
      LRisposteMsg.AddMsg('','');

      if Assigned(WM015MW.DatiTimbratura.RisposteMsg) then
        FreeAndNil(WM015MW.DatiTimbratura.RisposteMsg);
      WM015MW.DatiTimbratura.RisposteMsg:=LRisposteMsg.Clone;

      // gestione ricorsione
      if LModalResult = mrYes then
        InserisciTimbratura; // ricorsione
    end;
  finally
    FreeAndNil(LRisposteMsg);
  end;
end;

procedure TWM015FTimbraturaVirtualeFM.lblOraAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if EventName = AJAX_CURRENT_POSITION_OK then
    PositionRead(Params)
  else if EventName = AJAX_CURRENT_POSITION_ERR then
    PositionError(Params);
end;

procedure TWM015FTimbraturaVirtualeFM.RegistraTimbratura(POra: TDateTime; PVerso: String);
var
  LResCtrl: TResCtrl;
  LCodCausale: String;
begin
  if cmbCausale.ItemIndex >= 0 then
    LCodCausale:=cmbCausale.ListaCodici[cmbCausale.ItemIndex]
  else
    LCodCausale:='';

  LResCtrl:=WM015MW.CreaNuovaTimbratura(POra, PVerso, LCodCausale);

  if LResCtrl.Ok then
    InserisciTimbratura
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM015FTimbraturaVirtualeFM.tmrAggiornaOrarioTimer(Sender: TObject);
var
  LJsCode: String;
  LNow: TDateTime;
begin
  inherited;
  LNow:=Now;
  // avvia il timer per aggiornamento data / ora
  LJsCode:='updateTime(WM015FTimbraturaVirtualeFM.lblData, WM015FTimbraturaVirtualeFM.lblOra, ' +
            LNow.Year.ToString + ', ' +
            LNow.Month.ToString + ', ' +
            LNow.Day.ToString + ', ' +
            LNow.Hour.ToString + ', ' +
            LNow.Minute.ToString + ', ' +
            LNow.Second.ToString + ', ' +
            LNow.Millisecond.ToString + ');';

  UniSession.AddJs(LJsCode);
end;

procedure TWM015FTimbraturaVirtualeFM.btnTimbraturaAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
var LModalResult: Integer;
    LOraTimbServer, LOraTimbClient: TDateTime;
    LOraTimbServerStr, LOraTimbClientStr: String;
begin
  inherited;

  if (EventName = 'btnEntrataClick') or (EventName = 'btnUscitaClick') then
  begin
    LOraTimbServer:=Now;
    LOraTimbClient:=GetOraTimbraturaClient(Params);

    if Abs(SecondsBetween(LOraTimbClient, LOraTimbServer)) >= 30 then
    begin
      LOraTimbServerStr:=FormatDateTime('hh:nn:ss', LOraTimbServer);
      LOraTimbClientStr:=FormatDateTime('hh:nn:ss', LOraTimbClient);

      LModalResult:=MessageDlg('E'' stata rilevata una differenza superiore a 30 secondi tra l''ora di sistema e l''ora del dispositivo:' + #13#10 +
                               'Ora del dispositivo: ' + LOraTimbClientStr + #13#10 +
                               'Ora di sistema: ' + LOraTimbServerStr + #13#10 +
                               'Proseguire comunque con l''inserimento della timbratura alle ore ' + LOraTimbServerStr + '?',
                               TMsgDlgType.mtConfirmation, mbYesNo);

      if LModalResult = mrNo then
        Exit;
    end;

    if EventName = 'btnEntrataClick' then
      RegistraTimbratura(LOraTimbServer, 'E')
    else if EventName = 'btnUscitaClick' then
      RegistraTimbratura(LOraTimbServer, 'U');
  end;
end;

procedure TWM015FTimbraturaVirtualeFM.btnMostraPosizioneClick(Sender: TObject);
begin
  with WM015FGoogleMaps do
  begin
    LatMarker:=WM015MW.LatitudineAttuale;
    LngMarker:=WM015MW.LongitudineAttuale;
    RilevatoriJs:=WM015MW.GetListaRilevatoriJs(FmtSettings);

    if Assigned(WM015MW.Rilevatore) then
      CodRilevatore:=WM015MW.Rilevatore.Codice
    else
      CodRilevatore:='';

    ShowModal;
  end;
end;

procedure TWM015FTimbraturaVirtualeFM.PositionRead(Params: TUniStrings);
var
  LLatStr: String;
  LLngStr: String;
  LLat: double;
  LLng: double;
  LJsCode: string;
begin
  lblErrori.Caption:='';
  //btnMostraPosizione.Visible:=True;
  btnMostraPosizione.Enabled:=True;
  try
    // verifica ed imposta le coordinate
    LLatStr:=Params.Values['lat'];
    LLngStr:=Params.Values['lng'];
    if not TryStrToFloat(LLatStr.Replace('.',',',[]),LLat,FmtSettings) or
       not TryStrToFloat(LLngStr.Replace('.',',',[]),LLng,FmtSettings) then
    begin
      lblErrori.Caption:=Format('Coordinate di posizione non valide: (%s, %s)',[LLatStr,LLngStr]);
      Exit;
    end;

    if WM015MW.SetRilevatoreAgganciato(LLat, LLng) then
    begin
      lblRilevatoreValue.Text:=Format('%s %s',[WM015MW.Rilevatore.Codice,WM015MW.Rilevatore.Descrizione]);

      LJsCode:=Format('updatePosizione(%s, %s); ',[LLatStr, LLngStr]);
      UniSession.AddJS(LJsCode);

      LJsCode:=Format('updateRilevatori({ %s }, "%s"); ',[WM015MW.GetListaRilevatoriJs(FmtSettings), WM015MW.Rilevatore.Codice]);
      UniSession.AddJS(LJsCode);

      AbilitaTimbratura(True);
    end
    else
    begin
      lblRilevatoreValue.Text:='Non disponibile';
      AbilitaTimbratura(False);
    end;
  except
    on E: Exception do
    begin
      lblErrori.Caption:=Format('Errore durante l''impostazione del rilevatore: %s',[E.Message]);
    end;
  end;
end;

procedure TWM015FTimbraturaVirtualeFM.PositionError(Params: TUniStrings);
var
  LErrorCode: Integer;
  LErrMsg: string;
begin
  if TryStrToInt(Params.Values['errorCode'], LErrorCode) then
  begin
    case LErrorCode of
      1: LErrMsg:='permesso negato';
      2: LErrMsg:='posizione non disponibile';
      3: LErrMsg:='timeout';
    end;
  end
  else
  begin
    LErrMsg:=Format('codice di errore sconosciuto: %s',[Params.Values['errorCode']]);
  end;
  lblErrori.Caption:='Errore di geolocalizzazione: ' + LErrMsg;
  //btnMostraPosizione.Visible:=False;
  btnMostraPosizione.Enabled:=False;
  AbilitaTimbratura(False);
  // pulisce il rilevatore
  WM015MW.SvuotaRilevatore;
end;

function TWM015FTimbraturaVirtualeFM.CreaPanelTimbrature(PCaption: String): TMedpUnimPanel2Labels;
begin
  Result:=TMedpUnimPanel2Labels.Create(Self);

  with Result do
  begin
    with Label1 do
    begin
      Caption:=PCaption;
      LayoutConfig.Width:='100%';
      LayoutConfig.Height:='auto';
      Constraints.MinHeight:=30;
      JustifyContent:=JustifyCenter;
      BoxModel.CSSMargin.Left:='5px';
    end;

    Label2.Visible:=False;
  end;
end;

function TWM015FTimbraturaVirtualeFM.GetOraTimbraturaClient(Params: TUniStrings): TDateTime;
var LAnno, LMese, LGiorno, LOra, LMinuti, LSecondi: Integer;
    LEsito: Boolean;
begin
  LEsito:=TryStrToInt(Params.Values['anno'], LAnno);
  LEsito:=LEsito and TryStrToInt(Params.Values['mese'], LMese);
  LEsito:=LEsito and TryStrToInt(Params.Values['giorno'], LGiorno);
  LEsito:=LEsito and TryStrToInt(Params.Values['ora'], LOra);
  LEsito:=LEsito and TryStrToInt(Params.Values['minuti'], LMinuti);
  LEsito:=LEsito and TryStrToInt(Params.Values['secondi'], LSecondi);

  if LEsito then
    Result:=EncodeDateTime(Lanno, LMese, LGiorno, LOra, LMinuti, LSecondi, 0)
  else
    Result:=DATE_NULL;
end;

initialization
  RegisterClass(TWM015FTimbraturaVirtualeFM);

  ActivateClassGroup(TWM015FTimbraturaVirtualeFM);

end.
