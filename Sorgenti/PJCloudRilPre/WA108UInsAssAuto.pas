unit WA108UInsAssAuto;

interface

uses WR100UBase, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel, IWCompExtCtrls,
  meIWImageFile, medpIWImageButton, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  System.Classes, Vcl.Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, Rp502Pro, R600,
  System.SysUtils, OracleData, medpIWC700NavigatorBar, C180FunzioniGenerali,
  A000UCostanti, A000UInterfaccia, A000UMessaggi, A108UInsAssAutoMW;

type
  TWA108FInsAssAuto = class(TWR100FBase)
    btnEsegui: TmedpIWImageButton;
    btnAnomalie: TmedpIWImageButton;
    lblMese: TmeIWLabel;
    edtMese: TmeIWEdit;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnEseguiClick(Sender: TObject);
    procedure btnAnomalieClick(Sender: TObject);
    procedure edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
  private
    A108MW:TA108FInsAssAutoMW;
    OldProg:Integer;
    DataCorr:TDateTime;
  public
    function InizializzaAccesso: Boolean; override;
    procedure DistruggiOggetti; override;
  protected
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function TotalRecordsElaborazione: Integer; override;
    function CurrentRecordElaborazione: Integer; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata: String; override;
  end;

implementation

{$R *.dfm}

procedure TWA108FInsAssAuto.IWAppFormCreate(Sender: TObject);
begin
  A108MW:=TA108FInsAssAutoMW.Create(Self);
  inherited;
  A108MW.Mese:=Parametri.DataLavoro;
  edtMese.Text:=FormatDateTime('mm/yyyy',A108MW.Mese);
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Danilo: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  grdC700.AttivaBrowse:=False;
  A108MW.selAnagrafe:=grdC700.selAnagrafe;
  AttivaGestioneC700;
  BtnAnomalie.Enabled:=False;
end;

function TWA108FInsAssAuto.InizializzaAccesso: Boolean;
begin
  Result:=AccessoAbilitato and (not SolaLettura);
end;

procedure TWA108FInsAssAuto.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA108FInsAssAuto.edtMeseAsyncChange(Sender: TObject; EventParams: TStringList);
begin
  try
    grdC700.WC700FM.C700DataLavoro:=R180FineMese(StrToDate('01/' + edtMese.Text));
  except
    grdC700.WC700FM.C700DataLavoro:=Parametri.DataLavoro;
  end;
end;

procedure TWA108FInsAssAuto.btnEseguiClick(Sender: TObject);
begin
  try
    A108MW.Mese:=StrToDate('01/' + edtMese.Text);
  except
    raise Exception.Create(A000MSG_A108_ERR_MESE);
  end;
  StartElaborazioneCiclo((Sender as TmedpIWImageButton).HTMLName);
end;

procedure TWA108FInsAssAuto.InizioElaborazione;
begin
  inherited;
  OldProg:=grdC700.SelAnagrafe.FieldByName('Progressivo').AsInteger;
  btnAnomalie.Enabled:=False;
  A108MW.R502ProDtM:=TR502ProDtM1.Create(nil);
  A108MW.R502ProDtM.PeriodoConteggi(R180InizioMese(A108MW.Mese),R180FineMese(A108MW.Mese));
  A108MW.R600DtM:=TR600DtM1.Create(nil);
  R180SetVariable(grdC700.SelAnagrafe,'DataLavoro',R180FineMese(A108MW.Mese));
  grdC700.SelAnagrafe.Open;
  grdC700.SelAnagrafe.First;
  DataCorr:=R180InizioMese(A108MW.Mese);
  A108MW.ResetCompensazione(DataCorr);
end;

function TWA108FInsAssAuto.TotalRecordsElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecordCount;
end;

function TWA108FInsAssAuto.CurrentRecordElaborazione: Integer;
begin
  Result:=grdC700.selAnagrafe.RecNO;
end;

procedure TWA108FInsAssAuto.DistruggiOggetti;
begin
  inherited;
  //Se viene chiuso il browser in fase di elaborazione, ElaborazioneTerminata non viene chiamata e gli oggetti non vengono disallocati
  FreeAndNil(A108MW.R502ProDtM);
  FreeAndNil(A108MW.R600DtM);
end;

procedure TWA108FInsAssAuto.ElaboraElemento;
begin
  A108MW.CompensazioneGiornalieraAutomatica(DataCorr);
  DataCorr:=DataCorr + 1;
end;

function TWA108FInsAssAuto.ElementoSuccessivo: Boolean;
begin
  Result:=DataCorr <= R180FineMese(A108MW.Mese);
  if not Result then
  begin
    grdC700.selAnagrafe.Next;
    if not grdC700.selAnagrafe.EOF then
    begin
      Result:=True;
      DataCorr:=R180InizioMese(A108MW.Mese);
      A108MW.ResetCompensazione(DataCorr);
    end;
  end;
end;

procedure TWA108FInsAssAuto.FineCicloElaborazione;
begin
  btnAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
end;

function TWA108FInsAssAuto.ElaborazioneTerminata: String;
begin
  FreeAndNil(A108MW.R502ProDtM);
  FreeAndNil(A108MW.R600DtM);
  grdC700.SelAnagrafe.SearchRecord('PROGRESSIVO',OldProg,[srFromBeginning]);
  if btnAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

procedure TWA108FInsAssAuto.btnAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' + Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B';
  accediForm(201,Params,False);
end;

end.
