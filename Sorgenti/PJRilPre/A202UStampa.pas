unit A202UStampa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt, Vcl.ExtCtrls, qrpctrls,
  Math, OracleData;

type
  TA202FStampa = class(TR002FQRep)
    qrT425: TQRBand;
    qlblInizio: TQRDBText;
    qlblFine: TQRDBText;
    qlblDal: TQRLabel;
    qlblAl: TQRLabel;
    qlblTipoRapporto: TQRLabel;
    qlblD_TipoRapporto: TQRDBText;
    qlblEnte: TQRLabel;
    qlblD_Ente: TQRDBText;
    qlblPartTime: TQRLabel;
    qlblD_PartTime: TQRDBText;
    qlblTipologia: TQRLabel;
    qlblD_TIPO: TQRDBText;
    qlblTipoPartTime: TQRLabel;
    qlblD_TipoPT: TQRDBText;
    QRLabel8: TQRLabel;
    qlblD_INDPRESPT: TQRDBText;
    qlblQualifica: TQRLabel;
    qlblDisciplina: TQRLabel;
    qlblD_Disciplina: TQRDBText;
    qlblD_Qualifica: TQRDBText;
    qlblNoteT: TQRLabel;
    qlblNote: TQRDBText;
    qrbTitoloPeriodi: TQRBand;
    QRLabel1: TQRLabel;
    qrDatiAnagrafico: TQRBand;
    qrRiepilogo_Titolo: TQRChildBand;
    qlblMatricola: TQRLabel;
    qlblCognome: TQRLabel;
    qlblNome: TQRLabel;
    QRLabel5: TQRLabel;
    qrT055_Titolo: TQRBand;
    QRLabel3: TQRLabel;
    qExprValidato: TQRExpr;
    qlblValidato: TQRLabel;
    qrRiepilogo: TQRChildBand;
    qrT425_Titolo: TQRChildBand;
    QRLabel4: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel6: TQRLabel;
    qlblComplGG: TQRLabel;
    qlblSPT_GG: TQRLabel;
    qlblSPTI_GG: TQRLabel;
    qlblSPTI_AA: TQRLabel;
    qlblComplAA: TQRLabel;
    qlblSPT_AA: TQRLabel;
    qlblDaApprGG: TQRLabel;
    qlblSPT_GG_NA: TQRLabel;
    qlblSPTI_GG_NA: TQRLabel;
    qlblSPT_AA_NA: TQRLabel;
    qlblSPTI_AA_NA: TQRLabel;
    qlblDaApprAA: TQRLabel;
    QRLabel2: TQRLabel;
    qlblSFTE_GG: TQRLabel;
    qlblSFTE_AA: TQRLabel;
    qlblSFTE_GG_NA: TQRLabel;
    qlblSFTE_AA_NA: TQRLabel;
    procedure FormCreate(Sender: TObject);
    procedure qrT425BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Dal, Al: TDateTime;
  end;

var
  A202FStampa: TA202FStampa;

implementation

{$R *.dfm}

procedure TA202FStampa.FormCreate(Sender: TObject);
begin
  inherited;
  qlblComplGG.Caption:=qlblComplGG.Caption + chr(10) + chr(13) + '(giorni)';
  qlblComplAA.Caption:=qlblComplAA.Caption + chr(10) + chr(13) + '(anni)';
  qlblDaApprGG.Caption:=qlblDaApprGG.Caption + chr(10) + chr(13) + '(giorni)';
  qlblDaApprAA.Caption:=qlblDaApprAA.Caption + chr(10) + chr(13) + '(anni)';
end;

procedure TA202FStampa.qrT425BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:= Math.Max(QRep.DataSet.FieldByName('INIZIO').AsDateTime, Dal) <= Math.Min(QRep.DataSet.FieldByName('FINE').AsDateTime, Al);
end;

end.
