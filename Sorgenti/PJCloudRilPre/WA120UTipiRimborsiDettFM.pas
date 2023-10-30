unit WA120UTipiRimborsiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox, IWCompListbox,
  meIWDBComboBox, A000UCostanti, medpIWMultiColumnComboBox, WA120UTipiRimborsiDM,
  meIWDBLabel,DB, IWHTMLControls, meIWLink, WR100UBase, C180FunzioniGenerali,
  IWMultiColumnComboBox, C190FunzioniGeneraliWeb, IWCompButton, meIWButton,
  WC013UCheckListFM, C018UIterAutDM;

type
  TWA120FTipiRimborsiDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    dchkAnticipo: TmeIWDBCheckBox;
    dcmbTipoRimb: TmeIWDBComboBox;
    lblTipoRimb: TmeIWLabel;
    dchkScaricoPaghe: TmeIWDBCheckBox;
    LblCodiceVociPaghe: TmeIWLabel;
    dedtCodiceVociPaghe: TmeIWDBEdit;
    lblIterMissioniOnLine: TmeIWLabel;
    lblTipoQuantita: TmeIWLabel;
    dcmbTipoQuantita: TmeIWDBComboBox;
    lblPercentualeanticipo: TmeIWLabel;
    dedtPercAnticipo: TmeIWDBEdit;
    lblDescPct: TmeIWLabel;
    lblNoteFisse: TmeIWLabel;
    dedtNoteFisse: TmeIWDBEdit;
    dchkFlagMotivazione: TmeIWDBCheckBox;
    dchkFlagTarga: TmeIWDBCheckBox;
    lblIndennitaSupplementare: TmeIWLabel;
    dchkEsistenza: TmeIWDBCheckBox;
    dchkScarico: TmeIWDBCheckBox;
    LblCodiceVociPagheIndennitaSupplementare: TmeIWLabel;
    dedtCodiceVociPagheIndennitaSupplementare: TmeIWDBEdit;
    LblPercentualePerIndennitaSupplementare: TmeIWLabel;
    dedtPercentualePerIndennitaSupplementare: TmeIWDBEdit;
    cmbArrotondamentoPerIndennitaSupplementare: TMedpIWMultiColumnComboBox;
    dLblArrotondamentoPerIndennitaSupplementare: TmeIWDBLabel;
    LnkArrotondamentoPerIndennitaSupplementare: TmeIWLink;
    lblCategRimborsi: TmeIWLabel;
    dEdtImportoMax: TmeIWDBEdit;
    lblImportoMax: TmeIWLabel;
    dCmbCategRimborso: TMedpIWMultiColumnComboBox;
    dchkFlagMezzoProprio: TmeIWDBCheckBox;
    dedtFasiCompetenza: TmeIWDBEdit;
    btnFasiCompetenza: TmeIWButton;
    lblFasiCompetenza: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbArrotondamentoPerIndennitaSupplementareAsyncChange(
      Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure LnkArrotondamentoPerIndennitaSupplementareClick(Sender: TObject);
    procedure dchkFlagMezzoProprioAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnFasiCompetenzaClick(Sender: TObject);
    procedure dchkAnticipoAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    WC013:TWC013FCheckListFM;
    procedure ResultCausaliCollegate(Sender: TObject; Result:Boolean);
    function IsFasiCompetenzaModificabile: Boolean;
  public
    procedure DataSet2Componenti; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses
  A120UTipiRimborsiMW;

{$R *.dfm}

procedure TWA120FTipiRimborsiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  dcmbTipoRimb.Items.Add('');
  dcmbTipoRimb.Items.Add(M020TIPO_PASTO);
  dcmbTipoRimb.Items.Add(M020TIPO_MEZZO);
  dcmbTipoRimb.Items.Add(M020TIPO_PEDAGGIO);
  dcmbTipoQuantita.NoSelectionText:='';
  inherited;
end;

procedure TWA120FTipiRimborsiDettFM.LnkArrotondamentoPerIndennitaSupplementareClick(Sender: TObject);
var Params: String;
begin
  Params:='CODICE='+ cmbArrotondamentoPerIndennitaSupplementare.Text;
  (Self.Owner as TWR100FBase).AccediForm(519,Params);
end;

function TWA120FTipiRimborsiDettFM.IsFasiCompetenzaModificabile: Boolean;
begin
  Result:=(WR302DM.selTabella.FieldByName('FLAG_ANTICIPO').AsString = 'S') or
          ((WR302DM.selTabella.FieldByName('TIPO').AsString = M020TIPO_MEZZO) and
           (WR302DM.selTabella.FieldByName('FLAG_MEZZO_PROPRIO').AsString = 'S'));
end;

procedure TWA120FTipiRimborsiDettFM.AbilitaComponenti;
begin
  inherited;
  with WR302DM.selTabella do
  begin
    if state  = dsEdit then     //in edit codice non modificabile
      dedtCodice.Enabled:=False
    else
      dedtCodice.Enabled:=True;
  end;
  dchkFlagMezzoProprio.Enabled:=WR302DM.selTabella.FieldByName('TIPO').AsString = M020TIPO_MEZZO;
  btnFasiCompetenza.Enabled:=IsFasiCompetenzaModificabile;
end;

procedure TWA120FTipiRimborsiDettFM.ResultCausaliCollegate(Sender: TObject; Result:Boolean);
begin
  if Result then
  begin
    WR302DM.selTabella.FieldByName('FASI_COMPETENZA').AsString:=C190GetCheckList(5,WC013.ckList);
  end;
end;

procedure TWA120FTipiRimborsiDettFM.btnFasiCompetenzaClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  WC013.ckList.Items.Add(IntToStr(M140FASE_INIZIALE));
  WC013.ckList.Items.Add(IntToStr(M140FASE_RICHIESTA));
  WC013.ckList.Items.Add(IntToStr(M140FASE_AUTORIZZAZIONE));
  WC013.ckList.Items.Add(IntToStr(M140FASE_AGVIAGGIO));
  WC013.ckList.Items.Add(IntToStr(M140FASE_CASSA));
  WC013.ckList.Items.Add(IntToStr(M140FASE_RIMBORSI));
  WC013.ckList.Items.Add(IntToStr(M140FASE_CHIUSURA));
  C190PutCheckList(WR302DM.selTabella.FieldByName('FASI_COMPETENZA').AsString,5,WC013.ckList);
  WC013.ResultEvent:=ResultCausaliCollegate;
  WC013.Visualizza;
end;

procedure TWA120FTipiRimborsiDettFM.CaricaMultiColumnCombobox;
var
  LA120MW: TA120FTipiRimborsiMW;
begin
  inherited;

  LA120MW:=(WR302DM as TWA120FTipiRimborsiDM).A120FTipiRimborsiMW;
  C190CaricaMepdMulticolumnComboBox(dCmbCategRimborso,LA120MW.selM022);
  LA120MW.selP050.First;
  cmbArrotondamentoPerIndennitaSupplementare.Items.Clear;
  while not LA120MW.selP050.Eof do
  begin
    cmbArrotondamentoPerIndennitaSupplementare.AddRow(LA120MW.selP050.FieldByName('COD_ARROTONDAMENTO').AsString + ';' +
                                                      LA120MW.selP050.FieldByName('DESCRIZIONE').AsString + ';' +
                                                      LA120MW.selP050.FieldByName('VALORE').AsString);
    LA120MW.selP050.Next;
  end;
end;

procedure TWA120FTipiRimborsiDettFM.DataSet2Componenti;
begin
  inherited;

  cmbArrotondamentoPerIndennitaSupplementare.Text:=WR302DM.selTabella.FieldByName('ARROTINDENNITASUPPL').AsString;
  dCmbCategRimborso.Text:=WR302DM.selTabella.FieldByName('CATEG_RIMBORSO').AsString;
end;

procedure TWA120FTipiRimborsiDettFM.dchkAnticipoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  btnFasiCompetenza.Enabled:=IsFasiCompetenzaModificabile;
end;

procedure TWA120FTipiRimborsiDettFM.dchkFlagMezzoProprioAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  btnFasiCompetenza.Enabled:=IsFasiCompetenzaModificabile;
end;

procedure TWA120FTipiRimborsiDettFM.cmbArrotondamentoPerIndennitaSupplementareAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('ARROTINDENNITASUPPL').AsString:=cmbArrotondamentoPerIndennitaSupplementare.Text;
  WR302DM.selTabella.FieldByName('CATEG_RIMBORSO').AsString:=dCmbCategRimborso.Text;
end;

end.
