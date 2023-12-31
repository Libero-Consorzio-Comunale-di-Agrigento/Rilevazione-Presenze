unit RegolePassword;

interface

uses
  SysUtils, StrUtils, Math, Classes, (*Forms, Controls,*)
  (*FunzioniGenerali,*)
  A000UMessaggi;

type
  TRegolePassword = class(TComponent)
  private
    { Private declarations }
    function CtrlCriptazione(const S: String): Boolean;
  public
    { Public declarations }
    MesiValidita,
    Lunghezza,
    Cifre,
    Maiuscole,
    CarSpeciali:Word;
    PasswordI060:Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(APersistent: TPersistent); override;
    function PasswordValida(Password:String):String;
    function PasswordScaduta(NuovaPwd:Boolean; DataPwd:TDateTime):Boolean;
  end;

implementation

uses
  FunzioniGenerali;

procedure TRegolePassword.Assign(APersistent: TPersistent);
begin
  if APersistent is TRegolePassword then
  begin
    MesiValidita:=TRegolePassword(APersistent).MesiValidita;
    Lunghezza:=TRegolePassword(APersistent).Lunghezza;
    Cifre:=TRegolePassword(APersistent).Cifre;
    Maiuscole:=TRegolePassword(APersistent).Maiuscole;
    CarSpeciali:=TRegolePassword(APersistent).CarSpeciali;
    PasswordI060:=TRegolePassword(APersistent).PasswordI060;
  end
  else
    inherited Assign(APersistent);
end;

procedure TRegolePassword.Clear;
begin
  MesiValidita:=0;
  Lunghezza:=0;
  Cifre:=0;
  Maiuscole:=0;
  PasswordI060:=True;
end;

constructor TRegolePassword.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Clear;
end;

destructor TRegolePassword.Destroy;
begin
  inherited Destroy;
end;

function TRegolePassword.CtrlCriptazione(const S: String): Boolean;
{Verifica se la password indicata pu� essere criptata dalla funzione R180Cripta.
 In pratica verifica che ogni carattere abbia un codice
 ASCII compreso fra 32 e 126 (caratteri ASCII standard stampabili)
}
var
  i: Integer;
begin
  Result:=True;
  for i:=1 to Length(S) do
    if (Ord(S[i]) < 32) or (Ord(S[i]) > 126) then
    begin
      Result:=False;
      Break;
    end;
end;

function TRegolePassword.PasswordValida(Password:String):String;
var
  c_NumCifre,c_NumCarSpeciali,c_numUpper,i:Integer;
begin
  c_NumCifre:=0 ;
  c_NumCarSpeciali:=0;
  c_numUpper:=0;
  Result:='';

  if Length(Password) < Lunghezza then
  begin
    Result:=Format(A000MSG_ERR_FMT_PWD_LUNGHEZZA,[Lunghezza]);
    exit;
  end;

  for i:=1 to Length(Password) do
  begin
    c_NumCifre:=c_NumCifre + ifthen(TFunzioniGenerali.(*R180*)IsDigit(Password[i]),1,0);
    c_NumCarSpeciali:=c_NumCarSpeciali + ifthen(TFunzioniGenerali.IsNewSpecialChar(Password[i]),1,0);
    c_numUpper:=c_numUpper + ifthen((not TFunzioniGenerali.(*R180*)IsDigit(Password[i]) and (Password[i]=UpCase(Password[i]))),1,0);
  end;

  if c_numUpper < Maiuscole  then
  begin
    Result:=Format(A000MSG_ERR_FMT_PWD_MAIUSCOLE,[Maiuscole]);
    exit;
  end;

  if c_NumCifre < Cifre  then
  begin
    Result:=Format(A000MSG_ERR_FMT_PWD_CIFRE,[Cifre]);
    exit;
  end;

  if c_NumCarSpeciali < CarSpeciali  then
  begin
    Result:=Format(A000MSG_ERR_FMT_PWD_CARATTERI_SPECIALI,[CarSpeciali]);
    exit;
  end;

  if PasswordI060 and (not CtrlCriptazione(Password)) then
    Result:=A000MSG_ERR_PWD_CARATTERI_NON_AMMESSI;
end;

function TRegolePassword.PasswordScaduta(NuovaPwd:Boolean; DataPwd:TDateTime):Boolean;
begin
  Result:=NuovaPwd or ((MesiValidita > 0) and (TFunzioniGenerali.(*R180*)AddMesi(DataPwd,MesiValidita) <= Date));
end;

end.
