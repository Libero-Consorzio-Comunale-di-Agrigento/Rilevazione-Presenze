unit WA190ULimitiEccedenzaResMesiFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  WA190ULimitiEccedenzaResDM, WC020UInputDataOreFM, DB, System.Actions,
  Vcl.Menus;

type
  TWA190FLimitiEccedenzaResMesiFM = class(TWR203FGestDetailFM)
    actAssegnazioneAnnua: TAction;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actAssegnazioneAnnuaExecute(Sender: TObject);
  private
    procedure ResultAssegnazioneAnnua(Sender: TObject; Result: Boolean;Valore: String);
  public
    procedure DataSourceStateChange(Sender: TObject); override;
  end;

implementation

{$R *.dfm}

procedure TWA190FLimitiEccedenzaResMesiFM.IWFrameRegionCreate(Sender: TObject);
begin
  actNuovo.Visible:=False;
  actElimina.Visible:=False;
  inherited;
end;

procedure TWA190FLimitiEccedenzaResMesiFM.ResultAssegnazioneAnnua(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    with (WR302DM as TWA190FLimitiEccedenzaResDM) do
    begin
      A094FSkLimitiStraordMW.AssegnazioneAnnua(selTabella.FieldByName('Anno').AsInteger,
                                               selTabella.FieldByName('Campo1').AsString,
                                               selTabella.FieldByName('Campo2').AsString,
                                               'R',
                                               Valore);
      grdTabella.medpAggiornaCDS(True);
    end;
  end;
end;

procedure TWA190FLimitiEccedenzaResMesiFM.actAssegnazioneAnnuaExecute(Sender: TObject);
var WC020FInputDataOreFM : TWC020FInputDataOreFM;
begin
  (* Massimo 22/07/2013: modificata WC020
  WC020FInputOreFM:=TWC020FInputOreFM.Create(Self.Parent);
  WC020FInputOreFM.Default('Valore mensile:','00.00');
  WC020FInputOreFM.ResultEvent:=ResultAssegnazioneAnnua;
  WC020FInputOreFM.Visualizza('Assegnazione annua');
  *)
  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self.Parent);
  WC020FInputDataOreFM.ImpostaCampiOre('Valore mensile:','00.00');
  WC020FInputDataOreFM.ResultEvent:=ResultAssegnazioneAnnua;
  WC020FInputDataOreFM.Visualizza('Assegnazione annua');
end;

procedure TWA190FLimitiEccedenzaResMesiFM.DataSourceStateChange(
  Sender: TObject);
begin
  actAssegnazioneAnnua.Enabled:=grdTabella.medpDataSet.State = dsBrowse;
  inherited;
end;

end.
