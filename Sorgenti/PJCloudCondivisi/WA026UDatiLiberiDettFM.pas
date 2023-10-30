unit WA026UDatiLiberiDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, A000UInterfaccia, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  IWMultiColumnComboBox, meIWDBComboBox, meIWDBLabel,
  meIWLabel, IWCompCheckbox, meIWDBCheckBox, meIWComboBox, Db, meIWEdit,
  IWCompExtCtrls, IWCompJQueryWidget, meIWCheckBox;

type
  TWA026FDatiLiberiDettFM = class(TWR205FDettTabellaFM)
    lblNomeDato: TmeIWLabel;
    dedtNomeCampo: TmeIWDBEdit;
    lblNomePagina: TmeIWLabel;
    cmbNomePagina: TmeIWComboBox;
    lblFormato: TmeIWLabel;
    lblDimensioneDato: TmeIWLabel;
    lblDimensioneDescrizioneDato: TmeIWLabel;
    dedtLunghezza: TmeIWDBEdit;
    dedtLunghezzaDesc: TmeIWDBEdit;
    dchkDatoTabellare: TmeIWDBCheckBox;
    dchkRiferimentoTabellaStoricizzata: TmeIWDBCheckBox;
    dchkGestioneManualeScadenza: TmeIWDBCheckBox;
    lblDecorrenzaDati: TmeIWLabel;
    edtDecorrenza: TmeIWEdit;
    drgpFormato: TmeIWDBRadioGroup;
    chkObbligatorio: TmeIWCheckBox;
    edtValDefault: TmeIWEdit;
    lblValDefault: TmeIWLabel;
    dchkStoricizzabile: TmeIWDBCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dchkDatoTabellareClick(Sender: TObject);
    procedure dchkRiferimentoTabellaStoricizzataClick(Sender: TObject);
    procedure drgpFormatoClick(Sender: TObject);
  private

  public
    procedure AbilitaComponenti; override;
    procedure Componenti2DataSet; override;
    procedure DataSet2Componenti; override;
  end;

implementation

uses WA026UDatiLiberiDM, WA026UDatiLiberi;

{$R *.dfm}

procedure TWA026FDatiLiberiDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with TWA026FDatiLiberiDM(TWA026FDatiLiberi(Self.Parent).WR302DM) do
  begin
    selT033.Open;
    cmbNOMEPAGINA.Items.Clear;
    while not selT033.Eof do
    begin
      cmbNOMEPAGINA.Items.Add(selT033.FieldByName('NOMEPAGINA').AsString);
      selT033.Next;
    end;
    selT033.Close;
    chkObbligatorio.Checked:=A026FDatiLiberiMW.GetDatoObbligatorio(selTabella.FieldByName('NOMECAMPO').AsString);
    edtValDefault.Text:=A026FDatiLiberiMW.GetDatoDefault(selTabella.FieldByName('NOMECAMPO').AsString);
  end;
end;

procedure TWA026FDatiLiberiDettFM.DataSet2Componenti;
begin
  with TWA026FDatiLiberiDM(WR302DM) do
  begin
    cmbNOMEPAGINA.ItemIndex:=cmbNOMEPAGINA.Items.IndexOf(A026FDatiLiberiMW.GetNomePagina);
    if selTabella.State in [dsBrowse] then
    begin
      chkObbligatorio.Checked:=A026FDatiLiberiMW.GetDatoObbligatorio(selTabella.FieldByName('NOMECAMPO').AsString);
      edtValDefault.Text:=A026FDatiLiberiMW.GetDatoDefault(selTabella.FieldByName('NOMECAMPO').AsString);
    end
    else
    begin
      chkObbligatorio.Checked:=False;
      edtValDefault.Text:='';
    end;
  end;
end;

procedure TWA026FDatiLiberiDettFM.Componenti2DataSet;
begin
  with TWA026FDatiLiberiDM(WR302DM) do
  begin
    A026FDatiLiberiMW.A026Decorrenza:=edtDecorrenza.Text;
    A026FDatiLiberiMW.A026NomePagina:=cmbNOMEPAGINA.Text;
    A026FDatiLiberiMW.DatoDefault:=edtValDefault.Text;
    A026FDatiLiberiMW.DatoObbligatorio:=chkObbligatorio.Checked;
  end;
end;

procedure TWA026FDatiLiberiDettFM.AbilitaComponenti;
var
  isTabella : boolean;
  isStorico : boolean;
begin
  with TWA026FDatiLiberiDM(WR302DM) do
  begin
    if selTabella.State in [dsInsert,dsEdit] then
    begin
      selTabella.FieldByName('PROGRESSIVO').ReadOnly:=selTabella.State = dsEdit;

      if not (selTabella.FieldByName('FORMATO').AsString = 'S') then
      begin
        selTabella.FieldByName('TABELLA').AsString:='N';
        dchkDatoTabellare.Enabled:=False;
      end
      else
        dchkDatoTabellare.Enabled:=True;
    end;

    isTabella:=selTabella.FieldByName('TABELLA').AsString = 'S';
    lblDimensioneDescrizioneDato.Enabled:=isTabella;
    dedtLunghezzaDesc.Enabled:=isTabella;

    // abilitazione storico
    dchkRiferimentoTabellaStoricizzata.Enabled:=isTabella;

    if not isTabella then
      selTabella.FieldByName('STORICO').AsString:='N';

    isStorico:=selTabella.FieldByName('STORICO').AsString ='S';

    if (isStorico) and (selTabellaStorico.OldValue = 'N') then
    begin
      lblDecorrenzaDati.Visible:=True;
      edtDecorrenza.Visible:=True;
      edtDecorrenza.Text:='01/01/1900';
    end
    else
    begin
      lblDecorrenzaDati.Visible:=False;
      edtDecorrenza.Visible:=False;
      edtDecorrenza.Text:='';
    end;

    // abilitazione scadenza
    dchkGestioneManualeScadenza.Enabled:=isStorico;
    if not isStorico then
      selTabella.FieldByName('SCADENZA').AsString:='N';

    // abilitazione scadenza
    dchkGestioneManualeScadenza.Enabled:=isStorico;

    dchkStoricizzabile.Enabled:=selTabella.State = dsInsert;
  end;
end;


procedure TWA026FDatiLiberiDettFM.dchkDatoTabellareClick(Sender: TObject);
begin
  AbilitaComponenti;
end;

procedure TWA026FDatiLiberiDettFM.dchkRiferimentoTabellaStoricizzataClick(
  Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWA026FDatiLiberiDettFM.drgpFormatoClick(Sender: TObject);
begin
  inherited;
{ TODO -oCaratto -cworkaround : IWDbRadioGroup non imposta il campo su seltabella già qui. la Check invece si. }
  with TWA026FDatiLiberiDM(WR302DM).selTabella do
    FieldByName(drgpFormato.DataField).AsString:=drgpFormato.Values[drgpFormato.ItemIndex];

  AbilitaComponenti;
end;

end.
