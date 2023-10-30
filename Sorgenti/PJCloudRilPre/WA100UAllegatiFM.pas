unit WA100UAllegatiFM;

interface

uses
  A000UCostanti,
  A000UInterfaccia,
  C021UDocumentiManagerDM,
  C180FunzioniGenerali,
  C190FunzioniGeneraliWeb,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Data.Db, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, WR203UGestDetailFM, System.Actions,
  Vcl.ActnList, Vcl.Menus, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompGrids, meIWGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWDBGrids, medpIWDBGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  meIWLink, IWApplication, System.IOUtils, IWGlobal,
  meIWImageFile;

type
  TWA100FAllegatiFM = class(TWR203FGestDetailFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
  private
    C021DM: TC021FDocumentiManagerDM;
    procedure imgFileDownloadExecute(Sender: TObject);
  public
    procedure ReleaseOggetti; override;
    procedure CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource); override;
  end;

implementation

{$R *.dfm}

{ TWA100FAllegatiFM }

procedure TWA100FAllegatiFM.IWFrameRegionCreate(Sender: TObject);
begin
  actCopiaSu.Visible:=False;
  actNuovo.Visible:=False;
  actModifica.Visible:=False;
  actElimina.Visible:=False;
  actAnnulla.Visible:=False;
  actConferma.Visible:=False;

  inherited;

  C021DM:=TC021FDocumentiManagerDM.Create(nil);
end;

procedure TWA100FAllegatiFM.ReleaseOggetti;
begin
  FreeAndNil(C021DM);
end;

procedure TWA100FAllegatiFM.CaricaDettaglio(DataSet:TDataSet; DataSource:TDataSource);
var
  c: Integer;
begin
  grdTabella.medpComandiCustom:=True;
  inherited;
  c:=grdTabella.medpIndexColonna(DBG_COMANDI);
  grdTabella.medpPreparaComponenteGenerico('WR102-R',c,0,DBG_IMG,'','SALVA','Salva il documento','','');
  grdTabella.medpCaricaCDS;
end;

procedure TWA100FAllegatiFM.grdTabellaAfterCaricaCDS(Sender: TObject; DBG_ROWID: string);
var
  i: Integer;
  IWImg: TmeIWImageFile;
begin
  inherited;

  for i:=0 to High(grdTabella.medpCompGriglia) do
  begin
    IWImg:=(grdTabella.medpCompCella(i,DBG_COMANDI,0) as TmeIWImageFile);
    IWImg.Tag:=StrToInt(grdTabella.medpValoreColonna(i,'ID'));
    IWImg.medpDownloadButton:=True;
    IWImg.OnClick:=imgFileDownloadExecute;
  end;
end;

procedure TWA100FAllegatiFM.imgFileDownloadExecute(Sender: TObject);
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
    A000SessioneWEB.RipristinaTimeOut;
  end;
end;

end.
