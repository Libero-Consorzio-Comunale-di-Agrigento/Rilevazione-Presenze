unit WA200UImportazioneMassivaDocumentiDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR300UBaseDM, B022UUtilityGestDocumentaleMW,
  Data.DB, Datasnap.DBClient;

type
  TWA200FImportazioneMassivaDocumentiDM = class(TWR300FBaseDM)
    cdsAppTipologia: TClientDataSet;
    cdsAppUfficio: TClientDataSet;
    dsrAppTipologia: TDataSource;
    dsrAppUfficio: TDataSource;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure IWUserSessionBaseDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    B022MW: TB022FUtilityGestDocumentaleMW;
  end;

implementation

uses WA200UImportazioneMassivaDocumenti;

{$R *.dfm}

procedure TWA200FImportazioneMassivaDocumentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
  B022MW:=TB022FUtilityGestDocumentaleMW.Create(nil);
  (Self.Owner as TWA200FImportazioneMassivaDocumenti).dcmbImpTipologia.ListSource:=B022MW.dsrT962;
  (Self.Owner as TWA200FImportazioneMassivaDocumenti).dcmbImpUfficio.ListSource:=B022MW.dsrT963;
  cdsAppTipologia.CreateDataSet;
  cdsAppTipologia.Append;
  cdsAppUfficio.CreateDataSet;
  cdsAppUfficio.Append;
end;

procedure TWA200FImportazioneMassivaDocumentiDM.IWUserSessionBaseDestroy(Sender: TObject);
begin
  FreeAndNil(B022MW);
  inherited;
end;

end.
