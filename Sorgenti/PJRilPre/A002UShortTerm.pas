unit A002UShortTerm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Menus, C180FunzioniGenerali;

type
  TA002FShortTerm = class(TForm)
    pnlNominativo: TPanel;
    lblNominativo: TLabel;
    pnlPrevisioni: TPanel;
    dgrdPeriodi: TDBGrid;
    pmnEsporta: TPopupMenu;
    mnuCopiaExcel: TMenuItem;
    lblMessFineContrPrev: TLabel;
    lblFineContrPrev: TLabel;
    lblRegola35Prev: TLabel;
    lblPensionePrev: TLabel;
    lblShifPrev: TLabel;
    lblMessRegola35Prev: TLabel;
    lblMessPensionePrev: TLabel;
    lblMessShifPrev: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure mnuCopiaExcelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses A002UAnagrafeDtM1;

{$R *.dfm}

procedure TA002FShortTerm.FormCreate(Sender: TObject);
begin
  dgrdPeriodi.DataSource:=A002FAnagrafeDtM1.A002FAnagrafeMW.dsrShortTerm;
end;

procedure TA002FShortTerm.mnuCopiaExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdPeriodi, True, False);
end;

end.
