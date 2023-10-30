unit meIWDBFile;

interface

uses
  SysUtils, Classes, Controls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompEdit, IWDBStdCtrls,
  IWDsnPaint, IWDsnPaintHandlers;

type
  TmeIWDBFile = class(TIWDBFile)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
  end;


implementation

{ TmeIWDBFile }

constructor TmeIWDBFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  with StyleRenderOptions do
  begin
    RenderPadding:=False;
  end;
end;

initialization


end.
