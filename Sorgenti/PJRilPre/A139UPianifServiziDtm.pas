//==============================================================================
//nella procedure "OpenTotAnag" sono presenti T430V_FESTIVO E T430V_GIORNALIERO
//attualmente fissi utilizzati nella form A139FQuadroRiass
//==============================================================================
unit A139UPianifServiziDtm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R004UGESTSTORICODTM, DB, OracleData, Oracle, A000UInterfaccia,
  DBClient, A000UCostanti, A000USessione, C180FunzioniGenerali, C700USelezioneAnagrafe,
  Rp502Pro, R500Lin, Math;

type
  TA139FPianifServiziDtm = class(TR004FGestStoricoDtM)
    selT545: TOracleDataSet;
    DscT545: TDataSource;
    CDtsT545: TClientDataSet;
    DscSuppT545: TDataSource;
    selT540: TOracleDataSet;
    DscT540: TDataSource;
    CDtsT540: TClientDataSet;
    DscSuppT540: TDataSource;
    GetMaxProg: TOracleDataSet;
    selT501: TOracleDataSet;
    selT501PATTUGLIA: TIntegerField;
    selT501DATA: TDateTimeField;
    selT501TIPO: TStringField;
    selT501CODICE: TStringField;
    selT550: TOracleDataSet;
    selT555: TOracleDataSet;
    selT501CodTipo: TStringField;
    selT501DescTipo: TStringField;
    selT501DescApparato: TStringField;
    selT502: TOracleDataSet;
    selT520: TOracleDataSet;
    DscT520: TDataSource;
    InsT520: TOracleQuery;
    CopiaSelT500: TOracleDataSet;
    InsT500: TOracleQuery;
    GetMinProg: TOracleDataSet;
    selAnag: TOracleDataSet;
    selT502_2: TOracleDataSet;
    selT502_2DATA: TDateTimeField;
    selT502_2CAMPO1: TStringField;
    selT502_2CAMPO2: TStringField;
    selCampo1: TOracleDataSet;
    selCampo2: TOracleDataSet;
    selT502_2DescCampo1: TStringField;
    selT502_2DescCampo2: TStringField;
    selT502_2Matricola: TStringField;
    selT502_2Nominativo: TStringField;
    selTotAnag: TOracleDataSet;
    selT520DATA: TDateTimeField;
    selT520TIPO_TURNO: TStringField;
    selT520NOME: TStringField;
    selT520COMANDATO: TStringField;
    TabellaStampa: TClientDataSet;
    selT030T502: TOracleDataSet;
    selT500: TOracleDataSet;
    selT500COMANDATO: TStringField;
    selT500TIPO_TURNO: TStringField;
    selT500SERVIZIO: TStringField;
    selT500DATA: TDateTimeField;
    selT500DALLE: TStringField;
    selT500ALLE: TStringField;
    selT500CAUSALE: TStringField;
    selT500NOTE: TStringField;
    selT500NOTE_SERVIZIO: TStringField;
    selT500PATTUGLIA: TIntegerField;
    selT500DescServizio: TStringField;
    selT500DescTTurno: TStringField;
    selT500C_CAMPO1: TStringField;
    selT500C_CAMPO2: TStringField;
    selT500NOMINATIVO: TStringField;
    selT275: TOracleDataSet;
    selT500DescCausale: TStringField;
    InsT320: TOracleQuery;
    InsT501: TOracleQuery;
    UpdT501_502: TOracleQuery;
    DelT501_T502: TOracleQuery;
    selT500_T502: TOracleDataSet;
    selT021: TOracleDataSet;
    selT011: TOracleDataSet;
    selT502_2PROGRESSIVO: TIntegerField;
    selT502_2PATTUGLIA: TIntegerField;
    selCountT502: TOracleQuery;
    selT500PROGRESSIVI: TStringField;
    selT500APPARATI: TStringField;
    selT550CODICE: TStringField;
    selT550DESCRIZIONE: TStringField;
    selT550COD_APPARATO: TStringField;
    dsrCampo1: TDataSource;
    dsrCampo2: TDataSource;
    selT040: TOracleDataSet;
    dsrT040: TDataSource;
    selT040DATA: TDateTimeField;
    selT040NOMINATIVO: TStringField;
    selT040MATRICOLA: TStringField;
    selT040CAUSALE: TStringField;
    selAssenti: TOracleDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    dsrAssenti: TDataSource;
    selT502Inters: TOracleDataSet;
    selT501Inters: TOracleDataSet;
    selT502_2COMANDATO: TStringField;
    selT545Tutto: TOracleDataSet;
    selT500Aperti: TOracleDataSet;
    selT500STATO: TStringField;
    selT520DESCRIZIONE: TStringField;
    selT500ORDINE: TIntegerField;
    cdsT500: TClientDataSet;
    cdsT501: TClientDataSet;
    cdsT502: TClientDataSet;
    selT530: TOracleDataSet;
    TabellaStampaAss: TClientDataSet;
    selT040Stampa: TOracleDataSet;
    selI070: TOracleDataSet;
    selT503: TOracleDataSet;
    selT500ORDINE_CMD: TIntegerField;
    selT502QuadroRiass: TOracleDataSet;
    selT040GetAss: TOracleDataSet;
    InsT080: TOracleQuery;
    selT430T502: TOracleDataSet;
    updT502: TOracleQuery;
    InsT502: TOracleQuery;
    UpdT040: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DscSuppT545DataChange(Sender: TObject; Field: TField);
    procedure DscSuppT540DataChange(Sender: TObject; Field: TField);
    procedure selT500NewRecord(DataSet: TDataSet);
    procedure selT500CalcFields(DataSet: TDataSet);
    procedure BeforePostNoStorico(DataSet: TDataSet); override;
    procedure selT501NewRecord(DataSet: TDataSet);
    procedure selT502_2NewRecord(DataSet: TDataSet);
    procedure selT502_2BeforePost(DataSet: TDataSet);
    procedure selT500AfterScroll(DataSet: TDataSet);
    procedure BeforeDelete(DataSet: TDataSet); override;
    procedure selT500AfterOpen(DataSet: TDataSet);
    procedure selT500BeforeEdit(DataSet: TDataSet);
    procedure selT500BeforeInsert(DataSet: TDataSet);
    procedure AfterPost(DataSet: TDataSet); override;
    procedure selT500DALLEValidate(Sender: TField);
    procedure selT502_2BeforeInsert(DataSet: TDataSet);
    procedure selT502_2AfterScroll(DataSet: TDataSet);
    procedure selT500AfterCancel(DataSet: TDataSet);
    procedure selT500AfterDelete(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure selT501BeforePost(DataSet: TDataSet);
    procedure selT545FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT502_2BeforeDelete(DataSet: TDataSet);
    procedure CopiaSelT500FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT500SERVIZIOValidate(Sender: TField);
    procedure selT500TIPO_TURNOValidate(Sender: TField);
  private
    { Private declarations }
    m_tab_timbrature_vuoto:t_ttimbraturedipmese;
    m_tab_giustificativi_vuoto:t_tgiustificdipmese;
    DuplicaRiga:Boolean;
    procedure CreaCDSDuplicaRiga;
  public
    { Public declarations }
    ParametriPianServiziRaggr1,ParametriPianServiziRaggr2:String;
    EnabledT500:Boolean;
    StrError:TStringList;
    R502DtM:TR502ProDtM1;
    procedure OpenT500(DataFil:TDateTime = 0);
    procedure OpenT500Aperti;
    procedure OpenT501(NomeDts:String = 'selT500');
    procedure OpenTotAnag;
    procedure OpenAssenti(AssGius,AssNonGius:Boolean);
    procedure OpenT502_2;
    procedure OpenT540;
    procedure OpenT502(Patt:Integer;Data:TDateTime);
    procedure AggDati(DataDec:TDateTime; Anagrafe:Boolean);
    procedure CreaTabellaStampa;
    procedure CreaTabellaStampaAssenze;
    procedure CaricaTabellaStampa(AssGius,AssNonGius:Boolean);
    procedure BloccaCampi(Val:Boolean;Campi:String);
    procedure ControlloAnomaliePattuglia(Patt:Integer;Data:TDateTime);
    function ProgPositivi:Boolean;
    function UnProgPositivo:Boolean;
    function GeneraPattuglia(Data:TDateTime):integer;
    function GeneraProg(Data:TDateTime):Integer;
    function RegistraPattuglia:Boolean;
    function GetTipoGiornoServizio(D:TDateTime):String;
    procedure RinumeraT500;
    function SovrapposizioneT501(Tipo,Codice:String; Data:TDateTime; Dalle,Alle:String; Inserimento:Boolean; RigaID:String):Boolean;
    function SovrapposizioneT502(Prog:Integer; Data:TDateTime; Dalle,Alle:String; Inserimento:Boolean; RigaID:String):Boolean;
    procedure DuplicaRecordCorrente;
    function GetServiziAperti:String;
  end;

var
  A139FPianifServiziDtm: TA139FPianifServiziDtm;

implementation

uses A139UPianifServizi;

{$R *.dfm}

procedure TA139FPianifServiziDtm.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ParametriPianServiziRaggr1:=Parametri.CampiRiferimento.C22_PianServLiv1;
  ParametriPianServiziRaggr2:=Parametri.CampiRiferimento.C22_PianServLiv2;
  InizializzaDataSet(selT500,[evBeforePostNoStorico,
                              evBeforeDelete,
                              evAfterDelete,
                              evAfterPost]);
  StrError:=TStringList.Create;
  DuplicaRiga:=False;
  selT530.Open;
  selT545Tutto.Open;
  selT545.Open;

  OpenT540;

  selT500.FieldByName('C_CAMPO1').DisplayLabel:=UpperCase(Copy(ParametriPianServiziRaggr1,0,1)) + LowerCase(Copy(ParametriPianServiziRaggr1,2,100));
  selT500.FieldByName('C_CAMPO2').DisplayLabel:=UpperCase(Copy(ParametriPianServiziRaggr2,0,1)) + LowerCase(Copy(ParametriPianServiziRaggr2,2,100));
end;

procedure TA139FPianifServiziDtm.OpenT540;
var SQL:String;
begin
  //Apertura tabella T540_servizi
  //Se l'operatore non è in modalità comandato viene applicato il filtro
  //immediatamente sotto
  selT540.Close;
  SQL:='';
  if Not A139FPianifServizi.btnServiziComandati.Down then
  begin
    selI070.SetVariable('AZIENDA',Parametri.Azienda);
    selI070.SetVariable('UTENTE',Parametri.Operatore);
    selI070.Open;
    SQL:='WHERE T540.FILTRO_ANAGRAFE IS NULL';
    if Not selI070.FieldByName('FILTRO_ANAGRAFE').isNull then
      SQL:=SQL + ' OR T540.FILTRO_ANAGRAFE = ''' + selI070.FieldByName('FILTRO_ANAGRAFE').AsString + '''';    
    selT540.SetVariable('WHERE',SQL);
  end
  else
    selT540.SetVariable('WHERE',NULL);
  selT540.Open;
  //--
end;

function TA139FPianifServiziDtM.GetTipoGiornoServizio(D:TDateTime):String;
{Restituisce l'alternanza dei giorni festivi/feriali legati alla pianificazione dei Servizi (FIRENZE_COMUNE)}
var x:Byte;
    Festivo:Boolean;
    DataPrimoFestivo,DataPrimoGiornaliero:TDateTime;
begin
  Result:='';
  try
    if not selT530.Active then
      exit;
    if selT530.RecordCount = 0 then
      exit;
    DataPrimoFestivo:=selT530.FieldByName('DATA_PRIMOGGFES').AsDateTime;
    DataPrimoGiornaliero:=selT530.FieldByName('DATA_PRIMOGGLAV').AsDateTime;
    with selT011 do
    begin
      SetVariable('CODICE',selT530.FieldByName('CALENDARIO').AsString);
      SetVariable('DATA1',Min(DataPrimoFestivo,DataPrimoGiornaliero));
      if D > GetVariable('DATA2') then
      begin
        SetVariable('DATA2',D);
        Close;
      end;
      Open;
      if not SearchRecord('DATA',D,[srFromEnd]) then
        exit;
      if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(D) = 1) then
      begin
        Festivo:=True;
        if SearchRecord('DATA',DataPrimoFestivo,[srFromBeginning]) then
          Result:='F'
        else
          exit;
      end
      else
      begin
        Festivo:=False;
        if SearchRecord('DATA',DataPrimoGiornaliero,[srFromBeginning]) then
          Result:='G'
        else
          exit;
      end;
      x:=0;
      while not Eof do
      begin
        if FieldByName('DATA').AsDateTime > D then
          Break;
        if Festivo then
        begin
          if (FieldByName('FESTIVO').AsString = 'S') or (DayOfWeek(FieldByName('DATA').AsDateTime) = 1) then
          begin
            inc(x);
            if x > selT530.FieldByName('ALTERNANZA_GGFES').AsInteger then
              x:=1;
          end;
        end
        else
        begin
          if (FieldByName('FESTIVO').AsString = 'N') and (DayOfWeek(FieldByName('DATA').AsDateTime) > 1) then
          begin
            inc(x);
            if x > selT530.FieldByName('ALTERNANZA_GGLAV').AsInteger then
              x:=1;
          end;
        end;
        Next;
      end;
      if x > 0 then
        if Result = 'G' then
          Result:=Result + chr(x + 64)
        else
          Result:=Result + IntToStr(x);
    end;
  except
  end;
end;

procedure TA139FPianifServiziDtm.OpenT502(Patt:Integer;Data:TDateTime);
var S:String;
begin
  S:=selT502.SubstitutedSQL;
  (*if selT502.GetVariable('PATTUGLIA') <> Patt then
  begin
    selT502.SetVariable('PATTUGLIA',Patt);
    selT502.Close;
  end;*)
  if selT502.GetVariable('DATA') <> Data then
  begin
    selT502.SetVariable('DATA',Data);
    selT502.Close;
  end;
  selT502.SetVariable('PARAMETRI1',ParametriPianServiziRaggr1);
  selT502.SetVariable('PARAMETRI2',ParametriPianServiziRaggr2);
  C700MergeSelAnagrafe(selT502,False);
  C700MergeSettaPeriodo(selT502,Data,Data);
  if S <> selT502.SubstitutedSQL then
    selT502.Close;
  selT502.Open;
  selT502.Filtered:=False;
  selT502.Filter:='PATTUGLIA = ' + IntToStr(Patt);
  selT502.Filtered:=True;
end;

procedure TA139FPianifServiziDtm.ControlloAnomaliePattuglia(Patt:Integer;Data:TDateTime);
var Str,Str1:String;
begin
  //pattuglie non complete
  Str:='Pattuglia con dipendente non impostato:' + #13#10;
  Str:=Str + '  Data:' + selT500.FieldByName('DATA').AsString + #13#10;
  Str:=Str + '  Servizio:' + VarToStr(selT500.Lookup('PATTUGLIA;DATA',VarArrayOf([Patt,Data]),'DESCSERVIZIO')) + #13#10;
  Str:=Str + '  Dalle:' + VarToStr(selT500.Lookup('PATTUGLIA;DATA',VarArrayOf([Patt,Data]),'DALLE')) + ' Alle:' + VarToStr(selT500.Lookup('PATTUGLIA;DATA',VarArrayOf([Patt,Data]),'ALLE'));
  Str1:='';
  OpenT502(Patt,Data);
  selT502.First;
  while Not selT502.Eof do
  begin
    if selT502.FieldByName('PROGRESSIVO').AsInteger < 0 then
    begin
      if Not selT502.FieldByName('CAMPO1').IsNull then
        Str1:=Str1 + #13#10 + '  ' + ParametriPianServiziRaggr1 + ':' + selT502.FieldByName('CAMPO1').AsString;
      if Not selT502.FieldByName('CAMPO2').IsNull then
        Str1:=Str1 + #13#10 + '  ' + ParametriPianServiziRaggr2 + ':' + selT502.FieldByName('CAMPO2').AsString;
    end;
    selT502.Next;
  end;
  if Str1 <> '' then
  begin
    Str:=Str + Str1;
    if StrError.Count > 0 then
      StrError.Add('');
    StrError.Add(Str);
  end;
  //sovrapposizione dipendenti
  selT502.First;
  while not selT502.Eof do
  begin
    if selT502.FieldByName('PROGRESSIVO').AsInteger > 0 then
      if SovrapposizioneT502(selT502.FieldByName('PROGRESSIVO').AsInteger,
                             selT500.FieldByName('DATA').AsDateTime,
                             selT500.FieldByName('DALLE').AsString,
                             selT500.FieldByName('ALLE').AsString,
                             False,
                             selT502.RowID) then
        with selT502Inters do
        begin
          Str1:='';
          First;
          while not Eof do
          begin
            if Str1 <> '' then
              Str1:=Str1 + #13#10;
            Str1:=Str1 + Format('  %s dalle %s alle %s - Turno:%s - Servizio:%s',[FieldByName('DATA').AsString,FieldByName('DALLE').AsString,FieldByName('ALLE').AsString,FieldByName('TIPO_TURNO').AsString,FieldByName('SERVIZIO').AsString]);
            Next;
          end;
          Str:=Format('Turno:%s - Servizio:%s',[selT500.FieldByName('TIPO_TURNO').AsString,selT500.FieldByName('SERVIZIO').AsString]);
          StrError.Add(Format('%s %s(%s) %s - Dalle %s alle %s:',[
            selT502.FieldByName('COGNOME').AsString,
            selT502.FieldByName('NOME').AsString,
            selT502.FieldByName('MATRICOLA').AsString,
            Str,
            selT500.FieldByName('DALLE').AsString,
            selT500.FieldByName('ALLE').AsString]));
           StrError.Add('  Sovrapposizione con');
           StrError.Add(Str1);
        end;
   selT502.Next;
  end;
  //sovrapposizione apparati
  OpenT501;
  selT501.First;
  while not selT501.Eof do
  begin
    if SovrapposizioneT501(selT501.FieldByName('TIPO').AsString,
                           selT501.FieldByName('CODICE').AsString,
                           selT500.FieldByName('DATA').AsDateTime,
                           selT500.FieldByName('DALLE').AsString,
                           selT500.FieldByName('ALLE').AsString,
                           False,
                           selT501.RowID) then
      with selT501Inters do
      begin
        Str1:='';
        First;
        while not Eof do
        begin
          if Str1 <> '' then
            Str1:=Str1 + #13#10;
          Str1:=Str1 + Format('  %s dalle %s alle %s - Turno:%s - Servizio:%s',[FieldByName('DATA').AsString,FieldByName('DALLE').AsString,FieldByName('ALLE').AsString,FieldByName('TIPO_TURNO').AsString,FieldByName('SERVIZIO').AsString]);
          Next;
        end;
        Str:=Format('Turno:%s - Servizio:%s',[selT500.FieldByName('TIPO_TURNO').AsString,selT500.FieldByName('SERVIZIO').AsString]);
        StrError.Add(Format('Apparato %s %s  %s - Dalle %s alle %s:',[
          selT501.FieldByName('TIPO').AsString,
          selT501.FieldByName('CODICE').AsString,
          Str,
          selT500.FieldByName('DALLE').AsString,
          selT500.FieldByName('ALLE').AsString]));
         StrError.Add('  Sovrapposizione con');
         StrError.Add(Str1);
      end;
   selT501.Next;
  end;
end;

procedure TA139FPianifServiziDtm.CopiaSelT500FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=A139FPianifServizi.btnServiziComandati.Down and (DataSet.FieldByName('COMANDATO').AsString = 'S')
          or
          (not A139FPianifServizi.btnServiziComandati.Down) and (DataSet.FieldByName('COMANDATO').AsString = 'N');
end;

function TA139FPianifServiziDtm.RegistraPattuglia:Boolean;
var Ret:Boolean;
    StrProg,DipOld,ServOld,Orario_Turno:String;
    POld,Dalle1,Dalle2,Alle1,Alle2,Dalle,Alle,NumT:Integer;
  procedure GetNumTurno(Dalle,Alle:Integer);
  var xx,yy:Integer;
  begin
    //Richiamo i conteggi con le timbrature fittizie Dalle..Alle per pianificare l'orario/turno teorico
    with R502DtM do
    begin
      for xx:=Low(m_tab_timbrature) to High(m_tab_timbrature) do
        for yy:=1 to MaxTimbrature do
          m_tab_timbrature[xx,yy]:=m_tab_timbrature_vuoto;
      for xx:=Low(m_tab_giustificativi) to High(m_tab_giustificativi) do
        for yy:=1 to MaxGiustif do
          m_tab_giustificativi[xx,yy]:=m_tab_giustificativi_vuoto;
      with m_tab_timbrature[R180Giorno(selT500.FieldByName('DATA').AsDateTime),1] do
      begin
        toratimb:=EncodeDate(1900,1,1) + EncodeTime(Dalle div 60, Dalle mod 60, 0, 0);
        tversotimb:='E';
        tflagtimb:='O';
        trilevtimb:='';
        tcaustimb:='';
      end;
      if Dalle < Alle then
        with m_tab_timbrature[R180Giorno(selT500.FieldByName('DATA').AsDateTime),2] do
        begin
          toratimb:=EncodeDate(1900,1,1) + EncodeTime(Alle div 60, Alle mod 60, 0, 0);
          tversotimb:='U';
          tflagtimb:='O';
          trilevtimb:='';
          tcaustimb:='';
        end
      else
        with m_tab_timbrature[R180Giorno(selT500.FieldByName('DATA').AsDateTime + 1),1] do
        begin
          toratimb:=EncodeDate(1900,1,1) + EncodeTime(Alle div 60, Alle mod 60, 0, 0);
          tversotimb:='U';
          tflagtimb:='O';
          trilevtimb:='';
          tcaustimb:='';
        end;
      PianificazioneEsterna.Progressivo:=POld;
      PianificazioneEsterna.Data:=selT500.FieldByName('DATA').AsDateTime;
      PianificazioneEsterna.l08_Orario:='';
      PianificazioneEsterna.l08_turno1:=-1;
      Conteggi('Cartellino',POld,selT500.FieldByName('DATA').AsDateTime);
      Orario_Turno:=c_orario;
      NumT:=r_turno1;
    end;
  end;
begin
  //OpenT502(selT500.FieldByName('PATTUGLIA').AsInteger,selT500.FieldByName('DATA').AsDateTime);
  ControlloAnomaliePattuglia(selT500.FieldByName('PATTUGLIA').AsInteger,selT500.FieldByName('DATA').AsDateTime);
  if selT502.RecordCount = 0 then
  begin
    Result:=True;
    Exit;
  end;
  if not selT500.FieldByName('CAUSALE').IsNull then
  begin
    //Registrazione turni di straordinrio sulla Libera Professione
    Ret:=True;
    selT502.First;
    while Not selT502.Eof do
    begin
      InsT320.SetVariable('PROGRESSIVO',selT502.FieldByName('PROGRESSIVO').AsInteger);
      InsT320.SetVariable('DATA',selT502.FieldByName('DATA').AsDateTime);
      InsT320.SetVariable('DALLE',selT500.FieldByName('DALLE').AsString);
      InsT320.SetVariable('ALLE',selT500.FieldByName('ALLE').AsString);
      InsT320.SetVariable('CAUSALE',selT500.FieldByName('CAUSALE').AsString);
      try
        InsT320.Execute;
      except
        Ret:=False;
        Break;
      end;
      selT502.Next;
    end;
  end
  else
  begin
    //PIANIFICA CON MODELLO ORARIO
    Ret:=True;
    selT500_T502.Close;
    selT500_T502.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
    selT502.First;
    StrProg:='';
    while not selT502.Eof do
    begin
      StrProg:=StrProg + selT502.FieldByName('PROGRESSIVO').AsString;
      selT502.Next;
      if not selT502.Eof then
        StrProg:=StrProg + ', ';
    end;
    selT500_T502.SetVariable('PROGRESSIVI',StrProg);
    selT500_T502.Open;
    POld:=0;
    DipOld:='';
    ServOld:='';
    Dalle1:=-1;
    Alle1:=-1;
    Dalle2:=-1;
    Alle2:=-1;
    while True do
    begin
      if selT500_T502.Eof or (POld <> selT500_T502.FieldByName('PROGRESSIVO').AsInteger) then
      begin
        if POld > 0 then
        begin
          if (Dalle1 >= 0) then
          begin
            Dalle:=Dalle1;
            if Dalle1 < Alle1 then
              Alle:=Alle1
            else
              Alle:=Alle1 + 1440;
            if Alle - Dalle < DURATA_TURNO then
              StrError.Add(Format('%s %s - Dalle %s alle %s: ' + #13#10 + '  Turno minore di %s ore',[DipOld,ServOld,R180MinutiOre(Dalle1),R180MinutiOre(Alle1),R180MinutiOre(DURATA_TURNO)]))
            else if Alle - Dalle > DURATA_TURNO then
              StrError.Add(Format('%s %s - Dalle %s alle %s: ' + #13#10 + '  Turno maggiore di %s ore',[DipOld,ServOld,R180MinutiOre(Dalle1),R180MinutiOre(Alle1),R180MinutiOre(DURATA_TURNO)]));
          end;
          if (Dalle2 >= 0) then
          begin
            Dalle:=Dalle2;
            if Dalle2 < Alle2 then
              Alle:=Alle2
            else
              Alle:=Alle2 + 1440;
            if Alle - Dalle < DURATA_TURNO then
              StrError.Add(Format('%s %s - Dalle %s alle %s: ' + #13#10 + '  Turno minore di %s ore',[DipOld,ServOld,R180MinutiOre(Dalle2),R180MinutiOre(Alle2),R180MinutiOre(DURATA_TURNO)]))
            else if Alle - Dalle > DURATA_TURNO then
              StrError.Add(Format('%s %s - Dalle %s alle %s: ' + #13#10 + '  Turno maggiore di %s ore',[DipOld,ServOld,R180MinutiOre(Dalle2),R180MinutiOre(Alle2),R180MinutiOre(DURATA_TURNO)]));
          end;
          Orario_Turno:='P1';
          NumT:=-1;
          GetNumTurno(Dalle1,Alle1);
          InsT080.SetVariable('TURNO1',null);
          InsT080.SetVariable('TURNO2',null);
          InsT080.SetVariable('TURNO1EU',null);
          InsT080.SetVariable('TURNO2EU',null);
          InsT080.SetVariable('PROGRESSIVO',POld);
          InsT080.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
          InsT080.SetVariable('ORARIO',Orario_Turno);
          if NumT > 0 then
          begin
            InsT080.SetVariable('TURNO1',NumT);
            if Dalle1 >= Alle1 then
              InsT080.SetVariable('TURNO1EU','U');
          end;
          if Dalle2 >= 0 then
          begin
            NumT:=-1;
            GetNumTurno(Dalle2,Alle2);
            if NumT > 0 then
            begin
              InsT080.SetVariable('TURNO2',NumT);
              if Dalle2 >= Alle2 then
                InsT080.SetVariable('TURNO2EU','U');
            end;
          end;
          try
            InsT080.Execute;
          except
            Ret:=False;
            Break;
          end;
        end;
        if not selT500_T502.Eof then
        begin
          POld:=selT500_T502.FieldByName('PROGRESSIVO').AsInteger;
          Dalle1:=R180OreMinutiExt(selT500_T502.FieldByName('DALLE').AsString);
          Alle1:=R180OreMinutiExt(selT500_T502.FieldByName('ALLE').AsString);
          Dalle2:=-1;
          Alle2:=-1;
          DipOld:=selT500_T502.FieldByName('NOMINATIVO').AsString + '(' + selT500_T502.FieldByName('MATRICOLA').AsString + ')';
          ServOld:=Format('Turno:%s - Servizio:%s',[selT500_T502.FieldByName('TIPO_TURNO').AsString,selT500_T502.FieldByName('SERVIZIO').AsString]);
        end
        else
          Break;
      end
      else
      begin
        if R180OreMinutiExt(selT500_T502.FieldByName('DALLE').AsString) = Alle1 then
        begin
          if Alle1 - Dalle1 < DURATA_TURNO then
            Alle1:=R180OreMinutiExt(selT500_T502.FieldByName('ALLE').AsString)
          else
          begin
            Dalle2:=R180OreMinutiExt(selT500_T502.FieldByName('DALLE').AsString);
            Alle2:=R180OreMinutiExt(selT500_T502.FieldByName('ALLE').AsString);
          end;
        end
        else
        begin
          Dalle2:=R180OreMinutiExt(selT500_T502.FieldByName('DALLE').AsString);
          Alle2:=R180OreMinutiExt(selT500_T502.FieldByName('ALLE').AsString);
        end;
      end;
      selT500_T502.Next;
    end;
  end;
  if Ret then
    SessioneOracle.Commit
  else
    SessioneOracle.Rollback;
  Result:=Ret;
end;

procedure TA139FPianifServiziDtm.BloccaCampi(Val:Boolean;Campi:String);
var i:Integer;
begin
  selT500.DisableControls;
  Campi:=',' + UpperCase(Campi) + ',';
  for i:=0 to selT500.FieldCount - 1 do
    if pos(',' + selT500.Fields[i].FieldName + ',',Campi) > 0 then
      selT500.Fields[i].ReadOnly:=Not Val
    else
      selT500.Fields[i].ReadOnly:=Val;
  selT500.EnableControls;
end;

procedure TA139FPianifServiziDtm.CreaTabellaStampa;
begin
  if TabellaStampa.Active then
    TabellaStampa.EmptyDataSet;
  TabellaStampa.Close;
  TabellaStampa.FieldDefs.Clear;
  TabellaStampa.FieldDefs.Add('PATTUGLIA',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('ORDINE',ftInteger,0,False);
  TabellaStampa.FieldDefs.Add('DATA',ftDateTime,0,False);
  TabellaStampa.FieldDefs.Add('STATO',ftString,1,False);
  TabellaStampa.FieldDefs.Add('DALLE_ALLE',ftString,13,False);
  TabellaStampa.FieldDefs.Add('COD_TIPO_TURNO',ftString,40,False);
  TabellaStampa.FieldDefs.Add('TIPO_TURNO',ftString,40,False);
  TabellaStampa.FieldDefs.Add('SERVIZIO',ftString,80,False);
  TabellaStampa.FieldDefs.Add('COMANDATO',ftString,1,False);
  TabellaStampa.FieldDefs.Add('NOTE_SERVIZIO',ftString,2000,False);
  TabellaStampa.FieldDefs.Add('CAUSALE',ftString,5,False);
  TabellaStampa.FieldDefs.Add('CAMPO1',ftString,400,False);
  TabellaStampa.FieldDefs.Add('CAMPO2',ftString,400,False);
  TabellaStampa.FieldDefs.Add('CAMPO1_GROUP',ftString,100,False);
  TabellaStampa.FieldDefs.Add('NOMINATIVO',ftString,400,False);
  TabellaStampa.FieldDefs.Add('APPARATI',ftString,400,False);
  TabellaStampa.IndexDefs.Clear;
  TabellaStampa.IndexDefs.Add('Idx1',('DATA;COD_TIPO_TURNO;DALLE_ALLE;SERVIZIO;PATTUGLIA'),[]);
  TabellaStampa.IndexDefs.Add('Idx2',('DATA;ORDINE;COD_TIPO_TURNO;DALLE_ALLE;SERVIZIO;PATTUGLIA'),[]);
  TabellaStampa.IndexDefs.Add('Idx3',('DATA;COD_TIPO_TURNO;CAMPO1_GROUP;DALLE_ALLE;SERVIZIO;PATTUGLIA'),[]);
  TabellaStampa.IndexDefs.Add('Idx4',('DATA;ORDINE;COD_TIPO_TURNO;CAMPO1_GROUP;DALLE_ALLE;SERVIZIO;PATTUGLIA'),[]);
  TabellaStampa.IndexName:='Idx1';
  TabellaStampa.CreateDataSet;
  TabellaStampa.LogChanges:=False;
end;

procedure TA139FPianifServiziDtm.CreaTabellaStampaAssenze;
begin
  if TabellaStampaAss.Active then
    TabellaStampaAss.EmptyDataSet;
  TabellaStampaAss.Close;
  TabellaStampaAss.FieldDefs.Clear;
  TabellaStampaAss.FieldDefs.Add('NOMINATIVO',ftString,50,False);
  TabellaStampaAss.FieldDefs.Add('DATA',ftDateTime,0,False);
  TabellaStampaAss.FieldDefs.Add('PATTUGLIA',ftInteger,0,False);
  TabellaStampaAss.FieldDefs.Add('CAUSALE',ftString,5,False);
  TabellaStampaAss.FieldDefs.Add('CAUSDESC',ftString,40,False);
  TabellaStampaAss.FieldDefs.Add('DALLEALLE',ftString,40,False);
  TabellaStampaAss.CreateDataSet;
  TabellaStampaAss.LogChanges:=False;
end;

procedure TA139FPianifServiziDtm.CaricaTabellaStampa(AssGius,AssNonGius:Boolean);
var ProgPrev, TempString:String;
begin
  try
    OpenT500;
    Screen.Cursor:=crHourGlass;
    selT500.DisableControls;
    selT500.AfterScroll:=nil;
    while not selT500.Eof do
    begin
      selT040Stampa.Close;
      selT040Stampa.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').AsInteger);
      selT040Stampa.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
      selT040Stampa.Open;
      ProgPrev:='NULL';
      while Not selT040Stampa.Eof do
      begin
        TabellaStampaAss.Append;
        if selT040Stampa.FieldByName('PROGRESSIVO').AsString <> ProgPrev then
        begin
          TempString:=selT040Stampa.FieldByName('COGNOME').AsString + ' ' + selT040Stampa.FieldByName('NOME').AsString;
          TempString:=TempString + ' (' + selT040Stampa.FieldByName('MATRICOLA').AsString + ')';
          TabellaStampaAss.FieldByName('NOMINATIVO').AsString:=TempString;
        end;
        ProgPrev:=selT040Stampa.FieldByName('PROGRESSIVO').AsString;
        TabellaStampaAss.FieldByName('PATTUGLIA').AsInteger:=selT500.FieldByName('PATTUGLIA').AsInteger;
        TabellaStampaAss.FieldByName('CAUSDESC').AsString:=selT040Stampa.FieldByName('DESCRIZIONE').AsString;
        TempString:=FormatDateTime('hh.nn',selT040Stampa.FieldByName('DAORE').AsDateTime) + ' - ' + FormatDateTime('hh.nn',selT040Stampa.FieldByName('AORE').AsDateTime);;
        TabellaStampaAss.FieldByName('DALLEALLE').AsString:=TempString;
        TabellaStampaAss.FieldByName('DATA').AsDateTime:=selT040Stampa.FieldByName('DATA').AsDateTime;
        TabellaStampaAss.FieldByName('CAUSALE').AsString:=selT040Stampa.FieldByName('CAUSALE').AsString;
        TabellaStampaAss.Post;
        selT040Stampa.Next;
      end;
      TabellaStampa.Append;
      TabellaStampa.FieldByName('PATTUGLIA').AsInteger:=selT500.FieldByName('PATTUGLIA').AsInteger;
      TabellaStampa.FieldByName('ORDINE').AsInteger:=selT500.FieldByName(A139FPianifServizi.Ordinamento).AsInteger;
      TabellaStampa.FieldByName('STATO').AsString:=selT500.FieldByName('STATO').AsString;
      TabellaStampa.FieldByName('DATA').AsDateTime:=selT500.FieldByName('DATA').AsDateTime;
      TabellaStampa.FieldByName('DALLE_ALLE').AsString:=selT500.FieldByName('DALLE').AsString + ' - '  + selT500.FieldByName('ALLE').AsString;
      TabellaStampa.FieldByName('COD_TIPO_TURNO').AsString:=selT500.FieldByName('TIPO_TURNO').AsString;
      TabellaStampa.FieldByName('TIPO_TURNO').AsString:=selT500.FieldByName('DESCTTURNO').AsString;
      TabellaStampa.FieldByName('SERVIZIO').AsString:=selT500.FieldByName('DESCSERVIZIO').AsString;
      TabellaStampa.FieldByName('NOTE_SERVIZIO').AsString:=Trim(selT500.FieldByName('NOTE_SERVIZIO').AsString);
      TabellaStampa.FieldByName('CAUSALE').AsString:=selT500.FieldByName('CAUSALE').AsString;
      TabellaStampa.FieldByName('COMANDATO').AsString:=selT500.FieldByName('COMANDATO').AsString;
      TabellaStampa.FieldByName('CAMPO1').AsString:=selT500.FieldByName('C_CAMPO1').AsString;
      TabellaStampa.FieldByName('CAMPO2').AsString:=selT500.FieldByName('C_CAMPO2').AsString;
      if Pos(#13,selT500.FieldByName('C_CAMPO1').AsString) > 0 then
        TabellaStampa.FieldByName('CAMPO1_GROUP').AsString:=Copy(selT500.FieldByName('C_CAMPO1').AsString,1,Pos(#13,selT500.FieldByName('C_CAMPO1').AsString))
      else
        TabellaStampa.FieldByName('CAMPO1_GROUP').AsString:=selT500.FieldByName('C_CAMPO1').AsString;
      TabellaStampa.FieldByName('NOMINATIVO').AsString:=selT500.FieldByName('NOMINATIVO').AsString;
      TabellaStampa.FieldByName('APPARATI').AsString:=selT500.FieldByName('APPARATI').AsString;
      TabellaStampa.Post;
      selT500.Next;
    end;
  finally
    selT500.EnableControls;
    selT500.First;
    selT500.AfterScroll:=selT500AfterScroll;
    selT500AfterScroll(nil);
    Screen.Cursor:=crDefault;
  end;
  //Assenti giustificati
  if AssGius then
  begin
    OpenAssenti(True,False);
    with selT040 do
    try
      DisableControls;
      Screen.Cursor:=crHourGlass;
      First;
      while not Eof do
      begin
        TabellaStampa.Append;
        TabellaStampa.FieldByName('DATA').AsDateTime:=selT040.FieldByName('DATA').AsDateTime;
        TabellaStampa.FieldByName('PATTUGLIA').AsFloat:=selT040.RecNo;
        TabellaStampa.FieldByName('COD_TIPO_TURNO').AsString:='zzz1AssentiGiutificati';
        TabellaStampa.FieldByName('TIPO_TURNO').AsString:='Assenti giustificati';
        TabellaStampa.FieldByName('SERVIZIO').AsString:='Assente giustificato';
        TabellaStampa.FieldByName('NOTE_SERVIZIO').AsString:='';
        TabellaStampa.FieldByName('NOMINATIVO').AsString:=Format('%s(%s)',[selT040.FieldByName('NOMINATIVO').AsString,selT040.FieldByName('MATRICOLA').AsString]);
        TabellaStampa.Post;
        Next;
      end;
    finally;
      Close;
      Screen.Cursor:=crDefault;
      EnableControls;
    end;
  end;
  //Assenti non giustificati
  if AssNonGius then
  begin
    OpenAssenti(False,True);
    with selAssenti do
    try
      DisableControls;
      Screen.Cursor:=crHourGlass;
      First;
      while not Eof do
      begin
        TabellaStampa.Append;
        TabellaStampa.FieldByName('DATA').AsDateTime:=StrToDate(A139FPianifServizi.edtDatada.Text);
        TabellaStampa.FieldByName('PATTUGLIA').AsFloat:=selAssenti.RecNo;
        TabellaStampa.FieldByName('COD_TIPO_TURNO').AsString:='zzz2AssentiNonGiutificati';
        TabellaStampa.FieldByName('TIPO_TURNO').AsString:='Assenti non giustificati';
        TabellaStampa.FieldByName('SERVIZIO').AsString:='Assente ingiustificato';
        TabellaStampa.FieldByName('NOTE_SERVIZIO').AsString:='';
        TabellaStampa.FieldByName('NOMINATIVO').AsString:=Format('%s(%s)',[selAssenti.FieldByName('NOMINATIVO').AsString,selAssenti.FieldByName('MATRICOLA').AsString]);
        TabellaStampa.Post;
        Next;
      end;
    finally;
      Close;
      Screen.Cursor:=crDefault;
      EnableControls;
    end;
  end;
end;

procedure TA139FPianifServiziDtm.OpenTotAnag;
var ParDati:String;
begin
  ParDati:=', V430.T430' + ParametriPianServiziRaggr1 + ', V430.T430' + ParametriPianServiziRaggr2 + ', V430.T430V_GIORNALIERO, V430.T430V_FESTIVO';
  selTotAnag.SetVariable('DATI',ParDati);
  if C700MergeSettaPeriodo(selTotAnag,selT500.FieldByName('DATA').AsDateTime,selT500.FieldByName('DATA').AsDateTime) then
    selTotAnag.Close;
  try
    selTotAnag.Open;
  except
    //l'except serve solo finchè non si decide sui campi sulla gestione dei campi V_GIORNALIERO, V_FESTIVO
    ParDati:=', V430.T430' + ParametriPianServiziRaggr1 + ', V430.T430' + ParametriPianServiziRaggr2;
    selTotAnag.Close;
    selTotAnag.SetVariable('DATI',ParDati);
    selTotAnag.Open;
  end;
end;

procedure TA139FPianifServiziDtm.OpenAssenti(AssGius,AssNonGius:Boolean);
begin
  Screen.Cursor:=crHourGlass;
  try
    if AssGius then
    begin
      selT040.setVariable('DATA1',StrToDate(A139FPianifServizi.edtDataDa.Text));
      selT040.setVariable('DATA2',StrToDate(A139FPianifServizi.edtDataA.Text));
      C700MergeSettaPeriodo(selT040,StrToDate(A139FPianifServizi.edtDataDa.Text),StrToDate(A139FPianifServizi.edtDataA.Text));
      selT040.Close;
      selT040.FieldByName('DATA').Visible:=A139FPianifServizi.edtDataDa.Text <> A139FPianifServizi.edtDataA.Text;
      selT040.Open;
    end;
    if AssNonGius then
      if A139FPianifServizi.edtDataDa.Text = A139FPianifServizi.edtDataA.Text then
      begin
        selAssenti.setVariable('DATA',StrToDate(A139FPianifServizi.edtDataDa.Text));
        C700MergeSettaPeriodo(selAssenti,StrToDate(A139FPianifServizi.edtDataDa.Text),StrToDate(A139FPianifServizi.edtDataA.Text));
        selAssenti.Close;
        selAssenti.Open;
      end
      else
        selAssenti.Close;
  finally
    Screen.Cursor:=crDefault;
  end;
end;


procedure TA139FPianifServiziDtm.AggDati(DataDec:TDateTime; Anagrafe:Boolean);
var Filtro:String;
begin
  Screen.Cursor:=crHourGlass;
  try
    //SET DATOLIB #1
    if A000LookupTabella(ParametriPianServiziRaggr1,selCampo1) then
    begin
      if selCampo1.VariableIndex('DECORRENZA') >= 0 then
        selCampo1.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      //selCampo1.Open;
    end;
    if C700SelAnagrafe <> nil then
    begin
      Filtro:=StringReplace(selCampo1.SQL.Text,'ORDER BY CODICE','ORDER BY 2',[rfIgnoreCase]);
      Insert(' AND CODICE IN (SELECT T430' + ParametriPianServiziRaggr1 + ' FROM :C700SelAnagrafe) ',Filtro,pos('ORDER BY',Filtro));
      selCampo1.SQL.Clear;
      selCampo1.SQL.Text:=Filtro;
      selCampo1.DeclareVariable('C700SelAnagrafe',otSubst);
      C700MergeSelAnagrafe(selCampo1,False);
      C700MergeSettaPeriodo(selCampo1,DataDec,DataDec);
      selCampo1.Close;
      selCampo1.Open;
    end;
    //SET DATOLIB #2
    if A000LookupTabella(ParametriPianServiziRaggr2,selCampo2) then
    begin
      if selCampo2.VariableIndex('DECORRENZA') >= 0 then
        selCampo2.SetVariable('DECORRENZA',EncodeDate(3999,12,31));
      //selCampo2.Open;
    end;
    if C700SelAnagrafe <> nil then
    begin
      Filtro:=StringReplace(selCampo2.SQL.Text,'ORDER BY CODICE','ORDER BY 2',[rfIgnoreCase]);
      Insert(' AND CODICE IN (SELECT T430' + ParametriPianServiziRaggr2 + ' FROM :C700SelAnagrafe) ',Filtro,pos('ORDER BY',Filtro));
      selCampo2.SQL.Clear;
      selCampo2.SQL.Text:=Filtro;
      selCampo2.DeclareVariable('C700SelAnagrafe',otSubst);
      C700MergeSelAnagrafe(selCampo2,False);
      C700MergeSettaPeriodo(selCampo2,DataDec,DataDec);
      selCampo2.Close;
      selCampo2.Open;
    end;
  finally
    Screen.Cursor:=crDefault;
  end;
  if not Anagrafe then
    exit;
  Screen.Cursor:=crHourGlass;
  try
    Filtro:='';
    if Not selT502_2.FieldByName('CAMPO1').IsNull then
      Filtro:=Filtro + 'T430' + ParametriPianServiziRaggr1 + ' = ''' + selT502_2.FieldByName('CAMPO1').AsString + '''';
    if Not SelT502_2.FieldByName('CAMPO2').IsNull then
    begin
      if Filtro <> '' then
        Filtro:=Filtro + ' AND ';
      Filtro:=Filtro + 'T430' +  ParametriPianServiziRaggr2 + ' = ''' + selT502_2.FieldByName('CAMPO2').AsString + '''';
    end;
    if Filtro <> '' then
      Filtro:=' AND ' + Filtro;
    selAnag.Close;
    selAnag.SetVariable('FILTRO',Filtro);
    selAnag.SetVariable('DATA',DataDec);
    C700MergeSelAnagrafe(selAnag,False);
    C700MergeSettaPeriodo(selAnag,A139FPianifServizi.DataElab,A139FPianifServizi.DataElab);
    selAnag.Open;
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA139FPianifServiziDtm.DscSuppT540DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if A139FPianifServizi.chkServizio.Checked then
    OpenT500;
end;

procedure TA139FPianifServiziDtm.DscSuppT545DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if A139FPianifServizi.chkTTurno.Checked then
    OpenT500;
end;

function TA139FPianifServiziDtm.ProgPositivi:Boolean;
begin
  Result:=False;
  if Not selT502.Active then
    Exit;
  if selT502.RecordCount = 0 then
    Exit;
  Result:=True;
  selT502.First;
  while Not selT502.Eof do
  begin
    if selT502.FieldByName('PROGRESSIVO').AsInteger < 0 then
    begin
      Result:=False;
      Break;
    end;
    selT502.Next;
  end;
end;

function TA139FPianifServiziDtm.UnProgPositivo:Boolean;
begin
  Result:=False;
  if Not selT502.Active then
    Exit;
  selT502.First;
  while Not selT502.Eof do
  begin
    if selT502.FieldByName('PROGRESSIVO').AsInteger > 0 then
    begin
      Result:=True;
      Break;
    end;
    selT502.Next;
  end;
end;

procedure TA139FPianifServiziDtm.OpenT501(NomeDts:String = 'selT500');
var P:String;
    D:TDateTime;
begin
  if NomeDts = 'selT500' then
  begin
    if Not selT500.Active then
      Exit;
    P:=selT500.FieldByName('PATTUGLIA').AsString;
    D:=selT500.FieldByName('DATA').AsDateTime;
  end
  else
  begin
    if Not CopiaSelT500.Active then
      Exit;
    P:=CopiaSelT500.FieldByName('PATTUGLIA').AsString;
    D:=CopiaSelT500.FieldByName('DATA').AsDateTime;
  end;
  selT501.DisableControls;
  try
    if P <> VarToStr(selT501.GetVariable('PATTUGLIA')) then
    begin
      selT501.Close;
      selT501.SetVariable('PATTUGLIA',P);
    end;
    if D <> selT501.GetVariable('DATA') then
    begin
      selT501.Close;
      selT501.SetVariable('DATA',D);
    end;
    selT501.Open;
  finally
    selT501.EnableControls;
  end;
end;

procedure TA139FPianifServiziDtm.OpenT500(DataFil:TDateTime=0);
var PComandato,PTipoTurno,PServizio:String;
    PFiltTurno,PFiltServizio:Byte;
    PData1,PData2:TDateTime;
begin
  with A139FPianifServizi do
  begin
    if (selT500.Session = nil) or Not(EnabledT500) then
      Exit;
    selT500.AfterScroll:=nil;
    selT500.DisableControls;
    Screen.Cursor:=crHourGlass;
    try
      if btnServiziComandati.Down then
        PComandato:='S'
      else
        PComandato:='N';
      try
        PData1:=StrToDate(edtDatada.Text);
      except
        PData1:=DataElab;
      end;
      try
        PData2:=StrToDate(edtDataa.Text);
      except
        PData2:=DataElab;
      end;
      PTipoTurno:=VarToStr(DBCmbTTurno.KeyValue);
      PServizio:=VarToStr(DBCmbServizio.KeyValue);
      if ChkTTurno.Checked then
        PFiltTurno:=0
      else
        PFiltTurno:=1;
      if chkServizio.Checked then
        PFiltServizio:=0
      else
        PFiltServizio:=1;
      selT500.Close;
      selT500.SetVariable('PARAMETRI1',ParametriPianServiziRaggr1);
      selT500.SetVariable('PARAMETRI2',ParametriPianServiziRaggr2);
      selT500.SetVariable('COMANDATO',PComandato);
      selT500.SetVariable('DATA1',PData1);
      selT500.SetVariable('DATA2',PData2);
      selT500.SetVariable('TIPO_TURNO',PTipoTurno);
      selT500.SetVariable('SERVIZIO',PServizio);
      selT500.SetVariable('FILT_TURNO',PFiltTurno);
      selT500.SetVariable('FILT_SERVIZIO',PFiltServizio);
      if chkOrdinamento.Checked then
        selT500.SetVariable('ORDINE',null)
      else
        selT500.SetVariable('ORDINE','NVL(' + Ordinamento + ',ORDINE_CMD),');
      C700MergeSelAnagrafe(selT500,False);
      C700MergeSettaPeriodo(selT500,DataElab,DataElab);
      selT500.Open;
    finally
      selT500.EnableControls;
      gridServizi.AutoSizeRows(False,2);
      if chkColonneAutoDimensionate.Checked then
        gridServizi.AutoSizeColumns(False,0);
      selT500.AfterScroll:=selT500AfterScroll;
      selT500AfterScroll(selT500);
      Screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TA139FPianifServiziDtm.OpenT500Aperti;
var D:TDateTime;
begin
  if not selT500.Active then
    exit;
  try
    D:=R180Sysdate(SessioneOracle) - selT530.FieldByName('GGCHIUSURA').AsInteger;
    //selT500Aperti.SetVariable('DATA',StrToDate(A139FPianifServizi.edtDataA.Text) - selT530.FieldByName('GGCHIUSURA').AsInteger);
    selT500Aperti.SetVariable('OFFSET',selT530.FieldByName('GGCHIUSURA').AsInteger);
    selT500Aperti.SetVariable('COMANDATO',selT500.GetVariable('COMANDATO'));
    selT500Aperti.SetVariable('PARAMETRI1',selT500.GetVariable('PARAMETRI1'));
    selT500Aperti.SetVariable('PARAMETRI2',selT500.GetVariable('PARAMETRI2'));
    C700MergeSelAnagrafe(selT500Aperti,False);
    //if C700MergeSettaPeriodo(selT500Aperti,StrToDate(A139FPianifServizi.edtDataA.Text) - selT530.FieldByName('GGCHIUSURA').AsInteger,StrToDate(A139FPianifServizi.edtDataA.Text) - selT530.FieldByName('GGCHIUSURA').AsInteger) then
    if C700MergeSettaPeriodo(selT500Aperti,D,D) then
      selT500Aperti.Close;
    Screen.Cursor:=crHourGlass;
    try
      selT500Aperti.Open;
    finally
      Screen.Cursor:=crDefault;
    end;
  except
  end;
end;

function TA139FPianifServiziDtm.GeneraProg(Data:TDateTime):Integer;
begin
  GetMinProg.Close;
  GetMinProg.SetVariable('DATAIN',Data);
  GetMinProg.Open;
  Result:=GetMinProg.FieldByName('PROG').AsInteger;
end;

function TA139FPianifServiziDtm.GeneraPattuglia(Data:TDateTime):integer;
begin
  GetMaxProg.Close;
  GetMaxProg.SetVariable('DATAIN',Data);
  GetMaxProg.Open;
  Result:=GetMaxProg.FieldByName('PROG').AsInteger;
end;

function TA139FPianifServiziDtm.GetServiziAperti:String;
begin
  Result:='';
  with selT500Aperti do
  begin
    if not Active then
      OpenT500Aperti;
    if RecordCount > 0 then
      Result:=Format('%s - Riga %s - dalle %s alle %s ' + #13#10 + 'Turno %s - Servizio %s',[FieldByName('DATA').AsString,FieldByName('ORDINE').AsString,FieldByName('DALLE').AsString,FieldByName('ALLE').AsString,FieldByName('D_TIPOTURNO').AsString,FieldByName('D_SERVIZIO').ASString]);
    Close;
  end;
end;

procedure TA139FPianifServiziDtm.BeforePostNoStorico(DataSet: TDataSet);
var S:String;
begin

  if Not(Not(A139FPianifServizi.btnServiziComandati.Down) and (selT500.FieldByName('COMANDATO').AsString = 'S')) then
    if (not selT500.FieldByName('TIPO_TURNO').IsNull) and (VarToStr(selT545.Lookup('CODICE',selT500.FieldByName('TIPO_TURNO').AsString,'CODICE')) = '') then
      raise Exception.Create('Tipo turno non ammesso!');

  if (selT500.FieldByName('TIPO_TURNO').AsString = '00C') or (selT500.FieldByName('TIPO_TURNO').AsString = '00N') or
     (selT500.FieldByName('TIPO_TURNO').AsString = '01C') or (selT500.FieldByName('TIPO_TURNO').AsString = '01N') then
  begin
    selT500.FieldByName('DALLE').AsString:='00.00';
    selT500.FieldByName('ALLE').AsString:='00.00';
  end;

  S:=GetServiziAperti;
  if S <> '' then
    raise Exception.Create('Esistono servizi aperti, impossibile confermare!' + #13#10 + S);
  if (selT500.State in [dsEdit]) and
     (selT500.FieldByName('DATA').medpOldValue <> selT500.FieldByName('DATA').Value) then
    selT500.FieldByName('PATTUGLIA').AsInteger:=GeneraPattuglia(selT500.FieldByName('DATA').AsDateTime);
  R180OraValidate(selT500.FieldByName('DALLE').AsString);
  R180OraValidate(selT500.FieldByName('ALLE').AsString);

  if (not selT500.FieldByName('ORDINE_CMD').IsNull) and (A139FPianifServizi.btnServiziComandati.Down) and (selT500.FieldByName('ORDINE_CMD').AsInteger <= 100000) then
  begin
    selT500.FieldByName('ORDINE_CMD').Clear;
    Raise Exception.Create('Impossibile inserire un numero ordine inferiore a 100000!');
  end;
  inherited;
  A139FPianifServizi.GridServizi.Col:=1;
  if selT500.FieldByName('PATTUGLIA').IsNull then
    selT500.FieldByName('PATTUGLIA').AsInteger:=GeneraPattuglia(selT500.FieldByName('DATA').AsDateTime);
  if (selT500.State in [dsEdit]) and
     (selT500.FieldByName('DATA').medpOldValue <> selT500.FieldByName('DATA').Value) then
  begin
    UpdT501_502.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
    UpdT501_502.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').AsInteger);
    UpdT501_502.SetVariable('OLDPATTUGLIA',selT500.FieldByName('PATTUGLIA').medpOldValue);
    UpdT501_502.SetVariable('OLDDATA',selT500.FieldByName('DATA').medpOldValue);
    UpdT501_502.Execute;
    selT502_2.Close;
  end;
end;

procedure TA139FPianifServiziDtm.OpenT502_2;
begin
  AggDati(selT500.FieldByName('DATA').AsDateTime,False);
  selT502_2.Close;
  selT502_2.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').AsInteger);
  selT502_2.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
  selT502_2.SetVariable('PARAMETRI1',ParametriPianServiziRaggr1);
  selT502_2.SetVariable('PARAMETRI2',ParametriPianServiziRaggr2);
  C700MergeSelAnagrafe(selT502_2,False);
  C700MergeSettaPeriodo(selT502_2,A139FPianifServizi.DataElab,A139FPianifServizi.DataElab);
  selT502_2.Open;
end;

procedure TA139FPianifServiziDtm.selT500AfterOpen(DataSet: TDataSet);
begin
  inherited;
  if selT500.RecordCount = 0 then
    selT500AfterScroll(selT500);
end;

procedure TA139FPianifServiziDtm.AfterPost(DataSet: TDataSet);
begin
  if DuplicaRiga then exit;
  if InterfacciaR004.StatoBeforePost = 'I' then
  begin
    //Inserimento pattuglia vuota
    InsT502.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').AsInteger);
    InsT502.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
    InsT502.SetVariable('PROGRESSIVO',GeneraProg(selT500.FieldByName('DATA').AsDateTime));
    InsT502.Execute;
    //Rinumerazione della colonna Ordine, solo se l'ordinamento non è cronologico
    if (not A139FPianifServizi.chkOrdinamento.Checked) and selT500.FieldByName(A139FPianifServizi.Ordinamento).IsNull then
      RinumeraT500;
  end;
  inherited;
  try
    selT500.AfterScroll:=nil;
    A139FPianifServizi.gridServizi.AutoSizeRows(False,2);
    if A139FPianifServizi.chkColonneAutoDimensionate.Checked then
      A139FPianifServizi.gridServizi.AutoSizeColumns(False,0);
  finally
    selT500.AfterScroll:=selT500AfterScroll;
  end;
end;

procedure TA139FPianifServiziDtm.selT500AfterScroll(DataSet: TDataSet);
begin
  inherited;
  with A139FPianifServizi do
  begin
    actRegistraT520.Enabled:=(not SolaLettura) and (selT500.RecordCount > 0) and
                             ((btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S')) or
                              (not btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'N')));
    actCancellapianificazionecorrente.Enabled:=(not SolaLettura) and (selT500.RecordCount > 0) and
                             ((btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S')) or
                              (not btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'N')));
    actRegistraServizio.Enabled:=(not SolaLettura) and (selT500.RecordCount > 0) and (edtDataDa.Text = edtDataA.Text);
    actCancella.Enabled:=(not SolaLettura) and (selT500.FieldByName('STATO').AsString = 'A');
    actModifica.Enabled:=(not SolaLettura) and (selT500.FieldByName('STATO').AsString = 'A');
    actChiudiPattuglia.Enabled:=(not SolaLettura) and (Parametri.A139_ServiziBlocco = 'S') and
                                (selT500.FieldByName('STATO').AsString = 'A') and
                                ((btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S')) or
                                 (not btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'N')));
    actSbloccaPattuglia.Enabled:=(not SolaLettura) and (Parametri.A139_ServiziSBlocco = 'S') and
                                 (selT500.FieldByName('STATO').AsString = 'C') and
                                 ((btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S')) or
                                  (not btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'N')));
    actDuplicaRiga.Enabled:=(not SolaLettura) and (selT500.FieldByName('STATO').AsString = 'A') and
                            ((btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S')) or
                             (not btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'N')));
    OpenT502(selT500.FieldByName('PATTUGLIA').AsInteger,selT500.FieldByName('DATA').AsDateTime);                             
    actOpenA004.Enabled:=A139FPianifServizi.AccessoA004 and UnProgPositivo;
    GridServizi.Repaint;
  end;
end;

procedure TA139FPianifServiziDtm.selT500AfterCancel(DataSet: TDataSet);
begin
  inherited;
  try
    selT500.AfterScroll:=nil;
    A139FPianifServizi.gridServizi.AutoSizeRows(False,2);
    if A139FPianifServizi.chkColonneAutoDimensionate.Checked then
      A139FPianifServizi.gridServizi.AutoSizeColumns(False,0);
  finally
    selT500.AfterScroll:=selT500AfterScroll;
  end;
end;

procedure TA139FPianifServiziDtm.BeforeDelete(DataSet: TDataSet);
var S:String;
begin
  inherited;
  S:=GetServiziAperti;
  if S <> '' then
    raise Exception.Create('Esistono servizi aperti, impossibile confermare!' + #13#10 + S);
  if selT500.FieldByName('STATO').AsString = 'C' then
    raise Exception.Create('Non è possibile eliminare un servizio chiuso!');
  with A139FPianifServizi do
    if (selT500.FieldByName('COMANDATO').AsString = 'S') and (Not btnServiziComandati.Down) then
      raise Exception.Create('Non è possibile eliminare servizi comandati!')
    else if (selT500.FieldByName('COMANDATO').AsString = 'N') and (btnServiziComandati.Down) then
      raise Exception.Create('Non è possibile eliminare servizi non comandati!');

  DelT501_T502.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').AsInteger);
  DelT501_T502.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
  DelT501_T502.Execute;
end;

procedure TA139FPianifServiziDtm.selT500AfterDelete(DataSet: TDataSet);
begin
  inherited;
  selT502.Close;
  try
    selT500.AfterScroll:=nil;
    A139FPianifServizi.gridServizi.AutoSizeRows(False,2);
    if A139FPianifServizi.chkColonneAutoDimensionate.Checked then
      A139FPianifServizi.gridServizi.AutoSizeColumns(False,0);
  finally
    selT500.AfterScroll:=selT500AfterScroll;
  end;
end;

procedure TA139FPianifServiziDtm.selT500BeforeEdit(DataSet: TDataSet);
var S:String;
begin
  if A139FPianifServizi.edtDatada.Text = A139FPianifServizi.edtDataA.Text then
  begin
    S:=GetServiziAperti;
    if S <> '' then
      raise Exception.Create('Esistono servizi aperti, impossibile confermare!' + #13#10 + S);
  end;
  if selT500.FieldByName('STATO').AsString = 'C' then
    raise Exception.Create('Non è possibile modificare un servizio chiuso!');
  inherited;
  A139FPianifServizi.GridServizi.HideInplaceEdit;
  if (selT500.FieldByName('COMANDATO').AsString = 'S') then
    if Not A139FPianifServizi.BtnServiziComandati.Down then
      BloccaCampi(True,'NOTE,ORDINE')
    else
      BloccaCampi(False,'')
  else
    BloccaCampi(False,'');
end;

procedure TA139FPianifServiziDtm.selT500BeforeInsert(DataSet: TDataSet);
var S:String;
begin
  if A139FPianifServizi.edtDatada.Text = A139FPianifServizi.edtDataA.Text then
  begin
    S:=GetServiziAperti;
    if S <> '' then
      raise Exception.Create('Esistono servizi aperti, impossibile confermare!' + #13#10 + S);
  end;
  inherited;
  A139FPianifServizi.GridServizi.HideInplaceEdit;
  BloccaCampi(False,'');  
end;

procedure TA139FPianifServiziDtm.selT500CalcFields(DataSet: TDataSet);
begin
  inherited;
  selT500.FieldByName('C_CAMPO1').AsString:='';
  selT500.FieldByName('C_CAMPO2').AsString:='';
  selT500.FieldByName('NOMINATIVO').AsString:='';
  selT500.FieldByName('PROGRESSIVI').AsString:='';
  if selT500.State = dsInsert  then
    exit;
  OpenT502(selT500.FieldByName('PATTUGLIA').AsInteger, selT500.FieldByName('DATA').AsDateTime);
  if selT502.RecordCount <= 0 then
    Exit;
  selT502.First;
  while Not(selT502.Eof) do
  begin
    if (selT500.FieldByName('C_CAMPO1').AsString <> '') or (selT500.FieldByName('C_CAMPO2').AsString <> '') or (selT500.FieldByName('NOMINATIVO').AsString <> '') then
    begin
      selT500.fieldByName('C_CAMPO1').AsString:=selT500.fieldByName('C_CAMPO1').AsString + #13;
      selT500.fieldByName('C_CAMPO2').AsString:=selT500.fieldByName('C_CAMPO2').AsString + #13;
      selT500.fieldByName('NOMINATIVO').AsString:=selT500.fieldByName('NOMINATIVO').AsString + #13;
    end;
    selT500.FieldByName('C_CAMPO1').AsString:=selT500.FieldByName('C_CAMPO1').AsString + VarToStr(selCampo1.Lookup('CODICE',selT502.FieldByName('CAMPO1').AsString,'DESCRIZIONE'));
    selT500.FieldByName('C_CAMPO2').AsString:=selT500.FieldByName('C_CAMPO2').AsString + VarToStr(selCampo2.Lookup('CODICE',selT502.FieldByName('CAMPO2').AsString,'DESCRIZIONE'));
    selT500.FieldByName('NOMINATIVO').AsString:=selT500.FieldByName('NOMINATIVO').AsString + selT502.FieldByName('COGNOME').AsString + ' ' + selT502.FieldByName('NOME').AsString + ' (' + selT502.FieldByName('MATRICOLA').AsString + ')';
    if selT502.FieldByName('PROGRESSIVO').AsInteger > 0 then
    begin
      if selT500.FieldByName('PROGRESSIVI').AsString <> '' then
        selT500.FieldByName('PROGRESSIVI').AsString:=selT500.FieldByName('PROGRESSIVI').AsString + ',';
      selT500.FieldByName('PROGRESSIVI').AsString:=selT500.FieldByName('PROGRESSIVI').AsString + selT502.FieldByName('PROGRESSIVO').AsString;
    end;
    selT502.Next;
  end;
end;

procedure TA139FPianifServiziDtm.selT500DALLEValidate(Sender: TField);
var m:Integer;
begin
  inherited;
  if not Sender.IsNull then
  begin
    R180OraValidate(Sender.Text);
    if (Sender = selT500.FieldByName('DALLE')) and selT500.FieldByName('ALLE').IsNull then
    begin
      m:=R180OreMinutiExt(Sender.AsString) + DURATA_TURNO;
      if m >= 1440 then
        selT500.FieldByName('ALLE').AsString:=R180MinutiOre(m - 1440)
      else
        selT500.FieldByName('ALLE').AsString:=R180MinutiOre(m);
    end;
  end;
end;

procedure TA139FPianifServiziDtm.selT500NewRecord(DataSet: TDataSet);
begin
  inherited;
  with A139FPianifServizi do
  begin
    try
      selT500.FieldByName('DATA').AsDateTime:=StrToDate(edtDataA.Text);
    except
    end;
    selT500.FieldByName('PATTUGLIA').Clear;
    selT500.FieldByName('TIPO_TURNO').Value:=DBCmbTTurno.KeyValue;
    selT500.FieldByName('SERVIZIO').Value:=DBCmbServizio.KeyValue;
    if btnServiziComandati.Down then
      selT500.FieldByName('COMANDATO').AsString:='S'
    else
      selT500.FieldByName('COMANDATO').AsString:='N';
  end;
end;

procedure TA139FPianifServiziDtm.selT500SERVIZIOValidate(Sender: TField);
begin
  inherited;
  if selT500.FieldByName('NOTE_SERVIZIO').IsNull then
    selT500.FieldByName('NOTE_SERVIZIO').AsString:=VarToStr(selT540.Lookup('CODICE',selT500.FieldByName('SERVIZIO').AsString,'DESCRIZIONE'));
end;

procedure TA139FPianifServiziDtm.selT500TIPO_TURNOValidate(Sender: TField);
begin
  inherited;
  if selT500.FieldByName('TIPO_TURNO').AsString <> '' then
    if VarToStr(selT545.Lookup('CODICE',selT500.FieldByName('TIPO_TURNO').AsString,'CODICE')) = '' then
      raise Exception.Create('Tipo turno non ammesso!');
end;

procedure TA139FPianifServiziDtm.selT501BeforePost(DataSet: TDataSet);
var S:String;
begin
  inherited;
  if DuplicaRiga then exit;
  if SovrapposizioneT501(selT501.FieldByName('TIPO').AsString,
                         selT501.FieldByName('CODICE').AsString,
                         selT500.FieldByName('DATA').AsDateTime,
                         selT500.FieldByName('DALLE').AsString,
                         selT500.FieldByName('ALLE').AsString,
                         selT501.State = dsInsert,
                         selT501.RowID) then
    with selT501Inters do
    begin
      S:='';
      First;
      while not Eof do
      begin
        if S <> '' then
          S:=S + #13#10;
        S:=S + Format('%s dalle %s alle %s - Turno:%s - Servizio:%s',[FieldByName('DATA').AsString,FieldByName('DALLE').AsString,FieldByName('ALLE').AsString,FieldByName('TIPO_TURNO').AsString,FieldByName('SERVIZIO').AsString]);
        Next;
      end;
      //raise Exception.Create('Sovrapposizione con altra pianificazione:' + #13#10 + S);
      if MessageDlg('Sovrapposizione con altra pianificazione:' + #13#10 + S + #13#10 + 'Confermare comunque?',mtWarning,[mbYes,mbNo],0) = mrNo then
        Abort;
    end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA139FPianifServiziDtm.selT501NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT501.FieldByName('DATA').AsDateTime:=selT500.FieldByName('DATA').AsDateTime;
  selT501.FieldByName('PATTUGLIA').AsInteger:=selT500.FieldByName('PATTUGLIA').AsInteger;
  selT501.FieldByName('TIPO').AsString:='RADIO';
end;

procedure TA139FPianifServiziDtm.selT502_2AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if DuplicaRiga then exit;
  selT502_2.FieldByName('CAMPO1').ReadOnly:=False;
  selT502_2.FieldByName('CAMPO2').ReadOnly:=False;
  selT502_2.FieldByName('DESCCAMPO1').ReadOnly:=False;
  selT502_2.FieldByName('DESCCAMPO2').ReadOnly:=False;
  selT502_2.FieldByName('PROGRESSIVO').ReadOnly:=False;
  if (not A139FPianifServizi.btnServiziComandati.Down) and (selT500.FieldByName('COMANDATO').AsString = 'S') then
  begin
    //selT502_2.FieldByName('CAMPO1').ReadOnly:=not selT502_2.FieldByName('CAMPO1').IsNull;
    selT502_2.FieldByName('CAMPO2').ReadOnly:=not selT502_2.FieldByName('CAMPO2').IsNull;
    //selT502_2.FieldByName('DESCCAMPO1').ReadOnly:=selT502_2.FieldByName('CAMPO1').ReadOnly;
    selT502_2.FieldByName('DESCCAMPO2').ReadOnly:=selT502_2.FieldByName('CAMPO2').ReadOnly;
    selT502_2.FieldByName('PROGRESSIVO').ReadOnly:=selT502_2.FieldByName('COMANDATO').AsString = 'S';
    selT502_2.FieldByName('NOMINATIVO').ReadOnly:=(not selT502_2.FieldByName('CAMPO1').IsNull) or (not selT502_2.FieldByName('CAMPO2').IsNull);
  end;
end;

procedure TA139FPianifServiziDtm.selT502_2BeforeDelete(DataSet: TDataSet);
begin
  inherited;
  if DuplicaRiga then exit;
  if (not A139FPianifServizi.btnServiziComandati.Down) and (selT500.FieldByName('COMANDATO').AsString = 'S') then
    Abort;
  RegistraLog.SettaProprieta('C',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
end;

procedure TA139FPianifServiziDtm.selT502_2BeforeInsert(DataSet: TDataSet);
var i:Integer;
begin
  inherited;
  if (not A139FPianifServizi.btnServiziComandati.Down) and (selT500.FieldByName('COMANDATO').AsString = 'S') then
    Abort;
  for i:=0 to selT502_2.FieldCount - 1 do
    selT502_2.Fields[i].ReadOnly:=False;
  if DuplicaRiga then exit;
end;

procedure TA139FPianifServiziDtm.selT502_2BeforePost(DataSet: TDataSet);
var S:String;
begin
  inherited;
  if selT502_2.FieldByName('PROGRESSIVO').IsNull then
    selT502_2.FieldByName('PROGRESSIVO').AsInteger:=GeneraProg(A139FPianifServizi.DataElab)
  else if selT502_2.FieldByName('PROGRESSIVO').AsInteger > 0 then
  begin
    selT502_2.FieldByName('CAMPO1').AsString:=VarToStr(selTotAnag.Lookup('PROGRESSIVO',selT502_2.FieldByName('PROGRESSIVO').AsInteger,'T430' + ParametriPianServiziRaggr1));
    selT502_2.FieldByName('CAMPO2').AsString:=VarToStr(selTotAnag.Lookup('PROGRESSIVO',selT502_2.FieldByName('PROGRESSIVO').AsInteger,'T430' + ParametriPianServiziRaggr2));
  end;
  if A139FPianifServizi.btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S') and (selT502_2.FieldByName('PROGRESSIVO').AsInteger > 0) then
    selT502_2.FieldByName('COMANDATO').AsString:='S'
  else
    selT502_2.FieldByName('COMANDATO').AsString:='N';
  if DuplicaRiga then exit;
  if SovrapposizioneT502(selT502_2.FieldByName('PROGRESSIVO').AsInteger,
                         selT500.FieldByName('DATA').AsDateTime,
                         selT500.FieldByName('DALLE').AsString,
                         selT500.FieldByName('ALLE').AsString,
                         selT502_2.State = dsInsert,
                         selT502_2.RowID) then
    with selT502Inters do
    begin
      S:='';
      First;
      while not Eof do
      begin
        if S <> '' then
          S:=S + #13#10;
        S:=S + Format('%s dalle %s alle %s - Turno:%s - Servizio:%s',[FieldByName('DATA').AsString,FieldByName('DALLE').AsString,FieldByName('ALLE').AsString,FieldByName('TIPO_TURNO').AsString,FieldByName('SERVIZIO').AsString]);
        Next;
      end;
      raise Exception.Create('Sovrapposizione con altra pianificazione:' + #13#10 + S);
    end;
  case DataSet.State of
    dsInsert:RegistraLog.SettaProprieta('I',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
    dsEdit:RegistraLog.SettaProprieta('M',R180Query2NomeTabella(DataSet),Copy(Name,1,4),DataSet,True);
  end;
end;

procedure TA139FPianifServiziDtm.selT502_2NewRecord(DataSet: TDataSet);
begin
  inherited;
  selT502_2.FieldByName('PATTUGLIA').AsInteger:=selT500.FieldByName('PATTUGLIA').AsInteger;
  selT502_2.FieldByName('DATA').AsDateTime:=selT500.FieldByName('DATA').AsDateTime;
end;

procedure TA139FPianifServiziDtm.selT545FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  Accept:=((selT545.FieldByName('COMANDATO').AsString = 'S') and A139FPianifServizi.btnServiziComandati.Down) or
          ((selT545.FieldByName('COMANDATO').AsString = 'N') and not A139FPianifServizi.btnServiziComandati.Down);
end;

procedure TA139FPianifServiziDtm.RinumeraT500;
var RI:String;
    i:Word;
    D:TDateTime;
begin
  try
    RI:=selT500.RowId;
    selT500.AfterScroll:=nil;
    selT500.BeforePost:=nil;
    selT500.AfterPost:=nil;
    selT500.DisableControls;
    selT500.First;
    D:=selT500.FieldByName('DATA').AsDateTime;
    i:=1;
    while not selT500.Eof do
    begin
      {if A139FPianifServizi.btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S')
         or
         (not A139FPianifServizi.btnServiziComandati.Down) and (selT500.FieldByName('COMANDATO').AsString = 'N')then
      begin
        if selT500.FieldByName('DATA').AsDateTime <> D then
        begin
          D:=selT500.FieldByName('DATA').AsDateTime;
          i:=1;
        end;
        selT500.Edit;
        selT500.FieldByName('ORDINE').AsInteger:=i;
        selT500.Post;
        inc(i);
      end;}
      if A139FPianifServizi.btnServiziComandati.Down and (selT500.FieldByName('COMANDATO').AsString = 'S')
         or
         (not A139FPianifServizi.btnServiziComandati.Down){ and (selT500.FieldByName('COMANDATO').AsString = 'N')}then
      begin
        if selT500.FieldByName('DATA').AsDateTime <> D then
        begin
          D:=selT500.FieldByName('DATA').AsDateTime;
          i:=1;
        end;
        selT500.Edit;

        if Not A139FPianifServizi.btnServiziComandati.Down then
          selT500.FieldByName('ORDINE').AsInteger:=i
        else if A139FPianifServizi.btnServiziComandati.Down then
          selT500.FieldByName('ORDINE_CMD').AsInteger:=i + 100000;

        selT500.Post;
        inc(i);
      end;
      selT500.Next;
    end;
  finally
    selT500.AfterScroll:=selT500AfterScroll;
    selT500.BeforePost:=BeforePostNoStorico;
    selT500.AfterPost:=AfterPost;
    selT500.SearchRecord('ROWID',RI,[srFromBeginning]);
    selT500.EnableControls;
  end;
end;

function TA139FPianifServiziDtm.SovrapposizioneT501(Tipo,Codice:String; Data:TDateTime; Dalle,Alle:String; Inserimento:Boolean; RigaID:String):Boolean;
begin
  with selT501Inters do
  begin
    Close;
    SetVariable('TIPO',Tipo);
    SetVariable('CODICE',Codice);
    SetVariable('DATA',Data);
    SetVariable('DALLE',R180OreMinutiExt(Dalle));
    if R180OreMinutiExt(Dalle) < R180OreMinutiExt(Alle) then
      SetVariable('ALLE',R180OreMinutiExt(Alle))
    else
      SetVariable('ALLE',R180OreMinutiExt(Alle) + 1440);
    if Inserimento then
      SetVariable('RIGAID',null)
    else
      SetVariable('RIGAID',RigaID);
    Open;
    Result:=RecordCount > 0;
  end;
end;

function TA139FPianifServiziDtm.SovrapposizioneT502(Prog:Integer; Data:TDateTime; Dalle,Alle:String; Inserimento:Boolean; RigaID:String):Boolean;
begin
  Result:=False;
  if Prog < 0 then 
    exit;
  with selT502Inters do
  begin
    Close;
    SetVariable('PROGRESSIVO',Prog);
    SetVariable('DATA',Data);
    SetVariable('DALLE',R180OreMinutiExt(Dalle));
    if R180OreMinutiExt(Dalle) < R180OreMinutiExt(Alle) then
      SetVariable('ALLE',R180OreMinutiExt(Alle))
    else
      SetVariable('ALLE',R180OreMinutiExt(Alle) + 1440);
    if Inserimento then
      SetVariable('RIGAID',null)
    else
      SetVariable('RIGAID',RigaID);
    Open;
    Result:=RecordCount > 0;
  end;
end;

procedure TA139FPianifServiziDtm.DuplicaRecordCorrente;
var i:Integer;
begin
  DuplicaRiga:=True;
  try
    //lettura tabelle figlie
    OpenT501;
    OpenT502_2;
    //creazione client dataset
    CreaCDSDuplicaRiga;
    //salvataggio valori della pattuglia corrente nei client dataset
    cdsT500.Append;
    for i:=0 to selT500.FieldDefs.Count - 1 do
      if selT500.FieldByName(selT500.FieldDefs[i].Name).FieldKind = fkData then
        cdsT500.FieldByName(selT500.FieldDefs[i].Name).Value:=selT500.FieldByName(selT500.FieldDefs[i].Name).Value;
    cdsT500.Post;
    selT501.First;
    while not selT501.Eof do
    begin
      cdsT501.Append;
        for i:=0 to selT501.FieldDefs.Count - 1 do
          if selT501.FieldByName(selT501.FieldDefs[i].Name).FieldKind = fkData then
            cdsT501.FieldByName(selT501.FieldDefs[i].Name).Value:=selT501.FieldByName(selT501.FieldDefs[i].Name).Value;
      cdsT501.Post;
      selT501.Next;
    end;
    selT502_2.First;
    while not selT502_2.Eof do
    begin
      cdsT502.Append;
        for i:=0 to selT502_2.FieldDefs.Count - 1 do
          if selT502_2.FieldByName(selT502_2.FieldDefs[i].Name).FieldKind = fkData then
            cdsT502.FieldByName(selT502_2.FieldDefs[i].Name).Value:=selT502_2.FieldByName(selT502_2.FieldDefs[i].Name).Value;
      cdsT502.Post;
      selT502_2.Next;
    end;
    //salvataggio valori dei client dataset nella nuova pattuglia
    selT500.Insert;
    for i:=0 to cdsT500.FieldCount - 1 do
      selT500.FieldByName(cdsT500.Fields[i].FieldName).Value:=cdsT500.Fields[i].Value;
    selT500.FieldByName('PATTUGLIA').Clear;
    selT500.FieldByName('APPARATI').Clear;
    selT500.FieldByName('ORDINE').Clear;
    selT500.FieldByName('ORDINE_CMD').Clear;
    selT500.Post;
    cdsT501.First;
    while not cdsT501.Eof do
    begin
      selT501.Append;
        for i:=0 to cdsT501.FieldCount - 1 do
          selT501.FieldByName(cdsT501.Fields[i].FieldName).Value:=cdsT501.Fields[i].Value;
      selT501.FieldByName('PATTUGLIA').AsInteger:=selT500.FieldByName('PATTUGLIA').AsInteger;
      selT501.Post;
      cdsT501.Next;
    end;
    cdsT502.First;
    while not cdsT502.Eof do
    begin
      selT502_2.Append;
        for i:=0 to cdsT502.FieldCount - 1 do
          selT502_2.FieldByName(cdsT502.Fields[i].FieldName).Value:=cdsT502.Fields[i].Value;
      selT502_2.FieldByName('PATTUGLIA').AsInteger:=selT500.FieldByName('PATTUGLIA').AsInteger;
      selT502_2.FieldByName('PROGRESSIVO').Clear;
      selT502_2.Post;
      cdsT502.Next;
    end;
    selT502.Close;
    A139FPianifServizi.actRefreshExecute(nil);
    //selT500AfterScroll(nil);
  finally
    DuplicaRiga:=False;
    cdsT500.EmptyDataSet;
    cdsT501.EmptyDataSet;
    cdsT502.EmptyDataSet;
  end;
end;

procedure TA139FPianifServiziDtm.CreaCDSDuplicaRiga;
var i:Integer;
begin
  with cdsT500 do
  begin
    if Active then
      EmptyDataSet;
    Close;
    FieldDefs.Clear;
    for i:=0 to selT500.FieldDefs.Count - 1 do
      FieldDefs.Add(selT500.FieldDefs[i].Name,selT500.FieldDefs[i].DataType,selT500.FieldDefs[i].Size,False);
    CreateDataSet;
  end;
  with cdsT501 do
  begin
    if Active then
      EmptyDataSet;
    Close;
    FieldDefs.Clear;
    for i:=0 to selT501.FieldDefs.Count - 1 do
      FieldDefs.Add(selT501.FieldDefs[i].Name,selT501.FieldDefs[i].DataType,selT501.FieldDefs[i].Size,False);
    CreateDataSet;
  end;
  with cdsT502 do
  begin
    if Active then
      EmptyDataSet;
    Close;
    FieldDefs.Clear;
    for i:=0 to selT502_2.FieldDefs.Count - 1 do
      FieldDefs.Add(selT502_2.FieldDefs[i].Name,selT502_2.FieldDefs[i].DataType,selT502_2.FieldDefs[i].Size,False);
    CreateDataSet;
  end;
end;

procedure TA139FPianifServiziDtm.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(StrError);
end;

end.
