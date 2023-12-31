
unit A126UBloccoRiepiloghiMW;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,Dialogs,
  DB, OracleData, R005UDataModuleMW, A000UMessaggi, A000UInterfaccia, A000UCostanti,
  A000USessione, C180FunzioniGenerali,Oracle;

type
  TA126FBloccoRiepiloghiMW = class(TR005FDataModuleMW)
    scrBloccaRiep: TOracleQuery;
    scrSbloccaRiep: TOracleQuery;
    selT195: TOracleDataSet;
    selT199: TOracleDataSet;
    scrT193: TOracleQuery;
    delT195Cassa: TOracleQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSelT180_Funzioni: TOracleDataset;
    FDaData, FAData: TDateTime;
  public
    function getLstRiepiloghi: TStringlist;
    procedure BloccoRiepiloghi(Progressivo: Integer; Lock: Boolean;
      Riepilogo: String);
    procedure GetCassaEffettiva(var CassaEffettiva: TDateTime; var Records: Integer);
    procedure GetCassaUtilizzata(var CassaUtilizzata: TDateTime; var Util: Boolean; CassaEffettiva: TDateTime);
    procedure DataCassaSuccessiva(CassaEffettiva: TDateTime);
    procedure DataCassaPrecedente;
    procedure AnnullaDataCassa;
    function DataCassaPresente: Boolean;
    procedure EliminaDataCassa;
    function MessaggioEliminaDataCassa: String;
    procedure ScriviLog(Blocco: Boolean;RiepiloghiSelezionati: String);
    function FilterT180:Boolean;
    procedure CalcFieldsT180;
    procedure SelAnagrafeFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    property SelT180_Funzioni:TOracleDataset read FSelT180_Funzioni write FSelT180_Funzioni;
    property DaData: TDateTime read FDaData write FDaData;
    property AData: TDateTime read FAData write FAData;
  end;

implementation

{$R *.dfm}

{ TA126FBloccoRiepiloghiMW }

procedure TA126FBloccoRiepiloghiMW.CalcFieldsT180;
begin
  with FSelT180_Funzioni do
  begin
    if FieldByName('RIEPILOGO').AsString = 'T040' then
      FieldByName('D_RIEPILOGO').AsString:='Giustificativi'
    else if FieldByName('RIEPILOGO').AsString = 'T080' then
      FieldByName('D_RIEPILOGO').AsString:='Pianificazione'
    else if FieldByName('RIEPILOGO').AsString = 'T081I' then
      FieldByName('D_RIEPILOGO').AsString:='Pianificazione iniziale'
    else if FieldByName('RIEPILOGO').AsString = 'T081C' then
      FieldByName('D_RIEPILOGO').AsString:='Pianificazione corrente'
    else if FieldByName('RIEPILOGO').AsString = 'T100' then
      FieldByName('D_RIEPILOGO').AsString:='Timbrature'
    else if FieldByName('RIEPILOGO').AsString = 'T070' then
      FieldByName('D_RIEPILOGO').AsString:='Scheda riepilogativa'
    else if FieldByName('RIEPILOGO').AsString = 'T077' then
      FieldByName('D_RIEPILOGO').AsString:='Dati atipici'
    else if FieldByName('RIEPILOGO').AsString = 'T071A' then
      FieldByName('D_RIEPILOGO').AsString:='Ore di assestamento'
    else if FieldByName('RIEPILOGO').AsString = 'T071S' then
      FieldByName('D_RIEPILOGO').AsString:='Liquidazione straordinario'
    else if FieldByName('RIEPILOGO').AsString = 'T074' then
      FieldByName('D_RIEPILOGO').AsString:='Liquidazione ore causalizzate'
    else if FieldByName('RIEPILOGO').AsString = 'T134' then
      FieldByName('D_RIEPILOGO').AsString:='Liquidazione ore anni prec.'
    else if FieldByName('RIEPILOGO').AsString = 'T195' then
      FieldByName('D_RIEPILOGO').AsString:='Scarico paghe'
    else if FieldByName('RIEPILOGO').AsString = 'T340' then
      FieldByName('D_RIEPILOGO').AsString:='ReperibilitÓ'
    else if FieldByName('RIEPILOGO').AsString = 'T380' then
      FieldByName('D_RIEPILOGO').AsString:='Pianificazione reperibilitÓ'
    else if FieldByName('RIEPILOGO').AsString = 'T410' then
      FieldByName('D_RIEPILOGO').AsString:='Pasti'
    else if FieldByName('RIEPILOGO').AsString = 'T370' then
      FieldByName('D_RIEPILOGO').AsString:='Timbrature mensa'
    else if FieldByName('RIEPILOGO').AsString = 'T375' then
      FieldByName('D_RIEPILOGO').AsString:='Accessi mensa'
    else if FieldByName('RIEPILOGO').AsString = 'T680' then
      FieldByName('D_RIEPILOGO').AsString:='Buoni pasto'
    else if FieldByName('RIEPILOGO').AsString = 'T690' then
      FieldByName('D_RIEPILOGO').AsString:='Acquisto buoni'
    else if FieldByName('RIEPILOGO').AsString = 'T762' then
      FieldByName('D_RIEPILOGO').AsString:='Incentivi'
    else if FieldByName('RIEPILOGO').AsString = 'T130' then
      FieldByName('D_RIEPILOGO').AsString:='Residui saldi'
    else if FieldByName('RIEPILOGO').AsString = 'T131' then
      FieldByName('D_RIEPILOGO').AsString:='Residui presenze'
    else if FieldByName('RIEPILOGO').AsString = 'T264' then
      FieldByName('D_RIEPILOGO').AsString:='Residui assenze'
    else if FieldByName('RIEPILOGO').AsString = 'T692' then
      FieldByName('D_RIEPILOGO').AsString:='Residuo buoni'
    else if FieldByName('RIEPILOGO').AsString = 'SG656' then
      FieldByName('D_RIEPILOGO').AsString:='Residuo crediti formativi'
    else if FieldByName('RIEPILOGO').AsString = 'T820' then
      FieldByName('D_RIEPILOGO').AsString:='Limiti individuali mensili'
    else if FieldByName('RIEPILOGO').AsString = 'T825' then
      FieldByName('D_RIEPILOGO').AsString:='Limiti individuali annuali'
    else if FieldByName('RIEPILOGO').AsString = 'M040' then
      FieldByName('D_RIEPILOGO').AsString:='Missioni'
    else if FieldByName('RIEPILOGO').AsString = 'T065' then
      FieldByName('D_RIEPILOGO').AsString:='Richieste liq. straordinario'
    else if FieldByName('RIEPILOGO').AsString = 'T860' then
      FieldByName('D_RIEPILOGO').AsString:='Validazione cartellini';
  end;
end;

procedure TA126FBloccoRiepiloghiMW.DataModuleCreate(Sender: TObject);
begin
  inherited;
  selT195.Open;
  selT199.Open;
end;

function TA126FBloccoRiepiloghiMW.FilterT180: Boolean;
begin
  Result:=VarToStr(SelAnagrafe.Lookup('PROGRESSIVO',FSelT180_Funzioni.FieldByName('PROGRESSIVO').AsInteger,'PROGRESSIVO')) <> '';
end;

function TA126FBloccoRiepiloghiMW.getLstRiepiloghi: TStringlist;
  procedure AddRiepilogo(Riepilogo:String);
  var i:Integer;
  begin
    if A000FiltroDizionario('SICUREZZA RIEPILOGHI',Riepilogo) then
      for i:=0 to High(lstRiepiloghi) do
        if Riepilogo = Trim(Copy(lstRiepiloghi[i],1,5)) then
        begin
          Result.Add(lstRiepiloghi[i]);
          Break;
        end;
  end;
begin
  Result:=TStringList.Create;
  //  if A000GetInibizioni('Funzione','OpenA004GiustifAssPres') = 'S' then
  if (A000GetInibizioni('Tag','2') = 'S') then
    AddRiepilogo('T040');
  //  if A000GetInibizioni('Funzione','OpenA025Pianif') = 'S' then
  if A000GetInibizioni('Tag','8') = 'S' then
    AddRiepilogo('T080');

  //Tabellone turni
  if A000GetInibizioni('Tag','24') = 'S' then
  begin
    AddRiepilogo('T081I');
    AddRiepilogo('T081C');
  end;

  //  if A000GetInibizioni('Funzione','OpenA023Timbrature') = 'S' then
  if A000GetInibizioni('Tag','7') = 'S' then
    AddRiepilogo('T100');

  //  if A000GetInibizioni('Funzione','OpenA029SchedaRiepil') = 'S' then
  if A000GetInibizioni('Tag','10') = 'S' then
  begin
    AddRiepilogo('T070');
    AddRiepilogo('T077');
    AddRiepilogo('T071A');
    AddRiepilogo('T071S');
    AddRiepilogo('T074');
  end;

  //  if A000GetInibizioni('Funzione','OpenA116LiquidazioneOreAnniPrec') = 'S' then
  if A000GetInibizioni('Tag','169') = 'S' then
    AddRiepilogo('T134');

  //Scarico paghe
  if A000GetInibizioni('Tag','13') = 'S' then
    AddRiepilogo('T195');

  //Libera professione
  if A000GetInibizioni('Tag','46') = 'S' then
    AddRiepilogo('T320');

  //Prestazioni aggiuntive
  if A000GetInibizioni('Tag','61') = 'S' then
    AddRiepilogo('T332');

  //  if (A000GetInibizioni('Funzione','OpenA043StampaRep') = 'S') or
  //     (A000GetInibizioni('Funzione','OpenA036TurniRep') = 'S') then
  if (A000GetInibizioni('Tag','19') = 'S') or
     (A000GetInibizioni('Tag','15') = 'S') then
  begin
    AddRiepilogo('T340');
    AddRiepilogo('T380');
  end;

  //  if (A000GetInibizioni('Funzione','OpenA049StampaPasti') = 'S') or
  //     (A000GetInibizioni('Funzione','OpenA048PastiMese') = 'S') then
  if (A000GetInibizioni('Tag','28') = 'S') or
     (A000GetInibizioni('Tag','29') = 'S') then
    AddRiepilogo('T410');

  //  if A000GetInibizioni('Funzione','OpenA047TimbMensa') = 'S' then
  if A000GetInibizioni('Tag','27') = 'S' then
  begin
    AddRiepilogo('T370');
    AddRiepilogo('T375');
  end;

  //  if (A000GetInibizioni('Funzione','OpenA074RiepilogoBuoni') = 'S') or
  //     (A000GetInibizioni('Funzione','OpenA072BuoniMese') = 'S') then
  if (A000GetInibizioni('Tag','36') = 'S') or
     (A000GetInibizioni('Tag','34') = 'S') then
    AddRiepilogo('T680');

  //  if A000GetInibizioni('Funzione','OpenA073AcquistoBuoni') = 'S' then
  if A000GetInibizioni('Tag','35') = 'S' then
    AddRiepilogo('T690');

  //  if (A000GetInibizioni('Funzione','OpenA167RegistraIncentivi') = 'S') or
  //     (A000GetInibizioni('Funzione','OpenA168IncentiviMaturati') = 'S') then
  if (A000GetInibizioni('Tag','39') = 'S') or
     (A000GetInibizioni('Tag','40') = 'S') then
    AddRiepilogo('T762');

  //  if (A000GetInibizioni('Funzione','OpenA030Residui') = 'S') then
  if A000GetInibizioni('Tag','11') = 'S' then
  begin
    AddRiepilogo('T130');
    AddRiepilogo('T131');
    AddRiepilogo('T264');
    AddRiepilogo('T692');
    AddRiepilogo('SG656');
  end;

  //  if A000GetInibizioni('Funzione','OpenA094LimitiStr') = 'S' then
  if A000GetInibizioni('Tag','43') = 'S' then
  begin
    AddRiepilogo('T820');
    AddRiepilogo('T825');
  end;

  //  if A000GetInibizioni('Funzione','OpenA100Missioni') = 'S' then
  if A000GetInibizioni('Tag','49') = 'S' then
    AddRiepilogo('M040');

  //  if A000GetInibizioni('Funzione','OpenA029SchedaRiepil') = 'S'  then
  if A000GetInibizioni('Tag','10') = 'S' then
    AddRiepilogo('T860');

  //Scioperi
  if A000GetInibizioni('Tag','21') = 'S' then
    AddRiepilogo('T250');
end;

procedure TA126FBloccoRiepiloghiMW.SelAnagrafeFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  try
    Accept:=(SelAnagrafe.FieldByName('T430FINE').AsDateTime >= R180InizioMese(FDaData)) or
            SelAnagrafe.FieldByName('T430FINE').IsNull or
            (SelAnagrafe.FieldByName('T430FINE').AsDateTime = 0);
    Accept:=Accept and (SelAnagrafe.FieldByName('T430INIZIO').AsDateTime <= R180FineMese(FAData));
  except
    Accept:=False;
  end;
end;

procedure TA126FBloccoRiepiloghiMW.AnnullaDataCassa;
begin
  RegistraLog.SettaProprieta('C','T199_DATACASSA',NomeOwner,nil,True);
  RegistraLog.InserisciDato('DATA_CASSA',selT199.FieldByName('DATA_CASSA').AsString,'');
  selT199.Delete;
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

procedure TA126FBloccoRiepiloghiMW.BloccoRiepiloghi(Progressivo:Integer; Lock:Boolean; Riepilogo:String);
begin
  Riepilogo:=Trim(Copy(Riepilogo,1,5));
  if Lock then  //LORENA 22/07/2004
    with scrBloccaRiep do
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DAL',FDaData);
      SetVariable('AL',FAData);
      SetVariable('RIEPILOGO',Riepilogo);
      Execute;
    end
  else
    with scrSbloccaRiep do
    begin
      SetVariable('PROGRESSIVO',Progressivo);
      SetVariable('DAL',FDaData);
      SetVariable('AL',FAData);
      SetVariable('RIEPILOGO',Riepilogo);
      Execute;
    end;
end;

procedure TA126FBloccoRiepiloghiMW.ScriviLog(Blocco: Boolean;RiepiloghiSelezionati:String);
begin
  if Blocco then
  begin
    RegistraLog.SettaProprieta('I','T180_DATIBLOCCATI',NomeOwner,nil,True);
    RegistraLog.InserisciDato('DAL-AL','',DateToStr(DaData) + '-' + DateToStr(AData));
    RegistraLog.InserisciDato('RIEPILOGO','',RiepiloghiSelezionati);
  end
  else
  begin
    RegistraLog.SettaProprieta('C','T180_DATIBLOCCATI',NomeOwner,nil,True);
    RegistraLog.InserisciDato('DAL-AL',DateToStr(DaData) + '-' + DateToStr(AData),'');
    RegistraLog.InserisciDato('RIEPILOGO',RiepiloghiSelezionati,'');
  end;
  RegistraLog.RegistraOperazione;
end;

procedure TA126FBloccoRiepiloghiMW.GetCassaEffettiva(var CassaEffettiva: TDateTime; var Records: Integer);
begin
  with selT195 do
  begin
    Refresh;
    if FieldByName('DC').IsNull then
    begin
      CassaEffettiva:=R180InizioMese(Date);
      Records:=0;
    end
    else
    begin
      CassaEffettiva:=R180InizioMese(FieldByName('DC').AsDateTime);
      Records:=FieldByName('TOT').AsInteger;
    end;
  end;
end;

procedure TA126FBloccoRiepiloghiMW.GetCassaUtilizzata(var CassaUtilizzata: TDateTime;var Util: Boolean; CassaEffettiva: TDateTime);
begin
  with selT199 do
  begin
    Refresh;
    if RecordCount = 0 then
    begin
      CassaUtilizzata:=CassaEffettiva;
      Util:=False;
    end
    else
    begin
      CassaUtilizzata:=R180InizioMese(Fields[0].AsDateTime);
      Util:=True;
    end;
  end;
end;

procedure TA126FBloccoRiepiloghiMW.DataCassaPrecedente;
begin
  with selT199 do
  begin
    Edit;
    FieldByName('DATA_CASSA').AsDateTime:=R180AddMesi(FieldByName('DATA_CASSA').AsDateTime,-1);
    Post;
    RegistraLog.SettaProprieta('M','T199_DATACASSA',NomeOwner,nil,True);
    RegistraLog.InserisciDato('DATA_CASSA',FieldByName('DATA_CASSA').AsString,DateToStr(R180AddMesi(FieldByName('DATA_CASSA').AsDateTime,+1)));
    RegistraLog.RegistraOperazione;
  end;
  with scrT193 do
  begin
    SetVariable('MESE',-1);
    Execute;
  end;
  SessioneOracle.Commit;
end;

function TA126FBloccoRiepiloghiMW.DataCassaPresente: Boolean;
begin
  Result:=selT199.RecordCount > 0;
end;

procedure TA126FBloccoRiepiloghiMW.EliminaDataCassa;
begin
  RegistraLog.SettaProprieta('C','T195_VOCIVARIABILI',NomeOwner,nil,True);
  with selT195 do
  begin
    RegistraLog.InserisciDato('DATA_CASSA',FieldByName('DC').AsString,'');
    RegistraLog.InserisciDato('DATARIF_DAL',FieldByName('DR1').AsString,'');
    RegistraLog.InserisciDato('DATARIF_AL',FieldByName('DR2').AsString,'');
    RegistraLog.InserisciDato('COUNT',FieldByName('TOT').AsString,'');
  end;

  delT195Cassa.Execute;
  RegistraLog.RegistraOperazione;
  SessioneOracle.Commit;
end;

function TA126FBloccoRiepiloghiMW.MessaggioEliminaDataCassa: String;
var
  MinDataRif,MaxDataCassa,MaxDataRif:String;
  Count195:Word;
begin
  with selT195 do
  begin
    Refresh;
    MinDataRif:=UpperCase(FormatDateTime('mmmm yyyy',FieldByName('DR1').AsDateTime));
    MaxDataRif:=UpperCase(FormatDateTime('mmmm yyyy',FieldByName('DR2').AsDateTime));
    MaxDataCassa:=UpperCase(FormatDateTime('mmmm yyyy',FieldByName('DC').AsDateTime));
    Count195:=FieldByName('TOT').AsInteger;
    Result:=Format(A000MSG_A126_DLG_FMT_ELIMINA_DATA_CASSA,[MaxDataCassa,MinDataRif,MaxDataRif,Count195]);
  end;
end;

procedure TA126FBloccoRiepiloghiMW.DataCassaSuccessiva(CassaEffettiva: TDateTime);
begin
  with selT199 do
  begin
    Refresh;
    Edit;
    if FieldByName('DATA_CASSA').AsDateTime < R180AddMesi(CassaEffettiva,-1) then
      FieldByName('DATA_CASSA').AsDateTime:=CassaEffettiva
    else
      FieldByName('DATA_CASSA').AsDateTime:=R180AddMesi(FieldByName('DATA_CASSA').AsDateTime,1);
    Post;
    RegistraLog.SettaProprieta('M','T199_DATACASSA',NomeOwner,nil,True);
    RegistraLog.InserisciDato('DATA_CASSA',DateToStr(R180AddMesi(FieldByName('DATA_CASSA').AsDateTime,-1)),FieldByName('DATA_CASSA').AsString);
    RegistraLog.RegistraOperazione;
  end;
  with scrT193 do
  begin
    SetVariable('MESE',1);
    Execute;
  end;
  SessioneOracle.Commit;
end;

end.
