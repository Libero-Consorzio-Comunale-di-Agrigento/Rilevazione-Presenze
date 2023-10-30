unit WA019URaggrGiustifDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione;

type
  TWA019FRaggrGiustifDM = class(TWR302FGestTabellaDM)
    selTabellaCodice: TStringField;
    selTabellaDescrizione: TStringField;
    selTabellaCodInterno: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterPost(DataSet: TDataSet); override;
  private
  public
  end;

implementation

{$R *.dfm}

procedure TWA019FRaggrGiustifDM.AfterPost(DataSet: TDataSet);
var S:String;
begin
  inherited;
  with DataSet do
  begin
    S:=FieldByName('CODICE').AsString;
    DisableControls;
    Refresh;
    Locate('CODICE',S,[]);
    EnableControls;
  end;
end;

procedure TWA019FRaggrGiustifDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
end;

end.
