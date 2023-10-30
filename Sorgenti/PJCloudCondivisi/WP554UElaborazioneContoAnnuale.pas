unit WP554UElaborazioneContoAnnuale;

interface

uses
  WP554UElaborazioneContoAnnualeDM, P554UElaborazioneContoAnnualeMW,
  WP554UImpostazioniFM, WC022UMsgElaborazioneFM,
  P948UCalcoloContoAnnualeDtm, C004UParamForm, C180FunzioniGenerali,
  WR100UBase, A000UInterfaccia, A000UCostanti, Oracle, OracleData,
  A000USessione, System.SysUtils, System.Variants,
  System.Classes, Vcl.Controls,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton,
  meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  IWCompCheckbox, meIWCheckBox, meIWRadioGroup, IWTMSCheckList,
  meTIWCheckListBox, meIWImageButton, StrUtils, System.IOUtils, Math,
  IWApplication, meIWImageFile, medpIWImageButton, A000UMessaggi,
  medpIWMessageDlg, Vcl.Menus,
  medpIWMultiColumnComboBox, C190FunzioniGeneraliWeb, IWCompJQueryWidget;

type
  TDatiFormattaDato = record
    Valore:Real;
    Anomalia:String;
  end;

  TWP554FElaborazioneContoAnnuale = class(TWR100FBase)
    lblAnno: TmeIWLabel;
    edtAnno: TmeIWEdit;
    lblMeseDa: TmeIWLabel;
    edtMeseDa: TmeIWEdit;
    lblMeseA: TmeIWLabel;
    edtMeseA: TmeIWEdit;
    chkElaboraDatiCONTANN: TmeIWCheckBox;
    chkElaboraRiepiloghi: TmeIWCheckBox;
    chkElabRisorseResidue: TmeIWCheckBox;
    chkEsportazione: TmeIWCheckBox;
    rgpStatoCedolini: TmeIWRadioGroup;
    chkAnnulla: TmeIWCheckBox;
    chkChiusura: TmeIWCheckBox;
    lblDataChiusura: TmeIWLabel;
    edtDataChiusura: TmeIWEdit;
    btnImpostazioni: TmeIWButton;
    lblTabelle: TmeIWLabel;
    clbTabElab: TmeTIWCheckListBox;
    btnAnno: TmeIWButton;
    lblStatoCedolini: TmeIWLabel;
    btnEsegui: TmedpIWImageButton;
    btnVisualizzaFile: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    lblCodAziendaBase: TmeIWLabel;
    cmbCodAziendaBase: TMedpIWMultiColumnComboBox;
    lblDAziendaBase: TmeIWLabel;
    chkEseguiScriptIniziali: TmeIWCheckBox;
    chkSvuotaTabella: TmeIWCheckBox;
    JQuery: TIWJQueryWidget;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtMeseAAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure btnAnomalieClick(Sender: TObject);
    procedure btnVisualizzaFileClick(Sender: TObject);
    procedure clbTabElabAsyncCheckClick(Sender: TObject;
      EventParams: TStringList; Index: Integer; Check: LongBool);
    procedure btnAnnoClick(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnImpostazioniClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure cmbCodAziendaBaseAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure chkElaboraDatiCONTANNClick(Sender: TObject);
  private
    WP554DM: TWP554FElaborazioneContoAnnualeDM;
    P948DM: TP948FCalcoloContoAnnualeDtm;
    WP554ImpostazioniFM: TWP554FImpostazioniFM;
    //Id della testata CONTANN Mensile aperta
    Id_FLUSSO_Aperto,AnnoRegole:Integer;
    //PercorsoFileAnomalie: String;
    PresenzaAnomalie,FileGenerato: Boolean;
    DatiDaElaborare,sMesFornManc: String;
    IdDaElaborare: TStringList;
    bCancellaId: boolean;
    //Variabili per calcolo
    DatiInpP948:TDatiInpP948;
    StopElaborazione: Boolean;
    procedure CalcoloRiepiloghi;
    procedure RidistribuzioneRisorseResidue;
    function GestioneAnomalie(sTipo: String): String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure DisabilitaComponenti;
    procedure AbilitaComponenti;
    procedure AbilitazioniIniziali;
    function FormattaDato(sCodArrotondamento: String; rDato: Real):TDatiFormattaDato;
    procedure CaricaIdFlusso(sStato: String);
    procedure ChiusuraFornitura;
    procedure EsportazioneFile;
    procedure GeneraFile(Nome: String);
    procedure Esegui_Step1;
    procedure OnResultEsegui(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
    procedure ElaborazioneDipendenti;
    procedure AfterElaborazione_Step1;
    procedure AfterElaborazione_Step2;
    procedure OnResultAfterElaborazione(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
    procedure CaricaElencoTabelle;
    procedure CaricaMultiColumnCombobox;
    procedure AggiornaDescrizioneAziendaBase;
    procedure AbilitaAziendaBase;
  protected
    procedure ImpostazioniWC700; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure InizializzaMsgElaborazione; override;
    procedure ElaborazioneServer; override;
    procedure AfterElaborazione; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DistruggiOggetti; override;
  public
    sAnomalia: String;
    ListaDati:TStringList;
    vTabElab:array of TTabElab;
    Comparto,TipoOper,Regione,Azienda,DSM,Istituto,NomeFile:String;
    function  InizializzaAccesso:Boolean; override;
    procedure ConfermaImpostazioni(PImpostazioni: TImpostazioni);
    procedure AnnullaImpostazioni;
  end;

implementation

{$R *.dfm}

uses
  WC700USelezioneAnagrafeFM, IWGlobal, IW.Common.System;

{ TWP554FElaborazioneContoAnnuale }

function TWP554FElaborazioneContoAnnuale.InizializzaAccesso: Boolean;
begin
  Result:=True;
end;

procedure TWP554FElaborazioneContoAnnuale.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  WP554DM:=TWP554FElaborazioneContoAnnualeDM.Create(Self);
  AttivaGestioneC700;
  WP554DM.P554MW.selAnagrafe:=grdC700.selAnagrafe;

  P948DM:=TP948FCalcoloContoAnnualeDtm.Create(nil);
  P948DM.P554MW:=WP554DM.P554MW;

  //Inizializzo lista id
  ListaDati:=TStringList.Create;
  IdDaElaborare:=TStringList.Create;
  A000SettaVariabiliAmbiente;

  if edtDataChiusura.Text = '  /  /    ' then
    edtDataChiusura.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  GetParametriFunzione;

  //Disabilito anomalie
  btnAnomalie.Enabled:=False;
  btnVisualizzaFile.Enabled:=False;
  //Impostazione abilitazioni iniziali sui componenti
  chkElaboraDatiCONTANNClick(nil);//sistema i flag ed estrae le aziende disponibili
end;

procedure TWP554FElaborazioneContoAnnuale.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWP554FElaborazioneContoAnnuale.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    // imposta a nil il puntatore al frame delle impostazioni quando ne viene effettuata la free
    if AComponent = WP554ImpostazioniFM then
    begin
      WP554ImpostazioniFM:=nil;
    end;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.DistruggiOggetti;
begin
  try ListaDati.Free; except end;
  try IdDaElaborare.Free; except end;
  try FreeAndNil(WP554DM); except end;
  try FreeAndNil(P948DM); except end;
end;

procedure TWP554FElaborazioneContoAnnuale.Selezionatutto1Click(Sender: TObject);
var
 i:Integer;
begin
  for i:=0 to clbTabElab.Items.Count - 1 do
    clbTabElab.Selected[i]:=True;
  clbTabElab.AsyncUpdate;
end;

procedure TWP554FElaborazioneContoAnnuale.Deselezionatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to clbTabElab.Items.Count - 1 do
    clbTabElab.Selected[i]:=False;
  clbTabElab.AsyncUpdate;
end;

procedure TWP554FElaborazioneContoAnnuale.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to clbTabElab.Items.Count - 1 do
    clbTabElab.Selected[i]:=not clbTabElab.Selected[i];
  clbTabElab.AsyncUpdate;
end;

procedure TWP554FElaborazioneContoAnnuale.CaricaIdFlusso(sStato:String);
//Carico gli id conto annuale dell'anno delle tabelle selezionate
var
  i: Integer;
begin
  with WP554DM.P554MW do
  begin
    DatiDaElaborare:='';
    seleP554.SetVariable('Anno',edtAnno.Text);
    if Trim(sStato) = '' then
      seleP554.SetVariable('Stato','''S'',''N''')
    else
      seleP554.SetVariable('Stato','''' + sStato + '''');
    seleP554.Close;
    seleP554.Open;
    sMesFornManc:='';
    while not seleP554.Eof do
    begin
      for i:=0 to High(vTabElab) do
      begin
        if vTabElab[i].CodiceTabella = seleP554.FieldByName('COD_TABELLA').AsString then
        begin
          //***if clbTabElab.Checked[i] then
          if clbTabElab.Selected[i] then
          begin
            if DatiDaElaborare <> '' then
              DatiDaElaborare:=DatiDaElaborare + ',';
            DatiDaElaborare:=DatiDaElaborare + seleP554.FieldByName('ID_CONTOANN').AsString;
            sMesFornManc:=sMesFornManc + ' Anno: ' + edtAnno.Text + ' Tabella: ' + seleP554.FieldByName('COD_TABELLA').AsString + #13#10;
          end;
          break;
        end;
      end;
      seleP554.Next;
    end;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.CalcoloRiepiloghi;
//Calcolo riepiloghi
var
  sCodArrotondamento:String;
  DatiFormattaDato:TDatiFormattaDato;
begin
  if Id_FLUSSO_Aperto <= 0 then
  begin
    sAnomalia:='Non esiste la tabella ' + DatiInpP948.CodTabella + ' dell''anno aperta di cui calcolare i riepiloghi '#13#10;
    GestioneAnomalie('C');
    AbilitaComponenti;
    exit;
  end;
  //***screen.Cursor:=crHourglass;
  DisabilitaComponenti;

  with WP554DM.P554MW do
  begin
    //Apertura query per estrarre i codici arrotondamento per tutte le tabelle dell'anno
    if (selP552b.GetVariable('AnnoElaborazione') <> DatiInpP948.AnnoElaborazione) then
    begin
      selP552b.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
      selP552b.Close;
      selP552b.Open;
    end;
    //Cancellazione eventuali riepiloghi già esistenti per la stessa dichiarazione
    delP555b.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
    delP555b.Execute;
    //Lettura e somma dei dati riepilogativi
    selP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
    selP555.SetVariable('CodAziendaBase',cmbCodAziendaBase.Text);
    selP555.SetVariable('DataElaborazione',StrToDate('31/12/' + DatiInpP948.AnnoElaborazione));
    selP555.Close;
    selP555.Open;
    sAnomalia:='';
    while not selP555.Eof do
    begin
      sCodArrotondamento:='';
      if ((DatiInpP948.TipoTabellaRighe = '0') or (DatiInpP948.TipoTabellaRighe = '1')) and
         (selP552b.SearchRecord('COD_TABELLA;COLONNA',VarArrayOf([DatiInpP948.CodTabella,selP555.FieldByName('COLONNA').AsInteger]),[srFromBeginning])) then
        sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString
      //Nel caso di tabelle con dati registrati su righe diverse verifico cambio righe
      else if (DatiInpP948.TipoTabellaRighe = '2') and
         (selP552b.SearchRecord('COD_TABELLA;RIGA',VarArrayOf([DatiInpP948.CodTabella,selP555.FieldByName('RIGA').AsInteger]),[srFromBeginning])) then
        sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
      //Registrazione riepiloghi per la dichiarazione
      DatiFormattaDato:=FormattaDato(sCodArrotondamento, selP555.FieldByName('DATO').AsFloat);
      if (DatiFormattaDato.Anomalia <> '') and (sAnomalia = '') then
         sAnomalia:=DatiFormattaDato.Anomalia + #13#10;
      insP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
      insP555.SetVariable('Riga',selP555.FieldByName('RIGA').AsInteger);
      insP555.SetVariable('Colonna',selP555.FieldByName('COLONNA').AsInteger);
      insP555.SetVariable('Valore',DatiFormattaDato.Valore);
      insP555.Execute;
      selP555.Next;
    end;
    if sAnomalia <> '' then
      GestioneAnomalie('C');
    SessioneOracle.Commit;
  end;
  AbilitaComponenti;
  //***screen.Cursor:=crDefault;
end;

procedure TWP554FElaborazioneContoAnnuale.RidistribuzioneRisorseResidue;
//Ridistribuzione risorse residue su riepilogo
var
  sCodArrotondamento :String;
  IdFlussoQuote:Integer;
  DatiFormattaDato:TDatiFormattaDato;
begin
  //Verifico esistenza id conto annuale aperto
  if Id_FLUSSO_Aperto <= 0 then
  begin
    sAnomalia:='Non esiste tabella dell''anno aperta su cui ridistribuire le risorse residue '#13#10;
    GestioneAnomalie('C');
    AbilitaComponenti;
    exit;
  end;
  //***screen.Cursor:=crHourglass;
  DisabilitaComponenti;
  with WP554DM.P554MW do
  begin
    //Apertura query per estrarre i codici arrotondamento per tutte le tabelle dell'anno
    if (selP552b.GetVariable('AnnoElaborazione') <> DatiInpP948.AnnoElaborazione) then
    begin
      selP552b.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
      selP552b.Close;
      selP552b.Open;
    end;
    //Lettura e somma dei dati riepilogativi
    selP553.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
    selP553.SetVariable('CodTabella',DatiInpP948.CodTabella);
    selP553.Close;
    selP553.Open;
    while not selP553.Eof do
    begin
      sCodArrotondamento:='';
      //Nel caso di tabella tipo Accorpamento voci aggiorno direttamente l'importo sulla corrispondente riga
      if DatiInpP948.TipoTabellaRighe = '2' then
      begin
        if selP552b.SearchRecord('COD_TABELLA;RIGA',VarArrayOf([DatiInpP948.CodTabella,selP553.FieldByName('COLONNA_RIGA').AsInteger]),[srFromBeginning]) then
          sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
        DatiFormattaDato:=FormattaDato(sCodArrotondamento, selP553.FieldByName('IMPORTO_RESIDUO').AsFloat);
        updP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
        updP555.SetVariable('Riga',selP553.FieldByName('COLONNA_RIGA').AsInteger);
        updP555.SetVariable('Colonna',1);
        updP555.SetVariable('ImportoResiduo',DatiFormattaDato.Valore);
        updP555.Execute;
        if updP555.RowsProcessed = 0 then
        begin
          sAnomalia:='Non esiste il dato su cui ridistribuire il residuo Tabella: ' + DatiInpP948.CodTabella
          + ' Riga: ' + selP553.FieldByName('COLONNA_RIGA').AsString + #13#10;
          GestioneAnomalie('C');
        end
        else if DatiFormattaDato.Anomalia <> '' then
        begin
          sAnomalia:=DatiFormattaDato.Anomalia + #13#10;
          GestioneAnomalie('C');
        end;
      end
      //Nel caso di tabella tipo Qualifiche ministeriali occorre gestire l'aggiornamento delle singole righe una per ogni
      //qualifica
      else if DatiInpP948.TipoTabellaRighe = '0' then
      begin
        if selP552b.SearchRecord('COD_TABELLA;COLONNA',VarArrayOf([DatiInpP948.CodTabella,selP553.FieldByName('COLONNA_RIGA').AsInteger]),[srFromBeginning]) then
          sCodArrotondamento:=selP552b.FieldByName('COD_ARROTONDAMENTO').AsString;
        IdFlussoQuote:=Id_FLUSSO_Aperto;
        if DatiInpP948.CodTabella <> selP553.FieldByName('COD_TABELLA_QUOTE').AsString then
        begin
          //Lettura ID tabella da cui leggere le quote
          selP554.SetVariable('Anno',edtAnno.Text);
          selP554.SetVariable('CodTabella',selP553.FieldByName('COD_TABELLA_QUOTE').AsString);
          selP554.Close;
          selP554.Open;
          if selP554.Eof then
          begin
            sAnomalia:='Non esiste il dato da cui leggere le quote per il calcolo della percentuale di ridistribuzione Tabella: ' + selP553.FieldByName('COD_TABELLA_QUOTE').AsString
            + ' Macro categoria: ' + selP553.FieldByName('MACRO_CATEG').AsString + #13#10;
            GestioneAnomalie('C');
            IdFlussoQuote:=0;
          end
          else
            IdFlussoQuote:=selP554.FieldByName('ID_CONTOANN').AsInteger;
        end;
        if IdFlussoQuote > 0 then
        begin
          selP555a.SetVariable('IdCONTANN',IdFlussoQuote);
          selP555a.SetVariable('CodTabella',selP553.FieldByName('COD_TABELLA_QUOTE').AsString);
          selP555a.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
          selP555a.SetVariable('Colonna',selP553.FieldByName('COLONNA_QUOTE').AsInteger);
          selP555a.SetVariable('MacroCateg',selP553.FieldByName('MACRO_CATEG').AsString);
          selP555a.Close;
          selP555a.Open;
          if selP555a.Eof then
          begin
            sAnomalia:='Non esiste il dato da cui leggere le quote per il calcolo della percentuale di ridistribuzione Tabella: ' + selP553.FieldByName('COD_TABELLA_QUOTE').AsString
            + ' Macro categoria: ' + selP553.FieldByName('MACRO_CATEG').AsString + #13#10;
            GestioneAnomalie('C');
          end
          else
          begin
            //Calcolo percentuale di ridistribuzionje per tutta la Macro categoria
            selP555b.SetVariable('IdCONTANN',IdFlussoQuote);
            selP555b.SetVariable('CodTabella',selP553.FieldByName('COD_TABELLA_QUOTE').AsString);
            selP555b.SetVariable('AnnoElaborazione',DatiInpP948.AnnoElaborazione);
            selP555b.SetVariable('Colonna',selP553.FieldByName('COLONNA_QUOTE').AsInteger);
            selP555b.SetVariable('MacroCateg',selP553.FieldByName('MACRO_CATEG').AsString);
            selP555b.SetVariable('ImportoResiduo',selP553.FieldByName('IMPORTO_RESIDUO').AsFloat);
            selP555b.Close;
            selP555b.Open;
            if not selP555b.Eof then
            begin
              sAnomalia:='';
              while not selP555a.Eof do
              begin
                DatiFormattaDato:=FormattaDato(sCodArrotondamento,selP555a.FieldByName('DATO').AsFloat*selP555b.FieldByName('PERC_RIDISTR').AsFloat);
                if (DatiFormattaDato.Anomalia <> '') and (sAnomalia = '') then
                   sAnomalia:=DatiFormattaDato.Anomalia + #13#10;
                updP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
                updP555.SetVariable('Riga',selP555a.FieldByName('RIGA').AsInteger);
                updP555.SetVariable('Colonna',selP553.FieldByName('COLONNA_RIGA').AsInteger);
                updP555.SetVariable('ImportoResiduo',DatiFormattaDato.Valore);
                updP555.Execute;
                if (updP555.RowsProcessed = 0) and (DatiFormattaDato.Valore > 0) then
                begin
                  //Registrazione riepiloghi per la dichiarazione
                  insP555.SetVariable('IdCONTANN',Id_FLUSSO_Aperto);
                  insP555.SetVariable('Riga',selP555a.FieldByName('RIGA').AsInteger);
                  insP555.SetVariable('Colonna',selP553.FieldByName('COLONNA_RIGA').AsInteger);
                  insP555.SetVariable('Valore',DatiFormattaDato.Valore);
                  insP555.Execute;
                end;
                selP555a.Next;
              end;
              if sAnomalia <> '' then
                GestioneAnomalie('C');
            end;
          end;
        end;
      end;
      selP553.Next;
    end;
    SessioneOracle.Commit;
  end;
  AbilitaComponenti;
  //***screen.Cursor:=crDefault;
end;

procedure TWP554FElaborazioneContoAnnuale.ChiusuraFornitura;
//Chiusura della fornitura del conto annuale per il periodo indicato
begin
  //***screen.Cursor:=crHourglass;
  DisabilitaComponenti;
  //Carico gli id conto annuale dell'anno delle tabelle selezionate
  CaricaIdFlusso('N');
  with WP554DM.P554MW do
  begin
    //La chiusura viene fatta per tutti gli id flussi aperti dell'anno delle tabelle selezionate
    if DatiDaElaborare <> '' then
    begin
      updP554.SetVariable('IdFlussi',DatiDaElaborare);
      updP554.SetVariable('DataChiusura',StrToDate(edtDataChiusura.Text));
      updP554.Execute;
    end;
  end;
  SessioneOracle.Commit;
  AbilitaComponenti;
  //***screen.Cursor:=crDefault;
end;

procedure TWP554FElaborazioneContoAnnuale.EsportazioneFile;
//Esportazione su file del conto annuale del periodo indicato
var i:Integer;
  lstTabelle:TStringList;
begin
  if (trim(Regione) = '') or (trim(Azienda) = '') then
    raise Exception.Create('Indicare codice regione e codice azienda utilizzando il pulsante Impostazioni!');
  //***screen.Cursor:=crHourglass;
  DisabilitaComponenti;
  //Carico gli id conto annuale dell'anno delle tabelle selezionate
  CaricaIdFlusso('');
  lstTabelle:=TStringList.Create;
  lstTabelle.Clear;
  lstTabelle.CommaText:=DatiDaElaborare;
  { DONE : TEST IW 14 OK }
  if Trim(NomeFile) = '' then
    NomeFile:=IncludeTrailingPathDelimiter(gsAppPath) + 'CONTOANNUALE.TXT';
  //***ProgressBar1.Position:=0;
  //***ProgressBar1.Max:=lstTabelle.Count;
  with WP554DM.P554MW do
  begin
    AnnoRegole:=0;
    selQuery.Close;
    selQuery.SQL.Clear;
    selQuery.DeleteVariables;
    selQuery.SQL.Add('SELECT MAX(ANNO) ANNO FROM P552_CONTOANNREGOLE WHERE ANNO <= ' + edtAnno.Text);
    selQuery.Open;
    if selQuery.RecordCount > 0 then
      AnnoRegole:=selQuery.FieldByName('ANNO').AsInteger;
  end;
  for i:=0 to lstTabelle.Count - 1 do
  begin
    with WP554DM.P554MW do
    begin
      //***ProgressBar1.StepBy(1);
      selP555Righe.Close;
      selP555Righe.SetVariable('ANNOREGOLE',AnnoRegole);
      selP555Righe.SetVariable('ID_CONTOANN',StrToIntDef(lstTabelle.Strings[i],0));
      selP555Righe.Open;
      selP555Esporta.Close;
      selP555Esporta.SetVariable('ANNOREGOLE',AnnoRegole);
      selP555Esporta.SetVariable('ID_CONTOANN',StrToIntDef(lstTabelle.Strings[i],0));
      selP555Esporta.Open;
      if selP555Esporta.RecordCount > 0 then  //se ci sono dati da elab. per la tabella corrente
      begin
        if (trim(Istituto) = '') and (selP555Esporta.FieldByName('COD_TABELLA').AsString = 'T01C') then
        begin
          //***screen.Cursor:=crDefault;
          //***ProgressBar1.Position:=0;
          raise Exception.Create('Indicare il codice istituto utilizzando il pulsante Impostazioni!');
        end;
        if (trim(DSM) = '') and (selP555Esporta.FieldByName('COD_TABELLA').AsString = 'T01D') then
        begin
          //***screen.Cursor:=crDefault;
          //***ProgressBar1.Position:=0;
          raise Exception.Create('Indicare il codice DSM utilizzando il pulsante Impostazioni!');
        end;
        selP551.Close;
        selP551.SetVariable('ANNO',AnnoRegole);
        selP551.SetVariable('TABELLA',selP555Esporta.FieldByName('COD_TABELLA').AsString);
        selP551.Open;
        if selP551.RecordCount > 0 then  //se esiste il tracciato record della tab.corrente
        begin
          //***StatusBar.Panels[1].Text:='Esportazione tabella ' + selP551.FieldByName('COD_TABELLA').AsString;
          if FileExists(NomeFile) then
          begin
            if R180MessageBox('File ' + NomeFile + ' già esistente. Sostituire il file?','DOMANDA') = mrYes then
            begin
              DeleteFile(NomeFile);
              GeneraFile(NomeFile);
            end;
          end
          else
            GeneraFile(NomeFile);
        end;
      end;
    end;
  end;
  FreeAndNil(lstTabelle);
  AbilitaComponenti;
  //***screen.Cursor:=crDefault;
  //***ProgressBar1.Position:=0;
  //***StatusBar.Panels[1].Text:='';
end;

procedure TWP554FElaborazioneContoAnnuale.GeneraFile(Nome:String);
var F:TextFile;
  Riga,Valore,s:string;
  ValoreNum:Real;
  i,NumDec:Integer;
  App:TStringList;

  function ValoreArrot(Imp:Real;TipoCampo,Formato:String):Real;
  var F:String;
    j:Integer;
  begin
    Result:=Imp;
    F:=Formato;
    with WP554DM.P554MW do
    begin
      if Imp <> 0  then
      begin
        if Trim(F) = '' then
        begin
          selP551Formato.Close;
          selP551Formato.SetVariable('TABELLA',selP551.FieldByName('COD_TABELLA').AsString);
          selP551Formato.SetVariable('ANNO',selP551.FieldByName('ANNO').AsInteger);
          selP551Formato.SetVariable('TIPOCAMPO',TipoCampo);
          selP551Formato.Open;
          F:=selP551Formato.FieldByName('FORMATO').AsString;
        end;
        if F = 'N' then
          Result:=R180Arrotonda(Imp,1,'P')
        else if Copy(F,1,2) = 'NV' then
        begin
          NumDec:=StrToIntDef(Copy(F,3,1),0);
          s:='';
          for j:=1 to NumDec-1 do
            s:=s + '0';
          s:='0,' + s + '1';
          Result:=R180Arrotonda(Imp,StrToFloatDef(s,1),'P');
        end;
      end;
    end;
  end;
begin
  FileGenerato:=True;
  AssignFile(F,Nome);
  Rewrite(F);
  with WP554DM.P554MW do
  begin
    selP555Righe.First;
    while not selP555Righe.Eof do  //ciclo su tutte le righe della tabella
    begin
      selP551.First;
      Riga:='';
      //per ogni riga ciclo su tutti i campi del tracciato record e creo la riga da scrivere sul file
      while not selP551.Eof do
      begin
        ValoreNum:=0;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'ANNO' then
          Valore:=selP555Esporta.FieldByName('ANNO').AsString;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'AZIENDA' then
          Valore:=Azienda;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'FILLER' then
          Valore:='';
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDCATEG' then
          Valore:=selP555Righe.FieldByName('VALORE_COSTANTE').AsString;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDCOMPARTO' then
          Valore:=Comparto;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDDSM' then
          Valore:=DSM;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDFIGURA' then
          Valore:=selP555Righe.FieldByName('VALORE_COSTANTE').AsString;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'IDISTITUTO' then
          Valore:=Istituto;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'REGIONE' then
          Valore:=Regione;
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'TIPOOPERAZ' then
          Valore:=TipoOper;
        //Tipo campo COLONNA Cxxx
        if Copy(selP551.FieldByName('TIPO_CAMPO').AsString,1,1) = 'C' then
          if selP555Esporta.SearchRecord('RIGA;COLONNA',
            VarArrayOf([selP555Righe.FieldByName('RIGA').AsInteger,StrToIntDef(Copy(selP551.FieldByName('TIPO_CAMPO').AsString,2,3),0)]),[srFromBeginning]) then
          begin
            ValoreNum:=ValoreArrot(selP555Esporta.FieldByName('VALORE').AsFloat,'',selP551.FieldByName('FORMATO').AsString);
            Valore:=FloatToStr(ValoreNum);
          end
          else
            Valore:='';
        //Tipo campo FORMULA - somma
        if selP551.FieldByName('TIPO_CAMPO').AsString = 'FORMULA' then
        begin
          App:=TStringList.Create;
          App.Clear;
          App.CommaText:=StringReplace(StringReplace(selP551.FieldByName('FORMULA').AsString,'+',',+',[rfReplaceAll]),'-',',-',[rfReplaceAll]);
          if Length(App.Strings[0]) = 4 then
            App.Strings[0]:='+' + App.Strings[0];
          for i:=0 to App.Count -1 do
          begin
            if selP555Esporta.SearchRecord('RIGA;COLONNA',
               VarArrayOf([selP555Righe.FieldByName('RIGA').AsInteger,StrToIntDef(Copy(App.Strings[i],3,3),0)]),[srFromBeginning]) then
            begin
              begin
                if Copy(App.Strings[i],1,1) = '+' then
                  ValoreNum:=ValoreNum + ValoreArrot(selP555Esporta.FieldByName('VALORE').AsFloat,Copy(App.Strings[i],2,4),'')
                else if Copy(App.Strings[i],1,1) = '-' then
                  ValoreNum:=ValoreNum - ValoreArrot(selP555Esporta.FieldByName('VALORE').AsFloat,Copy(App.Strings[i],2,4),'');
              end;
            end;
          end;
          ValoreNum:=ValoreArrot(ValoreNum,'',selP551.FieldByName('FORMATO').AsString);
          if ValoreNum = 0 then
            Valore:=''
          else
            Valore:=FloatToStr(ValoreNum);
          FreeAndNil(App);
        end;

        if selP551.FieldByName('FORMATO').AsString = 'X' then
        begin
          Valore:=Copy(Valore,1,selP551.FieldByName('LUNGHEZZA').AsInteger);
          Riga:=Riga + Format('%-*s',[selP551.FieldByName('LUNGHEZZA').AsInteger,Valore])
        end
        else if selP551.FieldByName('FORMATO').AsString = 'N' then
        begin
          Valore:=FloatToStr(ValoreNum);
          Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger,selP551.FieldByName('LUNGHEZZA').AsInteger,StrToIntDef(Valore,0)]);
        end
        else if Copy(selP551.FieldByName('FORMATO').AsString,1,2) = 'NV' then
        begin
          Valore:=FloatToStr(ValoreNum);
          NumDec:=StrToIntDef(Copy(selP551.FieldByName('FORMATO').AsString,3,1),0);
          if Pos(',',Valore) > 0 then
          begin
            if Length(Valore)-Pos(',',Valore) = NumDec then
              Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                StrToIntDef(Copy(Valore,1,Pos(',',Valore)-1),0)]) + ',' +
                Copy(Valore,Pos(',',Valore)+1,NumDec)
            else
              Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
                StrToIntDef(Copy(Valore,1,Pos(',',Valore)-1),0)]) + ',' +
                Copy(Valore,Pos(',',Valore)+1,Length(Valore)-Pos(',',Valore));
            for i:=1 to NumDec-(Length(Valore)-Pos(',',Valore)) do
              Riga:=Riga + '0';
          end
          else
          begin
            Riga:=Riga + Format('%-*.*d',[selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,
              selP551.FieldByName('LUNGHEZZA').AsInteger-NumDec-1,StrToIntDef(Valore,0)]) + ',';
            for i:=1 to NumDec do
              Riga:=Riga + '0';
          end;
        end;
        selP551.Next;
      end;
      Writeln(F,Riga);  //scrivo la riga sul file
      selP555Righe.Next;
    end;
  end;
  CloseFile(F);
end;

function TWP554FElaborazioneContoAnnuale.GestioneAnomalie(sTipo:String):String;
//Registrazione e visualizzazione anomalie
var MessaggioAnomalia: String;
begin
  Result:='C';
  //Setto stato di presenza di anomalie
  PresenzaAnomalie:=True;
  if sTipo = 'I' then
  begin
    with grdC700.WC700DM.selAnagrafe {C700SelAnagrafe} do
    begin
      MessaggioAnomalia:=FieldByName('Matricola').AsString + ' ' +
        TrimRight(FieldByName('Nome').AsString) + ' ' +
        TrimRight(FieldByName('Cognome').AsString) + ' cod.tab. ' + DatiInpP948.CodTabella + ':'#13#10;
    end;
  end;
  if P948DM.DatiOut.Blocca <> '' then
    MessaggioAnomalia:=MessaggioAnomalia + ' - ANOM.BLOCCANTE ' + P948DM.DatiOut.Blocca + #13#10;
  if P948DM.DatiOut.NoBlocca <> '' then
    MessaggioAnomalia:=MessaggioAnomalia + P948DM.DatiOut.NoBlocca;
  if sAnomalia <> '' then
    MessaggioAnomalia:=MessaggioAnomalia + sAnomalia;
  //Registra anomalie su file txt
  //R180AppendFile(PercorsoFileAnomalie,MessaggioAnomalia);
  RegistraMsg.InserisciMessaggio('A',MessaggioAnomalia,'',IfThen(sTipo = 'I',grdC700.WC700DM.selAnagrafe{C700SelAnagrafe}.FieldByName('Progressivo').AsInteger));
end;

procedure TWP554FElaborazioneContoAnnuale.GetParametriFunzione;
{Leggo i parametri della form}
var
  Anno,Mese,Giorno: Word;
begin
  DecodeDate(Parametri.DataLavoro,Anno,Mese,Giorno);
  //***edtAnno.Value:=Anno - 1;
  edtAnno.Text:=IntToStr(Anno - 1);
  if (edtMeseDa.Text = '  /    ') or (edtMeseDa.Text = '') then
    edtMeseDa.Text:='01/' + {//***IntToStr(edtAnno.Value)}edtAnno.Text;
  if (edtMeseA.Text = '  /    ') or (edtMeseA.Text = '') then
    edtMeseA.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  edtAnno.Text:=C004DM.GetParametro('edtAnno',edtAnno.Text);
  CaricaElencoTabelle;
  edtMeseDa.Text:=C004DM.GetParametro('edtMeseDa',edtMeseDa.Text);
  edtMeseA.Text:=C004DM.GetParametro('edtMeseA',edtMeseA.Text);
  chkElaboraDatiCONTANN.Checked:=(C004DM.GetParametro('chkElabDatiCONTANN','') = 'S');
  chkElaboraRiepiloghi.Checked:=(C004DM.GetParametro('chkElaboraRiepiloghi','') = 'S');
  chkElabRisorseResidue.Checked:=(C004DM.GetParametro('chkElabRisorseResid','') = 'S');
  chkAnnulla.Checked:=(C004DM.GetParametro('chkAnnulla','') = 'S');
  chkChiusura.Checked:=(C004DM.GetParametro('chkChiusura','') = 'S');
  //L'esportazione non è più gestita chkEsportazione.Checked:=C004DM.GetParametro('chkEsportazione','') = 'S';
  chkEsportazione.Visible:=False;//L'esportazione non è più gestita
  chkEsportazione.Enabled:=False;//L'esportazione non è più gestita
  chkEsportazione.Checked:=False;//L'esportazione non è più gestita
  Azienda:=C004DM.GetParametro('Exp_Azienda','');
  Comparto:=C004DM.GetParametro('Exp_Comparto','01');
  DSM:=C004DM.GetParametro('Exp_DSM','');
  Istituto:=C004DM.GetParametro('Exp_Istituto','');
  Regione:=C004DM.GetParametro('Exp_Regione','');
  TipoOper:=C004DM.GetParametro('Exp_TipoOper','0');
  NomeFile:=C004DM.GetParametro('Exp_NomeFile','');
  //Al fondo, per non essere inficiato dai precedenti chkElaboraDatiCONTANNAsyncClick che scattano in automatico
  cmbCodAziendaBase.Text:=C004DM.GetParametro('cmbCodAziendaBase',T440AZIENDA_BASE);
end;

procedure TWP554FElaborazioneContoAnnuale.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  C004DM.PutParametro('cmbCodAziendaBase',cmbCodAziendaBase.Text);
  C004DM.PutParametro('edtAnno',edtAnno.Text);
  C004DM.PutParametro('edtMeseDa',edtMeseDa.Text);
  C004DM.PutParametro('edtMeseA',edtMeseA.Text);
  if chkElaboraDatiCONTANN.Checked then
    C004DM.PutParametro('chkElabDatiCONTANN','S')
  else
    C004DM.PutParametro('chkElabDatiCONTANN','N');
  if chkElaboraRiepiloghi.Checked then
    C004DM.PutParametro('chkElaboraRiepiloghi','S')
  else
    C004DM.PutParametro('chkElaboraRiepiloghi','N');
  if chkElabRisorseResidue.Checked then
    C004DM.PutParametro('chkElabRisorseResid','S')
  else
    C004DM.PutParametro('chkElabRisorseResid','N');
  if chkAnnulla.Checked then
    C004DM.PutParametro('chkAnnulla','S')
  else
    C004DM.PutParametro('chkAnnulla','N');
  if chkChiusura.Checked then
    C004DM.PutParametro('chkChiusura','S')
  else
    C004DM.PutParametro('chkChiusura','N');
  (*//L'esportazione non è più gestitaif chkEsportazione.Checked then
    C004DM.PutParametro('chkEsportazione','S')
  else
    C004DM.PutParametro('chkEsportazione','N');*)
  C004DM.PutParametro('Exp_Azienda',Azienda);
  C004DM.PutParametro('Exp_Comparto',Comparto);
  C004DM.PutParametro('Exp_DSM',DSM);
  C004DM.PutParametro('Exp_Istituto',Istituto);
  C004DM.PutParametro('Exp_Regione',Regione);
  C004DM.PutParametro('Exp_TipoOper',TipoOper);
  C004DM.PutParametro('Exp_NomeFile',NomeFile);
  try SessioneOracle.Commit; except end;
end;

procedure TWP554FElaborazioneContoAnnuale.DisabilitaComponenti;
//Disabilito i componenti sui quali non devono poter agire
begin
  btnAnomalie.Enabled:=False;
end;

procedure TWP554FElaborazioneContoAnnuale.AbilitaComponenti;
//Riabilito i componenti disabilitati
begin
  if PresenzaAnomalie then
    btnAnomalie.Enabled:=True;
end;

procedure TWP554FElaborazioneContoAnnuale.AbilitazioniIniziali;
var
  i: Integer;
//Imposto abilitazioni iniziali per i componenti
begin
  if not WP554DM.P554MW.bVisStatoCedolini then
  begin
    rgpStatoCedolini.Visible:=False;
    rgpStatoCedolini.ItemIndex:=1;//Per sicurezza anche se bisognerebbe non usare la relativa variabile nelle query del conto annuale
  end
  else
    rgpStatoCedolini.Visible:=chkElaboraDatiCONTANN.Checked;
  C190VisualizzaElemento(JQuery,'divStatoCedolini',rgpStatoCedolini.Visible);
  chkAnnulla.Enabled:=not(chkElaboraDatiCONTANN.Checked or chkElaboraRiepiloghi.Checked or chkEsportazione.Checked
    or chkElabRisorseResidue.Checked or chkChiusura.Checked);
  chkElaboraDatiCONTANN.Enabled:=not (chkAnnulla.Checked or chkEsportazione.Checked or
    chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked or chkChiusura.Checked);
  chkElaboraRiepiloghi.Enabled:=not (chkElaboraDatiCONTANN.Checked or chkEsportazione.Checked or
    chkAnnulla.Checked or chkElabRisorseResidue.Checked or chkChiusura.Checked);
  chkElabRisorseResidue.Enabled:=not (chkElaboraDatiCONTANN.Checked or chkEsportazione.Checked or
    chkAnnulla.Checked or chkElaboraRiepiloghi.Checked or chkChiusura.Checked);
  chkChiusura.Enabled:=not (chkAnnulla.Checked or chkEsportazione.Checked or
    chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked or chkElaboraDatiCONTANN.Checked);
  (*//L'esportazione non è più gestita
  chkEsportazione.Enabled:=not (chkAnnulla.Checked or chkChiusura.Checked or
    chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked or chkElaboraDatiCONTANN.Checked);*)
  //---sbtDataChiusura.Enabled:=chkChiusura.Checked;
  lblDataChiusura.Visible:=chkChiusura.Checked;
  edtDataChiusura.Visible:=chkChiusura.Checked;
  if not chkElaboraDatiCONTANN.Enabled then
    chkElaboraDatiCONTANN.Checked:=False;
  if not chkElaboraRiepiloghi.Enabled then
    chkElaboraRiepiloghi.Checked:=False;
  if not chkElabRisorseResidue.Enabled then
    chkElabRisorseResidue.Checked:=False;
  if not chkAnnulla.Enabled then
    chkAnnulla.Checked:=False;
  if not chkChiusura.Enabled then
    chkChiusura.Checked:=False;
  (*//L'esportazione non è più gestita
  if not chkEsportazione.Enabled then
    chkEsportazione.Checked:=False;
  btnImpostazioni.Enabled:=chkEsportazione.Checked;
  btnVisualizzaFile.Enabled:=chkEsportazione.Checked and FileGenerato;*)
  btnImpostazioni.Visible:=False;//L'esportazione non è più gestita
  btnVisualizzaFile.Visible:=False;//L'esportazione non è più gestita
  clbTabElab.Enabled:=chkElaboraDatiCONTANN.Checked or chkElaboraRiepiloghi.Checked or chkElabRisorseResidue.Checked
                      or chkAnnulla.Checked or chkChiusura.Checked or chkEsportazione.Checked;
  btnEsegui.Enabled:=((not SolaLettura) and (chkElaboraDatiCONTANN.Checked or chkElaboraRiepiloghi.Checked
                     or chkElabRisorseResidue.Checked or chkAnnulla.Checked or chkChiusura.Checked or chkEsportazione.Checked));
  lblMeseDa.Visible:=chkElaboraDatiCONTANN.Checked;
  edtMeseDa.Visible:=chkElaboraDatiCONTANN.Checked;
  lblMeseA.Visible:=chkElaboraDatiCONTANN.Checked;
  edtMeseA.Visible:=chkElaboraDatiCONTANN.Checked;
  chkSvuotaTabella.Visible:=chkElaboraDatiCONTANN.Checked;
  chkEseguiScriptIniziali.Css:='invisibile';
  if chkElaboraDatiCONTANN.Checked then
  begin
    for i:=0 to High(vTabElab) do
    begin
      if clbTabElab.Selected[i]
      and WP554DM.P554MW.selP552.SearchRecord('COD_TABELLA',VarArrayOf([vTabElab[i].CodiceTabella]),[srFromBeginning]) then
        if WP554DM.P554MW.selP552.FieldByName('SCRIPT_INIZIALE').AsString <> '' then
            chkEseguiScriptIniziali.Css:='intestazione';
    end;
  end;
  chkEseguiScriptIniziali.Invalidate; // fix intraweb per forzare aggiornamento proprietà css in async
  grdC700.Visible:=chkElaboraDatiCONTANN.Checked or chkAnnulla.Checked;
end;

procedure TWP554FElaborazioneContoAnnuale.chkElaboraDatiCONTANNClick(Sender: TObject);
begin
  inherited;
  AbilitazioniIniziali;
  CaricaMultiColumnCombobox;
end;

procedure TWP554FElaborazioneContoAnnuale.clbTabElabAsyncCheckClick(
  Sender: TObject; EventParams: TStringList; Index: Integer; Check: LongBool);
var
  i,j: integer;
begin
  if chkElabRisorseResidue.Checked or chkEsportazione.Checked then
    exit;
  with WP554DM.P554MW do
  begin
    //***i:=clbTabElab.ItemIndex;
    i:=Index;

    selP552a.First;
    while not selP552a.Eof do
    begin
      if selP552a.FieldByName('COD_TABELLA').AsString = vTabElab[i].CodiceTabella then
      begin
        //P554FElaborazioneContoAnnuale.
        //---clbTabElab.OnClick:=nil;
        for j:=0 to High(vTabElab) do
        begin
          if vTabElab[j].CodiceTabella = selP552a.FieldByName('COD_TABELLA_CORRELATA').AsString then
          begin
            //***clbTabElab.Checked[j]:=clbTabElab.Checked[i];
            clbTabElab.Selected[j]:=clbTabElab.Selected[i];
            break;
          end;
        end;
        //---clbTabElab.OnClick:=clbTabElabClick;
      end;
      selP552a.Next;
    end;
    selP552a.First;
    while not selP552a.Eof do
    begin
      if selP552a.FieldByName('COD_TABELLA_CORRELATA').AsString = vTabElab[i].CodiceTabella then
      begin
        //P554FElaborazioneContoAnnuale.
        //---clbTabElab.OnClick:=nil;
        for j:=0 to High(vTabElab) do
        begin
          if vTabElab[j].CodiceTabella = selP552a.FieldByName('COD_TABELLA').AsString then
          begin
            //***clbTabElab.Checked[j]:=clbTabElab.Checked[i];
            clbTabElab.Selected[j]:=clbTabElab.Selected[i];
            break;
          end;
        end;
        //---clbTabElab.OnClick:=clbTabElabClick;
      end;
      selP552a.Next;
    end;
  end;
  AbilitazioniIniziali;
end;

function TWP554FElaborazioneContoAnnuale.FormattaDato(sCodArrotondamento:String; rDato:Real):TDatiFormattaDato;
//Formattazione del dato se numerico
begin
  with WP554DM.P554MW do
  begin
    Result.Valore:=rDato;
    Result.Anomalia:='';
    if sCodArrotondamento <> '' then
    begin
      if (selP050.GetVariable('CodValuta') <> selP500.FieldByName('COD_VALUTA').AsString) or
         (selP050.GetVariable('CodArrotondamento') <> sCodArrotondamento) or
         (selP050.GetVariable('Decorrenza') <> DatiInpP948.DataInizioElaborazione) then
      begin
        selP050.SetVariable('CodValuta',selP500.FieldByName('COD_VALUTA').AsString);
        selP050.SetVariable('CodArrotondamento',sCodArrotondamento);
        selP050.SetVariable('Decorrenza',DatiInpP948.DataInizioElaborazione);
        selP050.Close;
        selP050.Open;
      end;
      if not selP050.Eof then
      begin
        //Arrotondamento
        if rDato <> 0 then
          rDato:=R180Arrotonda(rDato,selP050.FieldByName('VALORE').AsFloat,selP050.FieldByName('TIPO').AsString);
      end
      else
      begin
        //Non esiste l'arrotondamento
        Result.Anomalia:='Non esiste l''arrotondamento seguente: Valuta=' + selP500.FieldByName('COD_VALUTA').AsString;
        Result.Anomalia:=Result.Anomalia + ' Codice arrotondamento=' + sCodArrotondamento;
        Result.Anomalia:=Result.Anomalia + ' Decorrenza=' + FormatDateTime('dd/mm/yyyy',DatiInpP948.DataInizioElaborazione);
        exit;
      end;
    end;
    Result.Valore:=rDato;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.btnAnomalieClick(Sender: TObject);
var
  Params: string;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + RegistraMsg.ID.ToString + ParamDelimiter +
          'TIPO=A,B,I';
  AccediForm(201,Params,True);
end;

procedure TWP554FElaborazioneContoAnnuale.btnEseguiClick(Sender: TObject);
var
  i: integer;
  Selez:Boolean;
begin
  //Controllo che almeno una tabella sia selezionata
  Selez:=False;
  for i:=0 to clbTabElab.Items.Count - 1 do
    if clbTabElab.Selected[i] then
      Selez:=True;
  if not Selez then
    raise exception.Create('Selezionare almeno una tabella da elaborare!');
  //Leggo parametri aziendali
  with WP554DM.P554MW do
  begin
    if selP500.GetVariable('Anno') <> edtAnno.Text then
    begin
      selP500.SetVariable('Anno',edtAnno.Text);
      selP500.SetVariable('COD_AZIENDA_BASE',T440AZIENDA_BASE);
      selP500.Close;
      selP500.Open;
    end;
  end;

  if chkElaboraDatiCONTANN.Checked then
  begin
    //Leggo eventualI forniture precedenti non chiuse
    CaricaIdFlusso('N');
    if sMesFornManc <> '' then
    begin
      //***.ini
      {
      if R180MessageBox(' Esistono già le seguenti elaborazioni precedenti riferite all''anno: ' + chr(13) +
         sMesFornManc + ' Proseguire comunque con l''elaborazione?', DOMANDA) = mrNo then
        exit;
      }
      MsgBox.WebMessageDlg(' Esistono già le seguenti elaborazioni precedenti riferite all''anno: '#13#10 +
                           sMesFornManc + ' Proseguire comunque con l''elaborazione cancellando i dati precedentemente registrati per ' +
                           IfThen(chkSvuotaTabella.Checked,'TUTTI i dipendenti','i SOLI dipendenti selezionati') + '?',mtConfirmation,[mbYes,mbNo],
                           OnResultEsegui,'FORNITURE_NON_CHIUSE');
      //***.fine
      Exit;
    end;
  end;
  Esegui_Step1;
end;

procedure TWP554FElaborazioneContoAnnuale.OnResultEsegui(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if KeyID = 'FORNITURE_NON_CHIUSE' then
  begin
    if ModalResult = mrYes then
      Esegui_Step1;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.Esegui_Step1;
begin
  StartElaborazioneServer(btnEsegui.HTMLName);
end;

procedure TWP554FElaborazioneContoAnnuale.InizializzaMsgElaborazione;
// impostazioni per frame di elaborazione in corso
begin
  WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
  WC022FMsgElaborazioneFM.Titolo:=A000MSG_MSG_ELABORAZIONE;
  WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
end;

procedure TWP554FElaborazioneContoAnnuale.ElaborazioneServer;
// parte di elaborazione principale
var
  i: Integer;
begin
  if not chkEsportazione.Checked then
  begin
    //Setto stato di non presenza di anomalie
    PresenzaAnomalie:=False;
    RegistraMsg.IniziaMessaggio(medpCodiceForm);
    //***Self.Enabled:=False;
    //Imposto variabile per cancellazione per dipendenti selezionati con id delle tabelle selezionate per l'elaborazione
    bCancellaId:=chkElaboraDatiCONTANN.Checked and not chkSvuotaTabella.Checked;
    //Cancellazione per tutti i dipendenti con id delle tabelle selezionate per l'elaborazione
    if chkElaboraDatiCONTANN.Checked and chkSvuotaTabella.Checked and (DatiDaElaborare <> '') then
    begin
      WP554DM.P554MW.delP555c.SetVariable('IdFlussi',DatiDaElaborare);
      WP554DM.P554MW.delP555c.Execute;
      SessioneOracle.Commit;
    end;
    //Ciclo sulle regole elaborando le tabelle che sono state selezionate
    for i:=0 to High(vTabElab) do
    begin
      if clbTabElab.Selected[i]
      and WP554DM.P554MW.selP552.SearchRecord('COD_TABELLA',VarArrayOf([vTabElab[i].CodiceTabella]),[srFromBeginning]) then
      begin
        //***StatusBar.Panels[1].Text:='Tabella in elaborazione ' + vTabElab[i].CodiceTabella;
        //Leggo la testata per impostare Id_FLUSSO_Aperto
        //***.ini
        WP554DM.P554MW.Anno:=StrToIntDef(edtAnno.Text,0);
        WP554DM.P554MW.ChkElaboraDatiCONTANN_Checked:=chkElaboraDatiCONTANN.Checked;
        //***.fine
        Id_FLUSSO_Aperto:=WP554DM.P554MW.TestataCONTANN(vTabElab[i].CodiceTabella);
        //Configuro variabili per calcolo CONTANN
        DatiInpP948.ID_CONTANN:=Id_FLUSSO_Aperto;
        DatiInpP948.AnnoElaborazione:=edtAnno.Text;
        DatiInpP948.DataInizioElaborazione:=StrToDate('01/'+edtMeseDa.Text);
        DatiInpP948.DataFineElaborazione:=StrToDate('01/'+edtMeseA.Text);
        //edtAnno.Text;
        DatiInpP948.CodTabella:=vTabElab[i].CodiceTabella;
        DatiInpP948.DescTabella:=WP554DM.P554MW.selP552.FieldByName('DESCRIZIONE').AsString;
        DatiInpP948.TipoTabellaRighe:=WP554DM.P554MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString;
        if WP554DM.P554MW.selP552.FieldByName('TIPO_TABELLA_RIGHE').AsString = '0' then
          //Se qualifica ministeriale prendo il nome del campo dai parametri aziendali
          DatiInpP948.ValoreCostante:='QUALIFICAMINIST'
        else
          //..altrimenti passo il dato libero o la funzione Oracle utilizzata
          DatiInpP948.ValoreCostante:=WP554DM.P554MW.selP552.FieldByName('VALORE_COSTANTE').AsString;
        DatiInpP948.ElaboraDatiCONTANN:=chkElaboraDatiCONTANN.Checked;
        DatiInpP948.ElaboraRiepiloghi:=chkElaboraRiepiloghi.Checked;
        case rgpStatoCedolini.ItemIndex of
          0:DatiInpP948.StatoCedolini:='''S''';
          1:DatiInpP948.StatoCedolini:='''S'',''N''';
          2:DatiInpP948.StatoCedolini:='''N''';
        end;
        if chkElaboraDatiCONTANN.Checked then
        begin
          if (chkEseguiScriptIniziali.Checked) and
             (WP554DM.P554MW.selP552.FieldByName('SCRIPT_INIZIALE').AsString <> '') then
          begin
            WP554DM.P554MW.ScriptIniziale.SQL.Clear;
            WP554DM.P554MW.ScriptIniziale.SQL.Add(WP554DM.P554MW.selP552.FieldByName('SCRIPT_INIZIALE').AsString);
            WP554DM.P554MW.ScriptIniziale.Execute;
            SessioneOracle.Commit;
          end;
          ElaborazioneDipendenti;
          //Imposto variabile per evitare cancellazione id delle tabelle selezionate per l'elaborazione, dopo
          //l'elaborazione della prima tabella
          bCancellaId:=False;
        end;
        //Calcolo dati riepilogativi
        if chkElaboraRiepiloghi.Checked then
          CalcoloRiepiloghi;
        //Ridistribuzione risorse residue
        if chkElabRisorseResidue.Checked then
        begin
          CalcoloRiepiloghi;
          RidistribuzioneRisorseResidue;
        end;
      end;
    end;
    //Fase di annullamento fatta in unica passata per tutte le tabelle selezionate
    if chkAnnulla.Checked then
      ElaborazioneDipendenti;
    //***Self.Enabled:=True;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.AfterElaborazione;
begin
  inherited;

  // ATTENZIONE!
  // a questo punto è già presente il messagebox di fine elaborazione
  // richiamo il metodo cancelmessagebox per eliminarlo
  MsgBox.CancelMessageBox;

  //Chiusura della fornitura
  if chkChiusura.Checked then
  begin
    //***.ini
    {
    if (R180MessageBox('Confermi l''operazione di chiusura del Conto Annuale del periodo indicato?',DOMANDA) = mrYes) then
      ChiusuraFornitura;
    }
    MsgBox.WebMessageDlg('Confermi l''operazione di chiusura del Conto Annuale del periodo indicato?',mtConfirmation,[mbYes,mbNo],OnResultAfterElaborazione,'CHIUDI_FORNITURA');
    Exit;
    //***.fine
  end;

  AfterElaborazione_Step1;
end;

procedure TWP554FElaborazioneContoAnnuale.OnResultAfterElaborazione(Sender: TObject; ModalResult: TmeIWModalResult; KeyID: String);
begin
  if KeyID = 'CHIUDI_FORNITURA' then
  begin
    if ModalResult = mrYes then
      ChiusuraFornitura;
    AfterElaborazione_Step1;
  end
  else if KeyID = 'CONFERMA_ESPORTAZIONE' then
  begin
    if ModalResult = mrYes then
      EsportazioneFile;
    AfterElaborazione_Step2;
  end
  else if KeyID = 'VISUALIZZA_ANOMALIE' then
  begin
    if ModalResult = mrYes then
      btnAnomalieClick(nil);
  end
  else if KeyID = 'ELAB_OK' then
  begin
    if chkElaboraDatiCONTANN.Checked then
    begin
      MsgBox.WebMessageDlg('Si desidera eseguire il calcolo dei dati riepilogativi?',mtConfirmation,[mbYes,mbNo],OnResultAfterElaborazione,'DATI_RIEPILOGATIVI');
      Exit;
    end;
  end
  else if KeyID = 'DATI_RIEPILOGATIVI' then
  begin
    if ModalResult = mrYes then
    begin
      chkElaboraDatiCONTANN.Checked:=False;
      chkElaboraDatiCONTANNClick(chkElaboraDatiCONTANN);
      chkElaboraRiepiloghi.Checked:=True;
      chkElaboraDatiCONTANNClick(chkElaboraRiepiloghi);
      cmbCodAziendaBase.Text:=T440AZIENDA_TUTTE;//in caso di più aziende nell'anno, forzo l'elaborazione per tutte
      AggiornaDescrizioneAziendaBase;
      btnEseguiClick(nil);
    end;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.AfterElaborazione_Step1;
begin
  //Esportazione su file
  if chkEsportazione.Checked then
  begin
    PresenzaAnomalie:=False;
    btnVisualizzaFile.Enabled:=False;
    FileGenerato:=False;
    CaricaIdFlusso('');
    //***.ini
    {
    if Pos(',',DatiDaElaborare) > 0 then
      raise exception.Create('L''esportazione su file è possibile selezionando solo una tabella alla volta!');
    }
    if Pos(',',DatiDaElaborare) > 0 then
    begin
      MsgBox.MessageBox('L''esportazione su file è possibile selezionando solo una tabella alla volta!',ESCLAMA);
      Exit;
    end;
    {
    if (R180MessageBox('Confermi l''operazione di esportazione su file?',DOMANDA) = mrYes) then
      EsportazioneFile;
    }
    MsgBox.WebMessageDlg('Confermi l''operazione di esportazione su file?',mtConfirmation,[mbYes,mbNo],OnResultAfterElaborazione,'CONFERMA_ESPORTAZIONE');
    Exit;
    //***.fine
  end;
  AfterElaborazione_Step2;
end;

procedure TWP554FElaborazioneContoAnnuale.AfterElaborazione_Step2;
begin
  // informazioni post-elaborazione
  //***.ini
  {
  if frmSelAnagrafe.ElaborazioneInterrotta then
  begin
    R180MessageBox('Elaborazione interrotta su richiesta dell''operatore.',INFORMA);
    frmSelAnagrafe.ElaborazioneInterrotta:=False;
  end
  else
  }
  //***.fine
  begin
    if chkChiusura.Checked then
    begin
      if sMesFornManc <> '' then
        R180MessageBox('Elaborazione terminata. Sono state chiuse le seguenti tabelle '#13#10 + sMesFornManc,INFORMA)
      else
        R180MessageBox('Elaborazione terminata. Non è stata chiusa alcuna tabella ',INFORMA);
      Exit; //***
    end
    else if chkAnnulla.Checked then
    begin
      if sMesFornManc <> '' then
        R180MessageBox('Elaborazione terminata. Sono state annullate le seguenti tabelle '#13#10 + sMesFornManc,INFORMA)
      else
        R180MessageBox('Elaborazione terminata. Nessuna tabella aperta da annullare ',INFORMA);
      Exit; //***
    end
    else if chkEsportazione.Checked then
    begin
      if FileGenerato then
      begin
        btnVisualizzaFile.Enabled:=True;
        R180MessageBox('Elaborazione terminata. E'' stato generato il file ' + NomeFile,INFORMA)
      end
      else
        R180MessageBox('Elaborazione terminata. Nessun file generato.',INFORMA);
      Exit; //***
    end
    else if PresenzaAnomalie then
    begin
      //***.ini
      {
      if R180MessageBox('Elaborazione terminata con anomalie. Si desidera visualizzarle?',DOMANDA) = mrYes then
        btnAnomalieClick(nil);
      }
      MsgBox.WebMessageDlg('Elaborazione terminata con anomalie. Si desidera visualizzarle?',mtConfirmation,[mbYes,mbNo],OnResultAfterElaborazione,'VISUALIZZA_ANOMALIE');
      Exit;
      //***.fine
    end
    else
    begin
      //***.ini
      {
      R180MessageBox('Elaborazione terminata correttamente.',INFORMA);
      if chkElaboraDatiCONTANN.Checked and (R180MessageBox('Si desidera eseguire il calcolo dei dati riepilogativi?',DOMANDA) = mrYes) then
      begin
        chkElaboraDatiCONTANN.Checked:=False;
        chkElaboraRiepiloghi.Checked:=True;
        btnEseguiClick(nil);
      end;
      }
      MsgBox.WebMessageDlg('Elaborazione terminata correttamente.',mtInformation,[mbOk],OnResultAfterElaborazione,'ELAB_OK');
      Exit;
      //***.fine
    end;
  end;
  //***StatusBar.Panels[1].Text:='';
end;

procedure TWP554FElaborazioneContoAnnuale.ElaborazioneDipendenti;
//Ciclo di scorrimento ed elaborazione dei dipendenti
begin
  //Ciclo sul range di dipendenti
  try
    try
      if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DatiInpP948.DataInizioElaborazione,R180FineMese(DatiInpP948.DataFineElaborazione)) then
        grdC700.SelAnagrafe.Close;
      grdC700.SelAnagrafe.Open;
      grdC700.selAnagrafe.First;

      //***ProgressBar1.Position:=0;
      //***ProgressBar1.Max:=C700SelAnagrafe.RecordCount;
      //***frmSelAnagrafe.ElaborazioneInterrompibile:=True;
      //Carico gli id conto annuale dell'anno delle tabelle selezionate
      CaricaIdFlusso('N');
      //Se non ci sono Id da annullare mi posiziono sull'ultimo dip. così termino subito l'elaborazione
      if chkAnnulla.Checked and (DatiDaElaborare = '') then
        grdC700.selAnagrafe.Last;

      while not grdC700.selAnagrafe.Eof do
      begin
        sAnomalia:='';
        P948DM.DatiOut.Blocca:='';
        P948DM.DatiOut.NoBlocca:='';
        //***frmSelAnagrafe.VisualizzaDipendente;
        //Se nessun tipo di elaborazione risulta selezionato, esco dal ciclo dipendenti
        if not(chkElaboraDatiCONTANN.Checked) and not(chkAnnulla.Checked) then
          Break;
        DisabilitaComponenti;
        DatiInpP948.Progressivo:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
        //Elaborazione per calcolo periodi e dati CONTANN mensili
        if chkElaboraDatiCONTANN.Checked then
        begin
          if Id_FLUSSO_Aperto <= 0 then
          begin
            sAnomalia:='Per l''anno di elaborazione risulta già chiusa la tabella ' + DatiInpP948.CodTabella + #13#10;
            GestioneAnomalie('I');
            AbilitaComponenti;
            //***Self.Enabled:=True;
            StopElaborazione:=True;//***
            exit;
          end;
          //Se prima elaborazione cancello dati individuali di tutte le tabelle selezionate per l'elaborazione
          if bCancellaId and (DatiDaElaborare <> '') then
          begin
            WP554DM.P554MW.delP555a.SetVariable('IdFlussi',DatiDaElaborare);
            WP554DM.P554MW.delP555a.SetVariable('Progressivo',grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
            WP554DM.P554MW.delP555a.Execute;
          end;
          //Richiamo il calcolo per la registrazione dei dati e periodi CONTANN
          //***.ini
          P948DM.P554MW.Anno:=StrToIntDef(edtAnno.Text,0);
          P948DM.P554MW.ChkElaboraDatiCONTANN_Checked:=chkElaboraDatiCONTANN.Checked;
          //***.fine
          P948DM.Calcolo(DatiInpP948);
          if (P948DM.DatiOut.Blocca <> '') or
             (P948DM.DatiOut.NoBlocca <> '') then
          begin
            //Segnalo anomalia bloccante
            if GestioneAnomalie('I') = 'E' then
            begin
              //Nel caso di anomalia interattiva, se non si prosegue esco dal ciclo dipendenti
              StopElaborazione:=True;//***
              exit;
            end;
          end;
        end;
        //Annulla dati registrati e non ancora chiusi
        if chkAnnulla.Checked and (DatiDaElaborare <> '') then
        begin
          WP554DM.P554MW.delP555.SetVariable('IdFlussi',DatiDaElaborare);
          WP554DM.P554MW.delP555.SetVariable('Progressivo',grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
          WP554DM.P554MW.delP555.Execute;
        end;
        SessioneOracle.Commit;
        //***ProgressBar1.StepBy(1);
        grdC700.selAnagrafe.Next;
      end;
      //Verifico se cancellare testate Conto Annuale che non hanno dati di dettaglio
      if DatiDaElaborare <> '' then
      begin
        WP554DM.P554MW.delP554.SetVariable('IdFlussi',DatiDaElaborare);
        WP554DM.P554MW.delP554.Execute;
        SessioneOracle.Commit;
      end;
    except
      SessioneOracle.Rollback;
      raise;
    end;
  finally
    AbilitaComponenti;
    //***ProgressBar1.Position:=0;
    //***frmSelAnagrafe.ElaborazioneInterrompibile:=False;
    //***frmSelAnagrafe.VisualizzaDipendente;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.btnImpostazioniClick(Sender: TObject);
// visualizza il frame delle impostazioni
begin
  try
    // crea frame impostazioni
    WP554ImpostazioniFM:=TWP554FImpostazioniFM.Create(Self);
    FreeNotification(WP554ImpostazioniFM);
    // imposta valori delle impostazioni
    WP554ImpostazioniFM.Impostazioni.NomeFile:=NomeFile;
    WP554ImpostazioniFM.Impostazioni.Azienda:=Azienda;
    WP554ImpostazioniFM.Impostazioni.Comparto:=Comparto;
    WP554ImpostazioniFM.Impostazioni.DSM:=DSM;
    WP554ImpostazioniFM.Impostazioni.Istituto:=Istituto;
    WP554ImpostazioniFM.Impostazioni.Regione:=Regione;
    WP554ImpostazioniFM.Impostazioni.TipoOper:=TipoOper;
    WP554ImpostazioniFM.Visualizza;
  except
    on E: Exception do
    begin
      WP554ImpostazioniFM:=nil;
      MsgBox.MessageBox(Format('Errore durante l''apertura delle impostazioni:'#13#10'%s (%s)',
                               [E.Message,E.ClassName]),ESCLAMA);
    end;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.ConfermaImpostazioni(PImpostazioni: TImpostazioni);
// conferma le impostazioni indicate nel relativo frame
begin
  NomeFile:=PImpostazioni.NomeFile;
  Azienda:=PImpostazioni.Azienda;
  Comparto:=PImpostazioni.Comparto;
  DSM:=PImpostazioni.DSM;
  Istituto:=PImpostazioni.Istituto;
  Regione:=PImpostazioni.Regione;
  TipoOper:=PImpostazioni.TipoOper;
end;

procedure TWP554FElaborazioneContoAnnuale.AnnullaImpostazioni;
// annulla le impostazioni eventualmente già salvate
begin
  NomeFile:='';
  Azienda:='';
  Comparto:='';
  DSM:='';
  Istituto:='';
  Regione:='';
  TipoOper:='';
end;

procedure TWP554FElaborazioneContoAnnuale.btnVisualizzaFileClick(Sender: TObject);
begin
  inherited;
  //***.ini
  {
  OpenC012VisualizzaTesto('<P554> Visualizzazione file di esportazione',NomeFile,nil,
                          'Visualizzazione file di esportazione della tabella ' + P554FElaborazioneContoAnnualeDtM.P554MW.selP551.FieldByName('COD_TABELLA').AsString);
  }
  if (NomeFile.Trim = '') or
     (not TFile.Exists(NomeFile)) then
  begin
    MsgBox.MessageBox('Impossibile visualizzare il file. File inesistente.',INFORMA);
    Exit;
  end;
  GGetWebApplicationThreadVar.SendFile(NomeFile,True,'application/x-download',NomeFile);
end;

procedure TWP554FElaborazioneContoAnnuale.WC700AperturaSelezione(Sender: TObject);
begin
  inherited;

end;

procedure TWP554FElaborazioneContoAnnuale.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ',DATANAS';
  grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  grdC700.WC700FM.C700SelezionePeriodica:=True;
end;

procedure TWP554FElaborazioneContoAnnuale.edtAnnoAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnAnno.HTMLName]));
end;

procedure TWP554FElaborazioneContoAnnuale.btnAnnoClick(Sender: TObject);
begin
  CaricaElencoTabelle;
  CaricaMultiColumnCombobox;
end;

procedure TWP554FElaborazioneContoAnnuale.CaricaElencoTabelle;
var
  i: integer;
begin
  i:=0;
  with WP554DM.P554MW do
  begin
    selP552.SetVariable('AnnoElaborazione',edtAnno.Text);
    selP552.Close;
    selP552.Open;
    selP552a.SetVariable('AnnoElaborazione',edtAnno.Text);
    selP552a.Close;
    selP552a.Open;
    SetLength(vTabElab,0);
    clbTabElab.Items.Clear;
    while not selP552.Eof do
    begin
      SetLength(vTabElab,i + 1);
      vTabElab[i].CodiceTabella:=selP552.FieldByName('COD_TABELLA').AsString;
      vTabElab[i].DescTabella:=selP552.FieldByName('DESCRIZIONE').AsString;
      clbTabElab.Items.Add(selP552.FieldByName('COD_TABELLA').AsString + '  ' +
        selP552.FieldByName('DESCRIZIONE').AsString.Replace('"','''',[rfReplaceAll]));
      selP552.Next;
      inc(i);
    end;
  end;
end;

procedure TWP554FElaborazioneContoAnnuale.CaricaMultiColumnCombobox;
var sAzienda:String;
begin
  //Azienda
  with WP554DM.P554MW do
  begin
    if chkElaboraRiepiloghi.Checked then
    begin
      sAzienda:=SelAziendeBase.GetAziende(StrToInt(edtAnno.Text),cmbCodAziendaBase.Text,chkElaboraRiepiloghi.Checked);
      cmbCodAziendaBase.Items.Clear;
      SelAziendeBase.First;
      while not SelAziendeBase.Eof do
      begin
        cmbCodAziendaBase.AddRow(SelAziendeBase.FieldByName('CODICE').AsString + ';' + SelAziendeBase.FieldByName('DESCRIZIONE').AsString);
        SelAziendeBase.Next;
      end;
      cmbCodAziendaBase.Text:=sAzienda;
    end;
  end;
  AggiornaDescrizioneAziendaBase;
  AbilitaAziendaBase;
end;

procedure TWP554FElaborazioneContoAnnuale.cmbCodAziendaBaseAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  if cmbCodAziendaBase.Text = '' then
    cmbCodAziendaBase.Text:=T440AZIENDA_BASE;
  AggiornaDescrizioneAziendaBase;
end;

procedure TWP554FElaborazioneContoAnnuale.AggiornaDescrizioneAziendaBase;
begin
  lblDAziendaBase.Caption:=WP554DM.P554MW.SelAziendeBase.GetDescAziendaBase(cmbCodAziendaBase.Text);
end;

procedure TWP554FElaborazioneContoAnnuale.AbilitaAziendaBase;
begin
  cmbCodAziendaBase.Visible:=WP554DM.P554MW.SelAziendeBase.VisualizzaAziende and chkElaboraRiepiloghi.Checked;
  lblCodAziendaBase.Visible:=cmbCodAziendaBase.Visible;
  lblDAziendaBase.Visible:=cmbCodAziendaBase.Visible;
end;

procedure TWP554FElaborazioneContoAnnuale.edtMeseAAsyncDoubleClick(
  Sender: TObject; EventParams: TStringList);
begin
  edtMeseA.Text:=edtMeseDa.Text;
end;

end.
