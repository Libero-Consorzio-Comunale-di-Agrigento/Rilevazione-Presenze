unit WC006UStoriaDipFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, meIWDBGrid,C190FunzioniGeneraliWeb,
  DB,WR010UBase, IWCompButton, meIWButton, Menus,WA002UAnagrafe, IWCompEdit;

type
  TWC006SpostaStoricoResultEvent = procedure(Sender: TObject; ResultDec,ResultFine: TDateTime) of object;

  TWC006FStoriaDipFM = class(TWR200FBaseFM)
    grdStoria: TmeIWDBGrid;
    btnChiudi: TmeIWButton;
    pmnGrigliaDati: TPopupMenu;
    mnuSpostaStorico: TMenuItem;
    procedure grdStoriaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnChiudiClick(Sender: TObject);
    procedure mnuSpostaStoricoClick(Sender: TObject);
  private
    ResultEvent:TWC006SpostaStoricoResultEvent;
    procedure onGridClick(ASender: TObject; const AValue: string);
    private FCampoColoreRiga : String;
  public
    procedure Visualizza(cdsrDati: TDataSource;SpostaStoricoResultEvent : TWC006SpostaStoricoResultEvent);
    property CampoColoreRiga : String read FCampoColoreRiga write FCampoColoreRiga;
  end;

implementation

{$R *.dfm}


procedure TWC006FStoriaDipFM.Visualizza(cdsrDati: TDataSource; SpostaStoricoResultEvent : TWC006SpostaStoricoResultEvent);
var
  i,nc: Integer;
  JSOnOpen: String;
begin
  //creazione colonne con evento click
  with grdStoria do
  begin
    DataSource:=cdsrDati;
    Columns.Clear;
    for i:=0 to DataSource.DataSet.FieldCount - 1 do
      if DataSource.DataSet.Fields[i].Visible then
      begin
        Columns.Add;
        nc:=Columns.Count - 1;
        with TIWDBGridColumn(Columns.Items[nc]) do
        begin
          DataField:=DataSource.DataSet.Fields[i].FieldName;
          Font.Enabled:=False;
          Title.Text:=DataSource.DataSet.Fields[i].DisplayLabel;
          Title.RawText:=True;
          Title.Font.Enabled:=False;
          LinkField:='KEY';
          OnClick:=onGridClick;
        end;
      end;
  end;
  ResultEvent:=SpostaStoricoResultEvent;
  grdStoria.medpContextMenu:=pmnGrigliaDati;
  //imposta la riga con classe riga_selezionata all'interno dell'area visibile
  JSOnOpen:='var idsel=$("#divgrid").find("tr:has(td.riga_selezionata)").attr("id"); document.getElementById("divgrid").scrollTop=document.getElementById(idsel).offsetTop - 80; ';

  TWR010FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,800,400,500,'Situazione storica','#wc006_container',False,True,-1,'',JSonOpen);
end;

procedure TWC006FStoriaDipFM.grdStoriaRenderCell(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,ARow,AColumn,True,(CampoColoreRiga = ''),True);
  if (CampoColoreRiga <> '') then
  begin
    if grdStoria.DataSource.DataSet.FieldByName(CampoColoreRiga).AsBoolean then
      ACell.Css:=ACell.Css + ' riga_colorata'
    else
      ACell.Css:=ACell.Css + ' riga_bianca'
  end;
end;

procedure TWC006FStoriaDipFM.mnuSpostaStoricoClick(Sender: TObject);
begin
  inherited;
  btnChiudiClick(Sender);
end;

procedure TWC006FStoriaDipFM.onGridClick(ASender: TObject;
  const AValue: string);
begin
  grdStoria.DataSource.DataSet.Locate('KEY',AValue,[]);
  //edtScroll.Text:=Format('%d%d',[integer(grdStoria), AValue]);
end;

procedure TWC006FStoriaDipFM.btnChiudiClick(Sender: TObject);
var DecFine:TDateTime;
begin
  if (Sender = mnuSpostaStorico) then
    if Assigned(ResultEvent) then
    try
      if UpperCase(grdStoria.DataSource.DataSet.FieldByName('DATAFINE').AsString) = 'CORRENTE' then
        DecFine:=EncodeDate(3999,12,31)
      else
        DecFine:=grdStoria.DataSource.DataSet.FieldByName('DATAFINE').AsDateTime;
      ResultEvent(Self,grdStoria.DataSource.DataSet.FieldByName('DATADEC').AsDateTime,DecFine);
    except
      on E: EAbort do;
      on E: Exception do
        raise;
    end;

  ReleaseOggetti;
  Free;
  inherited;
end;

end.
