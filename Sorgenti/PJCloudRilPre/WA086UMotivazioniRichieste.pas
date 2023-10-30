unit WA086UMotivazioniRichieste;

interface

uses
  WA086UMotivazioniRichiesteDM,
  WA086UMotivazioniRichiesteBrowseFM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WR102UGestTabella, System.Actions, Vcl.ActnList, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompEdit, meIWEdit;

type
  TWA086FMotivazioniRichieste = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.dfm}

function TWA086FMotivazioniRichieste.InizializzaAccesso: Boolean;
begin
  Result:=True;
end;

procedure TWA086FMotivazioniRichieste.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA086FMotivazioniRichiesteDM.Create(Self);
  WBrowseFM:=TWA086FMotivazioniRichiesteBrowseFM.Create(Self);

  CreaTabDefault;
end;

end.
