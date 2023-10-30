unit WA129UIndennitaKm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WA129UIndennitaKmDM, WA129UIndennitaKmBrowseFM, WA129UIndennitaKmDettFM,
  DB;

type
  TWA129FIndennitaKm = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  protected
    procedure RefreshPage; override;
    procedure CambioDataDecorrenza; override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA129FIndennitaKm.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA129FIndennitaKmDM.Create(Self);

  WBrowseFM:=TWA129FIndennitaKmBrowseFM.Create(Self);
  WDettaglioFM:=TWA129FIndennitaKmDettFM.Create(Self);
  CreaTabDefault;
end;

function TWA129FIndennitaKm.InizializzaAccesso: Boolean;
var Codice: String;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  if Codice <> '' then
  begin
    WR302DM.selTabella.Locate('CODICE',Codice,[]);
  end;
  CercaStoricoCorrente(Date);
  Result:=True;
end;

procedure TWA129FIndennitaKm.CambioDataDecorrenza;
begin
  inherited;
  with (WR302DM as TWA129FIndennitaKmDM) do
  begin
    if selTabella.State in [dsEdit,dsInsert] then
     (WDettaglioFM as TWA129FIndennitaKmDettFM).CaricaMultiColumnCombobox;
  end;
end;

procedure TWA129FIndennitaKm.RefreshPage;
begin
 with (WR302DM as TWA129FIndennitaKmDM) do
  begin
    A129FIndennitaKmMW.selP050.Refresh;
    if selTabella.State in [dsEdit,dsInsert] then
     (WDettaglioFM as TWA129FIndennitaKmDettFM).CaricaMultiColumnCombobox;
  end;
end;

end.
