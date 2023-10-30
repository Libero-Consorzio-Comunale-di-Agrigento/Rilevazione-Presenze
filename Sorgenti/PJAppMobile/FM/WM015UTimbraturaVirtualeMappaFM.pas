unit WM015UTimbraturaVirtualeMappaFM;

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
  System.StrUtils, uniHTMLFrame, unimHTMLFrame, System.Messaging, WM016UGoogleMaps;

type

  TWM015FTimbraturaVirtualeMappaFM = class(TUniFrame)
    tmrOrario: TUnimTimer;
    lblErrori: TUnimLabel;
    pnlTimbratura: TUnimContainerPanel;
    pnlRilevatore: TUnimPanel;
    UnimPanel1: TUnimPanel;
    lblRilevatore: TUnimLabel;
    lblRilevatoreValue: TUnimLabel;
    btnMostraPosizione: TUnimButton;
    pnlPulsanti: TUnimPanel;
    btnEntrata: TUnimButton;
    UnimLabel1: TUnimLabel;
    btnUscita: TUnimButton;
    pnlCausale: TUnimPanel;
    lblCausale: TUnimLabel;
    cmbCausale: TUnimSelect;
    lblOra: TUnimLabel;
    lblData: TUnimLabel;
    HTMLFrame: TUnimHTMLFrame;
    procedure UniFrameCreate(Sender: TObject);
    procedure UniFrameDestroy(Sender: TObject);
    procedure btnEntrataClick(Sender: TObject);
    procedure btnUscitaClick(Sender: TObject);
    procedure lblOraAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure btnMostraPosizioneClick(Sender: TObject);
  private
    WM015MW: TWM015FTimbraturaVirtualeMW;
    FLatMarker: Double;
    FLngMarker: Double;
    FRilevatoriJs: String;
    FCodRilevatore: String;

    procedure InserisciTimbratura;
    procedure AbilitaTimbratura(const Value: Boolean);
    procedure RegistraTimbratura(PVerso: String);

    procedure PositionRead(Params: TUniStrings);
    procedure PositionError(Params: TUniStrings);

    procedure AggiornaCausali;
    //procedure AggiornaTimbrature;
    procedure AggiornaRilevatori;
  public
    { Public declarations }
  end;

implementation

uses
  uniGUIVars,
  uniGUIApplication,
  WM000UMainModule;

{$R *.dfm}

procedure TWM015FTimbraturaVirtualeMappaFM.UniFrameCreate(Sender: TObject);
var
  LJsCode: String;
begin
  with WM000FMainModule do
  begin
    WM015MW:=TWM015FTimbraturaVirtualeMW.Create(InfoLogin.DatiGenerali.DatiAnagraficiUtente.Progressivo,
                                                InfoLogin.DatiGenerali.Parametri.CampiRiferimento.C90_W038TimbCausalizzabile,
                                                InfoLogin.DatiGenerali.Parametri.CampiRiferimento.C90_W038RilevatoreMobile);
  end;

  // avvia il timer per aggiornamento data / ora
  LJsCode:='updateTime(WM015FTimbraturaVirtualeMappaFM.lblData, WM015FTimbraturaVirtualeMappaFM.lblOra); ';
  UniSession.AddJs(LJsCode);
  tmrOrario.Enabled:=True;

  // tab timbratura
  AbilitaTimbratura(False);
  // pannello scelta causale visibile in base a parametro aziendale

  // pannello rilevatore nascosto inizialmente
  pnlRilevatore.Visible:=False;
  btnMostraPosizione.Visible:=False;

  // pannello principale
  lblErrori.Caption:='';

  AggiornaCausali;
  //AggiornaTimbrature;
  AggiornaRilevatori;

  if WM015MW.UsaGeolocalizzazione then
  begin
    pnlRilevatore.Visible:=True;
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

procedure TWM015FTimbraturaVirtualeMappaFM.UniFrameDestroy(Sender: TObject);
var
  LJsCode: String;
begin
  // in chiusura ferma il timer javascript per la geolocalizzazione
  LJsCode:=
    'if (geolocInterval) { ' +
    '  clearInterval(geolocInterval); ' +
    '  geoLocInterval = 0; '+
    '} ';
  UniSession.AddJS(LJsCode);

  FreeAndNil(WM015MW);

  UniSession.AddJS('clear()');
end;


procedure TWM015FTimbraturaVirtualeMappaFM.AggiornaCausali;
var i: Integer;
    LCausale: String;
    LResCtrl: TResCtrl;
begin
  pnlCausale.Visible:=WM015MW.TimbCausalizzabile;

  if WM015MW.TimbCausalizzabile then
  begin
    with WM000FMainModule do
      LResCtrl:= WM015MW.CaricaListaCausaliSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

    if LResCtrl.Ok then
    begin
      cmbCausale.Clear;

      for i:=0 to WM015MW.ListaCausali.Count-1 do
      begin
        LCausale:=Format('%.*s %s',[WM015MW.ListaCausali[i].Key.Length, WM015MW.ListaCausali[i].Key, WM015MW.ListaCausali[i].Value]);
        cmbCausale.Items.Add(LCausale);

        if i=0 then
          cmbCausale.Items.Objects[0]:=WM015MW.ListaCausali;
      end;

      cmbCausale.ItemIndex:=0;
    end
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

{procedure TWM015FTimbraturaVirtualeMappaFM.AggiornaTimbrature;
var i: Integer;
    LResCtrl: TResCtrl;
begin
  with WM000FMainModule do
    LResCtrl:= WM015MW.CaricaListaTimbrature(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

  if LResCtrl.Ok then
    if WM015MW.ListaTimbrature.Count = 0 then
    begin
      lstTimbrature.Items.Clear;
      // testo per indicare che non ci sono ancora timbrature
      lstTimbrature.Items.Add('Nessuna timbratura');
    end
    else
    begin
      lstTimbrature.Items.Clear;

      for i:=0 to WM015MW.ListaTimbrature.Count-1 do
      begin
        lstTimbrature.Items.Add(WM015MW.ListaTimbrature[i]);
      end;
    end
  else
    ShowMessage(LResCtrl.Messaggio);
end;}

procedure TWM015FTimbraturaVirtualeMappaFM.AggiornaRilevatori;
var LResCtrl: TResCtrl;
begin
  with WM000FMainModule do
    LResCtrl:= WM015MW.CaricaListaRilevatoriSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

  if not LResCtrl.Ok then
  begin
    ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWM015FTimbraturaVirtualeMappaFM.AbilitaTimbratura(const Value: Boolean);
begin
  btnEntrata.Enabled:=Value;
  btnUscita.Enabled:=Value;
end;

procedure TWM015FTimbraturaVirtualeMappaFM.InserisciTimbratura;
var LResCtrl: TResCtrl;
    LRisposteMsg: TRisposteMsg;
    LRisposta: String;
    LModalResult: Integer;
begin
  try
    with WM000FMainModule do
      LResCtrl:= WM015MW.InserisciTimbraturaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, LRisposteMsg);

    if not LResCtrl.Ok then
      Exit;

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
      //AggiornaTimbrature;

      // messaggio di conferma
      UniSession.AddJS('Ext.toast({message: "Timbratura inserita con successo", timeout: 5000}); ');
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

procedure TWM015FTimbraturaVirtualeMappaFM.lblOraAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if EventName = AJAX_CURRENT_POSITION_OK then
    PositionRead(Params)
  else if EventName = AJAX_CURRENT_POSITION_ERR then
    PositionError(Params);
end;

procedure TWM015FTimbraturaVirtualeMappaFM.RegistraTimbratura(PVerso: String);
var
  LResCtrl: TResCtrl;
  LCodCausale: String;
begin
  if cmbCausale.ItemIndex >= 0 then
    LCodCausale:=(cmbCausale.Items.Objects[0] as TList<TPair<String,String>>)[cmbCausale.ItemIndex].Key
  else
    LCodCausale:='';

  LResCtrl:=WM015MW.CreaNuovaTimbratura(PVerso, LCodCausale);

  if LResCtrl.Ok then
    InserisciTimbratura
  else
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWM015FTimbraturaVirtualeMappaFM.btnEntrataClick(Sender: TObject);
begin
  RegistraTimbratura('E');
end;

procedure TWM015FTimbraturaVirtualeMappaFM.btnMostraPosizioneClick(Sender: TObject);
var LRilevatoriJS: String;
    LJsCode: string;
begin
  FLatMarker:=WM015MW.LatitudineAttuale;
  FLngMarker:=WM015MW.LongitudineAttuale;
  FRilevatoriJs:=WM015MW.GetListaRilevatoriJs(FmtSettings);
  FCodRilevatore:=WM015MW.Rilevatore.Codice;

  LJsCode:=Format('drawMap(%s, %s, { %s }, "%s"); ',[floattostr(FLatMarker).Replace(',','.',[]), floattostr(FLngMarker).Replace(',','.',[]), FRilevatoriJs, FCodRilevatore]);
  UniSession.AddJS(LJsCode);
  //WM016FGoogleMaps.ShowModal;
end;

procedure TWM015FTimbraturaVirtualeMappaFM.btnUscitaClick(Sender: TObject);
begin
  RegistraTimbratura('U');
end;

procedure TWM015FTimbraturaVirtualeMappaFM.PositionRead(Params: TUniStrings);
var
  LLatStr: String;
  LLngStr: String;
  LLat: double;
  LLng: double;
  LRilevatoriJS: String;
  LJsCode: string;

  Messaggio: TMessage;
 // MessageManager: TMessageManager;
begin
  lblErrori.Caption:='';
  btnMostraPosizione.Visible:=True;

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
      lblRilevatoreValue.Text:='non disponibile';
      AbilitaTimbratura(False);
    end;
  except
    on E: Exception do
    begin
      lblErrori.Caption:=Format('Errore durante l''impostazione del rilevatore: %s',[E.Message]);
    end;
  end;
end;

procedure TWM015FTimbraturaVirtualeMappaFM.PositionError(Params: TUniStrings);
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
  btnMostraPosizione.Visible:=False;

  AbilitaTimbratura(False);
  // pulisce il rilevatore
  WM015MW.SvuotaRilevatore;
end;

initialization
  RegisterClass(TWM015FTimbraturaVirtualeMappaFM);

  // workaround per evitare errore di class not found sui frame:
  // attiva il classgroup di uno dei frame (sono tutti uguali)
  ActivateClassGroup(TWM015FTimbraturaVirtualeMappaFM);

end.
