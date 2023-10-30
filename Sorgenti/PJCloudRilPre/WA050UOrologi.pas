unit WA050UOrologi;

interface

uses
  WA050UOrologiBrowseFM, WA050UOrologiDettFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  WA050UOrologiDM, IWCompButton, WR102UGestTabella,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, OracleData,
  IWCompGrids, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, System.Actions, IWCompEdit, meIWEdit, Data.DB,
  IWCompJQueryWidget;

type
  TWA050FOrologi = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
  private
    function  InizializzaAccesso:Boolean; override;
    procedure OnConfermaPosizioneRilevatore(EventParams: TStringList);
  public
  end;

implementation

{$R *.dfm}

function TWA050FOrologi.InizializzaAccesso: Boolean;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA050FOrologi.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA050FOrologiDM.Create(Self);
  WBrowseFM:=TWA050FOrologiBrowseFM.Create(Self);
  WDettaglioFM:=TWA050FOrologiDettFM.Create(Self);
  CreaTabDefault;

  GGetWebApplicationThreadVar.RegisterCallBack('OnConfermaPosizioneRilevatore',OnConfermaPosizioneRilevatore);
end;

procedure TWA050FOrologi.OnConfermaPosizioneRilevatore(EventParams: TStringList);
var
  LLat: double;
  LLng: Double;
  LRaggioValidita: Integer;
  LLatStr: string;
  LLngStr: string;
  LRaggioValiditaStr: String;
  LIndirizzo: string;
  LFmtSettings: TFormatSettings;
begin
  if not (WR302DM.selTabella.State in [dsInsert,dsEdit]) then
    Exit;

  LLatStr:=EventParams.Values['lat'];
  LLngStr:=EventParams.Values['lng'];
  LRaggioValiditaStr:=EventParams.Values['radius'];
  LIndirizzo:=EventParams.Values['address'];

  LFmtSettings:=TFormatSettings.Create;
  LFmtSettings.DecimalSeparator:='.';

  if not TryStrToFloat(LLatStr,LLat,LFmtSettings) then
    GGetWebApplicationThreadVar.ShowMessage(Format('Errore nelle coordinate: latitudine non valida: %s',[LLatStr]));
  if not TryStrToFloat(LLngStr,LLng,LFmtSettings) then
    GGetWebApplicationThreadVar.ShowMessage(Format('Errore nelle coordinate: longitudine non valida: %s',[LLngStr]));
  if not TryStrToInt(LRaggioValiditaStr,LRaggioValidita) then
    GGetWebApplicationThreadVar.ShowMessage(Format('Errore: raggio di validità non valido: %s',[LRaggioValiditaStr]));

  WR302DM.selTabella.FieldByName('LAT').AsFloat:=LLat;
  WR302DM.selTabella.FieldByName('LNG').AsFloat:=LLng;
  WR302DM.selTabella.FieldByName('RAGGIO_VALIDITA').AsInteger:=LRaggioValidita;
  WR302DM.selTabella.FieldByName('INDIRIZZO').AsString:=LIndirizzo;
end;

end.
