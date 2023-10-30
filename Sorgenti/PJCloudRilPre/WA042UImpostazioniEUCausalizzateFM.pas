unit WA042UImpostazioniEUCausalizzateFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompButton, meIWButton, IWDBStdCtrls, meIWDBLabel, IWCompEdit,
  medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel;

type
  TWA042FImpostazioniEUCausalizzateFM = class(TWR200FBaseFM)
    lblPresenza: TmeIWLabel;
    btnChiudi: TmeIWButton;
    cmbPresenza: TMedpIWMultiColumnComboBox;
    lblDescrizione: TmeIWLabel;
    btnConferma: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbPresenzaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    procedure AggiornaLabel;
    { Private declarations }
  public
    procedure Visualizza;
  end;


implementation

uses WR100UBase, WA042UStampaPreAss;

{$R *.dfm}

procedure TWA042FImpostazioniEUCausalizzateFM.btnChiudiClick(Sender: TObject);
begin
  if Sender = btnConferma then
    (Self.Owner as TWA042FStampaPreAss).A042MW.sPb_CausaleEU:=cmbPresenza.Text;
  ReleaseOggetti;
  Free;
end;

procedure TWA042FImpostazioniEUCausalizzateFM.cmbPresenzaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  AggiornaLabel;
end;

procedure TWA042FImpostazioniEUCausalizzateFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (Self.Owner as TWA042FStampaPreAss).A042MW.selT275 do
  begin
    Filter:= 'CODICE <> ''**NC**''';
    Filtered:=True;
    First;
    while not Eof do
    begin
      cmbPresenza.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    if SearchRecord('Codice', (Self.Owner as TWA042FStampaPreAss).A042MW.sPb_CausaleEU, [srFromBeginning]) then
      cmbPresenza.Text:=FieldByName('CODICE').AsString;
    AggiornaLabel;
  end;
end;

procedure TWA042FImpostazioniEUCausalizzateFM.AggiornaLabel;
begin
  lblDescrizione.Caption:='';
  if cmbPresenza.ItemIndex <> -1 then
    lblDescrizione.Caption:=cmbPresenza.Items[cmbPresenza.ItemIndex].RowData[1];
end;

procedure TWA042FImpostazioniEUCausalizzateFM.Visualizza;
begin
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,360,160,160,'(WA042) Impostazione causali di presenza','#WA042_ImpostazioniContaier',False,True);
end;

end.

