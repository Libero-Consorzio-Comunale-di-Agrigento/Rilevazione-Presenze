unit A200UImportazioneMassivaDocumentiDtM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, OracleData, Oracle, Vcl.Forms,
  A000USessione, A000UInterfaccia, B022UUtilityGestDocumentaleMW;

type
  TA200FImportazioneMassivaDocumentiDtM = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    B022MW: TB022FUtilityGestDocumentaleMW;
  end;

var
  A200FImportazioneMassivaDocumentiDtM: TA200FImportazioneMassivaDocumentiDtM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

  uses A200UImportazioneMassivaDocumenti;

{$R *.dfm}

procedure TA200FImportazioneMassivaDocumentiDtM.DataModuleCreate(Sender: TObject);
var
  i:Integer;
begin
  if not SessioneOracle.Connected  then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  for i:=0 to Self.ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
  end;

  B022MW:=TB022FUtilityGestDocumentaleMW.Create(nil);

  A200FImportazioneMassivaDocumenti.dcmbImpTipologia.ListSource:=B022MW.dsrT962;
  A200FImportazioneMassivaDocumenti.dcmbImpUfficio.ListSource:=B022MW.dsrT963;
end;

procedure TA200FImportazioneMassivaDocumentiDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(B022MW);
  inherited;
end;

end.
