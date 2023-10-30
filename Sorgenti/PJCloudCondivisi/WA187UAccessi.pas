unit WA187UAccessi;

interface

uses
  WA187UAccessiBrowseFM,
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWControl,
  Controls, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWCompEdit, IWHTMLControls, meIWLink,
  ActnList, Menus, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompMenu, IWCompLabel, Variants,
  A000UInterfaccia, A000UCostanti, A000USessione, WR100UBase,
  IWCompTabControl, Forms, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion,
  IWCompButton, WR103UGestMasterDetail,
  IWDBStdCtrls, meIWLabel, WR302UGestTabellaDM, meIWButton, meIWDBNavigator,
  meIWGrid, medpIWTabControl, medpIWStatusBar, C180FunzioniGenerali,
  medpIWMessageDlg, Oracle, OracleData, Db,
  meIWComboBox, IWCompProgressBar, IWBaseComponent,
  IWBaseHTMLComponent, IWBaseHTML40Component, meIWTimer,
  WA187UAccessiSessioniFM, WR102UGestTabella, IWCompGrids,A000UMessaggi,
  IWCompExtCtrls, System.Actions, meIWImageFile, meIWEdit;

type
  TWA187FAccessi = class(TWR103FGestMasterDetail)
    actBloccaAccessi: TAction;
    actSbloccaAccessi: TAction;
    lblAccessoUtenti: TmeIWLabel;
    lblSessioniAttive: TmeIWLabel;
    procedure IWAppFormCreate(Sender: TObject);
    procedure actBloccaAccessiExecute(Sender: TObject);
    procedure actSbloccaAccessiExecute(Sender: TObject);
  private
    procedure ResultBloccaAccessi(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultSbloccaAccessi(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ImpostaAccessoNegato(Valore:String);
  public
  end;

implementation

uses WA187UAccessiDM;

{$R *.dfm}

procedure TWA187FAccessi.IWAppFormCreate(Sender: TObject);
var
  Detail:TWA187FAccessiSessioniFM;
begin
  inherited;
  WR302DM:=TWA187FAccessiDM.Create(Self);

  InterfacciaWR102.DettaglioFM:=False;
  WBrowseFM:=TWA187FAccessiBrowseFM.Create(Self);
  CreaTabDefault;

  try
    Detail:=TWA187FAccessiSessioniFM.Create(Self);
    AggiungiDetail(Detail);
    //TWA187FAccessiDM(WR302DM).selVSESSION.SetVariable('ORDERBY','ORDER BY OSUSER,MACHINE,TERMINAL,PROGRAM');
    //TWA187FAccessiDM(WR302DM).selVSESSION.Open;
    Detail.CaricaDettaglio(TWA187FAccessiDM(WR302DM).selVSESSION,TWA187FAccessiDM(WR302DM).dsrVSESSION);
  except
    (*
    on E:Exception do
    begin
      MsgBox.WebMessageDlg(Format(A000MSG_A187_ERR_FMT_V_SESSION,[E.Message]),mtInformation,[mbOK],nil,'');
      lblSessioniAttive.Visible:=False;
    end;
    *)
  end;
end;

procedure TWA187FAccessi.actBloccaAccessiExecute(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_A187_DLG_BLOCCO,mtConfirmation,[mbYes,mbNo],ResultBloccaAccessi,'');
end;

procedure TWA187FAccessi.ResultBloccaAccessi(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    ImpostaAccessoNegato('S');
end;

procedure TWA187FAccessi.actSbloccaAccessiExecute(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_A187_DLG_SBLOCCO,mtConfirmation,[mbYes,mbNo],ResultSbloccaAccessi,'');
end;

procedure TWA187FAccessi.ResultSbloccaAccessi(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    ImpostaAccessoNegato('N');
end;

procedure TWA187FAccessi.ImpostaAccessoNegato(Valore:String);
var
  RowID:String;
begin
  RowID:=WR302DM.selTabella.RowId;
  with TWA187FAccessiDM(WR302DM).selTabella do
  begin
    First;
    DisableControls;
    while not Eof do
      begin
        Edit;
        FieldByName('ACCESSO_NEGATO').AsString:=Valore;
        Post;
        Next;
      end;
    First;
    EnableControls;
  end;
  WR302DM.selTabella.Locate('ROWID',RowID,[]);
  WBrowseFM.grdTabella.medpAggiornaCDS;
end;

end.
