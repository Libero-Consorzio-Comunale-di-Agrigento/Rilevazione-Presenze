unit WP652UINPDAPMMRegole;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls,
  meIWLink, WP652UINPDAPMMRegoleDM, WP652UINPDAPMMRegoleBrowseFM,
  WP652UINPDAPMMRegoleDettFM, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, meIWRegion, A000UMessaggi, Data.DB,
  A000UCostanti;

type
  TWP652FINPDAPMMRegole = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actAggiornaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    NomeFlusso: String;
    function  InizializzaAccesso:Boolean; override;
    procedure selTabellaStateChange(DataSet: TDataSet); override;
  end;

implementation

{$R *.dfm}

procedure TWP652FINPDAPMMRegole.IWAppFormCreate(Sender: TObject);
begin
  actCopiaSu.Visible:=False;
  actNuovo.Visible:=False;
  actElimina.Visible:=False;
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=true;
end;

function TWP652FINPDAPMMRegole.InizializzaAccesso: Boolean;
var
  sTag: String;
begin
  sTag:=GetParam('TAG');
  if sTag <> '' then
    SetTag(StrToInt(sTag))
  else
    SetTag(571); //per test
  Title:=Format('(%s) %s',[medpCodiceForm,medpNomeFunzione]);

  NomeFlusso:=GetParam('FLUSSO');
  if NomeFlusso = '' then
    NomeFlusso:=FLUSSO_FLUPER; //per TEST;

  if NomeFlusso = FLUSSO_INPDAP then
    HelpKeyword:=Format('%sP0',[medpCodiceForm])
  else if NomeFlusso = FLUSSO_FLUPER then
    HelpKeyword:=Format('%sP1',[medpCodiceForm])
  else
    HelpKeyword:=Format('%sP2',[medpCodiceForm]);

  WR302DM:=TWP652FINPDAPMMRegoleDM.Create(Self);
  WBrowseFM:=TWP652FINPDAPMMRegoleBrowseFM.Create(Self);
  WDettaglioFM:=TWP652FINPDAPMMRegoleDettFM.Create(Self);
  actVisioneCorrenteExecute(nil);
  CreaTabDefault;
  AggiornaToolBarStorico(False, False, False, False, False, False);
  Result:=True;
end;

procedure TWP652FINPDAPMMRegole.selTabellaStateChange(DataSet: TDataSet);
begin
  inherited;
  AggiornaToolBarStorico(False,False, False, False, False, False);
end;

procedure TWP652FINPDAPMMRegole.actAggiornaExecute(Sender: TObject);
begin
  if NomeFlusso = FLUSSO_FLUPER then
  begin
    with (WR302DM as TWP652FINPDAPMMRegoleDM).P652FINPDAPMMRegoleMW do
    begin
      v430.Close;
      v430.Open;
    end;
  end;
  inherited;
end;

procedure TWP652FINPDAPMMRegole.actModificaExecute(Sender: TObject);
begin
  if (WR302DM.selTabella.FieldByName('REGOLA_MODIFICABILE').AsString <> 'S') then
    raise Exception.Create(A000MSG_P652_ERR_NO_MODIFICA);
  inherited;
end;

end.
