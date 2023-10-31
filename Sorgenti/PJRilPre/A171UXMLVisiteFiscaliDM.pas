unit A171UXMLVisiteFiscaliDM;

interface

uses
  System.SysUtils, System.Classes, R004UGestStoricoDTM, Data.DB, OracleData,
  C700USelezioneAnagrafe, selAnagrafe, C180FunzioniGenerali, A000UInterfaccia,
  Oracle, FunzioniGenerali, System.Variants, A171UXMLVisiteFiscaliMW;

type
   TA171FXMLVisiteFiscaliDM = class(TR004FGestStoricoDtM)
    selT049: TOracleDataSet;
    selT049COGNOME: TStringField;
    selT049NOME: TStringField;
    selT049CODCATASTALE_REP: TStringField;
    selT049CAP_REP: TStringField;
    selT049VIA_REP: TStringField;
    selT049COGNOME_REP: TStringField;
    selT049DATA_RICHIESTA: TDateTimeField;
    selT049CONFERMA_AMB: TStringField;
    selT049ACCETTA_ATTI_MED: TStringField;
    selT049TIPO_AMB_DOM: TStringField;
    selT049DATA_VISITA: TDateTimeField;
    selT049ORARIO_VISITA: TStringField;
    selT049OBBLIGO_ORARIO: TStringField;
    selT049MALATTIA_FERIE: TStringField;
    selT049INIZIO_MAL: TDateTimeField;
    selT049FINE_MAL: TDateTimeField;
    selT049CODFISCALE: TStringField;
    selT049IndComuneCAP: TStringField;
    selT049PROGRESSIVO: TIntegerField;
    selT049DataUltimaVisita: TDateTimeField;
    selT049DescComuneRep: TStringField;
    selT049ORA_RICHIESTA: TStringField;
    selT049ELABORATO: TStringField;
    selT049DETTAGLI_INDIRIZZO: TStringField;
    selT049TELEFONO: TStringField;
    selT049D_DETTAGLI_INDIRIZZO: TStringField;
    selT049D_DETTAGLI_INDIRIZZO_REP: TStringField;
    selT049D_TELEFONO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT049CalcFields(DataSet: TDataSet);
    procedure selT049AfterScroll(DataSet: TDataSet);
    procedure selT049CODCATASTALE_REPChange(Sender: TField);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure selT049BeforeInsert(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    A171MW:TA171FXMLVisiteFiscaliMW;
  end;

var
  A171FXMLVisiteFiscaliDM: TA171FXMLVisiteFiscaliDM;

implementation

uses A171UXMLVisiteFiscali;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA171FXMLVisiteFiscaliDM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A171MW:=TA171FXMLVisiteFiscaliMW.Create(Self);
  A171MW.selT049:=selT049;
  InizializzaDataSet(selT049,[evBeforeEdit,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
end;

procedure TA171FXMLVisiteFiscaliDM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A171MW);
  inherited;
end;

procedure TA171FXMLVisiteFiscaliDM.selT049AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if A171FXMLVisiteFiscali <> nil then
  begin
    A171FXMLVisiteFiscali.StatusBar.Panels[1].Text:=Format('Record %d/%d',[selT049.RecNo,selT049.RecordCount]);
    A171FXMLVisiteFiscali.rgpDipendente.Caption:=Format('%s %s',[selT049.FieldByName('COGNOME').AsString, selT049.FieldByName('NOME').AsString]);
    if C700SelAnagrafe.SearchRecord('PROGRESSIVO',selT049.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning]) then
      A171FXMLVisiteFiscali.frmSelAnagrafe.VisualizzaDipendente
    else
      A171FXMLVisiteFiscali.frmSelAnagrafe.lblDipendente.Caption:='';
  end;
end;

procedure TA171FXMLVisiteFiscaliDM.selT049BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  Abort;
end;

procedure TA171FXMLVisiteFiscaliDM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A171MW.BeforeEditSelT049;
end;

procedure TA171FXMLVisiteFiscaliDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  A171MW.BeforePostSelT049;
  inherited;
end;

procedure TA171FXMLVisiteFiscaliDM.selT049CODCATASTALE_REPChange(Sender: TField);
begin
  inherited;
  selT049.FieldByName('CAP_REP').AsString:=VarToStr(A171FXMLVisiteFiscaliDM.A171MW.selT480.Lookup('CODCATASTALE',selT049.FieldByName('CODCATASTALE_REP').AsString,'CAP'));
end;

procedure TA171FXMLVisiteFiscaliDM.selT049CalcFields(DataSet: TDataSet);
begin
  inherited;
  A171MW.CalcFieldSelT049;
end;

end.
