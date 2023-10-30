unit WM000UMessageDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUImClasses, uniGUIForm, uniGUImForm, uniGUImJSForm,
  uniGUIBaseClasses, MedpUnimPanelBase, uniButton, uniBitBtn, unimBitBtn,
  MedpUnimButton, uniLabel, unimLabel, MedpUnimLabel;

//---- NON UTILIZZATO!!!!!!!----------------------------------------------------
//---- NON UTILIZZATO!!!!!!!----------------------------------------------------
//---- NON UTILIZZATO!!!!!!!----------------------------------------------------
//---- NON UTILIZZATO!!!!!!!----------------------------------------------------
type
  TWM000FMessageDlg = class(TUnimForm)
    pnlButtons: TMedpUnimPanelBase;
    Button1: TMedpUnimButton;
    Button2: TMedpUnimButton;
    pnlTitolo: TMedpUnimPanelBase;
    lblTitolo: TMedpUnimLabel;
    pnlTesto: TMedpUnimPanelBase;
    lblTesto: TMedpUnimLabel;
  private
    { Private declarations }
  public
    function ShowModal(PMessage: String):Integer;
  end;

function WM000FMessageDlg: TWM000FMessageDlg;

implementation

{$R *.dfm}

uses
  WM000UMainModule, uniGUIApplication;

function WM000FMessageDlg: TWM000FMessageDlg;
begin
  Result := TWM000FMessageDlg(WM000FMainModule.GetFormInstance(TWM000FMessageDlg));
end;

{ TWM000FMessageDlg }

function TWM000FMessageDlg.ShowModal(PMessage: String): Integer;
begin
  lblTesto.Caption:=PMessage;

  Result:=inherited ShowModal;
end;

end.
