unit A154UGestioneDocumentaleDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  OracleData, Dialogs, A000USessione, A000UCostanti, A000UMessaggi,
  A000UInterfaccia, C700USelezioneAnagrafe, R004UGestStoricoDTM,
  DBClient, A154UGestioneDocumentaleMW;

type
  TA154FGestioneDocumentaleDtM = class(TR004FGestStoricoDtM)
    selT960: TOracleDataSet;
    selT960ID: TFloatField;
    selT960DATA_CREAZIONE: TDateTimeField;
    selT960NOME_UTENTE: TStringField;
    selT960UTENTE: TStringField;
    selT960PROGRESSIVO: TFloatField;
    selT960TIPOLOGIA: TStringField;
    selT960UFFICIO: TStringField;
    selT960NOME_FILE: TStringField;
    selT960EXT_FILE: TStringField;
    selT960DIMENSIONE: TFloatField;
    selT960PERIODO_DAL: TDateTimeField;
    selT960PERIODO_AL: TDateTimeField;
    selT960NOTE: TStringField;
    selT960D_NOME_FILE: TStringField;
    selT960D_CARTELLA_FILE: TStringField;
    selT960WEB_MATRICOLA: TStringField;
    selT960D_DIMENSIONE: TStringField;
    selT960D_PROPRIETARIO: TStringField;
    selT960D_TIPOLOGIA: TStringField;
    selT960D_UFFICIO: TStringField;
    selT960WEB_NOMINATIVO: TStringField;
    selT960DATA_ACCESSO: TDateTimeField;
    selT960UTENTE_ACCESSO: TStringField;
    selT960D_DATI_ACCESSO: TStringField;
    selT960ACCESSO_RESPONSABILE: TStringField;
    selT960D_ACCESSO_RESPONSABILE: TStringField;
    selT960DATA_LETTURA_PROGRESSIVO: TDateTimeField;
    selT960AUTOCERTIFICAZIONE: TStringField;
    selT960DATA_RILASCIO: TDateTimeField;
    selT960RICHIEDERE_ENTE: TStringField;
    selT960DATA_RICHIESTA_ENTE: TDateTimeField;
    selT960DATA_RICEZIONE_ENTE: TDateTimeField;
    selT960PATH_STORAGE: TStringField;
    selT960D_PATH_STORAGE: TStringField;
    selT960DATA_NOTIFICA: TDateTimeField;
    selT960ACCESSO_PORTALE: TStringField;
    selT960D_ACCESSO_PORTALE: TStringField;
    selT960PROVENIENZA: TStringField;
    selT960CF_FAMILIARE: TStringField;
    selT960VERSIONE: TFloatField;
    selT960HASH: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
    procedure DataModuleDestroy(Sender: TObject);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT960CalcFields(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure AfterDelete(DataSet: TDataSet); override;
    procedure BeforeEdit(DataSet: TDataSet); override;
    procedure selT960AfterScroll(DataSet: TDataSet);
    procedure selT960BeforeRefresh(DataSet: TDataSet);
    procedure selT960AfterRefresh(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A154MW: TA154FGestioneDocumentaleMW;
  end;

var
  A154FGestioneDocumentaleDtM: TA154FGestioneDocumentaleDtM;

implementation

uses A154UGestioneDocumentale;

{$R *.dfm}

procedure TA154FGestioneDocumentaleDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT960.SetVariable('AZIENDA',Parametri.Azienda);
  InizializzaDataSet(selT960,[evOnNewRecord,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  A154MW:=TA154FGestioneDocumentaleMW.Create(Self);
  A154MW.selT960_Funzioni:=selT960;

  selT960.Open;
end;

procedure TA154FGestioneDocumentaleDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A154MW);
  inherited;
end;

procedure TA154FGestioneDocumentaleDtM.AfterDelete(DataSet: TDataSet);
// sovrascrivo il metodo perché non deve richiamare AfterPost!
begin
  // noop
end;

procedure TA154FGestioneDocumentaleDtM.AfterPost(DataSet: TDataSet);
begin
  A154MW.DestEMailAllegato:=UFFICIOTODIPENDENTE;
  A154MW.AfterPost;
end;

procedure TA154FGestioneDocumentaleDtM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  A154MW.BeforeDelete;
end;

procedure TA154FGestioneDocumentaleDtM.BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  A154MW.BeforeEdit;
end;

procedure TA154FGestioneDocumentaleDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A154MW.BeforePost;
  A154MW.EditNomeFile:=(selT960.State = dsInsert) and (not selT960.FieldByName('NOME_FILE').IsNull);
  A154MW.EditNomeFile:=A154MW.EditNomeFile or ((selT960.State = dsEdit) and (selT960.FieldByName('NOME_FILE').medpOldValue = null) and (not selT960.FieldByName('NOME_FILE').IsNull));
end;

procedure TA154FGestioneDocumentaleDtM.OnNewRecord(DataSet: TDataSet);
begin
  //inherited // no, perché imposta field decorrenza!
  A154MW.OnNewRecord;
  DataSet.FieldByName('PROGRESSIVO').AsInteger:=C700Progressivo;
end;

procedure TA154FGestioneDocumentaleDtM.selT960AfterScroll(DataSet: TDataSet);
var
  LEsisteFile: Boolean;
begin
  LEsisteFile:=DataSet.FieldByName('NOME_FILE').AsString <> '';
  A154FGestioneDocumentale.actFileVisualizza.Enabled:=LEsisteFile;
  A154FGestioneDocumentale.actFileDownload.Enabled:=LEsisteFile;
  //Se l'allegato è già stato notificato al dipendente disabilito il bottone
  A154FGestioneDocumentale.btnEMailAllegato.Enabled:=selT960.FieldByName('DATA_NOTIFICA').IsNull;
  // Consento la modifica del flag "Visibile dal portale IrisWeb" solo se il documento non è stato
  // caricato dall'utente
  A154FGestioneDocumentale.dchkAccessoPortale.Enabled:=(selT960.FieldByName('UTENTE').AsString <> '');
  A154FGestioneDocumentale.dcmbFamiliare.Text:=selT960.FieldByName('CF_FAMILIARE').AsString;
  A154FGestioneDocumentale.lblD_Familiare.Caption:='';
  if A154MW.selSG101.SearchRecord('CODFISCALE',selT960.FieldByName('CF_FAMILIARE').AsString,[srFromBeginning]) then
    A154FGestioneDocumentale.lblD_Familiare.Caption:=A154MW.selSG101.FieldByName('DENOMINAZIONE').AsString;

  A154FGestioneDocumentale.GestioneAfterScroll;
end;

procedure TA154FGestioneDocumentaleDtM.selT960BeforeRefresh(DataSet: TDataSet);
begin
  A154MW.BeforeRefresh;
end;

procedure TA154FGestioneDocumentaleDtM.selT960AfterRefresh(DataSet: TDataSet);
begin
  A154MW.AfterRefresh;
end;

procedure TA154FGestioneDocumentaleDtM.selT960CalcFields(DataSet: TDataSet);
begin
  A154MW.OnCalcFields;
end;

end.
