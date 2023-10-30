unit WS720UProfiliAreeDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit,
  medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  meIWLabel, IWDBStdCtrls, meIWDBLabel, meIWDBLookupComboBox, IWCompListbox, A000UInterfaccia, DB;

type
  TWS720FProfiliAreeDettFM = class(TWR205FDettTabellaFM)
    lblDato1: TmeIWLabel;
    lblDato2: TmeIWLabel;
    lblDato3: TmeIWLabel;
    lblDato4: TmeIWLabel;
    lblCodArea: TmeIWLabel;
    cmbDato1: TMedpIWMultiColumnComboBox;
    cmbDato2: TMedpIWMultiColumnComboBox;
    cmbDato3: TMedpIWMultiColumnComboBox;
    cmbDato4: TMedpIWMultiColumnComboBox;
    cmbCodiceArea: TMedpIWMultiColumnComboBox;
    dlblDescDato1: TmeIWDBLabel;
    dlblDescDato2: TmeIWDBLabel;
    dlblDescDato3: TmeIWDBLabel;
    dlblDescDato4: TmeIWDBLabel;
    dlblDescArea: TmeIWDBLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbDato1AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbDato2AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbDato3AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbDato4AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodiceAreaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    procedure GestioneInterfaccia;
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses WS720UProfiliAreeDM;

{$R *.dfm}

procedure TWS720FProfiliAreeDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  GestioneInterfaccia;
end;

procedure TWS720FProfiliAreeDettFM.GestioneInterfaccia;
begin
  with WR302DM do
  begin
    if selTabella.FieldByName('DESC_DATO1').Visible then
    begin
      lblDato1.Caption:=selTabella.FieldByName('DESC_DATO1').DisplayLabel;
    end
    else
    begin
      lblDato1.Caption:='Dato 1 non definito';
    end;
    if selTabella.FieldByName('DESC_DATO2').Visible then
    begin
      lblDato2.Caption:=selTabella.FieldByName('DESC_DATO2').DisplayLabel;
    end
    else
    begin
      lblDato2.Caption:='Dato 2 non definito';
    end;
    if selTabella.FieldByName('DESC_DATO3').Visible then
    begin
      lblDato3.Caption:=selTabella.FieldByName('DESC_DATO3').DisplayLabel;
    end
    else
    begin
      lblDato3.Caption:='Dato 3 non definito';
    end;
    if selTabella.FieldByName('DESC_DATO4').Visible then
    begin
      lblDato4.Caption:=selTabella.FieldByName('DESC_DATO4').DisplayLabel;
    end
    else
    begin
      lblDato4.Caption:='Dato 4 non definito';
    end;
  end;
end;

procedure TWS720FProfiliAreeDettFM.AbilitaComponenti;
begin
  with WR302DM do
  begin
    cmbDato1.Enabled:=selTabella.FieldByName('DATO1').Visible and (not selTabella.FieldByName('DATO1').ReadOnly);
    lblDato1.Enabled:=selTabella.FieldByName('DATO1').Visible;
    cmbDato2.Enabled:=selTabella.FieldByName('DATO2').Visible and (not selTabella.FieldByName('DATO2').ReadOnly);
    lblDato2.Enabled:=selTabella.FieldByName('DATO2').Visible;
    cmbDato3.Enabled:=selTabella.FieldByName('DATO3').Visible and (not selTabella.FieldByName('DATO3').ReadOnly);
    lblDato3.Enabled:=selTabella.FieldByName('DATO3').Visible;
    cmbDato4.Enabled:=selTabella.FieldByName('DATO4').Visible and (not selTabella.FieldByName('DATO4').ReadOnly);
    lblDato4.Enabled:=selTabella.FieldByName('DATO4').Visible;
    cmbCodiceArea.Enabled:=selTabella.FieldByName('COD_AREA').Visible and (not selTabella.FieldByName('COD_AREA').ReadOnly);
    lblCodArea.Enabled:=selTabella.FieldByName('COD_AREA').Visible;
  end;
end;

procedure TWS720FProfiliAreeDettFM.DataSet2Componenti;
begin
  inherited;
  cmbDato1.Text:=(WR302DM as TWS720FProfiliAreeDM).selTabella.FieldByName('DATO1').AsString;
  cmbDato2.Text:=(WR302DM as TWS720FProfiliAreeDM).selTabella.FieldByName('DATO2').AsString;
  cmbDato3.Text:=(WR302DM as TWS720FProfiliAreeDM).selTabella.FieldByName('DATO3').AsString;
  cmbDato4.Text:=(WR302DM as TWS720FProfiliAreeDM).selTabella.FieldByName('DATO4').AsString;
  cmbCodiceArea.Text:=(WR302DM as TWS720FProfiliAreeDM).selTabella.FieldByName('COD_AREA').AsString;
end;

procedure TWS720FProfiliAreeDettFM.Componenti2DataSet;
begin
  inherited;
  (WR302DM as TWS720FProfiliAreeDM).SelTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
  (WR302DM as TWS720FProfiliAreeDM).SelTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
  (WR302DM as TWS720FProfiliAreeDM).SelTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;
  (WR302DM as TWS720FProfiliAreeDM).SelTabella.FieldByName('DATO4').AsString:=cmbDato4.Text;
  (WR302DM as TWS720FProfiliAreeDM).SelTabella.FieldByName('COD_AREA').AsString:=cmbCodiceArea.Text;
end;

procedure TWS720FProfiliAreeDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWS720FProfiliAreeDM).S720FProfiliAreeMW do
  begin
    if selDato1.State <> dsInactive then
    begin
      selDato1.First;
      cmbDato1.Items.Clear;
      while not selDato1.Eof do
      begin
        cmbDato1.AddRow(selDato1.FieldByName('CODICE').AsString + ';' +
                        selDato1.FieldByName('DESCRIZIONE').AsString);
        selDato1.Next;
      end;
    end;
    if selDato2.State <> dsInactive then
    begin
      selDato2.First;
      cmbDato2.Items.Clear;
      while not selDato2.Eof do
      begin
        cmbDato2.AddRow(selDato2.FieldByName('CODICE').AsString + ';' +
                        selDato2.FieldByName('DESCRIZIONE').AsString);
        selDato2.Next;
      end;
    end;
    if selDato3.State <> dsInactive then
    begin
      selDato3.First;
      cmbDato3.Items.Clear;
      while not selDato3.Eof do
      begin
        cmbDato3.AddRow(selDato3.FieldByName('CODICE').AsString + ';' +
                        selDato3.FieldByName('DESCRIZIONE').AsString);
        selDato3.Next;
      end;
    end;
    if selDato4.State <> dsInactive then
    begin
      selDato4.First;
      cmbDato4.Items.Clear;
      while not selDato4.Eof do
      begin
        cmbDato4.AddRow(selDato4.FieldByName('CODICE').AsString + ';' +
                        selDato4.FieldByName('DESCRIZIONE').AsString);
        selDato4.Next;
      end;
    end;
    if selArea.State <> dsInactive then
    begin
      selArea.First;
      cmbCodiceArea.Items.Clear;
      while not selArea.Eof do
      begin
        cmbCodiceArea.AddRow(selArea.FieldByName('COD_AREA').AsString + ';' +
                             selArea.FieldByName('DESCRIZIONE').AsString);
        selArea.Next;
      end;
    end;
  end;
end;

procedure TWS720FProfiliAreeDettFM.cmbCodiceAreaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('COD_AREA').AsString:=cmbCodiceArea.Text;
end;

procedure TWS720FProfiliAreeDettFM.cmbDato1AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO1').AsString:=cmbDato1.Text;
end;

procedure TWS720FProfiliAreeDettFM.cmbDato2AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO2').AsString:=cmbDato2.Text;
end;

procedure TWS720FProfiliAreeDettFM.cmbDato3AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO3').AsString:=cmbDato3.Text;
end;

procedure TWS720FProfiliAreeDettFM.cmbDato4AsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('DATO4').AsString:=cmbDato4.Text;
end;
end.
