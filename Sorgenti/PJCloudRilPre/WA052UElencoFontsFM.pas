unit WA052UElencoFontsFM;

interface

uses
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompLabel, meIWLabel,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompListbox,
  meIWComboBox, IWCompButton, meIWButton, WR100UBase, IWCompEdit, meIWEdit,
  IWCompCheckbox, meIWCheckBox, medpIWMultiColumnComboBox, A052UParCarMW, Generics.collections,
  System.UITypes, A000Umessaggi, A000UInterfaccia, A000UCostanti;

type
  TWA052FElencoFontsFM = class(TWR200FBaseFM)
    cmbFonts: TmeIWComboBox;
    btnChiudi: TmeIWButton;
    btnConferma: TmeIWButton;
    lblFonts: TmeIWLabel;
    lblDimensione: TmeIWLabel;
    cmbDimensione: TMedpIWMultiColumnComboBox;
    chkGrassetto: TmeIWCheckBox;
    chkCorsivo: TmeIWCheckBox;
    chkSottolineato: TmeIWCheckBox;
    chkBarrato: TmeIWCheckBox;
    lblColore: TmeIWLabel;
    cmbColore: TmeIWComboBox;
    procedure btnChiudiClick(Sender: TObject);
    procedure IWFrameRegionCreate(Sender: TObject);
  private
    FontProperties: TFontProperties;
    lstSystemFonts: TList<String>;
  public
    procedure Visualizza(Fp: TFontProperties);
    procedure ReleaseOggetti; override;
  end;

implementation

uses
  Winapi.CommDlg;

{$R *.dfm}


procedure TWA052FElencoFontsFM.IWFrameRegionCreate(Sender: TObject);
var
  i: Integer;
//  s: String;
begin
  inherited;
  lstSystemFonts:=TList<String>.Create;
  LoadFontList(lstSystemFonts);
  //dimensioni
  cmbDimensione.Items.Clear;
  for i:=8 to 30 do
    cmbDimensione.AddRow(i.toString);
  //colori
  for i:=0 to High(lstColori) do
    if (lstColori[i].Testo = 'S') then
      cmbColore.Items.Add(lstColori[i].Nome+'='+lstColori[i].Numero.ToString);
end;

procedure TWA052FElencoFontsFM.Visualizza(Fp: TFontProperties);
var
  lstFonts: TList<String>;
  s: String;
  idx: Integer;
  Found: Boolean;
begin
  FontProperties:=Fp;
  //fonts
  lstFonts:=TList<String>.Create(lstSystemFonts);
  try
    //se font preimpostato non trovato nella lista lo aggiungo

    Found:=False;
    for s in lstFonts do
    begin
      if s.ToUpper = FontProperties.Name.ToUpper then
      begin
        Found:=true;
        Break;
      end;
    end;
    if not Found then
      lstFonts.Add(FontProperties.Name);

    lstFonts.Sort;

    cmbFonts.Items.Clear;
    cmbFonts.ItemIndex:=-1;
    for s in lstFonts do
    begin
      idx:=cmbFonts.Items.Add(s);
      if s.ToUpper = FontProperties.Name.ToUpper then
        cmbFonts.ItemIndex:=idx;
    end;
    if cmbFonts.ItemIndex = -1 then
      cmbFonts.ItemIndex:=0;
  finally
    FreeAndNil(lstFonts);
  end;
  //dimensioni
  cmbDimensione.Text:=FontProperties.Size.ToString;
  //check
  chkGrassetto.Checked:=FontProperties.Bold;
  chkSottolineato.Checked:=FontProperties.Underline;
  chkCorsivo.Checked:=FontProperties.Italic;
  chkBarrato.Checked:=FontProperties.StrikeOut;

  for idx:=0 to cmbColore.items.Count - 1 do
  begin
    if cmbColore.Items.ValueFromIndex[idx] = FontProperties.Color.ToString then
    begin
      cmbColore.ItemIndex:=idx;
      Break;
    end;
  end;

  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,412,245,245, 'Elenco fonts','#wa052elencofonts_container',False,True);
end;

procedure TWA052FElencoFontsFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  if sender = btnConferma then
  begin
    if cmbFonts.ItemIndex = -1 then
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Font']));

     if cmbDimensione.Text = '' then
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Punti']));

    if cmbColore.ItemIndex = -1 then
      raise Exception.Create(Format(A000MSG_ERR_FMT_CAMPO_OBBLIGATORIO,['Colore']));

    FontProperties.Name:=cmbFonts.Text;
    FontProperties.Size:=cmbDimensione.Text.ToInteger;
    FontProperties.Color:=cmbColore.Items.ValueFromIndex[cmbColore.ItemIndex].ToInteger;

    FontProperties.Bold:=chkGrassetto.Checked;
    FontProperties.Underline:=chkSottolineato.Checked;
    FontProperties.Italic:=chkCorsivo.Checked;
    FontProperties.StrikeOut:=chkBarrato.Checked;
  end;

  ReleaseOggetti;
  Free;
end;

procedure TWA052FElencoFontsFM.ReleaseOggetti;
begin
  inherited;
  FreeAndNil(lstSystemFonts);
end;

end.
