unit MedpUnimPanelNota;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, unimMemo, MedpUnimPanel2Labels, MedpUnimLabelIcon,
  MedpUnimTypes, MedpUnimLabel, MedpUnimMemo;

type
  TMedpUnimPanelNota = class(TMedpUnimPanelBase)
  private
    FpnlHeader: TMedpUnimPanelBase;
    FlblIntestazione: TMedpUnimLabel;
    FlblStatoAutorizzazione: TMedpUnimLabel;
    FlblEdit: TMedpUnimLabelIcon;
    FmemNota: TMedpUnimMemo;

    FOldText: String;

    FKey: Variant;
    FData: TObject;
  protected
    procedure SetDefaultProperties; override;

    procedure OnClickEdit(Sender: TObject);
    procedure OnExitMemo(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelIntestazione: TMedpUnimLabel read FlblIntestazione;
    property LabelStatoAutorizzazione: TMedpUnimLabel read FlblStatoAutorizzazione;
    property EditIcon: TMedpUnimLabelIcon read FlblEdit;
    property Memo: TMedpUnimMemo read FmemNota;

    property Key: Variant read FKey write FKey;
    property Data: TObject read FData write FData;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelNota]);
end;

{ TMedpUnimPanelNota }

constructor TMedpUnimPanelNota.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FpnlHeader:=TMedpUnimPanelBase.Create(Self);
  FlblIntestazione:=TMedpUnimLabel.Create(Self);
  FlblEdit:=TMedpUnimLabelIcon.Create(FpnlHeader);
  FlblStatoAutorizzazione:=TMedpUnimLabel.Create(Self);
  FmemNota:=TMedpUnimMemo.Create(Self);


  with FpnlHeader do
  begin
    Layout:='hbox';
    LayoutAttribs.Align:='center';
    LayoutAttribs.Pack:='start';
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='auto';
    Constraints.MinHeight:=35;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FmemNota do
  begin
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='100';
    FmemNota.Memo.Enabled:=False;
    FmemNota.Memo.OnExit:=OnExitMemo;
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FlblIntestazione do
  begin
    Flex:=1;
    JustifyContent:=JustifyStart;
    LayoutConfig.Height:='auto';
    Parent:=FpnlHeader;
    SetSubComponent(True);
  end;

  with FlblStatoAutorizzazione do
  begin
    LayoutConfig.Width:='100%';
    JustifyContent:=JustifyStart;
    LayoutConfig.Height:='auto';
    Parent:=Self;
    SetSubComponent(True);
  end;

  with FlblEdit do
  begin
    Caption:='fas fa-edit';
    LayoutConfig.Height:='100%';
    LayoutConfig.Width:='35';
    Font.Size:=22;
    Visible:=True;
    OnClick:=OnClickEdit;
    SetSubComponent(True);
    Parent:=FpnlHeader;
  end;

  SetDefaultProperties;
end;

procedure TMedpUnimPanelNota.SetDefaultProperties;
begin
  inherited;

  Height:=45;
  Width:=200;

  Layout:='vbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='auto';
end;

procedure TMedpUnimPanelNota.OnExitMemo(Sender: TObject);
begin
  FmemNota.Memo.Enabled:=False;
  FmemNota.ConfermaIcon.Visible:=False;
  FmemNota.ConfermaIcon.OnClick(FmemNota.ConfermaIcon);
  FlblEdit.Visible:=True;

  if Trim(FmemNota.Memo.Text)='' then
    FmemNota.Memo.Text:='(nessuna nota)';

  if Trim(FmemNota.Memo.Text) <> FOldText then
    DoOnChange;
end;

procedure TMedpUnimPanelNota.OnClickEdit(Sender: TObject);
begin
  if Sender is TMedpUnimLabelIcon then
    if (Sender as TMedpUnimLabelIcon).Visible then
    begin
      FmemNota.Memo.Enabled:=True;
      FmemNota.Memo.WebFocus;
      FlblEdit.Visible:=False;

      FOldText:=Trim(FmemNota.Memo.Text);

      if Trim(FmemNota.Memo.Text)='(nessuna nota)' then
        FmemNota.Memo.Text:='';
    end;
end;

end.
