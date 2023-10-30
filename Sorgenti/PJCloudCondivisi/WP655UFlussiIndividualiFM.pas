unit WP655UFlussiIndividualiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWCompExtCtrls, meIWRadioGroup, IWCompLabel, meIWLabel, WP655UDatiINPDAPMMDM,
  Data.DB, WR100UBase, C190FunzioniGeneraliWeb, meIWImageFile, A000UInterfaccia,
  medpIWMessageDlg, WC015USelEditGridFM, meIWEdit, OracleData, medpIWImageButton,
  WC013UCheckListFM, A000UCostanti;

type
  TWP655FFlussiIndividualiFM = class(TWR203FGestDetailFM)
    rgpTipoDati: TmeIWRadioGroup;
    lblTipoDati: TmeIWLabel;
    rgpTipoRecord: TmeIWRadioGroup;
    btnFiltroParte: TmedpIWImageButton;
    btnFiltroNumeri: TmedpIWImageButton;
    btnFiltroProg: TmedpIWImageButton;
    lblTipoRecord: TmeIWLabel;
    procedure rgpTipoDatiClick(Sender: TObject);
    procedure rgpTipoRecordClick(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure btnFiltroParteClick(Sender: TObject);
    procedure btnFiltroNumeriClick(Sender: TObject);
    procedure btnFiltroProgClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
  private
    RowEdit: Integer;
    procedure AbilitazioneComponenti;
    procedure imgElencoPartiClick(Sender: TObject);
    procedure ResultElencoParti(Sender: TObject; Result: Boolean);
    procedure edtNumeroParteAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure FiltroParteResult(Sender: TObject; Result: Boolean);
    procedure FiltroNumeriResult(Sender: TObject; Result: Boolean);
    procedure FiltroProgrResult(Sender: TObject; Result: Boolean);
    procedure edtValoreAsyncChange(Sender: TObject; EventParams: TStringList);
  public
    bCopiaSu: Boolean;
    ParteOrig, NumeroOrig,ProgressivoOrig,ValoreOrig: String;
    procedure CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource); override;
    procedure DataSourceStateChange(Sender: TObject); override;
  end;

implementation

uses
  WP655UDatiINPDAPMM;

{$R *.dfm}

{ TWP655FFlussiIndividualiFM }

procedure TWP655FFlussiIndividualiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  bCopiaSu:=False;
  if (Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso = FLUSSO_INPDAP then
    rgpTipoDati.Visible:=True
  else
  begin
    C190VisualizzaElemento(JQuery,'divTipoDati',False);
    rgpTipoDati.Visible:=False;
  end;
end;

procedure TWP655FFlussiIndividualiFM.actCopiaSuExecute(Sender: TObject);
begin
  bCopiaSu:=True;
  ParteOrig:=grdTabella.medpDataSet.FieldByName('PARTE').AsString;
  NumeroOrig:=grdTabella.medpDataSet.FieldByName('NUMERO').AsString;
  ProgressivoOrig:=grdTabella.medpDataSet.FieldByName('PROGRESSIVO_NUMERO').AsString;
  ValoreOrig:=grdTabella.medpDataSet.FieldByName('VALORE').AsString;
  actNuovoExecute(actNuovo);
  bCopiaSu:=False;
end;

procedure TWP655FFlussiIndividualiFM.btnFiltroNumeriClick(Sender: TObject);
var
  elencoValoriCheckList: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
begin
  try
    elencoValoriCheckList:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.ElencoNumeriChecklist((Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso);

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(elencoValoriCheckList.LstDescrizione, elencoValoriCheckList.lstCodice);
    LstSel:=TStringList.Create;
    LstSel.StrictDelimiter:=True;
    LstSel.CommaText:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.DatiSelezionati;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=FiltroNumeriResult;
    WC013.Visualizza(0,0,'<WC013> Filtro Numeri');

  finally
    FreeAndNil(elencoValoriCheckList);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP655FFlussiIndividualiFM.FiltroNumeriResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    with (WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW do
    begin
      lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
      PartiSelezionate:='';
      DatiSelezionati:=lstTmp.CommaText;
      FreeAndNil(lstTmp);
      //Modifico la query aggiungendo il filtro sulle voci selezionate
      ModificaQuery((Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso,rgpTipoDati.ItemIndex, rgpTipoRecord.ItemIndex);
      grdTabella.medpAggiornaCDS(True);
    end;
  end;
end;

procedure TWP655FFlussiIndividualiFM.btnFiltroParteClick(Sender: TObject);
var
  elencoValoriCheckList: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
begin
  try
    elencoValoriCheckList:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.ElencoPartiChecklist((Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso);

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(elencoValoriCheckList.LstDescrizione, elencoValoriCheckList.lstCodice);
    LstSel:=TStringList.Create;
    LstSel.CommaText:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.PartiSelezionate;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=FiltroParteResult;
    WC013.Visualizza(0,0,'<WC013> Filtro Parte');
  finally
    FreeAndNil(elencoValoriCheckList);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP655FFlussiIndividualiFM.btnFiltroProgClick(Sender: TObject);
var
  elencoValoriCheckList: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
  LstSel: TStringList;
begin
  try
    elencoValoriCheckList:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.ElencoProgrChecklist(rgpTipoDati.ItemIndex);

    WC013:=TWC013FCheckListFM.Create(Self.Owner);
    WC013.CaricaLista(elencoValoriCheckList.LstDescrizione, elencoValoriCheckList.lstCodice);
    LstSel:=TStringList.Create;
    LstSel.CommaText:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.ProgrSelezionati;
    WC013.ImpostaValoriSelezionati(LstSel);
    FreeAndNil(LstSel);
    WC013.ResultEvent:=FiltroProgrResult;
    WC013.Visualizza(0,0,'<WC013> Filtro Progressivi');

  finally
    FreeAndNil(elencoValoriCheckList);
    if LstSel <> nil then
      FreeAndNil(LstSel);
  end;
end;

procedure TWP655FFlussiIndividualiFM.FiltroProgrResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    with (WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW do
    begin
      lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
      ProgrSelezionati:=lstTmp.CommaText;
      FreeAndNil(lstTmp);
      //Modifico la query aggiungendo il filtro sulle voci selezionate
      ModificaQuery((Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso,rgpTipoDati.ItemIndex, rgpTipoRecord.ItemIndex);
      grdTabella.medpAggiornaCDS(True);
    end;
  end;
end;

procedure TWP655FFlussiIndividualiFM.FiltroParteResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    with (WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW do
    begin
      lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
      DatiSelezionati:='';
      PartiSelezionate:=lstTmp.CommaText;
      FreeAndNil(lstTmp);
      //Modifico la query aggiungendo il filtro sulle voci selezionate
      ModificaQuery((Self.Owner as TWP655FDatiINPDAPMM).NomeFlusso,rgpTipoDati.ItemIndex, rgpTipoRecord.ItemIndex);
      grdTabella.medpAggiornaCDS(True);
    end;
  end;
end;

procedure TWP655FFlussiIndividualiFM.CaricaDettaglio(DataSet: TDataSet;
  DataSource: TDataSource);
begin
  //Devo forzare caricamento perchè all'avvio  il pannello Detail e nullo
  //e quindo il caricamento è inibito da exit;
  rgpTipoDati.ItemIndex:=0;
  rgpTipoRecord.ItemIndex:=0;
  (WR302DM AS TWP655FDatiINPDAPMMDM).CaricaFlussiIndividuali;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PARTE'),0,DBG_EDT,'','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PARTE'),1,DBG_IMG,'','CAMBIADATO','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('NUMERO'),0,DBG_EDT,'','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('PROGRESSIVO_NUMERO'),0,DBG_EDT,'input_num_nnnn','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('D_DESCRIZIONE'),0,DBG_LBL,'40','','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO_RECORD'),0,DBG_EDT,'','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('VALORE'),0,DBG_EDT,'','','','','S');
end;

procedure TWP655FFlussiIndividualiFM.DataSourceStateChange(Sender: TObject);
begin
  inherited;
  AbilitazioneComponenti;
end;

procedure TWP655FFlussiIndividualiFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  img: TmeIWImageFile;
  edt: TmeIWEdit;
begin
  inherited;
  img:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PARTE'),1) as TmeIWImageFile);
  if img <> nil then  //in modifica componente non creato
  begin
    img.OnClick:=imgElencoPartiClick;
  end;
  //numero e parte modificabili solo in inserimento
  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PARTE'),0) as TmeIWEdit);
  if edt <> nil then
  begin
    edt.OnAsyncChange:=edtNumeroParteAsyncChange;
  end;
  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUMERO'),0) as TmeIWEdit);
  if edt <> nil then
  begin
    edt.OnAsyncChange:=edtNumeroParteAsyncChange;
  end;
  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALORE'),0) as TmeIWEdit);
  if edt <> nil then
  begin
    edt.OnAsyncChange:=edtValoreAsyncChange;
  end;
end;

procedure TWP655FFlussiIndividualiFM.edtValoreAsyncChange(Sender: TObject; EventParams: TStringList);
var
  edt: TmeIWEdit;
  Row: Integer;
  valoreFormattato, msg: String;
  Parte: String;
  Numero: String;
begin
  //imposto anche il dataset in modo che venga aggiornato il campo d_descrizione (calcolato)
  Row:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);

  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PARTE'),0) as TmeIWEdit);
  if edt <> nil then
    Parte:=edt.Text //in insert editbox
  else
    Parte:=grdtabella.medpValoreColonna(Row,'PARTE'); //in modifica componente non presente

  edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUMERO'),0) as TmeIWEdit);
  if edt <> nil then
    Numero:=edt.Text //in insert editbox
  else
    Numero:=grdtabella.medpValoreColonna(Row,'NUMERO'); //in modifica componente non presente

  with (WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW do
  begin
    edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('VALORE'),0) as TmeIWEdit);
    valoreFormattato:='';
    if Trim(edt.Text) <> '' then
    begin
      msg:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.ImpostaValore(Parte, Numero, edt.Text,valoreFormattato);
      if msg <> '' then
        raise Exception.Create(msg);
    end;
    p663.FieldByName('VALORE').asString:=valoreFormattato;
    edt.Text:=valoreFormattato;
  end;
end;

procedure TWP655FFlussiIndividualiFM.edtNumeroParteAsyncChange(Sender: TObject; EventParams: TStringList);
var
  edt: TmeIWEdit;
  Row: Integer;
  lbl: TmeIWLabel;
begin
  //imposto anche il dataset in modo che venga aggiornato il campo d_descrizione (calcolato)
  //numero e parte modificabili solo in inserimento (in modifica il dataset P663 non è posizionato su record corretto perchè modifica multipla di righe)
  Row:=grdTabella.medpRigaDiCompGriglia((Sender as TmeIWEdit).FriendlyName);
  with (WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW do
  begin
    edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('PARTE'),0) as TmeIWEdit);
    p663.OnCalcFields:=nil; //devo rimuovere perchè riposiziona selP660; come win...
    p663.FieldByName('PARTE').asString:=edt.Text;
    edt:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('NUMERO'),0) as TmeIWEdit);
    p663.OnCalcFields:=P663CalcFields;
    p663.FieldByName('NUMERO').asString:=edt.Text;
   end;

  lbl:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('D_DESCRIZIONE'),0) as TmeIWLabel);
  lbl.caption:=grdtabella.medpDataset.FieldByName('D_DESCRIZIONE').asString;
end;

procedure TWP655FFlussiIndividualiFM.imgElencoPartiClick(Sender: TObject);
var
  WC015: TWC015FSelEditGridFM;
  Parte: String;
  Numero: String;
begin
  WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
  RowEdit:=grdtabella.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Parte:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('PARTE'),0) as TmeIWEdit).Text;
  Numero:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('NUMERO'),0) as TmeIWEdit).Text;
  WC015.medpCurrRecord:=(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.selP660.SearchRecord('PARTE;NUMERO',VarArrayOf([Parte,Numero]),[srFromBeginning]);
  WC015.medpSearchKind:=skContent;
  WC015.medpSearchField:='DESCRIZIONE';
  WC015.medpSearchFilter:=Format('%s=''%s*''',['PARTE',Parte]);
  WC015.ResultEvent:=ResultElencoParti;
  WC015.Visualizza('Elenco dati',(WR302DM AS TWP655FDatiINPDAPMMDM).P655FDatiINPDAPMMMW.selP660,False,False,True);
end;

procedure TWP655FFlussiIndividualiFM.ResultElencoParti(Sender: TObject; Result: Boolean);
var
  edt: TmeIWEdit;
  lbl: TmeIWLabel;
begin
  if Result then
  begin
    with (WR302DM AS TWP655FDatiINPDAPMMDM) do
    begin
      //imposto anche il dataset in modo che venga aggiornato il campo d_descrizione (calcolato)
      edt:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('PARTE'),0) as TmeIWEdit);
      edt.Text:=P655FDatiINPDAPMMMW.selP660.FieldByName('PARTE').AsString;
      P655FDatiINPDAPMMMW.p663.OnCalcFields:=nil; //devo rimuovere perchè riposiziona selP660; come win...
      P655FDatiINPDAPMMMW.p663.FieldByName('PARTE').asString:=edt.Text;
      edt:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('NUMERO'),0) as TmeIWEdit);
      edt.Text:=P655FDatiINPDAPMMMW.selP660.FieldByName('NUMERO').AsString;
      P655FDatiINPDAPMMMW.p663.OnCalcFields:=P655FDatiINPDAPMMMW.P663CalcFields;
      P655FDatiINPDAPMMMW.p663.FieldByName('NUMERO').asString:=edt.Text;

      lbl:=(grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('D_DESCRIZIONE'),0) as TmeIWLabel);
      lbl.caption:=grdtabella.medpDataset.FieldByName('D_DESCRIZIONE').asString;
    end;
  end;
end;

procedure TWP655FFlussiIndividualiFM.AbilitazioneComponenti;
var
  Browse: Boolean;
begin
  Browse:=not (grdTabella.medpDataSet.State in [dsInsert,dsEdit]);
  rgpTipoDati.Enabled:=Browse;
  rgpTipoRecord.Enabled:=Browse;
  btnFiltroParte.Enabled:=Browse;
  btnFiltroNumeri.Enabled:=Browse;
  btnFiltroProg.Enabled:=Browse;

  if (rgpTipoRecord.ItemIndex <> 0) or
     (WR302DM.selTabella.FieldByName('CHIUSO').AsString = 'S') or
     ((rgpTipoDati.ItemIndex = 0) and ((Self.Owner as TWR100FBase).grdC700.selAnagrafe.RecordCount = 0)) then
  begin
    actCopiaSu.Enabled:=False;
    actNuovo.Enabled:=False;
    actModifica.Enabled:=False;
    actElimina.Enabled:=False;
  end
  else
  begin
    actCopiaSu.Enabled:=Browse and not(TWR100FBase(Self.Owner).SolaLettura);
    actNuovo.Enabled:=actCopiaSu.Enabled;
    actModifica.Enabled:=actCopiaSu.Enabled;
    actElimina.Enabled:=actCopiaSu.Enabled;
  end;
  TWR100FBase(Self.Owner).AggiornaToolBar(grdDetailNavBar,actlstDetailNavBar);
  TWR100FBase(Self.Owner).grdC700.Visible:=rgpTipoDati.ItemIndex = 0;
end;

procedure TWP655FFlussiIndividualiFM.rgpTipoDatiClick(Sender: TObject);
begin
  inherited;
  with (WR302DM AS TWP655FDatiINPDAPMMDM) do
  begin
    P655FDatiINPDAPMMMW.FiltraP660(rgpTipoDati.ItemIndex);
    CaricaFlussiIndividuali;
    grdTabella.medpAggiornaCDS(True);
  end;
  AbilitazioneComponenti;
end;

procedure TWP655FFlussiIndividualiFM.rgpTipoRecordClick(Sender: TObject);
begin
  inherited;
  with (WR302DM AS TWP655FDatiINPDAPMMDM) do
  begin
    CaricaFlussiIndividuali;
    grdTabella.medpAggiornaCDS(True);
  end;

  AbilitazioneComponenti;
end;

end.
