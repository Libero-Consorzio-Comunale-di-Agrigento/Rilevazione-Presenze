unit WA163UTipoQuote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, OracleData,A000UInterfaccia;

type
  TWA163FTipoQuote = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA163UTipoQuoteDM, WA163UTipoQuoteBrowseFM, WA163UTipoQuoteDettFM;

{$R *.dfm}

procedure TWA163FTipoQuote.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA163FTipoQuoteDM.Create(Self);
  WBrowseFM:=TWA163FTipoQuoteBrowseFM.Create(Self);
  WDettaglioFM:=TWA163FTipoQuoteDettFM.Create(Self);

  CreaTabDefault;
end;

function TWA163FTipoQuote.InizializzaAccesso: Boolean;
var
  Codice: string;
  Decorrenza: TDateTime;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  if Codice <> '' then
  begin
    if not TryStrToDate(getParam('DECORRENZA'),Decorrenza) then
      Decorrenza:=Parametri.DataLavoro;
    WR302DM.selTabella.SearchRecord('CODICE',Codice,[srFromBeginning]);
    CercaStoricoCorrente(Decorrenza);
  end;
  Result:=True;
end;

end.
