unit WA080UTabLayoutFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM,WR100UBase, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,C190FunzioniGeneraliWeb, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, meIWButton;

type
  TWA080ModalResultEvents = procedure(Sender: TObject) of object;

  TWA080FTabLayoutFM = class(TWR205FDettTabellaFM)
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
    ResultEvent:TWA080ModalResultEvents;
    procedure Visualizza(Title:String);
  end;

implementation

{$R *.dfm}

procedure TWA080FTabLayoutFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if Assigned(ResultEvent) then
  try
    ResultEvent(Sender);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
  FreeAndNil(Self);
end;

procedure TWA080FTabLayoutFM.Visualizza(Title: String);
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,700,-1,EM2PIXEL * 30, Title,'#wa080_container',False,True);
end;


end.
