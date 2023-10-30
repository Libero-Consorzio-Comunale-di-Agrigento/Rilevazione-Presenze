unit WA095UStRiasStr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, medpIWTabControl, IWDBGrids, medpIWDBGrid, IWCompLabel, meIWLabel,
  IWCompEdit, meIWEdit, medpIWC700NavigatorBar, meIWRadioGroup, IWCompCheckbox,
  meIWCheckBox, meIWImageFile, medpIWImageButton, IWAdvCheckGroup,
  meTIWAdvCheckGroup, WA095UStRiasStrDM,
  A000UInterfaccia, A000UMessaggi, A000UCostanti, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  medpIWMessageDlg, OracleData;

type
  TTipoValore = (tvZero, tvLiquidato);

  TWA095FStRiasStr = class(TWR100FBase)
    grdTabDetail: TmedpIWTabControl;
    WA095ParametriRG: TIWRegion;
    TemplateParametriRG: TIWTemplateProcessorHTML;
    edtAnno: TmeIWEdit;
    edtMese: TmeIWEdit;
    lblAnno: TmeIWLabel;
    lblMese: TmeIWLabel;
    WA095RisultatiRG: TIWRegion;
    grdRisultati: TmedpIWDBGrid;
    TemplateRisultatiRG: TIWTemplateProcessorHTML;
    lblRiepilogo: TmeIWLabel;
    rgpDisponibilita: TmeIWRadioGroup;
    lblDisponibilita: TmeIWLabel;
    chkLiquidazione: TmeIWCheckBox;
    imgAnnullaLiquidazione: TmedpIWImageButton;
    imgAnteprima: TmedpIWImageButton;
    imgSoloLiquidazione: TmedpIWImageButton;
    imgAnomalie: TmedpIWImageButton;
    cgpDettaglio: TmeTIWAdvCheckGroup;
    lblDettaglio: TmeIWLabel;
    btnModificaDati: TmeIWButton;
    btnConfermaDati: TmeIWButton;
    btnAnnullaDati: TmeIWButton;
    btnLiquida: TmeIWButton;
    btnImpostaLiquidato: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdTabDetailTabControlChange(Sender: TObject);
    procedure chkLiquidazioneAsyncClick(Sender: TObject;
      EventParams: TStringList);
    procedure imgAnomalieClick(Sender: TObject);
    procedure imgSoloLiquidazioneClick(Sender: TObject);
    procedure grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure imgAnnullaLiquidazioneClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
    procedure btnModificaDatiClick(Sender: TObject);
    procedure btnConfermaDatiClick(Sender: TObject);
    procedure btnAnnullaDatiClick(Sender: TObject);
    procedure btnLiquidaClick(Sender: TObject);
    procedure btnImpostaLiquidatoClick(Sender: TObject);
    procedure grdRisultatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    RicaricaGridRisultati,
    LiquidazioneInModifica: Boolean;
    DataElab: TDateTime;
    SenderHTMLName: String;
    LstPagineBloccate: TStringList;
    procedure GetParametriFunzione;
    procedure PutParametriFunzione;
    function VerificaAnnoMese: Boolean;
    procedure ResultAnnullaLiquidazione(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
    procedure SetLiquidazioneInModifica(const PInModifica: Boolean);
    procedure VisualizzaModificaLiquidazione(PVisualizza: Boolean);
    procedure ImpostaValoriLiquidato(PTipoValore: TTipoValore);
    procedure AnnullaDati;
    procedure ConfermaDati;
    function ConfermaLiquidazione(var RErrMsg: String): Boolean;
  protected
    procedure WC700AperturaSelezione(Sender: TObject); override;
    procedure ImpostazioniWC700; override;
    procedure InizioElaborazione; override;
    function CurrentRecordElaborazione: Integer; override;
    function TotalRecordsElaborazione: Integer; override;
    function ElaborazioneTerminata: String; override;
    procedure FineCicloElaborazione; override;
    procedure DistruzioneOggettiElaborazione(Errore: Boolean); override;
    procedure ElaboraElemento; override;
    function ElementoSuccessivo: Boolean; override;
  public
    WA095FStRiasStrDM: TWA095FStRiasStrDM;
    function InizializzaAccesso: Boolean; override;
  end;

implementation

{$R *.dfm}

procedure TWA095FStRiasStr.IWAppFormCreate(Sender: TObject);
begin
  grdTabDetail.AggiungiTab('Parametri',WA095ParametriRG);
  grdTabDetail.AggiungiTab('Risultati',WA095RisultatiRG);
  grdTabDetail.HasFiller:=True;
  grdTabDetail.ActiveTab:=WA095ParametriRG;
  inherited;
  grdC700:=TmedpIWC700NavigatorBar.Create(Self);//Alberto: creato prima di AttivaGestioneC700 per impostare le altre proprietà non standard
  // Massimo 23/07/2103 con questo codice non eredita la selezione anagrafe
  //grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.ImpostaProgressivoCorrente:=True;
  grdC700.AttivaBrowse:=False;

  AttivaGestioneC700;

  WA095FStRiasStrDM:=TWA095FStRiasStrDM.Create(Self);
  WA095FStRiasStrDM.A095FStRiasStrMW.SelAnagrafe:=grdC700.selAnagrafe;

  LstPagineBloccate:=TStringList.Create;
end;

procedure TWA095FStRiasStr.IWAppFormDestroy(Sender: TObject);
begin
  FreeAndNil(LstPagineBloccate);
  inherited;
end;

function TWA095FStRiasStr.InizializzaAccesso: Boolean;
var
  i: Integer;
begin
  edtAnno.Text:=FormatDateTime('yyyy',Parametri.DataLavoro);
  edtMese.Text:=FormatDateTime('mm',Parametri.DataLavoro);
  chkLiquidazione.Enabled:=not SolaLettura;
  imgSoloLiquidazione.Enabled:=chkLiquidazione.Checked;
  imgAnomalie.Enabled:=False;

  // gestione liquidazione manuale
  VisualizzaModificaLiquidazione(False);

  with WA095FStRiasStrDM.A095FStRiasStrMW do
    for i:=0 to LstCampiDettaglioAnagrafe.Count - 1 do
    begin
      cgpDettaglio.Items.Add(LstCampiDettaglioAnagrafe[i]);
    end;

  GetParametriFunzione;

  RicaricaGridRisultati:=False;
  grdRisultati.medpPaginazione:=True;
  grdRisultati.medpRighePagina:=18;
  grdTabDetail.Tabs[WA095RisultatiRG].Enabled:=False;
  Result:=True;
end;

procedure TWA095FStRiasStr.grdRisultatiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  LEsistonoRecord, LPaginaModificabile: Boolean;
begin
  inherited;

  LEsistonoRecord:=grdRisultati.medpDataSet.RecordCount > 0;
  VisualizzaModificaLiquidazione(LEsistonoRecord);

  // verifica se la pagina attuale è modificabile per la liquidazione
  LPaginaModificabile:=(LEsistonoRecord) and
                       (LstPagineBloccate.IndexOf(grdRisultati.medpGetCurrPag.ToString) = -1);

  btnModificaDati.Enabled:=(not LiquidazioneInModifica) and LPaginaModificabile;
  btnLiquida.Enabled:=(not LiquidazioneInModifica) and LPaginaModificabile;
end;

procedure TWA095FStRiasStr.grdRisultatiRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  NumColonna:=grdRisultati.medpNumColonna(AColumn);
  Campo:=grdRisultati.medpColonna(NumColonna).DataField.ToUpper;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdRisultati.medpCompGriglia) + 1) and (grdRisultati.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRisultati.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;

  if ARow > 0 then
  begin
    // dettaglio

    // valuta i singoli campi
    if Campo = 'STRPAG' then
    begin
      ACell.Css:=ACell.Css + ' font_rosso';
    end;
  end;
end;

procedure TWA095FStRiasStr.grdTabDetailTabControlChange(Sender: TObject);
var
  LGestModificaStr: Boolean;
begin
  if (grdTabDetail.ActiveTab = WA095RisultatiRG) and (RicaricaGridRisultati) then
  begin
    //grdRisultati.medpAttivaGrid(WA095FStRiasStrDM.A095FStRiasStrMW.TabellaStampa,False,False);
    grdRisultati.medpEditMultiplo:=True;
    grdRisultati.medpRowSelect:=False;
    grdRisultati.medpAttivaGrid(WA095FStRiasStrDM.A095FStRiasStrMW.TabellaStampa,False,False,False);

    LGestModificaStr:=(not chkLiquidazione.Checked) and (grdRisultati.medpDataSet.RecordCount > 0);
    VisualizzaModificaLiquidazione(LGestModificaStr);
    if LGestModificaStr then
    begin
      // prepara la gestione della liquidazione manuale
      SetLiquidazioneInModifica(False);
    end;
    RicaricaGridRisultati:=False;
  end;
end;

procedure TWA095FStRiasStr.ImpostaValoriLiquidato(PTipoValore: TTipoValore);
var
  r: Integer;
  LValore: String;
  IWEdt: TmeIWEdit;
begin
  if grdRisultati.medpStato = msEdit then
  begin
    for r:=0 to High(grdRisultati.medpCompGriglia) do
    begin
      case PTipoValore of
        tvLiquidato: LValore:=grdRisultati.medpValoreColonna(r,'StrPag_Disp');
        tvZero:      LValore:='00.00';
      else
        LValore:='';
      end;

      IWEdt:=(grdRisultati.medpCompCella(r,'STRPAG',0) as TmeIWEdit);
      IWEdt.Text:=LValore;
    end;
  end;
end;

procedure TWA095FStRiasStr.VisualizzaModificaLiquidazione(PVisualizza: Boolean);
begin
  // in readonly la modifica liquidazione è nascosta
  if SolaLettura then
    PVisualizza:=False;

  btnModificaDati.Visible:=PVisualizza;
  btnConfermaDati.Visible:=PVisualizza;
  btnAnnullaDati.Visible:=PVisualizza;
  btnImpostaLiquidato.Visible:=PVisualizza;
  btnLiquida.Visible:=PVisualizza;
end;

procedure TWA095FStRiasStr.SetLiquidazioneInModifica(const PInModifica: Boolean);
begin
  LiquidazioneInModifica:=PInModifica;

  btnModificaDati.Enabled:=not PInModifica;
  btnConfermaDati.Enabled:=PInModifica;
  btnAnnullaDati.Enabled:=PInModifica;
  btnImpostaLiquidato.Enabled:=PInModifica;
  btnLiquida.Enabled:=(not PInModifica) and (LstPagineBloccate.IndexOf(grdRisultati.medpGetCurrPag.ToString) = -1);

  // in modifica disabilita la possibilità di navigare fra le pagine
  if PInModifica then
    grdRisultati.medpDisabilitaNavBar
  else
    grdRisultati.medpAbilitaNavBar;
end;

procedure TWA095FStRiasStr.imgAnnullaLiquidazioneClick(Sender: TObject);
var
  DataTmp: TDateTime;
begin
  if not VerificaAnnoMese then
    Exit;

  //Caratto 11/07/2013  - deve valutare i dipendenti nel periodo indicato
  DataTmp:=EncodeDate(StrToInt(edtAnno.Text),StrToInt(edtMese.Text),1);

  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(DataTmp),R180FineMese(DataTmp)) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;
  AggiornaAnagr;
  ////Caratto 11/07/2013 - fine
  try
    DataElab:=WA095FStRiasStrDM.A095FStRiasStrMW.ControlloLiquid(grdC700.SelAnagrafe, StrToInt(edtAnno.Text),StrToInt(edtMese.Text));
  except
    on E : Exception do
    begin
      MsgBox.WebMessageDlg(e.Message,mtError,[mbOk],nil,'');
      Exit;
    end;
  end;
  MsgBox.WebMessageDlg(Format(A000MSG_A095_DLG_FMT_ANNULLA_LIQ,[UpperCase(FormatDateTime('mmmm yyyy',DataElab))]),mtConfirmation,[mbYes, mbNo],ResultAnnullaLiquidazione,'');
end;

procedure TWA095FStRiasStr.ResultAnnullaLiquidazione(Sender: TObject;
  Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    SenderHTMLName:=imgAnnullaLiquidazione.HTMLName;
    StartElaborazioneCiclo(SenderHTMLName);
  end;
end;

procedure TWA095FStRiasStr.imgAnomalieClick(Sender: TObject);
var Params: String;
begin
  inherited;
  if  (RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB) then
  begin
    Params:='AZIENDA=' + Parametri.Azienda + ParamDelimiter +
            'OPERATORE=' +Parametri.Operatore + ParamDelimiter +
            'MASCHERA=' + medpCodiceForm + ParamDelimiter +
            'ID=' + IntToStr(RegistraMsg.ID) + ParamDelimiter +
            'TIPO=A,B';

    accediForm(201,Params,True);
  end;
end;

procedure TWA095FStRiasStr.imgSoloLiquidazioneClick(Sender: TObject);
begin
  if not VerificaAnnoMese then
    Exit;

  imgAnomalie.Enabled:=False;
  SenderHTMLName:=(Sender as TmedpIWImageButton).HTMLName;

  DataElab:=R180FineMese(EncodeDate(StrToInt(edtAnno.Text),StrToInt(edtMese.Text),1));
  if grdC700.WC700FM.C700SettaPeriodoSelAnagrafe(R180InizioMese(DataElab),R180FineMese(DataElab)) then
    grdC700.selAnagrafe.Close;
  grdC700.selAnagrafe.Open;
  grdC700.selAnagrafe.First;
  AggiornaAnagr;

  StartElaborazioneCiclo(SenderHTMLName);
end;

function TWA095FStRiasStr.VerificaAnnoMese: Boolean;
begin
  Result:=False;
  if (StrToInt(edtAnno.Text) < 1900) or
     (StrToInt(edtAnno.Text) > 3999) then
  begin
    MsgBox.WebMessageDlg(A000MSG_A091_ERR_ANNO,mtError,[mbOk],nil,'');
    edtAnno.SetFocus;
    Exit;
  end;

  if (StrToInt(edtMese.Text) < 1) or
     (StrToInt(edtMese.Text) > 12) then
  begin
    MsgBox.WebMessageDlg(A000MSG_A091_ERR_MESE,mtError,[mbOk],nil,'');
    edtMese.SetFocus;
    Exit;
  end;
  Result:=True;
end;

procedure TWA095FStRiasStr.GetParametriFunzione;
begin
  rgpDisponibilita.ItemIndex:=StrToInt(C004DM.GetParametro('DISPONIBILITA','0'));
  //Non usare , come separatore altrimenti il metodo CommaText prende come delimitatore anche lo spazio
  C190PutCheckList(C004DM.GetParametro('DETTAGLIO',''),99,cgpDettaglio,';');
end;

procedure TWA095FStRiasStr.PutParametriFunzione;
begin
  C004DM.Cancella001;
  C004DM.PutParametro('DISPONIBILITA',IntToStr(rgpDisponibilita.ItemIndex));
  //Non usare , come separatore altrimenti il metodo CommaText prende come delimitatore anche lo spazio
  C004DM.PutParametro('DETTAGLIO',C190GetCheckList(99,cgpDettaglio,';'));
end;

procedure TWA095FStRiasStr.WC700AperturaSelezione(Sender: TObject);
var Data: TDateTime;
begin
  if tryStrToDate('01/' + edtMese.Text + '/' + edtAnno.Text,Data ) then
  begin
    grdC700.WC700FM.C700DataDal:=R180InizioMese(Data);
    grdC700.WC700FM.C700DataLavoro:=R180FineMese(Data);
  end;
end;

procedure TWA095FStRiasStr.ImpostazioniWC700;
begin
  inherited;
  with grdC700.WC700FM do
  begin
    C700DatiVisualizzati:='MATRICOLA,T430BADGE,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
    C700DataDal:=Parametri.DataLavoro;
    C700SelezionePeriodica:=False;
  end;
end;

procedure TWA095FStRiasStr.btnModificaDatiClick(Sender: TObject);
begin
  grdRisultati.medpModifica(False);
  ImpostaValoriLiquidato(tvZero);
  SetLiquidazioneInModifica(True);
end;

procedure TWA095FStRiasStr.btnConfermaDatiClick(Sender: TObject);
begin
  ConfermaDati;
  SetLiquidazioneInModifica(False);
end;

procedure TWA095FStRiasStr.btnAnnullaDatiClick(Sender: TObject);
begin
  AnnullaDati;
  SetLiquidazioneInModifica(False);
end;

procedure TWA095FStRiasStr.btnImpostaLiquidatoClick(Sender: TObject);
begin
  ImpostaValoriLiquidato(tvLiquidato);
end;

procedure TWA095FStRiasStr.btnLiquidaClick(Sender: TObject);
var
  LNumPag: Integer;
  LErrore: String;
begin
  // salva numero pagina corrente
  LNumPag:=grdRisultati.medpGetCurrPag;

  // effettua liquidazione della pagina corrente
  if ConfermaLiquidazione(LErrore) then
  begin
    LstPagineBloccate.Add(LNumPag.ToString);
  end
  else
  begin
    MsgBox.MessageBox(LErrore,ESCLAMA);
  end;

  // aggiornamento tabella
  grdRisultati.medpStato:=msBrowse;
  grdRisultati.medpBrowse:=True;
  grdRisultati.medpCaricaCDS;
end;

procedure TWA095FStRiasStr.ConfermaDati;
var
  r: Integer;
  LIdRiga: String;
begin
  grdRisultati.medpDataSet.Cancel;
  for r:=0 to High(grdRisultati.medpCompGriglia) do
  begin
    LIdRiga:=grdRisultati.medpValoreColonna(r,'IdRiga');
    if grdRisultati.medpDataSet.Locate('IdRiga',LIdRiga,[]) then
    begin
      grdRisultati.medpDataSet.Edit;
      grdRisultati.medpConferma(r);
    end;
  end;

  grdRisultati.medpStato:=msBrowse;
  grdRisultati.medpBrowse:=True;
  grdRisultati.medpCaricaCDS;
end;

procedure TWA095FStRiasStr.AnnullaDati;
var
  r: Integer;
  LIdRiga: String;
begin
  grdRisultati.medpDataSet.Cancel;
  for r:=0 to High(grdRisultati.medpCompGriglia) do
  begin
    LIdRiga:=grdRisultati.medpValoreColonna(r,'IdRiga');
    if grdRisultati.medpDataSet.Locate('IdRiga',LIdRiga,[]) then
      grdRisultati.medpAnnulla(r);
  end;
end;

function TWA095FStRiasStr.ConfermaLiquidazione(var RErrMsg: String): Boolean;
var
  r, LIdRiga: Integer;
begin
  grdRisultati.medpDataSet.Cancel;
  try
    for r:=0 to High(grdRisultati.medpCompGriglia) do
    begin
      LIdRiga:=grdRisultati.medpValoreColonna(r,'IdRiga').ToInteger;
      WA095FStRiasStrDM.A095FStRiasStrMW.LiquidazioneDatiModificati(StrToInt(edtAnno.Text),
                                                                    StrToInt(edtMese.Text),
                                                                    rgpDisponibilita.ItemIndex,
                                                                    LIdRiga);
    end;
    Result:=True;
  except
    on E: Exception do
    begin
      RErrMsg:=E.Message;
      Result:=False;
    end;
  end;
end;

procedure TWA095FStRiasStr.chkLiquidazioneAsyncClick(Sender: TObject; EventParams: TStringList);
begin
  inherited;
  imgSoloLiquidazione.Enabled:=chkLiquidazione.Checked;
end;

//ELABORAZIONE
procedure TWA095FStRiasStr.InizioElaborazione;
var
  LstIntestazione, LstDettaglio: TStringList;
  i:Integer;
  S: String;
begin
  inherited;

  with WA095FStRiasStrDM.A095FStRiasStrMW do
  begin
    selDatiBloccati.Close;

    if SenderHTMLName = imgAnnullaLiquidazione.HTMLName then  //Annulla liquidazione
    begin
      ApriSelT071(DataElab,StrToInt(edtAnno.Text),StrToInt(edtMese.Text), grdC700.SelAnagrafe.VariableIndex('C700DATADAL') >= 0);
    end
    else
    begin
      LstIntestazione:=TStringList.Create;
      LstDettaglio:=TStringList.Create;

      for i:=0 to cgpDettaglio.Items.Count - 1 do
        if cgpDettaglio.isChecked[i] then
          LstDettaglio.Add(cgpDettaglio.Items[i]);

      S:=SettaCampiSelAnagrafe(grdC700.selAnagrafe.SQL.Text, StrToInt(edtAnno.Text),LstIntestazione, LstDettaglio);
      if S <> '' then
      begin
        grdC700.selAnagrafe.CloseAll;
        grdC700.selAnagrafe.SQL.Text:=S;
      end;
      FreeAndNil(LstIntestazione);
      FreeAndNil(LstDettaglio);
      //SettaPeriodoSelAnagrafe eseguito sul click per poter aggiornare la statusbar con il numero delle anagrafiche
      grdC700.selAnagrafe.Open;
      grdC700.selAnagrafe.First;

      //Massimo: assegnazione già fatta nel FormCreate
      //SelAnagrafe:=grdC700.selAnagrafe;

      CreaTabellaStampa(True);
      SettaVariabiliDataset(StrToInt(edtAnno.Text),StrToInt(edtMese.Text));
    end;

    IdRiga:=0;
  end;

  // pulisce array delle pagine bloccate per la liquidazione
  LstPagineBloccate.Clear;
end;

procedure TWA095FStRiasStr.ElaboraElemento;
begin
  inherited;
  with WA095FStRiasStrDM.A095FStRiasStrMW do
  begin
    if SenderHTMLName = imgAnnullaLiquidazione.HTMLName then
      ElaboraAnnullaLiquidazione(DataElab)
    else
      ElaboraDipendente(R180Anno(DataElab), R180Mese( DataElab), rgpDisponibilita.ItemIndex, chkLiquidazione.Checked);
  end;
  SessioneOracle.Commit;
end;

function TWA095FStRiasStr.ElementoSuccessivo: Boolean;
var ods: TOracleDataset;
begin
  Result:=False;
  if SenderHTMLName = imgAnnullaLiquidazione.HTMLName then
    ods:=WA095FStRiasStrDM.A095FStRiasStrMW.selT071
  else
    ods:=grdC700.selAnagrafe;

  ods.Next;
  if not ods.EOF then
    Result:=True;
end;

procedure TWA095FStRiasStr.FineCicloElaborazione;
begin
  inherited;
  WA095FStRiasStrDM.A095FStRiasStrMW.PreparaAggiornaFruitoBudget(DataElab);

  imgAnomalie.Enabled:=(RegistraMsg.ContieneTipoA) or (RegistraMsg.ContieneTipoB);
  grdTabDetail.Tabs[WA095RisultatiRG].Enabled:=False;
  //Solo se stampa
  if SenderHTMLName = imgAnteprima.HTMLName then
  begin
    RicaricaGridRisultati:=True;
    grdTabDetail.Tabs[WA095RisultatiRG].Enabled:=True;
    grdTabDetail.ActiveTab:=WA095RisultatiRG;
  end
end;

function TWA095FStRiasStr.ElaborazioneTerminata: String;
begin
  if imgAnomalie.Enabled then
    Result:=A000MSG_MSG_ELABORAZIONE_ANOMALIE
  else
    Result:=inherited;
end;

function TWA095FStRiasStr.CurrentRecordElaborazione: Integer;
begin
  if SenderHTMLName = imgAnnullaLiquidazione.HTMLName then
    Result:=WA095FStRiasStrDM.A095FStRiasStrMW.selT071.RecNO
  else
    Result:=grdC700.selAnagrafe.RecNO;
end;

function TWA095FStRiasStr.TotalRecordsElaborazione: Integer;
begin
  if SenderHTMLName = imgAnnullaLiquidazione.HTMLName then
    Result:=WA095FStRiasStrDM.A095FStRiasStrMW.selT071.RecordCount
  else
    Result:=grdC700.selAnagrafe.RecordCount;
end;

procedure TWA095FStRiasStr.DistruzioneOggettiElaborazione(Errore: Boolean);
begin
  inherited;
  if Errore then
    SessioneOracle.Rollback
  else
  begin
    PutParametriFunzione;
    SessioneOracle.Commit;
  end;
end;

end.
