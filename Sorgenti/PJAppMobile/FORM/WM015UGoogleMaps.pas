unit WM015UGoogleMaps;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniGUIBaseClasses, uniPanel, uniHTMLFrame, unimHTMLFrame, System.Messaging;

type
  TWM015FGoogleMaps = class(TUnimForm)
    HTMLFrame: TUnimHTMLFrame;
    procedure UnimFormReady(Sender: TObject);
    procedure UnimFormDestroy(Sender: TObject);
    procedure UnimFormCreate(Sender: TObject);
  private
    { Private declarations }
    FLatMarker: Double;
    FLngMarker: Double;
    FRilevatoriJs: String;
    FCodRilevatore: String;
  public
    { Public declarations }
    property LatMarker: Double read FLatMarker write FLatMarker;
    property LngMarker: Double read FLngMarker write FLngMarker;
    property RilevatoriJs: String read FRilevatoriJs write FRilevatoriJs;
    property CodRilevatore: String read FCodRilevatore write FCodRilevatore;
  end;

function WM015FGoogleMaps: TWM015FGoogleMaps;

implementation

{$R *.dfm}

uses
  WM000UMainModule, uniGUIApplication, WM000UServerModule;

function WM015FGoogleMaps: TWM015FGoogleMaps;
begin
  Result:=TWM015FGoogleMaps(WM000FMainModule.GetFormInstance(TWM015FGoogleMaps));
end;

procedure TWM015FGoogleMaps.UnimFormCreate(Sender: TObject);
begin
  Caption:='<span style="display: flex; align-items: center;"><img src="' + WM000FServerModule.FilesFolderURL + 'favicon/favicon-96x96.png" width="35" height="35"><p>&nbsp&nbspMappa rilevatori</p></span>';
end;

procedure TWM015FGoogleMaps.UnimFormDestroy(Sender: TObject);
begin
  UniSession.AddJS('clear()');
end;

procedure TWM015FGoogleMaps.UnimFormReady(Sender: TObject);
var LJsCode: string;
begin
  LJsCode:=Format('drawMap(%s, %s, { %s }, "%s"); ',[floattostr(FLatMarker).Replace(',','.',[]), floattostr(FLngMarker).Replace(',','.',[]), FRilevatoriJs, FCodRilevatore]);
  UniSession.AddJS(LJsCode);
end;

end.
