unit WA197ULayoutSchedaAnagr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA197ULayoutSchedaAnagrDM,
  WA197ULayoutSchedaAnagrBrowseFM, WA197ULayoutSchedaAnagrDettFM, A000UInterfaccia,
  A000UMessaggi,medpIWMessageDlg;

type
  TWA197FLayoutSchedaAnagr = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure IWAppFormRender(Sender: TObject);
    procedure actConfermaExecute(Sender: TObject);
  private
    { Private declarations }
  end;

implementation

{$R *.dfm}

procedure TWA197FLayoutSchedaAnagr.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  WR302DM:=TWA197FLayoutSchedaAnagrDM.Create(Self);
  WBrowseFM:=TWA197FLayoutSchedaAnagrBrowseFM.Create(Self);
  WDettaglioFM:=TWA197FLayoutSchedaAnagrDettFM.Create(Self);
  InterfacciaWR102.CopiaSuChiave:='NOME';
  CreaTabDefault;
end;

procedure TWA197FLayoutSchedaAnagr.actConfermaExecute(Sender: TObject);
begin
  if (WDettaglioFM as TWA197FLayoutSchedaAnagrDettFM).VerificaGrdPending then
  begin
    MsgBox.WebMessageDlg(A000MSG_ERR_GRID_PENDING,mtInformation,[mbOk],nil,'');
    Abort;
  end;
  inherited;
end;

procedure TWA197FLayoutSchedaAnagr.IWAppFormRender(Sender: TObject);
begin
  inherited;
  //non trova i componenti dentro la grid nella region dinamica. attivo a mano
  jqMask.Enabled:=True;
end;

end.
