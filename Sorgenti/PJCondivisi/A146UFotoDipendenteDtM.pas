unit A146UFotoDipendenteDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, A000UInterfaccia, DB, OracleData, C180FunzioniGenerali,
  Oracle, System.IOUtils, A146UFotoDipendenteMW;

type
  TA146FFotoDipendenteDtM = class(TR004FGestStoricoDtM)
    selT032: TOracleDataSet;
    selT032FOTO: TBlobField;
    selT032PROGRESSIVO: TIntegerField;
    selT032FILE_FOTO: TStringField;
    DT032: TDataSource;
    selT032FMT_BLOB: TStringField;
    procedure selT032NewRecord(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure selT032BeforePost(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    A146FMW: TA146FFotoDipendenteMW;
  end;

var
  A146FFotoDipendenteDtM: TA146FFotoDipendenteDtM;

implementation

uses A146UFotoDipendente;

{$R *.dfm}

procedure TA146FFotoDipendenteDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  InizializzaDataSet(selT032,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);

  A146FMW:=TA146FFotoDipendenteMW.Create(Self);
  A146FMW.selT032:=selT032;
end;

procedure TA146FFotoDipendenteDtM.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A146FMW);
end;

procedure TA146FFotoDipendenteDtM.selT032BeforePost(DataSet: TDataSet);
begin
  inherited;
  A146FMW.selT032BeforePost(DataSet);
end;

procedure TA146FFotoDipendenteDtM.selT032NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT032PROGRESSIVO.AsInteger:=A146FFotoDipendente.Progressivo;
end;

end.
