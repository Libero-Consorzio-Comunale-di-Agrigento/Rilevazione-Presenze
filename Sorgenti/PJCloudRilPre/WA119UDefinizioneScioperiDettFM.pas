unit WA119UDefinizioneScioperiDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompEdit, IWDBStdCtrls,
  meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, medpIWMultiColumnComboBox, meIWEdit, IWCompExtCtrls,
  IWDBExtCtrls, meIWDBRadioGroup, OracleData, meIWImageFile, C180FunzioniGenerali,
  Data.DB, meIWDBLabel, WR203UGestDetailFM, System.Actions, Vcl.ActnList,
  Vcl.Menus, IWCompGrids, meIWGrid, IWDBGrids, medpIWDBGrid;

type
  TWA119FDefinizioneScioperiDettFM = class(TWR205FDettTabellaFM)
    lblData: TmeIWLabel;
    dedtData: TmeIWDBEdit;
    lblDaOre: TmeIWLabel;
    lblAOre: TmeIWLabel;
    dedtDaOre: TmeIWDBEdit;
    dedtAOre: TmeIWDBEdit;
    lblCausale: TmeIWLabel;
    lblDescCausale: TmeIWLabel;
    lblSelezioneAnagrafica: TmeIWLabel;
    drgpTipoGiust: TmeIWDBRadioGroup;
    dedtSelezioneAnagrafica: TmeIWDBEdit;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    cmbCausale: TMedpIWMultiColumnComboBox;
    lblTipoGiust: TmeIWLabel;
    lblGGNotifica: TmeIWLabel;
    dedtGGNotifica: TmeIWDBEdit;
    dlblDescGGNotifica: TmeIWDBLabel;
    procedure drgpTipoGiustClick(Sender: TObject);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure cmbCausale2AsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
  private
    procedure CaricaComboBox(CmbBox: TMedpIWMultiColumnComboBox; DataSet: TOracleDataSet);
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
  public
    procedure OnDsrStateChange;
    procedure OnInserimento;
    procedure SetDescrizioneCausale;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
  end;

implementation

uses WA119UDefinizioneScioperi, WA119UDefinizioneScioperiDM;

{$R *.dfm}

procedure TWA119FDefinizioneScioperiDettFM.CaricaMultiColumnComboBox;
begin
  inherited;
  with (WR302DM as TWA119FDefinizioneScioperiDM).A119MW do
  begin
    CaricaComboBox(cmbCausale,selT265);
  end;
end;

procedure TWA119FDefinizioneScioperiDettFM.CaricaComboBox(CmbBox: TMedpIWMultiColumnComboBox; DataSet: TOracleDataSet);
begin
  with DataSet do
  begin
    Refresh;
    First;
    while not Eof do
    begin
      CmbBox.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
  end;
end;

procedure TWA119FDefinizioneScioperiDettFM.Componenti2DataSet;
begin
  inherited;
  with (WR302DM as TWA119FDefinizioneScioperiDM) do
  begin
    selTabella.FieldByName('CAUSALE').AsString:=cmbCausale.Text;
  end;
end;

procedure TWA119FDefinizioneScioperiDettFM.DataSet2Componenti;
begin
  inherited;
  with (WR302DM as TWA119FDefinizioneScioperiDM) do
  begin
    cmbCausale.Text:=selTabella.FieldByName('CAUSALE').AsString;
    SetDescrizioneCausale;
  end;
end;

procedure TWA119FDefinizioneScioperiDettFM.drgpTipoGiustClick(Sender: TObject);
begin
  inherited;
  // abilitazione dei dati da ore / a ore in base al tipo giustificativo
  dedtDaOre.Enabled:=drgpTipoGiust.ItemIndex > 0;
  dedtAOre.Enabled:=drgpTipoGiust.ItemIndex > 2;
  lblDaOre.Enabled:=dedtDaOre.Enabled;
  lblAOre.Enabled:=dedtAOre.Enabled;
  if drgpTipoGiust.ItemIndex = 1 then
    dedtDaOre.Text:='';
end;

procedure TWA119FDefinizioneScioperiDettFM.cmbCausale2AsyncChange(
  Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  SetDescrizioneCausale;
end;

procedure TWA119FDefinizioneScioperiDettFM.SetDescrizioneCausale;
// imposta la label di descrizione della causale in base al valore della combobox
begin
  lblDescCausale.Caption:=VarToStr((WR302DM as TWA119FDefinizioneScioperiDM).A119MW.selT265.Lookup('CODICE',cmbCausale.Text,'DESCRIZIONE'));
end;

procedure TWA119FDefinizioneScioperiDettFM.imgC700SelezioneAnagrafeClick(Sender: TObject);
begin
  with (WR302DM as TWA119FDefinizioneScioperiDM).selTabella do
  begin
  if State in [dsEdit,dsInsert] then
    with (Self.Owner as TWA119FDefinizioneScioperi).grdC700 do
    begin
      // impedisce di includere i dipendenti cessati nella selezione per lo sciopero
      WC700FM.C700DipendentiCessati:=False;
      WC700FM.C700DipendentiCessatiVal:=False;
      WC700FM.ResultEvent:=ResultSelAnagrafe;
      actSelezioneAnagraficheExecute(nil);
    end;
  end;
end;

procedure TWA119FDefinizioneScioperiDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
  function TrasformaV430(X:String):String;
    var Apice:Boolean;
        i:Integer;
    begin
      Result:='';
      i:=1;
      Apice:=False;
      while i <= Length(X) do
      begin
        if X[i] = '''' then
          Apice:=not Apice;
        if (not Apice) and (Copy(X,i,5) = 'V430.') then
        begin
          X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
          inc(i,5);
        end;
        inc(i);
      end;
      Result:=EliminaRitornoACapo(Trim(X));
    end;
var S:string;
begin
  if Result then
  begin
    S:=Trim((Self.Owner as TWA119FDefinizioneScioperi).grdC700.WC700FM.SQLCreato.Text);
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    //(WR302DM as TWA119FDefinizioneScioperiDM).selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString:=TrasformaV430(S);
    (WR302DM as TWA119FDefinizioneScioperiDM).selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString:=S.Replace(#13#10,' ',[rfReplaceAll]);
  end;
end;

procedure TWA119FDefinizioneScioperiDettFM.OnDsrStateChange;
begin
  imgC700SelezioneAnagrafe.Enabled:=WR302DM.dsrTabella.State in [dsEdit,dsInsert];
  drgpTipoGiustClick(nil);
  SetDescrizioneCausale;
end;

procedure TWA119FDefinizioneScioperiDettFM.OnInserimento;
// metodo da utilizzare in risposta a un inserimento sul dataset
begin
  // necessario per difformità di comportamento win - web
  // forza il default sul primo elemento (giornata intera) perché non viene
  // propagata l'impostazione dal valore del campo del dataset
  drgpTipoGiust.ItemIndex:=0;

  drgpTipoGiustClick(nil);
  SetDescrizioneCausale;

  //dedtData.SetFocus;  // commentato per effetto collaterale del calendar attivo
end;

end.
