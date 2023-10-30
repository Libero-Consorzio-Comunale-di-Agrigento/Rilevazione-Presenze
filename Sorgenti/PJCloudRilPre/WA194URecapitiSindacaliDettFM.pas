unit WA194URecapitiSindacaliDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompListbox, IWDBStdCtrls,
  meIWDBComboBox, IWCompEdit, meIWDBEdit, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel, DB,
  C180FunzioniGenerali, IWCompButton, meIWButton, meIWEdit, IWHTMLControls,
  meIWLink, UIntfWebT480;

type
  TWA194FRecapitiSindacaliDettFM = class(TWR205FDettTabellaFM)
    lblCodice: TmeIWLabel;
    dedtCodice: TmeIWDBEdit;
    lblTipo: TmeIWLabel;
    dcmbTipo: TmeIWDBComboBox;
    dedtProgressivo: TmeIWDBEdit;
    lblProgressivo: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblIndirizzo: TmeIWLabel;
    dedtIndirizzo: TmeIWDBEdit;
    lblTelefono: TmeIWLabel;
    dedtTelefono: TmeIWDBEdit;
    dedtComune: TmeIWDBEdit;
    lblCap: TmeIWLabel;
    dedtCap: TmeIWDBEdit;
    lblProv: TmeIWLabel;
    lnkDescrComune: TmeIWLink;
    edtDescComune: TmeIWEdit;
    btnComune: TmeIWButton;
    lblFax: TmeIWLabel;
    dedtFax: TmeIWDBEdit;
    dedtProv: TmeIWDBEdit;
    lblCognome: TmeIWLabel;
    dedtCognome: TmeIWDBEdit;
    lblNome: TmeIWLabel;
    dedtNome: TmeIWDBEdit;
    lblEMail: TmeIWLabel;
    dedtEMail: TmeIWDBEdit;
    lblTelCasa: TmeIWLabel;
    dedtTelCasa: TmeIWDBEdit;
    lblTelUfficio: TmeIWLabel;
    dedtTelUfficio: TmeIWDBEdit;
    lblCellulare: TmeIWLabel;
    dedtCellulare: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure lnkDescrComuneClick(Sender: TObject);
    procedure dcmbTipoChange(Sender: TObject);
  private
    { Private declarations }
    IntfWebT480:TIntfWebT480;
    procedure DataSet2Componenti; override;
    procedure ReleaseOggetti; override;
  public
    { Public declarations }
  end;

implementation

uses WA194URecapitiSindacaliDM, WR100UBase;

{$R *.dfm}

procedure TWA194FRecapitiSindacaliDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  R180SetComboItemsValues(dcmbTipo.Items,(WR302DM as TWA194FRecapitiSindacaliDM).A121MW.D_TipoRecapito,'IV');
  inherited;
  IntfWebT480:=TIntfWebT480.Create(Self.Parent);
  with IntfWebT480 do
  begin
    DataSource:=(WR302DM as TWA194FRecapitiSindacaliDM).A121MW.dsrT480;
    edtCitta:=edtDescComune;
    dedtCodice:=dedtComune;
    dedtCap:=Self.dedtCap;
    btnLookup:=btnComune;
  end;
end;

procedure TWA194FRecapitiSindacaliDettFM.lnkDescrComuneClick(Sender: TObject);
begin
  (Self.Owner as TWR100FBase).AccediForm(530,'CODICE=' + dedtComune.Text);//EntiLocali
end;

procedure TWA194FRecapitiSindacaliDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(IntfWebT480);
end;

procedure TWA194FRecapitiSindacaliDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWA194FRecapitiSindacaliDM) do
    edtDescComune.Text:=selTabella.FieldByName('CITTA').AsString;
end;

procedure TWA194FRecapitiSindacaliDettFM.dcmbTipoChange(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA194FRecapitiSindacaliDM) do
    if SelTabella.State = dsInsert then
    begin
      A121MW.selT241MaxProg.SetVariable('CODICE',Sindacato);
      A121MW.selT241MaxProg.SetVariable('TIPO',dCmbTipo.Items.ValueFromIndex[dCmbTipo.ItemIndex]);
      A121MW.selT241MaxProg.Execute;
      SelTabella.FieldByName('PROG_RECAPITO').AsString:=IntToStr(StrToIntDef(VarToStr(A121MW.selT241MaxProg.Field(0)),0) + 1);
    end;
end;

end.
