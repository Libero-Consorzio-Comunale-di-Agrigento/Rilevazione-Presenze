unit WA126UDataCassaFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompEdit, meIWEdit, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel, meIWLabel,
  WA126UBloccoRiepiloghiDM, WR102UGestTabella, A000UMessaggi, A000UInterfaccia,
  meIWImageFile,medpIWMessageDlg, IWCompGrids, meIWGrid, ActnList,
  System.Actions;

type
  TWA126FDataCassaFM = class(TWR200FBaseFM)
    lblCassaEffettiva: TmeIWLabel;
    edtCassaEffettiva: TmeIWEdit;
    lblCassaRecords: TmeIWLabel;
    edtCassaRecords: TmeIWEdit;
    lblCassaUtilizzata: TmeIWLabel;
    edtCassaUtilizzata: TmeIWEdit;
    actlstNavigatorBarCassa: TActionList;
    actAggiornaCassa: TAction;
    actPrecedenteCassa: TAction;
    actSuccessivoCassa: TAction;
    actEliminaCassa: TAction;
    grdNavigatorBarCassa: TmeIWGrid;
    actAnnullaCassa: TAction;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure actSuccessivoCassaExecute(Sender: TObject);
    procedure actPrecedenteCassaExecute(Sender: TObject);
    procedure actAnnullaCassaExecute(Sender: TObject);
    procedure actEliminaCassaExecute(Sender: TObject);
    procedure actAggiornaCassaExecute(Sender: TObject);
  private
    CassaEffettiva,
    CassaUtilizzata: TDateTime;
    procedure GetUltimaDataCassa;
    procedure imgNavBarClick(Sender: TObject);
    procedure ResultCassaSuccessiva(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultCassaPrecedente(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultAnnullaCassa(Sender: TObject; R: TmeIWModalResult; KI: String);
    procedure ResultEliminaCassa(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
procedure TWA126FDataCassaFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  GetUltimaDataCassa;
  (Self.Owner as TWR102FGestTabella).CreaNavigatorBar(actlstNavigatorBarCassa,grdNavigatorBarCassa,imgNavBarClick);
end;

procedure TWA126FDataCassaFM.actAggiornaCassaExecute(Sender: TObject);
begin
  GetUltimaDataCassa;
end;

procedure TWA126FDataCassaFM.actAnnullaCassaExecute(Sender: TObject);
begin
  if (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.DataCassaPresente then
    MsgBox.WebMessageDlg(A000MSG_A126_DLG_CASSA_PRECEDENTE,mtConfirmation,[mbYes,mbNo],ResultAnnullaCassa,'');
end;

procedure TWA126FDataCassaFM.actEliminaCassaExecute(Sender: TObject);
begin
  with (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW do
  begin
    MsgBox.WebMessageDlg(MessaggioEliminaDataCassa,mtConfirmation,[mbYes,mbNo],ResultEliminaCassa,'');
  end;
end;

procedure TWA126FDataCassaFM.actPrecedenteCassaExecute(Sender: TObject);
begin
  inherited;
  GetUltimaDataCassa;
  if CassaEffettiva >= CassaUtilizzata then
  begin
    MsgBox.WebMessageDlg(A000MSG_A126_ERR_DATA_CASSA_ANTE,mtError,[mbOk],nil,'');
    Exit;
  end;
  MsgBox.WebMessageDlg(A000MSG_A126_DLG_CASSA_PRECEDENTE,mtConfirmation,[mbYes,mbNo],ResultCassaPrecedente,'');
end;

procedure TWA126FDataCassaFM.actSuccessivoCassaExecute(Sender: TObject);
begin
  inherited;
  MsgBox.WebMessageDlg(A000MSG_A126_DLG_CASSA_SUCCESSIVA,mtConfirmation,[mbYes,mbNo],ResultCassaSuccessiva,'');
end;

procedure TWA126FDataCassaFM.GetUltimaDataCassa;
var
  Records: Integer;
  Util: Boolean;
begin
  with (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW do
  begin
    GetCassaEffettiva(CassaEffettiva,Records);
    if Records = 0 then
    begin
      edtCassaEffettiva.Text:='';
      edtCassaRecords.Text:='';
    end
    else
    begin
      edtCassaEffettiva.Text:=FormatDateTime('mmmm yyyy',CassaEffettiva);
      edtCassaRecords.Text:=IntToStr(Records);
    end;

    GetCassaUtilizzata(CassaUtilizzata,Util,CassaEffettiva);
    if Util then
      edtCassaUtilizzata.Text:=FormatDateTime('mmmm yyyy',CassaUtilizzata)
    else
      edtCassaUtilizzata.Text:='';
  end;
end;

procedure TWA126FDataCassaFM.imgNavBarClick(Sender: TObject);
begin
  TAction(actlstNavigatorBarCassa.Actions[TmeIWImageFile(Sender).Tag]).Execute;
end;

procedure TWA126FDataCassaFM.ResultAnnullaCassa(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.AnnullaDataCassa;
    GetUltimaDataCassa;
  end;
end;

procedure TWA126FDataCassaFM.ResultCassaPrecedente(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.DataCassaPrecedente;
    GetUltimaDataCassa;
  end;
end;

procedure TWA126FDataCassaFM.ResultCassaSuccessiva(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.DataCassaSuccessiva(CassaEffettiva);
    GetUltimaDataCassa;
  end;
end;

procedure TWA126FDataCassaFM.ResultEliminaCassa(Sender: TObject;
  R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
  begin
    (WR302DM as TWA126FBloccoRiepiloghiDM).A126FBloccoRiepiloghiMW.EliminaDataCassa;
    GetUltimaDataCassa;
  end;
end;

end.
