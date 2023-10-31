unit A175URegoleOrologiMW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, OracleData, Data.DB, C180FunzioniGenerali, Oracle;

type
  TA175FRegoleOrologiMW = class(TR005FDataModuleMW)
    selT361: TOracleDataSet;
    selT275: TOracleDataSet;
    insT363: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public
    selT362: TOracleDataSet;
    selT363: TOracleDataSet;
    Storicizza: Boolean;
    procedure selT362BeforePost;
    procedure selT362AfterPost;
    procedure selT362AfterScroll;
    procedure selT363BeforePost;
    procedure selT363OnNewRecord;
    procedure ControllaCausali(DataSet: TDataSet);
  end;

const
  Giorni = '*,1,2,3,4,5,6,7';

var
  A175FRegoleOrologiMW: TA175FRegoleOrologiMW;

implementation

uses
  A175URegoleOrologiDM;

{$R *.dfm}

procedure TA175FRegoleOrologiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT361.Open;
  selT275.Open;
end;

procedure TA175FRegoleOrologiMW.selT362BeforePost;
begin
  if Storicizza then
  begin
    insT363.SetVariable('VECCHIO',A175FRegoleOrologiDM.selT362.FieldByName('ID').AsFloat);
  end;
  ControllaCausali(selT362);
  if (selT362.State in [dsInsert]) then
    selT362.FieldByName('ID').Value:=Null;  //permette l'uso della sequenza in delphi (SequenceField on Post)
end;

procedure TA175FRegoleOrologiMW.selT362AfterPost;
begin
  if Storicizza then
  begin
    insT363.SetVariable('NUOVO',A175FRegoleOrologiDM.selT362.FieldByName('ID').AsFloat);
    insT363.Execute;
    Storicizza:=False;
  end;
end;

procedure TA175FRegoleOrologiMW.selT362AfterScroll;
//aggiornamento della tabella per visualizzare il contenuto collegato alla riga selezionata sulla grid principale
begin
  selT363.Close;
  selT363.SetVariable('ID', selT362.FieldByName('ID').AsInteger);
  selT363.Open;
end;

procedure TA175FRegoleOrologiMW.selT363BeforePost;
begin
  ControllaCausali(selT363);
  //controlli sulla validità dell'input
  if not R180In(selT363.FieldByName('GG').AsString,Giorni.Split([','])) then
    raise Exception.Create('Indicare i giorni da 1 a 7, * per indicare un giorno generico');
  R180OraValidate(selT363.FieldByName('DALLE').AsString);
  R180OraValidate(selT363.FieldByName('ALLE').AsString);
  if R180OreMinuti(selT363.FieldByName('DALLE').AsString) >= R180OreMinuti(selT363.FieldByName('ALLE').AsString) then
    raise Exception.Create('Le ore devono essere in ordine cronologico');
end;

procedure TA175FRegoleOrologiMW.selT363OnNewRecord;
begin
  selT363.FieldByName('ID').AsInteger:=selT362.FieldByName('ID').AsInteger;
end;

procedure TA175FRegoleOrologiMW.ControllaCausali(DataSet: TDataSet);
//controllo: se è selezionato il valore "*", è possibile solamente aggiungere il valore "-"
begin
  if R180NumOccorrenzeCar(DataSet.FieldByName('CAUSALI_ABILITATE').AsString,'*') > 0 then
  begin
    if R180NumOccorrenzeCar(DataSet.FieldByName('CAUSALI_ABILITATE').AsString,'-') = 0 then
    begin
      if Length(DataSet.FieldByName('CAUSALI_ABILITATE').AsString) > 1 then
        raise Exception.Create('Errore: In caso di selezione di tutte le causali (*), l''unico altro valore ammesso è la causale vuota');
    end
    else
    begin
      if Length(DataSet.FieldByName('CAUSALI_ABILITATE').AsString) > 3 then
        raise Exception.Create('Errore: In caso di selezione di tutte le causali (*), l''unico altro valore ammesso è la causale vuota');
    end;
  end;
end;

end.
