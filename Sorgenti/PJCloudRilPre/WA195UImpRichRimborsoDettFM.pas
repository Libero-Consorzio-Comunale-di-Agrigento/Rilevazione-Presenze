unit WA195UImpRichRimborsoDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompCheckbox, meIWDBCheckBox, DB, IWCompListbox,
  meIWDBComboBox, IWCompMemo, meIWDBMemo, WA195UImpRichRimborsoDM, meIWEdit,
  IWCompGrids, IWDBGrids, medpIWDBGrid;

type
  TWA195FImpRichRimborsoDettFM = class(TWR205FDettTabellaFM)
    lblNome: TmeIWLabel;
    dedtNome: TmeIWDBEdit;
    lblMatricola: TmeIWLabel;
    dedtMatricola: TmeIWDBEdit;
    dchkIspettiva: TmeIWDBCheckBox;
    lblDestinazione: TmeIWLabel;
    dedtDestinazione: TmeIWDBEdit;
    lblLocalita: TmeIWLabel;
    dedtLocalita: TmeIWDBEdit;
    lblDal: TmeIWLabel;
    dedtDal: TmeIWDBEdit;
    lblDalle: TmeIWLabel;
    dedtDalle: TmeIWDBEdit;
    lblAl: TmeIWLabel;
    dedtAl: TmeIWDBEdit;
    lblAlle: TmeIWLabel;
    dedtAlle: TmeIWDBEdit;
    lblProtocollo: TmeIWLabel;
    dedtProtocollo: TmeIWDBEdit;
    dedtCodRimb: TmeIWDBEdit;
    lblCodRimb: TmeIWLabel;
    dedtVoceRimb: TmeIWDBEdit;
    lblVoceRimb: TmeIWLabel;
    dedtKM: TmeIWDBEdit;
    lblKM: TmeIWLabel;
    dedtKMRimborsati: TmeIWDBEdit;
    lblKMRimborsati: TmeIWLabel;
    dedtValuta: TmeIWDBEdit;
    lblValuta: TmeIWLabel;
    dedtRichiesta: TmeIWDBEdit;
    lblRichiesta: TmeIWLabel;
    dedtRimborso: TmeIWDBEdit;
    lblRimborso: TmeIWLabel;
    dcmbStato: TmeIWDBComboBox;
    lblStato: TmeIWLabel;
    lblNote: TmeIWLabel;
    lblSedeLavoro: TmeIWLabel;
    dedtSedeLavoro: TmeIWDBEdit;
    lblComuneResidenza: TmeIWLabel;
    dedtComuneResidenza: TmeIWDBEdit;
    lblMotivazioni: TmeIWLabel;
    dgrdMotivazioni: TmedpIWDBGrid;
    lblMezzi: TmeIWLabel;
    dgrdMezzi: TmedpIWDBGrid;
    dmemNote: TmeIWDBMemo;
    dgrdDettaglioGG: TmedpIWDBGrid;
    lblDettaglioGG: TmeIWLabel;
    dedtComuneDom: TmeIWDBEdit;
    lblComuneDom: TmeIWLabel;
    procedure dedtKMRimborsatiAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure renderGrid(ACell: TIWGridCell; const ARow, AColumn: Integer);
  public
    procedure AbilitaComponenti; override;
    procedure Dataset2Componenti; override;
  end;

implementation

uses WA195UImpRichRimborso, A000UInterfaccia;

{$R *.dfm}

{ TWA195FImpRichRimborsoDettFM }
procedure TWA195FImpRichRimborsoDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA195FImpRichRimborsoDM) do
  begin
    dgrdMotivazioni.medpAttivaGrid(A100FImpRimborsiIterMW.selM175,False,False,False);
    dgrdMezzi.medpAttivaGrid(A100FImpRimborsiIterMW.selM170,False,False,False);
    // CUNEO_ASLCN1 - chiamata 88143.ini
    dgrdDettaglioGG.medpAttivaGrid(A100FImpRimborsiIterMW.selM143,False,False,False);
    // CUNEO_ASLCN1 - chiamata 88143.fine
  end;

  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);
end;

procedure TWA195FImpRichRimborsoDettFM.renderGrid(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
var
  Agrid: TmedpIWDBGrid;
begin
  inherited;
  Agrid:=TmedpIWDBGrid(ACell.Grid);
  if not Agrid.medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

procedure TWA195FImpRichRimborsoDettFM.AbilitaComponenti;
var IndKm: boolean;
begin
  inherited;
  with (Self.Parent as TWA195FImpRichRimborso) do
  begin
    abilitaPulsanti;
  end;
  with WR302DM do
  begin
    if (selTabella.State in [dsEdit,dsInsert]) then
    begin
      dedtNome.Enabled:=False;
      dedtMatricola.Enabled:=False;
      dedtSedeLavoro.Enabled:=False;
      dedtComuneResidenza.Enabled:=False;
      // CUNEO_ASLCN1 - chiamata 88143.ini
      dedtComuneDom.Enabled:=False;
      // CUNEO_ASLCN1 - chiamata 88143.fine
      dchkIspettiva.Enabled:=False;
      dedtDestinazione.Enabled:=False;
      dedtLocalita.Enabled:=False;
      dedtDal.Enabled:=False;
      dedtDalle.Enabled:=False;
      dedtAl.Enabled:=False;
      dedtAlle.Enabled:=False;
      dedtProtocollo.Enabled:=False;
      dedtCodRimb.Enabled:=False;
      dedtVoceRimb.Enabled:=False;
      dedtKM.Enabled:=False;
      dedtValuta.Enabled:=False;
      dedtRichiesta.Enabled:=False;
      IndKm:=selTabella.FieldByName('INDENNITA_KM').AsString = 'S';
      dedtRimborso.ReadOnly:=IndKm;
      dedtKMRimborsati.ReadOnly:=not IndKm;
      if not IndKm then
      begin
        selTabella.FieldByName('KMPERCORSI').Text:='';
        selTabella.FieldByName('KMPERCORSI_VARIATO').Text:='';
      end;
    end;
  end;
end;

procedure TWA195FImpRichRimborsoDettFM.Dataset2Componenti;
begin
  inherited;
  if dgrdMotivazioni.medpClientDataSet <> nil then
    dgrdMotivazioni.medpAggiornaCDS(True);
  if dgrdMezzi.medpClientDataSet <> nil then
    dgrdMezzi.medpAggiornaCDS(True);
end;

procedure TWA195FImpRichRimborsoDettFM.dedtKMRimborsatiAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  //in cloud evento validate non associato al campo del dataset. richiamato direttamente
  //l'evento async non attende la fine dell'evento validate del campo. perciò non legato e richiamato
  (WR302DM as TWA195FImpRichRimborsoDM).A100FImpRimborsiIterMW.KMPERCORSI_VARIATOValidate
end;

end.
