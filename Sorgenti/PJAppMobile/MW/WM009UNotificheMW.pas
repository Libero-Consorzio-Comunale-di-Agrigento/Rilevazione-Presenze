unit WM009UNotificheMW;

interface

uses B110USharedTypes, B110UClientModule, C200UWebServicesTypes, A000UCostanti, A000USessione, SysUtils, Generics.Collections;


type
  TWM009FNotificheMW = class (TObject)
  private
    FNotifiche: TDictionary<Integer, Integer>;

    //non più utilizzate -----------
    FRichiesteAssenza: Integer;
    FRichiesteTimbratura: Integer;
    FCedolini: Integer;
    FRichiesteCambioOrario: Integer;
    FMessaggiDaLeggere: Integer;
    FCertificati: Integer;
    //------------------------------

    function GetRichiesteGiustSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): Integer;
    function GetRichiesteTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): Integer;
    function GetRichiesteCambioOrario(PSessioneIrisWin: TSessioneIrisWin): Integer;
    function GetMessaggiDaLeggere(PSessioneIrisWin: TSessioneIrisWin): Integer;
    function GetCedoliniSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PDatiGenerali: TOutputDatiGenerali): Integer;
    function GetCertificati(PSessioneIrisWin: TSessioneIrisWin): Integer;
    function GetNotificheByTag(const Tag: Integer): Integer;
  public
    property NotificheByTag[const Tag: Integer]: Integer read GetNotificheByTag;

    //non più utilizzate -----------
    property RichiesteAssenza: Integer read FRichiesteAssenza;
    property RichiesteTimbratura: Integer read FRichiesteTimbratura;
    property RichiesteCambioOrario: Integer read FRichiesteCambioOrario;
    property Cedolini: Integer read FCedolini;
    property MessaggiDaLeggere: Integer read FMessaggiDaLeggere;
    property Certificati: Integer read FCertificati;
    //------------------------------

    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function NumeroNotifiche: Integer;
    procedure AggiornaNotifiche(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PDatiGenerali: TOutputDatiGenerali; PSessioneIrisWin: TSessioneIrisWin);
  end;

implementation

uses WM016UCambioOrarioMW, WM018UMessaggisticaMW, WM019UCertificazioniMW;

{ TWM009FNotificheMW }

constructor TWM009FNotificheMW.Create;
begin
  inherited;
  FNotifiche:=TDictionary<Integer, Integer>.Create;
  Clear;
end;

destructor TWM009FNotificheMW.Destroy;
begin
  FreeAndNil(FNotifiche);
  inherited;
end;

procedure TWM009FNotificheMW.Clear;
begin
  FNotifiche.Clear;
  //non più utilizzate -----------
  FRichiesteAssenza:=0;
  FRichiesteTimbratura:=0;
  FCedolini:=0;
  FRichiesteCambioOrario:=0;
  FMessaggiDaLeggere:=0;
  FCertificati:=0;
  //------------------------------
end;

procedure TWM009FNotificheMW.AggiornaNotifiche(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PDatiGenerali: TOutputDatiGenerali; PSessioneIrisWin: TSessioneIrisWin);
begin
  Clear;
  // richieste di giustificativo da autorizzare
  // estratte solo se si dispone dell'abilitazione in scrittura
  if PDatiGenerali.GetAbilitazioneTag(407) = 'S' then
    //FRichiesteAssenza:=GetRichiesteGiustSRV(B110, InfoClient, ParametriLogin);
    FNotifiche.AddOrSetValue(407, GetRichiesteGiustSRV(B110, InfoClient, ParametriLogin));

  // richieste di timbratura da autorizzare
  // estratte solo se si dispone dell'abilitazione in scrittura
  if PDatiGenerali.GetAbilitazioneTag(419) = 'S' then
    //FRichiesteTimbratura:=GetRichiesteTimbraturaSRV(B110, InfoClient, ParametriLogin);
    FNotifiche.AddOrSetValue(419, GetRichiesteTimbraturaSRV(B110, InfoClient, ParametriLogin));

  // cedolini da visualizzare
  // estratti se si dispone almeno dell'abilitazione in lettura
  if PDatiGenerali.GetAbilitazioneTag(417) <> 'N' then
    //FCedolini:=GetCedoliniSRV(B110, InfoClient, ParametriLogin, PDatiGenerali);
    FNotifiche.AddOrSetValue(417, GetCedoliniSRV(B110, InfoClient, ParametriLogin, PDatiGenerali));

  // richieste di cambio orario da autorizzare
  // estratte solo se si dispone dell'abilitazione in scrittura
  if PDatiGenerali.GetAbilitazioneTag(431) = 'S' then
    //FRichiesteCambioOrario:=GetRichiesteCambioOrario(PSessioneIrisWin);
    FNotifiche.AddOrSetValue(431, GetRichiesteCambioOrario(PSessioneIrisWin));

  // messaggi da leggere
  // estratti se si dispone almeno dell'abilitazione in lettura
  if PDatiGenerali.GetAbilitazioneTag(445) <> 'N' then
    //FMessaggiDaLeggere:=GetMessaggiDaLeggere(PSessioneIrisWin);
    FNotifiche.AddOrSetValue(445, GetMessaggiDaLeggere(PSessioneIrisWin));

  // richieste di schede informative da validare
  // estratte solo se si dispone dell'abilitazione in scrittura
  if PDatiGenerali.GetAbilitazioneTag(456) = 'S' then
    //FCertificati:=GetCertificati(PSessioneIrisWin);
    FNotifiche.AddOrSetValue(456, GetCertificati(PSessioneIrisWin));
end;

function TWM009FNotificheMW.NumeroNotifiche: Integer;
begin
  Result:=FRichiesteAssenza + FRichiesteTimbratura + FCedolini + FRichiesteCambioOrario + FMessaggiDaLeggere + FCertificati;
end;

function TWM009FNotificheMW.GetCedoliniSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin; PDatiGenerali: TOutputDatiGenerali): Integer;
var LRes: TRisultato;
    LResCtrl: TResCtrl;
    LMeseDa: TDateTime;
    LMeseA: TDateTime;
begin
  try
    // impostazione date riferimento
    LMeseDa:=PDatiGenerali.ParametriServizi.DataUltimoCedolinoChiuso;
    if LMeseDa = DATE_NULL then
      LMeseDa:=Date;
    LMeseA:=LMeseDa;

    try
      // estrae dataset cedolini
      LRes:=B110.B110FServerMethodsDMClient.Cedolini(InfoClient.PrepareForServer,
                                                     ParametriLogin.PrepareForServer,
                                                     True,
                                                     LMeseDa,
                                                     LMeseA
                                                    );
      LResCtrl:=LRes.Check(TOutputCedolini);
      if LResCtrl.Ok then
        Result:=(LRes.Output as TOutputCedolini).NumeroCedolini
      else
        Result:=0;
    finally
      FreeAndNil((LRes.Output as TOutputCedolini).JSONDatasets); // per risolvere memory leak, sarebbe da valutare distruttore su TOutputCedolini
    end;

  except
    on E: Exception do
      Result:=0;
  end;
end;

function TWM009FNotificheMW.GetRichiesteGiustSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): Integer;
var
  LRes: TRisultato;
  LResCtrl: TResCtrl;
begin
  try
    LRes:=B110.B110FServerMethodsDMClient.RichiesteGiust(InfoClient.PrepareForServer,
                                                         ParametriLogin.PrepareForServer,
                                                         True,
                                                         TFiltriRichieste.Create('trDaAutorizzare',DATE_MIN,DATE_MAX,0),
                                                         '');
    LResCtrl:=LRes.Check(TOutputRichiesteGiust);
    if LResCtrl.Ok then
      Result:=(LRes.Output as TOutputRichiesteGiust).RichiesteTotali
    else
      Result:=0;
  except
    on E: Exception do
      Result:=0;
  end;
end;

function TWM009FNotificheMW.GetRichiesteTimbraturaSRV(B110: TB110FClientModule; InfoClient: TInfoClient; ParametriLogin: TParametriLogin): Integer;
var
  LRes: TRisultato;
  LResCtrl: TResCtrl;
begin
  try
    LRes:=B110.B110FServerMethodsDMClient.RichiesteTimb(InfoClient.PrepareForServer,
                                                        ParametriLogin.PrepareForServer,
                                                        True,
                                                        TFiltriRichieste.Create('trDaAutorizzare',DATE_MIN,DATE_MAX,0),
                                                        '');
    LResCtrl:=LRes.Check(TOutputRichiesteTimb);
    if LResCtrl.Ok then
      Result:=(LRes.Output as TOutputRichiesteTimb).RichiesteTotali
    else
      Result:=0;
  except
    on E: Exception do
      Result:=0;
  end;
end;

function TWM009FNotificheMW.GetRichiesteCambioOrario(PSessioneIrisWin: TSessioneIrisWin): Integer;
var WM016MW: TWM016FCambioOrarioMW;
begin
  Result:=0;
  try
    if Assigned(PSessioneIrisWin) then
    begin
      WM016MW:=TWM016FCambioOrarioMW.Create(PSessioneIrisWin, True);
      try
        WM016MW.AggiornaRichiesteSRV(nil, nil, nil);
        Result:=WM016MW.RecordCount;
      finally
        FreeAndNil(WM016MW);
      end;
    end;
  except
    on E: Exception do
      Result:=0;
  end;
end;

function TWM009FNotificheMW.GetMessaggiDaLeggere(PSessioneIrisWin: TSessioneIrisWin): Integer;
var WM018MW: TWM018FMessaggisticaMW;
begin
  Result:=0;
  try
    if Assigned(PSessioneIrisWin) then
    begin
      WM018MW:=TWM018FMessaggisticaMW.Create(PSessioneIrisWin);
      try
        Result:=WM018MW.GetNumMessaggiDaLeggere;
      finally
        FreeAndNil(WM018MW);
      end;
    end;
  except
    on E: Exception do
      Result:=0;
  end;
end;

function TWM009FNotificheMW.GetCertificati(PSessioneIrisWin: TSessioneIrisWin): Integer;
var WM019MW: TWM019FCertificazioniMW;
begin
  Result:=0;
  try
    if Assigned(PSessioneIrisWin) then
    begin
      WM019MW:=TWM019FCertificazioniMW.Create(PSessioneIrisWin, True, nil);
      try
        WM019MW.AggiornaRichiesteSRV(nil, nil, nil);
        Result:=WM019MW.RecordCount;
      finally
        FreeAndNil(WM019MW);
      end;
    end;
  except
    on E: Exception do
      Result:=0;
  end;
end;

function TWM009FNotificheMW.GetNotificheByTag(const Tag: Integer): Integer;
var LValue: Integer;
begin
  Result:=0;

  if FNotifiche.TryGetValue(Tag, LValue) then
    Result:=LValue;
end;

end.
