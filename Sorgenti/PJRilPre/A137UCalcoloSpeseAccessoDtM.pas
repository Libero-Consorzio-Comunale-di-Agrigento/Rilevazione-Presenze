unit A137UCalcoloSpeseAccessoDtM;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, A000UCostanti, A000USessione,A000UInterfaccia, Oracle, OracleData, C700USelezioneAnagrafe,
  RegistrazioneLog, (*Midaslib,*) Crtl, DBClient, Variants,
  DatiBloccati, C180FunzioniGenerali;

type
  TA137FCalcoloSpeseAccessoDtM = class(TDataModule)
    selM010: TOracleDataSet;
    selD010: TDataSource;
    selM010TIPO_MISSIONE: TStringField;
    selM010DESCRIZIONE: TStringField;
    TabellaStampa: TClientDataSet;
    selT100: TOracleDataSet;
    selT430: TOracleDataSet;
    selT361: TOracleDataSet;
    selM041: TOracleDataSet;
    selM042: TOracleDataSet;
    selT480: TOracleDataSet;
    insM040: TOracleQuery;
    selM040: TOracleDataSet;
    selM052: TOracleDataSet;
    insM052: TOracleQuery;
    updM052: TOracleQuery;
    selT275: TOracleDataSet;
    procedure A137FCalcoloSpeseAccessoDtMCreate(Sender: TObject);
    procedure A137FCalcoloSpeseAccessoDtMDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ListaPresenze:TStringList;
    selDatiBloccati:TDatiBloccati;
    procedure CreaTabellaStampa;
    procedure InserisciDipendente(TipCodPart,CodLocPart: String; KmPercorsi: Real);
    procedure RegistraMese(DataComp: TDateTime; TipoTrasferta: String);
  end;

var
  A137FCalcoloSpeseAccessoDtM: TA137FCalcoloSpeseAccessoDtM;

implementation

uses A137UCalcoloSpeseAccesso;

{$R *.DFM}

procedure TA137FCalcoloSpeseAccessoDtM.A137FCalcoloSpeseAccessoDtMCreate(Sender: TObject);
{Preparo le query Mensili}
var i:Integer;
begin
  if not(SessioneOracle.Connected) then
  begin
    Password(Application.Name);
    A000ParamDBOracle(SessioneOracle);
  end;
  SessioneOracle.Preferences.TrimStringFields:=True;
  for i:=0 to Self.ComponentCount - 1 do
    begin
    if Components[i] is TOracleQuery then
      (Components[i] as TOracleQuery).Session:=SessioneOracle;
    if Components[i] is TOracleDataSet then
      (Components[i] as TOracleDataSet).Session:=SessioneOracle;
    end;
  selDatiBloccati:=TDatiBloccati.Create(Self);
  ListaPresenze:=TStringList.Create;
  selM010.Open;
  selM041.Open;
  selM042.Open;
  selT361.Open;
  selT480.Open;
  selT275.Open;
  with selT275 do
    while not Eof do
    begin
      ListaPresenze.Add(Format('%-5s %s',[FieldByName('Codice').AsString,FieldByName('Descrizione').AsString]));
      Next;
    end;
end;

procedure TA137FCalcoloSpeseAccessoDtM.A137FCalcoloSpeseAccessoDtMDestroy(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Self.ComponentCount - 1 do
    if Self.Components[i] is TOracleDataSet then
      (Self.Components[i] as TOracleDataSet).Close;
  SessioneOracle.Preferences.TrimStringFields:=False;
  TabellaStampa.Close;
  ListaPresenze.Free;
  FreeAndNil(selDatiBloccati);
end;

procedure TA137FCalcoloSpeseAccessoDtM.CreaTabellaStampa;
begin
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('Progressivo',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Matricola',ftString,8,False);
  TabellaStampa.FieldDefs.Add('Badge',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('Cognome',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Nome',ftString,50,False);
  TabellaStampa.FieldDefs.Add('Nominativo',ftString,61,False);
  TabellaStampa.FieldDefs.Add('DescLocPartenza',ftString,60,False);
  TabellaStampa.FieldDefs.Add('KmPercorsi',ftFloat,0,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Primario',('Cognome;Nome;Matricola'),[ixUnique]);
  TabellaStampa.IndexName:='Primario';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA137FCalcoloSpeseAccessoDtM.InserisciDipendente(TipCodPart,CodLocPart: String; KmPercorsi: Real);
var
  DescLocPartenza: String;
begin
  if TipCodPart = 'C' then
  begin
    if selT480.SearchRecord('CODICE',VarArrayOf([CodLocPart]),[srFromBeginning]) then
      DescLocPartenza:=selT480.FieldByName('CITTA').AsString;
  end
  else if TipCodPart = 'P' then
  begin
    if selM042.SearchRecord('CODICE',VarArrayOf([CodLocPart]),[srFromBeginning]) then
      DescLocPartenza:=selM042.FieldByName('DESCRIZIONE').AsString;
  end;
  TabellaStampa.Insert;
  TabellaStampa.FieldByName('Progressivo').AsInteger:=C700SelAnagrafe.FieldByName('Progressivo').AsInteger;
  TabellaStampa.FieldByName('Matricola').AsString:=C700SelAnagrafe.FieldByName('Matricola').AsString;
  TabellaStampa.FieldByName('Badge').AsInteger:=C700SelAnagrafe.FieldByName('T430Badge').AsInteger;
  TabellaStampa.FieldByName('Cognome').AsString:=C700SelAnagrafe.FieldByName('Cognome').AsString;
  TabellaStampa.FieldByName('Nome').AsString:=C700SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('Nominativo').AsString:=C700SelAnagrafe.FieldByName('Cognome').AsString+' '+C700SelAnagrafe.FieldByName('Nome').AsString;
  TabellaStampa.FieldByName('DescLocPartenza').AsString:=DescLocPartenza;
  TabellaStampa.FieldByName('KmPercorsi').AsFloat:=KmPercorsi;
  TabellaStampa.Post;
end;

procedure TA137FCalcoloSpeseAccessoDtM.RegistraMese(DataComp: TDateTime; TipoTrasferta: String);
var
  MessaggioAnomalia: String;
  DiffGg: Integer;
begin
  if TabellaStampa.RecordCount = 0 then
    exit;
  TabellaStampa.First;
  with TabellaStampa do
    while not TabellaStampa.Eof do
    begin
      selM040.Close;
      selM040.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
      selM040.SetVariable('MeseScarico',DataComp);
      selM040.SetVariable('MeseCompetenza',R180FineMese(DataComp));
      selM040.SetVariable('TipoRegistrazione',TipoTrasferta);
      selM040.SetVariable('DataDa',DataComp);
      selM040.SetVariable('OraDa','00.00');
      selM040.SetVariable('DataA',R180FineMese(DataComp));
      selM040.SetVariable('OraA','00.00');
      selM040.Open;
      if selM040.RecordCount = 0 then
      begin
        try
          DiffGg:=Trunc(R180FineMese(DataComp)-DataComp);
          //Inserimento testata trasferta
          insM040.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
          insM040.SetVariable('MeseScarico',DataComp);
          insM040.SetVariable('MeseCompetenza',R180FineMese(DataComp));
          insM040.SetVariable('DataDa',DataComp);
          insM040.SetVariable('TipoRegistrazione',TipoTrasferta);
          insM040.SetVariable('DataA',R180FineMese(DataComp));
          insM040.SetVariable('TotaleGg',DiffGg+1);
          insM040.SetVariable('Durata',R180MinutiOre(DiffGg*60*24));
          insM040.SetVariable('OreIndRidottaHG',DiffGg*24);
          insM040.Execute;
        except
          //Registra anomalie su file txt
          MessaggioAnomalia:=Format('%-8s %-40s %10s - ',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString+' '+FieldByName('NOME').AsString,'Fine mese']);
          MessaggioAnomalia:=MessaggioAnomalia+'Impossibile inserire la testata della trasferta perché esiste già un record con Mese scarico '+FormatDateTime('mm/yyyy',DataComp)+' e Data/Ora inizio '+FormatDateTime('dd/mm/yyyy',DataComp)+' 00.00';
          //R180AppendFile(A137FCalcoloSpeseAccesso.PercorsoFileAnomalie,MessaggioAnomalia);
          RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',FieldByName('PROGRESSIVO').AsInteger);
          A137FCalcoloSpeseAccesso.TrovateAnomalie:=True;
          Next;
          Continue;
        end;
      end;
      selM052.Close;
      selM052.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
      selM052.SetVariable('MeseScarico',DataComp);
      selM052.SetVariable('MeseCompetenza',R180FineMese(DataComp));
      selM052.SetVariable('DataDa',DataComp);
      selM052.SetVariable('OraDa','00.00');
      selM052.SetVariable('CodiceIndennitaKm',TipoTrasferta);
      selM052.Open;
      if selM052.RecordCount = 0 then
        try
          //Inserimento indennità chilometrica
          insM052.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
          insM052.SetVariable('MeseScarico',DataComp);
          insM052.SetVariable('MeseCompetenza',R180FineMese(DataComp));
          insM052.SetVariable('DataDa',DataComp);
          insM052.SetVariable('CodiceIndennitaKm',TipoTrasferta);
          insM052.SetVariable('KmPercorsi',FieldByName('KmPercorsi').AsFloat);
          insM052.Execute;
        except
          //Registra anomalie su file txt
          MessaggioAnomalia:=Format('%-8s %-40s %10s - ',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString+' '+FieldByName('NOME').AsString,'Fine mese']);
          MessaggioAnomalia:=MessaggioAnomalia+'Impossibile inserire l''indennità chilometrica';
          //R180AppendFile(A137FCalcoloSpeseAccesso.PercorsoFileAnomalie,MessaggioAnomalia);
          RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',FieldByName('PROGRESSIVO').AsInteger);
          A137FCalcoloSpeseAccesso.TrovateAnomalie:=True;
          Next;
          Continue;
        end
      else
        try
          //Aggiornamento indennità chilometrica
          updM052.SetVariable('Progressivo',FieldByName('PROGRESSIVO').AsInteger);
          updM052.SetVariable('MeseScarico',DataComp);
          updM052.SetVariable('MeseCompetenza',R180FineMese(DataComp));
          updM052.SetVariable('DataDa',DataComp);
          updM052.SetVariable('CodiceIndennitaKm',TipoTrasferta);
          updM052.SetVariable('KmPercorsi',FieldByName('KmPercorsi').AsFloat);
          updM052.Execute;
        except
          //Registra anomalie su file txt
          MessaggioAnomalia:=Format('%-8s %-40s %10s - ',[FieldByName('MATRICOLA').AsString,FieldByName('COGNOME').AsString+' '+FieldByName('NOME').AsString,'Fine mese']);
          MessaggioAnomalia:=MessaggioAnomalia+'Impossibile aggiornare l''indennità chilometrica';
          //R180AppendFile(A137FCalcoloSpeseAccesso.PercorsoFileAnomalie,MessaggioAnomalia);
          RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',FieldByName('PROGRESSIVO').AsInteger);
          A137FCalcoloSpeseAccesso.TrovateAnomalie:=True;
          Next;
          Continue;
        end;
      Next;
    end;
  SessioneOracle.Commit;
end;

end.
