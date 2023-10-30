unit WA164UQuoteIncentiviDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion,  DB, A000UInterfaccia,
  IWCompEdit, medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, WA164UQuoteIncentiviDM,
  WR102UGestTabella, IWDBStdCtrls, meIWDBLabel, meIWDBEdit, meIWEdit,
  IWCompListbox, meIWDBComboBox, IWCompCheckbox, meIWDBCheckBox, C180FunzioniGenerali,
  IWHTMLControls, meIWLink, A000UCostanti, IWCompButton, meIWButton, WC013UCheckListFM;

type
  TWA164FQuoteIncentiviDettFM = class(TWR205FDettTabellaFM)
    lblDato1: TmeIWLabel;
    cmbDato1: TMedpIWMultiColumnComboBox;
    lblDato2: TmeIWLabel;
    cmbDato2: TMedpIWMultiColumnComboBox;
    lblDato3: TmeIWLabel;
    cmbDato3: TMedpIWMultiColumnComboBox;
    lblDescDato1: TmeIWLabel;
    lblDescDato2: TmeIWLabel;
    lblDescDato3: TmeIWLabel;
    cmbCodTipoQuota: TMedpIWMultiColumnComboBox;
    dlblTipoQuota: TmeIWDBLabel;
    lblAssenza: TmeIWLabel;
    cmbAssenza: TMedpIWMultiColumnComboBox;
    dlblDescAssenza: TmeIWDBLabel;
    lblImporto: TmeIWLabel;
    dedtImporto: TmeIWDBEdit;
    dEdtNumOre: TmeIWDBEdit;
    lblNumOre: TmeIWLabel;
    dEdtPenalizzazione: TmeIWDBEdit;
    lblPenalizzazione: TmeIWLabel;
    dedtValutStrutturale: TmeIWDBEdit;
    lblValutStrutturale: TmeIWLabel;
    lblImpNetto: TmeIWLabel;
    dlblImpNetto: TmeIWDBLabel;
    dedtPercIndividuale: TmeIWDBEdit;
    lblPercIndividuale: TmeIWLabel;
    dedtPercStrutturale: TmeIWDBEdit;
    lblPercStrutturale: TmeIWLabel;
    lblTipoStampa: TmeIWLabel;
    cmbTipoStampa: TMedpIWMultiColumnComboBox;
    dedtPercentuale: TmeIWDBEdit;
    lblPercentuale: TmeIWLabel;
    dChkSaldo: TmeIWDBCheckBox;
    dchkPartTime: TmeIWDBCheckBox;
    lblTipologia: TmeIWLabel;
    lnkCodTipoQuota: TmeIWLink;
    dchkConsideraProva: TmeIWDBCheckBox;
    lblDurataSospensione: TmeIWLabel;
    dedtDurataSospensione: TmeIWDBEdit;
    lblTipiRapportoSospensione: TmeIWLabel;
    dedtTipiRapportoSospensione: TmeIWDBEdit;
    btnTipiRapportoSospensione: TmeIWButton;
    lblEsclusioneValori: TmeIWLabel;
    dedtEsclusioneValori: TmeIWDBEdit;
    btnEsclusioneValori: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbDato1AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbDato2AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbDato3AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbCodTipoQuotaAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbAssenzaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure ricalcoloImportoAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtPercentualeAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dedtImportoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure lnkCodTipoQuotaClick(Sender: TObject);
    procedure btnTipiRapportoSospensioneClick(Sender: TObject);
    procedure btnEsclusioneValoriClick(Sender: TObject);
  private
    procedure ImpostaCaptionTipologia;
    procedure TipiRapportoSospensioneResult(Sender: TObject; Result: Boolean);
    procedure EsclusioneValoriResult(Sender: TObject; Result: Boolean);
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure CaricaComboTipoQuota;
  end;

implementation

{$R *.dfm}

procedure TWA164FQuoteIncentiviDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    lblDato1.Caption:=WR302DM.selTabella.FieldByName('DATO1').DisplayLabel
  else
    lblDato1.Caption:='Dato 1 non definito';
  lblDescDato1.Caption:='';

  if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    lblDato2.Caption:=WR302DM.selTabella.FieldByName('DATO2').DisplayLabel
  else
    lblDato2.Caption:='Dato 2 non definito';
  lblDescDato2.Caption:='';

  if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    lblDato3.Caption:=WR302DM.selTabella.FieldByName('DATO3').DisplayLabel
  else
    lblDato3.Caption:='Dato 3 non definito';
  lblDescDato3.Caption:='';

  //combo con medpAutoresetItems=False
  cmbTipoStampa.AddRow('0 - Scheda standard');
  cmbTipoStampa.AddRow('1 - Scheda posizionati sanitari');
  cmbTipoStampa.AddRow('2 - Scheda posizionati amm./tecnici');

  if Parametri.CampiRiferimento.C7_EscludeIncentivo <> '' then
    lblEsclusioneValori.Caption:='Escludi se ' + R180Capitalize(Parametri.CampiRiferimento.C7_EscludeIncentivo)
  else
  begin
    lblEsclusioneValori.Caption:='Dato esclusione non definito';
    lblEsclusioneValori.Visible:=False;
    dedtEsclusioneValori.Visible:=False;
    btnEsclusioneValori.Visible:=False;
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.lnkCodTipoQuotaClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='CODICE='+ cmbCodTipoQuota.Text + ParamDelimiter + 'DECORRENZA=';
  if WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime <> DATE_NULL then
    Params:=Params + DateToStr(WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime)
  else
    Params:=Params  + DateToStr(Parametri.DataLavoro);

   (Self.Parent as TWR102FGestTabella).AccediForm(199,Params);
end;

procedure TWA164FQuoteIncentiviDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
  Assenza, CodTipoQuota,TipoQuota: String;
begin
  inherited;
  with (WR302DM as TWA164FQuoteIncentiviDM) do
  begin
    bEdit:=SelTabella.state in [dsEdit, dsInsert];

    if bEdit then
    begin
      if Parametri.CampiRiferimento.C7_Dato1 = '' then
        cmbDato1.Enabled:=False;

      if Parametri.CampiRiferimento.C7_Dato2 = '' then
        cmbDato2.Enabled:=False;

      if Parametri.CampiRiferimento.C7_Dato3 = '' then
        cmbDato3.Enabled:=False;

      dedtNumOre.Enabled:=False;
      dedtPercIndividuale.Enabled:=False;
      dedtPercStrutturale.Enabled:=False;
      dedtValutStrutturale.Enabled:=False;
      lblImpNetto.Enabled:=False;
      dlblImpNetto.Enabled:=False;
      dedtPenalizzazione.Enabled:=False;
      cmbTipoStampa.Enabled:=False;

      assenza:=Trim(selTabella.FieldByName('CAUSALE').AsString);
      dedtPercentuale.Enabled:=(assenza <> '');
      dchkSaldo.Enabled:=dedtPercentuale.Enabled;
      dchkPartTime.Enabled:=dedtPercentuale.Enabled;
      codTipoQuota:=Trim(selTabella.FieldByName('CODTIPOQUOTA').AsString);
      if codTipoQuota <> '' then
      begin
        TipoQuota:=A164FQuoteIncentiviMW.getTipoQuotaByCod(codTipoQuota);

        dedtNumOre.Enabled:=(TipoQuota = 'Q') or A164FQuoteIncentiviMW.getRifSaldoAnnoCorrByCod(codTipoQuota);
        dedtPercIndividuale.Enabled:=R180In(TipoQuota,['I','V','C']);
        dedtPercStrutturale.Enabled:=dedtPercIndividuale.Enabled;
        dedtValutStrutturale.Enabled:=dedtPercIndividuale.Enabled;
        dedtPenalizzazione.Enabled:=TipoQuota = 'P';
        dedtImporto.Enabled:=(TipoQuota <> 'P') and (selTabella.FieldByName('PERCENTUALE').AsInteger = 100);
        dlblImpNetto.Enabled:=R180In(TipoQuota,['I','V','C','Q']);
        cmbTipoStampa.Enabled:=TipoQuota = 'Q';
      end;

      lblImporto.Enabled:=dedtImporto.Enabled;
      lblImpNetto.Enabled:=dlblImpNetto.Enabled;
    end;

    //In modifica o Storicizzazione la chiave non è modificabile. non fatto
    //sui campi del dataset perchè i componenti non sono data-aware
    if (SelTabella.State = dsEdit) or
     (Self.Parent as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso then
    begin
      cmbDato1.Enabled:=False;
      cmbDato2.Enabled:=False;
      cmbDato3.Enabled:=False;
      cmbCodTipoQuota.Enabled:=False;
      cmbAssenza.Enabled:=False;
    end;
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.DataSet2Componenti;
var
  idx: Integer;
begin
  with (WR302DM as TWA164FQuoteIncentiviDM) do
  begin
    //Trim dei campi perchè se vuoti salvati su db con ' '.
    cmbDato1.Text:=selTabella.FieldByName('DATO1').AsString.Trim;
    cmbDato2.Text:=selTabella.FieldByName('DATO2').AsString.Trim;
    cmbDato3.Text:=selTabella.FieldByName('DATO3').AsString.Trim;

    if Parametri.CampiRiferimento.C7_Dato1 <> '' then
      lblDescDato1.Caption:=selTabella.FieldByName('D_DATO1').AsString;

    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
      lblDescDato2.Caption:=selTabella.FieldByName('D_DATO2').AsString;

    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
      lblDescDato3.Caption:=selTabella.FieldByName('D_DATO3').AsString;

    cmbCodTipoQuota.Text:=selTabella.FieldByName('CODTIPOQUOTA').AsString.Trim;
    cmbAssenza.Text:=selTabella.FieldByName('CAUSALE').AsString.Trim;

    idx:=StrToIntDef(selTabella.FieldByName('TIPO_STAMPAQUANT').AsString,0);
    cmbTipoStampa.ItemIndex:=idx;

    ImpostaCaptionTipologia;
    lblImporto.Caption:=A164FQuoteIncentiviMW.getCaptionImporto;
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.dedtImportoAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  with (WR302DM  as TWA164FQuoteIncentiviDM) do
    selTabella.FieldByName('IMPORTO').AsFloat:=R180Arrotonda(selTabella.FieldByName('IMPORTO').AsFloat,0.00001,'P');
  RicalcoloImportoAsyncChange(Sender,EventParams);
end;

procedure TWA164FQuoteIncentiviDettFM.dedtPercentualeAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;

  with (WR302DM  as TWA164FQuoteIncentiviDM) do
  begin
  if not dedtImporto.Enabled then
    selTabella.FieldByName('IMPORTO').AsInteger:=-1;
  if dedtImporto.Enabled and (selTabella.FieldByName('IMPORTO').AsInteger = -1) then
    selTabella.FieldByName('IMPORTO').AsInteger:=0;
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.ImpostaCaptionTipologia;
var
  TipoQuota: String;
begin
  with (WR302DM  as TWA164FQuoteIncentiviDM) do
  begin
    TipoQuota:=A164FQuoteIncentiviMW.getTipoQuotaByCod(selTabella.FieldByName('CODTIPOQUOTA').AsString);
    lblTipologia.Caption:=R180getCaptionTipologia(TipoQuota);
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.ricalcoloImportoAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  dlblImpNetto.Invalidate
end;

procedure TWA164FQuoteIncentiviDettFM.Componenti2DataSet;
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
    selTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
    selTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;

    selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbCodTipoQuota.Text;
    selTabella.FieldByName('CAUSALE').AsString:=cmbAssenza.Text;
    selTabella.FieldByName('TIPO_STAMPAQUANT').AsInteger:=cmbTipoStampa.ItemIndex;

    //Questi campi sono chiave. su db sono salvati con ' '
   // Li devo impostare a ' ' perchè altrimenti verifica chiave esistente non troverebbe duplicazioni di chiave
   if selTabella.FieldByName('DATO1').AsString = '' then
      selTabella.FieldByName('DATO1').AsString:=' ';
    if selTabella.FieldByName('DATO2').AsString = '' then
      selTabella.FieldByName('DATO2').AsString:=' ';
    if selTabella.FieldByName('DATO3').AsString = '' then
      selTabella.FieldByName('DATO3').AsString:=' ';
    if selTabella.FieldByName('CODTIPOQUOTA').AsString = '' then
      selTabella.FieldByName('CODTIPOQUOTA').AsString:=' ';
    if selTabella.FieldByName('CAUSALE').AsString = '' then
      selTabella.FieldByName('CAUSALE').AsString:=' ';
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.CaricaMultiColumnCombobox;
begin
  with (WR302DM as TWA164FQuoteIncentiviDM).A164FQuoteIncentiviMW do
  begin
    if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    begin
      cmbDato1.Items.Clear;
      selDato1.first;
      while not selDato1.Eof do
      begin
        cmbDato1.AddRow(Format('%s;%s',[selDato1.FieldByName('CODICE').AsString,selDato1.FieldByName('DESCRIZIONE').AsString]));
        selDato1.Next;
      end;
    end;

    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    begin
      cmbDato2.Items.Clear;
      selDato2.first;
      while not selDato2.Eof do
      begin
        cmbDato2.AddRow(Format('%s;%s',[selDato2.FieldByName('CODICE').AsString,selDato2.FieldByName('DESCRIZIONE').AsString]));
        selDato2.Next;
      end;
    end;

    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    begin
      cmbDato3.Items.Clear;
      selDato3.first;
      while not selDato3.Eof do
      begin
        cmbDato3.AddRow(Format('%s;%s',[selDato3.FieldByName('CODICE').AsString,selDato3.FieldByName('DESCRIZIONE').AsString]));
        selDato3.Next;
      end;
    end;

    CaricaComboTipoQuota;

    cmbAssenza.Items.Clear;
    selT265.First;
    while not selT265.Eof do
    begin
      cmbAssenza.AddRow(Format('%s;%s',[selT265.FieldByName('CODICE').AsString,selT265.FieldByName('DESCRIZIONE').AsString]));
      selT265.Next;
    end;
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.CaricaComboTipoQuota;
begin
  with (WR302DM as TWA164FQuoteIncentiviDM).A164FQuoteIncentiviMW do
  begin
    cmbCodTipoQuota.Items.Clear;
    selT765.First;
    while not selT765.Eof do
    begin
      cmbCodTipoQuota.AddRow(Format('%s;%s',[selT765.FieldByName('CODICE').AsString,selT765.FieldByName('DESCRIZIONE').AsString]));
      selT765.Next;
    end;
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.cmbAssenzaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('CAUSALE').AsString:=cmbAssenza.Text;
  if (cmbAssenza.Text <> '') then
  begin
    WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:='';
    cmbCodTipoQuota.Text:='';
  end;

  AbilitaComponenti;
end;

procedure TWA164FQuoteIncentiviDettFM.cmbCodTipoQuotaAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbCodTipoQuota.Text;
  if (cmbCodTipoQuota.Text <> '') then
  begin
    WR302DM.selTabella.FieldByName('PERCENTUALE').AsInteger:=100;
    WR302DM.selTabella.FieldByName('PENALIZZAZIONE').AsString:='';
    WR302DM.selTabella.FieldByName('CAUSALE').AsString:='';
    cmbAssenza.Text:='';
  end;
  ImpostaCaptionTipologia;

  AbilitaComponenti;
end;

procedure TWA164FQuoteIncentiviDettFM.cmbDato1AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  WR302DM.selTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
  lblDescDato1.Caption:=WR302DM.selTabella.FieldByName('D_DATO1').AsString
end;

procedure TWA164FQuoteIncentiviDettFM.cmbDato2AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
  lblDescDato2.Caption:=WR302DM.selTabella.FieldByName('D_DATO2').AsString
end;

procedure TWA164FQuoteIncentiviDettFM.cmbDato3AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  WR302DM.selTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;
  lblDescDato3.Caption:=WR302DM.selTabella.FieldByName('D_DATO3').AsString
end;

procedure TWA164FQuoteIncentiviDettFM.btnTipiRapportoSospensioneClick(Sender: TObject);
var
  LstSel: TStringList;
  ElencoValoriChecklist: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
begin

  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  LstSel:=TStringList.Create;
  try
    ElencoValoriChecklist:=(WR302DM as TWA164FQuoteIncentiviDM).A164FQuoteIncentiviMW.ListTipiRapporto;

    LstSel.CommaText:=dedtTipiRapportoSospensione.Text;
    WC013.CaricaLista(ElencoValoriChecklist.lstDescrizione, ElencoValoriChecklist.lstCodice);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=TipiRapportoSospensioneResult;
    WC013.Visualizza(0,0,'<WC013> Tipi rapporto');
  finally
    FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.TipiRapportoSospensioneResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      WR302DM.SelTabella.FieldByName('TIPIRAPPORTO_SOSPENSIONE').AsString:=lstTmp.CommaText;
    finally
      FreeAndNil(lstTmp);
    end;
    AbilitaComponenti;
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.btnEsclusioneValoriClick(Sender: TObject);
var
  LstSel: TStringList;
  ElencoValoriChecklist: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
begin

  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  LstSel:=TStringList.Create;
  try
    ElencoValoriChecklist:=(WR302DM as TWA164FQuoteIncentiviDM).A164FQuoteIncentiviMW.ListEsclusioneValori;

    LstSel.CommaText:=dedtEsclusioneValori.Text;
    WC013.CaricaLista(ElencoValoriChecklist.lstDescrizione, ElencoValoriChecklist.lstCodice);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=EsclusioneValoriResult;
    WC013.Visualizza(0,0,'<WC013> ' + R180Capitalize(Parametri.CampiRiferimento.C7_EscludeIncentivo));
  finally
    FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
  end;
end;

procedure TWA164FQuoteIncentiviDettFM.EsclusioneValoriResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      WR302DM.SelTabella.FieldByName('ESCLUSIONE_VALORI').AsString:=lstTmp.CommaText;
    finally
      FreeAndNil(lstTmp);
    end;
    AbilitaComponenti;
  end;
end;

end.
