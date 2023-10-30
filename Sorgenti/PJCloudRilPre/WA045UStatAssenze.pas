unit WA045UStatAssenze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Math, OracleData,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, DB, DBClient, MConnect,
  Menus, IWCompJQueryWidget, meIWRadioGroup, meIWImageFile, medpIWImageButton,
  IWCompCheckbox, meIWCheckBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, StrUtils,
  A000UInterfaccia, medpIWC700NavigatorBar,A045UStatAssenzeMW, medpIWMessageDlg, A000UMessaggi, A000UCostanti, ActiveX,
  C180FunzioniGenerali, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} C190FunzioniGeneraliWeb, IWAdvCheckGroup, meTIWAdvCheckGroup, WC013UCheckListFM;

type
  TWA045FStatAssenze = class(TWR100FBase)
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    JQuery: TIWJQueryWidget;
    lblParamDaAppl: TmeIWLabel;
    lblQualMinisteriali: TmeIWLabel;
    lblTipiRapporto: TmeIWLabel;
    chkGGLavorativi: TmeIWCheckBox;
    ChkAssTutte: TmeIWCheckBox;
    chkSantoPatrono: TmeIWCheckBox;
    ChkContNumDip: TmeIWCheckBox;
    ChkPartOr: TmeIWCheckBox;
    lblCausaliFormaz: TmeIWLabel;
    edtCausali: TmeIWEdit;
    btnCausali: TmeIWButton;
    btnEsegui: TmedpIWImageButton;
    rgpArrotondamentoAssenza: TmeIWRadioGroup;
    lblArrotondamentoAssenza: TmeIWLabel;
    rgpTipoArrotondamentoAssenza: TmeIWRadioGroup;
    lblTipoArrotondamentoAssenza: TmeIWLabel;
    lblOgniAssenza: TmeIWLabel;
    lblAssPerDip: TmeIWLabel;
    lblAssPerQual: TmeIWLabel;
    rgpArrotondamentoTotale: TmeIWRadioGroup;
    lblArrotondamentoTotale: TmeIWLabel;
    rgpTipoArrotondamentoTotale: TmeIWRadioGroup;
    lblTipoArrotondamentoTotale: TmeIWLabel;
    rgpArrotondamentoQualifica: TmeIWRadioGroup;
    lblArrotondamentoQualifica: TmeIWLabel;
    rgpTipoArrotondamentoQualifica: TmeIWRadioGroup;
    lblTipoArrotondamentoQualifica: TmeIWLabel;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    DCOMConnection: TDCOMConnection;
    LstListaCausali: TmeTIWAdvCheckGroup;
    LstListaTipiRapporto: TmeTIWAdvCheckGroup;
    chkElabora: TmeIWCheckBox;
    chkStampa: TmeIWCheckBox;
    rgpStampa: TmeIWRadioGroup;
    procedure IWAppFormCreate(Sender: TObject);
    procedure ChkAssTutteAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure ChkPartOrAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure rgpArrotondamentoAssenzaClick(Sender: TObject);
    procedure rgpArrotondamentoTotaleClick(Sender: TObject);
    procedure rgpArrotondamentoQualificaClick(Sender: TObject);
    procedure chkElaboraAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkStampaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnCausaliClick(Sender: TObject);
    procedure rgpStampaAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    A045MW: TA045FStatAssenzeMW;
    WC013:TWC013FCheckListFM;
    dSantoPatrono,DataCorr,DataInizioTmp,DataFineTmp : TDateTime;
    ListaDip : TList;
    ListaQualifiche:TStringList;
    ListaRapporti:TStringList;
    sTipiRapporto,sQualifiche,SalvaSQL,DCOMNomeFile:string;
    InterrompiElaborazione:Boolean;
    procedure PopolaListaQualifiche;
    procedure PopolaListaTipiRapporto;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ResultWC700(Sender: TObject; Result: Boolean);
    procedure Controlli;
    procedure EstrazioneAssenze;
    procedure DomandaAnteprimaUltimaOperaz(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure DomandaStampaUltimaOperaz(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure GeneraPDF;
    procedure evtA045MergeSelAnagrafe(DataSet: TOracleDataSet; RicreaVariabili: Boolean);
    procedure evtA045MergeSettaPeriodo(DataSet: TOracleDataSet; DataDa, DataA: TDateTime);
    procedure evtA045ShowMsg(Msg: String);
    function evtA045SqlCreatoC700: String;
    // Gestione progressBar
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    procedure FineCicloElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function ElementoSuccessivo: Boolean; override;
    function CurrentRecordElaborazione: Integer; override;
    function CreateJSonString: String;
    procedure CallDCOMPrinter;
    procedure ResConfermaStampa(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
    procedure cklistCausali(Sender: TObject; Result: Boolean);
  protected
    procedure ImpostazioniWC700; override;
    procedure WC700AperturaSelezione(Sender: TObject); override;
  public
    sDescTipiRapporto:string;
  end;

implementation

{$R *.dfm}

procedure TWA045FStatAssenze.IWAppFormCreate(Sender: TObject);
begin
  A045MW:=TA045FStatAssenzeMW.Create(Self);
  A045MW.evtA045MergeSelAnagrafe:=evtA045MergeSelAnagrafe;
  A045MW.evtA045MergeSettaPeriodo:=evtA045MergeSettaPeriodo;
  A045MW.evtA045SqlCreatoC700:=evtA045SqlCreatoC700;
  A045MW.evtA045ShowMsg:=evtA045ShowMsg;
  inherited;
  GetParametriFunzione;
  AttivaGestioneC700;
  A045MW.SelAnagrafe:=grdC700.SelAnagrafe;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);
  edtDaData.Text:=DateToStr(A045MW.DataInizio);
  edtAData.Text:=DateToStr(A045MW.DataFine);
  PopolaListaQualifiche;
  PopolaListaTipiRapporto;
  InterrompiElaborazione:=False;
  //Aggiunto perchè su IrisWin viene richiamato in automatico all'apertura della form e su web no
  ChkAssTutteAsyncClick(nil,nil);
end;

procedure TWA045FStatAssenze.ResultWC700(Sender: TObject; Result: Boolean);
begin
  if Result then
    PopolaListaQualifiche;
end;

procedure TWA045FStatAssenze.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  with (pmnAzioni.PopupComponent as TmeTIWAdvCheckGroup) do
    for i:=0 to Items.Count - 1 do
      if Sender = SelezionaTutto1 then
        IsChecked[i]:=True
      else if Sender = DeselezionaTutto1 then
        IsChecked[i]:=False
      else if Sender = InvertiSelezione1 then
        IsChecked[i]:=not IsChecked[i];
end;

procedure TWA045FStatAssenze.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

procedure TWA045FStatAssenze.btnCausaliClick(Sender: TObject);
begin
  WC013:=TWC013FCheckListFM.Create(Self);
  with WC013 do
  begin
    A045MW.selT275.Close;
    A045MW.selT275.Open;
    ckList.Items.Add(' * PRESENZE * ');
    while not A045MW.selT275.Eof do
    begin
      ckList.Items.Add(Format('%-5s %s',[A045MW.selT275.FieldByName('Codice').AsString,A045MW.selT275.FieldByName('Descrizione').AsString]));
      ckList.Values.Add(Trim(A045MW.selT275.FieldByName('CODICE').AsString));
      A045MW.selT275.Next;
    end;
    A045MW.selT275.Close;
    A045MW.selT305.Close;
    A045MW.selT305.Open;
    ckList.Items.Add(' * GIUSTIFICAZIONE * ');
    while not A045MW.selT305.Eof do
    begin
      ckList.Items.Add(Format('%-5s %s',[A045MW.selT305.FieldByName('Codice').AsString,A045MW.selT305.FieldByName('Descrizione').AsString]));
      ckList.Values.Add(Trim(A045MW.selT305.FieldByName('CODICE').AsString));
      A045MW.selT305.Next;
    end;
    A045MW.selT305.Close;
    ResultEvent:=cklistCausali;
    C190PutCheckList(edtCausali.Text,5,ckList);
    WC013.Visualizza;
  end;
end;

procedure TWA045FStatAssenze.cklistCausali(Sender: TObject; Result: Boolean);
begin
  if Result then
    edtCausali.Text:=Trim(C190GetCheckList(5,WC013.ckList));
end;

procedure TWA045FStatAssenze.btnEseguiClick(Sender: TObject);
begin
  if not MsgBox.KeyExists('CONFERMA_STAMPA') then
  begin
    Controlli;
    if (rgpStampa.ItemIndex > 0) and not chkElabora.Checked then
    begin
      MsgBox.WebMessageDlg(A000MSG_A045_DLG_STAMPA_ULTIMA_OPERAZ,mtConfirmation,[mbYes,mbNo],ResConfermaStampa,'CONFERMA_STAMPA');
      Abort;
    end
    else if chkElabora.Checked then
    begin
      MsgBox.WebMessageDlg(A000MSG_DLG_CONFERMA_ELABORAZIONE,mtConfirmation,[mbYes,mbNo],ResConfermaStampa,'CONFERMA_STAMPA');
      Abort;
    end;
  end;
  MsgBox.ClearKeys;
  if chkElabora.Checked then
    StartElaborazioneCiclo(btnEsegui.HTMLName)
  else if (rgpStampa.ItemIndex > 0) then
  begin
    GeneraPDF;
    InviaFileGenerato;
  end;
end;

procedure TWA045FStatAssenze.ResConfermaStampa(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R <> mrYes then
    MsgBox.ClearKeys
  else
   btnEseguiClick(btnEsegui)
end;

procedure TWA045FStatAssenze.GeneraPDF;
begin
  CallDCOMPrinter;
  if FileExists(DCOMNomeFile) then
    NomeFileGenerato:=DCOMNomeFile
  else
    raise Exception.Create(A000MSG_ERR_FILE_NON_CREATO);
end;

procedure TWA045FStatAssenze.CallDCOMPrinter;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  if rgpStampa.ItemIndex = 1 then
    DCOMNomeFile:=GetNomeFile('pdf')
  else if rgpStampa.ItemIndex = 2 then
    DCOMNomeFile:=GetNomeFile('xls');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    A000SessioneWEB.AnnullaTimeOut;
    DCOMConnection.AppServer.PrintA045(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TWA045FStatAssenze.EstrazioneAssenze;
begin
  with A045MW do
  begin
    //Inizializzo i conteggi
    CreaSQLEstrazioneAssenze(chkGGLavorativi.Checked);
    if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataInizio,DataFine) then
      SelAnagrafe.Close;
    SelAnagrafe.Open;
    SelAnagrafe.First;
    while not SelAnagrafe.Eof do
    begin
      Application.ProcessMessages;
      if InterrompiElaborazione then
      begin
        InterrompiElaborazione:=False;
        MessaggioStatus(INFORMA,'');
        raise exception.Create(A000MSG_MSG_OPERAZIONE_INTERROTTA);
      end;
      //Santo Patrono
      if chkSantoPatrono.Checked and ConteggiaPatrono(SelAnagrafe.FieldByName('Progressivo').AsInteger) then
        AggiungiDip;
      // Chiamata a 'ElaboraCausaliPresenza'
      GGLavorativiChecked:=chkGGLavorativi.Checked;
      AssTutteChecked:=ChkAssTutte.Checked;
      ChkPartOrChecked:=ChkPartOr.Checked;
      Causali:=edtCausali.Text;
      TipoArrotondamentoAssenzaItemIndex:=rgpTipoArrotondamentoAssenza.ItemIndex;
      ArrotondamentoAssenzaItemIndex:=rgpArrotondamentoAssenza.ItemIndex;
      ElaboraCausaliPresenza;
      SelAnagrafe.Next;
    end;
  end;
end;

procedure TWA045FStatAssenze.Controlli;
var i: integer;
begin
  A045MW.DataInizio:=StrToDate(edtDaData.Text);
  A045MW.DataFine:=StrToDate(edtAData.Text);
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(A045MW.DataInizio,A045MW.DataFine) then
    grdC700.SelAnagrafe.Close;
  grdC700.SelAnagrafe.Open;
  if grdC700.SelAnagrafe.RecordCount = 0 then
    raise exception.Create(A000MSG_ERR_NO_DIP);
  if A045MW.DataInizio > A045MW.DataFine then
    raise Exception.Create(A000MSG_A045_ERR_ORDINE_DATE);
  //QUALIFICHE
  with A045MW do
  begin
    sQualifiche:='';
    for i:=0 to LstListaCausali.Items.Count - 1 do
      if LstListaCausali.IsChecked[i] then
      begin
        if sQualifiche <> '' then
          sQualifiche:=sQualifiche + ',';
        sQualifiche:=sQualifiche + '''' + Trim(Copy(LstListaCausali.Items[i],1, Pos(' - ', LstListaCausali.Items[i]))) + '''';
      end;
    if Trim(sQualifiche) = '' then
      raise Exception.Create(A000MSG_A045_ERR_SELEZ_QUALIFICA);
    //TIPI RAPPORTO
    sTipiRapporto:='';
    sDescTipiRapporto:='';
    for i:=0 to LstListaTipiRapporto.Items.Count - 1 do
      if LstListaTipiRapporto.IsChecked[i] then
      begin
        if sTipiRapporto <> '' then
        begin
          sTipiRapporto:=sTipiRapporto + ',';
          sDescTipiRapporto:=sDescTipiRapporto + ', ';
        end;
        sTipiRapporto:=sTipiRapporto + '''' + Trim(Copy(LstListaTipiRapporto.Items[i],1,5)) + '''';
        sDescTipiRapporto:= sDescTipiRapporto + Trim(Copy(LstListaTipiRapporto.Items[i],1,5));
      end;
  end;
end;

procedure TWA045FStatAssenze.ChkAssTutteAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if ChkAssTutte.Checked then
    ChkPartOr.Checked:=False;
  ChkPartOr.Enabled:=Not(ChkAssTutte.Checked);
end;

procedure TWA045FStatAssenze.chkElaboraAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  btnEsegui.Enabled:=chkElabora.Checked or (rgpStampa.ItemIndex > 0);
end;

procedure TWA045FStatAssenze.ChkPartOrAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if ChkPartOr.Checked then
    ChkAssTutte.Checked:=False;
  ChkAssTutte.Enabled:=Not(ChkPartOr.Checked);
end;

procedure TWA045FStatAssenze.chkStampaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  btnEsegui.Enabled:=chkElabora.Checked or chkStampa.Checked;
  if (not chkElabora.Checked) and chkStampa.Checked then
    chkElabora.Checked:=True;
end;

procedure TWA045FStatAssenze.GetParametriFunzione;
{Leggo i parametri della form}
begin
  EdtCausali.Text:=C004DM.GetParametro('CAUSALI', '');
  ChkContNumDip.Checked:=C004DM.GetParametro('CONTNUMDIP', 'S') = 'S';
  chkGGLavorativi.Checked:=C004DM.GetParametro('GGLAVORATIVI', 'S') = 'S';
  chkSantoPatrono.Checked:=C004DM.GetParametro('SANTOPATRONO', 'N') = 'S';
  chkAssTutte.Checked:=C004DM.GetParametro('TEORICOGG', 'S') = 'S';
end;

procedure TWA045FStatAssenze.PopolaListaQualifiche;
var i: Integer;
    LstQualifiche:TStringList;
begin
  LstQualifiche:=A045MW.CreaListaQualifiche;
  LstListaCausali.Items.Assign(LstQualifiche);
  FreeAndNil(LstQualifiche);
  for i:=0 to lstListaCausali.Items.Count - 1 do
    lstListaCausali.IsChecked[i]:=True;
end;

procedure TWA045FStatAssenze.PopolaListaTipiRapporto;
var i: Integer;
    LstRapporti:TStringList;
begin
  LstRapporti:=A045MW.CreaListaTipiRapporto;
  LstListaTipiRapporto.Items.Assign(LstRapporti);
  FreeAndNil(LstRapporti);
  for i:=0 to LstListaTipiRapporto.Items.Count - 1 do
    LstListaTipiRapporto.IsChecked[i]:=True;
end;

procedure TWA045FStatAssenze.PutParametriFunzione;
{Scrivo i parametri della form}
begin
  C004DM.Cancella001;
  C004DM.PutParametro('CAUSALI',EdtCausali.Text);
  if ChkContNumDip.Checked then
    C004DM.PutParametro('CONTNUMDIP','S')
  else
    C004DM.PutParametro('CONTNUMDIP','N');
  if chkGGLavorativi.Checked then
    C004DM.PutParametro('GGLAVORATIVI', 'S')
  else
    C004DM.PutParametro('GGLAVORATIVI', 'N');
  if chkSantoPatrono.Checked then
    C004DM.PutParametro('SANTOPATRONO', 'S')
  else
    C004DM.PutParametro('SANTOPATRONO', 'N');
  if chkAssTutte.Checked then
    C004DM.PutParametro('TEORICOGG', 'S')
  else
    C004DM.PutParametro('TEORICOGG', 'N');
  try SessioneOracle.Commit; except end;
end;

procedure TWA045FStatAssenze.rgpArrotondamentoAssenzaClick(Sender: TObject);
begin
  if rgpArrotondamentoAssenza.ItemIndex > 0 then
    rgpTipoArrotondamentoAssenza.Enabled:=true
  else
  begin
    rgpTipoArrotondamentoAssenza.ItemIndex:=2;
    rgpTipoArrotondamentoAssenza.Enabled:=false;
  end;
end;

procedure TWA045FStatAssenze.rgpArrotondamentoQualificaClick(Sender: TObject);
begin
  if rgpArrotondamentoQualifica.ItemIndex > 0 then
    rgpTipoArrotondamentoQualifica.Enabled:=true
  else
  begin
    rgpTipoArrotondamentoQualifica.ItemIndex:=2;
    rgpTipoArrotondamentoQualifica.Enabled:=false;
  end;
end;

procedure TWA045FStatAssenze.rgpArrotondamentoTotaleClick(Sender: TObject);
begin
  if rgpArrotondamentoTotale.ItemIndex > 0 then
    rgpTipoArrotondamentoTotale.Enabled:=true
  else
  begin
    rgpTipoArrotondamentoTotale.ItemIndex:=2;
    rgpTipoArrotondamentoTotale.Enabled:=false;
  end;
end;

procedure TWA045FStatAssenze.rgpStampaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  btnEsegui.Enabled:=chkElabora.Checked or (rgpStampa.ItemIndex > 0);
  if (not chkElabora.Checked) and (rgpStampa.ItemIndex > 0) then
    chkElabora.Checked:=True;
end;

procedure TWA045FStatAssenze.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  if Errore then
    SessioneOracle.Rollback
  else
    SessioneOracle.Commit;
  PutParametriFunzione;
end;

procedure TWA045FStatAssenze.DomandaAnteprimaUltimaOperaz(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    btnEseguiClick(nil)
  else
    MsgBox.ClearKeys;
end;

procedure TWA045FStatAssenze.DomandaStampaUltimaOperaz(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
    btnEseguiClick(nil)
  else
    MsgBox.ClearKeys;
end;

procedure TWA045FStatAssenze.evtA045MergeSelAnagrafe(DataSet: TOracleDataSet; RicreaVariabili: Boolean);
begin
  grdC700.WC700FM.C700MergeSelAnagrafe(DataSet,RicreaVariabili);
end;

procedure TWA045FStatAssenze.evtA045MergeSettaPeriodo(DataSet: TOracleDataSet; DataDa, DataA: TDateTime);
begin
  grdC700.WC700FM.C700MergeSettaPeriodo(DataSet,DataDa,DataA);
end;

procedure TWA045FStatAssenze.evtA045ShowMsg(Msg: String);
begin
 MsgBox.WebMessageDlg(Msg,mtInformation,[mbOk],nil,'');
end;

function TWA045FStatAssenze.evtA045SqlCreatoC700: String;
begin
  Result:=grdC700.WC700FM.SQLCreato.Text
end;

procedure TWA045FStatAssenze.ImpostazioniWC700;
begin
  //Caratto 03/10/2014 Impostato date WC700 con date del MW perchè la selezione
  //iniziale deve già essere eseguita con le date del MW
  grdC700.WC700FM.C700DataDal:=A045MW.DataInizio;
  grdC700.WC700FM.C700DataLavoro:= A045MW.DataFine;
end;

procedure TWA045FStatAssenze.InizioElaborazione;
begin
  DataCorr:=A045MW.DataInizio;
  DataInizioTmp:=A045MW.DataInizio;
  DataFineTmp:=A045MW.DataFine;
end;

procedure TWA045FStatAssenze.ElaboraElemento;
begin
  A045MW.DataInizio:=DataCorr;
  A045MW.DataFine:=Min(R180FineMese(DataCorr),DataFineTmp);
  MessaggioStatus(INFORMA,'Elaborazione ' + R180NomeMese(R180Mese(A045MW.DataFine)) + ' ' + IntToStr(R180Anno(A045MW.DataFine)) + ' in corso...');
  A045MW.SvuotaLista;
  EstrazioneAssenze;
  A045MW.OrdinaListaDip;
  //Chiamata a 'GeneraTabella'
  A045MW.ArrotondamentoTotaleItemIndex:=rgpArrotondamentoTotale.ItemIndex;
  A045MW.TipoArrotondamentoTotaleItemIndex:=rgpTipoArrotondamentoTotale.ItemIndex;
  A045MW.GeneraTabella;
  DataCorr:=R180InizioMese(R180AddMesi(DataCorr,1));
end;

procedure TWA045FStatAssenze.FineCicloElaborazione;
begin
  A045MW.DataInizio:=DataInizioTmp;
  A045MW.DataFine:=DataFineTmp;

  if (rgpStampa.ItemIndex > 0) then
  begin
    CallDCOMPrinter;
    NomeFileGenerato:=DCOMNomeFile;
    Exit;
  end;
end;

function TWA045FStatAssenze.TotalRecordsElaborazione: Integer;
begin
  Result:= Round(DataFineTmp) - Round(DataInizioTmp);
end;

procedure TWA045FStatAssenze.WC700AperturaSelezione(Sender: TObject);
var
  D: TDateTime;
begin
  if TryStrToDate(edtDaData.Text,D) then
    grdC700.WC700FM.C700DataDal:=D;

  if TryStrToDate(edtAData.Text,D) then
    grdC700.WC700FM.C700DataLavoro:=D;
end;

function TWA045FStatAssenze.ElementoSuccessivo: Boolean;
begin
  Result:=DataCorr <= DataFineTmp;
end;

function TWA045FStatAssenze.CurrentRecordElaborazione: Integer;
begin
  WC019FProgressBarFM.MessaggioStep2:='Elaborazione ' + R180NomeMese(R180Mese(A045MW.DataFine)) + ' ' + IntToStr(R180Anno(A045MW.DataFine)) + ' in corso...';
  Result:= (Round(DataFineTmp) - Round(DataInizioTmp)) - (Round(DataFineTmp) - Round(DataCorr));
end;

function TWA045FStatAssenze.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaData,json);
    C190Comp2JsonString(edtCausali,json);
    C190Comp2JsonString(edtAData,json);

    C190Comp2JsonString(rgpArrotondamentoQualifica,json);
    C190Comp2JsonString(rgpTipoArrotondamentoQualifica,json);
    C190Comp2JsonString(rgpArrotondamentoAssenza,json);
    C190Comp2JsonString(rgpTipoArrotondamentoAssenza,json);
    C190Comp2JsonString(rgpArrotondamentoTotale,json);
    C190Comp2JsonString(rgpTipoArrotondamentoTotale,json);

    C190Comp2JsonString(chkGGLavorativi,json);
    C190Comp2JsonString(ChkAssTutte,json);
    C190Comp2JsonString(ChkPartOr,json);
    // Chiamata: 125859.ini - BugFix: Versione: 10.5(3) - PALERMO_UNIVERSITA
    //C190Comp2JsonString(ChkAssTutte,json);
    C190Comp2JsonString(chkContNumDip,json);
    // Chiamata: 125859.fine
    C190Comp2JsonString(chkSantoPatrono,json);

    json.AddPair('LstListaCausali',TJSONString.Create(C190GetCheckList(6,LstListaCausali)));
    json.AddPair('LstListaTipiRapporto',TJSONString.Create(C190GetCheckList(6,LstListaTipiRapporto)));

    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

end.
