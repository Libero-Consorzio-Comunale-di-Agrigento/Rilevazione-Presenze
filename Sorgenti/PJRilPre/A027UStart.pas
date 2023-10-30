unit A027UStart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, A000UInterfaccia, C180FunzioniGenerali, Printers;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses A027UCarMen;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var ADevice,ADriver,APort:array [0..255] of Char;
    DevMode:PDeviceMode;
    DeviceHandle: THandle;
begin
  R180AppendFile('c:\Iriswin\A027srv.trc','Execute');
  SessioneOracle.LogonDatabase:='IRIS9';
  SessioneOracle.LogonUsername:='MONDOEDP';
  SessioneOracle.LogonPassword:='TIMOTEO';
  SessioneOracle.Logon;
  //Leggo le impostazioni per assegnarle al QuickReport
  Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
  R180AppendFile('c:\Iriswin\A027srv.trc','-2');
  if DeviceHandle = 0 then
  begin
    Printer.PrinterIndex:=Printer.PrinterIndex;
    Printer.GetPrinter(ADevice,ADriver,APort,DeviceHandle);
  end;
  R180AppendFile('c:\Iriswin\A027srv.trc','-3');
  if DeviceHandle <> 0 then
    DevMode:=GlobalLock(DeviceHandle);
  R180AppendFile('c:\Iriswin\A027srv.trc','-4');
  GlobalUnlock(DeviceHandle);
  R180AppendFile('c:\Iriswin\A027srv.trc','-5');
  A027FCarMen:=TA027FCarmen.Create(nil);
  try
    R180AppendFile('c:\Iriswin\A027srv.trc','1');
    A027FCarMen.FormShow(A027FCarMen);
    R180AppendFile('c:\Iriswin\A027srv.trc','2');
    A027FCarMen.EDaData.Text:='01/01/2004';
    R180AppendFile('c:\Iriswin\A027srv.trc','3');
    A027FCarMen.EAData.Text:='31/01/2004';
    R180AppendFile('c:\Iriswin\A027srv.trc','4');
    A027FCarMen.frmSelAnagrafe.SelezionaProgressivo(4);
    R180AppendFile('c:\Iriswin\A027srv.trc','5');
    R180AppendFile('c:\Iriswin\A027srv.trc','NumRecords:' + IntToStr(A027FCarMen.R400FCartellinoDtM.A027SelAnagrafe.RecordCount));
    try
      A027FCarMen.BitBtn1Click(A027FCarMen.BitBtn5);
    except
      on E:Exception do
        R180AppendFile('c:\Iriswin\A027srv.trc',E.Message);
    end;
    R180AppendFile('c:\Iriswin\A027srv.trc','6');
  finally
    A027FCarMen.Release;
  end;
end;

end.
