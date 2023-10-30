unit W033UProspettoAssenze;

{ [NOTA Gallizio 2017-11-10]: Le righe indicate con (*) sono state commentate durante la rivistazione del
  prospetto perchè la funzionalità di cancellazione periodo non è impiegata. }

interface

uses
  W010URichiestaAssenze, W010URichiestaAssenzeDM, W010UCancPeriodoFM,
  SysUtils, StrUtils, Classes, Graphics, Controls, IWApplication,
  IWTemplateProcessorHTML, IWCompLabel, Generics.Collections,
  IWControl, IWHTMLControls, IWCompEdit,
  IWCompButton, Oracle, OracleData, RegistrazioneLog, Variants, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWAppForm, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWVCLComponent, DatiBloccati, ActnList, Menus, IWCompMenu, R012UWebAnagrafico,
  IWDBGrids, IW.Browser.Firefox, medpIWDBGrid, DB, DBClient,
  A000UCostanti, A000USessione, A000UInterfaccia, C004UParamForm, C018UIterAutDM,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb, R010UPAGINAWEB,
  meIWLabel, meIWEdit, meIWButton,
  meIWImageFile, IWAdvCheckGroup, meTIWAdvCheckGroup, meIWLink, Forms, IWVCLBaseContainer,
  IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, meIWRegion,
  meIWGrid, medpIWTabControl,
  W033UAutorizzazioneAssenzeFM, W033ULegendaAssenzeFM, W033UProspettoAssenzeDM,
  IWCompListbox, meIWComboBox, IWCompGrids, IWCompExtCtrls, IW.Browser.InternetExplorer,
  A000UMessaggi, W000UMessaggi, IWCompCheckbox, meIWCheckBox, IWCompJQueryWidget,
  DBXJSON{$IF CompilerVersion >= 31}, System.JSON{$ENDIF}, WR010UBase;

type
  TColonna = class
  public
    Name, TitleLabel, Classes, ClassiHeader:String;
    Key, Frozen, Hidden: Boolean;
    Width: Integer;
  end;

  TW033FProspettoAssenze = class(TR012FWebAnagrafico)
    W033ParametriRG: TmeIWRegion;
    edtPeriodoDal: TmeIWEdit;
    edtPeriodoAl: TmeIWEdit;
    btnEsegui: TmeIWButton;
    lblGiustificativi: TmeIWLabel;
    cgpGiustificativi: TmeTIWAdvCheckGroup;
    imgSelezionaTuttoGiustificativi: TmeIWImageFile;
    imgDeselezionaTuttoGiustificativi: TmeIWImageFile;
    imgInvertiSelezioneGiustificativi: TmeIWImageFile;
    lblTipologie: TmeIWLabel;
    cgpTipologie: TmeTIWAdvCheckGroup;
    W033ProspettoRG: TmeIWRegion;
    tpParametri: TIWTemplateProcessorHTML;
    tpProspetto: TIWTemplateProcessorHTML;
    tabProspettoAssenze: TmedpIWTabControl;
    lblParametriOpzionali: TmeIWLabel;
    cgpParametriOpzionali: TmeTIWAdvCheckGroup;
    lnkLegendaColoriGiorni: TmeIWLink;
    cmbDatoRaggr: TmeIWComboBox;
    lblDatoRaggr: TmeIWLabel;
    pmnSeleziona: TPopupMenu;
    mnuSelezionaTutto: TMenuItem;
    mnuDeselezionaTutto: TMenuItem;
    mnuInvertiSelezione: TMenuItem;
    jqProspetto: TIWJQueryWidget;
    edtHdnIdRichiesta: TmeIWEdit;
    btnHdnCausaleAut: TmeIWButton;
    edtHdnPaginaAttuale: TmeIWEdit;
    edtHdnScrollTop: TmeIWEdit;
    edtHdnScrollLeft: TmeIWEdit;
    imgPeriodoPrec: TmeIWImageFile;
    imgPeriodoSucc: TmeIWImageFile;
    pmnMenuCella: TPopupMenu;
    EsportaInExcelItem: TMenuItem;
    btnHdnEsportaExcel: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure imgDeselezionaTuttoGiustificativiClick(Sender: TObject);
    procedure imgInvertiSelezioneGiustificativiClick(Sender: TObject);
    procedure imgSelezionaTuttoGiustificativiClick(Sender: TObject);
    procedure lnkLegendaColoriGiorniClick(Sender: TObject);
    //procedure lnkCausaleCancClick(Sender: TObject);  (*)
    procedure tabProspettoAssenzeTabControlChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure mnuSelezionaTuttoClick(Sender: TObject);
    procedure mnuDeselezionaTuttoClick(Sender: TObject);
    procedure mnuInvertiSelezioneClick(Sender: TObject);
    procedure tpParametriUnknownTag(const AName: string; var VValue: string);
    procedure tabProspettoAssenzeTabControlChange(Sender: TObject);
    procedure btnHdnCausaleAutClick(Sender: TObject);
    procedure btnHdnEsportaExcelClick(Sender: TObject);
  private
    Dal,Al:TDateTime;
    FiltroDip,ElencoGiust,ElencoTipi:String;
    NRigheCausali:Integer;
    W033DM: TW033FProspettoAssenzeDM;
    W033FAutorizzazioneAssenzeFM: TW033FAutorizzazioneAssenzeFM;
    //W010DM: TW010FRichiestaAssenzeDM; (*)
    //W010CancPeriodoFM: TW010FCancPeriodoFM;  (*)
    W033FLegendaAssenzeFM: TW033FLegendaAssenzeFM;
    C004FParamFormPrv:TC004FParamForm;
    C018:TC018FIterAutDM;
    // C018Canc:TC018FIterAutDM; (*)
    AutorizzazioneRichieste:Boolean;
    RaggruppamentoCorrente: String; // Impostato da CaricaLista() e usato da GetDatiTabellaProspettoJSON()
    MyFormatSettings:TFormatSettings;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ImpostaJqProspetto;
    procedure ElaboraProspetto;
    procedure CaricaRichiesteAutorizzabili;
    procedure CaricaLista;
    procedure GetDatiTabellaProspettoJSON(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
    function GetDatiExcel: TStream;
  protected
    procedure RefreshPage; override;
    procedure DistruggiOggetti; override;
    procedure Notification(AComponent: TComponent;  Operation: TOperation); override;
  public
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

{$R *.DFM}

function TW033FProspettoAssenze.InizializzaAccesso:Boolean;
begin
  Result:=True;
  Dal:=ParametriForm.Dal;
  Al:=ParametriForm.Al;
  edtPeriodoDal.Text:=DateToStr(Dal);
  edtPeriodoAl.Text:=DateToStr(Al);
  GetDipendentiDisponibili(Parametri.DataLavoro);
end;

procedure TW033FProspettoAssenze.IWAppFormCreate(Sender: TObject);
begin
  Self.AggiungiPluginJavaScript('JQGRID_LOCALE_IT', A000TraduzioneStringhe(A000MSG_W033_ERR_JS_JQGRID_NON_SUPP));
  Self.AggiungiPluginJavaScript('JQGRID',A000TraduzioneStringhe(A000MSG_W033_ERR_JS_JQGRID_NON_SUPP));
  inherited;

  // inizializza valori
  Dal:=R180InizioMese(Parametri.DataLavoro);
  Al:=R180FineMese(Parametri.DataLavoro);

  //C004: gestire il ProgOper per gli utenti web...
  C004FParamFormPrv:=CreaC004(SessioneOracle,'W033',Parametri.Operatore,False);
  //SelezionePeriodica:=True;

  W033DM:=TW033FProspettoAssenzeDM.Create(Self);

  with WR000DM.selT265 do
  begin
    Filtered:=True;  //Filtro Dizionario
    Open;
    Tag:=Tag + 1;
    while not Eof do
    begin
      cgpGiustificativi.Items.Add(StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      Next;
    end;
  end;
  with WR000DM.selT275 do
  begin
    Filtered:=True;  //Filtro Dizionario
    Open;
    Tag:=Tag + 1;
    if Parametri.CampiRiferimento.C90_W010CausPres = 'S' then
      while not Eof do
      begin
        cgpGiustificativi.Items.Add(StringReplace(Format('%-5s %s',[FieldByName('CODICE').AsString,FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
        Next;
      end;
  end;
  cgpGiustificativi.Items.Sort;
  //cgpTipologie.IsChecked[0]:=True; In alternativa al GetParametriFunzione
  cmbDatoRaggr.Items.Clear;
  with W033DM.selI010 do
  begin
    First;
    cmbDatoRaggr.Items.Add('');
    while not Eof do
    begin
      cmbDatoRaggr.Items.Add(FieldByName('NOME_LOGICO').AsString);
      Next;
    end;
  end;
  GetParametriFunzione;

  // apre dataset per decodifica codici causali
  W033DM.selCausali.Open;

  //Controllo se gestire l'autorizzazione delle richieste
  AutorizzazioneRichieste:=False;
  if not SolaLettura then
  begin
    try
      WR000DM.Responsabile:=True;
      C018:=TC018FIterAutDM.Create(Self);
      C018.Responsabile:=WR000DM.Responsabile;
      C018.Iter:=ITER_GIUSTIF;
      C018.PreparaDataSetIter(W033DM.selaT050,tiAutorizzazione);
      AutorizzazioneRichieste:=True;
    except
      //l'operatore non ha l'abilitazione agli iter: non gestisco l'autorizzazione delle richieste
      WR000DM.Responsabile:=False;
    end;

    // empoli - commessa 2012/102.ini (*)
    // prepara il C018 per la cancellazione periodo
    {W010DM:=TW010FRichiestaAssenzeDM.Create(Self);
    W010DM.C018DM:=C018;
    C018Canc:=TC018FIterAutDM.Create(Self);
    C018Canc.Iter:=ITER_GIUSTIF;
    C018Canc.PreparaDataSetIter(W010DM.selT050,tiRichiesta);}
    // empoli - commessa 2012/102.fine
  end;

  tabProspettoAssenze.AggiungiTab(A000TraduzioneStringhe(A000MSG_W033_MSG_LBL_PARAMETRI), W033ParametriRG);
  tabProspettoAssenze.AggiungiTab(A000TraduzioneStringhe(A000MSG_W033_MSG_LBL_PROSPETTO), W033ProspettoRG);
  tabProspettoAssenze.ActiveTab:=W033ParametriRG;

  MyFormatSettings:=TFormatSettings.Create;  //TFormatSettings è un record, non va eseguita la Free
  MyFormatSettings.DecimalSeparator:='.';
  Self.RegistraMetodoAJAX('GetDatiTabellaProspetto',GetDatiTabellaProspettoJSON);
  ImpostaJqProspetto;

  // imposta la gestione automatica degli spostamenti di periodo
  AssegnaGestPeriodo(edtPeriodoDal,edtPeriodoAl,imgPeriodoPrec,imgPeriodoSucc);
end;

procedure TW033FProspettoAssenze.lnkLegendaColoriGiorniClick(Sender: TObject);
begin
  W033FLegendaAssenzeFM:=TW033FLegendaAssenzeFM.Create(Self);
end;

procedure TW033FProspettoAssenze.mnuSelezionaTuttoClick(Sender: TObject);
begin
  imgSelezionaTuttoGiustificativiClick(nil);
end;

procedure TW033FProspettoAssenze.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    { (*)
    if AComponent = W010CancPeriodoFM then
    begin
      // chiusura frame cancellazione periodo
      try
        W010CancPeriodoFM:=nil;
        // aggiorna prospetto
        if tabProspettoAssenze.ActiveTab = W033ProspettoRG then
          btnEseguiClick(nil);
      except
      end;
    end}   
    if AComponent = W033FAutorizzazioneAssenzeFM then
    begin
      // chiusura frame autorizzazione richiesta
      try
        W033FAutorizzazioneAssenzeFM:=nil;
        // aggiorna prospetto
        if tabProspettoAssenze.ActiveTab = W033ProspettoRG then
          btnEseguiClick(nil);
      except
      end;
    end;
  end;
end;

procedure TW033FProspettoAssenze.mnuDeselezionaTuttoClick(Sender: TObject);
begin
  imgDeselezionaTuttoGiustificativiClick(nil);
end;

procedure TW033FProspettoAssenze.mnuInvertiSelezioneClick(Sender: TObject);
begin
  imgInvertiSelezioneGiustificativiClick(nil);
end;

// empoli - commessa 2012/102.ini    (*)
{procedure TW033FProspettoAssenze.lnkCausaleCancClick(Sender: TObject);
// cancellazione periodo
begin
  if Assigned(W010CancPeriodoFM) then
    FreeAndNil(W010CancPeriodoFM);
  W010CancPeriodoFM:=TW010FCancPeriodoFM.Create(Self);
  FreeNotification(W010CancPeriodoFM);
  W010CancPeriodoFM.W010DM:=W010DM;
  W010CancPeriodoFM.C018:=C018Canc;
  W010CancPeriodoFM.IdOrig:=StrToIntDef((Sender as TmeIWLink).FriendlyName,0);
  W010CancPeriodoFM.DataProposta:=(Sender as TmeIWLink).Tag;
  W010CancPeriodoFM.Visualizza;
end;}
// empoli - commessa 2012/102.fine

procedure TW033FProspettoAssenze.GetParametriFunzione;
{Leggo i parametri della form}
var S:String;
    i,j:Integer;
begin
  i:=1;
  while C004FParamFormPrv.GetParametro('cgpCausali' + IntToStr(i),'FINITE') <> 'FINITE' do
  begin
    S:=',' + C004FParamFormPrv.GetParametro('cgpCausali' + IntToStr(i),'') + ',';
    for j:=0 to cgpGiustificativi.Items.Count - 1 do
      if Pos(',' + Copy(cgpGiustificativi.Items[j],1,Pos(' ',cgpGiustificativi.Items[j]) - 1) + ',',S) > 0 then
        cgpGiustificativi.IsChecked[j]:=True;
    inc(i);
  end;
  cgpTipologie.IsChecked[0]:=Pos('I',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpTipologie.IsChecked[1]:=Pos('M',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpTipologie.IsChecked[2]:=Pos('N',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpTipologie.IsChecked[3]:=Pos('D',C004FParamFormPrv.GetParametro('cgpTipologie','')) > 0;
  cgpParametriOpzionali.IsChecked[0]:=C004FParamFormPrv.GetParametro('chkTimbrature','N') = 'S';
  cgpParametriOpzionali.IsChecked[1]:=C004FParamFormPrv.GetParametro('chkAssenzaGGIntera','N') = 'S';
  cgpParametriOpzionali.IsChecked[2]:=C004FParamFormPrv.GetParametro('chkEscludiRiposi','N') = 'S';
  cgpParametriOpzionali.IsChecked[3]:=C004FParamFormPrv.GetParametro('chkNominativoSpez','N') = 'S';
  cmbDatoRaggr.ItemIndex:=Max(0,cmbDatoRaggr.Items.IndexOf(VarToStr(W033DM.selI010.Lookup('NOME_CAMPO',C004FParamFormPrv.GetParametro('cmbDatoRaggr',''),'NOME_LOGICO'))));
end;

procedure TW033FProspettoAssenze.PutParametriFunzione;
{Scrivo i parametri della form}
var S:String;
    i:Integer;
begin
  C004FParamFormPrv.Cancella001;
  i:=0;
  S:=StringReplace(ElencoGiust,'''','',[rfReplaceAll]) + ',';
  repeat
    inc(i);
    C004FParamFormPrv.PutParametro('cgpCausali' + IntToStr(i),Copy(S,1,IfThen(Length(S) >= (2000-6),Pos(',',Copy(S,2000-6)),Length(S))));
    S:=Copy(S,IfThen(Length(S) >= (2000-6),Pos(',',Copy(S,2000-6)),Length(S)) + 1);
  until S = '';
  C004FParamFormPrv.PutParametro('cgpTipologie',StringReplace(ElencoTipi,'''','',[rfReplaceAll]));
  C004FParamFormPrv.PutParametro('chkTimbrature',IfThen(cgpParametriOpzionali.IsChecked[0],'S','N'));
  C004FParamFormPrv.PutParametro('chkAssenzaGGIntera',IfThen(cgpParametriOpzionali.IsChecked[1],'S','N'));
  C004FParamFormPrv.PutParametro('chkEscludiRiposi',IfThen(cgpParametriOpzionali.IsChecked[2],'S','N'));
  C004FParamFormPrv.PutParametro('chkNominativoSpez',IfThen(cgpParametriOpzionali.IsChecked[3],'S','N'));
  if cmbDatoRaggr.ItemIndex > 0 then
    C004FParamFormPrv.PutParametro('cmbDatoRaggr',VarToStr(W033DM.selI010.Lookup('NOME_LOGICO',cmbDatoRaggr.Text,'NOME_CAMPO')));
  SessioneOracle.Commit;
end;

procedure TW033FProspettoAssenze.tabProspettoAssenzeTabControlChange(
  Sender: TObject);
begin
  inherited;
  JqProspetto.Enabled:=(tabProspettoAssenze.ActiveTabIndex = 1);
end;

procedure TW033FProspettoAssenze.tabProspettoAssenzeTabControlChanging(
  Sender: TObject; var AllowChange: Boolean);
begin
  //Se passo al prospetto senza aver mai cliccato su Esegui, forzo l'esecuzione
  if (Sender as TmedpIWTabControl).TabByIndex(0).Selected then
    if not W033DM.cdsLista.Active then
      btnEseguiClick(nil);
end;

procedure TW033FProspettoAssenze.tpParametriUnknownTag(const AName: string; var VValue: string);
begin
  inherited;
  if UpperCase(AName) = 'LGNPERIODODAELABORARE' then
    VValue:=A000TraduzioneStringhe(A000MSG_W033_MSG_LGNPERIODOELAB);//'Periodo da elaborare';
end;

procedure TW033FProspettoAssenze.ImpostaJqProspetto;
var
  NumRighePagJQGrid:Integer;
begin
  jqProspetto.OnReady.Clear;
  NumRighePagJQGrid:=Self.GetRighePaginaTabella;
  if NumRighePagJQGrid > 0 then
    jqProspetto.OnReady.Add(Format('parametriTabella.jqGridRowNum=%d;',[NumRighePagJQGrid]))
  else
    jqProspetto.OnReady.Add('parametriTabella.jqGridRowNum=false;');
  jqProspetto.OnReady.Add(Format('parametriTabella.btnHdnEsportaExcelHTMLName="%s";',[btnHdnEsportaExcel.HTMLName]));
  jqProspetto.OnReady.Add('getDatiTabellaProspetto();');
end;

procedure TW033FProspettoAssenze.ElaboraProspetto;
begin
  CaricaRichiesteAutorizzabili;
  CaricaLista;
end;

procedure TW033FProspettoAssenze.CaricaRichiesteAutorizzabili;
begin
  if not AutorizzazioneRichieste then
    exit;

  //Cerco le richieste che il mio utente può autorizzare
  with W033DM.selaT050 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',WR000DM.FiltroRicerca);
    SetVariable('FILTRO_PERIODO','AND T_ITER.DAL <= to_date(''' + FormatDateTime('dd/mm/yyyy',Al) + ''',''dd/mm/yyyy'') AND T_ITER.AL >= to_date(''' + FormatDateTime('dd/mm/yyyy',Dal) + ''',''dd/mm/yyyy'')');
    SetVariable('FILTRO_VISUALIZZAZIONE','and T850.STATO is null and T851.STATO is null');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    // MONDOEDP - commessa MAN/07.ini
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    // MONDOEDP - commessa MAN/07.fine
    Open;
  end;

  // apertura del dataset di supporto per la cancellazione periodo   (*)
  {with W010DM.selT050 do
  begin
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',WR000DM.FiltroRicerca);
    SetVariable('FILTRO_PERIODO','AND T_ITER.DAL <= to_date(''' + FormatDateTime('dd/mm/yyyy',Al) + ''',''dd/mm/yyyy'') AND T_ITER.AL >= to_date(''' + FormatDateTime('dd/mm/yyyy',Dal) + ''',''dd/mm/yyyy'')');
    SetVariable('FILTRO_VISUALIZZAZIONE','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.ini
    SetVariable('FILTRO_STRUTTURA','');
    // MONDOEDP - commessa MAN/07 SVILUPPO#58.fine
    // MONDOEDP - commessa MAN/07.ini
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    // MONDOEDP - commessa MAN/07.fine
    Open;
  end; }
end;

procedure TW033FProspettoAssenze.btnHdnCausaleAutClick(Sender: TObject);
// autorizzazione della richiesta
begin
  W033FAutorizzazioneAssenzeFM:=TW033FAutorizzazioneAssenzeFM.Create(Self);
  FreeNotification(W033FAutorizzazioneAssenzeFM);
  with W033FAutorizzazioneAssenzeFM do
  begin
    W033DM_Aut:=W033DM;
    W001DM_Aut:=WR000DM;
    C018_Aut:=C018;
    CaricaGriglia(EdtHdnIdRichiesta.Text);
  end;
end;

procedure TW033FProspettoAssenze.btnHdnEsportaExcelClick(Sender: TObject);
begin
  streamDownload:=GetDatiExcel;
  InviaFile('ElencoDipendenti.xlsx',streamDownload);
  //(Owner as TWR010FBase).InviaFile('ElencoDipendenti.xlsx',streamDownload);
end;

procedure TW033FProspettoAssenze.CaricaLista;
var i,n,o,NRigheCausaliTemp,nRighePag,LCaus,IdxIdRigaJS:Integer;
    Data:TDateTime;
    DatoRaggr,NomeCampo,ValoreRaggrOld:String;
begin
  with W033DM do
  begin
    selT040.Close;
    selT050.Close;
    selT100.Close;
    if Pos(':DATALAVORO',UpperCase(FiltroDip)) > 0 then
    begin
      if selT040.VariableIndex('DATALAVORO') = -1 then
      begin
        selT040.DeclareVariable('DATALAVORO',otDate);
        selT050.DeclareVariable('DATALAVORO',otDate);
        selT100.DeclareVariable('DATALAVORO',otDate);
      end;
      selT040.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT050.SetVariable('DATALAVORO',Parametri.DataLavoro);
      selT100.SetVariable('DATALAVORO',Parametri.DataLavoro);
    end
    else if selT040.VariableIndex('DATALAVORO') > -1 then
    begin
      selT040.DeleteVariable('DATALAVORO');
      selT050.DeleteVariable('DATALAVORO');
      selT100.DeleteVariable('DATALAVORO');
    end;
    selT040.SetVariable('FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    selT040.SetVariable('DAL',Dal);
    selT040.SetVariable('AL',Al);
    selT040.SetVariable('PRESENZE',Parametri.CampiRiferimento.C90_W010CausPres);
    selT040.Open;
    selT050.SetVariable('FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    selT050.SetVariable('DAL',Dal);
    selT050.SetVariable('AL',Al);
    selT050.SetVariable('PRESENZE',Parametri.CampiRiferimento.C90_W010CausPres);
    selT050.Open;
    selT100.SetVariable('FILTRO_DIP','IN (SELECT /*+ UNNEST */ PROGRESSIVO ' + Copy(FiltroDip,Pos('FROM',FiltroDip),Pos('ORDER BY',FiltroDip) - Pos('FROM',FiltroDip)) + ')');
    selT100.SetVariable('DAL',Dal);
    selT100.SetVariable('AL',Al);
    if cgpParametriOpzionali.IsChecked[0] then
      selT100.Open;

    cdsLista.Close;
    cdsLista.FieldDefs.Clear;
    cdsLista.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsLista.FieldDefs.Add('COGNOME',ftString,50,False);
    cdsLista.FieldDefs.Add('NOME',ftString,50,False);
    cdsLista.FieldDefs.Add('NOMINATIVO',ftString,200,False);
    cdsLista.FieldDefs.Add('DATO_RAGGR',ftString,200,False);
    cdsLista.FieldDefs.Add('ORDINE',ftInteger,0,False);
    cdsLista.FieldDefs.Add('ID_RIGA_JS', ftString, 50);
    cdsLista.FieldDefs.Add('IS_VUOTA', ftBoolean, 0, True);
    for i:=0 to Trunc(Al - Dal) do
      cdsLista.FieldDefs.Add(FormatDateTime('yyyymmdd',Dal + i),ftDate,0,False);
    cdsLista.CreateDataSet;
    cdsLista.LogChanges:=False;
    cdsLista.IndexDefs.Clear;
    cdsLista.IndexDefs.Add('Ricerca',('DATO_RAGGR;ORDINE;COGNOME;NOME;PROGRESSIVO'),[]);
    cdsLista.IndexName:='Ricerca';

    cdsListaTimb.Close;
    cdsListaTimb.FieldDefs.Clear;
    cdsListaTimb.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaTimb.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaTimb.FieldDefs.Add('LAVORATIVO',ftString,1,False);
    cdsListaTimb.FieldDefs.Add('TIMBRATURE',ftString,1,False);
    cdsListaTimb.CreateDataSet;
    cdsListaTimb.LogChanges:=False;

    cdsListaAss.Close;
    cdsListaAss.FieldDefs.Clear;
    cdsListaAss.FieldDefs.Add('PROGRESSIVO',ftInteger,0,False);
    cdsListaAss.FieldDefs.Add('DATA',ftDate,0,False);
    cdsListaAss.FieldDefs.Add('CAUSALE',ftString,5,False);
    cdsListaAss.FieldDefs.Add('SIGLA_CAUSALE',ftString,5,False);
    cdsListaAss.FieldDefs.Add('SELEZIONATO',ftString,1,False);
    cdsListaAss.FieldDefs.Add('DEFINITIVO',ftString,1,False);
    cdsListaAss.FieldDefs.Add('FRUIZIONE',ftString,1,False);
    cdsListaAss.FieldDefs.Add('D_FRUIZIONE',ftString,15,False);
    cdsListaAss.FieldDefs.Add('ID_AUTORIZZABILE',ftInteger,0,False);
    cdsListaAss.FieldDefs.Add('ID_CANCELLABILE',ftInteger,0,False);
    cdsListaAss.FieldDefs.Add('TIPO_RICHIESTA',ftString,1,False);
    cdsListaAss.FieldDefs.Add('NOTE',ftString,10,False);
    cdsListaAss.CreateDataSet;
    cdsListaAss.LogChanges:=False;
    cdsListaAss.IndexDefs.Clear;
    cdsListaAss.IndexDefs.Add('Ricerca',('PROGRESSIVO;DATA'),[]);
    cdsListaAss.IndexName:='Ricerca';

    if cmbDatoRaggr.ItemIndex > 0 then
    begin
      DatoRaggr:=VarToStr(selI010.Lookup('NOME_LOGICO',cmbDatoRaggr.Text,'NOME_CAMPO'));
      NomeCampo:=IfThen(Copy(DatoRaggr,1,4) = 'T430',Copy(DatoRaggr,5),DatoRaggr);
      if A000LookupTabella(NomeCampo,selSQL) then
      begin
        if selSQL.VariableIndex('DECORRENZA') >= 0 then
          selSQL.SetVariable('DECORRENZA',Al);
        try
          selSQL.Open;
        except
        end;
      end;
    end;

    NRigheCausali:=1;
    selAnagrafeW.First;
    while not selAnagrafeW.Eof do
    begin
      cdsLista.Append;
      cdsLista.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
      cdsLista.FieldByName('COGNOME').AsString:=selAnagrafeW.FieldByName('COGNOME').AsString;
      cdsLista.FieldByName('NOME').AsString:=selAnagrafeW.FieldByName('NOME').AsString;
      cdsLista.FieldByName('NOMINATIVO').AsString:=cdsLista.FieldByName('COGNOME').AsString + IfThen(cgpParametriOpzionali.IsChecked[3],CRLF,' ') + cdsLista.FieldByName('NOME').AsString;
      if cmbDatoRaggr.ItemIndex > 0 then
      begin
        QSGruppo.GetDatiStorici(DatoRaggr,SelAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Dal,Al);
        if QSGruppo.LocDatoStorico(Al) then
        begin
          cdsLista.FieldByName('DATO_RAGGR').AsString:=QSGruppo.FieldByName(DatoRaggr).AsString;
          if selSQL.Active then
            cdsLista.FieldByName('DATO_RAGGR').AsString:=cdsLista.FieldByName('DATO_RAGGR').AsString + '     ' + VarToStr(selSQL.Lookup('CODICE',cdsLista.FieldByName('DATO_RAGGR').AsString,'DESCRIZIONE'));
        end;
      end;
      cdsLista.FieldByName('ORDINE').AsInteger:=9999;
      cdsLista.FieldByName('ID_RIGA_JS').AsString:='DIP_' + cdsLista.FieldByName('PROGRESSIVO').AsString;
      cdsLista.FieldByName('IS_VUOTA').AsBoolean:=False;
      cdsLista.Post;
      for i:=0 to Trunc(Al - Dal) do
      begin
        Data:=Dal + i;
        NRigheCausaliTemp:=0;
        cdsListaTimb.Append;
        cdsListaTimb.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
        cdsListaTimb.FieldByName('DATA').AsDateTime:=Data;
        T010F_GGLAVORATIVO.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        T010F_GGLAVORATIVO.SetVariable('DATA',Data);
        T010F_GGLAVORATIVO.Execute;
        cdsListaTimb.FieldByName('LAVORATIVO').AsString:=VarToStr(T010F_GGLAVORATIVO.GetVariable('LAVORATIVO'));
        //Presenza timbrature
        if cgpParametriOpzionali.IsChecked[0] then
          cdsListaTimb.FieldByName('TIMBRATURE').AsString:=IfThen(StrToIntDef(VarToStr(selT100.Lookup('PROGRESSIVO;DATA',VarArrayOf([selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data]),'N_TIMB')),0) > 0,'S','N');
        cdsListaTimb.Post;
        //Cerco le assenze definitive del dipendente
        selT040.Filter:='(PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) + ') AND (DATA = ' + FloatToStr(Data) + ')';
        selT040.Filtered:=True;
        selT040.First;
        while not selT040.Eof do
        begin
          if not cgpParametriOpzionali.IsChecked[2]
          or (VarToStr(WR000DM.selT265.Lookup('CODICE',selT040.FieldByName('CAUSALE').AsString,'CODINTERNO')) <> 'H')
          or (selT040.FieldByName('TIPOGIUST').AsString <> 'I') then
          begin
            if (Pos('''' + selT040.FieldByName('CAUSALE').AsString + '''',ElencoGiust) > 0)
            and (Pos('''' + selT040.FieldByName('TIPOGIUST').AsString + '''',ElencoTipi) > 0) then
            begin
              inc(NRigheCausaliTemp);
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('CAUSALE').AsString:=selT040.FieldByName('CAUSALE').AsString;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT040.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              //LCaus:=Max(Length(cdsListaAss.FieldByName('CAUSALE').AsString),Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString));
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='S';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='S';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT040.FieldByName('TIPOGIUST').AsString;
              if selT040.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=A000TraduzioneStringhe('GG')
              else if selT040.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 ' + A000TraduzioneStringhe('GG')
              else if selT040.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + ' ' + A000TraduzioneStringhe('ore')
              else if selT040.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + '-' + selT040.FieldByName('AORE').AsString;
              // (*)
              {if (selT040.FieldByName('ID_RICHIESTA').AsInteger > 0) and
                 //Cancellazione abilitata
                 (C018 <> nil) and (C018.Revocabile) and
                 FALSE AND // Alberto 02/03/2017: al momento disattivata
                 (Parametri.CampiRiferimento.C90_W010Cancellazione = 'S') then
                 //(StrTipoRichiesta = 'D') and
                 //(IdRevoca <= 0) and // impedisce cancellazione se esiste una revoca
                 //     (TmpAl > TmpDal);
              begin
                cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger:=selT040.FieldByName('ID_RICHIESTA').AsInteger;
              end;}
              // Le note vanno utilizzate solo se il parametro C31_NoteGiustificativi è attivo
              cdsListaAss.FieldByName('NOTE').AsString:='';
              if Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S' then
                cdsListaAss.FieldByName('NOTE').AsString:=selT040.FieldByName('NOTE').AsString;
              cdsListaAss.Post;
            end
            else if cgpParametriOpzionali.IsChecked[1]
            //and (selT040.FieldByName('TIPOGIUST').AsString = 'I')
            then
            begin
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT040.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              LCaus:=Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString);
              if LCaus > 0 then
                inc(NRigheCausaliTemp);
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='N';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='S';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT040.FieldByName('TIPOGIUST').AsString;
              if selT040.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=A000TraduzioneStringhe('GG')
              else if selT040.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 ' + A000TraduzioneStringhe('GG')
              else if selT040.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + ' ' + A000TraduzioneStringhe('ore')
              else if selT040.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT040.FieldByName('DAORE').AsString + '-' + selT040.FieldByName('AORE').AsString;
              // Le note vanno utilizzate solo se il parametro C31_NoteGiustificativi è attivo
              cdsListaAss.FieldByName('NOTE').AsString:='';
              if Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S' then
                cdsListaAss.FieldByName('NOTE').AsString:=selT040.FieldByName('NOTE').AsString;
              cdsListaAss.Post;
            end;
          end;
          selT040.Next;
        end;
        selT040.Filtered:=False;
        //Cerco le assenze richieste del dipendente
        //selT050.Filter:='(PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) + ') AND (' + FloatToStr(Data) + ' >= DAL) AND (' + FloatToStr(Data) + ' <= AL)';
        selT050.Filter:='(PROGRESSIVO = ' + IntToStr(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger) + ') AND (' + FloatToStr(Data) + ' = DATA)';
        selT050.Filtered:=True;
        selT050.First;
        while not selT050.Eof do
        begin
          if (Parametri.CampiRiferimento.C90_W010CausPres = 'S')
          and (VarToStr(WR000DM.selT265.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'CODICE')) = '') then
            T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC','GC')
          else
            T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC',VarToStr(WR000DM.selT265.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'GSIGNIFIC')));
          T010F_GGSIGNIFICATIVO.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
          T010F_GGSIGNIFICATIVO.SetVariable('DATA',Data);
          T010F_GGSIGNIFICATIVO.Execute;
          if (VarToStr(T010F_GGSIGNIFICATIVO.GetVariable('SIGNIFICATIVO')) = 'S')
          and (   not cgpParametriOpzionali.IsChecked[2]
               or (VarToStr(WR000DM.selT265.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'CODINTERNO')) <> 'H')
               or (selT050.FieldByName('TIPOGIUST').AsString <> 'I')) then
          begin
            if (Pos('''' + selT050.FieldByName('CAUSALE').AsString + '''',ElencoGiust) > 0)
            and (Pos('''' + selT050.FieldByName('TIPOGIUST').AsString + '''',ElencoTipi) > 0) then
            begin
              inc(NRigheCausaliTemp);
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('CAUSALE').AsString:=selT050.FieldByName('CAUSALE').AsString;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              //LCaus:=Max(Length(cdsListaAss.FieldByName('CAUSALE').AsString),Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString));
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='S';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='N';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT050.FieldByName('TIPOGIUST').AsString;
              if selT050.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=A000TraduzioneStringhe('GG')
              else if selT050.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 ' + A000TraduzioneStringhe('GG')
              else if selT050.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + ' ' + A000TraduzioneStringhe('ore')
              else if selT050.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + '-' + selT050.FieldByName('AORE').AsString;
              // Le note vanno utilizzate solo se il parametro C31_NoteGiustificativi è attivo
              cdsListaAss.FieldByName('NOTE').AsString:='';
              if Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S' then
                cdsListaAss.FieldByName('NOTE').AsString:=selT050.FieldByName('NOTE_GIUSTIFICATIVO').AsString;

              // chiamata <74473>
              if AutorizzazioneRichieste then
              begin
                if selaT050.Locate('ID',selT050.FieldByName('ID').AsInteger,[]) then
                begin
                  cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsInteger:=selT050.FieldByName('ID').AsInteger;
                  cdsListaAss.FieldByName('TIPO_RICHIESTA').AsString:=selaT050.FieldByName('TIPO_RICHIESTA').AsString;
                end;
                // (*)
                {else if (not SolaLettura) and
                        (W010DM.selT050.Locate('ID',selT050.FieldByName('ID').AsInteger,[])) and
                        (C018.Revocabile) and
                        FALSE AND // Alberto 02/03/2017: al momento disattivata
                        (Parametri.CampiRiferimento.C90_W010Cancellazione = 'S') and
                        (W010DM.selT050.FieldByName('TIPO_RICHIESTA').AsString = 'D') and
                        (W010DM.selT050.FieldByName('AUTORIZZAZIONE').AsString = 'S') and
                        (W010DM.selT050.FieldByName('ELABORATO').AsString <> 'E') and
                        (W010DM.selT050.FieldByName('ID_REVOCA').AsInteger <= 0) and // impedisce cancellazione se esiste una revoca
                        (W010DM.selT050.FieldByName('AL').AsDateTime > W010DM.selT050.FieldByName('DAL').AsDateTime) then
                begin
                  // cancellazione abilitata
                  cdsListaAss.FieldByName('ID_CANCELLABILE').AsInteger:=selT050.FieldByName('ID').AsInteger;
                end;}
              end;
              cdsListaAss.Post;
            end
            else if cgpParametriOpzionali.IsChecked[1]
            //and (selT050.FieldByName('TIPOGIUST').AsString = 'I')
            and (selT050.FieldByName('STATO').AsString = 'S')
            then
            begin
              cdsListaAss.Append;
              cdsListaAss.FieldByName('PROGRESSIVO').AsInteger:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
              cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString:=VarToStr(W033DM.selCausali.Lookup('CODICE',selT050.FieldByName('CAUSALE').AsString,'SIGLA_CAUSALE'));
              LCaus:=Length(cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString);
              if LCaus > 0 then
                inc(NRigheCausaliTemp);
              cdsListaAss.FieldByName('DATA').AsDateTime:=Data;
              cdsListaAss.FieldByName('SELEZIONATO').AsString:='N';
              cdsListaAss.FieldByName('DEFINITIVO').AsString:='N';
              cdsListaAss.FieldByName('FRUIZIONE').AsString:=selT050.FieldByName('TIPOGIUST').AsString;
              if selT050.FieldByName('TIPOGIUST').AsString = 'I' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=A000TraduzioneStringhe('GG')
              else if selT050.FieldByName('TIPOGIUST').AsString = 'M' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:='1/2 ' + A000TraduzioneStringhe('GG')
              else if selT050.FieldByName('TIPOGIUST').AsString = 'N' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + ' ' + A000TraduzioneStringhe('ore')
              else if selT050.FieldByName('TIPOGIUST').AsString = 'D' then
                cdsListaAss.FieldByName('D_FRUIZIONE').AsString:=selT050.FieldByName('DAORE').AsString + '-' + selT050.FieldByName('AORE').AsString;
              // Le note vanno utilizzate solo se il parametro C31_NoteGiustificativi è attivo
              cdsListaAss.FieldByName('NOTE').AsString:='';
              if Parametri.CampiRiferimento.C31_NoteGiustificativi = 'S' then
                cdsListaAss.FieldByName('NOTE').AsString:=selT050.FieldByName('NOTE_GIUSTIFICATIVO').AsString;
              cdsListaAss.Post;
            end;
          end;
          selT050.Next;
        end;
        selT050.Filtered:=False;
        NRigheCausali:=Max(NRigheCausali,NRigheCausaliTemp);
      end;
      selAnagrafeW.Next;
    end;
    if not selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]) then
      selAnagrafeW.First;
    selSQL.Close;

    //Gestione Dato di raggruppamento, solo in caso di griglia paginata
    nRighePag:=Self.GetRighePaginaTabella;
    RaggruppamentoCorrente:='';
    if (cdsLista.RecordCount > 0) and (cmbDatoRaggr.ItemIndex > 0) and (nRighePag > 0) then
    begin
      { Usato più tardi creare la mappa [numero pagina]->[categoria] nel JSON di risposta
        nel metodo GetDatiTabellaProspettoJSON() }
      RaggruppamentoCorrente:=cmbDatoRaggr.Text;
      cdsLista.First;
      IdxIdRigaJS:=0;
      n:=0;
      o:=0;
      ValoreRaggrOld:=cdsLista.FieldByName('DATO_RAGGR').AsString;
      while not cdsLista.Eof do
      begin
        if (cdsLista.FieldByName('DATO_RAGGR').AsString <> ValoreRaggrOld) then
        begin
          //Siamo sul primo record dopo un cambio di raggruppamento. Dovremmo poter aggiungere righe vuote per terminare la pagina.
          if (n > 0) and (n < nRighePag) then
          begin
            for i:=1 to (nRighePag - n) do
            begin
              cdsLista.Append;
              cdsLista.FieldByName('PROGRESSIVO').AsInteger:=0;
              cdsLista.FieldByName('COGNOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
              cdsLista.FieldByName('NOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
              cdsLista.FieldByName('DATO_RAGGR').AsString:=ValoreRaggrOld;
              cdsLista.FieldByName('ORDINE').AsInteger:=o;
              cdsLista.FieldByName('ID_RIGA_JS').AsString:='RAGGR_' + IntToStr(IdxIdRigaJS);
              cdsLista.FieldByName('IS_VUOTA').AsBoolean:=True;
              cdsLista.Post;
              Inc(IdxIdRigaJS);
            end;
            cdsLista.Next; // Mi sposto dall'ultimo elemento aggiunto e torno su quello che stiamo elaborando
          end;
          n:=0;
          Inc(o);
          ValoreRaggrOld:=cdsLista.FieldByName('DATO_RAGGR').AsString;
        end;
        //Assegnazione della pagina alle righe dei dipendenti
        cdsLista.Edit;
        cdsLista.FieldByName('ORDINE').AsInteger:=o;
        cdsLista.Post;
        Inc(n);
        if n = nRighePag then
          n:=0;
        cdsLista.Next;
      end;
      //Gestione righe vuote sull'ultima pagina
      if (n > 0) and (n < nRighePag) then
      begin
        for i:=1 to (nRighePag - n) do
        begin
          cdsLista.Append;
          cdsLista.FieldByName('PROGRESSIVO').AsInteger:=0;
          cdsLista.FieldByName('COGNOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
          cdsLista.FieldByName('NOME').AsString:='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
          cdsLista.FieldByName('DATO_RAGGR').AsString:=ValoreRaggrOld;
          cdsLista.FieldByName('ORDINE').AsInteger:=o;
          cdsLista.FieldByName('ID_RIGA_JS').AsString:='RAGGR_' + IntToStr(IdxIdRigaJS);
          cdsLista.FieldByName('IS_VUOTA').AsBoolean:=True;
          cdsLista.Post;
          Inc(IdxIdRigaJS);
        end;
        cdsLista.Next;
      end;
    end;
  end;
end;

function TW033FProspettoAssenze.GetDatiExcel: TStream;
var
  XlsDataset: TClientDataSet;
  ListaColonne: TList<TPair<String,String>>;
  Campo,Valore, Titolo: String;
  Causale, DCausale, DFruizione: string;
  Data: TDateTime;
  Progressivo, i:integer;
	function GetData(const D:TDateTime):String;
  begin
    Result:=Copy(FormatDateTime('dddd',D),1,2) + ' ';
    if R180Anno(Dal) = R180Anno(Al) then
    begin
      if R180Mese(Dal) = R180Mese(Al) then
        Result:=Result + FormatDateTime('dd',D)
      else
        Result:=Result + FormatDateTime('dd/mm',D);
    end
    else
      Result:=Result + FormatDateTime('dd/mm/yy',D);
  end;
begin
  ListaColonne:=TList<TPair<String,String>>.Create;
  Result:=nil;
  XlsDataset:=TClientDataSet.Create(self);
  try
    //Ciclo per creazione DS di appoggio
    if W033DM.cdsLista.RecordCount = 0 then
      Exit;
    if W033DM.cdsLista.FieldDefs.Count = 0 then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W033_ERR_DATASET_NON_DEFINITO));
    for i:=0 to (W033DM.cdsLista.FieldDefs.Count - 1) do
    begin
      Campo:=W033DM.cdsLista.FieldDefs[i].Name;
      if R180In(Campo, ['DATO_RAGGR','ORDINE','COGNOME','NOME','IS_VUOTA','ID_RIGA_JS']) then
        continue;
      XlsDataset.FieldDefs.Add(W033DM.cdsLista.FieldDefs[i].Name, ftString, 200);
    end;
    XlsDataset.CreateDataSet;

    try
      //Ciclo per titolo colonne e dati
      W033DM.cdsLista.First;
      while not W033DM.cdsLista.Eof do
      begin
        XlsDataset.Append;
        Progressivo:=W033DM.cdsLista.FieldByName('PROGRESSIVO').AsInteger;
        for i:=0 to XlsDataset.FieldDefs.Count -1 do
        begin
          Campo:=XlsDataset.FieldDefs[i].Name;
          if R180In(Campo, ['PROGRESSIVO', 'NOMINATIVO']) then
          begin
            Titolo:=Uppercase(Copy(Campo,1,1))+Lowercase(Copy(Campo,2,Length(Campo)));
            Valore:=Trim(W033DM.cdsLista.FieldByName(Campo).AsString (*.Replace(''#$D#$A'',' ')*));
          end
          else
          begin
            try
              Data:=EncodeDate(StrToInt(Copy(Campo,1,4)),StrToInt(Copy(Campo,5,2)),StrToInt(Copy(Campo,7,2)));
              Titolo:=GetData(Data);
              Valore:='';
              if W033DM.cdsListaAss.Locate('PROGRESSIVO;DATA',VarArrayOf([Progressivo,Data]),[]) then
                repeat
                  Causale:=W033DM.cdsListaAss.FieldByName('CAUSALE').AsString;
                  if Causale <> '' then
                  begin
                    DCausale:=VarToStr(WR000DM.selT265.Lookup('CODICE',Causale,'DESCRIZIONE'));
                    if DCausale = '' then
                      DCausale:=VarToStr(WR000DM.selT275.Lookup('CODICE',Causale,'DESCRIZIONE'));
                  end
                  else
                  begin
                    Causale:=W033DM.cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString;
                    DCausale:='';
                  end;
                  DFruizione:=Trim(W033DM.cdsListaAss.FieldByName('D_FRUIZIONE').AsString);
                  Causale:=IfThen((Causale = '') and (DFruizione <> ''), 'Assenza', Trim(Causale));
                  DCausale:=Trim(DCausale);
                  Valore:=IfThen(Valore <> '', Valore + CRLF (*'; '*));
                  Valore:=Valore + Causale + IfThen(DCausale <> '', ' ') + DCausale + ' [' + DFruizione + ']';
                  W033DM.cdsListaAss.Next;
                until W033DM.cdsListaAss.Eof
                or (W033DM.cdsListaAss.FieldByName('PROGRESSIVO').AsInteger <> Progressivo)
                or (W033DM.cdsListaAss.FieldByName('DATA').AsDateTime <> Data);
            except
              Titolo:='! Err' + Campo;
              Valore:='Errore';
            end;
          end;

          XlsDataset.FieldByName(Campo).AsString:=Valore;
          if W033DM.cdsLista.Bof then
            ListaColonne.Add(TPair<String,String>.Create(Campo, Titolo));
        end;
        XlsDataset.Post;
        W033DM.cdsLista.Next;
      end;

      Result:=R180DatasetToXlsx(SessioneOracle, True, XlsDataset, ListaColonne, False);
    except
      on E:Exception do
      begin
        raise Exception.Create(E.Message + ' ' + Campo + ' ' + Valore + ' ' + i.ToString);
      end;
    end;
  finally
    FreeAndNil(XlsDataset);
  end;
end;

procedure TW033FProspettoAssenze.GetDatiTabellaProspettoJSON(JSONInput:TJSONValue; var JSONOutput:TJSONObject);
const
  MinCharGiorni = 3;
  MinCharMesi   = 5;
  MinCharAnni   = 8;
var
  Colonna:TColonna;
  i,c,Progressivo,NumRiga,NumRighePag,NumPagAttuale,MaxNumCharTestoCella:Integer;
  AltezzaCellaEM:Double;
  FieldDef:TFieldDef;
  DatiTabellaJSON:TJSONObject;
  DefinizColonneJSON,RigheJSON:TJSONArray;
  ColonnaJSON,RigaJSON,ClassiCelleTabellaJSON,ClassiCelleRigaJSON,TooltipCelleTabellaJSON,TooltipCelleRigaJSON,
  MapNumPaginaRaggrupJSON:TJSONObject;
  Success,MezzaGiornata,IsFirefox,NomeSuDueRighe:Boolean;
  Data:TDateTime;
  Timbrature,Causale,DCausale,Selezionato,Definitivo,Fruizione,DFruizione,Causali,
  TooltipCella,BackgroundColor,Spazi,Testo,NomeColonna,HTMLCella,HTMLSfondo,HTMLCausali,DescRaggrPaginaAttuale,
  Note,TestoMezzaGiornata,TestoCausale,ClassiCella:String;

  function GetData(const D:TDateTime):String;
  begin
    Result:=Copy(FormatDateTime('dddd',D),1,2) + '<br>';
    if R180Anno(Dal) = R180Anno(Al) then
    begin
      if R180Mese(Dal) = R180Mese(Al) then
        Result:=Result + FormatDateTime('dd',D)
      else
        Result:=Result + FormatDateTime('dd/mm',D);
    end
    else
      Result:=Result + FormatDateTime('dd/mm/yy',D);
  end;
begin
  DefinizColonneJSON:=TJSONArray.Create;
  DatiTabellaJSON:=TJSONObject.Create;
  RigheJSON:=TJSONArray.Create;
  ClassiCelleTabellaJSON:=TJSONObject.Create;
  ClassiCelleRigaJSON:=nil;
  TooltipCelleTabellaJSON:=TJSONObject.Create;
  TooltipCelleRigaJSON:=nil;
  ColonnaJSON:=nil;
  RigaJSON:=nil;
  NumRighePag:=Self.GetRighePaginaTabella;
  MapNumPaginaRaggrupJSON:=nil;
  Success:=False;
  IsFirefox:=(GetBrowser is TFirefox);
  NomeSuDueRighe:=cgpParametriOpzionali.IsChecked[3];
  try
    try
      if W033DM.cdsLista.RecordCount = 0 then
      begin
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXWarning(JSONOutput, nil, [A000TraduzioneStringhe(A000MSG_W033_MSG_NESSUN_DATO)]);
        Exit;
      end;
      if W033DM.cdsLista.FieldDefs.Count = 0 then
        raise Exception.Create(A000TraduzioneStringhe(A000MSG_W033_ERR_DATASET_NON_DEFINITO));
      W033DM.cdsLista.First;

      // Utilizzato solo su Firefox
      if not NomeSuDueRighe then
        AltezzaCellaEM:=NRigheCausali + 0.2
      else
        AltezzaCellaEM:=IfThen(NRigheCausali < 2,2,NRigheCausali) + 0.2;

      if RaggruppamentoCorrente <> '' then
        MapNumPaginaRaggrupJSON:=TJSONObject.Create;

      NumRiga:=0;
      // Lunghezza massima in CARATTERI
      if R180Anno(Dal) = R180Anno(Al) then
      begin
        if R180Mese(Dal) = R180Mese(Al) then
          MaxNumCharTestoCella:=MinCharGiorni
        else
          MaxNumCharTestoCella:=MinCharMesi;
      end
      else
        MaxNumCharTestoCella:=MinCharAnni;
      // Ogni riga di cdsLista è un dipendente, quindi una riga della tabella
      while not W033DM.cdsLista.Eof do
      begin
        RigaJSON:=TJSONObject.Create;
        ClassiCelleRigaJSON:=TJSONObject.Create;
        TooltipCelleRigaJSON:=TJSONObject.Create;
        for i:=0 to (W033DM.cdsLista.FieldDefs.Count - 1) do
        begin
          FieldDef:=W033DM.cdsLista.FieldDefs[i];
          NomeColonna:=FieldDef.Name;
          ClassiCella:='';
          HTMLCella:='';
          if R180In(FieldDef.Name, ['DATO_RAGGR','ORDINE','COGNOME','NOME','IS_VUOTA']) then
            continue
          else if FieldDef.Name = 'PROGRESSIVO' then
            RigaJSON.AddPair(FieldDef.Name,TJSONNumber.Create(W033DM.cdsLista.FieldByName(FieldDef.Name).AsInteger))
          else if (FieldDef.Name = 'NOMINATIVO') then
          begin
             if IsFirefox then
              HTMLCella:='<div style="height:' + FloatToStr(AltezzaCellaEM,MyFormatSettings) + 'em;">'
            else
              HTMLCella:='<div style="height:100%;">';
            HTMLCella:=HTMLCella + C190ConvertiSimboliHtml(W033DM.cdsLista.FieldByName(FieldDef.Name).AsString) + '</div>';
            RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair(FieldDef.Name,HTMLCella));
            if not W033DM.cdsLista.FieldByName('IS_VUOTA').AsBoolean then
              ClassiCella:='ui-state-default' // Stile cella di intestazione
            else
              ClassiCella:='cella_riga_vuota';
          end
          else if (FieldDef.Name = 'ID_RIGA_JS') or (FieldDef.Name = 'DATO_RAGGR') then
            RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair(FieldDef.Name,C190ConvertiSimboliHtml(W033DM.cdsLista.FieldByName(FieldDef.Name).AsString)))
          else
          begin
             // Il nome del campo è la data nel formato yyyyddmm
            Data:=EncodeDate(StrToInt(Copy(FieldDef.Name,1,4)),StrToInt(Copy(FieldDef.Name,5,2)),StrToInt(Copy(FieldDef.Name,7,2)));
            Progressivo:=W033DM.cdsLista.FieldByName('PROGRESSIVO').AsInteger;
            NomeColonna:='GG' + FieldDef.Name; // Evita ambiguità lato JS
            TooltipCella:='';
            Testo:='';
            Spazi:='';
            HTMLCausali:='';
            HTMLSfondo:='';
            if (not W033DM.cdsLista.FieldByName('IS_VUOTA').AsBoolean) and (W033DM.cdsListaTimb.Locate('PROGRESSIVO;DATA',VarArrayOf([Progressivo,Data]),[])) then
            begin
              { Procedo a valorizzare il contenuto della cella se: la riga non è fittizia (creata ad hoc per il raggruppamento) E
                sono state effettuate le selezioni estrarre le causali (potrebbe comunque essere vuota anche in questi casi) }
              Timbrature:=W033DM.cdsListaTimb.FieldByName('TIMBRATURE').AsString;
              if W033DM.cdsListaTimb.FieldByName('LAVORATIVO').AsString = 'N' then
                ClassiCella:='bg_nonlavorativo';
              //Fascia verde per presenza timbrature
              if Timbrature = 'S' then
                HTMLSfondo:='<span style="position:absolute; left:95%; top:0px; width:5%; height:100%; z-index:7; background-color:#00FF00;">&nbsp;</span>';
              //Azzero le variabili delle assenze
              Causale:='';
              DCausale:='';
              Selezionato:='';
              Definitivo:='';
              Fruizione:='';
              DFruizione:='';
              Causali:='';
              MezzaGiornata:=False;
              Note:='';
              //Ciclo sulle assenze del giorno del dipendente
              if W033DM.cdsListaAss.Locate('PROGRESSIVO;DATA',VarArrayOf([Progressivo,Data]),[]) then
                repeat
                  Causale:=W033DM.cdsListaAss.FieldByName('CAUSALE').AsString;
                  if Causale <> '' then
                  begin
                    // chiamata <71723>.ini
                    DCausale:=VarToStr(WR000DM.selT265.Lookup('CODICE',Causale,'DESCRIZIONE'));
                    if DCausale = '' then
                      DCausale:=VarToStr(WR000DM.selT275.Lookup('CODICE',Causale,'DESCRIZIONE'));
                    // chiamata <71723>.fine
                  end
                  else
                  begin
                    Causale:=W033DM.cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString;
                    DCausale:='';
                  end;
                  Selezionato:=W033DM.cdsListaAss.FieldByName('SELEZIONATO').AsString;
                  Definitivo:=W033DM.cdsListaAss.FieldByName('DEFINITIVO').AsString;
                  Fruizione:=W033DM.cdsListaAss.FieldByName('FRUIZIONE').AsString;
                  DFruizione:=W033DM.cdsListaAss.FieldByName('D_FRUIZIONE').AsString;
                  Note:=W033DM.cdsListaAss.FieldByName('NOTE').AsString; // Valorizzate soLo se C31_NoteGiustificativi = 'S'
                  TestoCausale:='';
                  TestoMezzaGiornata:='';
                  if Causale <> '' then
                  begin
                    TestoCausale:=Causale;
                    { In caso di mezze giornate l'utente può specificare se si tratta di mattino o pomeriggio (di solito
                      usano AM, A.M. o simili per mattino e PM, P.M. o simili per pomeriggio) }
                    if (Fruizione = 'M') and (Trim(Note) <> '') then
                      TestoMezzaGiornata:='(' + Uppercase(Note) + ')';
                    if AutorizzazioneRichieste then
                    begin
                      if W033DM.cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsInteger > 0 then
                      begin
                        HTMLCausali:=HTMLCausali + '<div><a href="javascript:void(0);"';
                        // (*)
                        {if W033DM.cdsListaAss.FieldByName('TIPO_RICHIESTA').AsString = 'C' then
                          HTMLCausali:=HTMLCausali + ' style="font-weight: bold;"';}
                        HTMLCausali:=HTMLCausali + ' onclick="causaleAut(''' + W033DM.cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsString + ''');">' + C190ConvertiSimboliHTML(TestoCausale + TestoMezzaGiornata) + '</a></div>';
                      end
                      else
                        HTMLCausali:=HTMLCausali + '<div>' + C190ConvertiSimboliHTML(TestoCausale + TestoMezzaGiornata) + '</div>';
                    end
                    else
                      HTMLCausali:=HTMLCausali + '<div>' + C190ConvertiSimboliHTML(TestoCausale + TestoMezzaGiornata) + '</div>';
                    MaxNumCharTestoCella:=Max(MaxNumCharTestoCella,Length(TestoCausale + TestoMezzaGiornata));
                    TooltipCella:=TooltipCella + Causale + IfThen(Trim(DCausale) <> '',' ') + C190ConvertiSimboliHTML(DCausale + ': ' + DFruizione) + IfThen(TestoMezzaGiornata <> '', ' ' + TestoMezzaGiornata,'') + '<br>';
                  end;
                  BackgroundColor:='transparent';
                  if Selezionato = 'N' then
                    BackgroundColor:=IfThen(W033DM.cdsListaAss.FieldByName('SIGLA_CAUSALE').AsString <> '','#FF0000','#B1B1B1')  //Rosso se esiste sigla, Grigio se nulla
                  else if W033DM.cdsListaAss.FieldByName('TIPO_RICHIESTA').AsString <> 'C' then
                    BackgroundColor:=IfThen(Definitivo = 'N','#FFAAAA','#FF0000')  //Richieste di cancellazione o autorizzazione inserimento
                  else if W033DM.cdsListaAss.FieldByName('ID_AUTORIZZABILE').AsInteger > 0 then
                    BackgroundColor:='#F5DEB3';//Autorizzazione alla cancellazione
                  //Creo gli span colorati, sovrapponendo gli strati di visualizzazione
                  HTMLSfondo:=HTMLSfondo + Format('<span style="position:absolute; left:%s; top:0px; width:%s; height:100%%; z-index:%s; background-color:%s;">&nbsp;</span>',
                                                   //Left: più di una fruizione a mezza giornata: 50%
                                                         //presenza timbrature: 95% (vedi sopra)
                                                         //altri casi: 0px
                                                  [IfThen((Fruizione = 'M') and MezzaGiornata,'50%','0px'),
                                                   //Width: fruizione a giornata intera: 100%
                                                          //fruizione a mezza giornata: 50%
                                                          //fruizione ad ore: 25%
                                                          //presenza timbrature: 5% (vedi sopra)
                                                          //testo (causali): 100% (vedi sotto)
                                                   IfThen(Fruizione = 'I','100%',IfThen(Fruizione = 'M','50%','25%')),
                                                   //Strato: assenza generica a giornata: 0
                                                           //assenza a giornata intera sul cartellino: 1
                                                           //assenza richiesta a giornata intera: 2
                                                           //assenza a mezza giornata sul cartellino: 3
                                                           //assenza richiesta a mezza giornata: 4
                                                           //assenza ad ore sul cartellino: 5
                                                           //assenza richiesta ad ore: 6
                                                           //presenza timbrature: 7 (vedi sopra)
                                                           //testo (causali): 8 (vedi sotto)
                                                   IfThen(Selezionato = 'N','0',
                                                                            IfThen(Fruizione = 'I',IfThen(Definitivo = 'N','2','1'),
                                                                                                   IfThen(Fruizione = 'M',IfThen(Definitivo = 'N','4','3'),
                                                                                                                          IfThen(Definitivo = 'N','6','5')))),
                                                   //Colore: assenza generica a giornata: grigio
                                                           //assenza sul cartellino: rosso
                                                           //assenza richiesta: rosa
                                                           //presenza timbrature: lime (vedi sopra)
                                                           //testo (causali): trasparente (vedi sotto)
                                                   //IfThen(Selezionato = 'N','#B1B1B1',IfThen(Definitivo = 'N','#FFAAAA','#FF0000'))]);
                                                   BackgroundColor]);
                  MezzaGiornata:=Fruizione = 'M';
                  W033DM.cdsListaAss.Next;
                until W033DM.cdsListaAss.Eof
                or (W033DM.cdsListaAss.FieldByName('PROGRESSIVO').AsInteger <> Progressivo)
                or (W033DM.cdsListaAss.FieldByName('DATA').AsDateTime <> Data);
            end
            else if W033DM.cdsLista.FieldByName('IS_VUOTA').AsBoolean then   // Non abbiamo elaborato il contenuto perchè la riga era intenzionalmente vuota
              ClassiCella:='cella_riga_vuota';
            //Testo con le causali fruite
            if HTMLCausali <> '' then
              HTMLCausali:='<div style="position:absolute; left:0px; top:0px; width:100%; height:100%; z-index:8; background-color:transparent; padding-left:2px; font-size: 12px;">' + HTMLCausali +'</div>';
            if IsFirefox then
              HTMLCella:='<div style="position:relative; height:' + FloatToStr(AltezzaCellaEM,MyFormatSettings) + 'em;">'
            else
              HTMLCella:='<div style="position:relative; height:100%;">';
            for c:=1 to NRigheCausali do
              HTMLCella:=HTMLCella + '<br>';
            HTMLCella:=HTMLCella + HTMLSfondo + HTMLCausali + '</div>';
            RigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair(NomeColonna,HTMLCella));
            if TooltipCella <> '' then
              TooltipCelleRigaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair(NomeColonna,TooltipCella));
            end;
          if ClassiCella <> '' then
            ClassiCelleRigaJSON.AddPair(NomeColonna, ClassiCella);
        end;

        ClassiCelleTabellaJSON.AddPair(W033DM.cdsLista.FieldByName('ID_RIGA_JS').AsString,ClassiCelleRigaJSON);
        ClassiCelleRigaJSON:=nil;
        TooltipCelleTabellaJSON.AddPair(W033DM.cdsLista.FieldByName('ID_RIGA_JS').AsString,TooltipCelleRigaJSON);
        TooltipCelleRigaJSON:=nil;
        if (RaggruppamentoCorrente <> '') and (NumRiga mod NumRighePag = 0) then // Se è il primo elemento della pagina
        begin
          NumPagAttuale:=NumRiga div NumRighePag + 1;
          DescRaggrPaginaAttuale:=RaggruppamentoCorrente + ': ' + IfThen(W033DM.cdsLista.FieldByName('DATO_RAGGR').AsString = '',A000TraduzioneStringhe('vuoto'),W033DM.cdsLista.FieldByName('DATO_RAGGR').AsString);
          MapNumPaginaRaggrupJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('_' + IntToStr(NumPagAttuale),C190ConvertiSimboliHtml(DescRaggrPaginaAttuale)));
        end;
        Inc(NumRiga);
        RigheJSON.Add(RigaJSON);
        RigaJSON:=nil;
        W033DM.cdsLista.Next;
      end;

      // Compongo la definizione delle colonne
      for i:=0 to (W033DM.cdsLista.FieldDefs.Count - 1) do
      begin
        FieldDef:=W033DM.cdsLista.FieldDefs[i];
        if not R180In(FieldDef.Name,['DATO_RAGGR','ORDINE','COGNOME','NOME','IS_VUOTA']) then
        begin
          Colonna:=TColonna.Create;
          if FieldDef.Name = 'PROGRESSIVO' then
          begin
            Colonna.Name:=FieldDef.Name;
            Colonna.Hidden:=True;
            Colonna.Frozen:=True;
          end
          else if FieldDef.Name = 'NOMINATIVO' then
          begin
            Colonna.Name:=FieldDef.Name;
            Colonna.TitleLabel:=A000TraduzioneStringhe(A000MSG_W033_MSG_LBL_NOMINATIVO);
            Colonna.Width:=200;
            Colonna.Frozen:=True;
          end
          else if FieldDef.Name = 'ID_RIGA_JS' then
          begin
            Colonna.Name:=FieldDef.Name;
            Colonna.Key:=True;
            Colonna.Hidden:=True;
            Colonna.Frozen:=True;
          end
          else if FieldDef.Name = 'DATO_RAGGR' then
          begin
            Colonna.Name:=FieldDef.Name;
            COlonna.TitleLabel:='RAGGR';
            Colonna.Width:=60;
            Colonna.Frozen:=True;
          end
          else
          begin
            { Su cdsLista il nome del campo è la data in formato yyyymmdd. Lato JS aggiungo il prefisso 'GG' per evitare ambiguità
             (stringa che contiene numero, per es. la funzione isNaN() ritorna false sia che sia un vero numero sia che sia una
             stringa che contiene un numero. Dà problemi con jqGrid.) }
            Colonna.Name:='GG' + FieldDef.Name;
            Data:=EncodeDate(StrToInt(Copy(FieldDef.Name,1,4)),StrToInt(Copy(FieldDef.Name,5,2)),StrToInt(Copy(FieldDef.Name,7,2)));
            Colonna.TitleLabel:=GetData(Data);
            Colonna.Width:=MaxNumCharTestoCella * 8;
            if DayOfWeek(Data) = 1 then
              Colonna.ClassiHeader:='font_rosso';
          end;
          ColonnaJSON:=TJSONObject.Create;
          ColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('name', Colonna.Name));
          ColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('label',Colonna.TitleLabel));
          if Colonna.Key then
            ColonnaJSON.AddPair('key', TJSONTrue.Create);
          ColonnaJSON.AddPair('width', TJSONNumber.Create(Colonna.Width));
          ColonnaJSON.AddPair('frozen', TGestoreChiamataAJAX.CreaJSONBoolean(Colonna.Frozen));
          ColonnaJSON.AddPair('hidden', TGestoreChiamataAJAX.CreaJSONBoolean(Colonna.Hidden));
          ColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('medpClasseHeader',Colonna.ClassiHeader));
          ColonnaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('classes', Colonna.Classes));
          ColonnaJSON.AddPair('title', TGestoreChiamataAJAX.CreaJSONBoolean(false));
          DefinizColonneJSON.Add(ColonnaJSON);

          ColonnaJSON:=nil;
          FreeAndNil(Colonna);
          Colonna:=nil;
        end;
      end;
      DatiTabellaJSON.AddPair(TGestoreChiamataAJAX.CreaJSONPair('caption',A000TraduzioneStringhe(A000MSG_W033_MSG_LBL_CAPTION_GRID) + ' ' + C190ConvertiSimboliHtml(C190PeriodoStr(Dal,Al))));
      DatiTabellaJSON.AddPair('colonne',DefinizColonneJSON);
      DefinizColonneJSON:=nil;
      DatiTabellaJSON.AddPair('righe',RigheJSON);
      RigheJSON:=nil;
      DatiTabellaJSON.AddPair('classiCelle',ClassiCelleTabellaJSON);
      ClassiCelleTabellaJSON:=nil;
      DatiTabellaJSON.AddPair('datiTooltip',TooltipCelleTabellaJSON);
      TooltipCelleTabellaJSON:=nil;
      if RaggruppamentoCorrente <> '' then
      begin
        DatiTabellaJSON.AddPair('mappaPaginaDatiRaggr',MapNumPaginaRaggrupJSON);
        MapNumPaginaRaggrupJSON:=nil;
      end
      else
        DatiTabellaJSON.AddPair('mappaPaginaDatiRaggr',TJSONNull.Create);
      TGestoreChiamataAJAX.ValorizzaRispostaAJAXSuccess(JSONOutput,DatiTabellaJSON);
      Success:=True;
    except
      on E:Exception do
      begin
        try FreeAndNil(JSONOutput); except end;
        JSONOutput:=TJSONObject.Create;
        TGestoreChiamataAJAX.ValorizzaRispostaAJAXError(JSONOutput,[A000TraduzioneStringhe(A000MSG_W033_ERR_ERRORE_PROSPETTO) + ': ' + E.Message]);
      end;
    end;
  finally
    if not Success then
    begin
      // Disalloco le variabili istanziate non utilizzate
      if RigaJSON <> nil then
        try FreeAndNil(RigaJSON); except end;
      if RigheJSON <> nil then
        try FreeAndNil(RigheJSON); except end;
      if ClassiCelleRigaJSON <> nil then
        try FreeAndNil(ClassiCelleRigaJSON); except end;
      if TooltipCelleRigaJSON <> nil then
        try FreeAndNil(TooltipCelleRigaJSON); except end;
      if MapNumPaginaRaggrupJSON <> nil then
        try FreeAndNil(MapNumPaginaRaggrupJSON); except end;
      if ClassiCelleTabellaJSON <> nil then
        try FreeAndNil(ClassiCelleTabellaJSON); except end;
      if TooltipCelleTabellaJSON <> nil then
        try FreeAndNil(TooltipCelleTabellaJSON); except end;
      if Colonna <> nil then
        try FreeAndNil(Colonna); except end;
      if ColonnaJSON <> nil then
        try FreeAndNil(ColonnaJSON); except end;
      if DefinizColonneJSON <> nil then
        try FreeAndNil(DefinizColonneJSON); except end;
      try FreeAndNil(DatiTabellaJSON); except end;
    end;
  end;
end;

procedure TW033FProspettoAssenze.imgDeselezionaTuttoGiustificativiClick(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
    cgpGiustificativi.IsChecked[i]:=False;
  cgpGiustificativi.AsyncUpdate;
end;

procedure TW033FProspettoAssenze.imgInvertiSelezioneGiustificativiClick(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
    cgpGiustificativi.IsChecked[i]:=not cgpGiustificativi.IsChecked[i];
  cgpGiustificativi.AsyncUpdate;
end;

procedure TW033FProspettoAssenze.imgSelezionaTuttoGiustificativiClick(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
    cgpGiustificativi.IsChecked[i]:=True;
  cgpGiustificativi.AsyncUpdate;
end;

procedure TW033FProspettoAssenze.btnEseguiClick(Sender: TObject);
var PeriodoCambiato:Boolean;
    i:Integer;
    Caus: String;
begin
  //Tipologie
  ElencoTipi:='';
  for i:=0 to cgpTipologie.Items.Count - 1 do
    if cgpTipologie.IsChecked[i] then
      ElencoTipi:=ElencoTipi + '''' + IfThen(i = 0,'I',IfThen(i = 1,'M',IfThen(i = 2,'N','D'))) + ''',';
  ElencoTipi:=Copy(ElencoTipi,1,Length(ElencoTipi)-1);
  //Giustificativi
  ElencoGiust:='';
  for i:=0 to cgpGiustificativi.Items.Count - 1 do
  begin
    if cgpGiustificativi.IsChecked[i] then
    begin
      Caus:=Copy(cgpGiustificativi.Items[i],1,Pos(' ',cgpGiustificativi.Items[i]) - 1);
      ElencoGiust:=ElencoGiust + '''' + Caus + ''',';
    end;
  end;
  ElencoGiust:=Copy(ElencoGiust,1,Length(ElencoGiust) - 1);
  //Salvo i parametri di esecuzione
  PutParametriFunzione;
  //Se tutte le causali sono deselezionate, allora le considero tutte
  if ElencoGiust = '' then
  begin
    for i:=0 to cgpGiustificativi.Items.Count - 1 do
    begin
      Caus:=Copy(cgpGiustificativi.Items[i],1,Pos(' ',cgpGiustificativi.Items[i]) - 1);
      ElencoGiust:=ElencoGiust + '''' + Caus + ''',';
    end;
  end;
  //Periodo
  try
    PeriodoCambiato:=(Dal <> StrToDate(edtPeriodoDal.Text)) or (Al <> StrToDate(edtPeriodoAl.Text));
    Dal:=StrToDate(edtPeriodoDal.Text);
    Al:=StrToDate(edtPeriodoAl.Text);
    if Al < Dal then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
    if Al > R180AddMesi(Dal,12) then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_W033_MSG_PERIODO_MINORE_DI_12));
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      exit;
    end;
  end;
  if PeriodoCambiato then
  begin
    ParametriForm.Dal:=Dal;
    ParametriForm.Al:=Al;
  end;
  FiltroDip:=selAnagrafeW.SubstitutedSql;
  ElaboraProspetto;
  if Sender <> nil then
    tabProspettoAssenze.ActiveTab:=W033ProspettoRG;
end;

procedure TW033FProspettoAssenze.RefreshPage;
begin
  WR000DM.Responsabile:=AutorizzazioneRichieste;

  // se il tab attivo è quello del prospetto, lo aggiorna
  //VisualizzaGriglia;
  if tabProspettoAssenze.ActiveTab = W033ProspettoRG then
    btnEseguiClick(nil);
end;

procedure TW033FProspettoAssenze.DistruggiOggetti;
begin
  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
    R180CloseDataSetTag0(WR000DM.selT275);
  end;
  FreeAndNil(C004FParamFormPrv);
  FreeAndNil(W033DM);
  {// empoli - commessa 2012/102.ini (*)
  FreeAndNil(W010DM);
  FreeAndNil(C018Canc);
  // empoli - commessa 2012/102.fine}
end;

end.
