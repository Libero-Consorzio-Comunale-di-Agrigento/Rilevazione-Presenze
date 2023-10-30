unit WA100UDistanzeChilometricheFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWCompButton, meIWButton, WR010UBase, C190FunzioniGeneraliWeb,DB,
  IWCompCheckbox, meIWCheckBox;

type
  TResultEvent = procedure(Res:Boolean; km: Double) of object;

  TWA100FDistanzeChilometricheFM = class(TWR200FBaseFM)
    grdTabella: TmedpIWDBGrid;
    btnConferma: TmeIWButton;
    btnChiudi: TmeIWButton;
    chkAR: TmeIWCheckBox;
    procedure btnConfermaClick(Sender: TObject);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
  private
    FDataSet: TDataSet;
    procedure setDataSet(const Value: TDataSet);
  public
    ResultEvent: TResultEvent;
    procedure Visualizza;
    property DataSet: TDataSet read FDataSet write setDataSet;
  end;

implementation

{$R *.dfm}
{ TWA100FDistanzeChilometricheFM }

procedure TWA100FDistanzeChilometricheFM.btnConfermaClick(Sender: TObject);
var
  Res: Boolean;
  km: Double;
begin
  inherited;
  km:=0;
  if Sender = btnConferma then
  begin
    km:=grdTabella.medpClientDataSet.FieldByName('CHILOMETRI').AsFloat;
    if chkAR.Checked then
      km:=km * 2;
    Res:=True;
  end
  else
    Res:=False;

  if Assigned(ResultEvent) then
  try
    ResultEvent(Res,km);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;

  ReleaseOggetti;
  Free;
end;

procedure TWA100FDistanzeChilometricheFM.grdTabellaRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var Agrid: TmedpIWDBGrid;
begin
  inherited;
  Agrid:=TmedpIWDBGrid(ACell.Grid);
  if not Agrid.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TWA100FDistanzeChilometricheFM.setDataSet(const Value: TDataSet);
begin
  FDataSet:=Value;
  grdTabella.medpAttivaGrid(FDataSet,False,False,False);
end;

procedure TWA100FDistanzeChilometricheFM.Visualizza;
begin
  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,700,-1,EM2PIXEL * 30, 'Distanze chilometriche','#wa100DistanzeChilometriche_container',False,True);
end;

end.
