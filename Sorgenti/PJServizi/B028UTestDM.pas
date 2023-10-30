unit B028UTestDM;

interface

uses
  System.SysUtils, System.Classes,
  Windows, Forms, Messages, StrUtils, Math, ComServ, ComObj, VCLCom, DataBkr, Variants,
  DBClient, StdVcl, QRPDFFilt, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} OracleData,Oracle,
  A000USessione, A000UInterfaccia, B028PPrintServer_COM_TLB;

type
  TB028FTestDM = class(TDataModule)
  private
    { Private declarations }
    procedure AperturaSessione(DBServer, Azienda, Operatore: String);
    procedure EreditaSelezioneAnagrafica(SelezioneAnagrafica: String);
    procedure SettaDatiUtente(PDatiUtente: WideString; PForm: TForm);
  public
    { Public declarations }
    procedure PrintA061(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString);
  end;

var
  B028FTestDM: TB028FTestDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses B028UprovaStampa, A001UPasswordDtM1, A042UDialogStampa, A042UStampaPreAssDtM1, A042UGrafico, A043UDialogStampa,
     A045UDialogStampa, A047UTimbMensa, A047UDialogStampa, A047UTimbMensaDtM1, A051UTimbOrig, A051UTimbOrigDtM1, A058UPianifTurni, A058UPianifTurniDtM1,
     A059UContSquadre, A059UContSquadreDtM1, A061UDettAssenze, A065UStampaBudget, A068UTurniGior, A068UTurniGiorDtM1,
     A074URiepilogoBuoni, A074URiepilogoBuoniDtM1, A081UTimbCaus,
     A077UGeneratoreStampe, A077UGeneratoreStampeDtM, A077UStampa,
     A081UTimbCausDtM1, A090UAssenzeAnno, A090UAssenzeAnnoDtM1, A092UStampaStorico, A092UStampaStoricoDtM1,
     A105UStoricoGiustificativi, A116ULiquidazioneOreAnniPrec, A104UStampaMissioniDtm1, A104UDialogStampa,
     A167URegistraIncentivi,A167URegistraIncentiviDtm, A145UComunicazioneVisiteFiscali, A145UComunicazioneVisiteFiscaliDtM,
     S715UDialogStampa,S715UStampaValutazioniDtM,
     C700USelezioneAnagrafe, C180FunzioniGenerali;

procedure TB028FTestDM.AperturaSessione(DBServer,Azienda, Operatore: String);
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

procedure TB028FTestDM.EreditaSelezioneAnagrafica(SelezioneAnagrafica: String);
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

procedure TB028FTestDM.SettaDatiUtente(PDatiUtente: WideString; PForm:TForm);
var i,j:Integer;
    json: TJSONObject;
    jPairGiust: TJSONPair;
begin
  try
    json:=TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(PDatiUtente),0) as TJSONObject;
    for i:=0 to json.Size - 1 do
    begin
      jPairGiust:=TJSONPair(json.Get(i));
      //Casi eccezionali da gestire sulle singole classi
      //A042
      if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'LstIntestazione') then
        R180PutCheckList(jPairGiust.JsonValue.Value,40,(PForm as TA042FDialogStampa).chkLIntestazione)
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'LstDettaglio') then
        R180PutCheckList(jPairGiust.JsonValue.Value,40,(PForm as TA042FDialogStampa).chkLDettaglio)
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'chkVisLineeV') then
        (PForm as TA042FDialogStampa).VisualizzaVLine:=jPairGiust.JSONValue.Value = 'S'
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'chkVisLineeH') then
        (PForm as TA042FDialogStampa).VisualizzaHLine:=jPairGiust.JSONValue.Value = 'S'
      else if (PForm is TA042FDialogStampa) and (jPairGiust.JsonString.Value = 'edtTitoloGrafico') then
        (PForm as TA042FDialogStampa).TitoloGrafico:=jPairGiust.JSONValue.Value
      //A043
      else if  (PForm is TA043FDialogStampa) and (jPairGiust.JsonString.Value = 'SoloAgg') then
        (PForm as TA043FDialogStampa).SoloAgg:=jPairGiust.JsonValue.Value
      //A045
      else if (PForm is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'LstListaCausali') then
        R180PutCheckList(jPairGiust.JsonValue.Value,6,(PForm as TA045FDialogStampa).LstListaCausali)
      else if (PForm is TA045FDialogStampa) and (jPairGiust.JsonString.Value = 'LstListaTipiRapporto') then
        R180PutCheckList(jPairGiust.JsonValue.Value,6,(PForm as TA045FDialogStampa).LstListaTipiRapporto)
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
      //A047
      else if (PForm is TA047FDialogStampa) and (jPairGiust.JsonString.Value = 'LstOrologi') then
        R180PutCheckList(jPairGiust.JsonValue.Value,2,(PForm as TA047FDialogStampa).cbxOrologi)
      else if (PForm is TA061FDettAssenze) and (jPairGiust.JsonString.Value = 'LstCodAcc') then
        R180PutCheckList(jPairGiust.JsonValue.Value,6,(PForm as TA061FDettAssenze).LstCodAcc)
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
        (PForm as TA074FRiepilogoBuoni).DataI:=StrToDate(jPairGiust.JsonValue.Value)
      else if (PForm is TA074FRiepilogoBuoni) and (jPairGiust.JsonString.Value = 'edtA') then
        (PForm as TA074FRiepilogoBuoni).DataF:=StrToDate(jPairGiust.JsonValue.Value)
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
      //A105
      else if  (PForm is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'StatoPaghe') then
        (PForm as TA105FStoricoGiustificativi).A105MW.StatoPaghe:=jPairGiust.JsonValue.Value
      else if (PForm is TA105FStoricoGiustificativi) and (jPairGiust.JsonString.Value = 'clbCausali') then
        R180PutCheckList(jPairGiust.JsonValue.Value,5,(PForm as TA105FStoricoGiustificativi).clbCausali)
      //A116
      else if  (PForm is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'SoloAgg') then
        (PForm as TA116FLiquidazioneOreAnniPrec).SoloAgg:=jPairGiust.JsonValue.Value
      else if (PForm is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'cgpIntestazione') then
        R180PutCheckList(jPairGiust.JsonValue.Value,99,(PForm as TA116FLiquidazioneOreAnniPrec).clbIntestazione)
      else if (PForm is TA116FLiquidazioneOreAnniPrec) and (jPairGiust.JsonString.Value = 'cgpDettaglio') then
        R180PutCheckList(jPairGiust.JsonValue.Value,99,(PForm as TA116FLiquidazioneOreAnniPrec).clbDettaglio)
      //A167
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
      else if  (PForm is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'cmbMedicineLegali') then
        (PForm as TA145FComunicazioneVisiteFiscali).dcmbMedicineLegali.KeyValue:=jPairGiust.JsonValue.Value
      else if  (PForm is TA145FComunicazioneVisiteFiscali) and (jPairGiust.JsonString.Value = 'lstElementiDettaglio') then
        (PForm as TA145FComunicazioneVisiteFiscali).lstElementiDettaglioCOM.CommaText:=jPairGiust.JsonValue.Value
      else if  (PForm is TS715FDialogStampa) and (jPairGiust.JsonString.Value = 'ListaTipologieQuote') then
        (PForm as TS715FDialogStampa).ListaTipologieQuote:=jPairGiust.JsonValue.Value
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

procedure TB028FTestDM.PrintA061(const SelezioneAnagrafica, FilePDF, Operatore, Azienda, DBServer, DatiUtente: WideString);
begin
  //Inizializzo sessione
  AperturaSessione(DBServer,Azienda,Operatore);
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


end.
