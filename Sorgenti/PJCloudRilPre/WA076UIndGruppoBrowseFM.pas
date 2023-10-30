unit WA076UIndGruppoBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR204UBrowseTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompGrids, IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, MedpIWMultiColumnComboBox, IWCompEdit,
  Vcl.Menus, WR102UGestTabella;

type
  TWA076FIndGruppoBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure grdTabellaDataSet2Componenti(Row: Integer);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    { Private declarations }
    procedure cmbCodiceChange(Sender: TObject; Index: Integer);
    procedure cmbCodice2Change(Sender: TObject; Index: Integer);
    procedure cmbIndennitaChange(Sender: TObject; Index: Integer);
  public
    { Public declarations }
  end;

implementation

uses WA076UIndGruppoDM;

{$R *.dfm}

procedure TWA076FIndGruppoBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with grdTabella do
  begin
    medpPreparaComponentiDefault;
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('CODICE'),0,DBG_MECMB,'10','2','null','','S');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('CODICE2'),0,DBG_MECMB,'10','2','null','','S');
    medpPreparaComponenteGenerico('WR102',medpIndexColonna('INDENNITA'),0,DBG_MECMB,'10','2','null','','S');
  end;
end;

procedure TWA076FIndGruppoBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
begin
  inherited;
  // Caricamento MultiColumnComboBox per la colonna CODICE
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE'),0) <> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso)  then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE'),0)as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      //OnChange:=cmbCodiceChange;
      Text:=grdTabella.medpValoreColonna(Row, 'CODICE');
      with TWA076FIndGruppoDM(WR302DM).A076MW.selCodice1 do
      begin
        First;
        while not Eof do
        begin
          AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
      end;
    end;
  // Caricamento MultiColumnComboBox per la colonna CODICE2
  if (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE2'),0) <> nil) and
     (not (Self.Owner as TWR102FGestTabella).InterfacciaWR102.StoricizzazioneInCorso) then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('CODICE2'),0)as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      //OnChange:=cmbCodice2Change;
      Text:=grdTabella.medpValoreColonna(Row, 'CODICE2');
      with TWA076FIndGruppoDM(WR302DM).A076MW.selCodice2 do
      begin
        First;
        while not Eof do
        begin
          AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
      end;
    end;
  // Caricamento MultiColumnComboBox per la colonna INDENNITA
  if grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INDENNITA'),0) <> nil then
    with (grdTabella.medpCompCella(Row,grdTabella.medpIndexColonna('INDENNITA'),0)as TMedpIWMultiColumnComboBox) do
    begin
      Items.Clear;
      PopUpHeight:=20;
      LookupColumn:=1;
      //OnChange:=cmbIndennitaChange;
      Text:=grdTabella.medpValoreColonna(Row, 'INDENNITA');
      with TWA076FIndGruppoDM(WR302DM).A076MW.Q163 do
      begin
        First;
        while not Eof do
        begin
          AddRow(Format('%s;%s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
          Next;
        end;
      end;
    end;
end;

procedure TWA076FIndGruppoBrowseFM.cmbIndennitaChange(Sender: TObject;Index: Integer);
begin
  // Viene aggiornato il field descrizione corrispondente al codice selezionato
  with TWA076FIndGruppoDM(WR302DM) do
  begin
    selTabella.FieldByName('INDENNITA').Value:=(Sender as TMedpIWMultiColumnComboBox).Items[Index].RowData[0];
    with grdTabella.medpClientDataSet do
    begin
      Edit;
      FieldByName('D_INDENNITA').Value:=selTabella.FieldByName('D_INDENNITA').Value;
      Post;
    end;
  end;
end;

procedure TWA076FIndGruppoBrowseFM.cmbCodiceChange(Sender: TObject;Index: Integer);
begin
  // Viene aggiornato il field descrizione corrispondente al codice selezionato
  with TWA076FIndGruppoDM(WR302DM) do
  begin
    selTabella.FieldByName('CODICE').Value:=(Sender as TMedpIWMultiColumnComboBox).Items[Index].RowData[0];
    with grdTabella.medpClientDataSet do
    begin
      Edit;
      FieldByName('D_DESCCODICE').Value:=selTabella.FieldByName('D_DESCCODICE').Value;
      Post;
    end;
  end;
end;

procedure TWA076FIndGruppoBrowseFM.cmbCodice2Change(Sender: TObject;Index: Integer);
begin
  // Viene aggiornato il field descrizione corrispondente al codice selezionato
  with TWA076FIndGruppoDM(WR302DM) do
  begin
    selTabella.FieldByName('CODICE2').Value:=(Sender as TMedpIWMultiColumnComboBox).Items[Index].RowData[0];
    with grdTabella.medpClientDataSet do
    begin
      Edit;
      FieldByName('D_DESCCODICE2').Value:=selTabella.FieldByName('D_DESCCODICE2').Value;
      Post;
    end;
  end;
end;

end.
