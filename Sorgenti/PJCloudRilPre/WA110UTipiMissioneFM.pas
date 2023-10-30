unit WA110UTipiMissioneFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  OracleData, Db, medpIWMessageDlg, System.Actions, Vcl.Menus;

type
  TWA110FTipiMissioneFM = class(TWR203FGestDetailFM)
    procedure actConfermaExecute(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  protected
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String); override;
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
    procedure AggiornaDettaglio; override;
  end;

implementation
uses WA110UParametriConteggio, WA110UParametriConteggioDettFM, WA110UParametriConteggioDM;

{$R *.dfm}

{ TWA110FTipiMissioneFM }

procedure TWA110FTipiMissioneFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpOrdinamentoColonne:=True;
end;

procedure TWA110FTipiMissioneFM.AggiornaDettaglio;
begin
  with (WR302DM as TWA110FParametriConteggioDM) do
  begin
    //non richiamare inherited. deve solo riposizionare il cds sulla riga corretta
    A110FParametriConteggioMW.selM011.SearchRecord('CODICE',selTabella.FieldByName('TIPO_MISSIONE').AsString,[srFromBeginning]);
    grdTabella.medpAggiornaCDS(False);
  end;
end;

procedure TWA110FTipiMissioneFM.CaricaDettaglio(DataSet: TDataSet;
  DataSource: TDataSource);
begin
  with (WR302DM as TWA110FParametriConteggioDM) do
  begin
    inherited;
    A110FParametriConteggioMW.selM011.SearchRecord('CODICE',selTabella.FieldByName('TIPO_MISSIONE').AsString,[srFromBeginning]);
    grdTabella.medpAggiornaCDS(False);
  end;
end;

procedure TWA110FTipiMissioneFM.ResultDelete(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  inherited;
  with ((Self.Owner as TWA110FParametriConteggio).WDettaglioFM as TWA110FParametriConteggioDettFM) do
  begin
    AggiornaTipiMissione;
  end;
end;

procedure TWA110FTipiMissioneFM.actConfermaExecute(Sender: TObject);
begin
  inherited;
  //Aggiorno combo Tipo Missione
  with ((Self.Owner as TWA110FParametriConteggio).WDettaglioFM as TWA110FParametriConteggioDettFM) do
  begin
    AggiornaTipiMissione;
  end;
end;

end.
