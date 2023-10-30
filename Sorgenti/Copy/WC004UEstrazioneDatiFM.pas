unit WC004UEstrazioneDatiFM;

interface

uses
  WR100UBase, WR200UBaseFM, WR302UGestTabellaDM, A000UInterfaccia,
  C190FunzioniGeneraliWeb,C180FunzioniGenerali,
  SysUtils, Classes, Controls, Forms, Variants, medpIWMessageDlg,
  IWVCLBaseContainer, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, OracleData, DB,
  StrUtils,
  IWAdvRadioGroup, meTIWAdvRadioGroup, meIWButton, meIWGrid,
  IWDBGrids, medpIWDBGrid, Math, IWCompListbox, meIWListbox,
  IWCompLabel, meIWLabel, DBClient, IWCompMemo, meIWMemo, IWHTMLControls, meIWLink,
  meIWComboBox, meIWEdit, IWCompGrids, IWCompJQueryWidget,IWApplication,
  IWCompEdit;

type
  TModalitaEstrazione = (meStandard,meAvanzata);

  TStampa = record
    NomeStampa,
    Descrizione: String;
  end;

  TSelezione = record
    Seleziona,
    Ordina,
    Filtro: TmeIWLink;
    Alias,
    Valore1,
    Valore2: TmeIWEdit;
    Operatore: TmeIWComboBox;
  end;

  TWC004FEstrazioneDatiFM = class(TWR200FBaseFM)
    grdEsportazione: TmedpIWDBGrid;
    rgpModalita: TmeTIWAdvRadioGroup;
    lblSelezione: TmeIWLabel;
    lblOrdinamento: TmeIWLabel;
    btnEsegui: TmeIWButton;
    btnEsportaInExcel: TmeIWButton;
    btnChiudi: TmeIWButton;
    dsrDati: TDataSource;
    cdsDati: TClientDataSet;
    memQuery: TmeIWMemo;
    lblQuery: TmeIWLabel;
    lblInfo: TmeIWLabel;
    btnCarica: TmeIWButton;
    btnSalva: TmeIWButton;
    btnElimina: TmeIWButton;
    grdCampiSelA: TmeIWGrid;
    lbCampiSelB: TmeIWListbox;
    edtStampe: TmeIWEdit;
    jQLayout: TIWJQueryWidget;
    btnSelRemAll: TmeIWButton;
    lbCampiOrdB: TmeIWListbox;
    btnSelAddAll: TmeIWButton;
    btnOrdRemAll: TmeIWButton;
    btnPulisci: TmeIWButton;
    btnEsportaInCSV: TmeIWButton;
    procedure grdEsportazioneRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnEsportaInExcelClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure rgpModalitaClick(Sender: TObject);
    procedure btnSalvaClick(Sender: TObject);
    procedure btnCaricaClick(Sender: TObject);
    procedure btnEliminaClick(Sender: TObject);
    procedure btnCampoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnOrdinaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbOperatoreAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure lbCampiSelBAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure lbCampiOrdBAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure memQueryAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnPulisciClick(Sender: TObject);
    procedure grdCampiSelARenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    TestoQueryOrig: String;
    NomeTabella: String;
    FModalita: TModalitaEstrazione;
    SalvaStdSql,SqlManuale: Boolean;
    ListaImpostazioni: TStringList;
    StampeArr: array of TStampa;
    Griglia: array of TSelezione;
    SenderModalita: TObject;
    DataSet:TOracleDataSet;
    function  FindIndexGriglia(const Tipo,Nome: String): Integer;
    procedure PulisciGriglia;
    procedure CaricaGriglia;
    function  NumParam(const Op: String): Integer;
    function  GetTestoQuery: String;
    procedure OnRisposta(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure CambiaModalita(Sender: TObject);
    function  GetModalita: TModalitaEstrazione;
    procedure SetModalita(const Val: TModalitaEstrazione);
    function  IsParolaRiservataSql(const Parola: String): Boolean;
    procedure AggiornaConteggiCampi;
    procedure GetImpostazioni;
    procedure SetImpostazioni0;
    procedure SetImpostazioni;
    procedure DelImpostazioni0;
    procedure DelImpostazioni;
    procedure CaricaInterfaccia;
    procedure SalvaInterfaccia;
    procedure Reimposta;
    procedure ImpostaJQuery;
  public
    procedure ReleaseOggetti; override;
    procedure InizializzaQuery(Sender: TControl);
    procedure Visualizza;
    procedure CreaColonne;
    procedure CaricaArray;
    procedure CaricaDati(DBG_ROWID:String = '');
    property Modalita: TModalitaEstrazione read GetModalita write SetModalita;
    property TestoQuery: String read GetTestoQuery;
  end;

implementation

{$R *.dfm}

uses WR102UGestTabella, WR203UGestDetailFM;

procedure TWC004FEstrazioneDatiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  // dataset di appoggio per estrazione dati
  //WR302DM.selEstrazioneDati.SQL.Text:='select T.* from ' + TWR102FGestTabella(Self.Parent).InterfacciaWR102.NomeTabella + ' T where rownum < 0';
  //TestoQueryOrig:=WR302DM.selEstrazioneDati.SQL.Text;
  //InizializzaQuery(Self.Parent);//Non serve perchè richiamata dopo dal chiamante
  SqlManuale:=False;
  ListaImpostazioni:=TStringList.Create;
  SetLength(StampeArr,0);
  SetLength(Griglia,0);

  rgpModalita.ItemIndex:=0;
  rgpModalitaClick(nil);
end;

procedure TWC004FEstrazioneDatiFM.InizializzaQuery(Sender: TControl);
begin
  if Sender is TWR102FGestTabella then
  begin
    DataSet:=WR302DM.selTabella;
    NomeTabella:=(Sender as TWR102FGestTabella).InterfacciaWR102.NomeTabella;
  end
  else if Sender is TWR203FGestDetailFM then
  begin
    DataSet:=((Sender as TWR203FGestDetailFM).grdTabella.medpDataSet as TOracleDataSet);
    NomeTabella:=R180Query2NomeTabella(DataSet);
  end;
  WR302DM.selEstrazioneDati.SQL.Text:='select T.* from ' + NomeTabella + ' T where rownum < 0';
  TestoQueryOrig:=WR302DM.selEstrazioneDati.SQL.Text;
end;

procedure TWC004FEstrazioneDatiFM.ImpostaJQuery;
var
  s, Elementi: String;
  i: Integer;
begin
  (*
  s:='$("#wc004_tabs").tabs();' + CRLF +
     '$("#wc004_standard").' + IfThen(Modalita = meStandard,'show();','hide();') + CRLF +
     '$("#wc004_sql").' + IfThen(Modalita = meAvanzata,'show();','hide();' + CRLF +
     '');
  *)
   s:='$("#wc004_standard").' + IfThen(Modalita = meStandard,'show();','hide();') + CRLF +
     '$("#wc004_sql").' + IfThen(Modalita = meAvanzata,'show();','hide();' + CRLF +
     '');
  // autocomplete configurazioni stampa
  Elementi:='';
  for i:=0 to High(StampeArr) do
    Elementi:=Elementi + '''' +  C190EscapeJS(StampeArr[i].NomeStampa) + ''',';
  if Elementi <> '' then
  begin
    s:=s + 'var elementi = [' + Copy(Elementi,1,Length(Elementi) - 1) + '];' +
           '$("#' + edtStampe.HTMLName + '").autocomplete({' + CRLF +
           '  source: elementi,' + CRLF +
           '  delay: 0,' + CRLF +
           '  minLength: 0' + CRLF +
           '}).focus(function(){ ' + CRLF +
           '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
           '}); ';
  end;
  jQLayout.OnReady.Text:=Format(W000JQ_Tabs,[Name])+' '+ CRLF +s;
end;

function TWC004FEstrazioneDatiFM.NumParam(const Op: String): Integer;
// determina il numero di parametri per l'operatore indicato
begin
  if (Trim(Op) = '') or (Op = 'IS NULL') or (Op = 'IS NOT NULL') then
    Result:=0
  else if (Op = '=') or (Op = '<') or (Op = '<=') or (Op = '>') or (Op = '>=') or
          (Op = '<>') or (Op = 'IN') or (Op = 'LIKE') or (Op = '') then
    Result:=1
  else
    Result:=2;
end;

procedure TWC004FEstrazioneDatiFM.cmbOperatoreAsyncChange(Sender: TObject; EventParams: TStringList);
var
  i,np: Integer;
begin
  i:=TmeIWComboBox(Sender).Tag;
  np:=NumParam(TmeIWComboBox(Sender).Text);
  Griglia[i].Valore1.Visible:=np > 0;
  Griglia[i].Valore2.Visible:=np = 2;
end;

procedure TWC004FEstrazioneDatiFM.Visualizza;
var
  i: Integer;
begin
  grdEsportazione.medpDataSet:=WR302DM.selEstrazioneDati;
  grdEsportazione.medpPaginazione:=True;
  grdEsportazione.medpRighePagina:=1000;

  // carica griglia selezione campi
  PulisciGriglia;
  CaricaGriglia;

  // pulisce listbox selezione e ordinamento
  lbCampiSelB.Items.Clear;
  lbCampiOrdB.Items.Clear;

  // carica array elenco stampe
  CaricaArray;

  // esecuzione query e visualizzazione risultati
  for i:=0 to High(Griglia) do
  begin
    lbCampiSelB.Items.Values[Griglia[i].Alias.FriendlyName]:=IntToStr(i);
    Griglia[i].Seleziona.Css:='ui-icon ui-icon-circle-minus';
  end;
  AggiornaConteggiCampi;

  // setta codice jquery ed esegue query
  ImpostaJQuery;
  btnEseguiClick(nil);

  // visualizza messaggio modale
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,750,-1,700,'Estrazione dati','#wc004_container',False,True);
end;

procedure TWC004FEstrazioneDatiFM.CaricaArray;
var
  i: Integer;
begin
  // caricamento impostazioni di stampa
  with WR302DM.selT900 do
  begin
    Close;
    SetVariable('CODICEINTERNO',TWR100FBase(Self.Parent).medpCodiceForm);
    Open;
    SetLength(StampeArr,0);
    i:=0;
    while not Eof do
    begin
      SetLength(StampeArr,i + 1);
      StampeArr[i].NomeStampa:=FieldByName('NOMESTAMPA').AsString;
      StampeArr[i].Descrizione:=FieldByName('DESCRIZIONE').AsString;
      i:=i + 1;
      Next;
    end;
  end;
end;

procedure  TWC004FEstrazioneDatiFM.PulisciGriglia;
var
  i: Integer;
begin
  for i:=0 to High(Griglia) do
  begin
    FreeAndNil(Griglia[i].Seleziona);
    FreeAndNil(Griglia[i].Ordina);
    FreeAndNil(Griglia[i].Alias);
    FreeAndNil(Griglia[i].Filtro);
    FreeAndNil(Griglia[i].Operatore);
    FreeAndNil(Griglia[i].Valore1);
    FreeAndNil(Griglia[i].Valore2);
  end;
  SetLength(Griglia,0);
end;

procedure TWC004FEstrazioneDatiFM.CaricaGriglia;
var
  i,j,r: Integer;
  Elem: String;
begin
  // imposta grid per i campi di selezione e listbox per ordinamento
  WR302DM.selEstrazioneDati.Close;
  WR302DM.selEstrazioneDati.SQL.Text:=TestoQueryOrig;
  WR302DM.selEstrazioneDati.Open;
  //SetLength(Griglia,grdEsportazione.medpDataSet.FieldDefs.Count);
  SetLength(Griglia,0);
  grdCampiSelA.RowCount:=Length(Griglia) + 1;// grdEsportazione.medpDataSet.FieldDefs.Count + 1;
  grdCampiSelA.ColumnCount:=8;
  // intestazione
  grdCampiSelA.Cell[0,0].Text:='';
  grdCampiSelA.Cell[0,0].Css:='riga_intestazione align_center';
  grdCampiSelA.Cell[0,1].Text:='Selezione';
  grdCampiSelA.Cell[0,1].Css:='riga_intestazione align_center';
  grdCampiSelA.Cell[0,2].Text:='Nome da visualizzare';
  grdCampiSelA.Cell[0,2].Css:='riga_intestazione align_center';
  grdCampiSelA.Cell[0,3].Text:='Ord.';
  grdCampiSelA.Cell[0,3].Css:='riga_intestazione align_center';
  grdCampiSelA.Cell[0,4].Text:='Filtro';
  grdCampiSelA.Cell[0,4].Css:='riga_intestazione align_center';
  grdCampiSelA.Cell[0,5].Text:='';
  grdCampiSelA.Cell[0,5].Css:='riga_intestazione align_center';
  grdCampiSelA.Cell[0,6].Text:='';
  grdCampiSelA.Cell[0,6].Css:='riga_intestazione align_center';
  grdCampiSelA.Cell[0,7].Text:='';
  grdCampiSelA.Cell[0,7].Css:='riga_intestazione align_center';
  // dati
  r:=-1;
  for i:=0 to grdEsportazione.medpDataSet.FieldDefs.Count  - 1 do
  begin
    Elem:=grdEsportazione.medpDataSet.FieldDefs[i].Name;
    if DataSet.FindField(Elem) = nil then
      Continue;
    inc(r);
    SetLength(Griglia,r + 1);
    grdCampiSelA.RowCount:=Length(Griglia) + 1;
    Griglia[r].Seleziona:=TmeIWLink.Create(Self);
    with Griglia[r].Seleziona do
    begin
      Caption:=Elem;
      Css:='ui-icon ui-icon-circle-plus';
      Hint:='Seleziona il campo ' + Elem;
      ShowHint:=True;
      OnAsyncClick:=btnCampoAsyncClick;
      Tag:=r;
    end;
    Griglia[r].Alias:=TmeIWEdit.Create(Self);
    with Griglia[r].Alias do
    begin
      Css:='campiAlias';
      FriendlyName:=Elem;

      if (DataSet.FindField(Elem) <> nil) then
        //Devo prendere l'alias preimpostato dal dataset di riferimento
        Text:=DataSet.FieldByName(Elem).DisplayName
      else
        //se Field non Definito sul dataset imposto con default
        Text:=Elem;

      Hint:='Alias per campo ' + Elem;
      ShowHint:=True;
      Tag:=r;
    end;
    Griglia[r].Ordina:=TmeIWLink.Create(Self);
    with Griglia[r].Ordina do
    begin
      Caption:='';
      Css:='ui-icon ui-icon-triangle-2-n-s';
      OnAsyncClick:=btnOrdinaAsyncClick;
      Hint:='Ordinamento per campo ' + Elem;
      ShowHint:=True;
      Tag:=r;
    end;
    Griglia[r].Filtro:=TmeIWLink.Create(Self);
    with Griglia[r].Filtro do
    begin
      Caption:='';
      Css:='ui-icon ui-icon-carat-1-e';
      Hint:='Filtro per il campo ' + Elem;
      ShowHint:=True;
      Tag:=r;
    end;
    Griglia[r].Operatore:=TmeIWComboBox.Create(Self);
    with Griglia[r].Operatore do
    begin
      Css:='campiOperatore';
      Items.StrictDelimiter:=True;
      Items.CommaText:=' ,=,<,<=,>,>=,<>,IS NULL,IS NOT NULL,IN,LIKE,BETWEEN';
      ItemIndex:=0;
      OnAsyncChange:=cmbOperatoreAsyncChange;
      Tag:=r;
    end;
    Griglia[r].Valore1:=TmeIWEdit.Create(Self);
    with Griglia[r].Valore1 do
    begin
      Css:='campiValore';
      Text:='';
      Tag:=r;
      Visible:=False;
    end;
    Griglia[r].Valore2:=TmeIWEdit.Create(Self);
    with Griglia[r].Valore2 do
    begin
      Css:='campiValore';
      Text:='';
      Tag:=r;
      Visible:=False;
    end;

    j:=0;
    grdCampiSelA.Cell[r + 1,j].Control:=Griglia[r].Seleziona;
    inc(j);
    grdCampiSelA.Cell[r + 1,j].Text:=Elem;
    inc(j);
    grdCampiSelA.Cell[r + 1,j].Control:=Griglia[r].Alias;
    inc(j);
    grdCampiSelA.Cell[r + 1,j].Control:=Griglia[r].Ordina;
    inc(j);
    //grdCampiSelA.Cell[r + 1,j].Control:=Griglia[r].Filtro;
    //inc(j);
    grdCampiSelA.Cell[r + 1,j].Control:=Griglia[r].Operatore;
    inc(j);
    grdCampiSelA.Cell[r + 1,j].Control:=Griglia[r].Valore1;
    inc(j);
    grdCampiSelA.Cell[r + 1,j].Control:=Griglia[r].Valore2;
  end;
end;

function TWC004FEstrazioneDatiFM.GetModalita: TModalitaEstrazione;
begin
  Result:=FModalita;
end;

procedure TWC004FEstrazioneDatiFM.SetModalita(const Val: TModalitaEstrazione);
begin
  if Val = FModalita then
    Exit;

  case Val of
    meStandard:
      begin
        if SqlManuale then
        begin
          edtStampe.Text:='';
          PulisciGriglia;
          CaricaGriglia;

          // pulisce listbox selezione e ordinamento
          lbCampiSelB.Items.Clear;
          lbCampiOrdB.Items.Clear;
        end;
        lblInfo.Caption:='Fare click sui campi da selezionare';
        lblInfo.Css:='informazione';
        TWR100FBase(Self.Parent).ActiveControl:=nil;
      end;
    meAvanzata:
      begin
        if SalvaStdSql then
          SalvaInterfaccia;
        memQuery.Text:=TestoQuery;
        lblInfo.Caption:='Introdurre la query nel campo visualizzato';
        lblInfo.Css:='informazione';
        TWR100FBase(Self.Parent).ActiveControl:=memQuery;
        SqlManuale:=False;
      end;
  end;

  FModalita:=Val;
  ImpostaJQuery;
end;

procedure TWC004FEstrazioneDatiFM.rgpModalitaClick(Sender: TObject);
begin
  SenderModalita:=Sender;
  // se passo da avanzato a manuale chiede conferma se sql modificato
  if (Modalita = meAvanzata) and
     (rgpModalita.ItemIndex = 0) and
     (SqlManuale) then
    MsgBox.WebMessageDlg('Attenzione! Il passaggio alla modalità standard' + CRLF +
                               'comporterà la perdita delle impostazioni attuali.' + CRLF +
                               'Vuoi continuare?',mtConfirmation,[mbYes,mbNo],OnRisposta,'CONFERMA_MOD_STD')
  else
    CambiaModalita(Sender);
end;

procedure TWC004FEstrazioneDatiFM.CambiaModalita(Sender: TObject);
begin
  SalvaStdSql:=Sender <> nil;
  case rgpModalita.ItemIndex of
    0: Modalita:=meStandard;
    1: Modalita:=meAvanzata;
  end;
end;

// GESTIONE TABELLA

procedure TWC004FEstrazioneDatiFM.grdCampiSelARenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  if (ARow < 0) and
     ((AColumn = 0) or (AColumn = 2)) then
    //ACell.Css:='fg-button ui-state-default fg-button-icon-left ui-corner-all';
end;

procedure TWC004FEstrazioneDatiFM.grdEsportazioneRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  grdEsportazione.medpRenderCell(ACell,ARow,AColumn,True,True,False);
end;

procedure TWC004FEstrazioneDatiFM.CaricaDati(DBG_ROWID:String = '');
begin
  grdEsportazione.medpCaricaCDS(DBG_ROWID);
end;

procedure TWC004FEstrazioneDatiFM.CreaColonne;
var
  i,j:Integer;
  NomeDato,NomeAlias:String;
begin
  //TWR100FBase(Self.Parent).R010PagGridAbilitaBrowse(grdEsportazione,True);
  grdEsportazione.medpBrowse:=True;
  grdEsportazione.medpDataSet.Refresh;
  grdEsportazione.medpCreaCDS;
  grdEsportazione.medpEliminaColonne;
  with WR302DM.selEstrazioneDati do
  begin
    for i:=0 to FieldCount - 1 do
    begin
      NomeDato:=Fields[i].FieldName;
      NomeAlias:=Fields[i].DisplayLabel;
      if Modalita = meStandard then
      begin
        j:=FindIndexGriglia('S',NomeDato);
        if j > -1 then
        begin
           if (Griglia[j].Alias.Text <> '') and
              (Griglia[j].Alias.Text <> Griglia[j].Alias.FriendlyName) then
             NomeAlias:=Griglia[j].Alias.Text
           else
             NomeAlias:=Griglia[j].Alias.FriendlyName;
        end;
      end;
      grdEsportazione.medpAggiungiColonna(NomeDato,NomeAlias,'',nil);
    end;
    //TWR100FBase(Self.Parent).R010PagGridAggiorna(grdEsportazione,RecordCount);
  end;
  grdEsportazione.medpInizializzaCompGriglia;
  CaricaDati;
end;

procedure TWC004FEstrazioneDatiFM.AggiornaConteggiCampi;
var
  i,NumSel,NumOrd: Integer;
begin
  NumSel:=0;
  NumOrd:=0;
  for i:=0 to High(Griglia) do
  begin
    if Griglia[i].Seleziona.Css = 'ui-icon ui-icon-circle-minus' then
      NumSel:=NumSel + 1;
    if Griglia[i].Ordina.Css = 'ui-icon ui-icon-triangle-1-n' then
      NumOrd:=NumOrd + 1;
  end;

  // conteggio campi sel.
  lblSelezione.Caption:='Campi selezionati (' + IntToStr(NumSel) + ')';
  lblOrdinamento.Caption:='Campi di ordinamento (' + IntToStr(NumOrd) + ')';
end;

procedure TWC004FEstrazioneDatiFM.btnCampoAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i: Integer;
  jsTemp: String;
begin
  jsTemp:='';
  if (Sender = btnSelAddAll) or (Sender = btnSelRemAll) then
  begin
    lbCampiSelB.Items.Clear;
    for i:=0 to High(Griglia) do
    begin
      if Sender = btnSelAddAll then
      begin
        lbCampiSelB.Items.Values[Griglia[i].Alias.FriendlyName]:=IntToStr(i);
        Griglia[i].Seleziona.Css:='ui-icon ui-icon-circle-minus';
      end
      else
        Griglia[i].Seleziona.Css:='ui-icon ui-icon-circle-plus';
      lblInfo.Caption:=IfThen(Sender = btnSelAddAll,'Premere ' + btnEsegui.Caption + ' per effettuare la selezione','Fare click sui campi da selezionare');
      lblInfo.Css:='informazione';
      jsTemp:=Format(' $("#%s").attr("class","%s");%s',[Griglia[i].Seleziona.HTMLName,Griglia[i].Seleziona.Css,CRLF]);
      //Eseguo addJavasript per ogni elemento altrimenti problemi con FireFox quando ci sono tanti elementi
      //es : WA071 rimuovi tutti va in errore
      //A000App.CallBackResponse.AddJavaScriptToExecute(jsTemp);
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(jsTemp);
    end;
  end
  else
  begin
    i:=TmeIWLink(Sender).Tag;
    if TmeIWLink(Sender).Css = 'ui-icon ui-icon-circle-plus' then
    begin
      // aggiungi
      TmeIWLink(Sender).Css:='ui-icon ui-icon-circle-minus';
      lbCampiSelB.Items.Values[Griglia[i].Alias.FriendlyName]:=IntToStr(i);
      lblInfo.Caption:='Premere ' + btnEsegui.Caption + ' per effettuare la selezione';
      lblInfo.Css:='informazione';
    end
    else
    begin
      // rimuovi
      TmeIWLink(Sender).Css:='ui-icon ui-icon-circle-plus';
      lbCampiSelB.Items.Delete(lbCampiSelB.Items.IndexOfName(Griglia[i].Alias.FriendlyName));
      lblInfo.Caption:='Fare click sui campi da selezionare';
      lblInfo.Css:='informazione';
    end;
    jsTemp:=Format(' $("#%s").attr("class","%s");%s',[TmeIWLink(Sender).HTMLName,TmeIWLink(Sender).Css,CRLF]);
    //A000App.CallBackResponse.AddJavaScriptToExecute(jsTemp);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(jsTemp);
  end;
  AggiornaConteggiCampi;

end;

procedure TWC004FEstrazioneDatiFM.lbCampiSelBAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
var
  p: Integer;
  jsTemp: String;
begin
  jsTemp:='';
  p:=StrToIntDef(lbCampiSelB.Items.Values[lbCampiSelB.Text],-1);
  if p > -1 then
  begin
    Griglia[p].Seleziona.Css:='ui-icon ui-icon-circle-plus';
    jsTemp:=Format('$("#%s").attr("class","%s");%s',[Griglia[p].Seleziona.HTMLName,Griglia[p].Seleziona.Css,CRLF]);
  end;
  lbCampiSelB.Items.Delete(lbCampiSelB.ItemIndex);
  lblInfo.Caption:='Fare click sui campi da selezionare';
  lblInfo.Css:='informazione';
  AggiornaConteggiCampi;
  //A000App.CallBackResponse.AddJavaScriptToExecute(jsTemp);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(jsTemp);
end;

procedure TWC004FEstrazioneDatiFM.memQueryAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  SqlManuale:=True;
end;

procedure TWC004FEstrazioneDatiFM.btnOrdinaAsyncClick(Sender: TObject; EventParams: TStringList);
var
  i: Integer;
  jsTemp: String;
begin
  jsTemp:='';
  if Sender = btnOrdRemAll then
  begin
    // ordinamento: rimuovi tutti
    lbCampiOrdB.Items.Clear;
    for i:=0 to High(Griglia) do
    begin
      Griglia[i].Ordina.Css:='ui-icon ui-icon-triangle-2-n-s';
      jsTemp:=Format('$("#%s").attr("class","%s");%s',[Griglia[i].Ordina.HTMLName,Griglia[i].Ordina.Css,CRLF]);
      //A000App.CallBackResponse.AddJavaScriptToExecute(jsTemp);
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(jsTemp);
    end;
  end
  else
  begin
    i:=TmeIWLink(Sender).Tag;
    if TmeIWLink(Sender).Css = 'ui-icon ui-icon-triangle-2-n-s' then
    begin
      // aggiungi
      TmeIWLink(Sender).Css:='ui-icon ui-icon-triangle-1-n';
      lbCampiOrdB.Items.Values[Griglia[i].Alias.FriendlyName]:=IntToStr(i);
    end
    else
    begin
      // rimuovi
      TmeIWLink(Sender).Css:='ui-icon ui-icon-triangle-2-n-s';
      lbCampiOrdB.Items.Delete(lbCampiOrdB.Items.IndexOfName(Griglia[i].Alias.FriendlyName));
    end;
    jsTemp:=Format('$("#%s").attr("class","%s");%s',[Griglia[i].Ordina.HTMLName,Griglia[i].Ordina.Css,CRLF]);
    //A000App.CallBackResponse.AddJavaScriptToExecute(jsTemp);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(jsTemp);
  end;
  AggiornaConteggiCampi;

end;

procedure TWC004FEstrazioneDatiFM.lbCampiOrdBAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
var
  i: Integer;
  jsTemp: String;
begin
  jsTemp:='';
  if lbCampiOrdB.Text = '' then
    i:=-1
  else
    i:=StrToIntDef(lbCampiOrdB.Items.Values[lbCampiOrdB.Text],-1);//StrToIntDef(lbCampiOrdB.Text,-1);
  if i > -1 then
  begin
    Griglia[i].Ordina.Css:='ui-icon ui-icon-triangle-2-n-s';
    jsTemp:=Format('$("#%s").attr("class","%s");%s',[Griglia[i].Ordina.HTMLName,Griglia[i].Ordina.Css,CRLF]);
    lbCampiOrdB.Items.Delete(lbCampiOrdB.ItemIndex);
    AggiornaConteggiCampi;
    //A000App.CallBackResponse.AddJavaScriptToExecute(jsTemp);
    GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(jsTemp);
  end;
end;

procedure TWC004FEstrazioneDatiFM.btnPulisciClick(Sender: TObject);
begin
  Reimposta;
  memQuery.Clear;
  edtStampe.Text:='';
  PulisciGriglia;
  CaricaGriglia;

  // pulisce listbox selezione e ordinamento
  lbCampiSelB.Items.Clear;
  lbCampiOrdB.Items.Clear;

  lblInfo.Caption:='Fare click sui campi da selezionare';
  lblInfo.Css:='informazione';
end;

function TWC004FEstrazioneDatiFM.FindIndexGriglia(const Tipo,Nome: String): Integer;
var
  i: Integer;
  Found: Boolean;
begin
  Found:=False;
  for i:=0 to High(Griglia) do
    if Nome = Griglia[i].Alias.FriendlyName then
    begin
      if Tipo = 'S' then
        //Griglia[i].Nome.Css:='campi sel'
      else
        Griglia[i].Ordina.Caption:='-';
      Found:=True;
      Break;
    end;
  Result:=IfThen(Found,i,-1);
end;

// CARICAMENTO - SALVATAGGIO IMPOSTAZIONI
procedure TWC004FEstrazioneDatiFM.OnRisposta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if KI = 'CONFERMA_SALVA' then
  begin
    // yes, no
    if R = mrYes then
      SetImpostazioni;
    MsgBox.ClearKeys;
  end
  else if KI = 'CONFERMA_ELIMINA' then
  begin
    // yes, no
    if R = mrYes then
      DelImpostazioni;
    MsgBox.ClearKeys;
  end
  else if KI = 'CONFERMA_MOD_STD' then
  begin
    // yes, no
    if R = mrYes then
      CambiaModalita(SenderModalita)
    else
      rgpModalita.ItemIndex:=1;
    MsgBox.ClearKeys;
  end;
end;

procedure TWC004FEstrazioneDatiFM.GetImpostazioni;
// lettura impostazioni da db
begin
  if WR302DM.selT900.SearchRecord('NOMESTAMPA',edtStampe.Text,[srFromBeginning]) then
  begin
    ListaImpostazioni.Clear;
    with WR302DM.selT901 do
    begin
      Close;
      SetVariable('CODICEINTERNO',TWR100FBase(Self.Parent).medpCodiceForm);
      SetVariable('NOMESTAMPA',edtStampe.Text);
      Open;
      while not WR302DM.selT901.Eof do
      begin
        ListaImpostazioni.Add(WR302DM.selT901.FieldByName('RIGA').AsString);
        WR302DM.selT901.Next;
      end;
    end;
  end
  else
  begin
    TWR100FBase(Self.Parent).ActiveControl:=edtStampe;
    lblInfo.Caption:='La configurazione indicata è inesistente!';
    lblInfo.Css:='segnalazione';
  end;
end;

procedure TWC004FEstrazioneDatiFM.CaricaInterfaccia;
// impostazione dati nell'interfaccia
var
  i,j: Integer;
  LElenco:TStringList;
  TipoRiga,Riga,Elenco: String;
begin
  // ricarica informazioni
  PulisciGriglia;
  CaricaGriglia;
  lbCampiSelB.Items.Clear;
  lbCampiOrdB.Items.Clear;
  CaricaArray;
  ImpostaJQuery;

  if ListaImpostazioni.Count = 0 then
    Exit;

  SqlManuale:=False;
  rgpModalita.ItemIndex:=IfThen(ListaImpostazioni[0] = 'M;0',0,1);
  rgpModalitaClick(nil);

  if Modalita = meStandard then
  begin
    LElenco:=TStringList.Create;
    for i:=1 to ListaImpostazioni.Count - 1 do
    begin
      Riga:=ListaImpostazioni[i];
      TipoRiga:=Copy(Riga,1,1);
      Elenco:=Copy(Riga,3,MaxInt);

      if TipoRiga = 'A' then
      begin
        // definizione alias
        R180Tokenize(LElenco,Elenco,';');
        for j:=0 to High(Griglia) do
          if LElenco[0] = Griglia[j].Alias.FriendlyName then
          begin
            Griglia[j].Alias.Text:=LElenco[1];
            Break;
          end;
      end;
      if TipoRiga = 'S' then
      begin
        // campi selezione
        R180Tokenize(LElenco,Elenco,',');
        for j:=0 to LElenco.Count - 1 do
          lbCampiSelB.Items.Values[LElenco[j]]:=IntToStr(FindIndexGriglia('S',LElenco[j]));
      end
      else if TipoRiga = 'O' then
      begin
        // campi ordinamento
        R180Tokenize(LElenco,Elenco,',');
        for j:=0 to LElenco.Count - 1 do
          lbCampiOrdB.Items.Values[LElenco[j]]:=IntToStr(FindIndexGriglia('O',LElenco[j]));
      end
      else if TipoRiga = 'W' then
      begin
        // gestione filtro where
        R180Tokenize(LElenco,Elenco,';');
        for j:=0 to High(Griglia) do
          if LElenco[0] = Griglia[j].Alias.FriendlyName then
          begin
            Griglia[j].Operatore.ItemIndex:=Griglia[j].Operatore.Items.IndexOf(LElenco[1]);
            Griglia[j].Valore1.Text:=LElenco[2];
            Griglia[j].Valore2.Text:=LElenco[3];
            Break;
          end;
      end;
    end;
  end;

  // query risultante
  memQuery.Text:=TestoQuery;
  SqlManuale:=Modalita = meAvanzata;

  AggiornaConteggiCampi;
  lblInfo.Caption:='Configurazione ' + edtStampe.Text + ' caricata';
  lblInfo.Css:='informazione';
end;

function TWC004FEstrazioneDatiFM.IsParolaRiservataSql(const Parola: String): Boolean;
var
  S: String;
begin
  S:=UpperCase(Parola);
  Result:=(S = 'SELECT') or
          (S = 'FROM') or
          (S = 'WHERE') or
          (S = 'DESC') or
          (S = 'ORDER') or
          (S = 'GROUP') or
          (S = 'HAVING') or
          (S = 'COUNT');
end;

procedure TWC004FEstrazioneDatiFM.SalvaInterfaccia;
// impostazione dati nell'interfaccia
var
  i: Integer;
  StrSelect,StrWhere,StrOrderby: String;
  L: TStringList;
begin
  ListaImpostazioni.Clear;

  // 1. modalità
  ListaImpostazioni.Add('M;' + IfThen(Modalita = meStandard,'0','1'));

  // 2. alias
  for i:=0 to High(Griglia) do
  begin
    Griglia[i].Alias.Text:=Trim(Griglia[i].Alias.Text);
    if (Griglia[i].Alias.Text <> '') and
       (Griglia[i].Alias.Text <> Griglia[i].Alias.FriendlyName) then
    begin
      if IsParolaRiservataSql(Griglia[i].Alias.Text) then
      begin
        ListaImpostazioni.Clear;

        //A000App.ShowMessage('Il nome da visualizzare per il campo ' + Griglia[i].Alias.FriendlyName + ' non è utilizzabile,' + CRLF +
        GGetWebApplicationThreadVar.ShowMessage('Il nome da visualizzare per il campo ' + Griglia[i].Alias.FriendlyName + ' non è utilizzabile,' + CRLF +
                            'in quanto "' + Griglia[i].Alias.Text + '" è una parola riservata.' + CRLF +
                            'Scegliere un nome da visualizzare differente.');


        TWR100FBase(Self.Parent).ActiveControl:=Griglia[i].Alias;
        Exit;
      end
      else
        ListaImpostazioni.Add('A;' + Griglia[i].Alias.FriendlyName + ';' + Griglia[i].Alias.Text);
    end;
  end;

  // 3. selezione, filtro e ordinamento
  StrSelect:='';
  StrWhere:='';
  StrOrderby:='';

  if Modalita = meStandard then
  begin
    // modalità standard
    if lbCampiSelB.Items.Count = 0 then
      Exit;

    // selezione
    for i:=0 to lbCampiSelB.Items.Count - 1 do
      StrSelect:=StrSelect + lbCampiSelB.Items.Names[i] + ',';
    ListaImpostazioni.Add('S;' + Copy(StrSelect,1,Length(StrSelect) - 1));

    // ordinamento
    if lbCampiOrdB.Items.Count > 0 then
    begin
      for i:=0 to lbCampiOrdB.Items.Count - 1 do
        StrOrderby:=StrOrderby + lbCampiOrdB.Items.Names[i] + ',';
      ListaImpostazioni.Add('O;' + Copy(StrOrderby,1,Length(StrOrderby) - 1));
    end;

    // filtro
    for i:=0 to High(Griglia) do
      if Griglia[i].Operatore.ItemIndex > 0 then
        ListaImpostazioni.Add('W;' + Griglia[i].Alias.FriendlyName + ';' + Griglia[i].Operatore.Text + ';' + Griglia[i].Valore1.Text + ';' + Griglia[i].Valore2.Text);
  end
  else
  begin
    // modalità avanzata SQL
    L:=TStringList.Create;
    try
      L.Text:=memQuery.Text;
      R180SplitLines(L,[' ',','],1990);
      for i:=0 to L.Count - 1 do
      begin
        if Trim(L[i]) <> '' then
          ListaImpostazioni.Add('Q;' + Trim(L[i]));
      end;
    finally
      FreeAndNil(L);
    end;
  end;
end;

procedure TWC004FEstrazioneDatiFM.SetImpostazioni0;
// salvataggio impostazioni su db
begin
  if ListaImpostazioni.Count = 1 then
  begin
    if ListaImpostazioni[0] = 'M;0' then
      //A000App.ShowMessage('E'' necessario selezionare almeno un campo' + CRLF +
      GGetWebApplicationThreadVar.ShowMessage('E'' necessario selezionare almeno un campo' + CRLF +
                          'per poter salvare la configurazione!')
    else
      //A000App.ShowMessage('Impossibile salvare: la query di selezione è vuota!');
      GGetWebApplicationThreadVar.ShowMessage('Impossibile salvare: la query di selezione è vuota!');
    Exit;
  end;

  with WR302DM.selT900 do
  begin
    Close;
    SetVariable('CODICEINTERNO',TWR100FBase(Self.Parent).medpCodiceForm);
    Open;
    if SearchRecord('NOMESTAMPA',edtStampe.Text,[srFromBeginning]) then
      MsgBox.WebMessageDlg('La configurazione ' + edtStampe.Text + ' è già esistente.' + CRLF + 'Sovrascriverla?',mtConfirmation,[mbYes,mbNo],OnRisposta,'CONFERMA_SALVA')
    else
      SetImpostazioni;
  end;
end;

procedure TWC004FEstrazioneDatiFM.SetImpostazioni;
// salvataggio impostazioni su db
var
  i: Integer;
  CodInt,NomeStampa,Op: String;
begin
  // pre: WR302DM.selT900 aperto
  CodInt:=TWR100FBase(Self.Parent).medpCodiceForm;
  NomeStampa:=edtStampe.Text;

  // apre dataset per modifiche
  with WR302DM.selT901 do
  begin
    Close;
    SetVariable('CODICEINTERNO',CodInt);
    SetVariable('NOMESTAMPA',NomeStampa);
    Open;
  end;

  // tipo operazione
  Op:=IfThen(WR302DM.selT900.SearchRecord('NOMESTAMPA',NomeStampa,[srFromBeginning]),'M','I');

  if Op = 'I' then
  begin
    // INSERIMENTO: inserisce nuovo record padre
    with WR302DM.selT900 do
    begin
      Append;
      FieldByName('CODICEINTERNO').AsString:=CodInt;
      FieldByName('NOMESTAMPA').AsString:=NomeStampa;
      Post;
    end;
  end
  else
  begin
    // MODIFICA: mantiene il record padre e cancella impostazioni esistenti
    with WR302DM.selT901 do
    begin
      Last;
      while not Bof do
        Delete;
    end;
  end;

  // inserisce nuove impostazioni
  for i:=0 to ListaImpostazioni.Count - 1 do
  begin
    with WR302DM.selT901 do
    begin
      Append;
      FieldByName('CODICEINTERNO').AsString:=CodInt;
      FieldByName('NOMESTAMPA').AsString:=NomeStampa;
      FieldByName('NUMRIGA').AsInteger:=i + 1;
      FieldByName('RIGA').AsString:=ListaImpostazioni[i];
      Post;
    end;
  end;
  SessioneOracle.Commit;

  // ricarica info
  CaricaArray;
  ImpostaJQuery;
  lblInfo.Caption:=IfThen(Op = 'I','Configurazione inserita','Configurazione modificata');
  lblInfo.Css:='informazione';
end;

procedure TWC004FEstrazioneDatiFM.DelImpostazioni0;
begin
  with WR302DM.selT900 do
  begin
    Close;
    SetVariable('CODICEINTERNO',TWR100FBase(Self.Parent).medpCodiceForm);
    Open;
    if SearchRecord('NOMESTAMPA',edtStampe.Text,[srFromBeginning]) then
      MsgBox.WebMessageDlg('Eliminare la configurazione ' + edtStampe.Text + '?',mtConfirmation,[mbYes,mbNo],OnRisposta,'CONFERMA_ELIMINA')
    else
    begin
      TWR100FBase(Self.Parent).ActiveControl:=edtStampe;
      lblInfo.Caption:='La configurazione indicata è inesistente!';
      lblInfo.Css:='segnalazione';
    end;
  end;
end;

procedure TWC004FEstrazioneDatiFM.DelImpostazioni;
var
  CodInt,NomeStampa: String;
begin
  // pre: WR302DM.selT900 aperto
  CodInt:=TWR100FBase(Self.Parent).medpCodiceForm;
  NomeStampa:=edtStampe.Text;

  // apre dataset per cancellazioni
  with WR302DM.selT901 do
  begin
    Close;
    SetVariable('CODICEINTERNO',CodInt);
    SetVariable('NOMESTAMPA',NomeStampa);
    Open;
  end;

  // cancella impostazioni esistenti
  with WR302DM.selT901 do
  begin
    while not Eof do
      Delete;
  end;

  // elimina record su tabella T900
  WR302DM.selT900.Delete;
  SessioneOracle.Commit;

  // ricarica informazioni
  PulisciGriglia;
  CaricaGriglia;
  lbCampiSelB.Items.Clear;
  lbCampiOrdB.Items.Clear;
  CaricaArray;
  ImpostaJQuery;
  lblInfo.Caption:='Configurazione ' + edtStampe.Text + ' eliminata.';
  lblInfo.Css:='informazione';
  edtStampe.Text:='';
end;

procedure TWC004FEstrazioneDatiFM.btnCaricaClick(Sender: TObject);
begin
  if (edtStampe.Text = '') then
  begin
    TWR100FBase(Self.Parent).ActiveControl:=edtStampe;
    lblInfo.Caption:='Indicare il nome della configurazione!';
    lblInfo.Css:='segnalazione';
  end
  else
  begin
    Reimposta;
    GetImpostazioni;
    CaricaInterfaccia;
  end;
end;

procedure TWC004FEstrazioneDatiFM.btnSalvaClick(Sender: TObject);
// salva configurazione
begin
  Reimposta;
  if (edtStampe.Text = '') then
  begin
    TWR100FBase(Self.Parent).ActiveControl:=edtStampe;
    lblInfo.Caption:='Digitare un nome da attribuire alla configurazione!';
    lblInfo.Css:='segnalazione';
  end
  else
  begin
    SalvaInterfaccia;
    SetImpostazioni0;
  end;
end;

procedure TWC004FEstrazioneDatiFM.btnEliminaClick(Sender: TObject);
// elimina configurazione salvata
begin
  Reimposta;
  if (edtStampe.Text = '') then
  begin
    TWR100FBase(Self.Parent).ActiveControl:=edtStampe;
    //A000App.ShowMessage('Selezionare il nome della configurazione da eliminare!')
    lblInfo.Caption:='Selezionare il nome della configurazione da eliminare!';
    lblInfo.Css:='segnalazione';
  end
  else
  begin
    DelImpostazioni0;
  end;
end;

// ESECUZIONE QUERY
procedure TWC004FEstrazioneDatiFM.Reimposta;
begin
  grdEsportazione.Visible:=False;
  lblInfo.Caption:='';
  lblInfo.Css:='informazione';
end;

function TWC004FEstrazioneDatiFM.GetTestoQuery: String;
// compone la query sql in base ai parametri
var
  i,j,np: Integer;
  TipoRiga,Riga,Elenco,S,
  StrSelect,StrWhere,StrOrderby,Op,Val1,Val2: String;
  LElenco: TStringList;
begin
  Result:='';

  if ListaImpostazioni.Count = 0 then
    Exit;


  if ListaImpostazioni[0] = 'M;0' then
  begin
    StrSelect:='';
    StrWhere:='';
    StrOrderby:='';
    LElenco:=TStringList.Create;
    try
      // modalità standard
      for i:=1 to ListaImpostazioni.Count -1 do
      begin
        Riga:=ListaImpostazioni[i];
        TipoRiga:=Copy(Riga,1,1);
        Elenco:=Copy(Riga,3,MaxInt);
        if TipoRiga = 'S' then
          StrSelect:=StrSelect + Elenco + ','
        else if TipoRiga = 'O' then
          StrOrderby:=StrOrderby + Elenco + ','
        else if TipoRiga = 'W' then
        begin
          R180Tokenize(LElenco,Elenco,';');
          Op:=LElenco[1];
          S:=LElenco[0] + ' ' + Op;
          np:=NumParam(Op);
          if np > 0 then
          begin
            // valore 1
            Val1:=LElenco[2];
            //     if grdEsportazione.medpDataSet
            if (Op = 'IN') and (Pos(',',Val1) > 0) then
              Val1:='(''' + StringReplace(Val1,',',''',''',[rfReplaceAll]) + ''')'
            else
              Val1:='''' + AggiungiApice(Val1) + '''';
            S:=S + ' ' + Val1;

            // valore 2
            if np = 2 then
            begin
              Val2:='''' + AggiungiApice(LElenco[3]) + '''';
              S:=S + ' AND ' + Val2;
            end;
          end;
          StrWhere:=StrWhere + ' AND (' + S + ')';
        end
      end;

      // composizione query
      if StrSelect <> '' then
      begin
        // gestione alias nella selezione
        if SalvaStdSql then
        begin
          R180Tokenize(LElenco,StrSelect,',');
          StrSelect:='';
          for i:=0 to LElenco.Count - 1 do
          begin
            LElenco[i]:=Trim(LElenco[i]);
            if LElenco[i] <> '' then
            begin
              for j:=0 to High(Griglia) do
                if (LElenco[i] = Griglia[j].Alias.FriendlyName) and
                   (Griglia[j].Alias.FriendlyName <> Griglia[j].Alias.Text) then
                begin
                  LElenco[i]:=LElenco[i] + ' "' + Griglia[j].Alias.Text + '"';
                  Break;
                end;
              StrSelect:=StrSelect + LElenco[i] + ',';
            end;
          end;
        end;

        // risultato query
        Result:='SELECT ' + Copy(StrSelect,1,Length(StrSelect) - 1) + CRLF +
                'FROM   ' + NomeTabella + CRLF +
                IfThen(StrWhere <> '','WHERE ' + Copy(StrWhere,5,MaxInt) + CRLF) +
                IfThen(StrOrderby <> '','ORDER BY ' + Copy(StrOrderby,1,Length(StrOrderby) - 1));
      end;
    finally
      FreeAndNil(LElenco);
    end;
    end
    else
    begin
      for i:=1 to ListaImpostazioni.Count - 1 do
      begin
        Riga:=ListaImpostazioni[i];
        TipoRiga:=Copy(Riga,1,1);
        Elenco:=Copy(Riga,3,MaxInt);
        if TipoRiga = 'Q' then
          Result:=Result + Elenco + CRLF;
      end;
    end;
end;

procedure TWC004FEstrazioneDatiFM.btnEseguiClick(Sender: TObject);
var
  S: String;
begin
  Reimposta;

  if Modalita = meStandard then
  begin
    SalvaInterfaccia;
    S:=Trim(TestoQuery);
  end
  else
  begin
    S:=Trim(memQuery.Text);
  end;

  // controlli bloccanti
  //***S:=S + ' WHERE ROWNUM < 10';
  if S = '' then
  begin
    lblInfo.Caption:=IfThen(Modalita = meStandard,
                            'Selezionare almeno un campo dalla lista!',
                            'Introdurre la query da eseguire!');
    lblInfo.Css:='segnalazione';
    if Modalita = meAvanzata then
      TWR100FBase(Self.Parent).ActiveControl:=memQuery;
    Exit;
  end;

  // controlla testo query (modalità avanzata)
  if Copy(UpperCase(S),1,7) <> 'SELECT ' then
  begin
    lblInfo.Caption:='Non è consentita l''esecuzione dell''istruzione SQL indicata!';
    lblInfo.Css:='segnalazione';
    Exit;
  end;

  // apertura dataset e impostazione tabella
  WR302DM.selEstrazioneDati.Close;
  WR302DM.selEstrazioneDati.SQL.Text:=S;
  try
    WR302DM.selEstrazioneDati.Open;
  except
    on E: Exception do
    begin
      lblInfo.Caption:='Errore nella selezione: ' + E.Message;
      lblInfo.Css:='segnalazione';
      Exit;
    end;
  end;
  CreaColonne;

  grdEsportazione.Visible:=True;

  if WR302DM.selEstrazioneDati.RecordCount = 0 then
    lblInfo.Caption:='Nessun record estratto'
  else
    lblInfo.Caption:=IntToStr(WR302DM.selEstrazioneDati.RecordCount) + ' record estratti';

  if (Sender <> nil) and (Sender is TmeIWButton) then
    jQLayout.OnReady.Add('$("#tabs").tabs({active: 1 });');
end;

procedure TWC004FEstrazioneDatiFM.btnEsportaInExcelClick(Sender: TObject);
begin
  //ATTENZIONE. Aggiunto codice per rilascio del lock IW nella scriptEvents del pulsante per gestione sendStream
  if not grdEsportazione.medpDataSet.Active then
  begin
    lblInfo.Caption:='Esportazione impossibile: nessuna selezione attiva';
    lblInfo.Css:='segnalazione';
    Exit;
  end;
  if grdEsportazione.medpDataSet.RecordCount = 0 then
  begin
    lblInfo.Caption:='Esportazione impossibile: nessun record presente';
    lblInfo.Css:='segnalazione';
    Exit;
  end;

  if Sender = btnEsportaInCSV then
    TWR100FBase(Self.Parent).inviaFile('estrazione.xls',grdEsportazione.ToCsv())
  else
    TWR100FBase(Self.Parent).inviaFile('estrazione.xlsx',grdEsportazione.ToXlsx);
end;

// DISTRUZIONE FRAME
procedure TWC004FEstrazioneDatiFM.btnChiudiClick(Sender: TObject);
begin
  WR302DM.selEstrazioneDati.Close;
  WR302DM.selEstrazioneDati.SQL.Text:=TestoQueryOrig;
  try
    WR302DM.selEstrazioneDati.Open;
  except
  end;

  // ripristina righe per pagina
  TWR100FBase(Self.Parent).ActiveControl:=nil;
  ReleaseOggetti;
  Free;
end;

procedure TWC004FEstrazioneDatiFM.ReleaseOggetti;
begin
  inherited;
  PulisciGriglia;
  FreeAndNil(ListaImpostazioni);
end;

end.
