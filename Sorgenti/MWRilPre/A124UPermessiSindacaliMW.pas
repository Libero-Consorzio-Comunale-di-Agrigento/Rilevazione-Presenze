unit A124UPermessiSindacaliMW;

interface

uses
  System.SysUtils, System.Classes, Variants, R005UDataModuleMW, Data.DB, OracleData,
  Oracle, Datasnap.DBClient, DatiBloccati, A000UInterfaccia, A004UGiustifAssPresMW,
  Rp502Pro, R500Lin, C180FunzioniGenerali, A000UMessaggi, StrUtils, System.UITypes,
  Math, XSBuiltIns, ActiveX, A000UCostanti, A000USessione;

type
  T124Dlg = procedure(msg,Chiave:String) of object;

type
  (*TDatiColl = record
    Data:TDateTime;
    NumeroProt:String;
    DataProt:TDateTime;
    Dalle,
    Alle,
    Ore,
    TipoPermesso,
    AbbatteCompetenze,
    CodSindacato,
    CodOrganismo,
    Stato,
    ProtModifica:String;
    DataModifica:TDateTime;
  end;*)

  TA124FPermessiSindacaliMW = class(TR005FDataModuleMW)
    Q040: TOracleDataSet;
    Q100: TOracleDataSet;
    Q100PROGRESSIVO: TFloatField;
    Q100DATA: TDateTimeField;
    Q100ORA: TDateTimeField;
    Q100VERSO: TStringField;
    Q100FLAG: TStringField;
    Q100RILEVATORE: TStringField;
    Q100CAUSALE: TStringField;
    Q275: TOracleDataSet;
    Q305: TOracleDataSet;
    selPermessi: TOracleDataSet;
    selT240Filtro: TOracleDataSet;
    selV010: TOracleDataSet;
    cdsT248: TClientDataSet;
    cdsT248PROGRESSIVO: TIntegerField;
    cdsT248DATA: TDateField;
    cdsT248NUMERO_PROT: TStringField;
    cdsT248DATA_PROT: TDateField;
    cdsT248DALLE: TStringField;
    cdsT248ALLE: TStringField;
    cdsT248ORE: TStringField;
    cdsT248ABBATTE_COMPETENZE: TStringField;
    cdsT248COD_SINDACATO: TStringField;
    cdsT248COD_ORGANISMO: TStringField;
    cdsT248STATO: TStringField;
    cdsT248PROT_MODIFICA: TStringField;
    cdsT248DATA_MODIFICA: TDateField;
    cdsT248RSU: TStringField;
    cdsT248RAGGRUPPAMENTO: TStringField;
    cdsT248SINDACATI_RAGGRUPPATI: TStringField;
    cdsT248TIPO_PERMESSO: TStringField;
    cdsT248PROG_PERMESSO: TIntegerField;
    dsrT240C: TDataSource;
    selT240C: TOracleDataSet;
    selCompetenze: TOracleDataSet;
    selCompetenzeAREA_SINDACALE: TStringField;
    selCompetenzeTIPO: TStringField;
    selCompetenzeDECORRENZA: TDateTimeField;
    selCompetenzeSCADENZA: TDateTimeField;
    selCompetenzeCOMPETENZA: TStringField;
    selCompetenzeFRUITO: TStringField;
    selCompetenzeRESIDUO: TStringField;
    dsrCompetenze: TDataSource;
    selT245: TOracleDataSet;
    dsrT245: TDataSource;
    selT240: TOracleDataSet;
    dsrT240: TDataSource;
    selT248Canc: TOracleDataSet;
    selT247InsColl: TOracleDataSet;
    selT248NoGEDAP: TOracleDataSet;
    selT248PROGRESSIVO: TIntegerField;
    selT248TIPO_PERMESSO: TStringField;
    selT248DATA: TDateTimeField;
    selT248NUMERO_PROT: TStringField;
    selT248DATA_PROT: TDateTimeField;
    selT248NoGEDAPDALLE: TStringField;
    selT248NoGEDAPALLE: TStringField;
    selT248NoGEDAPORE: TStringField;
    selT248NoGEDAPABBATTE_COMPETENZE: TStringField;
    selT248NoGEDAPCOD_SINDACATO: TStringField;
    selT248NoGEDAPCOD_ORGANISMO: TStringField;
    selT248NoGEDAPSTATO: TStringField;
    selT248NoGEDAPPROT_MODIFICA: TStringField;
    selT248NoGEDAPDATA_MODIFICA: TDateTimeField;
    selT248NoGEDAPINSERITO_GEDAP: TStringField;
    selT248NoGEDAPPROG_PERMESSO: TFloatField;
    dsrT248NoGEDAP: TDataSource;
    dsrT240NoGEDAP: TDataSource;
    selT240NoGEDAP: TOracleDataSet;
    selT248NoGEDAPMATRICOLA: TStringField;
    selT248NoGEDAPCOGNOME: TStringField;
    selT248NoGEDAPNOME: TStringField;
    selT248NoGEDAPDATA_DA: TDateTimeField;
    selT245Tutti: TOracleDataSet;
    selT240Tutti: TOracleDataSet;
    selV430: TOracleDataSet;
    selT248NoGEDAPABBATTE_COMPETENZE_ORG: TStringField;
    selT248NoGEDAPD_SINDACATO: TStringField;
    selT248NoGEDAPD_ORGANISMO: TStringField;
    selT248NoGEDAPRSU: TStringField;
    selT248NoGEDAPRAGGRUPPAMENTO: TStringField;
    selT248NoGEDAPRETRIBUITO: TStringField;
    selT248NoGEDAPSTATUTARIO: TStringField;
    selT248NoGEDAPSIGLA_GEDAP: TStringField;
    selT248NoGEDAPCOD_MINISTERIALE: TStringField;
    dsrT245NoGEDAP: TDataSource;
    selT245NoGEDAP: TOracleDataSet;
    updT248: TOracleQuery;
    selT040PFP: TOracleDataSet;
    dsrT040PFP: TDataSource;
    selT040PFPMATRICOLA: TStringField;
    selT040PFPCOGNOME: TStringField;
    selT040PFPNOME: TStringField;
    selT040PFPDATA: TDateTimeField;
    selT040PFPCAUSALE: TStringField;
    selT040PFPDAORE: TDateTimeField;
    selT040PFPAORE: TDateTimeField;
    selT040PFPPROGRESSIVO: TFloatField;
    selT040PFPDALLE: TStringField;
    selT040PFPALLE: TStringField;
    selT040PFPDESCRIZIONE: TStringField;
    selT040PFPD_CAUSALE: TStringField;
    selT040PFPD_TIPO: TStringField;
    selT040PFPTIPO_PERMESSO: TStringField;
    selT040PFPCAUSALE_GEDAP: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsT248AfterScroll(DataSet: TDataSet);
    procedure cdsT248NewRecord(DataSet: TDataSet);
    procedure selT240AfterOpen(DataSet: TDataSet);
    procedure selT240FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure selT248NoGEDAPCalcFields(DataSet: TDataSet);
    procedure selT040PFPCalcFields(DataSet: TDataSet);
  private
    {private}
    R502ProDtM1:TR502ProDtM1;
    Inserimento_selT248: Boolean;
  public
    A004MW: TA004FGiustifAssPresMW;
    selT248: TOracleDataSet;
    DataSetInUso: TDataSet;
    (*Nominativo: String;*)
    Azione(*,SuperoCompetResiduo*):String;
    Compet(*, SelezioneCollettiva*): boolean;
    (*Conta:Integer;*)
    ProceduraChiamante(*,OldProg*):Integer;
    selDatiBloccati:TDatiBloccati;
    evtRichiesta:T124Dlg;
    (*DatiColl:TDatiColl;*)
    (*procedure SelAnagrafeOnFilterRecord(DataSet: TDataSet; var Accept: Boolean);*)
    procedure selT248AfterScroll;
    procedure selT248CalcFields(DSCF:TDataSet);
    procedure selT248NewRecord;
    procedure selT248BeforeDelete(DataSet: TDataSet);
    procedure selT248BeforePostNoStorico(DataSet: TDataSet);
    procedure selT248AfterPost(DataSet: TDataSet);
    (*procedure AggiornaSindacatiMC;*)
    procedure AggiornaSindacati;
    //function AggiornaDescrizioni(Tipo,Codice:String;var TipoSind:String):String;
    procedure Competenze;
    procedure Controlli;
    procedure ControlloProgInterno;
    procedure validaOre(Sender: TField);
    procedure ValorizzNumOre;
    function CalcolaNumOre(ODSPerm:TOracleDataSet;DataDa,DataA:TDateTime):Integer;
    function CalcolaNumOreFP(ODSPerm:TOracleDataSet;DataDa,DataA:TDateTime):Integer;
    procedure RipristinaStatoModificato;
    procedure CopiaPermesso;
    procedure ImpostaFiltroPermessi(PermessiNonCancellati,AnnoCorrente:Boolean);
    procedure PreparaCancellazione;
    (*procedure PreparaCancellazioneCollettiva(Tipo:String);*)
    (*procedure CancellaPermesso;*)
    (*procedure ImpostaFiltroInserimentoCollettivo;*)
    (*procedure PreparaInserimento;*)
    (*procedure PreparaInserimentoCollettivo;*)
    (*procedure InserisciPermesso;*)
    (*procedure CercaDip(Prog:Integer);*)
    procedure RecuperaNoGEDAP(DataDa,DataA:TDateTime;Organismo,Sindacato:String);
    procedure RecuperaPFP(DataDa,DataA:TDateTime);
    procedure ImpostaPermessoSelInviato;
    procedure ImpostaTuttiPermessiInviati;
    procedure ControlliGeneraXmlGEDAP;
    procedure WSGEDAP(DataSetWS:TOracleDataSet;InvioMassivo:Boolean);
  end;

implementation

{$R *.dfm}

uses A124UWSPermessiGEDAP;

procedure TA124FPermessiSindacaliMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  A004MW:=TA004FGiustifAssPresMW.Create(nil);
  selDatiBloccati:=TDatiBloccati.Create(nil);
  selDatiBloccati.TipoLog:='M';
  selT245Tutti.Open;

  with A004MW do
  begin
    chkNuovoPeriodo:=False;
    GestioneSingolaDM:=True;
    AnomalieInterattive:=False;
    EseguiCommit:=False;
    //Il Chiamante viene impostato nel DataModulo chiamante (A124/WA124)
    R600DtM1.AnomalieBloccanti:=True;
    R600DtM1.VisualizzaAnomalie:=False;
    R600DtM1.AnomalieNonBloccanti:='7';
  end;
end;

procedure TA124FPermessiSindacaliMW.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(A004MW);
  FreeAndNil(selDatiBloccati);//.Free;
end;

procedure TA124FPermessiSindacaliMW.cdsT248AfterScroll(DataSet: TDataSet);
begin
  (*inherited;
  AbbatteCompetenze:=cdsT248.FieldByName('ABBATTE_COMPETENZE').AsString;
  AggiornaSindacatiMC;*)
end;

procedure TA124FPermessiSindacaliMW.cdsT248NewRecord(DataSet: TDataSet);
begin
  (*inherited;
  cdsT248.FieldByName('DATA_DA').AsDateTime:=Parametri.DataLavoro;
  cdsT248.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
  cdsT248.FieldByName('DATA_PROT').AsDateTime:=Parametri.DataLavoro;
  cdsT248.FieldByName('DATA_MODIFICA').AsDateTime:=Parametri.DataLavoro;
  cdsT248.FieldByName('ABBATTE_COMPETENZE').AsString:='S';
  cdsT248.FieldByName('STATO').AsString:='O';
  cdsT248.FieldByName('TIPO_PERMESSO').AsString:='D';
  cdsT248.FieldByName('PROG_PERMESSO').AsInteger:=0;
  if selT240C.RecordCount = 1 then
    cdsT248.FieldByName('COD_SINDACATO').AsString:=selT240C.FieldByName('CODICE').AsString
  else
    cdsT248.FieldByName('COD_SINDACATO').AsString:='';*)
end;

procedure TA124FPermessiSindacaliMW.selT040PFPCalcFields(DataSet: TDataSet);
begin
  inherited;
  if selT040PFP.FieldByName('DAORE').AsDateTime > 0 then
    selT040PFP.FieldByName('DALLE').AsString:= TimeToStr(selT040PFP.FieldByName('DAORE').AsDateTime);
  if selT040PFP.FieldByName('AORE').AsDateTime > 0 then
    selT040PFP.FieldByName('ALLE').AsString:= TimeToStr(selT040PFP.FieldByName('AORE').AsDateTime);
  selT040PFP.FieldByName('D_CAUSALE').AsString:=selT040PFP.FieldByName('CAUSALE').AsString + ' - ' +
                                                selT040PFP.FieldByName('DESCRIZIONE').AsString;

  if selT040PFP.FieldByName('TIPO_PERMESSO').AsString = 'I' then
    selT040PFP.FieldByName('D_TIPO').AsString:=A000TraduzioneStringhe('Giornate')
  else if selT040PFP.FieldByName('TIPO_PERMESSO').AsString = 'M' then
    selT040PFP.FieldByName('D_TIPO').AsString:=A000TraduzioneStringhe('Mezze giorn.')
  else if selT040PFP.FieldByName('TIPO_PERMESSO').AsString = 'N' then
   selT040PFP. FieldByName('D_TIPO').AsString:=A000TraduzioneStringhe('Numero Ore')
  else if selT040PFP.FieldByName('TIPO_PERMESSO').AsString = 'D' then
    selT040PFP.FieldByName('D_TIPO').AsString:=A000TraduzioneStringhe('Da ore/A ore');

end;

procedure TA124FPermessiSindacaliMW.selT240AfterOpen(DataSet: TDataSet);
var
  SegnaLibro:TBookmark;
begin
  inherited;
  selT240.DisableControls;
  SegnaLibro:=selT240.GetBookmark;
  try
    selT240Filtro.SQL.Clear;
    selT240Filtro.SQL.Add('SELECT '' '' SINDACATO FROM DUAL WHERE :PROGRESSIVO = :PROGRESSIVO AND :DATA = :DATA');
    while not selT240.Eof do
    begin
      if (not selT240.FieldByName('FILTRO').IsNull) and
         ((selT240.FieldByName('RAGGRUPPAMENTO').AsString = 'S') or (selT240.FieldByName('RSU').AsString = 'S')) then
      begin
        selT240Filtro.SQL.Add('UNION');
        selT240Filtro.SQL.Add('SELECT ''' + selT240.FieldByName('CODICE').AsString + ''' FROM T030_ANAGRAFICO T030, T430_STORICO T430, P430_ANAGRAFICO P430');
        selT240Filtro.SQL.Add('WHERE T030.PROGRESSIVO = T430.PROGRESSIVO AND :PROGRESSIVO = T030.PROGRESSIVO AND :DATA BETWEEN T430.DATADECORRENZA AND T430.DATAFINE AND');
        selT240Filtro.SQL.Add(selT240.FieldByName('FILTRO').AsString);
      end;
      selT240.Next;
    end;
    selT240.First;
    selT240.EnableControls;
    selT240.GotoBookmark(SegnaLibro);
  finally
    selT240.FreeBookmark(SegnaLibro);
  end;
  selT240Filtro.Close;
  selT240Filtro.SetVariable('PROGRESSIVO',ProgressivoC700);
  selT240Filtro.SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
  selT240Filtro.Open;
end;

procedure TA124FPermessiSindacaliMW.selT240FilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  inherited;
  Accept:=(selT240.FieldByName('RAGGRUPPAMENTO').AsString = 'N') or selT240.FieldByName('FILTRO').IsNull;
  if Accept then
    exit;
  Accept:=selT240Filtro.SearchRecord('SINDACATO',selT240.FieldByName('CODICE').AsString,[srFromBeginning]);
end;

(*procedure TA124FPermessiSindacaliMW.SelAnagrafeOnFilterRecord(DataSet:TDataSet;var Accept:Boolean);
begin
  Accept:=selT247InsColl.SearchRecord('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger,[srFromBeginning])
end;*)

procedure TA124FPermessiSindacaliMW.selT248AfterScroll;
begin
  inherited;
  (*if SelezioneCollettiva then
    AggiornaSindacatiMC
  else
  begin*)
    AggiornaSindacati;
    if Compet then
      Competenze;
  (*end;*)
end;

procedure TA124FPermessiSindacaliMW.selT248CalcFields(DSCF:TDataSet);
begin
  //Proprietà dell'organismo
  DSCF.FieldByName('D_ORGANISMO').AsString:=VarToStr(selT245Tutti.Lookup('CODICE',DSCF.FieldByName('COD_ORGANISMO').AsString,'DESCRIZIONE'));
  DSCF.FieldByName('RETRIBUITO').AsString:=VarToStr(selT245Tutti.Lookup('CODICE',DSCF.FieldByName('COD_ORGANISMO').AsString,'RETRIBUITO'));
  DSCF.FieldByName('STATUTARIO').AsString:=VarToStr(selT245Tutti.Lookup('CODICE',DSCF.FieldByName('COD_ORGANISMO').AsString,'STATUTARIO'));
  DSCF.FieldByName('ABBATTE_COMPETENZE_ORG').AsString:=VarToStr(selT245Tutti.Lookup('CODICE',DSCF.FieldByName('COD_ORGANISMO').AsString,'ABBATTE_COMPETENZE_ORG'));
  //Proprietà del sindacato
  R180SetVariable(selT240Tutti,'DATA',DSCF.FieldByName('DATA').AsDateTime);
  selT240Tutti.Open;
  DSCF.FieldByName('D_SINDACATO').AsString:=VarToStr(selT240Tutti.Lookup('CODICE',DSCF.FieldByName('COD_SINDACATO').AsString,'DESCRIZIONE'));
  DSCF.FieldByName('RSU').AsString:=VarToStr(selT240Tutti.Lookup('CODICE',DSCF.FieldByName('COD_SINDACATO').AsString,'RSU'));
  DSCF.FieldByName('RAGGRUPPAMENTO').AsString:=VarToStr(selT240Tutti.Lookup('CODICE',DSCF.FieldByName('COD_SINDACATO').AsString,'RAGGRUPPAMENTO'));
  DSCF.FieldByName('COD_MINISTERIALE').AsString:=VarToStr(selT240Tutti.Lookup('CODICE',DSCF.FieldByName('COD_SINDACATO').AsString,'COD_MINISTERIALE'));
  //Proprietà del permesso
  DSCF.FieldByName('SIGLA_GEDAP').AsString:=IfThen(DSCF.FieldByName('STATUTARIO').AsString = 'S','PRO',
                                                   IfThen(DSCF.FieldByName('RETRIBUITO').AsString = 'S','PEM','PNR')
                                                   + IfThen(DSCF.FieldByName('RSU').AsString = 'S',' RSU'));
end;

procedure TA124FPermessiSindacaliMW.selT248NewRecord;
begin
  inherited;
  selT248.FieldByName('PROGRESSIVO').AsInteger:=ProgressivoC700;
  selT248.FieldByName('DATA_DA').AsDateTime:=Parametri.DataLavoro;
  selT248.FieldByName('DATA').AsDateTime:=Parametri.DataLavoro;
  selT248.FieldByName('DATA_PROT').AsDateTime:=Parametri.DataLavoro;
  selT248.FieldByName('DATA_MODIFICA').AsDateTime:=Parametri.DataLavoro;
  selT248.FieldByName('PROG_PERMESSO').AsInteger:=0;
  if selT240.RecordCount = 1 then
    selT248.FieldByName('COD_SINDACATO').AsString:=selT240.FieldByName('CODICE').AsString
  else
    selT248.FieldByName('COD_SINDACATO').AsString:='';
  selT248.FieldByName('COD_ORGANISMO').AsString:='';
end;

procedure TA124FPermessiSindacaliMW.selT248BeforeDelete(DataSet: TDataSet);
var j:Integer;
begin
  inherited;
  Inserimento_selT248:=False;
  // Giustificativi: controllo blocco cancellazione
  if selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').medpOldValue,R180InizioMese(DataSet.FieldByName('DATA_DA').medpOldValue),'T040')
  or selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').medpOldValue,R180InizioMese(DataSet.FieldByName('DATA').medpOldValue),'T040') then
    (*if SelezioneCollettiva then
    begin
      RegistraMsg.InserisciMessaggio('B',selDatiBloccati.MessaggioLog,'',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
      Abort;
    end
    else*)
      raise Exception.Create(selDatiBloccati.MessaggioLog);

  //Cancellazione su A004
  A004MW.R600DtM1.AnomalieBloccanti:=True;
  A004MW.R600DtM1.VisualizzaAnomalie:=False;
  A004MW.R600DtM1.AnomalieNonBloccanti:='7';
  with A004MW do
  begin
    Var_Gestione:=0;
    Var_TipoGiust_Count:=4;
    Var_NumGG:=0;
    Var_Familiari:='';
    Var_TipoCaus:=1;
    if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'I' then
      Var_TipoGiust:=0
    else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'M' then
      Var_TipoGiust:=1
    else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'N' then
      Var_TipoGiust:=2
    else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'D' then
      Var_TipoGiust:=3;
    Var_DaOre:=VarToStr(DataSet.FieldByName('DALLE').medpOldValue);
    Var_AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
    Var_DaData:=DataSet.FieldByName('DATA_DA').medpOldValue;
    Var_AData:=DataSet.FieldByName('DATA').medpOldValue;
    Var_Progressivo:=DataSet.FieldByName('PROGRESSIVO').medpOldValue;
    Var_Causale:=VarToStr(selT245Tutti.Lookup('CODICE',DataSet.FieldByName('COD_ORGANISMO').medpOldValue,'CAUSALE'));
    if Var_Causale <> '' then
    begin
      Q040.Close;
      Q040.SetVariable('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
      Q040.Open;
      Giustif.Causale:=Var_Causale;
      Giustif.Inserimento:=False;
      Giustif.Modo:=R180CarattereDef(VarToStr(DataSet.FieldByName('TIPO_PERMESSO').medpOldValue),1,#0);
      Giustif.DaOre:=Var_DaOre;
      Giustif.AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
      DataInizioOrig:=DataSet.FieldByName('DATA_DA').medpOldValue;
      DataInizio:=DataSet.FieldByName('DATA_DA').medpOldValue;
      DataFine:=DataSet.FieldByName('DATA').medpOldValue;
      try
        CancellaGiustif(False,False);
      except
        on E:Exception do
        begin
          (*if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + E.Message,Parametri.Azienda,Var_Progressivo);
            Abort;
          end
          else*)
            raise Exception.Create('Anomalia bloccante: ' + E.Message);
        end;
      end;
      for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
      begin
        (*if SelezioneCollettiva then
        begin
          RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j],Parametri.Azienda,Var_Progressivo);
          Abort;
        end
        else*)
          raise Exception.Create('Anomalia bloccante: ' + R600DtM1.ListAnomalie[j]);
      end;
      for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
        RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j],Parametri.Azienda,Var_Progressivo);
    end
    else if DataSet.FieldByName('COD_ORGANISMO').medpOldValue <> '' then
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_ORGANISMO_NO_CAUS,[VarToStr(DataSet.FieldByName('COD_ORGANISMO').medpOldValue)]),'',Var_Progressivo);
  end;
end;

procedure TA124FPermessiSindacaliMW.selT248BeforePostNoStorico(DataSet: TDataSet);
var j:Integer;
begin
  Inserimento_selT248:=DataSet.State = dsInsert;
  // Controllo competenze
  if (DataSet.FieldByName('ABBATTE_COMPETENZE_ORG').AsString = 'S') and
    (((DataSet.State = dsEdit) and (Azione = 'M')) or
     (DataSet.State = dsInsert)) then
  begin
    Competenze;
    with selCompetenze do
    begin
      DisableControls;
      First;
      while not Eof do
      begin
        if Trim(selCompetenze.FieldByName('RESIDUO').AsString) <> '' then
          if R180OreMinutiExt(DataSet.FieldByName('ORE').AsString) > R180OreMinutiExt(selCompetenze.FieldByName('RESIDUO').AsString) then
          begin
            (*if SelezioneCollettiva then
            begin
              SuperoCompetResiduo:=selCompetenze.FieldByName('RESIDUO').AsString;
              if not Compet then
                selCompetenze.Close;
              Abort;
            end
            else*)
              raise exception.Create(A000MSG_A124_ERR_COMP_SUPERATE);
          end;
        Next;
      end;
      EnableControls;
    end;
  end;
  if not Compet then
    selCompetenze.Close;
  // Valorizzazione stato
  if (DataSet.State = dsEdit) and
     (Trim(DataSet.FieldByName('PROT_MODIFICA').AsString) <> '') then
    if Azione = 'M' then
      DataSet.FieldByName('STATO').AsString:='M'
    else if Azione = 'C' then
      DataSet.FieldByName('STATO').AsString:='C';
  // Giustificativi: controllo blocco
  if selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataSet.FieldByName('DATA_DA').AsDateTime),'T040')
  or selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(DataSet.FieldByName('DATA').AsDateTime),'T040') then
    (*if SelezioneCollettiva then
    begin
      RegistraMsg.InserisciMessaggio('B',selDatiBloccati.MessaggioLog,'',DataSet.FieldByName('PROGRESSIVO').AsInteger);
      Abort;
    end
    else*)
      raise exception.Create(selDatiBloccati.MessaggioLog);
  if DataSet.State <> dsInsert then
    if selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').medpOldValue,R180InizioMese(DataSet.FieldByName('DATA_DA').medpOldValue),'T040')
    or selDatiBloccati.DatoBloccato(DataSet.FieldByName('PROGRESSIVO').medpOldValue,R180InizioMese(DataSet.FieldByName('DATA').medpOldValue),'T040') then
      (*if SelezioneCollettiva then
      begin
        RegistraMsg.InserisciMessaggio('B',selDatiBloccati.MessaggioLog,'',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
        Abort;
      end
      else*)
        raise exception.Create(selDatiBloccati.MessaggioLog);
  //Inserimento su A004
  with A004MW do
  begin
    Var_Gestione:=0;
    Var_TipoGiust_Count:=4;
    Var_NumGG:=0;
    Var_Familiari:='';
    Var_TipoCaus:=1;
    if DataSet.State <> dsInsert then //Cancella
    begin
      if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'I' then
        Var_TipoGiust:=0
      else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'M' then
        Var_TipoGiust:=1
      else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'N' then
        Var_TipoGiust:=2
      else if DataSet.FieldByName('TIPO_PERMESSO').medpOldValue = 'D' then
        Var_TipoGiust:=3;
      Var_DaOre:=VarToStr(DataSet.FieldByName('DALLE').medpOldValue);
      Var_AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
      Var_DaData:=DataSet.FieldByName('DATA_DA').medpOldValue;
      Var_AData:=DataSet.FieldByName('DATA').medpOldValue;
      Var_Progressivo:=DataSet.FieldByName('PROGRESSIVO').medpOldValue;
      Var_Causale:=VarToStr(selT245Tutti.Lookup('CODICE',DataSet.FieldByName('COD_ORGANISMO').medpOldValue,'CAUSALE'));
      if Var_Causale <> '' then
      begin
        Q040.Close;
        Q040.SetVariable('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').medpOldValue);
        Q040.Open;
        Giustif.Causale:=Var_Causale;
        Giustif.Inserimento:=False;
        Giustif.Modo:=R180CarattereDef(VarToStr(DataSet.FieldByName('TIPO_PERMESSO').medpOldValue),1,#0);
        Giustif.DaOre:=Var_DaOre;
        Giustif.AOre:=VarToStr(DataSet.FieldByName('ALLE').medpOldValue);
        DataInizioOrig:=DataSet.FieldByName('DATA_DA').medpOldValue;
        DataInizio:=DataSet.FieldByName('DATA_DA').medpOldValue;
        DataFine:=DataSet.FieldByName('DATA').medpOldValue;
        try
          CancellaGiustif(False,False);
        except
          on E:Exception do
          begin
            (*if SelezioneCollettiva then
            begin
              RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + E.Message,Parametri.Azienda,Var_Progressivo);
              Abort;
            end
            else*)
              raise exception.Create('Anomalia bloccante: ' + E.Message);
          end;
        end;
        for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
        begin
          (*if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j],Parametri.Azienda,Var_Progressivo);
            Abort;
          end
          else*)
            raise exception.Create('Anomalia bloccante: ' + R600DtM1.ListAnomalie[j]);
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j],'',Var_Progressivo);
      end
      else if DataSet.FieldByName('COD_ORGANISMO').medpOldValue <> '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_ORGANISMO_NO_CAUS,[VarToStr(DataSet.FieldByName('COD_ORGANISMO').medpOldValue)]),'',Var_Progressivo);
    end;
    if DataSet.FieldByName('STATO').AsString <> 'C' then //Inserisci
    begin
      if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'I' then
        Var_TipoGiust:=0
      else if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'M' then
        Var_TipoGiust:=1
      else if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'N' then
        Var_TipoGiust:=2
      else if DataSet.FieldByName('TIPO_PERMESSO').AsString = 'D' then
        Var_TipoGiust:=3;
      Var_DaOre:=DataSet.FieldByName('DALLE').AsString;
      Var_AOre:=DataSet.FieldByName('ALLE').AsString;
      Var_DaData:=DataSet.FieldByName('DATA_DA').AsString;
      Var_AData:=DataSet.FieldByName('DATA').AsString;
      Var_Progressivo:=DataSet.FieldByName('PROGRESSIVO').AsInteger;
      Var_Causale:=VarToStr(selT245Tutti.Lookup('CODICE',DataSet.FieldByName('COD_ORGANISMO').AsString,'CAUSALE'));
      if Var_Causale <> '' then
      begin
        Q040.Close;
        Q040.SetVariable('PROGRESSIVO',DataSet.FieldByName('PROGRESSIVO').AsInteger);
        Q040.Open;
        Giustif.Causale:=Var_Causale;
        Giustif.Inserimento:=True;
        Giustif.Modo:=R180CarattereDef(DataSet.FieldByName('TIPO_PERMESSO').AsString,1,#0);
        Giustif.DaOre:=Var_DaOre;
        Giustif.AOre:=DataSet.FieldByName('ALLE').AsString;
        DataInizioOrig:=DataSet.FieldByName('DATA_DA').AsDateTime;
        DataInizio:=DataSet.FieldByName('DATA_DA').AsDateTime;
        DataFine:=DataSet.FieldByName('DATA').AsDateTime;
        try
          InserisciGiustif(False);
        except
          on E:Exception do
          begin
            (*if SelezioneCollettiva then
            begin
              RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + E.Message,Parametri.Azienda,Var_Progressivo);
              Abort;
            end
            else*)
              raise Exception.Create('Anomalia bloccante: ' + E.Message);
          end;
        end;
        for j:=0 to R600DtM1.ListAnomalie.Count - 1 do
        begin
          (*if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A','Anomalia bloccante: ' + R600DtM1.ListAnomalie[j],Parametri.Azienda,Var_Progressivo);
            Abort;
          end
          else*)
            raise Exception.Create('Anomalia bloccante: ' + R600DtM1.ListAnomalie[j]);
        end;
        for j:=0 to R600DtM1.ListAnomalieNonBloccanti.Count - 1 do
          RegistraMsg.InserisciMessaggio('A','Anomalia non bloccante: ' + R600DtM1.ListAnomalieNonBloccanti[j],'',Var_Progressivo);
      end
      else if DataSet.FieldByName('COD_ORGANISMO').AsString <> '' then
        RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_ORGANISMO_NO_CAUS,[DataSet.FieldByName('COD_ORGANISMO').AsString]),'',Var_Progressivo);
    end;
  end;
end;

procedure TA124FPermessiSindacaliMW.selT248AfterPost(DataSet: TDataSet);
begin
  if Inserimento_selT248 and (Parametri.CampiRiferimento.C40_InvioGedap = 'S') then
  begin
    WSGEDAP((DataSet as TOracleDataSet),False);
    SessioneOracle.Commit;
  end;
end;

(*procedure TA124FPermessiSindacaliMW.AggiornaSindacatiMC;
begin
  selT240C.Close;
  selT240C.SetVariable('DATA',DataSetInUso.FieldByName('DATA').AsDateTime);
  selT240C.SetVariable('COMPETENZE',AbbatteCompetenze);
  selT240C.Open;
end;*)

procedure TA124FPermessiSindacaliMW.AggiornaSindacati;
begin
  //Organismi
  R180SetVariable(selT245,'PROGRESSIVO',ProgressivoC700);
  selT245.Open;
  selT245.First;
  //Svuoto il codice (e la descrizione in CalcFields) dell'organismo, se non è più presente nell'elenco di quelli selezionabili
  if (selT248.State in [dsEdit,dsInsert])
  and not selT248.FieldByName('COD_ORGANISMO').IsNull
  and (VarToStr(selT245.Lookup('CODICE',selT248.FieldByName('COD_ORGANISMO').AsString,'CODICE')) = '')
  then
    selT248.FieldByName('COD_ORGANISMO').AsString:='';
  //Sindacati
  R180SetVariable(selT240,'PROGRESSIVO',ProgressivoC700);
  R180SetVariable(selT240,'DATA',selT248.FieldByName('DATA').AsDateTime);
  R180SetVariable(selT240,'COMPETENZE',VarToStr(selT245Tutti.Lookup('CODICE',selT248.FieldByName('COD_ORGANISMO').AsString,'ABBATTE_COMPETENZE_ORG')));
  R180SetVariable(selT240,'STATUTARIO',VarToStr(selT245Tutti.Lookup('CODICE',selT248.FieldByName('COD_ORGANISMO').AsString,'STATUTARIO')));
  selT240.Open;
  selT240.First;
  //Svuoto il codice (e la descrizione in CalcFields) del sindacato, se non è più presente nell'elenco di quelli selezionabili
  if (selT248.State in [dsEdit,dsInsert])
  and not selT248.FieldByName('COD_SINDACATO').IsNull
  and (VarToStr(selT240.Lookup('CODICE',selT248.FieldByName('COD_SINDACATO').AsString,'CODICE')) = '') then
    selT248.FieldByName('COD_SINDACATO').AsString:='';
end;

{function TA124FPermessiSindacaliMW.AggiornaDescrizioni(Tipo,Codice:String;var TipoSind:String):String;
var DS:TOracleDataSet;
begin
  Result:='';
  TipoSind:='';//Variabile significativa solo quando si richiama con Tipo 'S'
  if Tipo = 'S' then
  begin
    (*if SelezioneCollettiva then
      DS:=selT240C
    else*)
      DS:=selT240;
    if Codice <> '' then
    begin
      if VarToStr(DS.Lookup('CODICE',Codice,'RSU')) = 'S' then
        TipoSind:='RSU'
      else if VarToStr(DS.Lookup('CODICE',Codice,'RAGGRUPPAMENTO')) = 'S' then
        TipoSind:='RAGGRUPPAMENTO'
      else
        TipoSind:='';
      Result:=VarToStr(DS.Lookup('CODICE',Codice,'DESCRIZIONE'));
    end
    else
    begin
      Result:='';
      TipoSind:='';
    end
  end
  else if Tipo = 'O' then
  begin
    DS:=selT245;
    if Codice <> '' then
      Result:=VarToStr(DS.Lookup('CODICE',Codice,'DESCRIZIONE'))
    else
      Result:='';
  end;
end;}

procedure TA124FPermessiSindacaliMW.Competenze;
begin
  selCompetenze.Close;
  if selT248.State = dsEdit then //considero o meno il rowid per il controllo delle compet. in modif.
    selCompetenze.SetVariable('NUMRIGA','AND T248.ROWID (+) <> ''' + selT248.RowId + '''')
  else
    selCompetenze.SetVariable('NUMRIGA','');
  selCompetenze.SetVariable('CODICE',selT248.FieldByName('COD_SINDACATO').AsString);
  selCompetenze.SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
  selCompetenze.SetVariable('PROGRESSIVO',selT248.FieldByName('PROGRESSIVO').AsInteger);
  selCompetenze.Open;
end;

procedure TA124FPermessiSindacaliMW.Controlli;
begin
  if DataSetInUso.FieldByName('DATA_DA').AsDateTime > DataSetInUso.FieldByName('DATA').AsDateTime then
    raise exception.Create(A000MSG_ERR_DATE_INVERTITE);
  if R180Anno(DataSetInUso.FieldByName('DATA_DA').AsDateTime) <> R180Anno(DataSetInUso.FieldByName('DATA').AsDateTime) then
    raise exception.Create(A000MSG_A124_ERR_STESSO_ANNO);
  if (DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'D') then
  begin
    if ((Trim(DataSetInUso.FieldByName('DALLE').AsString) = '')
    or (Trim(DataSetInUso.FieldByName('ALLE').AsString) = '')) then
      raise exception.Create(A000MSG_A124_ERR_NO_DALLE_ALLE);
    if R180OreMinutiExt(DataSetInUso.FieldByName('ALLE').AsString) < R180OreMinutiExt(DataSetInUso.FieldByName('DALLE').AsString) then
      raise exception.Create(A000MSG_A124_ERR_ALLE_MAGGIORE_DALLE);
  end;
  if (DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'N') and
     (Trim(DataSetInUso.FieldByName('DALLE').AsString) = '') then
    raise exception.Create(A000MSG_A124_ERR_NO_DALLE);
  if Trim(DataSetInUso.FieldByName('COD_ORGANISMO').AsString) = '' then
    raise exception.Create(A000MSG_A124_ERR_NO_ORGANISMO);
  if Trim(DataSetInUso.FieldByName('COD_SINDACATO').AsString) = '' then
    raise exception.Create(A000MSG_A124_ERR_NO_SINDACATO);
  // Controllo protocollo modifica
  (*if not SelezioneCollettiva then*)
    if (selT248.FieldByName('STATO').AsString = 'M') and
       (Trim(selT248.FieldByName('PROT_MODIFICA').AsString) = '') then
      raise exception.Create(A000MSG_A124_ERR_NO_NUM_PROTOCOLLO);
  if R180OreMinuti(Trim(DataSetInUso.FieldByName('ORE').AsString)) <= 0 then
    raise exception.Create(A000MSG_A124_ERR_NO_ORE);
end;

procedure TA124FPermessiSindacaliMW.ControlloProgInterno;
begin
  with selPermessi do
  begin
    Close;
    SetVariable('PROG',selT248.FieldByName('PROGRESSIVO').AsInteger);
    SetVariable('DATA_DA',selT248.FieldByName('DATA_DA').AsDateTime);
    SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
    Open;
    First;
    while not Eof do
    begin
      if (FieldByName('TIPO_PERMESSO').AsString = 'I') or
         (FieldByName('TIPO_PERMESSO').AsString = 'M') or
         (FieldByName('TIPO_PERMESSO').AsString = 'N') then
      begin
        (*if SelezioneCollettiva then
        begin
          RegistraMsg.InserisciMessaggio('A',Nominativo + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE,'',selT248.FieldByName('PROGRESSIVO').AsInteger);
          Abort;
        end
        else*)
          raise exception.Create(A000MSG_A124_ERR_INSERIMENTO + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE);
      end
      else if FieldByName('TIPO_PERMESSO').AsString = 'D' then
      begin
        if (selT248.FieldByName('TIPO_PERMESSO').AsString = 'I') or
           (selT248.FieldByName('TIPO_PERMESSO').AsString = 'M') or
           (selT248.FieldByName('TIPO_PERMESSO').AsString = 'N') then
        begin
          (*if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A',Nominativo + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE,'',selT248.FieldByName('PROGRESSIVO').AsInteger);
            Abort;
          end
          else*)
            raise exception.Create(A000MSG_A124_ERR_INSERIMENTO + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE);
        end
        else  //se permesso dalle-alle
        begin
          (*if SelezioneCollettiva then
          begin
            RegistraMsg.InserisciMessaggio('A',Nominativo + ': ' + A000MSG_A124_ERR_PERMESSO_ESISTE,'',selT248.FieldByName('PROGRESSIVO').AsInteger);
            Abort;
          end
          else*) if (R180OreMinutiExt(selT248.FieldByName('ALLE').AsString) > R180OreMinutiExt(FieldByName('DALLE').AsString)) and
            (R180OreMinutiExt(selT248.FieldByName('DALLE').AsString) < R180OreMinutiExt(FieldByName('ALLE').AsString)) then
            raise exception.Create(A000MSG_A124_ERR_INSERIMENTO + ': ' + A000MSG_A124_ERR_PERMESSO_INTERSECA)
          else
            selT248.FieldByName('PROG_PERMESSO').AsInteger:=FieldByName('PROG_PERMESSO').AsInteger + 1;
        end;
      end;
      Next;
    end;
  end;
  if selT248.FieldByName('PROG_PERMESSO').AsInteger > 0 then
    if Assigned(evtRichiesta) then
      evtRichiesta('Attenzione: ' + A000MSG_A124_ERR_PERMESSO_ESISTE + ' Continuare?','EsistePermesso');
end;

procedure TA124FPermessiSindacaliMW.validaOre(Sender: TField);
begin
  inherited;
  if (Sender.IsNull) or (Sender.AsString = '') then exit;
  R180OraValidate(Sender.AsString);
end;

procedure TA124FPermessiSindacaliMW.ValorizzNumOre;
begin
  if (*(SelezioneCollettiva) or*) (DataSetInUso.FieldByName('COD_ORGANISMO').IsNull) then
    Exit;
  if DataSetInUso.FieldByName('TIPO_PERMESSO').AsString = 'D' then  //Tipo permesso = Dalle-Alle
    if (Trim(DataSetInUso.FieldByName('DALLE').AsString) <> '') and
       (Trim(DataSetInUso.FieldByName('ALLE').AsString) <> '') then
      if R180OreMinutiExt(DataSetInUso.FieldByName('ALLE').AsString) < R180OreMinutiExt(DataSetInUso.FieldByName('DALLE').AsString) then
        raise exception.Create(A000MSG_A124_ERR_ALLE_MAGGIORE_DALLE);
  DataSetInUso.FieldByName('ORE').AsString:=R180MinutiOre(CalcolaNumOre((DataSetInUso as TOracleDataSet),DataSetInUso.FieldByName('DATA_DA').AsDateTime,DataSetInUso.FieldByName('DATA').AsDateTime));
end;

function TA124FPermessiSindacaliMW.CalcolaNumOre(ODSPerm:TOracleDataSet;DataDa,DataA:TDateTime):Integer;
var xx:Integer;
    Assenza:String;
    tgiustific_vuoto:t_tgiustificdipmese;
    dCorr:TDateTime;
begin
  Result:=0;
  Assenza:=VarToStr(selT245Tutti.Lookup('CODICE',ODSPerm.FieldByName('COD_ORGANISMO').AsString,'CAUSALE'));
  dCorr:=DataDa;
  //Valorizzazione Num.Ore in base a Tipo permesso
  try
    R502ProDtM1:=TR502ProDtM1.Create(nil);
    with R502ProDtM1 do
    begin
      Chiamante:='Assenze';
      PeriodoConteggi(DataDa,DataA);
      while dCorr <= DataA do
      begin
        Blocca:=0;
        DataCon:=dCorr;
        for xx:=1 to MaxGiustif do m_tab_giustificativi[R180Giorno(DataCon),xx]:=tgiustific_vuoto;
        m_tab_giustificativi[R180Giorno(DataCon),1].tcausgius:=Assenza;
        m_tab_giustificativi[R180Giorno(DataCon),1].tdallegius:=EncodeDate(1899,12,30) + (R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString) / 1440);
        m_tab_giustificativi[R180Giorno(DataCon),1].tallegius:=EncodeDate(1899,12,30) + (R180OreMinutiExt(ODSPerm.FieldByName('ALLE').AsString) / 1440);
        m_tab_giustificativi[R180Giorno(DataCon),1].ttipogius:=R180CarattereDef(ODSPerm.FieldByName('TIPO_PERMESSO').AsString);
        Conteggi('Assenze',ODSPerm.FieldByName('PROGRESSIVO').AsInteger,DataCon);
        if Trim(Assenza) = '' then  //se organismo senza assenza
        begin
          if R502ProDtM1.Blocca = 0 then  //se non ci sono anom.bloccanti --> DebitoGG
          begin
            if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'I' then //Giornata intera
              Result:=Result + DebitoGG
            else if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'M' then //Mezza giornata
            begin
              if Trim(ODSPerm.FieldByName('DALLE').AsString) <> '' then //Mezza giornata con numero ore
                Result:=Result + R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString)
              else
                Result:=Result + Trunc(DebitoGG/2);
            end
            else if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'N' then //Num.Ore
              Result:=Result + R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString)
            else if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'D' then //Dalle..Alle
              Result:=Result + (R180OreMinutiExt(ODSPerm.FieldByName('ALLE').AsString) - R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString));
          end;
        end
        else
        begin  //se organismo con assenza
          if R180In(ValStrT265[triepgiusasse[1].tcausasse,'INFLUCONT'],['B','D']) then
            //causali che non rendono le ore sul cartellino
            Result:=Result + triepgiusasse[1].tminvalasse
          else
            //causali che rendono le ore sul cartellino
            Result:=Result + triepgiusasse[1].tminresasse;
        end;
        dCorr:=dCorr + 1;
      end;
    end;
  finally
    FreeAndNil(R502ProDtM1);
  end;
end;

function TA124FPermessiSindacaliMW.CalcolaNumOreFP(ODSPerm: TOracleDataSet; DataDa, DataA: TDateTime): Integer;
var xx:Integer;
    tgiustific_vuoto:t_tgiustificdipmese;
    dCorr:TDateTime;
begin
  Result:=0;
  dCorr:=DataDa;
  //Valorizzazione Num.Ore in base a Tipo permesso
  try
    R502ProDtM1:=TR502ProDtM1.Create(nil);
    with R502ProDtM1 do
    begin
      Chiamante:='Assenze';
      PeriodoConteggi(DataDa,DataA);
      while dCorr <= DataA do
      begin
        Blocca:=0;
        DataCon:=dCorr;
        for xx:=1 to MaxGiustif do m_tab_giustificativi[R180Giorno(DataCon),xx]:=tgiustific_vuoto;
        m_tab_giustificativi[R180Giorno(DataCon),1].tdallegius:=EncodeDate(1899,12,30) + (R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString) / 1440);
        m_tab_giustificativi[R180Giorno(DataCon),1].tallegius:=EncodeDate(1899,12,30) + (R180OreMinutiExt(ODSPerm.FieldByName('ALLE').AsString) / 1440);
        m_tab_giustificativi[R180Giorno(DataCon),1].ttipogius:=R180CarattereDef(ODSPerm.FieldByName('TIPO_PERMESSO').AsString);
        Conteggi('Assenze',ODSPerm.FieldByName('PROGRESSIVO').AsInteger,DataCon);
        if R502ProDtM1.Blocca = 0 then  //se non ci sono anom.bloccanti --> DebitoGG
        begin
          if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'I' then //Giornata intera
            Result:=Result + DebitoGG
          else if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'M' then //Mezza giornata
          begin
            if Trim(ODSPerm.FieldByName('DALLE').AsString) <> '' then //Mezza giornata con numero ore
              Result:=Result + R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString)
            else
              Result:=Result + Trunc(DebitoGG/2);
          end
          else if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'N' then //Num.Ore
            Result:=Result + R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString)
          else if ODSPerm.FieldByName('TIPO_PERMESSO').AsString = 'D' then //Dalle..Alle
            Result:=Result + (R180OreMinutiExt(ODSPerm.FieldByName('ALLE').AsString) - R180OreMinutiExt(ODSPerm.FieldByName('DALLE').AsString));
        end;
        dCorr:=dCorr + 1;
      end;
    end;
  finally
    FreeAndNil(R502ProDtM1);
  end;
end;

procedure TA124FPermessiSindacaliMW.RipristinaStatoModificato;
begin
  selT248.Edit;
  selT248.FieldByName('STATO').AsString:='M';
  selT248.Post;
  SessioneOracle.Commit;
end;

procedure TA124FPermessiSindacaliMW.CopiaPermesso;
var Progressivo:Integer;
  DataProt,DataMod:TDateTime;
  Prot,Dalle,Alle,ProtMod,Sindacato,Organismo,TipoPermesso:String;
begin
  if selT248.FieldByName('STATO').AsString = 'C' then
    raise exception.Create(Format(A000MSG_A124_ERR_FMT_PERM_CANCELLATO,['copiare']));
  Progressivo:=selT248.FieldByName('PROGRESSIVO').AsInteger;
  Prot:=selT248.FieldByName('NUMERO_PROT').AsString;
  DataProt:=selT248.FieldByName('DATA_PROT').AsDateTime;
  Dalle:=selT248.FieldByName('DALLE').AsString;
  Alle:=selT248.FieldByName('ALLE').AsString;
  TipoPermesso:=selT248.FieldByName('TIPO_PERMESSO').AsString;
  Sindacato:=selT248.FieldByName('COD_SINDACATO').AsString;
  Organismo:=selT248.FieldByName('COD_ORGANISMO').AsString;
  DataMod:=StrToDate('30/12/1899');
  if selT248.FieldByName('STATO').AsString = 'M' then
  begin
    ProtMod:='';
    DataMod:=StrToDate('30/12/1899');
  end;
  selV010.Close;
  selV010.SetVariable('PROGRESSIVO',Progressivo);
  selV010.SetVariable('DATA',selT248.FieldByName('DATA').AsDateTime);
  selV010.Open;
  selV010.First;
  selT248.OnNewRecord:=nil;
  selT248.Insert;
  selT248.FieldByName('PROGRESSIVO').AsInteger:=Progressivo;
  selT248.FieldByName('DATA_DA').AsDateTime:=selV010.FieldByName('DATA').AsDateTime;
  selT248.FieldByName('DATA').AsDateTime:=selV010.FieldByName('DATA').AsDateTime;
  selT248.FieldByName('NUMERO_PROT').AsString:=Prot;
  selT248.FieldByName('DATA_PROT').AsDateTime:=DataProt;
  selT248.FieldByName('DALLE').AsString:=Dalle;
  selT248.FieldByName('ALLE').AsString:=Alle;
  selT248.FieldByName('TIPO_PERMESSO').AsString:=TipoPermesso;
  selT248.FieldByName('PROG_PERMESSO').AsInteger:=0;
  selT248.FieldByName('COD_SINDACATO').AsString:=Sindacato;
  selT248.FieldByName('COD_ORGANISMO').AsString:=Organismo;
  selT248.FieldByName('STATO').AsString:='O';
  selT248.FieldByName('PROT_MODIFICA').AsString:=ProtMod;
  selT248.FieldByName('DATA_MODIFICA').AsDateTime:=DataMod;
  ValorizzNumOre;
end;

procedure TA124FPermessiSindacaliMW.ImpostaFiltroPermessi(PermessiNonCancellati,AnnoCorrente:Boolean);
var Filtro:String;
begin
  Filtro:='';
  if PermessiNonCancellati then
    Filtro:='(STATO <> ''C'')';
  if PermessiNonCancellati and AnnoCorrente then
    Filtro:=Filtro + ' AND ';
  if AnnoCorrente then
    Filtro:=Filtro + '(DATA >= ' + FloatToStr(EncodeDate(R180Anno(selT248.FieldByName('DATA').AsDateTime),1,1)) + ') AND (DATA <= ' + FloatToStr(EncodeDate(R180Anno(selT248.FieldByName('DATA').AsDateTime),12,31)) + ')';
  selT248.Filter:=Filtro;
  selT248.Filtered:=selT248.Filter <> '';
end;

procedure TA124FPermessiSindacaliMW.PreparaCancellazione;//Usato solo in WIN
begin
  (*if SelezioneCollettiva then
  begin
    cdsT248.Close;
    cdsT248.CreateDataSet;
    cdsT248.Open;
    cdsT248.Insert;
  end
  else*)
    selT248.Edit;
end;

(*procedure TA124FPermessiSindacaliMW.PreparaCancellazioneCollettiva(Tipo:String);
var PosFrom,LungOrderBy:Integer;
    Filtro:String;
begin
  with selT248Canc do
  begin
    Close;
    SetVariable('DATA',DataSetInUso.FieldByName('DATA').AsDateTime);
    SetVariable('DALLE',DataSetInUso.FieldByName('DALLE').AsString);
    SetVariable('ALLE',DataSetInUso.FieldByName('ALLE').AsString);
    SetVariable('ORE',DataSetInUso.FieldByName('ORE').AsString);
    SetVariable('COD_SINDACATO',DataSetInUso.FieldByName('COD_SINDACATO').AsString);
    SetVariable('COD_ORGANISMO',DataSetInUso.FieldByName('COD_ORGANISMO').AsString);
    SetVariable('NUMERO_PROT',DataSetInUso.FieldByName('NUMERO_PROT').AsString);
    SetVariable('DATA_PROT',DataSetInUso.FieldByName('DATA_PROT').AsDateTime);
    SetVariable('ABBATTE',DataSetInUso.FieldByName('ABBATTE_COMPETENZE').AsString);
    SetVariable('TIPO',Tipo);
    SetVariable('PROT_MODIFICA',DataSetInUso.FieldByName('PROT_MODIFICA').AsString);
    SetVariable('DATA_MODIFICA',DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime);
    PosFrom:=Pos('FROM',SelAnagrafe.SQL.Text);
    LungOrderBy:=Pos('ORDER BY',SelAnagrafe.SQL.Text);
    if LungOrderBy <= 0  then
      LungOrderBy:=Length(SelAnagrafe.SQL.Text);
    Filtro:=' (SELECT PROGRESSIVO ' + Copy(SelAnagrafe.SQL.Text,PosFrom,LungOrderBy-PosFrom) + ')';
    Filtro:=StringReplace(UpperCase(Filtro),':DATALAVORO','TO_DATE(''' + DateToStr(Parametri.DataLavoro) + ''',''DD/MM/YYYY'')',[rfReplaceAll]);
    SetVariable('SELC700',Filtro);
    Open;
    if Assigned(evtRichiesta) then
      evtRichiesta(Format(IfThen(Tipo = 'C',A000MSG_A124_DLG_FMT_STATO_CANC_PERMESSO,A000MSG_A124_DLG_FMT_CANC_PERMESSO),[IntToStr(RecordCount)]),'CancellazioneCollettiva');
  end;
end;*)

(*procedure TA124FPermessiSindacaliMW.CancellaPermesso;
var Messaggio:String;
begin
  with selT248Canc do
    if VarToStr(GetVariable('TIPO')) = 'C' then
    begin
      Edit;
      FieldByName('STATO').AsString:='C';
      FieldByName('PROT_MODIFICA').AsString:=DataSetInUso.FieldByName('PROT_MODIFICA').AsString;
      FieldByName('DATA_MODIFICA').AsDateTime:=DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime;
      try
        Post;
        Conta:=Conta+1;
      except
        on E:exception do
          Messaggio:=E.Message;
      end;
      if Messaggio <> '' then
        RegistraMsg.InserisciMessaggio('A',Nominativo + ': Aggiornamento fallito - ' + Messaggio,'',FieldByName('PROGRESSIVO').AsInteger);
    end
    else if VarToStr(GetVariable('TIPO')) = 'E' then
    begin
      try
        Delete;
        Conta:=Conta + 1;
      except
        on E:exception do Messaggio:=E.Message;
      end;
      if Messaggio <> '' then
        RegistraMsg.InserisciMessaggio('A',Nominativo + ': Cancellazione fallita - ' + Messaggio,'',FieldByName('PROGRESSIVO').AsInteger);
    end;
end;*)

(*procedure TA124FPermessiSindacaliMW.ImpostaFiltroInserimentoCollettivo;
var nDip:Integer;
    Filtro:String;
begin
  Filtro:=VarToStr(selT240c.Lookup('CODICE',DatiColl.CodSindacato,'FILTRO'));//Necessario per Cloud che non si posiziona automaticamente sul selT240c
  selT247InsColl.Close;
  selT247InsColl.SetVariable('DATALAVORO',DatiColl.Data);
  selT247InsColl.SetVariable('FILTRO_T240',IfThen(Filtro <> '','AND ' + StringReplace(Filtro,'T430.','T430',[rfReplaceAll])));
  selT247InsColl.SetVariable('COD_SINDACATO',DatiColl.CodSindacato);
  selT247InsColl.SetVariable('ABBATTE_COMPETENZE',DatiColl.AbbatteCompetenze);
  selT247InsColl.Open;
  OldProg:=SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  SelAnagrafe.Filtered:=True;
  nDip:=SelAnagrafe.RecordCount;
  SelAnagrafe.Filtered:=False;
  CercaDip(OldProg);
  if Assigned(evtRichiesta) then
    evtRichiesta(Format(A000MSG_A124_DLG_FMT_INS_PERMESSO,[IntToStr(nDip)]),'InserimentoCollettivo');
end;*)

(*procedure TA124FPermessiSindacaliMW.PreparaInserimento;//Usato solo in WIN
begin
  if SelezioneCollettiva then
  begin
    cdsT248.Close;
    cdsT248.CreateDataSet;
    cdsT248.Open;
  end;
end;*)

(*procedure TA124FPermessiSindacaliMW.PreparaInserimentoCollettivo;
begin
  DatiColl.Data:=DataSetInUso.FieldByName('DATA').AsDateTime;
  DatiColl.NumeroProt:=DataSetInUso.FieldByName('NUMERO_PROT').AsString;
  DatiColl.DataProt:=DataSetInUso.FieldByName('DATA_PROT').AsDateTime;
  DatiColl.Dalle:=DataSetInUso.FieldByName('DALLE').AsString;
  DatiColl.Alle:=DataSetInUso.FieldByName('ALLE').AsString;
  DatiColl.Ore:=DataSetInUso.FieldByName('ORE').AsString;
  DatiColl.TipoPermesso:=DataSetInUso.FieldByName('TIPO_PERMESSO').AsString;
  DatiColl.AbbatteCompetenze:=DataSetInUso.FieldByName('ABBATTE_COMPETENZE').AsString;
  DatiColl.CodSindacato:=DataSetInUso.FieldByName('COD_SINDACATO').AsString;
  DatiColl.CodOrganismo:=DataSetInUso.FieldByName('COD_ORGANISMO').AsString;
  DatiColl.Stato:=DataSetInUso.FieldByName('STATO').AsString;
  DatiColl.ProtModifica:=DataSetInUso.FieldByName('PROT_MODIFICA').AsString;
  DatiColl.DataModifica:=DataSetInUso.FieldByName('DATA_MODIFICA').AsDateTime;
end;*)

(*procedure TA124FPermessiSindacaliMW.InserisciPermesso;
begin
  with selT248 do
  begin
  //Inserimento in tabella per il dip.corrente del permesso salvato sul ClientDataSet
    Insert;
    FieldByName('PROGRESSIVO').AsInteger:=SelAnagrafe.FieldByName('Progressivo').AsInteger;
    FieldByName('DATA').AsDateTime:=DatiColl.Data;
    FieldByName('NUMERO_PROT').AsString:=DatiColl.NumeroProt;
    FieldByName('DATA_PROT').AsDateTime:=DatiColl.DataProt;
    FieldByName('DALLE').AsString:=DatiColl.Dalle;
    FieldByName('ALLE').AsString:=DatiColl.Alle;
    FieldByName('ORE').AsString:=DatiColl.Ore;
    FieldByName('TIPO_PERMESSO').AsString:=DatiColl.TipoPermesso;
    FieldByName('PROG_PERMESSO').AsInteger:=0;
    FieldByName('ABBATTE_COMPETENZE').AsString:=DatiColl.AbbatteCompetenze;
    FieldByName('COD_SINDACATO').AsString:=DatiColl.CodSindacato;
    FieldByName('COD_ORGANISMO').AsString:=DatiColl.CodOrganismo;
    FieldByName('STATO').AsString:=DatiColl.Stato;
    FieldByName('PROT_MODIFICA').AsString:=DatiColl.ProtModifica;
    FieldByName('DATA_MODIFICA').AsDateTime:=DatiColl.DataModifica;
  end;
end;*)

(*procedure TA124FPermessiSindacaliMW.CercaDip(Prog:Integer);
begin
  if Prog <> SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger then
    SelAnagrafe.SearchRecord('PROGRESSIVO',Prog,[srFromBeginning]);
  Nominativo:=SelAnagrafe.FieldByName('MATRICOLA').AsString + ' - ' + SelAnagrafe.FieldByName('COGNOME').AsString + ' ' + SelAnagrafe.FieldByName('NOME').AsString;
end;*)

procedure TA124FPermessiSindacaliMW.RecuperaNoGEDAP(DataDa,DataA:TDateTime;Organismo,Sindacato:String);
begin
  with selT248NoGEDAP do
  begin
    Close;
    SetVariable('DATAI',DataDa);
    SetVariable('DATAF',DataA);
    SetVariable('COD_ORGANISMO',Organismo);
    SetVariable('COD_SINDACATO',Sindacato);
    //Usato il MergeSelAnagrafe
    Open;
  end;
end;

procedure TA124FPermessiSindacaliMW.RecuperaPFP(DataDa, DataA: TDateTime);
begin
  with selT040PFP do
  begin
    Close;
    SetVariable('DATAI',DataDa);
    SetVariable('DATAF',DataA);
    Open;
  end;
end;

procedure TA124FPermessiSindacaliMW.selT248NoGEDAPCalcFields(DataSet: TDataSet);
begin
  inherited;
  selT248CalcFields(DataSet);
end;

procedure TA124FPermessiSindacaliMW.ImpostaPermessoSelInviato;
begin
  with selT248NoGEDAP do
  begin
    Edit;
    FieldByName('INSERITO_GEDAP').AsString:='S';
    Post;
    Refresh;
  end;
end;

procedure TA124FPermessiSindacaliMW.ImpostaTuttiPermessiInviati;
begin
  with selT248NoGEDAP do
  begin
    First;
    while not Eof do
    begin
      Edit;
      FieldByName('INSERITO_GEDAP').AsString:='S';
      Post;
      Next;
    end;
    Refresh;
    First;
  end;
end;

procedure TA124FPermessiSindacaliMW.ControlliGeneraXmlGEDAP;
var DescDatoAz,CampiEstratti:String;
    Tabella,Codice,Storico:String;
  procedure VerificaCampiEstratti(NomeDatoAz:String);
  begin
    selV430.Close;
    selV430.SetVariable('PROGRESSIVO',-1);
    selV430.SetVariable('DATA',EncodeDate(1900,1,1));
    selV430.SetVariable('CAMPIESTRATTI',CampiEstratti);
    try
      selV430.Open;
    except
      if NomeDatoAz = '' then
        raise Exception.Create(Format(A000MSG_A124_ERR_FMT_DATI_ANAGRAFICI,[selV430.SQL[0]]))
      else
        raise Exception.Create(Format(A000MSG_A124_ERR_FMT_DATO_AZIENDALE,[A000DescDatiEnte(NomeDatoAz)]));
    end;
  end;
begin
  //Username PerlaPA
  if Trim(Parametri.CampiRiferimento.C40_WebSrv_User) = '' then
    DescDatoAz:=A000DescDatiEnte('C40_WEBSRV_USER')
  //Password PerlaPA
  else if Trim(Parametri.CampiRiferimento.C40_WebSrv_Pwd) = '' then
    DescDatoAz:=A000DescDatiEnte('C40_WEBSRV_PWD')
  //Codice ente GEDAP
  else if Trim(Parametri.CampiRiferimento.C40_EnteGedap) = '' then
    DescDatoAz:=A000DescDatiEnte('C40_ENTEGEDAP')
  //URL GEDAP
  else if Trim(Parametri.CampiRiferimento.C40_WebSrv_URLGedap) = '' then
    DescDatoAz:=A000DescDatiEnte('C40_WEBSRV_URLGEDAP')
  //Qualifica GEDAP
  else if Trim(Parametri.CampiRiferimento.C40_Qualifica) = '' then
    DescDatoAz:=A000DescDatiEnte('C40_QUALIFICA')
  //Comune default GEDAP, se Indirizzo GEDAP indicato
  else if (Trim(Parametri.CampiRiferimento.C40_DistaccoSede_ComuneDef) = '')
  and (Trim(Parametri.CampiRiferimento.C40_DistaccoSede_Indirizzo) <> '') then
    DescDatoAz:=A000DescDatiEnte('C40_DISTACCOSEDE_COMUNEDEF');
  if DescDatoAz <> '' then
    raise Exception.Create(Format(A000MSG_A124_ERR_FMT_DATO_AZ_VUOTO,[DescDatoAz]));

  //Dati base
  CampiEstratti:='';
  VerificaCampiEstratti('');
  //Qualifica GEDAP
  CampiEstratti:=', T430' + Parametri.CampiRiferimento.C40_Qualifica + ' qualifica';
  VerificaCampiEstratti('C40_QUALIFICA');
  //Distaccamento GEDAP
  if Trim(Parametri.CampiRiferimento.C40_DistaccoSede_Indirizzo) <> '' then
  begin
    //Comune GEDAP, con default
    CampiEstratti:=CampiEstratti + ', ' + 'NVL('
                                         + IfThen(Trim(Parametri.CampiRiferimento.C40_DistaccoSede_Comune) = '','NULL','T430' + Parametri.CampiRiferimento.C40_DistaccoSede_Comune)
                                         + ',''' + Parametri.CampiRiferimento.C40_DistaccoSede_ComuneDef + ''') codcatastalesede';
    VerificaCampiEstratti('C40_DISTACCOSEDE_COMUNE');
    //Indirizzo GEDAP (se tabellare, prendo la descrizione)
    A000GetTabella(Parametri.CampiRiferimento.C40_DistaccoSede_Indirizzo,Tabella,Codice,Storico);
    CampiEstratti:=CampiEstratti + ', ' + 'T430' + IfThen(Tabella <> 'T430_STORICO','D_') + Parametri.CampiRiferimento.C40_DistaccoSede_Indirizzo + ' indirizzosede';
    VerificaCampiEstratti('C40_DISTACCOSEDE_INDIRIZZO');
  end;
end;

procedure TA124FPermessiSindacaliMW.WSGEDAP(DataSetWS:TOracleDataSet;InvioMassivo:Boolean);
var GEDAPPT:GEDAP;
    Req:wsdlRequest;
    Res:wsdlResponse;
    dPerm:(*Variant*)TXSDate;//Delphi non codifica il tipo AnySimpleType e lo trasforma in Variant, ma bisogna gestire il tipo Date.
    hIni,hFin:TXSTime;
    dip:dipendente;
    provv4:provvedimento4;
    provv5:provvedimento5;
    sogLeg:soggettoLegittimato;
    istPEMPROPNR:nuovoIstitutoPemProPnr_type;
    istPEMPNRRSU:nuovoIstitutoPemPnrRsu_type;
    //istAFP:nuovoIstitutoAfp_type;
    istPFP:nuovoIstitutoPfp_type;
    dCorr:TDateTime;
    NumOreGG:Integer;
    EsitoInvio:String;
    //PermOreTot, PermMinRes, Causale: Integer;
  function ControlloDatiObbligatoriWS(pSindacale:Boolean):Boolean;
  var iQualifica:Integer;
    function ControlloDatoObbligatorioWS(Valore,DescDato:String;DataPermesso:TDateTime = 0):Boolean;
    begin
      Result:=True;
      if Valore = '' then
      begin
        RegistraMsg.InserisciMessaggio('A',IfThen(DataPermesso = 0,Format(A000MSG_A124_ERR_FMT_CAMPO_VUOTO,[DescDato]),
                                                                   Format(A000MSG_A124_ERR_FMT_CAMPO_VUOTO_DATA,[DescDato,DateToStr(DataPermesso)])),
                                       '',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
        Result:=False;
      end;
    end;
  begin
    Result:=False;
    //Dati anagrafici del dipendente
    R180SetVariable(selV430,'PROGRESSIVO',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
    R180SetVariable(selV430,'DATA',DataSetWS.FieldByName('DATA').AsDateTime);
    selV430.Open;
    if not ControlloDatoObbligatorioWS(selV430.FieldByName('CODFISCALE').AsString,'Codice fiscale') then exit;
    if not ControlloDatoObbligatorioWS(selV430.FieldByName('COGNOME').AsString,'Cognome') then exit;
    if not ControlloDatoObbligatorioWS(selV430.FieldByName('NOME').AsString,'Nome') then exit;
    if not ControlloDatoObbligatorioWS(selV430.FieldByName('SESSO').AsString,'Sesso') then exit;
    if not ControlloDatoObbligatorioWS(selV430.FieldByName('DATANAS').AsString,'Data di nascita') then exit;
    if not ControlloDatoObbligatorioWS(selV430.FieldByName('CODCATASTALENAS').AsString,'Comune di nascita') then exit;
    if not ControlloDatoObbligatorioWS(selV430.FieldByName('qualifica').AsString,'Qualifica',DataSetWS.FieldByName('DATA').AsDateTime) then exit;
    try
      iQualifica:=StrToInt(selV430.FieldByName('qualifica').AsString);
    except
      RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_QUALIFICA_NUMERICA,[selV430.FieldByName('qualifica').AsString]),'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
      exit;
    end;
    //Controlli specifici dei permessi sindacali
    if pSindacale then
    begin
    //Non controllo i campi già obbligatori sulla tabella T248: Es. DATA_DA, DATA
      //Ore totali
      if not ControlloDatoObbligatorioWS(DataSetWS.FieldByName('ORE').AsString,'Ore tot.') then exit;
      //Data del provvedimento
      if not ControlloDatoObbligatorioWS(DataSetWS.FieldByName('DATA_PROT').AsString,'Data protocollo') then exit;
      //Codice ministeriale sindacato
      if DataSetWS.FieldByName('RSU').AsString = 'N' then
        if not ControlloDatoObbligatorioWS(DataSetWS.FieldByName('COD_MINISTERIALE').AsString,'Cod. ministeriale') then exit;
    end;
    Result:=True;
  end;
  procedure GeneraNuovoPermessoWS(DataPermesso:TDateTime;nOreFruite:Integer);
  var OraIni,OraFin:String;
  begin
    //DATI PER ISTITUTO
    //dataPermesso (PEM / PRO / PNR / PEM RSU / PNR RSU) - dataInizio, dataFine (FPE)
    dPerm:=TXSDate.Create;
    dPerm.AsDate:=DataPermesso;

    if DataSetWS = selT248NoGEDAP then
    begin //PERMESSI SINDACALI (PEM / PRO / PNR / PEM RSU / PNR RSU) --> oraInizio, orafine
      if not DataSetWS.FieldByName('DALLE').IsNull
      and not DataSetWS.FieldByName('ALLE').IsNull then
      begin
        OraIni:=DataSetWS.FieldByName('DALLE').AsString;
        OraFin:=DataSetWS.FieldByName('ALLE').AsString;
      end
      else
      begin
        OraIni:='08.00';
        OraFin:=R180MinutiOre(R180OreMinuti(OraIni) + nOreFruite);
      end;
      hIni:=TXSTime.Create;
      hIni.Hour:=StrToIntDef(Trim(Copy(OraIni,1,2)),0);
      hIni.Minute:=StrToIntDef(Trim(Copy(OraIni,4,2)),0);
      hIni.XSToNative(StringReplace(hIni.NativeToXS,'Z','',[]));//tolgo la 'Z' che sposterebbe l'orario avanti di un'ora
      hFin:=TXSTime.Create;
      hFin.Hour:=StrToIntDef(Trim(Copy(OraFin,1,2)),0);
      hFin.Minute:=StrToIntDef(Trim(Copy(OraFin,4,2)),0);
      hFin.XSToNative(StringReplace(hFin.NativeToXS,'Z','',[]));//tolgo la 'Z' che sposterebbe l'orario avanti di un'ora
    end;
    //else if DataSetWS = selT040PFP then
    {begin //PERMESSI FPE --> oreTotali, minutiResidui, Causale
      //if DataSetWS = selT040... Ore = nOreFuite div 60, Minuti = nOreFruite mod 60
      PermOreTot:=nOreFruite div 60;
      PermMinRes:=nOreFruite mod 60;
      Causale:=DataSetWS.FieldByName('CAUSALE_GEDAP').AsString;
    end;}
    //else if ... //ASPETTATIVE FPE --> dataInizio, dataFine, giorniTotali, Causale

    //DATI PER DIPENDENTE
    dip:=dipendente.Create;
    dip.codiceFiscale:=selV430.FieldByName('CODFISCALE').AsString;
    dip.cognome:=selV430.FieldByName('COGNOME').AsString;
    dip.nome:=selV430.FieldByName('NOME').AsString;
    dip.sesso:=sesso_type(IfThen(selV430.FieldByName('SESSO').AsString = 'M',0,1));
    dip.dataNascita:=TXSDate.Create;
    dip.dataNascita.AsDate:=selV430.FieldByName('DATANAS').AsDateTime;
    dip.comuneNascita:=selV430.FieldByName('CODCATASTALENAS').AsString;
    dip.qualifica:=TXSDecimal.Create;
    dip.qualifica.DecimalString:=selV430.FieldByName('qualifica').AsString;
    if Trim(Parametri.CampiRiferimento.C40_DistaccoSede_Indirizzo) <> '' then
      if not selV430.FieldByName('indirizzosede').IsNull then
      begin
        dip.distaccamento:=distaccamento.Create;
        dip.distaccamento.comune:=selV430.FieldByName('codcatastalesede').AsString;
        dip.distaccamento.indirizzo:=selV430.FieldByName('indirizzosede').AsString;
      end;
    if DataSetWS = selT248NoGEDAP then
    begin //PERMESSI SINDACALI
      //dati per Provvedimento
      if DataSetWS.FieldByName('RSU').AsString = 'N' then
      begin
        //PEM / PRO / PNR
        provv5:=provvedimento5.Create;
        provv5.data:=TXSDate.Create;
        provv5.data.AsDate:=DataSetWS.FieldByName('DATA_PROT').AsDateTime;
        provv5.numeroProtocollo:=DataSetWS.FieldByName('NUMERO_PROT').AsString;
      end
      else
      begin
        //PEM RSU / PNR RSU
        provv4:=provvedimento4.Create;
        provv4.data:=TXSDate.Create;
        provv4.data.AsDate:=DataSetWS.FieldByName('DATA_PROT').AsDateTime;
        provv4.numeroProtocollo:=DataSetWS.FieldByName('NUMERO_PROT').AsString;
      end;
      //dati per Soggetto legittimato
      if DataSetWS.FieldByName('RSU').AsString = 'N' then
      begin
        //PEM / PRO / PNR
        sogLeg:=soggettoLegittimato.Create;
        sogLeg.codiceFiscale:=DataSetWS.FieldByName('COD_MINISTERIALE').AsString;
      end;
    end;
  end;
  procedure AssegnaPermessoWS;
  begin
    //Creo l'istituto
    Req:=wsdlRequest.Create;
    Req.userName:=Parametri.CampiRiferimento.C40_WebSrv_User;                                 //TEST: 'WSTestFile';
    Req.pwd:=Parametri.CampiRiferimento.C40_WebSrv_Pwd;                                       //TEST: 'WSTestFile@Pass';
    Req.inserimentoIstituto:=inserimentoIstituto.Create;
    Req.inserimentoIstituto.codiceEnte:=StrToInt(Parametri.CampiRiferimento.C40_EnteGedap);   //TEST: 116149763;
    if DataSetWS = selT248NoGEDAP then
    begin //PEM / PRO / PNR / PEM RSU / PNR RSU
      if DataSetWS.FieldByName('RSU').AsString = 'N' then
      begin  //Non RSU
        istPEMPROPNR:=nuovoIstitutoPemProPnr_type.Create;
        //Istituto
        istPEMPROPNR.dataPermesso:=dPerm;
        istPEMPROPNR.oraInizio:=hIni;
        istPEMPROPNR.oraFine:=hFin;
        //Dipendente
        istPEMPROPNR.dipendente:=dip;
        //Provvedimento
        istPEMPROPNR.provvedimento:=provv5;
        //Soggetto legittimato
        istPEMPROPNR.soggettoLegittimato:=sogLeg;
        //Assegno l'istituto
        if DataSetWS.FieldByName('STATUTARIO').AsString = 'S' then
          //PRO: Permessi sind. Retrib. per le Riunioni di Organismi Direttivi Statutari
          Req.inserimentoIstituto.nuovoIstitutoPRO:=istPEMPROPNR
        else if DataSetWS.FieldByName('RETRIBUITO').AsString = 'S' then
          //PEM: Permessi sindacali Retribuiti per l'Espletamento del Mandato
          Req.inserimentoIstituto.nuovoIstitutoPEM:=istPEMPROPNR
        else
          //PNR: Permessi sindacali Non Retribuiti
          Req.inserimentoIstituto.nuovoIstitutoPNR:=istPEMPROPNR;
      end
      else
      begin  //RSU
        istPEMPNRRSU:=nuovoIstitutoPemPnrRsu_type.Create;
        //Istituto
        istPEMPNRRSU.dataPermesso:=dPerm;
        istPEMPNRRSU.oraInizio:=hIni;
        istPEMPNRRSU.oraFine:=hFin;
        //Dipendente
        istPEMPNRRSU.dipendente:=dip;
        //Provvedimento
        istPEMPNRRSU.provvedimento:=provv4;
        //Assegno l'istituto
        if DataSetWS.FieldByName('RETRIBUITO').AsString = 'S' then
          //PEM RSU: Permessi sindacali Retribuiti per l'Espletamento del Mandato RSU
          Req.inserimentoIstituto.nuovoIstitutoPEMRSU:=istPEMPNRRSU
        else
          //PNR RSU: Permessi sindacali Non Retribuiti RSU
          Req.inserimentoIstituto.nuovoIstitutoPNRRSU:=istPEMPNRRSU;
      end;
    end
    //Aspettative per Funzioni Pubbliche Elettive
    else if DataSetWS = selT040PFP then
    begin    //Permessi per funzioni pubbliche elettive
      //Istituto
      istPFP:=nuovoIstitutoPfp_type.Create;
      istPFP.dataInizio:=dPerm;     //Data inizio dell’istituto – Anno minimo = 2006
      istPFP.dataFine:=dPerm;       //Data fine dell’istituto – Anno minimo = 2006
      istPFP.oreTotali:=TXSDecimal.Create;      //Ore totali di permesso
      istPFP.oreTotali.DecimalString:=IntToStr(NumOreGG div 60);
      istPFP.minutiResidui:=TXSDecimal.Create;  //Minuti di permesso
      istPFP.minutiResidui.DecimalString:=IntToStr(NumOreGG mod 60);
      istPFP.causale:=TXSDecimal.Create;        //Codice tabella esterna
      istPFP.causale.DecimalString:=DataSetWS.FieldByName('CAUSALE_GEDAP').AsString;
      //Dipendente
      istPFP.dipendente:=dip;

      Req.inserimentoIstituto.nuovoIstitutoPFP:=istPFP;
    end;
    //else if... //ASPETTATIVE FPE
  end;
  procedure InserisciPermessoWS;
  begin
    try
      if (not IsLibrary) then
        CoInitialize(nil);
      try

        //Trace invio
        if assigned(Req.inserimentoIstituto.nuovoIstitutoPFP) then
        begin
          RegistraMsg.InserisciMessaggio('I', 'IstitutoPFP.dataInizio: ' + DateToStr(Req.inserimentoIstituto.nuovoIstitutoPFP.dataInizio.AsDate),'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
          RegistraMsg.InserisciMessaggio('I', 'IstitutoPFP.dataFine: ' + DateToStr(Req.inserimentoIstituto.nuovoIstitutoPFP.dataFine.AsDate),'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
          RegistraMsg.InserisciMessaggio('I', 'IstitutoPFP.oreTotali: ' + Req.inserimentoIstituto.nuovoIstitutoPFP.oreTotali.DecimalString,'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
          RegistraMsg.InserisciMessaggio('I', 'IstitutoPFP.minutiResidui: ' + Req.inserimentoIstituto.nuovoIstitutoPFP.minutiResidui.DecimalString,'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
          RegistraMsg.InserisciMessaggio('I', 'IstitutoPFP.Causale: ' + Req.inserimentoIstituto.nuovoIstitutoPFP.causale.DecimalString,'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
          RegistraMsg.InserisciMessaggio('I', 'IstitutoPFP.Dipendente.Qualifica: ' + Req.inserimentoIstituto.nuovoIstitutoPFP.dipendente.qualifica.DecimalString,'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
        end;

        Res:=GEDAPPT.InserimentoIstituti(Req);

        if Res <> nil then
        begin
          if Res.esitoInserimentoIstituto.esito = esito_type(0) then
          begin
            if EsitoInvio <> 'N' then //se almeno un giorno del permesso è andato in errore, non devo ignorarlo
              EsitoInvio:='S';
          end
          else
          begin
            EsitoInvio:='N';
            RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_ESITO_NEGATIVO_WS,[Res.esitoInserimentoIstituto.errori[0]]),'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
          end;
          FreeAndNil(Res);//.Free;//non deve stare nel finally, altrimenti va in access violation
        end;
      except
        on E:exception do
        begin
          EsitoInvio:='N';
          RegistraMsg.InserisciMessaggio('A',Format(A000MSG_A124_ERR_FMT_RICHIAMO_WS,[E.Message]),'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger);
        end;
      end;
    finally
      CoUninitialize;
      if Req <> nil then
        FreeAndNil(Req);//.Free;
    end;
  end;
begin
  GEDAPPT:=GetGEDAP(False,Parametri.CampiRiferimento.C40_WebSrv_URLGedap);
  while not DataSetWS.Eof do //scorro i permessi
  begin
    if ControlloDatiObbligatoriWS(DataSetWS = selT248NoGEDAP) then
    begin
      EsitoInvio:='';
      if DataSetWS = selT248NoGEDAP then
      begin //PERMESSI SINDACALI
        dCorr:=DataSetWS.FieldByName('DATA_DA').AsDateTime;
        while dCorr <= DataSetWS.FieldByName('DATA').AsDateTime do //scorro i giorni del permesso
        begin
          NumOreGG:=CalcolaNumOre(DataSetWS,dCorr,dCorr);
          if NumOreGG > 0 then
          begin
            GeneraNuovoPermessoWS(dCorr,NumOreGG);
            AssegnaPermessoWS;
            InserisciPermessoWS;
          end;
          dCorr:=dCorr + 1;
        end;
      end
      else if DataSetWS = selT040PFP then
      begin //PERMESSI FUNZIONI PUBBLICHE ELETTIVE
        dCorr:=DataSetWS.FieldByName('DATA').AsDateTime;
        NumOreGG:=CalcolaNumOreFP(DataSetWS,dCorr,dCorr);
        if NumOreGG > 0 then
        begin
          GeneraNuovoPermessoWS(dCorr,NumOreGG);
          AssegnaPermessoWS;
          InserisciPermessoWS;
        end;
      end;
      //else if DateSetWS = ...   //ASPETTATIVE FUNZIONI PUBBLICHE ELETTIVE

      if EsitoInvio = '' then //Non ho inviato nemmeno un giorno (NumOreGG sempre uguale a 0)
        RegistraMsg.InserisciMessaggio('A',A000MSG_A124_ERR_NO_CALCOLO_ORE_FRUITE,'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger)
      else if (EsitoInvio = 'S') and (DataSetWS = selT248NoGEDAP) then //Nessun giorno è andato in errore
      begin
        //Aggiorno il campo INSERITO_GEDAP
        updT248.SetVariable('ROWID','''' + DataSetWS.RowId + '''');
        updT248.Execute;
      end;
    end;
    if not InvioMassivo then
      Break
    else
      DataSetWS.Next;
  end;

  (*
  if DataSetWS = selT248NoGEDAP then
  begin  //GESTIONE PERMESSI SINDACALI
    GEDAPPT:=GetGEDAP(False,Parametri.CampiRiferimento.C40_WebSrv_URLGedap);
    while not DataSetWS.Eof do //scorro i permessi
    begin
      if ControlloDatiObbligatoriWS(DataSetWS = selT248NoGEDAP) then
      begin
        EsitoInvio:='';
        dCorr:=DataSetWS.FieldByName('DATA_DA').AsDateTime;
        while dCorr <= DataSetWS.FieldByName('DATA').AsDateTime do //scorro i giorni del permesso
        begin
          NumOreGG:=CalcolaNumOre(DataSetWS,dCorr,dCorr);
          if NumOreGG > 0 then
          begin
            GeneraNuovoPermessoWS(dCorr,NumOreGG);
            AssegnaPermessoWS;
            InserisciPermessoWS;
          end;
          dCorr:=dCorr + 1;
        end;
        if EsitoInvio = '' then //Non ho inviato nemmeno un giorno (NumOreGG sempre uguale a 0)
          RegistraMsg.InserisciMessaggio('A',A000MSG_A124_ERR_NO_CALCOLO_ORE_FRUITE,'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger)
        else if EsitoInvio = 'S' then //Nessun giorno è andato in errore
        begin
          //Aggiorno il campo INSERITO_GEDAP
          updT248.SetVariable('ROWID','''' + DataSetWS.RowId + '''');
          updT248.Execute;
        end;
      end;
      if not InvioMassivo then
        Break
      else
        DataSetWS.Next;
    end;
  end
  else if DataSetWS = selT040PFP then
  begin //GESTIONE PERMESSI PER FUNZIONI PUBBLICHE ELETTIVE
    GEDAPPT:=GetGEDAP(False,Parametri.CampiRiferimento.C40_WebSrv_URLGedap);
    while not DataSetWS.Eof do //scorro i permessi
    begin
      if ControlloDatiObbligatoriWS(DataSetWS = selT248NoGEDAP) then
      begin
        EsitoInvio:='';
        if DataSetWS.FieldByName('CAUSALE_GEDAP').AsString <> '' then
        begin
          dCorr:=DataSetWS.FieldByName('DATA').AsDateTime;
          {while dCorr <= DataSetWS.FieldByName('DATA').AsDateTime do //scorro i giorni del permesso
          begin}
            NumOreGG:=CalcolaNumOreFP(DataSetWS,dCorr,dCorr);
            if NumOreGG > 0 then
            begin
              GeneraNuovoPermessoWS(dCorr,NumOreGG);
              AssegnaPermessoWS;
              InserisciPermessoWS;
            end;
            {dCorr:=dCorr + 1;
          end;}
          if EsitoInvio = '' then //Non ho inviato nemmeno un giorno (NumOreGG sempre uguale a 0)
            RegistraMsg.InserisciMessaggio('A',A000MSG_A124_ERR_NO_CALCOLO_ORE_FRUITE,'',DataSetWS.FieldByName('PROGRESSIVO').AsInteger)
          else if EsitoInvio = 'S' then //Nessun giorno è andato in errore
          begin
            //Aggiorno il campo INSERITO_GEDAP
            updT248.SetVariable('ROWID','''' + DataSetWS.RowId + '''');
            updT248.Execute;
          end;
        end;
      end;
      if not InvioMassivo then
        Break
      else
        DataSetWS.Next;
    end;
  end;
  //else...  //GESTIONE ASPETTIVE PER FUNZIONI PUBBLICHE ELETTIVE
  *)

end;

end.
