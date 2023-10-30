unit MedpUnimPanelDownload;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.Forms, uniGUIBaseClasses,
  uniGUIClasses, uniGUImJSForm, MedpUnimPanelBase, MedpUnimPanelDisclosure;

type
  TMedpUnimPanelDownload = class(TMedpUnimPanelDisclosure)
  private
    { Private declarations }
  protected
    procedure LoadCompleted; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('uniGUI Medp Mobile', [TMedpUnimPanelDownload]);
end;

{ TMedpUnimPanelDownload }

constructor TMedpUnimPanelDownload.Create(AOwner: TComponent);
begin
  inherited;

  with FlblDisclosureIcon do
  begin
    Caption:='fas fa-file-download';

    LayoutConfig.Height:='45px';
    LayoutConfig.Width:='45px';
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
  end;
end;

procedure TMedpUnimPanelDownload.LoadCompleted;
begin
  inherited;
  FlblDisclosureIcon.JSInterface.JSCall('addCls',['activeClick']);
  FlblDisclosureIcon.JSInterface.JSCall('addCls',['background-blue']);
end;

end.
