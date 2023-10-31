unit A139UGestisciApparati;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, R001UGESTTAB, ActnList, ImgList, DB, Menus, ComCtrls, ToolWin, Grids,
  C015UElencoValori, DBGrids, DBCtrls, StdCtrls;

type
  TA139FGestisciApparati = class(TR001FGestTab)
    DBGridApparati: TDBGrid;
    GroupBox1: TGroupBox;
    chkServizio: TCheckBox;
    chkCampo1: TCheckBox;
    chkCampo2: TCheckBox;
    dcmbCampo1: TDBLookupComboBox;
    dcmbCampo2: TDBLookupComboBox;
    procedure DBGridApparatiEditButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridApparatiDblClick(Sender: TObject);
    procedure DBGridApparatiKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  A139FGestisciApparati: TA139FGestisciApparati;

implementation

uses A139UPianifServizi, A139UPianifServiziDtM;

{$R *.dfm}

procedure TA139FGestisciApparati.FormCreate(Sender: TObject);
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    chkCampo1.Caption:=selT500.FieldByName('C_CAMPO1').DisplayLabel;
    chkCampo2.Caption:=selT500.FieldByName('C_CAMPO2').DisplayLabel;
    selT555.Open;
    selT550.Close;
    if selT550.GetVariable('DATA') <> selT500.FieldByName('DATA').AsDateTime then
    begin
      selT550.SetVariable('DATA',selT500.FieldByName('DATA').AsDateTime);
      selT550.Close;
    end;
    selT550.Open;
    OpenT501;
    DButton.DataSet:=selT501;
  end;
  chkCampo1.Checked:=not A139FPianifServizi.btnServiziComandati.Down;
  chkCampo1.Enabled:=A139FPianifServizi.btnServiziComandati.Down;
  if chkCampo1.Checked then
    dcmbCampo1.KeyValue:=A139FPianifServiziDtM.selCampo1.FieldByName('CODICE').AsString;
end;

procedure TA139FGestisciApparati.DBGridApparatiDblClick(Sender: TObject);
begin
  inherited;
  if dbgridApparati.SelectedField = A139FPianifServiziDtm.selT501.FieldByName('DescApparato') then
    DBGridApparatiEditButtonClick(dbgridApparati);
end;

procedure TA139FGestisciApparati.DBGridApparatiEditButtonClick(Sender: TObject);
var Ret:Variant;
    S:String;
begin
  inherited;
  with A139FPianifServiziDtm do
  begin
    if (selT501.ReadOnly) or (selT501.FieldByName('TIPO').IsNull) then
      Exit;
    if DBGridApparati.SelectedField = selT501DESCAPPARATO then
    begin
      S:=selT550.SQL.Text;
      Insert(Format(' and T550.COD_APPARATO = ''%s'' ',[selT501.FieldByName('TIPO').AsString]),S,Pos('ORDER BY',UpperCase(S)));
      if chkServizio.Checked and (not selT500.FieldByName('SERVIZIO').IsNull) then
        Insert(Format(' and instr('',''||nvl(T550.FILTRO_SERVIZI,''%s'')||'','','',%s,'')>0 ',[selT500.FieldByName('SERVIZIO').AsString,selT500.FieldByName('SERVIZIO').AsString]),S,Pos('ORDER BY',UpperCase(S)));
      if chkCampo1.Checked and (VarToStr(dcmbCampo1.KeyValue) <> '') then
        Insert(Format(' and instr('',''||nvl(T550.FILTRO1,''%s'')||'','','',%s,'')>0 ',[VarToStr(dcmbCampo1.KeyValue),VarToStr(dcmbCampo1.KeyValue)]),S,Pos('ORDER BY',UpperCase(S)));
      if chkCampo2.Checked and (VarToStr(dcmbCampo2.KeyValue) <> '') then
        Insert(Format(' and instr('',''||nvl(T550.FILTRO2,''%s'')||'','','',%s,'')>0 ',[VarToStr(dcmbCampo2.KeyValue),VarToStr(dcmbCampo2.KeyValue)]),S,Pos('ORDER BY',UpperCase(S)));
      Ret:=VarArrayOf([selT501.FieldByName('CODICE').AsString]);
      OpenC015FElencoValori('T550_APPARATI','<A139> Elenco apparati',S,'CODICE',Ret,selT550);
      if (not VarIsNull(Ret[0])) and (VarToStr(Ret[0]) <> '') then
      begin
        if A139FPianifServiziDtm.selT501.State = dsBrowse then
          A139FPianifServiziDtm.selT501.Edit;
        A139FPianifServiziDtm.selT501.FieldByName('CODICE').AsString:=VarToStr(Ret[0]);
      end;
    end;
  end;
end;

procedure TA139FGestisciApparati.DBGridApparatiKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  with A139FPianifServiziDtm do
    if (DBGridApparati.SelectedField = selT501DescApparato) and (Key = 13) then
    begin
      selT501.Edit;
      DBGridApparatiEditButtonClick(nil);
    end;
end;

end.
