unit WA118UPubblicazioneDocumentiDettFM;

interface

uses
  A000UCostanti,
  A118UPubblicazioneDocumentiMW,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, medpIWMultiColumnComboBox, IWCompExtCtrls,
  meIWRadioGroup, meIWImageFile, medpIWImageButton, OracleData, Data.DB;

type
  TWA118FPubblicazioneDocumentiDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblFiltro: TmeIWLabel;
    dedtFiltro: TmeIWDBEdit;
    lblTipologiaDocumenti: TmeIWLabel;
    cmbTipologiaDocumenti: TMedpIWMultiColumnComboBox;
    lblRoot: TmeIWLabel;
    dedtRoot: TmeIWDBEdit;
    btnCheckFiltro: TmedpIWImageButton;
    lblSorgenteDocumenti: TmeIWLabel;
    lblDescTipologiaDocumenti: TmeIWLabel;
    cmbSorgenteDocumenti: TMedpIWMultiColumnComboBox;
    lblDescSorgenteDocumenti: TmeIWLabel;
    dedtUrlWS: TmeIWDBEdit;
    lblUrlWS: TmeIWLabel;
    procedure btnCheckFiltroAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbTipologiaDocumentiAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbSorgenteDocumentiChange(Sender: TObject; Index: Integer);
  private

  public
    A118MW: TA118FPubblicazioneDocumentiMW;
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure ImpostaPannelloInfoSorgente;
  end;

implementation

uses
  WA118UPubblicazioneDocumenti,
  WA118UPubblicazioneDocumentiDM,
  IWApplication;

{$R *.dfm}

procedure TWA118FPubblicazioneDocumentiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  CaricaMultiColumnCombobox;
end;

procedure TWA118FPubblicazioneDocumentiDettFM.btnCheckFiltroAsyncClick(Sender: TObject; EventParams: TStringList);
var
  LResCtrl: TResCtrl;
begin
  LResCtrl:=TWA118FPubblicazioneDocumentiDM(WR302DM).A118MW.CheckFiltroDocumenti(dedtFiltro.Text);
  if LResCtrl.Ok then
    GGetWebApplicationThreadVar.ShowMessage('Il filtro di visualizzazione documento è sintatticamente corretto!')
  else
  begin
    if LResCtrl.Messaggio = '' then
      GGetWebApplicationThreadVar.ShowMessage('Il filtro di visualizzazione documento è sintatticamente corretto, ma non è possibile determinarne il risultato!')
    else
      GGetWebApplicationThreadVar.ShowMessage(Format('Il filtro di visualizzazione documento è errato:'#13#10'%s',[LResCtrl.Messaggio]));
  end;
end;

procedure TWA118FPubblicazioneDocumentiDettFM.CaricaMultiColumnCombobox;
begin
  // carica sorgenti documenti
  C190CaricaMepdMulticolumnComboBox(cmbSorgenteDocumenti,TWA118FPubblicazioneDocumentiDM(WR302DM).A118MW.cdsI200Sorgente);

  // carica tipologie documenti
  C190CaricaMepdMulticolumnComboBox(cmbTipologiaDocumenti,TWA118FPubblicazioneDocumentiDM(WR302DM).selT962Lookup);
end;

procedure TWA118FPubblicazioneDocumentiDettFM.cmbSorgenteDocumentiChange(Sender: TObject; Index: Integer);
begin
  if cmbSorgenteDocumenti.ItemIndex >= 0 then
    lblDescSorgenteDocumenti.Caption:=cmbSorgenteDocumenti.Items[cmbSorgenteDocumenti.ItemIndex].RowData[1]
  else
    lblDescSorgenteDocumenti.Caption:='';

  ImpostaPannelloInfoSorgente;
end;

procedure TWA118FPubblicazioneDocumentiDettFM.cmbTipologiaDocumentiAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if cmbTipologiaDocumenti.ItemIndex >= 0 then
    lblDescTipologiaDocumenti.Caption:=cmbTipologiaDocumenti.Items[cmbTipologiaDocumenti.ItemIndex].RowData[1]
  else
    lblDescTipologiaDocumenti.Caption:='';
end;

procedure TWA118FPubblicazioneDocumentiDettFM.Componenti2DataSet;
begin
  // sorgente documenti
  WR302DM.selTabella.FieldByName('SORGENTE_DOCUMENTI').AsString:=cmbSorgenteDocumenti.Text;

  // tipologia documenti
  WR302DM.selTabella.FieldByName('TIPOLOGIA_DOCUMENTI').AsString:=cmbTipologiaDocumenti.Text;
end;

procedure TWA118FPubblicazioneDocumentiDettFM.DataSet2Componenti;
begin
  // sorgente documenti
  cmbSorgenteDocumenti.ItemIndex:=-1;
  cmbSorgenteDocumenti.Text:=WR302DM.selTabella.FieldByName('SORGENTE_DOCUMENTI').AsString;
  lblDescSorgenteDocumenti.Caption:=VarToStr(TWA118FPubblicazioneDocumentiDM(WR302DM).A118MW.cdsI200Sorgente.Lookup('CODICE',cmbSorgenteDocumenti.Text,'DESCRIZIONE'));

  // tipologia documenti
  cmbTipologiaDocumenti.ItemIndex:=-1;
  cmbTipologiaDocumenti.Text:=WR302DM.selTabella.FieldByName('TIPOLOGIA_DOCUMENTI').AsString;
  lblDescTipologiaDocumenti.Caption:=VarToStr(TWA118FPubblicazioneDocumentiDM(WR302DM).selT962Lookup.Lookup('CODICE',cmbTipologiaDocumenti.Text,'DESCRIZIONE'));
end;

procedure TWA118FPubblicazioneDocumentiDettFM.ImpostaPannelloInfoSorgente;
var
  LSorg: String;
begin
  if WR302DM.selTabella.State in [dsInsert,dsEdit] then
    LSorg:=cmbSorgenteDocumenti.Text
  else
    LSorg:=WR302DM.selTabella.FieldByName('SORGENTE_DOCUMENTI').AsString;

  lblTipologiaDocumenti.Visible:=(LSorg = SORGENTE_T960);
  cmbTipologiaDocumenti.Visible:=(LSorg = SORGENTE_T960);
  lblDescTipologiaDocumenti.Visible:=(LSorg = SORGENTE_T960);

  lblUrlWS.Visible:=(R180In(LSorg,[SORGENTE_WS_ENGI_CU,SORGENTE_WS_ENGI_CEDOL]));
  dedtUrlWS.Visible:=(R180In(LSorg,[SORGENTE_WS_ENGI_CU,SORGENTE_WS_ENGI_CEDOL]));

  lblRoot.Visible:=(LSorg = SORGENTE_FS_EXT);
  dedtRoot.Visible:=(LSorg = SORGENTE_FS_EXT);

  // visualizza frame dei livelli solo se la sorgente documenti è su file system
  TWA118FPubblicazioneDocumenti(Self.Owner).LivelliFM.Visible:=(LSorg = SORGENTE_FS_EXT);
end;

end.
