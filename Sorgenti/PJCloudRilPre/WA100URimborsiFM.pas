unit WA100URimborsiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompGrids, meIWGrid, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, medpIWMessageDlg, WA100UMissioniDM,
  A000UInterfaccia, OracleData, DB, C190FunzioniGeneraliWeb, MedpIWMultiColumnComboBox, meIWLabel,
  meIWedit, IWCompEdit, meIWImageFile, WA100UDettaglioImportiFM, A100UMissioniMW,
  Vcl.Menus;

type
  TWA100FRimborsiFM = class(TWR203FGestDetailFM)
    pmnTipoRimborso: TPopupMenu;
    Accedi1: TMenuItem;
    procedure actConfermaExecute(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure actAnnullaExecute(Sender: TObject);
    procedure Accedi1Click(Sender: TObject);
  private
    RowEdit: Integer;
    comboTipiRimborso: TMedpIWMultiColumnComboBox;
    procedure cmbCodRimbAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure edtImpRimbSpeseAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure imgDettaglioImportiClick(Sender: TObject);
    procedure ResultDettaglioImporti(Reset:Boolean);
    procedure cmbValutaEstAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
  protected
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String); override;
  public
    procedure caricaComboTipiRimborso;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation uses WA100UMissioni;

{$R *.dfm}

procedure TWA100FRimborsiFM.Accedi1Click(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='CODICE=' + (pmnTipoRimborso.PopupComponent as TMedpIWMultiColumnComboBox).Text;
  (Self.Parent as TWA100FMissioni).AccediForm(156,Params,False);
end;

procedure TWA100FRimborsiFM.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  //Reset filtro
  with ((Self.Parent as TWA100FMissioni).WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    M051.CancelUpdates;

    CalcolaTotaleRimborsi;
    FiltraRegoleRimborsi(False);
  end;
end;

procedure TWA100FRimborsiFM.actConfermaExecute(Sender: TObject);
var Msg: String;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //Per cloud fare sempre ApplyUpdates perchè in cachedUpdate (Su win lo fa toolbarfiglio)
    SessioneOracle.ApplyUpdates([Q050],True);
    SessioneOracle.ApplyUpdates([M051],True);
    Q050.Refresh;
    CalcolaTotaleRimborsi;
    Msg:=GestioneMese;
    if Msg <> '' then
      MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],nil,'');

    //Reset filtro
    FiltraRegoleRimborsi(False);
  end;
end;

procedure TWA100FRimborsiFM.actModificaExecute(Sender: TObject);
begin
  //Filtro. deve farlo qui perchè in dataset2componenti il dataset è in edit e il refresh lo riporta in browse
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    FiltraRegoleRimborsi;
    VerificaRimborsoPastoEsistente;
  end;
  inherited;
end;

procedure TWA100FRimborsiFM.actNuovoExecute(Sender: TObject);
begin
  //Filtro. deve farlo qui perchè in dataset2componenti il dataset è in edit e il refresh lo riporta in browse
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    FiltraRegoleRimborsi;
    VerificaRimborsoPastoEsistente;
  end;
  inherited;
end;

procedure TWA100FRimborsiFM.CaricaDettaglio(DataSet: TDataSet;DataSource: TDataSource);
begin
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICERIMBORSOSPESE'),0,DBG_MECMB,'5','4','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('DESCRIMBORSO'),0,DBG_LBL,'50','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICEVOCEPAGHE'),0,DBG_LBL,'10','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('CODICEVOCEPAGHEINDENNITASUPPL'),0,DBG_LBL,'10','1','null','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTORIMBORSOSPESE'),0,DBG_EDT,'input_num_generic','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTORIMBORSOSPESE'),1,DBG_IMG,'','CAMBIADATO','','','D');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPORTOCOSTORIMBORSO'),0,DBG_EDT,'input_num_generic','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COD_VALUTA_EST'),0,DBG_MECMB,'5','2','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPRIMB_VALEST'),0,DBG_EDT,'input_num_generic','','','','S');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('IMPRIMB_VALEST'),1,DBG_IMG,'','CAMBIADATO','','','D');
end;

procedure TWA100FRimborsiFM.caricaComboTipiRImborso;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    Q020.First;
    comboTipiRimborso.Items.Clear;
    while not Q020.Eof do
    begin
      comboTipiRimborso.AddRow(Q020.FieldByName('CODICE').AsString + ';' + Q020.FieldByName('DESCRIZIONE').AsString + ';' +
                   Q020.FieldByName('CODICEVOCEPAGHE').AsString + ';' + Q020.FieldByName('CODICEVOCEPAGHEINDENNITASUPPL').AsString);
      Q020.Next;
    end;
  end;
end;

procedure TWA100FRimborsiFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  comboValuta: TMedpIWMultiColumnComboBox;
  editImportoCosto, edit: TmeIWedit;
  img: TmeIWImageFile;
begin
  inherited;
  //Salvo riga di edit
  RowEdit:=Row;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin

    comboTipiRimborso:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICERIMBORSOSPESE'),0) as TMedpIWMultiColumnComboBox );
    comboTipiRimborso.Tag:=Row;
    comboTipiRimborso.Items.Clear;
    comboTipiRimborso.PopupHeight:=10;

    CaricaComboTipiRimborso;

    comboTipiRimborso.OnAsyncChange:=cmbCodRimbAsyncChange;
    comboTipiRimborso.medpContextMenu:=pmnTipoRimborso;

    //Descrizione
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('DESCRIMBORSO'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row, 'DESCRIMBORSO');

    //Codice voce paghe
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICEVOCEPAGHE'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row, 'CODICEVOCEPAGHE');

    //Codice voce paghe I.S.
    (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICEVOCEPAGHEINDENNITASUPPL'),0) as TmeIWLabel).Caption:=grdTabella.medpValoreColonna(Row, 'CODICEVOCEPAGHEINDENNITASUPPL');
    edit:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTORIMBORSOSPESE'),0) as TmeIWedit);
    //devo impostare subito su campo del dataset perchè eseguito test per dettagliare l'importo
    edit.OnAsyncChange:=edtImpRImbSpeseAsyncChange;
    editImportoCosto:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTOCOSTORIMBORSO'),0) as TmeIWedit);
    if M051.Active then
    begin
      edit.ReadOnly:=M051.RecordCount > 0;
      editImportoCosto.ReadOnly:=M051.RecordCount > 0;
    end;
    editImportoCosto.ReadOnly:=Q050.FieldByName('IMPORTOCOSTORIMBORSO').ReadOnly and
                               (VarToStr(Q020.Lookup('CODICE', Q050.FieldByName('CODICERIMBORSOSPESE').AsString, 'FLAG_ANTICIPO')) = 'S');


    //Pulsante dettaglio importi
    img:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPORTORIMBORSOSPESE'),1) as TmeIWImageFile);
    img.Tag:=Row;
    img.OnClick:=imgDettaglioImportiClick;

    img:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPRIMB_VALEST'),1) as TmeIWImageFile);
    img.Tag:=Row;
    img.OnClick:=imgDettaglioImportiClick;

    //cod valuta est

    comboValuta:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('COD_VALUTA_EST'),0) as TMedpIWMultiColumnComboBox );
    comboValuta.Tag:=Row;
    comboValuta.Items.Clear;
    comboValuta.PopupHeight:=10;

    SelP030.Close;
    SelP030.SetVariable('DATADA',(WR302DM as TWA100FMissioniDM).selTabella.FieldByName('DATADA').AsDateTime);
    SelP030.Open;

    SelP030.First;
    while not SelP030.Eof do
    begin
      comboValuta.AddRow(SelP030.FieldByName('COD_VALUTA').AsString + ';' + SelP030.FieldByName('DESCRIZIONE').AsString);
      SelP030.Next;
    end;
    comboValuta.OnAsyncChange:=cmbValutaEstAsyncChange;
    //importo valuta est
    edit:=(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('IMPRIMB_VALEST'),0) as TmeIWedit);
    edit.ReadOnly:=(comboValuta.Text = '');
  end;
end;

procedure TWA100FRimborsiFM.imgDettaglioImportiClick(Sender: TObject);
var
  Msg: String;
  WA100DettaglioImporti:TWA100FDettaglioImportiFM;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    Msg:=VerificaDettaglioRimborsi;
    if Msg <> '' then
    begin
      MsgBox.WebMessageDlg(Msg,mtError,[mbOk],nil,'');
      Exit;
    end;

    WA100DettaglioImporti:=TWA100FDettaglioImportiFM.Create(Self.Parent);
    WA100DettaglioImporti.ResultEvent:=ResultDettaglioImporti;
    WA100DettaglioImporti.Visualizza;
  end;
end;

//cambio label sul cambio della combo
procedure TWA100FRimborsiFM.cmbCodRimbAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var cmb: TMedpIWMultiColumnComboBox;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    grdTabella.medpDataset.FieldByName('CODICERIMBORSOSPESE').AsString:=cmb.Text;

    //Descrizione e codice voce paghhe  sono lookup di CODICERIMBORSOSPESE
    (grdTabella.medpCompCella(cmb.Tag,grdTabella.medpIndexColonna('DESCRIMBORSO'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('DESCRIMBORSO').AsString;
    (grdTabella.medpCompCella(cmb.Tag,grdTabella.medpIndexColonna('CODICEVOCEPAGHE'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('CODICEVOCEPAGHE').AsString;
    (grdTabella.medpCompCella(cmb.Tag,grdTabella.medpIndexColonna('CODICEVOCEPAGHEINDENNITASUPPL'),0) as TmeIWLabel).Caption:=grdTabella.medpDataset.FieldByName('CODICEVOCEPAGHEINDENNITASUPPL').AsString;
  end;
end;


procedure TWA100FRimborsiFM.cmbValutaEstAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var
  cmb: TMedpIWMultiColumnComboBox;
  edit: TmeIWedit;
begin
  cmb:=(Sender as TMedpIWMultiColumnComboBox);
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    grdTabella.medpDataset.FieldByName('COD_VALUTA_EST').AsString:=cmb.Text;

    edit:=(grdTabella.medpCompCella(cmb.tag,grdTabella.medpIndexColonna('IMPRIMB_VALEST'),0) as TmeIWedit);
    if cmb.Text = '' then
      edit.Text:='';
    edit.ReadOnly:=(cmb.Text = '');
  end;
end;

procedure TWA100FRimborsiFM.edtImpRImbSpeseAsyncChange(Sender: TObject;EventParams: TStringList);
var edt: TmeIWEdit;
begin
  edt:=(Sender as TmeIWEdit);
  grdTabella.medpDataset.FieldByName('IMPORTORIMBORSOSPESE').AsString:=edt.Text
end;

procedure TWA100FRimborsiFM.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
var bSegnalazionePastoOldValue: Boolean;
  Msg:String;
begin
  inherited;
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    //Per cloud fare sempre ApplyUpdates perchè in cachedUpdate (Su win lo fa toolbarfiglio)
    VerificaRimborsoPastoEsistente;
    bSegnalazionePastoOldValue:=bPb_RimborsoPastoEsistente;
    SessioneOracle.ApplyUpdates([Q050],True);
    SessioneOracle.ApplyUpdates([M051],True);
    CalcolaTotaleRimborsi;
    Msg:=RicalcolaDeleteRimborso(bSegnalazionePastoOldValue);
    if Msg <> '' then
      MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],nil,'');
  end;
end;

procedure TWA100FRimborsiFM.ResultDettaglioImporti(Reset:Boolean);
var DettaglioImporti: TCostiDettaglio;
begin
  with (WR302DM as TWA100FMissioniDM).A100FMissioniMW do
  begin
    if reset then
    begin
      Q050.FieldByName('IMPORTORIMBORSOSPESE').AsInteger:=0;
      (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('IMPORTORIMBORSOSPESE'),0) as TmeIWEdit).Text:=Q050.FieldByName('IMPORTORIMBORSOSPESE').AsString;
    end;

    if Not(M051.Active) then
      exit;
    if (M051.RecordCount > 0) then
    begin
      DettaglioImporti:=CostiDettaglio;

      if DettaglioImporti.nCosto >= 0 then
      begin
        Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsFloat:=DettaglioImporti.nCosto;
        (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('IMPORTOCOSTORIMBORSO'),0) as TmeIWEdit).Text:=Q050.FieldByName('IMPORTOCOSTORIMBORSO').AsString;

        Q050.FieldByName('COSTORIMB_VALEST').AsFloat:=DettaglioImporti.EstRimborso;
        Q050.FieldByName('IMPRIMB_VALEST').AsFloat:=DettaglioImporti.EstCosto;
        (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('COSTORIMB_VALEST'),0) as TmeIWEdit).Text:=Q050.FieldByName('COSTORIMB_VALEST').AsString;
        (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('IMPRIMB_VALEST'),0) as TmeIWEdit).Text:=Q050.FieldByName('IMPRIMB_VALEST').AsString;

        Q050.FieldByName('IMPORTORIMBORSOSPESE').AsFloat:=DettaglioImporti.nRimborso;
        with (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('IMPORTORIMBORSOSPESE'),0) as TmeIWEdit) do
        begin
          Text:=Q050.FieldByName('IMPORTORIMBORSOSPESE').AsString;
          ReadOnly:=True;
        end;
      end;
    end;
    //su cloud operare su edit
    if M051.RecordCount <= 0 then
    begin
      (grdTabella.medpCompCella(RowEdit,grdTabella.medpIndexColonna('IMPORTORIMBORSOSPESE'),0) as TmeIWEdit).ReadOnly:=False;
    end;
  end;
end;

end.
