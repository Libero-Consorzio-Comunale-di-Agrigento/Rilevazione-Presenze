unit W018URichiestaTimbrature;

interface

uses
  A000UCostanti, A000USessione, A000UInterfaccia, A000UMessaggi, W000UMessaggi,
  A023UTimbratureMW, A023UAllTimbMW, R010UPaginaWeb, R012UWebAnagrafico, R013UIterBase,
  W018URiepilogoEccedenzeFM, W005UCartellinoFM, W018URichiestaTimbratureDM,
  C018UIterAutDM, C180FunzioniGenerali, C190FunzioniGeneraliWeb,
  IWApplication, IWAppForm, SysUtils, Classes, Graphics, Controls, Math, StrUtils,
  IWControl, IWHTMLControls, IWCompListbox, IWCompEdit,
  OracleData, IWCompCheckbox, DatiBloccati, IWDBGrids, Variants,
  IWVCLBaseControl, meIWCheckBox, Forms, IWVCLBaseContainer, IWContainer,
  meIWGrid, DB, IWCompMemo, Oracle, ActnList, meIWMemo, DBClient,
  meTIWAdvRadioGroup, medpIWDBGrid, medpIWMessageDlg, meIWImageFile, meIWButton,
  meIWEdit, meIWLabel, meIWComboBox, IWCompGrids, IWCompExtCtrls, meIWLink,
  IWCompButton, Menus, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompLabel, IWBaseControl, IWBaseHTMLControl;

type
  TMotivazioni = record
    Codice: String;
    Descrizione: String;
  end;

  TRilevatori = record
    Codice: String;
    Descrizione: String;
    Funzione: String;
    Text: String;
  end;

  TRecordRichiesta = record
    Data: TDateTime;
    Ora: String;
    Verso: String;
    VersoModificato: Boolean;
    Causale: String;
    Operazione: String;
    DataRichiesta: TDateTime;
    Motivazione: String;
    Rilevatore: String;
    FunzioneRilevatore: String;
  end;

  TAutorizza = record
    Rowid:String;
    Checked:Boolean;
    Caption:TCaption;
    Operazione:String;
  end;

  TW018FRichiestaTimbrature = class(TR013FIterBase)
    dsrT105: TDataSource;
    cdsT105: TClientDataSet;
    grdTimbrature: TmedpIWDBGrid;
    dsrT100: TDataSource;
    cdsT100: TClientDataSet;
    btnVisualizza: TmeIWButton;
    edtDataFiltro: TmeIWEdit;
    lblDataFiltro: TmeIWLabel;
    btnRiepilogoOre: TmeIWButton;
    btnImporta: TmeIWButton;
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure btnVisualizzaClick(Sender: TObject);
    procedure chkAutorizzazioneClick(Sender: TObject);
    procedure chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure btnRiepilogoOreClick(Sender: TObject);
    procedure grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdTimbratureAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure edtDataFiltroSubmit(Sender: TObject);
    procedure btnImportaClick(Sender: TObject);
    procedure grdTimbratureRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    FData: TDateTime;
    FArrMotivazioni: array of TMotivazioni;
    FMotivazioneDefault: Integer;
    FLstCausFilt: TStringList;
    FArrRilevatori: array of TRilevatori;
    FAbilIns: Boolean;
    FAbilCanc: Boolean;
    FAutorizza: TAutorizza;
    FRichiesta: TRecordRichiesta;
    FStileCella1: String;
    FStileCella2: String;
    FMemoText: String;
    W018DM: TW018FRichiestaTimbratureDM;
    W018FRiepilogoOreFM: TW018FRiepilogoEccedenzeFM;
    W005FCartellinoFM: TW005FCartellinoFM;
    FAutorizzazioniDaConfermare: Boolean;
    // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
    A023MW: TA023FTimbratureMW;
    // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine
    FDatiTimb: TDatiRichiestaTimb;
    procedure grdRichiesteColumnClick(ASender: TObject; const AValue: string);
    procedure grdTimbratureColumnClick(ASender: TObject; const AValue: string);
    procedure AutorizzazioneOK;
    function  ArrIndexFromCodice(const Tipo: String; const Codice: String): Integer;
    function  _ArrMotivazioniGetIndex(const Codice: String; p,r:Integer): Integer;
    function  _ArrRilevatoriGetIndex(const Codice: String; p,r:Integer): Integer;
    procedure GetDatiTabellari;
    procedure imgModificaCausClick(Sender: TObject);
    procedure imgAnnullaCausClick(Sender: TObject);
    procedure imgConfermaCausClick(Sender: TObject);
    procedure imgCancellaRichiestaClick(Sender: TObject);
    procedure TrasformaCompCausale(const FN:String);
    procedure GetModificaTimbrature;
    procedure AllineaTimbrature;
    procedure imgCancellaClick(Sender: TObject);
    procedure imgInserisciClick(Sender: TObject);
    procedure imgModificaClick(Sender: TObject);
    procedure imgConfermaClick(Sender: TObject);
    procedure imgAnnullaClick(Sender: TObject);
    procedure imgIterClick(Sender: TObject);
    procedure imgAllegClick(Sender: TObject); // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2
    procedure imgDettaglioGGClick(Sender: TObject);
    procedure cmbCausaleChange(Sender: TObject);
    procedure AggiornaTitoloNote(Causale:String);
    procedure TrasformaComponenti(FN:String; DaTestoAControlli:Boolean);
    function  ModificheRiga(FN:String): Boolean;
    function  ControlliOK(FN:String): Boolean;
    procedure EseguiRichiesta;
    procedure ConfermaInsRichiesta;
    procedure AnnullaInsRichiesta;
    procedure PostInsRichiesta;
    procedure PostAnnullaRichiesta;
    procedure GestisciRisposteRichiestaTimb;
    procedure SetAutorizzazione(Sender: TObject);
    procedure W018AutorizzaTutto(Sender: TObject; var Ok: Boolean);
    function  DecodificaFunzioneRilevatore(const PFunzione: String): String;
  protected
    procedure RefreshPage; override;
    procedure GetDipendentiDisponibili(Data:TDateTime); override;
    procedure VisualizzaDipendenteCorrente; override;
    procedure DistruggiOggetti; override;
  public
    function  InizializzaAccesso:Boolean; override;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
  end;

implementation

{$R *.DFM}

function TW018FRichiestaTimbrature.InizializzaAccesso:Boolean;
const
  FUNZIONE = 'InizializzaAccesso';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Result:=True;
  FData:=ParametriForm.Al;
  GetDipendentiDisponibili(FData);
  selAnagrafeW.SearchRecord('PROGRESSIVO',ParametriForm.Progressivo,[srFromBeginning]);

  if WR000DM.Responsabile then
  begin
    // seleziona l'item "tutti i dipendenti" (o l'unico della lista)
    cmbDipendentiDisponibili.ItemIndex:=0;

    // cfr. TC018FIterAutDM.ImpostaFiltriRichiestaPerIter
  end
  else
  begin
    // se data filtro è specificata -> funzione chiamata dal cartellino
    if ParametriForm.DataFiltro = 0 then
      ParametriForm.DataFiltro:=Date - 1;
    edtDataFiltro.Text:=DateToStr(ParametriForm.DataFiltro);
  end;

  if WR000DM.Responsabile then
  begin
    medpAutorizzaMultiplo:=True;
    OnAutorizzaTutto:=W018AutorizzaTutto;
  end;

  GetDatiTabellari;//+++

  // visualizza i dati del dipendente selezionato
  VisualizzaDipendenteCorrente;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.IWAppFormCreate(Sender: TObject);
const
  FUNZIONE = 'IWAppFormCreate';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Tag:=IfThen(WR000DM.Responsabile,419,418);
  inherited;
  W018DM:=TW018FRichiestaTimbratureDM.Create(Self);
  Iter:=ITER_TIMBR;

  FDatiTimb:=TDatiRichiestaTimb.Create;
  W018DM.C018:=C018;
  if WR000DM.Responsabile then
    C018.PreparaDataSetIter(W018DM.selT105,tiAutorizzazione)
  else
    C018.PreparaDataSetIter(W018DM.selT105,tiRichiesta);

  Self.HelpKeyWord:=IfThen(WR000DM.Responsabile,'W018P1','W018P0');
  FData:=Parametri.DataLavoro;

  // imposta la data di ricerca timbrature effettuate
  edtDataFiltro.Text:=DateToStr(Date - 1);

  // abilitazioni elementi
  FAbilIns:=(not SolaLettura) and
           (not WR000DM.Responsabile) and
           (Parametri.InserisciTimbrature = 'S');
  FAbilCanc:=(not SolaLettura) and
            ((Parametri.CancellaTimbrature = 'S') or (Parametri.T100_CancTimbOrig = 'S'));

  // timbrature da modificare: solo per il dipendente
  btnVisualizza.Visible:=not WR000DM.Responsabile;
  edtDataFiltro.Visible:=not WR000DM.Responsabile;
  lblDataFiltro.Visible:=not WR000DM.Responsabile;

  // tabella delle timbrature
  grdTimbrature.medpRighePagina:=GetRighePaginaTabella;
  grdTimbrature.medpDataSet:=W018DM.selT100ModifTimb;
  grdTimbrature.medpTestoNoRecord:='Nessuna timbratura';

  // tabella delle richieste
  grdRichieste.medpRighePagina:=GetRighePaginaTabella;
  grdRichieste.medpDataSet:=W018DM.selT105;
  grdRichieste.medpTestoNoRecord:=A000TraduzioneStringhe(A000MSG_MSG_NESSUNA_RICHIESTA);

  // datamodule per acquisizione timbrature web
  FAutorizzazioniDaConfermare:=False;
  A023MW:=TA023FTimbratureMW.Create(Self);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.RefreshPage;
const
  FUNZIONE = 'RefreshPage';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  WR000DM.Responsabile:=Tag = 419;
  if not FAutorizzazioniDaConfermare then
    VisualizzaDipendenteCorrente;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.IWAppFormRender(Sender: TObject);
const
  FUNZIONE = 'IWAppFormRender';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  BloccaGestione:=grdRichieste.medpStato <> msBrowse;

  // autorizza / nega tutto
  if medpAutorizzaMultiplo then
  begin
    if btnTuttiSi.Visible then
      btnTuttiSi.Visible:=(W018DM.selT105.RecordCount > 0) and (FAutorizza.Operazione = '');
    btnTuttiNo.Visible:=btnTuttiSi.Visible;
  end;

  // acquisizione timbrature
  // abilitata solo per le richieste da autorizzare se il corrispondente parametro aziendale è attivo
  btnImporta.Visible:=(Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S') and
                      (WR000DM.Responsabile) and // bugfix - SGIULIANOMILANESE_COMUNE - chiamata <76351>
                      (W018DM.selT105.RecordCount > 0) and
                      (C018.TipoRichiesteSel = [trDaAutorizzare]);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdRichiesteRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  LNumColonna: Integer;
  idx: Integer;
  LCampo: String;
begin
  if not (ACell.Grid as TmedpIWDBGrid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;

  LNumColonna:=grdRichieste.medpNumColonna(AColumn);
  LCampo:=grdRichieste.medpColonna(LNumColonna).DataField;

  // assegnazione stili
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) then
  begin
    if LCampo = 'D_AUTORIZZAZIONE' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center';
      if grdRichieste.medpValoreColonna(ARow - 1,'AUTORIZZAZIONE') = 'N' then
        ACell.Css:=ACell.Css + ' font_rosso';
    end
    else if LCampo = 'D_ELABORATO' then
    begin
      ACell.Css:=ACell.Css + ' font_grassetto align_center' +
                 IfThen(grdRichieste.medpValoreColonna(ARow - 1,'ELABORATO') = 'E',' font_rosso')
    end;
  end;

  // gestione degli Hint
  if (ARow > 0) and (Length(grdRichieste.medpCompGriglia) > 0) and (ACell.Text <> '') then
  begin
    if LCampo = 'CAUSALE_UTILE' then
    begin
      ACell.Hint:=VarToStr(W018DM.selT275Lookup.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
      ACell.ShowHint:=ACell.Hint <> '';
    end
    else if LCampo = 'CAUSALE_ORIG' then
    begin
      ACell.Hint:=VarToStr(W018DM.selT275Lookup.Lookup('CODICE',ACell.Text,'DESCRIZIONE'));
      ACell.ShowHint:=ACell.Hint <> '';
    end
    else if (LCampo = 'RILEVATORE_RICH') or
            (LCampo = 'RILEVATORE_ORIG') then // MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
    begin
      idx:=ArrIndexFromCodice('R',grdRichieste.medpValoreColonna(ARow - 1,LCampo));
      if idx >= 0 then
        ACell.Hint:=FArrRilevatori[idx].Descrizione;
      ACell.ShowHint:=ACell.Hint <> '';
    end;
    // MONDOEDP - commessa: MAN/07 SVILUPPO#54.ini
    // gestione colonna descrizione motivazione in tabella
    {
    else if Campo = 'MOTIVAZIONE' then
    begin
      idx:=ArrIndexFromCodice('M',grdRichieste.medpValoreColonna(ARow - 1,'MOTIVAZIONE'));
      if idx >= 0 then
        ACell.Hint:=ArrMotivazioni[idx].Descrizione;
      ACell.ShowHint:=ACell.Hint <> '';
    end;
    }
    // MONDOEDP - commessa: MAN/07 SVILUPPO#54.fine
  end;

  // assegnazione componenti
  if (ARow > 0) and (ARow <= High(grdRichieste.medpCompGriglia) + 1) and (grdRichieste.medpCompGriglia[ARow - 1].CompColonne[LNumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdRichieste.medpCompGriglia[ARow - 1].CompColonne[LNumColonna];
  end;
end;

procedure TW018FRichiestaTimbrature.grdRichiesteAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i,x,LivAut,LivCaus: Integer;
  HintDesc,Op,CausUtile: String;
  DatiModificabili:Boolean;
  IWImg: TmeIWImageFile;
const
  FUNZIONE = 'grdRichiesteAfterCaricaCDS';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  //Righe dati
  for i:=0 to High(grdRichieste.medpCompGriglia) do
  begin
    C018.Id:=StrToIntDef(VarToStr(grdRichieste.medpValoreColonna(i,'ID')),-1);
    C018.CodIter:=VarToStr(grdRichieste.medpValoreColonna(i,'COD_ITER'));
    with (grdRichieste.medpCompCella(i,DBG_ITER,0) as TmeIWImageFile) do
    begin
      OnClick:=imgIterClick;
      Hint:=C018.LeggiNoteComplete;
      ImageFile.FileName:=IfThen(C018.NoteIndicate,fileImgElencoHighlight,fileImgElenco);
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    // dettaglio allegati
    if C018.EsisteGestioneAllegati then
    begin
      IWImg:=(grdRichieste.medpCompCella(i,DBG_ALLEG,0) as TmeIWImageFile);
      if C018.SetIconaAllegati(IWImg) then
        IWImg.OnClick:=imgAllegClick;
    end;
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    if (not SolaLettura) and (C018.TipoRichiesteSel <> [trAutorizzAuto]) then
    begin
      if WR000DM.Responsabile then
      begin
        if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        begin
          if (grdRichieste.medpValoreColonna(i,'ELABORATO') = 'N') and
             (grdRichieste.medpValoreColonna(i,'ID_REVOCA') = '') and
             (grdRichieste.medpValoreColonna(i,'AUTORIZZ_AUTOMATICA') <> 'S') and
             (StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),0) > 0) then
          begin
            // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
            if Parametri.CampiRiferimento.C90_W018AcquisizioneAuto <> 'S' then
            begin
              // v1: onclick
              C018.SetValoriAut(grdRichieste,i,0,0,1,chkAutorizzazioneClick);
              // v1.fine
            end
            else
            begin
              // v2.ini
              // versione con onasyncclick (non aggiorna la dbgrid dopo l'operazione di autorizzazione)
              C018.SetValoriAut(grdRichieste,i,0,0,1,nil);
              with (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox) do
              begin
                Name:=Format(ROW_ELEM_NAME_FMT,[CHKSI_NAME,i]);
                OnAsyncClick:=chkAutorizzazioneAsyncClick;
              end;
              if grdRichieste.medpCompCella(i,0,1) <> nil then
              begin
                with (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox) do
                begin
                  Name:=Format(ROW_ELEM_NAME_FMT,[CHKNO_NAME,i]);
                  OnAsyncClick:=chkAutorizzazioneAsyncClick;
                end;
              end;
              // v2.fine
            end;
            // GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine
          end
          else
          begin
            //Elimino checkbox se autorizzazione automatica o non abilitato ad autorizzare
            FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
          end;
        end;
        //Gestione pulsante di modifica causale
        x:=grdRichieste.medpIndexColonna('DBG_COMANDI');
        LivCaus:=StrToIntDef(grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE_LIV'),0);
        LivAut:=StrToIntDef(grdRichieste.medpValoreColonna(i,'LIVELLO_AUTORIZZAZIONE'),-1);
        C018.CodIter:=grdRichieste.medpValoreColonna(i,'COD_ITER');
        DatiModificabili:=C018.ModificaValori(LivAut) and (LivAut >= LivCaus);
        if grdRichieste.medpColonna('DBG_COMANDI').Visible then
        begin
          Op:=grdRichieste.medpValoreColonna(i,'OPERAZIONE');
          CausUtile:=grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE');
          if not ( DatiModificabili and
                  (grdRichieste.medpValoreColonna(i,'AUTORIZZAZIONE') = '') and
                  (((Op = 'I') and ((CausUtile <> '') or C018.GetDatoAutorizzatore('CAUSALE',IntToStr(LivAut)).Esiste)) or
                   ((Op = 'M') and ((CausUtile <> grdRichieste.medpValoreColonna(i,'CAUSALE_ORIG')) or C018.GetDatoAutorizzatore('CAUSALE',IntToStr(LivAut)).Esiste)))
                  ) then
          begin
            //Elimino il pulsante di modifica causale
            FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[x]);
          end
          else
          begin
            if FStileCella1 = '' then
            begin
              with (grdRichieste.medpCompGriglia[i].CompColonne[x] as TmeIWGrid) do
              begin
                FStileCella1:=Cell[0,0].Css;
                FStileCella2:=Cell[0,2].Css;
              end;
            end;
            //Associo l'evento onclick al pulsante di modifica causale
            with (grdRichieste.medpCompCella(i,x,0) as TmeIWImageFile) do
            begin
              Hint:=IfThen(grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE') = '','Imposta causale','Modifica causale');
              OnClick:=imgModificaCausClick;
            end;
            //Associo l'evento onclick al pulsante di annullamento modifica causale
            (grdRichieste.medpCompCella(i,x,1) as TmeIWImageFile).OnClick:=imgAnnullaCausClick;
            //Associo l'evento onclick al pulsante di conferma modifica causale
            (grdRichieste.medpCompCella(i,x,2) as TmeIWImageFile).OnClick:=imgConfermaCausClick;
            with (grdRichieste.medpCompGriglia[i].CompColonne[x] as TmeIWGrid) do
            begin
              Cell[0,1].Css:='invisibile';
              Cell[0,2].Css:='invisibile';
            end;
          end;
        end;
        //Gestione pulsante di dettaglio giornaliero
        x:=grdRichieste.medpIndexColonna('DETTAGLIO_GG');
        (grdRichieste.medpCompCella(i,x,0) as TmeIWImageFile).OnClick:=imgDettaglioGGClick;
      end
      else
      begin
        // visualizza immagine per cancellazione richiesta solo se non ancora autorizzata
        if (grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil) and (grdRichieste.medpValoreColonna(i,'REVOCABILE') <> 'CANC') then
          FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[0]);
        if grdRichieste.medpCompGriglia[i].CompColonne[0] <> nil then
        begin
          (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).OnClick:=imgCancellaRichiestaClick;
          HintDesc:=' del ' + grdRichieste.medpValoreColonna(i,'DATA_RICHIESTA') +
                    ' per l''' + IfThen(grdRichieste.medpValoreColonna(i,'VERSO')='E','entrata','uscita') +
                    ' del giorno ' + grdRichieste.medpValoreColonna(i,'DATA') +
                    ' alle ore ' + grdRichieste.medpValoreColonna(i,'ORA') +
                    ' con causale ' + grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE');
          (grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).Hint:=(grdRichieste.medpCompCella(i,0,0) as TmeIWImageFile).Hint + HintDesc;
        end;
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdRichiesteColumnClick(ASender: TObject; const AValue: string);
const
  FUNZIONE = 'grdRichiesteColumnClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  cdsT105.Locate('DBG_ROWID',AValue,[]);

  // nominativo
  if TuttiDipSelezionato then
  begin
    selAnagrafeW.SearchRecord('MATRICOLA',cdsT105.FieldByName('MATRICOLA').AsString,[srFromBeginning]);
    lnkDipendente.Caption:=FormattaInfoDipendenteCorrente;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdTimbratureAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i: Integer;
  HintDesc,Flag:String;
const
  FUNZIONE = 'grdTimbratureAfterCaricaCDS';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  if (not SolaLettura) then
  begin
    //Riga di inserimento
    if grdTimbrature.medpRigaInserimento then
    begin
      if FStileCella1 = '' then
      begin
        with (grdTimbrature.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
        begin
          FStileCella1:=Cell[0,0].Css;
          FStileCella2:=Cell[0,2].Css;
        end;
      end;
      HintDesc:=' per il ' + edtDataFiltro.Text;
      with (grdTimbrature.medpCompCella(0,0,0) as TmeIWImageFile) do
      begin
        OnClick:=imgInserisciClick; //Inserimento
        Hint:=Hint + HintDesc;
      end;
      with (grdTimbrature.medpCompCella(0,0,1) as TmeIWImageFile) do
      begin
        OnClick:=imgAnnullaClick;   //Annulla
        Hint:=Hint + HintDesc;
      end;
      with (grdTimbrature.medpCompCella(0,0,2) as TmeIWImageFile) do
      begin
        OnClick:=imgConfermaClick;  //Conferma
        Hint:=Hint + HintDesc;
      end;
      with (grdTimbrature.medpCompGriglia[0].CompColonne[0] as TmeIWGrid) do
      begin
        Cell[0,1].Css:='invisibile';
        Cell[0,2].Css:='invisibile';
      end;
    end;
    //Righe dati
    for i:=IfThen(grdTimbrature.medpRigaInserimento,1,0) to High(grdTimbrature.medpCompGriglia) do
    begin
      if grdTimbrature.medpCompGriglia[i].CompColonne[0] <> nil then
      begin
        HintDesc:=' di ' + grdTimbrature.medpValoreColonna(i,'DESC_VERSO') +
                  ' alle ' + grdTimbrature.medpValoreColonna(i,'ORA') +
                  ' del ' + edtDataFiltro.Text;

        // Associo l'evento OnClick alle Icone
        with (grdTimbrature.medpCompCella(i,0,0) as TmeIWImageFile) do
        begin
          OnClick:=imgCancellaClick; //Cancella
          Hint:=Hint + HintDesc;
        end;
        with (grdTimbrature.medpCompCella(i,0,1) as TmeIWImageFile) do
        begin
          OnClick:=imgModificaClick; //Modifica
          Hint:=Hint + HintDesc;
        end;
        with (grdTimbrature.medpCompCella(i,0,2) as TmeIWImageFile) do
        begin
          OnClick:=imgAnnullaClick;  //Annulla
        end;
        with (grdTimbrature.medpCompCella(i,0,3) as TmeIWImageFile) do
        begin
          OnClick:=imgConfermaClick; //Conferma
        end;

        with (grdTimbrature.medpCompGriglia[i].CompColonne[0] as TmeIWGrid) do
        begin
          if not FAbilCanc then
            //Non abilitato alla cancellazione
            Cell[0,0].Css:='invisibile'
          else
          begin
            Flag:=grdTimbrature.medpValoreColonna(i,'FLAG');
            if (Flag = 'I') and (Parametri.CancellaTimbrature = 'N') then
              Cell[0,0].Css:='invisibile'
            else if (Flag = 'O') and (Parametri.T100_CancTimbOrig = 'N') then
              Cell[0,0].Css:='invisibile';
          end;
          if (Parametri.T100_Ora <> 'S') and (Parametri.T100_Causale <> 'S') then
            //Non abilitato alla modifica
            Cell[0,1].Css:='invisibile';
          Cell[0,2].Css:='invisibile';
          Cell[0,3].Css:='invisibile';
        end;
      end;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdTimbratureColumnClick(ASender: TObject; const AValue: string);
const
  FUNZIONE = 'grdTimbratureColumnClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  inherited;
  cdst100.Locate('DBG_ROWID',AValue,[]);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.grdTimbratureRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var Campo:String;
    NumColonna:Integer;
begin
  inherited;
  grdTimbrature.medpRenderCellComp(ACell,ARow,AColumn);
  NumColonna:=(ACell.Grid as TmedpIWDBGrid).medpNumColonna(AColumn);
  Campo:=grdTimbrature.medpColonna(NumColonna).DataField;

  // assegnazione stili
  if (ARow > 0) and (Length(grdTimbrature.medpCompGriglia) > 0) then
    if (grdTimbrature.medpValoreColonna(ARow - 1,'FLAG') = 'I') and R180In(Campo,['ORA','DESC_VERSO']) then
      ACell.Css:=ACell.Css + ' font_grassetto';
end;

procedure TW018FRichiestaTimbrature.btnVisualizzaClick(Sender: TObject);
const
  FUNZIONE = 'btnVisualizzaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // controlla la data filtro
  if Trim(edtDataFiltro.Text) = '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Indicare la data per la visualizzazione delle timbrature.');
    ActiveControl:=edtDataFiltro;
    Exit;
  end;
  if not TryStrToDate(edtDataFiltro.Text,ParametriForm.DataFiltro) then
  begin
    GGetWebApplicationThreadVar.ShowMessage('Indicare una data valida!');
    ActiveControl:=edtDataFiltro;
    Exit;
  end;
  if ParametriForm.DataFiltro > Date then
  begin
    GGetWebApplicationThreadVar.ShowMessage('La data non può essere successiva al giorno corrente!');
    ActiveControl:=edtDataFiltro;
    Exit;
  end;
  // estrae le timbrature del giorno indicato
  GetModificaTimbrature;
  grdTimbrature.Caption:='Timbrature di ' + FormatDateTime('dddd d mmmm yyyy',ParametriForm.DataFiltro);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.W018AutorizzaTutto(Sender: TObject; var Ok: Boolean);
// Effettua l'autorizzazione positiva / negativa di tutte le richieste
// ancora da autorizzare visibili a video.
var
  Aut: String;
  ErrModCan: Boolean;
const
  FUNZIONE = 'btnVisualizzaClick';
  function FormattaDatiRichiesta: String;
  var
    Operazione,OperazioneStr,Verso,Causale,
    VersoOrig,CausaleOrig,NoteRich: String;
  begin
    with W018DM.selT105 do
    begin
      Operazione:=FieldByName('OPERAZIONE').AsString;
      Verso:=FieldByName('VERSO').AsString;
      VersoOrig:=FieldByName('VERSO_ORIG').AsString;
      Causale:=FieldByName('CAUSALE_UTILE').AsString;
      CausaleOrig:=FieldByName('CAUSALE_ORIG').AsString;
      NoteRich:=FieldByName('NOTE1').AsString;
      if Operazione = 'I' then
        OperazioneStr:='inserimento'
      else if Operazione = 'M' then
        OperazioneStr:='modifica'
      else if Operazione = 'C' then
        OperazioneStr:='cancellazione';
      // formatta la richiesta
      Result:=Format('Richiesta di %s effettuata da %s (%s) il %s',
                     [OperazioneStr,
                      FieldByName('NOMINATIVO').AsString,
                      FieldByName('MATRICOLA').AsString,
                      FieldByName('DATA_RICHIESTA').AsString]) + CRLF +
              Format('Data: %s Ora: %s Verso: %s Causale: %s',
                     [FieldByName('DATA').AsString,
                      FieldByName('ORA').AsString,
                      IfThen(Operazione = 'M',VersoOrig,Verso),
                      IfThen(Operazione = 'M',CausaleOrig,Causale)]) +
              IfThen(Verso <> VersoOrig,CRLF + 'Verso modificato: ' + Verso) +
              IfThen(Causale <> CausaleOrig,CRLF + 'Causale modificata: ' + Causale) +
              IfThen(NoteRich <> '',CRLF + 'Note dipendente: ' + NoteRich);
    end;
  end;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // inizializzazione variabili
  ErrModCan:=False;
  Aut:=IfThen(Sender = btnTuttiSi,C018SI,C018NO);

  // autorizzazione richieste
  with W018DM.selT105 do
  begin
    // niente refresh: autorizza solo ciò che è visualizzato nella pagina
    First;
    while not Eof do
    begin
      try
        if (FieldByName('ELABORATO').AsString = 'N') and
           (FieldByName('ID_REVOCA').IsNull) and
           (FieldByName('AUTORIZZ_AUTOMATICA').AsString <> 'S') and
           (FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger > 0) then
        begin
          try
            C018.CodIter:=FieldByName('COD_ITER').AsString;
            C018.Id:=FieldByName('ID').AsInteger;
            try
              C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Parametri.Operatore,'','',True);
              SessioneOracle.Commit;
              if C018.MessaggioOperazione <> '' then
                raise Exception.Create(C018.MessaggioOperazione);
            except
              on E: Exception do
              begin
                SessioneOracle.Commit;
                // messaggio bloccante
                MsgBox.MessageBox('Impostazione dell''autorizzazione fallita!' + CRLF +
                                  'Motivo: ' + E.Message + CRLF + CRLF +
                                  FormattaDatiRichiesta,ESCLAMA);
                Exit;
              end;
            end;
          except
            // errore probabilmente dovuto a record modificato / cancellato da altro utente
            on E:Exception do
            begin
              ErrModCan:=True;
            end;
          end;
        end;
      finally
        Next;
      end;
    end;
  end;
  if ErrModCan then
    MsgBox.MessageBox('Alcune richieste non sono state considerate per l''autorizzazione in quanto modificate nel frattempo o non più disponibili.',INFORMA);
  Ok:=True;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.chkAutorizzazioneClick(Sender: TObject);
// autorizzazione - v1
const
  FUNZIONE = 'chkAutorizzazioneClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  SetAutorizzazione(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;

// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
procedure TW018FRichiestaTimbrature.chkAutorizzazioneAsyncClick(Sender: TObject; EventParams: TStringList);
// autorizzazione - v2
var
  Nome, Indice, Target: String;
  IWC: TComponent;
const
  FUNZIONE = 'chkAutorizzazioneAsyncClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  SetAutorizzazione(Sender);

  // garantisce che solo uno dei check si/no sia impostato
  if (Sender as TmeIWCheckBox).Checked then
  begin
    // determina il nome del checkbox da TmeIWCheckBox
    Nome:=(Sender as TmeIWCheckBox).Name;
    Indice:=RightStr(Nome,ROW_ELEM_INDEX_LENGTH);
    Nome:=Copy(Nome,1,Length(Nome) - ROW_ELEM_INDEX_LENGTH);

    Target:=IfThen(Nome = CHKSI_NAME,CHKNO_NAME,CHKSI_NAME) + Indice;
    IWC:=FindComponent(Target);
    if Assigned(IWC) then
    begin
      (IWC as TmeIWCheckBox).Checked:=False;
    end;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;
// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine

procedure TW018FRichiestaTimbrature.SetAutorizzazione(Sender: TObject);
// conferma l'autorizzazione indicata sulla richiesta
begin
  FAutorizza.Rowid:=(Sender as TmeIWCheckBox).FriendlyName;
  FAutorizza.Checked:=(Sender as TmeIWCheckBox).Checked;
  FAutorizza.Caption:=(Sender as TmeIWCheckBox).Caption;

  // esegue l'autorizzazione della richiesta
  AutorizzazioneOK;

  if (Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S') and
     (GGetWebApplicationThreadVar.IsCallBack) then
  begin
    FAutorizzazioniDaConfermare:=True;
  end;
end;

procedure TW018FRichiestaTimbrature.chkNoteInsAsyncClick(Sender: TObject; EventParams: TStringList);
var
  StrTemp: String;
const
  FUNZIONE = 'chkNoteInsAsyncClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  if (Sender as TmeIWCheckBox).Checked then
    StrTemp:='FindElem("MEMNOTEINS").className = "textarea_note inser";' + CRLF +
             'FindElem("MEMNOTEINS").focus();'
  else
    StrTemp:='FindElem("MEMNOTEINS").className = "invisibile"';
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecute(StrTemp);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.AutorizzazioneOK;
// Importante: può essere richiamato anche da eventi async
var
  Aut,Resp: String;
  LivPrec,LivPost,NumScartate,NumRichieste:Integer;
  ErrMsg:String;
const
  FUNZIONE = 'AutorizzazioneOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Aut:='';
  Resp:='';
  // autorizzazione richiesta
  with W018DM.selT105 do
  begin
    // verifica presenza record
    //Refresh;
    if (not SearchRecord('ROWID',FAutorizza.RowId,[srFromBeginning])) or
       (not CheckRecord(FAutorizza.RowId)) then
    begin
      if GGetWebApplicationThreadVar.IsCallBack then
      begin
        GGetWebApplicationThreadVar.ShowMessage(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2));
      end
      else
      begin
        VisualizzaDipendenteCorrente;
        MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_W009_MSG_RICH_NON_DISPONIBILE2),INFORMA);
      end;
      Exit;
    end;
    // imposta i dati di autorizzazione
    Resp:=Parametri.Operatore;
    if FAutorizza.Checked and (FAutorizza.Caption = 'Si') then
      // autorizzazione SI
      Aut:=C018SI
    else if FAutorizza.Checked and (FAutorizza.Caption = 'No') then
      // autorizzazione NO
      Aut:=C018NO
    else if not FAutorizza.Checked then
      // autorizzazione non impostata
      Aut:='';
    // salva i dati di autorizzazione
    try
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      LivPrec:=FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger;
      LivPost:=C018.InsAutorizzazione(FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger,Aut,Resp,'','',True);
      (* Possibile soluzione per acquisire subito la richiesta appena autorizzata, senza richiesta esplicita da parte del responsabile.
      if (LivPrec < LivPost) and (C018.StatoRichiesta <> '') then
      begin
        A023MW.AcquisizioneRichiesteAuto(C018.Id.ToString,ErrMsg,NumScartate,NumRichieste);
      end;
      *)
      SessioneOracle.Commit;
      if C018.MessaggioOperazione <> '' then
        raise Exception.Create(C018.MessaggioOperazione);
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Impostazione dell''autorizzazione fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
      end;
    end;
    if not GGetWebApplicationThreadVar.IsCallBack then
    begin
      Refresh;
      grdRichieste.medpCaricaCDS;
    end;
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.btnRiepilogoOreClick(Sender: TObject);
var
  DataAttuale,DataSelez,DataInizio,DataFine: TDateTime;
const
  FUNZIONE = 'btnRiepilogoOreClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // stabilisce e imposta il periodo per i conteggi
  DataAttuale:=Date; //Trunc(R180SysDate(SessioneOracle));
  with W018DM.selT105 do
  begin
    if SearchRecord('ROWID',cdsT105.FieldByName('DBG_ROWID').AsString,[srFromBeginning]) then
      DataSelez:=FieldByName('DATA').AsDateTime
    else
      DataSelez:=IfThen(ParametriForm.DataFiltro = 0,DataAttuale,ParametriForm.DataFiltro);
  end;
  DataInizio:=R180InizioMese(DataSelez);
  DataFine:=R180FineMese(DataSelez);
  if DataFine > DataAttuale then
    DataFine:=DataAttuale;
  Log('Traccia',Format('Data selezionata: %s, inizio: %s, fine: %s',[DateToStr(DataSelez),DateToStr(DataInizio),DateToStr(DataFine)]));

  // crea frame per riepilogo ore
  W018FRiepilogoOreFM:=TW018FRiepilogoEccedenzeFM.Create(Self);
  Log('Traccia','Creazione frame di riepilogo ore completata');
  W018FRiepilogoOreFM.W018DM:=W018DM;
  W018FRiepilogoOreFM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W018FRiepilogoOreFM.DataSelez:=DataSelez;
  W018FRiepilogoOreFM.DataInizio:=DataInizio;
  W018FRiepilogoOreFM.DataFine:=DataFine;
  if not W018FRiepilogoOreFM.Visualizza then
  begin
    GGetWebApplicationThreadVar.ShowMessage(Format('Nessun riepilogo da visualizzare per il mese di %s %d!',
                               [R180NomeMese(R180Mese(DataInizio)),
                                R180Anno(DataInizio)]));
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.ini
procedure TW018FRichiestaTimbrature.btnImportaClick(Sender: TObject);
var
  ElencoRichieste,ErrMsg: String;
  AvvisoRiesegui: Boolean;
  Conta,NumScartate,NumRichieste: Integer;
const
  FUNZIONE = 'AutorizzazioneOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  FAutorizzazioniDaConfermare:=False;
  ElencoRichieste:='';
  Conta:=0;
  AvvisoRiesegui:=False;

  // determina l'elenco delle richieste attualmente presenti nel dataset
  W018DM.selT105.Refresh;
  if W018DM.selT105.RecordCount = 0 then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  W018DM.selT105.First;
  while not W018DM.selT105.Eof do
  begin
    if W018DM.selT105.FieldByName('ELABORATO').AsString = 'N' then
    begin
      if Conta >= ORACLE_MAX_IN_VALUES then
      begin
        AvvisoRiesegui:=True;
        Break;
      end;
      ElencoRichieste:=ElencoRichieste + W018DM.selT105.FieldByName('ID').AsString + ',';
      inc(Conta);
    end;
    W018DM.selT105.Next;
  end;
  ElencoRichieste:=Copy(ElencoRichieste,1,Length(ElencoRichieste) - 1);

  if ElencoRichieste = '' then
  begin
    MsgBox.MessageBox(A000TraduzioneStringhe(A000MSG_R013_NESSUNA_RICHIESTA_DA_IMPORTARE),INFORMA);
    Exit;
  end;

  //ImportaTimbratureAutorizzate(ElencoRichieste);
  A023MW.AcquisizioneRichiesteAuto(ElencoRichieste,ErrMsg,NumScartate,NumRichieste);
  if ErrMsg <> '' then
  begin
    MsgBox.AddMessage(ErrMsg);
  end;

  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;

  // richieste > del limite della 'in' di oracle
  if AvvisoRiesegui then
    MsgBox.AddMessage(A000TraduzioneStringhe(A000MSG_W018_MSG_RIESEGUI_IMPORTAZIONE));

  MsgBox.ShowMessages;
end;
// GENOVA_HGALLIERA - commessa 2013/006 - SVILUPPO 1.fine

function TW018FRichiestaTimbrature.ArrIndexFromCodice(const Tipo: String; const Codice: String): Integer;
// Determina l'indice della causale specificata nell'array indicato dal tipo
const
  FUNZIONE = 'ArrIndexFromCodice';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  Result:=-1;
  if Codice = '' then
    Exit;

  if Tipo = 'R' then //Rilevatori
    Result:=_ArrRilevatoriGetIndex(Codice,0,High(FArrRilevatori))
  else
    Result:=_ArrMotivazioniGetIndex(Codice,0,High(FArrMotivazioni));

  Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRichiestaTimbrature._ArrRilevatoriGetIndex(const Codice: String; p,r:Integer): Integer;
// Funzione di ricerca dicotomica per l'array dei rilevatori
var
  q, Res: Integer;
const
  FUNZIONE = '_ArrRilevatoriGetIndex';
begin
   Log('Traccia',FUNZIONE + ': inizio');
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < FArrRilevatori[q].Codice) then
      Res:=_ArrRilevatoriGetIndex(Codice,p,q-1);
    if (Codice > FArrRilevatori[q].Codice) then
      Res:=_ArrRilevatoriGetIndex(Codice,q+1,r);
    if (Codice = FArrRilevatori[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if FArrRilevatori[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
  Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRichiestaTimbrature._ArrMotivazioniGetIndex(const Codice: String; p,r:Integer): Integer;
// Funzione di ricerca dicotomica per l'array delle motivazioni
const
  FUNZIONE = '_ArrMotivazioniGetIndex';
var
  q, Res: Integer;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Res:=-1;

  if (p < r) then
  begin
    q:=(p+r) div 2;
    if (Codice < FArrMotivazioni[q].Codice) then
      Res:=_ArrMotivazioniGetIndex(Codice,p,q-1);
    if (Codice > FArrMotivazioni[q].Codice) then
      Res:=_ArrMotivazioniGetIndex(Codice,q+1,r);
    if (Codice = FArrMotivazioni[q].Codice) then
      Res:=q;
  end
  else if p = r then
  begin
    if FArrMotivazioni[p].Codice = Codice then
      Res:=p
  end
  else
    Res:=-1;
  Result:=Res;
  Log('Traccia',FUNZIONE + ': fine');
end;

// MONDOEDP - commessa MAN/02 SVILUPPO#112.ini
function TW018FRichiestaTimbrature.DecodificaFunzioneRilevatore(const PFunzione: String): String;
// decodifica la funzione del rilevatore in base al codice
begin
  if PFunzione = 'P' then
    Result:='presenza'
  else if PFunzione = 'M' then
    Result:='mensa'
  else if PFunzione = 'E' then
    Result:='presenza/mensa'
  else
    Result:=Format('[non valido: %s]',[PFunzione]);
end;
// MONDOEDP - commessa MAN/02 SVILUPPO#112.fine

procedure TW018FRichiestaTimbrature.GetDatiTabellari;
// Popolamento strutture dati di supporto per i dati tabellari
var i: Integer;
const
  FUNZIONE = 'GetDatiTabellari';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // array per le motivazioni della richiesta
  FMotivazioneDefault:=-1;
  R180SetVariable(W018DM.selT106,'TIPO','T');
  W018DM.selT106.Open;
  W018DM.selT106.First;
  SetLength(FArrMotivazioni,W018DM.selT106.RecordCount);
  i:=0;
  while not W018DM.selT106.Eof do
  begin
    FArrMotivazioni[i].Codice:=W018DM.selT106.FieldByName('CODICE').AsString;
    FArrMotivazioni[i].Descrizione:=W018DM.selT106.FieldByName('DESCRIZIONE').AsString;
    if W018DM.selT106.FieldByName('CODICE_DEFAULT').AsString = 'S' then
      FMotivazioneDefault:=i;
    W018DM.selT106.Next;
    i:=i + 1;
  end;
  W018DM.selT106.Close;

  // array per i rilevatori
  //WR000DM.selT361.Close;
  WR000DM.selT361.Filtered:=True;//FiltroDizionario
  WR000DM.selT361.Open;
  WR000DM.selT361.First;
  SetLength(FArrRilevatori,WR000DM.selT361.RecordCount + 1);
  i:=1;
  while not WR000DM.selT361.Eof do
  begin
    FArrRilevatori[i].Codice:=WR000DM.selT361.FieldByName('CODICE').AsString;
    FArrRilevatori[i].Descrizione:=Format('%s (%s)',[WR000DM.selT361.FieldByName('DESCRIZIONE').AsString,DecodificaFunzioneRilevatore(WR000DM.selT361.FieldByName('FUNZIONE').AsString)]);
    FArrRilevatori[i].Text:=Format('%-5s %s',[WR000DM.selT361.FieldByName('CODICE').AsString,WR000DM.selT361.FieldByName('DESCRIZIONE').AsString]);
    FArrRilevatori[i].Funzione:=WR000DM.selT361.FieldByName('FUNZIONE').AsString;

    WR000DM.selT361.Next;
    i:=i + 1;
  end;
  //WR000DM.selT361.Close;
  WR000DM.selT361.Filtered:=False;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.GetDipendentiDisponibili(Data:TDateTime);
const
  FUNZIONE = 'GetDipendentiDisponibili';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  ElementoTuttiDip:=WR000DM.Responsabile;
  inherited;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.VisualizzaDipendenteCorrente;
var
  FiltroAnag,LCod,LDesc: String;
  i:Integer;
  LCausRichWeb: Boolean;
const
  FUNZIONE = 'VisualizzaDipendenteCorrente';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  inherited;

  // salva parametri form
  ParametriForm.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;

  FAutorizza.Operazione:='';
  grdRichieste.medpBrowse:=True;

  // causali di presenza abilitate
  LCausRichWeb:=False;
  FLstCausFilt:=TStringList.Create;
  // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.ini
  FLstCausFilt.NameValueSeparator:=NAME_VALUE_SEPARATOR;
  // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.fine
  W018DM.selT275Abilitate.Close;
  W018DM.selT275Abilitate.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
  W018DM.selT275Abilitate.SetVariable('DATA',StrToDate(edtDataFiltro.Text));
  W018DM.selT275Abilitate.Open;
  W018DM.selT275Abilitate.First;
  while not W018DM.selT275Abilitate.Eof do
  begin
    LCod:=W018DM.selT275Abilitate.FieldByName('CODICE').AsString;
    LDesc:=Format('%-5s %s',[LCod,W018DM.selT275Abilitate.FieldByName('DESCRIZIONE').AsString]);
    FLstCausFilt.Values[LDesc]:=LCod;
    // causale richiesta web
    if W018DM.selT275Abilitate.FieldByName('TIPO_RICHIESTA_WEB').AsString <> 'N' then
      LCausRichWeb:=True;
    W018DM.selT275Abilitate.Next;
  end;
  // il pulsante "Riepilogo ore" è visibile solo se ci sono causali per cui è indicato il cumulo con le richieste web
  btnRiepilogoOre.Visible:=LCausRichWeb;

  // apre il dataset delle richieste di timbrature
  with W018DM.selT105 do
  begin
    // determina filtri
    FiltroAnag:=IfThen(TuttiDipSelezionato,
                       WR000DM.FiltroRicerca,
                       'and T030.PROGRESSIVO = ' + selAnagrafeW.FieldByName('PROGRESSIVO').AsString);
    Close;
    SetVariable('DATALAVORO',Parametri.DataLavoro);
    SetVariable('FILTRO_ANAG',FiltroAnag);
    SetVariable('FILTRO_PERIODO',C018.Periodo.Filtro);
    SetVariable('FILTRO_VISUALIZZAZIONE',C018.FiltroRichieste);
    SetVariable('FILTRO_STRUTTURA',C018.FiltroStruttura);
    SetVariable('FILTRO_ALLEGATI',C018.FiltroAllegati);
    R013Open(W018DM.selT105);
  end;

  grdRichieste.medpCreaCDS;
  grdRichieste.medpEliminaColonne;
  if WR000DM.Responsabile then
  begin
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
    grdRichieste.medpAggiungiColonna('DETTAGLIO_GG','Dett. gg','',nil);
    if C018.TipoRichiesteSel <> [trDaAutorizzare] then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('MATRICOLA','Matricola','',nil);
    grdRichieste.medpAggiungiColonna('NOMINATIVO','Nominativo','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_SI','Msg aut SI','',nil);
    grdRichieste.medpAggiungiColonna('MSGAUT_NO','Msg aut NO','',nil);
    grdRichieste.medpColonna('MSGAUT_SI').Visible:=False;
    grdRichieste.medpColonna('MSGAUT_NO').Visible:=False;
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if C018.EsisteAutorizzIntermedia or C018.Revocabile then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Data','',nil);
    grdRichieste.medpAggiungiColonna('DESC_OPERAZIONE','Operazione','',nil);
    grdRichieste.medpAggiungiColonna('VERSO','Verso','',nil);
    grdRichieste.medpAggiungiColonna('ORA','Ora','',nil);
    grdRichieste.medpAggiungiColonna('DBG_COMANDI','Mod.caus.','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_UTILE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('RILEVATORE_RICH','Rilevatore','',nil);
    grdRichieste.medpAggiungiColonna('VERSO_ORIG','Verso orig.','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_ORIG','Causale orig.','',nil);
    grdRichieste.medpAggiungiColonna('RILEVATORE_ORIG','Rilev. orig.','',nil);
    if Length(FArrMotivazioni) > 0 then
    begin
      grdRichieste.medpAggiungiColonna('D_MOTIVAZIONE','Motivazione','',nil);
    end;
    grdRichieste.medpColonna('MATRICOLA').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('NOMINATIVO').Visible:=TuttiDipSelezionato;
    grdRichieste.medpColonna('DBG_COMANDI').Visible:=(not SolaLettura) and
                                                     (C018.TipoRichiesteSel <> [trAutorizzAuto]) and
                                                     (Parametri.T100_Causale = 'S') and
                                                     (C018.IterModificaValori);
  end
  else
  begin
    grdRichieste.medpAggiungiColonna('DBG_COMANDI',IfThen(Parametri.AccessibilitaNonVedenti = 'S','Azioni'),'',nil);
    grdRichieste.medpAggiungiColonna('DATA_RICHIESTA','Richiesta','',nil);
    if C018.EsisteAutorizzIntermedia or C018.Revocabile then
      grdRichieste.medpAggiungiColonna('D_TIPO_RICHIESTA','Tipologia','',nil);
    grdRichieste.medpAggiungiColonna('DATA','Data','',nil);
    grdRichieste.medpAggiungiColonna('DESC_OPERAZIONE','Operazione','',nil);
    grdRichieste.medpAggiungiColonna('VERSO','Verso','',nil);
    grdRichieste.medpAggiungiColonna('ORA','Ora','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_UTILE','Causale','',nil);
    grdRichieste.medpAggiungiColonna('RILEVATORE_RICH','Rilevatore','',nil);
    grdRichieste.medpAggiungiColonna('VERSO_ORIG','Verso orig.','',nil);
    grdRichieste.medpAggiungiColonna('CAUSALE_ORIG','Causale orig.','',nil);
    grdRichieste.medpAggiungiColonna('RILEVATORE_ORIG','Rilev. orig.','',nil);
    if Length(FArrMotivazioni) > 0 then
    begin
      grdRichieste.medpAggiungiColonna('D_MOTIVAZIONE','Motivazione','',nil);
    end;
    grdRichieste.medpAggiungiColonna('D_AUTORIZZAZIONE','Autorizz.','',nil);
    if C018.TipoRichiesteSel <> [trDaAutorizzare] then
      grdRichieste.medpAggiungiColonna('D_ELABORATO','Elab.','',nil);
    grdRichieste.medpAggiungiColonna('D_RESPONSABILE','Responsabile','',nil);
    grdRichieste.medpAggiungiColonna(DBG_ITER,'Dettagli','',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
    if C018.EsisteGestioneAllegati then
      grdRichieste.medpAggiungiColonna(DBG_ALLEG,DBG_ALLEG_TITLE,'',nil);
    // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  end;
  grdRichieste.medpAggiungiColonna('FLAG','','',nil);
  grdRichieste.medpColonna('FLAG').Visible:=False;
  grdRichieste.medpAggiungiRowClick('DBG_ROWID',grdRichiesteColumnClick);
  grdRichieste.medpInizializzaCompGriglia;
  if (not SolaLettura) and (C018.TipoRichiesteSel <> [trAutorizzAuto]) then
  begin
    if WR000DM.Responsabile then
    begin
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_CHK,'','Si','','');
      grdRichieste.medpPreparaComponenteGenerico('R',0,1,DBG_CHK,'','No','','');
      if grdRichieste.medpColonna('DBG_COMANDI').Visible then
      begin
        i:=grdRichieste.medpIndexColonna('DBG_COMANDI');
        grdRichieste.medpPreparaComponenteGenerico('R',i,0,DBG_IMG,'','MODIFICA','Modifica','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',i,1,DBG_IMG,'','ANNULLA','Annulla','','S');
        grdRichieste.medpPreparaComponenteGenerico('R',i,2,DBG_IMG,'','CONFERMA','Conferma','Confermare la modifica della causale indicata dal dipendente?','D');
      end;
    end
    else
      grdRichieste.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Elimina la richiesta di modifica timbratura','Eliminare la richiesta selezionata?','',True);
  end;
  grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ITER),0,DBG_IMG,'','ELENCO','Dettaglio della richiesta','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
  if C018.EsisteGestioneAllegati then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna(DBG_ALLEG),0,DBG_IMG,'','ALLEGATI','Allegati alla richiesta','');
  // EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine
  if WR000DM.Responsabile then
    grdRichieste.medpPreparaComponenteGenerico('R',grdRichieste.medpIndexColonna('DETTAGLIO_GG'),0,DBG_IMG,'','DETTAGLIO','Cartellino interattivo del giorno','','',True);
  grdRichieste.medpCaricaCDS;

  // visualizzazione timbrature del giorno per il dipendente
  if not WR000DM.Responsabile then
  begin
    btnVisualizzaClick(nil);
  end
  else
  begin
    grdTimbrature.Visible:=False;
    JavascriptBottom.Add('document.getElementById("elencoTimbrature").className = "invisibile";');
  end;

  // svuota clientdataset per i conteggi di riepilogo
  W018DM.cdsRiepOre.Close;

  FAutorizzazioniDaConfermare:=False;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgModificaCausClick(Sender: TObject);
var
  FN: string;
const
  FUNZIONE = 'imgModificaCausClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  // modifica
  if FAutorizza.Operazione = 'M' then
  begin
    MsgBox.MessageBox('E'' necessario completare l''operazione di variazione in corso prima di procedere!',INFORMA);
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdRichiesteColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  FAutorizza.Operazione:='M';
  grdRichieste.medpBrowse:=False;
  TrasformaCompCausale(FN);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgAnnullaCausClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgAnnullaCausClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FAutorizza.Operazione:='';

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdRichiesteColumnClick(Sender,FN);

  grdRichieste.medpBrowse:=True;
  TrasformaCompCausale(FN);
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgConfermaCausClick(Sender: TObject);
var
  FN, CausMod: String;
  i, idxCaus: Integer;
const
  FUNZIONE = 'imgConfermaCausClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // applicazione modifiche
  if (FAutorizza.Operazione = 'M') then
  begin
    // se il record non esiste -> errore
    //W018DM.selT105.Refresh;
    if (not W018DM.selT105.SearchRecord('ROWID',FN,[srFromBeginning])) or
       (not CheckRecord(FN)) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Errore durante la modifica della causale:' + CRLF +
                        'la richiesta non è più disponibile!',INFORMA);
      Exit;
    end;

    i:=grdRichieste.medpRigaDiCompGriglia(FN);
    idxCaus:=grdRichieste.medpIndexColonna('CAUSALE_UTILE');

    grdRichiesteColumnClick(Sender,FN);

    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    CausMod:=Copy((grdRichieste.medpCompCella(i,idxCaus,0) as TmeIWComboBox).Text,1,5);
    FAutorizza.Operazione:='';
    grdRichieste.medpBrowse:=True;
    if CausMod = W018DM.selT105.FieldByName('CAUSALE_UTILE').AsString then
    begin
      TrasformaCompCausale(FN);
      Exit;
    end;

    // modifica della causale
    try
      with W018DM.selT105 do
      begin
        RefreshRecord;

        C018.CodIter:=FieldByName('COD_ITER').AsString;
        C018.Id:=FieldByName('ID').AsInteger;
        if CausMod = W018DM.selT105.FieldByName('CAUSALE').AsString then
          C018.DelDatoAutorizzatore('CAUSALE',FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger)
        else
          C018.SetDatoAutorizzatore('CAUSALE',CausMod,FieldByName('LIVELLO_AUTORIZZAZIONE').AsInteger);
        SessioneOracle.Commit;
        RefreshOptions:=[roAllFields];
        RefreshRecord;
        RefreshOptions:=[];//Si annullano le opzioni di refresh perchè danno problemi col RefreshRecord usato nella Delete
      end;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        VisualizzaDipendenteCorrente;
        GGetWebApplicationThreadVar.ShowMessage('Modifica della causale fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
        Exit;
      end;
    end;
    grdRichieste.medpAllineaRecordCDS;
    grdRichieste.medpCaricaCDS(FN);
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgCancellaRichiestaClick(Sender: TObject);
// Cancellazione di una richiesta
const
  FUNZIONE = 'imgCancellaRichiestaClick';
var
  D,D2:TDateTime;
  FN: String;
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  with W018DM.selT105 do
  begin
    //Refresh;
    if (not SearchRecord('ROWID',FN,[srFromBeginning])) or
       (not CheckRecord(FN)) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('Attenzione! La richiesta da cancellare non è più disponibile!',INFORMA);
      Exit;
    end;

    grdRichiesteColumnClick(Sender,FN);

    D:=FieldByName('DATA').AsDateTime;
    try
      //elimina la richiesta
      C018.CodIter:=FieldByName('COD_ITER').AsString;
      C018.Id:=FieldByName('ID').AsInteger;
      C018.EliminaIter;
      SessioneOracle.Commit;
      Refresh;
    except
      on E: Exception do
      begin
        SessioneOracle.Commit;
        GGetWebApplicationThreadVar.ShowMessage('Cancellazione della richiesta fallita!' + CRLF +
                                   'Motivo: ' + E.Message);
      end;
    end;
  end;
  grdRichieste.medpCaricaCDS;
  if TryStrToDate(edtDataFiltro.Text,D2) and (D = D2) then
    GetModificaTimbrature;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.TrasformaCompCausale(const FN:String);
// Trasforma la colonna "Causale" della riga indicata da text a control e viceversa
// per la grid grdRichieste
const
  FUNZIONE = 'TrasformaCompCausale';
var
  DaTestoAControlli: Boolean;
  i,x,idxCaus: Integer;
  LIWCmb: TmeIWComboBox;
  LCausale: String;
  LDesc: String;
begin
  Log('Traccia',FUNZIONE + ': inizio');

  i:=grdRichieste.medpRigaDiCompGriglia(FN);
  idxCaus:=grdRichieste.medpIndexColonna('CAUSALE_UTILE');
  DaTestoAControlli:=grdRichieste.medpCompGriglia[i].CompColonne[idxCaus] = nil;
  // abilita / disabilita possibilità di autorizzare
  (grdRichieste.medpCompCella(i,0,0) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;
  (grdRichieste.medpCompCella(i,0,1) as TmeIWCheckBox).Enabled:=not DaTestoAControlli;

  // Gestione icone comandi
  with (grdRichieste.medpCompGriglia[i].CompColonne[idxCaus - 1] as TmeIWGrid) do
  begin
    Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',FStileCella1);
    Cell[0,1].Css:=IfThen(DaTestoAControlli,FStileCella1,'invisibile');
    Cell[0,2].Css:=IfThen(DaTestoAControlli,FStileCella2,'invisibile');
  end;

  if DaTestoAControlli then
  begin
    LCausale:=grdRichieste.medpValoreColonna(i,'CAUSALE_UTILE');

    // combobox delle causali
    grdRichieste.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','','','','S');
    grdRichieste.medpCreaComponenteGenerico(i,idxCaus,grdRichieste.Componenti);
    LIWCmb:=(grdRichieste.medpCompCella(i,idxCaus,0) as TmeIWComboBox);
    LIWCmb.ItemsHaveValues:=True;
    // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.ini
    LIWCmb.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
    // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.fine
    LIWCmb.Items.BeginUpdate;
    LIWCmb.Items.Add('');
    LIWCmb.Items.AddStrings(FLstCausFilt);
    // aggiunge causale alla lista se non contemplata fra quelle abilitate
    if (LCausale <> '') and
       (R180IndexOf(LIWCmb.Items,LCausale,5) < 0) and
       (not VarIsNull(W018DM.selT275Lookup.Lookup('CODICE',LCausale,'CODICE'))) then
    begin
      LDesc:=Format('%-5s %s',[LCausale,VarToStr(W018DM.selT275Lookup.Lookup('CODICE',LCausale,'DESCRIZIONE'))]);
      LIWCmb.Items.Add(Format('%s=%s',[LDesc,LCausale]));
    end;
    LIWCmb.Items.EndUpdate;
    LIWCmb.ItemIndex:=Max(0,R180IndexOf(LIWCmb.Items,LCausale,5));
  end
  else
  begin
    // trasforma componenti in testo
    FreeAndNil(grdRichieste.medpCompGriglia[i].CompColonne[idxCaus]);
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.GetModificaTimbrature;
const
  FUNZIONE = 'GetModificaTimbrature';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  FRichiesta.Operazione:='';
  grdTimbrature.medpBrowse:=True;

  AllineaTimbrature;

  // apre dataset di supporto per timbrature
  W018DM.selT100ModifTimb.Close;
  W018DM.selT100ModifTimb.SetVariable('PROGRESSIVO',selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger);
  W018DM.selT100ModifTimb.SetVariable('DATA',StrToDate(edtDataFiltro.Text));
  W018DM.selT100ModifTimb.Open;

  grdTimbrature.medpCreaCDS;
  grdTimbrature.medpEliminaColonne;
  grdTimbrature.medpAggiungiColonna('DBG_COMANDI',IfThen(Parametri.AccessibilitaNonVedenti = 'S','Azioni'),'DBG_ROWID',grdTimbratureColumnClick);
  grdTimbrature.medpAggiungiColonna('DESC_VERSO','Verso','',nil);
  grdTimbrature.medpAggiungiColonna('ORA','Ora','',nil);
  grdTimbrature.medpAggiungiColonna('DESC_CAUSALE','Causale','',nil);
  grdTimbrature.medpAggiungiColonna('RILEVATORE','Rilevatore','',nil);
  grdTimbrature.medpAggiungiColonna('MOTIVAZIONE','Motivazione','',nil);
  grdTimbrature.medpAggiungiColonna('NOTE','Note','',nil);
  grdTimbrature.medpColonna('MOTIVAZIONE').Visible:=Length(FArrMotivazioni) > 0;
  grdTimbrature.medpColonna('NOTE').Visible:=False;
  grdTimbrature.medpAggiungiRowClick('DBG_ROWID',grdTimbratureColumnClick);

  grdTimbrature.medpInizializzaCompGriglia;
  if not SolaLettura then
  begin
    if FAbilCanc or (Parametri.T100_Ora = 'S') or (Parametri.T100_Causale = 'S') then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('R',0,0,DBG_IMG,'','CANCELLA','Cancella la timbratura','Confermare la richiesta di eliminazione della timbratura corrente?','S');
      grdTimbrature.medpPreparaComponenteGenerico('R',0,1,DBG_IMG,'','MODIFICA','Modifica la timbratura','','D');
      grdTimbrature.medpPreparaComponenteGenerico('R',0,2,DBG_IMG,'','ANNULLA','Annulla la richiesta di modifica della timbratura','','S');
      grdTimbrature.medpPreparaComponenteGenerico('R',0,3,DBG_IMG,'','CONFERMA','Conferma la richiesta di modifica della timbratura','Confermare la richiesta di modifica della timbratura corrente?','D');
    end;
    if FAbilIns then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('I',0,0,DBG_IMG,'','INSERISCI','Inserisce la richiesta di una nuova timbratura','','S');
      grdTimbrature.medpPreparaComponenteGenerico('I',0,1,DBG_IMG,'','ANNULLA','Annulla la richiesta di inserimento di una nuova timbratura','','S');
      grdTimbrature.medpPreparaComponenteGenerico('I',0,2,DBG_IMG,'','CONFERMA','Conferma la richiesta di inserimento di una nuova timbratura','Confermare la richiesta di inserimento della timbratura?','D');
    end;
  end;
  grdTimbrature.medpCaricaCDS;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.AllineaTimbrature;
var A023FAllTimbW018:TA023FAllTimbMW;
    Data:TDateTime;
begin
  Data:=StrToDate(edtDataFiltro.Text);
  // crea oggetto per allineamento timbrature uguali
  A023FAllTimbW018:=TA023FAllTimbMW.Create(nil);
  try
    try
      // allineamento timbrature
      A023FAllTimbW018.Q100.Session:=SessioneOracle;
      A023FAllTimbW018.Q100Upd.Session:=SessioneOracle;
      A023FAllTimbW018.Allinea(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,Data,Data);
    except
      on E:Exception do
        Log('Errore','Allineamento timbrature uguali: ' + E.ClassName + '/' + E.Message);
    end;
  finally
    try FreeAndNil(A023FAllTimbW018); except end;
  end;
end;

procedure TW018FRichiestaTimbrature.imgCancellaClick(Sender: TObject);
var
  i: Integer;
  FN: String;
const
  FUNZIONE = 'imgCancellaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if FRichiesta.Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare l''operazione in corso prima di procedere!');
    Exit;
  end;

  grdTimbratureColumnClick(Sender,FN);

  // verifica blocco riepiloghi
  if WR000DM.selDatiBloccati.DatoBloccato(selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger,R180InizioMese(ParametriForm.DataFiltro),'T100') then
  begin
    MsgBox.MessageBox('Inserimento richiesta annullato: blocco attivo!',INFORMA,'Riepiloghi bloccati');
    Exit;
  end;

  // se il record non esiste -> errore
  W018DM.selT100ModifTimb.Refresh;
  if not W018DM.selT100ModifTimb.SearchRecord('ROWID',FN,[srFromBeginning]) then
  begin
    GetModificaTimbrature;
    MsgBox.MessageBox('Errore durante l''inserimento della richiesta:' + CRLF +
                      'la timbratura da cancellare non è più disponibile!',INFORMA);
    Exit;
  end;

  // eliminazione record
  i:=grdTimbrature.medpRigaDiCompGriglia(FN);
  FRichiesta.Operazione:='C';
  FRichiesta.Data:=ParametriForm.DataFiltro;
  FRichiesta.Ora:=grdTimbrature.medpValoreColonna(i,'ORA');
  EseguiRichiesta;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgInserisciClick(Sender: TObject);
// Crea i controlli per la riga di inserimento
var
  x: Integer;
  FN: string;
  LIWCmb: TmeIWComboBox;
const
  FUNZIONE = 'imgInserisciClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  if FRichiesta.Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare' + CRLF +
                               'l''operazione in corso prima di procedere!');
    Exit;
  end;
  grdTimbratureColumnClick(Sender,FN);

  FRichiesta.Operazione:='I';
  grdTimbrature.medpBrowse:=False;
  with (grdTimbrature.medpCompgriglia[0].CompColonne[0] as TmeIWGrid) do
  begin
    Cell[0,0].Css:='invisibile';
    Cell[0,1].Css:=FStileCella1;
    Cell[0,2].Css:=FStileCella2;
  end;

  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'20','Entrata,Uscita','Verso della timbratura','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,1,grdTimbrature.Componenti);
  (grdTimbrature.medpCompCella(0,1,0) as TmeTIWAdvRadioGroup).ItemIndex:=0;

  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_EDT,'ORA2','','Ora della timbratura in formato hh mm','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,2,grdTimbrature.Componenti);

  if Parametri.T100_Causale = 'S' then
  begin
    grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','','Selezione della causale per la timbratura','','S');
    grdTimbrature.medpCreaComponenteGenerico(0,3,grdTimbrature.Componenti);
    LIWCmb:=(grdTimbrature.medpCompCella(0,3,0) as TmeIWComboBox);
    LIWCmb.ItemsHaveValues:=True;
    // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.ini
    LIWCmb.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
    // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.fine
    LIWCmb.Items.BeginUpdate;
    LIWCmb.Items.Add('');
    LIWCmb.Items.AddStrings(FLstCausFilt);
    LIWCmb.Items.EndUpdate;
    LIWCmb.ItemIndex:=0;
    LIWCmb.OnChange:=cmbCausaleChange;
  end;

  // rilevatore
  if Parametri.T100_Rilevatore = 'S' then
  begin
    grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'30','','Selezione del rilevatore per la timbratura','','S');
    grdTimbrature.medpCreaComponenteGenerico(0,grdTimbrature.medpIndexColonna('RILEVATORE'),grdTimbrature.Componenti);
    with (grdTimbrature.medpCompCella(0,'RILEVATORE',0) as TmeIWComboBox) do
    begin
      ItemsHaveValues:=True;
      Items.BeginUpdate;
      Items.Add('');
      for x:=1 to Length(FArrRilevatori) - 1 do
        Items.Values[FArrRilevatori[x].Text]:=FArrRilevatori[x].Codice;
      Items.EndUpdate;
      ItemIndex:=0;
    end;
  end;

  // motivazione
  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'40','','Selezione della motivazione per la timbratura','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,grdTimbrature.medpIndexColonna('MOTIVAZIONE'),grdTimbrature.Componenti);
  with (grdTimbrature.medpCompCella(0,'MOTIVAZIONE',0) as TmeIWComboBox) do
  begin
    NoSelectionText:='';
    RequireSelection:=True;
    ItemsHaveValues:=True;
    Items.BeginUpdate;
    for x:=0 to Length(FArrMotivazioni) - 1 do
      Items.Values[FArrMotivazioni[x].Descrizione]:=FArrMotivazioni[x].Codice;
    Items.EndUpdate;
    ItemIndex:=FMotivazioneDefault;
  end;

  grdTimbrature.medpColonna('NOTE').Visible:=True;
  grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','Inserimento delle note per la timbratura','','S');
  grdTimbrature.medpCreaComponenteGenerico(0,grdTimbrature.medpIndexColonna('NOTE'),grdTimbrature.Componenti);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgModificaClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgModificaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  if FRichiesta.Operazione <> '' then
  begin
    GGetWebApplicationThreadVar.ShowMessage('E'' necessario completare oppure annullare' + CRLF +
                               'l''operazione in corso prima di procedere!');
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdTimbratureColumnClick(Sender,FN);

  // porta la riga in modifica: trasforma i componenti
  FRichiesta.Operazione:=IfThen(FN = '*','I','M');
  grdTimbrature.medpBrowse:=False;
  TrasformaComponenti(FN,True);

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgConfermaClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgConfermaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  // controlli per modifica
  if (FRichiesta.Operazione = 'M') then
  begin
    // nessuna operazione da effettuare se non sono state apportate modifiche alla riga
    FMemoText:='';
    if not ModificheRiga(FN) then
    begin
      FRichiesta.Operazione:='';
      grdTimbrature.medpColonna('NOTE').Visible:=False;
      grdTimbrature.medpCaricaCDS(FN);
      grdTimbrature.medpBrowse:=True;
      MsgBox.MessageBox('I dati della timbratura non sono stati modificati: richiesta non inserita!',INFORMA);
      Exit;
    end;

    // se il record non esiste -> errore
    W018DM.selT100ModifTimb.Refresh;
    if not W018DM.selT100ModifTimb.SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      FRichiesta.Operazione:='';
      GetModificaTimbrature;
      MsgBox.MessageBox('Errore durante l''inserimento della richiesta:' + CRLF +
                        'la timbratura da modificare non è più disponibile!',INFORMA);
      Exit;
    end;
  end;

  // effettua controlli bloccanti
  if not ControlliOK(FN) then
    Exit;

  EseguiRichiesta;

  grdTimbrature.medpColonna('NOTE').Visible:=False;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgAnnullaClick(Sender: TObject);
const
  FUNZIONE = 'imgAnnullaClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  VisualizzaDipendenteCorrente;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.imgIterClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgIterClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdTimbrature.medpStato = msBrowse then
    grdRichiesteColumnClick(Sender,FN);
  with W018DM.selT105 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('La richiesta selezionata non è più disponibile!',INFORMA);
      Exit;
    end;
  end;
  VisualizzaDettagli(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;

// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.ini
procedure TW018FRichiestaTimbrature.imgAllegClick(Sender: TObject);
var
  FN: String;
const
  FUNZIONE = 'imgAllegClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  if grdTimbrature.medpStato = msBrowse then
    grdRichiesteColumnClick(Sender,FN);
  with W018DM.selT105 do
  begin
    if not SearchRecord('ROWID',FN,[srFromBeginning]) then
    begin
      VisualizzaDipendenteCorrente;
      MsgBox.MessageBox('La richiesta selezionata non è più disponibile!',INFORMA);
      Exit;
    end;
  end;
  VisualizzaAllegati(Sender);
  Log('Traccia',FUNZIONE + ': fine');
end;
// EMPOLI_ASL11 - commessa 2014/054 SVILUPPO#2.fine

procedure TW018FRichiestaTimbrature.imgDettaglioGGClick(Sender: TObject);
var
  i: Integer;
  FN: String;
const
  FUNZIONE = 'imgDettaglioGGClick';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  FN:=(Sender as TmeIWImageFile).FriendlyName;

  grdRichiesteColumnClick(Sender,FN);
  i:=grdRichieste.medpRigaDiCompGriglia(FN);

  W005FCartellinoFM:=TW005FCartellinoFM.Create(Self);
  W005FCartellinoFM.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  W005FCartellinoFM.Dal:=StrToDate(grdRichieste.medpValoreColonna(i,'DATA'));
  W005FCartellinoFM.Al:=W005FCartellinoFM.Dal;
  W005FCartellinoFM.Visualizza;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.cmbCausaleChange(Sender: TObject);
const
  FUNZIONE = 'cmbCausaleChange';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  AggiornaTitoloNote(Trim(Copy((Sender as TmeIWComboBox).Text,1,5)));
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.AggiornaTitoloNote(Causale:String);
const
  FUNZIONE = 'AggiornaTitoloNote';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  grdTimbrature.medpColonna('NOTE').Title.Text:='Note';
  if W018DM.selT106C.RecordCount > 0 then
  begin
    W018DM.selT106C.First;
    while not W018DM.selT106C.Eof do
    begin
      if R180CercaParolaIntera(Causale,W018DM.selT106C.FieldByName('CAUSALI').AsString,',') > 0 then
      begin
        grdTimbrature.medpColonna('NOTE').Title.Text:=W018DM.selT106C.FieldByName('DESCRIZIONE').AsString;
        Break;
      end;
      W018DM.selT106C.Next;
    end;
  end;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.TrasformaComponenti(FN:String; DaTestoAControlli:Boolean);
// Trasforma i componenti della riga indicata da text a control e viceversa
// per la grid grdTimbrature
var
  i,x: Integer;
  LIWCmb: TmeIWComboBox;
  LCausale: String;
  LDesc: String;
const
  FUNZIONE = 'TrasformaComponenti';
begin
  // pre: not SolaLettura
  Log('Traccia',FUNZIONE + ': inizio');
  i:=grdTimbrature.medpRigaDiCompGriglia(FN);

  if FRichiesta.Operazione = 'I' then
  begin
    with (grdTimbrature.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',FStileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,FStileCella1,'invisibile');
      Cell[0,2].Css:=IfThen(DaTestoAControlli,FStileCella2,'invisibile');
    end;
  end
  else
  begin
    with (grdTimbrature.medpCompgriglia[i].CompColonne[0] as TmeIWGrid) do
    begin
      Cell[0,0].Css:=IfThen(DaTestoAControlli,'invisibile',FStileCella1);
      Cell[0,1].Css:=IfThen(DaTestoAControlli,'invisibile',FStileCella2);
      Cell[0,2].Css:=IfThen(DaTestoAControlli,FStileCella1,'invisibile');
      Cell[0,3].Css:=IfThen(DaTestoAControlli,FStileCella2,'invisibile');
    end;
  end;

  if DaTestoAControlli then
  begin
    // verso
    if (not SolaLettura) and (Parametri.T100_Ora = 'S') then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_RGP,'20','Entrata,Uscita','Verso della timbratura','','S');
      grdTimbrature.medpCreaComponenteGenerico(i,1,grdTimbrature.Componenti);
      (grdTimbrature.medpCompCella(i,1,0) as TmeTIWAdvRadioGroup).ItemIndex:=IfThen(grdTimbrature.medpValoreColonna(i,'VERSO') = 'E',0,1);
    end;
    // causale
    if (not SolaLettura) and (Parametri.T100_Causale = 'S') then
    begin
      LCausale:=grdTimbrature.medpValoreColonna(i,'CAUSALE');

      grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'50','','Selezione della causale per la timbratura','','S');
      grdTimbrature.medpCreaComponenteGenerico(i,3,grdTimbrature.Componenti);
      LIWCmb:=(grdTimbrature.medpCompCella(i,3,0) as TmeIWComboBox);
      LIWCmb.ItemsHaveValues:=True;
      // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.ini
      LIWCmb.Items.NameValueSeparator:=NAME_VALUE_SEPARATOR;
      // BugFix Chiamata: 123721 Utente: FIRENZE_COMUNE.fine
      LIWCmb.Items.BeginUpdate;
      LIWCmb.Items.Add('');
      LIWCmb.Items.AddStrings(FLstCausFilt);
      // aggiunge causale alla lista se non contemplata fra quelle abilitate
      if (LCausale <> '') and
         (R180IndexOf(LIWCmb.Items,LCausale,5) < 0) and
         (not VarIsNull(W018DM.selT275Lookup.Lookup('CODICE',LCausale,'CODICE'))) then
      begin
        LDesc:=Format('%-5s %s',[LCausale,VarToStr(W018DM.selT275Lookup.Lookup('CODICE',LCausale,'DESCRIZIONE'))]);
        LIWCmb.Items.Add(Format('%s=%s',[LDesc,LCausale]));
      end;
      LIWCmb.Items.EndUpdate;
      LIWCmb.ItemIndex:=Max(0,R180IndexOf(LIWCmb.Items,LCausale,5));
      LIWCmb.OnChange:=cmbCausaleChange;

      AggiornaTitoloNote(grdTimbrature.medpValoreColonna(i,'CAUSALE'));
    end;
    // motivazione
    if (not SolaLettura) and
       (Length(FArrMotivazioni) > 0) and
       ((Parametri.T100_Ora = 'S') or (Parametri.T100_Causale = 'S')) then
    begin
      grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_CMB_COUR,'40','','Selezione della motivazione per la timbratura','','S');
      grdTimbrature.medpCreaComponenteGenerico(i,grdTimbrature.medpIndexColonna('MOTIVAZIONE'),grdTimbrature.Componenti);
      with (grdTimbrature.medpCompCella(i,'MOTIVAZIONE',0) as TmeIWComboBox) do
      begin
        NoSelectionText:='';
        RequireSelection:=True;
        ItemsHaveValues:=True;
        Items.BeginUpdate;
        for x:=0 to Length(FArrMotivazioni) - 1 do
          Items.Values[FArrMotivazioni[x].Descrizione]:=FArrMotivazioni[x].Codice;
        Items.EndUpdate;
        ItemIndex:=FMotivazioneDefault;
      end;
    end;

    grdTimbrature.medpColonna('NOTE').Visible:=True;
    grdTimbrature.medpPreparaComponenteGenerico('C',0,0,DBG_MEMO,'20','','Inserimento delle note per la timbratura','','S');
    grdTimbrature.medpCreaComponenteGenerico(i,grdTimbrature.medpIndexColonna('NOTE'),grdTimbrature.Componenti);
  end
  else
  begin
    // verso
    if (not SolaLettura) and (Parametri.T100_Ora = 'S') then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[1]);
    end;

    //ora - solo inserimento
    if FRichiesta.Operazione = 'I' then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[2]);
    end;

    // causale
    if (not SolaLettura) and (Parametri.T100_Causale = 'S') then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[3]);
    end;

    //rilevatore - solo inserimento e se colonna presente
    if FRichiesta.Operazione = 'I' then
      if Parametri.T100_Rilevatore = 'S' then
      begin
        FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[grdTimbrature.medpIndexColonna('RILEVATORE')]);
      end;

    // motivazione
    if (not SolaLettura) and
       (Length(FArrMotivazioni) > 0) and
       ((Parametri.T100_Ora = 'S') or (Parametri.T100_Causale = 'S')) then
    begin
      FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[grdTimbrature.medpIndexColonna('MOTIVAZIONE')]);
    end;

    // note
    FreeAndNil(grdTimbrature.medpCompgriglia[i].CompColonne[grdTimbrature.medpIndexColonna('NOTE')]);
  end;
  Log('Traccia',FUNZIONE + ': fine');
end;

function TW018FRichiestaTimbrature.ModificheRiga(FN:String): Boolean;
// Restituisce true se sono state effettuate modifiche alla timbratura, false altrimenti
var
  i: Integer;
  NewVerso,NewCausale: String;
const
  FUNZIONE = 'ModificheRiga';
begin
  Log('Traccia',FUNZIONE + ': inizio');
  Result:=False;
  i:=grdTimbrature.medpRigaDiCompGriglia(FN);

  // se verso abilitato verifica modifica
  FRichiesta.VersoModificato:=False;
  if grdTimbrature.medpCompGriglia[i].CompColonne[1] <> nil then
  begin
    NewVerso:=IfThen((grdTimbrature.medpCompCella(i,1,0) as TmeTIWAdvRadioGroup).ItemIndex = 0,'E','U');
    FRichiesta.VersoModificato:=(grdTimbrature.medpValoreColonna(i,'VERSO') <> NewVerso);
    Result:=Result or (grdTimbrature.medpValoreColonna(i,'VERSO') <> NewVerso);
  end;

  // se causale abilitata verifica modifica
  if grdTimbrature.medpCompGriglia[i].CompColonne[3] <> nil then
  begin
    NewCausale:=Copy((grdTimbrature.medpCompCella(i,3,0) as TmeIWComboBox).Text,1,5);
    Result:=Result or (grdTimbrature.medpValoreColonna(i,'CAUSALE') <> NewCausale);
  end;

  FMemoText:=(grdTimbrature.medpCompCella(i,'NOTE',0) as TmeIWMemo).Text;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.OnTabClosing(var AllowClose: Boolean; var Conferma: String);
begin
  // conferma nel caso di autorizzazioni pendenti da confermare
  if (Parametri.CampiRiferimento.C90_W018AcquisizioneAuto = 'S') and
     (FAutorizzazioniDaConfermare) then
  begin
    Conferma:='Attenzione!'#13#10 +
              'Sono presenti autorizzazioni da confermare.'#13#10 +
              'Le modifiche non verrano perse, ma sarà necessario confermarle la volta successiva.'#13#10 +
              'Uscire comunque?';
  end;
end;

function TW018FRichiestaTimbrature.ControlliOK(FN:String): Boolean;
// Effettua i controlli e imposta i dati per l'aggiornamento
var
  i,c,idx: Integer;
  IWC: TmeIWComboBox;
  IWEdt: TmeIWEdit;
const
  FUNZIONE = 'ControlliOK';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  Result:=False;
  i:=grdTimbrature.medpRigaDiCompGriglia(FN);

  // imposta variabili per inserimento / aggiornamento
  if FRichiesta.Operazione = 'I' then
  begin
    // data timbratura
    if Trim(edtDataFiltro.Text) = '' then
    begin
      MsgBox.MessageBox('Indicare la data della timbratura!',INFORMA);
      ActiveControl:=edtDataFiltro;
      Exit;
    end;
    if not TryStrToDate(edtDataFiltro.Text,FRichiesta.Data) then
    begin
      MsgBox.MessageBox('Indicare una data valida!',INFORMA);
      ActiveControl:=edtDataFiltro;
      Exit;
    end;
    if FRichiesta.Data > Date then
    begin
      MsgBox.MessageBox('La data non può essere successiva al giorno corrente!',INFORMA);
      ActiveControl:=edtDataFiltro;
      Exit;
    end;
    if (Parametri.WEBIterTimbGGPrec >= 0) and ((Date - FRichiesta.Data) > Parametri.WEBIterTimbGGPrec) then
    begin
      MsgBox.MessageBox(Format('La data non può essere antecedente più di %d giorni!',[Parametri.WEBIterTimbGGPrec]),INFORMA);
      ActiveControl:=edtDataFiltro;
      Exit;
    end;

    // ora timbratura
    IWEdt:=(grdTimbrature.medpCompCella(i,'ORA',0) as TmeIWEdit);
    if IWEdt.Text = '' then
    begin
      MsgBox.MessageBox('Indicare l''ora della timbratura!',INFORMA);
      ActiveControl:=IWEdt;
      Exit;
    end;
    try
      R180OraValidate(IWEdt.Text);
      FRichiesta.Ora:=IWEdt.Text;
    except
      on E:Exception do
      begin
        MsgBox.MessageBox(E.Message,INFORMA);
        ActiveControl:=IWEdt;
        Exit;
      end;
    end;
  end
  else
  begin
    // modifica
    FRichiesta.Data:=ParametriForm.DataFiltro;
    FRichiesta.Ora:=grdTimbrature.medpValoreColonna(i,'ORA');
  end;

  // verso
  c:=grdTimbrature.medpIndexColonna('DESC_VERSO');
  if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
    FRichiesta.Verso:=IfThen((grdTimbrature.medpCompCella(i,1,0) as TmeTIWAdvRadioGroup).ItemIndex = 0,'E','U')
  else
    FRichiesta.Verso:=grdTimbrature.medpValoreColonna(i,'VERSO');

  // causale
  c:=grdTimbrature.medpIndexColonna('DESC_CAUSALE');
  if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
  begin
    IWC:=(grdTimbrature.medpCompCella(i,c,0) as TmeIWComboBox);
    FRichiesta.Causale:=IWC.Items.ValueFromIndex[IWC.ItemIndex];
  end
  else
    FRichiesta.Causale:=grdTimbrature.medpValoreColonna(i,'CAUSALE');

  //if Parametri.T100_Rilevatore = 'S' then
  begin
    // rilevatore
    c:=grdTimbrature.medpIndexColonna('RILEVATORE');
    if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
    begin
      IWC:=(grdTimbrature.medpCompCella(i,c,0) as TmeIWComboBox);
      FRichiesta.Rilevatore:=IWC.Items.ValueFromIndex[IWC.ItemIndex];
    end
    else
      FRichiesta.Rilevatore:=grdTimbrature.medpValoreColonna(i,'RILEVATORE');

    // estrae la funzione del rilevatore (presenza / mensa)
    if FRichiesta.Rilevatore = '' then
    begin
      // rilevatore non indicato -> presenza
      FRichiesta.FunzioneRilevatore:='P';
    end
    else
    begin
      idx:=ArrIndexFromCodice('R',FRichiesta.Rilevatore);
      if idx >= 0 then
        FRichiesta.FunzioneRilevatore:=FArrRilevatori[idx].Funzione
      else
        FRichiesta.FunzioneRilevatore:='P';
    end;
  end;

  // motivazione
  if Length(FArrMotivazioni) > 0 then
  begin
    c:=grdTimbrature.medpIndexColonna('MOTIVAZIONE');
    if (grdTimbrature.medpCompGriglia[i].CompColonne[c] <> nil) then
    begin
      // verifica selezione motivazione
      IWC:=(grdTimbrature.medpCompCella(i,c,0) as TmeIWComboBox);
      if IWC.ItemIndex < 0 then
      begin
        MsgBox.MessageBox('E'' necessario selezionare una motivazione per la richiesta!',INFORMA);
        ActiveControl:=IWC;
        Exit;
      end;
      FRichiesta.Motivazione:=FArrMotivazioni[IWC.ItemIndex].Codice;
    end
    else
      FRichiesta.Motivazione:='';
  end;

  // controlli ok
  Result:=True;
  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.EseguiRichiesta;
var LDataOra: TDateTime;
begin
  FDatiTimb.Operazione:=FRichiesta.Operazione;
  FDatiTimb.Progressivo:=selAnagrafeW.FieldByName('PROGRESSIVO').AsInteger;
  FDatiTimb.Data:=FRichiesta.Data;
  FDatiTimb.Ora:=FRichiesta.Ora;
  FDatiTimb.FunzioneRilevatore:=FRichiesta.FunzioneRilevatore;
  if FDatiTimb.Operazione = 'I' then
  begin
    FDatiTimb.Verso:=FRichiesta.Verso;
    FDatiTimb.Causale:=FRichiesta.Causale;
    FDatiTimb.Rilevatore:=FRichiesta.Rilevatore;
    FDatiTimb.Motivazione:=FRichiesta.Motivazione;
    FDatiTimb.VersoOrig:='';
    FDatiTimb.CausaleOrig:='';
    FDatiTimb.RilevatoreOrig:='';
    FDatiTimb.NoteIns:=Trim((grdTimbrature.medpCompCella(0,'NOTE',0) as TmeIWMemo).Text)
  end
  else if FDatiTimb.Operazione = 'M' then
  begin
    FDatiTimb.Verso:=FRichiesta.Verso;
    FDatiTimb.Causale:=FRichiesta.Causale;
    FDatiTimb.Rilevatore:='';
    FDatiTimb.Motivazione:=FRichiesta.Motivazione;
    FDatiTimb.VersoOrig:=W018DM.selT100ModifTimb.FieldByName('VERSO').AsString;
    FDatiTimb.CausaleOrig:=W018DM.selT100ModifTimb.FieldByName('CAUSALE').AsString;
    FDatiTimb.RilevatoreOrig:=W018DM.selT100ModifTimb.FieldByName('RILEVATORE').AsString;
    FDatiTimb.NoteIns:=Trim(FMemoText);
  end
  else if FDatiTimb.Operazione = 'C' then
  begin
    FDatiTimb.Verso:=W018DM.selT100ModifTimb.FieldByName('VERSO').AsString;
    FDatiTimb.Causale:=W018DM.selT100ModifTimb.FieldByName('CAUSALE').AsString;
    FDatiTimb.Rilevatore:=W018DM.selT100ModifTimb.FieldByName('RILEVATORE').AsString;
    FDatiTimb.Motivazione:='';
    FDatiTimb.VersoOrig:='';
    FDatiTimb.CausaleOrig:='';
    FDatiTimb.RilevatoreOrig:='';
    FDatiTimb.NoteIns:='';
  end;

  A023MW.ItemsRichiestaTimb.PostAnnullaRichiesta:=PostAnnullaRichiesta;
  A023MW.ItemsRichiestaTimb.PostInsRichiesta:=PostInsRichiesta;
  A023MW.ItemsRichiestaTimb.selT105:=W018DM.selT105;
  A023MW.ItemsRichiestaTimb.C018:=C018;
  FDatiTimb.RisposteMsg.Clear;
  A023MW.ControlliRichiestaTimb(FDatiTimb);
  GestisciRisposteRichiestaTimb;
end;

procedure TW018FRichiestaTimbrature.ConfermaInsRichiesta;
begin
  A023MW.ConfermaInsRichiesta;
  GestisciRisposteRichiestaTimb;
end;

procedure TW018FRichiestaTimbrature.AnnullaInsRichiesta;
begin
  A023MW.AnnullaInsRichiesta;
end;

procedure TW018FRichiestaTimbrature.GestisciRisposteRichiestaTimb;
begin
  if FDatiTimb.RisposteMsg.Bloccante then
  begin
    //Messaggio bloccante
    MsgBox.MessageBox(FDatiTimb.RisposteMsg.ErrMsg,ESCLAMA,FDatiTimb.RisposteMsg.ErrTitolo);
    Exit;
  end
  else if FDatiTimb.RisposteMsg.ErrMsg <> '' then
  begin
    //Mesaggio non bloccante: richiesta riposta dall'operatore
    Messaggio(FDatiTimb.RisposteMsg.ErrTitolo,FDatiTimb.RisposteMsg.ErrMsg,ConfermaInsRichiesta,AnnullaInsRichiesta);
    Exit;
  end
  else
  begin
    // nulla da fare
  end;
end;

procedure TW018FRichiestaTimbrature.PostInsRichiesta;
var
  Res: Integer;
  TmpMsgOperazione: String;
const
  FUNZIONE = 'ConfermaInsRichiesta';
begin
  if (C018.Id > 0) and (C018.StatoRichiesta <> '') and (Parametri.CampiRiferimento.C90_W018AcquisizioneAuto <> 'S') then
    C018.IncludiTipoRichieste(trAutorizzate);

  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW018FRichiestaTimbrature.PostAnnullaRichiesta;
begin
  // aggiorna visualizzazione
  grdRichieste.medpResetOffset;
  VisualizzaDipendenteCorrente;
end;

procedure TW018FRichiestaTimbrature.DistruggiOggetti;
const
  FUNZIONE = 'DistruggiOggetti';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  // dealloca componenti creati
  FreeAndNil(FDatiTimb);
  FreeAndNil(W018DM);
  FreeAndNil(A023MW);

  SetLength(FArrMotivazioni,0);
  FreeAndNil(FLstCausFilt);

  inherited;

  Log('Traccia',FUNZIONE + ': fine');
end;

procedure TW018FRichiestaTimbrature.edtDataFiltroSubmit(Sender: TObject);
const
  FUNZIONE = 'edtDataFiltroSubmit';
begin
  Log('Traccia',FUNZIONE + ': inizio');

  btnVisualizzaClick(nil);

  Log('Traccia',FUNZIONE + ': fine');
end;

end.

