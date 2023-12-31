unit A116UStampa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls, Variants, QRExport, QRWebFilt, QRPDFFilt,
  A000UCostanti, A000UInterfaccia, A000USessione, C180FunzioniGenerali;

type
  TA116FStampa = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBand1: TQRBand;
    QRGroup1:TQRGroup;
    QRDBTNome: TQRDBText;
    QRBIntestazione: TQRBand;
    QRDBTCognome: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLEnte: TQRLabel;
    QRFoot1: TQRBand;
    QRLTot1: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRBand2: TQRBand;
    QRLabel10: TQRLabel;
    QRLLiquidabile: TQRLabel;
    QRLLiquidato: TQRLabel;
    QRLLiquidabile1: TQRLabel;
    QRLLiquidato1: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel22: TQRLabel;
    QRLAbbattuto1: TQRLabel;
    QRLAbbattuto: TQRLabel;
    QRDBText8: TQRDBText;
    QRLabel24: TQRLabel;
    DatiDettaglio: TQRLabel;
    NomiDettaglio: TQRLabel;
    QRMemo1: TQRMemo;
    ChildBand1: TQRChildBand;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    Anomalia: TQRLabel;
    QRLabel15: TQRLabel;
    QRDBText2: TQRDBText;
    QRTextFilter1: TQRTextFilter;
    QRRTFFilter1: TQRRTFFilter;
    QRPDFFilter1: TQRPDFFilter;
    QRHTMLFilter1: TQRHTMLFilter;
    QRExcelFilter1: TQRExcelFilter;
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
    procedure QRFoot1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Liquidabile,Liquidabile1,Liquidabile2: Integer;
    Liquidato,Liquidato1,Liquidato2: Integer;
    Abbattuto,Abbattuto1,Abbattuto2: Integer;
  public
    { Public declarations }
    procedure CreaReport(Preview:Boolean);
  end;

var
  A116FStampa: TA116FStampa;

implementation

uses A116ULiquidazioneOreAnniPrec;
{$R *.DFM}

procedure TA116FStampa.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
  RepR.PrinterSettings.UseStandardPrinter:=(A116FLiquidazioneOreAnniPrec.A116MW.TipoModulo = 'COM') and Parametri.UseStandardPrinter;
  RepR.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
  QRDBTNome.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
  QRDBTCognome.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
  QRDBText3.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
  QRDBText4.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
  QRDBText5.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
  QRDBText8.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
  QRDBText2.DataSet:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa;
end;

//------------------------------------------------------------------------------
procedure TA116FStampa.CreaReport(Preview:Boolean);
begin
  if (A116FLiquidazioneOreAnniPrec.A116MW.TipoModulo = 'COM') and (Trim(A116FLiquidazioneOreAnniPrec.A116MW.DocumentoPDF) <> '') and (Trim(A116FLiquidazioneOreAnniPrec.A116MW.DocumentoPDF) <> '<VUOTO>') then
  begin
    RepR.ShowProgress:=False;
    RepR.ExportToFilter(TQRPDFDocumentFilter.Create(A116FLiquidazioneOreAnniPrec.A116MW.DocumentoPDF));
  end
  else if Preview then
    RepR.Preview
  else
    RepR.Print;
end;

procedure TA116FStampa.RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  QRLEnte.Caption:=Parametri.DAzienda;
  QRLTitolo.Caption:=' Liquidazione/abbattimento ore residue anno ' + A116FLiquidazioneOreAnniPrec.edtAnno.Text +
                     ' nel mese di ' + A116FLiquidazioneOreAnniPrec.edtData.Text;
  Liquidabile:=0;
  Liquidabile1:=0;
  Liquidabile2:=0;
  Liquidato:=0;
  Liquidato1:=0;
  Liquidato2:=0;
  Abbattuto:=0;
  Abbattuto1:=0;
  Abbattuto2:=0;
end;

procedure TA116FStampa.QRGroup1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i:Integer;
    S,NC,D_NC:String;
begin
  QRMemo1.Lines.Clear;
  for i:=0 to A116FLiquidazioneOreAnniPrec.A116MW.INomeCampo.Count - 1 do
  begin
    NC:=A116FLiquidazioneOreAnniPrec.A116MW.INomeCampo[i];
    D_NC:=NC;
    Insert('D_',D_NC,5);
    S:=Format('%s: %s %s',[A116FLiquidazioneOreAnniPrec.A116MW.INomeLogico[i],A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName(NC).AsString,A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName(D_NC).AsString]);
    QRMemo1.Lines.Add(S);
  end;
  Liquidabile1:=0;
  Liquidato1:=0;
  Abbattuto1:=0;
end;

procedure TA116FStampa.QRBand1AfterPrint(Sender: TQRCustomBand; BandPrinted: Boolean);
var Comodo: Integer;
begin
  Comodo:=R180OreMinutiExt(A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName('Liquidabile').AsString);
  Inc(Liquidabile,Comodo);
  Inc(Liquidabile1,Comodo);
  Comodo:=R180OreMinutiExt(A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName('Liquidato').AsString);
  Inc(Liquidato,Comodo);
  Inc(Liquidato1,Comodo);
  Comodo:=R180OreMinutiExt(A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName('Abbattuto').AsString);
  Inc(Abbattuto,Comodo);
  Inc(Abbattuto1,Comodo);
end;

procedure TA116FStampa.QRFoot1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRLLiquidabile1.Caption:=R180MinutiOre(Liquidabile1);
  QRLLiquidato1.Caption:=R180MinutiOre(Liquidato1);
  QRLAbbattuto1.Caption:=R180MinutiOre(Abbattuto1);
end;

procedure TA116FStampa.QRBand2BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRLLiquidabile.Caption:=R180MinutiOre(Liquidabile);
  QRLLiquidato.Caption:=R180MinutiOre(Liquidato);
  QRLAbbattuto.Caption:=R180MinutiOre(Abbattuto);
end;

procedure TA116FStampa.QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
var i,L:Integer;
begin
  DatiDettaglio.Caption:='';
  for i:=0 to A116FLiquidazioneOreAnniPrec.A116MW.DNomeCampo.Count - 1 do
  begin
    if i > 0 then
      DatiDettaglio.Caption:=DatiDettaglio.Caption + ' ';
    if Length(A116FLiquidazioneOreAnniPrec.A116MW.DNomeLogico[i]) > A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName(A116FLiquidazioneOreAnniPrec.A116MW.DNomeCampo[i]).Size then
      L:=Length(A116FLiquidazioneOreAnniPrec.A116MW.DNomeLogico[i])
    else
      L:=A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName(A116FLiquidazioneOreAnniPrec.A116MW.DNomeCampo[i]).Size;
    DatiDettaglio.Caption:=DatiDettaglio.Caption + Format('%-*s',[L,A116FLiquidazioneOreAnniPrec.A116MW.TabellaStampa.FieldByName(A116FLiquidazioneOreAnniPrec.A116MW.DNomeCampo[i]).AsString]);
  end;
end;

end.
