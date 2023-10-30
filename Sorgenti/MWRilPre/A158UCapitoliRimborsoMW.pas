unit A158UCapitoliRimborsoMW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, Data.DB, OracleData, C180FunzioniGenerali,
  A000UInterfaccia, Oracle, A000UCostanti;

type
  TA158FCapitoliRimborsoMW = class(TR005FDataModuleMW)
    selM030: TOracleDataSet;
    selM022: TOracleDataSet;
    procedure selM030FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    selM031: TOracleDataSet;
    ArrCapitoliTrasferta:array of TItemsValues;
    procedure ElencoCapitoliTrasferta(Decorrenza:TDateTime);
    procedure OnCalcFields;
    procedure OnBeforePost;
    procedure TestDecorrenzaCapitoloTrasferta(Decorrenza:TDateTime; CapTrasferta:string);
  end;

implementation

{$R *.dfm}

procedure TA158FCapitoliRimborsoMW.ElencoCapitoliTrasferta(Decorrenza:TDateTime);
begin
  SetLength(ArrCapitoliTrasferta,0);
  selM030.First;
  while Not selM030.Eof do
  begin
    if R180Between(Decorrenza,selM030.FieldByName('DECORRENZA').AsDateTime,selM030.FieldByName('DECORRENZA_FINE').AsDateTime) then
    begin
      SetLength(ArrCapitoliTrasferta, Length(ArrCapitoliTrasferta) + 1);
      ArrCapitoliTrasferta[High(ArrCapitoliTrasferta)].Value:=selM030.FieldByName('CODICE').AsString;
      ArrCapitoliTrasferta[High(ArrCapitoliTrasferta)].Item:=selM030.FieldByName('DESCRIZIONE').AsString
    end;
    selM030.Next;
  end;
end;

procedure TA158FCapitoliRimborsoMW.OnCalcFields;
var
  Trovato:Boolean;
begin
  Trovato:=False;
  selM030.First;
  repeat
    if R180Between(selM031.FieldByName('DECORRENZA').AsDateTime, selM030.FieldByName('DECORRENZA').AsDateTime, selM030.FieldByName('DECORRENZA_FINE').AsDateTime) and
       (selM031.FieldByName('CAPITOLO_TRASFERTA').AsString = selM030.FieldByName('CODICE').AsString) then
    begin
      Trovato:=True;
      Break;
    end;
    selM030.Next;
  until selM030.Eof;
  if Trovato then
    selM031.FieldByName('dCapitolo_trasferta').AsString:=selM030.FieldByName('DESCRIZIONE').AsString;
end;

procedure TA158FCapitoliRimborsoMW.OnBeforePost;
begin
  TestDecorrenzaCapitoloTrasferta(selM031.FieldByName('DECORRENZA').AsDateTime,selM031.FieldByName('CAPITOLO_TRASFERTA').AsString);
end;

procedure TA158FCapitoliRimborsoMW.selM030FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=R180Between(selM031.FieldByName('DECORRENZA').AsDateTime,selM030.FieldByName('DECORRENZA').AsDateTime,selM030.FieldByName('DECORRENZA_FINE').AsDateTime);
end;

procedure TA158FCapitoliRimborsoMW.TestDecorrenzaCapitoloTrasferta(Decorrenza:TDateTime; CapTrasferta:string);
var
  QryTest:TOracleQuery;
begin
  inherited;
  QryTest:=TOracleQuery.Create(nil);
  try
    QryTest.Session:=SessioneOracle;
    QryTest.SQL.Add('select count(*) as NUMREC');
    QryTest.SQL.Add('  from M030_CAPITOLI_TRASFERTA M031');
    QryTest.SQL.Add(' where :DECORRENZA between M031.DECORRENZA and M031.DECORRENZA_FINE');
    QryTest.SQL.Add('   and M031.CODICE = :CODICE');
    QryTest.DeclareAndSet('DECORRENZA',otDate, Decorrenza);
    QryTest.DeclareAndSet('CODICE',otString, CapTrasferta.Trim);
    QryTest.Execute;
    if QryTest.FieldAsInteger('NUMREC') <= 0 then
      raise Exception.Create(Format('non esiste nessun capitolo trasferta %s alla data %s.',[CapTrasferta,
                                                                                             DateToStr(Decorrenza)]));
  finally
    FreeAndNil(QryTest);
  end;
end;

end.
