unit WC015USelEditGridFM;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Math, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWVCLComponent, IWBaseLayoutComponent, IWApplication,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  DB, DBClient, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWDBGrids, medpIWDBGrid, Oracle, OracleData, IWCompButton, meIWButton,
  meIWGrid, meIWImageFile, meIWEdit, IWCompGrids, IWCompJQueryWidget, Vcl.Menus, IWCompLabel,
  meIWLabel, IWCompEdit, IWCompExtCtrls, medpIWImageButton, meIWImageButton,
  A000UCostanti, A000USessione, A000UInterfaccia, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  Vcl.Imaging.pngimage, meIWImage, meIWRadioGroup;

type
  TWC015ModalResultEvents = procedure(Sender: TObject; Result: Boolean) of object;
  TWC015DataSetEvent = procedure (Sender: TObject; Row: Integer)of object;
  TWC015InitializeEvent = procedure (Sender: TObject)of object;

  TmedpSearchKind = (skInitial,skContent);

  TWC015FSelEditGridFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    grdElenco: TmedpIWDBGrid;
    btnConferma: TmeIWButton;
    ppMnu: TPopupMenu;
    actScaricaInExcelWC015: TMenuItem;
    lblRicerca1: TmeIWLabel;
    edtRicerca: TmeIWEdit;
    btnRicercaSu: TmeIWImageFile;
    btnRicercaGiu: TmeIWImageFile;
    btnRimuoviFiltro: TmeIWImageFile;
    lblRicerca2: TmeIWLabel;
    lblRicerca3: TmeIWLabel;
    rgpTipoRicerca: TmeIWRadioGroup;
    actScaricaInCSVWC015: TMenuItem;
    procedure grdElencoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnChiudiClick(Sender: TObject);
    procedure grdElencoComponenti2DataSet(Row: Integer);
    procedure grdElencoDataSet2Componenti(Row: Integer);
    procedure actScaricaInExcelWC015Click(Sender: TObject);
    procedure grdElencoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure edtRicercaSubmit(Sender: TObject);
    procedure btnRicercaGiuClick(Sender: TObject);
    procedure btnRicercaSuClick(Sender: TObject);
    procedure btnRimuoviFiltroClick(Sender: TObject);
    procedure rgpTipoRicercaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure actScaricaInCSVWC015Click(Sender: TObject);
  private
    {private declaration}
    Titolo:string;
    FConfermaAutomatica: Boolean;
    FmedpSearchField:String;
    procedure grdElencoRowClick;
    procedure AbilitaRicerca;
    procedure EseguiRicerca(DaInizio,CercaAvanti:Boolean);
  public
    {pubplc declaration}
    ResultEvent:TWC015ModalResultEvents;
    //Massimo 18/12/2012 aggiunto DataSetEvent per permettere al chiamante di ridefinire
    //componenti2dataSet, dataSet2Componenti e medppreparacomponeti
    DataSet2ComponentiEvent:TWC015DataSetEvent;
    Componenti2DataSetEvent:TWC015DataSetEvent;
    InizializzaEvent:TWC015InitializeEvent;
    medpSearchFilter:String;
    medpSearchKind:TmedpSearchKind;
    medpCurrRecord:Boolean;
    medpCustomSearchKind:Boolean;
    //Massimo 18/12/2012 aggiunta property
    property  grdTabella: TmedpIWDBGrid read grdElenco write grdElenco;
    property  ConfermaAutomatica: Boolean read FConfermaAutomatica write FConfermaAutomatica;
    property  medpSearchField:String read FmedpSearchField write FmedpSearchField;
    procedure Visualizza(Title:String;selElenco:TDataset;const ActiveEdit:Boolean = True;const AllowInsert:Boolean = True;const Conferma:Boolean = False;W:Integer = 700);
  end;

implementation

uses WR010UBase;

{$R *.dfm}

procedure TWC015FSelEditGridFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  medpCurrRecord:=True;
  medpSearchKind:=skInitial;
  medpCustomSearchKind:=False;
  medpSearchField:='';
  medpSearchFilter:='';
  edtRicerca.Text:='';
  FConfermaAutomatica:=False;
  grdElenco.medpPaginazione:=True;
  grdElenco.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
end;

procedure TWC015FSelEditGridFM.rgpTipoRicercaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaRicerca;
end;

procedure TWC015FSelEditGridFM.Visualizza(Title:String;selElenco:TDataset;const ActiveEdit:Boolean = True;const AllowInsert:Boolean = True;const Conferma:Boolean = False;W:Integer = 700);
var i:Integer;
    locSearchField:String;
begin
  btnConferma.Visible:=Conferma;
  btnChiudi.Visible:=Conferma;
  grdElenco.Summary:=Format('Tabella per %s',[Title]);
  rgpTipoRicerca.ItemIndex:=IfThen(medpSearchKind = skContent,0,1);

  grdElenco.medpDataSet:=selElenco;
  //registra chiave record attuale
  if medpCurrRecord then
    grdElenco.SetCurrRecord;
  if (selElenco is TOracleDataset) and (medpSearchField <> '') then
  begin
    //imposta ordinamento di default
    locSearchField:=medpSearchField;
    grdElenco.medpSortField:=medpSearchField;
  end;
  grdElenco.medpAttivaGrid(selElenco,ActiveEdit,AllowInsert);
  //imposta filtro
  btnRimuoviFiltro.Visible:=False;
  if Pos('=''*''',medpSearchFilter) > 0 then
    medpSearchFilter:='';
  if medpSearchFilter <> '' then
  begin
    grdElenco.medpDataSet.Filter:=medpSearchFilter;
    grdElenco.medpDataSet.Filtered:=True;
    //Se nessun record annullo il filtro per poter scegliere su tutto il dataset
    if grdElenco.medpDataSet.RecordCount = 0 then
      grdElenco.medpDataSet.Filtered:=False;
    btnRimuoviFiltro.Visible:=grdElenco.medpDataSet.Filtered;
  end;
  //Se nessun campo di ricerca definito, imposto quello della prima colonna
  if medpSearchField = '' then
  begin
    for i:=0 to grdElenco.Columns.Count - 1 do
      if grdElenco.medpColonna(i).Visible then
      begin
        medpSearchField:=grdElenco.medpColonna(i).DataField;
        Break;
      end;
  end;
  if (selElenco is TOracleDataset) and (medpSearchField <> '') then
  begin
    //imposta ordinamento di default
    if locSearchField <> medpSearchField then
      selElenco.Refresh;
    AbilitaRicerca;
  end;
  if medpCurrRecord then
    grdElenco.GetCurrRecord;
  if (medpSearchField <> '') or (medpSearchFilter <> '') then
    grdElenco.medpAggiornaCDS(True) //Ricarico il CDS della dbgrid
  else
    grdElenco.medpAggiornaCDS(False);
  if Assigned(InizializzaEvent) then
  try
    InizializzaEvent(Self);
  except
    on E: EAbort do;
    on E: Exception do
      raise;
  end;
  Titolo:=Title;

  if FConfermaAutomatica then
    grdElenco.OnRowClick:=grdElencoRowClick;

  if Conferma then
    (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,W,-1,EM2PIXEL * 30, Titolo,'#' + Name,False,True,-1,'','')
  else
  begin
    (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,W,-1,EM2PIXEL * 30, Titolo,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
    // nasconde l'area dei pulsanti che risulta altrimenti vuota    
    jQuery.OnReady.Add('$(''.area_pulsanti'').hide();');
  end;
end;

procedure TWC015FSelEditGridFM.btnRicercaGiuClick(Sender: TObject);
begin
  inherited;
  EseguiRicerca(False,True);
end;

procedure TWC015FSelEditGridFM.EseguiRicerca(DaInizio,CercaAvanti:Boolean);
var
  searchString: String;
  sroSucc,sroInizio:TSearchRecordOptions;
begin
  inherited;
  if grdElenco.medpDataSet <> nil then
  begin
    if grdElenco.medpStato <> msBrowse then
      exit;
    searchString:=Trim(edtRicerca.Text);
    if searchString <> '' then
    begin
      //aggiunta sempre della wildcard al fondo della stringa di ricerca
      if searchString[Length(searchString)] <> '%' then
        searchString:=searchString + '%';
      if (medpSearchKind = skContent) and (searchString[1] <> '%') then
        searchString:='%' + searchString;

      //sostituzione wildcards. SearchRecord usa *
      searchString:=StringReplace(searchString,'%','*',[rfReplaceAll]);

      //cerco da record corrente, se non trovo parto dall'inizio/fine
      if CercaAvanti then
      begin
        sroSucc:=[srFromCurrent,srForward,srIgnoreCase,srWildCards];
        sroInizio:=[srFromBeginning,srIgnoreCase,srWildCards];
      end
      else
      begin
        sroSucc:=[srFromCurrent,srBackward,srIgnoreCase,srWildCards];
        sroInizio:=[srFromEnd,srIgnoreCase,srWildCards];
      end;
      if DaInizio or (not TOracleDataSet(grdElenco.medpDataSet).SearchRecord(grdElenco.medpSortField,searchString,sroSucc)) then
        TOracleDataSet(grdElenco.medpDataSet).SearchRecord(grdElenco.medpSortField,searchString,sroInizio);

      grdElenco.medpAggiornaCDS;
    end;
  end;
end;

procedure TWC015FSelEditGridFM.btnRicercaSuClick(Sender: TObject);
begin
  inherited;
  EseguiRicerca(False,False);
end;

procedure TWC015FSelEditGridFM.btnRimuoviFiltroClick(Sender: TObject);
begin
  inherited;
  grdElenco.SetCurrRecord;
  grdElenco.medpDataSet.Filtered:=False;
  grdElenco.GetCurrRecord;
  grdElenco.medpAggiornaCDS(True); //Ricarico il CDS della dbgrid
  btnRimuoviFiltro.Visible:=False;
end;

procedure TWC015FSelEditGridFM.actScaricaInCSVWC015Click(Sender: TObject);
var NomeFile:String;
begin
  if (Self.Owner is TWR010FBase) then
  begin
    if not Assigned(Sender) then
      (Self.Owner as TWR010FBase).csvDownload:=grdElenco.ToCsv
    else
    begin
      NomeFile:=Titolo + '.xls';
      NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
      (Self.Owner as TWR010FBase).InviaFile(NomeFile,(Self.Owner as TWR010FBase).csvDownload);
    end;
  end
  else
    raise Exception.Create('WC015FSelEditGridFM: Owner non impostato, impossibile proseguire');
end;

procedure TWC015FSelEditGridFM.actScaricaInExcelWC015Click(Sender: TObject);
var NomeFile:String;
begin
  if (Self.Owner is TWR010FBase) then
  begin
    if not Assigned(Sender) then
      (Self.Owner as TWR010FBase).streamDownload:=grdElenco.ToXlsx
    else
    begin
      NomeFile:=Titolo + '.xlsx';
      NomeFile:=NomeFile.Replace(' ','_').Replace('(','').Replace(')','').Replace('/','').Replace('\','');
      (Self.Owner as TWR010FBase).InviaFile(NomeFile,(Self.Owner as TWR010FBase).streamDownload);
    end;
  end
  else
    raise Exception.Create('WC015FSelEditGridFM: Owner non impostato, impossibile proseguire');
end;

procedure TWC015FSelEditGridFM.edtRicercaSubmit(Sender: TObject);
begin
  inherited;
  EseguiRicerca(True,True);
end;

procedure TWC015FSelEditGridFM.grdElencoAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
begin
  inherited;
  AbilitaRicerca;
end;

procedure TWC015FSelEditGridFM.AbilitaRicerca;
begin
  lblRicerca1.Visible:=(*btnConferma.Visible and*) (grdElenco.medpSortField <> '');
  lblRicerca2.Visible:=lblRicerca1.Visible and not medpCustomSearchKind;
  rgpTipoRicerca.Visible:=lblRicerca1.Visible and medpCustomSearchKind;
  lblRicerca3.Visible:=lblRicerca1.Visible;
  edtRicerca.Visible:=(*btnConferma.Visible and*) (grdElenco.medpSortField <> '');
  btnRicercaGiu.Visible:=(*btnConferma.Visible and*) (grdElenco.medpSortField <> '');
  btnRicercaSu.Visible:=(*btnConferma.Visible and*) (grdElenco.medpSortField <> '');
  if grdElenco.medpSortField <> '' then
  begin
    if medpCustomSearchKind then
    begin
      if rgpTipoRicerca.ItemIndex = 0 then
        medpSearchKind:=skContent
      else
        medpSearchKind:=skInitial;
    end;
    if medpSearchField <> grdElenco.medpSortField then
    begin
      medpSearchField:=grdElenco.medpSortField;
      edtRicerca.Text:='';
      if not medpCustomSearchKind then
      begin
        if grdElenco.medpDataSet.FieldByName(grdElenco.medpSortField).Size > 20 then
          medpSearchKind:=skContent
        else
          medpSearchKind:=skInitial;
      end;
    end;
    if lblRicerca1.Visible then
    begin
      lblRicerca1.Caption:='Ricerca per ';
      lblRicerca2.Caption:=IfThen(medpSearchKind = skContent,'Contenuto','Iniziale');
      lblRicerca3.Caption:=' in ' + grdElenco.medpDataSet.FieldByName(grdElenco.medpSortField).DisplayLabel;
    end;
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoComponenti2DataSet(Row: Integer);
begin
  inherited;
  if Assigned(Componenti2DataSetEvent) then
  begin
    try
      Componenti2DataSetEvent(Self,Row);
    except
      on E: EAbort do;
      on E: Exception do
        raise;
    end;
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoDataSet2Componenti(Row: Integer);
begin
  inherited;
  if Assigned(DataSet2ComponentiEvent) then
  begin
    try
      DataSet2ComponentiEvent(Self,Row);
    except
      on E: EAbort do;
      on E: Exception do
        raise;
    end;
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdElenco.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdElenco.medpCompGriglia) + 1) and (grdElenco.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdElenco.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWC015FSelEditGridFM.grdElencoRowClick;
begin
  if FConfermaAutomatica then
    btnChiudiClick(btnConferma);
end;

procedure TWC015FSelEditGridFM.btnChiudiClick(Sender: TObject);
var Res: Boolean;
begin
  Res:=(Sender = btnConferma);

  if Assigned(ResultEvent) then
  begin
    try
      ResultEvent(Self,Res);
    except
      on E: EAbort do;
      on E: Exception do
        raise;
    end;
  end;
  if medpSearchFilter <> '' then
    grdElenco.medpDataSet.Filtered:=False;
  ReleaseOggetti;
  Free;
end;

end.
