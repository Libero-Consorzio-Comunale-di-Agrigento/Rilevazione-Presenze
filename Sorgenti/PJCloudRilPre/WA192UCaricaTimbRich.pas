unit WA192UCaricaTimbRich;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, OracleData,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, A023UTimbratureMW, A000UInterfaccia, IWDBGrids, medpIWDBGrid, medpIWMessageDlg,
  C190FunzioniGeneraliWeb, meIWImageFile, medpIWImageButton, A000UCostanti, A000UMessaggi,
  IWCompEdit, meIWEdit, meIWRadioGroup, IWCompLabel, meIWLabel,
  System.StrUtils, C180FunzioniGenerali;

type
  TWA192FCaricaTimbRich = class(TWR100FBase)
    grdRichieste: TmedpIWDBGrid;
    ImgImporta: TmedpIWImageButton;
    imgVisualizzaLog: TmedpIWImageButton;
    lblModalita: TmeIWLabel;
    rgpModalita: TmeIWRadioGroup;
    lblPeriodo: TmeIWLabel;
    lblPeriodoDal: TmeIWLabel;
    edtPeriodoDal: TmeIWEdit;
    lblPeriodoAl: TmeIWLabel;
    edtPeriodoAl: TmeIWEdit;
    imgRefreshDati: TmeIWImageFile;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow,
      AColumn: Integer);
    procedure imgVisualizzaLogClick(Sender: TObject);
    procedure ImgImportaTutteClick(Sender: TObject);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure rgpModalitaClick(Sender: TObject);
    procedure imgRefreshDatiClick(Sender: TObject);
  private
    Singola, ElabOK: Boolean;
    A023FTimbratureMW: TA023FTimbratureMW;
    procedure imgElaboraClick(Sender: TObject);
    procedure Importazione(SenderName: String; Sing: Boolean);
    procedure ResImportaTutto(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure AggiornaFiltroPeriodo;
  protected
    procedure InizioElaborazione; override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
    procedure FineCicloElaborazione; override;
    function ElaborazioneTerminata:String; override;
    procedure DistruzioneOggettiElaborazione(Errore:Boolean); override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
  public
    function InizializzaAccesso:Boolean; override;
  end;

const
  // item del filtro messaggi
  ITEM_NUOVE     = 0;
  ITEM_ELABORATE = 1;

implementation

{$R *.dfm}

procedure TWA192FCaricaTimbRich.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR100LinkWC700:=False;
  AttivaGestioneC700;

  A023FTimbratureMW:=TA023FTimbratureMW.Create(Self);
end;

function TWA192FCaricaTimbRich.InizializzaAccesso: Boolean;
begin
  // forzo eredita Selezione
  grdC700.actC700EreditaSelezioneExecute(nil);

  // imposta dataset
  A023FTimbratureMW.selT105.Close;
  grdC700.WC700FM.C700MergeSelAnagrafe(A023FTimbratureMW.selT105,False);
  grdC700.WC700FM.C700MergeSettaPeriodo(A023FTimbratureMW.selT105,Parametri.DataLavoro,Parametri.DataLavoro);
  A023FTimbratureMW.selT105.SetVariable('AZIENDA',Parametri.Azienda);
  A023FTimbratureMW.selT105.SetVariable('HINTT030V430',Parametri.CampiRiferimento.C26_HintT030V430);
  A023FTimbratureMW.selT105.SetVariable('FILTRO_RICHIESTE',null);
  A023FTimbratureMW.selT105.SetVariable('FILTRO_MODALITA','AND T105.ELABORATO = ''N''');
  // selT105.Open;

  grdRichieste.medpComandiCustom:=True;
  grdRichieste.medpRowSelect:=False;
  grdRichieste.medpPaginazione:=True;
  grdRichieste.medpRighePagina:=StrToIntDef(Parametri.CampiRiferimento.C90_WebRighePag,-1);
  grdRichieste.medpAttivaGrid(A023FTimbratureMW.selT105,False,False,False);

  grdRichieste.medpPreparaComponenteGenerico('WR102-R',grdRichieste.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ELENCO','Elabora richiesta','','');
  grdRichieste.medpCaricaCDS;
  rgpModalitaClick(nil); //+++

  Result:=True;
end;

procedure TWA192FCaricaTimbRich.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  img: TmeIWImageFile;
  r: Integer;
begin
  inherited;

  for r:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    img:=(grdRichieste.medpCompCella(r,'DBG_COMANDI',0) as TmeIWImageFile);
    img.OnClick:=imgElaboraClick;
  end;
end;

procedure TWA192FCaricaTimbRich.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var NumColonna: Integer;
begin
  inherited;
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;
  NumColonna:=grdRichieste.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA192FCaricaTimbRich.imgElaboraClick(Sender: TObject);
var
  Id : String;
  r  : Integer;
begin
  r:=grdRichieste.medpRigaDiCompGriglia((Sender as TmeIWImageFile).FriendlyName);
  Id:=grdRichieste.medpValoreColonna(r, 'ID');

  if A023FTimbratureMW.selT105.SearchRecord('ID',Id,[srFromBeginning]) then
  begin
    Importazione((Sender as TmeIWImageFile).HTMLName,True);
  end;
end;

procedure TWA192FCaricaTimbRich.ImgImportaTutteClick(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(A000MSG_A023_DLG_IMPORTA_RICH,mtConfirmation,[mbYes,mbNo],ResImportaTutto,'');
end;

procedure TWA192FCaricaTimbRich.ResImportaTutto(Sender: TObject; R: TmeIWModalResult; KI: String);
var Azienda,Profilo:String;
begin
  if R = mrYes then
    Importazione(ImgImporta.HTMLName,False);
end;

procedure TWA192FCaricaTimbRich.rgpModalitaClick(Sender: TObject);
var
  LElab: String;
begin
  if rgpModalita.ItemIndex = ITEM_NUOVE then
  begin
    // richieste nuove: cancella periodo intersezione
    edtPeriodoDal.Clear;
    edtPeriodoAl.Clear;
  end
  else
  begin
    // richieste già elaborate: imposta default per periodo di intersezione
    if edtPeriodoDal.Text = '' then
      edtPeriodoDal.Text:=FormatDateTime('dd/mm/yyyy',Date);
    if edtPeriodoAl.Text = '' then
      edtPeriodoAl.Text:=FormatDateTime('dd/mm/yyyy',Date);
  end;

  // imposta filtro modalità
  LElab:=IfThen(rgpModalita.ItemIndex = ITEM_NUOVE,'N','E');
  R180SetVariable(A023FTimbratureMW.selT105,'FILTRO_MODALITA',Format('AND T105.ELABORATO = ''%s''',[LElab]));

  // imposta filtro periodo
  AggiornaFiltroPeriodo;

  // apre il dataset e aggiorna la grid
  A023FTimbratureMW.selT105.Open;
  grdRichieste.medpCaricaCDS;

  // titolo grid
  grdRichieste.Caption:=IfThen(rgpModalita.ItemIndex = ITEM_NUOVE,'Richieste da elaborare','Richieste da rielaborare');
end;

procedure TWA192FCaricaTimbRich.AggiornaFiltroPeriodo;
var
  LPeriodoDal: TDateTime;
  LPeriodoAl: TDateTime;
  LPeriodo: String;
  function IsDataNulla(const PData: String): Boolean;
  begin
    Result:=(Trim(PData) = '') or (PData = '  /  /    ');
  end;
begin
  // periodo richieste
  if IsDataNulla(edtPeriodoDal.Text) and IsDataNulla(edtPeriodoAl.Text) then
  begin
    // periodo vuoto
    LPeriodo:='';
  end
  else
  begin
    // una delle date è indicata
    if not TryStrToDate(edtPeriodoDal.Text,LPeriodoDal) then
      raise Exception.Create('Data di inizio periodo non valida!');
    if not TryStrToDate(edtPeriodoAl.Text,LPeriodoAl) then
      raise Exception.Create('Data di fine periodo non valida!');
    if LPeriodoDal > LPeriodoAl then
      raise Exception.Create('Il periodo indicato non è valido!');
    if LPeriodoDal = LPeriodoAl then
      LPeriodo:=Format('AND T105.DATA = TO_DATE(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',LPeriodoDal)])
    else
      LPeriodo:=Format('AND T105.DATA BETWEEN TO_DATE(''%s'',''dd/mm/yyyy'') AND TO_DATE(''%s'',''dd/mm/yyyy'')',[FormatDateTime('dd/mm/yyyy',LPeriodoDal),FormatDateTime('dd/mm/yyyy',LPeriodoAl)]);
  end;

  R180SetVariable(A023FTimbratureMW.selT105,'FILTRO_PERIODO',LPeriodo);
end;

procedure TWA192FCaricaTimbRich.Importazione(SenderName: String; Sing:Boolean);
begin
  inherited;
  try
    Singola:=Sing;
    A023FTimbratureMW.InizializzaAcquisizioneWeb(Singola);
  except
    on e: exception do
    begin
      MsgBox.WebMessageDlg(e.Message,mtError,[mbOk],nil,'');
      Abort;
    end;
  end;
  StartElaborazioneCiclo(SenderName);
end;

procedure TWA192FCaricaTimbRich.imgRefreshDatiClick(Sender: TObject);
begin
  // chiude il dataset in modo da forzare l'aggiornamento dei dati
  A023FTimbratureMW.selT105.Close;

  // imposta filtro periodo
  AggiornaFiltroPeriodo;

  // apre il dataset e aggiorna la grid
  A023FTimbratureMW.selT105.Open;
  grdRichieste.medpCaricaCDS;
end;

procedure TWA192FCaricaTimbRich.imgVisualizzaLogClick(Sender: TObject);
var
  Params: String;
begin
  Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
          'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
          'MASCHERA=' + medpCodiceForm + ParamDelimiter +
          'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
          'TIPO=A,B,I';

  AccediForm(201,Params,True);
end;

procedure TWA192FCaricaTimbRich.IWAppFormDestroy(Sender: TObject);
begin
  A023FTimbratureMW.FinalizzaAcquisizioneWeb;
  FreeAndNil(A023FTimbratureMW);
  inherited;
end;

//ELABORAZIONE
procedure TWA192FCaricaTimbRich.InizioElaborazione;
begin
  inherited;
  ElabOK:=True;
end;

function TWA192FCaricaTimbRich.TotalRecordsElaborazione: Integer;
begin
  if Singola then
    Result:=1
  else
    Result:=A023FTimbratureMW.selT105.RecordCount;
end;

function TWA192FCaricaTimbRich.CurrentRecordElaborazione: Integer;
begin
  if Singola then
    Result:=1
  else
    Result:=A023FTimbratureMW.selT105.RecNo;
end;

procedure TWA192FCaricaTimbRich.ElaboraElemento;
begin
  inherited;
  A023FTimbratureMW.ImportaRichiesta;

  if A023FTimbratureMW.Elaborato = 'E' then
    ElabOK:=False;
end;

function TWA192FCaricaTimbRich.ElementoSuccessivo: Boolean;
begin
  if Singola then
    Result:=False
  else
  begin
    Result:=False;
    A023FTimbratureMW.selT105.Next;
    if not A023FTimbratureMW.selT105.Eof then //richiama calcolo su nuovo dipendente
      Result:=True;
  end;
end;

function TWA192FCaricaTimbRich.ElaborazioneTerminata: String;
begin
  if ElabOK then
    Result:=A000MSG_MSG_ELAB_OK
  else
    Result:=A000MSG_MSG_ELAB_ERRORE;
end;

procedure TWA192FCaricaTimbRich.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  A023FTimbratureMW.selT105.Refresh;
  A023FTimbratureMW.FinalizzaAcquisizioneWeb;
  grdRichieste.medpAggiornaCDS(True);
end;

procedure TWA192FCaricaTimbRich.FineCicloElaborazione;
begin
  inherited;
end;

end.
