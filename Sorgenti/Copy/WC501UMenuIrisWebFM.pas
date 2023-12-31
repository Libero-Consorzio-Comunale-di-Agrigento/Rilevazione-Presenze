unit WC501UMenuIrisWebFM;

interface

uses
  Graphics, Jpeg, pngimage,
  WR206UMenuFM, A000UInterfaccia, A000UCostanti, A000USessione, A000UMessaggi,
  L021Call, C180FunzioniGenerali, Oracle, IWCompJQueryWidget,
  medpIWMessageDlg, meIWImageFile, meIWImage, meIWLink, OracleData,
  SysUtils, Classes, Controls, Forms, IWAppForm, Menus,
  IWVCLBaseContainer, IWColor, IWContainer, IWRegion, IWHTMLContainer,
  IWHTML40Container, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompMenu, ImgList, ActnList,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWApplication, IWTemplateProcessorHTML, meIWMenu, System.Actions;

type
  TWC501FMenuIrisWebFM = class(TWR206FMenuFM)
    FunzioniOperative1: TMenuItem;
    Ricercaanagrafe1: TMenuItem;
    Elencoanagrafe1: TMenuItem;
    Giustificativiasspres1: TMenuItem;
    Pianificazioneorari1: TMenuItem;
    Accessimensa1: TMenuItem;
    SepA01: TMenuItem;
    Reperibili1: TMenuItem;
    Chiamateinreperibilit1: TMenuItem;
    Reperibilita1: TMenuItem;
    Puntoinformativo1: TMenuItem;
    Messaggi1: TMenuItem;
    SepB01: TMenuItem;
    Stampacartellino1: TMenuItem;
    Validazionecartellino1: TMenuItem;
    StampaCedolino1: TMenuItem;
    StampaCUD1: TMenuItem;
    Generatoredistampe1: TMenuItem;
    Anomalie1: TMenuItem;
    SepB02: TMenuItem;
    Schedaanagrafica1: TMenuItem;
    Cartellinointerattivo1: TMenuItem;
    SepB03: TMenuItem;
    Richiestaassenze1: TMenuItem;
    Autorizzazioneassenz1: TMenuItem;
    Prospettoassenze1: TMenuItem;
    Richiestatimbrature1: TMenuItem;
    Autorizzazionetimbrature1: TMenuItem;
    SepB11: TMenuItem;
    Richiestacambioorario1: TMenuItem;
    Autorizzazionecambioorario1: TMenuItem;
    SepB05: TMenuItem;
    Richiestastraordinari1: TMenuItem;
    Autorizzazionestraordinari1: TMenuItem;
    SepB09: TMenuItem;
    Richiestastraordgiornaliero1: TMenuItem;
    Autorizzazionestraordgiornaliero1: TMenuItem;
    SepB10: TMenuItem;
    Richiestamissioni1: TMenuItem;
    Autorizzazionemissioni1: TMenuItem;
    SepB06: TMenuItem;
    Curriculum1: TMenuItem;
    Preferenze1: TMenuItem;
    Schedavalutazioni1: TMenuItem;
    Schedaautovalutazioni1: TMenuItem;
    Pesatureindividuali1: TMenuItem;
    Schedequantitativeindividuali1: TMenuItem;
    SepB07: TMenuItem;
    RichiestaIscrizioneCorsi1: TMenuItem;
    AutorizzIscrizioneCorsi1: TMenuItem;
    Gestionesicurezza1: TMenuItem;
    Gestionesicurezza2: TMenuItem;
    Gestionedeleghe1: TMenuItem;
    Cambioprofilo1: TMenuItem;
    actAnomalie: TAction;
    actCartellino: TAction;
    actReperibilita: TAction;
    actListaReperibili: TAction;
    actGiustificativi: TAction;
    actStampaCartellino: TAction;
    actRichiestaAssenze: TAction;
    actSchedaAnagrafica: TAction;
    actAutorizzazioneAssenze: TAction;
    actNotificheElaborazioni: TAction;
    actCurriculum: TAction;
    actPreferenze: TAction;
    actRichiestaIscrCorsi: TAction;
    actAutorizIscrCorsi: TAction;
    actGeneratoreStampe: TAction;
    actAccessiMensa: TAction;
    actStampaCedolino: TAction;
    actStampaCUD: TAction;
    actRichiestaTimbrature: TAction;
    actAutorizzazioneTimbrature: TAction;
    actGestioneCredenziali: TAction;
    actGestioneDeleghe: TAction;
    actCambioProfilo: TAction;
    actSchedaValutazioni: TAction;
    actSchedaAutovalutazioni: TAction;
    actPianifOrari: TAction;
    actRichiestaStraordinari: TAction;
    actAutorizzazioneStraordinari: TAction;
    actAnagrafeElenco: TAction;
    actRicercaAnagrafe: TAction;
    actClose: TAction;
    actRichiestaCambioOrario: TAction;
    actAutorizzazioneCambioOrario: TAction;
    actRichiestaStraordGG: TAction;
    actAutorizzazioneStraordGG: TAction;
    actChiamateReperibili: TAction;
    actPesatureIndividuali: TAction;
    actTabelloneTurni: TAction;
    actSchedeQuantIndividuali: TAction;
    actRichiestaMissioni: TAction;
    actAutorizzazioneMissioni: TAction;
    actProspettoAssenze: TAction;
    actValidazioneCartellino: TAction;
    actStampaSchedaValutazioni: TAction;
    Stampaschedadivalutazione1: TMenuItem;
    actPubblicazioneDocumenti: TAction;
    SepB08: TMenuItem;
    Pubblicazionedocumenti1: TMenuItem;
    actMessaggistica: TAction;
    Messaggi2: TMenuItem;
    actDetrazioniIRPEF: TAction;
    DetrazioniIRPEF1: TMenuItem;
    abelloneturni1: TMenuItem;
    actTraspDirigenza: TAction;
    Trasparenzacurriculumperdirigenza1: TMenuItem;
    actRichiestaScioperi: TAction;
    actAutorizzazioneScioperi: TAction;
    Richiestascioperi1: TMenuItem;
    SepB12: TMenuItem;
    Autorizzazionescioperi1: TMenuItem;
    actBollatriceVirtuale: TAction;
    Bollatricevirtuale1: TMenuItem;
    actUploadDocumenti: TAction;
    SepA02: TMenuItem;
    Uploaddocumenti1: TMenuItem;
    actInformazioniSu: TAction;
    N1: TMenuItem;
    Informazionisu1: TMenuItem;
    actQueryServizio: TAction;
    Interrogazionidiservizio1: TMenuItem;
    actGestioneDocumentale: TAction;
    Gestionedocumentale1: TMenuItem;
    actDatiConiuge: TAction;
    Datidelconiuge1: TMenuItem;
    actModPersonaleReperibile: TAction;
    Modificapersonalereperibile1: TMenuItem;
    actAcquistoTicket: TAction;
    N2: TMenuItem;
    Acquistoticket1: TMenuItem;
    actCambioAzienda: TAction;
    Cambioazienda1: TMenuItem;
    N3: TMenuItem;
    actIscrizioneOrdiniProf: TAction;
    OrdiniprofessionaliIscrizione1: TMenuItem;
    actCompensazioneSaldoNegativo: TAction;
    Compensazionesaldonegativo1: TMenuItem;
    actDatiGiuridici: TAction;
    Autocertificazionedatigiuridici1: TMenuItem;
    actCertificazioni: TAction;
    actAutorizzazioneCertificazioni: TAction;
    RichiestCertificazioni1: TMenuItem;
    AutorizzazioneCertificazioni1: TMenuItem;
    N4: TMenuItem;
    actRichiestaDocumentale: TAction;
    actAutorizzazioneDocumentale: TAction;
    Richiestadocumentale1: TMenuItem;
    Autorizzazionedocumentale1: TMenuItem;
    actAutorizzazioneBudget: TAction;
    Gestionedelbudget2: TMenuItem;
    actRichiestaBudget: TAction;
    Richiestamodificabudget1: TMenuItem;
    actRichiestaDispTurni: TAction;
    actAutorizzazioneDispTurni: TAction;
    Richiestadisponibilitturni1: TMenuItem;
    Autorizzazionedisponibilitturni1: TMenuItem;
    actDatiAtipici: TAction;
    Datiatipici1: TMenuItem;
    procedure IWFrameRegionRender(Sender: TObject);
    procedure actExecute(Sender: TObject); override;
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    function InformazioniSu:string;
  public
  end;

implementation

// includere qui tutte le unit utilizzate nel menu
uses IWGlobal,
     WR010UBase,
     R010UPaginaWeb,
     R013UIterBase,
     W001UIrisWebDtM,
     W002UAnagrafeScheda,W002URicercaAnagrafe,W002UAnagrafeElenco,
     W003UAnomalie,
     W004UReperibilita,
     W005UCartellino,
     W006UListaReperibili,
     WC023UCambioPasswordFM,
     W008UGiustificativi, W009UStampaCartellino,
     W010URichiestaAssenze,
     W011UNotificheElaborazioni,
     W012UCurriculum, W013UPreferenze, W014UPianifCorsi,
     W015UServerStampe,
     W016UAccessiMensa,
     W017UStampaCedolino,
     W018URichiestaTimbrature,
     W019UGestioneDeleghe,
     W020UCambioProfilo,
     W021UStampaCUD,
     W022USchedaValutazioni,
     W023UPianifOrari,
     W024URichiestaStraordinari,
     W025UCambioOrario,
     W026URichiestaStrGG,
     W027UDetrazioniIRPEF,
     W028UChiamateReperibili,
     W029UPesatureIndividuali,
     W030UTabelloneTurni,
     W031USchedeQuantIndividuali,
     W032URichiestaMissioni,
     W033UProspettoAssenze,
     W034UPubblicazioneDocumenti,
     W035UMessaggistica,
     W036UTraspDirigenza,
     W037URichiestaScioperi,
     W038UBollatriceVirtuale,
     W039UGestioneDocumentale,
     W040UUploadDocumenti,
     W041UQueryServizio,
     W042UDatiConiuge,
     W043UModPersonaleReperibile,
     W044UAcquistoTicket,
     W045UCambioAzienda,
     W046UCompensazioneSaldoNegativo,
     W047UIscrizioneOrdine,
     W049UAutocertificazioneDatiGiuridici,
     W048UCertificazioni,
     W050URichiestaDocumentale,
     W051UBudgetStraordinario,
     W052URichiestaDispTurni,
     W053UDatiAtipici;

{$R *.dfm}

procedure TWC501FMenuIrisWebFM.IWFrameRegionCreate(Sender: TObject);
procedure AccodaAction(pAction: TAction);
var
  i: integer;
begin
  i:=0;
  while i < ActionList.ActionCount do
  try
    if ActionList[i] = pAction then
    begin
      if ActionList[i].Index <> ActionList.ActionCount - 1 then
      begin
        ActionList[i].Index:=ActionList.ActionCount - 1;
        break;
      end;
    end
  finally
    inc(i);
  end;
end;

begin
  inherited;

  //Riordina Actionlist
  AccodaAction(actGestioneCredenziali);
  AccodaAction(actGestioneDeleghe);
  AccodaAction(actCambioAzienda);
  AccodaAction(actCambioProfilo);
end;

procedure TWC501FMenuIrisWebFM.IWFrameRegionRender(Sender: TObject);
begin
  // disabilita ricerca anagrafe se dipendente con inibizione individuale
  if (not WR000DM.Responsabile
  ) and (Parametri.InibizioneIndividuale) then
    actRicercaAnagrafe.Visible:=False;

  // ricerca ed elenco anagrafe sono sempre nascosti nel menu
  Ricercaanagrafe1.Visible:=False;
  Elencoanagrafe1.Visible:=False;

  // abilitazioni menu particolari
  // 1. cambio profilo, gestione deleghe e cambio azienda
  R180SetVariable(WR000DM.selI061,'AZIENDA',Parametri.Azienda);
  R180SetVariable(WR000DM.selI061,'NOME_UTENTE',Parametri.Operatore);
  WR000DM.selI061.Open;

  // abilitazione del cambio profilo (l'utente deve avere pi¨ profili)
  actCambioProfilo.Visible:=(actCambioProfilo.Visible) and (WR000DM.selI061.RecordCount > 1);

  // abilitazione delega profilo (il profilo web deve esistere (* e non deve essere delegato*))
  if (WR000DM.selI061.RecordCount > 0) and (Parametri.ProfiloWEB <> '') then
  begin
    if WR000DM.selI061.SearchRecord('NOME_PROFILO',Parametri.ProfiloWEB,[srFromBeginning]) then
      actGestioneDeleghe.Visible:=(actGestioneDeleghe.Visible)(* and (WR000DM.selI061.FieldByName('DELEGATO_DA').IsNull)*)
    else
      actGestioneDeleghe.Visible:=False;
  end
  else
    actGestioneDeleghe.Visible:=False;

  // abilitazione del cambio azienda
  actCambioAzienda.Visible:=actCambioAzienda.Visible and WR000DM.IsCambioAziendaAbilitato;

  // 2. disabilita "autorizzazione ecced. giornaliere" in base a parametro aziendale C90_W026TipoRichiesta
  // cfr. R010UPaginaWeb.FormRender
  if (Parametri.CampiRiferimento.C90_W026TipoRichiesta = 'A') and
     (actRichiestaStraordGG.Visible) and
     (actAutorizzazioneStraordGG.Visible) then
  begin
    // nasconde la action di autorizzazione ecced. gg.
    // e modifica la caption e l'icona dell'action di richiesta
    actRichiestaStraordGG.Caption:=actAutorizzazioneStraordGG.Caption;
    actRichiestaStraordGG.Hint:=actAutorizzazioneStraordGG.Caption;
    actRichiestaStraordGG.ImageIndex:=actAutorizzazioneStraordGG.ImageIndex;
    actAutorizzazioneStraordGG.Visible:=False;
  end;

  inherited;
end;

function TWC501FMenuIrisWebFM.InformazioniSu:string;
var
  listaModuliInstallati:string;
begin
  listaModuliInstallati:='';
  if Parametri.ModuliInstallati = '' then
    listaModuliInstallati:='nessuno'
  else
    listaModuliInstallati:=Parametri.ModuliInstallati;

  Result:='IrisWEB' + #13#10 +
          'Versione: ' + Parametri.VersionePJ + ' (' + Parametri.BuildPJ  + ')' + #13#10 +
          'Data di rilascio: ' + Parametri.DataPJ + #13#10 + #13#10 +
          'by Mondo Edp';
end;

procedure TWC501FMenuIrisWebFM.actExecute(Sender: TObject);
// gestione azioni menu
var
  WC023: TWC023FCambioPasswordFM;
  MyForm: TWR010FBase;
  Ok: Boolean;
begin
  {Gestione pressione informazioni}
  if Sender = actInformazioniSu then
  begin
    MsgBox.MessageBox(InformazioniSu,INFORMA,'Informazioni su...');
    Exit;
  end;
  try
    inherited;
  except
    on E: EAbort do
      Exit;
  end;

  // EMPOLI_ASL11 - commessa 2015/103 SVILUPPO#2.ini
  // la funzione messaggistica di irisweb,
  // se associata ad un parametro aziendale,
  // pu˛ impedire l'apertura delle altre funzioni fino a quando
  // sono presenti messaggi con lettura obbligatoria
  MyForm:=(Self.Parent as TWR010FBase);
  if (A000GetInibizioni('Tag','445') <> 'N') and (Parametri.CampiRiferimento.C90_MessaggiObbligatoriBloccanti = 'S') then
  begin
    Ok:=// ok in caso di chiusura del form W035
        ((MyForm.Tag = 445) and (MyForm.IsPageClosing)) or
        // ok in caso di apertura o passaggio a determinate funzioni
        (R180In(FTag,
                [445,    // W035 - messaggistica
                 421,    // W020 - cambio profilo
                 453,    // W045 - cambio azienda
                  -2,    // W002 - anagrafe elenco
                  -1])); // W002 - ricerca anagrafe
    if not Ok then
    begin
      if WR000DM.GetNumMsgDaLeggere.LetturaObbligatoria > 0 then
      begin
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_WC501_ERR_MESSAGGI_LETT_OBBL),INFORMA);
        Exit;
      end;
    end;
  end;
  // EMPOLI_ASL11 - commessa 2015/103 SVILUPPO#2.fine

  // forza il refresh dei dati se la form viene riutilizzata
  if not NewForm then
    F.RefreshPageAttivo:=True;

  // 1. Parte speciale: ricerca ed elenco anagrafe
  // ricerca anagrafe
  if (Sender = actRicercaAnagrafe) or (FTag = -1) then //era 428 prima della 8.6
  begin
    with (F as TW002FRicercaAnagrafe) do
    begin
      if WR000DM.AccessoDirettoValutatore <> 'N' then
        VisualizzaCessati:=True
      else
        VisualizzaCessati:=Parametri.InibizioneIndividuale;
      OpenPage; //???
      //Show;//???
    end;
    Exit;
  end
  else if (Sender = actAnagrafeElenco) or (FTag = -2) then // era 429 prima della 8.6
  begin
    F.Show;
    Exit;
  end;

  // 2. Parte indipendente dalla selezione anagrafica
  // gestione sicurezza utente corrente
  if (Sender = actGestioneCredenziali) or (FTag = 415) then
  begin
    WC023:=TWC023FCambioPasswordFM.Create(Self.Parent);//(A000App);
    WC023.Visualizza;
    Exit;
  end
  else if (Sender = actGestioneDeleghe) or (FTag = 420) then
  begin
    if NewForm then
      F:=TW019FGestioneDeleghe.Create(A000App);
    F.Show;
    Exit;
  end
  else if (Sender = actCambioProfilo) or (FTag = 421) then
  begin
    if NewForm then
      F:=TW020FCambioProfilo.Create(A000App);
    F.Show;
    Exit;
  end
  else if (Sender = actCambioAzienda) or (FTag = 453) then
  begin
    if NewForm then
      F:=TW045FCambioAzienda.Create(A000App);
    F.Show;
    Exit;
  end;

  // 3. Parte in funzione della selezione anagrafica
  // verifica selezione anagrafica
  if (WR000DM.cdsAnagrafe.RecordCount = 0) and (WR000DM.AccessoDirettoValutatore = 'N') then
  begin
    MsgBox.MessageBox('Nessuna anagrafica selezionata',INFORMA);
    Exit;
  end;

  if (Sender = actCartellino) or (FTag = 400) then
  begin
    // 400 - cartellino interattivo
    if NewForm then
    begin
      F:=TW005FCartellino.Create(A000App);
      (F as TW005FCartellino).InizializzaDaMainMenu;
    end;
  end
  else if (Sender = actDatiAtipici) or (FTag = 464) then
  begin
    // 464 - registrazione dati atipici
    if NewForm then
    begin
      F:=TW053FDatiAtipici.Create(A000App);
    end;
  end
  else if (Sender = actGiustificativi) or (FTag = 401) then
  begin
    // 401 - giustificativi ass./pres.
    if NewForm then
    begin
      F:=TW008FGiustificativi.Create(A000App);
      F.SetParam('DAL',Parametri.DataLavoro);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAnomalie) or (FTag = 402) then
  begin
    // 402 - anomalie
    if NewForm then
      F:=TW003FAnomalie.Create(A000App);
  end
  else if (Sender = actReperibilita) or (FTag = 403) then
  begin
    // 403 - pianificazione reperibilitÓ
    if NewForm then
      F:=TW004FReperibilita.Create(A000App);
  end
  else if (Sender = actListaReperibili) or (FTag = 404) then
  begin
    // 404 - elenco reperibili
    if NewForm then
      F:=TW006FListaReperibili.Create(A000App);
  end
  else if (Sender = actStampaCartellino) or (FTag = 405) then
  begin
    // 405 - stampa cartellino
    if NewForm then
      F:=TW009FStampaCartellino.Create(A000App);
    F.SetParam('TAG','405');
  end
  else if (Sender = actRichiestaAssenze) or (FTag = 406) then
  begin
    // 406 - richiesta giustificativi
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW010FRichiestaAssenze.Create(A000App);
      F.SetParam('DAL',Parametri.DataLavoro);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneAssenze) or (FTag = 407) then
  begin
    // 407 - autorizzazione giustificativi
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW010FRichiestaAssenze.Create(A000App);
      F.SetParam('DAL',Parametri.DataLavoro);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actNotificheElaborazioni) or (FTag = 408) then
  begin
    // 408 - messaggi
    if NewForm then
      F:=TW011FNotificheElaborazioni.Create(A000App);
  end
  else if (Sender = actCurriculum) or (FTag = 409) then
  begin
    // 409 - Curriculum
    if NewForm then
      F:=TW012FCurriculum.Create(A000App);
  end
  else if (Sender = actPreferenze) or (FTag = 410) then
  begin
    // 410 - preferenze
    if NewForm then
      F:=TW013FPreferenze.Create(A000App);
  end
  else if (Sender = actRichiestaIscrCorsi) or (FTag = 411) then
  begin
    // 411 - richiesta corsi
    WR000DM.Responsabile:=False;
    if NewForm then
      F:=TW014FPianifCorsi.Create(A000App);
  end
  else if (Sender = actSchedaAnagrafica) or (FTag = 412) then
  begin
    // 412 - scheda anagrafica
    if NewForm then
    begin
      F:=TW002FAnagrafeScheda.Create(A000App);
      F.SetParam('MATRICOLA',WR000DM.cdsAnagrafe.FieldByName('MATRICOLA').AsString);
      F.SetParam('CAPTION_INDIETRO','Elenco anagrafe');
      F.SetParam('COMPLETA',True);
    end;
  end
  else if (Sender = actAutorizIscrCorsi) or (FTag = 413) then
  begin
    // 413 - autorizzazione corsi
    WR000DM.Responsabile:=True;
    if NewForm then
      F:=TW014FPianifCorsi.Create(A000App);
  end
  else if (Sender = actGeneratoreStampe) or (FTag = 414) then
  begin
    // 414 - generatore di stampe
    if NewForm then
      F:=TW015FServerStampe.Create(A000App);
  end
  else if (Sender = actAccessiMensa) or (FTag = 416) then
  begin
    // 416 - accessi mensa
    if NewForm then
      F:=TW016FAccessiMensa.Create(A000App);
  end
  else if (Sender = actStampaCedolino) or (FTag = 417) then
  begin
    // 417 - stampa cedolino
    if NewForm then
      F:=TW017FStampaCedolino.Create(A000App);
  end
  else if (Sender = actRichiestaTimbrature) or (FTag = 418) then
  begin
    // 418 - richiesta modifica timbrature
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW018FRichiestaTimbrature.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneTimbrature) or (FTag = 419) then
  begin
    // 419 - autorizzazione modifica timbrature
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW018FRichiestaTimbrature.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actStampaCUD) or (FTag = 422) then
  begin
    // 422 - stampa CUD
    if NewForm then
      F:=TW021FStampaCUD.Create(A000App);
  end
  else if (Sender = actSchedaValutazioni) or (FTag = 423) then
  begin
    // 423 - scheda di valutazione
    WR000DM.TipoValutazione:='V';
    WR000DM.SoloStampa:=False;
    if NewForm then
    begin
      F:=TW022FSchedaValutazioni.Create(A000App);
      //TW022FSchedaValutazioni(F).SoloStampa:=False;
    end;
  end
  else if (Sender = actSchedaAutovalutazioni) or (FTag = 424) then
  begin
    // 424 - scheda di autovalutazione
    WR000DM.TipoValutazione:='A';
    WR000DM.SoloStampa:=False;
    if NewForm then
    begin
      F:=TW022FSchedaValutazioni.Create(A000App);
      //TW022FSchedaValutazioni(F).SoloStampa:=False;
    end;
  end
  else if (Sender = actPianifOrari) or (FTag = 425) then
  begin
    // 425 - pianificazione orari giornaliera
    if NewForm then
    begin
      F:=TW023FPianifOrari.Create(A000App);
      F.SetParam('AL',DATE_NULL);
    end;
  end
  else if (Sender = actRichiestaStraordinari) or (FTag = 426) then
  begin
    // 426 - richiesta straordinari
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW024FRichiestaStraordinari.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneStraordinari) or (FTag = 427) then
  begin
    // 427 - autorizzazione straordinari
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW024FRichiestaStraordinari.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actRichiestaScioperi) or (FTag = 428) then
  begin
    // 428 - notifica adesione scioperi
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW037FRichiestaScioperi.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneScioperi) or (FTag = 429) then
  begin
    // 429 - autorizzazione adesione scioperi
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW037FRichiestaScioperi.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actRichiestaCambioOrario) or (FTag = 430) then
  begin
    // 430 - richiesta cambio orario
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW025FCambioOrario.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneCambioOrario) or (FTag = 431) then
  begin
    // 431 - autorizzazione cambio orario
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW025FCambioOrario.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actRichiestaStraordGG) or (FTag = 432) then
  begin
    // 432 - richiesta eccedenze giornaliere
    WR000DM.Responsabile:=False;
    if NewForm then
      F:=TW026FRichiestaStrGG.Create(A000App);
  end
  else if (Sender = actAutorizzazioneStraordGG) or (FTag = 433) then
  begin
    // 433 - autorizzazione eccedenze giornaliere
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW026FRichiestaStrGG.Create(A000App);
      if Parametri.CampiRiferimento.C90_W026TipoStraord = 'A' then
      begin
        // TORINO_COMUNE
        F.SetParam('DAL',EncodeDate(1900,1,1));
        F.SetParam('AL',EncodeDate(3999,12,31));
      end
      else
      begin
        F.SetParam('DAL',Date - 1);
        F.SetParam('AL',Date - 1);
      end;
    end;
  end
  else if (Sender = actDetrazioniIRPEF) or (FTag = 434) then
  begin
    // 434 - Detrazioni fiscali
    if NewForm then
    begin
      F:=TW027FDetrazioniIRPEF.Create(A000App);
    end;
  end
  else if (Sender = actChiamateReperibili) or (FTag = 435) then
  begin
    // 435 - Registrazione chiamate in reperibilitÓ
    if NewForm then
    begin
      F:=TW028FChiamateReperibili.Create(A000App);
      F.SetParam('AL',DATE_NULL);
    end;
  end
  else if (Sender = actPesatureIndividuali) or (FTag = 436) then
  begin
    // 436 - Pesature individuali incentivi
    if NewForm then
    begin
      F:=TW029FPesatureIndividuali.Create(A000App);
      F.SetParam('AL',DATE_NULL);
      (F as TW029FPesatureIndividuali).GetPesiDip;
    end;
  end
  else if (Sender = actProspettoAssenze) or (FTag = 437) then
  begin
    // 437 - Prospetto assenze
    if NewForm then
    begin
      F:=TW033FProspettoAssenze.Create(A000App);
      F.SetParam('DAL',R180InizioMese(Parametri.DataLavoro));
      F.SetParam('AL',R180FineMese(Parametri.DataLavoro));
      F.SetParam('SINGOLO',False);
    end;
  end
  else if (Sender = actTabelloneTurni) or (FTag = 438) then
  begin
    // 438 - Tabellone Turni
    if NewForm then
    begin
      F:=TW030FTabelloneTurni.Create(A000App);
      F.SetParam('DAL',R180InizioMese(Parametri.DataLavoro));
      F.SetParam('AL',R180FineMese(Parametri.DataLavoro));
      F.SetParam('SINGOLO',False);
    end;
  end
  else if (Sender = actSchedeQuantIndividuali) or (FTag = 439) then
  begin
    // 439 - Schede quantitative individuali incentivi
    if NewForm then
    begin
      F:=TW031FSchedeQuantIndividuali.Create(A000App);
      F.SetParam('AL',DATE_NULL);
      (F as TW031FSchedeQuantIndividuali).GetSchedeDip;
    end;
  end
  else if (Sender = actRichiestaMissioni) or (FTag = 440) then
  begin
    // 440 - Richiesta missioni
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW032FRichiestaMissioni.Create(A000App);
    end;
  end
  else if (Sender = actAutorizzazioneMissioni) or (FTag = 441) then
  begin
    // 441 - Autorizzazione missioni
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW032FRichiestaMissioni.Create(A000App);
      F.SetParam('DAL',R180InizioMese(Parametri.DataLavoro));
      F.SetParam('AL',R180FineMese(Parametri.DataLavoro));
    end;
  end
  else if (Sender = actValidazioneCartellino) or (FTag = 442) then
  begin
    // 442 - iter validazione cartellino
    WR000DM.Responsabile:=True;
    if NewForm then
      F:=TW009FStampaCartellino.Create(A000App);
    F.SetTag(442);
  end
  else if (Sender = actStampaSchedaValutazioni) or (FTag = 443) then
  begin
    // 443 - stampa scheda di valutazione
    WR000DM.TipoValutazione:='V';
    WR000DM.SoloStampa:=True;
    if NewForm then
    begin
      F:=TW022FSchedaValutazioni.Create(A000App);
      //TW022FSchedaValutazioni(F).SoloStampa:=True;
    end;
  end
  else if (Sender = actPubblicazioneDocumenti) or (FTag = 444) then
  begin
    WR000DM.Responsabile:=False;
    if NewForm then
      F:=TW034FPubblicazioneDocumenti.Create(A000App);
  end
  else if (Sender = actMessaggistica) or (FTag = 445) then
  begin
    if NewForm then
      F:=TW035FMessaggistica.Create(A000App);
  end
  else if (Sender = actTraspDirigenza) or (FTag = 446) then
  begin
    if NewForm then
      F:=TW036FTraspDirigenza.Create(A000App);
  end
  else if (Sender = actUploadDocumenti) or (FTag = 449) then
  begin
    // 449 - upload documenti
    if NewForm then
      F:=TW040FUploadDocumenti.Create(A000App);
  end
  else if (Sender = actBollatriceVirtuale) or (FTag = 451) then
  begin
    // 451 - bollatrice virtuale
    if NewForm then
      F:=TW038FBollatriceVirtuale.Create(A000App);
  end
  else if (Sender = actQueryServizio) or (FTag = 447) then
  begin
    // 447 - Interrogazioni si servizio
    if NewForm then
      F:=TW041FQueryServizio.Create(A000App);
  end
  else if (Sender = actGestioneDocumentale) or (FTag = 448) then
  begin
    // 448 - gestione documentale
    if NewForm then
      F:=TW039FGestioneDocumentale.Create(A000App);
  end
  else if (Sender = actDatiConiuge) or (FTag = 450) then
  begin
    // 450 - dati coniuge
    if NewForm then
      F:=TW042FDatiConiuge.Create(A000App);
  end
  else if (Sender = actModPersonaleReperibile) or (FTag = 452) then
  begin
    // 452 - modifica personale reperibile
    if NewForm then
      F:=TW043FModPersonaleReperibile.Create(A000App);
  end
  else if (Sender = actAcquistoTicket) or (FTag = 466) then
  begin
    // 466 - acquisto ticket
    if NewForm then
      F:=TW044FAcquistoTicket.Create(A000App);
  end
  else if (Sender = actIscrizioneOrdiniProf) or (FTag = 467) then
  begin
    // 467 - Iscrizione Ordine professionale
    if NewForm then
      F:=TW047FIscrizioneOrdine.Create(A000App);
  end
  else if (Sender = actCompensazioneSaldoNegativo) or (FTag = 454) then
  begin
    // 454 - compensazione saldo negativo
    if NewForm then
      F:=TW046FCompensazioneSaldoNegativo.Create(A000App);
  end
  else if (Sender = actDatiGiuridici) or (FTag = 465) then
  begin
    // 465 - Autocertificazione dati giuridici
    if NewForm then
      F:=TW049FAutocertificazioneDatiGiuridici.Create(A000App);
  end
  else if (Sender = actCertificazioni) or (FTag = 455) then
  begin
    // 455 - Certificazioni
    WR000DM.Responsabile:=False;
    if NewForm then
      F:=TW048FCertificazioni.Create(A000App);
  end
  else if (Sender = actAutorizzazioneCertificazioni) or (FTag = 456) then
  begin
    //456 - Autorizzazione certificazioni
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW048FCertificazioni.Create(A000App);
      //F.SetParam('DAL',R180InizioMese(Parametri.DataLavoro));
      //F.SetParam('AL',R180FineMese(Parametri.DataLavoro));
    end;
  end
  else if (Sender = actRichiestaDocumentale) or (FTag = 457) then
  begin
    // 457 - richiesta documentale
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW050FRichiestaDocumentale.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneDocumentale) or (FTag = 458) then
  begin
    // 458 - autorizzazione documentale
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW050FRichiestaDocumentale.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneBudget) or (FTag = 460) then
  begin
    // 460 - budget straordinario
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW051FBudgetStraordinario.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actRichiestaBudget) or (FTag = 461) then
  begin
    // 461 - richiesta budget
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW051FBudgetStraordinario.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actRichiestaDispTurni) or (FTag = 462) then
  begin
    // 462 - richiesta disponibilitÓ turni
    WR000DM.Responsabile:=False;
    if NewForm then
    begin
      F:=TW052FRichiestaDispTurni.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end
  else if (Sender = actAutorizzazioneDispTurni) or (FTag = 463) then
  begin
    // 463 - autorizzazione disponibilitÓ turni
    WR000DM.Responsabile:=True;
    if NewForm then
    begin
      F:=TW052FRichiestaDispTurni.Create(A000App);
      F.SetParam('AL',Parametri.DataLavoro);
    end;
  end;

  // gestione generica
  if F <> nil then
  begin
    if NewForm then
    begin
      // imposta parametri standard se non indicati
      // - progressivo
      if F.GetParam('PROGRESSIVO') = '' then
        F.SetParam('PROGRESSIVO',(Self.Parent as TR010FPaginaWeb).medpProgressivo);

      // procedura di open
      F.OpenPage;
    end
    else
    begin
      F.RefreshPageAttivo:=True;
      F.Show;
    end;
  end;
end;

end.
