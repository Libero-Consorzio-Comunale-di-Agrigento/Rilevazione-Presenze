unit WA189ULimitiEccedenzaLiqMesiFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  DB, WC020UInputDataOreFM, WA189ULimitiEccedenzaLiqDM, System.Actions,
  Vcl.Menus;

type
  TWA189FLimitiEccedenzaLiqMesiFM = class(TWR203FGestDetailFM)
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

procedure TWA189FLimitiEccedenzaLiqMesiFM.IWFrameRegionCreate(Sender: TObject);
begin
  actNuovo.Visible:=False;
  actElimina.Visible:=False;
  inherited;
end;

procedure TWA189FLimitiEccedenzaLiqMesiFM.ResultAssegnazioneAnnua(Sender: TObject; Result: Boolean; Valore: String);
begin
  if Result then
  begin
    with (WR302DM as TWA189FLimitiEccedenzaLiqDM) do
    begin
      A094FSkLimitiStraordMW.AssegnazioneAnnua(selTabella.FieldByName('Anno').AsInteger,
                                               selTabella.FieldByName('Campo1').AsString,
                                               selTabella.FieldByName('Campo2').AsString,
                                               'L',
                                               Valore);
      grdTabella.medpAggiornaCDS(True);
    end;
  end;
end;

procedure TWA189FLimitiEccedenzaLiqMesiFM.actAssegnazioneAnnuaExecute(
  Sender: TObject);
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

procedure TWA189FLimitiEccedenzaLiqMesiFM.DataSourceStateChange(Sender: TObject);
begin
  //Browse:=not (DataSetState in [dsInsert,dsEdit]);
  actAssegnazioneAnnua.Enabled:=grdTabella.medpDataSet.State = dsBrowse;
  inherited;
end;

end.
