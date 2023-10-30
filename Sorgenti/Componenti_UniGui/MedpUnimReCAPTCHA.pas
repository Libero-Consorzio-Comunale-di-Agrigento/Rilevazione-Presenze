unit MedpUnimReCAPTCHA;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniPanel, uniHTMLFrame, unimHTMLFrame, MedpUnimHTMLFrame, uniGUITypes,
  uIdHTTP;

type
  TMedpUnimReCAPTCHA = class(TMedpUnimHTMLFrame)
  private
    FSiteKey: string;
    FSecretKey: string;
    FVerified: Boolean;
    FOnVerified: TNotifyEvent;
    FOnExpired: TNotifyEvent;
    procedure SetSiteKey(const Value: string);
    procedure SetSecretKey(const Value: string);
  protected
    procedure BeforeLoadCompleted; override;
    procedure LoadCompleted; override;
    procedure JSEventHandler(AEventName: string; AParams: TUniStrings);override;
  public
    constructor Create(AOwner:TComponent); override;
  published
    property SiteKey: string read FSiteKey write SetSiteKey;
    property SecretKey: string read FSecretKey write SetSecretKey;
    property Verified: Boolean read FVerified;
    property OnVerified: TNotifyEvent read FOnVerified write FOnVerified;
    property OnExpired: TNotifyEvent read FOnExpired write FOnExpired;
    procedure Reset;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimReCAPTCHA]);
end;

{ TMedpUnimReCAPTCHA }

constructor TMedpUnimReCAPTCHA.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TMedpUnimReCAPTCHA.JSEventHandler(AEventName: string; AParams: TUniStrings);
var
  IdHttp1: TIdHTTP;
  response: string;
begin
  inherited;
  if AEventName = 'OnCallBack' then
  begin
    IdHttp1:=TIdHTTP.Create(Self);
    try
      response:=IdHttp1.Get('https://www.google.com/recaptcha/api/siteverify?secret=' +
                                FSecretKey + '&response=' +
                                AParams['response'].AsString);

      if Pos('"success": true', response) > 0 then
      begin
        FVerified:=True;
        if Assigned(OnVerified) then OnVerified(Self);
      end
      else
        raise Exception.Create('Validazione ReCAPTCHA lato server fallita');
    finally
      IdHttp1.Free;
    end;
  end
  else if AEventName = 'OnCallBackExpired' then
  begin
    FVerified:=False;
    if Assigned(OnExpired) then OnExpired(Self);
  end;
end;

procedure TMedpUnimReCAPTCHA.LoadCompleted;
begin
  inherited;
  JSCallGlobalDefer(
    JSFunction('',
              'recaptcha = document.getElementById("' + JSName + '_recaptcha");' +
              'if (recaptcha) {grecaptcha.render(recaptcha);}'
              ),
      100
    );
end;

procedure TMedpUnimReCAPTCHA.BeforeLoadCompleted;
var
  sWidth:string;
begin
  inherited;

  {if Trim(FSiteKey) = '' then
  begin
    raise Exception.Create('UniReCAPTCHA : Please Set SiteKey'+ #13#10+
                          ' To Get SiteKey Please Visit : https://www.google.com/recaptcha/admin');
    Exit;
  end;

  if Trim(FSecretKey) = '' then
  begin
    raise Exception.Create('UniReCAPTCHA : Please Set SecretKey'+ #13#10+
                          ' To Get SecretKey Please Visit : https://www.google.com/recaptcha/admin');
    Exit;
  end;}

  StaticHTML:=True;
  JSCode(JSName+'OnCallBack = function(resp) {ajaxRequest('+JSName+', "OnCallBack", {response: resp}) };');
  JSCode(JSName+'OnCallBackExpired = function(resp) {ajaxRequest('+JSName+', "OnCallBackExpired", {}) };');
  sWidth:=StringReplace(FormatFloat('0.00',Width/302),',','.',[rfReplaceAll]);
  Height:=Trunc(76*Width/302);
  HTML.Text:='<div id="' + JSName + '_recaptcha" class="g-recaptcha" data-sitekey="'+FSiteKey+'" data-callback="'+JSName+'OnCallBack" data-expired-callback="'+JSName+'OnCallBackExpired" style="transform:scale('+sWidth+');transform-origin:0 0"	></div>';
end;

procedure TMedpUnimReCAPTCHA.Reset;
begin
  FVerified:=False;
  JSCallGlobal('grecaptcha.reset',[]);
end;

procedure TMedpUnimReCAPTCHA.SetSecretKey(const Value: string);
begin
  if Value <> '' then
    FSecretKey:=Value
  else
    FSecretKey:='invalid';
end;

procedure TMedpUnimReCAPTCHA.SetSiteKey(const Value: string);
begin
  if Value <> '' then
    FSiteKey:=Value
  else
    FSiteKey:='invalid';
end;

initialization
    UniAddJSLibrary('https://www.google.com/recaptcha/api.js', True, [upoPlatformBoth]);
end.
