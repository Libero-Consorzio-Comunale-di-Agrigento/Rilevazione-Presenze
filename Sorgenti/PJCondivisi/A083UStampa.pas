unit A083UStampa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R002UQREP, QRPDFFilt, QRExport, C700USelezioneAnagrafe,
  QRWebFilt, QRCtrls, QuickRpt, Vcl.ExtCtrls, A000UInterfaccia;

type
  TA083FStampa = class(TR002FQRep)
    QRBndDettaglio: TQRBand;
    QRDBTxtMessaggio: TQRDBText;
    QRDBTxtNominativo: TQRDBText;
    QRDBTxtMatricola: TQRDBText;
    QRLineaOrizz: TQRShape;
    QRDBTxtTipo: TQRDBText;
    QRDBTxtMaschera: TQRDBText;
    QRDBTxtOperatore: TQRDBText;
    QRDBTxtData: TQRDBText;
    QRDBTxtID: TQRDBText;
    QRLblID: TQRLabel;
    QRLblData: TQRLabel;
    QRLblOperatore: TQRLabel;
    QRLblMaschera: TQRLabel;
    QRLblMatricola: TQRLabel;
    QRBndAzienda: TQRGroup;
    QRLblAzienda: TQRLabel;
    QRDBTxtAzienda: TQRDBText;
    QRBndIntestazione: TQRBand;
    QRSysData1: TQRSysData;
    procedure TitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBndDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
    procedure QRBndAziendaBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRepBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A083FStampa: TA083FStampa;

implementation

{$R *.dfm}

uses A083UMsgElaborazioniDtm;

procedure TA083FStampa.QRBndAziendaBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  PrintBand:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('AZIENDA_MSG').Visible;
end;

procedure TA083FStampa.QRBndDettaglioBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  //Imposto la visibilità dell'ID
  QRLblID.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('ID').Visible;
  QRDBTxtID.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('ID').Visible;
  //Imposto la visibilità della DATA
  QRLblData.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('DATA_MSG').Visible;
  QRDBTxtData.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('DATA_MSG').Visible;
  //Imposto la visibilità dell'OPERATORE
  QRLblOperatore.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('OPERATORE').Visible;
  QRDBTxtOperatore.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('OPERATORE').Visible;
  //Imposto la visibilità della MASCHERA
  QRLblMaschera.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MASCHERA').Visible;
  QRDBTxtMaschera.Enabled:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MASCHERA').Visible;
  //Imposto la visibilità della MATRICOLA
  QRLblMatricola.Enabled:=(A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MATRICOLA').Visible) and (A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MATRICOLA').AsString <> '');
  QRDBTxtMatricola.Enabled:=(A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MATRICOLA').Visible) and (A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MATRICOLA').AsString <> '');
  QRDBTxtNominativo.Enabled:=(A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MATRICOLA').Visible) and (A083FMsgElaborazioniDtm.A083MW.DataSetStampa.FieldByName('MATRICOLA').AsString <> '');
end;

procedure TA083FStampa.QRepBeforePrint(Sender: TCustomQuickRep; var PrintReport: Boolean);
begin
  inherited;
  QRBndAzienda.Expression:=A083FMsgElaborazioniDtm.A083MW.DataSetStampa.Name + '.AZIENDA_MSG';
end;

procedure TA083FStampa.TitoloBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  inherited;
  LEnte.Caption:=Parametri.RagioneSociale;
  LTitolo.Caption:='Messaggi delle elaborazioni';
end;

end.
