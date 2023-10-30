unit WA205USquadre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, Oracle,
  System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  medpIWTabControl, IWCompLabel, meIWLabel, medpIWStatusBar, IWCompEdit,
  meIWEdit, IWCompGrids, meIWGrid, IWCompButton, meIWButton, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, medpIWDBGrid,
  C190FunzioniGeneraliWeb, StrUtils, A000UCostanti, OracleData;

type
  TWA205FSquadre = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    { Private declarations }
    CodeAC: String;
    procedure ImpostaTestoJQ(NomeComponente:String);
  public
    { Public declarations }
    function InizializzaAccesso:Boolean; override;
    procedure CaricaJQAutocomplete(Griglia:TmedpIWDBGrid;r:Integer);
    procedure AbilitaJqAutocomplete(Val:Boolean);
  end;

implementation

uses WA205USquadreDM, WA205USquadreBrowseFM, WA205USquadreDettFM, WA205UAreeSquadreFM;

{$R *.dfm}

function TWA205FSquadre.InizializzaAccesso;
begin
  Result:=False;
  WR302DM.selTabella.SearchRecord('CODICE',GetParam('CODICE'),[srFromBeginning]);
  WBrowseFM.grdTabella.medpAggiornaCDS(True);
  AggiornaRecord;
  Result:=True;
end;

procedure TWA205FSquadre.IWAppFormCreate(Sender: TObject);
var Detail:TWA205FAreeSquadreFM;
begin
  inherited;
  WR302DM:=TWA205FSquadreDM.Create(Self);
  WBrowseFM:=TWA205FSquadreBrowseFM.Create(Self);
  WDettaglioFM:=TWA205FSquadreDettFM.Create(Self);
  Detail:=TWA205FAreeSquadreFM.Create(Self);
  AggiungiDetail(Detail);
  TWA205FSquadreDM(WR302DM).A205MW.selT603AfterScroll;
  Detail.CaricaDettaglio(TWA205FSquadreDM(WR302DM).A205MW.selT651,TWA205FSquadreDM(WR302DM).A205MW.dsrT651);
  CreaTabDefault;
end;

procedure TWA205FSquadre.CaricaJQAutocomplete(Griglia:TmedpIWDBGrid;r:Integer);
var i:Integer;
begin
  CodeAC:='';
  jQAutocomplete.Enabled:=True;
  jQAutocomplete.OnReady.Clear;
  with Griglia,medpDataSet do
    for i:=0 to FieldCount - 1 do
      if Fields[i].FieldName = 'CODICE_OPERATORE' then
        if medpCompCella(r,medpIndexColonna(Fields[i].FieldName),0) <> nil then
          if medpCompCella(r,medpIndexColonna(Fields[i].FieldName),0) is TmeIWEdit then
            ImpostaTestoJQ((medpCompCella(r,medpIndexColonna(Fields[i].FieldName),0) as TmeIWEdit).HTMLName);
  jQAutocomplete.OnReady.Add(CodeAC);
end;

procedure TWA205FSquadre.ImpostaTestoJQ(NomeComponente:String);
var Elementi:String;
    Lista:TStringList;
    i:Integer;
begin
  Lista:=TStringList.Create;
  Lista.StrictDelimiter:=True;
  with TWA205FSquadreDM(WR302DM).A205MW.selT430 do
  begin
    First;
    while not Eof do
    begin
      Lista.Add(FieldByName('TIPOOPE').AsString);
      Next;
    end;
  end;
  if Lista.Count > 0 then
  begin
    (*//Non usare perché non mantiene le virgole interne al testo delle singole opzioni:
    Elementi:='''' + StringReplace(C190EscapeJS(Lista.CommaText),',',''',''',[rfReplaceAll]) + '''';
    //Eventuale work-around in aggiunta, che però lascerebbe sempre "sporca" la StringList...
    Elementi:=StringReplace(Elementi,'#comma-to-save#',',',[rfReplaceAll]);
    //...dato che in CaricaListaValori bisognerebbe prevedere:
    Valore:=StringReplace(Valore,',','#comma-to-save#',[rfReplaceAll]);*)

    //Ciclo su Lista per mantenere le virgole interne al testo delle singole opzioni:
    for i:=0 to Lista.Count - 1 do
      Elementi:=Elementi + IfThen(Elementi <> '',''',''') + C190EscapeJS(Lista[i]);
    Elementi:='''' + Elementi + '''';
    CodeAC:=CodeAC + CRLF +
            'var elementi = [' + Elementi + ']; ' + CRLF +
            '$("#' + NomeComponente + '").autocomplete({ ' + CRLF +
            '  source: elementi, ' + CRLF +
            '  delay: 0,' + CRLF +
            '  minLength: 0' + CRLF +
            '}).focus(function(){ ' + CRLF +
            '  $(this).data("ui-autocomplete").search(""); ' + CRLF +
            '}); ';
  end;
  FreeAndNil(Lista);
end;

procedure TWA205FSquadre.AbilitaJqAutocomplete(Val:Boolean);
begin
  jQAutocomplete.OnReady.Clear;
  jQAutocomplete.OnReady.Add(IfThen(Val,CodeAC));
end;

end.
