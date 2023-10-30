unit WA007UProfiliOrariDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, A000UCostanti, A000USessione,
  A000UInterfaccia, WR303UGestMasterDetailDM, WR300UBaseDM, DBClient,
  WR302UGestTabellaDM, medpIWMessageDlg, medpIWDBGrid;

type
  TWA007FProfiliOrariDM = class(TWR303FGestMasterDetailDM)
    Q220CODICE: TStringField;
    Q220DECORRENZA: TDateTimeField;
    Q220DECORRENZA_FINE: TDateTimeField;
    Q220DESCRIZIONE: TStringField;
    selTabellaANTICIPOUSCITA: TDateTimeField;
    selTabellaPRITIMSC: TStringField;
    selTabellaSCOSTENTRATA: TStringField;
    selTabellaTIMBNONAPPOGGIATE: TStringField;
    selTabellaRITARDO_ENTRATA: TIntegerField;
    selTabellaIGNORA_TIMBNONINSEQ: TStringField;
    dsrT221: TDataSource;
    selT221: TOracleDataSet;
    selT221Codice: TStringField;
    selT221D_Codice: TStringField;
    selT221Progressivo: TFloatField;
    selT221Lunedi: TStringField;
    selT221Martedi: TStringField;
    selT221Mercoledi: TStringField;
    selT221Giovedi: TStringField;
    selT221Venerdi: TStringField;
    selT221Sabato: TStringField;
    selT221Domenica: TStringField;
    selT221NonLav: TStringField;
    selT221FESTIVO: TStringField;
    selT221DLunedi: TStringField;
    selT221DMartedi: TStringField;
    selT221DMercoledi: TStringField;
    selT221DGiovedi: TStringField;
    selT221DVenerdi: TStringField;
    selT221DSabato: TStringField;
    selT221DDomenica: TStringField;
    selT221DNonLav: TStringField;
    selT221DFestivo: TStringField;
    selT221DECORRENZA: TDateTimeField;
    selT020: TOracleDataSet;
    selT020CODICE: TStringField;
    selT020DESCRIZIONE: TStringField;
    dsrT020: TDataSource;
    OperSQL: TOracleQuery;
    insT221: TOracleQuery;
    selT220CopiaR: TOracleDataSet;
    selT220CopiaW: TOracleDataSet;
    selT221Copia: TOracleDataSet;
    selT221MaxProgr: TOracleDataSet;
    selTabellaPRIORITA_DOM_FEST: TStringField;
    selTabellaPRIORITA_DOM_NONLAV: TStringField;
    selTabellaPESO_SCOSTENTRATA_S: TIntegerField;
    selTabellaPESO_TIMBESTERNE: TIntegerField;
    selTabellaPESO_TIMBNONAPPOGGIATE_S: TIntegerField;
    selTabellaPESO_TIMBNONAPPOGGIATE_N: TIntegerField;
    selTabellaPESO_PRITIMSC_S: TIntegerField;
    selTabellaPESO_PRITIMSC_A: TIntegerField;
    selTabellaPESO_MINANTSCELTA: TIntegerField;
    selTabellaPESO_RITARDO_ENTRATA: TIntegerField;
    selTabellaIGNORA_STACCOPMT: TStringField;
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure AfterPost(DataSet: TDataSet); override;
    procedure BeforePost(DataSet: TDataSet); override;
    procedure selTabellaFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT221NewRecord(DataSet: TDataSet);
    procedure IWUserSessionBaseCreate(Sender: TObject);
   // procedure cds221BeforePost(DataSet: TDataSet);
    procedure selT221AfterPost(DataSet: TDataSet);
    procedure selT221AfterDelete(DataSet: TDataSet);
    procedure AfterDelete(DataSet: TDataSet); override;
  private
    VecchioCodiceDizionario:String;
    storic:Boolean;
    CodiceOld,CodiceNew:String;
    DecorrenzaOld,DecorrenzaNew:TDateTime;
    procedure CambiaCodiceDecorrenza;
  protected
    procedure RelazionaTabelleFiglie; override;
  public
  end;

implementation

uses WA007UProfiliOrariDettFM, WA007UProfiliOrari, WA007UProfiliOrariSettimaneFM;

{$R *.dfm}

procedure TWA007FProfiliOrariDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','ORDER BY CODICE,DECORRENZA');
  selT221.SetVariable('ORDERBY','ORDER BY CODICE,PROGRESSIVO');
  inherited;
  selT221.Open;
  selT020.Open;
  SetTabelleRelazionate([selTabella,selT221]);
end;


procedure TWA007FProfiliOrariDM.selTabellaFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if DataSet = selTabella then
    Accept:=A000FiltroDizionario('PROFILI ORARIO',DataSet.FieldByName('CODICE').AsString)
  else if DataSet = selT020 then
    Accept:=A000FiltroDizionario('MODELLI ORARIO',DataSet.FieldByName('CODICE').AsString);
end;

procedure TWA007FProfiliOrariDM.BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  VecchioCodiceDizionario:=DataSet.FieldByName('CODICE').AsString;
end;

procedure TWA007FProfiliOrariDM.BeforePost(DataSet: TDataSet);
begin
  inherited;

  if DataSet.State = dsEdit then
    VecchioCodiceDizionario:=VarToStr(DataSet.FieldByName('CODICE').medpOldValue)
  else
    VecchioCodiceDizionario:='';
  //Se storicizzo devo riportare i ProfiliSettimanali sul nuovo periodo
  storic:=InterfacciaWR102.StoricizzazioneInCorso and (selT221.RecordCount > 0);
  //Gestione del cambio codice/decorrenza per salvaguardare la foreign key
  CodiceOld:='';
  CodiceNew:='';
  DecorrenzaOld:=DATE_NULL;
  DecorrenzaNew:=DATE_NULL;
  if (selTabella.State = dsEdit) and
     ((selTabella.FieldByName('CODICE').Value <> selTabella.FieldByName('CODICE').medpOldValue) or
      (selTabella.FieldByName('DECORRENZA').Value <> selTabella.FieldByName('DECORRENZA').medpOldValue)) then
  begin
    CodiceOld:=selTabella.FieldByName('CODICE').medpOldValue;
    CodiceNew:=selTabella.FieldByName('CODICE').Value;
    DecorrenzaOld:=selTabella.FieldByName('DECORRENZA').medpOldValue;
    DecorrenzaNew:=selTabella.FieldByName('DECORRENZA').Value;
    selTabella.FieldByName('CODICE').Value:=selTabella.FieldByName('CODICE').medpOldValue;
    selTabella.FieldByName('DECORRENZA').Value:=selTabella.FieldByName('DECORRENZA').medpOldValue;
  end;
end;

procedure TWA007FProfiliOrariDM.AfterDelete(DataSet: TDataSet);
begin
  inherited;
  if DataSet.FieldByName('CODICE').AsString <> VecchioCodiceDizionario then
    A000AggiornaFiltroDizionario('PROFILI ORARIO',VecchioCodiceDizionario,'');
end;

procedure TWA007FProfiliOrariDM.AfterPost(DataSet: TDataSet);
var S:String;
begin
  S:=selTabella.FieldByName('Codice').AsString;
  if storic then
    InterfacciaWR102.OttimizzaStorico:=False;
  if (CodiceOld <> CodiceNew) or (DecorrenzaOld <> DecorrenzaNew) then
    CambiaCodiceDecorrenza;
  try
    inherited;
  finally
    InterfacciaWR102.OttimizzaStorico:=True;
  end;
  A000AggiornaFiltroDizionario('PROFILI ORARIO',VecchioCodiceDizionario,S);
end;

procedure TWA007FProfiliOrariDM.CambiaCodiceDecorrenza;
var i:Integer;
begin
  //Copia di selT220 con nuovo codice/decorrenza
  selT220CopiaW.Close;
  selT220CopiaR.Close;
  selT221Copia.Close;
  selT220CopiaR.SetVariable('CODICE',CodiceOld);
  selT220CopiaR.Open;
  selT220CopiaW.SetVariable('CODICE',CodiceNew);
  selT220CopiaW.Open;
  while not selT220CopiaR.Eof do
  begin
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld = selT220CopiaR.FieldByname('DECORRENZA').AsDateTime) then
    begin
      selT220CopiaW.Append;
      for i:=0 to selT220CopiaR.FieldCount - 1 do
        selT220CopiaW.Fields[i].Value:=selT220CopiaR.Fields[i].Value;
      if CodiceOld <> CodiceNew then
        selT220CopiaW.FieldByName('CODICE').AsString:=CodiceNew;
      if DecorrenzaOld = selT220CopiaR.FieldByname('DECORRENZA').AsDateTime then
        selT220CopiaW.FieldByName('DECORRENZA').AsDateTime:=DecorrenzaNew;
      selT220CopiaW.Post;
    end;
    selT220CopiaR.Next;
  end;
  //Modifica di selT221
  selT221Copia.SetVariable('CODICE',CodiceOld);
  selT221Copia.Open;
  while not selT221Copia.Eof do
  begin
    if (CodiceOld <> CodiceNew) or (DecorrenzaOld = selT221Copia.FieldByname('DECORRENZA').AsDateTime) then
    begin
      selT221Copia.Edit;
      if CodiceOld <> CodiceNew then
        selT221Copia.FieldByname('CODICE').AsString:=CodiceNew;
      if DecorrenzaOld = selT221Copia.FieldByname('DECORRENZA').AsDateTime then
        selT221Copia.FieldByname('DECORRENZA').AsDateTime:=DecorrenzaNew;
      selT221Copia.Post;
    end;
    selT221Copia.Next;
  end;
  //Eliminazione di selT220 originale
  if DecorrenzaOld <> DecorrenzaNew then
    if selT220CopiaR.SearchRecord('DECORRENZA',DecorrenzaOld,[srFromBeginning]) then
      selT220CopiaR.Delete;
  if CodiceOld <> CodiceNew then
  begin
    selT220CopiaR.First;
    while not selT220CopiaR.Eof do
      selT220CopiaR.Delete;
  end;
  selT220CopiaW.CloseAll;
  selT220CopiaR.CloseAll;
  selT221Copia.CloseAll;
  selTabella.Refresh;
  if CodiceOld <> CodiceNew then
    selTabella.SearchRecord('CODICE',CodiceNew,[srFromBeginning]);
  selTabella.SearchRecord('CODICE;DECORRENZA',VarArrayOf([CodiceNew,DecorrenzaNew]),[srFromBeginning]);
end;

   (*
procedure TWA007FProfiliOrariDM.cds221BeforePost(DataSet: TDataSet);
  procedure AssegnaOrarioLunedi(Giorno:String);
  begin
    if cds221.FieldByName(Giorno).AsString = '' then
      cds221.FieldByName(Giorno).AsString:=cds221.FieldByName('LUNEDI').AsString;
  end;
  procedure ControllaOrario(Giorno:String);
  begin
    if ((Giorno = 'NONLAV') or (Giorno = 'FESTIVO')) and (cds221.FieldByName(Giorno).AsString = ':GGST') then
      exit;
    if (cds221.FieldByName(Giorno).AsString <> '') and (not selT020.SearchRecord('CODICE',cds221.FieldByName(Giorno).AsString,[srFromBeginning])) then
      raise Exception.Create('Codice "' + cds221.FieldByName(Giorno).AsString + '" nel giorno ' + Giorno + ' inesistente!');
  end;
begin
  if TWA007FProfiliOrariSettimaneFM(TWA007FProfiliOrari(Self.Owner).DetailFM[0]).grdTabella.medpStatoInterno <> msiNone then
    exit;
  if (cds221.FieldByName('DBG_ROWID').AsString = '*') and (cds221.RecordCount = 1) then
    if (cds221.FieldByName('LUNEDI').AsString <> '') then
    begin
      AssegnaOrarioLunedi('MARTEDI');
      AssegnaOrarioLunedi('MERCOLEDI');
      AssegnaOrarioLunedi('GIOVEDI');
      AssegnaOrarioLunedi('VENERDI');
      AssegnaOrarioLunedi('SABATO');
      AssegnaOrarioLunedi('DOMENICA');
      AssegnaOrarioLunedi('NONLAV');
      AssegnaOrarioLunedi('FESTIVO');
    end;

  ControllaOrario('LUNEDI');
  ControllaOrario('MARTEDI');
  ControllaOrario('MERCOLEDI');
  ControllaOrario('GIOVEDI');
  ControllaOrario('VENERDI');
  ControllaOrario('SABATO');
  ControllaOrario('DOMENICA');
  ControllaOrario('NONLAV');
  ControllaOrario('FESTIVO');
end;
   *)
procedure TWA007FProfiliOrariDM.selT221AfterDelete(DataSet: TDataSet);
begin
  inherited;
  if TWA007FProfiliOrariDettFM(TWA007FProfiliOrari(Self.Owner).WDettaglioFM) <> nil then
    with TWA007FProfiliOrariDettFM(TWA007FProfiliOrari(Self.Owner).WDettaglioFM) do
      lblNumSettimane.Caption:=IntToStr(selT221.RecordCount);
end;

procedure TWA007FProfiliOrariDM.selT221AfterPost(DataSet: TDataSet);
begin
  inherited;
  if TWA007FProfiliOrariDettFM(TWA007FProfiliOrari(Self.Owner).WDettaglioFM) <> nil then
    with TWA007FProfiliOrariDettFM(TWA007FProfiliOrari(Self.Owner).WDettaglioFM) do
      lblNumSettimane.Caption:=IntToStr(selT221.RecordCount);
end;

procedure TWA007FProfiliOrariDM.selT221NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT221MaxProgr.SetVariable('CODICE',selTabella.FieldByName('Codice').AsString);
  selT221MaxProgr.SetVariable('DECORRENZA',selTabella.FieldByName('Decorrenza').AsString);
  selT221MaxProgr.Open;
  if selT221MaxProgr.FieldByName('Max').AsString = '' then
    selT221MaxProgr.FieldByName('Max').AsString := '0';

  DataSet.FieldByName('Codice').AsString:=selTabella.FieldByName('Codice').AsString;
  DataSet.FieldByName('Decorrenza').AsDateTime:=selTabella.FieldByName('Decorrenza').AsDateTime;
  DataSet.FieldByName('Progressivo').AsInteger:=selT221MaxProgr.FieldByName('Max').AsInteger+1;
  selT221MaxProgr.Close;
end;

procedure TWA007FProfiliOrariDM.RelazionaTabelleFiglie;
begin
  if InterfacciaWR102.StoricizzazioneInCorso = False then
  begin
    selT221.DisableControls;
    selT221.Close;
    selT221.SetVariable('Codice',selTabella.FieldByName('Codice').AsString);
    selT221.SetVariable('Decorrenza',selTabella.FieldByName('Decorrenza').AsDateTime);
    selT221.Open;
    selT221.EnableControls;
  end;
end;

end.
