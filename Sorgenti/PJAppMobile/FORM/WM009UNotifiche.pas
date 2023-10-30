unit WM009UNotifiche;


//------------------------------------------------------------------------------
// !! NON PIU' UTILIZZATO DOPO RESTYLING MENU PRINCIPALE --------------------------
//------------------------------------------------------------------------------

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniGUIBaseClasses, MedpUnimPanelBase, MedpUnimPanelDisclosure, uniLabel,
  unimLabel, MedpUnimLabel, MedpUnimLabelIcon, A000UInterfaccia;

type
  TWM009FNotifiche = class(TUnimForm)
    MainPanel: TMedpUnimPanelBase;
    pnlGiustificativi: TMedpUnimPanelBase;
    lblDisclGiustificativi: TMedpUnimLabelIcon;
    pnlLblGiustificativi: TMedpUnimPanelBase;
    lblHeaderGiust: TMedpUnimLabel;
    lblNumGiust: TMedpUnimLabel;
    pnlTimbrature: TMedpUnimPanelBase;
    pnlLblTimbrature: TMedpUnimPanelBase;
    lblHeaderTimb: TMedpUnimLabel;
    lblNumTimb: TMedpUnimLabel;
    lblDisclTimbrature: TMedpUnimLabelIcon;
    pnlCedolini: TMedpUnimPanelBase;
    pnlLblCedolini: TMedpUnimPanelBase;
    lblHeaderCedolini: TMedpUnimLabel;
    lblNumCedolini: TMedpUnimLabel;
    lblDisclCedolini: TMedpUnimLabelIcon;
    pnlCambioOrario: TMedpUnimPanelBase;
    pnlLblCambioOrario: TMedpUnimPanelBase;
    lblHeaderCambioOrario: TMedpUnimLabel;
    lblNumCambioOrario: TMedpUnimLabel;
    lblDisclCambioOrario: TMedpUnimLabelIcon;
    pnlMessaggi: TMedpUnimPanelBase;
    pnllblMessaggi: TMedpUnimPanelBase;
    lblHeaderMessaggi: TMedpUnimLabel;
    lblNumMessaggi: TMedpUnimLabel;
    lblDisclMessaggi: TMedpUnimLabelIcon;
    lblNessunaNotifica: TMedpUnimLabel;
    pnlCertificati: TMedpUnimPanelBase;
    pnlLblCertificati: TMedpUnimPanelBase;
    lblHeaderCertificati: TMedpUnimLabel;
    lblNumCertificati: TMedpUnimLabel;
    lblDisclCertificati: TMedpUnimLabelIcon;
    procedure lblDisclGiustificativiClick(Sender: TObject);
    procedure lblDisclTimbratureClick(Sender: TObject);
    procedure lblDisclCedoliniClick(Sender: TObject);
    procedure UnimFormShow(Sender: TObject);
    procedure UnimFormCreate(Sender: TObject);
    procedure lblDisclCambioOrarioClick(Sender: TObject);
    procedure lblDisclMessaggiClick(Sender: TObject);
    procedure lblDisclCertificatiClick(Sender: TObject);
  private
    { Private declarations }
  public
    TagNavigazione: Integer;
  end;

function WM009FNotifiche: TWM009FNotifiche;

implementation

{$R *.dfm}

uses
  uniGUIVars, WM000UMainModule, uniGUIApplication, WM000UServerModule;

function WM009FNotifiche: TWM009FNotifiche;
begin
  Result := TWM009FNotifiche(WM000FMainModule.GetFormInstance(TWM009FNotifiche));
end;

procedure TWM009FNotifiche.UnimFormCreate(Sender: TObject);
begin
  Caption:='<span style="display: flex; align-items: center;"><img src="' + WM000FServerModule.FilesFolderURL + 'favicon/favicon-96x96.png" width="35" height="35"><p>&nbsp&nbspNotifiche</p></span>';
end;

procedure TWM009FNotifiche.UnimFormShow(Sender: TObject);
var SessioneConnessa: Boolean;
begin
  with WM000FMainModule do
  begin
    SessioneConnessa:=SessioneOracle.Connected;
    //se entro con una sessione oracle già connessa, uso quella e non la chiudo al termine
    if not SessioneConnessa then
    begin
      SessioneOracle.Preferences.UseOci7:=False;
      SessioneOracle.LogOn;
      SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
    end;
    try
      Notifiche.AggiornaNotifiche(B110ClientModule, InfoClient, InfoLogin.ParametriLogin, InfoLogin.DatiGenerali, A000SessioneIrisWIN);
    finally
      if not SessioneConnessa then
        SessioneOracle.LogOff;
    end;

    lblNessunaNotifica.Visible:=Notifiche.NumeroNotifiche = 0;

    if Notifiche.RichiesteAssenza > 0 then
    begin
      pnlGiustificativi.Visible:=True;

      if Notifiche.RichiesteAssenza = 1 then
        lblNumGiust.Caption:='1 richiesta'
      else
        lblNumGiust.Caption:=Format('%d richieste',[Notifiche.RichiesteAssenza]);
    end
    else
      pnlGiustificativi.Visible:=False;

    if Notifiche.RichiesteTimbratura > 0 then
    begin
      pnlTimbrature.Visible:=True;

      if Notifiche.RichiesteTimbratura = 1 then
        lblNumTimb.Caption:='1 richiesta'
      else
        lblNumTimb.Caption:=Format('%d richieste',[Notifiche.RichiesteTimbratura]);
    end
    else
      pnlTimbrature.Visible:=False;

    if Notifiche.RichiesteCambioOrario > 0 then
    begin
      pnlCambioOrario.Visible:=True;

      if Notifiche.RichiesteCambioOrario = 1 then
        lblNumCambioOrario.Caption:='1 richiesta'
      else
        lblNumCambioOrario.Caption:=Format('%d richieste',[Notifiche.RichiesteCambioOrario]);
    end
    else
      pnlCambioOrario.Visible:=False;

    if Notifiche.Cedolini > 0 then
    begin
      pnlCedolini.Visible:=True;

      if Notifiche.Cedolini = 1 then
        lblNumCedolini.Caption:='1 cedolino'
      else
        lblNumCedolini.Caption:=Format('%d cedolini',[Notifiche.Cedolini]);
    end
    else
      pnlCedolini.Visible:=False;

    if Notifiche.MessaggiDaLeggere > 0 then
    begin
      pnlMessaggi.Visible:=True;

      if Notifiche.MessaggiDaLeggere = 1 then
        lblNumMessaggi.Caption:='1 messaggio'
      else
        lblNumMessaggi.Caption:=Format('%d messaggi',[Notifiche.MessaggiDaLeggere]);
    end
    else
      pnlMessaggi.Visible:=False;

    if Notifiche.Certificati > 0 then
    begin
      pnlCertificati.Visible:=True;

      if Notifiche.Certificati = 1 then
        lblNumCertificati.Caption:='1 scheda informativa'
      else
        lblNumCertificati.Caption:=Format('%d schede informative',[Notifiche.Certificati]);
    end
    else
      pnlCertificati.Visible:=False;

    TagNavigazione:=0;
  end;
end;

procedure TWM009FNotifiche.lblDisclCedoliniClick(Sender: TObject);
begin
  TagNavigazione:=417;
  ModalResult:=mrOk;
end;

procedure TWM009FNotifiche.lblDisclGiustificativiClick(Sender: TObject);
begin
  TagNavigazione:=407;
  ModalResult:=mrOk;
end;

procedure TWM009FNotifiche.lblDisclMessaggiClick(Sender: TObject);
begin
  TagNavigazione:=445;
  ModalResult:=mrOk;
end;

procedure TWM009FNotifiche.lblDisclTimbratureClick(Sender: TObject);
begin
  TagNavigazione:=419;
  ModalResult:=mrOk;
end;

procedure TWM009FNotifiche.lblDisclCambioOrarioClick(Sender: TObject);
begin
  TagNavigazione:=431;
  ModalResult:=mrOk;
end;

procedure TWM009FNotifiche.lblDisclCertificatiClick(Sender: TObject);
begin
  TagNavigazione:=456;
  ModalResult:=mrOk;
end;

end.
