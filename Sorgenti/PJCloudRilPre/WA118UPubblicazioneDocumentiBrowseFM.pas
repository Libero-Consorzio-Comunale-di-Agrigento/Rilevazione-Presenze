unit WA118UPubblicazioneDocumentiBrowseFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR204UBrowseTabellaFM, Vcl.Menus,
  IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompGrids,
  IWDBGrids, medpIWDBGrid, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion;

type
  TWA118FPubblicazioneDocumentiBrowseFM = class(TWR204FBrowseTabellaFM)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WA118FPubblicazioneDocumentiBrowseFM: TWA118FPubblicazioneDocumentiBrowseFM;

implementation

{$R *.dfm}

end.
