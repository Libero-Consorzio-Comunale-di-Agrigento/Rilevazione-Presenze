unit WP690UStampaFondi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids,
  meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, WP690UStampaFondiDM,
  meIWImageFile, medpIWImageButton, IWTMSCheckList, meTIWCheckListBox,
  IWCompCheckbox, meIWCheckBox, IWCompLabel, meIWLabel, IWApplication, Vcl.Menus,
  Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  StrUtils, A000UMessaggi, A000UCostanti, A000UInterfaccia, ActiveX,
  C180FunzioniGenerali, C190FunzioniGeneraliWeb;

type
  TWP690FStampaFondi = class(TWR100FBase)
    lblDecorrenzaDa: TmeIWLabel;
    lblDecorrenzaA: TmeIWLabel;
    edtDecorrenzaDa: TmeIWEdit;
    edtDecorrenzaA: TmeIWEdit;
    btnDate: TmeIWButton;
    chkRaggruppa: TmeIWCheckBox;
    lblFondi: TmeIWLabel;
    clbFondi: TmeTIWCheckListBox;
    btnGeneraPDF: TmedpIWImageButton;
    chkDettRisorse: TmeIWCheckBox;
    chkDettDestinazioni: TmeIWCheckBox;
    pmnAzioni: TPopupMenu;
    Selezionatutto1: TMenuItem;
    Deselezionatutto1: TMenuItem;
    Invertiselezione1: TMenuItem;
    DCOMConnection: TDCOMConnection;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure edtDecorrenzaDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure edtDecorrenzaAAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure btnDateClick(Sender: TObject);
    procedure Selezionatutto1Click(Sender: TObject);
    procedure Deselezionatutto1Click(Sender: TObject);
    procedure Invertiselezione1Click(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
  private
    { Private declarations }
    WP690DM: TWP690FStampaFondiDM;
    ListaFondiSel:String;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    procedure ForzaSubmit;
    procedure AggiornaListaFondi;
    procedure ElaborazioneServer; override;
    function CreateJSonString: String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWP690FStampaFondi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WP690DM:=TWP690FStampaFondiDM.Create(Self);
  GetParametriFunzione;
  AggiornaListaFondi;
end;

procedure TWP690FStampaFondi.IWAppFormDestroy(Sender: TObject);
begin
  PutParametriFunzione;
  FreeAndNil(WP690DM);
  inherited;
end;

procedure TWP690FStampaFondi.GetParametriFunzione;
begin
  edtDecorrenzaDa.Text:=C004DM.GetParametro('edtDecorrenzaDa','01/01/' + IntToStr(R180Anno(Parametri.DataLavoro)));
  edtDecorrenzaA.Text:=C004DM.GetParametro('edtDecorrenzaA','31/12/' + IntToStr(R180Anno(Parametri.DataLavoro)));
end;

procedure TWP690FStampaFondi.PutParametriFunzione;
var Data: TDateTime;
begin
  C004DM.Cancella001;
  if TryStrToDate(edtDecorrenzaDa.Text,Data) then
    C004DM.PutParametro('edtDecorrenzaDa',edtDecorrenzaDa.Text);
  if TryStrToDate(edtDecorrenzaA.Text,Data) then
    C004DM.PutParametro('edtDecorrenzaA',edtDecorrenzaA.Text);

  try SessioneOracle.Commit; except end;
end;

procedure TWP690FStampaFondi.edtDecorrenzaDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ForzaSubmit;
end;

procedure TWP690FStampaFondi.edtDecorrenzaAAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  ForzaSubmit;
end;

procedure TWP690FStampaFondi.ForzaSubmit;
begin
  //Forzo un submit che richiama il click di un pulsante nascosto, così la maschera si riaggiorna
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnDate.HTMLName]));
end;

procedure TWP690FStampaFondi.btnDateClick(Sender: TObject);
begin
  inherited;
  AggiornaListaFondi;
end;

procedure TWP690FStampaFondi.AggiornaListaFondi;
var i:Integer;
begin
  //Carico in clbFondi l'elenco dei fondi appena recuperato
  if WP690DM.P690MW.FondiDisponibili(StrToDate(edtDecorrenzaDa.Text),StrToDate(edtDecorrenzaA.Text)) then
  begin
    clbFondi.Items.Clear;
    for i:=0 to WP690DM.P690MW.ListaFondi.Count - 1 do
    begin
      clbFondi.Items.Add(WP690DM.P690MW.ListaFondi[i]);
      clbFondi.Selected[clbFondi.Items.Count - 1]:=False;
    end;
  end;
end;

procedure TWP690FStampaFondi.Selezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbFondi.Items.Count - 1 do
    clbFondi.Selected[i]:=True;
  clbFondi.AsyncUpdate;
end;

procedure TWP690FStampaFondi.Deselezionatutto1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbFondi.Items.Count - 1 do
    clbFondi.Selected[i]:=False;
  clbFondi.AsyncUpdate;
end;

procedure TWP690FStampaFondi.Invertiselezione1Click(Sender: TObject);
var i:Integer;
begin
  for i:=0 to clbFondi.Items.Count - 1 do
    clbFondi.Selected[i]:=not clbFondi.Selected[i];
  clbFondi.AsyncUpdate;
end;

procedure TWP690FStampaFondi.btnGeneraPDFClick(Sender: TObject);
var i:Integer;
begin
  ListaFondiSel:='';
  for i:=0 to clbFondi.Items.Count - 1 do
    if clbFondi.Selected[i] then
    begin
      if ListaFondiSel <> '' then
        ListaFondiSel:=ListaFondiSel + ',';
      ListaFondiSel:=ListaFondiSel + Trim(Copy(clbFondi.Items[i],1,Pos(' - ',clbFondi.Items[i]) - 1));
    end;
  if ListaFondiSel = '' then
    raise exception.Create(A000MSG_P690_ERR_FONDI);
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWP690FStampaFondi.ElaborazioneServer;
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
    DCOMConnection.AppServer.PrintP690(DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
  end;
end;

function TWP690FStampaFondi.CreateJSonString: String;
var
  json: TJSONObject;
  i: Integer;
begin
  json:=TJSONObject.Create;
  try
    //Popolo il json con i valori necessari al B028 per creare il PDF per la stampa
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDecorrenzaDa,json);
    C190Comp2JsonString(edtDecorrenzaA,json);
    C190Comp2JsonString(chkRaggruppa,json);
    C190Comp2JsonString(chkDettRisorse,json);
    C190Comp2JsonString(chkDettDestinazioni,json);
    json.AddPair('ListaFondiSel',TJSONString.Create(ListaFondiSel));
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

end.
