unit WA210URegoleArchiviazioneDocDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR302UGestTabellaDM, Data.DB, OracleData,
  System.StrUtils, A000UInterfaccia, A000UCostanti, C180FunzioniGenerali,
  A210URegoleArchiviazioneDocMW;

type
  TProcDataSet = procedure(DataSet: TDataSet) of object;

  TWA210FRegoleArchiviazioneDocDM = class(TWR302FGestTabellaDM)
    selTabellaAPPLICAZIONE: TStringField;
    selTabellaTIPO_DOCUMENTO: TStringField;
    selTabellaPATH_FILE: TStringField;
    selTabellaFILE_PDF: TStringField;
    selTabellaFILE_XML: TStringField;
    selTabellaCAMPI_XML: TStringField;
    selTabellaSOSTITUZIONE_FILE: TStringField;
    selTabellaD_TIPO_DOCUMENTO: TStringField;
    selTabellaD_SOSTITUZIONE_FILE: TStringField;
    selTabellaSVUOTA_DIRECTORY: TStringField;
    selTabellaD_SVUOTA_DIRECTORY: TStringField;
    selTabellaSERVER_SFTP: TStringField;
    selTabellaUSERNAME_SFTP: TStringField;
    selTabellaPASSWORD_SFTP: TStringField;
    selTabellaDIR_ARCH_SFTP: TStringField;
    selTabellaPATH_PSCP: TStringField;
    selTabellaDATA_RIF_ULTIMA_ELAB: TDateTimeField;
    selTabellaBUCKETID: TStringField;
    selTabellaTIPO_FILE_METADATI: TStringField;
    selT962Lookup: TOracleDataSet;
    dsrT962Lookup: TDataSource;
    selTabellaTIPOLOGIA_DOCUMENTI: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure IWUserSessionBaseDestroy(Sender: TObject);
    procedure selTabellaPASSWORD_SFTPGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure selTabellaPASSWORD_SFTPSetText(Sender: TField;
      const Text: string);
    procedure selTabellaBeforeEdit(DataSet: TDataSet);
  private
    { Private declarations }
  public
    A210MW:TA210FRegoleArchiviazioneDocMW;
    AfterScrollCustom: TProcDataSet;
  end;

implementation

uses WA210URegoleArchiviazioneDoc;

{$R *.dfm}

procedure TWA210FRegoleArchiviazioneDocDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  A210MW:=TA210FRegoleArchiviazioneDocMW.Create(Self);
  A210MW.selI210:=selTabella;
  selTabella.Filtered:=true;

  selTabella.SetVariable('APPLICAZIONE', Parametri.Applicazione);

  selT962Lookup.Open;
end;

procedure TWA210FRegoleArchiviazioneDocDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  A210MW.selI210BeforePostNoStorico;
end;

procedure TWA210FRegoleArchiviazioneDocDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A210MW)//.Free;
end;

procedure TWA210FRegoleArchiviazioneDocDM.selTabellaBeforeEdit(
  DataSet: TDataSet);
begin
  inherited;
    if Assigned(AfterScrollCustom) then
    AfterScrollCustom(DataSet);
end;

procedure TWA210FRegoleArchiviazioneDocDM.selTabellaPASSWORD_SFTPGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  inherited;
   Text:=R180Decripta(Sender.AsString,A210PSW_CRYPT_PASSPHRASE);
end;

procedure TWA210FRegoleArchiviazioneDocDM.selTabellaPASSWORD_SFTPSetText(
  Sender: TField; const Text: string);
begin
  inherited;
  Sender.AsString:=R180Cripta(Text,A210PSW_CRYPT_PASSPHRASE);
end;

end.
