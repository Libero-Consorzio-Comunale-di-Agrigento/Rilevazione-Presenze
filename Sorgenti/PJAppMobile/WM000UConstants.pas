unit WM000UConstants;

interface

uses
  WM000UTypes,
  System.UITypes,
  Graphics,
  SysUtils,
  IniFiles, A000UCostanti;

const
  // titolo applicazione
  WEBAPP_TITLE = 'IrisAPP';
  FILE_CONFIG_IRISAPP = 'IrisAPP.ini';
  FILE_CONFIG_B110 = 'B110.ini';

  //UNASSIGNED_DATE = -693594; // 00/00/0000

  FONT_COLOR_DEFAULT            = clWebBlack;
  FONT_COLOR_DIP_IN_SERVIZIO    = clWebGreen;
  FONT_COLOR_DIP_GIUSTIFICATO   = clWebCrimson;
  FONT_COLOR_DIP_REPERIBILE     = clWebOrangeRed;

  FONT_COLOR_TIMB_ENTRATA       = clWebGreen;
  FONT_COLOR_TIMB_USCITA        = clWebCrimson;

  // limite richieste da visualizzare
  LIMITE_RICHIESTE_VISUALIZZATE = 100;

  COOKIE_AZIENDA = 'azienda';
  COOKIE_TOKEN = 'token';
  COOKIE_UTENTE = 'utente';     //dismesso
  COOKIE_PASSWORD = 'password'; //dismesso
  COOKIE_OAUTH2_ACCESSTOKEN = 'OAUTH2_accesstoken';
  COOKIE_OAUTH2_REFRESHTOKEN = 'OAUTH2_refreshtoken';
  COOKIE_OAUTH2_TOKENTYPE = 'OAUTH2_tokentype';

  COOKIE_PASSPHRASE = 'VlRGb1MyTkhUWGRTYkVaV1VWUXdPUT09';
  COOKIE_SEP = '{@IrisAPPTOKEN@}';

  PASSWORD_LOGIN_ESTERNO = 'PASSWORD_LOGIN_ESTERNO';

  // funzioni disponibili a menu
  FUNZIONI_MENU: array[0..14] of TFunzioneMenu =
  (
    (Tag:   0; S: 'WM011'; Classe: 'TWM011FDatiGiornalieriFM';     Titolo:'Dati giornalieri';              Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag:   0; S: 'WM012'; Classe: 'TWM012FElencoDipendentiFM';    Titolo:'Elenco dipendenti';             Abilitazione: (RichiedeFiltroIndividuale: False;  RichiedeProfiloResp: True)),
    (Tag: 417; S: 'WM005'; Classe: 'TWM005FCedolinoFM';            Titolo:'';                              Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag: 459; S: 'WM015'; Classe: 'TWM015FTimbraturaVirtualeFM';  Titolo:'';                              Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag: 405; S: 'WM004'; Classe: 'TWM004FCartellinoFM';          Titolo:'';                              Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag: 418; S: 'WM014'; Classe: 'TWM014FRicTimbratureFM';       Titolo:'Richiesta timbrature';          Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag: 419; S: 'WM010'; Classe: 'TWM010FAutTimbratureFM';       Titolo:'Autoriz. timbrature';           Abilitazione: (RichiedeFiltroIndividuale: False;  RichiedeProfiloResp: True)),
    (Tag: 407; S: 'WM003'; Classe: 'TWM003FAutAssenzeFM';          Titolo:'Autoriz. giustificativi';       Abilitazione: (RichiedeFiltroIndividuale: False;  RichiedeProfiloResp: True)),
    (Tag: 406; S: 'WM013'; Classe: 'TWM013FRicAssenzeFM';          Titolo:'';                              Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag: 420; S: 'WM006'; Classe: 'TWM006FGestioneDelegheFM';     Titolo:'';                              Abilitazione: (RichiedeFiltroIndividuale: False;  RichiedeProfiloResp: True)),
    (Tag: 430; S: 'WM016'; Classe: 'TWM016FRicCambioOrarioFM';     Titolo:'';                              Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag: 431; S: 'WM017'; Classe: 'TWM017FAutCambioOrarioFM';     Titolo:'Autoriz. cambio orario';        Abilitazione: (RichiedeFiltroIndividuale: False;  RichiedeProfiloResp: True)),
    (Tag: 445; S: 'WM018'; Classe: 'TWM018FMessaggisticaFM';       Titolo:'';                              Abilitazione: (RichiedeFiltroIndividuale: False;  RichiedeProfiloResp: False)),
    (Tag: 455; S: 'WM019'; Classe: 'TWM019FRicCertificazioniFM';   Titolo:'Compilaz. scheda informativa';  Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False)),
    (Tag: 456; S: 'WM020'; Classe: 'TWM020FAutCertificazioniFM';   Titolo:'Validaz. scheda informativa';   Abilitazione: (RichiedeFiltroIndividuale: False;  RichiedeProfiloResp: True))//,
    //(Tag:  -1; S: '_TEST'; Classe: 'TWM000FTestFM';                Titolo:'Test frame';                    Abilitazione: (RichiedeFiltroIndividuale: True;   RichiedeProfiloResp: False))
  );

implementation

end.
