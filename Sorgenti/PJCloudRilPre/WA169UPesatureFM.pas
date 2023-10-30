unit WA169UPesatureFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions, Vcl.ActnList, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, Data.Db, A000UInterfaccia, A000UMessaggi;

type
  TWA169FPesatureFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  private
    procedure BeforeApplyUpdatesT774;
  public
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WA169UPesatureIndividuali, WA169UPesatureIndividualiDM, WA169UPesatureIndividualiDettFM;

{$R *.dfm}

procedure TWA169FPesatureFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponentiDefault;
end;

procedure TWA169FPesatureFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  actElimina.Visible:=False;
  actNuovo.Visible:=False;
  evBeforeApplyUpdates:=BeforeApplyUpdatesT774;
end;

procedure TWA169FPesatureFM.actConfermaExecute(Sender: TObject);
var
  mess:String;
begin
  inherited;
  mess:=(Self.Parent as TWA169FPesatureIndividuali).Aggiorna(true, false);
  if mess <> '' then
  begin
    raise exception.Create(mess);
  end;
end;

procedure TWA169FPesatureFM.BeforeApplyUpdatesT774;
var SumPI, SumQI:Real;
begin
  SumPI:=(WR302DM as TWA169FPesatureIndividualiDM).A169FPesatureIndividualiMW.SumT774PesoIndividuale;
  if (WR302DM.selTabella.FieldByName('PESO_TOTALE').AsFloat <> 0) and
     (SumPI > WR302DM.selTabella.FieldByName('PESO_TOTALE').AsFloat) then
  begin
    ((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css:=StringReplace(((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    ((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotPesi.css:=StringReplace(((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotPesi.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    ((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotPesi.Text:=FloatToStr(SumPI);
    raise exception.Create(A000MSG_A169_ERR_PESI_BASE);
  end;

  SumQI:=(WR302DM as TWA169FPesatureIndividualiDM).A169FPesatureIndividualiMW.SumT774QuotaIndividuale;
  if (WR302DM.selTabella.FieldByName('QUOTA_TOTALE').AsFloat <> 0) and
     (SumPI > WR302DM.selTabella.FieldByName('QUOTA_TOTALE').AsFloat) then
  begin
    ((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.css:=StringReplace(((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    ((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuote.css:=StringReplace(((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).lblTotQuote.css,'font_neroImp','font_rossoImp',[rfReplaceAll]);
    ((Self.Parent as TWA169FPesatureIndividuali).WDettaglioFM as TWA169FPesatureIndividualiDettFM).edtTotQuote.Text:=FloatToStr(SumQI);

    raise exception.Create(A000MSG_A169_ERR_QUOTE_BASE);
  end;
end;

end.
