unit WA020UCausPresenze;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  OracleData, Dialogs, WR102UGestTabella, ActnList, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  IWCompButton, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl,
  IWHTMLControls, meIWLink, System.Actions, IWCompEdit, meIWEdit;

type
  TWA020FCausPresenze = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actCopiaSuExecute(Sender: TObject);
  private
    IDSorgente:Integer; // Usato dopo la copia tramite "Copia su"
    procedure CreaCopiaParamStoriciz;
  public
    function InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA020UCausPresenzeDM, WA020UCausPresenzeBrowseFM, WA020UCausPresenzeDettFM;

{$R *.dfm}

procedure TWA020FCausPresenze.actCopiaSuExecute(Sender: TObject);
begin
  IDSorgente:=WR302DM.selTabella.FieldByName('ID').AsInteger;
  inherited;
end;

function TWA020FCausPresenze.InizializzaAccesso: Boolean;
var Codice: String;
begin
  Result:=False;
  Codice:=GetParam('CODICE');
  (WR302DM as TWA020FCausPresenzeDM).selTabella.SearchRecord('CODICE',Codice,[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  Result:=True;
end;

procedure TWA020FCausPresenze.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.CopiaSuOperazioniDopoCopia:=CreaCopiaParamStoriciz;
  WR302DM:=TWA020FCausPresenzeDM.Create(Self);
  WBrowseFM:=TWA020FCausPresenzeBrowseFM.Create(Self);
  WDettaglioFM:=TWA020FCausPresenzeDettFM.Create(Self);
  CreaTabDefault;
end;

procedure TWA020FCausPresenze.CreaCopiaParamStoriciz;
var
  IDDestinazione:Integer;
begin
  { IDSorgente è stato impostato prima del richiamo del frame "Copia su".
    Se stiamo eseguendo questo metodo vuol dire che la copia è stata effettuata correttamente e il
    dataset è stato posizionato sul nuovo elemento.}
  IDDestinazione:=WR302DM.selTabella.FieldByName('ID').AsInteger;
  { Sia il DM che MW storico devono sempre essere instanziati a questo punto.
    Se non lo sono vuol dire che comunque qualcosa non funziona a dovere. }
  try
    (WR302DM as TWA020FCausPresenzeDM).A020StoricoMW.CreaCopiaParametriStorici(IDSorgente,
                                                                               IDDestinazione);
  finally
    // Copia terminata. Possiamo manualmente impostare a False il flag CopiaInCorso
    InterfacciaWR102.CopiaInCorso:=False;
    WR302DM.selTabella.Refresh;
    WR302DM.selTabella.Locate('ID',IDDestinazione,[]);
  end;

end;

end.
