unit A040UStampa2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt,
  QRPrntr, ExtCtrls, Printers, A000UInterfaccia, Math, StrUtils, DB,
  C001StampaLib, C180FunzioniGenerali;

type
  T040RivalutaCodici = function(pGruppo: string): TStringList of object;

  TA040FStampa2 = class(TR002FQRep)
    QRGroup1: TQRGroup;
    QRLRaggruppamento1: TQRLabel;
    QRBDettaglio: TQRBand;
    QRBHeader: TQRBand;
    QRDBTRaggr1: TQRDBText;
    ChildBand1: TQRChildBand;
    QRLRaggruppamentoChild1: TQRLabel;
    QRDBTRaggrChild1: TQRDBText;
    QRBLegendaHead: TQRBand;
    qlblTurniCod: TQRLabel;
    qlblTurniDesc: TQRLabel;
    qlblCausCod: TQRLabel;
    qlblCausDesc: TQRLabel;
    QRLineHeadB: TQRShape;
    qlblCausTitolo: TQRLabel;
    QRShape2: TQRShape;
    qshpDatoAgg2Titolo: TQRShape;
    qshpTurniTitolo: TQRShape;
    qlblTurniTitolo: TQRLabel;
    QRBLegendaDett: TQRChildBand;
    dlblCausCod: TQRDBText;
    dlblTurniCod: TQRDBText;
    dlblCausDesc: TQRDBText;
    dlblTurniDesc: TQRDBText;
    qshpDatoAgg2Dett: TQRShape;
    QRShape6: TQRShape;
    qshpTurniDett: TQRShape;
    QRLineDettB: TQRShape;
    QRLineHeadT: TQRShape;
    QRLPeriodo: TQRLabel;
    qlblDatoAgg1Titolo: TQRLabel;
    qlblDatoAgg1Cod: TQRLabel;
    qlblDatoAgg1Desc: TQRLabel;
    qlblDatoAgg2Titolo: TQRLabel;
    qlblDatoAgg2Cod: TQRLabel;
    qlblDatoAgg2Desc: TQRLabel;
    dlblDatoAgg1Cod: TQRDBText;
    dlblDatoAgg1Desc: TQRDBText;
    dlblDatoAgg2Cod: TQRDBText;
    dlblDatoAgg2Desc: TQRDBText;
    qshpCausTitolo: TQRShape;
    qshpDatoAgg1Titolo: TQRShape;
    qshpCausDett: TQRShape;
    qshpDatoAgg1Dett: TQRShape;
    QRLRaggruppamentoChild2: TQRLabel;
    QRDBTRaggrChild2: TQRDBText;
    QRLRaggruppamento2: TQRLabel;
    QRDBTRaggr2: TQRDBText;
    bndColonneRaggr: TQRChildBand;
    procedure FormDestroy(Sender: TObject);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRBHeaderBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure QRBLegendaDettAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRBLegendaHeadBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBLegendaDettBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepAfterPreview(Sender: TObject);
    procedure QRepAfterPrint(Sender: TObject);
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBDettaglioAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure QRGroup1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure QRDBTDettPrint(sender: TObject; var Value: string);
    procedure bndColonneRaggrBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
    ArrHead: array of TQRLabel;
    ArrLinesHead: array of TQRShape;
    ArrGroupHead: array of TQRLabel;
    ArrGroupLinesHead: array of TQRShape;
    ArrDett: array of TQRDBText;
    ArrLinesDett: array of TQRShape;
    Spazio: Integer;
    LastBandLegenda: TQRCustomBand;
    GruppoCorrente: TStringList;
    function  ContieneTag(Tag, T: Integer): Boolean;
    procedure AggiornaCodici;
    procedure CreaComponenti;
    procedure DistruggiComponenti;
    procedure RimuoviLegenda;
    function  CreaHeaderLabel(AOwner: TComponent; Par: TWinControl; F: TField; x,y,w: Integer): TQRLabel;
    function  CreaSeparatore(AOwner: TComponent; Par: TWinControl; x: Integer): TQRShape;
    function  CreaDettText(AOwner: TComponent; DS: TDataset; F: TField; x, y, w: Integer): TQRDBText;
    procedure RipartizioneSpazio(SpazioTot,CampiStampati: Integer);
  public
    { Public declarations }
    TitoloStampa: String;
    AbilRaggr: Boolean;
    VisualizzaLegenda: Boolean;
    RivalutaCodici:T040RivalutaCodici;
    Riproporziona: String;  { Usare per distribuire lo spazio restante sulla width dei campi, anche se negativo
                              N  = nessuna riproporzione
                              P  = distribuisce lo spazio proporzionalmente alla width dei campi
                              P+ = come P ma solo se lo spazio restante è positivo
                              F  = distribuisce in modo fisso lo spazio
                              F+ = come F ma solo se lo spazio restante è positivo
                            }
    procedure CreaReport;
  end;

var
  A040FStampa2: TA040FStampa2;

const
  LEFT_INI: Integer = 5;
  TOP_INI: Integer = 4;
  SPAZIO_H: Integer = 4;
  HEIGHT_BAND_HEAD_INI: Integer = 40;
  HEIGHT_BAND_DETT_INI: Integer = 24;
  HEIGHT_FIELD_INI: Integer = 15;
  SPAZIO_LEGENDA: Integer = 5;
  HEIGHT_BAND_LEGENDA_DETT_INI: Integer = 20;

implementation

uses A040UPianifRepDtM2;

{$R *.dfm}

procedure TA040FStampa2.FormCreate(Sender: TObject);
begin
  inherited;
  // inizializzazione variabili
  TitoloStampa:='';
  AbilRaggr:=False;
  VisualizzaLegenda:=False;
  Riproporziona:='N';
end;

procedure TA040FStampa2.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(GruppoCorrente) then
    FreeAndNil(GruppoCorrente);
  DistruggiComponenti;
end;

function TA040FStampa2.ContieneTag(Tag, T: Integer): Boolean;
begin
  Result:=((Tag and T) = T); // and bit a bit
end;

procedure TA040FStampa2.QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  WTurniCod,WTurniDesc,WCausCod,WCausDesc,WDatoAgg1Cod,WDatoAgg1Desc,WDatoAgg2Cod,WDatoAgg2Desc,
  WLegendaTurni,WLegendaCaus,WLegendaDatoAgg1,WLegendaDatoAgg2,
  WTot,WDiff,nLeft: Integer;
begin
  inherited;
  // titolo stampa
  LEnte.Caption:=Parametri.RagioneSociale;
  LTitolo.Caption:=TitoloStampa;
  with A040FPianifRepDtM2 do
    if (DataInizio = R180InizioMese(DataInizio)) and
       (DataFine = R180FineMese(DataInizio)) then
      QRLPeriodo.Caption:='Mese di ' + R180NomeMese(R180Mese(DataInizio)) +
                          ' ' + IntToStr(R180Anno(DataInizio))
    else if DataInizio = DataFine then
      QRLPeriodo.Caption:='Giorno: ' + FormatDateTime('dd/mm/yyyy',DataInizio)
    else
      QRLPeriodo.Caption:='Periodo ' + FormatDateTime('dd/mm/yyyy',DataInizio) +
                          ' - ' + FormatDateTime('dd/mm/yyyy',DataFine);
  // legenda
  qlblDatoAgg1Titolo.Caption:='LEGENDA ' + UpperCase(A040FPianifRepDtM2.GetNomeLogico(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg1));
  qlblDatoAgg2Titolo.Caption:='LEGENDA ' + UpperCase(A040FPianifRepDtM2.GetNomeLogico(Parametri.CampiRiferimento.C29_ChiamateRepDatoAgg2));
  QRBLegendaHead.Enabled:=False;
  QRBLegendaDett.Enabled:=False;
  if VisualizzaLegenda then
  begin
    with A040FPianifRepDtM2.cdsLegenda do
    if RecordCount > 0 then
    begin
      First;
      QRBLegendaHead.Enabled:=True;
      QRBLegendaDett.Enabled:=True;
      //turni
      qlblTurniTitolo.Enabled:=FieldByName('CODTURNO').Visible;
      qlblTurniTitolo.Transparent:=not FieldByName('CODTURNO').Visible;
      qlblTurniCod.Enabled:=qlblTurniTitolo.Enabled;
      qlblTurniCod.Transparent:=qlblTurniTitolo.Transparent;
      qlblTurniDesc.Enabled:=qlblTurniTitolo.Enabled;
      qlblTurniDesc.Transparent:=qlblTurniTitolo.Transparent;
      qshpTurniTitolo.Enabled:=qlblTurniTitolo.Enabled;
      dlblTurniCod.Enabled:=qlblTurniTitolo.Enabled;
      dlblTurniCod.Transparent:=qlblTurniTitolo.Transparent;
      dlblTurniDesc.Enabled:=qlblTurniTitolo.Enabled;
      dlblTurniDesc.Transparent:=qlblTurniTitolo.Transparent;
      qshpTurniDett.Enabled:=qlblTurniTitolo.Enabled;
      //assenze
      qlblCausTitolo.Enabled:=FieldByName('CODCAUS').Visible;
      qlblCausTitolo.Transparent:=not FieldByName('CODCAUS').Visible;
      qlblCausCod.Enabled:=qlblCausTitolo.Enabled;
      qlblCausCod.Transparent:=qlblCausTitolo.Transparent;
      qlblCausDesc.Enabled:=qlblCausTitolo.Enabled;
      qlblCausDesc.Transparent:=qlblCausTitolo.Transparent;
      qshpCausTitolo.Enabled:=qlblCausTitolo.Enabled;
      dlblCausCod.Enabled:=qlblCausTitolo.Enabled;
      dlblCausCod.Transparent:=qlblCausTitolo.Transparent;
      dlblCausDesc.Enabled:=qlblCausTitolo.Enabled;
      dlblCausDesc.Transparent:=qlblCausTitolo.Transparent;
      qshpCausDett.Enabled:=qlblCausTitolo.Enabled;
      //dato aggiuntivo 1
      qlblDatoAgg1Titolo.Enabled:=FieldByName('CODDATOAGG1').Visible;
      qlblDatoAgg1Titolo.Transparent:=not FieldByName('CODDATOAGG1').Visible;
      qlblDatoAgg1Cod.Enabled:=qlblDatoAgg1Titolo.Enabled;
      qlblDatoAgg1Cod.Transparent:=qlblDatoAgg1Titolo.Transparent;
      qlblDatoAgg1Desc.Enabled:=qlblDatoAgg1Titolo.Enabled;
      qlblDatoAgg1Desc.Transparent:=qlblDatoAgg1Titolo.Transparent;
      qshpDatoAgg1Titolo.Enabled:=qlblDatoAgg1Titolo.Enabled;
      dlblDatoAgg1Cod.Enabled:=qlblDatoAgg1Titolo.Enabled;
      dlblDatoAgg1Cod.Transparent:=qlblDatoAgg1Titolo.Transparent;
      dlblDatoAgg1Desc.Enabled:=qlblDatoAgg1Titolo.Enabled;
      dlblDatoAgg1Desc.Transparent:=qlblDatoAgg1Titolo.Transparent;
      qshpDatoAgg1Dett.Enabled:=qlblDatoAgg1Titolo.Enabled;
      //dato aggiuntivo 2
      qlblDatoAgg2Titolo.Enabled:=FieldByName('CODDATOAGG2').Visible;
      qlblDatoAgg2Titolo.Transparent:=not FieldByName('CODDATOAGG2').Visible;
      qlblDatoAgg2Cod.Enabled:=qlblDatoAgg2Titolo.Enabled;
      qlblDatoAgg2Cod.Transparent:=qlblDatoAgg2Titolo.Transparent;
      qlblDatoAgg2Desc.Enabled:=qlblDatoAgg2Titolo.Enabled;
      qlblDatoAgg2Desc.Transparent:=qlblDatoAgg2Titolo.Transparent;
      qshpDatoAgg2Titolo.Enabled:=qlblDatoAgg2Titolo.Enabled;
      dlblDatoAgg2Cod.Enabled:=qlblDatoAgg2Titolo.Enabled;
      dlblDatoAgg2Cod.Transparent:=qlblDatoAgg2Titolo.Transparent;
      dlblDatoAgg2Desc.Enabled:=qlblDatoAgg2Titolo.Enabled;
      dlblDatoAgg2Desc.Transparent:=qlblDatoAgg2Titolo.Transparent;
      qshpDatoAgg2Dett.Enabled:=qlblDatoAgg2Titolo.Enabled;
      //spazio occupato da ogni campo di dettaglio
      WTurniCod:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('CODTURNO').DisplayWidth)),qlblTurniCod.Width);
      WTurniDesc:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('DESCTURNO').DisplayWidth)),qlblTurniDesc.Width);
      WCausCod:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('CODCAUS').DisplayWidth)),qlblCausCod.Width);
      WCausDesc:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('DESCCAUS').DisplayWidth)),qlblCausDesc.Width);
      WDatoAgg1Cod:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('CODDATOAGG1').DisplayWidth)),qlblDatoAgg1Cod.Width);
      WDatoAgg1Desc:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('DESCDATOAGG1').DisplayWidth)),qlblDatoAgg1Desc.Width);
      WDatoAgg2Cod:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('CODDATOAGG2').DisplayWidth)),qlblDatoAgg2Cod.Width);
      WDatoAgg2Desc:=max(QRep.TextWidth(QRep.Font,StringOfChar('Z',FieldByName('DESCDATOAGG2').DisplayWidth)),qlblDatoAgg2Desc.Width);
      //spazio occupato da ogni legenda
      WLegendaTurni:=IfThen(FieldByName('CODTURNO').Visible,max(WTurniCod + SPAZIO_LEGENDA + SPAZIO_LEGENDA + WTurniDesc,qlblTurniTitolo.Width));
      WLegendaCaus:=IfThen(FieldByName('CODCAUS').Visible,max(WCausCod + SPAZIO_LEGENDA + SPAZIO_LEGENDA + WCausDesc,qlblCausTitolo.Width));
      WLegendaDatoAgg1:=IfThen(FieldByName('CODDATOAGG1').Visible,max(WDatoAgg1Cod + SPAZIO_LEGENDA + SPAZIO_LEGENDA + WDatoAgg1Desc,qlblDatoAgg1Titolo.Width));
      WLegendaDatoAgg2:=IfThen(FieldByName('CODDATOAGG2').Visible,max(WDatoAgg2Cod + SPAZIO_LEGENDA + SPAZIO_LEGENDA + WDatoAgg2Desc,qlblDatoAgg2Titolo.Width));
      //spazio totale occupato
      WTot:=WLegendaTurni + WLegendaCaus + WLegendaDatoAgg1 + WLegendaDatoAgg2;
      //spazio rimanente/eccedente (differenza tenendo conto anche degli spazi prima e dopo)
      WDiff:=QRBLegendaHead.Width - (WTot + IfThen(WLegendaTurni > 0,SPAZIO_LEGENDA + SPAZIO_LEGENDA) +
                                            IfThen(WLegendaCaus > 0,SPAZIO_LEGENDA + SPAZIO_LEGENDA) +
                                            IfThen(WLegendaDatoAgg1 > 0,SPAZIO_LEGENDA + SPAZIO_LEGENDA) +
                                            IfThen(WLegendaDatoAgg2 > 0,SPAZIO_LEGENDA + SPAZIO_LEGENDA));
      if WDiff < 0 then
      begin
        //restringo ogni legenda in proporzione alla lunghezza totale (arrotondo la riduzione all'intero successivo per sicurezza)
        WLegendaTurni:=WLegendaTurni + Round((WLegendaTurni * WDiff / WTot) + 0.49);
        WLegendaCaus:=WLegendaCaus + Round((WLegendaCaus * WDiff / WTot) + 0.49);
        WLegendaDatoAgg1:=WLegendaDatoAgg1 + Round((WLegendaDatoAgg1 * WDiff / WTot) + 0.49);
        WLegendaDatoAgg2:=WLegendaDatoAgg2 + Round((WLegendaDatoAgg2 * WDiff / WTot) + 0.49);
      end;
      //posizionamento e dimensionamento titoli e campi
      nLeft:=0;
      if FieldByName('CODTURNO').Visible then
      begin
        qlblTurniTitolo.Left:=nLeft + SPAZIO_LEGENDA;
        qlblTurniCod.Left:=qlblTurniTitolo.Left;
        dlblTurniCod.Left:=qlblTurniTitolo.Left;
        dlblTurniCod.Width:=WTurniCod;
        qlblTurniDesc.Left:=dlblTurniCod.Left + dlblTurniCod.Width + SPAZIO_LEGENDA + SPAZIO_LEGENDA;
        dlblTurniDesc.Left:=qlblTurniDesc.Left;
        dlblTurniDesc.Width:=WTurniDesc;
        if (dlblTurniDesc.Left + dlblTurniDesc.Width) > (qlblTurniTitolo.Left + WLegendaTurni) then
          dlblTurniDesc.Width:=dlblTurniDesc.Width - ((dlblTurniDesc.Left + dlblTurniDesc.Width) - (qlblTurniTitolo.Left + WLegendaTurni));
        nLeft:=qlblTurniTitolo.Left + WLegendaTurni + SPAZIO_LEGENDA;
        qshpTurniTitolo.Left:=nLeft;
        qshpTurniDett.Left:=qshpTurniTitolo.Left;
      end;
      if FieldByName('CODCAUS').Visible then
      begin
        qlblCausTitolo.Left:=nLeft + SPAZIO_LEGENDA;
        qlblCausCod.Left:=qlblCausTitolo.Left;
        dlblCausCod.Left:=qlblCausTitolo.Left;
        dlblCausCod.Width:=WCausCod;
        qlblCausDesc.Left:=dlblCausCod.Left + dlblCausCod.Width + SPAZIO_LEGENDA + SPAZIO_LEGENDA;
        dlblCausDesc.Left:=qlblCausDesc.Left;
        dlblCausDesc.Width:=WCausDesc;
        if (dlblCausDesc.Left + dlblCausDesc.Width) > (qlblCausTitolo.Left + WLegendaCaus) then
          dlblCausDesc.Width:=dlblCausDesc.Width - ((dlblCausDesc.Left + dlblCausDesc.Width) - (qlblCausTitolo.Left + WLegendaCaus));
        nLeft:=qlblCausTitolo.Left + WLegendaCaus + SPAZIO_LEGENDA;
        qshpCausTitolo.Left:=nLeft;
        qshpCausDett.Left:=qshpCausTitolo.Left;
      end;
      if FieldByName('CODDATOAGG1').Visible then
      begin
        qlblDatoAgg1Titolo.Left:=nLeft + SPAZIO_LEGENDA;
        qlblDatoAgg1Cod.Left:=qlblDatoAgg1Titolo.Left;
        dlblDatoAgg1Cod.Left:=qlblDatoAgg1Titolo.Left;
        dlblDatoAgg1Cod.Width:=WDatoAgg1Cod;
        qlblDatoAgg1Desc.Left:=dlblDatoAgg1Cod.Left + dlblDatoAgg1Cod.Width + SPAZIO_LEGENDA + SPAZIO_LEGENDA;
        dlblDatoAgg1Desc.Left:=qlblDatoAgg1Desc.Left;
        dlblDatoAgg1Desc.Width:=WDatoAgg1Desc;
        if (dlblDatoAgg1Desc.Left + dlblDatoAgg1Desc.Width) > (qlblDatoAgg1Titolo.Left + WLegendaDatoAgg1) then
          dlblDatoAgg1Desc.Width:=dlblDatoAgg1Desc.Width - ((dlblDatoAgg1Desc.Left + dlblDatoAgg1Desc.Width) - (qlblDatoAgg1Titolo.Left + WLegendaDatoAgg1));
        nLeft:=qlblDatoAgg1Titolo.Left + WLegendaDatoAgg1 + SPAZIO_LEGENDA;
        qshpDatoAgg1Titolo.Left:=nLeft;
        qshpDatoAgg1Dett.Left:=qshpDatoAgg1Titolo.Left;
      end;
      if FieldByName('CODDATOAGG2').Visible then
      begin
        qlblDatoAgg2Titolo.Left:=nLeft + SPAZIO_LEGENDA;
        qlblDatoAgg2Cod.Left:=qlblDatoAgg2Titolo.Left;
        dlblDatoAgg2Cod.Left:=qlblDatoAgg2Titolo.Left;
        dlblDatoAgg2Cod.Width:=WDatoAgg2Cod;
        qlblDatoAgg2Desc.Left:=dlblDatoAgg2Cod.Left + dlblDatoAgg2Cod.Width + SPAZIO_LEGENDA + SPAZIO_LEGENDA;
        dlblDatoAgg2Desc.Left:=qlblDatoAgg2Desc.Left;
        dlblDatoAgg2Desc.Width:=WDatoAgg2Desc;
        if (dlblDatoAgg2Desc.Left + dlblDatoAgg2Desc.Width) > (qlblDatoAgg2Titolo.Left + WLegendaDatoAgg2) then
          dlblDatoAgg2Desc.Width:=dlblDatoAgg2Desc.Width - ((dlblDatoAgg2Desc.Left + dlblDatoAgg2Desc.Width) - (qlblDatoAgg2Titolo.Left + WLegendaDatoAgg2));
        nLeft:=qlblDatoAgg2Titolo.Left + WLegendaDatoAgg2 + SPAZIO_LEGENDA;
        qshpDatoAgg2Titolo.Left:=nLeft;
        qshpDatoAgg2Dett.Left:=qshpDatoAgg2Titolo.Left;
      end;
      QRLineHeadT.Width:=nLeft;
      QRLineHeadB.Width:=nLeft;
      QRLineDettB.Width:=nLeft;
    end;
  end;
end;

procedure TA040FStampa2.QRepAfterPreview(Sender: TObject);
begin
  inherited;
  if VisualizzaLegenda then
    RimuoviLegenda;
end;

procedure TA040FStampa2.QRepAfterPrint(Sender: TObject);
begin
  inherited;
  if VisualizzaLegenda then
    RimuoviLegenda;
end;

procedure TA040FStampa2.QRGroup1AfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  if VisualizzaLegenda then
  begin
    RimuoviLegenda;
    if A040FPianifRepDtM2.cdsLegenda.RecordCount > 0 then
      A040FPianifRepDtM2.cdsLegenda.First;
  end;
end;

procedure TA040FStampa2.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  QRDBTRaggr1.Left:=QRLRaggruppamento1.Left + QRLRaggruppamento1.Width + 5;
  QRDBTRaggr2.Left:=QRLRaggruppamento2.Left + QRLRaggruppamento2.Width + 5;
  PrintBand:=AbilRaggr;
end;

procedure TA040FStampa2.QRBHeaderBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i,altezza: Integer;
  h: Extended;
begin
  inherited;
  // ricalcola altezza banda
  if Sender = QRBDettaglio then
    // imposta height di default
    Sender.Height:=HEIGHT_BAND_DETT_INI
  else if Sender = QRBHeader then
  begin
    PrintBand:=QRBHeader.Height > 0;
    // imposta height di default
    Sender.Height:=HEIGHT_BAND_HEAD_INI;
  end;

  Sender.ExpandedHeight(h);
  altezza:=Round(h * ProporzioneBandExpanded);
  Sender.Height:=altezza;

  // imposta l'altezza dei componenti pari all'altezza della banda
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if Sender.Controls[i] is TQRLabel then
      TQRLabel(Sender.Controls[i]).Height:=altezza
    else if Sender.Controls[i] is TQRDBText then
      TQRDBText(Sender.Controls[i]).Height:=altezza
    else if Sender.Controls[i] is TQRShape then
    begin
      if TQRShape(Sender.Controls[i]).Shape = qrsVertLine then
        TQRShape(Sender.Controls[i]).Height:=altezza;
    end;
  end;
end;

// Creazione dinamica dei componenti
function TA040FStampa2.CreaHeaderLabel(AOwner: TComponent; Par: TWinControl; F: TField; x,y,w: Integer): TQRLabel;
begin
  Result:=TQRLabel.Create(AOwner);
  with Result do
  begin
    Parent:=Par;
    Caption:=F.DisplayName;
    Left:=x;
    Top:=y;
    Height:=HEIGHT_FIELD_INI;
    Width:=w;
    AutoSize:=False;
    AutoStretch:=True;
    WordWrap:=True;
    Alignment:=taCenter;
    Font:=QRep.Font;
    Tag:=F.Tag;
    if ContieneTag(Tag,TAG_EVIDENZIA_FESTIVI) then
    begin
      Font.Style:=Font.Style + [fsBold];
      Font.Color:=clRed;
    end;
  end;
end;

function TA040FStampa2.CreaSeparatore(AOwner: TComponent; Par: TWinControl; x: Integer): TQRShape;
begin
  Result:=TQRShape.Create(AOwner);
  with Result do
  begin
    Parent:=Par;
    Enabled:=True;
    Shape:=qrsVertLine;
    Pen.Style:=psSolid;
    Left:=x;
    Top:=0;
    Width:=1;
    Height:=QRBHeader.Height;
  end;
end;

function TA040FStampa2.CreaDettText(AOwner: TComponent; DS: TDataset;
  F: TField; x, y, w: Integer): TQRDBText;
begin
  Result:=TQRDBText.Create(AOwner);
  with Result do
  begin
    Parent:=QRBDettaglio;
    DataSet:=DS;
    DataField:=F.FieldName;
    Alignment:=F.Alignment;
    Left:=x;
    Top:=y;
    Height:=HEIGHT_FIELD_INI;
    Width:=w;
    AutoSize:=False;
    AutoStretch:=True;
    WordWrap:=True;
    Font:=QRep.Font;
    Tag:=F.Tag;
    OnPrint:=QRDBTDettPrint;
  end;
end;

procedure TA040FStampa2.QRDBTDettPrint(sender: TObject; var Value: string);
var
  N: String;
  Fest: Boolean;
begin
  inherited;

  N:=TQRDBText(Sender).DataField;

  if ContieneTag(TQRDBText(Sender).Tag,TAG_EVIDENZIA_FESTIVI) then
  begin
    Fest:=True;

    if (N = 'DATA') and (A040FPianifRepDtM2.IsFestivo(StrToDate(Value))) then //(DayOfWeek(StrToDate(Value)) = 1) then
      Fest:=True
    else if (N = 'DD') and
            (A040FPianifRepDtM2.IsFestivo(EncodeDate(R180Anno(A040FPianifRepDtM2.DataInizio),
                                                     R180Mese(A040FPianifRepDtM2.DataInizio),
                                                     StrToInt(Value)))) then
            {(DayOfWeek(EncodeDate(R180Anno(A040FPianifRepDtM2.DataInizio),
                                  R180Mese(A040FPianifRepDtM2.DataInizio),
                                  StrToInt(Value))) = 1) then
            }
      Fest:=True
    else if (N = 'GG') then // and (LowerCase(Copy(Value,1,3)) = 'dom') then
    begin
      Fest:=(A040FPianifRepDtM2.IsFestivo(EncodeDate(R180Anno(A040FPianifRepDtM2.DataInizio),
                                                     R180Mese(A040FPianifRepDtM2.DataInizio),
                                                     StrToInt(Copy(Value,5,MAXINT)))));
      Value:=Copy(Value,1,3);
    end
    else
      Fest:=False;

    // evidenzia il giorno festivo
    if Fest then
    begin
      TQRDBText(Sender).Font.Style:=Font.Style + [fsBold];
      TQRDBText(Sender).Font.Color:=clRed;
    end
    else
      TQRDBText(Sender).Font:=QRep.Font;
  end;
end;

procedure TA040FStampa2.AggiornaCodici;
var i,j,p,iMin: integer;
    LstCodici, LstAppoggio: TStringList;
    Gruppo: TStringList;
    T: TTurno;
begin
  inherited;
  if not Assigned(RivalutaCodici) then
   exit;
  j:=0;
  Gruppo:=TStringList.Create;
  Gruppo.Add(QRDBTRaggrChild1.DataSet.FieldByName(QRDBTRaggrChild1.DataField).AsString);
  if QRDBTRaggrChild2.DataField <> '' then
    Gruppo.Add(QRDBTRaggrChild2.DataSet.FieldByName(QRDBTRaggrChild2.DataField).AsString);
  if Gruppo.CommaText <> GruppoCorrente.CommaText then
  begin
    GruppoCorrente.CommaText:=Gruppo.CommaText;

    if A040FPianifRepDtM2.RaggrDatiAgg then
    begin
      A040FPianifRepDtM2.selT380.Open;
      A040FPianifRepDtM2.selT380.First;
      LstCodici:=TStringList.Create;
      LstAppoggio:=TStringList.Create;
      LstAppoggio.Sorted:=True;
      LstAppoggio.Duplicates:=dupIgnore;
      while not A040FPianifRepDtM2.selT380.Eof do
      begin
        for p:=1 to 3 do
        begin
          if (A040FPianifRepDtM2.GetValDatoAgg('1',p.ToString) = Gruppo[0]) then
            if ((Gruppo.Count = 2) and (A040FPianifRepDtM2.GetValDatoAgg('2',p.ToString) = Gruppo[1])) or (Gruppo.Count = 1) then
              LstAppoggio.Add(A040FPianifRepDtM2.selT380.FieldByname(Format('TURNO%.1d',[p])).AsString);
        end;
        A040FPianifRepDtM2.selT380.Next;
      end;

      for p:=0 to LstAppoggio.Count-1 do
      begin
        T:=A040FPianifRepDtM2.GetTurno(LstAppoggio[p]);
        LstCodici.Add(Format('Turno %s%s%s - %s',[T.Codice,#13#10,T.OraInizio,T.OraFine]));
        if A040FPianifRepDtM2.NomeCampoDett <> '' then
          LstCodici.Add(A040FPianifRepDtM2.NomeLogicoDett);
      end;
    end
    else
      LstCodici:=RivalutaCodici(GruppoCorrente.CommaText);

    iMin:=IfThen(A040FPianifRepDtM2.NomeCampoRaggr2 <> '',5,4);
    for i:=iMin to High(ArrHead) do
    begin
      if j <= LstCodici.Count-1 then
        ArrHead[i].Caption:=LstCodici[j]
      else
        ArrHead[i].Caption:='';
      ArrGroupHead[i].Caption:=ArrHead[i].Caption;
      inc(j);
    end;
    FreeAndNil(Gruppo);
    FreeAndNil(LstCodici);
    if Assigned(LstAppoggio) then
      FreeAndNil(LstAppoggio);
  end;
end;

procedure TA040FStampa2.bndColonneRaggrBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i,altezza: Integer;
  h: Extended;
begin
  inherited;
  if QRGroup1.height > 0 then
  begin
    AggiornaCodici;
    Sender.Height:=HEIGHT_BAND_HEAD_INI;
    Sender.ExpandedHeight(h);
    altezza:=Round(h * ProporzioneBandExpanded);
    Sender.Height:=altezza;

    // imposta l'altezza dei componenti pari all'altezza della banda
    for i:=0 to Sender.ControlCount - 1 do
    begin
      if Sender.Controls[i] is TQRLabel then
        TQRLabel(Sender.Controls[i]).Height:=altezza
      else if Sender.Controls[i] is TQRDBText then
        TQRDBText(Sender.Controls[i]).Height:=altezza
      else if Sender.Controls[i] is TQRShape then
      begin
        if TQRShape(Sender.Controls[i]).Shape = qrsVertLine then
          TQRShape(Sender.Controls[i]).Height:=altezza;
      end;
    end;
  end;
  PrintBand:=QRGroup1.height > 0;
  if PrintBand then
    QRBHeader.Height:=0;
end;

procedure TA040FStampa2.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  QRGroup1.Height:=0;
  QRDBTRaggrChild1.Left:=QRLRaggruppamentoChild1.Left + QRLRaggruppamentoChild1.Width + 5;
  QRDBTRaggrChild2.Left:=QRLRaggruppamentoChild2.Left + QRLRaggruppamentoChild2.Width + 5;
  AggiornaCodici;
end;

procedure TA040FStampa2.CreaComponenti;
var
  i,x,y,w,SpazioTot,CampiStampati: Integer;
begin
  // disalloca gli eventuali oggetti già creati
  DistruggiComponenti;
  
  CampiStampati:=0;
  Spazio:={QRep.TextWidth(QRBHeader.Font,'Z')}SPAZIO_H;
  x:=LEFT_INI;  // left di partenza
  y:=TOP_INI;   // top elementi

  // crea e imposta label e dbtext per la stampa
  with A040FPianifRepDtM2 do
  begin
    SetLength(ArrHead,cdsPianif.FieldCount);
    SetLength(ArrLinesHead,cdsPianif.FieldCount - 1);
    SetLength(ArrGroupHead,cdsPianif.FieldCount);
    SetLength(ArrGroupLinesHead,cdsPianif.FieldCount - 1);
    SetLength(ArrDett,cdsPianif.FieldCount);
    SetLength(ArrLinesDett,cdsPianif.FieldCount - 1);
    
    for i:=0 to cdsPianif.FieldCount - 1 do
    begin
      if cdsPianif.Fields[i].Tag = TAG_NO_PRINT then
        Continue;

      // determina width campo
      w:=QRep.TextWidth(QRep.Font,StringOfChar('Z',cdsPianif.Fields[i].DisplayWidth));

      // intestazione
      ArrHead[i]:=CreaHeaderLabel(Self,QRBHeader,cdsPianif.Fields[i],x,y,w);
      if i < cdsPianif.FieldCount - 1 then
        ArrLinesHead[i]:=CreaSeparatore(Self,QRBHeader,x + w + 1);

      // raggruppamento
      ArrGroupHead[i]:=CreaHeaderLabel(Self,bndColonneRaggr,cdsPianif.Fields[i],x,y,w);
      if i < cdsPianif.FieldCount - 1 then
        ArrGroupLinesHead[i]:=CreaSeparatore(Self,bndColonneRaggr,x + w + 1);

      // dettaglio
      ArrDett[i]:=CreaDettText(Self,cdsPianif,cdsPianif.Fields[i],x,y,w);
      if i < cdsPianif.FieldCount - 1 then
        ArrLinesDett[i]:=CreaSeparatore(Self,QRBDettaglio,x + w + 1);

      x:=x + w + Spazio;
      if not ContieneTag(cdsPianif.Fields[i].Tag,TAG_NO_RIPROPORZIONA) then
        CampiStampati:=CampiStampati + 1;
    end;

    // riposiziona i componenti orizzontalmente in base allo spazio occupato
    if Riproporziona <> 'N' then
    begin
      SpazioTot:=QRBHeader.Width - x + Spazio;
      RipartizioneSpazio(SpazioTot, CampiStampati);
    end;
  end; // ==> end with
end;

procedure TA040FStampa2.RipartizioneSpazio(SpazioTot,CampiStampati: Integer);
{ Distribuisce lo spazio vuoto rimanente sulla width dei campi in modo da
  ottenere un prospetto che utilizzi tutto lo spazio della pagina a disposizione.
  In base al parametro Riproporziona verrà redistribuito lo spazio.
  NOTA: gli array di head e di dettaglio hanno le stesse caratteristiche
}

var
  i, SommaWidth, ExtWidth, x, Resto: Integer;
  ArrExtWidth: array of Integer;
  Primo: Boolean;
begin
  if (Riproporziona <> 'F')  and (Riproporziona <> 'F+') and
     (Riproporziona <> 'P')  and (Riproporziona <> 'P+') then
    Exit;

  // se lo spazio è 0 termina subito
  if SpazioTot = 0 then
    Exit;

  // verifica se è possibile riproporzionare in negativo
  if SpazioTot < 0 then
    if (Riproporziona = 'F+') or
       (Riproporziona = 'P+') then
    Exit;

  // crea l'array contenente gli incrementi di width dei singoli campi
  SetLength(ArrExtWidth,Length(ArrHead));
  if (Riproporziona = 'P') or (Riproporziona = 'P+') then
  begin
    // somma le width dei campi da proporzionare
    SommaWidth:=0;
    for i:=0 to High(ArrHead) do
      if ArrHead[i] <> nil then
        if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
          SommaWidth:=SommaWidth + ArrHead[i].Width;

    // imposta l'incremento di width proporzionale per ogni campo
    for i:=0 to High(ArrHead) do
    begin
      ArrExtWidth[i]:=0;
      if ArrHead[i] <> nil then
        if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
          ArrExtWidth[i]:=(SpazioTot * ArrHead[i].Width) div SommaWidth
    end;

    // determina lo spazio rimanente
    Resto:=SpazioTot - SumInt(ArrExtWidth);
  end
  else
  begin
    // determina l'incremento di width fisso per ogni campo
    ExtWidth:=SpazioTot div CampiStampati;

    // imposta l'incremento di width per ogni campo
    for i:=0 to High(ArrHead) do
    begin
      ArrExtWidth[i]:=0;
      if ArrHead[i] <> nil then
        if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
          ArrExtWidth[i]:=ExtWidth;
    end;

    // determina lo spazio rimanente
    Resto:=SpazioTot mod CampiStampati;
  end;

  // distribuisce lo spazio rimanente in misura di 1 sui primi campi
  // (non si butta via nulla...)
  x:=0;
  for i:=0 to High(ArrHead) do
  begin
    if ArrHead[i] <> nil then
      if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
      begin
        x:=x + 1;
        if x <= Resto then
          ArrExtWidth[i]:=ArrExtWidth[i] + 1;
      end;
  end;

  // reimposta le proprietà left e width dei componenti:
  // label sulla band header e dbtext sulla band di dettaglio
  // NOTA: gli array di head e di dettaglio hanno le stesse caratteristiche
  Primo:=True;
  for i:=0 to High(ArrHead) do
  begin
    if ArrHead[i] <> nil then
    begin
      // sposta il campo in base al campo precedente
      if not Primo then
      begin
        ArrHead[i].Left:=ArrHead[i - 1].Left + ArrHead[i - 1].Width + Spazio;
        ArrDett[i].Left:=ArrDett[i - 1].Left + ArrDett[i - 1].Width + Spazio;
      end;

      // aumenta width campo
      if not ContieneTag(ArrHead[i].Tag,TAG_NO_RIPROPORZIONA) then
      begin
        ArrHead[i].Width:=max(1,ArrHead[i].Width + ArrExtWidth[i]);
        ArrDett[i].Width:=max(1,ArrDett[i].Width + ArrExtWidth[i]);
      end;

      // sposta linea separatrice vert.
      if i < High(ArrHead) then
      begin
        ArrLinesHead[i].Left:=ArrHead[i].Left + ArrHead[i].Width + 2;
        ArrLinesDett[i].Left:=ArrHead[i].Left + ArrHead[i].Width + 2;
      end;
      Primo:=False;
    end;
  end;
  SetLength(ArrExtWidth,0);

  for i:=0 to High(ArrHead) do
    if ArrHead[i] <> nil then
    begin
      ArrGroupHead[i].Width:=ArrHead[i].Width;
      ArrGroupHead[i].Left:=ArrHead[i].Left;
      if i < High(ArrHead) then
        ArrGroupLinesHead[i].Left:=ArrLinesHead[i].Left;
    end;
end;

procedure TA040FStampa2.DistruggiComponenti;
var
  i: Integer;
begin
  // rimuove vecchi riferimenti
  LastBandLegenda:=nil;

  // dealloca oggetti in array
  for i:=0 to High(ArrHead) do
    FreeAndNil(ArrHead[i]);
  for i:=0 to High(ArrLinesHead) do
    FreeAndNil(ArrLinesHead[i]);
  for i:=0 to High(ArrGroupHead) do
    FreeAndNil(ArrGroupHead[i]);
  for i:=0 to High(ArrGroupLinesHead) do
    FreeAndNil(ArrGroupLinesHead[i]);
  for i:=0 to High(ArrDett) do
    FreeAndNil(ArrDett[i]);
  for i:=0 to High(ArrLinesDett) do
    FreeAndNil(ArrLinesDett[i]);

  // dealloca array
  SetLength(ArrHead,0);
  SetLength(ArrLinesHead,0);
  SetLength(ArrGroupHead,0);
  SetLength(ArrGroupLinesHead,0);
  SetLength(ArrDett,0);
  SetLength(ArrLinesDett,0);
end;

procedure TA040FStampa2.CreaReport;
begin
  if Assigned(GruppoCorrente) then
    GruppoCorrente.Clear
  else
    GruppoCorrente:=TStringList.Create; //'';
  // gestione campo raggruppamento
  if AbilRaggr then
  begin
    ChildBand1.Enabled:=True;
    bndColonneRaggr.Enabled:=not QRGroup1.ForceNewPage;
    QRGroup1.Enabled:=True;
    QRGroup1.Expression:=A040FPianifRepDtM2.NomeCampoRaggr1 + IfThen(A040FPianifRepDtM2.NomeCampoRaggr2 <> '',' + ' + A040FPianifRepDtM2.NomeCampoRaggr2);
    QRLRaggruppamento1.Caption:=A040FPianifRepDtM2.NomeLogicoRaggr1 + ':';
    QRDBTRaggr1.DataField:=A040FPianifRepDtM2.NomeCampoRaggr1;
    QRLRaggruppamentoChild1.Caption:=A040FPianifRepDtM2.NomeLogicoRaggr1 + ':';
    QRDBTRaggrChild1.DataField:=A040FPianifRepDtM2.NomeCampoRaggr1;
    QRLRaggruppamento2.Caption:=A040FPianifRepDtM2.NomeLogicoRaggr2 + IfThen(A040FPianifRepDtM2.NomeCampoRaggr2 <> '',':');
    QRDBTRaggr2.DataField:=A040FPianifRepDtM2.NomeCampoRaggr2;
    QRDBTRaggr2.Enabled:=A040FPianifRepDtM2.NomeCampoRaggr2 <> '';//Per non sporcare la successiva esportazione in pdf dell'anteprima
    QRLRaggruppamentoChild2.Caption:=A040FPianifRepDtM2.NomeLogicoRaggr2 + IfThen(A040FPianifRepDtM2.NomeCampoRaggr2 <> '',':');
    QRDBTRaggrChild2.DataField:=A040FPianifRepDtM2.NomeCampoRaggr2;
    QRDBTRaggrChild2.Enabled:=A040FPianifRepDtM2.NomeCampoRaggr2 <> '';//Per non sporcare la successiva esportazione in pdf dell'anteprima
    ChildBand1.Height:=IfThen(A040FPianifRepDtM2.NomeCampoRaggr2 <> '',45,27);
  end
  else
  begin
    //QRGroup1.Enabled:=False;
    bndColonneRaggr.Enabled:=False;
    ChildBand1.Enabled:=False;
    QRGroup1.Enabled:=True;
    QRGroup1.Expression:=''
  end;

  CreaComponenti;
end;

procedure TA040FStampa2.QRBDettaglioAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  QRGroup1.Height:=IfThen(A040FPianifRepDtM2.NomeCampoRaggr2 <> '',45,27);
  QRBHEader.Height:=HEIGHT_BAND_HEAD_INI;
end;

// Gestione legenda
procedure TA040FStampa2.QRBLegendaHeadBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var
  i: Integer;
begin
  inherited;

  // imposta proprietà dei separatori orizzontali
  QRLineHeadT.Top:=20;
  QRLineHeadB.Top:=Sender.Height - 1;

  // adatta altezza linee verticali
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if Sender.Controls[i] is TQRShape then
      if TQRShape(Sender.Controls[i]).Shape = qrsVertLine then
      begin
        TQRShape(Sender.Controls[i]).Top:=QRLineHeadT.Top + 1;
        TQRShape(Sender.Controls[i]).Height:=Sender.Height - TQRShape(Sender.Controls[i]).Top;
      end;
  end;
end;

procedure TA040FStampa2.QRBLegendaDettBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var
  i,altezza: Integer;
  h: Extended;
begin
  inherited;
  // imposta height di default
  Sender.Height:=HEIGHT_BAND_LEGENDA_DETT_INI;

  // ricalcola altezza banda
  Sender.ExpandedHeight(h);
  altezza:=Round(h * ProporzioneBandExpanded);
  Sender.Height:=altezza;

  // adatta altezza linee verticali
  for i:=0 to Sender.ControlCount - 1 do
  begin
    if Sender.Controls[i] is TQRShape then
      if TQRShape(Sender.Controls[i]).Shape = qrsVertLine then
      begin
        TQRShape(Sender.Controls[i]).Top:=0;
        TQRShape(Sender.Controls[i]).Height:=altezza;
      end
      else if TQRShape(Sender.Controls[i]).Shape = qrsHorLine then
      begin
        // unica linea orizzontale è il separatore in basso
        TQRShape(Sender.Controls[i]).Top:=(altezza - 1);
      end;
  end;
end;

procedure TA040FStampa2.QRBLegendaDettAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
var
  i: Integer;
begin
  inherited;
  if VisualizzaLegenda then
  begin
    A040FPianifRepDtM2.cdsLegenda.Next;
    if not A040FPianifRepDtM2.cdsLegenda.Eof then
    begin
      Sender.HasChild:=True;
      Sender.ChildBand.BeforePrint:=QRBLegendaDettBeforePrint;
      Sender.ChildBand.AfterPrint:=QRBLegendaDettAfterPrint;
      Sender.ChildBand.Name:=Format('QRBLegendaDett_%.5d',[A040FPianifRepDtM2.cdsLegenda.RecNo]);
      // spostare tutti i componenti su Sender.ChildBand
      for i:=Sender.ControlCount - 1 downto 0 do
        Sender.Controls[i].Parent:=Sender.ChildBand;
      Sender.ChildBand.Height:=Sender.Height;

      LastBandLegenda:=Sender.ChildBand;
    end;
  end;
end;

procedure TA040FStampa2.RimuoviLegenda;
{ elimina le childband create per la legenda }
var
  QRCB: TQRCustomBand;
  i: Integer;
begin
  if LastBandLegenda <> nil then
  begin
    QRCB:=LastBandLegenda;
    while QRCB <> QRBLegendaDett do
    begin
      for i:=QRCB.ControlCount - 1 downto 0 do
        QRCB.Controls[i].Parent:=TQRChildBand(QRCB).ParentBand;
      QRCB:=TQRChildBand(QRCB).ParentBand;
      QRCB.HasChild:=False;
    end;
  end;
end;

end.
