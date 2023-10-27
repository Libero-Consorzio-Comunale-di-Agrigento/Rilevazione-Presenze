unit WR103UGestMasterDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR102UGestTabella, ActnList, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  medpIWStatusBar, meIWGrid, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, Oracle, OracleData,
  Db, IWCompGrids,A000UMessaggi, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWCompButton, meIWButton,
  System.Actions, meIWImageFile, IWCompEdit, meIWEdit, medpIWDBGrid;

type
  TWR103FGestMasterDetail = class(TWR102FGestTabella)
    grdDetailTabControl: TmedpIWTabControl;
    procedure IWAppFormDestroy(Sender: TObject);
    procedure IWAppFormCreate(Sender: TObject);
    procedure grdDetailTabControlTabControlChange(Sender: TObject);
  private
    Details:array of TControl;
    function GetDetails(i:Integer):TControl;
  protected
  public
    DisabilitaFigliInModifica: Boolean;
    procedure AggiornaDetails;
    procedure AggiungiDetail(DetailFM:TControl; AggiungiTabStandard:Boolean; const Title:String = ''); overload;
    procedure AggiungiDetail(DetailFM:TControl; const Title:String = ''); overload;
    procedure selTabellaStateChange(DataSet: TDataSet); override;
    property DetailFM[i:Integer]:TControl read GetDetails;
    procedure OnTabClosing(var AllowClose: Boolean; var Conferma: String); override;
    function DetailsCount: Integer;
  end;

implementation

uses WR203UGestDetailFM, WR100UBase;

{$R *.dfm}

procedure TWR103FGestMasterDetail.IWAppFormCreate(Sender: TObject);
begin
  DisabilitaFigliInModifica:=True;
  SetLength(Details,0); //Inizializzazione array pannelli dettaglio
  //per mantenere scroll dei pannelli figli
  inherited;
  AddScrollBarManager('divscrollableWR203');
end;

procedure TWR103FGestMasterDetail.AggiungiDetail(DetailFM:TControl; AggiungiTabStandard:Boolean; const Title:String = '');
begin
  SetLength(Details,Length(Details) + 1);
  Details[High(Details)]:=DetailFM;
  if AggiungiTabStandard then
    grdDetailTabControl.AggiungiTab(Title, DetailFM);

  if Length(Details) >= 2 then
    grdDetailTabControl.Visible:=True
  else
    grdDetailTabControl.Visible:=False;

  if AggiungiTabStandard then
    grdDetailTabControl.ActiveTab:=Details[0];
end;

procedure TWR103FGestMasterDetail.AggiungiDetail(DetailFM:TControl; const Title:String = '');
begin
  AggiungiDetail(DetailFM, True, Title);
end;

function TWR103FGestMasterDetail.DetailsCount: Integer;
begin
  Result:=Length(Details);
end;

procedure TWR103FGestMasterDetail.AggiornaDetails;
var i:Integer;
begin
  for i:=0 to Length(Details) - 1 do
    if Details[i] is TWR203FGestDetailFM then
      if (Details[i] as TWR203FGestDetailFM).Relazionato then
        (Details[i] as TWR203FGestDetailFM).AggiornaDettaglio;
end;

function TWR103FGestMasterDetail.GetDetails(i:Integer):TControl;
begin
  if i <= High(Details) then
    Result:=Details[i]
  else
    Result:=nil;
end;

procedure TWR103FGestMasterDetail.grdDetailTabControlTabControlChange(Sender: TObject);
begin
  if not PrimoRender then
  try
    if (grdDetailTabControl.ActiveTab is TWR203FGestDetailFM) and
       (TWR203FGestDetailFM(grdDetailTabControl.ActiveTab).grdTabella.medpDataSet <> nil) and
       (TWR203FGestDetailFM(grdDetailTabControl.ActiveTab).grdTabella.medpDataSet.State = dsBrowse) and
       (TWR203FGestDetailFM(grdDetailTabControl.ActiveTab).grdTabella.medpStato = msBrowse)
    then
      TWR203FGestDetailFM(grdDetailTabControl.ActiveTab).AggiornaDettaglio;
  except
  end;
end;

procedure TWR103FGestMasterDetail.selTabellaStateChange(DataSet: TDataSet);
var
  i:Integer;
  Browse:Boolean;
begin
  inherited;
  if DisabilitaFigliInModifica then
  begin
    Browse:=not (DataSet.State in [dsInsert,dsEdit]);
    AbilitaToolBar(grdDetailTabControl,Browse,nil);
    for i:=0 to Length(Details) - 1 do
      if Details[i] is TWR203FGestDetailFM then
      begin
        (Details[i] as TWR203FGestDetailFM).DSMasterState:=DataSet.State;
        AbilitaToolBar((Details[i] as TWR203FGestDetailFM).grdDetailNavBar,Browse,(Details[i] as TWR203FGestDetailFM).actlstDetailNavBar);
        //Caratto 1/8/2012 Devo disabilitare la grid dei pannelli detail se sto modificando la grid padre
        (Details[i] as TWR203FGestDetailFM).grdTabella.medpBrowse:=Browse;
      end;
  end;
end;

procedure TWR103FGestMasterDetail.OnTabClosing(var AllowClose: Boolean;
  var Conferma: String);
var i: Integer;
begin
  //richiama OnTabClosing di wr102
  inherited;

  if AllowClose then  //se passato controllo sulla 102
    if Self is TWR103FGestMasterDetail then
      for i:=0 to Length(TWR103FGestMasterDetail(Self).Details)-1 do
        if TWR103FGestMasterDetail(Self).DetailFM[i] is TWR203FGestDetailFM then
          if (TWR103FGestMasterDetail(Self).DetailFM[i] as TWR203FGestDetailFM).grdTabella.medpDataSet.State in [dsInsert,dsEdit] then
          begin
            AllowClose:=False;
            Conferma:=A000MSG_ERR_MODIFICHE_PENDING;
            Break;
          end;
end;

procedure TWR103FGestMasterDetail.IWAppFormDestroy(Sender: TObject);
begin
  SetLength(Details,0);
  inherited;
end;

end.
