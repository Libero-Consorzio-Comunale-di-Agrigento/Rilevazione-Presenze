unit WA143UMedicineLegaliDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OracleData, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompLabel,Db, meIWLabel, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWMultiColumnComboBox, IWCompExtCtrls,
  meIWImageFile, meIWEdit, IWCompButton, meIWButton, UIntfWebT480,
  C180FunzioniGenerali, WR205UDettTabellaFM,
  IWHTMLControls, meIWLink,WA011UEntiLocali,WR100UBase,A000UInterfaccia;

type
  TWA143FMedicineLegaliDettFM = class(TWR205FDettTabellaFM)
    dedtEmail: TmeIWDBEdit;
    dedtTelefono: TmeIWDBEdit;
    dedtCap: TmeIWDBEdit;
    dedtIndirizzo: TmeIWDBEdit;
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    lblIndirizzo: TmeIWLabel;
    lblCap: TmeIWLabel;
    lblTelefono: TmeIWLabel;
    lblEmail: TmeIWLabel;
    dedtComune: TmeIWDBEdit;
    btnComuni: TmeIWButton;
    edtDescComune: TmeIWEdit;
    dedDescrizione: TmeIWDBEdit;
    lnkComuni: TmeIWLink;
    lblCodComune: TmeIWLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure lnkComuniClick(Sender: TObject);
  private
    { Private declarations }
    IntfWebT480:TIntfWebT480;
    procedure DataSet2Componenti; override;
    procedure Componenti2Dataset; override;
    procedure ReleaseOggetti; override;
  public
    { Public declarations }
  end;

implementation

uses WA143UMedicineLegali, WA143UMedicineLegaliDM;

{$R *.dfm}

procedure TWA143FMedicineLegaliDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    DataSource:=(WR302DM as TWA143FMedicineLegaliDM).dsrT480;
    edtCitta:=edtDescComune;
    dedtCodice:=dedtComune;
    dedtCap:=Self.dedtCap;
    btnLookup:=btnComuni;
  end;
  DataSet2Componenti;
end;

procedure TWA143FMedicineLegaliDettFM.lnkComuniClick(Sender: TObject);
begin
  TWR100FBase(Self.Parent).AccediForm(530,'CODICE=' + TWA143FMedicineLegaliDM(WR302DM).selT480.FieldByName('CODICE').AsString);
end;

procedure TWA143FMedicineLegaliDettFM.DataSet2Componenti;
begin
   inherited;
   edtDescComune.Text:='';
    with TWA143FMedicineLegaliDM(WR302DM) do
      if selT480.SearchRecord('CODICE',selTabella.FieldByName('COD_COMUNE').AsString,[srFromBeginning]) then
        edtDescComune.Text:=selT480.FieldByName('CITTA').AsString;
end;

procedure TWA143FMedicineLegaliDettFM.Componenti2DataSet;
begin
   inherited;
end;

procedure TWA143FMedicineLegaliDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(IntfWebT480);
end;

end.
