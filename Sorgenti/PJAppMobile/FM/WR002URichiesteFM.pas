unit WR002URichiesteFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, StrUtils,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses, System.IoUtils,
  uniGUIClasses, uniGUIFrame, WM000UFrameBase, uniGUIBaseClasses, uniGUImJSForm,
  MedpUnimPanelBase, uniPageControl, unimTabPanel, MedpUnimTabPanelBase,
  uniPanel, MedpUnimRadioGroup, MedpUnimPanelDataDaA, MedpUnimPanelNumElem,
  MedpUnimPanelListaElem, MedpUnimPanelHeaderDett, A000UCostanti, A000UInterfaccia, WR002URichiesteMW,
  WR003UNoteMW, WR006UAllegatiMW, WM000UMainModule, MedpUnimPanelNota, MedpUnimPanel4Labels, MedpUnimPanelDisclosure,
  MedpUnimTypes, MedpUnimPanel2Labels, unimPanel, uniButton, uniBitBtn,
  unimBitBtn, MedpUnimPanelListaDisclosure, MedpUnimPanelListaDettaglio, MedpUnimPanelAllegato,
  uniFileUpload, unimFileUpload, MedpUnimMemo, uniLabel, unimLabel,
  MedpUnimLabel, uniEdit, unimEdit, MedpUnimEdit, MedpUnimButton,
  MedpUnimPanel2Button, WM000UServerModule, C180FunzioniGenerali, MedpUnimLabelIcon, MedpUnimPanelEditIcons,
  uniCheckBox, unimCheckBox;

type
  TWR002FRichiesteFM = class(TWM000FFrameBase)
    tpnlRichieste: TMedpUnimTabPanelBase;

    tabElenco: TUnimTabSheet;
      rgpTipoRichiesta: TMedpUnimRadioGroup;
      pnlDataDaA: TMedpUnimPanelDataDaA;
      pnlNumRichieste: TMedpUnimPanelNumElem;
    tabDettaglio: TUnimTabSheet;
      pnlHeaderDettaglio: TMedpUnimPanelHeaderDett;
    tabNote: TUnimTabSheet;
      pnlHeaderNote: TMedpUnimPanelHeaderDett;
      pnlListaNote: TMedpUnimPanelListaElem;
    pnlListaDettaglio: TMedpUnimPanelListaDettaglio;
    pnlListaRichieste: TMedpUnimPanelListaDisclosure;
    tabAllegati: TUnimTabSheet;
    pnlHeaderAllegati: TMedpUnimPanelHeaderDett;
    pnlNuovoModifica: TMedpUnimPanelBase;
    pnlNumAllegati: TMedpUnimPanelNumElem;
    pnlListaAllegati: TMedpUnimPanelListaElem;
    memNoteAllegato: TMedpUnimMemo;
    lblInsNote: TMedpUnimLabel;
    lblInsAllegato: TMedpUnimLabel;
    pnlUpload: TMedpUnimPanelBase;
    pnlModificaFile: TMedpUnimPanel2Labels;
    pnlOkAnnullaAllegato: TMedpUnimPanel2Button;
    chkAllConformi: TUnimCheckBox;
    edtUploadFile: TMedpUnimEdit;
    pnlFiltroRichieste: TMedpUnimPanelBase;

    procedure UniFrameCreate(Sender: TObject); virtual;
    procedure UniFrameDestroy(Sender: TObject); override;

    procedure OnBackClick(Sender: TObject); virtual;
    procedure OnPnlListaRichiesteChange(Sender: TObject); virtual;
    procedure OnFiltriRichiestaChange(Sender: TObject); virtual;
    procedure OnRichiestaClick(Sender: TObject); virtual;
    procedure OnDisclNoteClick(Sender: TObject); virtual;
    procedure OnNotaChange(Sender: Tobject); virtual;
    procedure OnHeaderDettaglioUpClick(Sender: TObject); virtual;
    procedure OnHeaderDettaglioDownClick(Sender: TObject); virtual;
    procedure OnDisclAllegatiClick(Sender: TObject); virtual;
    procedure pnlListaAllegatiChange(Sender: TObject); virtual;
    procedure pnlNumAllegatilblIconaClick(Sender: TObject); virtual;
    procedure btnConfermaAllegatoClick(Sender: TObject); virtual;
    procedure btnAnnullaAllegatoClick(Sender: TObject); virtual;
    procedure btnUploadCompleted(Sender: TObject; AStream: TFileStream); virtual;
    procedure btnEditAllegatoClick(Sender: TObject); virtual;
    procedure btnDeleteAllegatoClick(Sender: TObject); virtual;
    procedure btnDownloadAllegatoClick(Sender: TObject); virtual;
    procedure chkAllConformiClick(Sender: TObject);
  private
    FModalitaAllegato: String; //N = no edit, I = inserimento, M = modifica
    FAllegatoInModifica: TAllegato;
    btnUpload: TUnimFileUploadButton;

    procedure ApriPanelEdit(PInserimento: Boolean);
    procedure ChiudiPanelEdit;
  protected
    WR002RichiesteMW: TWR002FRichiesteMW;
    WR003NoteMW: TWR003FNoteMW;
    WR006AllegatiMW: TWR006FAllegatiMW;

    FAutorizzatore: Boolean;
    FAggiornaListeOnBackClick: Boolean;

    procedure LoadCompleted; override;

    procedure CreaPanelNota(PLivelloNota: Integer; PIntestazione,PTextNota,PStatoAutorizzazione: String; PInModifica: Boolean);

    procedure CreaPanelRichiesta; virtual;
    procedure AggiornaHeaderDettaglio; virtual;
    function AggiornaListaNote: TResCtrl; virtual;
    function AggiornaListaAllegati: TResCtrl; virtual;
    function AggiungiGestAllegatiDettaglio: TResCtrl; virtual;

    function AggiornaListaRichieste: TResCtrl; virtual; abstract;
    function AggiornaListaDettaglio: TResCtrl; virtual; abstract;
    function CreaLabelsRichiesta: TMedpUnimPanelBase; virtual; abstract;
  const
    ITEM_MORE_DETAILS          = '(...)';
    ITEM_TIPO_RICHIESTA_TEXT   = 'Tipo richiesta';
    ITEM_DATA_RICHIESTA_TEXT   = 'Data richiesta';
    ITEM_NOTE_TEXT             = 'Note';
    ITEM_ALLEGATI_TEXT         = 'Allegati';
    ITEM_MOTIVAZIONE_TEXT      = 'Motivazione';
    ITEM_COMPETENZE_TEXT       = 'Competenze';
  end;

implementation

{$R *.dfm}

procedure TWR002FRichiesteFM.UniFrameCreate(Sender: TObject);
begin
  inherited;
  WR003NoteMW:=nil;
  btnUpload:=nil;
  FAutorizzatore:=False;
  FAggiornaListeOnBackClick:=False;

  tpnlRichieste.ActivePage:=tabElenco;

  pnlDataDaA.ChangeEnabled:=False;
  if Assigned(WR002RichiesteMW) then
  begin
    pnlDataDaA.DataDa.Date:=WR002RichiesteMW.FiltroPeriodoDa;
    pnlDataDaA.DataA.Date:=WR002RichiesteMW.FiltroPeriodoA;
  end;
  pnlDataDaA.ChangeEnabled:=True;

  pnlDataDaA.Visible:=False;

  FModalitaAllegato:='N';
end;

procedure TWR002FRichiesteFM.UniFrameDestroy(Sender: TObject);
begin
  FreeAndNil(btnUpload);
  FreeAndNil(WR006AllegatiMW);
  FreeAndNil(WR002RichiesteMW);
  FreeAndNil(WR003NoteMW);
  inherited;
end;

procedure TWR002FRichiesteFM.LoadCompleted;
begin
  inherited;
  //qui devo avere FAutorizzatore già valorizzato

  //gestione allegati abilitata solo per iter giustificativi e certificazioni
  if ((WR002RichiesteMW.Iter = ITER_GIUSTIF) or (WR002RichiesteMW.Iter = ITER_CERTIFICAZIONI)) and A000SessioneIrisWin.Parametri.ModuloInstallato['ITER_AUTORIZZATIVI'] then
  begin
    WR006AllegatiMW:=TWR006FAllegatiMW.Create(A000SessioneIrisWIN, WR002RichiesteMW.DataSet, WR002RichiesteMW.Iter, FAutorizzatore);
    FAggiornaListeOnBackClick:=True;
  end
  else
    WR006AllegatiMW:=nil;

  AggiornaListaRichieste;
end;

procedure TWR002FRichiesteFM.OnPnlListaRichiesteChange(Sender: TObject);
begin
  inherited;
  pnlNumRichieste.NumElementi:=pnlListaRichieste.NumeroElementi;
end;

procedure TWR002FRichiesteFM.OnRichiestaClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  if (Sender is TMedpUnimPanelDisclosure) then
  begin
    if WR002RichiesteMW.Locate('ID', (Sender as TMedpUnimPanelDisclosure).Key, [])  then
    begin
      AggiornaHeaderDettaglio;
      LResCtrl:=AggiornaListaDettaglio;

      if LResCtrl.Ok then
        tpnlRichieste.Next
      else
        ShowMessage(LResCtrl.Messaggio);
    end;
  end;
end;

procedure TWR002FRichiesteFM.OnFiltriRichiestaChange(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  inherited;

  WR002RichiesteMW.FiltroPeriodoDa:=pnlDataDaA.DataDa.Date;
  WR002RichiesteMW.FiltroPeriodoA:=pnlDataDaA.DataA.Date;

  if rgpTipoRichiesta.ItemIndex = 0 then
  begin
    WR002RichiesteMW.FiltroStatoRichiesta:=TStatoRichieste.srDaAutorizzare;
    pnlDataDaA.Visible:=False;
  end
  else if rgpTipoRichiesta.ItemIndex = 1 then
  begin
    WR002RichiesteMW.FiltroStatoRichiesta:=TStatoRichieste.srAutorizzate;
    pnlDataDaA.Visible:=True;
  end
  else if rgpTipoRichiesta.ItemIndex = 2 then
  begin
    WR002RichiesteMW.FiltroStatoRichiesta:=TStatoRichieste.srNegate;
    pnlDataDaA.Visible:=True;
  end;

  LResCtrl:=AggiornaListaRichieste;
  if not LResCtrl.Ok then
    ShowMessage(LResCtrl.Messaggio);
end;

procedure TWR002FRichiesteFM.OnHeaderDettaglioDownClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  if WR002RichiesteMW.Next then
  begin
    AggiornaHeaderDettaglio;
    LResCtrl:=AggiornaListaDettaglio;

    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWR002FRichiesteFM.OnHeaderDettaglioUpClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  if WR002RichiesteMW.Prior then
  begin
    AggiornaHeaderDettaglio;
    LResCtrl:=AggiornaListaDettaglio;

    if not LResCtrl.Ok then
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWR002FRichiesteFM.OnBackClick(Sender: TObject);
var LModalResult: Integer;
    LMessaggio: String;
begin
  inherited;
  if tpnlRichieste.ActivePage = tabNote then
  begin
    if FAggiornaListeOnBackClick then
      AggiornaListaDettaglio;
    tpnlRichieste.ActivePage:=tabDettaglio
  end
  else if tpnlRichieste.ActivePage = tabAllegati then
  begin
    if FModalitaAllegato <> 'N' then
    begin
      if FModalitaAllegato = 'I' then
        LMessaggio:='Annullare l''inserimento dell''allegato?'
      else if FModalitaAllegato = 'M' then
        LMessaggio:='Annullare la modifica dell''allegato?';

      LModalResult:=MessageDlg(LMessaggio, TMsgDlgType.mtConfirmation, mbYesNo);
      if LModalResult = mrNo then
        Exit;
    end;
    ChiudiPanelEdit;
    if FAggiornaListeOnBackClick then
      AggiornaListaDettaglio;
    tpnlRichieste.ActivePage:=tabDettaglio
  end
  else if tpnlRichieste.ActivePage = tabDettaglio then
  begin
    if FAggiornaListeOnBackClick then
      AggiornaListaRichieste;
    tpnlRichieste.ActivePage:=tabElenco;
  end;
end;

procedure TWR002FRichiesteFM.CreaPanelRichiesta;
begin
  pnlListaRichieste.Add(CreaLabelsRichiesta, True, WR002RichiesteMW.ID, OnRichiestaClick);
end;

procedure TWR002FRichiesteFM.AggiornaHeaderDettaglio;
begin
  pnlHeaderDettaglio.Up.Visible:=WR002RichiesteMW.PrecEnabled;
  pnlHeaderDettaglio.Down.Visible:=WR002RichiesteMW.SuccEnabled;

  pnlHeaderDettaglio.LabelDettaglio.Caption:='Richiesta ' + WR002RichiesteMW.RecNo.ToString + ' di ' + WR002RichiesteMW.RecordCount.ToString;
end;

//**************************************** GESTIONE NOTE ****************************************//

procedure TWR002FRichiesteFM.OnNotaChange(Sender: Tobject);
var LResCtrl: TResCtrl;
begin
  if Assigned(WR002RichiesteMW) and Assigned(WR003NoteMW) then
  begin
    if Sender is TMedpUnimPanelNota then
    begin
      if WR003NoteMW.Locate((Sender as TMedpUnimPanelNota).Key) then
      begin
        if Trim((Sender as TMedpUnimPanelNota).Memo.Memo.Text) = '(nessuna nota)' then
          WR003NoteMW.Nota:=''
        else
          WR003NoteMW.Nota:=(Sender as TMedpUnimPanelNota).Memo.Memo.Text;

        with WM000FMainModule do
        begin
          LResCtrl:=WR003NoteMW.SetNoteRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

          if not LResCtrl.Ok then
            ShowMessage(LResCtrl.Messaggio);
        end;
      end;
    end;
  end;
end;

procedure TWR002FRichiesteFM.OnDisclNoteClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  if (Sender is TMedpUnimPanelDisclosure) and (tpnlRichieste.ActivePage = tabDettaglio) then
  begin
    LResCtrl:=AggiornaListaNote;

    if LResCtrl.Ok then
      tpnlRichieste.ActivePage:=tabNote
    else
      ShowMessage(LResCtrl.Messaggio);
  end;
end;

procedure TWR002FRichiesteFM.CreaPanelNota(PLivelloNota: Integer; PIntestazione,PTextNota,PStatoAutorizzazione: String; PInModifica: Boolean);
var LNota: TMedpUnimPanelNota;
begin
  LNota:=TMedpUnimPanelNota.Create(Self);

  with LNota do
  begin
    Memo.Memo.Text:=PTextNota;
    if PStatoAutorizzazione = '' then
      LabelStatoAutorizzazione.Caption:=''
    else
      LabelStatoAutorizzazione.Caption:='(' + PStatoAutorizzazione + ')';

    LabelIntestazione.Caption:=PIntestazione;
    LabelIntestazione.Font.Style:=[fsBold];
    EditIcon.Visible:=PInModifica;
    Key:=PLivelloNota;
    OnChange:=OnNotaChange;
  end;

  pnlListaNote.Add(LNota);
end;

function TWR002FRichiesteFM.AggiornaListaNote: TResCtrl;
begin
  pnlListaNote.Clear;

  if Assigned(WR002RichiesteMW) then
  begin
    if Assigned(WR003NoteMW) then
      FreeAndNil(WR003NoteMW);

    WR003NoteMW:=TWR003FNoteMW.Create(WR002RichiesteMW.ID, WR002RichiesteMW.LivelloAutorizzazione, AbilitazioneFunzione);

    with WM000FMainModule do
    begin
      Result:=WR003NoteMW.GetNoteRichiestaSRV(B110ClientModule, InfoClient, InfoLogin.ParametriLogin);

      if Result.Ok then
        while not WR003NoteMW.Eof do
        begin
          CreaPanelNota(WR003NoteMW.LivelloNota, WR003NoteMW.Intestazione, WR003NoteMW.Nota, WR003NoteMW.Autorizzazione, WR003NoteMW.InModifica);
          WR003NoteMW.Next;
        end;
    end;
  end
  else
  begin
    Result.Ok:=False;
    Result.Messaggio:='Errore: Oggetto WR002RichiesteMW non inizializzato, impossibile aggiornare la lista delle note';
  end;
end;

//**************************************** GESTIONE ALLEGATI ****************************************//

procedure TWR002FRichiesteFM.OnDisclAllegatiClick(Sender: TObject);
var LResCtrl: TResCtrl;
begin
  if Assigned(WR006AllegatiMW)then
    if (Sender is TMedpUnimPanelDisclosure) and (tpnlRichieste.ActivePage = tabDettaglio) then
    begin
      pnlNumAllegati.Icona.Visible:=not FAutorizzatore
                                    and not (WR002RichiesteMW.FiltroStatoRichiesta = srNegate) //non posso editare richieste negare o revocate
                                    and not (WR002RichiesteMW.TipoRichiesta = 'R');

      LResCtrl:=AggiornaListaAllegati;
      if LResCtrl.Ok then
        tpnlRichieste.ActivePage:=tabAllegati
      else
        ShowMessage(LResCtrl.Messaggio);
    end;
end;

procedure TWR002FRichiesteFM.pnlListaAllegatiChange(Sender: TObject);
begin
  inherited;
  pnlNumAllegati.NumElementi:=pnlListaAllegati.NumeroElementi;
end;

procedure TWR002FRichiesteFM.pnlNumAllegatilblIconaClick(Sender: TObject);
begin
  inherited;
  if (FModalitaAllegato = 'N') and Assigned(WR006AllegatiMW) then
  begin

    if WR006AllegatiMW.MaxAllegatiSuperato then
    begin
      ShowMessage(Format('E'' possibile allegare alla richiesta un massimo di %d file', [WR006AllegatiMW.MaxAllegati]));
      Exit;
    end;

    ApriPanelEdit(True);
  end
  else
    ShowMessage('Terminare l''operazione di ' + IfThen(FModalitaAllegato = 'M', 'modifica', 'inserimento') + ' in corso prima di procedere con l''operazione richiesta');
end;

procedure TWR002FRichiesteFM.btnEditAllegatoClick(Sender: TObject);
begin
  inherited;

  if Assigned(WR006AllegatiMW) then
  begin
    FAllegatoInModifica:=(((Sender as TMedpUnimLabelIcon).Parent as TMedpUnimPanelEditIcons).Parent as TMedpUnimPanelAllegato).Data as TAllegato;

    if FModalitaAllegato = 'N' then
      ApriPanelEdit(False)
    else
      ShowMessage('Terminare l''operazione di ' + IfThen(FModalitaAllegato = 'M', 'modifica', 'inserimento') + ' in corso prima di procedere con l''operazione richiesta');
  end;
end;

procedure TWR002FRichiesteFM.btnDeleteAllegatoClick(Sender: TObject);
var LModalResult: Integer;
    LAllegato: TAllegato;
    LResCtrl: TResCtrl;
begin
  inherited;

  if (FModalitaAllegato = 'N') and Assigned(WR006AllegatiMW) then
  begin
    LModalResult:=MessageDlg('Eliminare l''allegato selezionato?', TMsgDlgType.mtConfirmation, mbYesNo);

    if LModalResult = mrYes then
    begin
      LAllegato:=(((Sender as TMedpUnimLabelIcon).Parent as TMedpUnimPanelEditIcons).Parent as TMedpUnimPanelAllegato).Data as TAllegato;
      LResCtrl:=WR006AllegatiMW.EliminaAllegato(LAllegato.IdRichiesta, LAllegato.IdT960);

      if not LResCtrl.Ok then
      begin
        ShowMessage(LResCtrl.Messaggio);
        Exit;
      end;

      LResCtrl:=AggiornaListaAllegati;
      if not LResCtrl.Ok then
      begin
        ShowMessage(LResCtrl.Messaggio);
        Exit;
      end;
    end;
  end
  else
    ShowMessage('Terminare l''operazione di ' + IfThen(FModalitaAllegato = 'M', 'modifica', 'inserimento') + ' in corso prima di procedere con l''operazione richiesta');
end;

procedure TWR002FRichiesteFM.btnDownloadAllegatoClick(Sender: TObject);
var LNomeFile, LRandomFolder, LPathFile: String;
    LAllegato: TAllegato;
    LResCtrl: TResCtrl;
begin
  inherited;

  if Assigned(WR006AllegatiMW) then
  begin
    repeat
      LRandomFolder:=IntToStr(Random(9999));
      LPathFile:=TPath.Combine(WM000FServerModule.LocalCachePath,LRandomFolder);
    until not DirectoryExists(LPathFile);

    LAllegato:=((Sender as TMedpUnimLabelIcon).Parent as TMedpUnimPanelAllegato).Data as TAllegato;

    LResCtrl:=WR006AllegatiMW.SalvaAllegatoDaDB(LAllegato.IdT960, LPathFile, LNomeFile);
    if not LResCtrl.Ok then
    begin
      ShowMessage(LResCtrl.Messaggio);
      Exit;
    end;

    UniSession.AddJS('window.open("' + WM000FServerModule.GlobalCacheURL + UniSession.SessionId + '/' + LRandomFolder + '/' + LNomeFile +'", "_blank")');
    //UniSession.SendFile(TPath.Combine(LPathFile, LNomeFile)); //scarica il file, su IPhone in firefox e chrome non funziona
  end;
end;

procedure TWR002FRichiesteFM.btnConfermaAllegatoClick(Sender: TObject);
var LMessaggio: String;
    LModalResult: Integer;
    LResCtrl: TResCtrl;
begin
  inherited;

  if Assigned(WR006AllegatiMW) then
  begin
    if FModalitaAllegato = 'I' then
      LMessaggio:='Confermare l''inserimento dell''allegato?'
    else if FModalitaAllegato = 'M' then
      LMessaggio:='Confermare la modifica dell''allegato?';

    LModalResult:=MessageDlg(LMessaggio, TMsgDlgType.mtConfirmation, mbYesNo);

    if LModalResult = mrYes then
    begin
      if FModalitaAllegato = 'I' then
        LResCtrl:=WR006AllegatiMW.InserisciAllegato(WR002RichiesteMW.ID, btnUpload.FileName, btnUpload.CacheFile, Trim(memNoteAllegato.Memo.Text))
      else if FModalitaAllegato = 'M' then
        LResCtrl:=WR006AllegatiMW.ModificaAllegato(FAllegatoInModifica.IdT960, Trim(memNoteAllegato.Memo.Text));

      if not LResCtrl.Ok then
      begin
        ShowMessage(LResCtrl.Messaggio);
        Exit;
      end;

      FAllegatoInModifica:=nil;

      LResCtrl:=AggiornaListaAllegati;
      if not LResCtrl.Ok then
      begin
        ShowMessage(LResCtrl.Messaggio);
        Exit;
      end;

      ChiudiPanelEdit;
    end;
  end;
end;

procedure TWR002FRichiesteFM.btnUploadCompleted(Sender: TObject; AStream: TFileStream);
begin
  inherited;
  edtUploadFile.Text:=btnUpload.FileName;

  if (FModalitaAllegato = 'I') and chkAllConformi.Checked and  (btnUpload.FileName <> '')  then
    pnlOkAnnullaAllegato.Button1.Enabled:=True
  else
    pnlOkAnnullaAllegato.Button1.Enabled:=False;
end;

procedure TWR002FRichiesteFM.chkAllConformiClick(Sender: TObject);
begin
  inherited;
  if (FModalitaAllegato = 'I') and chkAllConformi.Checked and  (btnUpload.FileName <> '')  then
    pnlOkAnnullaAllegato.Button1.Enabled:=True
  else
    pnlOkAnnullaAllegato.Button1.Enabled:=False;
end;

procedure TWR002FRichiesteFM.btnAnnullaAllegatoClick(Sender: TObject);
var LMessaggio: String;
    LModalResult: Integer;
begin
  inherited;
  if FModalitaAllegato = 'I' then
    LMessaggio:='Annullare l''inserimento dell''allegato?'
  else if FModalitaAllegato = 'M' then
    LMessaggio:='Annullare la modifica dell''allegato?';

  LModalResult:=MessageDlg(LMessaggio, TMsgDlgType.mtConfirmation, mbYesNo);

  if LModalResult = mrYes then
    ChiudiPanelEdit;
end;

function TWR002FRichiesteFM.AggiornaListaAllegati: TResCtrl;
var temp: TMedpUnimPanelAllegato;
    i: Integer;
const ERRORE = 'Errore durante l''aggiornamento della lista degli allegati: %s';
begin
  Result.Clear;

  if Assigned(WR006AllegatiMW) then
  begin
    pnlListaAllegati.Clear;

    Result:=WR006AllegatiMW.AggiornaListaAllegati(WR002RichiesteMW.ID);
    if not Result.Ok then
    begin
      Result.Messaggio:=Format(ERRORE,[Result.Messaggio]);
      Exit;
    end;
    try
      with WR006AllegatiMW do
      begin
        for i:=0 to ListaAllegati.Count-1 do
        begin
          temp:=TMedpUnimPanelAllegato.Create(Self, ListaAllegati[i].NomeFile + '.' + ListaAllegati[i].ExtFile, R180GetFileSizeStr(ListaAllegati[i].Dimensione), ListaAllegati[i].Note);
          temp.pnlEditIcons.Visible:=not FAutorizzatore
                                     and not (WR002RichiesteMW.FiltroStatoRichiesta = srNegate) //non posso editare richieste negare o revocate
                                     and not (WR002RichiesteMW.TipoRichiesta = 'R');;
          temp.pnlEditIcons.Label1.OnClick:=btnEditAllegatoClick;
          temp.pnlEditIcons.Label2.OnClick:=btnDeleteAllegatoClick;
          temp.lblDownloadIcon.OnClick:=btnDownloadAllegatoClick;
          temp.Data:=ListaAllegati[i];
          pnlListaAllegati.Add(temp);
        end;
      end;
    except
      on E: Exception do
      begin
        Result.Ok:=False;
        Result.Messaggio:=Format(ERRORE,[E.Message]);
      end;
    end;
  end
  else
    Result.Messaggio:=Format(ERRORE,['Gestione degli allegati non abilitata']);
end;

function TWR002FRichiesteFM.AggiungiGestAllegatiDettaglio: TResCtrl;
var LDettAllegati: String;
    LCondizioneAllegati: String;
    LNumAllegati: Integer;
begin
  Result.Clear;
  try
    if Assigned(WR006AllegatiMW) then // se è attiva la gestione allegati
    begin
      LCondizioneAllegati:=WR006AllegatiMW.GetCondizioneAllegati;
      LNumAllegati:=WR006AllegatiMW.GetNumeroAllegati(WR002RichiesteMW.ID);
      LDettAllegati:='';

      if LCondizioneAllegati = 'F' then
        LDettAllegati:='facoltativi - '
      else if LCondizioneAllegati = 'O' then
        LDettAllegati:='obbligatori - ';

      if LNumAllegati = 1 then
        LDettAllegati:=LDettAllegati + '1 allegato presente'
      else if LNumAllegati > 1 then
        LDettAllegati:=LDettAllegati + IntToStr(LNumAllegati) + ' allegati presenti'
      else
        LDettAllegati:=LDettAllegati + 'nessun allegato presente';

      if LDettAllegati <> '' then
        pnlListaDettaglio.Add2Labels(ITEM_ALLEGATI_TEXT, LDettAllegati, True, 0, OnDisclAllegatiClick);
    end;
    Result.Ok:=True;
  except
    on E: Exception do
    begin
      Result.Messaggio:=E.Message;
    end;
  end;
end;

procedure TWR002FRichiesteFM.ApriPanelEdit(PInserimento: Boolean);
begin
  if PInserimento then
  begin
    edtUploadFile.Text:='';
    edtUploadFile.Visible:=True;
    btnUpload:=TUnimFileUploadButton.Create(Self);
    btnUpload.Height:=40;
    btnUpload.JSInterface.JSAddListener('added', 'function(sender){ if (sender.inputElement) {sender.inputElement.hide()} if (sender.labelElement){sender.labelElement.hide()};' + ' sender.setWidth("41px"); sender.setHeight("40px"); fbtn=sender.getFileButton(); if (fbtn) {fbtn.setStyle("margin-right", "3px"); fbtn.setText("<i class=''fas fa-file-upload'' style=''font-size: 150%;''></i>");' + '};}');
    btnUpload.OnCompleted:=btnUploadCompleted;
    btnUpload.SetSubComponent(True);
    btnUpload.Parent:=pnlUpload;
    FModalitaAllegato:='I';
    lblInsAllegato.Caption:='Inserimento allegato';
    pnlModificaFile.Visible:=False;
    chkAllConformi.Visible:=True;
    chkAllConformi.Checked:=False;
    memNoteAllegato.Memo.Clear;
    pnlOkAnnullaAllegato.Button1.Enabled:=False;
    pnlNuovoModifica.JSInterface.JSCall('setHeight',['303px']);
    btnUpload.Enabled:=True;
  end
  else
  begin
    edtUploadFile.Text:='';
    FreeAndNil(btnUpload);
    edtUploadFile.Visible:=False;
    FModalitaAllegato:='M';
    lblInsAllegato.Caption:='Modifica allegato';
    pnlModificaFile.Visible:=True;
    chkAllConformi.Visible:=False;
    pnlOkAnnullaAllegato.Button1.Enabled:=True;
    pnlModificaFile.Label2.Caption:=FAllegatoInModifica.NomeFile + '.' + FAllegatoInModifica.ExtFile;
    memNoteAllegato.Memo.Text:=FAllegatoInModifica.Note;
    pnlNuovoModifica.JSInterface.JSCall('setHeight',['183px']);
  end;

  pnlNuovoModifica.BoxModel.CSSBorder.Top:='2px solid black';
  pnlNuovoModifica.BoxModel.CSSBorder.Bottom:='2px solid black';
  pnlNuovoModifica.BoxModel.CSSPadding.Left:='3px';
  pnlNuovoModifica.BoxModel.CSSPadding.Right:='3px';
end;


procedure TWR002FRichiesteFM.ChiudiPanelEdit;
begin
  FModalitaAllegato:='N';
  edtUploadFile.Text:='';
  FreeAndNil(btnUpload);
  pnlNuovoModifica.JSInterface.JSCall('setHeight',['0px']);
  pnlNuovoModifica.BoxModel.CSSBorder.Top:='0px';
  pnlNuovoModifica.BoxModel.CSSBorder.Bottom:='0px';
end;

initialization
  RegisterClass(TWR002FRichiesteFM);

end.
