unit WP552URegoleContoAnnuale;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WP552uRegoleContoAnnualeDM, WP552URegoleContoAnnualeBrowseFM,
  WP552URegoleContoAnnualeDettFM, WP552URigheRegoleContoAnnualeFM,
  WP552UColonneRegoleContoAnnualeFM, WP552UEsportazioneFileFM, OracleData,
  IWCompEdit, meIWEdit, WP552UScriptInizialeRegoleContoAnnualeFM;

type
  TWP552FRegoleContoAnnuale = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  public
    ScriptIniziale: TWP552FScriptInizialeRegoleContoAnnualeFM;
    DetailRighe: TWP552FRigheRegoleContoAnnualeFM;
    DetailColonne: TWP552FColonneRegoleContoAnnualeFM;
    EsportazioneFileFM: TWP552FEsportazioneFileFM;
    procedure EseguiDelete; override;
    function InizializzaAccesso:boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWP552FRegoleContoAnnuale.IWAppFormCreate(Sender: TObject);
begin
  actCopiaSu.Visible:=False;
  inherited;
  InterfacciaWR102.TemplateAutomatico:=False;
  WR302DM:=TWP552FRegoleContoAnnualeDM.Create(Self);
  WR100LinkWC700:=False;
  AttivaGestioneC700;

  WBrowseFM:=TWP552FRegoleContoAnnualeBrowseFM.Create(Self);
  WDettaglioFM:=TWP552FRegoleContoAnnualeDettFM.Create(Self);
  ScriptIniziale:=TWP552FScriptInizialeRegoleContoAnnualeFM.Create(Self);
  CreaTabDefault;
  grdTabControl.AggiungiTab('Script iniziale',ScriptIniziale);
  if DatiAbilitazioni.AccessoBrowse = 'S' then
    grdTabControl.ActiveTab:=WBrowseFM
  else
    grdTabControl.ActiveTab:=WDettaglioFM;

  ScriptIniziale.dmemScriptIniziale.DataSource:=(WDettaglioFM as TWP552FRegoleContoAnnualeDettFM).dmemRegolaManuale.DataSource;

  DetailRighe:=TWP552FRigheRegoleContoAnnualeFM.Create(Self);
  AggiungiDetail(DetailRighe,'Righe');
  DetailRighe.CaricaDettaglio(TWP552FRegoleContoAnnualeDM(WR302DM).P552FRegoleContoAnnualeMW.selP552Righe,TWP552FRegoleContoAnnualeDM(WR302DM).P552FRegoleContoAnnualeMW.dsrP552Righe);

  DetailColonne:=TWP552FColonneRegoleContoAnnualeFM.Create(Self);
  AggiungiDetail(DetailColonne,'Colonne');
  DetailColonne.CaricaDettaglio(TWP552FRegoleContoAnnualeDM(WR302DM).P552FRegoleContoAnnualeMW.selP552Colonne,TWP552FRegoleContoAnnualeDM(WR302DM).P552FRegoleContoAnnualeMW.dsrP552Colonne);

  EsportazioneFileFM:=TWP552FEsportazioneFileFM.Create(Self);
  AggiungiDetail(EsportazioneFileFM,'Esportazione su file');
  EsportazioneFileFM.CaricaDettaglio(TWP552FRegoleContoAnnualeDM(WR302DM).P552FRegoleContoAnnualeMW.selP551,TWP552FRegoleContoAnnualeDM(WR302DM).P552FRegoleContoAnnualeMW.dsrP551);
end;

procedure TWP552FRegoleContoAnnuale.IWAppFormDestroy(Sender: TObject);
begin
  ScriptIniziale.Free;
  inherited;
end;

function TWP552FRegoleContoAnnuale.InizializzaAccesso: boolean;
var
  MaxAnno: Integer;
begin
  MaxAnno:=(WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.GetMaxAnno;
  WR302DM.selTabella.SearchRecord('ANNO',MaxAnno,[srFromBeginning]);

  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;

  Result:=True;
end;

procedure TWP552FRegoleContoAnnuale.EseguiDelete;
var
  Tabella,Anno: String;
begin
  Tabella:=WR302DM.selTabella.FieldByName('COD_TABELLA').AsString;
  Anno:=IntToStr(WR302DM.selTabella.FieldByName('ANNO').AsInteger);
  (WR302DM as TWP552FRegoleContoAnnualeDM).P552FRegoleContoAnnualeMW.DeleteP552(Tabella,Anno);

  WBrowseFM.grdTabella.medpAggiornaCDS;
  AggiornaRecord;
end;

end.
