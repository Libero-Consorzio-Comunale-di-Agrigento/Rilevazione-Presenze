unit WA131UCollegMissioniFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompListbox, meIWListbox, WC013UCheckListFM, WA131UGestioneAnticipiDM,
  IWCompEdit, medpIWMultiColumnComboBox, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWCompExtCtrls, meIWImageFile, medpIWImageButton, WR102UGestTabella,
  A000UMessaggi, A000UInterfaccia, WC010UMemoEditFM, medpIWMessageDlg;

type
  TWA131FCollegMissioniFM = class(TWR200FBaseFM)
    lstAnticipi: TmeIWListbox;
    btnElencoAnticipi: TmeIWButton;
    lblAnticipiSospesi: TmeIWLabel;
    lblDataMiss: TmeIWLabel;
    lblCassa: TmeIWLabel;
    lblAnnoMov: TmeIWLabel;
    lblNumMov: TmeIWLabel;
    lblCodVoce: TmeIWLabel;
    lblValDataMiss: TmeIWLabel;
    lblValCassa: TmeIWLabel;
    lblValAnnoMov: TmeIWLabel;
    lblValNumMov: TmeIWLabel;
    lblValCodVoce: TmeIWLabel;
    lblMissioniDaLiquidare: TmeIWLabel;
    cmbMissioni: TMedpIWMultiColumnComboBox;
    lblDataDa: TmeIWLabel;
    LblProtocollo: TmeIWLabel;
    lblMeseScarico: TmeIWLabel;
    lblMeseCompetenza: TmeIWLabel;
    lblValDataDa: TmeIWLabel;
    LblValProtocollo: TmeIWLabel;
    lblValMeseScarico: TmeIWLabel;
    lblValMeseCompetenza: TmeIWLabel;
    grdAnticipiMissioni: TmedpIWDBGrid;
    imgCollega: TmedpIWImageButton;
    lblRimborsi: TmeIWLabel;
    procedure btnElencoAnticipiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure lstAnticipiAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbMissioniAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure grdAnticipiMissioniRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure imgCollegaClick(Sender: TObject);
  private
    WC013:TWC013FCheckListFM;
    SlstAnticipiSelezionati: TStringList;
    procedure ckAnticipiResult(Sender: TObject; Result:Boolean);
    procedure CaricaCmbMissioni;
    procedure SvuotaAnticipiSelezionati;
    procedure ResultCollega(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    procedure Aggiorna;
    procedure ReleaseOggetti; override;
  end;

implementation

{$R *.dfm}
procedure TWA131FCollegMissioniFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  SlstAnticipiSelezionati:=TStringList.Create();
  LblValDataMiss.Caption:='';
  LblValCassa.Caption:='';
  LblValAnnoMov.Caption:='';
  LblValNumMov.Caption:='';
  LblValCodVoce.Caption:='';
  LblValDataDa.Caption:='';
  LblValProtocollo.Caption:='';
  LblValMeseScarico.Caption:='';
  LblValMeseCompetenza.Caption:='';

  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
    grdAnticipiMissioni.medpAttivaGrid(SelM050,False,False,False);

  Aggiorna;
end;

procedure TWA131FCollegMissioniFM.Aggiorna;
begin
  SvuotaAnticipiSelezionati;
  CaricaCmbMissioni;
  GrdAnticipiMissioni.medpAggiornaCDS(True);
end;

procedure TWA131FCollegMissioniFM.lstAnticipiAsyncChange(Sender: TObject;
  EventParams: TStringList);
var IndAnt: Integer;
begin
  inherited;
  LblValDataMiss.Caption:='';
  LblValCassa.Caption:='';
  LblValAnnoMov.Caption:='';
  LblValNumMov.Caption:='';
  LblValCodVoce.Caption:='';
  IndAnt:=-1;
  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
  begin
    if (LstAnticipi.ItemIndex >= 0) and (SlstAnticipiSelezionati.Count > 0) then
      IndAnt:=GetIndexAntArray(SLstAnticipiSelezionati[LstAnticipi.itemIndex]);

    if (IndAnt < 0) or (IndAnt > 9999) then
      Exit;
    LblValDataMiss.Caption:=DateToStr(AntArray[IndAnt].DataMis);
    LblValCassa.Caption:=AntArray[IndAnt].Cassa;
    LblValAnnoMov.Caption:=AntArray[IndAnt].Anno;
    LblValNumMov.Caption:=IntToStr(AntArray[IndAnt].Numero);
    LblValCodVoce.Caption:=AntArray[IndAnt].CodiceV;
  end;
end;

procedure TWA131FCollegMissioniFM.SvuotaAnticipiSelezionati;
begin
  SlstAnticipiSelezionati.Clear;
  lstAnticipi.Items.Clear;
  lstAnticipiAsyncChange(nil,nil);
end;

procedure TWA131FCollegMissioniFM.btnElencoAnticipiClick(Sender: TObject);
var i: Integer;
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
  begin
    for i:=0 to High(AntArray) do
    begin
      WC013.ckList.Items.Add(FormatDescAnticipo(i));
      WC013.ckList.Values.Add(AntArray[i].AntId);
    end;
    WC013.ResultEvent:=ckAnticipiResult;
    WC013.ImpostaValoriSelezionati(SlstAnticipiSelezionati);
    WC013.Visualizza;
  end;
end;

procedure TWA131FCollegMissioniFM.ckAnticipiResult(Sender: TObject;
  Result: Boolean);
var i,j: Integer;
  lstTmp: TStringList;
begin
  if Result then
  begin
    //Distruggo vecchia stringlist e assegno quella nuova
    lstTmp:=WC013.LeggiValoriSelezionati;
    SlstAnticipiSelezionati.Clear;
    SlstAnticipiSelezionati.Assign(lstTmp);
    FreeAndNil(lstTmp);
    lstAnticipi.Items.Clear;
    for i:=0 to SlstAnticipiSelezionati.Count-1 do
    begin
      with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
      begin
        for j:=0 to High(AntArray) do
          if AntArray[j].AntId = SlstAnticipiSelezionati[i] then
            lstAnticipi.Items.Add(FormatDescAnticipo(j));
      end;
    end;
    if LstAnticipi.Items.Count > 0 then
      LstAnticipi.ItemIndex:=0;
      lstAnticipiAsyncChange(nil,nil);
  end;
end;

procedure TWA131FCollegMissioniFM.cmbMissioniAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  LblValDataDa.Caption:='';
  LblValProtocollo.Caption:='';
  LblValMeseScarico.Caption:='';
  LblValMeseCompetenza.Caption:='';
  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
  begin
    if cmbMissioni.ItemIndex <> -1 then
    begin
      selM040.Locate('IDMISSIONI',cmbMissioni.Items[cmbMissioni.ItemIndex].RowData[4],[]);
      LblValDataDa.Caption:=selM040.FieldByName('DATADA').AsString;
      LblValProtocollo.Caption:=selM040.FieldByName('PROTOCOLLO').AsString;
      LblValMeseScarico.Caption:=selM040.FieldByName('MESESCARICO').AsString;
      LblValMeseCompetenza.Caption:=selM040.FieldByName('MESECOMPETENZA').AsString;
    end;
  end;
end;

procedure TWA131FCollegMissioniFM.grdAnticipiMissioniRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  inherited;
  grdAnticipiMissioni.medpRenderCell(ACell,ARow,AColumn,True,True,False);
end;

procedure TWA131FCollegMissioniFM.imgCollegaClick(Sender: TObject);
begin
  inherited;
  if not (Self.Parent as TWR102FGestTabella).VerificaSelezioneC700 then
    Raise Exception.Create(A000MSG_ERR_NO_DIP);

  if SlstAnticipiSelezionati.Count = 0 then
    Raise Exception.Create(A000MSG_A131_ERR_NO_ANT);

  if (CmbMissioni.ItemIndex < 0) then
    Raise Exception.Create(A000MSG_A131_ERR_NO_MISSIONE);

  MsgBox.WebMessageDlg(A000MSG_A131_DLG_COLLEGA, mtConfirmation,[mbYes,mbNo], ResultCollega,'');
end;

procedure TWA131FCollegMissioniFM.ResultCollega(Sender: TObject; R: TmeIWModalResult; KI: String);
var
  WC010FMemoEditFM: TWC010FMemoEditFM;
  LstAnomalie: TStringList;
begin
  if R = mrYes then
  begin
    with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
    begin
      LstAnomalie:=CollegaMissioni(sLstAnticipiSelezionati);

      if LstAnomalie.Count > 0 then
      begin
        WC010FMemoEditFM:=TWC010FMemoEditFM.Create(Self.Parent);
        WC010FMemoEditFM.memValore.Lines.Clear;
        WC010FMemoEditFM.memValore.Lines.Assign(LstAnomalie);
        WC010FMemoEditFM.Width:=600;
        WC010FMemoEditFM.Height:=350;
        WC010FMemoEditFM.Visualizza('Anomalie Inserimento Anticipi');
      end;
      FreeAndNil(LstAnomalie);
      CaricaAnticipi;
      Aggiorna;
    end;
  end;
end;

procedure TWA131FCollegMissioniFM.CaricaCmbMissioni;
begin
  cmbMissioni.Items.Clear;
  with (WR302DM as TWA131FGestioneAnticipiDM).A131FGestioneAnticipiMW do
  begin
    selM040.First;
    while not selM040.Eof do
    begin
      //La comdo viene definita con 4 colonne. l'ultima non è visibile e serve
      //per poter reperire l'id usando items.rowdata[4]
      cmbMissioni.AddRow( selM040.FieldByName('DATADA').AsString + ';' +
                          selM040.FieldByName('PROTOCOLLO').AsString + ';' +
                          selM040.FieldByName('MESESCARICO').AsString + ';' +
                          selM040.FieldByName('MESECOMPETENZA').AsString + ';' +
                          selM040.FieldByName('IDMISSIONI').AsString
                        );
      selM040.Next;
    end;
    //IMPOSTO PRIMO ELEMENTO SELEZIONATO
    if cmbMissioni.Items.Count > 0 then
      cmbMissioni.ItemIndex:=0
    else
    begin
      cmbMissioni.Text:='';
      cmbMissioni.ItemIndex:=-1;
    end;
    cmbMissioniAsyncChange(nil,nil,0,'');
  end;
end;

procedure TWA131FCollegMissioniFM.ReleaseOggetti;
begin
  FreeAndNil(SlstAnticipiSelezionati);
  inherited;
end;

end.
