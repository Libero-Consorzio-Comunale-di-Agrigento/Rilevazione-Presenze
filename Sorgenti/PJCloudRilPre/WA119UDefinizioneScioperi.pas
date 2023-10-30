unit WA119UDefinizioneScioperi;

interface

uses
  WR102UGestTabella, WR103UGestMasterDetail, WA119URichiesteFM,
  System.Actions, IWBaseComponent, System.SysUtils, System.Variants,
  System.Classes, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, medpIWC700NavigatorBar, Data.DB, OracleData,
  Vcl.ActnList, Vcl.Controls;

type
  TWA119FDefinizioneScioperi = class(TWR103FGestMasterDetail)
    procedure IWAppFormCreate(Sender: TObject);
  private
    procedure ResultWC700(Sender: TObject; Result: Boolean);
  protected
    procedure ImpostazioniWC700; override;
  public
    WA119FRichiesteFM: TWA119FRichiesteFM;
    function  InizializzaAccesso:Boolean; override;
  end;

implementation

uses WA119UDefinizioneScioperiDM,
     WA119UDefinizioneScioperiBrowseFM,
     WA119UDefinizioneScioperiDettFM;

{$R *.dfm}

{ TWA119FScioperi }

function TWA119FDefinizioneScioperi.InizializzaAccesso: Boolean;
var
  LId: Integer;
begin
  Result:=True;
  if TryStrToInt(GetParam('ID'),LId) then
  begin
    WR302DM.selTabella.SearchRecord('ID',LId,[srFromBeginning]);
    WBrowseFM.grdTabella.medpAggiornaCDS;
  end;
end;

procedure TWA119FDefinizioneScioperi.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  // nasconde l'azione di "copia su"
  actCopiaSu.Visible:=False;

  WR302DM:=TWA119FDefinizioneScioperiDM.Create(Self);
  WBrowseFM:=TWA119FDefinizioneScioperiBrowseFM.Create(Self);
  WDettaglioFM:=TWA119FDefinizioneScioperiDettFM.Create(Self);

  WA119FRichiesteFM:=TWA119FRichiesteFM.Create(Self);

  WR100LinkWC700:=False;
  AttivaGestioneC700;

  CreaTabDefault;

  // prepara la parte di detail
  AggiungiDetail(WA119FRichiesteFM);
  WA119FRichiesteFM.CaricaDettaglio((WR302DM as TWA119FDefinizioneScioperiDM).A119MW.selT251,
                                    (WR302DM as TWA119FDefinizioneScioperiDM).A119MW.dsrT251);
  WA119FRichiesteFM.PreparaComponenti;
  AggiornaDetails;
end;

procedure TWA119FDefinizioneScioperi.ImpostazioniWC700;
begin
  grdC700.AttivaBrowse:=False;
  grdC700.AttivaEredita:=False;
  grdC700.ImpostaProgressivoCorrente:=False;
  grdC700.WC700FM.ResultEvent:=ResultWC700;
end;

procedure TWA119FDefinizioneScioperi.ResultWC700(Sender: TObject; Result: Boolean);
var S:String;
  function TrasformaV430(X:String):String;
  var Apice:Boolean;
      i:Integer;
  begin
    Result:='';
    i:=1;
    Apice:=False;
    while i <= Length(X) do
    begin
      if X[i] = '''' then
        Apice:=not Apice;
      if (not Apice) and (Copy(X,i,5) = 'V430.') then
      begin
        X:=Copy(X,1,i - 1) + Copy(X,i + 5,4) + '.' + Copy(X,i + 9,Length(X));
        inc(i,5);
      end;
      inc(i);
    end;
    Result:=Trim(X);
  end;
begin
  if Result and (WR302DM.selTabella.State in [dsEdit,dsInsert]) then
  begin
    grdC700.WC700FM.SQLCreato.Text.Trim;
    if Pos('ORDER BY',UpperCase(S)) > 0 then
      S:=Copy(S,1,Pos('ORDER BY',UpperCase(S)) - 1);
    WR302DM.selTabella.FieldByName('SELEZIONE_ANAGRAFICA').AsString:=TrasformaV430(S);
  end;
end;

end.
