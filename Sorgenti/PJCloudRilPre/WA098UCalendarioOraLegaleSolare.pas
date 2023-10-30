unit WA098UCalendarioOraLegaleSolare;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink,
  WA098UCalendarioOraLegaleSolareDM, WA098UCalendarioOraLegaleSolareBrowseFM;

type
  TWA098FCalendarioOraLegaleSolare = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function InizializzaAccesso:boolean; override;
  end;

implementation

{$R *.dfm}

function TWA098FCalendarioOraLegaleSolare.InizializzaAccesso:Boolean;
begin
  //Inizializzazione
  Result:=True;
end;

procedure TWA098FCalendarioOraLegaleSolare.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  actCopiaSu.Visible:=False;
  InterfacciaWR102.DettaglioFM:=False;
  WR302DM:=TWA098FCalendarioOralegaleSolareDM.Create(Self);
  WBrowseFM:=TWA098FCalendarioOralegaleSolareBrowseFM.Create(Self);
  CreaTabDefault;
end;

end.
