unit C005UDatiAnagraficiDM;

interface

uses
  System.StrUtils, System.SysUtils, System.Classes, Data.DB, Oracle, OracleData,
  A000UInterfaccia, C180FunzioniGenerali, USelI010;

type
  TC005FDatiAnagraficiDM = class(TDataModule)
    QAnagra: TOracleDataSet;
    selDatiCorrenti: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    QI010:TselI010;
  public
    { Public declarations }
    Titolo:String;
    lstDatiAnagrafici:TStringList;
    lstDatiCorrenti:TStringList;
    procedure GetDatiAnagrafici(P:Integer; D:TDateTime);
    procedure GetDatiCorrenti(P:Integer; D:TDateTime);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TC005FDatiAnagraficiDM.DataModuleCreate(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  QI010:=TselI010.Create(Self);
  QI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO','POSIZIONE IS NOT NULL','POSIZIONE,NOME_LOGICO');
  lstDatiAnagrafici:=TStringList.Create;
  lstDatiCorrenti:=TStringList.Create;
end;

procedure TC005FDatiAnagraficiDM.GetDatiAnagrafici(P:Integer; D:TDateTime);
var S,NC:String;
    MaxL:Integer;
    VisProgressivo:Boolean;
begin
  lstDatiAnagrafici.Clear;
  Titolo:='';
  QAnagra.Close;
  QAnagra.SetVariable('Progressivo',P);
  QAnagra.SetVariable('Data',D);
  QAnagra.Open;
  QI010.First;
  MaxL:=Length('PROGRESSIVO');
  while not QI010.Eof do
  begin
    NC:=QI010.FieldByName('NOME_CAMPO').AsString;
    if //(NC = 'PROGRESSIVO') or
       (NC = 'NOME') or
       (NC = 'COMUNENAS') or
       (NC = 'PROVINCIA') or
       (NC = 'CAPNAS') or
       //(NC = 'T430PROGRESSIVO') or
       //(NC = 'P430PROGRESSIVO') or
       (NC = 'T430COMUNE') or
       (NC = 'T430CAP') or
       (NC = 'T430D_PROVINCIA') or
       (Copy(NC,1,6) = 'T430D_') then
    begin
      QI010.Next;
      Continue;
    end;
    if Length(QI010.FieldByName('NOME_LOGICO').AsString) > MaxL then
      MaxL:=Length(QI010.FieldByName('NOME_LOGICO').AsString);
    QI010.Next;
  end;
  //Forzo visualizzazione progressivo come primo elemento
  VisProgressivo:=True;
  S:=Format('%-*s:',[MaxL,'PROGRESSIVO']);
  S:=Format('%s%s',[S,QAnagra.FieldByName('PROGRESSIVO').AsString]);
  lstDatiAnagrafici.Add(S);
  //altri dati da visualizzare
  QI010.First;
  while not QI010.Eof do
  begin
    S:='';
    NC:=QI010.FieldByName('NOME_CAMPO').AsString;
    if //(NC = 'PROGRESSIVO') or
       (NC = 'NOME') or
       (NC = 'COMUNENAS') or
       (NC = 'PROVINCIA') or
       (NC = 'CAPNAS') or
       //(NC = 'T430PROGRESSIVO') or
       //(NC = 'P430PROGRESSIVO') or
       (NC = 'T430COMUNE') or
       (NC = 'T430CAP') or
       (NC = 'T430D_PROVINCIA') or
       (Copy(NC,1,6) = 'T430D_') then
    begin
      QI010.Next;
      Continue;
    end;
    if R180In(NC,['PROGRESSIVO','T430PROGRESSIVO','P430PROGRESSIVO']) then
    begin
      if not VisProgressivo then
        VisProgressivo:=True
      else
      begin
        QI010.Next;
        Continue;
      end;
    end;
    S:=Format('%-*s:',[MaxL,QI010.FieldByName('NOME_LOGICO').AsString]);
    //Cognome nome
    if NC = 'COGNOME' then
    begin
      S:=Format('%s%s %s',[S,QAnagra.FieldByName('COGNOME').AsString,QAnagra.FieldByName('NOME').AsString]);
      Titolo:=Format('%s %s',[QAnagra.FieldByName('COGNOME').AsString,QAnagra.FieldByName('NOME').AsString]);
    end
    //Comune di nascita: Citta Provincia Cap
    else if NC = 'CITTA' then
      S:=Format('%s%s (%s) %s',[S,Trim(QAnagra.FieldByName('CITTA').AsString),QAnagra.FieldByName('PROVINCIA').AsString,QAnagra.FieldByName('CAPNAS').AsString])
    //Comune di residenza: Citta Provincia Cap
    else if NC = 'T430D_COMUNE' then
      S:=Format('%s%s (%s) %s',[S,Trim(QAnagra.FieldByName('T430D_COMUNE').AsString),QAnagra.FieldByName('T430D_PROVINCIA').AsString,QAnagra.FieldByName('T430CAP').AsString])
    //Cusalizzazione straordinario fuori fascia
    else if NC = 'T430CAUSSTRAORD' then
      if QAnagra.FieldByName(NC).AsString = 'O' then
        S:=S + 'Obbligatorio'
      else
        S:=S + 'Facoltativo'
    //Abilitazioni prolungamento orario
    else if (NC = 'T430STRAORDE') or (NC = 'T430STRAORDU') or (NC = 'T430STRAORDEU') or (NC = 'T430STRAORDEU2') then
      if QAnagra.FieldByName(NC).AsString = '0' then
        S:=S + 'Inibito'
      else if QAnagra.FieldByName(NC).AsString = '1' then
        S:=S + 'Causalizzato'
      else
        S:=S + 'Libero'
    //Ore teoriche
    else if NC = 'T430HTEORICHE' then
      if QAnagra.FieldByName(NC).AsString = '0' then
        S:=S + 'Giorn./mens. da gg.lavorativi'
      else if QAnagra.FieldByName(NC).AsString = '1' then
        S:=S + 'Giorn./mens. da tipo orario'
      else if QAnagra.FieldByName(NC).AsString = '2' then
        S:=S + 'Giorn. da tipo orario, mens. da calendario'
      else
        S:=S + 'Giorn./mens. da calendario'
    else if NC = 'T430TGESTIONE' then
      if QAnagra.FieldByName(NC).AsString = '0' then
        S:=S + 'Normale'
      else
        S:=S + 'Turnista'
    else
    begin
      try
        if QAnagra.FindField(NC) <> nil then
          S:=Format('%s%s',[S,QAnagra.FieldByName(NC).AsString]);
      except
      end;
      try
        if QAnagra.FindField('T430D_' + Copy(NC,5,40)) <> nil then
          S:=Format('%s %s',[S,QAnagra.FieldByName('T430D_' + Copy(NC,5,40)).AsString]);
      except
      end;
    end;
    if S <> '' then
      lstDatiAnagrafici.Add(S);
    QI010.Next;
  end;
end;

procedure TC005FDatiAnagraficiDM.GetDatiCorrenti(P: Integer; D: TDateTime);
  function FormattaTimbratura:String;
  var lst:TStringList;
  begin
    Result:='';
    lst:=TStringList.Create;
    try
      lst.CommaText:=selDatiCorrenti.FieldByName('PRESENTE').AsString;
      Result:=lst.Values['ora'];
    finally
      lst.Free;
    end;
  end;
  function FormattaGiustificativo:String;
  var lst:TStringList;
      i:Integer;
  begin
    Result:='';
    lst:=TStringList.Create;
    try
      lst.CommaText:=selDatiCorrenti.FieldByName('GIUSTIFICATO').AsString;
      for i:=0 to lst.Count - 1 do
      begin
        if lst.Names[i] = 'causale' then
          Result:=Result + IfThen(Result <> '',CRLF) + lst.ValueFromIndex[i]
        else
          Result:=Result + ' ' + lst.Names[i] + ' ' + lst.ValueFromIndex[i];
      end;
    finally
      lst.Free;
    end;
  end;
  function FormattaTurnoRG:String;
  var lst:TStringList;
      i:Integer;
  begin
    Result:='';
    lst:=TStringList.Create;
    try
      lst.CommaText:=selDatiCorrenti.FieldByName('REPERIBILE').AsString;
      for i:=0 to lst.Count - 1 do
      begin
        if lst.Names[i] = 'tipologia' then
          Result:=Result + IfThen(Result <> '',CRLF) + R180Capitalize(lst.ValueFromIndex[i])
        else
          Result:=Result + ' ' + lst.Names[i] + ' ' + lst.ValueFromIndex[i];
      end;
    finally
      lst.Free;
    end;
  end;
begin
  lstDatiCorrenti.Clear;
  with selDatiCorrenti do
  try
    Close;
    SetVariable('PROGRESSIVO',P);
    SetVariable('DATA',D);
    Open;
    lstDatiCorrenti.Add('Situazione alle ' + FormatDateTime('hh.nn',Now));
    if FieldByName('PRESENTE').IsNull then
      lstDatiCorrenti.Add('Non presente in servizio')
    else
      lstDatiCorrenti.Add('Presente in servizio dalle ore ' + FormattaTimbratura);
    if FieldByName('GIUSTIFICATO').IsNull then
      lstDatiCorrenti.Add('Giustificativo in corso: nessuno')
    else
      lstDatiCorrenti.Add('Giustificativo in corso: ' + FormattaGiustificativo);
    if not FieldByName('REPERIBILE').IsNull then
      lstDatiCorrenti.Add(FormattaTurnoRG);
  finally
    Close;
  end;
end;

procedure TC005FDatiAnagraficiDM.DataModuleDestroy(Sender: TObject);
begin
  QAnagra.Close;
  FreeAndNil(QI010);
  lstDatiAnagrafici.Free;
  lstDatiCorrenti.Free;
end;

end.
