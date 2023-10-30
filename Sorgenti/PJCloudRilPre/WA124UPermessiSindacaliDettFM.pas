unit WA124UPermessiSindacaliDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, DB,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, OracleData,
  IWBaseHTMLControl, IWControl, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  IWCompEdit, IWDBStdCtrls, meIWDBEdit, IWCompCheckbox, meIWDBCheckBox,
  medpIWMultiColumnComboBox, IWCompGrids, IWDBGrids, medpIWDBGrid,
  C180FunzioniGenerali, R500Lin, meIWRadioGroup, A000UMessaggi,
  IWCompButton, meIWButton, StrUtils, A000UInterfaccia, Vcl.Menus,
  IWHTMLControls, meIWLink, meIWDBLabel, A000UCostanti;

type
  TWA124FPermessiSindacaliDettFM = class(TWR205FDettTabellaFM)
    drgpTipoPermesso: TmeIWDBRadioGroup;
    lblTipoPermesso: TmeIWLabel;
    lblProtocollo: TmeIWLabel;
    lblNumProt: TmeIWLabel;
    lblDataProt: TmeIWLabel;
    lblProtMod: TmeIWLabel;
    lblNumProtMod: TmeIWLabel;
    lblDataProtMod: TmeIWLabel;
    lblStato: TmeIWLabel;
    lblStatoDescr: TmeIWLabel;
    dedtNumProt: TmeIWDBEdit;
    dedtDataProt: TmeIWDBEdit;
    dedtDataProtMod: TmeIWDBEdit;
    dedtNumProtMod: TmeIWDBEdit;
    lblData: TmeIWLabel;
    dedtData: TmeIWDBEdit;
    dedtDalle: TmeIWDBEdit;
    dedtAlle: TmeIWDBEdit;
    lblAlle: TmeIWLabel;
    lblOre: TmeIWLabel;
    dedtOre: TmeIWDBEdit;
    dchkAbbatteCompetenzeOrg: TmeIWDBCheckBox;
    lblDalle: TmeIWLabel;
    cmbSindacato: TMedpIWMultiColumnComboBox;
    cmbOrganismo: TMedpIWMultiColumnComboBox;
    grdCompetenze: TmedpIWDBGrid;
    lblCompetenze: TmeIWLabel;
    rgpModalita: TmeIWRadioGroup;
    btnCompetenze: TmeIWButton;
    btnElimina: TmeIWButton;
    pmnRipristina: TPopupMenu;
    RitornaallostatoMODIFICATO1: TMenuItem;
    lnkSindacato: TmeIWLink;
    lnkOrganismo: TmeIWLink;
    dedtDataDa: TmeIWDBEdit;
    lblDataDa: TmeIWLabel;
    dchkStatutario: TmeIWDBCheckBox;
    dchkRetribuito: TmeIWDBCheckBox;
    dchkRsu: TmeIWDBCheckBox;
    dchkRaggruppamento: TmeIWDBCheckBox;
    dlblSiglaGedap: TmeIWDBLabel;
    lblGEDAP: TmeIWLabel;
    dlblDOrganismo: TmeIWDBLabel;
    dlblDSindacato: TmeIWDBLabel;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdCompetenzeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure cmbOrganismoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbSindacatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure dedtDalleAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure rgpModalitaClick(Sender: TObject);
    procedure btnCompetenzeClick(Sender: TObject);
    procedure dedtDataAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnEliminaClick(Sender: TObject);
    procedure RitornaallostatoMODIFICATO1Click(Sender: TObject);
    procedure lnkSindacatoClick(Sender: TObject);
    procedure drgpTipoPermessoClick(Sender: TObject);
  private
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  public
    { Public declarations }
    procedure AbilitaComponenti; override;
  end;

implementation

uses WA124UPermessiSindacali, WA124UPermessiSindacaliDM;

{$R *.dfm}

procedure TWA124FPermessiSindacaliDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    Competenze;
    grdCompetenze.medpAttivaGrid(selCompetenze,False,False);
    Compet:=False;
    (*SelAnagrafe.OnFilterRecord:=SelAnagrafeOnFilterRecord;*)
  end;
end;

procedure TWA124FPermessiSindacaliDettFM.lnkSindacatoClick(Sender: TObject);
var Params:String;
begin
  inherited;
  Params:='TIPO=' + IfThen((Sender as TmeIWLink).Name = 'lnkSindacato','S','O') + ParamDelimiter +
          'CODICE=' + IfThen((Sender as TmeIWLink).Name = 'lnkSindacato',cmbSindacato.Text,cmbOrganismo.Text);
  (Self.Owner as TWA124FPermessiSindacali).accediForm(55,Params);
end;

procedure TWA124FPermessiSindacaliDettFM.rgpModalitaClick(Sender: TObject);
begin
  (*

  !!!La modalità collettiva è stata nascosta e remmata perché non usata!!!

  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    SelezioneCollettiva:=rgpModalita.ItemIndex = 1;
    AggiornaSindacati;
    AggiornaSindacatiMC;
  end;
  CaricaMultiColumnCombobox;
  AbilitaComponenti;
  *)
end;

procedure TWA124FPermessiSindacaliDettFM.RitornaallostatoMODIFICATO1Click(Sender: TObject);
begin
  inherited;
  lblStatoDescr.Caption:='MODIFICATO';
  (WR302DM as TWA124FPermessiSindacaliDM).A124MW.Azione:='M';
  (WR302DM as TWA124FPermessiSindacaliDM).A124MW.RipristinaStatoModificato;
  (Self.Owner as TWA124FPermessiSindacali).WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

procedure TWA124FPermessiSindacaliDettFM.AbilitaComponenti;
begin
  //Abilitazione pulsanti
  with (Self.Owner as TWA124FPermessiSindacali),(WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    actPrimo.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actPrecedente.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actSuccessivo.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actUltimo.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actRicerca.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actAggiorna.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actModifica.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actEstrai.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actCopiaSu.Enabled:=(DataSetInUso.State = dsBrowse) and (not SolaLettura) (*and (not SelezioneCollettiva)*);
    actCartellino.Enabled:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger <> 0;
    actPermessiAnnoCorrente.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    actPermessiNonCancellati.Enabled:=(DataSetInUso.State = dsBrowse) (*and (not SelezioneCollettiva)*);
    AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
    //Abilitazione selezione anagrafiche e modalità collettiva-singola
    grdC700.Enabled:=DataSetInUso.State = dsBrowse;
    (*rgpModalita.Enabled:=DataSetInUso.State = dsBrowse;*)
    //Abilitazione pulsante Elimina
    btnElimina.Visible:=(DataSetInUso.State in [dsEdit,dsInsert]) and (Azione = 'C');
    //Abilitazione Protocollo Modifica
    dEdtNumProtMod.ReadOnly:=not( (DataSetInUso.State = dsEdit) (*or
                                 ((DataSetInUso.State = dsInsert) and (SelezioneCollettiva) and (Azione = 'C'))*));
    lblNumProtMod.Enabled:=not dEdtNumProtMod.ReadOnly;
    lblDataProtMod.Enabled:=not dEdtNumProtMod.ReadOnly;
    //Abilitazione competenze
    (*btnCompetenze.Enabled:=not SelezioneCollettiva;*)
    GrdCompetenze.Visible:=(*not SelezioneCollettiva and*) Compet;
    lblCompetenze.Visible:=GrdCompetenze.Visible;
    //
    AbilitaRitornaallostatoModificato;
    (*rgpModalita.Enabled:=DataSetInUso.State = dsBrowse;*)
    if grdTabControl.TabCount > 0 then
      grdTabControl.TabByIndex(0).Enabled:=True(*not SelezioneCollettiva*);
    //Abilitazione campi principali
    CmbSindacato.Enabled:=((*(not SelezioneCollettiva) and*) (DataSetInUso.State in [dsEdit,dsInsert]) and (Azione <> 'C')) (*or
                           ((SelezioneCollettiva) and (DataSetInUso.State = dsInsert))*);
    dEdtDalle.Enabled:=drgpTipoPermesso.Values.IndexOf(DataSetInUso.FieldByName('TIPO_PERMESSO').AsString) > (drgpTipoPermesso.Items.Count - 4);
    dEdtAlle.Enabled:=drgpTipoPermesso.Values.IndexOf(DataSetInUso.FieldByName('TIPO_PERMESSO').AsString) > (drgpTipoPermesso.Items.Count - 2);
    lblDalle.Enabled:=drgpTipoPermesso.Values.IndexOf(DataSetInUso.FieldByName('TIPO_PERMESSO').AsString) > (drgpTipoPermesso.Items.Count - 4);
    lblDalle.Caption:=IfThen(R180In(drgpTipoPermesso.Values.IndexOf(DataSetInUso.FieldByName('TIPO_PERMESSO').AsString),[1,2]),'num.Ore','da Ore');
    lblAlle.Enabled:=drgpTipoPermesso.Values.IndexOf(DataSetInUso.FieldByName('TIPO_PERMESSO').AsString) > (drgpTipoPermesso.Items.Count - 2);
  end;
  CmbOrganismo.Enabled:=CmbSindacato.Enabled;
  drgpTipoPermesso.Enabled:=CmbSindacato.Enabled;
  //Abilitazione Protocollo
  lblNumProt.Enabled:=CmbSindacato.Enabled;
  dEdtNumProt.ReadOnly:=not CmbSindacato.Enabled;
  lblDataProt.Enabled:=CmbSindacato.Enabled;
end;

procedure TWA124FPermessiSindacaliDettFM.CaricaMultiColumnCombobox;
var DS: TDataSet;
    TrovCod: Boolean;
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM),A124MW do
    (*if SelezioneCollettiva then
      DS:=dsrT240C.DataSet
    else*)
      DS:=dsrT240.DataSet;
  //Carico cmbSindacato
  TrovCod:=False;
  with DS do
  begin
    First;
    cmbSindacato.Items.Clear;
    while not Eof do
    begin
      cmbSindacato.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      if not TrovCod then
        TrovCod:=cmbSindacato.Text = FieldByName('CODICE').AsString;
      Next;
    end;
  end;
  if not TrovCod and ((WR302DM as TWA124FPermessiSindacaliDM).A124MW.DataSetInUso.State <> dsBrowse) then
  begin
    cmbSindacato.Text:='';
    //lblSindacatoDescr.Caption:='';
  end;
  //Carico cmbOrganismo
  TrovCod:=False;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW.selT245 do
  begin
    First;
    cmbOrganismo.Items.Clear;
    while not Eof do
    begin
      cmbOrganismo.AddRow(FieldByName('CODICE').AsString+';'+FieldByName('DESCRIZIONE').AsString);
      if not TrovCod then
        TrovCod:=cmbOrganismo.Text = FieldByName('CODICE').AsString;
      Next;
    end;
  end;
  if not TrovCod and ((WR302DM as TWA124FPermessiSindacaliDM).A124MW.DataSetInUso.State <> dsBrowse) then
  begin
    cmbOrganismo.Text:='';
    //lblOrganismoDescr.Caption:='';
  end;
end;

procedure TWA124FPermessiSindacaliDettFM.cmbOrganismoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    DataSetInUso.FieldByName('COD_ORGANISMO').AsString:=cmbOrganismo.Text;
    (*if SelezioneCollettiva then
      AggiornaSindacatiMC
    else*)
      AggiornaSindacati;
    CaricaMultiColumnCombobox;
    if (DatasetInUso.State in [dsEdit,dsInsert]) then
      ValorizzNumOre;
  end;
end;

procedure TWA124FPermessiSindacaliDettFM.cmbSindacatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    DataSetInUso.FieldByName('COD_SINDACATO').AsString:=cmbSindacato.Text;
end;

procedure TWA124FPermessiSindacaliDettFM.Componenti2DataSet;
begin
  inherited;
end;

procedure TWA124FPermessiSindacaliDettFM.DataSet2Componenti;
//var TipoSind:String;
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    // Valorizzazione label STATO
    lblStatoDescr.Caption:=IfThen(DataSetInUso.FieldByName('STATO').AsString = 'O','ORIGINALE',
                           IfThen(DataSetInUso.FieldByName('STATO').AsString = 'M','MODIFICATO',
                           IfThen(DataSetInUso.FieldByName('STATO').AsString = 'C','CANCELLATO','')));
    (*if SelezioneCollettiva then
      AggiornaSindacatiMC
    else*)
      AggiornaSindacati;
    CmbSindacato.Text:=DataSetInUso.FieldByName('COD_SINDACATO').AsString;
    CmbOrganismo.Text:=DataSetInUso.FieldByName('COD_ORGANISMO').AsString;
    //lblSindacatoDescr.Caption:=AggiornaDescrizioni('S',VarToStr(CmbSindacato.Text),TipoSind);
    //lblOrganismoDescr.Caption:=AggiornaDescrizioni('O',VarToStr(CmbOrganismo.Text),TipoSind);
    // Valorizzazione label COMPETENZE
    lblCompetenze.Caption:='';
    if selCompetenze.Active then
    begin
      Competenze;
      grdCompetenze.medpAggiornaCDS(True);
      if selCompetenze.RecordCount = 0 then
        lblCompetenze.Caption:=A000MSG_A124_MSG_NO_COMP_CONTRATTO;
    end;
  end;
end;

procedure TWA124FPermessiSindacaliDettFM.dedtDalleAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if (DatasetInUso.State in [dsEdit,dsInsert]) then
      ValorizzNumOre;
end;

procedure TWA124FPermessiSindacaliDettFM.dedtDataAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
  begin
    try
      if StrToDate(dedtData.Text) < StrToDate(dedtDataDa.Text) then
      begin
        if Sender = dedtData then
          dedtDataDa.Text:=dedtData.Text
        else
          dedtData.Text:=dedtDataDa.Text;
        if (DatasetInUso.State in [dsEdit,dsInsert]) then
        begin
          DatasetInUso.FieldByName('DATA_DA').AsDateTime:=StrToDate(dedtDataDa.Text);
          DatasetInUso.FieldByName('DATA').AsDateTime:=StrToDate(dedtData.Text);
        end;
      end;
    except
    end;
    (*if SelezioneCollettiva then
      AggiornaSindacatiMC
    else*)
      AggiornaSindacati;
    CaricaMultiColumnCombobox;
    if (DatasetInUso.State in [dsEdit,dsInsert]) then
      ValorizzNumOre;
  end;
end;

procedure TWA124FPermessiSindacaliDettFM.drgpTipoPermessoClick(Sender: TObject);
begin
  inherited;
  dEdtDalle.Enabled:=drgpTipoPermesso.ItemIndex > (drgpTipoPermesso.Items.Count - 4);
  dEdtAlle.Enabled:=drgpTipoPermesso.ItemIndex > (drgpTipoPermesso.Items.Count - 2);
  lblDalle.Enabled:=dEdtDalle.Enabled;
  lblDalle.Caption:=IfThen(R180In(drgpTipoPermesso.ItemIndex,[1,2]),'num.Ore','da Ore');
  lblAlle.Enabled:=dEdtAlle.Enabled;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if (DataSetInUso.State in [dsEdit,dsInsert]) then
    begin
      DataSetInUso.FieldByName('DALLE').AsString:='';
      DataSetInUso.FieldByName('ALLE').AsString:='';
      DataSetInUso.FieldByName('ORE').AsString:='';
      ValorizzNumOre;
    end;
end;

procedure TWA124FPermessiSindacaliDettFM.btnCompetenzeClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA124FPermessiSindacaliDM).A124MW do
    if not Compet then
    begin
      Compet:=True;
      Competenze;
      grdCompetenze.medpAggiornaCDS(True);
      if selCompetenze.RecordCount = 0 then
        lblCompetenze.Caption:=A000MSG_A124_MSG_NO_COMP_CONTRATTO
      else
        lblCompetenze.Caption:='';
      btnCompetenze.Caption:='Nascondi competenze';
    end
    else
    begin
      Compet:=False;
      selCompetenze.Close;
      lblCompetenze.Caption:='';
      btnCompetenze.Caption:='Visualizza competenze';
    end;
  AbilitaComponenti;
end;

procedure TWA124FPermessiSindacaliDettFM.btnEliminaClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWA124FPermessiSindacali).actEliminaExecute(Sender);
end;

procedure TWA124FPermessiSindacaliDettFM.grdCompetenzeRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
end;

end.
