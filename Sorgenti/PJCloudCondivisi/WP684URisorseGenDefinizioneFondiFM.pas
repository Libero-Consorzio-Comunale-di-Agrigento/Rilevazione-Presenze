unit WP684URisorseGenDefinizioneFondiFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  Data.DB, A000UInterfaccia, A000UMessaggi, C190FunzioniGeneraliWeb,
  medpIWMessageDlg, medpIWMultiColumnComboBox, WC020UInputDataOreFM, IWCompEdit;

type
  TWP684FRisorseGenDefinizioneFondiFM = class(TWR203FGestDetailFM)
    actRinumeraOrdineStampa: TAction;
    actModificaCodiceVoce: TAction;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actRinumeraOrdineStampaExecute(Sender: TObject);
    procedure actModificaCodiceVoceExecute(Sender: TObject);
    procedure grdTabellaComponenti2DataSet(Row: Integer);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    procedure RinumeraOrdineStampa(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ModificaCodiceVoce(Sender: TObject; Result: Boolean; Valore: String);
  public
    procedure DataSourceStateChange(Sender: TObject); override;
    procedure CaricaDettaglio(DataSet:TDataSet;DataSource:TDataSource); override;
  end;

implementation

uses WP684UDefinizioneFondi, WP684UDefinizioneFondiDM;

{$R *.dfm}

procedure TWP684FRisorseGenDefinizioneFondiFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpEditMultiplo:=False;
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.actRinumeraOrdineStampaExecute(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(A000MSG_P664_DLG_RINUM_ORDINE_STAMPA,mtConfirmation,[mbYes,mbNo],RinumeraOrdineStampa,'');
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.RinumeraOrdineStampa(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
      RinumOrdineStampa(selP686R);
    grdTabella.medpAggiornaCDS(True);
  end;
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.actModificaCodiceVoceExecute(Sender: TObject);
var WC020FInputBoxFM : TWC020FInputDataOreFM;
begin
  WC020FInputBoxFM:=TWC020FInputDataOreFM.Create(Self.Parent);
  WC020FInputBoxFM.ImpostaCampiText('Codice voce:',(WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP686R.FieldByName('COD_VOCE_GEN').AsString);
  WC020FInputBoxFM.ResultEvent:=ModificaCodiceVoce;
  WC020FInputBoxFM.Visualizza('Modifica codice voce');
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.ModificaCodiceVoce(Sender: TObject; Result: Boolean; Valore: String);
var EsitoModificaCodiceVoce:Boolean;
begin
  if Result then
  begin
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    begin
      if Valore = selP686R.FieldByName('COD_VOCE_GEN').AsString then
        exit;
      EsitoModificaCodiceVoce:=ModifCodiceVoce(selP686R,selP686R.FieldByName('COD_FONDO').AsString,DateToStr(selP686R.FieldByName('DECORRENZA_DA').AsDateTime),Valore);
      if EsitoModificaCodiceVoce then
      begin
        grdTabella.medpAggiornaCDS(True);
        MsgBox.WebMessageDlg(A000MSG_P684_MSG_MODIFICA_COD_VOCE,mtInformation,[mbOK],nil,'');
      end
      else
        MsgBox.WebMessageDlg(Format(A000MSG_P684_ERR_FMT_MODIFICA_COD_VOCE,[ScriptSQL.Output.Text]),mtError,[mbOK],nil,'');
    end;
  end;
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.grdTabellaComponenti2DataSet(Row: Integer);
begin
  with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    selP686R.FieldByName('TIPO_VOCE').AsString:=TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO_VOCE'),0)).Text;
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  with TmedpIWMultiColumnComboBox(grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('TIPO_VOCE'),0)) do
  begin
    CustomElement:=True;
    MaxLength:=50;
    Tag:=Row;
    Items.Clear;
    Text:=grdTabella.medpValoreColonna(Row,'TIPO_VOCE');
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW.selP686Tipo do
    begin
      Close;
      SetVariable('CLASS','R');
      Open;
      while not Eof do
      begin
        AddRow(FieldByName('TIPO_VOCE').AsString);
        Next;
      end;
      Close;
    end;
  end;
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.DataSourceStateChange(Sender: TObject);
begin
  if grdTabella.medpDataSet.State in [dsInsert,dsEdit] then
    with (WR302DM as TWP684FDefinizioneFondiDM).P684FDefinizioneFondiMW do
    begin
      TipoElabGen:='R';
      DataElabGen:=selP684.FieldByName('DECORRENZA_DA').AsDateTime;
      FondoElabGen:=selP684.FieldByName('COD_FONDO').AsString;
    end;
  (Self.Owner as TWP684FDefinizioneFondi).AbilitazioniComponenti;//Per impostare actModificaCodiceVoce e actRinumeraOrdineStampa
  inherited;
end;

procedure TWP684FRisorseGenDefinizioneFondiFM.CaricaDettaglio(DataSet: TDataSet; DataSource: TDataSource);
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('TIPO_VOCE'),0,DBG_MECMB,'50','1','null','','S');
end;

end.
