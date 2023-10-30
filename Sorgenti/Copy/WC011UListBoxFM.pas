unit WC011UListboxFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompListbox, meIWListbox, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR100UBase, Math, StrUtils,
  medpIWMessageDlg, IWCompJQueryWidget,A000UMessaggi,A000UInterfaccia;

type
  TWC011ModalResultEvents = procedure(Sender: TObject; DialogResult: Boolean; ResultValue: string) of object;

  TWC011FListboxFM = class(TWR200FBaseFM)
    btnOk: TmeIWButton;
    btnAnnulla: TmeIWButton;
    lstValori: TmeIWListbox;
    procedure btnClick(Sender: TObject);
  private
    { Private declarations }
  public
    ResultEvent:TWC011ModalResultEvents;
    procedure Visualizza(const TitoloDialog:string = 'Scelta valore campo');
  end;

implementation

{$R *.dfm}

procedure TWC011FListboxFM.Visualizza(const TitoloDialog:string);
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,Self.Width + 35,-1,Self.Height + 30, TitoloDialog,'#wc011_container',False,True);
end;

procedure TWC011FListboxFM.btnClick(Sender: TObject);
var
  Result:Boolean;
  Value:String;
begin
  Result:=False;
  TWR100FBase(Self.Parent).ActiveControl:=nil;

  Value:='';
  if Sender = btnOk then
  begin
    if lstValori.ItemIndex > -1 then
    begin
      Result:=True;
      Value:=lstValori.Items[lstValori.ItemIndex];
    end
    else
      MsgBox.WebMessageDlg(A000MSG_ERR_SELEZIONARE_ELEMENTO,mtInformation,[mbOK],nil,'');
  end;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Self,Result,Value);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
  Free;
end;

end.
