unit WP050UCodArrotondamentiDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR302UGestTabellaDM, DB, OracleData;

type
  TWP050FCodArrotondamentiDM = class(TWR302FGestTabellaDM)
    selTabellaCOD_ARROTONDAMENTO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWP050FCodArrotondamentiDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY COD_ARROTONDAMENTO');
  inherited;

end;

end.
