unit A139UStampaServizi;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt,
  ExtCtrls, A000UInterfaccia, jpeg, Printers;

type
  TA139FStampaServizi = class(TR002FQRep)
    QRBand1: TQRBand;
    bndTipoTurno: TQRGroup;
    QRDBText1: TQRDBText;
    qedtCampo1: TQRDBText;
    qedtCampo2: TQRDBText;
    qedtNominativo: TQRDBText;
    qedtDalleAlle: TQRDBText;
    qedtApparati: TQRDBText;
    qedtCausale: TQRDBText;
    qedtNote: TQRDBText;
    SummaryBand1: TQRBand;
    LNote: TQRLabel;
    LFirmaDx: TQRLabel;
    bndCampo1: TQRGroup;
    QRDBText9: TQRDBText;
    TitleBand1: TQRBand;
    LFirmaSx: TQRLabel;
    qedtOrd: TQRLabel;
    QRSubDetailAss: TQRSubDetail;
    qedtCausAss: TQRDBText;
    qedtNomeAss: TQRDBText;
    qedtDalleAlleAss: TQRDBText;
    qshpAssenzePattuglia: TQRShape;
    QRImage1: TQRImage;
    LUfficio: TQRLabel;
    QRNote2: TQRBand;
    LNote2: TQRLabel;
    procedure ChildBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText1Print(sender: TObject; var Value: string);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRSubDetailAssBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRSubDetailAssAfterPrint(Sender: TQRCustomBand;
      BandPrinted: Boolean);
    procedure bndTipoTurnoBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure bndCampo1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure qedtDalleAllePrint(sender: TObject; var Value: string);
    procedure qedtNominativoPrint(sender: TObject; var Value: string);
  private
    { Private declarations }
    LeftOrig:Integer;
  public
    { Public declarations }
  end;

var
  A139FStampaServizi: TA139FStampaServizi;

implementation

uses A139UPianifServiziDtm, A139UDialogStampa, A139UPianifServizi;

{$R *.dfm}

procedure TA139FStampaServizi.bndCampo1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  with A139FPianifServiziDtm.TabellaStampa do
    if (FieldByName('COD_TIPO_TURNO').AsString = '00C') or (FieldByName('COD_TIPO_TURNO').AsString = '00N') then
      PrintBand:=False;
end;

procedure TA139FStampaServizi.bndTipoTurnoBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  with A139FPianifServiziDtm.TabellaStampa do
    if (FieldByName('COD_TIPO_TURNO').AsString = '00C') or (FieldByName('COD_TIPO_TURNO').AsString = '00N') then
      PrintBand:=False;
end;

procedure TA139FStampaServizi.ChildBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=Trim(A139FPianifServiziDtm.TabellaStampa.FieldByName('APPARATO').AsString) <> '';
end;

procedure TA139FStampaServizi.qedtDalleAllePrint(sender: TObject;
  var Value: string);
begin
  inherited;
  with A139FPianifServiziDtm.TabellaStampa do
    if (FieldByName('COD_TIPO_TURNO').AsString = '01C') or (FieldByName('COD_TIPO_TURNO').AsString = '01N') then
      Value:='';
end;

procedure TA139FStampaServizi.qedtNominativoPrint(sender: TObject;
  var Value: string);
begin
  inherited;
  with A139FPianifServiziDtm.TabellaStampa do
    if (FieldByName('COD_TIPO_TURNO').AsString = '01C') or (FieldByName('COD_TIPO_TURNO').AsString = '01N') then
      Value:='';
end;

procedure TA139FStampaServizi.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    if (TabellaStampa.FieldByName('COD_TIPO_TURNO').AsString = '00C') or (TabellaStampa.FieldByName('COD_TIPO_TURNO').AsString = '00N') then
    begin
      LUfficio.Caption:=A139FDialogStampa.Ufficio + IfThen(A139FDialogStampa.Ufficio <> '',#13#10#13#10,'') + TabellaStampa.FieldByName('NOTE_SERVIZIO').AsString;
      QRep.NewPage;
      PrintBand:=False;
      exit;
    end
    else
      LUfficio.Caption:=A139FDialogStampa.Ufficio;
    qedtOrd.Caption:=A139FPianifServiziDtM.TabellaStampa.FieldByName('ORDINE').AsString;
    if A139FPianifServiziDtM.TabellaStampa.FieldByName('STATO').AsString = 'C' then
      qedtOrd.Caption:=qedtOrd.Caption + '*';
    if A139FPianifServiziDtM.TabellaStampa.FieldByName('COMANDATO').AsString = 'S' then
      qedtOrd.Caption:=qedtOrd.Caption + 'c';
    TabellaStampaAss.Filtered:=False;
    TabellaStampaAss.Filter:='PATTUGLIA = ' + TabellaStampa.FieldByName('PATTUGLIA').AsString;
    TabellaStampaAss.Filtered:=True;
    //Setto posizionamento dell'etichetta tipo turno:
    //se = Commento stampo in mezzo alla pagina
    //se <> Commento normale
    if (TabellaStampa.FieldByName('COD_TIPO_TURNO').AsString = '01C') or (TabellaStampa.FieldByName('COD_TIPO_TURNO').AsString = '01N') then
    begin
      qedtNote.AlignToBand:=True;
      qedtNote.Alignment:=taCenter;
    end
    else
    begin
      qedtNote.AlignToBand:=False;
      qedtNote.Alignment:=taLeftJustify;
      if QRep.Page.Orientation = poLandscape then
        qedtNote.Left:=652
      else
        qedtNote.Left:=542;
    end;
  end;
  qshpAssenzePattuglia.Width:=qrSubDetailass.Width;
  qshpAssenzePattuglia.Enabled:=True;
end;

procedure TA139FStampaServizi.QRDBText1Print(sender: TObject;
  var Value: string);
begin
  inherited;
  Value:='Carta di servizio ' + Value;
end;

procedure TA139FStampaServizi.QRSubDetailAssAfterPrint(Sender: TQRCustomBand;
  BandPrinted: Boolean);
begin
  inherited;
  qshpAssenzePattuglia.Enabled:=False
end;

procedure TA139FStampaServizi.QRSubDetailAssBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  if A139FPianifServiziDtm.TabellaStampaAss.RecordCount <= 0 then
    PrintBand:=False;
  qedtNomeAss.Left:=qedtNominativo.Left;
  inherited;
end;

end.
