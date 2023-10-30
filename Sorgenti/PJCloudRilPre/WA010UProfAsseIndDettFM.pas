unit WA010UProfAsseIndDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  meIWDBComboBox, meIWDBLabel,
  meIWLabel, Db, Oracle, ActnList, IWCompExtCtrls,
  IWCompJQueryWidget, meIWImageFile, IWHTMLControls, meIWLink, IWCompMemo, meIWMemo, meIWDBMemo,
  medpIWMultiColumnComboBox,
  A000UCostanti, A000UInterfaccia, C180FunzioniGenerali, WR205UDettTabellaFM;

type
  TWA010FProfAsseIndDettFM = class(TWR205FDettTabellaFM)
    lblUnitaDiMisura: TmeIWLabel;
    lblRapportiDiLavoroUnificati: TmeIWLabel;
    lblResiduoFruibile: TmeIWLabel;
    dedtResiduoFruibile: TmeIWDBEdit;
    lblVariazioneManuale: TmeIWLabel;
    dedtVariazioneManuale: TmeIWDBEdit;
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
    lblDescRaggruppamento: TmeIWLabel;
    dlblRaggruppamento: TmeIWDBLabel;
    lblDal: TmeIWLabel;
    lblAl: TmeIWLabel;
    dedtDal: TmeIWDBEdit;
    dedtAl: TmeIWDBEdit;
    drgpUnitaDiMisura: TmeIWDBRadioGroup;
    drgpRapportiDiLavoroUnificati: TmeIWDBRadioGroup;
    lnkRaggruppamento: TmeIWLink;
    lblNote: TmeIWLabel;
    DBMemo1: TmeIWDBMemo;
    dcmbRaggruppamento: TMedpIWMultiColumnComboBox;
    dcmbFamiliari: TMedpIWMultiColumnComboBox;
    lblFamiliari: TmeIWLabel;
    dedtVariazFerieSol: TmeIWDBEdit;
    lblVariazFerieSol: TmeIWLabel;
    procedure drgpUnitaDiMisuraClick(Sender: TObject);
    procedure dcmbRaggruppamentoChange(Sender: TObject; Index: Integer);
    procedure imgAccediClick(Sender: TObject);
  private
    { Private declarations }
    procedure ImpostaMask;
  public
    { Public declarations }
     procedure DataSet2Componenti; override;
     procedure AbilitaComponenti; override;
     procedure Componenti2DataSet; override;
     procedure CaricaMultiColumnCombobox;override;
  end;

implementation

uses WA010UProfAsseIndDM, WA010UProfAsseInd, WA017URaggrAsse, WR100UBase;

{$R *.dfm}


//imposta css in base all'unita di misura
procedure TWA010FProfAsseIndDettFM.ImpostaMask;
begin
 with TWA010FProfAsseIndDM(WR302DM) do
  begin
  if selTabella.FieldByName('UMISURA').AsString = 'G' then
    begin
      ImpostaCss(dedtVariazioneManuale, 'input_num_nnnd_neg width5chr');
      ImpostaCss(dedtVariazFerieSol, 'input_num_nnnd_neg width5chr');
      ImpostaCss(dedtCompetenza1, 'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza2, 'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza3, 'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza4, 'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza5, 'input_num_nnnd width5chr');
      ImpostaCss(dedtCompetenza6, 'input_num_nnnd width5chr');
    end
    else
    begin
      ImpostaCss(dedtVariazioneManuale, 'input_hour_hhhhmm_neg width5chr');
      ImpostaCss(dedtVariazFerieSol, 'input_hour_hhhhmm_neg width5chr');
      ImpostaCss(dedtCompetenza1, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza2, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza3, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza4, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza5, 'input_hour_hhhhmm width5chr');
      ImpostaCss(dedtCompetenza6, 'input_hour_hhhhmm width5chr');
    end;
  end;
end;

procedure TWA010FProfAsseIndDettFM.DataSet2Componenti;
begin
  with TWA010FProfAsseIndDM(WR302DM) do
  begin
    //Raggruppamento assenza
    dcmbRaggruppamento.ItemIndex:=-1;
    dcmbRaggruppamento.Text:=selTabella.FieldByName('CODRAGGR').AsString;
    lblDescRaggruppamento.Caption:=selTabella.FieldByName('D_Raggruppamento').AsString;
    //Familiari
    dcmbFamiliari.ItemIndex:=-1;
    dcmbFamiliari.Text:=selTabella.FieldByName('FAMILIARE_DATANAS').AsString;
    if selTabella.FieldByName('FAMILIARE_DATANAS').AsDateTime = DATE_NULL then
      dcmbFamiliari.Text:='';
  end;
  impostaMask;
end;

procedure TWA010FProfAsseIndDettFM.AbilitaComponenti;
var
  SeparatoreDa  : String;
  SeparatoreA   : String;
  ContaSolare   : Boolean;
begin

  with TWA010FProfAsseIndDM(WR302DM) do
  begin
    if selTabella.State in [dsInsert,dsEdit] then
    begin
      lblVariazFerieSol.Enabled:=False;
      dedtVariazFerieSol.Enabled:=False;

      ContaSolare:=VarToStr(Q260.Lookup('CODICE',selTabella.FieldByName('CODRAGGR').AsString,'CONTASOLARE')) = 'S';

      drgpRapportiDiLavoroUnificati.Enabled:=ContaSolare;
      drgpUnitaDiMisura.Enabled:=ContaSolare;
      lblResiduoFruibile.Enabled:=ContaSolare;
      dedtResiduoFruibile.Enabled:=ContaSolare;

      dedtCompetenza1.Enabled:=ContaSolare;
      dedtCompetenza2.Enabled:=ContaSolare;
      dedtCompetenza3.Enabled:=ContaSolare;
      dedtCompetenza4.Enabled:=ContaSolare;
      dedtCompetenza5.Enabled:=ContaSolare;
      dedtCompetenza6.Enabled:=ContaSolare;

      dedtRetribuzione1.Enabled:=ContaSolare;
      dedtRetribuzione2.Enabled:=ContaSolare;
      dedtRetribuzione3.Enabled:=ContaSolare;
      dedtRetribuzione4.Enabled:=ContaSolare;
      dedtRetribuzione5.Enabled:=ContaSolare;
      dedtRetribuzione6.Enabled:=ContaSolare;

      //Caratto 29/06/2012 nel cambio di unità misura cambio il separatore decimali tra , e .
      if (selTabella.fieldByName('UMISURA').asString = 'G') then
      begin
        SeparatoreDa:='.';
        SeparatoreA:=',';
      end
      else
      begin
        SeparatoreDa:=',';
        SeparatoreA:='.';
      end;

      selTabella.FieldByName('Decurtazione').asString:=StringReplace(selTabella.FieldByName('Decurtazione').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
      selTabella.FieldByName('Competenza1').asString:=StringReplace(selTabella.FieldByName('Competenza1').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
      selTabella.FieldByName('Competenza2').asString:=StringReplace(selTabella.FieldByName('Competenza2').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
      selTabella.FieldByName('Competenza3').asString:=StringReplace(selTabella.FieldByName('Competenza3').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
      selTabella.FieldByName('Competenza4').asString:=StringReplace(selTabella.FieldByName('Competenza4').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
      selTabella.FieldByName('Competenza5').asString:=StringReplace(selTabella.FieldByName('Competenza5').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
      selTabella.FieldByName('Competenza6').asString:=StringReplace(selTabella.FieldByName('Competenza6').asString,SeparatoreDa,SeparatoreA,[rfReplaceAll]);
    end;
  end;
end;

procedure TWA010FProfAsseIndDettFM.CaricaMultiColumnComboBox;
begin
  TWA010FProfAsseIndDM(WR302DM).Q260.Open;
  TWA010FProfAsseIndDM(WR302DM).Q260.First;
  while not TWA010FProfAsseIndDM(WR302DM).Q260.Eof do
  begin
    dcmbRaggruppamento.AddRow(TWA010FProfAsseIndDM(WR302DM).Q260.FieldByName('CODICE').AsString + ';' + TWA010FProfAsseIndDM(WR302DM).Q260.FieldByName('DESCRIZIONE').AsString);
    TWA010FProfAsseIndDM(WR302DM).Q260.Next;
  end;

  TWA010FProfAsseIndDM(WR302DM).selSG101.First;
  while not TWA010FProfAsseIndDM(WR302DM).selSG101.Eof do
  begin
    dcmbFamiliari.AddRow(TWA010FProfAsseIndDM(WR302DM).selSG101.FieldByName('DATA').AsString + ';' + TWA010FProfAsseIndDM(WR302DM).selSG101.FieldByName('NOME').AsString);
    TWA010FProfAsseIndDM(WR302DM).selSG101.Next;
  end;
end;

procedure TWA010FProfAsseIndDettFM.Componenti2DataSet;
begin
  with TWA010FProfAsseIndDM(WR302DM) do
  begin
    if (dcmbRaggruppamento.Text <> '') then
      selTabella.FieldByName('CODRAGGR').AsString:=dcmbRaggruppamento.Text
    else
      selTabella.FieldByName('CODRAGGR').AsString:=EmptyStr;
    if dcmbFamiliari.Text <> '' then
      selTabella.FieldByName('FAMILIARE_DATANAS').AsDateTime:=StrToDateTime(dcmbFamiliari.Text)
    else
      selTabella.FieldByName('FAMILIARE_DATANAS').AsDateTime:=DATE_NULL;
   end;
end;

procedure TWA010FProfAsseIndDettFM.dcmbRaggruppamentoChange(Sender: TObject;
  Index: Integer);
begin
  inherited;

  with TWA010FProfAsseIndDM(WR302DM) do
  begin
    selTabella.FieldByName('CODRAGGR').AsString:=dcmbRaggruppamento.Items[Index].RowData[0];
    selTabella.FieldByName('UMISURA').AsString:=VarToStr(Q260.Lookup('CODICE',selTabella.FieldByName('CODRAGGR').AsString ,'UMISURA'));
  end;
  lblDescRaggruppamento.Caption:=dcmbRaggruppamento.Items[Index].RowData[1];
  ImpostaMask;
  AbilitaComponenti;
end;

procedure TWA010FProfAsseIndDettFM.drgpUnitaDiMisuraClick(Sender: TObject);

begin
{ TODO -oCaratto -cworkaround : IWDbRadioGroup non imposta il campo su seltabella già qui. la Check invece si. }
  with TWA010FProfAsseIndDM(WR302DM) do
    selTabella.FieldByName('UMISURA').AsString:=drgpUnitaDiMisura.Values[drgpUnitaDiMisura.ItemIndex];
  ImpostaMask;
  AbilitaComponenti;
end;

procedure TWA010FProfAsseIndDettFM.imgAccediClick(Sender: TObject);
begin
  TWA010FProfAsseInd(Self.Parent).AccediForm(106,'CODICE=' +TWA010FProfAsseIndDM(WR302DM).selTabella.FieldByName('CODRAGGR').AsString);
end;

end.
