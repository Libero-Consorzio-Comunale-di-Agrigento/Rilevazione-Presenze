unit WA126UBloccoRiepiloghi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, OracleData,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,   medpIWC700NavigatorBar,
  WA126UBloccoRiepiloghiDM, WA126UBloccoRiepiloghiBrowseFM,WA126UBloccoRiepiloghiFM,
  WA126UDataCassaFM, A000UInterfaccia, A000USessione, C180FunzioniGenerali, System.Actions, Oracle, IWCompEdit, meIWEdit;

type
  TWA126FBloccoRiepiloghi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabControlTabControlChange(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    WA126FBloccoRiepiloghiFM: TWA126FBloccoRiepiloghiFM;
    WA126FDataCassaFM: TWA126FDataCassaFM;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    function ImpostaQuery:Boolean;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure FineCicloElaborazione;override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
  public
    ParProg,ParChiamante,ParDataDa,ParDataA:String;
    function InizializzaAccesso:Boolean; override;
    procedure CaricaElenco;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.dfm}

procedure TWA126FBloccoRiepiloghi.IWAppFormCreate(Sender: TObject);
begin
  //Rendo invisibili action non permesse
  ActNuovo.Visible:=False;
  ActModifica.Visible:=False;
  ActCopiaSu.Visible:=False;
  ActConferma.Visible:=False;
  ActAnnulla.Visible:=False;
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA126FBloccoRiepiloghiDM.Create(Self);

  (* Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);// creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.AttivaBrowse:=False;
  *)
  AttivaGestioneC700;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
  (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.SelAnagrafe:=grdC700.selAnagrafe;

  WBrowseFM:=TWA126FBloccoRiepiloghiBrowseFM.Create(Self);
  WA126FBloccoRiepiloghiFM:=TWA126FBloccoRiepiloghiFM.Create(Self);
  WA126FDataCassaFM:=TWA126FDataCassaFM.Create(Self);

  grdTabControl.AggiungiTab('Tabella',WBrowseFM);
  grdTabControl.AggiungiTab('Blocco riepiloghi',WA126FBloccoRiepiloghiFM);
  grdTabControl.AggiungiTab('Data di cassa',WA126FDataCassaFM);

  grdTabControl.ActiveTab:=WBrowseFM;
end;

function TWA126FBloccoRiepiloghi.InizializzaAccesso: Boolean;
begin
  ParProg:=GetParam('PROG');
  ParChiamante:=GetParam('CHIAMANTE');
  ParDataDa:=GetParam('DATADA');
  ParDataA:=GetParam('DATAA');
  WA126FBloccoRiepiloghiFM.CaricaDatiIniziali;
  if (ParChiamante <> '') or (A000GetInibizioni('Tag','13') <> 'S') then
  begin
    grdTabControl.Tabs[WA126FDataCassaFM].Visible:=False;
    if (ParChiamante <> '') then
    begin
      grdC700.actC700EreditaSelezioneExecute(nil);
      grdC700.selAnagrafe.SearchRecord('PROGRESSIVO',StrToIntDef(ParProg,0),[srFromBeginning]);
    end;
  end;
  CaricaElenco;

  Result:=True;
end;


procedure TWA126FBloccoRiepiloghi.ResultWC700(Sender: TObject; Result: Boolean);
begin
  //se elenco filtrato per i soli dipendenti selezionati, ricarico la grid
  if (Result) and ((WBrowseFM as TWA126FBloccoRiepiloghiBrowseFM).ChkDipendentiSelezionati.checked) then
  begin
    //Devo scatenare il filter dei record
    WR302DM.selTabella.Filtered:=False;
    WR302DM.selTabella.Filtered:=True;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA126FBloccoRiepiloghi.CaricaElenco;
begin
  if ImpostaQuery then //se dati modificati ricarico
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA126FBloccoRiepiloghi.grdTabControlTabControlChange(
  Sender: TObject);
begin
  inherited;
  if grdTabControl.ActiveTab = WBrowseFM then
    CaricaElenco;
end;

function TWA126FBloccoRiepiloghi.ImpostaQuery:Boolean;
var
  DipendentiSelezionati: Boolean;
begin
  DipendentiSelezionati:=(WBrowseFM as TWA126FBloccoRiepiloghiBrowseFM).ChkDipendentiSelezionati.checked;
  Result:=(WR302DM as TWA126FBloccoRiepiloghiDM).ImpostaSelTabella(WA126FBloccoRiepiloghiFM.GetRiepiloghiSelezionati,
                                                                   WA126FBloccoRiepiloghiFM.DataIniziale,
                                                                   WA126FBloccoRiepiloghiFM.DataFinale,
                                                                   DipendentiSelezionati);
end;

procedure TWA126FBloccoRiepiloghi.OnTabClosing(var AllowClose: Boolean;
  var Conferma: String);
begin
  inherited;
  WA126FBloccoRiepiloghiFM.PutParametriFunzione;
end;

procedure TWA126FBloccoRiepiloghi.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(WA126FBloccoRiepiloghiFM);
  FreeAndNil(WA126FDataCassaFM);
  inherited;
end;

//ELABORAZIONE
procedure TWA126FBloccoRiepiloghi.InizioElaborazione;
begin
  inherited;
  grdC700.SelAnagrafe.OnFilterRecord:=(WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.SelAnagrafeFilterRecord;
  grdC700.SelAnagrafe.First;
end;

function TWA126FBloccoRiepiloghi.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;


function TWA126FBloccoRiepiloghi.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA126FBloccoRiepiloghi.WC700AperturaSelezione(Sender: TObject);
var
  Data: TDateTime;
begin
  if TryStrToDate('01/' + WA126FBloccoRiepiloghiFM.edtDaData.Text,Data) then
    grdC700.WC700FM.C700DataDal:=R180InizioMese(Data);

  if TryStrToDate('01/' + WA126FBloccoRiepiloghiFM.edtAData.Text,Data) then
    grdC700.WC700FM.C700DataLavoro:=R180FineMese(Data);
end;

procedure TWA126FBloccoRiepiloghi.ElaboraElemento;
var
 LstRiep: TStringList;
 i: Integer;
begin
  inherited;
  try
    LstRiep:=WA126FBloccoRiepiloghiFM.GetLstRiepiloghiSelezionati;
    for i:=0 to LstRiep.Count - 1 do
      (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.BloccoRiepiloghi(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                                                                            WA126FBloccoRiepiloghiFM.Blocco,
                                                                            LstRiep[i]);
    SessioneOracle.Commit;
  finally
    FreeAndNil(LstRiep);
  end;
end;

function TWA126FBloccoRiepiloghi.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.selAnagrafe.Next;
  if not grdC700.selAnagrafe.EOF then
    Result:=True;
end;

procedure TWA126FBloccoRiepiloghi.FineCicloElaborazione;
begin
  with (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW do
    ScriviLog(WA126FBloccoRiepiloghiFM.Blocco,WA126FBloccoRiepiloghiFM.GetRiepiloghiSelezionati);
end;

procedure TWA126FBloccoRiepiloghi.DistruzioneOggettiElaborazione(
  Errore: Boolean);
begin
  inherited;
  grdC700.selAnagrafe.OnFilterRecord:=nil;
  grdC700.selAnagrafe.Filtered:=False;
  if WR302DM.selTabella.Active then
  begin
    WR302DM.selTabella.Refresh;
    //aggiorno griglia
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

end.
