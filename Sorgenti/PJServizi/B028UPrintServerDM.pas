unit B028UPrintServerDM;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, Forms, Messages, SysUtils, StrUtils, Math, Classes, ComServ, ComObj, VCLCom, DataBkr, Variants,
  DBClient, StdVcl, QRPDFFilt, DBXJSON, System.JSON, OracleData,Oracle, Printers, QRPrntr,
  A000USessione, A000UInterfaccia, A000UMessaggi, B028PPrintServer_COM_TLB,
  A000UCostanti, Vcl.Graphics;

type
  TB028PrintServer = class(TRemoteDataModule, IB028PrintServer)
  private
    procedure AperturaSessione(DBServer, Azienda, Operatore: String);
    procedure EreditaSelezioneAnagrafica(SelezioneAnagrafica: String);
    procedure SettaParametri(DatiUtente: WideString);
    procedure SettaDatiUtente(PDatiUtente: WideString; PForm: TForm);
  protected
    class procedure UpdateRegistry(Register: Boolean; const ClassID, ProgID: string); override;
    procedure ProvaStampa(const NomeFile: WideString); safecall;
    procedure PrintA040(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA042(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA043(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA045(const SelezioneAnagrafica, FileOutput, Operatore, Azienda, DBServer: WideString; const DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA047(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA049(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA051(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA058(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA059(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA061(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA065(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA068(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA074(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA077(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA081(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA083(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA090(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA092(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA104(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA105(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA116(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA145(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA167(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA202(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP077(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP273(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP283(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP314(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant); safecall;
    procedure PrintP500(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant); safecall;
    procedure PrintP700(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP710(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP715(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintS404(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintS715(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant); safecall;
    procedure PrintA097(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintS304(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintS203(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintA027(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintS201(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP690(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
    procedure PrintP461(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses
  B028UprovaStampa,
  C180FunzioniGenerali,
  C700USelezioneAnagrafe,
  A001UPasswordDtM1,
  A027UCarMen,
  A040UPianifRep,
  A040UInserimento,
  A040UDialogStampa,
  A040UPianifRepDtM1,
  A040UPianifRepDtM2,
  A040UStampa,
  A040UStampa2,
  A042UDialogStampa,
  A042UStampaPreAssDtM1,
  A042UGrafico,
  A043UDialogStampa,
  A045UDialogStampa,
  A047UTimbMensa,
  A047UDialogStampa,
  A047UTimbMensaDtM1,
  A049UDialogStampa,
  A049UStampaPastiDtM1,
  A051UTimbOrig,
  A051UTimbOrigDtM1,
  A058UPianifTurni,
  A058UPianifTurniDtM1,
  A059UContSquadre,
  A059UContSquadreDtM1,
  A061UDettAssenze,
  A065UStampaBudget,
  A068UTurniGior,
  A068UTurniGiorDtM1,
  A074URiepilogoBuoni,
  A074URiepilogoBuoniDtM1,
  A074URiepilogoBuoniMW,
  A077UGeneratoreStampe,
  A077UGeneratoreStampeDtM,
  A077UStampa,
  A081UTimbCausDtM1,
  A081UTimbCaus,
  A083UMsgElaborazioni,
  A083UMsgElaborazioniDtm,
  A083UStampa,
  A090UAssenzeAnno,
  A090UAssenzeAnnoDtM1,
  A092UStampaStorico,
  A092UStampaStoricoDtM1,
  A097UPianifLibProf,
  A097UPianifLibProfDtM1,
  A105UStoricoGiustificativi,
  A116ULiquidazioneOreAnniPrec,
  A104UStampaMissioniDtm1,
  A104UDialogStampa,
  A167URegistraIncentivi,
  A167URegistraIncentiviDtm,
  A145UComunicazioneVisiteFiscali,
  A145UComunicazioneVisiteFiscaliDtM,
  A202URapportiLavoro,
  A202URapportiLavoroDM,
  A202URapportiLavoroMW,
  P077UGeneratoreStampe,
  P077UGeneratoreStampeDtM,
  P077UStampa,
  P273UStampaStoricoRetribContr,
  P273UStampa,
  P273UStampaStoricoRetribContrDTM,
  P283UStampaPeriodiRetrib,
  P283UStampa,
  P283UStampaPeriodiRetribDTM,
  P314UStampaModelliTFR1,
  P314UStampa,
  P314UStampaModelliTFR1DTM,
  P461UImportazioneAssistSanitConvenz,
  P461UImportazioneAssistSanitConvenzDtM,
  P500UCalcoloCedolino,
  P500UCalcoloCedolinoDtm,
  P690UStampaFondi,
  P690UStampaFondiDtM,
  P700UDialogStampa,
  P700UStampaDettaglio,
  P700UStampaRaggr,
  P700URiepilogoMensileInpsDTM1,
  P710UDialogStampa,
  P710UStampa,
  P710URiepilogoAnnualeInailDTM1,
  P715UStampaCertificazioneUnica,
  P715UStampaCertificazioneUnicaDtm,
  S201UDistribuzioneOrganicoDtm,
  S201USelezioneAtti,
  S203UStampaPiantaOrganica,
  S203UStampaPiantaOrganicaDtm,
  S304URiepilogoIncarichi,
  S304URiepilogoIncarichiDtM,
  S404UStampaRischi,
  S715UDialogStampa,
  S715UStampaValutazioniDtM;

class procedure TB028PrintServer.UpdateRegistry(Register: Boolean; const ClassID, ProgID: string);
begin
  if Register then
  begin
    inherited UpdateRegistry(Register, ClassID, ProgID);
    EnableSocketTransport(ClassID);
    EnableWebTransport(ClassID);
  end else
  begin
    DisableSocketTransport(ClassID);
    DisableWebTransport(ClassID);
    inherited UpdateRegistry(Register, ClassID, ProgID);
  end;
end;

procedure TB028PrintServer.AperturaSessione(DBServer,Azienda, Operatore: String);
begin
  //Login al DB e recupero dati aziendali
  with TA001FPasswordDtM1.Create(nil) do
  try
    InizializzazioneSessione(DBServer);
    QI090.Close;
    QI090.SetVariable('Azienda',Azienda);
    QI090.Open;
    QI060.Close;
    QI060.SetVariable('Azienda',Azienda);
    QI060.SetVariable('Utente',Operatore);
    QI060.Open;
    QI070.Close;
    QI070.SetVariable('Azienda',Azienda);
    QI070.SetVariable('Utente',Operatore);
    QI070.Open;
    // bugfix.ini
    // ATTENZIONE al seguente caso
    //   - lo stesso "Operatore" è presente sia su Irisweb (I060) che su IrisWin (I070)
    //   - nel caso di accesso con operatore, l'operatore (corretto) veniva erroneamente sovrascritto con SYSMAN
    //if (QI060.RecordCount > 0) or (QI070.RecordCount = 0) then
    if QI070.RecordCount = 0 then
    // bugfix.fine
    begin
      QI070.Close;
      QI070.SetVariable('Azienda',Azienda);
      QI070.SetVariable('Utente','SYSMAN');
      QI070.Open;
    end;
    RegistraInibizioni;
    Parametri.Database:=DBServer;
  finally
    Free;
  end;
  SessioneOracle.LogonDataBase:=DBServer;
  try
    A000ParamDBOracle(SessioneOracle);
    RegistraMsg.IniziaMessaggio('B028');
  except
    on E:Exception do
      R180ScriviMsgLog('B028PPrintServer.log',E.Message);
  end;
  Parametri.Operatore:=Operatore;
end;

procedure TB028PrintServer.EreditaSelezioneAnagrafica(SelezioneAnagrafica: String);
var
  S: String;
  pS,pF,pO: Integer;
begin
  S:=SelezioneAnagrafica;
  //Massimo 21/11/2013 --ini - modifica per IrisWeb
  if S.IndexOf(':DATADAL') <> -1 then
    S:=ReplaceStr(S,':DATADAL',':C700DATADAL');
  if S.IndexOf(':C700DATADAL') <> -1 then
  begin
    C700SelAnagrafe.DeclareVariable('C700DATADAL',otDate);
    C700SelAnagrafe.SetVariable('C700DATADAL',C700DataDal);
  end;
  //Massimo 21/11/2013 --fine
  RegistraMsg.InserisciMessaggio('I','Selezione iniziale: ' + S);
  pF:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
  pS:=R180CercaParolaIntera('SELECT',UpperCase(S),'.,;');
  if (pF > 0) and (pS > 0) then
  begin
    pS:=pS + 7; // 'SELECT '
    C700DatiSelezionati:=Copy(S,pS,pF - pS - 1);
    C700DatiSelezionati:=StringReplace(C700DatiSelezionati,',V430.',',',[rfReplaceAll,rfIgnoreCase]);
    Delete(S,pS,pF - pS);
    C700DatiSelezionati:=C700CompletaDatiSelezionati;
    Insert(C700DatiSelezionati + ' ',S,pS);
  end
  else
    RegistraMsg.InserisciMessaggio('A','Selezione anagrafica errata: ' + S);
  RegistraMsg.InserisciMessaggio('I','Selezione finale: ' + S);
  C700SelAnagrafe.SQL.Text:=S;
  pF:=R180CercaParolaIntera('FROM',UpperCase(S),'.,;');
  if pF > 0 then
    S:=Trim(Copy(S,pF + 4,Length(S)));
  pO:=R180CercaParolaIntera('ORDER BY',UpperCase(S),'.,;');
  if pO > 0 then
    S:=Trim(Copy(S,1,pO - 1));
  C700FSelezioneAnagrafe.CorpoSQL.Text:=S;
end;

procedure TB028PrintServer.SettaParametri(DatiUtente: WideString);
var i:Integer;
    json: TJSONObject;
    jPairGiust: TJSONPair;
begin
  try
    json:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(DatiUtente),0) as TJSONObject;
    for i:=0 to json.Size - 1 do
    begin
      jPairGiust:=TJSONPair(json.Get(i));
      if jPairGiust.JsonString.Value = 'StandardPrinter' then
        Parametri.UseStandardPrinter:=jPairGiust.JsonValue.Value.ToUpper = 'S'
      else if jPairGiust.JsonString.Value = 'Parametri.Applicazione' then
        Parametri.Applicazione:=jPairGiust.JsonValue.Value;
    end;
  finally
    json.Free;
  end;
end;

procedure TB028PrintServer.SettaDatiUtente(PDatiUtente: WideString; PForm:TForm);
var i,j:Integer;
    json: TJSONObject;
    jPairGiust: TJSONPair;
begin
  try
    //json:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(PDatiUtente),0) as TJSONObject;
    json:=TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(PDatiUtente),0) as TJSONObject;
    for i:=0 to json.Size - 1 do
    begin
      jPairGiust:=TJSONPair(json.Get(i));
      if R180In(jPairGiust.JsonString.Value,['StandardPrinter','Parametri.Applicazione']) then
        Continue;
      //Casi eccezionali da gestire sulle singole classi
      //A027
      if (PForm is TA027FCarMen) and (jPairGiust.JsonString.Value = 'EDaData') then
        (PForm as TA027FCarMen).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA027FCarMen) and (jPairGiust.JsonString.Value = 'EAData') then
        (PForm as TA027FCarMen).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A040
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'CodTipologia') then
        A040FPianifRepDtM1.A040MW.CodTipologia:=jPairGiust.JsonValue.Value
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'edtAnno') then
        A040FPianifRep.EAnno.Value:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'edtMese') then
        A040FPianifRep.EMese.Value:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'cmbFontName') then
      begin
        A040FStampa.RepR.Font.Name:=jPairGiust.JsonValue.Value;
        A040FStampa2.QRep.Font.Name:=jPairGiust.JsonValue.Value;
      end
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'cmbFontSize') then
      begin
        A040FStampa.RepR.Font.Size:=StrToInt(jPairGiust.JsonValue.Value);
        A040FStampa2.QRep.Font.Size:=StrToInt(jPairGiust.JsonValue.Value);
      end
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'cmbOrientamentoPag') then
      begin
        if jPairGiust.JsonValue.Value = A040FPianifRepDtM1.A040MW.VERTICALE then
          A040FStampa2.QRep.Page.Orientation:=poPortrait
        else if jPairGiust.JsonValue.Value = A040FPianifRepDtM1.A040MW.ORIZZONTALE then
          A040FStampa2.QRep.Page.Orientation:=poLandScape;
      end
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'cmbFormatoPag') then
      begin
        if StrToInt(jPairGiust.JsonValue.Value) > 0  then
        begin
          A040FPianifRepDtM1.A040MW.PaperSizeStampa:=TQRPaperSize(StrToInt(jPairGiust.JsonValue.Value) - 1);
          A040FPianifRepDtM1.A040MW.PaperSizeStampa2:=TQRPaperSize(StrToInt(jPairGiust.JsonValue.Value) - 1);
        end;
      end
      //COMO_ASL - 2021/084 SVILUPPO#1
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'cmbFontTitoloSize') then
      begin
        A040FStampa2.LTitolo.Font.Size:=StrToInt(jPairGiust.JsonValue.Value);
      end
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'chkTitoloBold') then
      begin
        if jPairGiust.JSONValue.Value = 'S' then
          A040FStampa2.LTitolo.Font.Style:=A040FStampa2.LTitolo.Font.Style + [fsBold]
        else
          A040FStampa2.LTitolo.Font.Style:=A040FStampa2.LTitolo.Font.Style - [fsBold];
      end
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'chkTitoloUnderline') then
      begin
        if jPairGiust.JSONValue.Value = 'S' then
          A040FStampa2.LTitolo.Font.Style:=A040FStampa2.LTitolo.Font.Style + [fsUnderline]
        else
          A040FStampa2.LTitolo.Font.Style:=A040FStampa2.LTitolo.Font.Style - [fsUnderline];
      end
      else if (PForm is TA040FDialogStampa) and (jPairGiust.JsonString.Value = 'rgpCampoDettaglio') then
        A040FPianifRepDtM1.A040MW.RecapitoAlternativo:=jPairGiust.JSONValue.Value = '1'
      //COMO_ASL - 2021/084 SVILUPPO#1 - fine
    //A042
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'LstIntestazione') then
        R180PutCheckList(jPairGiust.JsonValue.Value,40,(PForm as TA042FDialogStampa).chkLIntestazione)
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'LstDettaglio') then
        R180PutCheckList(jPairGiust.JsonValue.Value,40,(PForm as TA042FDialogStampa).chkLDettaglio)
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'chkVisLineeV') then
        (PForm as TA042FDialogStampa).VisualizzaVLine:=jPairGiust.JSONValue.Value = 'S'
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'chkVisLineeH') then
        (PForm as TA042FDialogStampa).VisualizzaHLine:=jPairGiust.JSONValue.Value = 'S'
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'edtTitoloGrafico') then
        (PForm as TA042FDialogStampa).TitoloGrafico:=jPairGiust.JSONValue.Value
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'edtDaData') then
        (PForm as TA042FDialogStampa).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'edtAData') then
        (PForm as TA042FDialogStampa).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'edtGGContinuativi') then
        (PForm as TA042FDialogStampa).edtGGContinuativi.Text:=jPairGiust.JsonValue.Value
      //A043
      else if (PForm is TA043FDialogStampa) and (jPairGiust.JsonString.Value = 'SoloAgg') then
        (PForm as TA043FDialogStampa).SoloAgg:=jPairGiust.JsonValue.Value
      else if (PForm is TA043FDialogStampa) and (jPairGiust.JsonString.Value = 'edtDataDa') then
        (PForm as TA043FDialogStampa).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA043FDialogStampa) and (jPairGiust.JsonString.Value = 'edtDataA') then
        (PForm as TA043FDialogStampa).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A045
      else if (PForm is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'LstListaCausali') then
        R180PutCheckList(jPairGiust.JsonValue.Value,6,(PForm as TA045FDialogStampa).LstListaCausali)
      else if (PForm is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'LstListaTipiRapporto') then
        R180PutCheckList(jPairGiust.JsonValue.Value,6,(PForm as TA045FDialogStampa).LstListaTipiRapporto)
      else if (PForm is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'edtDaData') then
        (PForm as TA045FDialogStampa).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'edtAData') then
        (PForm as TA045FDialogStampa).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A047
      else if (PForm is TA047FDialogStampa) and (jPairGiust.JsonString.Value = 'LstOrologi') then
        R180PutCheckList(jPairGiust.JsonValue.Value,2,(PForm as TA047FDialogStampa).cbxOrologi)
      //A049
      else if (PForm is TA049FDialogStampa) and (jPairGiust.JsonString.Value = 'edtInizio') then
        (PForm as TA049FDialogStampa).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA049FDialogStampa) and (jPairGiust.JsonString.Value = 'edtFine') then
        (PForm as TA049FDialogStampa).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA049FDialogStampa) and (jPairGiust.JsonString.Value = 'FiltroRilevatori') then
        (PForm as TA049FDialogStampa).FiltroRilevatori:=jPairGiust.JsonValue.Value
      //A051
      else if  (PForm is TA051FTimbOrig) and (jPairGiust.JsonString.Value = 'cmbMese') then
        (PForm as TA051FTimbOrig).cmbMese.ItemIndex:=StrToInt(jPairGiust.JsonValue.Value) // necessario perchè tra web e win qua gli itemindex sono disallineati
      //A058
      else if (PForm is TA058FPianifTurni) and (jPairGiust.JsonString.Value = 'edtDataDa') then
        (PForm as TA058FPianifTurni).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA058FPianifTurni) and (jPairGiust.JsonString.Value = 'edtDataA') then
        (PForm as TA058FPianifTurni).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A059
      else if  (PForm is TA059FContSquadre) and (jPairGiust.JsonString.Value = 'edtDataDa') then
        (PForm as TA059FContSquadre).DataInizio:=StrToDateTime(jPairGiust.JsonValue.Value)
      else if  (PForm is TA059FContSquadre) and (jPairGiust.JsonString.Value = 'edtDataA') then
        (PForm as TA059FContSquadre).DataFine:=StrToDateTime(jPairGiust.JsonValue.Value)
      //A061
      else if (PForm is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'LstCausali') then
        R180PutCheckList(jPairGiust.JsonValue.Value,6,(PForm as TA061FDettAssenze).LstCausali)
      else if (PForm is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'LstCodAcc') then
        R180PutCheckList(jPairGiust.JsonValue.Value,6,(PForm as TA061FDettAssenze).LstCodAcc)
      else if (PForm is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'edtDaData') then
        (PForm as TA061FDettAssenze).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'edtAData') then
        (PForm as TA061FDettAssenze).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'edtDaRegStamp') then
        (PForm as TA061FDettAssenze).frmInputPeriodoRegStamp.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'edtARegStamp') then
        (PForm as TA061FDettAssenze).frmInputPeriodoRegStamp.edtFine.Text:=jPairGiust.JsonValue.Value
      //A065
      else if (PForm is TA065FStampaBudget) and (jPairGiust.JsonString.Value = 'cmbDaMese') then
        (PForm as TA065FStampaBudget).cmbDaMese.ItemIndex:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TA065FStampaBudget) and (jPairGiust.JsonString.Value = 'cmbAMese') then
        (PForm as TA065FStampaBudget).cmbAMese.ItemIndex:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TA065FStampaBudget) and (jPairGiust.JsonString.Value = 'clbGruppi') then
        R180PutCheckList(jPairGiust.JsonValue.Value,22,(PForm as TA065FStampaBudget).clbGruppi)
      //A068
      else if  (PForm is TA068FTurniGior) and (jPairGiust.JsonString.Value = 'edtData') then
        (PForm as TA068FTurniGior).Data:=StrToDateTime(jPairGiust.JsonValue.Value)
      //A074
      else if (PForm is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'edtPwdFileSequenziale') then
        (PForm as TA074FRiepilogoBuoni).FsPassword:=jPairGiust.JsonValue.Value
      else if (PForm is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'ActiveTab') then
        (PForm as TA074FRiepilogoBuoni).PageControl1.ActivePageIndex:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'edtDa') then
        (PForm as TA074FRiepilogoBuoni).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'edtA') then
        (PForm as TA074FRiepilogoBuoni).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A077
      else if (PForm is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'edtDal') then
        (PForm as TA077FGeneratoreStampe).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'edtAl') then
        (PForm as TA077FGeneratoreStampe).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'CodiceStampa') then
        A077FGeneratoreStampeDtM.Q910.SearchRecord('CODICE',jPairGiust.JsonValue.Value,[srFromBeginning])
      else if (PForm is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'GeneraTabellaOnly') then
        A077FGeneratoreStampeDtM.GeneraTabellaOnly:=jPairGiust.JsonValue.Value = 'S'
      else if (PForm is TA077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'DropTabelleTemp') then
        A077FGeneratoreStampe.DropTabelleTemp:=jPairGiust.JsonValue.Value = 'S'
      //A081
      else if (PForm is TA081FTimbCaus) and (jPairGiust.JsonString.Value = 'CgpListaCausali') then
        R180PutCheckList(jPairGiust.JsonValue.Value,5,(PForm as TA081FTimbCaus).CgpListaCausali)
      else if (PForm is TA081FTimbCaus) and (jPairGiust.JsonString.Value = 'edtDaData') then
        (PForm as TA081FTimbCaus).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA081FTimbCaus) and (jPairGiust.JsonString.Value = 'edtAData') then
        (PForm as TA081FTimbCaus).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A083
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'sApplicazione') then
        A083FMsgElaborazioniDtM.A083MW.sApplicazione:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'sAziendeChecked') then
        A083FMsgElaborazioniDtM.A083MW.sAziendeChecked:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'sOperatoriChecked') then
        A083FMsgElaborazioniDtM.A083MW.sOperatoriChecked:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'sMaschereChecked') then
        A083FMsgElaborazioniDtM.A083MW.sMaschereChecked:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'sOperazioniChecked') then
        A083FMsgElaborazioniDtM.A083MW.sOperazioniChecked:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'sCampiChecked') then
        A083FMsgElaborazioniDtM.A083MW.sCampiChecked:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'sTestoMsg') then
        A083FMsgElaborazioniDtM.A083MW.sTestoMsg:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'msgID') then
        A083FMsgElaborazioniDtM.A083MW.msgID:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'edtDataDa') then
        (PForm as TA083FMsgElaborazioni).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA083FMsgElaborazioni) and (jPairGiust.JsonString.Value = 'edtDataA') then
        (PForm as TA083FMsgElaborazioni).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A090
      else if (PForm is TA090FAssenzeAnno) and (jPairGiust.JsonString.Value = 'CgpListaAnagr') then
        R180PutCheckList(jPairGiust.JsonValue.Value,50,(PForm as TA090FAssenzeAnno).ListaAnagra)
      else if (PForm is TA090FAssenzeAnno) and (jPairGiust.JsonString.Value = 'CgpListaCausali') then
        R180PutCheckList(jPairGiust.JsonValue.Value,5,(PForm as TA090FAssenzeAnno).ListaCausali)
      //A092
      else if (PForm is TA092FStampaStorico) and (jPairGiust.JsonString.Value = 'CgpAnagra') then
        R180PutCheckList(jPairGiust.JsonValue.Value,40,(PForm as TA092FStampaStorico).ListaAnagra)
      else if (PForm is TA092FStampaStorico) and (jPairGiust.JsonString.Value = 'edtDaData') then
        (PForm as TA092FStampaStorico).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA092FStampaStorico) and (jPairGiust.JsonString.Value = 'edtAData') then
        (PForm as TA092FStampaStorico).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A104
      else if (PForm is TA104FDialogStampa) and (jPairGiust.JsonString.Value = 'TXT') then
        (PForm as TA104FDialogStampa).StampaTXT:=jPairGiust.JsonValue.Value = 'S'
      //A105
      else if  (PForm is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'StatoPaghe') then
        (PForm as TA105FStoricoGiustificativi).A105MW.StatoPaghe:=jPairGiust.JsonValue.Value
      else if (PForm is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'clbCausali') then
        R180PutCheckList(jPairGiust.JsonValue.Value,5,(PForm as TA105FStoricoGiustificativi).clbCausali)
      else if (PForm is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'edtDaData') then
        (PForm as TA105FStoricoGiustificativi).frmInputPeriodoS.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'edtAData') then
        (PForm as TA105FStoricoGiustificativi).frmInputPeriodoS.edtFine.Text:=jPairGiust.JsonValue.Value
      //A116
      else if  (PForm is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'SoloAgg') then
        (PForm as TA116FLiquidazioneOreAnniPrec).SoloAgg:=jPairGiust.JsonValue.Value
      else if (PForm is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'cgpIntestazione') then
        R180PutCheckList(jPairGiust.JsonValue.Value,99,(PForm as TA116FLiquidazioneOreAnniPrec).clbIntestazione)
      else if (PForm is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'cgpDettaglio') then
        R180PutCheckList(jPairGiust.JsonValue.Value,99,(PForm as TA116FLiquidazioneOreAnniPrec).clbDettaglio)
      //A145
      else if (PForm is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'edtDataDa') then
        (PForm as TA145FComunicazioneVisiteFiscali).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'edtDataA') then
        (PForm as TA145FComunicazioneVisiteFiscali).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      //A167
      else if (PForm is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'edtDaData') then
        (PForm as TA167FRegistraIncentivi).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'edtAData') then
      begin
        (PForm as TA167FRegistraIncentivi).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value;
        (PForm as TA167FRegistraIncentivi).ImpostaDataQuote;
        (PForm as TA167FRegistraIncentivi).CaricaComboTipoCalcolo;
      end
      else if (PForm is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'cmbTipoCalcolo') then
      begin
        //la combo deve già essere caricata, ovvero edtAData settato prima di cmbTipoCalcolo
        for j:=0 to (PForm as TA167FRegistraIncentivi).cmbTipoCalcolo.Items.Count - 1 do
          if Copy((PForm as TA167FRegistraIncentivi).cmbTipoCalcolo.Items[j],1,1) = jPairGiust.JsonValue.Value then
            (PForm as TA167FRegistraIncentivi).cmbTipoCalcolo.ItemIndex:=j;
        (PForm as TA167FRegistraIncentivi).CambiaCalcolo;
      end
      else if (PForm is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'cmbCampoAnag') then
        (PForm as TA167FRegistraIncentivi).dcmbCampoAnag.KeyValue:=jPairGiust.JsonValue.Value
      else if (PForm is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'cgpColonne') then
      begin
        R180PutCheckList(jPairGiust.JsonValue.Value,99,(PForm as TA167FRegistraIncentivi).chkColonne);
        (PForm as TA167FRegistraIncentivi).chkColonneClickCheck(nil);
      end
      else if  (PForm is TA167FRegistraIncentivi) and (jPairGiust.JsonString.Value = 'SoloAgg') then
        (PForm as TA167FRegistraIncentivi).SoloAgg:=jPairGiust.JsonValue.Value
      //A145
      else if  (PForm is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'cmbMedicineLegali') then
        (PForm as TA145FComunicazioneVisiteFiscali).dcmbMedicineLegali.KeyValue:=jPairGiust.JsonValue.Value
      else if  (PForm is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'lstElementiDettaglio') then
        (PForm as TA145FComunicazioneVisiteFiscali).lstElementiDettaglioCOM.CommaText:=jPairGiust.JsonValue.Value
      //A202
      else if  (PForm is TA202FRapportiLavoro) and (jPairGiust.JsonString.Value = 'StampaDal') then
        A202FRapportiLavoroDM.A202MW.DataIReport:=StrToDateTime(jPairGiust.JSONValue.Value)
      else if  (PForm is TA202FRapportiLavoro) and (jPairGiust.JsonString.Value = 'StampaAl') then
        A202FRapportiLavoroDM.A202MW.DataFReport:=StrToDateTime(jPairGiust.JSONValue.Value)
      //S404
      else if (PForm is TS404FStampaRischi) and (jPairGiust.JsonString.Value = 'chkLIntestazione') then
      begin
        R180PutCheckList(jPairGiust.JsonValue.Value,99,(PForm as TS404FStampaRischi).chkLIntestazione);
        (PForm as TS404FStampaRischi).chkLIntestazioneClick(nil);
      end
      else if (PForm is TS404FStampaRischi) and (jPairGiust.JsonString.Value = 'chkLDettaglio') then
      begin
        R180PutCheckList(jPairGiust.JsonValue.Value,99,(PForm as TS404FStampaRischi).chkLDettaglio);
        (PForm as TS404FStampaRischi).chkLDettaglioClick(nil);
      end
      //S715
      else if  (PForm is TS715FDialogStampa) and (jPairGiust.JsonString.Value = 'ListaTipologieQuote') then
        (PForm as TS715FDialogStampa).ListaTipologieQuote:=jPairGiust.JsonValue.Value
      //P077
      else if (PForm is TP077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'edtDal') then
        (PForm as TP077FGeneratoreStampe).frmInputPeriodo.edtInizio.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TP077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'edtAl') then
        (PForm as TP077FGeneratoreStampe).frmInputPeriodo.edtFine.Text:=jPairGiust.JsonValue.Value
      else if (PForm is TP077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'CodiceStampa') then
        P077FGeneratoreStampeDtM.Q910.SearchRecord('CODICE',jPairGiust.JsonValue.Value,[srFromBeginning])
      else if (PForm is TP077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'DropTabelleTemp') then
        (PForm as TP077FGeneratoreStampe).DropTabelleTemp:=jPairGiust.JsonValue.Value = 'S'
      else if (PForm is TP077FGeneratoreStampe) and (jPairGiust.JsonString.Value = 'GeneraTabellaOnly') then
        P077FGeneratoreStampeDtM.GeneraTabellaOnly:=jPairGiust.JsonValue.Value = 'S'
      //P461
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'sCodCausaleRecupero1') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.sCodCausaleRecupero1:=jPairGiust.JsonValue.Value
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'sCodCausaleRecupero2') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.sCodCausaleRecupero2:=jPairGiust.JsonValue.Value
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'sCodCausaleRecupero3') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.sCodCausaleRecupero3:=jPairGiust.JsonValue.Value
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'iMaxMesiRecupero1') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.iMaxMesiRecupero1:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'iMaxMesiRecupero2') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.iMaxMesiRecupero2:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'iMaxMesiRecupero3') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.iMaxMesiRecupero3:=StrToInt(jPairGiust.JsonValue.Value)
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'bStampaIndirizzo') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.bStampaIndirizzo:=jPairGiust.JsonValue.Value = 'S'
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'bStampaSedeServizio') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.bStampaSedeServizio:=jPairGiust.JsonValue.Value = 'S'
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'bStampaSoloPrimaPagina') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.bStampaSoloPrimaPagina:=jPairGiust.JsonValue.Value = 'S'
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'bStampaSoloTotali') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.bStampaSoloTotali:=jPairGiust.JsonValue.Value = 'S'
      else if (PForm is TP461FImportazioneAssistSanitConvenz) and (jPairGiust.JsonString.Value = 'iDistanzaIndirizzoDaTitolo') then
        P461FImportazioneAssistSanitConvenzDtm.P461MW.ParametriElaborazione.iDistanzaIndirizzoDaTitolo:=StrToInt(jPairGiust.JsonValue.Value)
      //P690
      else if (PForm is TP690FStampaFondi) and (jPairGiust.JsonString.Value = 'ListaFondiSel') then
        (PForm as TP690FStampaFondi).ListaFondiSel:=jPairGiust.JsonValue.Value
      //P700
      else if (PForm is TP700FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciInpsSelezionati') then
        P700FRiepilogoMensileInpsDTM1.P700MW.sPv_CodiciINPSSelezionati:=jPairGiust.JsonValue.Value
      else if (PForm is TP700FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciInpsDeSelezionati') then
        P700FRiepilogoMensileInpsDTM1.P700MW.sPv_CodiciINPSDeSelezionati:=jPairGiust.JsonValue.Value
      else if (PForm is TP700FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciDM10Selezionati') then
        P700FRiepilogoMensileInpsDTM1.P700MW.sPv_CodiciDM10Selezionati:=jPairGiust.JsonValue.Value
      else if (PForm is TP700FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciDM10DeSelezionati') then
        P700FRiepilogoMensileInpsDTM1.P700MW.sPv_CodiciDM10DeSelezionati:=jPairGiust.JsonValue.Value
      //P710
      else if (PForm is TP710FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciINAILSelezionati') then
        P710FRiepilogoAnnualeInailDTM1.P710MW.sPv_CodiciINAILSelezionati:=jPairGiust.JsonValue.Value
      else if (PForm is TP710FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciINAILDeSelezionati') then
        P710FRiepilogoAnnualeInailDTM1.P710MW.sPv_CodiciINAILDeSelezionati:=jPairGiust.JsonValue.Value
      else if (PForm is TP710FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciPosizioniSelezionati') then
        P710FRiepilogoAnnualeInailDTM1.P710MW.sPv_CodiciPosizioniSelezionati:=jPairGiust.JsonValue.Value
      else if (PForm is TP710FDialogStampa) and (jPairGiust.JsonString.Value = 'sPv_CodiciPosizioniDeSelezionati') then
        P710FRiepilogoAnnualeInailDTM1.P710MW.sPv_CodiciPosizioniDeSelezionati:=jPairGiust.JsonValue.Value
      //P273
      else if (PForm is TP273FStampaStoricoRetribContr) and (jPairGiust.JsonString.Value = 'filtro') then
        P273FStampaStoricoRetribContrDTM.P273MW.sFiltro:=jPairGiust.JsonValue.Value
      //P283
      else if (PForm is TP283FStampaPeriodiRetrib) and (jPairGiust.JsonString.Value = 'filtro') then
        P283FStampaPeriodiRetribDTM.P283MW.sFiltro:=jPairGiust.JsonValue.Value
      //S304
      else if (PForm is TS304FRiepilogoIncarichi) and (jPairGiust.JsonString.Value = 'sCodice') then
        S304FRiepilogoIncarichiDtM.selSG307.SearchRecord('CODICE',jPairGiust.JsonValue.Value,[srFromBeginning])
      //S203
      else if (PForm is TS203FStampaPiantaOrganica) and (jPairGiust.JsonString.Value = 'CodiceStampa') then
        S203FStampaPiantaOrganicaDtM.selSG508.SearchRecord('CODICE',jPairGiust.JsonValue.Value,[srFromBeginning])
      else if (PForm is TS203FStampaPiantaOrganica) and (jPairGiust.JsonString.Value = 'C700SqlCreato') then
        C700FSelezioneAnagrafe.SQLCreato.Text:=jPairGiust.JsonValue.Value
      //S201
      else if (PForm is TS201FSelezioneAtti) and (jPairGiust.JsonString.Value = 'DataInizio') then
        (PForm as TS201FSelezioneAtti).DataInizio:=StrToDateTime(jPairGiust.JSONValue.Value)
      else if (PForm is TS201FSelezioneAtti) and (jPairGiust.JsonString.Value = 'DataFine') then
        (PForm as TS201FSelezioneAtti).DataFine:=StrToDateTime(jPairGiust.JSONValue.Value)
      else if (PForm is TS201FSelezioneAtti) and (jPairGiust.JsonString.Value = 'StrutturaVisualizzazione') then
        (PForm as TS201FSelezioneAtti).StrutturaVisualizzazione:=jPairGiust.JSONValue.Value
      else if (PForm is TS201FSelezioneAtti) and (jPairGiust.JsonString.Value = 'LstAttiPrevisti') then
        (PForm as TS201FSelezioneAtti).LstAttiPrevisti:=jPairGiust.JSONValue.Value
      else if (PForm is TS201FSelezioneAtti) and (jPairGiust.JsonString.Value = 'LstAttiCopertura') then
        (PForm as TS201FSelezioneAtti).LstAttiCopertura:=jPairGiust.JSONValue.Value
      else if (PForm is TS201FSelezioneAtti) and (jPairGiust.JsonString.Value = 'chkNumPostiVal') then
        (PForm as TS201FSelezioneAtti).chkNumPostiVal.Checked:=jPairGiust.JSONValue.Value = 'S'
      //Se il componente non è gestito tra i casi particolari allora provo ad abbinarlo automaticamente
      else if PForm.FindComponent(jPairGiust.JsonString.Value) <> nil then
        R180JsonString2Comp(PForm.FindComponent(jPairGiust.JsonString.Value),jPairGiust)
      else
        raise Exception.Create('Componente inesistente: ' + jPairGiust.JsonString.Value);
    end;
  finally
    json.Free;
  end;
end;

procedure TB028PrintServer.ProvaStampa(const NomeFile: WideString);
begin
  with TB028FProvaStampa.Create(nil) do
  try
    QuickRep1.ShowProgress:=False;
    QuickRep1.ExportToFilter(TQRPDFDocumentFilter.Create(NomeFile));
  finally
    Free;
  end;
end;

procedure TB028PrintServer.PrintA045(const SelezioneAnagrafica, FileOutput, Operatore, Azienda, DBServer: WideString; const DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A045FDialogStampa:=TA045FDialogStampa.Create(nil);
  try
    A045FDialogStampa.DocumentoOutput:=IfThen(FileOutput <> '',FileOutput,'<VUOTO>');
    A045FDialogStampa.A045MW.TipoModulo:='COM';
    A045FDialogStampa.FormShow(A045FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Inizializzo form
    A045FDialogStampa.chkAnteprima.Checked:=True;
    A045FDialogStampa.chkElabora.Checked:=False;
    A045FDialogStampa.PopolaListaQualifiche;
    A045FDialogStampa.PopolaListaTipiRapporto;

    //Leggo i dati inseriti dall'utente web e li setto su  A045FDialogStampa
    SettaDatiUtente(DatiUtente,A045FDialogStampa);

    //Creo File stampa
    A045FDialogStampa.btnEseguiClick(A045FDialogStampa);
  finally
    A045FDialogStampa.Free;
  end;
end;

procedure TB028PrintServer.PrintA061(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A061FDettAssenze:=TA061FDettAssenze.Create(nil);
  try
    A061FDettAssenze.A061MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A061FDettAssenze.A061MW.TipoModulo:='COM';
    A061FDettAssenze.FormShow(A061FDettAssenze);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A045FDialogStampa
    SettaDatiUtente(DatiUtente,A061FDettAssenze);

    //Creo File stampa
    A061FDettAssenze.BtnPreViewClick(A061FDettAssenze);
  finally
    A061FDettAssenze.Free;
  end;
end;

procedure TB028PrintServer.PrintA043(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A043FDialogStampa:=TA043FDialogStampa.Create(nil);
  try
    A043FDialogStampa.A043MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A043FDialogStampa.A043MW.TipoModulo:='COM';
    A043FDialogStampa.FormShow(A043FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A043FDialogStampa
    SettaDatiUtente(DatiUtente,A043FDialogStampa);

    //Creo File stampa
    if A043FDialogStampa.SoloAgg = 'S' then
      A043FDialogStampa.BtnStampaClick(A043FDialogStampa.btnSoloAggiornamento)
    else
      A043FDialogStampa.BtnStampaClick(A043FDialogStampa.btnAnteprima);

    // valuta esito operazione
    if RegistraMsg.ContieneAnomalie then
      DettaglioLog:=RegistraMsg.ID.ToString;
  finally
    A043FDialogStampa.Free;
  end;
end;

procedure TB028PrintServer.PrintA074(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A074FRiepilogoBuoni:=TA074FRiepilogoBuoni.Create(nil);
  try
    A074FRiepilogoBuoniDtM1:=TA074FRiepilogoBuoniDtM1.Create(nil);
    A074FRiepilogoBuoni.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A074FRiepilogoBuoni.TipoModulo:=TTipoModuloRec.COM;
    A074FRiepilogoBuoni.FormShow(A043FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A074FRiepilogoBuoni);
    A074FRiepilogoBuoni.ChkInizioAnnoClick(nil);

    //Inizializzo form
    A074FRiepilogoBuoni.BtnStampaClick(A074FRiepilogoBuoni.BtnStampa);

    // valorizza esito operazione
    if RegistraMsg.ContieneAnomalie then
    begin
      // esito: stringa separata da virgola contenente un flag che indica la presenza di anomalie + l'id del messaggio di log
      DettaglioLog:=Format('%s,%d',[TEsitoA074Rec.Anomalie,RegistraMsg.ID]);
    end
    else if RegistraMsg.ContieneTipoI then
    begin
      // esito: stringa separata da virgola contenente un flag che indica la presenza di informazioni + l'id del messaggio di log
      DettaglioLog:=Format('%s,%d',[TEsitoA074Rec.Info,RegistraMsg.ID]);
    end;
  finally
    A074FRiepilogoBuoni.Free;
    A074FRiepilogoBuoniDtM1.Free;
  end;
end;

procedure TB028PrintServer.PrintA042(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A042FDialogStampa:=TA042FDialogStampa.Create(nil);
  try
    A042FStampaPreAssDtM1:=TA042FStampaPreAssDtM1.Create(nil);
    A042FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A042FDialogStampa.TipoModulo:='COM';
    A042FDialogStampa.FormShow(A042FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A042FDialogStampa);

    //Inizializzo form
    A042FDialogStampa.BtnStampaClick(A042FDialogStampa.BtnStampa);
  finally
    A042FDialogStampa.Free;
    A042FStampaPreAssDtM1.Free;
  end;
end;

procedure TB028PrintServer.PrintA092(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A092FStampaStorico:=TA092FStampaStorico.Create(nil);
  try
    A092FStampaStoricoDtM1:=TA092FStampaStoricoDtM1.Create(nil);
    A092FStampaStorico.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A092FStampaStorico.TipoModulo:='COM';
    A092FStampaStorico.FormShow(A092FStampaStorico);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A092FStampaStorico);

    //Eslaborazione stampa
    try
      A092FStampaStorico.BtnPreViewClick(A092FStampaStorico.BtnStampa);
    except
      on E:Exception do
        DettaglioLog:=E.Message;
    end;
  finally
    A092FStampaStorico.Free;
    A092FStampaStoricoDtM1.Free;
  end;
end;

procedure TB028PrintServer.PrintA081(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A081FTimbCaus:=TA081FTimbCaus.Create(nil);
  try
    A081FTimbCausDtM1:=TA081FTimbCausDtM1.Create(nil);
    A081FTimbCaus.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A081FTimbCaus.TipoModulo:='COM';
    A081FTimbCaus.FormShow(A081FTimbCaus);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A081FTimbCaus);

    //Inizializzo form
    A081FTimbCaus.BtnPreViewClick(A081FTimbCaus.BtnStampa);
  finally
    A081FTimbCaus.Free;
    A081FTimbCausDtM1.Free;
  end;
end;

procedure TB028PrintServer.PrintA051(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A051FTimbOrig:=TA051FTimbOrig.Create(nil);
  try
    A051FTimbOrigDtM1:=TA051FTimbOrigDtM1.Create(nil);
    A051FTimbOrig.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A051FTimbOrig.TipoModulo:='COM';
    A051FTimbOrig.FormShow(A081FTimbCaus);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A051FTimbOrig);

    //Inizializzo form
    A051FTimbOrig.BtnStampaClick(A051FTimbOrig.BtnStampa);
  finally
    A051FTimbOrig.Free;
    A051FTimbOrigDtM1.Free;
  end;
end;

procedure TB028PrintServer.PrintA090(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A090FAssenzeAnno:=TA090FAssenzeAnno.Create(nil);
  try
    A090FAssenzeAnnoDtM1:=TA090FAssenzeAnnoDtM1.Create(nil);
    A090FAssenzeAnno.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A090FAssenzeAnno.TipoModulo:='COM';
    A090FAssenzeAnno.FormShow(A090FAssenzeAnno);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A090FAssenzeAnno);

    //Inizializzo form
    A090FAssenzeAnno.edtDaAnnoChange(A090FAssenzeAnno.edtDaAnno);
    A090FAssenzeAnno.BtnPreViewClick(A090FAssenzeAnno.BtnStampa);
  finally
    A090FAssenzeAnno.Free;
    A090FAssenzeAnnoDtM1.Free;
  end;
end;

procedure TB028PrintServer.PrintA116(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A116FLiquidazioneOreAnniPrec:=TA116FLiquidazioneOreAnniPrec.Create(nil);
  try
    A116FLiquidazioneOreAnniPrec.A116MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A116FLiquidazioneOreAnniPrec.A116MW.TipoModulo:='COM';
    A116FLiquidazioneOreAnniPrec.FormShow(A116FLiquidazioneOreAnniPrec);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A116FLiquidazioneOreAnniPrec
    SettaDatiUtente(DatiUtente,A116FLiquidazioneOreAnniPrec);

    //Inizializzo form
    //Creo File stampa
    if A116FLiquidazioneOreAnniPrec.SoloAgg = 'S' then
      A116FLiquidazioneOreAnniPrec.BtnStampaClick(A116FLiquidazioneOreAnniPrec.btnEffettuaLiq)
    else
      A116FLiquidazioneOreAnniPrec.BtnStampaClick(A116FLiquidazioneOreAnniPrec.BtnPreView);

    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);
  finally
    A116FLiquidazioneOreAnniPrec.Free;
  end;
end;

procedure TB028PrintServer.PrintA077(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A077FGeneratoreStampe:=TA077FGeneratoreStampe.Create(nil);
  try
    A077FGeneratoreStampe.TipoModulo:='COM';
    A077FGeneratoreStampeDtM:=TA077FGeneratoreStampeDtM.Create(nil);
    A077FGeneratoreStampe.FormShow(A077FGeneratoreStampe);
    A077FGeneratoreStampe.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A077FGeneratoreStampe.DropTabelleTemp:=True;
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A077FGeneratoreStampe
    SettaDatiUtente(DatiUtente,A077FGeneratoreStampe);
    //Inizializzo form
    if FilePDF <> '' then
      A077FGeneratoreStampe.btnAnteprimaClick(A077FGeneratoreStampe)
    else if A077FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> '' then
      A077FGeneratoreStampe.btnAnteprimaClick(A077FGeneratoreStampe.btnTabella);
    DettaglioLog:=StringReplace(A077FGeneratoreStampe.TestoLog,'<NUM_PAG>',IntToStr(A077FStampa.QRep.PageNumber),[rfReplaceAll]);
    if (DettaglioLog = '') and (FilePDF = '') and (A077FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> '')  then
      DettaglioLog:='Dati registrati sulla tabella T920' + A077FGeneratoreStampe.TabellaStampa;
  finally
    A077FGeneratoreStampeDtM.Free;
    A077FGeneratoreStampe.Free;
  end;
end;

procedure TB028PrintServer.PrintA059(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A059FContSquadre:=TA059FContSquadre.Create(nil);
  try
    A059FContSquadreDtM1:=TA059FContSquadreDtM1.Create(nil);
    A059FContSquadre.TipoModulo:='COM';
    A059FContSquadre.FormShow(A059FContSquadre);
    A059FContSquadre.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Leggo i dati inseriti dall'utente web e li setto su  A059FContSquadre
    SettaDatiUtente(DatiUtente,A059FContSquadre);
    //Richiamo anteprima stampa
    A059FContSquadre.btnStampaClick(A059FContSquadre.btnAnteprima);
  finally
    A059FContSquadreDtM1.Free;
    A059FContSquadre.Free;
  end;
end;

procedure TB028PrintServer.PrintA068(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A068FTurniGior:=TA068FTurniGior.Create(nil);
  try
    A068FTurniGiorDtM1:=TA068FTurniGiorDtM1.Create(nil);
    A068FTurniGior.TipoModulo:='COM';
    A068FTurniGior.FormShow(A068FTurniGior);
    A068FTurniGior.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A059FContSquadre
    SettaDatiUtente(DatiUtente,A068FTurniGior);
    //Richiamo anteprima stampa
    A068FTurniGior.Label1.Caption:=FormatDateTime('dd mmmm yyyy',A068FTurniGior.Data);
    A068FTurniGior.BitBtn3Click(A068FTurniGior.BitBtn3);
  finally
    A068FTurniGiorDtM1.Free;
    A068FTurniGior.Free;
  end;
end;

procedure TB028PrintServer.PrintA202(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant); safecall;
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A202FRapportiLavoro:=TA202FRapportiLavoro.Create(nil);
  try
    A202FRapportiLavoroDM:=TA202FRapportiLavoroDM.Create(nil);
    A202FRapportiLavoroDM.A202MW.TipoModulo:='COM';// ImpostaModalita(COM);
    A202FRapportiLavoroDM.A202MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A202FRapportiLavoroDM.ImpostaModalita(VALIDAZIONE);
    A202FRapportiLavoro.FormShow(A202FRapportiLavoro);
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A202FRapportiLavoro
    SettaDatiUtente(DatiUtente,A202FRapportiLavoro);
    //Richiamo anteprima stampa
    A202FRapportiLavoro.Stampa1Click(A202FRapportiLavoro.TStampa);

  finally
    FreeAndNil(A202FRapportiLavoro);
    FreeAndNil(A202FRapportiLavoroDM);

  end;
end;

procedure TB028PrintServer.PrintA058(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A058FPianifTurni:=TA058FPianifTurni.Create(nil);
  try
    A058FPianifTurniDtM1:=TA058FPianifTurniDtM1.Create(nil);
    A058FPianifTurni.TipoModulo:='COM';
    A058FPianifTurni.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A058FPianifTurni.FormShow(A058FPianifTurni);
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A058FPianifTurni
    SettaDatiUtente(DatiUtente,A058FPianifTurni);
    //Richiamo anteprima stampa
    A058FPianifTurniDtM1.DataInizio:=A058FPianifTurni.DataI;
    A058FPianifTurniDtM1.DataFine:=A058FPianifTurni.DataF;
    A058FPianifTurniDtm1.RefreshSquadre;//Necessario per aggiornare selT603 e avere SquadraRiferimento valorizzato
    A058FPianifTurni.btnEseguiClick(A058FPianifTurni.btnAnteprima);
  finally
    A058FPianifTurniDtM1.Free;
    A058FPianifTurni.Free;
  end;
end;

procedure TB028PrintServer.PrintA105(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A105FStoricoGiustificativi:=TA105FStoricoGiustificativi.Create(nil);
  try
    A105FStoricoGiustificativi.A105MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A105FStoricoGiustificativi.A105MW.TipoModulo:='COM';
    A105FStoricoGiustificativi.FormShow(A105FStoricoGiustificativi);
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  A105FStoricoGiustificativi
    SettaDatiUtente(DatiUtente,A105FStoricoGiustificativi);
    //Richiamo anteprima stampa
    A105FStoricoGiustificativi.BtnPreViewClick(A105FStoricoGiustificativi.BtnPreView);
  finally
    A105FStoricoGiustificativi.Free;
  end;
end;

procedure TB028PrintServer.PrintA104(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A104FDialogStampa:=TA104FDialogStampa.Create(nil);
  try
    A104FStampaMissioniDtM1:=TA104FStampaMissioniDtM1.Create(nil);
    A104FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A104FDialogStampa.TipoModulo:='COM';
    A104FDialogStampa.FormShow(nil);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  A074FRiepilogoBuoni
    SettaDatiUtente(DatiUtente,A104FDialogStampa);

    //Inizializzo form
    A104FDialogStampa.BtnStampaClick(A104FDialogStampa.BtnStampa);
  finally
    A104FDialogStampa.Free;
    A104FStampaMissioniDtM1.Free;
  end;
end;
procedure TB028PrintServer.PrintA047(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A047FTimbMensa:=TA047FTimbMensa.Create(nil);
  try
    A047FTimbMensaDtM1:=TA047FTimbMensaDtM1.Create(nil);
    A047FTimbMensa.FormShow(nil);

    A047FDialogStampa.TipoModulo:='COM';
    A047FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');

    A047FTimbMensa.frmSelAnagrafe.OnCambiaProgressivo:=nil;
    A047FDialogStampa.FormShow(A047FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su A047FDialogStampa
    SettaDatiUtente(DatiUtente,A047FDialogStampa);
    //Richiamo anteprima stampa
    A047FDialogStampa.DataI:=StrToDateTime(A047FDialogStampa.eDaData.Text);
    A047FDialogStampa.DataF:=StrToDateTime(A047FDialogStampa.eAData.Text);
    A047FDialogStampa.BtnStampaClick(A047FDialogStampa.btnStampa);
  finally
    A047FTimbMensaDtM1.Free;
    A047FTimbMensa.Free;
  end;
end;

procedure TB028PrintServer.PrintA049(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A049FDialogStampa:=TA049FDialogStampa.Create(nil);
  A049FStampaPastiDtM1:=TA049FStampaPastiDtM1.Create(nil);
  try
    A049FStampaPastiDtM1.A049FStampaPastiMW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A049FStampaPastiDtM1.A049FStampaPastiMW.TipoModulo:=TTipoModuloRec.COM;
    A049FDialogStampa.FormShow(A049FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    SettaDatiUtente(DatiUtente,A049FDialogStampa);
    //Inizializzo form
    if FilePDF = ''then
    begin
      //esecuzione senza stampa fatta a parte
    end
    else
    begin
      A049FDialogStampa.btnStampaClick(A049FDialogStampa.btnStampa);
      if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
        DettaglioLog:=IntToStr(RegistraMsg.ID);
    end;
  finally
    A049FDialogStampa.close;
    A049FDialogStampa.Free;
    A049FStampaPastiDtM1.Free;
  end;
end;

procedure TB028PrintServer.PrintA167(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A167FRegistraIncentivi:=TA167FRegistraIncentivi.Create(nil);
  A167FRegistraIncentiviDtm:=TA167FRegistraIncentiviDtm.Create(nil);
  try
    A167FRegistraIncentivi.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A167FRegistraIncentivi.TipoModulo:='COM';
    A167FRegistraIncentivi.FormShow(A167FRegistraIncentivi);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    //Leggo i dati inseriti dall'utente web e li setto su  A116FLiquidazioneOreAnniPrec
    SettaDatiUtente(DatiUtente,A167FRegistraIncentivi);
    //Inizializzo form
    //Creo File stampa
    if A167FRegistraIncentivi.SoloAgg = 'S' then
      A167FRegistraIncentivi.btnAggiornamentoClick(A167FRegistraIncentivi.btnAggiornamento)
    else
      A167FRegistraIncentivi.BtnAnteprimaClick(A167FRegistraIncentivi.BtnStampa);

    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);

  finally
    A167FRegistraIncentivi.close;
    A167FRegistraIncentivi.Free;
    A167FRegistraIncentiviDtm.Free;
  end;
end;

procedure TB028PrintServer.PrintA145(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);

begin

  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A145FComunicazioneVisiteFiscali:=TA145FComunicazioneVisiteFiscali.Create(nil);
  A145FComunicazioneVisiteFiscaliDtm:=TA145FComunicazioneVisiteFiscaliDtm.Create(nil);
  try
    A145FComunicazioneVisiteFiscali.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A145FComunicazioneVisiteFiscali.TipoModulo:='COM';
    A145FComunicazioneVisiteFiscali.FormShow(A145FComunicazioneVisiteFiscali);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    SettaDatiUtente(DatiUtente,A145FComunicazioneVisiteFiscali);
    //Inizializzo form
    if FilePDF = ''then
    begin
      A145FComunicazioneVisiteFiscali.btnEseguiClick(A145FComunicazioneVisiteFiscali.btnEsegui);
      DettaglioLog:=A145FComunicazioneVisiteFiscali.MessaggioDCOM;
    end
    else
    begin
      A145FComunicazioneVisiteFiscali.btnStampaClick(A145FComunicazioneVisiteFiscali.btnStampa);
      DettaglioLog:=A145FComunicazioneVisiteFiscali.MessaggioDCOM;
    end;
  finally
    A145FComunicazioneVisiteFiscali.close;
    A145FComunicazioneVisiteFiscali.Free;
    A145FComunicazioneVisiteFiscaliDtm.Free;
  end;
end;

procedure TB028PrintServer.PrintS715(const SelezioneAnagrafica, FilePDF, Operatore,
          Azienda, DBServer, DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant);

begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  S715FDialogStampa:=TS715FDialogStampa.Create(nil);
  S715FStampaValutazioniDtm:=TS715FStampaValutazioniDtm.Create(nil);
  try
    S715FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    S715FDialogStampa.TipoModulo:='COM';
    S715FDialogStampa.FormShow(S715FDialogStampa);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    SettaDatiUtente(DatiUtente,S715FDialogStampa);

    S715FDialogStampa.AbilitaComponenti;
    //Forza settaggio variabili
    S715FDialogStampa.edtDataDaExit(S715FDialogStampa.edtDataDa);
    S715FDialogStampa.edtDataAExit(S715FDialogStampa.edtDataA);

    S715FDialogStampa.btnEseguiClick(S715FDialogStampa.btnEsegui);
    MessaggioAggiuntivo:=S715FDialogStampa.MessaggioDCOM;
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);
  finally
    S715FDialogStampa.Close;
    S715FDialogStampa.Free;
    S715FStampaValutazioniDtm.Free;
  end;
end;

procedure TB028PrintServer.PrintA065(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A065FStampaBudget:=TA065FStampaBudget.Create(nil);
  try
    A065FStampaBudget.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A065FStampaBudget.TipoModulo:='COM';
    A065FStampaBudget.FormShow(A065FStampaBudget);

    //Leggo i dati inseriti dall'utente web e li setto su  A065FStampaBudget
    SettaDatiUtente(DatiUtente,A065FStampaBudget);

    //Recupero l'elenco dei gruppi in base alle date
    A065FStampaBudget.sedtAnnoChange(A065FStampaBudget.sedtAnno);
    A065FStampaBudget.cmbAMeseChange(A065FStampaBudget.cmbAMese);

    //RiLeggo i dati inseriti dall'utente web (in particolare seleziono i gruppi)
    SettaDatiUtente(DatiUtente,A065FStampaBudget);
    A065FStampaBudget.RicaricaListaGruppiSel;

    A065FStampaBudget.BStampaClick(A065FStampaBudget.btnAnteprima);
  finally
    A065FStampaBudget.Free;
  end;
end;

procedure TB028PrintServer.PrintA040(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A040FPianifRep:=TA040FPianifRep.Create(nil);
  try
    A040FPianifRep.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A040FPianifRep.TipoModulo:='COM';
    A040FPianifRepDtM1:=TA040FPianifRepDtM1.Create(nil);
    A040FPianifRepDtM2:=TA040FPianifRepDtM2.Create(nil);

    A040FPianifRep.EAnno.OnChange:=nil;
    A040FPianifRep.EMese.OnChange:=nil;
    A040FDialogStampa.rgpTipoStampa.OnClick:=nil;
    SettaDatiUtente(DatiUtente,A040FDialogStampa);//Imposto il CodTipologia
    A040FPianifRepDtM1.A040MW.ImpostaTipologiaDataSet;
    //A040FPianifRepDtM2:=TA040FPianifRepDtM2.Create(nil);
    A040FPianifRep.EAnno.OnChange:=A040FPianifRep.EAnnoChange;
    A040FPianifRep.EMese.OnChange:=A040FPianifRep.EAnnoChange;
    A040FDialogStampa.rgpTipoStampa.OnClick:=A040FDialogStampa.rgpTipoStampaClick;
    A040FPianifRep.FormShow(A040FPianifRep);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.SQL.Text:=A040FPianifRepDtM1.A040MW.SelAnagrafe.SQL.Text;
    C700FSelezioneAnagrafe.SelezionePeriodicaDalAl(A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp, A040FPianifRepDtM1.A040MW.DataInizio, A040FPianifRepDtM1.A040MW.DataFine, nil, 2, True, False, False);
    A040FPianifRepDtM1.A040MW.SelAnagrafeLookUp.Open;
    A040FPianifRep.EAnnoChange(nil);

    A040FPianifRepDtM1.A040MW.DataSt:=A040FPianifRepDtM1.A040MW.DataInizio;
    A040FDialogStampa.FormShow(A040FDialogStampa);

    if A040FPianifRepDtM1.A040MW.RecapitoAlternativo then
      A040FDialogStampa.rgpCampoDettaglio.ItemIndex:=1
    else
      A040FDialogStampa.rgpCampoDettaglio.ItemIndex:=0;

    //Leggo i dati inseriti dall'utente web e li setto su  A040FDialogStampa
    SettaDatiUtente(DatiUtente,A040FDialogStampa);

    A040FDialogStampa.btnStampaClick(A040FDialogStampa.btnAnteprima);
    DettaglioLog:=A040FPianifRep.MessaggioDCOM;
  finally
    FreeAndNil(A040FStampa2);
    FreeAndNil(A040FStampa);
    FreeAndNil(A040FInserimento);
    FreeAndNil(A040FDialogStampa);
    FreeAndNil(A040FPianifRepDtM2);
    FreeAndNil(A040FPianifRepDtM1);
    A040FPianifRep.Free;
  end;
end;

procedure TB028PrintServer.PrintS404(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  S404FStampaRischi:=TS404FStampaRischi.Create(nil);
  try
    S404FStampaRischi.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    S404FStampaRischi.TipoModulo:='COM';
    S404FStampaRischi.FormShow(S404FStampaRischi);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto su  S404FStampaRischi
    SettaDatiUtente(DatiUtente,S404FStampaRischi);

    S404FStampaRischi.btnStampaClick(S404FStampaRischi.btnAnteprima);
  finally
    S404FStampaRischi.Free;
  end;
end;

procedure TB028PrintServer.PrintP077(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P077FGeneratoreStampe:=TP077FGeneratoreStampe.Create(nil);
  try
    P077FGeneratoreStampe.TipoModulo:='COM';
    P077FGeneratoreStampeDtM:=TP077FGeneratoreStampeDtM.Create(nil);
    P077FGeneratoreStampe.FormShow(P077FGeneratoreStampe);
    P077FGeneratoreStampe.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    P077FGeneratoreStampe.DropTabelleTemp:=True;
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto su  P077FGeneratoreStampe
    SettaDatiUtente(DatiUtente,P077FGeneratoreStampe);
    //Inizializzo form
    if FilePDF <> '' then
      P077FGeneratoreStampe.btnAnteprimaClick(P077FGeneratoreStampe)
    else if P077FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> '' then
      P077FGeneratoreStampe.btnAnteprimaClick(P077FGeneratoreStampe.btnTabella);
    DettaglioLog:=StringReplace(P077FGeneratoreStampe.TestoLog,'<NUM_PAG>',IntToStr(P077FStampa.QRep.PageNumber),[rfReplaceAll]);
    if (DettaglioLog = '') and (FilePDF = '') and (P077FGeneratoreStampeDtM.Q910.FieldByName('TABELLA_GENERATA').AsString <> '')  then
      DettaglioLog:='Dati registrati sulla tabella T920' + P077FGeneratoreStampe.TabellaStampa;
  finally
    P077FGeneratoreStampeDtM.Free;
    P077FGeneratoreStampe.Free;
  end;
end;

procedure TB028PrintServer.PrintP273(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P273FStampaStoricoRetribContr:=TP273FStampaStoricoRetribContr.Create(nil);
  try
    P273FStampaStoricoRetribContrDTM:=TP273FStampaStoricoRetribContrDTM.Create(nil);
    P273FStampa:=TP273FStampa.Create(nil);
    P273FStampaStoricoRetribContr.TipoModulo:='COM';
    P273FStampaStoricoRetribContr.FormShow(P273FStampaStoricoRetribContr);
    P273FStampaStoricoRetribContr.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto sulla stampa
    SettaDatiUtente(DatiUtente,P273FStampaStoricoRetribContr);
    P273FStampaStoricoRetribContr.chkUltimoPeriodoClick(nil);
    P273FStampaStoricoRetribContr.btnAnteprimaClick(P273FStampaStoricoRetribContr.btnStampa);

  finally
    DettaglioLog:=IntToStr(RegistraMsg.ID);
    P273FStampaStoricoRetribContrDTM.Free;
    P273FStampaStoricoRetribContr.Free;
    P273FStampa.Free;
  end;
end;

procedure TB028PrintServer.PrintP283(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P283FStampaPeriodiRetrib:=TP283FStampaPeriodiRetrib.Create(nil);
  try
    P283FStampaPeriodiRetribDTM:=TP283FStampaPeriodiRetribDTM.Create(nil);
    P283FStampa:=TP283FStampa.Create(nil);
    P283FStampaPeriodiRetrib.TipoModulo:='COM';
    P283FStampaPeriodiRetrib.FormShow(P283FStampaPeriodiRetrib);
    P283FStampaPeriodiRetrib.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto sulla stampa
    SettaDatiUtente(DatiUtente,P283FStampaPeriodiRetrib);
    P283FStampaPeriodiRetrib.btnAnteprimaClick(P283FStampaPeriodiRetrib.btnStampa);

  finally
    DettaglioLog:=IntToStr(RegistraMsg.ID);
    P283FStampaPeriodiRetribDTM.Free;
    P283FStampaPeriodiRetrib.Free;
    P283FStampa.Free;
  end;
end;

procedure TB028PrintServer.PrintP314(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P314FStampaModelliTFR1:=TP314FStampaModelliTFR1.Create(nil);
  try
    P314FStampaModelliTFR1DTM:=TP314FStampaModelliTFR1DTM.Create(nil);
    P314FStampa:=TP314FStampa.Create(nil);
    P314FStampaModelliTFR1.TipoModulo:='COM';
    P314FStampaModelliTFR1.FormShow(P314FStampaModelliTFR1);
    P314FStampaModelliTFR1.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto sulla stampa
    SettaDatiUtente(DatiUtente,P314FStampaModelliTFR1);
    P314FStampaModelliTFR1.btnAnteprimaClick(nil);

    if P314FStampaModelliTFR1DTM.P314MW.PresenzaAnomalie then
    begin
      MessaggioAggiuntivo:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
      if P314FStampaModelliTFR1DTM.P314MW.TabellaStampa.RecordCount = 0 then
        MessaggioAggiuntivo:=Trim(MessaggioAggiuntivo + ' ' + A000MSG_P314_MSG_NO_MODELLITFR1);
    end;

  finally
    DettaglioLog:=IntToStr(RegistraMsg.ID);
    P314FStampaModelliTFR1DTM.Free;
    P314FStampaModelliTFR1.Free;
    P314FStampa.Free;
  end;
end;

procedure TB028PrintServer.PrintP500(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog, MessaggioAggiuntivo: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P500FCalcoloCedolino:=TP500FCalcoloCedolino.Create(nil);
  try
    P500FCalcoloCedolinoDtM:=TP500FCalcoloCedolinoDtM.Create(nil);
    P500FCalcoloCedolino.TipoModulo:='COM';
    P500FCalcoloCedolinoDtM.P500FCalcoloCedolinoMW.A210MW.AvviaPSCP:=P500FCalcoloCedolinoDtM.AvviaPSCPWeb;
    P500FCalcoloCedolino.FormShow(P500FCalcoloCedolino);
    P500FCalcoloCedolino.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto su  P077FGeneratoreStampe
    SettaDatiUtente(DatiUtente,P500FCalcoloCedolino);
    P500FCalcoloCedolino.ImpostaComponenti(nil);
    P500FCalcoloCedolino.btnEseguiClick(P500FCalcoloCedolino.btnEsegui);

    if P500FCalcoloCedolinoDtm.P500FCalcoloCedolinoMW.PresenzaAnomalie then
    begin
      MessaggioAggiuntivo:=A000MSG_MSG_ELABORAZIONE_ANOMALIE;
      if P500FCalcoloCedolino.chkStampa.Checked
      and (P500FCalcoloCedolinoDtm.P500FCalcoloCedolinoMW.cdsStampaAnagrafico.RecordCount = 0) then
        MessaggioAggiuntivo:=Trim(MessaggioAggiuntivo + ' ' + A000MSG_P500_MSG_NO_CEDOLINO);
    end
    else if not P500FCalcoloCedolinoDtm.P500FCalcoloCedolinoMW.CedolinoElaborato then
    begin
      MessaggioAggiuntivo:=A000MSG_P500_MSG_NO_CEDOLINO
    end;

  finally
    DettaglioLog:=IntToStr(RegistraMsg.ID);
    P500FCalcoloCedolinoDtM.Free;
    P500FCalcoloCedolino.Free;
  end;
end;

procedure TB028PrintServer.PrintP700(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P700FDialogStampa:=TP700FDialogStampa.Create(nil);
  try
    P700FRiepilogoMensileInpsDTM1:=TP700FRiepilogoMensileInpsDTM1.Create(nil);
    P700FStampaDettaglio:=TP700FStampaDettaglio.Create(nil);
    P700FStampaRaggr:=TP700FStampaRaggr.Create(nil);
    P700FDialogStampa.TipoModulo:='COM';
    P700FDialogStampa.FormShow(P700FDialogStampa);
    P700FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto sulla stampa
    SettaDatiUtente(DatiUtente,P700FDialogStampa);
    P700FDialogStampa.btnAnteprimaClick(P700FDialogStampa.btnStampa);
  finally
    DettaglioLog:=IntToStr(RegistraMsg.ID);
    P700FRiepilogoMensileInpsDTM1.Free;
    P700FDialogStampa.Free;
    P700FStampaDettaglio.Free;
    P700FStampaRaggr.Free;
  end;
end;

procedure TB028PrintServer.PrintP710(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P710FDialogStampa:=TP710FDialogStampa.Create(nil);
  try
    P710FRiepilogoAnnualeInailDTM1:=TP710FRiepilogoAnnualeInailDTM1.Create(nil);
    P710FStampa:=TP710FStampa.Create(nil);
    P710FDialogStampa.TipoModulo:='COM';
    P710FDialogStampa.FormShow(P710FDialogStampa);
    P710FDialogStampa.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto sulla stampa
    SettaDatiUtente(DatiUtente,P710FDialogStampa);
    P710FDialogStampa.btnAnteprimaClick(P710FDialogStampa.btnStampa);
  finally
    DettaglioLog:=IntToStr(RegistraMsg.ID);
    P710FRiepilogoAnnualeInailDTM1.Free;
    P710FDialogStampa.Free;
    P710FStampa.Free;
  end;
end;

procedure TB028PrintServer.PrintP715(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P715FStampaCertificazioneUnica:=TP715FStampaCertificazioneUnica.Create(nil);
  P715FStampaCertificazioneUnicaDtm:=TP715FStampaCertificazioneUnicaDtm.Create(nil);
  try
    P715FStampaCertificazioneUnica.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    P715FStampaCertificazioneUnica.TipoModulo:='COM';
    P715FStampaCertificazioneUnica.FormShow(P715FStampaCertificazioneUnica);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    //Forza settaggio variabili
    SettaDatiUtente(DatiUtente,P715FStampaCertificazioneUnica);//imposto la data da usare come riferimento
    P715FStampaCertificazioneUnica.edtAnnoChange(nil);         //legge i dati setup in base all'anno impostato da SettaDatiUtente
    P715FStampaCertificazioneUnica.chkRiepilogativoClick(nil); //imposta i campi in base ai dati setup
    SettaDatiUtente(DatiUtente,P715FStampaCertificazioneUnica);//reimposta memAnnotazione e edtDataFirma e altro in base al chiamante

    P715FStampaCertificazioneUnica.btnAnteprimaClick(P715FStampaCertificazioneUnica.btnAnteprima);
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=IntToStr(RegistraMsg.ID);
  finally
    P715FStampaCertificazioneUnica.Close;
    P715FStampaCertificazioneUnica.Free;
    P715FStampaCertificazioneUnicaDtm.Free;
  end;
end;

procedure TB028PrintServer.PrintA083(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A083FMsgElaborazioni:=TA083FMsgElaborazioni.Create(nil);
  try
    A083FMsgElaborazioniDTM:=TA083FMsgElaborazioniDTM.Create(nil);
    A083FStampa:=TA083FStampa.Create(nil);
    A083FMsgElaborazioni.TipoModulo:='COM';
    A083FMsgElaborazioni.FormShow(A083FMsgElaborazioni);
    A083FMsgElaborazioni.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto sulla stampa
    SettaDatiUtente(DatiUtente,A083FMsgElaborazioni);
    A083FMsgElaborazioni.Stampa1Click(nil);
  finally
    DettaglioLog:=IntToStr(RegistraMsg.ID);
    A083FMsgElaborazioniDTM.Free;
    A083FMsgElaborazioni.Free;
    A083FStampa.Free;
  end;
end;

procedure TB028PrintServer.PrintA097(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A097FPianifLibProf:=TA097FPianifLibProf.Create(nil);
  try
    A097FPianifLibProfDtM1:=TA097FPianifLibProfDtM1.Create(nil);
    A097FPianifLibProfDtM1.A097MW.TipoModulo:='COM';
    A097FPianifLibProf.FormShow(A097FPianifLibProf);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;

    //Leggo i dati inseriti dall'utente web e li setto su A097FPianifLibProf
    SettaDatiUtente(DatiUtente,A097FPianifLibProf);

    //Inizializzo form
    A097FPianifLibProfDtM1.A097MW.Dal:=A097FPianifLibProf.DataI;
    A097FPianifLibProfDtM1.A097MW.Al:=A097FPianifLibProf.DataF;
    A097FPianifLibProf.edtNomeFileInput.Text:=FilePDF;
    A097FPianifLibProf.AbilitaComponenti;

    //Avvio importazione file excel
    A097FPianifLibProf.btnImportazioneFileClick(nil);
  finally
    DettaglioLog:=IntToStr(A097FPianifLibProfDtM1.A097MW.NRecImp) + '+';//record importati
    if RegistraMsg.ContieneTipoA or RegistraMsg.ContieneTipoB then
      DettaglioLog:=DettaglioLog + IntToStr(RegistraMsg.ID);//id anomalie
    A097FPianifLibProfDtM1.Free;
    A097FPianifLibProf.Free;
  end;
end;

procedure TB028PrintServer.PrintS304(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);

  S304FRiepilogoIncarichi:=TS304FRiepilogoIncarichi.Create(nil);
  S304FRiepilogoIncarichiDtM:=TS304FRiepilogoIncarichiDtM.Create(nil);
  try
    S304FRiepilogoIncarichiDtM.S304MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    S304FRiepilogoIncarichiDtM.S304MW.TipoModulo:=TTipoModuloRec.COM;

    S304FRiepilogoIncarichi.FormShow(S304FRiepilogoIncarichi);

    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    //Leggo i dati inseriti dall'utente web e li setto sul form
    SettaDatiUtente(DatiUtente,S304FRiepilogoIncarichi);

    S304FRiepilogoIncarichi.btnAnteprimaClick(S304FRiepilogoIncarichi.btnAnteprima);
  finally
    S304FRiepilogoIncarichi.Free;
    S304FRiepilogoIncarichiDtM.Free;
  end;
end;

procedure TB028PrintServer.PrintS203(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  S203FStampaPiantaOrganica:=TS203FStampaPiantaOrganica.Create(nil);
  try
    S203FStampaPiantaOrganicaDtM:=TS203FStampaPiantaOrganicaDtM.Create(nil);
    S203FStampaPiantaOrganicaDtm.S203MW.TipoModulo:='COM';
    S203FStampaPiantaOrganica.FormShow(S203FStampaPiantaOrganica);
    S203FStampaPiantaOrganicaDtM.S203MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    //Leggo i dati inseriti dall'utente web e li setto sul form
    SettaDatiUtente(DatiUtente,S203FStampaPiantaOrganica);
    //Inizializzo form
    S203FStampaPiantaOrganica.btnAnteprimaClick(S203FStampaPiantaOrganica);
  finally
    with S203FStampaPiantaOrganicaDtm.S203MW do
      if cdsTabEffettivi.Active then
        if cdsTabEffettivi.RecordCount > 0 then
          if FilePDF <> '' then
            cdsTabEffettivi.SaveToFile(Copy(FilePDF,1,Length(FilePDF) - 3) + 'cdstemp');
    S203FStampaPiantaOrganicaDtM.Free;
    S203FStampaPiantaOrganica.Free;
  end;
end;

procedure TB028PrintServer.PrintA027(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
var
  PosFrom:Integer;
  SQLDef:String;
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  A027FCarMen:=TA027FCarMen.Create(nil);
  try
    A027FCarMen.TipoModulo:='COM';
    A027FCarMen.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    A027FCarMen.FormShow(A027FCarMen);
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);

    SQLDef:=C700SelAnagrafe.SubstitutedSQL;
    if Pos('V430.*',UpperCase(SQLDef)) = 0 then
    begin
      PosFrom:=Pos('FROM',UpperCase(SQLDef));
      if PosFrom > 1 then
        Insert(',V430.* ',SQLDef,PosFrom);
      C700SelAnagrafe.SQL.Text:=SQLDef;
    end;
    C700SelAnagrafe.Open;

    //Leggo i dati inseriti dall'utente web e li setto sul form
    SettaDatiUtente(DatiUtente,A027FCarMen);
    // Avvio stampa
    A027FCarMen.BitBtn1Click(A027FCarMen.BitBtn1);
  finally
    A027FCarMen.Free;
  end;
end;

procedure TB028PrintServer.PrintS201(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  S201FSelezioneAtti:=TS201FSelezioneAtti.Create(nil);
  try
    S201FDistribuzioneOrganicoDtM:=TS201FDistribuzioneOrganicoDtM.Create(nil);
    S201FDistribuzioneOrganicoDtM.S201MW.TipoModulo:='COM';
    S201FDistribuzioneOrganicoDtM.S201MW.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Leggo i dati inseriti dall'utente web e li setto sul form
    SettaDatiUtente(DatiUtente,S201FSelezioneAtti);
    S201FSelezioneAtti.FormShow(S201FSelezioneAtti);
    // Avvio stampa
    S201FSelezioneAtti.btnAnteprimaClick(S201FSelezioneAtti);
  finally
    S201FDistribuzioneOrganicoDtM.Free;
    S201FSelezioneAtti.Free;
  end;
end;

procedure TB028PrintServer.PrintP690(const FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P690FStampaFondi:=TP690FStampaFondi.Create(nil);
  try
    P690FStampaFondiDtM:=TP690FStampaFondiDtM.Create(nil);
    P690FStampaFondi.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    P690FStampaFondi.TipoModulo:='COM';
    P690FStampaFondi.FormShow(P690FStampaFondi);

    //Leggo i dati inseriti dall'utente web e li setto su P690FStampaFondi
    SettaDatiUtente(DatiUtente,P690FStampaFondi);

    //Recupero l'elenco dei fondi in base alle date e seleziono i valori
    P690FStampaFondi.edtDecorrenzaDaExit(nil);

    P690FStampaFondi.btnAnteprimaClick(P690FStampaFondi.btnAnteprima);
  finally
    P690FStampaFondiDtM.Free;
    P690FStampaFondi.Free;
  end;
end;

procedure TB028PrintServer.PrintP461(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString; var DettaglioLog: OleVariant);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
  SettaParametri(DatiUtente);
  P461FImportazioneAssistSanitConvenz:=TP461FImportazioneAssistSanitConvenz.Create(nil);
  try
    P461FImportazioneAssistSanitConvenzDtM:=TP461FImportazioneAssistSanitConvenzDtM.Create(nil);
    P461FImportazioneAssistSanitConvenz.TipoModulo:='COM';
    P461FImportazioneAssistSanitConvenz.FormShow(P461FImportazioneAssistSanitConvenz);
    P461FImportazioneAssistSanitConvenz.DocumentoPDF:=IfThen(FilePDF <> '',FilePDF,'<VUOTO>');
    //Eredito selezione anagrafe
    C700SelAnagrafe.Close;
    EreditaSelezioneAnagrafica(SelezioneAnagrafica);
    C700SelAnagrafe.Open;
    //Leggo i dati inseriti dall'utente web e li setto sul form
    SettaDatiUtente(DatiUtente,P461FImportazioneAssistSanitConvenz);
    //Eseguo stampa
    P461FImportazioneAssistSanitConvenz.actStampaScelteRevocheExecute(nil);
    DettaglioLog:=P461FImportazioneAssistSanitConvenz.MessaggioDCOM;
  finally
    P461FImportazioneAssistSanitConvenzDtM.Free;
    P461FImportazioneAssistSanitConvenz.Free;
  end;
end;

initialization
  TComponentFactory.Create(ComServer, TB028PrintServer, Class_B028PrintServer, ciSingleInstance, tmSingle);

end.

