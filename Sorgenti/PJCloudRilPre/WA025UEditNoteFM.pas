unit WA025UEditNoteFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompMemo,
  meIWMemo;

type
  TWA025FEditNoteFM = class(TWR200FBaseFM)
    mmNote: TmeIWMemo;
    btnOK: TmeIWButton;
    btnAnnulla: TmeIWButton;
    procedure btnAnnullaClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RigaEdit:integer;
    procedure Visualizza(TestoNota:string);
  end;

implementation

uses
  WR100UBase, WR102UGestTabella, meIWLabel;

{$R *.dfm}

procedure TWA025FEditNoteFM.btnAnnullaClick(Sender: TObject);
begin
  inherited;
  FreeAndNil(Self);
end;

procedure TWA025FEditNoteFM.btnOKClick(Sender: TObject);
var
  lblNote:TmeIWLabel;
begin
  inherited;
  (Self.Parent as TWR102FGesttabella).WR302DM.selTabella.FieldByName('NOTE').AsString:=mmNote.lines.Text;
  lblNote:=((Self.Parent as TWR102FGesttabella).WBrowseFM.grdTabella.medpCompCella(RigaEdit,'NOTE',0) as TmeIWLabel);
  lblNote.Caption:=mmNote.lines.Text;
  FreeAndNil(Self);
end;

procedure TWA025FEditNoteFM.Visualizza(TestoNota:string);
begin
  mmNote.lines.Text:=TestoNota;
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,440,180,180, 'Note','#WA025FEditNoteFM',False,True);
end;

end.
