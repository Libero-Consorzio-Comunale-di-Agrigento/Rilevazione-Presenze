unit WA187UAccessiSessioniFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR203UGestDetailFM, ActnList, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWDBGrids, medpIWDBGrid, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, meIWGrid,
  IWVCLBaseContainer, IWContainer, IWHTMLContainer, IWHTML40Container, IWRegion,
  C190FunzioniGeneraliWeb, meIWComboBox, C180FunzioniGenerali, meIWEdit, Db,
  Oracle, OracleData, A000UInterfaccia, A000UCostanti, A000USessione, medpIWMessageDlg,
  IWCompJQueryWidget, IWCompGrids,A000UMessaggi;

type
  TWA187FAccessiSessioniFM = class(TWR203FGestDetailFM)
    actKillSingola: TAction;
    actKillMultipla: TAction;
    procedure actKillSingolaExecute(Sender: TObject);
    procedure actKillMultiplaExecute(Sender: TObject);
    //procedure actAggiornaExecute(Sender: TObject);
  private
    procedure ResultKillSingola(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultKillMultipla(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    { Public declarations }
  end;

implementation

uses WA187UAccessiDM, WA187UAccessi, WR100UBase;

{$R *.dfm}
{
procedure TWA187FAccessiSessioniFM.actAggiornaExecute(Sender: TObject);
begin
  grdTabella.medpDataSet.Refresh;
  grdTabella.medpAggiornaCDS;
end;
}
procedure TWA187FAccessiSessioniFM.actKillSingolaExecute(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_A187_DLG_TERMINA_SESS,mtConfirmation,[mbYes,mbNo],ResultKillSingola,'');
end;

procedure TWA187FAccessiSessioniFM.ResultKillSingola(Sender: TObject; R: TmeIWModalResult; KI: String);
var oper: Integer;
begin
  if R = mrYes then
  begin
    with TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM).OperSQL do
    begin
      SQL.Clear;
      SQL.Add(Format('ALTER SYSTEM KILL SESSION ''%d,%d''',[TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM).selVSESSION.FieldByName('SID').AsInteger,TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM).selVSESSION.FieldByName('SERIAL#').AsInteger]));
      try Execute; except end;
      SessioneOracle.Commit;
      oper:=TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM).dsrVSESSION.DataSet.FieldByName('SID').AsInteger;
      TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM).dsrVSESSION.DataSet.Refresh;
      TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM).selVSESSION.SearchRecord('SID',oper,[srFromBeginning]);
    end;
  end;
end;

procedure TWA187FAccessiSessioniFM.actKillMultiplaExecute(Sender: TObject);
begin
  MsgBox.WebMessageDlg(A000MSG_A187_DLG_TERMINA_ALL_SESS,mtConfirmation,[mbYes,mbNo],ResultKillMultipla,'');
end;

procedure TWA187FAccessiSessioniFM.ResultKillMultipla(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    with TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM) do
    begin
      selVSESSION.First;
      selVSESSION.DisableControls;
      while not selVSESSION.Eof do
      begin
        OperSQL.SQL.Clear;
        OperSQL.SQL.Add(Format('ALTER SYSTEM KILL SESSION ''%d,%d''',[selVSESSION.FieldByName('SID').AsInteger,selVSESSION.FieldByName('SERIAL#').AsInteger]));
        try OperSQL.Execute; except end;
        selVSESSION.Next;
      end;
      TWA187FAccessiDM(TWA187FAccessi(Self.Parent).WR302DM).dsrVSESSION.DataSet.Refresh;
      selVSESSION.First;
      selVSESSION.EnableControls;
    end;
  end;
end;

end.
