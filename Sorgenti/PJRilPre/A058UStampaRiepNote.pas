unit A058UStampaRiepNote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, QuickRpt, QRCtrls,
  Data.DB, Datasnap.DBClient;

type
  TA058FStampaRiepNote = class(TForm)
    QRRiepNote: TQuickRep;
    QRBandTitolo: TQRBand;
    QRLblTitolo: TQRLabel;
    QRBandNominativo: TQRGroup;
    QRDettaglio: TQRBand;
    QRTxtNominativo: TQRDBText;
    QRTxtData: TQRDBText;
    QRTxtNote: TQRDBText;
    procedure FormCreate(Sender: TObject);
    procedure QRBandTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRRiepNoteBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    TabellaStampaNote:TClientDataSet;
    procedure CreaTabellaStampaNote;
    procedure CaricaTabellaStampaNote;
    procedure InizializzaComponenti;
  public
    { Public declarations }
    procedure StampaNote;
  end;

var
  A058FStampaRiepNote: TA058FStampaRiepNote;

implementation

uses
  A058UPianifTurniDtm1;

{$R *.dfm}

procedure TA058FStampaRiepNote.FormCreate(Sender: TObject);
begin
  QRRiepNote.useQR5Justification:=True;
end;

procedure TA058FStampaRiepNote.StampaNote;
begin
  CreaTabellaStampaNote;
  InizializzaComponenti;
  CaricaTabellaStampaNote;
end;

procedure TA058FStampaRiepNote.CreaTabellaStampaNote;
begin
  TabellaStampaNote:=TClientDataSet.Create(nil);
  TabellaStampaNote.FieldDefs.Add('NOMINATIVO',ftString,50);
  TabellaStampaNote.FieldDefs.Add('DATA',ftDateTime);
  TabellaStampaNote.FieldDefs.Add('NOTE',ftString,2000);
  TabellaStampaNote.IndexDefs.Clear;
  TabellaStampaNote.IndexDefs.Add('PK','NOMINATIVO;DATA',[]);
  TabellaStampaNote.IndexName:='PK';
  TabellaStampaNote.CreateDataSet;
  TabellaStampaNote.Open;
end;

procedure TA058FStampaRiepNote.InizializzaComponenti;
begin
  QRRiepNote.DataSet:=TabellaStampaNote;
  QRTxtNominativo.DataSet:=TabellaStampaNote;
  QRTxtNominativo.DataField:='NOMINATIVO';
  QRTxtData.DataSet:=TabellaStampaNote;
  QRTxtData.DataField:='DATA';
  QRTxtNote.DataSet:=TabellaStampaNote;
  QRTxtNote.DataField:='NOTE';
end;

procedure TA058FStampaRiepNote.CaricaTabellaStampaNote;
var i,j:integer;
begin
  for i:=0 to A058FPianifTurniDtM1.Vista.Count - 1 do
    for j:=0 to A058FPianifTurniDtM1.Vista[i].Giorni.Count - 1 do
      if not A058FPianifTurniDtM1.Vista[i].Giorni[J].Note.IsEmpty then
      begin
        TabellaStampaNote.Insert;
        TabellaStampaNote.FieldByName('NOMINATIVO').AsString:=Format('%s %s',[A058FPianifTurniDtM1.Vista[i].Cognome,
                                                                              A058FPianifTurniDtM1.Vista[i].Nome]);
        TabellaStampaNote.FieldByName('DATA').AsDateTime:=A058FPianifTurniDtM1.Vista[i].Giorni[J].Data;
        TabellaStampaNote.FieldByName('NOTE').AsString:=A058FPianifTurniDtM1.Vista[i].Giorni[J].Note;
        TabellaStampaNote.Post;
      end;
end;

procedure TA058FStampaRiepNote.QRBandTitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRlblTitolo.Left:=(QRBandTitolo.Width div 2) - (QRLblTitolo.Width div 2);
end;

procedure TA058FStampaRiepNote.QRDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  QRDettaglio.Frame.DrawBottom:=A058FPianifTurniDtm1.selT082.FieldByName('SEPARATORE_RIGHE').AsString = 'S';
end;

procedure TA058FStampaRiepNote.QRRiepNoteBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  QRRiepNote.NewPage;
  QRRiepNote.Font.Size:=A058FPianifTurniDtM1.selT082.FieldByName('DIMENSIONE_FONT').AsInteger;
end;

procedure TA058FStampaRiepNote.FormDestroy(Sender: TObject);
begin
  if TabellaStampaNote <> nil then
    FreeAndNil(TabellaStampaNote);
end;

end.
