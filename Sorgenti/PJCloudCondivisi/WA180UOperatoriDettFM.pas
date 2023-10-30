unit WA180UOperatoriDettFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR205UDettTabellaFM, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWDBExtCtrls, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWDBRadioGroup, IWCompListbox, meIWDBLookupComboBox,
  IWMultiColumnComboBox, meIWDBComboBox, meIWDBLabel, StrUtils,
  meIWLabel, IWCompCheckbox, meIWDBCheckBox, A000UInterfaccia, Menus,
  WR100UBase, IWCompExtCtrls, IWCompJQueryWidget, meIWImageFile,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, DB,
  IWHTMLControls, meIWLink, medpIWMultiColumnComboBox,
  meIWEdit, OracleData, medpIWImageButton, medpIWC700NavigatorBar, IWTypes;

type
  TWA180FOperatoriDettFM = class(TWR205FDettTabellaFM)
    lblAzienda: TmeIWLabel;
    lblOperatore: TmeIWLabel;
    dedtOperatore: TmeIWDBEdit;
    lblScadenzaAccesso: TmeIWLabel;
    dlblScadenzaAccesso: TmeIWDBLabel;
    lblPassword: TmeIWLabel;
    dedtPassword: TmeIWDBEdit;
    lblScadenzaPassword: TmeIWLabel;
    dlblScadenzaPassword: TmeIWDBLabel;
    dchkOccupato: TmeIWDBCheckBox;
    dchkSblocco: TmeIWDBCheckBox;
    dchkNuovaPassword: TmeIWDBCheckBox;
    lblVisualizzaCessati: TmeIWLabel;
    dedtVisualizzaCessati: TmeIWDBEdit;
    lblProfiliAssegnati: TmeIWLabel;
    dcmbPermessi: TmeIWDBLookupComboBox;
    dcmbFiltroAnagrafe: TmeIWDBLookupComboBox;
    dcmbFiltroFunzioni: TmeIWDBLookupComboBox;
    dcmbFiltroDizionario: TmeIWDBLookupComboBox;
    lblDescAzienda: TmeIWLabel;
    dchkIntegrazioneAnagrafica: TmeIWDBCheckBox;
    lnkPermessi: TmeIWLink;
    lnkFiltroAnagrafe: TmeIWLink;
    lnkFiltroFunzioni: TmeIWLink;
    lnkFiltroDizionario: TmeIWLink;
    dcmbAzienda: TMedpIWMultiColumnComboBox;
    lblMatricola: TmeIWLabel;
    lblNominativo: TmeIWLabel;
    lblCodFiscale: TmeIWLabel;
    edtMatricola: TmeIWEdit;
    edtNominativo: TmeIWEdit;
    edtCodFiscale: TmeIWEdit;
    lblAnagraficoRiferimento: TmeIWLabel;
    jqVisual: TIWJQueryWidget;
    imgC700SelezioneAnagrafe: TmeIWImageFile;
    imgC700PulisciSelezione: TmeIWImageFile;
    imgC700RicercaAnagrafe: TmeIWImageFile;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnAccediClick(Sender: TObject);
    procedure dcmbAziendaChange(Sender: TObject; Index: Integer);
    procedure imgC700SelezioneAnagrafeClick(Sender: TObject);
    procedure imgC700PulisciSelezioneClick(Sender: TObject);
  private
    FGestSelAnag: Boolean;
    FOldAzienda: String;
    procedure ResultSelAnagrafe(Sender: TObject; Result: Boolean);
    procedure ResultRicercaAnagrafe(Sender: TObject; Result: Boolean);
    procedure ResetSelAnagrafe;
  public
    procedure AbilitaComponenti; override;
    procedure DataSet2Componenti; override;
    procedure Componenti2DataSet; override;
    procedure CaricaMultiColumnCombobox; override;
    procedure OnAziendaChange;
    procedure OnDataSourceTabellaStateChange;
    procedure AggiornaDatiAnagraficaCollegata;
    property GestSelAnag: Boolean read FGestSelAnag;
  end;

implementation

uses WA180UOperatoriDM, WA180UOperatori,
     WA181UAziende, WA182UPermessi, WA183UFiltroAnagrafe,
     WA184UFiltroFunzioni, WA185UFiltroDizionario,
     WA186ULoginDipendenti, WA187UAccessi;

{$R *.dfm}

procedure TWA180FOperatoriDettFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;

  dcmbPermessi.ListSource:=TWA180FOperatoriDM(WR302DM).dsrI071;
  dcmbFiltroAnagrafe.ListSource:=TWA180FOperatoriDM(WR302DM).dsrI072Dist;
  dcmbFiltroFunzioni.ListSource:=TWA180FOperatoriDM(WR302DM).dsrI073Dist;
  dcmbFiltroDizionario.ListSource:=TWA180FOperatoriDM(WR302DM).dsrI074Dist;

  dchkIntegrazioneAnagrafica.Visible:=(Parametri.CampiRiferimento.C5_IntegrazAnag = 'F') or
                                      (Parametri.CampiRiferimento.C5_IntegrazAnag = 'T');

  dedtPassword.Enabled:=Parametri.I070_Password;

  // associazione operatore - anagrafica
  FOldAzienda:='';
  OnAziendaChange;
end;

procedure TWA180FOperatoriDettFM.imgC700PulisciSelezioneClick(Sender: TObject);
// pulisce l'eventuale anagrafica collegato all'operatore
begin
  // annullamento del progressivo collegato
  if WR302DM.selTabella.State in [dsInsert,dsEdit] then
  begin
    WR302DM.selTabella.FieldByName('T030_PROGRESSIVO').Value:=null;
    AggiornaDatiAnagraficaCollegata;
  end;

  // reset selezione anagrafica
  ResetSelAnagrafe;
end;

procedure TWA180FOperatoriDettFM.OnAziendaChange;
var
  LLinkI070T030: String;
  LAbil: Boolean;
begin
  // imposta variabili
  LLinkI070T030:=(WR302DM as TWA180FOperatoriDM).GetDatoEnte(dcmbAzienda.Text,'C33_LINK_I070_T030');

  // L'associazione si può fare solo se si opera sull'azienda correntemente in uso.
  // In caso contrario (Parametri.Azienda <> I070.AZIENDA) a seconbda del valore di C33_Link_I070_T030 :
  // - 'N': nulla
  // - 'F': non visualizzare il riquadro ma consentire l'operatività della pagina
  // - 'O': non visualizzare il riquadro e non consentire l'operatività della pagina (accesso in sola lettura forzato)
  FGestSelAnag:=(Parametri.Azienda = dcmbAzienda.Text) and R180In(LLinkI070T030,['F','O']);

  C190VisualizzaElemento(jqVisual,'grpAnagraficoRiferimento',FGestSelAnag);
  lblAnagraficoRiferimento.Caption:='Anagrafica di riferimento' + IfThen(LLinkI070T030 = 'O',' (*)');
  if FGestSelAnag then
  begin
    AggiornaDatiAnagraficaCollegata;
  end;

  // se l'azienda è diversa da quella di accesso ed il link agli operatori è obbligatorio non consente l'operatività (accesso in sola lettura forzato)
  LAbil:=(WR302DM.selTabella.State = dsBrowse) and
         (not TWA180FOperatori(Self.Owner).SolaLettura) and
         ((Parametri.Azienda = dcmbAzienda.Text) or (LLinkI070T030 <> 'O'));
  TWA180FOperatori(Self.Owner).actCopiaSu.Enabled:=LAbil;
  TWA180FOperatori(Self.Owner).actNuovo.Enabled:=LAbil;
  TWA180FOperatori(Self.Owner).actModifica.Enabled:=LAbil;
  TWA180FOperatori(Self.Owner).actElimina.Enabled:=LAbil;
  TWA180FOperatori(Self.Owner).AggiornaToolBar(TWA180FOperatori(Self.Owner).grdNavigatorBar,TWA180FOperatori(Self.Owner).actlstNavigatorBar);
end;

procedure TWA180FOperatoriDettFM.DataSet2Componenti;
var
  Sysdate:TDateTime;
begin
  Sysdate:=Date; // Trunc(R180Sysdate(WR302DM.selTabella.Session)); // utilizza la data del webserver

  dcmbAzienda.ItemIndex:=-1;
  dcmbAzienda.Text:=WR302DM.selTabella.FieldByName('AZIENDA').AsString;
  lblDescAzienda.Caption:=VarToStr(TWA180FOperatoriDM(WR302DM).QI090.LookUp('AZIENDA',WR302DM.selTabella.FieldByName('AZIENDA').AsString, 'DESCRIZIONE'));

  dcmbPermessi.KeyValue:=WR302DM.selTabella.FieldByName('PERMESSI').AsString;
  dcmbFiltroAnagrafe.KeyValue:=WR302DM.selTabella.FieldByName('FILTRO_ANAGRAFE').AsString;
  dcmbFiltroFunzioni.KeyValue:=WR302DM.selTabella.FieldByName('FILTRO_FUNZIONI').AsString;
  dcmbFiltroDizionario.KeyValue:=WR302DM.selTabella.FieldByName('FILTRO_DIZIONARIO').AsString;

  dlblScadenzaPassword.Visible:=TWA180FOperatoriDM(WR302DM).QI090.FieldByName('VALID_PASSWORD').AsInteger > 0;
  if not dlblScadenzaPassword.Visible then
    lblScadenzaPassword.Caption:='Scadenza password: illimitata'
  else
    lblScadenzaPassword.Caption:='Scadenza:';
  // scadenza accesso utente
  if (WR302DM.selTabella.FieldByName('UTENTE').AsString <> 'SYSMAN') and
     (TWA180FOperatoriDM(WR302DM).QI090.FieldByName('VALID_UTENTE').AsInteger > 0) then
  begin
    if (not WR302DM.selTabella.FieldByName('DATA_ACCESSO').IsNull) and
       (TWA180FOperatoriDM(WR302DM).QI090.FieldByName('VALID_UTENTE').AsInteger > 0) and
       (R180AddMesi(WR302DM.selTabella.FieldByName('DATA_ACCESSO').AsDateTime,TWA180FOperatoriDM(WR302DM).QI090.FieldByName('VALID_UTENTE').AsInteger) <= Sysdate) then
      lblScadenzaAccesso.Caption:='Accesso scaduto:'
    else
      lblScadenzaAccesso.Caption:='Scadenza accesso:';
      dlblScadenzaAccesso.Visible:=true;
    end
  else
  begin
    dlblScadenzaAccesso.Visible:=false;
    lblScadenzaAccesso.Caption:='Scadenza accesso: illimitata';
  end;

  if lblScadenzaAccesso.Caption <> 'Accesso scaduto:' then
  begin
    //RiabilitaOperatore.Enabled:=false;
    //RiabilitaOperatore1.Enabled:=false;
    lblScadenzaAccesso.Css:='intestazione';
  end
  else
    begin
    //RiabilitaOperatore.Enabled:=true;
    //RiabilitaOperatore1.Enabled:=true;
    lblScadenzaAccesso.Css:='intestazione font_rosso';
  end;

  TWA180FOperatoriDM(WR302DM).AziendaCorrente:=WR302DM.selTabella.FieldByName('AZIENDA').AsString;
  TWA180FOperatoriDM(WR302DM).AggiornaFiltroProfili;
end;

procedure TWA180FOperatoriDettFM.AbilitaComponenti;
begin
  if WR302DM.selTabella.State in [dsEdit,dsInsert] then
  begin
    WR302DM.selTabella.FieldByName('UTENTE').ReadOnly:=WR302DM.selTabella.FieldByName('UTENTE').AsString = 'SYSMAN';
    dedtOperatore.ReadOnly:=WR302DM.selTabella.FieldByName('UTENTE').ReadOnly;

    dcmbAzienda.ReadOnly:=TWA180FOperatoriDM(WR302DM).EsistonoLinkOperatori;
  end;

  // ricerca anagrafica collegata abilitata in browse
  imgC700RicercaAnagrafe.Enabled:=(WR302DM.selTabella.State = dsBrowse);
end;

procedure TWA180FOperatoriDettFM.CaricaMultiColumnCombobox;
var
  LDS: TOracleDataSet;
begin
  inherited;

  // carica multicolumn aziende
  LDS:=TWA180FOperatoriDM(WR302DM).QI090;
  LDS.AfterScroll:=nil;
  try
    LDS.Refresh;
    C190CaricaMepdMulticolumnComboBox(dcmbAzienda,LDS,'AZIENDA');
  finally
    LDS.AfterScroll:=TWA180FOperatoriDM(WR302DM).QI090AfterScroll;
  end;
end;

procedure TWA180FOperatoriDettFM.Componenti2DataSet;
begin
  WR302DM.selTabella.FieldByName('AZIENDA').AsString:=dcmbAzienda.Text;
end;

procedure TWA180FOperatoriDettFM.btnAccediClick(Sender: TObject);
begin
  TWR100FBase(Self.Parent).AccediForm(TmeIWLink(Sender).Tag,'AZIENDA=' + dcmbAzienda.Text + '|' +
                                                            'PROFILO=' + IfThen((Sender as TmeIWLink).Name = 'lnkPermessi',      dcmbPermessi.Text,
                                                                         IfThen((Sender as TmeIWLink).Name = 'lnkFiltroAnagrafe',dcmbFiltroAnagrafe.Text,
                                                                         IfThen((Sender as TmeIWLink).Name = 'lnkFiltroFunzioni',dcmbFiltroFunzioni.Text,
                                                                                                                                 dcmbFiltroDizionario.Text))));
end;

procedure TWA180FOperatoriDettFM.dcmbAziendaChange(Sender: TObject; Index: Integer);
begin
  inherited;
  lblDescAzienda.Caption:=VarToStr(TWA180FOperatoriDM(WR302DM).QI090.LookUp('AZIENDA', dcmbAzienda.Items[Index].RowData[0], 'DESCRIZIONE'));

  TWA180FOperatoriDM(WR302DM).AziendaCorrente:=dcmbAzienda.Items[Index].RowData[0];
  TWA180FOperatoriDM(WR302DM).AggiornaFiltroProfili;

  OnAziendaChange;
end;

procedure TWA180FOperatoriDettFM.OnDataSourceTabellaStateChange;
begin
  // aggiorna anagrafica rif.
  if FGestSelAnag then
  begin
    AggiornaDatiAnagraficaCollegata;
  end;
end;

procedure TWA180FOperatoriDettFM.imgC700SelezioneAnagrafeClick(Sender: TObject);
// apre il frame di selezione anagrafica
var
  LDataRif: TDateTime;
  LC700Nav: TmedpIWC700NavigatorBar;
begin
  if (Sender = imgC700SelezioneAnagrafe) and
     (not (WR302DM.selTabella.State in [dsInsert,dsEdit])) then
    Exit;

  LC700Nav:=(Self.Owner as TWA180FOperatori).grdC700;

  LDataRif:=Parametri.DataLavoro;
  LC700Nav.WC700FM.C700DataLavoro:=LDataRif;
  LC700Nav.WC700FM.C700DataDal:=LDataRif;
  if LC700Nav.WC700FM.C700SettaPeriodoSelAnagrafe(LDataRif,LDataRif) then
    LC700Nav.SelAnagrafe.CloseAll;
  LC700Nav.SelAnagrafe.Open;

  // in base al pulsante premuto imposta l'evento di gestione della conferma di selezione anagrafica
  if Sender = imgC700SelezioneAnagrafe then
    LC700Nav.WC700FM.ResultEvent:=ResultSelAnagrafe
  else
    LC700Nav.WC700FM.ResultEvent:=ResultRicercaAnagrafe;

  // presenta il frame di selezione anagrafe
  LC700Nav.actSelezioneAnagraficheExecute(nil);
end;

procedure TWA180FOperatoriDettFM.ResultSelAnagrafe(Sender: TObject; Result: Boolean);
// evento in risposta alla conferma della selezione anagrafica
var
  LC700Nav: TmedpIWC700NavigatorBar;
  LSqlText:string;
begin
  if not Result then
    Exit;

//  LSqlText:=Trim((Self.Owner as TWA180FOperatori).grdC700.WC700FM.SQLCreato.Text);
//  if Pos('ORDER BY',UpperCase(LSqlText)) > 0 then
//    LSqlText:=Copy(LSqlText,1,Pos('ORDER BY',UpperCase(LSqlText)) - 1);
//
//  edtMatricola.Text:=LSqlText;

  LC700Nav:=(Self.Owner as TWA180FOperatori).grdC700;

  if (LC700Nav.SelAnagrafe.Active) and
     (LC700Nav.SelAnagrafe.RecordCount > 0) then
  begin
    WR302DM.selTabella.FieldByName('T030_PROGRESSIVO').AsInteger:=LC700Nav.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  end
  else
  begin
    WR302DM.selTabella.FieldByName('T030_PROGRESSIVO').Value:=null;
  end;

  // aggiorna i dati dell'anagrafica
  AggiornaDatiAnagraficaCollegata;
end;

procedure TWA180FOperatoriDettFM.ResultRicercaAnagrafe(Sender: TObject; Result: Boolean);
// evento in risposta alla conferma della selezione anagrafica
var
  LC700Nav: TmedpIWC700NavigatorBar;
  LAziendaCorr: String;
  LFound: Boolean;
  LMsg: string;
begin
  if not Result then
    Exit;

//  LSqlText:=Trim((Self.Owner as TWA180FOperatori).grdC700.WC700FM.SQLCreato.Text);
//  if Pos('ORDER BY',UpperCase(LSqlText)) > 0 then
//    LSqlText:=Copy(LSqlText,1,Pos('ORDER BY',UpperCase(LSqlText)) - 1);
//
//  edtMatricola.Text:=LSqlText;

  LAziendaCorr:=WR302DM.selTabella.FieldByName('AZIENDA').AsString;
  LC700Nav:=(Self.Owner as TWA180FOperatori).grdC700;

  if (not LC700Nav.SelAnagrafe.Active) or
     (LC700Nav.SelAnagrafe.RecordCount = 0) then
  begin
    MsgBox.MessageBox('Nessuna anagrafica selezionata!',INFORMA);
    Exit;
  end;

  LFound:=False;
  LC700Nav.SelAnagrafe.First;
  while not LC700Nav.SelAnagrafe.Eof do
  begin
    LFound:=WR302DM.selTabella.SearchRecord('AZIENDA;T030_PROGRESSIVO',VarArrayOf([LAziendaCorr,LC700Nav.SelAnagrafe.FieldByName('PROGRESSIVO').AsInteger]),[srFromBeginning]);
    if LFound then
      Break;
    LC700Nav.SelAnagrafe.Next;
  end;

  // segnalazione se nessun operatore corrisponde al criterio di ricerca indicato
  if not LFound then
  begin
    if LC700Nav.SelAnagrafe.RecordCount = 1 then
      LMsg:=Format('Nessun operatore è collegato all''anagrafica selezionata'#13#10'(%s %s)',
                   [LC700Nav.SelAnagrafe.FieldByName('COGNOME').AsString,
                    LC700Nav.SelAnagrafe.FieldByName('NOME').AsString])
    else
      LMsg:=Format('Nessun operatore è collegato ad alcuna'#13#10'delle %d anagrafiche selezionate!',
                   [LC700Nav.SelAnagrafe.RecordCount]);
    MsgBox.MessageBox(LMsg,INFORMA);
  end;
end;

procedure TWA180FOperatoriDettFM.ResetSelAnagrafe;
var
  LC700Nav: TmedpIWC700NavigatorBar;
begin
  //Farlo solo se è stata cambiata l'azienda, altrimenti perde i riferimenti al vecchio filtro sulla vecchia selezione
  if dcmbAzienda.Text <> FOldAzienda then
  begin
    FOldAzienda:=dcmbAzienda.Text;

    LC700Nav:=(Self.Owner as TWA180FOperatori).grdC700;

    {
    try
      LC700Nav.DistruggiSelAnagrafe;
    except
    end;
    Parametri.ColonneStruttura.Clear;

    C600frmSelAnagrafe.CreaSelAnagrafe(A008FOperatoriDtM1.DbIris008B,nil,0,False);
    C600frmSelAnagrafe.C600Progressivo:=0;
    C600frmSelAnagrafe.C600FSelezioneAnagrafe.Singolodipendente1.Checked:=False;
    }

    // se la selezione è resettata annulla il progressivo dell'anagrafica collegata eventualmente impostato
    if WR302DM.selTabella.State in [dsInsert,dsEdit] then
    begin
      WR302DM.selTabella.FieldByName('T030_PROGRESSIVO').Value:=null;
      AggiornaDatiAnagraficaCollegata;
    end;
  end;
end;

procedure TWA180FOperatoriDettFM.AggiornaDatiAnagraficaCollegata;
// aggiorna i dati anagrafici del progressivo eventualmente associato all'operatore
var
  LProg: Integer;
  LMatricola: string;
  LNominativo: String;
  LCodFiscale: string;
  LselT030: TOracleDataSet;
begin
  LMatricola:='';
  LNominativo:='';
  LCodFiscale:='';

  LProg:=WR302DM.selTabella.FieldByName('T030_PROGRESSIVO').AsInteger;
  if LProg <> 0 then
  begin
    LselT030:=(WR302DM as TWA180FOperatoriDM).selT030;
    LselT030.Close;
    LselT030.SetVariable('PROGRESSIVO',LProg);
    LselT030.Open;
    if LselT030.RecordCount > 0 then
    begin
      LMatricola:=LselT030.FieldByName('MATRICOLA').AsString;
      LNominativo:=Format('%s %s',[LselT030.FieldByName('COGNOME').AsString,LselT030.FieldByName('NOME').AsString]);
      LCodFiscale:=LselT030.FieldByName('CODFISCALE').AsString;
    end;
  end;

  edtMatricola.Text:=LMatricola;
  edtNominativo.Text:=LNominativo;
  edtCodFiscale.Text:=LCodFiscale;

  // gestione abilitazioni e visualizzazioni pulsanti
  C190AbilitaComponente(imgC700SelezioneAnagrafe,WR302DM.selTabella.State in [dsInsert,dsEdit]);
  C190AbilitaComponente(imgC700PulisciSelezione,WR302DM.selTabella.State in [dsInsert,dsEdit]);
  imgC700RicercaAnagrafe.Visible:=WR302DM.selTabella.State = dsBrowse;
end;

end.
