unit WS030UProvvedimentiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompMemo, IWDBStdCtrls,
  meIWDBMemo, medpIWMultiColumnComboBox, IWHTMLControls, meIWLink, IWCompEdit,
  meIWDBEdit, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, Vcl.Menus, meIWDBLabel, DB, C006UStoriaDati, WC006UStoriaDipFM;

type
  TWS030FProvvedimentiDettFM = class(TWR205FDettTabellaFM)
    lblTipo: TmeIWLabel;
    dRgpTipo: TmeIWDBRadioGroup;
    dEdtDataRegistr: TmeIWDBEdit;
    lblDataRegistr: TmeIWLabel;
    lblDataDecor: TmeIWLabel;
    dEdtDataDecor: TmeIWDBEdit;
    lblDataFine: TmeIWLabel;
    dEdtDataFine: TmeIWDBEdit;
    cmbDato: TMedpIWMultiColumnComboBox;
    lnkMotivazione: TmeIWLink;
    cmbMotivazione: TMedpIWMultiColumnComboBox;
    lblTipoAtto: TmeIWLabel;
    dedtTipoAtto: TmeIWDBEdit;
    lblNumAtto: TmeIWLabel;
    dedtNumAtto: TmeIWDBEdit;
    lblDataAtto: TmeIWLabel;
    dedtDataAtto: TmeIWDBEdit;
    lblDataEsec: TmeIWLabel;
    dedtDataEsec: TmeIWDBEdit;
    lblAutorita: TmeIWLabel;
    dedtAutorita: TmeIWDBEdit;
    cmbSede: TMedpIWMultiColumnComboBox;
    dmemNote: TmeIWDBMemo;
    lblNote: TmeIWLabel;
    lblDato: TmeIWLabel;
    lblSede: TmeIWLabel;
    btnDataDecor: TmeIWButton;
    pmnNumAtto: TPopupMenu;
    miNuovoNumero: TMenuItem;
    dlblDescDato: TmeIWDBLabel;
    dlblDescSede: TmeIWDBLabel;
    dlblDescMotivazione: TmeIWDBLabel;
    dmemTestoVar: TmeIWDBMemo;
    lblTestoVar: TmeIWLabel;
    procedure miNuovoNumeroClick(Sender: TObject);
    procedure dRgpTipoClick(Sender: TObject);
    procedure cmbDatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbMotivazioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure cmbSedeAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure lnkMotivazioneClick(Sender: TObject);
    procedure btnDataDecorClick(Sender: TObject);
  private
    { Private declarations }
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure AbilitaComponenti; override;
    procedure SpostaStoricoResultEvent (Sender: TObject; ResultDec,ResultFine: TDateTime);
  public
    { Public declarations }
    procedure ImpostaCodiceDato;
  end;

implementation

uses WS030UProvvedimenti, WS030UProvvedimentiDM;

{$R *.dfm}

procedure TWS030FProvvedimentiDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWS030FProvvedimentiDM).S030MW do
  begin
    //Dato
    cmbDato.Items.Clear;
    if dRgpTipo.ItemIndex = 0 then
    begin
      selI010.First;
      while not selI010.Eof do
      begin
        cmbDato.AddRow(selI010.FieldByName('CODICE').AsString + ';' + selI010.FieldByName('DESCRIZIONE').AsString);
        selI010.Next;
      end;
    end
    else if dRgpTipo.ItemIndex = 1 then
    begin
      selT265.First;
      while not selT265.Eof do
      begin
        cmbDato.AddRow(selT265.FieldByName('CODICE').AsString + ';' + selT265.FieldByName('DESCRIZIONE').AsString);
        selT265.Next;
      end;
    end;
    //Motivazione
    cmbMotivazione.Items.Clear;
    selSG104.First;
    while not selSG104.Eof do
    begin
      cmbMotivazione.AddRow(selSG104.FieldByName('CODICE').AsString + ';' + selSG104.FieldByName('DESCRIZIONE').AsString);
      selSG104.Next;
    end;
    //Sede
    cmbSede.Items.Clear;
    if selSede.Active then
    begin
      selSede.First;
      while not selSede.Eof do
      begin
        cmbSede.AddRow(selSede.FieldByName('CODICE').AsString + ';' + selSede.FieldByName('DESCRIZIONE').AsString);
        selSede.Next;
      end;
    end
    else
      cmbSede.Enabled:=False;
  end;
  ImpostaCodiceDato;
end;

procedure TWS030FProvvedimentiDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWS030FProvvedimentiDM) do
  begin
    cmbDato.Text:=selTabella.FieldByName('NOMECAMPO').AsString.Trim;
    cmbMotivazione.Text:=selTabella.FieldByName('CAUSALE').AsString.Trim;
    cmbSede.Text:=selTabella.FieldByName('SEDE').AsString.Trim;
  end;
end;

procedure TWS030FProvvedimentiDettFM.Componenti2DataSet;
begin
  inherited;
  with WR302DM do
  begin
    selTabella.FieldByName('NOMECAMPO').AsString:=cmbDato.Text;
    selTabella.FieldByName('CAUSALE').AsString:=cmbMotivazione.Text;
    selTabella.FieldByName('SEDE').AsString:=cmbSede.Text;
  end;
end;

procedure TWS030FProvvedimentiDettFM.AbilitaComponenti;
begin
  inherited;
  btnDataDecor.Enabled:=WR302DM.selTabella.State in [dsEdit,dsInsert];
  miNuovoNumero.Enabled:=WR302DM.selTabella.State in [dsEdit,dsInsert];
end;

procedure TWS030FProvvedimentiDettFM.dRgpTipoClick(Sender: TObject);
begin
  inherited;
  if WR302DM.SelTabella.State in [dsEdit,dsInsert] then
  begin
    cmbDato.Text:='';
    (WR302DM as TWS030FProvvedimentiDM).SelTabella.FieldByName('NOMECAMPO').AsString:=cmbDato.Text;
  end;
  CaricaMultiColumnCombobox;
end;

procedure TWS030FProvvedimentiDettFM.ImpostaCodiceDato;
begin
  if (WR302DM as TWS030FProvvedimentiDM).SelTabella.FieldByName('TIPO_PROVV').AsString = 'A' then
    lblDato.Caption:='Causale assenza'
  else
    lblDato.Caption:='Dato storico';
  if WR302DM.SelTabella.State in [dsEdit,dsInsert] then
    if cmbDato.Items.Count = 1 then
    begin
      cmbDato.Text:=cmbDato.Items[0].RowData[0];
      (WR302DM as TWS030FProvvedimentiDM).SelTabella.FieldByName('NOMECAMPO').AsString:=cmbDato.Text;
    end;
end;

procedure TWS030FProvvedimentiDettFM.cmbDatoAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if WR302DM.SelTabella.State in [dsEdit,dsInsert] then
    (WR302DM as TWS030FProvvedimentiDM).SelTabella.FieldByName('NOMECAMPO').AsString:=cmbDato.Text;//Fa scattare la ricerca della descrizione
end;

procedure TWS030FProvvedimentiDettFM.btnDataDecorClick(Sender: TObject);
var i:Integer;
    C006FStoriaDati: TC006FStoriaDati;
    WC006FStoriaDipFM: TWC006FStoriaDipFM;
    Dato: String;
begin
  if dRgpTipo.ItemIndex = 0 then //Variaz. storiche
  begin
    C006FStoriaDati:=TC006FStoriaDati.Create(nil);
    try
      with (WR302DM as TWS030FProvvedimentiDM) do
      begin
        Dato:=S030MW.selSG100.FieldByName('NomeCampo').AsString;
        C006FStoriaDati.GetStoriaDato(S030MW.SelAnagrafe.FieldByName('Progressivo').AsInteger,Dato);
        cdsStoriaDato.EmptyDataSet;
        for i:=C006FStoriaDati.StoriaDipendente.Count - 1 downto 0 do
        begin
          cdsStoriaDato.Append;
          cdsStoriaDato.FieldByName('KEY').AsString:=IntToStr(cdsStoriaDato.RecordCount);
          cdsStoriaDato.FieldByName('DATO').AsString:=Dato;
          cdsStoriaDato.FieldByName('DATADEC').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataDec;
          cdsStoriaDato.FieldByName('DATAFINE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).DataFine;
          cdsStoriaDato.FieldByName('VALORE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Valore;
          cdsStoriaDato.FieldByName('DESCRIZIONE').AsString:=RecStoria(C006FStoriaDati.StoriaDipendente[i]).Descrizione;
          cdsStoriaDato.FieldByName('RIGACOLORATA').AsBoolean:=False;
          cdsStoriaDato.Post;
        end;
        cdsStoriaDato.First;
        WC006FStoriaDipFM:=TWC006FStoriaDipFM.Create(Self.Owner);
        WC006FStoriaDipFM.CampoColoreRiga:='RIGACOLORATA';
        WC006FStoriaDipFM.Visualizza(cdsrStoriaDato,SpostaStoricoResultEvent);
      end;
    finally
      C006FStoriaDati.Free;
    end;
  end
  else //Giustif. assenza
    with (WR302DM as TWS030FProvvedimentiDM),S030MW do
    begin
      R600DtM.Progressivo:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
      R600DtM.GetPeriodiAssenza(selSG100.FieldByName('NomeCampo').AsString);
      cdsStoriaDato.EmptyDataSet;
      R600DtM.cdsPeriodiAssenza.First;
      while not R600DtM.cdsPeriodiAssenza.Eof do
      begin
        cdsStoriaDato.Append;
        cdsStoriaDato.FieldByName('KEY').AsString:=IntToStr(cdsStoriaDato.RecordCount);
        cdsStoriaDato.FieldByName('DATO').AsString:='Giorni: ' + R600DtM.cdsPeriodiAssenza.FieldByName('TOTALEGG').AsString;
        cdsStoriaDato.FieldByName('DATADEC').AsString:=R600DtM.cdsPeriodiAssenza.FieldByName('DATAINIZIO').AsString;
        cdsStoriaDato.FieldByName('DATAFINE').AsString:=R600DtM.cdsPeriodiAssenza.FieldByName('DATAFINE').AsString;
        cdsStoriaDato.FieldByName('VALORE').AsString:=R600DtM.cdsPeriodiAssenza.FieldByName('CAUSALE').AsString;
        cdsStoriaDato.FieldByName('DESCRIZIONE').AsString:=R600DtM.cdsPeriodiAssenza.FieldByName('DESCRIZIONE').AsString;
        cdsStoriaDato.FieldByName('RIGACOLORATA').AsBoolean:=False;
        cdsStoriaDato.Post;
        R600DtM.cdsPeriodiAssenza.Next;
      end;
      cdsStoriaDato.First;
      WC006FStoriaDipFM:=TWC006FStoriaDipFM.Create(Self.Owner);
      WC006FStoriaDipFM.CampoColoreRiga:='RIGACOLORATA';
      WC006FStoriaDipFM.Visualizza(cdsrStoriaDato,SpostaStoricoResultEvent);
    end;
end;

procedure TWS030FProvvedimentiDettFM.SpostaStoricoResultEvent(Sender: TObject; ResultDec,ResultFine: TDateTime);
begin
  (WR302DM as TWS030FProvvedimentiDM).S030MW.selSG100.FieldByName('DataDecor').AsDateTime:=ResultDec;
  (WR302DM as TWS030FProvvedimentiDM).S030MW.selSG100.FieldByName('DataFine').AsDateTime:=ResultFine;
end;

procedure TWS030FProvvedimentiDettFM.lnkMotivazioneClick(Sender: TObject);
begin
  inherited;
  (Self.Owner as TWS030FProvvedimenti).AccediForm(301,'CODICE=' + cmbMotivazione.Text);
  (WR302DM as TWS030FProvvedimentiDM).S030MW.selSG104.Close;//Serve ad effettuare la riapertura in CaricaMultiColumnCombobox
end;

procedure TWS030FProvvedimentiDettFM.cmbMotivazioneAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if WR302DM.SelTabella.State in [dsEdit,dsInsert] then
    (WR302DM as TWS030FProvvedimentiDM).SelTabella.FieldByName('CAUSALE').AsString:=cmbMotivazione.Text;
end;

procedure TWS030FProvvedimentiDettFM.cmbSedeAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  if WR302DM.SelTabella.State in [dsEdit,dsInsert] then
    (WR302DM as TWS030FProvvedimentiDM).SelTabella.FieldByName('SEDE').AsString:=cmbSede.Text;
end;

procedure TWS030FProvvedimentiDettFM.miNuovoNumeroClick(Sender: TObject);
begin
  inherited;
  //Propongo il nuovo numero atto
  if WR302DM.SelTabella.State in [dsEdit,dsInsert] then
    (WR302DM as TWS030FProvvedimentiDM).SelTabella.FieldByName('NUMATTO').AsString:=(WR302DM as TWS030FProvvedimentiDM).S030MW.NuovoNumeroAtto;
end;

end.
