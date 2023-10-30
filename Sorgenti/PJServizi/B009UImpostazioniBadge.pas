unit B009UImpostazioniBadge;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, C004UParamForm, Buttons, A000UInterfaccia, Variants;

type
  TB009FImpostazioniBadge = class(TForm)
    Panel1: TPanel;
    EdtPosizione: TEdit;
    Label1: TLabel;
    EdtLunghezza: TEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    procedure BtnOkClick(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure PutParametriFunzione;
    procedure GetParametriFunzione;
  public
    { Public declarations }
  end;

var
  B009FImpostazioniBadge: TB009FImpostazioniBadge;

implementation

uses B009UPuntoInformativo;

{$R *.DFM}

procedure TB009FImpostazioniBadge.PutParametriFunzione;
{Scrivo i parametri della forma}
begin
  C004FParamForm.Cancella001;
  C004FParamForm.PutParametro('Posizione', EdtPosizione.text);
  C004FParamForm.PutParametro('Lunghezza', EdtLunghezza.text);
  try SessioneOracle.Commit; except end;
end;

procedure TB009FImpostazioniBadge.GetParametriFunzione;
{Leggo i parametri della form}
begin
  edtPosizione.text:=C004FParamForm.GetParametro('Posizione','');
  edtLunghezza.text:=C004FParamForm.GetParametro('Lunghezza','');
end;

procedure TB009FImpostazioniBadge.BtnOkClick(Sender: TObject);
begin
  PutParametriFunzione;
  B009FImpostazioniBadge.Close;
end;

procedure TB009FImpostazioniBadge.BtnCancelClick(Sender: TObject);
begin
  B009FImpostazioniBadge.Close;
end;

procedure TB009FImpostazioniBadge.FormShow(Sender: TObject);
begin
  CreaC004(SessioneOracle,'B009',0);
  B009FImpostazioniBadge.GetParametriFunzione
end;

procedure TB009FImpostazioniBadge.FormDestroy(Sender: TObject);
begin
  C004FParamForm.Free;
end;

end.
