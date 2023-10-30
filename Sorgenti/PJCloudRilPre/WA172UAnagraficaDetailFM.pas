unit WA172UAnagraficaDetailFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  WR100UBase, C180FUnzioniGenerali, DB, C190FunzioniGeneraliWeb,
  WR103UGestMasterDetail, A000UInterfaccia, A000UMessaggi, medpIWMessageDlg,
  medpIWMultiColumnComboBox, meIWImageFile, WC013UCheckListFM,
  WA172USchedeQuantIndividualiDM, A000UCostanti, meIWEdit, meIWComboBox,
  A172USchedeQuantIndividualiMW, WA172USchedeQuantIndividualiDettFM,
  WA172USchedeQuantObiettiviFM;

type
  TWA172FAnagraficaDetailFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure actConfermaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
  private
    Totali: TTotali;
    RowEdit: Integer;
    procedure imgPartTimeClick(Sender: TObject);
    procedure FlessibilitaResult(Sender: TObject; Result: Boolean);
    procedure ImpostaCampiReadOnly(InEdit: boolean);
    procedure OnPostCdsT768;
    procedure imgObiettiviPosizClick(Sender: TObject);
  public
    procedure CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource); override;
    procedure AggiornaDettaglio; override;
  end;

implementation

{$R *.dfm}
procedure TWA172FAnagraficaDetailFM.IWFrameRegionCreate(Sender: TObject);
begin
  actElimina.Visible:=False;
  actNuovo.Visible:=False;
  evBeforeApplyUpdates:=OnPostCdsT768;
  inherited;
end;

procedure TWA172FAnagraficaDetailFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpCancellaRigaWR102;

  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('OBIETTIVI_POSIZ'),0,DBG_IMG,'','CAMBIADATO','null','','C');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FLESSIBILITA'),0,DBG_EDT,'','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('FLESSIBILITA'),1,DBG_IMG,'','CAMBIADATO','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NOTE'),0,DBG_EDT,'10','','','','S');

  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NUMORE_ASSEGNATE'),0,DBG_EDT,'','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NUMORE_ACCETTATE'),0,DBG_EDT,'','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('INF_OBIETTIVI'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('ACCETT_VALUTAZIONE'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VALUTATORE'),0,DBG_CMB,'20','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CONFERMATO'),0,DBG_MECMB,'1','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NUMORE_EXTRA'),0,DBG_EDT,'','','null','','S');

  //Devo fare qui aggirna totali e non in Componenti2Dataset del fra di dettaglio perchè prima il
  //clientDataset non è ancora caricato
  ((Self.Parent as TWR103FGestMasterDetail).WDettaglioFM as TWA172FSchedeQuantIndividualiDettFM).aggiornaTotali;
end;

procedure TWA172FAnagraficaDetailFM.AggiornaDettaglio;
begin
  inherited;
  //Devo fare qui aggiorna totali e non in Componenti2Dataset del fra di dettaglio perchè prima il
  //clientDataset non è ancora caricato
  ((Self.Parent as TWR103FGestMasterDetail).WDettaglioFM as TWA172FSchedeQuantIndividualiDettFM).aggiornaTotali;
end;

procedure TWA172FAnagraficaDetailFM.actAnnullaExecute(Sender: TObject);
begin
  ImpostaCampiReadOnly(False);
  inherited;
end;

procedure TWA172FAnagraficaDetailFM.actConfermaExecute(Sender: TObject);
begin
  ImpostaCampiReadOnly(False);
  inherited;
  //Totali calcolati da OnPostCdsT768 richiamata all'interno di inherited;
  (WR302DM AS TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.cdsT768Post(Totali);
  (Self.Parent as TWR103FGestMasterDetail).actAggiornaExecute(nil);
end;

procedure TWA172FAnagraficaDetailFM.OnPostCdsT768;
begin
  //Eseguita dopo il post di tutti i record del cds. posso conteggiare i totali
  Totali:=(WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.CalcolaTotali;
  if (Totali.MaxImp <> 0) and
     (R180AzzeraPrecisione(Totali.MaxImp - Totali.TotaleAccett,2) < 0) then
    raise exception.Create(A000MSG_A172_ERR_TOT_ORE_ACCETTATE);
end;

procedure TWA172FAnagraficaDetailFM.actModificaExecute(Sender: TObject);
begin
  if (Self.Parent as TWR103FGestMasterDetail).WR302DM.selTabella.FieldByName('STATO').AsString = 'C' then
  begin
    MsgBox.WebMessageDlg(A000MSG_A172_MSG_MODIFICA_DETAIL_NON_CONSENTITA,mtInformation,[mbOk],nil,'');
    Exit;
  end;
  ImpostaCampiReadOnly(True);
  inherited;
end;

procedure TWA172FAnagraficaDetailFM.ImpostaCampiReadOnly(InEdit: boolean);
begin
  //devo mettere i campi readonly solo quando sono in modifica.
  //Se imposto prima i campi a readonly da errore nel caricamento del Clientdataset
  //Se non imposto i campi reaonly in edit vengono creati i componenti
  with grdTabella.medpDataSet do
  begin
    FieldByName('MATRICOLA').ReadOnly:=InEdit;
    FieldByName('COGNOME').ReadOnly:=InEdit;
    FieldByName('NOME').ReadOnly:=InEdit;
    FieldByName('TOTQUOTAQUAL').ReadOnly:=InEdit;
    FieldByName('PARTTIME').ReadOnly:=InEdit;

    FieldByName('IMPORTO_ORARIO').ReadOnly:=InEdit;
    FieldByName('TOTALE_ACCETTATO').ReadOnly:=InEdit;
    FieldByName('DATO1').ReadOnly:=InEdit;
    FieldByName('DATO2').ReadOnly:=InEdit;
    FieldByName('DATO3').ReadOnly:=InEdit;
    FieldByName('NUMORE_TOTALI').ReadOnly:=InEdit;
    FieldByName('NUMORE_PAGATE').ReadOnly:=InEdit;
  end;
end;

procedure TWA172FAnagraficaDetailFM.grdTabellaComponenti2DataSet(Row: Integer);
var
  cmb: TmeIWComboBox;
begin
  cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALUTATORE'),0) as TMeIWComboBox);
  grdTabella.medpDataSet.FieldByName('VALUTATORE').AsString:=cmb.Text;
end;

procedure TWA172FAnagraficaDetailFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  cmb: TmeIWComboBox;
  val,Dato1,Dato2,Dato3,TipoStampaQuant: String;
begin
  inherited;
  //Obiettivi posizionati
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('OBIETTIVI_POSIZ'),0) as TmeIWImageFile) do
  begin
    Dato1:=Copy(grdTabella.medpValoreColonna(Row,'DATO1'),1,Pos(' - ',grdTabella.medpValoreColonna(Row,'DATO1'))-1);
    Dato2:=Copy(grdTabella.medpValoreColonna(Row,'DATO2'),1,Pos(' - ',grdTabella.medpValoreColonna(Row,'DATO2'))-1);
    Dato3:=Copy(grdTabella.medpValoreColonna(Row,'DATO3'),1,Pos(' - ',grdTabella.medpValoreColonna(Row,'DATO3'))-1);

    TipoStampaQuant:=(WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.getTipoStampaQuant(Dato1,Dato2,Dato3);

    if TipoStampaQuant <> '0' then
    begin
      Hint:='Definizione obiettivi posizionati';
      onClick:=imgObiettiviPosizClick;
    end
    else
    begin
      css:=css + ' invisibile';
    end;
  end;

  //flessibilità
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('FLESSIBILITA'),1) as TmeIWImageFile) do
  begin
    if grdTabella.medpValoreColonna(Row,'PARTTIME') = '100' then
    begin
      css:=css + ' invisibile';
    end
    else
    begin
      OnClick:=imgPartTimeClick;
    end;
  end;
  //inf Obiettivi
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INF_OBIETTIVI'),0) as TMedpIWMultiColumnComboBox) do
  begin
    AddRow('S');
    AddRow('N');
  end;
  //Valutazione
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('ACCETT_VALUTAZIONE'),0) as TMedpIWMultiColumnComboBox) do
  begin
    AddRow('S');
    AddRow('N');
  end;
  //Valutatore
  cmb:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALUTATORE'),0) as TMeIWComboBox);
  with (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW do
  begin
    cmb.NoSelectionText:=' ';
    selValutatori.First;
    while not selValutatori.Eof do
    begin
      cmb.Items.Add(selValutatori.FieldByName('VALUTATORE').AsString);
      val:=grdTabella.medpClientDataSet.FieldByName('VALUTATORE').AsString;
      if val = selValutatori.FieldByName('VALUTATORE').AsString then
      begin
        cmb.ItemIndex:=cmb.Items.Count - 1;
      end;
      selValutatori.Next;
    end;
  end;

  //Firma
  with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CONFERMATO'),0) as TMedpIWMultiColumnComboBox) do
  begin
    AddRow('S');
    AddRow('N');
  end;
end;

procedure TWA172FAnagraficaDetailFM.imgObiettiviPosizClick(Sender: TObject);
var
  WA172FObiettiviFM: TWA172FSchedeQuantObiettiviFM;
  FN,Dato1,Dato2,Dato3,TipoStampaQuant: String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  RowEdit:=grdTabella.medpRigaDiCompGriglia(FN);

  with (WR302DM as TWA172FSchedeQuantIndividualiDM) do
  begin
    A172FSchedeQuantIndividualiMW.ImpostaSelSG715(selTabella.FieldByName('ANNO').AsInteger,StrToIntDef(grdTabella.medpValoreColonna(RowEdit,'PROGRESSIVO'),0));
  end;
  WA172FObiettiviFM:=TWA172FSchedeQuantObiettiviFM.Create(Self.Owner);

  Dato1:=Copy(grdTabella.medpValoreColonna(RowEdit,'DATO1'),1,Pos(' - ',grdTabella.medpValoreColonna(RowEdit,'DATO1'))-1);
  Dato2:=Copy(grdTabella.medpValoreColonna(RowEdit,'DATO2'),1,Pos(' - ',grdTabella.medpValoreColonna(RowEdit,'DATO2'))-1);
  Dato3:=Copy(grdTabella.medpValoreColonna(RowEdit,'DATO3'),1,Pos(' - ',grdTabella.medpValoreColonna(RowEdit,'DATO3'))-1);

  TipoStampaQuant:=(WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.getTipoStampaQuant(Dato1,Dato2,Dato3);

  WA172FObiettiviFM.Visualizza(TipoStampaQuant);
end;


procedure TWA172FAnagraficaDetailFM.imgPartTimeClick(Sender: TObject);
var WC013: TWC013FCheckListFM;
  elencoFlessibilita: TElencoValoriCheckList;
  LstSel: TStringList;
  FN:String;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  RowEdit:=grdTabella.medpRigaDiCompGriglia(FN);

  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with (WR302DM as TWA172FSchedeQuantIndividualiDM) do
  begin
    elencoFlessibilita:=A172FSchedeQuantIndividualiMW.getLstFlessibilita;
    WC013.CaricaLista(elencoFlessibilita.lstDescrizione, elencoFlessibilita.lstCodice);
    FreeAndNil(elencoFlessibilita);
    LstSel:=TStringList.Create;
    LstSel.CommaText:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('FLESSIBILITA'),0) as TmeIWEdit).Text;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=FlessibilitaResult;
    WC013.Visualizza(0,0,'<WC013> Elenco Flessibilita');
  end;
end;

procedure TWA172FAnagraficaDetailFM.FlessibilitaResult(Sender: TObject; Result: Boolean);
var lst: TStringList;
begin
  if Result then
  begin
    lst:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('FLESSIBILITA'),0) as TmeIWEdit).Text:=lst.CommaText;
    FreeAndNil(lst);
  end;
end;

end.
