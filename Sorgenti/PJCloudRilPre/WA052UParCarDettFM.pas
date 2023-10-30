unit WA052UParCarDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox, IWCompListbox,
  meIWDBComboBox, IWCompButton, meIWButton, WC013UCheckListFM, WA052UParCarDM,
  IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWCompGrids, meIWGrid,
  medpIWTabControl, meIWRegion, meIWDBListbox, IWDBGrids, medpIWDBGrid,
  DB, WR102UGestTabella, C190FunzioniGeneraliWeb, A052UParCarMW,
  meIWComboBox, A027UCostanti, OracleData, A000UMessaggi, WA052UElencoFontsFM,
  meIWImageFile, WA052UProprietaFM, WR100UBase,WA052UPreviewFM,IWApplication,meIWEdit,
  medpIWMessageDlg, A000UInterfaccia;

type
  TWA052FParCarDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    dchkRagioneSociale: TmeIWDBCheckBox;
    dchkNumPagine: TmeIWDBCheckBox;
    dchkIntestazioneRipetuta: TmeIWDBCheckBox;
    lblDataStampa: TmeIWLabel;
    dedtDataStampa: TmeIWDBEdit;
    lblMargineSup: TmeIWLabel;
    dedtMargineSup: TmeIWDBEdit;
    lblLogoLarghezza: TmeIWLabel;
    dedtLogoLarghezza: TmeIWDBEdit;
    lblOrientamento: TmeIWLabel;
    dcmbOrientamento: TmeIWDBComboBox;
    lblAssenzeNoRiepilogo: TmeIWLabel;
    dedtAssenzeNoRiepilogo: TmeIWDBEdit;
    btnAssenzeNoRiepilogo: TmeIWButton;
    drgpValCartellino: TmeIWDBRadioGroup;
    lblValCartellino: TmeIWLabel;
    grdTabDetail: TmedpIWTabControl;
    WA052IntestazioneRG: TmeIWRegion;
    WA052DettaglioRG: TmeIWRegion;
    WA052RiepilogoRG: TmeIWRegion;
    TemplateIntestazioneRG: TIWTemplateProcessorHTML;
    TemplateDettaglioRG: TIWTemplateProcessorHTML;
    TemplateRiepilogoRG: TIWTemplateProcessorHTML;
    grdIntestazione: TmedpIWDBGrid;
    grdDettaglio: TmedpIWDBGrid;
    grdRiepilogo: TmedpIWDBGrid;
    btnFontIntestazione: TmeIWButton;
    btnFontDettaglio: TmeIWButton;
    btnFontRiepilogo: TmeIWButton;
    btnPreviewDettaglio: TmeIWButton;
    btnPreviewIntestazione: TmeIWButton;
    btnPreviewRiepilogo: TmeIWButton;
    dchkSeparatoreRiga: TmeIWDBCheckBox;
    dchkSeparatoreColonna: TmeIWDBCheckBox;
    procedure btnAssenzeNoRiepilogoClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdLabesRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure grdIntestazioneDataSet2Componenti(Row: Integer);
    procedure grdDettaglioDataSet2Componenti(Row: Integer);
    procedure grdRiepilogoDataSet2Componenti(Row: Integer);
    procedure btnFontIntestazioneClick(Sender: TObject);
    procedure btnPreviewDettaglioClick(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    procedure CausaliAssenzaKMResult(Sender: TObject; Result: Boolean);
    procedure PreparaComponentiGrid(grd: TMedpIWDBGrid);
    procedure cmbCampoIntestazioneAsyncChange(Sender: TObject;EventParams: TStringList);
    procedure ImpostaComponentiProprietaCampo(grd: TMedpIWDbGrid;
      LabelProperties: TLabelProperties; row: Integer);
    procedure cmbCampoDettaglioAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure cmbCampoRiepilogoAsyncChange(Sender: TObject;
      EventParams: TStringList);
   (*tempdario spostamento a step inibito
    procedure edtIntestazionePosizioneAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure edtDettaglioPosizioneAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure edtRiepilogoPosizioneAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure ReimpostaPosizione(grd: TMedpIWDbGrid; sez: String;row: Integer);
    *)
    procedure imgProprietaClick(Sender: TObject);
    procedure ResultProprietaCampo(Tag: Integer);
    procedure ResultPreview(Sezione: String);
    function  GetNumRigaInModifica(GrigliaMedp:TmedpIWDBGrid):Integer;
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AnnullaModificheDettagli;
  end;

implementation

{$R *.dfm}

{ TWA052FParCarDettFM }
procedure TWA052FParCarDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  //Non usare la variabile WR302DM del frame perchè prima di inherited non ancora valorizzata.
  //Non spostare dopo inherited perchè richiama Dataset2Componenti e deve già essere stato eseguito medpAttivaGrid
  with ((Self.Owner as TWR102FGestTabella).WR302DM as TWA052FParCarDM) do
  begin
    grdIntestazione.medpAttivaGrid(dicCdsLabels[TSezione.INTESTAZIONE],False,False,False);
    grdDettaglio.medpAttivaGrid(dicCdsLabels[TSezione.DETTAGLIO],False,False,False);
    grdRiepilogo.medpAttivaGrid(dicCdsLabels[TSezione.RIEPILOGO],False,False,False);
  end;

  PreparaComponentiGrid(grdIntestazione);
  PreparaComponentiGrid(grdDettaglio);
  PreparaComponentiGrid(grdRiepilogo);
  inherited;
  grdTabDetail.AggiungiTab('Intestazione',WA052IntestazioneRG);
  grdTabDetail.AggiungiTab('Dettaglio',WA052DettaglioRG);
  grdTabDetail.AggiungiTab('Riepilogo',WA052RiepilogoRG);

  grdTabDetail.ActiveTab:=WA052IntestazioneRG;
end;

procedure TWA052FParCarDettFM.ResultProprietaCampo(Tag:Integer);
begin
  grdDettaglio.medpDataSet.FieldByName('TAG').AsInteger:=Tag;
end;

procedure TWA052FParCarDettFM.resultPreview(Sezione: String);
var grd: TMedpIWDBGrid;
begin
  inherited;
  if Sezione = TSezione.INTESTAZIONE then
  begin
    grd:=grdIntestazione;
  end
  else if Sezione = TSezione.DETTAGLIO  then
  begin
    grd:=grdDettaglio;
  end
  else
  begin
    grd:=grdRiepilogo;
  end;

  grd.medpAggiornaCDS(True);
end;

procedure TWA052FParCarDettFM.imgProprietaClick(Sender: TObject);
var
  WA052FProprietaFM: TWA052FProprietaFM;
begin
  inherited;
  with (WR302DM as TWA052FParCarDM).A052FParCarMW do
  begin
    WA052FProprietaFM:=TWA052FProprietaFM.Create(Self.Parent);
    WA052FProprietaFM.ResultProprieta:=ResultProprietaCampo;
    WA052FProprietaFM.visualizza(grdDettaglio.medpDataSet.FieldByName('CAMPOVIS').AsString,grdDettaglio.medpDataSet.FieldByName('TAG').AsInteger);
  end;
end;

procedure TWA052FParCarDettFM.PreparaComponentiGrid(grd: TMedpIWDBGrid);
begin
  //Si aggiunge +1 perchè in modifica compare la colonna con i bottoni di editing
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('CAMPOVIS')+1,0,DBG_CMB,'15','','','','S');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('CAMPOVIS')+1,1,DBG_IMG,'','CAMBIADATO','','','D');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('CAPTION')+1,0,DBG_EDT,'15','','','','S');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('LARGH')+1,0,DBG_EDT,'input_num_nnn','','','','S');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('ALT')+1,0,DBG_EDT,'input_num_nnn','','','','S');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('SINISTRA')+1,0,DBG_EDT,'input_num_nnn','','','','S');
  grd.medpPreparaComponenteGenerico('WR102',grd.medpIndexColonna('ALTO')+1,0,DBG_EDT,'input_num_nnn','','','','S');
end;

procedure TWA052FParCarDettFM.AbilitaComponenti;
var edit: boolean;
begin
  inherited;

  with (WR302DM as TWA052FParCarDM) do
  begin
    dedtAssenzeNoRiepilogo.ReadOnly:=True;
    edit:=SelTabella.State in [dsEdit, dsInsert];
    grdIntestazione.medpAttivaGrid(dicCdsLabels[TSezione.INTESTAZIONE],edit,edit,edit);
    grdDettaglio.medpAttivaGrid(dicCdsLabels[TSezione.DETTAGLIO],edit,edit,edit);
    grdRiepilogo.medpAttivaGrid(dicCdsLabels[TSezione.RIEPILOGO],edit,edit,edit);
    btnPreviewIntestazione.Enabled:=True;
    btnPreviewDettaglio.Enabled:=True;
    btnPreviewRiepilogo.Enabled:=True;
  end;
end;

procedure TWA052FParCarDettFM.DataSet2Componenti;
begin
  inherited;
  grdIntestazione.medpAggiornaCDS(True);
  grdDettaglio.medpAggiornaCDS(True);
  grdRiepilogo.medpAggiornaCDS(True);
end;

procedure TWA052FParCarDettFM.btnAssenzeNoRiepilogoClick(Sender: TObject);
var LstCausaliSelezionate,
    LstCodici,
    LstDescrizioni: TStringList;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  try
    LstCausaliSelezionate:=TStringList.Create;
    LstCodici:=TStringList.Create;
    LstDescrizioni:=TStringList.Create;
    with (WR302DM as TWA052FParCarDM) do
    begin
      A052FParCarMW.selT265.First;
      while not A052FParCarMW.selT265.Eof do
      begin
        LstCodici.Add(A052FParCarMW.selT265.FieldByName('CODICE').AsString);
        LstDescrizioni.Add(Format('%5s %s',[A052FParCarMW.selT265.FieldByName('CODICE').AsString,A052FParCarMW.selT265.FieldByName('DESCRIZIONE').AsString]));
        A052FParCarMW.selT265.Next;
      end;

      WC013.CaricaLista(LstDescrizioni, LstCodici);
      LstCausaliSelezionate.CommaText:=SelTabella.FieldByName('CAUASS_NO_RIEPILOGO').AsString;
      WC013.ImpostaValoriSelezionati(LstCausaliSelezionate);

      WC013.ResultEvent:=CausaliAssenzaKMResult;
      WC013.Visualizza(0,0,'<WC013> Causali assenza');
    end;
  finally
    FreeAndNil(LstCausaliSelezionate);
    FreeAndNil(LstCodici);
    FreeAndNil(LstDescrizioni);
  end;
end;

procedure TWA052FParCarDettFM.btnFontIntestazioneClick(Sender: TObject);
var
  WA052FElencoFontsFM: TWA052FElencoFontsFM;
  sezione: String;
begin
  inherited;
  with (WR302DM as TWA052FParCarDM).A052FParCarMW do
  begin
    WA052FElencoFontsFM:=TWA052FElencoFontsFM.Create(Self.Parent);
    if sender = btnFontIntestazione then
      sezione:=TSezione.INTESTAZIONE
    else if sender = btnFontDettaglio then
      sezione:=TSezione.DETTAGLIO
    else
      sezione:=TSezione.RIEPILOGO;

    WA052FElencoFontsFM.visualizza(dicSezioni[sezione].FontProperties);
  end;
end;

procedure TWA052FParCarDettFM.btnPreviewDettaglioClick(Sender: TObject);
var
  WA052FPreviewFM: TWA052FPreviewFM;
  sezione: String;
  grd: TmedpIWDBGrid;
begin
  inherited;
  if sender = btnPreviewIntestazione then
  begin
    sezione:=TSezione.INTESTAZIONE;
    grd:=grdIntestazione;
  end
  else if sender = btnPreviewDettaglio then
  begin
    sezione:=TSezione.DETTAGLIO;
    grd:=grdDettaglio;
  end
  else
  begin
    sezione:=TSezione.RIEPILOGO;
    grd:=grdRiepilogo;
  end;

  if grd.medpStato in [msEdit,msInsert] then
  begin
    MsgBox.WebMessageDlg(A000MSG_A052_ERR_PENDING,mtInformation,[mbOK],nil,'');
    Abort;
  end;

  with (WR302DM as TWA052FParCarDM) do
  begin
    WA052FPreviewFM:=TWA052FPreviewFM.Create(Self.Parent);
    WA052FPreviewFM.ResultPreview:=ResultPreview;
    WA052FPreviewFM.Visualizza(A052FParCarMW.dicSezioni[sezione],selTabella.State in [dsInsert,dsEdit]);

  end;
end;

procedure TWA052FParCarDettFM.CausaliAssenzaKMResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    (WR302DM as TWA052FParCarDM).SelTabella.FieldByName('CAUASS_NO_RIEPILOGO').AsString:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
  end;

end;
(*tempdario spostamento a step inibito
procedure TWA052FParCarDettFM.edtIntestazionePosizioneAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  row: Integer;
begin
  row:=(Sender as TmeIWEdit).tag;
  ReimpostaPosizione(grdIntestazione,TSezione.INTESTAZIONE, row);
end;

procedure TWA052FParCarDettFM.edtDettaglioPosizioneAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  row: Integer;
begin
  row:=(Sender as TmeIWEdit).tag;
  ReimpostaPosizione(grdDettaglio,TSezione.DETTAGLIO, row);
end;

procedure TWA052FParCarDettFM.edtRiepilogoPosizioneAsyncChange(Sender: TObject;
  EventParams: TStringList);
var
  row: Integer;
begin
  row:=(Sender as TmeIWEdit).tag;
  ReimpostaPosizione(grdRiepilogo,TSezione.RIEPILOGO, row);
end;

procedure TWA052FParCarDettFM.ReimpostaPosizione(grd:TMedpIWDbGrid;sez:String;row:Integer);
var Sezione: TSezione;
begin
  Sezione:=(WR302DM as TWA052FParCarDM).A052FParCarMW.dicSezioni[sez];
  with (grd.medpCompCella(row,grd.medpIndexColonna('SINISTRA'),0) AS TMeIWEdit) do
  begin
    //se il campo è nullo o non numerico può dare eccezione
    try
      Text:=sezione.GotoNearestX(StrToInt(Text)).ToString;
    except
    end;
  end;

  with (grd.medpCompCella(row,grd.medpIndexColonna('ALTO'),0) AS TMeIWEdit) do
  begin
    //se il campo è nullo o non numerico può dare eccezione
    try
      Text:=sezione.GotoNearestY(StrToInt(Text)).ToString;;
    except
    end;
  end;
end;
*)
procedure TWA052FParCarDettFM.cmbCampoIntestazioneAsyncChange(Sender: TObject; EventParams: TStringList);
var
  LabelProperties: TLabelProperties;
  row: Integer;
  campo: String;
begin
  try
    with (Sender as TMeIWComBoBox) do
    begin
      row:=Tag;
      campo:=Text;
    end;

    with (WR302DM as TWA052FParCarDM).A052FParCarMW do
    begin
      selI010.SearchRecord('NOME_LOGICO',campo,[srFromBeginning]);
      LabelProperties:=CreaLabelIntestazione(0,0);
    end;
    ImpostaComponentiProprietaCampo(grdIntestazione,LabelProperties,row);
  finally
    FreeAndNil(LabelProperties);
  end;
end;

procedure TWA052FParCarDettFM.cmbCampoDettaglioAsyncChange(Sender: TObject; EventParams: TStringList);
var
  LabelProperties: TLabelProperties;
  row, idx: Integer;
  campo, s: String;
  img: TmeIWImageFile;
begin
  try
    with (Sender as TMeIWComBoBox) do
    begin
      row:=Tag;
      campo:=Text;
      idx:=ItemIndex + 1;
    end;

    with (WR302DM as TWA052FParCarDM).A052FParCarMW do
    begin
      LabelProperties:=CreaLabelDettaglio(datidett[idx],0,0);
      ImpostaComponentiProprietaCampo(grdDettaglio,LabelProperties,row);

      img:=(grdDettaglio.medpCompCella(Row,grdDettaglio.medpIndexColonna('CAMPOVIS'),1) as TmeIWImageFile);
      //in async la proprietà css non viene recepita
      //devo modificare la classe con jquery.
      //DEVO MANTENERE ALLINEATO ANCHE LA PROPRIETA CSS PERCHE UN SUCCESSIVO EVENTO SUBMIT FAREBBE PERDERE LE IMPOSTAZIONI

      s:='$("#' + img.HTMLName + '").removeClass("invisibile"); ';
      img.Css:=StringReplace(img.Css, ' invisibile', '',[rfReplaceAll]);

      if not hasproprieta(LabelProperties.Tag) then
      begin
        s:=s + '$("#' + img.HTMLName + '").addClass("invisibile");';
        img.Css:= img.Css +  ' invisibile';
      end;
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(s);
    end;

  finally
    FreeAndNil(LabelProperties);
  end;
end;

procedure TWA052FParCarDettFM.cmbCampoRiepilogoAsyncChange(Sender: TObject; EventParams: TStringList);
var
  LabelProperties: TLabelProperties;
  row, idx: Integer;
  campo: String;
begin
  try
    with (Sender as TMeIWComBoBox) do
    begin
      row:=Tag;
      campo:=Text;
      idx:=ItemIndex + 1;
    end;

    with (WR302DM as TWA052FParCarDM).A052FParCarMW do
    begin
      LabelProperties:=CreaLabelRiepilogo(datiRiep[idx],0,0);
    end;
    ImpostaComponentiProprietaCampo(grdRiepilogo,LabelProperties,row);
  finally
    FreeAndNil(LabelProperties);
  end;
end;

function TWA052FParCarDettFM.GetNumRigaInModifica(GrigliaMedp:TmedpIWDBGrid):Integer;
var
  I:Integer;
begin
  Result:=-1;
  if GrigliaMedp.medpStato = msEdit then
  begin
    for I:=1 to High(GrigliaMedp.medpCompGriglia) do
    begin
      if (GrigliaMedp.medpCompGriglia[I].CompColonne[0] as TmeIWGrid).Cell[0,3].Css <> 'invisibile' then
      begin
        Result:=I;
        Break;
      end;
    end;
  end
  else if GrigliaMedp.medpStato = msInsert then
  begin
    if (GrigliaMedp.medpCompGriglia[0].CompColonne[0] as TmeIWGrid).Cell[0,2].Css <> 'invisibile' then
      Result:=0;
  end;
end;

procedure TWA052FParCarDettFM.Componenti2DataSet;
var
  NumRigaInModifica:Integer;
begin
  // In caso di conferma sulla form dobbiamo allineare il contenuto delle grid del
  // dettaglio con il dataset se sono in stato di modifica / inserimento.
  inherited;
  NumRigaInModifica:=GetNumRigaInModifica(grdIntestazione);
  if NumRigaInModifica > -1 then
    grdIntestazione.medpConferma(NumRigaInModifica);

  NumRigaInModifica:=GetNumRigaInModifica(grdDettaglio);
  if NumRigaInModifica > -1 then
    grdDettaglio.medpConferma(NumRigaInModifica);

  NumRigaInModifica:=GetNumRigaInModifica(grdRiepilogo);
  if NumRigaInModifica > -1 then
    grdRiepilogo.medpConferma(NumRigaInModifica);
end;

procedure TWA052FParCarDettFM.ImpostaComponentiProprietaCampo(grd:TMedpIWDbGrid;LabelProperties:TLabelProperties;row:Integer );
begin
  //NomeCampo contiene il nome che viene salvato su db. per intestazione visualizza nome_logico ma salva nome_campo
  grd.medpDataSet.FieldByName('NOMECAMPO').AsString:=LabelProperties.Name;
  grd.medpDataSet.FieldByName('CAMPOVIS').AsString:=(grd.medpCompCella(row,grd.medpIndexColonna('CAMPOVIS'),0) AS TmeIWComboBox).Text;

  grd.medpDataSet.FieldByName('UNIQUENAME').AsString:=LabelProperties.UniqueName;
  grd.medpDataSet.FieldByName('TAG').AsInteger:=LabelProperties.Tag;

  with (grd.medpCompCella(row,grd.medpIndexColonna('CAPTION'),0) AS TMeIWEdit) do
  begin
    if Text = '' then
      Text:=LabelProperties.Caption;
  end;
  with (grd.medpCompCella(row,grd.medpIndexColonna('LARGH'),0) AS TMeIWEdit) do
  begin
    if Text = '' then
      Text:=LabelProperties.Width.ToString;
  end;
  with (grd.medpCompCella(row,grd.medpIndexColonna('ALT'),0) AS TMeIWEdit) do
  begin
    if Text = '' then
      Text:=LabelProperties.Height.ToString;
  end;

  with (grd.medpCompCella(row,grd.medpIndexColonna('SINISTRA'),0) AS TMeIWEdit) do
  begin
    if Text = '' then
      Text:=LabelProperties.Left.ToString;
  end;

  with (grd.medpCompCella(row,grd.medpIndexColonna('ALTO'),0) AS TMeIWEdit) do
  begin
    if Text = '' then
      Text:=LabelProperties.Top.ToString;
  end;
end;

procedure TWA052FParCarDettFM.grdDettaglioDataSet2Componenti(Row: Integer);
var
  combo: TMeIWComBoBox;
  edit: TMeIWEdit;
  idx: Integer;
  dato: TDett;
  img: TmeIWImageFile;
begin
  inherited;
  //su dettaglio pulsante proprietà visibile in alcuni casi
  img:=(grdDettaglio.medpCompCella(Row,grdDettaglio.medpIndexColonna('CAMPOVIS'),1) as TmeIWImageFile);
  with (WR302DM as TWA052FParCarDM).A052FParCarMW do
  begin
    if not hasproprieta(grdDettaglio.medpDataSet.FieldByName('TAG').AsInteger) then
      img.Css:=img.Css + ' invisibile';

    img.OnClick:=imgProprietaClick;
  end;

  combo:=(grdDettaglio.medpCompCella(Row,grdDettaglio.medpIndexColonna('CAMPOVIS'),0) as TMeIWComBoBox );
  combo.Tag:=Row;
  combo.Items.Clear;
  combo.NoSelectionText:='';
  combo.NonEditableAsLabel:=True;

  for dato in DatiDett do
  begin
    idx:=combo.Items.Add(dato.D);
    if dato.D = grdDettaglio.medpDataSet.FieldByName('NOMECAMPO').AsString then
      combo.ItemIndex:=idx;
  end;
  combo.Editable:=not (grdDettaglio.medpDataSet.State = dsEdit);

  combo.OnAsyncChange:=cmbCampoDettaglioAsyncChange;
  (*tempdario spostamento a step inibito
  edit:=(grdDettaglio.medpCompCella(Row,grdDettaglio.medpIndexColonna('SINISTRA'),0) as TmeIWEdit);
  edit.Tag:=Row;
  edit.OnAsyncChange:=edtDettaglioPosizioneAsyncChange;
  edit:=(grdDettaglio.medpCompCella(Row,grdDettaglio.medpIndexColonna('ALTO'),0) as TmeIWEdit);
  edit.Tag:=Row;
  edit.OnAsyncChange:=edtDettaglioPosizioneAsyncChange;
  *)
end;

procedure TWA052FParCarDettFM.grdIntestazioneDataSet2Componenti(Row: Integer);
var
  combo: TMeIWComBoBox;
  edit: TmeIWEdit;
  idx: Integer;
begin
  inherited;
  //su intestazione pulsante proprietà sempre invisibile
  with (grdIntestazione.medpCompCella(Row,grdIntestazione.medpIndexColonna('CAMPOVIS'),1) as TmeIWImageFile) do
    Css:=Css + ' invisibile';

  combo:=(grdIntestazione.medpCompCella(Row,grdIntestazione.medpIndexColonna('CAMPOVIS'),0) as TMeIWComBoBox );
  combo.Tag:=Row;
  combo.Items.Clear;
  combo.NoSelectionText:='';
  combo.NonEditableAsLabel:=True;
  with (WR302DM as TWA052FParCarDM).A052FParCarMW do
  begin
    selI010.First;
    while not selI010.Eof do
    begin
      idx:=combo.Items.Add(selI010.FieldByName('NOME_LOGICO').AsString);
      if selI010.FieldByName('NOME_CAMPO').AsString = grdIntestazione.medpDataSet.FieldByName('NOMECAMPO').AsString then
        combo.ItemIndex:=idx;
      selI010.Next;
    end;
    combo.Editable:=not (grdIntestazione.medpDataSet.State = dsEdit);

    combo.OnAsyncChange:=cmbCampoIntestazioneAsyncChange;
  end;
  (*tempdario spostamento a step inibito
  edit:=(grdIntestazione.medpCompCella(Row,grdIntestazione.medpIndexColonna('SINISTRA'),0) as TmeIWEdit);
  edit.Tag:=Row;
  edit.OnAsyncChange:=edtIntestazionePosizioneAsyncChange;
  edit:=(grdIntestazione.medpCompCella(Row,grdIntestazione.medpIndexColonna('ALTO'),0) as TmeIWEdit);
  edit.Tag:=Row;
  edit.OnAsyncChange:=edtIntestazionePosizioneAsyncChange;
  *)
end;

procedure TWA052FParCarDettFM.grdRiepilogoDataSet2Componenti(Row: Integer);
var
  combo: TMeIWComBoBox;
  edit: TMeIWEdit;
  idx: Integer;
  dato: TRiep;
begin
  inherited;
  //su riepilogo pulsante proprietà sempre invisibile
  with (grdRiepilogo.medpCompCella(Row,grdRiepilogo.medpIndexColonna('CAMPOVIS'),1) as TmeIWImageFile) do
    css:=css + ' invisibile';

  combo:=(grdRiepilogo.medpCompCella(Row,grdRiepilogo.medpIndexColonna('CAMPOVIS'),0) as TMeIWComBoBox );
  combo.Tag:=Row;
  combo.Items.Clear;
  combo.NoSelectionText:='';
  combo.NonEditableAsLabel:=True;

  for dato in DatiRiep do
  begin
    idx:=combo.Items.Add(dato.D);
    if dato.D = grdRiepilogo.medpDataSet.FieldByName('NOMECAMPO').AsString then
      combo.ItemIndex:=idx;
  end;
  combo.Editable:=not(grdRiepilogo.medpDataSet.State = dsEdit);

  combo.OnAsyncChange:=cmbCampoRiepilogoAsyncChange;
  (*tempdario spostamento a step inibito
  edit:=(grdRiepilogo.medpCompCella(Row,grdRiepilogo.medpIndexColonna('SINISTRA'),0) as TmeIWEdit);
  edit.Tag:=Row;
  edit.OnAsyncChange:=edtRiepilogoPosizioneAsyncChange;
  edit:=(grdRiepilogo.medpCompCella(Row,grdRiepilogo.medpIndexColonna('ALTO'),0) as TmeIWEdit);
  edit.Tag:=Row;
  edit.OnAsyncChange:=edtRiepilogoPosizioneAsyncChange;
  *)
end;

procedure TWA052FParCarDettFM.grdLabesRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  grd: TMedpIWDBGrid;
begin
  inherited;
  grd:=TmedpIWDBGrid(ACell.Grid);
  if not grd.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grd.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grd.medpCompGriglia) + 1) and (grd.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grd.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA052FParCarDettFM.AnnullaModificheDettagli;
var
  NumRigaInModifica:Integer;
begin
  NumRigaInModifica:=GetNumRigaInModifica(grdIntestazione);
  if NumRigaInModifica > -1 then
  begin
    grdIntestazione.medpAnnulla(NumRigaInModifica);
    grdIntestazione.medpDataSet.Cancel;
  end;

  NumRigaInModifica:=GetNumRigaInModifica(grdDettaglio);
  if NumRigaInModifica > -1 then
  begin
    grdDettaglio.medpAnnulla(NumRigaInModifica);
    grdDettaglio.medpDataSet.Cancel;
  end;

  NumRigaInModifica:=GetNumRigaInModifica(grdRiepilogo);
  if NumRigaInModifica > -1 then
  begin
    grdRiepilogo.medpAnnulla(NumRigaInModifica);
    grdRiepilogo.medpDataset.Cancel;
  end;
end;

end.
