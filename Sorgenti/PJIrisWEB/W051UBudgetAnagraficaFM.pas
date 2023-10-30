unit W051UBudgetAnagraficaFM;

interface

uses
  System.SysUtils, System.Classes, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, Vcl.Controls, Vcl.Forms,
  IWAppForm, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  Data.DB, Datasnap.DBClient, IWCompGrids, IWDBGrids, meIWDBGrid, WR010UBase, C190FunzioniGeneraliWeb,
  W051UBudgetStraordinarioDM, medpIWDBGrid;


type
  TW051FBudgetAnagraficaFM = class(TWR200FBaseFM)
    btnChiudi: TmedpIWImageButton;
    cdsAnagr: TClientDataSet;
    dsrAnagr: TDataSource;
    grdAnagrafica: TmedpIWDBGrid;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    W051DM:TW051FBudgetStraordinarioDM;
    procedure Visualizza;
  end;

var
  W051FBudgetAnagraficaFM: TW051FBudgetAnagraficaFM;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TW051FBudgetAnagraficaFM.btnChiudiClick(Sender: TObject);
begin
  Free;
end;

procedure TW051FBudgetAnagraficaFM.IWFrameRegionCreate(Sender: TObject);
begin
  Self.Parent:=TIWAppForm(Self.Owner);
end;

procedure TW051FBudgetAnagraficaFM.Visualizza;
var Titolo:String;
begin
  Titolo:='Elenco dipendenti selezionati';
  (Self.Parent as TWR010FBase).VisualizzajQMessaggio(JQuery,440,-1,EM2PIXEL * 24,Titolo,'#' + Self.Name,False,True);

  grdAnagrafica.medpRighePagina:=10;
  W051DM.A064MW.AperturaDipendenti;

  grdAnagrafica.medpAttivaGrid(W051DM.A064MW.selbV430,False,False);
  grdAnagrafica.medpTestoNoRecord:='Nessun dipendente';

  grdAnagrafica.medpCreaCDS;
  grdAnagrafica.medpEliminaColonne;

  grdAnagrafica.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
  grdAnagrafica.medpAggiungiColonna('COGNOME','Cognome','',nil);
  grdAnagrafica.medpAggiungiColonna('NOME','Nome','',nil);

  grdAnagrafica.medpInizializzaCompGriglia;

  grdAnagrafica.medpCaricaCDS;
end;

end.
