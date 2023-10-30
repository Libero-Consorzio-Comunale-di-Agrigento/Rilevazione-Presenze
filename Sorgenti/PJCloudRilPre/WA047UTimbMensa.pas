unit WA047UTimbMensa;

interface

uses
  Winapi.Windows, ActiveX,Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR104UGestCartellino, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar,
  meIWImageFile, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, WA047UTimbMensaDM,
  C180FunzioniGenerali,A000UCostanti, IWCompEdit, meIWEdit, A000UInterfaccia,
  System.Actions, Vcl.ActnList, C190FunzioniGeneraliWeb,medpIWC700NavigatorBar,
  A000UMessaggi, medpIWMessageDlg, IWApplication, IWCompLabel, meIWLabel,
  WR100UBase, Vcl.Menus, A047UTimbMensaMW, WA047UGestTimbFM,
  WA047UAccessoManualeFM, WA047UDialogStampaFM,WC020UInputDataOreFM, Data.DB,
  Datasnap.DBClient, Datasnap.Win.MConnect, A000USessione;

type
  TWA047FTimbMensa = class(TWR104FGestCartellino)
    mnuInserisciTimb: TMenuItem;
    mnuInserisciTimb1: TMenuItem;
    mnuModificaTimb: TMenuItem;
    mnuCancellaTimb: TMenuItem;
    pmnAccesso: TPopupMenu;
    mnuAggiungiAccessi: TMenuItem;
    pmnNuovoAccesso: TPopupMenu;
    mnuInserisciAccesso: TMenuItem;
    mnuEliminaAccesso: TMenuItem;
    btnNuovoAccesso: TmeIWButton;
    actStampa: TAction;
    N1: TMenuItem;
    mnuRipristino: TMenuItem;
    N2: TMenuItem;
    mnuRipristino1: TMenuItem;
    DCOMConnection: TDCOMConnection;
    mnuRegoleConteggio: TMenuItem;
    mnuRegoleConteggio2: TMenuItem;
    N3: TMenuItem;
    mnuRegoleConteggio3: TMenuItem;
    N4: TMenuItem;
    mnuRegoleConteggio4: TMenuItem;
    procedure IWAppFormCreate(Sender: TObject);
    procedure mnuInserisciTimbClick(Sender: TObject);
    procedure mnuModificaTimbClick(Sender: TObject);
    procedure mnuCancellaTimbClick(Sender: TObject);
    procedure mnuAggiungiAccessiClick(Sender: TObject);
    procedure mnuEliminaAccessoClick(Sender: TObject);
    procedure mnuInserisciAccessoClick(Sender: TObject);
    procedure btnNuovoAccessoClick(Sender: TObject);
    procedure actStampaExecute(Sender: TObject);
    procedure mnuRipristinoClick(Sender: TObject);
    procedure mnuRegoleConteggioClick(Sender: TObject);
  private
    bCanNuovoAccesso: boolean;
    AccessiXRow: Integer;
    WA047FDialogStampaFM: TWA047FDialogStampaFM;
    procedure ImpostaDaCalendario(Data: TDateTime; i: Integer);
    procedure CreaGrdAccessi(day, c: Integer);
    function getNumeroAccessi(day: Integer): Byte;
    procedure ImpostaGrdAccessiGiorno(var grd: TmeIWGrid; var NumAccessi: Integer; day: Integer);
    function getAccessoMensa(day, i: Integer): TAccessiMensa;
    procedure ImpostaEditAccesso(var edt: TmeIWEdit;AccessiMensa: TAccessiMensa; day, nAccesso: Integer);
    function ConteggiGiorno(Giorno: TDateTime): TConteggiPasti;
    procedure ResultCancellaTimbratura(Sender: TObject; R: TmeIWModalResult;
      KI: String);
    procedure IncDecAccessi(bIncrementa: boolean);
    procedure edtNuovoAccessoAsyncDoubleClick(Sender: TObject;
      EventParams: TStringList);
    procedure GestNuovoAccesso;
    procedure ResultEliminaTimbratureRiscaricate(Sender: TObject;
      Result: Boolean; Valore: String);
  protected
    procedure ImpostazioniWC700; override;
    procedure AttivaConteggi; override;
    procedure ApriGestTimb(Modifica: Boolean); override;
    procedure ApriGestGiust(Modifica: Boolean); override;
    procedure ElaborazioneServer; override;
  public
    WA047FTimbMensaDM: TWA047FTimbMensaDM;
    function InizializzaAccesso: Boolean; override;
    procedure WC700CambioProgressivo(Sender: TObject); override;
    procedure CaricaCartellino; override;
    procedure CaricaGrid; override;
    function getTimbratura(day,i:Integer):TTimbrature;override;
    function getNumeroTimbrature(day:Integer):Byte;override;
    function getGustificativo(day,i:Integer):TGiustificativi;override;
    function getNumeroGiustificativi(day:Integer):Byte;override;
  end;

  const
    NOMEACCESSO: String = 'Acces';

implementation

{$R *.dfm}

procedure TWA047FTimbMensa.ImpostazioniWC700;
begin
  inherited;
  grdC700.ImpostaProgressivoCorrente:=True;
end;

procedure TWA047FTimbMensa.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AccessiXRow:=2;
  AttivaGestioneC700;
  WA047FTimbMensaDM:=TWA047FTimbMensaDM.Create(Self);
  WA047FTimbMensaDM.A047FTimbMensaMW.SelAnagrafe:=grdC700.selAnagrafe;

  //Imposta variabili wr104 per caricagrid
  with WA047FTimbMensaDM.A047FTimbMensaMW do
  begin
    QRilevatori:=QOrologi;
    QCausAss:=Q265;
    QCausPres:=Q275;
    QCausGiust:=Q305;
    DsrTimbrature:=D370;
  end;
end;

procedure TWA047FTimbMensa.mnuAggiungiAccessiClick(Sender: TObject);
begin
  inherited;
  DataOperazione:=StrToDate(IntToStr(pmnAccesso.PopupComponent.Tag) + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(pmnAccesso.PopupComponent.Name,NOMEACCESSO);

  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;
  IncDecAccessi(True);
end;

procedure TWA047FTimbMensa.IncDecAccessi(bIncrementa: boolean);
var
  AccessiMensa: TAccessiMensa;

begin
if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  AccessiMensa:=getAccessoMensa(R180Giorno(DataOperazione),NumeroElemento);
  if bIncrementa then
    AccessiMensa.Accessi:=AccessiMensa.Accessi + 1
  else
    AccessiMensa.Accessi:=AccessiMensa.Accessi - 1;

  WA047FTimbMensaDM.A047FTimbMensaMW.ModificaNumeroAccessi(DataOperazione,
                                                           grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,
                                                           AccessiMensa.Causale,
                                                           AccessiMensa.PranzoCena,
                                                           AccessiMensa.Accessi);
  CaricaGrid;
end;

procedure TWA047FTimbMensa.mnuCancellaTimbClick(Sender: TObject);
var
  Timbratura: TTimbrature;
  BloccaOperazione: boolean;
begin
  inherited;
  DataOperazione:=StrToDate(IntToStr(pmnTimbratura.PopupComponent.Tag) + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(pmnTimbratura.PopupComponent.Name,NOMETIMBR);

  Timbratura:=WA047FTimbMensaDM.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FTimbrature[R180Giorno(DataOperazione),NumeroElemento];
  BloccaOperazione:=not bCanCancellaTimbratura;

  if Parametri.CancellaTimbrature <> 'S' then
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

  if not(WA047FTimbMensaDM.A047FTimbMensaMW.Q370.Locate('Data;Ora;Verso;Flag',VarArrayOf([DataOperazione,Timbratura.Ora,Timbratura.Verso,Timbratura.Flag]),[])) then
    Exit;

  MsgBox.WebMessageDlg(A000MSG_A023_DLG_CANC_TIMB, mtConfirmation,[mbYes,mbNo], ResultCancellaTimbratura,'');
end;

procedure TWA047FTimbMensa.mnuEliminaAccessoClick(Sender: TObject);
begin
  inherited;
  DataOperazione:=StrToDate(IntToStr(pmnAccesso.PopupComponent.Tag) + '/' + edtMese.Text);
  NumeroElemento:=EstraiColonnaElemento(pmnAccesso.PopupComponent.Name,NOMEACCESSO);

  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;
  IncDecAccessi(False);
end;

procedure TWA047FTimbMensa.ResultCancellaTimbratura(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    with WA047FTimbMensaDM.A047FTimbMensaMW do
    begin
      A000FGestioneTimbraGiustMW.EseguiCancellaTimbratura(R180Giorno(DataOperazione),NumeroElemento);
      Q370.Close;
      Q370.Open;
    end;
    CaricaCartellino;
    //CaricaGrid;
  end;
end;

procedure TWA047FTimbMensa.mnuInserisciAccessoClick(Sender: TObject);
var
  day: integer;
begin
  inherited;
  Day:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent.Tag;
  DataOperazione:=StrToDate(IntToStr(Day) + '/' + edtMese.Text);
  GestNuovoAccesso;
end;

procedure TWA047FTimbMensa.mnuInserisciTimbClick(Sender: TObject);
var Day: Integer;
begin
  inherited;
  Day:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent.Tag;
  DataOperazione:=StrToDate(IntToStr(Day) + '/' + edtMese.Text);
  ApriGestTimb(False);
end;

procedure TWA047FTimbMensa.mnuModificaTimbClick(Sender: TObject);
begin
  try
    DataOperazione:=StrToDate(IntToStr(pmnTimbratura.PopupComponent.Tag) + '/' + edtMese.Text);
    NumeroElemento:=EstraiColonnaElemento(pmnTimbratura.PopupComponent.Name,NOMETIMBR);
    ApriGestTimb(True);
  except
  end;
end;

procedure TWA047FTimbMensa.mnuRegoleConteggioClick(Sender: TObject);
begin
  inherited;
  accediForm(129);
end;

procedure TWA047FTimbMensa.mnuRipristinoClick(Sender: TObject);
var
   Comp: TComponent;
   WC020FInputDataOreFM: TWC020FInputDataOreFM;
begin
  inherited;

  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  Comp:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent;
  DataOperazione:=StrToDate(IntToStr(comp.Tag) + '/' + edtMese.Text);

  if WA047FTimbMensaDM.A047FTimbMensaMW.selDatiBloccati.DatoBloccato(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,R180InizioMese(DataOperazione),'T370') then
  begin
    MsgBox.WebMessageDlg(WA047FTimbMensaDM.A047FTimbMensaMW.selDatiBloccati.MessaggioLog,mtError,[mbOK],nil,'');
    Exit;
  end;
  grdCartellino.Visible:=False;
  WC020FInputDataOreFM:=TWC020FInputDataOreFM.Create(Self);
  WC020FInputDataOreFM.ImpostaCampiPeriodo('Da: ','A: ',DataOperazione, DataOperazione, 'dd/mm/yyyy');
  WC020FInputDataOreFM.Visualizza('Eliminazione timbrature riscaricate');
  WC020FInputDataOreFM.ResultEvent:=ResultEliminaTimbratureRiscaricate;
end;

procedure TWA047FTimbMensa.ResultEliminaTimbratureRiscaricate(Sender: TObject;
  Result: Boolean; Valore: String);
var lstValori: TStringList;
  DataI, DataF: TDateTime;
begin

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
    WA047FTimbMensaDM.A047FTimbMensaMW.EliminaTimbratureRiscaricate(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,DataI, DataF);
    CaricaCartellino;
  end;
end;

function TWA047FTimbMensa.ConteggiGiorno(Giorno:TDateTime): TConteggiPasti;
var
  i: Integer;
begin
  with WA047FTimbMensaDM.A047FTimbMensaMW do
  begin
    Result:=ConteggiGiorno(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger,Giorno);
    for i:=0 to R300FAccessiMensaDtM.Anomalie.Count - 1 do
      LstAnomalie.Add(R300FAccessiMensaDtM.Anomalie[i]);
  end;
end;

function TWA047FTimbMensa.InizializzaAccesso: Boolean;
var
  Progressivo: Integer;
begin
  //Valuta se si può inserire la nuova timbratura
  bCanNuovaTimbratura:=(not SolaLettura);
  bCanNuovoAccesso:=(not SolaLettura);
  bCanCancellaTimbratura:=(not SolaLettura);
  bCanNuovoGiustificativo:=False;
  SetLength(Cartellino,0);

  DataCorr:=R180InizioMese(Parametri.DataLavoro);
  edtMese.Text:=FormatDateTime('mm/yyyy',DataCorr);

  Progressivo:=StrToIntDef(GetParam('PROGRESSIVO'),0);
  if Progressivo > 0 then
  begin
    grdC700.WC700FM.C700Progressivo:=Progressivo;
    grdC700.WC700FM.actConfermaExecute(nil);
  end;

  CaricaCartellino;
  Result:=True;
end;

procedure TWA047FTimbMensa.actStampaExecute(Sender: TObject);
begin
  WA047FDialogStampaFM:=TWA047FDialogStampaFM.Create(Self);
  WA047FDialogStampaFM.visualizza(DataCorr);
end;

procedure TWA047FTimbMensa.ApriGestGiust(Modifica: Boolean);
begin
  inherited;
  //non usato
end;

procedure TWA047FTimbMensa.ApriGestTimb(Modifica: Boolean);
var
  WA047FGestTimbFM: TWA047FGestTimbFM;
  vis:boolean;
  Ril: String;
begin
  inherited;
  if SolaLettura then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    Exit;
  end;

  if WA047FTimbMensaDM.A047FTimbMensaMW.selDatiBloccati.DatoBloccato(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger ,R180InizioMese(DataOperazione),'T370') then
  begin
    MsgBox.WebMessageDlg(WA047FTimbMensaDM.A047FTimbMensaMW.selDatiBloccati.MessaggioLog,mtError,[mbOK],nil,'');
    Exit;
  end;
  //Chiamata: 83085
  if modifica then
  begin
    Ril:=WA047FTimbMensaDM.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FTimbrature[R180Giorno(DataOperazione),NumeroElemento].Rilevatore;

    if not A000FiltroDizionario('OROLOGI DI TIMBRATURA',Ril) then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_RILEVATORE_DIZIONARIO,mtError,[mbOK],nil,'');
      Exit;
    end;
  end;

  WA047FGestTimbFM:=TWA047FGestTimbFM.Create(Self);
  WA047FGestTimbFM.A000FGestioneTimbraGiustMW:=WA047FTimbMensaDM.A047FTimbMensaMW.A000FGestioneTimbraGiustMW;

  if modifica then
    vis:=WA047FGestTimbFM.ModificaTimbratura(DataOperazione,NumeroElemento)
  else
    vis:=WA047FGestTimbFM.InserisciTimbratura(DataOperazione);

  if vis then
  begin
    grdCartellino.Visible:=False;
    WA047FGestTimbFM.Visualizza()
  end
  else
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_OPERAZIONE_NON_CONSENTITA,mtError,[mbOK],nil,'');
    WA047FGestTimbFM.ReleaseOggetti;
    FreeAndNil(WA047FGestTimbFM);
  end;
end;

procedure TWA047FTimbMensa.AttivaConteggi;
begin
  inherited;
  WA047FTimbMensaDM.A047FTimbMensaMW.R300FAccessiMensaDtM.SettaPeriodo(R180InizioMese(DataCorr),R180FineMese(DataCorr));
end;

procedure TWA047FTimbMensa.GestNuovoAccesso;
var
  WA047FAccessoManualeFM: TWA047FAccessoManualeFM;
begin
  WA047FAccessoManualeFM:=TWA047FAccessoManualeFM.Create(Self);
  WA047FAccessoManualeFM.Data:=DataOperazione;
  WA047FAccessoManualeFM.visualizza;
end;

procedure TWA047FTimbMensa.btnNuovoAccessoClick(Sender: TObject);
begin
  inherited;
  GestNuovoAccesso;
end;

procedure TWA047FTimbMensa.CaricaCartellino;
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
  WA047FTimbMensaDM.A047FTimbMensaMW.caricaMese(R180Anno(DataCorrente),R180Mese(DataCorrente),actConteggi.Checked);

  //cartellino da indice 1 a giorniMese. Cosi allineato con grid che ha intestazione
  setLength(Cartellino,giorniMese+1);
  for i:=1 to High(Cartellino) do
  begin
    Cartellino[i].Data:=DataCorrente;
    ImpostaDaCalendario(DataCorrente,i);

    DataCorrente:=DataCorrente+1;
  end;
  CaricaGrid;
end;

procedure TWA047FTimbMensa.CaricaGrid;
var
  day, c: Integer;
  lnkTmp: TmeIWLink;
  conteggi: TConteggiPasti;
  grdConteggi: TMeIWGrid;
begin
  // Deallocazione controlli della griglia e pulizia dati
  C190PulisciIWGrid(grdCartellino,True);

  lblCartellinoCaption.Caption:='Timbrature mensa del mese di ' + FormatDateTime('mmmm yyyy',DataCorr);

  //Caricamento Grid
  grdCartellino.RowCount:=Length(Cartellino);
  grdCartellino.ColumnCount:=4;
  if ActConteggi.Checked then
    grdCartellino.ColumnCount:=grdCartellino.ColumnCount + 1;
  c:=0;

  //intestazione
  grdCartellino.Cell[0,c].Text:='Data';
  grdCartellino.Cell[0,c].Css:='width5chr';
  inc(c);

  grdCartellino.Cell[0,c].Text:='Timbrature';
  inc(c);

  grdCartellino.Cell[0,c].Text:='Accessi manuali';
  grdCartellino.Cell[0,c].Css:='width40chr';
  inc(c);

  grdCartellino.Cell[0,c].Text:='Giustificativi';
  grdCartellino.Cell[0,c].Css:='width40chr';
  inc(c);

  if ActConteggi.Checked then
  begin
    grdCartellino.Cell[0,c].Text:='Conteggi';
    grdCartellino.Cell[0,c].Css:='width10chr';
  end;

  //Dati cartellino
  for day:=1 to High(Cartellino) do
  begin
    if ActConteggi.Checked then
      conteggi:=ConteggiGiorno(Cartellino[day].Data);

    c:=0;
    with grdCartellino.Cell[day,c] do
    begin
      Css:=CssSfondoGiorno(Cartellino[day]);

      lnkTmp:=TmeIWLink.Create(Self);
      Control:=lnkTmp;
      impostaLinkGiorno(lnkTmp,Cartellino[day]);
    end;
    inc(c);

    //Timbrature
    CreaGrdTimbrature(day,c);
    inc(c);

    CreaGrdAccessi(day,c);
    inc(c);
    //Giustificativi
    CreaGrdGiustificativi(day,c);
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
        ColumnCount:=1;
        RowCount:=1;
      end;
      //componente label
      with grdConteggi.Cell[0,0] do
      begin
        Control:=TmeIWLabel.Create(Self);
      end;
      with (grdConteggi.Cell[0,0].Control as TmeIWLabel) do
      begin
        FriendlyName:='contPasti' + IntToStr(day);
        Name:=FriendlyName;
        Caption:=IntToStr(conteggi.PastiCon);
        if conteggi.PastiInt > 0 then
          Caption:=Caption + ' - ' + IntToStr(conteggi.PastiInt);
        Hint:='Pasti';
        Css:='conteggio font_neroImp';
      end;
    end;
  end;
end;

procedure TWA047FTimbMensa.ImpostaEditAccesso(var edt:TmeIWEdit; AccessiMensa: TAccessiMensa;day,nAccesso:Integer);
begin
  with edt do
  begin
    //metto nel name il numero della timbratura. serve quando si va in modifica per sapere la timbratura da modificare
    FriendlyName:=NOMEACCESSO + IntToStr(nAccesso) + NOMEDAY + IntToStr(day);
    Name:=FriendlyName;
    Tag:=day;
    Text:=Format('%s=%s',[AccessiMensa.PranzoCena,AccessiMensa.Accessi.ToString]);
    ReadOnly:=True;
    Css:='width3chr font11';

    RenderSize:=False;
    Font.Enabled:=False;
    if (not SolaLettura) then
    begin
      if (pmnAccesso.Items.Count > 0) then
        edt.medpContextMenu:=pmnAccesso;
    end;
  end;
end;

procedure TWA047FTimbMensa.ImpostaGrdAccessiGiorno (var grd: TmeIWGrid; var NumAccessi: Integer;day:Integer);
var
  nt: Integer;
begin
  with grd do
  begin
    Css:='gridComandi';
    FriendlyName:='ListaAccessi' + IntToStr(day);
    Name:=FriendlyName;

    if MaxAccessi < NumAccessi then
      NumAccessi:=MaxAccessi;

    //calcolo colonne: massimo TIMBXROW timbrature per riga + 2 componenti(edit per nuova timbratura e cella vuota per allineamento)
    nt:=NumAccessi;
    if nt > AccessiXRow then
      nt:=AccessiXRow;

    //Ogni accesso ha 3 elementi (pranzocena , rilevatore e causale) e una cella finale per allineamento a sx
    ColumnCount:=(nt * 3) + 1;
    //La cella nuovo accesso ha solo 1 edit
    if bCanNuovoAccesso then
      ColumnCount:=ColumnCount + 1;
    RowCount:=1 + ((NumAccessi - 1) div AccessiXRow );
  end;
end;

procedure TWA047FTimbMensa.CreaGrdAccessi(day,c: Integer);
var
  numAccessi,
  rowControl,
  colControl,
  j: Integer;
  AccessoMensa: TAccessiMensa;
  grdAccessiGiorno: TmeIWGrid;
  tmpEdt: TmeIWEdit;
  tmpLnk: TmeIWLink;
begin
  //Accessi
  NumAccessi:=0;
  grdCartellino.Cell[day,c].css:='riga_bianca';
  if (getNumeroAccessi(day) > 0) or (bCanNuovoAccesso) then
  begin
    grdAccessiGiorno:=TmeIWGrid.Create(Self);
    grdCartellino.Cell[day,c].Control:=grdAccessiGiorno;
    NumAccessi:=getNumeroAccessi(day);

    //Imposta grid che contiene le timbrature
    ImpostaGrdAccessiGiorno(grdAccessiGiorno,
                            NumAccessi,
                            day);
    // accessi
    colControl:=0;
    rowControl:=0;
    for j:=0 to NumAccessi - 1 do
    begin
      AccessoMensa:=getAccessoMensa(day,j + 1);
      // componente edit per ora timbratura
      with grdAccessiGiorno.Cell[rowControl,colControl] do
      begin
        tmpEdt:=TmeIWEdit.Create(Self);
        Control:=tmpEdt;
        Css:='width3chr';
      end;
      ImpostaEditAccesso(tmpEdt, AccessoMensa,day,j+1);
      inc(ColControl);

      //componente label per rilevatore
      with grdAccessiGiorno.Cell[rowControl,colControl] do
      begin
        tmpLnk:=TmeIWLink.Create(Self);
        Control:=tmpLnk;
        Css:='cellaRil';
      end;

      ImpostaLinkRilevatore(tmpLnk,AccessoMensa.Rilevatore);
      inc(ColControl);

      //componente label per causale
      with grdAccessiGiorno.Cell[rowControl,colControl] do
      begin
        tmpLnk:=TmeIWLink.Create(Self);
        Control:=tmpLnk;
        Css:='cellaCausale';
      end;

      ImpostaLinkCausale(tmpLnk, nil,Trim(AccessoMensa.Causale));

      inc(ColControl);
      if (rowControl < grdAccessiGiorno.rowCount - 1 ) and (colControl > (AccessiXRow * 3) - 1) then
      begin
        colControl:=0;
        inc(rowControl);
      end;
    end;

    if bCanNuovoAccesso then
    begin
      // componente edit
      with grdAccessiGiorno.Cell[rowControl,colControl] do
      begin
        Control:=TmeIWEdit.Create(Self);
        Css:='width3chr';
      end;
      with (grdAccessiGiorno.Cell[rowControl,colControl].Control as TmeIWEdit) do
      begin
        FriendlyName:=NOMEACCESSO + IntToStr(numAccessi+1) + NOMEDAY + IntToStr(day);
        Name:=FriendlyName;
        Tag:=day;
        Text:='';
        Css:='width3chr font11';
        Hint:='Nuovo accesso mensa';
        ReadOnly:=True;
        onAsyncDoubleClick:=edtNuovoAccessoAsyncDoubleClick;
        medpContextMenu:=pmnNuovoAccesso;
        RenderSize:=False;
        Font.Enabled:=False;
      end;
    end;
  end;
end;

function TWA047FTimbMensa.getGustificativo(day, i: Integer): TGiustificativi;
begin
  Result:=WA047FTimbMensaDM.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FGiustificativi[day,i];
end;

function TWA047FTimbMensa.getNumeroGiustificativi(day: Integer): Byte;
begin
  Result:=WA047FTimbMensaDM.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FNumGiustif[day];
end;

function TWA047FTimbMensa.getNumeroTimbrature(day: Integer): Byte;
begin
  Result:=WA047FTimbMensaDM.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FNumTimbrature[day];
end;

function TWA047FTimbMensa.getTimbratura(day, i: Integer): TTimbrature;
begin
  Result:=WA047FTimbMensaDM.A047FTimbMensaMW.A000FGestioneTimbraGiustMW.FTimbrature[day,i];
end;

function TWA047FTimbMensa.getNumeroAccessi(day: Integer): Byte;
begin
  Result:=WA047FTimbMensaDM.A047FTimbMensaMW.FNumAccessi[day];
end;

function TWA047FTimbMensa.getAccessoMensa(day,i: Integer): TAccessiMensa;
begin
  Result:=WA047FTimbMensaDM.A047FTimbMensaMW.FAccessi[day,i];
end;

procedure TWA047FTimbMensa.ImpostaDaCalendario(Data:TDateTime;i:Integer);
{Cerco le caratteristiche del giorno su Calendario Individ/Tabella
(Festivo/Lavorativo)}
begin
  Cartellino[i].NonImpostato:=False;
  with WA047FTimbMensaDM.A047FTimbMensaMW do
  begin
    if Q012.Locate('Data',Data,[]) then {Calendario del dipendente}
    begin
      Cartellino[i].Festivo:=Q012.FieldByName('Festivo').AsString = 'S';
      Cartellino[i].Lavorativo:=Q012.FieldByName('Lavorativo').AsString = 'S';
    end
    else {Calendario in anagrafico}
    begin
      if not QSCalendario.LocDatoStorico(Data) then exit;
      Q011.Close;
      Q011.SetVariable('Codice',QSCalendario.FieldByName('T430CALENDARIO').AsString);
      Q011.SetVariable('DataInizio',Q012.GetVariable('DataInizio'));
      Q011.SetVariable('DataFine',Q012.GetVariable('DataFine'));
      Q011.Open;
      if Q011.Locate('Data',Data,[]) then
      begin
        Cartellino[i].Festivo:=Q011.FieldByName('Festivo').AsString = 'S';
        Cartellino[i].Lavorativo:=Q011.FieldByName('Lavorativo').AsString = 'S';
      end
      else
        Cartellino[i].NonImpostato:=True;
    end;
  end;
  Cartellino[i].Domenica:=DayOfWeek(Data) = 1;
end;

procedure TWA047FTimbMensa.WC700CambioProgressivo(Sender: TObject);
begin
  inherited;
  if WA047FTimbMensaDM <> nil then
    CaricaCartellino;
end;

procedure TWA047FTimbMensa.edtNuovoAccessoAsyncDoubleClick(Sender: TObject;
  EventParams: TStringList);
var btnName: String;
begin
  try
    if (not SolaLettura) then
    begin
      DataOperazione:=StrToDate(IntToStr((Sender as TmeIWEdit).Tag) + '/' + edtMese.Text);
      btnName:=btnNuovoAccesso.HTMLName;
      //Devo forzare un submit perchè non posso creare frame in async. Non esiste l'evento DoubleClick non in async
      GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnName]));
    end;
  except
  end;
end;

procedure TWA047FTimbMensa.ElaborazioneServer;
var
  DatiUtente: String;
  DettaglioLog:OleVariant;
begin
  //Elaborazione stampa. richiamato da DialogStampa startElaborazioneServer
  //Chiamo Servizio COM B028 per creare il pdf su server
    DCOMNomeFile:=GetNomeFile('pdf');
    ForceDirectories(ExtractFileDir(DCOMNomeFile));
    DatiUtente:=WA047FDialogStampaFM.CreateJSonString;
    if (not IsLibrary) and
       (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
      CoInitialize(nil);
    if not DCOMConnection.Connected then
      DCOMConnection.Connected:=True;
    try
      DCOMConnection.AppServer.PrintA047(grdC700.selAnagrafe.SubstitutedSQL,
                                         DCOMNomeFile,
                                         Parametri.Operatore,
                                         Parametri.Azienda,
                                         WR000DM.selAnagrafe.Session.LogonDataBase,
                                         DatiUtente,
                                         DettaglioLog);
    finally
      DCOMConnection.Connected:=False;
    end;
end;

end.
