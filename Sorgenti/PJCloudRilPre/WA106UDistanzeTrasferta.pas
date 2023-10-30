unit WA106UDistanzeTrasferta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink,WA106UDistanzeTrasfertaDM, WA106UDistanzeTrasfertaBrowseFM,
  WA106UDistanzeTrasfertaDettFM, meIWImageFile;

type
  TWA106FDistanzeTrasferta = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  protected
    procedure RefreshPage; override;
  public
  end;

implementation

{$R *.dfm}

procedure TWA106FDistanzeTrasferta.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA106FDistanzeTrasfertaDM.Create(Self);
  WBrowseFM:=TWA106FDistanzeTrasfertaBrowseFM.Create(Self);
  WDettaglioFM:=TWA106FDistanzeTrasfertaDettFM.Create(Self);
  CreaTabDefault;
end;

procedure TWA106FDistanzeTrasferta.RefreshPage;
begin
  with (WR302DM as TWA106FDistanzeTrasfertaDM).A106FDistanzeTrasfertaMW do
  begin
    //Aggiornamento in caso di aggiunta comune
    //per le localita refresh su chiudi del frame WC015
    SelT480.Refresh;
  end;
end;

end.
