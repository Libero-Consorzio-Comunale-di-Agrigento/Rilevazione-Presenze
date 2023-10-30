unit WA073UControlloFM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, OracleData, Oracle,
  Dialogs, WR200UBaseFM, IWCompEdit, meIWEdit, IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl,
  IWControl, IWCompLabel, meIWLabel, IWCompJQueryWidget, IWVCLComponent, IWBaseLayoutComponent, IWApplication,
  IWBaseContainerLayout, IWContainerLayout, IWTemplateProcessorHTML, IWVCLBaseContainer, IWContainer,
  IWHTMLContainer, IWHTML40Container, IWRegion, IWCompExtCtrls, meIWImageFile, medpIWImageButton,
  A000UInterfaccia, IWCompGrids, IWDBGrids, meIWDBGrid, medpIWDBGrid, Menus,WR100UBase;

type
  TWA073FControlloFM = class(TWR200FBaseFM)
    lblDal: TmeIWLabel;
    dedtDaData: TmeIWEdit;
    lblAl: TmeIWLabel;
    dedtAData: TmeIWEdit;
    lblAcquistati: TmeIWLabel;
    lblMaturati: TmeIWLabel;
    lblBuoniAcq: TmeIWLabel;
    lblTicketAcq: TmeIWLabel;
    edtBuoniAcq: TmeIWEdit;
    edtTicketAcq: TmeIWEdit;
    lblBuoniMat: TmeIWLabel;
    lblTicketMat: TmeIWLabel;
    edtBuoniMat: TmeIWEdit;
    edtTicketMat: TmeIWEdit;
    lblAnomalie: TmeIWLabel;
    btnCalcola: TmedpIWImageButton;
    btmAnteprima: TmedpIWImageButton;
    grdAnteprima: TmedpIWDBGrid;
    pmnAzioni: TPopupMenu;
    actScaricaInExcelControllo: TMenuItem;
    actScaricaInCSVControllo: TMenuItem;
    procedure btnCalcolaClick(Sender: TObject);
    procedure btmAnteprimaClick(Sender: TObject);
    procedure grdAnteprimaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
    procedure actScaricaInExcelControlloClick(Sender: TObject);
    procedure actScaricaInCSVControlloClick(Sender: TObject);
  private
    Prog:LongInt;
  public
    procedure InizializzaDate;
  end;

implementation

uses WA073UAcquistoBuoni, WA073UAcquistoBuoniDM;

{$R *.dfm}

procedure TWA073FControlloFM.btmAnteprimaClick(Sender: TObject);
var TmpProg:Integer;
begin
  TmpProg:=TWA073FAcquistoBuoni(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger;
  with TWA073FAcquistoBuoniDM(TWA073FAcquistoBuoni(Self.Owner).WR302DM).A073MW do
  begin
    DataA:=StrToDate(DedtAData.Text);
    CreaBuoniPastoCDS;
    grdAnteprima.medpAttivaGrid(BuoniPasto,False,False);
    grdAnteprima.Visible:=True;
  end;
  TWA073FAcquistoBuoni(Self.Owner).grdC700.selAnagrafe.SearchRecord('Progressivo',TmpProg,[srFromBeginning]);
end;

procedure TWA073FControlloFM.btnCalcolaClick(Sender: TObject);
begin
  with TWA073FAcquistoBuoniDM(TWA073FAcquistoBuoni(Self.Owner).WR302DM).A073MW do
  begin
    try
      Inizio:=StrToDate(DedtDaData.Text);
      Fine:=StrToDate(DedtAData.Text);
    except
      raise Exception.Create('Il periodo indicato non è valido!');
    end;
    if Inizio > Fine then
    raise Exception.Create('Le date non sono in ordine cronologico!');
    Progressivo:=Prog;
    CalcolaRiepilogo;
    edtBuoniAcq.Text:=BuoniPastoAcquistati;
    edtTicketAcq.Text:=TicketAcquistati;
    edtBuoniMat.Text:=BuoniPastoMaturati;
    edtTicketMat.Text:=TicketMaturati;
    lblAnomalie.Visible:=Anomalie;
  end;
end;

procedure TWA073FControlloFM.InizializzaDate;
var A,M,G:Word;
D:TDateTime;
begin
  D:=Parametri.DataLavoro;
  Prog:=TWA073FAcquistoBuoni(Self.Owner).grdC700.selAnagrafe.FieldByName('Progressivo').AsInteger;
  with TWA073FAcquistoBuoni(Self.Owner).WBrowseFM.grdTabella do
    if medpDataSet.RecordCount > 0 then
     try
      D:=medpDataSet.FieldByName('DATA').AsDateTime;
     except
     end;
  DecodeDate(D,A,M,G);
  DedtDaData.Text:=FormatDateTime('dd/mm/yyyy',D);
  DedtAData.Text:=FormatDateTime('dd/mm/yyyy',Date);
end;

procedure TWA073FControlloFM.actScaricaInCSVControlloClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    TWA073FAcquistoBuoni(Self.Owner).csvDownload:=grdAnteprima.ToCsv
  else
    TWA073FAcquistoBuoni(Self.Owner).inviaFile('Estrazione.xls',TWA073FAcquistoBuoni(Self.Owner).csvDownload);
end;

procedure TWA073FControlloFM.actScaricaInExcelControlloClick(Sender: TObject);
begin
  if not Assigned(Sender) then
    TWA073FAcquistoBuoni(Self.Owner).streamDownload:=grdAnteprima.ToXlsx
  else
    TWA073FAcquistoBuoni(Self.Owner).inviaFile('Estrazione.xlsx',TWA073FAcquistoBuoni(Self.Owner).streamDownload);
end;

procedure TWA073FControlloFM.grdAnteprimaRenderCell(ACell: TIWGridCell; const ARow, AColumn: Integer);
var
  NumColonna: Integer;
begin
  if not TmedpIWDBGrid(ACell.Grid).medpRenderCell(ACell,ARow,AColumn,True,True) then
    Exit;
  NumColonna:=grdAnteprima.medpNumColonna(AColumn);
  // Assegnazione componenti alle celle
  if (ARow > 0) and (ARow <= High(grdAnteprima.medpCompGriglia) + 1) and (grdAnteprima.medpCompGriglia[ARow - 1].CompColonne[NumColonna] <> nil) then
  begin
    ACell.Text:='';
    ACell.Control:=grdAnteprima.medpCompGriglia[ARow - 1].CompColonne[NumColonna];
  end;
end;

end.
