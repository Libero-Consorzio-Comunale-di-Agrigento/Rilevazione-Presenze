unit WA172USchedeQuantObiettiviFM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR200UBaseFM, IWCompJQueryWidget,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, WR100UBase, IWCompEdit,
  IWDBStdCtrls, meIWDBEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, WA172USchedeQuantIndividualiDM,
  IWCompButton, meIWButton, meIWEdit, System.Actions, Vcl.ActnList, IWCompGrids,
  meIWGrid, WR102UGestTabella, DB, meIWImageFile, OracleData, IWCompMemo,
  meIWDBMemo, medpIWMessageDlg, A000UInterfaccia, A000UMessaggi;

type
  TWA172FSchedeQuantObiettiviFM = class(TWR200FBaseFM)
    lblAnno: TmeIWLabel;
    dedtAnno: TmeIWDBEdit;
    btnChiudi: TmeIWButton;
    lblTipoStampa: TmeIWLabel;
    edtTipoStampa: TmeIWEdit;
    actlstNavigatorBar: TActionList;
    actNuovo: TAction;
    actModifica: TAction;
    actElimina: TAction;
    actAnnulla: TAction;
    actConferma: TAction;
    grdNavigatorBar: TmeIWGrid;
    dmemObiettivo1: TmeIWDBMemo;
    dmemObiettivo2: TmeIWDBMemo;
    dmemObiettivo3: TmeIWDBMemo;
    dmemObiettivo4: TmeIWDBMemo;
    lblObiettivo1: TmeIWLabel;
    lblObiettivo2: TmeIWLabel;
    lblObiettivo3: TmeIWLabel;
    lblObiettivo4: TmeIWLabel;
    lblPeso1: TmeIWLabel;
    lblPeso2: TmeIWLabel;
    lblPeso3: TmeIWLabel;
    lblPeso4: TmeIWLabel;
    dedtPeso1: TmeIWDBEdit;
    dedtPeso2: TmeIWDBEdit;
    dedtPeso3: TmeIWDBEdit;
    dedtPeso4: TmeIWDBEdit;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure btnChiudiClick(Sender: TObject);
    procedure actModificaExecute(Sender: TObject);
    procedure actAnnullaExecute(Sender: TObject);
    procedure actNuovoExecute(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  private
    procedure imgNavBarClick(Sender: TObject);
    procedure selSG715StateChange(DataSet: TDataset);
    procedure AbilitaComponenti;
    procedure ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    procedure ReleaseOggetti; override;
    procedure Visualizza(TipoStampaQuant: String);
  end;

implementation

{$R *.dfm}

procedure TWA172FSchedeQuantObiettiviFM.actAnnullaExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.selSG715.Cancel;
end;

procedure TWA172FSchedeQuantObiettiviFM.actConfermaExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.selSG715.Post;
end;

procedure TWA172FSchedeQuantObiettiviFM.actEliminaExecute(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(A000MSG_DLG_CANCELLAZIONE,mtConfirmation,[mbYes,mbNo],ResultDelete,'')
end;

procedure TWA172FSchedeQuantObiettiviFM.ResultDelete(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    with (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW do
    begin
      selSG715.Delete;
      //Richiamo per impostare correttamente le action
      selSG715StateChange(selSG715);
    end;
  end;
end;

procedure TWA172FSchedeQuantObiettiviFM.actModificaExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.selSG715.Edit;
end;

procedure TWA172FSchedeQuantObiettiviFM.actNuovoExecute(Sender: TObject);
begin
  inherited;
  (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.selSG715.Insert;
end;

procedure TWA172FSchedeQuantObiettiviFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA172FSchedeQuantIndividualiDM) do
  begin
    OnSelSG715StateChange:=selSG715StateChange;
    dedtAnno.DataSource:=dsrSG715;
    dmemObiettivo1.DataSource:=dsrSG715;
    dmemObiettivo2.DataSource:=dsrSG715;
    dmemObiettivo3.DataSource:=dsrSG715;
    dmemObiettivo4.DataSource:=dsrSG715;
    dedtPeso1.DataSource:=dsrSG715;
    dedtPeso2.DataSource:=dsrSG715;
    dedtPeso3.DataSource:=dsrSG715;
    dedtPeso4.DataSource:=dsrSG715;

    (Self.Owner as TWR102FGestTabella).CreaNavigatorBar(actlstNavigatorBar,grdNavigatorBar,imgNavBarClick);
  end;
end;

procedure TWA172FSchedeQuantObiettiviFM.imgNavBarClick(Sender: TObject);
begin
  TAction(actlstNavigatorBar.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA172FSchedeQuantObiettiviFM.AbilitaComponenti;
var
  bEdit: Boolean;
begin
  with (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW do
    bEdit:=selSG715.State in [dsInsert,dsEdit];

  if bEdit then
  begin
    dedtAnno.Enabled:=False;
    edtTipoStampa.Enabled:=False;
    dmemObiettivo4.Enabled:=False;
  end;

  btnChiudi.Enabled:=True;
end;

procedure TWA172FSchedeQuantObiettiviFM.selSG715StateChange(DataSet: TDataset);
var
  Browse:Boolean;
begin
  Browse:=not (DataSet.State in [dsInsert,dsEdit]);

  AbilitaComponentiRegion(IWFrameRegion,(Dataset as TOracleDataset));
  AbilitaComponenti;
  actElimina.Enabled:=Browse and not(Self.Owner as TWR102FGestTabella).SolaLettura;
  actNuovo.Enabled:=actElimina.Enabled;
  actModifica.Enabled:=actElimina.Enabled;

  if actNuovo.Enabled then
  begin
    if (edtTipoStampa.Text = '') or (DataSet.RecordCount > 0) then
      actNuovo.Enabled:=False;
  end;

  if actModifica.Enabled then
  begin
    if (edtTipoStampa.Text = '') then
    begin
      actModifica.Enabled:=False;
      actElimina.Enabled:=False;
    end;
  end;

  actConferma.Enabled:=not Browse;
  actAnnulla.Enabled:=not Browse;

  (Self.Owner as TWR102FGestTabella).AggiornaToolBar(grdNavigatorBar,actlstNavigatorBar);
end;

procedure TWA172FSchedeQuantObiettiviFM.Visualizza(TipoStampaQuant: String);
begin
  edtTipoStampa.Text:='';
  if TipoStampaQuant = '1' then
    edtTipoStampa.Text:='1 - Scheda posizionati sanitari'
  else if TipoStampaQuant = '2' then
    edtTipoStampa.Text:='2 - Scheda posizionati amm./tecnici';

  //Richiamo per impostare correttamente le action
  selSG715StateChange((WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW.selSG715);
  (Self.Parent as TWR100FBase).VisualizzaJQMessaggio(jQuery,600,-1,450,'Obiettivi schede dei posizionati','#' + Self.Name,False,True);
end;

procedure TWA172FSchedeQuantObiettiviFM.btnChiudiClick(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA172FSchedeQuantIndividualiDM).A172FSchedeQuantIndividualiMW do
  begin
    if selSG715.State <> dsBrowse then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_MODIFICHE_PENDING,mtInformation,[mbOk],nil,'');
      Exit;
    end;
  end;
  ReleaseOggetti;
  Free;
end;

procedure TWA172FSchedeQuantObiettiviFM.ReleaseOggetti;
begin
  with (WR302DM as TWA172FSchedeQuantIndividualiDM) do
  begin
    OnSelSG715StateChange:=nil;
  end;
  inherited;
end;

end.
