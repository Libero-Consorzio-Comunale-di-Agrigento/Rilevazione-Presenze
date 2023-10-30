unit WA023UTimbrature;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,OracleData,
  Dialogs, WR104UGestCartellino, IWBaseComponent, IWBaseHTMLComponent, IWApplication,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, medpIWC700NavigatorBar, C180FunzioniGenerali, C190FunzioniGeneraliWeb, IWCompEdit, meIWEdit,
  IWCompLabel, meIWLabel, StrUtils, WA023UTimbratureDM, A000UInterfaccia, A000UMessaggi,
  medpIWMessageDlg, R500Lin, A023UTimbratureMW,IW.Browser.InternetExplorer,
  Menus,WA023UGestTimbFM, WA023UGestGiustFM, IWCompMemo, meIWMemo, meIWImageFile, A000USessione,
  IWCompJQueryWidget, ActnList, A000UCostanti,  WC021URiepilogoAssenzeFM,
  medpIWImageButton, WA023URipristinoTimbOrigFM, WC020UInputDataOreFM,
  WA023UValidaAssenzeFM, WA023UAllTimbUgualiFM, System.Actions,
  WC027UInfoDatiFM, WR100UBase, FunzioniGenerali,
  WC028URichiesteInCorsoFM;

type

  TRichiesta = (irTimbrature,irGiugstificativi);

  TWA023FTimbrature = class(TWR104FGestCartellino)
    mnuModificaTimb: TMenuItem;
    mnuInserisciTimb: TMenuItem;
    mnuCancellaTimb: TMenuItem;
    mnuInserisciTimb2: TMenuItem;
    mnuInserisciGiust: TMenuItem;
    mnuModificaGiust: TMenuItem;
    mnuInserisciGiustif2: TMenuItem;
    JQuery: TIWJQueryWidget;
    mnuValidaAssenze: TMenuItem;
    mnuAggiornaDataControllo: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    mnuAggiornadatacontrollo2: TMenuItem;
    lblDataControllo: TmeIWLabel;
    mnuAggiornaDataControllo3: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    mnuAggiornaDataControllo4: TMenuItem;
    grdCorrezione: TmeIWGrid;
    imgAnomaliaPrecedente: TmeIWImageFile;
    imgAvvioCorrezione: TmeIWImageFile;
    lblAnomalia: TmeIWLabel;
    imgAnomaliaSuccessiva: TmeIWImageFile;
    imgCorreggiAnomalia: TmeIWImageFile;
    actCompetenzeResidui: TMenuItem;
    mnuRipristino: TMenuItem;
    mnuRipristino2: TMenuItem;
    N5: TMenuItem;
    mnuAllineamentoTimbratureUguali: TMenuItem;
    N6: TMenuItem;
    mnuAllineamentoTimbratureUguali2: TMenuItem;
    mnuEliminazionetimbratureriscaricate: TMenuItem;
    mnuEliminazionetimbratureriscaricate2: TMenuItem;
    mnuAccediGiust: TMenuItem;
    actConteggiServizio: TMenuItem;
    actConteggiServizio1: TMenuItem;
    actConteggiServizio2: TMenuItem;
    actConteggiServizio3: TMenuItem;
    actReset: TAction;
    actStampaCartellino: TAction;
    actCorrezione: TAction;
    actElaboraOmesseTimbrature: TAction;
    actArchiviazioneCartellini: TAction;
    Inforichiesta1: TMenuItem;
    Inforichiesta2: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure mnuModificaTimbClick(Sender: TObject);
    procedure mnuCancellaTimbClick(Sender: TObject);
    procedure mnuModificaGiustClick(Sender: TObject);
    procedure mnuInserisciGiustClick(Sender: TObject);
    procedure mnuValidaAssenzeClick(Sender: TObject);
    procedure mnuAggiornaDataControlloAsyncClick(Sender: TObject);
    procedure imgAnomaliaPrecedenteAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgAvvioCorrezioneAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgAnomaliaSuccessivaAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgCorreggiAnomaliaClick(Sender: TObject);
    procedure actCompetenzeResiduiClick(Sender: TObject);
    procedure mnuRipristinoClick(Sender: TObject);
    procedure mnuAllineamentoTimbratureUgualiClick(Sender: TObject);
    procedure mnuEliminazionetimbratureriscaricateClick(Sender: TObject);
    procedure mnuAccediGiustClick(Sender: TObject);
    procedure actConteggiServizioClick(Sender: TObject);
    procedure actResetExecute(Sender: TObject);
    procedure actStampaCartellinoExecute(Sender: TObject);
    procedure actCorrezioneExecute(Sender: TObject);
    procedure actElaboraOmesseTimbratureExecute(Sender: TObject);
    procedure mnuInserisciTimbClick(Sender: TObject);
    procedure actArchiviazioneCartelliniExecute(Sender: TObject);
    procedure Inforichiesta1Click(Sender: TObject);
    procedure Inforichiesta2Click(Sender: TObject);
  private
    //correzione anomalie - ini
    TotAnom, AnomCorr:Integer;
    Prog,Livello:Integer;
    DataAnomalia:TDateTime;
    Anomalia:String;
    SB,SN:String;
    WA023FValidaAssenzeFM: TWA023FValidaAssenzeFM;
    //correzione anomalie - fine
    procedure ImpostaDaCalendario(Data: TDateTime; Progressivo, i: Integer);
    procedure ResultCancellaTimbratura(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    function ConteggiGiorno(Giorno: TDateTime): TConteggiGiorno;
    procedure giornoLinkClick(Sender: TObject);
    procedure orarioLinkClick(Sender: TObject);
    procedure VisualizzaDataControllo(Data: TDateTime);
    procedure AggiornaToolbarCorrezione;
    procedure CorrezioneInizio;
    procedure ScorriQuery(Avanti: Boolean);
    procedure Fine;
    procedure DeleteRecord;
    procedure VisualizzaRiepilogo;
    procedure ResultRipristinoTimbrature(Sender: TObject; Result: Boolean);
    procedure ResultAllineaTimbrature(Sender: TObject; Result: Boolean);
    procedure ResultEliminaTimbratureDoppie(Sender: TObject; Result: Boolean;
      Valore: String);
    procedure ResultCloseFrame(Sender: TObject; Result: Boolean);
    procedure WA023FValidaAssenzaFM_btnChiudiClick(Sender: TObject);
    procedure InformazioniRichiesta(TipoInfoRichiesta:TRichiesta);
    procedure imgRichiesteInCorsoClick(Sender: TObject);
  protected
    procedure RefreshPage; override;
    procedure AttivaConteggi; override;
    procedure ApriGestTimb(Modifica: Boolean); override;
    procedure ApriGestGiust(Modifica: Boolean); override;
  public
    WA023FTimbratureDM: TWA023FTimbratureDM;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    function InizializzaAccesso: Boolean; override;
    procedure CaricaCartellino; override;
    procedure CaricaGrid; override;
    function getTimbratura(day,i:Integer):TTimbrature; override;
    function getNumeroTimbrature(day:Integer):Byte; override;
    function getGustificativo(day,i:Integer):TGiustificativi;override;
    function getNumeroGiustificativi(day:Integer):Byte ;override;
  end;

implementation

{$R *.dfm}

procedure TWA023FTimbrature.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.ImpostaProgressivoCorrente:=True;
  AttivaGestioneC700;
  WA023FTimbratureDM:=TWA023FTimbratureDM.Create(Self);
  WA023FTimbratureDM.A023FTimbratureMW.SelAnagrafe:=grdC700.selAnagrafe;
  //devo settare Q031
  WA023FTimbratureDM.A023FTimbratureMW.ImpostaQ031;
  //crea toolbar correzione
  grdCorrezione.RowCount:=1;
  grdCorrezione.ColumnCount:=5;
  grdCorrezione.Cell[0,0].Control:=imgAvvioCorrezione;
  grdCorrezione.Cell[0,1].Control:=imgAnomaliaPrecedente;
  grdCorrezione.Cell[0,2].Control:=imgAnomaliaSuccessiva;
  grdCorrezione.Cell[0,3].Control:=imgCorreggiAnomalia;
  grdCorrezione.Cell[0,4].Control:=lblAnomalia;
  grdCorrezione.Visible:=False;
  VisualizzaDataControllo(0);
  //Imposta variabili wr104 per caricagrid e frame gest timb
  with WA023FTimbratureDM.A023FTimbratureMW do
  begin
    QRilevatori:=Q361;
    QCausAss:=Q265;
    QCausPres:=Q275;
    QCausGiust:=Q305;
    DsrTimbrature:=D100;
  end;
  actArchiviazioneCartellini.Visible:=A000GetInibizioni('Tag','75') = 'S';
end;

procedure TWA023FTimbrature.InformazioniRichiesta(TipoInfoRichiesta:TRichiesta);
var
  WC027: TWC027FInfoDatiFM;
begin
  WC027:=TWC027FInfoDatiFM.Create(Self);
  // in base al tipo di richiesta estraggo l'ID delle timbrature o dei giustificativi
  if TipoInfoRichiesta = TRichiesta.irTimbrature then
  begin
    WC027.MostraInfoTimb(WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[DataOperazione.Day,NumeroElemento]);
  end
  else if TipoInfoRichiesta = TRichiesta.irGiugstificativi then
  begin
    WC027.MostraInfoGiust(WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[DataOperazione.Day,NumeroElemento]);
  end;
end;

procedure TWA023FTimbrature.Inforichiesta1Click(Sender: TObject);
begin
  inherited;
  DataOperazione:=StrToDate(pmnTimbratura.PopupComponent.Tag.ToString + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(pmnTimbratura.PopupComponent.Name,NOMETIMBR);
  InformazioniRichiesta(irTimbrature);
end;

procedure TWA023FTimbrature.Inforichiesta2Click(Sender: TObject);
begin
  inherited;
  DataOperazione:=StrToDate(pmnGiustificativo.PopupComponent.Tag.ToString + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(pmnGiustificativo.PopupComponent.Name,NOMEGIUST);
  InformazioniRichiesta(irGiugstificativi);
end;

function TWA023FTimbrature.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
  LDataRifStr: String;
  LDataRif: TDateTime;
begin
  bCanNuovoGiustificativo:=((not SolaLettura) and (A000GetInibizioni('Funzione','OpenA004GiustifAssPres') = 'S'));
  //Valuta se si può inserire la nuova timbratura

  bCanNuovaTimbratura:=((not SolaLettura) and (Parametri.InserisciTimbrature = 'S'));
  bCanCancellaTimbratura:=(not SolaLettura) and ((Parametri.CancellaTimbrature = 'S') or (Parametri.T100_CancTimbOrig = 'S'));

  //Deve prendere il progressivo selezionato da parametro (passato da WA100)
  //e non il progressivo corrente della WA001
  //Se arriva da menu Progressivo non impostato e quindi posizionamento su progressivo corrente della wa001 (fatto su attivazione wc700)
  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  SetLength(Cartellino,0);

  try
    LDataRifStr:=GetParam('DATARIF');
    if LDataRifStr = '' then
      LDataRif:=0
    else
      LDataRif:=StrToDate(LDataRifStr);
  except
    LDataRif:=0;
  end;
  if LDataRif > 0 then
    DataCorr:=R180InizioMese(LDataRif)
  else
    DataCorr:=R180InizioMese(Parametri.DataLavoro);
  edtMese.Text:=FormatDateTime('mm/yyyy',DataCorr);
  CaricaCartellino;

  Result:=True;
end;

procedure TWA023FTimbrature.mnuAccediGiustClick(Sender: TObject);
var Comp: TComponent;
   Params: String;
begin
  inherited;
  Comp:=(((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TmeIWEdit);

  DataOperazione:=StrToDate(IntToStr(Comp.Tag) + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(Comp.Name,NOMEGIUST);

  with WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[Comp.Tag,NumeroElemento] do
  begin
    Params:='CODICE=' + Causale;
    //se causale di presenza apro WA020 altrimenti WA016
    if WA023FTimbratureDM.A023FTimbratureMW.Q275.Locate('Codice',Causale,[]) then
      AccediForm(107,Params,False)
    else
      AccediForm(105,Params,False);
  end;
end;

procedure TWA023FTimbrature.mnuAggiornaDataControlloAsyncClick(Sender: TObject);
var Comp: TComponent;
    Data: TDateTime;
begin
  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  Data:=StrToDate(IntToStr(Comp.Tag) + '/' + edtMese.Text);
  WA023FTimbratureDM.A023FTimbratureMW.AggDataControllo(Data);
  VisualizzaDataControllo(Data);
end;

procedure TWA023FTimbrature.mnuAllineamentoTimbratureUgualiClick(
  Sender: TObject);
var
  WA023FAllTimbUgualiFM: TWA023FAllTimbUgualiFM;
  Comp: TComponent;
begin
  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  if WA023FTimbratureDM.A023FTimbratureMW.DatoBloccato(StrToDate('01/' + edtMese.Text)) then
  begin
    MsgBox.WebMessageDlg(WA023FTimbratureDM.A023FTimbratureMW.selDatiBloccati.MessaggioLog,mtError,[mbOK],nil,'');
    Exit;
  end;

  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  DataOperazione:=StrToDate(IntToStr(Comp.Tag) + '/' + edtMese.Text);

  //Riesame del 15/10/2013 su attività WA023
  //Rendo invisibile la grid per alleggerire il render e l'aggiornamento delle grid del frame
  grdCartellino.Visible:=True;//False;

  WA023FAllTimbUgualiFM:=TWA023FAllTimbUgualiFM.Create(Self);
  WA023FAllTimbUgualiFM.CaricaDatiIniziali(DataOperazione);
  WA023FAllTimbUgualiFM.ResultEvent:=ResultAllineaTimbrature;
  WA023FAllTimbUgualiFM.Visualizza;
end;

procedure TWA023FTimbrature.ResultAllineaTimbrature(Sender: TObject; Result: Boolean);
begin
  grdCartellino.Visible:=True;
  // se è stato effettuato un allineamento aggiorna la vista
  if Result then
    CaricaCartellino;
end;

procedure TWA023FTimbrature.mnuCancellaTimbClick(Sender: TObject);
var
  Timbratura: TTimbrature;
  BloccaOperazione: boolean;
begin
  inherited;
  DataOperazione:=StrToDate(IntToStr(pmnTimbratura.PopupComponent.Tag) + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(pmnTimbratura.PopupComponent.Name,NOMETIMBR);

  Timbratura:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[R180Giorno(DataOperazione),NumeroElemento];
  BloccaOperazione:=not bCanCancellaTimbratura;

  if (Parametri.CancellaTimbrature <> 'S') and (Timbratura.Flag = 'I') then
    BloccaOperazione:=True;
  if (Parametri.T100_CancTimbOrig <> 'S') and (Timbratura.Flag = 'O') then
    BloccaOperazione:=True;
  if BloccaOperazione then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  //Chiamata: 83085
  if not A000FiltroDizionario('OROLOGI DI TIMBRATURA',Timbratura.Rilevatore) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_RILEVATORE_DIZIONARIO,mtError,[mbOK],nil,'');
    Exit;
  end;

  if not(WA023FTimbratureDM.A023FTimbratureMW.Q100.Locate('Data;Ora;Verso;Flag',VarArrayOf([DataOperazione,Timbratura.Ora,Timbratura.Verso,Timbratura.Flag]),[])) then
    Exit;

  MsgBox.WebMessageDlg(A000MSG_A023_DLG_CANC_TIMB, mtConfirmation,[mbYes,mbNo], ResultCancellaTimbratura,'');
end;

procedure TWA023FTimbrature.mnuEliminazionetimbratureriscaricateClick(
  Sender: TObject);
var WC020FInputDataOreFM: TWC020FInputDataOreFM;
    Comp: TComponent;
begin
  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  if WA023FTimbratureDM.A023FTimbratureMW.DatoBloccato(StrToDate('01/' + edtMese.Text)) then
  begin
    MsgBox.WebMessageDlg(WA023FTimbratureDM.A023FTimbratureMW.selDatiBloccati.MessaggioLog,mtError,[mbOK],nil,'');
    Exit;
  end;

  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  DataOperazione:=StrToDate(IntToStr(Comp.Tag) + '/' + edtMese.Text);

  //Riesame del 15/10/2013 su ativita WA023
  grdCartellino.Visible:=True;//False;

  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
  WC020FInputDataOreFM.ImpostaCampiPeriodo('Da: ','A: ',DataOperazione, DataOperazione, 'dd/mm/yyyy');
  WC020FInputDataOreFM.Visualizza('Eliminazione timbrature riscaricate');
  WC020FInputDataOreFM.ResultEvent:=ResultEliminaTimbratureDoppie;
end;

procedure TWA023FTimbrature.mnuInserisciGiustClick(Sender: TObject);
var Comp: TComponent;
begin
  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  DataOperazione:=StrToDate(IntToStr(Comp.Tag) + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(Comp.Name,NOMEGIUST);
  ApriGestGiust(False);
end;

procedure TWA023FTimbrature.mnuInserisciTimbClick(Sender: TObject);
var Day: Integer;
begin
  Day:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent.Tag;
  DataOperazione:=StrToDate(IntToStr(Day) + '/' + edtMese.Text);
  ApriGestTimb(False);
end;

procedure TWA023FTimbrature.mnuModificaGiustClick(Sender: TObject);
begin
  inherited;
  try
    DataOperazione:=StrToDate(IntToStr(pmnGiustificativo.PopupComponent.Tag) + '/' + edtMese.Text);
    NumeroElemento:=EstraiColonnaElemento(pmnGiustificativo.PopupComponent.Name,NOMEGIUST);
    ApriGestGiust(True);
  except
  end;
end;

procedure TWA023FTimbrature.mnuModificaTimbClick(Sender: TObject);
begin
  inherited;
  try
    DataOperazione:=StrToDate(IntToStr(pmnTimbratura.PopupComponent.Tag) + '/' + edtMese.Text);
    NumeroElemento:=EstraiColonnaElemento(pmnTimbratura.PopupComponent.Name,NOMETIMBR);
    ApriGestTimb(True);
  except
  end;
end;

procedure TWA023FTimbrature.mnuRipristinoClick(Sender: TObject);
var WA023FRipristinoTimbOrigFM: TWA023FRipristinoTimbOrigFM;
    Abilitazione: boolean;
    Comp: TComponent;
begin
  Abilitazione:=(not SolaLettura) and (Parametri.RipristinoTimbOri = 'S');

  if not Abilitazione then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  if WA023FTimbratureDM.A023FTimbratureMW.DatoBloccato(StrToDate('01/' + edtMese.Text)) then
  begin
    MsgBox.WebMessageDlg(WA023FTimbratureDM.A023FTimbratureMW.selDatiBloccati.MessaggioLog,mtError,[mbOK],nil,'');
    Exit;
  end;

  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  DataOperazione:=StrToDate(IntToStr(Comp.Tag) + '/' + edtMese.Text);
  //Rendo invisibile la grid per alleggerire il render e l'aggiornamento delle grid del frame
  grdCartellino.Visible:=True;//False;
  WA023FRipristinoTimbOrigFM:=TWA023FRipristinoTimbOrigFM.Create(Self);
  WA023FRipristinoTimbOrigFM.CaricaDatiIniziali(DataOperazione);
  WA023FRipristinoTimbOrigFM.ResultEvent:=ResultRipristinoTimbrature;
  WA023FRipristinoTimbOrigFM.Visualizza;
end;

procedure TWA023FTimbrature.ResultRipristinoTimbrature(Sender: TObject; Result: Boolean);
begin
  grdCartellino.Visible:=True;
  if Result then
    CaricaCartellino;
end;

//Funzione di ritorno generica per tutti i frame
procedure TWA023FTimbrature.ResultCloseFrame(Sender: TObject; Result: Boolean);
begin
  //Riesame del 15/10/2013 su ativita WA023
  grdCartellino.Visible:=True;
end;

procedure TWA023FTimbrature.mnuValidaAssenzeClick(Sender: TObject);
var Comp: TComponent;
    StrCaus: String;
    Day:Integer;
begin
  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  DataOperazione:=StrToDate(IntToStr(Comp.Tag) + '/' + edtMese.Text);
  Day:=R180Giorno(DataOperazione);
  StrCaus:=WA023FTimbratureDM.A023FTimbratureMW.TrovaAssenzeDaValidare(Day);

  if StrCaus <> '' then
  begin
    //Riesame del 15/10/2013 su ativita WA023
    grdCartellino.Visible:=True;//False;
    WA023FValidaAssenzeFM:=TWA023FValidaAssenzeFM.Create(Self);
    WA023FValidaAssenzeFM.A023MW:=WA023FTimbratureDM.A023FTimbratureMW;
    WA023FValidaAssenzeFM.btnChiudi.OnClick:=WA023FValidaAssenzaFM_btnChiudiClick;
    WA023FValidaAssenzeFM.Visualizza(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,DataOperazione,DataOperazione,StrCaus);
  end;
end;

procedure TWA023FTimbrature.WA023FValidaAssenzaFM_btnChiudiClick(Sender: TObject);
begin
  inherited;
  //Riesame del 15/10/2013 su ativita WA023
  grdCartellino.Visible:=True;
  if WA023FValidaAssenzeFM.ElaborazioneEseguita then
    btnVisualizzaClick(nil);
  //WA023FValidaAssenzeFM.Free;
  FreeAndNil(WA023FValidaAssenzeFM);
end;

procedure TWA023FTimbrature.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  if WA023FTimbratureDM = nil then Exit;

  WA023FTimbratureDM.A023FTimbratureMW.ImpostaQ031;
  VisualizzaDataControllo(WA023FTimbratureDM.A023FTimbratureMW.Q031.FieldByName('Data').AsDateTime);

  CaricaCartellino;
end;

procedure TWA023FTimbrature.ApriGestTimb(Modifica: Boolean);
var WA023FGestTimbFM: TWA023FGestTimbFM;
  vis: boolean;
  ril: String;
begin
  inherited;
  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  if WA023FTimbratureDM.A023FTimbratureMW.selDatiBloccati.DatoBloccato(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,R180InizioMese(DataOperazione),'T100') then
  begin
    MsgBox.WebMessageDlg(WA023FTimbratureDM.A023FTimbratureMW.selDatiBloccati.MessaggioLog,mtError,[mbOK],nil,'');
    Exit;
  end;

  //Chiamata: 83085
  if modifica then
  begin
    Ril:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[R180Giorno(DataOperazione),NumeroElemento].Rilevatore;

    if not A000FiltroDizionario('OROLOGI DI TIMBRATURA',Ril) then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_RILEVATORE_DIZIONARIO,mtError,[mbOK],nil,'');
      Exit;
    end;
  end;

  WA023FGestTimbFM:=TWA023FGestTimbFM.Create(Self);
  WA023FGestTimbFM.A000FGestioneTimbraGiustMW:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW;
  if modifica then
    vis:=WA023FGestTimbFM.ModificaTimbratura(DataOperazione,NumeroElemento)
  else
    vis:=WA023FGestTimbFM.InserisciTimbratura(DataOperazione);

  if vis then
  begin
    //Riesame del 15/10/2013 su ativita WA023
    grdCartellino.Visible:=True;//False;
    WA023FGestTimbFM.Visualizza()
  end
  else
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    WA023FGestTimbFM.ReleaseOggetti;
    FreeAndNil(WA023FGestTimbFM);
  end;
end;

procedure TWA023FTimbrature.AttivaConteggi;
begin
  inherited;
  WA023FTimbratureDM.A023FTimbratureMW.R502ProDtM1.PeriodoConteggi(R180InizioMese(DataCorr),R180FineMese(DataCorr));
end;

procedure TWA023FTimbrature.actArchiviazioneCartelliniExecute(Sender: TObject);
var
  Data: TDateTime;
  Params: String;
begin
  inherited;
  Data:=StrToDate('01/' + edtMese.Text);
  Params:='PERIODODAL=' + DateToStr(Data) + ParamDelimiter + 'PERIODOAL=' + DateToStr(R180FineMese(Data)) + ParamDelimiter + 'PROGRESSIVO=' + IntToStr(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  AccediForm(75, Params, True);
end;

procedure TWA023FTimbrature.actCompetenzeResiduiClick(Sender: TObject);
var WC021FRiepilogoAssenzeFM: TWC021FRiepilogoAssenzeFM;
begin
  inherited;
  DataOperazione:=StrToDate(IntToStr(pmnGiustificativo.PopupComponent.Tag) + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(pmnGiustificativo.PopupComponent.Name,NOMEGIUST);

  WC021FRiepilogoAssenzeFM:=TWC021FRiepilogoAssenzeFM.Create(Self);
  WC021FRiepilogoAssenzeFM.ResultEvent:=ResultCloseFrame;
  WC021FRiepilogoAssenzeFM.VisualizzaFrame:=VisualizzaRiepilogo;
  with WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[R180Giorno(DataOperazione),NumeroElemento] do
  begin
    WC021FRiepilogoAssenzeFM.CaricaDati(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger, Causale, DataOperazione, DataNas);
  end;
end;

procedure TWA023FTimbrature.VisualizzaRiepilogo;
begin
  //Riesame del 15/10/2013 su ativita WA023
  grdCartellino.Visible:=True;//False;
  VisualizzaJQMessaggio(jQuery,770,-1,570, 'Riepilogo','#wc021_container',False,True);
end;

procedure TWA023FTimbrature.actConteggiServizioClick(Sender: TObject);
var
  Comp: TComponent;
  DataOperazione: TDateTime;
  Params: String;
begin
  inherited;
  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  DataOperazione:=StrToDate(Comp.Tag.ToString + '/' + edtMese.Text);

  Params:='DATA=' + FormatDateTime('dd/mm/yyyy',DataOperazione) + ParamDelimiter +
          'PROGRESSIVO=' + IntToStr(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);

  accediform(5,Params,False);
end;

procedure TWA023FTimbrature.actCorrezioneExecute(Sender: TObject);
var
  progC700: Integer;
begin
  inherited;
  //Caratto 18/03/2014 Utente: MONDOEDP Chiamata: 82153 bugfix posizionamento in caso di nessuna anomalia
  progC700:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;

  actCorrezione.Checked:=not actCorrezione.Checked;
  grdCorrezione.Visible:=actCorrezione.Checked;
  grdC700.AbilitaToolbar(not actCorrezione.Checked);
  edtMese.Enabled:=not (actCorrezione.Checked);
  actMeseSucc.Enabled:=not (actCorrezione.Checked);
  actMesePrec.Enabled:=not (actCorrezione.Checked);
  AggiornaToolBar(grdComandi,actlstComandi);
  if actCorrezione.Checked then
  begin
    grdC700.WC700FM.CreaSelezioneTotale;  //crea selezione di tutti i dipendenti di selAnagrafe
    imgAvvioCorrezioneAsyncClick(nil,nil);
    //Caratto 18/03/2014 Utente: MONDOEDP Chiamata: 82153 bugfix posizionamento in caso di nessuna anomalia
    if WA023FTimbratureDM.A023FTimbratureMW.Q101.RecordCount = 0 then
      grdC700.selAnagrafe.SearchRecord('PROGRESSIVO',progC700,[srFromBeginning]);
  end
  else
    //Annullo la selezione per ritornare al filtro impostato dall'utente
    grdC700.WC700FM.RipristinaSelezione;
end;

procedure TWA023FTimbrature.actElaboraOmesseTimbratureExecute(Sender: TObject);
begin
  inherited;
  AccediForm(95,'',True);
end;

procedure TWA023FTimbrature.actResetExecute(Sender: TObject);
begin
  inherited;
  WA023FTimbratureDM.A023FTimbratureMW.R502ProDtM1.Resetta;
  WA023FTimbratureDM.A023FTimbratureMW.R502ProDtM1.ResettaProg;
  LstAnomalie.Clear;
  if ActConteggi.Checked and (Length(Cartellino) > 0) then
    CaricaGrid;
end;

procedure TWA023FTimbrature.actStampaCartellinoExecute(Sender: TObject);
var Params: String;
begin
  Params:='DATA=' + FormatDateTime('dd/mm/yyyy',DataCorr) + ParamDelimiter +
          'PROGRESSIVO=' + IntToStr(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger);
  AccediForm(9,Params,True);
end;

procedure TWA023FTimbrature.CorrezioneInizio;
begin
  lblAnomalia.Text:='';
  imgAvvioCorrezione.Enabled:=True;
  imgAnomaliaSuccessiva.Enabled:=False;
  imgAnomaliaPrecedente.Enabled:=False;
  imgCorreggiAnomalia.Enabled:=False;
  TotAnom:=0;
  AnomCorr:=0;
  WA023FTimbratureDM.A023FTimbratureMW.SetProgOperAnomale;
end;

procedure TWA023FTimbrature.ApriGestGiust(Modifica: Boolean);
var WA023FGestGiustFM: TWA023FGestGiustFM;
  Giustificativo: TGiustificativi;
  sTipo, sOre1, sOre2, sCausale, sDataNas, Params: String;
begin
  inherited;
  if (not bCanNuovoGiustificativo) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;
  if Modifica then
  begin
    sCausale:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[R180Giorno(DataOperazione),NumeroElemento].Causale;
    // AOSTA_REGIONE - chiamata 85647.ini
    // se la causale originale ha la gestione visite fiscali, impedisce modifica
    with WA023FTimbratureDM.A023FTimbratureMW do
    begin
      if VarToStr(Q265.Lookup('CODICE',sCausale,'VISITA_FISCALE')) = 'S' then
      begin
        MsgBox.WebMessageDlg(Format(A000TraduzioneStringhe(A000MSG_A023_ERR_FMT_MOD_VISITA_FISCALE_S),[mnuInserisciGiust.Caption]),mtError,[mbOK],nil,'');
        Exit;
      end;
    end;
    // AOSTA_REGIONE - chiamata 85647.fine

    if (WA023FTimbratureDM.A023FTimbratureMW.GetValStrT230(sCausale,'CAUSALI_CHECKCOMPETENZE',DataOperazione) <> '') or
       (WA023FTimbratureDM.A023FTimbratureMW.GetValStrT230(sCausale,'CAUSALE_FRUIZORE',DataOperazione) <> '') or
       (WA023FTimbratureDM.A023FTimbratureMW.GetValStrT230(sCausale,'CAUSALE_HMASSENZA',DataOperazione) <> '') or
       (WA023FTimbratureDM.A023FTimbratureMW.GetValStrT230(sCausale,'CHECK_SOLOCOMPETENZE',DataOperazione) = 'S')
    then
    begin
      MsgBox.WebMessageDlg(A000TraduzioneStringhe(A000MSG_A023_ERR_NO_MOD_GIUST),mtError,[mbOK],nil,'');
      Exit;
    end;

    // controllo dati bloccati
    if WA023FTimbratureDM.A023FTimbratureMW.selDatiBloccati.DatoBloccato(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,R180InizioMese(DataOperazione),'T040') then
    begin
      MsgBox.WebMessageDlg(WA023FTimbratureDM.A023FTimbratureMW.selDatiBloccati.MessaggioLog,mtError,[mbOK],nil,'');
      Exit;
    end;
  end;
  if Modifica then
  begin
    WA023FGestGiustFM:=TWA023FGestGiustFM.Create(Self);
    if WA023FGestGiustFM.ModificaGiustificativo(DataOperazione,NumeroElemento) then
    begin
      //Rendo invisibile la grid per alleggerire il render e l'aggiornamento delle grid del frame
      //Riesame del 15/10/2013 su ativita WA023
      grdCartellino.Visible:=True;//False;
      WA023FGestGiustFM.Visualizza();
    end
    else
    begin
      WA023FGestGiustFM.ReleaseOggetti;
      FreeAndNil(WA023FGestGiustFM);
    end;
  end
  else
  begin
    sTipo:='';
    sOre1:='';
    sOre2:='';
    sCausale:='';
    sDataNas:='';
    with WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW do
    begin
      if NumeroElemento <= FNumGiustif[R180Giorno(DataOperazione)] then
      begin
        Giustificativo:=FGiustificativi[R180Giorno(DataOperazione),NumeroElemento];
        sTipo:=Giustificativo.Tipo;
        sOre1:=FormatDateTime('hh:mm',Giustificativo.DaOre);
        sOre2:=FormatDateTime('hh:mm',Giustificativo.AOre);
        sCausale:=Giustificativo.Causale;
        if (sTipo = 'I') or (Giustificativo.Tipo = '') then
        begin
          sOre1:='';
          sOre2:='';
        end
        else if sTipo = 'M' then
        begin
          if R180OreMinuti(Giustificativo.DaOre) = 0 then
            sOre1:='';
          sOre2:='';
        end;
        if Giustificativo.DataNas <> DATE_NULL then
          sDataNas:=DateTimeToStr(Giustificativo.DataNas);
      end;
    end;
    Params:='PROGRESSIVO=' + grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsString + ParamDelimiter +
           'DATA=' + FormatDateTime('dd/mm/yyyy',DataOperazione) + ParamDelimiter +
           'TIPO=' + sTipo + ParamDelimiter +
           'ORE1=' + sOre1 + ParamDelimiter +
           'ORE2=' + sOre2 + ParamDelimiter +
           'CAUSALE=' + sCausale + ParamDelimiter +
           'DATANAS=' + sDataNas + ParamDelimiter +
           'CARTEL=S';
    AccediForm(2,Params,True);
  end;
end;

procedure TWA023FTimbrature.CaricaCartellino;
var
  i, GiorniMese: Integer;
  DataCorrente: TDateTime;
begin
  grdC700.WC700FM.C700DataLavoro:=R180FineMese(DataCorr);

  lblCartellinoCaption.Visible:=True;
  lnkLegenda.Visible:=True;
  grdCartellino.Visible:=True;
  if grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger = 0 then
  begin
    lblCartellinoCaption.Visible:=False;
    lnkLegenda.Visible:=False;
    grdCartellino.Visible:=False;
    Exit;
  end;

  DataCorrente:=R180InizioMese(DataCorr);
  GiorniMese:=R180GiorniMese(DataCorrente);

  //carica Mese
  WA023FTimbratureDM.A023FTimbratureMW.caricaMese(R180Anno(DataCorrente),R180Mese(DataCorrente),ActConteggi.Checked);

  //cartellino da indice 1 a giorniMese. Cosi allineato con grid che ha intestazione
  setLength(Cartellino,giorniMese+1);
  for i:=1 to High(Cartellino) do
  begin
    Cartellino[i].Data:=DataCorrente;
    Cartellino[i].Domenica:=DayOfWeek(DataCorrente) = 1;
    ImpostaDaCalendario(DataCorrente,grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,i);

    DataCorrente:=DataCorrente+1;
  end;
  CaricaGrid;
end;

{Cerco le caratteristiche del giorno su Calendario Individ/Tabella
(Festivo/Lavorativo)}
procedure TWA023FTimbrature.ImpostaDaCalendario(Data: TDateTime; Progressivo,i:Integer);
begin
  with WA023FTimbratureDM.A023FTimbratureMW.GetCalend do
  begin
    SetVariable('PROG',Progressivo);
    SetVariable('D',Data);
    Execute;
    Cartellino[i].NonImpostato:=False;
    if (VarToStr(GetVariable('L')) = '') and (VarToStr(GetVariable('F')) = '') and (GetVariable('G') = 0) then
    begin
      Cartellino[i].NonImpostato:=True;
      Exit;
    end;

    Cartellino[i].Festivo:=VarToStr(GetVariable('F')) = 'S';
    Cartellino[i].Lavorativo:=VarToStr(GetVariable('L')) = 'S';
  end;
end;

function TWA023FTimbrature.ConteggiGiorno(Giorno:TDateTime): TConteggiGiorno;
{Richiama i conteggi e li visualizza nelle TLabel}
var
  s: String;
begin
  Result:=WA023FTimbratureDM.A023FTimbratureMW.ConteggiGiornalieri(Giorno);

  for s in WA023FTimbratureDM.A023FTimbratureMW.getLstAnomalieConteggiGiornalieri do
    LstAnomalie.Add(s);
end;

procedure TWA023FTimbrature.CaricaGrid;
var
  day,c,colControl,rowControl: Integer;
  Conteggi: TConteggiGiorno;
  grdGiorno: TmeIWGrid;
  tmpLnk: TmeIWLink;
  grdConteggi: TmeIWGrid;
  LIWImg: TmeIWImageFile;
procedure EvidenziaNoteGiorno(Data: TDateTime; LGiorno: TmeIWLink);
begin
  if WA023FTimbratureDM.A023FTimbratureMW.Q080.Locate('Data', Data,[]) then
  begin
    if WA023FTimbratureDM.A023FTimbratureMW.Q080.FieldByName('Note').AsString <> '' then
    begin
      LGiorno.Text:=tmpLnk.Text + ' *';
      LGiorno.Hint:=WA023FTimbratureDM.A023FTimbratureMW.Q080.FieldByName('Note').AsString;
      LGiorno.ShowHint:=True;
    end;
  end;
end;
begin
  // Deallocazione controlli della griglia e pulizia dati
  C190PulisciIWGrid(grdCartellino,True);

  lblCartellinoCaption.Caption:='Cartellino del mese di ' + FormatDateTime('mmmm yyyy',DataCorr);
  //Caricamento Grid
  grdCartellino.RowCount:=Length(Cartellino);
  grdCartellino.ColumnCount:=4;
  if ActConteggi.Checked then
  begin
    grdCartellino.ColumnCount:=grdCartellino.ColumnCount + 1;
    WA023FTimbratureDM.A023FTimbratureMW.CaricaTimbratureGiustificativi;
  end;
  c:=0;

  //intestazione
  grdCartellino.Cell[0,c].Text:='Data';
  grdCartellino.Cell[0,c].Css:='width5chr';

  // giustificativi
  inc(c);
  grdCartellino.Cell[0,c].Text:='Giustificativi';
  grdCartellino.Cell[0,c].Css:='width45chr';
  inc(c);

  // timbrature
  grdCartellino.Cell[0,c].Text:='Timbrature';
  inc(c);

  // richieste in corso
  grdCartellino.Cell[0,c].Text:='Richieste';
  grdCartellino.Cell[0,c].Css:='width5chr';
  inc(c);

  // conteggi
  if ActConteggi.Checked then
  begin
    grdCartellino.Cell[0,c].Text:='Conteggi';
    grdCartellino.Cell[0,c].Css:='width15chr';
  end;

  // Dati cartellino
  for day:=1 to High(Cartellino) do
  begin
    if ActConteggi.Checked then
    begin
      WA023FTimbratureDM.A023FTimbratureMW.R502ProDtM1.PrimaVolta:='si';
      //devo eseguire i conteggi prima di caricare la grid. perchè nel caso di allineamento
      //automatico viene modificato l'array delle timbrature
      conteggi:=ConteggiGiorno(Cartellino[day].Data);
    end;

    c:=0;
    with grdCartellino.Cell[day,c] do
    begin
      Css:=cssSfondoGiorno(Cartellino[day]);

      //creare grid con giorno , orario ,turno e cp
      grdGiorno:=TmeIWGrid.Create(Self);
      grdCartellino.Cell[day,c].Control:=grdGiorno;
      with grdGiorno do
      begin
        Css:='gridGiornoCartellino';
        FriendlyName:='grdGiorno' + IntToStr(day);
        ColumnCount:=2;
        RowCount:=2;
      end;
      colControl:=0;
      rowControl:=0;
      //link per giorno
      with grdGiorno.Cell[rowControl,colControl] do
      begin
        tmpLnk:=TmeIWLink.Create(Self);
        Control:=tmpLnk;
      end;
      ImpostaLinkGiorno(tmpLnk,Cartellino[day]);
      EvidenziaNoteGiorno(Cartellino[day].Data, tmpLnk);

      //caratto 26/03/2014 link solo se abilitato come per altre funzioni
      if A000GetInibizioni('Tag','8') <> 'N'  then
        tmpLnk.onClick:=giornoLinkClick;

      inc(colControl);
      //label per cp
      with grdGiorno.Cell[rowControl,colControl] do
      begin
        Control:=TmeIWLabel.Create(Self);
      end;
      with (grdGiorno.Cell[rowControl,colControl].Control as TmeIWLabel) do
      begin
        Css:='giornoCartellino  ';
        Text:='';
        if WA023FTimbratureDM.A023FTimbratureMW.FPianif[Day] then
          Text:='cp';
      end;
      colControl:=0;
      inc(rowControl);
      //link per orario
      with grdGiorno.Cell[rowControl,colControl] do
      begin
        Control:=TmeIWLink.Create(Self);
      end;
      with (grdGiorno.Cell[rowControl,colControl].Control as TmeIWLink) do
      begin
        RawText:=False;
        Css:='giornoCartellino';
        Text:='';
        //Caratto 3/6/2015 Versione: 9.4(4) Utente: AOSTA_REGIONE Chiamata: 91677; conteggi sovrascrivono
        //caratto 26/11/2013. Utente: MONDOEDP -  Chiamata: 79584 Ini. L'orario veniva sovrascritto in caso di conteggi attivi
        if (ActConteggi.Checked) and (conteggi.Orario <> '') and (not conteggi.Blocca ) then //risultato dai conteggi
        //Utente: MONDOEDP -  Chiamata: 79584 fine.
        begin
          if conteggi.OrarioFontNero then
            Css:=Css + ' font_neroImp';
          Text:=conteggi.Orario;
        end
        else
        begin
          if WA023FTimbratureDM.A023FTimbratureMW.Q080.Locate('Data',Cartellino[day].Data,[]) then
          begin
            Css:=Css + ' font_rosso';
            Text:=WA023FTimbratureDM.A023FTimbratureMW.Q080.FieldByName('Orario').AsString;
          end;
        end;
        if Text = '' then
        begin
          RawText:=True;
          Text:='&nbsp;';
        end
        else
        begin
          //caratto 18/03/2014 Utente: MONDOEDP Chiamata: 82153 link solo se abilitato
          if A000GetInibizioni('Tag','103') <> 'N'  then
            onclick:=orarioLinkClick;
        end;
      end;
      inc(colControl);
      //label per turnoorario
      with grdGiorno.Cell[rowControl,colControl] do
      begin
        Control:=TmeIWLabel.Create(Self);
      end;
      with (grdGiorno.Cell[rowControl,colControl].Control as TmeIWLabel) do
      begin
        Css:='giornoCartellino';
        Text:='';

        //Caratto 3/6/2015 Versione: 9.4(4) Utente: AOSTA_REGIONE Chiamata: 91677; conteggi sovrascrivono
        //caratto 02/12/2013. Utente: MONDOEDP - il turno veniva sovrascritto in caso di conteggi attivi
        if (ActConteggi.Checked) and (conteggi.TurniDaConteggio) and (not conteggi.Blocca) then //risultato dai conteggi
        begin
          if conteggi.TurniFontNero then
            Css:=Css + ' font_neroImp';
          Text:=conteggi.Turni;
        end
        else
        begin
          if WA023FTimbratureDM.A023FTimbratureMW.Q080.Locate('Data',Cartellino[day].Data,[]) then
          begin
            Css:=Css + ' font_rosso';
            Text:=WA023FTimbratureDM.A023FTimbratureMW.TestoTurno(Cartellino[day].Data);
          end;
        end;
      end;
      inc(colControl);
    end;
    inc(c);

    //Giustificativi
    CreaGrdGiustificativi(day, c);
    inc(c);

    //Timbrature
    CreaGrdTimbrature(day,c);
    inc(c);

    // richieste in corso
    if (WA023FTimbratureDM.A023FTimbratureMW.selVT105.Locate('Data',Cartellino[day].Data,[])) or
       (WA023FTimbratureDM.A023FTimbratureMW.selVT085.Locate('Data',Cartellino[day].Data,[])) or
       (WA023FTimbratureDM.A023FTimbratureMW.selVT050.Locate('Data',Cartellino[day].Data,[])) then
    begin
      LIWImg:=TmeIWImageFile.Create(Self);
      { DONE : TEST IW 14 OK }
      //LIWImg.DontSubmitFiles:=True;
      LIWImg.Parent:=Self;
      LIWImg.Css:='icona displayBlock';
      LIWImg.ImageFile.FileName:=fileImgElenco;
      LIWImg.OnClick:=imgRichiesteInCorsoClick;
      LIWImg.Hint:='Visualizza richieste in corso del ' + Cartellino[day].Data.Date.ToString('dd/mm');
      LIWImg.Tag:=Trunc(Cartellino[day].Data);
      grdCartellino.Cell[day,c].Control:=LIWImg;
    end
    else
    begin
      grdCartellino.Cell[day,c].Control:=nil;
    end;
    inc(c);

    //Conteggi
    if ActConteggi.Checked then
    begin
      grdConteggi:=TmeIWGrid.Create(Self);
      grdCartellino.Cell[day,c].Control:=grdConteggi;
      with grdConteggi do
      begin
        Css:='gridComandi bg_giallo';
        FriendlyName:='Conteggi' + IntToStr(day);
        Name:=FriendlyName;
        ColumnCount:=4;
        RowCount:=1;
      end;
      colControl:=0;
      //componente label per ore lavorate
      with grdConteggi.Cell[0,colControl] do
      begin
        Control:=TmeIWLabel.Create(Self);
      end;
      with (grdConteggi.Cell[0,colControl].Control as TmeIWLabel) do
      begin
        FriendlyName:='orelav' + IntToStr(day);
        Name:=FriendlyName;
        Caption:=Conteggi.OreLavorate;
        Hint:='Ore lavorate';
        Css:='conteggio font_neroImp';
      end;
      inc(colControl);
      //componente label per debito
      with grdConteggi.Cell[0,colControl] do
      begin
        Control:=TmeIWLabel.Create(Self);
      end;
      with (grdConteggi.Cell[0,colControl].Control as TmeIWLabel) do
      begin
        FriendlyName:='debito' + IntToStr(day);
        Name:=FriendlyName;
        Caption:=Conteggi.Debito;
        Hint:='Debito giornaliero';
        Css:='conteggio font_verde';
      end;
      inc(colControl);
      //componente label per scostamento
      with grdConteggi.Cell[0,colControl] do
      begin
        Control:=TmeIWLabel.Create(Self);
      end;
      with (grdConteggi.Cell[0,colControl].Control as TmeIWLabel) do
      begin
        FriendlyName:='scost' + IntToStr(day);
        Name:=FriendlyName;
        Caption:=Conteggi.Scostamento;
        Hint:='Scostamento';
        Css:='conteggio font_rosso';
      end;
      inc(colControl);
      //componente label per esclusione
      with grdConteggi.Cell[0,colControl] do
      begin
        Control:=TmeIWLabel.Create(Self);
      end;
      with (grdConteggi.Cell[0,colControl].Control as TmeIWLabel) do
      begin
        FriendlyName:='escl' + IntToStr(day);
        Name:=FriendlyName;
        Caption:=Conteggi.EscluseDaNorm;
        Hint:='Ore escluse dalle normali';
        Css:='conteggio font_blu';
      end;
    end;
  end;
end;

function TWA023FTimbrature.getGustificativo(day, i: Integer): TGiustificativi;
begin
  Result:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FGiustificativi[day,i];
end;

function TWA023FTimbrature.getNumeroGiustificativi(day: Integer): Byte;
begin
  Result:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FNumGiustif[day];
end;

function TWA023FTimbrature.getNumeroTimbrature(day: Integer): Byte;
begin
  Result:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FNumTimbrature[day];
end;

function TWA023FTimbrature.getTimbratura(day,i: Integer): TTimbrature;
begin
  Result:=WA023FTimbratureDM.A023FTimbratureMW.A000FGestioneTimbraGiustMW.FTimbrature[day,i];
end;

procedure TWA023FTimbrature.giornoLinkClick(Sender: TObject);
var Day,Progressivo: Integer;
  sData, Params: String;
begin
  Day:=(Sender as TmeIWLink).Tag;
  sData:=FormatDateTime('dd/mm/yyyy',StrToDate(IntToStr(Day) + '/' + edtMese.Text));

  Progressivo:=grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger;
  Params:='PROGRESSIVO=' + IntToStr(Progressivo) + ParamDelimiter +
          'DATADA=' + sData + ParamDelimiter +
          'DATAA=' + sData + ParamDelimiter +
          'DACARTELLINO=TRUE';

  AccediForm(8,Params,True);
end;

procedure TWA023FTimbrature.orarioLinkClick(Sender: TObject);
var Params,
    Codice: String;
begin
  Codice:=(Sender as TmeIWLink).Text;
  Params:='CODICE=' + Codice;
  AccediForm(103,Params,False);
end;

procedure TWA023FTimbrature.ResultCancellaTimbratura(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    with WA023FTimbratureDM.A023FTimbratureMW do
    begin
      A000FGestioneTimbraGiustMW.EseguiCancellaTimbratura(R180Giorno(DataOperazione),NumeroElemento);
      Q100.Close;
      Q100.Open;
    end;
    CaricaGrid;
  end;
end;

procedure TWA023FTimbrature.ResultEliminaTimbratureDoppie(Sender: TObject; Result: Boolean; Valore: String);
var lstValori: TStringList;
  DataI, DataF: TDateTime;
begin
  //Riesame del 15/10/2013 su ativita WA023
  grdCartellino.Visible:=True;
  if Result then
  begin
    try
      try
        lstValori:=TStringList.Create;
        lstValori.CommaText:=Valore;
        DataI:=StrToDate(lstValori[0]);
        DataF:=StrToDate(lstValori[1]);
      except
        raise Exception.Create(A000MSG_ERR_DATA_ERRATA);
      end;
    finally
      FreeAndNil(lstValori);
    end;
    WA023FTimbratureDM.A023FTimbratureMW.EliminaTimbratureDoppie(False,DataI,DataF);
    CaricaCartellino;
  end;
end;

procedure TWA023FTimbrature.imgCorreggiAnomaliaClick(Sender: TObject);
var YY,MM,Giorno :Word;
begin
  inc(AnomCorr,1);
  imgCorreggiAnomalia.Enabled:=False;
  DecodeDate(DataAnomalia,YY,MM,Giorno);
  DeleteRecord;
  edtMese.Text:=FormatDateTime('mm/yyyy',DataAnomalia);
  DataCorr:=R180InizioMese(DataAnomalia);
  //imposta progressivo corrente su dataset e carica il cartellino
  WC700CambioProgressivo(nil);
  lstScrollBar[ScrollBarIndexOf('divscrollable')].Top:=(Giorno - 5) * 38;
  AggiornaToolbarCorrezione;
end;

procedure TWA023FTimbrature.imgRichiesteInCorsoClick(Sender: TObject);
var
  LWC028FM: TWC028FRichiesteInCorsoFM;
  LDate: TDateTime;
begin
  LDate:=(Sender as TmeIWImageFile).Tag;

  LWC028FM:=TWC028FRichiesteInCorsoFM.Create(Self);
  LWC028FM.A023MW:=WA023FTimbratureDM.A023FTimbratureMW;
  LWC028FM.Visualizza(LDate);
end;

procedure TWA023FTimbrature.RefreshPage;
begin
  inherited;
  with WA023FTimbratureDM.A023FTimbratureMW do
  begin
    Q080.Close;
    Q080.Open;
    R502ProDtM1.Q080.Close;
    R502ProDtM1.PeriodoConteggi(R180InizioMese(DataCorr),R180FineMese(DataCorr));
    //refresh per inserimento / cancellazione giustificativo
    Q040.Close;
    Q040.Open;
    Q031_1.Close;
    Q031_1.Open;
    CaricaCartellino;
  end;
end;

procedure TWA023FTimbrature.VisualizzaDataControllo(Data: TDateTime);
begin
  if Data <> 0 then
  begin
    lblDataControllo.Caption:='Data Controllo: ' + FormatDateTime('dd/mm/yyyy',Data);
  end;
  lblDataControllo.Visible:=(Data <> 0);
end;

//Correzione anomalie - inizio
procedure TWA023FTimbrature.imgAnomaliaPrecedenteAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ScorriQuery(False);
  AggiornaToolbarCorrezione;
end;

procedure TWA023FTimbrature.imgAnomaliaSuccessivaAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  ScorriQuery(True);
  AggiornaToolbarCorrezione;
end;

procedure TWA023FTimbrature.imgAvvioCorrezioneAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  CorrezioneInizio;
  imgAvvioCorrezione.Enabled:=False;
  ScorriQuery(True);
  AggiornaToolbarCorrezione;
end;

procedure TWA023FTimbrature.ScorriQuery(Avanti:Boolean);
var
  sTimbGior,
  sTimbrature,
  sAnomalia: String;
begin
  with WA023FTimbratureDM.A023FTimbratureMW do
  begin
    if Avanti then
    begin
     if Q101.Active then
       Q101.Next
     else
       Q101.Open;
     if Q101.Eof then
     begin
       Fine;
       exit;
     end;
    end
    else
    begin
      Q101.Prior;
      if Q101.Bof then
        exit;
    end;
    imgAnomaliaSuccessiva.Enabled:=Q101.RecordCount > 0;
    imgAnomaliaPrecedente.Enabled:=imgAnomaliaSuccessiva.Enabled;
    imgCorreggiAnomalia.Enabled:=imgAnomaliaSuccessiva.Enabled;
    TotAnom:=Q101.RecNo;
    Prog:=Q101.FieldByName('Progressivo').Value;
    DataAnomalia:=Q101.FieldByName('Data').Value;
    Livello:=Q101.FieldByName('Livello').AsInteger;
    Anomalia:=Q101.FieldByName('Anomalia').Value;
    selAnagrafe.Locate('Progressivo',Prog,[]);
    SB:=selAnagrafe.FieldByname('T430BADGE').AsString;
    SN:=selAnagrafe.FieldByname('COGNOME').AsString + ' ' + selAnagrafe.FieldByname('NOME').AsString;

    sAnomalia:='Matricola:' + SelAnagrafe.FieldByname('MATRICOLA').AsString + ' Badge:' + SB + ' ' + SN +
                      ' Data:' + FormatDateTime('dd/mm/yyyy',DataAnomalia) +
                      Format(' Anomalia di %d° livello ',[Livello]) +
                      Anomalia + ' ';
    selT100.Close;
    selT100.SetVariable('Progressivo',Q101.FieldByName('Progressivo').AsInteger);
    selT100.SetVariable('Data',Q101.FieldByName('Data').AsDateTime);
    selT100.Open;

    sTimbrature:='';
    while not selT100.Eof do
    begin
      sTimbGior:=selT100.FieldByName('Verso').AsString + FormatDateTime('hh:mm',selT100.FieldByName('Ora').AsDateTime);
      //le timbrature originali in rosso
      if selT100.FieldByName('Flag').AsString = 'O' then
      begin
         sTimbGior:='<SPAN class="font_rossoImp">' + sTimbGior + '<SPAN> ';
      end;
      sTimbrature:=sTimbrature + sTimbGior;
      selT100.Next;
    end;
    sAnomalia:=sAnomalia + sTimbrature;

    lblAnomalia.Text:=sAnomalia;
  end;
end;

procedure TWA023FTimbrature.AggiornaToolbarCorrezione;
begin
  if imgAvvioCorrezione.Enabled then
    imgAnomaliaPrecedente.ImageFile.Filename:='img/btnSuccessivo.png'
  else
    imgAvvioCorrezione.ImageFile.Filename:='img/btnSuccessivo_disabled.png';

  if imgAnomaliaPrecedente.Enabled then
    imgAnomaliaPrecedente.ImageFile.Filename:='img/btnStoricoPrecedente.png'
  else
    imgAnomaliaPrecedente.ImageFile.Filename:='img/btnStoricoPrecedente_disabled.png';

  if imgAnomaliaSuccessiva.Enabled then
    imgAnomaliaSuccessiva.ImageFile.Filename:='img/btnStoricoSuccessivo.png'
  else
    imgAnomaliaSuccessiva.ImageFile.Filename:='img/btnStoricoSuccessivo_disabled.png';

  if imgCorreggiAnomalia.Enabled then
    imgCorreggiAnomalia.ImageFile.Filename:='img/btnAmbulanza2.png'
  else
    imgCorreggiAnomalia.ImageFile.Filename:='img/btnAmbulanza2_disabled.png';
end;

procedure TWA023FTimbrature.Fine;
begin
  lblAnomalia.Text:='Correzione terminata.';
  lblAnomalia.hint:='<html> Correzione terminata. <BR> ' +
                    'Totale anomalie riscontrate:' + inttostr(TotAnom) + '<BR>' +
                    'Numero anomalie corrette:' + inttostr(AnomCorr)  + '<BR>' +
                    'Numero anomalie ignorate:' + inttostr(TotAnom - AnomCorr);
  imgAvvioCorrezione.Enabled:=True;
  imgAnomaliaSuccessiva.Enabled:=False;
  imgAnomaliaPrecedente.Enabled:=False;
  imgCorreggiAnomalia.Enabled:=False;
end;

procedure TWA023FTimbrature.DeleteRecord;
begin
  with WA023FTimbratureDM.A023FTimbratureMW do
  begin
    Q101Delete.SetVariable('Progressivo',Prog);
    Q101Delete.SetVariable('Data',DataAnomalia);
    Q101Delete.SetVariable('Livello',Livello);
    Q101Delete.SetVariable('Anomalia',Anomalia);
    Q101Delete.SetVariable('Operatore',Parametri.ProgOper);
    try
      Q101Delete.Execute;
      SessioneOracle.Commit;
    except
    end;
  end;
end;
//Correzione anomalie - fine

procedure TWA023FTimbrature.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(WA023FTimbratureDM);
  inherited;
end;

end.
