unit WA156UNotificheIrisWEB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink;

type
  TWA156FNotificheIrisWEB = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA156UNotificheIrisWEBDM, WA156UNotificheIrisWEBBrowseFM;

{$R *.dfm}

{ TWA156FNotificheIrisWEB }

function TWA156FNotificheIrisWEB.InizializzaAccesso: Boolean;
begin
  Result:=True;
end;

procedure TWA156FNotificheIrisWEB.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA156FNotificheIrisWEBDM.Create(Self);
  WBrowseFM:=TWA156FNotificheIrisWEBBrowseFM.Create(Self);

  CreaTabDefault;
end;

end.
