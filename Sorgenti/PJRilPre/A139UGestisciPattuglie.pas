unit A139UGestisciPattuglie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  DBGrids, C700USelezioneAnagrafe, C015UElencoValori, C180FunzioniGenerali;

type
  TA139FGestisciPattuglie = class(TR001FGestTab)
    DBGridPattuglia: TDBGrid;
    PopupMenu1: TPopupMenu;
    Copiariga1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure DBGridPattugliaEditButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Copiada1Click(Sender: TObject);
    procedure DBGridPattugliaDblClick(Sender: TObject);
    procedure DBGridPattugliaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A139FGestisciPattuglie: TA139FGestisciPattuglie;

implementation

uses A139UPianifServizi, A139UPianifServiziDtm;

{$R *.dfm}

procedure TA139FGestisciPattuglie.FormCreate(Sender: TObject);
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    DButton.DataSet:=A139FPianifServiziDtm.selT502_2;
    OpenTotAnag;
    OpenT502_2;
    DBGridPattuglia.Columns[R180GetColonnaDBGrid(DBGridPattuglia,'DescCampo1')].Title.Caption:=UpperCase(Copy(ParametriPianServiziRaggr1,0,1)) + LowerCase(Copy(ParametriPianServiziRaggr1,2,100));;
    DBGridPattuglia.Columns[R180GetColonnaDBGrid(DBGridPattuglia,'DescCampo2')].Title.Caption:=UpperCase(Copy(ParametriPianServiziRaggr2,0,1)) + LowerCase(Copy(ParametriPianServiziRaggr2,2,100));
    actCancella.Enabled:=(selT500.FieldByName('COMANDATO').AsString = 'N') or (A139FPianifServizi.btnServiziComandati.Down);
    actInserisci.Enabled:=(selT500.FieldByName('COMANDATO').AsString = 'N') or (A139FPianifServizi.btnServiziComandati.Down);
    actCopiaSu.Visible:=True;
  end;
end;

procedure TA139FGestisciPattuglie.Copiada1Click(Sender: TObject);
var S1,S2:String;
begin
  with A139FPianifServiziDtm.selT502_2 do
  begin
    S1:=FieldByName('CAMPO1').AsString;
    S2:=FieldByName('CAMPO2').AsString;
    Append;
    FieldByName('CAMPO1').AsString:=S1;
    FieldByName('CAMPO2').AsString:=S2;
    Post;
  end;
end;

procedure TA139FGestisciPattuglie.DBGridPattugliaDblClick(Sender: TObject);
begin
  inherited;
  if dbgridPattuglia.SelectedField = A139FPianifServiziDtm.selT502_2.FieldByName('Matricola') then
    DBGridPattugliaEditButtonClick(dbgridPattuglia);
end;

procedure TA139FGestisciPattuglie.DBGridPattugliaEditButtonClick(Sender: TObject);
var Ret:Variant;
begin
  inherited;
  with A139FPianifServiziDtm do
    if DBGridPattuglia.SelectedField = selT502_2Matricola then
    begin
      AggDati(selT502_2.FieldByName('DATA').AsDateTime,True);
      Ret:=VarArrayOf([selT502_2.FieldByName('PROGRESSIVO').AsInteger]);
      OpenC015FElencoValori('T502_PATTUGLIE','<A139> Elenco dipendenti',selAnag.SQL.Text,'PROGRESSIVO',Ret,selAnag);
      if (not selT502_2.FieldByName('PROGRESSIVO').ReadOnly) and (VarToStr(Ret[0]) <> '') then
      begin
        if selT502_2.State = dsBrowse then
          selT502_2.Edit;
        selT502_2.FieldByName('PROGRESSIVO').AsInteger:=Ret[0];
      end;
    end;
end;

procedure TA139FGestisciPattuglie.DBGridPattugliaKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    DBGridPattugliaEditButtonClick(nil);
end;

procedure TA139FGestisciPattuglie.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  with A139FPianifServiziDtm do
    if selT502_2.RecordCount = 0 then
    begin
      InsT502.SetVariable('PATTUGLIA',selT500.FieldByName('PATTUGLIA').AsInteger);
      InsT502.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
      InsT502.SetVariable('PROGRESSIVO',GeneraProg(selT500.FieldByName('DATA').AsDateTime));
      InsT502.Execute;
    end;
end;

end.
