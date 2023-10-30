unit A146UFotoDipendenteMW;

interface

uses
  System.SysUtils, System.Classes, DB, OracleData, Oracle, System.IOUtils,
  A000UInterfaccia, R005UDataModuleMW;

type
  TA146FFotoDipendenteMW = class(TR005FDataModuleMW)
    selT032Blob: TOracleDataSet;
    updT032Blob: TOracleQuery;
    procedure selT032BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    selT032 : TOracleDataSet;
    procedure CopiaTuttoSuDatabase;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA146FFotoDipendenteMW.selT032BeforePost(DataSet: TDataSet);
begin
  if Not FileExists(selT032.FieldByName('FILE_FOTO').AsString) and (Not selT032.FieldByName('FILE_FOTO').isNull) then
  begin
    selT032.FieldByName('FILE_FOTO').Clear;
    Raise Exception.Create('Percorso file inesistente');
  end;
  inherited;
end;

procedure TA146FFotoDipendenteMW.CopiaTuttoSuDatabase;
var
 LOB: TLOBLocator;
 //Buffer: array[0..99] of Byte;
 //BlobField: TField;
 // BS: TStream;
 LFile: string;
begin
  LOB:=TLOBLocator.CreateTemporary(SessioneOracleR005,otBLOB,True);
  try
    selT032Blob.Close;
    selT032Blob.Open;
    while not selT032Blob.Eof do
    begin
      LFile:=selT032Blob.FieldByName('FILE_FOTO').AsString;
      if TFile.Exists(LFile) then
      begin
        LOB.LoadFromFile(selT032Blob.FieldByName('FILE_FOTO').AsString);

        // carica la foto su database
        updT032Blob.SetVariable('PROGRESSIVO',selT032Blob.FieldByName('PROGRESSIVO').AsInteger);
        updT032Blob.SetComplexVariable('FOTO',LOB);
        updT032Blob.Execute;
        SessioneOracleR005.Commit;
      end
      else
      begin
        // file non esistente
      end;

      selT032Blob.Next;
    end;

    // refresh del dataset principale
    selT032.Close;
    selT032.Open;
  finally
    LOB.Free;
  end;
end;




end.
