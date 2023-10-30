unit WC022UMsgElaborazioneFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompLabel, meIWLabel, IWCompExtCtrls, meIWImageFile, A000UMessaggi;

type
  TWC022FMsgElaborazioneFM = class(TWR200FBaseFM)
    lblMsg: TmeIWLabel;
    imgElaborazione: TmeIWImageFile;
    imgLoader: TmeIWImageFile;
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    FMessaggio: String;
    FTitolo: String;
    FFilename: String;
  public
    procedure Visualizza;
    procedure Chiudi;
    property Messaggio : String write FMessaggio;
    property Titolo : String write FTitolo;
    property ImgFileName : String write FFilename;
    const
      IMG_FILENAME_ELABORAZIONE='img\elaborazione.png';
      IMG_FILENAME_PDF='img\Pdf.png';
      IMG_FILENAME_XLS='img\xls.png';
      IMG_FILENAME_XLSX='img\xlsx.png';
      IMG_FILENAME_TXT='img\txt.png';
  end;

implementation

uses WR100UBase;

{$R *.dfm}

procedure TWC022FMsgElaborazioneFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  Messaggio:=A000MSG_MSG_ELABORAZIONE_PDF_IN_CORSO;
  Titolo:=A000MSG_MSG_ELABORAZIONE;
  ImgFileName:=IMG_FILENAME_PDF;
end;

procedure TWC022FMsgElaborazioneFM.Visualizza;
begin
  lblMsg.Caption:=FMessaggio;
  imgElaborazione.ImageFile.Filename:=FFilename;
  // visualizza messaggio modale
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,500,200,200,FTitolo,'#wa074msgstampa_container',False,True);
end;

procedure TWC022FMsgElaborazioneFM.Chiudi;
begin
  ReleaseOggetti;
  Free;
end;

end.
