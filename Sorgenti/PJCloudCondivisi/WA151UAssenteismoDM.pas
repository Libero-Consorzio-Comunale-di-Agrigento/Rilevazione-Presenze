unit WA151UAssenteismoDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData, StrUtils,
  A151UAssenteismoMW;

type
  TWA151FAssenteismoDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaCOD_TIPOACCORPCAUSALI: TStringField;
    selTabellaCOD_CODICIACCORPCAUSALI: TStringField;
    selTabellaMODO_ACCORPCAUSALI: TStringField;
    selTabellaSTAMPA_GENERATORE: TStringField;
    selTabellaRIGHE: TStringField;
    selTabellaRIGHE_VUOTE: TStringField;
    selTabellaDETTAGLIO_DIP: TStringField;
    selTabellaCOLONNE: TStringField;
    selTabellaNUMDIP_PERIODO: TStringField;
    selTabellaNUMDIP_ARROT: TStringField;
    selTabellaPRESENZA_GGLAV: TStringField;
    selTabellaPRESENZA_ARROT: TStringField;
    selTabellaASSENZA_GGLAV: TStringField;
    selTabellaASSENZA_QM: TStringField;
    selTabellaASSENZA_GGINT: TStringField;
    selTabellaASSENZA_ARROT: TStringField;
    selTabellaRIEPILOGO_ARROT: TStringField;
    selTabellaASS_FAMILIARI: TStringField;
    selTabellaASS_FRUIZIONE_GG: TStringField;
    selTabellaASS_FRUIZIONE_HH: TStringField;
    selTabellaASS_FRUIZIONE_MG: TStringField;
    selTabellaASS_FRUIZIONE_DH: TStringField;
    selTabellaASS_MAXPERIODO_GG: TIntegerField;
    selTabellaASS_DEBITO_GGINT: TStringField;
    selTabellaTOTALE_GENERALE: TStringField;
    selTabellaESPORTA_XML: TStringField;
    selTabellaASS_DETTAGLIO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterScroll(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
  private
    { Private declarations }
  public
    A151MW: TA151FAssenteismoMW;
    procedure AggiornaDescAccorp;
  end;

implementation

uses WA151UAssenteismo, WA151UAssenteismoDettFM;

{$R *.dfm}

procedure TWA151FAssenteismoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  A151MW:=TA151FAssenteismoMW.Create(Self);
  A151MW.selT151:=SelTabella;
  A151MW.lNumDip.Text:=StringReplace(StringReplace(A151MW.lNumDip.Text,'<','(',[rfReplaceAll]),'>',')',[rfReplaceAll]);
  A151MW.lPres.Text:=StringReplace(StringReplace(A151MW.lPres.Text,'<','(',[rfReplaceAll]),'>',')',[rfReplaceAll]);
  A151MW.lAss.Text:=StringReplace(StringReplace(A151MW.lAss.Text,'<','(',[rfReplaceAll]),'>',')',[rfReplaceAll]);
  A151MW.lRiep.Text:=StringReplace(StringReplace(A151MW.lRiep.Text,'<','(',[rfReplaceAll]),'>',')',[rfReplaceAll]);
  inherited;
end;

procedure TWA151FAssenteismoDM.AfterScroll(DataSet: TDataSet);
begin
  inherited;
  A151MW.AfterScroll;
  if (Self.Owner as TWA151FAssenteismo).WDettaglioFM <> nil then
    with ((Self.Owner as TWA151FAssenteismo).WDettaglioFM as TWA151FAssenteismoDettFM),A151MW do
    begin
      cmbTabella.Text:=selTabella.FieldByName('STAMPA_GENERATORE').AsString;
      cmbTipoAccorp.Text:=selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString;
      AggiornaDescAccorp;
      AggiornaGrigliaRighe;
      (Self.Owner as TWA151FAssenteismo).AbilitaComponenti;
      cmbEsportaXml.Text:=IfThen(selTabella.FieldByName('ESPORTA_XML').AsString = 'S',PLEsportaXML[0],IfThen(selTabella.FieldByName('ESPORTA_XML').AsString = 'L',PLEsportaXML[1],''));
    end;
end;

procedure TWA151FAssenteismoDM.AggiornaDescAccorp;
begin
  with ((Self.Owner as TWA151FAssenteismo).WDettaglioFM as TWA151FAssenteismoDettFM),A151MW do
    lblTipoAccorp.Text:=VarToStr(selT255.Lookup('COD_TIPOACCORPCAUSALI',cmbTipoAccorp.Text,'DESCRIZIONE'));
end;

procedure TWA151FAssenteismoDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  with ((Self.Owner as TWA151FAssenteismo).WDettaglioFM as TWA151FAssenteismoDettFM),A151MW do
  begin
    CaricaListeColonne;
    selTabella.FieldByName('STAMPA_GENERATORE').AsString:=cmbTabella.Text;
    selTabella.FieldByName('COD_TIPOACCORPCAUSALI').AsString:=cmbTipoAccorp.Text;
    iEsportaXml:=PLEsportaXML.IndexOf(cmbEsportaXml.Text);
  end;
  A151MW.BeforePostNoStorico;
end;

end.
