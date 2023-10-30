unit WA062UAccessoDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer,IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion,WR100UBase,C190FunzioniGeneraliWeb, IWCompEdit, meIWEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompExtCtrls, meIWImageFile, medpIWImageButton;
type
  TWA62ModalResultEvents = procedure(Sender: TObject; Result: Boolean) of object;


  TWA062FAccessoDB = class(TWR200FBaseFM)
    lblUser: TmeIWLabel;
    edtUser: TmeIWEdit;
    lblPassword: TmeIWLabel;
    edtPassword: TmeIWEdit;
    btnConferma: TmedpIWImageButton;
    btnAnnulla: TmedpIWImageButton;
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnConfermaClick(Sender: TObject);
  private
    { Private declarations }
  public
    ResultEvent:TWA62ModalResultEvents;
    procedure Visualizza;
    procedure SetUsername(username :String);
    function GetPassword:String;
  end;

implementation

{$R *.dfm}

procedure TWA062FAccessoDB.btnAnnullaClick(Sender: TObject);
begin
 if Assigned(ResultEvent) then
  try
    ResultEvent(Sender,False);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
end;

procedure TWA062FAccessoDB.btnConfermaClick(Sender: TObject);
begin
  if Assigned(ResultEvent) then
  try
    ResultEvent(Sender,True);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
end;

procedure TWA062FAccessoDB.SetUsername(username :String);
begin
  edtUser.Text:=username;
end;

function TWA062FAccessoDB.GetPassword:String;
begin
  Result:=edtPassword.Text;
end;

procedure TWA062FAccessoDB.Visualizza;
begin
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,310,200,EM2PIXEL * 30, 'Accesso al DB','#wa062DbFM_container',False,True);
end;

end.
