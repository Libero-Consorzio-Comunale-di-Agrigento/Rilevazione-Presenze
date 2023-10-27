unit UfrmDBRichEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.DBCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB;

type
  TfrmDBRichEdit = class(TFrame)
    pnlTools: TPanel;
    btnBold: TSpeedButton;
    btnItalic: TSpeedButton;
    btnUnderline: TSpeedButton;
    btnAlignLeft: TSpeedButton;
    btnAlignCenter: TSpeedButton;
    btnAlignRight: TSpeedButton;
    cmbSize: TComboBox;
    cmbColore: TComboBox;
    cmbFontName: TComboBox;
    DMemo: TDBRichEdit;
    procedure btnBoldClick(Sender: TObject);
    procedure btnItalicClick(Sender: TObject);
    procedure btnUnderlineClick(Sender: TObject);
    procedure cmbColoreChange(Sender: TObject);
    procedure cmbColoreDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure cmbSizeChange(Sender: TObject);
    procedure cmbFontNameChange(Sender: TObject);
    procedure cmbFontNameKeyPress(Sender: TObject; var Key: Char);
    procedure DMemoSelectionChange(Sender: TObject);
    procedure btnAlignLeftClick(Sender: TObject);
    procedure btnAlignCenterClick(Sender: TObject);
    procedure btnAlignRightClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inizializza(pDataSource: TDataSource; pDataField: string);
    procedure AbilitaTools(pAbilita: Boolean);
  end;

implementation

{$R *.dfm}

{ TfrmGestRichText }

procedure TfrmDBRichEdit.Inizializza(pDataSource: TDataSource; pDataField: string);
begin
  DMemo.DataSource:=pDataSource;
  DMemo.DataField:=pDataField;

  //Componenti
  with cmbColore.Items do
  begin
    Add(IntToStr(clBlack));
    Add(IntToStr(clRed));
    Add(IntToStr(clFuchsia));
    Add(IntToStr(clBlue));
    Add(IntToStr(clGreen));
    Add(IntToStr(clYellow));
  end;
  cmbColore.ItemIndex:=0;
  cmbFontName.Items := Screen.Fonts;

  AbilitaTools(False);

  DMemo.OnSelectionChange:=DMemoSelectionChange;

  cmbFontName.OnChange:=cmbFontNameChange;
  cmbFontName.OnKeyPress:=cmbFontNameKeyPress;

  cmbSize.OnChange:=cmbSizeChange;

  cmbColore.OnChange:=cmbColoreChange;
  cmbColore.OnDrawItem:=cmbColoreDrawItem;

  btnBold.OnClick:=btnBoldClick;
  btnItalic.OnClick:=btnItalicClick;
  btnUnderline.OnClick:=btnUnderlineClick;

  btnAlignLeft.OnClick:=btnAlignLeftClick;
  btnAlignCenter.OnClick:=btnAlignCenterClick;
  btnAlignRight.OnClick:=btnAlignRightClick;
end;

procedure TfrmDBRichEdit.btnBoldClick(Sender: TObject);
var Btn: TSpeedButton;
begin
  Btn:=TSpeedButton(Sender);
  if Btn.Down then
    DMemo.SelAttributes.Style:=DMemo.SelAttributes.Style + [TFontStyle.fsBold]
  else
    DMemo.SelAttributes.Style:=DMemo.SelAttributes.Style - [TFontStyle.fsBold];
  DMemo.SetFocus;
end;

procedure TfrmDBRichEdit.btnItalicClick(Sender: TObject);
var Btn: TSpeedButton;
begin
  Btn:=TSpeedButton(Sender);
  if Btn.Down then
    DMemo.SelAttributes.Style:=DMemo.SelAttributes.Style + [TFontStyle.fsItalic]
  else
    DMemo.SelAttributes.Style:=DMemo.SelAttributes.Style - [TFontStyle.fsItalic];
  DMemo.SetFocus;
end;

procedure TfrmDBRichEdit.btnUnderlineClick(Sender: TObject);
var Btn: TSpeedButton;
begin
  Btn:=TSpeedButton(Sender);
  if Btn.Down then
      DMemo.SelAttributes.Style:=DMemo.SelAttributes.Style + [TFontStyle.fsUnderline]
  else
      DMemo.SelAttributes.Style:=DMemo.SelAttributes.Style - [TFontStyle.fsUnderline];
  DMemo.SetFocus;
end;

procedure TfrmDBRichEdit.cmbColoreChange(Sender: TObject);
begin
  if TComboBox(Sender).Focused then
  begin
    DMemo.SelAttributes.Color:=StrToInt(TComboBox(Sender).Text);
    DMemo.SetFocus;
  end;
end;

procedure TfrmDBRichEdit.cmbColoreDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TComboBox, Canvas do
  begin
    // fill the rectangle first with white
    Brush.Color:=clWhite;
    FillRect(Rect);
    // then reduce it and fill it with the color
    InflateRect(Rect, -2, -2);
    Brush.Color:=StrToInt(Items[Index]);
    FillRect(Rect);
  end;
end;

procedure TfrmDBRichEdit.cmbSizeChange(Sender: TObject);
begin
  if TComboBox(Sender).Focused then
  begin
    DMemo.SelAttributes.Size:=StrToInt(TComboBox(Sender).Text);
    DMemo.SetFocus;
  end;
end;

procedure TfrmDBRichEdit.DMemoSelectionChange(Sender: TObject);
var i: integer;
begin
  with cmbFontName do
  begin
    for i:=0 to Items.Count do
      if Items[i]=DMemo.SelAttributes.Name then
      begin
        ItemIndex:=i;
        Break
      end;
  end;

  with cmbSize do
  begin
    for i:=0 to Items.Count do
      if Items[i]=IntToStr(DMemo.SelAttributes.Size) then
      begin
        ItemIndex:=i;
        Break
      end;
  end;

  with cmbColore do
  begin
    if DMemo.SelAttributes.Color < 0 then
      ItemIndex:=0
    else
    for i:=0 to Items.Count do
      if Items[i]=IntToStr(DMemo.SelAttributes.Color) then
      begin
        ItemIndex:=i;
        Break
      end;
  end;

  btnBold.Down:= fsBold in DMemo.SelAttributes.Style;
  btnItalic.Down:=fsItalic in DMemo.SelAttributes.Style;
  btnUnderline.Down:=fsUnderline in DMemo.SelAttributes.Style;

  if DMemo.Paragraph.Alignment=taLeftJustify then
    btnAlignLeft.Down:=True
  else if DMemo.Paragraph.Alignment=taRightJustify then
    btnAlignRight.Down:=True
  else if DMemo.Paragraph.Alignment=taCenter then
    btnAlignCenter.Down:=True;
end;

procedure TfrmDBRichEdit.cmbFontNameChange(Sender: TObject);
var Cmb: TComboBox;
begin
  Cmb:=TComboBox(Sender);
  if Cmb.Focused then
  begin
    DMemo.SelAttributes.Name:=Cmb.Items[Cmb.ItemIndex];
    //DMemo.SetFocus;
  end;
end;

procedure TfrmDBRichEdit.cmbFontNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=VK_RETURN then
    DMemo.SetFocus;
end;

procedure TfrmDBRichEdit.AbilitaTools(pAbilita: Boolean);
var i: integer;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i].GetParentComponent = pnlTools then
    begin
      if Components[i] is TComboBox then TComboBox(Components[i]).Enabled:=pAbilita;
      if Components[i] is TSpeedButton then TSpeedButton(Components[i]).Enabled:=pAbilita;
    end;
end;

procedure TfrmDBRichEdit.btnAlignLeftClick(Sender: TObject);
  var Btn: TSpeedButton;
begin
  Btn:=TSpeedButton(Sender);
  if Btn.Down then
    DMemo.Paragraph.Alignment:=taLeftJustify;
  DMemo.SetFocus;
end;

procedure TfrmDBRichEdit.btnAlignCenterClick(Sender: TObject);
  var Btn: TSpeedButton;
begin
  Btn:=TSpeedButton(Sender);
  if Btn.Down then
    DMemo.Paragraph.Alignment:=taCenter;
  DMemo.SetFocus;
end;

procedure TfrmDBRichEdit.btnAlignRightClick(Sender: TObject);
  var Btn: TSpeedButton;
begin
  Btn:=TSpeedButton(Sender);
  if Btn.Down then
    DMemo.Paragraph.Alignment:=taRightJustify;
  DMemo.SetFocus;
end;

end.
