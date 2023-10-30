unit WA174UParPianifTurniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, DB,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, meIWRegion, IWCompExtCtrls, IWDBExtCtrls, OracleData,
  meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, IWCompButton, meIWButton,
  meIWDBComboBox, IWCompListbox, meIWDBLookupComboBox, IWCompGrids, meIWGrid,
  medpIWTabControl,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, A000UInterfaccia, WC013UCheckListFM,
  IWHTMLControls, meIWList, meIWListbox, meIWLink;

type
  TWA174FParPianifTurniDettFM = class(TWR205FDettTabellaFM)
    WA174PianificazioneRG: TmeIWRegion;
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    TemplatePianificazioneRG: TIWTemplateProcessorHTML;
    drgpModLavoro: TmeIWDBRadioGroup;
    lblModLavoro: TmeIWLabel;
    lblPianifOrd: TmeIWLabel;
    lblOpzioniPianif: TmeIWLabel;
    dChkPianifGGFest: TmeIWDBCheckBox;
    dChkPianifGGAss: TmeIWDBCheckBox;
    dChkPinifSoloTurnista: TmeIWDBCheckBox;
    lblProgressiva: TmeIWLabel;
    dchkGenera: TmeIWDBCheckBox;
    dchkIniziale: TmeIWDBCheckBox;
    dchkCorrente: TmeIWDBCheckBox;
    WA174StampaRG: TmeIWRegion;
    TemplateStampaRG: TIWTemplateProcessorHTML;
    lblTitolo: TmeIWLabel;
    dedtTitolo: TmeIWDBEdit;
    lblDesc1: TmeIWLabel;
    dedtDesc1: TmeIWDBEdit;
    lblDesc2: TmeIWLabel;
    dedtDesc2: TmeIWDBEdit;
    lblNotePagina: TmeIWLabel;
    dedtNotePagina: TmeIWDBEdit;
    lblDettStampa: TmeIWLabel;
    drgpDettStampa: TmeIWDBRadioGroup;
    lblOrdinamento: TmeIWLabel;
    lblTipoStampa: TmeIWLabel;
    drgpTipoStampa: TmeIWDBRadioGroup;
    lblDatiOpzionali: TmeIWLabel;
    dchkTotTurni: TmeIWDBCheckBox;
    dchkTotTurnoOpe: TmeIWDBCheckBox;
    dchkTotCopertura: TmeIWDBCheckBox;
    dChkVisOrario: TmeIWDBCheckBox;
    dChkToTurnitMese: TmeIWDBCheckBox;
    dchkDettOrari: TmeIWDBCheckBox;
    dchkTotLiquid: TmeIWDBCheckBox;
    dchkRigheNome: TmeIWDBCheckBox;
    dchkAssenze: TmeIWDBCheckBox;
    dchkSaldiOre: TmeIWDBCheckBox;
    dchkSeparatoreCol: TmeIWDBCheckBox;
    dchkSepratoreRighe: TmeIWDBCheckBox;
    lblCauEsclusione: TmeIWLabel;
    dEdtEcludiCaus: TmeIWDBEdit;
    btnCaus: TmeIWButton;
    lblMarginesx: TmeIWLabel;
    dedtMgSx: TmeIWDBEdit;
    lblDimFont: TmeIWLabel;
    dedtDimFont: TmeIWDBEdit;
    lblNumGG: TmeIWLabel;
    dedtNumGG: TmeIWDBEdit;
    lblDatoAnag: TmeIWLabel;
    dcmbDatoAnag: TmeIWDBLookupComboBox;
    lblOPagina: TmeIWLabel;
    dcmbOPagina: TmeIWDBComboBox;
    grdTabDetail: TmedpIWTabControl;
    dChkGiustifOpe: TmeIWDBCheckBox;
    dChkRendiOper: TmeIWDBCheckBox;
    lstElencoOrd: TmeIWListbox;
    grdOrdinamento: TmeIWGrid;
    lstElencoOrdStampa: TmeIWListbox;
    grdOrdinamentoStampa: TmeIWGrid;
    dChkStampaReperibilita: TmeIWDBCheckBox;
    dChkRiepNote: TmeIWDBCheckBox;
    lblLayout: TmeIWLabel;
    dchkRiduciRigheDip: TmeIWDBCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure drgpDettStampaClick(Sender: TObject);
    procedure dchkTotTurniAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkGeneraAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnCausClick(Sender: TObject);
    procedure drgpModLavoroClick(Sender: TObject);
    procedure WA174StampaRGRender(Sender: TObject);
    procedure lstElencoOrdDblClick(Sender: TObject);
    procedure lstElencoOrdStampaDblClick(Sender: TObject);
    procedure dchkRiduciRigheDipAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure dchkRigheNomeAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    WC013: TWC013FCheckListFM;
    strOrdVis, {StringList per ordinamento visualizzazione tabellone}
    strOrdStampa:TStringList; {StringList per ordinamento stampa tabellone}
    procedure OnClickUpVis(Sender:TObject);
    procedure OnClickDownVis(Sender:TObject);
    procedure OnClickEliminaVis(Sender:TObject);
    procedure OnClickUpStampa(Sender:TObject);
    procedure OnClickDownStampa(Sender:TObject);
    procedure OnClickEliminaStampa(Sender:TObject);
    procedure CaricaGrdOrdinamento(myGrdOrd:TmeIWGrid);
    procedure CausaliResult(Sender:TObject; Result:Boolean);
    procedure SpostaSu(Sender:TObject;myStrList:TStrings);
    procedure SpostaGiu(Sender:TObject;myStrList:TStrings);
    procedure Cancella(Sender:TObject;myStrList:TStrings);
  public
    procedure Abilitazioni;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure ReleaseOggetti; override;
    procedure AbilitaComponenti; override;
  end;


implementation

uses WA174UParPianifTurniDM, IWApplication;

{$R *.dfm}

procedure TWA174FParPianifTurniDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  strOrdVis:=TStringList.Create;
  strOrdStampa:=TStringList.Create;
  inherited;
  dCmbDatoAnag.ListSource:=(WR302DM as TWA174FParPianifTurniDM).A174MW.dsrI010;
  R180SetComboItemsValues(dCmbOPagina.Items,(WR302DM as TWA174FParPianifTurniDM).A174MW.Orientamento,'IV');
  grdTabDetail.AggiungiTab('Pianificazione',WA174PianificazioneRG);
  grdTabDetail.AggiungiTab('Stampa',WA174StampaRG);
  grdTabDetail.ActiveTab:=WA174PianificazioneRG;
  dChkRiepNote.Visible:=False; //Nascosto per ristrutturazione pianificazione turni. Se nessuno lo reclama, eliminare
  C190VisualizzaElemento(JQuery,'grpBoxProgressiva',(Parametri.CampiRiferimento.C11_PianifOrariProg = 'S'));

  //Gestione ordinamento in visualizzazione tabellone
  (WR302DM as TWA174FParPianifTurniDM).A174MW.CaricaListaDatiOrdinamento(lstElencoOrd.Items);
  lstElencoOrd.ItemIndex:=0;
  //Carico strOrdVis(Visualizzazione Tabellone)
  (WR302DM as TWA174FParPianifTurniDM).A174MW.CaricaOrdinamento('ORD_VIS',strOrdVis);
  //Carico grdOrdinamento(Visualizzazione Tabellone)
  CaricaGrdOrdinamento(grdOrdinamento);

  //Gestione ordinamento in stampa tabellone
  (WR302DM as TWA174FParPianifTurniDM).A174MW.CaricaListaDatiOrdinamento(lstElencoOrdStampa.Items);
  lstElencoOrdStampa.ItemIndex:=0;
  //Carico strOrdVis(Visualizzazione Tabellone)
  (WR302DM as TWA174FParPianifTurniDM).A174MW.CaricaOrdinamento('ORD_STAMPA',strOrdStampa);
  //Carico grdOrdinamento(Visualizzazione Tabellone)
  CaricaGrdOrdinamento(grdOrdinamentoStampa);
end;

procedure TWA174FParPianifTurniDettFM.SpostaSu(Sender:TObject; myStrList:TStrings);
var
  IndiceItem:integer;
  StrSwap:string;
begin
  IndiceItem:=(Sender as TmeIWLink).Tag;
  if IndiceItem > 0 then
  begin
    StrSwap:=myStrList[IndiceItem - 1];
    myStrList[IndiceItem - 1]:=myStrList[IndiceItem];
    myStrList[IndiceItem]:=StrSwap;
  end;
end;

procedure TWA174FParPianifTurniDettFM.SpostaGiu(Sender:TObject;myStrList:TStrings);
var
  IndiceItem:integer;
  StrSwap:string;
begin
  IndiceItem:=(Sender as TmeIWLink).Tag;
  if IndiceItem < myStrList.Count - 1 then
  begin
    StrSwap:=myStrList[IndiceItem + 1];
    myStrList[IndiceItem + 1]:=myStrList[IndiceItem];
    myStrList[IndiceItem]:=StrSwap;
  end;
end;

procedure TWA174FParPianifTurniDettFM.Cancella(Sender:TObject;myStrList:TStrings);
var
  IndiceItem:integer;
begin
  IndiceItem:=(Sender as TmeIWLink).Tag;
  myStrList.Delete(IndiceItem);
end;

procedure TWA174FParPianifTurniDettFM.AbilitaComponenti;
begin
  CaricaGrdOrdinamento(grdOrdinamento);
  CaricaGrdOrdinamento(grdOrdinamentoStampa);
end;

procedure TWA174FParPianifTurniDettFM.DataSet2Componenti;
begin
  //Carico strOrdVis
  (WR302DM as TWA174FParPianifTurniDM).A174MW.CaricaOrdinamento('ORD_VIS',strOrdVis);
  //Carico grdOrdinamento
  CaricaGrdOrdinamento(grdOrdinamento);

  //Carico strOrdStampa
  (WR302DM as TWA174FParPianifTurniDM).A174MW.CaricaOrdinamento('ORD_STAMPA',strOrdStampa);
  //Carico grdOrdinamentoStampa
  CaricaGrdOrdinamento(grdOrdinamentoStampa);
end;

procedure TWA174FParPianifTurniDettFM.Componenti2DataSet;
begin
 //Salvo su db il contenuto delle grid di ordinamento
 //Visualizzazione
 (WR302DM as TWA174FParPianifTurniDM).selTabella.FieldByName('ORD_VIS').AsString:=
 (WR302DM as TWA174FParPianifTurniDM).A174MW.SalvaOrdinamento(strOrdVis);
 //Stampa
 (WR302DM as TWA174FParPianifTurniDM).selTabella.FieldByName('ORD_STAMPA').AsString:=
 (WR302DM as TWA174FParPianifTurniDM).A174MW.SalvaOrdinamento(strOrdStampa);
end;

procedure TWA174FParPianifTurniDettFM.lstElencoOrdDblClick(Sender: TObject);
begin
  inherited;
  //(Visualizzazione)Aggiungo campo ordinamento, se non presente
  if strOrdVis.IndexOf(lstElencoOrd.Items[lstElencoOrd.ItemIndex]) <= -1 then
  begin
    strOrdVis.Add(lstElencoOrd.Items[lstElencoOrd.ItemIndex]);
    CaricaGrdOrdinamento(grdOrdinamento);
  end;
end;

procedure TWA174FParPianifTurniDettFM.lstElencoOrdStampaDblClick(Sender: TObject);
begin
  inherited;
  //(Stampa)Aggiungo campo ordinamento, se non presente
  if strOrdStampa.IndexOf(lstElencoOrdStampa.Items[lstElencoOrdStampa.ItemIndex]) <= -1 then
  begin
    strOrdStampa.Add(lstElencoOrdStampa.Items[lstElencoOrdStampa.ItemIndex]);
    CaricaGrdOrdinamento(grdOrdinamentoStampa);
  end;
end;

procedure TWA174FParPianifTurniDettFM.OnClickUpStampa(Sender:TObject);
begin
  SpostaSu(Sender,strOrdStampa);
  CaricaGrdOrdinamento(grdOrdinamentoStampa);
end;

procedure TWA174FParPianifTurniDettFM.OnClickDownStampa(Sender:TObject);
begin
  SpostaGiu(Sender,strOrdStampa);
  CaricaGrdOrdinamento(grdOrdinamentoStampa);
end;

procedure TWA174FParPianifTurniDettFM.OnClickEliminaStampa(Sender:TObject);
begin
  Cancella(Sender,strOrdStampa);
  CaricaGrdOrdinamento(grdOrdinamentoStampa);
end;

procedure TWA174FParPianifTurniDettFM.OnClickUpVis(Sender:TObject);
begin
  SpostaSu(Sender,strOrdVis);
  CaricaGrdOrdinamento(grdOrdinamento);
end;

procedure TWA174FParPianifTurniDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(strOrdVis);
  FreeAndNil(strOrdStampa);
end;

procedure TWA174FParPianifTurniDettFM.OnClickDownVis(Sender:TObject);
var
  IndiceItem:integer;
  StrSwap:string;
begin
  SpostaGiu(Sender,strOrdVis);
  CaricaGrdOrdinamento(grdOrdinamento);
end;

procedure TWA174FParPianifTurniDettFM.OnClickEliminaVis(Sender:TObject);
begin
  Cancella(Sender,strOrdVis);
  CaricaGrdOrdinamento(grdOrdinamento);
end;

procedure TWA174FParPianifTurniDettFM.CaricaGrdOrdinamento(myGrdOrd:TmeIWGrid);
var
  c,r:integer;
  Stato:boolean;
  myStrList:TStringList;
begin
  myStrList:=nil;
  if myGrdOrd = grdOrdinamento then
    myStrList:=strOrdVis
  else if myGrdOrd = grdOrdinamentoStampa then
    myStrList:=strOrdStampa;
  C190PulisciIWGrid(myGrdOrd,True);
  myGrdOrd.ColumnCount:=4;
  myGrdOrd.RowCount:=myStrList.Count;
  Stato:=(WR302DM as TWA174FParPianifTurniDM).selTabella.State in [dsEdit,dsInsert];
  for r:=0 to myStrList.Count - 1 do
  begin
    if r > 0 then
    begin
      //Link sposta item in alto
      myGrdOrd.Cell[r,0].Css:='';
      myGrdOrd.Cell[r,0].control:=TmeIWLink.Create(Self);
      myGrdOrd.Cell[r,0].control.Css:='ui-icon ui-icon-circle-triangle-n';
      (myGrdOrd.Cell[r,0].control as TmeIWLink).Enabled:=Stato;
      //In base alla Tabella da visualizzare assegno gli aventi dedicati alla stampa o alla visualizzazione
      if myGrdOrd = grdOrdinamento then
        (myGrdOrd.Cell[r,0].control as TmeIWLink).OnClick:=OnClickUpVis
      else
        (myGrdOrd.Cell[r,0].control as TmeIWLink).OnClick:=OnClickUpStampa;
      (myGrdOrd.Cell[r,0].control as TmeIWLink).Tag:=r;
    end;
    if r < myStrList.Count - 1 then
    begin
      //Link sposta item in basso
      myGrdOrd.Cell[r,1].Css:='';
      myGrdOrd.Cell[r,1].control:=TmeIWLink.Create(Self);
      myGrdOrd.Cell[r,1].control.Css:='ui-icon ui-icon-circle-triangle-s';
      (myGrdOrd.Cell[r,1].control as TmeIWLink).Enabled:=Stato;
      //In base alla Tabella da visualizzare assegno gli aventi dedicati alla stampa o alla visualizzazione
      if myGrdOrd = grdOrdinamento then
        (myGrdOrd.Cell[r,1].control as TmeIWLink).OnClick:=OnClickDownVis
      else
        (myGrdOrd.Cell[r,1].control as TmeIWLink).OnClick:=OnClickDownStampa;
      (myGrdOrd.Cell[r,1].control as TmeIWLink).Tag:=r;
    end;
    //Link elimina item
    myGrdOrd.Cell[r,2].Css:='';
    myGrdOrd.Cell[r,2].control:=TmeIWLink.Create(Self);
    myGrdOrd.Cell[r,2].control.Css:='ui-icon ui-icon-circle-minus';
    (myGrdOrd.Cell[r,2].control as TmeIWLink).Enabled:=Stato;
    //In base alla Tabella da visualizzare assegno gli aventi dedicati alla stampa o alla visualizzazione
    if myGrdOrd = grdOrdinamento then
      (myGrdOrd.Cell[r,2].control as TmeIWLink).OnClick:=OnClickEliminaVis
    else
      (myGrdOrd.Cell[r,2].control as TmeIWLink).OnClick:=OnClickEliminaStampa;
    (myGrdOrd.Cell[r,2].control as TmeIWLink).Tag:=r;
    //Testo campo ordinamento
    myGrdOrd.Cell[r,3].Css:='width20chr';
    myGrdOrd.Cell[r,3].Text:=myStrList[r];
  end;
end;

procedure TWA174FParPianifTurniDettFM.WA174StampaRGRender(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TWA174FParPianifTurniDettFM.btnCausClick(Sender: TObject);
var
  LstCausaliSelezionate : TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  with TOracleDataSet.Create(Self) do
    try
      Session:=SessioneOracle;
      SQL.Add((WR302DM as TWA174FParPianifTurniDM).A174MW.SqlCausali);
      Open;
      WC013.ckList.Items.Clear;
      while not Eof do
      begin
        WC013.ckList.Items.Add(Format('%-5s',[FieldByName('CODICE').AsString]) + ' ' +
                                              FieldByName('DESCRIZIONE').AsString);
        WC013.ckList.Values.Add(Trim(FieldByName('CODICE').AsString));
        Next;
      end;
      LstCausaliSelezionate:=TStringList.Create;
      LstCausaliSelezionate.CommaText:=(WR302DM as TWA174FParPianifTurniDM).SelTabella.FieldByName('CAUS_ECLUDITURNO').AsString;
      WC013.ImpostaValoriSelezionati(LstCausaliSelezionate);
      FreeAndNil(LstCausaliSelezionate);
      WC013.ResultEvent:=CausaliResult;
      WC013.Visualizza(0,0,'<WC013> Causali esclusione turno');
    finally
      Free;
    end;
end;

procedure TWA174FParPianifTurniDettFM.CausaliResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    (WR302DM as TWA174FParPianifTurniDM).SelTabella.FieldByName('CAUS_ECLUDITURNO').AsString:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
  end;
end;

procedure TWA174FParPianifTurniDettFM.dchkGeneraAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if ((WR302DM as TWA174FParPianifTurniDM).selTabella.State in [dsInsert,dsEdit]) and dchkGenera.Checked then
    (WR302DM as TWA174FParPianifTurniDM).selTabella.FieldByName('INIZIALE').AsString:='S';
end;

procedure TWA174FParPianifTurniDettFM.dchkRiduciRigheDipAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  Abilitazioni;
end;

procedure TWA174FParPianifTurniDettFM.dchkRigheNomeAsyncClick(Sender: TObject;EventParams: TStringList);
begin
  inherited;
  Abilitazioni;
end;

procedure TWA174FParPianifTurniDettFM.dchkTotTurniAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Abilitazioni;
end;

procedure TWA174FParPianifTurniDettFM.drgpDettStampaClick(Sender: TObject);
begin
  Abilitazioni;
end;

procedure TWA174FParPianifTurniDettFM.drgpModLavoroClick(Sender: TObject);
begin
  inherited;
  Abilitazioni;
end;

procedure TWA174FParPianifTurniDettFM.Abilitazioni;
var
  s:string;
begin
  with (WR302DM as TWA174FParPianifTurniDM).selTabella do
  begin
    dChkRendiOper.Visible:=drgpModLavoro.ItemIndex = 1;

    dChkRiduciRigheDip.Enabled:=not dChkRigheNome.Checked;
    if (not dChkRiduciRigheDip.Enabled) and (State in [dsEdit,dsInsert]) then
      FieldByName('COMPATTA_RIGHE_DIP').AsString:='N';

    dChkRigheNome.Enabled:=not dChkRiduciRigheDip.Checked;
    if (not dChkRigheNome.Enabled) and (State in [dsEdit,dsInsert]) then
      FieldByName('RIGHE_NOME').AsString:='N';

    dEdtEcludiCaus.Enabled:=drgpTipoStampa.ItemIndex = 1;
    btnCaus.Enabled:=dEdtEcludiCaus.Enabled and (State in [dsEdit,dsInsert]);

    dChkVisOrario.Enabled:=drgpDettStampa.ItemIndex = 0;
    if not dChkVisOrario.Enabled and (State in [dsEdit,dsInsert]) then
      FieldByName('ORARIO_SINTETICO').AsString:='N';

    dChkTotLiquid.Enabled:=drgpTipoStampa.ItemIndex = 1;
    if not dChkTotLiquid.Enabled and (State in [dsEdit,dsInsert]) then
      FieldByName('TOT_LIQUIDABILE').AsString:='N';

    dchkTotTurnoOpe.Enabled:=dChkTotTurni.Checked;
    if not dchkTotTurnoOpe.Enabled and (State in [dsEdit,dsInsert]) then
      FieldByName('TOT_OPE_TURNO').AsString:='N';
  end;
end;

end.
