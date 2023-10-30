unit WA202URapportiLavoro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, Oracle, System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, Math, StrUtils, DateUtils,
  A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali, WR302UGestTabellaDM, WR204UBrowseTabellaFM,
  IWCompListbox, meIWComboBox, medpIWMessageDlg, Datasnap.DSMetadata, Datasnap.DSClientMetadata, WR100UBase,
  medpIWMultiColumnComboBox, A202URapportiLavoroMW, DB, medpIWDBGrid,
  WA202UValidazioneBrowseFM, WA202UDetailEnteCorrFM, WA202UDetailEnteCorr01FM, WA202UDetailProfAssFM, TypInfo;

type
  TWA202FRapportiLavoro = class(TWR103FGestMasterDetail)
    DSRestMetaDataProvider1: TDSRestMetaDataProvider;
    grdRiepilogo: TmeIWGrid;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabControlTabControlChanging(Sender: TObject; var AllowChange: Boolean);
    procedure grdTabControlTabControlChange(Sender: TObject);
  private
    { Private declarations }
    _StrGridPeriodi:string;
    _StrGridAspett:string;
    _StrGridValid:string;

    procedure SettaModalita(Modalita:TA202Modalita);
    procedure ApriSelTabella;
    procedure CaricaComboPAssenze;
    procedure EseguiStoricizzazione(pDataI: TDateTime; pDataF: TDateTime; pAssenze: string);
    procedure GetRiepilogo;
    procedure ValorizzaCampiStoricizzazione;
    procedure WC700CambioProgressivo(Sender: TObject); override;
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA202URapportiLavoroDM, WA202URapportiLavoroBrowseFM;

{$R *.dfm}

{ TWA202FRapportiLavoro }

function TWA202FRapportiLavoro.InizializzaAccesso: Boolean;
var Progressivo:Integer;
    Modalita: TA202Modalita;
begin
  Modalita:=PASSENZE; //VALIDAZIONE; //PASSENZE;  //condizione solo per test WA202 isolata

  if GetParam('MODALITA') <> '' then
  begin
    if StrToInt(GetParam('MODALITA')) = Integer(PASSENZE) then
      Modalita:=PASSENZE
    else if StrToInt(GetParam('MODALITA')) = Integer(VALIDAZIONE) then
      Modalita:=VALIDAZIONE;
  end;

  SettaModalita(Modalita);
  // progressivo
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
    TWA202FRapportiLavoroDM(WR302DM).A202MW.CambiaProgressivo(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    inherited;
    if TWA202FRapportiLavoroDM(WR302DM).A202MW.ModalitaA202=VALIDAZIONE then
      GetRiepilogo;
    if WR302DM.selTabella.RecordCount = 0 then
      AggiornaDetails;
  end;

  Result:=True;
end;

procedure TWA202FRapportiLavoro.GetRiepilogo;
begin
 with TWA202FRapportiLavoroDM(WR302DM).A202MW do
  begin
    selRiepilogo.Close;
    R180SetVariable(selRiepilogo,'PROGRESSIVO',Progressivo);
    selRiepilogo.Open;
    selRiepilogo.First;
  end;

  with grdRiepilogo do
  begin
    //Servizi prestati totale (approvati+non approvati) [gg];
    Cell[1,1].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_ALL').AsString;
    //Servizi prestati totale (approvati+non approvati) [anni];
    Cell[1,2].Text:=FloatToStrF(TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_ALL').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati a tempo indeterminato (approvati+non approvati) [gg];
    Cell[2,1].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_TI').AsString;
    //Servizi prestati a tempo indeterminato (approvati+non approvati) [anni];
    Cell[2,2].Text:=FloatToStrF(TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_TI').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati totale (non approvati) [gg];
    Cell[1,3].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_ALL_NA').AsString;
    //Servizi prestati totale (non approvati) [anni];
    Cell[1,4].Text:=FloatToStrF(TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_ALL_NA').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati a tempo indeterminato (non approvati) [gg];
    Cell[2,3].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_TI_NA').AsString;
    //Servizi prestati a tempo indeterminato (non approvati) [anni];
    Cell[2,4].Text:=FloatToStrF(TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_TI_NA').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati rapportati al part time totale FTE (approvati+non approvati) [gg];
    Cell[3,1].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_FTE_ALL').AsString;
    //Servizi prestati rapportati al part time totale FTE (approvati+non approvati) [anni];
    Cell[3,2].Text:=FloatToStrF(TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_FTE_ALL').AsInteger / 365, ffNumber, 50, 2);

    //Servizi prestati rapportati al part time FTE (non approvati) [gg];
    Cell[3,3].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_FTE_NA').AsString;
    //Servizi prestati rapportati al part time FTE (non approvati) [anni];
    Cell[3,4].Text:=FloatToStrF(TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('G_FTE_NA').AsInteger / 365, ffNumber, 50, 2);

    Cell[1,5].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('DT_ANZ_5').AsString;
    Cell[1,6].Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selRiepilogo.FieldByName('DT_ANZ_15').AsString;
    Cell[2,5].Text:='-';
    Cell[2,6].Text:='-';
    Cell[3,5].Text:='-';
    Cell[3,6].Text:='-';
  end;
end;

procedure TWA202FRapportiLavoro.grdTabControlTabControlChange(Sender: TObject);
begin
  inherited;
  case grdTabControl.TabIndex of
    0:begin
      WR302DM.SelTabella:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selT425;
      DetailFM[0].Visible:=True;
      DetailFM[1].Visible:=False;
      WBrowseFM.grdTabella.Caption:=_StrGridPeriodi;
    end;
    1:begin
      WR302DM.SelTabella:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selT055;
      DetailFM[0].Visible:=False;
      DetailFM[1].Visible:=True;
      WBrowseFM.grdTabella.Caption:=_StrGridAspett;
    end;
    2:begin
      WR302DM.SelTabella:=TWA202FRapportiLavoroDM(WR302DM).A202MW.selT425_T050_NA;
      DetailFM[0].Visible:=False;
      DetailFM[1].Visible:=False;
      WBrowseFM.grdTabella.Caption:=_StrGridValid;
    end;
  end;
  ApriSelTabella;
end;

procedure TWA202FRapportiLavoro.ApriSelTabella;
begin
  with WR302DM do
  begin
    SelTabella.Close;
    if SelTabella <> TWA202FRapportiLavoroDM(WR302DM).A202MW.selT425_T050_NA then
      SelTabella.SetVariable('PROGRESSIVO',grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
    SelTabella.Open;
    DsrTabella.DataSet:=SelTabella;
    WBrowseFM.grdTabella.medpAttivaGrid(SelTabella,false,false);
    InterfacciaWR102.NomeTabella:=UpperCase(R180Query2NomeTabella(selTabella));
  end;
end;

procedure TWA202FRapportiLavoro.grdTabControlTabControlChanging(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  if WR302DM.SelTabella.State <> dsBrowse then
    AllowChange:=False;
end;

procedure TWA202FRapportiLavoro.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  //Il corpo è eseguito in SettaModalita, richiamatao da InizializzaAccesso
  (*
  InterfacciaWR102.DettaglioFM:=False;

  WR302DM:=TWA202FRapportiLavoroDM.Create(Self);
  *)
end;

//  CONTROLLI PASSENZE
procedure TWA202FRapportiLavoro.EseguiStoricizzazione(pDataI: TDateTime; pDataF: TDateTime; pAssenze: string);
begin
  try
    TWA202FRapportiLavoroDM(WR302DM).A202MW.EseguiStoricizzazione(pDataI, pDataF, pAssenze);
    AggiornaDetails;
  except
    on E:Exception do
      raise Exception.Create(A000MSG_ERR_OPERAZIONE_NON_ESEGUITA + CRLF + E.Message);
  end;
end;

procedure TWA202FRapportiLavoro.SettaModalita(Modalita:TA202Modalita);
var i,j: integer;
    DetailEnteCorr, DetailAsp: TWA202FDetailEnteCorrFM;
    DetailProfiliAss: TWA202FDetailProfAssFM;
begin
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA202FRapportiLavoroDM.Create(Self);

  TWA202FRapportiLavoroDM(WR302DM).ImpostaModalita(Modalita);

  //Javascript per rimuovere il tab control e ottenere i frame attaccati
  JavaScript.Add('$(document).ready(function(){');
  JavaScript.Add('$("#GRDDETAILTABCONTROL").remove();');
  JavaScript.Add('})');

  if TWA202FRapportiLavoroDM(WR302DM).A202MW.ModalitaA202 = PASSENZE then
  begin
    HelpContext:=202000;
    TWA202FRapportiLavoroDM(WR302DM).A202MW.ValorizzaCampiStoricizzazione:=ValorizzaCampiStoricizzazione;

    WBrowseFM:=TWA202FRapportiLavoroBrowseFM.Create(Self);
    AttivaGestioneC700;

    TemplateProcessor.Templates.Default:='WA202FRapportiLavoroPASSENZE.html';
    TWA202FRapportiLavoroBrowseFM(WBrowseFM).grdTabella.Caption:='Rapporti di lavoro presso altri Enti';

    DisabilitaFigliInModifica:=False;

    //Rapporti di lavoro presso ente corrente
    DetailEnteCorr:=TWA202FDetailEnteCorrFM.Create(Self);
    AggiungiDetail(DetailEnteCorr, False);
    DetailEnteCorr.TemplateProcessor.Templates.Default:='WA202FDetailEnteCorrFM_PA.html';
    DetailEnteCorr.grdTabella.Caption:='Rapporti di lavoro Ente corrente';
    DetailEnteCorr.grdTabella.medpRighePagina:=100;
    DetailEnteCorr.CaricaDettaglio(TWA202FRapportiLavoroDM(WR302DM).A202MW.selT430, TWA202FRapportiLavoroDM(WR302DM).A202MW.dsrT430);

    //Profili assenze assegnati (Ferie)
    DetailProfiliAss:=TWA202FDetailProfAssFM.Create(Self);
    AggiungiDetail(DetailProfiliAss, False);
    DetailProfiliAss.grdTabella.Caption:='Profili assenza storicizzati';
    DetailProfiliAss.grdTabella.medpRighePagina:=100;
    DetailProfiliAss.CaricaDettaglio(TWA202FRapportiLavoroDM(WR302DM).A202MW.cdsProfili, TWA202FRapportiLavoroDM(WR302DM).A202MW.dsrProfili);

    DetailProfiliAss.EseguiStoricizzazionePA:=EseguiStoricizzazione;

    //CreaTabDefault;
    grdTabControl.AggiungiTab('Profili assenze', WBrowseFM);

    CaricaComboPAssenze;
    DetailProfiliAss.InibisciCampi;
  end
  else //VALIDAZIONE:
  begin
    HelpContext:=202100;
    _StrGridPeriodi:='Periodi giuridici autocertificati';
    _StrGridAspett:='Periodi di aspettativa autocertificati';
    _StrGridValid:='Periodi da validare';

    WBrowseFM:=TWA202FValidazioneBrowseFM.Create(Self);

    //Grid riepilogo
    with grdRiepilogo do
    begin
      ColumnCount:=7;
      RowCount:=4;

      for i:=0 to ColumnCount-1 do
      begin
        Cell[0,i].Alignment:=taCenter;
        Cell[0,i].Css:='riga_intestazione';
        Cell[1,i].Css:='riga_colorata';
        Cell[2,i].Css:='riga_bianca';
        Cell[3,i].Css:='riga_colorata';
      end;

      for i:=1 to RowCount-1 do
      begin
        Cell[i,0].Alignment:=taLeftJustify;
        for j:=1 to ColumnCount-1 do
          Cell[i,j].Alignment:=taRightJustify;
      end;
      Cell[1,0].Text:='Servizi prestati totale';
      Cell[2,0].Text:='Servizi prestati a tempo indeterminato';
      Cell[3,0].Text:='Servizi prestati rapportati al part time';
      Cell[0,1].Text:='Complessivo (giorni)';
      Cell[0,2].Text:='Complessivo (anni)';
      Cell[0,3].Text:='Da approvare (giorni)';
      Cell[0,4].Text:='Da approvare (anni)';
      Cell[0,5].Text:='Anzianità 5 anni';
      Cell[0,6].Text:='Anzianità 15 anni';
    end;

    AttivaGestioneC700;

    TemplateProcessor.Templates.Default:='WA202FRapportiLavoroVALIDAZIONE.html';
    TWA202FValidazioneBrowseFM(WBrowseFM).grdTabella.Caption:=_StrGridPeriodi;

    //Periodi giuridici presenti in anagrafico
    DetailEnteCorr:=TWA202FDetailEnteCorrFM.Create(Self);
    DetailEnteCorr.Name:='DetailEnteCorr';
    AggiungiDetail(DetailEnteCorr, False);
    DetailEnteCorr.TemplateProcessor.Templates.Default:='WA202FDetailEnteCorrFM_VAL.html';
    DetailEnteCorr.grdTabella.Caption:='Periodi giuridici presenti in anagrafico';
    DetailEnteCorr.grdTabella.medpRighePagina:=100;
    DetailEnteCorr.CaricaDettaglio(TWA202FRapportiLavoroDM(WR302DM).A202MW.selT430, TWA202FRapportiLavoroDM(WR302DM).A202MW.dsrT430);

    //Periodi di aspettativa presenti in anagrafico
    DetailAsp:=TWA202FDetailEnteCorrFM.Create(Self);
    DetailAsp.Name:='DetailAsp';
    AggiungiDetail(DetailAsp, False);
    DetailAsp.TemplateProcessor.Templates.Default:='WA202FDetailEnteCorrFM_VAL.html';
    DetailAsp.grdTabella.Caption:='Periodi di aspettativa presenti in archivio';
    DetailAsp.grdTabella.medpRighePagina:=100;
    DetailAsp.CaricaDettaglio(TWA202FRapportiLavoroDM(WR302DM).A202MW.selT040, TWA202FRapportiLavoroDM(WR302DM).A202MW.dsrT040);

    //CreaTabDefault;
    grdTabControl.AggiungiTab('Riepilogo rapporti di lavoro', WBrowseFM);
    grdTabControl.AggiungiTab('Periodi di aspettativa', WBrowseFM);
    grdTabControl.AggiungiTab('Periodi da validare', WBrowseFM);
    grdTabControl.ActiveTab:=grdTabControl.TabByIndex(0).TabPageControl;

    //Azioni di Inserimento e Cancellazione invisibili
    actNuovo.Visible:=False;
    actElimina.Visible:=False;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);

    //Rendo modificabili solo i campi VALIDAZIONE di selT425 e selT055
    for i:=0 to TWA202FRapportiLavoroDM(WR302DM).A202MW.selT425.FieldCount-1 do
      TWA202FRapportiLavoroDM(WR302DM).A202MW.selT425.Fields[i].ReadOnly:=True;
    TWA202FRapportiLavoroDM(WR302DM).A202MW.selT425.FieldByName('VALIDAZIONE').ReadOnly:=False;

    for i:=0 to TWA202FRapportiLavoroDM(WR302DM).A202MW.selT055.FieldCount-1 do
      TWA202FRapportiLavoroDM(WR302DM).A202MW.selT055.Fields[i].ReadOnly:=True;
    TWA202FRapportiLavoroDM(WR302DM).A202MW.selT055.FieldByName('VALIDAZIONE').ReadOnly:=False;
  end;
end;

procedure TWA202FRapportiLavoro.WC700CambioProgressivo(Sender: TObject);
begin
  TWA202FRapportiLavoroDM(WR302DM).A202MW.CambiaProgressivo(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  inherited;
  if WR302DM.selTabella.RecordCount = 0 then
    AggiornaDetails;
  if TWA202FRapportiLavoroDM(WR302DM).A202MW.ModalitaA202=VALIDAZIONE then
      GetRiepilogo;
end;

procedure TWA202FRapportiLavoro.CaricaComboPAssenze;
begin
  //Carico cmbTipoRapporto
  with TWA202FRapportiLavoroDM(WR302DM).A202MW.selT261 do
  begin
    open;
    First;
    while not Eof do
    begin
      TWA202FDetailProfAssFM(DetailFM[1]).cmbPAssenze.AddRow(FieldByName('CODICE').AsString + ';' +FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA202FRapportiLavoro.ValorizzaCampiStoricizzazione;
{Valorizza campi per storicizzazione}
var StoricizzazioneAbilitata:Boolean;
  Codice, Descrizione, DataFine: string;
begin
  TWA202FDetailProfAssFM(DetailFM[1]).InibisciCampi;
  with TWA202FRapportiLavoroDM(WR302DM).A202MW.cdsProfili do
  begin
    Filtered:=False;
    Filter:='Valorizza=True';
    Filtered:=True;
    if RecordCount = 1 then
    begin
      Codice:=FieldByName('Valore').AsString;
      Descrizione:=FieldByName('Descrizione').AsString;
      DataFine:=FieldByName('Termine').AsString;
    end
    else
    begin
      Codice:='';
      Descrizione:='';
      DataFine:='';
    end;
    Filtered:=False;
  end;

  TWA202FDetailProfAssFM(DetailFM[1]).cmbPAssenze.Enabled:=not SolaLettura;
  with TWA202FRapportiLavoroDM(WR302DM).A202MW.selT261 do
  begin
    R180SetVariable(TWA202FRapportiLavoroDM(WR302DM).A202MW.selT261,'CODICE',Codice);
    Open;
    First;
    Codice:=FieldByName('CODICE').AsString;
    Descrizione:=FieldByName('DESCRIZIONE').AsString;
  end;
  with TWA202FDetailProfAssFM(DetailFM[1]) do
  begin
    cmbPAssenze.Text:=Codice;
    lblDescrizione.Caption:=Descrizione;
    edtScadenza.Text:=FormatDateTime('dd/mm/yyyy',TWA202FRapportiLavoroDM(WR302DM).A202MW.DataScadenza);
    edtGG.Text:=TWA202FRapportiLavoroDM(WR302DM).A202MW.GGServizio.ToString;
    edtDecorrenza.Text:=FormatDateTime('dd/mm/yyyy',max(TWA202FRapportiLavoroDM(WR302DM).A202MW.DataDecorrenzaUtile, TWA202FRapportiLavoroDM(WR302DM).A202MW.DataInizioUtile));
    edtFine.Text:=IfThen(UpperCase(DataFine) = UpperCase(A202_Corrente),
                        FormatDateTime('dd/mm/yyyy', EncodeDateTime(3999, 12, 31, 0, 0, 0, 0)),
                        DataFine);

    StoricizzazioneAbilitata:=(not SolaLettura);

    edtDecorrenza.Enabled:=StoricizzazioneAbilitata;
    edtFine.Enabled:=StoricizzazioneAbilitata;
    btnApplica.Enabled:=StoricizzazioneAbilitata;
  end;
end;


end.
