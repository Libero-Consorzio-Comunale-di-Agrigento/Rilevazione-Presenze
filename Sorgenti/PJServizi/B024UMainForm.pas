unit B024UMainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  IdTCPServer, IdCustomHTTPServer, IdSoapServerHTTP, IdBaseComponent,
  IdComponent, IdSoapComponent, IdSoapITIProvider, IdSoapServer,
  IdSoapServerTCPIP, IdCustomTCPServer, Vcl.StdCtrls;

type
  TB024FMainForm = class(TForm)
    IdSoapServer1: TIdSoapServer;
    IdSOAPServerHTTP1: TIdSOAPServerHTTP;
    lblInfo: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B024FMainForm: TB024FMainForm;

implementation

uses
  B024UADSCatanzaroDM;

{$R *.DFM}

procedure TB024FMainForm.FormCreate(Sender: TObject);
begin
  lblInfo.Caption:=Format('Server SOAP in ascolto sulla porta %d',[GConfig.Port]);
end;

end.
