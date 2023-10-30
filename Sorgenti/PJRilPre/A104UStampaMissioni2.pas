unit A104UStampaMissioni2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls, Dialogs,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls, Db,
  A000UCostanti, A000USessione,A000UInterfaccia, Variants;

type
  TA104FStampaMissioni2 = class(TQuickRep)
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRShape1: TQRShape;
    QRLblAzienda: TQRLabel;
    QRLblTitolo: TQRLabel;
    QRLblCompetenza: TQRLabel;
    QrLblDipendente: TQRLabel;
    QRGroup1: TQRGroup;
    QRGroup2: TQRGroup;
    QRDBText14: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRLabel15: TQRLabel;
    QRDBText17: TQRDBText;
    QRLabel16: TQRLabel;
    QRDBText18: TQRDBText;
    QRDBText19: TQRDBText;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRDBText20: TQRDBText;
    QRLabel19: TQRLabel;
    QRDBText21: TQRDBText;
    QRLblIndennitaDiTrasferta: TQRLabel;
    QrLblImportoTrasferta: TQRLabel;
    QRShape3: TQRShape;
    QRShape8: TQRShape;
    QRShape9: TQRShape;
    QRDBText4: TQRDBText;
    QRShape17: TQRShape;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText1: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText2: TQRDBText;
    QRLabel9: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel10: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRLabel21: TQRLabel;
    QRSubDetail2: TQRSubDetail;
    QRDBText5: TQRDBText;
    QRDBText12: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText13: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLabel11: TQRLabel;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRDBText9: TQRDBText;
    QRDBText10: TQRDBText;
    QRBand1: TQRBand;
    QRLabel22: TQRLabel;
    QRShape2: TQRShape;
    QRLabel23: TQRLabel;
    QRLblTotaleRimborsi: TQRLabel;
    QRLblTotale: TQRLabel;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape7: TQRShape;
    QRShape4: TQRShape;
    QRShape12: TQRShape;
    QRShape14: TQRShape;
    QRDBText23: TQRDBText;
    QRDBText24: TQRDBText;
    QRBand2: TQRBand;
    QRShape21: TQRShape;
    QRLabel24: TQRLabel;
    QRLblTotaleGenerale: TQRLabel;
    QRDBText25: TQRDBText;
    GroupFooterBand1: TQRBand;
    QRLabel20: TQRLabel;
    QRDBText22: TQRDBText;
    QRDBText11: TQRDBText;
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetail1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2AfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand5BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup4BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    nPv_TotaleGeneraleMissioniDip, nPv_TotaleMissione, nPv_TotaleRimborsi:Currency;//Real;
  public
    bPv_SaltoPagina:Boolean;
    procedure CreaReport;
    constructor Create(AOwner: TComponent); override;
  end;

var
  A104FStampaMissioni2: TA104FStampaMissioni2;

implementation

uses A104UStampaMissioniDtM1;

{$R *.DFM}

constructor TA104FStampaMissioni2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.useQR5Justification:=True;
end;

procedure TA104FStampaMissioni2.CreaReport;
begin

  A104FStampaMissioniDtM1.TabellaStampa.IndexDefs.Clear;
  A104FStampaMissioniDtM1.TabellaStampa.IndexDefs.Add('Indice','mesescarico;contatore',[ixPrimary]);
  A104FStampaMissioniDtM1.TabellaStampa.IndexName:='Indice';

  if bPv_SaltoPagina then
  begin
    QRGroup1.ForceNewPage:=True;
  end
  else
  begin
    QRGroup1.ForceNewPage:=False;
  end;

  if bPv_SaltoPagina then
    QRGroup1.ForceNewPage:=True
  else
    QRGroup1.ForceNewPage:=False;

  A104FStampaMissioni.Preview;
end;

procedure TA104FStampaMissioni2.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QRLblAzienda.Caption:=Parametri.RagioneSociale;
  QRLblCompetenza.Caption:='Mese/Anno cassa: ' + FormatDateTime('mm/yyyy', A104FStampaMissioniDtM1.TabellaStampa.fieldbyname('MESESCARICO').AsDateTime);
end;

procedure TA104FStampaMissioni2.QRSubDetail1BeforePrint(
  Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  if A104FStampaMissioniDtM1.SelM050.Eof then
    PrintBand := False
  else
  begin
    PrintBand := True;
    with A104FStampaMissioniDtM1 do
    begin
      if UpperCase(SelM050FLAG_ANTICIPO.AsString) = 'N' then
      begin
        nPv_TotaleRimborsi:=nPv_TotaleRimborsi + SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
        nPv_TotaleMissione:=nPv_TotaleMissione + SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
      end
      else
      begin
        nPv_TotaleRimborsi:=nPv_TotaleRimborsi - SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
        nPv_TotaleMissione:=nPv_TotaleMissione - SelM050IMPORTORIMBORSOSPESE.AsFloat + SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat;
      end;
    end;
  end;
end;

procedure TA104FStampaMissioni2.QRGroup2AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    SelM050.Close;
    SelM050.SetVariable('PROGRESSIVO',TabellaStampa.fieldbyname('PROGRESSIVO').AsInteger);
    SelM050.SetVariable('MESESCARICO',TabellaStampa.fieldbyname('MESESCARICO').asDateTime);
    SelM050.SetVariable('MESECOMPETENZA',TabellaStampa.fieldbyname('MESECOMPETENZA').asDateTime);
    SelM050.SetVariable('DATADA',TabellaStampa.fieldbyname('DATADA').asDateTime);
    SelM050.SetVariable('ORADA', TabellaStampa.fieldbyname('ORADA').asString);
    SelM050.Open;
  end;
end;

procedure TA104FStampaMissioni2.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  nPv_TotaleMissione:=0;
  nPv_TotaleRimborsi:=0;

  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDINTERA').asFloat <> 0 then
    begin
      QrLblIndennitaDiTrasferta.Caption:='Indennità di trasferta intera';
      QrLblImportoTrasferta.Caption:=TabellaStampa.fieldbyname('IMPORTOINDINTERA').AsString;
      nPv_TotaleMissione:=TabellaStampa.fieldbyname('IMPORTOINDINTERA').AsFloat;
    end
    else if TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAH').AsFloat <> 0 then
    begin
      Q010.Close;
      Q010.SetVariable('DECORRENZA',SelM040DATAA.AsDateTime);
      Q010.Open;
      if Q010.FieldByName('RIDUZIONE_PASTO').AsString='S' then
        QrLblIndennitaDiTrasferta.Caption:='Indennità di trasferta ridotta per rimborso pasto'
      else
        QrLblIndennitaDiTrasferta.Caption:='Indennità di trasferta supero ore';
      QrLblImportoTrasferta.Caption:=TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAH').AsString;
      nPv_TotaleMissione:=TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAH').AsFloat;
    end
    else if TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAG').AsFloat <> 0 then
    begin
      QrLblIndennitaDiTrasferta.Caption:='Indennità di trasferta supero giorni';
      QrLblImportoTrasferta.Caption:=TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAG').AsString;
      nPv_TotaleMissione:=TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAG').AsFloat;
    end
    else if TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAHG').AsFloat <> 0 then
    begin
      QrLblIndennitaDiTrasferta.Caption:='Indennità di trasferta supero ore e giorni';
      QrLblImportoTrasferta.Caption:=TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAHG').AsString;
      nPv_TotaleMissione:=TabellaStampa.fieldbyname('IMPORTOINDRIDOTTAHG').AsFloat;
    end
    else
    begin
      QrLblIndennitaDiTrasferta.Caption:='';
      QrLblImportoTrasferta.Caption:='';
    end;

    nPv_TotaleRimborsi:=TabellaStampa.fieldbyname('IMPORTOINDKMNELCOMUNE').AsFloat + TabellaStampa.fieldbyname('IMPORTOINDKMFUORICOMUNE').AsFloat;
  end;

  nPv_TotaleMissione:=nPv_TotaleMissione + nPv_TotaleRimborsi;

end;

procedure TA104FStampaMissioni2.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if nPv_TotaleRimborsi=0 then
    QRShape2.Width:=0
  else
    QRShape2.Width:=104;
  QrLblTotaleRimborsi.Caption:=FloatToStr(nPv_TotaleRimborsi);
  QrLblTotale.Caption:= FloatToStr(nPv_TotaleMissione);
  nPv_TotaleGeneraleMissioniDip:=nPv_TotaleGeneraleMissioniDip + nPv_TotaleMissione;
end;

procedure TA104FStampaMissioni2.QuickRepBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Screen.Cursor:=crDefault;
end;

procedure TA104FStampaMissioni2.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if SelM050IMPORTOINDENNITASUPPLEMENTARE.AsFloat = 0 then
      PrintBand := False;
  end;
end;

procedure TA104FStampaMissioni2.ChildBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDKMNELCOMUNE').AsFloat = 0 then
      PrintBand := False;
  end;
end;

procedure TA104FStampaMissioni2.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  nPv_TotaleGeneraleMissioniDip:=0;
  with A104FStampaMissioniDtM1 do
  begin
    QrLblDipendente.Caption:=TabellaStampa.fieldbyname('MATRICOLA').asString + ' - ' + TabellaStampa.fieldbyname('COGNOME').asString + ' ' + TabellaStampa.fieldbyname('NOME').asString;
  end;
end;

procedure TA104FStampaMissioni2.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  QrLblTotaleGenerale.Caption:= FloatToStr(nPv_TotaleGeneraleMissioniDip);
end;

procedure TA104FStampaMissioni2.ChildBand5BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDKMFUORICOMUNE').AsFloat = 0 then
      PrintBand := False;
  end;
end;

procedure TA104FStampaMissioni2.QRBand4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    PrintBand:=False;
end;

procedure TA104FStampaMissioni2.QRGroup4BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if bPv_SaltoPagina then
    PrintBand:=False
  else
    PrintBand:=True;
end;

procedure TA104FStampaMissioni2.ChildBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with A104FStampaMissioniDtM1 do
  begin
    if TabellaStampa.fieldbyname('IMPORTOINDKMFUORICOMUNE').AsFloat = 0 then
      PrintBand := False;
  end;
end;

end.
