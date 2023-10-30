unit A204UModelliCertificazioneMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, Oracle,
  Math, StrUtils,
  A000USessione, A000UInterfaccia, A000UMessaggi, C180FunzioniGenerali;

type
  TA204FModelliCertificazioneMW = class(TR005FDataModuleMW)
    selT002: TOracleDataSet;
    selT430Colonne: TOracleDataSet;
    procedure selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    selSG235: TOracleDataSet;
    selSG236: TOracleDataSet;
    selSG237: TOracleDataSet;
    procedure selSG235BeforePost;
    procedure selSG236BeforePost;
    procedure selSG237BeforePost;
    procedure selSG236NewRecord(pID: Double);
    procedure selSG237NewRecord(pID: Double; pCat: String);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA204FModelliCertificazioneMW.selSG236NewRecord(pID: Double);
begin
  selSG236.FieldByName('ID').AsFloat:=pID;
end;

procedure TA204FModelliCertificazioneMW.selSG237NewRecord(pID: Double; pCat: String);
begin
  selSG237.FieldByName('ID').AsFloat:=pID;
  selSG237.FieldByName('CATEGORIA').AsString:=pCat;
end;

procedure TA204FModelliCertificazioneMW.selSG235BeforePost;
begin
  with selSG235 do
  begin
  //Codice nullo
  if FieldByName('CODICE').AsString = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A204_ERR_CODICE_MOD_NULLO));
  //Data inizio-fine
  if FieldByName('INIZIO_VALIDITA').AsDateTime > FieldByName('FINE_VALIDITA').AsDateTime then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A204_ERR_PERIODO));
  end;
end;

procedure TA204FModelliCertificazioneMW.selSG236BeforePost;
var
  Q: TOracleQuery;
begin
  //Codice nullo
  if selSG236.FieldByName('CODICE').AsString = '' then
    raise Exception.Create(A000TraduzioneStringhe(A000MSG_A088_ERR_CODICE_CAT_NULLO));
  //Codice già in uso (impedito anche a livello di DB)
  Q:=TOracleQuery.Create(nil);
  try
    Q.Session:=SessioneOracle;
    Q.SQL.Add('select count(*) from SG236_CATEGORIE_CERTIFICAZIONI');
    Q.SQL.Add('where ID = ' + selSG236.FieldByName('ID').AsString +
           ' and CODICE = ''' + selSG236.FieldByName('CODICE').AsString + '''' +
           ' and ROWID <> ''' + selSG236.RowId + '''');
    Q.Execute;
    if Q.FieldAsInteger(0) > 0 then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A204_ERR_CODICE_IN_USO));
  finally
    Q.Free;
  end;
end;

procedure TA204FModelliCertificazioneMW.selSG237BeforePost;
  function Occorrenze(const Substring, Text: string): integer;
  var
    offset: integer;
  begin
    result := 0;
    offset := Pos(Text, Substring);
    while offset <> 0 do
    begin
      inc(result);
      offset := PosEx(Substring, Text, offset + length(Substring));
    end;
  end;

var
  Q: TOracleQuery;
  c: integer;
begin
  with selSG237 do
  begin
    //Codice nullo
    if FieldByName('CODICE').AsString = '' then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_A088_ERR_CODICE_NULLO));

    //Codice già in uso (impedito anche a livello di DB)
    Q:=TOracleQuery.Create(nil);
    try
      Q.Session:=SessioneOracle;
      Q.SQL.Add('select count(*) from SG237_DATI_CERTIFICAZIONI');
      Q.SQL.Add('where ID = ' + FieldByName('ID').AsString +
          ' and CATEGORIA = ''' + FieldByName('CATEGORIA').AsString + '''' +
             ' and CODICE = ''' + FieldByName('CODICE').AsString + '''' +
             ' and ROWID <> ''' + RowId + '''');
      Q.Execute;
      if Q.FieldAsInteger(0) > 0 then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_A204_ERR_CODICE_IN_USO));
    finally
      Q.Free;
    end;

    //Sovrapposizione tra 'valori' - 'dato_anagrafico' - 'query_valore'
    c:=0;
    c:=IfThen(FieldByName('DATO_ANAGRAFICO').AsString <> '', c+1, c);
    if c > 0 then
      c:=IfThen((not R180In(FieldByName('VALORI').AsString,['','C','P'])), c+1, c)
    else
      c:=IfThen(FieldByName('VALORI').AsString <> '', c+1, c);
    if c > 1 then
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A204_ERR_COL_DATO_ANAGRAFICO),
                                    [FieldByName('DATO_ANAGRAFICO').DisplayLabel,
                                    FieldByName('VALORI').DisplayLabel]));
    c:=IfThen(FieldByName('QUERY_VALORE').AsString <> '', c+1, c);
    if c > 1 then
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A204_ERR_COL_VALORI),
                                    [FieldByName('VALORI').DisplayLabel,
                                    FieldByName('DATO_ANAGRAFICO').DisplayLabel,
                                    FieldByName('QUERY_VALORE').DisplayLabel]));
    //URL non valido
    if FieldByName('FORMATO').AsString = 'U' then
      if Occorrenze(FieldByName('VALORI').AsString, ',') <> 1 then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_A204_ERR_URL));

    //Colonne valorizzate non usate per il tipo di dato
    {
    if not (R180CarattereDef(FieldByName('FORMATO').AsString) in ['S','M','U'])  and
       ((FieldByName('VALORI').AsString <> '') or (FieldByName('DATO_ANAGRAFICO').AsString <> '') or (FieldByName('QUERY_VALORE').AsString <> '')) then
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_A204_ERR_COL_VALORI_01),
                                    [FieldByName('VALORI').DisplayLabel,
                                    FieldByName('DATO_ANAGRAFICO').DisplayLabel,
                                    FieldByName('QUERY_VALORE').DisplayLabel]));
    }
  end;
end;

procedure TA204FModelliCertificazioneMW.selT002FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=A000FiltroDizionario('INTERROGAZIONI DI SERVIZIO',DataSet.FieldByName('NOME').AsString);
end;

end.
