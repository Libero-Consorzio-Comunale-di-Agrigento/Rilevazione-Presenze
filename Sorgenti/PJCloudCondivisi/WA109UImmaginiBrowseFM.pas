unit WA109UImmaginiBrowseFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, DBClient,
  A000UInterfaccia, A000UMessaggi, C190FunzioniGeneraliWeb, WR204UBrowseTabellaFM,
  medpIWMessageDlg, medpIWDBGrid, meIWButton,
  IWApplication, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWDBGrids, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWLayoutMgrHTML, IWCompMemo,
  IWCompLabel, xmlDoc, ActiveX, IWHTMLTag, IWCompJQueryWidget, IWCompGrids,
  Vcl.Menus;

type
  TWA109FImmaginiBrowseFM = class(TWR204FBrowseTabellaFM)
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure grdTabellaDataSet2Componenti(Row: Integer);
  private
    { Private declarations }
    procedure btnCaricaImmagineClick(Sender: TObject);
    procedure OnFileUploadDialogResult(FileDialog: TObject;Conferma: Boolean;NomeFile: String);
  public
    { Public declarations }
  end;

implementation

uses WA109UImmaginiDM, WA109UImmagini;

{$R *.dfm}

procedure TWA109FImmaginiBrowseFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  grdTabella.medpPaginazione:=False;
  grdTabella.medpAggiornaCDS;
  grdTabella.medpPreparaComponentiDefault;
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('LARGHEZZA_CEDOLINO'),0,DBG_EDT,'input_num_nnnn_neg','','','');
  grdTabella.medpPreparaComponenteGenerico('WR102',grdTabella.medpIndexColonna('COLONNA_AZIONI'),0,DBG_BTN,'','Carica immagine...','','','');
end;

procedure TWA109FImmaginiBrowseFM.grdTabellaDataSet2Componenti(Row: Integer);
var
  Pulsante:TmeIWButton;
begin
  inherited;
  Pulsante:=(grdTabella.medpCompCella(Row,'COLONNA_AZIONI',0) as TmeIWButton);
  Pulsante.OnClick:=btnCaricaImmagineClick;
  Pulsante.Tag:=Row;
end;

procedure TWA109FImmaginiBrowseFM.btnCaricaImmagineClick(Sender: TObject);
begin
  (Owner as TWA109FImmagini).VisualizzaDialogFileUpload(OnFileUploadDialogResult);
end;

procedure TWA109FImmaginiBrowseFM.OnFileUploadDialogResult(FileDialog: TObject;Conferma: Boolean;NomeFile: String);
begin
  { DONE : TEST IW 14 OK }
  try
    if Conferma then
    begin
       if Pos('.BMP',UpperCase(ExtractFileName(NomeFile))) = 0 then
      begin
        MsgBox.WebMessageDlg(A000MSG_A109_MSG_IMMAGINE_NON_VALIDA,mtInformation,[mbOK],nil,'');
        Exit;
      end;
      //scrittura del file immagine sul dataset
      (WR302DM as TWA109FImmaginiDM).selTabellaIMMAGINE.LoadFromFile(NomeFile);
      //TestoStatus;
    end;
  except
    on E:Exception do
      raise Exception.Create(Format(A000MSG_ERR_FMT_ERRORE,['upload fallito']));
  end;
end;

end.
