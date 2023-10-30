unit WA034UParametriAvanzati;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,WA034UParametriAvanzatiDM,
  WA034UParametriAvanzatiDettFM,WA034UParametriAvanzatiBrowseFM, System.Actions,
  IWCompEdit, meIWEdit;

type
  TWA034FParametriAvanzati = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ImpostaCodiceInterfaccia(Codice: String);
  end;

implementation

{$R *.dfm}


procedure TWA034FParametriAvanzati.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.DettaglioFM:=True;

  InterfacciaWr102.GestioneStoricizzata:=True; //Deve essere fatto prima di creazione DM poichè imposta PK in base a questo attributo
  WR302DM:=TWA034FParametriAvanzatiDM.Create(Self);
  WDettaglioFM:=TWA034FParametriAvanzatiDettFM.Create(Self);
  WBrowseFM:=TWA034FParametriAvanzatiBrowseFM.Create(Self);
  CreaTabDefault;
end;

procedure TWA034FParametriAvanzati.ImpostaCodiceInterfaccia(Codice: String);
begin
  with WR302DM.selTabella do
  begin
    Close;
    SetVariable('CODICE_INTERFACCIA',Codice);
    Open;
  end;
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
end;

end.
