unit WA080URientriObbligatoriDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,WR302UGestTabellaDM, DB, OracleData, Oracle,C180FunzioniGenerali;

type
  TWA080FRientriObbligatoriDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDECORRENZA: TDateTimeField;
    selTabellaDECORRENZA_FINE: TDateTimeField;
    selTabellaGG_LAVORATIVI: TFloatField;
    selTabellaRIENTRI_OBBL: TFloatField;
    procedure selTabellaNewRecord(DataSet: TDataSet);
    procedure BeforeEdit(DataSet: TDataSet);override;
    procedure BeforeInsert(DataSet: TDataSet);override;
  private
    FTipoCartellino:String;
  public
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure PutTipoCartellino(Valore:String);
    property TipoCartellino:String read FTipoCartellino write PutTipoCartellino;
  end;

implementation

{$R *.dfm}

//Massimo 23/01/2013
//Ridefinita la procedure per non far eseguire l'evento BeforeEdit dal WR302FGestTabellaDM
//ed evitare che vengano messi readonly i campi in chiave
procedure TWA080FRientriObbligatoriDM.BeforeEdit(DataSet: TDataSet);
var S:String;
begin
  S:='';
end;

//Massimo 30/01/2013
//Ridefinita la procedure per non far eseguire l'evento BeforeInsert dal WR302FGestTabellaDM
//ed evitare che vengano messi readonly i campi in chiave
procedure TWA080FRientriObbligatoriDM.BeforeInsert(DataSet: TDataSet);
var S:String;
begin
  S:='';
end;

procedure TWA080FRientriObbligatoriDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  inherited;
end;

procedure TWA080FRientriObbligatoriDM.PutTipoCartellino(Valore: String);
begin
  FTipoCartellino:=Valore;
  R180SetVariable(selTabella,'TIPOCARTELLINO',FTipoCartellino);
  selTabella.Open;
end;

procedure TWA080FRientriObbligatoriDM.selTabellaNewRecord(DataSet: TDataSet);
begin
  inherited;
  selTabella.FieldByName('CODICE').AsString:=TipoCartellino;
end;

end.
