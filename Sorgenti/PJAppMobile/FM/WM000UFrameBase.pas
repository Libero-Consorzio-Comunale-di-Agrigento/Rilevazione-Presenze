unit WM000UFrameBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniGUIBaseClasses, uniGUImJSForm,
  MedpUnimPanelBase, unimPanel;

type
  TOnChangeEvent = procedure(Sender: TObject) of object;

  TWM000FFrameBase = class(TUniFrame)
    MainPanel: TMedpUnimPanelBase;
    procedure UniFrameDestroy(Sender: TObject); virtual;
  private
    FAbilitazioneFunzione: String;
    FOnChange: TOnChangeEvent;
    procedure SetAbilitazioneFunzione(const Value: String);
  published
    property OnChangeAbilitaFunzione: TOnChangeEvent read FOnChange write FOnChange;
  public
    property AbilitazioneFunzione: String read FAbilitazioneFunzione write SetAbilitazioneFunzione;
  end;

implementation

{$R *.dfm}

{ TWM000FFrameBase }

procedure TWM000FFrameBase.SetAbilitazioneFunzione(const Value: String);
begin
  if FAbilitazioneFunzione <> Value then
  begin
    FAbilitazioneFunzione:=Value;

    if Assigned(FOnChange) then
      FOnChange(Self);
  end;
end;

procedure TWM000FFrameBase.UniFrameDestroy(Sender: TObject);
begin
  UniSession.AddJS('aggiornaNotifiche();');
  inherited;
end;

end.
