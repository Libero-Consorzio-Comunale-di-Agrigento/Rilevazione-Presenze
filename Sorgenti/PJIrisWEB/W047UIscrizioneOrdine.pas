unit W047UIscrizioneOrdine;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  FunzioniGenerali,
  R012UWebAnagrafico,
  W000UMessaggi,
  W047UIscrizioneOrdineDM, W047UIscrizioneOrdineFM,
  System.SysUtils, System.Math, System.Variants, System.Classes, System.DateUtils, StrUtils,
  IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit,
  IWCompGrids, meIWGrid, IWCompButton, meIWButton, Vcl.Controls,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWDBGrids, medpIWDBGrid, OracleData,
  meIWImageFile, meIWDBEdit, Vcl.Menus;

type
  TW047FIscrizioneOrdine = class(TR012FWebAnagrafico)
    grdIscrizioneOrdine: TmedpIWDBGrid;
    pmnTabella: TPopupMenu;
    mnuEsportaExcel: TMenuItem;
    mnuEsportaCsv: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdIscrizioneOrdineRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure grdIscrizioneOrdineAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdIscrizioneOrdineModifica(Sender: TObject);
    procedure mnuEsportaExcelClick(Sender: TObject);
    function GrigliaBeforeOperazione(Sender: TObject): Boolean;
    procedure mnuEsportaCsvClick(Sender: TObject);
  private
    FW047DM: TW047FIscrizioneOrdineDM;
    FW047Isc: TW047FIscrizioneOrdineFM;
    FIsDateInRangeConsentito: Boolean;
    FNumRecordMeseSucc: Integer;
    CodeAC: String;
    CampiV430a,codReperito:String;
    procedure CreaFrame(Griglia:TmedpIWDBGrid;Operazione,FN:String);
    procedure imgInserisciIncaricoAttualeClick(Sender: TObject);
    procedure imgModificaIncaricoAttualeClick(Sender: TObject);
    procedure imgAccediIncaricoAttualeClick(Sender: TObject);
    procedure PreparaGriglia(Griglia:TmedpIWDBGrid;DataSet:TOracleDataSet);
    procedure PreparaComponenti(Griglia:TmedpIWDBGrid);
    procedure CaricaJQAutocomplete(Griglia:TmedpIWDBGrid;r:Integer);
    procedure ImpostaTestoJQ(NomeLogico:String;NomeComponente:String);
  protected
    procedure VisualizzaDipendenteCorrente; override;
  public
    procedure AbilitaJqAutocomplete(Val:Boolean);
    function InizializzaAccesso:Boolean; override;
    procedure GetIscrizione;
  end;

implementation

uses
  IWApplication;

{$R *.dfm}

{ TW047FIscrizioneOrdine }

function TW047FIscrizioneOrdine.InizializzaAccesso: Boolean;
begin
  // controlla definizione parametro per Ordini professioni sanitarie
  if Parametri.CampiRiferimento.C36_OrdProfSanCodice = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W047_ERR_FMT_NO_PARAM_ORDSAN_CODICE),[medpNomeFunzione]));
    Exit;
  end;

  Result:=True;
  GetDipendentiDisponibili(Parametri.DataLavoro);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  VisualizzaDipendenteCorrente;
  if codReperito.IsEmpty then
  begin
    GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W047_ERR_FMT_NO_DATO_REGOLA));
    Result:=False;
    Exit;
  end;
end;

procedure TW047FIscrizioneOrdine.IWAppFormCreate(Sender: TObject);
function Split(StrBuf,Delimiter: string): TStringList;
var
  MyStrList: TStringList;
  TmpBuf: string;
  LoopCount: integer;
begin
  MyStrList:=TStringList.Create;
  LoopCount:=1;

  if StrBuf <> '' then
  begin
    repeat
      if StrBuf[LoopCount] = Delimiter then
      begin
        MyStrList.Add(TmpBuf);
        TmpBuf:='';
      end
      else
        TmpBuf:=TmpBuf + StrBuf[LoopCount];

      inc(LoopCount);
    until LoopCount > Length(StrBuf);
  end;
  { Inserisce gli ultimi dati del buffer... }
  MyStrList.Add(TmpBuf);

  Result:=MyStrList;
end;
var
  i: integer;
  LstCampi: TStringList;

begin
  inherited;

  // inizializzazioni
  FIsDateInRangeConsentito:=False;
  FNumRecordMeseSucc:=0;
  FW047DM:=TW047FIscrizioneOrdineDM.Create(Self);
  FW047DM.selAnagrafeW:=selAnagrafeW;

  //Imposta la DisplayLabel dei campi obbligatori opzionali
  LstCampi:=Split(Parametri.CampiRiferimento.C36_OrdProfSan_Campi_Obb, ',');
  if assigned(LstCampi) then
  begin
    for i:=0 to FW047DM.selSG220.FieldCount-1 do
    begin
      if LstCampi.IndexOf(FW047DM.selSG220.Fields[i].FieldName) >= 0 then
        FW047DM.selSG220.Fields[i].DisplayLabel:= '(*) ' + FW047DM.selSG220.Fields[i].DisplayLabel;
    end;
    FreeAndNil(LstCampi);
  end;
  // imposta alcune proprietà della grid
  grdIscrizioneOrdine.medpPaginazione:=False;
  grdIscrizioneOrdine.medpTestoNoRecord:='Nessun dato di Iscrizione Ordini professionali';
  grdIscrizioneOrdine.medpRowSelect:=False;

  PreparaGriglia(grdIscrizioneOrdine,FW047DM.selSG220);
end;

procedure TW047FIscrizioneOrdine.VisualizzaDipendenteCorrente;
var
  LResCtrl: TResCtrl;
  LAbilIns: Boolean;
  LAbilEdit: Boolean;
  LDataIscrizioneOrdine: TDateTime;
  LMeseSuccIni: TDateTime;
begin
  inherited;

  // salva il progressivo corrente
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  GetIscrizione;
end;

procedure TW047FIscrizioneOrdine.GetIscrizione;
begin
  CampiV430a:='T430'+Parametri.CampiRiferimento.C36_OrdProfSanCodice;
  codReperito:='';
  with FW047DM do
  begin
    if selV430a.Active then
      selV430a.Close;
    R180SetVariable(selV430a,'CAMPI',CampiV430a);
    R180SetVariable(selV430a,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selV430a.Open;
    codReperito:=FW047DM.CercaOrdineProf(FW047DM.selV430a.FieldByName(CampiV430a).AsString);

    if selSG220.Active then
      selSG220.Close;
    R180SetVariable(selSG220,'PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
    selSG220.Open;
  end;
  grdIscrizioneOrdine.medpAggiornaCDS;
end;

procedure TW047FIscrizioneOrdine.mnuEsportaCsvClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    csvDownload:=grdIscrizioneOrdine.ToCsv
  else
    InviaFile('ElencoIscrizioneOrdini.xls',csvDownload);
end;

procedure TW047FIscrizioneOrdine.mnuEsportaExcelClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    streamDownload:=grdIscrizioneOrdine.ToXlsx
  else
    InviaFile('ElencoIscrizioneOrdini.xlsx',streamDownload);
end;

procedure TW047FIscrizioneOrdine.AbilitaJqAutocomplete(Val: Boolean);
begin
  jQAutocomplete.OnReady.Clear;
  jQAutocomplete.OnReady.Add(IfThen(Val,CodeAC));
end;

procedure TW047FIscrizioneOrdine.CaricaJQAutocomplete(Griglia: TmedpIWDBGrid; r: Integer);
var i,j:Integer;
    NomeComponente:String;
begin
  CodeAC:='';
  jQAutocomplete.Enabled:=True;
  jQAutocomplete.OnReady.Clear;
  with Griglia,medpDataSet do
    for i:=0 to FieldCount - 1 do
      //Componenti creati nel frame
      if r = -1 then
      begin
        NomeComponente:='';
        for j:=0 to FW047Isc.ComponentCount - 1 do
          if FW047Isc.Components[j] is TmeIWDBEdit then
            if (FW047Isc.Components[j] as TmeIWDBEdit).DataField = Fields[i].FieldName then
              NomeComponente:=(FW047Isc.Components[j] as TmeIWDBEdit).HTMLName;
        if NomeComponente <> '' then
          ImpostaTestoJQ(Fields[i].FieldName,NomeComponente);
      end
      //Componenti creati nella griglia
      else if medpCompCella(r,medpIndexColonna(Fields[i].FieldName),0) is TmeIWEdit then
        ImpostaTestoJQ(Fields[i].FieldName,(medpCompCella(r,medpIndexColonna(Fields[i].FieldName),0) as TmeIWEdit).HTMLName);
  jQAutocomplete.OnReady.Add(CodeAC);
end;

procedure TW047FIscrizioneOrdine.CreaFrame(Griglia: TmedpIWDBGrid; Operazione, FN: String);
begin
  Griglia.medpColumnClick(nil,FN);
  //Apro frame di gestione dati
  FW047Isc:=TW047FIscrizioneOrdineFM.Create(Self);
  CaricaJQAutocomplete(Griglia,-1);
  FW047Isc.evtAbilitaJQ:=AbilitaJqAutocomplete;
  FW047Isc.ReadOnly:=SolaLettura;
  FW047Isc.W047DM2:=FW047DM;
  FW047Isc.DataSetIsc:=(Griglia.medpDataSet as TOracleDataSet);
  FW047Isc.AzioneRichiamo:=Operazione;
  FW047Isc.ValoreV430a:=FW047DM.selV430a.FieldByName(CampiV430a).AsString;
  FW047Isc.Apri;
  FW047Isc.Visualizza;

end;

procedure TW047FIscrizioneOrdine.ImpostaTestoJQ(NomeLogico, NomeComponente: String);
var Elementi:String;
    Lista:TStringList;
    i:Integer;
begin
  Lista:=FW047DM.RecuperaLista(NomeLogico);
  if Lista = nil then
    exit;
  // prepara autocomplete
  if Lista.Count > 0 then
  begin
    //Ciclo su Lista per mantenere le virgole interne al testo delle singole opzioni:
    for i:=0 to Lista.Count - 1 do
      Elementi:=Elementi + IfThen(Elementi <> '',''',''') + C190EscapeJS(Lista[i]);
    Elementi:='''' + Elementi + '''';
    CodeAC:=CodeAC + CRLF +
            'var elementi = [' + Elementi + ']; ' + CRLF +
            '$("#' + NomeComponente + '").autocomplete({ ' + CRLF +
            '  source: elementi, ' + CRLF +
            '  delay: 0,' + CRLF +
            '  minLength: 0' + CRLF +
            '}).focus(function(){ ' + CRLF +
            '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
            '}); ';
  end;
end;

procedure TW047FIscrizioneOrdine.grdIscrizioneOrdineAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var i:Integer;
begin
  inherited;
  with grdIscrizioneOrdine do
  begin
    if not SolaLettura then
    begin
      (medpCompCella(0,0,0) as TmeIWImageFile).OnClick:=imgInserisciIncaricoAttualeClick;
      (medpCompCella(0,0,0) as TmeIWImageFile).Confirmation:=IfThen((medpDataSet.RecordCount > 0) and (FW047DM.ControlloCampiObbligatori(grdIscrizioneOrdine.medpDataSet,medpDataSet) = ''),
        'Attenzione! Si sta inserendo una nuova iscrizione ad un Ordine professionale. Proseguire?');
    end;
    for i:=IfThen(medpComandiInsert,1,0) to High(medpCompGriglia) do
    begin
      //Associo l'evento OnClick alle icone dei comandi
      if not SolaLettura then
        if (medpCompGriglia[i].CompColonne[0] <> nil) then
          (medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgModificaIncaricoAttualeClick;
      if (medpCompGriglia[i].CompColonne[0] <> nil) then
        (medpCompCella(i,0,4) as TmeIWImageFile).OnClick:=imgAccediIncaricoAttualeClick;
    end;
  end;
end;

procedure TW047FIscrizioneOrdine.grdIscrizioneOrdineModifica(Sender: TObject);
begin
  // forza allineamento client dataset a seguito di possibile modifica del record
  // nell'evento OnBeforeEdit del dataset selSG220)
  grdIscrizioneOrdine.medpAllineaRecordCDS;
end;

procedure TW047FIscrizioneOrdine.grdIscrizioneOrdineRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  LNumColonna: Integer;
  LNomeCampo: String;
begin
  if not grdIscrizioneOrdine.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  LNumColonna:=grdIscrizioneOrdine.medpNumColonna(AColumn);
  LNomeCampo:=grdIscrizioneOrdine.medpColonna(LNumColonna).DataField.ToUpper;

  // assegnazione componenti alle celle
  if (ARow > 0) and (ARow - 1 <= High(grdIscrizioneOrdine.medpCompGriglia)) and (grdIscrizioneOrdine.medpCompGriglia[ARow - 1].CompColonne[LNumColonna] <> nil) then
  begin
    ACell.Control:=grdIscrizioneOrdine.medpCompGriglia[ARow - 1].CompColonne[LNumColonna];
    ACell.Text:='';
  end;
end;

function TW047FIscrizioneOrdine.GrigliaBeforeOperazione(Sender: TObject): Boolean;
var Operazione:String;
begin
  inherited;
  Result:=True;
  Operazione:=IfThen((Sender as TmeIWImageFile).Hint = 'Inserisci','Inserimento',IfThen((Sender as TmeIWImageFile).Hint = 'Modifica','Modifica',IfThen((Sender as TmeIWImageFile).Hint = 'Accedi','Accesso','Cancellazione')));
end;

procedure TW047FIscrizioneOrdine.imgAccediIncaricoAttualeClick(Sender: TObject);
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  CreaFrame(grdIscrizioneOrdine,'A',(Sender as TmeIWImageFile).FriendlyName);
end;

procedure TW047FIscrizioneOrdine.imgInserisciIncaricoAttualeClick(Sender: TObject);
var CampoObbl:String;
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  with grdIscrizioneOrdine do
    if (medpDataSet.RecordCount > 0) then
    begin
      CampoObbl:=FW047DM.ControlloCampiObbligatori(grdIscrizioneOrdine.medpDataSet,medpDataSet);
    end;
  if CampoObbl <> '' then
    raise exception.Create('Compilare il campo "' + CampoObbl + '" per l''"Incarico attuale" già presente, prima di inserirne uno nuovo!');
  CreaFrame(grdIscrizioneOrdine,'I',(Sender as TmeIWImageFile).FriendlyName);

end;

procedure TW047FIscrizioneOrdine.imgModificaIncaricoAttualeClick(Sender: TObject);
begin
  if not GrigliaBeforeOperazione(Sender) then
    Exit;
  CreaFrame(grdIscrizioneOrdine,'M',(Sender as TmeIWImageFile).FriendlyName);

end;

procedure TW047FIscrizioneOrdine.PreparaGriglia(Griglia: TmedpIWDBGrid; DataSet: TOracleDataSet);
begin
  Griglia.medpPaginazione:=False;
  Griglia.medpDataset:=DataSet;
  DataSet.Open;
  Griglia.medpComandiCustom:=(Griglia = grdIscrizioneOrdine);
  Griglia.medpAttivaGrid(DataSet,not SolaLettura,not SolaLettura,not SolaLettura);
  PreparaComponenti(Griglia);

end;

procedure TW047FIscrizioneOrdine.PreparaComponenti(Griglia: TmedpIWDBGrid);
begin
  with Griglia do
  begin
    medpCancellaRigaWR102;
    medpPreparaComponentiDefault;
    if (Griglia = grdIscrizioneOrdine) then
    begin
      medpPreparaComponenteGenerico('R',0,4,DBG_IMG,'','ACCEDI','Accedi','','D');
      Griglia.medpCaricaCDS;//Necessario perché queste griglie hanno il medpComandiCustom
    end;
  end;
end;

end.
