unit A083UMsgElaborazioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, Data.DB, OracleData, A000UInterfaccia,
  L021Call, C700USelezioneAnagrafe, Oracle;

type
  TLista = record
    Codice:String;
    Descrizione:String;
  end;

  TA083FMsgElaborazioniMW = class(TR005FDataModuleMW)
    selOutAnagrafe: TOracleDataSet;
    selOutAnagrafeID: TFloatField;
    selOutAnagrafeDATA_MSG: TDateTimeField;
    selOutAnagrafeAZIENDA_MSG: TStringField;
    selOutAnagrafeOPERATORE: TStringField;
    selOutAnagrafeMASCHERA: TStringField;
    selOutAnagrafeTIPO: TStringField;
    selOutAnagrafeMSG: TStringField;
    selOutAnagrafeMATRICOLA: TStringField;
    selOutAnagrafeNOMINATIVO: TStringField;
    selOutPut: TOracleDataSet;
    selOutPutID: TFloatField;
    selOutPutDATA_MSG: TDateTimeField;
    selOutPutAZIENDA: TStringField;
    selOutPutOPERATORE: TStringField;
    selOutPutMASCHERA: TStringField;
    selOutPutTIPO: TStringField;
    selOutPutMSG: TStringField;
    selOutPutMATRICOLA: TStringField;
    selOutPutNOMINATIVO: TStringField;
    selI005Aziende: TOracleDataSet;
    selI005Valori: TOracleDataSet;
    GetDataDaID: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataSetStampa:TOracleDataset;
    sApplicazione,sAziendeChecked,sOperatoriChecked,sMaschereChecked,sOperazioniChecked,sCampiChecked,sTestoMsg,msgID:String;
    bSelAnagrafe,bDettaglioCompleto,bUltimoMov:Boolean;
    DataDa,DataA:TDateTime;
    vetAziende:array of String;
    vetOperazioni:array of TLista;
    vetOperatori:array of String;
    vetMaschere:array of TLista;
    procedure CaricaVetOperatori;
    procedure CaricaVetMaschere;
    procedure Aggiorna;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TA083FMsgElaborazioniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  //Carico vetAziende
  SetLength(vetAziende,0);
  selI005Aziende.Close;
  if Parametri.Azienda <> 'AZIN' then
    selI005Aziende.SetVariable('FILTRO','WHERE I090.AZIENDA = ''' + Parametri.Azienda + '''');
  selI005Aziende.Open;
  selI005Aziende.First;
  while not selI005Aziende.Eof do
  begin
    SetLength(vetAziende,Length(vetAziende)+1);
    vetAziende[High(vetAziende)]:=selI005Aziende.FieldByName('AZIENDA').AsString;
    selI005Aziende.Next;
  end;
  selI005Aziende.Close;
  if Parametri.VersioneOracle < 11 then
  begin
    selI005Valori.SetVariable('HINT','/*+ ordered*/');
    selOutput.SetVariable('HINT','/*+ ordered*/');
    selOutAnagrafe.SetVariable('HINT','/*+ ordered*/');
  end;
  //Carico vetOperazioni
  SetLength(vetOperazioni,3);
  vetOperazioni[0].Codice:='A';
  vetOperazioni[0].Descrizione:='Anomalie';
  vetOperazioni[1].Codice:='I';
  vetOperazioni[1].Descrizione:='Informazioni';
  vetOperazioni[2].Codice:='B';
  vetOperazioni[2].Descrizione:='Riepiloghi bloccati';
  sApplicazione:=Parametri.Applicazione;
end;

procedure TA083FMsgElaborazioniMW.CaricaVetOperatori;
begin
  //Carico vetOperatori
  selI005Valori.Close;
  selI005Valori.SetVariable('SELECT','DISTINCT NVL(NVL(I005.AZIENDA_MSG,I005.AZIENDA),''AZIN'')||''.''||NVL(I005.OPERATORE,''SERVIZI_MONDOEDP'') AS OPERATORE');
  selI005Valori.SetVariable('AZIENDA',sAziendeChecked);
  selI005Valori.Open;
  SetLength(vetOperatori,0);
  selI005Valori.First;
  while Not selI005Valori.Eof do
  begin
    SetLength(vetOperatori,Length(vetOperatori)+1);
    vetOperatori[High(vetOperatori)]:=selI005Valori.FieldByName('OPERATORE').AsString;
    selI005Valori.Next;
  end;
end;

procedure TA083FMsgElaborazioniMW.CaricaVetMaschere;
var i:Integer;
begin
  //Carico vetMaschere
  selI005Valori.Close;
  selI005Valori.SetVariable('SELECT','DISTINCT I005.MASCHERA');
  selI005Valori.SetVariable('AZIENDA',sAziendeChecked);
  selI005Valori.Open;
  SetLength(vetMaschere,0);
  selI005Valori.First;
  while Not selI005Valori.Eof do
  begin
    i:=low(FunzioniDisponibili);
    //Unificazione L021. Considero le maschere win e web (FunzioniDisponibili.S ,FunzioniDisponibili.SW)
    while i <= High(FunzioniDisponibili) do
    begin
      if L021VerificaMaschera(selI005Valori.FieldByName('MASCHERA').AsString,i) and
         L021VerificaApplicazione(sApplicazione,i) then
        Break;
      inc(i);
    end;
    if (i <= High(FunzioniDisponibili)) and
       (L021VerificaMaschera(selI005Valori.FieldByName('MASCHERA').AsString,i)) and
       L021VerificaApplicazione(sApplicazione,i) then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:=selI005Valori.FieldByName('MASCHERA').AsString;
      VetMaschere[High(VetMaschere)].Descrizione:=FunzioniDisponibili[i].N + ' (' + selI005Valori.FieldByName('MASCHERA').AsString + ') ';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B005' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B005';
      VetMaschere[High(VetMaschere)].Descrizione:='Aggiornamento base dati (B005)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B006' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B006';
      VetMaschere[High(VetMaschere)].Descrizione:='Acquisizione automatica timbrature (B006)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B013' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B013';
      VetMaschere[High(VetMaschere)].Descrizione:='Integrazione anagrafica EMK (B013)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B014' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B014';
      VetMaschere[High(VetMaschere)].Descrizione:='Integrazione anagrafica (B014)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B015' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B015';
      VetMaschere[High(VetMaschere)].Descrizione:='Scarico giustificativi (B015)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B019' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B019';
      VetMaschere[High(VetMaschere)].Descrizione:='Schedulatore di stampe (B019)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B023' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B023';
      VetMaschere[High(VetMaschere)].Descrizione:='Cifratura cedolini (B023)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'B021' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='B021';
      VetMaschere[High(VetMaschere)].Descrizione:='Servizi Web REST (B021)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'P007' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='P007';
      VetMaschere[High(VetMaschere)].Descrizione:='Recupero DMA (P007)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'A077COM' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='A077COM';
      VetMaschere[High(VetMaschere)].Descrizione:='A077PCOMServer (A077)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'P077COM' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='P077COM';
      VetMaschere[High(VetMaschere)].Descrizione:='P077PCOMServer (P077)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'W000' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='W000';
      VetMaschere[High(VetMaschere)].Descrizione:='Applicativi WEB (W000)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'W000-IrisWEB' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='W000-IrisWEB';
      VetMaschere[High(VetMaschere)].Descrizione:='IrisWEB (W000)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'W000-IrisCloudRILPRE' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='W000-IrisCloudRILPRE';
      VetMaschere[High(VetMaschere)].Descrizione:='IrisCloudRILPRE (W000)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'W000-IrisCloudPAGHE' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='W000-IrisCloudPAGHE';
      VetMaschere[High(VetMaschere)].Descrizione:='IrisCloudPAGHE (W000)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'W000-IrisCloudSTAGIU' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='W000-IrisCloudSTAGIU';
      VetMaschere[High(VetMaschere)].Descrizione:='IrisCloudSTAGIU (W000)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'X004' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='X004';
      VetMaschere[High(VetMaschere)].Descrizione:='X004 - Integrazione NBS';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'A004WEBSRV' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='A004WEBSRV';
      VetMaschere[High(VetMaschere)].Descrizione:='WebService Giustificativi (A004WEBSRV)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'A025WEBSRV' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='A025WEBSRV';
      VetMaschere[High(VetMaschere)].Descrizione:='WebService Turni (A025WEBSRV)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'A040WEBSRV' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='A040WEBSRV';
      VetMaschere[High(VetMaschere)].Descrizione:='WebService Turni reperibilità (A040WEBSRV)';
    end
    else if selI005Valori.FieldByName('MASCHERA').AsString = 'A176' then
    begin
      SetLength(VetMaschere,Length(VetMaschere) + 1);
      VetMaschere[High(VetMaschere)].Codice:='A176';
      VetMaschere[High(VetMaschere)].Descrizione:='Riepilogo iter autorizzativi (A176)';
    end;
    selI005Valori.Next;
  end;
end;

procedure TA083FMsgElaborazioniMW.Aggiorna;
var SQL,Maschere,FiltroC700:String;
  i:Integer;
begin
  SQL:=' AND NVL(NVL(I006.AZIENDA_MSG,I005.AZIENDA),''AZIN'') IN (' + sAziendeChecked + ')';
  if sOperatoriChecked <> '' then
    SQL:=SQL + #13#10 + ' AND NVL(NVL(I006.AZIENDA_MSG,I005.AZIENDA),''AZIN'')||''.''||NVL(I005.OPERATORE,''SERVIZI_MONDOEDP'') IN (' + sOperatoriChecked + ')';

  Maschere:='';
  for i:=0 to Length(vetMaschere) - 1 do
  begin
    if Maschere <> '' then
      Maschere:=Maschere + ',';
    Maschere:=Maschere + '''' + vetMaschere[i].Codice + '''';
  end;
  //Aggiungo maschere sempre visibili
  if Maschere <> '' then
    Maschere:=Maschere + ',';
  Maschere:=Maschere + '''B005'',';
  Maschere:=Maschere + '''B006'',';
  Maschere:=Maschere + '''B013'',';
  Maschere:=Maschere + '''B014'',';
  Maschere:=Maschere + '''B015'',';
  Maschere:=Maschere + '''B019'',';
  Maschere:=Maschere + '''B021'',';
  Maschere:=Maschere + '''B023'',';
  Maschere:=Maschere + '''P007'',';
  Maschere:=Maschere + '''W000'',';
  Maschere:=Maschere + '''W000-IrisWEB'',';
  Maschere:=Maschere + '''W000-IrisCloudRILPRE'',';
  Maschere:=Maschere + '''W000-IrisCloudPAGHE'',';
  Maschere:=Maschere + '''W000-IrisCloudSTAGIU'',';
  Maschere:=Maschere + '''A077COM'',';
  Maschere:=Maschere + '''P077COM'',';
  Maschere:=Maschere + '''A004WEBSRV'',';
  Maschere:=Maschere + '''A025WEBSRV'',';
  Maschere:=Maschere + '''A040WEBSRV''';
  if sMaschereChecked <> '' then
    SQL:=SQL + #13#10 + ' AND I005.MASCHERA IN (' + sMaschereChecked + ')'
  else
    SQL:=SQL + ' AND I005.MASCHERA IN (' + Maschere +')';

  if sOperazioniChecked <> '' then
    SQL:=SQL + #13#10 + ' AND I006.TIPO IN (' + sOperazioniChecked + ')';

  SQL:=SQL + #13#10 + ' AND TRUNC(I005.DATA) BETWEEN TO_DATE(''' + DateToStr(DataDa) + ''',''DD/MM/YYYY'') AND TO_DATE(''' + DateToStr(DataA) + ''',''DD/MM/YYYY'')';

  if sTestoMsg.Trim <> '' then
    SQL:=SQL + #13#10 + ' AND UPPER(I006.MSG) LIKE ''%' + sTestoMsg.Trim.ToUpper + '%''';

  if bUltimoMov then
  begin
    if msgID = '' then
      msgID:=IntToStr(RegistraMsg.ID);
    SQL:=SQL + ' AND I005.ID = ' + msgID;
  end;
  if bDettaglioCompleto then
  begin
    SQL:='select I005.ID FROM MONDOEDP.I005_MSGINFO I005, MONDOEDP.I006_MSGDATI I006 WHERE I005.ID = I006.ID' + #13#10 + SQL;
    SQL:=Format('and I005.ID in (%s)',[SQL]);
  end;
  if (SelAnagrafe.Active) and bSelAnagrafe then
  begin
    selOutAnagrafe.Close;
    FiltroC700:='';
    if Pos('ORDER BY',SelAnagrafe.SQL.Text) > 0 then
      FiltroC700:=Copy(SelAnagrafe.SQL.Text,Pos('WHERE',SelAnagrafe.SQL.Text)+6,Pos('ORDER BY',SelAnagrafe.SQL.Text)-Pos('WHERE',SelAnagrafe.SQL.Text)-6)
    else
      FiltroC700:=Copy(SelAnagrafe.SQL.Text,Pos('WHERE',SelAnagrafe.SQL.Text)+6);
    if Trim(FiltroC700) <> '' then
      FiltroC700:=' AND ' + FiltroC700;
    selOutAnagrafe.SetVariable('FILTRO',SQL);
    selOutAnagrafe.SetVariable('QVISTAORACLE', QVistaOracle);
    selOutAnagrafe.SetVariable('DATALAVORO', Parametri.DataLavoro);
    selOutAnagrafe.SetVariable('FILTROC700', FiltroC700);
    selOutAnagrafe.Open;
    DataSetStampa:=TOracleDataSet(selOutAnagrafe);
  end
  else
  begin
    selOutPut.Close;
    selOutPut.SetVariable('FILTRO',SQL);
    selOutPut.Open;
    DataSetStampa:=TOracleDataSet(selOutPut);
  end;
end;


end.
