unit WA111UParMessaggiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, DB,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, IWDBExtCtrls,
  meIWDBRadioGroup, IWCompListbox, IWDBStdCtrls, meIWDBComboBox, IWControl,
  IWCompEdit, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWCompLabel, meIWLabel, IWCompCheckbox,
  meIWDBCheckBox, IWCompGrids, IWDBGrids, medpIWDBGrid, meIWDBLookupComboBox,
  IWHTMLControls, meIWLink;

type
  TWA111FParMessaggiDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    lblNomeFile: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    dedtNomeFile: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    lblFormatoData: TmeIWLabel;
    dcmbFormatoData: TmeIWDBComboBox;
    lblTipoRegistrazione: TmeIWLabel;
    drgpTipoRegistrazione: TmeIWDBRadioGroup;
    lblRegistraMessaggi: TmeIWLabel;
    drgpRegistraMessaggi: TmeIWDBRadioGroup;
    dedtNumeroRipetiz: TmeIWDBEdit;
    lblNumeroRipetiz: TmeIWLabel;
    lblTipoFiltro: TmeIWLabel;
    dgrpTipoFiltro: TmeIWDBRadioGroup;
    lblNumeroGiorniValid: TmeIWLabel;
    dedtNumeroGiorniValid: TmeIWDBEdit;
    lblMesiIndietro: TmeIWLabel;
    dedtMesiIndietro: TmeIWDBEdit;
    lblValiditaDati: TmeIWLabel;
    dedtValiditaDati: TmeIWDBEdit;
    dChkDefault: TmeIWDBCheckBox;
    lblTipoSupporto: TmeIWLabel;
    dRgpTipoSupporto: TmeIWDBRadioGroup;
    lblProva: TmeIWLabel;
    dCmbFiltroAnagr: TmeIWDBLookupComboBox;
    lnkFiltroAnagr: TmeIWLink;
    procedure dcmbFormatoDataChange(Sender: TObject);
    procedure dgrpTipoFiltroClick(Sender: TObject);
    procedure lnkFiltroAnagrClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA111UParMessaggi, WA111UParMessaggiDM, WR100UBase;

{$R *.dfm}

procedure TWA111FParMessaggiDettFM.dcmbFormatoDataChange(Sender: TObject);
begin
  inherited;
  if dCmbFormatoData.Text = '' then
    LblProva.Caption:=''
  else
    LblProva.Caption:=FormatDateTime(dCmbFormatoData.Text,Now);
end;

procedure TWA111FParMessaggiDettFM.dgrpTipoFiltroClick(Sender: TObject);
begin
  if dgrpTipoFiltro.ItemIndex = 0 then
  begin
    dCmbFiltroAnagr.ListSource:=((Self.Owner as TWA111FParMessaggi).WR302DM as TWA111FParMessaggiDM).A111MW.dsrT003;
    if ((Self.Owner as TWA111FParMessaggi).WR302DM as TWA111FParMessaggiDM).selTabella.State in [dsEdit,dsInsert] then
      //dCmbFiltroAnagr.Field.Clear;
      ((Self.Owner as TWA111FParMessaggi).WR302DM as TWA111FParMessaggiDM).A111MW.selT291.FieldByName('FILTRO_ANAGR').AsString:='';
  end
  else
  begin
    dCmbFiltroAnagr.ListSource:=((Self.Owner as TWA111FParMessaggi).WR302DM as TWA111FParMessaggiDM).A111MW.dsrT002;
    if ((Self.Owner as TWA111FParMessaggi).WR302DM as TWA111FParMessaggiDM).selTabella.State in [dsEdit,dsInsert] then
      //dCmbFiltroAnagr.Field.Clear;
      ((Self.Owner as TWA111FParMessaggi).WR302DM as TWA111FParMessaggiDM).A111MW.selT291.FieldByName('FILTRO_ANAGR').AsString:='';
  end;
end;

procedure TWA111FParMessaggiDettFM.lnkFiltroAnagrClick(Sender: TObject);
begin
  inherited;
  if dgrpTipoFiltro.ItemIndex = 1 then
    TWR100FBase(Self.Parent).AccediForm(31,'NOME=' + dCmbFiltroAnagr.Text)
  else
  begin
    (Self.Owner as TWA111FParMessaggi).grdC700.actSelezioneAnagraficheExecute(Sender);
    (Self.Owner as TWA111FParMessaggi).grdC700.WC700FM.ApriSelezione(dcmbFiltroAnagr.Text);
  end;
end;

end.
