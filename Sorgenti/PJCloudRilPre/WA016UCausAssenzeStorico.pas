unit WA016UCausAssenzeStorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, A000UMessaggi,
  IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel,
  medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink, medpIWMessageDlg,
  WC013UCheckListFM, WA016UCausAssenze;

type
  TWA016FCausAssenzeStorico = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    IDCausale:Integer;
    DataPeriodoInizialeImpostata:Boolean;
  public
    WC013FCheckListFM:TWC013FCheckListFM;
    WA016StoricoDataLavoro:TDateTime;
    WA016FCausAssenze:TWA016FCausAssenze;
    constructor Create(AOwner: TComponent;
                       const PAddToHistory: Boolean;
                       IDCausale:Integer;
                       WA016FCausAssenze:TWA016FCausAssenze);
    procedure ImpostaDataPeriodoIniziale;
  end;

implementation

uses A000UInterfaccia, WA016UCausAssenzeStoricoDM, WA016UCausAssenzeStoricoBrowseFM,
     WA016UCausAssenzeStoricoDettFM;

{$R *.dfm}

procedure TWA016FCausAssenzeStorico.actEliminaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.RecordCount < 2 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A016_MSG_NO_ELIMINA_STOR,TmeIWMsgDlgType.mtWarning,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

constructor TWA016FCausAssenzeStorico.Create(AOwner: TComponent;
                                             const PAddToHistory: Boolean;
                                             IDCausale:Integer;
                                             WA016FCausAssenze:TWA016FCausAssenze);
begin
  Self.IDCausale:=IDCausale;
  Self.WA016FCausAssenze:=WA016FCausAssenze;
  inherited Create(AOwner,PAddToHistory);
end;

procedure TWA016FCausAssenzeStorico.IWAppFormCreate(Sender: TObject);
var
  WA016StoricoDM:TWA016FCausAssenzeStoricoDM;
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.OttimizzaStorico:=False;
  WA016StoricoDM:=TWA016FCausAssenzeStoricoDM.Create(Self);
  WA016StoricoDM.IDCausale:=Self.IDCausale;
  WA016StoricoDM.Inizializza;
  WR302DM:=WA016StoricoDM;
  WBrowseFM:=TWA016FCausAssenzeStoricoBrowseFM.Create(Self);
  WDettaglioFM:=TWA016FCausAssenzeStoricoDettFM.Create(Self);
  CercaStoricoCorrente(Parametri.DataLavoro);

  CreaTabDefault;
end;

procedure TWA016FCausAssenzeStorico.ImpostaDataPeriodoIniziale;
var
  DataLavoroInizialeStr:String;
begin
  if (not DataPeriodoInizialeImpostata) then
  begin
    DataLavoroInizialeStr:=DateToStr(WA016StoricoDataLavoro);
    cmbDecorrenza.ItemIndex:=cmbDecorrenza.Items.IndexOf(DataLavoroInizialeStr);
    cmbDecorrenza.OnChange(nil);
    DataPeriodoInizialeImpostata:=True;
  end;
end;

end.
