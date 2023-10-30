unit WA053USquadreDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, StdCtrls, Mask, DBCtrls, IWCompEdit,
  IWDBStdCtrls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,A000UInterfaccia,
  C180FunzioniGenerali, meIWDBEdit, meIWLabel, IWCompListbox, meIWDBLookupComboBox, medpIWMultiColumnComboBox;

type
  TWA053FSquadreDettFM = class(TWR205FDettTabellaFM)
    lblTurno1: TmeIWLabel;
    lblFerTurno1: TmeIWLabel;
    lblFestTurno1: TmeIWLabel;
    lblMinimo: TmeIWLabel;
    lblMassimo: TmeIWLabel;
    dedtTotmin1: TmeIWDBEdit;
    dedtFesmin1: TmeIWDBEdit;
    dedtTotmax1: TmeIWDBEdit;
    dedtFesmax1: TmeIWDBEdit;
    lblTurno2: TmeIWLabel;
    lblFerTurno2: TmeIWLabel;
    lblFestTurno2: TmeIWLabel;
    dedtTotmin2: TmeIWDBEdit;
    dedtFesmin2: TmeIWDBEdit;
    dedtTotmax2: TmeIWDBEdit;
    dedtFesmax2: TmeIWDBEdit;
    lblTurno3: TmeIWLabel;
    lblFerTurno3: TmeIWLabel;
    lblFestTurno3: TmeIWLabel;
    dedtTotmin3: TmeIWDBEdit;
    dedtFesmin3: TmeIWDBEdit;
    dedtTotmax3: TmeIWDBEdit;
    dedtFesmax3: TmeIWDBEdit;
    lblTurno4: TmeIWLabel;
    lblFerTurno4: TmeIWLabel;
    lblFestTurno4: TmeIWLabel;
    dedtTotmin4: TmeIWDBEdit;
    dedtFesmin4: TmeIWDBEdit;
    dedtTotmax4: TmeIWDBEdit;
    dedtFesmax4: TmeIWDBEdit;
    lblLimitiOperatori: TmeIWLabel;
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtDescrizioneLunga: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    dEdtCodice: TmeIWDBEdit;
    lblCausaleCompetenzeRiposo: TmeIWLabel;
    lblFestMensiliMinime: TmeIWLabel;
    dedtMinFestMese: TmeIWDBEdit;
    lblPrioritaVerificaTurni: TmeIWLabel;
    dedtPrioritaMinMax: TmeIWDBEdit;
    lblControlliPeriodo: TmeIWLabel;
    lblMinInd1: TmeIWLabel;
    dedtMinInd1: TmeIWDBEdit;
    lblMinInd2: TmeIWLabel;
    dedtMinInd2: TmeIWDBEdit;
    lblMinInd3: TmeIWLabel;
    dedtMinInd3: TmeIWDBEdit;
    lblMinInd4: TmeIWLabel;
    dedtMinInd4: TmeIWDBEdit;
    dedtMaturazIndennita: TmeIWDBEdit;
    lblMaturazIndennita: TmeIWLabel;
    cmbCausComp: TMedpIWMultiColumnComboBox;
    lblDescrCausaleCompetenzeRiposo: TmeIWLabel;
    lblMaxNottiMese: TmeIWLabel;
    edtMaxNottiMese: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure cmbCausCompAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnComboBox; override;
  end;


implementation

uses WA053USquadreDM;

{$R *.dfm}

procedure TWA053FSquadreDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  //attivazione gestione Tab JQuery
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);
end;

procedure TWA053FSquadreDettFM.DataSet2Componenti;
begin
  inherited;
  cmbCausComp.ItemIndex:=-1;
  with TWA053FSquadreDM(WR302DM) do
  begin
    cmbCausComp.Text:=selTabella.FieldByName('CAUS_RIPOSO').AsString;
    lblDescrCausaleCompetenzeRiposo.Caption:=VarToStr(selT265.LookUp('CODICE', selTabella.FieldByName('CAUS_RIPOSO').AsString, 'DESCRIZIONE'));
  end;
end;


procedure TWA053FSquadreDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with  TWA053FSquadreDM(WR302DM).selT265 do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      cmbCausComp.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA053FSquadreDettFM.cmbCausCompAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA053FSquadreDM(WR302DM) do
  begin
    if Index <> -1 then
    begin
      selTabella.FieldByName('CAUS_RIPOSO').AsString:=cmbCausComp.Text;
      lblDescrCausaleCompetenzeRiposo.Caption:=VarToStr(selT265.LookUp('CODICE', selTabella.FieldByName('CAUS_RIPOSO').AsString, 'DESCRIZIONE'));
    end
    else
    begin
      selTabella.FieldByName('CAUS_RIPOSO').AsString:='';
      lblDescrCausaleCompetenzeRiposo.Caption:='';
    end;
  end;
end;

procedure TWA053FSquadreDettFM.Componenti2DataSet;
begin
  inherited;
  with TWA053FSquadreDM(WR302DM) do
    selTabella.FieldByName('CAUS_RIPOSO').AsString:=cmbCausComp.Text;
end;
end.
