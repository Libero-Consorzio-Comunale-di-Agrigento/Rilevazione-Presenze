unit A155URicercaDocumentaleDtM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  OracleData, Dialogs, A000USessione, A000UCostanti, A000UMessaggi,
  A000UInterfaccia, C700USelezioneAnagrafe, R004UGestStoricoDTM,
  DBClient, A155URicercaDocumentaleMW;

type
  TA155FRicercaDocumentaleDtM = class(TR004FGestStoricoDtM)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    A155MW: TA155FRicercaDocumentaleMW;
  end;

var
  A155FRicercaDocumentaleDtM: TA155FRicercaDocumentaleDtM;

implementation

uses A155URicercaDocumentale;

{$R *.dfm}

procedure TA155FRicercaDocumentaleDtM.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A155MW:=TA155FRicercaDocumentaleMW.Create(Self);
  InizializzaDataSet(A155MW.selT960,[evOnNewRecord,
                                     evBeforePostNoStorico,
                                     evBeforeDelete,
                                     evAfterDelete,
                                     evAfterPost]);
end;

procedure TA155FRicercaDocumentaleDtM.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(A155MW);
  inherited;
end;

end.
