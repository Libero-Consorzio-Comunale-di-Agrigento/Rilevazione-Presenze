unit WA082UCdcPercent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, meIWLabel, IWCompGrids, IWApplication, StrUtils,
  medpIWTabControl, medpIWStatusBar, meIWGrid, meIWMemo,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink,WA082UCdcPercentDM,WA082UCdcPercentBrowseFM,
  IWCompMemo, A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi, C180FunzioniGenerali,
  medpIWMessageDlg,OracleData, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton,medpIWC700NavigatorBar,
  System.Actions;

type
  TWA082FCdcPercent = class(TWR102FGestTabella)
    memoAnomalie: TmeIWMemo;
    actRipristina: TAction;
    actCopia: TAction;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actRipristinaExecute(Sender: TObject);
    procedure actCopiaExecute(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
  private
    function InizializzaAccesso:Boolean; override;
    procedure ResultRipristino(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultCopia(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure AbilitazioneCopia;
  public
    procedure AggiornaVisualizzazione;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    procedure OnTabChanging(var AllowChange: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.dfm}

procedure TWA082FCdcPercent.IWAppFormCreate(Sender: TObject);
begin
  actCopia.Enabled:=False;
  inherited;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA082FCdcPercentDM.Create(Self);
  if A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,nil) then
  begin
    (* Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
    grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
    grdC700.ImpostaProgressivoCorrente:=False;
    grdC700.Impostazioni:=ImpostazioniWC700;
    *)
    AttivaGestioneC700;

    WBrowseFM:=TWA082FCdcPercentBrowseFM.Create(Self);
  end;
end;

procedure TWA082FCdcPercent.IWAppFormRender(Sender: TObject);
begin
  inherited;
  //Se ho prodotto delle anomalie devo disabilitare la navigazione sulla WC700
  with TWA082FCdcPercentDM(WR302DM) do
    grdC700.AbilitaToolbar(not ((Anomalie <> '') and A082FCdcPercentMW.SituazioneModificata));
end;

function TWA082FCdcPercent.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
begin
  Result:=False;
  if not A000LookupTabella(Parametri.CampiRiferimento.C13_CdcPercentualizzati,nil) then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000MSG_A082_ERR_NO_CDC);
    Exit;
  end;

  //Deve prendere il progressivo selezionato da parametro (passato da WA002)
  //e non il progressivo corrente della WA001
  //Se arriva da menu Progressivo non impostato e quindi posizionamento su progressivo corrente della wa001 (fatto su attivazione wc700)
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  //Ripristina deve partire disabilitato
  actRipristina.Enabled:=False;
  AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);

  Result:=True;
end;

procedure TWA082FCdcPercent.OnTabChanging(var AllowChange: Boolean; var Conferma: String);
begin
  with TWA082FCdcPercentDM(WR302DM) do
    if (Anomalie <> '') and A082FCdcPercentMW.SituazioneModificata then
    begin
      AllowChange:=False;
      Conferma:=Format(A000MSG_A082_ERR_FMT_ANOMALIE_PENDING,[IfThen(A082FCdcPercentMW.cdsT433.RecordCount > 0,A000MSG_A082_ERR_FMT_ANOMALIE_PENDING2)]);
    end;
end;

procedure TWA082FCdcPercent.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  inherited; //richiama il tab closing ereditato (Verifica stato dataset)
  if AllowClose then
    with TWA082FCdcPercentDM(WR302DM) do
      if (Anomalie <> '') and A082FCdcPercentMW.SituazioneModificata then
      begin
        AllowClose:=False;
        Conferma:=Format(A000MSG_A082_ERR_FMT_ANOMALIE_PENDING,[IfThen(A082FCdcPercentMW.cdsT433.RecordCount > 0,A000MSG_A082_ERR_FMT_ANOMALIE_PENDING2)]);
      end;
end;

procedure TWA082FCdcPercent.ResultCopia(Sender: TObject; R: TmeIWModalResult;
  KI: String);
var
  ProgOrig: Integer;
begin
  if R = mrYes then
  begin
    with grdC700.SelAnagrafe do
    begin
      DisableControls;
      ProgOrig:=FieldByName('PROGRESSIVO').AsInteger;
      try
        First;
        while Not Eof do
        begin
          TWA082FCdcPercentDM(WR302DM).A082FCdcPercentMW.CopiaMassivaCDC(ProgOrig,FieldByName('PROGRESSIVO').AsInteger,grdC700.WC700FM.C700DataLavoro);
          Next;
        end;
        MsgBox.MessageBox(A000MSG_MSG_OPERAZIONE_COMPLETATA,INFORMA);
      except
        on e:exception do
          MsgBox.MessageBox(Format(A000MSG_ERR_FMT_ERRORE,[e.Message]),ESCLAMA);
      end;
      EnableControls;
      SearchRecord('PROGRESSIVO',ProgOrig,[srFromBeginning]);
    end;
  end;
end;

procedure TWA082FCdcPercent.ResultRipristino(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    TWA082FCdcPercentDM(WR302DM).A082FCdcPercentMW.CancellaT433(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    TWA082FCdcPercentDM(WR302DM).A082FCdcPercentMW.Ripristina;
    TWA082FCdcPercentDM(WR302DM).selTabella.Close;
    TWA082FCdcPercentDM(WR302DM).selTabella.Open;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWA082FCdcPercent.AggiornaVisualizzazione;
begin
  with TWA082FCdcPercentDM(WR302DM) do
  begin
    MemoAnomalie.Clear;
    if Anomalie <> '' then
      memoAnomalie.Lines.add(Format(A000MSG_A082_ERR_FMT_PERIODI,[Anomalie]));

    //Se ho prodotto delle anomalie devo disabilitare la navigazione sulla WC700
    grdC700.AbilitaToolbar(not ((Anomalie <> '') and A082FCdcPercentMW.SituazioneModificata));

    AbilitazioneCopia;

    actRipristina.Enabled:=(Anomalie <> '') and (A082FCdcPercentMW.cdsT433.RecordCount > 0);
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
end;

procedure TWA082FCdcPercent.AbilitazioneCopia;
begin
  actCopia.Enabled:=False;
  if SolaLettura or
     (grdC700.SelAnagrafe.RecordCount <= 1) or
     (TWA082FCdcPercentDM(WR302DM).Anomalie <> '') then
    Exit;

  with TWA082FCdcPercentDM(WR302DM) do
  begin
    selT433Count.Close;
    selT433Count.setVariable('PROGRESSIVO',selTabella.getVariable('PROGRESSIVO'));
    selT433Count.setVariable('DATALAVORO',Parametri.DataLavoro);
    selT433Count.Open;
    selT433Count.First;
    if selT433Count.FieldByName('NUM').AsInteger > 0 then
        actCopia.Enabled:=True;
    selT433Count.Close;
  end;
end;

procedure TWA082FCdcPercent.actCopiaExecute(Sender: TObject);
begin
  with grdC700.SelAnagrafe do
    MsgBox.WebMessageDlg(Format(A000MSG_A082_DLG_FMT_COPIA,[FieldByName('COGNOME').AsString,FieldByName('NOME').AsString,DateToStr(Parametri.DataLavoro)]),mtConfirmation,[mbYes,mbNo],ResultCopia,'');
end;

procedure TWA082FCdcPercent.actRipristinaExecute(Sender: TObject);
begin
  inherited;
  if VerificaSelezioneC700 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A082_DLG_RIPRISTINO,mtConfirmation,[mbYes,mbNo],ResultRipristino,'');
    Abort;
  end;
end;

end.
