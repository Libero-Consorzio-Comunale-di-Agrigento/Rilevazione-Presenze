unit WA151UAssenteismoDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, StrUtils,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, Math, DB,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, meIWImageButton,
  IWDBExtCtrls, meIWDBRadioGroup, IWCompButton, meIWButton, IWCompLabel,
  meIWLabel, medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls, meIWDBEdit, meIWEdit,
  IWCompGrids, meIWGrid, medpIWTabControl, IWTMSCheckList, meTIWCheckListBox,
  meIWRegion, IWCompCheckbox, meIWDBCheckBox, IWDBGrids, medpIWDBGrid, C190FunzioniGeneraliWeb,
  WC013UCheckListFM;

type
  TWA151FAssenteismoDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    dedtDescrizione: TmeIWDBEdit;
    cmbTabella: TMedpIWMultiColumnComboBox;
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    lblTabella: TmeIWLabel;
    cmbTipoAccorp: TMedpIWMultiColumnComboBox;
    lblTitoloTipoAccorp: TmeIWLabel;
    lblAccorpamenti: TmeIWLabel;
    lblCodiciAccorpamenti: TmeIWLabel;
    dedtAccorpamenti: TmeIWDBEdit;
    lblTipoAccorp: TmeIWLabel;
    btnAccorpamenti: TmeIWButton;
    drdgAssenze: TmeIWDBRadioGroup;
    grdTabColonne: TmedpIWTabControl;
    WA151NumDipRG: TmeIWRegion;
    lstNumDip: TmeTIWCheckListBox;
    lblColonne: TmeIWLabel;
    drdgNumDipPeriodo: TmeIWDBRadioGroup;
    drdgNumDipArrot: TmeIWDBRadioGroup;
    lblNumDipPeriodo: TmeIWLabel;
    lblNumDipArrot: TmeIWLabel;
    WA151PresenzeRG: TmeIWRegion;
    lstPresenze: TmeTIWCheckListBox;
    drdgPresenzaArrot: TmeIWDBRadioGroup;
    lblPresenzeArrot: TmeIWLabel;
    dchkPresenzaGGLav: TmeIWDBCheckBox;
    WA151AssenzeRG: TmeIWRegion;
    lstAssenze: TmeTIWCheckListBox;
    drdgAssenzaArrot: TmeIWDBRadioGroup;
    lblAssenzaArrot: TmeIWLabel;
    dchkAssenzaGGLav: TmeIWDBCheckBox;
    WA151RiepilogoRG: TmeIWRegion;
    lstRiepilogo: TmeTIWCheckListBox;
    drdgRiepilogoArrot: TmeIWDBRadioGroup;
    lblRiepilogoArrot: TmeIWLabel;
    dchkAssenzaGGInt: TmeIWDBCheckBox;
    dchkAssenzaQM: TmeIWDBCheckBox;
    dchkDettaglioGiustificativi: TmeIWDBCheckBox;
    dchkDettaglioFamiliari: TmeIWDBCheckBox;
    lblDebitoGGInt: TmeIWLabel;
    drdgDebitoGGInt: TmeIWDBRadioGroup;
    lblFruizione: TmeIWLabel;
    dchkFruizGG: TmeIWDBCheckBox;
    dchkFruizMG: TmeIWDBCheckBox;
    dchkFruizHH: TmeIWDBCheckBox;
    dchkFruizDH: TmeIWDBCheckBox;
    lblMaxGG: TmeIWLabel;
    dedtMaxGG: TmeIWDBEdit;
    lblRighe: TmeIWLabel;
    dchkDettaglioDip: TmeIWDBCheckBox;
    dchkTotaleGen: TmeIWDBCheckBox;
    dchkRigheVuote: TmeIWDBCheckBox;
    lblEsportaXml: TmeIWLabel;
    cmbEsportaXml: TMedpIWMultiColumnComboBox;
    dgrdRighe: TmedpIWDBGrid;
    tpNumDip: TIWTemplateProcessorHTML;
    tpPresenze: TIWTemplateProcessorHTML;
    tpRiepilogo: TIWTemplateProcessorHTML;
    tpAssenze: TIWTemplateProcessorHTML;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure dgrdRigheDataSet2Componenti(Row: Integer);
    procedure dgrdRigheComponenti2DataSet(Row: Integer);
    procedure dgrdRigheRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnAccorpamentiClick(Sender: TObject);
    procedure cmbTipoAccorpAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure lstAssenzeAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure dchkAssenzaGGIntAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbTabellaChange(Sender: TObject; Index: Integer);
    procedure dchkDettaglioGiustificativiAsyncClick(Sender: TObject;
      EventParams: TStringList);
  private
    procedure cklistCausaliResult(Sender: TObject; Result: Boolean);
    procedure AssegnaPickList;
    procedure AssegnaCheckList;
  public
    procedure CaricaMultiColumnCombobox; override;
    procedure AggiornaGrigliaRighe;
    procedure ConfermaGrdRighe;
    procedure Aggiorna(Colonne:String);
    procedure CaricaListeColonne;
  end;

implementation

uses WA151UAssenteismo, WA151UAssenteismoDM;

{$R *.dfm}

procedure TWA151FAssenteismoDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabColonne.AggiungiTab('Num.Dip.',WA151NumDipRG);
  grdTabColonne.AggiungiTab('Presenze',WA151PresenzeRG);
  grdTabColonne.AggiungiTab('Assenze',WA151AssenzeRG);
  grdTabColonne.AggiungiTab('Riepilogo',WA151RiepilogoRG);
  grdTabColonne.HasFiller:=True;
  grdTabColonne.ActiveTab:=WA151NumDipRG;

  dgrdRighe.medpPaginazione:=False;
  dgrdRighe.medpRowSelect:=False;
  dgrdRighe.medpEditMultiplo:=True;
  dgrdRighe.medpPreparaComponenteGenerico('WR102',0,0,DBG_EDT,'','','','','S');

  AssegnaCheckList;
end;

procedure TWA151FAssenteismoDettFM.lstAssenzeAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  (Self.Owner as TWA151FAssenteismo).AbilitaComponenti;
end;

procedure TWA151FAssenteismoDettFM.AssegnaPickList;
var i:Integer;
begin
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
    for i:=0 to PLEsportaXML.Count - 1 do
      cmbEsportaXML.AddRow(PLEsportaXML[i]);
end;

procedure TWA151FAssenteismoDettFM.btnAccorpamentiClick(Sender: TObject);
var
  WC013: TWC013FCheckListFM;
  LstCodice,
  LstDescrizione: TStringList;
begin
  LstCodice:=TStringList.Create;
  LstDescrizione:=TStringList.Create;
  ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW.lAccorpSel.CommaText:=dedtAccorpamenti.Text;
  try
    WC013:=TWC013FCheckListFM.Create(Self.Parent);
    with WC013 do
    begin
      with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW.selT256 do
      begin
        Close;
        SetVariable('TIPO',cmbTipoAccorp.Text);
        Open;
        First;
        while not Eof do
        begin
          LstCodice.Add(FieldByName('COD_CODICIACCORPCAUSALI').AsString);
          LstDescrizione.Add(Format('%-5s',[FieldByName('COD_CODICIACCORPCAUSALI').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
          Next;
        end;
      end;
      CaricaLista(LstDescrizione, LstCodice);
      ImpostaValoriSelezionati(((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW.lAccorpSel);

      ResultEvent:=cklistCausaliResult;
      WC013.Visualizza(0,0,'Elenco accorpamenti');
    end;
  finally
    FreeAndNil(LstCodice);
    FreeAndNil(LstDescrizione);
  end;
end;

procedure TWA151FAssenteismoDettFM.cklistCausaliResult(Sender: TObject; Result:Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    lAccorpSel.Clear;
    lAccorpSel.Assign(lstTmp);
    selT151.FieldByName('COD_CODICIACCORPCAUSALI').AsString:=lAccorpSel.CommaText;
    FreeAndNil(lstTmp);
  end;
end;

procedure TWA151FAssenteismoDettFM.AssegnaCheckList;
var i:Integer;
begin
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    for i:=0 to lNumDip.Count - 1 do
      lstNumDip.Items.Add(lNumDip[i]);
    for i:=0 to lPres.Count - 1 do
      lstPresenze.Items.Add(lPres[i]);
    for i:=0 to lAss.Count - 1 do
      lstAssenze.Items.Add(lAss[i]);
    for i:=0 to lRiep.Count - 1 do
      lstRiepilogo.Items.Add(lRiep[i]);
  end;
end;

procedure TWA151FAssenteismoDettFM.CaricaMultiColumnCombobox;
begin
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM),A151MW do
  begin
    // caricamento combo Tabella
    if cmbTabella.Items.Count = 0 then
    begin
      selT910.First;
      while not selT910.Eof do
      begin
        cmbTabella.AddRow(selT910.FieldByName('CODICE').AsString + ';' + selT910.FieldByName('TITOLO').AsString);
        selT910.Next;
      end;
    end;
    // caricamento combo Tabella
    if cmbTipoAccorp.Items.Count = 0 then
    begin
      selT255.First;
      while not selT255.Eof do
      begin
        cmbTipoAccorp.AddRow(selT255.FieldByName('COD_TIPOACCORPCAUSALI').AsString + ';' + selT255.FieldByName('DESCRIZIONE').AsString);
        selT255.Next;
      end;
    end;
    AggiornaDescAccorp;
  end;
  AssegnaPickList;
end;

procedure TWA151FAssenteismoDettFM.cmbTabellaChange(Sender: TObject; Index: Integer);
begin
  inherited;
  AggiornaGrigliaRighe;
end;

procedure TWA151FAssenteismoDettFM.cmbTipoAccorpAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).AggiornaDescAccorp;
end;

procedure TWA151FAssenteismoDettFM.dchkAssenzaGGIntAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  (Self.Owner as TWA151FAssenteismo).AbilitaComponenti;
end;

procedure TWA151FAssenteismoDettFM.dchkDettaglioGiustificativiAsyncClick(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  (Self.Owner as TWA151FAssenteismo).AbilitaComponenti;
end;

procedure TWA151FAssenteismoDettFM.dgrdRigheComponenti2DataSet(Row: Integer);
begin
  inherited;
  dgrdRighe.medpDataSet.FieldByName('ORDINE').AsString:=TmeIWEdit(dgrdRighe.medpCompCella(Row,dgrdRighe.medpIndexColonna('ORDINE'),0)).Text;
end;

procedure TWA151FAssenteismoDettFM.dgrdRigheDataSet2Componenti(Row: Integer);
begin
  inherited;
  TmeIWEdit(dgrdRighe.medpCompCella(Row,dgrdRighe.medpIndexColonna('ORDINE'),0)).Text:=dgrdRighe.medpValoreColonna(Row,'ORDINE');
end;

procedure TWA151FAssenteismoDettFM.dgrdRigheRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=dgrdRighe.medpNumColonna(AColumn);

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(dgrdRighe.medpCompGriglia) + 1) and (dgrdRighe.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=dgrdRighe.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA151FAssenteismoDettFM.AggiornaGrigliaRighe;
begin
  with ((Self.Owner as TWA151FAssenteismo).WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    CodTabella:=cmbTabella.Text;
    RecuperaTabella;
    AggiornaCdsRighe;
    dgrdRighe.medpAttivaGrid(cdsRighe,False,False,False);
    if selT151.State in [dsEdit,dsInsert] then
      dgrdRighe.medpModifica(False);
    Aggiorna(selT151.FieldByName('COLONNE').AsString);
  end;
end;

procedure TWA151FAssenteismoDettFM.ConfermaGrdRighe;
var r: Integer;
begin
  with dgrdRighe do
  begin
    medpDataSet.First;
    for r:=IfThen(RigaInserimento,1,0) to High(medpCompGriglia) do
    begin
      //Dato che vado ad aggiornare il campo ORDINE, usato nell'Index del cds, i record del cds potrebbero essere ordinati diversamente da quelli della griglia. Quindi devo posizionarmi su quello giusto prima di aggiornare.
      medpDataSet.Locate('DATO',medpValoreColonna(r,'DATO'),[]);
      medpDataSet.Edit;
      medpConferma(r);
    end;
    medpDataSet.First;
  end;
end;

procedure TWA151FAssenteismoDettFM.Aggiorna(Colonne:String);
var i:Integer;
begin
  //Caricamento colonne
  for i:=0 to lstNumDip.Items.Count - 1 do
  begin
    lstNumDip.Selected[i]:=False;
    if Pos(',' + Copy(lstNumDip.Items[i],2,3) + ',',',' + Colonne + ',') > 0 then
      lstNumDip.Selected[i]:=True;
  end;
  for i:=0 to lstPresenze.Items.Count - 1 do
  begin
    lstPresenze.Selected[i]:=False;
    if Pos(',' + Copy(lstPresenze.Items[i],2,3) + ',',',' + Colonne + ',') > 0 then
      lstPresenze.Selected[i]:=True;
  end;
  for i:=0 to lstAssenze.Items.Count - 1 do
  begin
    lstAssenze.Selected[i]:=False;
    if Pos(',' + Copy(lstAssenze.Items[i],2,3) + ',',',' + Colonne + ',') > 0 then
      lstAssenze.Selected[i]:=True;
  end;
  for i:=0 to lstRiepilogo.Items.Count - 1 do
  begin
    lstRiepilogo.Selected[i]:=False;
    if (lstRiepilogo.Items[i] <> '') and
       (Pos(',' + Copy(lstRiepilogo.Items[i],2,3) + ',',',' + Colonne + ',') > 0) then
      lstRiepilogo.Selected[i]:=True;
  end;
end;

procedure TWA151FAssenteismoDettFM.CaricaListeColonne;
var i:Integer;
begin
  with (WR302DM as TWA151FAssenteismoDM).A151MW do
  begin
    NumDipSel:='';
    for i:=0 to lstNumDip.Items.Count - 1 do
      if lstNumDip.Selected[i] then
        NumDipSel:=NumDipSel + IfThen(Trim(NumDipSel) <> '',',') + Copy(lstNumDip.Items[i],2,3);
    PresenzeSel:='';
    for i:=0 to lstPresenze.Items.Count - 1 do
      if lstPresenze.Selected[i] then
        PresenzeSel:=PresenzeSel + IfThen(Trim(PresenzeSel) <> '',',') + Copy(lstPresenze.Items[i],2,3);
    AssenzeSel:='';
    for i:=0 to lstAssenze.Items.Count - 1 do
      if lstAssenze.Selected[i] then
        AssenzeSel:=AssenzeSel + IfThen(Trim(AssenzeSel) <> '',',') + Copy(lstAssenze.Items[i],2,3);
    RiepilogoSel:='';
    for i:=0 to lstRiepilogo.Items.Count - 1 do
      if lstRiepilogo.Selected[i] then
        RiepilogoSel:=RiepilogoSel + IfThen(Trim(RiepilogoSel) <> '',',') + Copy(lstRiepilogo.Items[i],2,3);
  end;
end;

end.
