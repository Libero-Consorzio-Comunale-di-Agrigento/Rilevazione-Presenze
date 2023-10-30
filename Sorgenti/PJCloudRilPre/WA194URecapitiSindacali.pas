unit WA194URecapitiSindacali;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton, OracleData,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, meIWImageFile;

type
  TWA194FRecapitiSindacali = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA194URecapitiSindacaliDM, WA194URecapitiSindacaliBrowseFM, WA194URecapitiSindacaliDettFM;

{$R *.dfm}

function TWA194FRecapitiSindacali.InizializzaAccesso: Boolean;
var Codice, Tipo, Progr: String;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  Tipo:=GetParam('TIPO_RECAPITO');
  Progr:=GetParam('PROG_RECAPITO');
  if Trim(Codice) <> '' then
  begin
    (WR302DM as TWA194FRecapitiSindacaliDM).Sindacato:=Codice;
    with WR302DM.SelTabella do
    begin
      Close;
      SetVariable('CODICE',Codice);
      Open;
      SearchRecord('CODICE;TIPO_RECAPITO;PROG_RECAPITO',VarArrayOf([Codice,Tipo,Progr]),[srFromBeginning]);
    end;
    WBrowseFM.grdTabella.medpAggiornaCDS(True);
  end;
  Result:=True;
end;

procedure TWA194FRecapitiSindacali.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA194FRecapitiSindacaliDM.Create(Self);
  WBrowseFM:=TWA194FRecapitiSindacaliBrowseFM.Create(Self);
  WDettaglioFM:=TWA194FRecapitiSindacaliDettFM.Create(Self);
  CreaTabDefault;
  actVisioneCorrenteExecute(nil);
end;

end.
