unit WA020UCausPresenzeStorico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR102UGestTabella, System.Actions,
  Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component,
  IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout,
  IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel,
  meIWLabel, medpIWStatusBar, IWCompEdit, meIWEdit, IWCompGrids, meIWGrid,
  IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWHTMLControls, meIWLink, A000UInterfaccia, WA020UCausPresenze,
  WA020UCausPresenzeStoricoDM, WA020UCausPresenzeStoricoDettFM,
  WA020UCausPresenzeStoricoBrowseFM, A000UMessaggi, medpIWMessageDlg;

type
  TWA020FCausPresenzeStorico = class(TWR102FGestTabella)
    procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    DataPeriodoInizialeImpostata:Boolean;
    IDCausale:Integer;
  public
    WA020StoricoDataLavoro:TDateTime;
    WA020FCausPresenze:TWA020FCausPresenze;
    constructor Create(AOwner: TComponent;
                       const PAddToHistory: Boolean;
                       IDCausale:Integer;
                       WA020FCausPresenze:TWA020FCausPresenze);
    procedure ImpostaDataPeriodoIniziale;

  end;

implementation

uses WA020UCausPresenzeDM;

{$R *.dfm}

procedure TWA020FCausPresenzeStorico.actEliminaExecute(Sender: TObject);
begin
  if WR302DM.selTabella.RecordCount < 2 then
  begin
    MsgBox.WebMessageDlg(A000MSG_A020_MSG_NO_ELIMINA_STOR,TmeIWMsgDlgType.mtWarning,[mbOk],nil,'');
    Exit;
  end;
  inherited;
end;

constructor TWA020FCausPresenzeStorico.Create(AOwner: TComponent;
                                              const PAddToHistory: Boolean;
                                              IDCausale:Integer;
                                              WA020FCausPresenze:TWA020FCausPresenze);
begin
  Self.IDCausale:=IDCausale;
  Self.WA020FCausPresenze:=WA020FCausPresenze;
  inherited Create(AOwner,PAddToHistory);
end;

procedure TWA020FCausPresenzeStorico.IWAppFormCreate(Sender: TObject);
var
  WA020StoricoDM:TWA020FCausPresenzeStoricoDM;
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  InterfacciaWR102.OttimizzaStorico:=False;
  WA020StoricoDM:=TWA020FCausPresenzeStoricoDM.Create(Self);
  WA020StoricoDM.IDCausale:=Self.IDCausale;
  WA020StoricoDM.Inizializza;
  WR302DM:=WA020StoricoDM;
  WBrowseFM:=TWA020FCausPresenzeStoricoBrowseFM.Create(Self);
  WDettaglioFM:=TWA020FCausPresenzeStoricoDettFM.Create(Self);
  CercaStoricoCorrente(Parametri.DataLavoro);

  CreaTabDefault;
end;

procedure TWA020FCausPresenzeStorico.ImpostaDataPeriodoIniziale;
var
  DataLavoroInizialeStr:String;
begin
  if (not DataPeriodoInizialeImpostata) then
  begin
    DataLavoroInizialeStr:=DateToStr(WA020StoricoDataLavoro);
    cmbDecorrenza.ItemIndex:=cmbDecorrenza.Items.IndexOf(DataLavoroInizialeStr);
    cmbDecorrenza.OnChange(nil);
    DataPeriodoInizialeImpostata:=True;
  end;
end;

end.
