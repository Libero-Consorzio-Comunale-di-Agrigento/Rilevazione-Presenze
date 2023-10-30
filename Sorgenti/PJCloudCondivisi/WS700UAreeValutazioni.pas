unit WS700UAreeValutazioni;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WR103UGestMasterDetail, System.Actions, Vcl.ActnList, IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls, IWVCLComponent, IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, medpIWTabControl, IWCompLabel, meIWLabel, IWCompGrids, meIWGrid, medpIWStatusBar, IWCompButton, meIWButton, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWHTMLControls, meIWLink,
  S700UAreeValutazioniMW,A000UInterfaccia, medpIWMessageDlg,WS700UElementiFM, A000UMessaggi;

type
  TWS700FAreeValutazioni = class(TWR103FGestMasterDetail)
  procedure IWAppFormCreate(Sender: TObject);
    procedure actEliminaExecute(Sender: TObject);
  private
    confermaElimina, elimina: boolean;
    procedure ResultElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
  public
    Detail:TWS700FElementiFM;
  end;

implementation

uses WS700UAreeValutazioniDM, WS700UAreeValutazioniBrowseFM, WS700UAreeValutazioniDettFM;

{$R *.dfm}

procedure TWS700FAreeValutazioni.actEliminaExecute(Sender: TObject);
begin
  if confermaElimina then
    MsgBox.WebMessageDlg(A000MSG_S700_MSG_CANC_VALUT,mtConfirmation,[mbYes,mbNo],ResultElimina,'');
  if elimina then
  begin
    confermaElimina:=false;
    elimina:=true;
    inherited;
  end;
end;

procedure TWS700FAreeValutazioni.IWAppFormCreate(Sender: TObject);
begin
  inherited;
  InterfacciaWR102.GestioneStoricizzata:=True;
  WR302DM:=TWS700FAreeValutazioniDM.Create(Self);
  WBrowseFM:=TWS700FAreeValutazioniBrowseFM.Create(Self);

  Detail:=nil;

  WDettaglioFM:=TWS700FAreeValutazioniDettFM.Create(Self);

  Detail:=TWS700FElementiFM.Create(Self);
  AggiungiDetail(Detail);
  Detail.CaricaDettaglio(TWS700FAreeValutazioniDM(WR302DM).S700FAreeValutazioniMW.selSG700,TWS700FAreeValutazioniDM(WR302DM).dsrSG700);


  confermaElimina:=true;
  elimina:=false;
  CreaTabDefault;
end;

procedure TWS700FAreeValutazioni.ResultElimina(Sender: TObject; Res: TmeIWModalResult; KeyID: String);
begin
  if Res = mrYes then
  begin
    confermaElimina:=false;
    elimina:=true;
    actEliminaExecute(Sender);
  end
end;


end.
