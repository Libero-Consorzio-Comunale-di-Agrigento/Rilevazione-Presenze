unit WP501UCudSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions, meIWImageFile, OracleData, A000UCostanti, IWCompEdit, meIWEdit, A000UInterfaccia;

type
  TWP501FCudSetup = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ModPAGHEAttivato:Boolean;
    function InizializzaAccesso: boolean; override;
  end;

implementation

uses WP501UCudSetupDM, WP501UCudSetupBrowseFM, WP501UCudSetupDettFM;

{$R *.dfm}

procedure TWP501FCudSetup.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  ModPAGHEAttivato:=Parametri.ApplicativiDisponibili.IndexOf('PAGHE') >= 0;
  //ModPAGHEAttivato:=False;

  WR302DM:=TWP501FCudSetupDM.Create(Self);
  WBrowseFM:=TWP501FCudSetupBrowseFM.Create(Self);
  WDettaglioFM:=TWP501FCudSetupDettFM.Create(Self);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  CreaTabDefault;

  if Parametri.Applicazione = 'RILPRE' then
  begin
    actNuovo.Enabled:=Not ModPAGHEAttivato;
    actModifica.Enabled:=Not ModPAGHEAttivato;
    actElimina.Enabled:=Not ModPAGHEAttivato;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;

end;

function TWP501FCudSetup.InizializzaAccesso: boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('COD_AZIENDA_BASE;ANNO',VarArrayOf([T440AZIENDA_BASE,WR302DM.selTabella.FieldByName('ANNO').AsInteger]),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  WDettaglioFM.CaricaMultiColumnCombobox;
  actNuovo.Enabled:=False;
  Result:=True;
end;

end.
