unit WC018UInfoRichiestaFM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  A000UGestioneTimbraGiustMW,
  C018UIterAutDM,
  C021UDocumentiManagerDM,
  C180FunzioniGenerali,
  FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  WR200UBaseFM,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container,
  IWRegion, WR010UBase, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, IWCompGrids, IWDBGrids, medpIWDBGrid,
  IWCompButton, meIWButton, Data.DB, IWCompMemo, meIWMemo, Vcl.Menus;

type
  TWC018FInfoRichiestaFM = class(TWR200FBaseFM)
    lblIDRichiesta: TmeIWLabel;
    lblDataRichiesta: TmeIWLabel;
    lblCodiceIter: TmeIWLabel;
    lblRichiedente: TmeIWLabel;
    lblNoteRichiedente: TmeIWLabel;
    lblInformazioniDellaRichiesta: TmeIWLabel;
    lblIDRichiestaValue: TmeIWLabel;
    lblDataRichiestaValue: TmeIWLabel;
    lblCodiceIterValue: TmeIWLabel;
    lblRichiedenteValue: TmeIWLabel;
    lblInfoAutorizzatore: TmeIWLabel;
    lblDataAutorizzazione: TmeIWLabel;
    lblAutorizzatore: TmeIWLabel;
    lblNoteAutorizzatore: TmeIWLabel;
    lblDataAutorizzazioneValue: TmeIWLabel;
    lblAutorizzatoreValue: TmeIWLabel;
    lblInfoRevoca: TmeIWLabel;
    lblIDRevoca: TmeIWLabel;
    lblDataRevoca: TmeIWLabel;
    lblNoteRevoca: TmeIWLabel;
    lblIDRevocaValue: TmeIWLabel;
    dGrdDocumenti: TmedpIWDBGrid;
    btnChiudi: TmeIWButton;
    mmNoteRichiedenteValue: TmeIWMemo;
    mmNoteAutorizzatoreValue: TmeIWMemo;
    mmNoteRevocaValue: TmeIWMemo;
    lblDatarevocaValue: TmeIWLabel;
    lblElencoAllegati: TmeIWLabel;
    ppmnuAllegati: TPopupMenu;
    procedure btnChiudiClick(Sender: TObject);
    procedure dGrdDocumentiAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    { Private declarations }
    C018IterInfo:TC018IterInfo;
    C021DM:TC021FDocumentiManagerDM;
    procedure imgFileDownloadExecute(Sender: TObject);
  public
    { Public declarations }
    A000FGestioneTimbraGiustMW: TA000FGestioneTimbraGiustMW;
    procedure Visualizza(IDRichiesta:integer);
  end;

implementation

uses
  meIWImageFile, IWApplication;

{$R *.dfm}

procedure TWC018FInfoRichiestaFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(C018IterInfo);
  FreeAndNil(Self);
end;

procedure TWC018FInfoRichiestaFM.dGrdDocumentiAfterCaricaCDS(Sender: TObject;
  DBG_ROWID: string);
var
  i: Integer;
  IWImg: TmeIWImageFile;
begin
  inherited;
  for i:=0 to High(dGrdDocumenti.medpCompGriglia) do
  begin
    IWImg:=(dGrdDocumenti.medpCompCella(i,DBG_COMANDI,0) as TmeIWImageFile);
    IWImg.Tag:=StrToInt(dGrdDocumenti.medpValoreColonna(i,'ID_ALLEGATO'));
    IWImg.medpDownloadButton:=True;
    IWImg.OnClick:=imgFileDownloadExecute;
  end;
end;

procedure TWC018FInfoRichiestaFM.imgFileDownloadExecute(Sender: TObject);
// effettua il download dell'allegato
var
  LId: Integer;
  LDoc: TDocumento;
  LResCtrl: TResCtrl;
begin
  // estrae id richiesta (è contenuto nel tag)
  LId:=(Sender as TmeIWImageFile).Tag;

  // se l'id non è valido esce immediatamente
  if LId <= 0 then
    Exit;

  C021DM:=TC021FDocumentiManagerDM.Create(nil);
  A000SessioneWEB.AnnullaTimeOut;
  try
    // estrae il file con i metadati associati
    try
      LResCtrl:=C021DM.GetById(LId,True,LDoc);

      if not LResCtrl.Ok then
      begin
        MsgBox.MessageBox(LResCtrl.Messaggio,ESCLAMA);
        Exit;
      end;

      // invia il file al browser
      GGetWebApplicationThreadVar.SendFile(LDoc.FilePath,True,'application/x-download',LDoc.GetNomeFileCompleto);
    except
      on E: Exception do
      begin
        GGetWebApplicationThreadVar.ShowMessage(Format('Errore durante il download del documento:'#13#10'%s',[E.Message]));
        Exit;
      end;
    end;
  finally
    FreeAndNil(LDoc);
    FreeAndNil(C021DM);
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

procedure TWC018FInfoRichiestaFM.Visualizza(IDRichiesta:integer);
var
  c:integer;
begin
  inherited;
  C018IterInfo:=TC018IterInfo.create;
  C018IterInfo.IDRichiesta:=IDRichiesta;
  //Info richiesta
  lblIDRichiestaValue.Caption:=C018IterInfo.IDRichiesta.ToString;
  lblDataRichiestaValue.Caption:=C018IterInfo.DataRichiesta.ToString;
  lblCodiceIterValue.Caption:=C018IterInfo.CodIter;
  lblRichiedenteValue.Caption:=C018IterInfo.Richiedente;
  mmNoteRichiedenteValue.Text:=C018IterInfo.NoteRichiesta;
  //Info autorizzatore
  lblDataAutorizzazioneValue.Caption:=C018IterInfo.DataAutorizzazione.ToString;
  lblAutorizzatoreValue.Caption:=C018IterInfo.Autorizzatore;
  mmNoteAutorizzatoreValue.Text:=C018IterInfo.NoteAutorizzatore;
  //Info revoca
  lblIDRevocaValue.Caption:=C018IterInfo.IDRevoca.ToString;
  lblDataRevocaValue.Caption:=C018IterInfo.DataRevoca.ToString;
  mmNoteRevocaValue.Text:=C018IterInfo.NoteRevoca;
  //Gestione allegati
  dGrdDocumenti.medpComandiCustom:=True;
  dGrdDocumenti.RigaInserimento:=False;
  dGrdDocumenti.medpAttivaGrid(C018IterInfo.Allegati,False,False);
  dGrdDocumenti.medpPreparaComponentiDefault;
  c:=dGrdDocumenti.medpIndexColonna(DBG_COMANDI);
  dGrdDocumenti.medpPreparaComponenteGenerico('WR102-R',c,0,DBG_IMG,'','SALVA','Salva il documento','','');
  dGrdDocumenti.medpCaricaCDS;

  (Self.Parent as TWR010FBase).VisualizzaJQMessaggio(jQuery,575,-1,-1,'<WC018> Informazioni richiesta','#' + Self.Name,False,True);
  C190VisualizzaElemento(JQuery,'grpRevoca',C018IterInfo.IDRevoca > 0);
  C190VisualizzaElemento(JQuery,'dGrdDocumenti',C018IterInfo.Allegati.RecordCount > 0);
end;

end.
