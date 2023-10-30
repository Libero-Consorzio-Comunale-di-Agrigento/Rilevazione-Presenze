unit W005UCartellino;

interface

uses
  FunzioniGenerali,
  SysUtils, StrUtils, Classes, Graphics, Controls, IWApplication,
  R012UWEBANAGRAFICO, R500Lin, IWTemplateProcessorHTML, IWCompLabel,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  IWCompButton, OracleData, A000USessione, A000UInterfaccia, C180FunzioniGenerali,
  IWCompCheckbox, Rp502Pro, RegistrazioneLog, Variants, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWAppForm, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  R010UPAGINAWEB, IWVCLComponent, DatiBloccati,
  WC001ULegendaCalendarioFM, A023UAllTimbMW, meIWGrid,
  meIWEdit, Oracle, C190FunzioniGeneraliWeb, W005UCartellinoDtm, meIWLabel,
  IWCompGrids, meIWLink, meIWCheckBox, meIWComboBox, meIWButton, A023UTimbratureMW, WA023UValidaAssenzeFM,
  IW.Browser.InternetExplorer, A000UMessaggi, W000UMessaggi, IWCompExtCtrls, meIWImageFile,
  IWCompJQueryWidget, WC028URichiesteInCorsoFM;

const
  COL_F = 1;
  COL_G = 1;

type
  TTimbrature = record
    Ora:Integer;
    Verso:String;
    Causale:String;
    Ril:String;
    Flag:String;
    IdRichiesta:Integer;// commessa MAN/02 - SVILUPPO 92
    RowId:String;
  end;

  TGiustificativi = record
    Causale:String;
    Descrizione:String;
    Tipo:String;
    Dalle:Integer;
    Alle:Integer;
    RowId:String;
    Richiesta:Boolean;
    Validata:String;//S:Assenza Validata, N:Assenza da Validare,  :Assenza senza bisogno di validazione
    Note:String;
  end;

  TCartellino = record
    Data:TDateTime;
    Lavorativo:Boolean;
    Festivo:Boolean;
    Domenica:Boolean;
    Timbrature:array of TTimbrature;
    Giustificativi:array of TGiustificativi;
  end;

  TW005IWEdit = class(TmeIWEdit)
  public
    W005EdtGiorno:integer;
    W005EdtTimb:integer;
  end;

  TW005FCartellino = class(TR012FWebAnagrafico)
    btnEsegui: TmeIWButton;
    edtPeriodoDal: TmeIWEdit;
    edtPeriodoAl: TmeIWEdit;
    lblCausPresDisponibili: TmeIWLabel;
    cmbCausPresDisponibili: TmeIWComboBox;
    btnApplica: TmeIWButton;
    chkConteggi: TmeIWCheckBox;
    lblCausAssDisponibili: TmeIWLabel;
    cmbCausAssDisponibili: TmeIWComboBox;
    lblPeriodo: TmeIWLabel;
    lnkLegendaColoriGiorni: TmeIWLink;
    grdCartellino: TmeIWGrid;
    lblCartellinoCaption: TmeIWLabel;
    btnValidaAssenze: TmeIWButton;
    imgPeriodoPrec: TmeIWImageFile;
    imgPeriodoSucc: TmeIWImageFile;
    grdRiepilogoSaldi: TmeIWGrid;
    lblRiepilogoSaldiCaption: TmeIWLabel;
    lblUscitaNominaleGGCorr: TmeIWLabel;
    JQuery: TIWJQueryWidget;
    lnkMostraLegende: TmeIWLink;
    lnkLegende: TmeIWLink;
    lnkAggiorna: TmeIWLink;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure grdCartellinoRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure chkConteggiClick(Sender: TObject);
    procedure NuovaTimbraturaSubmit(Sender: TObject);
    procedure btnApplicaClick(Sender: TObject);
    procedure grdCartellinoCellClick(ASender: TObject; const ARow, AColumn: Integer);
    procedure lnkLegendaColoriGiorniClick(Sender: TObject);
    procedure btnValidaAssenzeClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure imgPeriodoPrecClick(Sender: TObject);
    procedure grdRiepilogoSaldiRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure lnkMostraLegendeClick(Sender: TObject);
    procedure lnkLegendeClick(Sender: TObject);
  private
    ColF: Integer;
    ColNuovaTimb: Integer;
    ColData: Integer;
    ColOrario: Integer;
    ColRichieste: Integer;
    ColGiust: Integer;
    Dal,Al:TDateTime;
    Cartellino:array of TCartellino;
    R502ProDtM1:TR502ProDtM1;
    lstAnomalie:TStringList;
    AbilGiustif,AbilPianif,AbilSegnalazioneTimb,OldResponsabile: Boolean;
    IWC:TIWCustomControl;
    A023FAllTimbW005:TA023FAllTimbMW;
    A023MW: TA023FTimbratureMW;
    WA023FValidaAssenzeFM: TWA023FValidaAssenzeFM;
    procedure MostraLegenda(Mostra:Boolean);
    procedure GetCausaliDisponibili;
    procedure VisualizzaCartellino;
    procedure WA023FValidaAssenzaFM_btnChiudiClick(Sender: TObject);
    procedure edtTimbraturaAsyncDoubleClickIns(Sender: TObject; EventParams: TStringList);
    procedure edtTimbraturaAsyncDoubleClickEdt(Sender: TObject; EventParams: TStringList);
  protected
    procedure RefreshPage; override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
    function  GetInfoFunzione: String; override;
  public
    W005Dtm: TW005FCartellinoDtm;
    bDettaglioGG: Boolean;
    bAbilitaHandlerModificaTimb: Boolean;
    procedure PublicRefresh;
    procedure InizializzaDaMainMenu;
    function ElaboraTimbratura(T,Oper:String; Giorno,Timb:Integer; Data:TDateTime):String;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses
  W008UGiustificativi,
  W010URichiestaAssenze,
  W018URichiestaTimbrature,
  W023UPianifOrari,
  W005UGestTimbFM;

{$R *.DFM}

procedure TW005FCartellino.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  // salva il flag responsabile in una variabile per eventuale ripristino in chiusura
  // (se la form non viene aggiunta alla history)
  OldResponsabile:=WR000DM.Responsabile;

  W005Dtm:=TW005FCartellinoDtm.Create(nil);
  bDettaglioGG:=False;
  bAbilitaHandlerModificaTimb:=True;

  if WR000DM.TipoUtente <> 'Dipendente' then
    R502ProDtM1:=TR502ProDtM1.Create(Self);
  lstAnomalie:=TStringList.Create;

  // inizializzazione causali disponibili
  GetCausaliDisponibili;

  AbilGiustif:=(A000GetInibizioni('Funzione','OpenW008Giustificativi') <> 'N') or
               (A000GetInibizioni('Funzione','OpenW010RichiestaAssenze') <> 'N') or
               (WR000DM.Responsabile and (A000GetInibizioni('Funzione','OpenW010AutorizzAssenze') <> 'N'));
  AbilPianif:=A000GetInibizioni('Tag','425') <> 'N';
  AbilSegnalazioneTimb:=(A000GetInibizioni('Tag',IfThen(Parametri.InibizioneIndividuale,'418','419')) <> 'N');

  btnApplica.Visible:=(not SolaLettura);
  btnValidaAssenze.Visible:=(not SolaLettura);

  //chkConteggi.Checked:=True; // solo per debug!!!
  SelezionePeriodica:=True;

  with WR000DM do
  begin
    selT265.Tag:=selT265.Tag + 1;
    selT275.Tag:=selT275.Tag + 1;
  end;

  // imposta la gestione automatica degli spostamenti di periodo
  AssegnaGestPeriodo(edtPeriodoDal,edtPeriodoAl,imgPeriodoPrec,imgPeriodoSucc,imgPeriodoPrecClick,imgPeriodoPrecClick);

  A023MW:=TA023FTimbratureMW.Create(Self);
  Mostralegenda(False);
end;

procedure TW005FCartellino.InizializzaDaMainMenu;
//Inizializzazioni parametri se chiamata dal menu principale
begin
  if StrToIntDef(Parametri.CampiRiferimento.C90_W005Settimane,0) > 0 then
  begin
    Dal:=Parametri.DataLavoro - (DayOfWeek(Parametri.DataLavoro - 1) - 1);
    Dal:=Dal - ((StrToIntDef(Parametri.CampiRiferimento.C90_W005Settimane,0) - 1) * 7);
    Al:=Parametri.DataLavoro + (7 - DayOfWeek(Parametri.DataLavoro - 1));
  end
  else
  begin
    Dal:=R180InizioMese(Parametri.DataLavoro);
    Al:=R180FineMese(Parametri.DataLavoro);
  end;
  SetParam('DAL',Dal);
  SetParam('AL',Al);
  SetParam('SINGOLO',False);
end;

function TW005FCartellino.InizializzaAccesso:Boolean;
var
  Trovato: Boolean;
begin
  Result:=True;
  if bDettaglioGG then
    SolaLettura:=True;

  // imposta periodo visualizzazione in base a parametro aziendale
  Dal:=ParametriForm.Dal;
  Al:=ParametriForm.Al;
  edtPeriodoDal.Text:=DateToStr(Dal);
  edtPeriodoAl.Text:=DateToStr(Al);

  selAnagrafeW.Filter:='PROGRESSIVO = ' + IntToStr(ParametriForm.Progressivo);
  selAnagrafeW.Filtered:=ParametriForm.Singolo;
  // selezione dipendenti periodica
  // (solo se utente supervisore oppure dipendente con filtro anagrafe impostato)
  if (WR000DM.TipoUtente = 'Dipendente') and
     (Parametri.Inibizioni.Text = '') then
    GetDipendentiDisponibili(Al)
  else
    GetDipendentiDisponibili(Dal,Al);
  Trovato:=selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);
  // chiamata da dettaglio giornaliero
  if (bDettaglioGG) and (not Trovato) then
    raise Exception.Create('Il dipendente selezionato non è presente nel proprio filtro anagrafe.'#13#10'Impossibile visualizzare il dettaglio!');

  VisualizzaDipendenteCorrente;
end;

procedure TW005FCartellino.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(A023MW);
  // se la form non è aggiunta alla history, ripristina il flag responsabile originale
  if not medpAddToHistory then
    if WR000DM <> nil then
      WR000DM.Responsabile:=OldResponsabile;
  inherited;
end;

procedure TW005FCartellino.PublicRefresh;
begin
  WR000DM.selT265.Filtered:=False;
  WR000DM.selT275.Filtered:=False;
  VisualizzaDipendenteCorrente;
  if chkConteggi.Checked then
    chkConteggiClick(nil);
end;

procedure TW005FCartellino.RefreshPage;
begin
  PublicRefresh;
end;

procedure TW005FCartellino.MostraLegenda(Mostra:Boolean);
begin
  lblCausPresDisponibili.Css:=C190ImpostaCssInvisibile(lblCausPresDisponibili.Css, Mostra);
  cmbCausPresDisponibili.Css:=C190ImpostaCssInvisibile(cmbCausPresDisponibili.Css, Mostra);
  lblCausAssDisponibili.Css:=C190ImpostaCssInvisibile(lblCausAssDisponibili.Css, Mostra);
  cmbCausAssDisponibili.Css:=C190ImpostaCssInvisibile(cmbCausAssDisponibili.Css, Mostra);
  lnkLegendaColoriGiorni.Css:=C190ImpostaCssInvisibile(lnkLegendaColoriGiorni.Css, Mostra);
  lnkMostraLegende.Css:=C190ImpostaCssInvisibile(lnkMostraLegende.Css, not Mostra);
  C190VisualizzaElemento(JQuery,'grpLegenda',Mostra);
end;

procedure TW005FCartellino.btnEseguiClick(Sender: TObject);
var PeriodoCambiato:Boolean;
begin
  try
    PeriodoCambiato:=(Dal <> StrToDate(edtPeriodoDal.Text)) or (Al <> StrToDate(edtPeriodoAl.Text));
    Dal:=StrToDate(edtPeriodoDal.Text);
    Al:=StrToDate(edtPeriodoAl.Text);
    if Al < Dal then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_ERRATO));
    if Al - Dal >= 366 then
      raise Exception.Create(A000TraduzioneStringhe(A000MSG_ERR_PERIODO_LUNGO));
    if Dal < Parametri.WEBCartelliniDataMin then
    begin
      GGetWebApplicationThreadVar.ShowMessage(Format(A000TraduzioneStringhe(A000MSG_W005_ERR_FMT_STOP_DATA_ANTECEDENTE),[DateToStr(Parametri.WEBCartelliniDataMin)]));
      PeriodoCambiato:=True;
      Dal:=Parametri.WEBCartelliniDataMin;
      edtPeriodoDal.Text:=DateToStr(Dal);
      if Al < Dal then
      begin
        Al:=Dal;
        edtPeriodoAl.Text:=DateToStr(Al);
      end;
    end;
  except
    on E:Exception do
    begin
      GGetWebApplicationThreadVar.ShowMessage(E.Message);
      exit;
    end;
  end;

  if PeriodoCambiato then
  begin
    // salva parametri form
    ParametriForm.Dal:=Dal;
    ParametriForm.Al:=Al;

    // effettua selezione dipendenti periodica nei seguenti due casi:
    // a. utente supervisore oppure
    // b. dipendente con filtro anagrafe impostato
    if (WR000DM.TipoUtente = 'Dipendente') and
       (Trim(Parametri.Inibizioni.Text) = '') then
      GetDipendentiDisponibili(Al)
    else
      GetDipendentiDisponibili(Dal,Al);
  end;

  lstAnomalie.Clear;
  VisualizzaDipendenteCorrente;
end;

procedure TW005FCartellino.btnValidaAssenzeClick(Sender: TObject);
var i,j:Integer;
    StrCaus:String;
begin
  for i:=0 to High(Cartellino) do
    for j:=0 to High(Cartellino[i].Giustificativi) do
      if (Cartellino[i].Giustificativi[j].Causale <> '')
      and (Cartellino[i].Giustificativi[j].Validata = 'N')
      and (A000FiltroDizionario('CAUSALI ASSENZA',Cartellino[i].Giustificativi[j].Causale))
      and (Pos(',' + Cartellino[i].Giustificativi[j].Causale + ',',',' + StrCaus + ',') <= 0) then
        StrCaus:=StrCaus + IfThen(StrCaus <> '',',') + Cartellino[i].Giustificativi[j].Causale;
  WA023FValidaAssenzeFM:=TWA023FValidaAssenzeFM.Create(Self);
  WA023FValidaAssenzeFM.A023MW:=A023MW;
  WA023FValidaAssenzeFM.btnChiudi.OnClick:=WA023FValidaAssenzaFM_btnChiudiClick;
  WA023FValidaAssenzeFM.Visualizza(ParametriForm.Progressivo,Dal,Al,StrCaus);
end;

procedure TW005FCartellino.WA023FValidaAssenzaFM_btnChiudiClick(Sender: TObject);
begin
  inherited;
  if WA023FValidaAssenzeFM.ElaborazioneEseguita then
    btnEseguiClick(nil);
  WA023FValidaAssenzeFM.Free;
end;

procedure TW005FCartellino.GetCausaliDisponibili;
begin
  with WR000DM do
  begin
    // causali di presenza
    cmbCausPresDisponibili.Items.Clear;
    selT275.Close;
    selT275.Filtered:=False;
    selT275.Open;
    while not selT275.Eof do
    begin
      cmbCausPresDisponibili.Items.Add(StringReplace(Format('%-5s %s',[selT275.FieldByName('CODICE').AsString,selT275.FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      selT275.Next;
    end;
    cmbCausPresDisponibili.RequireSelection:=cmbCausPresDisponibili.Items.Count > 0;

    // causali di assenza
    cmbCausAssDisponibili.Items.Clear;
    selT265.Close;
    selT265.Filtered:=False;
    selT265.Open;
    while not selT265.Eof do
    begin
      cmbCausAssDisponibili.Items.Add(StringReplace(Format('%-5s %s',[selT265.FieldByName('CODICE').AsString,selT265.FieldByName('DESCRIZIONE').AsString]),' ',SPAZIO,[rfReplaceAll]));
      selT265.Next;
    end;
    //CloseAll;
    //R180CloseDataSetTag0(WR000DM.selT265);
  end;
  cmbCausAssDisponibili.RequireSelection:=cmbCausAssDisponibili.Items.Count > 0;
end;

procedure TW005FCartellino.VisualizzaDipendenteCorrente;
begin
  inherited;
  // salva parametri
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  // timbrature
  W005DtM.selT100.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W005DtM.selT100.SetVariable('DAL',Dal);
  W005DtM.selT100.SetVariable('AL',Al);
  W005DtM.selT100.Close;
  W005DtM.selT100.Open;

  // giustificativi
  W005DtM.selT040.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W005DtM.selT040.SetVariable('DAL',Dal);
  W005DtM.selT040.SetVariable('AL',Al);
  W005DtM.selT040.Close;
  W005DtM.selT040.Open;

  //giustificativi non ancora elaborati
  W005DtM.selT050.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W005DtM.selT050.SetVariable('DAL',Dal);
  W005DtM.selT050.SetVariable('AL',Al);
  W005DtM.selT050.Close;
  W005DtM.selT050.Open;

  //calendari
  W005DtM.selV010.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W005DtM.selV010.SetVariable('DAL',Dal);
  W005DtM.selV010.SetVariable('AL',Al);
  W005DtM.selV010.Close;
  W005DtM.selV010.Open;

  A023MW.CaricaRichieste(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Dal,Al);

  VisualizzaCartellino;
end;

procedure TW005FCartellino.VisualizzaCartellino;
var D:TDateTime;
    i,j,c,MaxT,MaxG,NumGiust:Integer;
    Timbratura,Causale,Rilevatore,Durata,ElencoGiust:String;
    Validaz,anm:String;
    TotOreReseTotali,TotDebitoGg,TotScost,TotMinLavEsc:Integer;
    LCell: TIWGridCell;
  function GetTurno(Data:TDateTime):String;
  begin
    Result:='';
    if (R502ProDtM1.c_turni1 = -1) then
    begin
      if (R502ProDtM1.r_turno1 > 0) or (R502ProDtM1.r_turno1 = -8) then
      begin
        Result:=Format('%2s',[IntToStr(R502ProDtM1.r_turno1)]);
        if R502ProDtM1.r_turno2 > 0 then
          Result:=Result + Format('%2s',[IntToStr(R502ProDtM1.r_turno2)]);
      end;
    end
    else
    begin
      with W005DtM.selT080 do
        if SearchRecord('Data',Data,[srFromBeginning]) then
          Result:=Format('%2s%1s%2s%1s',[FieldByName('Turno1').AsString,FieldByName('Turno1EU').AsString,
                                         FieldByName('Turno2').AsString,FieldByName('Turno2EU').AsString]);
    end;
    if Trim(Result) <> '' then
      Result:=' (' + Trim(Result) + ')';
  end;
  function GetAnomalieCSI:String;
  var i:Integer;
  begin
    Result:='';
    if (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
      with R502ProDtM1 do
      begin
        for i:=0 to lstAnomalieGG.Count - 1 do
        begin
          if (lstAnomalieGG[i].Livello = 1) and (lstAnomalieGG[i].Num in [2]) then
            Result:=Result + IfThen(Result <> '','<br/>') + lstAnomalieGG[i].Descrizione
          else if (lstAnomalieGG[i].Livello = 2) and (lstAnomalieGG[i].Num in [22,31]) then
            Result:=Result + IfThen(Result <> '','<br/>') + lstAnomalieGG[i].Descrizione
          else if (lstAnomalieGG[i].Livello = 3) and (lstAnomalieGG[i].Num in [6,9]) then
            Result:=Result + IfThen(Result <> '','<br/>') + lstAnomalieGG[i].Descrizione
        end;
      end;
  end;
begin
  WR000DM.selT361.Open;
  //Inizializzazione tabella in memoria
  for i:=0 to High(Cartellino) do
  begin
    SetLength(Cartellino[i].Timbrature,0);
    SetLength(Cartellino[i].Giustificativi,0);
  end;
  SetLength(Cartellino,Trunc(Al - Dal) + 1);
  with TOracleQuery.Create(Self) do
  begin
    try
      Session:=SessioneOracle;
      SQL.Clear;
      SQL.Add('SELECT MAX(MAXTIMB)');
      SQL.Add('FROM(');
      SQl.Add('SELECT T100.DATA, COUNT(*) AS MAXTIMB');
      SQL.Add('FROM T100_TIMBRATURE T100');
      SQL.Add('WHERE T100.DATA BETWEEN :INDATADA AND :INDATAA');
      SQL.Add('AND T100.PROGRESSIVO = :INPROG');
      SQL.Add('GROUP BY T100.DATA)');
      DeclareVariable('INDATADA',otDate);
      DeclareVariable('INDATAA',otDate);
      DeclareVariable('INPROG',otInteger);
      SetVariable('INDATADA',Dal);
      SetVariable('INDATAA',Al);
      SetVariable('INPROG',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      Execute;
      MaxT:=FieldAsInteger(0);
    finally
      Free;
    end;
  end;

  btnValidaAssenze.Enabled:=False;
  MaxG:=0;
  //Lettura dati in memoria
  D:=Dal;
  i:=0;
  if chkConteggi.Checked then
  begin
    // uso di ResettaProg.ini
    // (non applicato per errori di access violation)
    if R502ProDtM1 = nil then
      R502ProDtM1:=TR502ProDtM1.Create(Self);
    //R502ProDtM1.ResettaProg;
    // utilizzo di ResettaProg.fine

    R502ProDtM1.ConsideraRichiesteWeb:=Parametri.ModuloInstallato['TORINO_CSI_PRV'];
    R502ProDtM1.PeriodoConteggi(Dal,Dal - 1);
    R502ProDtM1.PeriodoConteggi(Dal,Al);

    // apertura dataset della pianif. orari
    with W005DtM.selT080 do
    begin
      Close;
      SetVariable('Progressivo',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
      SetVariable('DataInizio',Dal);
      SetVariable('DataFine',Al);
      Open;
    end;
  end;
  while D <= Al do
  begin
    Cartellino[i].Data:=D;
    Cartellino[i].Domenica:=DayOfWeek(D) = 1;
    Cartellino[i].Lavorativo:=False;
    Cartellino[i].Festivo:=False;
    // calendario
    with W005DtM.selV010 do
    begin
      if SearchRecord('Data',D,[srFromBeginning]) then
      begin
        Cartellino[i].Lavorativo:=FieldByName('LAVORATIVO').AsString = 'S';
        Cartellino[i].Festivo:=FieldByName('FESTIVO').AsString = 'S';
      end;
    end;
    // timbrature
    with W005DtM.selT100 do
    begin
      if SearchRecord('Data',D,[srFromBeginning]) then
      begin
        j:=0;
        repeat
          SetLength(Cartellino[i].Timbrature,j + 1);
          Cartellino[i].Timbrature[j].RowId:=RowId;
          Cartellino[i].Timbrature[j].Ora:=R180OreMinuti(FieldByName('ORA').AsDateTime);
          Cartellino[i].Timbrature[j].Verso:=FieldByName('VERSO').AsString;
          Cartellino[i].Timbrature[j].Causale:=FieldByName('CAUSALE').AsString;
          Cartellino[i].Timbrature[j].Ril:=FieldByName('RILEVATORE').AsString;
          Cartellino[i].Timbrature[j].Flag:=FieldByName('FLAG').AsString;
          Cartellino[i].Timbrature[j].IdRichiesta:=FieldByName('ID_RICHIESTA').AsInteger; // commessa MAN/02 - SVILUPPO 92
          inc(j);
        until not SearchRecord('Data',D,[]);
      end;
    end;
    // giustificativi
    with W005DtM.selT040 do
    begin
      if SearchRecord('Data',D,[srFromBeginning]) then
      begin
        j:=0;
        repeat
          //non visualizzo i giustificativi se non appartenenti al filtro dizionario
          if (not A000FiltroDizionario('CAUSALI SUL CARTELLINO',FieldByName('CAUSALE').AsString)) then
            Continue;
          SetLength(Cartellino[i].Giustificativi,j + 1);
          Cartellino[i].Giustificativi[j].RowId:=RowId;
          Cartellino[i].Giustificativi[j].Causale:=FieldByName('CAUSALE').AsString;
          Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT265.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
          if Trim(Cartellino[i].Giustificativi[j].Descrizione) = '' then
            Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT275.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
          Cartellino[i].Giustificativi[j].Tipo:=FieldByName('TIPOGIUST').AsString;
          Cartellino[i].Giustificativi[j].Dalle:=R180OreMinuti(FieldByName('DAORE').AsDateTime);
          Cartellino[i].Giustificativi[j].Alle:=R180OreMinuti(FieldByName('AORE').AsDateTime);
          Cartellino[i].Giustificativi[j].Richiesta:=False;
          Cartellino[i].Giustificativi[j].Note:=FieldByName('NOTE').AsString;
          Validaz:=VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('Causale').AsString,'VALIDAZIONE'));
          if (Validaz <> '') and (Validaz <> 'N') then
            if FieldByName('SCHEDA').AsString = 'V' then
              Cartellino[i].Giustificativi[j].Validata:='S'
            else
            begin
              Cartellino[i].Giustificativi[j].Validata:='N';
              btnValidaAssenze.Enabled:=True;
            end;
          inc(j);
        until not SearchRecord('Data',D,[]);
      end;
    end;
    // giustificativi non ancora elaborati
    with W005DtM.selT050 do
    begin
      First;
      while not Eof do
      begin
        //non viusalizzo i giustificativi se non appartenenti al filtro dizionario
        if (not A000FiltroDizionario('CAUSALI SUL CARTELLINO',FieldByName('CAUSALE').AsString)) then
        begin
          Next;
          Continue;
        end;
        if (D >= FieldByName('DAL').AsDateTime) and (D <= FieldByName('AL').AsDateTime) then
        begin
          if (Parametri.CampiRiferimento.C90_W010CausPres = 'S')
          and (VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('CAUSALE').AsString,'CODICE')) = '') then
            W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC','GC')
          else
            W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('GSIGNIFIC',VarToStr(WR000DM.selT265.Lookup('CODICE',FieldByName('CAUSALE').AsString,'GSIGNIFIC')));
          W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
          W005DtM.T010F_GGSIGNIFICATIVO.SetVariable('DATA',D);
          W005DtM.T010F_GGSIGNIFICATIVO.Execute;
          if (VarToStr(W005DtM.T010F_GGSIGNIFICATIVO.GetVariable('SIGNIFICATIVO')) = 'S') then
          begin
            SetLength(Cartellino[i].Giustificativi,Length(Cartellino[i].Giustificativi) + 1);
            j:=Length(Cartellino[i].Giustificativi) - 1;
            Cartellino[i].Giustificativi[j].RowId:=RowId;
            Cartellino[i].Giustificativi[j].Causale:=FieldByName('CAUSALE').AsString;
            Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT265.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
            if Trim(Cartellino[i].Giustificativi[j].Descrizione) = '' then
              Cartellino[i].Giustificativi[j].Descrizione:=VarToStr(WR000DM.selT275.LookUp('CODICE',Cartellino[i].Giustificativi[j].Causale,'DESCRIZIONE'));
            Cartellino[i].Giustificativi[j].Tipo:=FieldByName('TIPOGIUST').AsString;
            Cartellino[i].Giustificativi[j].Dalle:=R180OreMinutiExt(FieldByName('NUMEROORE').AsString);
            Cartellino[i].Giustificativi[j].Alle:=R180OreMinutiExt(FieldByName('AORE').AsString);
            Cartellino[i].Giustificativi[j].Richiesta:=True;
          end;
        end;
        Next;
      end;
    end;
    if Length(Cartellino[i].Timbrature) > MaxT then
      MaxT:=Length(Cartellino[i].Timbrature);
    if Length(Cartellino[i].Giustificativi) > MaxG then
      MaxG:=Length(Cartellino[i].Giustificativi);
    D:=D + 1;
    inc(i);
  end;
  // Deallocazione controlli della griglia e pulizia dati
  for i:=0 to grdCartellino.RowCount - 1 do
  begin
    for j:=0 to grdCartellino.ColumnCount - 1 do
    begin
      if grdCartellino.Cell[i,j].Control <> nil then
      begin
        IWC:=grdCartellino.Cell[i,j].Control;
        grdCartellino.Cell[i,j].Control:=nil;
        FreeAndNil(IWC);
      end;
      grdCartellino.Cell[i,j].Css:='';
      grdCartellino.Cell[i,j].Clickable:=False;
      grdCartellino.Cell[i,j].Text:='';
    end;
  end;

  if (chkConteggi.Checked) and (Parametri.ModuloInstallato['TORINO_CSI_PRV']) then
  begin
    lstAnomalie.Add('AnomalieCSI');
  end;

  // Caricamento della griglia
  grdCartellino.RowCount:=Trunc(Al - Dal) + 2;
  ColF:=COL_F + IfThen(lstAnomalie.Count > 0,1) +
        IfThen(chkConteggi.Checked,2) +
        1 +
        IfThen((not SolaLettura) and (Parametri.InserisciTimbrature = 'S'),1);
  grdCartellino.ColumnCount:=ColF + COL_G + 1;

  // caption tabella
  if (Dal = R180InizioMese(Dal)) and (Al = R180FineMese(Dal)) then
    lblCartellinoCaption.Caption:='Cartellino del mese di ' + FormatDateTime('mmmm yyyy',Dal)
  else
    lblCartellinoCaption.Caption:=Format('Cartellino dal %s al %s',[edtPeriodoDal.Text,edtPeriodoAl.Text]);

  // intestazione
  c:=0;

  // data
  ColData:=c;
  grdCartellino.Cell[0,c].Text:='Data';
  grdCartellino.Cell[0,c].Css:='';
  inc(c);

  // anomalie
  if (lstAnomalie.Count > 0) then
  begin
    grdCartellino.Cell[0,c].Text:='Anomalie';
    grdCartellino.Cell[0,c].Css:='';
    inc(c);
  end;

  // richieste in corso
  ColRichieste:=c;
  grdCartellino.Cell[0,c].Text:='Richieste';
  grdCartellino.Cell[0,c].Css:='width5chr';
  inc(c);

  // conteggi
  ColOrario:=-1;
  if (chkConteggi.Checked) then
  begin
    grdCartellino.Cell[0,c].Text:='Saldo gg';
    grdCartellino.Cell[0,c].Css:='';
    inc(c);

    ColOrario:=c;
    grdCartellino.Cell[0,c].Text:='Orario';
    grdCartellino.Cell[0,c].Css:='';
    inc(c);
  end;

  // giustificativi
  ColGiust:=c;
  grdCartellino.Cell[0,c].Text:='Giustificativi';
  grdCartellino.Cell[0,c].Css:='';
  inc(c);

  // cella per nuova timbratura
  ColNuovaTimb:=-1;
  if (not SolaLettura) and (Parametri.InserisciTimbrature = 'S') then
  begin
    ColNuovaTimb:=c;
    grdCartellino.Cell[0,c].Text:='Nuova';
    inc(c);
  end;

  // timbrature
  grdCartellino.Cell[0,C].Text:='Timbrature';

  // dati
  TotOreReseTotali:=0;
  TotDebitoGg:=0;
  TotScost:=0;
  TotMinLavEsc:=0;
  for i:=0 to High(Cartellino) do
  begin
    with Cartellino[i] do
    begin
      c:=0;
      // data
      with grdCartellino.Cell[i + 1,c] do
      begin
        Text:=FormatDateTime('dd/mm',Data) + Format(' (%s)',[Copy(FormatDateTime('dddd',Data),1,2)]);
        Hint:=IntToStr(Trunc(Data));
        ShowHint:=False;
        Clickable:=(ParametriForm.Chiamante <> 'W018') and  // evita loop tra form
                   (AbilSegnalazioneTimb) and
                   (Data <= Trunc(Date)) and
                   not bDettaglioGG;
        Css:='bg_trasparente';
        if Festivo and (not Lavorativo) then
          Css:='bg_aqua'
        else if Festivo then
          Css:='bg_giallo'
        else if not Lavorativo then
          Css:='bg_lime';
        Css:=Css + ' ' + IfThen(Domenica,'font_rosso','comandi');
      end;
      inc(c);

      //Richiamo conteggi e carico eventuali anomalie da visualizzare (per TORINO_CSI)
      if (chkConteggi.Checked) then
      begin
        R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data);
        anm:=GetAnomalieCSI;
        if anm <> '' then
          lstAnomalie.Add(Format('%s=%s',[DateToStr(Data),anm]));
      end;

      // anomalie
      if (lstAnomalie.Count > 0) then
      begin
        with grdCartellino.Cell[i + 1,c] do
        begin
          if (lstAnomalie.IndexOfName(DateToStr(Data)) >= 0) then
          begin
            Hint:='Anomalia';
            ShowHint:=True;
            Text:=lstAnomalie.Values[DateToStr(Data)];
            Css:='segnalazione';
          end
          else
          begin
            Text:='';
            Css:='comandi';
          end;
        end;
        inc(c);
      end;

      // richieste in corso
      LCell:=grdCartellino.Cell[i + 1,c];
      Assert(not A023MW.selVT105.Filtered, 'selVT105 è filtrato!!!');
      Assert(not A023MW.selVT050.Filtered, 'selVT050 è filtrato!!!');
      LCell.Visible:=A023MW.selVT105.Locate('Data',Cartellino[i].Data,[]) or
                     A023MW.selVT050.Locate('Data',Cartellino[i].Data,[]);
      if LCell.Visible then
      begin
        LCell.Alignment:=TAlignment.taCenter;
        LCell.RawText:=True;
        // in base ad un parametro attiva o meno l'accesso all'elenco richieste
        LCell.Text:=Format('<img class="icona displayBlock" src="img/btnElenco2%s.png" title="%s" alt="Richieste in corso" />',
                           [IfThen(not bAbilitaHandlerModificaTimb,'_Disabled'),
                            IfThen(bAbilitaHandlerModificaTimb,'Visualizza richieste in corso')]);
        LCell.Clickable:=bAbilitaHandlerModificaTimb;
      end;
      inc(c);

      // conteggi
      if (chkConteggi.Checked) then
      begin
        // PRE: conteggi già effettuati

        // daniloc. - allineamento automatico timbrature
        // in caso di errore di tipo "timbrature non in sequenza"
        if R502ProDtM1.Blocca = 2 then
        begin
          // crea oggetto per allineamento timbrature uguali
          A023FAllTimbW005:=TA023FAllTimbMW.Create(nil);
          try
            try
              // allineamento timbrature
              A023FAllTimbW005.Q100.Session:=SessioneOracle;
              A023FAllTimbW005.Q100Upd.Session:=SessioneOracle;
              A023FAllTimbW005.Allinea(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,Data);

              // timbrature
              with W005DtM.selT100 do
              begin
                Refresh;
                if SearchRecord('Data',Data,[srFromBeginning]) then
                begin
                  j:=0;
                  repeat
                    SetLength(Cartellino[i].Timbrature,j + 1);
                    Cartellino[i].Timbrature[j].RowId:=RowId;
                    Cartellino[i].Timbrature[j].Ora:=R180OreMinuti(FieldByName('ORA').AsDateTime);
                    Cartellino[i].Timbrature[j].Verso:=FieldByName('VERSO').AsString;
                    Cartellino[i].Timbrature[j].Causale:=FieldByName('CAUSALE').AsString;
                    Cartellino[i].Timbrature[j].Ril:=FieldByName('RILEVATORE').AsString;
                    Cartellino[i].Timbrature[j].Flag:=FieldByName('FLAG').AsString;
                    inc(j);
                  until not SearchRecord('Data',Data,[]);
                end;
              end;

              R502ProDtM1.ResettaProg;
              R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data);
            except
              on E:Exception do
                Log('Errore','Allineamento timbrature uguali: ' + E.ClassName + '/' + E.Message);
            end;
          finally
            try FreeAndNil(A023FAllTimbW005); except end;
          end;
        end;
        // allineamento automatico timbrature.fine

        // saldi gg
        with grdCartellino.Cell[i + 1,c] do
        begin
          Hint:='';
          ShowHint:=False;
          Css:='conteggi' + ' ' + 'align_right';
          TotDebitoGg:=TotDebitoGg + R502ProDtM1.debitogg;
          TotScost:=TotScost + R502ProDtM1.scost;
          if R502ProDtM1.Blocca = 0 then
          begin
            Text:='<span style="color: #00008B; cursor: default;" title="Ore lavorate">' +
                  R180MinutiOre(R502ProDtM1.OreReseTotali) + '</span><br/>' +
                  '<span style="color: #008800; cursor: default;" title="Debito giornaliero">' +
                  R180MinutiOre(R502ProDtM1.debitogg) + '</span><br/>' +
                  '<span style="color: #FF0000; cursor: default;" title="Scostamento">' +
                  R180MinutiOre(R502ProDtM1.scost) + '</span><br/>' +
                  '<span style="color: #0033CC; cursor: default;" title="Ore escluse dalle normali">' +
                  R180MinutiOre(R502ProDtM1.minlavesc);
            TotOreReseTotali:=TotOreReseTotali + R502ProDtM1.OreReseTotali;
            TotMinLavEsc:=TotMinLavEsc + R502ProDtM1.minlavesc;
          end
          else
          begin
            // anomalia bloccante
            Text:='<span style="cursor: default;" title="Anomalia bloccante: ' + R502ProDtM1.DescAnomaliaBloccante + '">' +
                  '&nbsp;<br/>Anom.<br/>&nbsp;</span>';
            Css:=Css + ' ' + 'segnalazione';
          end;
        end;
        inc(c);

        // orario (pianificazione)
        with grdCartellino.Cell[i + 1,c] do
        begin
          Clickable:=AbilPianif and not bDettaglioGG;
          Css:='';
          Text:='';
          if R502ProDtM1.cdsT020.Active then
          begin
            Hint:=R502ProDtM1.cdsT020.FieldByName('DESCRIZIONE').AsString;
            if AbilPianif then
              Hint:=Hint + ' - Pianificazione giornaliera';

            ShowHint:=True;
          end;
          if R502ProDtM1.pianif = 'no' then
          begin
            Text:=R502ProDtM1.c_orario;
          end
          else
          begin
            with W005DtM.selT080 do
              if SearchRecord('Data',Data,[srFromBeginning]) then
              begin
                Text:=FieldByName('ORARIO').AsString;
                Css:=Css + ' ' + 'font_rosso';
              end;
          end;
          Text:=Text + GetTurno(Data);
        end;
        inc(c);
      end;

      // giustificativi
      NumGiust:=Min(Length(Giustificativi),10); //*** stabilire n° max di giust. da visualizzare (per ora 10)
      with grdCartellino.Cell[i + 1,c] do
      begin
        Css:='';
        Clickable:=AbilGiustif and not bDettaglioGG;
        ShowHint:=True;
        if NumGiust = 0 then
        begin
          if not bDettaglioGG then
          begin
            Text:='_____';
            Hint:=A000TraduzioneStringhe(A000MSG_W005_MSG_NUOVOGIUST);
		      end;
        end
        else
        begin
          // concatena l'elenco dei giustificativi del giorno
          Css:='bg_rosa';
          ElencoGiust:='';
          for j:=0 to NumGiust - 1 do
          begin
            Durata:=Giustificativi[j].Tipo;
            if Durata = 'N' then
              Durata:=R180MinutiOre(Giustificativi[j].Dalle)
            else if Durata = 'D' then
              Durata:=R180MinutiOre(Giustificativi[j].Dalle) + '/' +
                      R180MinutiOre(Giustificativi[j].Alle);
            if not Giustificativi[j].Richiesta then
              Css:='bg_rosso';
            ElencoGiust:=ElencoGiust + '<div class="' + IfThen(Giustificativi[j].Richiesta,'bg_rosa','bg_rosso') + ' ' + IfThen(Giustificativi[j].Validata = 'N','fontAcqua',IfThen(Giustificativi[j].Richiesta,'fontBlack','fontWhite')) + '">' + Giustificativi[j].Causale + IfThen(Giustificativi[j].Note <> '','[' + Giustificativi[j].Note + ']') + '(' + Durata + ')' + '</div>';
          end;
          Hint:=Giustificativi[0].Descrizione + ' - ' + A000TraduzioneStringhe(A000MSG_W005_MSG_GIUSTIFICATIVI);
          Text:=Copy(ElencoGiust,1,Length(ElencoGiust) - 3);
        end;
      end;
      inc(c);

      // cella per nuova timbratura
      if (not SolaLettura) and (Parametri.InserisciTimbrature = 'S') then
      begin
        grdCartellino.Cell[i + 1,c].Control:=TW005IWEdit.Create(Self);
        with (grdCartellino.Cell[i + 1,c].Control as TW005IWEdit) do
        begin
          OnAsyncDoubleClick:=edtTimbraturaAsyncDoubleClickIns;
          Hint:='Inserimento nuova timbratura: ' + A000MSG_W005_MSG_FORMATO_TIMB;
          FriendlyName:=IntToStr(i + 1);
          Tag:=Trunc(Data);
          Text:='';
          CSS:='inputW005';
          Editable:=True;
          DoSubmitValidation:=False;
          OnSubmit:=NuovaTimbraturaSubmit;
          RenderSize:=False;
          Font.Enabled:=False;
        end;
        inc(c);
      end;
      if High(Timbrature) >= 0 then
      begin
        grdCartellino.Cell[i + 1,c].Control:=TmeIWGrid.Create(Self);
        with (grdCartellino.Cell[i + 1,c].Control as TmeIWGrid) do
        begin
          Css:='gridComandi';
          FriendlyName:='ListaTimbrature' + IntToStr(i + 1);
          ColumnCount:=MaxT;
          RowCount:=1;
        end;
      end;
      // timbrature
      for j:=0 to High(Timbrature) do
      begin
        Rilevatore:='';
        if Timbrature[j].Ril <> '' then
          Rilevatore:='(' + Timbrature[j].Ril + ')';
        Causale:='';
        if Timbrature[j].Causale <> '' then
          Causale:='/' + Timbrature[j].Causale;
        Timbratura:=Timbrature[j].Verso +
                    {StringReplace(R180MinutiOre(Timbrature[j].Ora),'.','',[])}
                    R180MinutiOre(Timbrature[j].Ora);
        // componente edit per timbratura
        with (grdCartellino.Cell[i + 1,c].Control as TmeIWGrid).Cell[0,j] do
        begin
          Control:=TW005IWEdit.Create(Self);
          Css:='width15chrW005';
          if bAbilitaHandlerModificaTimb then
            Control.OnAsyncDoubleClick:=edtTimbraturaAsyncDoubleClickEdt;
        end;
        with ((grdCartellino.Cell[i + 1,c].Control as TmeIWGrid).Cell[0,j].Control as TW005IWEdit) do
        begin
          W005EdtGiorno:=i;
          W005EdtTimb:=j;
          FriendlyName:=IntToStr(i + 1);
          Tag:=Trunc(Data);
          Text:=Timbratura + Causale + Rilevatore;
          // NON UTILIZZARE EDITABLE (NON VISUALIZZA IL COLORE ROSSO DELLE TIMBRATURE ORIGINALI E DISABILITA L'HINT)
          //Editable:=(not SolaLettura);
          ReadOnly:=SolaLettura;
          Hint:='Timbratura di ' +
                IfThen(Timbrature[j].Verso = 'E','entrata','uscita') +
                ' alle ore ' + R180MinutiOre(Timbrature[j].Ora) +
                IfThen(Timbrature[j].Causale <> '',' con causale ' + Timbrature[j].Causale,'') +
                IfThen(Timbrature[j].Ril <> '',' sul rilevatore ' + Timbrature[j].Ril + ' ' + VarToStr(WR000DM.selT361.Lookup('CODICE',Timbrature[j].Ril,'DESCRIZIONE')),'');
          if (getBrowser is TInternetExplorer) and (GetBrowser.MajorVersion = 6) then
            Css:='inputW005IE6' + ' ' + IfThen(Timbrature[j].Verso = 'E','bg_lime','bg_aqua')
          else
            Css:='inputW005' + ' ' + IfThen(Timbrature[j].Verso = 'E','bg_lime','bg_aqua');
          if Timbrature[j].Flag = 'O' then
            Css:=Css + ' ' + 'font_rosso'; // timb. originale

          RenderSize:=False;
          Font.Enabled:=False;
        end;
      end;
      if grdCartellino.Cell[i + 1,c].Control <> nil then
      begin
        for j:=0 to MaxT - 1 do
        begin
          with (grdCartellino.Cell[i + 1,c].Control as TmeIWGrid).Cell[0,j] do
          begin
            if Control = nil then
            begin
              Css:='width15chrW005';
              Text:='&nbsp;';
            end;
          end;
        end;
      end;
      //inc(c);
    end;
  end;

  lblUscitaNominaleGGCorr.Visible:=chkConteggi.Checked and R180Between(Date,Dal,Al);
  if lblUscitaNominaleGGCorr.Visible then
  begin
    R502ProDtM1.ResettaProg;
    R502ProDtM1.IgnTimbNonInSeqForzata:=True;
    try
      R502ProDtM1.Conteggi('Cartolina',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Date);
      if (R502ProDtM1.Blocca > 0) or ((R502ProDtM1.TipoOrario = 'D') and (R502ProDtM1.PeriodoLavorativo = 'L')) then
        lblUscitaNominaleGGCorr.Visible:=False
      else
        lblUscitaNominaleGGCorr.Caption:='L''uscita odierna è prevista alle ore ' + R180MinutiOre(R502ProDtM1.UscitaTeorica);
    finally
      R502ProDtM1.IgnTimbNonInSeqForzata:=False;
    end;
  end;

  if WR000DM.TipoUtente = 'Dipendente' then
    FreeAndNil(R502ProDtM1);
  // Caricamento griglia riepilogo saldi
  grdRiepilogoSaldi.RowCount:=1;
  grdRiepilogoSaldi.ColumnCount:=2;
  grdRiepilogoSaldi.Cell[0,0].Text:='<span style="color: #00008B; cursor: default;" title="Ore lavorate">' +
                                    'Ore lavorate' + '</span><br/>' +
                                    '<span style="color: #008800; cursor: default;" title="Debito orario">' +
                                    'Debito orario' + '</span><br/>' +
                                    '<span style="color: #FF0000; cursor: default;" title="Scostamento">' +
                                    'Scostamento' + '</span><br/>' +
                                    '<span style="color: #0033CC; cursor: default;" title="Ore escluse dalle normali">' +
                                    'Ore escluse dalle normali';
  grdRiepilogoSaldi.Cell[0,1].Text:='<span style="color: #00008B; cursor: default;" title="Ore lavorate">' +
                                    R180MinutiOre(TotOreReseTotali) + '</span><br/>' +
                                    '<span style="color: #008800; cursor: default;" title="Debito orario">' +
                                    R180MinutiOre(TotDebitoGg) + '</span><br/>' +
                                    '<span style="color: #FF0000; cursor: default;" title="Scostamento">' +
                                    R180MinutiOre(TotScost) + '</span><br/>' +
                                    '<span style="color: #0033CC; cursor: default;" title="Ore escluse dalle normali">' +
                                    R180MinutiOre(TotMinLavEsc);
  grdRiepilogoSaldi.Visible:=chkConteggi.Checked;
  lblRiepilogoSaldiCaption.Visible:=grdRiepilogoSaldi.Visible;
end;

procedure TW005FCartellino.grdCartellinoRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  RenderCell(ACell,ARow,AColumn,True,False);
end;

procedure TW005FCartellino.grdRiepilogoSaldiRenderCell(ACell: TIWGridCell;
  const ARow, AColumn: Integer);
begin
  inherited;
  C190RenderCell(ACell,ARow,AColumn,False,False,False);
  if AColumn = 1 then
    ACell.Css:=ACell.Css + ' conteggi align_right';
end;

procedure TW005FCartellino.imgPeriodoPrecClick(Sender: TObject);
//var DalNew,AlNew:TDateTime;
begin
  {
  R180SpostaPeriodo(Dal,Al,Sender = imgSuccessivo,True,DalNew,AlNew);
  edtDal.Text:=DateToStr(DalNew);
  edtAl.Text:=DateToStr(AlNew);
  }
  btnEseguiClick(nil);
end;

procedure TW005FCartellino.chkConteggiClick(Sender: TObject);
begin
  lstAnomalie.Clear;
  VisualizzaCartellino;
end;

function TW005FCartellino.ElaboraTimbratura(T,Oper:String; Giorno,Timb:Integer; Data:TDateTime):String;
var H,V,C,R,Messaggio:String;
    PNew,DNew,HNew,CNew,RNew,VNew,IdNew,
    POld,DOld,HOld,COld,ROld,VOld,IdOld:String;
begin
  Result:='';
  H:='';
  V:='';
  C:='';
  R:='';
  PNew:='';
  DNew:='';
  HNew:='';
  CNew:='';
  RNew:='';
  VNew:='';
  IdNew:=''; // commessa MAN/02 - SVILUPPO 92
  POld:='';
  DOld:='';
  HOld:='';
  COld:='';
  ROld:='';
  VOld:='';
  IdOld:=''; // commessa MAN/02 - SVILUPPO 92
  Messaggio:='';

  if Oper <> 'C' then
  begin
    // separa l'informazione nei suoi valori
    V:=UpperCase(Copy(T,1,1));
    H:=Copy(T,2,5);
    if Pos('/',T) > 0 then
      C:=Copy(T,Pos('/',T) + 1,Length(T));
    if Pos('(',C) > 0 then
      C:=Copy(C,1,Pos('(',C) - 1);
    if Pos('(',T) > 0 then
      R:=Copy(T,Pos('(',T) + 1,Length(T));
    if Pos(')',R) > 0 then
      R:=Copy(R,1,Pos(')',R) - 1);

    // formato timbratura (verso + ora)
    if (V = '') or (H = '') then
    begin
      Result:=A000MSG_W005_ERR_FORMATO_TIMB;
      exit;
    end;
    // verso
    if (V <> 'E') and (V <> 'U') then
    begin
      Result:=A000MSG_W005_ERR_VERSO_TIMB;
      exit;
    end;
    // ora
    if Pos('.',H) = 0 then
    begin
      Result:=A000MSG_W005_ERR_FORMATO_ORA_TIMB;
      exit;
    end;
    try
      R180OraValidate(H);
      H:=StringReplace(H,'.','',[]);
    except
      on E: Exception do
      begin
        Result:=StringReplace(E.Message,'del dato',A000TraduzioneStringhe(A000MSG_W005_ERR_DELL_ORA),[]);
        Exit;
      end;
    end;
    // causale
    if not C.IsEmpty then
    begin
      // controllo con filtro dizionario
      W005Dtm.selT275.Filtered:=True;
      W005Dtm.selT305.Filtered:=True;
      try
        if (not W005Dtm.selT275.SearchRecord('CODICE',C,[srFromBeginning])) and
           (not W005Dtm.selT305.SearchRecord('CODICE',C,[srFromBeginning])) then
        begin
          Result:=Format(A000MSG_W005_FMT_CAUSALE_INESISTENTE,[C]);
          exit;
        end;
      finally
        W005Dtm.selT275.Filtered:=False;
        W005Dtm.selT305.Filtered:=False;
      end;
    end;
    // rilevatore
    if Length(R) > 2 then
    begin
      Result:=A000MSG_W005_ERR_COD_MAX_2_CHARATTERI;
      exit;
    end;
  end;
  if (Oper = 'M') or (Oper = 'I') then
  begin
    PNew:=selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    DNew:=DateToStr(Data);
    HNew:=H;
    VNew:=V;
    CNew:=C;
    RNew:=R;
    IdNew:=''; // commessa MAN/02 - SVILUPPO 92
  end;
  if (Oper = 'M') or (Oper = 'C') then
  begin
    POld:=selAnagrafeW.FieldByName('PROGRESSIVO').AsString;
    DOld:=DateToStr(Data);
    HOld:=StringReplace(R180MinutiOre(Cartellino[Giorno].Timbrature[Timb].Ora),'.','',[]);
    VOld:=Cartellino[Giorno].Timbrature[Timb].Verso;
    COld:=Cartellino[Giorno].Timbrature[Timb].Causale;
    ROld:=Cartellino[Giorno].Timbrature[Timb].Ril;
    // commessa MAN/02 - SVILUPPO 92.ini
    if Cartellino[Giorno].Timbrature[Timb].IdRichiesta = 0 then
      IdOld:=''
    else
      IdOld:=IntToStr(Cartellino[Giorno].Timbrature[Timb].IdRichiesta);
    // commessa MAN/02 - SVILUPPO 92.fine
    if HNew = '' then
    begin
      if (Parametri.CancellaTimbrature = 'N') and (Parametri.T100_CancTimbOrig = 'N') then
        Messaggio:=A000MSG_W005_MSG_CANC_TIMBRATURE
      else if (Parametri.CancellaTimbrature = 'N') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'I') then
        Messaggio:=A000MSG_W005_MSG_CANC_TIMB_MANUALI
      else if (Parametri.T100_CancTimbOrig = 'N') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'O') then
        Messaggio:=A000MSG_W005_MSG_CANC_TIMB_ORIGINALI;
    end;
    if (HNew <> '') and (HNew <> HOld) and (Parametri.T100_Ora = 'N') then
      Messaggio:=A000MSG_W005_MSG_MODIF_TIMBRATURE;
    if (HNew <> '') and (RNew <> ROld) and (Parametri.T100_Rilevatore = 'N') then
      Messaggio:=A000MSG_W005_MSG_MODIF_RILEVATORE;
    if (HNew <> '') and (CNew <> '') and (CNew <> COld) and (Parametri.T100_Causale = 'N') then
      Messaggio:=A000MSG_W005_MSG_MODIF_CAUSALE;
    if not CNew.IsEmpty then
    begin
      if (not W005Dtm.selT275.SearchRecord('CODICE',CNew,[srFromBeginning])) and
         (not W005Dtm.selT305.SearchRecord('CODICE',CNew,[srFromBeginning])) and
         (Parametri.T100_Causale = 'S') then
      begin
        Messaggio:=A000MSG_W005_MSG_USARE_CAUS_SELEZIONATA;
      end;
    end;
  end
  // filtro dizionario su caus. pres anche per inserimento
  else if Oper = 'I' then
  begin
    if not CNew.IsEmpty then
    begin
      if (not W005Dtm.selT275.SearchRecord('CODICE',CNew,[srFromBeginning])) and
         (not W005Dtm.selT305.SearchRecord('CODICE',CNew,[srFromBeginning])) then
      begin
        Messaggio:=A000MSG_W005_MSG_USARE_CAUS_SELEZIONATA;
      end;
    end;
  end;
  if Messaggio = '' then
  begin
    // controllo dati bloccati
    if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(Data),'T100') then
    begin
      Result:=WR000DM.selDatiBloccati.MessaggioLog;
    end
    else
    begin
      // applica la modifica al database
      with W005DtM do
      begin
        Timbrature.SetVariable('OPER',Oper);
        if Oper <> 'I' then
          Timbrature.SetVariable('ROWID',Cartellino[Giorno].Timbrature[Timb].RowID);
        Timbrature.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
        Timbrature.SetVariable('DATA',Data);
        Timbrature.SetVariable('ORA',H);
        if Oper <> 'I' then
          Timbrature.SetVariable('FLAG',Cartellino[Giorno].Timbrature[Timb].Flag);
        Timbrature.SetVariable('VERSO',V);
        Timbrature.SetVariable('CAUSALE',C);
        Timbrature.SetVariable('RILEVATORE',R);
        Timbrature.SetVariable('ORIGINALE','N');
        if (Oper = 'M') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'O') and (Parametri.TimbOrig_Causale = 'S') and (COld <> CNew) then
          if (HOld = HNew) and (VOld = VNew) and (ROld = RNew) then
            Timbrature.SetVariable('ORIGINALE','S');
        if (Oper = 'M') and (Cartellino[Giorno].Timbrature[Timb].Flag = 'O') and (Parametri.TimbOrig_Verso = 'S') and (VOld <> VNew) then
          if (HOld = HNew) and (COld = CNew) and (ROld = RNew) then
            Timbrature.SetVariable('ORIGINALE','S');
        Timbrature.Execute;
        if VarToStr(Timbrature.GetVariable('ERRORE')) <> '' then
        begin
          if Oper = 'I' then
            Result:=A000MSG_W005_MSG_INSERIMENTO_FALLITO;
        end
        else
        begin
          RegistraLog.SettaProprieta(Oper,'T100_TIMBRATURE',medpCodiceForm,nil,True);
          RegistraLog.InserisciDato('PROGRESSIVO',Pold,PNew);
          RegistraLog.InserisciDato('DATA',DOld,DNew);
          RegistraLog.InserisciDato('ORA',HOld,HNew);
          RegistraLog.InserisciDato('VERSO',VOld,VNew);
          RegistraLog.InserisciDato('CAUSALE',COld,CNew);
          RegistraLog.InserisciDato('RILEVATORE',ROld,RNew);
          RegistraLog.InserisciDato('ID_RICHIESTA',IdOld,IdNew); // commessa MAN/02 - SVILUPPO 92
          RegistraLog.RegistraOperazione;
        end;
      end;
    end;
    Result:=A000TraduzioneStringhe(Result);
  end
  else
    Result:=A000TraduzioneStringhe(A000MSG_W005_MSG_MANCANO_AUTORIZZAZIONI) + ' ' + A000TraduzioneStringhe(Messaggio);
end;

procedure TW005FCartellino.NuovaTimbraturaSubmit(Sender: TObject);
var S:String;
begin
  S:=ElaboraTimbratura((Sender as TW005IWEdit).Text,'I',0,0,(Sender as TW005IWEdit).Tag);
  SessioneOracle.Commit;
  if S <> '' then
  begin
    if S = A000TraduzioneStringhe(A000MSG_W005_MSG_INSERIMENTO_FALLITO) then
      (Sender as TW005IWEdit).Text:='';
    GGetWebApplicationThreadVar.ShowMessage(S + '!')
  end
  else
  begin
    VisualizzaDipendenteCorrente;
  end;
end;

procedure TW005FCartellino.btnApplicaClick(Sender: TObject);
var i,j,k:Integer;
    T,Msg:String;
    Data:TDateTime;
    IWEdt: TW005IWEdit;
begin
  lstAnomalie.Clear;
  try
    for i:=1 to grdCartellino.RowCount - 1 do
    begin
      for j:=1 to grdCartellino.ColumnCount - 1 do
      begin
        Msg:='';
        Data:=StrToInt(grdCartellino.Cell[i,0].Hint);
        //Nuova timbratura
        if j = (ColF - 1 + COL_G) then
        begin
          if (grdCartellino.Cell[i,j].Control as TW005IWEdit).Text <> '' then
            Msg:=ElaboraTimbratura((grdCartellino.Cell[i,j].Control as TW005IWEdit).Text,'I',0,0,Data);
        end;
        //Modifica/cancellazione timbratura esistente
        if j > (ColF - 1 + COL_G) then
        begin
          if grdCartellino.Cell[i,j].Control is TmeIWGrid then
          begin
            for k:=0 to (grdCartellino.Cell[i,j].Control as TmeIWGrid).ColumnCount - 1 do
            begin
              if (grdCartellino.Cell[i,j].Control as TmeIWGrid).Cell[0,k].Control <> nil then
              begin
                IWEdt:=((grdCartellino.Cell[i,j].Control as TmeIWGrid).Cell[0,k].Control as TW005IWEdit);
                {Bruno 04/10/2011
                 Espressione precedente:    x:=(k + 3) - (ColF + COL_G);}
                T:=Cartellino[i - 1].Timbrature[k].Verso +
                   R180MinutiOre(Cartellino[i - 1].Timbrature[k].Ora);
                if Cartellino[i - 1].Timbrature[k].Causale <> '' then
                  T:=T + '/' + Cartellino[i - 1].Timbrature[k].Causale;
                if Cartellino[i - 1].Timbrature[k].Ril <> '' then
                  T:=T + '(' + Cartellino[i - 1].Timbrature[k].Ril + ')';
                if IWEdt.Text <> T then
                begin
                  if Trim(IWEdt.Text) = '' then
                    Msg:=ElaboraTimbratura(IWEdt.Text,'C',i - 1,k,Data)
                  else
                    Msg:=ElaboraTimbratura(IWEdt.Text,'M',i - 1,k,Data);
                end;
              end;
              if Msg <> '' then
              begin
                if lstAnomalie.IndexOfName(DateToStr(Data)) = -1 then
                  lstAnomalie.Add(Format('%s=%s',[DateToStr(Data),Msg]));
              end;
            end;
          end;
        end;
      end;
    end;
  finally
    SessioneOracle.Commit;
  end;
  VisualizzaDipendenteCorrente;
end;

procedure TW005FCartellino.grdCartellinoCellClick(ASender: TObject; const ARow, AColumn: Integer);
var
//  ColData, ColOrario, ColRichieste, ColGiust: Integer;
  LGiorno: TDateTime;
  W018: TW018FRichiestaTimbrature;
  W023: TW023FPianifOrari;
  W008: TW008FGiustificativi;
  W010: TW010FRichiestaAssenze;
  LWC028FM: TWC028FRichiesteInCorsoFM;
begin
  {
  // determina le colonne da considerare
  ColData:=0;
  ColOrario:=IfThen(chkConteggi.Checked,IfThen(lstAnomalie.Count > 0,1,0) +  2,-1);
  ColRichieste:=
  ColGiust:=IfThen(lstAnomalie.Count > 0,1,0) + IfThen(chkConteggi.Checked,2,0) + 1;
  }

  // data della riga selezionata
  LGiorno:=StrToInt(grdCartellino.Cell[ARow,0].Hint);

  if AColumn = ColData then
  begin
    // click sulla data    -> segnalazione / autorizzazione omesse timbrature
    // in assenza di informazioni imposta il flag Responsabile in base alla presenza
    // o meno di un filtro anagrafe impostato
    WR000DM.Responsabile:=not Parametri.InibizioneIndividuale;
    W018:=TW018FRichiestaTimbrature.Create(GGetWebApplicationThreadVar);
    W018.SetParam('CHIAMANTE','W005');
    W018.SetParam('PROGRESSIVO',medpProgressivo);
    W018.SetParam('AL',Parametri.DataLavoro);
    W018.SetParam('DATA_FILTRO',LGiorno);
    W018.OpenPage;
  end
  else if AColumn = ColOrario then
  begin
    // click sull'orario  -> pianificazione orari
    W023:=TW023FPianifOrari.Create(GGetWebApplicationThreadVar);
    W023.SetParam('CHIAMANTE','W005');
    W023.SetParam('PROGRESSIVO',medpProgressivo);
    W023.SetParam('DAL',LGiorno);
    W023.SetParam('AL',LGiorno);
    W023.OpenPage;
  end
  else if AColumn = ColRichieste then
  begin
    LWC028FM:=TWC028FRichiesteInCorsoFM.Create(Self);
    LWC028FM.A023MW:=A023MW;
    LWC028FM.Visualizza(LGiorno);
  end
  else if AColumn = ColGiust then
  begin
    // se l'utente è abilitato alla gestione giustificativi attiva questa,
    // altrimenti verifica l'abilitazione alla richiesta assenze
    if (A000GetInibizioni('Funzione','OpenW008Giustificativi') <> 'N') and
       True//(not Parametri.ModuloInstallato['TORINO_CSI_PRV'])
    then
    begin
      // click sul giust.   -> gestione giustificativi
      W008:=TW008FGiustificativi.Create(GGetWebApplicationThreadVar);
      W008.SetParam('CHIAMANTE','W005');
      W008.SetParam('PROGRESSIVO',medpProgressivo);
      W008.SetParam('DAL',LGiorno);
      W008.SetParam('AL',LGiorno);
      if (Length(Cartellino[ARow - 1].Giustificativi) > 0) and (Cartellino[ARow - 1].Giustificativi[0].Causale <> '') then
      begin
        W008.SetParam('CAUSALE',Cartellino[ARow - 1].Giustificativi[0].Causale);
        W008.SetParam('TIPOGIUST',Cartellino[ARow - 1].Giustificativi[0].Tipo);
        if R180In(Cartellino[ARow - 1].Giustificativi[0].Tipo,['N','D']) then
        begin
          W008.SetParam('DAORE',R180MinutiOre(Cartellino[ARow - 1].Giustificativi[0].Dalle));
          if Cartellino[ARow - 1].Giustificativi[0].Tipo = 'D' then
            W008.SetParam('AORE',R180MinutiOre(Cartellino[ARow - 1].Giustificativi[0].Alle));
        end;
      end;
      W008.OpenPage;
    end
    else if (A000GetInibizioni('Funzione','OpenW010RichiestaAssenze') <> 'N') or
            (WR000DM.Responsabile and (A000GetInibizioni('Funzione','OpenW010AutorizzAssenze') <> 'N')) then
    begin
      // click sul giust.   -> richiesta assenze
      if A000GetInibizioni('Funzione','OpenW010RichiestaAssenze') <> 'N' then
        WR000DM.Responsabile:=False;

      W010:=TW010FRichiestaAssenze.Create(GGetWebApplicationThreadVar);
      W010.SetParam('CHIAMANTE','W005');
      W010.SetParam('PROGRESSIVO',medpProgressivo);
      W010.SetParam('DAL',LGiorno);
      W010.SetParam('AL',LGiorno);
      if (Length(Cartellino[ARow - 1].Giustificativi) > 0) and (Cartellino[ARow - 1].Giustificativi[0].Causale <> '') then
      begin
        W010.SetParam('CAUSALE',Cartellino[ARow - 1].Giustificativi[0].Causale);
        W010.SetParam('TIPOGIUST',Cartellino[ARow - 1].Giustificativi[0].Tipo);
        if R180In(Cartellino[ARow - 1].Giustificativi[0].Tipo,['N','D']) then
        begin
          W010.SetParam('DAORE',R180MinutiOre(Cartellino[ARow - 1].Giustificativi[0].Dalle));
          if Cartellino[ARow - 1].Giustificativi[0].Tipo = 'D' then
            W010.SetParam('AORE',R180MinutiOre(Cartellino[ARow - 1].Giustificativi[0].Alle));
        end;
      end;
      W010.OpenPage;
    end;
  end;
end;

procedure TW005FCartellino.lnkLegendeClick(Sender: TObject);
begin
  inherited;
  MostraLegenda(False);
end;

procedure TW005FCartellino.lnkLegendaColoriGiorniClick(Sender: TObject);
begin
  TWC001FLegendaCalendarioFM.Create(Self);
end;

procedure TW005FCartellino.lnkMostraLegendeClick(Sender: TObject);
begin
  inherited;
  MostraLegenda(True);
end;

function TW005FCartellino.GetInfoFunzione: String;
begin
  Result:=inherited GetInfoFunzione;
  Result:=Result + '<br>' + C190PeriodoStr(Dal,Al);
end;

procedure TW005FCartellino.DistruggiOggetti;
var
  i:Integer;
begin
  // array di supporto
  for i:=0 to High(Cartellino) do
  begin
    SetLength(Cartellino[i].Timbrature,0);
    SetLength(Cartellino[i].Giustificativi,0);
  end;

  if R502ProDtM1 <> nil then
    FreeAndNil(R502ProDtM1);
  if lstAnomalie <> nil then
    FreeAndNil(lstAnomalie);

  if (GGetWebApplicationThreadVar <> nil) and
     (GGetWebApplicationThreadVar.Data <> nil) then
  begin
    R180CloseDataSetTag0(WR000DM.selT265);
    R180CloseDataSetTag0(WR000DM.selT275);
  end;

  try FreeAndNil(W005Dtm); except end;
end;

procedure TW005FCartellino.edtTimbraturaAsyncDoubleClickEdt(Sender: TObject; EventParams: TStringList);
var
  W005FGestTimbFM:TW005FGestTimbFM;
  ParamTimbratura:TInfoTimbratura;
begin
  inherited;
  W005FGestTimbFM:=TW005FGestTimbFM.Create(Self);
  ParamTimbratura.TxtTimbratura:=(Sender as TW005IWEdit).Text;
  ParamTimbratura.DataTimbratura:=(Sender as TW005IWEdit).Tag;
  ParamTimbratura.Operazione:='M';
  ParamTimbratura.GiornoTimbratura:=(Sender as TW005IWEdit).W005EdtGiorno;
  ParamTimbratura.NumeroTimbratura:=(Sender as TW005IWEdit).W005EdtTimb;
  W005FGestTimbFM.Visualizza(ParamTimbratura);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[lnkAggiorna.HTMLName]));
end;

procedure TW005FCartellino.edtTimbraturaAsyncDoubleClickIns(Sender: TObject;
  EventParams: TStringList);
var
  W005FGestTimbFM:TW005FGestTimbFM;
  ParamTimbratura:TInfoTimbratura;
begin
  inherited;
  W005FGestTimbFM:=TW005FGestTimbFM.Create(Self);
  ParamTimbratura.TxtTimbratura:=(Sender as TW005IWEdit).Text;
  ParamTimbratura.DataTimbratura:=(Sender as TW005IWEdit).Tag;
  ParamTimbratura.Operazione:='I';
  W005FGestTimbFM.Visualizza(ParamTimbratura);
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[lnkAggiorna.HTMLName]));
end;

end.
