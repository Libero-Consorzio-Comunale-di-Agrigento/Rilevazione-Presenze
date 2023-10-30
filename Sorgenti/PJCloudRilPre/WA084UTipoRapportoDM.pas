unit WA084UTipoRapportoDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,
  A000UCostanti, A000USessione, medpIWMessageDlg;

type
  TWA084FTipoRapportoDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaTIPO: TStringField;
    selTabellaD_TIPO: TStringField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
  private
  public
  end;

implementation

uses WR100UBase;

{$R *.dfm}

procedure TWA084FTipoRapportoDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
end;

end.
