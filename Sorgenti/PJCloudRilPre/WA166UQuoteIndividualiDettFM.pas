unit WA166UQuoteIndividualiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompCheckbox, IWDBStdCtrls, meIWDBCheckBox, DB,
  IWCompEdit, medpIWMultiColumnComboBox, IWCompLabel, meIWLabel,
  WA166UQuoteIndividualiDM, meIWDBLabel, meIWDBEdit, C180FunzioniGenerali;

type
  TWA166FQuoteIndividualiDettFM = class(TWR205FDettTabellaFM)
    dchkForzaProva: TmeIWDBCheckBox;
    dchkPartTime: TmeIWDBCheckBox;
    dchkSospendiQuote: TmeIWDBCheckBox;
    lblTipoQuota: TmeIWLabel;
    cmbTipoQuota: TMedpIWMultiColumnComboBox;
    dlblTipoQuota: TmeIWDBLabel;
    lblImporto: TmeIWLabel;
    dedtImporto: TmeIWDBEdit;
    lblNumOre: TmeIWLabel;
    dedtNumore: TmeIWDBEdit;
    lblPercentuale: TmeIWLabel;
    dedtPercentuale: TmeIWDBEdit;
    dchkConsideraSaldo: TmeIWDBCheckBox;
    lblPercIndividuale: TmeIWLabel;
    dedtPercIndividuale: TmeIWDBEdit;
    lblPercStrutturale: TmeIWLabel;
    dedtPercStrutturale: TmeIWDBEdit;
    lblPenalizzazione: TmeIWLabel;
    dedtPenalizzazione: TmeIWDBEdit;
    lblTipologia: TmeIWLabel;
    dedtDecorrenza: TmeIWDBEdit;
    lblDecorrenza: TmeIWLabel;
    dedtScadenza: TmeIWDBEdit;
    lblScadenza: TmeIWLabel;
    procedure dchkSospendiQuoteAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure cmbTipoQuotaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure dedtPercentualeAsyncChange(Sender: TObject;
      EventParams: TStringList);
  private
    procedure ImpostaCaptionTipologia;
  public
    procedure CaricaComboTipoQuota;
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation

{$R *.dfm}

procedure TWA166FQuoteIndividualiDettFM.AbilitaComponenti;
var
  TipoQuota: String;
begin
  with (WR302DM as TWA166FQuoteIndividualiDM) do
  begin
    if selTabella.State in [dsEdit,dsInsert] then
    begin
      if selTabella.FieldByName('CODTIPOQUOTA').AsString <> '' then
      begin
        dchkForzaProva.Enabled:=False;
        dchkPartTime.Enabled:=False;
        dchkSospendiQuote.Enabled:=False;

        TipoQuota:=A166FQuoteIndividualiMW.getTipoQuotaByCod(Trim(selTabella.FieldByName('CODTIPOQUOTA').AsString));

        dedtNumOre.Enabled:=TipoQuota = 'Q';
        dedtPercentuale.Enabled:=not R180In(TipoQuota,['D','N','Q','P']);
        dedtPercIndividuale.Enabled:=R180In(TipoQuota,['I','V','C','D','N']);
        dedtPercStrutturale.Enabled:=R180In(TipoQuota,['I','V','C']);
        dchkConsideraSaldo.Enabled:=TipoQuota = 'A';
        dedtPenalizzazione.Enabled:=TipoQuota = 'P';
        dedtImporto.Enabled:=not R180In(TipoQuota,['C','P']);

        if not dedtPercentuale.Enabled then
          selTabella.FieldByName('PERCENTUALE').AsFloat:=100;
        //se già disabilitato lascio cosi. altrimenti abilito in base a percentuale
        if dedtImporto.Enabled then
        begin
          dedtImporto.Enabled:=selTabella.FieldByName('PERCENTUALE').AsFloat = 100;
        end;
      end
      else
      begin
        dchkSospendiQuote.Enabled:=True;
        dchkForzaProva.Enabled:=selTabella.FieldByName('SOSPENDI_QUOTE').AsString <> 'S';
        dchkPartTime.Enabled:=dchkForzaProva.Enabled;
        dedtNumOre.Enabled:=False;
        dedtPercentuale.Enabled:=False;
        dedtPercIndividuale.Enabled:=False;
        dedtPercStrutturale.Enabled:=False;
        dchkConsideraSaldo.Enabled:=False;
        dedtPenalizzazione.Enabled:=False;
        dedtImporto.Enabled:=False;
      end;

      if not dchkSospendiQuote.Enabled then
        selTabella.FieldByName('SOSPENDI_QUOTE').AsString:='N';

      if not dchkForzaProva.Enabled then
        selTabella.FieldByName('SALTAPROVA').AsString:='N';

      if not dchkPartTime.Enabled then
        selTabella.FieldByName('SOSPENDI_PT').AsString:='N';
    end;
  end;
end;

procedure TWA166FQuoteIndividualiDettFM.ImpostaCaptionTipologia;
var
  TipoQuota: String;
begin
  with (WR302DM  as TWA166FQuoteIndividualiDM) do
  begin
    TipoQuota:=A166FQuoteIndividualiMW.getTipoQuotaByCod(selTabella.FieldByName('CODTIPOQUOTA').AsString);
    lblTipologia.Caption:=R180getCaptionTipologia(TipoQuota);
  end;
end;

procedure TWA166FQuoteIndividualiDettFM.dchkSospendiQuoteAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA166FQuoteIndividualiDettFM.dedtPercentualeAsyncChange(
  Sender: TObject; EventParams: TStringList);
var
  bImpEnab: Boolean;
begin
  inherited;
  with (WR302DM  as TWA166FQuoteIndividualiDM) do
  begin
    bImpEnab:=selTabella.FieldByName('PERCENTUALE').AsFloat = 100;

    if not bImpEnab then
      selTabella.FieldByName('IMPORTO').AsInteger:=-1;

    if bImpEnab and (selTabella.FieldByName('IMPORTO').AsInteger = -1) then
    begin
      selTabella.FieldByName('IMPORTO').AsInteger:=0;
      A166FQuoteIndividualiMW.ImpostaImportoPenalizzazione;
    end;
  end;
  AbilitaComponenti;
end;

procedure TWA166FQuoteIndividualiDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  CaricaComboTipoQuota;
end;

procedure TWA166FQuoteIndividualiDettFM.cmbTipoQuotaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
var
  TipoQuota: String;
begin
  inherited;
  with (WR302DM as TWA166FQuoteIndividualiDM) do
  begin
    selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbTipoQuota.Text;
    A166FQuoteIndividualiMW.ImpostaImportoPenalizzazione;

    TipoQuota:=A166FQuoteIndividualiMW.getTipoQuotaByCod(cmbTipoQuota.Text);
    if (TipoQuota = 'C') then
      selTabella.FieldByName('IMPORTO').AsFloat:=-1;
  end;

  ImpostaCaptionTipologia;
  AbilitaComponenti;
end;

procedure TWA166FQuoteIndividualiDettFM.DataSet2Componenti;
begin
  inherited;
  with WR302DM do
  begin
    cmbTipoQuota.Text:=selTabella.FieldByName('CODTIPOQUOTA').AsString.Trim;
    ImpostaCaptionTipologia;
  end;
end;

procedure TWA166FQuoteIndividualiDettFM.Componenti2DataSet;
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbTipoQuota.Text;
    //Questi campi sono chiave. su db sono salvati con ' '
    // Li devo impostare a ' ' perchè altrimenti verifica chiave esistente non troverebbe duplicazioni di chiave
    if selTabella.FieldByName('CODTIPOQUOTA').AsString = '' then
      selTabella.FieldByName('CODTIPOQUOTA').AsString:=' ';

    if not dedtImporto.Enabled then
      selTabella.FieldByName('IMPORTO').AsInteger:=-1;
  end;
end;

procedure TWA166FQuoteIndividualiDettFM.CaricaComboTipoQuota;
begin
  with (WR302DM as TWA166FQuoteIndividualiDM).A166FQuoteIndividualiMW do
  begin
    cmbTipoQuota.Items.Clear;
    selT765.First;
    while not selT765.Eof do
    begin
      cmbTipoQuota.AddRow(Format('%s;%s;%s',[selT765.FieldByName('CODICE').AsString,selT765.FieldByName('DESCRIZIONE').AsString,selT765.FieldByName('TIPOQUOTA').AsString]));
      selT765.Next;
    end;
  end;
end;

end.
