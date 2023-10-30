unit B018UArticolo71DtM1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, A000Versione, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData,
  (*Midaslib,*) Crtl, DBClient, C180FunzioniGenerali, Variants, USelI010;

type
  TB018FArticolo71DtM1 = class(TDataModule)
    dsrQ265: TDataSource;
    selQ265: TOracleDataSet;
    selT040: TOracleDataSet;
    PeriodiAssenza: TOracleQuery;
    procedure B007FCancellaDtM1Create(Sender: TObject);
    procedure B007FCancellaDtM1Destroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selI010:TselI010;
    MaxLung:Integer;
end;

var
  B018FArticolo71DtM1: TB018FArticolo71DtM1;

implementation

uses B018UArticolo71;

{$R *.DFM}

procedure TB018FArticolo71DtM1.B007FCancellaDtM1Create(Sender: TObject);
var i:integer;
begin
  while True do
  begin
    if Password(Application.Title) = -1 then
    begin
      Parametri.Azienda:='';
      Break;
    end;
    if Parametri.AggiornamentoBaseDati = 'S' then
      Break;
    ShowMessage('L''utente non è abilitato a questa funzione');
  end;
  if Parametri.Azienda = '' then
    exit;
  A000ParamDBOracle(SessioneOracle);
  (*
  if (Parametri.VersioneDB <> '') and (VersionePA <> Parametri.VersioneDB) then
  begin
    ShowMessage('Attenzione!' + #13 +
                 Format('La versione del database (%s) non corrisponde alla versione del prodotto (%s).',[Parametri.VersioneDB,VersionePA]) + #13 +
                 'E'' necessario allineare la propria postazione di lavoro alla versione del database.' + #13 +
                 'Se il problema persiste contattare l''amministratore di sistema.');
    Parametri.Azienda:='';
  end;
  *)
  for i:=0 to ComponentCount - 1 do
  begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    if Components[i] is TOracleScript then
      (Components[i] as TOracleScript).Session:=SessioneOracle;
  end;
  //A000GetLayout(A000SessioneIrisWIN); //Alberto: Già letto su A001UPasswordDtM1
  selQ265.Open;
end;

procedure TB018FArticolo71DtM1.B007FCancellaDtM1Destroy(Sender: TObject);
begin
  selQ265.Close;
end;

end.
