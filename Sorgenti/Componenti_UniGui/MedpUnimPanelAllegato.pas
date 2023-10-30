unit MedpUnimPanelAllegato;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimLabelIcon, MedpUnimPanel4Labels, MedpUnimPanelNota,
  MedpUnimLabel, MedpUnimPanelEditIcons, Graphics, MedpUnimTypes, StrUtils;

type
  TMedpUnimPanelAllegato = class(TMedpUnimPanelBase)
  private
    FlblDownloadIcon: TMedpUnimLabelIcon;
    FpnlDati: TMedpUnimPanelBase;
    FpnlEditIcons: TMedpUnimPanelEditIcons;
    Fpnl4Labels: TMedpUnimPanel4Labels;
    FKey: Variant;
    FData: TObject;
  protected
    procedure LoadCompleted; override;
    procedure SetDefaultProperties; override;
  public
    constructor Create(AOwner: TComponent; PNomeFile, PDimensione, PNote: String);
  published
    property lblDownloadIcon: TMedpUnimLabelIcon read FlblDownloadIcon write FlblDownloadIcon;
    property pnlDati: TMedpUnimPanelBase read FpnlDati write FpnlDati;
    property pnlEditIcons: TMedpUnimPanelEditIcons read FpnlEditIcons write FpnlEditIcons;
    property Key: Variant read FKey write FKey;
    property Data: TObject read FData write FData;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelAllegato]);
end;

{ TMedpUnimPanelAllegato }

constructor TMedpUnimPanelAllegato.Create(AOwner: TComponent; PNomeFile, PDimensione, PNote: String);
var LlblNoteLabel: TMedpUnimLabel;
    LlblNoteText: TMedpUnimLabel;
begin
  inherited Create(AOwner);

  FpnlEditIcons:=TMedpUnimPanelEditIcons.Create(Self);
  FpnlDati:=TMedpUnimPanelBase.Create(Self);
  FlblDownloadIcon:=TMedpUnimLabelIcon.Create(Self);

  with FlblDownloadIcon do
  begin
    Caption:='fas fa-file-download';

    LayoutConfig.Height:='45';
    LayoutConfig.Width:='45';
    BoxModel.CSSMargin.Top:='5px';
    BoxModel.CSSMargin.Right:='2px';
    BoxModel.CSSMargin.Bottom:='5px';
    BoxModel.CSSMargin.Left:='2px';
    CSSColor:='#ffffff';
    Font.Size:=18;
    with BoxModel do
    begin
      CSSBorderRadius:='30px';
      CssPadding.Top:='4px';
      CssPadding.Right:='4px';
      CssPadding.Bottom:='5px';
      CssPadding.Left:='5px';
    end;
    SetSubComponent(True);
    Parent:=Self;
  end;

  with FpnlDati do
  begin
    Layout:='vbox';
    LayoutAttribs.Align:='center';
    LayoutAttribs.Pack:='center';
    Flex:=1;
    LayoutConfig.Height:='auto';
    BoxModel.CSSPadding.Top:='3px';
    BoxModel.CSSPadding.Right:='3px';
    BoxModel.CSSPadding.Bottom:='3px';
    BoxModel.CSSPadding.Left:='3px';
    SetSubComponent(True);
    Parent:=Self;
  end;
  InsertComponent(FpnlDati);

  with FpnlEditIcons do
  begin
    BoxModel.CSSMargin.Right:='2px';
    BoxModel.CSSMargin.Left:='2px';
    LayoutConfig.Height:='100%';
    SetSubComponent(True);
    Parent:=Self;
  end;
  InsertComponent(FpnlEditIcons);

  Fpnl4Labels:=TMedpUnimPanel4Labels.Create(FpnlDati);
  with Fpnl4Labels do
  begin
    Font.Style:=[fsBold];

    Label1.Caption:='Nome file:';
    Label1.JustifyContent:=TJustifyContent.JustifyStart;
    Label1.LayoutConfig.Height:='auto';
    Label1.LayoutConfig.Width:='40%';

    Label2.Caption:=PNomeFile;
    Label2.JustifyContent:=TJustifyContent.JustifyStart;
    Label2.LayoutConfig.Height:='auto';
    Label2.LayoutConfig.Width:='60%';

    Label3.Caption:='Dimensione:';
    Label3.JustifyContent:=TJustifyContent.JustifyStart;
    Label3.LayoutConfig.Height:='auto';
    Label3.LayoutConfig.Width:='40%';

    Label4.Caption:=PDimensione;
    Label4.LayoutConfig.Height:='auto';
    Label4.LayoutConfig.Width:='60%';

    SetSubComponent(True);
    Parent:=FpnlDati;
  end;
  FpnlDati.InsertComponent(Fpnl4Labels);

  LlblNoteLabel:=TMedpUnimLabel.Create(FpnlDati);
  with LlblNoteLabel do
  begin
    Caption:='Note:';
    Font.Style:=[fsBold];
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='auto';
    BoxModel.CSSBorder.Top:='1px solid';
    JustifyContent:=TJustifyContent.JustifyStart;
    SetSubComponent(True);
    Parent:=FpnlDati;
  end;
  FpnlDati.InsertComponent(LlblNoteLabel);

  LlblNoteText:=TMedpUnimLabel.Create(FpnlDati);
  with LlblNoteText do
  begin
    Caption:=IfThen(PNote = '', '(nessuna nota)', PNote);
    Font.Style:=[fsBold];
    LayoutConfig.Width:='100%';
    LayoutConfig.Height:='auto';
    JustifyContent:=TJustifyContent.JustifyStart;
    SetSubComponent(True);
    Parent:=FpnlDati;
  end;
  FpnlDati.InsertComponent(LlblNoteText);
end;

procedure TMedpUnimPanelAllegato.SetDefaultProperties;
begin
  inherited;

  Height:=45;
  Width:=300;

  Layout:='hbox';
  LayoutAttribs.Align:='center';
  LayoutAttribs.Pack:='start';
  LayoutConfig.Width:='100%';
  LayoutConfig.Height:='auto';
  BoxModel.CSSPadding.Top:='3px';
  BoxModel.CSSPadding.Bottom:='3px';
  Constraints.MinHeight:=30;
end;

procedure TMedpUnimPanelAllegato.LoadCompleted;
begin
  inherited;
  FlblDownloadIcon.JSInterface.JSCall('addCls',['activeClick']);
  FlblDownloadIcon.JSInterface.JSCall('addCls',['background-blue']);
  Fpnl4Labels.Label2.JSInterface.JSCall('addCls',['overflow-wrap-anywhere']);
end;

end.
