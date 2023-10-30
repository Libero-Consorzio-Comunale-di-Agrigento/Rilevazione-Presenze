unit WA039URegReperibDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Db,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
   IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
   IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, IWCompExtCtrls, IWDBExtCtrls,
   meIWDBRadioGroup, IWCompCheckbox, meIWDBCheckBox, IWCompListbox, meIWDBComboBox;

type
  TWA039FRegReperibDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    drgpTipologia: TmeIWDBRadioGroup;
    lblOraInizio: TmeIWLabel;
    dedtOraInizio: TmeIWDBEdit;
    lblOraFine: TmeIWLabel;
    dedtOraFine: TmeIWDBEdit;
    lblDurata: TmeIWLabel;
    dedtTurnoIntero: TmeIWDBEdit;
    drgpTipoTurno: TmeIWDBRadioGroup;
    lblTipologia: TmeIWLabel;
    lblTipoTurno: TmeIWLabel;
    drgpTipoOre: TmeIWDBRadioGroup;
    lblSuddivisioneOre: TmeIWLabel;
    dedtOreNormali: TmeIWDBEdit;
    lblVociPaghe: TmeIWLabel;
    lblTurniInteri: TmeIWLabel;
    dedtVpTurno: TmeIWDBEdit;
    dedtVpOre: TmeIWDBEdit;
    lblOre: TmeIWLabel;
    dedtVpMaggiorate: TmeIWDBEdit;
    lblOreMaggiorate: TmeIWLabel;
    dedtVpNonMaggiorate: TmeIWDBEdit;
    lblOreNonMaggiorate: TmeIWLabel;
    dedtVpGettoneChiamata: TmeIWDBEdit;
    lblGettoneChiamata: TmeIWLabel;
    dedtVpMaxMese: TmeIWDBEdit;
    lblTurniEccedenti: TmeIWLabel;
    lblLimiteMensile: TmeIWLabel;
    lblPianifMaxMese: TmeIWLabel;
    dedtPianifMaxMese: TmeIWDBEdit;
    dchkBloccaMaxMese: TmeIWDBCheckBox;
    dchkPianifMaxMeseTurniInteri: TmeIWDBCheckBox;
    dchkDetrazMensa: TmeIWDBCheckBox;
    dchkOreNonCaus: TmeIWDBCheckBox;
    lblTolleranza: TmeIWLabel;
    dedtTolleranza: TmeIWDBEdit;
    lblOreCompresenza: TmeIWLabel;
    dedtCompresenza: TmeIWDBEdit;
    lblOreMinIndennita: TmeIWLabel;
    dedtOreMinIndennita: TmeIWDBEdit;
    lblCampoAnagrafico: TmeIWLabel;
    dcmbCampiAnagra: TmeIWDBComboBox;
    lblTollChiamataInizio: TmeIWLabel;
    dedtTollChiamataInizio: TmeIWDBEdit;
    lblTollChiamata: TmeIWLabel;
    lblTollChiamataInizio2: TmeIWLabel;
    lblTollChiamataFine: TmeIWLabel;
    dedtTollChiamataFine: TmeIWDBEdit;
    lblTollChiamataFine2: TmeIWLabel;
    lblSigla: TmeIWLabel;
    dedtSigla: TmeIWDBEdit;
    procedure drgpTipologiaClick(Sender: TObject);
    procedure dedtOraInizioAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure drgpTipoTurnoClick(Sender: TObject);
    procedure drgpTipoOreClick(Sender: TObject);
    procedure dedtPianifMaxMeseAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA039URegreperib, WA039URegreperibDM;

{$R *.dfm}

procedure TWA039FRegReperibDettFM.dedtOraInizioAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella do
    if (State in [dsEdit,dsInsert]) and (Trim((Sender as TmeIWDBEdit).Text) = '.') then
      FieldByName((Sender as TmeIWDBEdit).DataField).Clear;
end;

procedure TWA039FRegReperibDettFM.dedtPianifMaxMeseAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if (Sender as TmeIWDBEdit).Text <> '' then
  begin
    dchkPianifMaxMeseTurniInteri.Enabled:=True;
    dchkBloccaMaxMese.Enabled:=True;
    if ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').IsNull then
      ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').AsString:='N';
  end
  else
  begin
    dchkPianifMaxMeseTurniInteri.Enabled:=False;
    dchkBloccaMaxMese.Enabled:=False;
    ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella.FieldByName('PIANIF_MAX_MESE_TURNI_INTERI').Value:=null;
  end;
end;

procedure TWA039FRegReperibDettFM.drgpTipologiaClick(Sender: TObject);
begin
  inherited;
  lblDurata.Enabled:=drgpTipologia.ItemIndex = 0;
  dEdtTurnoIntero.Enabled:=drgpTipologia.ItemIndex = 0;
  drgpTipoOre.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtOreNormali.Enabled:=(drgpTipologia.ItemIndex = 0) and (drgpTipoOre.ItemIndex = 2);
  drgpTipoTurno.Enabled:=drgpTipologia.ItemIndex = 0;
  lblTurniInteri.Enabled:=drgpTipologia.ItemIndex = 0;
  lblOre.Enabled:=drgpTipologia.ItemIndex = 0;
  lblOreMaggiorate.Enabled:=drgpTipologia.ItemIndex = 0;
  lblOreNonMaggiorate.Enabled:=drgpTipologia.ItemIndex = 0;
  lblGettoneChiamata.Enabled:=drgpTipologia.ItemIndex = 0;
  lblTurniEccedenti.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtVpTurno.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtVpOre.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtVpMaggiorate.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtVpNonMaggiorate.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtVpGettoneChiamata.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtVpMaxMese.Enabled:=drgpTipologia.ItemIndex = 0;
  dEdtVpTurno.Enabled:=drgpTipologia.ItemIndex = 0;
  dEdtVpOre.Enabled:=drgpTipologia.ItemIndex = 0;
  dEdtVpMaggiorate.Enabled:=drgpTipologia.ItemIndex = 0;
  dEdtVpNonMaggiorate.Enabled:=drgpTipologia.ItemIndex = 0;
  dchkDetrazMensa.Enabled:=drgpTipologia.ItemIndex = 0;
  dchkOreNonCaus.Enabled:=drgpTipologia.ItemIndex = 0;
  lblTolleranza.Enabled:=drgpTipologia.ItemIndex = 0;
  lblOreCompresenza.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtTolleranza.Enabled:=drgpTipologia.ItemIndex = 0;
  dedtCompresenza.Enabled:=drgpTipologia.ItemIndex = 0;
  lblCampoAnagrafico.Enabled:=drgpTipologia.ItemIndex = 0;
  dcmbCampiAnagra.Enabled:=drgpTipologia.ItemIndex = 0;
  dchkPianifMaxMeseTurniInteri.Enabled:=(dedtPianifMaxMese.Enabled) and (dedtPianifMaxMese.Text <> '');
end;

procedure TWA039FRegReperibDettFM.drgpTipoOreClick(Sender: TObject);
begin
  inherited;
  case drgpTipoOre.ItemIndex of
    0,1:begin
          if ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella.State in [dsInsert,dsEdit] then
            ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella.FieldByName(dedtOreNormali.DataField).Clear;
          dedtOreNormali.Enabled:=False;
        end;
    2:dedtOreNormali.Enabled:=True;
  end;
end;

procedure TWA039FRegReperibDettFM.drgpTipoTurnoClick(Sender: TObject);
var Abilitato:Boolean;
begin
  case drgpTipoTurno.ItemIndex of
    0:Abilitato:=False;
    1..2:Abilitato:=True;
  else
    Abilitato:=False;
  end;
  with ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella do
  begin
    if (State in [dsEdit,dsInsert]) and (not Abilitato) then
      FieldByName(dcmbCampiAnagra.DataField).Clear;
    if (((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).SelTabella.State in [dsEdit,dsInsert]) and Abilitato then
      FieldByName(dedtCompresenza.DataField).Clear;
  end;
  lblOreCompresenza.Enabled:=(drgpTipologia.ItemIndex = 0) and (not Abilitato);
  dedtCompresenza.Enabled:=(drgpTipologia.ItemIndex = 0) and (not Abilitato);
  dcmbCampiAnagra.Enabled:=Abilitato;
end;


procedure TWA039FRegReperibDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with ((Self.Owner as TWA039FRegreperib).WR302DM as TWA039FRegreperibDM).A039MW.QCols do
  begin
    First;
    while not Eof do
    begin
      dcmbCampiAnagra.Items.Add(FieldByName('COLUMN_NAME').AsString);
      Next;
    end;
  end;
end;

end.
