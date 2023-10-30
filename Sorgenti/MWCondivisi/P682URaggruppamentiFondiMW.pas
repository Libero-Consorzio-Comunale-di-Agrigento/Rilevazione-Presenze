unit P682URaggruppamentiFondiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData;

type
  TP682FRaggruppamentiFondiMW = class(TR005FDataModuleMW)
  private
    { Private declarations }
  public
    { Public declarations }
    selP682: TOracleDataSet;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
