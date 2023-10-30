unit WA071URegoleBuoniDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent, Db,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBComboBox,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, meIWEdit, IWCompCheckbox, meIWDBCheckBox, meIWDBLabel,
  meIWDBLookupComboBox, meIWLabel, IWCompButton, meIWButton,
  A000UInterfaccia, IWAdvCheckGroup, meTIWAdvCheckGroup,
  WC013UCheckListFM, IWCompExtCtrls, IWCompJQueryWidget, A000UCostanti;

type
  TWA071FRegoleBuoniDettFM = class(TWR205FDettTabellaFM)
    dcmbCodice: TmeIWDBLookupComboBox;
    lblCodice: TmeIWLabel;
    lblGestione: TmeIWLabel;
    drgpGestione: TmeIWDBRadioGroup;
    dcmbRegolaSuccessiva: TmeIWDBLookupComboBox;
    lblRegolaSuccessiva: TmeIWLabel;
    dchkGiorniNonLav: TmeIWDBCheckBox;
    dchkAccessiMensa: TmeIWDBCheckBox;
    dchkPausaMensa: TmeIWDBCheckBox;
    dchkOrarioSpezzato: TmeIWDBCheckBox;
    dchkOreMinNettoPM: TmeIWDBCheckBox;
    dchkPausaMensaGestita: TmeIWDBCheckBox;
    dchkMissioni: TmeIWDBCheckBox;
    lblCausaliAssenzaTollerate: TmeIWLabel;
    dedtAssenza: TmeIWDBEdit;
    btnAssenza: TmeIWButton;
    dedtPresenza: TmeIWDBEdit;
    lblCausaliPresenzaEscluse: TmeIWLabel;
    btnPresenza: TmeIWButton;
    lblCausTicket: TmeIWLabel;
    dedtCausTicket: TmeIWDBEdit;
    btnCausTicket: TmeIWButton;
    lblForzaMaturazione: TmeIWLabel;
    dedtForzaMaturazione: TmeIWDBEdit;
    dedtInibMaturazione: TmeIWDBEdit;
    lblInibMaturazione: TmeIWLabel;
    btnInibMaturazione: TmeIWButton;
    lblOreLavorateMinime: TmeIWLabel;
    lblPeriodoCompl: TmeIWLabel;
    dcmbPeriodoCompl: TmeIWDBComboBox;
    dedtOreMinime: TmeIWDBEdit;
    dedtOrePomeriggio: TmeIWDBEdit;
    dedtOreMattina: TmeIWDBEdit;
    lblMattinaPomeriggio: TmeIWLabel;
    lblRientroPom: TmeIWLabel;
    dedtIniPom: TmeIWDBEdit;
    lblNumMaxBuoni: TmeIWLabel;
    dedtDebitoGiornMin: TmeIWDBEdit;
    lblDebitoGiornMin: TmeIWLabel;
    lblEccedenzaMin: TmeIWLabel;
    dedtEccedenzaMin: TmeIWDBEdit;
    dedtNumMaxBuoni: TmeIWDBEdit;
    lblFascia1: TmeIWLabel;
    lblDa1: TmeIWLabel;
    lblA1: TmeIWLabel;
    dedtDa1: TmeIWDBEdit;
    dedtA1: TmeIWDBEdit;
    dchkFascia1Esclusiva: TmeIWDBCheckBox;
    lblFascia2: TmeIWLabel;
    lblDa2: TmeIWLabel;
    lblA2: TmeIWLabel;
    dedtDa2: TmeIWDBEdit;
    dedtA2: TmeIWDBEdit;
    lblIntervallo: TmeIWLabel;
    lblIntervalloMinimo: TmeIWLabel;
    lblIntervalloMassimo: TmeIWLabel;
    dedtIntervalloMinimo: TmeIWDBEdit;
    dedtIntervalloMassimo: TmeIWDBEdit;
    dchkIntervalloEffettivo: TmeIWDBCheckBox;
    cgpGiorniFissi: TmeTIWAdvCheckGroup;
    lblMesiPrecedenti: TmeIWLabel;
    dedtMesiPrecedenti: TmeIWDBEdit;
    lblConguaglioMax: TmeIWLabel;
    dedtConguaglioMax: TmeIWDBEdit;
    lblRestituzioneMax: TmeIWLabel;
    dedtRestituzioneMax: TmeIWDBEdit;
    lblAcquistoMinimo: TmeIWLabel;
    dedtAcquistoMinimo: TmeIWDBEdit;
    lblResiduoPrecedente: TmeIWLabel;
    lblConguaglioMaxPrec: TmeIWLabel;
    dedtConguaglioMaxPrec: TmeIWDBEdit;
    lblAcquistiTeorici: TmeIWLabel;
    lblModalitaPreferenziale: TmeIWLabel;
    drgpAcquistoTeorico: TmeIWDBRadioGroup;
    dchkAssenzeAcquisto: TmeIWDBCheckBox;
    dchkHhMinAcquisto: TmeIWDBCheckBox;
    lblMediaMaxAcquisto: TmeIWLabel;
    dedtMediaMaxAcquisto: TmeIWDBEdit;
    lblMediaMinAcquisto: TmeIWLabel;
    dedtMediaMinAcquisto: TmeIWDBEdit;
    dedtResiduoPrecedente: TmeIWDBEdit;
    cgpPeriodicitaAcquisto: TmeTIWAdvCheckGroup;
    btnForzaMaturazione: TmeIWButton;
    dchkUsaIntervalloMensa: TmeIWDBCheckBox;
    lblDescCodice: TmeIWLabel;
    lblDescRegolaSuccessiva: TmeIWLabel;
    dchkRegolaRientroPomeridiano: TmeIWDBCheckBox;
    lblRientroMassimo: TmeIWLabel;
    dedtRientroMassimo: TmeIWDBEdit;
    drgpTipoGiorniFissi: TmeIWDBRadioGroup;
    lblFasciaDebitoGG: TmeIWLabel;
    lblDebitoMin: TmeIWLabel;
    lblDebitoMax: TmeIWLabel;
    dedtDebitoMin: TmeIWDBEdit;
    dedtDebitoMax: TmeIWDBEdit;
    lblCausAssenzaPM: TmeIWLabel;
    dedtCausAssenzaPM: TmeIWDBEdit;
    btnCausAssenzaPM: TmeIWButton;
    lblTurniLav: TmeIWLabel;
    lblTurniLavGG: TmeIWLabel;
    lblTurniLavOre: TmeIWLabel;
    dedtTurniLavGG: TmeIWDBEdit;
    dedtTurniLavOre: TmeIWDBEdit;
    lblRecupDebito: TmeIWLabel;
    lblRecupDebitoStart: TmeIWLabel;
    lblRecupDebitoMM: TmeIWLabel;
    dedtRecupDebitoMM: TmeIWDBEdit;
    dedtRecupDebitoStart: TmeIWDBEdit;
    dedtSaldoAnnuoMin: TmeIWDBEdit;
    lblSaldoAnnuoMin: TmeIWLabel;
    lblPersonaleTurnista: TmeIWLabel;
    dchkGGLavSempreCalendario: TmeIWDBCheckBox;
    dchkGGLavNoPianifCalendario: TmeIWDBCheckBox;
    dchkIntervalloInternoPMT: TmeIWDBCheckBox;
    dedtQuantita: TmeIWDBEdit;
    lblNumMaxBuoniSett: TmeIWLabel;
    dedtNumMaxBuoniSett: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure ReleaseOggetti; override;
    procedure btnAssenzaClick(Sender: TObject);
    procedure btnPresenzaClick(Sender: TObject);
    procedure btnCausTicketClick(Sender: TObject);
    {procedure dcmbPeriodoComplAsyncSelect(Sender: TObject;
      EventParams: TStringList);}
    procedure cgpGiorniFissiClick(Sender: TObject);
    procedure dcmbRegolaSuccessivaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure dcmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure dedtDebitoGiornMinAsyncExit(Sender: TObject;
      EventParams: TStringList);
    procedure btnCausAssenzaPMClick(Sender: TObject);
    procedure drgpAcquistoTeoricoClick(Sender: TObject);
  private
    Lista265,Lista275,Lista305:TStringList;
    WC013:TWC013FCheckListFM;
    procedure cklistPresenzaResult(Sender: TObject; Result:Boolean);
    procedure cklistAssenzaResult(Sender: TObject; Result:Boolean);
    procedure cklistCausTicketResult(Sender: TObject; Result:Boolean);
    procedure cklistForzaMaturazioneResult(Sender: TObject; Result:Boolean);
    procedure cklistInibMaturazioneResult(Sender: TObject; Result:Boolean);
    procedure cklistAssenzaPMResult(Sender: TObject; Result:Boolean);
    procedure SettaCausali(S:String);
    function GetCausali:String;
  public
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  end;

const PeriodoCompl:array[0..2] of string = ({N}'Giornata intera',
                                            {S}'1°+2° fascia',
                                            {E}'estremi 1° e 2° fascia');
const ValuePeriodoCompl:array[0..2] of string = ('N','S','E');

implementation

uses WA071URegoleBuoni,WA071URegoleBuoniDM,WR100UBase;

{$R *.dfm}

procedure TWA071FRegoleBuoniDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  //attivazione gestione Tab JQuery
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);

  lblCodice.Caption:=Parametri.CampiRiferimento.C4_BuoniMensa;
  dcmbCodice.ListSource:=TWA071FRegoleBuoniDM(WR302DM).DSource;
  dcmbRegolaSuccessiva.ListSource:=TWA071FRegoleBuoniDM(WR302DM).dsrT670lkp;
  Lista265:=TStringList.Create;
  Lista275:=TStringList.Create;
  Lista305:=TStringList.Create;

  with TWA071FRegoleBuoniDM(WR302DM) do
  begin
    Q265.First;
    Lista265.Clear;
    while not Q265.Eof do
    begin
      Lista265.Add(Format('%-5s %s',[Q265.FieldByName('CODICE').AsString,Q265.FieldByName('DESCRIZIONE').AsString]));
      Q265.Next;
    end;
    Q275.First;
    Lista275.Clear;
    while not Q275.Eof do
    begin
      Lista275.Add(Format('%-5s %s',[Q275.FieldByName('CODICE').AsString,Q275.FieldByName('DESCRIZIONE').AsString]));
      Q275.Next;
    end;
    Q305.First;
    Lista305.Clear;
    while not Q305.Eof do
    begin
      Lista305.Add(Format('%-5s %s',[Q305.FieldByName('CODICE').AsString,Q305.FieldByName('DESCRIZIONE').AsString]));
      Q305.Next;
    end;
  end;

  dcmbPeriodoCompl.ItemsHaveValues:=True;
  dcmbPeriodoCompl.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  dcmbPeriodoCompl.Items.Clear;
  dcmbPeriodoCompl.Items.Values[PeriodoCompl[0]]:=ValuePeriodoCompl[0];
  dcmbPeriodoCompl.Items.Values[PeriodoCompl[1]]:=ValuePeriodoCompl[1];
  dcmbPeriodoCompl.Items.Values[PeriodoCompl[2]]:=ValuePeriodoCompl[2];

  lblDescCodice.Caption:='';
  lblDescRegolaSuccessiva.Caption:='';
end;


procedure TWA071FRegoleBuoniDettFM.DataSet2Componenti;
var
  i,y : Integer;
begin
  with TWA071FRegoleBuoniDM(WR302DM) do
  begin
    if QSource.LookUp('CODICE', selTabella.FieldByName('CODICE').AsString , 'DESCRIZIONE') <> null then
      lblDescCodice.Caption:=QSource.LookUp('CODICE', selTabella.FieldByName('CODICE').AsString, 'DESCRIZIONE')
    else
      lblDescCodice.Caption:='';

    if QSource.LookUp('CODICE', selTabella.FieldByName('REGOLA_SUCCESSIVA').AsString, 'DESCRIZIONE') <> null then
      lblDescRegolaSuccessiva.Caption:=TWA071FRegoleBuoniDM(WR302DM).QSource.LookUp('CODICE', selTabella.FieldByName('REGOLA_SUCCESSIVA').AsString, 'DESCRIZIONE')
    else
      lblDescRegolaSuccessiva.Caption:='';

    //Periodicita aquisto
    for i:=0 to cgpPeriodicitaAcquisto.Items.Count - 1 do
      cgpPeriodicitaAcquisto.IsChecked[i]:=R180CarattereDef(selTabella.fieldByName('PERIODICITA_ACQUISTO').AsString,i + 1,'N') = 'S';

    //giorni fissi
    for i:=0 to cgpGiorniFissi.Items.Count - 1 do
      cgpGiorniFissi.IsChecked[i]:=False;

    for i:=0 to cgpGiorniFissi.Items.Count - 1 do
      for y:=1 to Length(selTabella.FieldByName('GIORNI_FISSI').AsString) do
        if (i + 1) = StrToIntDef(selTabella.FieldByName('GIORNI_FISSI').AsString[y],0) then
          cgpGiorniFissi.IsChecked[i]:=True;
  end;
  drgpAcquistoTeoricoClick(drgpAcquistoTeorico);
end;

procedure TWA071FRegoleBuoniDettFM.Componenti2DataSet;
var i:Integer;
    S:String;
begin
  S:='NNNNNNNNNNNN';
  with TWA071FRegoleBuoniDM(WR302DM) do
  begin
    for i:=0 to cgpPeriodicitaAcquisto.Items.Count - 1 do
      if cgpPeriodicitaAcquisto.IsChecked[i] then
        S[i + 1]:='S';
    selTabella.fieldByName('PERIODICITA_ACQUISTO').AsString:=S;

    S:='';
    for i:=0 to cgpGiorniFissi.Items.Count - 1 do
      if cgpGiorniFissi.IsChecked[i] then
        S:=S + IntToStr(i + 1);
    selTabella.FieldByName('GIORNI_FISSI').AsString:=S;

    if dcmbCodice.ItemIndex = -1 then
      selTabellaCODICE.Value:=VarToStr(selTabellaCODICE.OldValue);
  end;
end;


procedure TWA071FRegoleBuoniDettFM.SettaCausali(S:String);
begin
  C190PutCheckList(S,5,WC013.ckList);
end;

procedure TWA071FRegoleBuoniDettFM.btnAssenzaClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.Clear;
    ckList.Items.Assign(Lista265);
    ResultEvent:=cklistAssenzaResult;
    SettaCausali(dedtAssenza.Text);
    WC013.Visualizza;
  end;
end;

procedure TWA071FRegoleBuoniDettFM.btnCausAssenzaPMClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.Clear;
    ckList.Items.Assign(Lista265);
    ResultEvent:=cklistAssenzaPMResult;
    SettaCausali(dedtCausAssenzaPM.Text);
    WC013.Visualizza;
  end;
end;

procedure TWA071FRegoleBuoniDettFM.btnCausTicketClick(Sender: TObject);
var
  LName,LScript: String;
begin
  inherited;
  LScript:='';
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ckList.Items.BeginUpdate;
    ckList.Items.Clear;
    ckList.Items.Add('*** Presenza');
    ckList.IsEnabled[ckList.Items.Count - 1]:=False;
    LName:=Format('%s_CHK_%d',[ckList.HTMLName,ckList.Items.Count]);
    LScript:=LScript + #13#10 + Format('$("#%s").hide(); $("#%s").parent().addClass("wa071_td_header");',[LName,LName]);
    ckList.Items.AddStrings(Lista275);
    ckList.Items.Add('*** Giustificazione');
    ckList.IsEnabled[ckList.Items.Count - 1]:=False;
    LName:=Format('%s_CHK_%d',[ckList.HTMLName,ckList.Items.Count]);
    LScript:=LScript + #13#10 + Format('$("#%s").hide(); $("#%s").parent().addClass("wa071_td_header");',[LName,LName]);
    ckList.Items.AddStrings(Lista305);
    ckList.Items.Add('*** Assenza');
    ckList.IsEnabled[ckList.Items.Count - 1]:=False;
    LName:=Format('%s_CHK_%d',[ckList.HTMLName,ckList.Items.Count]);
    LScript:=LScript + #13#10 + Format('$("#%s").hide(); $("#%s").parent().addClass("wa071_td_header");',[LName,LName]);
    ckList.Items.AddStrings(Lista265);
    ckList.Items.EndUpdate;
    if Sender = btnCausTicket then
    begin
      ResultEvent:=cklistCausTicketResult;
      SettaCausali(dedtCausTicket.Text)
    end
    else if Sender = btnForzaMaturazione then
    begin
      ResultEvent:=cklistForzaMaturazioneResult;
      SettaCausali(dedtForzaMaturazione.Text)
    end
    else
    begin
      ResultEvent:=cklistInibMaturazioneResult;
      SettaCausali(dedtInibMaturazione.Text);
    end;
    Visualizza;
  end;
  (Self.Owner as TWA071FRegoleBuoni).AddToInitProc(LScript);
end;

procedure TWA071FRegoleBuoniDettFM.btnPresenzaClick(Sender: TObject);
begin
  inherited;
  WC013:=TWC013FCheckListFM.Create(Self.Parent);
  with WC013 do
  begin
    ResultEvent:=cklistPresenzaResult;
    ckList.Items.Clear;
    ckList.Items.Assign(Lista275);
    SettaCausali(dedtPresenza.Text);
    WC013.Visualizza;
  end;
end;

procedure TWA071FRegoleBuoniDettFM.cklistPresenzaResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtPresenza.DataField).AsString:=GetCausali;
end;

procedure TWA071FRegoleBuoniDettFM.cklistAssenzaResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtAssenza.DataField).AsString:=GetCausali;
end;

procedure TWA071FRegoleBuoniDettFM.cklistCausTicketResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtCausTicket.DataField).AsString:=GetCausali;
end;

procedure TWA071FRegoleBuoniDettFM.cklistForzaMaturazioneResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtForzaMaturazione.DataField).AsString:=GetCausali;
end;

procedure TWA071FRegoleBuoniDettFM.cklistInibMaturazioneResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtInibMaturazione.DataField).AsString:=GetCausali;
end;

procedure TWA071FRegoleBuoniDettFM.cklistAssenzaPMResult(Sender: TObject; Result:Boolean);
begin
  if Result then
    WR302DM.selTabella.FieldByName(dedtCausAssenzaPM.DataField).AsString:=GetCausali;
end;

procedure TWA071FRegoleBuoniDettFM.dcmbCodiceAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  if TWA071FRegoleBuoniDM(WR302DM).QSource.LookUp('CODICE', dcmbCodice.Text, 'DESCRIZIONE') <> null then
    lblDescCodice.Caption:=TWA071FRegoleBuoniDM(WR302DM).QSource.LookUp('CODICE', dcmbCodice.Text, 'DESCRIZIONE')
  else
    lblDescCodice.Caption:='';
end;

{procedure TWA071FRegoleBuoniDettFM.dcmbPeriodoComplAsyncSelect(Sender: TObject;
  EventParams: TStringList);
begin
  inherited;
  //WR302DM.selTabella.FieldByName(dcmbCodice.DataField).AsString:=WR302DM.selTabella.FieldByName(dcmbCodice.DataField).medpOldValue;
end;}

procedure TWA071FRegoleBuoniDettFM.dcmbRegolaSuccessivaAsyncChange(
  Sender: TObject; EventParams: TStringList);
begin
  inherited;
  if TWA071FRegoleBuoniDM(WR302DM).QSource.LookUp('CODICE', dcmbRegolaSuccessiva.Text, 'DESCRIZIONE') <> null then
    lblDescRegolaSuccessiva.Caption:=TWA071FRegoleBuoniDM(WR302DM).QSource.LookUp('CODICE', dcmbRegolaSuccessiva.Text, 'DESCRIZIONE')
  else
    lblDescRegolaSuccessiva.Caption:='';
end;

procedure TWA071FRegoleBuoniDettFM.dedtDebitoGiornMinAsyncExit(Sender: TObject;
  EventParams: TStringList);
var
  i : Integer;
begin
  inherited;
  if dEdtDebitoGiornMin.Text <> '00.00' then
    for i:=0 to cgpGiorniFissi.Items.Count - 1 do
      cgpGiorniFissi.IsChecked[i]:=False;
  cgpGiorniFissi.AsyncUpdate;

end;

procedure TWA071FRegoleBuoniDettFM.drgpAcquistoTeoricoClick(Sender: TObject);
begin
  inherited;
  dedtQuantita.Enabled:=TmeIWDBRadioGroup(Sender).ItemIndex=2;
end;

procedure TWA071FRegoleBuoniDettFM.cgpGiorniFissiClick(Sender: TObject);
begin
  inherited;
  WR302DM.selTabella.FieldByName(dedtDebitoGiornMin.DataField).AsString:='00.00';
end;

function TWA071FRegoleBuoniDettFM.GetCausali:String;
begin
  Result:=Trim(C190GetCheckList(5,WC013.ckList));
end;

procedure TWA071FRegoleBuoniDettFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(Lista265);//.Free;
  FreeAndNil(Lista275);//.Free;
  FreeAndNil(Lista305);//.Free;
end;

end.
