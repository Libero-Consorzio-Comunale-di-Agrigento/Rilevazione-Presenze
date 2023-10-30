unit WA068UTurniGior;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR100UBase, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompButton, meIWButton, IWCompGrids, meIWGrid,DBXJSON,{$IF CompilerVersion >= 31}System.JSON,{$ENDIF}
  medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton,
  Data.DB, Datasnap.DBClient, Datasnap.Win.MConnect, meIWRadioGroup, IWCompEdit,
  meIWEdit, IWCompLabel, meIWLabel, medpIWC700NavigatorBar, WC700USelezioneAnagrafeFM,
  A000UInterfaccia, A000UMessaggi, C190FunzioniGeneraliWeb, A000UCostanti, ActiveX;

type
  TWA068FTurniGior = class(TWR100FBase)
    DCOMConnection: TDCOMConnection;
    btnGeneraPDF: TmedpIWImageButton;
    lblData: TmeIWLabel;
    edtData: TmeIWEdit;
    lblIntestazione: TmeIWLabel;
    edtIntestazione: TmeIWEdit;
    rgpTPianif: TmeIWRadioGroup;
    lblTPianif: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnGeneraPDFClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    function CreateJSonString: String;
    procedure ElaborazioneServer; override;
  protected
    procedure ImpostazioniWC700;override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA068FTurniGior.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  //creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);
  grdC700.AttivaBrowse:=False;
  AttivaGestioneC700;
  edtData.Text:=FormatDateTime('dd/mm/yyyy',Parametri.DataLavoro);
  rgpTPianif.ItemIndex:=StrToInt(C004DM.GetParametro(rgpTPianif.Name,'1'));
end;

procedure TWA068FTurniGior.IWAppFormDestroy(Sender: TObject);
begin
  C004DM.Cancella001;
  C004DM.PutParametro(rgpTPianif.Name,IntToStr(rgpTPianif.ItemIndex));
  try SessioneOracle.Commit; except end;
  inherited;
end;

procedure TWA068FTurniGior.ImpostazioniWC700;
begin
  inherited;
  grdC700.WC700FM.C700DatiSelezionati:=C700CampiBase + ',T430SQUADRA,T430D_SQUADRA';
end;

procedure TWA068FTurniGior.btnGeneraPDFClick(Sender: TObject);
begin
  if grdC700.selAnagrafe.RecordCount = 0 then
    raise Exception.create(A000MSG_ERR_NO_DIP);
  if Trim(edtData.Text) = '' then
    raise Exception.create(A000MSG_ERR_DATA_ERRATA);
  StartElaborazioneServer(btnGeneraPDF.HTMLName);
end;

procedure TWA068FTurniGior.ElaborazioneServer;
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
    DCOMConnection.AppServer.PrintA068(grdC700.selAnagrafe.SubstitutedSQL,
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

function TWA068FTurniGior.CreateJSonString: String;
var json: TJSONObject;
    i: Integer;
begin
  json:=TJSONObject.Create;
  try
    json.AddPair('StandardPrinter',IfThen(Pos(INI_PAR_USE_STANDARD_PRINTER,W000ParConfig.ParametriAvanzati) > 0,'S','N'));
    C190Comp2JsonString(edtData,json);
    C190Comp2JsonString(edtIntestazione,json);
    C190Comp2JsonString(rgpTPianif,json);
    Result:=json.ToString;
  finally
    FreeAndNil(json);
  end;
end;


end.
