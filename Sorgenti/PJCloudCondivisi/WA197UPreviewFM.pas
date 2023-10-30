unit WA197UPreviewFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, WR100UBase, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton, meIWButton,
  meIWRegion, WA197ULayoutSchedaAnagrDM, OracleData, Data.DB, meIWLabel;

type
  TWA197FPreviewFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    previewRG: TmeIWRegion;
    procedure btnChiudiClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Visualizza(Pagina: String);
  end;

implementation

{$R *.dfm}

{ TWA197FPreviewFM }

procedure TWA197FPreviewFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  ReleaseOggetti;
  Free;
end;

procedure TWA197FPreviewFM.Visualizza(Pagina:String);
var
  ODS: TOracleDataset;
  BM: TBookmark;
  lblPreview: TmeIWLabel;
begin
  with (WR302DM as TWA197FLayoutSchedaAnagrDM) do
  begin
    ODS:=dicDatasetPagina.items[Pagina];
    try
      BM:=ODS.GetBookmark;
      ODS.First;
      while not ODS.EOF do
      begin
        if (ODS.FieldByName('ACCESSO').AsString <> 'N') and
           (ODS.FieldByName('NOMEPAGINA').AsString = Pagina)then
        begin
          lblPreview:=TmeIWLabel.Create(Self);
          lblPreview.Parent:=previewRG;

          lblPreview.caption:=ODS.FieldByName('CAPTION').AsString;
          lblPreview.Hint:=ODS.FieldByName('CAMPODB').AsString;
          lblPreview.top:=ODS.FieldByName('TOP').AsInteger;
          lblPreview.left:=ODS.FieldByName('LFT').AsInteger;
          lblPreview.height:=3;
          if (ODS.FieldByName('ACCESSO').AsString = 'R') then
            lblPreview.Enabled:=False;

          //Render options
          lblPreview.StyleRenderOptions.RenderSize:=False;
          lblPreview.StyleRenderOptions.RenderPosition:=True;
          lblPreview.StyleRenderOptions.RenderAbsolute:=True;
          lblPreview.StyleRenderOptions.RenderPadding:=False;
          lblPreview.StyleRenderOptions.RenderFont:=True;
          lblPreview.RenderSize:=False;
          lblPreview.AutoSize:=True;

          lblPreview.css:='spanPreview';
          lblPreview.BGColor:=clWhite;
        end;
        ODS.Next;
      end;
      if ODS.BookmarkValid(BM) then
        ODS.GotoBookmark(BM);
    finally
      ODS.FreeBookmark(BM);
    end;
  end;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,850,450,450, 'Anteprima ' + Pagina,'#'+ Self.name,False,False);
end;

end.
