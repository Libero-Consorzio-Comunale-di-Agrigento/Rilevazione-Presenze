unit WA186ULoginDipendentiCambioPasswordFM;

interface

uses
  C190FunzioniGeneraliWeb, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompEdit, meIWEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, IWDBStdCtrls, meIWDBLabel, IWCompButton,
  meIWButton, WR100UBase, medpIWMessageDlg, C180FunzioniGenerali,
  IWCompJQueryWidget, A000UMessaggi, RegolePassword,A000UInterfaccia;

type
  TWA186ModalResultEvents = procedure(Sender: TObject; DialogResult: Boolean; ResultValue: string) of object;

  TWA186FLoginDipendentiCambioPasswordFM = class(TWR200FBaseFM)
    lblPasswordAttuale: TmeIWLabel;
    lblNuovaPassword: TmeIWLabel;
    lblConfermaPassword: TmeIWLabel;
    edtPasswordAttuale: TmeIWEdit;
    edtNuovaPassword: TmeIWEdit;
    edtConfermaPassword: TmeIWEdit;
    btnConferma: TmeIWButton;
    btnAnnulla: TmeIWButton;
    lblScadenza: TmeIWDBLabel;
    procedure btnClick(Sender: TObject);
  private
    OldPassword:String;
    LunghezzaPassword:Integer;
    IsNullDominioD:Boolean;
  public
    ResultEvent:TWA186ModalResultEvents;
    procedure Visualizza(VecchiaPassword:String; MinCaratteri:Integer; DominioDip:Boolean);
  end;

implementation

uses WA186ULoginDipendentiDM;

{$R *.dfm}

procedure TWA186FLoginDipendentiCambioPasswordFM.Visualizza(VecchiaPassword:String; MinCaratteri:Integer; DominioDip:Boolean);
begin
  IsNullDominioD:=DominioDip;
  OldPassword:=VecchiaPassword;
  LunghezzaPassword:=MinCaratteri;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,300,-1,EM2PIXEL * 30,'Cambio password','#wa186_container',False,True);
end;

procedure TWA186FLoginDipendentiCambioPasswordFM.btnClick(Sender: TObject);
var
  S:String;
  Result:Boolean;
  RegolePassword:TRegolePassword;
begin
  if Sender = btnConferma then
  begin
    Result:=True;

    if edtPasswordAttuale.Visible then
      if R180Cripta(edtPasswordAttuale.Text,30011945) <> OldPassword then
        MsgBox.WebMessageDlg(A000MSG_A186_ERR_PWD_ERRATA,mtInformation,[mbOK],nil,'');

    if edtNuovaPassword.Text <> edtConfermaPassword.Text then
    begin
      MsgBox.WebMessageDlg(A000MSG_A186_ERR_DLG_PWD,mtInformation,[mbOK],nil,'');
      // controllo caratteri password per crittografia su db - daniloc. 26.01.2011
      Exit;
    end
    else if (IsNullDominioD) or (Length(edtNuovaPassword.Text) > 0) then
    begin
      try
        RegolePassword:=TRegolePassword.Create(nil);
        with TWA186FLoginDipendentiDM(WR302DM).QI090 do
        begin
          RegolePassword.PasswordI060:=True;
          RegolePassword.MesiValidita:=FieldByName('VALID_PASSWORD').AsInteger;
          RegolePassword.Lunghezza:=FieldByName('LUNG_PASSWORD').AsInteger;
          RegolePassword.Cifre:=FieldByName('PASSWORD_CIFRE').AsInteger;
          RegolePassword.Maiuscole:=FieldByName('PASSWORD_MAIUSCOLE').AsInteger;
          RegolePassword.CarSpeciali:=FieldByName('PASSWORD_CARSPECIALI').AsInteger;
          S:=RegolePassword.PasswordValida(edtNuovaPassword.Text);
        end;
      finally
        FreeAndNil(RegolePassword);
      end;
      if S <> '' then
      begin
        MsgBox.WebMessageDlg(S,mtInformation,[mbOK],nil,'');
        Exit;
      end;
    end;
  end
  else     //btnAnnulla
    Result:=False;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Result, R180Cripta(edtConfermaPassword.Text,30011945));
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
  Free;
end;

end.
