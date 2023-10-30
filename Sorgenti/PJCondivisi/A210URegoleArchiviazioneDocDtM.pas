unit A210URegoleArchiviazioneDocDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StrUtils,
  DB, A000UCostanti, A000USessione, A000UInterfaccia,  RegistrazioneLog, OracleData, Oracle,
  R004UGestStorico, R004UGestStoricoDTM, Variants, C180FunzioniGenerali,A210URegoleArchiviazioneDocMW,
  C022UEseguiProgramma;

type
  TA210FRegoleArchiviazioneDocDtM = class(TR004FGestStoricoDtM)
    selI210: TOracleDataSet;
    selI210APPLICAZIONE: TStringField;
    selI210TIPO_DOCUMENTO: TStringField;
    selI210D_TIPO_DOCUMENTO: TStringField;
    selI210PATH_FILE: TStringField;
    selI210FILE_PDF: TStringField;
    selI210FILE_XML: TStringField;
    selI210CAMPI_XML: TStringField;
    selI210SOSTITUZIONE_FILE: TStringField;
    selI210SVUOTA_DIRECTORY: TStringField;
    selI210SERVER_SFTP: TStringField;
    selI210USERNAME_SFTP: TStringField;
    selI210PASSWORD_SFTP: TStringField;
    selI210DIR_ARCH_SFTP: TStringField;
    selI210PATH_PSCP: TStringField;
    selI210DATA_RIF_ULTIMA_ELAB: TDateTimeField;
    selT962Lookup: TOracleDataSet;
    dsrT962Lookup: TDataSource;
    selI210TIPOLOGIA_DOCUMENTI: TStringField;
    selI210TIPO_FILE_METADATI: TStringField;
    selI210BUCKETID: TStringField;
    selI210VERIFICA_VALIDAZIONE: TStringField;
    selI210SCRIPT_VALIDAZIONE: TStringField;
    selI210SCRIPT_NOTE: TStringField;
    selI210SCRIPT_ARCHIVIAZIONE: TStringField;
    selI210INVIA_REGISTRO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selI210CalcFields(DataSet: TDataSet);
    procedure selI210PASSWORD_SFTPGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selI210PASSWORD_SFTPSetText(Sender: TField; const Text: string);
  private
    { Private declarations }
  public
    { Public declarations }
    A210MW: TA210FRegoleArchiviazioneDocMW;
  end;

var
  A210FRegoleArchiviazioneDocDtM: TA210FRegoleArchiviazioneDocDtM;

implementation

{$R *.DFM}

uses A210URegoleArchiviazioneDoc;


procedure TA210FRegoleArchiviazioneDocDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;

  selT962Lookup.Open;

  A210MW:=TA210FRegoleArchiviazioneDocMW.Create(Self);
  A210MW.selI210:=selI210;
  InizializzaDataSet(selI210,[evBeforeEdit,
                              evBeforeInsert,
                              evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost,
                              evOnTranslateMessage]);
  A210FRegoleArchiviazioneDoc.DButton.DataSet:=selI210;
  selI210.SetVariable('APPLICAZIONE', Parametri.Applicazione);
  selI210.Open;
end;

procedure TA210FRegoleArchiviazioneDocDtM.selI210CalcFields(DataSet: TDataSet);
begin
  inherited;

  if selI210.FieldByName('TIPO_DOCUMENTO').AsString = 'CAR' then
    selI210.FieldByName('D_TIPO_DOCUMENTO').AsString:='Cartellino'
  else if selI210.FieldByName('TIPO_DOCUMENTO').AsString = 'CED' then
    selI210.FieldByName('D_TIPO_DOCUMENTO').AsString:='Cedolino'
  else if selI210.FieldByName('TIPO_DOCUMENTO').AsString = 'CU' then
    selI210.FieldByName('D_TIPO_DOCUMENTO').AsString:='CU'
  else if selI210.FieldByName('TIPO_DOCUMENTO').AsString = 'LOGCED' then
    selI210.FieldByName('D_TIPO_DOCUMENTO').AsString:='Log cedolino'
  else if selI210.FieldByName('TIPO_DOCUMENTO').AsString = 'LOGCU' then
    selI210.FieldByName('D_TIPO_DOCUMENTO').AsString:='Log CU'
  else if selI210.FieldByName('TIPO_DOCUMENTO').AsString = 'TAB' then
    selI210.FieldByName('D_TIPO_DOCUMENTO').AsString:='Tabellone turni';
end;

procedure TA210FRegoleArchiviazioneDocDtM.selI210PASSWORD_SFTPGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text:=R180Decripta(Sender.AsString,A210PSW_CRYPT_PASSPHRASE);
end;

procedure TA210FRegoleArchiviazioneDocDtM.selI210PASSWORD_SFTPSetText(
  Sender: TField; const Text: string);
begin
  inherited;
  Sender.AsString:=R180Cripta(Text,A210PSW_CRYPT_PASSPHRASE);
end;

procedure TA210FRegoleArchiviazioneDocDtM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A210MW.selI210BeforePostNoStorico;
end;

end.
