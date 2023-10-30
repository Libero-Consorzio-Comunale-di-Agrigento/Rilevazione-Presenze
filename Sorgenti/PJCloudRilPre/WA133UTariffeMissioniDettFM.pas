unit WA133UTariffeMissioniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit,
  medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, WA133UTariffeMissioniDM, IWDBStdCtrls,
  meIWDBLabel, meIWDBEdit;

type
  TWA133FTariffeMissioniDettFM = class(TWR205FDettTabellaFM)
    lblCodContratto: TmeIWLabel;
    cmbCodice: TMedpIWMultiColumnComboBox;
    dlblDTrasferta: TmeIWDBLabel;
    lblCodPosizioneEconomica: TmeIWLabel;
    dedtIndGiornaliera: TmeIWDBEdit;
    lblCodiciVocePaghe: TmeIWLabel;
    lblCategoriaEconomica: TmeIWLabel;
    dEdtCodVoceEsente: TmeIWDBEdit;
    lblSoggettoTassazione: TmeIWLabel;
    dEdtCodVoceAssog: TmeIWDBEdit;
    lblCodLivello: TmeIWLabel;
    dedtCodTariffa: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    procedure cmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
  private
    { Private declarations }
  public
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
  end;

implementation

{$R *.dfm}

{ TWA133FTariffeMissioniDettFM }

procedure TWA133FTariffeMissioniDettFM.CaricaMultiColumnCombobox;
begin
  with (WR302DM as TWA133FTariffeMissioniDM).A133FTariffeMissioniMW do
  begin
    QSource.First;
    cmbCodice.Items.Clear;
    while not QSource.Eof do
    begin
      cmbCodice.AddRow(QSource.FieldByName('CODICE').AsString + ';' +
                       QSource.FieldByName('DESCRIZIONE').AsString);
      QSource.Next;
    end;
  end;
end;

procedure TWA133FTariffeMissioniDettFM.cmbCodiceAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  WR302DM.selTabella.FieldByName('CODICE').AsString:=cmbCodice.Text;
  //Aggiorna DBLabel
end;

procedure TWA133FTariffeMissioniDettFM.DataSet2Componenti;
begin
  inherited;
  with WR302DM.selTabella do
  begin
    cmbCodice.Text:=FieldByName('CODICE').AsString;
  end;
end;

end.
