unit WA104UStampaMissioni;

interface

uses
  Windows, ActiveX,Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, medpIWStatusBar,
  meIWImageFile, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, WC013uCheckListFM, A000UCostanti, A000UMessaggi, C180FunzioniGenerali,
  A000UInterfaccia, IWCompCheckbox, meIWCheckBox, medpIWImageButton, WC022UMsgElaborazioneFM,
  DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}C190FunzioniGeneraliWeb, Data.DB, Datasnap.DBClient,
  Datasnap.Win.MConnect, StrUtils, meIWRadioGroup;

type
  TWA104FStampaMissioni = class(TWR100FBase)
    lblMeseScaricoDa: TmeIWLabel;
    edtMeseScaricoDa: TmeIWEdit;
    lblMeseScaricoA: TmeIWLabel;
    edtMeseScaricoA: TmeIWEdit;
    lblStato: TmeIWLabel;
    edtStato: TmeIWEdit;
    btnStato: TmeIWButton;
    ChkSaltoPagina: TmeIWCheckBox;
    lblTitolo: TmeIWLabel;
    EdtTitolo: TmeIWEdit;
    btnGeneraPDF: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    lblOrdinamento: TmeIWLabel;
    rgpOrdinamento: TmeIWRadioGroup;
    btnGeneraTXT: TmedpIWImageButton;
    procedure btnStatoClick(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnGeneraTXTClick(Sender: TObject);
  private
    StampaTXT: Boolean;
    LstCodStatiMissione,
    LstDescStatiMissione: TStringList;
    WC013: TWC013FCheckListFM;
    procedure StatiMissioneResult(Sender: TObject; Result: Boolean);
    procedure GetParametriFunzione;
    function CreateJSonString: String;
    procedure PutParametriFunzione;
  protected
    procedure ElaborazioneServer; override;
  end;

implementation

{$R *.dfm}

procedure TWA104FStampaMissioni.btnGeneraPDFClick(Sender: TObject);
begin
  StampaTXT:=False;
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA104FStampaMissioni.btnGeneraTXTClick(Sender: TObject);
begin
  inherited;
  StampaTXT:=True;
  WC022FMsgElaborazioneFM:=TWC022FMsgElaborazioneFM.Create(Self);
  WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_TXT;
  WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_TXT_IN_CORSO;
  StartElaborazioneServer(btnGeneraTXT.HTMLName);
end;

procedure TWA104FStampaMissioni.btnStatoClick(Sender: TObject);
var
  LstStatiSelezionati : TStringList;
begin
  WC013:=TWC013FCheckListFM.Create(Self.Owner);
  WC013.CaricaLista(LstDescStatiMissione,LstCodStatiMissione);
  LstStatiSelezionati:=TStringList.Create;
  LstStatiSelezionati.CommaText:=edtStato.Text;
  WC013.ImpostaValoriSelezionati(LstStatiSelezionati);
  FreeAndNil(LstStatiSelezionati);
  WC013.ResultEvent:=StatiMissioneResult;
  WC013.Visualizza(0,0,'<WC013> Stati missione');
end;

procedure TWA104FStampaMissioni.StatiMissioneResult(Sender: TObject; Result: Boolean);
var
  lstTmp: TStringList;
begin
  if Result then
  begin
    lstTmp:=WC013.LeggiValoriSelezionati;
    edtStato.Text:=lstTmp.CommaText;
    FreeAndNil(lstTmp);
  end;
end;

procedure TWA104FStampaMissioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGestioneC700;
  LstCodStatiMissione:=TStringList.Create;
  LstCodStatiMissione.add(COD_MISSIONE_DA_LIQUIDARE);
  LstCodStatiMissione.add(COD_MISSIONE_LIQUIDATA);
  LstCodStatiMissione.add(COD_MISSIONE_PARZ_LIQUIDATA);
  LstCodStatiMissione.add(COD_MISSIONE_SOSPESA);

  LstDescStatiMissione:=TStringList.Create;
  LstDescStatiMissione.add(DESC_MISSIONE_DA_LIQUIDARE);
  LstDescStatiMissione.add(DESC_MISSIONE_LIQUIDATA);
  LstDescStatiMissione.add(DESC_MISSIONE_PARZ_LIQUIDATA);
  LstDescStatiMissione.add(DESC_MISSIONE_SOSPESA);

  GetParametriFunzione;
end;

procedure TWA104FStampaMissioni.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(LstCodStatiMissione);
  FreeAndNil(LstDescStatiMissione);
  inherited;
end;

procedure TWA104FStampaMissioni.GetParametriFunzione;
begin
  edtMeseScaricoDa.Text:=C004DM.GetParametro('CASSADA', FormatDateTime('mm/yyyy',(R180InizioMese(Parametri.DataLavoro))));
  edtMeseScaricoA.Text:=C004DM.GetParametro('CASSAA', FormatDateTime('mm/yyyy',(R180FineMese(Parametri.DataLavoro))));
  edtStato.Text:=C004DM.GetParametro('STATO','');
  ChkSaltoPagina.Checked:=C004DM.GetParametro('SALTOPG', 'S') = 'S';
  rgpOrdinamento.ItemIndex:=StrToInt(C004DM.GetParametro('ORDINAMENTO', '0'));

  EdtTitolo.Text:=C004DM.GetParametro('TITOLO','RIEPILOGO LIQUIDAZIONI MENSILI');
end;

function TWA104FStampaMissioni.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    json.AddPair('TXT',IfThen(StampaTXT,'S','N'));
    C190Comp2JsonString(edtMeseScaricoDa,json);
    C190Comp2JsonString(edtMeseScaricoA,json);
    C190Comp2JsonString(edtStato,json);
    C190Comp2JsonString(ChkSaltoPagina,json);
    C190Comp2JsonString(EdtTitolo,json);
    C190Comp2JsonString(rgpOrdinamento,json);
    Result:=json.ToString;
    FreeAndNil(json);
  finally
    FreeAndNil(json);
  end;
end;


procedure TWA104FStampaMissioni.ElaborazioneServer;
var DettaglioLog:OleVariant;
    DatiUtente: String;
begin
  //Chiamo Servizio COM B028 per creare il pdf su server
  if StampaTXT then
    DCOMNomeFile:=GetNomeFile('txt')
  else
    DCOMNomeFile:=GetNomeFile('pdf');
  ForceDirectories(ExtractFileDir(DCOMNomeFile));
  DatiUtente:=CreateJSonString;
  if (not IsLibrary) and
     (Pos(INI_PAR_NO_COINITIALIZE,W000ParConfig.ParametriAvanzati) = 0) then // gestione parametri di configurazione su file
    CoInitialize(nil);
  if not DCOMConnection.Connected then
    DCOMConnection.Connected:=True;
  try
    DCOMConnection.AppServer.PrintA104(grdC700.selAnagrafe.SubstitutedSQL,
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

procedure TWA104FStampaMissioni.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004DM.Cancella001;
  C004DM.PutParametro('CASSADA',edtMeseScaricoDa.Text);
  C004DM.PutParametro('CASSAA',edtMeseScaricoA.Text);
  C004DM.PutParametro('STATO',edtStato.Text);
  C004DM.PutParametro('SALTOPG',ifThen(chkSaltoPagina.Checked ,'S','N'));
  C004DM.PutParametro('ORDINAMENTO', rgpOrdinamento.ItemIndex.ToString);
  C004DM.PutParametro('TITOLO',EdtTitolo.Text);

  try SessioneOracle.Commit; except end;

end;

end.
