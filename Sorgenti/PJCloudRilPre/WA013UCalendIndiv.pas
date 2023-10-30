unit WA013UCalendIndiv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR100UBase, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML,
  IWCompButton, medpIWMessageDlg, meIWButton, IWCompGrids, meIWGrid, medpIWStatusBar, IWVCLBaseControl,IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, meIWImageFile, medpIWImageButton, IWCompCheckbox,
  IWDBStdCtrls, meIWDBCheckBox, IWCompEdit, meIWEdit, IWCompLabel, meIWLabel,
  A013UCalendIndivMW, meIWCheckBox, A000UMessaggi, A000UInterfaccia;

type
  TWA013FCalendIndiv = class(TWR100FBase)
    lblDataPatrono: TmeIWLabel;
    edtDataPatrono: TmeIWEdit;
    lblGiorniLavorativi: TmeIWLabel;
    lblGenCalendari: TmeIWLabel;
    lblDa: TmeIWLabel;
    edtDa: TmeIWEdit;
    lblA: TmeIWLabel;
    edtA: TmeIWEdit;
    btnVisualizzaCalendario: TmedpIWImageButton;
    btnGeneraCalendario: TmedpIWImageButton;
    btnCancellaCalendario: TmedpIWImageButton;
    chkMartedi: TmeIWCheckBox;
    chkMercoledi: TmeIWCheckBox;
    chkGiovedi: TmeIWCheckBox;
    chkVenerdi: TmeIWCheckBox;
    chkSabato: TmeIWCheckBox;
    chkDomenica: TmeIWCheckBox;
    chkLunedi: TmeIWCheckBox;
    procedure IWAppFormCreate(Sender: TObject);
    procedure btnGeneraCalendarioClick(Sender: TObject);
    procedure btnVisualizzaCalendarioClick(Sender: TObject);
    procedure IWAppFormDestroy(Sender: TObject);
  private
    TmpSender: TObject;
    procedure ResultMessaggioConfermaCalendario(Sender: TObject; R: TmeIWModalResult; KI: String);
  public
    A013MW:TA013FCalendIndivMW;
  end;


implementation

uses WA013USviluppoIndivFM;

{$R *.dfm}

procedure TWA013FCalendIndiv.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  AttivaGestioneC700;
  A013MW:=TA013FCalendIndivMW.Create(Self);
  A013MW.SelAnagrafe:=grdC700.selAnagrafe;
  btnGeneraCalendario.Enabled:=not SolaLettura;
  btnCancellaCalendario.Enabled:=not SolaLettura;
end;

procedure TWA013FCalendIndiv.IWAppFormDestroy(Sender: TObject);
begin
  inherited;
  if TmpSender <> nil then
    FreeAndNil(TmpSender);
  if A013MW <> nil then
    FreeAndNil(A013MW);
end;

procedure TWA013FCalendIndiv.btnGeneraCalendarioClick(Sender: TObject);
var DaGiorno,AGiorno,Patrono:TDateTime;
    Messaggio:String;
{Genero il calendario del dipendente da data a data}
begin
  TmpSender:=Sender;
  if not A013MW.ConvData(edtDa.Text,DaGiorno) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA ,mtInformation,[mbOK],nil,'');
    exit;
  end;
  if not A013MW.ConvData(edtA.Text,AGiorno) then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_DATA_ERRATA ,mtInformation,[mbOK],nil,'');
    exit;
  end;
  if DaGiorno > AGiorno then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_DATE_INVERTITE ,mtInformation,[mbOK],nil,'');
    exit;
  end;
  if Sender = btnCancellaCalendario then
    Messaggio:='cancellare'
  else
    Messaggio:='generare';
  if not MsgBox.KeyExists('ConfermaCalendario')then
  begin
    MsgBox.WebMessageDlg(Format(A000MSG_A013_DLG_FMT_CONFERMA_AZIONE,[Messaggio,edtDa.Text,edtA.Text]),mtConfirmation,[mbYes,mbNo],ResultMessaggioConfermaCalendario,'ConfermaCalendario');
    Abort;
  end;
  //Cancellazione Calendario
  if Sender = btnCancellaCalendario then
  begin
    A013MW.CancellaCalendario(DaGiorno,AGiorno);
    MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA ,mtInformation,[mbOK],nil,'');
    exit;
  end;
  if (Trim(EdtDataPatrono.Text) <> '') and (StringReplace(EdtDataPatrono.Text,' ','',[rfReplaceAll]) <> '//') and (not A013MW.ConvData(EdtDataPatrono.Text,Patrono)) then
  begin
    MsgBox.WebMessageDlg(A000MSG_A013_ERR_DATA_PATRONO ,mtInformation,[mbOK],nil,'');
    exit;
  end;
  {Carico nel vettore LAVORATIVO i giorni lavorativi}
  with A013MW do
  begin
    if (Trim(EdtDataPatrono.Text) = '') then
      DataPatrono:=0
    else
      DataPatrono:=StrToDate(EdtDataPatrono.Text);
    Lavorativo[1]:=chkLunedi.Checked;
    Lavorativo[2]:=chkMartedi.Checked;
    Lavorativo[3]:=chkMercoledi.Checked;
    Lavorativo[4]:=chkGiovedi.Checked;
    Lavorativo[5]:=chkVenerdi.Checked;
    Lavorativo[6]:=chkSabato.Checked;
    Lavorativo[7]:=chkDomenica.Checked;
    //Generazione Calendario
    GeneraCalendario(DaGiorno,AGiorno);
    MsgBox.WebMessageDlg(A000MSG_MSG_ELABORAZIONE_TERMINATA ,mtInformation,[mbOK],nil,'');
  end;
end;

procedure TWA013FCalendIndiv.ResultMessaggioConfermaCalendario(Sender: TObject; R: TmeIWModalResult; KI: String);
begin
  try
    if R = mrYes then
      btnGeneraCalendarioClick(TmpSender);
  finally
    MsgBox.ClearKeys;
  end;
end;

procedure TWA013FCalendIndiv.btnVisualizzaCalendarioClick(Sender: TObject);
{Visualizzo il calendario del dipendente da data a data}
var AnnoF,MeseF,GiornoF,AnnoL,MeseL,GiornoL:Word;
    Range:Boolean;
    DiffAnni:Integer;
    Msg:String;
begin
  with A013MW do
  begin
    //Controllo se e' impostato un range valido
    Range:=True;
    if not ConvData(EdtDa.Text,DaData) then
    begin
      Range:=False;
      DaData:=EncodeDate(1900,1,1);
    end;
    if not ConvData(EdtA.Text,AData) then
    begin
      Range:=False;
      AData:=EncodeDate(3999,12,31);
    end;
    if (Range) and (DaData > AData) then
    begin
      MsgBox.WebMessageDlg(A000MSG_ERR_DATE_INVERTITE ,mtInformation,[mbOK],nil,'');
      exit;
    end;
    Msg:=ValidaCalendario;
    if(Msg <> '') then
    begin
      MsgBox.WebMessageDlg(Msg ,mtInformation,[mbOK],nil,'');
      exit;
    end;
    DecodeDate(DaData,AnnoF,MeseF,GiornoF);
    DecodeDate(AData,AnnoL,MeseL,GiornoL);
  end;
  with TWA013FSviluppoIndivFM.Create(Self) do
  begin
    DaData:=EncodeDate(AnnoF,MeseF,GiornoF);
    AData:=EncodeDate(AnnoL,MeseL,GiornoL);
    if DaData > AData then
    begin
      DaData:=EncodeDate(AnnoL,MeseL,GiornoL);
      AData:=EncodeDate(AnnoF,MeseF,GiornoF);
      DecodeDate(DaData,AnnoF,MeseF,GiornoF);
      DecodeDate(AData,AnnoL,MeseL,GiornoL);
    end;
    DiffAnni:=AnnoL - AnnoF;
    if DiffAnni = 0 then
      NumMesi:=MeseL - MeseF + 1
    else
      NumMesi:=12*(DiffAnni - 1) + MeseL + 13 - MeseF;
    Anno:=AnnoF;
    Mese:=MeseF;
    Visualizza;
  end;
end;

end.
