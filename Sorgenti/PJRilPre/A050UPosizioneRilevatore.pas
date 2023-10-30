unit A050UPosizioneRilevatore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, ComCtrls, MSHTML,
  System.Win.Registry, System.StrUtils, Vcl.Buttons;

type
  TA050FPosizioneRilevatore = class(TForm)
    WebBrowser1: TWebBrowser;
    PanelHeader: TPanel;
    memIndirizzo: TMemo;
    btnGotoIndirizzo: TButton;
    lblIndirizzo: TLabel;
    btnOK: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnGotoIndirizzoClick(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData, Headers: OleVariant; var Cancel: WordBool);
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure WebBrowser1NavigateComplete2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure btnOKClick(Sender: TObject);
  private
    HTMLWindow2: IHTMLWindow2;
    FRilevatore: string;
    FCanEdit: Boolean;
    FLat: double;
    FLng: double;
    FRadius: Integer;
    FAddress: string;
    FCurDispatch: IDispatch;
    FDocLoaded: Boolean;
    procedure SetCanEdit(const Value: Boolean);
    procedure SetPermissions;
    function StringToCoord(const Value: string): Double;
    procedure SetLatStr(const Value: string);
    procedure SetLngStr(const Value: string);
  public
    property CanEdit: Boolean read FCanEdit write SetCanEdit;
    property Rilevatore: String read FRilevatore write FRilevatore;
    property Lat: double read FLat write FLat;
    property Lng: double read FLng write FLng;
    property Radius: Integer read FRadius write FRadius;
    property Address: String read FAddress write FAddress;
  end;

implementation

uses
  A000UCostanti,
  ActiveX;

{$R *.dfm}

const
  HTMLStr: AnsiString =
    '<!DOCTYPE html>   '#13#10 +
    '<html>   '#13#10 +
    '  <head>   '#13#10 +
    //'    <title>Imposta posizione</title>   '#13#10 +
    '    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">   '#13#10 +
    '    <meta charset="utf-8">   '#13#10 +
    '    <style>   '#13#10 +
    '      #map {   '#13#10 +
    '        height: 100%;   '#13#10 +
    '      }   '#13#10 +
    '      html, body {   '#13#10 +
    '        height: 100%;   '#13#10 +
    '        margin: 0;   '#13#10 +
    '        padding: 0;   '#13#10 +
    '        font-family: Tahoma;   '#13#10 +
    '      }   '#13#10 +
    '      #infowindow-content .title {   '#13#10 +
    '        font-weight: bold;   '#13#10 +
    '      }   '#13#10 +
    '      #infowindow-content {   '#13#10 +
    '        display: none;   '#13#10 +
    '      }   '#13#10 +
    '      #map #infowindow-content {   '#13#10 +
    '        display: inline;   '#13#10 +
    '      }   '#13#10 +
    '      .pac-card {   '#13#10 +
    '        margin: 10px 0 0 10px;   '#13#10 +
    '        border-radius: 2px 0 0 2px;   '#13#10 +
    '        box-sizing: border-box;   '#13#10 +
    '        -moz-box-sizing: border-box;   '#13#10 +
    '        outline: none;   '#13#10 +
    '        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);   '#13#10 +
    '        background-color: #fff;   '#13#10 +
    '          '#13#10 +
    '      }   '#13#10 +
    '      #pac-title {   '#13#10 +
    '        color: #fff;   '#13#10 +
    '        background-color: #4d90fe;   '#13#10 +
    '        font-size: 18px;   '#13#10 +
    '        font-weight: bold; '#13#10 +
    '        padding: 6px 12px;   '#13#10 +
    '      }   '#13#10 +
    '      #pac-container {   '#13#10 +
    '        padding: 12px; '#13#10 +
    '      }   '#13#10 +
    '      #pac-label {   '#13#10 +
    '        font-size: 13px; '#13#10 +
    '      }   '#13#10 +
    '      #pac-radius {  '#13#10 +
    '        border: 1px solid #ccc; '#13#10 +
    '        background-color: #fff;   '#13#10 +
    '        font-size: 14px;   '#13#10 +
    '        margin-left: 12px;   '#13#10 +
    '        padding: 0 4px 0 4px;   '#13#10 +
    '        width: 4em;   '#13#10 +
    '      }  '#13#10 +
    '       '#13#10 +
    '      #pac-radius:focus {   '#13#10 +
    '        border-color: #4d90fe;   '#13#10 +
    '      }   '#13#10 +
    '        '#13#10 +
    '        '#13#10 +
    '    </style>   '#13#10 +
    '  </head>   '#13#10 +
    '  <body>   '#13#10 +
    '    <div class="pac-card" id="pac-card" >   '#13#10 +
    '      <div id="pac-title">   '#13#10 +
    '        Impostazioni rilevatore '#13#10 +
    '      </div>   '#13#10 +
    '      <div id="pac-container">  '#13#10 +
    '        <label id="pac-label">Raggio validit&agrave; timbratura (metri) </label>  '#13#10 +
    '        <input id="pac-radius" type="number" min="-1" max="9999" value="0">   '#13#10 +
    '      </div>  '#13#10 +
    '    </div>  '#13#10 +
    '    <div id="map"></div>   '#13#10 +
    '    <div id="infowindow-content">   '#13#10 +
    '      <img src="" width="16" height="16" id="place-icon">   '#13#10 +
    '      <span id="place-name"  class="title"></span><br>   '#13#10 +
    '      <span id="place-address"></span>   '#13#10 +
    '    </div>   '#13#10 +
    '    <script>   '#13#10 +
    '      var map, infoWindow, rilCircle, geocoder, marker; '#13#10 +
    '      var retVal = new Object(); '#13#10 +
    '      var confirmPosition = function() {  '#13#10 +
    '        window.location = window.location + "?lat=" + retVal.center.lat() + "&lng=" + retVal.center.lng() + "&radius=" + retVal.radius + "&address=" + retVal.address; '#13#10 +
    '      }  '#13#10 +
    '      onload = function () {  '#13#10 +
    '        var e = document.getElementById("pac-radius"); '#13#10 +
    '        e.oninput = radiusInputHandler; '#13#10 +
    '        e.onpropertychange = e.oninput; // for IE8  '#13#10 +
    '      }; '#13#10 +
    '      var radiusInputHandler = function(e) {   '#13#10 +
    '        try {  '#13#10 +
    '          retVal.radius = parseInt(this.value); '#13#10 +
    '        }  '#13#10 +
    '        catch (err) {  '#13#10 +
    '          retVal.radius = 0; '#13#10 +
    '        }    '#13#10 +
    '        rilCircle.setCenter(retVal.center); '#13#10 +
    '        rilCircle.setRadius(retVal.radius); '#13#10 +
    '      }; '#13#10 +
    '      function initMap() {   '#13#10 +
    '        retVal.center = new google.maps.LatLng(0, 0); '#13#10 +
    '        retVal.radius = 0; '#13#10 +
    '        retVal.address = ""; '#13#10 +
    '        geocoder = new google.maps.Geocoder(); '#13#10 +
    '        map = new google.maps.Map(document.getElementById("map"), {   '#13#10 +
    '          center: retVal.center, '#13#10 +
    '          fullscreenControl: false, '#13#10 +
    '          zoom: 17,  '#13#10 +
    '          mapTypeId: google.maps.MapTypeId.ROADMAP, '#13#10 +
    '          mapTypeControl: false, '#13#10 +
    '          streetViewControl: false '#13#10 +
    '        });   '#13#10 +
    '        marker = new google.maps.Marker({   '#13#10 +
    '          map: map,   '#13#10 +
    '          anchorPoint: new google.maps.Point(0, -29)   '#13#10 +
    '        });   '#13#10 +
    '        rilCircle = new google.maps.Circle({  '#13#10 +
    '          clickable: false,  '#13#10 +
    '          strokeColor: "#0000FF",  '#13#10 +
    '          strokeOpacity: 0.8,  '#13#10 +
    '          strokeWeight: 2,  '#13#10 +
    '          fillColor: "#0000FF",  '#13#10 +
    '          fillOpacity: 0.15,  '#13#10 +
    '          map: map,  '#13#10 +
    '          center: null,  '#13#10 +
    '          radius: retVal.radius  '#13#10 +
    '        }); '#13#10 +
    '        infowindow = new google.maps.InfoWindow();   '#13#10 +
    '        var card = document.getElementById("pac-card");   '#13#10 +
    '        map.controls[google.maps.ControlPosition.TOP_LEFT].push(card);   '#13#10 +
    '        var infowindowContent = document.getElementById("infowindow-content");   '#13#10 +
    '        infowindow.setContent(infowindowContent);   '#13#10 +
    '      }  '#13#10 +
    '      function handleLocationError(browserHasGeolocation, infoWindow, pos) {  '#13#10 +
    '        infowindow.setPosition(pos); '#13#10 +
    '        infowindow.setContent(browserHasGeolocation ?  '#13#10 +
    '                              "Errore: il servizio di geolocalizzazione non funziona correttamente." :  '#13#10 +
    '                              "Errore: il browser in uso non supporta la geolocalizzazione."); '#13#10 +
    '        infowindow.open(map); '#13#10 +
    '      }  '#13#10 +
//  posizionamento del marker e del circle
    '      function moveMarker(coords) {  '#13#10 +
    '        if ((marker) && (rilCircle)) {  '#13#10 +
    '          marker.setVisible(false); '#13#10 +
    '          marker.setPosition(coords);   '#13#10 +
    '          marker.setVisible(true);   '#13#10 +
    '          rilCircle.setCenter(coords); '#13#10 +
    '          geocoder.geocode({"location": coords}, function(results, status) { '#13#10 +
    '            if (status === "OK") { '#13#10 +
    '             if (results[0]) { '#13#10 +
    '                retVal.address = results[0].formatted_address; '#13#10 +
    '                infowindow.setContent(results[0].formatted_address); '#13#10 +
    '                infowindow.open(map, marker); '#13#10 +
    '              } else { '#13#10 +
    '                // nessun risultato '#13#10 +
    '              } '#13#10 +
    '            } else { '#13#10 +
    '              // errore durante ricerca indirizzo -> cfr. status '#13#10 +
    '            } '#13#10 +
    '          }); '#13#10 +
    '        }  '#13#10 +
    '      }  '#13#10 +
//  posizionamento su indirizzo
    '      function gotoAddress(address) {  '#13#10 +
    '        if (geocoder) { '#13#10 +
    '          geocoder.geocode( { address: address }, function(results, status) { '#13#10 +
    '            if (status == google.maps.GeocoderStatus.OK) { '#13#10 +
    '              map.setCenter(results[0].geometry.location); '#13#10 +
    '              retVal.address = address; '#13#10 +
    '              retVal.center = new google.maps.LatLng(results[0].geometry.location.lat(), results[0].geometry.location.lng()); '#13#10 +
    '              moveMarker(retVal.center); '#13#10 +
    '            } else {  '#13#10 +
    '              window.alert("Errore durante la ricerca della localita: " + status); '#13#10 +
    '            }  '#13#10 +
    '          }); '#13#10 +
    '        }  '#13#10 +
    '      }  '#13#10 +
//  posizionamento su coordinate specifiche
    '      function gotoCoords(lat, lng, bMoveMarker) { '#13#10 +
    '        retVal.center = new google.maps.LatLng(lat, lng); '#13#10 +
    '        map.setCenter(retVal.center); '#13#10 +
    '        if (bMoveMarker) { '#13#10 +
    '          moveMarker(retVal.center); '#13#10 +
    '        } '#13#10 +
    '      } '#13#10 +
//  inizializzazione mappa
    '      function setInitialData(rilevatore, editEnabled, lat, lng, radius) { '#13#10 +
    '        document.getElementById("pac-title").textContent = "Rilevatore: " + rilevatore; '#13#10 +
    '        if (editEnabled) { '#13#10 +
    '          map.addListener("click", function(event) {  '#13#10 +
    '            infowindow.close();   '#13#10 +
    '            var pos = event.latLng; '#13#10 +
    '            if (pos) {  '#13#10 +
    '              retVal.center = pos; '#13#10 +
    '              moveMarker(retVal.center); '#13#10 +
    '            }  '#13#10 +
    '          }); '#13#10 +
    '        } '#13#10 +
    '        else { '#13#10 +
    '          document.getElementById("pac-radius").readOnly = true; ; '#13#10 +
    '        } '#13#10 +
    '        document.getElementById("pac-radius").value = radius; '#13#10 +
    '        try {  '#13#10 +
    '          retVal.radius = parseInt(radius); '#13#10 +
    '        }  '#13#10 +
    '        catch (err) { '#13#10 +
    '          retVal.radius = 0; '#13#10 +
    '        } '#13#10 +
    '        rilCircle.setRadius(retVal.radius); '#13#10 +
//  geolocalizzazione
    '        if ((lat === 0) && (lng === 0)) { '#13#10 +
    '          if (navigator.geolocation) {  '#13#10 +
    '            navigator.geolocation.getCurrentPosition(function(position) { '#13#10 +
    '              gotoCoords(position.coords.latitude, position.coords.longitude, false); '#13#10 +
    '            }, function() {  '#13#10 +
    '              handleLocationError(true, infowindow, map.getCenter()); '#13#10 +
    '            }); '#13#10 +
    '          } else {  '#13#10 +
    '            handleLocationError(false, infowindow, map.getCenter()); '#13#10 +
    '          }  '#13#10 +
    '        } '#13#10 +
    '        else { '#13#10 +
    '          gotoCoords(lat, lng, true); '#13#10 +
    '        } '#13#10 +
    '      } '#13#10 +
    '    </script>   '#13#10 +
    '    <script src="https://maps.googleapis.com/maps/api/js?key=' + GOOGLE_MAPS_API_KEY + '&libraries=places&callback=initMap" async defer></script>   '#13#10 +
    '  </body>   '#13#10 +
    '</html>';

procedure TA050FPosizioneRilevatore.SetPermissions;
const
  HOME_PATH = 'SOFTWARE';
  FEATURE_BROWSER_EMULATION = 'Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION\';
  IE_11 = 11001;
var
  LReg: TRegIniFile;
  LKey: string;
begin
  LKey:=ExtractFileName(ParamStr(0));
  LReg:=TRegIniFile.Create(HOME_PATH);
  try
    if LReg.OpenKey(FEATURE_BROWSER_EMULATION, True) and
      not(TRegistry(LReg).KeyExists(LKey) and (TRegistry(LReg).ReadInteger(LKey)
      = IE_11)) then
    begin
      TRegistry(LReg).WriteInteger(LKey, IE_11);
    end;
  finally
    LReg.Free;
  end;
end;

procedure TA050FPosizioneRilevatore.SetCanEdit(const Value: Boolean);
begin
  PanelHeader.Visible:=Value;
  FCanEdit:=Value;
end;

procedure TA050FPosizioneRilevatore.SetLatStr(const Value: string);
begin
  FLat:=StringToCoord(Value);
end;

procedure TA050FPosizioneRilevatore.SetLngStr(const Value: string);
begin
  FLng:=StringToCoord(Value);
end;

function TA050FPosizioneRilevatore.StringToCoord(const Value: string): Double;
var
  LFmtSettings: TFormatSettings;
begin
  LFmtSettings:=TFormatSettings.Create;
  LFmtSettings.DecimalSeparator:='.';
  Result:=StrToFloat(Value,LFmtSettings);
end;

procedure TA050FPosizioneRilevatore.FormCreate(Sender: TObject);
var
  LStream: TMemoryStream;
  LFlags: OleVariant;  // flags that determine action
  LPersistStreamInit: IPersistStreamInit;
  LStreamAdapter: IStream;
begin
  SetPermissions;

  FLat:=0;
  FLng:=0;
  FRadius:=0;
  FAddress:='';
  FCurDispatch:=nil;
  FDocLoaded:=False;
  btnGotoIndirizzo.Enabled:=False;

  // non salvare nella history
  // non utilizzare cache
  LFlags:=navNoHistory or navNoReadFromCache or navNoWriteToCache;
  WebBrowser1.Navigate('about:blank', LFlags);

  if Assigned(WebBrowser1.Document) then
  begin
    LStream:=TMemoryStream.Create;
    try
      LStream.WriteBuffer(Pointer(HTMLStr)^, Length(HTMLStr));
      LStream.Seek(0, soFromBeginning);
      if WebBrowser1.Document.QueryInterface(IPersistStreamInit, LPersistStreamInit) = S_OK then
      begin
        // pulisce documento
        if LPersistStreamInit.InitNew = S_OK then
        begin
          // estrae l'interfaccia dallo stream
          LStreamAdapter:=TStreamAdapter.Create(LStream);
          // carica i dati dallo stream nel webbrowser
          LPersistStreamInit.Load(LStreamAdapter);
        end;
      end;
    finally
      LStream.Free;
    end;
    HTMLWindow2:=(WebBrowser1.Document as IHTMLDocument2).parentWindow;
  end;
end;

procedure TA050FPosizioneRilevatore.FormShow(Sender: TObject);
var
  LSCript: string;
  LFmtSettings: TFormatSettings;
begin
  // inizializza posizione se indicata
  while not FDocLoaded do
    Application.ProcessMessages;

  LFmtSettings:=TFormatSettings.Create;
  LFmtSettings.DecimalSeparator:='.';
  LScript:=Format('setInitialData("%s", %s, %g, %g, %d)',[FRilevatore,IfThen(FCanEdit,'true','false'),FLat,FLng,FRadius],LFmtSettings);
  HTMLWindow2.execScript(LScript,'JavaScript');
end;

procedure TA050FPosizioneRilevatore.btnOKClick(Sender: TObject);
begin
  while not FDocLoaded do
    Application.ProcessMessages;
  HTMLWindow2.execScript(Format('confirmPosition()',['']),'JavaScript');
end;

procedure TA050FPosizioneRilevatore.btnGotoIndirizzoClick(Sender: TObject);
var
  LIndirizzo: String;
begin
  LIndirizzo:=memIndirizzo.Lines.Text.Trim;
  LIndirizzo:=LIndirizzo
    .Replace(#13#10,' ',[rfReplaceAll])
    .Replace(#13,' ',[rfReplaceAll])
    .Replace(#10,' ',[rfReplaceAll]);

  while not FDocLoaded do
    Application.ProcessMessages;
  HTMLWindow2.execScript(Format('gotoAddress(%s)',[LIndirizzo.QuotedString]),'JavaScript');
end;

procedure TA050FPosizioneRilevatore.WebBrowser1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  LURL: String;
  LStr: String;
  LKeyVal: String;
  LValArr: TArray<String>;
  LKey: String;
  LVal: String;
begin
  FCurDispatch:=nil;
  FDocLoaded:=False;
  btnGotoIndirizzo.Enabled:=False;

  LURL:=URL;

  if LURL.Contains('?') then
  begin
    LStr:=LURL.Substring(LURL.IndexOf('?') + 1);

    for LKeyVal in LStr.Split(['&']) do
    begin
      LValArr:=LKeyVal.Split(['=']);
      LKey:=LValArr[0];
      LVal:=LValArr[1];
      begin
        if LKey = 'lat' then
          SetLatStr(LVal)
        else if LKey = 'lng' then
          SetLngStr(LVal)
        else if LKey = 'radius' then
          FRadius:=LVal.ToInteger
        else if LKey = 'address' then
          FAddress:=LVal;
      end;
    end;
    ModalResult:=mrOk;
    //Close;
  end;
end;

procedure TA050FPosizioneRilevatore.WebBrowser1DocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
  if (pDisp = FCurDispatch) then
  begin
    FDocLoaded:=True;
    FCurDispatch:=nil;
    btnGotoIndirizzo.Enabled:=FDocLoaded;
  end;
end;

procedure TA050FPosizioneRilevatore.WebBrowser1NavigateComplete2(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
  if FCurDispatch = nil then
    FCurDispatch:=pDisp;
end;

end.
