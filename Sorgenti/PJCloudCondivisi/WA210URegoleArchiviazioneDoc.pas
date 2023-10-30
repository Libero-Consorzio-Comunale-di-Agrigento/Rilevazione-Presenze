unit WA210URegoleArchiviazioneDoc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, IWCompJQueryWidget, A000UInterfaccia, Oracle, IWCompEdit, meIWEdit;

type
  TWA210FRegoleArchiviazioneDoc = class(TWR102FGestTabella)
    JQuery: TIWJQueryWidget;
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses WA210URegoleArchiviazioneDocDM,WA210URegoleArchiviazioneDocDettFM,
  WA210URegoleArchiviazioneDocBrowseFM;



{$R *.dfm}

procedure TWA210FRegoleArchiviazioneDoc.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  WR302DM:=TWA210FRegoleArchiviazioneDocDM.Create(Self);
  WBrowseFM:=TWA210FRegoleArchiviazioneDocBrowseFM.Create(Self);
  WDettaglioFM:=TWA210FRegoleArchiviazioneDocDettFM.Create(Self);
  (WDettaglioFM as TWA210FRegoleArchiviazioneDocDettFM).selI210:=WR302DM.selTabella;
  JQuery.OnReady.Text:=Format(W000JQ_Tabs,[Name]);

  CreaTabDefault;
  (WR302DM as TWA210FRegoleArchiviazioneDocDM).AfterScrollCustom:=(WDettaglioFM as TWA210FRegoleArchiviazioneDocDettFM).AfterScroll;
  (WDettaglioFM as TWA210FRegoleArchiviazioneDocDettFM).dcmbTipologiaDocumenti.ListSource:=(WR302DM as TWA210FRegoleArchiviazioneDocDM).dsrT962Lookup;
end;

end.


