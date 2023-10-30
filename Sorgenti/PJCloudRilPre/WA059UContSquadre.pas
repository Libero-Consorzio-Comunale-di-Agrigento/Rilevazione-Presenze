unit WA059UContSquadre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid, DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, IWDBStdCtrls, meIWDBLabel, IWCompEdit,
  medpIWMultiColumnComboBox, IWCompLabel, meIWLabel, meIWRadioGroup, meIWEdit,
  meIWImageFile, medpIWImageButton, A059UContSquadraMW, A000UInterfaccia, C190FunzioniGeneraliWeb,
  IWCompJQueryWidget, Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, A000UMessaggi, A000UCostanti, ActiveX,
  IWApplication;

type
  TWA059FContSquadre = class(TWR100FBase)
    lblSquadraDa: TmeIWLabel;
    cmbCodSquadraDa: TMedpIWMultiColumnComboBox;
    lblSquadraA: TmeIWLabel;
    cmbCodSquadraA: TMedpIWMultiColumnComboBox;
    rgpModalita: TmeIWRadioGroup;
    lblModalita: TmeIWLabel;
    rgpTipo: TmeIWRadioGroup;
    lblTipo: TmeIWLabel;
    lblDataDa: TmeIWLabel;
    edtDataDa: TmeIWEdit;
    lblDataA: TmeIWLabel;
    edtDataA: TmeIWEdit;
    btnGeneraPDF: TmedpIWImageButton;
    lblDescSquadraDa: TmeIWLabel;
    lblDescSquadraA: TmeIWLabel;
    JQuery: TIWJQueryWidget;
    DCOMConnection: TDCOMConnection;
    btnCambioData: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
    procedure cmbCodSquadraDaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
    procedure rgpModalitaAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure btnCambioDataClick(Sender: TObject);
  private
    DataInizio,DataFine:TDateTime;
    A059MW: TA059FContSquadraMW;
    procedure CaricaComboBox;
    procedure AggiornaDescrizioni;
    procedure ElaborazioneServer; override;
    function CreateJSonString: String;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA059FContSquadre.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  A059MW:=TA059FContSquadraMW.Create(Self);
  DataInizio:=Parametri.DataLavoro;
  edtDataDa.Text:=DateToStr(DataInizio);
  DataFine:=Parametri.DataLavoro;
  edtDataA.Text:=DateToStr(DataFine);
  A059MW.RefreshDataSet(DataInizio,DataFine);
  CaricaComboBox;
  edtDataDa.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  edtDataA.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  C190VisualizzaElemento(JQuery,'rgpTipo',(Parametri.CampiRiferimento.C11_PianifOrariProg = 'S'));
  rgpModalitaAsyncClick(nil,nil);
end;

procedure TWA059FContSquadre.CaricaComboBox;
begin
  cmbCodSquadraDa.Items.Clear;
  cmbCodSquadraA.Items.Clear;
  with A059MW.selT603a do
  begin
    First;
    while not Eof do
    begin
      cmbCodSquadraDa.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      cmbCodSquadraA.AddRow(FieldByName('CODICE').AsString + ';' + FieldByName('DESCRIZIONE').AsString);
      Next;
    end;
    First;
  end;
  AggiornaDescrizioni;
end;

procedure TWA059FContSquadre.edtDataDaAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(Format('SubmitClick("%s", "", true);',[btnCambioData.HTMLName]));
end;

procedure TWA059FContSquadre.btnCambioDataClick(Sender: TObject);
begin
  inherited;
  try
    DataInizio:=StrToDate(edtDataDa.Text);
    DataFine:=StrToDate(edtDataA.Text);
  except
  end;
  A059MW.RefreshDataSet(DataInizio,DataFine);
  CaricaComboBox;
end;

procedure TWA059FContSquadre.cmbCodSquadraDaAsyncChange(Sender: TObject; EventParams: TStringList; Index: Integer; Value: string);
begin
  AggiornaDescrizioni;
end;

procedure TWA059FContSquadre.AggiornaDescrizioni;
begin
  lblDescSquadraDa.Caption:='';
  lblDescSquadraA.Caption:='';
  try
    lblDescSquadraDa.Caption:=A059MW.selT603a.Lookup('CODICE',cmbCodSquadraDa.Text,'DESCRIZIONE');
  except
    //Se il valore precedente non è più disponibile in base alle nuove date, allora prendo il primo della lista
    cmbCodSquadraDa.Text:=A059MW.selT603a.FieldByName('CODICE').AsString;
    lblDescSquadraDa.Caption:=VarToStr(A059MW.selT603a.Lookup('CODICE',cmbCodSquadraDa.Text,'DESCRIZIONE'));
  end;
  try
    lblDescSquadraA.Caption:=A059MW.selT603a.Lookup('CODICE',cmbCodSquadraA.Text,'DESCRIZIONE');
  except
    //Se il valore precedente non è più disponibile in base alle nuove date, allora prendo il primo della lista
    cmbCodSquadraA.Text:=A059MW.selT603a.FieldByName('CODICE').AsString;
    lblDescSquadraA.Caption:=VarToStr(A059MW.selT603a.Lookup('CODICE',cmbCodSquadraA.Text,'DESCRIZIONE'));
  end;
end;

procedure TWA059FContSquadre.rgpModalitaAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  //Applico le abilitazioni previste nel tab Permessi della form <A008> Profilo utenti
  if not SolaLettura then
  begin
    //PIANIFICAZIONE PROGRESSIVA
    if Parametri.CampiRiferimento.C11_PianifOrariProg = 'S' then
      rgpTipo.Enabled:=not (rgpModalita.ItemIndex = 0)
    else
      rgpTipo.Enabled:=False;
  end;
end;

procedure TWA059FContSquadre.btnGeneraPDFClick(Sender: TObject);
begin
  if (Trim(cmbCodSquadraDa.Text) = '') or (Trim(cmbCodSquadraA.Text) = '') then
    raise Exception.Create(A000MSG_A059_ERR_SQUADRA_MANCANTE);
  if cmbCodSquadraA.Text < cmbCodSquadraDa.Text then
    raise Exception.Create(A000MSG_A059_ERR_SQUADRE);
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA059FContSquadre.ElaborazioneServer;
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
    DCOMConnection.AppServer.PrintA059(DCOMNomeFile,
                                       Parametri.Operatore,
                                       Parametri.Azienda,
                                       WR000DM.selAnagrafe.Session.LogonDataBase,
                                       DatiUtente,
                                       DettaglioLog);
  finally
    DCOMConnection.Connected:=False;
  end;
end;

function TWA059FContSquadre.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtDataDa,json);
    C190Comp2JsonString(edtDataA,json);
    C190Comp2JsonString(cmbCodSquadraDa,json);
    C190Comp2JsonString(cmbCodSquadraA,json);
    C190Comp2JsonString(rgpModalita,json);
    C190Comp2JsonString(rgpTipo,json);
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;

end.
