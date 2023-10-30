unit WA041UInsRiposi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompLabel, meIWLabel, IWCompEdit, meIWEdit, C180FunzioniGenerali,
  meIWImageFile, medpIWImageButton,medpIWMessageDlg, medpIWC700NavigatorBar,
  A000UMessaggi, A000UInterfaccia, WA041UInsRiposiDM, A000UCostanti;

type
  TWA041FInsRiposi = class(TWR100FBase)
    edtDataDa: TmeIWEdit;
    edtDataA: TmeIWEdit;
    lblDataDa: TmeIWLabel;
    lblDataA: TmeIWLabel;
    imgAnomalie: TmedpIWImageButton;
    imgEsegui: TmedpIWImageButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure imgEseguiClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure imgAnomalieClick(Sender: TObject);
  private
    DataI,
    DataF: TDateTime;
    WA041FInsRiposiDM: TWA041FInsRiposiDM;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione;override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
    procedure DistruggiOggetti; override;
  public
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA041FInsRiposi.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  // Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
  //grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.ImpostaProgressivoCorrente:=True;
  grdC700.AttivaBrowse:=False;

  AttivaGestioneC700;
  WA041FInsRiposiDM:=TWA041FInsRiposiDM.Create(Self);
  WA041FInsRiposiDM.A041FInsRiposiMW.SelAnagrafe:=grdC700.selAnagrafe;
end;

function TWA041FInsRiposi.InizializzaAccesso: Boolean;
begin
  edtDataDa.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  edtDataA.Text:=FormatDateTime('mm/yyyy',Parametri.DataLavoro);
  imgAnomalie.Enabled:=False;
  Result:=True;
end;

procedure TWA041FInsRiposi.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(WA041FInsRiposiDM);
  inherited;
end;

procedure TWA041FInsRiposi.imgAnomalieClick(Sender: TObject);
var
  params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';

  accediForm(201,Params,True);
end;

procedure TWA041FInsRiposi.imgEseguiClick(Sender: TObject);
begin
  inherited;
  imgAnomalie.Enabled:=False;

  if grdC700.SelAnagrafe.RecordCount = 0 then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_NO_DIP,mtError,[mbOk],nil,'');
    Exit;
  end;

  if not TryStrToDate('01/' + edtDataDa.Text,DataI) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['inizio periodo']),mtError,[mbOk],nil,'');
    edtDataDa.SetFocus;
    Exit;
  end;

  if not TryStrToDate('01/' + edtDataA.Text,DataF) then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_ERR_FMT_DATA_NON_VALIDA,['fine periodo']),mtError,[mbOk],nil,'');
    edtDataA.SetFocus;
    Exit;
  end;

  DataI:=R180InizioMese(DataI);
  DataF:=R180FineMese(DataF);

  if DataF < DataI then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_PERIODO_ERRATO,mtError,[mbOk],nil,'');
    Exit;
  end;

  if FormatDateTime('yyyy',DataI) <> FormatDateTime('yyyy',DataF) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_DATE_STESSO_ANNO,mtError,[mbOk],nil,'');
    Exit;
  end;

  StartElaborazioneCiclo(imgEsegui.HTMLName);
end;

procedure TWA041FInsRiposi.WC700AperturaSelezione(Sender: TObject);
begin
  if TryStrToDate('01/' + edtDataDa.Text,DataI) then
  begin
    DataI:=R180InizioMese(DataI);
    grdC700.WC700FM.C700DataDal:=DataI;
  end;

  if TryStrToDate('01/' + edtDataA.Text,DataF) then
  begin
    DataF:=R180FineMese(DataF);
    grdC700.WC700FM.C700DataLavoro:=DataF;
  end;
end;

procedure TWA041FInsRiposi.ImpostazioniWC700;
begin
  grdC700.WC700FM.C700SelezionePeriodica:=False;
end;

//ELABORAZIONE
procedure TWA041FInsRiposi.InizioElaborazione;
begin
  inherited;

  //Selezione periodica a false. viene considerata solo DataF perchè variabile C700DATADAL non presente
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(DataI,DataF) then
    grdC700.SelAnagrafe.CloseAll;

  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;

  with WA041FInsRiposiDM.A041FInsRiposiMW do
  begin
    InizializzaSelDatiBloccati;
    DataInizio:=DataI;
    DataFine:=DataF;
    //Massimo: assegnazione già fatta nel FormCreate
    //SelAnagrafe:=grdC700.selAnagrafe;

    InizializzaComponentiElaborazione;
  end;
end;

function TWA041FInsRiposi.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecNO;
end;


procedure TWA041FInsRiposi.ElaboraElemento;
begin
  inherited;
  WA041FInsRiposiDM.A041FInsRiposiMW.ElaboraDipendente;
end;


function TWA041FInsRiposi.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.SelAnagrafe.RecordCount;
end;

function TWA041FInsRiposi.ElementoSuccessivo: Boolean;
begin
  Result:=False;
  grdC700.SelAnagrafe.Next;
  if not grdC700.SelAnagrafe.EOF then
    Result:=True;
end;

procedure TWA041FInsRiposi.FineCicloElaborazione;
begin
  inherited;
  imgAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

function TWA041FInsRiposi.ElaborazioneTerminata: String;
begin
  if imgAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA041FInsRiposi.DistruggiOggetti;
begin
  inherited;
  DistruzioneOggettiElaborazione(False);
end;

procedure TWA041FInsRiposi.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
   WA041FInsRiposiDM.A041FInsRiposiMW.DistruggiComponentiElaborazione;
end;

end.
