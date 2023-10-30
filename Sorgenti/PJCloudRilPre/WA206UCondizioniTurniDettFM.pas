unit WA206UCondizioniTurniDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWHTMLControls, meIWLink,
  IWCompLabel, meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompEdit, medpIWMultiColumnComboBox, IWDBStdCtrls, meIWDBEdit,
  IWCompMemo, meIWMemo, IWCompButton, meIWButton, C180FunzioniGenerali,
  A000UCostanti, WC007UFormContainerFM, WC013UCheckListFM, DB, OracleData,
  WA206UCodiciCondizioniTurni, WA206UCodiciCondizioniTurniBrowseFM;

type
  TWA206FCondizioniTurniDettFM = class(TWR205FDettTabellaFM)
    cmbCodSquadra: TMedpIWMultiColumnComboBox;
    lblDescSquadra: TmeIWLabel;
    lblCodTipoOpe: TmeIWLabel;
    cmbCodTipoOpe: TMedpIWMultiColumnComboBox;
    lblDescTipoOpe: TmeIWLabel;
    lblCodOrario: TmeIWLabel;
    cmbCodOrario: TMedpIWMultiColumnComboBox;
    lblDescOrario: TmeIWLabel;
    lblSiglaTurno: TmeIWLabel;
    cmbSiglaTurno: TMedpIWMultiColumnComboBox;
    lblDescSiglaTurno: TmeIWLabel;
    lblCodGiorno: TmeIWLabel;
    cmbCodGiorno: TMedpIWMultiColumnComboBox;
    lblDescGiorno: TmeIWLabel;
    meIWLabel9: TmeIWLabel;
    MedpIWMultiColumnComboBox5: TMedpIWMultiColumnComboBox;
    meIWLabel10: TmeIWLabel;
    cmbCodCondizione: TMedpIWMultiColumnComboBox;
    lblDescCondizione: TmeIWLabel;
    lnkCodSquadra: TmeIWLink;
    lnkCodCondizione: TmeIWLink;
    lblPriorita: TmeIWLabel;
    dedtPriorita: TmeIWDBEdit;
    lblMinimo: TmeIWLabel;
    dedtMinimo: TmeIWDBEdit;
    lblOttimale: TmeIWLabel;
    dedtOttimale: TmeIWDBEdit;
    lblMassimo: TmeIWLabel;
    dedtMassimo: TmeIWDBEdit;
    lblLivelloAnomalia: TmeIWLabel;
    dedtLivelloAnomalia: TmeIWDBEdit;
    lblValore: TmeIWLabel;
    dedtValore: TmeIWDBEdit;
    memValore: TmeIWMemo;
    btnValore: TmeIWButton;
    procedure btnValoreClick(Sender: TObject);
    procedure cmbCodDatoChange(Sender: TObject; Index: Integer);
    procedure lnkCodSquadraClick(Sender: TObject);
    procedure lnkCodCondizioneClick(Sender: TObject);
  private
    { Private declarations }
    WA206FCodiciCondizioniTurni:TWA206FCodiciCondizioniTurni;
    WC007FM:TWC007FFormContainerFM;
    function GetListT020:TElencoValoriChecklist;
    function GetListT265:TElencoValoriChecklist;
    procedure ValoreResult(Sender: TObject; Result: Boolean);
    procedure AggiornaLabel;
    procedure CodiciCondizioniTurniResultEvent(Sender: TObject);
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure AbilitaComponenti; override;
  end;

implementation

uses WA206UCondizioniTurni, WA206UCondizioniTurniDM, WR100UBase;

{$R *.dfm}

procedure TWA206FCondizioniTurniDettFM.DataSet2Componenti;
begin
  inherited;
  (WR302DM as TWA206FCondizioniTurniDM).A206MW.RefreshDataSet;
  (WR302DM as TWA206FCondizioniTurniDM).A206MW.PulisciValori;
  cmbCodSquadra.Text:=WR302DM.selTabella.FieldByName('COD_SQUADRA').AsString;
  cmbCodTipoOpe.Text:=WR302DM.selTabella.FieldByName('COD_TIPOOPE').AsString;
  cmbCodGiorno.Text:=WR302DM.selTabella.FieldByName('COD_GIORNO').AsString;
  cmbCodOrario.Text:=WR302DM.selTabella.FieldByName('COD_ORARIO').AsString;
  cmbSiglaTurno.Text:=WR302DM.selTabella.FieldByName('SIGLA_TURNO').AsString;
  cmbCodCondizione.Text:=WR302DM.selTabella.FieldByName('COD_CONDIZIONE').AsString;
  AggiornaLabel;
end;

procedure TWA206FCondizioniTurniDettFM.Componenti2DataSet;
begin
  inherited;
  WR302DM.selTabella.FieldByName('COD_SQUADRA').AsString:=cmbCodSquadra.Text;
  WR302DM.selTabella.FieldByName('COD_TIPOOPE').AsString:=cmbCodTipoOpe.Text;
  WR302DM.selTabella.FieldByName('COD_GIORNO').AsString:=cmbCodGiorno.Text;
  WR302DM.selTabella.FieldByName('COD_ORARIO').AsString:=cmbCodOrario.Text;
  WR302DM.selTabella.FieldByName('SIGLA_TURNO').AsString:=cmbSiglaTurno.Text;
  WR302DM.selTabella.FieldByName('COD_CONDIZIONE').AsString:=cmbCodCondizione.Text;
end;

procedure TWA206FCondizioniTurniDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM AS TWA206FCondizioniTurniDM).A206MW do
  begin
    cmbCodSquadra.Items.Clear;
    selT603.First;
    while not selT603.Eof do
    begin
      cmbCodSquadra.AddRow(Format('%s;%s',[selT603.FieldByName('CODICE').AsString,selT603.FieldByName('DESCRIZIONE').AsString]));
      selT603.Next;
    end;
    cmbCodTipoOpe.Items.Clear;
    selTipoOpe.First;
    while not selTipoOpe.Eof do
    begin
      cmbCodTipoOpe.AddRow(Format('%s;%s',[selTipoOpe.FieldByName('TIPOOPE').AsString,selTipoOpe.FieldByName('DESCRIZIONE').AsString]));
      selTipoOpe.Next;
    end;
    cmbCodGiorno.Items.Clear;
    selGiorni.First;
    while not selGiorni.Eof do
    begin
      cmbCodGiorno.AddRow(Format('%s;%s',[selGiorni.FieldByName('CODICE').AsString,selGiorni.FieldByName('DESCRIZIONE').AsString]));
      selGiorni.Next;
    end;
    cmbCodOrario.Items.Clear;
    selT020.First;
    while not selT020.Eof do
    begin
      cmbCodOrario.AddRow(Format('%s;%s',[selT020.FieldByName('CODICE').AsString,selT020.FieldByName('DESCRIZIONE').AsString]));
      selT020.Next;
    end;
    cmbSiglaTurno.Items.Clear;
    selT021.First;
    while not selT021.Eof do
    begin
      cmbSiglaTurno.AddRow(Format('%s;%s',[selT021.FieldByName('SIGLATURNI').AsString,selT021.FieldByName('DESCRIZIONE').AsString]));
      selT021.Next;
    end;
    cmbCodCondizione.Items.Clear;
    selT605.First;
    while not selT605.Eof do
    begin
      cmbCodCondizione.AddRow(Format('%s;%s',[selT605.FieldByName('CODICE').AsString,selT605.FieldByName('DESCRIZIONE').AsString]));
      selT605.Next;
    end;
  end;
end;

procedure TWA206FCondizioniTurniDettFM.cmbCodDatoChange(Sender: TObject; Index: Integer);
begin
  inherited;
  Componenti2DataSet;
  DataSet2Componenti;
  CaricaMultiColumnComboBox;
  AbilitaComponenti;
end;

procedure TWA206FCondizioniTurniDettFM.AggiornaLabel;
begin
  inherited;
  lblDescSquadra.Text:=VarToStr((WR302DM as TWA206FCondizioniTurniDM).A206MW.selT603.Lookup('CODICE',cmbCodSquadra.Text,'DESCRIZIONE'));
  lblDescTipoOpe.Text:=VarToStr((WR302DM as TWA206FCondizioniTurniDM).A206MW.selTipoOpe.Lookup('TIPOOPE',cmbCodTipoOpe.Text,'DESCRIZIONE'));
  lblDescGiorno.Text:=VarToStr((WR302DM as TWA206FCondizioniTurniDM).A206MW.selGiorni.Lookup('CODICE',cmbCodGiorno.Text,'DESCRIZIONE'));
  lblDescOrario.Text:=VarToStr((WR302DM as TWA206FCondizioniTurniDM).A206MW.selT020.Lookup('CODICE',cmbCodOrario.Text,'DESCRIZIONE'));
  lblDescSiglaTurno.Text:=VarToStr((WR302DM as TWA206FCondizioniTurniDM).A206MW.selT021.Lookup('SIGLATURNI',cmbSiglaTurno.Text,'DESCRIZIONE'));
  lblDescCondizione.Text:=VarToStr((WR302DM as TWA206FCondizioniTurniDM).A206MW.selT605.Lookup('CODICE',cmbCodCondizione.Text,'DESCRIZIONE'));
end;

procedure TWA206FCondizioniTurniDettFM.AbilitaComponenti;
var Browse,ModificaInCorso,AbilitaBrowseC700,TipoCondOK:Boolean;
    i:Integer;
begin
  inherited;
  with (WR302DM AS TWA206FCondizioniTurniDM).A206MW do
  begin
    TipoCondOK:=TipoCond <> 'E';
    with (Self.Owner as TWA206FCondizioniTurni) do
    begin
      Browse:=not (selT606.State in [dsInsert,dsEdit]);
      actNuovo.Enabled:=actNuovo.Enabled and TipoCondOK;
      actModifica.Enabled:=actModifica.Enabled and TipoCondOK;
      actElimina.Enabled:=actElimina.Enabled and TipoCondOK;
      AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
      AggiornaToolBarStorico(TipoCondOK and not Browse,TipoCondOK and not Browse,TipoCondOK and not Browse,False,False,TipoCondOK and Browse);

      CondOK:=selT605a.SearchRecord('CODICE',selT606.FieldByName('COD_CONDIZIONE').AsString,[srFromBeginning]);

      ModificaInCorso:=(selT606.State in [dsEdit]) or
                       ((selT606.State in [dsInsert]) and InterfacciaWR102.StoricizzazioneInCorso);
      cmbCodSquadra.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('SQUADRA_ABILITA').AsString = 'S');
      lnkCodSquadra.Enabled:=cmbCodSquadra.Enabled;
      cmbCodTipoOpe.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('TIPOOPE_ABILITA').AsString = 'S');
      lblCodTipoOpe.Enabled:=cmbCodTipoOpe.Enabled;
      cmbCodOrario.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('ORARIO_ABILITA').AsString = 'S');
      lblCodOrario.Enabled:=cmbCodOrario.Enabled;
      cmbSiglaTurno.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('TURNO_ABILITA').AsString = 'S');
      lblSiglaTurno.Enabled:=cmbSiglaTurno.Enabled;
      cmbCodGiorno.Enabled:=CondOK and not ModificaInCorso and (selT605a.FieldByName('GIORNO_ABILITA').AsString = 'S');
      lblCodGiorno.Enabled:=cmbCodGiorno.Enabled;
      cmbCodCondizione.Enabled:=not ModificaInCorso;
      lnkCodCondizione.Enabled:=cmbCodCondizione.Enabled;

      ModificaInCorso:=selT606.State in [dsInsert,dsEdit];
      rgpTipoCondizioni.Enabled:=not ModificaInCorso;
      dedtPriorita.Enabled:=CondOK;
      lblPriorita.Enabled:=dedtPriorita.Enabled;
      dedtLivelloAnomalia.Enabled:=CondOK;
      lblLivelloAnomalia.Enabled:=dedtLivelloAnomalia.Enabled;
      dedtMinimo.Enabled:=CondOK and (selT605a.FieldByName('MINIMO_ABILITA').AsString = 'S');
      lblMinimo.Enabled:=dedtMinimo.Enabled;
      dedtOttimale.Enabled:=CondOK and (selT605a.FieldByName('OTTIMALE_ABILITA').AsString = 'S');
      lblOttimale.Enabled:=dedtOttimale.Enabled;
      dedtMassimo.Enabled:=CondOK and (selT605a.FieldByName('MASSIMO_ABILITA').AsString = 'S');
      lblMassimo.Enabled:=dedtMassimo.Enabled;

      memValore.Visible:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S') and (selT605a.FieldByName('VALORE_TIPO').AsString = 'ANAG');
      //C600frmSelAnagrafe.Visible:=memValore.Visible;
      dedtValore.Visible:=not memValore.Visible;
      dedtValore.Enabled:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S') and (selT605a.FieldByName('VALORE_TIPO').AsString = '');
      btnValore.Visible:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S') and R180In(selT605a.FieldByName('VALORE_TIPO').AsString,['T020','T265']);
      btnValore.Enabled:=ModificaInCorso;
      lblValore.Enabled:=CondOK and (selT605a.FieldByName('VALORE_ABILITA').AsString = 'S');

      (*frmSelAnagrafe.Enabled:=not ModificaInCorso;
      frmSelAnagrafe.Visible:=TipoCond <> 'G';
      AbilitaBrowseC700:=TipoCond = 'I';
      frmSelAnagrafe.btnRicerca.Visible:=AbilitaBrowseC700;
      frmSelAnagrafe.btnPrimo.Visible:=AbilitaBrowseC700;
      frmSelAnagrafe.btnPrecedente.Visible:=AbilitaBrowseC700;
      frmSelAnagrafe.btnSuccessivo.Visible:=AbilitaBrowseC700;
      frmSelAnagrafe.btnUltimo.Visible:=AbilitaBrowseC700;
      frmSelAnagrafe.R003Datianagrafici.Visible:=AbilitaBrowseC700;
      frmSelAnagrafe.lblDipendente.Visible:=AbilitaBrowseC700;*)
    end;
  end;
end;

procedure TWA206FCondizioniTurniDettFM.btnValoreClick(Sender: TObject);
var WC013: TWC013FCheckListFM;
  listValori: TElencoValoriChecklist;
  LstSel: TStringList;
  TitoloFinestra: String;
begin
  inherited;
  with (WR302DM AS TWA206FCondizioniTurniDM).A206MW do
    if R180In(selT605a.FieldByName('VALORE_TIPO').AsString,['T020','T265']) then
    begin
      WC013:=TWC013FCheckListFM.Create(Self.Owner);
      if selT605a.FieldByName('VALORE_TIPO').AsString = 'T020' then
      begin
        listValori:=GetListT020;
        TitoloFinestra:='<WC013> Modelli orario';
      end
      else //T265
      begin
        listValori:=GetListT265;
        TitoloFinestra:='<WC013> Causali di assenza';
      end;
      WC013.CaricaLista(listValori.lstDescrizione,listValori.lstCodice);
      FreeAndNil(listValori);
      LstSel:=TStringList.Create;
      LstSel.CommaText:=dedtValore.Text;
      WC013.ImpostaValoriSelezionati(LstSel);
      FreeAndNil(LstSel);
      WC013.ResultEvent:=ValoreResult;
      WC013.Visualizza(0,0,TitoloFinestra);
    end;
end;

function TWA206FCondizioniTurniDettFM.GetListT020:TElencoValoriChecklist;
begin
  Result:=TElencoValoriChecklist.Create;
  with (WR302DM as TWA206FCondizioniTurniDM).A206MW.selT020 do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('CODICE').AsString <> '*' then
      begin
        Result.lstCodice.Add(FieldByName('CODICE').AsString);
        Result.lstDescrizione.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      end;
      Next;
    end;
  end;
end;

function TWA206FCondizioniTurniDettFM.GetListT265:TElencoValoriChecklist;
begin
  Result:=TElencoValoriChecklist.Create;
  with (WR302DM as TWA206FCondizioniTurniDM).A206MW.selT265 do
  begin
    First;
    while not Eof do
    begin
      Result.lstCodice.Add(FieldByName('CODICE').AsString);
      Result.lstDescrizione.Add(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]));
      Next;
    end;
  end;
end;

procedure TWA206FCondizioniTurniDettFM.ValoreResult(Sender: TObject; Result: Boolean);
var lst: TStringList;
begin
  if Result then
  begin
    lst:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    try
      dedtValore.DataSource.DataSet.FieldByName(dedtValore.DataField).AsString:=lst.CommaText;
    finally
      FreeAndNil(lst);
    end;
  end;
end;

procedure TWA206FCondizioniTurniDettFM.lnkCodSquadraClick(Sender: TObject);
var Params: string;
begin
  Params:='CODICE=' + cmbCodSquadra.Text;
  TWR100FBase(Self.Parent).AccediForm(128,Params);
end;

procedure TWA206FCondizioniTurniDettFM.lnkCodCondizioneClick(Sender: TObject);
begin
  inherited;
  WA206FCodiciCondizioniTurni:=TWA206FCodiciCondizioniTurni.Create(TWA206FCondizioniTurni(Self.Owner).Owner,False,cmbCodCondizione.Text);
  WC007FM:=TWC007FFormContainerFM.Create(Self.Parent);
  WC007FM.TemplateProcessor.Templates.Default:='WA206FCodiciCondizioniTurniFM.html';
  WC007FM.ResultEvent:=CodiciCondizioniTurniResultEvent;
  WC007FM.popupWidth:=880;
  WC007FM.popupHeigth:=560;
  WA206FCodiciCondizioniTurni.grdNavigatorBar.Parent:=WC007FM.IWFrameRegion;
  WA206FCodiciCondizioniTurni.grdTabControl.Parent:=WC007FM.IWFrameRegion;
  WA206FCodiciCondizioniTurni.WBrowseFM.Parent:=WC007FM.IWFrameRegion;
  WA206FCodiciCondizioniTurni.WDettaglioFM.Parent:=WC007FM.IWFrameRegion;
  WC007FM.Visualizza('Codici condizioni');
end;

procedure TWA206FCondizioniTurniDettFM.CodiciCondizioniTurniResultEvent(Sender: TObject);
begin
  if WA206FCodiciCondizioniTurni <> nil then
  begin
    WA206FCodiciCondizioniTurni.grdNavigatorBar.Parent:=WA206FCodiciCondizioniTurni;
    WA206FCodiciCondizioniTurni.grdTabControl.Parent:=WA206FCodiciCondizioniTurni;
    WA206FCodiciCondizioniTurni.WBrowseFM.Parent:=WA206FCodiciCondizioniTurni;
    WA206FCodiciCondizioniTurni.WDettaglioFM.Parent:=WA206FCodiciCondizioniTurni;
    FreeAndNil(WA206FCodiciCondizioniTurni);
  end;
end;

end.
