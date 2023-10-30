unit W045UCambioAzienda;

interface

uses
  A000UCostanti,
  A000USessione,
  A000UInterfaccia,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  R010UPaginaWeb,
  System.SysUtils, System.Classes, IWVCLComponent, IWApplication,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, IWCompButton, meIWButton, Vcl.Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompListbox, meIWComboBox;

type
  TW045FCambioAzienda = class(TR010FPaginaWeb)
    lblAziendaCorrente: TmeIWLabel;
    edtAziendaCorrente: TmeIWEdit;
    lblAziendaNuova: TmeIWLabel;
    cmbAziendaNuova: TmeIWComboBox;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    procedure btnConfermaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnAnnullaClick(Sender: TObject);
  private
    procedure PopolaComboAziende;
  end;

implementation

uses W001UIrisWebDtM;

{$R *.dfm}

procedure TW045FCambioAzienda.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  medpModale:=True;

  // propone il nome del profilo da associare
  edtAziendaCorrente.Text:=Parametri.Azienda;

  // popola la combo delle aziende
  PopolaComboAziende;

  // imposta hidden fields da inviare via post
  HiddenFields.Add('azienda=');
  HiddenFields.Add('usr=');
  HiddenFields.Add('pwd=');
  HiddenFields.Add('xusr=');
  HiddenFields.Add('database=' + Parametri.Database);
  HiddenFields.Add('loginesterno=S');
end;

procedure TW045FCambioAzienda.PopolaComboAziende;
var
  LLstAziende: TStringList;
begin
  LLstAziende:=TStringList.Create;
  try
    WR000DM.GetElencoCambioAziende(LLstAziende);
    cmbAziendaNuova.Items.Assign(LLstAziende);
    cmbAziendaNuova.ItemIndex:=0;
  finally
    FreeAndNil(LlstAziende);
  end;
end;

procedure TW045FCambioAzienda.btnConfermaAsyncClick(Sender: TObject; EventParams: TStringList);
var
  AzioneForm,S,Usr:String;
begin
  //Criptatura RDL con parametri fissi
  Usr:=R180SSO_TokenUsr(Parametri.Operatore,A000SSO_UsrMask);
  Usr:=R180RDL_ECB_Encrypt(Usr,A000SSO_RDLPassphrase);

  // L'URL indica a IW di creare una nuova sessione per gestire questa richiesta
  if not IsLibrary then
    AzioneForm:='/$/start'
  else
    AzioneForm:=C190IncludeEndingSlash(GGetWebApplicationThreadVar.InternalUrlBase) + 'start';

  // imposta la nuova azienda
  // quindi effettua un submit della form SubmitForm con il metodo
  // normale SubmitClick
  S:='var formIris = document.forms["SubmitForm"]; ' +
     'formIris.setAttribute("action","' + AzioneForm + '"); ' +
     'document.getElementById("HIDDEN_xusr").value = "' + Usr + '"; ' + //pwd non serve: lo usr viene passato sempre criptato in RDL
     'document.getElementById("HIDDEN_azienda").value = "' + cmbAziendaNuova.Text + '"; ' +
     'formIris.elements["IW_SessionID_"].value="";' +
     'formIris.elements["IW_TrackID_"].value="";' +
     'SubmitClick("' + btnConferma.HTMLName + '", "", true); ';

  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(S);

  // tentativo per ridurre il timeout della attuale sessione, che non è più usata
  GGetWebApplicationThreadVar.SessionTimeOut:=2;
end;

procedure TW045FCambioAzienda.btnAnnullaClick(Sender: TObject);
begin
  ClosePage;
end;

end.
