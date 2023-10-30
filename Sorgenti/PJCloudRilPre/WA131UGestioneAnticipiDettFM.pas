unit WA131UGestioneAnticipiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, medpIWMultiColumnComboBox, meIWDBLabel,
  WA131UGestioneAnticipiDM, IWCompCheckbox, meIWDBCheckBox, IWCompExtCtrls,
  IWDBExtCtrls, meIWDBRadioGroup, C180FunzioniGenerali, A000UInterfaccia,
  IWAdvRadioGroup, meTIWAdvRadioGroup,
  IWCompMemo, meIWDBMemo, db, IWHTMLControls, meIWLink;

type
  TWA131FGestioneAnticipiDettFM = class(TWR205FDettTabellaFM)
    lblCassa: TmeIWLabel;
    dedtCassa: TmeIWDBEdit;
    LblNumMovimento: TmeIWLabel;
    dedtNumMovimento: TmeIWDBEdit;
    lblAnnoMovimento: TmeIWLabel;
    dedtAnnoMovimento: TmeIWDBEdit;
    lblDataMov: TmeIWLabel;
    dedtDataMov: TmeIWDBEdit;
    cmbCodiceVoce: TMedpIWMultiColumnComboBox;
    dlblDescCodVoce: TmeIWDBLabel;
    lblNSosp: TmeIWLabel;
    dedtNSosp: TmeIWDBEdit;
    lblDataMissione: TmeIWLabel;
    dedtDataMissione: TmeIWDBEdit;
    lblQuantita: TmeIWLabel;
    dedtQuantita: TmeIWDBEdit;
    lblImporto: TmeIWLabel;
    dChkTotalizzatore: TmeIWDBCheckBox;
    drgpTipoAnticipo: TmeIWDBRadioGroup;
    lblTipoAnticipo: TmeIWLabel;
    lblDataImpostazioneStato: TmeIWLabel;
    dedtDataImpostazioneStato: TmeIWDBEdit;
    rgpStato: TmeTIWAdvRadioGroup;
    lblNote: TmeIWLabel;
    dmemNote: TmeIWDBMemo;
    lnkCodiceVoce: TmeIWLink;
    dedtImporto: TmeIWDBEdit;
    procedure cmbCodiceVoceAsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
    procedure rgpStatoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dedtDataMovAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dedtNumMovimentoAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure lnkCodiceVoceClick(Sender: TObject);
  private
    SaveItemIndexStato: Integer;
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses WA131UGestioneAnticipi;
{$R *.dfm}

{ TWA131FGestioneAnticipiDettFM }

procedure TWA131FGestioneAnticipiDettFM.DataSet2Componenti;
var Abilita: boolean;
begin
  inherited;
  with WR302DM do
  begin
    cmbCodiceVoce.Text:=selTabella.FieldByName('COD_VOCE').AsString;
    if SelTabella.FieldByName('STATO').AsString = 'S' then
      rgpStato.ItemIndex:=0
    else if SelTabella.FieldByName('STATO').AsString = 'P' then
      rgpStato.ItemIndex:=1
    else if SelTabella.FieldByName('STATO').AsString = 'L' then
      rgpStato.ItemIndex:=2
    else if SelTabella.FieldByName('STATO').AsString = 'R' then
      rgpStato.ItemIndex:=3
    else
      rgpStato.ItemIndex:=-1;
    SaveItemIndexStato:=rgpStato.ItemIndex;

    Abilita:=False;
    if (Pos(selTabella.FieldByName('STATO').AsString,Parametri.A131_AnticipiGestibili) <> 0)
         and Not((Self.Parent as TWA131FGestioneAnticipi).SolaLettura) then
        Abilita:=True;
    with (Self.Parent as TWA131FGestioneAnticipi) do
    begin
     actModifica.Enabled:=Abilita;
     actElimina.Enabled:=Abilita;
     AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    end;
    (Self.Parent as TWA131FGestioneAnticipi).WCollegMissioniFM.imgCollega.Enabled:=Abilita;
  end;
end;

procedure TWA131FGestioneAnticipiDettFM.dedtDataMovAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  with WR302DM do
  begin
    if SelTabella.State = dsInsert then
    begin
      if (SelTabella.FieldByName('DATA_MISSIONE').AsDateTime = DATE_NULL) and
         (SelTabella.FieldByName('DATA_MOVIMENTO').AsDateTime > DATE_NULL)  then
      begin
        SelTabella.FieldByName('DATA_MISSIONE').AsDateTime:=SelTabella.FieldByName('DATA_MOVIMENTO').AsDateTime
      end;
    end;
  end;
end;

procedure TWA131FGestioneAnticipiDettFM.dedtNumMovimentoAsyncDoubleClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW.CreaNumMovimento;
end;

procedure TWA131FGestioneAnticipiDettFM.lnkCodiceVoceClick(Sender: TObject);
var Params: String;
begin
  inherited;
//aggancio WA120
  Params:='CODICE=' + cmbCodiceVoce.Text;
  (Self.Owner as TWA131FGestioneAnticipi).AccediForm(156,Params);
end;

procedure TWA131FGestioneAnticipiDettFM.rgpStatoAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  //Imposto solo se ho cambiato item selezionato.
  //se faccio click su quello già selezionato non imposto nulla
  if SaveItemIndexStato <> rgpStato.ItemIndex then
  begin
    with WR302DM do
    begin
      if rgpStato.ItemIndex = 0 then
        SelTabella.FieldByName('STATO').AsString:='S'
      else if rgpStato.ItemIndex = 1 then
        SelTabella.FieldByName('STATO').AsString:='P'
      else if rgpStato.ItemIndex = 2 then
        SelTabella.FieldByName('STATO').AsString:='L'
      else if rgpStato.ItemIndex = 3 then
        SelTabella.FieldByName('STATO').AsString:='R';
      selTabella.FieldByName('DATA_IMPOSTAZIONE_STATO').AsDateTime:=Trunc(R180SysDate(SessioneOracle));
    end;
    SaveItemIndexStato:=rgpStato.ItemIndex;
  end;
end;

procedure TWA131FGestioneAnticipiDettFM.AbilitaComponenti;
var enab: Boolean;
begin
  inherited;
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    //in edit non si può cambiare cassa, num movimento, anno e cod voce
    enab:=WR302DM.selTabella.State = dsInsert;
    dedtCassa.Enabled:=enab;
    dedtNumMovimento.Enabled:=enab;
    dedtAnnoMovimento.Enabled:=enab;
    cmbCodiceVoce.Enabled:=enab;
    //SE IN MODIFICA O INSERT COLLEGA DISABILITATO
    (Self.Parent as TWA131FGestioneAnticipi).WCollegMissioniFM.imgCollega.Enabled:=False;
  end;
end;

procedure TWA131FGestioneAnticipiDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
  begin
    selTAnticipi.First;
    while not selTAnticipi.Eof do
    begin
      cmbCodiceVoce.AddRow(selTAnticipi.FieldByName('CODICE').AsString + ';' + selTAnticipi.FieldByName('DESCRIZIONE').AsString);
      selTAnticipi.Next;
    end;
  end;
end;

procedure TWA131FGestioneAnticipiDettFM.cmbCodiceVoceAsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with WR302DM do
  begin
  if cmbCodiceVoce.ItemIndex <> -1 then
    selTabella.FieldByName('COD_VOCE').AsString:=cmbCodiceVoce.Text
  else
    selTabella.FieldByName('COD_VOCE').AsString:='';
  end;
  //Aggiorna DBLabel legata a campo Lookup
end;

procedure TWA131FGestioneAnticipiDettFM.Componenti2DataSet;
begin
  inherited;
end;

end.
