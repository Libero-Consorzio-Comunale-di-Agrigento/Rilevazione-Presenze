unit B013UPianificazioneIntegrazione;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Variants;

type
  TB013FPianificazioneIntegrazione = class(TForm)
    dgrdPianificazioneIntegrazione: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  B013FPianificazioneIntegrazione: TB013FPianificazioneIntegrazione;

implementation

uses B013UIntegrazioneEMKDtM;

{$R *.DFM}

end.
