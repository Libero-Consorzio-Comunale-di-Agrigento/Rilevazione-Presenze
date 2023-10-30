unit S740URegoleValutazioniMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData, Oracle,
  Data.DB, Variants, C180FunzioniGenerali, StrUtils, USelI010, A000UInterfaccia, A000UMessaggi,
  A000UCostanti, medpBackupOldValue;

type
  TCampi = record
    Ord:Word;
    Nome,
    Desc,
    Default:String;
  end;

  TCampiOpzionali = record
    Ord:Word;
    Desc:String;
    Compila,Stampa:Boolean;
  end;

  TS740FRegoleValutazioniMW = class(TR005FDataModuleMW)
    D010: TDataSource;
    selT450: TOracleDataSet;
    SG742: TOracleDataSet;
    SG742DECORRENZA: TDateTimeField;
    SG742CODREGOLA: TStringField;
    SG742NOME_CAMPO: TStringField;
    SG742DESCRIZIONE: TStringField;
    SG742ETICHETTA: TStringField;
    SG742ORDINE: TFloatField;
    D742: TDataSource;
    delSG742: TOracleQuery;
    insaSG742: TOracleQuery;
    insSG742: TOracleQuery;
    updSG742: TOracleQuery;
    selSG750: TOracleDataSet;
    D750: TDataSource;
    selSG735: TOracleDataSet;
    D735: TDataSource;
    procedure SG742BeforeDelete(DataSet: TDataSet);
    procedure SG742BeforeEdit(DataSet: TDataSet);
    procedure SG742BeforeInsert(DataSet: TDataSet);
    procedure SG742CalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    Fsg741_Funzioni: TOracleDataSet;
    Fsg741_FunzioniOldValues: TmedpBackupOldValue;
    procedure CreazioneSelI010;
  public
    Storicizzato:Boolean;
    selI010:TselI010;
    function ElencoPagine: TElencoValoriCheckList;
    function ElencoCodiciRapporto: TElencoValoriCheckList;
    procedure SG741AfterOpen;
    procedure SG741AfterPost(Decorrenza: TDateTime; Codice: String);
    procedure SG741AfterScroll;
    procedure SG741CalcFields;
    procedure SG741BeforeDelete;
    function ValDateAssegnazione: String;
    function OrdineDateAssegnazione: String;
    function AbilitaValutato: String;
    function ValFirma: String;
    function ValFirma6: String;
    procedure Assegnazioni;
    function ValAnnoObiettivi: String;
    procedure SetCampiOpzionali(sel: Array of Boolean; Campo: String);
    procedure GetPeriodoCorrente;
    property SG741_Funzioni: TOracleDataset read Fsg741_Funzioni write Fsg741_Funzioni;
    property SG741_FunzioniOldValues: TmedpBackupOldValue read Fsg741_FunzioniOldValues write Fsg741_FunzioniOldValues;
    const
      CampiOpzionali:array [0..6] of TCampiOpzionali = (
        (Ord:1; Desc:'Peso % area';               Compila:True;  Stampa:True),
        (Ord:2; Desc:'Punteggio area';            Compila:True;  Stampa:True),
        (Ord:3; Desc:'Peso % elemento';           Compila:True;  Stampa:True),
        (Ord:4; Desc:'Punteggio pesato elemento'; Compila:True;  Stampa:True),
        (Ord:5; Desc:'Giudicabile';               Compila:True;  Stampa:False),
        (Ord:6; Desc:'Presa visione valutato';    Compila:False; Stampa:True),
        (Ord:7; Desc:'Descrizione punteggio';     Compila:True;  Stampa:False)
        );
  end;

const
  OpzioneFirma6: String = '#FIRMA_6#';
  Campi:array [1..60] of TCampi = (
    (Ord:1;  Nome:'ANNO_VALUTAZIONE_C';           Desc:'Anno di valutazione (compilazione)';            Default:'Anno valutazione'),
    (Ord:2;  Nome:'ANNO_VALUTAZIONE_S';           Desc:'Anno di valutazione (stampa)';                  Default:'Anno valutazione'),
    (Ord:3;  Nome:'PERIODO_VALUTAZIONE_S';        Desc:'Periodo di valutazione (stampa)';               Default:'dal #DALdd/mm# al #ALdd/mm#'),
    (Ord:4;  Nome:'VALUTATO_C';                   Desc:'Dipendente valutato (compilazione)';            Default:'Valutato'),
    (Ord:5;  Nome:'VALUTATO_S';                   Desc:'Dipendente valutato (stampa)';                  Default:'Valutato'),
    (Ord:6;  Nome:'VALUTATORE_C';                 Desc:'Valutatore (compilazione)';                     Default:'Valutatore'),
    (Ord:7;  Nome:'VALUTATORE_S';                 Desc:'Valutatore (stampa)';                           Default:'Valutatore'),
    (Ord:8;  Nome:'PUNTEGGIO_FINALE_SCHEDA_C';    Desc:'Punteggio scheda (compilazione)';               Default:'Punteggio scheda'),
    (Ord:9;  Nome:'PUNTEGGIO_FINALE_SCHEDA_S';    Desc:'Punteggio scheda (stampa)';                     Default:'Punteggio scheda'),
    (Ord:10; Nome:'DATO_STAMPA_1_S';              Desc:'Dato anagrafico 1 (stampa)';                    Default:''),
    (Ord:11; Nome:'DATO_STAMPA_2_S';              Desc:'Dato anagrafico 2 (stampa)';                    Default:''),
    (Ord:12; Nome:'DATO_STAMPA_3_S';              Desc:'Dato anagrafico 3 (stampa)';                    Default:''),
    (Ord:13; Nome:'DATO_STAMPA_4_S';              Desc:'Dato anagrafico 4 (stampa)';                    Default:''),
    (Ord:14; Nome:'DATO_STAMPA_5_S';              Desc:'Dato anagrafico 5 (stampa)';                    Default:''),
    (Ord:15; Nome:'DATO_STAMPA_6_S';              Desc:'Dato anagrafico 6 (stampa)';                    Default:''),
    (Ord:16; Nome:'CODICE_AREA_C';                Desc:'Codice area (compilazione)';                    Default:'Cod. area'),
    (Ord:17; Nome:'CODICE_AREA_S';                Desc:'Codice area (stampa)';                          Default:'Codice area'),
    (Ord:18; Nome:'DESCRIZIONE_AREA_C';           Desc:'Descrizione area (compilazione)';               Default:'Descrizione area'),
    (Ord:19; Nome:'DESCRIZIONE_AREA_S';           Desc:'Descrizione area (stampa)';                     Default:'Descrizione area'),
    (Ord:20; Nome:'PESO_AREA_C';                  Desc:'Peso % area (compilazione)';                    Default:'Peso % area'),
    (Ord:21; Nome:'PESO_AREA_S';                  Desc:'Peso % area (stampa)';                          Default:'Peso %'),
    (Ord:22; Nome:'PUNTEGGIO_AREA_C';             Desc:'Punteggio area (compilazione)';                 Default:'Punt. area'),
    (Ord:23; Nome:'PUNTEGGIO_AREA_S';             Desc:'Punteggio area (stampa)';                       Default:'Punteggio'),
    (Ord:24; Nome:'CODICE_ITEM_C';                Desc:'Codice elemento (compilazione)';                Default:'Cod. elem.'),
    (Ord:25; Nome:'CODICE_ITEM_S';                Desc:'Codice elemento (stampa)';                      Default:'Codice elem.'),
    (Ord:26; Nome:'DESCRIZIONE_ITEM_C';           Desc:'Descrizione elemento (compilazione)';           Default:'Descrizione elem.'),
    (Ord:27; Nome:'DESCRIZIONE_ITEM_S';           Desc:'Descrizione elemento (stampa)';                 Default:'Descrizione elemento'),
    (Ord:28; Nome:'ITEM_VALUTABILE_C';            Desc:'Elemento valutabile (compilazione)';            Default:'Valutabile'),
    (Ord:29; Nome:'ITEM_VALUTABILE_S';            Desc:'Elemento valutabile (stampa)';                  Default:'Valutab.'),
    (Ord:30; Nome:'PESO_ITEM_C';                  Desc:'Peso % elemento (compilazione)';                Default:'Peso % elem.'),
    (Ord:31; Nome:'PESO_ITEM_S';                  Desc:'Peso % elemento (stampa)';                      Default:'Peso %'),
    (Ord:32; Nome:'SOGLIA_PUNTEGGIO_ITEM_C';      Desc:'Soglia raggiung. elemento (compilazione)';      Default:'Soglia'),
    (Ord:33; Nome:'SOGLIA_PUNTEGGIO_ITEM_S';      Desc:'Soglia raggiung. elemento (stampa)';            Default:'Soglia'),
    (Ord:34; Nome:'PUNTEGGIO_ITEM_C';             Desc:'Punteggio elemento (compilazione)';             Default:'Punt. elem.'),
    (Ord:35; Nome:'PUNTEGGIO_ITEM_S';             Desc:'Punteggio elemento (stampa)';                   Default:'Punteggio'),
    (Ord:36; Nome:'DESCRIZIONE_PUNTEGGIO_ITEM_C'; Desc:'Descrizione punteggio elemento (compilazione)'; Default:'Descrizione punt. elem.'),
    (Ord:37; Nome:'NOTE_PUNTEGGIO_C';             Desc:'Note punteggio elemento (compilazione)';        Default:'Note punt.'),
    (Ord:38; Nome:'NOTE_PUNTEGGIO_S';             Desc:'Note punteggio elemento (stampa)';              Default:'Note punteggio'),
    (Ord:39; Nome:'PUNTEGGIO_PESATO_ITEM_C';      Desc:'Punteggio pesato elemento (compilazione)';      Default:'Punt. pesato elem.'),
    (Ord:40; Nome:'PUNTEGGIO_PESATO_ITEM_S';      Desc:'Punteggio pesato elemento (stampa)';            Default:'Punt. pes.'),
    (Ord:41; Nome:'VALUTAZIONE_INTERMEDIA_C';     Desc:'Valutazione intermedia (compilazione)';         Default:'Valutazione intermedia'),
    (Ord:42; Nome:'VALUTAZIONE_INTERMEDIA_S';     Desc:'Valutazione intermedia (stampa)';               Default:'Valutazione intermedia'),
    (Ord:43; Nome:'VALUTAZIONI_COMPLESSIVE_C';    Desc:'Valutazioni complessive (compilazione)';        Default:'Valutazioni complessive'),
    (Ord:44; Nome:'VALUTAZIONI_COMPLESSIVE_S';    Desc:'Valutazioni complessive (stampa)';              Default:'Valutazioni complessive'),
    (Ord:45; Nome:'OBIETTIVI_PIANIFICATI_C';      Desc:'Obiettivi pianificati (compilazione)';          Default:'Obiettivi pianificati'),
    (Ord:46; Nome:'OBIETTIVI_PIANIFICATI_S';      Desc:'Obiettivi pianificati (stampa)';                Default:'Obiettivi pianificati'),
    (Ord:47; Nome:'PROPOSTE_FORMATIVE_C';         Desc:'Proposte formative (compilazione)';             Default:'Proposte formative'),
    (Ord:48; Nome:'PROPOSTE_FORMATIVE_S';         Desc:'Proposte formative (stampa)';                   Default:'Proposte formative'),
    (Ord:49; Nome:'COMMENTI_VALUTATO_C';          Desc:'Commenti del valutato (compilazione)';          Default:'Commenti valutato'),
    (Ord:50; Nome:'COMMENTI_VALUTATO_S';          Desc:'Commenti del valutato (stampa)';                Default:'Commenti valutato'),
    (Ord:51; Nome:'NOTE_C';                       Desc:'Note (compilazione)';                           Default:'Note'),
    (Ord:52; Nome:'NOTE_S';                       Desc:'Note (stampa)';                                 Default:'Note'),
    (Ord:53; Nome:'ITEM_PERSONALIZZATO_S';        Desc:'Presenza elemento personalizzato (stampa)';     Default:'Elemento personalizzato'),
    (Ord:54; Nome:'FIRMA_1_S';                    Desc:'Firma 1 (stampa)';                              Default:'VALUTATORE'),
    (Ord:55; Nome:'FIRMA_2_S';                    Desc:'Firma 2 (stampa)';                              Default:'VALUTATO per presa visione'),
    (Ord:56; Nome:'FIRMA_3_S';                    Desc:'Firma 3 (stampa)';                              Default:'DIRETTORE SC/DIP per presa visione'),
    (Ord:57; Nome:'FIRMA_4_S';                    Desc:'Firma 4 (stampa)';                              Default:''),
    (Ord:58; Nome:'FIRMA_5_S';                    Desc:'Firma 5 (stampa)';                              Default:''),
    (Ord:59; Nome:'FIRMA_6_S';                    Desc:'Firma 6 (stampa)';                              Default:''),
    (Ord:60; Nome:'SCAGLIONI_INCENTIVI_S';        Desc:'Scaglioni incentivi (stampa)';                  Default:'Scaglioni incentivi')
    );

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TS740FRegoleValutazioniMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  CreazioneSelI010;
  Fsg741_FunzioniOldValues:=TmedpBackupOldValue.Create(Self);
end;

procedure TS740FRegoleValutazioniMW.SG741AfterOpen;
begin
  Fsg741_FunzioniOldValues.CreaStruttura;
end;

procedure TS740FRegoleValutazioniMW.SG741AfterScroll;
begin
  SG742.Close;
  SG742.SetVariable('DECORRENZA',SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  SG742.SetVariable('CODREGOLA',SG741_Funzioni.FieldByName('CODICE').AsString);
  SG742.Open;
  SG741_FunzioniOldValues.Aggiorna;
end;

procedure TS740FRegoleValutazioniMW.SG741CalcFields;
begin
  SG741_Funzioni.FieldByName('D_TIPOQUOTA_STAMPA').AsString:=VarToStr(selSG735.Lookup('CODICE',SG741_Funzioni.FieldByName('CODTIPOQUOTA_STAMPA').AsString,'DESCRIZIONE'));
  SG741_Funzioni.FieldByName('D_PARPROTOCOLLO').AsString:=VarToStr(selSG750.Lookup('CODICE',SG741_Funzioni.FieldByName('COD_PARPROTOCOLLO').AsString,'DESCRIZIONE'));
end;

procedure TS740FRegoleValutazioniMW.SG742BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  abort;
end;

procedure TS740FRegoleValutazioniMW.SG742BeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if not (SG741_Funzioni.State in [dsInsert,dsEdit]) then
    abort;
end;

procedure TS740FRegoleValutazioniMW.SG742BeforeInsert(DataSet: TDataSet);
begin
  inherited;
  abort;
end;

procedure TS740FRegoleValutazioniMW.SG742CalcFields(DataSet: TDataSet);
var i:Integer;
begin
  inherited;
  for i:=1 to High(Campi) do
    if Campi[i].Nome = SG742.FieldByName('NOME_CAMPO').AsString then
    begin
      SG742.FieldByName('DESCRIZIONE').AsString:=Campi[i].Desc;
      Break;
    end;
end;

procedure TS740FRegoleValutazioniMW.SG741AfterPost(Decorrenza: TDateTime; Codice: String);
var i:Integer;
    Trovato:Boolean;
begin
  //Copio i dati dal record precedente, dopo l'automatismo dell'appiattimento dei record uguali
  if Storicizzato
  and (Decorrenza = SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime)
  and (Codice = SG741_Funzioni.FieldByName('CODICE').AsString) then
  begin
    insaSG742.SetVariable('DECORRENZA_OLD',Decorrenza);
    insaSG742.SetVariable('DECORRENZA_NEW',SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    insaSG742.SetVariable('CODREGOLA',SG741_Funzioni.FieldByName('CODICE').AsString);
    insaSG742.Execute;
    SessioneOracle.Commit;
  end;
  if SG741_Funzioni.RecordCount > 0 then
  begin
    SG742.Close;
    SG742.SetVariable('DECORRENZA',SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime);
    SG742.SetVariable('CODREGOLA',SG741_Funzioni.FieldByName('CODICE').AsString);
    SG742.Open;
    //Inserisco i record mancanti
    for i:=1 to High(Campi) do
      if not SG742.SearchRecord('NOME_CAMPO',Campi[i].Nome,[srFromBeginning]) then
      begin
        insSG742.SetVariable('DECORRENZA',SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime);
        insSG742.SetVariable('CODREGOLA',SG741_Funzioni.FieldByName('CODICE').AsString);
        insSG742.SetVariable('NOME_CAMPO',Campi[i].Nome);
        insSG742.SetVariable('ETICHETTA',Campi[i].Default);
        insSG742.SetVariable('ORDINE',Campi[i].Ord);
        insSG742.Execute;
      end;
    SessioneOracle.Commit;
    //Aggiorno quelli esistenti e cancello quelli obsoleti
    with SG742 do
    begin
      Refresh;
      First;
      while not Eof do
      begin
        Trovato:=False;
        for i:=1 to High(Campi) do
          if Campi[i].Nome = FieldByName('NOME_CAMPO').AsString then
          begin
            Trovato:=True;
            Break;
          end;
        if Trovato then
        begin
          updSG742.SetVariable('DECORRENZA',FieldByName('DECORRENZA').AsDateTime);
          updSG742.SetVariable('CODREGOLA',FieldByName('CODREGOLA').AsString);
          updSG742.SetVariable('NOME_CAMPO',FieldByName('NOME_CAMPO').AsString);
          updSG742.SetVariable('ORDINE',Campi[i].Ord);
          updSG742.Execute;
        end
        else
        begin
          delSG742.SetVariable('DECORRENZA',FieldByName('DECORRENZA').AsDateTime);
          delSG742.SetVariable('CODREGOLA',FieldByName('CODREGOLA').AsString);
          delSG742.SetVariable('NOME_CAMPO',FieldByName('NOME_CAMPO').AsString);
          delSG742.Execute;
        end;
        Next;
      end;
      SessioneOracle.Commit;
      Refresh;
    end;
  end;
end;

procedure TS740FRegoleValutazioniMW.SG741BeforeDelete;
begin
  Storicizzato:=False;
  delSG742.SetVariable('DECORRENZA',SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime);
  delSG742.SetVariable('CODREGOLA',SG741_Funzioni.FieldByName('CODICE').AsString);
  delSG742.SetVariable('NOME_CAMPO',null);
  delSG742.Execute;
end;

function TS740FRegoleValutazioniMW.ValDateAssegnazione: String;
begin
  Result:='';
  if ((SG741_Funzioni.FieldByName('DATA_DA_OBIETTIVI').AsString = '')
     or (SG741_Funzioni.FieldByName('DATA_A_OBIETTIVI').AsString = ''))
  and (SG741_Funzioni.FieldByName('ASSEGN_PREVENTIVA_OBIETTIVI').AsString = 'S') then
    Result:=A000MSG_S740_ERR_DATE_VAL;
end;

function TS740FRegoleValutazioniMW.OrdineDateAssegnazione: String;
begin
  Result:='';
  if SG741_Funzioni.FieldByName('DATA_DA_OBIETTIVI').AsDateTime > SG741_Funzioni.FieldByName('DATA_A_OBIETTIVI').AsDateTime then
    Result:=A000MSG_S740_ERR_DATE_ORDINE;
end;

function TS740FRegoleValutazioniMW.AbilitaValutato: String;
begin
  Result:='';
  if (SG741_Funzioni.FieldByName('ABILITA_ACCETTAZIONE_VALUTATO').AsString = 'N')
  and not R180In(SG741_Funzioni.FieldByName('ABILITA_COMMENTI_VALUTATO').AsString,['1','2']) then
    Result:=A000MSG_S740_ERR_IMPOSTARE_CAMPO;
end;

function TS740FRegoleValutazioniMW.ValFirma: String;
begin
  Result:='';
   if ((SG741_Funzioni.FieldByName('DATO_STAMPA_1').AsString = OpzioneFirma6)
      or (SG741_Funzioni.FieldByName('DATO_STAMPA_2').AsString = OpzioneFirma6)
      or (SG741_Funzioni.FieldByName('DATO_STAMPA_3').AsString = OpzioneFirma6)
      or (SG741_Funzioni.FieldByName('DATO_STAMPA_4').AsString = OpzioneFirma6)
      or (SG741_Funzioni.FieldByName('DATO_STAMPA_5').AsString = OpzioneFirma6)
      or (SG741_Funzioni.FieldByName('DATO_STAMPA_6').AsString = OpzioneFirma6))
      and ((SG742.RecordCount = 0)
      or (Trim(VarToStr(SG742.Lookup('NOME_CAMPO','FIRMA_6_S','ETICHETTA'))) = '')) then
     Result:=A000MSG_S740_ERR_SESTA_FIRMA;
end;

function TS740FRegoleValutazioniMW.ValFirma6: String;
begin
  Result:='';
  if SG741_Funzioni.FieldByName('DATO_VARIAZIONE_VALUTATORE').AsString = OpzioneFirma6 then
    Result:='" non può contenere ' + OpzioneFirma6 + '!';
end;

procedure TS740FRegoleValutazioniMW.Assegnazioni;
begin
  if SG741_Funzioni.FieldByName('ABILITA_AREE_FORMATIVE').AsString = 'N' then
    SG741_Funzioni.FieldByName('AREA_FORMATIVA_OBBLIGATORIA').AsString:='N';
  if SG741_Funzioni.FieldByName('STAMPA_VARIAZIONI_5').AsString = 'S' then
    SG741_Funzioni.FieldByName('DESC_LUNGA_5').AsString:='S';
end;

function TS740FRegoleValutazioniMW.ValAnnoObiettivi;
begin
  Result:='';
  if (((SG741_Funzioni.FieldByName('DATA_DA_OBIETTIVI').AsString <> '') and (R180Anno(SG741_Funzioni.FieldByName('DATA_DA_OBIETTIVI').AsDateTime) <> R180Anno(SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime)))
      or ((SG741_Funzioni.FieldByName('DATA_A_OBIETTIVI').AsString <> '') and (R180Anno(SG741_Funzioni.FieldByName('DATA_A_OBIETTIVI').AsDateTime) <> R180Anno(SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime))))
      and ((SG741_Funzioni.FieldByName('DATA_DA_OBIETTIVI').AsDateTime <> SG741_FunzioniOldValues.FieldByName('DATA_DA_OBIETTIVI').Value)
      or (SG741_Funzioni.FieldByName('DATA_A_OBIETTIVI').AsDateTime <> SG741_FunzioniOldValues.FieldByName('DATA_A_OBIETTIVI').Value)) then
    Result:=A000MSG_S740_ERR_INTERNO_ANNO + IntToStr(R180Anno(SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime)) + '!';
end;

procedure TS740FRegoleValutazioniMW.SetCampiOpzionali(sel: Array of Boolean; Campo: String);
var i:Integer;
    s:String;
begin
  s:='';
  for i:=0 to High(sel) do
    if sel[i] then
      s:=s + IfThen(s <> '',',') + IntToStr(CampiOpzionali[i].Ord);
  SG741_Funzioni.FieldByName(Campo).AsString:=s;
end;

procedure TS740FRegoleValutazioniMW.CreazioneSelI010;
begin
  SelI010:=TselI010.Create(Self);
  selSG735.Open;
  selSG750.Open;
  selI010.Apri(SessioneOracle,Parametri.Layout,Parametri.Applicazione,'NOME_CAMPO,NOME_LOGICO,POSIZIONE','TABLE_NAME NOT IN (''T030_ANAGRAFICO'',''T480_COMUNI'')','NOME_LOGICO');
  selI010.Close;
  selI010.SQL.Insert(0,'SELECT ''' + OpzioneFirma6 + ''' NOME_CAMPO, ''' + OpzioneFirma6 + ''' NOME_LOGICO, 9999 POSIZIONE FROM DUAL UNION ');
  selI010.Open;
  D010.DataSet:=selI010;
  selT450.Open;
end;

function TS740FRegoleValutazioniMW.ElencoCodiciRapporto: TElencoValoriCheckList;
var
  sCodice: string;
begin
  Result:=TElencoValoriChecklist.Create;
  selT450.First;
  while not selT450.Eof do
  begin
    sCodice:=selT450.FieldByName('CODICE').AsString;
    Result.lstCodice.add(sCodice);
    Result.lstDescrizione.Add(Format('%-5s %s',[sCodice,selT450.FieldByName('DESCRIZIONE').AsString]));
    selT450.Next;
  end;
end;

function TS740FRegoleValutazioniMW.ElencoPagine: TElencoValoriCheckList;
var
  sCodice: string;
begin
  Result:=TElencoValoriChecklist.Create;
  sCodice:='P0';
  Result.lstCodice.add(sCodice);
  Result.lstDescrizione.Add(Format('%-2s %s',[sCodice,'Valutazione intermedia']));

  sCodice:='P1';
  Result.lstCodice.add(sCodice);
  Result.lstDescrizione.Add(Format('%-2s %s',[sCodice,'Valutazioni complessive']));

  sCodice:='P2';
  Result.lstCodice.add(sCodice);
  Result.lstDescrizione.Add(Format('%-2s %s',[sCodice,'Obiettivi pianificati']));

  sCodice:='P3';
  Result.lstCodice.add(sCodice);
  Result.lstDescrizione.Add(Format('%-2s %s',[sCodice,'Proposte formative']));

  sCodice:='P4';
  Result.lstCodice.add(sCodice);
  Result.lstDescrizione.Add(Format('%-2s %s',[sCodice,'Commenti valutato']));

  sCodice:='P5';
  Result.lstCodice.add(sCodice);
  Result.lstDescrizione.Add(Format('%-2s %s',[sCodice,'Note']));
end;

procedure TS740FRegoleValutazioniMW.GetPeriodoCorrente;
begin
  while not SG741_Funzioni.Eof do
  begin
    if R180Between(Parametri.DataLavoro,SG741_Funzioni.FieldByName('DECORRENZA').AsDateTime,SG741_Funzioni.FieldByName('DECORRENZA_FINE').AsDateTime) then
      Break;
    SG741_Funzioni.Next;
  end;
end;

procedure TS740FRegoleValutazioniMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(selI010);
end;

end.

