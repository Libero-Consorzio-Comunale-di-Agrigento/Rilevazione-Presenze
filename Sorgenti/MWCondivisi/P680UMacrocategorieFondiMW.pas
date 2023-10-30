unit P680UMacrocategorieFondiMW;

interface

uses
  System.SysUtils, System.Classes, R005UDataModuleMW, OracleData;

type
  TP680FMacrocategorieFondiMW = class(TR005FDataModuleMW)
  private
    { Private declarations }
  public
    { Public declarations }
    selP680: TOracleDataSet;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
