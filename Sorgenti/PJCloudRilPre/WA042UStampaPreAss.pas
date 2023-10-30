unit WA042UStampaPreAss;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompCheckbox, meIWCheckBox, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, meIWRadioGroup, IWAdvCheckGroup,
  meTIWAdvCheckGroup, meIWImageFile, medpIWImageButton, IWAdvRadioGroup, meTIWAdvRadioGroup, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} USelI010,
  A000UInterfaccia, A000UMessaggi, A000UCostanti, ActiveX, C180FunzioniGenerali, C190FunzioniGeneraliWeb, DB, DBClient, MConnect,
  WA042UImpostazioniEUCausalizzateFM, WA042UImpostazioniProspettoFM, WA042UImpostazioniGraficoFM, A042UStampaPreAssMW, Menus,
  meIWImageButton, WC015USelEditGridFM, QueryStorico;

type
  TWA042FStampaPreAss = class(TWR100FBase)
    chkGiornoCorrente: TmeIWCheckBox;
    edtDaData: TmeIWEdit;
    lblDaData: TmeIWLabel;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    lblDaOra: TmeIWLabel;
    edtDaOra: TmeIWEdit;
    lblAOra: TmeIWLabel;
    edtAOra: TmeIWEdit;
    chkDescrizioneAssenze: TmeIWCheckBox;
    chkTurnista: TmeIWCheckBox;
    chkTabellare: TmeIWCheckBox;
    chkSaltoPaginaData: TmeIWCheckBox;
    chkTotaliData: TmeIWCheckBox;
    chkRaggData: TmeIWCheckBox;
    chkSaltoPagina: TmeIWCheckBox;
    chkTotaliGruppo: TmeIWCheckBox;
    chkTotali: TmeIWCheckBox;
    LstIntestazione: TmeTIWAdvCheckGroup;
    lblIntestazione: TmeIWLabel;
    LstDettaglio: TmeTIWAdvCheckGroup;
    lblDettaglio: TmeIWLabel;
    btnGeneraPDF: TmedpIWImageButton;
    rgpTipoStampa: TmeTIWAdvRadioGroup;
    lblTipoStampa: TmeIWLabel;
    BtnAvanzati: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    edtTitoloGrafico: TmeIWEdit;
    lblInfoAggiuntive: TmeIWLabel;
    lblTitoloGrafico: TmeIWLabel;
    chkVisLineeV: TmeIWCheckBox;
    chkVisLineeH: TmeIWCheckBox;
    pmnAzioniRaggr: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    pmnAzioniDett: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    btnVisStampa: TmedpIWImageButton;
    edtSeparatoreIntestazione: TmeIWEdit;
    lblSeparatoreIntestazione: TmeIWLabel;
    edtGGContinuativi: TmeIWEdit;
    lblGGContinuativi: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure LstIntestazioneClick(Sender: TObject);
    procedure LstDettaglioClick(Sender: TObject);
    procedure chkGiornoCorrenteAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtADataAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
    procedure chkRaggDataAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure chkTabellareAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure rgpTipoStampaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure BtnAvanzatiClick(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure btnVisStampaClick(Sender: TObject);
  private
    WA042FImpostazioniEUCausalizzateFM: TWA042FImpostazioniEUCausalizzateFM;
    WA042FImpostazioniProspettoFM: TWA042FImpostazioniProspettoFM;
    WA042FImpostazioniGraficoFM: TWA042FImpostazioniGraficoFM;
    WC015:TWC015FSelEditGridFM;
    procedure Abilitazioni;
    procedure GetParametriFunzione;
    procedure ElaborazioneServer; override;
    function CreateJSonString: String;
    procedure VisualizzaGrpInfoAggiuntive;
    function GetColoreA(Codice: String): Integer;
    function GetColoreP(Codice: String): Integer;
  protected
    procedure WC700AperturaSelezione(Sender: Tobject); override;
  public
    A042MW: TA042FStampaPreAssMW;
    procedure PutParametriFunzione;
  end;

implementation

{$R *.dfm}

procedure TWA042FStampaPreAss.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  A042MW:=TA042FStampaPreAssMW.Create(Self);
  A042MW.GetColoreA:=GetColoreA;
  A042MW.GetColoreP:=GetColoreP;
  AttivaGestioneC700;
  with A042MW.selI010 do
  begin
    while not Eof do
    begin
      LstIntestazione.Items.Add(FieldByName('NOME_LOGICO').AsString);
      LstDettaglio.Items.Add(FieldByName('NOME_LOGICO').AsString);
      Next;
    end;
  end;
  GetParametriFunzione;
  Abilitazioni;
end;

procedure TWA042FStampaPreAss.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
  if A042MW <> nil then
    FreeAndNil(A042MW);
end;

procedure TWA042FStampaPreAss.IWAppFormRender(Sender: TObject);
begin
  inherited;
  VisualizzaGrpInfoAggiuntive;
end;

procedure TWA042FStampaPreAss.WC700AperturaSelezione(Sender: Tobject);
begin
  grdC700.WC700FM.C700DataDal:=StrToDate(edtDaData.Text);
  grdC700.WC700FM.C700DataLavoro:=StrToDate(edtAData.Text);
end;

procedure TWA042FStampaPreAss.LstDettaglioClick(Sender: TObject);
var
  i:Integer;
begin
  A042MW.ListaDettaglio.Clear;
  for i:=0 to LstDettaglio.Items.Count - 1 do
    if LstDettaglio.IsChecked[i] then
      A042MW.ListaDettaglio.Add(VarToStr(A042MW.selI010.Lookup('NOME_LOGICO',LstDettaglio.Items[i],'NOME_CAMPO')));
  Abilitazioni;
end;

procedure TWA042FStampaPreAss.LstIntestazioneClick(Sender: TObject);
var
  i:Integer;
begin
  A042MW.ListaIntestazione.Clear;
  for i:=0 to LstIntestazione.Items.Count - 1 do
    if LstIntestazione.isChecked[i] then
      A042MW.ListaIntestazione.Add(VarToStr(A042MW.selI010.Lookup('NOME_LOGICO',LstIntestazione.Items[i],'NOME_CAMPO')));
  Abilitazioni;
end;

procedure TWA042FStampaPreAss.Abilitazioni;
begin
  BtnAvanzati.Enabled:=rgpTipoStampa.ItemIndex in [3,4,5];
  edtGGContinuativi.Enabled:=rgpTipoStampa.ItemIndex=2;
  lblGGContinuativi.Enabled:=edtGGContinuativi.Enabled;
  btnVisStampa.Enabled:=rgpTipoStampa.ItemIndex = 5;
  edtAData.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2,5]) and (not chkGiornoCorrente.Checked);;
  edtDaOra.Enabled:=rgpTipoStampa.ItemIndex in [0,4];
  edtAOra.Enabled:=rgpTipoStampa.ItemIndex in [0,4];
  chkTurnista.Enabled:=rgpTipoStampa.ItemIndex in [0,1,2];
  if not chkTurnista.Enabled then
    chkTurnista.Checked:=False;
  chkTabellare.Enabled:=rgpTipoStampa.ItemIndex in [2];
  if not chkTabellare.Enabled then
    chkTabellare.Checked:=False;

  LstIntestazione.Enabled:=rgpTipoStampa.ItemIndex in [0,1,2,4,5];
  lblSeparatoreIntestazione.Enabled:=lstIntestazione.Enabled;
  edtSeparatoreIntestazione.Enabled:=lstIntestazione.Enabled;

  chkSaltoPagina.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2,4]) and (A042MW.ListaIntestazione.Count > 0);
  if not chkSaltoPagina.Enabled then
    chkSaltoPagina.Checked:=False;
  chkTotaliGruppo.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (A042MW.ListaIntestazione.Count > 0) and
                           (not chkTabellare.Checked);
  if not chkTotaliGruppo.Enabled then
    chkTotaliGruppo.Checked:=False;
  chkTotali.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (not chkTabellare.Checked);
  if not chkTotali.Enabled then
    chkTotali.Checked:=False;

  chkRaggData.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (not chkTabellare.Checked);
  if not chkRaggData.Enabled then
    chkRaggData.Checked:=False;
  chkSaltoPaginaData.Enabled:=(chkRaggData.Checked) and (not chkSaltoPagina.Enabled);
  if not chkSaltoPaginaData.Enabled then
    chkSaltoPaginaData.Checked:=False;
  chkTotaliData.Enabled:=chkRaggData.Checked;
  if not chkTotaliData.Enabled then
    chkTotaliData.Checked:=False;

  LstDettaglio.Enabled:=(rgpTipoStampa.ItemIndex in [0,1,2]) and (not chkTabellare.Checked);
  chkDescrizioneAssenze.Enabled:=(rgpTipoStampa.ItemIndex = 1) and (not chkTabellare.Checked);
end;

procedure TWA042FStampaPreAss.BtnAvanzatiClick(Sender: TObject);
begin
  if rgpTipoStampa.ItemIndex = 3 then
  begin
    WA042FImpostazioniGraficoFM:=TWA042FImpostazioniGraficoFM.Create(Self);
    WA042FImpostazioniGraficoFM.Visualizza;
  end
  else if rgpTipoStampa.ItemIndex = 4 then
  begin
    WA042FImpostazioniProspettoFM:=TWA042FImpostazioniProspettoFM.Create(Self);
    WA042FImpostazioniProspettoFM.Visualizza;
  end
  else if rgpTipoStampa.ItemIndex = 5 then
  begin
    WA042FImpostazioniEUCausalizzateFM:=TWA042FImpostazioniEUCausalizzateFM.Create(Self);
    WA042FImpostazioniEUCausalizzateFM.Visualizza;
  end;
end;

procedure TWA042FStampaPreAss.btnGeneraPDFClick(Sender: TObject);
begin
  PutParametriFunzione;
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA042FStampaPreAss.btnVisStampaClick(Sender: TObject);
var
  i, nNumGiorni: integer;
  s:string;
  DaData, AData:TDateTime;
begin

  if grdC700.selAnagrafe.RecordCount <= 0 then
    raise Exception.Create('Nessun dipendente selezionato.');

  PutParametriFunzione;
  A042MW.SeparatoreIntestazione:=edtSeparatoreIntestazione.Text;
  if (A042MW.ListaIntestazione.Count > 0) or (A042MW.ListaDettaglio.Count > 0) then
  begin
    S:=grdC700.SelAnagrafe.SQL.Text;
    for i:=0 to A042MW.ListaIntestazione.Count - 1 do
      R180InserisciColonna(s,AliasTabella(A042MW.ListaIntestazione[i]) + '.' + A042MW.ListaIntestazione[i]);
    for i:=0 to A042MW.ListaDettaglio.Count - 1 do
      if Pos(A042MW.ListaDettaglio[i],Copy(S,1,Pos('FROM',S))) <= 0 then
        R180InserisciColonna(S,AliasTabella(A042MW.ListaDettaglio[i]) + '.' + A042MW.ListaDettaglio[i]);
    grdC700.SelAnagrafe.CloseAll;
    grdC700.SelAnagrafe.SQL.Text:=S;
  end;
  grdC700.SelAnagrafe.Open;

  TryStrToDate(edtDaData.Text,DaData);
  TryStrToDate(edtAData.Text,AData);

  nNumGiorni:=trunc(AData - DaData) + 1;
  A042MW.CreaTabellaStampaEUCausalizzate;
  A042MW.R502ProDtM1.Conteggi('APERTURA',0,Date);
  A042MW.R502ProDtM1.PeriodoConteggi(DaData, AData);
  A042MW.SelAnagrafe:=grdC700.SelAnagrafe;
  grdC700.SelAnagrafe.First;
  while not grdC700.SelAnagrafe.Eof do
  begin
    for i:= 0 to nNumGiorni - 1 do
    begin
      A042MW.TimbraturaMezzanotte:=False;
      //Eseguo i conteggi
      A042MW.R502ProDtM1.Conteggi('Cartolina',grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger, DaData + i);
      //ed inserisco i dati nella tabella...
      A042MW.InserisciDipendenteTabellaEUCausalizzate(grdC700.selAnagrafe.FieldByName('PROGRESSIVO').AsInteger, DaData + i);
    end;
    grdC700.SelAnagrafe.Next;
  end;
  A042MW.TabellaStampa.First;
  WC015:=TWC015FSelEditGridFM.Create(Self);
  WC015.Visualizza('Entrate/Uscite causalizzate',A042MW.TabellaStampa,False,False,False,1000);
end;

procedure TWA042FStampaPreAss.ElaborazioneServer;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA042(grdC700.selAnagrafe.SubstitutedSQL,
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

function TWA042FStampaPreAss.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDaData,json);
    C190Comp2JsonString(edtAData,json);
    C190Comp2JsonString(edtDaOra,json);
    C190Comp2JsonString(edtAOra,json);
    C190Comp2JsonString(edtGGContinuativi,json);
    C190Comp2JsonString(rgpTipoStampa,json);
    C190Comp2JsonString(edtSeparatoreIntestazione,json);
    json.AddPair('LstIntestazione',TJSONString.Create(C190GetCheckList(40,LstIntestazione)));
    json.AddPair('LstDettaglio',TJSONString.Create(C190GetCheckList(40,LstDettaglio)));

    C190Comp2JsonString(chkGiornoCorrente,json);
    C190Comp2JsonString(chkDescrizioneAssenze,json);
    C190Comp2JsonString(chkTurnista,json);
    C190Comp2JsonString(chkTabellare,json);
    C190Comp2JsonString(chkRaggData,json);
    C190Comp2JsonString(chkTotaliData,json);
    C190Comp2JsonString(chkSaltoPaginaData,json);
    C190Comp2JsonString(chkTotali,json);
    C190Comp2JsonString(chkTotaliGruppo,json);
    C190Comp2JsonString(chkSaltoPagina,json);

    //Informazioni aggiuntive per la stampa del grafico presenze/assenze
    C190Comp2JsonString(edtTitoloGrafico,json);
    C190Comp2JsonString(chkVisLineeV,json);
    C190Comp2JsonString(chkVisLineeH,json);
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA042FStampaPreAss.chkGiornoCorrenteAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  if chkGiornoCorrente.Checked then
  begin
    edtDaData.Text:=DateToStr(Date);
    edtAData.Text:=DateToStr(Date);
  end;
  edtDaData.Enabled:=not chkGiornoCorrente.Checked;
  edtAData.Enabled:=not chkGiornoCorrente.Checked;
  lblDaData.Enabled:=not chkGiornoCorrente.Checked;
  lblAData.Enabled:=not chkGiornoCorrente.Checked;
end;

procedure TWA042FStampaPreAss.chkRaggDataAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Abilitazioni;
end;

procedure TWA042FStampaPreAss.chkTabellareAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Abilitazioni;
end;

procedure TWA042FStampaPreAss.edtADataAsyncDoubleClick(Sender: TObject; EventParams: TStringList);
begin
  try
    edtAData.Text:=DateToStr(R180FineMese(StrToDate(edtDaData.Text)));
  except
  end;
end;

procedure TWA042FStampaPreAss.GetParametriFunzione;
var S:String;
  i:Integer;
begin
  edtDaData.Text:=DateToStr(R180InizioMese(Parametri.DataLavoro));
  edtAData.Text:=DateToStr(R180FineMese(Parametri.DataLavoro));
  chkGiornoCorrente.Checked:=C004DM.GetParametro('GIORNO_CORRENTE','N') = 'S';
  chkGiornoCorrenteAsyncClick(nil,nil);
  edtDaOra.Text:=C004DM.GetParametro('DAORA', '00.00');
  edtAOra.Text:=C004DM.GetParametro('AORA', '23.59');
  edtGGContinuativi.Text:=C004DM.GetParametro('GGCONTINUATIVI','0');
  rgpTipoStampa.ItemIndex:=StrToInt(C004DM.GetParametro('TIPOSTAMPA','0'));
  edtSeparatoreIntestazione.Text:=C004DM.GetParametro('SEPARATORE_INTESTAZIONE',' - ');
  chkDescrizioneAssenze.Checked:=C004DM.GetParametro('DESCRIZIONE_ASSENZE','N') = 'S';
  chkSaltoPagina.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
  chkTurnista.Checked:=C004DM.GetParametro('TURNISTA','N') = 'S';
  chkTabellare.Checked:=C004DM.GetParametro('STAMPATABELLARE','N') = 'S';
  chkRaggData.Checked:=C004DM.GetParametro('RAGGRUPPADATA','N') = 'S';
  chkTotaliData.Checked:=C004DM.GetParametro('TOTALIDATA','N') = 'S';
  chkSaltoPaginaData.Checked:=C004DM.GetParametro('SALTOPAGDATA','N') = 'S';
  chkTotaliGruppo.Checked:=C004DM.GetParametro('TOTALIGRUPPO','N') = 'S';
  chkTotali.Checked:=C004DM.GetParametro('TOTALIGEN','N') = 'S';
  S:=C004DM.GetParametro('CAMPORAGGRUPPA','');
  if Trim(S) <> '' then
  begin
    for i:=0 to LstIntestazione.Items.Count - 1 do
      if Pos(VarToStr(A042MW.selI010.Lookup('NOME_LOGICO',LstIntestazione.Items[i],'NOME_CAMPO')),S) > 0 then
        LstIntestazione.isChecked[i]:=True;
  end;
  LstIntestazioneClick(nil);
  S:=C004DM.GetParametro('CAMPODETTAGLIO','');
  if Trim(S) <> '' then
  begin
    for i:=0 to LstDettaglio.Items.Count - 1 do
      if Pos(VarToStr(A042MW.selI010.Lookup('NOME_LOGICO',LstDettaglio.Items[i],'NOME_CAMPO')),S) > 0 then
        LstDettaglio.isChecked[i]:=True;
  end;
  LstDettaglioClick(nil);


  A042MW.bPb_MostraCausaliNonAbbinate:=C004DM.GetParametro('CAUSALI_NON_ABBINATE','S') = 'S';
  //Carico l'array delle causali/colori...
  A042MW.PopolaArrayCausali;
  //Carico la causale da utilizzare per la stampaEUCausalizzate
  A042MW.sPb_CausaleEU:=C004DM.GetParametro('CAUSEU','');
  //Carico i parametri per il prospetto delle ore...
  A042MW.tPb_Limite1:=strtotime(C004DM.GetParametro('ORELIM1','5.00'));
  A042MW.bPb_Intervallo1:=C004DM.GetParametro('INT1','S') = 'S';
  A042MW.bPb_Giornata1:=C004DM.GetParametro('GIO1','N') = 'S';
  A042MW.tPb_Limite2:=strtotime(C004DM.GetParametro('ORELIM2','12.00'));
  A042MW.bPb_Intervallo2:=C004DM.GetParametro('INT2','N') = 'S';
  A042MW.bPb_Giornata2:=C004DM.GetParametro('GIO2','S') = 'S';
end;

procedure TWA042FStampaPreAss.PutParametriFunzione;
var
  i:integer;
begin
  C004DM.Cancella001;
  C004DM.PutParametro('GIORNO_CORRENTE', IfThen(chkGiornoCorrente.Checked,'S','N'));
  C004DM.PutParametro('DAORA', edtDaOra.Text);
  C004DM.PutParametro('AORA', edtAOra.Text);
  C004DM.PutParametro('GGCONTINUATIVI', edtGGContinuativi.Text);
  C004DM.PutParametro('TIPOSTAMPA',IntToStr(rgpTipoStampa.ItemIndex));
  C004DM.PutParametro('SEPARATORE_INTESTAZIONE',edtSeparatoreIntestazione.Text);
  C004DM.PutParametro('DESCRIZIONE_ASSENZE', IfThen(chkDescrizioneAssenze.Checked,'S','N'));
  if chkSaltoPagina.Checked then
    C004DM.PutParametro('SALTOPAGINA','S')
  else
    C004DM.PutParametro('SALTOPAGINA','N');
  if chkTurnista.Checked then
    C004DM.PutParametro('TURNISTA','S')
  else
    C004DM.PutParametro('TURNISTA','N');
  if chkTabellare.Checked then
    C004DM.PutParametro('STAMPATABELLARE','S')
  else
    C004DM.PutParametro('STAMPATABELLARE','N');
  C004DM.PutParametro('CAMPORAGGRUPPA',A042MW.ListaIntestazione.Text);
  C004DM.PutParametro('CAMPODETTAGLIO',A042MW.ListaDettaglio.Text);
  if chkRaggData.Checked then
    C004DM.PutParametro('RAGGRUPPADATA','S')
  else
    C004DM.PutParametro('RAGGRUPPADATA','N');
  if chkTotaliData.Checked then
    C004DM.PutParametro('TOTALIDATA','S')
  else
    C004DM.PutParametro('TOTALIDATA','N');
  if chkSaltoPaginaData.Checked then
    C004DM.PutParametro('SALTOPAGDATA','S')
  else
    C004DM.PutParametro('SALTOPAGDATA','N');
  if chkTotaliGruppo.Checked then
    C004DM.PutParametro('TOTALIGRUPPO','S')
  else
    C004DM.PutParametro('TOTALIGRUPPO','N');
  if chkTotali.Checked then
    C004DM.PutParametro('TOTALIGEN','S')
  else
    C004DM.PutParametro('TOTALIGEN','N');

  with A042MW do
  begin
    if bPb_MostraCausaliNonAbbinate then
      C004DM.PutParametro('CAUSALI_NON_ABBINATE','S')
    else
      C004DM.PutParametro('CAUSALI_NON_ABBINATE','N');
    //Adesso salvo i dati della mappa dei colori...
    //Memorizzo le causali di presenza...
    for i:=0 to length(aPb_CausaliPresenzaDb)-1 do
      C004DM.PutParametro('COLOREP_' + aPb_CausaliPresenzaDb[i].sCodice, IntToStr(aPb_CausaliPresenzaDb[i].xColore));
    //Memorizzo le causali di assenza...
    for i:=0 to length(aPb_CausaliAssenzaDb)-1 do
      C004DM.PutParametro('COLOREA_' + aPb_CausaliAssenzaDb[i].sCodice, IntToStr(aPb_CausaliAssenzaDb[i].xColore));

    //Salvo la causale da utilizzare per la stampaEUCausalizzate
    C004DM.PutParametro('CAUSEU', sPb_CausaleEU);

    //Salvo i parametri per il prospetto delle ore...
    C004DM.PutParametro('ORELIM1',FormatDateTime('hh.nn', tPb_Limite1));
    if bPb_Intervallo1 then
      C004DM.PutParametro('INT1','S')
    else
      C004DM.PutParametro('INT1','N');
    if bPb_Giornata1 then
      C004DM.PutParametro('GIO1','S')
    else
      C004DM.PutParametro('GIO1','N');
    C004DM.PutParametro('ORELIM2',FormatDateTime('hh.nn',tPb_Limite2));
    if bPb_Intervallo2 then
      C004DM.PutParametro('INT2','S')
    else
      C004DM.PutParametro('INT2','N');
    if bPb_Giornata2 then
      C004DM.PutParametro('GIO2','S')
    else
      C004DM.PutParametro('GIO2','N');
  end;

  try SessioneOracle.Commit; except end;
end;

procedure TWA042FStampaPreAss.rgpTipoStampaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  Abilitazioni;
  VisualizzaGrpInfoAggiuntive;
end;

procedure TWA042FStampaPreAss.Selezionatutto1Click(Sender: TObject);
var
 i:Integer;
begin
  inherited;
  for i:=0 to LstIntestazione.Items.Count - 1 do
    LstIntestazione.IsChecked[i]:=True;
  LstIntestazione.AsyncUpdate;
end;

procedure TWA042FStampaPreAss.Deselezionatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to LstIntestazione.Items.Count - 1 do
    LstIntestazione.IsChecked[i]:=False;
  LstIntestazione.AsyncUpdate;
end;

procedure TWA042FStampaPreAss.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to LstIntestazione.Items.Count - 1 do
    LstIntestazione.IsChecked[i]:=not LstIntestazione.IsChecked[i];
  LstIntestazione.AsyncUpdate;
end;

procedure TWA042FStampaPreAss.MenuItem1Click(Sender: TObject);
var
 i:Integer;
begin
  inherited;
  for i:=0 to LstDettaglio.Items.Count - 1 do
    LstDettaglio.IsChecked[i]:=True;
  LstDettaglio.AsyncUpdate;
end;

procedure TWA042FStampaPreAss.MenuItem2Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to LstDettaglio.Items.Count - 1 do
    LstDettaglio.IsChecked[i]:=False;
  LstDettaglio.AsyncUpdate;
end;

procedure TWA042FStampaPreAss.MenuItem3Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to LstDettaglio.Items.Count - 1 do
    LstDettaglio.IsChecked[i]:=not LstDettaglio.IsChecked[i];
  LstDettaglio.AsyncUpdate;
end;

function TWA042FStampaPreAss.GetColoreA(Codice: String): Integer;
begin
  Result:=strtoint(C004DM.GetParametro('COLOREA_' + Codice, inttostr(clWhite)));
end;

function TWA042FStampaPreAss.GetColoreP(Codice: String): Integer;
begin
  Result:=strtoint(C004DM.GetParametro('COLOREP_' + Codice, inttostr(clWhite)));
end;

procedure TWA042FStampaPreAss.VisualizzaGrpInfoAggiuntive;
begin
  if rgpTipoStampa.ItemIndex = 3 then // solo se scelgo grafico presenze/assenze
    AddToInitProc('$(''.InfoAggiuntiveGrafico'').show(''slow'');')
  else
    AddToInitProc('$(''.InfoAggiuntiveGrafico'').hide(''slow'');');

  if rgpTipoStampa.ItemIndex = 2 then // solo se scelgo grafico presenze/assenze
    AddToInitProc('$(''.GGContinuativi'').show(''slow'');')
  else
    AddToInitProc('$(''.GGContinuativi'').hide(''slow'');');
end;

end.

