unit WA107UInsAssAutoRegole;

interface

uses WR102UGestTabella, Classes, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, Controls, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA107FInsAssAutoRegole = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA107UInsAssAutoRegoleDM, WA107UInsAssAutoRegoleBrowseFM, WA107UInsAssAutoRegoleDettFM;

{$R *.dfm}

procedure TWA107FInsAssAutoRegole.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA107FInsAssAutoRegoleDM.Create(Self);
  WBrowseFM:=TWA107FInsAssAutoRegoleBrowseFM.Create(Self);
  WDettaglioFM:=TWA107FInsAssAutoRegoleDettFM.Create(Self);
  CreaTabDefault;
  (WDettaglioFM as TWA107FInsAssAutoRegoleDettFM).AbilitaComponenti(False);
end;

procedure TWA107FInsAssAutoRegole.actModificaExecute(Sender: TObject);
begin
  inherited;
  (WDettaglioFM as TWA107FInsAssAutoRegoleDettFM).AbilitaComponenti(True);
end;

procedure TWA107FInsAssAutoRegole.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  (WDettaglioFM as TWA107FInsAssAutoRegoleDettFM).AbilitaComponenti(False);
end;

procedure TWA107FInsAssAutoRegole.actConfermaExecute(Sender: TObject);
begin
  inherited;
  (WDettaglioFM as TWA107FInsAssAutoRegoleDettFM).AbilitaComponenti(False);
end;

end.
