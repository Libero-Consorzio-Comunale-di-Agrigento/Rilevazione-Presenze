unit WC007UFormContainerFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM,WR100UBase, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,C190FunzioniGeneraliWeb, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, meIWButton;

type
  TWA080ModalResultEvents = procedure(Sender: TObject) of object;

  TWC007FFormContainerFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    ResultEvent:TWA080ModalResultEvents;
    PopupHeigth, PopupWidth:Integer;
    procedure Visualizza(Title:String);
  end;

implementation

{$R *.dfm}

procedure TWC007FFormContainerFM.btnChiudiClick(Sender: TObject);
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

procedure TWC007FFormContainerFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  PopupWidth:=-1;
  PopupHeigth:=-1;
end;

procedure TWC007FFormContainerFM.Visualizza(Title: String);
var
  LWidth: Integer;
  LHeight: Integer;
begin
  LWidth:=StrToInt(ifThen(PopupWidth >= 0,IntToStr(PopupWidth),'700'));   // conversioni superflue ma mantenuto per evitare problemi
  LHeight:=StrToInt(ifThen(PopupHeigth >= 0,IntToStr(PopupHeigth),'-1')); // conversioni superflue ma mantenuto per evitare problemi

  // visualizza il frame con il pulsante di chiusura in alto
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,LWidth,LHeight,EM2PIXEL * 30, Title,'#wc007_container',True,True,-1,'','',btnChiudi.HTMLName);
end;


end.
