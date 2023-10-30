unit S028UMotivazioniMW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, R005UDataModuleMW, Data.DB, OracleData;

type
  TS028FmotivazioniMW = class(TR005FDataModuleMW)
    selP660: TOracleDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  S028FmotivazioniMW: TS028FmotivazioniMW;

implementation

{$R *.dfm}

end.
