unit A179UProfiliIterAutMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, A000UCostanti, Data.DB,
  Datasnap.DBClient;

type
  TA179FProfiliIterAutMW = class(TR005FDataModuleMW)
    cdsI075LookUp: TClientDataSet;
    cdsI075LookUpCODICE: TStringField;
    cdsI075LookUpDESCRIZIONE: TStringField;
    procedure cdsI075LookUpAfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  const
    D_TipoAccesso:array [0..2] of TItemsValues = (
      (Item:'Negato'; Value:'N'),
      (Item:'Da filtro funzioni'; Value:'F'),
      (Item:'Sola lettura'; Value:'R')
      );
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA179FProfiliIterAutMW.cdsI075LookUpAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
  inherited;
  for i:=Low(D_TipoAccesso) to High(D_TipoAccesso) do
  begin
    cdsI075LookUp.Insert;
    cdsI075LookUp.FieldByName('CODICE').AsString:=D_TipoAccesso[i].Value;
    cdsI075LookUp.FieldByName('DESCRIZIONE').AsString:=D_TipoAccesso[i].Item;
    cdsI075LookUp.Post;
  end;
end;

procedure TA179FProfiliIterAutMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  cdsI075LookUp.Open;
end;

end.
