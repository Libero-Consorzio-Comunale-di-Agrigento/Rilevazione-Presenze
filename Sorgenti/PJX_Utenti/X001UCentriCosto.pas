unit X001UCentriCosto;

interface

uses
  A000UInterfaccia, WR010UBase,
  C180FunzioniGenerali, C004UParamForm, X001UCentriCostoDtM,
  Classes, SysUtils, Math, StrUtils, IWAppForm, IWApplication, IWColor, IWTypes,
  Controls, IWVCLBaseControl, IWBaseControl, ClipBrd,
  IWBaseHTMLControl, IWControl, IWCompButton, IWCompEdit, IWGrids, IWDBGrids, DB,
  IWCompCheckbox, IWCompLabel, IWVCLComponent, IWBaseLayoutComponent, DBClient,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, Provider,
  IWHTMLControls, IWCompListbox, IWExtCtrls, IWJQueryWidget, ActnList, Menus,
  IWCompMenu, IWCompExtCtrls, IWCompGrids, meIWImageFile, meIWLabel, meIWLink,
  meIWRadioGroup, meIWCheckBox, meIWGrid, meIWEdit, meIWButton;

type
  TX001FCentriCosto = class(TWR010FBase)
    btnEsegui: TmeIWButton;
    lblDataStampa: TmeIWLabel;
    medtDataStampaDa: TmeIWEdit;
    grdStampa: TmeIWGrid;
    btnCopiaExcel: TmeIWButton;
    medtDataStampaA: TmeIWEdit;
    chkSoloVariazioni: TmeIWCheckBox;
    lblDal: TmeIWLabel;
    lblAl: TmeIWLabel;
    lblOrdinamento: TmeIWLabel;
    rgpOrdinamento: TmeIWRadioGroup;
    procedure btnEseguiClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdStampaRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure btnCopiaExcelClick(Sender: TObject);
    procedure medtDataStampaAAsyncExit(Sender: TObject;
      EventParams: TStringList);
    procedure medtDataStampaDaAsyncExit(Sender: TObject;
      EventParams: TStringList);
  private
    X001FCentriCostoDtm:TX001FCentriCostoDtM;
    C004:TC004FParamForm;
    edtArray: array of TmeIWEdit;
    ElencoCampiInvisibili:String;
    procedure PopolamentoGrigliaDaClientDataSet;
  protected
    procedure DistruggiOggetti; override;
  end;

implementation

uses IWGlobal;

{$R *.dfm}

procedure TX001FCentriCosto.IWAppFormCreate(Sender: TObject);
var
  i:Integer;
  NomeCampoGriglia:String;
begin
  inherited;
  X001FCentriCostoDtm:=TX001FCentriCostoDtM.Create(Self);
  ElencoCampiInvisibili:=W000ParConfig.CampiInvisibili{R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'CampiInvisibili','')}; // gestione parametri di configurazione su file
  medtDataStampaDa.Text:=DateToStr(Date);
  medtDataStampaA.Text:=DateToStr(Date);
  with X001FCentriCostoDtm.selX001 do
  begin
    Close;
    SetVariable('DATAA',Date);
    SetVariable('DATADA',Date);
    SetVariable('FILTRO','AND ROWNUM < 2');
    Open;
    //Svuoto l'array dei componenti edit
    SetLength(edtArray,0);
    //Per ogni campo del clientdataset creo una colonna
    grdStampa.ColumnCount:=FieldCount;
    grdStampa.RowCount:=2;
    PopolamentoGrigliaDaClientDataSet;
    grdStampa.RowCount:=2;

    for i:=0 to FieldCount - 1 do
    begin
      //Alla prima riga imposto il titolo per ogni colonna
      NomeCampoGriglia:=Fields[i].FieldName;
      if NomeCampoGriglia = 'DECORRENZA' then
        grdStampa.Cell[0,i].Text:='Decorrenza'
      else if NomeCampoGriglia = 'SCADENZA' then
        grdStampa.Cell[0,i].Text:='Scadenza'
      else if Pos('D_',NomeCampoGriglia) = 1 then
        grdStampa.Cell[0,i].Text:='Descrizione ' + Copy(NomeCampoGriglia,Pos('D_',NomeCampoGriglia) + 2)
      else
        grdStampa.Cell[0,i].Text:='Codice ' + NomeCampoGriglia;
      //Alla seconda riga imposto il componente filtro per ogni colonna
      SetLength(edtArray,length(edtArray) + 1);
      edtArray[High(edtArray)]:=TmeIWEdit.Create(Self);
      grdStampa.Cell[1,i].Control:=edtArray[High(edtArray)];
      with edtArray[High(edtArray)] do
      begin
        Css:='input_perc90ml0' + IfThen((NomeCampoGriglia = 'DECORRENZA') or (NomeCampoGriglia = 'SCADENZA'),' input_data_dmy');
        Text:='';
        Font.Enabled:=False;
        RenderSize:=False;
        Name:='Filtro' + IntToStr(High(edtArray));
      end;
    end;
  end;
end;

procedure TX001FCentriCosto.DistruggiOggetti;
begin
  try FreeAndNil(C004); except end;
  try FreeAndNil(X001FCentriCostoDtm); except end;
end;

procedure TX001FCentriCosto.medtDataStampaAAsyncExit(Sender: TObject;
  EventParams: TStringList);
begin
  chkSoloVariazioni.Enabled:=medtDataStampaDa.Text <> medtDataStampaA.Text;
  if not chkSoloVariazioni.Enabled then
    chkSoloVariazioni.Checked:=False;
end;

procedure TX001FCentriCosto.medtDataStampaDaAsyncExit(Sender: TObject;
  EventParams: TStringList);
begin
  chkSoloVariazioni.Enabled:=medtDataStampaDa.Text <> medtDataStampaA.Text;
  if not chkSoloVariazioni.Enabled then
    chkSoloVariazioni.Checked:=False;
end;

procedure TX001FCentriCosto.grdStampaRenderCell(ACell: TIWGridCell; const ARow,
  AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,True);
  ACell.Wrap:=ARow <> 1;
  if ARow = grdStampa.CurrentRow then
    ACell.Css:='riga_selezionata';
end;

procedure TX001FCentriCosto.btnCopiaExcelClick(Sender: TObject);
var S{,NomeFile,URL_Stampa}:String;
    i:Integer;
    //F:TextFile;
begin
  with X001FCentriCostoDtm.selX001 do
  begin
    if not Active then
      exit;
    S:='';
    DisableControls;
    First;
    try
      for i:=0 to FieldCount - 1 do
        if Pos(',' + Fields[i].FieldName + ',',',' + ElencoCampiInvisibili + ',') = 0 then
          S:=S + Trim(grdStampa.Cell[0,i].Text) + TAB;
      S:=S + CRLF;
      while not EOF do
      begin
        for i:=0 to FieldCount - 1 do
          if Pos(',' + Fields[i].FieldName + ',',',' + ElencoCampiInvisibili + ',') = 0 then
            S:=S + Fields[i].AsString + TAB;
        S:=S + CRLF;
        Next;
      end;
    finally
      First;
      EnableControls;
    end;
  end;

  // 8.5 new.ini
  {
  NomeFile:=GServerController.FilesDir + 'X001\' + GGetWebApplicationThreadVar.AppID + '.xls';
  ForceDirectories(ExtractFileDir(NomeFile));
  AssignFile(F,NomeFile);
  Rewrite(F);
  Writeln(F,S);
  CloseFile(F);
  URL_Stampa:=StringReplace(GGetWebApplicationThreadVar.AppURLBase,'/X001PCentriCostoTOHM_IIS.dll','',[rfIgnoreCase]) + '/Files/X001/' + GGetWebApplicationThreadVar.AppID + '.xls';
  AddToInitProc('NewWindow("' + URL_Stampa + '","","resizable=yes,toolbar=no,menubar=no,location=no,directories=no,status=no");');
  }
  InviaFile('Centri di costo.xls',S);
  // 8.5.fine
end;

procedure TX001FCentriCosto.btnEseguiClick(Sender: TObject);
var
  sFiltro,sElencoCodici,sFiltroVariazioni:String;
  i:integer;
  DataDa,DataA:TDateTime;

  function NomeColonna(NomeCampo:String):String;
  begin
    Result:='';
    with X001FCentriCostoDtm.selX001 do
    begin
      First;
      while not Eof do
      begin
        if FieldByName(NomeCampo).AsString <> '' then
        begin
          Result:=FieldByName(NomeCampo).AsString;
          Break;
        end;
        Next;
      end;
      First;
    end;
  end;
begin
  //CONTROLLO PARAMETRI DI ELABORAZIONE
  try
    DataDa:=StrToDate(medtDataStampaDa.Text);
  except
    medtDataStampaDa.SetFocus;
    GGetWebApplicationThreadVar.ShowMessage('Impostare la data inizio!');
    exit;
  end;
  try
    DataA:=StrToDate(medtDataStampaA.Text);
  except
    medtDataStampaA.SetFocus;
    GGetWebApplicationThreadVar.ShowMessage('Impostare la data fine!');
    exit;
  end;
  if DataA < DataDa then
  begin
    GGetWebApplicationThreadVar.ShowMessage('La data di fine deve essere maggiore o uguale a quella di inizio!');
    exit;
  end;

  with X001FCentriCostoDtm.selX001 do
  begin
    //Imposto il filtro
    for i:=0 to High(edtArray) do
      if (edtArray[i] <> nil) and (Trim(edtArray[i].Text) <> '') then
        sFiltro:=sFiltro + IfThen(sFiltro <> '',' AND ','') + ' UPPER(' + IfThen((i = 0) or (i = 1),' TO_CHAR(' + Fields[i].FieldName + ',''DD/MM/YYYY'') ',Fields[i].FieldName) + ')' + ' LIKE ' + ' UPPER(' + QuotedStr(edtArray[i].Text) + ')';
    if chkSoloVariazioni.Checked then
    begin
      for i:=0 to FieldCount - 1 do
        if (i <> 0) and (i <> 1) and (Copy(Fields[i].FieldName,1,2) <> 'D_') then
          sElencoCodici:=sElencoCodici + IfThen(sElencoCodici <> '','||''°#°''||','') + Fields[i].FieldName;
      sFiltroVariazioni:=sElencoCodici + ' in (select distinct ' + sElencoCodici;
      // gestione parametri di configurazione su file.ini
      //sFiltroVariazioni:=sFiltroVariazioni + ' from ' + 'X001_' + Copy(R180GetRegistro(HKEY_LOCAL_MACHINE,'X001','TabColPartenza',''),Pos('.',R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'TabColPartenza','')) + 1) + '_' + IntToStr(StrToIntDef(R180GetRegistro(HKEY_LOCAL_MACHINE,CHIAVE_REGISTRO,'NumLivelli',''),0));
      sFiltroVariazioni:=sFiltroVariazioni + ' from ' + 'X001_' + Copy(W000ParConfig.TabColPartenza,Pos('.',W000ParConfig.TabColPartenza) + 1) + '_' + IntToStr(W000ParConfig.NumLivelli);
      // gestione parametri di configurazione su file.fine
      sFiltroVariazioni:=sFiltroVariazioni + ' where decorrenza <= to_date(''' + FormatDateTime('dd/mm/yyyy',DataA) + ''',''dd/mm/yyyy'')';
      sFiltroVariazioni:=sFiltroVariazioni + ' and scadenza >= to_date(''' + FormatDateTime('dd/mm/yyyy',DataDa) + ''',''dd/mm/yyyy'')';
      sFiltroVariazioni:=sFiltroVariazioni + ' and (decorrenza >= to_date(''' + FormatDateTime('dd/mm/yyyy',DataDa) + ''',''dd/mm/yyyy'')';
      sFiltroVariazioni:=sFiltroVariazioni + ' or scadenza <= to_date(''' + FormatDateTime('dd/mm/yyyy',DataA) + ''',''dd/mm/yyyy'')))';
      sFiltro:=sFiltro + IfThen(sFiltro <> '',' AND ','') + sFiltroVariazioni;
    end;
    if sFiltro <> '' then
      sFiltro:='AND ' + sFiltro;
    if (DataA <> GetVariable('DATAA'))
    or (DataDa <> GetVariable('DATADA'))
    or (sFiltro <> GetVariable('FILTRO'))
    or (('ORDER BY ' + IfThen(rgpOrdinamento.ItemIndex = 0,X001FCentriCostoDtm.OrdCod,X001FCentriCostoDtm.OrdDec)) <> GetVariable('ORDINAMENTO')) then
    begin
      Close;
      SetVariable('DATAA',DataA);
      SetVariable('DATADA',DataDa);
      SetVariable('FILTRO',sFiltro);
      SetVariable('ORDINAMENTO','ORDER BY ' + IfThen(rgpOrdinamento.ItemIndex = 0,X001FCentriCostoDtm.OrdCod,X001FCentriCostoDtm.OrdDec));
      Open;
    end;
    //Abilito i pulsanti
    btnCopiaExcel.Enabled:=RecordCount > 0;
  end;
  //Carico i dati del CDS nella griglia
  PopolamentoGrigliaDaClientDataSet;
end;

procedure TX001FCentriCosto.PopolamentoGrigliaDaClientDataSet;
var
  i,j:Integer;
begin
  with X001FCentriCostoDtm.selX001 do
  begin
    //Carico tutti i dati del clientdataset
    grdStampa.RowCount:=RecordCount + 2;
    First;
    for i:=2 to grdStampa.RowCount - 1 do
    begin
      for j:=0 to grdStampa.ColumnCount - 1 do
        grdStampa.Cell[i,j].Text:=Fields[j].AsString;
      Next;
    end;
    //Cancello le colonne invisibili
    for i:=FieldCount - 1 downto 0 do
      if Pos(',' + Fields[i].FieldName + ',',',' + ElencoCampiInvisibili + ',') > 0 then
      begin
        if grdStampa.Cell[1,i].Control <> nil then
        begin
          grdStampa.Cell[1,i].Control.Free;
          grdStampa.Cell[1,i].Control:=nil;
          edtArray[i]:=nil;
        end;
        for j:=0 to grdStampa.RowCount - 1 do
          grdStampa.Cell[j,i].CSS:='invisibile';
      end;
  end;
end;

initialization
  TX001FCentriCosto.SetAsMainForm;

end.
