unit WS730UPunteggiValutazioniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, medpIWMultiColumnComboBox,
  IWCompCheckbox, IWDBStdCtrls, meIWDBCheckBox, IWCompLabel, meIWLabel,
  meIWDBEdit, IWCompText, meIWDBText, meIWDBLabel, Data.Db;

type
  TWS730FPunteggiValutazioniDettFM = class(TWR205FDettTabellaFM)
    dcmbDato1: TMedpIWMultiColumnComboBox;
    dchkCalcoloPFP: TmeIWDBCheckBox;
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    lblPunteggio: TmeIWLabel;
    dedtPunteggio: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    lblDescrizione: TmeIWLabel;
    lblDato1: TmeIWLabel;
    dchkItemGiudicabile: TmeIWDBCheckBox;
    dchkGiustifica: TmeIWDBCheckBox;
    lblDescDato1: TmeIWDBLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dchkCalcoloPFPClick(Sender: TObject);
    procedure dcmbDato1AsyncChange(Sender: TObject;
      EventParams: TStringList; Index: Integer; Value: string);
  private
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  public
    procedure AbilitaComponenti; override;
  end;

implementation

{$R *.dfm}

uses WS730UPunteggiValutazioniDM;

procedure TWS730FPunteggiValutazioniDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWS730FPunteggiValutazioniDM).S730FPunteggiValutazioniMW do
  begin
    selDato1.First;
    dCmbDato1.Items.Clear;
    while not selDato1.Eof do
    begin
      dCmbDato1.AddRow(selDato1.FieldByName('CODICE').AsString + ';' +
                         selDato1.FieldByName('DESCRIZIONE').AsString);
      selDato1.Next;
    end;
  end;
end;

procedure TWS730FPunteggiValutazioniDettFM.DataSet2Componenti;
begin
  with TWS730FPunteggiValutazioniDM(WR302DM) do
  begin
    dCmbDato1.Text:=selTabella.FieldByName('DATO1').AsString;
  end;
end;

procedure TWS730FPunteggiValutazioniDettFM.dchkCalcoloPFPClick(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
end;

procedure TWS730FPunteggiValutazioniDettFM.dcmbDato1AsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer;
  Value: string);
begin
  with TWS730FPunteggiValutazioniDM(WR302DM) do
  begin
    selTabella.FieldByName('DATO1').AsString:=dCmbDato1.Text;
  end;
end;

procedure TWS730FPunteggiValutazioniDettFM.Componenti2DataSet;
begin
  with TWS730FPunteggiValutazioniDM(WR302DM) do
  begin
    selTabella.FieldByName('DATO1').AsString:=dCmbDato1.Text;
  end;
end;

procedure TWS730FPunteggiValutazioniDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  lblDato1.Caption:=(WR302DM as TWS730FPunteggiValutazioniDM).selTabella.FieldByName('DATO1').DisplayLabel;
end;

procedure TWS730FPunteggiValutazioniDettFM.AbilitaComponenti;
begin
  inherited;
  lblPunteggio.Visible:=(WR302DM as TWS730FPunteggiValutazioniDM).selTabella.FieldByName('CALCOLO_PFP').AsString = 'S';
  dedtPunteggio.Visible:=lblPunteggio.Visible;
end;

end.
