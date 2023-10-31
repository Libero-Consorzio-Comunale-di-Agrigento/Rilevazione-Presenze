unit A145UStampaIndividuale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R002UQREP, QRPDFFilt, QRExport, QRWebFilt, QRCtrls, QuickRpt, ExtCtrls,
  A000UInterfaccia, USelT004, DB, Oracle, OracleData, Math;

type
  TA145FStampaIndividuale = class(TR002FQRep)
    qimgLogo: TQRImage;
    QRDBText2: TQRDBText;
    QRBDettaglio: TQRBand;
    QRMemo1: TQRMemo;
    ChildBand1: TQRChildBand;
    QRDBTNomeCognome: TQRDBText;
    QRLPeriodoAssenza: TQRLabel;
    QRDBTDomicilio: TQRDBText;
    ChildBand2: TQRChildBand;
    QRMemo2: TQRMemo;
    QRLabel1: TQRLabel;
    ChildBand3: TQRChildBand;
    QRDBText1: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRLProt: TQRLabel;
    QRLNumProt: TQRLabel;
    QRLLuogoData: TQRLabel;
    QRLabel2: TQRLabel;
    QRDBlbl: TQRDBText;
    ChildBand4: TQRChildBand;
    QRMemo3: TQRMemo;
    QRLblNote: TQRLabel;
    QRDBText6: TQRDBText;
    procedure QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
    procedure QRLPeriodoAssenzaPrint(sender: TObject; var Value: string);
    procedure qlblSysDataPrint(sender: TObject; var Value: string);
    procedure ChildBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ImpostaDataset;
    procedure CreaReport;
  end;

var
  A145FStampaIndividuale: TA145FStampaIndividuale;

implementation

{$R *.dfm}

uses A145UComunicazioneVisiteFiscali, A145UComunicazioneVisiteFiscaliDtM;

procedure TA145FStampaIndividuale.ChildBand3BeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=Not QRep.DataSet.FieldByName('NOTE').IsNull and A145FComunicazioneVisiteFiscali.chkNote.Checked;
end;

procedure TA145FStampaIndividuale.ImpostaDataset;
begin
  QRep.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBText1.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBText2.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBText3.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBText4.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBText5.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBText6.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBTNomeCognome.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBTDomicilio.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
  QRDBlbl.DataSet:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.TabellaStampa;
end;

procedure TA145FStampaIndividuale.CreaReport;
begin
  // impostazione dati fissi
  QRLProt.Enabled:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.bNumProt;
  QRLNumProt.Enabled:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.bNumProt;
  if A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.bNumProt then
    QRLNumProt.Caption:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.sNumProt;
  QRLLuogoData.Enabled:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.bLuogo;
  if A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.bLuogo then
    QRLLuogoData.Caption:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.sLuogo + ', ' + DateToStr(A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.DataElaborazione);
  QRMemo1.Lines.Text:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.sDato1;
  QRMemo2.Lines.Text:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.sDato2;
  QRMemo3.Lines.Text:=A145FComunicazioneVisiteFiscaliDtm.A145FComVisiteFiscaliMW.DatiElab.sFirma;
  Screen.Cursor:=crDefault;

  // avvia la stampa
  if (A145FComunicazioneVisiteFiscali.TipoModulo = 'COM') and (Trim(A145FComunicazioneVisiteFiscali.DocumentoPDF) <> '') and (Trim(A145FComunicazioneVisiteFiscali.DocumentoPDF) <> '<VUOTO>') then
  begin
    QRep.ShowProgress:=False;
    QRep.ExportToFilter(TQRPDFDocumentFilter.Create(A145FComunicazioneVisiteFiscali.DocumentoPDF));
  end
  else
  begin
    if A145FComunicazioneVisiteFiscali.Anteprima then
      QRep.Preview
    else
      QRep.Print;
  end;
end;

procedure TA145FStampaIndividuale.qlblSysDataPrint(sender: TObject; var Value: string);
begin
  inherited;
  Value:='';
end;

procedure TA145FStampaIndividuale.QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
var
  L: Integer;
begin
  inherited;

  // titolo
  LEnte.Caption:='';
  LTitolo.Caption:='';

  // gestione del logo
  Titolo.Height:=90;
  if A145FComunicazioneVisiteFiscali.chkLogo.Checked then
    L:=StrToIntDef(A145FComunicazioneVisiteFiscali.edtLogoLarg.Text,150)
  else
    L:=0;
  try
    qimgLogo.Enabled:=L > 0; // edtLarghezza.Text...
    if qimgLogo.Enabled then
    begin
      qimgLogo.AutoSize:=True;
      qimgLogo.Stretch:=False;
      with TSelT004.Create(nil) do
      try
        Session:=SessioneOracle;
        if EsisteImmagine then
          qimgLogo.Picture.BitMap.Assign(Immagine);
      finally
        Free;
      end;
      qimgLogo.AutoSize:=False;
      qimgLogo.Stretch:=True;
      qimgLogo.Height:=Trunc(qimgLogo.Height * (L / qimgLogo.Width));
      qimgLogo.Width:=L;
      TQRBand(qimgLogo.Parent).Height:=max(TQRBand(qimgLogo.Parent).Height,qimgLogo.Top + qimgLogo.Height);
    end;
  except
    qimgLogo.Enabled:=False;
  end;
end;

procedure TA145FStampaIndividuale.QRLPeriodoAssenzaPrint(sender: TObject; var Value: string);
begin
  inherited;
  // due possibilità di visualizzazione, in base a inserimento normale / prolungamento
  // data_inizio - data_fine
  // data_inizio - nuova_data_fine (data_fine)
  Value:='in malattia dal giorno ' + QRep.Dataset.FieldByName('DataInizioAssenza').AsString + ' al giorno ';
  if QRep.Dataset.FieldByName('NuovaDataFine').IsNull then
    Value:=Value + QRep.Dataset.FieldByName('DataFineAssenza').AsString
  else
    Value:=Value + QRep.Dataset.FieldByName('NuovaDataFine').AsString +
           ' (' +  QRep.Dataset.FieldByName('DataFineAssenza').AsString + ')';
end;

end.
