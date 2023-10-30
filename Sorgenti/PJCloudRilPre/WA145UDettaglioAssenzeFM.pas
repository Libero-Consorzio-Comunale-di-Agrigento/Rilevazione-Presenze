unit WA145UDettaglioAssenzeFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWApplication,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompButton, meIWButton, IWCompGrids, meIWGrid,
  WR100UBase, WA145UComVisiteFiscaliDM, A145UComVisiteFiscaliMW, C190FunzioniGeneraliWeb,
  Vcl.Menus;

type
  TWA145FDettaglioAssenzeFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    grdDettaglio: TmeIWGrid;
    pmnGrdDettaglio: TPopupMenu;
    actScaricaInExcelDett: TMenuItem;
    actScaricaInCSVDett: TMenuItem;
    procedure btnChiudiClick(Sender: TObject);
    procedure grdDettaglioRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure actScaricaInExcelDettClick(Sender: TObject);
    procedure actScaricaInCSVDettClick(Sender: TObject);
  private
    FTitolo: String;
  public
    procedure CaricaDettaglio(Progressivo: Integer);
    procedure Visualizza(Titolo: String);
  end;

implementation

{$R *.dfm}

procedure TWA145FDettaglioAssenzeFM.CaricaDettaglio(Progressivo: Integer);
var
  elencoStoriaDip: TArrayStoriaDip;
  i: Integer;
begin
  with (WR300DM as TWA145FComVisiteFiscaliDM).A145FComVisiteFiscaliMW do
  begin
    elencoStoriaDip:=StoriaDipendente(Progressivo);
  end;
  grdDettaglio.ColumnCount:=5;
  grdDettaglio.RowCount:=Length(elencoStoriaDip) + 1;

  grdDettaglio.Cell[0,0].Text:='';
  grdDettaglio.Cell[0,1].Text:='Inizio';
  grdDettaglio.Cell[0,2].Text:='Fine';
  grdDettaglio.Cell[0,3].Text:='Giorni';
  grdDettaglio.Cell[0,4].Text:='Tipo esenzione';

  for i:=Low(elencoStoriaDip) to High(elencoStoriaDip) do
  begin
    grdDettaglio.Cell[i + 1,0].Text:=elencoStoriaDip[i].Operazione;
    grdDettaglio.Cell[i + 1,1].Text:=elencoStoriaDip[i].Inizio;
    grdDettaglio.Cell[i + 1,2].Text:=elencoStoriaDip[i].Fine;
    grdDettaglio.Cell[i + 1,3].Text:=elencoStoriaDip[i].Giorni;
    grdDettaglio.Cell[i + 1,4].Text:=elencoStoriaDip[i].TipoEsenzione;
  end;
end;

procedure TWA145FDettaglioAssenzeFM.grdDettaglioRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell, ARow, AColumn, True, True);
end;

procedure TWA145FDettaglioAssenzeFM.Visualizza(Titolo: String);
begin
  FTitolo:=Titolo;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,520,-1,250, Titolo,'#' + Self.name,False,True);
end;

procedure TWA145FDettaglioAssenzeFM.actScaricaInCSVDettClick(Sender: TObject);
var
  NomeFile: String;
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR100FBase).csvDownload:=grdDettaglio.ToCsv
  else
  begin
    NomeFile:=FTitolo + '.xls';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    (Self.Owner as TWR100FBase).InviaFile(NomeFile,(Self.Owner as TWR100FBase).csvDownload);
  end;
end;

procedure TWA145FDettaglioAssenzeFM.actScaricaInExcelDettClick(Sender: TObject);
var
  NomeFile: String;
begin
  if not Assigned(Sender) then
    (Self.Owner as TWR100FBase).streamDownload:=grdDettaglio.ToXlsx
  else
  begin
    NomeFile:=FTitolo + '.xlsx';
    NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
    (Self.Owner as TWR100FBase).InviaFile(NomeFile,(Self.Owner as TWR100FBase).streamDownload);
  end;

end;

procedure TWA145FDettaglioAssenzeFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  ReleaseOggetti;
  Free;
end;

end.
