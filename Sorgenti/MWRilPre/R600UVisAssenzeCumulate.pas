unit R600UVisAssenzeCumulate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Variants, Menus, C180FunzioniGenerali;

type
  TColonneAssenzeRec = record
  const
    C0             = 0;
    Data           = 1;
    Causale        = 2;
    Tipo           = 3;
    Valenza        = 4;
    Ore            = 5;
    Valore         = 6;
    Coniuge        = 7;
    RichiestaWeb   = 8;
  end;

  TColonnePeriodiAssRec = record
  const
    Dal            = 1;
    Al             = 2;
    Causali        = 3;
    Coniuge        = 4;
  end;

  TR600FVisAssenzeCumulate = class(TForm)
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    StampaVideata1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Copiainexcel1: TMenuItem;
    procedure StampaVideata1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Copiainexcel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  R600FVisAssenzeCumulate: TR600FVisAssenzeCumulate;
  R600FVisPeriodiCumulati: TR600FVisAssenzeCumulate;

implementation

{$R *.DFM}

procedure TR600FVisAssenzeCumulate.Copiainexcel1Click(Sender: TObject);
begin
  R180StringGridCopyToClipboard(StringGrid1);
end;

procedure TR600FVisAssenzeCumulate.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount:=9;
  StringGrid1.ColWidths[TColonneAssenzeRec.C0]:=40;
  StringGrid1.ColWidths[TColonneAssenzeRec.Causale]:=55;
  StringGrid1.ColWidths[TColonneAssenzeRec.Tipo]:=30;
  StringGrid1.ColWidths[TColonneAssenzeRec.Valore]:=40;
  StringGrid1.ColWidths[TColonneAssenzeRec.Coniuge]:=45;
  StringGrid1.ColWidths[TColonneAssenzeRec.RichiestaWeb]:=74;
  StringGrid1.Cells[TColonneAssenzeRec.Data,0]:='Data';
  StringGrid1.Cells[TColonneAssenzeRec.Causale,0]:='Causale';
  StringGrid1.Cells[TColonneAssenzeRec.Tipo,0]:='Tipo';
  StringGrid1.Cells[TColonneAssenzeRec.Valenza,0]:='Valenza ass.';
  StringGrid1.Cells[TColonneAssenzeRec.Ore,0]:='Ore';
  StringGrid1.Cells[TColonneAssenzeRec.Valore,0]:='Valore';
  StringGrid1.Cells[TColonneAssenzeRec.Coniuge,0]:='Coniuge'; //Lorena 3/12/2002
  StringGrid1.Cells[TColonneAssenzeRec.RichiestaWeb,0]:='Richiesta web';
end;

procedure TR600FVisAssenzeCumulate.StampaVideata1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.Execute then
    Self.Print;
end;

end.
