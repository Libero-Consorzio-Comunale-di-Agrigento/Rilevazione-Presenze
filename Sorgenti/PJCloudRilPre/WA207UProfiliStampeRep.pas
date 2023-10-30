unit WA207UProfiliStampeRep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, OracleData,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, Oracle, System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink;

type
  TWA207FProfiliStampeRep = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses
  WA207UProfiliStampeRepBrowseFM, WA207UProfiliStampeRepDettFM, WA207UProfiliStampeRepDM;

{$R *.dfm}

{ TWA207FProfiliStampeRep }

function TWA207FProfiliStampeRep.InizializzaAccesso: Boolean;
var Codice: String;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  if Codice <> '' then
    WR302DM.selTabella.SearchRecord('CODICE',Codice,[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA207FProfiliStampeRep.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA207FProfiliStampeRepDM.Create(Self);
  WBrowseFM:=TWA207FProfiliStampeRepBrowseFM.Create(Self);
  WDettaglioFM:=TWA207FProfiliStampeRepDettFM.Create(Self);
  CreaTabDefault;
end;

end.
