unit WC029USelezioneFontFM;

interface

uses
  A000UMessaggi,
  A000UInterfaccia,
  C190FunzioniGeneraliWeb,
  WR200UBaseFM,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel, meIWLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompListbox,
  meIWComboBox, IWCompButton, meIWButton, IWCompEdit, meIWEdit,
  IWCompCheckbox, meIWCheckBox, Generics.collections,
  System.UITypes, System.StrUtils, Vcl.Forms;

type
  TFontInfo = record
    Color: TColor;
    Name: String;
    Size: Integer;
    Bold: boolean;
    Italic: boolean;
    Underline : boolean;
    StrikeOut: boolean;
    function GetStyle: String; inline;
    procedure SetStyle(const Value: String);
    function ToString: String; inline;
  end;

  TFontFrameCloseProc = reference to procedure(const PSceltaConfermata: Boolean; const PResult: TFontInfo);

  TWC029FSelezioneFontFM = class(TWR200FBaseFM)
    cmbFonts: TmeIWComboBox;
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    lblFonts: TmeIWLabel;
    lblDimensione: TmeIWLabel;
    chkGrassetto: TmeIWCheckBox;
    chkCorsivo: TmeIWCheckBox;
    chkSottolineato: TmeIWCheckBox;
    chkBarrato: TmeIWCheckBox;
    lblColore: TmeIWLabel;
    cmbColore: TmeIWComboBox;
    lblErrore: TmeIWLabel;
    cmbDimensione: TmeIWComboBox;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    FLstSystemFonts: TList<String>;
    FFontProperties: TFontInfo;
    FMyCloseProc: TFontFrameCloseProc;
    procedure _Visualizza;
  public
    property FontProperties: TFontInfo read FFontProperties write FFontProperties;
    property MyCloseProc: TFontFrameCloseProc read FMyCloseProc write FMyCloseProc;
    class procedure Visualizza(const PTitle: string; PFontInfo: TFontInfo; PCloseProc: TFontFrameCloseProc; const PSolaLettura: Boolean = False; PParent: TWinControl = nil);
    procedure ReleaseOggetti; override;
    procedure AbilitaComponenti(const PAbilita: Boolean); inline;
  end;

implementation

uses
  WR010UBase,
  IWApplication;

{$R *.dfm}

class procedure TWC029FSelezioneFontFM.Visualizza(const PTitle: string; PFontInfo: TFontInfo; PCloseProc: TFontFrameCloseProc; const PSolaLettura: Boolean = False; PParent: TWinControl = nil);
// metodo statico per semplificare la chiamata
var
  LFrame: TWC029FSelezioneFontFM;
begin
  if PParent = nil then
    PParent:=(GGetWebApplicationThreadVar.ActiveForm as TWR010FBase)
  else if not (PParent is TWR010FBase) then
    raise Exception.CreateFmt('Impossibile visualizzare il frame di selezione font su un componente %s (atteso TWR010FBase)',[PParent.ClassName]);

  // istanzia il frame e ne imposta le proprietà
  LFrame:=TWC029FSelezioneFontFM.Create(PParent);
  LFrame.Title:=PTitle;
  LFrame.FFontProperties:=PFontInfo;
  if PParent <> nil then
    LFrame.Parent:=PParent;
  LFrame.FMyCloseProc:=PCloseProc;
  LFrame._Visualizza;

  // abilitazione elementi interfaccia
  LFrame.AbilitaComponenti(not PSolaLettura);
end;

procedure TWC029FSelezioneFontFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;

  lblErrore.Caption:='';

  // carica elenco font di sistema (server)
  FLstSystemFonts:=TList<String>.Create;
  LoadFontList(FLstSystemFonts);

  // carica combobox dimensioni
  cmbDimensione.Items.Clear;
  for i:=8 to 30 do
    cmbDimensione.Items.Add(i.ToString); //cmbDimensione.AddRow(i.toString);

  // carica combobox colori (alcuni)
  cmbColore.Items.Add('nero=' + ColorToString(TColorRec.Black));
  cmbColore.Items.Add('bordeaux=' + ColorToString(TColorRec.Maroon));
  cmbColore.Items.Add('verde=' + ColorToString(TColorRec.Green));
  cmbColore.Items.Add('verde oliva=' + ColorToString(TColorRec.Olive));
  cmbColore.Items.Add('blu scuro=' + ColorToString(TColorRec.Navy));
  cmbColore.Items.Add('viola=' + ColorToString(TColorRec.Purple));
  cmbColore.Items.Add('verde acqua=' + ColorToString(TColorRec.Teal));
  cmbColore.Items.Add('grigio=' + ColorToString(TColorRec.Gray));
  cmbColore.Items.Add('grigio chiaro=' + ColorToString(TColorRec.LtGray));
  cmbColore.Items.Add('rosso=' + ColorToString(TColorRec.Red));
  cmbColore.Items.Add('verde limone=' + ColorToString(TColorRec.Lime));
  cmbColore.Items.Add('giallo=' + ColorToString(TColorRec.Yellow));
  cmbColore.Items.Add('blu=' + ColorToString(TColorRec.Blue));
  cmbColore.Items.Add('fucsia=' + ColorToString(TColorRec.Fuchsia));
  cmbColore.Items.Add('azzurro=' + ColorToString(TColorRec.Aqua));
  cmbColore.Items.Add('bianco=' + ColorToString(TColorRec.White));
end;

procedure TWC029FSelezioneFontFM._Visualizza;
var
  LLstFonts: TList<String>;
  s: String;
  idx: Integer;
  LFound: Boolean;
begin
  // elenco font
  LLstFonts:=TList<String>.Create(FLstSystemFonts);
  try
    // se font preimpostato non trovato nella lista lo aggiungo
    LFound:=False;
    for s in LLstFonts do
    begin
      if s.ToUpper = FFontProperties.Name.ToUpper then
      begin
        LFound:=true;
        Break;
      end;
    end;
    if not LFound then
      LLstFonts.Add(FFontProperties.Name);

    // ordinamento dei font
    LLstFonts.Sort;

    // popola la combobox dei font
    cmbFonts.Items.Clear;
    cmbFonts.ItemIndex:=-1;
    for s in LLstFonts do
    begin
      idx:=cmbFonts.Items.Add(s);
      if s.ToUpper = FFontProperties.Name.ToUpper then
        cmbFonts.ItemIndex:=idx;
    end;
    if cmbFonts.ItemIndex = -1 then
      cmbFonts.ItemIndex:=0;
  finally
    FreeAndNil(LLstFonts);
  end;

  // dimensione
  cmbDimensione.ItemIndex:=cmbDimensione.Items.IndexOf(FFontProperties.Size.ToString); //cmbDimensione.Text:=FFontProperties.Size.ToString;

  // impostazioni del font
  chkGrassetto.Checked:=FFontProperties.Bold;
  chkSottolineato.Checked:=FFontProperties.Underline;
  chkCorsivo.Checked:=FFontProperties.Italic;
  chkBarrato.Checked:=FFontProperties.StrikeOut;

  // seleziona il colore
  for idx:=0 to cmbColore.items.Count - 1 do
  begin
    if cmbColore.Items.ValueFromIndex[idx] = ColorToString(FFontProperties.Color) then
    begin
      cmbColore.ItemIndex:=idx;
      Break;
    end;
  end;

  // visualizza il frame di selezione font
  if Parent is TWR010FBase then
    TWR010FBase(Parent).VisualizzaJQMessaggio(jQuery,380,-1,230,Title,'#' + Name,True,True,-1,'','',btnChiudi.HTMLName);
end;

procedure TWC029FSelezioneFontFM.AbilitaComponenti(const PAbilita: Boolean);
begin
  C190AbilitaComponente(cmbFonts,PAbilita);
  C190AbilitaComponente(cmbDimensione,PAbilita);
  C190AbilitaComponente(cmbColore,PAbilita);

  C190AbilitaComponente(chkGrassetto,PAbilita);
  C190AbilitaComponente(chkSottolineato,PAbilita);
  C190AbilitaComponente(chkCorsivo,PAbilita);
  C190AbilitaComponente(chkBarrato,PAbilita);

  C190VisualizzaElemento(JQuery,'wc029buttons',PAbilita);
  btnConferma.Visible:=PAbilita;
end;

procedure TWC029FSelezioneFontFM.btnChiudiClick(Sender: TObject);
// conferma selezione o chiude frame
var
  LErr: string;
  LColorStr: string;
begin
  lblErrore.Caption:='';

  if Sender = btnConferma then
  begin
    LErr:=IfThen(cmbFonts.ItemIndex = -1,'Font, ') +
          IfThen(cmbDimensione.ItemIndex = -1,'Punti, ') + //IfThen(cmbDimensione.Text = '','Punti, ') +
          IfThen(cmbColore.ItemIndex = -1,'Colore, ');
    if LErr <> '' then
    begin
      LErr:=LErr.Substring(0,LErr.Length - 2);
      lblErrore.Caption:=Format(A000MSG_ERR_FMT_DATI_OBBLIGATORI,[LErr]);
      Exit;
    end;

    // imposta le proprietà del font selezionato
    FFontProperties.Name:=cmbFonts.Text;
    FFontProperties.Size:=StrToInt(cmbDimensione.Text);
    LColorStr:=cmbColore.Items.ValueFromIndex[cmbColore.ItemIndex];
    FFontProperties.Color:=StringToColor(LColorStr);
    FFontProperties.Bold:=chkGrassetto.Checked;
    FFontProperties.Underline:=chkSottolineato.Checked;
    FFontProperties.Italic:=chkCorsivo.Checked;
    FFontProperties.StrikeOut:=chkBarrato.Checked;
  end;

  FMyCloseProc((Sender = btnConferma), FFontProperties);

  // distruzione oggetti
  ReleaseOggetti;
  Free;
end;

procedure TWC029FSelezioneFontFM.ReleaseOggetti;
begin
  inherited;

  FreeAndNil(FLstSystemFonts);
end;

{ TFontInfo }

function TFontInfo.GetStyle: String;
begin
  Result:=IfThen(Bold,'B') +
          IfThen(Italic,'I') +
          IfThen(Underline,'U') +
          IfThen(StrikeOut,'S');
end;

procedure TFontInfo.SetStyle(const Value: String);
var
  i: Integer;
begin
  // verifica i caratteri dello stringa (che indicano lo stile del font)
  for i:=0 to Value.Length - 1 do
  begin
    if not CharInSet(Value.Chars[i],['B','I','U','S']) then
      raise Exception.CreateFmt('Lo stile del font contiene uno o più caratteri non leciti: %s',[Value.Chars[i]]);
  end;

  // imposta le proprietà del font
  Bold:=Value.Contains('B');
  Italic:=Value.Contains('I');
  Underline:=Value.Contains('U');
  StrikeOut:=Value.Contains('S');
end;

function TFontInfo.ToString: String;
var
  LColorStr: string;
begin
  LColorStr:=ColorToString(Color).Substring(2);
  Result:=Format('%s - %d - %s - %s',[Name,Size,GetStyle,LColorStr]);
end;

end.
