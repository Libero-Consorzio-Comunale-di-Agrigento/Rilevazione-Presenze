unit WA097UProfiloFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent, Math,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWCompLabel, meIWLabel, IWCompButton, meIWButton,
  IWCompEdit, medpIWMultiColumnComboBox, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, IWCompCheckbox,
  meIWCheckBox, A000UInterfaccia, A000UCostanti, IWCompExtCtrls, meIWImageFile,
  medpIWImageButton, WR100UBase, A000UMessaggi, C180FunzioniGenerali, StrUtils,
  medpIWMessageDlg;

type
  TWA097FProfiloFM = class(TWR200FBaseFM)
    lnkProfilo: TmeIWLink;
    cmbProfilo: TMedpIWMultiColumnComboBox;
    btnInserisci: TmeIWButton;
    btnCancella: TmeIWButton;
    lblProfilo: TmeIWLabel;
    chkFestivi: TmeIWCheckBox;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure lnkProfiloClick(Sender: TObject);
    procedure cmbProfiloChange(Sender: TObject; Index: Integer);
    procedure btnInserisciClick(Sender: TObject);
  private
    procedure evtRichiesta(Msg,Chiave:String);
    procedure ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
  end;

implementation

uses WA097UPianifLibProf, WA097UPianifLibProfDM;

{$R *.dfm}

procedure TWA097FProfiloFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  with (WR302DM as TWA097FPianifLibProfDM).A097MW do
  begin
    Q310.First;
    while not Q310.Eof do
    begin
      cmbProfilo.AddRow(Q310.FieldByName('CODICE').AsString + ';' + Q310.FieldByName('DESCRIZIONE').AsString);
      Q310.Next;
    end;
    Q310.First;
  end;
  lblProfilo.Caption:='';
end;

procedure TWA097FProfiloFM.lnkProfiloClick(Sender: TObject);
begin
  inherited;
  (Self.Parent as TWR100FBase).AccediForm(150,'CODICE=' + cmbProfilo.Text);
end;

procedure TWA097FProfiloFM.cmbProfiloChange(Sender: TObject; Index: Integer);
begin
  lblProfilo.Caption:=VarToStr((WR302DM as TWA097FPianifLibProfDM).A097MW.Q310.Lookup('CODICE',cmbProfilo.Text,'DESCRIZIONE'));
end;

procedure TWA097FProfiloFM.btnInserisciClick(Sender: TObject);
begin
  with (WR302DM as TWA097FPianifLibProfDM).A097MW do
  begin
    if Dal > Al then
      raise Exception.Create(A000MSG_ERR_DATE_INVERTITE);
    if (Al - Dal) > (R180AddMesi(Dal,(12 * 5)) - Dal) then
      raise Exception.Create(A000MSG_A097_ERR_PERIODO_LUNGO);
    if VarToStr(Q310.Lookup('CODICE',cmbProfilo.Text,'CODICE')) = '' then
      raise Exception.create(A000MSG_A097_ERR_PROFILO_NON_VALIDO);
  end;
  (Self.Parent as TWA097FPianifLibProf).ProceduraChiamante:=IfThen(Sender = btnInserisci,0,1);
  evtRichiesta(Format(A000MSG_A097_DLG_FMT_CONFERMA,[IfThen(Sender = btnInserisci,'l''inserimento','la cancellazione'),(Self.Parent as TWA097FPianifLibProf).edtDataDa.Text,(Self.Parent as TWA097FPianifLibProf).edtDataA.Text]),'RichiestaConferma');
  (Self.Parent as TWR100FBase).StartElaborazioneCiclo((Sender as TmeIWButton).HTMLName);
end;

procedure TWA097FProfiloFM.evtRichiesta(Msg,Chiave:String);
begin
  if not MsgBox.KeyExists(Chiave) then
  begin
    MsgBox.WebMessageDlg(Msg,mtConfirmation,[mbYes,mbNo],ResultEvtRichiesta,Chiave);
    Abort;
  end;
end;

procedure TWA097FProfiloFM.ResultEvtRichiesta(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  if R = mrYes then
    case (Self.Parent as TWA097FPianifLibProf).ProceduraChiamante of
      0: btnInserisciClick(btnInserisci);
      1: btnInserisciClick(btnCancella);
    end
  else
    MsgBox.ClearKeys;
end;

end.
