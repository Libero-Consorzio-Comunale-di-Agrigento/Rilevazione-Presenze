unit WA010UProfAsseIndDM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, Oracle, C180FunzioniGenerali,
  A000UInterfaccia, WR302UGestTabellaDM, WR300UBaseDM, DBClient,A000UMessaggi;

type
  TWA010FProfAsseIndDM = class(TWR302FGestTabellaDM)
    D260: TDataSource;
    Q260: TOracleDataSet;
    selT265: TOracleDataSet;
    selSG101: TOracleDataSet;
    selTabellaPROGRESSIVO: TFloatField;
    selTabellaCODRAGGR: TStringField;
    selTabellaUMISURA: TStringField;
    selTabellaCOMPETENZA1: TStringField;
    selTabellaRETRIBUZIONE1: TFloatField;
    selTabellaCOMPETENZA2: TStringField;
    selTabellaRETRIBUZIONE2: TFloatField;
    selTabellaCOMPETENZA3: TStringField;
    selTabellaRETRIBUZIONE3: TFloatField;
    selTabellaCOMPETENZA4: TStringField;
    selTabellaRETRIBUZIONE4: TFloatField;
    selTabellaCOMPETENZA5: TStringField;
    selTabellaRETRIBUZIONE5: TFloatField;
    selTabellaCOMPETENZA6: TStringField;
    selTabellaRETRIBUZIONE6: TFloatField;
    selTabellaAGGIORNABILE: TStringField;
    selTabellaDATARES: TDateTimeField;
    selTabellaDECURTAZIONE: TStringField;
    selTabellaRAPPORTI_UNITI: TStringField;
    selTabellaDAL: TDateTimeField;
    selTabellaAL: TDateTimeField;
    selTabellaNOTE: TStringField;
    selTabellaFAMILIARE_DATANAS: TDateTimeField;
    selTabellaVARIAZ_FERIESOL: TStringField;
    selTabellaD_RAGGRUPPAMENTO: TStringField;
    selTabellaC_FAMILIARE_DATANAS: TDateTimeField;
    procedure IWUserSessionBaseCreate(Sender: TObject);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure OnNewRecord(DataSet: TDataSet); override;
  private
  public
  end;

implementation

uses WA010UProfAsseInd, WA010UProfAsseIndDettFM;

{$R *.dfm}

procedure TWA010FProfAsseIndDM.IWUserSessionBaseCreate(Sender: TObject);
begin
  selTabella.SetVariable('ORDERBY','order by DAL DESC,CODRAGGR');
  inherited;
  Q260.Open;
end;

procedure TWA010FProfAsseIndDM.OnNewRecord(DataSet: TDataSet);
begin
  selTabella.FieldByName('Progressivo').AsInteger:=TWA010FProfAsseInd(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger;
  inherited;
end;

procedure TWA010FProfAsseIndDM.BeforePostNoStorico(DataSet: TDataSet);
var AA,MM,GG:Word;
    Errore:Boolean;
    Msg:String;
  procedure VerificaAnnuale;
  begin
    DecodeDate(selTabella.FieldByName('DAL').AsDateTime,AA,MM,GG);
    if (MM <> 01) or (GG <> 01) then
      Errore:=True;
    DecodeDate(selTabella.FieldByName('AL').AsDateTime,AA,MM,GG);
    if (MM <> 12) or (GG <> 31) then
      Errore:=True;
    if Errore then
    begin
      selTabella.FieldByName('DAL').AsDateTime:=EncodeDate(AA,01,01);
      selTabella.FieldByName('AL').AsDateTime:=EncodeDate(AA,12,31);
      Raise Exception.Create( A000MSG_ERR_RAGGR_INTERO_ANNO);
    end;
  end;
begin
  if selTabella.FieldByName('FAMILIARE_DATANAS').IsNull then
    selTabella.FieldByName('FAMILIARE_DATANAS').AsDateTime:=DATE_NULL;

  //Specificare il familiare di riferimento è possibile solo se si tratta di una variazione
  if (selTabella.FieldByName('FAMILIARE_DATANAS').AsDateTime <> DATE_NULL) and (selTabella.FieldByName('DECURTAZIONE').IsNull) then
    selTabella.FieldByName('FAMILIARE_DATANAS').AsDateTime:=DATE_NULL;

  inherited;

  Errore:=False;
  (*
  if Q260.Lookup('CODICE',selTabella.FieldByName('CODRAGGR').AsString,'CONTASOLARE') = 'S' then
    VerificaAnnuale
  else
  begin
    selT265.Open;
    if selT265.Locate('CODICE',selTabella.FieldByName('CODRAGGR').AsString,[]) then
      VerificaAnnuale;
    selT265.Close;
  end;
  *)
  //Test intersezione periodi profili assenza
  with TOracleQuery.Create(self) do
  begin
    Errore:=False;
    Session:=SessioneOracle;
    SQL.Add('SELECT T263.CODRAGGR, T263.DAL, T263.AL');
    SQL.Add('FROM T263_PROFASSIND T263');
    SQL.Add('WHERE T263.CODRAGGR = :COD_RAGGR');
    SQL.Add('AND :FAMILIARE_DATANAS = T263.FAMILIARE_DATANAS');
    SQL.Add('AND :NEW_DAL <= T263.AL');
    SQL.Add('AND :NEW_AL >= T263.DAL');
    SQL.Add('AND (:IDRIGA IS NULL OR :IDRIGA <> ROWID)');
    SQL.Add('AND T263.PROGRESSIVO = :INPROG');
    SQL.Add('ORDER BY T263.CODRAGGR, T263.DAL, T263.AL');
    DeclareVariable('COD_RAGGR',otString);
    DeclareVariable('FAMILIARE_DATANAS',otDate);
    DeclareVariable('NEW_DAL',otDate);
    DeclareVariable('NEW_AL',otDate);
    DeclareVariable('INPROG',otInteger);
    DeclareVariable('IDRIGA',otString);
    SetVariable('COD_RAGGR',selTabella.FieldByName('CODRAGGR').AsString);
    SetVariable('FAMILIARE_DATANAS',selTabella.FieldByName('FAMILIARE_DATANAS').AsString);
    SetVariable('NEW_DAL',selTabella.FieldByName('DAL').AsDateTime);
    SetVariable('NEW_AL',selTabella.FieldByName('AL').AsDateTime);
    if selTabella.State = dsEdit then
      SetVariable('IDRIGA',selTabella.RowID)
    else
      SetVariable('IDRIGA',null);
    SetVariable('INPROG',selTabella.FieldByName('PROGRESSIVO').AsInteger);
    Execute;
    if RowCount > 0 then
    begin
      Errore:=True;
      Msg:='Il periodo indicato (' + selTabella.FieldByName('DAL').AsString + ' - ' + selTabella.FieldByName('AL').AsString +
           ') si interseca con il periodo ' + FieldAsString(1) + ' - ' + FieldAsString(2) + '.'
    end;
    Free;
  end;
  if Errore then
    Raise Exception.Create(Msg);

  (*
  if QueryPK1.EsisteChiave('T263_PROFASSIND',selTabella.RowId,selTabella.State,['PROGRESSIVO','DAL','CODRAGGR','FAMILIARE_DATANAS'],
      [selTabellaProgressivo.AsString,selTabellaDal.AsString,selTabellaCodRaggr.AsString,selTabellaFamiliare_Datanas.AsString]) then
    raise Exception.Create('Profilo già esistente!');
  *)

  selTabellaCompetenza1.AsString:=StringReplace(selTabellaCompetenza1.AsString,' ','',[rfReplaceAll]);
  selTabellaCompetenza2.AsString:=StringReplace(selTabellaCompetenza2.AsString,' ','',[rfReplaceAll]);
  selTabellaCompetenza3.AsString:=StringReplace(selTabellaCompetenza3.AsString,' ','',[rfReplaceAll]);
  selTabellaCompetenza4.AsString:=StringReplace(selTabellaCompetenza4.AsString,' ','',[rfReplaceAll]);
  selTabellaCompetenza5.AsString:=StringReplace(selTabellaCompetenza5.AsString,' ','',[rfReplaceAll]);
  selTabellaCompetenza6.AsString:=StringReplace(selTabellaCompetenza6.AsString,' ','',[rfReplaceAll]);
  selTabellaDecurtazione.AsString:=StringReplace(selTabellaDecurtazione.AsString,' ','',[rfReplaceAll]);
end;

end.
