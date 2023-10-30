unit WM000UMainFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, pngimage, uniGUIBaseClasses, uniImage,
  unimImage, jpeg, uniLabel, unimLabel;

type
  TWM000FMainFM = class(TUniFrame)
    UnimLabel1: TUnimLabel;
    procedure UniFrameCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  WM000UServerModule;

{$R *.dfm}

procedure TWM000FMainFM.UniFrameCreate(Sender: TObject);
begin
  UnimLabel1.Caption := 'Powered by uniGUI ' + WM000FServerModule.UniGUIVersion +
                        ' &  Ext JS ' + WM000FServerModule.ExtJSVersion;
end;

initialization
  // workaround per evitare errore di class not found sui frame:
  // attiva il classgroup di uno dei frame (sono tutti uguali)
  ActivateClassGroup(TWM000FMainFM);

end.
