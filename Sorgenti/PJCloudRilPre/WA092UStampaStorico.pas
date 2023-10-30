unit WA092UStampaStorico;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton, IWCompCheckbox, meIWCheckBox, IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompEdit, meIWEdit, IWAdvCheckGroup, meTIWAdvCheckGroup, IWCompLabel, meIWLabel, Menus,
  A092UStampaStoricoMW, A000UInterfaccia, DB, DBClient, MConnect, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF} C190FunzioniGeneraliWeb,
  A000UCostanti, A000UMessaggi, WC015USelEditGridFM, C180FunzioniGenerali, ActiveX;

type
  TWA092FStampaStorico = class(TWR100FBase)
    lblLstAnagra: TmeIWLabel;
    cgpAnagra: TmeTIWAdvCheckGroup;
    lblDaData: TmeIWLabel;
    edtDaData: TmeIWEdit;
    lblAData: TmeIWLabel;
    edtAData: TmeIWEdit;
    rgpOrdinamento: TmeTIWAdvRadioGroup;
    chkVariazioni: TmeIWCheckBox;
    chkSaltoPagina: TmeIWCheckBox;
    btnGeneraPDF: TmedpIWImageButton;
    DCOMConnection: TDCOMConnection;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    btnVisStampa: TmedpIWImageButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure btnVisStampaClick(Sender: TObject);
  private
    A092MW: TA092FStampaStoricoMW;
    WC015:TWC015FSelEditGridFM;
    FElabSenderHTMLName: String;
    ElencoDatiAnagrafe: String;
    ElencoDatiAnagrafeP430: String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ElaborazioneServer; override;
    function  CreateJSonString: String;
    function  ControlliValidita:boolean;
  protected
    procedure InizializzaMsgElaborazione; override;
    procedure InizioElaborazione; override;
    function  TotalRecordsElaborazione: Integer; override;
    procedure AfterElaborazione; override;
    procedure ElaboraElemento; override;
    function  ElementoSuccessivo:boolean; override;

  public
    { Public declarations }
    Stipendi:Boolean;
  end;


implementation

{$R *.dfm}

procedure TWA092FStampaStorico.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGestioneC700;
  A092MW:=TA092FStampaStoricoMW.Create(Self);
  Stipendi:=UpperCase(Parametri.Applicazione) = 'PAGHE';
  A092MW.Inizializza(Stipendi);

  edtDaData.Text:=DateToStr(Date);
  edtAData.Text:=DateToStr(Date);
  CgpAnagra.Items.Clear;

  with A092MW.Q010S do
    begin
    First;
    while not Eof do
      begin
      if (FieldByName('COLUMN_NAME').AsString <> 'PROGRESSIVO') and
         (FieldByName('COLUMN_NAME').AsString <> 'DATADECORRENZA') and
         (FieldByName('COLUMN_NAME').AsString <> 'DATAFINE') and
         (FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA') and
         (FieldByName('COLUMN_NAME').AsString <> 'DECORRENZA_FINE') then
        CgpAnagra.Items.Add(FieldByName('NOME_LOGICO').AsString);
      Next;
      end;
    end;
  GetParametriFunzione;
end;

procedure TWA092FStampaStorico.btnGeneraPDFClick(Sender: TObject);
begin
  if ControlliValidita then
  begin
    FElabSenderHTMLName:=btnGeneraPDF.HTMLName;
    PutParametriFunzione;
    StartElaborazioneServer(btnGeneraPDF.HTMLName);
  end;
end;

procedure TWA092FStampaStorico.ElaborazioneServer;
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
    DCOMConnection.AppServer.PrintA092(grdC700.selAnagrafe.SubstitutedSQL,
                                       DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
    DCOMMsg:=DettaglioLog;
  end;
end;

function TWA092FStampaStorico.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    json.AddPair('Parametri.Applicazione',TJSONString.Create(Parametri.Applicazione));
    C190Comp2JsonString(edtDaData,json);
    C190Comp2JsonString(edtAData,json);
    C190Comp2JsonString(rgpOrdinamento,json);
    json.AddPair('CgpAnagra',TJSONString.Create(C190GetCheckList(40,cgpAnagra)));
    C190Comp2JsonString(chkVariazioni,json);
    C190Comp2JsonString(chkSaltoPagina,json);
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

procedure TWA092FStampaStorico.Deselezionatutto1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CgpAnagra.Items.Count - 1 do
    CgpAnagra.IsChecked[i]:=False;
  CgpAnagra.AsyncUpdate;
end;

procedure TWA092FStampaStorico.GetParametriFunzione;
{Leggo i parametri della form}
var x,i:integer;
    svalore, snome, selemento:string;
begin
  chkSaltoPagina.Checked:=C004DM.GetParametro('SALTOPAGINA','N') = 'S';
  chkVariazioni.Checked:=C004DM.GetParametro('SOLOVARIAZIONI','N') = 'S';
  rgpOrdinamento.ItemIndex:=StrToInt(C004DM.GetParametro('ORDINAMENTO','0'));
  x:=0;
  snome:='LISTAANAGRA';
  while VarToStr(C004DM.GetParametro(snome + IntToStr(x),'')) <> '' do
  begin
    svalore:=C004DM.GetParametro(snome + IntToStr(x),'');
    svalore:=svalore + IfThen(svalore = '','',',');
    while Pos(',',svalore) > 0 do
    begin
      selemento:=Trim(Copy(svalore,1,Pos(',',svalore) - 1));
      svalore:=Trim(Copy(svalore,Pos(',',svalore) + 1));
      for i:=0 to CgpAnagra.Items.Count - 1 do
      begin
        if VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',CgpAnagra.Items[i],'COLUMN_NAME')) = selemento then
          CgpAnagra.IsChecked[i]:=true;
      end;
    end;
    inc(x);
  end;
end;

procedure TWA092FStampaStorico.PutParametriFunzione;
{Scrivo i parametri della forma}
var i,x,y:integer;
    svalore,snome:string;
begin
  C004DM.Cancella001;
  if chkSaltoPagina.Checked then
    C004DM.PutParametro('SALTOPAGINA','S')
  else
    C004DM.PutParametro('SALTOPAGINA','N');
  if chkVariazioni.Checked then
    C004DM.PutParametro('SOLOVARIAZIONI','S')
  else
    C004DM.PutParametro('SOLOVARIAZIONI','N');
  C004DM.PutParametro('ORDINAMENTO',IntToStr(rgpOrdinamento.ItemIndex));
  // salvo l'elenco dei campi di anagrafe selezionate
  x:=0; //contatore parametri causali
  y:=0; //contatore elementi per parametro
  svalore:='';
  snome:='LISTAANAGRA';
  For i:=0 to CgpAnagra.Items.Count - 1 do
  begin
    if CgpAnagra.IsChecked[i] then
    begin
      svalore:=svalore + IfThen(svalore = '','',',');
      svalore:=svalore + Trim(Format('%-30s',[VarToStr(A092MW.Q010S.Lookup('NOME_LOGICO',CgpAnagra.Items[i],'COLUMN_NAME'))]));
      inc(y);
      if y = 3 then
      begin
        C004DM.PutParametro(snome + IntToStr(x),svalore);
        inc(x);
        y:=0;
        svalore:='';
      end;
    end;
  end;
  C004DM.PutParametro(snome + IntToStr(x),svalore);
  try SessioneOracle.Commit; except end;
end;

procedure TWA092FStampaStorico.Selezionatutto1Click(Sender: TObject);
var
 i:Integer;
begin
  inherited;
  for i:=0 to CgpAnagra.Items.Count - 1 do
    CgpAnagra.IsChecked[i]:=True;
  CgpAnagra.AsyncUpdate;
end;

procedure TWA092FStampaStorico.Invertiselezione1Click(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to CgpAnagra.Items.Count - 1 do
    CgpAnagra.IsChecked[i]:=not CgpAnagra.IsChecked[i];
  CgpAnagra.AsyncUpdate;
end;


// -- gc: 13/09/2019 --

procedure TWA092FStampaStorico.btnVisStampaClick(Sender: TObject);
begin
  inherited;
  if ControlliValidita then
  begin
    FElabSenderHTMLName:=btnVisStampa.HTMLName;
    PutParametriFunzione;
    StartElaborazioneCicloServer(btnSendFile.HTMLName,True);
  end;
end;

function TWA092FStampaStorico.ControlliValidita: boolean;
var i:Integer;
    ok:boolean;
    DaData,AData:TDateTime;
begin
  Result:=True;
  grdC700.SelAnagrafe.Open;
  if grdC700.selAnagrafe.RecordCount=0 then
  begin
    Result:=False;
    MsgBox.MessageBox(A000MSG_A092_ERR_ANAGRAFE, ERRORE);
    exit;
  end;

  ok:=False;

  DaData:=StrToDate(edtDaData.Text);
  AData:=StrToDate(edtAData.Text);
  // Carico StringList usata per centralizzare scrittura del record
  A092MW.FParametriInterfaccia.ListaAnagra.Clear;
  for i:=0 to CgpAnagra.Items.Count - 1 do
    if CgpAnagra.IsChecked[i] then
      A092MW.FParametriInterfaccia.ListaAnagra.Add(CgpAnagra.Items[i]);
  A092MW.SetFiltriDatiAnagrafe;
  A092MW.FParametriInterfaccia.DaData:=DaData;
  A092MW.FParametriInterfaccia.AData:=AData;
  A092MW.FParametriInterfaccia.chkVariazioni:=chkVariazioni.Checked;
  A092MW.FParametriInterfaccia.IsApplicazionePaghe:=Stipendi;

  ok:=A092MW.FParametriInterfaccia.ListaAnagra.Count > 0;

  if not Ok then
  begin
    Result:=False;
    MsgBox.MessageBox(A000MSG_A092_ERR_DATO_ANAGRAFE, ERRORE);
    exit;
  end;
end;

procedure TWA092FStampaStorico.InizioElaborazione;
var Index: String;
begin
  if rgpOrdinamento.ItemIndex=0 then
    Index:='Primary'
  else
    Index:='IdxData';
  A092MW.CreaTabellaStampa(Index);

  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;

end;

procedure TWA092FStampaStorico.ElaboraElemento;
var i,j,NV: integer;
begin
  // Carico parametri per centralizzare scrittura del record
  A092MW.FParametriInterfaccia.Progressivo:=grdC700.SelAnagrafe.FieldByName('PROGRESSIVO').Value;
  A092MW.FParametriInterfaccia.Nominativo:=grdC700.SelAnagrafe.FieldByName('Cognome').AsString+' '+grdC700.SelAnagrafe.FieldByName('Nome').AsString;
  A092MW.FParametriInterfaccia.Matricola:=grdC700.SelAnagrafe.FieldByName('Matricola').AsString;

  // Richiamo metodo del Middleware per scrittura Dataset "TabellaStampa"
  A092MW.ElaborazioneElemento;
end;

function TWA092FStampaStorico.ElementoSuccessivo:boolean;
begin
  grdC700.selAnagrafe.Next;
  Result:=not grdC700.selAnagrafe.Eof;
end;

function TWA092FStampaStorico.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA092FStampaStorico.AfterElaborazione;
begin
  inherited;
  if FElabSenderHTMLName = btnVisStampa.HTMLName then
  begin
    A092MW.TabellaStampa.First;
    WC015:=TWC015FSelEditGridFM.Create(Self);
    WC015.Visualizza('Dettaglio elementi estratti',A092MW.TabellaStampa,False,False,False,1000);
  end;
end;

procedure TWA092FStampaStorico.InizializzaMsgElaborazione;
begin
  if FElabSenderHTMLName = btnGeneraPDF.HTMLName then
  begin
    WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_PDF_IN_CORSO;
    WC022FMsgElaborazioneFM.Titolo:=A000MSG_MSG_ELABORAZIONE;
    WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_PDF;
  end
  else
  begin
    WC022FMsgElaborazioneFM.Messaggio:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
    WC022FMsgElaborazioneFM.Titolo:=A000MSG_MSG_ELABORAZIONE;
    WC022FMsgElaborazioneFM.ImgFileName:=WC022FMsgElaborazioneFM.IMG_FILENAME_ELABORAZIONE;
  end;
end;

procedure TWA092FStampaStorico.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  inherited;
end;

end.
