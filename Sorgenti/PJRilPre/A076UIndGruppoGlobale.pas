unit A076UIndGruppoGlobale;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus,DB,ExtCtrls,C180FunzioniGenerali, Buttons,
  Grids, Variants;

type
  TA076FIndGruppoGlobale = class(TForm)
    RichEdit1: TRichEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    lblDescDecorrenza: TLabel;
    lblDataDecorrenza: TLabel;
    btnSetUpStampante: TBitBtn;
    BitBtn2: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnSetUpStampanteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CaricaEdit;
  end;

var
  A076FIndGruppoGlobale: TA076FIndGruppoGlobale;

implementation

uses A076UIndGruppoDtM1, A076UIndGruppo;

{$R *.DFM}

procedure TA076FIndGruppoGlobale.CaricaEdit;
begin

end;

procedure TA076FIndGruppoGlobale.BitBtn1Click(Sender: TObject);
begin
  RichEdit1.Print(A076FIndGruppoGlobale.Caption);
end;

procedure TA076FIndGruppoGlobale.btnSetUpStampanteClick(Sender: TObject);
begin
  PrinterSetUpDialog1.Execute;
end;

end.
