unit WA012UCalendariDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient, A000UCostanti, A000USessione,
  C180FunzioniGenerali, medpIWMessageDlg;

type
  TWA012FCalendariDM = class(TWR302FGestTabellaDM)
    selTabellaCODICE: TStringField;
    selTabellaDESCRIZIONE: TStringField;
    selTabellaLUNEDI: TStringField;
    selTabellaMARTEDI: TStringField;
    selTabellaMERCOLEDI: TStringField;
    selTabellaGIOVEDI: TStringField;
    selTabellaVENERDI: TStringField;
    selTabellaSABATO: TStringField;
    selTabellaDOMENICA: TStringField;
    Q011: TOracleDataSet;
    selT013: TOracleDataSet;
    selT013CODICE: TStringField;
    selT013ANNO: TIntegerField;
    selT013MESE: TIntegerField;
    selT013GIORNO: TIntegerField;
    dsrT013: TDataSource;
    CancQ011: TOracleQuery;
    UpdQ011: TOracleQuery;
    GeneraCal: TOracleQuery;
    selTabellaGGLAV: TFloatField;
    Q010IGNORAFESTIVITA: TStringField;
    selTabellaNUMGG_LAV: TIntegerField;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT013BeforePost(DataSet: TDataSet);
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure AfterCancel(DataSet: TDataSet); override;
  private
    VecchioCodiceDizionario:String;
  public
    procedure GeneraCalendario(DaGiorno,AGiorno:TDateTime);
  end;

implementation

uses  WA012UCalendariDettFM, WA012UCalendari, WR100UBase;

{$R *.dfm}

procedure TWA012FCalendariDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE');
  inherited;
  selT013.Open;
end;

procedure TWA012FCalendariDM.AfterCancel(DataSet: TDataSet);
begin
  selT013.CancelUpdates;
  inherited;
end;

procedure TWA012FCalendariDM.AfterPost(DataSet: TDataSet);
var Calend:String;
begin
  inherited;
  Calend:=selTabellaCodice.AsString;
  try
    if selT013.UpdatesPending then
      SessioneOracle.ApplyUpdates([selT013],False);
    SessioneOracle.Commit;
    selT013.CancelUpdates;
  except
    SessioneOracle.Rollback;
  end;
  A000AggiornaFiltroDizionario('CALENDARI',VecchioCodiceDizionario,Calend);
  selTabella.Close;
  selTabella.Open;
  selTabella.Locate('Codice',Calend,[]);
end;

procedure TWA012FCalendariDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  CancQ011.SetVariable('Codice',selTabella['Codice']);
  CancQ011.Execute;
  A000AggiornaFiltroDizionario('CALENDARI',selTabella.FieldByName('Codice').AsString,'');
end;

procedure TWA012FCalendariDM.BeforePostNoStorico(DataSet: TDataSet);
begin
  inherited;
  if DataSet.State in [dsEdit] then
    VecchioCodiceDizionario:=selTabella.FieldByName('Codice').medpOldValue
  else
    VecchioCodiceDizionario:='';
  //Aggiorno codice su T013
  with selT013 do
  try
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('CODICE').AsString:=selTabella.FieldByName('Codice').AsString;
      Post;
      Next;
    end;
    DisableControls;
  finally
    First;
    EnableControls;
  end;
  if (selTabella.State = dsEdit) and (selTabella.FieldByName('Codice').Value <> selTabella.FieldByName('Codice').medpOldValue) then
  begin
    UpdQ011.SetVariable('NewCodice',selTabella.FieldByName('Codice').Value);
    UpdQ011.SetVariable('OldCodice',selTabella.FieldByName('Codice').medpOldValue);
    UpdQ011.Execute;
  end;
end;

procedure TWA012FCalendariDM.selT013BeforePost(DataSet: TDataSet);
var D:TDateTime;
begin
  with DataSet do
  begin
    FieldByName('CODICE').AsString:=selTabellaCODICE.AsString;

    if FieldByName('ANNO').AsInteger > 0 then
      D:=EncodeDate(FieldByName('ANNO').AsInteger,FieldByName('MESE').AsInteger,FieldByName('Giorno').AsInteger)
    else
      D:=EncodeDate(R180Anno(Date),FieldByName('MESE').AsInteger,FieldByName('Giorno').AsInteger);
  end;
end;

procedure TWA012FCalendariDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept:=A000FiltroDizionario('CALENDARI',DataSet.FieldByName('CODICE').AsString);
end;

procedure TWA012FCalendariDM.GeneraCalendario(DaGiorno,AGiorno:TDateTime);
begin
  GeneraCal.SetVariable('DAL',DaGiorno);
  GeneraCal.SetVariable('AL',AGiorno);
  GeneraCal.SetVariable('COD',selTabella.FieldByName('CODICE').AsString);
  GeneraCal.Execute;
  RegistraLog.SettaProprieta('I','T011_CALENDARI',Copy(Name,1,5),nil,True);
  RegistraLog.InserisciDato('GENERAZIONE','',Format('%s %s - %s',[selTabella.FieldByName('CODICE').AsString,DateToStr(DaGiorno),DateToStr(AGiorno)]));
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
  MsgBox.WebMessageDlg('Calendario generato',mtInformation,[mbOk],nil,'');
end;

end.
