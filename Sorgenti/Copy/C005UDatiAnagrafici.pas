unit C005UDatiAnagrafici;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, OracleData, Oracle, Variants,
  A000UInterfaccia, C005UDatiAnagraficiDM, C180FunzioniGenerali;

type
  TC005FDatiAnagrafici = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    C005FDatiAnagraficiDM:TC005FDatiAnagraficiDM;
    procedure ShowDipendente(P:Integer);
  end;

var
  C005FDatiAnagrafici: TC005FDatiAnagrafici;
  C005DataVisualizzazione:TDateTime;

implementation

{$R *.DFM}

procedure TC005FDatiAnagrafici.FormCreate(Sender: TObject);
begin
  Top:=0;
  Left:=0;
  Width:=Screen.Width div 3;
  Height:=Screen.Height div 3;
  C005FDatiAnagraficiDM:=TC005FDatiAnagraficiDM.Create(Self);
end;

procedure TC005FDatiAnagrafici.ShowDipendente(P:Integer);
begin
  C005FDatiAnagraficiDM.GetDatiAnagrafici(P,C005DataVisualizzazione);
  Caption:='Dati anagrafici di ' + C005FDatiAnagraficiDM.Titolo + ' al ' + FormatDateTime('dd/mm/yyyy',C005DataVisualizzazione);
  Memo1.Lines.Text:=C005FDatiAnagraficiDM.lstDatiAnagrafici.Text;

  if True then
  begin
    C005FDatiAnagraficiDM.GetDatiCorrenti(P,Now);
    if C005FDatiAnagraficiDM.lstDatiCorrenti.Count > 0 then
    begin
      Memo1.Lines.Add('');
      Memo1.Lines.AddStrings(C005FDatiAnagraficiDM.lstDatiCorrenti);
    end;
  end;

  Height:=(Memo1.Lines.Count + 8) * Canvas.TextHeight('A');
  ShowModal;
end;

procedure TC005FDatiAnagrafici.FormDestroy(Sender: TObject);
begin
  FreeAndNil(C005FDatiAnagraficiDM);
end;

end.
