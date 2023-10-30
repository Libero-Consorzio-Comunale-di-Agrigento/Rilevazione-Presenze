unit B110UElencoDipendentiDM;
// http://localhost:89/datasnap/rest/TB110FServerMethodsDM/Dipendenti/AZIN/casa/c

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  B110USharedTypes,
  B110USharedUtils,
  B110UUtils,
  C018UIterAutDM,
  C200UWebServicesTypes,
  C200UWebServicesUtils,
  FunzioniGenerali,
  R015UDatasnapRestDM,
  UselI010,
  W000UMessaggi,
  W010URichiestaAssenzeDM,
  System.Math, System.StrUtils, System.SysUtils, System.Classes, System.Variants, UITypes,
  Oracle, OracleData,
  Datasnap.DBClient, Data.DB,
  FireDAC.Comp.Client, Data.FireDACJSONReflect;

type
  TB110FElencoDipendentiDM = class(TR015FDatasnapRestDM)
    selT033Nome: TOracleQuery;
    selAnagrafe: TOracleDataSet;
    cdsI010: TClientDataSet;
  private
    FDataRiferimento: TDateTime;
    procedure SetDataRiferimento(Value: TDateTime);
  protected
    function ControlloParametri: TResCtrl; override;
    procedure Esegui(var RRisultato: TRisultato); override;
  public
    property DataRiferimento: TDateTime write SetDataRiferimento;
  end;

implementation

{$R *.dfm}

{ TB110FElencoDipendentiDM }

procedure TB110FElencoDipendentiDM.SetDataRiferimento(Value: TDateTime);
begin
  if Value = DATE_NULL then
    FDataRiferimento:=Date
  else
    FDataRiferimento:=Value;
end;

function TB110FElencoDipendentiDM.ControlloParametri: TResCtrl;
begin
  //Result.Ok:=False;
  Result.Messaggio:='';

  if FDataRiferimento = DATE_NULL then
  begin
    //Result.Messaggio:='La data di riferimento non è indicata!';
    //Exit;
    FDataRiferimento:=Date;
  end;

  Result.Ok:=True;
end;

procedure TB110FElencoDipendentiDM.Esegui(var RRisultato: TRisultato);
var
  LTable: TFDMemTable;
  LRes: TOutputElencoDipendenti;
  i:Integer;
  selI010: TselI010;
  CampoCaptionLayout:String;
  ElencoCampi:String;
  CampiV430:String;
  FiltroAnagrafe:String;
  FiltroInServizio:String;
  OrdinamUtente:String;
  Ricerca,Posizione:Boolean;
  NomeCampo: String;
  PosizioneNulla: Boolean;
begin
  //Estraggo layout scheda anagrafica attivato per l'utente corrente
  selT033Nome.SetVariable('LAYOUT',Parametri.Layout);
  selT033Nome.SetVariable('OPERATORE',Parametri.Operatore);
  selT033Nome.Execute;
  Parametri.Layout:=VarToStr(selT033Nome.GetVariable('RESULT'));

  //RRisultato.AddInfo('Parametri.Layout:' + Parametri.Layout);

  //Lettura layout in selI010 e cdsI010
  //CampoCaptionLayout:=IfThen(Pos(INI_PAR_CAPTION_LAYOUT,W000ParConfig.ParametriAvanzati) = 0,'NOME_LOGICO','CAPTION_LAYOUT||DECODE(CAMPO_DESCRIZIONE,0,NULL,'' (desc.)'')');
  CampoCaptionLayout:='NOME_LOGICO';
  ElencoCampi:=Format('NOME_CAMPO,DATA_TYPE,DATA_LENGTH,NOME_LOGICO,%s CAPTION_LAYOUT,RICERCA,POSIZIONE,ACCESSO',[CampoCaptionLayout]);
  ElencoCampi:=ElencoCampi + ',NOMEPAGINA,decode(NOMEPAGINA,''Dati Anagrafici'',''0'',''Parametri orario'',''1'',''Presenze/Assenze'',''2'',NOMEPAGINA) NOMEPAGINA_ORD,TOP,LFT';
  selI010:=TselI010.Create(nil);
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,ElencoCampi,'','RICERCA,POSIZIONE,NOME_LOGICO');
  cdsI010.Close;
  cdsI010.FieldDefs.Assign(selI010.FieldDefs);
  cdsI010.CreateDataSet;
  cdsI010.LogChanges:=False;
  cdsI010.IndexDefs.Clear;
  cdsI010.IndexDefs.Add('Visualizzazione',('POSIZIONE;NOME_LOGICO'),[ixPrimary,ixUnique]);
  cdsI010.IndexDefs.Add('Ricerca',('RICERCA;POSIZIONE;NOME_LOGICO'),[ixPrimary,ixUnique]);
  cdsI010.IndexDefs.Add('Layout',('NOMEPAGINA_ORD;TOP;LFT;NOME_LOGICO'),[ixPrimary,ixUnique]);
  CampiV430:='';
  Parametri.ColonneStruttura.Clear;
  Parametri.TipiStruttura.Clear;
  selI010.First;
  while not selI010.Eof do
  begin
    cdsI010.Append;
    for i:=0 to selI010.FieldCount - 1 do
    begin
      Ricerca:=(UpperCase(selI010.Fields[i].FieldName) = 'RICERCA');
      Posizione:=(UpperCase(selI010.Fields[i].FieldName) = 'POSIZIONE');
      // i valori nulli dei campi RICERCA e POSIZIONE sono sostituiti con un valore numerico molto elevato
      if (Ricerca or Posizione) and (selI010.Fields[i].IsNull) then
        cdsI010.Fields[i].Value:=IfThen(Ricerca,RICERCA_NULL,POSIZIONE_NULL)
      else
        // copia del valore nel campo del clientdataset
        cdsI010.Fields[i].Value:=selI010.Fields[i].Value;
    end;
    cdsI010.Post;
    if ((Copy(cdsI010.FieldByName('NOME_CAMPO').AsString,1,4) = 'T430') or
        (Copy(cdsI010.FieldByName('NOME_CAMPO').AsString,1,4) = 'P430')) and
        (cdsI010.FieldByName('ACCESSO').AsString <> 'N') then
      CampiV430:=CampiV430 + 'V430.' + cdsI010.FieldByName('NOME_CAMPO').AsString + ',';

    Parametri.ColonneStruttura.Add(Format('%s=%s',[selI010.FieldByName('NOME_LOGICO').AsString,selI010.FieldByName('NOME_CAMPO').AsString]));
    if selI010.FieldByName('DATA_TYPE').AsString = 'VARCHAR2' then
      Parametri.TipiStruttura.Add(IntToStr(Ord(ftString)))
    else if selI010.FieldByName('DATA_TYPE').AsString = 'NUMBER' then
      Parametri.TipiStruttura.Add(IntToStr(Ord(ftInteger)))
    else if selI010.FieldByName('DATA_TYPE').AsString = 'DATE' then
      Parametri.TipiStruttura.Add(IntToStr(Ord(ftDateTime)));
    selI010.Next;
  end;
  FreeAndNil(selI010);

  if CampiV430 <> '' then
    CampiV430:=',' + Copy(CampiV430,1,Length(CampiV430) - 1);
  if Pos(',V430.T430BADGE,',',' + CampiV430 + ',') = 0 then
    CampiV430:=CampiV430 + ',V430.T430BADGE';
  CampiV430:=CampiV430 + ',' +
    'T100F_TIMB_CORRENTE(T030.PROGRESSIVO) T030PRESENTE, ' +
    'T040F_GIUSTIF_CORRENTE(T030.PROGRESSIVO) T030GIUSTIFICATO, ' +
    'T380F_TURNORG_CORRENTE(T030.PROGRESSIVO) T030REPERIBILE';

  //RRisultato.AddInfo('CampiV430:' + CampiV430);

  //Costruzione selAnagrafe
  selAnagrafe.SQL.Clear;
  selAnagrafe.SQL.Text:=QVistaOracle;
  selAnagrafe.SQL.Insert(0,Format('SELECT %s T030.*,T480.CITTA, T480.PROVINCIA %s FROM',[Parametri.CampiRiferimento.C26_HintT030V430,CampiV430]));
  selAnagrafe.SQL.Add(':FILTRO_IN_SERVIZIO');
  selAnagrafe.SQL.Add(':FILTRO');
  selAnagrafe.DeleteVariables;
  selAnagrafe.DeclareVariable('DATALAVORO',otDate);
  selAnagrafe.DeclareVariable('FILTRO',otSubst);
  selAnagrafe.DeclareVariable('FILTRO_IN_SERVIZIO',otSubst);

  //RRisultato.AddInfo('selAnagrafe.SubstitutedSQL:' + selAnagrafe.SubstitutedSQL);

  // imposta il filtro anagrafe e il filtro per i cessati
  FiltroInServizio:=FILTRO_IN_SERVIZIO;//IfThen(VisualizzaCessati,'',FILTRO_IN_SERVIZIO);
  FiltroAnagrafe:=Parametri.Inibizioni.Text;
  if FiltroAnagrafe <> '' then
  begin
    // IMPORTANTE: se nel filtro vengono usati campi della T030_ANAGRAFICO,
    // viene aggiunto l'alias "T030" per evitare problemi nelle join
    FiltroAnagrafe:=TFunzioniGenerali.InserisciAliasT030(FiltroAnagrafe);
    FiltroAnagrafe:=CRLF + TAG_FILTRO_ANAG_INIZIO + CRLF + FiltroAnagrafe + IfThen(FiltroAnagrafe <> '',CRLF) + TAG_FILTRO_ANAG_FINE + CRLF;
    if (Trim(FiltroAnagrafe) <> '') and (Trim(FiltroAnagrafe) <> TAG_FILTRO_ANAG_INIZIO + CRLF + TAG_FILTRO_ANAG_FINE) then
      FiltroAnagrafe:=' AND ' + FiltroAnagrafe;
    // chiude il dataset anagrafico e imposta le variabili
  end;
  OrdinamUtente:='ORDER BY COGNOME,NOME,MATRICOLA';
  OrdinamUtente:=TFunzioniGenerali.InserisciAliasT030(OrdinamUtente);
  selAnagrafe.Close;
  selAnagrafe.ReadBuffer:=IfThen(Parametri.InibizioneIndividuale,2,100);
  selAnagrafe.SetVariable('DATALAVORO',Parametri.DataLavoro);
  selAnagrafe.SetVariable('FILTRO_IN_SERVIZIO',FiltroInServizio);
  selAnagrafe.SetVariable('FILTRO',Trim(FiltroAnagrafe + ' ' + OrdinamUtente));
  try
    selAnagrafe.Open;
  except
    on E:Exception do
      raise Exception.Create(Format(A000TraduzioneStringhe(A000MSG_W002_ERR_FMT_FILTRO_NON_ASSOCIATO),[Parametri.Operatore,E.Message]));
  end;


  cdsI010.IndexName:='Visualizzazione';
  cdsI010.Filtered:=False;
  cdsI010.First;
  while not cdsI010.Eof do
  begin
    try
      NomeCampo:=cdsI010.FieldByName('NOME_CAMPO').AsString;
      PosizioneNulla:=(cdsI010.FieldByName('POSIZIONE').IsNull) or
                      (cdsI010.FieldByName('ACCESSO').AsString = 'N') or
                      (cdsI010.FieldByName('POSIZIONE').AsInteger = POSIZIONE_NULL);

      if selAnagrafe.FindField(NomeCampo) <> nil then
      begin
        selAnagrafe.FieldByName(NomeCampo).DisplayLabel:=cdsI010.FieldByName('CAPTION_LAYOUT').AsString;
        selAnagrafe.FieldByName(NomeCampo).Index:=IfThen(PosizioneNulla,POSIZIONE_NULL,cdsI010.FieldByName('POSIZIONE').AsInteger);
        selAnagrafe.FieldByName(NomeCampo).Visible:=not PosizioneNulla;
      end;
    except
    end;
    cdsI010.Next;
  end;
  if selAnagrafe.FindField('T430PROGRESSIVO') <> nil then
    selAnagrafe.FieldByName('T430PROGRESSIVO').Visible:=False;
  selAnagrafe.FieldByName('COGNOME').Visible:=True;
  selAnagrafe.FieldByName('NOME').Visible:=True;
  selAnagrafe.FieldByName('MATRICOLA').Visible:=True;
  selAnagrafe.FieldByName('COGNOME').Index:=0;
  selAnagrafe.FieldByName('NOME').Index:=1;
  selAnagrafe.FieldByName('MATRICOLA').Index:=2;
  selAnagrafe.FieldByName('PROGRESSIVO').Visible:=False;
  selAnagrafe.FieldByName('T030PRESENTE').Visible:=False;
  selAnagrafe.FieldByName('T030GIUSTIFICATO').Visible:=False;
  selAnagrafe.FieldByName('T030REPERIBILE').Visible:=False;
  selAnagrafe.FieldByName('T030PRESENTE').Index:=3;
  selAnagrafe.FieldByName('T030GIUSTIFICATO').Index:=4;
  selAnagrafe.FieldByName('T030REPERIBILE').Index:=5;
  selAnagrafe.FieldByName('T030PRESENTE').DisplayLabel:='Timbratura in corso';
  selAnagrafe.FieldByName('T030GIUSTIFICATO').DisplayLabel:='Giustificativo in corso';
  selAnagrafe.FieldByName('T030REPERIBILE').DisplayLabel:='Reperibilità in corso';

  RRisultato.Output:=TOutputElencoDipendenti.Create;
  LRes:=TOutputElencoDipendenti(RRisultato.Output);
  LRes.NumeroDipendenti:=selAnagrafe.RecordCount;
  LRes.DisplayLabels:=selAnagrafe.GetDisplayLabels;
  LRes.VisibleFields:=selAnagrafe.GetVisibleFields;
  LTable:=selAnagrafe.CloneDataset;

  LRes.JSONDatasets:=TFDJSONDataSets.Create;
  TFDJSONDataSetsWriter.ListAdd(LRes.JSONDatasets,LTable);

  //--------------------------------------------------------
  RRisultato.JSONDatasets:=LRes.JSONDatasets;
  RRisultato.MemTable:=LTable;
  //--------------------------------------------------------
end;

end.
