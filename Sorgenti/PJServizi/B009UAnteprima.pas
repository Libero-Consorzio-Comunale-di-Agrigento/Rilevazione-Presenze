unit B009UAnteprima;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,qrprntr,quickrpt, Buttons, ComCtrls, Variants;

type
  // To have a custom preview be used as the default preview,
  // you first define an interface class.  You will provide two
  // functions for this class, Show, and ShowModal.
  TQRMDIPreviewInterface = class(TQRPreviewInterface)
  public
    function Show(AQRPrinter : TQRPrinter) : TWinControl; override;
    function ShowModal(AQRPrinter : TQRPrinter): TWinControl; override;
  end;

  // We need the ParentReport property from TQRCompositeWinControl.  As of
  // the 3.0.4 release, this property is protected.  We create a descendant
  // class and that will give us access to the property
  TQRPatch = class(TQRCompositeWinControl)
  end;

  TB009FAnteprima = class(TForm)
    StatusBar: TStatusBar;
    PnlInformazioni: TPanel;
    Label1: TLabel;
    Timer1: TTimer;
    Panel1: TPanel;
    QRPreview1: TQRPreview;
    PnlNavigazione: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Label2: TLabel;
    Label3: TLabel;
    PnlChiusura: TGroupBox;
    Image7: TImage;
    Label6: TLabel;
    Label7: TLabel;
    PnlZoom: TGroupBox;
    Image5: TImage;
    Image6: TImage;
    Label4: TLabel;
    Label5: TLabel;
    procedure btnPrevPageClick(Sender: TObject);
    procedure btnNextPageClick(Sender: TObject);
    procedure btnZoomInClick(Sender: TObject);
    procedure btnZoomOutClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure QRPreview1PageAvailable(Sender: TObject; PageNum: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FQRPrinter : TQRPrinter;
    nPv_NumeroSecondi:Integer;
    procedure Init;
    procedure UpdateButtons;
    procedure SetMyWindow;
  public
    { Public declarations }
    pQuickreport : TQuickRep;
    bPleaseInit : Boolean;
    bCanPrint: boolean;
    sStatus,
    sTitle : string;
    constructor CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter);
    property QRPrinter : TQRPrinter read FQRPrinter write FQRPrinter;
  end;

var
  B009FAnteprima: TB009FAnteprima;
  PrintPreviewImage,
  CanPrint: boolean;
  PreviewInCorso:boolean;

implementation

uses B009UDialogBox;

{$R *.DFM}

// Now define the functions for the interface class.

function TQRMDIPreviewInterface.Show(AQRPrinter : TQRPrinter) : TWinControl;
begin
  Result := TB009FAnteprima.CreatePreview(Application, AQRPrinter);
  // You can set options for your preview here
  TB009FAnteprima(Result).bCanPrint := CanPrint;
  PreviewInCorso:=true;
  TB009FAnteprima(Result).Show;
end;

function TQRMDIPreviewInterface.ShowModal(AQRPrinter : TQRPrinter) : TWinControl;
begin
  Result := TB009FAnteprima.CreatePreview(Application, AQRPrinter);
  // You can set options for your preview here
  TB009FAnteprima(Result).bCanPrint := CanPrint;
  PreviewInCorso:=true;
  TB009FAnteprima(Result).ShowModal;
end;

constructor TB009FAnteprima.CreatePreview(AOwner : TComponent; aQRPrinter : TQRPrinter);
begin
  inherited Create(AOwner);
  QRPrinter := aQRPrinter;
  // Connect the preview component to the report's qrprinter object
  QRPreview1.QRPrinter := aQRPrinter;

  if (QRPrinter <> nil) and (QRPrinter.Title <> '') then
    Caption := QRPrinter.Title;
end;

procedure TB009FAnteprima.UpdateButtons;
begin
  StatusBar.Panels[0].Text := sStatus;
  StatusBar.Panels[1].Text := 'Pagina  ' + IntToStr(QRPreview1.PageNumber) + ' di ' +
    IntToStr(QRPreview1.QRPrinter.PageCount);
end;

procedure TB009FAnteprima.btnPrevPageClick(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    if PageNumber > 1 then
      PageNumber := PageNumber - 1;
  UpdateButtons;
end;

procedure TB009FAnteprima.btnNextPageClick(Sender: TObject);
begin
  Application.ProcessMessages;

  with QRPreview1 do
    if PageNumber < QRPreview1.QRPrinter.PageCount then
      PageNumber := PageNumber + 1;
  UpdateButtons;
end;

procedure TB009FAnteprima.btnZoomInClick(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    Zoom := Zoom + 10;
end;

procedure TB009FAnteprima.btnZoomOutClick(Sender: TObject);
begin
  Application.ProcessMessages;
  with QRPreview1 do
    if Zoom > 10 then
      Zoom := Zoom - 10;
end;

procedure TB009FAnteprima.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TB009FAnteprima.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PreviewInCorso:=false;
  Timer1.Enabled:=false;
  QRPrinter.ClosePreview(Self);
  Action := caFree;
end;

procedure TB009FAnteprima.SetMyWindow;
var
  wp: TWindowPlacement;
  Rec: TRect;
begin
  // Get the client area of the desktop so we can force the preview
  // to use all of the available space.  This keeps the user from
  // minizing the form.
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Rec, 0);
  wp.length := sizeof(wp);
  GetWindowPlacement(handle, @wp);
  wp.rcNormalposition := rec;
  setwindowplacement(handle, @wp);
end;

procedure TB009FAnteprima.FormShow(Sender: TObject);
begin
  bPleaseInit := True;
end;

procedure TB009FAnteprima.Init;
begin
  if bPleaseInit then
  begin
    { If the caller reports want to disable printing, then it will set}
    { the following boolean to false }
    UpdateButtons;

    bPleaseInit := False;
  end;
end;

procedure TB009FAnteprima.QRPreview1PageAvailable(Sender: TObject;
  PageNum: Integer);
var
  sTitle: string;
begin
  Init;

  sTitle := 'CARTELLINO MENSILE DEL DIPENDENTE ';

  if QRPreview1.QRPrinter.PageCount = 0 then
  begin
    Caption := sTitle + ' - 0 pagine';
    Timer1.enabled:=false;
    B009UDialogBox.OpenB009FDialogBox('Non esistono registrazioni che soddisfano i parametri indicati.', 'Attenzione', 'ESCLAMA');
    btnCloseClick(self);
    abort;
  end
  else if PageNum = 1 then
    Caption := sTitle + ' - 1 pagina'
  else
    Caption := sTitle + ' - ' + IntToStr(PageNum) + ' pagine';

  case QRPreview1.QRPrinter.Status of
    mpReady: sStatus := 'Pronto';
    mpBusy: sStatus := 'Occupato';
    mpFinished: sStatus := 'Completato';
  end;
  UpdateButtons;
end;

procedure TB009FAnteprima.FormCreate(Sender: TObject);
begin
  pQuickreport.useQR5Justification:=True;
  // Get the client area of the desktop
  SetMyWindow;
end;

procedure TB009FAnteprima.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  OldPosition:integer;
begin

  nPv_NumeroSecondi:=0;

  // Let the user navigate through the preview by the keyboard
  case Key of
    vk_Down  : With QRPreview1.VertScrollBar do
      begin
        OldPosition:=Position;
        Position := Position + trunc(Range / 10);
        if OldPosition = Position then
          btnNextPageClick(Self);
      end;
    vk_Up    : With QRPreview1.VertScrollBar do
      begin
        OldPosition:=Position;
        Position := Position - trunc(Range / 10);
        if OldPosition = Position then
        begin
          btnPrevPageClick(Self);
        end;
      end;
    vk_Left  : With QRPreview1.HorzScrollBar do
                 Position := Position - trunc(Range / 10);
    vk_Right : With QRPreview1.HorzScrollBar do
                 Position := Position + trunc(Range / 10);
    VK_Escape : btnCloseClick(self);
    107, 187  : btnZoomInClick(self);
    109, 189  : btnZoomOutClick(self);
  end;
  Key:=0;
end;

procedure TB009FAnteprima.FormActivate(Sender: TObject);
begin

  PnlNavigazione.Left:=2;
  PnlZoom.Left:=trunc((screen.Width -  PnlZoom.Width)/2) + 20;
  PnlChiusura.Left:=(screen.Width - PnlChiusura.Width) - 8;
  Panel1.Height :=screen.Height - (Statusbar.Height + PnlInformazioni.Height + 30);

  nPv_NumeroSecondi:=0;

end;

procedure TB009FAnteprima.Timer1Timer(Sender: TObject);
begin
  nPv_NumeroSecondi:=nPv_NumeroSecondi + 1;
  StatusBar.Panels[2].Text := 'Tempo mancante alla chiusura automatica del cartellino: ' + inttostr(30 - nPv_NumeroSecondi) + ' secondi';
  if nPv_NumeroSecondi > 30 then
  begin
    btnCloseClick(self);
  end;
end;

procedure TB009FAnteprima.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled:=false;
end;

initialization
  CanPrint := true;
  PrintPreviewImage := false;
  PreviewInCorso:=false;
end.

