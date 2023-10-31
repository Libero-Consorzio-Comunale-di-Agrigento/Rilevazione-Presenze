unit A126UStampaBloccoRiepiloghi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, ExtCtrls, Qrctrls,C180FunzioniGenerali, Variants;

type
  TA126FStampaBloccoRiepiloghi = class(TForm)
    RepR: TQuickRep;
    QRBTitolo: TQRBand;
    QRLTitolo: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBDettaglio: TQRBand;
    QRBIntestazione: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel5: TQRLabel;
    QRLAzienda: TQRLabel;
    LPeriodo: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText3: TQRDBText;
    QRBand1: TQRBand;
    QRLabel6: TQRLabel;
    LAnomalia: TQRLabel;
    QRLabel8: TQRLabel;
    QRBand2: TQRBand;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRGroup2: TQRGroup;
    LRagg: TQRLabel;
    QRDBText7: TQRDBText;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText5: TQRDBText;
    QRLabel12: TQRLabel;
    QRLabel14: TQRLabel;
    SummaryBand1: TQRBand;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel19: TQRLabel;
    QRLQuota: TQRLabel;
    procedure QRBDettaglioBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRGroup2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure RepRBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure SummaryBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Totali:array[1..3] of Real;
  public
    { Public declarations }
    DataI,DataF : TDateTime;
    StampaValuta:Boolean;
    procedure CreaReport;
  end;

var
  A126FStampaBloccoRiepiloghi: TA126FStampaBloccoRiepiloghi;

implementation

uses A126UBloccoRiepiloghi,A126UBloccoRiepiloghiDtM1;

{$R *.DFM}

procedure TA126FStampaBloccoRiepiloghi.CreaReport;
begin
  RepR.Preview;
end;

procedure TA126FStampaBloccoRiepiloghi.RepRBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  Totali[3]:=0;
end;

procedure TA126FStampaBloccoRiepiloghi.QRGroup2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Totali[2]:=0;
end;

procedure TA126FStampaBloccoRiepiloghi.QRGroup1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  Totali[1]:=0;
end;

procedure TA126FStampaBloccoRiepiloghi.QRBDettaglioBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
var i:Byte;
begin
  for i:=1 to 3 do
    Totali[i]:=Totali[i] + A126FBloccoRiepiloghiDtM1.TabellaStampa.FieldByName('Quota').AsFloat;
  LAnomalia.Caption:=A126FBloccoRiepiloghiDtM1.TabellaStampa.FieldByName('Anomalia').AsString;
end;

procedure TA126FStampaBloccoRiepiloghi.FormCreate(Sender: TObject);
begin
  RepR.useQR5Justification:=True;
end;

procedure TA126FStampaBloccoRiepiloghi.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if StampaValuta then
    QRLabel6.Caption:=Format('%m',[Totali[1]])
  else
    QRLabel6.Caption:=Format('%d',[Trunc(Totali[1])]);
end;

procedure TA126FStampaBloccoRiepiloghi.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if StampaValuta then
    QRLabel9.Caption:=Format('%m',[Totali[2]])
  else
    QRLabel9.Caption:=Format('%d',[Trunc(Totali[2])]);
end;

procedure TA126FStampaBloccoRiepiloghi.SummaryBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if StampaValuta then
    QRLabel17.Caption:=Format('%m',[Totali[3]])
  else
    QRLabel17.Caption:=Format('%d',[Trunc(Totali[3])]);
end;

end.
