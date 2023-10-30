unit WA020UCausPresenzeStoricoDettFM;

interface

uses
  C180FunzioniGenerali,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox, meIWEdit,
  medpIWMultiColumnComboBox, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  IWCompMemo, meIWMemo;

type
  TWA020FCausPresenzeStoricoDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescCausale: TmeIWLabel;
    dedtDescCausale: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    dchkNonAbilEliminaTimb: TmeIWDBCheckBox;
    chkAnomCausNonAccop: TmeIWDBCheckBox;
    lblCausTimb: TmeIWLabel;
    lblInclEsclOreNorm: TmeIWLabel;
    edtCausTimb: TmeIWEdit;
    edtInclEsclOreNorm: TmeIWEdit;
    lblCausCompDebitoGG: TmeIWLabel;
    cmbCausCompDebitoGG: TMedpIWMultiColumnComboBox;
    dedtOrdineDetraz: TmeIWDBEdit;
    lblOrdineDetraz: TmeIWLabel;
    lblIterAutStrArrotLiq: TmeIWLabel;
    dedtIterAutStrArrotLiq: TmeIWDBEdit;
    dchkIterAutStrArrotLiqFasce: TmeIWDBCheckBox;
    lblIterAutStr: TmeIWLabel;
    lblConteggioTimbInterna: TmeIWLabel;
    drgpConteggioTimbInterna: TmeIWDBRadioGroup;
    dchkAutoCompletamentoUE: TmeIWDBCheckBox;
    dchkSeparaCausaliUE: TmeIWDBCheckBox;
    lblIntersezioneTimbrature: TmeIWLabel;
    drgpIntersezioneTimbrature: TmeIWDBRadioGroup;
    lblPausaMensa: TmeIWLabel;
    dchkMaturaMensa: TmeIWDBCheckBox;
    dchkTimbPM: TmeIWDBCheckBox;
    dchkTimbPMH: TmeIWDBCheckBox;
    dchkTimbPMDetraz: TmeIWDBCheckBox;
    dchkSpezzStraord: TmeIWDBCheckBox;
    dchkRiconoscimentoTurno: TmeIWDBCheckBox;
    lblCdzAbilitazione: TmeIWLabel;
    memoCdzAbilitazione: TmeIWMemo;
    procedure IWFrameRegionRender(Sender: TObject);
    procedure cmbCausCompDebitoGGAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure dchkAutoCompletamentoUEClick(Sender: TObject);
    procedure dchkMaturaMensaClick(Sender: TObject);
    procedure drgpIntersezioneTimbratureClick(Sender: TObject);
  private
    procedure CaricaMultiColumnComboBox; override;
    procedure ImpostaEnabledCampi;
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  end;

implementation

uses
  WA020UCausPresenzeStorico,WA020UCausPresenzeStoricoDM,
  WA020UCausPresenzeDettFM,WA020UCausPresenzeDM,A020UCausPresenzeMW;

{$R *.dfm}

procedure TWA020FCausPresenzeStoricoDettFM.cmbCausCompDebitoGGAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  WR302DM.selTabella.FieldByName('CAUSCOMP_DEBITOGG').AsString:=cmbCausCompDebitoGG.Text;
end;

procedure TWA020FCausPresenzeStoricoDettFM.AbilitaComponenti;
var
  LDettFM:TWA020FCausPresenzeDettFM;
begin
  LDettFM:=((Self.Owner as TWA020FCausPresenzeStorico).WA020FCausPresenze.WDettaglioFM as TWA020FCausPresenzeDettFM);
  edtCausTimb.Text:=LDettFM.drgpCausSuTimbrature.Items[LDettFM.drgpCausSuTimbrature.ItemIndex];
  edtInclEsclOreNorm.Text:=LDettFM.drgpOreNormali.Items[LDettFM.drgpOreNormali.ItemIndex];

  lblCausCompDebitoGG.Enabled:=(WR302DM as TWA020FCausPresenzeStoricoDM).A020MW.OreNormali = 'A';
  cmbCausCompDebitoGG.Enabled:=(WR302DM as TWA020FCausPresenzeStoricoDM).A020MW.OreNormali = 'A';
  dchkAutoCompletamentoUE.Enabled:=R180In((WR302DM as TWA020FCausPresenzeStoricoDM).A020MW.TipoConteggio,['A','E']);
  dchkSeparaCausaliUE.Enabled:=R180In((WR302DM as TWA020FCausPresenzeStoricoDM).A020MW.TipoConteggio,['A','E']);
  dchkSpezzStraord.Enabled:=((WR302DM as TWA020FCausPresenzeStoricoDM).A020MW.OreNormali = 'A')  //Ore escluse dalle normali
                            and
                            ((WR302DM as TWA020FCausPresenzeStoricoDM).A020MW.CodInterno = 'A'); //gruppo Straordinario
  ImpostaEnabledCampi;
end;

procedure TWA020FCausPresenzeStoricoDettFM.ImpostaEnabledCampi;
begin
  drgpConteggioTimbInterna.Enabled:=drgpIntersezioneTimbrature.ItemIndex = 1;
  dchkSeparaCausaliUE.Enabled:=dchkAutoCompletamentoUE.Enabled and dchkAutoCompletamentoUE.Checked;
  dchkTimbPMDetraz.Enabled:=dchkMaturaMensa.Checked;
end;

procedure TWA020FCausPresenzeStoricoDettFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWA020FCausPresenzeStorico).ImpostaDataPeriodoIniziale;
end;

procedure TWA020FCausPresenzeStoricoDettFM.CaricaMultiColumnComboBox;
var
  A020MW:TA020FCausPresenzeMW;
begin
  // Raggiungo il form principale di WA020, da qui il suo DM, da qui il MW
  A020MW:=((Self.Owner as TWA020FCausPresenzeStorico).WA020FCausPresenze.WR302DM as TWA020FCausPresenzeDM).A020MW;
  A020MW.selT275lkpOreNorm.Refresh;
  A020MW.selT275lkpOreNorm.First;
  while not A020MW.selT275lkpOreNorm.Eof do
  begin
    cmbCausCompDebitoGG.AddRow(A020MW.selT275lkpOreNorm.FieldByName('CODICE').AsString + ';' +
                              A020MW.selT275lkpOreNorm.FieldByName('DESCRIZIONE').AsString);
    A020MW.selT275lkpOreNorm.Next;
  end;
end;

procedure TWA020FCausPresenzeStoricoDettFM.DataSet2Componenti;
begin
  cmbCausCompDebitoGG.Text:=WR302DM.selTabella.FieldByName('CAUSCOMP_DEBITOGG').AsString;
  memoCdzAbilitazione.Text:=WR302DM.selTabella.FieldByName('CONDIZIONE_ABILITAZIONE').AsString;
end;

procedure TWA020FCausPresenzeStoricoDettFM.dchkAutoCompletamentoUEClick(Sender: TObject);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TWA020FCausPresenzeStoricoDettFM.dchkMaturaMensaClick(
  Sender: TObject);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TWA020FCausPresenzeStoricoDettFM.drgpIntersezioneTimbratureClick(
  Sender: TObject);
begin
  inherited;
  ImpostaEnabledCampi;
end;

procedure TWA020FCausPresenzeStoricoDettFM.Componenti2DataSet;
begin
  WR302DM.selTabella.FieldByName('CAUSCOMP_DEBITOGG').AsString:=cmbCausCompDebitoGG.Text;
  WR302DM.selTabella.FieldByName('CONDIZIONE_ABILITAZIONE').AsString:=memoCdzAbilitazione.Text;
end;

end.
