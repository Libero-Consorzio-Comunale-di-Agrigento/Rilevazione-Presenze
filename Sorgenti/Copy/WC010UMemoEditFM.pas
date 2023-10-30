unit WC010UMemoEditFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, WR010UBase,
  IWCompMemo, meIWMemo, IWCompLabel, meIWLabel,
  C190FunzioniGeneraliWeb, A000UInterfaccia, A000UCostanti, A000USessione, IWAppForm,
  medpIWMessageDlg, IWGlobal, IWCompExtCtrls, IWCompJQueryWidget,A000UMessaggi;

type
  TWC010CtrlFunc = reference to function(const RList: TStrings):Boolean;

  TWC010FMemoEditFM = class(TWR200FBaseFM)
    memValore: TmeIWMemo;
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
  private
    FMyCtrlFunc: TWC010CtrlFunc;
    procedure _Visualizza(const PTitle: String);
  public
    property MyCtrlFunc: TWC010CtrlFunc read FMyCtrlFunc write FMyCtrlFunc;
    procedure Visualizza(TitoloDialog:string); overload; deprecated 'Utilizzare il metodo statico TWC010FMemoEditFM.Visualizza(...)'; // vecchia modalità
    class procedure Visualizza(const PTitle: string; const PWidth: Integer; const PHeight: Integer; PList: TStrings; PParent: TWinControl = nil; const PEdit: Boolean = False; PCtrlFunc: TWC010CtrlFunc = nil); overload;
  end;

implementation

uses
  IWApplication;

{$R *.dfm}

class procedure TWC010FMemoEditFM.Visualizza(const PTitle: string; const PWidth: Integer; const PHeight: Integer; PList: TStrings; PParent: TWinControl = nil; const PEdit: Boolean = False; PCtrlFunc: TWC010CtrlFunc  = nil);
// metodo statico per semplificare la chiamata
var
  LFrame: TWC010FMemoEditFM;
begin
  if PParent = nil then
    PParent:=(GGetWebApplicationThreadVar.ActiveForm as TWR010FBase)
  else if not (PParent is TWR010FBase) then
    raise Exception.CreateFmt('Impossibile visualizzare il frame di visualizzazione su un componente %s (atteso TWR010FBase)',[PParent.ClassName]);

  // istanzia il frame e ne imposta le proprietà
  LFrame:=TWC010FMemoEditFM.Create(PParent);
  LFrame.Title:=PTitle;
  if PParent <> nil then
    LFrame.Parent:=PParent;
  LFrame.Width:=PWidth;
  LFrame.Height:=PHeight;
  LFrame.memValore.Lines.Assign(PList);
  LFrame.memValore.Editable:=PEdit;
  LFrame.btnConferma.Visible:=PEdit;
  LFrame.MyCtrlFunc:=PCtrlFunc;
  LFrame._Visualizza(PTitle);
end;

procedure TWC010FMemoEditFM.Visualizza(TitoloDialog:string);
begin
  _Visualizza(TitoloDialog);
end;

procedure TWC010FMemoEditFM._Visualizza(const PTitle: String);
var
  LHeight: Integer;
const
  WC010_MIN_HEIGHT = 385;
begin
  LHeight:=Height + 35;
  TWR010FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,Self.Width + 35,WC010_MIN_HEIGHT,LHeight,LHeight,PTitle,'#wc010_container',True,True,-1,'','',btnChiudi.HTMLName);
end;

procedure TWC010FMemoEditFM.btnChiudiClick(Sender: TObject);
var RList: TStrings;
    Chiudi: Boolean;
begin
  Chiudi:=True;
  if Sender = btnConferma then
  begin
    RList:=memValore.Lines;
    if Assigned(FMyCtrlFunc) then
      Chiudi:=FMyCtrlFunc(RList);
  end;
  if Chiudi then
    Free;
end;

end.
