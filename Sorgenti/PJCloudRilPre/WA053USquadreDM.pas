unit WA053USquadreDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR303UGestMasterDetailDM, DBClient, DB, OracleData,Oracle,
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi,C180FunzioniGenerali;

type
  TWA053FSquadreDM = class(TWR303FGestMasterDetailDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaDESCRIZIONELUNGA: TStringField;
    selTabellaTOTMIN1: TIntegerField;
    selTabellaTOTMIN2: TIntegerField;
    selTabellaTOTMIN3: TIntegerField;
    selTabellaTOTMIN4: TIntegerField;
    selTabellaFESMIN1: TIntegerField;
    selTabellaFESMIN2: TIntegerField;
    selTabellaFESMIN3: TIntegerField;
    selTabellaFESMIN4: TIntegerField;
    dsrT601: TDataSource;
    selT601: TOracleDataSet;
    selT601CODICE: TStringField;
    selT601MIN1: TIntegerField;
    selT601MAX1: TIntegerField;
    selT601FESMIN1: TIntegerField;
    selT601FESMAX1: TIntegerField;
    selT601OTTIMALE1FR: TIntegerField;
    selT601OTTIMALE1FS: TIntegerField;
    selT601MIN2: TIntegerField;
    selT601MAX2: TIntegerField;
    selT601FESMIN2: TIntegerField;
    selT601FESMAX2: TIntegerField;
    selT601OTTIMALE2FR: TIntegerField;
    selT601OTTIMALE2FS: TIntegerField;
    selT601MIN3: TIntegerField;
    selT601MAX3: TIntegerField;
    selT601FESMIN3: TIntegerField;
    selT601FESMAX3: TIntegerField;
    selT601OTTIMALE3FR: TIntegerField;
    selT601OTTIMALE3FS: TIntegerField;
    selT601MIN4: TIntegerField;
    selT601MAX4: TIntegerField;
    selT601FESMIN4: TIntegerField;
    selT601FESMAX4: TIntegerField;
    selT601SQUADRA: TStringField;
    selT601ORARIO: TStringField;
    selT601PROFILO: TStringField;
    selT601TURNAZ: TStringField;
    selTabellaTOTMAX1: TIntegerField;
    selTabellaTOTMAX2: TIntegerField;
    selTabellaTOTMAX3: TIntegerField;
    selTabellaTOTMAX4: TIntegerField;
    selTabellaFESMAX1: TIntegerField;
    selTabellaFESMAX2: TIntegerField;
    selTabellaFESMAX3: TIntegerField;
    selTabellaFESMAX4: TIntegerField;
    selT265: TOracleDataSet;
    selTabellaCAUS_RIPOSO: TStringField;
    selTabellaMIN_IND1: TIntegerField;
    selTabellaMIN_IND2: TIntegerField;
    selTabellaMIN_IND3: TIntegerField;
    selTabellaMIN_IND4: TIntegerField;
    selTabellaPERIODO_MATUR_IND: TIntegerField;
    selTabellaMIN_FESTIVITA_MESE: TIntegerField;
    selTabellaPRIORITA_MINMAX: TStringField;
    selT602: TOracleDataSet;
    selT640: TOracleDataSet;
    selT601AggiornaSquadra: TOracleQuery;
    selTabellaMAX_NOTTI_MESE: TIntegerField;
    Q651: TOracleDataSet;
    Q651Codice_Operatore: TStringField;
    Q651Codice_Squadra: TStringField;
    Q651Codice_Area: TStringField;
    selT650: TOracleDataSet;
    lstT601: TOracleDataSet;
    Q651CancellaSquadra: TOracleQuery;
    Q651CancellaOperatore: TOracleQuery;
    Q651AggiornaSquadra: TOracleQuery;
    Q651AggiornaOperatore: TOracleQuery;
    D651: TDataSource;
    selT601CancellaSquadra: TOracleQuery;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure RelazionaTabelleFiglie;override;
    procedure BeforePostNoStorico(DataSet: TDataSet);override;
    procedure Q651NewRecord(DataSet: TDataSet);
    procedure selTabellaBeforeDelete(DataSet: TDataSet);
    procedure selT601BeforeDelete(DataSet: TDataSet);
    procedure selT601BeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses WA053USquadre;

{$R *.dfm}

procedure TWA053FSquadreDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
  selT601.Open;
  selT265.Open;
  selT640.Open;
  selT602.Open;
  Q651.Open;
  lstT601.Open;
  selT650.Open;
end;

procedure TWA053FSquadreDM.Q651NewRecord(DataSet: TDataSet);
begin
  inherited;
  Q651Codice_Squadra.AsString:=selTabellaCODICE.AsString;
end;

procedure TWA053FSquadreDM.RelazionaTabelleFiglie;
begin
  inherited;
  selT601.DisableControls;
  selT601.Close;
  selT601.SetVariable('SQUADRA',selTabella.FieldByName('CODICE').AsString);
  selT601.Open;
  selT601.EnableControls;

  Q651.DisableControls;
  Q651.Close;
  Q651.SetVariable('SQUADRA',selTabella.FieldByName('CODICE').AsString);
  Q651.Open;
  Q651.EnableControls;

  lstT601.DisableControls;
  lstT601.Close;
  lstT601.SetVariable('SQUADRA',selTabella.FieldByName('CODICE').AsString);
  lstT601.Open;
  lstT601.EnableControls;
end;

procedure TWA053FSquadreDM.selT601BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  Q651CancellaOperatore.SetVariable('Squadra',selT601Squadra.AsString);
  Q651CancellaOperatore.SetVariable('Operatore',selT601Codice.AsString);
  Q651CancellaOperatore.Execute;
end;

procedure TWA053FSquadreDM.selT601BeforePost(DataSet: TDataSet);
begin
  inherited;
  if selT601.State = dsEdit then
    if selT601Codice.Value <> selT601Codice.medpOldValue then
    begin
      Q651AggiornaOperatore.SetVariable('Squadra',selT601Squadra.Value);
      Q651AggiornaOperatore.SetVariable('Operatore',selT601Codice.Value);
      Q651AggiornaOperatore.SetVariable('Operatore_Old',selT601Codice.medpOldValue);
      try
        Q651AggiornaOperatore.Execute;
      except
        SessioneOracle.Rollback;
        raise;
      end;
    end;
end;

procedure TWA053FSquadreDM.selTabellaBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  selT601CancellaSquadra.SetVariable('Squadra',selTabellaCodice.AsString);
  selT601CancellaSquadra.Execute;
  Q651CancellaSquadra.SetVariable('Squadra',selTabellaCodice.AsString);
  Q651CancellaSquadra.Execute;
end;

procedure TWA053FSquadreDM.BeforePostNoStorico(DataSet: TDataSet);
var i:Integer;
    TempStr:String;
begin
  inherited;
  if selTabella.State = dsEdit then
    if selTabellaCodice.Value <> selTabellaCodice.medpOldValue then
    begin
      selT601AggiornaSquadra.SetVariable('Squadra',selTabellaCodice.Value);
      selT601AggiornaSquadra.SetVariable('Squadra_Old',selTabellaCodice.medpOldValue);
      Q651AggiornaSquadra.SetVariable('Squadra',selTabellaCodice.Value);
      Q651AggiornaSquadra.SetVariable('Squadra_Old',selTabellaCodice.medpOldValue);
      try
        selT601AggiornaSquadra.Execute;
        Q651AggiornaSquadra.Execute;
      except
        SessioneOracle.Rollback;
        raise;
      end;
    end;
  //=====================================================================
  //COTROLLO CHE IL CAMPO "PRIORITA_MINMAX" SIA VALORIZZATO CORRETTAMENTE
  //=====================================================================
  TempStr:=Copy(selTabella.FieldByName('PRIORITA_MINMAX').AsString,1,4);
  i:=1;
  While i <= Length(TempStr) do
  begin
    if (Copy(TempStr,i,1) <> '1') and (Copy(TempStr,i,1) <> '2') and
       (Copy(TempStr,i,1) <> '3') and (Copy(TempStr,i,1) <> '4') then
    begin
      TempStr:=StringReplace(TempStr,Copy(TempStr,i,1),'',[rfReplaceAll]);
      i:=0;
    end;
    Inc(i);
  end;
  i:=1;
  repeat
    if Pos(IntToStr(i),TempStr) <= 0 then
      TempStr:=TempStr + IntToStr(i);
    Inc(i);
  until Length(TempStr) >= 4 ;
  selTabella.FieldByName('PRIORITA_MINMAX').AsString:=TempStr;
end;

end.
