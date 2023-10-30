unit WM000UTypes;

interface

uses SysUtils;

type
  TAbilitazioneMenu = record
    RichiedeFiltroIndividuale: Boolean;
    RichiedeProfiloResp: Boolean;
    function IsOk(const PFiltroIndividuale, PProfiloResp: Boolean): Boolean;
  end;

  TFunzioneMenu = record
    Tag: Integer;
    S: String;
    Classe: String;
    Titolo: String;
    Abilitazione: TAbilitazioneMenu;
  end;

implementation

{ TAbilitazioneMenu }

function TAbilitazioneMenu.IsOk(const PFiltroIndividuale, PProfiloResp: Boolean): Boolean;
begin
  Result:=((not RichiedeFiltroIndividuale) or PFiltroIndividuale) and
          ((not RichiedeProfiloResp) or PProfiloResp);
end;

end.
