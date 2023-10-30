unit WA006UModelliOrario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Db,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, C180FunzioniGenerali, A000UInterfaccia, System.Actions, meIWImageFile,
  IWCompEdit, meIWEdit, Oracle, A000UCostanti;

type
  TWA006FModelliOrario = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
  public
    function  InizializzaAccesso:Boolean; override;
  end;


implementation

uses
  WA006UModelliOrarioDM,
  A006UMOdelliOrarioMW,
  WA006UModelliOrarioDettFM,
  WA006UModelliOrarioBrowseFM;

{$R *.dfm}

procedure TWA006FModelliOrario.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWA006FModelliOrarioDM.Create(Self);
  WBrowseFM:=TWA006FModelliOrarioBrowseFM.Create(Self);
  WDettaglioFM:=TWA006FModelliOrarioDettFM.Create(Self);
  CercaStoricoCorrente(Parametri.DataLavoro);
  CreaTabDefault;
end;

function TWA006FModelliOrario.InizializzaAccesso: Boolean;
var Codice: String;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  if Codice <> '' then
  begin
    WR302DM.selTabella.Locate('CODICE',Codice,[]);
    CercaStoricoCorrente(Parametri.DataLavoro);
  end;
  Result:=True;
end;

end.
