unit WA160URegoleIncentiviDettFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR205UDettTabellaFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls, meIWDBEdit,
  IWCompLabel, meIWLabel, IWCompExtCtrls, IWDBExtCtrls, meIWDBRadioGroup,
  IWCompCheckbox, meIWDBCheckBox, WC013UCheckListFM, C190FunzioniGeneraliWeb, WR010UBase, C180FunzioniGenerali,
  IWCompButton, meIWButton, A160URegoleIncentiviMW, A000UInterfaccia,  A000USessione, meIWEdit,
  medpIWMultiColumnComboBox, meIWDBLabel, Data.Db;

type
  TWA160FRegoleIncentiviDettFM = class(TWR205FDettTabellaFM)
    dedtAbbMax: TmeIWDBEdit;
    lblLivelli: TmeIWLabel;
    drdgTipoCalcolo: TmeIWDBRadioGroup;
    drdgPropInc: TmeIWDBRadioGroup;
    dchkPartTime: TmeIWDBCheckBox;
    dchkScaglioniGgEff: TmeIWDBCheckBox;
    drdgQuoteQuant: TmeIWDBRadioGroup;
    btnLivelli: TmeIWButton;
    dedtLivelli: TmeIWDBEdit;
    dCmbCodice: TMedpIWMultiColumnComboBox;
    lblCodice: TmeIWLabel;
    dLblInterfaccia: TmeIWDBLabel;
    lblFileIstruzioni:TmeIWLabel;
    dedtFileIstruzioni:TmeIWDBEdit;
    lblAbbattimento:TmeIWLabel;
    lblQuoteQuant: TmeIWLabel;
    procedure btnLivelliClick(Sender: TObject);
    procedure dCmbCodiceAsyncChange(Sender: TObject; EventParams: TStringList;
      Index: Integer; Value: string);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure drdgQuoteQuantClick(Sender: TObject);
    procedure drdgTipoCalcoloClick(Sender: TObject);
    procedure drdgPropIncClick(Sender: TObject);
  private
    WC013: TWC013FCheckListFM;
    procedure chklstLivelliResult(Sender: TObject; Result: Boolean);
    procedure CaricaMultiColumnCombobox; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
  public
    procedure AbilitaComponenti; override;
  end;

implementation

{$R *.dfm}

uses WA160URegoleIncentiviDM;

procedure TWA160FRegoleIncentiviDettFM.btnLivelliClick(Sender: TObject);
var
  LstCodice, LstDescrizione, LstCausaliSelezionate: TStringList;
begin
  inherited;
  LstCodice:=TStringList.Create;
  LstDescrizione:=TStringList.Create;
  LstCausaliSelezionate:=TStringList.Create;

  if Trim(Parametri.CampiRiferimento.C7_Dato3) = '' then
    raise exception.Create('Specificare il valore corrispondente a <INCENTIVI: DATO 3> nella Gestione aziende!');

  with (WR302DM as TWA160FRegoleIncentiviDM).A160FRegoleIncentiviMW do
  begin
    QLiv.SQL.Clear;
    if A000LookupTabella(Parametri.CampiRiferimento.C7_Dato3, QLiv) then
    begin
      if QLiv.VariableIndex('DECORRENZA') >= 0 then
        QLiv.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      QLiv.Open;

      WC013:=TWC013FCheckListFM.Create(Self.Parent);
//      WC013.Caption:='<C013> Elenco ' + UpperCase(Copy(Parametri.CampiRiferimento.C7_Dato3,1,1)) +
//                                        LowerCase(Copy(Parametri.CampiRiferimento.C7_Dato3,2,length(Parametri.CampiRiferimento.C7_Dato3)));
      try
        with WC013 do
        begin
          with QLiv do
          begin
            First;
            while not Eof do
            begin
              if Trim(FieldByName('CODICE').AsString) <> '' then
                LstCodice.Add(FieldByName('CODICE').AsString);
              LstDescrizione.Add(Format('%-5s',[FieldByName('CODICE').AsString]) + ' - ' + FieldByName('DESCRIZIONE').AsString);
              Next;
            end;
          end;
          CaricaLista(LstDescrizione, LstCodice);
          LstCausaliSelezionate.Commatext:=dedtLivelli.Text;
          ImpostaValoriSelezionati(LstCausaliSelezionate);
          ResultEvent:=chklstLivelliResult;
          WC013.Visualizza(0,0);
        end;
      finally
        FreeAndNil(LstCodice);
        FreeAndNil(LstDescrizione);
        FreeAndNil(LstCausaliSelezionate);
      end;
    end;
  end;
end;

procedure TWA160FRegoleIncentiviDettFM.chklstLivelliResult(Sender: TObject; Result:Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=(Sender as TWC013FCheckListFM).LeggiValoriSelezionati;
    dedtLivelli.Text:=lstTmp.CommaText;
    WR302DM.selTabella.FieldByName(dedtLivelli.DataField).AsString:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
  end;
end;

procedure TWA160FRegoleIncentiviDettFM.CaricaMultiColumnCombobox;
begin
  inherited;
  with (WR302DM as TWA160FRegoleIncentiviDM).A160FRegoleIncentiviMW do
  begin
    selInterfaccia.First;
    dCmbCodice.Items.Clear;
    while not selInterfaccia.Eof do
    begin
      dcmbCodice.AddRow(selInterfaccia.FieldByName('CODICE').AsString + ';' +
                         selInterfaccia.FieldByName('DESCRIZIONE').AsString);
      selInterfaccia.Next;
    end;
  end;
end;

procedure TWA160FRegoleIncentiviDettFM.DataSet2Componenti;
begin
  with TWA160FRegoleIncentiviDM(WR302DM) do
  begin
    dCmbCodice.Text:=selTabella.FieldByName('LIVELLO').AsString;
  end;
end;

procedure TWA160FRegoleIncentiviDettFM.Componenti2DataSet;
begin
  with TWA160FRegoleIncentiviDM(WR302DM) do
  begin
    selTabella.FieldByName('LIVELLO').AsString:=dCmbCodice.Text;
  end;
end;

procedure TWA160FRegoleIncentiviDettFM.dCmbCodiceAsyncChange(Sender: TObject;
  EventParams: TStringList; Index: Integer; Value: string);
begin
  inherited;
  with TWA160FRegoleIncentiviDM(WR302DM) do
    selTabella.FieldByName('LIVELLO').AsString:=dCmbCodice.Text;
end;

procedure TWA160FRegoleIncentiviDettFM.drdgQuoteQuantClick(Sender: TObject);
begin
  inherited;
  lblFileIstruzioni.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO_QUOTEQUANT').AsString = 'S');
  dedtFileIstruzioni.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO_QUOTEQUANT').AsString = 'S');
end;

procedure TWA160FRegoleIncentiviDettFM.drdgTipoCalcoloClick(Sender: TObject);
begin
  inherited;
  lblLivelli.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO').AsString = 'D');
  dedtLivelli.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO').AsString = 'D');
  btnLivelli.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO').AsString = 'D');
  lblAbbattimento.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO').AsString = 'C');
  dedtAbbMax.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO').AsString = 'C');
  lblQuoteQuant.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO').AsString = 'C');
  drdgQuoteQuant.Visible:=(WR302DM.selTabella.Fieldbyname('TIPO').AsString = 'C');
end;

procedure TWA160FRegoleIncentiviDettFM.drdgPropIncClick(Sender: TObject);
begin
  inherited;
  dchkScaglioniGgEff.Visible:=(WR302DM.selTabella.Fieldbyname('PROPORZIONE_INCENTIVI').AsString = '1');
end;

procedure TWA160FRegoleIncentiviDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  lblCodice.Caption:='Codice ' + Parametri.CampiRiferimento.C7_Dato1;
  lblAbbattimento.Caption:='Penalizzazione max (' + (WR302DM as TWA160FRegoleIncentiviDM).A160FRegoleIncentiviMW.selP030.FieldByName('ABBREVIAZIONE').AsString + ')';
end;

procedure TWA160FRegoleIncentiviDettFM.AbilitaComponenti;
var Tipologia:Integer;
begin
  inherited;
  if TWA160FRegoleIncentiviDM(WR302DM).selTabella.State in [dsEdit,dsInsert, dsBrowse] then
  begin
    drdgPropIncClick (nil);
    drdgQuoteQuantClick (nil);
    drdgTipoCalcoloClick (nil);
  end;
end;
end.
