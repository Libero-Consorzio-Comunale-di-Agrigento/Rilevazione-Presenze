unit WS740URegoleValutazioniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel,
  meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWCompExtCtrls, meIWImageFile, DB, A000UInterfaccia, C180FunzioniGenerali,
  meIWRegion, medpIWTabControl, IWCompGrids, meIWGrid, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  IWCompCheckbox, meIWDBCheckBox, IWCompButton, meIWButton, medpIWMultiColumnComboBox, IWTMSCheckList,
  meTIWCheckListBox, meIWDBLabel, WC013UCheckListFM, C190FunzioniGeneraliWeb, IWCompMemo, meIWDBMemo,
  IWDBExtCtrls, meIWDBRadioGroup, IWDBGrids, medpIWDBGrid, IWAdvRadioGroup, meTIWAdvRadioGroup,
  A000UCostanti, IWCompListbox, meIWDBLookupComboBox, Math;

type
  TWS740FRegoleValutazioniDettFM = class(TWR205FDettTabellaFM)
    dedtCodice: TmeIWDBEdit;
    lblCodice: TmeIWLabel;
    lblDescrizione: TmeIWLabel;
    dedtDescrizione: TmeIWDBEdit;
    lblFiltroAnagrafe: TmeIWLabel;
    dedtFiltroAnagrafe: TmeIWDBEdit;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    WS740GenericoRG: TmeIWRegion;
    WS740StampaRG: TmeIWRegion;
    WS740ValutazioniRG: TmeIWRegion;
    grdTabDetail: TmedpIWTabControl;
    TemplateGenericoRG: TIWTemplateProcessorHTML;
    TemplateStampaRG: TIWTemplateProcessorHTML;
    TemplateValutazioniRG: TIWTemplateProcessorHTML;
    lblPathIstruzioni: TmeIWLabel;
    dedtPathIstruzioni: TmeIWDBEdit;
    lblPathInformazioni: TmeIWLabel;
    dedtPathInformazioni: TmeIWDBEdit;
    lblCodiciTipoRapporto: TmeIWLabel;
    dedtCodiciTipoRapporto: TmeIWDBEdit;
    btnSceltaCodiciTipoRapporto: TmeIWButton;
    lblGiorniMinimi: TmeIWLabel;
    dedtGiorniMinimi: TmeIWDBEdit;
    dchkValutaCessatiRuolo: TmeIWDBCheckBox;
    dchkAggiornaDataCompilazione: TmeIWDBCheckBox;
    dchkInvioEmail: TmeIWDBCheckBox;
    dedtPagineAbilitate: TmeIWDBEdit;
    lblPagineAbilitate: TmeIWLabel;
    lblVisCampiOpzionali: TmeIWLabel;
    clbCampiOpzionaliCompilazione: TmeTIWCheckListBox;
    btnPagineAbilitate: TmeIWButton;
    lblTesto: TmeIWLabel;
    dmemTestoValutazioniComplessive: TmeIWDBMemo;
    TemplateObiettivi: TIWTemplateProcessorHTML;
    WS740ObiettiviRG: TmeIWRegion;
    TemplateProposte: TIWTemplateProcessorHTML;
    WS740ProposteRG: TmeIWRegion;
    TemplateCommentiRG: TIWTemplateProcessorHTML;
    TemplateNoteRG: TIWTemplateProcessorHTML;
    WS740CommentiRG: TmeIWRegion;
    WS740NoteRG: TmeIWRegion;
    dchkAssegnPreventivaObiettivi: TmeIWDBCheckBox;
    lblPeriodoAssegnObiettivi: TmeIWLabel;
    lblDataDa: TmeIWLabel;
    lblDataA: TmeIWLabel;
    dedtDataDaObiettivi: TmeIWDBEdit;
    dedtDataAObiettivi: TmeIWDBEdit;
    dchkAbilitaAreeFormative: TmeIWDBCheckBox;
    dchkAreaFormativaObbligatoria: TmeIWDBCheckBox;
    dchkAbilitaAccettazioneValutato: TmeIWDBCheckBox;
    lblAbilitaTesto: TmeIWLabel;
    dchkModificaNoteSupervisore: TmeIWDBCheckBox;
    WS740DatiAnagraficiRG: TmeIWRegion;
    TemplateDatiAnagraficiRG: TIWTemplateProcessorHTML;
    grdTabDetail2: TmedpIWTabControl;
    WS740EtichetteRG: TmeIWRegion;
    TemplateEtichetteRG: TIWTemplateProcessorHTML;
    WS740VarieRG: TmeIWRegion;
    TemplateVarieRG: TIWTemplateProcessorHTML;
    lblDatiDaStampare: TmeIWLabel;
    dchkDescLunga1: TmeIWDBCheckBox;
    dchkDescLunga3: TmeIWDBCheckBox;
    dchkDescLunga5: TmeIWDBCheckBox;
    dchkStampaVariazioni5: TmeIWDBCheckBox;
    dgrdEtichette: TmedpIWDBGrid;
    lblLogo: TmeIWLabel;
    lblLarghezza: TmeIWLabel;
    lblAltezza: TmeIWLabel;
    dedtLogoLarghezza: TmeIWDBEdit;
    dedtLogoAltezza: TmeIWDBEdit;
    dchkStampaPeriodoValutazione: TmeIWDBCheckBox;
    lblPathFilePDF: TmeIWLabel;
    edtPathFilePDF: TmeIWDBEdit;
    lblStampaCampiOpzionali: TmeIWLabel;
    clbCampiOpzionaliStampa: TmeTIWCheckListBox;
    drgpAbilitaCommentiValutato: TmeTIWAdvRadioGroup;
    dcmbDatoStampa1: TmeIWDBLookupComboBox;
    dcmbDatoStampa2: TmeIWDBLookupComboBox;
    dcmbDatoStampa3: TmeIWDBLookupComboBox;
    dcmbDatoStampa4: TmeIWDBLookupComboBox;
    dcmbDatoStampa5: TmeIWDBLookupComboBox;
    dcmbDatoStampa6: TmeIWDBLookupComboBox;
    dchkCommentiValutatoDip: TmeIWDBCheckBox;
    dchkRegistraDataAccettazioneVal: TmeIWDBCheckBox;
    lblCodParProtocollo: TmeIWLabel;
    cmbCodParProtocollo: TMedpIWMultiColumnComboBox;
    dlblDescParProtocollo: TmeIWDBLabel;
    drgpTipoArrotondamento: TTIWAdvRadioGroup;
    lblTipoArrotondamento: TmeIWLabel;
    lblTestoAvvisoPresaVisione: TmeIWLabel;
    dmemTestoAvvisoPresaVisione: TmeIWDBMemo;
    lblDatoVariazioneValutatore: TmeIWLabel;
    dcmbDatoVariazioneValutatore: TmeIWDBLookupComboBox;
    lblCodTipoQuotaStampa: TmeIWLabel;
    cmbCodTipoQuotaStampa: TMedpIWMultiColumnComboBox;
    dlblDescTipoQuotaStampa: TmeIWDBLabel;
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnSceltaCodiciTipoRapportoClick(Sender: TObject);
    procedure btnPagineAbilitateClick(Sender: TObject);
    procedure dchkDescLunga1Click(Sender: TObject);
    procedure dchkDescLunga1AsyncClick(Sender: TObject; EventParams: TStringList);
    procedure drgpAbilitaCommentiValutatoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure drgpTipoArrotondamentoAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure cmbCodTipoQuotaStampaAsyncChange(Sender: TObject;EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbCodParProtocolloAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
  private
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure ResultAcconti(Sender: TObject; Result:Boolean);
    procedure ResultPagine(Sender: TObject; Result:Boolean);
  public
    { Public declarations }
    procedure AbilitaComponenti; override;
  end;

implementation

uses WS740URegoleValutazioni, WS740URegoleValutazioniDM;

{$R *.dfm}
procedure TWS740FRegoleValutazioniDettFM.IWFrameRegionCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  //tabs
  grdTabDetail.AggiungiTab('Generico',WS740GenericoRG);
  grdTabDetail.AggiungiTab('Stampa',WS740StampaRG);
  grdTabDetail.AggiungiTab('P1-Valutazioni Complessive',WS740ValutazioniRG);
  grdTabDetail.AggiungiTab('P2-Obiettivi pianificati',WS740ObiettiviRG);
  grdTabDetail.AggiungiTab('P3-Proposte formative',WS740ProposteRG);
  grdTabDetail.AggiungiTab('P4-Commenti valutato',WS740CommentiRG);
  grdTabDetail.AggiungiTab('P5-Note',WS740NoteRG);
  grdTabDetail2.AggiungiTab('Dati Anagrafici',WS740DatiAnagraficiRG);
  grdTabDetail2.AggiungiTab('Etichette',WS740EtichetteRG);
  grdTabDetail2.AggiungiTab('Varie',WS740VarieRG);
  grdTabDetail.ActiveTab:=WS740GenericoRG;
  grdTabDetail2.ActiveTab:=WS740DatiAnagraficiRG;
  dcmbDatoVariazioneValutatore.ListSource:=(WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.D010;
  dcmbDatoStampa1.ListSource:=(WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.D010;
  dcmbDatoStampa2.ListSource:=(WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.D010;
  dcmbDatoStampa3.ListSource:=(WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.D010;
  dcmbDatoStampa4.ListSource:=(WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.D010;
  dcmbDatoStampa5.ListSource:=(WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.D010;
  dcmbDatoStampa6.ListSource:=(WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.D010;

  with (WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW do
    for i:=0 to High(CampiOpzionali) do
    begin
      if CampiOpzionali[i].Stampa then
        clbCampiOpzionaliStampa.Items.Add(CampiOpzionali[i].Desc);
      if CampiOpzionali[i].Compila then
        clbCampiOpzionaliCompilazione.Items.Add(CampiOpzionali[i].Desc);
    end;
end;

procedure TWS740FRegoleValutazioniDettFM.imgC700SelezioneAnagrafeClick(Sender: TObject);
var
  dDataSelAnagrafe: TDateTime;
begin
  inherited;
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    with (Self.Owner as TWS740FRegoleValutazioni).grdC700 do
    begin
      dDataSelAnagrafe:=Parametri.DataLavoro;
      if WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime <> DATE_NULL then
        dDataSelAnagrafe:=WR302DM.selTabella.FieldByName('DECORRENZA').AsDateTime;
      WC700FM.C700SettaPeriodoSelAnagrafe(dDataSelAnagrafe,dDataSelAnagrafe);
      WC700FM.ResultEvent:=ResultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWS740FRegoleValutazioniDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
var S:string;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWS740FRegoleValutazioni).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    WR302DM.selTabella.FieldByName('FILTRO_ANAGRAFE').AsString:=S.Replace(#13#10,' ',[rfReplaceAll]);
  end;
end;

procedure TWS740FRegoleValutazioniDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW do
  begin
    selSG735.First;
    cmbCodTipoQuotaStampa.Items.Clear;
    while not selSG735.Eof do
    begin
      cmbCodTipoQuotaStampa.AddRow(selSG735.FieldByName('CODICE').AsString + ';' +
                                   selSG735.FieldByName('DESCRIZIONE').AsString);
      selSG735.Next;
    end;

    selSG750.First;
    cmbCodParProtocollo.Items.Clear;
    while not selSG750.Eof do
    begin
      cmbCodParProtocollo.AddRow(selSG750.FieldByName('CODICE').AsString + ';' +
                                 selSG750.FieldByName('DESCRIZIONE').AsString);
      selSG750.Next;
    end;
  end;
end;

procedure TWS740FRegoleValutazioniDettFM.DataSet2Componenti;
var i,k:Integer;
    TipoArr:String;
begin
  with TWS740FRegoleValutazioniDM(WR302DM) do
  begin
    cmbCodTipoQuotaStampa.Text:=selTabella.FieldByName('CODTIPOQUOTA_STAMPA').AsString;
    cmbCodParProtocollo.Text:=selTabella.FieldByName('COD_PARPROTOCOLLO').AsString;

    with S740FRegoleValutazioniMW do
      for i:=0 to High(CampiOpzionali) do
      begin
        k:=clbCampiOpzionaliStampa.Items.IndexOf(CampiOpzionali[i].Desc);
        if k >= 0 then
          clbCampiOpzionaliStampa.Selected[k]:=R180InConcat(IntToStr(CampiOpzionali[i].Ord),WR302DM.selTabella.FieldByName('CAMPI_OPZIONALI_STAMPA').AsString);
        k:=clbCampiOpzionaliCompilazione.Items.IndexOf(CampiOpzionali[i].Desc);
        if k >= 0 then
          clbCampiOpzionaliCompilazione.Selected[k]:=R180InConcat(IntToStr(CampiOpzionali[i].Ord),WR302DM.selTabella.FieldByName('CAMPI_OPZIONALI_COMPILAZIONE').AsString);
      end;

    if dgrdEtichette.medpDataSet <> nil then
      dgrdEtichette.medpAggiornaCDS(True);

    drgpAbilitaCommentiValutato.ItemIndex:=selTabella.FieldByName('ABILITA_COMMENTI_VALUTATO').AsInteger - 1;
    TipoArr:=selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString;
    drgpTipoArrotondamento.ItemIndex:=IfThen(TipoArr = 'E',1,IfThen(TipoArr = 'D',2,IfThen(TipoArr = 'P',3,0)));

  end;
end;

procedure TWS740FRegoleValutazioniDettFM.dchkDescLunga1AsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  AbilitaComponenti;
  //tempdario attivagrid
end;

procedure TWS740FRegoleValutazioniDettFM.dchkDescLunga1Click(Sender: TObject);
begin
  inherited;
  AbilitaComponenti;
    //tempdario attivagrid
end;

procedure TWS740FRegoleValutazioniDettFM.drgpAbilitaCommentiValutatoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  WR302DM.selTabella.FieldByName('ABILITA_COMMENTI_VALUTATO').AsInteger:=drgpAbilitaCommentiValutato.ItemIndex + 1;
end;

procedure TWS740FRegoleValutazioniDettFM.drgpTipoArrotondamentoAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  case drgpTipoArrotondamento.ItemIndex of
    0: WR302DM.selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='N';
    1: WR302DM.selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='E';
    2: WR302DM.selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='D';
    3: WR302DM.selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='P';
  end;
end;

procedure TWS740FRegoleValutazioniDettFM.cmbCodTipoQuotaStampaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  WR302DM.selTabella.FieldByName('CODTIPOQUOTA_STAMPA').AsString:=cmbCodTipoQuotaStampa.Text;
end;

procedure TWS740FRegoleValutazioniDettFM.cmbCodParProtocolloAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  WR302DM.selTabella.FieldByName('COD_PARPROTOCOLLO').AsString:=cmbCodParProtocollo.Text;
end;

procedure TWS740FRegoleValutazioniDettFM.Componenti2DataSet;
var i,k:Integer;
    selArray: array of Boolean;
begin
  with TWS740FRegoleValutazioniDM(WR302DM) do
  begin
    selTabella.FieldByName('CODTIPOQUOTA_STAMPA').AsString:=cmbCodTipoQuotaStampa.Text;
    selTabella.FieldByName('COD_PARPROTOCOLLO').AsString:=cmbCodParProtocollo.Text;
    selTabella.FieldByName('ABILITA_COMMENTI_VALUTATO').AsInteger:=drgpAbilitaCommentiValutato.ItemIndex + 1;
    case drgpTipoArrotondamento.ItemIndex of
      0: selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='N';
      1: selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='E';
      2: selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='D';
      3: selTabella.FieldByName('TIPO_ARROTONDAMENTO').AsString:='P';
    end;

    SetLength(selArray, Length(S740FRegoleValutazioniMW.CampiOpzionali));
    for i:=0 to High(selArray) do
    begin
      selArray[i]:=False;
      k:=clbCampiOpzionaliStampa.Items.IndexOf(S740FRegoleValutazioniMW.CampiOpzionali[i].Desc);
      if k >= 0 then
        selArray[i]:=clbCampiOpzionaliStampa.Selected[k];
    end;
    S740FRegoleValutazioniMW.SetCampiOpzionali(selArray, 'CAMPI_OPZIONALI_STAMPA');
    for i:=0 to High(selArray) do
    begin
      selArray[i]:=False;
      k:=clbCampiOpzionaliCompilazione.Items.IndexOf(S740FRegoleValutazioniMW.CampiOpzionali[i].Desc);
      if k >= 0 then
        selArray[i]:=clbCampiOpzionaliCompilazione.Selected[k];
    end;
    S740FRegoleValutazioniMW.SetCampiOpzionali(selArray, 'CAMPI_OPZIONALI_COMPILAZIONE');
  end;
end;

procedure TWS740FRegoleValutazioniDettFM.btnSceltaCodiciTipoRapportoClick(Sender: TObject);
var
  ElencoCodiciRapporto: TElencoValoriChecklist;
  LstSel: TStringList;
  WC013: TWC013FCheckListFM;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  ElencoCodiciRapporto:=(WR302DM AS TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.ElencoCodiciRapporto;
  WC013.CaricaLista(ElencoCodiciRapporto.lstDescrizione, ElencoCodiciRapporto.lstCodice);
  FreeAndNil(ElencoCodiciRapporto);
  LstSel:=TStringList.Create;
  LstSel.CommaText:=dedtCodiciTipoRapporto.Text;
  WC013.ImpostaValoriSelezionati(LstSel);
  FreeAndNil(LstSel);

  WC013.ResultEvent:=ResultAcconti;
  WC013.Visualizza(0,0,'<WC013> Elenco tipo rapporto');
end;

procedure TWS740FRegoleValutazioniDettFM.btnPagineAbilitateClick(Sender: TObject);
var
  ElencoPagine: TElencoValoriChecklist;
  LstSel: TStringList;
  WC013: TWC013FCheckListFM;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  ElencoPagine:=(WR302DM AS TWS740FRegoleValutazioniDM).S740FRegoleValutazioniMW.ElencoPagine;
  WC013.CaricaLista(ElencoPagine.lstDescrizione, ElencoPagine.lstCodice);
  FreeAndNil(ElencoPagine);
  LstSel:=TStringList.Create;
  LstSel.CommaText:=dedtPagineAbilitate.Text;
  WC013.ImpostaValoriSelezionati(LstSel);
  FreeAndNil(LstSel);

  WC013.ResultEvent:=ResultPagine;
  WC013.Visualizza(0,0,'<WC013> Elenco pagine');
end;

procedure TWS740FRegoleValutazioniDettFM.ResultAcconti(Sender: TObject; Result:Boolean);
var
  lstTemp: TStringList;
begin
  if Result then
  begin
    lstTemp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    WR302DM.selTabella.FieldByName('COD_TIPI_RAPPORTO').AsString:=lstTemp.CommaText;
    FreeAndNil(lstTemp);
  end;
end;

procedure TWS740FRegoleValutazioniDettFM.ResultPagine(Sender: TObject; Result:Boolean);
var
  lstTemp: TStringList;
begin
  if Result then
  begin
    lstTemp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    WR302DM.selTabella.FieldByName('PAGINE_ABILITATE').AsString:=lstTemp.CommaText;
    FreeAndNil(lstTemp);
  end;
end;

procedure TWS740FRegoleValutazioniDettFM.AbilitaComponenti;
var
  bEdit: Boolean;
begin
  bEdit:=WR302DM.selTabella.State in [dsEdit,dsInsert];
  if bEdit then
  begin
    dedtDataDaObiettivi.Enabled:=dchkAssegnPreventivaObiettivi.Checked;
    dedtDataAObiettivi.Enabled:=dchkAssegnPreventivaObiettivi.Checked;
    dchkAreaFormativaObbligatoria.Enabled:=dchkAbilitaAreeFormative.Checked;
    if not dchkAreaFormativaObbligatoria.Enabled then
      dchkAreaFormativaObbligatoria.Checked:=False;
    dchkRegistraDataAccettazioneVal.Enabled:=dchkCommentiValutatoDip.Checked and dchkAbilitaAccettazioneValutato.Checked;
    if not dchkRegistraDataAccettazioneVal.Enabled then
      dchkRegistraDataAccettazioneVal.Checked:=False;
    drgpAbilitaCommentiValutato.EnabledItems[0]:=1;
    drgpAbilitaCommentiValutato.EnabledItems[1]:=1;
    drgpAbilitaCommentiValutato.EnabledItems[2]:=dchkAbilitaAccettazioneValutato.Checked.ToInteger;
    drgpAbilitaCommentiValutato.EnabledItems[3]:=dchkAbilitaAccettazioneValutato.Checked.ToInteger;
    // verifica che l'item attualmente selezionato sia abilitato
    if(not dchkAbilitaAccettazioneValutato.Checked) then
    begin
      if(drgpAbilitaCommentiValutato.ItemIndex = 2)or(drgpAbilitaCommentiValutato.ItemIndex = 3) then
        drgpAbilitaCommentiValutato.ItemIndex:=0;
    end;
    dcmbDatoStampa2.Enabled:=not dchkDescLunga1.Checked;
    dcmbDatoStampa4.Enabled:=not dchkDescLunga3.Checked;
    if dchkStampaVariazioni5.Checked then
      dchkDescLunga5.Checked:=True;
    dchkDescLunga5.Enabled:=not dchkStampaVariazioni5.Checked;
    dcmbDatoStampa6.Enabled:=not dchkDescLunga5.Checked;
  end;
  with (WR302DM as TWS740FRegoleValutazioniDM) do
  begin
    dgrdEtichette.medpAttivaGrid(S740FRegoleValutazioniMW.SG742,selTabella.State in [dsEdit],False,False);
  end;
  //Sempre ReadOnly
  dedtCodiciTipoRapporto.ReadOnly:=True;
  dedtPagineAbilitate.ReadOnly:=True;
end;

end.
