unit WA046UTerMensa;

interface

uses
  Windows,OracleData, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, ActnList, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  System.Actions;

type
  TWA046FTerMensa = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function InizializzaAccesso: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA046UTerMensaDM, WA046UTerMensaBrowseFM,WA046UTerMensaDettFM;

{$R *.dfm}

function TWA046FTerMensa.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA046FTerMensa.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA046FTerMensaDM.Create(Self);
  WBrowseFM:=TWA046FTerMensaBrowseFM.Create(Self);
  WDettaglioFM:=TWA046FTerMensaDettFM.Create(Self);

  CreaTabDefault;
end;

end.
