unit WA009UProfAsseAnnDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup,
  IWCompCheckbox, meIWDBCheckBox, IWCompButton,
  meIWButton, WA021UAssestamentoAnnuoFM, A000UInterfaccia, meIWLabel,
  IWCompListbox, meIWDBComboBox, IWAdvRadioGroup, meTIWAdvRadioGroup,
  IWDBGrids, medpIWDBGrid,
  Db, Oracle, StrUtils, Math, OracleData, IWCompExtCtrls,
  IWCompJQueryWidget, meIWImageFile, IWHTMLControls, meIWLink,
  medpIWMultiColumnComboBox;

type
  TWA009FProfAsseAnnDettFM = class(TWR205FDettTabellaFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    lblUnitaDiMisura: TmeIWLabel;
    lblRapportiDiLavoroUnificati: TmeIWLabel;
    lblPercentualeRetribuzione: TmeIWLabel;
    lblCompetenze: TmeIWLabel;
    dedtCompetenza1: TmeIWDBEdit;
    dedtRetribuzione1: TmeIWDBEdit;
    dedtRetribuzione2: TmeIWDBEdit;
    dedtCompetenza2: TmeIWDBEdit;
    dedtRetribuzione3: TmeIWDBEdit;
    dedtCompetenza3: TmeIWDBEdit;
    dedtRetribuzione4: TmeIWDBEdit;
    dedtCompetenza4: TmeIWDBEdit;
    dedtCompetenza5: TmeIWDBEdit;
    dedtRetribuzione5: TmeIWDBEdit;
    dedtCompetenza6: TmeIWDBEdit;
    dedtRetribuzione6: TmeIWDBEdit;
    lblFascia1: TmeIWLabel;
    lblFascia2: TmeIWLabel;
    lblFascia3: TmeIWLabel;
    lblFascia4: TmeIWLabel;
    lblFascia5: TmeIWLabel;
    lblFascia6: TmeIWLabel;
    lblFruizioneAnnoCorrente: TmeIWLabel;
    lblFruizioneMinima: TmeIWLabel;
    dedtFruizioneMinima: TmeIWDBEdit;
    lblDa: TmeIWLabel;
    dedtDa: TmeIWDBEdit;
    dedtResiduoFruibile: TmeIWDBEdit;
    lblResiduoFruibile: TmeIWLabel;
    dedtMaxFruizOre: TmeIWDBEdit;
    lblMaxFruizOre: TmeIWLabel;
    lblProporzionamento: TmeIWLabel;
    dcmbProporzionamento: TmeIWDBComboBox;
    dchkSommaGiorni: TmeIWDBCheckBox;
    lblArrotondamento: TmeIWLabel;
    lblArrotondamentoOre: TmeIWLabel;
    dedtArrotondamentoOre: TmeIWDBEdit;
    dchkMezzeGiornate: TmeIWDBCheckBox;
    lblDescProfiloAssenze: TmeIWLabel;
    rgpTipoArrot: TmeTIWAdvRadioGroup;
    lblDescRaggruppamento: TmeIWLabel;
    drgpUnitaDiMisura: TmeIWDBRadioGroup;
    drgpTipo: TmeIWDBRadioGroup;
    drgpRapportiDiLavoroUnificati: TmeIWDBRadioGroup;
    lnkProfiloAssenze: TmeIWLink;
    lnkRaggruppamento: TmeIWLink;
    dchkCompetenzePersonalizzate: TmeIWDBCheckBox;
    lblTipo: TmeIWLabel;
    cmbProfiloAssenze: TMedpIWMultiColumnComboBox;
    cmbRaggruppamento: TMedpIWMultiColumnComboBox;
    dchkPropGG: TmeIWDBCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dchkMezzeGiornateClick(Sender: TObject);
    procedure imgAccediRaggruppamentoClick(Sender: TObject);
    procedure imgAccediProfiloAssenzeClick(Sender: TObject);
    procedure drgpUnitaDiMisuraClick(Sender: TObject);
    procedure cmbRaggruppamentoAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbProfiloAssenzeAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure drgpTipoClick(Sender: TObject);
    procedure dcmbProporzionamentoChange(Sender: TObject);
  private
  public
    procedure DataSet2Componenti; override;
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure CaricaMaskEdit;
  end;

implementation

uses WA009UProfAsseAnn, WA009UProfAsseAnnDM, WR100UBase, WA017URaggrAsse,
     WA009UProfiliAssenzeFM;

{$R *.dfm}

procedure TWA009FProfAsseAnnDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;

  dcmbProporzionamento.Items.Clear;
  dcmbProporzionamento.Items.Values['Nessuna proporzione']:='0';
  dcmbProporzionamento.Items.Values['Lavorato nel mese > 15gg']:='1';
  dcmbProporzionamento.Items.Values['Lavorato nel mese > metà mese']:='2';
  dcmbProporzionamento.Items.Values['Lavorato nel mese > 14gg']:='3';
  dcmbProporzionamento.Items.Values['Proporzione giornaliera']:='4';
end;

procedure TWA009FProfAsseAnnDettFM.DataSet2Componenti;
begin
  with (TWA009FProfAsseAnnDM(WR302DM)) do
  begin
    cmbProfiloAssenze.ItemIndex:=-1;
    cmbProfiloAssenze.Text:=selTabella.fieldByName('CODPROFILO').AsString;
    lblDescProfiloAssenze.Caption:=VarToStr(selT261.LookUp('CODICE',selTabella.fieldByName('CODPROFILO').AsString, 'DESCRIZIONE'));

    cmbRaggruppamento.ItemIndex:=-1;
    cmbRaggruppamento.Text:=selTabella.FieldByName('CODRAGGR').AsString;
    lblDescRaggruppamento.Caption:=VarToStr(Q260.LookUp('CODICE', selTabella.FieldByName('CODRAGGR').AsString, 'DESCRIZIONE'));

    if selTabellaARRFAV. AsString = 'F' then
      rgpTipoArrot.ItemIndex:=0
    else if selTabellaARRFAV. AsString = 'P' then
      rgpTipoArrot.ItemIndex:=1
    else if selTabellaARRFAV. AsString = 'S' then
      rgpTipoArrot.ItemIndex:=2;

    CaricaMaskEdit;
  end;
end;

procedure TWA009FProfAsseAnnDettFM.Componenti2DataSet;
begin
  with (TWA009FProfAsseAnnDM(WR302DM)) do
  begin
    selTabella.FieldByName('CODPROFILO').AsString:=cmbProfiloAssenze.Text;
    selTabella.FieldByName('CODRAGGR').AsString:=cmbRaggruppamento.Text;

    if rgpTipoArrot.ItemIndex = 0 then
      selTabella.FieldByName('ARRFAV').AsString:='F'
    else if rgpTipoArrot.ItemIndex = 1 then
      selTabella.FieldByName('ARRFAV').AsString:='P'
    else if rgpTipoArrot.ItemIndex = 2 then
      selTabella.FieldByName('ARRFAV').AsString:='S'
  end;
end;

procedure TWA009FProfAsseAnnDettFM.CaricaMaskEdit;
begin
  with (TWA009FProfAsseAnnDM(WR302DM)) do
  begin
    if selTabellaUMisura.Value = 'G' then
    begin
      //La classe NoDisabled serve per rimuovere l'attributo disabled per i componenti Data-Aware
      ImpostaCss(dedtCompetenza1,'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza2,'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza3,'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza4,'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza5,'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza6,'input_num_nnnd width5chr');
      ImpostaCss(dedtFruizioneMinima,'input_num_nnnd width5chr');
    end
    else if selTabellaUMisura.Value = 'O' then //ore
    begin
      ImpostaCss(dedtCompetenza1,'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza2,'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza3,'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza4,'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza5,'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza6,'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtFruizioneMinima,'input_hour_hhhhmm width5chr');
    end;
  end;
end;

procedure TWA009FProfAsseAnnDettFM.CaricaMultiColumnCombobox;
begin
  TWA009FProfAsseAnnDM(WR302DM).selT261.First;
  while not TWA009FProfAsseAnnDM(WR302DM).selT261.Eof do
  begin
    cmbProfiloAssenze.AddRow(TWA009FProfAsseAnnDM(WR302DM).selT261.FieldByName('CODICE').AsString + ';' + TWA009FProfAsseAnnDM(WR302DM).selT261.FieldByName('DESCRIZIONE').AsString);
    TWA009FProfAsseAnnDM(WR302DM).selT261.Next;
  end;

  TWA009FProfAsseAnnDM(WR302DM).Q260.Refresh;
  TWA009FProfAsseAnnDM(WR302DM).Q260.First;
  while not TWA009FProfAsseAnnDM(WR302DM).Q260.Eof do
  begin
    cmbRaggruppamento.AddRow(TWA009FProfAsseAnnDM(WR302DM).Q260.FieldByName('CODICE').AsString + ';' + TWA009FProfAsseAnnDM(WR302DM).Q260.FieldByName('DESCRIZIONE').AsString);
    TWA009FProfAsseAnnDM(WR302DM).Q260.Next;
  end;

end;

procedure TWA009FProfAsseAnnDettFM.AbilitaComponenti;
begin
  with (TWA009FProfAsseAnnDM(WR302DM)) do
  begin
    dchkSommaGiorni.Enabled:=(dcmbProporzionamento.ItemIndex in [1,2,3]) and (drgpTipo.ItemIndex <> 2);
    dchkPropGG.Enabled:=(dcmbProporzionamento.ItemIndex in [1,2,3]) and (drgpTipo.ItemIndex <> 2);
    if selTabella.State in [dsEdit,dsInsert] then
    begin
      if (selTabella.FieldByName('UMISURA').AsString ='O') or (selTabella.FieldByName('MG').AsString ='S') then
      begin
        rgpTipoArrot.EnabledItems[1]:=0;

        if (rgpTipoArrot.ItemIndex = 1) then
        begin
          selTabella.FieldByName('ARRFAV').AsString:='F';
          rgpTipoArrot.ItemIndex:=0;
        end;
      end
      else
        rgpTipoArrot.EnabledItems[1]:=1;
      if not dchkSommaGiorni.Enabled then
        dchkSommaGiorni.Checked:=False;
      if not dchkPropGG.Enabled then
        dchkPropGG.Checked:=False;
    end;

    dchkMezzeGiornate.Enabled:=selTabellaUMisura.Value = 'G';
    if not dchkMezzeGiornate.Enabled then
      selTabella.FieldByName('MG').AsString:='N';

    lblArrotondamentoOre.Enabled:=selTabellaUMisura.Value = 'O';
    dedtArrotondamentoOre.Enabled:=selTabellaUMisura.Value = 'O';
    if not dedtArrotondamentoOre.Enabled then
      selTabella.FieldByName('ARR_COMPETENZA_IN_ORE').AsString:='';

    lblMaxFruizOre.Enabled:=selTabellaUMisura.Value = 'O';
    dedtMaxFruizOre.Enabled:=selTabellaUMisura.Value = 'O';
    if not dedtMaxFruizOre.Enabled then
      selTabella.FieldByName('MAX_FRUIZIONE_GIORN_IN_ORE').AsString:='';
  end;
end;

procedure TWA009FProfAsseAnnDettFM.cmbProfiloAssenzeAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA009FProfAsseAnnDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.fieldByName('CODPROFILO').AsString:=cmbProfiloAssenze.Text; //nel caso si lanci l'accedi
      lblDescProfiloAssenze.Caption:=cmbProfiloAssenze.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.fieldByName('CODPROFILO').AsString:='';
      lblDescProfiloAssenze.Caption:='';
    end;
  end;
end;

procedure TWA009FProfAsseAnnDettFM.cmbRaggruppamentoAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA009FProfAsseAnnDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.fieldByName('CODRAGGR').AsString:=cmbRaggruppamento.Text; //nel caso si lanci l'accedi
      lblDescRaggruppamento.Caption:=cmbRaggruppamento.Items[Index].RowData[1];
    end
    else
    begin
      selTabella.fieldByName('CODRAGGR').AsString:='';
      lblDescRaggruppamento.Caption:='';
    end;
  end;
end;

procedure TWA009FProfAsseAnnDettFM.dchkMezzeGiornateClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA009FProfAsseAnnDettFM.dcmbProporzionamentoChange(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA009FProfAsseAnnDettFM.drgpTipoClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA009FProfAsseAnnDettFM.drgpUnitaDiMisuraClick(Sender: TObject);
var
  SeparatoreDa,SeparatoreA : String;
begin
  inherited;
  with TWA009FProfAsseAnnDM(WR302DM).selTabella do
  begin
    FieldByName('UMisura').AsString:=drgpUnitaDiMisura.Values[drgpUnitaDiMisura.ItemIndex];
    //Caratto 19/06/2012 nel cambio di unità misura cambio il separatore decimali tra , e .
    if (FieldByName('UMisura').asString = 'G') then
    begin
      SeparatoreDa:='.';
      SeparatoreA:=',';
    end
    else
    begin
      SeparatoreDa:=',';
      SeparatoreA:='.';
    end;
    FieldByName('Fruiz_anno_minima').asString:=StringReplace(FieldByName('Fruiz_anno_minima').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
    FieldByName('Competenza1').asString:=StringReplace(FieldByName('Competenza1').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
    FieldByName('Competenza2').asString:=StringReplace(FieldByName('Competenza2').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
    FieldByName('Competenza3').asString:=StringReplace(FieldByName('Competenza3').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
    FieldByName('Competenza4').asString:=StringReplace(FieldByName('Competenza4').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
    FieldByName('Competenza5').asString:=StringReplace(FieldByName('Competenza5').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
    FieldByName('Competenza6').asString:=StringReplace(FieldByName('Competenza6').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
  end;
  AbilitaComponenti;
  CaricaMaskEdit;
end;

procedure TWA009FProfAsseAnnDettFM.imgAccediProfiloAssenzeClick(
  Sender: TObject);
begin
  inherited;
  TWA009FProfAsseAnnDM(WR302DM).selT261.SearchRecord('CODICE',TWA009FProfAsseAnnDM(WR302DM).selTabellaCodProfilo.AsString,[srFromBeginning]);
  TWA009FProfiliAssenzeFM(TWA009FProfAsseAnn(Self.Parent).WProfiliAssenzeFM).grdProfiliAssenze.medpAggiornaCDS(True);
  TWA009FProfAsseAnn(Self.Parent).grdTabControl.ActiveTab:=TWA009FProfAsseAnn(Self.Parent).WProfiliAssenzeFM;
end;

procedure TWA009FProfAsseAnnDettFM.imgAccediRaggruppamentoClick(
  Sender: TObject);
begin

  TWA009FProfAsseAnn(Self.Parent).AccediForm(110,'CODICE='+TWA009FProfAsseAnnDM(WR302DM).selTabellaCodRaggr.AsString);
end;

end.