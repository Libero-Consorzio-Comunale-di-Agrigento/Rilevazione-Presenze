unit WA119URichiesteFM;

interface

uses
  WA119UPartecipazioneScioperiDM, A119UPartecipazioneScioperiMW, WC015USelEditGridFM,
  C190FunzioniGeneraliWeb,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  IWAdvRadioGroup, meTIWAdvRadioGroup, IWCompExtCtrls, meIWImageFile,
  medpIWImageButton, C180FunzioniGenerali, System.StrUtils, System.Math;

type
  TWA119FRichiesteFM = class(TWR203FGestDetailFM)
    rgpAutorizzate: TmeTIWAdvRadioGroup;
    rgpBloccate: TmeTIWAdvRadioGroup;
    btnImporta: TmedpIWImageButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure btnImportaClick(Sender: TObject);
    procedure rgpAutorizzateClick(Sender: TObject);
    procedure rgpBloccateClick(Sender: TObject);
  private
    A119MW: TA119FPartecipazioneScioperiMW;
    procedure imgVisDettaglioClick(Sender: TObject);
    procedure imgAnnullaAutClick(Sender: TObject);
    procedure imgBloccaSbloccaRiepiloghiClick(Sender: TObject);
    procedure imgImportaClick(Sender: TObject);
  public
    procedure PreparaComponenti;
  end;

implementation

uses WA119UPartecipazioneScioperi, // qui per circular unit reference
     A000UInterfaccia;

{$R *.dfm}

procedure TWA119FRichiesteFM.IWFrameRegionCreate(Sender: TObject);
begin
  // variabile di appoggio per semplificare
  A119MW:=((Self.Owner as TWA119FPartecipazioneScioperi).WR302DM as TWA119FPartecipazioneScioperiDM).A119MW;
  grdTabella.medpComandiCustom:=True;

  // disabilita azioni di edit sul dataset
  actNuovo.Visible:=False;
  actCopiaSu.Visible:=False;
  actModifica.Visible:=False;
  actElimina.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;

  inherited;
  grdTabella.medpTestoNoRecord:='Nessuna notifica';
  grdTabella.medpPaginazione:=True;
  grdTabella.medpRighePagina:=200;
end;

procedure TWA119FRichiesteFM.PreparaComponenti;
// prepara componenti per tabella di dettaglio
begin
  grdTabella.medpCancellaRigaWR102;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),0,DBG_IMG,'','ACCEDI','Visualizza notifica adesione sciopero','','');
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),1,DBG_IMG,'','BLOCCA_RIEP','Blocca riepiloghi','','');
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),2,DBG_IMG,'','SBLOCCA_RIEP','Sblocca riepiloghi','','');
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),3,DBG_IMG,'','IMPORTA','Importa giustificativi per il personale che aderisce allo sciopero','','');
  grdTabella.medpPreparaComponenteGenerico('WR102-R',grdTabella.medpIndexColonna('DBG_COMANDI'),4,DBG_IMG,'','ANNULLA','Annulla autorizzazione richiesta','Confermi l''annullamento dell''autorizzazione?','');
end;

procedure TWA119FRichiesteFM.grdTabellaAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i: Integer;
  Autorizzato, Bloccato: Boolean;
  TipoRich: String;
begin
  inherited;
  for i:=IfThen(grdTabella.medpRigaInserimento,1,0) to High(grdTabella.medpCompGriglia) do
  begin
    Autorizzato:=grdTabella.medpValoreColonna(i,'AUTORIZZATO') = 'S';
    Bloccato:=grdTabella.medpValoreColonna(i,'BLOCCATO') = 'S';
    TipoRich:=grdTabella.medpValoreColonna(i,'TIPO_RICHIESTA');
    // visualizza notifica adesione
    with (grdTabella.medpCompCella(i,'DBG_COMANDI',0) as TmeIWImageFile) do
    begin
      OnClick:=imgVisDettaglioClick;
    end;
    // blocca riepiloghi
    with (grdTabella.medpCompCella(i,'DBG_COMANDI',1) as TmeIWImageFile) do
    begin
      if Bloccato then
        Css:='invisibile';
      OnClick:=imgBloccaSbloccaRiepiloghiClick;
    end;
    // sblocca riepiloghi
    with (grdTabella.medpCompCella(i,'DBG_COMANDI',2) as TmeIWImageFile) do
    begin
      if not Bloccato then
        Css:='invisibile';
      OnClick:=imgBloccaSbloccaRiepiloghiClick;
    end;
    // importa
    with (grdTabella.medpCompCella(i,'DBG_COMANDI',3) as TmeIWImageFile) do
    begin
      if (not Autorizzato) or (TipoRich = A119_TR_E) then
        Css:='invisibile';
      OnClick:=imgImportaClick;
    end;
    // annulla autorizzazione
    with (grdTabella.medpCompCella(i,'DBG_COMANDI',4) as TmeIWImageFile) do
    begin
      if (not Autorizzato) then
        Css:='invisibile';
      OnClick:=imgAnnullaAutClick;
    end;
  end;
end;

procedure TWA119FRichiesteFM.rgpAutorizzateClick(Sender: TObject);
begin
  A119MW.FiltraNotifiche(rgpAutorizzate.ItemIndex,rgpBloccate.ItemIndex);
  grdTabella.medpCaricaCDS;
end;

procedure TWA119FRichiesteFM.rgpBloccateClick(Sender: TObject);
begin
  A119MW.FiltraNotifiche(rgpAutorizzate.ItemIndex,rgpBloccate.ItemIndex);
  grdTabella.medpCaricaCDS;
end;

// #######################################################################
// ################## AZIONI SULLA TABELLA DI DETTAGLIO ##################
// #######################################################################

procedure TWA119FRichiesteFM.imgVisDettaglioClick(Sender: TObject);
// visualizza notifica adesione sciopero tramite popup
// se Sender = nil -> si assume posizionamento già effettuato su record
var
  WC015: TWC015FSelEditGridFM;
  FN: String;
begin
  if (Sender <> nil) and
     (Sender is TmeIWImageFile) then
  begin
    // posizionamento su record indicato
    FN:=(Sender as TmeIWImageFile).FriendlyName;
    grdTabella.medpColumnClick(Sender,FN);
  end;

  // visualizzazione dettaglio dipendenti
  with A119MW do
  begin
    CaricaDettaglioDipendenti(selT251.FieldByName('ID').AsInteger);

    WC015:=TWC015FSelEditGridFM.Create(Self.Parent);
    WC015.Visualizza(Format('Notifica adesione sciopero di %s',[selT251.FieldByName('NOMINATIVO').AsString]),A119MW.selT252,False,False,False,800);
  end;
end;

procedure TWA119FRichiesteFM.imgAnnullaAutClick(Sender: TObject);
// annulla l'autorizzazione della richiesta
var
  Id, Prog: Integer;
  Autorizzato: Boolean;
  Data: TDateTime;
  FN, OldRowId: String;
begin
  // posizionamento su record indicato
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdTabella.medpColumnClick(Sender,FN);

  with A119MW do
  begin
    OldRowId:=selT251.RowId;
    Id:=selT251.FieldByName('ID').AsInteger;
    Prog:=selT251.FieldByName('PROGRESSIVO').AsInteger;
    Data:=selT251.FieldByName('DATA').AsDateTime;
    Autorizzato:=selT251.FieldByName('AUTORIZZATO').AsString = 'S';

    // azione impedita se richiesta non autorizzata
    if not Autorizzato then
      raise Exception.Create('Impossibile annullare l''autorizzazione ad una richiesta non autorizzata');

    // effettua annullamento autorizzazione
    try
      AnnullaAutorizzazione(Id,Prog,Data);
      SessioneOracle.Commit;

      // messaggio di avvenuta elaborazione
      MsgBox.MessageBox('Annullamento effettuato!',INFORMA);
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        MsgBox.MessageBox(Format('Annullamento non effettuato: %s!',[E.Message]),INFORMA);
      end;
    end;

    // aggiornamento tabella
    selT251.Close;
    selT251.Open;
    grdTabella.medpCaricaCDS(OldRowId);
  end;
end;

procedure TWA119FRichiesteFM.imgBloccaSbloccaRiepiloghiClick(Sender: TObject);
// blocca / sblocca i riepiloghi in base al corrispondente flag della richiesta
var
  Bloccato: Boolean;
  Prog: Integer;
  Data: TDateTime;
  FN, OldRowId: String;
begin
  // posizionamento su record indicato
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdTabella.medpColumnClick(Sender,FN);

  with A119MW do
  begin
    OldRowId:=selT251.RowId;
    Prog:=selT251.FieldByName('PROGRESSIVO').AsInteger;
    Data:=selT251.FieldByName('DATA').AsDateTime;
    Bloccato:=selT251.FieldByName('BLOCCATO').AsString = 'S';
    OldRowId:=selT251.RowId;

    // effettua blocco / sblocco riepiloghi in base al flag
    try
      if Bloccato then
        SbloccaRiepiloghiT250(Prog,Data)
      else
        BloccaRiepiloghiT250(Prog,Data);
      SessioneOracle.Commit;

      // messaggio di avvenuta elaborazione
      MsgBox.MessageBox(Format('%s riepiloghi effettuato!',[IfThen(Bloccato,'Sblocco','Blocco')]),INFORMA);
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        MsgBox.MessageBox(Format('%s riepiloghi non effettuato!',[IfThen(Bloccato,'Sblocco','Blocco')]),INFORMA);
      end;
    end;

    // aggiornamento tabella
    selT251.Close;
    selT251.Open;
    grdTabella.medpCaricaCDS(OldRowId);
  end;
end;

procedure TWA119FRichiesteFM.imgImportaClick(Sender: TObject);
// effettua l'inserimento dei giustificativi sui dipendenti compresi nella richiesta selezionata
var
  Autorizzato: Boolean;
  Id, Prog: Integer;
  FN, TipoRichiesta: String;
begin
  // posizionamento su record indicato
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  grdTabella.medpColumnClick(Sender,FN);

  with A119MW do
  begin
    PulisciAnomalieImportazione;
    Id:=selT251.FieldByName('ID').AsInteger;
    Prog:=selT251.FieldByName('PROGRESSIVO').AsInteger;
    Autorizzato:=selT251.FieldByName('AUTORIZZATO').AsString = 'S';
    TipoRichiesta:=selT251.FieldByName('TIPO_RICHIESTA').AsString;

    // azione impedita se richiesta non autorizzata
    if not Autorizzato then
      raise Exception.Create('Impossibile importare una richiesta non autorizzata');

    // azione impedita se richiesta non da importare
    if TipoRichiesta <> A119_TR_D then
      raise Exception.Create('Impossibile importare una richiesta non definitiva');

    // visibilità campi per esito importazione
    A119MW.selT251.FieldByName('D_ESITO_IMPORTAZIONE').Visible:=True;
    A119MW.selT252.FieldByName('D_ANOMALIE').Visible:=True;

    // importa i giustificativi per la richiesta
    try
      ImportaGiustificativi(Id,Prog);
      SessioneOracle.Commit;

      // messaggio di avvenuta elaborazione
      MsgBox.MessageBox('Importazione effettuata',INFORMA);
    except
      on E: Exception do
      begin
        SessioneOracle.Rollback;
        // visualizza anomalie importazione
        imgVisDettaglioClick(nil);
        MsgBox.MessageBox('Importazione non effettuata a causa di anomalie.'#13#10'Verificare il dettaglio.',INFORMA);
      end;
    end;
  end;

  // aggiorna tabella
  A119MW.selT251.Close; // v. evento OnCalcFields
  A119MW.selT251.Open; // v. evento OnCalcFields
  grdTabella.medpColonna('D_ESITO_IMPORTAZIONE').Visible:=True; // necessario per recepire la visibilità del field corrispondente
  grdTabella.medpCaricaCDS;
end;

procedure TWA119FRichiesteFM.btnImportaClick(Sender: TObject);
// effettua l'inserimento dei giustificativi per tutte le richieste presenti
var
  NumElab,NumErr: Integer;
begin
  // ciclo sulle richieste autorizzate per importazione
  NumElab:=0;
  NumErr:=0;
  with A119MW do
  begin
    PulisciAnomalieImportazione;
    selT251.First;
    while not selT251.Eof do
    begin
      if (selT251.FieldByName('AUTORIZZATO').AsString = 'S') and
         (selT251.FieldByName('TIPO_RICHIESTA').AsString = A119_TR_D) then
      begin
        // importa i giustificativi per la richiesta
        try
          inc(NumElab);
          ImportaGiustificativi(selT251.FieldByName('ID').AsInteger,selT251.FieldByName('PROGRESSIVO').AsInteger);
          SessioneOracle.Commit;
        except
          on E: Exception do
          begin
            inc(NumErr);
            SessioneOracle.Rollback;
          end;
        end;
      end;
      selT251.Next;
    end;
  end;

  // messaggio finale
  if NumElab = 0 then
  begin
    // nessuna richiesta importata
    MsgBox.MessageBox('Nessuna richiesta da importare!',INFORMA);
  end
  else
  begin
    // una o più richieste importate
    if NumErr = 0 then
    begin
      MsgBox.MessageBox('Importazione di tutti i giustificativi effettuata correttamente',INFORMA);
    end
    else
    begin
      MsgBox.MessageBox('Importazione di tutti i giustificativi effettuata con errori.'#13#10 +
                        'Una o più richieste non sono state importate',INFORMA);
    end;

    // visibilità campi per esito importazione
    A119MW.selT251.FieldByName('D_ESITO_IMPORTAZIONE').Visible:=True;
    A119MW.selT252.FieldByName('D_ANOMALIE').Visible:=True;

    // aggiorna tabella
    A119MW.selT251.Close; // v. evento OnCalcFields
    A119MW.selT251.Open; // v. evento OnCalcFields
    grdTabella.medpCaricaCDS;
  end;
end;

end.
