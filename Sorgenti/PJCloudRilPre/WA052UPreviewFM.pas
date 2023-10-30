unit WA052UPreviewFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, A052UParCarMW, WR100UBase,
  meIWLabel, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWCompButton, meIWButton, meIWRegion, IWCompLabel, IWApplication, C180FunzioniGenerali,
  IWCompEdit, meIWEdit, Generics.collections, C190FunzioniGeneraliWeb,
  WA052UParCarDM;

type
  TWA052FPreviewFM = class(TWR200FBaseFM)
    btnChiudi: TmeIWButton;
    previewRG: TmeIWRegion;
    lblLarghezza: TmeIWLabel;
    lblAltezza: TmeIWLabel;
    lblLeft: TmeIWLabel;
    lblTop: TmeIWLabel;
    edtLarghezza: TmeIWEdit;
    edtAltezza: TmeIWEdit;
    edtLeft: TmeIWEdit;
    edtTop: TmeIWEdit;
    lblCaption: TmeIWLabel;
    edtCaption: TmeIWEdit;
    btnConferma: TmeIWButton;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure edtProprietaAsyncChange(Sender: TObject;
      EventParams: TStringList);
    procedure edtProprietaSubmit(Sender: TObject);
  private
    DicComponenti: TDictionary<String,TmeIWLabel>;
    FSezione: TSezione;
    FCanModifica: Boolean;
    FSelectedLabel: TmeIWLabel;
    procedure LabelPreviewAsyncClick(Sender: TObject; EventParams: TStringList);
    procedure ImpostaAbilitazioneModificaProprieta;
    procedure ImpostaProprietaSuEdit;
    procedure ImpostaProprietaSuLabel;
  public
    ResultPreview: TProc<String>;
    procedure Visualizza(sezione:TSezione;modificaAllowed: boolean);
    procedure ReleaseOggetti; override;
  end;

implementation

{$R *.dfm}

{ TWA052FPreviewFM }

procedure TWA052FPreviewFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  FSelectedLabel:=nil;
  edtLarghezza.Text:='';
  edtAltezza.Text:='';
  edtLeft.Text:='';
  edtTop.Text:='';
  edtCaption.Text:='';
  DicComponenti:=TDictionary<String,TmeIWLabel>.Create();
end;

procedure TWA052FPreviewFM.Visualizza(sezione: TSezione;modificaAllowed: Boolean);
var
  LabelProperties: TLabelProperties;
  lblPreview: TmeIWLabel;
begin
  FSezione:=sezione;
  FCanModifica:=modificaAllowed;
  for LabelProperties in sezione.LstLabels do
  begin
    lblPreview:=TmeIWLabel.Create(Self);
    lblPreview.Parent:=previewRG;
    //associo uniquename al componente. mi serve per riabbinare i componenti
    //a labelProperties
    DicComponenti.add(LabelProperties.UniqueName,lblPreview);

    lblPreview.caption:=LabelProperties.Caption;
    lblPreview.Hint:=LabelProperties.Name;
    lblPreview.top:=LabelProperties.Top;
    lblPreview.left:=LabelProperties.Left;
    lblPreview.width:=LabelProperties.Width;
    lblPreview.height:=LabelProperties.Height;
    lblPreview.tag:=LabelProperties.Tag;

    //Render options
    lblPreview.StyleRenderOptions.RenderSize:=True;
    lblPreview.StyleRenderOptions.RenderPosition:=True;
    lblPreview.StyleRenderOptions.RenderAbsolute:=True;
    lblPreview.StyleRenderOptions.RenderPadding:=False;
    lblPreview.StyleRenderOptions.RenderFont:=True;
    lblPreview.RenderSize:=False;
    lblPreview.AutoSize:=False;
    //font
    lblPreview.Font.FontName:=sezione.FontProperties.Name.ToLower + ',arial';
    lblPreview.Font.Enabled:=True;
    lblPreview.Font.Size:=sezione.FontProperties.Size;
    lblPreview.Font.Style:=[];
    if sezione.FontProperties.Bold then
      lblPreview.Font.Style:=lblPreview.Font.Style + [fsBold];
    if sezione.FontProperties.Italic then
      lblPreview.Font.Style:=lblPreview.Font.Style + [fsItalic];
    if sezione.FontProperties.Underline then
      lblPreview.Font.Style:=lblPreview.Font.Style + [fsUnderline];
    if sezione.FontProperties.StrikeOut then
      lblPreview.Font.Style:=lblPreview.Font.Style + [fsStrikeOut];
    lblPreview.Font.Color:=sezione.FontProperties.Color;
    lblPreview.css:='spanPreview';
    lblPreview.BGColor:=clWhite;
    lblPreview.OnAsyncClick:=LabelPreviewAsyncClick;
  end;
  ImpostaAbilitazioneModificaProprieta;

  btnConferma.Visible:=FCanModifica;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,850,450,450, 'Anteprima','#wa052preview',False,False);
end;

procedure TWA052FPreviewFM.edtProprietaSubmit(Sender: TObject);
begin
  inherited;
  ImpostaProprietaSuLabel;
end;

procedure TWA052FPreviewFM.edtProprietaAsyncChange(Sender: TObject;
  EventParams: TStringList);
begin
  ImpostaProprietaSuLabel;
end;

procedure TWA052FPreviewFM.ImpostaAbilitazioneModificaProprieta;
var
  bEnabled: Boolean;
begin
  //NON USARE READONLY ALTRIMENTI IL PLUGIN AUTONUMERIC NON VIENE APPLICATO
 // bReadOnly:=(not FCanModifica) or (FSelectedLabel = nil);
  bEnabled:=(FCanModifica) and (FSelectedLabel <> nil);
  edtLarghezza.Enabled:=bEnabled;
  edtAltezza.Enabled:=bEnabled;
  edtLeft.Enabled:=bEnabled;
  edtTop.Enabled:=bEnabled;
  edtCaption.Enabled:=bEnabled;
end;

procedure TWA052FPreviewFM.LabelPreviewAsyncClick(Sender: TObject;
  EventParams: TStringList);
var
  lbl: TmeIWLabel;
  s: string;
begin
  lbl:=(Sender as TmeIWLabel);
  if (lbl = FSelectedLabel) then Exit;
  s:='';
  if FSelectedLabel <> nil then
  begin
    s:='$("#' + FSelectedLabel.HTMLName + '").removeClass("shadow"); ';
    FSelectedLabel.css:=StringReplace(FSelectedLabel.css,' shadow','',[rfReplaceAll]);
  end;

  s:=s + '$("#' + lbl.HTMLName + '").addClass("shadow"); ';
  lbl.css:=lbl.css + ' shadow';
  FSelectedLabel:=lbl;

  ImpostaProprietaSuEdit;
  GGetWebApplicationThreadVar.CallBackResponse.AddJavaScriptToExecuteAsCDATA(s);
end;

procedure TWA052FPreviewFM.ImpostaProprietaSuEdit;
begin
  edtLarghezza.Text:=FSelectedLabel.Width.ToString;
  edtAltezza.Text:=FSelectedLabel.Height.ToString;
  edtLeft.Text:=FSelectedLabel.Left.ToString;
  edtTop.Text:=FSelectedLabel.Top.ToString;
  edtCaption.Text:=FSelectedLabel.Caption;
  ImpostaAbilitazioneModificaProprieta;
end;

procedure TWA052FPreviewFM.ImpostaProprietaSuLabel;
begin
  try
    FSelectedLabel.Width:=StrToInt(edtLarghezza.Text);
  except
  end;
  try
    FSelectedLabel.Height:=StrToInt(edtAltezza.Text);
  except
  end;
  try
    FSelectedLabel.Left:=StrToInt(edtLeft.Text);
  except
  end;
  try
    FSelectedLabel.Top:=StrToInt(edtTop.Text);
  except
  end;
  FSelectedLabel.Caption:=edtCaption.Text;
end;

procedure TWA052FPreviewFM.btnChiudiClick(Sender: TObject);
var
  LabelProperties: TLabelProperties;
  lbl: TmeIWLabel;
begin
  inherited;
  if sender = btnConferma then
  begin
    //imposto su LstLabels i cambiamenti fatti ai componenti
    for LabelProperties in Fsezione.LstLabels do
    begin
      lbl:=dicComponenti[LabelProperties.UniqueName];

      //usare Name= Hint perchè alcuni campi possono essere presenti più volte
      //nel riepilogo; perciò il nome del campo viene salvato nell'hint e non nel nome
      //del componente stesso
      LabelProperties.Name:=lbl.Hint;
      LabelProperties.Caption:=lbl.Caption;
      LabelProperties.Top:=lbl.Top;
      LabelProperties.Left:=lbl.Left;
      LabelProperties.Height:=lbl.Height;
      LabelProperties.Width:=lbl.Width;
      LabelProperties.Tag:=lbl.Tag;
    end;
    with (WR302DM as TWA052FParCarDM) do
    begin
      CaricaClientDataset(dicCdsLabels[Fsezione.Name],Fsezione);
    end;
    if Assigned(ResultPreview) then
    begin
      ResultPreview(Fsezione.Name);
    end;
  end;
  ReleaseOggetti;
  Free;
end;

procedure TWA052FPreviewFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(DicComponenti);
end;

end.
