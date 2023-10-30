unit WM000UFrameForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm;

type
  TWM000FFrameForm = class(TUnimForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function WM000FFrameForm: TWM000FFrameForm;

implementation

{$R *.dfm}

uses
  WM000UMainModule, uniGUIApplication;

function WM000FFrameForm: TWM000FFrameForm;
begin
  Result := TWM000FFrameForm(WM000FMainModule.GetFormInstance(TWM000FFrameForm));
end;

end.
