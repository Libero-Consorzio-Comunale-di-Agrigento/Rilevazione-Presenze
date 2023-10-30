unit WA196UTipiPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, meIWImageFile,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, WA196UTipiPagamentoDM, WA196UTipiPagamentoBrowseFM,
  A000UCostanti, A000UMessaggi, A000UInterfaccia,medpIWMessageDlg;

type
  TWA196FTipiPagamento = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TWA196FTipiPagamento.actEliminaExecute(Sender: TObject);
begin
  if WBrowseFM.grdTabella.medpDataSet.FieldByName('CODICE').AsString  = DEBIT then
  begin
    MsgBox.WebMessageDlg(A000MSG_A100_ERR_PAG_DEBIT,mtError,[mbOk],nil,'');
    Abort;
  end;
  inherited;
end;

procedure TWA196FTipiPagamento.IWAppFormCreate(Sender: TObject);
begin
  inherited;

  WR302DM:=TWA196FTipiPagamentoDM.Create(Self);
  InterfacciaWR102.DettaglioFM:=False;
  WBrowseFM:=TWA196FTipiPagamentoBrowseFM.Create(Self);

  CreaTabDefault;
end;

end.
