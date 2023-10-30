unit WM002UInfo;

interface

uses
  WM000UTypes,
  WM000UConstants,
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniLabel, unimLabel, uniGUIBaseClasses, uniMultiItem, unimSelect, uniButton,
  unimButton, unimPanel, MedpUnimPanelBase, MedpUnimLabel, MedpUnimPanel2Labels,
  MedpUnimSelect, uniBitBtn, unimBitBtn, MedpUnimButton, A000UCostanti, A000UInterfaccia,
  MedpUnimPanelEdit, MedpUnimPanelCheckBox, WM001UCambioPasswordMW;

type
  TWM002FInfo = class(TUnimForm)
    pnlDatiGenerali: TMedpUnimPanelBase;
    pnlMatricola: TMedpUnimPanel2Labels;
    pnlNominativo: TMedpUnimPanel2Labels;
    pnlAzienda: TMedpUnimPanel2Labels;
    pnlProfilo: TMedpUnimPanelBase;
    lblProfilo: TMedpUnimLabel;
    pnlCmbProfilo: TMedpUnimPanelBase;
    cmbProfilo: TMedpUnimSelect;
    btnCambioProfilo: TMedpUnimButton;
    pnlGestionePassword: TMedpUnimPanelBase;
    pnlHeaderPassword: TMedpUnimPanelBase;
    lblPassword: TMedpUnimLabel;
    btnEditPassword: TMedpUnimButton;
    btnOkPassword: TMedpUnimButton;
    btnAnnullaPassword: TMedpUnimButton;
    edtPasswordAttuale: TMedpUnimPanelEdit;
    edtNuovaPassword: TMedpUnimPanelEdit;
    edtConfermaPassword: TMedpUnimPanelEdit;
    btnLogout: TMedpUnimButton;
    lblVersione: TMedpUnimLabel;
    pnlContatti: TMedpUnimPanelBase;
    pnlHeaderContatti: TMedpUnimPanelBase;
    lblContatti: TMedpUnimLabel;
    btnEditContatti: TMedpUnimButton;
    btnOkContatti: TMedpUnimButton;
    btnAnnullaContatti: TMedpUnimButton;
    chkRicezioneEmail: TMedpUnimPanelCheckBox;
    edtEmail: TMedpUnimPanelEdit;
    edtEmailPEC: TMedpUnimPanelEdit;
    edtCellulare: TMedpUnimPanelEdit;
    procedure UnimFormCreate(Sender: TObject);
    procedure cmbProfiloChange(Sender: TObject);
    procedure btnCambioProfiloClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure UnimFormDestroy(Sender: TObject);
    procedure btnEditPasswordClick(Sender: TObject);
    procedure btnEditContattiClick(Sender: TObject);
    procedure btnOkPasswordClick(Sender: TObject);
    procedure btnAnnullaPasswordClick(Sender: TObject);
    procedure btnOkContattiClick(Sender: TObject);
    procedure btnAnnullaContattiClick(Sender: TObject);
    procedure UnimFormClose(Sender: TObject; var Action: TCloseAction);
    procedure UnimFormShow(Sender: TObject);
  private
    FIdxProfiloCorrente: Integer;
    WM001MW: TWM001FCambioPasswordMW;
    SessioneConnessa: Boolean;
    FObbligoCambioPassword: Boolean;

    procedure ClearCookies;
    procedure EditPassword(AbilitaEdit: Boolean);
    procedure EditContatti(AbilitaEdit: Boolean);
    procedure SetObbligoCambioPassword(const Value: Boolean);
  public
    property ObbligoCambioPassword: Boolean read FObbligoCambioPassword write SetObbligoCambioPassword;
  end;

function WM002FInfo: TWM002FInfo;

implementation

uses
  WM000UMainModule,
  WM000UServerModule,
  uniGUIVars,
  uniGUIApplication;

{$R *.dfm}

function WM002FInfo: TWM002FInfo;
begin
  Result:=TWM002FInfo(WM000FMainModule.GetFormInstance(TWM002FInfo));
end;

procedure TWM002FInfo.UnimFormClose(Sender: TObject; var Action: TCloseAction);
begin
  if FObbligoCambioPassword then
    Action:=TCloseAction.caNone;
end;

procedure TWM002FInfo.UnimFormCreate(Sender: TObject);
var
  LProfilo: String;
begin
  with WM000FMainModule do
  begin
    Caption:='<span style="display: flex; align-items: center;"><img src="' + WM000FServerModule.FilesFolderURL + 'favicon/favicon-96x96.png" width="35" height="35"><p>&nbsp&nbspGestione utente</p></span>';

    with WM000FMainModule.InfoClient.VersioneApp do
      lblVersione.Caption:='IrisAPP - Versione ' + Versione + '(' + Build+  ')';
    pnlAzienda.Label2.Caption:=InfoLogin.DatiGenerali.Parametri.RagioneSociale;
    pnlMatricola.Label2.Caption:=InfoLogin.DatiGenerali.DatiAnagraficiUtente.Matricola;
    pnlNominativo.Label2.Caption:=InfoLogin.DatiGenerali.DatiAnagraficiUtente.Nome + ' ' + InfoLogin.DatiGenerali.DatiAnagraficiUtente.Cognome;

    // popola combobox con l'elenco dei profili disponibili
    cmbProfilo.Clear;
    for LProfilo in InfoLogin.DatiGenerali.ProfiliArr do
      cmbProfilo.Add(LProfilo, '');

    cmbProfilo.Enabled:=cmbProfilo.Items.Count > 1;
    cmbProfilo.ItemIndex:=cmbProfilo.IndexOfCode(InfoLogin.DatiGenerali.Profilo);
    FIdxProfiloCorrente:=cmbProfilo.ItemIndex;
    cmbProfilo.Visible:=True;
  end;

  // il pulsante di cambio profilo si abilita solo selezionando un profilo diverso dal corrente
  btnCambioProfilo.Enabled:=False;
  btnLogout.Visible:=UniApplication.Cookies.GetCookie(COOKIE_AZIENDA) <> '';

  if WM000FMainModule.InfoLogin.DatiGenerali.GetAbilitazioneTag(415) = 'S' then  //funzione gestione sicurezza abilitata
  begin
    //il cambio password è visibile solo se non è previsto un login esterno o l'autenticazione su dominio
    pnlGestionePassword.Visible:=not ((WM000FServerModule.ParConfig.LoginEsterno = 'S') or A000SessioneIrisWIN.Parametri.AuthDom);
    pnlContatti.Visible:=True;
  end
  else
  begin
    pnlGestionePassword.Visible:=False;
    pnlContatti.Visible:=False;
  end;

  SessioneConnessa:=SessioneOracle.Connected;
  if not SessioneConnessa then
  begin
    SessioneOracle.Preferences.UseOci7:=False;
    SessioneOracle.LogOn;
    SessioneOracle.UseOCI80:=not SessioneOracle.Preferences.UseOci7;
  end;

  WM001MW:=TWM001FCambioPasswordMW.Create(A000SessioneIrisWIN, WM000FServerModule.ParConfig.LoginEsterno);

  EditContatti(False);
  EditPassword(False);
end;

procedure TWM002FInfo.UnimFormDestroy(Sender: TObject);
begin
  if not SessioneConnessa then
    SessioneOracle.LogOff;

  FreeAndNil(WM001MW);
end;

procedure TWM002FInfo.UnimFormShow(Sender: TObject);
begin
  if FObbligoCambioPassword then
    UniSession.AddJS('Ext.toast({message: "<i class=''fas fa-exclamation-triangle fa-4x'' style=''color: #157fcc;''></i><br><p style=''font-size:18px; margin-left: 5px; margin-right: 5px;''>  E'' necessario cambiare la password  </p>", timeout: 5000}); ');
end;

procedure TWM002FInfo.cmbProfiloChange(Sender: TObject);
begin
  btnCambioProfilo.Enabled:=cmbProfilo.ItemIndex <> FIdxProfiloCorrente;
end;

procedure TWM002FInfo.EditContatti(AbilitaEdit: Boolean);
begin
  cmbProfilo.Enabled:=not AbilitaEdit;
  btnCambioProfilo.Enabled:=(cmbProfilo.ItemIndex <> FIdxProfiloCorrente) and (not AbilitaEdit);
  btnEditPassword.Enabled:=not AbilitaEdit;
  btnLogOut.Enabled:=not AbilitaEdit;

  btnEditContatti.Visible:=not AbilitaEdit;
  btnOkContatti.Visible:=AbilitaEdit;
  btnAnnullaContatti.Visible:=AbilitaEdit;

  chkRicezioneEmail.CheckBox.CheckIcon.ReadOnly:=not AbilitaEdit;
  edtEmail.Edit.ReadOnly:=not AbilitaEdit;
  edtEmailPEC.Edit.ReadOnly:=not AbilitaEdit;
  edtCellulare.Edit.ReadOnly:=not AbilitaEdit;

  if not AbilitaEdit then
  begin
    chkRicezioneEmail.CheckBox.CheckIcon.Checked:=WM001MW.RicezioneMail;
    edtEmail.Edit.Text:=WM001MW.EMail;
    edtEmailPEC.Edit.Text:=WM001MW.EMailPEC;
    edtCellulare.Edit.Text:=WM001MW.Cellulare;
  end;
end;

procedure TWM002FInfo.EditPassword(AbilitaEdit: Boolean);
begin
  cmbProfilo.Enabled:=not AbilitaEdit;
  btnCambioProfilo.Enabled:=(cmbProfilo.ItemIndex <> FIdxProfiloCorrente) and (not AbilitaEdit);
  btnEditContatti.Enabled:=not AbilitaEdit;
  btnLogOut.Enabled:=not AbilitaEdit;

  btnEditPassword.Visible:=not AbilitaEdit;
  btnOkPassword.Visible:=AbilitaEdit;
  btnAnnullaPassword.Visible:=AbilitaEdit;

  edtPasswordAttuale.Edit.ReadOnly:=not AbilitaEdit;
  edtNuovaPassword.Edit.ReadOnly:=not AbilitaEdit;
  edtConfermaPassword.Edit.ReadOnly:=not AbilitaEdit;

  edtPasswordAttuale.Edit.Text:='';
  edtNuovaPassword.Edit.Text:='';
  edtConfermaPassword.Edit.Text:='';
end;

procedure TWM002FInfo.SetObbligoCambioPassword(const Value: Boolean);
begin
  FObbligoCambioPassword:=Value;

  if FObbligoCambioPassword then
  begin
    EditPassword(True);
    pnlGestionePassword.Visible:=True; //cambio password visibile anche se tag gestione sicurezza non abilitato
    pnlContatti.Visible:=False;
    btnLogout.Visible:=False;
    pnlProfilo.Visible:=False;
  end;
end;

procedure TWM002FInfo.btnCambioProfiloClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  with WM000FMainModule do
  begin
    LResCtrl:=InfoLogin.LoginB110(B110ClientModule,
                              InfoClient,
                              InfoLogin.ParametriLogin.Azienda,
                              InfoLogin.ParametriLogin.Utente,
                              InfoLogin.ParametriLogin.Password,
                              cmbProfilo.ListaCodici[cmbProfilo.ItemIndex]);
  end;

  if LResCtrl.Ok then
    ModalResult:=mrOk
  else
    ShowMessage('Errore nel cambiamento del profilo: ' + LResCtrl.Messaggio);
end;

procedure TWM002FInfo.btnLogoutClick(Sender: TObject);
begin
  ClearCookies;
  UniSession.Logout;
end;

procedure TWM002FInfo.btnOkContattiClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  LResCtrl:=WM001MW.AggiornaContatti(edtEmail.Edit.Text,
                                     edtEmailPec.Edit.Text,
                                     edtCellulare.Edit.Text,
                                     chkRicezioneEmail.CheckBox.CheckIcon.Checked);
  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio)
  else
    EditContatti(False);
end;

procedure TWM002FInfo.btnOkPasswordClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  LResCtrl:=WM001MW.AggiornaPassword(edtNuovaPassword.Edit.Text,
                                     edtConfermaPassword.Edit.Text,
                                     edtPasswordAttuale.Edit.Text);
  if not LResCtrl.Ok then    //cambio password non andato a buon fine
  begin
    ShowMessage(LResCtrl.Messaggio);
    edtNuovaPassword.Edit.Text:='';
    edtConfermaPassword.Edit.Text:='';
  end
  else
  begin
    WM000FMainModule.InfoLogin.ParametriLogin.Password:=edtNuovaPassword.Edit.Text; //necessaria per un cambio profilo successivo
    ClearCookies;
    btnLogout.Visible:=False; //ho già eliminato i cookies con la vecchia password!!
    EditPassword(False);
    ShowMessage('La password è stata modificata correttamente');

    if FObbligoCambioPassword then  //se sono sul cambio di password obbligatorio, chiudo
    begin
      FObbligoCambioPassword:=False;
      Close;
    end;
  end;
end;

procedure TWM002FInfo.btnEditContattiClick(Sender: TObject);
begin
  EditContatti(True);
end;

procedure TWM002FInfo.btnAnnullaContattiClick(Sender: TObject);
begin
  EditContatti(False);
end;

procedure TWM002FInfo.btnEditPasswordClick(Sender: TObject);
begin
  EditPassword(True);
end;

procedure TWM002FInfo.btnAnnullaPasswordClick(Sender: TObject);
begin
  EditPassword(False);
end;

procedure TWM002FInfo.ClearCookies;
begin
  with UniApplication.Cookies do
  begin
    SetCookie(COOKIE_AZIENDA, '', Date-10);
    SetCookie(COOKIE_UTENTE, '', Date-10);
    SetCookie(COOKIE_PASSWORD, '', Date-10);
    SetCookie(COOKIE_TOKEN, '', Date-10);
    SetCookie(COOKIE_OAUTH2_ACCESSTOKEN, '', Date-10);
    SetCookie(COOKIE_OAUTH2_REFRESHTOKEN, '', Date-10);
    SetCookie(COOKIE_OAUTH2_TOKENTYPE, '', Date-10);
  end;
end;

end.
