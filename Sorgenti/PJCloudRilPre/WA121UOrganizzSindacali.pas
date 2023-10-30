unit WA121UOrganizzSindacali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, meIWImageFile, OracleData, WA121UOrganizzSindacaliOrganismiFM,
  IWCompEdit, meIWEdit;

type
  TWA121FOrganizzSindacali = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    DetOrganismiFM:TWA121FOrganizzSindacaliOrganismiFM;
  public
    { Public declarations }
    function InizializzaAccesso: Boolean; override;
  end;

implementation

uses WA121UOrganizzSindacaliDM, WA121UOrganizzSindacaliBrowseFM, WA121UOrganizzSindacaliDettFM,
     WA121UOrganizzSindacaliRecapitiFM, WA121UOrganizzSindacaliCompetenzeFM;

{$R *.dfm}

procedure TWA121FOrganizzSindacali.IWAppFormCreate(Sender: TObject);
var
  DetRecapitiFM:TWA121FOrganizzSindacaliRecapitiFM;
  DetCompetenzeFM:TWA121FOrganizzSindacaliCompetenzeFM;
begin
  inherited;
  WR100LinkWC700:=false;
  InterfacciaWR102.TemplateAutomatico:=False;
  InterfacciaWR102.GestioneStoricizzata:=true;
  WR302DM:=TWA121FOrganizzSindacaliDM.Create(Self);
  AttivaGestioneC700;
  WBrowseFM:=TWA121FOrganizzSindacaliBrowseFM.Create(Self);
  WDettaglioFM:=TWA121FOrganizzSindacaliDettFM.Create(Self);

  DetRecapitiFM:=TWA121FOrganizzSindacaliRecapitiFM.Create(Self);
  AggiungiDetail(DetRecapitiFM,'Recapiti');
  DetRecapitiFM.CaricaDettaglio((WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT241,(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.dsrT241);

  DetCompetenzeFM:=TWA121FOrganizzSindacaliCompetenzeFM.Create(Self);
  AggiungiDetail(DetCompetenzeFM,'Competenze');
  DetCompetenzeFM.CaricaDettaglio((WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT242,(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.dsrT242);
  DetCompetenzeFM.InizializzaComponenti;

  DetOrganismiFM:=TWA121FOrganizzSindacaliOrganismiFM.Create(Self);
  DetOrganismiFM.CaricaDettaglio((WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT245,(WR302DM as TWA121FOrganizzSindacaliDM).A121MW.dsrT245);
  DetOrganismiFM.InizializzaComponenti;

  CreaTabDefault;
  grdTabControl.AggiungiTab('Organismi sindacali',DetOrganismiFM);
  grdTabControl.ActiveTab:=WBrowseFM;
  actVisioneCorrenteExecute(nil);
end;

function TWA121FOrganizzSindacali.InizializzaAccesso: Boolean;
var Tipo,Codice:String;
begin
  Tipo:=GetParam('TIPO');
  Codice:=GetParam('CODICE');
  if Codice <> '' then
  begin
    if Tipo = 'S' then
    begin
      grdTabControl.ActiveTab:=WBrowseFM;
      WR302DM.selTabella.SearchRecord('CODICE',Codice,[srFromBeginning]);
      WBrowseFM.grdTabella.medpAggiornaCDS;
      AggiornaRecord;
    end
    else if Tipo = 'O' then
    begin
      grdTabControl.ActiveTab:=DetOrganismiFM;
      (WR302DM as TWA121FOrganizzSindacaliDM).A121MW.selT245.SearchRecord('CODICE',Codice,[srFromBeginning]);
      DetOrganismiFM.grdTabella.medpAggiornaCDS;
    end;
  end;
  Result:=True;
end;

end.
