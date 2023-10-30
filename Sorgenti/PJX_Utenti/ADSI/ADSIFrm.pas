unit ADSIFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ActiveX, A001UADsHlp, A001UActiveDs_TLB,
  A001USSPIValidatePassword, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB,
  Data.Win.ADODB, Vcl.Menus;

type
  TfrmADSI = class(TForm)
    pnlIns: TPanel;
    btnInserisci: TButton;
    edtUsr: TEdit;
    edtDominio: TEdit;
    lstUsr: TListBox;
    ppMnuDelete: TPopupMenu;
    Cancella1: TMenuItem;
    Splitter1: TSplitter;
    lstGrp: TListBox;
    btnConnetti: TButton;
    lblNomeutente: TLabel;
    edtPassword: TEdit;
    lblPassword: TLabel;
    Label1: TLabel;
    btnLogin: TButton;
    Label2: TLabel;
    edtProtocollo: TEdit;
    Label3: TLabel;
    edlTDAPDN: TEdit;
    procedure btnInserisciClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Cancella1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConnettiClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
    dom:IADsContainer;
    procedure LstUserAddToList(disp:IADs);
    procedure LstGroupAddToList(disp:IADs);
  public
    { Public declarations }
  end;

var
  frmADSI: TfrmADSI;

implementation

{$R *.dfm}

procedure TfrmADSI.btnConnettiClick(Sender: TObject);
var
  hr:HREsult;
begin
  hr:=ADsGetObject('WinNT://' + edtDominio.Text, IADsContainer, dom);
  if Failed(hr) then
    raise exception.Create('Errore nella connessione al dominio.');
  dom.Filter:=VarArrayOf(['user']);
  lstUsr.Items.Clear;
  ADsEnumerateObjects(dom, LstUserAddToList);
  dom.Filter:=VarArrayOf(['group']);
  lstGrp.Items.Clear;
  ADsEnumerateObjects(dom, LstGroupAddToList);
  if lstGrp.Items.Count > 0 then
    lstGrp.ItemIndex:=0;
end;

procedure TfrmADSI.btnInserisciClick(Sender: TObject);
var
  hr:HREsult;
  NewObject:IADs;
  User:IADsUser;
  grp:IADsGroup;
  Container:IADsContainer;
begin
  hr:=ADsGetObject('WinNT://' + edtDominio.Text,IADsContainer,Container);
  if Failed(hr) then
    exit;
  NewObject:=Container.Create('User',edtUsr.Text) as IADs;
  NewObject.QueryInterface(IID_IADsUser, User);
  User.SetPassword(edtPassword.Text);
  hr:=AdsGetObject(lstGrp.Items[lstGrp.ItemIndex], IADsGroup, grp);
  if Failed(hr) then
    Exit;
  User.SetInfo;
  //============================================================================
  grp.Add(user.ADsPath);
  //============================================================================
  dom.Filter:=VarArrayOf(['user']);
  lstUsr.Items.Clear;
  ADsEnumerateObjects(dom, LstUserAddToList);
  Container._Release;
  NewObject._Release;
  grp._Release;
  User._Release;
end;

procedure TfrmADSI.btnLoginClick(Sender: TObject);
var
  hr:integer;
  Result:Boolean;
  AdsOO:Integer;
  Obj:IADs;
  dom:IADsContainer;
  lUser:String;
begin
  Result:=False;
  if edtProtocollo.Text = 'NTLM' then
    Result:=SSPLogonUser(edtDominio.Text, edtUsr.Text, edtPassword.Text)
  else if edtProtocollo.Text = 'AD' then
  begin
     if (not IsLibrary) then
       CoInitialize(nil);
     try
       ADsOO:=ADsOpenObject('WinNT://'+edtDominio.Text,edtUsr.Text,edtPassword.Text,ADS_SECURE_AUTHENTICATION,IADs,Obj);
       Result:=Succeeded(ADsOO);
     except
       Result:=False;
     end;
     if (not IsLibrary) then
       CoUninitialize;
  end
  else if edtProtocollo.Text = 'LDAP' then
  begin
     if (not IsLibrary) then
       CoInitialize(nil);
     try
       if Pos(':nome_utente',LowerCase(edlTDAPDN.Text)) = 0 then
         ADsOO:=ADsOpenObject('LDAP://' + edtDominio.Text,edtUsr.Text,edtPassword.Text,ADS_SECURE_AUTHENTICATION,IADs,dom)
       else
       begin
         lUser:=StringReplace(edlTDAPDN.Text,':nome_utente',edtUsr.Text,[rfIgnoreCase]);
         ADsOO:=ADsOpenObject('LDAP://' + edtDominio.Text,lUser,edtPassword.Text,0,IADs,dom)
       end;
       Result:=ADsOO = S_OK;
     except
       Result:=False;
     end;
     if (not IsLibrary) then
       CoUninitialize;
  end;
  (*
  if False then
    HR:=ADsOpenObject('LDAP://' + edtDominio.Text, edtUsr.Text , edtPassword.Text, ADS_SECURE_AUTHENTICATION , IADs, dom)
  else
    HR:=ADsOpenObject('LDAP://' + edtDominio.Text, edtUsr.Text , edtPassword.Text, 0, IADs, dom);
  if HR = S_OK then
  //if Succeeded(HR) then
  begin
    ShowMessage('Connessione OK');
  end
  else
  begin
    ShowMessage(Format('Errore: %d', [HR]));
  end;
  *)
  if Result then
  begin
    ShowMessage('Connessione OK');
  end
  else
  begin
    ShowMessage(Format('Errore: %d', [ADsOO]));
  end;
end;

procedure TfrmADSI.Cancella1Click(Sender: TObject);
var
  hr:HREsult;
  Container:IADsContainer;
begin
  //CoInitialize(nil);
  hr:=ADsGetObject('WinNT://' + edtDominio.Text,IADsContainer,Container);
  if Failed(hr) then
    exit;
  Container.Delete('User',lstUsr.Items[lstUsr.ItemIndex]);
  dom.Filter:=VarArrayOf(['user']);
  lstUsr.Items.Clear;
  ADsEnumerateObjects(dom, LstUserAddToList);
  Container._Release;
  //CoUninitialize;
end;

procedure TfrmADSI.LstUserAddToList(disp:IADs);
begin
  lstUsr.Items.Add(disp.Name);
end;

procedure TfrmADSI.LstGroupAddToList(disp:IADs);
begin
  lstGrp.Items.Add(disp.ADsPath);
end;

procedure TfrmADSI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CoUninitialize;
end;

procedure TfrmADSI.FormShow(Sender: TObject);
begin
  CoInitialize(nil);
end;

end.
