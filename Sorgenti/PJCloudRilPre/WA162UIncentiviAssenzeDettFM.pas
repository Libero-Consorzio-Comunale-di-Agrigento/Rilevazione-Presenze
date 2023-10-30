unit WA162UIncentiviAssenzeDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, medpIWMessageDlg,
  medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, WA162UIncentiviAssenzeDM, A000UInterfaccia,
  IWDBStdCtrls, meIWDBLabel, WR102UGestTabella, DB, StrUtils, IWCompExtCtrls,
  IWDBExtCtrls, meIWDBRadioGroup, meIWDBEdit, IWCompButton, meIWButton,
  A000UCostanti, WC013UCheckListFM, IWCompCheckbox, meIWDBCheckBox,
  IWHTMLControls, meIWLink, Vcl.Menus, WC020UInputDataOreFM, IWApplication;

type
  TWA162FIncentiviAssenzeDettFM = class(TWR205FDettTabellaFM)
    lblDato1: TmeIWLabel;
    cmbDato1: TMedpIWMultiColumnComboBox;
    lblDescDato1: TmeIWLabel;
    lblDato2: TmeIWLabel;
    cmbDato2: TMedpIWMultiColumnComboBox;
    lblDescDato2: TmeIWLabel;
    lblDato3: TmeIWLabel;
    cmbDato3: TMedpIWMultiColumnComboBox;
    lblDescDato3: TmeIWLabel;
    cmbTipoAccorpCausali: TMedpIWMultiColumnComboBox;
    dlblDescTipoAccorp: TmeIWDBLabel;
    cmbCodiciAccorpCausali: TMedpIWMultiColumnComboBox;
    dlblDescCodAccorp: TmeIWDBLabel;
    lblCausale: TmeIWLabel;
    cmbCausale: TMedpIWMultiColumnComboBox;
    dlblDescCausale: TmeIWDBLabel;
    cmbTipoAbbattimento: TMedpIWMultiColumnComboBox;
    dlblDescTipoAbbatt: TmeIWDBLabel;
    lblRisparmio: TmeIWLabel;
    drdgGestioneFranchigia: TmeIWDBRadioGroup;
    lblGestioneFranchigia: TmeIWLabel;
    lblFranchigia: TmeIWLabel;
    dedtFranchigia: TmeIWDBEdit;
    dedtAssenzeAgg: TmeIWDBEdit;
    lblAssenzeAgg: TmeIWLabel;
    btnAssenzeAgg: TmeIWButton;
    dchkPropFranchigia: TmeIWDBCheckBox;
    dchkFruitoOre: TmeIWDBCheckBox;
    dchkAbbGGInt: TmeIWDBCheckBox;
    dchkSoloGGInt: TmeIWDBCheckBox;
    lblPercAbbFranc: TmeIWLabel;
    dedtPercAbbFranc: TmeIWDBEdit;
    lblPercAbb: TmeIWLabel;
    dedtPercAbb: TmeIWDBEdit;
    lnkTipoAbbattimento: TmeIWLink;
    lnkTipoAccorp: TmeIWLink;
    lnkCodAccorp: TmeIWLink;
    lblCodTipoQuota: TmeIWLabel;
    cmbCodTipoQuota: TMedpIWMultiColumnComboBox;
    lblDescTipoQuota: TmeIWLabel;
    pmnCodTipoQuota: TPopupMenu;
    CambiaCodTipoQuota1: TMenuItem;
    procedure cmbDato1AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbDato2AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbDato3AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbCodTipoQuotaAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbTipoAccorpCausaliAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodiciAccorpCausaliAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCausaleAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure cmbTipoAbbattimentoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure btnAssenzeAggClick(Sender: TObject);
    procedure drdgGestioneFranchigiaClick(Sender: TObject);
    procedure dchkAbbGGIntAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkSoloGGIntAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure dedtFranchigiaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure lnkTipoAbbattimentoClick(Sender: TObject);
    procedure lnkTipoAccorpClick(Sender: TObject);
    procedure CambiaCodTipoQuota1Click(Sender: TObject);
  private
    procedure ImpostaCodiciAccorpCausali;
    procedure ImpostaLblRisparmio;
    procedure AssenzeAggiuntiveResult(Sender: TObject; Result: Boolean);
    procedure ResultInputCambiaCodTipoQuota(Sender:TObject; Result:Boolean; Valore:String);
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure CaricaComboCodTipoQuota;
    procedure CaricaComboTipoAccorpCausali;
    procedure CaricaComboCodiciAccorpCausali;
    procedure CaricaComboTipoAbbattimento;
  end;

implementation

uses WA162UIncentiviAssenze;

{$R *.dfm}

{ TWA162FIncentiviAssenzeDettFM }

procedure TWA162FIncentiviAssenzeDettFM.IWFrameRegionCreate(Sender: TObject);
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

  lblDescTipoQuota.Caption:='';
end;

procedure TWA162FIncentiviAssenzeDettFM.lnkTipoAbbattimentoClick(
  Sender: TObject);
var
  Params: string;
begin
  inherited;
  Params:='CODICE='+ cmbTipoAbbattimento.Text;
  (Self.Parent as TWR102FGestTabella).AccediForm(198,Params);
end;

procedure TWA162FIncentiviAssenzeDettFM.lnkTipoAccorpClick(Sender: TObject);
var
  Params: String;
begin
  inherited;
  Params:='CODICE='+ cmbTipoAccorpCausali.Text;
  (Self.Parent as TWR102FGestTabella).AccediForm(196,Params);
end;

procedure TWA162FIncentiviAssenzeDettFM.AbilitaComponenti;
var
  bAbbGGInt,
  bSoloGGInt: Boolean;
begin
  inherited;
  with (Self.Parent as TWR102FGestTabella),(WR302DM as TWA162FIncentiviAssenzeDM) do
  begin
    actCopiaSu.Visible:=(SelTabella.State = dsBrowse) and (SelTabella.FieldByName('CODTIPOQUOTA').AsString <> '*');
    actCopiaSu.Enabled:=(Self.Parent as TWR102FGestTabella).actCopiaSu.Visible;
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
  end;
  with (WR302DM as TWA162FIncentiviAssenzeDM) do
  begin
    if (SelTabella.State in [dsEdit,dsInsert]) then
    begin
      cmbTipoAccorpCausali.Enabled:=Trim(selTabella.FieldByName('CAUSALE').AsString) = '';
      cmbCodiciAccorpCausali.Enabled:=cmbTipoAccorpCausali.Enabled;
      cmbTipoAbbattimento.Enabled:=cmbTipoAccorpCausali.Enabled;
      ImpostaLblRisparmio;
      drdgGestioneFranchigia.Enabled:=cmbTipoAccorpCausali.Enabled;
      dedtFranchigia.Enabled:=drdgGestioneFranchigia.Enabled;

      dedtAssenzeAgg.ReadOnly:=True; //sempre readonly(input tramite WC13)
      dedtAssenzeAgg.Enabled:=(selTabella.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
      btnAssenzeAgg.Enabled:=dedtAssenzeAgg.Enabled;
      dchkPropFranchigia.Enabled:=dedtAssenzeAgg.Enabled;

      //non usare checked del componente data-aware perchè impostato solo se renderizzato
      //se faccio modifica da pannello browse, la proprietà non è ancora aggiornata
      bAbbGGInt:=selTabella.FieldByName('FORZA_ABB_GGINT').AsString = 'S';
      bSoloGGInt:=selTabella.FieldByName('CONTA_SOLO_GGINT').AsString = 'S';

      dchkFruitoOre.Enabled:=(not bAbbGGint) and (not bSoloGGInt);
      dchkAbbGGInt.Enabled:=not bSoloGGInt;
      if not dchkAbbGGInt.Enabled then
        selTabella.FieldByName('FORZA_ABB_GGINT').AsString:='N';
      dchkSoloGGInt.Enabled:=not bAbbGGInt;
      if not dchkSoloGGInt.Enabled then
        selTabella.FieldByName('CONTA_SOLO_GGINT').AsString:='N';

      dedtPercAbbFranc.Enabled:=(Trim(SelTabella.FieldByName('CAUSALE').AsString) <> '') or
                                (SelTabella.FieldByName('FRANCHIGIA_ASSENZE').AsFloat <> 0);
      dedtPercAbb.Enabled:=(Trim(SelTabella.FieldByName('CAUSALE').AsString) <> '');
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
      cmbTipoAccorpCausali.Enabled:=False;
      cmbCodiciAccorpCausali.Enabled:=False;
      cmbCausale.Enabled:=False;
    end;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW do
  begin
    if Parametri.CampiRiferimento.C7_Dato1 <> '' then
    begin
      cmbDato1.Items.Clear;
      selDato1.First;
      while not selDato1.Eof do
      begin
        cmbDato1.AddRow(Format('%s;%s',[selDato1.FieldByName('CODICE').AsString,selDato1.FieldByName('DESCRIZIONE').AsString]));
        selDato1.Next;
      end;
    end;

    if Parametri.CampiRiferimento.C7_Dato2 <> '' then
    begin
      cmbDato2.Items.Clear;
      selDato2.First;
      while not selDato2.Eof do
      begin
        cmbDato2.AddRow(Format('%s;%s',[selDato2.FieldByName('CODICE').AsString,selDato2.FieldByName('DESCRIZIONE').AsString]));
        selDato2.Next;
      end;
    end;

    if Parametri.CampiRiferimento.C7_Dato3 <> '' then
    begin
      cmbDato3.Items.Clear;
      selDato3.First;
      while not selDato3.Eof do
      begin
        cmbDato3.AddRow(Format('%s;%s',[selDato3.FieldByName('CODICE').AsString,selDato3.FieldByName('DESCRIZIONE').AsString]));
        selDato3.Next;
      end;
    end;
    CaricaComboCodTipoQuota;

    CaricaComboTipoAccorpCausali;
    CaricaComboCodiciAccorpCausali;

    cmbCausale.Items.Clear;
    selT265.First;
    while not selT265.Eof do
    begin
      cmbCausale.AddRow(Format('%s;%s',[selT265.FieldByName('CODICE').AsString,selT265.FieldByName('DESCRIZIONE').AsString]));
      selT265.Next;
    end;

    CaricaComboTipoAbbattimento;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.CaricaComboCodTipoQuota;
begin
  with (WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW do
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

procedure TWA162FIncentiviAssenzeDettFM.CaricaComboTipoAccorpCausali;
begin
  with (WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW do
  begin
    cmbTipoAccorpCausali.Items.Clear;
    selT255.First;
    while not selT255.Eof do
    begin
      cmbTipoAccorpCausali.AddRow(Format('%s;%s',[selT255.FieldByName('COD_TIPOACCORPCAUSALI').AsString,selT255.FieldByName('DESCRIZIONE').AsString]));
      selT255.Next;
    end;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.CambiaCodTipoQuota1Click(Sender: TObject);
var WC020FInputBoxFM: TWC020FInputDataOreFM;
begin
  WC020FInputBoxFM:=TWC020FInputDataOreFM.Create(Self.Owner);
  WC020FInputBoxFM.ImpostaCampiText('Indicare il nuovo codice quota:','');
  WC020FInputBoxFM.ResultEvent:=ResultInputCambiaCodTipoQuota;
  WC020FInputBoxFM.Visualizza('Nuovo codice quota');
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[(Self.Owner as TWA162FIncentiviAssenze).btnCambioData.HTMLName]));
end;

procedure TWA162FIncentiviAssenzeDettFM.ResultInputCambiaCodTipoQuota(Sender:TObject; Result:Boolean; Valore:String);
begin
  if Result then
    try
      (WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW.CambiaCodTipoQuota(Valore);
      (Self.Parent as TWR102FGestTabella).actAggiornaExecute(nil);
    except
      on E: Exception do
      begin
        MsgBox.WebMessageDlg(E.Message,mtError,[mbOk],nil,'');
        Exit;
      end;
    end;
end;

procedure TWA162FIncentiviAssenzeDettFM.CaricaComboCodiciAccorpCausali;
begin
  with (WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW do
  begin
    ImpostaTipoSelT256(WR302DM.selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
    cmbCodiciAccorpCausali.Items.Clear;
    selT256.First;
    while not selT256.Eof do
    begin
      cmbCodiciAccorpCausali.AddRow(Format('%s;%s',[selT256.FieldByName('COD_CODICIACCORPCAUSALI').AsString,selT256.FieldByName('DESCRIZIONE').AsString]));
      selT256.Next;
    end;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.CaricaComboTipoAbbattimento;
begin
  with (WR302DM as TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW do
  begin
    cmbTipoAbbattimento.Items.Clear;
    selT766.First;
    while not selT766.Eof do
    begin
      cmbTipoAbbattimento.AddRow(Format('%s;%s;%s',[selT766.FieldByName('CODICE').AsString,selT766.FieldByName('DESCRIZIONE').AsString,selT766.FieldByName('RISPARMIO_BILANCIO').AsString]));
      selT766.Next;
    end;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWA162FIncentiviAssenzeDM) do
  begin
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
    lblDescTipoQuota.Text:=selTabella.FieldByName('D_TIPOQUOTA').AsString.Trim;
    cmbTipoAccorpCausali.Text:=selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString.Trim;
    cmbCodiciAccorpCausali.Text:=selTabella.FieldByName('COD_CODICIACCORPCAUSALI').AsString.Trim;
    cmbCausale.Text:=selTabella.FieldByName('CAUSALE').AsString.Trim;
    cmbTipoAbbattimento.Text:=selTabella.FieldByName('TIPO_ABBATTIMENTO').AsString.Trim;
    ImpostaLblRisparmio;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.dchkAbbGGIntAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if dchkAbbGGInt.Checked then
  begin
    WR302DM.selTabella.FieldByName('CONTA_FRUITO_ORE').AsString:='S';
    WR302DM.selTabella.FieldByName('CONTA_SOLO_GGINT').AsString:='N';
  end;
  AbilitaComponenti;
end;

procedure TWA162FIncentiviAssenzeDettFM.dchkSoloGGIntAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if dchkSoloGGInt.Checked then
  begin
    WR302DM.selTabella.FieldByName('CONTA_FRUITO_ORE').AsString:='S';
    WR302DM.selTabella.FieldByName('FORZA_ABB_GGINT').AsString:='N';
  end;
  AbilitaComponenti;
end;

procedure TWA162FIncentiviAssenzeDettFM.dedtFranchigiaAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with WR302DM.selTabella do
  begin
    if FieldByName('FRANCHIGIA_ASSENZE').AsFloat = 0 then
    begin
      FieldByName('PERC_ABB_FRANCHIGIA').AsFloat:=100;
      FieldByName('ASSENZE_AGGIUNTIVE').AsString:='';
    end
    else
    begin
      if FieldByName('GESTIONE_FRANCHIGIA').AsString = 'R' then
      begin
        FieldByName('TIPO_ABBATTIMENTO').AsString:='';
        cmbTipoAbbattimento.Text:='';
      end;
    end;
  end;
  AbilitaComponenti;
end;

procedure TWA162FIncentiviAssenzeDettFM.drdgGestioneFranchigiaClick(
  Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA162FIncentiviAssenzeDettFM.Componenti2DataSet;
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
    selTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
    selTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;
    selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbCodTipoQuota.Text;
    selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=cmbTipoAccorpCausali.Text;
    selTabella.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=cmbCodiciAccorpCausali.Text;
    selTabella.FieldByName('CAUSALE').AsString:=cmbCausale.Text;
    selTabella.FieldByName('TIPO_ABBATTIMENTO').AsString:=cmbTipoAbbattimento.Text;

    //Questi campi sono chiave. su db sono salvati con ' '
    // Li devo impostare a ' ' perchè altrimenti verifica chiave esistente non troverebbe duplicazioni di chiave
    if selTabella.FieldByName('DATO1').AsString = '' then
      selTabella.FieldByName('DATO1').AsString:=' ';
    if selTabella.FieldByName('DATO2').AsString = '' then
      selTabella.FieldByName('DATO2').AsString:=' ';
    if selTabella.FieldByName('DATO3').AsString = '' then
      selTabella.FieldByName('DATO3').AsString:=' ';
    if selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString = '' then
      selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=' ';
    if selTabella.FieldByName('COD_CODICIACCORPCAUSALI').AsString = '' then
      selTabella.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=' ';
    if selTabella.FieldByName('CAUSALE').AsString = '' then
      selTabella.FieldByName('CAUSALE').AsString:=' ';
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.btnAssenzeAggClick(Sender: TObject);
var
  LstSel: TStringList;
  ElencoValoriChecklist: TElencoValoriChecklist;
  WC013: TWC013FCheckListFM;
begin

  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  LstSel:=TStringList.Create;
  try
    ElencoValoriChecklist:=(WR302DM AS TWA162FIncentiviAssenzeDM).A162FIncentiviAssenzeMW.ListAssenzeAggiuntive(cmbTipoAccorpCausali.Text,cmbCodiciAccorpCausali.Text);

    LstSel.CommaText:=dedtAssenzeAgg.Text;
    WC013.CaricaLista(ElencoValoriChecklist.lstDescrizione, ElencoValoriChecklist.lstCodice);

    WC013.ImpostaValoriSelezionati(LstSel);
    WC013.ResultEvent:=AssenzeAggiuntiveResult;
    WC013.Visualizza(0,0,'<WC013> Assenze aggiuntive');
  finally
    FreeAndNil(ElencoValoriChecklist);
    FreeAndNil(LstSel);
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.AssenzeAggiuntiveResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      WR302DM.SelTabella.FieldByName('ASSENZE_AGGIUNTIVE').AsString:=lstTmp.CommaText;
    finally
      FreeAndNil(lstTmp);
    end;
    AbilitaComponenti;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbCausaleAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA162FIncentiviAssenzeDM) do
  begin
    selTabella.FieldByName('CAUSALE').AsString:=cmbCausale.Text;
    if Trim(selTabella.FieldByName('CAUSALE').AsString) = '' then
    begin
      selTabella.FieldByName('PERC_ABB_FRANCHIGIA').AsFloat:=100;
      selTabella.FieldByName('PERC_ABBATTIMENTO').AsFloat:=100;
    end;

    //dlblDescCausale legata a campo di lookup che si aggiorna al variare di CAUSALE
    if Trim(selTabella.FieldByName('CAUSALE').AsString) <> '' then
    begin
      selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString:='';
      cmbTipoAccorpCausali.Text:='';
      selTabella.FieldByName('COD_CODICIACCORPCAUSALI').AsString:='';
      cmbCodiciAccorpCausali.Text:='';
      selTabella.FieldByName('TIPO_ABBATTIMENTO').AsString:='';
      cmbTipoAbbattimento.Text:='';
      selTabella.FieldByName('FRANCHIGIA_ASSENZE').AsInteger:=0;
    end;
    AbilitaComponenti;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbCodiciAccorpCausaliAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  ImpostaCodiciAccorpCausali;
end;

procedure TWA162FIncentiviAssenzeDettFM.ImpostaCodiciAccorpCausali;
begin
  with WR302DM do
  begin
    selTabella.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=cmbCodiciAccorpCausali.Text;
    //dlblDescCodAccorp legata a campo di lookup che si aggiorna al variare di COD_CODICIACCORPCAUSALI
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbDato1AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
  lblDescDato1.Caption:=WR302DM.selTabella.FieldByName('D_DATO1').AsString
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbDato2AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
  lblDescDato2.Caption:=WR302DM.selTabella.FieldByName('D_DATO2').AsString
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbDato3AsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;
  lblDescDato3.Caption:=WR302DM.selTabella.FieldByName('D_DATO3').AsString
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbCodTipoQuotaAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('CODTIPOQUOTA').AsString:=cmbCodTipoQuota.Text;
  lblDescTipoQuota.Caption:=WR302DM.selTabella.FieldByName('D_TIPOQUOTA').AsString
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbTipoAbbattimentoAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA162FIncentiviAssenzeDM) do
  begin
    selTabella.FieldByName('TIPO_ABBATTIMENTO').AsString:=cmbTipoAbbattimento.Text;
    //dlblDescTipoAbbatt legata a campo di lookup che si aggiorna al variare di TIPO_ABBATTIMENTO
    AbilitaComponenti;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.cmbTipoAccorpCausaliAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA162FIncentiviAssenzeDM) do
  begin
    selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=cmbTipoAccorpCausali.Text;
    //dlblDescTipoAccorp legata a campo di lookup che si aggiorna al variare di COD_TIPOACCORPCAUSALI
    A162FIncentiviAssenzeMW.ImpostaTipoSelT256(WR302DM.selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString);
    cmbCodiciAccorpCausali.Text:='';
    ImpostaCodiciAccorpCausali;
    CaricaComboCodiciAccorpCausali;
  end;
end;

procedure TWA162FIncentiviAssenzeDettFM.ImpostaLblRisparmio;
begin
  with WR302DM.selTabella do
  begin
    lblRisparmio.Visible:=Trim(FieldByName('TIPO_ABBATTIMENTO').AsString) <> '';
    if lblRisparmio.Visible then
      lblRisparmio.Caption:='Risparmio bilancio: ' + IfThen(FieldByName('D_RISPARMIO').AsString = 'S','Si','No');
  end;
end;

end.
