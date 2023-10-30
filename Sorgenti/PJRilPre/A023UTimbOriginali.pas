unit A023UTimbOriginali;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Spin, Variants, SelAnagrafe, C700USelezioneAnagrafe,
  A000UInterfaccia, ComCtrls, ExtCtrls;

type
  TA023FTimbOriginali = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LblDaData: TLabel;
    Label1: TLabel;
    SBDaGG: TSpinEdit;
    Label2: TLabel;
    SBAGG: TSpinEdit;
    chkTuttiDipendenti: TCheckBox;
    frmSelAnagrafe1: TfrmSelAnagrafe;
    Panel1: TPanel;
    StatusBar: TStatusBar;
    procedure frmSelAnagrafebtnSelezioneClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataI,DataF:TDateTime;
  end;

var
  A023FTimbOriginali: TA023FTimbOriginali;

implementation

{$R *.DFM}

procedure TA023FTimbOriginali.BitBtn1Click(Sender: TObject);
var A,M,G:Word;
begin
  if SBDaGG.Value <= SBAGG.Value then
  begin
    DecodeDate(DataI,A,M,G);
    DataI:=EncodeDate(A,M,SBDaGG.Value);
    DataF:=EncodeDate(A,M,SBAGG.Value);
    ModalResult:=mrOK;
  end
  else
    raise Exception.Create('Il periodo indicato non è valido!');
end;

procedure TA023FTimbOriginali.FormShow(Sender: TObject);
begin
  if frmSelAnagrafe1.Visible then
  begin
    C700DatiVisualizzati:='MATRICOLA,COGNOME,NOME';
    C700DataLavoro:=Parametri.DataLavoro;
    frmSelAnagrafe1.CreaSelAnagrafe(SessioneOracle,StatusBar,0,False);
  end;
end;

procedure TA023FTimbOriginali.frmSelAnagrafebtnSelezioneClick(Sender: TObject);
begin
  frmSelAnagrafe1.btnSelezioneClick(Sender);
end;

end.
