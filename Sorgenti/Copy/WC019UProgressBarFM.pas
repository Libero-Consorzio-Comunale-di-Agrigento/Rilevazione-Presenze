unit WC019UProgressBarFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WR200UBaseFM, IWCompJQueryWidget, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer, IWHTMLContainer,
  IWHTML40Container, IWRegion, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompProgressBar, meIWProgressBar,
  IWCompButton, meIWButton, IWCompLabel, meIWLabel,A000UMessaggi,
  IWBaseComponent, IWBaseHTMLComponent, IWBaseHTML40Component, IWCompExtCtrls,
  IWCompCheckbox, meIWCheckBox, meIWImageFile;

type
  TSteps = (STEP1 = 1, STEP2 = 2, STEP3 =3 );
  TWC019FProgressBarFM = class(TWR200FBaseFM)
    pbAvanzamento: TmeIWProgressBar;
    lblElabInCorso: TmeIWLabel;
    chkInterrompiElaborazione: TmeIWCheckBox;
    imgSpinner: TmeIWImageFile;
    lblInfo: TmeIWLabel;
    btnChiudi: TmeIWButton;
    procedure IWFrameRegionCreate(Sender: TObject);
    procedure IWFrameRegionRender(Sender: TObject);
    procedure btnChiudiAsyncClick(Sender: TObject; EventParams: TStringList);
  private
    FNascondiFinalizzazione: Boolean;
    FInterrompiElaborazione:Boolean;
    FMessaggioStep3: String;
    FMessaggioStep2: String;
    NumRender:Integer;
    const
      IMG_SPINNER_URL : String = 'img/loading_ajax.gif';
      IMG_WARNING_URL : String = 'img/warning.png';
  public
    procedure Visualizza;
    procedure Chiudi;
    procedure AggiornaAvanzamento(Step: TSteps; const Cur: Integer = 0; Tot: Integer=0);
    property MessaggioStep3: String write FMessaggioStep3;
    property MessaggioStep2: String write FMessaggioStep2;
    property NascondiFinalizzazione: Boolean read FNascondiFinalizzazione write FNascondiFinalizzazione;
    property InterrompiElaborazione: Boolean read FInterrompiElaborazione write FInterrompiElaborazione;
  end;

implementation

uses WR100UBase;

{$R *.dfm}

{ TWC019FProgressBarFM }

procedure TWC019FProgressBarFM.IWFrameRegionCreate(Sender: TObject);
begin
  inherited;
  MessaggioStep3:=A000MSG_MSG_ELABORAZIONE_STEP_FINALE;
  MessaggioStep2:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
  FNascondiFinalizzazione:=False;
  FInterrompiElaborazione:=True;
  imgSpinner.ImageFile.URL:=IMG_SPINNER_URL;
  lblInfo.Caption:=A000MSG_MSG_ELAB_ASYNC_IN_CORSO;
  NumRender:=0;
end;

procedure TWC019FProgressBarFM.IWFrameRegionRender(Sender: TObject);
begin
  inherited;
  Inc(NumRender);
  if NumRender > 1 then
  begin
    // Se questo frame è stata renderizzato più di una volta, vuol dire che l'utente ha chiesto
    // al browser di refreshare la pagina (cosa che non deve accadere).
    // Avvisiamo che è necessario annullare l'operazione.
    pbAvanzamento.Color:=clWebRed;
    imgSpinner.ImageFile.URL:=IMG_WARNING_URL;
    lblInfo.Caption:=A000MSG_ERR_ELAB_ASYNC_REFRESH;
    chkInterrompiElaborazione.Editable:=False;
    btnChiudi.Visible:=True;
  end;
end;

procedure TWC019FProgressBarFM.Visualizza;
begin
  // visualizza messaggio modale
  lblElabInCorso.Caption:=A000MSG_MSG_ELABORAZIONE_IN_CORSO;
  pbAvanzamento.Percent:=0;
  pbAvanzamento.Visible:=True;
  chkInterrompiElaborazione.Visible:=FInterrompiElaborazione;
  TWR100FBase(Self.Parent).VisualizzaJQMessaggio(jQuery,500,200,200,'Elaborazione','#wc019_container',False,True);
end;

//Progress bar:
//step 1 : 1% per impostazioni iniziali.
//step 2 : incremento fino al 100% in base ai dipendenti selezionati
//step3:  generazione file (cambio caption etichetta)
procedure TWC019FProgressBarFM.AggiornaAvanzamento(Step: TSteps; const Cur: Integer; Tot: Integer);
begin
  Visible:=True;
  if Step = STEP1 then
    pbAvanzamento.Percent:=1
  else if Step = STEP2 then //100 è il valore a cui deve arrivare quando finito ciclo dipendenti (se necessario cambiarlo)
  begin
    if Tot > 0 then
    begin
      lblElabInCorso.Caption:=FMessaggioStep2;
      if cur > Tot then  //in alcuni casi il totale non può essere calcolato con esattezza e il valore può superare; es WP656
        pbAvanzamento.Percent:=100
      else
        pbAvanzamento.Percent:=Trunc((cur*100)/ Tot);

      if pbAvanzamento.Percent = 0 then
        pbAvanzamento.Percent:=1;
    end
    else
      pbAvanzamento.Percent:=100;
  end
  else if Step = STEP3 then
  begin
    pbAvanzamento.Visible:=False;
    chkInterrompiElaborazione.Visible:=False;
    lblElabInCorso.Caption:=FMessaggioStep3;
    //Permette di nascondere il frame con la dicitura di finalizzazione
    if NascondiFinalizzazione then
      Visible:=False;
  end;
end;

procedure TWC019FProgressBarFM.btnChiudiAsyncClick(Sender: TObject;
  EventParams: TStringList);
begin
  chkInterrompiElaborazione.Checked:=True;
  (Self.Owner as TWR100FBase).AJNElementoSuccessivo.Notify;
end;

procedure TWC019FProgressBarFM.Chiudi;
begin
  ReleaseOggetti;
  Free;
end;

end.
