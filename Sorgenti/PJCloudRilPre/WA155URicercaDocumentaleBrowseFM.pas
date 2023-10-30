unit WA155URicercaDocumentaleBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, C190FunzioniGeneraliWeb, meIWImageFile,
  C021UDocumentiManagerDM, IWApplication, IWGlobal, A000UInterfaccia, A000UCostanti,
  C180FunzioniGenerali, A000UMessaggi;

type
  TWA155FRicercaDocumentaleBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
    procedure grdTabellaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
  private
    C021DM: TC021FDocumentiManagerDM;
    procedure ReleaseOggetti; override;
    procedure imgAccediClick(Sender: TObject);
    procedure imgDownloadClick(Sender: TObject);
  end;

implementation

uses WA155URicercaDocumentale, WA155URicercaDocumentaleDM, A155URicercaDocumentaleMW;

{$R *.dfm}

procedure TWA155FRicercaDocumentaleBrowseFM.IWFrameRegionCreate(Sender: TObject);
var
  c: Integer;
begin
  // gestione tabella
  grdTabella.medpComandiCustom:=True;
  inherited;
  // prepara i componenti sulla colonna comandi
  grdTabella.medpPreparaComponentiDefault;
  c:=grdTabella.medpIndexColonna(DBG_COMANDI);
  grdTabella.medpPreparaComponenteGenerico('WR102-R',c,0,DBG_IMG,'','SALVA','Salva il documento','','');
  if (Self.Owner as TWA155FRicercaDocumentale).AbilitaGestioneA154 then
    grdTabella.medpPreparaComponenteGenerico('WR102-R',c,1,DBG_IMG,'','ACCEDI','Accedi al documento','','');
  grdTabella.medpCaricaCDS;

  // scorciatoia per datamodulo di servizio per allegati
  C021DM:=(WR302DM as TWA155FRicercaDocumentaleDM).A155MW.C021DM;
end;

procedure TWA155FRicercaDocumentaleBrowseFM.ReleaseOggetti;
begin
  //
end;

procedure TWA155FRicercaDocumentaleBrowseFM.grdTabellaAfterCaricaCDS(
  Sender: TObject; DBG_ROWID: string);
var
  r: Integer;
  img: TmeIWImageFile;
begin
  for r:=0 to High(grdTabella.medpCompGriglia) do
  begin
    // salva
    if grdTabella.medpCompCella(r,DBG_COMANDI,0) <> nil then
    begin
      img:=(grdTabella.medpCompCella(r,DBG_COMANDI,0) as TmeIWImageFile);
      //img.medpDownloadButton:=True; //bugfix
      img.OnClick:=imgDownloadClick;
    end;
    // accedi
    if ((Self.Owner as TWA155FRicercaDocumentale).AbilitaGestioneA154) and
       (grdTabella.medpCompCella(r,DBG_COMANDI,1) <> nil) then
    begin
      img:=(grdTabella.medpCompCella(r,DBG_COMANDI,1) as TmeIWImageFile);
      img.OnClick:=imgAccediClick;
    end;
  end;
end;

procedure TWA155FRicercaDocumentaleBrowseFM.grdTabellaRenderCell(
  ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
  Campo: String;
  NoteLimitate: Boolean;
begin
  if not grdTabella.medpRenderCell(ACell,ARow,AColumn,True,True,True) then
    Exit;

  NumColonna:=grdTabella.medpNumColonna(AColumn);
  Campo:=grdTabella.medpColonna(NumColonna).DataField;

  if ARow = 0 then
  begin
    // noop
  end
  else
  begin
    if Campo = 'NOTE' then
    begin
      // se il testo supera certe soglie (lunghezza o ritorni a capo)
      // lo riduce inserendo dei puntini di sospensione
      // per evitare che la riga ecceda un'altezza accettabile
      if (ACell.Text = '') or (ACell.Text = '<br>') then
      begin
        ACell.Hint:='';
        ACell.ShowHint:=False;
      end
      else
      begin
        ACell.Hint:=C190ConvertiSimboliHtml(ACell.Text);
        ACell.Css:=ACell.Css + ' tooltipHtml';
        NoteLimitate:=False;
        if Length(ACell.Text) > LIMITE_CARATTERI_NOTE then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('%s...',[Copy(ACell.Text,1,LIMITE_CARATTERI_NOTE)]);
        end;
        if ACell.RawText then
        begin
          NoteLimitate:=True;
          ACell.Text:=Format('<div style="overflow-y: hidden; text-overflow: ellipsis; max-height: %dem;">%s</div>',[LIMITE_RIGHE_NOTE,ACell.Text]);
        end;
        ACell.ShowHint:=NoteLimitate;
      end;
    end;
  end;

  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdTabella.medpCompGriglia) + 1) and (grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdTabella.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

procedure TWA155FRicercaDocumentaleBrowseFM.imgDownloadClick(Sender: TObject);
// effettua il download dell'allegato
var
  i: Integer;
  LId: Integer;
  LDoc: TDocumento;
  FN: String;
  LResCtrl: TResCtrl;
begin
  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdTabella.medpRigaDiCompGriglia(FN);

  // estrae id richiesta
  LId:=grdTabella.medpValoreColonna(i,'ID').ToInteger;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  A000SessioneWEB.AnnullaTimeOut;
  try
    try
      // estrae il file con i metadati associati
      LResCtrl:=C021DM.GetById(LId,True,LDoc);
      if not LResCtrl.Ok then
      begin
        MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // invia il file al browser
      // aggiorna i dati di accesso al documento ed esegue il download
      (Self.Owner as TWA155FRicercaDocumentale).AggiornaAccessoEScarica(LId,LDoc.FilePath);
    except
      on E: Exception do
      begin
        MsgBox.MessageBox(Format(A000MSG_A155_ERR_FMT_DOC_SALVA,[E.Message]),ESCLAMA);
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TWA155FRicercaDocumentaleBrowseFM.imgAccediClick(Sender: TObject);
var
  FN, LProg, LId, LParametri: String;
  i: Integer;
begin
  if not (Self.Owner as TWA155FRicercaDocumentale).AbilitaGestioneA154 then
  begin
    MsgBox.MessageBox('La funzione <A154> Gestione documentale non è abilitata!',ESCLAMA);
    Exit;
  end;

  FN:=(Sender as TmeIWImageFile).FriendlyName;
  i:=grdTabella.medpRigaDiCompGriglia(FN);
  LProg:=grdTabella.medpValoreColonna(i,'PROGRESSIVO');
  LId:=grdTabella.medpValoreColonna(i,'ID');
  LParametri:='PROGRESSIVO=' + LProg + ParamDelimiter +
              'ID=' + LId;
  (Self.Owner as TWA155FRicercaDocumentale).AccediForm(76,LParametri,False);
end;

end.
