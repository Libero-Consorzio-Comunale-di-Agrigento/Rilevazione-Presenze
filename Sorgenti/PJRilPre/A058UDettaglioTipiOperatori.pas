unit A058UDettaglioTipiOperatori;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Data.DB, C180FUnzioniGenerali;

type
  TA058FDettaglioTipiOperatori = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    DataRif:TDateTime;
  end;

var
  A058FDettaglioTipiOperatori: TA058FDettaglioTipiOperatori;

implementation

uses A058UPianifTurniDtM1, A058UPianifTurni;

{$R *.dfm}

procedure TA058FDettaglioTipiOperatori.FormShow(Sender: TObject);
begin
  Self.Caption:=StringReplace(Self.Caption,'dd/mm/yyyy',FormatDateTime('dd/mm/yyyy',DataRif),[rfReplaceAll]);
  with A058FPianifTurniDtM1 do
  begin
    //Recupero i massimi e i minimi
    R180SetVariable(selT606a,'PROGRESSIVO',-1); //Non individuale
    R180SetVariable(selT606a,'COD_SQUADRA',A058FPianifTurniDtm1.SquadraRiferimento);
    R180SetVariable(selT606a,'COD_ORARIO','*'); //Tutti gli orari
    R180SetVariable(selT606a,'COD_CONDIZIONE','00001'); //Numero teste
    if (not selT606a.Active) or (not R180Between(DataRif,selT606a.FieldByName('DECORRENZA').AsDateTime,selT606a.FieldByName('DECORRENZA_FINE').AsDateTime)) then
      R180SetVariable(selT606a,'DATA',DataRif);
    selT606a.Open;
  end;
end;

procedure TA058FDettaglioTipiOperatori.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(A058FDettaglioTipiOperatori);
end;

end.
