unit A002ULoginDipendenti;

interface

uses
  A000USessione,
  C180FunzioniGenerali,
  R001UGESTTAB,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.ToolWin, ToolbarFiglio, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TA002FLoginDipendenti = class(TR001FGestTab)
    dgrdLoginDipendente: TDBGrid;
    PnlDettaglio: TPanel;
    dgrdProfili: TDBGrid;
    frmToolbarFiglio: TfrmToolbarFiglio;
    Splitter1: TSplitter;
    pmnLogin: TPopupMenu;
    mnuCopiaExcel: TMenuItem;
    pmnProfili: TPopupMenu;
    mnuCopiaExcel2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuCopiaExcelClick(Sender: TObject);
    procedure mnuCopiaExcel2Click(Sender: TObject);
    procedure frmToolbarFiglioactTFGenerica1Execute(Sender: TObject);
  public
    procedure Visualizza(const PProg: Integer; const PVisioneCorrente: Boolean);
  end;

var
  A002FLoginDipendenti: TA002FLoginDipendenti;

procedure OpenA002LoginDipendenti(const PProg: Integer; const PVisioneCorrente: Boolean);

implementation

uses
  A002UAnagrafeDtm1;

{$R *.dfm}

procedure OpenA002LoginDipendenti(const PProg: Integer; const PVisioneCorrente: Boolean);
begin
  SolaLetturaOriginale:=SolaLettura;
  SolaLettura:=True;
  A002FLoginDipendenti:=TA002FLoginDipendenti.Create(Application);
  try
    A002FLoginDipendenti.Visualizza(PProg,False);
    A002FLoginDipendenti.ShowModal;
  finally
    FreeAndNil(A002FLoginDipendenti);
    SolaLettura:=SolaLetturaOriginale;
  end;
end;

procedure TA002FLoginDipendenti.FormCreate(Sender: TObject);
begin
  inherited;

  // nasconde azioni non utilizzabili
  actInserisci.Visible:=False;
  actModifica.Visible:=False;
  actCancella.Visible:=False;
  actGomma.Visible:=False;
  actConferma.Visible:=False;
  actAnnulla.Visible:=False;
  actStampa.Visible:=False;

  // nasconde azioni non utilizzabili su toolbar figlio
  frmToolbarFiglio.actTFInserisci.Visible:=False;
  frmToolbarFiglio.actTFModifica.Visible:=False;
  frmToolbarFiglio.actTFCancella.Visible:=False;
  frmToolbarFiglio.actTFGomma.Visible:=False;
  frmToolbarFiglio.actTFConferma.Visible:=False;
  frmToolbarFiglio.actTFAnnulla.Visible:=False;
  frmToolbarFiglio.actTFGenerica2.Visible:=False;

  // inizializzazioni collegamenti tabelle - datasource
  DButton.DataSet:=A002FAnagrafeDtm1.A002FAnagrafeMW.selI060Prog;
  dgrdProfili.DataSource:=A002FAnagrafeDtm1.A002FAnagrafeMW.dsrI061;
end;

procedure TA002FLoginDipendenti.FormShow(Sender: TObject);
begin
  inherited;

  // imposta la toolbar di dettaglio
  frmToolbarFiglio.TFDButton:=A002FAnagrafeDtm1.A002FAnagrafeMW.dsrI061;
  frmToolbarFiglio.TFDBGrid:=dgrdProfili;
  frmToolbarFiglio.tlbarFiglio.HandleNeeded;
  SetLength(frmToolbarFiglio.lstLock,4);
  frmToolbarFiglio.lstLock[0]:=Panel1;
  frmToolbarFiglio.lstLock[1]:=File1;
  frmToolbarFiglio.lstLock[2]:=Strumenti1;
  //frmToolbarFiglio.lstLock[3]:=frmSelAnagrafe;
  frmToolbarFiglio.AbilitaAzioniTF(nil);
end;

procedure TA002FLoginDipendenti.mnuCopiaExcelClick(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdLoginDipendente,True,False,True);
end;

procedure TA002FLoginDipendenti.mnuCopiaExcel2Click(Sender: TObject);
begin
  R180DBGridCopyToClipboard(dgrdProfili,True,False,True);
end;

procedure TA002FLoginDipendenti.Visualizza(const PProg: Integer; const PVisioneCorrente: Boolean);
// apre i dataset per la visualizzazione di utenti e profili
begin
  Screen.Cursor:=crHourGlass;
  try
    A002FAnagrafeDtM1.A002FAnagrafeMW.ApriDatasetLoginProfili(PProg);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TA002FLoginDipendenti.frmToolbarFiglioactTFGenerica1Execute(Sender: TObject);
// attiva / disattiva visione corrente profili
var
  LVisCorrente: Boolean;
begin
  Screen.Cursor:=crHourGlass;
  LVisCorrente:=frmToolbarFiglio.btnTFGenerico1.Down;
  try
    A002FAnagrafeDtM1.A002FAnagrafeMW.SetVisioneCorrenteProfili(LVisCorrente);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

end.
